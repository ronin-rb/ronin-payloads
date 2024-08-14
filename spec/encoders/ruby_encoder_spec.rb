require 'spec_helper'
require 'ronin/payloads/encoders/ruby_encoder'

describe Ronin::Payloads::Encoders::RubyEncoder do
  it "must inherit from Ronin::Payloads::Encoders::Encoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::Encoder
  end

  describe ".encoder_type" do
    subject { described_class }

    it "must return :ruby" do
      expect(subject.encoder_type).to eq(:ruby)
    end
  end
end
