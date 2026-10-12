import Mathlib
import HamiltonsCubic.Results.L56Spec
import HamiltonsCubic.Results.L71Sat
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false

/-!
# L71: a saturating witness at every even `n ≥ 6`, the balanced sphere product

[L71Sat.lean](L71Sat.lean)'s `L71_saturated` concludes that a critical linear Weyl operator saturating
L70's bound `θ = λ_min + (n-2)λ_max` has a symmetric pair for its eigenspaces, and the L71 row owes
*"a saturating witness at `n ≥ 5` (the balanced sphere products at even `n ≥ 6`, whose `Λ²` spectrum
through `Mpair_isHermitian` the layer has not computed), without which `L71_saturated` is proved but
not yet exhibited as non-vacuous in Lean"*. This file exhibits it.

At `n = 2p`, `p ≥ 3`, the labelling `βb p` splits `Fin (2p)` into two factors of size `p`, and
`Wb p = diagOp (weylE (βb p))` is the Einstein Weyl operator of `S^p × S^p` ([L56Weyl.lean](L56Weyl.lean)),
with weight `A - C` within a factor and `-C` across, `A = 1/(p-1)`, `C = 1/(2p-1)`:

* `bs_bal`: every factor has size `p`;
* `weylE_sq`: `w_ab² + (w²)_ab = w_ab` off the diagonal, so `Wb_critical`: `IsCritical (Wb p) 1` through
  SharpDiag's `diagCriticalityIsCritical`;
* `ev_bounds`: every eigenvalue of `Mpair` lies in `[-C, A - C]`, by L56Spec's `diagOp_eigen_entry` on
  the spectral frame; `ev_attains`: `-C` is an eigenvalue, by the frame's completeness at `φ_{0p}`;
* the saturation identity `1 = -C + (2p-2)(A - C)`, proved inline in `L71_nonvacuous` and `L71_witness`;
* `L71_witness`: every hypothesis of `L71_saturated` holds at `Wb p`, `θ = 1`, `λ_min = -C`,
  `λ_max = A - C`, and so does its conclusion.
-/

namespace HamiltonsCubic.L71Witness

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.L41Statement
  HamiltonsCubic.L56Weyl HamiltonsCubic.L56Spec

/-- The balanced labelling of `Fin (2p)`: the first `p` coordinates against the last `p`. -/
def βb (p : ℕ) : Fin (2 * p) → Bool := fun a => decide ((a : ℕ) < p)

theorem bs_bal (p : ℕ) (a : Fin (2 * p)) : bs (βb p) a = p := by
  unfold bs
  have hcard := Finset.card_filter_add_card_filter_not (s := (Finset.univ : Finset (Fin (2 * p))))
    (fun b : Fin (2 * p) => (b : ℕ) < p)
  have hlt : (Finset.univ.filter fun b : Fin (2 * p) => (b : ℕ) < p).card = p := by
    rw [Fin.card_filter_val_lt]; omega
  rw [Finset.card_univ, Fintype.card_fin, hlt] at hcard
  by_cases ha : (a : ℕ) < p
  · have e : (Finset.univ.filter fun b : Fin (2 * p) => βb p b = βb p a)
        = Finset.univ.filter fun b : Fin (2 * p) => (b : ℕ) < p := by
      ext b; simp [βb, ha]
    rw [e]; exact hlt
  · have e : (Finset.univ.filter fun b : Fin (2 * p) => βb p b = βb p a)
        = Finset.univ.filter fun b : Fin (2 * p) => ¬ (b : ℕ) < p := by
      ext b; simp [βb, ha]
    rw [e]; omega

/-- The operator. -/
noncomputable def Wb (p : ℕ) := diagOp (weylE (βb p))

theorem hbs (p : ℕ) (hp : 2 ≤ p) : ∀ a : Fin (2 * p), 2 ≤ bs (βb p) a := fun a => by
  rw [bs_bal]; exact hp

theorem hn (p : ℕ) (hp : 2 ≤ p) : 2 ≤ Fintype.card (Fin (2 * p)) := by
  rw [Fintype.card_fin]; omega

theorem Wb_isWeylOp (p : ℕ) (hp : 2 ≤ p) : IsWeylOp (Wb p) :=
  ⟨isLinOp_diagOp _, diagOp_isWeyl (weylE_isWeight (βb p) (hbs p hp) (hn p hp))⟩

