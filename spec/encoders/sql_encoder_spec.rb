require 'spec_helper'
require 'ronin/payloads/encoders/sql_encoder'

describe Ronin::Payloads::Encoders::SQLEncoder do
  it "must inherit from Ronin::Payloads::Encoders::Encoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::Encoder
  end
end
