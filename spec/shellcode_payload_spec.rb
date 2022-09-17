require 'spec_helper'
require 'ronin/payloads/shellcode_payload'

describe Ronin::Payloads::ShellcodePayload do
  it "must inherit from Ronin::Payloads::ASMPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::ASMPayload)
  end
end
