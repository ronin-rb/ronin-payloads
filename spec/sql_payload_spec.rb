require 'spec_helper'
require 'ronin/payloads/sql_payload'

describe Ronin::Payloads::SQLPayload do
  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::SQLEncoder)
    end
  end
end
