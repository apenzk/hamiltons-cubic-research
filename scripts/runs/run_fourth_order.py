"""F1 -- the fourth-order condition at a local maximizer of P on the unit sphere.

DERIVED FIRST, checked here.  T(x,y,z) = <x o y, z> fully symmetric,
P(x) = T(x,x,x), W a unit critical point (Q(W) = theta W), e = W/theta,
and z in the (theta/2)-eigenspace of L_W (i.e. the 1/2-eigenspace of L_e),
|z| = 1.  Write the curve x(t) = W + t z + (t^2/2) w with w perp W, and
gamma = x/|x|.  Then, exactly,

  (1) w = 0:   P(gamma(t)) = theta + sigma t^3 - (3 theta/8) t^4 + O(t^5),
      sigma = T(z,z,z).  The quartic coefficient carries NO algebra data --
      P is a cubic, so every term with algebra content sits at order <= 3.
      Krasnov-Tkachev Prop 6.7's fourth-derivative inequality is therefore
      automatically strict at every critical point of every cubic on a sphere.

  (2) general w:  [t^4] P(gamma) =
          (3/4) <(L_W - theta/2) w, w> + (3/2) <z o z, w> - 3 theta / 8.
      Maximising over w gives the real fourth-order condition
          <b, B^{-1} b>  <=  theta / 2,
          b = Pi(z o z),  B = theta/2 - L_W  > 0 on the orthogonal complement
          of span(W) + A_e(1/2), Pi that projection.
      Finiteness of the sup over ker B is exactly the fusion rule.

  (3) For z in the ORBIT TANGENT the condition holds with EQUALITY, forced:
      the orbit curve e^{tX}W has P == theta, so its own second-order term is
      a corrector achieving quartic coefficient 0, and local maximality caps
      the sup at 0.  So the fourth-order apparatus, like the third-order one,
      is vacuous on the orbit tangent and has content only on the excess
      A_e(1/2) \ominus orbit.

Coefficients below are computed by exact polynomial arithmetic: P(x(t)) is a
degree-6 polynomial in t and |x(t)|^2 a degree-4 one, so both are recovered
exactly by interpolation and the quotient series needs no fitting.
"""
import sys
import numpy as np

sys.path.insert(0, 'scripts/lib')
from review_r30_core import (weyl_basis, Q, circ, P, sphere_product_W,
                             normalize, orbit_tangent, orthonormalize)

np.random.seed(0)


def setup(n, W):
    B = weyl_basis(n)
    W = normalize(W)
    QW = Q(n, W)
    th = float(np.tensordot(W, QW))
    res = float(np.linalg.norm(QW - th * W))
    D = len(B)
    LW = np.empty((D, D))
    for j, X in enumerate(B):
        WX = circ(n, W, X)
        LW[:, j] = [float(np.tensordot(Y, WX)) for Y in B]
    return W, B, th, res, 0.5 * (LW + LW.T)


def coords(B, X):
    return np.array([float(np.tensordot(Y, X)) for Y in B])


def quartic_exact(n, W, Zm, Wm, th):
    """[t^4] of P(x/|x|) with x(t) = W + t Zm + (t^2/2) Wm, by exact series."""
    ts = np.linspace(-1.0, 1.0, 9)                     # 9 nodes: degree 6 exact
    pv = np.array([P(n, W + t * Zm + 0.5 * t ** 2 * Wm) for t in ts])
    xs = [W + t * Zm + 0.5 * t ** 2 * Wm for t in ts]
    qv = np.array([float(np.tensordot(x, x)) for x in xs])
    p = np.polyfit(ts, pv, 6)[::-1]                    # ascending coefficients
    q = np.polyfit(ts, qv, 4)[::-1]
    s = q.copy(); s[0] -= 1.0                          # q = 1 + s, s(0) = 0
    # (1+s)^{-3/2} = 1 - (3/2)s + (15/8)s^2 - (35/16)s^3 + (315/128)s^4
    ser = np.zeros(5); ser[0] = 1.0
    term = np.zeros(5); term[0] = 1.0
    for k, cf in enumerate([-1.5, 15 / 8, -35 / 16, 315 / 128], start=1):
        term = np.convolve(term, s)[:5]
        ser += cf * term if k == 1 else 0 * term
        if k > 1:
            ser += cf * term - cf * term          # placeholder, replaced below
    # recompute cleanly: powers of s
    ser = np.zeros(5); ser[0] = 1.0
    pw = np.zeros(5); pw[0] = 1.0
    for cf in [-1.5, 15 / 8, -35 / 16, 315 / 128]:
        pw = np.convolve(pw, s)[:5]
        ser += cf * pw
    return float(np.convolve(p[:5], ser)[4])


