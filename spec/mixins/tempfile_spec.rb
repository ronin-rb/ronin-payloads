require 'spec_helper'
require 'ronin/payloads/mixins/tempfile'

require 'ronin/payloads/payload'

describe Ronin::Payloads::Mixins::Tempfile do
  module TestFileBuilderMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::Tempfile
    end
  end

  let(:payload_class) { TestFileBuilderMixin::TestPayload }
  subject { payload_class.new }

  describe "#tempfile" do
    context "when given a block" do
      it "must yield a new Tempfile object" do
        expect { |b|
          subject.tempfile(&b)
        }.to yield_with_args(Tempfile)
      end

      it "must create the tempfile" do
        subject.tempfile do |tempfile|
          expect(File.file?(tempfile.path)).to be(true)
        end
      end

      context "when given a file name" do
        let(:name) { 'foo' }

        it "must add the file name to the tempfile name" do
          subject.tempfile(name) do |tempfile|
            expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-#{name}-\d+-\d+-[a-z0-9]+\z})
          end
        end

        context "when given the ext: keyword argument" do
          let(:ext) { '.txt' }

          it "must also append the file extension to the tempfile name" do
            subject.tempfile(name, ext: ext) do |tempfile|
              expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-#{name}-\d+-\d+-[a-z0-9]+#{Regexp.escape(ext)}\z})
            end
          end
        end
      end

      context "when given the ext: keyword argument" do
        let(:ext) { '.txt' }

        it "must append the file extension to the tempfile name" do
          subject.tempfile(ext: ext) do |tempfile|
            expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-\d+-\d+-[a-z0-9]+#{Regexp.escape(ext)}\z})
          end
        end
      end
    end

    context "when no block is given" do
      it "must return a Tempfile object" do
        expect(subject.tempfile).to be_kind_of(Tempfile)
      end

      context "when given a file name" do
        let(:name) { 'foo' }

        it "must add the file name to the tempfile name" do
          tempfile = subject.tempfile(name)

          expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-#{name}-\d+-\d+-[a-z0-9]+\z})
        end

        context "when given the ext: keyword argument" do
          let(:ext) { '.txt' }

          it "must also append the file extension to the tempfile name" do
            tempfile = subject.tempfile(name, ext: ext)

            expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-#{name}-\d+-\d+-[a-z0-9]+#{Regexp.escape(ext)}\z})
          end
        end
      end

      context "when given the ext: keyword argument" do
        let(:ext) { '.txt' }

        it "must append the file extension to the tempfile name" do
          tempfile = subject.tempfile(ext: ext)

          expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-\d+-\d+-[a-z0-9]+#{Regexp.escape(ext)}\z})
        end
      end
    end
  end
end
