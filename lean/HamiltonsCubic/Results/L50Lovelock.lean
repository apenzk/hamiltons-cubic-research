import Mathlib

set_option linter.style.longLine false

/-!
# L50's link (b): the Lovelock contraction, its value, and its vanishing below dimension six

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L50: on `𝒲ₙ`, `n ≤ 5`, `β = α/2`, through
`β − α/2 = −(1/64) δ^{a₁⋯a₆}_{b₁⋯b₆} W W W` and the vanishing of the six-index Kronecker delta at `n ≤ 5`. The record
calls the display's proportionality link (b), with its source unread. **This file proves its three parts**, in
coordinates `W : ι → ι → ι → ι → ℝ` with the algebraic symmetries `WeylC` (antisymmetry in each pair, pair symmetry,
first Bianchi):

- `LL_zero`: the contraction `LL W = ∑_σ sgn σ ∑_x W W W` vanishes when `ι` has at most five elements, each `x` repeating
  a value so the transposition of the two positions pairs every permutation with one of opposite sign;
- `T_eq`: `4T = α` for `T = W_{abcd}W_{aecf}W_{bdef}`, antisymmetrising the third factor in each of its pairs and
  applying Bianchi (`bianchi_diff`: `W_{abcd} − W_{adcb} = W_{acbd}`) each time;
- `gamma_eq`: `γ = β − T` for the second crossed contraction `γ = W_{abcd}W_{aecf}W_{bfde}`, Bianchi on the third factor;
- `collapse_of_display`: **given the expansion `LL W = 16α − 64γ`**, `β = α/2` below dimension six.

