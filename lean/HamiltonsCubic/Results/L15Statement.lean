import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Base.AltPart
import HamiltonsCubic.Results.L41Statement

/-!
# L15, the Bianchi defect of the spectral parts, priced exactly, STATED

[problem.md](../../../findings/problem.md)'s Observation L15, quoted verbatim from
[results.md](../../../results.md)'s canonical statement:

> **The identity.** For **every symmetric `R` on `Λ²ℝⁿ`**, not merely for curvature operators,
> at which `Alt(R) = 0` and the statement is empty,
>
> `scal(R² + R#) = ‖Ric(R)‖² + 6‖Alt(R)‖²,`
>
> with `Alt` the orthogonal projection onto `Λ⁴`, **the constant exactly `6` at every `n` and no
> cross-term**. It is non-vacuous from `n = 4`, `Λ⁴` being trivial below. **The constant is fixed
> by four normalisations** […]: under `scal = tr` both right-hand constants halve, under plain
> Frobenius on `Λ²` the `6` becomes `4`, under the unnormalised Bianchi map it becomes `2/3`, and
> **under the other `#` normalisation in circulation the identity is false rather than rescaled**
>, `n(n-1)(2n-3)` against `n(n-1)²` at `R = I`.
>
> **What it prices.** […] `|W|` and `W_±` need not satisfy the first Bianchi identity […] and
> where they fail, the identity prices the failure exactly: the master inequality carries a
> further `+24‖Alt(W_-)‖²`, the `24` being `6·4` via `Alt(|W|) = 2Alt(W_-)`. At Fox's `S⁴(α)`
> the uncorrected inequality fails by a factor of **exactly three**,
> `θ scal(|W|) = 4` against `4/3`, and the corrected form is saturated; all four quantities are
> padding-invariant, so this holds at **every `n ≥ 4`**.

**What [L15.lean](L15.lean) already carries and this file does not repeat**: that polarisation is
a rewriting, and the count of obstructions. **What that file never states is the identity.** The
identity is typed here.

## How it is proved

By contraction in the orthonormal frame `{φ_ij}`, with `m_klpq = (R φ_kl)_pq` carrying every
quantity. The three symmetries of `m` (antisymmetry in each pair, from linearity and `hskew`, and
the pair exchange, from `IsSymmetricOp`) are the whole input.

* `Proof.sharpQF_phi` writes `⟨R#φ_ij, φ_ij⟩` as a four-fold sum of products of brackets, and
  `Proof.twoSharp` collapses the double sum over `i, j` to sixteen terms, each a relabelling of
  `‖Ric‖²` or of the cross contraction `X = Σ m_ijkl m_iklj`, so `2 tr(R#) = ‖Ric‖² + X`.
* `Proof.alt_eq` expands `6‖Alt‖²` into its three squares and three cross terms, each a pure
  relabelling, giving `½ Σ m² + X`.
* `Proof.normSq_eq` is Parseval: `‖R‖² = ¼ Σ m²`.

The two `X` cancel and the identity follows. The record's route through
[Lemma L131](../../../findings/isotropy-cap.md) and the `Λ⁴` summand of `Sym²(Λ²)` is replaced by
this direct count.

## The four normalisations, as they appear in the definitions

Each is a choice the constant `6` depends on, and each is made explicitly:

* **`scal = 2 tr`.** `scalOp` below is `2 * traceOp`. *Under `scal = tr` both right-hand
  constants halve.*
* **`⟨X,Y⟩ = ½ tr(Xᵀ Y)` on `Λ²`**, inherited from
  [WeylReal.lean](../Base/WeylReal.lean)'s `inner2`, which makes `{φ_ij}_{i<j}` orthonormal.
  *Under plain Frobenius the `6` becomes `4`.*
* **The normalised Bianchi map**, `Alt(R)_{ijkl} = ⅓(R_{ijkl} + R_{iklj} + R_{iljk})`. *Under
  the unnormalised map the `6` becomes `2/3`*, the ratio `9 = 3²`, which is what fixes the `⅓`.
* **The `#` of [WeylReal.lean](../Base/WeylReal.lean)**, anchored by `I# = (n-2)I`. *Under the
  other `#` in circulation the identity is false rather than rescaled.*

`identity_at_identity_operator` below is the record's own `R = I` check under these choices, and
it is the one place the normalisations can be seen to cohere: both sides read `n(n-1)²`.

## Two hypotheses the record leaves implicit

**`R` is linear and symmetric.** *"Symmetric `R` on `Λ²ℝⁿ`"* is the whole hypothesis and there is
no Bianchi clause, that is the point of the observation, `Alt(R)` being the term that measures
its failure, but a `Matrix ι ι ℝ → Matrix ι ι ℝ` is a bare function here, so linearity is
carried explicitly. Without it the statement is false.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L15Statement

open HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The operators the identity is built from -/

/-- `R` is a linear map on bivectors. *A bare function is not, and the identity is false without
this.* -/
def IsLinearOp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  (∀ X Y, R (X + Y) = R X + R Y) ∧ (∀ (a : ℝ) X, R (a • X) = a • R X)

