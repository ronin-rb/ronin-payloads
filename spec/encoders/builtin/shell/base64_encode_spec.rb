require 'spec_helper'
require 'ronin/payloads/encoders/builtin/shell/base64_encode'

describe Ronin::Payloads::Encoders::Shell::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::ShellEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::ShellEncoder
  end

  describe "#encode" do
    let(:command) { "ls -la" }
    let(:encoded) { "echo bHMgLWxh|base64 -d|bash" }

    it "must encode the given command String as Base64 and embed it into the `echo ...|base64 -d|bash` command" do
      expect(subject.encode(command)).to eq(encoded)
    end

    context "when the shell param is set" do
      let(:shell)   { 'zsh' }
      let(:encoded) { "echo bHMgLWxh|base64 -d|#{shell}" }

      subject do
        described_class.new(params: {shell: shell})
      end

      it "must use the shell param in the command" do
        expect(subject.encode(command)).to eq(encoded)
      end
    end
  end
end
