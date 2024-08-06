require 'spec_helper'
require 'ronin/payloads/encoders/powershell_encoder'

describe Ronin::Payloads::Encoders::PowerShellEncoder do
  it "must inherit from Ronin::Payloads::Encoders::Encoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::Encoder
  end

  describe ".encoder_type" do
    subject { described_class }

    it "must return :powershell" do
      expect(subject.encoder_type).to eq(:powershell)
    end
  end
end
