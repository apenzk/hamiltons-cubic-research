import HamiltonsCubic.Results.L24Weyl
import HamiltonsCubic.Results.FirstVariation

set_option linter.style.longLine false

/-!
# L24 as an eigenvalue statement, and the simplicity of `1`

[findings/second-order.md](../../../findings/second-order.md), Lemma L24: at a local maximiser `W`
with `θ = P(W) > 0` and `e = W/θ`, `λ_max(L_e|_{W^⊥}) ≤ ½` with `L_e = e ∘ (·)`, **and `1` is a
simple eigenvalue of `L_e`**, since every eigenvalue off `W` is at most `½` while `L_e e = e`.

[L24Weyl.lean](L24Weyl.lean)'s `L24_weyl` proves the quadratic-form reading,
`⟪a, Q(v)⟫ ≤ P(a)/2` at every unit Weyl `v ⊥ a`. **This file reads it as a statement about
eigenvalues of `L_e` itself**, over the record's Fox product `foxProd2`:

- `foxProd2` is bilinear (`foxProd2_add_right`, `foxProd2_smul_right`, `foxProd2_smul_left`) and
  `foxProd2 v v = Q(v)` (`foxProd2_self`), each checked against every test operator through
  `foxTri2_split`, with `eq_of_innerOp2` turning agreement of pairings into equality;
- `L24_eigen`: **every eigenvalue of `L_e` on a Weyl direction orthogonal to `a` is at most `½`**;
- `Le_self`: `L_e a = a` at a unit critical `a`, so `1` is an eigenvalue;
- `L24_simple`: **every Weyl eigenvector of `L_e` with eigenvalue `1` is a multiple of `a`.**

*The eigenvalue bound needs no Weyl closure of `L_e`*: it is a statement about each eigenvector
that exists, and the Rayleigh quotient of one is bounded by the quadratic-form bound. The restricted
operator, with `L_e` preserving `W^⊥`, is [L24Restrict.lean](L24Restrict.lean).
-/

namespace HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Operators are equal when every pairing agrees**, `innerOp2` being positive definite. -/
theorem eq_of_innerOp2 {A B : CurvOp2 ι} (h : ∀ Z, innerOp2 Z A = innerOp2 Z B) : A = B := by
  have hD : normSq2 (A - B) = 0 := by
    unfold normSq2
    rw [innerOp2_comm, innerOp2_sub_left, innerOp2_comm A, innerOp2_comm B, h]; ring
  exact sub_eq_zero.mp (normSq2_eq_zero hD)

/-- `⟪Z, X ∘ Y⟫` from `foxTri2_split`, with the test operator in the first slot. -/
theorem innerOp2_foxProd2 (X Y Z : CurvOp2 ι) :
    innerOp2 Z (foxProd2 X Y)
      = (1/2 : ℝ) * (innerOp2 (X.comp Y) Z + innerOp2 (Y.comp X) Z)
        + -(1/4 : ℝ) * (phiTri Z X Y + phiTri Z Y X) := by
  rw [innerOp2_comm]; exact foxTri2_split X Y Z

/-- **`v ∘ v = Q(v)`.** -/
theorem foxProd2_self (v : CurvOp2 ι) : foxProd2 v v = Qop2 v := by
  refine eq_of_innerOp2 fun Z => ?_
  rw [innerOp2_foxProd2]
  unfold Qop2 compOp2
  rw [innerOp2_add_right, innerOp2_sharpMap_eq_phiTri, innerOp2_comm Z]
  ring

/-- **`∘` is commutative.** -/
theorem foxProd2_comm (X Y : CurvOp2 ι) : foxProd2 X Y = foxProd2 Y X := by
  unfold foxProd2; rw [add_comm X Y]; congr 1; abel

