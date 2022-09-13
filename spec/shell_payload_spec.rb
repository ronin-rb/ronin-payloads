require 'spec_helper'
require 'ronin/payloads/shell_payload'

describe Ronin::Payloads::ShellPayload do
  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::ShellEncoder)
    end
  end
end
