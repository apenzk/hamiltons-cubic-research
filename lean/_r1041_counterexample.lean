import HamiltonsCubic.Results.I106bFace

/-! r1041 scratch: an exact rational witness refuting `zero_diag_critical_is_isSignedPerm`
as typed (no genericity hypothesis), at `k = 4`, with `nu` pairwise distinct and `A` of rank 2. -/

namespace R1041

open Matrix HamiltonsCubic.I106bFace

noncomputable def Qc : Matrix (Fin 4) (Fin 4) ℝ :=
  !![0, 0, 3/5, -4/5;
     0, 0, 4/5,  3/5;
     1, 0, 0,    0;
     0, 1, 0,    0]

def nuc : Fin 4 → ℝ := ![0, 1, 2, 3]
def uc  : Fin 4 → ℝ := ![1, 0, 1, 2]
def cc  : Fin 4 → ℝ := ![0, 5, 3, 7]

theorem Qc_orth : Qc * Qcᵀ = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [Qc, Matrix.mul_apply, Fin.sum_univ_succ, Matrix.one_apply]

theorem Qc_zero_diag : ∀ i, Qc i i = 0 := by
  intro i; fin_cases i <;> norm_num [Qc]

theorem Qc_crit : ∀ l m : Fin 4,
    (nuc m - nuc l) * (1 * (nuc l + nuc m) * (Qcᵀ * Matrix.diagonal uc * Qc) l m
      + (Qcᵀ * Matrix.diagonal cc * Qc) l m) = 0 := by
  intro l m
  fin_cases l <;> fin_cases m <;>
    norm_num [Qc, nuc, uc, cc, Matrix.mul_apply, Fin.sum_univ_succ, Matrix.diagonal_apply]

theorem Qc_not_signedPerm : ¬ IsSignedPerm Qc := by
  rintro ⟨σ, ε, -, hval⟩
  have h2 : Qc 0 2 = if (2 : Fin 4) = σ 0 then ε 0 else 0 := hval 0 2
  have h3 : Qc 0 3 = if (3 : Fin 4) = σ 0 then ε 0 else 0 := hval 0 3
  have e2 : Qc 0 2 = 3/5 := by
    norm_num [Qc, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail]
  have e3 : Qc 0 3 = -(4/5) := by
    norm_num [Qc, Matrix.cons_val_two, Matrix.cons_val_three, Matrix.vecHead, Matrix.vecTail]
  have k2 : (2 : Fin 4) = σ 0 := by
    by_contra hc
    rw [if_neg hc] at h2; rw [e2] at h2; norm_num at h2
  have k3 : (3 : Fin 4) = σ 0 := by
    by_contra hc
    rw [if_neg hc] at h3; rw [e3] at h3; norm_num at h3
  have : (2 : Fin 4) = (3 : Fin 4) := k2.trans k3.symm
  exact absurd this (by decide)

/-- **The typed open statement is FALSE**: the witness satisfies every hypothesis and fails the
conclusion, so `False` follows from it. -/
theorem open_statement_is_false : False :=
  Qc_not_signedPerm
    (zero_diag_critical_is_isSignedPerm (by norm_num) 1 nuc uc cc Qc Qc_orth Qc_zero_diag Qc_crit)

#print axioms open_statement_is_false

end R1041
