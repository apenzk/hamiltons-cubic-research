"""M3: equivariance of L_e under O(p)xO(q) incl. reflections.
   M7: is the 18-dim E(1/2) at (3,3) really TWO ISOMORPHIC copies?  Commutant test."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r34_core import struct, weyl_basis, idempotent, Le_matrix, circ
from review_r34_summands import commutant_dim

def rep_on_weyl(g, n, B):
    """rho(g) on Weyl_n for g in O(n): X -> L X L^T with L = Lambda^2 g."""
    prs, idx, _ = struct(n)
    N = len(prs)
    L = np.zeros((N, N))
    for b, (k, l) in enumerate(prs):
        # g(e_k) ^ g(e_l)
        for a, (i, j) in enumerate(prs):
            L[a, b] = g[i, k]*g[j, l] - g[j, k]*g[i, l]
    D = B.shape[0]
    Bf = B.reshape(D, N*N)
    out = np.einsum('mn,dnk,lk->dml', L, B, L)
    return Bf @ out.reshape(D, N*N).T

print("=== M3: does L_e commute with O(p)xO(q)? ===")
rng = np.random.default_rng(7)
for (p, q) in [(3,3),(3,5),(4,4),(4,5),(5,5)]:
    n = p+q
    B = weyl_basis(n)
    e, theta, _ = idempotent(p, q)
    L = Le_matrix(e, n, B)
    worst_so = worst_o = worst_bad = 0.0
    for trial in range(3):
        # SO(p) x SO(q)
        def rand_o(m, det):
            A, _ = np.linalg.qr(rng.normal(size=(m, m)))
            if np.linalg.det(A)*det < 0:
                A[:, 0] *= -1
            return A
        for dp, dq, which in ((1,1,'so'), (-1,1,'o'), (-1,-1,'o'), (1,-1,'o')):
            g = np.zeros((n, n))
            g[:p, :p] = rand_o(p, dp); g[p:, p:] = rand_o(q, dq)
            R = rep_on_weyl(g, n, B)
            err = np.abs(R @ L - L @ R).max()/np.abs(L).max()
            if which == 'so': worst_so = max(worst_so, err)
            else: worst_o = max(worst_o, err)
        # a control: a generic rotation of O(n) NOT preserving the splitting
        gA, _ = np.linalg.qr(rng.normal(size=(n, n)))
        R = rep_on_weyl(gA, n, B)
        worst_bad = max(worst_bad, np.abs(R @ L - L @ R).max()/np.abs(L).max())
    print(f"  ({p},{q}): |[rho,L_e]| SO(p)xSO(q) {worst_so:.2e} | full O(p)xO(q) {worst_o:.2e}"
          f" | control generic O(n) {worst_bad:.2e}")

print()
print("=== M7: multiplicity inside E(1/2) at (3,3) and neighbours ===")
for (p, q) in [(3,3),(3,4),(3,5),(3,6),(4,4)]:
    n = p+q
    B = weyl_basis(n); D = B.shape[0]
    prs, idx, C = struct(n); N = len(prs)
    Bf = B.reshape(D, N*N)
    def gen(a):
        A = C[a]
        out = np.einsum('mn,dnk->dmk', A, B) - np.einsum('dmn,nk->dmk', B, A)
        return Bf @ out.reshape(D, N*N).T
    gens = [gen(a) for a, (i, j) in enumerate(prs) if j < p or i >= p]
    rP = np.eye(n); rP[0, 0] = -1
    rQ = np.eye(n); rQ[p, p] = -1
    RP = rep_on_weyl(rP, n, B); RQ = rep_on_weyl(rQ, n, B)
    e, theta, _ = idempotent(p, q)
    L = Le_matrix(e, n, B); L = 0.5*(L+L.T)
    w, U = np.linalg.eigh(L)
    sel = np.abs(w - 0.5) < 1e-8
    Vb = U[:, sel]
    d = Vb.shape[1]
    cso = commutant_dim(Vb, gens)
    co  = commutant_dim(Vb, gens, extra=(RP, RQ))
    # characters of a reflection in the first factor on the block
    chiP = np.trace(Vb.T @ RP @ Vb)
    print(f"  ({p},{q}): dim E(1/2) = {d:3d} (orbit {p*q:3d})   "
          f"dim Comm_SO(p)xSO(q) = {cso}   dim Comm_O(p)xO(q) = {co}   "
          f"chi(reflection in O(p)) = {chiP:+.3f}")
