import Mathlib
import HamiltonsCubic.Results.L68
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.SphereValue

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L130, the four-set ratio in closed form, and the entry cap that closes the spread conversion

## The record's statement, verbatim

> #### Lemma L130, the four-set ratio in closed form, and the entry cap that closes the spread conversion
>
> **(i) The ratio.** At every $(3,1)$ four-subset of $S^p\times S^q$,
> $$\frac{3m_4-\tfrac12\sigma^2}{\theta^2}=\frac9{2(p-1)^2},$$
> and the band forces $p\ge5$, so **the supremum over the two-factor family is exactly $9/32$**,
> attained for every $q\ge7$. *Scope: non-decay across the two-factor family, every point the
> record can evaluate, not across the class I18's clause quantifies over.*
>
> **(ii) The entry cap, on L68's hypotheses, criticality, symmetry, hollowness and
> $M\mathbf1=0$**, the last being what makes the off-diagonal criticality equation the one used
> here. Hollowness gives $\lVert M_a-M_b\rVert^2\ge2M_{ab}^2$, so with criticality
> $$M_{ab}\le\frac{s_a+s_b}{2\theta}\qquad\text{at every pure critical point,}$$
> which is Lemma L68's $g_{ab}\ge0$ with no hypothesis attached. **And criticality is load-bearing
> for the cap by an identity rather than by a sweep**: $2\theta M_{ab}-(s_a+s_b)=2\rho_{ab}-\tfrac12
> g_{ab}$ with $\rho$ the per-entry criticality residual, whose only constraint is
> $\sum M_{ab}\rho_{ab}=0$, so the cap fails **exactly** when $\rho_{ab}>\tfrac14g_{ab}$.
> **Consequently $p_a:=M_{aj}+M_{ak}\le\dfrac{2s_a+s_j+s_k}{2\theta}\le\dfrac3{2\theta}\le\theta$
> in the band, the last step being exactly $\theta^2\ge\tfrac32$**, with equality forcing $M$ to be
> a star and hence zero. Quantitatively $\theta-p_a\ge(1-s_a)/(2\theta)$.
>
> **What (ii) settles.** The denominator of the entry-spread conversion
> $\lVert\tilde o|_I\rVert_\infty\le\sqrt{\max s_a}\,\lVert\tilde o\rVert/\min_a\lvert\theta-p_a\rvert$
> **cannot vanish or be small**, so the conversion's price is bounded, and the count of indices
> with $p_a=\theta$ is **zero**, not "at most two". *The estimate is exactly tight on the
> two-factor family, since within-factor pairs are twin pairs.*
>
> **And (i) settles what an $m_4$-only criterion can be.** Any such sufficient condition must imply
> $m_4<\theta^2/3$, since in-band $\sigma=0$ four-sets exist ($S^6\times S^7$, and the $(2,2)$
> family at $q(q-1)+p(p-1)=4(p-1)(q-1)$); and that fails in band at $S^5\times S^{66}$, where
> $\sup m_4/\theta^2=3/8$. **So no reduction of the four-set clause to $m_4$ alone can work**, a
> theorem, not a caution.

[diagonal-half.md](../../../findings/diagonal-half.md), Lemma L130.

## What this file states

**Part (ii) in full and PROVED**, on the record's own hypotheses and against
[L68](L68.lean)'s objects (`rowSq` for `s_a`, `sq` for `(M²)_ab`, `g` for the density) so that
the statement is about the record's vertex matrix and not about a local reconstruction of it:

- `entry_cap'`, the cap `2θ M_ab ≤ s_a + s_b`, which is L68's `entry_cap`;
- `cap_residual`, the identity `2θM_ab − (s_a+s_b) = 2ρ_ab − ½g_ab` in the only sign of `ρ` that
  makes it true, `ρ_ab = θM_ab − M_ab² − (M²)_ab`;
- `cap_fails_iff`, the biconditional the block asserts: the cap fails **exactly** when
  `ρ_ab > ¼g_ab`;
- `pair_cap`, `p_a ≤ (2s_a + s_j + s_k)/(2θ)` in the division-free form `2θ p_a ≤ 2s_a+s_j+s_k`;
- `pair_le_theta` and `theta_sub_pair`, the two band consequences `p_a ≤ 3/(2θ) ≤ θ` and
  `θ − p_a ≥ (1−s_a)/(2θ)`, each from `θ > 0`, `θ² ≥ 3/2` and a **named row-norm budget**, with
  `pair_le_theta_record` and `theta_sub_pair_record` the same two at the record's own `tr M² = 2`;
- `rows_le_total`, that three distinct row norms are bounded by the total, which is what supplies
  that budget from `Σ_d s_d ≤ 1`.

**Part (i)'s closed form and its supremum, PROVED as arithmetic**: `ratio p = 9/(2(p−1)²)` is
strictly decreasing on `p ≥ 2`, so on the band's range `p ≥ 5` its supremum is `ratio 5 = 9/32`
and is attained; and `1/3 < 3/8`, the step by which an `m₄`-only criterion fails.

**Part (i) AT THE FAMILY, and PROVED**, the identity, not just its closed form. `sphereWeight`
and `diagOp` from [Families.lean](../Base/Families.lean) are `S^p × S^q` as a curvature operator
on `Λ²`, `fourMass` and `fourReach` are the record's `m₄` and `σ`, and:

