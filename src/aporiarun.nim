import os, osproc, strutils, parseopt2

const version = "V0.1"

proc writeVersion() =
     echo "aporiarun version is "&version
     quit 0

var
  filename = ""

for kind, key, val in getopt():
  case kind
  of cmdArgument:
    filename = key
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h":
      echo """
 aporiarun [options] <file>
   if filename exist start with this file
   [OPTIONS]
   --help -h     -> this help & quit
   --version -v  -> print version & quit
 """
      quit 0
    of "version", "v": writeVersion()
  of cmdEnd: assert(false) # cannot happen
if filename != "":
   filename = expandFilename(filename)
   # todo check if filename exist if not create it

discard execCmd("killall nimsuggest")
discard execCmd("/home/ygo/devygo/nim/Aporia/aporia "&filename)

