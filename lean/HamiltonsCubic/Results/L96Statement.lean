import Mathlib
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L96, REFUTED as stated: the 2-class scheme maximises at `θ₀(n)`, and not **only** at `K_{n/2,n/2}`

**The record's statement, quoted verbatim from [diagonal-half.md](../../../findings/diagonal-half.md):**

> #### Lemma L96, REFUTED as stated: at even $n$ the weighted 2-class scheme maximises at $\theta_0(n)$, and not only at $K_{n/2,n/2}$
>
> **Maximising over every feasible parameter set gives exactly $\theta_0(n)$, attained only at $(k,\lambda,\mu)=(n/2,0,n/2)$ (the complete bipartite $K_{n/2,n/2}$, which is the balanced two-block sphere product**), at every even $n$ from $6$ to $24$, matching $\theta_0$ to nine digits each time.
>
> The enumeration runs over parameter sets satisfying integrality and $k(k-\lambda-1)=(n-k-1)\mu$, a **superset** of the realisable strongly regular graphs, so the bound holds a fortiori.
>
> **THE PARITY QUALIFIER WAS LOST BY THE NUMBERING COMMIT.** … **At $n=9$ the true family maximum is $0.7698$ against $\theta_0(9)=1.1759$.**
>
> **"ONLY AT" IS REFUTED, WITH A WITNESS THE RECORD ALREADY HOLDS.** $\theta$ is complement-invariant, so **$2K_{n/2}$ attains $\theta_0$ at every even $n$**, $\mathrm{SRG}(6,2,1,0)$ at $n=6$, and $(12,5,4,0)$ screening to $1.236033$ with integral multiplicities.
>
> **THE "SUPERSET, SO A FORTIORI" STEP IS FALSE.** $(k,k-1,0)$ lies in the stated superset for every $k$ and gives $\theta=\sqrt n\,\theta_0(n)$ at $k=n-2$, witnesses $(6,3,2,0)\to1.581139$ and $(24,22,21,0)\to6.493587$. **The hypothesis that actually works is multiplicity integrality $f,g\in\mathbb Z_{\ge0}$, and it is never named.**
>
> **THE CLOSED FORM IS ALREADY ON THE RECORD, 130 LINES BELOW, IN THIS FILE.** … $\theta(n,k,\lambda,\mu)=\lvert1+\lambda-\mu\rvert\sqrt{2(n-1)/(n\,k\,(n-1-k))}$ … *Under the block's own positive root, $K_{n/2,n/2}$ returns $-\theta_0$, as written, its named maximiser is the minimiser.*

## What this file states

The refutation, in the closed form the audit supplies, at a **real** parameter `n` so nothing rests
on a tabulated range, **and the scheme itself as an object of the diagonal locus**.

* `balanced_attains`, `θ(n, n/2, 0, n/2) = θ₀(n)`: the named maximiser does attain the value.
* `complement_attains`, `θ(n, n/2-1, n/2-2, 0) = θ₀(n)` **as well**. This is `2K_{n/2}`, the
  complement, and it refutes *"only at"* at every `n > 2` rather than at the two tabulated ones.
* `feasible_*`, all three parameter sets satisfy `k(k-λ-1) = (n-k-1)μ`, so all three lie in the
  block's own enumeration superset.
* `superset_exceeds`, `θ(n, n-2, n-3, 0) = √n · θ₀(n)`, strictly above `θ₀(n)` for `n > 1`, with
  the two printed witnesses `(6,3,2,0) → √10/2` and `(24,22,21,0) → 6.493587` checked to their
  printed digits. **So "superset, so a fortiori" is false**: the superset's maximum is not `θ₀`.
* `unsigned_root_gives_minus_theta0`, dropping the absolute value sends the named maximiser to
  `-θ₀(n)`, the audit's *"its named maximiser is the minimiser"*.
* `nine_*`, `θ₀(9) = √112/9 = 1.17591…`, and the recorded family maximum `0.7698` at `n = 9` lies
  below it, so the heading's unqualified claim fails at odd `n`.

**The convention.** `θ₀(n)² = 2(n-1)(n-2)/n²`, which is the record's `θ₀(n) = ((n-1)/n)√(2(n-2)/(n-1))`
proved equal in `theta0_sq`, and it is the normalisation
[conventions.md](../../../findings/conventions.md) fixes for `θ`. No factor is chosen here.

## The scheme, now that the diagonal locus is built

* `twoClass`, `M = αA + β(J - I - A)` verbatim, and `IsSRG` the scheme identity
  `A² = kI + λA + μ(J-I-A)` with `A` a symmetric hollow `0/1` matrix of degree `k`.
* `IsSRG.feasible`, **the enumeration's constraint is a theorem about realisable schemes**:
  `k(k-λ-1) = (n-k-1)μ` follows by summing a row of the scheme identity. Together with
  `feasible_kk1` this is exactly the audit's *"superset"*, with both inclusions typed.
* `cycle5_isSRG`, the 5-cycle is `SRG(5,2,0,1)`, so `IsSRG` is not vacuous.
* `twoClass_isWeight` and `twoClass_isWeyl`, under the row-sum condition `kα + (n-1-k)β = 0` the
  scheme is a weight in `𝒟ₙ` and its operator is a **Weyl operator**, so the block's parameter
  sets name genuine competitors.
