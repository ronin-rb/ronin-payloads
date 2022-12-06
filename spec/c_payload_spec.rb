require 'spec_helper'
require 'ronin/payloads/c_payload'

describe Ronin::Payloads::CPayload do
  it "must inherit from Ronin::Payloads::BinaryPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::BinaryPayload)
  end

  describe ".cc" do
    subject { described_class }

    before do
      @cc = ENV['CC']
      ENV.delete('CC')
    end

    context "when ENV['CC'] is set" do
      let(:cc) { 'gcc' }

      before { ENV['CC'] = cc }

      it "must return ENV['CC']" do
        expect(subject.cc).to eq(cc)
      end

      after { ENV.delete('CC') }
    end

    context "when ENV['CC'] is not set" do
      it "must return 'cc'" do
        expect(subject.cc).to eq('cc')
      end
    end

    after { ENV['CC'] = @cc if @cc }
  end

  describe "params" do
    subject { described_class }

    it "must define a :cc param" do
      expect(subject.params[:cc]).to_not be_nil
    end

    it "must default the :cc param to #{described_class}.cc" do
      expect(subject.params[:cc].default_value).to eq(subject.cc)
    end
  end

  describe "#compile" do
    let(:source_files) { %w[foo.c bar.c baz.c] }
    let(:output)       { 'output' } 

    it "must call system with params[:cc], the output and source files" do
      expect(subject).to receive(:system).with(
        subject.params[:cc],'-o',output,*source_files
      )

      subject.compile(*source_files, output: output)
    end

    context "when the defs: keyword argument is given" do
      let(:def1) { 'foo' }
      let(:def2) { 'bar=baz' }
      let(:defs) { [def1, def2] }

      it "must append the values with '-D' flags" do
        expect(subject).to receive(:system).with(
          subject.params[:cc],'-o',output,"-D#{def1}","-D#{def2}",*source_files
        )

        subject.compile(*source_files, output: output, defs: defs)
      end
    end
  end
end
