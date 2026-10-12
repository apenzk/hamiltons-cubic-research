import Mathlib

/-!
# L174, I36 is a statement about the vertex-matrix budget, STATED

[second-order.md](../../../findings/second-order.md)'s Lemma L174, quoted verbatim:

> **Statement.** Let `κ² = max_F t_F` be the vertex-matrix budget, and normalise so that
> `‖M‖_F = 1` for the operator `M` that L94's bound is stated over, **the sense of "unit" is
> load-bearing and the block did not state it.** […] Then
> `(every local maximiser with θ > √(3/2) is coordinate-diagonal in some frame) ⟺ (every such
> maximiser has κ² = 2)`.
>
> **Proof.** [Lemma L94](../../../findings/LEDGER.md) gives `κ² ≤ 2‖M‖_F²` with **equality
> exactly at coordinate-diagonal**, an "iff" […] carrying **attainment of `max_F`** […]. At the
> normalisation above that reads: `κ² = 2` holds precisely when some frame makes `W`
> coordinate-diagonal. Applying it under the outer quantifier over `W` gives each direction, on
> any class of `W` whatever including the empty one. `□`

And the block's own final correction, which is the form actually proved here:

> **AND THE MAXIMISER HYPOTHESES ARE DECORATION, SO THE LEMMA IS THIS.** *For every unit `W`:
> `κ² = 2` iff `W` is coordinate-diagonal in some frame; and for **any** class `𝒞` of unit
> operators whatever, every member of `𝒞` is coordinate-diagonal in some frame iff every member
> has `κ² = 2`.*

**What [L174.lean](L174.lean) already carries and this file does not repeat**: the equivalence at
the plan item's own class, with `L94` as a hypothesis. **What that file does not state is the
general form**, it is written at the single class `{local maximisers with θ > √(3/2)}`, which is
the specialisation the block says is decoration. The general form is typed here, together with
the three numerical facts the block's corrections turn on.

## Where `L94` sits

`L94` is a hypothesis here, named `h94`. It is proved at the concrete Weyl tensors by
[L94Statement.lean](L94Statement.lean)'s `kappaSq_eq_two_iff`, and [I36Budget.lean](I36Budget.lean)'s `l94_concrete'`
and [L174Inst.lean](L174Inst.lean)'s `L94_holds` discharge `h94` with it. **L174's own content is the transfer across
the quantifier**, which is what this file proves.

*The two risks the abstraction cannot see, both named by the block's Gate 2: the sense of "unit"
that makes `2‖M‖²` equal `2`, the `Λ²` operator matrix, which
[conventions.md](../../../findings/conventions.md) tables, and the per-frame/extremal swap, since
`kappaSq` is opaque here and substituting `t_F` for `max_F t_F` type-checks identically.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L174Statement

open Finset

/-! ## The general form, which is the lemma -/

variable {W F : Type*}

/-- **L94, taken as a hypothesis.** At unit norm, `κ² = 2` holds exactly when some frame makes the
operator coordinate-diagonal. -/
def L94 (IsCoordDiag : W → F → Prop) (kappaSq : W → ℝ) (IsUnit : W → Prop) : Prop :=
  ∀ w, IsUnit w → (kappaSq w = 2 ↔ ∃ f : F, IsCoordDiag w f)

/-- **L174, in the general form the block's last correction states.** For *any* class `𝒞` of unit
operators whatever (including the empty one), every member is coordinate-diagonal in some frame
iff every member attains the budget.

*This is the whole of the lemma: `L94` is applied under the outer quantifier, and the class plays
no part.* -/
theorem class_transfer (IsCoordDiag : W → F → Prop) (kappaSq : W → ℝ) (IsUnit C : W → Prop)
    (h94 : L94 (F := F) IsCoordDiag kappaSq IsUnit) (hC : ∀ w, C w → IsUnit w) :
    (∀ w, C w → ∃ f : F, IsCoordDiag w f) ↔ (∀ w, C w → kappaSq w = 2) := by
  constructor
  · intro h w hw; exact (h94 w (hC w hw)).mpr (h w hw)
  · intro h w hw; exact (h94 w (hC w hw)).mp (h w hw)

