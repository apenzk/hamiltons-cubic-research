"""CLAIM 3b. Independent replication of the numbers the reopening rests on.

Builds the (3,3,1,1,0,0) matrix (6,137 cols) and the (3,2,1,1,1,0) matrix
(14,595 cols) once each, and hands the SAME rows to three routines in one
process:

  OLD  the e106cc2 routine (echelon-by-insertion), extracted from that commit
  NEW  the shipped sparse_rank at HEAD (Markowitz), extracted from the file
  DEN  r216's dense numpy rank_modp, extracted from c4b_hw.py

The dead end recorded 1,943 s for OLD at 6,137.  6ca5418 records 26.8 s for NEW
there and 164.6 s at 14,595.
"""
import os, sys, time, pickle, subprocess
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "runs"))
from collections import defaultdict
import run_n12_covariants as M

P = M.P
HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.join(HERE, "..", "..", "..")

def grab(text, start, end, name):
    i = text.index(start); j = text.index(end, i)
    ns = {"P": P, "defaultdict": defaultdict}
    try:
        import numpy as np; ns["np"] = np
    except ImportError: pass
    exec(compile(text[i:j], name, "exec"), ns)
    return ns

old_src = subprocess.run(["git", "show", "e106cc2:scripts/runs/run_n12_covariants.py"],
                         cwd=REPO, capture_output=True, text=True).stdout
OLD = grab(old_src, "def sparse_rank(", "\ndef hw_nullity(", "<e106cc2>")["sparse_rank"]
NEW = grab(open(M.__file__).read(), "def sparse_rank(", "\ndef hw_nullity(", "<HEAD>")["sparse_rank"]
den_src = open(os.path.join(HERE, "..", "r216", "c4b_hw.py")).read()
DEN = grab(den_src, "def rank_modp(", "\ndef ", "<r216>")["rank_modp"]

def build(lam):
    t0 = time.time()
    B = []
    for a, wa in enumerate(M.WTS):
        for b, wb in enumerate(M.WTS[a:], start=a):
            need = tuple(lam[t]-wa[t]-wb[t] for t in range(6))
            if need not in M.WDIM: continue
            c = M.WRANK[need]
            if c < b: continue
            for ia in range(M.OFF[wa], M.OFF[wa]+M.WDIM[wa]):
                for ib in range(max(ia, M.OFF[wb]), M.OFF[wb]+M.WDIM[wb]):
                    for ic in range(max(ib, M.OFF[need]), M.OFF[need]+M.WDIM[need]):
                        B.append((ia, ib, ic))
    rows = defaultdict(dict)
    for j, m in enumerate(B):
        for i in range(6):
            acc = defaultdict(int)
            for pos in range(3):
                for r, v in M.Emod[i].get(m[pos], ()):
                    key = tuple(sorted(m[:pos] + (r,) + m[pos+1:]))
                    acc[key] = (acc[key] + v) % P
            for key, v in acc.items():
                if v: rows[(i, key)][j] = v
    return B, [dict(r) for r in rows.values()], time.time()-t0

for lam, claimed in [((3,3,1,1,0,0), "OLD 1,943.1 s (e106cc2) / NEW 26.8 s (6ca5418)"),
                     ((3,2,1,1,1,0), "NEW 164.6 s (6ca5418)")]:
    B, rows, bt = build(lam)
    nnz = sum(len(r) for r in rows)
    print(f"\n{lam}  {len(B):,} cols  {len(rows):,} rows  {nnz:,} nnz  "
          f"[build {bt:.1f}s]   record: {claimed}", flush=True)
    for name, fn in (("NEW markowitz", NEW), ("DEN r216 dense", DEN), ("OLD e106cc2", OLD)):
        t = time.time(); rk = fn([dict(r) for r in rows], len(B)); el = time.time()-t
        print(f"    {name:16s} rank {rk:>7,}  nullity {len(B)-rk:>3}  {el:8.1f} s", flush=True)
