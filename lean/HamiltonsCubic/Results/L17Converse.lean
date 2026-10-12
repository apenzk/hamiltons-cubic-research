import HamiltonsCubic.Results.L17Phi
import HamiltonsCubic.Results.L17Cone

set_option linter.style.longLine false

/-!
# L17's "exactly those `n`": the converse

[route-a.md](../../../findings/route-a.md), Lemma L17: *`d⁺Φ(u; H) = 2aκₙF(H) ≤ 0` for exactly those `n` with
`κₙ ≤ 0`, which is `n ≥ 12`.* [L17Phi.lean](L17Phi.lean)'s `L17_ge12` is the direction `n ≥ 12`. **`L17_converse`** is
the other: for `4 ≤ n ≤ 11` some tangent `H ∈ 𝒲ₙ` has `d⁺Φ(u; H) > 0`.

- `kappaPen_pos`: `κₙ = 9(√(3/2) − Θₙ) > 0` at `4 ≤ n ≤ 11`, from `Θₙ² < 3/2` there;
- `Wb`, the padded `ℂP̄²` Weyl tensor, `(2, −1, −1)/√6` on the unit anti-self-dual bivectors, with `Wb_weyl`
  (skew, symmetric, first Bianchi and Ricci-flat, the last two from integer identities checked by `decide`:
  the three anti-self-dual forms share one cyclic sum and one Gram matrix);
- `opB_Wb` reads it in the model, `Wb_tangent` gives `⟨W_{ℂP̄²}, u⟩ = 0`, and `Wb_F_pos` gives `F > 0` through
  [L17Cone.lean](L17Cone.lean)'s `F_eq_zero_iff`: `P₀ W P₀` does not vanish on `a'`.
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer HamiltonsCubic.SpectralFn HamiltonsCubic.BivModel
  HamiltonsCubic.DefectCP2

variable {n : ℕ}

/-! ## `κₙ > 0` below `12` -/

theorem ThetaSq_lt (n : ℕ) (h4 : 4 ≤ n) (h12 : n < 12) : L16Statement.ThetaSq n < 3 / 2 := by
  unfold L16Statement.ThetaSq
  interval_cases n <;> norm_num

theorem ThetaSq_nonneg (n : ℕ) (h4 : 4 ≤ n) : 0 ≤ L16Statement.ThetaSq n := by
  have hn : (4 : ℝ) ≤ n := by exact_mod_cast h4
  unfold L16Statement.ThetaSq
  split_ifs
  · apply div_nonneg _ (by positivity)
    nlinarith
  · apply div_nonneg
    · have h1 : 0 ≤ (n : ℝ) - 1 := by linarith
      have h3 : 0 ≤ (n : ℝ) - 3 := by linarith
      positivity
    · have h2 : 0 ≤ (n : ℝ) - 2 := by linarith
      positivity

/-- **`κₙ > 0` for `4 ≤ n ≤ 11`.** -/
theorem kappaPen_pos (n : ℕ) (h4 : 4 ≤ n) (h12 : n < 12) : 0 < L16Statement.kappaPen n := by
  unfold L16Statement.kappaPen L16Statement.Theta
  have := Real.sqrt_lt_sqrt (ThetaSq_nonneg n h4) (ThetaSq_lt n h4 h12)
  linarith

/-! ## The padded `ℂP²`-bar Weyl tensor -/

/-- The anti-self-dual bivectors `a', b', c'`, padded and unnormalised (`‖Ω‖² = 2`). -/
noncomputable def Om (a : Fin 3) : Matrix (Fin n) (Fin n) ℝ := pad (om6 ⟨a.val + 3, by omega⟩)

theorem Om_skew (a : Fin 3) : IsSkew (Om (n := n) a) := pad_skew _ (om6_skew _)

