require 'spec_helper'
require 'ronin/payloads/php_payload'

describe Ronin::Payloads::PHPPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  module TestPHPPayload
    class TestPayload < Ronin::Payloads::PHPPayload

      def build
        @payload = "echo 'PWNED';"
      end

    end
  end

  let(:payload_class) { TestPHPPayload::TestPayload }
  subject { payload_class.new }

  describe "#to_command" do
    it "must escape the built payload as a quoted shell string and embed it within a 'php -r \"...\"' command" do
      expect(subject.to_command).to eq(%{php -r "echo 'PWNED';"})
    end
  end
end
