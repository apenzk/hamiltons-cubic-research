"""r239, claim 1 -- the two guards the Haar route rests on.

GUARD A.  chi_W(g), which c1_haar_moments.py derives as a polynomial in tr(g^j),
is checked against the trace of g^{tensor 4} on an explicitly built orthogonal
projector onto the Weyl-tensor subspace of (R^n)^{tensor 4}, at random g in O(n).

GUARD B.  The exact-moment theorem E[prod tr(g^j)^{a_j}] = E[prod (eta_j + sqrt(j)Z_j)^{a_j}]
for sum j a_j <= n is checked by Monte-Carlo Haar sampling on O(n).
"""
import numpy as np
from fractions import Fraction
from math import comb
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from c1_haar_moments import CHI_W, moment_one

rng = np.random.default_rng(20239)

def haar_O(n):
    A = rng.standard_normal((n, n))
    Q, R = np.linalg.qr(A)
    return Q * np.sign(np.diag(R))

def weyl_projector(n):
    """orthogonal projector of (R^n)^{ot 4} onto algebraic Weyl tensors."""
    N = n ** 4
    I = np.eye(N).reshape(n, n, n, n, N)
    T = I.transpose(4, 0, 1, 2, 3).copy()           # (N, n,n,n,n)
    # pair antisymmetry + pair swap
    T = 0.25 * (T - T.transpose(0, 2, 1, 3, 4) - T.transpose(0, 1, 2, 4, 3)
                + T.transpose(0, 2, 1, 4, 3))
    T = 0.5 * (T + T.transpose(0, 3, 4, 1, 2))
    # first Bianchi
    T = T - (T + T.transpose(0, 1, 3, 4, 2) + T.transpose(0, 1, 4, 2, 3)) / 3.0
    # remove Ricci + scalar (Kulkarni-Nomizu)
    g = np.eye(n)
    Ric = np.einsum('aikjk->aij', T)
    s = np.einsum('aii->a', Ric)
    E = Ric - s[:, None, None] / n * g
    def KN(A, B):
        return (np.einsum('aik,jl->aijkl', A, B) + np.einsum('ajl,ik->aijkl', A, B)
                - np.einsum('ail,jk->aijkl', A, B) - np.einsum('ajk,il->aijkl', A, B))
    T = (T - KN(E, g) / (n - 2)
         - s[:, None, None, None, None] * np.einsum('ik,jl->ijkl', g, g)[None] * 0
         - (s[:, None, None, None, None] / (2 * n * (n - 1)))
           * (2 * np.einsum('ik,jl->ijkl', g, g) - 2 * np.einsum('il,jk->ijkl', g, g))[None])
    M = T.reshape(N, N)
    # M is the (idempotent, symmetric) projector written row-wise
    return M

def chi_W_poly(pvals):
    """pvals[j] = tr(g^j), j>=1"""
    tot = 0.0
    for e, c in CHI_W.items():
        v = float(c)
        for i, a in enumerate(e):
            if a:
                v *= pvals[i + 1] ** a
        tot += v
    return tot

if __name__ == "__main__":
    print("GUARD A -- chi_W against an explicit Weyl projector")
    for n in (5, 6, 7):
        P = weyl_projector(n)
        err_idem = np.abs(P @ P - P).max()
        err_sym = np.abs(P - P.T).max()
        rk = int(round(np.trace(P)))
        want = n * (n + 1) * (n + 2) * (n - 3) // 12
        print(f"  n={n}: |P^2-P|={err_idem:.2e} |P-P^T|={err_sym:.2e} tr P={rk} (want {want})")
        assert err_idem < 1e-9 and err_sym < 1e-9 and rk == want
        for trial in range(3):
            g = haar_O(n)
            G4 = np.einsum('ai,bj,ck,dl->abcdijkl', g, g, g, g).reshape(n**4, n**4)
            tr_true = np.trace(P @ G4)
            pv = {j: np.trace(np.linalg.matrix_power(g, j)) for j in range(1, 5)}
            tr_poly = chi_W_poly(pv)
            ok = abs(tr_true - tr_poly) < 1e-8 * max(1.0, abs(tr_true))
            print(f"     trial {trial}: tr(P g^ot4) = {tr_true:+.9f}   poly = {tr_poly:+.9f}   {'OK' if ok else '*** MISMATCH ***'}")
            assert ok

    print()
    print("GUARD B -- Diaconis-Evans exact moments vs Monte-Carlo Haar on O(n)")
    tests = [((1, 2), 12), ((2,), 12), ((1, 1), 12), ((2, 2), 12), ((1, 1, 2), 12),
             ((4,), 12), ((3, 3), 12), ((1, 1, 1, 1), 12), ((2, 4), 12), ((6,), 12),
             ((1, 1, 2, 2, 4), 24), ((2, 2, 2, 2), 24)]
    NS = 400000
    for js, n in tests:
        from collections import Counter
        cnt = Counter(js)
        pred = Fraction(1)
        for j, a in cnt.items():
            pred *= moment_one(j, a)
        tot = np.zeros(NS)
        for i in range(NS):
            pass
        # vectorised sampling
        acc = 0.0
        acc2 = 0.0
        B = 20000
        reps = NS // B
        vals = []
        for _ in range(reps):
            A = rng.standard_normal((B, n, n))
            Q, R = np.linalg.qr(A)
            d = np.sign(np.einsum('bii->bi', R))
            Q = Q * d[:, None, :]
            prod = np.ones(B)
            for j in cnt:
                M = np.linalg.matrix_power(Q, j)
                t = np.einsum('bii->b', M)
                prod *= t ** cnt[j]
            vals.append(prod)
        v = np.concatenate(vals)
        m, se = v.mean(), v.std(ddof=1) / np.sqrt(len(v))
        z = (m - float(pred)) / se if se > 0 else 0.0
        deg = sum(js)
        flag = "OK" if abs(z) < 4 else "*** OFF ***"
        print(f"  n={n} moment {js} (wt deg {deg}<={n}): exact={float(pred):10.4f}  MC={m:10.4f} +- {se:.4f}  z={z:+.2f}  {flag}")
