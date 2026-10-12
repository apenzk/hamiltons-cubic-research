import Mathlib

/-!
# L13, the spectral-moment ceiling, STATED

[curvature-invariants.md](../../../findings/curvature-invariants.md)'s Lemma L13, quoted verbatim:

> **Statement.** Let `W` be a critical point of `P` on the unit sphere of `𝒲ₙ` with
> `θ = P(W) > 0`, let `L_W : H ↦ W ∘ H` be the multiplication operator, and let
> `k₀ = dim(O(n)·W)`. Then
>
> `θ²(1 + k₀/4) ≤ tr(L_W²) = κₙ`,   `κₙ = (n−1)(2n−1)/4`.
>
> **Proof.** Criticality gives `L_W W = θW`. Differentiating `O(n)`-equivariance of `Q` along the
> orbit gives `L_W o_A = (θ/2) o_A` for every orbit tangent `o_A`, and the orbit tangent space is
> orthogonal to `W`. `L_W` is self-adjoint, so `tr(L_W²)` is the sum of its squared eigenvalues,
> which is at least `θ² + k₀(θ/2)²`. `□`

## What is proved, and what the `sorry` is

The display has two halves and they belong to different results.

* **`θ²(1 + k₀/4) ≤ tr(L_W²)` is L13's own**, and it is proved here in full, as
  `trace_lower_bound`. Its hypotheses are the three facts the record's proof derives before the
  linear algebra starts, `L_W W = θW`, `L_W = (θ/2)` on the orbit tangents, and those tangents
  orthonormal and orthogonal to `W`, and the conclusion is the inequality.
* **`tr(L_W²) = κₙ` is [Lemma L161](../../../findings/curvature-invariants.md)'s**, which reads
  the constant off any single tensor once Fox's Theorem 1.3 makes it `W`-independent. That is the
  file's one `sorry`: `kappa_eq`. It is the record's own result and not a published one, so it
  stays a `sorry` rather than moving into a binder.

`L13` below is the two composed, and it is the record's display.

## The Peirce cap is absent, deliberately

The step is a **lower** bound on a sum of squares, so a cap, an upper bound on eigenvalues,
supplies nothing. What is consumed is the *attainment* of `θ/2` on the orbit, which needs no
maximality. *The block previously cited the cap as an input; `trace_lower_bound` shows the proof
runs without any upper bound on the spectrum at all.*

## What is NOT typed here

* **That `L_W` is the multiplication operator `H ↦ W ∘ H`**, or that `L_W W = θW` is criticality:
  the Lean layer has no algebra structure on `𝒲ₙ`, so `L` below is an abstract self-adjoint
  operator carrying the three properties the record's proof extracts.
* **`k₀ = dim(O(n)·W)`.** `k₀` below is the number of orthonormal orbit tangents supplied; that
  this equals the orbit's dimension is the record's.
* **The refuted clause** *"attained on a subspace of dimension exactly `dim(O(n)·u)`"*. Only
  *"at least"* is consumed downstream, and only *"at least"* is stated: `trace_lower_bound` takes
  an orthonormal family, not a basis of the eigenspace.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L13Statement

open RealInnerProductSpace Finset

/-! ## The inequality, proved -/

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]

/-- **L13's own half.** For a self-adjoint `L` with `L W = θW` at a unit `W`, and `k₀`
orthonormal vectors orthogonal to `W` on which `L` acts by `θ/2`,

`θ²(1 + k₀/4) ≤ tr(L²)`.

