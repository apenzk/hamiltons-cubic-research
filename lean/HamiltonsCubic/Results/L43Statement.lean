import Mathlib
import HamiltonsCubic.Base.WeylReal

set_option linter.style.longLine false

/-!
# L43, the criterion at `a = 0` demands exactly `θ₀(n)`

## The record's statement, quoted verbatim from [problem.md](../../../findings/problem.md)

> #### Lemma L43, the criterion at $a=0$ demands exactly $\theta_0(n)$

> On the slice $R_{\mathrm{ric}_0}=0$ the invariance criterion at $a=0$ collapses with no residue to
> \[
> \langle W,Q(W)\rangle\;\le\;\theta_0(n)\,\|W\|^3,\qquad \theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}n .
> \]

> **The collapse is an identity on the whole slice, not merely a vanishing at the boundary.**
> $\lVert\mathrm{ric}(I)\rVert^2$ cancels between the criterion's $F$ and the pairing, and the
> $c^3(n-1)\lVert I\rVert^2$ term is common to both sides, leaving exactly
> $\langle W,Q(W)\rangle-c(n-1)\lVert W\rVert^2$ and nothing else.

> **The slice is the EINSTEIN one.** […] *The cone also carries $\operatorname{scal}(R)>0$, which
> the printed $F$-sublevel set omits: $F$ is even in $R$, so without that clause the set is a double
> cone whose $c<0$ nappe reads $\langle W,Q(W)\rangle\le-\theta_0(n)\lVert W\rVert^3$, false at
> every sphere product.*

and the derivation the block points at, from the same file:

> Hence $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$, and **every cross term in the cubic vanishes** […] So
> $\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+\langle W,Q(W)\rangle$. On the right,
> $\lVert\mathrm{ric}(I)\rVert^2$ cancels between $F$ and the pairing, and the criterion collapses
> with **no residue at all** to
> $$\langle W,Q(W)\rangle\ \le\ c\,(n-1)\lVert W\rVert^2 .$$
> Normalising $\lVert W\rVert=1$, the $\partial\Omega_0$ constraint with
> $\lVert I\rVert^2=\dim\Lambda^2=\frac{n(n-1)}2$ gives $c=\frac1n\sqrt{\frac{2(n-2)}{n-1}}$,
> **the positive root, and $\operatorname{tr}(R)>0$ is what selects it.**

## What is typed here

The **second** half of the derivation, which is where the lemma's name lives: that the boundary
scalar `c` the cone `∂Ω₀` forces, multiplied by `n-1`, is exactly `θ₀(n)` and no other constant.

* `theta0` and `boundaryC`, the two constants, over `ℝ` throughout.
* `boundary_equation`, `c = boundaryC n` solves the `∂Ω₀` constraint
  `((n-2)/n)‖R_W‖² = ‖R_I‖²` at `‖W‖ = 1` with `‖I‖² = n(n-1)/2`, and it is the positive root.
* `collapse_constant`, **`c (n-1) = θ₀(n)`**, the lemma's "exactly `θ₀(n)`".
* `criterion_forms_agree`, at `‖W‖ = 1` the collapsed criterion `⟨W,Q(W)⟩ ≤ c(n-1)‖W‖²` and the
  lemma's display `⟨W,Q(W)⟩ ≤ θ₀(n)‖W‖³` are the same inequality, stated against the record's own
  `RealLayer.Pcubic`, `RealLayer.normSq` and `RealLayer.norm`.
* `lower_nappe_is_different`, `-θ₀(n) < 0 < θ₀(n)`: the constant the discarded nappe would demand
  has the opposite sign. *It types that sign fact only; the nappe itself is not stated.*

Everything below is proved; there is no `sorry`.

## What is NOT typed here

**The collapse itself is not stated.** Its subject is Beitz's cone `Ω₀`, the criterion function `F`,
and the Böhm–Wilking facts `Φ(I,W) = 0` and `Φ` preserving Weyl. `RealLayer` carries `Φ` as `Qop`,
with `Pcubic`, `normSq` and `Ric`, but no identity operator `I`, no decomposition
`R = cI + R_ric₀ + R_W`, no `F`, and neither Böhm–Wilking fact. Writing those objects here would be stating the lemma about definitions
invented in this file rather than about the record's, so the first half of the derivation, the
step from the criterion to `⟨W,Q(W)⟩ ≤ c(n-1)‖W‖²`, is absent rather than approximated.

**Nothing here asserts the bound.** `criterion_forms_agree` is an equivalence between two readings
of one inequality; it does not claim `θ ≤ θ₀(n)`, which is not L43's content and is open.
-/

namespace HamiltonsCubic.L43Statement

open HamiltonsCubic.RealLayer

/-! ## The two constants -/

