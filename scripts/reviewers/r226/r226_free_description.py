"""r226 -- does the free-description fence post hold?

Checks, against Levin-Chandrasekaran Definition 1.4 (a freely-described element
is a sequence {v_n} of invariants with phi_n^*(v_{n+1}) = v_n, i.e. RESTRICTION
compatibility, since phi_n^* is the orthogonal projection):

  T1  Weyl_n embeds in Weyl_{n+1} under zero-padding (trace-freeness survives).
  T2  A=|W|^6, B=<Q(W),W>^2, C=|W|^2|Q(W)|^2 are restriction-compatible, so each
      is a freely-described element.  Planted violation: the Weyl-PROJECTED Q,
      whose projector carries 1/n factors, must break the check.
  T3  At the balanced sphere product Q(W) = theta W exactly, so C-B = 0 there and
      the multiplier term cannot rescue the free extension.
  T4  Theta_n^2 with the PARITY-CORRECT value is strictly increasing in n.
  T5  The "n = delta^a_a" repair: is {n} a freely-described scalar?
"""
import sys, os
from fractions import Fraction as F
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "scripts"))
sys.path.insert(0, "scripts")
import numpy as np
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, ricci_from_mop, frob, norm

def pad(L2s, L2b, Mop):
    """zero-pad an operator on Lambda^2 R^n into Lambda^2 R^m, m>n."""
    N = L2b.N
    out = np.zeros((N, N))
    for a, pa in enumerate(L2s.pairs):
        for b, pb in enumerate(L2s.pairs):
            out[L2b.idx[pa], L2b.idx[pb]] = Mop[a, b]
    return out

def ABC(L2, Mop, project=False):
    Q = Q_op(L2, Mop)
    if project:
        Q, _, _ = weyl_from_mop(L2, Q)
    w2 = frob(Mop, Mop)
    A = w2 ** 3
    B = frob(Q, Mop) ** 2
    C = w2 * frob(Q, Q)
    return A, B, C

def rand_weyl(n, seed):
    """a random element of Weyl_n, built by projecting a random curvature op."""
    rng = np.random.default_rng(seed)
    L2 = Lambda2(n)
    M = rng.normal(size=(L2.N, L2.N)); M = (M + M.T) / 2
    W, Ric, S = weyl_from_mop(L2, M)
    return L2, W

print("=" * 72)
print("T1/T2  padding-compatibility of Weyl_n and of A, B, C")
print("=" * 72)
for n in (5, 6):
    L2, W = rand_weyl(n, seed=n)
    A0, B0, C0 = ABC(L2, W)
    Ric0 = ricci_from_mop(L2, W)
    print(f"\n n={n}  |Ric(W)|_max = {np.max(np.abs(Ric0)):.2e}  (W is Weyl)")
    for m in (n + 1, n + 2):
        L2b = Lambda2(m)
        Wp = pad(L2, L2b, W)
        Ricp = ricci_from_mop(L2b, Wp)
        A, B, C = ABC(L2b, Wp)
        ok = max(abs(A - A0) / abs(A0), abs(B - B0) / abs(B0), abs(C - C0) / abs(C0))
        print(f"   pad to m={m}: |Ric|_max={np.max(np.abs(Ricp)):.2e}  "
              f"relerr(A,B,C) = {abs(A-A0)/abs(A0):.2e} {abs(B-B0)/abs(B0):.2e} "
              f"{abs(C-C0)/abs(C0):.2e}")
        assert np.max(np.abs(Ricp)) < 1e-10, "padded W left Weyl_m -- no consistent sequence"
        assert ok < 1e-10, "A, B or C is NOT restriction-compatible"
print("\n  => Weyl_n < Weyl_{n+1} and A, B, C each restrict correctly: FREELY DESCRIBED.")

print("\n" + "-" * 72)
print("PLANTED VIOLATION  -- redo T2 with Q replaced by its Weyl projection,")
print("whose projector carries 1/n factors.  The check MUST fire.")
print("-" * 72)
fired = False
for n in (5, 6):
    L2, W = rand_weyl(n, seed=n)
    A0, B0, C0 = ABC(L2, W, project=True)
    for m in (n + 1, n + 2):
        L2b = Lambda2(m)
        Wp = pad(L2, L2b, W)
        A, B, C = ABC(L2b, Wp, project=True)
        rc = abs(C - C0) / abs(C0)
        rb = abs(B - B0) / abs(B0)
        print(f"  n={n}->m={m}: relerr B = {rb:.3e}   relerr C = {rc:.3e}")
        if rc > 1e-6:
            fired = True
assert fired, "planted violation did NOT fire -- the T2 check has no teeth"
print("  => FIRED.  Free description of C depends on Q being the UNPROJECTED")
print("     W^2+W^#, which is what scripts/curvature_operator.py implements.")

print("\n" + "=" * 72)
print("T3  at the balanced sphere product, is Q(W) = theta*W exactly?")
print("    (if so the multiplier term C-B vanishes there and cannot rescue)")
print("=" * 72)
def sphere_product_mop(L2, p):
    Mop = np.zeros((L2.N, L2.N))
    for a, (i, j) in enumerate(L2.pairs):
        if (i < p and j < p) or (i >= p and j >= p):
            Mop[a, a] = 1.0
    return Mop

