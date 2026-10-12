import HamiltonsCubic.Results.L190Statement
import HamiltonsCubic.Results.L183Statement

/-!
# L191, the pair rigidity, and the branch it leaves inhabited at `dim V = 4`

**`falsifier_at_dim4` is the falsifier both Gate 2 reviewers built independently**, and it fixes
L191's reach: the pair statement is FALSE one dimension below its hypothesis. *`unitSD 0` and
`unitSD 1` are orthonormal, satisfy both coincidences, and are equal neither to each other nor to
each other's negative, which is exactly what L191's conclusion forbids.*

**The distinctness is the load-bearing half.** *`pair_coincidences_at_dim4` states the two
coincidences alone, and every configuration with `omega_2 = omega_1` satisfies those, so it is
consistent with L191 holding at `dim V = 4` and falsifies nothing on its own.* It is kept as the
statement about the whole family, where `falsifier_at_dim4` is the witness.

**Weyl-ness is NOT typed here.** *That the pair assembles into a Ricci-flat first-Bianchi tensor is
carried in the block, and `IsWeyl` is never applied in this file, so the inhabitation of the
rank-two WEYL branch at `dim V = 4` rests on the record rather than on the kernel.*

**The lemma itself is proved in [L191Proof.lean](L191Proof.lean)**, as `L191`, without the
record's three cases: a frame of the common support carries both forms to `ℝ⁶`, and the adjugate
law of [L193](L193Statement.lean) forces `ω₂ = ±ω₁`.

*`Phi` is [SelfDual.lean](../Base/SelfDual.lean)'s `(X², X ∧ X)`, which is the record's map, so
"the images coincide" and "the squares and the self-wedges coincide" are the same statement.*
-/

set_option linter.style.longLine false
set_option maxHeartbeats 1000000
set_option maxRecDepth 8000

namespace HamiltonsCubic.L191Statement

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer HamiltonsCubic.L190Statement

/-- **`ω ∧ ω = ‖ω‖² f₁₂₃₄` on every member of `Λ⁺ℝ⁴`**, the self-wedge of a self-dual form being
its norm. -/
theorem wedgeSelf_sdCombo_apply (x y z : ℝ) :
    wedgeSelf (sdCombo x y z) 0 1 2 3 = 2 * (x ^ 2 + y ^ 2 + z ^ 2) := by
  have s0 : sdForm 0 = phi 0 1 + phi 2 3 := rfl
  have s1 : sdForm 1 = phi 0 2 - phi 1 3 := rfl
  have s2 : sdForm 2 = phi 0 3 + phi 1 2 := rfl
  have hp : ∀ i j a b : Fin 4, phi i j a b
      = (if j = a then (if i = b then (1 : ℝ) else 0) else 0)
        - (if i = a then (if j = b then (1 : ℝ) else 0) else 0) := by
    intro i j a b
    simp only [phi, Matrix.sub_apply, Matrix.single_apply, ite_and]
  show wedgeSelf (x • (phi 0 1 + phi 2 3) + y • (phi 0 2 - phi 1 3) + z • (phi 0 3 + phi 1 2))
      0 1 2 3 = _
  simp only [wedgeSelf_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply,
    smul_eq_mul, hp]
  simp
  ring

/-- **Both coincidences hold across `Λ⁺ℝ⁴` at equal norm**: any two members have equal squares and
equal self-wedges. *This is the family statement. It carries no distinctness, so it is satisfied by
`omega_2 = omega_1` and falsifies nothing by itself; `falsifier_at_dim4` below supplies the witness.*
The self-wedges are compared at the `(0,1,2,3)` component of `Λ⁴ℝ⁴`. -/
theorem pair_coincidences_at_dim4 (x y z u v w : ℝ)
    (hn : x ^ 2 + y ^ 2 + z ^ 2 = u ^ 2 + v ^ 2 + w ^ 2) :
    sdCombo x y z * sdCombo x y z = sdCombo u v w * sdCombo u v w ∧
      wedgeSelf (sdCombo x y z) 0 1 2 3 = wedgeSelf (sdCombo u v w) 0 1 2 3 := by
  constructor
  · rw [sdCombo_sq, sdCombo_sq, hn]
  · rw [wedgeSelf_sdCombo_apply, wedgeSelf_sdCombo_apply, hn]

