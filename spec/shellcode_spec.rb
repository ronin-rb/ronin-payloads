require 'spec_helper'
require 'ronin/payloads/shellcode'

describe Ronin::Payloads::Shellcode do
  it "must inherit from Ronin::Payloads::ASMPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::ASMPayload)
  end
end
