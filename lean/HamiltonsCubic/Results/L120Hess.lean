import Mathlib
import HamiltonsCubic.Results.L120Block
import HamiltonsCubic.Results.L24HessOp

set_option linter.style.longLine false

/-!
# L120: the Hessian of `P` on the sphere preserves every sign-isotypic subspace

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: *at every diagonal `M` the
operator `L_M` preserves each summand. **Hence the Hessian of `P` on the sphere is block-diagonal in
the same way**, and Lemma L24's criterion is checkable block by block.*
[L120Block.lean](L120Block.lean) proves the first sentence on bare operators (`L120_block`), and
[L24HessOp.lean](L24HessOp.lean) builds the Hessian as `hessOp`, `6θ(L_e − ½)` on `W^⊥`, in
`CurvOp2`. This file carries the sign characters across and composes them.

* `HasChar c S R`: `R` transforms by the scalar `c` under conjugation by `S`, **stated on `Λ²` only**
  (`S R(SᵀZS) Sᵀ = c R(Z)` for skew `Z`), which is where a `CurvOp2` operator lives;
* `act_extendL`: **the character transfers from `Λ²` to all matrices** for the extension `extend R`,
  since `skewProj(SᵀZS) = Sᵀ skewProj(Z) S` ([r1441](../../../reviews/REVIEW_r1441.md)'s transfer);
* `foxProd2_char`: at a `Γ`-fixed `a`, `a ∘ v` has the character of `v`, from `L120_block` and
  `foxProd_extend`;
* `hasChar_restrict`, `signChar_diag`: a diagonal Weyl operator, restricted to `Λ²`, is `Γ`-fixed
  in `SignChar`'s sense, which is `hessOp_char`'s hypothesis at the record's diagonal `M`;
* `hessOp_char`: **at a `Γ`-fixed unit critical Weyl `a`, `hessOp` maps each sign-isotypic subspace
  of `W^⊥` into itself**, the record's *"the Hessian of `P` on the sphere is block-diagonal in the
  same way"*.
-/

namespace HamiltonsCubic.L120Hess

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`R` has character `c` under conjugation by `S`, on `Λ²`.** -/
def HasChar (c : ℝ) (S : Matrix ι ι ℝ) (R : CurvOp2 ι) : Prop :=
  ∀ Z : Matrix ι ι ℝ, IsSkew Z → S * extend R (Sᵀ * Z * S) * Sᵀ = c • extend R Z

/-- **`R` is sign-isotypic with character `c`**: `HasChar (c ε) (diag ε) R` for every sign vector. -/
def SignChar (c : (ι → ℝ) → ℝ) (R : CurvOp2 ι) : Prop :=
  ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → HasChar (c ε) (signMat ε) R

/-- The extension of a `CurvOp2` operator as a linear map on all matrices. -/
noncomputable def extendL (R : CurvOp2 ι) : CurvLin ι where
  toFun := extend R
  map_add' := (isLinOp_extend R).1
  map_smul' := (isLinOp_extend R).2

omit [DecidableEq ι] in
theorem skewProj_conj (S Z : Matrix ι ι ℝ) : skewProj (Sᵀ * Z * S) = Sᵀ * skewProj Z * S := by
  unfold skewProj
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, Matrix.mul_smul,
    Matrix.smul_mul, Matrix.mul_sub, Matrix.sub_mul]
  simp only [Matrix.mul_assoc]

theorem extend_skewProj (R : CurvOp2 ι) (X : Matrix ι ι ℝ) :
    extend R (skewProj X) = extend R X := by
  unfold extend
  congr 2
  exact Subtype.ext (skewProj_eq_self (skewProj_mem X))

omit [DecidableEq ι] in
theorem skew_conj {S Z : Matrix ι ι ℝ} (hZ : IsSkew Z) : IsSkew (Sᵀ * Z * S) := by
  unfold IsSkew at *
  rw [Matrix.transpose_mul, Matrix.transpose_mul, Matrix.transpose_transpose, hZ, Matrix.neg_mul,
    Matrix.mul_neg, Matrix.mul_assoc]

/-- **The character transfers from `Λ²` to every matrix**, through the skew projection. -/
theorem hasChar_all {c : ℝ} {S : Matrix ι ι ℝ} {R : CurvOp2 ι} (h : HasChar c S R)
    (Z : Matrix ι ι ℝ) : S * extend R (Sᵀ * Z * S) * Sᵀ = c • extend R Z := by
  rw [← extend_skewProj R (Sᵀ * Z * S), skewProj_conj, ← extend_skewProj R Z]
  exact h _ (skewProj_mem Z)

theorem act_extendL {c : ℝ} {S : Matrix ι ι ℝ} {R : CurvOp2 ι} (h : HasChar c S R) :
    act S (extendL R) = c • extendL R := by
  refine LinearMap.ext fun Z => ?_
  rw [act_apply]
  exact hasChar_all h Z

theorem hasChar_smul {c : ℝ} {S : Matrix ι ι ℝ} {R : CurvOp2 ι} (h : HasChar c S R) (r : ℝ) :
    HasChar c S (r • R) := by
  intro Z hZ
  rw [extend_smul, extend_smul, Matrix.mul_smul, Matrix.smul_mul, h Z hZ, smul_comm]

