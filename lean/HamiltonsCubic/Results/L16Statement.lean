import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.L15Statement

/-!
# L16, the defect-penalty inequality, STATED against `Θₙ`

[problem.md](../../../findings/problem.md)'s Conjecture L16, quoted verbatim from
[results.md](../../../results.md)'s canonical statement:

> - **Conjecture L16 (lifting). The defect-penalty inequality, stated against `Θₙ`.**
>   `P ≤ Θₙ + κₙ‖Alt(W₋)‖²` for `n ≥ 12`, **restated 2026-09-04, performing the repair its
>   Gate 2 required**, since the earlier `θ₀(n)` form settled the conjecture at even `n` only.
>   *It settles the conjecture at even `n` only*: the sphere-product maximum is `Θₙ`, and at odd
>   `n` that is **strictly below** `θ₀(n)`, `Θ₁₃ = 1.2483756` against `θ₀(13) = 1.2498521`, so
>   the bound leaves a gap that shrinks and never closes. **Stating it against `Θₙ` repairs both
>   parities at no cost, the crossover `Θₙ > √(3/2)` still falling exactly at `n ≥ 12`.**
>   *Equality at the sphere product likewise fails at odd `n ≥ 13`, so "equality exactly" held
>   only at even `n`;* equality at the `ℂP²`-type competitor stands, with the penalty's sign
>   flipping exactly at `n = 6 + 2√7`. Survived adversarial falsification at `n = 12` and
>   `n = 14`.

and from [problem.md](../../../findings/problem.md)'s own block:

> With `Θₙ` the sphere-product value […] and `δ² = ‖Alt(W₋)‖²` the defect from Observation L15,
> the claim is `P(W) ≤ Θₙ + κₙδ²` on `{|W| = 1}` […] where `κₙ = 9(√(3/2) − Θₙ)` is pinned by
> requiring equality at the `ℂP²`-type competitor, whose defect is exactly `1/9` in every
> ambient dimension.

## What the `sorry` is