/-- The entries in indicator form: `w_ab = A·s_ab - C - (A - C)·δ_ab`. -/
theorem weylE_ind (p : ℕ) (a b : Fin (2 * p)) :
    weylE (βb p) a b = (1 / ((p : ℝ) - 1)) * (if βb p a = βb p b then 1 else 0)
      - 1 / ((2 * p : ℕ) - 1 : ℝ)
      - (1 / ((p : ℝ) - 1) - 1 / ((2 * p : ℕ) - 1 : ℝ)) * (if a = b then 1 else 0) := by
  unfold weylE
  simp only [Matrix.of_apply, bs_bal, Fintype.card_fin]
  by_cases hab : a = b
  · subst hab; simp
  · by_cases hβ : βb p a = βb p b
    · simp [hab, hβ]
    · simp [hab, hβ]

theorem sum_s (p : ℕ) (a : Fin (2 * p)) :
    ∑ c, (if βb p a = βb p c then (1 : ℝ) else 0) = p := by
  rw [Finset.sum_boole]
  have : (Finset.univ.filter fun c => βb p a = βb p c) = Finset.univ.filter fun c => βb p c = βb p a := by
    ext c; simp [eq_comm]
  rw [this]
  exact_mod_cast bs_bal p a

theorem sum_ss (p : ℕ) (a b : Fin (2 * p)) :
    ∑ c, (if βb p a = βb p c then (1 : ℝ) else 0) * (if βb p c = βb p b then 1 else 0)
      = p * (if βb p a = βb p b then 1 else 0) := by
  have e : ∀ c, (if βb p a = βb p c then (1 : ℝ) else 0) * (if βb p c = βb p b then 1 else 0)
      = (if βb p a = βb p b then 1 else 0) * (if βb p a = βb p c then 1 else 0) := fun c => by
    by_cases h1 : βb p a = βb p c
    · rw [if_pos h1, h1]; ring
    · rw [if_neg h1]
      by_cases h2 : βb p a = βb p b
      · rw [if_pos h2, if_neg (fun h => h1 (h2.trans h.symm))]; ring
      · simp [h2]
  simp only [e, ← Finset.mul_sum, sum_s]
  ring

/-- The within-factor identity over the atoms `u = p - 1`, `v = 2p - 1`. -/
theorem within_id (u v : ℝ) (hu : u ≠ 0) (hv : v ≠ 0) (huv : v = 2 * u + 1) :
    (1 / u - 1 / v) ^ 2 + ((1 / u) ^ 2 * (u + 1) - 2 * (1 / u) * (1 / v) * (u + 1)
      - 2 * (1 / u) * (1 / u - 1 / v) + (1 / v) ^ 2 * (2 * (u + 1)) + 2 * (1 / v) * (1 / u - 1 / v))
      = 1 / u - 1 / v := by
  field_simp
  rw [huv]
  ring

/-- The across identity over the same atoms. -/
theorem across_id (u v : ℝ) (hu : u ≠ 0) (hv : v ≠ 0) (huv : v = 2 * u + 1) :
    (1 / v) ^ 2 + (- 2 * (1 / u) * (1 / v) * (u + 1) + (1 / v) ^ 2 * (2 * (u + 1))
      + 2 * (1 / v) * (1 / u - 1 / v)) = -(1 / v) := by
  field_simp
  rw [huv]
  ring

