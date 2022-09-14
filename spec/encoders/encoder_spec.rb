require 'spec_helper'
require 'ronin/payloads/encoders/encoder'

describe Ronin::Payloads::Encoders::Encoder do
  it "must include Ronin::Core::Metadata::ID" do
    expect(described_class).to include(Ronin::Core::Metadata::ID)
  end

  it "must include Ronin::Core::Metadata::Summary" do
    expect(described_class).to include(Ronin::Core::Metadata::Summary)
  end

  it "must include Ronin::Core::Metadata::Description" do
    expect(described_class).to include(Ronin::Core::Metadata::Description)
  end

  it "must include Ronin::Core::Metadata::References" do
    expect(described_class).to include(Ronin::Core::Metadata::References)
  end

  it "must include Ronin::Core::Params::Mixin" do
    expect(described_class).to include(Ronin::Core::Params::Mixin)
  end

  module TestEncoders
    class TestEncoder < Ronin::Payloads::Encoders::Encoder

      register 'test_encoder'

    end
  end

  describe ".register" do
    subject { TestEncoders::TestEncoder }

    it "must register the Encoder class with Encoders.module_registry" do
      expect(Ronin::Payloads::Encoders.registry['test_encoder']).to be(subject)
    end

    it "must also set .id" do
      expect(subject.id).to eq('test_encoder')
    end
  end

  describe "#validate" do
    it "must call #validate_params" do
      expect(subject).to receive(:validate_params)

      subject.validate
    end
  end

  describe "#encode" do
    let(:data) { "data" }

    it "must raise NotImplementedError by default" do
      expect {
        subject.encode(data)
      }.to raise_error(NotImplementedError,"#{described_class}#encode was not implemented")
    end
  end
end