def report(name, n, W):
    W, B, th, res, LW = setup(n, W)
    D = len(B)
    wv = coords(B, W)
    ev, U = np.linalg.eigh(LW)
    half = np.array([U[:, k] for k in range(D)
                     if abs(ev[k] - th / 2) < 1e-7 and abs(wv @ U[:, k]) < 1e-6])
    orb = orbit_tangent(n, W)
    orbv = orthonormalize(np.array([coords(B, X) for X in orb])) if len(orb) else np.zeros((0, D))
    print(f"\n=== {name}  (n={n}) ===")
    print(f"  theta = {th:.9f}   criticality residual = {res:.2e}")
    print(f"  dim A_e(1/2) = {len(half)}   orbit tangent = {len(orbv)}"
          f"   EXCESS = {len(half) - len(orbv)}")
    if not len(half):
        print("  no 1/2-eigenspace")
        return

    z = half[0] / np.linalg.norm(half[0])
    Zm = sum(z[k] * B[k] for k in range(D))
    sig = float(np.tensordot(circ(n, Zm, Zm), Zm))
    c4 = quartic_exact(n, W, Zm, 0 * W, th)
    ok1 = abs(c4 + 3 * th / 8) < 1e-9
    print(f"  (1) geodesic:  sigma = {sig:+.2e}   [t^4] = {c4:+.12f}"
          f"   -3theta/8 = {-3 * th / 8:+.12f}   {'PASS' if ok1 else 'FAIL'}")

    w = np.random.randn(D); w -= (w @ wv) * wv / (wv @ wv); w /= np.linalg.norm(w)
    Wm = sum(w[k] * B[k] for k in range(D))
    c4b = quartic_exact(n, W, Zm, Wm, th)
    pred = (0.75 * (w @ (LW - th / 2 * np.eye(D)) @ w)
            + 1.5 * (coords(B, circ(n, Zm, Zm)) @ w) - 3 * th / 8)
    ok2 = abs(c4b - pred) < 1e-9
    print(f"  (2) corrected: [t^4] = {c4b:+.12f}   predicted = {pred:+.12f}"
          f"   {'PASS' if ok2 else 'FAIL'}")

    # (3) the inequality, split by orbit tangent vs excess
    Kperp = np.eye(D) - np.outer(wv, wv) / (wv @ wv)
    for v in half:
        u = Kperp @ v; nu = np.linalg.norm(u)
        if nu > 1e-9:
            Kperp -= np.outer(u, u) / nu ** 2
    Bop = th / 2 * np.eye(D) - LW
    Bs = Kperp @ Bop @ Kperp
    Bi = np.linalg.pinv(Bs, rcond=1e-9)

    def val(a):
        Am = sum(a[k] * B[k] for k in range(D))
        b = Kperp @ coords(B, circ(n, Am, Am))
        return float(b @ Bi @ b)

    if len(orbv):
        vs = [val(orbv[i] / np.linalg.norm(orbv[i])) for i in range(len(orbv))]
        print(f"  (3a) orbit directions: <b,B^-1b> in [{min(vs):.9f}, {max(vs):.9f}]"
              f"   theta/2 = {th / 2:.9f}   "
              f"{'EQUALITY (vacuous)' if max(abs(np.array(vs) - th / 2)) < 1e-6 else 'not equality'}")
    # excess directions
    Pex = np.eye(D)
    for v in orbv:
        Pex -= np.outer(v, v) / (v @ v)
    ex = orthonormalize(np.array([Pex @ v for v in half])) if len(half) else np.zeros((0, D))
    ex = np.array([v for v in ex if np.linalg.norm(v) > 1e-8])
    if len(ex):
        # The supremum over w is FINITE only when the fusion rule holds, i.e. when
        # z o z is orthogonal to A(1/2) = ker B.  Report the two honest quantities:
        # the third-order residual sigma = T(z,z,z), and the ker-B component of z o z.
        # A nonzero value of EITHER makes the point a non-maximum outright, and makes
        # the projected Rayleigh quotient meaningless as a supremum.
        Phalf = np.zeros((D, D))
        for v in half:
            Phalf += np.outer(v, v) / (v @ v)
        worst_sig, worst_ker = 0.0, 0.0
        for a in [ex[i] for i in range(len(ex))] + [np.random.randn(len(ex)) @ ex
                                                    for _ in range(200)]:
            a = a / np.linalg.norm(a)
            Am = sum(a[k] * B[k] for k in range(D))
            zz = coords(B, circ(n, Am, Am))
            worst_sig = max(worst_sig, abs(float(np.tensordot(circ(n, Am, Am), Am))))
            worst_ker = max(worst_ker, float(np.linalg.norm(Phalf @ zz)))
        live = worst_sig > 1e-8 or worst_ker > 1e-8
        print(f"  (3b) EXCESS directions: max |T(z,z,z)| = {worst_sig:.6f}, "
              f"max |Pi_ker(z o z)| = {worst_ker:.6f}")
        msg = ('third-order condition FAILS, sup over w is +infinity: NOT a local max'
               if live else 'both vanish: the conditions hold and carry no information')
        print(f"       -> {msg}")
    else:
        print("  (3b) EXCESS directions: none -- the apparatus is VACUOUS at this point")


if __name__ == '__main__':
    for n, blocks, name in [(8, [4, 4], 'S^4 x S^4'), (12, [6, 6], 'S^6 x S^6'),
                            (12, [5, 7], 'S^5 x S^7'), (6, [3, 3], 'S^3 x S^3')]:
        W, _ = sphere_product_W(blocks)
        report(name, n, W)
    sys.path.insert(0, 'scripts/lib')
    from b_cp2_nondegenerate import padded_cp2
    for n in (8, 10, 12):
        W, _ = padded_cp2(n)
        report('padded W_CP2', n, W)
