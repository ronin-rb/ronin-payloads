require 'spec_helper'
require 'ronin/payloads'
require 'ronin/payloads/root'

describe Ronin::Payloads do
  it "should have a version" do
    expect(subject.const_defined?('VERSION')).to eq(true)
  end

  it "must include Ronin::Core::ClassRegistry" do
    expect(subject).to include(Ronin::Core::ClassRegistry)
  end

  it "must include Ronin::Repos::ClassDir" do
    expect(subject).to include(Ronin::Repos::ClassDir)
  end

  it "must set .class_dir to 'ronin/payloads/builtin'" do
    expect(subject.class_dir).to eq(
      File.join(
        Ronin::Payloads::ROOT, 'lib', 'ronin', 'payloads', 'builtin'
      )
    )
  end

  it "must set .repo_class_dir to 'payloads'" do
    expect(subject.repo_class_dir).to eq('payloads')
  end
end
