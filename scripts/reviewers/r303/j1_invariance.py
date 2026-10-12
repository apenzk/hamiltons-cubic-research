"""J1: does L_W preserve the diagonal locus, and is the n x n formula exact?
Tested at critical/symmetric, critical/asymmetric and NON-critical diagonal W,
and with H not in Weyl_n at all."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np
from core303 import Alg, diag_op, op_diag, offdiag_mass, sphere_product_M
from diagcore import V_basis, Lop, crit_residual, theta_of

rng = np.random.default_rng(303)


def rand_hollow_sym(n, zero_rows=True):
    B = V_basis(n) if zero_rows else None
    if zero_rows:
        x = rng.normal(size=len(B))
        return np.einsum('k,kij->ij', x, B)
    X = rng.normal(size=(n, n)); X = (X + X.T) / 2
    np.fill_diagonal(X, 0.0)
    return X


def report(tag, alg, M, N):
    W, H = diag_op(alg, M), diag_op(alg, N)
    LH = alg.L(W, H)
    odm = offdiag_mass(LH)
    nn = op_diag(alg, LH)
    pred_raw = M * N + 0.5 * (M @ N + N @ M)      # as literally stated
    pred = pred_raw.copy(); np.fill_diagonal(pred, 0.0)
    err = np.abs(nn - pred).max()
    diag_of_raw = np.abs(np.diag(pred_raw)).max()
    rows = np.abs(nn.sum(1)).max()
    print(f"{tag:34s} offdiagmass(L H)={odm:.2e}  nxn err={err:.2e} "
          f" spurious diag of raw formula={diag_of_raw:.3e}  rowsum(L N)={rows:.2e}")
    return odm, err


for n, p, q in [(8, 3, 5), (12, 6, 6)]:
    if n > 9:
        continue
    alg = Alg(n)
    M = sphere_product_M(p, q)
    for _ in range(3):
        report(f"S^{p}xS^{q} crit, N in V", alg, M, rand_hollow_sym(n))
    report(f"S^{p}xS^{q} crit, N NOT in V", alg, M, rand_hollow_sym(n, False))

# non-critical diagonal W, and H not Ricci-flat
for n in (6, 7, 8):
    alg = Alg(n)
    M = rand_hollow_sym(n, False)
    M *= np.sqrt(2 / np.sum(M * M))
    B = V_basis(n)
    print(f"n={n} NON-critical W: crit residual = {np.abs(crit_residual(M,B)).max():.3e}")
    report(f"  n={n} random M, random N", alg, M, rand_hollow_sym(n, False))
    report(f"  n={n} random M, N in V", alg, M, rand_hollow_sym(n))
