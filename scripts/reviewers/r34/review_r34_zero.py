"""M4 zero claims attacked directly: L_e V = 0 for V in Weyl_p embedded, and the
structure identity behind it."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r34_core import (struct, weyl_basis, idempotent, circ, sharp_bilin,
                             W_pq, ip, Le_matrix)

def embed(p, n):
    """Weyl_p zero-padded into operators on Lambda^2(R^n)."""
    Bp = weyl_basis(p)
    prs_p, idx_p, _ = struct(p)
    prs_n, idx_n, _ = struct(n)
    N = len(prs_n)
    out = []
    for M in Bp:
        E = np.zeros((N, N))
        for a, pa in enumerate(prs_p):
            for b, pb in enumerate(prs_p):
                E[idx_n[pa], idx_n[pb]] = M[a, b]
        out.append(E)
    return np.array(out)

def block_masks(p, q):
    n = p+q
    prs, idx, _ = struct(n)
    N = len(prs)
    kind = np.empty(N, dtype=int)
    for a, (i, j) in enumerate(prs):
        kind[a] = 0 if j < p else (2 if i >= p else 1)   # 0=pp 1=mixed 2=qq
    return kind

print("=== L_e V for V in Weyl_p embedded (float) ===")
for (p, q) in [(4,3),(4,4),(4,5),(4,6),(4,7),(5,3),(5,4),(5,5),(5,6),(6,3),(6,4),(6,5),(7,3),(7,4),(4,8),(5,7),(6,6),(8,3)]:
    n = p+q
    if p < 4:   # Weyl_p = 0 below p=4
        continue
    e, theta, _ = idempotent(p, q)
    E = embed(p, n)
    worst = 0.0; scale = 0.0
    for V in E:
        LV = circ(e, V, n)
        worst = max(worst, np.abs(LV).max())
        scale = max(scale, np.abs(V).max())
    print(f"  Weyl_{p} in Weyl_{n} ({p},{q}): dim {E.shape[0]:3d}  "
          f"max|L_e V| = {worst:.3e}  (|V|~{scale:.2f})")

print()
print("=== why: the two structural pieces ===")
print("(a) sharp_bilin(Id_{Lambda^2 R^p}, V) = alpha_p * V  for V Ricci-flat Bianchi on R^p?")
for p in (4,5,6,7,8):
    B = weyl_basis(p)
    _, _, C = struct(p)
    N = C.shape[0]
    I = np.eye(N)
    rng = np.random.default_rng(3)
    V = np.einsum('d,dij->ij', rng.normal(size=B.shape[0]), B)
    S = sharp_bilin(I, V, p)
    alpha = ip(S, V)/ip(V, V)
    print(f"   p={p}: alpha = {alpha:+.9f}   residual |S - alpha V| = "
          f"{np.linalg.norm(S-alpha*V)/np.linalg.norm(V):.2e}")

print()
print("(b) the mixed-block component of sharp_bilin(e,V), V in Weyl_p")
for (p,q) in [(4,4),(4,6),(5,5),(5,3),(6,4)]:
    n=p+q
    e,_,_ = idempotent(p,q)
    kind = block_masks(p,q)
    E = embed(p,n)
    rng = np.random.default_rng(5)
    V = np.einsum('d,dij->ij', rng.normal(size=E.shape[0]), E)
    S = sharp_bilin(e, V, n)
    mm = np.ix_(kind==1, kind==1)
    pp = np.ix_(kind==0, kind==0)
    print(f"   ({p},{q}): |S_mixed| = {np.abs(S[mm]).max():.3e}   "
          f"|S_pp + e_pp*V| = {np.abs(S[pp] + e[0,0]*V[pp]).max():.3e}   e_pp={e[0,0]:.6f}")
