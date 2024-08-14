require 'spec_helper'
require 'ronin/payloads/builtin/command/windows/touch'

describe Ronin::Payloads::Command::Windows::Touch do
  it "must inherit from Ronin::Payloads::WindowsCommandPayload" do
    expect(described_class).to be < Ronin::Payloads::WindowsCommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/windows/touch'" do
      expect(subject.id).to eq('command/windows/touch')
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload to 'type nul >> C:\\temp\\pwned.txt'" do
      expect(subject.payload).to eq("type nul >> C:\\temp\\pwned.txt")
    end

    context "when the file param is changed" do
      let(:file) { 'pwned.txt' }

      before do
        subject.params[:file] = file
        subject.build
      end

      it "must change the file argument in the #payload" do
        expect(subject.payload).to eq("type nul >> #{file}")
      end
    end
  end
end
