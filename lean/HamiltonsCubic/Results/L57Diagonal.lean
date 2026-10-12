import HamiltonsCubic.Results.L57Critical
import HamiltonsCubic.Results.L130Statement

set_option linter.style.longLine false

/-!
# L57 at every diagonal Weyl operator

[L57Critical.lean](L57Critical.lean) proves `P(diag S) ≤ √(2(n−1)(n−2))/n` at every unit weight
satisfying the criticality equation. **This file carries it to every diagonal `W`**, the statement's
own quantifier ([findings/problem.md](../../../findings/problem.md), *So the all-n diagonal theorem is
COMPLETE*, and [diagonal-half.md](../../../findings/diagonal-half.md)'s compression of criticality):

- `multiplier_vanishes`: the Euler–Lagrange equation carries the Ricci multiplier,
  `s_ab² + (S²)_ab = λ s_ab + u_a + u_b` off the diagonal, and **`u = 0`**, summing over `b ≠ a`;
- `perp_weights`: a symmetric `G` orthogonal to every weight is `u_a + u_b` off the diagonal;
- `exists_max_weight`: a unit weight maximising `diagP` exists (a compact set in `Matrix`);
- `first_order`: at it, `∑ (s_ab² + (S²)_ab) y_ab = 0` for every weight `y ⊥ S`;
- `L57_diagonal`: **`P(diag w) ≤ √(2(n−1)(n−2))/n · ‖diag w‖³` for every weight `w` at every
  `n ≥ 4`**, which is `Θₙ ‖W‖³` at even `n`.
-/

namespace HamiltonsCubic.L57Critical

open Finset Matrix HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The Ricci multiplier vanishes.** -/
theorem multiplier_vanishes {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 3 ≤ Fintype.card ι)
    (lam : ℝ) (u : ι → ℝ)
    (hEL : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b + u a + u b) : ∀ a, u a = 0 := by
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  have hn3 : (3 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hrow : ∀ a, ∑ b, S a b = 0 := hS.rowSum
  -- `(S²) 𝟙 = 0`
  have hSS : ∀ a, ∑ b, (S * S) a b = 0 := by
    intro a
    simp only [Matrix.mul_apply]
    rw [Finset.sum_comm]
    exact Finset.sum_eq_zero fun c _ => by rw [← Finset.mul_sum, hrow c, mul_zero]
  have hdiag : ∀ a, (S * S) a a = ∑ c, S a c ^ 2 := fun a => by
    simp only [Matrix.mul_apply, sq, hS.symm _ a]
  -- sum the equation over `b ≠ a`, written over all `b` with the diagonal term added back
  have key : ∀ a, (n - 2) * u a + ∑ b, u b = 0 := by
    intro a
    have hall : ∀ b, S a b ^ 2 + (S * S) a b
        = (if b = a then S a a ^ 2 + (S * S) a a - (lam * S a a + u a + u a) else 0)
          + (lam * S a b + u a + u b) := by
      intro b
      by_cases h : b = a
      · subst h; simp
      · rw [if_neg h, zero_add, hEL a b (Ne.symm h)]
    have hs : ∑ b, (S a b ^ 2 + (S * S) a b)
        = (S a a ^ 2 + (S * S) a a - (lam * S a a + u a + u a))
          + (lam * ∑ b, S a b + n * u a + ∑ b, u b) := by
      rw [Finset.sum_congr rfl fun b _ => hall b, Finset.sum_add_distrib, Finset.sum_ite_eq',
        if_pos (Finset.mem_univ a)]
      simp only [Finset.sum_add_distrib, ← Finset.mul_sum, Finset.sum_const, Finset.card_univ,
        nsmul_eq_mul, ← hndef]
    rw [Finset.sum_add_distrib, hSS a, hrow a, hS.hollow a, hdiag a] at hs
    linarith

  -- all `u a` agree, and their sum vanishes
  have hsum : ∑ b, u b = 0 := by
    have h := Finset.sum_congr rfl fun a (_ : a ∈ (Finset.univ : Finset ι)) => key a
    rw [Finset.sum_add_distrib, ← Finset.mul_sum, Finset.sum_const, Finset.card_univ,
      nsmul_eq_mul, ← hndef] at h
    simp only [Finset.sum_const_zero] at h
    have : (n - 2 + n) * ∑ b, u b = 0 := by linarith
    rcases mul_eq_zero.mp this with h0 | h0
    · linarith
    · exact h0
  intro a
  have := key a
  rw [hsum, add_zero] at this
  rcases mul_eq_zero.mp this with h0 | h0
  · linarith
  · exact h0

/-- **The complement of the weights**: a symmetric `G` pairing to zero with every weight is
`u_a + u_b` off the diagonal. -/
theorem perp_weights (hn : 3 ≤ Fintype.card ι) (G : Matrix ι ι ℝ) (hG : ∀ a b, G a b = G b a)
    (hperp : ∀ y : Matrix ι ι ℝ, IsWeight y → ∑ a, ∑ b, G a b * y a b = 0) :
    ∃ u : ι → ℝ, ∀ a b, a ≠ b → G a b = u a + u b := by
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  have hn3 : (3 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hn2 : n - 2 ≠ 0 := by linarith
  have hn1 : n - 1 ≠ 0 := by linarith
  set r : ι → ℝ := fun a => ∑ b, (if a = b then 0 else G a b) with hr
  set R : ℝ := ∑ a, r a with hR
  set u : ι → ℝ := fun a => (r a - R / (2 * (n - 1))) / (n - 2) with hu
  refine ⟨u, ?_⟩
  set G' : Matrix ι ι ℝ := fun a b => if a = b then 0 else G a b - u a - u b with hG'
  have hsumu : ∑ a, u a = R / (2 * (n - 1)) := by
    simp only [hu, ← Finset.sum_div, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ,
      nsmul_eq_mul, ← hndef, ← hR]
    field_simp; ring
  have hrowG' : ∀ a, ∑ b, G' a b = 0 := by
    intro a
    have e : ∀ b, G' a b = (if a = b then 0 else G a b) - (if a = b then 0 else u a + u b) := by
      intro b; simp only [hG']; split_ifs <;> ring
    simp only [e, Finset.sum_sub_distrib]
    have e2 : ∑ b, (if a = b then (0 : ℝ) else u a + u b) = (n - 2) * u a + ∑ b, u b := by
      have : ∀ b, (if a = b then (0 : ℝ) else u a + u b) = u a + u b - (if a = b then 2 * u a else 0) := by
        intro b; split_ifs with h
        · subst h; ring
        · ring
      simp only [this, Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ,
        nsmul_eq_mul, Finset.sum_ite_eq, Finset.mem_univ, if_true, ← hndef]
      ring
    rw [e2, hsumu]
    have : ∑ b, (if a = b then (0 : ℝ) else G a b) = r a := rfl
    rw [this]
    simp only [hu]
    field_simp; ring
  have hwG' : IsWeight G' := by
    refine ⟨fun a b => ?_, fun a => by simp [hG'], hrowG'⟩
    simp only [hG']
    by_cases h : a = b
    · subst h; rfl
    · rw [if_neg h, if_neg (Ne.symm h), hG a b]; ring
  have hGG' := hperp G' hwG'
  have huG' : ∑ a, ∑ b, (u a + u b) * G' a b = 0 := by
    simp only [add_mul, Finset.sum_add_distrib, ← Finset.mul_sum]
    have t1 : ∑ a, u a * ∑ b, G' a b = 0 := Finset.sum_eq_zero fun a _ => by rw [hrowG' a, mul_zero]
    have t2 : ∑ a, ∑ b, u b * G' a b = 0 := by
      rw [Finset.sum_comm]
      refine Finset.sum_eq_zero fun b _ => ?_
      rw [← Finset.mul_sum]
      have : ∑ a, G' a b = 0 := by simp only [hwG'.symm _ b]; exact hrowG' b
      rw [this, mul_zero]
    rw [t1, t2, add_zero]
  have hsq : ∑ a, ∑ b, G' a b ^ 2 = 0 := by
    have e : ∀ a b, G' a b ^ 2 = G a b * G' a b - (u a + u b) * G' a b := by
      intro a b; simp only [hG']; split_ifs <;> ring
    simp only [e, Finset.sum_sub_distrib, hGG', huG', sub_zero]
  have hz : ∀ a b, G' a b = 0 := by
    intro a b
    have hnn : ∀ a ∈ (Finset.univ : Finset ι), 0 ≤ ∑ b, G' a b ^ 2 :=
      fun a _ => Finset.sum_nonneg fun b _ => sq_nonneg _
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hsq a (Finset.mem_univ a)
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => sq_nonneg (G' a b)).mp h1 b
      (Finset.mem_univ b)
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h2
  intro a b hab
  have := hz a b
  simp only [hG', if_neg hab] at this
  linarith

/-- The squared Frobenius norm over ordered pairs. -/
def fro (T : Matrix ι ι ℝ) : ℝ := ∑ a, ∑ b, T a b ^ 2

theorem fro_nonneg (T : Matrix ι ι ℝ) : 0 ≤ fro T :=
  Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ => sq_nonneg _

theorem fro_smul (c : ℝ) (T : Matrix ι ι ℝ) : fro (c • T) = c ^ 2 * fro T := by
  unfold fro; simp only [Matrix.smul_apply, smul_eq_mul, mul_pow, ← Finset.mul_sum]

theorem diagP_smul (c : ℝ) (T : Matrix ι ι ℝ) : diagP (c • T) = c ^ 3 * diagP T := by
  unfold diagP
  simp only [Matrix.smul_apply, smul_eq_mul, mul_pow, ← Finset.mul_sum, Matrix.smul_mul,
    Matrix.mul_smul, Matrix.trace_smul, smul_smul]
  ring

/-- `tr(M Y) = ∑ M_ab Y_ab` for a symmetric `Y`. -/
theorem trace_mul_symm (M Y : Matrix ι ι ℝ) (hY : ∀ a b, Y a b = Y b a) :
    (M * Y).trace = ∑ a, ∑ b, M a b * Y a b := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by rw [hY b a]

/-- **`diagP` along a line**: its linear coefficient is `(3/2)⟨S∘S + S², Y⟩`. -/
theorem diagP_line (S Y : Matrix ι ι ℝ) (hS : ∀ a b, S a b = S b a) (hY : ∀ a b, Y a b = Y b a)
    (t : ℝ) :
    diagP (S + t • Y) = diagP S + t * ((3 / 2) * ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b) * Y a b)
      + t ^ 2 * ((3 / 2) * (∑ a, ∑ b, S a b * Y a b ^ 2 + (S * Y * Y).trace)) + t ^ 3 * diagP Y := by
  unfold diagP
  have hcube : ∀ a b, (S + t • Y) a b ^ 3 = S a b ^ 3 + 3 * t * (S a b ^ 2 * Y a b)
      + 3 * t ^ 2 * (S a b * Y a b ^ 2) + t ^ 3 * Y a b ^ 3 := by
    intro a b; simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]; ring
  have htr : ((S + t • Y) * (S + t • Y) * (S + t • Y)).trace
      = (S * S * S).trace + 3 * t * (S * S * Y).trace + 3 * t ^ 2 * (S * Y * Y).trace
        + t ^ 3 * (Y * Y * Y).trace := by
    have c1 : (S * Y * S).trace = (S * S * Y).trace := by
      rw [Matrix.trace_mul_comm (S * Y) S, ← Matrix.mul_assoc]
    have c2 : (Y * S * S).trace = (S * S * Y).trace := by
      rw [Matrix.mul_assoc, Matrix.trace_mul_comm Y (S * S)]
    have c3 : (Y * S * Y).trace = (S * Y * Y).trace := by
      rw [Matrix.trace_mul_comm (Y * S) Y, ← Matrix.mul_assoc, Matrix.trace_mul_comm (Y * Y) S,
        ← Matrix.mul_assoc]
    have c4 : (Y * Y * S).trace = (S * Y * Y).trace := by
      rw [Matrix.trace_mul_comm (Y * Y) S, ← Matrix.mul_assoc]
    simp only [Matrix.add_mul, Matrix.mul_add, Matrix.smul_mul, Matrix.mul_smul, Matrix.trace_add,
      Matrix.trace_smul, smul_eq_mul, c1, c2, c3, c4]
    ring
  simp only [hcube, Finset.sum_add_distrib, ← Finset.mul_sum, htr]
  rw [trace_mul_symm (S * S) Y hY]
  simp only [add_mul, Finset.sum_add_distrib]
  ring

/-- **A unit weight exists** at `n ≥ 4`: a scaled sphere-product weight. -/
theorem exists_unit_weight (hn : 4 ≤ Fintype.card ι) : ∃ w : Matrix ι ι ℝ, IsWeight w ∧ fro w = 2 := by
  obtain ⟨S₀, -, hS₀⟩ := Finset.exists_subset_card_eq (s := (Finset.univ : Finset ι)) (n := 2)
    (by rw [Finset.card_univ]; omega)
  have hp : 2 ≤ S₀.card := by omega
  have hq : 2 ≤ S₀ᶜ.card := by rw [Finset.card_compl]; omega
  have hX := HamiltonsCubic.L130Statement.sphereWeight_sumSq S₀ hp hq
  set X := ∑ i, ∑ j, (sphereWeight S₀ i j) ^ 2 with hXdef
  have hpR : (2 : ℝ) ≤ S₀.card := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ S₀ᶜ.card := by exact_mod_cast hq
  have hXpos : 0 < X := by
    rw [hX]
    apply div_pos
    · have : (0 : ℝ) < (S₀.card : ℝ) + (S₀ᶜ.card : ℝ) - 2 := by linarith
      have : (0 : ℝ) < (S₀.card : ℝ) + (S₀ᶜ.card : ℝ) - 1 := by linarith
      positivity
    · apply mul_pos <;> linarith
  refine ⟨Real.sqrt (2 / X) • sphereWeight S₀, (sphereWeight_isWeight S₀ hp hq).smul _, ?_⟩
  rw [fro_smul, Real.sq_sqrt (by positivity)]
  unfold fro; rw [← hXdef]; field_simp

/-- **A unit weight maximising `diagP` exists.** -/
theorem exists_max_weight (hn : 4 ≤ Fintype.card ι) :
    ∃ S : Matrix ι ι ℝ, IsWeight S ∧ fro S = 2 ∧
      ∀ T : Matrix ι ι ℝ, IsWeight T → fro T = 2 → diagP T ≤ diagP S := by
  set K : Set (Matrix ι ι ℝ) := {T | IsWeight T ∧ fro T = 2} with hK
  have hbox : K ⊆ Set.pi Set.univ (fun _ : ι => Set.pi Set.univ (fun _ : ι => Set.Icc (-2 : ℝ) 2)) := by
    intro T hT a _ b _
    have h1 : T a b ^ 2 ≤ fro T := by
      unfold fro
      have := Finset.single_le_sum (f := fun a => ∑ b, T a b ^ 2) (fun a _ => Finset.sum_nonneg
        fun b _ => sq_nonneg (T a b)) (Finset.mem_univ a)
      have h2 := Finset.single_le_sum (f := fun b => T a b ^ 2) (fun b _ => sq_nonneg (T a b))
        (Finset.mem_univ b)
      linarith
    rw [hT.2] at h1
    constructor <;> nlinarith [sq_nonneg (T a b + 2), sq_nonneg (T a b - 2)]
  have hcomp : IsCompact (Set.pi Set.univ (fun _ : ι => Set.pi Set.univ (fun _ : ι => Set.Icc (-2 : ℝ) 2))
      : Set (Matrix ι ι ℝ)) :=
    isCompact_univ_pi fun _ => isCompact_univ_pi fun _ => isCompact_Icc
  have hcl : IsClosed K := by
    have e : K = (⋂ a, ⋂ b, {T : Matrix ι ι ℝ | T a b = T b a}) ∩ (⋂ a, {T : Matrix ι ι ℝ | T a a = 0})
        ∩ (⋂ a, {T : Matrix ι ι ℝ | ∑ c, T a c = 0}) ∩ {T | fro T = 2} := by
      ext T
      simp only [hK, Set.mem_ofPred_eq, Set.mem_inter_iff, Set.mem_iInter]
      constructor
      · rintro ⟨hw, hf⟩; exact ⟨⟨⟨hw.symm, hw.hollow⟩, hw.rowSum⟩, hf⟩
      · rintro ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩; exact ⟨⟨h1, h2, h3⟩, h4⟩
    rw [e]
    have hc : ∀ a b, Continuous fun T : Matrix ι ι ℝ => T a b := fun a b =>
      (continuous_apply b).comp (continuous_apply a)
    refine ((IsClosed.inter (IsClosed.inter ?_ ?_) ?_).inter ?_)
    · exact isClosed_iInter fun a => isClosed_iInter fun b => isClosed_eq (hc a b) (hc b a)
    · exact isClosed_iInter fun a => isClosed_eq (hc a a) continuous_const
    · exact isClosed_iInter fun a => isClosed_eq (continuous_finsetSum _ fun c _ => hc a c)
        continuous_const
    · exact isClosed_eq (continuous_finsetSum _ fun a _ => continuous_finsetSum _ fun b _ =>
        (hc a b).pow 2) continuous_const
  have hKc : IsCompact K := hcomp.of_isClosed_subset hcl hbox
  have hcont : Continuous (diagP : Matrix ι ι ℝ → ℝ) := by
    have hc : ∀ a b, Continuous fun T : Matrix ι ι ℝ => T a b := fun a b =>
      (continuous_apply b).comp (continuous_apply a)
    unfold diagP
    refine continuous_const.mul (Continuous.add ?_ ?_)
    · exact continuous_finsetSum _ fun a _ => continuous_finsetSum _ fun b _ => (hc a b).pow 3
    · exact ((continuous_id.matrix_mul continuous_id).matrix_mul continuous_id).matrix_trace
  obtain ⟨w0, hw0⟩ := exists_unit_weight hn
  obtain ⟨S, hSK, hmax⟩ := hKc.exists_isMaxOn ⟨w0, hw0⟩ hcont.continuousOn
  exact ⟨S, hSK.1, hSK.2, fun T hT hf => hmax ⟨hT, hf⟩⟩

theorem isWeight_add_smul {S Y : Matrix ι ι ℝ} (hS : IsWeight S) (hY : IsWeight Y) (t : ℝ) :
    IsWeight (S + t • Y) where
  symm a b := by simp only [Matrix.add_apply, Matrix.smul_apply, hS.symm a b, hY.symm a b]
  hollow a := by simp [hS.hollow a, hY.hollow a]
  rowSum a := by
    simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, Finset.sum_add_distrib,
      ← Finset.mul_sum, hS.rowSum a, hY.rowSum a, mul_zero, add_zero]

/-- A linear coefficient dominated by a quadratic one on both sides of `0` vanishes. -/
theorem lin_zero (L C : ℝ) (hC : 0 ≤ C)
    (h : ∀ t : ℝ, t ≠ 0 → |t| ≤ 1 → t * L ≤ t ^ 2 * C) : L = 0 := by
  by_contra hL
  set ε := min 1 (|L| / (2 * (C + 1))) with hε
  have hLpos : 0 < |L| := abs_pos.mpr hL
  have hεpos : 0 < ε := lt_min one_pos (by positivity)
  have hε1 : ε ≤ 1 := min_le_left _ _
  have hεL : ε * (C + 1) ≤ |L| / 2 := by
    have := min_le_right 1 (|L| / (2 * (C + 1)))
    rw [← hε] at this
    calc ε * (C + 1) ≤ |L| / (2 * (C + 1)) * (C + 1) := by gcongr
      _ = |L| / 2 := by field_simp
  rcases lt_or_gt_of_ne hL with hneg | hpos
  · have := h (-ε) (by linarith) (by rw [abs_neg, abs_of_pos hεpos]; exact hε1)
    rw [abs_of_neg hneg] at hεL
    nlinarith
  · have := h ε hεpos.ne' (by rw [abs_of_pos hεpos]; exact hε1)
    rw [abs_of_pos hpos] at hεL
    nlinarith

section maxim

variable {S : Matrix ι ι ℝ} (hS : IsWeight S) (hf : fro S = 2)
  (hmax : ∀ T : Matrix ι ι ℝ, IsWeight T → fro T = 2 → diagP T ≤ diagP S)
include hS hf hmax

theorem max_nonneg : 0 ≤ diagP S := by
  have h := hmax ((-1 : ℝ) • S) (hS.smul _) (by rw [fro_smul, hf]; norm_num)
  rw [diagP_smul] at h
  linarith

/-- **Off the unit sphere**: `diagP T ≤ M (fro T / 2)²` for every weight with `fro T ≥ 2`. -/
theorem max_bound (T : Matrix ι ι ℝ) (hT : IsWeight T) (hT2 : 2 ≤ fro T) :
    diagP T ≤ diagP S * (fro T / 2) ^ 2 := by
  have hM := max_nonneg hS hf hmax
  have hfp : 0 < fro T := by linarith
  set c := Real.sqrt (2 / fro T) with hc
  have hcpos : 0 < c := Real.sqrt_pos.mpr (by positivity)
  have hc2 : c ^ 2 = 2 / fro T := Real.sq_sqrt (by positivity)
  have hc1 : c ≤ 1 := by
    rw [hc, Real.sqrt_le_one]
    rw [div_le_one hfp]; exact hT2
  have hcT := hmax (c • T) (hT.smul c) (by rw [fro_smul, hc2]; field_simp)
  rw [diagP_smul] at hcT
  -- `diagP T ≤ M / c³ ≤ M / c⁴`
  have h3 : diagP T ≤ diagP S / c ^ 3 := by
    rw [le_div_iff₀ (by positivity)]; linarith
  have h34 : diagP S / c ^ 3 ≤ diagP S / c ^ 4 := by
    apply div_le_div_of_nonneg_left hM (by positivity)
    have : c ^ 4 = c ^ 3 * c := by ring
    rw [this]
    exact mul_le_of_le_one_right (by positivity) hc1
  have hc4 : c ^ 4 = (2 / fro T) ^ 2 := by rw [← hc2]; ring
  have : diagP S / c ^ 4 = diagP S * (fro T / 2) ^ 2 := by
    rw [hc4]; field_simp
  linarith

/-- **The first-order condition at the maximiser**: `⟨S∘S + S², y⟩ = 0` for every weight `y ⊥ S`. -/
theorem first_order (y : Matrix ι ι ℝ) (hy : IsWeight y) (horth : ∑ a, ∑ b, S a b * y a b = 0) :
    ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b) * y a b = 0 := by
  set L := (3 / 2) * ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b) * y a b with hL
  set A := (3 / 2) * (∑ a, ∑ b, S a b * y a b ^ 2 + (S * y * y).trace) with hA
  set B := diagP y with hB
  set M := diagP S with hMdef
  have hM := max_nonneg hS hf hmax
  have hfro : ∀ t : ℝ, fro (S + t • y) = 2 + t ^ 2 * fro y := by
    intro t
    unfold fro at *
    have e : ∀ a b, (S + t • y) a b ^ 2 = S a b ^ 2 + 2 * t * (S a b * y a b) + t ^ 2 * y a b ^ 2 := by
      intro a b; simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]; ring
    simp only [e, Finset.sum_add_distrib, ← Finset.mul_sum, horth, hf]
    ring
  have hk : 0 ≤ fro y := fro_nonneg y
  have hbound : ∀ t : ℝ, t ≠ 0 → |t| ≤ 1 → t * L ≤ t ^ 2 * (M * (fro y + fro y ^ 2 / 4) + |A| + |B|) := by
    intro t _ ht1
    have hT := max_bound hS hf hmax (S + t • y) (isWeight_add_smul hS hy t)
      (by rw [hfro]; nlinarith [sq_nonneg t])
    rw [diagP_line S y hS.symm hy.symm, hfro] at hT
    rw [← hL, ← hA, ← hB, ← hMdef] at hT
    have ht2 : t ^ 2 ≤ 1 := by nlinarith [abs_nonneg t, sq_abs t]
    have ht4 : t ^ 4 ≤ t ^ 2 := by nlinarith [sq_nonneg t]
    have hAb : -(t ^ 2 * A) ≤ t ^ 2 * |A| := by nlinarith [neg_abs_le A, sq_nonneg t]
    have hBb : -(t ^ 3 * B) ≤ t ^ 2 * |B| := by
      have : |t ^ 3 * B| ≤ t ^ 2 * |B| := by
        rw [abs_mul, show t ^ 3 = t * t ^ 2 by ring, abs_mul, abs_of_nonneg (sq_nonneg t)]
        have := mul_le_mul_of_nonneg_right ht1 (mul_nonneg (sq_nonneg t) (abs_nonneg B))
        nlinarith [abs_nonneg B]
      linarith [neg_abs_le (t ^ 3 * B)]
    have hMb : M * ((2 + t ^ 2 * fro y) / 2) ^ 2 ≤ M + t ^ 2 * (M * (fro y + fro y ^ 2 / 4)) := by
      have e : ((2 + t ^ 2 * fro y) / 2) ^ 2 = 1 + t ^ 2 * fro y + t ^ 4 * (fro y ^ 2 / 4) := by ring
      rw [e]
      have : t ^ 4 * (fro y ^ 2 / 4) ≤ t ^ 2 * (fro y ^ 2 / 4) :=
        mul_le_mul_of_nonneg_right ht4 (by positivity)
      nlinarith
    nlinarith
  have h0 := lin_zero L _ (by positivity) hbound
  rw [hL] at h0
  linarith

end maxim

/-- **At the maximiser the criticality equation holds with no multiplier.** -/
theorem max_crit (hn : 4 ≤ Fintype.card ι) {S : Matrix ι ι ℝ} (hS : IsWeight S) (hf : fro S = 2)
    (hmax : ∀ T : Matrix ι ι ℝ, IsWeight T → fro T = 2 → diagP T ≤ diagP S) :
    ∃ lam : ℝ, ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b := by
  set Lf : Matrix ι ι ℝ → ℝ := fun y => ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b) * y a b with hLf
  set lam := Lf S / 2 with hlam
  set G : Matrix ι ι ℝ := fun a b => S a b ^ 2 + (S * S) a b - lam * S a b with hG
  have hSS : ∀ a b, (S * S) a b = (S * S) b a := by
    intro a b; simp only [Matrix.mul_apply]
    exact Finset.sum_congr rfl fun c _ => by rw [hS.symm a c, hS.symm c b, mul_comm]
  have hGs : ∀ a b, G a b = G b a := by
    intro a b; simp only [hG, hS.symm a b, hSS a b]
  have hperp : ∀ y : Matrix ι ι ℝ, IsWeight y → ∑ a, ∑ b, G a b * y a b = 0 := by
    intro y hy
    set α := (∑ a, ∑ b, S a b * y a b) / 2 with hα
    have hy' := isWeight_add_smul hy hS (-α)
    have horth : ∑ a, ∑ b, S a b * (y + (-α) • S) a b = 0 := by
      have e : ∀ a b, S a b * (y + (-α) • S) a b = S a b * y a b - α * S a b ^ 2 := by
        intro a b; simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]; ring
      simp only [e, Finset.sum_sub_distrib, ← Finset.mul_sum]
      have : ∑ a, ∑ b, S a b ^ 2 = 2 := hf
      rw [this, hα]; ring
    have h1 := first_order hS hf hmax _ hy' horth
    have e1 : ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b) * (y + (-α) • S) a b = Lf y - α * Lf S := by
      simp only [hLf, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, mul_add, Finset.sum_add_distrib,
        Finset.mul_sum]
      rw [sub_eq_add_neg, ← Finset.sum_neg_distrib]
      congr 1
      exact Finset.sum_congr rfl fun a _ => by
        rw [← Finset.sum_neg_distrib]; exact Finset.sum_congr rfl fun b _ => by ring
    rw [e1] at h1
    have e2 : ∑ a, ∑ b, G a b * y a b = Lf y - lam * ∑ a, ∑ b, S a b * y a b := by
      simp only [hG, hLf, sub_mul, add_mul, Finset.sum_sub_distrib, Finset.mul_sum]
      congr 1
      exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
    rw [e2]
    have : ∑ a, ∑ b, S a b * y a b = 2 * α := by rw [hα]; ring
    rw [this, hlam]
    linarith
  obtain ⟨u, hu⟩ := perp_weights (by omega) G hGs hperp
  have hEL : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b + u a + u b := by
    intro a b hab
    have := hu a b hab
    simp only [hG] at this
    linarith
  have hu0 := multiplier_vanishes hS (by omega) lam u hEL
  have hcrit : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b := by
    intro a b hab; rw [hEL a b hab, hu0 a, hu0 b]; ring
  exact ⟨lam, hcrit⟩