/-- **The weights solve the criticality equation at `θ = 1`.** -/
theorem weylE_sq (p : ℕ) (hp : 3 ≤ p) (a b : Fin (2 * p)) (hab : a ≠ b) :
    weylE (βb p) a b ^ 2 + (weylE (βb p) * weylE (βb p)) a b = 1 * weylE (βb p) a b := by
  set A : ℝ := 1 / ((p : ℝ) - 1) with hA
  set C : ℝ := 1 / ((2 * p : ℕ) - 1 : ℝ) with hC
  set s : Fin (2 * p) → Fin (2 * p) → ℝ := fun x y => if βb p x = βb p y then 1 else 0 with hs
  set d : Fin (2 * p) → Fin (2 * p) → ℝ := fun x y => if x = y then 1 else 0 with hd
  have hw : ∀ x y, weylE (βb p) x y = A * s x y - C - (A - C) * d x y := fun x y => weylE_ind p x y
  have hprod : ∀ c, weylE (βb p) a c * weylE (βb p) c b =
      A ^ 2 * (s a c * s c b) - A * C * s a c - A * (A - C) * (s a c * d c b) - A * C * s c b + C ^ 2
        + C * (A - C) * d c b - A * (A - C) * (d a c * s c b) + C * (A - C) * d a c
        + (A - C) ^ 2 * (d a c * d c b) := fun c => by
    rw [hw, hw]; ring
  have e1 : ∑ c, s a c * s c b = p * s a b := sum_ss p a b
  have e2 : ∑ c, s a c = p := sum_s p a
  have e3 : ∑ c, s c b = p := by
    rw [← sum_s p b]; exact Finset.sum_congr rfl fun c _ => by simp only [hs, eq_comm]
  have e4 : ∑ c, s a c * d c b = s a b := by
    simp only [hd, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have e5 : ∑ c, d a c * s c b = s a b := by
    simp only [hd, ite_mul, one_mul, zero_mul, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have e6 : ∑ c, d a c = 1 := by
    simp only [hd, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have e7 : ∑ c, d c b = 1 := by
    simp only [hd, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have e8 : ∑ c, d a c * d c b = 0 := by
    simp only [hd, ite_mul, one_mul, zero_mul, Finset.sum_ite_eq, Finset.mem_univ, if_true, if_neg hab]
  have hmul : (weylE (βb p) * weylE (βb p)) a b =
      A ^ 2 * (p * s a b) - A * C * p - A * (A - C) * s a b - A * C * p + C ^ 2 * (2 * p)
        + C * (A - C) - A * (A - C) * s a b + C * (A - C) := by
    rw [Matrix.mul_apply, Finset.sum_congr rfl fun c _ => hprod c]
    simp only [Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, e1, e2, e3, e4, e5,
      e6, e7, e8, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
    push_cast; ring
  rw [hmul, hw a b]
  have hdab : d a b = 0 := by simp [hd, hab]
  rw [hdab]
  have hp1 : (p : ℝ) - 1 ≠ 0 := by
    have : (3 : ℝ) ≤ p := by exact_mod_cast hp
    linarith
  have hp2 : ((2 * p : ℕ) - 1 : ℝ) ≠ 0 := by
    have : (3 : ℝ) ≤ p := by exact_mod_cast hp
    push_cast; linarith
  have hp2' : 2 * (p : ℝ) - 1 ≠ 0 := by push_cast at hp2; exact hp2
  have hCp : C = 1 / (2 * (p : ℝ) - 1) := by rw [hC]; push_cast; ring
  by_cases hβ : βb p a = βb p b
  · have : s a b = 1 := by simp [hs, hβ]
    rw [this, hA, hCp]
    have h := within_id ((p : ℝ) - 1) (2 * (p : ℝ) - 1) hp1 hp2' (by ring)
    linear_combination h
  · have : s a b = 0 := by simp [hs, hβ]
    rw [this, hA, hCp]
    have h := across_id ((p : ℝ) - 1) (2 * (p : ℝ) - 1) hp1 hp2' (by ring)
    linear_combination h

theorem Wb_critical (p : ℕ) (hp : 3 ≤ p) : IsCritical (Wb p) 1 :=
  diagCriticalityIsCritical (weylE (βb p)) 1
    (weylE_isWeight (βb p) (hbs p (by omega)) (hn p (by omega))) (weylE_sq p hp)

/-- The entries of `weylE (βb p)`: `A - C` within a factor, `-C` across. -/
theorem weylE_val (p : ℕ) (a b : Fin (2 * p)) (hab : a ≠ b) :
    weylE (βb p) a b = if βb p a = βb p b then 1 / ((p : ℝ) - 1) - 1 / (2 * (p : ℝ) - 1)
      else -(1 / (2 * (p : ℝ) - 1)) := by
  unfold weylE
  simp only [Matrix.of_apply, if_neg hab, bs_bal, Fintype.card_fin]
  push_cast
  rfl

theorem inner2_zero_self {n : ℕ} : inner2 (0 : Matrix (Fin n) (Fin n) ℝ) 0 = 0 := by
  simp [inner2_eq_sum]

open HamiltonsCubic.EigenFrameExist HamiltonsCubic.SecondKind

/-- **Every eigenvalue lies in `[-C, A - C]`.** -/
theorem ev_bounds (p : ℕ) (hp : 3 ≤ p) (j : Pairs (2 * p)) :
    let hW := Wb_isWeylOp p (by omega);
    -(1 / (2 * (p : ℝ) - 1)) ≤ (Mpair_isHermitian (Wb p) hW.1 hW.2.1 hW.2.2.1).eigenvalues j ∧
      (Mpair_isHermitian (Wb p) hW.1 hW.2.1 hW.2.2.1).eigenvalues j
        ≤ 1 / ((p : ℝ) - 1) - 1 / (2 * (p : ℝ) - 1) := by
  intro hW
  have hf := eigenFrame_exists (Wb p) hW.1 hW.2.1 hW.2.2.1
  have hne : frameVec (Wb p) hW.1 hW.2.1 hW.2.2.1 j ≠ 0 := by
    intro h
    have := hf.orthonormal j j
    rw [if_pos rfl, h, inner2_zero_self] at this
    norm_num at this
  obtain ⟨a, b, hab, he⟩ := diagOp_eigen_entry (weylE (βb p)) _ (hf.skew j) hne _ (hf.eigen j)
  rw [he, weylE_val p a b hab]
  have hpR : (3 : ℝ) ≤ p := by exact_mod_cast hp
  have h1 : 0 < (p : ℝ) - 1 := by linarith
  have h2 : 0 < 2 * (p : ℝ) - 1 := by linarith
  have hlt : 1 / (2 * (p : ℝ) - 1) < 1 / ((p : ℝ) - 1) :=
    one_div_lt_one_div_of_lt h1 (by linarith)
  have hpos : 0 < 1 / (2 * (p : ℝ) - 1) := by positivity
  split_ifs <;> constructor <;> linarith

/-- **`-C` is an eigenvalue**, carried by `φ_{0p}` across the two factors. -/
theorem ev_attains (p : ℕ) (hp : 3 ≤ p) :
    let hW := Wb_isWeylOp p (by omega);
    ∃ j, (Mpair_isHermitian (Wb p) hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -(1 / (2 * (p : ℝ) - 1)) := by
  intro hW
  have hf := eigenFrame_exists (Wb p) hW.1 hW.2.1 hW.2.2.1
  set v := frameVec (Wb p) hW.1 hW.2.1 hW.2.2.1
  set ev := (Mpair_isHermitian (Wb p) hW.1 hW.2.1 hW.2.2.1).eigenvalues
  set i0 : Fin (2 * p) := ⟨0, by omega⟩
  set ip : Fin (2 * p) := ⟨p, by omega⟩
  have hne : i0 ≠ ip := by intro h; have := congrArg Fin.val h; simp [i0, ip] at this; omega
  have hβ : βb p i0 ≠ βb p ip := by simp [βb, i0, ip]; omega
  set X := phi i0 ip
  have hX : IsSkew X := phi_isSkew i0 ip
  have hsym := (weylE_isWeight (βb p) (hbs p (by omega)) (hn p (by omega))).symm
  have hWX : Wb p X = (-(1 / (2 * (p : ℝ) - 1))) • X := by
    show diagOp (weylE (βb p)) (phi i0 ip) = _
    rw [diagOp_phi _ hsym, weylE_val p i0 ip hne, if_neg hβ]
  have hX0 : X ≠ 0 := by
    intro h
    have := congrFun (congrFun h i0) ip
    simp [X, phi, Matrix.sub_apply, hne, Ne.symm hne] at this
  by_contra hno
  push Not at hno
  have hc : ∀ j, inner2 X (v j) = 0 := by
    intro j
    have e1 : inner2 (Wb p X) (v j) = inner2 X (Wb p (v j)) := hW.2.2.1 X (v j) hX (hf.skew j)
    rw [hWX, hf.eigen j, FamilyLayer.inner2_smul_left, inner2_comm X (ev j • v j),
      FamilyLayer.inner2_smul_left, inner2_comm (v j) X] at e1
    have : (ev j + 1 / (2 * (p : ℝ) - 1)) * inner2 X (v j) = 0 := by linarith
    rcases mul_eq_zero.mp this with h | h
    · exact absurd (by linarith : ev j = -(1 / (2 * (p : ℝ) - 1))) (hno j)
    · exact h
  have := hf.complete X hX
  simp only [hc, zero_smul, Finset.sum_const_zero] at this
  exact hX0 this

/-- **`L71_saturated` is not vacuous**: at every `p ≥ 3`, the balanced sphere product on `ℝ^{2p}`
meets all of its hypotheses, with `θ = 1`, `λ_min = -1/(2p-1)` and `λ_max = 1/(p-1) - 1/(2p-1)`. -/
theorem L71_nonvacuous (p : ℕ) (hp : 3 ≤ p) :
    ∃ (W : Matrix (Fin (2 * p)) (Fin (2 * p)) ℝ → Matrix (Fin (2 * p)) (Fin (2 * p)) ℝ)
      (hW : IsWeylOp W) (θ lmin lmax : ℝ),
      IsCritical W θ ∧ lmin < 0 ∧ 0 < lmax ∧
      (∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j) ∧
      (∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax) ∧
      θ = lmin + (((2 * p : ℕ) : ℝ) - 2) * lmax ∧
      ∃ γ, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin := by
  have hpR : (3 : ℝ) ≤ p := by exact_mod_cast hp
  have h1 : 0 < (p : ℝ) - 1 := by linarith
  have h2 : 0 < 2 * (p : ℝ) - 1 := by linarith
  refine ⟨Wb p, Wb_isWeylOp p (by omega), 1, -(1 / (2 * (p : ℝ) - 1)),
    1 / ((p : ℝ) - 1) - 1 / (2 * (p : ℝ) - 1), Wb_critical p hp, ?_, ?_,
    fun j => (ev_bounds p hp j).1, fun j => (ev_bounds p hp j).2, ?_, ev_attains p hp⟩
  · have : 0 < 1 / (2 * (p : ℝ) - 1) := by positivity
    linarith
  · have : 1 / (2 * (p : ℝ) - 1) < 1 / ((p : ℝ) - 1) := one_div_lt_one_div_of_lt h1 (by linarith)
    linarith
  · push_cast
    field_simp
    ring

/-- **And its conclusion holds there**: the balanced sphere product's extreme eigenspaces form a
symmetric pair. -/
theorem L71_witness (p : ℕ) (hp : 3 ≤ p) :
    let hW := Wb_isWeylOp p (by omega);
    let v := frameVec (Wb p) hW.1 hW.2.1 hW.2.2.1;
    let ev := (Mpair_isHermitian (Wb p) hW.1 hW.2.1 hW.2.2.1).eigenvalues;
    let lmin := -(1 / (2 * (p : ℝ) - 1));
    let lmax := 1 / ((p : ℝ) - 1) - 1 / (2 * (p : ℝ) - 1);
    L71Sat.spanOf v (fun k => ev k ≠ lmin ∧ ev k ≠ lmax) = ⊥ ∧
      L71Sat.spanOf v (fun k => ev k = lmax) = L71Statement.brackets (L71Sat.spanOf v (fun k => ev k = lmin)) ∧
      (∀ x ∈ L71Sat.spanOf v (fun k => ev k = lmax), ∀ y ∈ L71Sat.spanOf v (fun k => ev k = lmax),
        L71Statement.br x y ∈ L71Sat.spanOf v (fun k => ev k = lmax)) := by
  intro hW v ev lmin lmax
  have hpR : (3 : ℝ) ≤ p := by exact_mod_cast hp
  have h1 : 0 < (p : ℝ) - 1 := by linarith
  have h2 : 0 < 2 * (p : ℝ) - 1 := by linarith
  refine L71Sat.L71_saturated (n := 2 * p) (by omega) (Wb p) hW 1 (Wb_critical p hp) lmin lmax ?_ ?_
    (fun j => (ev_bounds p hp j).1) (fun j => (ev_bounds p hp j).2) ?_ (ev_attains p hp)
  · have : 0 < 1 / (2 * (p : ℝ) - 1) := by positivity
    simp only [lmin]; linarith
  · have : 1 / (2 * (p : ℝ) - 1) < 1 / ((p : ℝ) - 1) := one_div_lt_one_div_of_lt h1 (by linarith)
    simp only [lmax]; linarith
  · simp only [lmin, lmax]
    push_cast
    field_simp
    ring

end HamiltonsCubic.L71Witness
