"""Reviewer 109, independent implementation. Fence post 25 audit.

Builds random algebraic Weyl tensors, the Lambda^2 operator M, the eigenframe in
so(n) with the unnormalised basis phi_ij = E_ij - E_ji, the triple T, the pair
marginal R, and g_gamma = ||[ad(v_gamma), W]||^2.  Then checks every step of the
claimed collapse chain, and compares the recorded bound against the recorded
sharpened bound (which uses g's distribution over the sign strata).
"""
import numpy as np

rng = np.random.default_rng(109)


# ---------------------------------------------------------------- Weyl tensors
def kn(A, B, n):
    """Kulkarni-Nomizu product."""
    out = np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
    out -= np.einsum('il,jk->ijkl', A, B) + np.einsum('jk,il->ijkl', A, B)
    return out


def random_weyl(n):
    R = rng.standard_normal((n, n, n, n))
    R = R - R.transpose(1, 0, 2, 3)
    R = R - R.transpose(0, 1, 3, 2)
    R = R + R.transpose(2, 3, 0, 1)
    b = (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
    R = R - b                                  # first Bianchi
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R)
    S = np.trace(Ric)
    Ric0 = Ric - (S / n) * g
    W = R - kn(Ric0, g, n) / (n - 2) - S / (2 * n * (n - 1)) * kn(g, g, n)
    return W


def checks_weyl(W, n):
    e = [np.abs(W + W.transpose(1, 0, 2, 3)).max(),
         np.abs(W + W.transpose(0, 1, 3, 2)).max(),
         np.abs(W - W.transpose(2, 3, 0, 1)).max(),
         np.abs(W + W.transpose(0, 2, 3, 1) + W.transpose(0, 3, 1, 2)).max(),
         np.abs(np.einsum('ikjk->ij', W)).max()]
    return max(e)


# ------------------------------------------------------- Lambda^2 <-> so(n)
def pairs(n):
    return [(i, j) for i in range(n) for j in range(i + 1, n)]


def phi_basis(n):
    """phi_ij = E_ij - E_ji, one per pair i<j.  Declared orthonormal, i.e. the
    inner product on so(n) is <X,Y> = tr(X^T Y)/2."""
    P = pairs(n)
    B = np.zeros((len(P), n, n))
    for a, (i, j) in enumerate(P):
        B[a, i, j] = 1.0
        B[a, j, i] = -1.0
    return B, P


def ip(X, Y):
    return 0.5 * np.einsum('...ij,...ij->...', X, Y)


def operator(W, n):
    P = pairs(n)
    N = len(P)
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(P):
        for b, (k, l) in enumerate(P):
            M[a, b] = W[i, j, k, l]
    return M


