import Mathlib
import HamiltonsCubic.Base.FoxProduct
import HamiltonsCubic.Base.Families

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# L98, the diagonal floor, and the equals sign a census cannot deliver

**The record's statement, quoted verbatim from [diagonal-half.md](../../../findings/diagonal-half.md):**

> #### Observation L98, the diagonal floor $\min\lambda_{\max}(L_e)=1+\frac1{2(n-3)(n-4)}$
>
> **THE SOURCE WROTE THIS FORMULA WITH A QUESTION MARK OVER THE EQUALS SIGN, AND ASKED THAT IT BE QUOTED AS AN UPPER BOUND WITH ITS POPULATION.** … **A census bounds an infimum from above only**, so the floor is measured, and the label `Observation` is right while the bare $=$ is not.
>
> **the diagonal minimum has a closed form and it converges to $1$**, *[Reviewer 310](../reviews/REVIEW_r310.md), from a census of $571$ diagonal $\Delta>0$ critical points at $n=6\ldots16$*: $\min\lambda_{\max}(L_e)=1+\frac1{2(n-3)(n-4)}$, exact across seven consecutive dimensions, $1.011905$ at $n=10$, $1.006944$ at $n=12$, $1.003205$ at $n=16$.
>
> **THE POLES AT $n=3,4$ ARE EXCLUDED SILENTLY, AND BOTH ARE VACUOUS.** … *$n=5$ is an untested prediction of $1.25$.*
>
> **Two figures dismissed as "artefacts of small $n$" are the formula's own values at $n=7$ and $n=8$**, unrecorded corroboration from populations the fit never saw.
>
> **"$\Delta>0\Rightarrow\lambda_{\max}(L_e)\ge1$ SURVIVES" IS WRITTEN UNSCOPED (IN THE BLOCK WHOSE JOB IS THE SCOPE WARNING) AND ITS OWN TABLE REFUTES IT THREE LINES BELOW**, at $0.6089$, $0.5628$ and $0.5535$.
>
> Meanwhile the non-diagonal witness sits at $\lambda_{\max}(L_e)=0.608885$, **a factor $1.68$ below the diagonal floor** ($59.4\%$ of it; *an earlier version read "less than half", which is false, half of $1.025$ is $0.5125$*).

## What this file states

Two things, and they are different in kind.

* **The arithmetic of the formula**, in full: the three tabulated values, the two poles, the
  `n = 5` prediction, the corroborating values at `n = 7` and `n = 8`, strict positivity of the
  excess over `1` at every `n > 4`, monotone decrease, and the convergence to `1`.
* **The epistemic content the audit turns on**, as a theorem rather than a remark:
  `census_bounds_from_above` says a finite subsample of a set bounds that set's infimum from
  **above only**, and `census_can_be_strict` exhibits a subsample whose minimum is strictly above
  the infimum. Together they are exactly *"a census bounds an infimum from above only"*, so the
  census licenses `inf ≤ 1 + 1/(2(n-3)(n-4))` and not the `=` the heading prints.

* **The lemma's own subject**, now that [FoxProduct.lean](../Base/FoxProduct.lean) carries `L_e`
  and [Families.lean](../Base/Families.lean) carries the diagonal locus. `IsLamMax W θ c` is
  *"`c` is `λ_max(L_e|_{W^⊥})`"* in the Rayleigh reading (a bound that is attained) and
  `floorValues` is the set of its values over the diagonal `Δ > 0` critical points at this
  dimension. `census_upper_bound` is `census_bounds_from_above` **instantiated at that set**, and
  `diagonal_floor_le` is the block's claim in the direction a census licenses,
  `inf ≤ 1 + 1/(2(n-3)(n-4))`. `DiagFloorExact` names the heading's `=` and asserts nothing.
* **The two readings of the survival claim, separated.** `DiagFloorExact.strong_reading` is
  *"`Δ > 0 ⇒ λ_max(L_e) ≥ 1`"* scoped to the diagonal locus, derived from the floor being above
  `1`; `unscoped_refuted` is the same sentence unscoped, and shows one off-locus point below `1`
  kills it.

