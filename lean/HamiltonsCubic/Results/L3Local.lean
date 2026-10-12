import Mathlib
import HamiltonsCubic.Results.L222Xi
import HamiltonsCubic.Results.L27Close
import HamiltonsCubic.Results.L3Quad
import HamiltonsCubic.Results.RecordNormed
import HamiltonsCubic.Results.CubicTri

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L3's local-maximum clause: the balanced product is a strict local maximum transverse to its orbit

[findings/second-order.md](../../../findings/second-order.md), Lemma L3: *the unit Weyl tensor $W^*$ of $S^{n/2}\times S^{n/2}$ with
$P(W^*)>0$ is a local maximum of $P$ on the unit sphere $\Sigma$ of $\mathcal W_n$ … and strictly so transverse to its $O(n)$-orbit
$\mathcal O$: some neighbourhood $U$ of $\mathcal O$ in $\Sigma$ has $P<P(W^*)$ on $U\setminus\mathcal O$.*

The record's proof goes through the tubular neighbourhood theorem. This file proves the clause without it: move `V` by the
orthogonal `U₀` that brings it closest to `W*` (compactness of `O(n)`), so that `V' = U₀ · V` is orthogonal to every orbit tangent
at `W*` (first-order condition along the rotations of each coordinate plane); write `V' = a W* + h` with `h ⊥ W*`; then the cubic
expansion, the Hessian bound of [L3Quad.lean](L3Quad.lean) and a cubic bound on `P` give `P(V) = P(V') < P(W*)` once `h ≠ 0` is small.

