require 'spec_helper'
require 'ronin/payloads/encoders/shell_encoder'

describe Ronin::Payloads::Encoders::ShellEncoder do
  it "must be an alias to Ronin::Payloads::Encoders::ShellCommandEncoder" do
    expect(described_class).to be(Ronin::Payloads::Encoders::ShellCommandEncoder)
  end
end
