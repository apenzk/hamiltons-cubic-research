import Mathlib
import HamiltonsCubic.Results.CriticalBridge
import HamiltonsCubic.Results.L120HessPair
import HamiltonsCubic.Results.L120Pair
import HamiltonsCubic.Results.L71Witness
import HamiltonsCubic.Results.L0Witness
import HamiltonsCubic.Results.L53CPm

set_option linter.style.longLine false

/-!
# L120: the pair clause at a concrete critical diagonal operator

[L120HessPair.lean](L120HessPair.lean)'s `hessOp_pair` holds at a unit critical diagonal Weyl operator
with `P ≠ 0`, taking the criticality as the `CurvOp2` equation `Qop2 a = λ a`; the L120 row owes *"no
assembled instance with a concrete critical $w$ is typed"*. This file assembles one:

* `diagOp_smul`, `isWeight_smul`, `normSq_smul`, `isCritical_smul`: a critical diagonal operator scaled
  by `c` is critical at `cθ`, with norm `c²` times;
* `unit_critical`: a critical diagonal Weyl operator of positive norm and `θ ≠ 0`, scaled to unit norm,
  meets all of `hessOp_pair`'s hypotheses on `w` (the criticality through
  [CriticalBridge.lean](CriticalBridge.lean)'s `Qop2_restrict_of_critical`, `P` through L0Witness'
  `Pcubic2_restrict`);
* `balanced_unit`: the balanced sphere product `S^p × S^p` of [L71Witness.lean](L71Witness.lean),
  critical at `θ = 1`, gives such a `w` at every `p ≥ 3`;
* `L120_pair_instance`: `hessOp_pair`'s conclusion there, for every pair-summand `B` of the Weyl module
  with the right character;
* `pair_B_exists`: such a `B`, nonzero, is L120Pair's `pairS` at `j = 0`, `k = 1`, `c = δ₂ - δ₃`
  ([r1732](../../../reviews/REVIEW_r1732.md) O1).
-/

namespace HamiltonsCubic.L120Witness

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.CriticalBridge

variable {n : ℕ}

theorem diagOp_smul (c : ℝ) (w : Matrix (Fin n) (Fin n) ℝ) : diagOp (c • w) = c • diagOp w := by
  funext X; ext a b; simp [diagOp, mul_assoc]

theorem isWeight_smul {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) (c : ℝ) : IsWeight (c • w) where
  symm a b := by simp [hw.symm a b]
  hollow a := by simp [hw.hollow a]
  rowSum a := by simp [← Finset.mul_sum, hw.rowSum a]

