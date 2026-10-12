import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.AltPart
import HamiltonsCubic.Base.AltAntisym
import HamiltonsCubic.Results.L179Statement

/-!
# I36's Λ⁴ test: every power of a coordinate-diagonal operator is Bianchi-free

[findings/diagonal-half.md](../../../findings/diagonal-half.md), the I36 section.
The item asks for a computable test for "diagonal in some orthonormal frame",
which is an existential over frames. `Alt` is a candidate because it is
frame-covariant and vanishes on the locus, and this file types the half that is
derived.

`diagOp w` is the coordinate-diagonal operator with weight `w`, acting
entrywise. The base layer already proves `bianchi (diagOp w) = 0`
(`diagOp_bianchi`). What is added here is that the property survives every
power, because a composite of two diagonal operators is the diagonal operator of
the entrywise product, so the whole family `Alt(W^k) = 0`, `k ≥ 1`, holds at
once on the locus.

**What this file does NOT state**, and [lean/INDEX.md](../../INDEX.md) records it:
the converse, which the record has as **FALSE** for general symmetric operators
(part (iii) of the same block exhibits a witness at `n = 4`) and open only inside
the Weyl cone. The Vandermonde half is stated over `rankSumOp`, the layer's own
`Σ λᵢ ωᵢ ⊗ ωᵢ`, with DISTINCT nonzero eigenvalues so that each eigenspace is a
line and `𝔟(P_μ)` is one self-wedge. Both directions are proved, the second by
inverting the Vandermonde matrix on the `lam i`. The file carries no `sorry`.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Results

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.AltLayer HamiltonsCubic.SelfDualLayer HamiltonsCubic.L179

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The entrywise (Hadamard) product of two weights. -/
def hmul (w v : Matrix ι ι ℝ) : Matrix ι ι ℝ := Matrix.of fun a b => w a b * v a b

/-- **Diagonal operators compose entrywise.** This is the whole reason the test
survives powers. -/
theorem diagOp_comp (w v : Matrix ι ι ℝ) :
    (fun X => diagOp w (diagOp v X)) = diagOp (hmul w v) := by
  funext X; funext a b; simp [diagOp, hmul, mul_assoc]

/-- Entrywise powers of a weight. -/
def hpow (w : Matrix ι ι ℝ) : ℕ → Matrix ι ι ℝ
  | 0 => Matrix.of fun _ _ => 1
  | (k + 1) => hmul w (hpow w k)

/-- **Every power of a coordinate-diagonal operator is a coordinate-diagonal
operator**, with the entrywise power as its weight. -/
theorem diagOp_iterate (w : Matrix ι ι ℝ) :
    ∀ k : ℕ, ∀ X, (diagOp w)^[k] X = diagOp (hpow w k) X
  | 0, X => by funext a b; simp [hpow, diagOp]
  | (k + 1), X => by
      rw [Function.iterate_succ_apply, diagOp_iterate w k]
      funext a b
      simp [diagOp, hmul, hpow, mul_comm, mul_left_comm, mul_assoc]

/-- Symmetry of a weight is inherited by its entrywise powers. -/
theorem hpow_symm {w : Matrix ι ι ℝ} (hw : ∀ a b, w a b = w b a) :
    ∀ k a b, hpow w k a b = hpow w k b a
  | 0, _, _ => rfl
  | (k + 1), a, b => by simp [hpow, hmul, hw a b, hpow_symm hw k a b]

/-- The weight of a power is symmetric, which is all `diagOp_bianchi` needs. -/
theorem bianchi_diagOp_hpow (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) (k : ℕ)
    (i j l m : ι) :
    bianchi (diagOp (hpow w k)) i j l m = 0 :=
  diagOp_bianchi _ (hpow_symm hw k) i j l m

