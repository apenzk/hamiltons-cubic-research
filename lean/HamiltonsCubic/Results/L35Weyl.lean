import HamiltonsCubic.Results.L35Pack
import HamiltonsCubic.Results.L70Dims

set_option linter.style.longLine false

/-!
# L35 on the operator: at most two negative eigenvalues cap `θ` at `√(3/2)`

[findings/stratum-two-negative.md](../../../findings/stratum-two-negative.md), Lemma L35, from the eigenframe to the
bound, with no numerical step:

- `BracketT`: the properties the chain uses of `T_{abc} = ⟨[v_a, v_b], v_c⟩²`, nonnegative, totally symmetric, zero
  on repeated indices and pair-capped by `2` ([L31](../../../findings/stratum-two-negative.md), `brnorm_le_two`);
- `dual_set`: weak duality for the `(+++)` block over the positive index set, at any dual weight dominating every
  distinct triple's harmonic mean;
- `negatives`: at most two negatives become `−b₀, −c₀` and a column carrying the whole `(+−−)` block under its cap;
- **`L35_general`**: for such a `T` and a spectrum with `∑λ = 0`, `∑λ² = 1` and at most two negatives,
  `∑λ³ + ½∑_{ordered}λλλT ≤ √(3/2)`, the triple sum split into its eight sign blocks, `(++−)` nonpositive,
  `(−−−)` empty by pigeonhole, then [L35Pack.lean](L35Pack.lean)'s bounds and [L35Mono.lean](L35Mono.lean)'s `R3_le`;
- `frame_trace` (`∑λ = 0` from Ricci-flatness), `P_frame` (`P = ∑λ³ + ½∑λλλc²`), `bracketT_cst`, and
  **`L35_weyl`**: a unit Weyl `W` with an orthonormal eigenframe carrying at most two negative eigenvalues has
  `P(W) ≤ √(3/2)`.
-/

namespace HamiltonsCubic.L35Residual

open Finset HamiltonsCubic.L42Statement

variable {Γ : Type*} [Fintype Γ] [DecidableEq Γ]

set_option linter.unusedSectionVars false

/-- The hypotheses on the bracket tensor `T = c²`. -/
structure BracketT (T : Γ → Γ → Γ → ℝ) : Prop where
  nonneg : ∀ a b c, 0 ≤ T a b c
  s12 : ∀ a b c, T a b c = T b a c
  s23 : ∀ a b c, T a b c = T a c b
  rep : ∀ a c, T a a c = 0
  cap : ∀ a b, (∑ c, T a b c) ≤ 2

theorem BracketT.rep13 {T : Γ → Γ → Γ → ℝ} (hT : BracketT T) (a b : Γ) : T a b a = 0 := by
  rw [hT.s23, hT.rep]
theorem BracketT.rep23 {T : Γ → Γ → Γ → ℝ} (hT : BracketT T) (a b : Γ) : T b a a = 0 := by
  rw [hT.s12, hT.s23, hT.rep]

