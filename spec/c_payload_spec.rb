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

  describe "#compile_c" do
    let(:source_files) { %w[foo.c bar.c baz.c] }
    let(:output)       { 'output' }

    it "must call system with params[:cc], the output and source files" do
      expect(subject).to receive(:system).with(
        subject.params[:cc],'-o',output,*source_files
      ).and_return(true)

      subject.compile_c(*source_files, output: output)
    end

    context "when the defs: keyword argument is given" do
      context "and it's an Array" do
        let(:def1) { 'foo' }
        let(:def2) { 'bar=baz' }
        let(:defs) { [def1, def2] }

        it "must append the values with '-D' flags" do
          expect(subject).to receive(:system).with(
            subject.params[:cc],
            '-o', output,
            "-D#{def1}",
            "-D#{def2}",
            *source_files
          ).and_return(true)

          subject.compile_c(*source_files, output: output, defs: defs)
        end
      end

      context "and it's a Hash" do
        let(:name1)  { "foo" }
        let(:value1) { "1"   }
        let(:name2)  { "bar" }
        let(:value2) { "2"   }

        let(:def1) { "#{name1}=#{value1}" }
        let(:def2) { "#{name2}=#{value2}" }
        let(:defs) { {name1 => value1, name2 => value2} }

        it "must append the values with '-D' flags" do
          expect(subject).to receive(:system).with(
            subject.params[:cc],
            '-o', output,
            "-D#{def1}",
            "-D#{def2}",
            *source_files
          ).and_return(true)

          subject.compile_c(*source_files, output: output, defs: defs)
        end
      end

      context "but it's not an Array or a Hash" do
        let(:defs) { Object.new }

        it do
          expect {
            subject.compile_c(*source_files, output: output, defs: defs)
          }.to raise_error(ArgumentError,"defs must be either an Array or a Hash: #{defs.inspect}")
        end
      end
    end

    context "when system() returns false" do
      let(:source_file) { 'foo.go' }

      it do
        allow(subject).to receive(:system).and_return(false)

        expect {
          subject.compile_c(source_file, output: output)
        }.to raise_error(Ronin::Payloads::BuildFailed,"cc command failed: #{subject.params[:cc]} -o #{output} #{source_file}")
      end
    end

    context "when system() returns nil" do
      let(:source_file) { 'foo.go' }

      it do
        allow(subject).to receive(:system).and_return(nil)

        expect {
          subject.compile_c(source_file, output: output)
        }.to raise_error(Ronin::Payloads::BuildFailed,"cc command not installed")
      end
    end
  end
end
