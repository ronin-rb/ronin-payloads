require 'spec_helper'
require 'ronin/payloads/cli/printing/metadata'
require 'ronin/payloads/cli/command'

describe Ronin::Payloads::CLI::Printing::Metadata do
  module TestPrintingMetadata
    class TestCommand < Ronin::Payloads::CLI::Command
      include Ronin::Payloads::CLI::Printing::Metadata
    end
  end

  let(:command_class) { TestPrintingMetadata::TestCommand }
  subject { command_class.new }

  describe "#arch_name" do
    context "when given :x86" do
      it "must return 'x86'" do
        expect(subject.arch_name(:x86)).to eq('x86')
      end
    end

    context "when given :x86_64" do
      it "must return 'x86-64'" do
        expect(subject.arch_name(:x86_64)).to eq('x86-64')
      end
    end

    context "when given :ia64" do
      it "must return 'ia64'" do
        expect(subject.arch_name(:ia64)).to eq('IA64')
      end
    end

    context "when given :amd64" do
      it "must return 'x86-64'" do
        expect(subject.arch_name(:amd64)).to eq('x86-64')
      end
    end

    context "when given :ppc" do
      it "must return 'PPC'" do
        expect(subject.arch_name(:ppc)).to eq('PPC')
      end
    end

    context "when given :ppc64" do
      it "must return 'PPC64'" do
        expect(subject.arch_name(:ppc64)).to eq('PPC64')
      end
    end

    context "when given :mips" do
      it "must return 'MIPS'" do
        expect(subject.arch_name(:mips)).to eq('MIPS')
      end
    end

    context "when given :mips_le" do
      it "must return 'MIPS (LE)'" do
        expect(subject.arch_name(:mips_le)).to eq('MIPS (LE)')
      end
    end

    context "when given :mips_be" do
      it "must return 'MIPS'" do
        expect(subject.arch_name(:mips_be)).to eq('MIPS')
      end
    end

    context "when given :mips64" do
      it "must return 'MIPS64'" do
        expect(subject.arch_name(:mips64)).to eq('MIPS64')
      end
    end

    context "when given :mips64_le" do
      it "must return 'MIPS64 (LE)'" do
        expect(subject.arch_name(:mips64_le)).to eq('MIPS64 (LE)')
      end
    end

    context "when given :mips64_be" do
      it "must return 'MIPS64'" do
        expect(subject.arch_name(:mips64_be)).to eq('MIPS64')
      end
    end

    context "when given :arm" do
      it "must return 'ARM'" do
        expect(subject.arch_name(:arm)).to eq('ARM')
      end
    end

    context "when given :arm_le" do
      it "must return 'ARM'" do
        expect(subject.arch_name(:arm_le)).to eq('ARM')
      end
    end

    context "when given :arm_be" do
      it "must return 'ARM (BE)'" do
        expect(subject.arch_name(:arm_be)).to eq('ARM (BE)')
      end
    end

    context "when given :arm64" do
      it "must return 'ARM64'" do
        expect(subject.arch_name(:arm64)).to eq('ARM64')
      end
    end

    context "when given :arm64_le" do
      it "must return 'ARM64'" do
        expect(subject.arch_name(:arm64_le)).to eq('ARM64')
      end
    end

    context "when given :arm64_be" do
      it "must return 'ARM64 (BE)'" do
        expect(subject.arch_name(:arm64_be)).to eq('ARM64 (BE)')
      end
    end

    context "when given an unknown architecture" do
      it "must return the String version of the architecture" do
        expect(subject.arch_name(:foo)).to eq('foo')
      end
    end
  end

  describe "#os_name" do
    context "when given :unix" do
      it "must return 'UNIX'" do
        expect(subject.os_name(:unix)).to eq('UNIX')
      end
    end

    context "when given :bsd" do
      it "must return 'BSD'" do
        expect(subject.os_name(:bsd)).to eq('BSD')
      end
    end

    context "when given :freebsd" do
      it "must return 'FreeBSD'" do
        expect(subject.os_name(:freebsd)).to eq('FreeBSD')
      end
    end

    context "when given :openbsd" do
      it "must return 'OpenBSD'" do
        expect(subject.os_name(:openbsd)).to eq('OpenBSD')
      end
    end

    context "when given :netbsd" do
      it "must return 'NetBSD'" do
        expect(subject.os_name(:netbsd)).to eq('NetBSD')
      end
    end

    context "when given :linux" do
      it "must return 'Linux'" do
        expect(subject.os_name(:linux)).to eq('Linux')
      end
    end

    context "when given :macos" do
      it "must return 'macOS'" do
        expect(subject.os_name(:macos)).to eq('macOS')
      end
    end

    context "when given :windows" do
      it "must return 'Windows'" do
        expect(subject.os_name(:windows)).to eq('Windows')
      end
    end
  end
end
