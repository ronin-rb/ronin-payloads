require 'spec_helper'
require 'ronin/payloads/builtin/test/sql'

describe Ronin::Payloads::Test::SQL do
  it "must inherit from Ronin::Payloads::SQLPayload" do
    expect(described_class).to be < Ronin::Payloads::SQLPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/sql'" do
      expect(subject.id).to eq('test/sql')
    end
  end

  describe "#build" do
    context "when the sql param is not set" do
      before { subject.build }

      it "must set #payload to 'SELECT(1)'" do
        expect(subject.payload).to eq(%{SELECT(1)})
      end
    end

    context "when the sql param is set" do
      let(:sql) { 'SELECT("PWNED")' }

      before do
        subject.params[:sql] = sql
        subject.build
      end

      it "must set #payload to the sql param" do
        expect(subject.payload).to eq(sql)
      end
    end
  end
end