* `twoClass_normSq`, `twoClass_totalPow`, `twoClass_diagP`, `‖M‖² = ½n(kα²+(n-1-k)β²)` and the
  block's display `θ = ½[n(kα³+(n-1-k)β³) + tr M³]`, as identities.
* `twoClass_eigen` and `twoClass_kernel`, `M`'s eigenvalues are `0` on `𝟙` and `αr - β(1+r)` on
  `𝟙^⊥`, verbatim from the block.
* `twoClass_diagP_abs` and `twoClass_theta_abs`, **the closed form as the value of `θ` at the
  scheme**, `|θ| = |1+λ-μ|√(2(n-1)/(nk(n-1-k)))`. The absolute value is the audit's *"its named
  maximiser is the minimiser"*: the row-sum condition leaves the sign of `(α,β)` free and `θ` is
  odd in it.

**`twoClass_diagP_abs` is proved (2026-09-24), and it needs no multiplicities**: `span{I, A, J}` is
closed under products (`prod3`), so `tr M³` is a polynomial in `(n, k, λ, μ, α, β)`. *The earlier
text here called the multiplicities `f, g` the missing hypothesis; they are determined by
`(n, k, λ, μ)` and never enter.* `Pcubic` on the locus is [Families.lean](../Base/Families.lean)'s
`DiagCubicFormula`, PROVED in [SharpDiag.lean](../Base/SharpDiag.lean). The file carries no `sorry`.

## What is NOT typed here

* **The enumeration itself**, *"maximising over every feasible parameter set gives exactly
  `θ₀(n)`"*. The audit records that this is a finite check at `6 ≤ n ≤ 24` with no proof and no
  script. Nothing here asserts the maximisation.
* **That `K_{n/2,n/2}` and `2K_{n/2}` are realisable schemes.** `balanced_attains` and
  `complement_attains` are statements about the closed form at those parameters; no adjacency
  matrix realising them is constructed, so they are not instantiations of `twoClass_theta_abs`.
* **The `n = 9` family maximum `0.7698`** is a measured number; only its comparison with `θ₀(9)`
  is checked.
-/

namespace HamiltonsCubic.L96Statement

open Real

/-! ## The two closed forms -/

/-- `θ₀(n) = ((n-1)/n)·√(2(n-2)/(n-1))`, the record's conjectured value. -/
noncomputable def theta0 (n : ℝ) : ℝ := ((n - 1) / n) * Real.sqrt (2 * (n - 2) / (n - 1))

/-- **L144's closed form**, `θ(n,k,λ,μ) = |1+λ-μ|·√(2(n-1)/(n·k·(n-1-k)))`. -/
noncomputable def thetaSRG (n k lam mu : ℝ) : ℝ :=
  |1 + lam - mu| * Real.sqrt (2 * (n - 1) / (n * k * (n - 1 - k)))

/-- The feasibility relation the block's enumeration runs over. -/
def Feasible (n k lam mu : ℝ) : Prop := k * (k - lam - 1) = (n - k - 1) * mu

private theorem abs_mul_sqrt (c r : ℝ) :
    |c| * Real.sqrt r = Real.sqrt (c ^ 2 * r) := by
  rw [Real.sqrt_mul (sq_nonneg c), Real.sqrt_sq_eq_abs]

/-- **`θ₀(n) = √(2(n-1)(n-2)/n²)`**, the form every comparison below is made in. -/
theorem theta0_sq {n : ℝ} (hn : 2 < n) :
    theta0 n = Real.sqrt (2 * (n - 1) * (n - 2) / n ^ 2) := by
  have hn0 : (0:ℝ) < n := by linarith
  have hn1 : (0:ℝ) < n - 1 := by linarith
  have hfrac : (0:ℝ) < (n - 1) / n := div_pos hn1 hn0
  have hrw : 2 * (n - 1) * (n - 2) / n ^ 2 = ((n - 1) / n) ^ 2 * (2 * (n - 2) / (n - 1)) := by
    field_simp
  rw [theta0, hrw, Real.sqrt_mul (sq_nonneg _), Real.sqrt_sq hfrac.le]

/-! ## The named maximiser attains `θ₀` -/

/-- `K_{n/2,n/2}` is in the enumeration superset. -/
theorem feasible_balanced (n : ℝ) : Feasible n (n / 2) 0 (n / 2) := by
  unfold Feasible; ring

/-- **`θ(n, n/2, 0, n/2) = θ₀(n)`.** -/
theorem balanced_attains {n : ℝ} (hn : 2 < n) : thetaSRG n (n / 2) 0 (n / 2) = theta0 n := by
  have hnp : (0:ℝ) < n := by linarith
  have hA : (0:ℝ) < n * (n / 2) * (n - 1 - n / 2) := by
    refine mul_pos (mul_pos hnp (by linarith)) (by linarith)
  have hB : ((n:ℝ) ^ 2) ≠ 0 := by positivity
  rw [thetaSRG, abs_mul_sqrt, theta0_sq hn]
  congr 1
  rw [show (1 + 0 - n / 2) ^ 2 * (2 * (n - 1) / (n * (n / 2) * (n - 1 - n / 2)))
      = ((1 + 0 - n / 2) ^ 2 * (2 * (n - 1))) / (n * (n / 2) * (n - 1 - n / 2)) by ring]
  rw [div_eq_div_iff (ne_of_gt hA) hB]
  ring

