import json
import sys

source = sys.argv[1]
target = sys.argv[2]

with open(source) as f:
    lines = f.readlines()

rhythms = map(lambda x: int(x.split(",")[2]), lines)
with open(target, "w") as fwrite:
    json.dump(list(rhythms), fwrite)