- `sphereWeight_sumSq`, the weight's own `Σ_{i,j} w_ij² = pq(n−1)(n−2)/((p−1)(q−1))`, and
  `sphereWeight_scale`, the unit-norm scale it forces;
- `four_set_values`, the six entries of a `(3,1)` four-subset, three `tα` inside the block and
  three `−t` across it;
- `ratio_at_sphereProduct`, the identity `3m₄ − ½σ² = 9/(2(p−1)²) · θ_{p,q}²`, and
  `ratio_at_sphereProduct_div`, the same as the record's quotient `(3m₄−½σ²)/θ_{p,q}² = ratio p`;
- `ratio_at_sphereProduct_theta`, the same against `RealLayer.theta` itself, on the named
  hypothesis `SphereProductValue`, the `P`-value [Families.lean](../Base/Families.lean) states
  and owes, carried as a hypothesis so that the ratio becomes a fact about the record's `θ` the
  moment that value is discharged.

*The normalisation is the layer's own: `normSq (diagOp M) = 1`, which by `diagOp_normSq` is
`Σ_{a<b} M_ab² = 1`.* **It is what fixes the scale, and the identity is false without it**,
`3m₄ − ½σ²` is `2`-homogeneous in `M` while `θ` is scale-invariant.

### The normalisation, stated rather than chosen

The record's chain `p_a ≤ (2s_a+s_j+s_k)/(2θ) ≤ 3/(2θ)` needs a bound on the row-norm budget that
the block does not write down. **It is not silently supplied here**, and the file carries it at
both readings, each named on its own theorem:

- `pair_le_theta` and `theta_sub_pair` take `Σ_d s_d ≤ 1`, `Σ_{a,b} M_ab² ≤ 1`, plain Frobenius
  on the vertex matrix, under which `2s_a+s_j+s_k ≤ 1 + s_a ≤ 2`, so the record's `≤ 3` holds
  with room.
- `pair_le_theta_record` and `theta_sub_pair_record` take the record's own `tr M² = 2`, which is
  `Σ_d s_d = 2` and is exactly the scale part (i) is read at, `normSq (diagOp M) = 1` by
  `diagOp_normSq`. There `2s_a+s_j+s_k ≤ s_a + Σ_d s_d ≤ 3` needs the record's further `s_a ≤ 1`,
  which `pair_le_theta_record` carries as its own hypothesis, and the constants come out at the
  record's `3/(2θ)` and `(1−s_a)/(2θ)` with nothing to spare.

**The two scales differ by a factor of two**, and part (i)'s theorems are stated at the second,
`normSq (diagOp M) = 1`, because that is the normalisation `θ_{p,q}` is read under.

## What is NOT typed here

- **That the band forces `p ≥ 5`.** `ratio_sup` takes `p ≥ 5` as the range the supremum is over;
  the step from `θ_{p,q}² ≥ 3/2` to `p ≥ 5` is not derived here.
- **`P` at the sphere product**, hence `θ = θ_{p,q}` there. That is
  [Families.lean](../Base/Families.lean)'s `SphereProductValue`, which that layer states and does
  not prove; `ratio_at_sphereProduct_theta` carries it as a hypothesis, and the two theorems above
  it are stated against `thetaSplitSq` so that they stand with nothing owed.
- **That the `(3,1)` sets are the only ones with this ratio.** The theorem is stated at a
  four-subset with three indices in one block and one outside it, which is what the record's
  clause quantifies over; the `(4,0)` and `(2,2)` sets carry different values and are not typed.
- **`sup m₄/θ² = 3/8` at `S⁵ × S⁶⁶`**, and the existence of in-band `σ = 0` four-sets. Only the
  arithmetic step `1/3 < 3/8` is typed, so `no_m4_only_criterion` is a statement about numbers.
- **`Σ_{a,b} M_ab ρ_ab = 0`**, the residual's one constraint, which needs `P` and the criticality
  multiplier together.
- **The equality clause** "with equality forcing `M` to be a star and hence zero", and the
  entry-spread conversion itself, whose statement needs the `Õ` of the spread argument.
-/

namespace HamiltonsCubic.L130Statement

open Finset
open HamiltonsCubic.Diagonal

/-! ## Part (i), the closed form and its supremum -/

/-- **`(3m₄ − ½σ²)/θ² = 9/(2(p−1)²)`**, the record's closed form at a `(3,1)` four-subset. *Over
`ℝ` with `p : ℕ` cast in, so that `p − 1` is an ordinary difference.* -/
noncomputable def ratio (p : ℕ) : ℝ := 9 / (2 * ((p : ℝ) - 1) ^ 2)

/-- The value at the band's smallest admissible `p`. -/
theorem ratio_five : ratio 5 = 9 / 32 := by unfold ratio; norm_num