/-- **Weak duality over a positive index set** `P`: `∑_{P³} T λλλ ≤ 2μ ∑_{α ≠ β ∈ P} λ_αλ_β`. -/
theorem dual_set (T : Γ → Γ → Γ → ℝ) (hT : BracketT T) (lam : Γ → ℝ) (P : Finset Γ)
    (hP : ∀ a ∈ P, 0 < lam a) (μ : ℝ) (hμ0 : 0 ≤ μ)
    (hμ : ∀ α ∈ P, ∀ β ∈ P, ∀ γ ∈ P, α ≠ β → α ≠ γ → β ≠ γ → harmonicMean (lam α) (lam β) (lam γ) ≤ μ) :
    ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam α * lam β * lam γ * T α β γ
      ≤ 2 * μ * ((∑ a ∈ P, lam a) ^ 2 - ∑ a ∈ P, lam a ^ 2) := by
  -- per-term: 3λαλβλγ T ≤ μ(λαλβ + λβλγ + λαλγ) T
  have hterm : ∀ α ∈ P, ∀ β ∈ P, ∀ γ ∈ P, 3 * (lam α * lam β * lam γ * T α β γ)
      ≤ μ * (lam α * lam β * T α β γ + lam β * lam γ * T α β γ + lam α * lam γ * T α β γ) := by
    intro α hα β hβ γ hγ
    by_cases h1 : α = β
    · subst h1; rw [hT.rep]; simp
    by_cases h2 : α = γ
    · subst h2; rw [hT.rep13]; simp
    by_cases h3 : β = γ
    · subst h3; rw [hT.rep23]; simp
    have hc := triple_constraint (lam α) (lam β) (lam γ) (μ / 3) (hP α hα) (hP β hβ) (hP γ hγ)
      (by have := hμ α hα β hβ γ hγ h1 h2 h3; linarith)
    have hm := mul_le_mul_of_nonneg_right hc (hT.nonneg α β γ)
    nlinarith [hT.nonneg α β γ]
  have hsum := Finset.sum_le_sum fun α hα => Finset.sum_le_sum fun β hβ => Finset.sum_le_sum fun γ hγ =>
    hterm α hα β hβ γ hγ
  -- the three pair sums are equal by symmetry
  have e1 : ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam β * lam γ * T α β γ
      = ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam α * lam β * T α β γ := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun β _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun γ _ => Finset.sum_congr rfl fun α _ => ?_
    rw [hT.s12, hT.s23]
  have e2 : ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam α * lam γ * T α β γ
      = ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam α * lam β * T α β γ := by
    refine Finset.sum_congr rfl fun α _ => ?_
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun γ _ => Finset.sum_congr rfl fun β _ => by rw [hT.s23]
  -- the pair cap
  have hcap : ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam α * lam β * T α β γ
      ≤ 2 * ((∑ a ∈ P, lam a) ^ 2 - ∑ a ∈ P, lam a ^ 2) := by
    have hoff : (∑ a ∈ P, lam a) ^ 2 - ∑ a ∈ P, lam a ^ 2
        = ∑ α ∈ P, ∑ β ∈ P, if α = β then 0 else lam α * lam β := by
      rw [sq, Finset.sum_mul_sum]
      have : ∀ α ∈ P, ∑ β ∈ P, lam α * lam β = (∑ β ∈ P, if α = β then 0 else lam α * lam β) + lam α ^ 2 := by
        intro α hα
        rw [← Finset.add_sum_erase _ _ hα, ← Finset.add_sum_erase _ _ hα]
        rw [Finset.sum_congr rfl fun β hβ => if_neg (Ne.symm (Finset.ne_of_mem_erase hβ))]
        simp only [if_true]
        ring
      rw [Finset.sum_congr rfl this, Finset.sum_add_distrib]; ring
    rw [hoff, Finset.mul_sum]
    refine Finset.sum_le_sum fun α hα => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun β hβ => ?_
    by_cases hab : α = β
    · subst hab; simp [hT.rep]
    · rw [if_neg hab, ← Finset.mul_sum]
      have hpos : 0 ≤ lam α * lam β := (mul_pos (hP α hα) (hP β hβ)).le
      have hle : ∑ γ ∈ P, T α β γ ≤ 2 :=
        le_trans (Finset.sum_le_sum_of_subset_of_nonneg (subset_univ P) fun c _ _ => hT.nonneg α β c) (hT.cap α β)
      nlinarith
  have hsplit : ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, μ * (lam α * lam β * T α β γ + lam β * lam γ * T α β γ + lam α * lam γ * T α β γ)
      = 3 * μ * ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam α * lam β * T α β γ := by
    have e : ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, μ * (lam α * lam β * T α β γ + lam β * lam γ * T α β γ + lam α * lam γ * T α β γ)
        = μ * (∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam α * lam β * T α β γ)
          + μ * (∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam β * lam γ * T α β γ)
          + μ * (∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam α * lam γ * T α β γ) := by
      simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => Finset.sum_congr rfl fun γ _ => by ring
    rw [e, e1, e2]; ring
  have h3 : ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, 3 * (lam α * lam β * lam γ * T α β γ)
      = 3 * ∑ α ∈ P, ∑ β ∈ P, ∑ γ ∈ P, lam α * lam β * lam γ * T α β γ := by simp only [Finset.mul_sum]
  rw [h3, hsplit] at hsum
  nlinarith [mul_le_mul_of_nonneg_left hcap hμ0]

