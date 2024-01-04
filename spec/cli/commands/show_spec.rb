require 'spec_helper'
require 'ronin/payloads/cli/commands/show'
require_relative 'man_page_example'

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

describe Ronin::Payloads::CLI::Commands::Show do
  include_examples "man_page"

  module TestShowCommand
    class ExamplePayload < Ronin::Payloads::Payload

      id 'exaple_payload'

      param :foo, String, required: true, desc: 'Foo param'
      param :bar, Integer, required: true, desc: 'Bar param'
      param :baz, Integer, desc: 'Baz param'

    end
  end

  let(:payload_class) { TestShowCommand::ExamplePayload }

  describe "#print_payload_usage" do
    it "must print 'Usage:' followed by an example 'ronin-payloads build' command" do
      expect {
        subject.print_payload_usage(payload_class)
      }.to output(
        [
          "Usage:",
          "",
          "  $ ronin-payloads build #{payload_class.id} -p foo=FOO -p bar=NUM",
          "",
          ""
        ].join($/)
      ).to_stdout
    end
  end

  describe "#example_build_command" do
    context "when given a payload class with no params" do
      module TestShowCommand
        class PayloadWithNoParams < Ronin::Payloads::Payload

          id 'payload_with_no_params'

        end
      end

      let(:payload_class) { TestShowCommand::PayloadWithNoParams }

      it "must return 'ronin-payloads build ...' with the payload class ID" do
        expect(subject.example_build_command(payload_class)).to eq(
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
          expect(subject.example_build_command(payload_class)).to eq(
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
          expect(subject.example_build_command(payload_class)).to eq(
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
            expect(subject.example_build_command(payload_class)).to eq(
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
            expect(subject.example_build_command(payload_class)).to eq(
              "ronin-payloads build #{payload_class.id} -p foo=FOO -p bar=NUM"
            )
          end
        end
      end
    end

    context "when the payload is loaded via the '--file' option" do
      let(:payload_file) { 'path/to/payload.rb' }

      before { subject.options[:file] = payload_file }

      it "must return a 'ronin-payloads build --file ...' command with the payload file" do
        expect(subject.example_build_command(payload_class)).to eq(
          "ronin-payloads build -f #{payload_file} -p foo=FOO -p bar=NUM"
        )
      end
    end
  end
end
