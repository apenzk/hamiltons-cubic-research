"""r229 claim 3+4: independent rebuild of the omega-spectrum at the balanced
sphere product, from definitions, and audit of the numbers in the docstring of
scripts/runs/run_second_kind_moment.py.

Nothing is imported from the file under review.  Li's convention for the
second-kind operator, arXiv:2112.08465 eq. (2.2):  (Wring h)_{ij} = sum_{k,l} W_{iklj} h_{kl}.
"""
import numpy as np, itertools

def diag_curv(K):
    """coordinate-diagonal algebraic curvature tensor with sectional curvatures K_ab."""
    n = K.shape[0]
    d = np.eye(n)
    R = np.einsum('ij,ik,jl->ijkl', K, d, d) - np.einsum('ij,il,jk->ijkl', K, d, d)
    return R

def weyl_part(R):
    n = R.shape[0]; g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric); E = Ric - s / n * g
    def KN(A, B):
        return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    return R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)

def checks(W):
    ric = np.abs(np.einsum('ikjk->ij', W)).max()
    bia = np.abs(W + W.transpose(1, 2, 0, 3) + W.transpose(2, 0, 1, 3)).max()
    sym = np.abs(W - W.transpose(2, 3, 0, 1)).max()
    return ric, bia, sym

def lam2(W):
    n = W.shape[0]; pr = list(itertools.combinations(range(n), 2))
    M = np.array([[W[i, j, k, l] for (k, l) in pr] for (i, j) in pr])
    return M

def ring_full(W):
    """W-ring as a matrix on ALL of Sym^2 in an orthonormal basis (dim n(n+1)/2)."""
    n = W.shape[0]; idx = [(i, j) for i in range(n) for j in range(i, n)]
    def b(i, j):
        h = np.zeros((n, n))
        if i == j: h[i, i] = 1.0
        else: h[i, j] = h[j, i] = 1 / np.sqrt(2)
        return h
    B = [b(i, j) for (i, j) in idx]
    Op = np.zeros((len(B), len(B)))
    for a, h in enumerate(B):
        Wh = np.einsum('iklj,kl->ij', W, h)
        for c, hc in enumerate(B): Op[a, c] = np.sum(Wh * hc)
    gvec = np.array([np.trace(h) for h in B]); gvec /= np.linalg.norm(gvec)
    return Op, gvec

def spec_sym2_0(W):
    Op, gvec = ring_full(W)
    # restrict to the g-orthogonal complement with an explicit orthonormal basis
    Q, _ = np.linalg.qr(np.eye(len(gvec)) - np.outer(gvec, gvec))
    # columns of Q spanning gvec^perp
    keep = [k for k in range(Q.shape[1]) if abs(Q[:, k] @ gvec) < 1e-10 and np.linalg.norm(Q[:, k]) > .5]
    Qk = Q[:, keep]
    assert Qk.shape[1] == len(gvec) - 1, (Qk.shape, len(gvec))
    return np.linalg.eigvalsh(Qk.T @ Op @ Qk), np.linalg.eigvalsh(Op), Op, gvec

def p(v, k): return float(np.sum(np.asarray(v) ** k))

print("balanced sphere product S^m x S^m, Weyl part, Li convention\n")
print(f"{'n':>4} {'|W|^2':>8} {'|M|_F':>8} {'p1(w)':>10} {'p2(w)':>10} {'p3(w)':>12} {'-min w':>10} "
      f"{'n/(n-1)th0':>12}")
rows = {}
for n in (12, 14, 16, 24):
    m = n // 2
    K = np.zeros((n, n))
    for a in range(n):
        for b_ in range(n):
            if a != b_ and (a < m) == (b_ < m): K[a, b_] = 1.0
    W = weyl_part(diag_curv(K))
    r, bi, sy = checks(W)
    assert max(r, bi, sy) < 1e-10, (r, bi, sy)
    # normalisation used by the record: ||M||_F = 1  (M = W on Lambda^2)
    M = lam2(W); W = W / np.linalg.norm(M); M = lam2(W)
    w0, wfull, Op, gvec = spec_sym2_0(W)
    W2 = np.einsum('ijkl,ijkl', W, W)
    t0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    rows[n] = (w0, wfull, W2, t0)
    print(f"{n:>4} {W2:>8.4f} {np.linalg.norm(M):>8.4f} {p(w0,1):>10.2e} {p(w0,2):>10.6f} "
          f"{p(w0,3):>12.6f} {-min(w0):>10.6f} {n/(n-1)*t0:>12.6f}")