theorem hasChar_sub {c : ℝ} {S : Matrix ι ι ℝ} {R R' : CurvOp2 ι} (h : HasChar c S R)
    (h' : HasChar c S R') : HasChar c S (R - R') := by
  intro Z hZ
  have e : ∀ X, extend (R - R') X = extend R X - extend R' X := fun X => by
    unfold extend
    rw [_root_.sub_apply, Submodule.coe_sub]
  rw [e, e, Matrix.mul_sub, Matrix.sub_mul, h Z hZ, h' Z hZ, smul_sub]

/-- **At a `Γ`-fixed `a`, `a ∘ v` carries `v`'s sign character**: `L120_block` on the extensions,
crossed to `CurvOp2` by `foxProd_extend`. -/
theorem foxProd2_char {c : (ι → ℝ) → ℝ} {a v : CurvOp2 ι} (ha : SignChar (fun _ => 1) a)
    (hv : SignChar c v) : SignChar c (foxProd2 a v) := by
  intro ε hε Z hZ
  have hM : ∀ ε' : ι → ℝ, (∀ i, ε' i * ε' i = 1) → act (signMat ε') (extendL a) = extendL a :=
    fun ε' hε' => by rw [act_extendL (ha ε' hε'), one_smul]
  have hX : ∀ ε' : ι → ℝ, (∀ i, ε' i * ε' i = 1) → act (signMat ε') (extendL v) = c ε' • extendL v :=
    fun ε' hε' => act_extendL (hv ε' hε')
  have key := L120_block (extendL a) (extendL v) c hM hX ε hε Z
  have e1 : extend (foxProd2 a v) ((signMat ε)ᵀ * Z * signMat ε)
      = foxProd (extend a) (extend v) ((signMat ε)ᵀ * Z * signMat ε) :=
    (extend_apply (foxProd2 a v) ⟨_, skew_conj hZ⟩).trans
      (foxProd_extend a v ⟨_, skew_conj hZ⟩).symm
  have e2 : extend (foxProd2 a v) Z = foxProd (extend a) (extend v) Z :=
    (extend_apply (foxProd2 a v) ⟨Z, hZ⟩).trans (foxProd_extend a v ⟨Z, hZ⟩).symm
  rw [e1, e2]
  exact key

/-- **`L_e` preserves each sign-isotypic subspace** at a `Γ`-fixed `a`. -/
theorem LeLin_char {c : (ι → ℝ) → ℝ} {a v : CurvOp2 ι} (ha : SignChar (fun _ => 1) a)
    (hv : SignChar c v) : SignChar c (LeLin a v) :=
  foxProd2_char (fun ε hε => hasChar_smul (ha ε hε) _) hv

/-- **L120's Hessian clause.** At a `Γ`-fixed unit critical Weyl `a` with `P(a) ≠ 0`, the
Hessian `hessOp = 6θ(L_e − ½)` of `P` on the sphere maps each sign-isotypic subspace of `W^⊥` into
itself. -/
theorem hessOp_char {c : (ι → ℝ) → ℝ} {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1)
    (hWa : IsWeyl2 a) (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0)
    (hfix : SignChar (fun _ => 1) a) (v : weylPerpR a) (hv : SignChar c (tanV v)) :
    SignChar c (tanV (hessOp ha hWa hcrit hθ v)) := by
  rw [hessOp_apply]
  intro ε hε
  exact hasChar_smul (hasChar_sub (LeLin_char hfix hv ε hε) (hasChar_smul (hv ε hε) _)) _

/-- **A restricted bare Weyl operator has character `c`** as soon as its conjugation identity holds
on skew inputs. -/
theorem hasChar_restrict {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl R) {c : ℝ}
    {S : Matrix ι ι ℝ} (h : ∀ Z, IsSkew Z → S * R (Sᵀ * Z * S) * Sᵀ = c • R Z) :
    HasChar c S (restrict hW) := by
  intro Z hZ
  have e : ∀ X, IsSkew X → extend (restrict hW) X = R X := fun X hX =>
    (extend_apply (restrict hW) ⟨X, hX⟩).trans (restrict_apply hW ⟨X, hX⟩)
  rw [e _ (skew_conj hZ), e _ hZ]
  exact h Z hZ

/-- **A diagonal Weyl operator is `Γ`-fixed** in `SignChar`'s sense, the hypothesis `hfix` of
`hessOp_char` at the record's *"every diagonal `M`"* ([r1693](../../../reviews/REVIEW_r1693.md)). -/
theorem signChar_diag {w : Matrix ι ι ℝ} (hW : IsWeyl (HamiltonsCubic.FamilyLayer.diagOp w)) :
    SignChar (fun _ => 1) (restrict hW) := by
  intro ε hε
  refine hasChar_restrict hW fun Z _ => ?_
  have := congrArg (fun L : CurvLin ι => L Z) (act_signMat_diag ε hε w)
  simp only [act_apply] at this
  rw [one_smul]
  exact this

end HamiltonsCubic.L120Hess
