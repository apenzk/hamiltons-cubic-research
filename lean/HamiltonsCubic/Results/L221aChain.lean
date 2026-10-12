import Mathlib
import HamiltonsCubic.Results.FourL220
import HamiltonsCubic.Results.FourEq
import HamiltonsCubic.Results.L221a
import HamiltonsCubic.Results.L27Main

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L221 (a) on the operators: `θ ≤ √(3/2)` on disjoint four-set families

[findings/second-order.md](../../../findings/second-order.md), Lemma L221 (a): *If $Q_1,\dots,Q_m$ are pairwise disjoint four-sets,
every unit critical point of $P$ in $\mathcal D_n\oplus V_{Q_1}\oplus\cdots\oplus V_{Q_m}$ with some nonzero block component has
$\theta\le\sqrt{3/2}$.* The proof runs L220's steps 3 to 9 on one block $V_{Q_i}$ with $\nu_i\ne0$: step 6 gains the terms
$\langle\nu_j\circ\nu_j,q_i\rangle$, which vanish since $\nu_j\circ\nu_j\in\Pi_{Q_j}\perp\Pi_{Q_i}$, and step 9 runs with
$\lVert r_i\rVert^2\le1-\tfrac{\theta^2}3-\lVert\nu_i\rVert^2$.

* `step6_extra`, **`L220_bound_extra`**: [FourL220.lean](FourL220.lean)'s chain with an extra term `E` in the `𝒟ₙ` equation,
  orthogonal to `Π_Q`, and the unit norm weakened to `‖D‖² + ‖ν‖² ≤ 1`;
* `PiQ_zero_off`, `PiQ_orth`: `Π_Q ⊥ Π_{Q'}` at disjoint four-sets;
* **`nunu_orth`**: `ν' ∘ ν' ∈ Π_{Q'}` for `ν'` of character `χ_{Q'}` (`Q_nu`), so it is orthogonal to `Π_Q`;
* **`L221a_bound`**: L221 (a), `θ² ≤ 3/2`, through `L221a_split` and the character orthogonality of the components.
-/

namespace HamiltonsCubic.L221aChain

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.FourStep5 HamiltonsCubic.FrameOp2
  HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Cubic HamiltonsCubic.ItemFour HamiltonsCubic.PairNorm
  HamiltonsCubic.L224Rank HamiltonsCubic.FourStep67 HamiltonsCubic.FourStep8 HamiltonsCubic.BlockSub HamiltonsCubic.FourL220

variable {n : ℕ} {i j k l : Fin n}

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **Step 6 with an extra term** `E ⊥ Π_Q` in the `𝒟ₙ` equation. -/
theorem step6_extra {x y z θ : ℝ} (hs : x + y + z = 0) {r ν E : CurvOp2 (Fin n)} (hrW : IsWeyl2 r)
    (hperp : ∀ a b c : ℝ, a + b + c = 0 → innerOp2 r (coordOp (PiQ i j k l a b c)) = 0)
    (hνW : IsWeyl2 ν)
    (hsplit : foxProd2 (coordOp (PiQ i j k l x y z) + r) (coordOp (PiQ i j k l x y z) + r) + foxProd2 ν ν + E
      = θ • (coordOp (PiQ i j k l x y z) + r))
    (hE : innerOp2 E (coordOp (PiQ i j k l x y z)) = 0)
    (heig : (2 : ℝ) • foxProd2 (coordOp (PiQ i j k l x y z)) ν = θ • ν) :
    Pcubic2 (coordOp (PiQ i j k l x y z)) + innerOp2 (foxProd2 r r) (coordOp (PiQ i j k l x y z))
      + θ / 2 * normSq2 ν = θ * normSq2 (coordOp (PiQ i j k l x y z)) := by
  set q := coordOp (PiQ i j k l x y z) with hqdef
  have hqW : IsWeyl2 q := by
    rw [hqdef, coordOp_eq_restrict (PiQ_weight hij hik hil hjk hjl hkl hs)]; exact isWeyl2_restrict _
  have hqs := hqW.isSelfAdjoint2
  have hrs := hrW.isSelfAdjoint2
  have hνs := hνW.isSelfAdjoint2
  have hqq : foxProd2 q q = coordOp (PiQ i j k l (x * x + y * z + z * y) (y * y + z * x + x * z) (z * z + x * y + y * x)) :=
    PiQ_mul hij hik hil hjk hjl hkl x y z x y z
  have hqrq : innerOp2 (foxProd2 q r) q = 0 := by
    rw [foxProd2_comm, inner_fox_move hrs hqs hqs, hqq]
    exact hperp _ _ _ (PiQ_closed hs hs)
  have hνν : innerOp2 (foxProd2 ν ν) q = θ / 2 * normSq2 ν := by
    rw [innerOp2_comm, ← inner_fox_move hqs hνs hνs]
    have : foxProd2 q ν = (θ / 2) • ν := by
      have h2 := congrArg (fun T => (1 / 2 : ℝ) • T) heig
      simp only [smul_smul] at h2
      rw [show (1 / 2 : ℝ) * 2 = 1 by norm_num, one_smul, show 1 / 2 * θ = θ / 2 by ring] at h2
      exact h2
    rw [this, innerOp2_smul_left]; rfl
  have hrq : innerOp2 r q = 0 := hperp x y z hs
  have hP : Pcubic2 q = innerOp2 (foxProd2 q q) q := by
    rw [Pcubic2_eq_innerOp2, ← foxProd2_self, innerOp2_comm]
  have hpair := congrArg (fun T => innerOp2 T q) hsplit
  simp only [innerOp2_add_left, innerOp2_smul_left, hE, hrq, add_zero] at hpair
  have hDD : foxProd2 (q + r) (q + r) = foxProd2 q q + (2 : ℝ) • foxProd2 q r + foxProd2 r r := by
    rw [foxProd2_self, L219Prod.Qop2_add, foxProd2_self, foxProd2_self]; abel
  rw [hDD, innerOp2_add_left, innerOp2_add_left, innerOp2_smul_left, hqrq, hνν, ← hP] at hpair
  unfold normSq2 at hpair ⊢
  linarith

