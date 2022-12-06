# ronin-payloads-build 1 "May 2022" Ronin "User Manuals"

## SYNOPSIS

`ronin-payloads build` [*options*] {`--file` *FILE* \| *NAME*}

## DESCRIPTION

Loads and builds a payload.

## ARGUMENTS

*NAME*
  The name of the payload to load.

## OPTIONS

`-f`, `--file` *FILE*
  Optionally loads the payload from the file.

`-F`, `--format` `c`\|`shell`\|`powershell`\|`xml`\|`html`\|`js`\|`ruby`
  Formats the built payload for another programming language.

`-p`, `--param` *NAME*`=`*VALUE*
  Sets a param for the payload.

`-o`, `--output` *FILE*
  Writes the built payload to the given file instead of printing it to stdout.

`-e`, `--encoder` *ENCODER*
  Adds the encoder to the payload's encoder pipeline.

`--encoder-param` *ENCODER*`.`*NAME*`.`*VALUE*
  Sets a param on the given encoder.

`-D`, `--debug`
  Enables debugging messages.

`-h`, `--help`
  Print help information

## AUTHOR

Postmodern <postmodern.mod3@gmail.com>

## SEE ALSO

ronin-payloads-list(1) ronin-payloads-show(1) ronin-payloads-launch(1)
