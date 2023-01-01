### 0.1.0 / 2023-XX-XX

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
