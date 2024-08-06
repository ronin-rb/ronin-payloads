require 'spec_helper'
require 'ronin/payloads/encoders/html_encoder'

describe Ronin::Payloads::Encoders::HTMLEncoder do
  it "must inherit from Ronin::Payloads::Encoders::Encoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::Encoder
  end

  describe ".encoder_type" do
    subject { described_class }

    it "must return :html" do
      expect(subject.encoder_type).to eq(:html)
    end
  end
end
