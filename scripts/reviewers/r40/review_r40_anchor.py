"""Reviewer 40 -- anchor the normalisation: theta_0(n) at S^p x S^q and sqrt(3/2) at the Fox point."""
import numpy as np
from review_r40_core import (pairs_of, so_basis, struct_const, Qop, ip, weyl_basis,
                             project, coords, rho_alg, L_matrix)

LOG = '../agent_logs/review_r40_cpm.log'


def log(msg):
    print(msg, flush=True)
    with open(LOG, 'a') as f:
        f.write(msg + '\n')


def sphere_product_weyl(n, p, A, Bs, prs):
    """O(p)xO(q)-invariant element of Weyl_n, unit norm, positive branch."""
    q = n - p
    P = list(range(p))
    gens = []
    B, _, _ = so_basis(n)
    for a, (i, j) in enumerate(prs):
        if (i < p) == (j < p):
            gens.append(B[a])
    D = Bs.shape[0]
    stack = []
    for E in gens:
        r = rho_alg(n, E, prs)
        img = np.einsum('ij,cjk->cik', r, Bs) - np.einsum('cij,jk->cik', Bs, r)
        stack.append(np.einsum('dij,cij->dc', Bs, img))
    S = np.vstack(stack)
    sv = np.linalg.svd(S, compute_uv=False)
    U, s, Vt = np.linalg.svd(S)
    tol = max(S.shape) * s[0] * 1e-11
    rank = int(np.sum(s > tol))
    ns = Vt[rank:]
    return ns, rank


def main():
    log("=== anchoring the normalisation ===")
    for (n, p) in [(6, 3), (8, 4), (8, 3), (10, 5), (12, 6)]:
        A = struct_const(n)
        Bs, prs, idx = weyl_basis(n)
        ns, rank = sphere_product_weyl(n, p, A, Bs, prs)
        if ns.shape[0] != 1:
            log(f"  n={n} p={p}: invariant dim {ns.shape[0]} -- skip")
            continue
        W = np.einsum('d,dij->ij', ns[0], Bs)
        W = W / np.sqrt(ip(W, W))
        th = ip(W, Qop(A, W))
        if th < 0:
            W = -W
            th = ip(W, Qop(A, W))
        res = np.max(np.abs(Qop(A, W) - th * W))
        th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
        thpq = np.sqrt(2) * np.sqrt((p - 1) / p * (n - p - 1) / (n - p) * (n - 1) / (n - 2))
        log(f"  S^{p}xS^{n-p}: theta_mine = {th:.10f}  resid {res:.1e} | "
            f"theta_0(n)={th0:.10f} ratio {th/th0:.10f} | Nienhaus2.25 theta_kl={thpq:.10f}"
            f" ratio {th/thpq:.10f}")

    # Fox point: CP^2 Weyl operator in dim 4, zero-padded.  diag(0,0,0,-1,-1,2)/sqrt6
    for n in (6, 8, 10):
        A = struct_const(n)
        Bs, prs, idx = weyl_basis(n)
        N = len(prs)
        W = np.zeros((N, N))
        vals = {(0, 1): 0.0, (0, 2): 0.0, (0, 3): 0.0, (1, 2): 0.0, (1, 3): 0.0, (2, 3): 0.0}
        # Weyl operator of CP^2 in dim 4 on Lambda^2(R^4) w.r.t. the standard basis
        # eigenvalues (0,0,0,-1,-1,2)/sqrt6 in the (self-dual/anti-self-dual) frame.
        # Build it as the J-invariant traceless piece: W = c (3 P_J - I_{Lambda^2(R^4)}) form.
        J = np.zeros((4, 4)); J[0, 1] = 1; J[1, 0] = -1; J[2, 3] = 1; J[3, 2] = -1
        # omega = J as a 2-form; its bivector in the phi-basis of Lambda^2(R^4)
        om = np.zeros(N)
        for a, (i, j) in enumerate(prs):
            if i < 4 and j < 4:
                om[a] = J[i, j]
        om = om / np.linalg.norm(om)
        # anti-self-dual part of Lambda^2(R^4)
        idx4 = [a for a, (i, j) in enumerate(prs) if j < 4]
        P4 = np.zeros((N, N))
        for a in idx4:
            P4[a, a] = 1.0
        # Hodge star on Lambda^2(R^4) in the phi basis
        star = np.zeros((N, N))
        pairmap = {(0, 1): (2, 3), (0, 2): (1, 3), (0, 3): (1, 2),
                   (1, 2): (0, 3), (1, 3): (0, 2), (2, 3): (0, 1)}
        sgn = {(0, 1): 1, (2, 3): 1, (0, 2): -1, (1, 3): -1, (0, 3): 1, (1, 2): 1}
        for (i, j), (k, l) in pairmap.items():
            star[idx[(k, l)], idx[(i, j)]] = sgn[(i, j)]
        Pminus = 0.5 * (P4 - star)
        # W_CP2 = (2 om om^T - Pminus) normalised  -> eigenvalues (2,-1,-1) on Lambda^-
        Wc = 2 * np.outer(om, om) - Pminus
        Wc = Wc / np.sqrt(ip(Wc, Wc))
        r = np.max(np.abs(Wc - project(Bs, Wc)))
        th = ip(Wc, Qop(A, Wc))
        if th < 0:
            Wc = -Wc; th = ip(Wc, Qop(A, Wc))
        res = np.max(np.abs(Qop(A, Wc) - th * Wc))
        log(f"  Fox point padded into n={n}: in-Weyl resid {r:.1e}, theta = {th:.10f}, "
            f"crit resid {res:.1e}, theta/sqrt(3/2) = {th/np.sqrt(1.5):.10f}")


if __name__ == '__main__':
    main()
