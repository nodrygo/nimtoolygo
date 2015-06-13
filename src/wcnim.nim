import os, streams
var
    buf: array[16384, char]
    count = 0
    maxsize = 16384
    size = 16384

proc countstdin =
  while size > 0:
    size = stdin.readBuffer(addr buf, maxsize)
    for i in 0 .. <size:
      if buf[i] == '\l':
        inc count


proc countextfile(f) =
  try:
    let s = newFileStream(f,fmRead)
    var
      l: TaintedString = ""
    while  readline(s,l):
      inc count
  except:
    echo "FILE NOT EXIST"



proc main(f: string) =
    if f == "" : countstdin() else: countextfile(f)
    echo "Nb lines: ",count

when isMainModule:
   let f = if paramCount() > 0:  paramStr(1) else: ""
   echo "iput file is ",f
   main(f)



