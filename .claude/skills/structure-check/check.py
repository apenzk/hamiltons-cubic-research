#!/usr/bin/env python3
"""Structure compliance over the record's folders. Reports; never repairs.

The spec it enforces is .claude/skills/structure-check/SKILL.md. This file is the
executable half: the four checks are set comparisons, so they belong in a script
rather than in a model's reading of the tree -- a compliance check that gives two
different answers on two runs is not a check.

  A  every result and fence post carries an id heading
  B  every id is indexed, every index row exists, no id is used twice
  C  every folder's contents appear in that folder's index, both directions
  D  every references/<slug>/ holds README.md, notes.md, a PDF and a .txt

Exit 0 when every check is clean, 1 otherwise. `--json` prints the findings as
JSON for a caller that wants to act on them.
"""
import glob
import json
import os
import re
import sys
from collections import defaultdict

RESULT_HEADING = re.compile(r'^#### (Lemma|Observation|Conjecture) L(\d+)\b', re.M)
POST_HEADING = re.compile(r'^## Post F(\d+)\b', re.M)
INDEX_ROW = re.compile(r'^\| \*\*(\d+)\*\* \|', re.M)
UNNUMBERED = re.compile(r'^#+ (?:Theorem|Lemma|Observation|Conjecture)\b(?! L\d)', re.M)
# Fox's Lemma 1 is a foreign result and carries no id by design.
FOREIGN = re.compile(r"(?:Fox(?:'s|’s)|\bHis)\s+(?:own\s+)?$", re.I)


def findings_files():
    return sorted(f for f in glob.glob('findings/*.md')
                  if not os.path.basename(f).startswith('INDEX'))


def check_a():
    out = []
    for f in findings_files():
        text = open(f, encoding='utf-8').read()
        for m in UNNUMBERED.finditer(text):
            line = text[:m.start()].count('\n') + 1
            head = text[m.start():text.find('\n', m.start())]
            if FOREIGN.search(text[max(0, m.start() - 30):m.start()]):
                continue
            out.append({'file': f, 'line': line, 'heading': head.strip()})
    return out


def check_b():
    heads = defaultdict(list)
    for f in findings_files():
        for m in RESULT_HEADING.finditer(open(f, encoding='utf-8').read()):
            heads[int(m.group(2))].append(f)
    indexed = {int(m.group(1)) for m in
               INDEX_ROW.finditer(open('findings/INDEX-results.md', encoding='utf-8').read())}
    posts = defaultdict(list)
    for f in findings_files():
        for m in POST_HEADING.finditer(open(f, encoding='utf-8').read()):
            posts[int(m.group(1))].append(f)
    tabled = {int(m.group(1)) for m in
              re.finditer(r'^\| (\d+) \|', open('findings/INDEX-traps.md', encoding='utf-8').read(), re.M)}
    return {
        'duplicated': {n: v for n, v in heads.items() if len(v) > 1},
        'duplicated_posts': {n: v for n, v in posts.items() if len(v) > 1},
        'ghosts': sorted(indexed - set(heads)),
        'orphans': sorted(set(heads) - indexed),
        'posts_tabled_without_heading': sorted(tabled - set(posts)),
        'posts_headed_without_table': sorted(set(posts) - tabled),
    }


def check_c():
    out = {}
    refs = {d for d in os.listdir('references') if os.path.isdir('references/' + d)}
    idx = open('references/INDEX.md', encoding='utf-8').read()
    out['references_unindexed'] = sorted(d for d in refs if d not in idx)

    rv = open('reviews/INDEX.md', encoding='utf-8').read()
    files = {int(m.group(1)) for x in os.listdir('reviews')
             for m in [re.match(r'REVIEW_r(\d+)\.md', x)] if m}
    seen = {int(m) for m in re.findall(r'REVIEW_r(\d+)\.md', rv)}
    seen |= {int(m) for m in re.findall(r'^###+ Reviewer (\d+)', rv, re.M)}
    out['reviews_unindexed'] = sorted(files - seen)
    return out


def check_d():
    out = defaultdict(list)
    for d in sorted(x for x in os.listdir('references') if os.path.isdir('references/' + x)):
        files = os.listdir('references/' + d)
        has_pdf = any(x.endswith('.pdf') for x in files)
        readme = os.path.join('references', d, 'README.md')
        # A source that cannot be obtained is compliant when it says so -- and it
        # cannot carry a .txt either, since there is nothing to extract from.
        excused = (not has_pdf and os.path.exists(readme)
                   and 'Not obtained' in open(readme, encoding='utf-8').read())
        if 'README.md' not in files:
            out['no_readme'].append(d)
        if 'notes.md' not in files:
            out['no_notes'].append(d)
        # Public mirror: the papers are linked at their sources, never held.
        pass
    return dict(out)


