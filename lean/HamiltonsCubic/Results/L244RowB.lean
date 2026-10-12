import Mathlib
import HamiltonsCubic.Results.L209BianchiHalf
import HamiltonsCubic.Base.FoxBilinear

/-!
# L244, row (B) at every `n`: `I # W = −W` for every linear Weyl operator

[findings/second-order.md](../../../findings/second-order.md), Lemma L244 (i): "Pair
`∑_{a,b} λ_b B_ab = I#W = −W` (row (B), a Weyl identity)".

In the layer's normalisation `sharpQF (A + B) = sharpQF A + sharpQF B + mixSym A B`, so the mixed
quadratic form is `mixSym A B η = 2 ⟨(A#B) η, η⟩`, and row (B) reads
`mixSym id W η = −2 ⟨W η, η⟩` (`rowB`).

**The argument.** With `c_is = ⟨η, φ_is⟩`, `[η, φ_ij] = P − M`, `P = ∑_s c_js φ_is`,
`M = ∑_s c_is φ_js` (`br_eta_phi`). The key sum `K = ∑_ij ⟨W[η,φ_ij], [η,φ_ij]⟩` splits into four
double sums; two are Ricci contractions and vanish, the two cross sums agree by relabelling, and
the cross sum `S₁` equals its relabelling `S₂` (`S1_eq_S2`), while first Bianchi gives
`S₁ + S₂ = 4 ⟨Wη, η⟩`. So `K = −4 ⟨Wη, η⟩` (`key_sum`). Both halves of `mixSym id W` are
`−¼ ∑⟨W(ad_η² φ), φ⟩` by trace cyclicity on the `φ` basis (`trace_cyc`), and `mixQF W id = ¼ K`.
-/

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results

namespace HamiltonsCubic.L244RowB

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The coordinates `c_is = ⟨η, φ_is⟩`. -/
noncomputable def cc (η : Matrix ι ι ℝ) (i s : ι) : ℝ := inner2 η (phi i s)

theorem cc_anti (η : Matrix ι ι ℝ) (i s : ι) : cc η s i = -cc η i s := by
  unfold cc; rw [phi_swap, inner2_neg_right'']

/-- `[η, φ_ij] = ∑_s c_js φ_is − ∑_s c_is φ_js`. -/
theorem br_eta_phi (η : Matrix ι ι ℝ) (hη : IsSkew η) (i j : ι) :
    br η (phi i j) = (∑ s, cc η j s • phi i s) - ∑ s, cc η i s • phi j s := by
  have h := br_phi_skew i j η hη
  have hneg : br η (phi i j) = -br (phi i j) η := by unfold br; abel
  rw [hneg, h]; unfold cc; abel

/-- A linear operator between two coordinate sums. -/
theorem inner2_op_sums (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R) (x y : ι)
    (f g : ι → ℝ) :
    inner2 (R (∑ s, f s • phi x s)) (∑ t, g t • phi y t)
      = ∑ s, ∑ t, f s * g t * R4 R x s y t := by
  rw [linOp_sum R hR, inner2_sum_left']
  refine Finset.sum_congr rfl fun s _ => ?_
  rw [hR.2, FamilyLayer.inner2_smul_left, inner2_sum_right, Finset.mul_sum]
  refine Finset.sum_congr rfl fun t _ => ?_
  rw [FamilyLayer.inner2_smul_right]; unfold R4; ring

section key
variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hB : ∀ i j k l, bianchi R i j k l = 0) (hRic : ∀ a b, Ric R a b = 0)
    (η : Matrix ι ι ℝ) (hη : IsSkew η)