/-! ## Squares and cubes over a positive set -/

theorem pair_sq_leP (lam : Γ → ℝ) (P : Finset Γ) (i0 j l : Γ) (hi0 : i0 ∈ P) (hj : j ∈ P) (hl : l ∈ P)
    (hj0 : j ≠ i0) (hl0 : l ≠ i0) (hjl : j ≠ l) :
    lam j ^ 2 + lam l ^ 2 ≤ ∑ a ∈ P, lam a ^ 2 - lam i0 ^ 2 := by
  rw [← Finset.add_sum_erase _ _ hi0]
  have hsub : ({j, l} : Finset Γ) ⊆ P.erase i0 := by
    intro x hx
    simp only [mem_insert, mem_singleton] at hx
    rcases hx with rfl | rfl
    · exact mem_erase.mpr ⟨hj0, hj⟩
    · exact mem_erase.mpr ⟨hl0, hl⟩
  have := Finset.sum_le_sum_of_subset_of_nonneg hsub (fun i _ _ => sq_nonneg (lam i))
  rw [Finset.sum_pair hjl] at this
  linarith

theorem cube_sum_leP (lam : Γ → ℝ) (P : Finset Γ) (hP : ∀ a ∈ P, 0 < lam a) (i0 : Γ) (hi0 : i0 ∈ P)
    (htop : ∀ a ∈ P, lam a ≤ lam i0) :
    ∑ a ∈ P, lam a ^ 3 ≤ lam i0 ^ 3 + min (lam i0) (Real.sqrt (∑ a ∈ P, lam a ^ 2 - lam i0 ^ 2))
      * (∑ a ∈ P, lam a ^ 2 - lam i0 ^ 2) := by
  set d := ∑ a ∈ P, lam a ^ 2 - lam i0 ^ 2
  have hd : ∑ a ∈ P.erase i0, lam a ^ 2 = d := by
    have := Finset.add_sum_erase P (fun a => lam a ^ 2) hi0
    simp only [d]; linarith
  rw [← Finset.add_sum_erase _ _ hi0]
  have hterm : ∀ i ∈ P.erase i0, lam i ^ 3 ≤ min (lam i0) (Real.sqrt d) * lam i ^ 2 := by
    intro i hi
    have hiP : i ∈ P := (mem_erase.mp hi).2
    have h1 : lam i ≤ Real.sqrt d := by
      rw [← Real.sqrt_sq (hP i hiP).le]
      refine Real.sqrt_le_sqrt ?_
      rw [← hd]; exact Finset.single_le_sum (fun j _ => sq_nonneg (lam j)) hi
    have hm : lam i ≤ min (lam i0) (Real.sqrt d) := le_min (htop i hiP) h1
    have : lam i ^ 3 = lam i * lam i ^ 2 := by ring
    rw [this]; exact mul_le_mul_of_nonneg_right hm (sq_nonneg _)
  have := Finset.sum_le_sum hterm
  rw [← Finset.mul_sum, hd] at this
  linarith

