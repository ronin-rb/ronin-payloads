require 'spec_helper'
require 'ronin/payloads/cli/encoder_methods'
require 'ronin/payloads/cli/command'

describe Ronin::Payloads::CLI::EncoderMethods do
  module TestEncoderMethods
    class TestCommand < Ronin::Payloads::CLI::Command
      include Ronin::Payloads::CLI::EncoderMethods
    end
  end

  let(:command_class) { TestEncoderMethods::TestCommand }
  subject { command_class.new }

  describe "#encoder_type" do
    context "when given a HTMLEncoder class" do
      module TestEncoderMethods
        class TestHTMLEncoder < Ronin::Payloads::Encoders::HTMLEncoder
        end
      end

      let(:klass) { TestEncoderMethods::TestHTMLEncoder }

      it "must return 'html'" do
        expect(subject.encoder_type(klass)).to eq('html')
      end
    end

    context "when given a JavaScriptEncoder class" do
      module TestEncoderMethods
        class TestJavaScriptEncoder < Ronin::Payloads::Encoders::JavaScriptEncoder
        end
      end

      let(:klass) { TestEncoderMethods::TestJavaScriptEncoder }

      it "must return 'javascript'" do
        expect(subject.encoder_type(klass)).to eq('javascript')
      end
    end

    context "when given a ShellEncoder class" do
      module TestEncoderMethods
        class TestShellEncoder < Ronin::Payloads::Encoders::ShellEncoder
        end
      end

      let(:klass) { TestEncoderMethods::TestShellEncoder }

      it "must return 'shell'" do
        expect(subject.encoder_type(klass)).to eq('shell')
      end
    end

    context "when given a PowerShellEncoder class" do
      module TestEncoderMethods
        class TestPowerShellEncoder < Ronin::Payloads::Encoders::PowerShellEncoder
        end
      end

      let(:klass) { TestEncoderMethods::TestPowerShellEncoder }

      it "must return 'powershell'" do
        expect(subject.encoder_type(klass)).to eq('powershell')
      end
    end

    context "when given a SQLgEncoder class" do
      module TestEncoderMethods
        class TestSQLgEncoder < Ronin::Payloads::Encoders::SQLEncoder
        end
      end

      let(:klass) { TestEncoderMethods::TestSQLgEncoder }

      it "must return 'sql'" do
        expect(subject.encoder_type(klass)).to eq('sql')
      end
    end
  end

  describe "#load_encoder" do
    let(:name) { 'html/encode' }

    it "must call Encoders.load_class with the given ID" do
      expect(Ronin::Payloads::Encoders).to receive(:load_class).with(name)
      expect(subject).to_not receive(:exit)

      subject.load_encoder(name)
    end

    context "when Ronin::Payloads::Encoders::ClassNotfound is raised" do
      let(:message) { "class not found" }
      let(:exception) do
        Ronin::Payloads::Encoders::ClassNotFound.new(message)
      end

      it "must print an error message and exit with an error code" do
        expect(Ronin::Payloads::Encoders).to receive(:load_class).with(name).and_raise(exception)
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.load_encoder(name)
        }.to output("#{subject.command_name}: #{message}#{$/}").to_stderr
      end
    end

    context "when also given a file path" do
      let(:file) { '/path/to/html/encode.rb' }

      it "must call Encoders.load_class with the given ID and file" do
        expect(Ronin::Payloads::Encoders).to receive(:load_class_from_file).with(name,file)
        expect(subject).to_not receive(:exit)

        subject.load_encoder(name,file)
      end

      context "when Ronin::Payloads::Encoders::ClassNotfound is raised" do
        let(:message) { "class not found" }
        let(:exception) do
          Ronin::Payloads::Encoders::ClassNotFound.new(message)
        end

        it "must print an error message and exit with an error code" do
          expect(Ronin::Payloads::Encoders).to receive(:load_class_from_file).with(name,file).and_raise(exception)
          expect(subject).to receive(:exit).with(1)

          expect {
            subject.load_encoder(name,file)
          }.to output("#{subject.command_name}: #{message}#{$/}").to_stderr
        end
      end
    end
  end
end