*The proof is the record's: extend the orthonormal family `{W} ∪ {o_i}` to an orthonormal basis,
read `tr(L²)` as `Σ‖L b‖²` (every term nonnegative) and keep the `k₀ + 1` terms the family
supplies.* -/
theorem trace_lower_bound (L : V →ₗ[ℝ] V) (hL : L.IsSymmetric) (θ : ℝ)
    (W : V) (hW : ‖W‖ = 1) (hLW : L W = θ • W)
    (k₀ : ℕ) (o : Fin k₀ → V) (ho : Orthonormal ℝ o) (hoW : ∀ i, ⟪W, o i⟫ = 0)
    (hLo : ∀ i, L (o i) = (θ / 2) • o i) :
    θ ^ 2 * (1 + (k₀ : ℝ) / 4) ≤ LinearMap.trace ℝ V (L ∘ₗ L) := by
  classical
  -- the orthonormal family `{W} ∪ {o i}`
  set v : Fin (k₀ + 1) → V := Fin.cons W o with hv
  have hvorth : Orthonormal ℝ v := by
    constructor
    · intro i
      refine Fin.cases ?_ ?_ i
      · simpa [hv] using hW
      · intro j; simpa [hv] using ho.1 j
    · intro i j hij
      rcases Fin.eq_zero_or_eq_succ i with rfl | ⟨m, rfl⟩ <;>
        rcases Fin.eq_zero_or_eq_succ j with rfl | ⟨l, rfl⟩
      · exact absurd rfl hij
      · simpa [hv] using hoW l
      · have h := hoW m
        simpa [hv, real_inner_comm] using h
      · have hml : m ≠ l := fun h => hij (by rw [h])
        simpa [hv] using ho.2 hml
  have hinj : Function.Injective v := hvorth.linearIndependent.injective
  have hrange : Orthonormal ℝ ((↑) : Set.range v → V) :=
    (orthonormal_subtype_range hinj).mpr hvorth
  obtain ⟨u, b, hsub, hbcoe⟩ := hrange.exists_orthonormalBasis_extension
  -- the trace of `L²` is the sum of `‖L x‖²` over that basis
  have htr : LinearMap.trace ℝ V (L ∘ₗ L) = ∑ x ∈ u, ‖L x‖ ^ 2 := by
    rw [LinearMap.trace_eq_sum_inner (L ∘ₗ L) b]
    rw [← Finset.sum_coe_sort u (fun x => ‖L x‖ ^ 2)]
    refine Finset.sum_congr rfl fun x _ => ?_
    have h1 : ⟪b x, (L ∘ₗ L) (b x)⟫ = ⟪L (b x), L (b x)⟫ := (hL (b x) (L (b x))).symm
    rw [h1, real_inner_self_eq_norm_sq, hbcoe]
  -- the family's own terms are among them, and every term is nonnegative
  have himg : Finset.image v Finset.univ ⊆ u := by
    refine Finset.coe_subset.mp ?_
    simpa [Finset.coe_image, Set.image_univ] using hsub
  have hkeep : ∑ x ∈ Finset.image v Finset.univ, ‖L x‖ ^ 2 ≤ ∑ x ∈ u, ‖L x‖ ^ 2 :=
    Finset.sum_le_sum_of_subset_of_nonneg himg (fun i _ _ => by positivity)
  have himg2 : ∑ x ∈ Finset.image v Finset.univ, ‖L x‖ ^ 2 = ∑ i, ‖L (v i)‖ ^ 2 :=
    Finset.sum_image (fun x _ y _ h => hinj h)
  -- and those terms are `θ²` and `k₀` copies of `θ²/4`
  have hWterm : ‖L (v 0)‖ ^ 2 = θ ^ 2 := by
    have : v 0 = W := by simp [hv]
    rw [this, hLW, norm_smul, hW, mul_one, Real.norm_eq_abs, sq_abs]
  have hoterm : ∀ i : Fin k₀, ‖L (v i.succ)‖ ^ 2 = θ ^ 2 / 4 := by
    intro i
    have hvi : v i.succ = o i := by simp [hv]
    rw [hvi, hLo i, norm_smul, ho.1 i, mul_one, Real.norm_eq_abs, sq_abs]
    ring
  have hsum : ∑ i, ‖L (v i)‖ ^ 2 = θ ^ 2 + (k₀ : ℝ) * (θ ^ 2 / 4) := by
    rw [Fin.sum_univ_succ]
    rw [hWterm]
    congr 1
    rw [Finset.sum_congr rfl (fun i _ => hoterm i)]
    simp [Finset.sum_const, Finset.card_univ]
  rw [htr]
  calc θ ^ 2 * (1 + (k₀ : ℝ) / 4) = ∑ i, ‖L (v i)‖ ^ 2 := by rw [hsum]; ring
    _ = ∑ x ∈ Finset.image v Finset.univ, ‖L x‖ ^ 2 := himg2.symm
    _ ≤ ∑ x ∈ u, ‖L x‖ ^ 2 := hkeep

