require 'spec_helper'
require 'ronin/payloads/shellcode/bind_shell_payload'

describe Ronin::Payloads::Shellcode::BindShellPayload do
  module TestBindShellPayload
    class TestBindShell < Ronin::Payloads::Shellcode::BindShellPayload
    end
  end

  let(:host) { 'example.com' }
  let(:port) { 1337 }

  let(:payload_class) { TestBindShellPayload::TestBindShell }
  subject do
    payload_class.new(
      params: {
        host: host,
        port: port
      }
    )
  end

  it "must include Ronin::Payloads::Mixins::BindShell" do
    expect(described_class).to include(Ronin::Payloads::Mixins::BindShell)
  end

  it "must include Ronin::Payloads::Mixins::ResolveHost" do
    expect(described_class).to include(Ronin::Payloads::Mixins::ResolveHost)
  end

  it "must include Ronin::Payloads::Mixins::Network" do
    expect(described_class).to include(Ronin::Payloads::Mixins::Network)
  end

  describe "#packed_port" do
    let(:port) { 0xff00 }

    it "must return the packed port number as a 16bit integer in network byte-ordeR" do
      expect(subject.packed_port).to eq("\xff\x00".b)
    end
  end
end
