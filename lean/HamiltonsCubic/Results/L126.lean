import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Data.Rat.Defs
import Mathlib.Tactic.Ring

/-!
# L126, the four-set threshold, and the scope complement

[second-order.md](../../../findings/second-order.md)'s Lemma L126. The threshold `Σ = θ²` is
met at `Sᵖ × S^q` iff `1/(p-1) + 1/(q-1) = 1`, and the audit reports that this happens **only
at `S³ × S³`**.

**That is a factorisation, not a search.** With `a = p-1`, `b = q-1`, the condition is
`ab - a - b = 0`, i.e. `(a-1)(b-1) = 1`, and over the positive integers the only solution is
`a = b = 2`. So `p = q = 3` is forced, and **no `S² × S^q` can meet it** because `a = 1`
leaves `1/b = 0`.

**And the two scopes partition the family exactly.** [L27](../../../findings/nondegeneracy.md)
takes `p, q ≥ 3` with `(p,q) ≠ (3,3)`; L126 takes `p = 2` or `q = 2` or `(3,3)`. Every pair
with `p, q ≥ 2` falls under **exactly one**, proved as both exhaustiveness and disjointness,
so *"the exact complement"* is a theorem rather than an observation about which cases were
written.
-/

namespace HamiltonsCubic.FourSetThreshold

/-! ## The threshold forces `p = q = 3` -/

/-- Two non-negative integers multiplying to `1` are both `1`. -/
theorem prod_one {x y : ℤ} (hx : 0 ≤ x) (hy : 0 ≤ y) (h : x * y = 1) : x = 1 ∧ y = 1 := by
  have hx0 : x ≠ 0 := by intro hz; rw [hz] at h; simp at h
  have hy0 : y ≠ 0 := by intro hz; rw [hz] at h; simp at h
  have hx1 : 1 ≤ x := by omega
  have hy1 : 1 ≤ y := by omega
  constructor
  · nlinarith [h, hy1, hx]
  · nlinarith [h, hx1, hy]

/-- **The condition `1/a + 1/b = 1` is `(a-1)(b-1) = 1`** after clearing denominators. -/
theorem threshold_factors (a b : ℤ) (h : b + a = a * b) : (a - 1) * (b - 1) = 1 := by
  linarith [h, sq_nonneg (a - b)]

/-- **And over the positive integers that forces `a = b = 2`.** -/
theorem factors_force_two {a b : ℤ} (ha : 1 ≤ a) (hb : 1 ≤ b)
    (h : (a - 1) * (b - 1) = 1) : a = 2 ∧ b = 2 := by
  obtain ⟨h1, h2⟩ := prod_one (by omega : (0:ℤ) ≤ a - 1) (by omega : (0:ℤ) ≤ b - 1) h
  exact ⟨by omega, by omega⟩

/-- **So `p = q = 3` is the only sphere product meeting the threshold.** -/
theorem only_s3s3 {p q : ℤ} (hp : 2 ≤ p) (hq : 2 ≤ q)
    (h : (p - 2) * (q - 2) = 1) : p = 3 ∧ q = 3 := by
  obtain ⟨h1, h2⟩ := prod_one (by omega : (0:ℤ) ≤ p - 2) (by omega : (0:ℤ) ≤ q - 2) h
  exact ⟨by omega, by omega⟩

/-- **And `p = 2` never meets it**: `(p-2)(q-2) = 0 ≠ 1`. -/
theorem p_two_never (q : ℤ) : ((2 : ℤ) - 2) * (q - 2) ≠ 1 := by
  norm_num

/-! ## The two scopes partition the family -/

/-- [L27](../../../findings/nondegeneracy.md)'s scope. -/
def L27scope (p q : ℤ) : Prop := 3 ≤ p ∧ 3 ≤ q ∧ ¬ (p = 3 ∧ q = 3)

/-- L126's scope. -/
def L126scope (p q : ℤ) : Prop := p = 2 ∨ q = 2 ∨ (p = 3 ∧ q = 3)

/-- **Every pair with `p, q ≥ 2` falls under at least one.** -/
theorem exhaustive {p q : ℤ} (hp : 2 ≤ p) (hq : 2 ≤ q) : L27scope p q ∨ L126scope p q := by
  unfold L27scope L126scope
  by_cases h2p : p = 2
  · exact Or.inr (Or.inl h2p)
  · by_cases h2q : q = 2
    · exact Or.inr (Or.inr (Or.inl h2q))
    · by_cases h33 : p = 3 ∧ q = 3
      · exact Or.inr (Or.inr (Or.inr h33))
      · exact Or.inl ⟨by omega, by omega, h33⟩

/-- **And under at most one**, so the two are exact complements within the family. -/
theorem disjoint {p q : ℤ} (h27 : L27scope p q) (h126 : L126scope p q) : False := by
  unfold L27scope at h27
  unfold L126scope at h126
  obtain ⟨hp, hq, hne⟩ := h27
  rcases h126 with h | h | h
  · omega
  · omega
  · exact hne h

end HamiltonsCubic.FourSetThreshold