include hR hη in
theorem expand_ij (i j : ι) :
    inner2 (R (br η (phi i j))) (br η (phi i j))
      = ∑ s, ∑ t, cc η j s * cc η j t * R4 R i s i t
        - ∑ s, ∑ t, cc η j s * cc η i t * R4 R i s j t
        - ∑ s, ∑ t, cc η i s * cc η j t * R4 R j s i t
        + ∑ s, ∑ t, cc η i s * cc η i t * R4 R j s j t := by
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = -R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hsub : ∀ A B : Matrix ι ι ℝ, R (A - B) = R A - R B := fun A B => by
    rw [sub_eq_add_neg, hR.1, hneg, sub_eq_add_neg]
  rw [br_eta_phi η hη, hsub, inner2_sub_left', inner2_sub_right', inner2_sub_right',
    inner2_op_sums R hR, inner2_op_sums R hR, inner2_op_sums R hR, inner2_op_sums R hR]
  ring

include hR in
theorem R4_col (s t : ι) : ∑ i, R4 R i s i t = Ric R s t := by
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = -R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  unfold Ric R4
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [phi_swap i s, phi_swap i t, hneg, inner2_neg_left'', inner2_neg_right'', neg_neg]

theorem sum_rot3 (f : ι → ι → ι → ℝ) :
    ∑ a, ∑ b, ∑ c, f a b c = ∑ b, ∑ c, ∑ a, f a b c := by
  rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun b _ => ?_; rw [Finset.sum_comm]

theorem swap13 (f : ι → ι → ι → ι → ℝ) :
    ∑ i, ∑ j, ∑ s, ∑ t, f i j s t = ∑ i, ∑ j, ∑ s, ∑ t, f i t s j := by
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_comm]
  refine (Finset.sum_congr rfl fun s _ => Finset.sum_comm).trans ?_
  rw [Finset.sum_comm]

theorem sum_rot4 (f : ι → ι → ι → ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ b, ∑ c, ∑ d, ∑ a, f a b c d := by
  rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun b _ => ?_
  rw [Finset.sum_comm]; refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.sum_comm]