# --------------------------------------------------------------------- run
def analyse(n, seed_tag=''):
    W = random_weyl(n)
    sym = checks_weyl(W, n)
    M = operator(W, n)
    M = M / np.linalg.norm(M)
    lam, V = np.linalg.eigh(M)              # columns are eigenvectors in phi basis
    B, P = phi_basis(n)
    N = len(P)

    # eigenvectors as so(n) matrices
    Vso = np.einsum('ba,bij->aij', V, B)    # Vso[alpha] = sum_b V[b,alpha] phi_b

    # structure triple T[g,a,b] = <[v_a,v_b], v_g>^2
    comm = np.einsum('aik,bkj->abij', Vso, Vso) - np.einsum('bik,akj->abij', Vso, Vso)
    C = 0.5 * np.einsum('abij,gij->gab', comm, Vso)   # C[g,a,b] = <[v_a,v_b],v_g>
    T = C ** 2

    # total symmetry check
    tot = max(np.abs(T - T.transpose(1, 0, 2)).max(),
              np.abs(T - T.transpose(0, 2, 1)).max(),
              np.abs(T - T.transpose(2, 1, 0)).max())

    Rm = T.sum(axis=2)                       # R[g,a] = sum_b T[g,a,b]
    rho = Rm.sum(axis=1)                     # row marginal, expect 2(n-2)

    # ad(v_gamma) on Lambda^2, in the phi (orthonormal) basis
    ad = np.zeros((N, N, N))
    commB = np.einsum('gik,bkj->gbij', Vso, B) - np.einsum('bik,gkj->gbij', B, Vso)
    ad = 0.5 * np.einsum('gbij,aij->gab', commB, B)   # ad[g][a,b] = <[v_g,phi_b],phi_a>

    gvec = np.array([np.linalg.norm(ad[g] @ M - M @ ad[g]) ** 2 for g in range(N)])

    # Prop 1.7 as an independent formula
    diff2 = (lam[:, None] - lam[None, :]) ** 2
    g_pw = np.einsum('gab,ab->g', T, diff2)

    # theta, from the Lie-algebra sharp
    p3 = float((lam ** 3).sum())
    sharp = 0.5 * np.einsum('gab,g,a,b->', T, lam, lam, lam)
    theta = p3 + sharp

    # theta, independently from index contractions (calibrated constant checked below)
    tr3 = np.trace(np.linalg.matrix_power(M, 3))

    out = dict(n=n, sym=sym, tot=tot, rho_err=np.abs(rho - 2 * (n - 2)).max(),
               prop17=np.abs(gvec - g_pw).max(),
               sumg=gvec.sum(), sumg_err=abs(gvec.sum() - 4 * (n - 1)),
               perrow=np.abs(Rm @ lam + 2 * lam).max(),
               lamg=float(lam @ gvec), theta=theta, p3=p3, sharp=sharp,
               tr3_vs_p3=abs(tr3 - p3),
               lamg_err=abs(float(lam @ gvec) + 4 * theta),
               lam=lam, g=gvec, T=T, Rm=Rm, M=M)
    return out


def collapse_terms(o):
    lam, T, Rm = o['lam'], o['T'], o['Rm']
    full = np.einsum('gab,g,a,b->', T, lam, lam ** 2, np.ones_like(lam) * 0 + 1)
    # term1 = sum_{g,a} lam_g lam_a^2 R[g,a]
    term1 = np.einsum('ga,g,a->', Rm, lam, lam ** 2)
    term2 = np.einsum('gab,g,a,b->', T, lam, lam, lam)
    lhs = np.einsum('gab,g,ab->', T, lam, (lam[:, None] - lam[None, :]) ** 2)
    return term1, term2, lhs, 2 * term1 - 2 * term2


for n in (5, 6, 7):
    o = analyse(n)
    t1, t2, lhs, recon = collapse_terms(o)
    print(f"n={n}")
    print(f"  Weyl symmetry residual      {o['sym']:.2e}")
    print(f"  T totally symmetric         {o['tot']:.2e}")
    print(f"  row marginal rho = 2(n-2)   {o['rho_err']:.2e}")
    print(f"  Prop 1.7 (g vs T-formula)   {o['prop17']:.2e}")
    print(f"  sum g = 4(n-1)={4*(n-1)}      value {o['sumg']:.12f}  err {o['sumg_err']:.2e}")
    print(f"  per-row  sum_b lam_b R_ab = -2 lam_a   err {o['perrow']:.2e}")
    print(f"  tr(M^3) vs p3               {o['tr3_vs_p3']:.2e}")
    print(f"  theta = {o['theta']:.12f}   (p3={o['p3']:.6f}, <W#,W>={o['sharp']:.6f})")
    print(f"  sum lam g = {o['lamg']:.12f}  vs -4 theta = {-4*o['theta']:.12f}  err {o['lamg_err']:.2e}")
    print(f"  expansion: 2*term1-2*term2 = {recon:.12f} vs lhs {lhs:.12f} err {abs(recon-lhs):.2e}")
    print(f"  term1 = {t1:.12f}   vs -2 p3 = {-2*o['p3']:.12f}  err {abs(t1+2*o['p3']):.2e}")
    print(f"  term2 = {t2:.12f}   vs 2<W#,W> = {2*o['sharp']:.12f}  err {abs(t2-2*o['sharp']):.2e}")
    print()
