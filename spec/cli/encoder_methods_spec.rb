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

    context "when given a SQLEncoder class" do
      module TestEncoderMethods
        class TestSQLEncoder < Ronin::Payloads::Encoders::SQLEncoder
        end
      end

      let(:klass) { TestEncoderMethods::TestSQLEncoder }

      it "must return 'sql'" do
        expect(subject.encoder_type(klass)).to eq('sql')
      end
    end

    context "when given a XMLEncoder class" do
      module TestEncoderMethods
        class TestXMLEncoder < Ronin::Payloads::Encoders::XMLEncoder
        end
      end

      let(:klass) { TestEncoderMethods::TestXMLEncoder }

      it "must return 'xml'" do
        expect(subject.encoder_type(klass)).to eq('xml')
      end
    end
  end

  describe "#load_encoder" do
    let(:encoder_id) { 'html/encode' }

    it "must call Encoders.load_class with the given ID" do
      expect(Ronin::Payloads::Encoders).to receive(:load_class).with(encoder_id)
      expect(subject).to_not receive(:exit)

      subject.load_encoder(encoder_id)
    end

    context "when Ronin::Payloads::Encoders::ClassNotfound is raised" do
      let(:message) { "class not found" }
      let(:exception) do
        Ronin::Payloads::Encoders::ClassNotFound.new(message)
      end

      it "must print an error message and exit with an error code" do
        expect(Ronin::Payloads::Encoders).to receive(:load_class).with(encoder_id).and_raise(exception)
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.load_encoder(encoder_id)
        }.to output("#{subject.command_name}: #{message}#{$/}").to_stderr
      end
    end

    context "when another type of exception is raised" do
      let(:message)   { "unexpected error" }
      let(:exception) { RuntimeError.new(message) }

      it "must print the exception, an error message, and exit with -1" do
        expect(Ronin::Payloads::Encoders).to receive(:load_class).with(encoder_id).and_raise(exception)
        expect(subject).to receive(:print_exception).with(exception)
        expect(subject).to receive(:exit).with(-1)

        expect {
          subject.load_encoder(encoder_id)
        }.to output("#{subject.command_name}: an unhandled exception occurred while loading encoder #{encoder_id}#{$/}").to_stderr
      end
    end
  end

  describe "#load_encoder_from" do
    let(:file) { '/path/to/html/encode.rb' }

    it "must call Payloads.load_class with the given ID and file" do
      expect(Ronin::Payloads::Encoders).to receive(:load_class_from_file).with(file)
      expect(subject).to_not receive(:exit)

      subject.load_encoder_from(file)
    end

    context "when Ronin::Payloads::ClassNotfound is raised" do
      let(:message) { "class not found" }
      let(:exception) do
        Ronin::Payloads::Encoders::ClassNotFound.new(message)
      end

      it "must print an error message and exit with an error code" do
        expect(Ronin::Payloads::Encoders).to receive(:load_class_from_file).with(file).and_raise(exception)
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.load_encoder_from(file)
        }.to output("#{subject.command_name}: #{message}#{$/}").to_stderr
      end
    end

    context "when another type of exception is raised" do
      let(:message)   { "unexpected error" }
      let(:exception) { RuntimeError.new(message) }

      it "must print the exception, an error message, and exit with -1" do
        expect(Ronin::Payloads::Encoders).to receive(:load_class_from_file).with(file).and_raise(exception)
        expect(subject).to receive(:print_exception).with(exception)
        expect(subject).to receive(:exit).with(-1)

        expect {
          subject.load_encoder_from(file)
        }.to output(
          "#{subject.command_name}: an unhandled exception occurred while loading encoder from file #{file}#{$/}"
        ).to_stderr
      end
    end
  end

  describe "#initialie_encoder" do
    let(:encoder_id)    { 'test' }
    let(:encoder_class) { double('Encoder class', id: encoder_id) }

    it "must return a new instance of the given encoder class" do
      expect(encoder_class).to receive(:new)

      subject.initialize_encoder(encoder_class)
    end

    context "when additional keyword arguments are given" do
      let(:kwargs) do
        {foo: 1, bar: 2}
      end

      it "must pass them to new()" do
        expect(encoder_class).to receive(:new).with(**kwargs)

        subject.initialize_encoder(encoder_class,**kwargs)
      end
    end

    context "when a Core::Params::ParamError is raised" do
      let(:message)   { "param foo was not set" }
      let(:exception) { Ronin::Core::Params::RequiredParam.new(message) }

      it "must print an error message and exit with 1" do
        expect(encoder_class).to receive(:new).and_raise(exception)
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.initialize_encoder(encoder_class)
        }.to output("#{subject.command_name}: #{message}#{$/}").to_stderr
      end
    end

    context "when another type of exception is raised" do
      let(:message)   { "unexpected error" }
      let(:exception) { RuntimeError.new(message) }

      it "must print the exception, an error message, and exit with -1" do
        expect(encoder_class).to receive(:new).and_raise(exception)
        expect(subject).to receive(:print_exception).with(exception)
        expect(subject).to receive(:exit).with(-1)

        expect {
          subject.initialize_encoder(encoder_class)
        }.to output("#{subject.command_name}: an unhandled exception occurred while initializing encoder #{encoder_id}#{$/}").to_stderr
      end
    end
  end

  describe "#validate_encoder" do
    let(:encoder_id) { 'test' }
    let(:encoder)    { double('Encoder instance', class_id: encoder_id) }

    it "must return a new instance of the given encoder class" do
      expect(encoder).to receive(:validate)

      subject.validate_encoder(encoder)
    end

    context "when a Core::Params::ParamError is raised" do
      let(:message)   { "param foo was not set" }
      let(:exception) { Ronin::Core::Params::RequiredParam.new(message) }

      it "must print an error message and exit with 1" do
        expect(encoder).to receive(:validate).and_raise(exception)
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.validate_encoder(encoder)
        }.to output("#{subject.command_name}: failed to validate the encoder #{encoder_id}: #{message}#{$/}").to_stderr
      end
    end

    context "when a Ronin::Payloads::Encoders::ValidationError is raised" do
      let(:message)   { "param foo was not set" }
      let(:exception) do
        Ronin::Payloads::Encoders::ValidationError.new(message)
      end

      it "must print an error message and exit with 1" do
        expect(encoder).to receive(:validate).and_raise(exception)
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.validate_encoder(encoder)
        }.to output("#{subject.command_name}: failed to validate the encoder #{encoder_id}: #{message}#{$/}").to_stderr
      end
    end

    context "when another type of exception is raised" do
      let(:message)   { "unexpected error" }
      let(:exception) { RuntimeError.new(message) }

      it "must print the exception, an error message, and exit with -1" do
        expect(encoder).to receive(:validate).and_raise(exception)
        expect(subject).to receive(:print_exception).with(exception)
        expect(subject).to receive(:exit).with(-1)

        expect {
          subject.validate_encoder(encoder)
        }.to output("#{subject.command_name}: an unhandled exception occurred while validating the encoder #{encoder_id}#{$/}").to_stderr
      end
    end
  end
end
