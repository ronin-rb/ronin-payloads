require 'spec_helper'
require 'ronin/payloads/shell_command_payload'

describe Ronin::Payloads::ShellCommandPayload do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::CommandPayload)
  end

  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::ShellCommandEncoder)
    end
  end

  describe ".os" do
    subject { described_class }

    it do
      expect(subject.os).to eq(:unix)
    end
  end
end
