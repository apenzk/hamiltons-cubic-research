"""CLAIM 4 -- the verification.  Take the record's OWN four points (dumped from an
unmodified rerun of scripts/runs/run_graded_gap_hunt.py, which reproduces its table
exactly) and apply the FULL grading test built independently in r113_core.py."""
import sys, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r113_core import pairs, struct_consts, make_sharp, theta_of, grading_data

here = os.path.dirname(os.path.abspath(__file__))
Ms = np.load(os.path.join(here, 'record_points.npy'))
meta = np.load(os.path.join(here, 'record_meta.npy'))
n = 6; pr = pairs(n); N = len(pr)
c, _ = struct_consts(n); sharp = make_sharp(c)
print(f"{len(Ms)} points dumped from the record's own hunt\n")

print("The four rows of the record's table in findings/nondegeneracy.md, re-tested:")
print(f"{'|theta|':>9} {'sign':>5} {'resid':>9} {'S_mmm':>9} {'S_hhm leak':>11} {'dim m':>6} {'allowed':>8} {'gap':>10}  GRADED?")
targets = [0.413728, 0.421067, 0.584875, 0.418198]
done = set()
for tg in targets:
    best = None
    for k, M in enumerate(Ms):
        thr = meta[k][3]
        if abs(abs(thr) - tg) < 5e-6:
            best = (k, M, thr); break
    if best is None:
        print(f"{tg}: not found"); continue
    k, M, thr = best
    M = M/np.linalg.norm(M)
    th, Q = theta_of(M, sharp)
    res = np.linalg.norm(Q - th*M)
    for sgn in (+1, -1):
        Mo = sgn*M
        tho, Qo = theta_of(Mo, sharp)
        g = grading_data(Mo, c)
        allowed = g['n_neg'] in (5, 6, 8, 9)
        print(f"{abs(tho):9.6f} {'+' if tho>0 else '-':>5} {res:9.1e} {g['S_mmm']:9.4f} {g['S_hhm']:11.6f} "
              f"{g['n_neg']:6d} {'yes' if allowed else 'NO':>8} {g['gap']:10.3e}  {'YES' if g['graded'] else 'no'}")
    print()

# the headline point in full
print("=== the candidate falsifier: theta = 0.418198, S = 0, gap 2.2e-3 ===")
for k, M in enumerate(Ms):
    if abs(abs(meta[k][3]) - 0.418198) < 5e-6:
        M = M/np.linalg.norm(M)
        th, Q = theta_of(M, sharp)
        print(f"criticality residual ||Q - theta W|| = {np.linalg.norm(Q-th*M):.2e}")
        print(f"theta as returned by the solver = {th:+.9f}   (the record reports |theta| = 0.418198)")
        for sgn, name in ((+1, 'as-returned'), (-1, 'flipped')):
            Mo = sgn*M; tho, _ = theta_of(Mo, sharp); g = grading_data(Mo, c)
            print(f"\n  orientation {name}: theta = {tho:+.9f}")
            print(f"    spectrum: " + " ".join(f"{x:+.6f}" for x in np.sort(g['lam'])))
            print(f"    dim m = #{{lam<0}} = {g['n_neg']}   (a graded W at n=6 needs dim m in {{5,6,8,9}})")
            print(f"    S_mmm = <[m,m],m>^2 = {g['S_mmm']:.6e}      (necessary condition)")
            print(f"    S_hhm = |Pi_m [h,h]|^2 = {g['S_hhm']:.6f}   (the second condition)")
            print(f"    S_hmm = |Pi_h [h,m]|^2 = {g['S_hmm']:.6f}")
            print(f"    FULL GRADING TEST: {'GRADED' if g['graded'] else 'UNGRADED'}")
        break

# --- sweep ALL 355 of the record's solutions, both orientations ---
print("\n=== full grading test over all of the record's converged solutions ===")
seen = {}
for k, M in enumerate(Ms):
    M = M/np.linalg.norm(M)
    th, Q = theta_of(M, sharp)
    if abs(th) < 1e-6: continue
    if th < 0: M = -M; th, Q = theta_of(M, sharp)
    g = grading_data(M, c); gm = grading_data(-M, c)
    key = (round(th, 8), tuple(np.round(np.sort(g['lam']), 6)))
    seen[key] = (th, g, gm)
vals = list(seen.values())
print(f"{len(Ms)} runs -> {len(vals)} distinct critical points")
ng = sum(1 for th,g,gm in vals if g['graded'] or gm['graded'])
print(f"GRADED in either orientation: {ng}")
s0p = sum(1 for th,g,gm in vals if g['S_mmm'] < 1e-9)
s0m = sum(1 for th,g,gm in vals if gm['S_mmm'] < 1e-9)
print(f"S_mmm = 0 on the theta>0 orientation: {s0p};  on the theta<0 orientation: {s0m}")
bad = sum(1 for th,g,gm in vals if g['n_neg'] not in (5,6,8,9))
print(f"points whose theta>0 orientation has dim m outside the Cartan-allowed {{5,6,8,9}}: {bad}")
print(f"smallest gap over all: {min(g['gap'] for th,g,gm in vals):.4e}; largest |theta|: {max(th for th,g,gm in vals):.6f}")
print("\nevery point with S_mmm = 0 in either orientation:")
print(f"{'theta':>10} {'orient':>7} {'gap':>11} {'S_hhm leak':>12} {'dim m':>6} GRADED")
for th,g,gm in sorted(vals, key=lambda t: t[1]['gap']):
    if g['S_mmm'] < 1e-9:
        print(f"{th:10.6f} {'+':>7} {g['gap']:11.4e} {g['S_hhm']:12.6f} {g['n_neg']:6d} {'YES' if g['graded'] else 'no'}")
    if gm['S_mmm'] < 1e-9:
        print(f"{-th:10.6f} {'-':>7} {gm['gap']:11.4e} {gm['S_hhm']:12.6f} {gm['n_neg']:6d} {'YES' if gm['graded'] else 'no'}")
