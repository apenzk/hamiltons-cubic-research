import HamiltonsCubic.Results.L71b

/-!
# L30, Ricci-flatness as the eigenbasis identity

L30's descent opens with a reading of Ricci-flatness:

> Ricci-flatness is the positive-semidefinite identity
> `Σ_α λ_α v_α v_αᵀ = 0`, so every eigenvector **with nonzero eigenvalue** has
> its image in `U`.

**That identity is what the descent runs on**, and it is checked here at the
competitor. Its eigenvectors are the self-dual forms `a, b, c` of
[L71b](L71b.lean) with eigenvalues `2, -1, -1`; the kernel contributes nothing,
which is the *nonzero eigenvalue* clause doing its work.

Each of `a, b, c` is a complex structure on `ℝ⁴`, so `v vᵀ = -v² = I` and the
identity reduces to `2 - 1 - 1 = 0` on the coefficients, the trace-free
condition on the spectrum, seen on `ℝ⁴` rather than on `Λ²`.

*The constant is `1`, not `2`.* Each 2-plane block of `a` squares to `-I₂`, so
`a² = -I₄`. The `2` is `‖a‖²` under the half-trace pairing, and that is a
different quantity, the two were conflated when this file was first written,
and the three checks below caught it while the combination above passed.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- Each self-dual form squares to a multiple of the identity, the fact that
makes the identity collapse to the spectrum's trace. -/
theorem sdA_sq : sdA * sdAᵀ = (1 : Matrix (Fin 4) (Fin 4) ℚ) := by
  ext a b
  fin_cases a <;> fin_cases b <;>
    simp [sdA, basis4, phi, Matrix.mul_apply, Fin.sum_univ_four, Matrix.single_apply,
      Matrix.transpose_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.one_apply] <;> ring

theorem sdB_sq : sdB * sdBᵀ = (1 : Matrix (Fin 4) (Fin 4) ℚ) := by
  ext a b
  fin_cases a <;> fin_cases b <;>
    simp [sdB, basis4, phi, Matrix.mul_apply, Fin.sum_univ_four, Matrix.single_apply,
      Matrix.transpose_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.one_apply] <;> ring

theorem sdC_sq : sdC * sdCᵀ = (1 : Matrix (Fin 4) (Fin 4) ℚ) := by
  ext a b
  fin_cases a <;> fin_cases b <;>
    simp [sdC, basis4, phi, Matrix.mul_apply, Fin.sum_univ_four, Matrix.single_apply,
      Matrix.transpose_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.one_apply] <;> ring

/-- **Ricci-flatness in the eigenbasis, at the competitor.** The three nonzero
eigenvalues weight the three self-dual forms, and the sum vanishes. -/
theorem WCP2_ricci_eigenbasis :
    (2 : ℚ) • (sdA * sdAᵀ) - (sdB * sdBᵀ) - (sdC * sdCᵀ) = 0 := by
  rw [sdA_sq, sdB_sq, sdC_sq, two_smul]
  abel

/-- So the identity is the spectrum's trace-freeness, read on `ℝ⁴`: the nonzero
eigenvalues sum to zero, and each form contributes the same `I`. -/
theorem spectrum_traceless : (2 : ℚ) + (-1) + (-1) = 0 := by norm_num

end HamiltonsCubic.Base
