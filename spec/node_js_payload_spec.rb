require 'spec_helper'
require 'ronin/payloads/node_js_payload'

describe Ronin::Payloads::NodeJSPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  describe "encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::NodeJSEncoder)
    end
  end

  module TestNodeJSPayload
    class TestPayload < Ronin::Payloads::NodeJSPayload

      def build
        @payload = "console.log('PWNED')"
      end

    end
  end

  let(:payload_class) { TestNodeJSPayload::TestPayload }
  subject { payload_class.new }

  describe "#to_command" do
    it "must escape the built payload as a quoted shell string and embed it within a 'node -e \"...\"' command" do
      expect(subject.to_command).to eq(%{node -e "console.log('PWNED')"})
    end
  end
end
