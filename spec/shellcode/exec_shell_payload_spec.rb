require 'spec_helper'
require 'ronin/payloads/shellcode/exec_shell_payload'

describe Ronin::Payloads::Shellcode::ExecShellPayload do
  it "must inherit from Ronin::Payloads::ShellcodePayload " do
    expect(described_class).to be < Ronin::Payloads::ShellcodePayload
  end
end
