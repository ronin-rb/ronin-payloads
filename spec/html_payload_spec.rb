require 'spec_helper'
require 'ronin/payloads/html_payload'

describe Ronin::Payloads::HTMLPayload do
  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::HTMLEncoder)
    end
  end
end