**One `sorry`, in `diagonal_floor_le`**: the census point itself. The record holds `571` measured
diagonal `Δ > 0` critical points; constructing one here needs `Qop` on the diagonal locus, which
[Families.lean](../Base/Families.lean) records under `DiagCubicFormula`, PROVED in [SharpDiag.lean](../Base/SharpDiag.lean).

## What is NOT typed here

**`Δ` itself.** [conventions.md](../../../findings/conventions.md)'s symmetry defect is the trace
of the Petersen–Wink density over `{λ > 0}`; no layer below this one builds it, and it is a
different object from [AltPart.lean](../Base/AltPart.lean)'s Bianchi defect `δ²`. It enters
`IsCensusPoint` as a parameter, so every statement below is uniform in it.

**That `IsLamMax` is a spectral maximum.** It is the quadratic-form reading
[FoxProduct.lean](../Base/FoxProduct.lean) fixes; the equivalence with a largest eigenvalue needs
`L_e` self-adjoint, which that file records as owed.

**And the off-locus table is arithmetic only.** `three_values_below_one`, `factor_below_floor` and
`not_less_than_half` check the numbers the block prints against the claims it makes about them;
that those numbers *are* `λ_max(L_e)` at three non-diagonal critical points is measured, so
`unscoped_refuted` takes such a point as a hypothesis rather than constructing one.
-/

namespace HamiltonsCubic.L98Statement

open Filter Topology

/-! ## The formula -/

/-- The diagonal floor, `1 + 1/(2(n-3)(n-4))`. -/
noncomputable def floorFormula (n : ℝ) : ℝ := 1 + 1 / (2 * (n - 3) * (n - 4))

/-! ### The three tabulated values -/

theorem floor_ten : floorFormula 10 = 85 / 84 := by unfold floorFormula; norm_num

theorem floor_twelve : floorFormula 12 = 145 / 144 := by unfold floorFormula; norm_num

theorem floor_sixteen : floorFormula 16 = 313 / 312 := by unfold floorFormula; norm_num

/-- …and they are the printed decimals. -/
theorem tabulated_decimals :
    |floorFormula 10 - 1.011905| < 1e-6 ∧ |floorFormula 12 - 1.006944| < 1e-6 ∧
      |floorFormula 16 - 1.003205| < 1e-6 := by
  refine ⟨?_, ?_, ?_⟩ <;>
    · rw [abs_lt]
      constructor <;> · unfold floorFormula; norm_num

/-! ### The poles, and the small-`n` values the block does not identify -/

/-- **The poles at `n = 3, 4` are the vanishing of the denominator**, which is what the block
excludes silently. -/
theorem poles : 2 * ((3:ℝ) - 3) * (3 - 4) = 0 ∧ 2 * ((4:ℝ) - 3) * (4 - 4) = 0 := by
  constructor <;> norm_num

/-- **`n = 5` predicts `1.25`**, the value the block calls untested. -/
theorem floor_five : floorFormula 5 = 5 / 4 := by unfold floorFormula; norm_num

/-- **The two figures the record dismissed as *"artefacts of small `n`"* are the formula's own
values at `n = 7` and `n = 8`**, `1.0416…` and `1.025` exactly. This is the corroboration the
audit says went unrecorded. -/
theorem small_n_corroboration : floorFormula 7 = 25 / 24 ∧ floorFormula 8 = 41 / 40 := by
  constructor <;> · unfold floorFormula; norm_num

theorem floor_eight_is_one_point_oh_two_five : floorFormula 8 = 1.025 := by
  unfold floorFormula; norm_num

theorem floor_seven_decimal : |floorFormula 7 - 1.0417| < 1e-4 := by
  rw [abs_lt]; constructor <;> · unfold floorFormula; norm_num

/-! ### The shape of the formula -/

