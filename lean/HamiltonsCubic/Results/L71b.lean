import HamiltonsCubic.Base.Spectrum

/-!
# L71's three inclusions, at the point where L70 saturates

L70's equality case gives, with `𝔪 = E_min`, `𝔥 = E_max` and `𝔯` the rest,

`⁅𝔪,𝔪⁆ ⊆ 𝔥`,  `⁅𝔪,𝔥⁆ ⊆ 𝔪`,  `⁅𝔪,𝔯⁆ = 0`,

and [L71](L71.lean) proves those three are Lie identities away. **The competitor
saturates the identity**, [L70b](L70b.lean), so the inclusions should hold
there, and here they are checked.

At `W_{ℂP²}`: `𝔥 = ⟨a⟩` with `a = φ₀₁+φ₂₃`, `𝔪 = ⟨b,c⟩` with `b = φ₀₂-φ₁₃` and
`c = φ₀₃+φ₁₂`, and `𝔯` the anti-self-dual forms, which are the kernel.

**Checked by inner products, not by producing brackets.** An inclusion
`⁅x,y⁆ ∈ ⟨z⟩` is that the bracket pairs to zero against the rest of the basis,
which avoids needing the structure constant and says exactly what the inclusion
says.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- `𝔥`: the `+2` eigenvector. -/
def sdA : Matrix (Fin 4) (Fin 4) ℚ := basis4 0 + basis4 5

/-- `𝔪`: the two `-1` eigenvectors. -/
def sdB : Matrix (Fin 4) (Fin 4) ℚ := basis4 1 - basis4 4
def sdC : Matrix (Fin 4) (Fin 4) ℚ := basis4 2 + basis4 3

/-- `𝔯`: the anti-self-dual forms, which are `W_{ℂP²}`'s kernel. -/
def asdA : Matrix (Fin 4) (Fin 4) ℚ := basis4 0 - basis4 5
def asdB : Matrix (Fin 4) (Fin 4) ℚ := basis4 1 + basis4 4
def asdC : Matrix (Fin 4) (Fin 4) ℚ := basis4 2 - basis4 3

/-- **`⁅𝔪,𝔪⁆ ⊆ 𝔥`**: `⁅b,c⁆` pairs to zero against everything but `a`. -/
theorem mm_in_h :
    inner2 (br sdB sdC) sdB = 0 ∧ inner2 (br sdB sdC) sdC = 0 ∧
    inner2 (br sdB sdC) asdA = 0 ∧ inner2 (br sdB sdC) asdB = 0 ∧
    inner2 (br sdB sdC) asdC = 0 := by
  refine ⟨?_, ?_, ?_, ?_, ?_⟩ <;>
    simp [inner2, br, sdA, sdB, sdC, asdA, asdB, asdC, basis4, phi, Matrix.trace, Matrix.diag,
      Matrix.mul_apply, Matrix.transpose_apply, Fin.sum_univ_four, Matrix.single_apply,
      Matrix.add_apply, Matrix.sub_apply] <;> ring

/-- **`⁅𝔪,𝔥⁆ ⊆ 𝔪`**: `⁅b,a⁆` pairs to zero against `a` and against all of `𝔯`. -/
theorem mh_in_m :
    inner2 (br sdB sdA) sdA = 0 ∧
    inner2 (br sdB sdA) asdA = 0 ∧ inner2 (br sdB sdA) asdB = 0 ∧
    inner2 (br sdB sdA) asdC = 0 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;>
    simp [inner2, br, sdA, sdB, sdC, asdA, asdB, asdC, basis4, phi, Matrix.trace, Matrix.diag,
      Matrix.mul_apply, Matrix.transpose_apply, Fin.sum_univ_four, Matrix.single_apply,
      Matrix.add_apply, Matrix.sub_apply] <;> ring

/-- **`⁅𝔪,𝔯⁆ = 0`**, on the nose, the self-dual and anti-self-dual parts of
`𝔰𝔬(4)` commute. -/
theorem mr_zero :
    br sdB asdA = 0 ∧ br sdB asdB = 0 ∧ br sdB asdC = 0 ∧
    br sdC asdA = 0 ∧ br sdC asdB = 0 ∧ br sdC asdC = 0 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;>
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [sdA, sdB, sdC, asdA, asdB, asdC, basis4, phi, br, Matrix.mul_apply,
        Fin.sum_univ_four, Matrix.single_apply, Matrix.add_apply, Matrix.sub_apply,
        Matrix.zero_apply] <;> ring

end HamiltonsCubic.Base
