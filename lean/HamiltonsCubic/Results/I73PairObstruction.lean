import HamiltonsCubic.Base.WeylReal

set_option linter.style.longLine false

/-!
# Why the pair direction's two obstructions are DISJOINT, and the dichotomy that follows

The admissible direction of route [R33](../../../routes.md) is `π_{Weyl} (u ⊙ v)`, and what the
projection removes is a `Λ⁴` part and a Ricci part. **For two COORDINATE planes exactly one of
those two is ever present**, which is why the norm of the surviving direction has two values and
not a spectrum of them:

* **disjoint planes** `{i,j} ∩ {k,l} = ∅`: the product `φ_ij * φ_kl` is the zero matrix, so the
  anticommutator carrying the Ricci contraction vanishes and the whole loss is the `Λ⁴` part,
  which involves four indices and is therefore the same at every `n`;
* **planes sharing an index**: the `Λ⁴` component is a wedge of two bivectors with a common
  index and vanishes, so the whole loss is Ricci, whose projector carries the `n`.

**THIS FILE TYPES THE FIRST BULLET**, which is the one that is pure matrix algebra. *The second
is a statement about the `Λ⁴` component and needs the decomposition; the record carries the
measurement and this file does not claim it.*

*No orthogonal projector onto `Weyl_n` exists in this layer, so the norms themselves are not
typed here: `IsWeyl` is a predicate and nothing constructs the projection.*
-/

namespace HamiltonsCubic.Results

open Matrix HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Two coordinate bivectors on disjoint index pairs MULTIPLY TO ZERO.**

*Each `phi` is supported on the two entries its own pair names, so with no index in common the
row that one writes is a row the other never reads.* -/
theorem phi_mul_phi_of_disjoint {i j k l : ι}
    (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) :
    phi i j * phi k l = (0 : Matrix ι ι ℝ) := by
  ext a b
  rw [Matrix.mul_apply, Matrix.zero_apply]
  refine Finset.sum_eq_zero fun c _ => ?_
  -- `phi i j a c` is supported on `c ∈ {i, j}`; `phi k l c b` on `c ∈ {k, l}`.
  by_cases hc : c = i ∨ c = j
  · -- `phi k l` is supported on columns `k` and `l`, and `c` is neither
    have hck : k ≠ c := by rcases hc with rfl | rfl <;> exact Ne.symm ‹_›
    have hcl : l ≠ c := by rcases hc with rfl | rfl <;> exact Ne.symm ‹_›
    have h2 : phi k l c b = 0 := by
      simp [phi, Matrix.single, Matrix.of_apply, hck, hcl]
    rw [h2, mul_zero]
  · -- `phi i j` is supported on columns `i` and `j`, and `c` is neither
    push_neg at hc
    have h1 : phi i j a c = 0 := by
      simp [phi, Matrix.single, Matrix.of_apply, Ne.symm hc.1, Ne.symm hc.2]
    rw [h1, zero_mul]

/-- **Hence the anticommutator vanishes**, which is the object carrying the Ricci contraction of
`u ⊙ v`. *So a disjoint pair loses nothing to Ricci and everything to `Λ⁴`.* -/
theorem phi_anticomm_of_disjoint {i j k l : ι}
    (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) :
    phi i j * phi k l + phi k l * phi i j = (0 : Matrix ι ι ℝ) := by
  rw [phi_mul_phi_of_disjoint hik hil hjk hjl,
    phi_mul_phi_of_disjoint (Ne.symm hik) (Ne.symm hjk) (Ne.symm hil) (Ne.symm hjl)]
  simp

end HamiltonsCubic.Results