/-- **The negatives, at most two of them**, as `−b₀, −c₀` with a column `T'` carrying the `NN` block. -/
theorem negatives (T : Γ → Γ → Γ → ℝ) (hT : BracketT T) (lam : Γ → ℝ) (N P : Finset Γ)
    (hN : ∀ a ∈ N, lam a < 0) (hcard : N.card ≤ 2) (hPN : Disjoint P N) :
    ∃ b0 c0 : ℝ, ∃ τ : Γ → ℝ, 0 ≤ b0 ∧ 0 ≤ c0 ∧ (∀ a, 0 ≤ τ a) ∧ (∑ a ∈ P, τ a ≤ 2) ∧
      ∑ a ∈ N, lam a = -(b0 + c0) ∧ ∑ a ∈ N, lam a ^ 2 = b0 ^ 2 + c0 ^ 2 ∧
      ∑ a ∈ N, lam a ^ 3 = -b0 ^ 3 - c0 ^ 3 ∧
      ∀ a, ∑ b ∈ N, ∑ c ∈ N, lam b * lam c * T a b c = 2 * (b0 * c0) * τ a := by
  rcases Nat.lt_or_ge N.card 2 with h | h
  · rcases Nat.lt_or_ge N.card 1 with h0 | h0
    · have : N = ∅ := Finset.card_eq_zero.mp (show N.card = 0 by omega)
      subst this
      exact ⟨0, 0, fun _ => 0, le_refl _, le_refl _, fun _ => le_refl _, by simp, by simp, by simp, by simp,
        fun a => by simp⟩
    · obtain ⟨n, rfl⟩ := Finset.card_eq_one.mp (show N.card = 1 by omega)
      have hn := hN n (mem_singleton_self n)
      refine ⟨-lam n, 0, fun _ => 0, by linarith, le_refl _, fun _ => le_refl _, by simp, by simp, by simp,
        by simp; ring, fun a => ?_⟩
      simp [hT.rep23]
  · obtain ⟨n1, n2, hne, rfl⟩ := Finset.card_eq_two.mp (show N.card = 2 by omega)
    have h1 := hN n1 (by simp)
    have h2 := hN n2 (by simp)
    refine ⟨-lam n1, -lam n2, fun a => T a n1 n2, by linarith, by linarith, fun a => hT.nonneg _ _ _, ?_, ?_, ?_, ?_, ?_⟩
    · have hsub : ∑ a ∈ P, T a n1 n2 ≤ ∑ a, T a n1 n2 :=
        Finset.sum_le_sum_of_subset_of_nonneg (subset_univ P) fun c _ _ => hT.nonneg _ _ _
      have hcap := hT.cap n1 n2
      have hre : ∑ a, T a n1 n2 = ∑ c, T n1 n2 c := Finset.sum_congr rfl fun c _ => by rw [hT.s12, hT.s23, hT.s12]
      linarith
    · rw [Finset.sum_pair hne]; ring
    · rw [Finset.sum_pair hne]; ring
    · rw [Finset.sum_pair hne]; ring
    · intro a
      rw [Finset.sum_pair hne, Finset.sum_pair hne, Finset.sum_pair hne]
      rw [hT.rep23 n1 a, hT.rep23 n2 a, show T a n2 n1 = T a n1 n2 from (hT.s23 a n1 n2).symm]
      ring

