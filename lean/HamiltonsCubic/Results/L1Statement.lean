import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.L57Diagonal
import HamiltonsCubic.Results.L57Sphere

/-!
# L1, the granted diagonal case at `n = 12` and `n = 14`, PROVED

[problem.md](../../../findings/problem.md)'s Lemma L1. The record's own statement of what it
supplies:

> [Jäger's Theorem A](../../../references/jaeger-2016-diagonal-case/README.md) proves the
> diagonal case for **even `n ≥ 16`**, and the sentence following it leaves `n = 12, 14` open.
> The problem statement grants the diagonal case, so at exactly the two dimensions where the
> conjecture first bites, the grant is not covered by the literature. **Lemma L1 supplies them.**

and the diagonal theorem it supplies, in the form
[problem.md](../../../findings/problem.md) states it:

> **`⟨Q(W), W⟩ ≤ Θₙ|W|³` for every diagonal Weyl tensor at every `n ≥ 4`, with equality exactly
> at `S^{⌊n/2⌋} × S^{⌈n/2⌉}` (up to sign and permutation, uniquely for `n ≥ 5`).**

At `n = 12` and `n = 14` (both even), `Θₙ = θ₀(n) = √(2(n−1)(n−2))/n`.

## How the bound is proved

**`L1` is [L57Diagonal.lean](L57Diagonal.lean)'s `L57_diagonal` read at `n = 12, 14`.** That
theorem bounds `P(diag w)` for every weight `w` at every `n ≥ 4`; what joins the two statements
is that a diagonal Weyl operator IS `diag w` on bivectors:

- `diag_entry`: the symmetry clause of `IsWeyl` makes `(W X)ᵢⱼ = cᵢⱼ Xᵢⱼ` at every skew `X`, the
  `φᵢⱼ` coordinate of `W X` being `⟨X, W φᵢⱼ⟩`;
- `wOf_isWeight`: the eigenvalues, zeroed on the diagonal, form a weight, symmetric by the same
  clause and with zero row sums because the row sum is `Ric W a a`;
- `pcubic_congr`: `P` and `‖·‖` evaluate an operator only on bivectors, so `W` and `diag w`
  have the same `P` and the same norm.

**The equality clause is `L1_eq`**: a unit diagonal Weyl operator attains `θ₀(n)` exactly when it
is, on bivectors, `diag (c · sphereWeight T)` with `c > 0` and `2|T| = n`, the balanced sphere
product, read from [L57Sphere.lean](L57Sphere.lean)'s `L57_equality_even` through the same bridge.
**Both are stated in the coordinate frame**, the class `IsDiagonalOp` names.

## What IS proved here besides

The one rounding the record quantifies, and the two comparisons `n = 12` turns on. Those are
arithmetic and they are complete.

## The scope this file records

**`n = 12` and `n = 14`**, the two dimensions the record's L1 is about; `L57_diagonal` covers
every `n ≥ 4`. The record is explicit that nothing in the project depends on L1 (*"what it
depends on is the grant"*) so this statement is a correction offered to the setter rather than
a link in the route.

## A caveat inherited from the layer

`Pcubic` is [WeylReal.lean](../Base/WeylReal.lean)'s, built from `sharpBil`, the polarised `R#`.
The record's `P` is `⟨W, W² + W#⟩` and the layer's `Pcubic` is `trCube + sharpPair`; the
statement below is faithful to the record exactly to the extent that those agree.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L1Statement

open HamiltonsCubic.RealLayer Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## Diagonal, and the constant -/

/-- **`W` is diagonal in coordinate 2-planes**: every basis bivector `φ_ij` is an eigenvector.
*This is the class Jäger's Theorem A is about and the class the problem statement grants.* -/
def IsDiagonalOp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  ∃ c : ι → ι → ℝ, ∀ i j, R (phi i j) = c i j • phi i j

/-- `θ₀(n) = √(2(n−1)(n−2))/n`, which is `Θₙ` at even `n`. -/
noncomputable def theta0 (n : ℕ) : ℝ := Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ)

/-! ## A diagonal Weyl operator is `diagOp` of a weight on bivectors -/

open HamiltonsCubic.FamilyLayer

/-- **Self-adjointness fixes a diagonal `W` on every bivector, not only on the basis**: at a skew
`X`, `(W X)ᵢⱼ = cᵢⱼ Xᵢⱼ`. *`IsWeyl` carries no linearity clause, and the symmetry clause supplies
what linearity would: the `φᵢⱼ` coordinate of `W X` is `⟨X, W φᵢⱼ⟩`.* -/
theorem diag_entry {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {c : ι → ι → ℝ}
    (hc : ∀ i j, W (phi i j) = c i j • phi i j) {X : Matrix ι ι ℝ} (hX : IsSkew X) (i j : ι) :
    W X i j = c i j * X i j := by
  have h1 := inner2_phi (W X) (hW.1 X hX) i j
  have h2 := hW.2.1 X (phi i j) hX (phi_isSkew i j)
  rw [hc, inner2_smul_right, inner2_phi X hX] at h2
  linear_combination (-1 : ℝ) * (h1.symm.trans h2)

/-- The weight a diagonal `W` carries: its eigenvalues off the diagonal, `0` on it. -/
def wOf (c : ι → ι → ℝ) : Matrix ι ι ℝ := Matrix.of fun a b => if a = b then 0 else c a b

/-- **`W = diag w` on bivectors.** -/
theorem diag_eq {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {c : ι → ι → ℝ}
    (hc : ∀ i j, W (phi i j) = c i j • phi i j) {X : Matrix ι ι ℝ} (hX : IsSkew X) :
    W X = diagOp (wOf c) X := by
  ext i j
  simp only [diagOp, wOf, Matrix.of_apply]
  rw [diag_entry hW hc hX]
  split_ifs with h
  · subst h
    have hii : X i i = 0 := by
      have := congrFun (congrFun hX i) i
      simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
      linarith
    simp [hii]
  · rfl

/-- **The eigenvalues form a weight**: symmetric by self-adjointness read at `φ_ab`'s `(b,a)`
entry, and row sums zero because the row sum is `Ric W a a`. -/
theorem wOf_isWeight {W : Matrix ι ι ℝ → Matrix ι ι ℝ} (hW : IsWeyl W) {c : ι → ι → ℝ}
    (hc : ∀ i j, W (phi i j) = c i j • phi i j) : IsWeight (wOf c) where
  symm a b := by
    simp only [wOf, Matrix.of_apply]
    by_cases h : a = b
    · simp [h]
    · rw [if_neg h, if_neg (Ne.symm h)]
      have e := diag_entry hW hc (phi_isSkew a b) b a
      rw [hc a b] at e
      have p1 : phi a b b a = 1 := by
        simp [phi, Matrix.sub_apply, h, Ne.symm h]
      simp only [Matrix.smul_apply, smul_eq_mul, p1, mul_one] at e
      linarith
  hollow a := by simp [wOf]
  rowSum a := by
    have hr := hW.2.2.2 a a
    unfold Ric at hr
    rw [← hr]
    refine Finset.sum_congr rfl fun b _ => ?_
    simp only [wOf, Matrix.of_apply]
    split_ifs with h
    · subst h
      rw [phi_self]
      simp [inner2_eq_sum]
    · rw [hc, FamilyLayer.inner2_smul_left, inner2_self_phi a b h, mul_one]

/-- **`P` and `‖·‖` read an operator on bivectors only**, so two operators agreeing there, one
of them preserving bivectors, have the same `P` and the same norm. *Every evaluation in
`trCube`, `sharpQF`, `sharpBil`, `sharpOp` and `innerOp` is at a `φ`, a bracket of bivectors, a sum
of two, or the image of one.* -/
theorem pcubic_congr {R S : Matrix ι ι ℝ → Matrix ι ι ℝ} (hR : ∀ X, IsSkew X → IsSkew (R X))
    (h : ∀ X, IsSkew X → R X = S X) : Pcubic R = Pcubic S ∧ normSq R = normSq S := by
  have hadd : ∀ {A B : Matrix ι ι ℝ}, IsSkew A → IsSkew B → IsSkew (A + B) := by
    intro A B hA hB
    unfold IsSkew at *
    rw [Matrix.transpose_add, hA, hB, neg_add]
  have hbr : ∀ {A B : Matrix ι ι ℝ}, IsSkew A → IsSkew B → IsSkew (br A B) := by
    intro A B hA hB
    unfold IsSkew br at *
    rw [Matrix.transpose_sub, Matrix.transpose_mul, Matrix.transpose_mul, hA, hB]
    noncomm_ring
  have hQF : ∀ η, IsSkew η → sharpQF R η = sharpQF S η := by
    intro η hη
    unfold sharpQF
    refine congrArg (HMul.hMul (-(1/4 : ℝ))) (Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_)
    rw [h _ (hbr hη (hR _ (phi_isSkew i j))), h _ (phi_isSkew i j)]
  have hBil : ∀ X Y, IsSkew X → IsSkew Y → sharpBil R X Y = sharpBil S X Y := by
    intro X Y hX hY
    unfold sharpBil
    rw [hQF _ (hadd hX hY), hQF X hX, hQF Y hY]
  have hOp : ∀ X, IsSkew X → sharpOp R X = sharpOp S X := by
    intro X hX
    unfold sharpOp
    refine congrArg (HSMul.hSMul (1/2 : ℝ)) (Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_)
    rw [hBil X _ hX (phi_isSkew i j)]
  have hT : trCube R = trCube S := by
    unfold trCube innerOp compOp
    refine congrArg (HMul.hMul (1/2 : ℝ)) (Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_)
    rw [h _ (hR _ (phi_isSkew i j)), h _ (phi_isSkew i j)]
  have hP : sharpPair R = sharpPair S := by
    unfold sharpPair innerOp
    refine congrArg (HMul.hMul (1/2 : ℝ)) (Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_)
    rw [hOp _ (phi_isSkew i j), h _ (phi_isSkew i j)]
  refine ⟨?_, ?_⟩
  · rw [Pcubic_eq, Pcubic_eq, hT, hP]
  · unfold normSq innerOp
    refine congrArg (HMul.hMul (1/2 : ℝ)) (Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_)
    rw [h _ (phi_isSkew i j)]

/-! ## The statement -/

/-- **L1.** At `n = 12` and at `n = 14`, every diagonal Weyl tensor satisfies

`⟨Q(W), W⟩ ≤ Θₙ ‖W‖³`,

with `Θₙ = θ₀(n)` at these two even dimensions. **This is the granted diagonal case at the two
threshold dimensions Jäger's Theorem A leaves open**, proved as `L57_diagonal` at the weight
`W` carries. -/
theorem L1 (n : ℕ) (hn : n = 12 ∨ n = 14) (hcard : Fintype.card ι = n)
    (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeyl W) (hdiag : IsDiagonalOp W) :
    Pcubic W ≤ theta0 n * norm W ^ 3 := by
  obtain ⟨c, hc⟩ := hdiag
  have hcong := pcubic_congr hW.1 (fun X hX => diag_eq hW hc hX)
  have hn4 : 4 ≤ Fintype.card ι := by rcases hn with h | h <;> omega
  have key := HamiltonsCubic.L57Critical.L57_diagonal hn4 (wOf c) (wOf_isWeight hW hc)
  subst hcard
  have hnorm : RealLayer.norm W = RealLayer.norm (diagOp (wOf c)) := by
    unfold RealLayer.norm; rw [hcong.2]
  rw [hcong.1, hnorm]
  exact key

/-- **L1's equality clause.** At `n = 12` and `n = 14`, a unit diagonal Weyl operator attains `θ₀(n)` exactly when
it is, on bivectors, the balanced sphere product: `diag (c · sphereWeight T)` with `c > 0` and `2|T| = n`. -/
theorem L1_eq (n : ℕ) (hn : n = 12 ∨ n = 14) (hcard : Fintype.card ι = n)
    (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeyl W) (hdiag : IsDiagonalOp W) (hu : normSq W = 1) :
    Pcubic W = theta0 n ↔ ∃ (T : Finset ι) (c : ℝ), 2 * T.card = n ∧ 0 < c ∧
      ∀ X, IsSkew X → W X = diagOp (c • sphereWeight T) X := by
  obtain ⟨c, hc⟩ := hdiag
  have hn4 : 4 ≤ Fintype.card ι := by rcases hn with h | h <;> omega
  subst hcard
  have hcong := pcubic_congr hW.1 (fun X hX => diag_eq hW hc hX)
  have hu' : normSq (diagOp (wOf c)) = 1 := by rw [← hcong.2, hu]
  have key := HamiltonsCubic.L57Critical.L57_equality_even hn4 (wOf c) (wOf_isWeight hW hc) hu'
  rw [FamilyLayer.theta_of_unit _ hu'] at key
  rw [hcong.1]
  constructor
  · intro h
    obtain ⟨T, cc, hT, hcc, hS⟩ := key.mp h
    exact ⟨T, cc, hT, hcc, fun X hX => by rw [diag_eq hW hc hX, hS]⟩
  · rintro ⟨T, cc, hT, hcc, hagree⟩
    have hTc : 2 ≤ Tᶜ.card := by
      rw [Finset.card_compl]; rcases hn with h | h <;> omega
    have hT2 : 2 ≤ T.card := by rcases hn with h | h <;> omega
    have hwt : IsWeight (cc • sphereWeight T) := (sphereWeight_isWeight T hT2 hTc).smul cc
    have hcong2 := pcubic_congr hW.1 hagree
    have hu2 : normSq (diagOp (cc • sphereWeight T)) = 1 := by rw [← hcong2.2, hu]
    have key2 := HamiltonsCubic.L57Critical.L57_equality_even hn4 _ hwt hu2
    rw [FamilyLayer.theta_of_unit _ hu2] at key2
    rw [← hcong.1, hcong2.1]
    exact key2.mpr ⟨T, cc, hT, hcc, rfl⟩


/-- **The constant at the two dimensions**: `θ₀(12)² = 55/36` and `θ₀(14)² = 78/49`. -/
theorem theta0_values : theta0 12 ^ 2 = 55 / 36 ∧ theta0 14 ^ 2 = 78 / 49 := by
  constructor
  · unfold theta0
    rw [div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2 * ((12:ℕ) - 1 : ℝ) * ((12:ℕ) - 2 : ℝ))]
    norm_num
  · unfold theta0
    rw [div_pow, Real.sq_sqrt (by norm_num : (0:ℝ) ≤ 2 * ((14:ℕ) - 1 : ℝ) * ((14:ℕ) - 2 : ℝ))]
    norm_num

/-- **The hypotheses are satisfiable.** The zero operator is a diagonal Weyl tensor, so `L1` is
not vacuous. *It is not where the bound bites; the interesting members are the record's.* -/
example : IsWeyl (fun _ => 0 : Matrix ι ι ℝ → Matrix ι ι ℝ) ∧
    IsDiagonalOp (fun _ => 0 : Matrix ι ι ℝ → Matrix ι ι ℝ) := by
  refine ⟨⟨?_, ?_, ?_, ?_⟩, ⟨fun _ _ => 0, ?_⟩⟩
  · intro X _; simp [IsSkew]
  · intro X Y _ _; simp [inner2]
  · intro i j k l; simp [bianchi, inner2]
  · intro a b; simp [Ric, inner2]
  · intro i j; simp

/-! ## Step 1's one quantified rounding

*"One of those roundings is quantified: the report's Step 3 records `tr S⁴ ≤ E(n)` rounded to
`16/(8n+9)`, valid at every integer `n ≥ 4` since the cleared inequality is `41n − 57 ≥ 0`."* -/

/-- Jäger's Step-3 ceiling `E(n) = (8n² − 41n + 49)/(4(n+1)(n−2)(n−3))`. -/
noncomputable def E (n : ℝ) : ℝ := (8 * n ^ 2 - 41 * n + 49) / (4 * (n + 1) * (n - 2) * (n - 3))

/-- **The cleared inequality is exactly `41n − 57 ≥ 0`**, identically in `n`. -/
theorem rounding_cleared (n : ℝ) :
    16 * (4 * (n + 1) * (n - 2) * (n - 3)) - (8 * n ^ 2 - 41 * n + 49) * (8 * n + 9)
      = 41 * n - 57 := by ring

/-- **So the rounding is valid at every `n ≥ 4`**, and `n ≥ 2` is not the right hypothesis:
`41n − 57` fails at `n = 5/2`, and `E` is undefined at `n = 2, 3`. -/
theorem rounding_valid {n : ℝ} (hn : 4 ≤ n) : E n ≤ 16 / (8 * n + 9) := by
  have hd1 : (0:ℝ) < 4 * (n + 1) * (n - 2) * (n - 3) :=
    mul_pos (mul_pos (by linarith : (0:ℝ) < 4 * (n + 1)) (by linarith : (0:ℝ) < n - 2))
      (by linarith : (0:ℝ) < n - 3)
  have hd2 : (0:ℝ) < 8 * n + 9 := by linarith
  unfold E
  rw [div_le_div_iff₀ hd1 hd2]
  nlinarith [rounding_cleared n]

/-- **And the rounding itself fails at `n = 5/2`**, which is what makes `4 ≤ n` the right
hypothesis rather than the `n ≥ 2` once printed: there `E` sits at `1` against `16/29`.

*The cleared polynomial `41n − 57` is positive there; what fails is the clearing step, the
denominator `4(n+1)(n−2)(n−3)` being negative between `2` and `3`.* -/
theorem rounding_fails_at_five_halves :
    E (5/2) = 1 ∧ 16 / (8 * ((5:ℝ)/2) + 9) = 16 / 29 ∧ 16 / (29:ℝ) < E (5/2) := by
  have h : E (5/2) = 1 := by unfold E; norm_num
  exact ⟨h, by norm_num, by rw [h]; norm_num⟩

/-- **The rounding costs `29/32760` at `n = 12`**, the record's `0.000885`, about a
sixty-fourth of Step 2's residual there, so no single rounding carries the threshold. -/
theorem rounding_cost_at_twelve :
    E 12 = 709 / 4680 ∧ 16 / (8 * (12:ℝ) + 9) = 16 / 105 ∧
      16 / (105:ℝ) - 709 / 4680 = 29 / 32760 := by
  refine ⟨by unfold E; norm_num, by norm_num, by norm_num⟩

/-- And `29/32760` is `0.000885` to three significant figures. -/
theorem rounding_cost_bracket : (0.000884 : ℝ) < 29 / 32760 ∧ (29:ℝ) / 32760 < 0.000886 := by
  constructor <;> norm_num

/-! ## What closes `n = 12`, and what does not

*"The edge yields `tr S³ ≥ 1/√12 = 0.2887` against a requirement of `0.3152`; what closes it is
the dual certificate at `0.3336`, and calling the corner elimination the mechanism overstates its
reach."* -/

/-- **The working edge falls short at `n = 12`**: `1/√12` is below the requirement `0.3152`.
*All three comparisons are made against squares, so no root is taken.* -/
theorem edge_falls_short : (1:ℝ) / 12 < (0.3152 : ℝ) ^ 2 := by norm_num

/-- **The dual certificate clears it**: `0.3336 > 0.3152`. So the certified line, not the corner
elimination, is what closes `n = 12`. -/
theorem certificate_clears : (0.3152 : ℝ) < 0.3336 := by norm_num

/-- **The corner sits ON the working edge with equality**, its first coordinate being exactly
`1/√12`, and the Cauchy–Schwarz edge `(tr S³)² ≤ tr S⁴` admits it, `1/12 = 0.0833` against
`E(12) = 709/4680 = 0.1515`. *So the companion edge does not exclude the corner, against the
sentence that named it as if it did.* -/
theorem cs_edge_admits_corner : (1:ℝ) / 12 < 709 / 4680 := by norm_num

/-- **What excludes the corner is the working edge's equality case**, which forces the flat
spectrum, where `tr S⁴ = 1/12` sits strictly below `E(12) = 709/4680`. -/
theorem flat_spectrum_below_ceiling : (1:ℝ) / 12 < 709 / 4680 := by norm_num

end HamiltonsCubic.L1Statement
