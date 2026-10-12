import Mathlib
import HamiltonsCubic.Results.FourSquare
import HamiltonsCubic.Results.L120Ident

set_option linter.style.longLine false

/-!
# L220's four-set block as the span of two sandwiches

[findings/second-order.md](../../../findings/second-order.md), Lemma L220, Setting: *in the pairing basis of $V_Q$ with signed
coordinates $\nu=a\,e_{ij}\odot e_{kl}+b\,e_{ik}\odot e_{jl}+c\,e_{il}\odot e_{jk}$, $a+b+c=0$.* L120's `four_block_iff` describes $V_Q$ as the
range of `fourMap`, the span operators `spanVec x y z` with $x+y+z=0$. On skew matrices the two sandwiches of
[FourSquare.lean](FourSquare.lean) are span operators:

* `Smat_mul_apply`, `mul_Smat_apply`, `inner2_phiY`: the entries of $SY$, $YS$ and $\langle\varphi_{ab},Y\rangle=Y_{ba}$;
* **`sigA_mat`**: $S_{ik}YS_{jl}+S_{jl}YS_{ik}=\mathrm{spanVec}(1,0,-1)\,Y$;
* **`sigB_mat`**: $S_{ij}YS_{kl}+S_{kl}YS_{ij}=\mathrm{spanVec}(0,-1,1)\,Y$;
* `extendL_sigA`, `extendL_sigB`, `sigA_char`, `sigB_char`: both sandwiches are Weyl of character $\chi_Q$;
* **`four_eq_sig`**: every Weyl operator of character $\chi_Q$ is $x\,\sigma_A+y\,\sigma_B$.
-/

namespace HamiltonsCubic.FourIdent

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FrameOp2 HamiltonsCubic.FourSquare
  HamiltonsCubic.L121Block HamiltonsCubic.L126Assembly HamiltonsCubic.FamilyLayer HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks

variable {n : ℕ} {i j k l : Fin n}

theorem Smat_mul_apply {a b : Fin n} (hab : a ≠ b) (Y : Matrix (Fin n) (Fin n) ℝ) (p t : Fin n) :
    (Smat a b * Y) p t = if p = a then Y b t else if p = b then Y a t else 0 := by
  rw [Matrix.mul_apply]; exact Smat_row hab p (fun r => Y r t)

theorem mul_Smat_apply {a b : Fin n} (hab : a ≠ b) (Y : Matrix (Fin n) (Fin n) ℝ) (p q : Fin n) :
    (Y * Smat a b) p q = if q = a then Y p b else if q = b then Y p a else 0 := by
  rw [Matrix.mul_apply]; exact Smat_col hab q (fun t => Y p t)

