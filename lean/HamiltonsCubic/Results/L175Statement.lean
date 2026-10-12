import Mathlib

/-!
# L175, stated as the compression that loses `θ`

**The record's statement**, from [bounds-relaxations.md](../../../findings/bounds-relaxations.md)'s
*Lemma L175, no Schur-convexity argument ON THE SPECTRUM reaches `θ`*:

> **Statement.** `θ` is invisible to the spectrum `S`, the reason is
> [r649](../../../reviews/REVIEW_r649.md)'s, so no Schur-convexity argument **on the spectrum**
> reaches it. *In [Lemma L104](../../../findings/bounds-relaxations.md)'s reduced system `θ` occurs
> in (C) and nowhere else, which both audits confirmed; that observation is true and is not the
> fence.*

The block carries two riders that shape what may be typed:

> **THE SCOPE WAS LOST IN TRANSCRIPTION.** *The source reads "no Schur-convexity argument **on the
> spectrum** reaches `θ`"; the block, `INDEX-results.md`'s row and the machine-checked file all
> dropped three words.* **The narrow claim is provable and the general one is false.**

> **WHY THE GENERAL FENCE IS FALSE, WHICH IS THE USEFUL PART.** *(C) is solvable for `θ`: writing
> the three rows as one nonnegative measure and three moments gives `θ = gᵢ(T)` with `gᵢ` **linear
> and `θ`-free**.* **So a bound over the (A),(B)-feasible set of `gᵢ` bounds `θ`.**

## What `S` is here, and why

**`S` is the pair matrix `S_{ab} = Σ_c T_{abc}`, which is what the cited reason is about.** The
block writes "the spectrum `S`", but [r649](../../../reviews/REVIEW_r649.md)'s reason, the one it
names, is the compression `T ↦ S`, `binom N 3 → binom N 2`, and reads:

> Every scalar built from the pair matrix by `λ`-weighted contraction,
> `Σ_{ab} f(λ_a,λ_b) S_{ab} = Σ_{abc} f(λ_a,λ_b) T_{abc}`, is a contraction of `T` whose **third
> slot carries weight `λ⁰`**. At unit norm `θ = tr W³ + ½ Σ_{kαβ} λ_k λ_α λ_β T_{kαβ}`, whose
> `T`-dependence is the `{1,1,1}` pattern. **`θ` is invisible to `S`.**

So the two halves of that reason are `pairScalar_eq_lambdaZeroContraction` (proved) and
`theta_invisible_to_pairMatrix`, the separation, which is what "invisible" asserts, **proved by an
explicit witness**.

## What the separation says

**That the `{1,1,1}` contraction is not a function of the pair matrix**: two admissible `T` with
the same `S` and different `Σ λ_a λ_b λ_c T_{abc}`. The compression is injective below `N = 6`,
at `N = 5` the `3`-subset-to-`2`-subset inclusion map is square and of full rank, so the witness
must live at `N ≥ 6`. **The witness is at `N = 6`**: the two Pasch configurations on six points.

## What is NOT typed here

* **The fence itself.** *"No Schur-convexity argument on the spectrum reaches `θ`"* quantifies over
  arguments, and neither "Schur-convexity argument" nor "reaches" has a formal referent in this
  layer. **What is typed is the premise the fence is drawn from, and not the fence.**
* **The `θ`-freeness of (A) and (B) is deliberately absent.** Stating it as `relA θ ↔ relA θ'` is
  the empty theorem the audit of [L175.lean](L175.lean) already deleted, *"`X ↔ X` with both
  binders unused"*, so it is said here and not typed. What is typed instead is
  `C_determines_theta`, which is the fact that broke the general fence.
* **Weyl realisability is not imposed.** `IsAdmissible` is totally symmetric, hollow and
  nonnegative; it does not ask that `T` come from a `W ∈ 𝒲ₙ`, nor that it satisfy (A), (B), (C).
  The record's reason is a compression argument at that generality, and a separation among
  realisable `T` would be a stronger statement than the one quoted.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L175Statement

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The objects the compression is between -/

/-- **The `T` the toolbox works with**: totally symmetric, hollow, nonnegative. -/
structure IsAdmissible (T : ι → ι → ι → ℝ) : Prop where
  nonneg : ∀ a b c, 0 ≤ T a b c
  symm₁ : ∀ a b c, T a b c = T b a c
  symm₂ : ∀ a b c, T a b c = T a c b
  hollow₁ : ∀ a c, T a a c = 0
  hollow₂ : ∀ a b, T a b b = 0

