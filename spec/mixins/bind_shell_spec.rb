require 'spec_helper'
require 'ronin/payloads/mixins/bind_shell'
require 'ronin/payloads/payload'

describe Ronin::Payloads::Mixins::BindShell do
  module TestBindShellMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::BindShell
    end
  end

  let(:payload_class) { TestBindShellMixin::TestPayload }

  it "must also include Ronin::Payloads::Mixins::PostEx" do
    expect(payload_class).to include(Ronin::Payloads::Mixins::PostEx)
  end

  describe ".included" do
    subject { payload_class }

    it "must add a required 'host' param" do
      expect(subject.params[:host]).to_not be_nil
      expect(subject.params[:host].type).to be_kind_of(Ronin::Core::Params::Types::String)
      expect(subject.params[:host].required?).to be(true)
      expect(subject.params[:host].desc).to eq('The host to connect to')
    end

    it "must add a required 'port' param" do
      expect(subject.params[:port]).to_not be_nil
      expect(subject.params[:port].type).to be_kind_of(Ronin::Core::Params::Types::Integer)
      expect(subject.params[:port].required?).to be(true)
      expect(subject.params[:port].desc).to eq('The port to listen on')
    end
  end

  let(:host) { 'example.com' }
  let(:port) { 1337 }

  subject do
    payload_class.new(params: {host: host, port: port})
  end

  describe "#host" do
    it "must return the 'host' param value" do
      expect(subject.host).to eq(host)
    end
  end

  describe "#port" do
    it "must return the 'port' param value" do
      expect(subject.port).to eq(port)
    end
  end

  describe "#perform_postlaunch" do
    let(:addrinfo) { Addrinfo.tcp(host,port) }
    let(:socket)   { double('TCPSocket') }

    before { allow(socket).to receive(:remote_address).and_return(addrinfo) }

    let(:session) { Ronin::PostEx::Sessions::BindShell.new(socket) }

    it "must print a message about connecting to host:port, create a new Ronin::PostEx::Sesssions::BindShell session, set #session, then print a message about being connected to host:port" do
      expect(subject).to receive(:print_info).with("Connecting to #{host}:#{port} ...")
      expect(Ronin::PostEx::Sessions::BindShell).to receive(:connect).with(host,port).and_return(session)
      expect(subject).to receive(:print_info).with("Connected to #{host}:#{port}!")

      subject.perform_postlaunch

      expect(subject.session).to be(session)
    end
  end
end
