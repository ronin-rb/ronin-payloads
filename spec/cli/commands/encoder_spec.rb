require 'spec_helper'
require 'ronin/payloads/cli/commands/encoder'
require_relative 'man_page_example'

describe Ronin::Payloads::CLI::Commands::Encoder do
  include_examples "man_page"
end