/-- **I36(i), typed as the claim actually is: about the ITERATE.** Every power of a
coordinate-diagonal operator is Bianchi-free, so the whole family `Alt(W^k) = 0`
holds on the locus at once. *The subject here is `(diagOp w)^[k]`, and it is
`diagOp_iterate` that identifies it with a diagonal operator. Stating it at the
entrywise power instead says nothing about iteration and is interdeducible with
the base layer's `diagOp_bianchi` alone.* -/
theorem bianchi_diagOp_iterate (w : Matrix ι ι ℝ) (hw : ∀ a b, w a b = w b a) (k : ℕ)
    (i j l m : ι) :
    bianchi (fun X => (diagOp w)^[k] X) i j l m = 0 := by
  have h : (fun X => (diagOp w)^[k] X) = diagOp (hpow w k) := by
    funext X; exact diagOp_iterate w k X
  rw [h]
  exact bianchi_diagOp_hpow w hw k i j l m

/-- **I36(ii), the easy direction, proved.** When every eigenform is decomposable,
every power of the spectral operator is Bianchi-free. -/
theorem bianchi_rankSumOp_pow_of_wedgeSelf {r : ℕ} (lam : Fin r → ℝ)
    (om : Fin r → Matrix ι ι ℝ) (hskew : ∀ i, (om i)ᵀ = -om i)
    (h : ∀ i a b c d, wedgeSelf (om i) a b c d = 0) (k : ℕ) (a b c d : ι) :
    bianchi (rankSumOp (fun i => lam i ^ k) om) a b c d = 0 := by
  rw [bianchi_rankSumOp _ om hskew a b c d]
  simp [h]

/-- **I36(ii), the Vandermonde direction, proved.** With DISTINCT nonzero
eigenvalues each eigenspace is a line, so `𝔟(P_μ)` is the single self-wedge
`ωᵢ ∧ ωᵢ`, and the Vandermonde matrix on the `lam i` inverts the `k`-family: the
powers `k = 1, …, r` give `Vᵀ (λ ⊙ w) = 0`, `V` is invertible because `lam` is injective, and
`λᵢ ≠ 0` strips the factor.
*The earlier form of this statement quantified over an unconstrained family of
maps and was FALSE: with two equal `P` and `mu = (1, -1)` the operator is zero,
so the left side held while the right failed. Stating it at `rankSumOp` with
`lam` injective is what makes the eigenprojector reading correct.* -/
theorem wedgeSelf_of_bianchi_rankSumOp_pow {r : ℕ} (lam : Fin r → ℝ)
    (om : Fin r → Matrix ι ι ℝ) (_hskew : ∀ i, (om i)ᵀ = -om i)
    (_hne : ∀ i, lam i ≠ 0) (_hinj : Function.Injective lam)
    (_h : ∀ k : ℕ, 1 ≤ k → ∀ a b c d,
      bianchi (rankSumOp (fun i => lam i ^ k) om) a b c d = 0) :
    ∀ i a b c d, wedgeSelf (om i) a b c d = 0 := by
  intro i a b c d
  set w : Fin r → ℝ := fun i => lam i * wedgeSelf (om i) a b c d with hw
  have hv : (Matrix.vandermonde lam)ᵀ *ᵥ w = 0 := by
    funext k
    have h1 := _h (k.val + 1) (by omega) a b c d
    rw [bianchi_rankSumOp _ om _hskew a b c d] at h1
    have h2 : ∑ i, lam i ^ (k.val + 1) * wedgeSelf (om i) a b c d = 0 := by linarith
    simp only [Matrix.mulVec, dotProduct, Matrix.transpose_apply, Matrix.vandermonde_apply,
      Pi.zero_apply, hw]
    rw [← h2]
    exact Finset.sum_congr rfl fun j _ => by ring
  have hdet : (Matrix.vandermonde lam)ᵀ.det ≠ 0 := by
    rw [Matrix.det_transpose]; exact Matrix.det_vandermonde_ne_zero_iff.mpr _hinj
  have := congrFun (Matrix.eq_zero_of_mulVec_eq_zero hdet hv) i
  exact (mul_eq_zero.mp this).resolve_left (_hne i)

