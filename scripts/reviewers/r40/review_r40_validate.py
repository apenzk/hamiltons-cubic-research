"""Reviewer 40 -- validation of the from-scratch machinery before any claim is tested."""
import sys, time
import numpy as np
from review_r40_core import (pairs_of, so_basis, struct_const, sharp, sharp_bilin, Qop,
                             circ, ip, weyl_basis, weyl_dim_formula, coords, project,
                             rho_alg, rho_grp, L_matrix, to_tensor)

rng = np.random.default_rng(40)


def log(msg):
    print(msg, flush=True)


def main():
    for n in (5, 6, 7, 8):
        t0 = time.time()
        A = struct_const(n)
        N = n * (n - 1) // 2
        Idn = np.eye(N)
        # V1: Id^# = (n-2) Id
        s = sharp(A, Idn)
        e1 = np.max(np.abs(s - (n - 2) * Idn))
        # V2: dim Weyl_n
        Bs, prs, idx = weyl_basis(n)
        D = Bs.shape[0]
        e2 = D - weyl_dim_formula(n)
        # V3: orthonormality
        Gram = np.einsum('dij,eij->de', Bs, Bs)
        e3 = np.max(np.abs(Gram - np.eye(D)))
        # V4: random Weyl elements really are Bianchi + Ricci flat
        c = rng.standard_normal(D)
        X = np.einsum('d,dij->ij', c, Bs)
        R = to_tensor(n, X, prs)
        bia = R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))
        ric = np.einsum('ijil->jl', R)
        e4 = (np.max(np.abs(bia)), np.max(np.abs(ric)), np.max(np.abs(X - X.T)))
        # V5: Q(Weyl) subset Weyl
        Y = np.einsum('d,dij->ij', rng.standard_normal(D), Bs)
        QX = Qop(A, X)
        e5 = np.max(np.abs(QX - project(Bs, QX)))
        # V6: trilinear symmetry <X o Y, Z> totally symmetric
        Z = np.einsum('d,dij->ij', rng.standard_normal(D), Bs)
        t_xyz = ip(circ(A, X, Y), Z)
        t_yzx = ip(circ(A, Y, Z), X)
        t_zxy = ip(circ(A, Z, X), Y)
        t_yxz = ip(circ(A, Y, X), Z)
        sc = max(abs(t_xyz), 1.0)
        e6 = max(abs(t_xyz - t_yzx), abs(t_xyz - t_zxy), abs(t_xyz - t_yxz)) / sc
        # V7: circ(X,X) == Q(X)
        e7 = np.max(np.abs(circ(A, X, X) - Qop(A, X)))
        # V8: tr(L_x) = 0 for x in Weyl
        Lx, res = L_matrix(A, Bs, X)
        e8 = abs(np.trace(Lx)) / max(1.0, np.linalg.norm(Lx))
        # V9: L_x symmetric, and image stays in Weyl
        e9 = np.max(np.abs(Lx - Lx.T))
        # V10: equivariance of Q under SO(n)
        Ee = rng.standard_normal((n, n))
        Ee = Ee - Ee.T
        from scipy.linalg import expm
        g = expm(Ee)
        rg = rho_grp(n, g, prs)
        e10 = np.max(np.abs(Qop(A, rg @ X @ rg.T) - rg @ Qop(A, X) @ rg.T))
        log(f"n={n}: Id#-(n-2)Id={e1:.2e}  dimWeyl-formula={e2}  orthon={e3:.2e}")
        log(f"      bianchi/ricci/sym={e4[0]:.1e}/{e4[1]:.1e}/{e4[2]:.1e}  Q(W) in Weyl={e5:.2e}")
        log(f"      trilinear sym={e6:.2e}  circ=Q={e7:.2e}  tr(L_x)={e8:.2e}  L sym={e9:.2e}")
        log(f"      L_x out-of-Weyl resid={res:.2e}  SO(n)-equivariance={e10:.2e}  [{time.time()-t0:.1f}s]")


if __name__ == '__main__':
    main()
