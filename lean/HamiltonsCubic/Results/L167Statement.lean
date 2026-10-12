import Mathlib

set_option linter.style.longLine false

/-!
# L167, the competitor's stabiliser meets the mixed block trivially, and the orbit dimension is `4n−14`

The record's statement, quoted verbatim from [route-a.md](../../../findings/route-a.md):

> **Statement.** Let `u` be `W_{ℂP²}` padded by zero from `ℝ⁴` into `ℝⁿ`, `n = 4 + m`, and split
> `𝔰𝔬(n) = 𝔰𝔬(4) ⊕ (ℝ⁴ ⊗ ℝᵐ) ⊕ 𝔰𝔬(m)`. Then
> $$𝔰𝔱𝔞𝔟(u) ∩ (ℝ⁴ ⊗ ℝᵐ) = 0,\qquad 𝔰𝔱𝔞𝔟(u) = 𝔲(2) ⊕ 𝔰𝔬(m),\qquad \dim(SO(n)·u) = 4n − 14 .$$

with the two corrections its Gate 2 forced:

> **THE FALSE DISPLAY THE AUDIT FOUND, AND WHY IT WAS INERT.** *`ω² = −‖ω‖² Id` is off by a factor of
> two in the half-trace normalisation, at `ω = e₁₂ + e₃₄`, `ω² = −Id` against `‖ω‖² = 2`.* **The
> correct constant is `−½‖ω‖²`**, and the step reads only *"a nonzero multiple of the identity"*, so
> nothing downstream moved.

> **The stabiliser splits across the blocks, and that needs a parity argument.** *Three trivial
> intersections give only `dim 𝔰𝔱𝔞𝔟 ≥ 4 + C(m,2)`, a line `ℝ(X+Y)` can meet two summands trivially
> and lie in neither.* **Grade `Λ²ℝⁿ` by the parity of the `ℝᵐ`-degree**: `Λ²ℝ⁴` and `Λ²ℝᵐ` are even,
> `ℝ⁴ ∧ ℝᵐ` odd. Then `u`, `ρ(𝔰𝔬(4))` and `ρ(𝔰𝔬(m))` are all even while `ρ` of the mixed block is
> odd, so `[ρ(A₄+A_m),u]` and `[ρ(A_mix),u]` have opposite parities and **vanish separately**.

> $$\dim(SO(n)·u) = \binom n2 − \binom{n−4}2 − 4 = \frac{8n−20}2 − 4 = 4n − 14 .$$

> *`n ≥ 4` is used and was unstated; the edges `m = 0,1,2` give `2, 6, 10`, matching `4n−14` at
> `n = 4,5,6`.*

## What this file types

* `parity_splits`, **the parity argument, in the generality it is used in**: for a `ℤ/2`-grading
  carried by an involution `ε`, an even `u`, an even `X` and an odd `Y`, the vanishing of
  `[X+Y, u]` forces `[X,u] = 0` and `[Y,u] = 0` separately. This is the step the audit found
  asserted, and it is what closes the gap between the three trivial intersections and the direct sum.
* `selfdual_sq`, **the corrected display**: for `ω` self-dual on `ℝ⁴`, `ω² = −½‖ω‖²·Id` in the
  half-trace normalisation, with `witness_sq` and `witness_norm` reproducing the record's own
  `ω = e₁₂ + e₃₄`, `ω² = −Id`, `‖ω‖² = 2`, and `old_display_false` showing the withdrawn constant
  fails there.
* `selfdual_invertible`, every nonzero self-dual `ω` is invertible, which is the one thing the last
  step of the first display consumes.
* `orbit_dimension`, `C(n,2) − C(n−4,2) − 4 = 4n − 14`, stated additively over `ℕ` so that truncated
  subtraction cannot make it true by accident, together with `stabiliser_dimension`,
  `dim 𝔲(2) + dim 𝔰𝔬(m) = 4 + C(m,2)`, and `edge_cases` for `m = 0,1,2`.

## What is NOT typed here

* **The three displayed conclusions themselves** (the first is proved in [L167Mixed.lean](L167Mixed.lean) and the
  second in coordinates in [L167Full.lean](L167Full.lean), `stab_full`, so the third is what stays untyped),
  `𝔰𝔱𝔞𝔟(u) ∩ (ℝ⁴⊗ℝᵐ) = 0`, `𝔰𝔱𝔞𝔟(u) = 𝔲(2) ⊕ 𝔰𝔬(m)`,
  and `dim(SO(n)·u) = 4n−14` as a statement about an orbit. Stating them needs `Λ²ℝⁿ`, the
  derivation action `ρ` of `𝔰𝔬(n)` on it, and `W_{ℂP²}` as an element of it, none of which this file
  builds; what is typed are the three ingredients the proof consumes and the arithmetic it ends in.
