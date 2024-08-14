require 'spec_helper'
require 'ronin/payloads/python_payload'

describe Ronin::Payloads::PythonPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  describe "encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::PythonEncoder)
    end
  end

  module TestPythonPayload
    class TestPayload < Ronin::Payloads::PythonPayload

      def build
        @payload = "print('PWNED')"
      end

    end
  end

  let(:payload_class) { TestPythonPayload::TestPayload }
  subject { payload_class.new }

  describe "#to_command" do
    it "must escape the built payload as a quoted shell string and embed it within a 'python -c \"...\"' command" do
      expect(subject.to_command).to eq(%{python -c "print('PWNED')"})
    end
  end
end
