"""Eval set of the RAG experiment: the seeded incident pool.

Lists the files matching the pool regex in a fixed shuffled order and prints,
for each, every matching line cut to a window around the match, so a reader can
judge inclusion. Writes nothing. Run from the repository root.
"""
import random, re, subprocess, sys

POOL = r'already (filed|in the record|on file|stated in|proved in|recorded)|RETIRED into|was already'
SEED = 20261102
DIRS = ['reviews', 'verification', 'findings', 'results.md']

def pool():
    out = subprocess.run(['git', 'grep', '-lIiE', POOL, '--', *DIRS], capture_output=True, text=True, check=True).stdout.split()
    files = sorted(out)
    random.Random(SEED).shuffle(files)
    return files

def main():
    start, stop = (int(a) for a in sys.argv[1:3]) if len(sys.argv) > 2 else (0, 10)
    rx = re.compile(POOL, re.I)
    files = pool()
    print(f'# pool {len(files)} files, seed {SEED}, showing {start}..{stop - 1}')
    for k, f in enumerate(files[start:stop], start):
        print(f'\n## {k} {f}')
        for n, line in enumerate(open(f, errors='ignore'), 1):
            for m in rx.finditer(line):
                a, b = max(0, m.start() - 170), m.end() + 170
                print(f'  L{n}: ...{line[a:b].strip()}...')

if __name__ == '__main__':
    main()
