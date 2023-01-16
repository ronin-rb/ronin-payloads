require 'spec_helper'
require 'ronin/payloads/cli/commands/encode'
require_relative 'man_page_example'

describe Ronin::Payloads::CLI::Commands::Encode do
  include_examples "man_page"
end
