require 'spec_helper'
require 'ronin/payloads/encoders/builtin/shell/base64_encode'

describe Ronin::Payloads::Encoders::Shell::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::ShellCommandEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::ShellCommandEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shell/base64_encode'" do
      expect(subject.id).to eq('shell/base64_encode')
    end
  end

  describe "#encode" do
    let(:command) { "echo PWNED" }
    let(:encoded) { "echo ZWNobyBQV05FRA==|base64 -d|bash" }

    it "must encode the given command String as Base64 and embed it into the `echo ...|base64 -d|bash` command" do
      expect(subject.encode(command)).to eq(encoded)
    end

    context "when the shell param is set" do
      let(:shell)   { 'zsh' }
      let(:encoded) { "echo ZWNobyBQV05FRA==|base64 -d|#{shell}" }

      subject do
        described_class.new(params: {shell: shell})
      end

      it "must use the shell param in the command" do
        expect(subject.encode(command)).to eq(encoded)
      end
    end

    it "must return a valid shell command", :integration do
      expect(`#{subject.encode(command)}`).to eq("PWNED#{$/}")
    end
  end
end
