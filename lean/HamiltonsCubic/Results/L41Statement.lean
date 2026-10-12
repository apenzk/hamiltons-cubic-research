import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Base.Bivectors2
import HamiltonsCubic.Base.Families

set_option linter.style.longLine false

/-!
# L41, a `λ`-weighted identity, and the bound it gives

## The record's statement, quoted verbatim from [target.md](../../../findings/target.md)

> #### Lemma L41, a $\lambda$-weighted identity, and the bound it gives

> **Statement.** Let $W\in\mathcal W_n$ with eigenbasis $\{v_\gamma\}$ **orthonormal**, and write
> $g_\gamma=\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$. Then
>
> $$\sum_\gamma g_\gamma=4(n-1)\lVert W\rVert^2\quad\text{on all of }\mathcal W_n,\qquad \sum_\gamma\lambda_\gamma g_\gamma=-4P(W)\quad\text{on all of }\mathcal W_n.$$
>
> **Both are scale-covariant as written and neither is scale-invariant.**

> **The bound, at unit norm.** With $\Delta$ the $g$-mass on $\{\lambda>0\}$ and $G_0$ the mass on
> $\ker W$, the split into $\{\lambda>0\}$, $\{\lambda<0\}$, $\{\lambda=0\}$ being exhaustive,
>
> $$\theta\;\le\;\lvert\lambda_{\min}\rvert\cdot\frac{4(n-1)-\Delta-G_0}{4},\qquad \lVert W\rVert=1 .$$

with the Gate 2 corrections the block carries:

> **NEITHER IDENTITY NEEDS CRITICALITY** […] **holds at every $W\in\mathcal W_n$.**

> **THE UNIT-NORM HYPOTHESIS IS NOT COSMETIC HERE** […] *Its bracket mixes $4(n-1)$, of degree
> zero, with $\Delta$ and $G_0$, of degree two, so it is ill-formed at every other scale and
> **changes sign**.*

> **THE EQUALITY CLAUSE HOLDS IN ONE DIRECTION ONLY** […] the exact slack is
> $\sum_{\lambda>0}\lambda_\gamma g_\gamma+\sum_{\lambda<0}(\lambda_\gamma-\lambda_{\min})g_\gamma$,
> which **leaves the kernel unconstrained** […] **The true class is $E_{\lambda_{\min}}\oplus\ker W$.**

## What is typed here

* `EigenFrame`, the record's hypothesis "eigenbasis `{v_γ}` **orthonormal**", as a structure:
  skew, orthonormal for the `Λ²` pairing `inner2`, eigenvectors of `R`, and complete on the
  bivectors. The completeness clause is what makes it a *basis* rather than an orthonormal family.
* `gMass`, `g_γ = ‖[ad(v_γ), W]‖²`, with `ad(v)` the bracket action on `Λ²` and the norm the
  Hilbert–Schmidt norm `innerOp` of the real Weyl layer, so it is the record's `g_γ`.
* `weighted_identities`, **both displays, proved** (`Frame.weighted`).
* `exact_slack` and `lambdaMin_bound`, the bound, derived from the second display. `exact_slack`
  is the identity the Gate 2 correction names, and `lambdaMin_bound` is the record's display with
  `Δ` and `G₀` as the record defines them, at `‖W‖ = 1`. Both are proved.
* `equality_class`, the corrected equality clause: the slack vanishes exactly when `g` is
  supported on `E_{λ_min} ⊕ ker W`, `ker W` unconstrained. Proved.

## How the two identities are proved

**In the eigenframe, from four inputs, all proved in `Frame`.** Petersen–Wink 1.7 (`pw17`,
`g_γ = Σ_{αβ}(λ_α - λ_β)² c_{γαβ}²`); the total symmetry of `c²` (`T12`, `T23`, from the antisymmetry of
the bracket and the ad-invariance `adinv` of the pairing); the Killing row L153 (`killing_frame`,
`Σ_{ab} c_{xab}² = 2(n-2)`); and `A(W) = 2W` (`aW2`, `aW2_frame`, `Σ_{ab} λ_b c_{xab}² = -2λ_x`), the one
input that uses the Weyl conditions: Ricci-flatness kills eight of the sixteen terms and Bianchi gives
`2K = J`. **The second identity also needs `⟨W, W#⟩ = ½ Σ λ_γ λ_α λ_β c_{γαβ}²`** (`sharpPair_T`), through
`sharpQF_frame` and the polarisation `sharpBil_formula`, which hold for any operator that is linear on
bivectors, as every Weyl operator is (`weyl_lin`).

## What is NOT typed here

**`n - 1` is `(Fintype.card ι : ℝ) - 1`, over `ℝ`.** Nothing here is stated over `ℕ`.

**Scale-covariance is not typed**, so the record's warning that the bound is ill-formed away from
`‖W‖ = 1` appears only as the explicit unit-norm hypothesis on `lambdaMin_bound`.
-/

namespace HamiltonsCubic.L41Statement

open HamiltonsCubic.RealLayer Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {Γ : Type*} [Fintype Γ] [DecidableEq Γ]

noncomputable section

/-! ## `ad(v)`, the commutator, and `g_γ` -/

