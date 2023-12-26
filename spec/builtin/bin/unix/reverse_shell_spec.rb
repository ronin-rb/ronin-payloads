require 'spec_helper'
require 'ronin/payloads/builtin/bin/unix/reverse_shell'

describe Ronin::Payloads::Bin::UNIX::ReverseShell do
  it "must inherit from Ronin::Payloads::Shellcode::CPayload" do
    expect(described_class).to be < Ronin::Payloads::CPayload
  end

  it "must include Ronin::Payloads::Mixins::ReverseShell" do
    expect(described_class).to include(Ronin::Payloads::Mixins::ReverseShell)
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'bin/unix/reverse_shell'" do
      expect(subject.id).to eq('bin/unix/reverse_shell')
    end
  end

  describe ".os" do
    subject { described_class }

    it "must equal :unix" do
      expect(subject.os).to be(:unix)
    end
  end

  describe ".params" do
    subject { described_class }

    it "must add an os param that excludes :windows" do
      expect(subject.params[:os]).to_not be_nil
      expect(subject.params[:os].type).to be_kind_of(
        Ronin::Core::Params::Types::Enum
      )
      expect(subject.params[:os].type.values).to_not include(:windows)
    end
  end

  describe "SOURCE_FILE" do
    subject { described_class }

    it "must be a file" do
      expect(File.file?(subject::SOURCE_FILE)).to be(true)
    end
  end

  let(:host) { '127.0.0.1' }
  let(:port) { 1337 }

  subject do
    described_class.new(
      params: {
        host: host,
        port: port
      }
    )
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to start_with(
        "\x7fELF\x02\x01\x01\x00".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