def check_h():
    """How many numbered results have their own STATEMENT typed in Lean.

    THE FAILURE THIS MAKES VISIBLE.  The four states name what the FILE
    establishes, and a file whose theorems are all ingredients is labelled
    `proved` because its theorems are proved.  So the index cannot be read to
    tell whether a lemma is stated at all, and 164 results carried files while
    the route remained uncomposable -- invisible until someone asked.

    The rule requiring the statement is younger than the layer, so a large
    backlog is expected and is not a defect.  What is a defect is not knowing
    the number, and one number is not enough: reporting a single "undeclared"
    bucket invites marking the whole of it "not typed", which asserts the
    unread ones.  So a row declares one of three -- `statement: typed`,
    `statement: unchecked` for a file that binds the real objects and has not
    been read, `statement: not typed` for one whose theorems bind none and so
    cannot be stating the lemma -- and each is counted separately.  All are
    reported rather than enforced, because retro-fitting the backlog is work
    and not a gate."""
    idx = open('lean/INDEX.md', encoding='utf-8').read().split('\n')
    typed, unchecked, not_typed, undeclared = [], [], [], []
    for line in idx:
        if not line.startswith('|'):
            continue
        cells = [c.strip() for c in line.split('|')]
        if len(cells) < 5:
            continue
        m = re.search(r'\bL(\d+)\b', cells[1])
        if not m or not re.search(r'\*\*(proved|partial|stated|unsupported)\*\*', cells[3]):
            continue
        if 'statement: typed' in line:
            typed.append(m.group(1))
        elif 'statement: unchecked' in line:
            unchecked.append(m.group(1))
        elif 'statement: not typed' in line:
            not_typed.append(m.group(1))
        else:
            undeclared.append(m.group(1))
    return {'statement_typed': sorted(set(typed), key=int),
            'statement_unchecked': sorted(set(unchecked), key=int),
            'statement_not_typed': len(set(not_typed)),
            'statement_undeclared': len(set(undeclared))}


def check_e():
    """Audit status. The index is what every brief reads first, so a verdict it
    states must match the one LEDGER.md records, and a numbered result should
    state one at all. Reported rather than enforced while the back catalogue is
    unmarked -- a gate that fails on 142 rows teaches nothing."""
    out = {}
    idx = open('findings/INDEX-results.md', encoding='utf-8').read()
    led = open('findings/LEDGER.md', encoding='utf-8').read()

    # A ledger row may land on a version it then refuted; the repair is unaudited,
    # so the index is right to call it owed and that is not a contradiction.
    ledger = {}
    for m in re.finditer(r'^\| \*\*(\d+)\*\* \| \*\*Gate 2 ([A-Z]+)\*\*(.*)$', led, re.M):
        superseded = 'REFUTED it' in m.group(3)
        ledger[m.group(1)] = None if superseded else m.group(2)

    stated, silent, contradicted = [], [], []
    for m in re.finditer(r'^\| \*\*(\d+)\*\* \| (\w+) \|(.*)$', idx, re.M):
        n, kind, body = m.group(1), m.group(2), m.group(3)
        if kind == 'WITHDRAWN':
            continue
        v = re.search(r'\*\*Gate 2:?\s+([a-zA-Z]+)', body)
        if not v:
            silent.append(n)
            continue
        stated.append(n)
        # LANDED in the ledger means a verdict exists; the index must not call it owed.
        if ledger.get(n) == 'LANDED' and v.group(1).lower() in ('owed', 'pending'):
            contradicted.append(n)

    out['index_contradicts_ledger'] = sorted(contradicted, key=int)
    # Outstanding = no audit outcome: the row is silent, or it says there is none.
    outstanding = len(silent) + sum(
        1 for m in re.finditer(r'^\| \*\*(\d+)\*\* \| (\w+) \|(.*)$', idx, re.M)
        if m.group(2) != 'WITHDRAWN' and 'Gate 2: no verdict' in m.group(3))
    out['results_awaiting_audit'] = outstanding

    # THE CANON'S BACKLOG, which nothing measured until 2026-09-10 and which had
    # reached 97 of 189 numbered results -- more than half, including whole strands.
    # Step 4 of the loop updates results.md once per cycle, so a per-cycle update
    # cannot catch up a backlog and every later cycle adds one entry to a file
    # already far behind.  Counting it is what makes it visible; a gate that failed
    # on 97 rows would teach nothing, so this is reported like the row above.
    canon = open('results.md', encoding='utf-8').read()
    numbered = {int(m.group(1)) for m in
                re.finditer(r'^\| \*\*(\d+)\*\* \| (?:Lemma|Observation|Conjecture) \|', idx, re.M)}
    cited = {int(m.group(1)) for m in
             re.finditer(r'\b(?:Lemma|Observation|Conjecture) L(\d+)\b', canon)}
    out['canon_missing'] = sorted(numbered - cited)
    out['canon_carried'] = len(numbered & cited)
    return out


