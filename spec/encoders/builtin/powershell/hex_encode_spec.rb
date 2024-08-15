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
    let(:data)    { "dir" }
    let(:encoded) do
      %{Invoke-Expression "$([char]0x64)$([char]0x69)$([char]0x72)"}
    end

    it "must each character of the command as PowerShell '$([char]0xXX)' characters and evaluate the resulting string using 'Invoke-Expression'" do
      expect(subject.encode(data)).to eq(encoded)
    end
  end
end
