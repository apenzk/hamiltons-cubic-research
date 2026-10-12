import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Positivity

/-!
# L42's dual weight is feasible

[L42](../../../results.md) bounds `M(λ_P)`, a maximum over the polytope
`{t ≥ 0 : Σ_{γ ∉ {α,β}} t_{αβγ} ≤ 2 for every pair}`, by `3M ≤ h(s² - u)` with `h` the
**harmonic mean of the three largest** entries. It calls `h` *"the sharp dual weight"*.

[lean/INDEX.md](../INDEX.md) recorded the general bound as *blocked on the LP*. **It is
not blocked**: naming a dual weight is naming a certificate, and a certificate is
checked rather than searched for. The dual of that programme assigns `y_{αβ} ≥ 0` to
each pair constraint and needs, at every triple,

  `y_{αβ} + y_{αγ} + y_{βγ} ≥ λ_α λ_β λ_γ`,

which for `y_{αβ} = (h/3) λ_α λ_β` is exactly `h · (1/λ_α + 1/λ_β + 1/λ_γ) ≥ 3`, that
is, `h` at least the harmonic mean of that triple. **The three largest entries have the
smallest reciprocal sum, so they are the binding triple**, and feasibility everywhere
follows from feasibility there.

This file checks that. The summation step of weak duality, general in `n`, is proved in
[L42Statement.lean](L42Statement.lean)'s `sharp_dual_weight`.

Everything is `field_simp`/`linarith`, kernel-checked.
-/

namespace HamiltonsCubic.L42

/-- The reciprocal sum of a triple. Feasibility of the dual weight `h` at a triple is
`3 ≤ h * recipSum a b c`. -/
def recipSum (a b c : ℚ) : ℚ := 1 / a + 1 / b + 1 / c

/-- The harmonic mean of a triple, written without a nested division. -/
def harmMean (a b c : ℚ) : ℚ := 3 * a * b * c / (a * b + a * c + b * c)

/-- **The dual constraint at one triple is `h ≥ harmMean`.** Stated in the form the
programme uses: `(h/3)(λ_αλ_β + λ_αλ_γ + λ_βλ_γ) ≥ λ_αλ_βλ_γ`. -/
theorem dual_constraint_iff {a b c h : ℚ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    a * b * c ≤ h / 3 * (a * b + a * c + b * c) ↔ harmMean a b c ≤ h := by
  have hpos : 0 < a * b + a * c + b * c := by positivity
  rw [harmMean, div_le_iff₀ hpos]
  constructor <;> intro hh <;> linarith

/-- The harmonic mean of a triple is the reciprocal-sum form: `harmMean = 3 / recipSum`. -/
theorem harmMean_eq_recip {a b c : ℚ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    harmMean a b c = 3 / recipSum a b c := by
  have h1 : a ≠ 0 := ne_of_gt ha
  have h2 : b ≠ 0 := ne_of_gt hb
  have h3 : c ≠ 0 := ne_of_gt hc
  rw [harmMean, recipSum]
  field_simp
  ring

/-! ## The three largest are the binding triple -/

/-- Growing an entry shrinks its reciprocal, so a triple of larger entries has the
smaller reciprocal sum. -/
theorem recipSum_antitone {a b c a' b' c' : ℚ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (ha' : a ≤ a') (hb' : b ≤ b') (hc' : c ≤ c') :
    recipSum a' b' c' ≤ recipSum a b c := by
  have h1 : 1 / a' ≤ 1 / a := one_div_le_one_div_of_le ha ha'
  have h2 : 1 / b' ≤ 1 / b := one_div_le_one_div_of_le hb hb'
  have h3 : 1 / c' ≤ 1 / c := one_div_le_one_div_of_le hc hc'
  unfold recipSum
  linarith

/-- **So the harmonic mean is monotone**, and `h` taken at the three largest dominates
the harmonic mean of every triple, which is dual feasibility everywhere. -/
theorem harmMean_mono {a b c a' b' c' : ℚ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (ha' : a ≤ a') (hb' : b ≤ b') (hc' : c ≤ c') :
    harmMean a b c ≤ harmMean a' b' c' := by
  have ha0 : 0 < a' := lt_of_lt_of_le ha ha'
  have hb0 : 0 < b' := lt_of_lt_of_le hb hb'
  have hc0 : 0 < c' := lt_of_lt_of_le hc hc'
  rw [harmMean_eq_recip ha hb hc, harmMean_eq_recip ha0 hb0 hc0]
  have hr : 0 < recipSum a' b' c' := by
    unfold recipSum; positivity
  have := recipSum_antitone ha hb hc ha' hb' hc'
  exact div_le_div_of_nonneg_left (by norm_num) hr this

/-- **Feasibility, assembled**: if `h` is the harmonic mean of a triple that dominates
`(a,b,c)` entrywise, the dual constraint holds at `(a,b,c)`. -/
theorem dual_feasible {a b c a' b' c' : ℚ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (ha' : a ≤ a') (hb' : b ≤ b') (hc' : c ≤ c') :
    a * b * c ≤ harmMean a' b' c' / 3 * (a * b + a * c + b * c) :=
  (dual_constraint_iff ha hb hc).mpr (harmMean_mono ha hb hc ha' hb' hc')

/-! ## The sharp case, checked against the existing file

At exactly three positives the polytope has one vertex, `t = 2`, so `M = 2abc` and the
bound is an equality, which is why the constant cannot be improved.
[L42.lean](HamiltonsCubic/Results/L42.lean) carries that; here it is the same identity
seen from the dual side, `2 Σ y = h(s² - u)/3 · 3`.
-/

/-- With `h` the triple's own harmonic mean, the constraint holds with equality. -/
theorem sharp {a b c : ℚ} (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    a * b * c = harmMean a b c / 3 * (a * b + a * c + b * c) := by
  have hpos : (a * b + a * c + b * c) ≠ 0 := by positivity
  rw [harmMean]
  field_simp

/-! ## What this settles

**Settled**: that the record's named dual weight is feasible, the constraint at a
triple is exactly `h ≥ harmMean` there, the harmonic mean is monotone, so the three
largest bind, and that it is tight at a single triple, which is the sharpness.

**The summation step** of weak duality, `Σ_triples t (λλλ) ≤ 2 Σ_pairs y`, is proved in
[L42Statement.lean](L42Statement.lean), which closes L42's general bound.
-/

end HamiltonsCubic.L42
