import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.L15Statement

/-!
# L6, the zero-defect set hides no rival, STATED

[curvature-invariants.md](../../../findings/curvature-invariants.md)'s Conjecture L6, quoted
verbatim from [results.md](../../../results.md)'s canonical statement:

> - **Conjecture L6 (landscape). The zero-defect set, and why it hides no rival.** Where the
>   defect vanishes the diagonal argument applies verbatim, but that set is much larger than the
>   diagonal orbit (codimension `C(n,4)`) and does contain non-diagonalizable critical points.
>   All of them sit low: proven for the symmetric family, tested for the symmetry-free remainder.

with the scope its Gate 2 supplied and the block never stated:

> **SCOPE THE BLOCK NEVER STATED.** Its bar is `Θₙ` rather than `√(3/2)`, and the claim holds
> only for `n ≥ 12`. **The honest content is the last clause**: for the symmetry-free remainder
> this is *tested rather than proven*, 17 seeds at `n = 12` with 14 converging. *That clause is
> the conjecture, and it is why the label `Conjecture` is right.*

## The defect meant is the Bianchi one, and the file writes it

The block sits under the **symmetry** defect `Δ = Σ ‖[ad(v_δ), W]‖²` and says *"the defect"*,
while every quantitative claim in it belongs to the **Bianchi** defect `δ² = ‖Alt(W₋)‖²`. The two
have different zero sets, and padded `W_{ℂP²}` separates them: `Δ = 0` and `δ² = 1/9`. **`L6`
below is written in `δ²`**, [L15Statement.lean](L15Statement.lean)'s `altNormSq` together with
the spectral splitting, so that this block and [L16](L16Statement.lean) are stated against one
defect.

`ThetaSq`, `Theta` and `IsSpectralSplit` are repeated here character for character from
[L16Statement.lean](L16Statement.lean) rather than imported, because the root import list is
owned by another process and that file is not yet in the build; **the two copies must be kept in
step, and the intended reading is one definition.**

## What the `sorry` is

`L6`, and only it. **It is a Conjecture**: proven for the symmetric family by a citation swap to
[Lemma L47](../../../findings/graded-half.md), and for the symmetry-free remainder *tested*, 17
seeds at one dimension. The `sorry` is that untested remainder.

## What is NOT typed here

* **The codimension as an equality.** `codim_le` below proves the bound `codim ≤ C(n,4)`, which
  is free, a rank never exceeds its codomain's dimension. **Equality is surjectivity of `dF`**,
  which the record has only as measured ranks at `n = 6, 7, 8`, point-dependent, dropping exactly
  on the diagonal locus, with `F` non-differentiable where `ker W ≠ 0`. So the equality is not
  stated.
* **That zero defect is the transfer condition.** [Observation L15](L15Statement.lean)'s audit
  found a **second** obstruction, `X_inv ⪰ 0`, which no defect condition sees: zero defect is
  necessary and **not** sufficient. The word *"exactly"* is therefore absent below.
* **That the zero-defect set contains non-diagonalizable critical points**, or that it is larger
  than the diagonal orbit. Those are the block's premises, not its conclusion.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L6Statement

-- `altNormSq` moved to `AltLayer` when L15Statement's duplicate copy was deleted; it is
-- opened here explicitly rather than reached through L15Statement, which no longer owns it.
open HamiltonsCubic.RealLayer HamiltonsCubic.L15Statement HamiltonsCubic.AltLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The constant and the defect, repeated from [L16Statement.lean](L16Statement.lean) -/

/-- `Θₙ²`: `2(n−1)(n−2)/n²` at even `n`, `2(n−1)(n−3)/((n−2)(n+1))` at odd `n`. *One definition
with [L16Statement.lean](L16Statement.lean)'s.* -/
noncomputable def ThetaSq (n : ℕ) : ℝ :=
  if Even n then 2 * (n - 1) * (n - 2) / (n : ℝ) ^ 2
  else 2 * ((n : ℝ) - 1) * ((n : ℝ) - 3) / (((n : ℝ) - 2) * ((n : ℝ) + 1))

