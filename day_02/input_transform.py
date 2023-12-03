import re
import sys
INPUT_FILE_NAME = sys.argv[1]

game_re = re.compile(r'Game ([0-9]+): (.*)')
subset_re = re.compile(r'([0-9]+) (red|green|blue)')

def parse_game(ln: str, f_out):
    groups = game_re.match(ln).groups()
    game_id = groups[0]
    f_out.write(f"INSERT INTO game (id) VALUES ({game_id});\n")
    subset_n = 0
    for subset in groups[1].split(';'):
        subset_n = subset_n + 1
        blue =0
        red = 0
        green = 0
        for m in subset_re.finditer(subset):
            if m[2] == 'blue':
                blue = blue + int(m[1])
            elif m[2] == 'red':
                red = red + int(m[1])
            elif m[2] == 'green':
                green = green + int(m[1])
        f_out.write(f"INSERT INTO game_subset (subset, game_id, red, green, blue) VALUES ({subset_n}, {game_id}, {red}, {green}, {blue});\n")


with open(INPUT_FILE_NAME, 'r') as f:
    with open(INPUT_FILE_NAME.replace('txt', 'sql'), 'w') as f_out:
        f_out.write("""delete from game_subset;
delete from game;
""")
        for ln in f.readlines():
            parse_game(ln.strip(), f_out)