"""K5: does taking the largest theta from the k-block vertex system return coarsenings?

And is 'all rows of w distinct' the right filter?  A coordinate-diagonal block operator
merges blocks a and b into one block exactly when the merged operator is still constant
on block pairs, i.e. w_ac = w_bc for every c outside {a,b} AND w_aa = w_ab = w_bb.
Row a equals row b iff w_ac = w_bc for c not in {a,b}, w_aa = w_ba = w_ab, and
w_ab = w_bb -- the same conditions.  So equality of rows is exactly mergeability.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, itertools
from math import comb
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_blocks import (solve_family, Pval, normsq, triangles, effective_rows,
                               theta0, unpack, residual, Qmat, ricci)
from review_r54_core import pairs_of, Q as Qfull, P as Pfull, slack_structural

def full_W(sizes, w):
    n = sum(sizes); ps, idx = pairs_of(n)
    lab = []
    for bi, b in enumerate(sizes): lab += [bi]*b
    Wf = np.zeros((len(ps), len(ps)))
    for a, (i, j) in enumerate(ps):
        Wf[a, a] = w[lab[i], lab[j]]
    return Wf

def merged(sizes, w, groups):
    ns = [sum(sizes[a] for a in g) for g in groups]
    k2 = len(groups)
    w2 = np.zeros((k2, k2))
    for i, gi in enumerate(groups):
        for j, gj in enumerate(groups):
            w2[i, j] = w[gi[0], gj[0]] if (i != j or len(gi) == 1) else w[gi[0], gi[0]]
    return ns, w2

if __name__ == "__main__":
    print("=== k = 5 vertex system: the largest-theta solutions and what they really are ===")
    for sizes in [(2,2,2,2,2), (2,2,2,2,3), (2,2,2,2,4), (2,2,2,3,3), (3,3,3,3,3),
                  (2,2,2,2,6), (2,2,3,3,4)]:
        n = sum(sizes)
        sols = solve_family(list(sizes), starts=500, seed=hash(sizes) % 10000)
        rows = []
        for w, th in sols:
            wn = w / np.sqrt(normsq(sizes, w))
            grp = effective_rows(wn, tol=1e-6)
            tri = triangles(sizes, wn)
            rows.append((th/theta0(n), len(grp), grp, tri, wn, th))
        rows.sort(key=lambda r: -r[0])
        print(f"\n  sizes={sizes} n={n}  theta_0={theta0(n):.6f}   ({len(sols)} distinct critical points)")
        print(f"   {'ratio':>9} {'eff.blocks':>10} {'grouping':>28} {'3*tri (=S)':>11} {'merged sizes':>16} {'verdict':>12}")
        for r in rows[:6]:
            ratio, nb, grp, tri, wn, th = r
            ns, _ = merged(sizes, wn, grp)
            verdict = "genuine 5-block" if nb == 5 else f"coarsening to {nb}"
            print(f"   {ratio:>9.6f} {nb:>10} {str(grp):>28} {3*tri:>11} {str(sorted(ns)):>16} {verdict:>12}")

    print("\n=== confirming the coarsenings really are the coarser critical point ===")
    for sizes in [(2,2,2,2,4)]:
        n = sum(sizes)
        sols = solve_family(list(sizes), starts=600, seed=11)
        for w, th in sorted(sols, key=lambda s: -s[1])[:3]:
            wn = w/np.sqrt(normsq(sizes, w))
            grp = effective_rows(wn, 1e-6)
            ns, w2 = merged(sizes, wn, grp)
            Wf = full_W(sizes, wn); Wf /= np.linalg.norm(Wf)
            thf = Pfull(n, Wf)
            res = np.linalg.norm(Qfull(n, Wf) - thf*Wf)
            S = slack_structural(n, Wf)
            # is it the sphere product on the merged blocks?
            sph = np.zeros((len(ns), len(ns)))
            for a in range(len(ns)):
                for b in range(len(ns)):
                    sph[a, b] = 1.0/(ns[a]*(ns[a]-1)) if a == b else -1.0/(ns[a]*ns[b])
            sph /= np.sqrt(normsq(ns, sph))
            print(f"   ratio={thf/theta0(n):.9f}  groups={grp} -> sizes {ns}  resid={res:.1e} "
                  f"S_struct={S:.4f}  |w2 - sphere_product|={np.abs(np.abs(w2)-np.abs(sph)).max():.2e}")
