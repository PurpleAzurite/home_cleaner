import os
import strutils
import sequtils

proc checkAndRemove(path: string) =
    if os.existsDir(path):
      os.removeDir(path)
      echo "Removed directory: ", path

    elif os.existsFile(path):
      os.removeFile(path)
      echo "Removed file: ", path

proc printUsage() =
  echo "Usage: clean [options]"
  echo "\t-v, --version\tDisplay program version information"
  echo "\t-h, --help\tDisplay this message"
  echo "\t-l, --list <p>\tSpecify an alternative list file"

proc main() =
  var listFile = os.getConfigDir() & "clean/files.list"

  let args = os.commandLineParams()
  for idx, val in args:
    if val == "-v" or val == "--version":
      echo "Clean 1.0"
      quit(0)
    elif val == "-h" or val == "--help":
      printUsage()
      quit(0)
    elif val == "-l" or val == "--list":
      if len(args) < idx + 2:
        echo "Please specify a file"
        printUsage()
        quit(3)

      listFile = args[idx + 1]
      echo "Using list file: ", listFile
      break
    else:
      echo "Unknown option: ", val
      quit(1)

  try:
    let list, e = readFile(listFile).split('\n').filter(proc(x: string): bool = len(x) > 0)
    for _, val in list:
      let path = os.getHomeDir() & val
      checkAndRemove(path)

  except IOError:
    echo "Could not read list file: ", listFile
    quit(2)

when isMainModule:
  main()