/-- **The closed form is strictly decreasing in `p` from `p = 2` on**, which is why the supremum
sits at the left end of the band's range. -/
theorem ratio_strictAnti {p p' : ℕ} (hp : 2 ≤ p) (hlt : p < p') : ratio p' < ratio p := by
  have h1 : (1 : ℝ) ≤ (p : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (p : ℝ) := by exact_mod_cast hp
    linarith
  have h2 : (p : ℝ) < (p' : ℝ) := by exact_mod_cast hlt
  have hd1 : (0 : ℝ) < 2 * ((p : ℝ) - 1) ^ 2 := by nlinarith
  have hd2 : (0 : ℝ) < 2 * ((p' : ℝ) - 1) ^ 2 := by nlinarith
  unfold ratio
  rw [div_lt_div_iff₀ hd2 hd1]
  nlinarith

/-- **The supremum over the band's range is exactly `9/32`, and it is attained at `p = 5`.** -/
theorem ratio_sup (p : ℕ) (hp : 5 ≤ p) : ratio p ≤ 9 / 32 ∧ ratio 5 = 9 / 32 := by
  refine ⟨?_, ratio_five⟩
  rcases eq_or_lt_of_le hp with h | h
  · rw [← h, ratio_five]
  · exact le_of_lt (ratio_five ▸ ratio_strictAnti (by norm_num) h)

/-- **The step by which no `m₄`-only criterion can work.** Such a criterion must imply
`m₄ < θ²/3`, and the two-factor family reaches `m₄/θ² = 3/8`, which exceeds `1/3`. *The
identification of `3/8` as that supremum is not typed here; this is its arithmetic consequence.* -/
theorem no_m4_only_criterion : (1 : ℝ) / 3 < 3 / 8 := by norm_num

/-! ## Part (i) at the sphere product itself

*[Families.lean](../Base/Families.lean) builds `S^p × S^q` as the two-block weight `sphereWeight`
and `diagOp` as the operator it is on `Λ²`, so the record's `(3m₄ − ½σ²)/θ² = 9/(2(p−1)²)` can be
read at the object rather than at the closed form alone. `m₄` and `σ` are the four-set mass and
reach of [second-order.md](../../../findings/second-order.md), `m₄ = Σ_{a<b∈S} M_ab²` and
`σ = Σ_{a<b∈S} M_ab`, written here as halved ordered-pair sums so that no ordering of the index
type is needed.*
-/

section SphereProduct

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

noncomputable section

/-- **`m₄(T)`, the four-set mass** `Σ_{a<b∈T} M_ab²`, as a halved ordered-pair sum. *At a hollow
symmetric `M` the two readings agree, and this one needs no order on `ι`.* -/
def fourMass (M : Matrix ι ι ℝ) (T : Finset ι) : ℝ := (1 / 2) * ∑ a ∈ T, ∑ b ∈ T, M a b ^ 2

/-- **`σ(T)`, the four-set reach** `Σ_{a<b∈T} M_ab`, in the same reading. -/
def fourReach (M : Matrix ι ι ℝ) (T : Finset ι) : ℝ := (1 / 2) * ∑ a ∈ T, ∑ b ∈ T, M a b

/-- A double sum over an explicit four-set, written out. -/
theorem sum4 (f : ι → ι → ℝ) {a b c d : ι} (hab : a ≠ b) (hac : a ≠ c) (had : a ≠ d)
    (hbc : b ≠ c) (hbd : b ≠ d) (hcd : c ≠ d) :
    ∑ u ∈ ({a, b, c, d} : Finset ι), ∑ v ∈ ({a, b, c, d} : Finset ι), f u v
      = (f a a + f a b + f a c + f a d) + (f b a + f b b + f b c + f b d)
        + (f c a + f c b + f c c + f c d) + (f d a + f d b + f d c + f d d) := by
  simp [Finset.sum_insert, Finset.mem_insert, Finset.mem_singleton, hab, hac, had, hbc, hbd, hcd]
  ring

/-- The row sum of squares of the sphere-product weight, inside the first block: `(p−1)α² + q`
with `α = q/(p−1)`. -/
theorem sphereWeight_rowSq_in (S : Finset ι) {i : ι} (hi : i ∈ S) :
    ∑ j, (sphereWeight S i j) ^ 2
      = ((S.card : ℝ) - 1) * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) ^ 2 + (Sᶜ.card : ℝ) := by
  rw [← Finset.sum_add_sum_compl S (fun j => (sphereWeight S i j) ^ 2)]
  congr 1
  · have hcong : ∀ j ∈ S, (sphereWeight S i j) ^ 2
        = ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) ^ 2
          - (if j = i then ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) ^ 2 else 0) := by
      intro j hj
      by_cases hji : j = i
      · subst hji; simp [sphereWeight]
      · rw [sphereWeight_in S hi hj (Ne.symm hji)]; simp [hji]
    rw [Finset.sum_congr rfl hcong, Finset.sum_sub_distrib, Finset.sum_const,
      Finset.sum_ite_eq' S i (fun _ => ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) ^ 2), if_pos hi,
      nsmul_eq_mul]
    ring
  · have hcong : ∀ j ∈ Sᶜ, (sphereWeight S i j) ^ 2 = 1 := by
      intro j hj
      rw [sphereWeight_cross S hi (Finset.mem_compl.mp hj)]; norm_num
    rw [Finset.sum_congr rfl hcong, Finset.sum_const, nsmul_eq_mul, mul_one]

/-- The same outside the first block: `p + (q−1)β²` with `β = p/(q−1)`. -/
theorem sphereWeight_rowSq_out (S : Finset ι) {i : ι} (hi : i ∉ S) :
    ∑ j, (sphereWeight S i j) ^ 2
      = (S.card : ℝ) + ((Sᶜ.card : ℝ) - 1) * ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) ^ 2 := by
  rw [← Finset.sum_add_sum_compl S (fun j => (sphereWeight S i j) ^ 2)]
  congr 1
  · have hcong : ∀ j ∈ S, (sphereWeight S i j) ^ 2 = 1 := by
      intro j hj
      rw [sphereWeight_symm, sphereWeight_cross S hj hi]; norm_num
    rw [Finset.sum_congr rfl hcong, Finset.sum_const, nsmul_eq_mul, mul_one]
  · have hcong : ∀ j ∈ Sᶜ, (sphereWeight S i j) ^ 2
        = ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) ^ 2
          - (if j = i then ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) ^ 2 else 0) := by
      intro j hj
      by_cases hji : j = i
      · subst hji; simp [sphereWeight]
      · rw [sphereWeight_out S hi (Finset.mem_compl.mp hj) (Ne.symm hji)]; simp [hji]
    rw [Finset.sum_congr rfl hcong, Finset.sum_sub_distrib, Finset.sum_const,
      Finset.sum_ite_eq' Sᶜ i (fun _ => ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) ^ 2),
      if_pos (Finset.mem_compl.mpr hi), nsmul_eq_mul]
    ring

