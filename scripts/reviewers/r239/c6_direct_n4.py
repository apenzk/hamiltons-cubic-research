"""r239, claim 6 -- a CHARACTER-FREE check of the Burnside pipeline, at n = 4.

No cycle index, no conjugacy classes, no chi_W.  The 384 elements of B_4 are enumerated as
signed permutation matrices, acted on the 10-dimensional Weyl space through g^{ot 4}, and the
Reynolds average of every degree-d monomial is evaluated at random points.  The rank of that
value matrix is dim (Sym^d W_4)^{B_4}, since Reynolds maps the monomial basis ONTO the
invariants.  Expected from the Burnside table: 0, 3, 5, 14, 27, 67.
"""
import numpy as np
from itertools import permutations, product
from math import comb
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from c1_guards import weyl_projector

rng = np.random.default_rng(1239)
n = 4

P = weyl_projector(n)
w, U = np.linalg.eigh((P + P.T) / 2)
B = U[:, w > 0.5]                      # 256 x 10 orthonormal basis of W_4
assert B.shape[1] == 10, B.shape

G = []
for perm in permutations(range(n)):
    for signs in product([1, -1], repeat=n):
        g = np.zeros((n, n))
        for i in range(n):
            g[perm[i], i] = signs[i]
        G.append(g)
assert len(G) == 384

MATS = []
for g in G:
    G4 = np.einsum('ai,bj,ck,dl->abcdijkl', g, g, g, g).reshape(n**4, n**4)
    MATS.append(B.T @ G4 @ B)
# sanity: the action is orthogonal on W
assert max(np.abs(M @ M.T - np.eye(10)).max() for M in MATS) < 1e-9
print("B_4 acts orthogonally on the 10-dim Weyl space: OK")

def monomials(d, m):
    """exponent vectors of degree d in m variables"""
    if m == 1:
        yield (d,)
        return
    for i in range(d + 1):
        for rest in monomials(d - i, m - 1):
            yield (i,) + rest

for d in range(1, 7):
    E = np.array(list(monomials(d, 10)), dtype=np.int64)
    K = max(4 * comb(d + 9, 9) // 100, 3 * 80)
    K = min(K, 400)
    X = rng.standard_normal((K, 10))
    A = np.zeros((E.shape[0], K))
    for M in MATS:
        Y = X @ M.T
        pw = np.stack([Y ** k for k in range(d + 1)], axis=0)   # (d+1, K, 10)
        vals = np.ones((K, E.shape[0]))
        for i in range(10):
            vals *= pw[E[:, i], :, i].T
        A += vals.T
    A /= len(MATS)
    scale = np.abs(vals).max()          # size of a raw monomial value at these points
    s = np.linalg.svd(A, compute_uv=False)
    tol = scale * 1e-9
    rk = int((s > tol).sum())
    print(f"  d={d}: monomials {E.shape[0]}, points {K}, max|A| = {np.abs(A).max():.2e}, "
          f"raw scale {scale:.2e}, rank = {rk}")
