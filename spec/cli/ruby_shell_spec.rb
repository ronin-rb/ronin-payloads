require 'spec_helper'
require 'ronin/payloads/cli/ruby_shell'

describe Ronin::Payloads::CLI::RubyShell do
  describe "#initialize" do
    it "must default #name to 'ronin-payloads'" do
      expect(subject.name).to eq('ronin-payloads')
    end

    it "must default context: to Ronin::Payloads" do
      expect(subject.context).to be_a(Object)
      expect(subject.context).to be_kind_of(Ronin::Payloads)
    end
  end
end