/-- **The floor exceeds `1` at every admissible `n`**, which is what makes the stronger reading
`Δ > 0 ⇒ λ_max ≥ 1` consistent with it, and, at large `n`, sharp. -/
theorem floor_gt_one {n : ℝ} (hn : 4 < n) : 1 < floorFormula n := by
  unfold floorFormula
  have h3 : (0:ℝ) < n - 3 := by linarith
  have h4 : (0:ℝ) < n - 4 := by linarith
  have : 0 < 1 / (2 * (n - 3) * (n - 4)) := by positivity
  linarith

/-- **And it decreases**: the excess over `1` shrinks as `n` grows. -/
theorem floor_strictAnti {m n : ℝ} (hm : 4 < m) (hmn : m < n) : floorFormula n < floorFormula m := by
  unfold floorFormula
  have hm3 : (0:ℝ) < m - 3 := by linarith
  have hm4 : (0:ℝ) < m - 4 := by linarith
  have hn3 : (0:ℝ) < n - 3 := by linarith
  have hn4 : (0:ℝ) < n - 4 := by linarith
  have hden : 0 < 2 * (m - 3) * (m - 4) := by positivity
  have hden' : 0 < 2 * (n - 3) * (n - 4) := by positivity
  have hlt : 2 * (m - 3) * (m - 4) < 2 * (n - 3) * (n - 4) := by nlinarith
  have := one_div_lt_one_div_of_lt hden hlt
  linarith

/-- **It converges to `1`**, the block's own words, here as a limit. -/
theorem floor_tendsto_one : Tendsto floorFormula atTop (𝓝 1) := by
  have hden : Tendsto (fun n : ℝ => 2 * (n - 3) * (n - 4)) atTop atTop := by
    apply Filter.tendsto_atTop_mono (f := fun n : ℝ => n - 12) _ (tendsto_atTop_add_const_right _ (-12) tendsto_id)
    intro n
    rcases le_or_gt n 12 with h | h
    · nlinarith [sq_nonneg (n - 4), sq_nonneg (n - 3)]
    · nlinarith
  have h0 : Tendsto (fun n : ℝ => 1 / (2 * (n - 3) * (n - 4))) atTop (𝓝 0) := by
    have := hden.inv_tendsto_atTop
    refine this.congr fun n => ?_
    simp [one_div]
  have h1 : Tendsto (fun n : ℝ => 1 + 1 / (2 * (n - 3) * (n - 4))) atTop (𝓝 (1 + 0)) :=
    tendsto_const_nhds.add h0
  have h2 : (fun n : ℝ => 1 + 1 / (2 * (n - 3) * (n - 4))) = floorFormula := rfl
  rw [h2] at h1
  simpa using h1

/-! ## What a census delivers, and what it does not

*The audit's central count, as a theorem. It is stated for an arbitrary set of reals, and
instantiated at nothing, see the module docstring's "What is NOT typed here".*
-/

/-- **A CENSUS BOUNDS AN INFIMUM FROM ABOVE ONLY.** If `F` is a finite nonempty subsample of `S`
with least element `c`, then `sInf S ≤ c`. That is the whole of what a census of `571` points
licenses. -/
theorem census_bounds_from_above {S : Set ℝ} (hbdd : BddBelow S) {c : ℝ} (hc : c ∈ S) :
    sInf S ≤ c := csInf_le hbdd hc

/-- **AND THE INEQUALITY CAN BE STRICT**, so `min (census) = c` does not give `inf S = c`. Here
`S = [0,1]`, the subsample is `{1}`, its minimum is `1`, and `sInf S = 0`. This is why the source
wrote a question mark over the equals sign. -/
theorem census_can_be_strict :
    ∃ S : Set ℝ, ∃ c : ℝ, BddBelow S ∧ c ∈ S ∧ IsLeast {c} c ∧ sInf S < c := by
  refine ⟨Set.Icc (0:ℝ) 1, 1, bddBelow_Icc, ⟨by norm_num, le_refl 1⟩, ⟨rfl, by simp⟩, ?_⟩
  have h : sInf (Set.Icc (0:ℝ) 1) ≤ 0 :=
    csInf_le bddBelow_Icc (by norm_num : (0:ℝ) ∈ Set.Icc (0:ℝ) 1)
  linarith

