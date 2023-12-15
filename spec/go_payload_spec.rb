require 'spec_helper'
require 'ronin/payloads/go_payload'

describe Ronin::Payloads::GoPayload do
  it "must inherit from Ronin::Payloads::BinaryPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::BinaryPayload)
  end

  describe "#compile_go" do
    let(:source_files) { %w[foo.go bar.go baz.go] }

    it "must call system with `go build` and source files" do
      expect(subject).to receive(:system).with(
        'go', 'build', *source_files
      ).and_return(true)

      subject.compile_go(*source_files)
    end

    context "when the output: keyword is given" do
      let(:output) { 'output' }

      it "must call system with 'go build', the output, and source files" do
        expect(subject).to receive(:system).with(
          'go', 'build','-o', output, *source_files
        ).and_return(true)

        subject.compile_go(*source_files, output: output)
      end
    end

    context "when system() returns false" do
      let(:source_file) { 'foo.go' }

      it do
        allow(subject).to receive(:system).and_return(false)

        expect {
          subject.compile_go(source_file)
        }.to raise_error(Ronin::Payloads::BuildFailed,"go command failed: go build #{source_file}")
      end
    end

    context "when system() returns nil" do
      let(:source_file) { 'foo.go' }

      it do
        allow(subject).to receive(:system).and_return(nil)

        expect {
          subject.compile_go(source_file)
        }.to raise_error(Ronin::Payloads::BuildFailed,"go command not installed")
      end
    end
  end
end
