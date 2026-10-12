import HamiltonsCubic.Results.TorusEmbed

set_option linter.style.longLine false

/-!
# `𝔰𝔲(k)`'s torus family inside `𝔰𝔬(2k)`'s torus slice

[The R48 working note](../../../reviews/2026-09-27-R48-torus-families.md), batch 15, Gate 2 by r1727 and r1728. With
`ℂ^k = ℝ^{2k}` and `J = Jm` the complex structure, L271's roots `ε_i - ε_j` are the `J`-commuting planes (`cPart`)
and `ε_i + ε_j` the anticommuting ones, so the torus-invariant operators supported on `𝔲(k)` are `torusOp A U 0`,
and those supported on `𝔰𝔲(k)` also have `A 𝟙 = 0`.

- `torusOp_kills_anti`: `torusOp A U 0` kills every bivector anticommuting with `J`.
- `torusOp_commutes_J`: its image commutes with `J`, so it lies in `𝔲(k)`.
- `torusOp_kills_J`, `torusOp_perp_J`: with `A 𝟙 = 0` it kills `J` and its image is orthogonal to `J`, so it lives
  on `𝔰𝔲(k) = 𝔲(k) ∩ J^⊥`.
- `H_su_slice`: every `torusOp A U 0` obeys `κ_{2M}` for `M ≥ 7`, `k ≤ M`, by L282's `H_small_even` at `V = 0`.

Batch 15's prose carries the rest: every `SU(k)`-torus-invariant operator on `𝔰𝔲(k)`, extended by zero, is such a
`torusOp A U 0` and is invariant under all of `U(k)`'s torus, and its cubic form computed in `𝔰𝔬(2k)` is `𝔰𝔲(k)`'s
own. The layer has no intrinsic `𝔰𝔲(k)` with its own `#`.
-/

namespace HamiltonsCubic.SuTorus

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.TorusEmbed

variable {m : ℕ}

/-- The complex structure `J` of `ℂ^m = ℝ^{2m}`, `J2` on each coordinate plane. -/
def Jm : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ := fun p q => if p.1 = q.1 then J2 p.2 q.2 else 0

theorem Jm_mem : (Jm : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) ∈ skewSub (Fin m × Fin 2) := by
  show Jmᵀ = -Jm
  ext p q
  simp only [Jm, Matrix.transpose_apply, Matrix.neg_apply]
  by_cases h : p.1 = q.1
  · rw [if_pos h.symm, if_pos h, J2_skew]
  · rw [if_neg (Ne.symm h), if_neg h, neg_zero]

