import re
import sys
INPUT_FILE_NAME = sys.argv[1]
card_re = re.compile(r'Card +([0-9]+): ([^|]+) \| (.+)')

with open(INPUT_FILE_NAME, 'r') as f_in:
    with open(INPUT_FILE_NAME.replace('txt', 'sql'), 'w') as f_out:
        f_out.write('delete from scratchcard;\n')
        for ln in f_in.readlines():
            m = card_re.match(ln).groups()
            card_id = m[0]
            winning = [v.strip() for v in m[1].split(' ') if v != '']
            draw = [v.strip() for v in m[2].split(' ') if v != '']
            f_out.write("insert into scratchcard (id, winning, draw) values (%s, '{%s}', '{%s}');\n" % (card_id, ','.join(winning), ','.join(draw)))
    