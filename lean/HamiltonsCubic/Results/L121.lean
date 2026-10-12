import Mathlib.Tactic.Ring
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.FieldSimp

/-!
# L121, the 4-set block and its spectrum

[second-order.md](../../../findings/second-order.md)'s Lemma L121 puts `L_M` on the 4-set
space of `{i,j,k,l}` in signed coordinates as `½G` with

`G = [[A,C,B],[C,B,A],[B,A,C]]`, `A = M_ij + M_kl`, `B = M_ik + M_jl`, `C = M_il + M_jk`,

and states the spectrum on the Bianchi subspace `1⊥` as `±½√D`,
`D = A² + B² + C² - AB - BC - CA`. **The block states that spectrum and never derives it.**

**The derivation here is shorter than the one the block gestures at.** `G² = D·I + e₂·J`
with `e₂ = AB + BC + CA` (an identity in `A, B, C` with no case split) so on `1⊥`, where
`J` kills every vector, `G²` acts as `D·I` outright and the two eigenvalues are `±√D`. The
record's route through `det G = -(A+B+C)D` needs `A + B + C ≠ 0` to divide out the known
root; this one needs nothing, and it is proved below alongside the determinant so the two
can be compared.

`G` acts on triples rather than through `Matrix`, which keeps every step a `ring` identity.
-/

namespace HamiltonsCubic.FourSet

/-- The 4-set block, as its action on a triple in signed coordinates. -/
def Gv (A B C : ℝ) (x : ℝ × ℝ × ℝ) : ℝ × ℝ × ℝ :=
  (A * x.1 + C * x.2.1 + B * x.2.2,
   C * x.1 + B * x.2.1 + A * x.2.2,
   B * x.1 + A * x.2.1 + C * x.2.2)

/-- `D = A² + B² + C² - AB - BC - CA`, the discriminant under the square root. -/
def D (A B C : ℝ) : ℝ := A ^ 2 + B ^ 2 + C ^ 2 - A * B - B * C - C * A

/-- `e₂ = AB + BC + CA`. -/
def e2 (A B C : ℝ) : ℝ := A * B + B * C + C * A

/-- **`G` is symmetric**, the Latin square whose off-diagonal `(m, m')` entry is the third
letter. Read off the action: the coefficient of `x_j` in slot `i` equals that of `x_i` in
slot `j`. -/
theorem G_symm (A B C : ℝ) (x y : ℝ × ℝ × ℝ) :
    (Gv A B C x).1 * y.1 + (Gv A B C x).2.1 * y.2.1 + (Gv A B C x).2.2 * y.2.2
      = x.1 * (Gv A B C y).1 + x.2.1 * (Gv A B C y).2.1 + x.2.2 * (Gv A B C y).2.2 := by
  unfold Gv; simp only; ring

/-- **`1` is an eigenvector with eigenvalue `A + B + C`**, which is the root first Bianchi
removes. -/
theorem G_ones (A B C : ℝ) :
    Gv A B C (1, 1, 1) = ((A + B + C) * 1, (A + B + C) * 1, (A + B + C) * 1) := by
  unfold Gv; simp only; norm_num; refine ⟨by ring, by ring, by ring⟩

/-- **`1⊥` is invariant**: `G` preserves the vanishing of the coordinate sum. -/
theorem G_preserves_perp (A B C : ℝ) {x : ℝ × ℝ × ℝ} (hx : x.1 + x.2.1 + x.2.2 = 0) :
    (Gv A B C x).1 + (Gv A B C x).2.1 + (Gv A B C x).2.2 = 0 := by
  unfold Gv; simp only
  have : x.2.2 = -x.1 - x.2.1 := by linarith
  rw [this]; ring

