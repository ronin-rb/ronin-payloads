require 'spec_helper'
require 'ronin/payloads/go_payload'

describe Ronin::Payloads::GoPayload do
  it "must inherit from Ronin::Payloads::BinaryPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::BinaryPayload)
  end

  describe "#compile" do
    let(:source_files) { %w[foo.go bar.go baz.go] }

    it "must call system with `go build` and source files" do
      expect(subject).to receive(:system).with(
        'go', 'build', *source_files
      )

      subject.compile(*source_files)
    end

    context "when the output: keyword is given" do
      let(:output) { 'output' } 

      it "must call system with 'go build', the output, and source files" do
        expect(subject).to receive(:system).with(
          'go', 'build','-o', output, *source_files
        )

        subject.compile(*source_files, output: output)
      end
    end
  end
end
