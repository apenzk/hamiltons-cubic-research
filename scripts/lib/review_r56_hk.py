"""Reviewer 56 -- the r>=8 hyperkaehler family, which review_r11_grading_slack.py
does not cover.  Built independently: seed the Weyl-projected Kaehler tensors of a
hypercomplex triple on an r-plane, close the span under the symmetric bilinear map
B (Fox's algebra product), then find every idempotent inside the closed algebra and
measure theta and the structural slack S at each.
"""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from review_r56_core import *
from scipy.optimize import least_squares

def hyper_triple(n, r):
    """I,J,K on the first r coordinates (r divisible by 4), zero elsewhere."""
    I = np.zeros((n, n)); J = np.zeros((n, n)); K = np.zeros((n, n))
    for q in range(r // 4):
        o = 4 * q
        def st(A, a, b):
            A[o + a, o + b] = -1.0; A[o + b, o + a] = 1.0
        st(I, 0, 1); st(I, 2, 3)
        st(J, 0, 2); st(J, 3, 1)
        st(K, 0, 3); st(K, 1, 2)
    return I, J, K

def kahler_weyl(n, a, idx):
    T = (np.einsum('ik,jl->ijkl', a, a) - np.einsum('il,jk->ijkl', a, a)
         + 2 * np.einsum('ij,kl->ijkl', a, a))
    return weyl_project(T, idx, n)

def close_algebra(seed, c, tol=1e-8, maxdim=40):
    B = []
    def add(x):
        v = x.copy()
        for b in B:
            v -= np.sum(v * b) * b
        nv = np.linalg.norm(v)
        if nv > tol * max(1.0, np.linalg.norm(x)):
            B.append(v / nv); return True
        return False
    for s in seed:
        add(s)
    changed = True
    while changed and len(B) < maxdim:
        changed = False
        cur = list(B)
        for i in range(len(cur)):
            for j in range(i, len(cur)):
                if add(bil(cur[i], cur[j], c)):
                    changed = True
    return B

def idempotents(B, c, tries=4000, seed=0):
    k = len(B)
    G = np.array([[np.sum(a * b) for b in B] for a in B])
    def resid(x):
        W = sum(xi * b for xi, b in zip(x, B))
        nq = np.linalg.norm(W)
        if nq < 1e-9:
            return np.ones(k + 1) * 10
        W = W / nq
        QW = Q(W, c); th = float(np.sum(W * QW))
        R = QW - th * W
        return np.array([np.sum(R * b) for b in B] + [np.linalg.norm(x) - 1])
    rng = np.random.default_rng(seed)
    found = []
    for t in range(tries):
        x0 = rng.normal(size=k)
        r = least_squares(resid, x0, xtol=1e-14, ftol=1e-14, gtol=1e-14)
        if np.linalg.norm(r.fun) > 1e-10:
            continue
        W = sum(xi * b for xi, b in zip(r.x, B)); W /= np.linalg.norm(W)
        th = float(np.sum(W * Q(W, c)))
        if th < 0:
            W, th = -W, -th
        if all(np.linalg.norm(W - Wp) > 1e-6 for Wp, _ in found):
            found.append((W, th))
    return found

for (n, r) in ((8, 8), (12, 8), (12, 12)):
    idx, pos, N, c = struct(n)
    I, J, K = hyper_triple(n, r)
    assert np.allclose(I @ I, -np.diag([1.0]*r + [0.0]*(n-r)))
    print(f"\n=== n={n}, hypercomplex r-plane r={r}   (IJ-K residual {np.abs(I@J-K).max():.1e}) ===")
    gens = [kahler_weyl(n, a, idx) for a in (I, J, K)]
    gens = [g / np.linalg.norm(g) for g in gens]
    Gm = np.array([[np.sum(a * b) for b in gens] for a in gens])
    print(f"  Gram of the three Kaehler generators, rank = {np.linalg.matrix_rank(Gm, 1e-8)}")
    print(f"  ||S(I)+S(J)+S(K)|| = {np.linalg.norm(sum(gens)):.3e}   (Fox's r=4 collapse)")
    B = close_algebra(gens, c)
    print(f"  dim of the closed subalgebra = {len(B)}")
    ids = idempotents(B, c, tries=600, seed=1)
    print(f"  idempotents found: {len(ids)}")
    seen = []
    for W, th in sorted(ids, key=lambda t: -t[1]):
        S, leak = slack_struct(W, c)
        key = round(th, 8)
        tag = "" if key not in seen else "  (same theta as an earlier orbit)"
        seen.append(key)
        print(f"    theta={th:11.9f}  th/th0={th/theta0(n):7.4f}  S={S:11.4e} "
              f"leak={leak:9.2e}  massF={offdiag_mass(W):6.4f}{tag}")

print("\n=== positive control: r=4 in n=8 must return Fox S^4(alpha) ===")
idx, pos, N, c = struct(8)
I, J, K = hyper_triple(8, 4)
gens = [kahler_weyl(8, a, idx) for a in (I, J, K)]
gens = [g / np.linalg.norm(g) for g in gens]
print(f"  ||S(I)+S(J)+S(K)|| = {np.linalg.norm(sum(gens)):.3e}")
B = close_algebra(gens, c)
print(f"  dim closed algebra = {len(B)}")
ids = idempotents(B, c, tries=400, seed=2)
fox = w_cp2_padded(8, idx); fox /= np.linalg.norm(fox)
for W, th in sorted(ids, key=lambda t: -t[1])[:6]:
    S, leak = slack_struct(W, c)
    print(f"    theta={th:11.9f}  S={S:10.3e}  massF={offdiag_mass(W):6.4f}  "
          f"is it in the O(8) orbit of Fox? |spec diff|="
          f"{np.abs(np.sort(np.linalg.eigvalsh(W))-np.sort(np.linalg.eigvalsh(fox))).max():.2e}")
