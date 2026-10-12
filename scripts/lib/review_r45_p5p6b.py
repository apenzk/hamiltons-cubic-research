"""Reviewer 45, phase 7.

(A) P6 continued: the su(m) Kaehler points (SU(m)/SO(m) symmetric pair inside
    so(2m)), which FINDINGS records as the highest-theta degenerate graded
    points -- built here from the pair, not imported -- and their paddings.

(B) P5: degeneracy is NECESSARY for {S=0} to fail to be open, not SUFFICIENT.
    Test it directly: push off the padded S^3 x S^3 orbit along the 9 excess
    kernel directions and run a gauge-free Gauss-Newton corrector back onto
    Crit(P).  S and theta are orbit invariants, so a converged critical point
    with S > 0 near the orbit would prove non-openness; S == 0 at every
    converged point is evidence that openness survives the degeneracy.
"""
import sys, time
import numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r45_core import (struct, weyl_basis, Qop, circ, sphere_product, pad,
                             theta_and_residual, Le_matrix, slack, pairs_of)

LOG = 'agent_logs/review_r45_padded.log'


def log(msg):
    with open(LOG, 'a') as f:
        f.write(f"{time.strftime('%H:%M:%S')} {msg}\n")
    print(msg, flush=True)


def su_m_kahler(m):
    """W on Lambda^2(R^{2m}) for the symmetric pair su(m) = so(m) + p,
    so(m) = [[B,0],[0,B]], p = [[0,-S],[S,0]] with S symmetric traceless.
    W = a Pi_h - b Pi_p with r1 a = r2 b (trace free) and |W| = 1."""
    n = 2 * m
    ps, idx = pairs_of(n)
    N = len(ps)

    def tovec(M):
        v = np.zeros(N)
        for a, (i, j) in enumerate(ps):
            v[a] = M[i, j]
        return v

    H, Pp = [], []
    for i in range(m):
        for j in range(i + 1, m):
            B = np.zeros((m, m)); B[i, j], B[j, i] = -1.0, 1.0
            M = np.zeros((n, n)); M[:m, :m] = B; M[m:, m:] = B
            v = tovec(M); H.append(v / np.linalg.norm(v))
    Ss = []
    for i in range(m):
        for j in range(i + 1, m):
            S = np.zeros((m, m)); S[i, j] = S[j, i] = 1.0; Ss.append(S)
    for k in range(1, m):
        d = np.zeros(m); d[:k] = 1.0; d[k] = -float(k)
        Ss.append(np.diag(d) / np.linalg.norm(d))
    for S in Ss:
        M = np.zeros((n, n)); M[:m, m:] = -S; M[m:, :m] = S
        v = tovec(M); Pp.append(v / np.linalg.norm(v))
    B1, B2 = np.array(H), np.array(Pp)
    G = np.vstack([B1, B2])
    assert np.abs(G @ G.T - np.eye(len(G))).max() < 1e-12, "not orthonormal"
    r1, r2 = len(H), len(Pp)
    b = np.sqrt(r1 / (r2 * (r1 + r2)))
    a = r2 * b / r1
    return a * (B1.T @ B1) - b * (B2.T @ B2), r1, r2


def report(name, Wraw, n, Bc, Ac):
    A, B = Ac[n], Bc[n]
    Bf = B.reshape(B.shape[0], -1)
    N = A.shape[0]
    v = Bf @ Wraw.reshape(-1)
    dev = np.linalg.norm((v @ Bf).reshape(N, N) - Wraw) / np.linalg.norm(Wraw)
    W = Wraw / np.linalg.norm(Wraw)
    th, res = theta_and_residual(W, A)
    S = slack(W, A)
    T = np.einsum('amn,np->amp', A, W) - np.einsum('mn,anp->amp', W, A)
    s = np.linalg.svd(T.reshape(N, N * N), compute_uv=False)
    orb = int((s > max(N, N * N) * np.finfo(float).eps * s[0]).sum())
    M = Le_matrix(Bf, W / th, A)
    w = np.linalg.eigvalsh(M)
    d = np.sort(np.abs(w - 0.5))
    dimE = int((d < 1e-8).sum())
    th0 = np.sqrt(2 * (n - 1) * (n - 2)) / n
    log(f"  {name:<26} n={n:2d} projdev={dev:.1e} theta={th:.9f} "
        f"(th0={th0:.6f}) resid={res:.1e} S={S:.2e} orbit={orb} dimE={dimE} "
        f"excess={dimE-orb} gap={d[dimE] if dimE<len(d) else np.inf:.1e}")
    return th, S, dimE - orb


# ------------------------------------------------------------------ (B) P5