print("\nsame, rescaled to the file's own normalisation p_2(omega) = 3/4  (i.e. |W|^2 = 1):")
print(f"{'n':>4} {'p1':>10} {'p2':>10} {'p3':>12} {'-min w':>10} {'file m ACTUAL':>14} {'file p3':>10}")
file_m = {12: 0.067420, 14: 0.056614, 16: 0.048795, 24: 0.031435}
file_p3 = {12: 0.300581, 14: 0.309354, 16: 0.315643, 24: 0.329410}
for n in (12, 14, 16, 24):
    w0, wfull, W2, t0 = rows[n]
    s = w0 / 2.0     # |W|^2 = 4 -> 1 halves W, hence omega
    print(f"{n:>4} {p(s,1):>10.2e} {p(s,2):>10.6f} {p(s,3):>12.6f} {-min(s):>10.6f} "
          f"{file_m[n]:>14.6f} {file_p3[n]:>10.6f}")

print("\nfull Sym^2 vs Sym^2_0 (record normalisation |M|_F = 1):")
print(f"{'n':>4} {'dim S2':>7} {'dim S20':>8} {'p2 full':>10} {'p2 0':>10} {'p3 full':>12} {'p3 0':>12} "
      f"{'g-eigval':>10}")
for n in (12, 14, 16, 24):
    w0, wfull, W2, t0 = rows[n]
    _, gv = None, None
    print(f"{n:>4} {len(wfull):>7} {len(w0):>8} {p(wfull,2):>10.6f} {p(w0,2):>10.6f} "
          f"{p(wfull,3):>12.6f} {p(w0,3):>12.6f} {p(wfull,2)-p(w0,2):>10.2e}")

print("\ndistinct omega values at n=12 (record normalisation), vs record's closed form:")
w0 = rows[12][0]
vals, cnt = np.unique(np.round(w0, 9), return_counts=True)
for v, c in zip(vals, cnt): print(f"   {v:>12.6f}  x{c}")
mm = 6; A = 1 / (mm * np.sqrt((mm - 1) * (2 * mm - 1)))
print(f"   record: mA={mm*A:.6f} x{(mm-1)*(mm+2)}, -(m-1)A={-(mm-1)*A:.6f} x{mm**2}, "
      f"-2m(m-1)A={-2*mm*(mm-1)*A:.6f} x1;  3A={3*A:.6f}")

# ---------------------------------------------------------------------------
# ROOT CAUSE.  The record warns (bispectral.md) that the opposite index order
# W_{ikjl} NEGATES the second-kind operator.  If the refutation's measurement
# used that order, then omega -> -omega, so p_3 flips sign and "-min omega"
# returns max omega instead.  Test both against the file's four reported numbers.
def ring_flipped(W):
    n = W.shape[0]; idx = [(i, j) for i in range(n) for j in range(i, n)]
    def b(i, j):
        h = np.zeros((n, n))
        if i == j: h[i, i] = 1.0
        else: h[i, j] = h[j, i] = 1 / np.sqrt(2)
        return h
    B = [b(i, j) for (i, j) in idx]
    Op = np.zeros((len(B), len(B)))
    for a, h in enumerate(B):
        Wh = np.einsum('ikjl,kl->ij', W, h)          # the OTHER order
        for c, hc in enumerate(B): Op[a, c] = np.sum(Wh * hc)
    gvec = np.array([np.trace(h) for h in B]); gvec /= np.linalg.norm(gvec)
    Q, _ = np.linalg.qr(np.eye(len(gvec)) - np.outer(gvec, gvec))
    keep = [k for k in range(Q.shape[1]) if abs(Q[:, k] @ gvec) < 1e-10 and np.linalg.norm(Q[:, k]) > .5]
    Qk = Q[:, keep]
    return np.linalg.eigvalsh(Qk.T @ Op @ Qk)

print("\nROOT CAUSE TEST -- the wrong index order, in the file's |W|^2 = 1 scale")
print(f"{'n':>4} {'-min(-w)=max w':>15} {'file m ACTUAL':>14} {'p3(-w)':>10} {'file p3':>10}")
for n in (12, 14, 16, 24):
    m_ = n // 2
    K = np.zeros((n, n))
    for a in range(n):
        for b_ in range(n):
            if a != b_ and (a < m_) == (b_ < m_): K[a, b_] = 1.0
    W = weyl_part(diag_curv(K)); W = W / np.linalg.norm(lam2(W))
    wf = ring_flipped(W) / 2.0                        # |W|^2 = 1 scale
    print(f"{n:>4} {-wf.min():>15.6f} {file_m[n]:>14.6f} {p(wf,3):>10.6f} {file_p3[n]:>10.6f}")