/-- **At the maximiser, L57's bound.** -/
theorem max_le_theta (hn : 4 ≤ Fintype.card ι) {S : Matrix ι ι ℝ} (hS : IsWeight S) (hf : fro S = 2)
    (hmax : ∀ T : Matrix ι ι ℝ, IsWeight T → fro T = 2 → diagP T ≤ diagP S) :
    diagP S ≤ Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
      / (Fintype.card ι : ℝ) := by
  obtain ⟨lam, hcrit⟩ := max_crit hn hS hf hmax
  have hunit : ∑ a, ∑ b, S a b ^ 2 = 2 := hf
  rw [diagP_eq_lam hS hunit lam hcrit]
  exact L57_critical hS hn hunit lam hcrit

/-- **L57, THE DIAGONAL THEOREM, AT EVERY DIAGONAL WEYL OPERATOR**: for every weight `w` at every
`n ≥ 4`, `P(diag w) ≤ √(2(n−1)(n−2))/n · ‖diag w‖³`, which is `Θₙ ‖W‖³` at even `n`. -/
theorem L57_diagonal (hn : 4 ≤ Fintype.card ι) (w : Matrix ι ι ℝ) (hw : IsWeight w) :
    HamiltonsCubic.RealLayer.Pcubic (diagOp w) ≤
      Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2)) / (Fintype.card ι : ℝ)
        * HamiltonsCubic.RealLayer.norm (diagOp w) ^ 3 := by
  set Θ := Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2))
    / (Fintype.card ι : ℝ) with hΘ
  have hΘ0 : 0 ≤ Θ := div_nonneg (Real.sqrt_nonneg _) (by positivity)
  obtain ⟨S, hS, hf, hmax⟩ := exists_max_weight hn
  have hMΘ := max_le_theta hn hS hf hmax
  rw [HamiltonsCubic.RealLayer.diagCubicFormula w hw]
  have hnorm : HamiltonsCubic.RealLayer.norm (diagOp w) = Real.sqrt (fro w / 2) := by
    unfold HamiltonsCubic.RealLayer.norm
    rw [diagOp_normSq w hw.symm hw.hollow]
    congr 1; unfold fro; ring
  rw [hnorm]
  by_cases h0 : fro w = 0
  · have hz : ∀ a b, w a b = 0 := by
      intro a b
      have hnn : ∀ a ∈ (Finset.univ : Finset ι), 0 ≤ ∑ b, w a b ^ 2 :=
        fun a _ => Finset.sum_nonneg fun b _ => sq_nonneg _
      have h1 := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp h0 a (Finset.mem_univ a)
      have h2 := (Finset.sum_eq_zero_iff_of_nonneg fun b _ => sq_nonneg (w a b)).mp h1 b
        (Finset.mem_univ b)
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h2
    have hwz : w = 0 := Matrix.ext hz
    rw [h0]
    have hd : diagP w = 0 := by rw [hwz]; simp [diagP]
    rw [hd]; simp
  have hfp : 0 < fro w := lt_of_le_of_ne (fro_nonneg w) (Ne.symm h0)
  set c := Real.sqrt (2 / fro w) with hc
  have hcpos : 0 < c := Real.sqrt_pos.mpr (by positivity)
  have hc2 : c ^ 2 = 2 / fro w := Real.sq_sqrt (by positivity)
  have hcw := hmax (c • w) (hw.smul c) (by rw [fro_smul, hc2]; field_simp)
  rw [diagP_smul] at hcw
  have hcinv : Real.sqrt (fro w / 2) = c⁻¹ := by
    rw [hc, ← Real.sqrt_inv, inv_div]
  rw [hcinv]
  have : diagP w ≤ Θ / c ^ 3 := by
    rw [le_div_iff₀ (by positivity)]; linarith
  calc diagP w ≤ Θ / c ^ 3 := this
    _ = Θ * c⁻¹ ^ 3 := by rw [inv_pow, div_eq_mul_inv]

end HamiltonsCubic.L57Critical
