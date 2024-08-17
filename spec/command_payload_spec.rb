require 'spec_helper'
require 'ronin/payloads/command_payload'

describe Ronin::Payloads::CommandPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class.superclass).to be(Ronin::Payloads::Payload)
  end

  it "must include Ronin::Payloads::Metadata::OS" do
    expect(described_class).to include(Ronin::Payloads::Metadata::OS)
  end

  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::CommandEncoder)
    end
  end

  module TestCommandPayload
    class TestPayload < Ronin::Payloads::CommandPayload

      def build
        @payload = "ls -la"
      end

    end
  end

  let(:payload_class) { TestCommandPayload::TestPayload }
  subject { payload_class.new }

  describe "#to_php" do
    it "must convert the built command into a PHP string that is passed to 'system(\"...\")'" do
      php_escaped_string = Ronin::Support::Encoding::PHP.quote(subject.to_s)

      expect(subject.to_php).to eq("system(#{php_escaped_string})")
    end
  end

  describe "#to_ruby" do
    it "must convert the built command into a Ruby string that is passed to 'system(\"...\")'" do
      ruby_escaped_string = Ronin::Support::Encoding::Ruby.quote(subject.to_s)

      expect(subject.to_ruby).to eq("system(#{ruby_escaped_string})")
    end
  end

  describe "#to_node_js" do
    it "must convert the built command into a Node.js string that is passed to 'exec(\"...\",(error,stdout,stderr)=>{console.log(stdout);});'" do
      node_js_escaped_string = Ronin::Support::Encoding::NodeJS.quote(subject.to_s)

      expect(subject.to_node_js).to eq("exec(#{node_js_escaped_string},(error,stdout,stderr)=>{console.log(stdout);});")
    end
  end

  describe "#to_command" do
    it "must return #to_s" do
      expect(subject.to_command).to eq(subject.to_s)
    end
  end
end
