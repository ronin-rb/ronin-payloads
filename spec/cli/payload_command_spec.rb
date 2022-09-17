require 'spec_helper'
require 'ronin/payloads/cli/payload_command'
require 'ronin/payloads/payload'

describe Ronin::Payloads::CLI::PayloadCommand do
  module TestPayloadCommand
    class TestPayload < Ronin::Payloads::Payload
      register 'test_payload_command'
    end

    class TestCommand < Ronin::Payloads::CLI::PayloadCommand
    end
  end

  let(:payload_class) { TestPayloadCommand::TestPayload }
  let(:command_class) { TestPayloadCommand::TestCommand }
  subject { command_class.new }

  describe "#load_payload" do
    let(:id) { payload_class.id }

    it "must load the payload class and return the payload class" do
      expect(subject.load_payload(id)).to be(payload_class)
    end

    it "must also set #payload_class" do
      subject.load_payload(id)

      expect(subject.payload_class).to be(payload_class)
    end
  end

  describe "#initialize_payload" do
    before { subject.load_payload(payload_class.id) }

    it "must initialize a new payload object using #payload_class" do
      expect(subject.initialize_payload).to be_kind_of(payload_class)
    end

    it "must also set #payload" do
      subject.initialize_payload

      expect(subject.payload).to be_kind_of(payload_class)
    end
  end
end
