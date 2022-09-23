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
  subject { payload_class.new }

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
end
