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

  describe ".included" do
    subject { payload_class }

    it "must add a required 'host' param" do
      expect(subject.params[:host]).to_not be_nil
      expect(subject.params[:host].type).to be_kind_of(Ronin::Core::Params::Types::String)
      expect(subject.params[:host].required?).to be(true)
      expect(subject.params[:host].desc).to eq('The host interface to listen on')
    end

    it "must add a required 'port' param" do
      expect(subject.params[:port]).to_not be_nil
      expect(subject.params[:port].type).to be_kind_of(Ronin::Core::Params::Types::Integer)
      expect(subject.params[:port].required?).to be(true)
      expect(subject.params[:port].desc).to eq('The port to listen on')
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
  end

  describe "#port" do
    it "must return the 'port' param value" do
      expect(subject.port).to eq(port)
    end
  end
end