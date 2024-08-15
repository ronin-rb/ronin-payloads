require 'spec_helper'
require 'ronin/payloads/builtin/test/command'

describe Ronin::Payloads::Test::Command do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/command'" do
      expect(subject.id).to eq('test/command')
    end
  end

  describe "#build" do
    context "when the command param is not set" do
      before { subject.build }

      it "must set #payload to 'echo PWNED'" do
        expect(subject.payload).to eq(%{echo PWNED})
      end
    end

    context "when the command param is set" do
      let(:command) { 'echo lol' }

      before do
        subject.params[:command] = command
        subject.build
      end

      it "must set #payload to the command param" do
        expect(subject.payload).to eq(command)
      end
    end
  end
end
