require 'spec_helper'
require 'ronin/payloads/powershell_payload'

describe Ronin::Payloads::PowerShellPayload do
  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::PowerShellEncoder)
    end
  end
end
