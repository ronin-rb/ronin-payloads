require 'spec_helper'
require 'ronin/payloads/encoders/shell_encoder'

describe Ronin::Payloads::Encoders::ShellEncoder do
  it "must inherit from Ronin::Payloads::Encoders::Encoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::Encoder
  end

  describe ".encoder_type" do
    subject { described_class }

    it "must return :shell" do
      expect(subject.encoder_type).to eq(:shell)
    end
  end
end
