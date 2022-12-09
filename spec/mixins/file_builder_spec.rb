require 'spec_helper'
require 'ronin/payloads/mixins/file_builder'

require 'ronin/payloads/payload'

describe Ronin::Payloads::Mixins::FileBuilder do
  module TestFileBuilderMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::FileBuilder
    end
  end

  let(:payload_class) { TestFileBuilderMixin::TestPayload }
  subject { payload_class.new }

  it "must include Ronin::Payloads::Mixins::ERB" do
    expect(payload_class).to include(Ronin::Payloads::Mixins::ERB)
  end

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
            expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-#{name}-\d{8}-\d{5}-[a-z0-9]{5,6}\z})
          end
        end

        context "when given the ext: keyword argument" do
          let(:ext) { '.txt' }

          it "must also append the file extension to the tempfile name" do
            subject.tempfile(name, ext: ext) do |tempfile|
              expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-#{name}-\d{8}-\d{5}-[a-z0-9]{5,6}#{ext}\z})
            end
          end
        end
      end

      context "when given the ext: keyword argument" do
        let(:ext) { '.txt' }

        it "must append the file extension to the tempfile name" do
          subject.tempfile(ext: ext) do |tempfile|
            expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-\d{8}-\d{5}-[a-z0-9]{5,6}#{ext}\z})
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

          expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-#{name}-\d{8}-\d{5}-[a-z0-9]{5,6}\z})
        end

        context "when given the ext: keyword argument" do
          let(:ext) { '.txt' }

          it "must also append the file extension to the tempfile name" do
            tempfile = subject.tempfile(name, ext: ext)

            expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-#{name}-\d{8}-\d{5}-[a-z0-9]{5,6}#{ext}\z})
          end
        end
      end

      context "when given the ext: keyword argument" do
        let(:ext) { '.txt' }

        it "must append the file extension to the tempfile name" do
          tempfile = subject.tempfile(ext: ext)

          expect(tempfile.path).to match(%r{\A/tmp/ronin-payloads-\d{8}-\d{5}-[a-z0-9]{5,6}#{ext}\z})
        end
      end
    end
  end

  describe "#tempdir" do
    context "when given a block" do
      it "must yield a new temporary directory" do
        expect { |b|
          subject.tempdir(&b)
        }.to yield_with_args(%r{\A/tmp/ronin-payloads-\d{8}-\d{5}-[a-z0-9]{5,6}\z})
      end

      it "must create the new temporary directory" do
        subject.tempdir do |dir|
          expect(File.directory?(dir)).to be(true)
        end
      end

      context "when given a directory name" do
        let(:name) { 'foo' }

        it "must append it to 'ronin-payloads-'" do
          expect { |b|
            subject.tempdir(name,&b)
          }.to yield_with_args(%r{\A/tmp/ronin-payloads-#{name}-\d{8}-\d{5}-[a-z0-9]{5,6}\z})
        end
      end
    end

    context "when no block is given" do
      it "must return a new temporary directory" do
        tmpdir = subject.tempdir

        expect(tmpdir).to match(%r{\A/tmp/ronin-payloads-\d{8}-\d{5}-[a-z0-9]{5,6}\z})
        expect(File.directory?(tmpdir)).to be(true)
      end

      context "when given a directory name" do
        let(:name) { 'foo' }

        it "must append it to 'ronin-payloads-'" do
          tmpdir = subject.tempdir(name)

          expect(tmpdir).to match(%r{\A/tmp/ronin-payloads-#{name}-\d{8}-\d{5}-[a-z0-9]{5,6}\z})
        end
      end
    end
  end
end