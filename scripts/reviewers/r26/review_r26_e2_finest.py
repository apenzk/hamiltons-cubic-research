"""E2 (d): FINEST Stab(W*)^0-invariant refinement of each L_e eigenspace, then re-test the
Z2-grading. Within each eigenspace we find a generic element of the commutant of the
so(m)+so(m) action by projecting a random symmetric matrix onto ker(Omega),
Omega = sum_k ad_{rho_k}^* ad_{rho_k}, via damped power iteration."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import numpy as np, sys, math
sys.path.insert(0,_os.path.join(_ROOT, 'scripts'))
from review_r26_core import *
from review_r26_e2_core import sphere_e, Lmap_on_weyl
from review_r26_e2_fusion import eigblocks, gf2_grading
from review_r26_e2_stab import ad_on_lambda2, rho_on_weyl, group_on_weyl, fusion_blocks


def stab_gens(n, C, B):
    m = n//2
    prs = basis_pairs(n); idx = {p: k for k, p in enumerate(prs)}
    N = len(prs)
    gens = []
    for (lo, hi) in [(0, m), (m, n)]:
        for i in range(lo, hi):
            for j in range(i+1, hi):
                v = np.zeros(N); v[idx[(i, j)]] = 1.0
                gens.append(rho_on_weyl(ad_on_lambda2(v, C), B))
    return gens


def commutant_generic(rhos, d, iters=3000, seed=2):
    rng = np.random.default_rng(seed)
    X = rng.normal(size=(d, d)); X = X + X.T
    def Om(Y):
        out = np.zeros_like(Y)
        for r in rhos:
            Cm = r @ Y - Y @ r
            out += r @ Cm - Cm @ r
        return -out              # ad^* ad, PSD
    # power bound
    Z = rng.normal(size=(d, d)); Z = Z+Z.T
    for _ in range(30):
        Z = Om(Z); nz = np.linalg.norm(Z)
        if nz == 0: break
        Z /= nz
    L = max(np.linalg.norm(Om(Z)), 1e-9)
    for _ in range(iters):
        X = X - (1.0/L)*Om(X)
        X /= max(np.linalg.norm(X), 1e-300)
    resid = max(np.linalg.norm(r@X - X@r) for r in rhos)/max(np.linalg.norm(X), 1e-30)
    return (X+X.T)/2, resid


def orbit_tangent(n, C, B, e):
    """span of [D_A, W*] for A in so(n): the tangent to the SO(n)-orbit."""
    N = C.shape[0]; K = B.shape[0]
    W = e
    cols = []
    for a in range(N):
        v = np.zeros(N); v[a] = 1.0
        D = ad_on_lambda2(v, C)
        M = D @ W - W @ D
        cols.append(np.einsum('kab,ab->k', B, M))
    A = np.array(cols).T
    U, s, _ = np.linalg.svd(A, full_matrices=False)
    r = int((s > 1e-9*max(s[0], 1)).sum())
    return U[:, :r]


def run(n, nprobe=2):
    e, th, C, B, W = sphere_e(n)
    K = B.shape[0]; m = n//2
    Le = Lmap_on_weyl(e, C, B)
    ev, U, blocks = eigblocks(Le)
    rhos = stab_gens(n, C, B)
    T = orbit_tangent(n, C, B, e)
    print(f"\n{'='*95}\nn={n}: dim Weyl={K}, blocks {[(round(l,10), t-s) for (l,s,t) in blocks]}")
    print(f"  orbit tangent dim = {T.shape[1]}  (m^2 = {m*m}; dim SO(n)-dim Stab = "
          f"{n*(n-1)//2 - 2*(m*(m-1)//2)})")
    # which L_e eigenvalue carries the orbit tangent
    for (l, s, t) in blocks:
        frac = np.linalg.norm(U[:, s:t].T @ T)**2 / T.shape[1]
        if frac > 1e-8:
            print(f"    orbit tangent mass in E({l:+.6f}) = {frac:.6f}")
    fine = []
    for (l, s, t) in blocks:
        Us = U[:, s:t]; d = t-s
        rl = [Us.T @ r @ Us for r in rhos]
        if d == 1:
            fine.append(((round(l, 8), 0), Us)); continue
        X, resid = commutant_generic(rl, d)
        w2, V = np.linalg.eigh(X)
        # cluster
        cuts = [0] + [i for i in range(1, d) if w2[i]-w2[i-1] > 1e-6] + [d]
        parts = [(cuts[i], cuts[i+1]) for i in range(len(cuts)-1)]
        print(f"    E({l:+.8f}) dim {d}: commutant residual {resid:.2e}; "
              f"splits into dims {[b-a for a,b in parts]}")
        for q, (a, b) in enumerate(parts):
            fine.append(((round(l, 8), q), Us @ V[:, a:b]))
    print(f"  finest refinement: {len(fine)} blocks, dims {[Uu.shape[1] for _,Uu in fine]}")
    F = fusion_blocks(fine, C, B, nprobe=nprobe)
    sc = F.max()
    nz = np.sort(F.flatten()); pos = nz[nz > 1e-18*sc]
    print(f"  separation: smallest nonzero {pos[0]/sc:.2e}*max, largest zero "
          f"{(nz[nz<=1e-18*sc][-1]/sc if (nz<=1e-18*sc).any() else 0):.2e}*max")
    for tr in [1e-14, 1e-10, 1e-7, 1e-5]:
        d_, sols = gf2_grading(F, fine, tr*sc)
        print(f"  GF(2) grading dim at threshold {tr:g}*max: {d_}"
              + ("  -> only trivial" if d_ == 0 else "  -> NONTRIVIAL"))
        if d_ > 0:
            labs = [lab for lab, _ in fine]
            for s_ in sols:
                print("      sigma=-1 on", [labs[i] for i in range(len(fine)) if s_[i] == 1])


if __name__ == '__main__':
    for n in [int(x) for x in sys.argv[1:]] or [6]:
        run(n)
