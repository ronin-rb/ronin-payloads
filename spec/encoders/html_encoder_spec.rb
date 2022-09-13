require 'spec_helper'
require 'ronin/payloads/encoders/html_encoder'

describe Ronin::Payloads::Encoders::HTMLEncoder do
  it "must inherit from Ronin::Payloads::Encoders::Encoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::Encoder
  end
end
