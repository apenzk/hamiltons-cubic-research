import Mathlib
import HamiltonsCubic.Results.I117Statements

set_option linter.style.longLine false

/-!
# L268's uniform clause, both directions

[findings/second-order.md](../../../findings/second-order.md), Lemma L268: *"The uniform point $\mu\equiv1/c$
solves it exactly when $c=2(m-1)$."* [I117Statements.lean](I117Statements.lean) proves the backward half
(`L268_uniform`) and the idempotency equivalence `L268_torus_idem`, and the L268 row owes *"the operator-level
converse of the uniform clause, c=2(m−1) only"*. This file closes it:

* `uniform_first`: at the uniform weights `u` off the diagonal, the first root equation of any pair reads
  `u(1 - 4(m - 1)u²) = 2(m - 2)u²`, from `sum_off_one` and `sum_off_two`;
* `L268_uniform_iff`: for `m ≥ 3` and `c > 0`, the uniform point `μ ≡ 1/c` solves the system exactly when
  `c = 2(m - 1)`; the forward half multiplies the pair equation by `c³`, giving `(c - 2(m - 1))(c + 2) = 0`;
* `L268_uniform_op`: at the operator level, `torusOp A (μ ≡ 1/c) (μ ≡ 1/c)` with `A` symmetric is idempotent
  exactly when `A = A_μ` and `c = 2(m - 1)`.
-/

namespace HamiltonsCubic.L268Uniform

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.I117S Matrix Finset

variable {m : ℕ}

/-- The uniform root weights: `u` off the diagonal, `0` on it. -/
def uniM (m : ℕ) (u : ℝ) : Matrix (Fin m) (Fin m) ℝ := Matrix.of fun k l => if k = l then 0 else u

theorem uniM_pair (u : ℝ) : IsPairWeights (uniM m u) := by
  refine ⟨?_, fun i => by simp [uniM]⟩
  ext i j
  simp only [uniM, Matrix.transpose_apply, Matrix.of_apply]
  split_ifs with h1 h2 h2 <;> simp_all

/-- **The pair equation at the uniform weights.** -/
theorem uniform_first (u : ℝ) (i j : Fin m) (hij : i ≠ j) :
    (uniM m u i j * (1 - dvec (uniM m u) (uniM m u) i - dvec (uniM m u) (uniM m u) j
        + 2 * (uniM m u i j ^ 2 - uniM m u i j ^ 2)) = (uniM m u * uniM m u + uniM m u * uniM m u) i j) ↔
      u * (1 - 4 * ((m : ℝ) - 1) * u ^ 2) = 2 * ((m : ℝ) - 2) * u ^ 2 := by
  have hd : ∀ k : Fin m, ∑ l : Fin m, ((if k = l then (0 : ℝ) else u) ^ 2 + (if k = l then 0 else u) ^ 2)
      = ((m : ℝ) - 1) * (2 * u ^ 2) := fun k =>
    sum_off_one k _ _ (fun l hl => by rw [if_neg (Ne.symm hl)]; ring) (by simp)
  have hp : ∑ l : Fin m, (if i = l then (0 : ℝ) else u) * (if l = j then 0 else u) = ((m : ℝ) - 2) * u ^ 2 :=
    sum_off_two i j hij _ _ (fun l hli hlj => by rw [if_neg (Ne.symm hli), if_neg hlj]; ring) (by simp)
      (by simp)
  simp only [uniM, dvec, Matrix.add_apply, Matrix.mul_apply, Matrix.of_apply]
  simp only [hd, hp, if_neg hij]
  constructor <;> intro h <;> linear_combination h

/-- **L268's uniform clause**: `μ ≡ 1/c` solves the torus system exactly when `c = 2(m - 1)`. -/
theorem L268_uniform_iff (hm : 3 ≤ m) (c : ℝ) (hc : 0 < c) :
    TorusSystem (uniM m (1 / c)) (uniM m (1 / c)) ↔ c = 2 * ((m : ℝ) - 1) := by
  constructor
  · intro hsys
    have hne : (⟨0, by omega⟩ : Fin m) ≠ ⟨1, by omega⟩ := fun h => by simp [Fin.ext_iff] at h
    have h := (uniform_first (1 / c) _ _ hne).mp (hsys _ _ hne).1
    set u : ℝ := 1 / c with hu
    have huc : u * c = 1 := by rw [hu]; field_simp
    have key : (c - 2 * ((m : ℝ) - 1)) * (c + 2) = 0 := by
      linear_combination c ^ 3 * h
        + (-c ^ 2 + 4 * ((m : ℝ) - 1) * (u ^ 2 * c ^ 2 + u * c + 1) + 2 * ((m : ℝ) - 2) * c * (u * c + 1)) * huc
    rcases mul_eq_zero.mp key with h1 | h1
    · linarith
    · linarith
  · intro h
    rw [h]
    exact L268_uniform m hm

/-- **The operator form**: the torus operator at the uniform weights `1/c` is idempotent exactly when its
Cartan block is `A_μ` and `c = 2(m - 1)`. -/
theorem L268_uniform_op (hm : 3 ≤ m) (c : ℝ) (hc : 0 < c) (A : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) :
    IsIdem (torusOp A (uniM m (1 / c)) (uniM m (1 / c))) ↔
      A = Amu (uniM m (1 / c)) (uniM m (1 / c)) ∧ c = 2 * ((m : ℝ) - 1) := by
  rw [L268_torus_idem hm A _ _ hA (uniM_pair _) (uniM_pair _), L268_uniform_iff hm c hc]

end HamiltonsCubic.L268Uniform