The expansion is proved in [L50Expand.lean](L50Expand.lean) as `LL_expand`, which discharges the hypothesis in
`collapse`. Of the `720` permutations, `640` contract some factor with itself and vanish by Ricci-flatness
([L50Self.lean](L50Self.lean)'s `selfEdge_zero`), and the other `80` fall into two classes, `α` with signed weight `16`
and `γ` with `−64`, as enumerated exactly by [classify_lovelock_terms.py](../../../scripts/misc/classify_lovelock_terms.py).
With `γ = β − α/4` this is the record's `−64(β − α/2)`.
-/
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L50Lovelock

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The algebraic symmetries of a Weyl tensor in coordinates. -/
structure WeylC (W : ι → ι → ι → ι → ℝ) : Prop where
  anti12 : ∀ a b c d, W a b c d = -W b a c d
  anti34 : ∀ a b c d, W a b c d = -W a b d c
  pair : ∀ a b c d, W a b c d = W c d a b
  bianchi : ∀ a b c d, W a b c d + W a c d b + W a d b c = 0

/-- `α = W_{abcd} W_{abef} W_{cdef}`, summed over `x : Fin 6 → ι` with `a, …, f = x 0, …, x 5`. -/
noncomputable def alphaC (W : ι → ι → ι → ι → ℝ) : ℝ :=
  ∑ x : Fin 6 → ι, W (x 0) (x 1) (x 2) (x 3) * W (x 0) (x 1) (x 4) (x 5) * W (x 2) (x 3) (x 4) (x 5)
/-- `β = W_{abcd} W_{aecf} W_{bedf}`. -/
noncomputable def betaC (W : ι → ι → ι → ι → ℝ) : ℝ :=
  ∑ x : Fin 6 → ι, W (x 0) (x 1) (x 2) (x 3) * W (x 0) (x 4) (x 2) (x 5) * W (x 1) (x 4) (x 3) (x 5)
/-- `γ = W_{abcd} W_{aecf} W_{bfde}`. -/
noncomputable def gammaC (W : ι → ι → ι → ι → ℝ) : ℝ :=
  ∑ x : Fin 6 → ι, W (x 0) (x 1) (x 2) (x 3) * W (x 0) (x 4) (x 2) (x 5) * W (x 1) (x 5) (x 3) (x 4)
/-- `T = W_{abcd} W_{aecf} W_{bdef}`. -/
noncomputable def TC (W : ι → ι → ι → ι → ℝ) : ℝ :=
  ∑ x : Fin 6 → ι, W (x 0) (x 1) (x 2) (x 3) * W (x 0) (x 4) (x 2) (x 5) * W (x 1) (x 3) (x 4) (x 5)

theorem bianchi_diff {W : ι → ι → ι → ι → ℝ} (hW : WeylC W) (a b c d : ι) :
    W a b c d - W a d c b = W a c b d := by
  have h := hW.bianchi a b c d
  have e1 : W a d b c = -W a d c b := hW.anti34 a d b c
  have e2 : W a c d b = -W a c b d := hW.anti34 a c d b
  linarith

/-- Relabelling the six summation variables by a permutation `π` of their positions. -/
theorem sum_relabel (π : Equiv.Perm (Fin 6)) (F : (Fin 6 → ι) → ℝ) :
    ∑ x : Fin 6 → ι, F x = ∑ x : Fin 6 → ι, F (x ∘ π) := by
  exact (Equiv.sum_comp (Equiv.arrowCongr π.symm (Equiv.refl ι)) F).symm

/-- **`γ = β − T`**, Bianchi on the third factor. -/
theorem gamma_eq {W : ι → ι → ι → ι → ℝ} (hW : WeylC W) : gammaC W = betaC W - TC W := by
  unfold gammaC betaC TC
  rw [← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun x _ => ?_
  have h := hW.bianchi (x 1) (x 5) (x 3) (x 4)
  have e1 : W (x 1) (x 4) (x 5) (x 3) = -W (x 1) (x 4) (x 3) (x 5) := hW.anti34 _ _ _ _
  have : W (x 1) (x 5) (x 3) (x 4) = W (x 1) (x 4) (x 3) (x 5) - W (x 1) (x 3) (x 4) (x 5) := by linarith
  rw [this]; ring

/-- **`4T = α`**: antisymmetrising `T`'s third factor in its first pair and its second pair, Bianchi each time. -/
theorem T_eq {W : ι → ι → ι → ι → ℝ} (hW : WeylC W) : 4 * TC W = alphaC W := by
  -- step 1: 2T = S, relabel b ↔ d
  set S := ∑ x : Fin 6 → ι, W (x 0) (x 2) (x 1) (x 3) * W (x 0) (x 4) (x 2) (x 5) * W (x 1) (x 3) (x 4) (x 5) with hS
  have h1 : 2 * TC W = S := by
    have hr := sum_relabel (Equiv.swap 1 3) (fun x : Fin 6 → ι =>
      W (x 0) (x 1) (x 2) (x 3) * W (x 0) (x 4) (x 2) (x 5) * W (x 1) (x 3) (x 4) (x 5))
    simp [Equiv.swap_apply_def] at hr
    have hT2 : TC W = -∑ x : Fin 6 → ι, W (x 0) (x 3) (x 2) (x 1) * W (x 0) (x 4) (x 2) (x 5) * W (x 1) (x 3) (x 4) (x 5) := by
      unfold TC; rw [hr, ← Finset.sum_neg_distrib]
      refine Finset.sum_congr rfl fun x _ => ?_
      rw [hW.anti12 (x 3) (x 1)]; ring
    have e : 2 * TC W = TC W + -(∑ x : Fin 6 → ι, W (x 0) (x 3) (x 2) (x 1) * W (x 0) (x 4) (x 2) (x 5) * W (x 1) (x 3) (x 4) (x 5)) := by
      rw [← hT2]; ring
    rw [e]
    unfold TC
    rw [← sub_eq_add_neg, ← Finset.sum_sub_distrib, hS]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [← bianchi_diff hW (x 0) (x 1) (x 2) (x 3)]; ring
  -- step 2: 2S = α, relabel e ↔ f, then b ↔ c
  have h2 : 2 * S = alphaC W := by
    have hr := sum_relabel (Equiv.swap 4 5) (fun x : Fin 6 → ι =>
      W (x 0) (x 2) (x 1) (x 3) * W (x 0) (x 4) (x 2) (x 5) * W (x 1) (x 3) (x 4) (x 5))
    simp [Equiv.swap_apply_def] at hr
    have hS2 : S = -∑ x : Fin 6 → ι, W (x 0) (x 2) (x 1) (x 3) * W (x 0) (x 5) (x 2) (x 4) * W (x 1) (x 3) (x 4) (x 5) := by
      rw [hS, hr, ← Finset.sum_neg_distrib]
      refine Finset.sum_congr rfl fun x _ => ?_
      rw [hW.anti34 (x 1) (x 3) (x 5) (x 4)]; ring
    have hα := sum_relabel (Equiv.swap 1 2) (fun x : Fin 6 → ι =>
      W (x 0) (x 1) (x 2) (x 3) * W (x 0) (x 1) (x 4) (x 5) * W (x 2) (x 3) (x 4) (x 5))
    simp [Equiv.swap_apply_def] at hα
    have e : 2 * S = S + -(∑ x : Fin 6 → ι, W (x 0) (x 2) (x 1) (x 3) * W (x 0) (x 5) (x 2) (x 4) * W (x 1) (x 3) (x 4) (x 5)) := by
      rw [← hS2]; ring
    rw [e, hS, ← sub_eq_add_neg, ← Finset.sum_sub_distrib]
    unfold alphaC; rw [hα]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [← bianchi_diff hW (x 0) (x 4) (x 2) (x 5)]; ring
  linarith

/-- One permutation's term of the Lovelock contraction `δ^{a₁⋯a₆}_{b₁⋯b₆} W_{a₁a₂}^{b₁b₂} W_{a₃a₄}^{b₃b₄} W_{a₅a₆}^{b₅b₆}`,
with `b = x ∘ σ`. -/
def LLterm (W : ι → ι → ι → ι → ℝ) (σ : Equiv.Perm (Fin 6)) (x : Fin 6 → ι) : ℝ :=
  W (x 0) (x 1) (x (σ 0)) (x (σ 1)) * W (x 2) (x 3) (x (σ 2)) (x (σ 3)) * W (x 4) (x 5) (x (σ 4)) (x (σ 5))

/-- **The Lovelock contraction**, the generalised Kronecker delta on six indices against three copies of `W`. -/
noncomputable def LL (W : ι → ι → ι → ι → ℝ) : ℝ :=
  ∑ σ : Equiv.Perm (Fin 6), (Equiv.Perm.sign σ : ℝ) * ∑ x : Fin 6 → ι, LLterm W σ x

/-- **LOVELOCK'S IDENTITY BELOW DIMENSION SIX**: with at most five index values the contraction vanishes, every
`x : Fin 6 → ι` repeating a value, so the permutations pair off with opposite signs. -/
theorem LL_zero (W : ι → ι → ι → ι → ℝ) (hcard : Fintype.card ι ≤ 5) : LL W = 0 := by
  unfold LL
  simp only [Finset.mul_sum]
  rw [Finset.sum_comm]
  refine Finset.sum_eq_zero fun x _ => ?_
  have hni : ¬Function.Injective x := by
    intro hinj
    have := Fintype.card_le_of_injective x hinj
    simp at this; omega
  obtain ⟨i, j, hxij, hij⟩ : ∃ i j, x i = x j ∧ i ≠ j := by
    by_contra h
    push Not at h
    exact hni fun a b hab => h a b hab
  set τ := Equiv.swap i j
  have hxτ : ∀ k, x (τ k) = x k := by
    intro k
    by_cases hk : k = i
    · subst hk; simp [τ, Equiv.swap_apply_left, hxij]
    · by_cases hk' : k = j
      · subst hk'; simp [τ, Equiv.swap_apply_right, hxij]
      · simp [τ, Equiv.swap_apply_of_ne_of_ne hk hk']
  have hf : ∀ σ : Equiv.Perm (Fin 6), LLterm W (τ * σ) x = LLterm W σ x := by
    intro σ; unfold LLterm; simp only [Equiv.Perm.mul_apply, hxτ]
  have hre := Equiv.sum_comp (Equiv.mulLeft τ) (fun σ => (Equiv.Perm.sign σ : ℝ) * LLterm W σ x)
  have hsign : Equiv.Perm.sign τ = -1 := Equiv.Perm.sign_swap hij
  have hpt : ∀ σ : Equiv.Perm (Fin 6), (Equiv.Perm.sign (τ * σ) : ℝ) * LLterm W (τ * σ) x
      = -((Equiv.Perm.sign σ : ℝ) * LLterm W σ x) := by
    intro σ
    rw [hf, Equiv.Perm.sign_mul, hsign]; push_cast; ring
  simp only [Equiv.coe_mulLeft] at hre
  rw [Finset.sum_congr rfl fun σ _ => hpt σ, Finset.sum_neg_distrib] at hre
  linarith

/-- **The collapse from the display**: if the contraction is `16α − 64γ` (the six-index expansion, with every
self-contracted term vanishing by Ricci-flatness), then below dimension six `β = α/2`, which is L50's
`⟨W#, W⟩ = 2 tr(W³)`. -/
theorem collapse_of_display {W : ι → ι → ι → ι → ℝ} (hW : WeylC W) (hcard : Fintype.card ι ≤ 5)
    (hdisp : LL W = 16 * alphaC W - 64 * gammaC W) : betaC W = alphaC W / 2 := by
  have h0 := LL_zero W hcard
  have hg := gamma_eq hW
  have hT := T_eq hW
  linarith

end HamiltonsCubic.L50Lovelock
