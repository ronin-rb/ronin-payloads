require 'spec_helper'
require 'ronin/payloads/asm_payload'

describe Ronin::Payloads::ASMPayload do
  it "must inherit from Ronin::Payloads::BinaryPayload" do
    expect(described_class.superclass).to be(Ronin::Payloads::BinaryPayload)
  end

  it "must include Ronin::Payloads::Metadata::Arch" do
    expect(described_class).to include(Ronin::Payloads::Metadata::Arch)
  end

  it "must include Ronin::Payloads::Metadata::OS" do
    expect(described_class).to include(Ronin::Payloads::Metadata::OS)
  end

  describe ".assembler" do
    before do
      @as = ENV['AS']
      ENV.delete('AS')
    end

    subject { described_class }

    context "when ENV['AS'] is set" do
      let(:as) { 'arm-linux-gnu-as' }

      before { ENV['AS'] = as }

      it "must return ENV['AS']" do
        expect(subject.assembler).to eq(as)
      end

      after { ENV.delete('AS') }
    end

    context "when ENV['AS'] is not set" do
      it "must return 'as'" do
        expect(subject.assembler).to eq('as')
      end
    end

    after { ENV['AS'] = @as if @as }
  end

  describe "params" do
    subject { described_class }

    it "must define a :as param" do
      expect(subject.params[:assembler]).to_not be_nil
    end

    it "must default the :as param to #{described_class}.as" do
      expect(subject.params[:assembler].default_value).to eq(subject.assembler)
    end
  end

  describe "#assemble" do
    let(:source_files) { %w[foo.s bar.s baz.s] }
    let(:output)       { 'output.o' } 

    it "must call system with params[:assembler], the output and source files" do
      expect(subject).to receive(:system).with(
        subject.params[:assembler],'-o',output,*source_files
      ).and_return(true)

      subject.assemble(*source_files, output: output)
    end

    context "when the defs: keyword argument is given" do
      let(:name1)  { "foo" }
      let(:value1) { "1"   }
      let(:name2)  { "bar" }
      let(:value2) { "2"   }
      let(:defs)   { {name1 => value1, name2 => value2} }

      it "must append the values with '--defsym' flags" do
        expect(subject).to receive(:system).with(
          subject.params[:assembler],
          '-o', output,
          "--defsym", "#{name1}=#{value1}",
          "--defsym", "#{name2}=#{value2}",
          *source_files
        ).and_return(true)

        subject.assemble(*source_files, output: output, defs: defs)
      end
    end

    context "when system() returns false" do
      let(:source_file) { 'foo.s' }

      it do
        allow(subject).to receive(:system).and_return(false)

        expect {
          subject.assemble(source_file, output: output)
        }.to raise_error(Ronin::Payloads::BuildFailed,"assembler command failed: #{subject.params[:assembler]} -o #{output} #{source_file}")
      end
    end

    context "when system() returns nil" do
      let(:source_file) { 'foo.s' }

      it do
        allow(subject).to receive(:system).and_return(nil)

        expect {
          subject.assemble(source_file, output: output)
        }.to raise_error(Ronin::Payloads::BuildFailed,"assembler command not installed")
      end
    end
  end
end
