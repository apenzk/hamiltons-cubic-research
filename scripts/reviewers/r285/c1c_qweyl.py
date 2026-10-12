"""Is Weyl_n invariant under Q?  Separate the Bianchi and the Ricci halves."""
import numpy as np, sys
sys.path.insert(0, "scripts/reviewers/r285")
from c1_gradient import struct, Q, weyl_basis, proj
from itertools import combinations

def R_of(W, idx, i, j, k, l):
    if i == j or k == l: return 0.0
    s = 1.0
    if i > j: i, j, s = j, i, -s
    if k > l: k, l, s = l, k, -s
    return s*W[idx[(i,j)], idx[(k,l)]]

def bianchi_norm(W, n, idx):
    t = 0.0
    for (i,j,k,l) in combinations(range(n), 4):
        b = R_of(W,idx,i,j,k,l)+R_of(W,idx,i,k,l,j)+R_of(W,idx,i,l,j,k)
        t += b*b
    return np.sqrt(t)

def ricci(W, n, idx):
    Ric = np.zeros((n,n))
    for i in range(n):
        for k in range(n):
            Ric[i,k] = sum(R_of(W,idx,i,j,k,j) for j in range(n))
    return Ric

rng = np.random.default_rng(28522)
for n in (6, 8):
    pr, N, c = struct(n)
    idx = {p:k for k,p in enumerate(pr)}
    B, c2, N2 = weyl_basis(n)
    d = B.shape[0]
    print(f"=== n={n} dimWeyl={d} ===")
    for trial in range(3):
        co = rng.standard_normal(d); co /= np.linalg.norm(co)
        W = np.einsum('k,kab->ab', co, B)
        QW = Q(c, W)
        print(f"  trial {trial}: ||Q(W)||={np.linalg.norm(QW):.6f}"
              f"  offWeyl={np.linalg.norm(QW-proj(B,QW)):.3e}"
              f"  ||Bianchi(Q)||={bianchi_norm(QW,n,idx):.3e}"
              f"  ||Ric(Q)||={np.linalg.norm(ricci(QW,n,idx)):.3e}"
              f"  ||Ric(W)||={np.linalg.norm(ricci(W,n,idx)):.3e}")