/-- `R` is symmetric on `Λ²`: `⟨R X, Y⟩ = ⟨X, R Y⟩` for bivectors `X`, `Y`. **This is the whole
hypothesis of the identity**, no Bianchi clause, which is what makes `Alt(R)` non-zero and the
statement non-empty. -/
def IsSymmetricOp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)

/-- The trace of an operator on `Λ²`, in the orthonormal basis `{φ_ij}_{i<j}`; the `½` pays for
the ordered-pair double count. -/
noncomputable def traceOp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  (1 / 2) * ∑ i : ι, ∑ j : ι, inner2 (R (phi i j)) (phi i j)

/-- **`scal(A) = 2 tr(A)`**, the first of the four normalisations. -/
noncomputable def scalOp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ := 2 * traceOp R

/-- `tr(R#)`, read off the quadratic form `⟨R# η, η⟩` on the same orthonormal basis. -/
noncomputable def sharpTrace (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  (1 / 2) * ∑ i : ι, ∑ j : ι, sharpQF R (phi i j)

/-- **`scal(R² + R#)`**, the identity's left-hand side. *`tr(R²) = ‖R‖²` for symmetric `R`, which
is why `normSq` appears where `tr(R²)` is written.* -/
noncomputable def scalQ (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  2 * (normSq R + sharpTrace R)

/-- **`‖Ric(R)‖²`.** -/
noncomputable def ricNormSq (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  ∑ a : ι, ∑ b : ι, Ric R a b ^ 2

/-! ### `Alt` and its norm are [AltPart.lean](../Base/AltPart.lean)'s, not this file's

**THIS FILE CARRIED ITS OWN `altCoeff` AND `altNormSq` AND THEY ARE GONE.** *They were
character-for-character the base layer's, reached by a different route:* `altCoeff` here was
`⅓ · bianchi R` and there is `alt4 (comp R)`, equal because
[bianchi_eq_comp](../Base/AltPart.lean) says `bianchi` is the undivided cyclic sum of `comp`, and
both `altNormSq` carry the same `¼` because `fourInner` carries it.

**The `⅓` is the third normalisation**, without which the identity's constant is `2/3` rather than
`6`, and **the `¼` pays for the two ordered-pair double counts**. *Both now have ONE home, so the
constant `6` below cannot drift against a second copy nobody edits.*
-/

/-! ## The proof's contraction lemmas -/

namespace Proof

theorem lin_sum {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hlin : IsLinearOp R) {κ : Type*} (s : Finset κ)
    (c : κ → ℝ) (x : κ → Matrix ι ι ℝ) : R (∑ k ∈ s, c k • x k) = ∑ k ∈ s, c k • R (x k) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    simp only [Finset.sum_empty]
    have := hlin.2 0 0; simpa using this
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, hlin.1, hlin.2, ih]

theorem brphi_l (Y : Matrix ι ι ℝ) (i j p q : ι) :
    br (phi i j) Y p q = (if j = p then Y i q else 0) - (if i = p then Y j q else 0)
      - (if i = q then Y p j else 0) + (if j = q then Y p i else 0) := by
  simp [br, phi, Matrix.mul_apply, Matrix.single_apply, ite_and, Matrix.sub_apply, mul_sub, sub_mul,
    mul_ite, ite_mul, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq']
  ring

theorem br_sum_any {κ : Type*} (s : Finset κ) (u : Matrix ι ι ℝ) (f : κ → Matrix ι ι ℝ) :
    br u (∑ k ∈ s, f k) = ∑ k ∈ s, br u (f k) := by
  simp only [br, Matrix.mul_sum, Matrix.sum_mul, ← Finset.sum_sub_distrib]

/-- **`sharpQF` at a basis bivector, in the entries of the `M_kl = R φ_kl`.** -/
theorem sharpQF_phi {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hlin : IsLinearOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X)) (i j : ι) :
    sharpQF R (phi i j) = -(1 / 8) * ∑ k, ∑ l, ∑ a, ∑ b,
      br (phi i j) (R (phi k l)) a b * br (phi i j) (R (phi a b)) k l := by
  unfold sharpQF
  have hM : ∀ k l, IsSkew (R (phi k l)) := fun k l => hskew _ (phi_isSkew k l)
  have hZ : ∀ k l, IsSkew (br (phi i j) (R (phi k l))) := fun k l =>
    HamiltonsCubic.L41Statement.Frame.br_skew (phi_isSkew i j) (hM k l)
  have hRZ : ∀ k l, R (br (phi i j) (R (phi k l)))
      = ∑ a, ∑ b, ((1 / 2) * inner2 (br (phi i j) (R (phi k l))) (phi a b)) • R (phi a b) := by
    intro k l
    conv_lhs => rw [HamiltonsCubic.L41Statement.Frame.phi_expand _ (hZ k l)]
    have e1 : ∑ a, ∑ b, ((1 / 2) * inner2 (br (phi i j) (R (phi k l))) (phi a b)) • phi a b
        = ∑ p ∈ (Finset.univ ×ˢ Finset.univ : Finset (ι × ι)),
          ((1 / 2) * inner2 (br (phi i j) (R (phi k l))) (phi p.1 p.2)) • phi p.1 p.2 :=
      (Finset.sum_product' _ _ _).symm
    rw [e1, lin_sum hlin, Finset.sum_product'
      (f := fun a b => ((1 / 2) * inner2 (br (phi i j) (R (phi k l))) (phi a b)) • R (phi a b))]
  have hin : ∀ k l, inner2 (br (phi i j) (R (br (phi i j) (R (phi k l))))) (phi k l)
      = ∑ a, ∑ b, ((1 / 2) * br (phi i j) (R (phi k l)) a b) * br (phi i j) (R (phi a b)) k l := by
    intro k l
    rw [hRZ, br_sum_any, HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [br_sum_any, HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [HamiltonsCubic.L41Statement.Frame.br_smul_r, HamiltonsCubic.L41Statement.Frame.inner2_smul_l,
      HamiltonsCubic.RealLayer.inner2_phi _ (hZ k l) a b,
      HamiltonsCubic.RealLayer.inner2_phi _ (hZ a b) k l]
    ring
  simp only [hin, Finset.mul_sum]
  exact Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => Finset.sum_congr rfl fun a _ =>
    Finset.sum_congr rfl fun b _ => by ring


section Sym
variable {R : Matrix ι ι ℝ → Matrix ι ι ℝ}

theorem sA (hlin : IsLinearOp R) (_hsym : IsSymmetricOp R) (_hskew : ∀ X, IsSkew X → IsSkew (R X))
    (k l p q : ι) : R (phi l k) p q = - R (phi k l) p q := by
  rw [HamiltonsCubic.RealLayer.phi_swap k l, show -phi k l = (-1 : ℝ) • phi k l by simp, hlin.2]
  simp

theorem sB (_hlin : IsLinearOp R) (_hsym : IsSymmetricOp R) (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (k l p q : ι) : R (phi k l) q p = - R (phi k l) p q := by
  have := congrFun (congrFun (hskew _ (HamiltonsCubic.RealLayer.phi_isSkew k l)) p) q
  simpa [Matrix.transpose_apply] using this

theorem sP (_hlin : IsLinearOp R) (hsym : IsSymmetricOp R) (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (k l p q : ι) : R (phi p q) k l = R (phi k l) p q := by
  have h := hsym (phi k l) (phi p q) (HamiltonsCubic.RealLayer.phi_isSkew k l)
    (HamiltonsCubic.RealLayer.phi_isSkew p q)
  have hc : ∀ X Y : Matrix ι ι ℝ, inner2 X Y = inner2 Y X := fun X Y => by
    unfold inner2
    rw [← Matrix.trace_transpose (Xᵀ * Y)]
    simp [Matrix.transpose_mul]
  rw [hc (phi k l), HamiltonsCubic.RealLayer.inner2_phi _ (hskew _ (HamiltonsCubic.RealLayer.phi_isSkew k l)),
    HamiltonsCubic.RealLayer.inner2_phi _ (hskew _ (HamiltonsCubic.RealLayer.phi_isSkew p q))] at h
  linarith

theorem sAB (hlin : IsLinearOp R) (hsym : IsSymmetricOp R) (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (k l p q : ι) : R (phi l k) q p = R (phi k l) p q := by
  rw [sA hlin hsym hskew k l q p, sB hlin hsym hskew k l p q, neg_neg]

theorem sPA (hlin : IsLinearOp R) (hsym : IsSymmetricOp R) (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (k l p q : ι) : R (phi p q) l k = - R (phi k l) p q := by
  rw [sP hlin hsym hskew l k p q, sA hlin hsym hskew k l p q]

theorem sPB (hlin : IsLinearOp R) (hsym : IsSymmetricOp R) (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (k l p q : ι) : R (phi q p) k l = - R (phi k l) p q := by
  rw [sP hlin hsym hskew k l q p, sB hlin hsym hskew k l p q]

theorem sPAB (hlin : IsLinearOp R) (hsym : IsSymmetricOp R) (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (k l p q : ι) : R (phi q p) l k = R (phi k l) p q := by
  rw [sP hlin hsym hskew l k q p, sAB hlin hsym hskew k l p q]

end Sym

theorem reindex (f g : ι → ι → ι → ι → ℝ) (c : ℝ) (σ : ι × ι × ι × ι ≃ ι × ι × ι × ι)
    (h : ∀ a b c' d, f a b c' d
      = c * g (σ (a, b, c', d)).1 (σ (a, b, c', d)).2.1 (σ (a, b, c', d)).2.2.1 (σ (a, b, c', d)).2.2.2) :
    ∑ a, ∑ b, ∑ c', ∑ d, f a b c' d = c * ∑ a, ∑ b, ∑ c', ∑ d, g a b c' d := by
  have e : ∀ F : ι → ι → ι → ι → ℝ,
      ∑ a, ∑ b, ∑ c', ∑ d, F a b c' d = ∑ p : ι × ι × ι × ι, F p.1 p.2.1 p.2.2.1 p.2.2.2 := by
    intro F; simp only [Fintype.sum_prod_type]
  rw [e f, e g, Finset.mul_sum]
  exact Fintype.sum_equiv σ _ _ fun ⟨a, b, c', d⟩ => h a b c' d

/-- The cross contraction `Σ m_ijkl m_iklj`, with `m_klpq = (R φ_kl)_pq`. -/
noncomputable def XX (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  ∑ i, ∑ j, ∑ k, ∑ l, R (phi i j) k l * R (phi i k) l j

/-- `‖Ric‖²` written out in the `m`. -/
noncomputable def RR (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  ∑ a, ∑ b, ∑ c, ∑ d, R (phi a c) b c * R (phi a d) b d

theorem RR_eq {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hskew : ∀ X, IsSkew X → IsSkew (R X)) :
    RR R = ricNormSq R := by
  unfold RR ricNormSq Ric
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  have hc : ∀ c, inner2 (R (phi a c)) (phi b c) = -R (phi a c) b c := fun c =>
    HamiltonsCubic.RealLayer.inner2_phi _ (hskew _ (HamiltonsCubic.RealLayer.phi_isSkew a c)) b c
  simp only [hc, Finset.sum_neg_distrib, sq, neg_mul_neg, Finset.sum_mul_sum]

theorem twoSharp {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hlin : IsLinearOp R) (hsym : IsSymmetricOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X)) :
    ∑ i, ∑ j, sharpQF R (phi i j) = RR R + XX R := by
  simp only [sharpQF_phi hlin hskew, brphi_l]
  simp only [mul_sub, sub_mul, add_mul, mul_add, ite_mul, mul_ite, zero_mul, mul_zero,
    Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.mul_sum, Finset.sum_ite_eq, Finset.sum_ite_eq',
    Finset.mem_univ, if_true, Finset.sum_ite_irrel, Finset.sum_const_zero]
  have h0 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_1 x_2) x i * R (phi x_1 i) x x_2) = (1/8 : ℝ) * XX R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_1 x_2) x i * R (phi x_1 i) x x_2)) (fun i j k l => R (phi i j) k l * R (phi i k) l j) _
      ⟨fun p => (p.2.2.1, p.2.1, p.1, p.2.2.2), fun p => (p.2.2.1, p.2.1, p.1, p.2.2.2), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_1 x_2) x i * R (phi x_1 i) x x_2) = (1/8 : ℝ) * (R (phi x_2 x_1) x i * R (phi x_2 x) i x_1)
        linear_combination (-(1/8):ℝ) * ((R (phi x_1 i) x x_2) * (sA hlin hsym hskew x_2 x_1 x i) + (-1:ℝ) * (R (phi x_2 x_1) x i) * (sPAB hlin hsym hskew x_2 x i x_1)))
  have h1 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_1 x_2) x_1 i * R (phi x i) x x_2) = (-1/8 : ℝ) * RR R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_1 x_2) x_1 i * R (phi x i) x x_2)) (fun a b c d => R (phi a c) b c * R (phi a d) b d) _
      ⟨fun p => (p.2.2.1, p.2.2.2, p.2.1, p.1), fun p => (p.2.2.2, p.2.2.1, p.1, p.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_1 x_2) x_1 i * R (phi x i) x x_2) = (-1/8 : ℝ) * (R (phi x_2 x_1) i x_1 * R (phi x_2 x) i x)
        linear_combination (-(1/8):ℝ) * ((R (phi x i) x x_2) * (sAB hlin hsym hskew x_2 x_1 i x_1) + (1:ℝ) * (R (phi x_2 x_1) i x_1) * (sPAB hlin hsym hskew x_2 x i x)))
  have h2 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_1 x_2) i x_1 * R (phi i x) x x_2) = (-1/8 : ℝ) * RR R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_1 x_2) i x_1 * R (phi i x) x x_2)) (fun a b c d => R (phi a c) b c * R (phi a d) b d) _
      ⟨fun p => (p.2.2.1, p.2.2.2, p.2.1, p.1), fun p => (p.2.2.2, p.2.2.1, p.1, p.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_1 x_2) i x_1 * R (phi i x) x x_2) = (-1/8 : ℝ) * (R (phi x_2 x_1) i x_1 * R (phi x_2 x) i x)
        linear_combination (-(1/8):ℝ) * ((R (phi i x) x x_2) * (sA hlin hsym hskew x_2 x_1 i x_1) + (-1:ℝ) * (R (phi x_2 x_1) i x_1) * (sPA hlin hsym hskew x_2 x i x)))
  have h3 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_1 x_2) i x * R (phi i x_1) x x_2) = (1/8 : ℝ) * XX R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_1 x_2) i x * R (phi i x_1) x x_2)) (fun i j k l => R (phi i j) k l * R (phi i k) l j) _
      ⟨fun p => (p.2.1, p.2.2.1, p.2.2.2, p.1), fun p => (p.2.2.2, p.1, p.2.1, p.2.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_1 x_2) i x * R (phi i x_1) x x_2) = (1/8 : ℝ) * (R (phi x_1 x_2) i x * R (phi x_1 i) x x_2)
        linear_combination (-(1/8):ℝ) * ((1:ℝ) * (R (phi x_1 x_2) i x) * (sA hlin hsym hskew x_1 i x x_2)))
  have h4 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x x_2) x i * R (phi x_1 i) x_1 x_2) = (-1/8 : ℝ) * RR R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x x_2) x i * R (phi x_1 i) x_1 x_2)) (fun a b c d => R (phi a c) b c * R (phi a d) b d) _
      ⟨fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1), fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x x_2) x i * R (phi x_1 i) x_1 x_2) = (-1/8 : ℝ) * (R (phi x_2 x) i x * R (phi x_2 x_1) i x_1)
        linear_combination (-(1/8):ℝ) * ((R (phi x_1 i) x_1 x_2) * (sAB hlin hsym hskew x_2 x i x) + (1:ℝ) * (R (phi x_2 x) i x) * (sPAB hlin hsym hskew x_2 x_1 i x_1)))
  have h5 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x x_2) x_1 i * R (phi x i) x_1 x_2) = (1/8 : ℝ) * XX R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x x_2) x_1 i * R (phi x i) x_1 x_2)) (fun i j k l => R (phi i j) k l * R (phi i k) l j) _
      ⟨fun p => (p.2.2.1, p.1, p.2.1, p.2.2.2), fun p => (p.2.1, p.2.2.1, p.1, p.2.2.2), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x x_2) x_1 i * R (phi x i) x_1 x_2) = (1/8 : ℝ) * (R (phi x_2 x) x_1 i * R (phi x_2 x_1) i x)
        linear_combination (-(1/8):ℝ) * ((R (phi x i) x_1 x_2) * (sA hlin hsym hskew x_2 x x_1 i) + (-1:ℝ) * (R (phi x_2 x) x_1 i) * (sPAB hlin hsym hskew x_2 x_1 i x)))
  have h6 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x x_2) i x_1 * R (phi i x) x_1 x_2) = (1/8 : ℝ) * XX R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x x_2) i x_1 * R (phi i x) x_1 x_2)) (fun i j k l => R (phi i j) k l * R (phi i k) l j) _
      ⟨fun p => (p.1, p.2.2.1, p.2.2.2, p.2.1), fun p => (p.1, p.2.2.2, p.2.1, p.2.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x x_2) i x_1 * R (phi i x) x_1 x_2) = (1/8 : ℝ) * (R (phi x x_2) i x_1 * R (phi x i) x_1 x_2)
        linear_combination (-(1/8):ℝ) * ((1:ℝ) * (R (phi x x_2) i x_1) * (sA hlin hsym hskew x i x_1 x_2)))
  have h7 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x x_2) i x * R (phi i x_1) x_1 x_2) = (-1/8 : ℝ) * RR R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x x_2) i x * R (phi i x_1) x_1 x_2)) (fun a b c d => R (phi a c) b c * R (phi a d) b d) _
      ⟨fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1), fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x x_2) i x * R (phi i x_1) x_1 x_2) = (-1/8 : ℝ) * (R (phi x_2 x) i x * R (phi x_2 x_1) i x_1)
        linear_combination (-(1/8):ℝ) * ((R (phi i x_1) x_1 x_2) * (sA hlin hsym hskew x_2 x i x) + (-1:ℝ) * (R (phi x_2 x) i x) * (sPA hlin hsym hskew x_2 x_1 i x_1)))
  have h8 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_2 x) x i * R (phi x_1 i) x_2 x_1) = (-1/8 : ℝ) * RR R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_2 x) x i * R (phi x_1 i) x_2 x_1)) (fun a b c d => R (phi a c) b c * R (phi a d) b d) _
      ⟨fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1), fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_2 x) x i * R (phi x_1 i) x_2 x_1) = (-1/8 : ℝ) * (R (phi x_2 x) i x * R (phi x_2 x_1) i x_1)
        linear_combination (-(1/8):ℝ) * ((R (phi x_1 i) x_2 x_1) * (sB hlin hsym hskew x_2 x i x) + (-1:ℝ) * (R (phi x_2 x) i x) * (sPB hlin hsym hskew x_2 x_1 i x_1)))
  have h9 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_2 x) x_1 i * R (phi x i) x_2 x_1) = (1/8 : ℝ) * XX R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_2 x) x_1 i * R (phi x i) x_2 x_1)) (fun i j k l => R (phi i j) k l * R (phi i k) l j) _
      ⟨fun p => (p.2.2.1, p.1, p.2.1, p.2.2.2), fun p => (p.2.1, p.2.2.1, p.1, p.2.2.2), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_2 x) x_1 i * R (phi x i) x_2 x_1) = (1/8 : ℝ) * (R (phi x_2 x) x_1 i * R (phi x_2 x_1) i x)
        linear_combination (-(1/8):ℝ) * ((1:ℝ) * (R (phi x_2 x) x_1 i) * (sPB hlin hsym hskew x_2 x_1 i x)))
  have h10 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_2 x) i x_1 * R (phi i x) x_2 x_1) = (1/8 : ℝ) * XX R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_2 x) i x_1 * R (phi i x) x_2 x_1)) (fun i j k l => R (phi i j) k l * R (phi i k) l j) _
      ⟨fun p => (p.1, p.2.2.1, p.2.2.2, p.2.1), fun p => (p.1, p.2.2.2, p.2.1, p.2.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_2 x) i x_1 * R (phi i x) x_2 x_1) = (1/8 : ℝ) * (R (phi x x_2) i x_1 * R (phi x i) x_1 x_2)
        linear_combination (-(1/8):ℝ) * ((R (phi i x) x_2 x_1) * (sA hlin hsym hskew x x_2 i x_1) + (-1:ℝ) * (R (phi x x_2) i x_1) * (sAB hlin hsym hskew x i x_1 x_2)))
  have h11 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_2 x) i x * R (phi i x_1) x_2 x_1) = (-1/8 : ℝ) * RR R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_2 x) i x * R (phi i x_1) x_2 x_1)) (fun a b c d => R (phi a c) b c * R (phi a d) b d) _
      ⟨fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1), fun p => (p.2.2.1, p.2.2.2, p.1, p.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_2 x) i x * R (phi i x_1) x_2 x_1) = (-1/8 : ℝ) * (R (phi x_2 x) i x * R (phi x_2 x_1) i x_1)
        linear_combination (-(1/8):ℝ) * ((1:ℝ) * (R (phi x_2 x) i x) * (sP hlin hsym hskew x_2 x_1 i x_1)))
  have h12 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_2 x_1) x i * R (phi x_1 i) x_2 x) = (1/8 : ℝ) * XX R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_2 x_1) x i * R (phi x_1 i) x_2 x)) (fun i j k l => R (phi i j) k l * R (phi i k) l j) _
      ⟨fun p => (p.2.2.1, p.2.1, p.1, p.2.2.2), fun p => (p.2.2.1, p.2.1, p.1, p.2.2.2), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_2 x_1) x i * R (phi x_1 i) x_2 x) = (1/8 : ℝ) * (R (phi x_2 x_1) x i * R (phi x_2 x) i x_1)
        linear_combination (-(1/8):ℝ) * ((1:ℝ) * (R (phi x_2 x_1) x i) * (sPB hlin hsym hskew x_2 x i x_1)))
  have h13 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_2 x_1) x_1 i * R (phi x i) x_2 x) = (-1/8 : ℝ) * RR R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_2 x_1) x_1 i * R (phi x i) x_2 x)) (fun a b c d => R (phi a c) b c * R (phi a d) b d) _
      ⟨fun p => (p.2.2.1, p.2.2.2, p.2.1, p.1), fun p => (p.2.2.2, p.2.2.1, p.1, p.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_2 x_1) x_1 i * R (phi x i) x_2 x) = (-1/8 : ℝ) * (R (phi x_2 x_1) i x_1 * R (phi x_2 x) i x)
        linear_combination (-(1/8):ℝ) * ((R (phi x i) x_2 x) * (sB hlin hsym hskew x_2 x_1 i x_1) + (-1:ℝ) * (R (phi x_2 x_1) i x_1) * (sPB hlin hsym hskew x_2 x i x)))
  have h14 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_2 x_1) i x_1 * R (phi i x) x_2 x) = (-1/8 : ℝ) * RR R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_2 x_1) i x_1 * R (phi i x) x_2 x)) (fun a b c d => R (phi a c) b c * R (phi a d) b d) _
      ⟨fun p => (p.2.2.1, p.2.2.2, p.2.1, p.1), fun p => (p.2.2.2, p.2.2.1, p.1, p.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_2 x_1) i x_1 * R (phi i x) x_2 x) = (-1/8 : ℝ) * (R (phi x_2 x_1) i x_1 * R (phi x_2 x) i x)
        linear_combination (-(1/8):ℝ) * ((1:ℝ) * (R (phi x_2 x_1) i x_1) * (sP hlin hsym hskew x_2 x i x)))
  have h15 : ∑ x, ∑ x_1, ∑ x_2, ∑ i, -(1 / 8) * (R (phi x_2 x_1) i x * R (phi i x_1) x_2 x) = (1/8 : ℝ) * XX R :=
    reindex (fun x x_1 x_2 i => -(1 / 8) * (R (phi x_2 x_1) i x * R (phi i x_1) x_2 x)) (fun i j k l => R (phi i j) k l * R (phi i k) l j) _
      ⟨fun p => (p.2.1, p.2.2.1, p.2.2.2, p.1), fun p => (p.2.2.2, p.1, p.2.1, p.2.2.1), fun _ => rfl, fun _ => rfl⟩
      (fun x x_1 x_2 i => by
        show -(1 / 8) * (R (phi x_2 x_1) i x * R (phi i x_1) x_2 x) = (1/8 : ℝ) * (R (phi x_1 x_2) i x * R (phi x_1 i) x x_2)
        linear_combination (-(1/8):ℝ) * ((R (phi i x_1) x_2 x) * (sA hlin hsym hskew x_1 x_2 i x) + (-1:ℝ) * (R (phi x_1 x_2) i x) * (sAB hlin hsym hskew x_1 i x x_2)))
  rw [h0, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, h12, h13, h14, h15]
  ring


