require 'spec_helper'
require 'ronin/gen/generators/payloads/binary_payload'
require 'ronin/payloads/binary_payload'

require 'gen/generators/payloads/payload_examples'
require 'tmpdir'
require 'fileutils'

describe Gen::Generators::Payloads::BinaryPayload do
  before(:all) do
    @path = File.join(Dir.tmpdir,'generated_payload.rb')

    Gen::Generators::Payloads::BinaryPayload.generate(
      {
        :control_methods => ['code_exec']
      },
      [@path]
    )

    @payload = Payloads::BinaryPayload.load_context(@path)
  end

  it_should_behave_like "a Payload"

  it "should define a BinaryPayload" do
    @payload.class.should == Payloads::BinaryPayload
  end

  after(:all) do
    FileUtils.rm(@path)
  end
end
