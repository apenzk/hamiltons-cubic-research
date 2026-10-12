import Mathlib
import HamiltonsCubic.Results.I117Statements
import HamiltonsCubic.Results.OddTorus
import HamiltonsCubic.Results.WeylInvariantZero

set_option linter.style.longLine false

/-!
# L264 (2) with the cross block

[findings/second-order.md](../../../findings/second-order.md), Lemma L264 (2): *"On a compact semisimple $\mathfrak h$
with two or more simple ideals, no positive-definite idempotent is stable"*, its proof writing
$C=D_1+D_2+E$ over $\mathfrak h=\mathfrak h_1\oplus\mathfrak h_2$ with $E$ the cross block and using
$C\#D_i=D_i$. [I117Statements.lean](I117Statements.lean)'s `L264_not_simple_unstable` covers $E=0$. This file
covers every $E$:

* `ph`, `expand`, `trace_move`: every bivector is $\tfrac12\sum\langle X,\varphi_{ij}\rangle\varphi_{ij}$, so a
  self-adjoint `P` moves across a trace on the coordinate basis, $\sum G(P\varphi,\varphi)=\sum G(\varphi,P\varphi)$;
* `S4`, `moveA`, `moveC`: the same move inside `phiTri`'s quadruple sum, in either basis vector;
* `chainY`, `chainY1`: with `P₁`, `P₂` the projections onto the ideals and $D_1=P_1CP_1$ (`blk`),
  $\Phi(D_1,Y,C)=\Phi(D_1,Y,D_1)=\Phi(C,P_1YP_1,C)$, the cross block and $\mathfrak h_2$ dropping out;
* `inner_move`, `sharp_blk`: $\langle P_1YP_1,C\rangle=\langle Y,D_1\rangle$, so $C\#C=C$ gives
  $F(C,D_1,Y)=\langle Y,D_1\rangle$, which is $C\#D_1=D_1$;
* `L264_cross`: a self-adjoint `#`-idempotent supported on $\mathfrak h_1\oplus\mathfrak h_2$ with both blocks
  nonzero is not stable, through $H=\lVert D_2\rVert^2D_1-\lVert D_1\rVert^2D_2\perp C$ with
  $F(C,H,H)=\lVert H\rVert^2$.

`L264_cross` asks only that both blocks be nonzero, so it covers positive-semidefinite idempotents with a cross
block, such as $\Pi_{\mathfrak{so}(3)}$ in $\mathfrak{so}(4)=\Lambda^2_+\oplus\Lambda^2_-$. Three steps stay with the
record: that a compact semisimple $\mathfrak h\subseteq\mathfrak{so}(n)$ with two or more simple ideals splits as two
orthogonal commuting ideals (one simple ideal and the sum of the rest); that a positive-definite idempotent on
$\mathfrak h$ has both blocks nonzero; and reading $\mathfrak h$'s own `#` and stability as the ambient ones of
$\mathfrak{so}(n)$, `IsStable` quantifying over all of $\operatorname{Sym}^2\mathfrak{so}(n)$ while the destabilising
$H$ lies in $\operatorname{Sym}^2\mathfrak h$. The hypotheses `o₂₁` and `hQC` follow from the others through
self-adjointness and are kept for directness.
-/

namespace HamiltonsCubic.L264Cross

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The coordinate bivector `φ_ij` in `𝔰𝔬(n)`. -/
def ph (i j : ι) : skewSub ι := ⟨phi i j, phi_mem_skewSub i j⟩

theorem inner2_ph (X : skewSub ι) (i j : ι) :
    inner2 (X : Matrix ι ι ℝ) ((ph i j : skewSub ι) : Matrix ι ι ℝ) = (X : Matrix ι ι ℝ) j i := by
  have hX : (X : Matrix ι ι ℝ)ᵀ = -(X : Matrix ι ι ℝ) := X.2
  have hs : (X : Matrix ι ι ℝ) i j = -(X : Matrix ι ι ℝ) j i := by
    rw [← Matrix.transpose_apply (X : Matrix ι ι ℝ) j i, hX, Matrix.neg_apply]
  show inner2 (X : Matrix ι ι ℝ) (phi i j) = _
  rw [HamiltonsCubic.OddTorus.inner2_phi_r, hs]; ring

