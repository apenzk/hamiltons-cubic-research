"""Explicit models of the ten summands by block-support, plus real multiplicity tests."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r34_core import struct, weyl_basis, idempotent, Le_matrix
from review_r34_casimir import machinery, blocks

Wd = lambda m: m*(m+1)*(m+2)*(m-3)//12
sdim = lambda m: (m+2)*(m-1)//2
cdim = lambda m: m*(m-1)//2
Xdim = lambda m: m*(m*m-4)//3

def kinds(p, q):
    n = p+q; prs, _, _ = struct(n)
    return np.array([0 if j < p else (2 if i >= p else 1) for (i, j) in prs])

def support_subspace(p, q, pattern, B):
    """Elements of Weyl_n whose matrix vanishes outside the given (kind,kind) pattern."""
    n = p+q
    k = kinds(p, q); N = len(k)
    mask = np.zeros((N, N), bool)
    for (a, b) in pattern:
        mask |= np.outer(k == a, k == b) | np.outer(k == b, k == a)
    D = B.shape[0]
    Bout = B.reshape(D, N*N)[:, (~mask).ravel()]
    u, s, vt = np.linalg.svd(Bout, full_matrices=True)
    rank = int((s > 1e-9*max(1.0, s[0])).sum()) if s.size else 0
    return vt[rank:] if False else np.linalg.svd(Bout.T, full_matrices=True)[2][0:0]

def support_subspace2(p, q, pattern, B):
    n = p+q
    k = kinds(p, q); N = len(k)
    mask = np.zeros((N, N), bool)
    for (a, b) in pattern:
        mask |= np.outer(k == a, k == b) | np.outer(k == b, k == a)
    D = B.shape[0]
    M = B.reshape(D, N*N)[:, (~mask).ravel()]        # coefficients that must vanish
    if M.shape[1] == 0:
        return np.eye(D)
    u, s, vt = np.linalg.svd(M.T @ M)                 # nullspace of M (rows = basis coeffs)
    # nullspace of x -> x @ M
    u2, s2, vt2 = np.linalg.svd(M)
    r = int((s2 > 1e-9*max(1.0, s2[0])).sum())
    return u2[:, r:]                                  # (D, d) coefficient columns

def commutant_dim(Vb, gens, extra=()):
    """dim of {M on the block : [M,g]=0 for Lie gens, g M g^T = M for extra involutions}."""
    d = Vb.shape[1]
    rows = []
    for G in gens:
        g = Vb.T @ G @ Vb
        rows.append(np.kron(np.eye(d), g) - np.kron(g.T, np.eye(d)))
    for R in extra:
        r = Vb.T @ R @ Vb
        rows.append(np.kron(np.eye(d), r) @ np.kron(r.T, np.eye(d)) - np.eye(d*d))
    A = np.vstack(rows)
    s = np.linalg.svd(A, compute_uv=False)
    return d*d - int((s > 1e-8*max(1.0, s[0])).sum())

if __name__ == "__main__":
    for (p, q) in [(3,3),(3,4),(3,5),(4,4),(4,5),(5,5),(3,6),(4,6)]:
        n = p+q
        B = weyl_basis(n); D = B.shape[0]
        e, theta, _ = idempotent(p, q)
        L = Le_matrix(e, n, B); L = 0.5*(L+L.T)
        print(f"\n=== ({p},{q}) n={n} D={D} ===")
        for name, pat, pred in (("Weyl_p  [(pp,pp)]", [(0,0)], Wd(p)),
                                ("Weyl_q  [(qq,qq)]", [(2,2)], Wd(q)),
                                ("X_p(x)R^q [(pp,mix)]", [(0,1)], Xdim(p)*q),
                                ("X_q(x)R^p [(qq,mix)]", [(2,1)], Xdim(q)*p)):
            Vb = support_subspace2(p, q, pat, B)
            d = Vb.shape[1]
            if d == 0:
                print(f"   {name:24s} dim {d:5d}  (pred {pred})")
                continue
            S = Vb.T @ L @ Vb; w = np.linalg.eigvalsh(0.5*(S+S.T))
            print(f"   {name:24s} dim {d:5d}  (pred {pred:5d})  L_e spec "
                  f"[{w.min():+.2e},{w.max():+.2e}]  {'OK' if d==pred else 'MISMATCH'}")