/-- **L220's bound with an extra term and a weakened norm**: `θ² ≤ 3/2` when `D ∘ D + ν ∘ ν + E = θ D` with `E ⊥ Π_Q`,
`2 D ∘ ν = θ ν`, and `‖D‖² + ‖ν‖² ≤ 1`. -/
theorem L220_bound_extra {D ν E : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D) (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {θ : ℝ} (hθ : 0 < θ)
    (hE : ∀ a b c : ℝ, a + b + c = 0 → innerOp2 E (coordOp (PiQ i j k l a b c)) = 0)
    (hsplit : foxProd2 D D + foxProd2 ν ν + E = θ • D) (hDν : (2 : ℝ) • foxProd2 D ν = θ • ν)
    (hnorm : normSq2 D + normSq2 ν ≤ 1) : θ ^ 2 ≤ 3 / 2 := by
  obtain ⟨x, y, z, r, hs, rfl, hrW, hr, hperp⟩ := proj_PiQ hij hik hil hjk hjl hkl hDW hD
  have heig := Lq_eigen hij hik hil hjk hjl hkl hrW hr hperp hνW hν hDν
  have h5 := step5 hij hik hil hjk hjl hkl hs hνW hν hν0 heig
  have h6 := step6_extra hij hik hil hjk hjl hkl hs hrW hperp hνW hsplit (hE x y z hs) heig
  have h7 := step7 hij hik hil hjk hjl hkl hs hθ.le h5.symm
  have h8 := step8 hij hik hil hjk hjl hkl hs hθ.le h5.symm hrW hr hperp
  have hqr : normSq2 (coordOp (PiQ i j k l x y z) + r) = normSq2 (coordOp (PiQ i j k l x y z)) + normSq2 r := by
    unfold normSq2
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm (coordOp (PiQ i j k l x y z)) r,
      hperp x y z hs]
    ring
  rw [hqr] at hnorm
  have hR := normSq2_nonneg r
  have hN := normSq2_nonneg ν
  have hκ : 3 * innerOp2 (foxProd2 r r) (coordOp (PiQ i j k l x y z))
      ≤ θ * (1 - normSq2 (coordOp (PiQ i j k l x y z)) - normSq2 ν) := by
    have : θ * normSq2 r ≤ θ * (1 - normSq2 (coordOp (PiQ i j k l x y z)) - normSq2 ν) :=
      mul_le_mul_of_nonneg_left (by linarith) hθ.le
    linarith
  exact HamiltonsCubic.L220Statement.theta_sq_le θ _ (1 - normSq2 (coordOp (PiQ i j k l x y z)) - normSq2 ν) _ _ _ hθ
    (by linarith) hN (by ring) h5.symm (by linarith) h7 hκ

end

/-- `Π_Q` vanishes on a row outside `Q`. -/
theorem PiQ_zero_off {a : Fin n} (ha : a ∉ ({i, j, k, l} : Finset (Fin n))) (x y z : ℝ) (b : Fin n) :
    PiQ i j k l x y z a b = 0 := by
  simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at ha
  obtain ⟨h1, h2, h3, h4⟩ := ha
  simp [PiQ, E2, Matrix.vecMulVec_apply, Pi.single_apply, h1, h2, h3, h4]

