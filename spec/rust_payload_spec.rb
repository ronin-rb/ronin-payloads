require 'spec_helper'
require 'ronin/payloads/rust_payload'

describe Ronin::Payloads::RustPayload do
  it "must inherit from Ronin::Payloads::BinaryPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::BinaryPayload)
  end

  describe "#compile" do
    let(:source_files) { %w[foo.rs bar.rs baz.rs] }

    it "must call system with `rustc` and source files" do
      expect(subject).to receive(:system).with(
        'rustc', *source_files
      ).and_return(true)

      subject.compile(*source_files)
    end

    context "when the output: keyword is given" do
      let(:output) { 'output' }

      it "must call system with 'rustc', the output, and source files" do
        expect(subject).to receive(:system).with(
          'rustc','-o', output, *source_files
        ).and_return(true)

        subject.compile(*source_files, output: output)
      end
    end

    context "when the target: keyword is given" do
      let(:target) { 'aarch64-unknown-linux-gnu' }

      it "must call system with 'rustc', the target, and source files" do
        expect(subject).to receive(:system).with(
          'rustc','--target', target, *source_files
        ).and_return(true)

        subject.compile(*source_files, target: target)
      end
    end

    context "when the cfg: keyword is given" do
      context "and it's a Hash" do
        let(:key1)   { 'foo' }
        let(:value1) { 42    }
        let(:key2)   { 'bar' }
        let(:value2) { "baz" }
        let(:cfg) do
          {key1 => value1, key2 => value2}
        end

        it "must call system with 'rustc', --cfg='key=value' arguments, and the source files" do
          expect(subject).to receive(:system).with(
            'rustc', '--cfg', "#{key1}=\"#{value1}\"",
                     '--cfg', "#{key2}=\"#{value2}\"",
                     *source_files
          ).and_return(true)

          subject.compile(*source_files, cfg: cfg)
        end
      end

      context "and it's an Array" do
        let(:value1) { :foo  }
        let(:value2) { "baz" }
        let(:cfg)    { [value1, value2] }

        it "must call system with 'rustc', --cfg='key=value' arguments, and the source files" do
          expect(subject).to receive(:system).with(
            'rustc', '--cfg', value1.to_s, '--cfg', value2.to_s, *source_files
          ).and_return(true)

          subject.compile(*source_files, cfg: cfg)
        end
      end

      context "but it's not a Hash or an Array" do
        let(:cfg) { Object.new }

        it do
          expect {
            subject.compile(*source_files, cfg: cfg)
          }.to raise_error(ArgumentError,"cfg value must be either a Hash or an Array: #{cfg.inspect}")
        end
      end
    end

    context "when system() returns false" do
      let(:output)      { 'output' }
      let(:source_file) { 'foo.rs' }

      it do
        allow(subject).to receive(:system).and_return(false)

        expect {
          subject.compile(source_file, output: output)
        }.to raise_error(Ronin::Payloads::BuildFailed,"rustc command failed: rustc -o #{output} #{source_file}")
      end
    end

    context "when system() returns nil" do
      let(:output)      { 'output' }
      let(:source_file) { 'foo.rs' }

      it do
        allow(subject).to receive(:system).and_return(nil)

        expect {
          subject.compile(source_file, output: output)
        }.to raise_error(Ronin::Payloads::BuildFailed,"rustc command not installed")
      end
    end
  end
end
