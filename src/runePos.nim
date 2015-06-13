import  os
import unicode
include "system/inclrtl"

## Get Rune at position (and not buffer char)
## let s = "az€rt"
## echo  runeAtPos(s, 3)  -> is r
## echo  runeAt(s,3)      -> has no meaning
proc runeAtPos*(s: string, pos:int): string =
  var i = -1
  for r in runes(s):
    inc(i)
    if i == pos:
      return  $r

## take a slice from a rune string
##  let s = "az€r™tλγq"
##  echo runeSlice(s, 2, 5)  -> "€r™tλ"
proc runeSlice*(s: string, start:int, len:int): string =
  var i = -1
  var le = len
  var res:string =""
  if start+len > runeLen(s):
    res = "" # raise "runeSlice illegal len"
  else:
    for r in runes(s):
      inc(i)
      if i >= start and le > 0:
        dec(le)
        res = res & $r
  return $res


when isMainModule:
  let s = "az€r™tλγq"
  discard """ var
     r: Rune
     i = 2
  fastRuneAt(s,i,r,true)
  echo "r is ",r """
  assert  runeAtPos(s, 0)  ==  "a"
  assert  runeAtPos(s, 1)  ==  "z"
  assert  runeAtPos(s, 2)  ==  "€"
  assert  runeAtPos(s, 3)  ==  "r"
  assert  runeAtPos(s, 4)  ==  "™"
  assert  runeAtPos(s, 5)  ==  "t"
  assert  runeAtPos(s, 6)  ==  "λ"
  assert  runeAtPos(s, 7)  ==  "γ"
  assert  runeAtPos(s, 8)  ==  "q"
  assert  runeAtPos(s, 10)  ==  nil
  assert  runeSlice(s, 2, 5) == "€r™tλ"