/-- **`θ₀(n) = √(2(n-1)(n-2))/n`**, the target constant. -/
noncomputable def theta0 (n : ℝ) : ℝ := Real.sqrt (2 * (n - 1) * (n - 2)) / n

/-- **`c = (1/n)√(2(n-2)/(n-1))`**, the scalar the boundary `∂Ω₀` forces at `‖W‖ = 1`. -/
noncomputable def boundaryC (n : ℝ) : ℝ := (1 / n) * Real.sqrt (2 * (n - 2) / (n - 1))

/-! ## The boundary equation, and the constant it produces -/

/-- **`boundaryC n` solves the `∂Ω₀` constraint**, and it is the positive root: with `‖W‖ = 1` and
`‖I‖² = n(n-1)/2`, the equation `((n-2)/n)‖W‖² = c²‖I‖²` reads `(n-2)/n = c² n(n-1)/2`. -/
theorem boundary_equation (n : ℝ) (hn : 3 ≤ n) :
    (n - 2) / n = boundaryC n ^ 2 * (n * (n - 1) / 2) ∧ 0 < boundaryC n := by
  have h1 : (0 : ℝ) < n - 1 := by linarith
  have h2 : (0 : ℝ) < n - 2 := by linarith
  have hnpos : (0 : ℝ) < n := by linarith
  have hs : Real.sqrt (2 * (n - 2) / (n - 1)) ^ 2 = 2 * (n - 2) / (n - 1) :=
    Real.sq_sqrt (by positivity)
  constructor
  · simp only [boundaryC, mul_pow, div_pow, one_pow, hs]
    field_simp
  · have hsp : 0 < Real.sqrt (2 * (n - 2) / (n - 1)) := Real.sqrt_pos.mpr (by positivity)
    exact mul_pos (div_pos one_pos hnpos) hsp

/-- **`c (n-1) = θ₀(n)`**, the lemma's "exactly `θ₀(n)`". -/
theorem collapse_constant (n : ℝ) (hn : 3 ≤ n) :
    boundaryC n * (n - 1) = theta0 n := by
  have h1 : (0 : ℝ) < n - 1 := by linarith
  have h2 : (0 : ℝ) ≤ n - 2 := by linarith
  have hnpos : (0 : ℝ) < n := by linarith
  have key : Real.sqrt (2 * (n - 1) * (n - 2))
      = (n - 1) * Real.sqrt (2 * (n - 2) / (n - 1)) := by
    have hrw : 2 * (n - 1) * (n - 2) = (n - 1) ^ 2 * (2 * (n - 2) / (n - 1)) := by
      field_simp
    rw [hrw, Real.sqrt_mul (by positivity), Real.sqrt_sq h1.le]
  simp only [theta0, boundaryC, key]
  field_simp

/-! ## The two readings of the collapsed criterion -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **At unit norm the two forms of the criterion are one inequality.** The collapsed form
`⟨W,Q(W)⟩ ≤ c(n-1)‖W‖²` and the lemma's display `⟨W,Q(W)⟩ ≤ θ₀(n)‖W‖³` agree, `c(n-1)` being
`θ₀(n)` by `collapse_constant`. -/
theorem criterion_forms_agree (n : ℝ) (hn : 3 ≤ n) (W : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hsq : normSq W = 1) (hnorm : norm W = 1) :
    (Pcubic W ≤ boundaryC n * (n - 1) * normSq W) ↔ (Pcubic W ≤ theta0 n * norm W ^ 3) := by
  rw [hsq, hnorm, collapse_constant n hn]
  norm_num

/-! ## The `scal(R) > 0` clause is load-bearing -/

/-- **The nappe the clause discards demands the opposite constant.** `F` is even in `R`, so without
`scal(R) > 0` the sublevel set is a double cone whose lower nappe reads
`⟨W,Q(W)⟩ ≤ -θ₀(n)‖W‖³`; the two constants are distinct, and of opposite sign. -/
theorem lower_nappe_is_different (n : ℝ) (hn : 3 ≤ n) : -theta0 n < 0 ∧ 0 < theta0 n := by
  have h1 : (0 : ℝ) < n - 1 := by linarith
  have h2 : (0 : ℝ) < n - 2 := by linarith
  have hnpos : (0 : ℝ) < n := by linarith
  have : 0 < Real.sqrt (2 * (n - 1) * (n - 2)) := Real.sqrt_pos.mpr (by positivity)
  have hpos : 0 < theta0 n := by simp only [theta0]; positivity
  exact ⟨by linarith, hpos⟩

/-! ## The constant at the dimensions the record names -/

/-- **`θ₀(4) = √3/2`**, a value the record uses, checked against the closed form. -/
theorem theta0_four : theta0 4 = Real.sqrt 12 / 4 := by
  norm_num [theta0]

end HamiltonsCubic.L43Statement