/-! ## The constant, which is L161's -/

/-- `κₙ = (n−1)(2n−1)/4`, the second moment of `L_W`, constant in `W`. -/
noncomputable def kappa (n : ℝ) : ℝ := (n - 1) * (2 * n - 1) / 4

/-! ### `tr(L_W²) = κₙ` is a HYPOTHESIS here, and the theorem that asserted it was FALSE

**A `theorem kappa_eq` stood here and quantified over EVERY symmetric `L`**, concluding
`tr (L ∘ₗ L) = kappa n` from nothing but symmetry and the dimension of `V`. *Nothing tied `L` to
the multiplication operator of a unit Weyl tensor, which is what [Lemma L161](../../../findings/curvature-invariants.md)
is about, so the statement was false at every symmetric operator of the wrong scale and its `sorry`
was undischargeable.* **`L13` below carried no `sorry` of its own and was proved from it**, so it
inherited the falsity: at `k₀ = 0` and the witness below it asserted `10000 ≤ 13.75`.

**The repair is the shape [WeylTraceStatement.lean](../Base/WeylTraceStatement.lean) already uses**:
the identity enters `L13` as a binder, so the debt is visible to every caller instead of hiding
behind a name, and `kappa_eq` is deleted rather than weakened. -/

/-- **THE WITNESS THAT THE DELETED STATEMENT WAS FALSE**, kept so the repair cannot be undone by
someone who reads only the prose. *At `n = 6` the space has dimension `15` and `κ₆ = 55/4`, while
`L = 100 • (projection onto a unit `W`)` is symmetric with `tr (L ∘ₗ L) = 10000`.* -/
theorem kappa_eq_was_false : (100 : ℝ) ^ 2 ≠ kappa 6 := by
  unfold kappa; norm_num

/-- **L13, the display.** `θ²(1 + k₀/4) ≤ tr(L_W²) = κₙ`.

**`htr` is the hypothesis the deleted `kappa_eq` pretended to prove.** *It holds at the
multiplication operator of a unit Weyl tensor, which is [Lemma L161](../../../findings/curvature-invariants.md),
and the layer cannot yet say "L is that operator", so it is taken as given and the debt is in the
binder where a caller must meet it.* -/
theorem L13 (n : ℕ) (hn : 6 ≤ n) (L : V →ₗ[ℝ] V) (hL : L.IsSymmetric)
    (hnorm : Module.finrank ℝ V = n * (n - 1) / 2) (θ : ℝ)
    (htr : LinearMap.trace ℝ V (L ∘ₗ L) = kappa n)
    (W : V) (hW : ‖W‖ = 1) (hLW : L W = θ • W)
    (k₀ : ℕ) (o : Fin k₀ → V) (ho : Orthonormal ℝ o) (hoW : ∀ i, ⟪W, o i⟫ = 0)
    (hLo : ∀ i, L (o i) = (θ / 2) • o i) :
    θ ^ 2 * (1 + (k₀ : ℝ) / 4) ≤ kappa n := by
  rw [← htr]
  exact trace_lower_bound L hL θ W hW hLW k₀ o ho hoW hLo

/-! ## The ceiling: what the method can conceivably give -/

/-- **At the largest possible orbit, `k₀ = C(n,2)`, the display becomes
`θ² ≤ 2(n−1)(2n−1)/(n²−n+8)`.** *A larger orbit gives a stronger bound, so this is the method's
best output, a ceiling on its power, not a bound it delivers at a given point.* -/
theorem ceiling {n θ : ℝ} (hn : 4 ≤ n)
    (h : θ ^ 2 * (1 + (n * (n - 1) / 2) / 4) ≤ kappa n) :
    θ ^ 2 ≤ 2 * (n - 1) * (2 * n - 1) / (n ^ 2 - n + 8) := by
  have hden : (0:ℝ) < n ^ 2 - n + 8 := by nlinarith
  rw [le_div_iff₀ hden]
  unfold kappa at h
  nlinarith [h]

