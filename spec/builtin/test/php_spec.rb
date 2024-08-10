require 'spec_helper'
require 'ronin/payloads/builtin/test/php'

describe Ronin::Payloads::Test::PHP do
  it "must inherit from Ronin::Payloads::PHPPayload" do
    expect(described_class).to be < Ronin::Payloads::PHPPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/php'" do
      expect(subject.id).to eq('test/php')
    end
  end

  describe "#build" do
    context "when the php param is not set" do
      before { subject.build }

      it "must set #payload to `echo('PWNED');`" do
        expect(subject.payload).to eq(%{echo('PWNED');})
      end
    end

    context "when the php param is set" do
      let(:php) { "echo('lol');" }

      before do
        subject.params[:php] = php
        subject.build
      end

      it "must set #payload to the php param" do
        expect(subject.payload).to eq(php)
      end
    end
  end
end
