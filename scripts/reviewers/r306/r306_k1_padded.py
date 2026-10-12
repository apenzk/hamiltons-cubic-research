"""K1's counterexample: padded (isolated-vertex) diagonal critical points are
disconnected with dim ker M = #components, have theta > 0, and have
lambda_max(L_e) well BELOW 1 -- so the component-indicator family is radial there."""
import sys, os, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r306_defs as R
from r306_weyl import weyl_basis_fast, L_operator_full
from r306_k1 import comps

pool = pickle.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pool.pkl'), 'rb'))


def pad(M, k):
    n = M.shape[0]; out = np.zeros((n + k, n + k)); out[:n, :n] = M; return out


def full_lam(M):
    n = M.shape[0]; alg = R.Algebra(n); W = R.diag_operator(M); th = alg.P(W)
    B = weyl_basis_fast(n); Bm = np.array([b.ravel() for b in B]).T
    Lk = Bm.T @ (L_operator_full(alg, W) / th @ Bm)
    w = Bm.T @ W.ravel(); w /= np.linalg.norm(w)
    P = np.eye(len(B)) - np.outer(w, w)
    return np.linalg.eigvalsh(P @ ((Lk + Lk.T) / 2) @ P)[-1]


if __name__ == '__main__':
    print(f'{"point":26s} {"n":>3s} {"comp":>4s} {"dimker":>6s} {"theta":>10s} {"diag lam":>9s} {"full lam":>9s} {"indicator N":>12s}')
    for name in ['S2xS2', 'S3xS3', 'S3xS4', 'S4xS4', 'sol_n6_th0.30861', 'C5blowup2']:
        for k in (1, 2):
            M = pad(pool[name], k); n = M.shape[0]; th = R.theta_diag(M)
            c, lab = comps(M)
            dk = int(np.sum(np.abs(np.linalg.eigvalsh(M)) < 1e-9))
            dl, _ = R.diag_lam_max(M, th)
            a = np.zeros(c); a[0] = 1.0; a[1] = -1.0
            av = a[lab]; N = 2 * M * (av[:, None] + av[None, :])
            cos = np.sum(N * M) / max(np.linalg.norm(N), 1e-300) / np.linalg.norm(M)
            fl = full_lam(M) if n <= 9 else float('nan')
            print(f'{name + " pad" + str(k):26s} {n:3d} {c:4d} {dk:6d} {th:10.6f} {dl:9.6f} {fl:9.6f}  cos(N,M)={cos:+.6f}')
