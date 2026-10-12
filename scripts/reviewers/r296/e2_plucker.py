"""E2': the two-dimensional eigenspace at lambda = -0.302413, audited from the definitions.

wedge_std : the standard exterior-algebra coefficient of e_i^e_j^e_k^e_l in omega ^ omega,
            which is 2(w_ij w_kl - w_ik w_jl + w_il w_jk).   The repo's `plucker_min` /
            `wedge_norm` use HALF of that, so they report half the standard norm.
"""
import itertools, sys
import numpy as np
sys.path.insert(0, 'scripts/reviewers/r296')
import core296 as c

n = 8
QUADS = list(itertools.combinations(range(n), 4))
PRS = c.pairs_of(n)


def as_matrix(v):
    M = np.zeros((n, n))
    for a, (i, j) in enumerate(PRS):
        M[i, j] = v[a]; M[j, i] = -v[a]
    return M


def wedge_coeffs(v, half=False):
    M = as_matrix(v)
    f = 1.0 if half else 2.0
    return np.array([f * (M[i, j]*M[k, l] - M[i, k]*M[j, l] + M[i, l]*M[j, k])
                     for (i, j, k, l) in QUADS])


def wedge_norm(v, half=False):
    return float(np.linalg.norm(wedge_coeffs(v, half)))


def eigenspace(W, lam, tol=1e-9):
    """orthonormal basis of ker(W - lam I), by SVD -- not by picking eigh columns."""
    u, s, vt = np.linalg.svd(W - lam * np.eye(W.shape[0]))
    k = int((s < tol).sum())
    return vt[W.shape[0] - k:], s


if __name__ == '__main__':
    W = np.load('scripts/data/w_n8_nondiagonal_witness.npy')
    lam = np.linalg.eigvalsh(W)
    print("eigenvalues, clustered at 1e-9:")
    seen = []
    for x in lam:
        if not seen or abs(x - seen[-1][0]) > 1e-9:
            seen.append([x, 1])
        else:
            seen[-1][1] += 1
    for x, m in seen:
        print(f"   {x:+.12f}   multiplicity {m}")
    L = seen[0][0]
    E, sv = eigenspace(W, L)
    print(f"\nlambda = {L:.12f}: dim ker(W - lam I) = {E.shape[0]};"
          f" singular values near 0: {np.sort(sv)[:4]}")
    print(f"   residual ||(W - lam)E|| = {np.abs((W - L*np.eye(28)) @ E.T).max():.2e}")
    print(f"   gap to the next eigenvalue = {seen[1][0]-L:.6f}")

    # ---- constancy around the circle, both normalisations ----
    print("\nangle sweep, 25 angles:")
    vals_s, vals_h = [], []
    for t in np.linspace(0, np.pi, 25):
        v = np.cos(t) * E[0] + np.sin(t) * E[1]
        vals_s.append(wedge_norm(v)); vals_h.append(wedge_norm(v, half=True))
    vals_s, vals_h = np.array(vals_s), np.array(vals_h)
    print(f"   standard: min {vals_s.min():.15f}  max {vals_s.max():.15f}"
          f"  spread {np.ptp(vals_s):.2e}")
    print(f"   repo/half: min {vals_h.min():.15f}  max {vals_h.max():.15f}"
          f"  spread {np.ptp(vals_h):.2e}")

    # ---- constancy as an ALGEBRAIC identity, not a sample ----
    # omega(u) ^ omega(u) = m + cos u p + sin u q with u = 2t; ||.||^2 is a degree-2
    # trig polynomial, constant iff <m,p> = <m,q> = <p,q> = 0 and ||p|| = ||q||.
    def wedge_bil(x, y):
        return 0.5 * (wedge_coeffs(x + y) - wedge_coeffs(x) - wedge_coeffs(y))
    a, d = wedge_coeffs(E[0]), wedge_coeffs(E[1])
    b = 2.0 * wedge_bil(E[0], E[1])
    m, p, q = 0.5 * (a + d), 0.5 * (a - d), 0.5 * b
    print("\nthe four coefficients that must vanish for exact constancy:")
    print(f"   <m,p> = {m@p:+.3e}   <m,q> = {m@q:+.3e}   <p,q> = {p@q:+.3e}"
          f"   ||p||^2-||q||^2 = {p@p - q@q:+.3e}")
    print(f"   constant value ||omega^omega||^2 = ||m||^2 + ||p||^2 = "
          f"{m@m + p@p:.15f}   -> norm {np.sqrt(m@m+p@p):.15f}")
    print(f"   ||m|| = {np.linalg.norm(m):.15f}  ||p|| = {np.linalg.norm(p):.15f}"
          f"  ||q|| = {np.linalg.norm(q):.15f}")

    # ---- invariance under a rotation inside the degenerate eigenspace ----
    rng = np.random.default_rng(0)
    worst = 0.0
    for _ in range(200):
        th = rng.uniform(0, 2*np.pi)
        R = np.array([[np.cos(th), -np.sin(th)], [np.sin(th), np.cos(th)]])
        E2 = R @ E
        for t in np.linspace(0, np.pi, 9):
            v = np.cos(t)*E2[0] + np.sin(t)*E2[1]
            worst = max(worst, abs(wedge_norm(v) - vals_s[0]))
    print(f"\ninvariance under rotation inside the eigenspace: max deviation {worst:.2e}")

    # ---- singular values of each element: rank and the (1/sqrt2,1/sqrt2) shape ----
    print("\nsingular values of omega(t) as an 8x8 skew matrix (top 6):")
    for t in [0.0, 0.3, 0.7, 1.1, 1.9]:
        v = np.cos(t)*E[0] + np.sin(t)*E[1]
        s = np.linalg.svd(as_matrix(v), compute_uv=False)
        print(f"   t={t:4.1f}  {np.round(s, 12)[:6]}")

    # ---- does the plane live in Lambda^2 U for one 4-dim U? ----
    print("\ncommon support test:")
    for t in [0.0, 0.5, 1.2]:
        v = np.cos(t)*E[0] + np.sin(t)*E[1]
        u_, s_, vt_ = np.linalg.svd(as_matrix(v))
        U = vt_[:4]
        print(f"   t={t:4.1f} rank-4 image; principal angles to t=0 image: ", end='')
        if t == 0.0:
            U0 = U
        print(np.round(np.linalg.svd(U0 @ U.T, compute_uv=False), 9))
    print("   coordinate support of the plane (max |coeff| per pair):")
    supp = np.abs(E).max(axis=0)
    print("   ", " ".join(f"{PRS[a]}:{supp[a]:.3f}" for a in range(28) if supp[a] > 1e-9))