/-! ## …AND SO DOES ITS COMPLEMENT, which refutes *"only at"* -/

/-- `2K_{n/2} = SRG(n, n/2-1, n/2-2, 0)` is in the enumeration superset too. -/
theorem feasible_complement (n : ℝ) : Feasible n (n / 2 - 1) (n / 2 - 2) 0 := by
  unfold Feasible; ring

/-- **`θ(n, n/2-1, n/2-2, 0) = θ₀(n)`**, `θ` is complement-invariant, so the disjoint union of
two complete graphs on `n/2` vertices attains the same value. **This is the refutation of
*"attained only at `K_{n/2,n/2}`"***, and it holds at every `n > 2`, not only at the two `n` the
record exhibits. -/
theorem complement_attains {n : ℝ} (hn : 2 < n) :
    thetaSRG n (n / 2 - 1) (n / 2 - 2) 0 = theta0 n := by
  have hnp : (0:ℝ) < n := by linarith
  have hA : (0:ℝ) < n * (n / 2 - 1) * (n - 1 - (n / 2 - 1)) := by
    refine mul_pos (mul_pos hnp (by linarith)) (by linarith)
  have hB : ((n:ℝ) ^ 2) ≠ 0 := by positivity
  rw [thetaSRG, abs_mul_sqrt, theta0_sq hn]
  congr 1
  rw [show (1 + (n / 2 - 2) - 0) ^ 2 * (2 * (n - 1) / (n * (n / 2 - 1) * (n - 1 - (n / 2 - 1))))
      = ((1 + (n / 2 - 2) - 0) ^ 2 * (2 * (n - 1))) / (n * (n / 2 - 1) * (n - 1 - (n / 2 - 1))) by ring]
  rw [div_eq_div_iff (ne_of_gt hA) hB]
  ring

/-- **The two witnesses the record already holds**: `SRG(6,2,1,0)` and `(12,5,4,0)`, both attaining
`θ₀`. The second is the `1.236033` the audit prints. -/
theorem complement_witnesses :
    thetaSRG 6 2 1 0 = theta0 6 ∧ thetaSRG 12 5 4 0 = theta0 12 := by
  constructor
  · have h := complement_attains (n := 6) (by norm_num)
    norm_num at h ⊢
    exact h
  · have h := complement_attains (n := 12) (by norm_num)
    norm_num at h ⊢
    exact h

theorem theta0_twelve_sq : theta0 12 ^ 2 = 220 / 144 := by
  rw [theta0_sq (by norm_num), Real.sq_sqrt (by norm_num)]
  norm_num

theorem theta0_pos {n : ℝ} (hn : 2 < n) : 0 < theta0 n := by
  rw [theta0_sq hn]
  refine Real.sqrt_pos.mpr (div_pos (by nlinarith) (by nlinarith))

theorem theta0_twelve_decimal : |theta0 12 - 1.236033| < 1e-6 := by
  have h := theta0_twelve_sq
  have hpos := theta0_pos (n := 12) (by norm_num)
  rw [abs_lt]
  constructor <;> nlinarith [h, hpos]

/-! ## The "superset, so a fortiori" step is false -/

/-- The family `(k, k-1, 0)` is feasible for **every** `k`, which is what puts it in the block's
superset. -/
theorem feasible_kk1 (n k : ℝ) : Feasible n k (k - 1) 0 := by
  unfold Feasible; ring

/-- **`θ(n, n-2, n-3, 0) = √n · θ₀(n)`**, the superset's value at `k = n-2`. -/
theorem superset_value {n : ℝ} (hn : 2 < n) :
    thetaSRG n (n - 2) (n - 3) 0 = Real.sqrt n * theta0 n := by
  have hn0 : (0:ℝ) < n := by linarith
  have hA : (0:ℝ) < n * (n - 2) * (n - 1 - (n - 2)) := by
    refine mul_pos (mul_pos hn0 (by linarith)) (by linarith)
  have hB : ((n:ℝ) ^ 2) ≠ 0 := by positivity
  rw [thetaSRG, abs_mul_sqrt, theta0_sq hn, ← Real.sqrt_mul hn0.le]
  congr 1
  rw [show (1 + (n - 3) - 0) ^ 2 * (2 * (n - 1) / (n * (n - 2) * (n - 1 - (n - 2))))
      = ((1 + (n - 3) - 0) ^ 2 * (2 * (n - 1))) / (n * (n - 2) * (n - 1 - (n - 2))) by ring]
  rw [show n * (2 * (n - 1) * (n - 2) / n ^ 2) = (n * (2 * (n - 1) * (n - 2))) / n ^ 2 by ring]
  rw [div_eq_div_iff (ne_of_gt hA) hB]
  ring

/-- **And `√n · θ₀(n) > θ₀(n)` for `n > 2`**, so the maximum over the superset is strictly above
`θ₀`: the *"a fortiori"* step of the enumeration does not hold. -/
theorem superset_exceeds {n : ℝ} (hn : 2 < n) : theta0 n < thetaSRG n (n - 2) (n - 3) 0 := by
  have hpos := theta0_pos hn
  have hsn : 1 < Real.sqrt n := by
    rw [show (1:ℝ) = Real.sqrt 1 by simp]
    exact Real.sqrt_lt_sqrt (by norm_num) (by linarith)
  rw [superset_value hn]
  nlinarith

