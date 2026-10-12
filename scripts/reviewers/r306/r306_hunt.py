"""Census of critical points of P on Weyl_8, with the analytic Jacobian.

Reports for each: theta, Delta, diagonality (frame-independent), lambda_max(L_e|e-perp).
The prize is a critical point with Delta > 0 and lambda_max(L_e) <= 1/2 -- which refutes V3.
"""
import sys, os, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r306_defs as R
from r306_weyl import weyl_basis_fast, L_operator_full
from r306_defect import defect

n = int(sys.argv[1]) if len(sys.argv) > 1 else 8
NSTART = int(sys.argv[2]) if len(sys.argv) > 2 else 200
SEED = int(sys.argv[3]) if len(sys.argv) > 3 else 306

alg = R.Algebra(n)
B = weyl_basis_fast(n)
Bm = np.array([b.ravel() for b in B]).T          # D^2 x k
k = len(B)
rng = np.random.default_rng(SEED)
D = alg.D


def to_mat(y):
    return (Bm @ y).reshape(D, D)


def coords(X):
    return Bm.T @ X.ravel()


def F(y):
    W = to_mat(y)
    QW = alg.Q(W)
    th = float(np.sum(W * QW))
    return coords(QW - th * W), W, QW, th


def newton(y0, iters=200):
    y = y0.copy()
    for it in range(iters):
        f, W, QW, th = F(y)
        f = np.append(f, np.sum(W * W) - 1.0)
        if np.max(np.abs(f)) < 1e-13:
            return y, np.max(np.abs(f))
        Lop = L_operator_full(alg, W)
        Lk = Bm.T @ (Lop @ Bm)
        q = coords(QW); w = coords(W)
        J = 2 * Lk - 3 * np.outer(w, q) - th * np.eye(k)
        J = np.vstack([J, 2 * w])
        step, *_ = np.linalg.lstsq(J, -f, rcond=None)
        nrm = np.linalg.norm(step)
        if nrm > 0.5:
            step *= 0.5 / nrm
        y = y + step
    f, W, QW, th = F(y)
    f = np.append(f, np.sum(W * W) - 1.0)
    return y, np.max(np.abs(f))


def diagonality(W, tol=1e-8):
    """Frame-independent: W is diagonal in some frame iff some A in ker Phi_W
    has pairwise-distinct sums a_i + a_j, where Phi_W(A) = [W, D_A]."""
    Bs = R.basis_so(n)
    sym = []
    for i in range(n):
        E = np.zeros((n, n)); E[i, i] = 1.0; sym.append(E)
    for i in range(n):
        for j in range(i + 1, n):
            E = np.zeros((n, n)); E[i, j] = E[j, i] = 1 / np.sqrt(2); sym.append(E)
    cols = []
    for A in sym:
        Dm = np.zeros((D, D))
        for a in range(D):
            Y = A @ Bs[a] + Bs[a] @ A
            for b in range(D):
                Dm[b, a] = np.sum(Bs[b] * Y)
        cols.append((W @ Dm - Dm @ W).ravel())
    Mm = np.array(cols).T
    u, s, vt = np.linalg.svd(Mm)
    dim = int(np.sum(s < tol * max(s[0], 1e-30)))
    if dim == 0:
        return False, 0
    ker = vt[len(s) - dim:] if dim else None
    # a generic kernel element
    for _ in range(6):
        cc = rng.normal(size=dim)
        A = sum(cc[i] * sym[j] * 0 for i, j in [])  # placeholder
        A = np.zeros((n, n))
        for i in range(dim):
            A = A + cc[i] * sum(ker[i][j] * sym[j] for j in range(len(sym)))
        a = np.linalg.eigvalsh(A)
        sums = sorted(a[i] + a[j] for i in range(n) for j in range(i + 1, n))
        if min(np.diff(sums)) > 1e-7:
            return True, dim
    return False, dim


def lam_max(W, th):
    Lop = L_operator_full(alg, W) / th
    Lk = Bm.T @ (Lop @ Bm)
    w = coords(W); w = w / np.linalg.norm(w)
    P = np.eye(k) - np.outer(w, w)
    ev = np.linalg.eigvalsh(P @ ((Lk + Lk.T) / 2) @ P)
    return ev[-1]


if __name__ == '__main__':
    out = []
    for t in range(NSTART):
        y0 = rng.normal(size=k); y0 /= np.linalg.norm(y0)
        y, res = newton(y0)
        if res > 1e-12:
            continue
        W = to_mat(y); th = float(np.sum(W * alg.Q(W)))
        if th <= 1e-6:
            continue
        Dl, _ = defect(alg, W, scale=2.0)
        lm = lam_max(W, th)
        diag, kd = diagonality(W)
        lam = np.linalg.eigvalsh(W)
        rec = dict(theta=th, Delta=Dl, lam_max=lm, diagonal=bool(diag), kerdim=kd,
                   minabs=float(np.abs(lam).min()), res=float(res))
        out.append(rec)
        flag = ''
        if Dl > 1e-6 and lm <= 0.5 + 1e-9:
            flag = '   *** Delta>0 AND lam_max<=1/2 : V3 REFUTED ***'
        if Dl > 1e-6 and lm < 1.0:
            flag += '   [below the cushion]'
        print(f'[{t:4d}] theta={th:.9f} Delta={Dl:12.6f} lam_max={lm:.9f} diag={diag} kerPhi={kd} minlam={np.abs(lam).min():.2e}{flag}', flush=True)
    json.dump(out, open(f'/tmp/r306_census_n{n}_{SEED}.json', 'w'))
    print('collected', len(out))
