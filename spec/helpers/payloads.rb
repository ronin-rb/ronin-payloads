require 'ronin/payloads/payload'

module Helpers
  PAYLOADS_DIR = File.expand_path(File.join(File.dirname(__FILE__),'scripts','payloads'))

  def load_payload(name,base=Ronin::Payloads::Payload)
    base.load_object(File.join(PAYLOADS_DIR,"#{name}.rb"))
  end
end
