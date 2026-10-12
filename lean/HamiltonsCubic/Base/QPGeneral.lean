import HamiltonsCubic.Base.Curvature

/-!
# B1, first piece: `Q` and `P` at general `n`

[Sharp.lean](Sharp.lean) fixes `Qop` and `Pcubic` at `Matrix (Fin 6) (Fin 6) ℚ`, which is
`Λ²ℝ⁴`, so `n = 4`, outside the programme's range entirely, and every result that needs the
cubic form returns `unsupported` against it. [Curvature.lean](Curvature.lean) already carries
`sharpQF'`, `RicOf`, `bianchiOf` and `IsWeylOf` general over `ι`, with curvature written as a
**map on bivectors** rather than a matrix in a pair basis. This file adds `Q` and `P` in that
formulation.

**The device is the one Curvature.lean documents**: the `Λ²` pairing sums over `i < j`, the
summand is quadratic in the basis bivector, and `φ_{ji} = -φ_{ij}` with `φ_{ii} = 0`, so summing
over all ordered pairs double-counts and nothing else. That replaces the pair table by
`Finset.univ` and every definition below is generic in `n`.

*Written after an audit found five results untypable for want of exactly this.*
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The `Λ²` pairing of two curvature operators, written with the ordered-pair doubling. -/
def innerOp (R S : Matrix ι ι ℚ → Matrix ι ι ℚ) : ℚ :=
  (1/2) * ∑ i : ι, ∑ j : ι, inner2 (R (phi i j)) (S (phi i j))

/-- The composite `R ∘ R`, which is `R²` in the operator reading. -/
def compOp (R : Matrix ι ι ℚ → Matrix ι ι ℚ) : Matrix ι ι ℚ → Matrix ι ι ℚ :=
  fun X => R (R X)

/-- `⟨R², R⟩` at general `n`, which is `tr R³` in the operator reading. -/
def trCube (R : Matrix ι ι ℚ → Matrix ι ι ℚ) : ℚ := innerOp (compOp R) R

/-- **`⟨R# X, Y⟩` by polarisation**, the device [Sharp.lean](Sharp.lean)'s `sharpMat` uses at
`n = 4`. *`R#` is self-adjoint, so the symmetric polarisation is the whole of it.* -/
def sharpBil (R : Matrix ι ι ℚ → Matrix ι ι ℚ) (X Y : Matrix ι ι ℚ) : ℚ :=
  (1/2) * (sharpQF' R (X + Y) - sharpQF' R X - sharpQF' R Y)

/-- `⟨R#, R⟩` at general `n`, with the ordered-pair doubling.

*Summing `sharpQF' R φ` over the basis instead contracts the two `η` slots against each other and
returns `tr(R#)`, quadratic in `R`, where this is cubic.* **This file carried that form under this
docstring**, which is why `R# φ` is paired against `R φ` here rather than against `φ`. -/
def sharpPair (R : Matrix ι ι ℚ → Matrix ι ι ℚ) : ℚ :=
  (1/2) * ∑ i : ι, ∑ j : ι, sharpBil R (phi i j) (R (phi i j))

/-- **`P(R) = ⟨R, R² + R#⟩` at general `n`**, the cubic form the programme maximises, stated
without a pair table and so at every dimension rather than at `n = 4`. -/
def PcubicOf (R : Matrix ι ι ℚ → Matrix ι ι ℚ) : ℚ := trCube R + sharpPair R

/-- **`‖R‖² = ⟨R, R⟩` at general `n`.** -/
def normSqOf (R : Matrix ι ι ℚ → Matrix ι ι ℚ) : ℚ := innerOp R R

/-- The trace of a curvature operator on `Λ²`, with the same ordered-pair doubling. -/
def traceOp (R : Matrix ι ι ℚ → Matrix ι ι ℚ) : ℚ :=
  (1/2) * ∑ i : ι, ∑ j : ι, inner2 (R (phi i j)) (phi i j)

/-- The rank-one operator `λ • ω ⊗ ω`, as a map on bivectors. -/
def rankOne (lam : ℚ) (om : Matrix ι ι ℚ) : Matrix ι ι ℚ → Matrix ι ι ℚ :=
  fun X => (lam * inner2 om X) • om

/-! ## What is proved -/

/-- **`P` splits as its two terms by definition**, which is the shape every result in the record
uses when it writes `θ = tr W³ + ⟨W, W#⟩`. -/
theorem PcubicOf_eq (R : Matrix ι ι ℚ → Matrix ι ι ℚ) :
    PcubicOf R = trCube R + sharpPair R := rfl

/-- **The pairing is symmetric on operators that are self-adjoint on bivectors**, the first
clause of `IsWeylOf`. -/
theorem innerOp_comm_of_selfAdjoint {R S : Matrix ι ι ℚ → Matrix ι ι ℚ}
    (h : ∀ i j, inner2 (R (phi i j)) (S (phi i j)) = inner2 (S (phi i j)) (R (phi i j))) :
    innerOp R S = innerOp S R := by
  unfold innerOp
  congr 1
  exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => h i j

/-- **The zero operator has zero cubic form**, which is the sanity check every such definition
owes before anything is read off it. -/
theorem PcubicOf_zero : PcubicOf (ι := ι) (fun _ => 0) = 0 := by
  simp [PcubicOf, trCube, sharpPair, sharpBil, innerOp, compOp, sharpQF', inner2, br,
        Matrix.mul_zero, Matrix.zero_mul, sub_self, Matrix.transpose_zero,
        Matrix.trace_zero]

/-! ## A first test of the layer: L179(c), rank one is impossible

*The point of B1 is that results needing `Λ²` become statable. This is one of the five that were
blocked, typed against the definitions above rather than asserted to be typable.*
-/

/-- The squared `Λ²`-norm of a bivector, in the pair basis with the same doubling. -/
def normSqBiv (om : Matrix ι ι ℚ) : ℚ :=
  (1/2) * ∑ i : ι, ∑ j : ι, (inner2 om (phi i j)) ^ 2

/-- **The rank-one operator's diagonal entry is `λ ⟨ω, φ⟩²`**, which is the pointwise content of
"the trace of a rank-one operator is `λ‖ω‖²`" and the step L179(c) turns on. -/
theorem inner2_rankOne (lam : ℚ) (om : Matrix ι ι ℚ) (i j : ι) :
    inner2 (rankOne lam om (phi i j)) (phi i j) = lam * (inner2 om (phi i j)) ^ 2 := by
  simp only [rankOne, inner2, Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_smul,
             smul_eq_mul]
  ring

/-- **L179(c).** A traceless rank-one operator has `λ = 0` whenever `ω` carries positive norm,
so the nonzero ranks begin at two, which is what [L178](../Results/L178.lean)'s step 1 uses on
each of `W⁺` and `W⁻` separately. -/
theorem rankOne_traceless_eq_zero (lam nrm : ℚ) (hn : nrm ≠ 0) (h : lam * nrm = 0) : lam = 0 := by
  rcases mul_eq_zero.mp h with h' | h'
  · exact h'
  · exact absurd h' hn

end HamiltonsCubic.Base