/-- `Π_Q` vanishes on a column outside `Q`. -/
theorem PiQ_zero_off' {b : Fin n} (hb : b ∉ ({i, j, k, l} : Finset (Fin n))) (x y z : ℝ) (a : Fin n) :
    PiQ i j k l x y z a b = 0 := by
  simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hb
  obtain ⟨h1, h2, h3, h4⟩ := hb
  simp [PiQ, E2, Matrix.vecMulVec_apply, Pi.single_apply, h1, h2, h3, h4]

theorem PiQ_transpose (x y z : ℝ) : (PiQ i j k l x y z)ᵀ = PiQ i j k l x y z := by
  ext a b
  simp only [Matrix.transpose_apply, PiQ, E2, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul]
  ring

/-- **`Π_Q ⊥ Π_{Q'}` at disjoint four-sets.** -/
theorem PiQ_orth {i' j' k' l' : Fin n}
    (hdis : Disjoint ({i, j, k, l} : Finset (Fin n)) ({i', j', k', l'} : Finset (Fin n))) (x y z x' y' z' : ℝ) :
    innerOp2 (coordOp (PiQ i j k l x y z)) (coordOp (PiQ i' j' k' l' x' y' z')) = 0 := by
  rw [innerOp2_coordOp _ _ (PiQ_transpose x y z) (PiQ_transpose x' y' z')]
  refine mul_eq_zero_of_right _ (Finset.sum_eq_zero fun a _ => Finset.sum_eq_zero fun b _ => ?_)
  split_ifs
  · rfl
  · by_cases ha : a ∈ ({i, j, k, l} : Finset (Fin n))
    · rw [PiQ_zero_off (Finset.disjoint_left.mp hdis ha), mul_zero]
    · rw [PiQ_zero_off ha, zero_mul]

/-- **`ν' ∘ ν' ⊥ Π_Q`** for `ν'` of character `χ_{Q'}`, `Q'` disjoint from `Q`: `ν' ∘ ν' ∈ Π_{Q'}` (`Q_nu`). -/
theorem nunu_orth {i' j' k' l' : Fin n} (hij' : i' ≠ j') (hik' : i' ≠ k') (hil' : i' ≠ l') (hjk' : j' ≠ k')
    (hjl' : j' ≠ l') (hkl' : k' ≠ l')
    (hdis : Disjoint ({i, j, k, l} : Finset (Fin n)) ({i', j', k', l'} : Finset (Fin n)))
    {ν' : CurvOp2 (Fin n)} (hW : IsWeyl2 ν') (hν' : SignChar (setChar {i', j', k', l'}) ν') (a b c : ℝ) :
    innerOp2 (foxProd2 ν' ν') (coordOp (PiQ i j k l a b c)) = 0 := by
  obtain ⟨x, y, rfl⟩ := four_eq_sig hij' hik' hil' hjk' hjl' hkl' hW hν'
  rw [foxProd2_self, HamiltonsCubic.FourEq.Q_nu hij' hik' hil' hjk' hjl' hkl' x y, innerOp2_comm]
  exact PiQ_orth hdis _ _ _ _ _ _

/-- The flip at `a`. -/
noncomputable def flip (a : Fin n) : Fin n → ℝ := fun x => if x = a then -1 else 1

theorem flip_sq (a : Fin n) : ∀ x, flip a x * flip a x = 1 := fun x => by
  unfold flip; split_ifs <;> norm_num

theorem setChar_flip (a : Fin n) (s : Finset (Fin n)) : setChar s (flip a) = if a ∈ s then -1 else 1 := by
  unfold setChar flip
  rw [Finset.prod_ite_eq']

/-- **L221 (a) on the operators**: at pairwise disjoint four-sets `Q_1, …, Q_m`, every unit critical point
`W = D + Σ ν_i` of `P` with `D` of character `1`, `ν_i` of character `χ_{Q_i}`, some `ν_i ≠ 0` and `θ > 0` has
`θ² ≤ 3/2`. -/
theorem L221a_bound {m : ℕ} {Q : Fin m → Finset (Fin n)} (hdis : ∀ a b, a ≠ b → Disjoint (Q a) (Q b))
    (hcard : ∀ a, (Q a).card = 4) {D : CurvOp2 (Fin n)} {ν : Fin m → CurvOp2 (Fin n)} (hDW : IsWeyl2 D)
    (hD : SignChar (fun _ => 1) D) (hνW : ∀ a, IsWeyl2 (ν a)) (hν : ∀ a, SignChar (setChar (Q a)) (ν a))
    {θ : ℝ} (hθ : 0 < θ) (hQ : Qop2 (D + ∑ a, ν a) = θ • (D + ∑ a, ν a)) (hunit : normSq2 (D + ∑ a, ν a) = 1)
    (i0 : Fin m) (hi0 : ν i0 ≠ 0) : θ ^ 2 ≤ 3 / 2 := by
  obtain ⟨hsplit, hDν⟩ := HamiltonsCubic.L221a.L221a_split hdis hcard hD hν hQ
  obtain ⟨a, b, c, d, hab, hac, had, hbc, hbd, hcd, hQi⟩ := HamiltonsCubic.L27Main.card_four (hcard i0)
  have hν0' : SignChar (setChar {a, b, c, d}) (ν i0) := hQi ▸ hν i0
  have ha0 : a ∈ Q i0 := by rw [hQi]; simp
  set E := ∑ x ∈ Finset.univ.erase i0, foxProd2 (ν x) (ν x) with hEdef
  have hsum : ∑ x, foxProd2 (ν x) (ν x) = foxProd2 (ν i0) (ν i0) + E :=
    (Finset.add_sum_erase _ _ (Finset.mem_univ i0)).symm
  have hsplit' : foxProd2 D D + foxProd2 (ν i0) (ν i0) + E = θ • D := by
    rw [hsum] at hsplit
    exact (add_assoc (foxProd2 D D) _ _).trans hsplit
  have hE : ∀ x y z : ℝ, x + y + z = 0 → innerOp2 E (coordOp (PiQ a b c d x y z)) = 0 := by
    intro x y z _
    rw [innerOp2_comm, HamiltonsCubic.L120Decomp.innerOp2_sum']
    refine Finset.sum_eq_zero fun j hj => ?_
    have hj0 : j ≠ i0 := Finset.ne_of_mem_erase hj
    obtain ⟨a', b', c', d', hab', hac', had', hbc', hbd', hcd', hQj⟩ := HamiltonsCubic.L27Main.card_four (hcard j)
    have hd : Disjoint ({a, b, c, d} : Finset (Fin n)) ({a', b', c', d'} : Finset (Fin n)) := by
      rw [← hQi, ← hQj]; exact hdis i0 j (Ne.symm hj0)
    rw [innerOp2_comm]
    exact nunu_orth hab' hac' had' hbc' hbd' hcd' hd (hνW j) (hQj ▸ hν j) x y z
  -- the norm: `‖D‖² + ‖ν_{i0}‖² ≤ ‖W‖² = 1`, the components being orthogonal
  set R := ∑ x ∈ Finset.univ.erase i0, ν x with hRdef
  have hW : D + ∑ x, ν x = D + (ν i0 + R) := by rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i0)]
  have hDνi : innerOp2 D (ν i0) = 0 :=
    char_orth hD (hν i0) (flip_sq a) (by rw [setChar_flip, if_pos ha0]; norm_num)
  have hDR : innerOp2 D R = 0 := by
    rw [HamiltonsCubic.L120Decomp.innerOp2_sum']
    refine Finset.sum_eq_zero fun j _ => ?_
    obtain ⟨e, he⟩ := Finset.card_pos.mp (by rw [hcard j]; norm_num : 0 < (Q j).card)
    exact char_orth hD (hν j) (flip_sq e) (by rw [setChar_flip, if_pos he]; norm_num)
  have hνR : innerOp2 (ν i0) R = 0 := by
    rw [HamiltonsCubic.L120Decomp.innerOp2_sum']
    refine Finset.sum_eq_zero fun j hj => ?_
    have hj0 : j ≠ i0 := Finset.ne_of_mem_erase hj
    have haj : a ∉ Q j := Finset.disjoint_left.mp (hdis i0 j (Ne.symm hj0)) ha0
    exact char_orth (hν i0) (hν j) (flip_sq a) (by rw [setChar_flip, setChar_flip, if_pos ha0, if_neg haj]; norm_num)
  have hnorm : normSq2 D + normSq2 (ν i0) ≤ 1 := by
    rw [← hunit, hW]
    have hR := normSq2_nonneg R
    unfold normSq2 at hR ⊢
    simp only [innerOp2_add_left, innerOp2_add_right]
    rw [innerOp2_comm (ν i0) D, innerOp2_comm R D, innerOp2_comm R (ν i0), hDνi, hDR, hνR]
    linarith
  exact L220_bound_extra hab hac had hbc hbd hcd hDW hD (hνW i0) hν0' hi0 hθ hE hsplit' (hDν i0) hnorm

end HamiltonsCubic.L221aChain