/-- **The equality would need the reverse bound too.** `IsLeast S c` is `c ∈ S ∧ ∀ x ∈ S, c ≤ x`,
and only the first conjunct is what a census supplies. -/
theorem equality_needs_the_other_half {S : Set ℝ} {c : ℝ} (h : IsLeast S c) (hbdd : BddBelow S) :
    sInf S = c := le_antisymm (csInf_le hbdd h.1) (le_csInf ⟨c, h.1⟩ h.2)

/-! ## The off-locus table, checked against the claims made about it -/

/-- **The unscoped survival claim is refuted by the block's own three rows.** All three of
`0.608885`, `0.562755`, `0.553481` are below `1`, so *"`Δ > 0 ⇒ λ_max(L_e) ≥ 1` survives"* is
false without the diagonal scope. -/
theorem three_values_below_one :
    (0.608885 : ℝ) < 1 ∧ (0.562755 : ℝ) < 1 ∧ (0.553481 : ℝ) < 1 := by
  refine ⟨by norm_num, by norm_num, by norm_num⟩

/-- **The non-diagonal witness is a factor `1.68` below the `1.025` floor**, and `59.4%` of it. -/
theorem factor_below_floor :
    |(1.025 : ℝ) / 0.608885 - 1.68| < 1e-2 ∧ |(0.608885 : ℝ) / 1.025 - 0.594| < 1e-3 := by
  constructor <;> · rw [abs_lt]; constructor <;> norm_num

/-- **And *"less than half"* was false**: half of `1.025` is `0.5125`, which the witness exceeds. -/
theorem not_less_than_half : (1.025 : ℝ) / 2 = 0.5125 ∧ (0.5125 : ℝ) < 0.608885 := by
  constructor <;> norm_num

/-- **The off-locus cushion the block prints**: `0.553481 / 0.5 = 1.10696…`, the `1.1070` of the
table's last row. -/
theorem off_locus_cushion : |(0.553481 : ℝ) / 0.5 - 1.1070| < 1e-4 := by
  rw [abs_lt]; constructor <;> norm_num

/-! ## The lemma's own subject, now that `L_e` and the diagonal locus exist

*[FoxProduct.lean](../Base/FoxProduct.lean) carries `L_e` and the two Rayleigh readings, and
[Families.lean](../Base/Families.lean) carries the diagonal locus. So the census's subject, the
value of `λ_max(L_e|_{W^⊥})` at a diagonal `Δ > 0` critical point, is nameable here, and the
`≤` the audit says is earned is stated at that set rather than at an arbitrary one.*
-/

section Subject

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **`c` IS `λ_max(L_e|_{W^⊥})`**, in the quadratic-form reading
[FoxProduct.lean](../Base/FoxProduct.lean) fixes: an upper bound on the Rayleigh quotient over
`𝒲ₙ ∩ W^⊥` which is attained at one admissible direction of nonzero norm. *Both halves are needed:
`RayleighLE` alone is a bound and `RayleighGE` alone is a witness.* -/
def IsLamMax (W : CurvOp ι) (θ c : ℝ) : Prop := RayleighLE W θ c ∧ RayleighGE W θ c