/-- **The identity that gives the spectrum**: `G² = D·I + e₂·J`, with no hypothesis. -/
theorem G_sq (A B C : ℝ) (x : ℝ × ℝ × ℝ) :
    Gv A B C (Gv A B C x)
      = (D A B C * x.1 + e2 A B C * (x.1 + x.2.1 + x.2.2),
         D A B C * x.2.1 + e2 A B C * (x.1 + x.2.1 + x.2.2),
         D A B C * x.2.2 + e2 A B C * (x.1 + x.2.1 + x.2.2)) := by
  unfold Gv D e2; simp only
  refine Prod.ext ?_ (Prod.ext ?_ ?_) <;> simp only <;> ring

/-- **On the Bianchi subspace `G² = D·I`.** Every vector there satisfies `G²x = Dx`, so the
two eigenvalues of `G` on `1⊥` are `±√D` and those of `½G` are `±½√D`. -/
theorem G_sq_perp (A B C : ℝ) {x : ℝ × ℝ × ℝ} (hx : x.1 + x.2.1 + x.2.2 = 0) :
    Gv A B C (Gv A B C x) = (D A B C * x.1, D A B C * x.2.1, D A B C * x.2.2) := by
  rw [G_sq, hx]; norm_num

/-- `G` is linear in the vector, needed to iterate an eigenvector relation. -/
theorem Gv_smul (A B C μ : ℝ) (x : ℝ × ℝ × ℝ) :
    Gv A B C (μ * x.1, μ * x.2.1, μ * x.2.2)
      = (μ * (Gv A B C x).1, μ * (Gv A B C x).2.1, μ * (Gv A B C x).2.2) := by
  unfold Gv; simp only
  refine Prod.ext ?_ (Prod.ext ?_ ?_) <;> simp only <;> ring

/-- An eigenvector of `G` on `1⊥` has eigenvalue squaring to `D`, the spectrum, with the
sign the only freedom left. -/
theorem eigen_sq (A B C μ : ℝ) {x : ℝ × ℝ × ℝ} (hx : x.1 + x.2.1 + x.2.2 = 0)
    (hne : x.1 ≠ 0) (heig : Gv A B C x = (μ * x.1, μ * x.2.1, μ * x.2.2)) :
    μ ^ 2 = D A B C := by
  have h2 := G_sq_perp A B C hx
  rw [heig, Gv_smul, heig] at h2
  have hfst := congrArg Prod.fst h2
  simp only at hfst
  have hz : (μ ^ 2 - D A B C) * x.1 = 0 := by nlinarith [hfst]
  rcases mul_eq_zero.1 hz with h | h
  · linarith
  · exact absurd h hne

/-- **The half-sum form of `D`**, as the block prints it. -/
theorem D_half_sum (A B C : ℝ) :
    D A B C = (1 / 2) * ((A - B) ^ 2 + (B - C) ^ 2 + (C - A) ^ 2) := by
  unfold D; ring

/-- `D ≥ 0`, so the square root is real and the two eigenvalues are genuinely `±`. The block
does not say this, and it is what makes the stated spectrum well posed. -/
theorem D_nonneg (A B C : ℝ) : 0 ≤ D A B C := by
  rw [D_half_sum]; positivity

/-- **The determinant route, for comparison**: `det G = -(A + B + C) · D`, from which the
record divides out the known root. -/
theorem det_G (A B C : ℝ) :
    A * (B * C - A * A) - C * (C * C - A * B) + B * (C * A - B * B)
      = -((A + B + C) * D A B C) := by
  unfold D; ring

/-- The diagonal of `G` is `(A, B, C)`, the three letters in order, read off the basis
vectors. -/
theorem diag_entries (A B C : ℝ) :
    ((Gv A B C (1, 0, 0)).1, (Gv A B C (0, 1, 0)).2.1, (Gv A B C (0, 0, 1)).2.2) = (A, B, C) := by
  unfold Gv; simp only
  refine Prod.ext ?_ (Prod.ext ?_ ?_) <;> simp only <;> ring

