require 'spec_helper'
require 'ronin/payloads/cli/format_option'
require 'ronin/payloads/cli/command'

require 'stringio'

describe Ronin::Payloads::CLI::FormatOption do
  module TestFormatOption
    class TestCommand < Ronin::Payloads::CLI::Command
      include Ronin::Payloads::CLI::FormatOption
    end
  end

  let(:command_class) { TestFormatOption::TestCommand }
  subject { command_class.new }

  describe ".included" do
    subject { command_class }

    it "must add a -F,--format c|shell|js|ruby option" do
      expect(subject.options[:format]).to_not be(nil)
      expect(subject.options[:format].short).to eq('-F')
      expect(subject.options[:format].value).to_not be(nil)
      expect(subject.options[:format].value.type).to eq(
        [:hex, :c, :shell, :powershell, :xml, :html, :js, :ruby]
      )
      expect(subject.options[:format].desc).to eq('Formats the outputed data')
    end
  end

  describe "parse_options" do
    context "when given '--format hex'" do
      before { subject.parse_options(%w[--format hex]) }

      it "must set #format to Ronin::Support::Encoding::Hex.escape" do
        expect(subject.format).to eq(
          Ronin::Support::Encoding::Hex.method(:escape)
        )
      end
    end

    context "when given '--format c'" do
      before { subject.parse_options(%w[--format c]) }

      it "must set #format to Ronin::Support::Encoding::C.quote" do
        expect(subject.format).to eq(
          Ronin::Support::Encoding::C.method(:quote)
        )
      end
    end

    context "when given '--format shell'" do
      before { subject.parse_options(%w[--format shell]) }

      it "must set #format to Ronin::Support::Encoding::Shell.quote" do
        expect(subject.format).to eq(
          Ronin::Support::Encoding::Shell.method(:quote)
        )
      end
    end

    context "when given '--format powershell'" do
      before { subject.parse_options(%w[--format powershell]) }

      it "must set #format to Ronin::Support::Encoding::PowerShell.quote" do
        expect(subject.format).to eq(
          Ronin::Support::Encoding::PowerShell.method(:quote)
        )
      end
    end

    context "when given '--format xml'" do
      before { subject.parse_options(%w[--format xml]) }

      it "must set #format to Ronin::Support::Encoding::XML.encode" do
        expect(subject.format).to eq(
          Ronin::Support::Encoding::XML.method(:encode)
        )
      end
    end

    context "when given '--format html'" do
      before { subject.parse_options(%w[--format html]) }

      it "must set #format to Ronin::Support::Encoding::HTML.encode" do
        expect(subject.format).to eq(
          Ronin::Support::Encoding::HTML.method(:encode)
        )
      end
    end

    context "when given '--format js'" do
      before { subject.parse_options(%w[--format js]) }

      it "must set #format to Ronin::Support::Encoding::JS.quote" do
        expect(subject.format).to eq(
          Ronin::Support::Encoding::JS.method(:quote)
        )
      end
    end

    context "when given '--format ruby'" do
      before { subject.parse_options(%w[--format ruby]) }

      it "must set #format to Ronin::Support::Encoding::Ruby.quote" do
        expect(subject.format).to eq(
          Ronin::Support::Encoding::Ruby.method(:quote)
        )
      end
    end
  end

  describe "#format_data" do
    let(:data) { "hello world" }

    context "when #format is set" do
      before { subject.parse_options(%w[--format c]) }

      it "must call #encode on the #format" do
        expect(subject.format_data(data)).to eq(
          Ronin::Support::Encoding::C.quote(data)
        )
      end
    end

    context "when #format is not set" do
      it "must return the data" do
        expect(subject.format_data(data)).to eq(data)
      end
    end
  end

  describe "#print_data" do
    let(:data) { "hello world" }

    let(:stdout) { StringIO.new }
    subject { command_class.new(stdout: stdout) }

    context "when stdout is a TTY" do
      before { expect(stdout).to receive(:tty?).and_return(true) }

      context "when #format is set" do
        before { subject.parse_options(%w[--format html]) }

        it "must print the formatted data" do
          subject.print_data(data)

          expect(stdout.string).to eq(
            "#{Ronin::Support::Encoding::HTML.encode(data)}#{$/}"
          )
        end
      end

      context "when #format is not set" do
        it "must print the unformatted data" do
          subject.print_data(data)

          expect(stdout.string).to eq("#{data}#{$/}")
        end
      end
    end

    context "when stdout not is a TTY" do
      before { expect(stdout).to receive(:tty?).and_return(false) }

      context "when #format is set" do
        before { subject.parse_options(%w[--format html]) }

        it "must print the formatted data without a newline" do
          subject.print_data(data)

          expect(stdout.string).to eq(
            "#{Ronin::Support::Encoding::HTML.encode(data)}"
          )
        end
      end

      context "when #format is not set" do
        it "must print the unformatted data without a newline" do
          subject.print_data(data)

          expect(stdout.string).to eq(data)
        end
      end
    end
  end
end
