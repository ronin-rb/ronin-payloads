require 'spec_helper'
require 'ronin/payloads/cli/commands/launch'
require_relative 'man_page_example'

describe Ronin::Payloads::CLI::Commands::Launch do
  include_examples "man_page"
end
