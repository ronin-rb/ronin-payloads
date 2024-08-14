require 'spec_helper'
require 'ronin/payloads/ruby_payload'

describe Ronin::Payloads::RubyPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  describe "encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::RubyEncoder)
    end
  end

  module TestRubyPayload
    class TestPayload < Ronin::Payloads::RubyPayload

      def build
        @payload = "puts 'PWNED'"
      end

    end
  end

  let(:payload_class) { TestRubyPayload::TestPayload }
  subject { payload_class.new }

  describe "#to_command" do
    it "must escape the built payload as a quoted shell string and embed it within a 'ruby -e \"...\"' command" do
      expect(subject.to_command).to eq(%{ruby -e "puts 'PWNED'"})
    end
  end
end
