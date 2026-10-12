import HamiltonsCubic.Results.OrbitFree
import HamiltonsCubic.Results.L24Restrict
import HamiltonsCubic.Results.L234Split
import HamiltonsCubic.Results.CubicBridge
import HamiltonsCubic.Results.FoxBridge

set_option linter.style.longLine false

/-!
# L24's `½` is attained: `λ_max(L_e|_{W^⊥}) = ½` at a local maximiser

[L24Restrict.lean](L24Restrict.lean) proves `λ_max(L_e|_{W^⊥}) ≤ ½` at a unit Weyl `a` locally maximising `P`.
**This file proves the bound is attained**, along the orbit, as [findings/second-order.md](../../../findings/second-order.md)
records under Observation L25:

- `L24_sharp_vec`: at a unit critical Weyl `a`, `Q(a) = λa`, at `n ≥ 2`, there is a nonzero `v ∈ W^⊥` with
  `a ∘ v = (λ/2) v`. `v` is the orbit tangent `[ad φ_pq, a]` for a generator that moves `a`, which
  [OrbitFree.lean](OrbitFree.lean)'s `weyl_moves` supplies; `v` is Weyl by [OrbitWeyl.lean](OrbitWeyl.lean)'s
  `Dop_weylOp`, orthogonal to `a` by `innerOp_Dop_skew`, and the eigen-equation is
  [OrbitDeriv.lean](OrbitDeriv.lean)'s `orbit_half` on the class of linear bivector-valued maps, read back
  through `eq_of_innerOp2`;
- **`L24_sharp`**: `½` is an eigenvalue of `L_e|_{W^⊥}` at every unit critical Weyl `a` with `P(a) ≠ 0`,
  which is `λ_max(L_e|_{W^⊥}) ≥ ½` at every critical point with `θ ≠ 0`; no maximality enters;
- **`L24_lambda_max_eq`**: at a local maximiser with `P(a) > 0`, the largest Rayleigh quotient of
  `L_e|_{W^⊥}` is exactly `½`;
- `rayleighGE_half`: the same bound in [FoxProduct.lean](../Base/FoxProduct.lean)'s quadratic-form reading,
  `RayleighGE u θ ½`, at every Weyl `u` critical on `𝒲ₙ` with `θ ≠ 0` and `u ≠ 0` on bivectors.
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.TensorBridge

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem innerOp_congr_skew {R S R' S' : Matrix ι ι ℝ → Matrix ι ι ℝ}
    (hR : ∀ X, IsSkew X → R X = R' X) (hS : ∀ X, IsSkew X → S X = S' X) : innerOp R S = innerOp R' S' := by
  unfold innerOp
  simp only [hR _ (phi_isSkew _ _), hS _ (phi_isSkew _ _)]

theorem innerOp_comm' (R S : Matrix ι ι ℝ → Matrix ι ι ℝ) : innerOp R S = innerOp S R := by
  unfold innerOp; congr 1
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => inner2_comm _ _

theorem extend_skew (R : CurvOp2 ι) (X : Matrix ι ι ℝ) : IsSkew (extend R X) :=
  (R ⟨skewProj X, skewProj_mem X⟩).2

