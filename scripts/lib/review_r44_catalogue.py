"""Reviewer 44 -- P6: which S = 0 critical points are degenerate, at what theta,
and does padding preserve the excess?"""
import numpy as np, sys, time
from itertools import combinations_with_replacement
sys.path.insert(0, 'scripts/lib')
from review_r44_core import *
from review_r44_padded import Le_matrix

def log(m):
    print(m, flush=True)
    with open('agent_logs/review_r44_padded.log', 'a') as f:
        f.write(m + '\n')

def cpm_W(m):
    n = 2 * m
    J = np.zeros((n, n))
    for t in range(m):
        J[2*t, 2*t+1] = 1.0; J[2*t+1, 2*t] = -1.0
    d = np.eye(n)
    T = (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
         + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
         + 2.0 * np.einsum('ij,kl->ijkl', J, J))
    p, _ = pairs_of(n)
    R = np.array([[T[i, j, k, l] for (k, l) in p] for (i, j) in p])
    Ric = ricci(R, n); scal = np.trace(Ric)
    W = R - (scal / (n * (n - 1))) * np.eye(len(p))
    return W / np.linalg.norm(W)

def measure(Wsmall, n0, n, label):
    W = embed(Wsmall, n0, n) if n > n0 else Wsmall.copy()
    W = W / np.linalg.norm(W)
    B = weyl_basis(n)
    QW = Qop(W, n); th = float(np.tensordot(W, QW))
    res = float(np.linalg.norm(QW - th * W))
    S, dimm = slack_S(W, n)
    orb, sv = orbit_tangent_dim(W, n)
    gap = sv[orb-1] / sv[orb] if orb < len(sv) and sv[orb] > 0 else np.inf
    M = Le_matrix(W / th, n, B)
    ev = np.linalg.eigvalsh(M)
    half = int(np.sum(np.abs(ev - 0.5) < 1e-8))
    nearest = np.sort(np.abs(ev - 0.5))[half] if half < len(ev) else np.inf
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    return dict(label=label, n0=n0, n=n, theta=th, theta0=th0, res=res, S=S,
                orbit=orb, half=half, excess=half - orb, ratio=th/th0,
                sepgap=nearest, orbgap=gap)

def row(r):
    return (f'{r["label"]:>16s} n0={r["n0"]:2d} -> n={r["n"]:2d}  theta={r["theta"]:.9f} '
            f'({r["theta"]/r["theta0"]:.4f} of theta_0)  res={r["res"]:.1e}  S={r["S"]:+.2e}  '
            f'orbit={r["orbit"]:3d}  E(1/2)={r["half"]:3d}  excess={r["excess"]:3d}  '
            f'|ev-1/2| next={r["sepgap"]:.1e}')

if __name__ == '__main__':
    targets = [int(x) for x in sys.argv[1:]] or [12]
    pts = []
    for n0 in range(4, 13):
        for k in range(2, n0 // 2 + 1):
            l = n0 - k
            if l >= 2:
                pts.append((sphere_product_W((k, l)), n0, f'S{k}xS{l}'))
    for blocks in [(2,2,2), (3,3,3), (2,2,3), (4,4,4), (2,2,2,2), (3,3,3,3), (2,3,4), (2,2,4)]:
        n0 = sum(blocks)
        if n0 <= 12:
            pts.append((sphere_product_W(blocks), n0, 'x'.join(f'S{b}' for b in blocks)))
    for m in range(2, 7):
        pts.append((cpm_W(m), 2 * m, f'CP{m}'))
    log(f'catalogue: {len(pts)} points; native measurement then padded to {targets}')
    res_native = []
    for W, n0, lab in pts:
        r = measure(W, n0, n0, lab)
        res_native.append(r)
        log('NATIVE  ' + row(r))
    log('--- padded ---')
    for tn in targets:
        for W, n0, lab in pts:
            if n0 > tn:
                continue
            r = measure(W, n0, tn, lab)
            log('PADDED  ' + row(r))
