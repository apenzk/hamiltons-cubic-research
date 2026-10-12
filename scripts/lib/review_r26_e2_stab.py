"""E2 (d): refine the L_e eigenspaces by Stab(W*) and re-test the fusion law on the refinement."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import numpy as np, sys, math, itertools
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *
from review_r26_e2_core import sphere_e, Lmap_on_weyl
from review_r26_e2_fusion import eigblocks, gf2_grading


def ad_on_lambda2(Acoef, C):
    """D_A with (D_A)_{gb} = sum_a A_a c_{abg}; A given by its phi-coefficients."""
    return np.einsum('a,abg->gb', Acoef, C)


def rho_on_weyl(D, B):
    """infinitesimal action V -> [D,V], as a K x K matrix in the orthonormal Weyl basis"""
    K, N, _ = B.shape
    X = np.einsum('ab,kbc->kac', D, B, optimize=True) - np.einsum('kab,bc->kac', B, D, optimize=True)
    Bv = B.reshape(K, N*N)
    return Bv @ X.reshape(K, N*N).T          # M[l,k] = <B_l, [D,B_k]>


def group_on_weyl(g, C, B, n):
    """W -> L W L^T where L = Lambda^2(g) on Lambda^2 R^n, as a K x K matrix."""
    prs, idx = pair_index(n)
    N = len(prs)
    L = np.zeros((N, N))
    for k, (i, j) in enumerate(prs):
        # g.phi_ij = g phi_ij g^T ; coefficient on phi_kl is (g phi_ij g^T)_{kl}
        M = np.zeros((n, n)); M[i, j] = 1.0; M[j, i] = -1.0
        Mg = g @ M @ g.T
        L[:, k] = np.array([Mg[a, b] for (a, b) in prs])
    K = B.shape[0]
    X = np.einsum('ab,kbc,dc->kad', L, B, L, optimize=True)
    Bv = B.reshape(K, N*N)
    return Bv @ X.reshape(K, N*N).T


def stab_data(n):
    e, th, C, B, W = sphere_e(n)
    m = n//2
    prs = basis_pairs(n)
    idx = {p: k for k, p in enumerate(prs)}
    N = len(prs); K = B.shape[0]
    gen1, gen2 = [], []
    for i in range(m):
        for j in range(i+1, m):
            v = np.zeros(N); v[idx[(i, j)]] = 1.0; gen1.append(v)
    for i in range(m, n):
        for j in range(i+1, n):
            v = np.zeros(N); v[idx[(i, j)]] = 1.0; gen2.append(v)
    R1 = [rho_on_weyl(ad_on_lambda2(v, C), B) for v in gen1]
    R2 = [rho_on_weyl(ad_on_lambda2(v, C), B) for v in gen2]
    Cas1 = sum(r @ r for r in R1)
    Cas2 = sum(r @ r for r in R2)
    # swap
    g = np.zeros((n, n))
    for i in range(m):
        g[i, m+i] = 1.0; g[m+i, i] = 1.0
    Rsw = group_on_weyl(g, C, B, n)
    # check invariance of W* and commutation with L_e
    Le = Lmap_on_weyl(e, C, B)
    ecoef = np.einsum('kab,ab->k', B, e)
    inv = max(np.abs(r @ ecoef).max() for r in R1+R2)
    print(f"  n={n}: Stab generators {len(R1)}+{len(R2)}; |rho(A) e| max = {inv:.2e}; "
          f"|Rsw e - e| = {np.abs(Rsw@ecoef-ecoef).max():.2e}")
    print(f"         |[Cas1,L_e]| = {np.abs(Cas1@Le-Le@Cas1).max():.2e}  "
          f"|[Cas2,L_e]| = {np.abs(Cas2@Le-Le@Cas2).max():.2e}  "
          f"|[Rsw,L_e]| = {np.abs(Rsw@Le-Le@Rsw).max():.2e}  |Rsw^2-I| = {np.abs(Rsw@Rsw-np.eye(K)).max():.2e}")
    return e, th, C, B, Le, Cas1, Cas2, Rsw, R1, R2


def joint_blocks(ops, tol=1e-6):
    """joint eigenspace decomposition of a list of commuting symmetric K x K operators.
    Returns a list of (label tuple, orthonormal basis columns)."""
    K = ops[0].shape[0]
    blocks = [(tuple(), np.eye(K))]
    for op in ops:
        new = []
        for lab, U in blocks:
            Mr = U.T @ op @ U
            Mr = (Mr + Mr.T)/2
            ev, V = np.linalg.eigh(Mr)
            s = 0
            for i in range(1, len(ev)+1):
                if i == len(ev) or ev[i]-ev[i-1] > tol:
                    new.append((lab + (round(float(ev[s:i].mean()), 6),), U @ V[:, s:i]))
                    s = i
        blocks = new
    return blocks


def fusion_blocks(blocks, C, B, nprobe=2, seed=1):
    """F[x][y][z] via generic probes in block x and exact projectors for y,z"""
    rng = np.random.default_rng(seed)
    nb = len(blocks)
    Pr = [U @ U.T for (_, U) in blocks]
    F = np.zeros((nb, nb, nb))
    for x, (lab, U) in enumerate(blocks):
        for rep in range(nprobe):
            c = rng.normal(size=U.shape[1]); uc = U @ c; uc /= np.linalg.norm(uc)
            umat = np.einsum('k,kab->ab', uc, B)
            Lu = Lmap_on_weyl(umat, C, B)
            for y in range(nb):
                Ly = Lu @ Pr[y]
                for z in range(nb):
                    F[x, y, z] = max(F[x, y, z], ((Pr[z] @ Ly)**2).sum())
    return F


def run(n, nprobe=2):
    e, th, C, B, Le, Cas1, Cas2, Rsw = stab_data(n)[:8]
    for name, ops in [("L_e only", [Le]),
                      ("L_e + Cas1 + Cas2", [Le, Cas1, Cas2]),
                      ("L_e + Cas1 + Cas2 + swap", [Le, Cas1, Cas2, Rsw])]:
        bl = joint_blocks(ops)
        dims = [U.shape[1] for (_, U) in bl]
        print(f"\n  refinement [{name}]: {len(bl)} blocks, dims {sorted(dims, reverse=True)}")
        if name == "L_e + Cas1 + Cas2 + swap":
            # swap does not commute with Cas1, Cas2 individually -- verify block invariance
            pass
        F = fusion_blocks(bl, C, B, nprobe=nprobe)
        sc = F.max()
        for tr in [1e-14, 1e-10, 1e-7]:
            d, sols = gf2_grading(F, bl, tr*sc)
            msg = "only trivial" if d == 0 else f"NONTRIVIAL, dim {d}"
            print(f"     GF(2) grading dim at threshold {tr:g}*max : {d}  ({msg})")
            if d > 0 and tr == 1e-10:
                labs = [lab for (lab, _) in bl]
                for s in sols:
                    plus = [labs[i] for i in range(len(bl)) if s[i] == 0]
                    minus = [labs[i] for i in range(len(bl)) if s[i] == 1]
                    print(f"        sigma=+1 on {plus}")
                    print(f"        sigma=-1 on {minus}")
        nz = np.sort(F.flatten()); pos = nz[nz > 1e-18*sc]
        print(f"     separation: smallest nonzero {pos[0]/sc:.2e}*max ; "
              f"largest zero {nz[nz<=1e-18*sc][-1]/sc:.2e}*max")


if __name__ == '__main__':
    for n in [int(x) for x in sys.argv[1:]] or [6]:
        run(n)
