"""r232 / claim 1.  Two facts the transfer theorem leans on, checked exactly.

(A) PADDING LANDS IN THE MODULE.  A Weyl tensor of R^{n0}, padded with zeros,
    is a Weyl tensor of R^n.  Without this the restriction map P of the
    consistent sequence is not even defined on {W_n}, and step (1) of the
    theorem has nothing to restrict.  Note this is a fact about the TRACE-FREE
    condition, not about polynomial functors: it is what replaces the theorem's
    stated hypothesis for the module actually used.

(B) GENERATION DEGREE of {W_n} over B_n.  Definition 2.2 of
    Levin-Chandrasekaran: generated in degree d iff R[B_n] W_d = W_n.  Because
    B_n permutes and signs coordinates, R[B_n] W_d = sum over d-subsets S of
    iota_S(W_d).  We compute that span.  d_W feeds Theorem 2.11's Sym clause,
    hence k_B, hence whether n_0 = 12 is admissible at all.
"""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import r232_lin as L

def curvature_constraints(n):
    """rows of a matrix on R^{n^4} cutting out algebraic curvature tensors."""
    idx = lambda i, j, k, l: ((i * n + j) * n + k) * n + l
    rows = []
    for i, j, k, l in itertools.product(range(n), repeat=4):
        r = np.zeros(n ** 4, dtype=np.int64)
        r[idx(i, j, k, l)] += 1; r[idx(j, i, k, l)] += 1     # antisym in (ij)
        rows.append(r)
        r = np.zeros(n ** 4, dtype=np.int64)
        r[idx(i, j, k, l)] += 1; r[idx(i, j, l, k)] += 1     # antisym in (kl)
        rows.append(r)
        r = np.zeros(n ** 4, dtype=np.int64)
        r[idx(i, j, k, l)] += 1; r[idx(k, l, i, j)] -= 1     # pair symmetry
        rows.append(r)
        r = np.zeros(n ** 4, dtype=np.int64)
        r[idx(i, j, k, l)] += 1; r[idx(i, k, l, j)] += 1     # first Bianchi
        r[idx(i, l, j, k)] += 1
        rows.append(r)
    return np.array(rows, dtype=np.int64)

def ricci_constraints(n):
    idx = lambda i, j, k, l: ((i * n + j) * n + k) * n + l
    rows = []
    for i, j in itertools.product(range(n), repeat=2):
        r = np.zeros(n ** 4, dtype=np.int64)
        for k in range(n):
            r[idx(i, k, j, k)] += 1
        rows.append(r)
    return np.array(rows, dtype=np.int64)

def weyl_basis(n):
    """rows span W_n inside R^{n^4}, over F_p."""
    C = np.vstack([curvature_constraints(n), ricci_constraints(n)])
    return L.nullspace(C)

def dim_weyl(n):
    return n * (n + 1) * (n + 2) * (n - 3) // 12

def pad(B, n0, n):
    """embed tensors on R^{n0} into R^n by zero padding of every index."""
    out = np.zeros((B.shape[0], n ** 4), dtype=np.int64)
    for a, (i, j, k, l) in enumerate(itertools.product(range(n0), repeat=4)):
        out[:, ((i * n + j) * n + k) * n + l] = B[:, a]
    return out

def embed_subset(B, n0, n, S):
    """embed tensors on R^{n0} into R^n by sending coordinate a -> S[a]."""
    out = np.zeros((B.shape[0], n ** 4), dtype=np.int64)
    for a, (i, j, k, l) in enumerate(itertools.product(range(n0), repeat=4)):
        p, q, r, s = S[i], S[j], S[k], S[l]
        out[:, ((p * n + q) * n + r) * n + s] = B[:, a]
    return out

print("=" * 72)
print("(A)  is a zero-padded Weyl tensor of R^{n0} a Weyl tensor of R^n?")
for n0, n in [(4, 5), (4, 6), (5, 6), (5, 7), (6, 8), (4, 12)]:
    B0 = weyl_basis(n0)
    assert B0.shape[0] == dim_weyl(n0), (n0, B0.shape, dim_weyl(n0))
    Bp = pad(B0, n0, n)
    C = np.vstack([curvature_constraints(n), ricci_constraints(n)])
    resid = (Bp @ C.T) % L.P
    ok = not resid.any()
    print(f"  W_{n0} -> R^{n}:  dim W_{n0} = {B0.shape[0]:3d}   padded stays Weyl: {ok}")
    assert ok, "padding leaves the Weyl module -- P is not defined and step (1) collapses"

print()
print("=" * 72)
print("(B)  generation degree of {W_n} over B_n:  is  sum_S iota_S(W_4) = W_n ?")
for n in [5, 6, 7]:
    Bn = weyl_basis(n)
    assert Bn.shape[0] == dim_weyl(n)
    B4 = weyl_basis(4)
    rows = [embed_subset(B4, 4, n, S) for S in itertools.combinations(range(n), 4)]
    span = np.vstack(rows)
    r = L.rank(span)
    print(f"  n = {n}:  dim W_n = {Bn.shape[0]:3d}   rank of sum_S iota_S(W_4) = {r:3d}"
          f"   generated: {r == Bn.shape[0]}")
print()
print("  (W_3 = 0, so the generation degree of {W_n} is at least 4.)")
