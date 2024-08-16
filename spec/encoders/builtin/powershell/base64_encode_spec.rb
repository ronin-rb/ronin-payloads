require 'spec_helper'
require 'ronin/payloads/encoders/builtin/powershell/base64_encode'

describe Ronin::Payloads::Encoders::PowerShell::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::PowerShellEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::PowerShellEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'powershell/base64_encode'" do
      expect(subject.id).to eq('powershell/base64_encode')
    end
  end

  describe "#encode" do
    let(:powershell)  { "Write-Output 'PWNED'" }
    let(:encoded)     { %{Invoke-Expression([System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String("V3JpdGUtT3V0cHV0ICdQV05FRCc=")))} }

    it "must encode the given PowerShell code as a Base64 string and embed it into the 'Invoke-Expression([System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String(\"...\")))' string" do
      expect(subject.encode(powershell)).to eq(encoded)
    end

    it "must return valid PowerShell code", :integration do
      expect(`pwsh -C '#{subject.encode(powershell)}'`).to eq("PWNED#{$/}")
    end
  end
end