* `triL`, **`abs_Pcubic2_le_rec`**: `|P(H)| ≤ C (√‖H‖²)³`, through an orthonormal basis of the record's norm;
* `orthSet`, **`orthSet_compact`**, `pairing_continuous`, **`exists_max`**: a maximiser of `U ↦ ⟨U · V, A⟩` over `O(n)`;
* `innerOp2_rotR_adj`, `Rot_zero`, **`first_order`**: at the maximiser, `⟨ν_y, U₀ · V⟩ = 0` for every pair `j ≠ k`, from the
  derivative of the rotation ([L222Xi.lean](L222Xi.lean)'s `xi_W`);
* `orbitOp_eq`: the cross-pair orbit tangent is `2 ν_y`;
* **`L3_local_max`**: at every even `n = 2m`, `m ≥ 4`, there is `δ > 0` such that every unit Weyl `V` within `√δ` of the orbit
  either lies on it or has `P(V) < P(W*)`.
-/

namespace HamiltonsCubic.RealLayer
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `cubicTri` as a trilinear map on `RecCurv`. -/
noncomputable def triL : RecCurv ι →ₗ[ℝ] RecCurv ι →ₗ[ℝ] RecCurv ι →ₗ[ℝ] ℝ where
  toFun X := LinearMap.mk₂ ℝ (fun Y Z : RecCurv ι => cubicTri (X : CurvOp2 ι) (Y : CurvOp2 ι) (Z : CurvOp2 ι))
    (fun Y Y' Z => cubicTri_add_mid X Y Y' Z) (fun c Y Z => cubicTri_smul_mid c X Y Z)
    (fun Y Z Z' => cubicTri_add_right X Y Z Z') (fun c Y Z => cubicTri_smul_right c X Y Z)
  map_add' X X' := by
    ext Y Z
    simp only [LinearMap.add_apply]
    exact cubicTri_add_left X X' Y Z
  map_smul' c X := by
    ext Y Z
    simp only [LinearMap.smul_apply, RingHom.id_apply, smul_eq_mul]
    exact cubicTri_smul_left c X Y Z

theorem triL_apply (X Y Z : RecCurv ι) : triL X Y Z = cubicTri (X : CurvOp2 ι) (Y : CurvOp2 ι) (Z : CurvOp2 ι) := rfl

/-- **`|P(x)| ≤ C ‖x‖³` in the record's norm.** -/
theorem abs_Pcubic2_le_recNorm : ∃ C : ℝ, 0 ≤ C ∧ ∀ x : RecCurv ι, |Pcubic2 (x : CurvOp2 ι)| ≤ C * ‖x‖ ^ 3 := by
  let b := stdOrthonormalBasis ℝ (RecCurv ι)
  refine ⟨∑ i, ∑ j, ∑ k, |triL (b k) (b j) (b i)|, by positivity, fun x => ?_⟩
  have hP : Pcubic2 (x : CurvOp2 ι) = triL x x x := by rw [triL_apply]; exact Pcubic2_eq_cubicTri (x : CurvOp2 ι)
  have hx : x = ∑ i, inner ℝ (b i) x • b i := (b.sum_repr' x).symm
  have hc : ∀ i, |inner ℝ (b i) x| ≤ ‖x‖ := fun i => by
    have := abs_real_inner_le_norm (b i) x
    rwa [b.orthonormal.1 i, one_mul] at this
  have hexp : triL x x x = ∑ i, ∑ j, ∑ k, inner ℝ (b i) x * inner ℝ (b j) x * inner ℝ (b k) x * triL (b k) (b j) (b i) := by
    conv_lhs => rw [hx]
    simp only [map_sum, map_smul, LinearMap.sum_apply, LinearMap.smul_apply, smul_eq_mul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
    ring
  rw [hP, hexp, Finset.sum_mul]
  refine (Finset.abs_sum_le_sum_abs _ _).trans (Finset.sum_le_sum fun i _ => ?_)
  rw [Finset.sum_mul]
  refine (Finset.abs_sum_le_sum_abs _ _).trans (Finset.sum_le_sum fun j _ => ?_)
  rw [Finset.sum_mul]
  refine (Finset.abs_sum_le_sum_abs _ _).trans (Finset.sum_le_sum fun k _ => ?_)
  rw [abs_mul, abs_mul, abs_mul]
  have hi := hc i; have hj := hc j; have hk := hc k
  have ht := abs_nonneg (triL (b k) (b j) (b i))
  have a1 := abs_nonneg (inner ℝ (b i) x)
  have a2 := abs_nonneg (inner ℝ (b j) x)
  have a3 := abs_nonneg (inner ℝ (b k) x)
  calc |inner ℝ (b i) x| * |inner ℝ (b j) x| * |inner ℝ (b k) x| * |triL (b k) (b j) (b i)|
      ≤ ‖x‖ * ‖x‖ * ‖x‖ * |triL (b k) (b j) (b i)| := by gcongr
    _ = |triL (b k) (b j) (b i)| * ‖x‖ ^ 3 := by ring

/-- **`|P(H)| ≤ C (√‖H‖²)³`.** -/
theorem abs_Pcubic2_le_rec : ∃ C : ℝ, 0 ≤ C ∧ ∀ H : CurvOp2 ι, |Pcubic2 H| ≤ C * Real.sqrt (normSq2 H) ^ 3 := by
  obtain ⟨C, hC, hb⟩ := abs_Pcubic2_le_recNorm (ι := ι)
  refine ⟨C, hC, fun H => ?_⟩
  have hP := hb (RecCurv.equiv H)
  have h := RecCurv.norm_sq_eq (RecCurv.equiv H)
  have h0 := _root_.norm_nonneg (RecCurv.equiv H)
  obtain ⟨r, hr⟩ : ∃ r : ℝ, r = ‖RecCurv.equiv H‖ := ⟨_, rfl⟩
  rw [← hr] at hP h h0
  have hs : Real.sqrt (normSq2 H) = r := by
    rw [show normSq2 H = r ^ 2 from h.symm]
    exact Real.sqrt_sq h0
  rw [hs]
  exact hP

end HamiltonsCubic.RealLayer

namespace HamiltonsCubic.L3Local

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer HamiltonsCubic.TensorBridge
  HamiltonsCubic.Results HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L126Assembly HamiltonsCubic.L27Close HamiltonsCubic.L120Eigen HamiltonsCubic.L27Span

variable {n : ℕ}

/-- The orthogonal matrices. -/
def orthSet (n : ℕ) : Set (Matrix (Fin n) (Fin n) ℝ) := {U | IsOrth U}

theorem orthSet_compact : IsCompact (orthSet n) := by
  have hsub : orthSet n ⊆ Set.pi Set.univ (fun _ : Fin n => Set.pi Set.univ (fun _ : Fin n => Set.Icc (-1 : ℝ) 1)) := by
    intro U hU i _ j _
    have h := congrFun (congrFun hU.2 i) i
    simp only [Matrix.mul_apply, Matrix.transpose_apply, Matrix.one_apply_eq] at h
    have hle : U i j ^ 2 ≤ ∑ k, U i k * U i k := by
      rw [sq]
      exact Finset.single_le_sum (f := fun k => U i k * U i k) (fun k _ => mul_self_nonneg _) (Finset.mem_univ j)
    rw [h] at hle
    constructor <;> nlinarith [sq_nonneg (U i j)]
  have hcl : IsClosed (orthSet n) := by
    have c1 : Continuous (fun U : Matrix (Fin n) (Fin n) ℝ => Uᵀ * U) :=
      continuous_id.matrix_transpose.matrix_mul continuous_id
    have c2 : Continuous (fun U : Matrix (Fin n) (Fin n) ℝ => U * Uᵀ) :=
      continuous_id.matrix_mul continuous_id.matrix_transpose
    exact (isClosed_eq c1 continuous_const).inter (isClosed_eq c2 continuous_const)
  exact (isCompact_univ_pi fun _ => isCompact_univ_pi fun _ => isCompact_Icc).of_isClosed_subset hcl hsub

theorem inner2_continuous_left (Y : Matrix (Fin n) (Fin n) ℝ) : Continuous (fun X : Matrix (Fin n) (Fin n) ℝ => inner2 X Y) := by
  unfold inner2
  exact continuous_const.mul ((continuous_id.matrix_transpose.matrix_mul continuous_const).matrix_trace)

theorem rotR_apply_continuous (V : CurvOp2 (Fin n)) (X : skewSub (Fin n)) :
    Continuous (fun U : Matrix (Fin n) (Fin n) ℝ => ((rotR U V X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) := by
  simp only [rotR_coe]
  have h1 : Continuous (fun U : Matrix (Fin n) (Fin n) ℝ => (cU U X : skewSub (Fin n))) := by
    change Continuous (fun U : Matrix (Fin n) (Fin n) ℝ =>
      (⟨Uᵀ * (X : Matrix (Fin n) (Fin n) ℝ) * U, _⟩ : skewSub (Fin n)))
    exact Continuous.subtype_mk ((continuous_id.matrix_transpose.matrix_mul continuous_const).matrix_mul continuous_id) _
  have h2 : Continuous (fun U : Matrix (Fin n) (Fin n) ℝ => ((V (cU U X) : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)) :=
    continuous_subtype_val.comp (V.continuous.comp h1)
  exact (continuous_id.matrix_mul h2).matrix_mul continuous_id.matrix_transpose

theorem pairing_continuous (V A : CurvOp2 (Fin n)) :
    Continuous (fun U : Matrix (Fin n) (Fin n) ℝ => innerOp2 (rotR U V) A) := by
  unfold innerOp2
  refine continuous_const.mul (continuous_finsetSum _ fun i _ => continuous_finsetSum _ fun j _ => ?_)
  exact (inner2_continuous_left _).comp (rotR_apply_continuous V _)

/-- **A maximiser of the pairing with `A` over the orbit of `V`.** -/
theorem exists_max (V A : CurvOp2 (Fin n)) :
    ∃ U₀ ∈ orthSet n, ∀ U ∈ orthSet n, innerOp2 (rotR U V) A ≤ innerOp2 (rotR U₀ V) A := by
  have h1 : (1 : Matrix (Fin n) (Fin n) ℝ) ∈ orthSet n := by
    show IsOrth 1
    exact ⟨by simp, by simp⟩
  obtain ⟨U₀, hU₀, hmax⟩ := orthSet_compact.exists_isMaxOn ⟨1, h1⟩ (pairing_continuous V A).continuousOn
  exact ⟨U₀, hU₀, fun U hU => hmax hU⟩

theorem isOrth_mul {A B : Matrix (Fin n) (Fin n) ℝ} (hA : IsOrth A) (hB : IsOrth B) : IsOrth (A * B) := by
  refine ⟨?_, ?_⟩
  · rw [Matrix.transpose_mul, Matrix.mul_assoc, ← Matrix.mul_assoc Aᵀ, hA.1, Matrix.one_mul, hB.1]
  · rw [Matrix.transpose_mul, Matrix.mul_assoc, ← Matrix.mul_assoc B, hB.2, Matrix.one_mul, hA.2]

/-- **The frame change is self-adjoint up to transposition.** -/
theorem innerOp2_rotR_adj {R : Matrix (Fin n) (Fin n) ℝ} (hR : IsOrth R) {A B : CurvOp2 (Fin n)} (hA : IsWeyl2 A)
    (hB : IsWeyl2 B) : innerOp2 (rotR R A) B = innerOp2 A (rotR Rᵀ B) := by
  have hRt := isOrth_transpose hR
  have h := innerOp2_rotR hR hA (rotR_isWeyl2 hRt hB)
  rw [HamiltonsCubic.L219GenOps.rotR_comp, hR.2, HamiltonsCubic.L219GenOps.rotR_one] at h
  exact h

theorem Rot_zero (j k : Fin n) : HamiltonsCubic.PairSquare.Rot j k 1 0 = 1 := by
  ext p q
  simp only [HamiltonsCubic.PairSquare.Rot, Matrix.of_apply, Matrix.one_apply]
  split_ifs <;> simp_all

/-- **The first-order condition at a maximiser**: `V' = U₀ · V` is orthogonal to `ν_y`, `y_a = (w_ja − w_ka)/2`, for
every pair `j ≠ k`. -/
theorem first_order {w : Matrix (Fin n) (Fin n) ℝ} (hw : FamilyLayer.IsWeight w) {V : CurvOp2 (Fin n)} (hV : IsWeyl2 V)
    {U₀ : Matrix (Fin n) (Fin n) ℝ} (hU₀ : U₀ ∈ orthSet n)
    (hmax : ∀ U ∈ orthSet n, innerOp2 (rotR U V) (HamiltonsCubic.I117S.coordOp w)
      ≤ innerOp2 (rotR U₀ V) (HamiltonsCubic.I117S.coordOp w)) {j k : Fin n} (hjk : j ≠ k) :
    innerOp2 (HamiltonsCubic.PairSquare.nuX j k (fun a => (w j a - w k a) / 2)) (rotR U₀ V) = 0 := by
  have hV' : IsWeyl2 (rotR U₀ V) := rotR_isWeyl2 hU₀ hV
  have hM : IsWeyl2 (HamiltonsCubic.I117S.coordOp w) := by
    rw [HamiltonsCubic.PairSquare.coordOp_eq_restrict hw]; exact isWeyl2_restrict _
  have hd := HamiltonsCubic.L222Xi.xi_W hjk hw 0 (rotR U₀ V)
  rw [HamiltonsCubic.L222Xi.nuX_zero, add_zero (HamiltonsCubic.I117S.coordOp w : CurvOp2 (Fin n)),
    HamiltonsCubic.L222Xi.Dminus_zero] at hd
  have hval : innerOp2 ((2 : ℝ) • HamiltonsCubic.PairSquare.nuX j k (fun a => (w j a - w k a) / 2) + (-2 : ℝ) • (0 : CurvOp2 (Fin n)))
      (rotR U₀ V) = 2 * innerOp2 (HamiltonsCubic.PairSquare.nuX j k (fun a => (w j a - w k a) / 2)) (rotR U₀ V) := by
    have e : ((2 : ℝ) • HamiltonsCubic.PairSquare.nuX j k (fun a => (w j a - w k a) / 2) + (-2 : ℝ) • (0 : CurvOp2 (Fin n)))
        = (2 : ℝ) • HamiltonsCubic.PairSquare.nuX j k (fun a => (w j a - w k a) / 2) := by module
    rw [e, innerOp2_smul_left]
  rw [hval] at hd
  have hloc : IsLocalMax (fun φ => innerOp2 (rotR (HamiltonsCubic.PairSquare.Rot j k (Real.cos φ) (Real.sin φ))
      (HamiltonsCubic.I117S.coordOp w)) (rotR U₀ V)) 0 := by
    refine Filter.Eventually.of_forall fun φ => ?_
    have hR : ∀ ψ : ℝ, IsOrth (HamiltonsCubic.PairSquare.Rot j k (Real.cos ψ) (Real.sin ψ)) := fun ψ =>
      HamiltonsCubic.PairSquare.Rot_orth hjk (Real.cos_sq_add_sin_sq ψ)
    have key : ∀ ψ : ℝ, innerOp2 (rotR (HamiltonsCubic.PairSquare.Rot j k (Real.cos ψ) (Real.sin ψ))
        (HamiltonsCubic.I117S.coordOp w)) (rotR U₀ V)
        = innerOp2 (rotR ((HamiltonsCubic.PairSquare.Rot j k (Real.cos ψ) (Real.sin ψ))ᵀ * U₀) V)
          (HamiltonsCubic.I117S.coordOp w) := by
      intro ψ
      rw [innerOp2_rotR_adj (hR ψ) hM hV', HamiltonsCubic.L219GenOps.rotR_comp, innerOp2_comm]
    simp only
    rw [key φ, key 0, Real.cos_zero, Real.sin_zero, Rot_zero, Matrix.transpose_one, Matrix.one_mul]
    exact hmax _ (isOrth_mul (isOrth_transpose (hR φ)) hU₀)
  have h0 := hloc.hasDerivAt_eq_zero hd
  linarith

/-- **The cross-pair orbit tangent is `2 ν_y`**, `y_a = (w_ja − w_ka)/2`. -/
theorem orbitOp_eq (T : Finset (Fin n)) (t : ℝ) {j k : Fin n} (hjk : j ≠ k) :
    orbitOp T t j k = (2 : ℝ) • HamiltonsCubic.PairSquare.nuX j k
      (fun a => ((t • sphereWeight T) j a - (t • sphereWeight T) k a) / 2) := by
  rw [orbitOp_nuX T t hjk, ← HamiltonsCubic.L224EqRot.nuX_smul]
  unfold HamiltonsCubic.PairSquare.nuX
  congr 2
  funext a
  simp only [HamiltonsCubic.DiagSquare.vy, corb, Pi.smul_apply, smul_eq_mul]
  by_cases h1 : a = j
  · subst h1; simp
  · by_cases h2 : a = k
    · subst h2; simp
    · simp only [h1, h2, or_self, if_false, Ne.symm h1, Ne.symm h2, ne_eq, not_false_eq_true, and_self, if_true]
      ring

theorem normSq2_sub (A B : CurvOp2 (Fin n)) :
    normSq2 (A - B) = normSq2 A - 2 * innerOp2 A B + normSq2 B := by
  unfold normSq2
  rw [innerOp2_sub_left', innerOp2_comm A (A - B), innerOp2_comm B (A - B), innerOp2_sub_left', innerOp2_sub_left',
    innerOp2_comm B A]
  ring

/-- **L3's local-maximum clause.** At the unit balanced product `W*` of `S^m × S^m`, `m ≥ 4`, there is `δ > 0` such that every
unit Weyl `V` with `‖U · V − W*‖² < δ` for some orthogonal `U` either lies on the orbit (`U₀ · V = W*` for an orthogonal `U₀`) or
has `P(V) < P(W*)`: a strict local maximum on the unit sphere, transverse to the orbit. -/
theorem L3_local_max (T : Finset (Fin n)) (hp : 4 ≤ T.card) (hpq : Tᶜ.card = T.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) :
    ∃ δ > 0, ∀ V : CurvOp2 (Fin n), IsWeyl2 V → normSq2 V = 1 →
      (∃ U, IsOrth U ∧ normSq2 (rotR U V - restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) < δ) →
      Pcubic2 V < Pcubic2 (restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t))) ∨
        ∃ U, IsOrth U ∧ rotR U V = restrict (diagOp_isWeyl ((sphereWeight_isWeight T (by omega) (by omega)).smul t)) := by
  have hp2 : 2 ≤ T.card := by omega
  have hq2 : 2 ≤ Tᶜ.card := by omega
  have hp3 : 3 ≤ T.card := by omega
  have hq3 : 3 ≤ Tᶜ.card := by omega
  have hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3) := by omega
  have hwt : IsWeight (t • sphereWeight T) := (sphereWeight_isWeight T hp2 hq2).smul t
  set M := restrict (diagOp_isWeyl hwt) with hMdef
  have hMW : IsWeyl2 M := isWeyl2_restrict _
  have hcoord : HamiltonsCubic.I117S.coordOp (t • sphereWeight T) = M := HamiltonsCubic.PairSquare.coordOp_eq_restrict hwt
  have hPθ : Pcubic (diagOp (t • sphereWeight T)) = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [← theta_of_unit _ hn]
    exact HamiltonsCubic.L74Statement.theta_of_critical_unit (sphere_isCritical T hp2 hq2 t) hn
  have hPM : Pcubic2 M = t * ((T.card : ℝ) + Tᶜ.card - 1) := by
    rw [hMdef, Pcubic2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hPθ]
  set θ := t * ((T.card : ℝ) + Tᶜ.card - 1) with hθdef
  have hmR : (4 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : ((Tᶜ.card : ℕ) : ℝ) = (T.card : ℝ) := by exact_mod_cast hpq
  have hθ : 0 < θ := mul_pos ht (by rw [hqR]; linarith)
  have ha1 : normSq2 M = 1 := by rw [hMdef, normSq2_restrict (isLinOp_diagOp _) (diagOp_isWeyl hwt), hn]
  have hcrit : Qop2 M = θ • M := sphere_isCritical2 T hp2 hq2 t
  set D : ℝ := (T.card : ℝ) + Tᶜ.card - 2 with hDdef
  have hD : 0 < D := by rw [hDdef, hqR]; linarith
  obtain ⟨C, hC, hPb⟩ := abs_Pcubic2_le_rec (ι := Fin n)
  set κ : ℝ := 3 * θ / (2 * D) with hκdef
  have hκ : 0 < κ := by positivity
  refine ⟨min 1 ((κ / (C + 1)) ^ 2), lt_min one_pos (by positivity), ?_⟩
  rintro V hVW hV1 ⟨U, hU, hUd⟩
  obtain ⟨U₀, hU₀, hmax⟩ := exists_max V M
  set V' := rotR U₀ V with hV'def
  have hV'W : IsWeyl2 V' := rotR_isWeyl2 hU₀ hVW
  have hV'1 : normSq2 V' = 1 := by rw [hV'def, normSq2_rotR hU₀ hVW, hV1]
  set a := innerOp2 V' M with hadef
  -- the distance at the maximiser is the smallest
  have hUW : IsWeyl2 (rotR U V) := rotR_isWeyl2 hU hVW
  have hU1 : normSq2 (rotR U V) = 1 := by rw [normSq2_rotR hU hVW, hV1]
  have hd' : normSq2 (V' - M) = 2 - 2 * a := by rw [normSq2_sub, hV'1, ha1]; ring
  have hdU : normSq2 (rotR U V - M) = 2 - 2 * innerOp2 (rotR U V) M := by rw [normSq2_sub, hU1, ha1]; ring
  have hle := hmax U hU
  have hδ1 : min 1 ((κ / (C + 1)) ^ 2) ≤ 1 := min_le_left _ _
  have hδ2 : min 1 ((κ / (C + 1)) ^ 2) ≤ (κ / (C + 1)) ^ 2 := min_le_right _ _
  have hsmall : 2 - 2 * a < min 1 ((κ / (C + 1)) ^ 2) := by linarith
  have ha_half : 1 / 2 < a := by linarith
  -- the decomposition `V' = a M + h`
  set h := V' - a • M with hhdef
  have hhW : IsWeyl2 h := HamiltonsCubic.L214Frame.isWeyl2_sub' hV'W (isWeyl2_smul a hMW)
  have hperp : innerOp2 M h = 0 := by
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, show innerOp2 M M = 1 from ha1, ← hadef]; ring
  have hu : normSq2 h = 1 - a ^ 2 := by
    rw [hhdef, normSq2_sub, hV'1, innerOp2_smul_right, ← hadef]
    unfold normSq2
    rw [innerOp2_smul_left, innerOp2_smul_right]
    unfold normSq2 at ha1
    rw [ha1]; ring
  have hdecomp : V' = a • M + h := by rw [hhdef]; abel
  -- `h` is orthogonal to the `1/2`-eigenvectors
  have hgen : ∀ q : ↥(T ×ˢ Tᶜ), innerOp2 (crossOrbit T t q) h = 0 := by
    intro q
    obtain ⟨hj, hk⟩ := mem_cross T q
    have hjk : q.1.1 ≠ q.1.2 := fun e => hk (e ▸ hj)
    have hprops := orbitOp_props T hp2 hq2 t ht hn hj hk
    have hOM : innerOp2 (crossOrbit T t q) M = 0 := by
      rw [innerOp2_comm]; exact hprops.2.2.2.1
    have hOV : innerOp2 (crossOrbit T t q) V' = 0 := by
      show innerOp2 (orbitOp T t q.1.1 q.1.2) V' = 0
      rw [orbitOp_eq T t hjk, innerOp2_smul_left]
      have := first_order hwt hVW hU₀ (fun U hU => by rw [hcoord]; exact hmax U hU) hjk
      rw [this]; ring
    rw [hhdef, innerOp2_comm, innerOp2_sub_left', innerOp2_smul_left, innerOp2_comm V', innerOp2_comm M, hOV, hOM]
    ring
  have horb : ∀ K : CurvOp2 (Fin n), IsWeyl2 K → innerOp2 M K = 0 → LeLin M K = (1 / 2 : ℝ) • K → innerOp2 K h = 0 := by
    intro K hKW hKM hKe
    have hspan := (L27_half_span T hp3 hq3 hne t ht hn hKW).mp ⟨hKM, hKe⟩
    have hz : innerOp2 (0 : CurvOp2 (Fin n)) h = 0 := by
      have e := innerOp2_smul_left (0 : ℝ) h h
      rw [zero_mul] at e
      rw [← e]; congr 1; module
    have gen : ∀ K' ∈ Submodule.span ℝ (Set.range (crossOrbit T t)), innerOp2 K' h = 0 := by
      intro K' hK'
      induction hK' using Submodule.span_induction with
      | mem x hx =>
        obtain ⟨q, rfl⟩ := hx
        exact hgen q
      | zero => exact hz
      | add x y _ _ hx hy => rw [innerOp2_add_left, hx, hy, add_zero]
      | smul c x _ hx => rw [innerOp2_smul_left, hx, mul_zero]
    exact gen K hspan
  -- the Hessian bound and the Hessian form
  have hess := HamiltonsCubic.L3Quad.L3_hessian T hp hpq t ht hn hhW hperp horb
  have hq := hessQ_eq hMW hhW hcrit hperp
  rw [hPM] at hq
  -- the cubic expansion at `a M + h`
  have hexp : Pcubic2 V' = a ^ 3 * θ + 3 * a * innerOp2 M (Qop2 h) + Pcubic2 h := by
    rw [hdecomp, Pcubic2_expand, Pcubic2_smul, hPM, Pcubic2Lin_selfAdjoint (isWeyl2_smul a hMW).isSelfAdjoint2,
      Pcubic2Quad_selfAdjoint hhW.isSelfAdjoint2, Qop2_smul, hcrit, smul_smul, innerOp2_smul_right, innerOp2_smul_left,
      innerOp2_comm h M, hperp]
    ring
  have hPV : Pcubic2 V = Pcubic2 V' := (Pcubic2_rotR hU₀ hVW).symm
  have hu0 : 0 ≤ normSq2 h := innerOp2_self_nonneg h
  clear_value h a V' κ D θ
  have ha_le : a ≤ 1 := by nlinarith [hu, hu0]
  by_cases hz : normSq2 h = 0
  · right
    refine ⟨U₀, hU₀, ?_⟩
    have h0 : h = 0 := normSq2_eq_zero hz
    have e : (a - 1) * (a + 1) = 0 := by
      have : 1 - a ^ 2 = 0 := by rw [← hu, hz]
      linear_combination -this
    have ha : a = 1 := by
      rcases mul_eq_zero.mp e with h1 | h1
      · linarith
      · linarith
    rw [← hV'def, hdecomp, h0, ha]
    module
  · left
    have hpos : 0 < normSq2 h := lt_of_le_of_ne hu0 (Ne.symm hz)
    set u := normSq2 h with hudef
    set r := Real.sqrt u with hrdef
    have hr0 : 0 < r := Real.sqrt_pos.mpr hpos
    have hr2 : r ^ 2 = u := Real.sq_sqrt hu0
    have hPh : |Pcubic2 h| ≤ C * r ^ 3 := hPb h
    have hPh' : Pcubic2 h ≤ C * r ^ 3 := le_trans (le_abs_self _) hPh
    -- `u` is small
    have hu2 : u ≤ 2 * (1 - a) := by
      have e : u = 2 * (1 - a) - (1 - a) ^ 2 := by rw [hu]; ring
      have := sq_nonneg (1 - a)
      linarith only [e, this]
    have hu_small : u < (κ / (C + 1)) ^ 2 := by linarith only [hu2, hsmall, hδ2]
    have hr_small : r < κ / (C + 1) := by
      rw [hrdef]
      calc Real.sqrt u < Real.sqrt ((κ / (C + 1)) ^ 2) := Real.sqrt_lt_sqrt hu0 hu_small
        _ = κ / (C + 1) := Real.sqrt_sq (by positivity)
    have hC1 : 0 < C + 1 := by linarith only [hC]
    have hCr : C * r < κ := by
      have h1 : r * (C + 1) < κ := (lt_div_iff₀ hC1).mp hr_small
      nlinarith only [h1, hr0, hC]
    -- the Hessian term
    have hMQ : 3 * innerOp2 M (Qop2 h) ≤ -(3 * θ / D) * u + 3 / 2 * θ * u := by
      have hi : innerOp2 h h = u := rfl
      rw [hi] at hq
      have hD' : θ * (T.card + Tᶜ.card - 1) = θ * (T.card + Tᶜ.card - 1) := rfl
      have hh : hessQ M h ≤ -(6 * θ / D) * u := by
        have := hess
        rw [← hθdef, ← hDdef] at this
        exact this
      have e : -(6 * θ / D) * u = 2 * (-(3 * θ / D) * u) := by ring
      linarith only [hh, hq, e]
    have hcubic : a ^ 3 * θ + a * (3 / 2 * θ * u) ≤ θ := by
      have hua : u = 1 - a ^ 2 := hu
      rw [hua]
      have e : θ - (a ^ 3 * θ + a * (3 / 2 * θ * (1 - a ^ 2))) = θ / 2 * ((a - 1) ^ 2 * (a + 2)) := by ring
      have h1 : 0 ≤ (a - 1) ^ 2 * (a + 2) := mul_nonneg (sq_nonneg _) (by linarith only [ha_half])
      have h2 : 0 ≤ θ / 2 * ((a - 1) ^ 2 * (a + 2)) := mul_nonneg (by linarith only [hθ]) h1
      linarith only [e, h2]
    have hlin : a * (-(3 * θ / D) * u) ≤ -κ * u := by
      have hθD : 0 < 3 * θ / D := div_pos (by linarith only [hθ]) hD
      have hk : κ = 3 * θ / D * (1 / 2) := by rw [hκdef]; field_simp
      rw [hk]
      have hprod : 0 < 3 * θ / D * u := mul_pos hθD hpos
      nlinarith only [hprod, ha_half]
    rw [hPV, hexp, hPM]
    have ha0 : 0 < a := by linarith only [ha_half]
    have hstep : 3 * a * innerOp2 M (Qop2 h) ≤ a * (-(3 * θ / D) * u + 3 / 2 * θ * u) := by
      have := mul_le_mul_of_nonneg_left hMQ ha0.le
      linarith only [this]
    have hr3 : C * r ^ 3 = C * r * u := by rw [← hr2]; ring
    have hgap : 0 < u * (κ - C * r) := mul_pos hpos (by linarith only [hCr])
    linarith only [hstep, hcubic, hlin, hPh', hr3, hgap]

end HamiltonsCubic.L3Local
