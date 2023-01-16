require 'spec_helper'
require 'ronin/payloads/cli/commands/list'
require_relative 'man_page_example'

describe Ronin::Payloads::CLI::Commands::List do
  include_examples "man_page"
end