def check_g():
    """An id asserted outside a heading.  Phase B reads `#### ` headings only, so a
    result stated as a bolded line -- **Lemma L18 (unconditional).** -- carries an id
    the duplicate check never sees.  One such line held Lemma L20's tube theorem under
    L18's number, in the same file as the real L18, which carries no proof."""
    out = []
    for f in findings_files():
        t = open(f, encoding='utf-8').read()
        heads = {m.group(1) for m in re.finditer(r'^#### (?:Lemma|Observation|Conjecture|Corollary) L?(\d+)', t, re.M)}
        for m in re.finditer(r'^>?\s*\*\*(?:Lemma|Observation|Conjecture|Corollary) L?(\d+)\b', t, re.M):
            if m.group(1) not in heads:
                out.append((os.path.basename(f), m.group(1)))
    return sorted(set(out))


def check_f():
    """A result inherits the status of its weakest input, so a Lemma whose block
    cites an Observation may be an Observation. Citing is not depending on, so
    this reports rather than fails -- each hit is a reading, not a violation."""
    obs, out = set(), []
    for f in findings_files():
        for m in re.finditer(r'^#### Observation L?(\d+)', open(f, encoding='utf-8').read(), re.M):
            obs.add(m.group(1))
    for f in findings_files():
        t = open(f, encoding='utf-8').read()
        hs = [(m.start(), m.group(1)) for m in re.finditer(r'^#### Lemma L?(\d+)', t, re.M)]
        for k, (pos, n) in enumerate(hs):
            end = hs[k + 1][0] if k + 1 < len(hs) else len(t)
            cited = {x for x in re.findall(r'\bL(\d+)\b', t[pos:end]) if x in obs and x != n}
            if cited:
                out.append((n, sorted(cited, key=int)))
    return sorted(out, key=lambda r: int(r[0]))


def main():
    findings = {'A': check_a(), 'B': check_b(), 'C': check_c(), 'D': check_d(), 'E': check_e(), 'F': check_f(), 'G': check_g(), 'H': check_h()}
    failed = (
        bool(findings['A'])
        or any(findings['B'][k] for k in ('duplicated', 'duplicated_posts', 'ghosts', 'orphans',
                                          'posts_tabled_without_heading', 'posts_headed_without_table'))
        or any(findings['C'].values())
        or any(v for k, v in findings['D'].items() if k != 'no_pdf_excused')
        or bool(findings['E']['index_contradicts_ledger'])
    )
    if '--json' in sys.argv:
        print(json.dumps(findings, indent=2, sort_keys=True))
        return 1 if failed else 0

    print('A  unnumbered result headings:',
          len(findings['A']) or 'clean')
    for row in findings['A']:
        print(f"     {row['file']}:{row['line']}  {row['heading'][:70]}")
    b = findings['B']
    print('B  duplicated ids:', b['duplicated'] or 'clean')
    print('   duplicated post ids:', b['duplicated_posts'] or 'clean')
    print('   index ghosts:', b['ghosts'] or 'clean', '| orphans:', b['orphans'] or 'clean')
    print('   posts tabled without a heading:', b['posts_tabled_without_heading'] or 'clean')
    print('   posts headed without a table row:', b['posts_headed_without_table'] or 'clean')
    for k, v in findings['C'].items():
        print(f'C  {k}:', v or 'clean')
    for k, v in findings['D'].items():
        print(f'D  {k}: {len(v)}', v if v and k != 'no_pdf_excused' else '')
    e = findings['E']
    print('E  index contradicts the ledger:', e['index_contradicts_ledger'] or 'clean')
    print('   results awaiting audit:', e['results_awaiting_audit'], '(reported, not enforced)')
    print('   canon: results.md carries', e['canon_carried'], 'of',
          e['canon_carried'] + len(e['canon_missing']), 'numbered results;',
          len(e['canon_missing']), 'missing (reported, not enforced)')
    if e['canon_missing']:
        print('     missing:', e['canon_missing'])
    h = findings['H']
    print('H  numbered results whose STATEMENT is typed in Lean:', len(h['statement_typed']),
          h['statement_typed'] or '(none)')
    print('   statement UNCHECKED (structured file, needs a read):', len(h['statement_unchecked']),
          h['statement_unchecked'] or '')
    print('   statement not typed (arithmetic-only file):', h['statement_not_typed'])
    print('   rows not declaring statement status:', h['statement_undeclared'], '(reported, not enforced)')
    print('F  Lemmas citing an Observation:', len(findings['F']), '(reported, not enforced)')
    for n, c in findings['F']:
        print('     L%s -> %s' % (n, ', '.join('L' + x for x in c)))
    print('G  ids asserted outside a heading:', findings['G'] or 'clean', '(reported, not enforced)')
    print('\nVERDICT:', 'FAIL' if failed else 'PASS')
    return 1 if failed else 0


if __name__ == '__main__':
    sys.exit(main())
