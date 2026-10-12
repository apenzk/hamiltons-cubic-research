"""F2 -- the shared-frame majorization coupling, as a falsifier for route B'.

DERIVED FIRST.  M is the first-kind operator on Lambda^2 (Frobenius norm 1,
spectrum mu, sum mu = 0, sum mu^2 = 1); Wring the second-kind operator on
S^2_0 in Li's convention (spectrum omega, sum omega = 0, sum omega^2 = 3).
The bi-spectral identity of findings/bispectral.md reads

    theta = (3/2) p_3(mu) - (1/2) p_3(omega).

In ANY orthonormal frame both operators carry the SAME sectional curvatures on
their diagonals: M_{(ij),(ij)} = W_{ijij}, and (NPW Prop 3.10)
<Wring phi_ij, phi_ij> = W_{ijij} for phi_ij = (e_i (.) e_j)/sqrt(2).  Write
K = (W_{ijij})_{i<j} and K' = (K, d) for the full Wring diagonal, d its n-1
entries on the trace-free diagonal tensors psi_k.  Schur-Horn gives the
majorizations K < mu and K' < omega.

Majorization alone says NOTHING about p_3: t^3 is neither convex nor concave
on R.  The support bounds repair that.  With omega_i >= -m, t^3 + 3m t^2 is
convex on [-m, inf), so K' < omega gives
    p_3(omega) >= p_3(K') + 3m (p_2(K') - 3).
With mu_i <= Mp, t^3 - 3 Mp t^2 is concave on (-inf, Mp], so K < mu gives
    p_3(mu) <= p_3(K) + 3 Mp (1 - p_2(K)).
Hence the coupled bound -- the third piece of information fence post 33
demands, since it ties omega to mu through a shared frame rather than being
another moment of omega alone:

  theta <= (3/2)[p_3(K) + 3 Mp (1 - p_2(K))] - (1/2)[p_3(K') + 3m (p_2(K') - 3)].

FALSIFIER DESIGN: m and Mp are read off the ACTUAL spectra, i.e. the most
favourable support constants any argument could ever supply, and the frame is
optimised over random rotations (only helping).  If the bound still overshoots
theta_0(n) in this best case, no version of it can close.

SCREEN (Gate 1a): every point is checked for Ricci-flatness, first Bianchi,
sum omega = 0, sum omega^2 = 3, and theta reproduced against the record's own
P in scripts/review_r30_core.py before any bound is reported.
"""
import sys, itertools
import numpy as np

sys.path.insert(0, 'scripts/lib')
sys.path.insert(0, 'scripts/runs')
from review_r30_core import sphere_product_W, pair_index, normalize, P as P30
from run_bispectral_identity import lam2_matrix, random_weyl

rng = np.random.default_rng(1)


def theta0(n):
    return np.sqrt(2 * (n - 1) * (n - 2) / n ** 2)


def to4(M, n):
    """4-index W from the Lambda^2 matrix in the raw-component convention."""
    pairs, _ = pair_index(n)
    W = np.zeros((n,) * 4)
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            v = M[a, b]
            for s1, ii, jj in [(1, i, j), (-1, j, i)]:
                for s2, kk, ll in [(1, k, l), (-1, l, k)]:
                    W[ii, jj, kk, ll] = s1 * s2 * v
    return W


def s20_basis(n):
    """Orthonormal basis of S^2_0: the phi_ij first, then the psi_k."""
    B = []
    for i, j in itertools.combinations(range(n), 2):
        h = np.zeros((n, n)); h[i, j] = h[j, i] = 1 / np.sqrt(2); B.append(h)
    for k in range(n - 1):
        v = np.zeros(n); v[:k + 1] = 1.0; v[k + 1] = -(k + 1.0)
        v /= np.linalg.norm(v); B.append(np.diag(v))
    return B


def ring_on_s20(W4, n, B):
    """Wring restricted to S^2_0, Li's convention (Wring h)_ij = sum W_{iklj} h_kl."""
    m = len(B)
    R = np.empty((m, m))
    for a, h in enumerate(B):
        Wh = np.einsum('iklj,kl->ij', W4, h)
        R[a] = [float(np.sum(Wh * hb)) for hb in B]
    return 0.5 * (R + R.T)


def data(W4, n, B):
    M, pairs = lam2_matrix(W4)
    R = ring_on_s20(W4, n, B)
    mu = np.linalg.eigvalsh(M)
    om = np.linalg.eigvalsh(R)
    K = np.array([M[a, a] for a in range(len(pairs))])
    Kp = np.diag(R).copy()
    return K, Kp, mu, om


