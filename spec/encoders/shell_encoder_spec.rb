require 'spec_helper'
require 'ronin/payloads/encoders/shell_encoder'

describe Ronin::Payloads::Encoders::ShellEncoder do
  it "must inherit from Ronin::Payloads::Encoders::Encoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::Encoder
  end
end
