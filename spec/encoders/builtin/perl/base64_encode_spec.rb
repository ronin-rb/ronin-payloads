require 'spec_helper'
require 'ronin/payloads/encoders/builtin/perl/base64_encode'

describe Ronin::Payloads::Encoders::Perl::Base64Encode do
  it "must inherit from Ronin::Payloads::Encoders::PerlEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::PerlEncoder
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'perl/base64_encode'" do
      expect(subject.id).to eq('perl/base64_encode')
    end
  end

  describe "#encode" do
    let(:perl)    { 'print "PWNED\n"' }
    let(:encoded) { %{use MIME::Base64; eval(decode_base64("cHJpbnQgIlBXTkVEXG4i"))} }

    it "must encode the given Perl code as a Base64 string and embed it into the 'use MIME::Base64; eval(decode_base64(\"...\"))' string" do
      expect(subject.encode(perl)).to eq(encoded)
    end
  end
end
