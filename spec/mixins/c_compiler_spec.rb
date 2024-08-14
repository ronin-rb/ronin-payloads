require 'spec_helper'
require 'ronin/payloads/mixins/c_compiler'
require 'ronin/payloads/payload'

describe Ronin::Payloads::Mixins::CCompiler do
  module TestCCMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::CCompiler
    end
  end

  let(:payload_class) { TestCCMixin::TestPayload }

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
      it "must return nil" do
        expect(subject.cc).to be(nil)
      end
    end

    after { ENV['CC'] = @cc if @cc }
  end

  describe "params" do
    subject { payload_class }

    it "must define a :cc param" do
      expect(subject.params[:cc]).to_not be_nil
    end

    it "must default the :cc param to #{described_class}.cc" do
      expect(subject.params[:cc].default_value).to eq(described_class.cc)
    end

    it "must define a :c_compiler param" do
      expect(subject.params[:c_compiler]).to_not be_nil
    end

    it "must define a :arch param" do
      expect(subject.params[:arch]).to_not be_nil
    end

    it "must define a :vendor param" do
      expect(subject.params[:vendor]).to_not be_nil
    end

    it "must define a :os param" do
      expect(subject.params[:os]).to_not be_nil
    end
  end

  subject { payload_class.new }

  describe "#target_arch" do
    context "when the arch param is set" do
      let(:arch) { 'arm' }

      subject do
        payload_class.new(params: {arch: arch})
      end

      it "must return the arch param as a String" do
        expect(subject.target_arch).to eq(arch.to_s)
      end

      context "and it's :x86-64" do
        let(:arch) { :"x86-64" }

        it "must return 'x86_64'" do
          expect(subject.target_arch).to eq('x86_64')
        end
      end
    end

    context "when the arch param is not set" do
      it "must return nil" do
        expect(subject.target_arch).to be(nil)
      end
    end
  end

  describe "#target_vendor" do
    context "when the vendor param is set" do
      let(:vendor) { :pc }

      subject do
        payload_class.new(params: {vendor: vendor})
      end

      it "must return the vendor param as a String" do
        expect(subject.target_vendor).to eq(vendor.to_s)
      end

      context "but the os param is :windows" do
        subject do
          payload_class.new(params: {vendor: vendor, os: :windows})
        end

        it "must return 'w64'" do
          expect(subject.target_vendor).to eq('w64')
        end
      end
    end

    context "when the vendor param is not set" do
      it "must return nil" do
        expect(subject.target_vendor).to be(nil)
      end
    end
  end

  describe "#target_os" do
    context "when the os param is set" do
      let(:os) { :freebsd }

      subject do
        payload_class.new(params: {os: os})
      end

      it "must return the os param as a String" do
        expect(subject.target_os).to eq(os.to_s)
      end

      context "and it's :linux" do
        let(:os) { :linux }

        it "must return 'linux-gnu'" do
          expect(subject.target_os).to eq('linux-gnu')
        end
      end

      context "and it's :windows" do
        let(:os) { :windows }

        it "must return 'mingw32'" do
          expect(subject.target_os).to eq('mingw32')
        end
      end
    end
  end

  describe "#target_platform" do
    context "when both the arch and os params are set" do
      let(:arch) { 'x86-64' }
      let(:os)   { :linux   }

      subject do
        payload_class.new(params: {arch: arch, os: os})
      end

      it "must return a target triple of the format 'arch-os'" do
        expect(subject.target_platform).to eq('x86_64-linux-gnu')
      end
    end

    context "when both the arch, vendor, and os params are set" do
      let(:arch)   { 'x86-64' }
      let(:vendor) { :pc }
      let(:os)     { :linux }

      subject do
        payload_class.new(params: {arch: arch, vendor: vendor, os: os})
      end

      it "must return a target triple of the format 'arch-vendor-os'" do
        expect(subject.target_platform).to eq('x86_64-pc-linux-gnu')
      end
    end

    context "otherwise" do
      it "must return nil" do
        expect(subject.target_platform).to be(nil)
      end
    end
  end

  describe "#cc" do
    context "when the cc param is set" do
      let(:cc) { 'clang-13' }

      subject do
        payload_class.new(params: {cc: cc})
      end

      it "must return the cc param" do
        expect(subject.cc).to eq(cc)
      end
    end

    context "when the cc param is not set" do
      context "and when c_compiler is set to :gcc" do
        let(:c_compiler) { :gcc }

        subject do
          payload_class.new(params: {c_compiler: c_compiler})
        end

        it "must return 'gcc'" do
          expect(subject.cc).to eq('gcc')
        end

        context "and when the arch and os params are set" do
          let(:arch) { 'x86-64' }
          let(:os)   { :linux   }

          subject do
            payload_class.new(
              params: {
                c_compiler: c_compiler,

                arch: arch,
                os:   os
              }
            )
          end

          it "must return the gcc command for the target platform" do
            expect(subject.cc).to eq("x86_64-linux-gnu-gcc")
          end
        end

        context "and when the arch, vendor, and os params are set" do
          let(:arch)   { 'x86-64' }
          let(:vendor) { :pc }
          let(:os)     { :linux }

          subject do
            payload_class.new(
              params: {
                c_compiler: c_compiler,

                arch:   arch,
                vendor: vendor,
                os:     os
              }
            )
          end

          it "must return the gcc command for the target platform" do
            expect(subject.cc).to eq("x86_64-pc-linux-gnu-gcc")
          end
        end
      end

      context "and when c_compiler is set to :clang" do
        let(:c_compiler) { :clang }

        subject do
          payload_class.new(params: {c_compiler: c_compiler})
        end

        it "must return 'clang'" do
          expect(subject.cc).to eq('clang')
        end
      end
    end
  end

  describe "#compile_c" do
    let(:source_files) { %w[foo.c bar.c baz.c] }
    let(:output)       { 'output' }

    it "must call system with #cc, the output and source files" do
      expect(subject).to receive(:system).with(
        subject.cc,'-o',output,*source_files
      ).and_return(true)

      subject.compile_c(*source_files, output: output)
    end

    context "when the c_compiler param is set to :clang" do
      context "and the arch and os params are set" do
        let(:arch) { 'x86-64' }
        let(:os)   { :linux   }

        subject do
          payload_class.new(
            params: {
              c_compiler: :clang,

              arch: arch,
              os:   os
            }
          )
        end

        it "must add the '-target <triple>' option to the command with the #target_platform" do
          expect(subject).to receive(:system).with(
            subject.cc,
            '-target', subject.target_platform,
            '-o', output,
            *source_files
          ).and_return(true)

          subject.compile_c(*source_files, output: output)
        end
      end

      context "and the arch, vendor, and os params are set" do
        let(:arch)   { 'x86-64' }
        let(:vendor) { :pc }
        let(:os)     { :linux }

        subject do
          payload_class.new(
            params: {
              c_compiler: :clang,

              arch:   arch,
              vendor: vendor,
              os:     os
            }
          )
        end

        it "must add the '-target <triple>' option to the command with the #target_platform" do
          expect(subject).to receive(:system).with(
            subject.cc,
            '-target', subject.target_platform,
            '-o', output,
            *source_files
          ).and_return(true)

          subject.compile_c(*source_files, output: output)
        end
      end
    end

    context "when the defs: keyword argument is given" do
      context "and it's an Array" do
        let(:def1) { 'foo' }
        let(:def2) { 'bar=baz' }
        let(:defs) { [def1, def2] }

        it "must append the values with '-D' flags" do
          expect(subject).to receive(:system).with(
            subject.cc,
            "-D#{def1}",
            "-D#{def2}",
            '-o', output,
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
            subject.cc,
            "-D#{def1}",
            "-D#{def2}",
            '-o', output,
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

    context "when the libs: keyword argument is given" do
      let(:lib1) { 'foo' }
      let(:lib2) { 'bar' }
      let(:libs) { [lib1, lib2] }

      it "must append the values with '-l' flags" do
        expect(subject).to receive(:system).with(
          subject.cc,
          '-o', output,
          *source_files,
          "-l#{lib1}",
          "-l#{lib2}"
        ).and_return(true)

        subject.compile_c(*source_files, output: output, libs: libs)
      end
    end

    context "when system() returns false" do
      let(:source_file) { 'foo.go' }

      it do
        allow(subject).to receive(:system).and_return(false)

        expect {
          subject.compile_c(source_file, output: output)
        }.to raise_error(Ronin::Payloads::BuildFailed,/\A(?:gcc|clang|cc) command failed: #{subject.cc} -o #{output} #{source_file}\z/)
      end
    end

    context "when system() returns nil" do
      let(:source_file) { 'foo.go' }

      it do
        allow(subject).to receive(:system).and_return(nil)

        expect {
          subject.compile_c(source_file, output: output)
        }.to raise_error(Ronin::Payloads::BuildFailed,/\A(?:gcc|clang|cc) command not installed\z/)
      end
    end
  end
end