/-! ## The `n = 4` step, which is where Gate 2 closed the Weyl case

[r847](../../../reviews/REVIEW_r847.md) closed the converse in the affirmative at
`n = 4`, and the step it runs on is that `Λ⁴ℝ⁴` is one-dimensional: every `Alt(A)`
is a multiple of the Levi-Civita symbol, so the whole `k`-family collapses to one
scalar per power and Newton then equates the spectra of `W⁺` and `W⁻`. The
one-dimensionality is stated here; the spectral half needs the `Λ±` splitting as a
decomposition of the operator, which the layer states only as a submodule.
-/

set_option maxHeartbeats 4000000 in
/-- **At `n = 4` the `Λ⁴` part of any operator is a multiple of `levi4`.** This is
what makes the `n = 4` characterisation possible: the `k`-family of conditions
becomes a family of scalars.

**THE SPLIT, AND IT IS A WARNING RATHER THAN A RECIPE: THIS STATEMENT CARRIES NO HYPOTHESES ON
`A`, AND MAY NOT BE TRUE.**

*A first version of this note called it a finite check over the `4⁴` index tuples, on the ground
that `altCoeff` is alternating so both sides vanish on a repeated index.* **That ground is not
established.** `alt4` is the CYCLIC sum over the last three indices,
`⅓(T i j k l + T i k l j + T i l j k)`, which is invariant under cyclic permutation of `j k l` and
is NOT full antisymmetrisation. *Nothing here makes `altCoeff A a a x y` vanish.*

**AND `A` IS QUANTIFIED OVER EVERY MAP, NOT EVERY CURVATURE OPERATOR.** *`comp A i j k l` is
`⟪A φ_ij, φ_kl⟫`, so even `φ_aa = 0` gives nothing without linearity: `A 0` need not be `0`.* The
`n = 4` argument this file cites needs `Alt(A)` to be a genuine `Λ⁴` element, which requires the
curvature symmetries, and the statement as written asks for the conclusion without them.

**AND THE SCREEN FOUND A WITNESS: IT IS FALSE AS STATED.** *Take `A` the CONSTANT map
`x ↦ φ₀₁`.* Then `altCoeff A 0 0 1 2 = ⅓` while `levi4 0 0 1 2 = 0`, and a repeated index makes
the right side `0` for EVERY `c`, so one nonzero left side refutes the existential. **Thirty-six
of the two hundred and fifty-six tuples fail for that one witness.**

*The map is constant rather than linear, which is exactly the hypothesis the statement omits*: at
a linear `A`, `A 0 = 0` kills `comp A a a k l`, and the curvature symmetries then make `Alt(A)` a
genuine `Λ⁴` element.

**THE STATEMENT BELOW IS THE RESTATEMENT, CARRYING LINEARITY AND THE SYMMETRY CLAUSE**, which is
what `comp_pair_symm` in [AltPart.lean](../Base/AltPart.lean) runs on. *A `sorry` under a false
statement is worse than an open one, because everything that cites it inherits the error.*

**AND THE RESTATEMENT SURVIVES A NON-DEGENERATE SCREEN.** *The Hodge star on `Λ²ℝ⁴` is linear,
symmetric, and has `c = 1`*, and it matches `c · levi4` at all two hundred and fifty-six tuples.
**That is the test the obvious witnesses cannot perform**: the identity and its multiples give
`c = 0`, so they satisfy the conclusion vacuously and would pass even if it were false. *Reported
as a screen: it constrains the statement and does not establish it.*

