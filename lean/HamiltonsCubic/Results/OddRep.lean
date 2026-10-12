import Mathlib
import HamiltonsCubic.Results.L268Rep
import HamiltonsCubic.Results.OddTorus
import HamiltonsCubic.Results.TorusEmbed

set_option linter.style.longLine false

/-!
# L280: every torus-invariant symmetric operator on so(2m+1) is `torusOpOdd`

[findings/second-order.md](../../../findings/second-order.md), Lemma L280: *"On $\mathfrak{so}(2m+1)$ ... every
torus-invariant symmetric $C$ is $A\oplus\bigoplus_\alpha\mu_\alpha I_{R_\alpha}$"*, the short root planes being
$R_{\varepsilon_i}=\operatorname{span}\{e_{2i-1}\wedge e_{2m+1},e_{2i}\wedge e_{2m+1}\}$. On the index
`Option (Fin m × Fin 2)` (`none` is $e_{2m+1}$), torus invariance is `derOp (JO x) C = 0` for every `x`, `JO x` the
Cartan vector `J_x` of `𝔰𝔬(2m)` embedded, and symmetry is self-adjointness for `inner2`. This file:

* `restrict_C_sv`, `C_embed_old`: `C` sends each short vector `sv p = e_p ∧ e_none` into `𝔭 = span(e_a ∧ e_none)` and
  `𝔰𝔬(2m)` into itself, separated by `ad_{J_x}²` and `ad_{J_k + J_l}²` (`sepG`, `ad2J_sv`, `ad2W_sv`);
* `comp0`, `comp0_inv`, `comp0_sa`: the `𝔰𝔬(2m)` block is torus-invariant and self-adjoint, so [L268Rep.lean](L268Rep.lean)'s
  `L268_rep` makes it `torusOp`;
* `C_sv`: `C (sv (i, c)) = w_i sv (i, c)` with `w_i = wOf C i`, the rotation by `ad_{J_i}` fixing the plane's diagonal;
* `L280_rep`: `C = torusOpOdd A U V w` with the Gram values of its blocks;
* `H_torus_slice_odd_op` (L281) and `H_small_odd_op` (L282 (2)): H at every such `C`, through `L280_rep`.
-/

namespace HamiltonsCubic.OddRep

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.OddTorus HamiltonsCubic.L268Rep

section General

variable {κ : Type*} [Fintype κ] [DecidableEq κ]

/-- A skew matrix orthogonal to every coordinate bivector vanishes. -/
theorem skew_zero_of_phi (Z : skewSub κ) (h : ∀ a b, inner2 (Z : Matrix κ κ ℝ) (phi a b) = 0) : Z = 0 := by
  have hZ : (Z : Matrix κ κ ℝ)ᵀ = -(Z : Matrix κ κ ℝ) := Z.2
  apply Subtype.ext
  ext a b
  have h1 := h a b
  rw [inner2_phi_r] at h1
  have h2 : (Z : Matrix κ κ ℝ) b a = -(Z : Matrix κ κ ℝ) a b := by
    rw [← Matrix.transpose_apply (Z : Matrix κ κ ℝ) a b, hZ, Matrix.neg_apply]
  rw [h2] at h1
  show (Z : Matrix κ κ ℝ) a b = 0
  linarith

theorem inner2_ad2G (W : skewSub κ) (D : CurvOp2 κ) (hD : derOp W D = 0) (X Y : skewSub κ) :
    inner2 ((D (brS W (brS W X)) : skewSub κ) : Matrix κ κ ℝ) (Y : Matrix κ κ ℝ)
      = inner2 ((D X : skewSub κ) : Matrix κ κ ℝ) ((brS W (brS W Y) : skewSub κ) : Matrix κ κ ℝ) := by
  have hc : ∀ Z, D (brS W Z) = brS W (D Z) := fun Z => by
    have := congrArg (fun T : CurvOp2 κ => T Z) hD
    simp only [derOp_apply, _root_.zero_apply] at this
    exact (sub_eq_zero.mp this).symm
  rw [hc, hc, inner2_brS_skew, inner2_brS_skew]
  ring

