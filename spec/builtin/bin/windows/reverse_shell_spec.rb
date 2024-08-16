require 'spec_helper'
require 'ronin/payloads/builtin/bin/windows/reverse_shell'

describe Ronin::Payloads::Bin::Windows::ReverseShell do
  it "must inherit from Ronin::Payloads::Shellcode::CPayload" do
    expect(described_class).to be < Ronin::Payloads::CPayload
  end

  it "must include Ronin::Payloads::Mixins::ReverseShell" do
    expect(described_class).to include(Ronin::Payloads::Mixins::ReverseShell)
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'bin/windows/reverse_shell'" do
      expect(subject.id).to eq('bin/windows/reverse_shell')
    end
  end

  describe ".os" do
    subject { described_class }

    it "must equal :windows" do
      expect(subject.os).to be(:windows)
    end
  end

  describe ".params" do
    subject { described_class }

    it "must add an arch param with :x86-64 and :i686" do
      expect(subject.params[:arch]).to_not be_nil
      expect(subject.params[:arch].type).to be_kind_of(
        Ronin::Core::Params::Types::Enum
      )
      expect(subject.params[:arch].type.values).to eq([:"x86-64", :i686])
    end

    it "must add an os param that defaults to :windows" do
      expect(subject.params[:os]).to_not be_nil
      expect(subject.params[:os].type).to be_kind_of(
        Ronin::Core::Params::Types::Enum
      )
      expect(subject.params[:os].type.values).to eq([:windows])
      expect(subject.params[:os].default).to be(:windows)
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

  describe "#build", :integration do
    before { subject.build }

    it "must set #payload" do
      expect(subject.payload).to include(
        "This program cannot be run in DOS mode".b
      )
    end

    it "must ensure #payload is an ASCII 8bit string" do
      expect(subject.payload.encoding).to eq(Encoding::ASCII_8BIT)
    end
  end
end
