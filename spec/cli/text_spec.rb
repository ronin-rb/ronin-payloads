require 'spec_helper'
require 'ronin/payloads/cli/text'
require 'ronin/payloads/cli/command'

require 'ronin/payloads/binary_payload'
require 'ronin/payloads/asm_payload'
require 'ronin/payloads/shellcode_payload'
require 'ronin/payloads/c_payload'
require 'ronin/payloads/go_payload'
require 'ronin/payloads/rust_payload'
require 'ronin/payloads/java_payload'
require 'ronin/payloads/groovy_payload'
require 'ronin/payloads/javascript_payload'
require 'ronin/payloads/node_js_payload'
require 'ronin/payloads/nashorn_payload'
require 'ronin/payloads/command_payload'
require 'ronin/payloads/shell_command_payload'
require 'ronin/payloads/windows_command_payload'
require 'ronin/payloads/powershell_payload'
require 'ronin/payloads/coldfusion_payload'
require 'ronin/payloads/perl_payload'
require 'ronin/payloads/php_payload'
require 'ronin/payloads/sql_payload'
require 'ronin/payloads/html_payload'
require 'ronin/payloads/xml_payload'
require 'ronin/payloads/mixins/typescript'

describe Ronin::Payloads::CLI::Text do
  module TestCLIText
    class TestCommand < Ronin::Payloads::CLI::Command
      include Ronin::Payloads::CLI::Text
    end
  end

  let(:command_class) { TestCLIText::TestCommand }
  subject { command_class.new }

  describe "#payload_type_name" do
    {
      Ronin::Payloads::HTMLPayload           => 'HTML',
      Ronin::Payloads::XMLPayload            => 'XML',
      Ronin::Payloads::JavaScriptPayload     => 'JavaScript',
      Ronin::Payloads::NodeJSPayload         => 'Node.js',
      Ronin::Payloads::NashornPayload        => 'Nashorn',
      Ronin::Payloads::SQLPayload            => 'SQL',
      Ronin::Payloads::CommandPayload        => 'Command',
      Ronin::Payloads::ShellCommandPayload   => 'Shell Command',
      Ronin::Payloads::WindowsCommandPayload => 'Windows Command',
      Ronin::Payloads::PowerShellPayload     => 'PowerShell',
      Ronin::Payloads::CPayload              => 'C',
      Ronin::Payloads::GoPayload             => 'Go',
      Ronin::Payloads::RustPayload           => 'Rust',
      Ronin::Payloads::JavaPayload           => 'Java',
      Ronin::Payloads::GroovyPayload         => 'Groovy',
      Ronin::Payloads::ColdFusionPayload     => 'ColdFusion',
      Ronin::Payloads::PerlPayload           => 'Perl',
      Ronin::Payloads::PHPPayload            => 'PHP',
      Ronin::Payloads::ASMPayload            => 'ASM',
      Ronin::Payloads::ShellcodePayload      => 'Shellcode',
      Ronin::Payloads::BinaryPayload         => 'Binary',
      Ronin::Payloads::Payload               => 'Custom'
    }.each do |payload_class,type|
      context "when the class inherits from #{payload_class}" do
        let(:klass) { Class.new(payload_class) }
        let(:type)  { type }

        it "must return '#{type}'" do
          expect(subject.payload_type_name(klass)).to eq(type)
        end
      end
    end
  end

  module TestCLIText
    class ExamplePayload < Ronin::Payloads::Payload

      id 'exaple_payload'

      param :foo, String, required: true, desc: 'Foo param'
      param :bar, Integer, required: true, desc: 'Bar param'
      param :baz, Integer, desc: 'Baz param'

    end
  end

  let(:payload_class) { TestCLIText::ExamplePayload }

  describe "#example_payload_command" do
    context "when given a payload class with no params" do
      module TestShowCommand
        class PayloadWithNoParams < Ronin::Payloads::Payload

          id 'payload_with_no_params'

        end
      end

      let(:payload_class) { TestShowCommand::PayloadWithNoParams }

      it "must return 'ronin-payloads build ...' with the payload class ID" do
        expect(subject.example_payload_command(payload_class)).to eq(
          "ronin-payloads build #{payload_class.id}"
        )
      end
    end

    context "but the payload class does have params" do
      context "and none of them are required" do
        module TestShowCommand
          class PayloadWithOptionalParams < Ronin::Payloads::Payload

            id 'payload_with_optional_params'

            param :foo, String, desc: 'Foo param'
            param :bar, Integer, desc: 'Bar param'

          end
        end

        let(:payload_class) { TestShowCommand::PayloadWithOptionalParams }

        it "must not add any '-p' flags to the 'ronin-payloads build' command" do
          expect(subject.example_payload_command(payload_class)).to eq(
            "ronin-payloads build #{payload_class.id}"
          )
        end
      end

      context "and they all have default values" do
        module TestShowCommand
          class PayloadWithDefaultParams < Ronin::Payloads::Payload

            id 'payload_with_default_params'

            param :foo, String, default: 'foo',
                                desc:    'Foo param'

            param :bar, Integer, default: 42,
                                 desc:    'Bar param'

          end
        end

        let(:payload_class) { TestShowCommand::PayloadWithDefaultParams }

        it "must not add any '-p' flags to the 'ronin-payloads build' command" do
          expect(subject.example_payload_command(payload_class)).to eq(
            "ronin-payloads build #{payload_class.id}"
          )
        end
      end

      context "and some are required" do
        context "but they also have default values" do
          module TestShowCommand
            class PayloadWithRequiredAndDefaultParams < Ronin::Payloads::Payload

              id 'payload_with_required_and_default_params'

              param :foo, String, required: true,
                                  default:  'foo',
                                  desc:     'Foo param'

              param :bar, Integer, required: true,
                                   default:  42,
                                   desc:     'Bar param'

            end
          end

          let(:payload_class) { TestShowCommand::PayloadWithRequiredAndDefaultParams }

          it "must not add any '-p' flags to the 'ronin-payloads build' command" do
            expect(subject.example_payload_command(payload_class)).to eq(
              "ronin-payloads build #{payload_class.id}"
            )
          end
        end

        context "but some are required and have no default values" do
          module TestShowCommand
            class PayloadWithRequiredParams < Ronin::Payloads::Payload

              id 'payload_with_required_params'

              param :foo, String, required: true, desc: 'Foo param'
              param :bar, Integer, required: true, desc: 'Bar param'
              param :baz, Integer, desc: 'Baz param'

            end
          end

          let(:payload_class) { TestShowCommand::PayloadWithRequiredParams }

          it "must add '-p' flags followed by the param name and usage to the 'ronin-payloads build' command" do
            expect(subject.example_payload_command(payload_class)).to eq(
              "ronin-payloads build #{payload_class.id} -p foo=FOO -p bar=NUM"
            )
          end
        end
      end
    end

    context "when given the file: keyword argument" do
      let(:file) { 'path/to/payload.rb' }

      it "must return a 'ronin-payloads build --file ...' command with the payload file" do
        expect(subject.example_payload_command(payload_class, file: file)).to eq(
          "ronin-payloads build -f #{file} -p foo=FOO -p bar=NUM"
        )
      end
    end
  end
end
