import HamiltonsCubic.Results.L62
import Mathlib.Algebra.BigOperators.Ring.List

/-!
# L61b, why the bound is two-sided, and why "equality exactly on that orbit" was unreachable

Round [L61](../../../verification/ROUND_L61.md) made two changes to the record that
rest on one structural fact each, and stated both in prose:

* the certificate's bound is **two-sided**, `|θ| ≤ √(3/2)`, which the record had not
  claimed anywhere;
* *"with equality **exactly** on that orbit"* is false as written and **unreachable by a
  sum-of-squares certificate of that shape**, whatever its entries.

Both follow from `F₅`'s symmetries, and neither needs the certificate. Here they are
kernel-checked, in the same integer spectral form as
[L62](HamiltonsCubic/Results/L62.lean).
-/

namespace HamiltonsCubic.CP2

/-- `2 F₅` on a spectrum, cleared of the half: `3 (Σλ²)³ - 18 (Σλ³)²`. -/
def F5 (s : List ℤ) : ℤ :=
  3 * (s.map (fun x => x * x)).sum ^ 3 - 18 * (s.map (fun x => x * x * x)).sum ^ 2

theorem F5_at_W0 : F5 spec = 0 := by decide

/-! ## The two symmetries -/

/-- **`F₅` is even.** Negating the spectrum fixes `Σλ²` and negates `Σλ³`, which the
square absorbs. -/
theorem F5_neg (s : List ℤ) : F5 (s.map (fun x => -x)) = F5 s := by
  unfold F5
  simp only [List.map_map, Function.comp_def]
  have h2 : (s.map (fun x => -x * -x)).sum = (s.map (fun x => x * x)).sum := by
    congr 1; apply List.map_congr_left; intro x _; ring
  have h3 : (s.map (fun x => -x * -x * -x)).sum = (-1) * (s.map (fun x => x * x * x)).sum := by
    rw [← List.sum_map_mul_left]
    congr 1; apply List.map_congr_left; intro x _; ring
  rw [h2, h3]
  ring

/-- **`F₅` is homogeneous of degree six.** -/
theorem F5_smul (c : ℤ) (s : List ℤ) : F5 (s.map (fun x => c * x)) = c ^ 6 * F5 s := by
  unfold F5
  simp only [List.map_map, Function.comp_def]
  have h2 : (s.map (fun x => c * x * (c * x))).sum
      = c ^ 2 * (s.map (fun x => x * x)).sum := by
    rw [← List.sum_map_mul_left]
    congr 1; apply List.map_congr_left; intro x _; ring
  have h3 : (s.map (fun x => c * x * (c * x) * (c * x))).sum
      = c ^ 3 * (s.map (fun x => x * x * x)).sum := by
    rw [← List.sum_map_mul_left]
    congr 1; apply List.map_congr_left; intro x _; ring
  rw [h2, h3]
  ring

/-! ## What follows for the certificate

`F₅ ≥ 0` everywhere is what a sum of squares establishes. With `P = 3 tr(W³)` on `𝒲₅`
that reads `2 P² ≤ 3‖W‖⁶`, i.e. `θ² ≤ 3/2`, **a bound on the square, hence on `|θ|`,
which is the two-sided form.** The certificate never sees a sign.
-/

/-- The zero set of `F₅` is closed under negation. -/
theorem zero_set_neg (s : List ℤ) (h : F5 s = 0) : F5 (s.map (fun x => -x)) = 0 := by
  rw [F5_neg]; exact h

/-- The zero set of `F₅` is a cone. -/
theorem zero_set_cone (c : ℤ) (s : List ℤ) (h : F5 s = 0) :
    F5 (s.map (fun x => c * x)) = 0 := by
  rw [F5_smul, h, mul_zero]

/-- **`-W₀` lies in the zero set too**, which is the concrete instance: a certificate
proving `F₅ ≥ 0` fixes `Z(F₅)` and can say nothing finer, and `Z(F₅)` already contains
a point the claimed equality set need not. -/
theorem neg_W0_in_zero_set : F5 (spec.map (fun x => -x)) = 0 := by decide

/-! ## What this does and does not establish

**Establishes**: that the bound a nonnegativity certificate yields is two-sided, and
that `Z(F₅)` is a negation-closed cone, so *"equality exactly on the orbit of `W₀`"*
can hold only if that orbit is itself a negation-closed cone. **The obstruction is
structural and independent of the certificate's entries**, which is why round L61
called the clause unreachable rather than unproved.

**Does not establish**: whether `-W₀` lies in the `O(5)`-orbit of `W₀`. That is a group
fact, not an arithmetic one, and it is not needed for the statement above.
-/

end HamiltonsCubic.CP2