/-- **`∘` is additive in its second slot.** -/
theorem foxProd2_add_right (X Y Y' : CurvOp2 ι) :
    foxProd2 X (Y + Y') = foxProd2 X Y + foxProd2 X Y' := by
  refine eq_of_innerOp2 fun Z => ?_
  rw [innerOp2_add_right, innerOp2_foxProd2, innerOp2_foxProd2, innerOp2_foxProd2,
    ContinuousLinearMap.comp_add, ContinuousLinearMap.add_comp, innerOp2_add_left,
    innerOp2_add_left, phiTri_add_mid, phiTri_add_right]
  ring

/-- **`∘` is homogeneous in its second slot.** -/
theorem foxProd2_smul_right (c : ℝ) (X Y : CurvOp2 ι) :
    foxProd2 X (c • Y) = c • foxProd2 X Y := by
  refine eq_of_innerOp2 fun Z => ?_
  rw [innerOp2_smul_right, innerOp2_foxProd2, innerOp2_foxProd2,
    ContinuousLinearMap.comp_smul, ContinuousLinearMap.smul_comp, innerOp2_smul_left,
    innerOp2_smul_left, phiTri_smul_mid, phiTri_smul_right]
  ring

/-- **`∘` is homogeneous in its first slot.** -/
theorem foxProd2_smul_left (c : ℝ) (X Y : CurvOp2 ι) :
    foxProd2 (c • X) Y = c • foxProd2 X Y := by
  rw [foxProd2_comm, foxProd2_smul_right, foxProd2_comm]

/-- **`Q` is homogeneous of degree two.** -/
theorem Qop2_smul (c : ℝ) (v : CurvOp2 ι) : Qop2 (c • v) = (c ^ 2) • Qop2 v := by
  rw [← foxProd2_self, foxProd2_smul_left, foxProd2_smul_right, foxProd2_self, smul_smul, sq]

/-- **The Rayleigh quotient of `a ∘ ·` at `v` is `⟪a, Q(v)⟫`**, by full symmetry of `T`. -/
theorem innerOp2_foxProd2_self {a v : CurvOp2 ι} (ha : IsSelfAdjoint2 a) (hv : IsSelfAdjoint2 v) :
    innerOp2 (foxProd2 a v) v = innerOp2 a (Qop2 v) := by
  rw [← foxProd2_self, innerOp2_comm a]
  change foxTri2 a v v = foxTri2 v v a
  rw [foxTri2_comm, foxTri2_symm_right v a v ha hv]

/-- **L24 AS AN EIGENVALUE BOUND.** At a unit critical Weyl `a` locally maximising `P` on the
Weyl sphere with `θ = P(a) > 0`, every eigenvalue of `L_e = e ∘ (·)`, `e = a/θ`, on a nonzero
Weyl direction orthogonal to `a`, is at most `½`. -/
theorem L24_eigen {a v : CurvOp2 ι} {lam μ : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} a)
    (hθ : 0 < Pcubic2 a) (hWv : IsWeyl2 v) (hv : innerOp2 a v = 0) (hv0 : v ≠ 0)
    (heig : foxProd2 ((Pcubic2 a)⁻¹ • a) v = μ • v) : μ ≤ 1 / 2 := by
  set θ := Pcubic2 a with hθdef
  set s := normSq2 v with hs
  have hs0 : 0 < s := lt_of_le_of_ne (normSq2_nonneg v) (fun h => hv0 (normSq2_eq_zero h.symm))
  -- the unit direction `w = v/√s`
  set r := Real.sqrt s with hr
  have hr0 : 0 < r := Real.sqrt_pos.mpr hs0
  have hrr : r * r = s := Real.mul_self_sqrt hs0.le
  set w := r⁻¹ • v with hw
  have hw1 : normSq2 w = 1 := by
    unfold normSq2
    rw [hw, innerOp2_smul_left, innerOp2_smul_right, ← normSq2, ← hs]
    field_simp; nlinarith [hrr]
  have hwa : innerOp2 a w = 0 := by rw [hw, innerOp2_smul_right, hv, mul_zero]
  have hbound := L24_weyl ha hWa hcrit hmax hθ (isWeyl2_smul _ hWv) hwa hw1
  rw [Qop2_smul, innerOp2_smul_right] at hbound
  -- `⟪a, Q(v)⟫ = θ μ s`
  have hQ : innerOp2 a (Qop2 v) = θ * μ * s := by
    rw [← innerOp2_foxProd2_self hWa.isSelfAdjoint2 hWv.isSelfAdjoint2]
    have : foxProd2 a v = (θ * μ) • v := by
      have h1 := heig
      rw [foxProd2_smul_left] at h1
      have h2 := congrArg (fun X => θ • X) h1
      simp only [smul_smul] at h2
      rw [mul_inv_cancel₀ hθ.ne', one_smul] at h2
      exact h2
    rw [this, innerOp2_smul_left, ← normSq2, ← hs]
  rw [hQ] at hbound
  have hinv : (r⁻¹) ^ 2 = s⁻¹ := by rw [inv_pow, sq, hrr]
  rw [hinv] at hbound
  have key : θ * μ ≤ θ / 2 := by
    have := mul_le_mul_of_nonneg_left hbound hs0.le
    rw [show s * (s⁻¹ * (θ * μ * s)) = θ * μ * s by field_simp] at this
    nlinarith
  by_contra hc
  push Not at hc
  nlinarith

/-- **`L_e a = a`** at a unit critical `a` with `P(a) ≠ 0`, the multiplier being `P(a)`. -/
theorem Le_self {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hcrit : Qop2 a = lam • a)
    (hθ : Pcubic2 a ≠ 0) : foxProd2 ((Pcubic2 a)⁻¹ • a) a = a := by
  have hlam : Pcubic2 a = lam := by
    rw [Pcubic2_eq_innerOp2, hcrit, innerOp2_smul_right, ← normSq2, ha, mul_one]
  rw [foxProd2_smul_left, foxProd2_self, hcrit, smul_smul, hlam, inv_mul_cancel₀ (hlam ▸ hθ),
    one_smul]

/-- **`1` IS A SIMPLE EIGENVALUE OF `L_e` ON THE WEYL OPERATORS.** Under L24's hypotheses, a Weyl
`v` with `L_e v = v` is `⟪a, v⟫ a`. -/
theorem L24_simple {a v : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} a)
    (hθ : 0 < Pcubic2 a) (hWv : IsWeyl2 v)
    (heig : foxProd2 ((Pcubic2 a)⁻¹ • a) v = v) : v = innerOp2 a v • a := by
  set c := innerOp2 a v
  set v' := v + (-c) • a with hv'
  have hWv' : IsWeyl2 v' := isWeyl2_add hWv (isWeyl2_smul _ hWa)
  have hortho : innerOp2 a v' = 0 := by
    rw [hv', innerOp2_add_right, innerOp2_smul_right, ← normSq2, ha]
    ring
  have heig' : foxProd2 ((Pcubic2 a)⁻¹ • a) v' = (1 : ℝ) • v' := by
    rw [one_smul, hv', foxProd2_add_right, foxProd2_smul_right, Le_self ha hcrit hθ.ne', heig]
  by_contra hne
  have h0 : v' ≠ 0 := fun h => by
    apply hne
    have e : v = v' + c • a := by rw [hv']; ext X; simp
    rw [e, h]; ext X; simp
  have := L24_eigen ha hWa hcrit hmax hθ hWv' hortho h0 heig'
  norm_num at this

end HamiltonsCubic.RealLayer
