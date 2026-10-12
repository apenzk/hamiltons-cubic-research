import Mathlib
import HamiltonsCubic.Results.FourProd
import HamiltonsCubic.Results.L222Op

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220 step 2's other two products: `Π_Q` is a subalgebra, and `D ∘ ν ∈ V_Q`

[findings/second-order.md](../../../findings/second-order.md), Lemma L220, step 2: *$\Pi_Q$ is a subalgebra of $\mathcal D_n$, since a hollow
matrix supported on $Q$ with zero row sums has $S^{\circ2}+S^2$ supported on $Q$ off the diagonal with zero row sums … And
$D\circ\nu\in V_Q$ by L120.*

* `sum_Q`, `PiQ_T`, `PiQ_hollow`, `PiQ_weight`: sums over indices vanishing off $Q$, and $\Pi_Q$'s elements are weights;
* **`PiQ_mul`**: $\Pi_Q(x,y,z)\circ\Pi_Q(x',y',z')=\Pi_Q(xx'+yz'+zy',\,yy'+zx'+xz',\,zz'+xy'+yx')$, whose three values sum to
  $(x+y+z)(x'+y'+z')$, so $\Pi_Q$ is closed under $\circ$;
* **`Dnu_char`**: $D\circ\nu$ has character $\chi_Q$ for $D$ of character $1$ and $\nu$ of character $\chi_Q$.
-/

namespace HamiltonsCubic.FourPi

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd HamiltonsCubic.L222Op

variable {n : ℕ} {i j k l : Fin n}

/-- **`D ∘ ν ∈ V_Q`**: characters multiply, `1 · χ_Q = χ_Q`. -/
theorem Dnu_char {D ν : CurvOp2 (Fin n)} (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {i, j, k, l}) ν) :
    SignChar (setChar {i, j, k, l}) (foxProd2 D ν) :=
  signChar_congr (foxProd2_char2 hD hν) fun _ _ => one_mul _

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- A sum of a function vanishing off `Q` is its four values on `Q`. -/
theorem sum_Q (f : Fin n → ℝ) (hf : ∀ r, r ≠ i → r ≠ j → r ≠ k → r ≠ l → f r = 0) :
    ∑ r, f r = f i + f j + f k + f l := by
  rw [← Finset.sum_subset (Finset.subset_univ ({i, j, k, l} : Finset (Fin n))) (fun r _ hr => by
    simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hr
    exact hf r hr.1 hr.2.1 hr.2.2.1 hr.2.2.2)]
  rw [Finset.sum_insert (by simp [hij, hik, hil]), Finset.sum_insert (by simp [hjk, hjl]), Finset.sum_pair hkl]
  ring

theorem PiQ_T (x y z : ℝ) : (PiQ i j k l x y z)ᵀ = PiQ i j k l x y z := by
  ext p q
  simp only [PiQ, E2, Matrix.transpose_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul]
  ring

theorem PiQ_hollow (x y z : ℝ) (p : Fin n) : PiQ i j k l x y z p p = 0 := by
  simp only [PiQ, E2, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul, Pi.single_apply]
  by_cases h1 : p = i <;> by_cases h2 : p = j <;> by_cases h3 : p = k <;> by_cases h4 : p = l <;>
    simp_all [Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl]

theorem PiQ_off (x y z : ℝ) (p r : Fin n) (h1 : r ≠ i) (h2 : r ≠ j) (h3 : r ≠ k) (h4 : r ≠ l) :
    PiQ i j k l x y z p r = 0 := by
  simp [PiQ, E2, Pi.single_apply, Matrix.vecMulVec_apply, h1, h2, h3, h4]

