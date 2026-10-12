import Mathlib
import HamiltonsCubic.Results.L224LineOdd

set_option linter.style.longLine false

/-!
# L222 item 5's rotation action on the pair block: `e^{φξ}` turns `(D⁻_y, ν_x)` by the double angle

[findings/second-order.md](../../../findings/second-order.md), Lemma L222, item 5: *$\xi\cdot D\in V_{jk}$ with coordinates $K_{ja}-K_{ka}$,
and $\xi\cdot\nu\in\mathcal D_n$*; and L224 step 5: *$\xi\cdot E=0$, $\xi\cdot D^-_y=\nu_{2y}$ and $\xi\cdot\nu_x=D^-_{-2x}$, so $e^{\varphi\xi}$
fixes $E$ and rotates $(y,x)$ by $2\varphi$*. With $R=\mathrm{Rot}_{jk}(c,s)$, $c^2+s^2=1$, the finite rotation reads:

* `sandOp_lin`: a sandwich is linear in its first factor;
* `Rot_S`: $RSR^{\mathsf T}=(c^2-s^2)S-2cs\,D_u$;
* **`rot_Dminus`**: $R\cdot D^-_y=(c^2-s^2)D^-_y+2cs\,\nu_y$;
* **`rot_nuX`**: $R\cdot\nu_x=(c^2-s^2)\nu_x-2cs\,D^-_x$;
* `Rot_mul_off`, `mul_RotT_off`, `RtXR_off`, `rot_out`: a weight supported off $\{j,k\}$ is fixed;
* **`rot_even`**: every swap-even weight ($e_{ja}=e_{ka}$) is fixed.
-/

namespace HamiltonsCubic.L224Rot

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FrameOp2

variable {n : ℕ} {j k : Fin n}

