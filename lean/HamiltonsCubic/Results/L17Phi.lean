import HamiltonsCubic.Results.L17Close
import HamiltonsCubic.Results.FirstVariation
import HamiltonsCubic.Results.L66Positive
import HamiltonsCubic.Results.FoxBridge
import HamiltonsCubic.Results.L16Statement

set_option linter.style.longLine false

/-!
# Lemma L17 in full

[route-a.md](../../../findings/route-a.md), Lemma L17: *at the padded `ℂP²` competitor `u`, critical, and for `H ∈ 𝒲ₙ`
tangent to `u`, `d⁺Φ(u; H) = 2a κₙ F(H) ≤ 0` for exactly those `n` with `κₙ ≤ 0`, which is `n ≥ 12`.* **`L17`** proves
the identity for every real `κ` and `d⁺Φ ≤ 0` whenever `κ ≤ 0`, and **`L17_ge12`** gives `d⁺Φ ≤ 0` at `κ = κₙ` for
every `n ≥ 12`. *The converse half of "exactly", a tangent Weyl `H` with `F(H) > 0` at each `n < 12` together with
`κₙ > 0` there, is not proved here.* It joins two layers:

- **`P` on `CurvOp2`.** `u2` is CP2Real's `W_{ℂP²}` restricted to `Λ²`. `inner2_Qop2_u2` carries `Wc_crit` to
  `⟨Q(u) X, Y⟩ = √(3/2) ⟨u X, Y⟩`, so `innerOp2_Qop2_u2` gives `⟨H, Q(u)⟩ = √(3/2) ⟨H, u⟩`, and
  `hasDerivAt_Pcubic2_u2` gives `d⁺P(u; H) = 3⟨H, Q(u)⟩ = 0` for tangent `H`, through the layer's
  `hasDerivAt_Pcubic2_line`.
- **`δ²` on the bivector model.** `opB` reads a `CurvOp2` operator in the pair coordinates (`toSkew`, `coords_toSkew`,
  `toSkew_coords`). It carries self-adjointness (`opB_isSymmetric`), first Bianchi (`alt4_opB_eq_zero`) and the
  pairing (`innerOp2_eq_trace`, `⟨R, S⟩ = tr(RS)`), and **`opB_u2`** identifies the layer's competitor with the
  model's `uOp`, through `om_eq` (CP2Real's `ω_a` are the padded `a, b, c` over `√2`).

[L17Close.lean](L17Close.lean)'s `L17_at_u` then supplies `d⁺δ² = −2aF` and `F ≥ 0`, and the two derivatives
combine to `d⁺Φ = 0 − κ(−2aF) = 2aκF`. Both halves are read along the one path `u + tH`, the model's operator being
`opB (u + tH) = uOp + t opB H` (`opB_path`).
-/

namespace HamiltonsCubic.L17Deriv

open Module HamiltonsCubic.RealLayer HamiltonsCubic.CP2Real

variable {n : ℕ}

/-- The competitor as a curvature operator on `Λ²`. -/
noncomputable def u2 (hn : 4 ≤ n) : CurvOp2 (Fin n) := restrict (Wc_weyl hn)

/-- `sharpBil2` of a restriction is the layer's `sharpBil`. -/
theorem sharpBil2_restrict {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R)
    (X Y : skewSub (Fin n)) :
    sharpBil2 (restrict hW) X Y = sharpBil R (X : Matrix (Fin n) (Fin n) ℝ) (Y : Matrix (Fin n) (Fin n) ℝ) := by
  rfl