/-- **`Π_Q` is closed under `∘`.** -/
theorem PiQ_mul (x y z x' y' z' : ℝ) :
    foxProd2 (coordOp (PiQ i j k l x y z)) (coordOp (PiQ i j k l x' y' z'))
      = coordOp (PiQ i j k l (x * x' + y * z' + z * y') (y * y' + z * x' + x * z') (z * z' + x * y' + y * x')) := by
  rw [HamiltonsCubic.ItemFour.foxProd2_coordOp _ _ (PiQ_T hij hik hil hjk hjl hkl x y z)
    (PiQ_T hij hik hil hjk hjl hkl x' y' z') (PiQ_hollow hij hik hil hjk hjl hkl x y z)
    (PiQ_hollow hij hik hil hjk hjl hkl x' y' z')]
  apply HamiltonsCubic.ItemFour.coordOp_congr_off
  intro p q hpq
  simp only [Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul]
  rw [Matrix.mul_apply, Matrix.mul_apply,
    show (∑ r, PiQ i j k l x y z p r * PiQ i j k l x' y' z' r q)
      = _ from sum_Q hij hik hil hjk hjl hkl _ fun r h1 h2 h3 h4 => by
        rw [PiQ_off hij hik hil hjk hjl hkl x y z p r h1 h2 h3 h4, zero_mul],
    show (∑ r, PiQ i j k l x' y' z' p r * PiQ i j k l x y z r q)
      = _ from sum_Q hij hik hil hjk hjl hkl _ fun r h1 h2 h3 h4 => by
        rw [PiQ_off hij hik hil hjk hjl hkl x' y' z' p r h1 h2 h3 h4, zero_mul]]
  by_cases hpi : p = i
  · by_cases hqi : q = i
    · exact absurd (hpi.trans hqi.symm) hpq
    · by_cases hqj : q = j
      · simp [hpi, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
      · by_cases hqk : q = k
        · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
        · by_cases hql : q = l
          · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
          · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
  · by_cases hpj : p = j
    · by_cases hqi : q = i
      · simp [hpi, Ne.symm hpi, hpj, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
      · by_cases hqj : q = j
        · exact absurd (hpj.trans hqj.symm) hpq
        · by_cases hqk : q = k
          · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
          · by_cases hql : q = l
            · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
            · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
    · by_cases hpk : p = k
      · by_cases hqi : q = i
        · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
        · by_cases hqj : q = j
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
          · by_cases hqk : q = k
            · exact absurd (hpk.trans hqk.symm) hpq
            · by_cases hql : q = l
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
      · by_cases hpl : p = l
        · by_cases hqi : q = i
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
          · by_cases hqj : q = j
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
            · by_cases hqk : q = k
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
              · by_cases hql : q = l
                · exact absurd (hpl.trans hql.symm) hpq
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
        · by_cases hqi : q = i
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
          · by_cases hqj : q = j
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
            · by_cases hqk : q = k
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
              · by_cases hql : q = l
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul] <;> ring

/-- `Π_Q`'s elements with `x + y + z = 0` are weights, so they lie in `𝒟_n`. -/
theorem PiQ_weight {x y z : ℝ} (hs : x + y + z = 0) : IsWeight (PiQ i j k l x y z) := by
  refine ⟨fun a b => ?_, PiQ_hollow hij hik hil hjk hjl hkl x y z, fun a => ?_⟩
  · rw [← Matrix.transpose_apply (PiQ i j k l x y z) b a, PiQ_T hij hik hil hjk hjl hkl]
  · rw [sum_Q hij hik hil hjk hjl hkl _ fun r h1 h2 h3 h4 => PiQ_off hij hik hil hjk hjl hkl x y z a r h1 h2 h3 h4]
    by_cases h1 : a = i
    · subst h1; simp [PiQ, E2, Pi.single_apply, Matrix.vecMulVec_apply, hij, hik, hil, hjk, hjl, hkl,
        Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl]; linarith
    · by_cases h2 : a = j
      · subst h2; simp [PiQ, E2, Pi.single_apply, Matrix.vecMulVec_apply, h1, hjk, hjl, hkl, Ne.symm h1,
          Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, hik, hil, Ne.symm hik, Ne.symm hil]; linarith
      · by_cases h3 : a = k
        · subst h3; simp [PiQ, E2, Pi.single_apply, Matrix.vecMulVec_apply, h1, h2, hkl, Ne.symm h1, Ne.symm h2,
            Ne.symm hkl, hij, hil, hjl, Ne.symm hij, Ne.symm hil, Ne.symm hjl]; linarith
        · by_cases h4 : a = l
          · subst h4; simp [PiQ, E2, Pi.single_apply, Matrix.vecMulVec_apply, h1, h2, h3, Ne.symm h1, Ne.symm h2,
              Ne.symm h3, hij, hik, hjk, Ne.symm hij, Ne.symm hik, Ne.symm hjk]; linarith
          · simp [PiQ, E2, Pi.single_apply, Matrix.vecMulVec_apply, h1, h2, h3, h4, Ne.symm h1, Ne.symm h2, Ne.symm h3,
              Ne.symm h4]

end

end HamiltonsCubic.FourPi
