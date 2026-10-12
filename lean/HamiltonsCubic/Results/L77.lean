import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# L77, `γ = 2S_{𝔪𝔥𝔥}`, and what the open factor does not affect

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L77, refuted as stated and
repaired by restoring isotropy.

**The `n = 4` witness's second half, computed.** Take `𝔪 = 𝔰𝔬(3) ⊂ 𝔰𝔬(4)`, so
`𝔪^⊥ = span{φ₁₄, φ₂₄, φ₃₄}`. Then `[φ₁₄, φ₂₄] = -φ₁₂`, which lies in `𝔪` and **not** in
`𝔪^⊥`, proved from the matrices below. So `𝔪^⊥` is not a subalgebra, while the witness has
`γ = 0`: the *"iff"* fails in that direction without isotropy, which is the hypothesis the
statement omitted.

**The open factor of `2` does not reach the conclusion.** The two reviewers disagree on
whether the identity reads `γ = 2S` or `γ = S`, traced to a normalisation collision absent
from [conventions.md](../../../findings/conventions.md). **The lemma's conclusion is
unaffected**: `γ = cS` with any `c ≠ 0` gives `γ = 0 ↔ S = 0`, so the *"iff"* holds under
either reading. The dispute is real for the *value* (`2S ≠ S` wherever `S ≠ 0`) and empty
for the *statement*. The record lists it as open without noting the separation.
-/

namespace HamiltonsCubic.GammaS

/-! ## The open factor is irrelevant to the conclusion -/

/-- **`γ = cS` with `c ≠ 0` gives `γ = 0 ↔ S = 0`** for any `c`, so the lemma's *"iff"* is
the same statement under either normalisation. -/
theorem iff_independent_of_factor {γ S c : ℚ} (hc : c ≠ 0) (h : γ = c * S) :
    γ = 0 ↔ S = 0 := by
  constructor
  · intro hg
    rw [h] at hg
    rcases mul_eq_zero.1 hg with h' | h'
    · exact absurd h' hc
    · exact h'
  · intro hs; rw [h, hs]; ring

/-- **But the dispute is real for the value**: `2S = S` only when `S = 0`, so the two
readings disagree everywhere the quantity is nonzero. -/
theorem factor_matters {S : ℚ} (h : 2 * S = S) : S = 0 := by linarith

/-- So the normalisation collision affects every computed `γ` and no stated conclusion. -/
theorem separation {S : ℚ} (hS : S ≠ 0) : 2 * S ≠ S := fun h => hS (factor_matters h)

/-! ## The `n = 4` witness: `𝔪^⊥` is not a subalgebra -/

/-- `φ₁₄`, `φ₂₄` and `φ₁₂` as `4×4` matrices. -/
def phi14 : Matrix (Fin 4) (Fin 4) ℚ := !![0, 0, 0, 1; 0, 0, 0, 0; 0, 0, 0, 0; -1, 0, 0, 0]

def phi24 : Matrix (Fin 4) (Fin 4) ℚ := !![0, 0, 0, 0; 0, 0, 0, 1; 0, 0, 0, 0; 0, -1, 0, 0]

def phi34 : Matrix (Fin 4) (Fin 4) ℚ := !![0, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 1; 0, 0, -1, 0]

def phi12 : Matrix (Fin 4) (Fin 4) ℚ := !![0, 1, 0, 0; -1, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0]

/-- **`[φ₁₄, φ₂₄] = -φ₁₂`**, computed from the entries. -/
theorem bracket_leaves : phi14 * phi24 - phi24 * phi14 = -phi12 := by
  unfold phi14 phi24 phi12
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_succ]

/-- The result has a nonzero `(1,2)` entry. -/
theorem bracket_entry : (phi14 * phi24 - phi24 * phi14) 0 1 = -1 := by
  rw [bracket_leaves]
  unfold phi12
  simp

/-- **And every generator of `𝔪^⊥` vanishes there**, so the bracket leaves the span: `𝔪^⊥`
is not a subalgebra. -/
theorem complement_vanishes_at_entry :
    phi14 0 1 = 0 ∧ phi24 0 1 = 0 ∧ phi34 0 1 = 0 := by
  unfold phi14 phi24 phi34
  refine ⟨by simp, by simp, by simp⟩

/-- Hence no linear combination of the complement's generators can equal the bracket. -/
theorem not_closed (a b c : ℚ) :
    a * phi14 0 1 + b * phi24 0 1 + c * phi34 0 1
      ≠ (phi14 * phi24 - phi24 * phi14) 0 1 := by
  rw [bracket_entry]
  obtain ⟨h1, h2, h3⟩ := complement_vanishes_at_entry
  rw [h1, h2, h3]
  norm_num

end HamiltonsCubic.GammaS
