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
    let(:command) { "echo PWNED" }
    let(:encoded) { "echo${IFS}PWNED" }

    it "must replace spaces with '${IFS}'" do
      expect(subject.encode(command)).to eq(encoded)
    end

    context "when the input contains multiple consecutive spaces" do
      let(:command) { "echo   PWNED" }

      it "must replace multiple spaces with a single '${IFS}'" do
        expect(subject.encode(command)).to eq(encoded)
      end
    end

    context "when the input contains other kinds of whitespace" do
      let(:command) { "echo\tPWNED" }

      it "must replace other whitespace characters with '${IFS}'" do
        expect(subject.encode(command)).to eq(encoded)
      end
    end

    it "must return a valid shell command", :integration do
      expect(`sh -c '#{subject.encode(command)}'`).to eq("PWNED#{$/}")
    end
  end
end
