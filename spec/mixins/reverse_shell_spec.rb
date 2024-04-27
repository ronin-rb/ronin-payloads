require 'spec_helper'
require 'ronin/payloads/mixins/reverse_shell'
require 'ronin/payloads/payload'

describe Ronin::Payloads::Mixins::ReverseShell do
  module TestReverseShellMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::ReverseShell
    end
  end

  let(:payload_class) { TestReverseShellMixin::TestPayload }

  describe ".included" do
    subject { payload_class }

    it "must add a required 'host' param" do
      expect(subject.params[:host]).to_not be_nil
      expect(subject.params[:host].type).to be_kind_of(Ronin::Core::Params::Types::String)
      expect(subject.params[:host].required?).to be(true)
      expect(subject.params[:host].default).to eq('0.0.0.0')
      expect(subject.params[:host].desc).to eq('The host to connect back to')
    end

    it "must add a required 'port' param" do
      expect(subject.params[:port]).to_not be_nil
      expect(subject.params[:port].type).to be_kind_of(Ronin::Core::Params::Types::Integer)
      expect(subject.params[:port].required?).to be(true)
      expect(subject.params[:port].default).to eq(4444)
      expect(subject.params[:port].desc).to eq('The port to connect back to')
    end
  end

  let(:host) { '127.0.0.1' }
  let(:port) { 1337 }

  subject do
    payload_class.new(params: {host: host, port: port})
  end

  describe "#host" do
    it "must return the 'host' param value" do
      expect(subject.host).to eq(host)
    end

    context "when no 'host' param value is given" do
      subject { payload_class.new }

      it "must default to '0.0.0.0'" do
        expect(subject.host).to eq('0.0.0.0')
      end
    end
  end

  describe "#port" do
    it "must return the 'port' param value" do
      expect(subject.port).to eq(port)
    end

    context "when no 'port' param value is given" do
      subject { payload_class.new }

      it "must default to 4444" do
        expect(subject.port).to eq(4444)
      end
    end
  end

  describe "#perform_prelaunch" do
    let(:server_socket) { double('TCPServer') }

    it "must create a new TCPServer that listens on #host and #port and set @server" do
      expect(TCPServer).to receive(:new).with(host,port).and_return(server_socket)
      expect(server_socket).to receive(:listen).with(1)

      subject.perform_prelaunch

      expect(subject.instance_variable_get(:@server)).to be(server_socket)
    end
  end

  describe "#perform_postlaunch" do
    let(:server_socket) { double('TCPServer') }
    let(:client_socket) { double('TCPSocket') }

    let(:client_ip)   { '1.2.3.4' }
    let(:client_port) { 8888 }
    let(:client_addrinfo)    { Addrinfo.tcp(client_ip,client_port) }

    before do
      allow(client_socket).to receive(:remote_address).and_return(client_addrinfo)
    end

    before { subject.instance_variable_set(:@server,server_socket) }

    it "must print a message about waiting for a connection on host:port, accept a connection, create a new Ronin::PostEx::Sessions::ReverseShell with the new connection, set @session, and print a message about a new connection on host:port" do
      expect(subject).to receive(:print_info).with("Waiting for connection on #{host}:#{port} ...")
      expect(server_socket).to receive(:accept).and_return(client_socket)
      expect(subject).to receive(:print_info).with("Accepted connection from #{client_ip}:#{client_port}!")

      subject.perform_postlaunch

      expect(subject.session).to be_kind_of(Ronin::PostEx::Sessions::ReverseShell)
      expect(subject.session.io).to be(client_socket)
    end
  end

  describe "#perform_cleanup" do
    let(:server_socket) { double('TCPServer') }

    before { subject.instance_variable_set(:@server,server_socket) }

    it "must call @server.close and set @server to nil" do
      expect(server_socket).to receive(:close)

      subject.perform_cleanup

      expect(subject.instance_variable_get(:@server)).to be(nil)
    end
  end
end