/-- **The first printed witness**, `(6,3,2,0) → √10/2 = 1.581139…`, a member of `(k,k-1,0)` at
`k = 3`, feasible, and above `θ₀(6)`. -/
theorem witness_six_value : thetaSRG 6 3 2 0 = Real.sqrt 10 / 2 := by
  rw [thetaSRG, abs_mul_sqrt]
  rw [show ((1:ℝ) + 2 - 0) ^ 2 * (2 * (6 - 1) / (6 * 3 * (6 - 1 - 3))) = 10 * (1/2) ^ 2 by norm_num]
  rw [Real.sqrt_mul (by norm_num), Real.sqrt_sq (by norm_num)]
  ring

theorem witness_six_decimal : |thetaSRG 6 3 2 0 - 1.581139| < 1e-6 := by
  have hval := witness_six_value
  have hsq : Real.sqrt 10 ^ 2 = 10 := Real.sq_sqrt (by norm_num)
  have hpos : 0 < Real.sqrt 10 := Real.sqrt_pos.mpr (by norm_num)
  rw [hval, abs_lt]
  constructor <;> nlinarith [hsq, hpos]

/-- **The second printed witness**, `(24,22,21,0) → 6.493587`, at `k = n-2 = 22`. -/
theorem witness_twentyfour_sq : thetaSRG 24 22 21 0 ^ 2 = 22264 / 528 := by
  rw [thetaSRG, abs_mul_sqrt, Real.sq_sqrt (by norm_num)]
  norm_num

theorem witness_twentyfour_decimal : |thetaSRG 24 22 21 0 - 6.493587| < 1e-6 := by
  have hsq := witness_twentyfour_sq
  have hpos : 0 < thetaSRG 24 22 21 0 := by
    rw [thetaSRG, abs_mul_sqrt]
    exact Real.sqrt_pos.mpr (by norm_num)
  rw [abs_lt]
  constructor <;> nlinarith [hsq, hpos]

/-! ## The unsigned root sends the named maximiser to `-θ₀` -/

/-- **`(1+λ-μ) < 0` at `K_{n/2,n/2}` for `n > 2`**, so dropping the absolute value from the closed
form returns `-θ₀(n)` there: *"as written, its named maximiser is the minimiser"*. -/
theorem unsigned_root_gives_minus_theta0 {n : ℝ} (hn : 2 < n) :
    (1 + 0 - n / 2) * Real.sqrt (2 * (n - 1) / (n * (n / 2) * (n - 1 - n / 2))) = -theta0 n := by
  have hneg : (1 : ℝ) + 0 - n / 2 = -(n / 2 - 1) := by ring
  have habs : |(1 : ℝ) + 0 - n / 2| = n / 2 - 1 := by
    rw [hneg, abs_neg, abs_of_pos (by linarith)]
  have h := balanced_attains hn
  rw [thetaSRG, habs] at h
  rw [hneg]
  linarith [h]

/-! ## Odd `n`: the heading asserts a maximum the locus does not attain -/

/-- `θ₀(9)² = 112/81`, whose root is the `1.1759` the audit prints. -/
theorem theta0_nine_sq : theta0 9 ^ 2 = 112 / 81 := by
  rw [theta0_sq (by norm_num), Real.sq_sqrt (by norm_num)]
  norm_num

theorem theta0_nine_decimal : |theta0 9 - 1.1759| < 1e-4 := by
  have h := theta0_nine_sq
  have hpos := theta0_pos (n := 9) (by norm_num)
  rw [abs_lt]
  constructor <;> nlinarith [h, hpos]

/-- **The recorded family maximum at `n = 9` is below `θ₀(9)`**, so the heading, which drops the
parity qualifier the body carried, asserts a maximum above what the odd locus attains. -/
theorem nine_family_max_below : (0.7698 : ℝ) < theta0 9 := by
  have h := theta0_nine_sq
  have hpos := theta0_pos (n := 9) (by norm_num)
  nlinarith [h, hpos]

/-- **And at odd `n` the balanced parameter set is not integral**: `k = n/2` is not a natural
number, so `K_{n/2,n/2}` is not in the family at all. -/
theorem odd_no_balanced (m : ℕ) : ¬ ∃ k : ℕ, (k : ℝ) = (2 * m + 1 : ℝ) / 2 := by
  rintro ⟨k, hk⟩
  have h2 : (2 * k : ℝ) = 2 * (m : ℝ) + 1 := by
    rw [hk]; ring
  have hnat : 2 * k = 2 * m + 1 := by exact_mod_cast h2
  omega

/-! ## The 2-class scheme as an object of the diagonal locus

*[Families.lean](../Base/Families.lean) builds `𝒟ₙ`, `diagOp`, `IsWeight`, the weighted-graph
functional `diagP`, so `M = αA + β(J-I-A)` is nameable here, and the closed form above stops
being a definition standing on its own.*
-/

