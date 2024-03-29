require 'spec_helper'
require 'ronin/payloads/metadata/arch'

describe Ronin::Payloads::Metadata::Arch do
  module TestMetadataArch
    class WithNoArchSet
      include Ronin::Payloads::Metadata::Arch
    end

    class WithArchSet
      include Ronin::Payloads::Metadata::Arch

      arch :x86_64
    end

    class InheritsItsArch < WithArchSet
      include Ronin::Payloads::Metadata::Arch
    end

    class OverridesItsInheritedArch < WithArchSet
      include Ronin::Payloads::Metadata::Arch

      arch :armbe
    end
  end

  describe ".arch" do
    subject { test_class }

    context "and when arch is not set in the class" do
      let(:test_class) { TestMetadataArch::WithNoArchSet }

      it "must default to nil" do
        expect(subject.arch).to be(nil)
      end
    end

    context "and when arch is set in the class" do
      let(:test_class) { TestMetadataArch::WithArchSet }

      it "must return the set arch" do
        expect(subject.arch).to eq(:x86_64)
      end
    end

    context "but when the arch was set in the superclass" do
      let(:test_class) { TestMetadataArch::InheritsItsArch }

      it "must return the arch set in the superclass" do
        expect(subject.arch).to eq(:x86_64)
      end

      context "but the arch is overridden in the sub-class" do
        let(:test_class) { TestMetadataArch::OverridesItsInheritedArch }

        it "must return the arch set in the sub-class" do
          expect(subject.arch).to eq(:armbe)
        end
      end
    end
  end

  describe "#arch" do
    subject { test_class.new }

    context "when the Payload class has .arch set" do
      let(:test_class) { TestMetadataArch::WithArchSet }

      it "must return the Payload class'es .arch" do
        expect(subject.arch).to eq(test_class.arch)
      end
    end

    context "when the Payload class does not have .arch set" do
      let(:test_class) { TestMetadataArch::WithNoArchSet }

      it "must return nil" do
        expect(subject.arch).to be(nil)
      end
    end
  end
end
