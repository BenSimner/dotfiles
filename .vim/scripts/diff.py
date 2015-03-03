import sys
f0 = sys.argv[1]
f1 = sys.argv[2]

f2 = sys.argv[3]

f0_lines = []
f1_lines = []
f2_lines = []

with open(f0) as f0:
    with open(f1) as f1:
        l = f1.readline()
        for line in f0:
            if (line.strip() == l.strip()):
                l = f1.readline()
            else:
                f2_lines.append(line)
            
with open(f2, 'w') as f:
    f.writelines(f2_lines)