def Theta2(n):
    """parity-correct extremal constant, findings/problem.md"""
    if n % 2 == 0:
        return F(2 * (n - 1) * (n - 2), n * n)
    return F(2 * (n - 1) * (n - 3), (n + 1) * (n - 2))

for n in (6, 8, 10, 12):
    L2 = Lambda2(n)
    W, _, _ = weyl_from_mop(L2, sphere_product_mop(L2, n // 2))
    W = W / norm(W)
    Q = Q_op(L2, W)
    theta = frob(Q, W)
    resid = np.max(np.abs(Q - theta * W))
    slack = 1.0 * frob(Q, Q) - theta ** 2          # |W|^2|Q|^2 - <Q,W>^2, |W|=1
    print(f"  n={n:3d}: theta={theta:.12f}  Theta_n={float(Theta2(n))**0.5:.12f}"
          f"  |Q-theta W|_max={resid:.2e}   C-B={slack:.3e}")
    assert resid < 1e-10, "Q(W) is NOT a multiple of W at the balanced product"
    assert abs(theta - float(Theta2(n)) ** 0.5) < 1e-10
    assert abs(slack) < 1e-10, "the multiplier term does NOT vanish at the witness"
print("  => C-B = 0 at the witness, for EVERY mu.  The multiplier cannot rescue.")

print("\n" + "=" * 72)
print("T4  is the PARITY-CORRECT Theta_n^2 strictly increasing?")
print("=" * 72)
bad = [n for n in range(4, 400) if not Theta2(n + 1) > Theta2(n)]
print(f"  n=12..16: " + "  ".join(f"{n}:{float(Theta2(n)):.6f}" for n in range(11, 17)))
print(f"  n in [4,400) with Theta_{{n+1}}^2 <= Theta_n^2 : {bad}")
assert bad == [], "monotonicity fails across parity"
print("  => strictly increasing through BOTH parities, so the even-only formula")
print("     used in run_theta_free_description.py understates but does not")
print("     misstate the monotonicity.")

print("\n" + "=" * 72)
print("T5  the repair: is the scalar sequence {n} freely described?")
print("    Definition 1.4 needs phi_n^*(v_{n+1}) = v_n.  For the scalar n this")
print("    is the trace of the identity, and the trace does NOT commute with")
print("    the projection P_{V_n}.")
print("=" * 72)
for n in (5, 6, 7, 11, 12):
    I1 = np.eye(n + 1)
    P_I1 = I1[:n, :n]                     # phi_n^*(I_{n+1}) = orthogonal projection
    print(f"  n={n:3d}:  I_n IS freely described: P(I_{{n+1}}) = I_n ? "
          f"{np.array_equal(P_I1, np.eye(n))}"
          f"   BUT  tr(I_{{n+1}})={np.trace(I1):.0f} != tr(P(I_{{n+1}}))={np.trace(P_I1):.0f}")
    assert np.array_equal(P_I1, np.eye(n))
    assert np.trace(I1) != np.trace(P_I1)
print("  => delta^a_a = n is NOT a freely-described scalar.  Writing n as a")
print("     contraction changes the notation, not the sequence.")

print("\n" + "=" * 72)
print("T6  is {G_mu,n} itself freely described, and is its free extension")
print("    from n_0 negative at n > n_0?")
print("=" * 72)
for n0 in (12, 24):
    for n in (n0 + 1, n0 + 2, n0 + 12):
        gap = Theta2(n) - Theta2(n0)
        print(f"  n_0={n0} n={n}: free_ext(G)(W_n^bal) = Theta_{n0}^2-Theta_{n}^2 "
              f"= {gap * -1} = {-float(gap):.6f} < 0")
        assert gap > 0
print("  => the free extension is STRICTLY NEGATIVE at the balanced sphere")
print("     product of dimension n, for every mu.  Not nonnegative, so not SOS.")
print("\nDONE")

print("\n" + "=" * 72)
print("T7  clearing the denominator IS possible -- the brief's proposed reason")
print("    for claim 2 is refuted, so the repair must fail for another reason.")
print("=" * 72)
print("    n^2 * G_{mu,n} = 2(n-1)(n-2) A - n^2 B + mu n^2 (C-B),")
print("    every coefficient a POLYNOMIAL in n, and n^2>0 preserves SOS-ness.")
for n in (12, 13, 24):
    lhs = F(n * n) * Theta2(n)
    rhs = F(2 * (n - 1) * (n - 2)) if n % 2 == 0 else None
    print(f"    n={n:3d}: n^2 Theta_n^2 = {lhs}" +
          (f" = 2(n-1)(n-2) = {rhs}" if rhs is not None else
           "   (odd branch: clear (n+1)(n-2) instead)"))
assert F(144) * Theta2(12) == F(2 * 11 * 10)

print("\n" + "=" * 72)
print("T8  what IS freely describable: the NON-SHARP bound theta <= sqrt(2).")
print("=" * 72)
for n in (12, 13, 14, 24, 100):
    print(f"    n={n:3d}: 2 - Theta_n^2 = {F(2) - Theta2(n)} > 0")
    assert F(2) - Theta2(n) > 0
print("    so 2A - B + mu(C-B) has CONSTANT coefficients, is freely described,")
print("    and is nonnegative at every n.  The fence post bites the SHARP")
print("    constant, not every use of Theorem 3.5.")
print("\nDONE")
