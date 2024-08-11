require 'spec_helper'
require 'ronin/payloads/encoders/command_encoder'

describe Ronin::Payloads::Encoders::CommandEncoder do
  it "must inherit from Ronin::Payloads::Encoders::Encoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::Encoder
  end

  describe ".encoder_type" do
    subject { described_class }

    it "must return :command" do
      expect(subject.encoder_type).to eq(:command)
    end
  end
end
