require 'spec_helper'
require 'ronin/payloads/encoders/builtin/perl/hex_encode'

describe Ronin::Payloads::Encoders::Perl::HexEncode do
  it "must inherit from Ronin::Payloads::Encoders::PerlEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::PerlEncoder
  end

  describe "#encode" do
    let(:perl)    { 'print "PWNED\n"' }
    let(:encoded) { %{eval(pack("H*","7072696e74202250574e45445c6e22"))} }

    it "must encode the given Perl code as a hex string and embed it into the 'eval(pack(\"H*\",\"...\"))' string" do
      expect(subject.encode(perl)).to eq(encoded)
    end
  end
end
