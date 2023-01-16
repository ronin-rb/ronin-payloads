require 'spec_helper'
require 'ronin/payloads/cli/commands/new'
require_relative 'man_page_example'

describe Ronin::Payloads::CLI::Commands::New do
  include_examples "man_page"
end
