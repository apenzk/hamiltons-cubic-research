"""r277 -- independent checks for gate2_brief_j, built from the definitions only.

Everything here is derived from the diagonal (vertex-matrix) form of a Weyl operator:
W(e_i ^ e_j) = w_ij e_i ^ e_j with w symmetric, hollow, and row sums zero, for which
  (W^2)_ij   = w_ij^2
  (W^#)_ij   = sum_{k != i,j} w_ik w_jk
  ||W||^2    = sum_{i<j} w_ij^2
  P(W)       = <W, Q(W)> = theta at a critical point Q(W) = theta W.
The convention is fixed by the control theta(S^3 x S^3) = theta_0(6) = sqrt(10)/3.
"""
from fractions import Fraction
from math import sqrt


def two_block(p, q):
    """theta of the S^p x S^q sphere product, from criticality alone. Returns (theta, n)."""
    n = p + q
    # row sums zero: (p-1)a + q b = 0 ; (q-1)c + p b = 0, in units of b = 1
    b = Fraction(1)
    a = Fraction(-q, p - 1) * b
    c = Fraction(-p, q - 1) * b
    # criticality, cross pair: b^2 + (p-1) a b + (q-1) b c = theta b
    theta_over_b = b + (p - 1) * a + (q - 1) * c
    assert theta_over_b == -(n - 1) * b, "cross equation must give theta = -(n-1) b"
    # criticality, within-A pair: (p-1) a^2 + q b^2 = theta a  -- an independent check
    assert (p - 1) * a * a + q * b * b == theta_over_b * a
    assert (q - 1) * c * c + p * b * b == theta_over_b * c
    norm2 = Fraction(p * (p - 1), 2) * a * a + Fraction(q * (q - 1), 2) * c * c + p * q * b * b
    return float(abs(theta_over_b) / sqrt(float(norm2))), n


def theta0(n):
    return sqrt(2 * (n - 1) * (n - 2)) / n


def harmonic(*thetas):
    return 1.0 / sqrt(sum(1.0 / t ** 2 for t in thetas))


print("== theta_0(n) from the two-block product, against sqrt(2(n-1)(n-2))/n ==")
for n in range(4, 17, 2):
    t, _ = two_block(n // 2, n // 2)
    print(f"  n={n:2d}  balanced {t:.9f}   theta_0 {theta0(n):.9f}   delta {abs(t-theta0(n)):.1e}")

print("\n== theta_0 is strictly increasing in n, and < sqrt(2) ==")
prev = None
for n in range(4, 40):
    v = theta0(n)
    assert prev is None or v > prev, n
    assert v < sqrt(2)
    prev = v
print("  checked n=4..39: strictly increasing, all < sqrt(2) = 1.414213562")
print(f"  theta_0(11)={theta0(11):.6f} < sqrt(3/2)={sqrt(1.5):.6f} < theta_0(12)={theta0(12):.6f}")

print("\n== the pieces of (S^4)^3 -- record says S^4 x S^8 (+) S^4 x S^4 ==")
t48, n48 = two_block(4, 8)
t44, n44 = two_block(4, 4)
print(f"  S^4 x S^8 : theta {t48:.9f}  ambient n = {n48}   (record 1.201561484)")
print(f"  S^4 x S^4 : theta {t44:.9f}  ambient n = {n44}   (record 1.145644)")
print(f"  harmonic recombination -> {harmonic(t48, t44):.9f}   (record theta((S^4)^3) = 0.829156)")
print(f"  ** the first piece lives at n_i = {n48} = n. 'n_i < n' FAILS. **")

print("\n== the n=4 base case: max P on Weyl_4 ==")
# Weyl_4 = Lambda^+ (+) Lambda^-, each a trace-free symmetric 3x3; P = 9(det W+ + det W-).
# max det over trace-free symmetric 3x3 of unit Frobenius norm is at (2,-1,-1)/sqrt(6).
lam = [2 / sqrt(6), -1 / sqrt(6), -1 / sqrt(6)]
dmax = lam[0] * lam[1] * lam[2]
print(f"  max det = {dmax:.9f},  9*max det = {9*dmax:.9f}  vs sqrt(3/2) = {sqrt(1.5):.9f}")
print(f"  balanced split t=1/sqrt(2): P = {9*dmax*(2*(0.5**1.5)):.9f}  vs theta_0(4) = {theta0(4):.9f}")
print("  ** max P on Weyl_4 = sqrt(3/2) > theta_0(4) = sqrt(3)/2, so '|theta_i| <= theta_0(n_i)' is FALSE at n_i = 4 **")

print("\n== the two forms of the harmonic-square law, k = 2 ==")
print("  |theta| < min|theta_i|   and   |theta| <= max|theta_i|/sqrt(k)")
for pair in [(1.0, 1.0), (1.0, 1.4), (1.41, 1.41), (1.0, 100.0)]:
    h = harmonic(*pair)
    print(f"   theta_i={pair}: theta={h:.6f}  min={min(pair):.6f}  max/sqrt2={max(pair)/sqrt(2):.6f}"
          f"   -> the binding one is {'max/sqrt(2)' if max(pair)/sqrt(2) < min(pair) else 'min'}")
print("  ** with |theta_i| < sqrt(2) the max/sqrt(2) form gives |theta| < 1 < theta_0(n) for every n >= 6,")
print("     unconditionally -- so the file's 'only where min|theta_i| <= theta_0(n)' caveat is vacuous. **")

print("\n== post 22's table as an independent witness of the law at k = 2 and k = 3 ==")
s = sqrt(1.5)
print(f"  CP^2 + CP^2      : harmonic({s:.4f},{s:.4f}) = {harmonic(s,s):.6f}   (post 22: 0.8660)")
print(f"  CP^2 x3          : harmonic of three            = {harmonic(s,s,s):.6f}   (post 22: 0.7071)")
