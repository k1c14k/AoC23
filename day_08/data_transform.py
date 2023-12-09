import re
import sys

line_re = re.compile(r"([A-Z]+) = \(([A-Z]+), ([A-Z]+)\)")

INPUT_FILE_NAME = sys.argv[1]

with open(INPUT_FILE_NAME, 'r') as f_in:
    with open(INPUT_FILE_NAME.replace('txt', 'sql'), 'w') as f_out:
        f_out.write("""delete from instructions;
delete from node;
""")
        lines = f_in.readlines()
        instructions = ','.join(["'%s'" % c for c in [*lines[0]] if c != '\n'])
        f_out.write(f"insert into instructions values (ARRAY [{instructions}]);\n")
        for ln in lines[2:]:
            line = line_re.match(ln)
            f_out.write(f"insert into node values ('{line[1]}', '{line[2]}', '{line[3]}');\n")
