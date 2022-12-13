require 'spec_helper'
require 'ronin/payloads/mixins/resolve_host'

require 'ronin/payloads/payload'
require 'resolv'

describe Ronin::Payloads::Mixins::ResolveHost do
  module TestResolveHostMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::ResolveHost

      param :host, String, desc: 'The host name'
    end
  end

  let(:host) { 'example.com' }
  let(:ipv4_addresses) { %w[93.184.216.34] }
  let(:ipv6_addresses) { %w[2606:2800:220:1:248:1893:25c8:1946] }
  let(:ip_addresses)   { ipv4_addresses + ipv6_addresses }
  let(:addresses)      { Resolv.getaddresses(host) }

  let(:payload_class) { TestResolveHostMixin::TestPayload }
  subject do
    payload_class.new(
      params: {
        host: host
      }
    )
  end

  describe "#host_addresses" do
    context "when the host has addresses" do
      it "must return the IPv4 and IPv6 addresses for the host" do
        expect(subject.host_addresses).to eq(addresses)
      end
    end

    context "when the host is an IPv4 address" do
      let(:host) { '127.0.0.1' }

      it "must return an Array containing the host" do
        expect(subject.host_addresses).to eq([host])
      end
    end

    context "when the host is an IPv6 address" do
      let(:host) { '::1' }

      it "must return an Array containing the host" do
        expect(subject.host_addresses).to eq([host])
      end
    end

    context "when the host has no addresses" do
      let(:host) { 'does.not.exist' }

      it "must return an empty Array" do
        expect(subject.host_addresses).to eq([])
      end
    end
  end

  describe "#host_address" do
    context "when the host has addresses" do
      it "must return the first IP addresses for the host" do
        expect(addresses).to include(subject.host_address)
      end
    end

    context "when the host is an IPv4 address" do
      let(:host) { '127.0.0.1' }

      it "must return the host" do
        expect(subject.host_address).to eq(host)
      end
    end

    context "when the host is an IPv6 address" do
      let(:host) { '::1' }

      it "must return the host" do
        expect(subject.host_address).to eq(host)
      end
    end

    context "when the host has no addresses" do
      let(:host) { 'does.not.exist' }

      it "must return nil "do
        expect(subject.host_address).to be(nil)
      end
    end
  end

  describe "#host_ip_addresses" do
    context "when the host has addresses" do
      it "must return the IPv4 and IPv6 addresses for the host" do
        expect(subject.host_ip_addresses).to eq(ip_addresses)
      end
    end

    context "when the host is an IPv4 address" do
      let(:host) { '127.0.0.1' }

      it "must return an Array containing the host" do
        expect(subject.host_ip_addresses).to eq([host])
      end
    end

    context "when the host is an IPv6 address" do
      let(:host) { '::1' }

      it "must return an Array containing the host" do
        expect(subject.host_ip_addresses).to eq([host])
      end
    end

    context "when the host has no addresses" do
      let(:host) { 'does.not.exist' }

      it "must return an empty Array" do
        expect(subject.host_ip_addresses).to eq([])
      end
    end
  end

  describe "#host_ip_address" do
    context "when the host has addresses" do
      it "must return the first IP addresses for the host" do
        expect(ip_addresses).to include(subject.host_ip_address)
      end
    end

    context "when the host is an IPv4 address" do
      let(:host) { '127.0.0.1' }

      it "must return the host" do
        expect(subject.host_ip_address).to eq(host)
      end
    end

    context "when the host is an IPv6 address" do
      let(:host) { '::1' }

      it "must return the host" do
        expect(subject.host_ip_address).to eq(host)
      end
    end

    context "when the host has no addresses" do
      let(:host) { 'does.not.exist' }

      it "must return nil "do
        expect(subject.host_ip_address).to be(nil)
      end
    end
  end

  describe "#host_ipv4_addresses" do
    context "when the host has addresses" do
      it "must return the IPv4 addresses for the host" do
        expect(subject.host_ipv4_addresses).to eq(ipv4_addresses)
      end
    end

    context "when the host is an IPv4 address" do
      let(:host) { '127.0.0.1' }

      it "must return an Array containing the host" do
        expect(subject.host_ipv4_addresses).to eq([host])
      end
    end

    context "when the host is an IPv6 address" do
      let(:host) { '::1' }

      it do
        expect {
          subject.host_ipv4_addresses
        }.to raise_error(Ronin::Payloads::ValidationError,"host must be a hostname or an IPv4 address, was an IPv6 address: #{host.inspect}")
      end
    end

    context "when the host only has IPv6 addresses" do
      let(:host) { 'ipv6.wtfismyip.com' }

      it "must return an empty Array" do
        expect(subject.host_ipv4_addresses).to eq([])
      end
    end

    context "when the host has no addresses" do
      let(:host) { 'does.not.exist' }

      it "must return an empty Array" do
        expect(subject.host_ipv4_addresses).to eq([])
      end
    end
  end

  describe "#host_ipv4_address" do
    context "when the host has addresses" do
      it "must return the first IP addresses for the host" do
        expect(ipv4_addresses).to include(subject.host_ipv4_address)
      end
    end

    context "when the host is an IPv4 address" do
      let(:host) { '127.0.0.1' }

      it "must return the host" do
        expect(subject.host_ipv4_address).to eq(host)
      end
    end

    context "when the host is an IPv6 address" do
      let(:host) { '::1' }

      it do
        expect {
          subject.host_ipv4_address
        }.to raise_error(Ronin::Payloads::ValidationError,"host must be a hostname or an IPv4 address, was an IPv6 address: #{host.inspect}")
      end
    end

    context "when the host only has IPv6 addresses" do
      let(:host) { 'ipv6.wtfismyip.com' }

      it "must return nil" do
        expect(subject.host_ipv4_address).to be(nil)
      end
    end

    context "when the host has no addresses" do
      let(:host) { 'does.not.exist' }

      it "must return nil "do
        expect(subject.host_ipv4_address).to be(nil)
      end
    end
  end

  describe "#host_ipv6_addresses" do
    context "when the host has addresses" do
      it "must return the IPv4 and IPv6 addresses for the host" do
        expect(subject.host_ipv6_addresses).to eq(ipv6_addresses)
      end
    end

    context "when the host is an IPv4 address" do
      let(:host) { '127.0.0.1' }

      it do
        expect {
          subject.host_ipv6_addresses
        }.to raise_error(Ronin::Payloads::ValidationError,"host must be a hostname or an IPv6 address, was an IPv4 address: #{host.inspect}")
      end
    end

    context "when the host is an IPv6 address" do
      let(:host) { '::1' }

      it "must return an Array containing the host" do
        expect(subject.host_ipv6_addresses).to eq([host])
      end
    end

    context "when the host only has IPv4 addresses" do
      let(:host) { 'a.resolvers.level3.net' }

      it "must return an empty Array" do
        expect(subject.host_ipv6_addresses).to eq([])
      end
    end

    context "when the host has no addresses" do
      let(:host) { 'does.not.exist' }

      it "must return an empty Array" do
        expect(subject.host_ipv6_addresses).to eq([])
      end
    end
  end

  describe "#host_ipv6_address" do
    context "when the host has addresses" do
      it "must return the first IP addresses for the host" do
        expect(ipv6_addresses).to include(subject.host_ipv6_address)
      end
    end

    context "when the host is an IPv4 address" do
      let(:host) { '127.0.0.1' }

      it do
        expect {
          subject.host_ipv6_addresses
        }.to raise_error(Ronin::Payloads::ValidationError,"host must be a hostname or an IPv6 address, was an IPv4 address: #{host.inspect}")
      end
    end

    context "when the host is an IPv6 address" do
      let(:host) { '::1' }

      it "must return an Array containing the host" do
        expect(subject.host_ipv6_address).to eq(host)
      end
    end

    context "when the host only has IPv4 addresses" do
      let(:host) { 'a.resolvers.level3.net' }

      it "must return nil" do
        expect(subject.host_ipv6_address).to be(nil)
      end
    end

    context "when the host has no addresses" do
      let(:host) { 'does.not.exist' }

      it "must return nil "do
        expect(subject.host_ipv6_address).to be(nil)
      end
    end
  end
end