/-- **`W_{ℂP̄²}`**: coefficients `(2, −1, −1)/√6` on the anti-self-dual unit bivectors `Ω_a/√2`. -/
noncomputable def Wb (n : ℕ) (X : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  ∑ a, (CP2Real.mu a / 2 * inner2 X (Om a)) • Om a

theorem Wb_inner (X Y : Matrix (Fin n) (Fin n) ℝ) :
    inner2 (Wb n X) Y = ∑ a, CP2Real.mu a / 2 * inner2 X (Om a) * inner2 (Om a) Y := by
  unfold Wb
  rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
  exact Finset.sum_congr rfl fun a _ => by rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l]

theorem cycZ_indep (a : Fin 3) (i j k l : Fin 4) :
    om6Z ⟨a.val + 3, by omega⟩ i j * om6Z ⟨a.val + 3, by omega⟩ k l +
      om6Z ⟨a.val + 3, by omega⟩ i k * om6Z ⟨a.val + 3, by omega⟩ l j +
      om6Z ⟨a.val + 3, by omega⟩ i l * om6Z ⟨a.val + 3, by omega⟩ j k =
    om6Z 3 i j * om6Z 3 k l + om6Z 3 i k * om6Z 3 l j + om6Z 3 i l * om6Z 3 j k := by
  fin_cases a <;> revert i j k l <;> decide

theorem gramZ_indep (a : Fin 3) (x y : Fin 4) :
    ∑ c, om6Z ⟨a.val + 3, by omega⟩ x c * om6Z ⟨a.val + 3, by omega⟩ y c = ∑ c, om6Z 3 x c * om6Z 3 y c := by
  fin_cases a <;> revert x y <;> decide

theorem mu_sum' : CP2Real.mu 0 + CP2Real.mu 1 + CP2Real.mu 2 = 0 := by
  have := CP2Real.mu_sum; rwa [Fin.sum_univ_three] at this

theorem Om_block (a : Fin 3) (x y : Fin n) (hx : x.val < 4) (hy : y.val < 4) :
    Om (n := n) a x y = ((om6Z ⟨a.val + 3, by omega⟩ ⟨x.val, hx⟩ ⟨y.val, hy⟩ : ℤ) : ℝ) := by
  rw [Om, pad_apply _ _ _ ⟨hx, hy⟩, om6_eq_cast]

theorem Om_off (a : Fin 3) (x y : Fin n) (h : ¬(x.val < 4 ∧ y.val < 4)) : Om (n := n) a x y = 0 :=
  pad_zero _ _ _ h

/-- The cyclic sum of `Ω_a` does not depend on `a`. -/
theorem cyc_Om (a : Fin 3) (i j k l : Fin n) :
    Om (n := n) a i j * Om a k l + Om a i k * Om a l j + Om a i l * Om a j k =
      Om (n := n) 0 i j * Om 0 k l + Om 0 i k * Om 0 l j + Om 0 i l * Om 0 j k := by
  by_cases hb : i.val < 4 ∧ j.val < 4 ∧ k.val < 4 ∧ l.val < 4
  · obtain ⟨hi, hj, hk, hl⟩ := hb
    simp only [Om_block _ _ _ hi hj, Om_block _ _ _ hk hl, Om_block _ _ _ hi hk, Om_block _ _ _ hl hj,
      Om_block _ _ _ hi hl, Om_block _ _ _ hj hk]
    have ha := cycZ_indep a ⟨i.val, hi⟩ ⟨j.val, hj⟩ ⟨k.val, hk⟩ ⟨l.val, hl⟩
    have h0 := cycZ_indep 0 ⟨i.val, hi⟩ ⟨j.val, hj⟩ ⟨k.val, hk⟩ ⟨l.val, hl⟩
    exact_mod_cast ha.trans h0.symm
  · rcases not_and_or.mp hb with hi | hb'
    · simp [Om_off _ i _ (fun h => hi h.1)]
    rcases not_and_or.mp hb' with hj | hb''
    · simp [Om_off _ i j (fun h => hj h.2), Om_off _ l j (fun h => hj h.2), Om_off _ j k (fun h => hj h.1)]
    rcases not_and_or.mp hb'' with hk | hl
    · simp [Om_off _ k l (fun h => hk h.1), Om_off _ i k (fun h => hk h.2), Om_off _ j k (fun h => hk h.2)]
    · simp [Om_off _ k l (fun h => hl h.2), Om_off _ l j (fun h => hl h.1), Om_off _ i l (fun h => hl h.2)]

