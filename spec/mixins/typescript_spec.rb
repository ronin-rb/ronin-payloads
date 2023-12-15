require 'spec_helper'
require 'ronin/payloads/mixins/typescript'
require 'ronin/payloads/javascript_payload'

describe Ronin::Payloads::Mixins::TypeScript do
  module TestTypeScriptMixin
    class TestPayload < Ronin::Payloads::JavaScriptPayload
      include Ronin::Payloads::Mixins::TypeScript
    end
  end

  let(:payload_class) { TestTypeScriptMixin::TestPayload }

  describe ".tsc" do
    subject { described_class }

    context "when ENV['TSC'] is set" do
      let(:tsc) { 'tsc' }

      before { ENV['TSC'] = tsc }

      it "must return ENV['TSC']" do
        expect(subject.tsc).to eq(tsc)
      end
    end

    context "when ENV['TSC'] is not set" do
      before(:all) do
        @tsc = ENV['TSC']
        ENV.delete('TSC')
      end

      it "must return 'tsc'" do
        expect(subject.tsc).to eq('tsc')
      end

      after(:all) do
        ENV['TSC'] = @tsc if @tsc
      end
    end
  end

  describe "params" do
    subject { payload_class }

    it "must define a :tsc param" do
      expect(subject.params[:tsc]).to_not be_nil
    end

    it "must default the :tsc param to #{described_class}.tsc" do
      expect(subject.params[:tsc].default_value).to eq(described_class.tsc)
    end
  end

  subject { payload_class.new }

  describe "#compile_ts" do
    let(:source_files) { %w[foo.ts bar.ts baz.ts] }

    it "must call system with params[:tsc] and additional source files" do
      expect(subject).to receive(:system).with(
        subject.params[:tsc], *source_files
      ).and_return(true)

      subject.compile_ts(*source_files)
    end

    context "when system() returns false" do
      let(:source_file) { 'foo.ts' }

      it do
        allow(subject).to receive(:system).and_return(false)

        expect {
          subject.compile_ts(source_file)
        }.to raise_error(Ronin::Payloads::BuildFailed,"tsc command failed: #{subject.params[:tsc]} #{source_file}")
      end
    end

    context "when system() returns nil" do
      let(:source_file) { 'foo.rs' }

      it do
        allow(subject).to receive(:system).and_return(nil)

        expect {
          subject.compile_ts(source_file)
        }.to raise_error(Ronin::Payloads::BuildFailed,"tsc command not installed")
      end
    end
  end
end
