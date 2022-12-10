require 'spec_helper'
require 'ronin/payloads/mixins/build_dir'

require 'ronin/payloads/payload'

describe Ronin::Payloads::Mixins::BuildDir do
  module TestBuildDirMixin
    class TestPayload < Ronin::Payloads::Payload
      include Ronin::Payloads::Mixins::BuildDir

      id 'test-payload'

      def build
        @payload = 'built payload'
      end
    end
  end

  let(:payload_class) { TestBuildDirMixin::TestPayload }
  subject { payload_class.new }

  describe "#perform_build" do
    before { subject.perform_build }

    it "must set #build_dir to a temporary directory using the payload ID then build the payload" do
      expect(subject.build_dir).to match(%r{\A/tmp/ronin-payloads-#{payload_class.id}-\d+-\d+-[a-z0-9]+\z})
      expect(File.directory?(subject.build_dir)).to be(true)

      expect(subject.payload).to eq('built payload')
    end

    context "when the payload ID contains a '/'" do
      module TestBuildDirmixin
        class TestPayloadWithDirSeparatorInID < Ronin::Payloads::Payload
          include Ronin::Payloads::Mixins::BuildDir

          id 'test/payload'

          def build
            @payload = 'built payload'
          end
        end
      end

      let(:payload_class) { TestBuildDirmixin::TestPayloadWithDirSeparatorInID }

      it "must replace any '/' characters with a '-'" do
        expect(subject.build_dir).to match(%r{\A/tmp/ronin-payloads-test-payload-\d+-\d+-[a-z0-9]+\z})
      end
    end
  end

  describe "#perform_cleanup" do
    it "must delete #build_dir" do
      subject.perform_build

      build_dir = subject.build_dir

      subject.perform_cleanup

      expect(File.exist?(build_dir)).to be(false)
    end
  end
end