/-- **`Σ_{i,j} w_ij² = pq(n−1)(n−2)/((p−1)(q−1))` at the sphere-product weight**, which by
`diagOp_normSq` is twice its `‖·‖²`. *This is the closed form the unit-norm scale is read off, and
`(n−1)(n−2)` appearing in it is the same factorisation `θ_{p,q}` carries.* -/
theorem sphereWeight_sumSq (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    ∑ i, ∑ j, (sphereWeight S i j) ^ 2
      = (S.card : ℝ) * (Sᶜ.card : ℝ)
          * (((S.card : ℝ) + (Sᶜ.card : ℝ)) - 1) * (((S.card : ℝ) + (Sᶜ.card : ℝ)) - 2)
        / (((S.card : ℝ) - 1) * ((Sᶜ.card : ℝ) - 1)) := by
  have hpR : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  have hp1 : ((S.card : ℝ) - 1) ≠ 0 := by intro h; linarith [h]
  have hq1 : (((Sᶜ.card : ℝ)) - 1) ≠ 0 := by intro h; linarith [h]
  rw [← Finset.sum_add_sum_compl S (fun i => ∑ j, (sphereWeight S i j) ^ 2),
    Finset.sum_congr rfl (fun i hi => sphereWeight_rowSq_in S hi),
    Finset.sum_congr rfl (fun i hi => sphereWeight_rowSq_out S (Finset.mem_compl.mp hi)),
    Finset.sum_const, Finset.sum_const, nsmul_eq_mul, nsmul_eq_mul]
  field_simp
  ring

/-- **`m₄` and `σ` at a `(3,1)` four-subset**: three within-block entries `tα` and three
cross-block entries `−t`, so `m₄ = 3(tα)² + 3t²` and `σ = 3tα − 3t`. -/
theorem four_set_values (S : Finset ι) {a b c d : ι} (ha : a ∈ S) (hb : b ∈ S) (hc : c ∈ S)
    (hd : d ∉ S) (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) (t : ℝ) :
    fourMass (t • sphereWeight S) {a, b, c, d}
        = 3 * (t * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1))) ^ 2 + 3 * t ^ 2
      ∧ fourReach (t • sphereWeight S) {a, b, c, d}
        = 3 * (t * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1))) - 3 * t := by
  have had : a ≠ d := fun h => hd (h ▸ ha)
  have hbd : b ≠ d := fun h => hd (h ▸ hb)
  have hcd : c ≠ d := fun h => hd (h ▸ hc)
  have e0 : ∀ u : ι, (t • sphereWeight S) u u = 0 := by
    intro u; simp [Matrix.smul_apply, sphereWeight_hollow]
  have ein : ∀ u v : ι, u ∈ S → v ∈ S → u ≠ v →
      (t • sphereWeight S) u v = t * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) := by
    intro u v hu hv huv
    simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_in S hu hv huv]
  have ecr : ∀ u : ι, u ∈ S → (t • sphereWeight S) u d = -t := by
    intro u hu
    simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_cross S hu hd]; ring
  have ecr' : ∀ v : ι, v ∈ S → (t • sphereWeight S) d v = -t := by
    intro v hv
    simp only [Matrix.smul_apply, smul_eq_mul, sphereWeight_symm S d v,
      sphereWeight_cross S hv hd]; ring
  constructor
  · unfold fourMass
    rw [sum4 (fun u v => ((t • sphereWeight S) u v) ^ 2) hab hac had hbc hbd hcd]
    simp only [e0, ein a b ha hb hab, ein a c ha hc hac, ein b a hb ha (Ne.symm hab),
      ein b c hb hc hbc, ein c a hc ha (Ne.symm hac), ein c b hc hb (Ne.symm hbc),
      ecr a ha, ecr b hb, ecr c hc, ecr' a ha, ecr' b hb, ecr' c hc]
    ring
  · unfold fourReach
    rw [sum4 (fun u v => (t • sphereWeight S) u v) hab hac had hbc hbd hcd]
    simp only [e0, ein a b ha hb hab, ein a c ha hc hac, ein b a hb ha (Ne.symm hab),
      ein b c hb hc hbc, ein c a hc ha (Ne.symm hac), ein c b hc hb (Ne.symm hbc),
      ecr a ha, ecr b hb, ecr c hc, ecr' a ha, ecr' b hb, ecr' c hc]
    ring

/-- **The unit-norm scale**, `t² · pq(n−1)(n−2) = 2(p−1)(q−1)`, division-free. -/
theorem sphereWeight_scale (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ)
    (hnorm : normSq (diagOp (t • sphereWeight S)) = 1) :
    t ^ 2 * ((S.card : ℝ) * (Sᶜ.card : ℝ) * (((S.card : ℝ) + (Sᶜ.card : ℝ)) - 1)
        * (((S.card : ℝ) + (Sᶜ.card : ℝ)) - 2))
      = 2 * ((S.card : ℝ) - 1) * ((Sᶜ.card : ℝ) - 1) := by
  have hpR : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  have hp1 : ((S.card : ℝ) - 1) ≠ 0 := by intro h; linarith [h]
  have hq1 : (((Sᶜ.card : ℝ)) - 1) ≠ 0 := by intro h; linarith [h]
  rw [diagOp_normSq_smul _ _ (sphereWeight_symm S) (sphereWeight_hollow S),
    diagOp_normSq _ (sphereWeight_symm S) (sphereWeight_hollow S), sphereWeight_sumSq S hp hq]
    at hnorm
  field_simp at hnorm
  linarith [hnorm]

/-- **PART (i), AT THE FAMILY.** At a unit-norm member of `S^p × S^q` and a `(3,1)` four-subset,
three indices in the first block, one outside it,
`3m₄ − ½σ² = 9/(2(p−1)²) · θ_{p,q}²`, which is the record's ratio in division-free form.

*Everything in it is the record's own object: `sphereWeight` is
[Families.lean](../Base/Families.lean)'s two-block weight, `diagOp` the operator it is on `Λ²`,
`thetaSplitSq` the value `θ_{p,q}²` of Nienhaus Proposition 2.25, and `m₄`, `σ` the four-set mass
and reach.* **The normalisation is the layer's own**, `normSq (diagOp M) = 1`, which by
`diagOp_normSq` is `Σ_{a<b} M_ab² = 1`, and it is what fixes the scale the ratio is read at. -/
theorem ratio_at_sphereProduct (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ)
    (hnorm : normSq (diagOp (t • sphereWeight S)) = 1)
    {a b c d : ι} (ha : a ∈ S) (hb : b ∈ S) (hc : c ∈ S) (hd : d ∉ S)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    3 * fourMass (t • sphereWeight S) {a, b, c, d}
        - (1 / 2) * fourReach (t • sphereWeight S) {a, b, c, d} ^ 2
      = 9 / (2 * ((S.card : ℝ) - 1) ^ 2) * thetaSplitSq (S.card : ℝ) ((Sᶜ.card : ℝ)) := by
  have hpR : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  have hp0 : ((S.card : ℝ)) ≠ 0 := by intro h; linarith [h]
  have hq0 : (((Sᶜ.card : ℝ))) ≠ 0 := by intro h; linarith [h]
  have hp1 : ((S.card : ℝ) - 1) ≠ 0 := by intro h; linarith [h]
  have hq1 : (((Sᶜ.card : ℝ)) - 1) ≠ 0 := by intro h; linarith [h]
  have hn1 : ((S.card : ℝ) + (Sᶜ.card : ℝ) - 1) ≠ 0 := by intro h; linarith [h]
  have hn2 : ((S.card : ℝ) + (Sᶜ.card : ℝ) - 2) ≠ 0 := by intro h; linarith [h]
  obtain ⟨hm, hs⟩ := four_set_values S ha hb hc hd hab hac hbc t
  have ht := sphereWeight_scale S hp hq t hnorm
  have ht2 : t ^ 2 = 2 * ((S.card : ℝ) - 1) * ((Sᶜ.card : ℝ) - 1)
      / ((S.card : ℝ) * (Sᶜ.card : ℝ) * (((S.card : ℝ) + (Sᶜ.card : ℝ)) - 1)
          * (((S.card : ℝ) + (Sᶜ.card : ℝ)) - 2)) := by
    field_simp
    linarith [ht]
  rw [hm, hs]
  have key : ∀ A : ℝ, 3 * (3 * (t * A) ^ 2 + 3 * t ^ 2) - 1 / 2 * (3 * (t * A) - 3 * t) ^ 2
      = t ^ 2 * (9 / 2 * (A + 1) ^ 2) := by intro A; ring
  rw [key, ht2]
  unfold thetaSplitSq
  field_simp
  ring

theorem thetaSplitSq_pos (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    0 < thetaSplitSq (S.card : ℝ) ((Sᶜ.card : ℝ)) := by
  have hpR : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  have h1 : (0 : ℝ) < (S.card : ℝ) - 1 := by linarith
  have h2 : (0 : ℝ) < (Sᶜ.card : ℝ) - 1 := by linarith
  have h3 : (0 : ℝ) < (S.card : ℝ) + (Sᶜ.card : ℝ) - 1 := by linarith
  have h4 : (0 : ℝ) < (S.card : ℝ) + (Sᶜ.card : ℝ) - 2 := by linarith
  have h5 : (0 : ℝ) < (S.card : ℝ) := by linarith
  have h6 : (0 : ℝ) < (Sᶜ.card : ℝ) := by linarith
  unfold thetaSplitSq
  exact div_pos (mul_pos (mul_pos (mul_pos (by norm_num) h3) h1) h2)
    (mul_pos h4 (mul_pos h5 h6))

/-- **PART (i), AS THE RECORD WRITES IT**, the quotient `(3m₄ − ½σ²)/θ_{p,q}²` equals
`9/(2(p−1)²)`, which is `ratio p`. -/
theorem ratio_at_sphereProduct_div (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ)
    (hnorm : normSq (diagOp (t • sphereWeight S)) = 1)
    {a b c d : ι} (ha : a ∈ S) (hb : b ∈ S) (hc : c ∈ S) (hd : d ∉ S)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    (3 * fourMass (t • sphereWeight S) {a, b, c, d}
        - (1 / 2) * fourReach (t • sphereWeight S) {a, b, c, d} ^ 2)
      / thetaSplitSq (S.card : ℝ) ((Sᶜ.card : ℝ)) = ratio S.card := by
  rw [ratio_at_sphereProduct S hp hq t hnorm ha hb hc hd hab hac hbc]
  rw [mul_div_assoc, div_self (ne_of_gt (thetaSplitSq_pos S hp hq)), mul_one]
  rfl

/-- **PART (i) AGAINST THE RECORD'S OWN `θ`.** `θ` at a unit-norm sphere product is `θ_{p,q}` by
[Families.lean](../Base/Families.lean)'s `theta_sphereProduct`, which rests on
`SphereProductValue`. **THAT HYPOTHESIS IS GONE**, discharged by
[SphereValue.lean](../Base/SphereValue.lean)'s `sphereProductValue`, *so this is now a statement
about `RealLayer.theta` outright.* -/
theorem ratio_at_sphereProduct_theta
    (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) (t : ℝ) (ht : 0 < t)
    (hnorm : normSq (diagOp (t • sphereWeight S)) = 1)
    {a b c d : ι} (ha : a ∈ S) (hb : b ∈ S) (hc : c ∈ S) (hd : d ∉ S)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    3 * fourMass (t • sphereWeight S) {a, b, c, d}
        - (1 / 2) * fourReach (t • sphereWeight S) {a, b, c, d} ^ 2
      = ratio S.card * theta (diagOp (t • sphereWeight S)) ^ 2 := by
  rw [theta_sphereProduct sphereProductValue S hp hq t ht hnorm]
  unfold thetaSplit
  rw [Real.sq_sqrt (le_of_lt (thetaSplitSq_pos S hp hq))]
  exact ratio_at_sphereProduct S hp hq t hnorm ha hb hc hd hab hac hbc

end

end SphereProduct

/-! ## Part (ii), the entry cap, the residual identity, and the band consequences -/

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {M : ι → ι → ℝ}

/-- **The per-entry criticality residual, in the sign the identity forces.** It vanishes exactly
at a critical point, and `2θM_ab − (s_a+s_b) = 2ρ_ab − ½g_ab` holds with this `ρ` and with no
other. -/
def resid (M : ι → ι → ℝ) (θ : ℝ) (a b : ι) : ℝ :=
  θ * M a b - M a b ^ 2 - HamiltonsCubic.Diagonal.sq M a b

/-- **The cap itself.** `2θ M_ab ≤ s_a + s_b` at every pure critical point, the record's
`M_ab ≤ (s_a+s_b)/(2θ)`, division-free so that no sign condition on `θ` is smuggled in. *This is
L68's `entry_cap`, restated at its own name so that L130's chain reads against it.* -/
theorem entry_cap' (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a b : ι} (hab : a ≠ b)
    {θ : ℝ} (hc : M a b ^ 2 + HamiltonsCubic.Diagonal.sq M a b = θ * M a b) :
    2 * θ * M a b ≤ rowSq M a + rowSq M b :=
  entry_cap hh hs hab hc

/-- **The residual identity**, on hollowness and symmetry alone. -/
theorem cap_residual (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a b : ι}
    (hab : a ≠ b) (θ : ℝ) :
    2 * θ * M a b - (rowSq M a + rowSq M b) = 2 * resid M θ a b - (1 / 2) * g M a b := by
  rw [g_eq hh hs hab]
  unfold resid
  ring

/-- **The cap fails exactly when `ρ_ab > ¼g_ab`**, an identity rather than a sweep, which is what
makes criticality load-bearing for the cap. -/
theorem cap_fails_iff (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a b : ι}
    (hab : a ≠ b) (θ : ℝ) :
    (rowSq M a + rowSq M b < 2 * θ * M a b) ↔ (1 / 4) * g M a b < resid M θ a b := by
  have h := cap_residual hh hs hab θ
  constructor <;> intro h' <;> linarith

/-! ### `p_a = M_aj + M_ak` -/

/-- **`2θ p_a ≤ 2s_a + s_j + s_k`**, the record's `p_a ≤ (2s_a+s_j+s_k)/(2θ)`, from the cap applied
to the two entries. -/
theorem pair_cap (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a j k : ι}
    (haj : a ≠ j) (hak : a ≠ k) {θ : ℝ}
    (hcj : M a j ^ 2 + HamiltonsCubic.Diagonal.sq M a j = θ * M a j)
    (hck : M a k ^ 2 + HamiltonsCubic.Diagonal.sq M a k = θ * M a k) :
    2 * θ * (M a j + M a k) ≤ 2 * rowSq M a + rowSq M j + rowSq M k := by
  have h1 := entry_cap' hh hs haj hcj
  have h2 := entry_cap' hh hs hak hck
  linarith

/-- Three distinct row norms are bounded by the total, the row norms being sums of squares. -/
theorem rows_le_total {a j k : ι} (haj : a ≠ j) (hak : a ≠ k) (hjk : j ≠ k) :
    rowSq M a + rowSq M j + rowSq M k ≤ ∑ d, rowSq M d := by
  have hnn : ∀ d ∈ (univ : Finset ι), 0 ≤ rowSq M d := fun d _ =>
    Finset.sum_nonneg fun e _ => sq_nonneg _
  have hsub : ({a, j, k} : Finset ι) ⊆ univ := subset_univ _
  have hcard : ∑ d ∈ ({a, j, k} : Finset ι), rowSq M d = rowSq M a + rowSq M j + rowSq M k := by
    rw [Finset.sum_insert (by simp [haj, hak]), Finset.sum_insert (by simp [hjk]),
      Finset.sum_singleton]
    ring
  calc rowSq M a + rowSq M j + rowSq M k
      = ∑ d ∈ ({a, j, k} : Finset ι), rowSq M d := hcard.symm
    _ ≤ ∑ d, rowSq M d := Finset.sum_le_sum_of_subset_of_nonneg hsub fun d _ hd => hnn d (mem_univ d)

/-- **`p_a ≤ 3/(2θ) ≤ θ` in the band.** The last step is exactly `θ² ≥ 3/2`. The row-norm budget is
the named hypothesis `hbudget : Σ_d s_d ≤ 1` (unit norm read as `Σ_{a,b} M_ab² ≤ 1`) and under it
`2s_a+s_j+s_k ≤ 1 + s_a ≤ 2 ≤ 3`. -/
theorem pair_le_theta (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a j k : ι}
    (haj : a ≠ j) (hak : a ≠ k) (hjk : j ≠ k) {θ : ℝ} (hθ : 0 < θ) (hband : 3 / 2 ≤ θ ^ 2)
    (hbudget : ∑ d, rowSq M d ≤ 1)
    (hcj : M a j ^ 2 + HamiltonsCubic.Diagonal.sq M a j = θ * M a j)
    (hck : M a k ^ 2 + HamiltonsCubic.Diagonal.sq M a k = θ * M a k) :
    M a j + M a k ≤ 3 / (2 * θ) ∧ 3 / (2 * θ) ≤ θ := by
  have hrows := rows_le_total (M := M) haj hak hjk
  have hsa : 0 ≤ rowSq M a := Finset.sum_nonneg fun e _ => sq_nonneg _
  have hsj : 0 ≤ rowSq M j := Finset.sum_nonneg fun e _ => sq_nonneg _
  have hsk : 0 ≤ rowSq M k := Finset.sum_nonneg fun e _ => sq_nonneg _
  have hcap := pair_cap hh hs haj hak hcj hck
  have h2t : (0 : ℝ) < 2 * θ := by linarith
  constructor
  · rw [le_div_iff₀ h2t]
    nlinarith
  · rw [div_le_iff₀ h2t]
    nlinarith

/-- **`θ − p_a ≥ (1 − s_a)/(2θ)`**, the quantitative form, on the same budget. It is what makes the
entry-spread conversion's denominator bounded away from zero. -/
theorem theta_sub_pair (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a j k : ι}
    (haj : a ≠ j) (hak : a ≠ k) (hjk : j ≠ k) {θ : ℝ} (hθ : 0 < θ) (hband : 3 / 2 ≤ θ ^ 2)
    (hbudget : ∑ d, rowSq M d ≤ 1)
    (hcj : M a j ^ 2 + HamiltonsCubic.Diagonal.sq M a j = θ * M a j)
    (hck : M a k ^ 2 + HamiltonsCubic.Diagonal.sq M a k = θ * M a k) :
    (1 - rowSq M a) / (2 * θ) ≤ θ - (M a j + M a k) := by
  have hrows := rows_le_total (M := M) haj hak hjk
  have hsj : 0 ≤ rowSq M j := Finset.sum_nonneg fun e _ => sq_nonneg _
  have hsk : 0 ≤ rowSq M k := Finset.sum_nonneg fun e _ => sq_nonneg _
  have hcap := pair_cap hh hs haj hak hcj hck
  have h2t : (0 : ℝ) < 2 * θ := by linarith
  rw [div_le_iff₀ h2t]
  nlinarith

/-! ### The same chain at the record's own scale

*Part (i) above is read at `normSq (diagOp M) = 1`, which by `diagOp_normSq` is `Σ_{a<b} M_ab² = 1`
and is [diagonal-half.md](../../../findings/diagonal-half.md)'s `tr M² = 2`. In row norms that is
`Σ_d s_d = 2`, so the two theorems below carry the record's own budget and the record's own extra
clause `s_a ≤ 1`, and they return the record's constants `3/(2θ)` and `(1−s_a)/(2θ)` exactly.*
-/

/-- **`p_a ≤ 3/(2θ) ≤ θ` at the record's normalisation.** *`tr M² = 2` is `Σ_d s_d = 2`, and
`2s_a + s_j + s_k = s_a + (s_a+s_j+s_k) ≤ s_a + Σ_d s_d ≤ 3` is where `s_a ≤ 1` is used.* -/
theorem pair_le_theta_record (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a j k : ι}
    (haj : a ≠ j) (hak : a ≠ k) (hjk : j ≠ k) {θ : ℝ} (hθ : 0 < θ) (hband : 3 / 2 ≤ θ ^ 2)
    (hbudget : ∑ d, rowSq M d ≤ 2) (hsa : rowSq M a ≤ 1)
    (hcj : M a j ^ 2 + HamiltonsCubic.Diagonal.sq M a j = θ * M a j)
    (hck : M a k ^ 2 + HamiltonsCubic.Diagonal.sq M a k = θ * M a k) :
    M a j + M a k ≤ 3 / (2 * θ) ∧ 3 / (2 * θ) ≤ θ := by
  have hrows := rows_le_total (M := M) haj hak hjk
  have hcap := pair_cap hh hs haj hak hcj hck
  have h2t : (0 : ℝ) < 2 * θ := by linarith
  constructor
  · rw [le_div_iff₀ h2t]
    nlinarith
  · rw [div_le_iff₀ h2t]
    nlinarith

/-- **`θ − p_a ≥ (1 − s_a)/(2θ)` at the record's normalisation**, on the same budget. -/
theorem theta_sub_pair_record (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a j k : ι}
    (haj : a ≠ j) (hak : a ≠ k) (hjk : j ≠ k) {θ : ℝ} (hθ : 0 < θ) (hband : 3 / 2 ≤ θ ^ 2)
    (hbudget : ∑ d, rowSq M d ≤ 2)
    (hcj : M a j ^ 2 + HamiltonsCubic.Diagonal.sq M a j = θ * M a j)
    (hck : M a k ^ 2 + HamiltonsCubic.Diagonal.sq M a k = θ * M a k) :
    (1 - rowSq M a) / (2 * θ) ≤ θ - (M a j + M a k) := by
  have hrows := rows_le_total (M := M) haj hak hjk
  have hcap := pair_cap hh hs haj hak hcj hck
  have h2t : (0 : ℝ) < 2 * θ := by linarith
  rw [div_le_iff₀ h2t]
  nlinarith

/-- **The count of indices with `p_a = θ` is zero**, not "at most two": the previous bound is
strict once `s_a < 1`. -/
theorem no_index_at_theta (hh : ∀ a, M a a = 0) (hs : ∀ a b, M a b = M b a) {a j k : ι}
    (haj : a ≠ j) (hak : a ≠ k) (hjk : j ≠ k) {θ : ℝ} (hθ : 0 < θ) (hband : 3 / 2 ≤ θ ^ 2)
    (hbudget : ∑ d, rowSq M d ≤ 1) (hsa : rowSq M a < 1)
    (hcj : M a j ^ 2 + HamiltonsCubic.Diagonal.sq M a j = θ * M a j)
    (hck : M a k ^ 2 + HamiltonsCubic.Diagonal.sq M a k = θ * M a k) :
    M a j + M a k ≠ θ := by
  have h := theta_sub_pair hh hs haj hak hjk hθ hband hbudget hcj hck
  have h2t : (0 : ℝ) < 2 * θ := by linarith
  have hpos : 0 < (1 - rowSq M a) / (2 * θ) := div_pos (by linarith) h2t
  intro hcon
  rw [hcon] at h
  simp at h
  linarith

/-! ## Witnesses, so the hypotheses are not empty

*`M = 0` is hollow, symmetric and off-diagonally critical at every `θ`, with every row norm `0`,
so the budget holds and the two band consequences are non-vacuous. And `p = 5` witnesses the
supremum clause.* -/

example (θ : ℝ) (a b : ι) :
    (fun _ _ : ι => (0 : ℝ)) a a = 0
      ∧ (0 : ℝ) ^ 2 + HamiltonsCubic.Diagonal.sq (fun _ _ : ι => (0 : ℝ)) a b
        = θ * (0 : ℝ) := by
  refine ⟨rfl, ?_⟩
  unfold HamiltonsCubic.Diagonal.sq
  simp

example : ratio 5 = 9 / 32 ∧ (5 : ℕ) ≤ 5 := ⟨ratio_five, le_refl 5⟩

end HamiltonsCubic.L130Statement
