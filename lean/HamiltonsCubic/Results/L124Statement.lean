import Mathlib

set_option linter.style.longLine false

/-!
# L124, the half-flat four-set family: the sharp determinant bound and its rigidity

## The record's statement, verbatim

> #### Lemma L124, on the half-flat four-set family, $\theta=9\det V_+$, and $\theta^2\le\tfrac32\rho^2$ with equality exactly at $\pm W_{\mathbb{CP}^2}$
>
> **Fix a four-subset $S=\{i,j,k,l\}$ and write $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$,
> $C=M_{il}+M_{jk}$ for the opposite-pair sums, $\Sigma:=A^2+B^2+C^2-AB-BC-CA$, and
> $V_+:=W|_{\Lambda^2_+\langle S\rangle}$ with $\rho^2:=\lVert W|_{\Lambda^2\langle S\rangle}\rVert^2$.
> Call $W$ *half-flat at $S$* when $W|_{\Lambda^2\langle S\rangle}$ annihilates
> $\Lambda^2_-\langle S\rangle$.**
>
> > **(i) If $A+B+C=0$ then $\Sigma=\tfrac32(A^2+B^2+C^2)$**, an identity in three reals, carrying
> > no information about $W$.
> >
> > **(ii) Half-flat at $S$ $\Rightarrow$ $A,B,C$ are the DIAGONAL ENTRIES of $V_+$** in the basis
> > $\omega_1=(e_{ij}+e_{kl})/\sqrt2$, $\omega_2=(e_{ik}-e_{jl})/\sqrt2$,
> > $\omega_3=(e_{il}+e_{jk})/\sqrt2$, whence
> > $$\Sigma=\tfrac32\lVert\operatorname{diag}V_+\rVert^2\le\tfrac32\rho^2,\qquad\text{equality iff the three opposite-pair planes are $W$-invariant.}$$
> >
> > **(iii) THE RIGIDITY, and it is a statement about ONE POINT. On the half-flat family supported
> > at one four-set, $\theta=9\det V_+$; the sharp bound $\lvert\det X\rvert\le\lVert
> > X\rVert^3/(3\sqrt6)$ on traceless symmetric $3\times3$ then gives $\theta^2\le\tfrac32\rho^2$,
> > with equality exactly at $\pm W_{\mathbb{CP}^2}$, which is moreover the family's ONLY critical
> > point, since $\nabla\det$ on the sphere forces two equal eigenvalues.**
> >
> > **THE FORM "$\theta^2\le\Sigma$" IS A NON SEQUITUR AND IS WITHDRAWN.** *$\Sigma$ is
> > frame-dependent and $\theta$ is not, so the ordering holds only in $V_+$'s own eigenframe,
> > where $\Sigma=\tfrac32\rho^2$. Rotate $V_+$ to zero diagonal and $\Sigma=0<\theta^2=\tfrac32$.*

[second-order.md](../../../findings/second-order.md), Lemma L124.

## What this file states

**The record withdrew `θ² ≤ Σ`, and its heading now reads `θ² ≤ (3/2)ρ²`.** What is stated is
what survives: clause (i) in full, the algebraic half of clause (ii), and the whole of clause
(iii)'s analytic content, the sharp determinant bound on traceless symmetric `3×3` together with
its equality case, from which `θ² ≤ (3/2)ρ²` and the rigidity at `±W_{ℂP²}` follow. All of it is
PROVED.

**Clause (iii) is proved through the cubic discriminant**, which is the one line the record does
not print: for `x + y + z = 0`,
`((x-y)(y-z)(z-x))² = (x²+y²+z²)³/2 - 27(xyz)²`, so `(xyz)² ≤ (x²+y²+z²)³/54` with equality
exactly when two of the three coincide. That is the sharp bound `|det X| ≤ ‖X‖³/(3√6)` and its
equality case at once.

**`det` and `‖·‖` are read on the spectrum.** `V₊` is real symmetric, so `det V₊ = xyz` and
`‖V₊‖² = x² + y² + z²` for its eigenvalues, the classical spectral theorem, which is why the
determinant clause is stated in eigenvalue coordinates. The trace-free hypothesis is `x+y+z = 0`,
which is the record's own `A + B + C = 0`.

## Where the rest is typed, and what is not

**The geometric half of clause (ii)** and `θ = 9 det V₊` are in [L124Half.lean](L124Half.lean), on `Λ²₊` of the
coordinate four-set (`pair_sums_diag`, `half_flat_values`), and the family's only critical point is in
[L124Crit.lean](L124Crit.lean) (`crit_iff`, `crit_iff_CP`). This file keeps `theta_sq_le_of_det`, stated on a real
number named `θ`, as the scalar core those files instantiate.

