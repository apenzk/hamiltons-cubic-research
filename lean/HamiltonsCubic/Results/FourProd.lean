import Mathlib
import HamiltonsCubic.Results.FourIdent
import HamiltonsCubic.Results.L219Prod

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220 step 2: `ν ∘ ν ∈ Π_Q` with the record's pattern, at every `ν ∈ V_Q`

[findings/second-order.md](../../../findings/second-order.md), Lemma L220, step 2: *$\nu\circ\nu\in\Pi_Q$, with $x=2a^2-b^2-c^2$ and
cyclically*, where $\Pi_Q$ is the plane of sectional matrices $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$. The three pairing
sandwiches sum to zero, so $Q$ on $V_Q=\mathrm{span}(\sigma_A,\sigma_B)$ ([FourIdent.lean](FourIdent.lean)) is fixed by its values on
$\sigma_A$, $\sigma_B$ and $\sigma_A+\sigma_B=-\sigma_C$, each [FourSquare.lean](FourSquare.lean)'s `Q_sig`.

* **`sigC_mat`**: $S_{il}YS_{jk}+S_{jk}YS_{il}=\mathrm{spanVec}(-1,1,0)\,Y$ on skew $Y$;
* `sig_sum`: $\sigma_A+\sigma_B=-\sigma_C$;
* `Q_lin`: $Q(x\sigma_A+y\sigma_B)=x^2Q_A+y^2Q_B+xy(Q_C-Q_A-Q_B)$;
* `E2`, `PiQ`: the element of $\Pi_Q$ with values $(x,y,z)$;
* **`nu_sq`**: every Weyl $\nu$ of character $\chi_Q$ has signed coordinates $(a,b,c)$, $a+b+c=0$, with
  $\nu\circ\nu=\Pi_Q(2a^2-b^2-c^2,\,2b^2-c^2-a^2,\,2c^2-a^2-b^2)$.
-/

namespace HamiltonsCubic.FourProd

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FrameOp2 HamiltonsCubic.FourSquare
  HamiltonsCubic.L121Block HamiltonsCubic.L126Assembly HamiltonsCubic.FamilyLayer HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent

variable {n : ℕ} {i j k l : Fin n}

/-- The symmetric unit weight on the pair `{p, q}`. -/
noncomputable def E2 (p q : Fin n) : Matrix (Fin n) (Fin n) ℝ :=
  vecMulVec (Pi.single p 1) (Pi.single q 1) + vecMulVec (Pi.single q 1) (Pi.single p 1)

