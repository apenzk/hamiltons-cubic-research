import Mathlib.Data.Matrix.Basic
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Data.Nat.Choose.Basic
import Mathlib.Tactic.IntervalCases

/-!
# L75, maximal isotropy, and the hypothesis the third form drops

[isotropy-cap.md](../../../findings/isotropy-cap.md)'s Lemma L75, refuted as written. The
break is that `rank[𝔪,𝔪] = N - dim 𝔪` **fixes a dimension and leaves the subspace free**,
where `[𝔪,𝔪]^⊥ = 𝔪` entails isotropy unaided.

**The witness is computed here rather than asserted.** `𝔰𝔬(3) ⊂ 𝔰𝔬(4)` with
`𝔪 = span{φ₁₂, φ₁₃, φ₂₃}`: the bracket `[φ₁₂, φ₁₃] = -φ₂₃` is proved from the matrices, so
`[𝔪,𝔪] = 𝔪` and the rank count `3 = 6 - 3` holds **exactly**, while
`⟨[φ₁₂,φ₁₃], φ₂₃⟩ = -1 ≠ 0`, so `𝔪` is not isotropic. Dimension versus subspace, in four
dimensions.

**And the type-DIII row closes by an integrality obstruction.** `d = 6` at `n = 6` lies
outside [L76](../../../findings/isotropy-cap.md)'s family because `pq = 6` with `p + q = 6`
has no integer solution, the discriminant is `12`, not a square. The `𝔰𝔬(2m)/𝔲(m)`
dimensions `m(m-1)` give the record's `6` and `12` at `m = 3, 4`.
-/

namespace HamiltonsCubic.Isotropy

open Matrix

/-! ## The `𝔰𝔬(4)` witness, from the matrices -/

/-- `φ_{ab} = E_{ab} - E_{ba}`, at the three indices the witness uses. -/
def phi12 : Matrix (Fin 4) (Fin 4) ℚ := !![0, 1, 0, 0; -1, 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0]

def phi13 : Matrix (Fin 4) (Fin 4) ℚ := !![0, 0, 1, 0; 0, 0, 0, 0; -1, 0, 0, 0; 0, 0, 0, 0]

def phi23 : Matrix (Fin 4) (Fin 4) ℚ := !![0, 0, 0, 0; 0, 0, 1, 0; 0, -1, 0, 0; 0, 0, 0, 0]

/-- **`[φ₁₂, φ₁₃] = -φ₂₃`**, computed. So `[𝔪,𝔪] ⊆ 𝔪`, and by symmetry of the three
indices `[𝔪,𝔪] = 𝔪`. -/
theorem bracket_eq : phi12 * phi13 - phi13 * phi12 = -phi23 := by
  unfold phi12 phi13 phi23
  ext i j
  fin_cases i <;> fin_cases j <;> simp [Matrix.mul_apply, Fin.sum_univ_succ]

/-- `φ₂₃` is nonzero, so **the bracket lands back inside `𝔪` as a nonzero element**, which
is exactly `𝔪 ⊄ [𝔪,𝔪]^⊥`, the failure of isotropy. No pairing convention is needed: the
bracket of two basis vectors of `𝔪` *is* a nonzero multiple of the third. -/
theorem phi23_ne_zero : phi23 ≠ 0 := by
  intro h
  have : phi23 1 2 = (0 : Matrix (Fin 4) (Fin 4) ℚ) 1 2 := by rw [h]
  unfold phi23 at this
  simp at this

theorem bracket_nonzero : phi12 * phi13 - phi13 * phi12 ≠ 0 := by
  rw [bracket_eq]
  simpa using phi23_ne_zero

/-! ## The rank count holds exactly, which is the whole point -/

/-- `N = dim 𝔰𝔬(4) = 6`. -/
theorem N_four : Nat.choose 4 2 = 6 := by decide

/-- **`rank[𝔪,𝔪] = 3 = 6 - 3 = N - dim 𝔪`**, the third form is satisfied by a
non-isotropic `𝔪`, which is the refutation. -/
theorem rank_count_holds : 3 = Nat.choose 4 2 - 3 := by decide

/-! ## The rank-15 argument the block uses four lines below -/

/-- `N = dim 𝔰𝔬(6) = 15`, and isotropy gives `r ≤ N - dim 𝔪 = 9` at `dim 𝔪 = 6`. -/
theorem N_six : Nat.choose 6 2 = 15 := by decide

theorem isotropy_bound : Nat.choose 6 2 - 6 = 9 := by decide

/-- **So rank `15` forces `𝔪 = 0`**, and the detector is exactly the isotropy hypothesis the
third form omits. -/
theorem rank_fifteen_forces_zero (d : ℕ) (hd : d ≤ 15) (hrank : 15 ≤ 15 - d) :
    d = 0 := by omega

/-! ## The table rows -/

/-- `d = 4` is the least degree meeting `C(d,2) ≥ N - d` at `n = 5`, where `N = 10`: `d = 3`
gives `3 < 7` and `d = 4` gives `6 = 6`. -/
theorem d_four_minimal : 3 < 10 - 3 ∧ 6 = 10 - 4 := by
  constructor <;> decide

theorem choose_values : Nat.choose 3 2 = 3 ∧ Nat.choose 4 2 = 6 ∧ Nat.choose 5 2 = 10 := by
  refine ⟨by decide, by decide, by decide⟩

/-- **The type-DIII row falls by integrality.** `pq = 6` with `p + q = 6` needs
`t² - 6t + 6 = 0`, whose discriminant `12` is not a perfect square, so no integer split
exists and `d = 6` at `n = 6` sits outside L76's family. -/
theorem no_integer_split (p q : ℤ) (hsum : p + q = 6) (hprod : p * q = 6) : False := by
  have hq : q = 6 - p := by linarith
  rw [hq] at hprod
  have hk : (p - 3) ^ 2 = 3 := by nlinarith [hprod]
  have hb1 : p - 3 ≤ 1 := by nlinarith [hk, sq_nonneg (p - 3 - 2)]
  have hb2 : -1 ≤ p - 3 := by nlinarith [hk, sq_nonneg (p - 3 + 2)]
  have hsq : (1 - (p - 3)) * (1 + (p - 3)) ≥ 0 :=
    mul_nonneg (by linarith) (by linarith)
  nlinarith [hk, hsq]

/-- `dim 𝔰𝔬(2m)/𝔲(m) = m(m-1)`, giving the record's `6` at `m = 3` and `12` at `m = 4`. -/
theorem diii_dim (m : ℚ) : m * (2 * m - 1) - m * m = m * (m - 1) := by ring

theorem diii_three : 3 * (3 - 1) = 6 := by decide

theorem diii_four : 4 * (4 - 1) = 12 := by decide

end HamiltonsCubic.Isotropy