/-- The Gram matrix of `Ω_a` does not depend on `a`. -/
theorem gram_Om (hn : 4 ≤ n) (a : Fin 3) (x y : Fin n) :
    ∑ c, Om (n := n) a x c * Om a y c = ∑ c, Om (n := n) 0 x c * Om 0 y c := by
  by_cases hb : x.val < 4 ∧ y.val < 4
  · obtain ⟨hx, hy⟩ := hb
    rw [sum_pad hn _ fun c hc => by rw [Om_off _ x c (fun h => by omega), zero_mul],
      sum_pad hn _ fun c hc => by rw [Om_off _ x c (fun h => by omega), zero_mul]]
    have e : ∀ α : Fin 3, (∑ c : Fin 4, Om (n := n) α x ⟨c.val, by omega⟩ * Om α y ⟨c.val, by omega⟩) =
        ((∑ c : Fin 4, om6Z ⟨α.val + 3, by omega⟩ ⟨x.val, hx⟩ c * om6Z ⟨α.val + 3, by omega⟩ ⟨y.val, hy⟩ c : ℤ) : ℝ) := by
      intro α
      push_cast
      exact Finset.sum_congr rfl fun c _ => by rw [Om_block _ _ _ hx c.isLt, Om_block _ _ _ hy c.isLt]
    rw [e a, e 0, gramZ_indep a, gramZ_indep 0]
  · rcases not_and_or.mp hb with hx | hy
    · simp [Om_off _ x _ (fun h => hx h.1)]
    · simp [Om_off _ y _ (fun h => hy h.1)]

theorem Wb_entry (i j k l : Fin n) :
    inner2 (Wb n (phi i j)) (phi k l) = ∑ a, CP2Real.mu a / 2 * (Om (n := n) a i j * Om a k l) := by
  rw [Wb_inner]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [inner2_comm (phi i j), inner2_phi _ (Om_skew a), inner2_phi _ (Om_skew a)]
  ring

/-- **`W_{ℂP̄²}` is a Weyl operator.** -/
theorem Wb_weyl (hn : 4 ≤ n) : IsWeyl (Wb n) := by
  refine ⟨fun X _ => ?_, fun X Y _ _ => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · unfold Wb
    exact HamiltonsCubic.L41Statement.Frame.isSkew_sum _ _ _ fun a => Om_skew a
  · rw [Wb_inner, inner2_comm X, Wb_inner]
    exact Finset.sum_congr rfl fun a _ => by rw [inner2_comm (Om a) Y, inner2_comm X (Om a)]; ring
  · unfold bianchi
    rw [Wb_entry, Wb_entry, Wb_entry, ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    calc _ = ∑ a, CP2Real.mu a / 2 *
          (Om (n := n) 0 i j * Om 0 k l + Om 0 i k * Om 0 l j + Om 0 i l * Om 0 j k) :=
          Finset.sum_congr rfl fun a _ => by rw [← cyc_Om a]; ring
      _ = 0 := by rw [← Finset.sum_mul, Fin.sum_univ_three]; have := mu_sum'; rw [show CP2Real.mu 0 / 2 +
          CP2Real.mu 1 / 2 + CP2Real.mu 2 / 2 = 0 by linarith, zero_mul]
  · unfold Ric
    simp only [Wb_entry]
    rw [Finset.sum_comm]
    calc _ = ∑ α, CP2Real.mu α / 2 * ∑ c, Om (n := n) 0 a c * Om 0 b c :=
          Finset.sum_congr rfl fun α _ => by rw [← gram_Om hn α, Finset.mul_sum]
      _ = 0 := by rw [← Finset.sum_mul, Fin.sum_univ_three]; have := mu_sum'; rw [show CP2Real.mu 0 / 2 +
          CP2Real.mu 1 / 2 + CP2Real.mu 2 / 2 = 0 by linarith, zero_mul]