/-- **The specialisation [I36](../../../plan.md) needs**, which is the form the block displays:
`𝒞 = {unit local maximisers with θ > √(3/2)}`. -/
theorem I36_shape_iff_budget (IsCoordDiag : W → F → Prop) (kappaSq theta : W → ℝ)
    (IsUnit IsLocalMax : W → Prop) (t : ℝ)
    (h94 : L94 (F := F) IsCoordDiag kappaSq IsUnit) :
    (∀ w, IsUnit w → IsLocalMax w → t < theta w → ∃ f : F, IsCoordDiag w f)
      ↔ (∀ w, IsUnit w → IsLocalMax w → t < theta w → kappaSq w = 2) := by
  constructor
  · intro h w hu hm ht; exact (h94 w hu).mpr (h w hu hm ht)
  · intro h w hu hm ht; exact (h94 w hu).mp (h w hu hm ht)

/-- **The empty class satisfies both sides**, which is the block's *"on any class of `W` whatever
including the empty one"*, the equivalence carries no existential content of its own. -/
theorem empty_class (IsCoordDiag : W → F → Prop) (kappaSq : W → ℝ) (IsUnit : W → Prop)
    (h94 : L94 (F := F) IsCoordDiag kappaSq IsUnit) :
    (∀ w, (fun _ => False) w → ∃ f : F, IsCoordDiag w f)
      ↔ (∀ w, (fun _ => False) w → kappaSq w = 2) :=
  class_transfer IsCoordDiag kappaSq IsUnit (fun _ => False) h94 (fun _ h => h.elim)

/-! ## The ordered reading of `t`, which one audit ranked the first hazard

*Read as an unordered sum, `t_F ≤ 1` and `κ² = 2` holds nowhere, which would refute I36 by a
convention alone.* The definition is `t = ‖K‖_F² = Σ_{a≠b} K_{ab}²` for the symmetric hollow
sectional matrix `K_{ab} = W_{abab}`: a **matrix** Frobenius norm, so the index set is not a free
choice. -/

/-- **The ordered sum is exactly twice the unordered one**, for any symmetric hollow `K`. So the
two readings differ by the factor the numeral `2` records, and neither can be rescaled into the
other by changing what `κ²` means. -/
theorem ordered_is_double {m : ℕ} (K : Fin m → Fin m → ℝ)
    (hsym : ∀ a b, K a b = K b a) (hhollow : ∀ a, K a a = 0) :
    ∑ a, ∑ b, K a b ^ 2
      = 2 * ∑ p ∈ Finset.univ.filter (fun p : Fin m × Fin m => p.1 < p.2), K p.1 p.2 ^ 2 := by
  classical
  have hprod : ∑ a, ∑ b, K a b ^ 2 = ∑ p : Fin m × Fin m, K p.1 p.2 ^ 2 := by
    rw [Fintype.sum_prod_type]
  rw [hprod]
  rw [← Finset.sum_filter_add_sum_filter_not Finset.univ
        (fun p : Fin m × Fin m => p.1 < p.2) (fun p => K p.1 p.2 ^ 2)]
  have hswap : ∑ p ∈ Finset.univ.filter (fun p : Fin m × Fin m => ¬ p.1 < p.2), K p.1 p.2 ^ 2
      = ∑ p ∈ Finset.univ.filter (fun p : Fin m × Fin m => p.1 < p.2), K p.1 p.2 ^ 2 := by
    rw [← Finset.sum_filter_add_sum_filter_not
          (Finset.univ.filter (fun p : Fin m × Fin m => ¬ p.1 < p.2))
          (fun p : Fin m × Fin m => p.2 < p.1) (fun p => K p.1 p.2 ^ 2)]
    have hzero : ∑ p ∈ (Finset.univ.filter (fun p : Fin m × Fin m => ¬ p.1 < p.2)).filter
        (fun p : Fin m × Fin m => ¬ p.2 < p.1), K p.1 p.2 ^ 2 = 0 := by
      refine Finset.sum_eq_zero ?_
      intro p hp
      simp only [Finset.mem_filter] at hp
      have : p.1 = p.2 := le_antisymm (not_lt.mp hp.2) (not_lt.mp hp.1.2)
      rw [this, hhollow]
      ring
    rw [hzero, add_zero]
    refine Finset.sum_nbij' (fun p => (p.2, p.1)) (fun p => (p.2, p.1)) ?_ ?_ ?_ ?_ ?_
    · intro p hp
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hp ⊢
      exact hp.2
    · intro p hp
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hp ⊢
      exact ⟨not_lt.mpr (le_of_lt hp), hp⟩
    · intro p _; rfl
    · intro p _; rfl
    · intro p _; rw [hsym]
  rw [hswap]
  ring

