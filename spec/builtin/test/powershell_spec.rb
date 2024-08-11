require 'spec_helper'
require 'ronin/payloads/builtin/test/powershell'

describe Ronin::Payloads::Test::PowerShell do
  it "must inherit from Ronin::Payloads::PowerShellPayload" do
    expect(described_class).to be < Ronin::Payloads::PowerShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/powershell'" do
      expect(subject.id).to eq('test/powershell')
    end
  end

  describe "#build" do
    context "when the powershell param is not set" do
      before { subject.build }

      it "must set #payload to `Write-Output \"PWNED\";`" do
        expect(subject.payload).to eq(%{Write-Output "PWNED";})
      end
    end

    context "when the powershell param is set" do
      let(:powershell) { %{Write-Output "lol";} }

      before do
        subject.params[:powershell] = powershell
        subject.build
      end

      it "must set #payload to the powershell param" do
        expect(subject.payload).to eq(powershell)
      end
    end
  end
end