/-- **Criticality on `Λ²`**: `⟨Q(u) X, Y⟩ = √(3/2) ⟨u X, Y⟩`. -/
theorem inner2_Qop2_u2 (hn : 4 ≤ n) (X Y : skewSub (Fin n)) :
    inner2 ((Qop2 (u2 hn) X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) (Y : Matrix (Fin n) (Fin n) ℝ) =
      Real.sqrt (3 / 2) * inner2 ((u2 hn X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) Y := by
  have h := Wc_crit hn X Y X.2 Y.2
  have hs : inner2 ((sharpMap (u2 hn) X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) (Y : Matrix (Fin n) (Fin n) ℝ) =
      sharpBil (Wc n) X Y := inner2_sharpMap (u2 hn) X Y
  unfold Qop2 compOp2
  rw [add_apply, Submodule.coe_add, AltLayer.inner2_add_left, sharpMapCL_apply, hs]
  exact h

/-- **`⟨H, Q(u)⟩ = √(3/2) ⟨H, u⟩`** on `Λ²`. -/
theorem innerOp2_Qop2_u2 (hn : 4 ≤ n) (H : CurvOp2 (Fin n)) :
    innerOp2 H (Qop2 (u2 hn)) = Real.sqrt (3 / 2) * innerOp2 H (u2 hn) := by
  unfold innerOp2
  rw [mul_left_comm, Finset.mul_sum (s := Finset.univ) (a := Real.sqrt (3 / 2))]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_comm, inner2_Qop2_u2, inner2_comm]

/-- **`d⁺P(u; H) = 0`** along every direction tangent to `u`, `P` being differentiable. -/
theorem hasDerivAt_Pcubic2_u2 (hn : 4 ≤ n) (H : CurvOp2 (Fin n)) (hT : innerOp2 H (u2 hn) = 0) :
    HasDerivAt (fun t : ℝ => Pcubic2 (u2 hn + t • H)) 0 0 := by
  have h := hasDerivAt_Pcubic2_line (u2 hn) H (TensorBridge.isSelfAdjoint2_restrict (Wc_weyl hn))
  rwa [innerOp2_Qop2_u2, hT, mul_zero, mul_zero] at h

/-! ## From `CurvOp2` to the bivector model -/

open HamiltonsCubic.BivModel HamiltonsCubic.SpectralFn HamiltonsCubic.AltLayer HamiltonsCubic.DefectCP2

/-- `coords φ_p` is the unit vector at the pair `p`. -/
theorem coords_phi_pair (p q : Pairs n) :
    coords (n := n) (phi p.1.1 p.1.2) q = if q = p then 1 else 0 := by
  rw [coords_apply, inner2_phi _ (phi_isSkew _ _)]
  obtain ⟨⟨i, j⟩, hij⟩ := p
  obtain ⟨⟨k, l⟩, hkl⟩ := q
  simp only at hij hkl ⊢
  have hno : ¬(j = k ∧ i = l) := fun h => by
    obtain ⟨h1, h2⟩ := h; subst h1; subst h2; exact lt_asymm hij hkl
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, if_neg hno, zero_sub, neg_neg]
  by_cases h : i = k ∧ j = l
  · obtain ⟨h1, h2⟩ := h; subst h1; subst h2; simp
  · rw [if_neg h, if_neg]
    intro he
    apply h
    simp only [Subtype.mk.injEq, Prod.mk.injEq] at he
    exact ⟨he.1.symm, he.2.symm⟩

/-- The skew matrix with pair coordinates `c`. -/
noncomputable def toSkew : Biv n →ₗ[ℝ] skewSub (Fin n) where
  toFun c := ⟨∑ p : Pairs n, c p • phi p.1.1 p.1.2,
    Submodule.sum_mem _ fun p _ => Submodule.smul_mem _ _ (phi_mem_skewSub _ _)⟩
  map_add' c d := by ext1; simp [add_smul, Finset.sum_add_distrib]
  map_smul' r c := by ext1; simp [smul_smul, Finset.smul_sum]

/-- **`coords (toSkew c) = c`.** -/
theorem coords_toSkew (c : Biv n) : coords ((toSkew c : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = c := by
  ext q
  change coordsL (∑ p : Pairs n, c p • phi p.1.1 p.1.2) q = c q
  rw [map_sum]
  simp only [map_smul, coordsL_apply]
  rw [WithLp.ofLp_sum]
  simp only [Finset.sum_apply, PiLp.smul_apply, smul_eq_mul, coords_phi_pair, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq, Finset.mem_univ, if_true]

theorem phi_self_zero (i : Fin n) : phi i i = 0 := by
  have h := phi_swap i i
  have : (2 : ℝ) • phi i i = 0 := by rw [two_smul]; nth_rewrite 1 [h]; rw [neg_add_cancel]
  exact (smul_eq_zero.mp this).resolve_left two_ne_zero

/-- **`toSkew (coords X) = X`** on skew matrices. -/
theorem toSkew_coords {X : Matrix (Fin n) (Fin n) ℝ} (hX : IsSkew X) :
    ((toSkew (coords X) : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = X := by
  ext a b
  have hs := congrFun (congrFun (skew_expand X hX) a) b
  simp only [Matrix.smul_apply, Matrix.sum_apply, smul_eq_mul] at hs
  rw [sum_pairs (f := fun i j => inner2 X (phi i j) * phi i j a b)
    (fun i => by simp [phi_self_zero])
    (fun i j => by simp only [phi_swap j i, AltLayer.inner2_neg_right, Matrix.neg_apply]; ring)] at hs
  change (∑ p : Pairs n, coords X p • phi p.1.1 p.1.2) a b = X a b
  simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, coords_apply]
  linarith

/-- **An operator on `Λ²` read in the pair coordinates.** -/
noncomputable def opB (R : CurvOp2 (Fin n)) : Biv n →ₗ[ℝ] Biv n :=
  coordsL ∘ₗ (skewSub (Fin n)).subtype ∘ₗ (R : skewSub (Fin n) →ₗ[ℝ] skewSub (Fin n)) ∘ₗ toSkew

theorem opB_apply (R : CurvOp2 (Fin n)) (c : Biv n) :
    opB R c = coords ((R (toSkew c) : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) := rfl

/-- `opB` is linear in the operator. -/
theorem opB_add_smul (R S : CurvOp2 (Fin n)) (t : ℝ) : opB (R + t • S) = opB R + t • opB S := by
  refine LinearMap.ext fun c => ?_
  simp only [opB_apply, LinearMap.add_apply, LinearMap.smul_apply, add_apply,
    smul_apply, Submodule.coe_add, Submodule.coe_smul, ← coordsL_apply, map_add, map_smul]

/-- **Self-adjoint on `Λ²` is symmetric in the model.** -/
theorem opB_isSymmetric {R : CurvOp2 (Fin n)} (hR : IsSelfAdjoint2 R) : (opB R).IsSymmetric := fun c d => by
  rw [opB_apply, opB_apply]
  conv_lhs => rw [← coords_toSkew d]
  conv_rhs => rw [← coords_toSkew c]
  rw [inner_coords (R _).2 (toSkew d).2, inner_coords (toSkew c).2 (R _).2]
  exact hR _ _

/-- **`compOf (opB R) i j k l = ⟨R φᵢⱼ, φ_kl⟩`.** -/
theorem compOf_opB (R : CurvOp2 (Fin n)) (i j k l : Fin n) :
    compOf (opB R) i j k l = inner2 (applyPhi R i j) (phi k l) := by
  unfold compOf
  rw [opB_apply]
  have : toSkew (coords (phi i j)) = ⟨phi i j, phi_mem_skewSub i j⟩ := Subtype.ext (toSkew_coords (phi_isSkew i j))
  rw [this, real_inner_comm, inner_coords (R _).2 (phi_isSkew k l)]

/-- **First Bianchi carries over**: `Alt` of a Weyl operator vanishes in the model. -/
theorem alt4_opB_eq_zero {R : CurvOp2 (Fin n)} (hR : IsWeyl2 R) : alt4 (compOf (opB R)) = 0 := by
  funext i j k l
  simp only [alt4, compOf_opB, Pi.zero_apply]
  rw [hR.bianchi i j k l, mul_zero]

/-! ## The layer's critical competitor is the model's `u` -/

theorem Jz_eq_om6Z (a : Fin 3) (i j : Fin 4) : Jz a i j = om6Z ⟨a.val, by omega⟩ i j := by
  fin_cases a <;> fin_cases i <;> fin_cases j <;> decide

/-- `∑ₓ Emb q x f x` picks the `q`-th value inside the block and vanishes outside it. -/
theorem sum_Emb (q : Fin n) (f : Fin 4 → ℝ) :
    ∑ x : Fin 4, Emb n q x * f x = if h : q.val < 4 then f ⟨q.val, h⟩ else 0 := by
  split_ifs with h
  · rw [Finset.sum_eq_single ⟨q.val, h⟩]
    · simp [Emb]
    · intro x _ hx; simp only [Emb]; rw [if_neg (fun e => hx (Fin.ext e.symm)), zero_mul]
    · simp
  · refine Finset.sum_eq_zero fun x _ => ?_
    simp only [Emb]
    rw [if_neg, zero_mul]
    intro e; have := x.isLt; omega

/-- **CP2Real's `ω_a` are the model's padded bivectors**: `ω_a = pad(om6 a)/√2`. -/
theorem om_eq (a : Fin 3) : om (n := n) a = (Real.sqrt 2)⁻¹ • pad (om6 ⟨a.val, by omega⟩) := by
  ext q p
  rw [om_entry, Matrix.smul_apply, smul_eq_mul]
  unfold sq2
  congr 1
  simp only [dotProduct, Matrix.mulVec]
  rw [sum_Emb q]
  by_cases hq : q.val < 4
  · rw [dif_pos hq]
    simp only [mul_comm _ (Emb n p _)]
    rw [sum_Emb p]
    by_cases hp : p.val < 4
    · rw [dif_pos hp, pad_apply _ _ _ ⟨hq, hp⟩, J_cast, om6_eq_cast, Jz_eq_om6Z a]
    · rw [dif_neg hp, pad_zero _ _ _ (fun h => hp h.2)]
  · rw [dif_neg hq, pad_zero _ _ _ (fun h => hq h.1)]

theorem coords_om (a : Fin 3) : coords (om (n := n) a) = vec ⟨a.val, by omega⟩ := by
  rw [om_eq, vec, ← coordsL_apply, map_smul, coordsL_apply]

theorem om_skew' (a : Fin 3) : IsSkew (om (n := n) a) := om_skew a

/-- **`opB u = uOp`**: the layer's critical `W_{ℂP²}` is the operator whose derivative identity is proved. -/
theorem opB_u2 (hn : 4 ≤ n) : opB (u2 hn) = uOp := by
  refine LinearMap.ext fun c => ?_
  rw [opB_apply]
  change coords (Wc n (toSkew c : Matrix (Fin n) (Fin n) ℝ)) = _
  unfold Wc uOp
  rw [← coordsL_apply, map_sum, rankSum_apply, Fin.sum_univ_six, Fin.sum_univ_three]
  simp only [map_smul, coordsL_apply, coords_om]
  have hi : ∀ a : Fin 3, inner2 ((toSkew c : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) (om a) =
      inner ℝ (vec ⟨a.val, by omega⟩) c := fun a => by
    rw [← inner_coords (toSkew c).2 (om_skew a), coords_toSkew, coords_om, real_inner_comm]
  simp only [hi]
  simp only [mu, lam6, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val, zero_mul, zero_smul, add_zero,
    neg_div]
  rfl

/-! ## Tangency in the model -/

theorem coords_phi_eq_basis (p : Pairs n) :
    coords (n := n) (phi p.1.1 p.1.2) = EuclideanSpace.basisFun (Pairs n) ℝ p := by
  ext q
  rw [coords_phi_pair, EuclideanSpace.basisFun_apply, PiLp.single_apply]

theorem opB_basis (R : CurvOp2 (Fin n)) (p : Pairs n) :
    opB R (EuclideanSpace.basisFun (Pairs n) ℝ p) = coords (applyPhi R p.1.1 p.1.2) := by
  rw [← coords_phi_eq_basis, opB_apply]
  have : toSkew (coords (phi p.1.1 p.1.2)) = ⟨phi p.1.1 p.1.2, phi_mem_skewSub _ _⟩ :=
    Subtype.ext (toSkew_coords (phi_isSkew _ _))
  rw [this]

theorem applyPhi_swap (R : CurvOp2 (Fin n)) (i j : Fin n) : applyPhi R j i = -applyPhi R i j := by
  have : (⟨phi j i, phi_mem_skewSub j i⟩ : skewSub (Fin n)) = -⟨phi i j, phi_mem_skewSub i j⟩ :=
    Subtype.ext (phi_swap i j)
  simp only [applyPhi, this, map_neg, Submodule.coe_neg]

/-- **`⟨R, S⟩ = tr(R S)` in the model** for self-adjoint `R`. -/
theorem innerOp2_eq_trace {R : CurvOp2 (Fin n)} (hR : IsSelfAdjoint2 R) (S : CurvOp2 (Fin n)) :
    innerOp2 R S = LinearMap.trace ℝ (Biv n) (opB R ∘ₗ opB S) := by
  unfold innerOp2
  rw [sum_pairs (f := fun i j => inner2 (applyPhi R i j) (applyPhi S i j))
    (fun i => by
      have h := applyPhi_swap R i i
      have : applyPhi R i i = 0 := by
        have h2 : (2 : ℝ) • applyPhi R i i = 0 := by rw [two_smul]; nth_rewrite 1 [h]; rw [neg_add_cancel]
        exact (smul_eq_zero.mp h2).resolve_left two_ne_zero
      change inner2 (applyPhi R i i) (applyPhi S i i) = 0
      rw [this]; simp [inner2])
    (fun i j => by
      rw [applyPhi_swap R i j, applyPhi_swap S i j, AltLayer.inner2_neg_left, AltLayer.inner2_neg_right, neg_neg])]
  rw [LinearMap.trace_eq_sum_inner _ (EuclideanSpace.basisFun (Pairs n) ℝ), ← mul_assoc, one_div,
    inv_mul_cancel₀ two_ne_zero, one_mul]
  refine Finset.sum_congr rfl fun p _ => ?_
  rw [LinearMap.comp_apply, ← opB_isSymmetric hR, opB_basis, opB_basis,
    inner_coords (R _).2 (S _).2]

/-! ## L17 in full -/

/-- **One path for both halves**: the model reads `u + tH` as `opB (u + tH) = uOp + t opB H`. -/
theorem opB_path (hn : 4 ≤ n) (H : CurvOp2 (Fin n)) (t : ℝ) : opB (u2 hn + t • H) = uOp + t • opB H := by
  rw [opB_add_smul, opB_u2]

theorem opB_path_isSymmetric (hn : 4 ≤ n) {H : CurvOp2 (Fin n)} (hH : IsSelfAdjoint2 H) (t : ℝ) :
    (opB (u2 hn + t • H)).IsSymmetric := by
  rw [opB_path]
  intro x y
  simp only [LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_add_right, real_inner_smul_left,
    real_inner_smul_right, uOp_isSymmetric x y, opB_isSymmetric hH x y]

/-- **Lemma L17.** Let `u` be the padded `ℂP²` competitor in `𝒲ₙ`, `n ≥ 4`, critical with `Q(u) = √(3/2) u`, and let
`H ∈ 𝒲ₙ` be tangent, `⟨H, u⟩ = 0`. Along the one path `u + tH`, with `P` the layer's `Pcubic2` and `δ²` read in the
bivector model through `opB`, and `F(H) = H₂₂ + H₃₃ + tr(Π_ASD (P₀HP₀)₋) ≥ 0`:

`d⁺Φ(u; H) = 2a κ F(H)` for `Φ = P − κ δ²` and every real `κ`, with `a = 1/(3√6)`, and `d⁺Φ ≤ 0` whenever `κ ≤ 0`. -/
theorem L17 (hn : 4 ≤ n) {N : ℕ} (hN : finrank ℝ (Biv n) = N) {H : CurvOp2 (Fin n)} (hH : IsWeyl2 H)
    (hT : innerOp2 H (u2 hn) = 0) (κ : ℝ) :
    HasDerivWithinAt
      (fun t => Pcubic2 (u2 hn + t • H) -
        κ * altNormSqOf (specFn hN negPartScalar (opB_path_isSymmetric hn hH.selfAdjoint t)))
      (2 * (1 / (3 * Real.sqrt 6)) * κ *
        (inner ℝ (vec 1) (opB H (vec 1)) + inner ℝ (vec 2) (opB H (vec 2)) +
          ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)),
            inner ℝ (vec δ) (specFn hN negPartScalar
              (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm (opB_isSymmetric hH.selfAdjoint)) (vec δ))))
      (Set.Ici 0) 0 ∧
    (κ ≤ 0 → 2 * (1 / (3 * Real.sqrt 6)) * κ *
        (inner ℝ (vec 1) (opB H (vec 1)) + inner ℝ (vec 2) (opB H (vec 2)) +
          ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)),
            inner ℝ (vec δ) (specFn hN negPartScalar
              (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm (opB_isSymmetric hH.selfAdjoint)) (vec δ))) ≤ 0) := by
  have hHs := opB_isSymmetric (n := n) hH.selfAdjoint
  have hW : ∀ t : ℝ, (uOp + t • opB H).IsSymmetric := fun t => by
    rw [← opB_path hn]; exact opB_path_isSymmetric hn hH.selfAdjoint t
  have hsame : ∀ t : ℝ, specFn hN negPartScalar (opB_path_isSymmetric hn hH.selfAdjoint t) =
      specFn hN negPartScalar (hW t) := fun t => by
    have key : ∀ (T : Biv n →ₗ[ℝ] Biv n) (hT : T.IsSymmetric), T = uOp + t • opB H →
        specFn hN negPartScalar hT = specFn hN negPartScalar (hW t) := by
      rintro T hT rfl; rfl
    exact key _ _ (opB_path hn H t)
  simp_rw [hsame]
  have hTr : LinearMap.trace ℝ (Biv n) (opB H ∘ₗ uOp) = 0 := by
    rw [← opB_u2 hn, ← innerOp2_eq_trace hH.selfAdjoint, hT]
  obtain ⟨hδ, -, hle⟩ := L17_at_u hN hn hHs (alt4_opB_eq_zero hH) hTr hW
  have hP := (hasDerivAt_Pcubic2_u2 hn H hT).hasDerivWithinAt (s := Set.Ici 0)
  set F := inner ℝ (vec (n := n) 1) (opB H (vec 1)) + inner ℝ (vec 2) (opB H (vec 2)) +
    ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)), inner ℝ (vec δ) (specFn hN negPartScalar
      (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm hHs) (vec δ)) with hF
  have ha : 0 < 1 / (3 * Real.sqrt 6) := by positivity
  have hFnn : 0 ≤ F := by nlinarith
  refine ⟨?_, fun hκ => ?_⟩
  · refine (hP.sub (hδ.const_mul κ)).congr_deriv ?_
    ring
  · have : 0 ≤ (1 / (3 * Real.sqrt 6)) * F := mul_nonneg ha.le hFnn
    nlinarith

/-- **At `n ≥ 12` the penalty is `κₙ < 0`**, [L16Statement.lean](L16Statement.lean)'s `kappaPen`, so `d⁺Φ(u; H) ≤ 0`
for every tangent `H ∈ 𝒲ₙ`. -/
theorem L17_ge12 (hn12 : 12 ≤ n) {N : ℕ} (hN : finrank ℝ (Biv n) = N) {H : CurvOp2 (Fin n)} (hH : IsWeyl2 H)
    (hT : innerOp2 H (u2 (by omega)) = 0) :
    2 * (1 / (3 * Real.sqrt 6)) * L16Statement.kappaPen n *
        (inner ℝ (vec 1) (opB H (vec 1)) + inner ℝ (vec 2) (opB H (vec 2)) +
          ∑ δ ∈ ({3, 4, 5} : Finset (Fin 6)),
            inner ℝ (vec δ) (specFn hN negPartScalar
              (schur_isSymmetric hN uOp_isSymmetric zeroφ_symm (opB_isSymmetric hH.selfAdjoint)) (vec δ))) ≤ 0 :=
  (L17 (by omega) hN hH hT _).2 (L16Statement.kappaPen_neg n hn12).le

end HamiltonsCubic.L17Deriv
