require 'spec_helper'
require 'ronin/payloads/encoders/encoder'

describe Ronin::Payloads::Encoders::Encoder do
  it "must include Ronin::Core::Metadata::ModuleName" do
    expect(described_class).to include(Ronin::Core::Metadata::ModuleName)
  end

  it "must include Ronin::Core::Metadata::Summary" do
    expect(described_class).to include(Ronin::Core::Metadata::Summary)
  end

  it "must include Ronin::Core::Metadata::Description" do
    expect(described_class).to include(Ronin::Core::Metadata::Description)
  end

  it "must include Ronin::Core::Metadata::References" do
    expect(described_class).to include(Ronin::Core::Metadata::References)
  end

  it "must include Ronin::Core::Params::Mixin" do
    expect(described_class).to include(Ronin::Core::Params::Mixin)
  end

  describe "#encode" do
    let(:data) { "data" }

    it "must raise NotImplementedError by default" do
      expect {
        subject.encode(data)
      }.to raise_error(NotImplementedError,"#{described_class}#encode was not implemented")
    end
  end
end
