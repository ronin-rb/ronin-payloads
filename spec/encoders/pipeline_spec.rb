require 'spec_helper'
require 'ronin/payloads/encoders/pipeline'
require 'ronin/payloads/encoders/encoder'

describe Ronin::Payloads::Encoders::Pipeline do
  module TestEncoderPipeline
    class EncoderA < Ronin::Payloads::Encoders::Encoder

      id 'encoder_a'

      def encode(data)
        "AAA#{data}"
      end

    end

    class EncoderB < Ronin::Payloads::Encoders::Encoder

      id 'encoder_b'

      def encode(data)
        "#{data}BBB"
      end

    end

    class BadEncoder < Ronin::Payloads::Encoders::Encoder

      id 'bad_encoder'

      def encode(data)
      end

    end
  end

  describe "#initialize" do
    subject { described_class.new }

    it "must initialize #encoders to an empty Array" do
      expect(subject.encoders).to eq([])
    end
  end

  let(:encoder_a) { TestEncoderPipeline::EncoderA.new }
  let(:encoder_b) { TestEncoderPipeline::EncoderB.new }
  let(:encoders)  { [encoder_a, encoder_b] }

  subject { described_class.new(encoders) }

  describe "#<<" do
    subject { described_class.new([encoder_a]) }

    it "must append the encoder to the end of #encoders" do
      subject << encoder_b

      expect(subject.encoders[0]).to eq(encoder_a)
      expect(subject.encoders[1]).to eq(encoder_b)
    end

    it "must return self" do
      expect(subject << encoder_b).to be(subject)
    end
  end

  describe "#empty?" do
    context "when #encoders is empty" do
      subject { described_class.new }

      it "must return true" do
        expect(subject.empty?).to be(true)
      end
    end

    context "when #encoders is not empty" do
      it "must return false" do
        expect(subject.empty?).to be(false)
      end
    end
  end

  describe "#each" do
    context "when given a block" do
      it "must yield each encoder in #encoders" do
        expect { |b|
          subject.each(&b)
        }.to yield_successive_args(*subject.encoders)
      end
    end

    context "when no block is given" do
      it "must return an Enumerator" do
        expect(subject.each.to_a).to eq(subject.encoders)
      end
    end
  end

  describe "#validate" do
    it "must also call #validate on each encoder in #encoders" do
      expect(encoder_a).to receive(:validate)
      expect(encoder_b).to receive(:validate)

      subject.validate
    end
  end

  describe "#[]" do
    context "when given an Integer" do
      it "must return the encoder at the given index" do
        expect(subject[0]).to eq(encoders[0])
        expect(subject[1]).to eq(encoders[1])
      end
    end

    context "when given a String" do
      it "must return the encoder with the matching id" do
        expect(subject['encoder_a'].class_id).to eq('encoder_a')
        expect(subject['encoder_b'].class_id).to eq('encoder_b')
      end

      context "but there is no encoder with the matching id" do
        it "must return nil" do
          expect(subject['foo']).to be(nil)
        end
      end
    end
  end

  describe "#encode" do
    let(:payload) { "foo" }

    it "must pass the given payload String through each encoder" do
      expect(subject.encode(payload)).to eq("AAA#{payload}BBB")
    end

    it "must not change the given payload String" do
      subject.encode(payload)

      expect(payload).to eq("foo")
    end

    context "when one of the encoders in #encoders does not return a String" do
      let(:bad_encoder) { TestEncoderPipeline::BadEncoder.new }
      before { subject << bad_encoder }

      it do
        expect {
          subject.encode(payload)
        }.to raise_error(Ronin::Payloads::Encoders::BadEncoder,"no result was returned by the encoder: #{bad_encoder.inspect}")
      end
    end
  end
end
