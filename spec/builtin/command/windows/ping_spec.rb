require 'spec_helper'
require 'ronin/payloads/builtin/command/windows/ping'

describe Ronin::Payloads::Command::Windows::Ping do
  it "must inherit from Ronin::Payloads::WindowsCommandPayload" do
    expect(described_class).to be < Ronin::Payloads::WindowsCommandPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'command/windows/ping'" do
      expect(subject.id).to eq('command/windows/ping')
    end
  end

  describe "#build" do
    before { subject.build }

    it "must set #payload to 'ping -n 4 127.0.0.1'" do
      expect(subject.payload).to eq("ping -n 4 127.0.0.1")
    end

    context "when the host param is changed" do
      let(:host) { 'example.com' }

      before do
        subject.params[:host] = host
        subject.build
      end

      it "must change the host argument in the #payload" do
        expect(subject.payload).to eq("ping -n 4 #{host}")
      end
    end

    context "when the count param is changed" do
      let(:count) { 10 }

      before do
        subject.params[:count] = count
        subject.build
      end

      it "must change the `-n` value in the #payload" do
        expect(subject.payload).to eq("ping -n #{count} 127.0.0.1")
      end
    end
  end
end
