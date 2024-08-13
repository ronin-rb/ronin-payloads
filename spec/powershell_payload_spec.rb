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
end