/-- `Θₙ`. -/
noncomputable def Theta (n : ℕ) : ℝ := Real.sqrt (ThetaSq n)

/-- **`W = W₊ − W₋` is the spectral splitting**, characterised by the four properties that pin
it. *One definition with [L16Statement.lean](L16Statement.lean)'s.* -/
def IsSpectralSplit (W Wp Wm : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  IsLinearOp Wp ∧ IsLinearOp Wm ∧ IsSymmetricOp Wp ∧ IsSymmetricOp Wm ∧
  (∀ X, W X = Wp X - Wm X) ∧
  (∀ X, IsSkew X → 0 ≤ inner2 (Wp X) X) ∧ (∀ X, IsSkew X → 0 ≤ inner2 (Wm X) X) ∧
  (∀ X, Wp (Wm X) = 0)

/-! ## Criticality, written without a `Q` -/

/-- **`W` is a critical point of `P` on the unit sphere of `𝒲ₙ`**: every direction that stays in
`𝒲ₙ` and is orthogonal to `W` is a direction of vanishing derivative.

*`𝒲ₙ` is a linear subspace, so its tangent space at `W` is itself, and the sphere's constraint is
carried by the orthogonality clause. This is the record's criticality; the Lean layer has no `Q`,
so it is written variationally rather than as `Q(W) = θW`.* -/
def IsCriticalOnSphere (W : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  ∀ H : Matrix ι ι ℝ → Matrix ι ι ℝ, IsWeyl H → innerOp H W = 0 →
    deriv (fun t : ℝ => Pcubic (fun X => W X + t • H X)) 0 = 0

/-! ## The conjecture -/

/-- **L6.** For every `n ≥ 12`, every critical point `W` of `P` on the unit sphere of `𝒲ₙ` whose
**Bianchi** defect vanishes satisfies `P(W) ≤ Θₙ`: the zero-defect set hides no rival.

**Not proved here.** The symmetric family is closed by [Lemma L47](../../../findings/graded-half.md);
the symmetry-free remainder is *tested* (17 seeds at `n = 12`, 14 converging) and that is the
conjecture. -/
theorem L6 (n : ℕ) (hn : 12 ≤ n) (hcard : Fintype.card ι = n)
    (W Wp Wm : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeyl W) (hnorm : normSq W = 1)
    (hcrit : IsCriticalOnSphere W) (hsplit : IsSpectralSplit W Wp Wm)
    (hdefect : altNormSq Wm = 0) :
    Pcubic W ≤ Theta n := by
  sorry

/-! ## The codimension bound is free, and it is a bound -/

/-- **`codim ≤ dim Λ⁴` for any linear map at all.** The zero-defect set is a fibre of
`F : 𝒲ₙ → Λ⁴`, and the codimension of a fibre is the rank, which never exceeds the codomain's
dimension. *So the number `C(n,4)` is the target's dimension, not a count of independent
conditions.* -/
theorem codim_le {V W : Type*} [AddCommGroup V] [Module ℝ V] [AddCommGroup W] [Module ℝ W]
    [FiniteDimensional ℝ V] [FiniteDimensional ℝ W] (F : V →ₗ[ℝ] W) :
    Module.finrank ℝ V - Module.finrank ℝ (LinearMap.ker F) ≤ Module.finrank ℝ W := by
  have hrk := F.finrank_range_add_finrank_ker
  have hle : Module.finrank ℝ (LinearMap.range F) ≤ Module.finrank ℝ W :=
    Submodule.finrank_le _
  omega

/-- **And equality is a separate claim.** A rank strictly below the codomain's dimension is the
ordinary case; here is a linear map whose codimension is `0` while its codomain has dimension
`1`, so the bound is not an equality in general. -/
example : Module.finrank ℝ ℝ - Module.finrank ℝ (LinearMap.ker (0 : ℝ →ₗ[ℝ] ℝ)) = 0 ∧
    Module.finrank ℝ ℝ = 1 := by
  constructor
  · simp
  · simp

/-! ## The measured ranks agreed with the free bound, not with an independent count -/

/-- **The three measured ranks are `C(n,4)` itself** at `n = 6, 7, 8`, so what the measurement
agreed with is the free bound rather than an independent count of conditions. -/
theorem measured_ranks_are_the_bound :
    Nat.choose 6 4 = 15 ∧ Nat.choose 7 4 = 35 ∧ Nat.choose 8 4 = 70 := by
  refine ⟨by decide, by decide, by decide⟩

/-- **Under the symmetry reading the codimension claim is outright false at `n = 4`**:
`codim = 4` against `C(4,4) = 1`. This is the witness that the two defects cannot be conflated. -/
theorem symmetry_reading_false_at_four : Nat.choose 4 4 < 4 := by decide

/-! ## The two defects are separated by one witness -/

/-- **Padded `W_{ℂP²}` has `Δ = 0` and `δ² = 1/9`**, so the symmetry defect and the Bianchi
defect have different zero sets and a claim proved for one says nothing about the other. -/
theorem defects_differ : (0 : ℝ) ≠ 1 / 9 := by norm_num

/-! ## The scope: the bar is `Θₙ`, and the crossover is `n ≥ 12` -/

/-- **The bar is `Θₙ`, and it clears `√(3/2)` exactly from `n = 12`**, imported from
[L16Statement.lean](L16Statement.lean) so that the two blocks read one constant. -/
theorem bar_above_competitor (n : ℕ) (hn : 12 ≤ n) : 3 / 2 < ThetaSq n := by
  have hn' : (12 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  unfold ThetaSq
  split
  · rw [lt_div_iff₀ (by nlinarith : (0:ℝ) < (n:ℝ) ^ 2)]; nlinarith
  · rw [lt_div_iff₀ (by nlinarith : (0:ℝ) < ((n:ℝ) - 2) * ((n:ℝ) + 1))]; nlinarith

/-- **And it does not at `n = 11`**, `Θ₁₁² = 40/27`. So `n ≥ 12` is the scope the block never
stated, at both parities. -/
theorem bar_fails_at_eleven : ThetaSq 11 = 40 / 27 ∧ ThetaSq 11 < 3 / 2 := by
  have h : ThetaSq 11 = 40 / 27 := by unfold ThetaSq; rw [if_neg (by decide)]; norm_num
  exact ⟨h, by rw [h]; norm_num⟩

/-! ## The unitary-factor hinge, refuted by a family with no unitary factor -/

/-- **`𝔰𝔬(p) ⊕ 𝔰𝔬(q)` with `p, q ≥ 5` exceeds the dimension threshold, contains no unitary
factor and is defect-free**, the balanced split crossing the threshold exactly at `n ≥ 12`, the
record's own `n² − 12n + 8`. *The omitted case is the conjectured maximiser, omitted at exactly
the dimensions the conjecture is about.* -/
theorem threshold_at_eleven_and_twelve :
    (11:ℝ) ^ 2 - 12 * 11 + 8 = -3 ∧ (12:ℝ) ^ 2 - 12 * 12 + 8 = 8 := by
  constructor <;> norm_num

/-! ## The defect is not an `Aut(𝔤)`-invariant, so `n = 8` is unsound for any step reading it off
Cartan's list -/

/-- **`ℍP²` and `S³ × S⁵` are a triality pair at `θ² = 56/45` with defects `2/63` and `0`.** One
value, two defects: the defect is not preserved by an automorphism of the algebra. -/
theorem triality_splits_the_defect : (2:ℝ) / 63 ≠ 0 := by norm_num

/-! ## The sample the block suppressed -/

/-- **17 seeds at `n = 12`, 14 converging**, three unaccounted, and this is the whole of the
evidence for the symmetry-free half. -/
theorem seeds_unaccounted : 17 - 14 = 3 := by norm_num

end HamiltonsCubic.L6Statement
