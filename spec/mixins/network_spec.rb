require 'spec_helper'
require 'ronin/payloads/mixins/network'

require 'ronin/payloads/payload'

describe Ronin::Payloads::Mixins::Network do
  module TestNetworkMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::Network
    end
  end

  let(:payload_class) { TestNetworkMixin::TestPayload }
  subject { payload_class.new }

  describe "#pack_ipv4" do
    context "when given an IPv4 address" do
      let(:ip) { '1.2.3.4' }

      it "must pack the IPv4 address as a 32bit integer in network byte-order" do
        expect(subject.pack_ipv4(ip)).to eq("\x01\x02\x03\x04".b)
      end
    end

    context "when given an IPv6 address" do
      let(:ip) { '::1' }

      it do
        expect {
          subject.pack_ipv4(ip)
        }.to raise_error(ArgumentError,"IP must be an IPv4 address: #{ip.inspect}")
      end
    end
  end

  describe "#pack_ipv6" do
    context "when given an IPv6 address" do
      let(:ip) { '1111:2222:3333:4444:5555:6666:7777:8888' }

      it "must pack the IPv6 address as a 128bit integer in network byte-order" do
        expect(subject.pack_ipv6(ip)).to eq("\x11\x11\x22\x22\x33\x33\x44\x44\x55\x55\x66\x66\x77\x77\x88\x88".b)
      end
    end

    context "when given an IPv4 address" do
      let(:ip) { '1.2.3.4' }

      it do
        expect {
          subject.pack_ipv6(ip)
        }.to raise_error(ArgumentError,"IP must be an IPv6 address: #{ip.inspect}")
      end
    end
  end

  describe "#pack_port" do
    let(:port) { 0xff00 }

    it "must pack the port number as a 16bit integer in network byte-ordeR" do
      expect(subject.pack_port(port)).to eq("\xff\x00".b)
    end
  end
end