**`wedgeSelf_of_bianchi_rankSumOp_pow` is of a different shape**: it separates the
eigenprojectors by inverting the Vandermonde matrix over the `k`-family, which is real
mathematics rather than a finite check. -/
theorem alt_eq_smul_levi4 (A : Matrix (Fin 4) (Fin 4) ℝ → Matrix (Fin 4) (Fin 4) ℝ)
    (hneg : ∀ X, A (-X) = -A X)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (A X) Y = inner2 X (A Y)) :
    ∃ c : ℝ, ∀ a b x y : Fin 4, altCoeff A a b x y = c * levi4 a b x y := by
  refine ⟨altCoeff A 0 1 2 3, ?_⟩
  have z12 := altCoeff_zero_12 A hneg hsym
  have z13 := altCoeff_zero_13 A hneg hsym
  have z14 := altCoeff_zero_14 A hneg hsym
  have q0132 : altCoeff A 0 1 3 2 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_last A 0 1 2 3]
    try ring
  have q0213 : altCoeff A 0 2 1 3 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_mid A 0 1 2 3]
    try ring
  have q0231 : altCoeff A 0 2 3 1 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_last A 0 2 1 3, altCoeff_antisym_mid A 0 1 2 3]
    try ring
  have q0312 : altCoeff A 0 3 1 2 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_mid A 0 1 3 2, altCoeff_antisym_last A 0 1 2 3]
    try ring
  have q0321 : altCoeff A 0 3 2 1 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_mid A 0 2 3 1, altCoeff_antisym_last A 0 2 1 3, altCoeff_antisym_mid A 0 1 2 3]
    try ring
  have q1023 : altCoeff A 1 0 2 3 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 0 1 2 3]
    try ring
  have q1032 : altCoeff A 1 0 3 2 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 0 1 3 2, altCoeff_antisym_last A 0 1 2 3]
    try ring
  have q1203 : altCoeff A 1 2 0 3 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_mid A 1 0 2 3, altCoeff_antisym_first A hneg hsym 0 1 2 3]
    try ring
  have q1230 : altCoeff A 1 2 3 0 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_last A 1 2 0 3, altCoeff_antisym_mid A 1 0 2 3, altCoeff_antisym_first A hneg hsym 0 1 2 3]
    try ring
  have q1302 : altCoeff A 1 3 0 2 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_mid A 1 0 3 2, altCoeff_antisym_first A hneg hsym 0 1 3 2, altCoeff_antisym_last A 0 1 2 3]
    try ring
  have q1320 : altCoeff A 1 3 2 0 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_mid A 1 2 3 0, altCoeff_antisym_last A 1 2 0 3, altCoeff_antisym_mid A 1 0 2 3, altCoeff_antisym_first A hneg hsym 0 1 2 3]
    try ring
  have q2013 : altCoeff A 2 0 1 3 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 0 2 1 3, altCoeff_antisym_mid A 0 1 2 3]
    try ring
  have q2031 : altCoeff A 2 0 3 1 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 0 2 3 1, altCoeff_antisym_last A 0 2 1 3, altCoeff_antisym_mid A 0 1 2 3]
    try ring
  have q2103 : altCoeff A 2 1 0 3 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 1 2 0 3, altCoeff_antisym_mid A 1 0 2 3, altCoeff_antisym_first A hneg hsym 0 1 2 3]
    try ring
  have q2130 : altCoeff A 2 1 3 0 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 1 2 3 0, altCoeff_antisym_last A 1 2 0 3, altCoeff_antisym_mid A 1 0 2 3, altCoeff_antisym_first A hneg hsym 0 1 2 3]
    try ring
  have q2301 : altCoeff A 2 3 0 1 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_mid A 2 0 3 1, altCoeff_antisym_first A hneg hsym 0 2 3 1, altCoeff_antisym_last A 0 2 1 3, altCoeff_antisym_mid A 0 1 2 3]
    try ring
  have q2310 : altCoeff A 2 3 1 0 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_mid A 2 1 3 0, altCoeff_antisym_first A hneg hsym 1 2 3 0, altCoeff_antisym_last A 1 2 0 3, altCoeff_antisym_mid A 1 0 2 3, altCoeff_antisym_first A hneg hsym 0 1 2 3]
    try ring
  have q3012 : altCoeff A 3 0 1 2 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 0 3 1 2, altCoeff_antisym_mid A 0 1 3 2, altCoeff_antisym_last A 0 1 2 3]
    try ring
  have q3021 : altCoeff A 3 0 2 1 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 0 3 2 1, altCoeff_antisym_mid A 0 2 3 1, altCoeff_antisym_last A 0 2 1 3, altCoeff_antisym_mid A 0 1 2 3]
    try ring
  have q3102 : altCoeff A 3 1 0 2 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 1 3 0 2, altCoeff_antisym_mid A 1 0 3 2, altCoeff_antisym_first A hneg hsym 0 1 3 2, altCoeff_antisym_last A 0 1 2 3]
    try ring
  have q3120 : altCoeff A 3 1 2 0 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 1 3 2 0, altCoeff_antisym_mid A 1 2 3 0, altCoeff_antisym_last A 1 2 0 3, altCoeff_antisym_mid A 1 0 2 3, altCoeff_antisym_first A hneg hsym 0 1 2 3]
    try ring
  have q3201 : altCoeff A 3 2 0 1 = -altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 2 3 0 1, altCoeff_antisym_mid A 2 0 3 1, altCoeff_antisym_first A hneg hsym 0 2 3 1, altCoeff_antisym_last A 0 2 1 3, altCoeff_antisym_mid A 0 1 2 3]
    try ring
  have q3210 : altCoeff A 3 2 1 0 = altCoeff A 0 1 2 3 := by
    rw [altCoeff_antisym_first A hneg hsym 2 3 1 0, altCoeff_antisym_mid A 2 1 3 0, altCoeff_antisym_first A hneg hsym 1 2 3 0, altCoeff_antisym_last A 1 2 0 3, altCoeff_antisym_mid A 1 0 2 3, altCoeff_antisym_first A hneg hsym 0 1 2 3]
    try ring
  intro a b x y
  fin_cases a <;> fin_cases b <;> fin_cases x <;> fin_cases y <;>
    simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue,
      z12, z13, z14, altCoeff_zero_23, altCoeff_zero_24, altCoeff_zero_34,
      q0132,
      q0213,
      q0231,
      q0312,
      q0321,
      q1023,
      q1032,
      q1203,
      q1230,
      q1302,
      q1320,
      q2013,
      q2031,
      q2103,
      q2130,
      q2301,
      q2310,
      q3012,
      q3021,
      q3102,
      q3120,
      q3201,
      q3210] <;>
    norm_num [levi4, sgnR, Fin.lt_def]

