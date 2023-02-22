require 'spec_helper'
require 'ronin/payloads/cli/commands/build'
require_relative 'man_page_example'

describe Ronin::Payloads::CLI::Commands::Build do
  include_examples "man_page"

  describe "#initialize" do
    it "must initialize #encoder_ids to an empty Array" do
      expect(subject.encoder_ids).to eq([])
    end

    it "must initialize #encoder_params to an empty Hash" do
      expect(subject.encoder_params).to eq({})
    end
  end

  describe "options_parser" do
    context "when parsing '--encoder-param encoder.name=value'" do
      let(:encoder)     { 'the_encoder' }
      let(:param_name)  { 'foo' }
      let(:param_value) { 'bar' }

      let(:argv) { ['--encoder-param', "#{encoder}.#{param_name}=#{param_value}"] }
      before { subject.option_parser.parse(argv) }

      it "must add the param name and value to the Hash for the encoder name within #encoder_params" do
        expect(subject.encoder_params).to eq(
          {
            encoder => {param_name => param_value}
          }
        )
      end

      context "when parsing multiple '--encoder-param encoder.name=value' options" do
        let(:encoder)      { 'the_encoder' }
        let(:param_name1)  { 'foo'  }
        let(:param_value1) { 'bar'  }
        let(:param_name2)  { 'baz'  }
        let(:param_value2) { 'quix' }

        let(:argv) do
          [
            '--encoder-param', "#{encoder}.#{param_name1}=#{param_value1}",
            '--encoder-param', "#{encoder}.#{param_name2}=#{param_value2}"
          ]
        end
        before { subject.option_parser.parse(argv) }

        it "must merge the encoder_params together in the same Hash for the encoder name within #encoder_params" do
          expect(subject.encoder_params).to eq(
            {
              encoder => {
                param_name1 => param_value1,
                param_name2 => param_value2
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

      it "must append the encoder name to #encoder_ids" do
        expect(subject.encoder_ids).to eq([encoder1, encoder2])
      end
    end
  end
end