def screen(name, W4, n, B, theta_ref=None):
    ric = np.abs(np.einsum('ikjk->ij', W4)).max()
    bia = np.abs(W4 + W4.transpose(1, 2, 0, 3) + W4.transpose(2, 0, 1, 3)).max()
    K, Kp, mu, om = data(W4, n, B)
    th = 1.5 * np.sum(mu ** 3) - 0.5 * np.sum(om ** 3)
    ok = (ric < 1e-9 and bia < 1e-9 and abs(om.sum()) < 1e-9
          and abs(om @ om - 3) < 1e-8 and abs(mu @ mu - 1) < 1e-8)
    if theta_ref is not None:
        ok = ok and abs(th - theta_ref) < 1e-9
    if not ok:
        print(f"  SCREEN FAILED {name}: Ric={ric:.1e} Bia={bia:.1e} "
              f"sum_om={om.sum():.1e} sum_om2={om @ om:.6f} sum_mu2={mu @ mu:.6f} "
              f"theta={th:.9f} ref={theta_ref}")
    return ok, th


def bound(W4, n, B):
    """The coupled bound, with the psi block DIAGONALISED.

    Once the phi_ij are fixed by the shared-sectional requirement, the only
    basis freedom left in S^2_0 is the orthogonal completion on the n-1
    remaining vectors, and diagonalising Wring there is provably the optimal
    choice.  An arbitrary completion reports the bound as overshooting at
    points where it is exactly tight.
    """
    K, Kp, mu, om = data(W4, n, B)
    nph = n * (n - 1) // 2
    R = ring_on_s20(W4, n, B)
    Kp = np.concatenate([np.diag(R)[:nph], np.linalg.eigvalsh(R[nph:, nph:])])
    m, Mp = -om.min(), mu.max()
    lo_om = np.sum(Kp ** 3) + 3 * m * (np.sum(Kp ** 2) - 3.0)
    hi_mu = np.sum(K ** 3) + 3 * Mp * (1.0 - np.sum(K ** 2))
    bd = 1.5 * hi_mu - 0.5 * lo_om
    th = 1.5 * np.sum(mu ** 3) - 0.5 * np.sum(om ** 3)
    th_diag = 1.5 * np.sum(K ** 3) - 0.5 * np.sum(Kp ** 3)
    penalty = 4.5 * Mp * (1.0 - np.sum(K ** 2)) + 1.5 * m * (3.0 - np.sum(Kp ** 2))
    # the penalty sum is bound - th_diag, NOT bound - th; the difference is the
    # sign-indefinite term th_diag - th, which the two majorizations also carry
    assert abs((bd - th_diag) - penalty) < 1e-9, "penalty decomposition broken"
    return bd, th, bd - th, penalty


def rotate(W4, g):
    return np.einsum('ai,bj,ck,dl,ijkl->abcd', g, g, g, g, W4, optimize=True)


def report(name, W4, n, theta_ref=None, frames=16):
    B = s20_basis(n)
    ok, th = screen(name, W4, n, B, theta_ref)
    if not ok:
        return
    bd, th, slack, pen = bound(W4, n, B)
    best = bd
    for _ in range(frames):
        g = np.linalg.qr(rng.standard_normal((n, n)))[0]
        best = min(best, bound(rotate(W4, g), n, B)[0])
    t0 = theta0(n)
    print(f"{name:<20} n={n:<3} theta={th:+.6f} bound={bd:+.6f} SLACK={slack:+.6f}"
          f" (penalty sum {pen:+.6f}) best/{frames}fr={best:+.6f}"
          f" = {best / t0:5.2f} x theta_0  {'CLOSES' if best <= t0 + 1e-9 else 'OVERSHOOTS'}")


if __name__ == '__main__':
    print("=== catalogue (coordinate frame diagonalises both operators) ===")
    for blocks in ([4, 4], [6, 6], [5, 7], [3, 3]):
        n = sum(blocks)
        M = normalize(sphere_product_W(blocks)[0])
        report(f"S^{blocks[0]} x S^{blocks[1]}", to4(M, n), n, theta_ref=P30(n, M))
    print("\n=== padded W_CP2 -- the non-diagonal point where the conjecture is tight ===")
    from b_cp2_nondegenerate import padded_cp2
    for n in (8, 12):
        report("padded W_CP2", to4(normalize(padded_cp2(n)[0]), n), n, frames=8)
    print("\n=== random Weyl tensors ===")
    for n in (6, 7, 8):
        for t in range(3):
            W = random_weyl(n)
            W = W / np.sqrt(np.einsum('ijkl,ijkl', W, W)) * 2.0
            report(f"random #{t}", W, n)
