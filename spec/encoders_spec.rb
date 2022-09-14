require 'spec_helper'
require 'ronin/payloads/encoders'

describe Ronin::Payloads::Encoders do
  it "must include Ronin::Core::ClassRegistry" do
    expect(subject).to include(Ronin::Core::ClassRegistry)
  end

  it "must include Ronin::Repos::ClassDir" do
    expect(subject).to include(Ronin::Repos::ClassDir)
  end

  it "must set .class_dir to 'ronin/payloads/encoders/builtin'" do
    expect(subject.class_dir).to eq('ronin/payloads/encoders/builtin')
  end

  it "must set .repo_class_dir to 'encoders'" do
    expect(subject.repo_class_dir).to eq('encoders')
  end
end
