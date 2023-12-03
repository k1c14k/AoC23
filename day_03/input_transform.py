import re
import sys
INPUT_FILE_NAME = sys.argv[1]

part_re = re.compile(r'([0-9]+)')
symbol_re = re.compile(r'([^0-9.])')

with open(INPUT_FILE_NAME, 'r') as f_in:
    with open(INPUT_FILE_NAME.replace('txt', 'sql'), 'w') as f_out:
        y = 0
        f_out.write('delete from part;\n')
        f_out.write('delete from symbol;\n')
        for ln in f_in.readlines():
            y = y + 1
            for m in part_re.finditer(ln):
                f_out.write(f"insert into part (id, y, x_from, x_to) values ({m[0]}, {y}, {m.span(0)[0]}, {m.span(0)[1]-1});\n")
            for m in symbol_re.finditer(ln.strip()):
                f_out.write(f"insert into symbol (y, x, ch) values ({y}, {m.span(0)[0]}, '{m[0]}');\n")