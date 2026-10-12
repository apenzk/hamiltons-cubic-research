import Mathlib.Tactic

/-!
# L247 at a general three-value spectrum: the certificate in the traced rows

[findings/second-order.md](../../../findings/second-order.md), Lemma L247, extension. The proof uses only the six
rows of `E_0`, `E_1` (h0 to h5); h6 to h9 are carried for the statement's symmetry (r1170).

[the per-vector note](../../../reviews/2026-09-25-I73c-per-vector-rows.md), the general-spectrum
paragraph. Eigenvalues `l0, l1, l2` with multiplicities `p0, m, p2`; the ten hypotheses are the nine
traced rows ((A), (B), (C) over each class) and `tr W = 0`. With `T = −(1/2θ) ∑_c l_c t_(0,2,c)` the
bracket certificate's trace, `θ · 4T = −2 ∑_c l_c t_(0,2,c)`, and the statement is
`Den (l0 − l1)(θ 4T − θ p0) = const + c000 t000 + c011 t011 + c122 t122` with
`Den = 2 (l0 − l2)² (l1 − l2)² (n − 1) θ`. The coefficients come from exact linear algebra; the kernel
checks the identity by `linear_combination` over the ten rows.
-/

namespace HamiltonsCubic.ClassTraceGeneral

set_option maxRecDepth 10000 in
set_option maxHeartbeats 4000000 in
theorem general_identity (t000 t001 t002 t011 t012 t022 t111 t112 t122 t222 l0 l1 l2 θ n p0 m p2 : ℝ)
    (h0 : -p0*(n - 2) + t000 + 2*t001 + 2*t002 + t011 + 2*t012 + t022 = 0)
    (h1 : l0*p0 + l0*t000 + l0*t001 + l0*t002 + l1*t001 + l1*t011 + l1*t012 + l2*t002 + l2*t012 + l2*t022 = 0)
    (h2 : l0^2*t000 + 2*l0*l1*t001 + 2*l0*l2*t002 - l0*p0*(-l0 + θ) + l1^2*t011 + 2*l1*l2*t012 + l2^2*t022 = 0)
    (h3 : -m*(n - 2) + t001 + 2*t011 + 2*t012 + t111 + 2*t112 + t122 = 0)
    (h4 : l0*t001 + l0*t011 + l0*t012 + l1*m + l1*t011 + l1*t111 + l1*t112 + l2*t012 + l2*t112 + l2*t122 = 0)
    (h5 : l0^2*t001 + 2*l0*l1*t011 + 2*l0*l2*t012 + l1^2*t111 + 2*l1*l2*t112 - l1*m*(-l1 + θ) + l2^2*t122 = 0)
    (h6 : -p2*(n - 2) + t002 + 2*t012 + 2*t022 + t112 + 2*t122 + t222 = 0)
    (h7 : l0*t002 + l0*t012 + l0*t022 + l1*t012 + l1*t112 + l1*t122 + l2*p2 + l2*t022 + l2*t122 + l2*t222 = 0)
    (h8 : l0^2*t002 + 2*l0*l1*t012 + 2*l0*l2*t022 + l1^2*t112 + 2*l1*l2*t122 + l2^2*t222 - l2*p2*(-l2 + θ) = 0)
    (h9 : l0*p0 + l1*m + l2*p2 = 0) :
    (2*θ*(l0 - l2)^2*(l1 - l2)^2*(n - 1)) * (l0 - l1) * (-2 * (l0 * t002 + l1 * t012 + l2 * t022) - θ * p0) =
      (-θ*(l0 - l1)*(n - 1)*(2*l0^4*l1*p0 - l0^4*l2*p0 - 2*l0^3*l1^2*p0 - 4*l0^3*l1*l2*p0 - 2*l0^3*l1*p0*θ + 2*l0^3*l2^2*p0 + l0^3*l2*p0*θ + 5*l0^2*l1^2*l2*p0 - 2*l0^2*l1*l2^2*n*p0 + 4*l0^2*l1*l2^2*p0 + 4*l0^2*l1*l2*p0*θ + l0^2*l2^3*n*p0 - 2*l0^2*l2^3*p0 - 2*l0^2*l2^2*p0*θ + 2*l0*l1^3*l2*m*n - 2*l0*l1^3*l2*m - 2*l0*l1^2*l2^2*m*n + 2*l0*l1^2*l2^2*m + 2*l0*l1^2*l2^2*n*p0 - 6*l0*l1^2*l2^2*p0 + 2*l0*l1^2*l2*m*θ - l0*l1^2*l2*p0*θ - 2*l0*l1*l2^2*m*θ - 2*l1^3*l2^2*m*n + 2*l1^3*l2^2*m + 2*l1^2*l2^3*m*n - 2*l1^2*l2^3*m - l1^2*l2^3*n*p0 + 2*l1^2*l2^3*p0 - 2*l1^2*l2^2*m*θ + 2*l1^2*l2^2*p0*θ + 2*l1*l2^3*m*θ - 4*l1*l2^3*p0*θ + 2*l2^4*p0*θ)) + (-θ*(l0 - l1)^2*(l0 - l2)^2*(n - 1)*(2*l0*l1 - l0*l2 - l1*l2)) * t000 + (θ*(l0 - l1)^2*(l1 - l2)^2*(n - 1)*(2*l0*l1 + l0*l2 - 3*l1*l2)) * t011 + (2*l2*θ*(l0 - l1)*(l0 - l2)*(l1 - l2)^3*(n - 1)) * t122 := by
  linear_combination (l2^2*θ*(l0 - l1)^2*(n - 1)*(2*l0*l1 - l0*l2 - l1*l2)) * h0 + (-2*θ*(l0 - l1)*(n - 1)*(2*l0^2*l1^2 - 2*l0^2*l1*l2 + l0^2*l2^2 - 4*l0*l1^2*l2 + 4*l0*l1*l2^2 - 2*l0*l2^3 + l1^2*l2^2)) * h1 + (θ*(l0 - l1)*(n - 1)*(l0 + l1 - 2*l2)*(2*l0*l1 - l0*l2 - 3*l1*l2 + 2*l2^2)) * h2 + (-2*l1^2*l2*θ*(l0 - l1)*(l0 - l2)*(l1 - l2)*(n - 1)) * h3 + (4*l1*l2*θ*(l0 - l1)*(l0 - l2)*(l1 - l2)*(n - 1)) * h4 + (-2*l2*θ*(l0 - l1)*(l0 - l2)*(l1 - l2)*(n - 1)) * h5

end HamiltonsCubic.ClassTraceGeneral
