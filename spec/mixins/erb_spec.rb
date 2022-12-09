require 'spec_helper'
require 'ronin/payloads/mixins/erb'

require 'ronin/payloads/payload'

describe Ronin::Payloads::Mixins::ERB do
  module TestErbMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::ERB
    end
  end

  let(:payload_class) { TestErbMixin::TestPayload }
  subject { payload_class.new }

  it "must include Ronin::Support::Text::ERB::Mixin" do
    expect(payload_class).to include(Ronin::Support::Text::ERB::Mixin)
  end
end
