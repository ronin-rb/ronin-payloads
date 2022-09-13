require 'spec_helper'
require 'ronin/payloads/javascript_payload'

describe Ronin::Payloads::JavaScriptPayload do
  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::JavaScriptEncoder)
    end
  end
end
