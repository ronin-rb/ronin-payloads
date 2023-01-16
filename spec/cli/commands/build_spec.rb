require 'spec_helper'
require 'ronin/payloads/cli/commands/build'
require_relative 'man_page_example'

describe Ronin::Payloads::CLI::Commands::Build do
  include_examples "man_page"
end