/-- **And the operator form `t = 2‖diag W‖²` makes `t ≤ 2` Cauchy–Schwarz against `‖W‖ = 1`**,
the cheaper citation the block says it had quoted as a remark instead of using as the argument. -/
theorem t_le_two {ι : Type*} [Fintype ι] [DecidableEq ι] (Wm : ι → ι → ℝ)
    (hunit : ∑ i, ∑ j, Wm i j ^ 2 = 1) :
    2 * ∑ i, Wm i i ^ 2 ≤ 2 := by
  have hle : ∑ i, Wm i i ^ 2 ≤ ∑ i, ∑ j, Wm i j ^ 2 := by
    refine Finset.sum_le_sum ?_
    intro i _
    exact Finset.single_le_sum (f := fun j => Wm i j ^ 2) (fun j _ => sq_nonneg _)
      (Finset.mem_univ i)
  rw [hunit] at hle
  linarith

/-! ## The threshold, and the witness that makes the band non-empty -/

/-- **The threshold sits BELOW `θ₀(12)`, not above it**: `θ₀(12)² = 220/144 = 55/36 > 3/2`. So
`θ > √(3/2)` is the **weaker** hypothesis, which makes the theorem stronger and
[I36](../../../plan.md) harder. -/
theorem threshold_below_theta_zero : (3 : ℚ) / 2 < 55 / 36 ∧ (220 : ℚ) / 144 = 55 / 36 := by
  constructor <;> norm_num

/-- **The band is not empty and the record holds its witness**: `S⁵ × S⁷` at `n = 12` has
`θ² = 264/175`, strictly between `3/2` and `θ₀(12)² = 55/36`, and is a local maximiser by
[L69](../../../results.md), which is the whole of why it witnesses anything. -/
theorem band_witness :
    2 * (12 - 1 : ℚ) * (5 - 1) * (7 - 1) / ((12 - 2) * (5 * 7)) = 264 / 175 ∧
      (3 : ℚ) / 2 < 264 / 175 ∧ (264 : ℚ) / 175 < 55 / 36 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **`1 ≠ 2`, and nothing more.**

*It stands for the step "padded `W_{ℂP²}` has `κ² = 1`, so it fails `κ² = 2`", which is why the
strictness of `θ > √(3/2)` is load-bearing, but that step is about a curvature operator and this
is about two numerals.* -/
theorem one_ne_two : (1 : ℚ) ≠ 2 := by norm_num

/-- **A lower bound does not imply an upper one**: `1 ≤ x` does not give `x < 2`.

*It is the arithmetic behind "an ascent bounds `κ²` from below, so a recorded `κ² = 1` is evidence
in the wrong direction", a statement about `κ²` that this theorem does not make.* -/
theorem lower_bound_not_upper : ¬ (∀ x : ℝ, 1 ≤ x → x < 2) := by
  intro h
  exact absurd (h 2 (by norm_num)) (by norm_num)

/-- **Antisymmetry of `≤` at `2`**, which is `le_antisymm` at a numeral.

*It stands for "`κ² ≤ 2` is L94, so only `κ² ≥ 2` is owed"; the observation that a constructive
proof of the second exhibits a diagonalising frame is prose and is not typed.* -/
theorem eq_two_of_le_of_ge {x : ℝ} (hle : x ≤ 2) (hge : 2 ≤ x) : x = 2 := le_antisymm hle hge

end HamiltonsCubic.L174Statement
