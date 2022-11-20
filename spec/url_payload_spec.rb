require 'spec_helper'
require 'ronin/payloads/url_payload'

describe Ronin::Payloads::URLPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  describe ".url" do
    subject { payload_class }

    context "and when url is not set in the class" do
      module TestMetadataURL
        class WithNoURLSet < Ronin::Payloads::URLPayload
        end
      end

      let(:payload_class) { TestMetadataURL::WithNoURLSet }

      it "must default to nil" do
        expect(subject.url).to be(nil)
      end
    end

    context "and when url is set in the class" do
      module TestMetadataURL
        class WithURLSet < Ronin::Payloads::URLPayload
          url 'test'
        end
      end

      let(:payload_class) { TestMetadataURL::WithURLSet }

      it "must return the set url" do
        expect(subject.url).to eq("test")
      end
    end

    context "but when the url was set in the superclass" do
      module TestMetadataURL
        class InheritsItsURL < WithURLSet
        end
      end

      let(:payload_class) { TestMetadataURL::InheritsItsURL }

      it "must return the url set in the superclass" do
        expect(subject.url).to eq("test")
      end

      context "but the url is overridden in the sub-class" do
        module TestMetadataURL
          class OverridesItsInheritedURL < WithURLSet
            url "test2"
          end
        end

        let(:payload_class) do
          TestMetadataURL::OverridesItsInheritedURL
        end

        it "must return the url set in the sub-class" do
          expect(subject.url).to eq("test2")
        end

        it "must not modify the superclass'es url" do
          expect(subject.superclass.url).to eq('test')
        end
      end
    end
  end
end
