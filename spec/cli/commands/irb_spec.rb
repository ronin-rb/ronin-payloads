require 'spec_helper'
require 'ronin/payloads/cli/commands/irb'
require_relative 'man_page_example'

describe Ronin::Payloads::CLI::Commands::Irb do
  include_examples "man_page"
end