theorem mul_Jm (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (a : Fin m × Fin 2) (j : Fin m) (t : Fin 2) :
    (X * Jm : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) a (j, t) = X a (j, 0) * J2 0 t + X a (j, 1) * J2 1 t := by
  simp [Matrix.mul_apply, Fintype.sum_prod_type, Jm, Fin.sum_univ_two, mul_ite, Finset.sum_ite_eq']

theorem Jm_mul (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (i : Fin m) (s : Fin 2) (b : Fin m × Fin 2) :
    (Jm * X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) (i, s) b = J2 s 0 * X (i, 0) b + J2 s 1 * X (i, 1) b := by
  simp [Matrix.mul_apply, Fintype.sum_prod_type, Jm, Fin.sum_univ_two, ite_mul, Finset.sum_ite_eq]

/-- **`L271`'s operator with `V = 0` kills every bivector anticommuting with `J`.** -/
theorem torusOp_kills_anti (A U : Matrix (Fin m) (Fin m) ℝ) (X : skewSub (Fin m × Fin 2))
    (hX : (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) * Jm = -(Jm * X.1)) :
    torusOp A U 0 X = 0 := by
  have hXs : ∀ a b, X.1 b a = -X.1 a b := fun a b => by
    have h := congrFun (congrFun (X.2 : (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)ᵀ = -X) a) b
    simpa [Matrix.transpose_apply] using h
  have e : ∀ a b, ((X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) * Jm : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) a b = -((Jm * (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) a b) := fun a b => by
    rw [hX, Matrix.neg_apply]
  have r1 : ∀ i j : Fin m, X.1 (i, 0) (j, 1) = X.1 (i, 1) (j, 0) := fun i j => by
    have h := e (i, 0) (j, 0)
    rw [mul_Jm, Jm_mul] at h; simp [J2_00, J2_01, J2_10, J2_11] at h; linarith
  have r2 : ∀ i j : Fin m, X.1 (i, 1) (j, 1) = -X.1 (i, 0) (j, 0) := fun i j => by
    have h := e (i, 0) (j, 1)
    rw [mul_Jm, Jm_mul] at h; simp [J2_00, J2_01, J2_10, J2_11] at h; linarith
  have r0 : ∀ k : Fin m, X.1 (k, 1) (k, 0) = 0 := fun k => by
    have h1 := r1 k k
    have h2 := hXs (k, 0) (k, 1)
    linarith
  have hM : torusMat A U 0 X.1 = 0 := by
    ext ⟨i, s⟩ ⟨j, t⟩
    simp only [torusMat, Matrix.zero_apply]
    split_ifs with h
    · simp [r0]
    · fin_cases s <;> fin_cases t <;>
        simp [blk, cPart_00, cPart_01, cPart_10, cPart_11, r1 i j, r2 i j]
  apply Subtype.ext
  show skewPartM (torusMat A U 0 X.1) = 0
  rw [hM]; simp [skewPartM]

/-- **Its image commutes with `J`**, so it lies in `𝔲(m)`. -/
theorem torusOp_commutes_J (A U : Matrix (Fin m) (Fin m) ℝ) (X : skewSub (Fin m × Fin 2)) :
    ((torusOp A U 0 X : skewSub _) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) * Jm
      = Jm * ((torusOp A U 0 X : skewSub _) : Matrix _ _ ℝ) := by
  set M := torusMat A U 0 (X : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) with hMd
  have hMJ : M * Jm = Jm * M := by
    ext ⟨i, s⟩ ⟨j, t⟩
    rw [mul_Jm, Jm_mul]
    simp only [hMd, torusMat]
    by_cases h : i = j
    · subst h; fin_cases s <;> fin_cases t <;> simp [J2_00, J2_01, J2_10, J2_11]
    · fin_cases s <;> fin_cases t <;>
        simp [h, cPart_00, cPart_01, cPart_10, cPart_11, J2_00, J2_01, J2_10, J2_11] <;> ring
  have hJt : (Jm : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ)ᵀ = -Jm := Jm_mem
  have hMtJ : Mᵀ * Jm = Jm * Mᵀ := by
    have h := congrArg Matrix.transpose hMJ
    rw [Matrix.transpose_mul, Matrix.transpose_mul, hJt, Matrix.neg_mul, Matrix.mul_neg] at h
    exact (neg_inj.mp h).symm
  show skewPartM M * Jm = Jm * skewPartM M
  unfold skewPartM
  rw [Matrix.smul_mul, Matrix.mul_smul, Matrix.sub_mul, Matrix.mul_sub, hMJ, hMtJ]

/-- **With `A 𝟙 = 0` it kills `J`**, so with self-adjointness its image is orthogonal to `J`: it lives on `𝔰𝔲(m)`. -/
theorem torusOp_kills_J (A U : Matrix (Fin m) (Fin m) ℝ) (hA1 : A.mulVec (fun _ => 1) = 0) :
    torusOp A U 0 ⟨Jm, Jm_mem⟩ = 0 := by
  have hM : torusMat A U 0 Jm = 0 := by
    ext ⟨i, s⟩ ⟨j, t⟩
    simp only [torusMat, Matrix.zero_apply]
    split_ifs with h
    · have hs : ∑ k, A i k * Jm (k, 1) (k, 0) = (A.mulVec (fun _ => 1)) i := by
        simp [Jm, J2_10, Matrix.mulVec, dotProduct]
      rw [hs, hA1]; simp
    · fin_cases s <;> fin_cases t <;> simp [h, blk, Jm, cPart_00, cPart_01, cPart_10, cPart_11]
  apply Subtype.ext
  show skewPartM (torusMat A U 0 Jm) = 0
  rw [hM]; simp [skewPartM]

/-- **With `A` symmetric and `A 𝟙 = 0` the image is orthogonal to `J`**, so the operator lives on `𝔰𝔲(k)`. -/
theorem torusOp_perp_J (A U : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hA1 : A.mulVec (fun _ => 1) = 0)
    (X : skewSub (Fin m × Fin 2)) :
    inner2 ((torusOp A U 0 X : skewSub _) : Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ) Jm = 0 := by
  have h := torusOp_isSelfAdjoint2 A U 0 hA X ⟨Jm, Jm_mem⟩
  rw [torusOp_kills_J A U hA1] at h
  simpa [inner2] using h

/-- **The bound on the `V = 0` part of `𝔰𝔬(2k)`'s torus slice**: for `M ≥ 7` and `k ≤ M`, every `torusOp A U 0`
obeys `κ_{2M}`. The operators supported on `𝔰𝔲(k)` are those with `A 𝟙 = 0` (`torusOp_kills_anti`,
`torusOp_kills_J`, `torusOp_perp_J`); that they are all of `𝔰𝔲(k)`'s torus-invariant operators, and that their
cubic form is `𝔰𝔲(k)`'s own, is batch 15's prose. -/
theorem H_su_slice (M : ℕ) (hM : 7 ≤ M) (j : ℕ) (hj : j + 1 ≤ M) (A U : Matrix (Fin (j + 1)) (Fin (j + 1)) ℝ)
    (hA : Aᵀ = A) (hU : IsPairWeights U) :
    Ftri (torusOp A U 0) (torusOp A U 0) (torusOp A U 0) ≤ kapE M * (normSq2 (torusOp A U 0)) ^ ((3 : ℝ) / 2) :=
  H_small_even M hM j hj A U 0 hA hU ⟨by simp, fun i => by simp⟩

end HamiltonsCubic.SuTorus