theorem L24_sharp_vec {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hn : 2 ≤ Fintype.card ι) :
    ∃ v, v ∈ weylPerp a ∧ v ≠ 0 ∧ foxProd2 a v = (lam / 2) • v := by
  have hu : IsWeylOp (extend a) := ⟨isLinOp_extend a, isWeyl_extend hWa⟩
  have hne : ∃ X, IsSkew X ∧ extend a X ≠ 0 := by
    by_contra h
    push Not at h
    have ha0 : a = 0 := by
      ext1 X
      apply Subtype.ext
      rw [← extend_apply]
      simpa using h _ X.2
    have h0 : normSq2 a = 0 := by
      have h := innerOp2_smul_right 0 a a
      rw [zero_mul, show (0 : ℝ) • a = a by rw [ha0]; exact ContinuousLinearMap.ext fun X => by simp] at h
      exact h
    linarith
  obtain ⟨p, q, Y, hY, hYne⟩ := HamiltonsCubic.OrbitDeriv.weyl_moves (extend a) hu hn hne
  have hw : IsWeylOp (HamiltonsCubic.OrbitDeriv.Dop (phi p q) (extend a)) :=
    HamiltonsCubic.OrbitDeriv.Dop_weylOp _ (phi_isSkew p q) _ hu
  have hvw : ∀ X, IsSkew X → extend (restrict hw.2) X = HamiltonsCubic.OrbitDeriv.Dop (phi p q) (extend a) X :=
    fun X hX => extend_restrict_on_skew hw.2 X hX
  refine ⟨restrict hw.2, ⟨isWeyl2_restrict hw.2, ?_⟩, ?_, ?_⟩
  · rw [← innerOp_extend, innerOp_congr_skew (fun _ _ => rfl) hvw]
    have h := HamiltonsCubic.OrbitDeriv.innerOp_Dop_skew (phi p q) (phi_isSkew p q) _ _ hu.1 hu.1
    have hc := innerOp_comm' (HamiltonsCubic.OrbitDeriv.Dop (phi p q) (extend a)) (extend a)
    linarith
  · intro h0
    apply hYne
    rw [← hvw Y hY, show Y = ((⟨Y, hY⟩ : skewSub ι) : Matrix ι ι ℝ) from rfl, extend_apply, h0]
    rfl
  · refine eq_of_innerOp2 fun Z => ?_
    have hcritC : ∀ r, (IsLinOp r ∧ ∀ X, IsSkew X → IsSkew (r X)) →
        foxTri (extend a) (extend a) r = lam * innerOp (extend a) r := by
      rintro r ⟨hl, hs⟩
      have e1 : foxTri (extend a) (extend a) r = foxTri (extend a) (extend a) (extend (restrictLin hl hs)) :=
        foxTri_congr_on_skew (fun W _ => extend_skew a W) (fun W _ => extend_skew a W) (fun _ _ => rfl) (fun _ _ => rfl)
          (fun X hX => (extend_restrictLin_on_skew hl hs X hX).symm)
      rw [e1, foxTri_extend]
      unfold foxTri2
      rw [foxProd2_self, hcrit, innerOp2_smul_left, ← innerOp_extend]
      congr 1
      exact innerOp_congr_skew (fun _ _ => rfl) (fun X hX => extend_restrictLin_on_skew hl hs X hX)
    have horb := HamiltonsCubic.OrbitDeriv.orbit_half (phi p q) (phi_isSkew p q) (extend a) hu.1 lam
      (fun r => IsLinOp r ∧ ∀ X, IsSkew X → IsSkew (r X)) (fun r hr => hr)
      (fun r hr => ⟨HamiltonsCubic.OrbitDeriv.Dop_lin _ r hr.1,
        HamiltonsCubic.OrbitDeriv.Dop_skew _ (phi_isSkew p q) r hr.2⟩) hcritC
      (extend Z) ⟨isLinOp_extend Z, fun X _ => extend_skew Z X⟩
    rw [innerOp2_comm, innerOp2_smul_right, innerOp2_comm Z]
    change foxTri2 a (restrict hw.2) Z = _
    rw [foxTri2_comm, ← foxTri_extend, ← innerOp_extend,
      foxTri_congr_on_skew (fun W _ => extend_skew _ W) (fun W _ => extend_skew a W) hvw (fun _ _ => rfl) (fun _ _ => rfl), horb]
    rw [innerOp_congr_skew (R' := extend (restrict hw.2)) (S' := extend Z) (fun X hX => (hvw X hX).symm)
      (fun _ _ => rfl)]

