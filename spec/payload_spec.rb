require 'spec_helper'
require 'ronin/payloads/payload'
require 'ronin/payloads/encoders/encoder'

describe Ronin::Payloads::Payload do
  it "must include Ronin::Core::Metadata::ID" do
    expect(described_class).to include(Ronin::Core::Metadata::ID)
  end

  it "must include Ronin::Core::Metadata::Authors" do
    expect(described_class).to include(Ronin::Core::Metadata::Authors)
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

  describe "#build" do
    subject { described_class.new }

    it "must return nil by default" do
      expect(subject.build).to be(nil)
    end

    it "must not set @payload by default" do
      subject.build

      expect(subject.instance_variable_get('@payload')).to be(nil)
    end
  end

  describe "#cleanup" do
    subject { described_class.new }

    it "must return nil by default" do
      expect(subject.cleanup).to be(nil)
    end
  end

  module TestPayload
    class TestEncoder < Ronin::Payloads::Encoders::Encoder

      def encode(payload)
        payload.upcase
      end

    end

    class TestPayload < Ronin::Payloads::Payload

      register 'test_payload'

      def build
        @payload = "the payload"
      end

    end
  end

  let(:test_encoder_class) { TestPayload::TestEncoder }
  let(:test_encoder)       { test_encoder_class.new   }

  let(:test_class) { TestPayload::TestPayload }
  subject { test_class.new }

  describe ".register" do
    subject { test_class }

    it "must register the payload class into Payloads.registry" do
      expect(Ronin::Payloads.registry['test_payload']).to eq(subject)
    end

    it "must also set .id" do
      expect(subject.id).to eq('test_payload')
    end
  end

  describe "#validate" do
    it "must call #validate_params" do
      expect(subject).to receive(:validate_params)

      subject.validate
    end

    context "when #encoders is populated" do
      let(:encoder1) { test_encoder_class.new }
      let(:encoder2) { test_encoder_class.new }

      subject { test_class.new(encoders: [encoder1, encoder2]) }

      it "must also call #validate on each #encoder" do
        expect(encoder1).to receive(:validate)
        expect(encoder2).to receive(:validate)
        expect(subject).to receive(:validate_params)

        subject.validate
      end
    end
  end

  describe "#built?" do
    context "when @payload is set by #build" do
      before { subject.build }

      it "must return true" do
        expect(subject.built?).to be(true)
      end
    end

    context "when @payload is not set" do
      it "must return false" do
        expect(subject.built?).to be(false)
      end
    end
  end

  describe "#perform_build" do
    subject { described_class.new }

    it "must call #build and then check #built?" do
      expect(subject).to receive(:build)
      expect(subject).to receive(:built?).and_return(true)

      subject.perform_build
    end

    context "when the #build method did not set @payload" do
      it do
        expect {
          subject.perform_build
        }.to raise_error(Ronin::Payloads::PayloadNotBuilt,/^the payload was not built for some reason: /)
      end
    end
  end

  describe "#built_payload" do
    it "must return the built payload" do
      expect(subject.built_payload).to eq("the payload")
    end

    it "must not re-build the payload when called multiple times" do
      expect(subject.built_payload).to be(subject.built_payload)
    end
  end

  describe "#rebuild_payload" do
    before { subject.build }

    it "must forcibly re-build the payload" do
      previously_built_payload = subject.payload

      subject.rebuild_payload

      expect(subject.payload).to eq(previously_built_payload)
      expect(subject.payload).to_not be(previously_built_payload)
    end
  end

  describe "#encode_payload" do
    subject { test_class.new(encoders: [test_encoder]) }

    it "must encode the built payload" do
      expect(subject.encode_payload).to eq(
        test_encoder.encode(subject.built_payload)
      )
    end

    it "must return a new String each time" do
      encoded_payload = subject.encoded_payload

      expect(subject.encode_payload).to eq(encoded_payload)
      expect(subject.encode_payload).to_not be(encoded_payload)
    end
  end

  describe "#encoded_payload" do
    subject { test_class.new(encoders: [test_encoder]) }

    it "must encode the built payload" do
      expect(subject.encoded_payload).to eq(
        test_encoder.encode(subject.built_payload)
      )
    end

    it "must not re-encode the payload when called multiple times" do
      expect(subject.encoded_payload).to be(subject.encoded_payload)
    end
  end

  describe "#reencode_payload" do
    subject { test_class.new(encoders: [test_encoder]) }

    before { subject.encoded_payload }

    it "must forcibly re-encoded the payload" do
      previously_encoded_payload = subject.encoded_payload

      subject.reencode_payload

      expect(subject.encoded_payload).to eq(previously_encoded_payload)
      expect(subject.encoded_payload).to_not be(previously_encoded_payload)
    end
  end

  describe "#perform_prelaunch" do
    subject { described_class.new }

    it "must call #prelaunch" do
      expect(subject).to receive(:prelaunch)

      subject.perform_prelaunch
    end
  end

  describe "#perform_postlaunch" do
    subject { described_class.new }

    it "must call #postlaunch" do
      expect(subject).to receive(:postlaunch)

      subject.perform_postlaunch
    end
  end

  describe "#perform_cleanup" do
    subject { described_class.new }

    it "must call #cleanup" do
      expect(subject).to receive(:cleanup)

      subject.perform_cleanup
    end

    it "must set @payload to nil" do
      subject.instance_variable_set('@payload',"foo")

      subject.perform_cleanup

      expect(subject.instance_variable_get('@payload')).to be(nil)
    end
  end

  describe "#to_s" do
    subject { test_class.new(encoders: [test_encoder]) }

    it "must return the encoded payload" do
      expect(subject.to_s).to eq(subject.encoded_payload)
    end
  end
end
