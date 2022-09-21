require 'spec_helper'
require 'ronin/payloads/cli/printing'
require 'ronin/payloads/cli/command'

require 'ronin/payloads/binary_payload'
require 'ronin/payloads/asm_payload'
require 'ronin/payloads/shellcode_payload'
require 'ronin/payloads/c_payload'
require 'ronin/payloads/java_payload'
require 'ronin/payloads/javascript_payload'
require 'ronin/payloads/node_js_payload'
require 'ronin/payloads/shell_payload'
require 'ronin/payloads/powershell_payload'
require 'ronin/payloads/coldfusion_payload'
require 'ronin/payloads/php_payload'
require 'ronin/payloads/sql_payload'
require 'ronin/payloads/html_payload'
require 'ronin/payloads/xml_payload'
require 'ronin/payloads/mixins/typescript'

describe Ronin::Payloads::CLI::Printing do
  module TestCLIPrinting
    class TestCommand < Ronin::Payloads::CLI::Command
      include Ronin::Payloads::CLI::Printing
    end
  end

  let(:command_class) { TestCLIPrinting::TestCommand }
  subject { command_class.new }

  describe "#payload_type" do
    {
      Ronin::Payloads::HTMLPayload         => 'HTML',
      Ronin::Payloads::XMLPayload          => 'XML',
      Ronin::Payloads::JavaScriptPayload   => 'JavaScript',
      Ronin::Payloads::NodeJSPayload       => 'Node.js',
      Ronin::Payloads::SQLPayload          => 'SQL',
      Ronin::Payloads::ShellPayload        => 'Shell',
      Ronin::Payloads::PowerShellPayload   => 'PowerShell',
      Ronin::Payloads::CPayload            => 'C',
      Ronin::Payloads::JavaPayload         => 'Java',
      Ronin::Payloads::ColdFusionPayload   => 'ColdFusion',
      Ronin::Payloads::PHPPayload          => 'PHP',
      Ronin::Payloads::ASMPayload          => 'ASM',
      Ronin::Payloads::ShellcodePayload    => 'Shellcode',
      Ronin::Payloads::BinaryPayload       => 'Binary',
      Ronin::Payloads::Payload             => 'Custom'
    }.each do |payload_class,type|
      context "when the class inherits from #{payload_class}" do
        let(:klass) { Class.new(payload_class) }
        let(:type)  { type }

        it "must return '#{type}'" do
          expect(subject.payload_type(klass)).to eq(type)
        end
      end
    end
  end
end
