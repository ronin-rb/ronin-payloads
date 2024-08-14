require 'spec_helper'
require 'ronin/payloads/shell_payload'

describe Ronin::Payloads::ShellPayload do
  it "must be an alias for Ronin::Payloads::ShellCommandPayload" do
    expect(described_class).to be(Ronin::Payloads::ShellCommandPayload)
  end
end
