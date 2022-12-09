require 'spec_helper'
require 'ronin/payloads/java_payload'

describe Ronin::Payloads::JavaPayload do
  it "must inherit from Ronin::Payloads::Payload" do
    expect(described_class).to be < Ronin::Payloads::Payload
  end

  describe ".javac" do
    subject { described_class }

    context "when ENV['JAVAC'] is set" do
      let(:javac) { '/path/to/javac' }

      before { ENV['JAVAC'] = javac }

      it "must return ENV['JAVAC']" do
        expect(subject.javac).to eq(javac)
      end
    end

    context "when ENV['JAVAC'] is not set" do
      before(:all) do
        @javac = ENV['JAVAC']
        ENV.delete('JAVAC')
      end

      it "must return 'javac'" do
        expect(subject.javac).to eq('javac')
      end

      after(:all) do
        ENV['JAVAC'] = @javac if @javac
      end
    end
  end

  describe "params" do
    subject { described_class }

    it "must define a :javac param" do
      expect(subject.params[:javac]).to_not be_nil
    end

    it "must default the :javac param to #{described_class}.javac" do
      expect(subject.params[:javac].default_value).to eq(subject.javac)
    end
  end

  describe "#compile" do
    let(:source_files) { %w[foo.java bar.java baz.java] }

    it "must call system with params[:javac] and additional arguments" do
      expect(subject).to receive(:system).with(
        subject.params[:javac], *source_files
      ).and_return(true)

      subject.compile(*source_files)
    end

    context "when the dest_dir: keyword argument is given" do
      let(:dest_dir) { '/path/to/dest/dir' }

      it "must pass the `-d` option to the `javac` command" do
        expect(subject).to receive(:system).with(
          subject.params[:javac], '-d', dest_dir, *source_files
        ).and_return(true)

        subject.compile(*source_files, dest_dir: dest_dir)
      end
    end

    context "when system() returns false" do
      let(:source_file) { 'Foo.java' }

      it do
        allow(subject).to receive(:system).and_return(false)

        expect {
          subject.compile(source_file)
        }.to raise_error(Ronin::Payloads::BuildFailed,"javac command failed: #{subject.params[:javac]} #{source_file}")
      end
    end

    context "when system() returns nil" do
      let(:source_file) { 'Foo.java' }

      it do
        allow(subject).to receive(:system).and_return(nil)

        expect {
          subject.compile(source_file)
        }.to raise_error(Ronin::Payloads::BuildFailed,"javac command not installed")
      end
    end
  end
end
