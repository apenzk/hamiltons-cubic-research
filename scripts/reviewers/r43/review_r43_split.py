"""Reviewer 43, R3: the bilinear split of L_e, and the orbit-summand identification."""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r43_core import Ambient, frob
from review_r43_cpm import Umat, build_e, e_closed
from review_r43_hw import HW

rng = np.random.default_rng(431)

for m in [3, 4, 5, 6]:
    amb, U, e, (a, b, c) = build_e(m)
    N = amb.N
    B = amb.weyl_basis()
    print(f'--- m={m} n={2*m} dimWeyl={B.shape[0]} ---')
    # (i) sb(Id, X) = -X on Weyl_n
    errs = []
    for _ in range(3):
        X = np.einsum('k,kij->ij', rng.standard_normal(B.shape[0]), B)
        X /= np.linalg.norm(X)
        errs.append(np.abs(amb.sharp(np.eye(N), X) + X).max())
    print(f'  sb(Id,X) = -X on Weyl        max err {max(errs):.2e}')
    # sb(Id,X) off Weyl?
    Y = rng.standard_normal((N, N)); Y = (Y + Y.T); Y /= np.linalg.norm(Y)
    print(f'  sb(Id,Y) = -Y off Weyl       max err {np.abs(amb.sharp(np.eye(N), Y) + Y).max():.2e}  (expected to FAIL)')
    # (ii) the split identity
    errs = []
    for _ in range(3):
        X = np.einsum('k,kij->ij', rng.standard_normal(B.shape[0]), B); X /= np.linalg.norm(X)
        lhs = amb.circ(e, X)
        rhs = (0.5 * (e @ X + X @ e) + float(a) * amb.sharp(np.eye(N), X)
               + float(b - a) * amb.sharp(U.P_u, X) + float(c - b) * amb.sharp(U.P_omega, X))
        errs.append(np.abs(lhs - rhs).max())
    print(f'  split identity               max err {max(errs):.2e}')
    # (iii) the orbit
    J = U.J
    def rho(g):
        R = np.zeros((N, N))
        for k in range(N):
            C = g @ amb.phi[k] - amb.phi[k] @ g
            R[:, k] = [C[i, j] for (i, j) in amb.pairs]
        return R
    W = e / np.linalg.norm(e)
    # su(m) and u(m) stabilise W?
    stab = 0.0
    for _ in range(3):
        X = rng.standard_normal((2 * m, 2 * m)); X = X - X.T
        g = 0.5 * (X - J @ X @ J)                     # u(m)
        R = rho(g)
        stab = max(stab, np.abs(R @ W - W @ R).max() / np.abs(R).max())
    print(f'  u(m) stabilises W            max |[rho(g),W]| {stab:.2e}')
    # orbit tangents from the m-part
    tang = []
    for k in range(N):
        g = np.einsum('q,qij->ij', U.P_m[:, k], amb.phi)
        if np.abs(g).max() < 1e-12: continue
        R = rho(g)
        tang.append((R @ W - W @ R).ravel())
    Tg = np.array(tang)
    s = np.linalg.svd(Tg, compute_uv=False)
    r = int((s > 1e-8 * s[0]).sum())
    _, _, vt = np.linalg.svd(Tg)
    On = vt[:r]
    print(f'  dim orbit tangent            {r}   (m(m-1) = {m*(m-1)})')
    # does the orbit highest-weight vector lie in the complexified orbit tangent?
    H = HW(m)
    v = H.pw(H.odot(H.wedge(H.f[0], H.f[1]), U.omega.astype(complex)))
    v = v.ravel() / np.linalg.norm(v)
    proj = On.T @ (On @ v)
    print(f'  orbit h.w. vector in tangent  1 - |proj| = {1-np.linalg.norm(proj):.2e}')
    # (iv) R4's extra orbit claims: sb(P_u) and sb(P_omega) on the orbit
    X = np.einsum('k,kij->ij', On[0], B * 0 + 0) if False else On[0].reshape(N, N)
    X /= np.linalg.norm(X)
    su_ = amb.sharp(U.P_u, X); so_ = amb.sharp(U.P_omega, X)
    print(f'  on orbit: sb(P_u,X)/X ratio  {frob(X,su_):.9f} (claim (m-2)/6 = {(m-2)/6:.9f}), '
          f'residual {np.linalg.norm(su_-frob(X,su_)*X):.1e}')
    print(f'            sb(P_om,X)/X ratio {frob(X,so_):.2e} (claim 0), '
          f'residual {np.linalg.norm(so_-frob(X,so_)*X):.1e}')
