require 'spec_helper'
require 'ronin/payloads/powershell_payload'

describe Ronin::Payloads::PowerShellPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::WindowsCommandPayload)
  end

  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::PowerShellEncoder)
    end
  end

  module TestPowerShellPayload
    class TestPayload < Ronin::Payloads::PowerShellPayload

      def build
        @payload = "Write-Output 'PWNED'"
      end

    end
  end

  let(:payload_class) { TestPowerShellPayload::TestPayload }
  subject { payload_class.new }

  describe "#to_command" do
    it "must escape the built payload as a quoted shell string and embed it within a 'pwsh -Command \"...\"' command" do
      expect(subject.to_command).to eq(%{pwsh -Command "Write-Output 'PWNED'"})
    end
  end
end