/-- `Σ m_ijkl²`. -/
noncomputable def SS (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : ℝ :=
  ∑ i, ∑ j, ∑ k, ∑ l, R (phi i j) k l * R (phi i j) k l

theorem normSq_eq {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hskew : ∀ X, IsSkew X → IsSkew (R X)) :
    HamiltonsCubic.RealLayer.normSq R = (1 / 4) * SS R := by
  have hM : ∀ i j, IsSkew (R (phi i j)) := fun i j => hskew _ (HamiltonsCubic.RealLayer.phi_isSkew i j)
  have hp : ∀ i j, inner2 (R (phi i j)) (R (phi i j))
      = (1 / 2) * ∑ k, ∑ l, R (phi i j) k l * R (phi i j) k l := by
    intro i j
    rw [← HamiltonsCubic.L41Statement.Frame.parseval _ _ (hM i j) (hM i j)]
    simp only [HamiltonsCubic.RealLayer.inner2_phi _ (hM i j), neg_mul_neg]
  unfold HamiltonsCubic.RealLayer.normSq HamiltonsCubic.RealLayer.innerOp SS
  simp only [hp, Finset.mul_sum]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
    Finset.sum_congr rfl fun l _ => by ring

theorem alt_eq {R : Matrix ι ι ℝ → Matrix ι ι ℝ} (hskew : ∀ X, IsSkew X → IsSkew (R X)) :
    6 * altNormSq R = (1 / 2) * SS R + XX R := by
  have hc : ∀ i j k l, comp R i j k l = -R (phi i j) k l := fun i j k l =>
    HamiltonsCubic.RealLayer.inner2_phi _ (hskew _ (HamiltonsCubic.RealLayer.phi_isSkew i j)) k l
  let σ1 : ι × ι × ι × ι ≃ ι × ι × ι × ι :=
    ⟨fun p => (p.1, p.2.2.1, p.2.2.2, p.2.1), fun p => (p.1, p.2.2.2, p.2.1, p.2.2.1),
      fun _ => rfl, fun _ => rfl⟩
  let σ2 : ι × ι × ι × ι ≃ ι × ι × ι × ι :=
    ⟨fun p => (p.1, p.2.2.2, p.2.1, p.2.2.1), fun p => (p.1, p.2.2.1, p.2.2.2, p.2.1),
      fun _ => rfl, fun _ => rfl⟩
  have a2 : ∑ i, ∑ j, ∑ k, ∑ l, R (phi i k) l j * R (phi i k) l j = 1 * SS R :=
    reindex (fun i j k l => R (phi i k) l j * R (phi i k) l j)
      (fun i j k l => R (phi i j) k l * R (phi i j) k l) 1 σ1 fun i j k l => by
        show _ = 1 * (R (phi i k) l j * R (phi i k) l j); ring
  have a3 : ∑ i, ∑ j, ∑ k, ∑ l, R (phi i l) j k * R (phi i l) j k = 1 * SS R :=
    reindex (fun i j k l => R (phi i l) j k * R (phi i l) j k)
      (fun i j k l => R (phi i j) k l * R (phi i j) k l) 1 σ2 fun i j k l => by
        show _ = 1 * (R (phi i l) j k * R (phi i l) j k); ring
  have x2 : ∑ i, ∑ j, ∑ k, ∑ l, R (phi i k) l j * R (phi i l) j k = 1 * XX R :=
    reindex (fun i j k l => R (phi i k) l j * R (phi i l) j k)
      (fun i j k l => R (phi i j) k l * R (phi i k) l j) 1 σ1 fun i j k l => by
        show _ = 1 * (R (phi i k) l j * R (phi i l) j k); ring
  have x3 : ∑ i, ∑ j, ∑ k, ∑ l, R (phi i j) k l * R (phi i l) j k = 1 * XX R :=
    reindex (fun i j k l => R (phi i j) k l * R (phi i l) j k)
      (fun i j k l => R (phi i j) k l * R (phi i k) l j) 1 σ2 fun i j k l => by
        show _ = 1 * (R (phi i l) j k * R (phi i j) k l); ring
  have hR : (1 / 2) * SS R + XX R = (1 / 6) * (SS R
      + ∑ i, ∑ j, ∑ k, ∑ l, R (phi i k) l j * R (phi i k) l j
      + ∑ i, ∑ j, ∑ k, ∑ l, R (phi i l) j k * R (phi i l) j k
      + 2 * XX R
      + 2 * ∑ i, ∑ j, ∑ k, ∑ l, R (phi i k) l j * R (phi i l) j k
      + 2 * ∑ i, ∑ j, ∑ k, ∑ l, R (phi i j) k l * R (phi i l) j k) := by
    rw [a2, a3, x2, x3]; ring
  rw [hR]
  unfold altNormSq fourNormSq fourInner altCoeff alt4 SS XX
  simp only [hc, Finset.mul_sum, ← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ =>
    Finset.sum_congr rfl fun l _ => by ring

end Proof

/-! ## The identity -/

/-- **L15, the identity.** For every linear symmetric `R` on `Λ²ℝⁿ`,

`scal(R² + R#) = ‖Ric(R)‖² + 6‖Alt(R)‖²,`

with the constant exactly `6` at every `n` and **no cross-term**.

*The hypothesis is symmetry alone. At a curvature operator `Alt(R) = 0` and the identity is
empty, so the wider class is the statement rather than a generalisation of it.*

**`hskew`, that `R` maps `Λ²` into `Λ²`, is part of "on `Λ²ℝⁿ`" and was missing from the first
typing, which was FALSE (2026-09-24).** *`sharpQF` evaluates `R` at `[η, Rφ]`, so once `Rφ` has a
symmetric part, `R` is read off the bivectors, where `IsSymmetricOp` says nothing.* A screen at
`n = 4` with a linear `R` symmetric on bivectors to machine precision but with a symmetric-valued
component gave a defect of `146.4`; adding `hskew` brings it to rounding error.

**Proved** by contraction in the frame `{φ_ij}`, as the file header sets out. -/
theorem L15 (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hlin : IsLinearOp R) (hsym : IsSymmetricOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X)) :
    scalQ R = ricNormSq R + 6 * altNormSq R := by
  unfold scalQ sharpTrace
  rw [Proof.twoSharp hlin hsym hskew, Proof.RR_eq hskew, Proof.normSq_eq hskew]
  linarith [Proof.alt_eq hskew (R := R)]

/-! ## The `R = I` reading, which is where the normalisations cohere

The record checks the `#` normalisation at `R = I`, where `Alt(I) = 0`: the identity must read
`n(n-1)²` on both sides, and **under the other `#` in circulation the left side is
`n(n-1)(2n-3)`**, so it is false rather than rescaled. -/

/-- **The two sides at `R = I`, as closed forms in `n`.** With `I# = (n-2)I`, the anchor
[WeylReal.lean](../Base/WeylReal.lean)'s `#` carries, the left side is
`2(tr I² + tr I#) = 2(binom n 2 + (n-2) binom n 2) = n(n-1)²`, and `Ric(I) = (n-1)·id` gives
`‖Ric(I)‖² = n(n-1)²`. -/
theorem identity_at_identity_operator (n : ℝ) :
    2 * (n * (n - 1) / 2 + (n - 2) * (n * (n - 1) / 2)) = n * (n - 1) ^ 2 := by ring

/-- **And the competing `#` gives a different number**, `n(n-1)(2n-3)`, so the two cannot differ
by a rescaling of the identity. -/
theorem competing_sharp_differs :
    ∃ n : ℝ, n * (n - 1) * (2 * n - 3) ≠ n * (n - 1) ^ 2 := by
  refine ⟨4, ?_⟩
  norm_num

/-! ## What the identity prices, in arithmetic

Two consequences the record draws from the constant `6`, and both are arithmetic once the
identity is granted. -/

/-- **The `24` is `6·4`, via `Alt(|W|) = 2 Alt(W_-)`.** Doubling a tensor quadruples its squared
norm, so the `6‖Alt(|W|)‖²` the identity supplies is `24‖Alt(W_-)‖²` in the master
inequality. -/
theorem price_is_twentyfour (d : ℝ) : 6 * (2 * d) ^ 2 = 24 * d ^ 2 := by ring

/-- **The factor of three at Fox's `S⁴(α)`.** The uncorrected inequality reads `4` where `4/3` is
available, and `4 = 3·(4/3)` exactly, so the failure is by a factor of three, not approximately
so. *All four quantities are padding-invariant, so this holds at every `n ≥ 4`.* -/
theorem fox_factor_three : (4 : ℝ) = 3 * (4 / 3) := by norm_num

/-! ## Non-vacuity

The hypotheses of `L15` are satisfied by operators that are not curvature operators, which is
the whole point of the wider class. -/

/-- **The identity operator is linear and symmetric**, so `L15`'s hypotheses are inhabited. *At
`R = I` the Bianchi defect vanishes and the identity is the empty case; the non-empty cases are
the ones the observation exists for.* -/
theorem id_satisfies_hypotheses :
    IsLinearOp (id : Matrix ι ι ℝ → Matrix ι ι ℝ) ∧ IsSymmetricOp (id : Matrix ι ι ℝ → Matrix ι ι ℝ) := by
  refine ⟨⟨fun X Y => rfl, fun a X => rfl⟩, fun X Y _ _ => rfl⟩

/-- **The zero operator too**, and at it both sides of the identity are `0`. -/
theorem zero_satisfies_identity :
    scalQ (fun _ => (0 : Matrix ι ι ℝ)) = ricNormSq (fun _ => (0 : Matrix ι ι ℝ))
      + 6 * altNormSq (fun _ => (0 : Matrix ι ι ℝ)) := by
  simp [scalQ, normSq, innerOp, sharpTrace, sharpQF, ricNormSq, Ric,
    HamiltonsCubic.AltLayer.altNormSq, HamiltonsCubic.AltLayer.altCoeff,
    HamiltonsCubic.AltLayer.fourNormSq, HamiltonsCubic.AltLayer.fourInner,
    HamiltonsCubic.AltLayer.alt4, HamiltonsCubic.AltLayer.comp, inner2, br]

end HamiltonsCubic.L15Statement
