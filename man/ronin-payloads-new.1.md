# ronin-payloads-new 1 "May 2022" Ronin "User Manuals"

## SYNOPSIS

`ronin-payloads new` [*options*] *FILE*

## DESCRIPTION

Generates a new payload file.

## ARGUMENTS

*FILE*
  The path to the new payload file to generate.

## OPTIONS

`-t`, `--type` `asm|shellcode|c|shell|powershell|html|javascript|typescript|java|sql|php|nodejs`
  The type of payload to generate.

`-a`, `--author` *NAME*
  The name of the author. Defaults to the configured git author name or the
  `USERNAME` environment variable.

`-e`, `--author-email` *EMAIL*
  The email address of the author. Defaults to the configured git author email.

`-S`, `--summary` *TEXT*
  The summary text for the new payload.

`-D`, `--description` *TEXT*
  The description text for the new payload.

`-R`, `--reference` *URL*
  Adds a reference URL to the new payload.

`-h`, `--help`
  Print help information

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>

## SEE ALSO

ronin-payloads-list(1) ronin-payloads-show(1) ronin-payloads-build(1) ronin-payloads-launch(1)