`L16` itself, and only it. **It is a Conjecture, not a Lemma** (the record's own label) so the
`sorry` is the open problem rather than a gap in a proof. Everything the block derives *around*
the inequality is proved below: the crossover, the sign flip, the pencil, and both equality
clauses.

## Two constants named `κₙ` collide, and they are separated here

[L13](L13Statement.lean)'s `κₙ = (n−1)(2n−1)/4` is the second moment of `L_W`; this block's `κₙ`
is the penalty coefficient `9(√(3/2) − Θₙ)`. **They are different numbers with one name**,
`κ₁₂` is `253/4 = 63.25` there and `9(√(3/2) − Θ₁₂) = −0.102` here. The penalty constant is
written `kappaPen` throughout this file, and nothing here is called `κₙ`.

## `κₙ` is pinned to `Θₙ`, and the record says so twice

[LEDGER.md](../../../findings/LEDGER.md): *"`κₙ` is pinned to `θ₀(n)` in Lemma L17 and Lemma
L134, and the repair pins L16's to `Θₙ`, a 6% split at odd `n`."* So `kappaPen` below reads
against `Θₙ`, which is what makes `equality_at_competitor` hold at **both** parities; reading it
against `θ₀(n)` is the form the audit refuted.

## The defect, and how `W₋` is pinned without a functional calculus

`δ² = ‖Alt(W₋)‖²` needs the **negative spectral part** of `W`, which the Lean layer has no
functional calculus for. `IsSpectralSplit` below characterises it instead by the four properties
that determine it: `W = W₊ − W₋`, both parts linear, symmetric and positive semidefinite on
bivectors, and `W₊ ∘ W₋ = 0`. `‖Alt(·)‖²` is
[L15Statement.lean](L15Statement.lean)'s `altNormSq`, in the record's own normalisation.

## What is NOT typed here

* **That `Θₙ` is the sphere-product maximum.** `ThetaSq` below is the closed form
  `2(n−1)(n−2)/n²` at even `n` and `2(n−1)(n−3)/((n−2)(n+1))` at odd `n`; that these are the
  values of `P` at `S^{⌊n/2⌋} × S^{⌈n/2⌉}` is the record's, and is not stated here.
* **The equality cases as attainment.** `equality_at_zero_defect` and `equality_at_competitor`
  say what the right-hand side *evaluates to* at `δ² = 0` and `δ² = 1/9`; that some Weyl tensor
  attains those values is the record's separate claim about the two named maximisers.
* **The `n = 8` refutation** of the analogous statement below the crossover.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L16Statement

-- `altNormSq`/`altCoeff` moved to `AltLayer` when L15Statement's duplicate copy was deleted;
-- opened here explicitly rather than reached through L15Statement, which no longer owns them.
open HamiltonsCubic.RealLayer HamiltonsCubic.L15Statement HamiltonsCubic.AltLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The constants -/

/-- `Θₙ²`, the square of the sphere-product value: `2(n−1)(n−2)/n²` at even `n`, where the
balanced splitting exists, and `2(n−1)(n−3)/((n−2)(n+1))` at odd `n`, the value at
`S^{(n−1)/2} × S^{(n+1)/2}`. -/
noncomputable def ThetaSq (n : ℕ) : ℝ :=
  if Even n then 2 * (n - 1) * (n - 2) / (n : ℝ) ^ 2
  else 2 * ((n : ℝ) - 1) * ((n : ℝ) - 3) / (((n : ℝ) - 2) * ((n : ℝ) + 1))

/-- `Θₙ`. -/
noncomputable def Theta (n : ℕ) : ℝ := Real.sqrt (ThetaSq n)

/-- `θ₀(n)² = 2(n−1)(n−2)/n²`, the **even-`n`** formula read at every `n`. It is `Θₙ²` at even
`n` and strictly above it at odd `n ≥ 5`. -/
noncomputable def theta0Sq (n : ℕ) : ℝ := 2 * ((n : ℝ) - 1) * ((n : ℝ) - 2) / (n : ℝ) ^ 2

/-- **The penalty coefficient**, `κₙ = 9(√(3/2) − Θₙ)`, pinned by requiring equality at the
`ℂP²`-type competitor, whose defect is `1/9`. *Named `kappaPen` because `κₙ` already denotes
[L13](L13Statement.lean)'s second moment.* -/
noncomputable def kappaPen (n : ℕ) : ℝ := 9 * (Real.sqrt (3 / 2) - Theta n)

/-! ## The negative spectral part, and the defect -/

/-- **`W = W₊ − W₋` is the spectral splitting**, characterised by the four properties that pin
it: both parts linear and symmetric on bivectors, both positive semidefinite there, and the two
parts annihilating each other. *This replaces a functional calculus the Lean layer does not
have, and it determines `W₋` uniquely.* -/
def IsSpectralSplit (W Wp Wm : Matrix ι ι ℝ → Matrix ι ι ℝ) : Prop :=
  IsLinearOp Wp ∧ IsLinearOp Wm ∧ IsSymmetricOp Wp ∧ IsSymmetricOp Wm ∧
  (∀ X, W X = Wp X - Wm X) ∧
  (∀ X, IsSkew X → 0 ≤ inner2 (Wp X) X) ∧ (∀ X, IsSkew X → 0 ≤ inner2 (Wm X) X) ∧
  (∀ X, Wp (Wm X) = 0)

/-! ## The conjecture -/

/-- **L16.** For every `n ≥ 12` and every unit Weyl tensor `W` on `ℝⁿ`, with `W₋` the negative
part of its spectral splitting,

`P(W) ≤ Θₙ + κₙ ‖Alt(W₋)‖².`

**This is a Conjecture on the record and is not proved here.** It has survived a full
adversarial battery at `n = 12` and `n = 14`; the `sorry` is that open problem. -/
theorem L16 (n : ℕ) (hn : 12 ≤ n) (hcard : Fintype.card ι = n)
    (W Wp Wm : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeyl W) (hnorm : normSq W = 1)
    (hsplit : IsSpectralSplit W Wp Wm) :
    Pcubic W ≤ Theta n + kappaPen n * altNormSq Wm := by
  sorry

/-! ## The crossover: `Θₙ > √(3/2)` exactly from `n = 12`, at both parities -/

/-- The even branch cleared: `Θₙ² > 3/2` is `n² − 12n + 8 > 0`. -/
theorem even_branch_cleared {n : ℝ} (hn : 12 ≤ n) : 3 / 2 < 2 * (n - 1) * (n - 2) / n ^ 2 := by
  rw [lt_div_iff₀ (by nlinarith : (0:ℝ) < n ^ 2)]
  nlinarith

/-- The odd branch cleared: `Θₙ² > 3/2` is `n² − 13n + 18 > 0`. -/
theorem odd_branch_cleared {n : ℝ} (hn : 12 ≤ n) :
    3 / 2 < 2 * (n - 1) * (n - 3) / ((n - 2) * (n + 1)) := by
  rw [lt_div_iff₀ (by nlinarith : (0:ℝ) < (n - 2) * (n + 1))]
  nlinarith

/-- **`Θₙ² > 3/2` at every `n ≥ 12`, both parities**, the crossover the repair leaves unmoved. -/
theorem ThetaSq_gt (n : ℕ) (hn : 12 ≤ n) : 3 / 2 < ThetaSq n := by
  have hn' : (12 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  unfold ThetaSq
  split
  · exact even_branch_cleared hn'
  · exact odd_branch_cleared hn'

/-- **And it fails at `n = 11`**: `Θ₁₁² = 40/27 < 3/2`. So `12` is the first dimension at which
the bound's constant clears the competitor, at either parity. -/
theorem ThetaSq_eleven : ThetaSq 11 = 40 / 27 ∧ ThetaSq 11 < 3 / 2 := by
  have h : ThetaSq 11 = 40 / 27 := by
    unfold ThetaSq
    rw [if_neg (by decide)]
    norm_num
  exact ⟨h, by rw [h]; norm_num⟩

/-- `Θ₁₂² = 55/36`, the even value at the first admissible dimension. -/
theorem ThetaSq_twelve : ThetaSq 12 = 55 / 36 := by
  unfold ThetaSq; rw [if_pos (by decide)]; norm_num

/-- **`Θₙ > √(3/2)` for `n ≥ 12`**, the crossover as a statement about the roots themselves. -/
theorem Theta_gt_sqrt (n : ℕ) (hn : 12 ≤ n) : Real.sqrt (3 / 2) < Theta n :=
  Real.sqrt_lt_sqrt (by norm_num) (ThetaSq_gt n hn)

/-! ## The penalty's sign, and where it flips -/

/-- **The penalty is strictly negative for `n ≥ 12`**, so above the crossover the bound
penalises all defect. -/
theorem kappaPen_neg (n : ℕ) (hn : 12 ≤ n) : kappaPen n < 0 := by
  unfold kappaPen
  nlinarith [Theta_gt_sqrt n hn]

/-- **The sign flips exactly at `n = 6 + 2√7`**, which is where the even branch's
`n² − 12n + 8` vanishes: `(n − 6)² = 28`. -/
theorem sign_flip_root : ((6 : ℝ) + 2 * Real.sqrt 7 - 6) ^ 2 = 28 := by
  have h : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
  nlinarith [h]

/-- **And `6 + 2√7` lies strictly between `11` and `12`**, which is why the integer crossover is
`n ≥ 12`. -/
theorem sign_flip_bracket : (11 : ℝ) < 6 + 2 * Real.sqrt 7 ∧ 6 + 2 * Real.sqrt 7 < 12 := by
  have h : Real.sqrt 7 ^ 2 = 7 := Real.sq_sqrt (by norm_num)
  have hpos : 0 < Real.sqrt 7 := Real.sqrt_pos.mpr (by norm_num)
  constructor <;> nlinarith [h, hpos]

/-! ## The pencil: what L16 gives, exactly -/

/-- **L16 yields `θ ≤ √(3/2)` on `{δ² ≥ 1/9}` and nowhere else**, and the condition is
`n`-free, the two bounds are a pencil hinged at `(1/9, √(3/2))`.

*Stated as an equivalence, which is what "and nowhere else" means.* -/
theorem pencil (n : ℕ) (hn : 12 ≤ n) (d : ℝ) :
    Theta n + kappaPen n * d ≤ Real.sqrt (3 / 2) ↔ 1 / 9 ≤ d := by
  have hk : kappaPen n < 0 := kappaPen_neg n hn
  have hT : Theta n = Real.sqrt (3 / 2) - kappaPen n / 9 := by unfold kappaPen; ring
  rw [hT]
  constructor
  · intro h
    nlinarith
  · intro h
    nlinarith

/-! ## The two equality clauses, as evaluations of the right-hand side -/

/-- **At zero defect the bound reads `Θₙ`**, so L16 delivers the conjecture's own constant on
the zero-defect set, with no criticality hypothesis. -/
theorem equality_at_zero_defect (n : ℕ) : Theta n + kappaPen n * 0 = Theta n := by ring

/-- **At the competitor's defect `1/9` the bound reads `√(3/2)` exactly**, this is what pins
`κₙ`, and it holds at **both** parities because `kappaPen` is read against `Θₙ`. -/
theorem equality_at_competitor (n : ℕ) :
    Theta n + kappaPen n * (1 / 9) = Real.sqrt (3 / 2) := by unfold kappaPen; ring

/-! ## Why the earlier `θ₀(n)` form failed at odd `n`: the margin is a constant `4` -/

/-- **The cleared comparison `θ₀(n)²` against `Θₙ²` at odd `n` differs by exactly `4`,
identically in `n`.** So the gap never closes, and a bound stated against `θ₀` misses the odd
family by a fixed amount rather than an asymptotic one. -/
theorem margin_is_four (n : ℝ) : (n - 2) ^ 2 * (n + 1) - n ^ 2 * (n - 3) = 4 := by ring

/-- **Hence `Θₙ < θ₀(n)` strictly at every odd `n ≥ 5`.** This is why *"equality at the sphere
product"* fails at odd `n ≥ 13` under the `θ₀` form: the sphere product does not attain `θ₀`
there. -/
theorem Theta_lt_theta0_odd {n : ℕ} (hodd : ¬ Even n) (hn : 5 ≤ n) : ThetaSq n < theta0Sq n := by
  have hn' : (5 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
  unfold ThetaSq theta0Sq
  rw [if_neg hodd]
  rw [div_lt_div_iff₀ (by nlinarith : (0:ℝ) < ((n:ℝ) - 2) * ((n:ℝ) + 1))
    (by nlinarith : (0:ℝ) < (n:ℝ) ^ 2)]
  nlinarith [margin_is_four (n : ℝ)]

/-- The witness the audit prints: at `n = 13`, `Θ₁₃² = 120/77` against `θ₀(13)² = 264/169`. -/
theorem thirteen_witness : ThetaSq 13 = 120 / 77 ∧ theta0Sq 13 = 264 / 169 := by
  constructor
  · unfold ThetaSq; rw [if_neg (by decide)]; norm_num
  · unfold theta0Sq; norm_num

/-! ## Non-vacuity -/

/-- **The zero operator is a Weyl tensor and carries a spectral splitting**, so the hypotheses of
`L16` are satisfiable and the statement is not vacuous. *It is not a point of the unit sphere;
the sphere's non-emptiness is the record's, from the named maximisers.* -/
example : IsWeyl (fun _ => 0 : Matrix ι ι ℝ → Matrix ι ι ℝ) ∧
    IsSpectralSplit (fun _ => 0 : Matrix ι ι ℝ → Matrix ι ι ℝ) (fun _ => 0) (fun _ => 0) := by
  refine ⟨⟨?_, ?_, ?_, ?_⟩, ?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro X _; simp [IsSkew]
  · intro X Y _ _; simp [inner2]
  · intro i j k l; simp [bianchi, inner2]
  · intro a b; simp [Ric, inner2]
  · exact ⟨by intro X Y; simp, by intro a X; simp⟩
  · exact ⟨by intro X Y; simp, by intro a X; simp⟩
  · intro X Y _ _; simp [inner2]
  · intro X Y _ _; simp [inner2]
  · intro X; simp
  · intro X _; simp [inner2]
  · intro X _; simp [inner2]
  · intro X; simp

end HamiltonsCubic.L16Statement