def corrector(Wstart, Bf, A, iters=400):
    """Gauss-Newton on F(W) = pi(Q(W)) - <W,Q(W)> W restricted to the unit
    sphere of Weyl_n, in basis coordinates.  Jacobian from 2*L_W."""
    N = A.shape[0]
    D = Bf.shape[0]
    x = Bf @ Wstart.reshape(-1)
    x /= np.linalg.norm(x)
    for it in range(iters):
        W = (x @ Bf).reshape(N, N)
        QW = Qop(W, A)
        q = Bf @ QW.reshape(-1)
        th = float(x @ q)
        F = q - th * x
        if np.linalg.norm(F) < 1e-14:
            break
        # dF = 2 L_W - th I - 2 (x . L_W .) x^T ... build 2 L_W once every step
        L = Le_matrix(Bf, W, A)
        J = 2 * L - th * np.eye(D) - 2 * np.outer(x, L @ x)
        # restrict to x^perp
        P = np.eye(D) - np.outer(x, x)
        Jr = P @ J @ P
        step = np.linalg.lstsq(Jr, -P @ F, rcond=1e-10)[0]
        step = P @ step
        nrm = np.linalg.norm(step)
        if nrm > 0.3:
            step *= 0.3 / nrm
        x = x + step
        x /= np.linalg.norm(x)
    W = (x @ Bf).reshape(N, N)
    QW = Qop(W, A)
    th = float(np.tensordot(W, QW))
    return W, th, float(np.linalg.norm(Bf @ (QW - th * W).reshape(-1)))


if __name__ == "__main__":
    Bc, Ac = {}, {}
    for n in (6, 8, 10, 12):
        Bc[n] = weyl_basis(n)
        Ac[n] = struct(n)
    log("PHASE 7A: su(m) Kaehler points, native and padded")
    for m in (3, 4, 5, 6):
        n0 = 2 * m
        W0, r1, r2 = su_m_kahler(m)
        log(f"  su({m}) pair dims: so({m})={r1}, p={r2}, total={r1+r2}=m^2-1")
        for n in (n0, 10, 12):
            if n < n0 or n not in Bc:
                continue
            report(f"su({m}) Kahler"
                   + ("" if n == n0 else f" pad {n0}->{n}"),
                   pad(W0, n0, n) if n != n0 else W0, n, Bc, Ac)

    log("PHASE 7B: does a branch of critical points leave the padded S^3xS^3 orbit?")
    for n in (6, 8):
        A, B = Ac[n], Bc[n]
        Bf = B.reshape(B.shape[0], -1)
        N = A.shape[0]
        W = pad(sphere_product(3, 3, 6), 6, n) if n != 6 else sphere_product(3, 3, 6)
        W = W / np.linalg.norm(W)
        th, _ = theta_and_residual(W, A)
        M = Le_matrix(Bf, W / th, A)
        w, V = np.linalg.eigh(M)
        sel = np.where(np.abs(w - 0.5) < 1e-8)[0]
        # orbit tangent in basis coordinates
        T = (np.einsum('amn,np->amp', A, W)
             - np.einsum('mn,anp->amp', W, A)).reshape(N, N * N)
        Oc = T @ Bf.T
        q, rr = np.linalg.qr(Oc.T)
        rk = int((np.abs(np.diag(rr)) > 1e-9).sum())
        q = q[:, :rk]
        E = V[:, sel]
        Perp = E - q @ (q.T @ E)
        u, s, _ = np.linalg.svd(Perp, full_matrices=False)
        exc = int((s > 1e-8).sum())
        U = u[:, :exc]
        log(f"  n={n}: excess dim {exc}, theta={th:.9f}, S={slack(W,A):.1e}")
        rng = np.random.default_rng(4545)
        found = []
        for trial in range(24):
            c = rng.standard_normal(exc); c /= np.linalg.norm(c)
            v = (U @ c) @ Bf
            for t in (0.05, 0.12, 0.25):
                Ws = ((Bf @ W.reshape(-1)) + t * (Bf @ v)).reshape(-1)
                Ws /= np.linalg.norm(Ws)
                Ws = (Ws @ Bf).reshape(N, N)
                Wc, thc, rc = corrector(Ws, Bf, A, iters=120)
                Sc = slack(Wc, A)
                found.append((t, thc, rc, Sc))
        conv = [f for f in found if f[2] < 1e-10]
        log(f"    {len(conv)}/{len(found)} correctors converged (resid<1e-10)")
        if conv:
            ths = np.array([c[1] for c in conv]); Ss = np.array([c[3] for c in conv])
            log(f"    converged theta: min={ths.min():.9f} max={ths.max():.9f}")
            log(f"    converged slack S: min={Ss.min():.3e} max={Ss.max():.3e}  "
                f"(#with S>1e-8: {(Ss>1e-8).sum()})")
            off = [(t, th_, S_) for (t, th_, r_, S_) in conv if S_ > 1e-8]
            for o in off[:6]:
                log(f"      UNGRADED nearby critical point: t={o[0]} theta={o[1]:.9f} S={o[2]:.4f}")
