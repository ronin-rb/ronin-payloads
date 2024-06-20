### 0.1.5 / 2024-06-19

* Fixed order of arguments passed to `TCPServer.new` in
  {Ronin::Payloads::Mixins::ReverseShell#perform_prelaunch} which was preventing
  reverse shells from opening a local TCP server socket.

#### Payloads

* Fixed the module namespace for the {Ronin::Payloads::CMD::Node::ReverseShell}
  payload (aka `cmd/node/reverse_shell`).

#### CLI

* Automatically create the parent directory of the new payload file,
  if it doesn't exist, when running `ronin-payloads new path/to/new_payload.rb`.
* Fixed typo in `ronin-payloads encode` man-page for the `-E,--encoder` option.

### 0.1.4 / 2023-09-19

#### CLI

* All newly generated payload files using `ronin-payloads new` should have a
  `summary` and a `description`.
* Fixed a bug where the `ronin-payloads new` options `--author`,
  `--author-email`, or `--summary` were not properly escaping given values.

### 0.1.3 / 2023-06-12

#### CLI 

* Fixed a bug where `ronin-payloads new --type command`  wasn't being accepted
  as a valid payload type.

### 0.1.2 / 2023-06-09

* Add missing `require` for {Ronin::Payloads::Encoders::Encoder}.
* Added missing descriptions to built-in payloads (@ervinismu).
* Documentation fixes and improvements.

#### CLI

* Fixed the placeholder `references` URLs in the `ronin-payloads new` template.
* Fixed `--format html` and `--format xml` to encode every character.

### 0.1.1 / 2023-03-01

* Default the `host` param defined by {Ronin::Payloads::Mixins::BindShell} to
  `0.0.0.0`.

#### CLI

* Fixed multiple bugs in the `--param` option of the `ronin-payloads encode`
  comand.
* Fixed multiple bugs in the `--encoder-param` option of
  the `ronin-payloads build` command.

### 0.1.0 / 2023-02-01

* Initial release:
  * Require `ruby` >= 3.0.0.
  * Provides a succinct syntax and API for writing payloads in as few lines as
    possible.
  * Supports defining Payloads as plain old Ruby classes.
  * Provides base classes for a variety of languages and payload types
   (ASM, Shellcode, C, Go, Rust, Java, JSP, PHP, Python, Ruby, NodeJS, Shell,
    PowerShell, SQL, XML, HTML, URL).
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
    * Java
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
  * Supports adding additional encoders to payloads for further obfuscation.
  * Integrates with the [Ronin Post-Exploitation][ronin-post_ex] library.
  * Provides a simple CLI for building, encoding, launching, and generating new
    payloads.

[ronin-post_ex]: https://github.com/ronin-rb/ronin-post_ex#readme
