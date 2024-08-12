require 'spec_helper'
require 'ronin/payloads/encoders/node_js_encoder'

describe Ronin::Payloads::Encoders::NodeJSEncoder do
  it "must inherit from Ronin::Payloads::Encoders::Encoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::Encoder
  end

  describe ".encoder_type" do
    subject { described_class }

    it "must return :node_js" do
      expect(subject.encoder_type).to eq(:node_js)
    end
  end
end