/-! **THE ROUTE THAT WORKED WAS THE ONE THE FAILURE NAMED: GENERATORS, NOT A MONOLITHIC SPLIT.**

*The hypotheses are the weakest ones that suffice*: `altCoeff_antisym_first` in
[AltPart.lean](../Base/AltPart.lean) needs only sign-flipping rather than full linearity, and
`altCoeff_antisym_mid` needs nothing at all. **Those two plus `altCoeff_antisym_last` are the three
ADJACENT transpositions, which generate the whole symmetric group on four letters**, so a tuple with
four distinct entries in `Fin 4` is a permutation of `(0,1,2,3)` and its value is the base value up
to sign. `levi4` carries the same sign, so the constant is the base value itself.

**AND THE SIX COINCIDENCE LEMMAS CLOSE THE REST.** *The split is 24 all-distinct tuples against 232
that repeat an index*, and on a repeat both sides vanish: `altCoeff` by
[AltAntisym.lean](../Base/AltAntisym.lean)'s six patterns, `levi4` because `sgnR x x = 0`.

**WHAT FAILED BEFORE WAS DOING THAT AS ONE CASE ANALYSIS.** *A `linarith` carrying the generators at
all twenty-four permutations, run on each of two hundred and fifty-six branches, reached 5.5 GB in
forty seconds and was killed; the count went 2, 5, 1, 23, out-of-memory.* **The working shape proves
the twenty-four permutation values FIRST, as named facts, and lets the case split do nothing but
match one of them**: the branches still exist, and each is a rewrite rather than a search. *It
elaborates in nine seconds.* -/


end HamiltonsCubic.Results