**Absent**: the record's zero-diagonal witness against `Σ = (3/2)ρ²`, which needs the theorem that every traceless
symmetric matrix is orthogonally similar to one with zero diagonal.
-/

namespace HamiltonsCubic.L124Statement

open Finset

/-- `Σ = A² + B² + C² - AB - BC - CA`. -/
def Sig (A B C : ℝ) : ℝ := A ^ 2 + B ^ 2 + C ^ 2 - A * B - B * C - C * A

/-! ## Clause (i) -/

/-- **(i)** If `A + B + C = 0` then `Σ = (3/2)(A² + B² + C²)`. *An identity in three reals.* -/
theorem sig_of_trace_free (A B C : ℝ) (h : A + B + C = 0) :
    Sig A B C = (3 / 2) * (A ^ 2 + B ^ 2 + C ^ 2) := by
  unfold Sig
  linear_combination (-(1 / 2) * (A + B + C)) * h

/-! ## Clause (ii), its algebraic half -/

/-- `ρ² = ‖V‖²`, the squared Frobenius norm. -/
def frobSq (V : Matrix (Fin 3) (Fin 3) ℝ) : ℝ := ∑ i, ∑ j, V i j ^ 2

/-- `‖diag V‖²`. -/
def diagSq (V : Matrix (Fin 3) (Fin 3) ℝ) : ℝ := V 0 0 ^ 2 + V 1 1 ^ 2 + V 2 2 ^ 2

/-- The off-diagonal mass of `V`. -/
def offSq (V : Matrix (Fin 3) (Fin 3) ℝ) : ℝ :=
  V 0 1 ^ 2 + V 0 2 ^ 2 + V 1 0 ^ 2 + V 1 2 ^ 2 + V 2 0 ^ 2 + V 2 1 ^ 2

theorem frob_split (V : Matrix (Fin 3) (Fin 3) ℝ) : frobSq V = diagSq V + offSq V := by
  unfold frobSq diagSq offSq
  rw [Fin.sum_univ_three, Fin.sum_univ_three, Fin.sum_univ_three, Fin.sum_univ_three]
  ring

/-- **(ii), the part that is algebra**: with `A, B, C` the diagonal entries of a trace-free `V₊`,
`Σ = (3/2)‖diag V₊‖² ≤ (3/2)ρ²`. -/
theorem sig_le_frob (V : Matrix (Fin 3) (Fin 3) ℝ) (h : V 0 0 + V 1 1 + V 2 2 = 0) :
    Sig (V 0 0) (V 1 1) (V 2 2) = (3 / 2) * diagSq V ∧
      Sig (V 0 0) (V 1 1) (V 2 2) ≤ (3 / 2) * frobSq V := by
  have heq : Sig (V 0 0) (V 1 1) (V 2 2) = (3 / 2) * diagSq V := by
    rw [sig_of_trace_free _ _ _ h]; unfold diagSq; ring
  refine ⟨heq, ?_⟩
  have hoff : 0 ≤ offSq V := by unfold offSq; positivity
  rw [heq, frob_split]
  linarith

/-- **The equality case of (ii)**: `Σ = (3/2)ρ²` exactly when `V₊` is diagonal, which is the
record's "the three opposite-pair planes are `W`-invariant". -/
theorem sig_eq_frob_iff (V : Matrix (Fin 3) (Fin 3) ℝ) (h : V 0 0 + V 1 1 + V 2 2 = 0) :
    Sig (V 0 0) (V 1 1) (V 2 2) = (3 / 2) * frobSq V ↔ offSq V = 0 := by
  obtain ⟨heq, _⟩ := sig_le_frob V h
  rw [heq, frob_split]
  constructor
  · intro hh; linarith
  · intro hh; rw [hh]; ring

/-! ## Clause (iii): the sharp determinant bound and its rigidity -/

/-- **The cubic discriminant, on the trace-free plane.** This is the identity the sharp bound
comes from, and the record does not print it. -/
theorem disc_identity (x y z : ℝ) (h : x + y + z = 0) :
    ((x - y) * (y - z) * (z - x)) ^ 2
      = (x ^ 2 + y ^ 2 + z ^ 2) ^ 3 / 2 - 27 * (x * y * z) ^ 2 := by
  have hz : z = -x - y := by linarith
  subst hz
  ring

/-- **The sharp bound `|det X| ≤ ‖X‖³/(3√6)` on traceless symmetric `3×3`**, in the squared form
`(det X)² ≤ ‖X‖⁶/54` that carries no square root. -/
theorem det_sq_le (x y z : ℝ) (h : x + y + z = 0) :
    (x * y * z) ^ 2 ≤ (x ^ 2 + y ^ 2 + z ^ 2) ^ 3 / 54 := by
  have hd := disc_identity x y z h
  nlinarith [sq_nonneg ((x - y) * (y - z) * (z - x)), hd]

