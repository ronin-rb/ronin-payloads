require 'spec_helper'
require 'ronin/payloads/builtin/command/touch'

describe Ronin::Payloads::Command::Touch do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/touch'" do
      expect(subject.id).to eq('command/touch')
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload to 'touch /tmp/pwned'" do
      expect(subject.payload).to eq("touch /tmp/pwned")
    end

    context "when the file param is changed" do
      let(:file) { './pwned.txt' }

      before do
        subject.params[:file] = file
        subject.build
      end

      it "must change the file argument in the #payload" do
        expect(subject.payload).to eq("touch #{file}")
      end
    end
  end
end