theorem sepG (W : skewSub κ) (D : CurvOp2 κ) (hW : derOp W D = 0) (a b : ℝ) (e e' : skewSub κ)
    (he : brS W (brS W e) = a • e) (he' : brS W (brS W e') = b • e') (hab : a ≠ b) :
    inner2 ((D e : skewSub κ) : Matrix κ κ ℝ) (e' : Matrix κ κ ℝ) = 0 := by
  have h := inner2_ad2G W D hW e e'
  rw [he, he', map_smul, Submodule.coe_smul, Submodule.coe_smul, i2_smul_l, i2_smul_r] at h
  have : (a - b) * inner2 ((D e : skewSub κ) : Matrix κ κ ℝ) (e' : Matrix κ κ ℝ) = 0 := by linarith
  exact (mul_eq_zero.mp this).resolve_left (sub_ne_zero.mpr hab)

theorem derOp_add_leftG (X Y : skewSub κ) (R : CurvOp2 κ) : derOp (X + Y) R = derOp X R + derOp Y R := by
  refine ContinuousLinearMap.ext fun Z => ?_
  simp only [derOp_apply, _root_.add_apply, brS_add_left, map_add]
  abel

end General

variable {m : ℕ}

local notation "OI" => Option (Fin m × Fin 2)
local notation "SKO" => skewSub (Option (Fin m × Fin 2))
local notation "MO" => Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ

/-- The short root vector `e_p ∧ e_none`. -/
def sv (p : Fin m × Fin 2) : SKO := phiS (some p) none

/-- The Cartan vector `J_x` of `𝔰𝔬(2m)` inside `𝔰𝔬(2m + 1)`. -/
noncomputable def JO (x : Fin m) : SKO := embedL (cartS x)

theorem JO_eq (x : Fin m) : JO x = phiS (some (x, 0)) (some (x, 1)) := embedL_phi _ _

theorem brJ_sv0 (x i : Fin m) : brS (JO x) (sv (i, 0)) = (if x = i then (1 : ℝ) else 0) • sv (i, 1) := by
  rw [JO_eq, sv, sv, brS_phiS]
  by_cases h : x = i
  · subst h; simp [phiS_self]
  · simp [h, Ne.symm h]

theorem brJ_sv1 (x i : Fin m) : brS (JO x) (sv (i, 1)) = (-(if x = i then (1 : ℝ) else 0)) • sv (i, 0) := by
  rw [JO_eq, sv, sv, brS_phiS]
  by_cases h : x = i
  · subst h; simp only [phiS_self, if_true, if_false, Option.some.injEq, Prod.mk.injEq, true_and, reduceCtorEq]; simp; try exact (neg_one_smul ℝ _).symm
  · simp [h, Ne.symm h]

/-- `δ_xi`. -/
def dl (x i : Fin m) : ℝ := if x = i then 1 else 0

theorem brW_sv0 (x y i : Fin m) : brS (JO x + JO y) (sv (i, 0)) = (dl x i + dl y i) • sv (i, 1) := by
  rw [brS_add_left, brJ_sv0, brJ_sv0, add_smul]; rfl

theorem brW_sv1 (x y i : Fin m) : brS (JO x + JO y) (sv (i, 1)) = (-(dl x i + dl y i)) • sv (i, 0) := by
  rw [brS_add_left, brJ_sv1, brJ_sv1, ← add_smul]; congr 1; unfold dl; ring

/-- `ad_{J_x + J_y}²` on a short vector is `-(δ_xi + δ_yi)²`. -/
theorem ad2W_sv (x y i : Fin m) (c : Fin 2) :
    brS (JO x + JO y) (brS (JO x + JO y) (sv (i, c))) = (-((dl x i + dl y i) ^ 2)) • sv (i, c) := by
  fin_cases c
  · show brS (JO x + JO y) (brS (JO x + JO y) (sv (i, 0))) = _
    rw [brW_sv0, brS_smul_right, brW_sv1, smul_smul]
    congr 1; ring
  · show brS (JO x + JO y) (brS (JO x + JO y) (sv (i, 1))) = _
    rw [brW_sv1, brS_smul_right, brW_sv0, smul_smul]
    congr 1; ring

theorem JO_add (x y : Fin m) : JO x + JO y = embedL (cartS x + cartS y) := by
  rw [JO, JO, map_add]

theorem JO_eq' (x : Fin m) : JO x = JO x + JO x - JO x := by abel

theorem ad2J_sv (x i : Fin m) (c : Fin 2) :
    brS (JO x) (brS (JO x) (sv (i, c))) = (-(dl x i)) • sv (i, c) := by
  fin_cases c
  · show brS (JO x) (brS (JO x) (sv (i, 0))) = _
    rw [brJ_sv0, brS_smul_right, brJ_sv1, smul_smul]
    congr 1; unfold dl; split_ifs <;> norm_num
  · show brS (JO x) (brS (JO x) (sv (i, 1))) = _
    rw [brJ_sv1, brS_smul_right, brJ_sv0, smul_smul]
    congr 1; unfold dl; split_ifs <;> norm_num

theorem ad2_embed (W Y : skewSub (Fin m × Fin 2)) :
    brS (embedL W) (brS (embedL W) (embedL Y)) = embedL (brS W (brS W Y)) := by
  rw [brS_embedL, brS_embedL]

theorem sigT_pair_sq (k l : Fin m) (hkl : k ≠ l) (t : Fin 4) :
    (sigT k k l t + sigT l k l t) ^ 2 = 0 ∨ (sigT k k l t + sigT l k l t) ^ 2 = 4 := by
  fin_cases t <;> simp [sigT, hkl, Ne.symm hkl] <;> norm_num

section Rep

variable (C : CurvOp2 (Option (Fin m × Fin 2))) (hT : ∀ x, derOp (JO x) C = 0)
  (hsa : ∀ X Y : skewSub (Option (Fin m × Fin 2)),
    inner2 ((C X : skewSub (Option (Fin m × Fin 2))) : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)
        (Y : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)
      = inner2 (X : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)
        ((C Y : skewSub (Option (Fin m × Fin 2))) : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ))

include hT in
/-- **A short vector's image has no `𝔰𝔬(2m)` component.** -/
theorem restrict_C_sv (p : Fin m × Fin 2) : restrictL (C (sv p)) = 0 := by
  obtain ⟨i, c⟩ := p
  have hWp : ∀ x y, derOp (JO x + JO y) C = 0 := fun x y => by
    rw [derOp_add_leftG, hT, hT]; exact ContinuousLinearMap.ext fun _ => by simp
  refine vec_zero_of_basis _ (fun k => ?_) (fun k l t hkl => ?_)
  · show inner2 (restrictM ((C (sv (i, c)) : SKO) : MO)) ((cartS k : skewSub (Fin m × Fin 2)) : Matrix _ _ ℝ) = 0
    rw [← inner2_embedM_r]
    refine sepG (JO i) C (hT i) (-(dl i i)) 0 (sv (i, c)) (embedL (cartS k)) (ad2J_sv i i c) ?_ ?_
    · rw [JO, ad2_embed, ad2_cartS, map_zero, zero_smul]
    · simp [dl]
  · show inner2 (restrictM ((C (sv (i, c)) : SKO) : MO)) ((rootS k l t : skewSub (Fin m × Fin 2)) : Matrix _ _ ℝ) = 0
    rw [← inner2_embedM_r]
    by_cases hik : i = k
    · subst hik
      refine sepG (JO i + JO l) C (hWp i l) (-((dl i i + dl l i) ^ 2)) (-((sigT i i l t + sigT l i l t) ^ 2))
        (sv (i, c)) (embedL (rootS i l t)) (ad2W_sv i l i c) ?_ ?_
      · rw [JO_add, ad2_embed, ad2_pair_rootS i l i l hkl t, map_smul]
      · have h1 : dl i i + dl l i = 1 := by simp [dl, Ne.symm hkl]
        rw [h1]
        rcases sigT_pair_sq i l hkl t with h | h <;> rw [h] <;> norm_num
    by_cases hil : i = l
    · subst hil
      refine sepG (JO k + JO i) C (hWp k i) (-((dl k i + dl i i) ^ 2)) (-((sigT k k i t + sigT i k i t) ^ 2))
        (sv (i, c)) (embedL (rootS k i t)) (ad2W_sv k i i c) ?_ ?_
      · rw [JO_add, ad2_embed, ad2_pair_rootS k i k i hkl t, map_smul]
      · have h1 : dl k i + dl i i = 1 := by simp [dl, hkl]
        rw [h1]
        rcases sigT_pair_sq k i hkl t with h | h <;> rw [h] <;> norm_num
    · refine sepG (JO i) C (hT i) (-(dl i i)) (-(sigT i k l t ^ 2)) (sv (i, c)) (embedL (rootS k l t))
        (ad2J_sv i i c) ?_ ?_
      · rw [JO, ad2_embed, ad2_rootS i k l hkl t, map_smul]
      · rw [sigT_out i k l hik hil]; simp [dl]

end Rep

theorem sv_coe (p : Fin m × Fin 2) : ((sv p : SKO) : MO) = phi (some p) none := rfl

theorem inner2_sv_sv (p q : Fin m × Fin 2) :
    inner2 ((sv p : SKO) : MO) ((sv q : SKO) : MO) = if p = q then 1 else 0 := by
  rw [sv_coe, sv_coe, inner2_phi_r]
  by_cases h : p = q
  · subst h; simp [phi, Matrix.single_apply]; norm_num
  · simp [phi, Matrix.single_apply, h, Ne.symm h]

theorem old_embed (X : SKO) (h : IsOld (X : MO)) : embedL (restrictL X) = X := by
  apply Subtype.ext
  ext a b
  show embedM (restrictM (X : MO)) a b = (X : MO) a b
  rcases a with _ | a <;> rcases b with _ | b
  · exact ((h none).1).symm
  · exact ((h (some b)).2).symm
  · exact ((h (some a)).1).symm
  · rfl

theorem embed_old (Y : skewSub (Fin m × Fin 2)) : IsOld ((embedL Y : SKO) : MO) := by
  intro a; cases a <;> exact ⟨rfl, rfl⟩

/-- The `𝔰𝔬(2m)` block of an operator on `𝔰𝔬(2m + 1)`. -/
noncomputable def comp0 (C : CurvOp2 (Option (Fin m × Fin 2))) : CurvOp2 (Fin m × Fin 2) :=
  LinearMap.toContinuousLinearMap (restrictL ∘ₗ (C : SKO →ₗ[ℝ] SKO) ∘ₗ embedL)

theorem comp0_apply (C : CurvOp2 (Option (Fin m × Fin 2))) (Y : skewSub (Fin m × Fin 2)) :
    comp0 C Y = restrictL (C (embedL Y)) := rfl

/-- The weight of `C` on the short root plane `R_{ε_i}`. -/
noncomputable def wOf (C : CurvOp2 (Option (Fin m × Fin 2))) (i : Fin m) : ℝ :=
  inner2 ((C (sv (i, 0)) : SKO) : MO) ((sv (i, 0) : SKO) : MO)

theorem shortOp_sv (w : Fin m → ℝ) (p : Fin m × Fin 2) : shortOp w (sv p) = w p.1 • sv p := by
  apply Subtype.ext
  ext a b
  rw [shortOp_apply, Submodule.coe_smul, Matrix.smul_apply, smul_eq_mul]
  show shortW w a b * phi (some p) none a b = w p.1 * phi (some p) none a b
  rcases a with _ | a <;> rcases b with _ | b <;> simp [shortW, phi, Matrix.single_apply] <;>
    first | (split_ifs <;> simp_all) | skip

section Rep2

variable (C : CurvOp2 (Option (Fin m × Fin 2))) (hT : ∀ x, derOp (JO x) C = 0)
  (hsa : ∀ X Y : skewSub (Option (Fin m × Fin 2)),
    inner2 ((C X : skewSub (Option (Fin m × Fin 2))) : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)
        (Y : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)
      = inner2 (X : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)
        ((C Y : skewSub (Option (Fin m × Fin 2))) : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ))

include hT hsa

/-- **`C` keeps `𝔰𝔬(2m)` inside `𝔰𝔬(2m)`.** -/
theorem C_embed_old (Y : skewSub (Fin m × Fin 2)) : IsOld ((C (embedL Y) : SKO) : MO) := by
  have hX : ((C (embedL Y) : SKO) : MO)ᵀ = -((C (embedL Y) : SKO) : MO) := (C (embedL Y)).2
  have hs : ∀ a b, ((C (embedL Y) : SKO) : MO) b a = -((C (embedL Y) : SKO) : MO) a b := fun a b => by
    rw [← Matrix.transpose_apply ((C (embedL Y) : SKO) : MO) a b, hX, Matrix.neg_apply]
  have h1 : ∀ q, inner2 ((C (embedL Y) : SKO) : MO) ((sv q : SKO) : MO) = 0 := fun q => by
    rw [hsa]
    have e : ((embedL Y : SKO) : MO) = embedM (Y : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) := rfl
    have h' : restrictM ((C (sv q) : SKO) : MO) = 0 := congrArg Subtype.val (restrict_C_sv C hT q)
    rw [e, inner2_embedM_l, h']
    simp [inner2]
  have hq : ∀ q, ((C (embedL Y) : SKO) : MO) (some q) none = 0 := fun q => by
    have h := h1 q
    rw [sv_coe, inner2_phi_r, hs] at h
    linarith
  intro a
  rcases a with _ | a
  · have := hs none none; exact ⟨by linarith, by linarith⟩
  · exact ⟨hq a, by rw [hs, hq a, neg_zero]⟩

theorem C_embed (Y : skewSub (Fin m × Fin 2)) : C (embedL Y) = embedL (comp0 C Y) :=
  (old_embed _ (C_embed_old C hT hsa Y)).symm

theorem comp0_inv (x : Fin m) : derOp (cartS x) (comp0 C) = 0 := by
  refine ContinuousLinearMap.ext fun Y => ?_
  have hc : ∀ Z, C (brS (JO x) Z) = brS (JO x) (C Z) := fun Z => by
    have := congrArg (fun T : CurvOp2 (Option (Fin m × Fin 2)) => T Z) (hT x)
    simp only [derOp_apply, _root_.zero_apply] at this
    exact (sub_eq_zero.mp this).symm
  rw [derOp_apply, comp0_apply C (brS (cartS x) Y), ← brS_embedL, ← JO, hc, C_embed C hT hsa Y, JO, brS_embedL,
    restrictL_embedL, sub_self, _root_.zero_apply]

omit hT in
theorem comp0_sa (X Y : skewSub (Fin m × Fin 2)) :
    inner2 ((comp0 C X : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
        (Y : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
      = inner2 (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
        ((comp0 C Y : skewSub (Fin m × Fin 2)) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) := by
  show inner2 (restrictM ((C (embedL X) : SKO) : MO)) (Y : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)
    = inner2 (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (restrictM ((C (embedL Y) : SKO) : MO))
  rw [← inner2_embedM_r, ← inner2_embedM_l]
  exact hsa (embedL X) (embedL Y)

omit hsa in
theorem hc_JO (i : Fin m) (Z : SKO) : C (brS (JO i) Z) = brS (JO i) (C Z) := by
  have := congrArg (fun T : CurvOp2 (Option (Fin m × Fin 2)) => T Z) (hT i)
  simp only [derOp_apply, _root_.zero_apply] at this
  exact (sub_eq_zero.mp this).symm

omit hT hsa in
theorem sv1_eq (i : Fin m) : sv (i, 1) = brS (JO i) (sv (i, 0)) := by
  rw [brJ_sv0]; simp

omit hsa in
theorem short_cross (i j : Fin m) (hij : i ≠ j) (c d : Fin 2) :
    inner2 ((C (sv (i, c)) : SKO) : MO) ((sv (j, d) : SKO) : MO) = 0 :=
  sepG (JO i) C (hT i) (-(dl i i)) (-(dl i j)) _ _ (ad2J_sv i i c) (ad2J_sv i j d) (by simp [dl, hij])

theorem short_rot (i : Fin m) : inner2 ((C (sv (i, 0)) : SKO) : MO) ((sv (i, 1) : SKO) : MO) = 0 := by
  have h := inner2_brS_skew (JO i) (C (sv (i, 0))) (sv (i, 0))
  rw [← hc_JO C hT i, ← sv1_eq, hsa, inner2_comm] at h
  linarith

theorem short_diag (i : Fin m) :
    inner2 ((C (sv (i, 1)) : SKO) : MO) ((sv (i, 1) : SKO) : MO) = wOf C i := by
  rw [sv1_eq, hc_JO C hT, inner2_brS_skew, ← sv1_eq, brJ_sv1, Submodule.coe_smul, i2_smul_r, wOf]
  simp

theorem C_sv (p : Fin m × Fin 2) : C (sv p) = wOf C p.1 • sv p := by
  obtain ⟨i, c⟩ := p
  rw [← sub_eq_zero]
  refine skew_zero_of_phi _ fun a b => ?_
  have key : ∀ q, inner2 (((C (sv (i, c)) - wOf C i • sv (i, c) : SKO)) : MO) ((sv q : SKO) : MO) = 0 := by
    intro q
    obtain ⟨j, d⟩ := q
    rw [Submodule.coe_sub, Submodule.coe_smul, i2_sub_l, i2_smul_l, inner2_sv_sv]
    by_cases hij : i = j
    · subst hij
      fin_cases c <;> fin_cases d
      · simp [wOf]
      · simp [short_rot C hT hsa]
      · show inner2 ((C (sv (i, 1)) : SKO) : MO) ((sv (i, 0) : SKO) : MO) - _ = 0
        rw [hsa, inner2_comm, short_rot C hT hsa]; simp
      · show inner2 ((C (sv (i, 1)) : SKO) : MO) ((sv (i, 1) : SKO) : MO) - _ = 0
        rw [short_diag C hT hsa]; simp
    · rw [short_cross C hT i j hij]; simp [hij]
  rcases a with _ | a <;> rcases b with _ | b
  · simp [phi, inner2]
  · have h := key b
    rw [sv_coe] at h
    rw [show (phi none (some b) : MO) = -phi (some b) none by simp [phi]]
    rw [show ∀ M N : MO, inner2 M (-N) = -inner2 M N from fun M N => by simp [inner2]]
    rw [h, neg_zero]
  · have h := key a
    rwa [sv_coe] at h
  · rw [← embedM_phi, inner2_embedM_r, Submodule.coe_sub, Submodule.coe_smul]
    have h1 := congrArg Subtype.val (restrict_C_sv C hT (i, c))
    have h2 : restrictM ((sv (i, c) : SKO) : MO) = 0 := restrictM_phi_none_r _
    have e : restrictM (((C (sv (i, c)) : SKO) : MO) - wOf C i • ((sv (i, c) : SKO) : MO))
        = restrictM ((C (sv (i, c)) : SKO) : MO) - wOf C i • restrictM ((sv (i, c) : SKO) : MO) := by
      ext p q; simp [restrictM]
    rw [e, h2]
    have h1' : restrictM ((C (sv (i, c)) : SKO) : MO) = 0 := h1
    rw [h1']; simp [inner2]

end Rep2

section Main

variable (C : CurvOp2 (Option (Fin m × Fin 2))) (hT : ∀ x, derOp (JO x) C = 0)
  (hsa : ∀ X Y : skewSub (Option (Fin m × Fin 2)),
    inner2 ((C X : skewSub (Option (Fin m × Fin 2))) : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)
        (Y : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)
      = inner2 (X : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ)
        ((C Y : skewSub (Option (Fin m × Fin 2))) : Matrix (Option (Fin m × Fin 2)) (Option (Fin m × Fin 2)) ℝ))

include hT hsa

/-- **Every torus-invariant symmetric operator on `𝔰𝔬(2m + 1)` is `torusOpOdd`**: `C` commuting with every
`ad_{J_x}` and self-adjoint is `A ⊕ ⊕_α μ_α I_{R_α}` over the long and the short roots, with `A`, `U`, `V` the Gram
values of its `𝔰𝔬(2m)` block `comp0 C` and `w_i` its weight on `R_{ε_i}`. -/
theorem L280_rep :
    C = torusOpOdd (Aof (comp0 C)) (Uof (comp0 C)) (Vof (comp0 C)) (wOf C) ∧ (Aof (comp0 C))ᵀ = Aof (comp0 C) ∧
      IsPairWeights (Uof (comp0 C)) ∧ IsPairWeights (Vof (comp0 C)) := by
  obtain ⟨hrep0, hA, hU, hV⟩ := L268_rep (comp0 C) (comp0_inv C hT hsa) (comp0_sa C hsa)
  refine ⟨?_, hA, hU, hV⟩
  set T := torusOp (Aof (comp0 C)) (Uof (comp0 C)) (Vof (comp0 C)) with hTdef
  have hTsa := torusOp_isSelfAdjoint2 (Aof (comp0 C)) (Uof (comp0 C)) (Vof (comp0 C)) hA
  have hEsa := extOp_isSelfAdjoint2 T hTsa
  have hSsa := shortOp_isSelfAdjoint2 (wOf C)
  have hOsa : ∀ X Y : SKO, inner2 ((torusOpOdd (Aof (comp0 C)) (Uof (comp0 C)) (Vof (comp0 C)) (wOf C) X : SKO) : MO)
      (Y : MO) = inner2 (X : MO) ((torusOpOdd (Aof (comp0 C)) (Uof (comp0 C)) (Vof (comp0 C)) (wOf C) Y : SKO) : MO) := by
    intro X Y
    simp only [torusOpOdd, _root_.add_apply, Submodule.coe_add, i2_add_l, i2_add_r]
    rw [hEsa X Y, hSsa X Y]
  have hphi : ∀ a b, C (phiS a b) = torusOpOdd (Aof (comp0 C)) (Uof (comp0 C)) (Vof (comp0 C)) (wOf C) (phiS a b) := by
    have hsv : ∀ q, C (sv q) = torusOpOdd (Aof (comp0 C)) (Uof (comp0 C)) (Vof (comp0 C)) (wOf C) (sv q) := fun q => by
      have hr : restrictL (sv q) = 0 := restrictL_phi_none_r _
      rw [C_sv C hT hsa, torusOpOdd, _root_.add_apply, extOp_apply, hr, map_zero, map_zero, zero_add, shortOp_sv]
    intro a b
    rcases a with _ | a <;> rcases b with _ | b
    · rw [phiS_self, map_zero, map_zero]
    · have e : phiS (none : OI) (some b) = -sv b := I117S.phiS_swap (some b) none
      rw [e, map_neg, map_neg, hsv]
    · exact hsv a
    · have e : phiS (some a) (some b) = embedL (phiS a b) := (embedL_phi a b).symm
      rw [e, C_embed C hT hsa, torusOpOdd, _root_.add_apply, extOp_apply, restrictL_embedL,
        shortOp_kills_old _ _ (embed_old _), add_zero]
      exact congrArg (fun R : CurvOp2 (Fin m × Fin 2) => embedL (R (phiS a b))) hrep0
  refine ContinuousLinearMap.ext fun X => ?_
  rw [← sub_eq_zero]
  refine skew_zero_of_phi _ fun a b => ?_
  have e : (phi a b : MO) = ((phiS a b : SKO) : MO) := rfl
  rw [Submodule.coe_sub, i2_sub_l, e, hsa, hOsa, ← i2_sub_r', ← Submodule.coe_sub, hphi, sub_self]
  simp [inner2]

end Main

/-- **L281 for every torus-invariant self-adjoint operator on `𝔰𝔬(2m + 1)`**, `m = n + 1 ≥ 7`. -/
theorem H_torus_slice_odd_op (n : ℕ) (hn : 6 ≤ n) (C : CurvOp2 (Option (Fin (n + 1) × Fin 2)))
    (hT : ∀ x, derOp (JO x) C = 0)
    (hsa : ∀ X Y : skewSub (Option (Fin (n + 1) × Fin 2)),
      inner2 ((C X : skewSub (Option (Fin (n + 1) × Fin 2))) : Matrix (Option (Fin (n + 1) × Fin 2)) (Option (Fin (n + 1) × Fin 2)) ℝ)
          (Y : Matrix (Option (Fin (n + 1) × Fin 2)) (Option (Fin (n + 1) × Fin 2)) ℝ)
        = inner2 (X : Matrix (Option (Fin (n + 1) × Fin 2)) (Option (Fin (n + 1) × Fin 2)) ℝ)
          ((C Y : skewSub (Option (Fin (n + 1) × Fin 2))) : Matrix (Option (Fin (n + 1) × Fin 2)) (Option (Fin (n + 1) × Fin 2)) ℝ)) :
    Ftri C C C ≤ (2 * ((n : ℝ) + 1) - 1) / Real.sqrt (((n : ℝ) + 1) * (2 * ((n : ℝ) + 1) + 1))
      * (normSq2 C) ^ ((3 : ℝ) / 2) := by
  obtain ⟨hrep, hA, hU, hV⟩ := L280_rep C hT hsa
  rw [hrep]
  exact H_torus_slice_odd n hn _ _ _ _ hA hU hV

/-- **L282 (2) for every torus-invariant self-adjoint operator on `𝔰𝔬(2(j + 1) + 1)`**, `M ≥ 7`, `j + 2 ≤ M`. -/
theorem H_small_odd_op (M : ℕ) (hM : 7 ≤ M) (j : ℕ) (hj : j + 2 ≤ M) (C : CurvOp2 (Option (Fin (j + 1) × Fin 2)))
    (hT : ∀ x, derOp (JO x) C = 0)
    (hsa : ∀ X Y : skewSub (Option (Fin (j + 1) × Fin 2)),
      inner2 ((C X : skewSub (Option (Fin (j + 1) × Fin 2))) : Matrix (Option (Fin (j + 1) × Fin 2)) (Option (Fin (j + 1) × Fin 2)) ℝ)
          (Y : Matrix (Option (Fin (j + 1) × Fin 2)) (Option (Fin (j + 1) × Fin 2)) ℝ)
        = inner2 (X : Matrix (Option (Fin (j + 1) × Fin 2)) (Option (Fin (j + 1) × Fin 2)) ℝ)
          ((C Y : skewSub (Option (Fin (j + 1) × Fin 2))) : Matrix (Option (Fin (j + 1) × Fin 2)) (Option (Fin (j + 1) × Fin 2)) ℝ)) :
    Ftri C C C ≤ HamiltonsCubic.TorusEmbed.kapE M * (normSq2 C) ^ ((3 : ℝ) / 2) := by
  obtain ⟨hrep, hA, hU, hV⟩ := L280_rep C hT hsa
  rw [hrep]
  exact HamiltonsCubic.TorusEmbed.H_small_odd M hM j hj _ _ _ _ hA hU hV

end HamiltonsCubic.OddRep
