require 'spec_helper'
require 'ronin/payloads/javascript_payload'

describe Ronin::Payloads::JavaScriptPayload do
  describe ".encoder_class" do
    subject { described_class }

    it do
      expect(subject.encoder_class).to be(Ronin::Payloads::Encoders::JavaScriptEncoder)
    end
  end

  describe "#to_html" do
    class TestJavaScriptPayloadToHtml < Ronin::Payloads::JavaScriptPayload

      def build
        @payload = "alert(1)"
      end

    end

    let(:payload_class) { TestJavaScriptPayloadToHtml }
    subject { payload_class.new }

    it "must wrap the built payload in '<script type=\"text/javascript\">...</script>'" do
      expect(subject.to_html).to eq(
        %{<script type="text/javascript">#{subject}</script>}
      )
    end
  end
end
