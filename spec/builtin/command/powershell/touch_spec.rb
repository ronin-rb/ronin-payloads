require 'spec_helper'
require 'ronin/payloads/builtin/command/powershell/touch'

describe Ronin::Payloads::Command::PowerShell::Touch do
  it "must inherit from Ronin::Payloads::PowerShellPayload" do
    expect(described_class).to be < Ronin::Payloads::PowerShellPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/powershell/touch'" do
      expect(subject.id).to eq('command/powershell/touch')
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload to 'New-Item -Path C:\\temp\\pwned.txt -ItemType File'" do
      expect(subject.payload).to eq("New-Item -Path C:\\temp\\pwned.txt -ItemType File")
    end

    context "when the file param is changed" do
      let(:file) { 'pwned.txt' }

      before do
        subject.params[:file] = file
        subject.build
      end

      it "must change the file argument in the #payload" do
        expect(subject.payload).to eq("New-Item -Path #{file} -ItemType File")
      end
    end
  end
end