/-- **The reading is single-valued**, so "the" `λ_max` is well posed. -/
theorem IsLamMax.unique {W : CurvOp ι} {θ c c' : ℝ} (h : IsLamMax W θ c) (h' : IsLamMax W θ c') :
    c = c' :=
  le_antisymm (h.2.le_of_RayleighLE h'.1) (h'.2.le_of_RayleighLE h.1)

/-- **A point of the census**: a unit-norm critical point of the diagonal locus with `θ > 0` and
`Δ > 0`.

*`Δ` is [conventions.md](../../../findings/conventions.md)'s **symmetry defect**, the trace of the
Petersen–Wink density over `{λ > 0}`; no layer below this one builds it, and it is a different
object from [AltPart.lean](../Base/AltPart.lean)'s Bianchi defect `δ²`. It therefore enters as a
parameter `defect` rather than being identified with anything.* -/
structure IsCensusPoint (defect : CurvOp ι → ℝ) (w : Matrix ι ι ℝ) (θ : ℝ) : Prop where
  weight : IsWeight w
  unit : normSq (diagOp w) = 1
  crit : IsCritical (diagOp w) θ
  thetaPos : 0 < θ
  defectPos : 0 < defect (diagOp w)

/-- **Every census point is a point of `𝒲ₙ`**, which is what makes the set the record's. -/
theorem IsCensusPoint.isWeyl {defect : CurvOp ι → ℝ} {w : Matrix ι ι ℝ} {θ : ℝ}
    (h : IsCensusPoint defect w θ) : IsWeyl (diagOp w) :=
  diagOp_isWeyl h.weight

/-- **THE SET THE CENSUS SAMPLES**: the values `λ_max(L_e|_{W^⊥})` takes over the diagonal
`Δ > 0` critical points at this dimension. -/
def floorValues (defect : CurvOp ι → ℝ) : Set ℝ :=
  {c | ∃ (w : Matrix ι ι ℝ) (θ : ℝ), IsCensusPoint defect w θ ∧ IsLamMax (diagOp w) θ c}

/-- **THE EARNED DIRECTION, AT THE RECORD'S OWN SET.** One censused point at value `c` bounds the
infimum of the whole set by `c`, and by nothing else. *This is `census_bounds_from_above`
instantiated at the subject the module docstring used to say was unnameable.* -/
theorem census_upper_bound {defect : CurvOp ι → ℝ} (hbdd : BddBelow (floorValues defect))
    {w : Matrix ι ι ℝ} {θ c : ℝ} (hpt : IsCensusPoint defect w θ) (hval : IsLamMax (diagOp w) θ c) :
    sInf (floorValues defect) ≤ c :=
  csInf_le hbdd ⟨w, θ, hpt, hval⟩

/-- **THE CENSUS'S CLAIM, IN THE DIRECTION IT LICENSES**: `inf λ_max(L_e|_{W^⊥}) ≤ 1 + 1/(2(n-3)(n-4))`
over the diagonal `Δ > 0` critical points at dimension `n = card ι`.

**THE WITNESS IS A HYPOTHESIS, AND IT HAS TO BE.** *An earlier form of this theorem quantified over
`defect` with no witness clause, which asserted the bound for EVERY real-valued function on
curvature operators, and that is refutable on the record's own data*: at `n = 9` the record's
unpadded witness carries `λ_max = 1.303584` against `floorFormula 9 = 61/60`, so a `defect` picking
out that point alone gives an infimum above the formula. **The content of the census is the
existence of the point, so the point is what the statement must carry.**

*Discharging `hwitness` means exhibiting, at each `n`, a weight `w` with `diagOp w` a unit-norm
critical point of `P` carrying `θ > 0`, `Δ > 0` and `λ_max(L_e|_{W^⊥}) = 1 + 1/(2(n-3)(n-4))`. The
record holds `571` of these as measured data at `n = 6…16`; none is constructed at this layer, and
the criticality of a named weight needs `Qop` on the diagonal locus, which
[Families.lean](../Base/Families.lean) records under `DiagCubicFormula`, PROVED in [SharpDiag.lean](../Base/SharpDiag.lean).* -/
theorem diagonal_floor_le {defect : CurvOp ι → ℝ} (hbdd : BddBelow (floorValues defect))
    (hwitness : ∃ (w : Matrix ι ι ℝ) (θ : ℝ), IsCensusPoint defect w θ ∧
      IsLamMax (diagOp w) θ (floorFormula (Fintype.card ι))) :
    sInf (floorValues defect) ≤ floorFormula (Fintype.card ι) := by
  obtain ⟨w, θ, hpt, hval⟩ := hwitness
  exact census_upper_bound hbdd hpt hval

/-- **THE HEADING'S `=`, NAMED AND NOT ASSERTED.** `IsLeast` is the conjunction the equality needs:
the value is attained *and* it is a lower bound. A census supplies the first conjunct at one point
and never the second. -/
def DiagFloorExact (defect : CurvOp ι → ℝ) : Prop :=
  IsLeast (floorValues defect) (floorFormula (Fintype.card ι))

/-- **What the equality would give**, if it were earned: the infimum, not merely a bound on it. -/
theorem DiagFloorExact.sInf_eq {defect : CurvOp ι → ℝ} (h : DiagFloorExact defect) :
    sInf (floorValues defect) = floorFormula (Fintype.card ι) :=
  equality_needs_the_other_half h ⟨_, h.2⟩

/-- **`Δ > 0 ⇒ λ_max(L_e) ≥ 1`, SCOPED TO THE DIAGONAL LOCUS**, the reading the block says
survives. It is a consequence of the floor formula wherever that formula is a genuine lower bound,
because the formula's value strictly exceeds `1` at every `n > 4`. -/
theorem DiagFloorExact.strong_reading {defect : CurvOp ι → ℝ} (h : DiagFloorExact defect)
    (hn : 4 < (Fintype.card ι : ℝ)) {w : Matrix ι ι ℝ} {θ c : ℝ}
    (hpt : IsCensusPoint defect w θ) (hval : IsLamMax (diagOp w) θ c) : 1 < c :=
  lt_of_lt_of_le (floor_gt_one hn) (h.2 ⟨w, θ, hpt, hval⟩)

/-- **THE SAME READING WITHOUT THE SCOPE**, over every critical point of `𝒲ₙ` rather than the
diagonal ones. *This is the sentence the block writes unscoped.* -/
def UnscopedStrongReading (defect : CurvOp ι → ℝ) : Prop :=
  ∀ (W : CurvOp ι) (θ c : ℝ), IsWeylOp W → IsCritical W θ → 0 < θ → 0 < defect W →
    IsLamMax W θ c → 1 ≤ c

/-- **AND ONE OFF-LOCUS POINT REFUTES IT.** A `Δ > 0` critical point of `𝒲ₙ` whose `λ_max(L_e)` is
below `1` contradicts the unscoped reading outright. *The block's own table prints three such
values, `0.608885`, `0.562755`, `0.553481`, and `three_values_below_one` checks that all three are
below `1`; that they are `λ_max(L_e)` at critical points is measured, so the witness enters here as
a hypothesis and the conclusion is the refutation it forces.* -/
theorem unscoped_refuted {defect : CurvOp ι → ℝ} {W : CurvOp ι} {θ c : ℝ}
    (hW : IsWeylOp W) (hcrit : IsCritical W θ) (hθ : 0 < θ) (hΔ : 0 < defect W)
    (hval : IsLamMax W θ c) (hlt : c < 1) : ¬ UnscopedStrongReading defect := by
  intro h
  exact absurd (h W θ c hW hcrit hθ hΔ hval) (by linarith)

/-- **`λ_max(L_e|_{W^⊥}) ≥ 1` IS `RayleighGE W θ 1`**, which is the shape
[L99](L99Statement.lean) delivers at a point with two edge-carrying components. *So L99 puts
points into `floorValues` above `1` without any census.* -/
theorem one_le_of_RayleighGE {W : CurvOp ι} {θ c : ℝ} (hge : RayleighGE W θ 1)
    (hval : IsLamMax W θ c) : 1 ≤ c := hge.le_of_RayleighLE hval.1

end Subject

end HamiltonsCubic.L98Statement
