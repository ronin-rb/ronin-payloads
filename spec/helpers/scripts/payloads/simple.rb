require 'ronin/payloads/payload'

Ronin::Payloads::Payload.object do
  parameter :custom,
            :type => Symbol,
            :default => :func,
            :description => 'Custom value to use in building the payload'

  cache do
    self.name = 'simple'

    author :name => 'Anonymous', :email => 'anonymous@example.com'
  end

  build do
    @raw_payload = "code.#{@custom}"
  end

  def some_method
    :some_result
  end
end
