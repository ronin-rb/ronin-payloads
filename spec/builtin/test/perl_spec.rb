require 'spec_helper'
require 'ronin/payloads/builtin/test/perl'

describe Ronin::Payloads::Test::Perl do
  it "must inherit from Ronin::Payloads::PerlPayload" do
    expect(described_class).to be < Ronin::Payloads::PerlPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/perl'" do
      expect(subject.id).to eq('test/perl')
    end
  end

  describe "#build" do
    context "when the perl param is not set" do
      before { subject.build }

      it "must set #payload to `print(\"PWNED\\n\");`" do
        expect(subject.payload).to eq(%{print("PWNED\\n");})
      end
    end

    context "when the perl param is set" do
      let(:perl) { "print('lol');" }

      before do
        subject.params[:perl] = perl
        subject.build
      end

      it "must set #payload to the perl param" do
        expect(subject.payload).to eq(perl)
      end
    end
  end
end