/-- **The pair matrix `S_{ab} = Σ_c T_{abc}`**, the compression `T ↦ S`. -/
def pairMatrix (T : ι → ι → ι → ℝ) : ι → ι → ℝ := fun a b => ∑ c, T a b c

/-- **A `λ`-weighted contraction of the pair matrix**, `Σ_{ab} f(λ_a, λ_b) S_{ab}`. This is every
scalar the toolbox builds from `S`. -/
def pairScalar (f : ℝ → ℝ → ℝ) (lam : ι → ℝ) (T : ι → ι → ι → ℝ) : ℝ :=
  ∑ a, ∑ b, f (lam a) (lam b) * pairMatrix T a b

/-- **The `{1,1,1}` contraction, `Σ_{abc} λ_a λ_b λ_c T_{abc}`**, the `T`-dependence of `θ`, up to
the `½` and the `tr W³` term, neither of which touches `T`. -/
def tripleScalar (lam : ι → ℝ) (T : ι → ι → ι → ℝ) : ℝ :=
  ∑ a, ∑ b, ∑ c, lam a * lam b * lam c * T a b c

/-! ## The first half of r649's reason, proved -/

/-- **Every scalar built from the pair matrix is a `T`-contraction whose third slot carries weight
`λ⁰`.** *This is what `S` can see, and it is the half of the reason that is an identity.*
**Proved.** -/
theorem pairScalar_eq_lambdaZeroContraction (f : ℝ → ℝ → ℝ) (lam : ι → ℝ)
    (T : ι → ι → ι → ℝ) :
    pairScalar f lam T = ∑ a, ∑ b, ∑ c, f (lam a) (lam b) * T a b c := by
  unfold pairScalar pairMatrix
  exact Finset.sum_congr rfl fun a _ =>
    Finset.sum_congr rfl fun b _ => Finset.mul_sum _ _ _

/-! ## The second half, which is the lemma's premise -/

/-! ## The witness, two Pasch configurations on six points

*`{012, 034, 135, 245}` and `{013, 024, 125, 345}` cover the same twelve pairs, each once, so
their indicators have the same pair matrix; at `λ = (1,1,1,0,0,0)` the first contains the triple
`{012}` and the second no triple inside `{0,1,2}`, so their `{1,1,1}` contractions are `6` and `0`.
Each triple is encoded by the sum `2^a + 2^b + 2^c` of its distinct indices, which identifies it,
and every finite check is `decide`, kernel-evaluated.* -/

/-- **The indicator of a set of triples**, given by the codes `2^a + 2^b + 2^c` of its members. -/
def tri (codes : List ℕ) (a b c : Fin 6) : ℕ :=
  if a ≠ b ∧ b ≠ c ∧ a ≠ c ∧ (2 ^ a.val + 2 ^ b.val + 2 ^ c.val) ∈ codes then 1 else 0

/-- The Pasch configuration `{012, 034, 135, 245}`. -/
def paschA : List ℕ := [7, 25, 42, 52]
/-- The complementary Pasch configuration `{013, 024, 125, 345}`, on the same twelve pairs. -/
def paschB : List ℕ := [11, 21, 38, 56]

def lamN (i : Fin 6) : ℕ := if i.val < 3 then 1 else 0

theorem admissible (codes : List ℕ)
    (s1 : ∀ a b c : Fin 6, tri codes a b c = tri codes b a c)
    (s2 : ∀ a b c : Fin 6, tri codes a b c = tri codes a c b) :
    IsAdmissible (fun a b c => (tri codes a b c : ℝ)) where
  nonneg := fun _ _ _ => Nat.cast_nonneg _
  symm₁ := fun a b c => by exact_mod_cast s1 a b c
  symm₂ := fun a b c => by exact_mod_cast s2 a b c
  hollow₁ := fun a c => by simp [tri]
  hollow₂ := fun a b => by simp [tri]

theorem pairs_nat : ∀ a b : Fin 6, ∑ c, tri paschA a b c = ∑ c, tri paschB a b c := by decide

theorem triple_A : ∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, lamN a * lamN b * lamN c * tri paschA a b c = 6 := by
  decide

theorem triple_B : ∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6, lamN a * lamN b * lamN c * tri paschB a b c = 0 := by
  decide

/-- **`θ` is invisible to `S`.** Two admissible `T` with the same pair matrix and different
`{1,1,1}` contraction, so the compression `T ↦ S` discards exactly the contraction `θ` lives in.

