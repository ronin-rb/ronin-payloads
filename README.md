# ronin-payloads

[![CI](https://github.com/ronin-rb/ronin-payloads/actions/workflows/ruby.yml/badge.svg)](https://github.com/ronin-rb/ronin-payloads/actions/workflows/ruby.yml)
[![Code Climate](https://codeclimate.com/github/ronin-rb/ronin-payloads.svg)](https://codeclimate.com/github/ronin-rb/ronin-payloads)

* [Website](https://ronin-rb.dev/)
* [Source](https://github.com/ronin-rb/ronin-payloads)
* [Issues](https://github.com/ronin-rb/ronin-payloads/issues)
* [Documentation](https://ronin-rb.dev/docs/ronin-payloads/frames)
* [Slack](https://ronin-rb.slack.com) |
  [Discord](https://discord.gg/6WAb3PsVX9) |
  [Twitter](https://twitter.com/ronin_rb)

## Description

ronin-payloads is a Ruby micro-framework for writing and running exploit
payloads.

## Features

* Allows defining Payloads as plain-Ruby Classes.
* Provides base classes for a variety of common payloads:
  * {Ronin::Payloads::Payload}
  * {Ronin::Payloads::BinaryPayload}
  * {Ronin::Payloads::ASMPayload}
  * {Ronin::Payloads::Nops}
  * {Ronin::Payloads::Shellcode}
  * {Ronin::Payloads::BindShell}
* Provides classes for various payload-encoding techniques.
* Allows adding additional encoders to payloads.

## Synopsis

List available payloads:

```shell
$ ronin-payloads
```

Print information about a payload:

```shell
$ ronin-payloads list -n NAME -v
```

Build and output a payload:

```shell
$ ronin-payload build NAME
```

Build and output a raw un-escaped payload:

 ```shell
$ ronin-payload build NAME --raw
```

Load a payload from a file, then build and output it:

```shell
$ ronin-payload build -f FILE
```

Generate a boilerplate payload file, with some custom information:

```shell
$ ronin-payloads gen example_payload.rb \
                     --name Example --arch i686 --os Linux \
                     --authors Postmodern --description "This is an example."
```

**Note:** The list of available payload templates are:

* `binary_payload`
* `shellcode`
* `nops`

## Examples

Define a `/bin/sh` shellcode payload:

```ruby
require 'ronin/payloads/shellcode'

class BinShShellcode < Ronin::Payloads::Shellcode

  register 'shellcode-linux-x86-bin-sh'
  version '0.5'
  description <<~DESC
    Shellcode that spawns a local /bin/sh shell
  DESC

  targets_arch :x86
  targets_os   'Linux'

  build do
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
```

Define a payload encoder class:

```ruby
require 'ronin/encoders/encoder'

class Base64Encoder < Ronin::Encoders::Encoder

  register 'text-base64'

  description <<~DESC
    Example base64 payload encoder
  DESC

  targets_arch :x86
  targets_os   'Linux'

  def encode(data)
    data.to_s.base64_encode
  end

end
```

## Requirements

* [Ruby] >= 3.0.0
* [ronin-support] ~> 1.0
* [ronin-code-asm] ~> 1.0
* [ronin-post_ex] ~> 0.1
* [ronin-core] ~> 0.1
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
4. `bundle install`
5. `git checkout -b my_feature`
6. Code It!
7. `bundle exec rake spec`
8. `git push origin my_feature`

## License

Copyright (c) 2007-2013 Hal Brodigan (postmodern.mod3 at gmail.com)

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
[ronin-support]: https://github.com/ronin-rb/ronin-support#readme
[ronin-code-asm]: https://github.com/ronin-rb/ronin-code-asm#readme
[ronin-core]: https://github.com/ronin-rb/ronin-core#readme
[ronin-repos]: https://github.com/ronin-rb/ronin-repos#readme
[ronin-post_ex]: https://github.com/ronin-rb/ronin-post_ex#readme