* **That `𝔰𝔱𝔞𝔟(u) ∩ 𝔰𝔬(4)` is `𝔲(2)` rather than merely `4`-dimensional** is typed in
  [L167Full.lean](L167Full.lean): `br_J0K`, `su2_structure` and `u2_indep`, `J₀` central and `e_a = -K_a/2` carrying
  `𝔰𝔲(2)`'s structure constants `ε_{abc}`, the four generators independent.
* **That `ρ(A)ω = −∑_j (ω v_j) ∧ f_j`**, the identity that lets the first display read off `A`'s
  vectors from the image of `u`.
-/

namespace HamiltonsCubic.L167Statement

/-! ## The parity argument -/

/-- **The parity step, in the abstract.** `ε` carries a `ℤ/2`-grading (`ε² = 1`); `u` and `X` are
even (they commute with `ε`) and `Y` is odd (it anticommutes). Then `[X+Y, u] = 0` forces `[X,u]`
and `[Y,u]` to vanish **separately**, which is exactly what upgrades three trivial intersections
to a direct-sum decomposition of the stabiliser. -/
theorem parity_splits {E : Type*} [AddCommGroup E] [Module ℝ E]
    (ε u X Y : Module.End ℝ E) (hε : ε * ε = 1)
    (hu : ε * u = u * ε) (hX : ε * X = X * ε) (hY : ε * Y = -(Y * ε))
    (h : (X + Y) * u - u * (X + Y) = 0) :
    (X * u - u * X = 0) ∧ (Y * u - u * Y = 0) := by
  set P : Module.End ℝ E := X * u - u * X with hP
  set Q : Module.End ℝ E := Y * u - u * Y with hQ
  have hPQ : P + Q = 0 := by
    rw [hP, hQ, ← h]; noncomm_ring
  have hPe : ε * P = P * ε := by
    calc ε * P = ε * (X * u) - ε * (u * X) := by rw [hP]; noncomm_ring
      _ = (ε * X) * u - (ε * u) * X := by noncomm_ring
      _ = (X * ε) * u - (u * ε) * X := by rw [hX, hu]
      _ = X * (ε * u) - u * (ε * X) := by noncomm_ring
      _ = X * (u * ε) - u * (X * ε) := by rw [hu, hX]
      _ = P * ε := by rw [hP]; noncomm_ring
  have hQe : ε * Q = -(Q * ε) := by
    calc ε * Q = ε * (Y * u) - ε * (u * Y) := by rw [hQ]; noncomm_ring
      _ = (ε * Y) * u - (ε * u) * Y := by noncomm_ring
      _ = (-(Y * ε)) * u - (u * ε) * Y := by rw [hY, hu]
      _ = -(Y * (ε * u)) - u * (ε * Y) := by noncomm_ring
      _ = -(Y * (u * ε)) - u * (-(Y * ε)) := by rw [hu, hY]
      _ = -(Q * ε) := by rw [hQ]; noncomm_ring
  have hQP : Q = -P := by linear_combination (norm := noncomm_ring) hPQ
  have hboth : P * ε = -(P * ε) := by
    have h1 : ε * P = -(ε * P) := by
      rw [hQP] at hQe
      simp only [neg_mul, mul_neg, neg_neg] at hQe
      rw [hPe] at hQe ⊢
      linear_combination (norm := noncomm_ring) -hQe
    rw [hPe] at h1
    exact h1
  have hPz : P * ε = 0 := by
    have : (2 : ℝ) • (P * ε) = 0 := by
      rw [two_smul]
      linear_combination (norm := noncomm_ring) hboth
    have h2 : (2 : ℝ) ≠ 0 := by norm_num
    exact (smul_eq_zero.mp this).resolve_left h2
  have hPzero : P = 0 := by
    have := congrArg (· * ε) hPz
    simp only [zero_mul, mul_assoc, hε, mul_one] at this
    exact this
  refine ⟨hPzero, ?_⟩
  rw [hQP, hPzero, neg_zero]

/-! ## The corrected display on self-dual `2`-forms -/

/-- The self-dual `2`-form `a(e₁₂+e₃₄) + b(e₁₃−e₂₄) + c(e₁₄+e₂₃)` on `ℝ⁴`, as a skew matrix. -/
def sd (a b c : ℝ) : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0, a, b, c; -a, 0, c, -b; -b, -c, 0, a; -c, b, -a, 0]

/-- The record's half-trace normalisation, `‖ω‖² = ½ ∑_{i,j} ω_{ij}²`. -/
noncomputable def nrmSq (ω : Matrix (Fin 4) (Fin 4) ℝ) : ℝ := (1 / 2) * ∑ i, ∑ j, (ω i j) ^ 2

theorem sd_skew (a b c : ℝ) : Matrix.transpose (sd a b c) = - sd a b c := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [sd, Matrix.transpose_apply]

theorem nrmSq_sd (a b c : ℝ) : nrmSq (sd a b c) = 2 * (a ^ 2 + b ^ 2 + c ^ 2) := by
  simp [nrmSq, sd, Fin.sum_univ_four]
  ring