/-- `ad(v)` acting on `Λ²`: `X ↦ [v, X]`. -/
def adOp (v : Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => br v X

/-- The commutator of two operators on `Λ²`. -/
def commOp (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  fun X => A (B X) - B (A X)

/-- **`g_γ = ‖[ad(v_γ), W]‖²`**, the Hilbert–Schmidt norm on operators on `Λ²` being the layer's
`innerOp` paired with itself. -/
def gMass (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (v : Matrix ι ι ℝ) : ℝ :=
  innerOp (commOp (adOp v) R) (commOp (adOp v) R)

/-- **The record's "eigenbasis `{v_γ}` orthonormal"**: an orthonormal basis of the bivectors
consisting of eigenvectors of `R`, with eigenvalues `lam`. -/
structure EigenFrame (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (v : Γ → Matrix ι ι ℝ) (lam : Γ → ℝ) :
    Prop where
  skew : ∀ γ, IsSkew (v γ)
  orthonormal : ∀ γ δ, inner2 (v γ) (v δ) = if γ = δ then 1 else 0
  eigen : ∀ γ, R (v γ) = lam γ • v γ
  complete : ∀ X, IsSkew X → X = ∑ γ, inner2 X (v γ) • v γ

/-! ## The eigenframe machinery the two identities run on

`weyl_lin` (a Weyl operator is linear on bivectors, its symmetry forcing it), `parseval` and
`innerOp_frame` (the `φ`-basis pairing is the frame sum), `pw17` (Petersen–Wink Proposition 1.7 in
the eigenframe, `g_γ = Σ_{αβ}(λ_α - λ_β)² c_{γαβ}²`), and `killing_phi` (the Killing row, L153, in
the `φ` basis), and `aW2`, **`A(W) = 2W`**: `½ Σ_{ij} ⟨W[X,φ_ij],[X,φ_ij]⟩ = -2⟨WX,X⟩`
on `𝒲ₙ`, where 8 of the 16 terms of `E4sum` are Ricci contractions and Bianchi gives `2K = J`. -/

namespace Frame

theorem inner2_phi (M : Matrix ι ι ℝ) (k l : ι) : inner2 M (phi k l) = (1 / 2) * (M l k - M k l) := by
  rw [inner2_eq_sum]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, mul_sub, mul_ite, mul_one, mul_zero,
    Finset.sum_sub_distrib, ite_and]
  simp [Finset.sum_ite_eq, Finset.sum_ite_eq']

theorem inner2_add_l (X Y Z : Matrix ι ι ℝ) : inner2 (X + Y) Z = inner2 X Z + inner2 Y Z := by
  simp [inner2, Matrix.add_mul, Matrix.trace_add]; ring
theorem inner2_smul_l (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 (c • X) Y = c * inner2 X Y := by
  simp [inner2, Matrix.trace_smul]; ring
theorem inner2_sum_l {κ : Type*} (s : Finset κ) (f : κ → Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) :
    inner2 (∑ i ∈ s, f i) Y = ∑ i ∈ s, inner2 (f i) Y := by
  simp [inner2, Matrix.transpose_sum, Matrix.sum_mul, Matrix.trace_sum, Finset.mul_sum]
theorem inner2_sum_r {κ : Type*} (s : Finset κ) (f : κ → Matrix ι ι ℝ) (X : Matrix ι ι ℝ) :
    inner2 X (∑ i ∈ s, f i) = ∑ i ∈ s, inner2 X (f i) := by
  simp [inner2, Matrix.mul_sum, Matrix.trace_sum, Finset.mul_sum]
theorem inner2_smul_r (c : ℝ) (X Y : Matrix ι ι ℝ) : inner2 X (c • Y) = c * inner2 X Y := by
  simp [inner2, Matrix.trace_smul]; ring

theorem isSkew_sum {κ : Type*} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ)
    (hx : ∀ k, IsSkew (x k)) : IsSkew (∑ k ∈ s, c k • x k) := by
  unfold IsSkew at *
  simp only [Matrix.transpose_sum, Matrix.transpose_smul, hx, smul_neg, Finset.sum_neg_distrib]

/-- **A Weyl operator is linear on bivectors**, its symmetry forcing it: the defect is skew and
pairs to zero with every bivector. -/
theorem weyl_lin {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hR : IsWeyl R) {κ : Type*} (s : Finset κ)
    (c : κ → ℝ) (x : κ → Matrix ι ι ℝ) (hx : ∀ k, IsSkew (x k)) :
    R (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • R (x k) := by
  obtain ⟨hsk, hsym, -, -⟩ := hR
  set Z := R (∑ k ∈ s, c k • x k) - ∑ k ∈ s, c k • R (x k)
  have hZ : IsSkew Z := by
    have h1 := hsk _ (isSkew_sum s c x hx)
    have h2 := isSkew_sum s c (fun k => R (x k)) (fun k => hsk _ (hx k))
    unfold IsSkew at *; simp only [Z, Matrix.transpose_sub, h1, h2]; abel
  have hpair : ∀ Y, IsSkew Y → inner2 Z Y = 0 := by
    intro Y hY
    simp only [Z, sub_eq_add_neg, inner2_add_l, ← neg_one_smul ℝ (∑ k ∈ s, _), inner2_smul_l,
      inner2_sum_l, inner2_smul_l]
    rw [hsym _ Y (isSkew_sum s c x hx) hY, inner2_sum_l]
    simp only [inner2_smul_l]
    rw [show ∑ k ∈ s, c k * inner2 (R (x k)) Y = ∑ k ∈ s, c k * inner2 (x k) (R Y) from
      Finset.sum_congr rfl fun k _ => by rw [hsym _ Y (hx k) hY]]
    ring
  have := hpair Z hZ
  exact sub_eq_zero.mp (inner2_self_eq_zero this)

/-- **Polarised Parseval in the `φ` basis**, for skew `X`. -/
theorem parseval (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    (1 / 2) * ∑ i, ∑ j, inner2 X (phi i j) * inner2 Y (phi i j) = inner2 X Y := by
  have hX' : ∀ a b, X b a = - X a b := fun a b => by
    have := congrFun (congrFun hX a) b; simpa [Matrix.transpose_apply] using this
  have hY' : ∀ a b, Y b a = - Y a b := fun a b => by
    have := congrFun (congrFun hY a) b; simpa [Matrix.transpose_apply] using this
  rw [inner2_eq_sum]
  simp only [inner2_phi]
  congr 1
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  rw [hX' a b, hY' a b]; ring

/-- **The frame expansion of a bivector.** -/
theorem frame_expand {R : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame R v lam) (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    X = ∑ γ, inner2 X (v γ) • v γ := hf.complete X hX

/-- **`innerOp` IN THE FRAME.** For operators linear on bivectors, the `φ`-basis sum is the frame
sum. -/
theorem innerOp_frame {R : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame R v lam) (F G : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hF : ∀ c : Γ → ℝ, F (∑ γ, c γ • v γ) = ∑ γ, c γ • F (v γ))
    (hG : ∀ c : Γ → ℝ, G (∑ γ, c γ • v γ) = ∑ γ, c γ • G (v γ)) :
    innerOp F G = ∑ γ, inner2 (F (v γ)) (G (v γ)) := by
  unfold innerOp
  have hφ : ∀ i j, phi i j = ∑ γ, inner2 (phi i j) (v γ) • v γ :=
    fun i j => hf.complete _ (HamiltonsCubic.RealLayer.phi_isSkew i j)
  have hpair : ∀ γ δ, (1 / 2) * ∑ i, ∑ j, inner2 (v γ) (phi i j) * inner2 (v δ) (phi i j)
      = if γ = δ then 1 else 0 := fun γ δ => by
    rw [parseval _ _ (hf.skew γ) (hf.skew δ), hf.orthonormal]
  have e : ∀ i j, inner2 (F (phi i j)) (G (phi i j))
      = ∑ γ, ∑ δ, inner2 (v γ) (phi i j) * inner2 (v δ) (phi i j) * inner2 (F (v γ)) (G (v δ)) := by
    intro i j
    conv_lhs => rw [hφ i j, hF, hG]
    rw [inner2_sum_l]
    refine Finset.sum_congr rfl fun γ _ => ?_
    rw [inner2_smul_l, inner2_sum_r, Finset.mul_sum]
    refine Finset.sum_congr rfl fun δ _ => ?_
    rw [inner2_smul_r, inner2_comm (phi i j) (v γ), inner2_comm (phi i j) (v δ)]; ring
  simp only [e]
  have sw : ∀ f : ι → ι → Γ → Γ → ℝ, ∑ i, ∑ j, ∑ γ, ∑ δ, f i j γ δ = ∑ γ, ∑ δ, ∑ i, ∑ j, f i j γ δ := by
    intro f
    calc ∑ i, ∑ j, ∑ γ, ∑ δ, f i j γ δ = ∑ i, ∑ γ, ∑ δ, ∑ j, f i j γ δ :=
          Finset.sum_congr rfl fun i _ => by
            rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun γ _ => Finset.sum_comm
      _ = ∑ γ, ∑ δ, ∑ i, ∑ j, f i j γ δ := by
          rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun γ _ => Finset.sum_comm
  rw [sw, Finset.mul_sum]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [Finset.mul_sum]
  simp only [← Finset.sum_mul, ← mul_assoc, hpair, ite_mul, one_mul, zero_mul, Finset.sum_ite_eq,
    Finset.mem_univ, if_true]

theorem br_skew {X Y : Matrix ι ι ℝ} (hX : IsSkew X) (hY : IsSkew Y) : IsSkew (br X Y) := by
  unfold IsSkew at *
  simp only [br, Matrix.transpose_sub, Matrix.transpose_mul, hX, hY, Matrix.neg_mul, Matrix.mul_neg,
    neg_neg]
  abel

theorem br_sum_r {κ : Type*} (s : Finset κ) (u : Matrix ι ι ℝ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ) :
    br u (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • br u (x k) := by
  simp only [br, Matrix.mul_sum, Matrix.sum_mul, Matrix.mul_smul, Matrix.smul_mul, ← Finset.sum_sub_distrib,
    smul_sub]

theorem br_smul_r (u : Matrix ι ι ℝ) (c : ℝ) (x : Matrix ι ι ℝ) : br u (c • x) = c • br u x := by
  simp only [br, Matrix.mul_smul, Matrix.smul_mul, smul_sub]

theorem frame_sq {R : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame R v lam) (d : Γ → ℝ) :
    inner2 (∑ β, d β • v β) (∑ β, d β • v β) = ∑ β, d β ^ 2 := by
  simp only [inner2_sum_l, inner2_sum_r, inner2_smul_l, inner2_smul_r, hf.orthonormal, mul_ite, mul_one,
    mul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  exact Finset.sum_congr rfl fun β _ => by ring

/-- **Petersen–Wink Proposition 1.7 in the eigenframe**: `g_γ = Σ_{αβ} (λ_α - λ_β)² c_{γαβ}²`. -/
theorem pw17 {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hR : IsWeyl R) {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}
    (hf : EigenFrame R v lam) (γ : Γ) :
    gMass R (v γ) = ∑ α, ∑ β, (lam α - lam β) ^ 2 * inner2 (br (v γ) (v α)) (v β) ^ 2 := by
  have hC : ∀ c : Γ → ℝ, commOp (adOp (v γ)) R (∑ α, c α • v α)
      = ∑ α, c α • commOp (adOp (v γ)) R (v α) := by
    intro c
    simp only [commOp, adOp]
    rw [weyl_lin hR _ c v hf.skew, br_sum_r, br_sum_r,
      weyl_lin hR _ c (fun α => br (v γ) (v α)) (fun α => br_skew (hf.skew γ) (hf.skew α)),
      ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun α _ => (smul_sub _ _ _).symm
  unfold gMass
  rw [innerOp_frame hf _ _ hC hC]
  refine Finset.sum_congr rfl fun α _ => ?_
  have hexp := hf.complete _ (br_skew (hf.skew γ) (hf.skew α))
  have hCα : commOp (adOp (v γ)) R (v α)
      = ∑ β, ((lam α - lam β) * inner2 (br (v γ) (v α)) (v β)) • v β := by
    simp only [commOp, adOp]
    rw [hf.eigen α, br_smul_r]
    conv_lhs => rw [hexp]
    rw [weyl_lin hR _ _ v hf.skew, Finset.smul_sum, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun β _ => ?_
    rw [hf.eigen β, smul_smul, smul_smul, ← sub_smul]
    congr 1; ring
  rw [hCα, frame_sq hf]
  exact Finset.sum_congr rfl fun β _ => by ring

theorem brphi_entry (X : Matrix ι ι ℝ) (a b i j : ι) :
    br X (phi a b) i j
      = (if a = j then X i b else 0) - (if b = j then X i a else 0)
        - (if b = i then X a j else 0) + (if a = i then X b j else 0) := by
  simp [br, phi, Matrix.mul_apply, Matrix.single_apply, ite_and, Matrix.sub_apply,
    mul_sub, sub_mul, mul_ite, ite_mul, mul_zero, zero_mul, mul_one, one_mul,
    Finset.sum_sub_distrib, Finset.sum_ite_eq]
  ring

/-- **The Killing row, L153, in the `φ` basis**: `½ Σ_{ij} ‖[X, φ_ij]‖² = 2(n-2)‖X‖²` for skew `X`. -/
theorem killing_phi (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    (1 / 2) * ∑ i, ∑ j, inner2 (br X (phi i j)) (br X (phi i j))
      = 2 * ((Fintype.card ι : ℝ) - 2) * inner2 X X := by
  have hX' : ∀ a b, X b a = - X a b := fun a b => by
    have := congrFun (congrFun hX a) b; simpa [Matrix.transpose_apply] using this
  have hd : ∀ a, X a a = 0 := fun a => by have := hX' a a; linarith
  simp only [inner2_eq_sum, brphi_entry]
  simp only [sq, mul_sub, sub_mul, add_mul, mul_add, ite_mul, mul_ite, zero_mul, mul_zero,
    Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.mul_sum, Finset.sum_ite_eq, Finset.sum_ite_eq',
    Finset.mem_univ, if_true, Finset.sum_ite_irrel, Finset.sum_const_zero, hd]
  simp only [← Finset.mul_sum, Finset.sum_const, Finset.card_univ, nsmul_eq_mul, sub_zero, zero_sub,
    add_zero]
  have hA1 : ∑ x, ∑ i, X i x * X i x = ∑ x, ∑ i, X x i * X x i := Finset.sum_comm
  have hA3 : ∑ x, ∑ i, X i x * X x i = -∑ x, ∑ i, X x i * X x i := by
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun i _ => by rw [hX' i x]; ring
  have hA4 : ∑ x, ∑ i, X x i * X i x = -∑ x, ∑ i, X x i * X x i := by
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun i _ => by rw [hX' i x]; ring
  rw [hA1, hA3, hA4]
  ring

/-- **A bivector in the `φ` basis**: `Z = ½ Σ_{ab} ⟨Z, φ_ab⟩ φ_ab`. -/
theorem phi_expand (Z : Matrix ι ι ℝ) (hZ : IsSkew Z) :
    Z = ∑ a, ∑ b, ((1 / 2) * inner2 Z (phi a b)) • phi a b := by
  set E := ∑ a, ∑ b, ((1 / 2) * inner2 Z (phi a b)) • phi a b
  have hE : IsSkew E := by
    have : E = ∑ p : ι × ι, ((1 / 2) * inner2 Z (phi p.1 p.2)) • phi p.1 p.2 := by
      rw [← Finset.univ_product_univ, Finset.sum_product]
    rw [this]; exact isSkew_sum _ _ _ fun p => HamiltonsCubic.RealLayer.phi_isSkew _ _
  have hpair : ∀ Y, IsSkew Y → inner2 (Z - E) Y = 0 := by
    intro Y hY
    rw [sub_eq_add_neg, inner2_add_l, ← neg_one_smul ℝ E, inner2_smul_l]
    simp only [E, inner2_sum_l, inner2_smul_l]
    have := parseval Z Y hZ hY
    rw [Finset.mul_sum] at this
    simp only [Finset.mul_sum] at this
    have e : ∑ a, ∑ b, 1 / 2 * inner2 Z (phi a b) * inner2 (phi a b) Y
        = ∑ a, ∑ b, 1 / 2 * (inner2 Z (phi a b) * inner2 Y (phi a b)) :=
      Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by rw [inner2_comm (phi a b) Y]; ring
    rw [e, this]; ring
  have hZE : IsSkew (Z - E) := by unfold IsSkew at *; rw [Matrix.transpose_sub, hZ, hE]; abel
  exact (sub_eq_zero.mp (inner2_self_eq_zero (hpair _ hZE))).symm ▸ rfl

/-- **The `i,j` contraction of two brackets**, the whole `X`-side of `A(W) = 2W`. -/
theorem E4sum (X : Matrix ι ι ℝ) (hX : IsSkew X) (a b c d : ι) :
    ∑ i, ∑ j, br X (phi i j) a b * br X (phi i j) c d
      = -2 * (X * X) a c * (if b = d then 1 else 0) + 2 * (X * X) a d * (if b = c then 1 else 0)
        + 2 * (X * X) c b * (if a = d then 1 else 0) - 2 * (X * X) b d * (if a = c then 1 else 0)
        - 4 * X a d * X c b - 4 * X a c * X b d := by
  have hX' : ∀ p q, X q p = - X p q := fun p q => by
    have := congrFun (congrFun hX p) q; simpa [Matrix.transpose_apply] using this
  simp only [brphi_entry, Matrix.mul_apply]
  simp only [mul_sub, sub_mul, add_mul, mul_add, ite_mul, mul_ite, zero_mul, mul_zero,
    Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq',
    Finset.mem_univ, if_true, Finset.sum_ite_irrel, Finset.sum_const_zero]
  have m1 : ∀ p q, ∑ x, X p x * X q x = -∑ x, X p x * X x q := fun p q => by
    rw [← Finset.sum_neg_distrib]; exact Finset.sum_congr rfl fun x _ => by rw [hX' x q]; ring
  have m2 : ∀ p q, ∑ x, X x p * X q x = ∑ x, X q x * X x p := fun p q =>
    Finset.sum_congr rfl fun x _ => by ring
  have m3 : ∀ p q, ∑ x, X x p * X x q = -∑ x, X p x * X x q := fun p q => by
    rw [← Finset.sum_neg_distrib]; exact Finset.sum_congr rfl fun x _ => by rw [hX' p x]; ring
  rw [m1 a c, m2 b c, m3 b d, hX' b d, hX' a c]
  clear m1 m2 m3 hX' hX
  split_ifs <;> subst_vars <;> simp_all <;> ring

section Coeff
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ}

/-- The coefficients `C_{abcd} = ⟨W φ_ab, φ_cd⟩`. -/
noncomputable def C (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (a b c d : ι) : ℝ := inner2 (W (phi a b)) (phi c d)

theorem W_neg (hW : IsWeyl W) (X : Matrix ι ι ℝ) (hX : IsSkew X) : W (-X) = -W X := by
  have := weyl_lin hW (Finset.univ : Finset (Fin 1)) (fun _ => -1) (fun _ => X) (fun _ => hX)
  simpa using this

theorem C_anti1 (hW : IsWeyl W) (a b c d : ι) : C W a b c d = -C W b a c d := by
  unfold C
  rw [HamiltonsCubic.RealLayer.phi_swap a b, W_neg hW _ (HamiltonsCubic.RealLayer.phi_isSkew a b),
    ← neg_one_smul ℝ (W (phi a b)), inner2_smul_l]; ring

theorem C_anti2 (a b c d : ι) : C W a b c d = -C W a b d c := by
  unfold C
  rw [HamiltonsCubic.RealLayer.phi_swap c d, ← neg_one_smul ℝ (phi c d), inner2_smul_r]; ring

theorem C_pair (hW : IsWeyl W) (a b c d : ι) : C W a b c d = C W c d a b := by
  unfold C
  rw [hW.2.1 _ _ (HamiltonsCubic.RealLayer.phi_isSkew a b) (HamiltonsCubic.RealLayer.phi_isSkew c d),
    inner2_comm]

theorem C_bianchi (hW : IsWeyl W) (a b c d : ι) : C W a b c d + C W a c d b + C W a d b c = 0 :=
  hW.2.2.1 a b c d

theorem C_ric (hW : IsWeyl W) (a b : ι) : ∑ c, C W a c b c = 0 := hW.2.2.2 a b

end Coeff

section Contract
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ}

theorem weyl_lin2 (hW : IsWeyl W) (k : ι → ι → ℝ) (x : ι → ι → Matrix ι ι ℝ) (hx : ∀ a b, IsSkew (x a b)) :
    W (∑ a, ∑ b, k a b • x a b) = ∑ a, ∑ b, k a b • W (x a b) := by
  have e1 : ∑ a, ∑ b, k a b • x a b = ∑ p ∈ (Finset.univ ×ˢ Finset.univ : Finset (ι × ι)),
      k p.1 p.2 • x p.1 p.2 := (Finset.sum_product' _ _ _).symm
  have e2 : ∑ a, ∑ b, k a b • W (x a b) = ∑ p ∈ (Finset.univ ×ˢ Finset.univ : Finset (ι × ι)),
      k p.1 p.2 • W (x p.1 p.2) := (Finset.sum_product' _ _ _).symm
  rw [e1, e2]
  exact weyl_lin hW _ (fun p : ι × ι => k p.1 p.2) (fun p => x p.1 p.2) fun p => hx p.1 p.2

theorem coef (Z : Matrix ι ι ℝ) (hZ : IsSkew Z) (a b : ι) : (1 / 2) * inner2 Z (phi a b) = (1 / 2) * Z b a := by
  have : Z a b = -Z b a := by
    have := congrFun (congrFun hZ b) a; simpa [Matrix.transpose_apply] using this
  rw [Frame.inner2_phi, this]; ring

theorem quad_coord (hW : IsWeyl W) (Z : Matrix ι ι ℝ) (hZ : IsSkew Z) :
    inner2 (W Z) Z = ∑ a, ∑ b, ∑ c, ∑ d, ((1 / 2) * Z b a) * ((1 / 2) * Z d c) * C W a b c d := by
  have hE := phi_expand Z hZ
  conv_lhs => rw [hE]
  rw [weyl_lin2 hW _ _ fun a b => HamiltonsCubic.RealLayer.phi_isSkew a b]
  simp only [inner2_sum_l, inner2_sum_r, inner2_smul_l, inner2_smul_r, Finset.mul_sum, coef Z hZ]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl
    fun c _ => Finset.sum_congr rfl fun d _ => ?_
  unfold C
  rw [hW.2.1 _ _ (HamiltonsCubic.RealLayer.phi_isSkew c d) (HamiltonsCubic.RealLayer.phi_isSkew a b),
    inner2_comm (phi c d)]
  ring

theorem push_in {κ : Type*} [Fintype κ] (g : κ → ι → ι → ι → ι → ℝ) :
    ∑ i, ∑ a, ∑ b, ∑ c, ∑ d, g i a b c d = ∑ a, ∑ b, ∑ c, ∑ d, ∑ i, g i a b c d := by
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [Finset.sum_comm]

theorem sum6 (f : ι → ι → ι → ι → ι → ι → ℝ) :
    ∑ i, ∑ j, ∑ a, ∑ b, ∑ c, ∑ d, f i j a b c d = ∑ a, ∑ b, ∑ c, ∑ d, ∑ i, ∑ j, f i j a b c d := by
  rw [Finset.sum_congr rfl fun i _ => push_in (f i)]
  exact push_in (fun i a b c d => ∑ j, f i j a b c d)

theorem swap34 (f : ι → ι → ι → ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ a, ∑ b, ∑ d, ∑ c, f a b c d :=
  Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => Finset.sum_comm

theorem swap23 (f : ι → ι → ι → ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ a, ∑ c, ∑ b, ∑ d, f a b c d :=
  Finset.sum_congr rfl fun a _ => Finset.sum_comm

theorem swap12 (f : ι → ι → ι → ℝ) : ∑ a, ∑ b, ∑ c, f a b c = ∑ b, ∑ a, ∑ c, f a b c := Finset.sum_comm

theorem ric_zero_A (hW : IsWeyl W) (g : ι → ι → ℝ) : ∑ x, ∑ y, ∑ i, C W x y x i * g y i = 0 := by
  rw [swap12]
  refine Finset.sum_eq_zero fun y _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_eq_zero fun i _ => ?_
  rw [← Finset.sum_mul]
  have : ∑ x, C W x y x i = ∑ x, C W y x i x :=
    Finset.sum_congr rfl fun x _ => by rw [C_anti1 hW, C_anti2 (W := W) y x x i]; ring
  rw [this, C_ric hW, zero_mul]

theorem ric_zero_B (hW : IsWeyl W) (g : ι → ι → ℝ) : ∑ x, ∑ y, ∑ i, C W x y i x * g y i = 0 := by
  have : ∀ x y i, C W x y i x * g y i = C W x y x i * (-g y i) := fun x y i => by
    rw [C_anti2 (W := W) x y i x]; ring
  simp only [this]; exact ric_zero_A hW _

theorem ric_zero_C (hW : IsWeyl W) (g : ι → ι → ℝ) : ∑ x, ∑ y, ∑ i, C W x y y i * g i x = 0 := by
  refine Finset.sum_eq_zero fun x _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_eq_zero fun i _ => ?_
  rw [← Finset.sum_mul]
  have : ∑ y, C W x y y i = -∑ y, C W x y i y := by
    rw [← Finset.sum_neg_distrib]; exact Finset.sum_congr rfl fun y _ => C_anti2 (W := W) x y y i
  rw [this, C_ric hW, neg_zero, zero_mul]

theorem ric_zero_D (hW : IsWeyl W) (g : ι → ι → ℝ) : ∑ x, ∑ y, ∑ i, C W x y i y * g x i = 0 := by
  refine Finset.sum_eq_zero fun x _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_eq_zero fun i _ => ?_
  rw [← Finset.sum_mul, C_ric hW, zero_mul]

/-- **`A(W) = 2W`**: `½ Σ_{ij} ⟨W[X,φ_ij], [X,φ_ij]⟩ = -2⟨WX, X⟩` on `𝒲ₙ`. -/
theorem aW2 (hW : IsWeyl W) (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    (1 / 2) * ∑ i, ∑ j, inner2 (W (br X (phi i j))) (br X (phi i j)) = -2 * inner2 (W X) X := by
  rw [quad_coord hW X hX]
  simp only [fun i j => quad_coord hW _ (br_skew hX (HamiltonsCubic.RealLayer.phi_isSkew i j))]
  rw [sum6]
  have hin : ∀ a b c d, ∑ i, ∑ j, 1 / 2 * br X (phi i j) b a * (1 / 2 * br X (phi i j) d c) * C W a b c d
      = 1 / 4 * C W a b c d * (∑ i, ∑ j, br X (phi i j) b a * br X (phi i j) d c) := by
    intro a b c d
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun j _ => by ring
  simp only [hin, E4sum X hX]
  simp only [mul_add, mul_sub, add_mul, sub_mul, mul_ite, ite_mul, mul_one, mul_zero, zero_mul,
    Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.mul_sum, Finset.sum_ite_eq, Finset.sum_ite_eq',
    Finset.mem_univ, if_true, Finset.sum_ite_irrel, Finset.sum_const_zero]
  have hX' : ∀ p q, X q p = -X p q := fun p q => by
    have := congrFun (congrFun hX p) q; simpa [Matrix.transpose_apply] using this
  set J := ∑ a, ∑ b, ∑ c, ∑ d, C W a b c d * (X a b * X c d) with hJ
  set K := ∑ a, ∑ b, ∑ c, ∑ d, C W a b c d * (X a c * X b d) with hK
  have hR1 : ∑ x, ∑ x_1, ∑ i, 1 / 2 * (1 / 4 * C W x x_1 x i * (-2 * (X * X) x_1 i)) = 0 := by
    rw [← ric_zero_A hW (fun y i => -(1 / 4) * (X * X) y i)]
    exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
  have hR2 : ∑ x, ∑ x_1, ∑ i, 1 / 2 * (1 / 4 * C W x x_1 i x * (2 * (X * X) x_1 i)) = 0 := by
    rw [← ric_zero_B hW (fun y i => (1 / 4) * (X * X) y i)]
    exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
  have hR3 : ∑ x, ∑ x_1, ∑ i, 1 / 2 * (1 / 4 * C W x x_1 x_1 i * (2 * (X * X) i x)) = 0 := by
    rw [← ric_zero_C hW (fun i x => (1 / 4) * (X * X) i x)]
    exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
  have hR4 : ∑ x, ∑ x_1, ∑ i, 1 / 2 * (1 / 4 * C W x x_1 i x_1 * (2 * (X * X) x i)) = 0 := by
    rw [← ric_zero_D hW (fun x i => (1 / 4) * (X * X) x i)]
    exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
  have hN2 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, 1 / 2 * (1 / 4 * C W x x_1 x_2 i * (4 * X x_1 i * X x x_2)) = (1 / 2) * K := by
    rw [hK, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun c _ => ?_; rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun d _ => by ring
  have hN1 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, 1 / 2 * (1 / 4 * C W x x_1 x_2 i * (4 * X x_1 x_2 * X i x)) = (1 / 2) * K := by
    rw [swap34, hK, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun c _ => ?_; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [C_anti2 (W := W) a b d c, hX' c a]; ring
  have hRHS : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -2 * (1 / 2 * X x_1 x * (1 / 2 * X i x_2) * C W x x_1 x_2 i)
      = -(1 / 2) * J := by
    rw [hJ, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun c _ => ?_; rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun d _ => ?_
    rw [hX' a b, hX' c d]; ring
  -- the Bianchi step, `2K = J`
  have hS1 : ∑ a, ∑ b, ∑ c, ∑ d, C W a c d b * (X a c * X b d) = -J := by
    rw [swap23, swap34, hJ, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_; rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun c _ => ?_; rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun d _ => ?_; rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [hX' d b]; ring
  have hS2 : ∑ a, ∑ b, ∑ c, ∑ d, C W a d b c * (X a c * X b d) = K := by
    rw [swap34, swap23, swap34, hK]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl
      fun r _ => Finset.sum_congr rfl fun s _ => ?_
    rw [C_anti2 (W := W) a q s r, hX' q s]; ring
  have hB : K = J - K := by
    have : ∀ a b c d, C W a b c d * (X a c * X b d)
        = -(C W a c d b * (X a c * X b d)) - C W a d b c * (X a c * X b d) := fun a b c d => by
      have := C_bianchi hW a b c d; linear_combination (X a c * X b d) * this
    have e : K = -(∑ a, ∑ b, ∑ c, ∑ d, C W a c d b * (X a c * X b d))
        - ∑ a, ∑ b, ∑ c, ∑ d, C W a d b c * (X a c * X b d) := by
      rw [hK]; simp only [this, Finset.sum_sub_distrib, Finset.sum_neg_distrib]
    rw [hS1, hS2] at e; linarith
  rw [hR1, hR2, hR3, hR4, hN1, hN2, hRHS]
  linarith

end Contract

/-- **ad-invariance of the pairing**: `⟨[X, A], B⟩ = -⟨A, [X, B]⟩` for skew `X`, `A`. -/
theorem adinv {X A : Matrix ι ι ℝ} (B : Matrix ι ι ℝ) (hX : IsSkew X) (hA : IsSkew A) :
    inner2 (br X A) B = -inner2 A (br X B) := by
  unfold IsSkew at hX hA
  simp only [inner2, br, Matrix.transpose_sub, Matrix.transpose_mul, hX, hA, Matrix.neg_mul,
    Matrix.mul_neg, neg_neg, Matrix.sub_mul, Matrix.mul_sub, Matrix.trace_sub, Matrix.trace_neg]
  have h1 : Matrix.trace (A * X * B) = Matrix.trace (A * (X * B)) := by rw [Matrix.mul_assoc]
  have h2 : Matrix.trace (X * A * B) = Matrix.trace (A * (B * X)) := by
    rw [Matrix.mul_assoc, Matrix.trace_mul_comm, Matrix.mul_assoc]
  rw [h1, h2]; ring

theorem inner2_neg_r' (X Y : Matrix ι ι ℝ) : inner2 X (-Y) = -inner2 X Y := by
  rw [← neg_one_smul ℝ Y, inner2_smul_r]; ring

/-- **`⟨W# η, η⟩` in the eigenframe**: `½ Σ_{αβ} λ_α λ_β ⟨[η, v_α], v_β⟩²`. -/
theorem sharpQF_frame {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ}
    {lam : Γ → ℝ} (hf : EigenFrame W v lam) (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    sharpQF W η = (1 / 2) * ∑ α, ∑ β, lam α * lam β * inner2 (br η (v α)) (v β) ^ 2 := by
  set F : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X => br η (W (br η (W X))) with hF
  have hlin : ∀ c : Γ → ℝ, F (∑ α, c α • v α) = ∑ α, c α • F (v α) := by
    intro c
    simp only [hF]
    rw [weyl_lin hW _ c v hf.skew, br_sum_r,
      weyl_lin hW _ c (fun α => br η (W (v α))) (fun α => br_skew hη (hW.1 _ (hf.skew α))), br_sum_r]
  have hid : ∀ c : Γ → ℝ, (fun X : Matrix ι ι ℝ => X) (∑ α, c α • v α) = ∑ α, c α • (fun X => X) (v α) :=
    fun c => rfl
  have hQ : sharpQF W η = -(1 / 2) * innerOp F (fun X => X) := by
    unfold sharpQF innerOp; simp only [hF]; ring
  rw [hQ, innerOp_frame hf F (fun X => X) hlin hid]
  -- evaluate `⟨F v_α, v_α⟩`
  have hFa : ∀ α, inner2 (F (v α)) (v α)
      = -(lam α * ∑ β, lam β * inner2 (br η (v α)) (v β) ^ 2) := by
    intro α
    have hWs : W (lam α • br η (v α)) = lam α • W (br η (v α)) := by
      have := weyl_lin hW (Finset.univ : Finset (Fin 1)) (fun _ => lam α) (fun _ => br η (v α))
        (fun _ => br_skew hη (hf.skew α))
      simpa using this
    have hexp := hf.complete _ (br_skew hη (hf.skew α))
    have hWb : W (br η (v α)) = ∑ β, (inner2 (br η (v α)) (v β) * lam β) • v β := by
      conv_lhs => rw [hexp]
      rw [weyl_lin hW _ _ v hf.skew]
      exact Finset.sum_congr rfl fun β _ => by rw [hf.eigen β, smul_smul]
    have hc : ∀ β, inner2 (br η (v β)) (v α) = -inner2 (br η (v α)) (v β) := fun β => by
      rw [adinv _ hη (hf.skew β), inner2_comm]
    simp only [hF, hf.eigen α, br_smul_r, hWs, hWb, br_sum_r, inner2_smul_l, inner2_sum_l, hc]
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun β _ => by ring
  simp only [hFa, Finset.mul_sum, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
  ring

section Sharp
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ}

theorem W_add (hW : IsWeyl W) (A B : Matrix ι ι ℝ) (hA : IsSkew A) (hB : IsSkew B) :
    W (A + B) = W A + W B := by
  have := weyl_lin hW (Finset.univ : Finset (Fin 2)) (fun _ => 1) ![A, B]
    (by intro k; fin_cases k <;> simpa)
  simpa [Fin.sum_univ_two] using this

theorem br_add_l' (X Y Z : Matrix ι ι ℝ) : br (X + Y) Z = br X Z + br Y Z := by
  simp only [br, Matrix.add_mul, Matrix.mul_add]; abel
theorem br_add_r' (X Y Z : Matrix ι ι ℝ) : br X (Y + Z) = br X Y + br X Z := by
  simp only [br, Matrix.add_mul, Matrix.mul_add]; abel

/-- **The polarised `#` for a Weyl operator**, on bivectors. -/
theorem sharpBil_formula (hW : IsWeyl W) (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    sharpBil W X Y = -(1 / 8) * ∑ i, ∑ j,
      (inner2 (br X (W (br Y (W (phi i j))))) (phi i j) + inner2 (br Y (W (br X (W (phi i j))))) (phi i j)) := by
  unfold sharpBil sharpQF
  have hs : ∀ (Z : Matrix ι ι ℝ), IsSkew Z → ∀ i j, IsSkew (br Z (W (phi i j))) := fun Z hZ i j =>
    br_skew hZ (hW.1 _ (HamiltonsCubic.RealLayer.phi_isSkew i j))
  have h : ∀ i j : ι,
      inner2 (br (X + Y) (W (br (X + Y) (W (phi i j))))) (phi i j)
        = inner2 (br X (W (br X (W (phi i j))))) (phi i j)
          + inner2 (br Y (W (br Y (W (phi i j))))) (phi i j)
          + (inner2 (br X (W (br Y (W (phi i j))))) (phi i j)
             + inner2 (br Y (W (br X (W (phi i j))))) (phi i j)) := by
    intro i j
    rw [br_add_l' X Y (W (phi i j)), W_add hW _ _ (hs X hX i j) (hs Y hY i j), br_add_l', br_add_r',
      br_add_r', inner2_add_l, inner2_add_l, inner2_add_l]
    ring
  simp only [h, Finset.sum_add_distrib]
  ring

theorem sharpBil_comm (hW : IsWeyl W) (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    sharpBil W X Y = sharpBil W Y X := by
  rw [sharpBil_formula hW X Y hX hY, sharpBil_formula hW Y X hY hX]
  congr 1
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => add_comm _ _

theorem sharpBil_self (hW : IsWeyl W) (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    sharpBil W X X = sharpQF W X := by
  rw [sharpBil_formula hW X X hX hX]; unfold sharpQF
  rw [Finset.mul_sum, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum, Finset.mul_sum]
  exact Finset.sum_congr rfl fun j _ => by ring

theorem br_sum_l' {κ : Type*} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ) (Z : Matrix ι ι ℝ) :
    br (∑ k ∈ s, c k • x k) Z = ∑ k ∈ s, c k • br (x k) Z := by
  simp only [br, Matrix.sum_mul, Matrix.mul_sum, Matrix.smul_mul, Matrix.mul_smul, ← Finset.sum_sub_distrib,
    smul_sub]

theorem mix {κ : Type*} (s : Finset κ) (g : κ → ι → ι → ℝ) :
    ∑ i, ∑ j, ∑ k ∈ s, g k i j = ∑ k ∈ s, ∑ i, ∑ j, g k i j := by
  rw [show (∑ i, ∑ j, ∑ k ∈ s, g k i j) = ∑ i, ∑ k ∈ s, ∑ j, g k i j from
    Finset.sum_congr rfl fun i _ => Finset.sum_comm]
  exact Finset.sum_comm

theorem mixM {κ β : Type*} [AddCommMonoid β] (s : Finset κ) (g : κ → ι → ι → β) :
    ∑ i, ∑ j, ∑ k ∈ s, g k i j = ∑ k ∈ s, ∑ i, ∑ j, g k i j := by
  rw [show (∑ i, ∑ j, ∑ k ∈ s, g k i j) = ∑ i, ∑ k ∈ s, ∑ j, g k i j from
    Finset.sum_congr rfl fun i _ => Finset.sum_comm]
  exact Finset.sum_comm

theorem sharpBil_lin_l (hW : IsWeyl W) {κ : Type*} (s : Finset κ) (c : κ → ℝ) (x : κ → Matrix ι ι ℝ)
    (hx : ∀ k, IsSkew (x k)) (Y : Matrix ι ι ℝ) (hY : IsSkew Y) :
    sharpBil W (∑ k ∈ s, c k • x k) Y = ∑ k ∈ s, c k * sharpBil W (x k) Y := by
  rw [sharpBil_formula hW _ Y (isSkew_sum s c x hx) hY]
  simp only [fun k => sharpBil_formula hW (x k) Y (hx k) hY]
  have hs : ∀ i j k, IsSkew (br (x k) (W (phi i j))) := fun i j k =>
    br_skew (hx k) (hW.1 _ (HamiltonsCubic.RealLayer.phi_isSkew i j))
  simp only [br_sum_l', fun i j => weyl_lin hW s c (fun k => br (x k) (W (phi i j))) (hs i j), br_sum_r,
    inner2_sum_l, inner2_smul_l]
  simp only [← Finset.sum_add_distrib, ← mul_add]
  rw [mix, Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  simp only [← Finset.mul_sum]
  ring

theorem sharpBil_lin_r (hW : IsWeyl W) (X : Matrix ι ι ℝ) (hX : IsSkew X) {κ : Type*} (s : Finset κ)
    (c : κ → ℝ) (y : κ → Matrix ι ι ℝ) (hy : ∀ k, IsSkew (y k)) :
    sharpBil W X (∑ k ∈ s, c k • y k) = ∑ k ∈ s, c k * sharpBil W X (y k) := by
  rw [sharpBil_comm hW _ _ hX (isSkew_sum s c y hy), sharpBil_lin_l hW s c y hy X hX]
  exact Finset.sum_congr rfl fun k _ => by rw [sharpBil_comm hW _ _ (hy k) hX]

/-- **`⟨v, W# v⟩ = ⟨W# v, v⟩`**: the operator form pairs back to the quadratic form. -/
theorem inner_sharpOp (hW : IsWeyl W) (v : Matrix ι ι ℝ) (hv : IsSkew v) :
    inner2 v (sharpOp W v) = sharpQF W v := by
  rw [← sharpBil_self hW v hv]
  have hE := phi_expand v hv
  have ex : ∑ a, ∑ b, ((1 / 2) * inner2 v (phi a b)) • phi a b
      = ∑ p ∈ (Finset.univ ×ˢ Finset.univ : Finset (ι × ι)), ((1 / 2) * inner2 v (phi p.1 p.2)) • phi p.1 p.2 :=
    (Finset.sum_product' _ _ _).symm
  have e2 : sharpBil W v v = sharpBil W v
      (∑ p ∈ (Finset.univ ×ˢ Finset.univ : Finset (ι × ι)), ((1 / 2) * inner2 v (phi p.1 p.2)) • phi p.1 p.2) := by
    rw [← ex, ← hE]
  rw [e2, sharpBil_lin_r hW v hv (Finset.univ ×ˢ Finset.univ)
    (fun p : ι × ι => (1 / 2) * inner2 v (phi p.1 p.2)) (fun p => phi p.1 p.2)
    (fun p => HamiltonsCubic.RealLayer.phi_isSkew p.1 p.2),
    Finset.sum_product' (f := fun a b => (1 / 2) * inner2 v (phi a b) * sharpBil W v (phi a b))]
  unfold sharpOp
  rw [inner2_smul_r, inner2_sum_r, Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [inner2_sum_r, Finset.mul_sum]
  exact Finset.sum_congr rfl fun b _ => by rw [inner2_smul_r]; ring

theorem sharpOp_lin (hW : IsWeyl W) {v : Γ → Matrix ι ι ℝ} (hv : ∀ γ, IsSkew (v γ)) (c : Γ → ℝ) :
    sharpOp W (∑ γ, c γ • v γ) = ∑ γ, c γ • sharpOp W (v γ) := by
  unfold sharpOp
  simp only [fun i j => sharpBil_lin_l hW Finset.univ c v hv (phi i j) (HamiltonsCubic.RealLayer.phi_isSkew i j),
    Finset.sum_smul, Finset.smul_sum, smul_smul]
  rw [mixM]
  refine Finset.sum_congr rfl fun γ _ => Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  congr 1; ring

end Sharp

section Assembly
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}

/-- **`⟨W, W#⟩` in the eigenframe.** -/
theorem sharpPair_frame (hW : IsWeyl W) (hf : EigenFrame W v lam) :
    sharpPair W = ∑ γ, lam γ * sharpQF W (v γ) := by
  unfold sharpPair
  rw [innerOp_frame hf W (sharpOp W) (fun c => weyl_lin hW _ c v hf.skew) (sharpOp_lin hW hf.skew)]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [hf.eigen γ, inner2_smul_l, inner_sharpOp hW _ (hf.skew γ)]

/-- The structure constants of the frame. -/
noncomputable def cst (v : Γ → Matrix ι ι ℝ) (a b c : Γ) : ℝ := inner2 (br (v a) (v b)) (v c)

theorem cst_swap12 (hf : EigenFrame W v lam) (a b c : Γ) : cst v a b c = -cst v b a c := by
  unfold cst
  rw [show br (v a) (v b) = -br (v b) (v a) by simp only [br]; abel, ← neg_one_smul ℝ (br (v b) (v a)),
    inner2_smul_l]; ring

theorem cst_swap23 (hf : EigenFrame W v lam) (a b c : Γ) : cst v a b c = -cst v a c b := by
  unfold cst
  rw [adinv _ (hf.skew a) (hf.skew b), inner2_comm]

/-- **`‖[v_x, v_a]‖² = Σ_b c_{xab}²`.** -/
theorem brnorm_frame (hf : EigenFrame W v lam) (x a : Γ) :
    inner2 (br (v x) (v a)) (br (v x) (v a)) = ∑ b, cst v x a b ^ 2 := by
  have h := hf.complete _ (br_skew (hf.skew x) (hf.skew a))
  conv_lhs => rw [h]
  exact frame_sq hf _

/-- **The Killing row in the frame**: `Σ_{ab} c_{xab}² = 2(n-2)`. -/
theorem killing_frame (hW : IsWeyl W) (hf : EigenFrame W v lam) (x : Γ) :
    ∑ a, ∑ b, cst v x a b ^ 2 = 2 * ((Fintype.card ι : ℝ) - 2) := by
  simp only [← brnorm_frame hf x]
  have hlin : ∀ c : Γ → ℝ, (fun X => br (v x) X) (∑ α, c α • v α) = ∑ α, c α • (fun X => br (v x) X) (v α) :=
    fun c => br_sum_r _ _ _ _
  rw [← innerOp_frame hf (fun X => br (v x) X) (fun X => br (v x) X) hlin hlin]
  unfold innerOp
  rw [killing_phi _ (hf.skew x), hf.orthonormal, if_pos rfl]; ring

/-- **`A(W) = 2W` in the frame**: `Σ_{ab} λ_b c_{xab}² = -2 λ_x`. -/
theorem aW2_frame (hW : IsWeyl W) (hf : EigenFrame W v lam) (x : Γ) :
    ∑ a, ∑ b, lam b * cst v x a b ^ 2 = -2 * lam x := by
  have h := aW2 hW (v x) (hf.skew x)
  rw [hf.eigen x, inner2_smul_l, hf.orthonormal, if_pos rfl, mul_one] at h
  have hlin1 : ∀ c : Γ → ℝ, (fun X => W (br (v x) X)) (∑ α, c α • v α)
      = ∑ α, c α • (fun X => W (br (v x) X)) (v α) := fun c => by
    simp only; rw [br_sum_r, weyl_lin hW _ c _ fun α => br_skew (hf.skew x) (hf.skew α)]
  have hlin2 : ∀ c : Γ → ℝ, (fun X => br (v x) X) (∑ α, c α • v α) = ∑ α, c α • (fun X => br (v x) X) (v α) :=
    fun c => br_sum_r _ _ _ _
  have e : (1 / 2) * ∑ i, ∑ j, inner2 (W (br (v x) (phi i j))) (br (v x) (phi i j))
      = innerOp (fun X => W (br (v x) X)) (fun X => br (v x) X) := rfl
  rw [e, innerOp_frame hf _ _ hlin1 hlin2] at h
  rw [← h]
  refine Finset.sum_congr rfl fun a _ => ?_
  have hexp := hf.complete _ (br_skew (hf.skew x) (hf.skew a))
  conv_rhs => rw [hexp]
  rw [weyl_lin hW _ _ v hf.skew]
  simp only [hf.eigen, smul_smul, inner2_sum_l, inner2_sum_r, inner2_smul_l, inner2_smul_r, hf.orthonormal,
    mul_ite, mul_one, mul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  exact Finset.sum_congr rfl fun b _ => by unfold cst; ring

end Assembly

section Final
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}

theorem T12 (hf : EigenFrame W v lam) (a b c : Γ) : cst v a b c ^ 2 = cst v b a c ^ 2 := by
  rw [cst_swap12 hf]; ring
theorem T23 (hf : EigenFrame W v lam) (a b c : Γ) : cst v a b c ^ 2 = cst v a c b ^ 2 := by
  rw [cst_swap23 hf]; ring

/-- A factor on the middle index moves out through the `12` symmetry. -/
theorem HA (hf : EigenFrame W v lam) (g f : Γ → ℝ) :
    ∑ γ, ∑ α, ∑ β, g γ * f α * cst v γ α β ^ 2 = ∑ α, f α * ∑ γ, ∑ β, g γ * cst v α γ β ^ 2 := by
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun α _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [Finset.mul_sum]
  exact Finset.sum_congr rfl fun β _ => by rw [T12 hf]; ring

/-- A factor on the last index equals one on the middle, by the `23` symmetry. -/
theorem HB (hf : EigenFrame W v lam) (g f : Γ → ℝ) :
    ∑ γ, ∑ α, ∑ β, g γ * f β * cst v γ α β ^ 2 = ∑ γ, ∑ α, ∑ β, g γ * f α * cst v γ α β ^ 2 := by
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun β _ => Finset.sum_congr rfl fun α _ => by rw [T23 hf]

/-- `A(W) = 2W` with the weight on the middle index. -/
theorem aW2_mid (hW : IsWeyl W) (hf : EigenFrame W v lam) (x : Γ) :
    ∑ γ, ∑ β, lam γ * cst v x γ β ^ 2 = -2 * lam x := by
  rw [← aW2_frame hW hf x, Finset.sum_comm]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by rw [T23 hf]

theorem normSq_frame (hW : IsWeyl W) (hf : EigenFrame W v lam) : normSq W = ∑ γ, lam γ ^ 2 := by
  unfold normSq
  rw [innerOp_frame hf W W (fun c => weyl_lin hW _ c v hf.skew) (fun c => weyl_lin hW _ c v hf.skew)]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [hf.eigen γ, inner2_smul_l, inner2_smul_r, hf.orthonormal, if_pos rfl]; ring

theorem trCube_frame (hW : IsWeyl W) (hf : EigenFrame W v lam) : trCube W = ∑ γ, lam γ ^ 3 := by
  unfold trCube compOp
  have hl : ∀ c : Γ → ℝ, (fun X => W (W X)) (∑ α, c α • v α) = ∑ α, c α • (fun X => W (W X)) (v α) :=
    fun c => by
      simp only
      rw [weyl_lin hW _ c v hf.skew, weyl_lin hW _ c (fun α => W (v α)) fun α => hW.1 _ (hf.skew α)]
  rw [innerOp_frame hf _ W hl (fun c => weyl_lin hW _ c v hf.skew)]
  refine Finset.sum_congr rfl fun γ _ => ?_
  have h2 : W (lam γ • v γ) = lam γ • W (v γ) := by
    have := weyl_lin hW (Finset.univ : Finset (Fin 1)) (fun _ => lam γ) (fun _ => v γ) (fun _ => hf.skew γ)
    simpa using this
  rw [hf.eigen γ, h2, hf.eigen γ, inner2_smul_l, inner2_smul_l, inner2_smul_r, hf.orthonormal, if_pos rfl]; ring

theorem sharpPair_T (hW : IsWeyl W) (hf : EigenFrame W v lam) :
    sharpPair W = (1 / 2) * ∑ γ, ∑ α, ∑ β, lam γ * lam α * lam β * cst v γ α β ^ 2 := by
  rw [sharpPair_frame hW hf, Finset.mul_sum]
  refine Finset.sum_congr rfl fun γ _ => ?_
  rw [sharpQF_frame hW hf _ (hf.skew γ), Finset.mul_sum, Finset.mul_sum, Finset.mul_sum]
  refine Finset.sum_congr rfl fun α _ => ?_
  simp only [Finset.mul_sum]
  exact Finset.sum_congr rfl fun β _ => by unfold cst; ring

theorem first_identity (hW : IsWeyl W) (hf : EigenFrame W v lam) :
    ∑ γ, gMass W (v γ) = 4 * ((Fintype.card ι : ℝ) - 1) * normSq W := by
  simp only [pw17 hW hf]
  have pt : ∀ γ α β, (lam α - lam β) ^ 2 * inner2 (br (v γ) (v α)) (v β) ^ 2
      = (1 : ℝ) * lam α ^ 2 * cst v γ α β ^ 2 + (1 : ℝ) * lam β ^ 2 * cst v γ α β ^ 2
        - 2 * ((1 : ℝ) * lam α * (lam β * cst v γ α β ^ 2)) := fun γ α β => by unfold cst; ring
  simp only [pt, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  rw [HB hf (fun _ => 1) (fun β => lam β ^ 2), HA hf (fun _ => 1) (fun α => lam α ^ 2)]
  have e3 : ∑ γ, ∑ α, ∑ β, 2 * ((1 : ℝ) * lam α * (lam β * cst v γ α β ^ 2))
      = 2 * ∑ α, lam α * ∑ γ, ∑ β, lam β * cst v α γ β ^ 2 := by
    rw [Finset.mul_sum, Finset.sum_comm]
    refine Finset.sum_congr rfl fun α _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun γ _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum]
    exact Finset.sum_congr rfl fun β _ => by rw [T12 hf]; ring
  rw [e3]
  simp only [one_mul, killing_frame hW hf, aW2_frame hW hf, normSq_frame hW hf]
  simp only [← Finset.sum_mul, Finset.mul_sum]
  rw [show ∑ i, 2 * (lam i * (-2 * lam i)) = -4 * ∑ i, lam i ^ 2 by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun i _ => by ring,
    show ∑ i, 4 * ((Fintype.card ι : ℝ) - 1) * lam i ^ 2 = 4 * ((Fintype.card ι : ℝ) - 1) * ∑ i, lam i ^ 2 by
      rw [Finset.mul_sum]]
  ring

theorem second_identity (hW : IsWeyl W) (hf : EigenFrame W v lam) :
    ∑ γ, lam γ * gMass W (v γ) = -4 * Pcubic W := by
  simp only [pw17 hW hf, Finset.mul_sum]
  have pt : ∀ γ α β, lam γ * ((lam α - lam β) ^ 2 * inner2 (br (v γ) (v α)) (v β) ^ 2)
      = lam γ * lam α ^ 2 * cst v γ α β ^ 2 + lam γ * lam β ^ 2 * cst v γ α β ^ 2
        - 2 * (lam γ * lam α * lam β * cst v γ α β ^ 2) := fun γ α β => by unfold cst; ring
  simp only [pt, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  rw [HB hf lam (fun β => lam β ^ 2), HA hf lam (fun α => lam α ^ 2)]
  simp only [aW2_mid hW hf]
  unfold Pcubic
  rw [trCube_frame hW hf, sharpPair_T hW hf]
  have e : ∑ γ, ∑ α, ∑ β, 2 * (lam γ * lam α * lam β * cst v γ α β ^ 2)
      = 2 * ∑ γ, ∑ α, ∑ β, lam γ * lam α * lam β * cst v γ α β ^ 2 := by simp only [Finset.mul_sum]
  have e2 : ∑ α, lam α ^ 2 * (-2 * lam α) = -2 * ∑ γ, lam γ ^ 3 := by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun α _ => by ring
  rw [e, e2]
  ring

/-- **L41, both displays.** -/
theorem weighted (hW : IsWeyl W) (hf : EigenFrame W v lam) :
    (∑ γ, gMass W (v γ) = 4 * ((Fintype.card ι : ℝ) - 1) * normSq W) ∧
      (∑ γ, lam γ * gMass W (v γ) = -4 * Pcubic W) :=
  ⟨first_identity hW hf, second_identity hW hf⟩

end Final

end Frame

/-! ## The two identities -/

/-- **The lemma's two displays**, both on all of `𝒲ₙ` and neither needing criticality.

*Proved from `A(W) = 2W`, Petersen–Wink Proposition 1.7, the total symmetry of `T` and (for the first
display) this record's own L153, each proved in `Frame`.* -/
theorem weighted_identities (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsWeyl R)
    (v : Γ → Matrix ι ι ℝ) (lam : Γ → ℝ) (hf : EigenFrame R v lam) :
    (∑ γ, gMass R (v γ) = 4 * ((Fintype.card ι : ℝ) - 1) * normSq R) ∧
      (∑ γ, lam γ * gMass R (v γ) = -4 * Pcubic R) :=
  Frame.weighted hR hf

/-! ## The bound

*`Δ` is the `g`-mass on `{λ > 0}` and `G₀` the mass on `ker W`; the split into `{λ > 0}`,
`{λ < 0}`, `{λ = 0}` is exhaustive, which is what makes the negative mass `4(n-1) - Δ - G₀`.* -/

variable (lam g : Γ → ℝ) (lmin : ℝ)

omit [DecidableEq Γ] in
/-- **The exact slack**, which is the Gate 2 correction to the equality clause: the difference
between the bound's right-hand side and `-∑ λ_γ g_γ` is
`∑_{λ>0} λ_γ g_γ + ∑_{λ<0} (λ_γ - λ_min) g_γ`, **the kernel does not appear**, `G₀` having already
been subtracted.

*The record's "the split into `{λ>0}`, `{λ<0}`, `{λ=0}` being exhaustive" needs no hypothesis: it
is trichotomy, and the proof below establishes it.* -/
theorem exact_slack :
    (-lmin) * ((∑ γ, g γ) - (∑ γ ∈ univ.filter fun γ => 0 < lam γ, g γ)
        - (∑ γ ∈ univ.filter fun γ => lam γ = 0, g γ))
      - (-(∑ γ, lam γ * g γ))
    = (∑ γ ∈ univ.filter fun γ => 0 < lam γ, lam γ * g γ)
      + (∑ γ ∈ univ.filter fun γ => lam γ < 0, (lam γ - lmin) * g γ) := by
  classical
  have hsplit : ∀ f : Γ → ℝ,
      (∑ γ, f γ) = (∑ γ ∈ univ.filter fun γ => 0 < lam γ, f γ)
        + (∑ γ ∈ univ.filter fun γ => lam γ < 0, f γ)
        + (∑ γ ∈ univ.filter fun γ => lam γ = 0, f γ) := by
    intro f
    have e1 := Finset.sum_filter_add_sum_filter_not univ (fun γ => 0 < lam γ) f
    have e2 := Finset.sum_filter_add_sum_filter_not (univ.filter fun γ => ¬ 0 < lam γ)
      (fun γ => lam γ < 0) f
    rw [Finset.filter_filter, Finset.filter_filter] at e2
    have c1 : (univ.filter fun γ => ¬ 0 < lam γ ∧ lam γ < 0)
        = univ.filter fun γ => lam γ < 0 := by
      ext γ; simp only [mem_filter, mem_univ, true_and]
      exact ⟨fun h => h.2, fun h => ⟨by linarith, h⟩⟩
    have c2 : (univ.filter fun γ => ¬ 0 < lam γ ∧ ¬ lam γ < 0)
        = univ.filter fun γ => lam γ = 0 := by
      ext γ; simp only [mem_filter, mem_univ, true_and]
      exact ⟨fun h => le_antisymm (not_lt.mp h.1) (not_lt.mp h.2),
        fun h => ⟨by rw [h]; norm_num, by rw [h]; norm_num⟩⟩
    rw [c1, c2] at e2
    linarith
  have hg := hsplit g
  have hlg := hsplit fun γ => lam γ * g γ
  have hzero : (∑ γ ∈ univ.filter fun γ => lam γ = 0, lam γ * g γ) = 0 := by
    refine sum_eq_zero fun γ hγ => ?_
    simp only [mem_filter] at hγ
    rw [hγ.2, zero_mul]
  have hneg : (∑ γ ∈ univ.filter fun γ => lam γ < 0, (lam γ - lmin) * g γ)
      = (∑ γ ∈ univ.filter fun γ => lam γ < 0, lam γ * g γ)
        - lmin * (∑ γ ∈ univ.filter fun γ => lam γ < 0, g γ) := by
    rw [mul_sum, ← sum_sub_distrib]
    exact sum_congr rfl fun γ _ => by ring
  rw [hneg, hg]
  rw [show (∑ γ, lam γ * g γ) = _ from hlg, hzero]
  ring

omit [DecidableEq Γ] in
/-- **The record's bound, at unit norm.** With `G = 4(n-1)‖W‖²` the total `g`-mass, the first
display, at `‖W‖ = 1`, and `Δ`, `G₀` the masses on `{λ > 0}` and `ker W`, the second display gives
`θ ≤ |λ_min| (G - Δ - G₀)/4`.

*The hypotheses are the ones the record's proof uses: `g ≥ 0`, `λ_min ≤ λ_γ` for every `γ`, and
`λ_min ≤ 0`.* -/
theorem lambdaMin_bound (θ G : ℝ)
    (hgnn : ∀ γ, 0 ≤ g γ) (hmin : ∀ γ, lmin ≤ lam γ) (hminle : lmin ≤ 0)
    (htot : (∑ γ, g γ) = G)
    (hweight : (∑ γ, lam γ * g γ) = -4 * θ) :
    θ ≤ |lmin| * ((G - (∑ γ ∈ univ.filter fun γ => 0 < lam γ, g γ)
        - (∑ γ ∈ univ.filter fun γ => lam γ = 0, g γ)) / 4) := by
  classical
  rw [abs_of_nonpos hminle]
  have hslack := exact_slack lam g lmin
  rw [htot] at hslack
  have h1 : 0 ≤ (∑ γ ∈ univ.filter fun γ => 0 < lam γ, lam γ * g γ) := by
    refine sum_nonneg fun γ hγ => ?_
    simp only [mem_filter] at hγ
    exact mul_nonneg hγ.2.le (hgnn γ)
  have h2 : 0 ≤ (∑ γ ∈ univ.filter fun γ => lam γ < 0, (lam γ - lmin) * g γ) := by
    refine sum_nonneg fun γ _ => ?_
    exact mul_nonneg (by linarith [hmin γ]) (hgnn γ)
  rw [hweight] at hslack
  linarith

omit [DecidableEq Γ] in
/-- **The corrected equality class.** The slack of `lambdaMin_bound` vanishes exactly when `g` is
supported on `E_{λ_min} ⊕ ker W`, every `γ` with `g γ > 0` has `λ_γ = λ_min` or `λ_γ = 0`. *The
record's original clause said `E_{λ_min}` alone and fails the "only if" half, `G₀` having already
been subtracted.* -/
theorem equality_class (hgnn : ∀ γ, 0 ≤ g γ) (hmin : ∀ γ, lmin ≤ lam γ) (hminlt : lmin < 0)
    (hpart : ∀ γ, 0 < lam γ ∨ lam γ < 0 ∨ lam γ = 0) :
    ((∑ γ ∈ univ.filter fun γ => 0 < lam γ, lam γ * g γ)
        + (∑ γ ∈ univ.filter fun γ => lam γ < 0, (lam γ - lmin) * g γ) = 0)
    ↔ ∀ γ, 0 < g γ → lam γ = lmin ∨ lam γ = 0 := by
  classical
  constructor
  · intro h γ hgγ
    have h1 : ∀ δ ∈ univ.filter fun δ => 0 < lam δ, 0 ≤ lam δ * g δ := by
      intro δ hδ; simp only [mem_filter] at hδ; exact mul_nonneg hδ.2.le (hgnn δ)
    have h2 : ∀ δ ∈ univ.filter fun δ => lam δ < 0, 0 ≤ (lam δ - lmin) * g δ := by
      intro δ _; exact mul_nonneg (by linarith [hmin δ]) (hgnn δ)
    have s1 : (∑ δ ∈ univ.filter fun δ => 0 < lam δ, lam δ * g δ) = 0 := by
      have := sum_nonneg h1; have := sum_nonneg h2; linarith
    have s2 : (∑ δ ∈ univ.filter fun δ => lam δ < 0, (lam δ - lmin) * g δ) = 0 := by
      have := sum_nonneg h1; have := sum_nonneg h2; linarith
    rcases hpart γ with hp | hn | hz
    · exfalso
      have hmem : γ ∈ univ.filter fun δ => 0 < lam δ := by simp [hp]
      have := (sum_eq_zero_iff_of_nonneg h1).mp s1 γ hmem
      nlinarith
    · left
      have hmem : γ ∈ univ.filter fun δ => lam δ < 0 := by simp [hn]
      have := (sum_eq_zero_iff_of_nonneg h2).mp s2 γ hmem
      have : lam γ - lmin = 0 := by
        rcases mul_eq_zero.mp this with h' | h'
        · exact h'
        · exact absurd h' (ne_of_gt hgγ)
      linarith
    · right; exact hz
  · intro h
    have s1 : (∑ δ ∈ univ.filter fun δ => 0 < lam δ, lam δ * g δ) = 0 := by
      refine sum_eq_zero fun δ hδ => ?_
      simp only [mem_filter] at hδ
      rcases lt_or_eq_of_le (hgnn δ) with hg' | hg'
      · rcases h δ hg' with h' | h' <;> rw [h'] at hδ <;> linarith [hδ.2]
      · rw [← hg']; ring
    have s2 : (∑ δ ∈ univ.filter fun δ => lam δ < 0, (lam δ - lmin) * g δ) = 0 := by
      refine sum_eq_zero fun δ hδ => ?_
      simp only [mem_filter] at hδ
      rcases lt_or_eq_of_le (hgnn δ) with hg' | hg'
      · rcases h δ hg' with h' | h'
        · rw [h']; ring
        · rw [h'] at hδ; linarith [hδ.2]
      · rw [← hg']; ring
    rw [s1, s2]; ring

/-! ## Non-vacuity -/

/-- **A witness for the bound's hypotheses**, so `lambdaMin_bound` is not vacuous: two indices,
one at `λ = -1` carrying all the mass, one at `λ = 1` carrying none. -/
example : ∃ (lam g : Bool → ℝ) (lmin : ℝ), (∀ γ, 0 ≤ g γ) ∧ (∀ γ, lmin ≤ lam γ) ∧ lmin ≤ 0 ∧
    (∀ γ, 0 < lam γ ∨ lam γ < 0 ∨ lam γ = 0) := by
  refine ⟨fun b => if b then 1 else -1, fun b => if b then 0 else 4, -1, ?_, ?_, by norm_num, ?_⟩
  · intro γ; cases γ <;> norm_num
  · intro γ; cases γ <;> norm_num
  · intro γ; cases γ <;> norm_num

end

end HamiltonsCubic.L41Statement
