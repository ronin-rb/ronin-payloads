require 'spec_helper'
require 'ronin/payloads/mixins/post_ex'

require 'ronin/payloads/payload'
require 'ronin/post_ex/sessions/session'

describe Ronin::Payloads::Mixins::PostEx do
  module TestPostExMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::PostEx
    end
  end

  let(:payload_class) { TestPostExMixin::TestPayload }
  subject { payload_class.new }

  let(:session) { Ronin::PostEx::Sessions::Session.new }

  describe "#session=" do
    before { subject.session = session }

    it "must set #session" do
      expect(subject.session).to be(session)
    end
  end

  describe "#perform_cleanup" do
    context "when #session is set" do
      before { subject.session = session }

      it "must call #session.close" do
        expect(session).to receive(:close)

        subject.perform_cleanup
      end
    end
  end
end
