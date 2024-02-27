require 'spec_helper'
require 'ronin/payloads/nashorn_payload'

describe Ronin::Payloads::NashornPayload do
  it "must inherit from Ronin::Payloads::JavaScriptPayload" do
    expect(described_class).to be < Ronin::Payloads::JavaScriptPayload
  end

  describe ".payload_type" do
    subject { described_class }

    it "must return :nashorn" do
      expect(subject.payload_type).to eq(:nashorn)
    end
  end
end
