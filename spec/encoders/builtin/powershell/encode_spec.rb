require 'spec_helper'
require 'ronin/payloads/encoders/builtin/powershell/encode'

describe Ronin::Payloads::Encoders::PowerShell::Encode do
  it "must inherit from Ronin::Payloads::Encoders::PowerShellEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::PowerShellEncoder
  end

  describe "#encode" do
    let(:data)    { "hello world" }
    let(:encoded) { "$([char]0x68)$([char]0x65)$([char]0x6c)$([char]0x6c)$([char]0x6f)$([char]0x20)$([char]0x77)$([char]0x6f)$([char]0x72)$([char]0x6c)$([char]0x64)" }

    it "must PowerShell encode each character" do
      expect(subject.encode(data)).to eq(encoded)
    end
  end
end
