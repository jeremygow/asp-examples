#!/usr/bin/python

import re
import sys

binary_term = re.compile("(\w+)\(([\d\w]+),([\d\w]+)\)")

def display_facts(facts):
  """turn a list of ansprolog facts into a nice ascii-art diagram"""
  max_x = 1
  max_y = 1
  wall = {}
  gem = {}
  altar = {}

  for fact in facts:
    m = binary_term.match(fact)
    if m:
      functor, x, y = m.groups()
      x, y = int(x), int(y)
      pos = (x,y)
      max_x, max_y = max(x, max_x), max(y, max_y)
      if functor == "wall":
        wall[pos] = True
      elif functor == "gem":
        gem[pos] = True
      elif functor == "altar":
        altar[pos] = True

  def code(x,y):
    """decide how a grid cell should be typeset"""
    pos = (x,y)
    if pos in wall:
      return "W"
    elif pos in gem:
      return "G"
    elif pos in altar:
      return "A"
    else:
      return "."

  for y in range(1,max_y+1):
    print "".join([code(x,y) for x in range(1,max_x+1)])

  #print "".join(wall[1])

def main():
  """look for lines that contain logical facts and try to turn each of those
  into a maze"""
  for line in sys.stdin.xreadlines():
    line = line.strip()
    if line:
      if line[0].islower():
        facts = line.split(' ')
        display_facts(facts)
      else:
        print "% " + line

if __name__ == "__main__":
  main()