/-- **The equality case**: the bound is attained exactly when two eigenvalues coincide. -/
theorem det_sq_eq_iff (x y z : ℝ) (h : x + y + z = 0) :
    (x * y * z) ^ 2 = (x ^ 2 + y ^ 2 + z ^ 2) ^ 3 / 54 ↔ (x - y) * (y - z) * (z - x) = 0 := by
  have hd := disc_identity x y z h
  constructor
  · intro hh
    have : ((x - y) * (y - z) * (z - x)) ^ 2 = 0 := by rw [hd, hh]; ring
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.1 this
  · intro hh
    rw [hh] at hd
    nlinarith [hd]

/-- **The sharp bound in the form the record uses**: with `θ = 9·det V₊` and `ρ² = ‖V₊‖²` read on
the spectrum, `θ² ≤ (3/2)ρ⁶`; on the unit-norm family, where `ρ² = 1`, this is `θ² ≤ 3/2`.

*`hθ` is not this lemma's conclusion in disguise: `θ = 9 det V₊` is clause (iii)'s geometric input,
which is exactly what is recorded above as NOT typed here.* -/
theorem theta_sq_le_of_det (x y z θ : ℝ) (h : x + y + z = 0) (hθ : θ = 9 * (x * y * z)) :
    θ ^ 2 ≤ (3 / 2) * (x ^ 2 + y ^ 2 + z ^ 2) ^ 3 := by
  have hb := det_sq_le x y z h
  rw [hθ]
  nlinarith [hb]

/-- **The unit-norm form.** -/
theorem theta_sq_le_unit (x y z θ : ℝ) (h : x + y + z = 0) (hρ : x ^ 2 + y ^ 2 + z ^ 2 = 1)
    (hθ : θ = 9 * (x * y * z)) : θ ^ 2 ≤ 3 / 2 := by
  have := theta_sq_le_of_det x y z θ h hθ
  rw [hρ] at this
  linarith

/-- **The rigidity, in the direction the record states it**: equality forces two eigenvalues to
coincide, which with `x+y+z = 0` and `‖V₊‖ = 1` leaves only `±(2,-1,-1)/√6` up to permutation. -/
theorem theta_sq_eq_forces_repeat (x y z θ : ℝ) (h : x + y + z = 0)
    (hρ : x ^ 2 + y ^ 2 + z ^ 2 = 1) (hθ : θ = 9 * (x * y * z)) (heq : θ ^ 2 = 3 / 2) :
    (x - y) * (y - z) * (z - x) = 0 := by
  refine (det_sq_eq_iff x y z h).1 ?_
  rw [hρ]
  rw [hθ] at heq
  nlinarith [heq]

/-- **`W_{ℂP²}` attains it.** With `(x,y,z) = (2,-1,-1)/√6` the eigenvalues are trace-free of unit
norm, and `θ = 9xyz = √(3/2)`. -/
theorem cp2_attains :
    (2 / Real.sqrt 6) + (-1 / Real.sqrt 6) + (-1 / Real.sqrt 6) = 0 ∧
    (2 / Real.sqrt 6) ^ 2 + (-1 / Real.sqrt 6) ^ 2 + (-1 / Real.sqrt 6) ^ 2 = 1 ∧
    (9 * ((2 / Real.sqrt 6) * (-1 / Real.sqrt 6) * (-1 / Real.sqrt 6))) ^ 2 = 3 / 2 := by
  have h6 : Real.sqrt 6 ^ 2 = 6 := Real.sq_sqrt (by norm_num)
  have h6pos : (0 : ℝ) < Real.sqrt 6 := Real.sqrt_pos.2 (by norm_num)
  have h66 : Real.sqrt 6 ^ 6 = 216 := by
    rw [show (Real.sqrt 6) ^ 6 = ((Real.sqrt 6) ^ 2) ^ 3 by ring, h6]; norm_num
  have h6' : Real.sqrt 6 ≠ 0 := ne_of_gt h6pos
  refine ⟨by field_simp; norm_num, ?_, ?_⟩
  · field_simp
    linarith [h6]
  · field_simp
    linarith [h66]

/-! ## A witness, so the hypotheses are not empty

*`(x,y,z) = (1,0,-1)` is trace-free, so `det_sq_le` and `disc_identity` are not vacuous; there the
bound reads `0 ≤ 8/54` and is strict, so the equality case is not automatic either.* -/

example : (1 : ℝ) + 0 + (-1) = 0 := by norm_num

example : ((1 : ℝ) * 0 * (-1)) ^ 2 < ((1 : ℝ) ^ 2 + 0 ^ 2 + (-1) ^ 2) ^ 3 / 54 := by norm_num

end HamiltonsCubic.L124Statement