include hR hη in
/-- `⟨R η, η⟩ = ¼ ∑ c_ij c_kl R_ijkl`. -/
theorem quad_coord : 4 * inner2 (R η) η
    = ∑ a, ∑ b, ∑ c, ∑ d, cc η a b * cc η c d * R4 R a b c d := by
  have e := skew_expand η hη
  set E := ∑ i : ι, ∑ j : ι, (inner2 η (phi i j)) • phi i j with hE
  have hη' : η = (1/2 : ℝ) • E := e.symm
  have h1 : inner2 (R η) η = inner2 (R ((1/2 : ℝ) • E)) ((1/2 : ℝ) • E) := by rw [← hη']
  rw [h1, hR.2, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right, hE,
    linOp_sum R hR, inner2_sum_left']
  simp only [linOp_sum R hR, inner2_sum_left', hR.2, FamilyLayer.inner2_smul_left,
    inner2_sum_right, FamilyLayer.inner2_smul_right, Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => ?_
  refine ((sum_rot3 _).trans (sum_rot3 _)).trans ?_
  refine Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun c _ =>
    Finset.sum_congr rfl fun d _ => ?_
  unfold cc R4; ring

include hR hskew hsym hB hRic hη in
/-- **The key sum**: `∑_ij ⟨W[η, φ_ij], [η, φ_ij]⟩ = −4 ⟨W η, η⟩` for a linear Weyl operator. -/
theorem key_sum :
    ∑ i, ∑ j, inner2 (R (br η (phi i j))) (br η (phi i j)) = -4 * inner2 (R η) η := by
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = -R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hR4a : ∀ i j k l, R4 R j i k l = -R4 R i j k l := by
    intro i j k l; unfold R4; rw [phi_swap, hneg, inner2_neg_left'']
  have hP := R4_pair R hR hskew hsym
  have hA2 := R4_anti2 R hR
  simp only [expand_ij R hR η hη, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  -- the two Ricci contractions vanish
  have hA : ∑ i, ∑ j, ∑ s, ∑ t, cc η j s * cc η j t * R4 R i s i t = 0 := by
    rw [sum_rot4]
    refine Finset.sum_eq_zero fun j _ => Finset.sum_eq_zero fun s _ =>
      Finset.sum_eq_zero fun t _ => ?_
    rw [← Finset.mul_sum, R4_col R hR, hRic, mul_zero]
  have hD : ∑ i, ∑ j, ∑ s, ∑ t, cc η i s * cc η i t * R4 R j s j t = 0 := by
    refine Finset.sum_eq_zero fun i _ => ?_
    rw [sum_rot3]
    refine Finset.sum_eq_zero fun s _ => Finset.sum_eq_zero fun t _ => ?_
    rw [← Finset.mul_sum, R4_col R hR, hRic, mul_zero]
  -- the two cross sums agree under i ↔ j
  have hBC : ∑ i, ∑ j, ∑ s, ∑ t, cc η j s * cc η i t * R4 R i s j t
      = ∑ i, ∑ j, ∑ s, ∑ t, cc η i s * cc η j t * R4 R j s i t := Finset.sum_comm
  -- S₁ = S₂ by j ↔ t
  have hS : ∑ i, ∑ j, ∑ s, ∑ t, cc η i s * cc η j t * R4 R j s i t
      = ∑ i, ∑ j, ∑ s, ∑ t, cc η i s * cc η j t * R4 R i j s t := by
    rw [swap13 (fun i j s t => cc η i s * cc η j t * R4 R j s i t)]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ =>
      Finset.sum_congr rfl fun s _ => Finset.sum_congr rfl fun t _ => ?_
    rw [cc_anti η j t, hP t s i j, hA2 i j s t]; ring
  -- first Bianchi: S₁ + S₂ = Q₄
  have hBi : ∑ i, ∑ j, ∑ s, ∑ t, cc η i s * cc η j t * R4 R j s i t
      + ∑ i, ∑ j, ∑ s, ∑ t, cc η i s * cc η j t * R4 R i j s t
      = ∑ a, ∑ b, ∑ c, ∑ d, cc η a b * cc η c d * R4 R a b c d := by
    have hb : ∀ i j s t, R4 R j s i t + R4 R i j s t = -R4 R j t s i := by
      intro i j s t
      have h := hB j s i t
      unfold bianchi at h
      have e2 : inner2 (R (phi j i)) (phi t s) = R4 R i j s t := by
        change R4 R j i t s = R4 R i j s t
        rw [hR4a i j t s, hA2 i j s t, neg_neg]
      rw [e2] at h
      unfold R4 at *; linarith
    have hS3 : ∑ i, ∑ j, ∑ s, ∑ t, cc η i s * cc η j t * (-R4 R j t s i)
        = ∑ a, ∑ b, ∑ c, ∑ d, cc η a b * cc η c d * R4 R a b c d := by
      have hpt : ∀ i j s t, cc η i s * cc η j t * (-R4 R j t s i)
          = cc η s i * cc η j t * R4 R s i j t := by
        intro i j s t; rw [cc_anti η s i, hP j t s i]; ring
      simp only [hpt]
      rw [show (∑ i, ∑ j, ∑ s, ∑ t, cc η s i * cc η j t * R4 R s i j t)
          = ∑ i, ∑ s, ∑ j, ∑ t, cc η s i * cc η j t * R4 R s i j t from
        Finset.sum_congr rfl fun i _ => Finset.sum_comm]
      exact Finset.sum_comm
    rw [← hS3, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun s _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun t _ => ?_
    rw [← hb i j s t]; ring
  have hQ := quad_coord R hR η hη
  rw [hA, hD, hBC]
  linarith

end key

omit [DecidableEq ι] in
/-- `X ↦ [η, X]` is linear. -/
theorem ad_isLinOp (η : Matrix ι ι ℝ) : IsLinOp (fun X => br η X) :=
  ⟨fun X Y => by unfold br; simp only [Matrix.mul_add, Matrix.add_mul]; abel,
   fun c X => by unfold br; simp only [Matrix.mul_smul, Matrix.smul_mul, smul_sub]⟩

/-- **Trace cyclicity on the `φ` basis**: `∑ ⟨S(T φ_ij), φ_ij⟩ = ∑ ⟨T(S φ_ij), φ_ij⟩` for linear `S`,
`T` with skew values on the basis. -/
theorem trace_cyc (S T : Matrix ι ι ℝ → Matrix ι ι ℝ) (hS : IsLinOp S) (hT : IsLinOp T)
    (hSs : ∀ i j, IsSkew (S (phi i j))) (hTs : ∀ i j, IsSkew (T (phi i j))) :
    ∑ i, ∑ j, inner2 (S (T (phi i j))) (phi i j) = ∑ i, ∑ j, inner2 (T (S (phi i j))) (phi i j) := by
  have ex : ∀ (A B : Matrix ι ι ℝ → Matrix ι ι ℝ), IsLinOp A → (∀ i j, IsSkew (B (phi i j))) →
      ∀ i j, inner2 (A (B (phi i j))) (phi i j)
        = (1/2 : ℝ) * ∑ k, ∑ l, R4 B i j k l * R4 A k l i j := by
    intro A B hA hBs i j
    have e := skew_expand (B (phi i j)) (hBs i j)
    conv_lhs => rw [← e]
    rw [hA.2, FamilyLayer.inner2_smul_left, linOp_sum A hA, inner2_sum_left']
    congr 1
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [linOp_sum A hA, inner2_sum_left']
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [hA.2, FamilyLayer.inner2_smul_left]; rfl
  simp only [ex S T hS hTs, ex T S hT hSs, ← Finset.mul_sum]
  congr 1
  refine ((sum_rot4 _).trans (sum_rot4 _)).trans ?_
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
  ring

/-- **Row (B) at every `n`**: for a linear Weyl operator `W` and skew `η`,
`mixSym id W η = −2 ⟨W η, η⟩`, i.e. `I # W = −W`. -/
theorem rowB (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeylOp W) (η : Matrix ι ι ℝ)
    (hη : IsSkew η) : mixSym (fun X => X) W η = -2 * inner2 (W η) η := by
  obtain ⟨hlin, hskew, hsym, hB, hRic⟩ := hW
  have hK := key_sum W hlin hskew hsym hB hRic η hη
  have hadlin := ad_isLinOp η
  have had2 : IsLinOp (fun X => br η (br η X)) :=
    ⟨fun X Y => by simp only [hadlin.1], fun c X => by simp only [hadlin.2]⟩
  have hWad : IsLinOp (fun X => W (br η X)) :=
    ⟨fun X Y => by simp only [hadlin.1, hlin.1], fun c X => by simp only [hadlin.2, hlin.2]⟩
  have sk_ad : ∀ i j, IsSkew (br η (phi i j)) := fun i j => br_isSkew_real _ _ hη (phi_isSkew i j)
  -- both halves are −¼ ∑ ⟨W(ad² φ), φ⟩
  have h1 : mixQF (fun X => X) W η
      = -(1/4) * ∑ i, ∑ j, inner2 (W (br η (br η (phi i j)))) (phi i j) := by
    unfold mixQF
    congr 1
    exact trace_cyc (fun X => br η (br η X)) W had2 hlin
      (fun i j => br_isSkew_real _ _ hη (sk_ad i j)) (fun i j => hskew _ (phi_isSkew i j))
  have h2 : mixQF W (fun X => X) η
      = -(1/4) * ∑ i, ∑ j, inner2 (W (br η (br η (phi i j)))) (phi i j) := by
    unfold mixQF
    congr 1
    exact trace_cyc (fun X => br η X) (fun X => W (br η X)) hadlin hWad sk_ad
      (fun i j => hskew _ (sk_ad i j))
  have h3 : mixQF W (fun X => X) η
      = (1/4) * ∑ i, ∑ j, inner2 (W (br η (phi i j))) (br η (phi i j)) := by
    unfold mixQF
    simp only [inner2_br_skew _ _ _ hη, Finset.sum_neg_distrib]
    ring
  unfold mixSym
  rw [h1, ← h2, h3, hK]
  ring

end HamiltonsCubic.L244RowB
