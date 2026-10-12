"""r285 Claim 5: is 'Plucker-obstructed => theta <= sqrt(3/2)' true?

The obstruction is defined on every W in Weyl_n, with no criticality and no unit-norm
hypothesis (findings/diagonality.md's own domain column).  A generic W has 66 simple
eigenvalues, so every eigenspace is a line spanned by a generic bivector, and a generic
bivector has omega ^ omega != 0.  So the obstruction is GENERIC -- and a small generic
perturbation of the balanced sphere product at n=12 keeps theta above sqrt(3/2).
"""
import numpy as np, sys, itertools
sys.path.insert(0, "scripts/reviewers/r285")
from c1_gradient import struct, Q, weyl_basis, proj
from c24_hessian import sphere_product, pairs_of

n = 12
pr, N, c = struct(n)
B, _, _ = weyl_basis(n); D = len(B)
quad = list(itertools.combinations(range(n), 4))
ix = {p_: t for t, p_ in enumerate(pr)}
trip = np.array([[(ix[(i,j)], ix[(k,l)]), (ix[(i,k)], ix[(j,l)]), (ix[(i,l)], ix[(j,k)])]
                 for (i,j,k,l) in quad])
sgn = np.array([1.0, -1.0, 1.0])
def wedge(v):
    a = v[trip[:, :, 0]]; b = v[trip[:, :, 1]]
    return float(np.sqrt((((sgn*a*b).sum(axis=1))**2).sum()))

W0 = proj(B, sphere_product(n)); W0 = W0/np.linalg.norm(W0)
print("theta_0(12) =", np.sqrt(2*(n-1)*(n-2)/n**2), "  sqrt(3/2) =", np.sqrt(1.5))
th0 = float(np.sum(W0*Q(c, W0)))
ev0 = np.linalg.eigvalsh(W0)
print(f"balanced sphere product: theta={th0:.12f}  distinct eigenvalues={len(np.unique(np.round(ev0,10)))}")
# each eigenspace of W0: does it contain a decomposable?
evs, U = np.linalg.eigh(W0)
i = 0
while i < N:
    j = i
    while j+1 < N and abs(evs[j+1]-evs[i]) < 1e-9: j += 1
    vecs = U[:, i:j+1]
    # coordinate bivectors are decomposable; is any of them in this eigenspace?
    proj_norms = np.linalg.norm(vecs @ vecs.T, axis=0)
    hits = int((np.abs(np.diag(vecs @ vecs.T) - 1.0) < 1e-9).sum())
    print(f"  eigval {evs[i]:+.9f} dim {j-i+1}: coordinate bivectors inside = {hits}")
    i = j+1

rng = np.random.default_rng(2853)
print("\nperturbed sphere products (generic direction in Weyl_12):")
for eps in (1e-3, 1e-2, 3e-2, 5e-2):
    for t in range(2):
        cv = rng.standard_normal(D); cv /= np.linalg.norm(cv)
        V = np.einsum('k,kab->ab', cv, B)
        W = W0 + eps*V; W = W/np.linalg.norm(W)
        th = float(np.sum(W*Q(c, W)))
        evs = np.linalg.eigvalsh(W)
        gap = float(np.min(np.diff(evs)))
        _, U = np.linalg.eigh(W)
        mins = [wedge(U[:, k]) for k in range(N)]
        offw = np.linalg.norm(W - proj(B, W))
        print(f"  eps={eps:<6} theta={th:.9f} (> sqrt(3/2)? {th > np.sqrt(1.5)})"
              f"  min eigen-gap={gap:.3e}  min_k ||w_k ^ w_k||={min(mins):.6f}"
              f"  offWeyl={offw:.1e}")
