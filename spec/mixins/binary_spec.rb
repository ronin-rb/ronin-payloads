require 'spec_helper'
require 'ronin/payloads/mixins/binary'

require 'ronin/payloads/payload'
require 'ronin/payloads/metadata/arch'
require 'ronin/payloads/metadata/os'

describe Ronin::Payloads::Mixins::Binary do
  module TestBinaryMixin
    class PayloadWithArchSet < Ronin::Payloads::Payload
      include Ronin::Payloads::Metadata::Arch
      include Ronin::Payloads::Mixins::Binary

      arch :x86
    end

    class PayloadWithoutArch < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::Binary
    end

    class PayloadWithoutArchSet < Ronin::Payloads::Payload
      include Ronin::Payloads::Metadata::Arch
      include Ronin::Payloads::Mixins::Binary
    end

    class PayloadWithArchSetButWithoutOSSet < Ronin::Payloads::Payload
      include Ronin::Payloads::Metadata::Arch
      include Ronin::Payloads::Metadata::OS
      include Ronin::Payloads::Mixins::Binary

      arch :x86
    end

    class PayloadWithArchAndOSSet < Ronin::Payloads::Payload
      include Ronin::Payloads::Metadata::Arch
      include Ronin::Payloads::Metadata::OS
      include Ronin::Payloads::Mixins::Binary

      arch :x86
      os :linux
    end
  end

  subject { payload_class.new }

  describe "#perform_validate" do
    context "when the payload class does not define an #arch method" do
      let(:payload_class) { TestBinaryMixin::PayloadWithoutArch }

      it do
        expect {
          subject.perform_validate
        }.to raise_error(Ronin::Payloads::ValidationError,"payload #{payload_class} did not include Ronin::Payloads::Metadata::Arch")
      end
    end

    context "when the payload class's #arch method returns nil" do
      let(:payload_class) { TestBinaryMixin::PayloadWithoutArchSet }

      it do
        expect {
          subject.perform_validate
        }.to raise_error(Ronin::Payloads::ValidationError,"payload #{payload_class} did not include define an architecture")
      end
    end

    context "when the payload class defines an architecture" do
      let(:payload_class) { TestBinaryMixin::PayloadWithArchSet }

      it do
        expect {
          subject.perform_validate
        }.to_not raise_error
      end
    end
  end

  describe "#platform" do
    context "when #arch returns nil" do
      let(:payload_class) { TestBinaryMixin::PayloadWithoutArchSet }

      it "must return Ronin::Support::Binary::CTypes" do
        expect(subject.platform).to be(Ronin::Support::Binary::CTypes)
      end
    end

    context "when #arch returns a architecture name" do
      let(:payload_class) { TestBinaryMixin::PayloadWithArchSet }

      it "must return the according Ronin::Support::Binary::CTypes::Arch:: module" do
        expect(subject.platform).to be(Ronin::Support::Binary::CTypes::Arch::X86)
      end

      context "and when #os is defined" do
        context "and it returns an OS name" do
          let(:payload_class) do
            TestBinaryMixin::PayloadWithArchAndOSSet
          end

          it "must return the according Ronin::Support::Binary::CTypes::OS object with the according Ronin::Support::Binary::CTypes::Arch:: module inside it" do
            expect(subject.platform).to be_kind_of(Ronin::Support::Binary::CTypes::OS::Linux)
            expect(subject.platform.types).to be(Ronin::Support::Binary::CTypes::Arch::X86)
          end
        end

        context "but it returns nil" do
          let(:payload_class) do
            TestBinaryMixin::PayloadWithArchSetButWithoutOSSet
          end

          it "must still return the according Ronin::Support::Binary::CTypes::Arch:: module" do
            expect(subject.platform).to be(Ronin::Support::Binary::CTypes::Arch::X86)
          end
        end
      end
    end
  end

  describe "#pack" do
    let(:payload_class) { TestBinaryMixin::PayloadWithArchSet }

    let(:type)  { :uint32    }
    let(:value) { 0x12345678 }

    it "must pack the value using the type from #platform" do
      expect(subject.pack(type,value)).to eq("\x78\x56\x34\x12".b)
    end
  end
end
