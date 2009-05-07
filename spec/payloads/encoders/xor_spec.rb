require 'ronin/payloads/encoders/xor'

require 'spec_helper'

describe Ronin do
  describe Payloads::Encoders::XOR do
    before(:all) do
      @data = "\x00\x01\x90ABC123[]{}'"
    end

    it "should encode-out unwanted characters" do
      disallow = [0x00, 0x01, 0x90]
      xor = Payloads::Encoders::XOR.new(:disallow => disallow)

      xor.call(@data).each_byte do |b|
        disallow.include?(b).should_not == true
      end
    end
  end
end
