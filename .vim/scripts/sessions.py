# sessions.py - Takes 3 files and combines them into one
# author: Ben Simner 
# date: Di, 03 Mrz 2015
#
# python sessions.py src session0 session1 dest
# takes session0 diff session1 union src and places it in dest

import sys

src = sys.argv[1]
f0 = sys.argv[2]
f1 = sys.argv[3]
f2 = sys.argv[4]

f2_lines = []

with open(src) as f_src:
    with open(f0) as f0:
        with open(f1) as f1:
            s = f_src.readline()
            l = f0.readline()
            for line in f1:
                #print(s, l, line)
                if (s == line):
                    s = f_src.readline()
                    f2_lines.append(line)
                elif (l != line):
                    f2_lines.append(line)
                
                if (l == line):
                    l = f0.readline()
            
with open(f2, 'w') as f:
    f.writelines(f2_lines)
