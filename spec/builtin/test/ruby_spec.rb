require 'spec_helper'
require 'ronin/payloads/builtin/test/ruby'

describe Ronin::Payloads::Test::Ruby do
  it "must inherit from Ronin::Payloads::RubyPayload" do
    expect(described_class).to be < Ronin::Payloads::RubyPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/ruby'" do
      expect(subject.id).to eq('test/ruby')
    end
  end

  describe "#build" do
    context "when the ruby param is not set" do
      before { subject.build }

      it "must set #payload to `puts('PWNED');`" do
        expect(subject.payload).to eq(%{puts('PWNED');})
      end
    end

    context "when the ruby param is set" do
      let(:ruby) { "puts('lol');" }

      before do
        subject.params[:ruby] = ruby
        subject.build
      end

      it "must set #payload to the ruby param" do
        expect(subject.payload).to eq(ruby)
      end
    end
  end
end