/-- **And that ceiling never reaches `4`**, at any `n`: `2(n−1)(2n−1) < 4(n²−n+8)` clears to
`n > −15`. *So the best output the method can conceivably give is `θ ≤ 2 − o(1)`, against a true
value below `√2`.* -/
theorem ceiling_below_four {n : ℝ} (hn : 4 ≤ n) :
    2 * (n - 1) * (2 * n - 1) / (n ^ 2 - n + 8) < 4 := by
  have hden : (0:ℝ) < n ^ 2 - n + 8 := by nlinarith
  rw [div_lt_iff₀ hden]
  nlinarith

/-- **And it rises to `4`**: at `n = 1000` the ceiling already exceeds `3.98`. -/
theorem ceiling_rises :
    (3.98 : ℝ) < 2 * (1000 - 1) * (2 * 1000 - 1) / ((1000:ℝ) ^ 2 - 1000 + 8) := by norm_num

/-! ## The numbers at `n = 12` -/

/-- `κ₁₂ = 253/4`, `k₀ ≤ C(12,2) = 66`, and the ceiling there is `θ² ≤ 253/70`. -/
theorem at_twelve : kappa 12 = 253 / 4 ∧ (12 * 11 / 2 : ℕ) = 66 ∧
    (253 / 4 : ℝ) / (1 + 66 / 4) = 253 / 70 := by
  refine ⟨by unfold kappa; norm_num, by decide, by norm_num⟩

/-- **`√(253/70)` lies strictly between `1.901127` and `1.901128`**, bracketed by squaring,
against `θ₀(12) = 1.236033` and `√(3/2) = 1.224745`.

*The record prints `1.901128`; the value is `1.9011274850…`, so that figure is the last place
rounded up rather than truncated.* -/
theorem bound_at_twelve :
    ((1.901127 : ℝ)) ^ 2 < 253 / 70 ∧ (253:ℝ) / 70 < (1.901128 : ℝ) ^ 2 := by
  constructor <;> norm_num

/-- **The margin `58.9` is a ratio of two differences**, `(bound − θ₀)/(θ₀ − √(3/2))`, and it is
not a multiplicative excess: from the brackets alone it lies strictly between `58` and `59`. -/
theorem excess_at_twelve {l t s : ℝ}
    (hl1 : (1.901127 : ℝ) < l) (hl2 : l < 1.901128)
    (ht1 : (1.236033 : ℝ) < t) (ht2 : t < 1.236034)
    (hs1 : (1.224744 : ℝ) < s) (hs2 : s < 1.224745) :
    58 < (l - t) / (t - s) ∧ (l - t) / (t - s) < 59 := by
  have hden : (0 : ℝ) < t - s := by linarith
  constructor
  · rw [lt_div_iff₀ hden]; linarith
  · rw [div_lt_iff₀ hden]; linarith

/-- **At a point with a small orbit the same inequality is far weaker**: padded `W_{ℂP²}` at
`n = 12` has orbit `34`, where the bound reads `θ² ≤ 253/38`, above the ceiling `253/70`
itself. -/
theorem small_orbit_weaker :
    (253 / 4 : ℝ) / (1 + 34 / 4) = 253 / 38 ∧ (253:ℝ) / 70 < 253 / 38 := by
  constructor <;> norm_num

/-! ## The refuted clause, and why nothing moves -/

/-- *"Attained on a subspace of dimension exactly `dim(O(n)·u)`"* fails at critical points,
`18` against an orbit of `9` at `S³ × S³`, and `60` against `21` at `S² × S³ × S³`. **Only
"at least" is consumed downstream**, and `trace_lower_bound` states only that. -/
theorem dimension_clause_refuted : 9 < 18 ∧ 21 < 60 := by
  constructor <;> norm_num

end HamiltonsCubic.L13Statement
