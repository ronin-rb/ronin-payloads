require 'spec_helper'
require 'ronin/payloads/builtin/test/cmd'

describe Ronin::Payloads::Test::CMD do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/cmd'" do
      expect(subject.id).to eq('test/cmd')
    end
  end

  describe "#build" do
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