theorem L24_sharp {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (hn : 2 ≤ Fintype.card ι) :
    Module.End.HasEigenvalue (LeRestr ha hWa hcrit hθ) (1 / 2) := by
  obtain ⟨v, hv, hv0, heq⟩ := L24_sharp_vec ha hWa hcrit hn
  have hlam : Pcubic2 a = lam := by
    rw [Pcubic2_eq_innerOp2, hcrit, innerOp2_smul_right, ← normSq2, ha, mul_one]
  have hl0 : lam ≠ 0 := hlam ▸ hθ
  have hLe : LeLin a v = (1 / 2 : ℝ) • v := by
    show foxProd2 ((Pcubic2 a)⁻¹ • a) v = _
    rw [foxProd2_smul_left, heq, smul_smul, hlam]
    congr 1; field_simp
  refine Module.End.hasEigenvalue_of_hasEigenvector (x := ⟨v, hv⟩) ⟨?_, ?_⟩
  · rw [Module.End.mem_eigenspace_iff]
    exact Subtype.ext hLe
  · intro h; exact hv0 (congrArg Subtype.val h)

/-- **`λ_max(L_e|_{W^⊥}) = ½` EXACTLY at a local maximiser**: `L24_lambda_max` bounds the largest Rayleigh
quotient by `½`, and the orbit tangent attains it. -/
theorem L24_lambda_max_eq {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} a)
    (hθ : 0 < Pcubic2 a) [Nontrivial (weylPerpR a)] (hn : 2 ≤ Fintype.card ι) :
    (⨆ x : {x : weylPerpR a // x ≠ 0},
      RCLike.re (inner ℝ (LeRestr ha hWa hcrit hθ.ne' x) (x : weylPerpR a))
        / ‖(x : weylPerpR a)‖ ^ 2) = 1 / 2 := by
  refine le_antisymm (L24_lambda_max ha hWa hcrit hmax hθ) ?_
  set f := LeRestr ha hWa hcrit hθ.ne'
  obtain ⟨x, hx⟩ := (L24_sharp ha hWa hcrit hθ.ne' hn).exists_hasEigenvector
  have hfx : f x = (1 / 2 : ℝ) • x := Module.End.mem_eigenspace_iff.mp hx.1
  have hx0 : x ≠ 0 := hx.2
  have hpos : 0 < ‖x‖ ^ 2 := by positivity
  have hbdd : BddAbove (Set.range fun y : {y : weylPerpR a // y ≠ 0} =>
      RCLike.re (inner ℝ (f y) (y : weylPerpR a)) / ‖(y : weylPerpR a)‖ ^ 2) := by
    refine ⟨‖LinearMap.toContinuousLinearMap f‖, ?_⟩
    rintro _ ⟨y, rfl⟩
    have hy : 0 < ‖(y : weylPerpR a)‖ ^ 2 := by have := y.2; positivity
    rw [div_le_iff₀ hy]
    have h1 := real_inner_le_norm (f y) (y : weylPerpR a)
    have h2 := (LinearMap.toContinuousLinearMap f).le_opNorm (y : weylPerpR a)
    simp only [LinearMap.coe_toContinuousLinearMap'] at h2
    have hn0 : 0 ≤ ‖(y : weylPerpR a)‖ := by positivity
    simp only [RCLike.re_to_real]
    nlinarith
  refine le_trans ?_ (le_ciSup hbdd ⟨x, hx0⟩)
  show 1 / 2 ≤ RCLike.re (inner ℝ (f x) x) / ‖x‖ ^ 2
  have hi : inner ℝ (f x) x = (1 / 2) * ‖x‖ ^ 2 := by
    rw [hfx, ← real_inner_self_eq_norm_sq]
    exact real_inner_smul_left x x (1 / 2 : ℝ)
  rw [RCLike.re_to_real, hi, mul_div_assoc, div_self hpos.ne', mul_one]

/-- **`RayleighGE u θ ½`**, [FoxProduct.lean](../Base/FoxProduct.lean)'s quadratic-form reading of
`λ_max(L_e|_{W^⊥}) ≥ ½`, at every Weyl `u` critical on `𝒲ₙ` with `θ ≠ 0` and `u` nonzero on bivectors, at `n ≥ 2`.
The witness is the orbit tangent. -/
theorem rayleighGE_half (u : Matrix ι ι ℝ → Matrix ι ι ℝ) (hu : IsWeylOp u) (hn : 2 ≤ Fintype.card ι)
    (θ : ℝ) (hθ : θ ≠ 0) (hcrit : ∀ r, IsWeylOp r → foxTri u u r = θ * innerOp u r)
    (hne : ∃ X, IsSkew X ∧ u X ≠ 0) : RayleighGE u θ (1 / 2) := by
  obtain ⟨p, q, Y, hY, hYne⟩ := HamiltonsCubic.OrbitDeriv.weyl_moves u hu hn hne
  obtain ⟨hXw, hX⟩ := HamiltonsCubic.OrbitDeriv.orbit_half_weyl (phi p q) (phi_isSkew p q) u hu θ hcrit
  refine ⟨_, hXw, ?_, ?_, ?_⟩
  · intro h0
    apply hYne
    have hsum : ∑ i, ∑ j, inner2 (HamiltonsCubic.OrbitDeriv.Dop (phi p q) u (phi i j))
        (HamiltonsCubic.OrbitDeriv.Dop (phi p q) u (phi i j)) = 0 := by
      unfold innerOp at h0; linarith
    have hphi : ∀ i j, HamiltonsCubic.OrbitDeriv.Dop (phi p q) u (phi i j) = 0 := by
      intro i j
      have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ =>
        Finset.sum_nonneg fun j _ => inner2_self_nonneg _)).mp hsum i (Finset.mem_univ i)
      have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => inner2_self_nonneg _)).mp h1 j
        (Finset.mem_univ j)
      exact inner2_self_eq_zero h2
    rw [← skew_expand Y hY, hXw.1.2, HamiltonsCubic.OrbitDeriv.linOp_sum _ hXw.1]
    simp [HamiltonsCubic.OrbitDeriv.linOp_sum _ hXw.1, hXw.1.2, hphi]
  · have h := HamiltonsCubic.OrbitDeriv.innerOp_Dop_skew (phi p q) (phi_isSkew p q) u u hu.1 hu.1
    have hc := innerOp_comm' (HamiltonsCubic.OrbitDeriv.Dop (phi p q) u) u
    linarith
  · have e : foxTri (idemOf u θ) (HamiltonsCubic.OrbitDeriv.Dop (phi p q) u)
        (HamiltonsCubic.OrbitDeriv.Dop (phi p q) u)
        = θ⁻¹ * foxTri (HamiltonsCubic.OrbitDeriv.Dop (phi p q) u) u
          (HamiltonsCubic.OrbitDeriv.Dop (phi p q) u) := by
      unfold idemOf
      rw [foxTri_comm]
      unfold foxTri innerOp
      rw [show (θ⁻¹ • u) = fun W => θ⁻¹ • u W from rfl]
      simp only [foxProd_smul_right θ⁻¹ _ u hXw.1 hu.1, HamiltonsCubic.OrbitDeriv.inner2_smul_l']
      simp only [← Finset.mul_sum]; ring
    rw [e, hX _ hXw, ← mul_assoc, show θ⁻¹ * (θ / 2) = 1 / 2 by field_simp]

end HamiltonsCubic.RealLayer
