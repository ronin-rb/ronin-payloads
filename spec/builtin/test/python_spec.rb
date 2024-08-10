require 'spec_helper'
require 'ronin/payloads/builtin/test/python'

describe Ronin::Payloads::Test::Python do
  it "must inherit from Ronin::Payloads::PythonPayload" do
    expect(described_class).to be < Ronin::Payloads::PythonPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'test/python'" do
      expect(subject.id).to eq('test/python')
    end
  end

  describe "#build" do
    context "when the python param is not set" do
      before { subject.build }

      it "must set #payload to `print('PWNED');`" do
        expect(subject.payload).to eq(%{print('PWNED');})
      end
    end

    context "when the python param is set" do
      let(:python) { "puts('lol');" }

      before do
        subject.params[:python] = python
        subject.build
      end

      it "must set #payload to the python param" do
        expect(subject.payload).to eq(python)
      end
    end
  end
end
