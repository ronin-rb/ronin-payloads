require 'spec_helper'
require 'ronin/payloads/encoders/builtin/powershell/hex_encode'

describe Ronin::Payloads::Encoders::PowerShell::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::PowerShellEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::PowerShellEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'powershell/hex_encode'" do
      expect(subject.id).to eq('powershell/hex_encode')
    end
  end

  describe "#encode" do
    let(:powershell) { "Write-Output 'PWNED'" }
    let(:encoded) do
      %{Invoke-Expression "$([char]0x57)$([char]0x72)$([char]0x69)$([char]0x74)$([char]0x65)$([char]0x2d)$([char]0x4f)$([char]0x75)$([char]0x74)$([char]0x70)$([char]0x75)$([char]0x74)$([char]0x20)$([char]0x27)$([char]0x50)$([char]0x57)$([char]0x4e)$([char]0x45)$([char]0x44)$([char]0x27)"}
    end

    it "must each character of the command as PowerShell '$([char]0xXX)' characters and evaluate the resulting string using 'Invoke-Expression'" do
      expect(subject.encode(powershell)).to eq(encoded)
    end

    it "must return valid PowerShell code", :integration do
      expect(`pwsh -C '#{subject.encode(powershell)}'`).to eq("PWNED#{$/}")
    end
  end
end
