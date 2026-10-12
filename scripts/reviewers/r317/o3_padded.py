"""O3: padded W_CP^2 -- criticality, S_mmm, and status in (A), (B), (C)."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib317 as L, points317 as PT

Wc, n4 = PT.cpm(2)
Wc = Wc / np.linalg.norm(Wc)
for n in [4, 6, 8, 10, 12]:
    W = PT.pad(Wc, 4, n) if n > 4 else Wc
    W = W / np.linalg.norm(W)
    N = W.shape[0]
    c = L.structure_constants(n)
    res, th = L.crit_residual(W, c)
    ev = np.linalg.eigvalsh(W)
    npos = int((ev > 1e-9).sum()); nneg = int((ev < -1e-9).sum())
    S = L.S_components(W, c)
    D, _ = L.defect_Delta(W, c)
    # stabiliser algebra k(W) = {x : [ad x, W] = 0}
    rows = []
    for a in range(N):
        e = np.zeros(N); e[a] = 1.0
        adx = L.ad_on_lambda2(e, c)
        rows.append((adx @ W - W @ adx).ravel())
    A = np.array(rows).T
    s = np.linalg.svd(A, compute_uv=False)
    rank = int((s > 1e-9 * max(s[0], 1)).sum())
    u_, s_, vt_ = np.linalg.svd(A)
    kW = vt_[rank:].T                        # columns span k(W)
    dimk = kW.shape[1]
    dcs = L.commutant_sym_on_Rn(kW, n) if dimk else -1
    print(f'n={n:3d} theta={th:.12f} (sqrt(3/2)={np.sqrt(1.5):.12f}) crit-res={res:.2e} '
          f'|W|={np.linalg.norm(W):.3f}')
    print(f'      dims(E+,E-,ker)=({npos},{nneg},{N-npos-nneg}) of {N}   S_mmm={S["S_mmm"]:.2e} '
          f'S_mpp={S["S_mpp"]:.2e} Delta={D:.2e}   dim k(W)={dimk} (u(2)+so({n-4}) = {4 + (n-4)*(n-5)//2})')
    # (B): does it commute with Lambda^2(sigma) for sigma = diag(I_k,-I_{n-k})?
    hits = []
    for k in range(1, n):
        sg = np.diag([1.0] * k + [-1.0] * (n - k))
        Ls = L.Lambda2(sg, n)
        if np.abs(Ls @ W - W @ Ls).max() < 1e-12:
            hits.append(k)
    print(f'      (B) commutes with Lambda^2(diag(I_k,-I_(n-k))) for k in {hits}')
    # (C): symmetric subalgebras of so(n) and their dimensions vs dim k(W)
    dims = {f'so({k})+so({n-k})': k*(k-1)//2 + (n-k)*(n-k-1)//2 for k in range(1, n//2+1)}
    if n % 2 == 0:
        dims[f'u({n//2})'] = (n//2)**2
    small = {kk: vv for kk, vv in dims.items() if vv <= dimk}
    print(f'      symmetric subalgebras of so({n}) with dim <= dim k(W): {small}')
