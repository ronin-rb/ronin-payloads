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
      )

      subject.compile(*source_files)
    end

    context "when the output: keyword is given" do
      let(:output) { 'output' } 

      it "must call system with 'rustc', the output, and source files" do
        expect(subject).to receive(:system).with(
          'rustc','-o', output, *source_files
        )

        subject.compile(*source_files, output: output)
      end
    end

    context "when the target: keyword is given" do
      let(:target) { 'aarch64-unknown-linux-gnu' } 

      it "must call system with 'rustc', the target, and source files" do
        expect(subject).to receive(:system).with(
          'rustc','--target', target, *source_files
        )

        subject.compile(*source_files, target: target)
      end
    end
  end
end
