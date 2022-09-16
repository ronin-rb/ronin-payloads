require 'spec_helper'
require 'ronin/payloads/cli/payload_methods'
require 'ronin/payloads/cli/command'

describe Ronin::Payloads::CLI::PayloadMethods do
  module TestPayloadMethods
    class TestCommand < Ronin::Payloads::CLI::Command
      include Ronin::Payloads::CLI::PayloadMethods
    end
  end

  let(:command_class) { TestPayloadMethods::TestCommand }
  subject { command_class.new }

  describe "#load_payload" do
    let(:name) { 'html/encode' }

    it "must call Payloads.load_class with the given ID" do
      expect(Ronin::Payloads).to receive(:load_class).with(name)
      expect(subject).to_not receive(:exit)

      subject.load_payload(name)
    end

    context "when Ronin::Payloads::ClassNotfound is raised" do
      let(:message) { "class not found" }
      let(:exception) do
        Ronin::Payloads::ClassNotFound.new(message)
      end

      it "must print an error message and exit with an error code" do
        expect(Ronin::Payloads).to receive(:load_class).with(name).and_raise(exception)
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.load_payload(name)
        }.to output("#{subject.command_name}: #{message}#{$/}").to_stderr
      end
    end

    context "when also given a file path" do
      let(:file) { '/path/to/html/encode.rb' }

      it "must call Payloads.load_class with the given ID and file" do
        expect(Ronin::Payloads).to receive(:load_class_from_file).with(name,file)
        expect(subject).to_not receive(:exit)

        subject.load_payload(name,file)
      end

      context "when Ronin::Payloads::ClassNotfound is raised" do
        let(:message) { "class not found" }
        let(:exception) do
          Ronin::Payloads::ClassNotFound.new(message)
        end

        it "must print an error message and exit with an error code" do
          expect(Ronin::Payloads).to receive(:load_class_from_file).with(name,file).and_raise(exception)
          expect(subject).to receive(:exit).with(1)

          expect {
            subject.load_payload(name,file)
          }.to output("#{subject.command_name}: #{message}#{$/}").to_stderr
        end
      end
    end
  end

  describe "#initialie_payload" do
    let(:payload_class) { double('Encoder class') }

    it "must return a new instance of the given payload class" do
      expect(payload_class).to receive(:new)

      subject.initialize_payload(payload_class)
    end

    context "when additional keyword arguments are given" do
      let(:kwargs) do
        {foo: 1, bar: 2}
      end

      it "must pass them to new()" do
        expect(payload_class).to receive(:new).with(**kwargs)

        subject.initialize_payload(payload_class,**kwargs)
      end
    end

    context "when a Core::Params::ParamError is raised" do
      let(:message)   { "param foo was not set" }
      let(:exception) { Ronin::Core::Params::RequiredParam.new(message) }

      it "must print an error message and exit with 1" do
        expect(payload_class).to receive(:new).and_raise(exception)
        expect(subject).to receive(:exit).with(1)

        expect {
          subject.initialize_payload(payload_class)
        }.to output("#{subject.command_name}: #{message}#{$/}").to_stderr
      end
    end
  end
end
