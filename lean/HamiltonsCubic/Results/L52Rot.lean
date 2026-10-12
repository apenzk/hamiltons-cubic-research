import Mathlib
import HamiltonsCubic.Results.L52Remarks

set_option linter.style.longLine false

/-!
# L52's "only if" example: the rotation `U` behind `rot4`

[L52Remarks.lean](L52Remarks.lean) declares `rot4`, the doubly stochastic matrix
`[[½, ½, 0], [½, ½, 0], [0, 0, 1]]`, as *"the entrywise squares of the `π/4` rotation in the `e₀e₁` plane
... (not declared)"*, and the L52 row owes *"the rotation $U$ with $\lvert U\rvert^2=$ `rot4`"*:

* `U4`: the rotation by `π/4` in the `e₀e₁` plane, entries `±1/√2` there and `1` at `(2,2)`;
* `U4_orth`: `U4ᵀ U4 = 1`;
* `U4_sq`: `U4_ij² = rot4 i j`, so `rot4` is `|U4|²`;
* `U4_fixes`: `U4 diag(1,1,2) U4ᵀ = diag(1,1,2)`, the rotation stays inside the repeated eigenplane of
  `mu4 = (1, 1, 2)`, so `U4` is an eigenbasis change of `diag(mu4)` whose `|U|²` is no permutation.
-/

namespace HamiltonsCubic.L52Rot

open Matrix HamiltonsCubic.DoublyStochastic

/-- `1/√2`. -/
noncomputable def c : ℝ := 1 / Real.sqrt 2

theorem c_sq : c ^ 2 = 1 / 2 := by
  unfold c; rw [div_pow, Real.sq_sqrt (by norm_num)]; norm_num

/-- The rotation by `π/4` in the `e₀e₁` plane. -/
noncomputable def U4 : Matrix (Fin 3) (Fin 3) ℝ := !![c, -c, 0; c, c, 0; 0, 0, 1]

theorem U4_orth : U4ᵀ * U4 = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [U4, Matrix.mul_apply, Fin.sum_univ_three] <;> nlinarith [c_sq]

theorem U4_sq (i j : Fin 3) : U4 i j ^ 2 = rot4 i j := by
  fin_cases i <;> fin_cases j <;> simp [U4, rot4, c_sq]

theorem U4_fixes :
    U4 * Matrix.diagonal mu4 * U4ᵀ = Matrix.diagonal mu4 := by
  have hc : c * c = 1 / 2 := by rw [← pow_two]; exact c_sq
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [U4, mu4, Matrix.mul_apply, Fin.sum_univ_three, Matrix.transpose_apply, Matrix.vecMul_diagonal] <;>
    nlinarith [hc]

end HamiltonsCubic.L52Rot
