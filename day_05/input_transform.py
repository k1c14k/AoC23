import re
import sys

INPUT_FILE_NAME = sys.argv[1]
CATEGORIES = {'seed': 1, 'soil': 2, 'fertilizer': 3, 'water': 4, 'light': 5, 'temperature': 6, 'humidity': 7,
              'location': 8}

with open(INPUT_FILE_NAME, 'r') as f_in:
    with open(INPUT_FILE_NAME.replace('txt', 'sql'), 'w') as f_out:
        f_out.write('delete from mapping;\n')
        f_out.write('delete from component;\n')
        f_out.write('delete from component_range;\n')
        ln = f_in.readline()
        seed_ids = re.findall(r'([0-9]+)', ln)
        for seed_id in seed_ids:
            f_out.write(f"insert into component (id, category_id) values ({seed_id}, 1);\n")
        for pair in zip(*(iter(seed_ids),)*2):
            f_out.write(f"insert into component_range (id, range, category_id) values ({pair[0]}, {pair[1]}, 1);\n")
        source = None
        target = None
        for ln in f_in:
            if ln == '\n':
                continue
            elif ln.endswith(' map:\n'):
                ln = re.match(r'(.+)-to-(.+) map:', ln)
                source = CATEGORIES[ln[1]]
                target = CATEGORIES[ln[2]]
            else:
                ln = re.match(r'([0-9]+) +([0-9]+) +([0-9]+)', ln)
                f_out.write(f"insert into mapping (source, target, target_id, id, range) values ({source}, {target}, {ln[1]}, {ln[2]}, {ln[3]});\n")