section TwoClass

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The all-ones matrix `J`. -/
def Jmat (ι : Type*) [Fintype ι] : Matrix ι ι ℝ := Matrix.of fun _ _ => 1

/-- **`M = αA + β(J - I - A)`**, the record's weighted 2-class scheme, verbatim. -/
def twoClass (A : Matrix ι ι ℝ) (al be : ℝ) : Matrix ι ι ℝ :=
  al • A + be • (Jmat ι - 1 - A)

theorem twoClass_apply (A : Matrix ι ι ℝ) (al be : ℝ) (a b : ι) :
    twoClass A al be a b = al * A a b + be * (1 - (if a = b then (1:ℝ) else 0) - A a b) := by
  simp [twoClass, Jmat, Matrix.one_apply]

/-- **`A` IS AN `SRG(n,k,λ,μ)`**: a symmetric hollow `0/1` matrix, `k`-regular, whose square meets
the scheme identity `A² = kI + λA + μ(J-I-A)`. -/
structure IsSRG (A : Matrix ι ι ℝ) (k lam mu : ℝ) : Prop where
  symm : ∀ a b, A a b = A b a
  hollow : ∀ a, A a a = 0
  binary : ∀ a b, A a b = 0 ∨ A a b = 1
  regular : ∀ a, ∑ c : ι, A a c = k
  scheme : A * A = k • (1 : Matrix ι ι ℝ) + lam • A + mu • (Jmat ι - 1 - A)

