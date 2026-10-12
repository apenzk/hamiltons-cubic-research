"""Is (A) => (B)?  Build a sign-graded Weyl operator whose grading is of
u(m) type, then enumerate every Lie-algebra involution of so(n) commuting
with it and classify each as Lambda^2(sigma) with sigma^2 = +I (an involution
of R^n) or sigma^2 = -I (a complex structure)."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib317 as L, points317 as PT

n = 8; m = 4
c = L.structure_constants(n)
ns, coords, N = L.weyl_basis(n)
ker = np.load('scripts/reviewers/r317/kerJ_n8.npy')       # coeffs in ns basis
J = np.zeros((n, n))
for a in range(m):
    J[2*a, 2*a+1] = 1.0; J[2*a+1, 2*a] = -1.0
AdJ = L.Lambda2(J, n)
evJ, VJ = np.linalg.eigh(AdJ)
pb = VJ[:, evJ > 0.5]

Wcp, _ = PT.cpm(m)
Wcp = Wcp / np.linalg.norm(Wcp)

rng = np.random.default_rng(317)
mats = [L.coords_to_M(ns[d], coords, N) for d in range(ns.shape[0])]

def rand_commuting():
    v = rng.normal(size=ker.shape[0]) @ ker
    M = sum(v[d] * mats[d] for d in range(len(mats)))
    return M / np.linalg.norm(M)

for trial, eps in enumerate([0.05, 0.15, 0.3]):
    Wr = rand_commuting()
    W = Wcp + eps * Wr
    W = W / np.linalg.norm(W)
    ev = np.linalg.eigvalsh(W)
    npos = int((ev > 1e-9).sum()); nneg = int((ev < -1e-9).sum())
    S = L.S_components(W, c)
    D, _ = L.defect_Delta(W, c)
    res, th = L.crit_residual(W, c)
    print(f'\n--- eps={eps}: dims(+,-,0)=({npos},{nneg},{N-npos-nneg}) '
          f'S_mmm={S["S_mmm"]:.2e} S_mpp={S["S_mpp"]:.2e} Delta={D:.3f} theta={th:.6f} crit-res={res:.2e}')
    simple, V, evs, basis, free = L.gradings_in_eigenbasis(W, c)
    print('   simple spectrum:', simple, ' GF(2) solution-space dim =', len(basis))
    seen = []
    for k in range(1 << len(basis)):
        v = np.zeros(N, dtype=np.uint8)
        for b in range(len(basis)):
            if (k >> b) & 1:
                v ^= basis[b]
        eps_signs = 1.0 - 2.0 * v
        theta = V @ np.diag(eps_signs) @ V.T
        # verify automorphism of so(n)
        cT = np.einsum('abc,ax,by,cz->xyz', c, theta, theta, theta)
        err = np.abs(cT - c).max()
        h = V[:, v == 0]
        dimfix = h.shape[1]
        if dimfix == N:
            label = 'identity'
        else:
            dcs = L.commutant_sym_on_Rn(h, n)
            label = f'fix dim {dimfix}, sym-commutant of fix on R^n = {dcs}'
        print(f'   involution {k}: aut-err={err:.1e}  {label}')
