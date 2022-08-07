require 'spec_helper'
require 'ronin/payloads/encoders'

describe Ronin::Payloads::Encoders do
  it "must include Ronin::Core::ModuleRegistry" do
    expect(subject).to include(Ronin::Core::ModuleRegistry)
  end

  it "must include Ronin::Repos::ModuleDir" do
    expect(subject).to include(Ronin::Repos::ModulesDir)
  end

  it "must set .modules_dir to 'ronin/payloads/encoders/modules'" do
    expect(subject.modules_dir).to eq('ronin/payloads/encoders/modules')
  end

  it "must set .repo_modules_dir to 'encoders'" do
    expect(subject.repo_modules_dir).to eq('encoders')
  end
end
