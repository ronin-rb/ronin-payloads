require 'spec_helper'
require 'ronin/payloads/cli/commands/encode'
require_relative 'man_page_example'

describe Ronin::Payloads::CLI::Commands::Encode do
  include_examples "man_page"

  describe "#initialize" do
    it "must initialize #encoders to an empty Array" do
      expect(subject.encoders).to eq([])
    end

    it "must initialize #params to an empty Hash" do
      expect(subject.params).to eq({})
    end
  end

  describe "options_parser" do
    context "when parsing '--param encoder.name=value'" do
      let(:encoder)     { 'the_encoder' }
      let(:param_name)  { 'foo' }
      let(:param_value) { 'bar' }

      let(:argv) { ['--param', "#{encoder}.#{param_name}=#{param_value}"] }
      before { subject.option_parser.parse(argv) }

      it "must add the param name and value to the Hash for the encoder name within #params" do
        expect(subject.params).to eq(
          {
            encoder => {param_name.to_sym => param_value}
          }
        )
      end

      context "when parsing multiple '--param encoder.name=value' options" do
        let(:encoder)      { 'the_encoder' }
        let(:param_name1)  { 'foo'  }
        let(:param_value1) { 'bar'  }
        let(:param_name2)  { 'baz'  }
        let(:param_value2) { 'quix' }

        let(:argv) do
          [
            '--param', "#{encoder}.#{param_name1}=#{param_value1}",
            '--param', "#{encoder}.#{param_name2}=#{param_value2}"
          ]
        end
        before { subject.option_parser.parse(argv) }

        it "must merge the params together in the same Hash for the encoder name within #params" do
          expect(subject.params).to eq(
            {
              encoder => {
                param_name1.to_sym => param_value1,
                param_name2.to_sym => param_value2
              }
            }
          )
        end
      end
    end

    context "when parsing '--encoder ENCODER' options" do
      let(:encoder1) { 'encoder1' }
      let(:encoder2) { 'encoder2' }
      let(:argv)     { ['--encoder', encoder1, '--encoder', encoder2] }

      before { subject.option_parser.parse(argv) }

      it "must append the encoder name to #encoders" do
        expect(subject.encoders).to eq([encoder1, encoder2])
      end
    end
  end
end
