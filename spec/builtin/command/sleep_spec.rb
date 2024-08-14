require 'spec_helper'
require 'ronin/payloads/builtin/command/sleep'

describe Ronin::Payloads::Command::Sleep do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/sleep'" do
      expect(subject.id).to eq('command/sleep')
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload to 'sleep 5'" do
      expect(subject.payload).to eq("sleep 5")
    end

    context "when the secs param is changed" do
      let(:secs) { 10 }

      before do
        subject.params[:secs] = secs
        subject.build
      end

      it "must change the sleep number argument in the #payload" do
        expect(subject.payload).to eq("sleep #{secs}")
      end
    end
  end
end
