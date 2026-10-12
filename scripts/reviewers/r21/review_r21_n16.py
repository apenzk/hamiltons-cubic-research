"""Reviewer 21: n-independence of the frontier constants, at a second and third n.

Checks, without ever forming the (huge) ker-block matrix:
  sup_{W1} ||P_ker Q(W1)||           should be sqrt(5/6)
  sup_{K}  ||P_13  Q(K)||            should be 2/3
  the identity ||P_ker Fbil(W1, P_ker Q(W1))|| = 0 for random W1 in V13
  lam_max(M_{W1*}) via matrix-free Lanczos    should be 2/3
and evaluates the n=12 optimal pair, zero-padded, inside this n.
"""
import sys, time
import numpy as np
from scipy.sparse.linalg import LinearOperator, eigsh
from review_r21_core import Setup, unit

n = int(sys.argv[1]); nrest = int(sys.argv[2]) if len(sys.argv) > 2 else 8
iters = int(sys.argv[3]) if len(sys.argv) > 3 else 80
A_SUP = np.sqrt(5.0 / 6.0); B_SUP = 2.0 / 3.0
t0 = time.time()
S = Setup(n).precompute()
S.slim()
print(f"[{time.time()-t0:6.1f}s] precomputed", flush=True)
rng = np.random.default_rng(2024)

def asc_A(y):
    for _ in range(iters):
        W1 = S.mat13(y); q = S.q_ker(W1)
        K = S.matker(unit(q))
        g = S.f_13(W1, K)
        if np.linalg.norm(g) < 1e-300: break
        y = unit(g)
    return y

def asc_B(y):
    for _ in range(iters):
        K = S.matker(y); p = S.q_13(K)
        W1 = S.mat13(unit(p))
        g = S.f_ker(W1, K)
        if np.linalg.norm(g) < 1e-300: break
        y = unit(g)
    return y

bestA = (-1, None)
for k in range(nrest):
    y = asc_A(unit(rng.normal(size=S.d13)))
    v = np.linalg.norm(S.q_ker(S.mat13(y)))
    if v > bestA[0]: bestA = (v, y)
    print(f"   A restart {k}: {v:.12f}   [{time.time()-t0:.0f}s]", flush=True)
print(f"  sup A = {bestA[0]:.12f}  (sqrt(5/6)={A_SUP:.12f}, diff {bestA[0]-A_SUP:+.2e})", flush=True)
bestB = (-1, None)
for k in range(nrest):
    y = asc_B(unit(rng.normal(size=S.dker)))
    v = np.linalg.norm(S.q_13(S.matker(y)))
    if v > bestB[0]: bestB = (v, y)
    print(f"   B restart {k}: {v:.12f}   [{time.time()-t0:.0f}s]", flush=True)
print(f"  sup B = {bestB[0]:.12f}  (2/3={B_SUP:.12f}, diff {bestB[0]-B_SUP:+.2e})", flush=True)

y1 = bestA[1]; W1s = S.mat13(y1); q = S.q_ker(W1s); a = np.linalg.norm(q)
K1 = S.matker(unit(q))
print(f"\n  identity at the A-maximiser: ||P_ker Fbil(W1*,K*)|| = {np.linalg.norm(S.f_ker(W1s,K1)):.3e}", flush=True)
print(f"  ||P_13 Q(K*)|| = {np.linalg.norm(S.q_13(K1)):.3e}", flush=True)
print("  identity on random W1 in V13:  ||P_ker Fbil(W1, P_ker Q(W1))|| / ||P_ker Q(W1)||", flush=True)
for k in range(6):
    W1 = S.mat13(unit(rng.normal(size=S.d13)))
    qq = S.q_ker(W1); aa = np.linalg.norm(qq)
    Kq = S.matker(qq / aa)
    print(f"     sample {k}: a={aa:.6f} rel={np.linalg.norm(S.f_ker(W1,Kq))/aa:.3e}", flush=True)

def mv(v):
    return S.f_ker(W1s, S.matker(v))
op = LinearOperator((S.dker, S.dker), matvec=mv, dtype=float)
w = eigsh(op, k=2, which='LA', return_eigenvectors=False, tol=1e-10, maxiter=5000)
wm = eigsh(op, k=2, which='SA', return_eigenvectors=False, tol=1e-10, maxiter=5000)
print(f"\n  lam_max(M_W1*) = {max(w):.12f}  (2/3 = {B_SUP:.12f}, diff {max(w)-B_SUP:+.2e})", flush=True)
print(f"  lam_min(M_W1*) = {min(wm):.12f}", flush=True)
print(f"[{time.time()-t0:6.1f}s] done", flush=True)