*The witness must live at `N ≥ 6`, the compression being injective below that; it is the pair of
Pasch configurations above.* -/
theorem theta_invisible_to_pairMatrix :
    ∃ (lam : Fin 6 → ℝ) (T T' : Fin 6 → Fin 6 → Fin 6 → ℝ),
      IsAdmissible T ∧ IsAdmissible T' ∧
      (∀ a b, pairMatrix T a b = pairMatrix T' a b) ∧
      tripleScalar lam T ≠ tripleScalar lam T' := by
  refine ⟨fun i => (lamN i : ℝ), fun a b c => (tri paschA a b c : ℝ),
    fun a b c => (tri paschB a b c : ℝ), admissible _ (by decide) (by decide),
    admissible _ (by decide) (by decide), fun a b => ?_, ?_⟩
  · simp only [pairMatrix]
    exact_mod_cast pairs_nat a b
  · simp only [tripleScalar]
    have hA : (∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6,
        (lamN a : ℝ) * lamN b * lamN c * (tri paschA a b c : ℝ)) = 6 := by
      exact_mod_cast triple_A
    have hB : (∑ a : Fin 6, ∑ b : Fin 6, ∑ c : Fin 6,
        (lamN a : ℝ) * lamN b * lamN c * (tri paschB a b c : ℝ)) = 0 := by
      exact_mod_cast triple_B
    rw [hA, hB]
    norm_num


/-- **The sharp form of "invisible": no function of the pair matrix computes the `{1,1,1}`
contraction.** *This is what a Schur-convexity argument on `S` would need, and it is what the
separation denies.* **Proved from `theta_invisible_to_pairMatrix`.** -/
theorem tripleScalar_not_determined_by_pairMatrix :
    ∃ lam : Fin 6 → ℝ, ∀ F : (Fin 6 → Fin 6 → ℝ) → ℝ,
      ¬ (∀ T : Fin 6 → Fin 6 → Fin 6 → ℝ, IsAdmissible T →
          tripleScalar lam T = F (pairMatrix T)) := by
  obtain ⟨lam, T, T', hT, hT', hS, hne⟩ := theta_invisible_to_pairMatrix
  refine ⟨lam, fun F hF => hne ?_⟩
  rw [hF T hT, hF T' hT']
  congr 1
  funext a b
  exact hS a b

/-! ## Why the general fence (the one without "on the spectrum"), is false -/

/-- **(C)'s right side pins `θ`** as soon as `νᵢ ≠ 0`, so (C) is solvable for `θ` and a bound over
the (A),(B)-feasible set of the resulting linear, `θ`-free `gᵢ` does bound `θ`. *This is the
observation that refuted the unscoped fence at Gate 2, restated here from
[L175.lean](L175.lean) so the two halves of the block live together.* **Proved.** -/
theorem C_determines_theta (ν θ θ' : ℝ) (hν : ν ≠ 0)
    (h : 2 * ν * (θ - ν) = 2 * ν * (θ' - ν)) : θ = θ' := by
  have h2 : 2 * ν ≠ 0 := by simpa using hν
  have := mul_left_cancel₀ h2 h
  linarith

/-- **A witness that `IsAdmissible` is not empty**, so the separation above is a statement about a
nonempty class: the zero tensor is admissible, and so is the indicator of the distinct triples. -/
example : IsAdmissible (fun _ _ _ : Fin 6 => (0 : ℝ)) where
  nonneg := fun _ _ _ => le_refl 0
  symm₁ := fun _ _ _ => rfl
  symm₂ := fun _ _ _ => rfl
  hollow₁ := fun _ _ => rfl
  hollow₂ := fun _ _ => rfl

/-- A nonzero admissible witness: `T_{abc} = 1` exactly on the pairwise-distinct triples. *This is
the `T` the separation perturbs, and its admissibility is where the hollowness and symmetry
conventions are checked against something that is not `0`.* -/
example : IsAdmissible (fun a b c : Fin 6 =>
    if a ≠ b ∧ b ≠ c ∧ a ≠ c then (1 : ℝ) else 0) where
  nonneg := fun a b c => by split_ifs <;> norm_num
  symm₁ := fun a b c =>
    if_congr (by constructor <;> rintro ⟨h1, h2, h3⟩ <;> exact ⟨h1.symm, h3, h2⟩) rfl rfl
  symm₂ := fun a b c =>
    if_congr (by constructor <;> rintro ⟨h1, h2, h3⟩ <;> exact ⟨h3, h2.symm, h1⟩) rfl rfl
  hollow₁ := fun a c => by simp
  hollow₂ := fun a b => by simp

end HamiltonsCubic.L175Statement

#print axioms HamiltonsCubic.L175Statement.tripleScalar_not_determined_by_pairMatrix