/-- **THE ENUMERATION'S CONSTRAINT IS A THEOREM ABOUT REALISABLE SCHEMES.** `k(k-λ-1) =
(n-k-1)μ` follows from the scheme identity by summing a row, so every `SRG(n,k,λ,μ)` is
`Feasible`. *This is the direction that makes the block's set a **superset**; `feasible_kk1`
above is the direction that makes it a strict one.* -/
theorem IsSRG.feasible [Nonempty ι] {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) :
    Feasible (Fintype.card ι : ℝ) k lam mu := by
  have hL : ∀ a : ι, ∑ b : ι, (A * A) a b = k * k := by
    intro a
    simp only [Matrix.mul_apply]
    rw [Finset.sum_comm]
    rw [Finset.sum_congr rfl fun c (_ : c ∈ Finset.univ) => by
      rw [← Finset.mul_sum, h.regular c]]
    rw [← Finset.sum_mul, h.regular a]
  have hR : ∀ a : ι, ∑ b : ι,
      (k • (1 : Matrix ι ι ℝ) + lam • A + mu • (Jmat ι - 1 - A)) a b
        = k + lam * k + mu * ((Fintype.card ι : ℝ) - 1 - k) := by
    intro a
    have hpt : ∀ b : ι, (k • (1 : Matrix ι ι ℝ) + lam • A + mu • (Jmat ι - 1 - A)) a b
        = k * (if a = b then (1:ℝ) else 0) + lam * A a b
          + mu * (1 - (if a = b then (1:ℝ) else 0) - A a b) := by
      intro b; simp [Jmat, Matrix.one_apply]
    rw [Finset.sum_congr rfl fun b _ => hpt b, Finset.sum_add_distrib, Finset.sum_add_distrib,
      ← Finset.mul_sum, ← Finset.mul_sum, ← Finset.mul_sum]
    rw [h.regular a, Finset.sum_sub_distrib, Finset.sum_sub_distrib, h.regular a]
    simp
  have hkey : k * k = k + lam * k + mu * ((Fintype.card ι : ℝ) - 1 - k) := by
    obtain ⟨a⟩ := ‹Nonempty ι›
    rw [← hL a, h.scheme, hR a]
  unfold Feasible
  linear_combination hkey

/-! ### The hypotheses are satisfiable -/

/-- The 5-cycle. -/
def cycle5 : Matrix (Fin 5) (Fin 5) ℝ :=
  !![0,1,0,0,1; 1,0,1,0,0; 0,1,0,1,0; 0,0,1,0,1; 1,0,0,1,0]

/-- **A NONZERO WITNESS FOR `IsSRG`**: the 5-cycle is `SRG(5,2,0,1)`. *So the scheme identity is
satisfiable at a genuine strongly regular graph and not only at the degenerate `A = 0`.* -/
theorem cycle5_isSRG : IsSRG cycle5 2 0 1 := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩
  · intro a b; fin_cases a <;> fin_cases b <;> simp [cycle5]
  · intro a; fin_cases a <;> simp [cycle5]
  · intro a b; fin_cases a <;> fin_cases b <;> simp [cycle5]
  · intro a; fin_cases a <;> simp [cycle5, Fin.sum_univ_five] <;> norm_num
  · ext i j
    fin_cases i <;> fin_cases j <;>
      simp [cycle5, Jmat, Matrix.mul_apply, Fin.sum_univ_five] <;> norm_num

/-- **AND IT IS `Feasible`**, by `IsSRG.feasible` rather than by arithmetic, `2(2-0-1) =
(5-2-1)·1`. -/
theorem cycle5_feasible : Feasible 5 2 0 1 := by
  have h := cycle5_isSRG.feasible
  simpa using h


/-! ### The scheme is a point of `𝒟ₙ` -/

theorem twoClass_symm {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) (al be : ℝ)
    (a b : ι) : twoClass A al be a b = twoClass A al be b a := by
  rw [twoClass_apply, twoClass_apply, h.symm a b]
  by_cases hab : a = b
  · subst hab; rfl
  · simp [hab, Ne.symm hab]

theorem twoClass_hollow {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) (al be : ℝ)
    (a : ι) : twoClass A al be a a = 0 := by
  rw [twoClass_apply, h.hollow a]; simp

/-- **EVERY POSITIVE POWER OF THE WEIGHT IS AGAIN A 2-CLASS PATTERN**: `M_{ab}^p = α^p A_{ab} +
β^p (J-I-A)_{ab}`, because the two classes are `0/1` indicators of disjoint edge sets. -/
theorem twoClass_pow {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) (al be : ℝ)
    {p : ℕ} (hp : p ≠ 0) (a b : ι) :
    (twoClass A al be a b) ^ p
      = al ^ p * A a b + be ^ p * (1 - (if a = b then (1:ℝ) else 0) - A a b) := by
  rw [twoClass_apply]
  by_cases hab : a = b
  · subst hab; rw [h.hollow a]; simp [zero_pow hp]
  · rcases h.binary a b with h0 | h1
    · rw [h0]; simp [hab]
    · rw [h1]; simp [hab]

theorem twoClass_rowPow {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) (al be : ℝ)
    {p : ℕ} (hp : p ≠ 0) (a : ι) :
    ∑ b : ι, (twoClass A al be a b) ^ p
      = al ^ p * k + be ^ p * ((Fintype.card ι : ℝ) - 1 - k) := by
  rw [Finset.sum_congr rfl fun b _ => twoClass_pow h al be hp a b, Finset.sum_add_distrib,
    ← Finset.mul_sum, ← Finset.mul_sum, h.regular a, Finset.sum_sub_distrib,
    Finset.sum_sub_distrib, h.regular a]
  simp

/-- **`∑_{a,b} M_{ab}^p = n(kα^p + (n-1-k)β^p)`**, the shape both the norm and the cube sum take. -/
theorem twoClass_totalPow {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) (al be : ℝ)
    {p : ℕ} (hp : p ≠ 0) :
    ∑ a : ι, ∑ b : ι, (twoClass A al be a b) ^ p
      = (Fintype.card ι : ℝ) * (al ^ p * k + be ^ p * ((Fintype.card ι : ℝ) - 1 - k)) := by
  rw [Finset.sum_congr rfl fun a _ => twoClass_rowPow h al be hp a]
  simp [Finset.sum_const, Finset.card_univ, mul_comm]
  ring

/-- **RICCI-FLATNESS ON THE LOCUS FIXES `β` FROM `α`**: the zero-row-sum condition is
`kα + (n-1-k)β = 0`, and under it the scheme is a weight in `𝒟ₙ`. -/
theorem twoClass_isWeight {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) {al be : ℝ}
    (hrow : al * k + be * ((Fintype.card ι : ℝ) - 1 - k) = 0) : IsWeight (twoClass A al be) where
  symm := twoClass_symm h al be
  hollow := twoClass_hollow h al be
  rowSum a := by
    have h1 := twoClass_rowPow h al be (p := 1) one_ne_zero a
    simp only [pow_one] at h1
    rw [h1, hrow]

/-- **SO THE SCHEME IS A WEYL OPERATOR**, a genuine competitor rather than a parameter set. -/
theorem twoClass_isWeyl {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) {al be : ℝ}
    (hrow : al * k + be * ((Fintype.card ι : ℝ) - 1 - k) = 0) : IsWeyl (diagOp (twoClass A al be)) :=
  diagOp_isWeyl (twoClass_isWeight h hrow)

/-- **`‖M‖² = ½ n(kα² + (n-1-k)β²)`**, the norm condition the block says fixes `α, β` with the
row sums. -/
theorem twoClass_normSq {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) (al be : ℝ) :
    normSq (diagOp (twoClass A al be))
      = (1/2) * ((Fintype.card ι : ℝ) * (al ^ 2 * k + be ^ 2 * ((Fintype.card ι : ℝ) - 1 - k))) := by
  rw [diagOp_normSq _ (twoClass_symm h al be) (twoClass_hollow h al be),
    twoClass_totalPow h al be (two_ne_zero)]

/-- **THE BLOCK'S DISPLAY FOR `θ`, AS AN IDENTITY.** The record writes
`θ = ½[n(kα³+(n-1-k)β³) + fμ_r³ + gμ_s³]`; the first term is the entrywise cube sum, computed
here, and `fμ_r³ + gμ_s³` is `tr M³`, which is what the eigenvalues below supply. -/
theorem twoClass_diagP {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) (al be : ℝ) :
    diagP (twoClass A al be)
      = (1/2) * ((Fintype.card ι : ℝ) * (al ^ 3 * k + be ^ 3 * ((Fintype.card ι : ℝ) - 1 - k))
          + (twoClass A al be * twoClass A al be * twoClass A al be).trace) := by
  unfold diagP
  rw [twoClass_totalPow h al be (three_ne_zero)]

/-! ### The spectrum the display sums over -/

theorem Jmat_mulVec (v : ι → ℝ) : Jmat ι *ᵥ v = fun _ => ∑ c : ι, v c := by
  funext a; simp [Jmat, Matrix.mulVec, dotProduct]

/-- **`M`'s EIGENVALUES ARE `αr - β(1+r)` ON `1^⊥`**, verbatim from the block. *`J` annihilates
`1^⊥`, so only `α A - β(I + A)` survives there.* -/
theorem twoClass_eigen {A : Matrix ι ι ℝ} (al be ρ : ℝ) {v : ι → ℝ}
    (hv : ∑ c : ι, v c = 0) (heig : A *ᵥ v = ρ • v) :
    twoClass A al be *ᵥ v = (al * ρ - be * (1 + ρ)) • v := by
  have hJ : Jmat ι *ᵥ v = 0 := by rw [Jmat_mulVec, hv]; rfl
  unfold twoClass
  rw [Matrix.add_mulVec, Matrix.smul_mulVec, Matrix.smul_mulVec,
    Matrix.sub_mulVec, Matrix.sub_mulVec, hJ, Matrix.one_mulVec, heig]
  funext a
  simp only [Pi.add_apply, Pi.sub_apply, Pi.smul_apply, Pi.zero_apply, smul_eq_mul]
  ring

/-- **AND `0` IS THE EIGENVALUE ON `1`**, which is Ricci-flatness read spectrally. -/
theorem twoClass_kernel {A : Matrix ι ι ℝ} {k lam mu : ℝ} (h : IsSRG A k lam mu) {al be : ℝ}
    (hrow : al * k + be * ((Fintype.card ι : ℝ) - 1 - k) = 0) :
    twoClass A al be *ᵥ (fun _ => (1:ℝ)) = 0 := by
  funext a
  have h1 := (twoClass_isWeight h hrow).rowSum a
  simpa [Matrix.mulVec, dotProduct] using h1

/-! ### The closed form, at the object -/

/-! ### `span{I, A, J}` is an algebra, so `tr M³` is a function of `(n, k, λ, μ)` -/

section Alg
variable {A : Matrix ι ι ℝ} {k lam mu : ℝ}

theorem AJ (h : IsSRG A k lam mu) : A * Jmat ι = k • Jmat ι := by
  ext a b; simp [Matrix.mul_apply, Jmat, h.regular a]

theorem JA (h : IsSRG A k lam mu) : Jmat ι * A = k • Jmat ι := by
  ext a b
  simp only [Matrix.mul_apply, Jmat, Matrix.of_apply, one_mul, Matrix.smul_apply, smul_eq_mul, mul_one]
  rw [← h.regular b]; exact Finset.sum_congr rfl fun c _ => h.symm c b

theorem JJ : Jmat ι * Jmat ι = (Fintype.card ι : ℝ) • Jmat ι := by
  ext a b; simp [Matrix.mul_apply, Jmat]

/-- **The algebra `span{I, A, J}` is closed**, with the SRG relation giving `A²`. -/
theorem prod3 (h : IsSRG A k lam mu) (a b c a' b' c' : ℝ) :
    (a • A + b • Jmat ι + c • (1 : Matrix ι ι ℝ)) * (a' • A + b' • Jmat ι + c' • 1)
      = (a * a' * (lam - mu) + a * c' + c * a') • A
        + (a * a' * mu + k * (a * b' + b * a') + (Fintype.card ι : ℝ) * b * b' + b * c' + c * b') • Jmat ι
        + (a * a' * (k - mu) + c * c') • (1 : Matrix ι ι ℝ) := by
  have hAA : A * A = (lam - mu) • A + mu • Jmat ι + (k - mu) • (1 : Matrix ι ι ℝ) := by
    rw [h.scheme]; module
  simp only [Matrix.add_mul, Matrix.mul_add, Matrix.smul_mul, Matrix.mul_smul, hAA, AJ h, JA h, JJ,
    Matrix.one_mul, Matrix.mul_one]
  module

theorem trA (h : IsSRG A k lam mu) : A.trace = 0 := by
  simp [Matrix.trace, Matrix.diag, h.hollow]

theorem trJ : (Jmat ι).trace = (Fintype.card ι : ℝ) := by simp [Matrix.trace, Matrix.diag, Jmat]

theorem tr_form (h : IsSRG A k lam mu) (a b c : ℝ) :
    (a • A + b • Jmat ι + c • (1 : Matrix ι ι ℝ)).trace = (b + c) * (Fintype.card ι : ℝ) := by
  simp only [Matrix.trace_add, Matrix.trace_smul, trA h, trJ, Matrix.trace_one, smul_eq_mul]; ring

theorem twoClass_form (A : Matrix ι ι ℝ) (al be : ℝ) :
    twoClass A al be = (al - be) • A + be • Jmat ι + (-be) • (1 : Matrix ι ι ℝ) := by
  unfold twoClass; module

end Alg

/-- **`|θ| = |1+λ-μ|√(2(n-1)/(nk(n-1-k)))` AT THE 2-CLASS SCHEME**, which is what turns the
closed form above from a definition into the value of the record's functional at a named point of
`𝒟ₙ`. The absolute value on the left is the audit's *"under the block's own positive root,
`K_{n/2,n/2}` returns `-θ₀`"*: the row-sum condition leaves the overall sign of `(α, β)` free, and
`θ` is odd in it while `thetaSRG` is not.

**PROVED (2026-09-24) WITHOUT THE MULTIPLICITIES.** *This docstring said `tr M³` is not a function of
`(n, k, λ, μ)` without the multiplicities `f, g`, and that was a misattributed blocker*: `span{I, A, J}`
is closed under products (`prod3`, from the SRG relation and `AJ = JA = kJ`, `J² = nJ`), so `tr M³`
is a polynomial in `(n, k, λ, μ, α, β)`, and with the row condition and feasibility it is
`α³(1+λ-μ)·kn(n-1)²/(2m²)`, `m = n-1-k`; the unit norm gives `α² = 2m/(nk(n-1))`. Nothing about `Pcubic` is owed here:
`DiagCubicFormula` carries that, and it is proved in
[SharpDiag.lean](../Base/SharpDiag.lean). -/
theorem twoClass_diagP_abs {A : Matrix ι ι ℝ} {k lam mu al be : ℝ} (h : IsSRG A k lam mu)
    (hrow : al * k + be * ((Fintype.card ι : ℝ) - 1 - k) = 0)
    (hunit : normSq (diagOp (twoClass A al be)) = 1)
    (hk : 0 < k) (hk' : k < (Fintype.card ι : ℝ) - 1) :
    |diagP (twoClass A al be)| = thetaSRG (Fintype.card ι : ℝ) k lam mu := by
  have hne : Nonempty ι := by
    by_contra hc
    rw [not_nonempty_iff] at hc
    simp at hk'; linarith
  set n : ℝ := (Fintype.card ι : ℝ) with hn
  set m : ℝ := n - 1 - k with hm
  have hm0 : 0 < m := by rw [hm]; linarith
  have hn1 : 0 < n - 1 := by linarith
  have hn0 : 0 < n := by linarith
  have hfeas : k * (k - lam - 1) = m * mu := by
    have := h.feasible; unfold Feasible at this; rw [hm]; linarith
  have hbe : be = -al * k / m := by field_simp; linarith
  have hmu : mu = k * (k - lam - 1) / m := by field_simp; linarith
  -- the unit norm fixes `α²`
  have hnorm := twoClass_normSq h al be
  rw [hunit] at hnorm
  have hal2 : al ^ 2 = 2 * m / (n * k * (n - 1)) := by
    rw [hbe] at hnorm; field_simp at hnorm ⊢; rw [hm] at hnorm ⊢; nlinarith [hnorm]
  -- the value of `diagP`
  have hval : diagP (twoClass A al be) = al ^ 3 * (1 + lam - mu) * (k * n * (n - 1) ^ 2) / (2 * m ^ 2) := by
    have hM := congrArg Matrix.trace
      (show twoClass A al be * twoClass A al be * twoClass A al be = _ from by
        rw [twoClass_form, prod3 h, prod3 h])
    rw [tr_form h] at hM
    rw [twoClass_diagP h, hM, hbe, hmu]
    field_simp
    rw [hm]; ring
  rw [hval]
  have hA : |al| = Real.sqrt (2 * m / (n * k * (n - 1))) := by rw [← hal2, Real.sqrt_sq_eq_abs]
  have hsplit : 2 * (n - 1) / (n * k * m) = (2 * m / (n * k * (n - 1))) * ((n - 1) / m) ^ 2 := by
    field_simp
  unfold thetaSRG
  rw [show n - 1 - k = m from hm.symm, hsplit, Real.sqrt_mul (by positivity), Real.sqrt_sq (by positivity),
    ← hA]
  have hpos : 0 < k * n * (n - 1) ^ 2 := by positivity
  have hpos2 : 0 < 2 * m ^ 2 := by positivity
  rw [abs_div, abs_mul, abs_mul, abs_pow, abs_of_pos hpos, abs_of_pos hpos2]
  have h3 : |al| ^ 3 = |al| * (2 * m / (n * k * (n - 1))) := by
    rw [← hal2, ← sq_abs]; ring
  rw [h3]
  field_simp

/-- **THE CLOSED FORM IS `θ` AT THE SCHEME**, once `Pcubic` on the diagonal locus is the record's
weighted-graph functional. **THE `DiagCubicFormula` HYPOTHESIS IS GONE**, discharged by
[SharpDiag.lean](../Base/SharpDiag.lean)'s `diagCubicFormula`, *which was the only binder in the
tree carrying that `Prop` and is what makes this the last one.* It rests on `twoClass_diagP_abs`, proved
above. -/
theorem twoClass_theta_abs {A : Matrix ι ι ℝ}
    {k lam mu al be : ℝ} (h : IsSRG A k lam mu)
    (hrow : al * k + be * ((Fintype.card ι : ℝ) - 1 - k) = 0)
    (hunit : normSq (diagOp (twoClass A al be)) = 1)
    (hk : 0 < k) (hk' : k < (Fintype.card ι : ℝ) - 1) :
    |theta (diagOp (twoClass A al be))| = thetaSRG (Fintype.card ι : ℝ) k lam mu := by
  rw [theta_of_unit _ hunit,
    HamiltonsCubic.RealLayer.diagCubicFormula _ (twoClass_isWeight h hrow)]
  exact twoClass_diagP_abs h hrow hunit hk hk'

end TwoClass

end HamiltonsCubic.L96Statement
