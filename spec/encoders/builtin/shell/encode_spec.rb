require 'spec_helper'
require 'ronin/payloads/encoders/builtin/shell/encode'

describe Ronin::Payloads::Encoders::Shell::Encode do
  it "must inherit from Ronin::Payloads::Encoders::ShellEncoder" do
    expect(described_class).to be < Ronin::Payloads::Encoders::ShellEncoder
  end

  describe "#encode" do
    let(:data)    { "hello world" }
    let(:encoded) { "\\x68\\x65\\x6c\\x6c\\x6f\\x20\\x77\\x6f\\x72\\x6c\\x64" }

    it "must shell encode each character" do
      expect(subject.encode(data)).to eq(encoded)
    end
  end
end
