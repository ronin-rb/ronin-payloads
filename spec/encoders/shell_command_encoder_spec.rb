require 'spec_helper'
require 'ronin/payloads/encoders/shell_command_encoder'

describe Ronin::Payloads::Encoders::ShellCommandEncoder do
  it "must inherit from Ronin::Payloads::Encoders::CommandEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::CommandEncoder
  end

  describe ".encoder_type" do
    subject { described_class }

    it "must return :shell_command" do
      expect(subject.encoder_type).to eq(:shell_command)
    end
  end
end
