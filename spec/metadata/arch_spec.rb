require 'spec_helper'
require 'ronin/payloads/metadata/arch'

describe Ronin::Payloads::Metadata::Arch do
  describe ".arch" do
    subject { test_class }

    context "and when arch is not set in the class" do
      module TestMetadataArch
        class WithNoArchSet
          include Ronin::Payloads::Metadata::Arch
        end
      end

      let(:test_class) { TestMetadataArch::WithNoArchSet }

      it "must default to nil" do
        expect(subject.arch).to be(nil)
      end
    end

    context "and when arch is set in the class" do
      module TestMetadataArch
        class WithArchSet
          include Ronin::Payloads::Metadata::Arch

          arch :x86_64
        end
      end

      let(:test_class) { TestMetadataArch::WithArchSet }

      it "must return the set arch" do
        expect(subject.arch).to eq(:x86_64)
      end
    end

    context "but when the arch was set in the superclass" do
      module TestMetadataArch
        class InheritsItsArch < WithArchSet
          include Ronin::Payloads::Metadata::Arch
        end
      end

      let(:test_class) { TestMetadataArch::InheritsItsArch }

      it "must return the arch set in the superclass" do
        expect(subject.arch).to eq(:x86_64)
      end

      context "but the arch is overridden in the sub-class" do
        module TestMetadataArch
          class OverridesItsInheritedArch < WithArchSet
            include Ronin::Payloads::Metadata::Arch

            arch :armbe
          end
        end

        let(:test_class) do
          TestMetadataArch::OverridesItsInheritedArch
        end

        it "must return the arch set in the sub-class" do
          expect(subject.arch).to eq(:armbe)
        end
      end
    end
  end
end
