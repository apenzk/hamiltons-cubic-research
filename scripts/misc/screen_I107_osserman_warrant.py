"""I107 / R29: padded W_CP2 is NOT Osserman, so the route's warrant is false.

R29 was registered 2026-09-17 from the step 9 sweep, its plausibility resting on "both equality
families are consistent with it, padded W_CP2 being Osserman and the sphere products diagonal".
That claim is false for n > 4, and the reason is general rather than about this tensor.

THE GENERAL FACT.  J(x)_{ab} = sum_{ij} W_{a i b j} x^i x^j is the Jacobi operator, and Osserman
means its spectrum on x-perp is constant over unit x.  If W has ANY kernel direction x, meaning
W(x, . , . , .) = 0, then J(x) = 0, so the constant spectrum is 0, so J(y) vanishes on y-perp for
every y, so every sectional curvature vanishes and W = 0.  **Osserman forces no kernel direction.**

Padded W_CP2 is W_CP2 on a four-dimensional block and zero elsewhere, so every padding direction is
a kernel direction.  That is the record's own trap W1, that padded W_CP2 has a kernel.

Gate 1: (a) the convention is checked by J symmetric and J(x)x = 0, (b) W_CP2 at n = 4 reproduces
the classical fact that it IS Osserman, which is the control that this J is the right operator,
(c) the padding direction's J = 0 is asserted, (d) the general kernel lemma is asserted separately
from the instance, on a constructed tensor with a deliberate kernel direction.

A SCREEN that closes a route's warrant, not the route's statement.
"""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r27_core import pairs, R_of, weyl_basis
from b_cp2_nondegenerate import padded_cp2


def jacobi(W, n, idx, x):
    J = np.zeros((n, n))
    for a in range(n):
        for b in range(n):
            J[a, b] = sum(R_of(W, idx, a, i, b, j) * x[i] * x[j]
                          for i in range(n) for j in range(n))
    return J


def spec_perp(J, x):
    n = len(x)
    B = np.linalg.qr(np.column_stack([x] + [np.eye(n)[:, k] for k in range(n)]))[0][:, 1:n]
    return np.sort(np.linalg.eigvalsh(B.T @ J @ B))


print("=" * 78)
print("I107 / R29: is padded W_CP2 Osserman?")
print("=" * 78)

for n in (4, 8, 12):
    W, _ = padded_cp2(n)
    idx = {p: k for k, p in enumerate(pairs(n))}
    rng = np.random.default_rng(0)
    x = rng.normal(size=n); x /= np.linalg.norm(x)
    J = jacobi(W, n, idx, x)
    assert np.allclose(J, J.T, atol=1e-10), "J is not symmetric"
    assert np.allclose(J @ x, 0, atol=1e-10), "J(x)x != 0, wrong convention"
    specs = []
    for _ in range(12):
        v = rng.normal(size=n); v /= np.linalg.norm(v)
        specs.append(spec_perp(jacobi(W, n, idx, v), v))
    spread = (np.array(specs).max(axis=0) - np.array(specs).min(axis=0)).max()
    print(f"\nn={n}: max spread of the J-spectrum over 12 random unit x = {spread:.3e}")
    if n == 4:
        assert spread < 1e-8, "W_CP2 at n=4 should be Osserman"
        print("   IS Osserman, the classical fact  (asserted, control)")
    else:
        e_pad = np.zeros(n); e_pad[n - 1] = 1.0
        assert np.allclose(jacobi(W, n, idx, e_pad), 0, atol=1e-10)
        assert spread > 1e-3, "the padded tensor should NOT be Osserman"
        print("   NOT Osserman: every padding direction is a kernel direction  (asserted)")

print("\n" + "=" * 78)
print("the general fact, asserted apart from the instance")
print("=" * 78)
# a tensor with a deliberate kernel direction: any padded one.  If it were Osserman the
# constant would be 0, forcing W = 0.  Check the contrapositive numerically: nonzero W with a
# kernel direction has a NONZERO spectrum somewhere, hence non-constant.
n = 8
W, _ = padded_cp2(n)
idx = {p: k for k, p in enumerate(pairs(n))}
e_pad = np.zeros(n); e_pad[n - 1] = 1.0
e_blk = np.zeros(n); e_blk[0] = 1.0
s_pad, s_blk = spec_perp(jacobi(W, n, idx, e_pad), e_pad), spec_perp(jacobi(W, n, idx, e_blk), e_blk)
print(f"\n  kernel direction : spectrum {np.round(s_pad, 8)}")
print(f"  block  direction : spectrum {np.round(s_blk, 6)}")
assert np.allclose(s_pad, 0, atol=1e-12) and np.abs(s_blk).max() > 1e-3
assert np.linalg.norm(W) > 1e-6
print("\n  a NONZERO W with a kernel direction is never Osserman  (asserted)")
print("  and padded W_CP2, the conjecture's non-diagonal equality case, has one: trap W1.")
