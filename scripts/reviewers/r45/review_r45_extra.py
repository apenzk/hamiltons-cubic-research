"""Reviewer 45, phase 8: three loose ends.

(1) dim Weyl_n at n=13,14 against n(n+1)(n+2)(n-3)/12 (the brief quotes 4004
    for n=14; the formula gives 3080).
(2) Are the padded S^3xS^3 point and the su(4) Kaehler point the same SO(8)
    orbit at n=8?  They share theta, spectrum, orbit dimension and excess.
(3) A cleaner P5 probe: excess directions extracted by SVD against the orbit
    tangent, larger pushes, and orbit-invariant read-outs (theta, S, the
    spectrum of W, the spectrum of L_e).
"""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r45_core import (struct, weyl_basis, weyl_constraints, Qop,
                             sphere_product, pad, theta_and_residual,
                             Le_matrix, slack, pairs_of)
from review_r45_p5p6b import su_m_kahler, corrector

LOG = 'agent_logs/review_r45_padded.log'


def log(msg):
    with open(LOG, 'a') as f:
        f.write(f"{time.strftime('%H:%M:%S')} {msg}\n")
    print(msg, flush=True)


if __name__ == "__main__":
    log("PHASE 8.1: dim Weyl_n at n=13,14")
    for n in (13, 14):
        t = time.time()
        C, coord, ncoord, N = weyl_constraints(n)
        s = np.linalg.svd(C, compute_uv=False)
        rank = int((s > max(C.shape) * np.finfo(float).eps * s[0]).sum())
        D = ncoord - rank
        want = n * (n + 1) * (n + 2) * (n - 3) // 12
        log(f"  n={n}: dim Weyl_n = {D}, formula = {want}  "
            f"{'OK' if D == want else 'MISMATCH'} ({time.time()-t:.1f}s)")

    log("PHASE 8.2: padded S^3xS^3 vs su(4) Kaehler at n=8")
    n = 8
    A = struct(n); B = weyl_basis(n); Bf = B.reshape(B.shape[0], -1)
    N = A.shape[0]
    W1 = pad(sphere_product(3, 3, 6), 6, n); W1 /= np.linalg.norm(W1)
    W2, _, _ = su_m_kahler(4); W2 = W2 / np.linalg.norm(W2)
    for tag, W in (("pad S^3xS^3", W1), ("su(4) Kahler", W2)):
        th, res = theta_and_residual(W, A)
        ev = np.round(np.linalg.eigvalsh(W), 9)
        vals, cnt = np.unique(ev, return_counts=True)
        log(f"  {tag}: theta={th:.9f} spec="
            + " ".join(f"{v:.6f}x{c}" for v, c in zip(vals, cnt)))
    L1 = np.linalg.eigvalsh(Le_matrix(Bf, W1 / theta_and_residual(W1, A)[0], A))
    L2 = np.linalg.eigvalsh(Le_matrix(Bf, W2 / theta_and_residual(W2, A)[0], A))
    log(f"  max |spec L_e(pad) - spec L_e(su4)| = {np.abs(L1 - L2).max():.3e}")
    v1, c1 = np.unique(np.round(L1, 8), return_counts=True)
    v2, c2 = np.unique(np.round(L2, 8), return_counts=True)
    log("  L_e spectrum pad S^3xS^3: " + " ".join(f"{v:.5f}x{c}" for v, c in zip(v1, c1)))
    log("  L_e spectrum su(4) Kahl: " + " ".join(f"{v:.5f}x{c}" for v, c in zip(v2, c2)))
    # decisive: pad both to n=10 and compare orbit dimensions.  Padding is
    # SO-equivariant, so conjugate operators stay conjugate with equal orbits.
    n2 = 10
    A2 = struct(n2); N2 = A2.shape[0]
    for tag, W in (("pad S^3xS^3", W1), ("su(4) Kahler", W2)):
        Wp = pad(W, n, n2)
        T = (np.einsum('amn,np->amp', A2, Wp)
             - np.einsum('mn,anp->amp', Wp, A2)).reshape(N2, N2 * N2)
        s = np.linalg.svd(T, compute_uv=False)
        orb = int((s > max(T.shape) * np.finfo(float).eps * s[0]).sum())
        log(f"  orbit dim after padding {tag} to n=10: {orb}")

    log("PHASE 8.3: refined branch probe at the padded S^3xS^3, n=8")
    W = W1
    th, _ = theta_and_residual(W, A)
    M = Le_matrix(Bf, W / th, A)
    w, V = np.linalg.eigh(M)
    sel = np.where(np.abs(w - 0.5) < 1e-8)[0]
    T = (np.einsum('amn,np->amp', A, W)
         - np.einsum('mn,anp->amp', W, A)).reshape(N, N * N)
    Oc = (T @ Bf.T)
    u0, s0, _ = np.linalg.svd(Oc, full_matrices=False)
    rk = int((s0 > max(Oc.shape) * np.finfo(float).eps * s0[0]).sum())
    Qo = ((u0[:, :rk].T @ Oc) / s0[:rk, None]).T          # (D, rk) orthonormal
    E = V[:, sel]
    Perp = E - Qo @ (Qo.T @ E)
    u, s, _ = np.linalg.svd(Perp, full_matrices=False)
    exc = int((s > 1e-8).sum())
    U = u[:, :exc]
    log(f"  orbit rank {rk}, dim E(1/2) {len(sel)}, transverse excess {exc}")
    ev0 = np.sort(np.linalg.eigvalsh(W))
    rng = np.random.default_rng(9001)
    rows = []
    for trial in range(40):
        c = rng.standard_normal(exc); c /= np.linalg.norm(c)
        v = (U @ c) @ Bf
        for t in (0.1, 0.25, 0.4):
            x = Bf @ W.reshape(-1) + t * (Bf @ v)
            x /= np.linalg.norm(x)
            Wc, thc, rc = corrector((x @ Bf).reshape(N, N), Bf, A, iters=150)
            if rc < 1e-10:
                rows.append((t, thc, slack(Wc, A),
                             np.abs(np.sort(np.linalg.eigvalsh(Wc)) - ev0).max()))
    log(f"  converged {len(rows)}/120")
    if rows:
        R = np.array(rows)
        log(f"  theta range [{R[:,1].min():.9f}, {R[:,1].max():.9f}]")
        log(f"  slack range [{R[:,2].min():.3e}, {R[:,2].max():.3e}]  "
            f"#S>1e-8: {(R[:,2]>1e-8).sum()}")
        log(f"  max spectral deviation from the base point: {R[:,3].max():.3e}")
