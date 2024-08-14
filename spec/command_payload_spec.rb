require 'spec_helper'
require 'ronin/payloads/command_payload'

describe Ronin::Payloads::CommandPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  it "must include Ronin::Payloads::Metadata::OS" do
    expect(described_class).to include(Ronin::Payloads::Metadata::OS)
  end

  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::CommandEncoder)
    end
  end

  module TestCommandPayload
    class TestPayload < Ronin::Payloads::CommandPayload

      def build
        @payload = "ls -la"
      end

    end
  end

  let(:payload_class) { TestCommandPayload::TestPayload }
  subject { payload_class.new }

  describe "#to_ruby" do
    it "must convert the built command into a Ruby string that is passed to 'system(...)'" do
      expect(subject.to_ruby).to eq("system(\"#{subject}\")")
    end
  end
end
