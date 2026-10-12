"""r271: verify the ad-form identity of findings/ad-form-attempt.md against the record's own Q_general.

Checks
  (a) (M#)_{pq} = -1/2 tr(ad_{e_p} M ad_{e_q} M)  as MATRICES
  (b) <M#,M>    = -1/2 sum_{ab} M_ab tr(ad_{e_a} M ad_{e_b} M)
  (c) is M# in the Bianchi subspace (Lambda^4 component zero)?
  (d) size of ||ad_{e_a}||_op and the Cauchy-Schwarz bound the file derives.
"""
import numpy as np, sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))
sys.path.insert(0, "scripts/lib")
from weyl import (build_structure_constants, Q_general, bianchi_constraint_matrix,
                  vec_to_mat, mat_to_vec, R_val)

def weyl_basis_for(n):
    idx, pos, N, c = build_structure_constants(n)
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    Mdim = len(triu_idx)
    U, S, Vt = np.linalg.svd(Bmat)
    rank = int(np.sum(S > 1e-9 * S[0]))
    null_basis = Vt[rank:, :].T
    D = null_basis.shape[1]
    Rd = [vec_to_mat(null_basis[:, d], triu_idx, N) for d in range(D)]
    rows = []
    for i in range(n):
        for k in range(i, n):
            row = np.zeros(D)
            for j in range(n):
                if j == i or j == k: continue
                for d in range(D):
                    row[d] += R_val(Rd[d], pos, n, i, j, k, j)
            rows.append(row)
    Rm = np.array(rows)
    Ur, Sr, Vtr = np.linalg.svd(Rm)
    rr = int(np.sum(Sr > 1e-9 * Sr[0]))
    wb = null_basis @ Vtr[rr:, :].T
    return idx, pos, N, c, triu_idx, null_basis, wb

def ad_ops(c, N):
    """ad_a[g,b] = <[e_a,e_b], e_g> = c[a,b,g]."""
    return np.transpose(c, (0, 2, 1))   # ad[a][g,b]

def main():
    for n in (5, 6, 7):
        idx, pos, N, c, triu_idx, nullb, wb = weyl_basis_for(n)
        ad = ad_ops(c, N)
        rng = np.random.default_rng(2710 + n)
        print(f"\n=== n={n}  N={N}  dim Weyl={wb.shape[1]} ===")
        opn = np.array([np.linalg.norm(ad[a], 2) for a in range(N)])
        print(f"  ||ad_e_a||_op : min {opn.min():.6f} max {opn.max():.6f}  sum {opn.sum():.4f}  N*2={2*N}")
        for trial in range(3):
            v = wb @ rng.standard_normal(wb.shape[1])
            M = vec_to_mat(v, triu_idx, N)
            M /= np.linalg.norm(M)                       # ||M||_F = 1
            Q = Q_general(M, c)
            Msharp = Q - M @ M
            # (a) matrix form
            adM = np.einsum('agb,bd->agd', ad, M)        # ad_a . M
            Sform = -0.5 * np.einsum('agd,bdg->ab', adM, adM)   # -1/2 tr(ad_a M ad_b M)
            ea = np.linalg.norm(Sform - Msharp) / np.linalg.norm(Msharp)
            # (b) pairing
            lhs = float(np.tensordot(Msharp, M))
            rhs = -0.5 * float(np.einsum('ab,ab->', M, np.einsum('agd,bdg->ab', adM, adM)))
            # (c) Bianchi component of M#
            Bmat, ti, tp = bianchi_constraint_matrix(idx, pos, n, N)
            vs = mat_to_vec(Msharp, triu_idx)
            resid = np.linalg.norm(Bmat @ vs) / np.linalg.norm(vs)
            theta = float(np.tensordot(M, Q))
            print(f"  trial {trial}: relerr(matrix ad-form)={ea:.3e}  <M#,M>={lhs:+.8f} adform={rhs:+.8f} "
                  f"diff={abs(lhs-rhs):.3e}  Bianchi-resid(M#)={resid:.3e}  theta={theta:+.6f}")

    # (d) the file's Cauchy-Schwarz bound at n=12 (structure constants only, no Weyl tensor needed)
    print("\n=== Cauchy-Schwarz bound of ad-form-attempt.md, ||M||_F=1 ===")
    for n in (6, 8, 10, 12):
        idx, pos, N, c = build_structure_constants(n)
        ad = np.transpose(c, (0, 2, 1))
        opn = np.array([np.linalg.norm(ad[a], 2) for a in range(N)])
        s = opn.sum()
        sq = (opn**2).sum()
        # file's bound: 1/2 (sum ||ad||_op)^2 ||M||_F^2 max|M_ab|;  max|M_ab| <= 1 when ||M||_F=1
        print(f"  n={n:3d} N={N:3d}  sum||ad||_op={s:9.3f}  bound_file<= {0.5*s*s:12.2f}"
              f"   sharper(lam_max<=||M||_F): {0.5*sq:9.2f}")
    th0 = lambda n: np.sqrt(2*(n-1)*(n-2))/n
    print(f"  theta_0(12) = {th0(12):.6f}")

main()
