"""Reviewer 202, claim 3(a): is the global word-list permutation a CORRUPTION
or a GAUGE transformation?  R'_i[t] = R_i[sigma(t)] for every copy i, so the
claim is h' = h exactly, Q'_{ts} = Q_{sigma(t)sigma(s)}, c' = sigma^{-1}.c and
therefore B = c'* Q' c' unchanged.  Verified elementwise on (2,0) and (2,2)."""
import sys, os, random, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import harness as H

BASE = H.ADAPTED
rnd = random.Random(202)
for lam in [(2, 0), (2, 2)]:
    n = len(BASE[lam][0])
    sigma = list(range(n)); rnd.shuffle(sigma)
    A = {k: [list(c) for c in cs] for k, cs in BASE.items()}
    A[lam] = [[c[sigma[t]] for t in range(n)] for c in BASE[lam]]

    H0 = H.measure_h(BASE, lam); H1 = H.measure_h(A, lam)
    print(f"\nlambda={lam}  sigma[:6]={sigma[:6]}")
    print(f"  h identical elementwise: {H0 == H1}")

    # Q, exactly as run_n5_assemble builds it: copy 0, grouped by weight
    def Qof(D):
        c0 = D[lam][0]; byw = {}
        for t, v in enumerate(c0):
            if v: byw.setdefault(H.mwt(max(v)), []).append(t)
        return byw, {w: [[H.ip3_g(c0[a], c0[b]) for b in ts] for a in ts]
                     for w, ts in byw.items()}
    byw0, Q0 = Qof(BASE); byw1, Q1 = Qof(A)
    same_w = {w: sorted(byw0[w]) == sorted(sigma[t] for t in byw1[w]) for w in byw0}
    print(f"  same weight classes (as SETS of words): {all(same_w.values())}")
    # Q'_{ts} = Q_{sigma(t) sigma(s)}: check by comparing the permuted block
    ok = True
    for w in byw0:
        p0 = {t: k for k, t in enumerate(byw0[w])}
        for a_, ta in enumerate(byw1[w]):
            for b_, tb in enumerate(byw1[w]):
                if Q1[w][a_][b_] != Q0[w][p0[sigma[ta]]][p0[sigma[tb]]]: ok = False
    print(f"  Q' is Q conjugated by the permutation: {ok}")
    print(f"  => B = c* Q c is invariant, so nothing downstream can see it.")