set_option maxHeartbeats 1000000 in
/-- **L35 FOR A BRACKET TENSOR**: a spectrum with at most two negative entries, `∑λ = 0`, `∑λ² = 1`, and a
tensor `T` that is nonnegative, totally symmetric, zero on repeated indices and pair-capped by `2`, give
`∑λ³ + ½∑_{ordered} λ_aλ_bλ_c T_{abc} ≤ √(3/2)`. -/
theorem L35_general (T : Γ → Γ → Γ → ℝ) (hT : BracketT T) (lam : Γ → ℝ)
    (hneg : (univ.filter fun a => lam a < 0).card ≤ 2) (hsum : ∑ a, lam a = 0) (hn : ∑ a, lam a ^ 2 = 1) :
    ∑ a, lam a ^ 3 + (1 / 2) * ∑ a, ∑ b, ∑ c, lam a * lam b * lam c * T a b c ≤ Real.sqrt (3 / 2) := by
  set P := univ.filter fun a => 0 < lam a with hPdef
  set N := univ.filter fun a => lam a < 0 with hNdef
  have hPpos : ∀ a ∈ P, 0 < lam a := fun a ha => (mem_filter.mp ha).2
  have hNneg : ∀ a ∈ N, lam a < 0 := fun a ha => (mem_filter.mp ha).2
  have hPN : Disjoint P N := by
    rw [Finset.disjoint_left]
    intro a ha hb
    have := hPpos a ha; have := hNneg a hb; linarith
  have hsplit : ∀ g : Γ → ℝ, (∀ a, lam a = 0 → g a = 0) → ∑ a, g a = ∑ a ∈ P, g a + ∑ a ∈ N, g a := by
    intro g hg
    rw [← Finset.sum_union hPN]
    symm
    apply Finset.sum_subset (subset_univ _)
    intro a _ ha
    apply hg
    by_contra h
    apply ha
    rcases lt_or_gt_of_ne h with h' | h'
    · exact mem_union_right _ (mem_filter.mpr ⟨mem_univ _, h'⟩)
    · exact mem_union_left _ (mem_filter.mpr ⟨mem_univ _, h'⟩)
  -- the triple sum by sign blocks
  have h1 : ∀ a b, ∑ c, lam a * lam b * lam c * T a b c
      = ∑ c ∈ P, lam a * lam b * lam c * T a b c + ∑ c ∈ N, lam a * lam b * lam c * T a b c :=
    fun a b => hsplit _ fun c hc => by simp [hc]
  have h2 : ∀ a, ∑ b, (∑ c ∈ P, lam a * lam b * lam c * T a b c + ∑ c ∈ N, lam a * lam b * lam c * T a b c)
      = ∑ b ∈ P, (∑ c ∈ P, lam a * lam b * lam c * T a b c + ∑ c ∈ N, lam a * lam b * lam c * T a b c)
        + ∑ b ∈ N, (∑ c ∈ P, lam a * lam b * lam c * T a b c + ∑ c ∈ N, lam a * lam b * lam c * T a b c) :=
    fun a => hsplit _ fun b hb => by simp [hb]
  have h3 := hsplit (fun a => ∑ b ∈ P, (∑ c ∈ P, lam a * lam b * lam c * T a b c + ∑ c ∈ N, lam a * lam b * lam c * T a b c)
        + ∑ b ∈ N, (∑ c ∈ P, lam a * lam b * lam c * T a b c + ∑ c ∈ N, lam a * lam b * lam c * T a b c))
    (fun a ha => by simp [ha])
  have htot : ∑ a, ∑ b, ∑ c, lam a * lam b * lam c * T a b c
      = (∑ a ∈ P, ∑ b ∈ P, ∑ c ∈ P, lam a * lam b * lam c * T a b c)
        + (∑ a ∈ P, ∑ b ∈ P, ∑ c ∈ N, lam a * lam b * lam c * T a b c)
        + (∑ a ∈ P, ∑ b ∈ N, ∑ c ∈ P, lam a * lam b * lam c * T a b c)
        + (∑ a ∈ P, ∑ b ∈ N, ∑ c ∈ N, lam a * lam b * lam c * T a b c)
        + (∑ a ∈ N, ∑ b ∈ P, ∑ c ∈ P, lam a * lam b * lam c * T a b c)
        + (∑ a ∈ N, ∑ b ∈ P, ∑ c ∈ N, lam a * lam b * lam c * T a b c)
        + (∑ a ∈ N, ∑ b ∈ N, ∑ c ∈ P, lam a * lam b * lam c * T a b c)
        + (∑ a ∈ N, ∑ b ∈ N, ∑ c ∈ N, lam a * lam b * lam c * T a b c) := by
    simp only [h1, h2]
    rw [h3]
    simp only [Finset.sum_add_distrib]
    ring
  -- the three (++−) blocks are nonpositive
  have hnp : ∀ a b c, 0 < lam a → 0 < lam b → lam c < 0 → lam a * lam b * lam c * T a b c ≤ 0 :=
    fun a b c ha hb hc => mul_nonpos_of_nonpos_of_nonneg
      (mul_nonpos_of_nonneg_of_nonpos (mul_pos ha hb).le hc.le) (hT.nonneg a b c)
  have hPPN : ∑ a ∈ P, ∑ b ∈ P, ∑ c ∈ N, lam a * lam b * lam c * T a b c ≤ 0 :=
    Finset.sum_nonpos fun a ha => Finset.sum_nonpos fun b hb => Finset.sum_nonpos fun c hc =>
      hnp a b c (hPpos a ha) (hPpos b hb) (hNneg c hc)
  have hPNP : ∑ a ∈ P, ∑ b ∈ N, ∑ c ∈ P, lam a * lam b * lam c * T a b c ≤ 0 :=
    Finset.sum_nonpos fun a ha => Finset.sum_nonpos fun b hb => Finset.sum_nonpos fun c hc => by
      have := hnp a c b (hPpos a ha) (hPpos c hc) (hNneg b hb)
      rw [hT.s23] at this; linarith
  have hNPP : ∑ a ∈ N, ∑ b ∈ P, ∑ c ∈ P, lam a * lam b * lam c * T a b c ≤ 0 :=
    Finset.sum_nonpos fun a ha => Finset.sum_nonpos fun b hb => Finset.sum_nonpos fun c hc => by
      have := hnp b c a (hPpos b hb) (hPpos c hc) (hNneg a ha)
      rw [show T b c a = T a b c by rw [hT.s12 b c a, hT.s23 c b a, hT.s12 c a b, hT.s23 a c b]] at this; linarith
  -- (−−−) vanishes
  have hNNN : ∑ a ∈ N, ∑ b ∈ N, ∑ c ∈ N, lam a * lam b * lam c * T a b c = 0 := by
    refine Finset.sum_eq_zero fun a ha => Finset.sum_eq_zero fun b hb => Finset.sum_eq_zero fun c hc => ?_
    by_cases hab : a = b
    · subst hab; rw [hT.rep]; ring
    by_cases hac : a = c
    · subst hac; rw [hT.rep13]; ring
    by_cases hbc : b = c
    · subst hbc; rw [hT.rep23]; ring
    exfalso
    have hsub : ({a, b, c} : Finset Γ) ⊆ N := by
      intro x hx; simp only [mem_insert, mem_singleton] at hx; rcases hx with rfl | rfl | rfl <;> assumption
    have h3c : ({a, b, c} : Finset Γ).card = 3 := by
      rw [Finset.card_insert_of_notMem (by simp [hab, hac]), Finset.card_pair hbc]
    have := Finset.card_le_card hsub
    omega
  -- the three (+−−) blocks agree
  have hNNP : ∑ a ∈ N, ∑ b ∈ N, ∑ c ∈ P, lam a * lam b * lam c * T a b c
      = ∑ a ∈ P, ∑ b ∈ N, ∑ c ∈ N, lam a * lam b * lam c * T a b c := by
    rw [Finset.sum_comm, Finset.sum_congr rfl fun a _ => Finset.sum_comm]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [hT.s12 b a c, hT.s12 c a b, hT.s23 a c b]; ring
  have hNPN : ∑ a ∈ N, ∑ b ∈ P, ∑ c ∈ N, lam a * lam b * lam c * T a b c
      = ∑ a ∈ P, ∑ b ∈ N, ∑ c ∈ N, lam a * lam b * lam c * T a b c := by
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun c _ => ?_
    rw [hT.s12]; ring
  -- the negatives
  obtain ⟨b0, c0, τ, hb0, hc0, hτ0, hτ, hN1, hN2, hN3, hNN⟩ := negatives T hT lam N P hNneg hneg hPN
  have hPNN : ∑ a ∈ P, ∑ b ∈ N, ∑ c ∈ N, lam a * lam b * lam c * T a b c = 2 * (b0 * c0) * ∑ a ∈ P, lam a * τ a := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    have := hNN a
    have e : ∑ b ∈ N, ∑ c ∈ N, lam a * lam b * lam c * T a b c = lam a * ∑ b ∈ N, ∑ c ∈ N, lam b * lam c * T a b c := by
      simp only [Finset.mul_sum]; exact Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ => by ring
    rw [e, this]; ring
  -- the moments
  have hs1 := hsplit (fun a => lam a) (fun a h => h)
  have hs2 := hsplit (fun a => lam a ^ 2) (fun a h => by simp [h])
  have hs3 := hsplit (fun a => lam a ^ 3) (fun a h => by simp [h])
  rw [hsum, hN1] at hs1
  rw [hn, hN2] at hs2
  rw [hN3] at hs3
  -- P is nonempty
  have hPne : P.Nonempty := by
    rw [Finset.nonempty_iff_ne_empty]
    intro hP
    rw [hP, Finset.sum_empty] at hs1 hs2
    nlinarith
  obtain ⟨i0, hi0, htop⟩ := Finset.exists_max_image P lam hPne
  set A := lam i0 with hAdef
  have hA : 0 < A := hPpos i0 hi0
  set d := ∑ a ∈ P, lam a ^ 2 - A ^ 2 with hddef
  have hd : 0 ≤ d := by
    have := Finset.single_le_sum (fun a _ => sq_nonneg (lam a)) hi0 (f := fun a => lam a ^ 2); linarith
  have hK0 : 0 ≤ 3 / (2 * Real.sqrt 2) := by positivity
  have hμ : ∀ α ∈ P, ∀ β ∈ P, ∀ γ ∈ P, α ≠ β → α ≠ γ → β ≠ γ →
      harmonicMean (lam α) (lam β) (lam γ) ≤ min A (3 / (2 * Real.sqrt 2) * Real.sqrt d) := by
    intro α hα β hβ γ hγ h1 h2 h3
    refine le_min (hm_le_of_le _ _ _ _ (hPpos α hα) (hPpos β hβ) (hPpos γ hγ) (htop α hα) (htop β hβ) (htop γ hγ)) ?_
    have key : ∀ x ∈ P, ∀ y ∈ P, ∀ z ∈ P, y ≠ i0 → z ≠ i0 → y ≠ z →
        harmonicMean (lam x) (lam y) (lam z) ≤ 3 / (2 * Real.sqrt 2) * Real.sqrt d :=
      fun x hx y hy z hz hy0 hz0 hyz =>
        le_trans (hm_le_K0 _ _ _ (hPpos x hx) (hPpos y hy) (hPpos z hz))
          (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (pair_sq_leP lam P i0 y z hi0 hy hz hy0 hz0 hyz)) hK0)
    by_cases ha : α = i0
    · exact key α hα β hβ γ hγ (fun h => h1 (ha.trans h.symm)) (fun h => h2 (ha.trans h.symm)) h3
    · by_cases hb' : β = i0
      · rw [hm_perm12]; exact key β hβ α hα γ hγ ha (fun h => h3 (hb'.trans h.symm)) h2
      · by_cases hg : γ = i0
        · rw [hm_perm13]; exact key γ hγ β hβ α hα hb' ha (Ne.symm h1)
        · exact key α hα β hβ γ hγ hb' hg h3
  have hdual := dual_set T hT lam P hPpos _ (le_min hA.le (by positivity)) hμ
  have hcube := cube_sum_leP lam P hPpos i0 hi0 htop
  have hτA : ∑ a ∈ P, lam a * τ a ≤ 2 * A := by
    have : ∑ a ∈ P, lam a * τ a ≤ ∑ a ∈ P, A * τ a :=
      Finset.sum_le_sum fun a ha => mul_le_mul_of_nonneg_right (htop a ha) (hτ0 a)
    rw [← Finset.mul_sum] at this; nlinarith
  have hbc0 : 0 ≤ b0 * c0 := mul_nonneg hb0 hc0
  have hu : ∑ a ∈ P, lam a ^ 2 = A ^ 2 + d := by rw [hddef]; ring
  have hsP : ∑ a ∈ P, lam a = b0 + c0 := by linarith
  have hsq : (b0 + c0) ^ 2 = b0 ^ 2 + 2 * (b0 * c0) + c0 ^ 2 := by ring
  have hdf : 0 ≤ b0 ^ 2 - 2 * (b0 * c0) + c0 ^ 2 := by nlinarith [sq_nonneg (b0 - c0)]
  rw [hu] at hs2
  have hbc : b0 * c0 = ((b0 + c0) ^ 2 - 1 + (A ^ 2 + d)) / 2 := by linarith
  have hR := R3_le A (b0 + c0) d hA hd (by linarith) (by linarith) (by linarith)
  unfold R3 at hR
  rw [hsP, hu] at hdual
  have hcube' : ∑ a ∈ P, lam a ^ 3 ≤ A ^ 3 + min A (Real.sqrt d) * d := hcube
  rw [← hbc] at hR
  have hcubes : -b0 ^ 3 - c0 ^ 3 + 6 * A * (b0 * c0) = -(b0 + c0) ^ 3 + 3 * (b0 * c0) * (b0 + c0 + 2 * A) := by ring
  have hx : 2 * (b0 * c0) * ∑ a ∈ P, lam a * τ a ≤ 4 * A * (b0 * c0) := by nlinarith
  rw [htot, hs3, hNNP, hNPN, hNNN, hPNN]
  nlinarith [hcube', hdual, hPPN, hPNP, hNPP, hx, hcubes, hR, hbc0]

end HamiltonsCubic.L35Residual


namespace HamiltonsCubic.L35Residual

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.L41Statement HamiltonsCubic.L41Statement.Frame

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {Γ : Type*} [Fintype Γ] [DecidableEq Γ]
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}

theorem frame_trace (hW : IsWeyl W) (hf : EigenFrame W v lam) : ∑ γ, lam γ = 0 := by
  have h := innerOp_frame hf W (fun X => X) (fun c => weyl_lin hW _ c v hf.skew) (fun c => rfl)
  have e : ∑ γ, inner2 (W (v γ)) (v γ) = ∑ γ, lam γ := by
    refine Finset.sum_congr rfl fun γ _ => ?_
    rw [hf.eigen γ, inner2_smul_l, hf.orthonormal, if_pos rfl, mul_one]
  have z : innerOp W (fun X => X) = 0 := by
    unfold innerOp
    have : ∑ i, ∑ j, inner2 (W (phi i j)) (phi i j) = ∑ i, Ric W i i := rfl
    rw [this]; simp [hW.2.2.2]

  linarith

theorem P_frame (hW : IsWeyl W) (hf : EigenFrame W v lam) :
    Pcubic W = ∑ γ, lam γ ^ 3 + (1 / 2) * ∑ γ, ∑ α, ∑ β, lam γ * lam α * lam β * cst v γ α β ^ 2 := by
  unfold Pcubic
  rw [trCube_frame hW hf, sharpPair_T hW hf]

theorem bracketT_cst (hf : EigenFrame W v lam) : BracketT (fun a b c => cst v a b c ^ 2) where
  nonneg a b c := sq_nonneg _
  s12 a b c := T12 hf a b c
  s23 a b c := T23 hf a b c
  rep a c := by
    have : br (v a) (v a) = 0 := by unfold br; simp
    simp [cst, this, inner2]
  cap a b := brnorm_le_two hf a b

/-- **L35 ON THE OPERATOR**: a Weyl `W` of unit norm with an orthonormal eigenframe carrying at most two negative
eigenvalues has `P(W) ≤ √(3/2)`. -/
theorem L35_weyl (hW : IsWeyl W) (hf : EigenFrame W v lam) (hn : normSq W = 1)
    (hneg : (univ.filter fun a => lam a < 0).card ≤ 2) : Pcubic W ≤ Real.sqrt (3 / 2) := by
  rw [P_frame hW hf]
  have h2 : ∑ γ, lam γ ^ 2 = 1 := by rw [← normSq_frame hW hf, hn]
  exact L35_general (fun a b c => cst v a b c ^ 2) (bracketT_cst hf) lam hneg (frame_trace hW hf) h2

end HamiltonsCubic.L35Residual