/-! ## The witness in the model -/

/-- Its coefficients on the unit bivectors: `0` on the self-dual ones, `(2, −1, −1)/√6` on the rest. -/
noncomputable def lamBar : Fin 6 → ℝ := ![0, 0, 0, 2 / Real.sqrt 6, -1 / Real.sqrt 6, -1 / Real.sqrt 6]

theorem coords_Om (a : Fin 3) : coords (Om (n := n) a) = Real.sqrt 2 • vec ⟨a.val + 3, by omega⟩ := by
  rw [vec, smul_smul, mul_inv_cancel₀ (by positivity), one_smul, Om]

theorem opB_Wb (hn : 4 ≤ n) : opB (restrict (Wb_weyl hn)) = rankSum lamBar (vec (n := n)) := by
  refine LinearMap.ext fun c => ?_
  rw [opB_apply]
  change coords (Wb n (toSkew c : Matrix (Fin n) (Fin n) ℝ)) = _
  unfold Wb
  rw [← coordsL_apply, map_sum, rankSum_apply, Fin.sum_univ_six, Fin.sum_univ_three]
  simp only [map_smul, coordsL_apply, coords_Om]
  have hi : ∀ a : Fin 3, inner2 ((toSkew c : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) (Om a) =
      Real.sqrt 2 * inner ℝ (vec ⟨a.val + 3, by omega⟩) c := fun a => by
    rw [← inner_coords (toSkew c).2 (Om_skew a), coords_toSkew, coords_Om, real_inner_smul_right, real_inner_comm]
  simp only [hi, smul_smul]
  have h2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
  have e0 : vec (n := n) ⟨(0 : Fin 3).val + 3, by omega⟩ = vec 3 := rfl
  have e1 : vec (n := n) ⟨(1 : Fin 3).val + 3, by omega⟩ = vec 4 := rfl
  have e2 : vec (n := n) ⟨(2 : Fin 3).val + 3, by omega⟩ = vec 5 := rfl
  rw [e0, e1, e2]
  simp only [lamBar, CP2Real.mu, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val, zero_mul, zero_smul,
    zero_add, neg_div]
  congr 1
  · congr 1
    · congr 1; linear_combination (2 / Real.sqrt 6 / 2 * inner ℝ (vec 3) c) * h2
    · congr 1; linear_combination (-(1 / Real.sqrt 6) / 2 * inner ℝ (vec 4) c) * h2
  · congr 1; linear_combination (-(1 / Real.sqrt 6) / 2 * inner ℝ (vec 5) c) * h2

/-- **The witness is tangent to `u`.** -/
theorem Wb_tangent (hn : 4 ≤ n) : innerOp2 (restrict (Wb_weyl hn)) (u2 hn) = 0 := by
  rw [innerOp2_eq_trace (TensorBridge.isSelfAdjoint2_restrict (Wb_weyl hn)), opB_Wb hn, opB_u2 hn, uOp,
    trace_comp_rankSum, Fin.sum_univ_six]
  simp only [rankSum_vec hn, real_inner_smul_right, real_inner_self_eq_norm_sq,
    (vec_orthonormal hn).1 _, one_pow, mul_one, lam6, lamBar, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.cons_val, mul_zero, zero_mul, add_zero]

/-! ## `𝒲ₙ ∩ T_uS` lies in the admissible class -/

/-- **Every tangent Weyl operator is admissible** in the model: symmetric, `Alt = 0` and tangent. -/
theorem admissible_opB (hn : 4 ≤ n) {H : CurvOp2 (Fin n)} (hH : IsWeyl2 H) (hT : innerOp2 H (u2 hn) = 0) :
    Admissible (opB H) where
  symm := opB_isSymmetric hH.selfAdjoint
  bianchi := alt4_opB_eq_zero hH
  tangent := by rw [← opB_u2 hn, ← innerOp2_eq_trace hH.selfAdjoint, hT]

/-- **`F(W_{ℂP̄²}) > 0`**: its kernel compression does not vanish on the anti-self-dual bivectors. -/
theorem Wb_F_pos (hn : 4 ≤ n) {N : ℕ} (hN : finrank ℝ (Biv n) = N) :
    0 < Fval hN (opB_isSymmetric (TensorBridge.isSelfAdjoint2_restrict (Wb_weyl (n := n) hn))) := by
  set H := opB (restrict (Wb_weyl (n := n) hn)) with hHdef
  have hA := admissible_opB hn (isWeyl2_restrict (Wb_weyl hn)) (Wb_tangent hn)
  have hHs : H.IsSymmetric := hA.symm
  have hB : alt4 (compOf H) = 0 := hA.bianchi
  have hT : LinearMap.trace ℝ (Biv n) (H ∘ₗ uOp) = 0 := hA.tangent
  have hW : ∀ t : ℝ, (uOp + t • H).IsSymmetric := fun t x y => by
    simp only [LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_add_right, real_inner_smul_left,
      real_inner_smul_right, uOp_isSymmetric x y, hHs x y]
  obtain ⟨-, -, hle⟩ := L17_at_u hN hn hHs hB hT hW
  have ha : 0 < 1 / (3 * Real.sqrt 6) := by positivity
  have hnn : 0 ≤ Fval hN hHs := by unfold Fval; nlinarith
  refine lt_of_le_of_ne hnn fun h0 => ?_
  have h := (F_eq_zero_iff hN hn hHs hB hT).mp h0.symm 0
  have hi := inner_schur_eigen₂ hN uOp_isSymmetric zeroφ H (uOp_asd hn 0) (uOp_asd hn 0)
  rw [h, inner_zero_right] at hi
  have hv : inner ℝ (asd (n := n) 0) (H (asd 0)) = 2 / Real.sqrt 6 := by
    change inner ℝ (vec 3) (H (vec 3)) = _
    rw [hHdef, opB_Wb hn, rankSum_vec hn, real_inner_smul_right, real_inner_self_eq_norm_sq, (vec_orthonormal hn).1 _]
    simp [lamBar]
  rw [hv] at hi
  simp [zeroφ] at hi
  have : 0 < 2 / Real.sqrt 6 := by positivity
  linarith

/-! ## The converse -/

/-- **L17's "exactly those `n`", the converse half.** For `4 ≤ n ≤ 11` there is a tangent `H ∈ 𝒲ₙ`, the padded
`ℂP̄²` Weyl tensor, along which `Φ = P − κₙ δ²` increases to first order: `d⁺Φ(u; H) > 0`. With `L17_ge12` this is
the lemma's claim that the protection holds for exactly the `n ≥ 12`. -/
theorem L17_converse (h4 : 4 ≤ n) (h12 : n < 12) {N : ℕ} (hN : finrank ℝ (Biv n) = N) :
    ∃ (H : CurvOp2 (Fin n)) (hH : IsWeyl2 H), innerOp2 H (u2 h4) = 0 ∧ ∃ d : ℝ, 0 < d ∧
      HasDerivWithinAt
        (fun t => Pcubic2 (u2 h4 + t • H) -
          L16Statement.kappaPen n * altNormSqOf (specFn hN negPartScalar (opB_path_isSymmetric h4 hH.selfAdjoint t)))
        d (Set.Ici 0) 0 := by
  refine ⟨restrict (Wb_weyl h4), isWeyl2_restrict (Wb_weyl h4), Wb_tangent h4, ?_⟩
  obtain ⟨hd, -⟩ := L17 h4 hN (isWeyl2_restrict (Wb_weyl h4)) (Wb_tangent h4) (L16Statement.kappaPen n)
  refine ⟨_, ?_, hd⟩
  have hF := Wb_F_pos h4 hN
  have hk := kappaPen_pos n h4 h12
  have ha : 0 < 1 / (3 * Real.sqrt 6) := by positivity
  unfold Fval at hF
  positivity

end HamiltonsCubic.L17Deriv
