"""Screen the closed form of the three-coupling phase maximum on the common-eigenvector
stratum of G(2), and the affineness that closes the stratum.

With Lambda = d_A d_C / (beta v_2), rho_1 = beta v_2 r / d_A, rho_2 = beta v_2 p / d_C,
batch 11's phase sum is

    g(t1, t2) = a cos t1 + b cos t2 - c cos(t1 - t2),
    a = 2 Lambda rho_2,  b = 2 Lambda rho_1,  c = 2 Lambda rho_1 rho_2.

Four claims, each already derived:

(1) THE IDENTITY   Lambda (1 + rho_1^2 + rho_2^2) - g = Lambda |1 - rho_2 e^{i t1} - rho_1 e^{i t2}|^2.

(2) THE CLOSED FORM   max_t g = Lambda [ 1 + rho_1^2 + rho_2^2 - dist(1, annulus)^2 ],
    the annulus being |rho_1 - rho_2| <= |z| <= rho_1 + rho_2, so the distance is
    max(0, 1 - rho_1 - rho_2, |rho_1 - rho_2| - 1).

(3) THE COLLINEAR (DIAGONAL) MAXIMUM is the same formula with the annulus replaced by the
    four real points +-rho_1 +- rho_2, so the two agree exactly on the annulus boundary.

(4) AFFINENESS: inside the triangle region the whole value is affine in (p^2, r^2) at fixed
    (u_2, v_2), so along the norm segment 3 p^2 + r^2 = B its maximum sits at an endpoint of
    the region, where (3) says a diagonal configuration attains it.

Usage: python3 scripts/misc/screen_I106_annulus.py
"""

import numpy as np

rng = np.random.default_rng(20260916)
ALPHA, BETA = 15.0 / 4.0, 9.0 / 4.0


def g_of(t1, t2, a, b, c):
    return a * np.cos(t1) + b * np.cos(t2) - c * np.cos(t1 - t2)


def annulus_dist(r1, r2):
    return max(0.0, 1.0 - r1 - r2, abs(r1 - r2) - 1.0)


def collinear_dist(r1, r2):
    return min(abs(1.0 - r1 - r2), abs(1.0 - abs(r1 - r2)))


def check_identity(trials=200000):
    worst = 0.0
    for _ in range(trials):
        r1, r2, lam = rng.uniform(0, 3, 3)
        t1, t2 = rng.uniform(-np.pi, np.pi, 2)
        a, b, c = 2 * lam * r2, 2 * lam * r1, 2 * lam * r1 * r2
        lhs = lam * (1 + r1**2 + r2**2) - g_of(t1, t2, a, b, c)
        z = 1 - r2 * np.exp(1j * t1) - r1 * np.exp(1j * t2)
        worst = max(worst, abs(lhs - lam * abs(z) ** 2))
    return worst


def check_closed_form(cases=3000, grid=1441):
    th = np.linspace(-np.pi, np.pi, grid)
    T1, T2 = np.meshgrid(th, th, indexing="ij")
    worst_free, worst_coll = 0.0, 0.0
    for _ in range(cases):
        r1, r2 = rng.uniform(0, 3, 2)
        lam = rng.uniform(0.1, 3)
        a, b, c = 2 * lam * r2, 2 * lam * r1, 2 * lam * r1 * r2
        num = g_of(T1, T2, a, b, c).max()
        pred = lam * (1 + r1**2 + r2**2 - annulus_dist(r1, r2) ** 2)
        worst_free = max(worst_free, abs(num - pred))
        coll = max(g_of(t1, t2, a, b, c)
                   for t1 in (0.0, np.pi) for t2 in (0.0, np.pi))
        pred_c = lam * (1 + r1**2 + r2**2 - collinear_dist(r1, r2) ** 2)
        worst_coll = max(worst_coll, abs(coll - pred_c))
    return worst_free, worst_coll


def value(u2, v2, p, r, dA, dC, ta, tc, phase="free", grid=721):
    """Batch 11's value, with the phase sum maximised freely or over diagonal pairs."""
    lam = dA * dC / (BETA * v2)
    r1, r2 = BETA * v2 * r / dA, BETA * v2 * p / dC
    S = (ALPHA * (0.75 * u2**3 - 3 * u2 * p**2)
         + BETA * u2 * (0.75 * v2**2 - r**2) + ta * u2 + tc * v2)
    d = annulus_dist(r1, r2) if phase == "free" else collinear_dist(r1, r2)
    return S + lam * (1 + r1**2 + r2**2 - d**2)


def check_affine_and_closure(cases=400):
    """On the triangle region the value is affine in (p^2, r^2); and the free maximum over
    the norm segment is matched by a diagonal configuration on the same segment."""
    worst_affine, worst_gap = 0.0, -np.inf
    for _ in range(cases):
        dA, dC = rng.choice([0.3, 1.0, 3.0], 2)
        ta, tc = rng.normal(scale=3, size=2)
        u2 = rng.normal()
        v2 = abs(rng.normal()) + 1e-3
        B = abs(rng.normal()) * 2 + 1e-3

        # (4a) affineness in (x, y) = (p^2, r^2) wherever the annulus contains 1
        for _ in range(40):
            x, y = rng.uniform(0, B / 3), rng.uniform(0, B)
            x2, y2 = rng.uniform(0, B / 3), rng.uniform(0, B)
            for w in (0.3, 0.7):
                xm, ym = w * x + (1 - w) * x2, w * y + (1 - w) * y2
                pts = [(x, y), (x2, y2), (xm, ym)]
                rs = [(BETA * v2 * np.sqrt(b) / dA, BETA * v2 * np.sqrt(a) / dC)
                      for a, b in pts]
                if any(annulus_dist(*q) > 0 for q in rs):
                    continue
                vals = [value(u2, v2, np.sqrt(a), np.sqrt(b), dA, dC, ta, tc) for a, b in pts]
                worst_affine = max(worst_affine, abs(vals[2] - (w * vals[0] + (1 - w) * vals[1])))

        # (4b) free maximum over the segment 3x + y = B, against the diagonal maximum
        xs = np.linspace(0, B / 3, 4001)
        ys = np.maximum(B - 3 * xs, 0.0)
        free = max(value(u2, v2, np.sqrt(x), np.sqrt(y), dA, dC, ta, tc, "free")
                   for x, y in zip(xs, ys))
        diag = max(value(u2, v2, np.sqrt(x), np.sqrt(y), dA, dC, ta, tc, "diag")
                   for x, y in zip(xs, ys))
        worst_gap = max(worst_gap, free - diag)
    return worst_affine, worst_gap


if __name__ == "__main__":
    print(f"(1) identity, worst residual over 200000 draws: {check_identity():.3e}")
    f, c = check_closed_form()
    print(f"(2) closed form against a 1441^2 phase grid, worst gap: {f:.3e}")
    print(f"(3) collinear closed form, worst gap: {c:.3e}")
    aff, gap = check_affine_and_closure()
    print(f"(4a) affineness on the triangle region, worst defect: {aff:.3e}")
    print(f"(4b) free maximum minus diagonal maximum on the same norm segment: {gap:.3e}")