/-- **A sandwich is linear in its first factor.** -/
theorem sandOp_lin (a b : ℝ) {A A' B : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = A) (hA' : A'ᵀ = A') (hB : Bᵀ = B)
    (hC : (a • A + b • A')ᵀ = a • A + b • A') :
    sandOp (a • A + b • A') B hC hB = a • sandOp A B hA hB + b • sandOp A' B hA' hB := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [sandOp_coe]
  show _ = ((a • sandOp A B hA hB X + b • sandOp A' B hA' hB X : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ)
  rw [Submodule.coe_add, Submodule.coe_smul, Submodule.coe_smul, sandOp_coe, sandOp_coe]
  simp only [Matrix.add_mul, Matrix.mul_add, Matrix.smul_mul, Matrix.mul_smul]
  module

/-- **`Rot` conjugates `S`.** -/
theorem Rot_S (hjk : j ≠ k) (c s : ℝ) :
    Rot j k c s * Smat j k * (Rot j k c s)ᵀ = (c ^ 2 - s ^ 2) • Smat j k + (-(2 * c * s)) • diagonal (uj j k) := by
  ext p q
  have e : (Rot j k c s * Smat j k * (Rot j k c s)ᵀ) p q
      = Rot j k c s p k * Rot j k c s q j + Rot j k c s p j * Rot j k c s q k := by
    rw [Matrix.mul_apply]
    have hrow : ∀ r, (Rot j k c s * Smat j k) p r * (Rot j k c s)ᵀ r q
        = (if r = j then Rot j k c s p k * Rot j k c s q j else 0)
          + (if r = k then Rot j k c s p j * Rot j k c s q k else 0) := by
      intro r
      rw [Matrix.mul_apply, Matrix.transpose_apply]
      rw [Smat_col hjk r (Rot j k c s p)]
      by_cases hrj : r = j
      · subst hrj; simp [hjk]
      · by_cases hrk : r = k
        · subst hrk; simp [hrj]
        · simp [hrj, hrk]
    simp only [hrow, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  rw [e]
  simp only [Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, Matrix.diagonal_apply]
  by_cases hpj : p = j
  · subst hpj
    by_cases hqj : q = p
    · subst hqj; simp [Rot, Smat, uj, hjk, Ne.symm hjk]; ring
    · by_cases hqk : q = k
      · subst hqk; simp [Rot, Smat, uj, hjk, Ne.symm hjk]; ring
      · simp [Rot, Smat, uj, hjk, Ne.symm hjk, hqj, hqk, Ne.symm hqj]
  · by_cases hpk : p = k
    · subst hpk
      by_cases hqj : q = j
      · subst hqj; simp [Rot, Smat, uj, hpj, Ne.symm hpj]; ring
      · by_cases hqk : q = p
        · subst hqk; simp [Rot, Smat, uj, hpj, Ne.symm hpj]; ring
        · simp [Rot, Smat, uj, hpj, hqj, hqk, Ne.symm hqk]
    · by_cases hqp : q = p
      · subst hqp; simp [Rot, Smat, uj, hpj, hpk]
      · simp [Rot, Smat, uj, hpj, hpk, Ne.symm hqp, hqp]

theorem lin_T (a b : ℝ) {A A' : Matrix (Fin n) (Fin n) ℝ} (hA : Aᵀ = A) (hA' : A'ᵀ = A') :
    (a • A + b • A')ᵀ = a • A + b • A' := by
  rw [Matrix.transpose_add, Matrix.transpose_smul, Matrix.transpose_smul, hA, hA']

/-- **The rotation of `D⁻_y`**: `R · D⁻_y = (c² - s²) D⁻_y + 2cs ν_y`. -/
theorem rot_Dminus (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) (y : Fin n → ℝ) :
    rotR (Rot j k c s) (coordOp (Dminus j k y))
      = (c ^ 2 - s ^ 2) • coordOp (Dminus j k y) + (2 * c * s) • nuX j k y := by
  have hv : vy j k y j = vy j k y k := by simp [vy]
  unfold Dminus
  rw [coordOp_rank_two, rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _)),
    sandOp_congr _ _ (lin_T _ _ (uj_T j k) (Smat_T j k)) (diag_T _) (Rot_diag_u hjk c s) (Rot_diag_fix hjk hcs _ hv),
    sandOp_lin _ _ (uj_T j k) (Smat_T j k) (diag_T _)]
  rfl

/-- **The rotation of `ν_x`**: `R · ν_x = (c² - s²) ν_x - 2cs D⁻_x`. -/
theorem rot_nuX (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) (x : Fin n → ℝ) :
    rotR (Rot j k c s) (nuX j k x)
      = (c ^ 2 - s ^ 2) • nuX j k x + (-(2 * c * s)) • coordOp (Dminus j k x) := by
  have hv : vy j k x j = vy j k x k := by simp [vy]
  unfold nuX
  rw [rotR_sandOp _ _ _ _ _ (conj_sym _ _ (Smat_T j k)) (conj_sym _ _ (diag_T _)),
    sandOp_congr _ _ (lin_T _ _ (Smat_T j k) (uj_T j k)) (diag_T _) (Rot_S hjk c s) (Rot_diag_fix hjk hcs _ hv),
    sandOp_lin _ _ (Smat_T j k) (uj_T j k) (diag_T _)]
  unfold Dminus
  rw [coordOp_rank_two]

/-- `Rot` acts as the identity on a matrix whose rows `j, k` vanish. -/
theorem Rot_mul_off (hjk : j ≠ k) (c s : ℝ) (M : Matrix (Fin n) (Fin n) ℝ)
    (hM : ∀ r t, (r = j ∨ r = k) → M r t = 0) : Rot j k c s * M = M := by
  ext p t
  rw [Matrix.mul_apply, Rot_row hjk c s p (fun r => M r t)]
  simp only [hM j t (Or.inl rfl), hM k t (Or.inr rfl), mul_zero, sub_zero, add_zero]
  by_cases hpj : p = j
  · rw [if_pos hpj, hpj, hM j t (Or.inl rfl)]
  · by_cases hpk : p = k
    · rw [if_neg hpj, if_pos hpk, hpk, hM k t (Or.inr rfl)]
    · rw [if_neg hpj, if_neg hpk]

/-- `Rotᵀ` acts as the identity from the right on a matrix whose columns `j, k` vanish. -/
theorem mul_RotT_off (hjk : j ≠ k) (c s : ℝ) (M : Matrix (Fin n) (Fin n) ℝ)
    (hM : ∀ r t, (t = j ∨ t = k) → M r t = 0) : M * (Rot j k c s)ᵀ = M := by
  ext p q
  rw [Matrix.mul_apply]
  simp only [Matrix.transpose_apply]
  rw [show (∑ t, M p t * Rot j k c s q t) = ∑ t, Rot j k c s q t * M p t from
    Finset.sum_congr rfl fun t _ => mul_comm _ _, Rot_row hjk c s q (M p)]
  simp only [hM p j (Or.inl rfl), hM p k (Or.inr rfl), mul_zero, sub_zero, add_zero]
  by_cases hqj : q = j
  · rw [if_pos hqj, hqj, hM p j (Or.inl rfl)]
  · by_cases hqk : q = k
    · rw [if_neg hqj, if_pos hqk, hqk, hM p k (Or.inr rfl)]
    · rw [if_neg hqj, if_neg hqk]

/-- `Rotᵀ X Rot` agrees with `X` off the rows and columns `j, k`. -/
theorem RtXR_off (hjk : j ≠ k) (c s : ℝ) (X : Matrix (Fin n) (Fin n) ℝ) {p q : Fin n} (hpj : p ≠ j) (hpk : p ≠ k)
    (hqj : q ≠ j) (hqk : q ≠ k) : ((Rot j k c s)ᵀ * X * Rot j k c s) p q = X p q := by
  rw [Matrix.mul_apply, Rot_col hjk c s q (fun t => ((Rot j k c s)ᵀ * X) p t), if_neg hqj, if_neg hqk,
    Matrix.mul_apply]
  simp only [Matrix.transpose_apply]
  rw [show (∑ r, Rot j k c s r p * X r q) = ∑ r, X r q * Rot j k c s r p from
    Finset.sum_congr rfl fun r _ => mul_comm _ _, Rot_col hjk c s p (fun r => X r q), if_neg hpj, if_neg hpk]

/-- **A weight supported off `{j, k}` is fixed by the rotation.** -/
theorem rot_out (hjk : j ≠ k) (c s : ℝ) (e : Matrix (Fin n) (Fin n) ℝ) (he : eᵀ = e)
    (hoff : ∀ p q, (p = j ∨ p = k ∨ q = j ∨ q = k) → e p q = 0) :
    rotR (Rot j k c s) (coordOp e) = coordOp e := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [rotR_coe, coordOp_coe e he, cU_coe, coordOp_coe e he]
  set x := (X : Matrix (Fin n) (Fin n) ℝ)
  have h1 : e ⊙ ((Rot j k c s)ᵀ * x * Rot j k c s) = e ⊙ x := by
    ext p q
    simp only [Matrix.hadamard_apply]
    by_cases h : p = j ∨ p = k ∨ q = j ∨ q = k
    · rw [hoff p q h, zero_mul, zero_mul]
    · push Not at h
      rw [RtXR_off hjk c s x h.1 h.2.1 h.2.2.1 h.2.2.2]
  rw [h1, Rot_mul_off hjk c s _ (fun r t hr => by
      simp only [Matrix.hadamard_apply]; rw [hoff r t (by tauto), zero_mul]),
    mul_RotT_off hjk c s _ (fun r t ht => by
      simp only [Matrix.hadamard_apply]; rw [hoff r t (by tauto), zero_mul])]

/-- **A swap-even weight is fixed by the rotation**: `e_{ja} = e_{ka}` off `{j, k}`. -/
theorem rot_even (hjk : j ≠ k) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) (e : Matrix (Fin n) (Fin n) ℝ) (he : eᵀ = e)
    (hev : ∀ a, a ≠ j → a ≠ k → e j a = e k a) :
    rotR (Rot j k c s) (coordOp e) = coordOp e := by
  have hs : ∀ p q, e p q = e q p := fun p q => by rw [← Matrix.transpose_apply e q p, he]
  set P : Fin n → ℝ := fun i => if i = j ∨ i = k then 1 else 0 with hP
  set r : Fin n → ℝ := vy j k (fun a => e j a) with hr
  set eo : Matrix (Fin n) (Fin n) ℝ := Matrix.of fun p q => if p = j ∨ p = k ∨ q = j ∨ q = k then 0 else e p q with heo
  have heoT : eoᵀ = eo := by
    ext p q; simp only [heo, Matrix.transpose_apply, Matrix.of_apply]
    by_cases h : p = j ∨ p = k ∨ q = j ∨ q = k
    · rw [if_pos (by tauto), if_pos h]
    · rw [if_neg (by tauto), if_neg h, hs]
  have hoff : ∀ p q, (p = j ∨ p = k ∨ q = j ∨ q = k) → eo p q = 0 := fun p q h => by
    simp only [heo, Matrix.of_apply, if_pos h]
  -- the decomposition, read off the diagonal
  have hdec : coordOp e = coordOp eo + coordOp (vecMulVec P r + vecMulVec r P)
      + (e j k / 2) • (coordOp (vecMulVec P P) - coordOp (vecMulVec (uj j k) (uj j k))) := by
    rw [← HamiltonsCubic.ItemFour.coordOp_sub, ← coordOp_smul', ← coordOp_add, ← coordOp_add]
    apply HamiltonsCubic.ItemFour.coordOp_congr_off
    intro p q hpq
    simp only [Matrix.add_apply, Matrix.smul_apply, Matrix.sub_apply, Matrix.vecMulVec_apply, smul_eq_mul, heo,
      Matrix.of_apply, hP, hr, vy, uj]
    by_cases hpj : p = j
    · subst hpj
      by_cases hqk : q = k
      · subst hqk; simp [hjk, Ne.symm hjk]; ring
      · have hqj : q ≠ p := Ne.symm hpq
        simp [hjk, Ne.symm hjk, hqj, hqk]
    · by_cases hpk : p = k
      · subst hpk
        by_cases hqj : q = j
        · subst hqj; simp [hpj, Ne.symm hpj]; rw [hs]; ring
        · have hqk : q ≠ p := Ne.symm hpq
          simp [hpj, Ne.symm hpj, hqj, hqk]; rw [hev q hqj hqk]
      · by_cases hqj : q = j
        · subst hqj; simp [hpj, hpk, Ne.symm hpj]; rw [hs]
        · by_cases hqk : q = k
          · subst hqk; simp [hpj, hpk, hqj, Ne.symm hqj]; rw [hs, hev p hpj hpk]
          · simp [hpj, hpk, hqj, hqk]
  have hPjk : P j = P k := by simp [hP]
  have hrjk : r j = r k := by simp [hr, vy]
  have h2 : rotR (Rot j k c s) (coordOp (vecMulVec P r + vecMulVec r P)) = coordOp (vecMulVec P r + vecMulVec r P) := by
    rw [coordOp_rank_two, rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _))]
    exact sandOp_congr _ _ _ _ (Rot_diag_fix hjk hcs _ hPjk) (Rot_diag_fix hjk hcs _ hrjk)
  have h3 : rotR (Rot j k c s) (coordOp (vecMulVec P P)) = coordOp (vecMulVec P P) := by
    rw [coordOp_vv, LinearMap.map_smul, rotR_sandOp _ _ _ _ _ (conj_sym _ _ (diag_T _)) (conj_sym _ _ (diag_T _)),
      sandOp_congr _ _ (diag_T _) (diag_T _) (Rot_diag_fix hjk hcs _ hPjk) (Rot_diag_fix hjk hcs _ hPjk)]
  have h4 : rotR (Rot j k c s) (coordOp (vecMulVec (uj j k) (uj j k))) = coordOp (vecMulVec (uj j k) (uj j k)) := by
    rw [coordOp_vv, LinearMap.map_smul, sandOp_uu_rot hjk hcs]
  have e5 : coordOp (vecMulVec P P) - coordOp (vecMulVec (uj j k) (uj j k))
      = coordOp (vecMulVec P P) + (-1 : ℝ) • coordOp (vecMulVec (uj j k) (uj j k)) := by module
  rw [hdec, LinearMap.map_add, LinearMap.map_add, LinearMap.map_smul, e5, LinearMap.map_add, LinearMap.map_smul,
    rot_out hjk c s eo heoT hoff, h2, h3, h4]

end HamiltonsCubic.L224Rot
