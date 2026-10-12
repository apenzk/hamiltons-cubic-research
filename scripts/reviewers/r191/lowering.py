"""The lowering operators, derived from H and the cached raising operators, and
then checked against the Lie algebra.

Convention.  Everything stored as  M[input][output]:  M f_x = sum_t M[x][t] f_t,
which is how raise_mono reads E1C/E2C (reviewer 188).  The Gram in the usual
sense is G = H^T, since  <u,v> = sum_{a,b} u_a conj(v_b) H[a][b] = v^dag G u.
Adjointness  <E u, v> = <u, F v>  then forces  F_hat = (G E_hat G^-1)^dag  with
E_hat = E_stored^T, and F_stored = F_hat^T.

This is a DERIVATION of F, so it is checked, not trusted:
  (a) F must lower the weight by exactly alpha,
  (b) [E, F] must act on each weight block as a scalar, and
  (c) that scalar must be a linear functional of the weight.
Any of the three can fail; together they say H is an invariant metric and F is
the honest lowering operator of the compact form.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import *

H = build_H()
Hm = Hfull(H)
G = [[Hm[b][a] for b in range(35)] for a in range(35)]        # G = H^T
Ginv_H = inv_blockdiag(H)                                      # (H)^{-1}
# G^{-1} = (H^T)^{-1} = (H^{-1})^T
Ginv = [[Ginv_H[b][a] for b in range(35)] for a in range(35)]

def transpose(A): return [[A[j][i] for j in range(35)] for i in range(35)]

FS = {}
for k in (1, 2):
    Ehat = transpose(EC[k])
    Fhat = dagger(matmul(matmul(G, Ehat), Ginv))
    FS[k] = transpose(Fhat)                      # back to [input][output]

def commutator(A, B):
    Ah, Bh = transpose(A), transpose(B)
    Ch = [[csub(x, y) for x, y in zip(r1, r2)]
          for r1, r2 in zip(matmul(Ah, Bh), matmul(Bh, Ah))]
    return transpose(Ch)

if __name__ == "__main__":
    for k in (1, 2):
        a = ALPHA[k]
        shift_ok = all(FS[k][x][t] == Z or
                       (WT[t][0] == WT[x][0]-a[0] and WT[t][1] == WT[x][1]-a[1])
                       for x in range(35) for t in range(35))
        print(f"F{k} lowers every weight by {a}: {shift_ok}")
        Cm = commutator(EC[k], FS[k])            # [E,F], stored form
        # scalar on each weight block?
        scal, ok = {}, True
        for mu, idxs in BYW.items():
            sub = [[Cm[x][t] for t in idxs] for x in idxs]
            d = sub[0][0]
            for r in range(len(idxs)):
                for c in range(len(idxs)):
                    if sub[r][c] != (d if r == c else Z): ok = False
            scal[mu] = d
            for x in range(35):
                for t in range(35):
                    if (x in idxs) != (t in idxs) and Cm[x][t] != Z: ok = False
        print(f"  [E{k},F{k}] is a scalar on every weight block: {ok}")
        # linear in the weight?
        import itertools as it
        mus = sorted(scal)
        c1 = scal[(1, 0)] if (1, 0) in scal else None
        # fit s(mu) = p*mu1 + q*mu2 from two independent weights, then verify all
        base = [m for m in mus if m != (0, 0)]
        (m1, m2) = base[0], next(m for m in base if m[0]*base[0][1] != m[1]*base[0][0])
        det = m1[0]*m2[1] - m1[1]*m2[0]
        s1, s2 = scal[m1], scal[m2]
        p = cdiv(csub(cmul(s1, (F(m2[1]), F(0))), cmul(s2, (F(m1[1]), F(0)))), (F(det), F(0)))
        q = cdiv(csub(cmul(s2, (F(m1[0]), F(0))), cmul(s1, (F(m2[0]), F(0)))), (F(det), F(0)))
        lin = all(scal[m] == cadd(cmul(p, (F(m[0]), F(0))), cmul(q, (F(m[1]), F(0))))
                  for m in mus)
        print(f"  and that scalar is linear in the weight: {lin}   "
              f"[E,F]|_mu = ({p[0]})*mu1 + ({q[0]})*mu2")
        print(f"  coroot direction {(p[0], q[0])} vs alpha {a}: "
              f"proportional = {p[0]*a[1] == q[0]*a[0]}")