theorem normSq_smul (c : ℝ) (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) :
    normSq (c • R) = c ^ 2 * normSq R := by
  unfold normSq innerOp
  simp only [Pi.smul_apply, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  ring

theorem isCritical_smul {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hR : IsLinOp R) {θ : ℝ}
    (hc : IsCritical R θ) (c : ℝ) : IsCritical (c • R) (c * θ) := by
  intro i j
  rw [Qop_smul R hR c, hc i j, Pi.smul_apply, smul_smul, smul_smul]
  ring_nf

/-- **A unit critical diagonal operator from any critical one** of positive norm and `θ ≠ 0`. -/
theorem unit_critical {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {θ : ℝ}
    (hc : IsCritical (diagOp w) θ) (hθ : θ ≠ 0) (hN : 0 < normSq (diagOp w)) :
    ∃ (w' : Matrix (Fin n) (Fin n) ℝ) (hw' : IsWeight w') (lam : ℝ),
      normSq2 (restrict (diagOp_isWeyl hw')) = 1 ∧
      Qop2 (restrict (diagOp_isWeyl hw')) = lam • restrict (diagOp_isWeyl hw') ∧
      Pcubic2 (restrict (diagOp_isWeyl hw')) ≠ 0 := by
  set c : ℝ := 1 / Real.sqrt (normSq (diagOp w)) with hcdef
  have hs : 0 < Real.sqrt (normSq (diagOp w)) := Real.sqrt_pos.mpr hN
  have hc0 : c ≠ 0 := by rw [hcdef]; positivity
  have hc2 : c ^ 2 * normSq (diagOp w) = 1 := by
    rw [hcdef, div_pow, Real.sq_sqrt hN.le]; field_simp
  have hw' := isWeight_smul hw c
  have hlin : IsLinOp (diagOp (c • w)) := diagOp_isLinOp' _
  have hWop : IsWeylOp (diagOp (c • w)) := ⟨hlin, diagOp_isWeyl hw'⟩
  have hcrit' : IsCritical (diagOp (c • w)) (c * θ) := by
    rw [diagOp_smul]; exact isCritical_smul (diagOp_isLinOp' w) hc c
  have hunit : normSq (diagOp (c • w)) = 1 := by rw [diagOp_smul, normSq_smul, hc2]
  refine ⟨c • w, hw', c * θ, ?_, Qop2_restrict_of_critical hWop hcrit', ?_⟩
  · rw [normSq2_restrict hlin (diagOp_isWeyl hw'), hunit]
  · rw [Pcubic2_restrict hlin (diagOp_isWeyl hw'), HamiltonsCubic.L70CPm.Pcubic_eq_innerOp_Qop,
      HamiltonsCubic.L70CPm.innerOp_Qop_of_critical _ _ hcrit', hunit, mul_one]
    exact mul_ne_zero hc0 hθ

/-- **The balanced sphere product gives one** at every `p ≥ 3`. -/
theorem balanced_unit (p : ℕ) (hp : 3 ≤ p) :
    ∃ (w' : Matrix (Fin (2 * p)) (Fin (2 * p)) ℝ) (hw' : IsWeight w') (lam : ℝ),
      normSq2 (restrict (diagOp_isWeyl hw')) = 1 ∧
      Qop2 (restrict (diagOp_isWeyl hw')) = lam • restrict (diagOp_isWeyl hw') ∧
      Pcubic2 (restrict (diagOp_isWeyl hw')) ≠ 0 := by
  have hw := HamiltonsCubic.L56Weyl.weylE_isWeight (HamiltonsCubic.L71Witness.βb p)
    (HamiltonsCubic.L71Witness.hbs p (by omega)) (HamiltonsCubic.L71Witness.hn p (by omega))
  have hc := HamiltonsCubic.L71Witness.Wb_critical p hp
  refine unit_critical hw hc one_ne_zero ?_
  -- the norm is positive: `normSq = ½ ∑∑ w²` and the entry at `(0, p)` is `-1/(2p-1) ≠ 0`
  have e : normSq (diagOp (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p))) = (1 / 2) * ∑ i, ∑ j, (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i j * (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i j :=
    HamiltonsCubic.L99Statement.innerOp_diagOp (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) hw.symm hw.symm hw.hollow
  set i0 : Fin (2 * p) := ⟨0, by omega⟩
  set ip : Fin (2 * p) := ⟨p, by omega⟩
  have hne : i0 ≠ ip := by intro h; have := congrArg Fin.val h; simp [i0, ip] at this; omega
  have hβ : HamiltonsCubic.L71Witness.βb p i0 ≠ HamiltonsCubic.L71Witness.βb p ip := by
    simp [HamiltonsCubic.L71Witness.βb, i0, ip]; omega
  have hval : (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 ip = -(1 / (2 * (p : ℝ) - 1)) := by
    rw [HamiltonsCubic.L71Witness.weylE_val p i0 ip hne, if_neg hβ]
  have hpR : (3 : ℝ) ≤ p := by exact_mod_cast hp
  have hent : 0 < (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 ip * (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 ip := by
    rw [hval]; have : 0 < 1 / (2 * (p : ℝ) - 1) := by
      apply one_div_pos.mpr; linarith
    nlinarith
  have hrow : (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 ip * (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 ip ≤ ∑ j, (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 j * (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 j :=
    Finset.single_le_sum (f := fun j => (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 j * (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 j) (fun j _ => mul_self_nonneg _) (Finset.mem_univ ip)
  have hall : ∑ j, (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 j * (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i0 j ≤ ∑ i, ∑ j, (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i j * (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i j :=
    Finset.single_le_sum (f := fun i => ∑ j, (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i j * (HamiltonsCubic.L56Weyl.weylE (HamiltonsCubic.L71Witness.βb p)) i j)
      (fun i _ => Finset.sum_nonneg fun j _ => mul_self_nonneg _) (Finset.mem_univ i0)
  rw [e]
  linarith

open HamiltonsCubic.L120Hess HamiltonsCubic.L120HessPair HamiltonsCubic.Results HamiltonsCubic.TensorBridge in
/-- **The pair clause at a concrete critical diagonal operator**: at the unit balanced sphere product
on `ℝ^{2p}`, `p ≥ 3`, the Hessian maps every pair-summand operator of `W^⊥` to one with the same
character (`hessOp_pair` with its hypotheses on `w` discharged). L120Pair's `pairS` supplies nonzero
`B` at `n ≥ 4`. -/
theorem L120_pair_instance (p : ℕ) (hp : 3 ≤ p) :
    ∃ (w : Matrix (Fin (2 * p)) (Fin (2 * p)) ℝ) (hwt : IsWeight w) (lam : ℝ)
      (ha : normSq2 (restrict (diagOp_isWeyl hwt)) = 1)
      (hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = lam • restrict (diagOp_isWeyl hwt))
      (hθ : Pcubic2 (restrict (diagOp_isWeyl hwt)) ≠ 0),
      ∀ (B : CurvLin (Fin (2 * p))) (hB : B ∈ weylModuleS (Fin (2 * p))) {j k : Fin (2 * p)} (hjk : j ≠ k)
        (hiso : ∀ m, act (Results.flip m) B = (Results.sgn m j * Results.sgn m k) • B),
        SignChar (fun ε => ε j * ε k)
          (tanV (hessOp ha (isWeyl2_restrict (diagOp_isWeyl hwt)) hcrit hθ
            ⟨restrict (hB.1 : IsWeyl (fun X => B X)), pair_mem_weylPerp hwt B hB hjk hiso⟩)) := by
  obtain ⟨w, hwt, lam, ha, hcrit, hθ⟩ := balanced_unit p hp
  exact ⟨w, hwt, lam, ha, hcrit, hθ, fun B hB j k hjk hiso => hessOp_pair hwt ha hcrit hθ B hB hjk hiso⟩

open HamiltonsCubic.Results in
/-- **A concrete nonzero pair-summand operator** ([r1732](../../../reviews/REVIEW_r1732.md) O1): at every
`n ≥ 4`, L120Pair's `pairS` at `j = 0`, `k = 1`, `c = δ₂ - δ₃` lies in the Weyl module, carries the
character `ε₀ε₁` and is nonzero (`coord_pairS_diag` reads `c 2 = 1` off it), so `L120_pair_instance`'s
universal clause has a witness. -/
theorem pair_B_exists (hn : 4 ≤ n) :
    ∃ (B : CurvLin (Fin n)) (_ : B ∈ weylModuleS (Fin n)), B ≠ 0 ∧
      ∀ m, act (Results.flip m) B =
        (Results.sgn m (⟨0, by omega⟩ : Fin n) * Results.sgn m (⟨1, by omega⟩ : Fin n)) • B := by
  set j0 : Fin n := ⟨0, by omega⟩
  set j1 : Fin n := ⟨1, by omega⟩
  set i2 : Fin n := ⟨2, by omega⟩
  set i3 : Fin n := ⟨3, by omega⟩
  have hjk : j0 ≠ j1 := by intro h; have := congrArg Fin.val h; simp [j0, j1] at this
  have h23 : i2 ≠ i3 := by intro h; have := congrArg Fin.val h; simp [i2, i3] at this
  have h20 : i2 ≠ j0 := by intro h; have := congrArg Fin.val h; simp [i2, j0] at this
  have h21 : i2 ≠ j1 := by intro h; have := congrArg Fin.val h; simp [i2, j1] at this
  have h30 : i3 ≠ j0 := by intro h; have := congrArg Fin.val h; simp [i3, j0] at this
  have h31 : i3 ≠ j1 := by intro h; have := congrArg Fin.val h; simp [i3, j1] at this
  set c : Fin n → ℝ := fun i => (if i = i2 then 1 else 0) - (if i = i3 then 1 else 0) with hc
  have hsum : ∑ i ∈ univ.filter (fun i => j0 ≠ i ∧ j1 ≠ i), c i = 0 := by
    simp only [hc, Finset.sum_sub_distrib, Finset.sum_ite_eq', Finset.mem_filter, Finset.mem_univ,
      true_and]
    simp [Ne.symm h20, Ne.symm h21, Ne.symm h30, Ne.symm h31]
  refine ⟨_, pairS_mem hjk c hsum, ?_, pairS_iso hjk c hsum⟩
  intro h0
  have hco := coord_pairS_diag hjk c h20 h21
  rw [h0] at hco
  have hz : coord (0 : CurvLin (Fin n)) j0 i2 j1 i2 = 0 := by
    simp [coord, inner2_eq_sum]
  rw [hz] at hco
  simp [hc, h23] at hco

end HamiltonsCubic.L120Witness