/-- **Every bivector is `½ ∑ ⟨X, φ_ij⟩ φ_ij`.** -/
theorem expand (X : skewSub ι) :
    X = (1 / 2 : ℝ) • ∑ i, ∑ j, inner2 (X : Matrix ι ι ℝ) ((ph i j : skewSub ι) : Matrix ι ι ℝ) • ph i j := by
  apply Subtype.ext
  have h := HamiltonsCubic.Results.skew_expand (X : Matrix ι ι ℝ) X.2
  rw [Submodule.coe_smul, Submodule.coe_sum]
  conv_lhs => rw [h]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Submodule.coe_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Submodule.coe_smul, inner2_ph]; rfl

omit [DecidableEq ι] in
theorem sum4_swap (f : ι → ι → ι → ι → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := by
  calc ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ i, ∑ k, ∑ j, ∑ l, f i j k l :=
        Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ i, ∑ k, ∑ l, ∑ j, f i j k l :=
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun k _ => Finset.sum_comm
    _ = ∑ k, ∑ i, ∑ l, ∑ j, f i j k l := Finset.sum_comm
    _ = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := Finset.sum_congr rfl fun k _ => Finset.sum_comm

/-- **Moving a self-adjoint operator across a trace on the coordinate basis**:
`∑ G(P φ_ij, φ_ij) = ∑ G(φ_ij, P φ_ij)` for every bilinear `G`. -/
theorem trace_move (G : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ) (P : CurvOp2 ι) (hP : IsSelfAdjoint2 P) :
    ∑ i, ∑ j, G (P (ph i j)) (ph i j) = ∑ i, ∑ j, G (ph i j) (P (ph i j)) := by
  have hl : ∀ i j, G (P (ph i j)) (ph i j)
      = ∑ k, ∑ l, (1 / 2 : ℝ) * (inner2 ((P (ph i j) : skewSub ι) : Matrix ι ι ℝ) ((ph k l : skewSub ι) : Matrix ι ι ℝ)
          * G (ph k l) (ph i j)) := fun i j => by
    conv_lhs => rw [expand (P (ph i j))]
    simp only [map_smul, map_sum, LinearMap.smul_apply, LinearMap.sum_apply, smul_eq_mul, Finset.mul_sum]
  have hr : ∀ k l, G (ph k l) (P (ph k l))
      = ∑ i, ∑ j, (1 / 2 : ℝ) * (inner2 ((P (ph k l) : skewSub ι) : Matrix ι ι ℝ) ((ph i j : skewSub ι) : Matrix ι ι ℝ)
          * G (ph k l) (ph i j)) := fun k l => by
    conv_lhs => rw [expand (P (ph k l))]
    simp only [map_smul, map_sum, smul_eq_mul, Finset.mul_sum]
  simp only [hl, hr]
  rw [sum4_swap]
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
    Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [hP (ph i j) (ph k l), HamiltonsCubic.L33Statement.inner2_comm]

/-- The quadruple sum over two coordinate bivectors, each fed to two slots. -/
noncomputable def S4 (f : skewSub ι → skewSub ι → skewSub ι → skewSub ι → ℝ) : ℝ :=
  ∑ i, ∑ j, ∑ k, ∑ l, f (ph i j) (ph i j) (ph k l) (ph k l)

theorem S4_congr {f g : skewSub ι → skewSub ι → skewSub ι → skewSub ι → ℝ}
    (h : ∀ a b c d, f a b c d = g a b c d) : S4 f = S4 g := by
  unfold S4; simp only [h]

theorem moveA (F : skewSub ι → skewSub ι → skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ) (P : CurvOp2 ι)
    (hP : IsSelfAdjoint2 P) :
    S4 (fun a b c d => F c d (P a) b) = S4 (fun a b c d => F c d a (P b)) := by
  unfold S4
  rw [sum4_swap, sum4_swap (fun i j k l => F (ph k l) (ph k l) (ph i j) (P (ph i j)))]
  exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => trace_move _ P hP

theorem moveC (F : skewSub ι → skewSub ι → skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ) (P : CurvOp2 ι)
    (hP : IsSelfAdjoint2 P) :
    S4 (fun a b c d => F a b (P c) d) = S4 (fun a b c d => F a b c (P d)) := by
  unfold S4
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => trace_move _ P hP

/-- `(u, v) ↦ ⟨B[A u, w], K[v, d]⟩`. -/
noncomputable def GA (A B K : CurvOp2 ι) (w d : skewSub ι) : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ :=
  LinearMap.mk₂ ℝ
    (fun u v => inner2 ((B (brS (A u) w) : skewSub ι) : Matrix ι ι ℝ) ((K (brS v d) : skewSub ι) : Matrix ι ι ℝ))
    (fun u u' v => by simp only [map_add, brS_add_left, Submodule.coe_add, i2_add_l])
    (fun c u v => by simp only [map_smul, brS_smul_left, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun u v v' => by simp only [brS_add_left, map_add, Submodule.coe_add, i2_add_r])
    (fun c u v => by simp only [brS_smul_left, map_smul, Submodule.coe_smul, i2_smul_r, smul_eq_mul])

/-- `(u, v) ↦ ⟨B[a', C u], K[b, v]⟩`. -/
noncomputable def GC (a' : skewSub ι) (B C K : CurvOp2 ι) (b : skewSub ι) : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ :=
  LinearMap.mk₂ ℝ
    (fun u v => inner2 ((B (brS a' (C u)) : skewSub ι) : Matrix ι ι ℝ) ((K (brS b v) : skewSub ι) : Matrix ι ι ℝ))
    (fun u u' v => by simp only [map_add, brS_add_right, Submodule.coe_add, i2_add_l])
    (fun c u v => by simp only [map_smul, brS_smul_right, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
    (fun u v v' => by simp only [brS_add_right, map_add, Submodule.coe_add, i2_add_r])
    (fun c u v => by simp only [brS_smul_right, map_smul, Submodule.coe_smul, i2_smul_r, smul_eq_mul])

theorem GA_apply (A B K : CurvOp2 ι) (w d u v : skewSub ι) :
    GA A B K w d u v
      = inner2 ((B (brS (A u) w) : skewSub ι) : Matrix ι ι ℝ) ((K (brS v d) : skewSub ι) : Matrix ι ι ℝ) := rfl

theorem GC_apply (a' : skewSub ι) (B C K : CurvOp2 ι) (b u v : skewSub ι) :
    GC a' B C K b u v
      = inner2 ((B (brS a' (C u)) : skewSub ι) : Matrix ι ι ℝ) ((K (brS b v) : skewSub ι) : Matrix ι ι ℝ) := rfl

theorem phiTri_S4 (A B C : CurvOp2 ι) :
    phiTri A B C = -(1 / 4) * S4 (fun a b c d =>
      inner2 ((B (brS (A a) (C c)) : skewSub ι) : Matrix ι ι ℝ) ((brS b d : skewSub ι) : Matrix ι ι ℝ)) := rfl

section Split

variable (P₁ P₂ C : CurvOp2 ι)

/-- The idempotent's block on the first ideal, `D₁ = P₁ C P₁`. -/
noncomputable def blk : CurvOp2 ι := (P₁.comp C).comp P₁

theorem blk_apply (X : skewSub ι) : blk P₁ C X = P₁ (C (P₁ X)) := rfl

variable {P₁ P₂ C}
variable (s₁ : IsSelfAdjoint2 P₁) (s₂ : IsSelfAdjoint2 P₂)
  (i₁ : ∀ X, P₁ (P₁ X) = P₁ X) (o₁₂ : ∀ X, P₁ (P₂ X) = 0)
  (b₁ : ∀ X Y, P₁ (brS (P₁ X) (P₁ Y)) = brS (P₁ X) (P₁ Y)) (b₂ : ∀ X Y, P₂ (brS (P₂ X) (P₂ Y)) = brS (P₂ X) (P₂ Y))
  (c₁₂ : ∀ X Y, brS (P₁ X) (P₂ Y) = 0)
  (hCQ : ∀ X, C X = C (P₁ X + P₂ X)) (hQC : ∀ X, C X = P₁ (C X) + P₂ (C X))

include s₁ s₂ i₁ c₁₂ hCQ hQC in
/-- **`F(D₁, Y, C) = F(D₁, Y, D₁)`**: the cross block and the second ideal drop out of the pairing with `D₁`. -/
theorem chainY (Y : CurvOp2 ι) : phiTri (blk P₁ C) Y C = phiTri (blk P₁ C) Y (blk P₁ C) := by
  have hQs : IsSelfAdjoint2 (P₁ + P₂) := isSelfAdjoint2_add s₁ s₂
  have hD : ∀ X, blk P₁ C (P₁ X) = blk P₁ C X := fun X => by rw [blk_apply, blk_apply, i₁]
  rw [phiTri_S4, phiTri_S4]
  congr 1
  calc S4 (fun a b c d => inner2 ((Y (brS (blk P₁ C a) (C c)) : skewSub ι) : Matrix ι ι ℝ) ((brS b d : skewSub ι) : Matrix ι ι ℝ))
      = S4 (fun a b c d => GA (blk P₁ C) Y (ContinuousLinearMap.id ℝ _) (C c) d (P₁ a) b) :=
        S4_congr fun a b c d => by rw [GA_apply, hD]; rfl
    _ = S4 (fun a b c d => GA (blk P₁ C) Y (ContinuousLinearMap.id ℝ _) (C c) d a (P₁ b)) := moveA _ P₁ s₁
    _ = S4 (fun a b c d => GC (blk P₁ C a) Y C (ContinuousLinearMap.id ℝ _) (P₁ b) ((P₁ + P₂) c) d) :=
        S4_congr fun a b c d => by rw [GA_apply, GC_apply, _root_.add_apply, ← hCQ]
    _ = S4 (fun a b c d => GC (blk P₁ C a) Y C (ContinuousLinearMap.id ℝ _) (P₁ b) c ((P₁ + P₂) d)) :=
        moveC (fun a b => GC (blk P₁ C a) Y C (ContinuousLinearMap.id ℝ _) (P₁ b)) _ hQs
    _ = S4 (fun a b c d => GC (blk P₁ C a) Y C (ContinuousLinearMap.id ℝ _) (P₁ b) c (P₁ d)) :=
        S4_congr fun a b c d => by
          rw [GC_apply, GC_apply, _root_.add_apply, brS_add_right, c₁₂, add_zero]
    _ = S4 (fun a b c d => GC (blk P₁ C a) Y C (ContinuousLinearMap.id ℝ _) (P₁ b) (P₁ c) d) :=
        (moveC (fun a b => GC (blk P₁ C a) Y C (ContinuousLinearMap.id ℝ _) (P₁ b)) _ s₁).symm
    _ = S4 (fun a b c d => GA (blk P₁ C) Y (ContinuousLinearMap.id ℝ _) (blk P₁ C c) d a (P₁ b)) :=
        S4_congr fun a b c d => by
          rw [GC_apply, GA_apply]
          congr 2
          conv_lhs => rw [hQC (P₁ c), brS_add_right, blk_apply, c₁₂, add_zero]
          rfl
    _ = S4 (fun a b c d => GA (blk P₁ C) Y (ContinuousLinearMap.id ℝ _) (blk P₁ C c) d (P₁ a) b) :=
        (moveA _ P₁ s₁).symm
    _ = S4 (fun a b c d => inner2 ((Y (brS (blk P₁ C a) (blk P₁ C c)) : skewSub ι) : Matrix ι ι ℝ)
          ((brS b d : skewSub ι) : Matrix ι ι ℝ)) :=
        S4_congr fun a b c d => by rw [GA_apply, hD]; rfl

include s₁ s₂ o₁₂ b₁ b₂ c₁₂ in
theorem projBr (x y : skewSub ι) : P₁ (brS (P₁ x + P₂ x) (P₁ y + P₂ y)) = brS (P₁ x) (P₁ y) := by
  have c₂₁ : ∀ X Y, brS (P₂ X) (P₁ Y) = 0 := fun X Y => by rw [brS_neg, c₁₂, neg_zero]
  rw [brS_add_left, brS_add_right, brS_add_right, c₁₂, c₂₁, add_zero, zero_add, map_add, b₁, ← b₂ x y, o₁₂,
    add_zero]

include s₁ s₂ o₁₂ b₁ b₂ c₁₂ hCQ hQC in
/-- **`F(C, P₁ Y P₁, C) = F(D₁, Y, D₁)`**: the compressed direction sees only the first block. -/
theorem chainY1 (Y : CurvOp2 ι) :
    phiTri C (P₁.comp (Y.comp P₁)) C = phiTri (blk P₁ C) Y (blk P₁ C) := by
  have hQs : IsSelfAdjoint2 (P₁ + P₂) := isSelfAdjoint2_add s₁ s₂
  have hpb := projBr s₁ s₂ o₁₂ b₁ b₂ c₁₂
  rw [phiTri_S4, phiTri_S4]
  congr 1
  calc S4 (fun a b c d => inner2 (((P₁.comp (Y.comp P₁)) (brS (C a) (C c)) : skewSub ι) : Matrix ι ι ℝ)
        ((brS b d : skewSub ι) : Matrix ι ι ℝ))
      = S4 (fun a b c d => GA C (Y.comp P₁) P₁ (C c) d ((P₁ + P₂) a) b) :=
        S4_congr fun a b c d => by
          rw [GA_apply, _root_.add_apply, ← hCQ]
          exact s₁ _ _
    _ = S4 (fun a b c d => GA C (Y.comp P₁) P₁ (C c) d a ((P₁ + P₂) b)) := moveA _ _ hQs
    _ = S4 (fun a b c d => GC (C a) (Y.comp P₁) C P₁ ((P₁ + P₂) b) ((P₁ + P₂) c) d) :=
        S4_congr fun a b c d => by rw [GA_apply, GC_apply, _root_.add_apply (f := P₁) (g := P₂) c, ← hCQ]
    _ = S4 (fun a b c d => GC (C a) (Y.comp P₁) C P₁ ((P₁ + P₂) b) c ((P₁ + P₂) d)) :=
        moveC (fun a b => GC (C a) (Y.comp P₁) C P₁ ((P₁ + P₂) b)) _ hQs
    _ = S4 (fun a b c d => GA C (Y.comp P₁) (ContinuousLinearMap.id ℝ _) (C c) (P₁ d) a (P₁ b)) :=
        S4_congr fun a b c d => by
          rw [GC_apply, GA_apply, _root_.add_apply, _root_.add_apply, hpb]; rfl
    _ = S4 (fun a b c d => GA C (Y.comp P₁) (ContinuousLinearMap.id ℝ _) (C c) (P₁ d) (P₁ a) b) :=
        (moveA _ P₁ s₁).symm
    _ = S4 (fun a b c d => GC (C (P₁ a)) (Y.comp P₁) C (ContinuousLinearMap.id ℝ _) b c (P₁ d)) :=
        S4_congr fun a b c d => rfl
    _ = S4 (fun a b c d => GC (C (P₁ a)) (Y.comp P₁) C (ContinuousLinearMap.id ℝ _) b (P₁ c) d) :=
        (moveC (fun a b => GC (C (P₁ a)) (Y.comp P₁) C (ContinuousLinearMap.id ℝ _) b) _ s₁).symm
    _ = S4 (fun a b c d => inner2 ((Y (brS (blk P₁ C a) (blk P₁ C c)) : skewSub ι) : Matrix ι ι ℝ)
          ((brS b d : skewSub ι) : Matrix ι ι ℝ)) :=
        S4_congr fun a b c d => by
          rw [GC_apply]
          show inner2 ((Y (P₁ (brS (C (P₁ a)) (C (P₁ c)))) : skewSub ι) : Matrix ι ι ℝ) _ = _
          rw [hQC (P₁ a), hQC (P₁ c), hpb]
          rfl

include s₁ in
theorem inner_move (Y : CurvOp2 ι) : innerOp2 (P₁.comp (Y.comp P₁)) C = innerOp2 Y (blk P₁ C) := by
  let G : skewSub ι →ₗ[ℝ] skewSub ι →ₗ[ℝ] ℝ := LinearMap.mk₂ ℝ
    (fun u v => inner2 ((P₁ (Y v) : skewSub ι) : Matrix ι ι ℝ) ((C u : skewSub ι) : Matrix ι ι ℝ))
    (fun u u' v => by simp only [map_add, Submodule.coe_add, i2_add_r])
    (fun c u v => by simp only [map_smul, Submodule.coe_smul, i2_smul_r, smul_eq_mul])
    (fun u v v' => by simp only [map_add, Submodule.coe_add, i2_add_l])
    (fun c u v => by simp only [map_smul, Submodule.coe_smul, i2_smul_l, smul_eq_mul])
  have h := trace_move G P₁ s₁
  unfold innerOp2
  congr 1
  have e1 : ∀ i j, inner2 (applyPhi (P₁.comp (Y.comp P₁)) i j) (applyPhi C i j) = G (ph i j) (P₁ (ph i j)) :=
    fun i j => rfl
  have e2 : ∀ i j, inner2 (applyPhi Y i j) (applyPhi (blk P₁ C) i j) = G (P₁ (ph i j)) (ph i j) := fun i j => by
    show inner2 ((Y (ph i j) : skewSub ι) : Matrix ι ι ℝ) ((P₁ (C (P₁ (ph i j))) : skewSub ι) : Matrix ι ι ℝ) = _
    rw [← s₁]; rfl
  simp only [e1, e2, h]

include s₁ s₂ i₁ o₁₂ b₁ b₂ c₁₂ hCQ hQC in
/-- **`C # D₁ = D₁`**: `F(C, D₁, Y) = ⟨Y, D₁⟩` for every self-adjoint `Y`, cross block or not. -/
theorem sharp_blk (hC : IsSelfAdjoint2 C) (hidem : IsIdem C) (Y : CurvOp2 ι) (hY : IsSelfAdjoint2 Y) :
    Ftri C (blk P₁ C) Y = innerOp2 Y (blk P₁ C) := by
  have hDsa : IsSelfAdjoint2 (blk P₁ C) := fun X Z => by
    show inner2 ((P₁ (C (P₁ X)) : skewSub ι) : Matrix ι ι ℝ) _ = inner2 _ ((P₁ (C (P₁ Z)) : skewSub ι) : Matrix ι ι ℝ)
    rw [s₁, hC, s₁]
  calc Ftri C (blk P₁ C) Y = Ftri (blk P₁ C) C Y := Ftri_symm12 hY
    _ = Ftri (blk P₁ C) Y C := Ftri_symm23 hDsa C Y
    _ = Ftri (blk P₁ C) Y (blk P₁ C) := by unfold Ftri; rw [chainY s₁ s₂ i₁ c₁₂ hCQ hQC]
    _ = Ftri C (P₁.comp (Y.comp P₁)) C := by unfold Ftri; rw [chainY1 s₁ s₂ o₁₂ b₁ b₂ c₁₂ hCQ hQC]
    _ = Ftri C C (P₁.comp (Y.comp P₁)) := Ftri_symm23 hC _ _
    _ = innerOp2 (P₁.comp (Y.comp P₁)) C := Ftri_idem hidem _
    _ = innerOp2 Y (blk P₁ C) := inner_move s₁ Y

end Split


/-- **L264 (2) with the cross block.** Let `P₁`, `P₂` be the orthogonal projections onto two commuting ideals
`𝔥₁ ⊥ 𝔥₂` of `𝔥 = 𝔥₁ ⊕ 𝔥₂` (self-adjoint, idempotent, `P₁ P₂ = P₂ P₁ = 0`, each range a subalgebra,
`[𝔥₁, 𝔥₂] = 0`), and `C` a self-adjoint `#`-idempotent supported on `𝔥` (`C = Q C Q`, `Q = P₁ + P₂`) whose blocks
`D_i = P_i C P_i` are nonzero. Then `C` is not stable, whatever its cross block `E = P₁ C P₂ + P₂ C P₁`. -/
theorem L264_cross (P₁ P₂ C : CurvOp2 ι) (s₁ : IsSelfAdjoint2 P₁) (s₂ : IsSelfAdjoint2 P₂)
    (i₁ : ∀ X, P₁ (P₁ X) = P₁ X) (i₂ : ∀ X, P₂ (P₂ X) = P₂ X)
    (o₁₂ : ∀ X, P₁ (P₂ X) = 0) (o₂₁ : ∀ X, P₂ (P₁ X) = 0)
    (b₁ : ∀ X Y, P₁ (brS (P₁ X) (P₁ Y)) = brS (P₁ X) (P₁ Y)) (b₂ : ∀ X Y, P₂ (brS (P₂ X) (P₂ Y)) = brS (P₂ X) (P₂ Y))
    (c₁₂ : ∀ X Y, brS (P₁ X) (P₂ Y) = 0)
    (hCQ : ∀ X, C X = C (P₁ X + P₂ X)) (hQC : ∀ X, C X = P₁ (C X) + P₂ (C X))
    (hC : IsSelfAdjoint2 C) (hidem : IsIdem C) (h₁ : blk P₁ C ≠ 0) (h₂ : blk P₂ C ≠ 0) :
    ¬ IsStable C := by
  intro hst
  have c₂₁ : ∀ X Y, brS (P₂ X) (P₁ Y) = 0 := fun X Y => by rw [brS_neg, c₁₂, neg_zero]
  have hCQ' : ∀ X, C X = C (P₂ X + P₁ X) := fun X => by rw [add_comm]; exact hCQ X
  have hQC' : ∀ X, C X = P₂ (C X) + P₁ (C X) := fun X => by rw [add_comm]; exact hQC X
  set D₁ := blk P₁ C with hD₁
  set D₂ := blk P₂ C with hD₂
  have sa : ∀ {P : CurvOp2 ι}, IsSelfAdjoint2 P → IsSelfAdjoint2 (blk P C) := fun {P} hP X Z => by
    show inner2 ((P (C (P X)) : skewSub ι) : Matrix ι ι ℝ) _ = inner2 _ ((P (C (P Z)) : skewSub ι) : Matrix ι ι ℝ)
    rw [hP, hC, hP]
  have hD₁sa : IsSelfAdjoint2 D₁ := sa s₁
  have hD₂sa : IsSelfAdjoint2 D₂ := sa s₂
  have k₁ := sharp_blk s₁ s₂ i₁ o₁₂ b₁ b₂ c₁₂ hCQ hQC hC hidem
  have k₂ := sharp_blk s₂ s₁ i₂ o₂₁ b₂ b₁ c₂₁ hCQ' hQC' hC hidem
  -- `⟨D₁, D₂⟩ = 0` and `⟨D_i, C⟩ = ‖D_i‖²`
  have hperp : innerOp2 D₁ D₂ = 0 := by
    rw [hD₂, ← inner_move s₂ D₁]
    have : P₂.comp (D₁.comp P₂) = 0 := ContinuousLinearMap.ext fun X => by
      show P₂ (P₁ (C (P₁ (P₂ X)))) = 0
      rw [o₂₁]
    rw [this]; simp [innerOp2, applyPhi, inner2]
  have hperp' : innerOp2 D₂ D₁ = 0 := by rw [innerOp2_comm]; exact hperp
  have hDC : ∀ {P : CurvOp2 ι}, IsSelfAdjoint2 P → (∀ X, P (P X) = P X) →
      innerOp2 (blk P C) C = normSq2 (blk P C) := fun {P} hP hi => by
    unfold normSq2
    rw [← inner_move hP (blk P C)]
    congr 1
    exact ContinuousLinearMap.ext fun X => by
      show P (C (P X)) = P (P (C (P (P X))))
      rw [hi, hi]
  have hD₁C := hDC s₁ i₁
  have hD₂C := hDC s₂ i₂
  set a := normSq2 D₂ with ha
  set b := normSq2 D₁ with hb
  have ha0 : 0 < a := lt_of_le_of_ne (normSq2_nonneg D₂) (fun h => h₂ (normSq2_eq_zero h.symm))
  have hb0 : 0 < b := lt_of_le_of_ne (normSq2_nonneg D₁) (fun h => h₁ (normSq2_eq_zero h.symm))
  set H := a • D₁ + (-b) • D₂ with hH
  have hHsa : IsSelfAdjoint2 H := isSelfAdjoint2_add (isSelfAdjoint2_smul hD₁sa a) (isSelfAdjoint2_smul hD₂sa (-b))
  have hHC : innerOp2 H C = 0 := by
    rw [hH, innerOp2_add_left, innerOp2_smul_left, innerOp2_smul_left, hD₁C, hD₂C]
    ring
  have hnH : normSq2 H = a ^ 2 * b + b ^ 2 * a := by
    show innerOp2 (a • D₁ + (-b) • D₂) (a • D₁ + (-b) • D₂) = _
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_smul_left, innerOp2_smul_left,
      innerOp2_smul_left, innerOp2_smul_left, innerOp2_smul_right, innerOp2_smul_right, innerOp2_smul_right,
      innerOp2_smul_right, hperp, hperp']
    simp only [ha, hb, normSq2]; ring
  have hFH : Ftri C H H = a ^ 2 * b + b ^ 2 * a := by
    rw [hH]
    simp only [Ftri_add_mid, Ftri_add_right, Ftri_smul_mid, Ftri_smul_right]
    rw [k₁ D₁ hD₁sa, k₁ D₂ hD₂sa, k₂ D₁ hD₁sa, k₂ D₂ hD₂sa, hperp, hperp']
    simp only [ha, hb, normSq2]; ring
  have hle := hst H hHsa hHC
  rw [hFH, hnH] at hle
  nlinarith [mul_pos (mul_pos ha0 ha0) hb0, mul_pos (mul_pos hb0 hb0) ha0]

end HamiltonsCubic.L264Cross
