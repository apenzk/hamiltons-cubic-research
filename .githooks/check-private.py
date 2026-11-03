#!/usr/bin/env python3
"""Privacy check: refuse to publish private material on main.

    python3 .githooks/check-private.py

Reads every tracked file and reports a line holding a forbidden string, a secret pattern
or an email address outside the allowed ones, then exits 1 on any finding. The pre-commit
hook runs it on main only, so work branches commit freely and the squash onto main is
what gets checked.

The forbidden strings name private material, so they live outside the repository, one
per line in ~/.config/hamiltons-cubic/forbidden.txt (or the file $FORBIDDEN_LIST names),
with `allow <file> <string>` lines waiving one string in one file. Without that file the
check fails, since a missing list would otherwise pass everything.
"""
import os, re, subprocess, sys
from pathlib import Path

SECRETS = [re.compile(x) for x in [r'sk-ant-[A-Za-z0-9_-]{10,}', r'ghp_[A-Za-z0-9]{20,}', r'AKIA[0-9A-Z]{16}',
                                   r'BEGIN [A-Z ]*PRIVATE KEY', r'xox[bp]-[A-Za-z0-9-]+']]
EMAIL = re.compile(r'[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+(?:\.[A-Za-z0-9-]+)*'
                   r'\.(?:com|org|net|edu|gov|de|se|es|cn|uk|fr|it|io|jp|ch|at|nl|ca|au|ru|pl|be|dk|no|fi|il|kr|in|br|mx|eu|info)\b')
EMAIL_ALLOWED = ['aaa@aaa.com', 'users.noreply.github.com']
LIST = Path(os.environ.get('FORBIDDEN_LIST', Path.home() / '.config/hamiltons-cubic/forbidden.txt'))


def load():
    forbidden, allow = [], set()
    for line in LIST.read_text(encoding='utf-8').splitlines():
        if not line.strip() or line.startswith('#'):
            continue
        if line.startswith('allow '):
            _, rel, word = line.split(' ', 2)
            allow.add((rel, word))
        else:
            forbidden.append(line.strip())
    return forbidden, allow


def main():
    if not LIST.exists():
        sys.exit(f'check-private: {LIST} is missing, so nothing can be checked. Copy it from the private '
                 'repository before committing on main.')
    forbidden, allow = load()
    files = subprocess.run(['git', 'ls-files', '-z'], capture_output=True, text=True, check=True).stdout.split('\0')
    hits = []
    for rel in filter(None, files):
        try:
            text = open(rel, encoding='utf-8').read()
        except (UnicodeDecodeError, FileNotFoundError, IsADirectoryError):
            continue
        for i, line in enumerate(text.split('\n'), 1):
            hits += [f'{rel}:{i}: forbidden string' for w in forbidden if w in line and (rel, w) not in allow]
            hits += [f'{rel}:{i}: secret pattern' for rx in SECRETS if rx.search(line)]
            hits += [f'{rel}:{i}: email {m.group(0)}' for m in EMAIL.finditer(line)
                     if not any(a in m.group(0) for a in EMAIL_ALLOWED)]
    print('\n'.join(hits[:50]) or 'check-private: clean')
    if len(hits) > 50:
        print(f'... {len(hits) - 50} more')
    sys.exit(1 if hits else 0)


if __name__ == '__main__':
    main()
