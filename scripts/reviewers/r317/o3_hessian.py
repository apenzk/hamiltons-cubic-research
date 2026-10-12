"""Second-order test at padded W_CP^2: lambda_max(L_e) vs 1/2, and the
multiplicity of 1/2 against the orbit dimension."""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lib317 as L, points317 as PT

Wc, _ = PT.cpm(2); Wc /= np.linalg.norm(Wc)
for n in [8, 10]:
    c = L.structure_constants(n)
    ns, coords, N = L.weyl_basis(n)
    mats = np.array([L.coords_to_M(ns[d], coords, N) for d in range(ns.shape[0])])
    flat = mats.reshape(mats.shape[0], -1)
    qq, _ = np.linalg.qr(flat.T)
    B = qq.T.reshape(-1, N, N)
    D = B.shape[0]
    W = PT.pad(Wc, 4, n); W /= np.linalg.norm(W)
    QW = L.Q(W, c); th = float(np.sum(W * QW))
    co = np.einsum('kab,ab->k', B, QW)
    resW = np.linalg.norm(np.einsum('k,kab->ab', co, B) - th * W)
    Wsh = L.sharp(W, c)
    def polar(V):
        return 0.5 * (L.sharp(W + V, c) - Wsh - L.sharp(V, c))
    Lm = np.zeros((D, D))
    for k in range(D):
        V = B[k]
        LV = 0.5 * (W @ V + V @ W) + polar(V)
        Lm[:, k] = np.einsum('jab,ab->j', B, LV)
    Lm = 0.5 * (Lm + Lm.T)
    Le = Lm / th
    ev = np.linalg.eigvalsh(Le)
    # orbit: span{[ad x, W]}
    rows = []
    for a in range(N):
        e = np.zeros(N); e[a] = 1.0
        adx = L.ad_on_lambda2(e, c)
        rows.append((adx @ W - W @ adx).ravel())
    sv = np.linalg.svd(np.array(rows), compute_uv=False)
    dorb = int((sv > 1e-9 * sv[0]).sum())
    # restrict to W-perp
    coW = np.einsum('kab,ab->k', B, W)
    Pp = np.eye(D) - np.outer(coW, coW) / (coW @ coW)
    u_, s_, vt_ = np.linalg.svd(Pp)
    basis_perp = vt_[:D-1]
    Lperp = basis_perp @ Le @ basis_perp.T
    evp = np.linalg.eigvalsh(0.5 * (Lperp + Lperp.T))
    mult_half = int((np.abs(evp - 0.5) < 1e-8).sum())
    print(f'n={n}: theta={th:.12f} crit-res={resW:.1e} dim Weyl={D}  lambda_max(L_e|W^perp)={evp[-1]:.12f} '
          f'2nd={evp[-2]:.9f}  mult(1/2)={mult_half}  dim orbit={dorb}  '
          f'local max? {evp[-1] <= 0.5 + 1e-9}')
