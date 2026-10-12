import HamiltonsCubic.Results.L57Odd
import HamiltonsCubic.Results.FourthMomentEq

set_option linter.style.longLine false

/-!
# L57's equality case at odd `n`: the unbalanced product

At odd `n ≥ 5` a unit critical weight with `λ = Θₙ` makes every step of the odd chain tight
([L57Odd.lean](L57Odd.lean)): the fourth moment is at its minimum, so by
[FourthMomentEq.lean](FourthMomentEq.lean) the top eigenvector takes two values at multiplicities
`p, q` with `(p − q)² = 1`, and `S` is a positive multiple of L57's projection `Z(v)`, constant on the
three classes of pairs of that split: the unbalanced product `S^{(n−1)/2} × S^{(n+1)/2}`
(`L57_critical_eq_odd`). `L57_unit_eq_odd` gives the same at every unit weight attaining `Θₙ`.
-/

namespace HamiltonsCubic.L57Critical

open Finset Matrix HamiltonsCubic.FamilyLayer HamiltonsCubic.FourthMoment

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **L57's EQUALITY CASE AT A CRITICAL POINT, ODD `n`.** -/
theorem L57_critical_eq_odd {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 5 ≤ Fintype.card ι)
    (hodd : ¬ Even (Fintype.card ι)) (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (lam : ℝ)
    (hcrit : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b)
    (heq : lam = Real.sqrt (thetaOddSq (Fintype.card ι : ℝ))) :
    ∃ (v : ι → ℝ) (t x y : ℝ), 0 < t ∧ ∑ a, v a = 0 ∧ ∑ a, v a ^ 2 = 1 ∧ x ≠ y ∧
      (∀ a, v a = x ∨ v a = y) ∧
      (((Finset.univ.filter fun a => v a = x).card : ℤ) - (Finset.univ.filter fun a => v a = y).card) ^ 2 = 1 ∧
      ∀ a b, S a b = t * Zp v (Fintype.card ι : ℝ) a b := by
  set n : ℝ := (Fintype.card ι : ℝ) with hndef
  have hn5 : (5 : ℝ) ≤ n := by rw [hndef]; exact_mod_cast hn
  have hnpos : 0 < n := by linarith
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (by omega)
  obtain ⟨μ, v, hμ, hv, h2⟩ := exists_pos_eigen hS hne hunit
  have h1 := sum_v_zero S hS v μ hv hμ.ne'
  have hp := pairing S hS v μ hv lam h2 hcrit
  have hs1 := step1 S hS v μ hv h2 h1
  obtain ⟨hSZ, hZZ⟩ := step23_parts S hS v μ hv h2 h1 (by omega)
  rw [← hndef] at hs1 hSZ hZZ
  have hn2 : 0 < n - 2 := by linarith
  have hn1 : 0 < n - 1 := by linarith
  have hn3 : 0 < n - 3 := by linarith
  have hθ0 : 0 ≤ thetaOddSq n := by unfold thetaOddSq; positivity
  have hl0 : 0 ≤ lam := by rw [heq]; exact Real.sqrt_nonneg _
  have hlm : lam * n ≤ (n - 1) * μ := by
    have : lam * μ * n ≤ (n - 1) * μ ^ 2 := by nlinarith
    have hμ2 : lam * n * μ ≤ (n - 1) * μ * μ := by nlinarith
    exact le_of_mul_le_mul_right hμ2 hμ
  set M := 2 * n ^ 2 * (n - 3) / ((n ^ 2 - 1) * (n - 2)) with hM
  have hMpos : 0 < M := by
    have : 0 < n ^ 2 - 1 := by nlinarith
    positivity
  have hlsq : lam ^ 2 = thetaOddSq n := by rw [heq, Real.sq_sqrt hθ0]
  have hnM : n ^ 2 * thetaOddSq n = (n - 1) ^ 2 * M := by
    unfold thetaOddSq
    have : n ^ 2 - 1 = (n - 1) * (n + 1) := by ring
    rw [hM, this]; field_simp
  -- `μ² ≥ M`
  have hμlo : M ≤ μ ^ 2 := by
    have h := mul_self_le_mul_self (by positivity) hlm
    have e : lam * n * (lam * n) = (n - 1) ^ 2 * M := by rw [← hnM, ← hlsq]; ring
    rw [e] at h
    have : (n - 1) ^ 2 * M ≤ (n - 1) ^ 2 * μ ^ 2 := by nlinarith
    exact le_of_mul_le_mul_left this (by positivity)
  -- the chain above it
  have hcs := cs_pairs S (Zp v n)
  rw [hSZ, hunit, hZZ] at hcs
  have h4 := fourth_moment_odd (ι := ι) (by omega) hodd v h1 h2
  rw [← hndef] at h4
  set A := (n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) with hA
  set k := n / (2 * (n - 2)) with hk
  have hkpos : 0 < k := by positivity
  have hAk : 2 * (2 * (A - k * gOdd n)) = M := by
    rw [hA, hk, hM]; unfold gOdd
    have : n ^ 2 - 1 ≠ 0 := by nlinarith
    field_simp; ring
  have hv4 : ∑ a, v a ^ 4 = gOdd n := by
    have hup : 2 * (2 * (A - k * ∑ a, v a ^ 4)) ≤ M := by
      rw [← hAk]; nlinarith [mul_le_mul_of_nonneg_left h4 hkpos.le]
    have : k * ∑ a, v a ^ 4 ≤ k * gOdd n := by nlinarith
    exact le_antisymm (le_of_mul_le_mul_left this hkpos) h4
  have hZval : ∑ a, ∑ b, Zp v n a b ^ 2 = M / 2 := by
    rw [hZZ, hv4]; linarith [hAk]
  have hZpos : 0 < ∑ a, ∑ b, Zp v n a b ^ 2 := by rw [hZval]; positivity
  have hcseq : (∑ a, ∑ b, S a b * Zp v n a b) ^ 2
      = (∑ a, ∑ b, S a b ^ 2) * ∑ a, ∑ b, Zp v n a b ^ 2 := by
    rw [hSZ, hunit, hZval]
    have hup : μ ^ 2 ≤ M := by rw [hv4] at hcs; linarith [hAk]
    linarith
  have hprop := cs_eq S (Zp v n) hZpos hcseq
  obtain ⟨x, y, hxy, hvals, hpq⟩ := fourth_moment_odd_eq (ι := ι) hn hodd v ⟨h1, h2⟩ (by rw [← hndef]; exact hv4)
  refine ⟨v, _, x, y, ?_, h1, h2, hxy, hvals, hpq, hprop⟩
  rw [hSZ]; exact div_pos hμ hZpos

/-- **L57's EQUALITY CASE ON THE UNIT DIAGONAL SPHERE, ODD `n`.** -/
theorem L57_unit_eq_odd {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 5 ≤ Fintype.card ι)
    (hodd : ¬ Even (Fintype.card ι)) (hf : fro S = 2)
    (heq : diagP S = Real.sqrt (thetaOddSq (Fintype.card ι : ℝ))) :
    ∃ (v : ι → ℝ) (t x y : ℝ), 0 < t ∧ ∑ a, v a = 0 ∧ ∑ a, v a ^ 2 = 1 ∧ x ≠ y ∧
      (∀ a, v a = x ∨ v a = y) ∧
      (((Finset.univ.filter fun a => v a = x).card : ℤ) - (Finset.univ.filter fun a => v a = y).card) ^ 2 = 1 ∧
      ∀ a b, S a b = t * Zp v (Fintype.card ι : ℝ) a b := by
  obtain ⟨S₀, hS₀, hf₀, hmax₀⟩ := exists_max_weight (by omega : 4 ≤ Fintype.card ι)
  have hb : diagP S₀ ≤ Real.sqrt (thetaOddSq (Fintype.card ι : ℝ)) := by
    obtain ⟨lam, hcrit⟩ := max_crit (by omega) hS₀ hf₀ hmax₀
    have hunit : ∑ a, ∑ b, S₀ a b ^ 2 = 2 := hf₀
    rw [diagP_eq_lam hS₀ hunit lam hcrit]
    exact L57_critical_odd hS₀ hn hodd hunit lam hcrit
  have hmax : ∀ T : Matrix ι ι ℝ, IsWeight T → fro T = 2 → diagP T ≤ diagP S := fun T hT hfT => by
    rw [heq]; exact le_trans (hmax₀ T hT hfT) hb
  obtain ⟨lam, hcrit⟩ := max_crit (by omega) hS hf hmax
  have hunit : ∑ a, ∑ b, S a b ^ 2 = 2 := hf
  have hlam : lam = _ := (diagP_eq_lam hS hunit lam hcrit).symm.trans heq
  exact L57_critical_eq_odd hS hn hodd hunit lam hcrit hlam

end HamiltonsCubic.L57Critical