/-- **The same at unit norm**, which is the configuration the rank-two branch actually presents:
an orthonormal pair with `Φ(ω₁) = Φ(ω₂)` on both components. -/
theorem unitSD_coincidences (i j : Fin 3) :
    unitSD i * unitSD i = unitSD j * unitSD j ∧
      wedgeSelf (unitSD i) 0 1 2 3 = wedgeSelf (unitSD j) 0 1 2 3 :=
  ⟨by rw [unitSD_sq, unitSD_sq], by rw [wedgeSelf_unitSD_apply, wedgeSelf_unitSD_apply]⟩

theorem inner2_neg_right (X Y : Matrix (Fin 4) (Fin 4) ℝ) :
    inner2 X (-Y) = - inner2 X Y := by
  simp [inner2, Matrix.mul_neg, Matrix.trace_neg]

/-- **THE FALSIFIER, WITH THE HALF THAT MAKES IT ONE.** *`unitSD 0` and `unitSD 1` are orthonormal,
they satisfy BOTH of L191's coincidences, and they are equal neither to each other nor to each
other's negative*, which is what the conclusion `omega_2 = plus or minus omega_1` forbids. **So L191's conclusion fails at
`dim V = 4` and its six-dimensionality is sharp.**

*The distinctness is the load-bearing half and was absent from `pair_coincidences_at_dim4`, which
every configuration with `omega_2 = omega_1` also satisfies. It costs one matrix entry: the two
forms disagree at `(0,1)`, and orthonormality is the shorter route to the same fact.*

**The self-wedge clause is the FULL equality in `Λ⁴`**, `wedgeSelf_unitSD_eq` from
[L183Statement.lean](L183Statement.lean), rather than the `(0,1,2,3)` component alone: L191's
hypothesis is an equation in `Λ⁴`, and one component of it is a weaker thing that happened to be
what this file had imported.

**The last two clauses carry L191's COMMON SUPPORT hypothesis**, which orthonormality does not
supply and which was absent when this statement first answered its reviewers: each form is
invertible, so each has range all of `ℝ⁴` and the two supports coincide there. *Without them the
conjunction was consistent with the four-dimensional analogue holding, which is the shape of the
defect the declaration was written to close.* -/
theorem falsifier_at_dim4 :
    inner2 (unitSD 0) (unitSD 0) = 1 ∧ inner2 (unitSD 1) (unitSD 1) = 1 ∧
      inner2 (unitSD 0) (unitSD 1) = 0 ∧
      unitSD 0 * unitSD 0 = unitSD 1 * unitSD 1 ∧
      wedgeSelf (unitSD 0) = wedgeSelf (unitSD 1) ∧
      unitSD 1 ≠ unitSD 0 ∧ unitSD 1 ≠ -unitSD 0 ∧
      (∃ ν, unitSD 0 * ν = 1) ∧ (∃ ν, unitSD 1 * ν = 1) := by
  have h00 : inner2 (unitSD 0) (unitSD 0) = 1 := by rw [inner2_unitSD]; simp
  have h01 : inner2 (unitSD 0) (unitSD 1) = 0 := by rw [inner2_unitSD]; simp
  have hinv : ∀ k : Fin 3, ∃ ν, unitSD k * ν = 1 := by
    intro k
    refine ⟨(-2 : ℝ) • unitSD k, ?_⟩
    rw [Matrix.mul_smul, unitSD_sq]
    module
  refine ⟨h00, by rw [inner2_unitSD]; simp, h01, by rw [unitSD_sq, unitSD_sq],
    HamiltonsCubic.L183.wedgeSelf_unitSD_eq 0 1, ?_, ?_, hinv 0, hinv 1⟩
  · intro h
    rw [h, h00] at h01
    exact one_ne_zero h01
  · intro h
    rw [h, inner2_neg_right, h00] at h01
    norm_num at h01

end HamiltonsCubic.L191Statement
