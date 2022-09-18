require 'spec_helper'
require 'ronin/payloads/typescript_payload'

describe Ronin::Payloads::TypeScriptPayload do
  it "must inherit from Ronin::Payloads::JavaScriptPayload" do
    expect(described_class).to be < Ronin::Payloads::JavaScriptPayload
  end

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
    subject { described_class }

    it "must define a :tsc param" do
      expect(subject.params[:tsc]).to_not be_nil
    end

    it "must default the :tsc param to #{described_class}.tsc" do
      expect(subject.params[:tsc].default_value).to eq(subject.tsc)
    end
  end

  describe "#compile" do
    let(:source_files) { %w[foo.ts bar.ts baz.ts] }

    it "must call system with params[:tsc] and additional source files" do
      expect(subject).to receive(:system).with(
        subject.params[:tsc], *source_files
      )

      subject.compile(*source_files)
    end
  end
end