theorem inner2_phiY {Y : Matrix (Fin n) (Fin n) ℝ} (hY : IsSkew Y) (a b : Fin n) : inner2 (phi a b) Y = Y b a := by
  rw [inner2_comm, inner2_phi Y hY a b]
  have := congrFun (congrFun hY a) b
  simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
  linarith

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **`σ_A` is the span operator `(1, 0, -1)` on skew matrices.** -/
theorem sigA_mat {Y : Matrix (Fin n) (Fin n) ℝ} (hY : IsSkew Y) :
    Smat i k * Y * Smat j l + Smat j l * Y * Smat i k = spanVec i j k l 1 0 (-1) Y := by
  have hsk : ∀ a b, Y a b = -Y b a := fun a b => by
    have := congrFun (congrFun hY b) a
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith
  have hY' := hY
  ext p q
  rw [Matrix.add_apply, mul_Smat_apply hjl, mul_Smat_apply hik, Smat_mul_apply hik, Smat_mul_apply hik,
    Smat_mul_apply hjl, Smat_mul_apply hjl]
  simp only [spanVec, rk2, inner2_phiY hY, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  by_cases hpi : p = i
  · by_cases hqi : q = i
    · simp [hpi, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
    · by_cases hqj : q = j
      · simp [hpi, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
      · by_cases hqk : q = k
        · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
        · by_cases hql : q = l
          · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
  · by_cases hpj : p = j
    · by_cases hqi : q = i
      · simp [hpi, Ne.symm hpi, hpj, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
      · by_cases hqj : q = j
        · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
        · by_cases hqk : q = k
          · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · by_cases hql : q = l
            · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
            · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
    · by_cases hpk : p = k
      · by_cases hqi : q = i
        · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
        · by_cases hqj : q = j
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · by_cases hqk : q = k
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
            · by_cases hql : q = l
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
      · by_cases hpl : p = l
        · by_cases hqi : q = i
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · by_cases hqj : q = j
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
            · by_cases hqk : q = k
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
              · by_cases hql : q = l
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
        · by_cases hqi : q = i
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · by_cases hqj : q = j
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
            · by_cases hqk : q = k
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
              · by_cases hql : q = l
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]

/-- **`σ_B` is the span operator `(0, -1, 1)` on skew matrices.** -/
theorem sigB_mat {Y : Matrix (Fin n) (Fin n) ℝ} (hY : IsSkew Y) :
    Smat i j * Y * Smat k l + Smat k l * Y * Smat i j = spanVec i j k l 0 (-1) 1 Y := by
  have hsk : ∀ a b, Y a b = -Y b a := fun a b => by
    have := congrFun (congrFun hY b) a
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith
  ext p q
  rw [Matrix.add_apply, mul_Smat_apply hkl, mul_Smat_apply hij, Smat_mul_apply hij, Smat_mul_apply hij,
    Smat_mul_apply hkl, Smat_mul_apply hkl]
  simp only [spanVec, rk2, inner2_phiY hY, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  by_cases hpi : p = i
  · by_cases hqi : q = i
    · simp [hpi, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
    · by_cases hqj : q = j
      · simp [hpi, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
      · by_cases hqk : q = k
        · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
        · by_cases hql : q = l
          · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
  · by_cases hpj : p = j
    · by_cases hqi : q = i
      · simp [hpi, Ne.symm hpi, hpj, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
      · by_cases hqj : q = j
        · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
        · by_cases hqk : q = k
          · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · by_cases hql : q = l
            · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
            · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
    · by_cases hpk : p = k
      · by_cases hqi : q = i
        · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
        · by_cases hqj : q = j
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · by_cases hqk : q = k
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
            · by_cases hql : q = l
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
      · by_cases hpl : p = l
        · by_cases hqi : q = i
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · by_cases hqj : q = j
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
            · by_cases hqk : q = k
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
              · by_cases hql : q = l
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
        · by_cases hqi : q = i
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
          · by_cases hqj : q = j
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
            · by_cases hqk : q = k
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
              · by_cases hql : q = l
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, Smat_mul_apply, mul_Smat_apply, spanVec, rk2, inner2_phiY, phi, Matrix.sub_apply, Matrix.single_apply, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul] <;> linarith [hsk i i, hsk i j, hsk i k, hsk i l, hsk j i, hsk j j, hsk j k, hsk j l, hsk k i, hsk k j, hsk k k, hsk k l, hsk l i, hsk l j, hsk l k, hsk l l]

theorem skewProj_eq (X : Matrix (Fin n) (Fin n) ℝ) :
    HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) X = TensorBridge.skewProj X := by
  show (1 / 2 : ℝ) • (X - Xᵀ) = (2⁻¹ : ℝ) • (X - Xᵀ)
  norm_num

/-- `σ_A` extended is the span operator `(1, 0, -1)`. -/
theorem extendL_sigA : extendL (sig4 i k j l) = fourS i j k l 1 0 (-1) := by
  apply LinearMap.ext; intro X
  show extend (sig4 i k j l) X = spanVec i j k l 1 0 (-1) (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) X)
  rw [skewProj_eq hij hik hil hjk hjl hkl]
  unfold extend sig4
  rw [sandOp_coe]
  exact sigA_mat hij hik hil hjk hjl hkl (skewProj_mem X)

/-- `σ_B` extended is the span operator `(0, -1, 1)`. -/
theorem extendL_sigB : extendL (sig4 i j k l) = fourS i j k l 0 (-1) 1 := by
  apply LinearMap.ext; intro X
  show extend (sig4 i j k l) X = spanVec i j k l 0 (-1) 1 (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) X)
  rw [skewProj_eq hij hik hil hjk hjl hkl]
  unfold extend sig4
  rw [sandOp_coe]
  exact sigB_mat hij hik hil hjk hjl hkl (skewProj_mem X)

theorem sigA_char : SignChar (setChar {i, j, k, l}) (sig4 i k j l) := by
  refine (L120Ident.four_block_iff hij hik hil hjk hjl hkl _ (sig_weyl hik hjl hij hil (Ne.symm hjk) hkl)).mpr ⟨(1, 0), ?_⟩
  rw [extendL_sigA hij hik hil hjk hjl hkl]
  show fourS i j k l 1 0 (-1 - 0) = _
  norm_num

theorem sigB_char : SignChar (setChar {i, j, k, l}) (sig4 i j k l) := by
  refine (L120Ident.four_block_iff hij hik hil hjk hjl hkl _ (sig_weyl hij hkl hik hil hjk hjl)).mpr ⟨(0, -1), ?_⟩
  rw [extendL_sigB hij hik hil hjk hjl hkl]
  show fourS i j k l 0 (-1) (-0 - -1) = _
  norm_num

/-- **`V_Q` is spanned by the two sandwiches**: every Weyl operator of character `χ_Q` is `x σ_A + y σ_B`. -/
theorem four_eq_sig {V : CurvOp2 (Fin n)} (hVW : IsWeyl2 V) (hV : SignChar (setChar {i, j, k, l}) V) :
    ∃ x y : ℝ, V = x • sig4 i k j l + y • sig4 i j k l := by
  obtain ⟨v, hv⟩ := (L120Ident.four_block_iff hij hik hil hjk hjl hkl V hVW).mp hV
  refine ⟨v.1, -v.2, ContinuousLinearMap.ext fun X => Subtype.ext ?_⟩
  have e := congrArg (fun L : CurvLin (Fin n) => L (X : Matrix (Fin n) (Fin n) ℝ)) hv
  rw [← extend_apply V X]
  show extendL V (X : Matrix (Fin n) (Fin n) ℝ) = _
  rw [← e]
  show spanVec i j k l v.1 v.2 (-v.1 - v.2) (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) X) = _
  rw [skewProj_eq hij hik hil hjk hjl hkl, TensorBridge.skewProj_eq_self X.2]
  show _ = ((v.1 • sig4 i k j l X + (-v.2) • sig4 i j k l X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
  rw [Submodule.coe_add, Submodule.coe_smul, Submodule.coe_smul]
  unfold sig4
  rw [sandOp_coe, sandOp_coe, sigA_mat hij hik hil hjk hjl hkl X.2, sigB_mat hij hik hil hjk hjl hkl X.2]
  simp only [spanVec]
  module

end

end HamiltonsCubic.FourIdent
