require 'spec_helper'
require 'ronin/payloads/encoders/builtin/shell/ifs'

describe Ronin::Payloads::Encoders::Shell::IFS do
  it "must inherit from Ronin::Payloads::Encoders::ShellCommandEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::ShellCommandEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'shell/ifs'" do
      expect(subject.id).to eq('shell/ifs')
    end
  end

  describe "#encode" do
    let(:command) { "ls -la" }
    let(:encoded) { "ls${IFS}-la" }

    it "must replace spaces with '${IFS}'" do
      expect(subject.encode(command)).to eq(encoded)
    end

    context "when the input contains multiple consecutive spaces" do
      let(:command) { "ls   -la" }

      it "must replace multiple spaces with a single '${IFS}'" do
        expect(subject.encode(command)).to eq(encoded)
      end
    end

    context "when the input contains other kinds of whitespace" do
      let(:command) { "ls\t-la" }

      it "must replace other whitespace characters with '${IFS}'" do
        expect(subject.encode(command)).to eq(encoded)
      end
    end
  end
end