/-- **The element of `Π_Q`** with `K_{ij} = K_{kl} = x`, `K_{ik} = K_{jl} = y`, `K_{il} = K_{jk} = z`. -/
noncomputable def PiQ (i j k l : Fin n) (x y z : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  x • (E2 i j + E2 k l) + y • (E2 i k + E2 j l) + z • (E2 i l + E2 j k)

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **`σ_C` is the span operator `(-1, 1, 0)` on skew matrices.** -/
theorem sigC_mat {Y : Matrix (Fin n) (Fin n) ℝ} (hY : IsSkew Y) :
    Smat i l * Y * Smat j k + Smat j k * Y * Smat i l = spanVec i j k l (-1) 1 0 Y := by
  have hsk : ∀ a b, Y a b = -Y b a := fun a b => by
    have := congrFun (congrFun hY b) a
    simp only [Matrix.transpose_apply, Matrix.neg_apply] at this
    linarith
  ext p q
  rw [Matrix.add_apply, mul_Smat_apply hjk, mul_Smat_apply hil, Smat_mul_apply hil, Smat_mul_apply hil,
    Smat_mul_apply hjk, Smat_mul_apply hjk]
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

/-- **The three pairing sandwiches sum to zero**: `σ_A + σ_B = -σ_C`. -/
theorem sig_sum : sig4 i k j l + sig4 i j k l = -(sig4 i l j k) := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [ContinuousLinearMap.add_apply, ContinuousLinearMap.neg_apply, Submodule.coe_add, Submodule.coe_neg]
  unfold sig4
  rw [sandOp_coe, sandOp_coe, sandOp_coe, sigA_mat hij hik hil hjk hjl hkl X.2, sigB_mat hij hik hil hjk hjl hkl X.2,
    sigC_mat hij hik hil hjk hjl hkl X.2]
  simp only [spanVec]
  module

/-- **`Q` on `V_Q` by polarisation.** -/
theorem Q_lin (x y : ℝ) :
    Qop2 (x • sig4 i k j l + y • sig4 i j k l)
      = (x ^ 2) • coordOp (W4 i k j l) + (y ^ 2) • coordOp (W4 i j k l)
        + (x * y) • (coordOp (W4 i l j k) - coordOp (W4 i k j l) - coordOp (W4 i j k l)) := by
  have hA := Q_sig hik hjl hij hil (Ne.symm hjk) hkl
  have hB := Q_sig hij hkl hik hil hjk hjl
  have hC := Q_sig hil hjk hij hik (Ne.symm hjl) (Ne.symm hkl)
  have hAB : Qop2 (sig4 i k j l + sig4 i j k l) = coordOp (W4 i l j k) := by
    rw [sig_sum hij hik hil hjk hjl hkl, show -(sig4 i l j k) = (-1 : ℝ) • sig4 i l j k by module, Qop2_smul, hC]
    norm_num
  have hfox : (2 : ℝ) • foxProd2 (sig4 i k j l) (sig4 i j k l)
      = coordOp (W4 i l j k) - coordOp (W4 i k j l) - coordOp (W4 i j k l) := by
    have h := L219Prod.Qop2_add (sig4 i k j l) (sig4 i j k l)
    rw [hAB, hA, hB] at h
    rw [h]; abel
  rw [L219Prod.Qop2_add, Qop2_smul, Qop2_smul, hA, hB, foxProd2_smul_left, foxProd2_smul_right, ← hfox]
  module

/-- The polarised weight. -/
noncomputable def Wcomb (i j k l : Fin n) (x y : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  (x ^ 2) • W4 i k j l + (y ^ 2) • W4 i j k l + (x * y) • (W4 i l j k - W4 i k j l - W4 i j k l)

/-- **The polarised weight is the record's pattern** off the diagonal, at `(a, b, c) = (x, -y, y - x)`. -/
theorem Wcomb_pattern (x y : ℝ) :
    coordOp (Wcomb i j k l x y)
      = coordOp (PiQ i j k l (2 * x ^ 2 - (-y) ^ 2 - (y - x) ^ 2) (2 * (-y) ^ 2 - (y - x) ^ 2 - x ^ 2)
          (2 * (y - x) ^ 2 - x ^ 2 - (-y) ^ 2)) := by
  apply HamiltonsCubic.ItemFour.coordOp_congr_off
  intro p q hpq
  unfold Wcomb
  by_cases hpi : p = i
  · by_cases hqi : q = i
    · exact absurd (hpi.trans hqi.symm) hpq
    · by_cases hqj : q = j
      · simp [hpi, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
      · by_cases hqk : q = k
        · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
        · by_cases hql : q = l
          · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
          · simp [hpi, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
  · by_cases hpj : p = j
    · by_cases hqi : q = i
      · simp [hpi, Ne.symm hpi, hpj, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
      · by_cases hqj : q = j
        · exact absurd (hpj.trans hqj.symm) hpq
        · by_cases hqk : q = k
          · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
          · by_cases hql : q = l
            · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
            · simp [hpi, Ne.symm hpi, hpj, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
    · by_cases hpk : p = k
      · by_cases hqi : q = i
        · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
        · by_cases hqj : q = j
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
          · by_cases hqk : q = k
            · exact absurd (hpk.trans hqk.symm) hpq
            · by_cases hql : q = l
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
      · by_cases hpl : p = l
        · by_cases hqi : q = i
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
          · by_cases hqj : q = j
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
            · by_cases hqk : q = k
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
              · by_cases hql : q = l
                · exact absurd (hpl.trans hql.symm) hpq
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
        · by_cases hqi : q = i
          · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
          · by_cases hqj : q = j
            · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
            · by_cases hqk : q = k
              · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
              · by_cases hql : q = l
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring
                · simp [hpi, Ne.symm hpi, hpj, Ne.symm hpj, hpk, Ne.symm hpk, hpl, Ne.symm hpl, hqi, Ne.symm hqi, hqj, Ne.symm hqj, hqk, Ne.symm hqk, hql, Ne.symm hql, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl, W4, ind2, uj, E2, PiQ, Pi.single_apply, Matrix.vecMulVec_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul] <;> ring

/-- **L220 (2), `ν ∘ ν ∈ Π_Q` with its pattern**: every Weyl `ν` of character `χ_Q` has signed coordinates `(a, b, c)`,
`a + b + c = 0`, `ν = x σ_A + y σ_B` with `(a, b, c) = (x, -y, y - x)`, and `ν ∘ ν = Π_Q(2a² - b² - c², ...)`. -/
theorem nu_sq {ν : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν) (hν : SignChar (setChar {i, j, k, l}) ν) :
    ∃ a b c : ℝ, a + b + c = 0 ∧ ν = a • sig4 i k j l + (-b) • sig4 i j k l ∧
      Qop2 ν = coordOp (PiQ i j k l (2 * a ^ 2 - b ^ 2 - c ^ 2) (2 * b ^ 2 - c ^ 2 - a ^ 2) (2 * c ^ 2 - a ^ 2 - b ^ 2)) := by
  obtain ⟨x, y, rfl⟩ := four_eq_sig hij hik hil hjk hjl hkl hνW hν
  refine ⟨x, -y, y - x, by ring, by rw [neg_neg], ?_⟩
  rw [Q_lin hij hik hil hjk hjl hkl, ← Wcomb_pattern hij hik hil hjk hjl hkl]
  unfold Wcomb
  rw [coordOp_add, coordOp_add, coordOp_smul', coordOp_smul', coordOp_smul', HamiltonsCubic.ItemFour.coordOp_sub,
    HamiltonsCubic.ItemFour.coordOp_sub]

end

end HamiltonsCubic.FourProd