/-- **The restriction to `1⊥` is traceless, and `½G` itself is not.** The content is that the
Latin square's *diagonal* sum equals its *row* sum: the trace is `A + B + C`, which is the one
eigenvalue Bianchi removes, so the remaining two sum to `0`. For a general matrix these two
quantities are unrelated, which is why this needs proving rather than reading off. -/
theorem trace_eq_ones_eigenvalue (A B C : ℝ) :
    (Gv A B C (1, 0, 0)).1 + (Gv A B C (0, 1, 0)).2.1 + (Gv A B C (0, 0, 1)).2.2
      = (Gv A B C (1, 1, 1)).1 := by
  unfold Gv; simp only; ring

/-! ## What the three opposite-pair sums do at a sphere product

With `α` the within-first-factor entry, `β` the within-second and `γ` the cross entry, the
three splits of a 4-subset give `A, B, C` directly. **Only the `(2,2)` split survives**,
the block asserts this and here it is arithmetic in `α, β, γ`, with no normalisation needed.
-/

/-- A 4-subset inside one factor: all three sums are `2α`, so `D = 0`. -/
theorem split_four_zero (α : ℝ) : D (2 * α) (2 * α) (2 * α) = 0 := by unfold D; ring

/-- A `(3,1)` split: all three sums are `α + γ`, so `D = 0`. -/
theorem split_three_one (α γ : ℝ) : D (α + γ) (α + γ) (α + γ) = 0 := by unfold D; ring

/-- A `(2,2)` split: `A = α + β` and `B = C = 2γ`, so `D = (α + β - 2γ)²` and the eigenvalue
of `½G` is `±½|α + β - 2γ|`. -/
theorem split_two_two (α β γ : ℝ) :
    D (α + β) (2 * γ) (2 * γ) = (α + β - 2 * γ) ^ 2 := by unfold D; ring

/-! ## The recorded values, against the closed form `μ = (n-2) / (2(p-1)(q-1))` -/

/-- The balanced case collapses to `μ = 2 / (n - 2)`: at `p = q = m` and `n = 2m`,
`(n-2) / (2(m-1)²) = 1 / (m-1)`. -/
theorem balanced_mu (m : ℝ) (hm : 1 < m) :
    (2 * m - 2) / (2 * (m - 1) ^ 2) = 1 / (m - 1) := by
  have h : m - 1 ≠ 0 := by linarith
  field_simp

/-- `S³ × S³`: `μ = 1/2`, which is why the nine `(2,2)` 4-subsets each contribute a
`+½` eigenvector. -/
theorem mu_s3s3 : (6 - 2 : ℝ) / (2 * (3 - 1) * (3 - 1)) = 1 / 2 := by norm_num

/-- The nine directions the file called *an eigenvalue coincidence with no group origin* are
the `(2,2)`-split 4-subsets of `S³ × S³`: `C(3,2)² = 9`. With a `9`-dimensional orbit that
is the recorded `dim E(½) = 18`. -/
theorem count_s3s3 : Nat.choose 3 2 * Nat.choose 3 2 = 9 := by decide

theorem dim_eigenspace_s3s3 : 9 + Nat.choose 3 2 * Nat.choose 3 2 = 18 := by decide

/-- `S² × S⁴`: `μ = 2/3`. -/
theorem mu_s2s4 : (6 - 2 : ℝ) / (2 * (2 - 1) * (4 - 1)) = 2 / 3 := by norm_num

/-- `S² × S⁶`: `μ = 3/5`. -/
theorem mu_s2s6 : (8 - 2 : ℝ) / (2 * (2 - 1) * (6 - 1)) = 3 / 5 := by norm_num

/-- The two padding-invariant values are distinct, so they are separate 4-set eigenvalues
rather than one value seen twice, each is padding-invariant on its own family. -/
theorem padding_values_differ : (2 / 3 : ℝ) ≠ 3 / 5 := by norm_num

end HamiltonsCubic.FourSet
