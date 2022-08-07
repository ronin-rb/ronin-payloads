require 'spec_helper'
require 'ronin/payloads/metadata/os'

describe Ronin::Payloads::Metadata::OS do
  describe ".os" do
    subject { test_class }

    context "and when os is not set in the class" do
      module TestMetadataOS
        class WithNoOSSet
          include Ronin::Payloads::Metadata::OS
        end
      end

      let(:test_class) { TestMetadataOS::WithNoOSSet }

      it "must default to nil" do
        expect(subject.os).to be(nil)
      end
    end

    context "and when os is set in the class" do
      module TestMetadataOS
        class WithOSSet
          include Ronin::Payloads::Metadata::OS

          os :linux
        end
      end

      let(:test_class) { TestMetadataOS::WithOSSet }

      it "must return the set os" do
        expect(subject.os).to eq(:linux)
      end
    end

    context "but when the os was set in the superclass" do
      module TestMetadataOS
        class InheritsItsOS < WithOSSet
          include Ronin::Payloads::Metadata::OS
        end
      end

      let(:test_class) { TestMetadataOS::InheritsItsOS }

      it "must return the os set in the superclass" do
        expect(subject.os).to eq(:linux)
      end

      context "but the os is overridden in the sub-class" do
        module TestMetadataOS
          class OverridesItsInheritedOS < WithOSSet
            include Ronin::Payloads::Metadata::OS

            os :macos
          end
        end

        let(:test_class) do
          TestMetadataOS::OverridesItsInheritedOS
        end

        it "must return the os set in the sub-class" do
          expect(subject.os).to eq(:macos)
        end
      end
    end
  end

  describe ".os_version" do
    subject { test_class }

    context "and when os is not set in the class" do
      module TestMetadataOS
        class WithNoOSVersionSet
          include Ronin::Payloads::Metadata::OS
          os :linux
        end
      end

      let(:test_class) { TestMetadataOS::WithNoOSVersionSet }

      it "must default to nil" do
        expect(subject.os_version).to be(nil)
      end
    end

    context "and when os_version is set in the class" do
      module TestMetadataOS
        class WithOSVersionSet
          include Ronin::Payloads::Metadata::OS

          os :linux
          os_version '5.x'
        end
      end

      let(:test_class) { TestMetadataOS::WithOSVersionSet }

      it "must return the set os_version" do
        expect(subject.os_version).to eq('5.x')
      end
    end

    context "but when the os was set in the superclass" do
      module TestMetadataOS
        class InheritsItsOSVersion < WithOSVersionSet
          include Ronin::Payloads::Metadata::OS
        end
      end

      let(:test_class) { TestMetadataOS::InheritsItsOSVersion }

      it "must return the os_version set in the superclass" do
        expect(subject.os_version).to eq('5.x')
      end

      context "but the os is overridden in the sub-class" do
        module TestMetadataOS
          class OverridesItsInheritedOSVersion < WithOSVersionSet
            include Ronin::Payloads::Metadata::OS

            os :macos
            os_version '13'
          end
        end

        let(:test_class) do
          TestMetadataOS::OverridesItsInheritedOSVersion
        end

        it "must return the os_version set in the sub-class" do
          expect(subject.os_version).to eq('13')
        end
      end
    end
  end
end
