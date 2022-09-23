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
  subject { payload_class.new }

  describe ".included" do
    subject { payload_class }

    it "must add a required 'host' param" do
      expect(subject.params[:host]).to_not be_nil
      expect(subject.params[:host].type).to be_kind_of(Ronin::Core::Params::Types::String)
      expect(subject.params[:host].required?).to be(true)
      expect(subject.params[:host].desc).to eq('The host to connect back to')
    end

    it "must add a required 'port' param" do
      expect(subject.params[:port]).to_not be_nil
      expect(subject.params[:port].type).to be_kind_of(Ronin::Core::Params::Types::Integer)
      expect(subject.params[:port].required?).to be(true)
      expect(subject.params[:port].desc).to eq('The port to connect back to')
    end
  end
end