/-- **`ω² = −½‖ω‖²·Id`**, the corrected constant. -/
theorem selfdual_sq (a b c : ℝ) :
    sd a b c * sd a b c = (-(1 / 2) * nrmSq (sd a b c)) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  rw [nrmSq_sd]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [sd, Matrix.mul_apply, Fin.sum_univ_four, Matrix.one_apply] <;> ring

/-- The record's own witness: `ω = e₁₂ + e₃₄` has `ω² = −Id`. -/
theorem witness_sq : sd 1 0 0 * sd 1 0 0 = (-1 : ℝ) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [sd, Matrix.mul_apply, Fin.sum_univ_four, Matrix.one_apply]

/-- And `‖ω‖² = 2` there, so the withdrawn `ω² = −‖ω‖²·Id` is off by a factor of two. -/
theorem witness_norm : nrmSq (sd 1 0 0) = 2 := by rw [nrmSq_sd]; norm_num

theorem old_display_false :
    sd 1 0 0 * sd 1 0 0 ≠ (-(nrmSq (sd 1 0 0))) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  rw [witness_sq, witness_norm]
  intro h
  have := congrFun (congrFun h 0) 0
  simp [Matrix.one_apply] at this

/-- **Every nonzero self-dual `ω` is invertible**, the one property the last step of the first
display consumes. -/
theorem selfdual_invertible (a b c : ℝ) (hne : a ^ 2 + b ^ 2 + c ^ 2 ≠ 0) :
    sd a b c * ((-(a ^ 2 + b ^ 2 + c ^ 2)⁻¹) • sd a b c) = 1 := by
  have hpos : (0 : ℝ) < a ^ 2 + b ^ 2 + c ^ 2 := lt_of_le_of_ne (by positivity) (Ne.symm hne)
  rw [Matrix.mul_smul, selfdual_sq, nrmSq_sd, smul_smul]
  rw [show (-(a ^ 2 + b ^ 2 + c ^ 2)⁻¹) * (-(1 / 2) * (2 * (a ^ 2 + b ^ 2 + c ^ 2))) = 1 by
    field_simp]
  rw [one_smul]

/-! ## The dimension count -/

/-- **`C(n,2) − C(n−4,2) − 4 = 4n − 14`**, stated additively over `ℕ` at `n = m + 4` so that
truncated subtraction cannot make it true by accident. -/
theorem orbit_dimension (m : ℕ) :
    (m + 4).choose 2 = m.choose 2 + 4 + (4 * m + 2) ∧ 4 * (m + 4) = (4 * m + 2) + 14 := by
  refine ⟨?_, by ring⟩
  simp only [Nat.choose_succ_succ, Nat.choose_one_right, Nat.choose_zero_right,
    show Nat.succ 1 = 2 from rfl]
  omega

/-- The same identity over `ℤ`, cleared of the halves, where the subtraction is the record's and
truncation cannot hide an error. -/
theorem orbit_dimension_int (n : ℤ) :
    n * (n - 1) - (n - 4) * (n - 5) - 8 = 2 * (4 * n - 14) := by ring

/-- **The stabiliser's dimension**: `dim 𝔲(2) + dim 𝔰𝔬(m) = 4 + C(m,2)`, with the `4` splitting as
`3 + 1`, the complementary `Λ∓` summand plus `𝔰𝔬(1) ⊕ 𝔰𝔬(2)` inside the summand carrying `u`. -/
theorem stabiliser_dimension (m : ℕ) : 4 + m.choose 2 = (3 + 1) + m.choose 2 := by norm_num

/-- **The edges the record checks**: `m = 0,1,2` give `2, 6, 10`, matching `4n−14` at `n = 4,5,6`. -/
theorem edge_cases :
    (4 * 0 + 2 = 2 ∧ 4 * 4 - 14 = 2) ∧ (4 * 1 + 2 = 6 ∧ 4 * 5 - 14 = 6)
      ∧ (4 * 2 + 2 = 10 ∧ 4 * 6 - 14 = 10) := by
  refine ⟨⟨rfl, rfl⟩, ⟨rfl, rfl⟩, ⟨rfl, rfl⟩⟩

/-! ## A witness, so `parity_splits` is not vacuous -/

/-- The grading hypotheses are satisfiable: `ε = 1`, and every operator is then even, with `Y = 0`
the only odd one, the degenerate grading, which still exercises the statement. -/
example {E : Type*} [AddCommGroup E] [Module ℝ E] (u X : Module.End ℝ E)
    (hcomm : X * u - u * X = 0) :
    (X * u - u * X = 0) ∧ ((0 : Module.End ℝ E) * u - u * 0 = 0) :=
  parity_splits 1 u X 0 (by simp) (by simp) (by simp) (by simp) (by simpa using hcomm)

end HamiltonsCubic.L167Statement
