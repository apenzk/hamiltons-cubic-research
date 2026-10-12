import Mathlib
import HamiltonsCubic.Results.I117Statements

set_option linter.style.longLine false

/-!
# `Q` on a coordinate-diagonal operator, and L224's `D⁻_y ∘ D⁻_y = G_y`

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, step 2: *with the diagonal product
$(A\circ A)_{pq}=A_{pq}^2+\sum_cA_{pc}A_{cq}$, $D^-_y\circ D^-_y$ has $(ja)$-entry $y_a^2$, $(jk)$-entry $-\lVert y\rVert^2$ and $(ab)$-entry
$2y_ay_b$, so it is $G_y$.* [I117Statements.lean](I117Statements.lean) carries the coordinate-diagonal operator `coordOp a`,
$X\mapsto a\odot X$, and its sharp `sharpMapCL_coordOp`. Here the square:

* `coordOp_add`, `compOp2_coordOp`, `starW_eq_mul`: `coordOp` is additive in the weight, $(a\odot\cdot)^2=(a\odot a)\odot\cdot$, and
  `starW a` is the matrix square $a\,a$;
* **`Qop2_coordOp`**: $Q(a\odot\cdot)=(a\odot a+a\,a)\odot\cdot$ at a symmetric weight with zero diagonal, the record's diagonal product;
* **`Qop2_rank_two`**: at the weight $uv^{\mathsf T}+vu^{\mathsf T}$ with $u,v$ of disjoint supports ($u_iv_i=0$, so $u\cdot v=0$),
  $Q=\big((u\odot u)(v\odot v)^{\mathsf T}+(v\odot v)(u\odot u)^{\mathsf T}+\lVert v\rVert^2uu^{\mathsf T}+\lVert u\rVert^2vv^{\mathsf T}\big)\odot\cdot$;
* **`Q_Dminus`**: at $u=e_j-e_k$ and $v=y$ off $\{j,k\}$, this is L224's $D^-_y\circ D^-_y=G_y$, with $G_y$'s entries
  `Gy_ja`, `Gy_ka`, `Gy_jk`, `Gy_ab` as the record states them.
-/

namespace HamiltonsCubic.DiagSquare

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.I117S

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem coordOp_add (a b : Matrix ι ι ℝ) : coordOp (a + b) = coordOp a + coordOp b := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show skewPartM ((a + b) ⊙ (X : Matrix ι ι ℝ)) = skewPartM (a ⊙ (X : Matrix ι ι ℝ)) + skewPartM (b ⊙ (X : Matrix ι ι ℝ))
  rw [Matrix.add_hadamard]; unfold skewPartM; rw [Matrix.transpose_add]; module

theorem compOp2_coordOp (a : Matrix ι ι ℝ) (ha : aᵀ = a) : compOp2 (coordOp a) = coordOp (a ⊙ a) := by
  have haa : (a ⊙ a)ᵀ = a ⊙ a := by
    ext x y; simp only [Matrix.transpose_apply, Matrix.hadamard_apply]
    rw [← Matrix.transpose_apply a y x, ha]
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  show ((coordOp a (coordOp a X) : skewSub ι) : Matrix ι ι ℝ) = _
  rw [coordOp_coe a ha, coordOp_coe a ha, coordOp_coe (a ⊙ a) haa]
  ext x y; simp only [Matrix.hadamard_apply]; ring

theorem starW_eq_mul (a : Matrix ι ι ℝ) : starW a = a * a := by
  ext x y; simp [starW, Matrix.mul_apply]

/-- **`Q` on a coordinate-diagonal operator**: `Q(a ⊙ ·) = (a ⊙ a + a a) ⊙ ·`. -/
theorem Qop2_coordOp (a : Matrix ι ι ℝ) (ha : aᵀ = a) (ha0 : ∀ x, a x x = 0) :
    Qop2 (coordOp a) = coordOp (a ⊙ a + a * a) := by
  unfold Qop2
  rw [compOp2_coordOp a ha, sharpMapCL_coordOp a ha ha0, starW_eq_mul, coordOp_add]

/-- **`Q` at a rank-two weight** `u vᵀ + v uᵀ`, `u, v` of disjoint supports. -/
theorem Qop2_rank_two (u v : ι → ℝ) (hdis : ∀ i, u i * v i = 0) :
    Qop2 (coordOp (vecMulVec u v + vecMulVec v u))
      = coordOp (vecMulVec (fun i => u i * u i) (fun i => v i * v i) + vecMulVec (fun i => v i * v i) (fun i => u i * u i)
          + (∑ c, v c * v c) • vecMulVec u u + (∑ c, u c * u c) • vecMulVec v v) := by
  set a := vecMulVec u v + vecMulVec v u with hadef
  have ha : aᵀ = a := by
    rw [hadef, Matrix.transpose_add, Matrix.transpose_vecMulVec, Matrix.transpose_vecMulVec, add_comm]
  have ha0 : ∀ x, a x x = 0 := fun x => by
    simp only [hadef, Matrix.add_apply, Matrix.vecMulVec_apply]; rw [hdis x, mul_comm (v x), hdis x]; ring
  rw [Qop2_coordOp a ha ha0]
  congr 1
  have huv : ∑ c, u c * v c = 0 := Finset.sum_eq_zero fun c _ => hdis c
  ext x y
  simp only [hadef, Matrix.add_apply, Matrix.hadamard_apply, Matrix.vecMulVec_apply, Matrix.mul_apply,
    Matrix.smul_apply, smul_eq_mul]
  have hsum : ∑ c, (u x * v c + v x * u c) * (u c * v y + v c * u y)
      = (u x * v y) * (∑ c, u c * v c) + (u x * u y) * (∑ c, v c * v c) + (v x * v y) * (∑ c, u c * u c)
        + (v x * u y) * (∑ c, u c * v c) := by
    rw [Finset.mul_sum, Finset.mul_sum, Finset.mul_sum, Finset.mul_sum, ← Finset.sum_add_distrib,
      ← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun c _ => by ring
  rw [hsum, huv]
  have hx := hdis x
  have hy := hdis y
  have e : (u x * v y + v x * u y) * (u x * v y + v x * u y)
      = u x * u x * (v y * v y) + v x * v x * (u y * u y) + 2 * (u x * v x) * (u y * v y) := by ring
  rw [e, hx]
  ring

variable {n : ℕ}

/-- `u = e_j − e_k`. -/
noncomputable def uj (j k : Fin n) : Fin n → ℝ := fun i => if i = j then 1 else if i = k then -1 else 0

/-- `v = y` off `{j, k}`. -/
noncomputable def vy (j k : Fin n) (y : Fin n → ℝ) : Fin n → ℝ := fun i => if i = j ∨ i = k then 0 else y i

/-- **The record's `D⁻_y`**: weight `y_a` at `(j, a)`, `−y_a` at `(k, a)`, `a ∉ {j, k}`, symmetric, zero elsewhere. -/
noncomputable def Dminus (j k : Fin n) (y : Fin n → ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  vecMulVec (uj j k) (vy j k y) + vecMulVec (vy j k y) (uj j k)

/-- **The record's `G_y` off the diagonal**, as the weight `Q_Dminus` produces; its diagonal, which `coordOp` never
reads (`coordOp_offDiag`), differs from the record's hollow `K`. -/
noncomputable def Gy (j k : Fin n) (y : Fin n → ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  vecMulVec (fun i => uj j k i * uj j k i) (fun i => vy j k y i * vy j k y i)
    + vecMulVec (fun i => vy j k y i * vy j k y i) (fun i => uj j k i * uj j k i)
    + (∑ c, vy j k y c * vy j k y c) • vecMulVec (uj j k) (uj j k)
    + (∑ c, uj j k c * uj j k c) • vecMulVec (vy j k y) (vy j k y)

theorem uj_vy (j k : Fin n) (y : Fin n → ℝ) (i : Fin n) : uj j k i * vy j k y i = 0 := by
  unfold uj vy
  by_cases hj : i = j
  · simp [hj]
  · by_cases hk : i = k <;> simp [hj, hk]

/-- **L224 (2), the first square**: `D⁻_y ∘ D⁻_y = G_y`. -/
theorem Q_Dminus (j k : Fin n) (y : Fin n → ℝ) : Qop2 (coordOp (Dminus j k y)) = coordOp (Gy j k y) :=
  Qop2_rank_two _ _ (uj_vy j k y)

/-- `‖u‖² = 2` at `j ≠ k`. -/
theorem uj_norm {j k : Fin n} (hjk : j ≠ k) : ∑ c, uj j k c * uj j k c = 2 := by
  unfold uj
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j), if_pos rfl,
    ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hjk, Finset.mem_univ k⟩), if_neg (Ne.symm hjk), if_pos rfl,
    Finset.sum_eq_zero fun c hc => by
      rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]; ring]
  norm_num

/-- `G_y`'s `(j, a)` entry is `y_a²`, `a ∉ {j, k}`. -/
theorem Gy_ja {j k a : Fin n} (hjk : j ≠ k) (haj : a ≠ j) (hak : a ≠ k) (y : Fin n → ℝ) : Gy j k y j a = y a ^ 2 := by
  simp [Gy, uj, vy, Matrix.vecMulVec_apply, haj, hak, Ne.symm haj, Ne.symm hak, hjk]; ring

/-- `G_y`'s `(k, a)` entry is `y_a²`, `a ∉ {j, k}`. -/
theorem Gy_ka {j k a : Fin n} (hjk : j ≠ k) (haj : a ≠ j) (hak : a ≠ k) (y : Fin n → ℝ) : Gy j k y k a = y a ^ 2 := by
  simp [Gy, uj, vy, Matrix.vecMulVec_apply, haj, hak, Ne.symm haj, Ne.symm hak, Ne.symm hjk]; ring

/-- `G_y`'s `(j, k)` entry is `−‖y‖²` over the indices off `{j, k}`. -/
theorem Gy_jk {j k : Fin n} (hjk : j ≠ k) (y : Fin n → ℝ) :
    Gy j k y j k = -∑ c, vy j k y c * vy j k y c := by
  simp [Gy, uj, vy, Matrix.vecMulVec_apply, hjk, Ne.symm hjk]

/-- `G_y`'s `(a, b)` entry is `2 y_a y_b`, `a ≠ b` both off `{j, k}`. -/
theorem Gy_ab {j k a b : Fin n} (hjk : j ≠ k) (haj : a ≠ j) (hak : a ≠ k) (hbj : b ≠ j) (hbk : b ≠ k)
    (_hab : a ≠ b) (y : Fin n → ℝ) : Gy j k y a b = 2 * (y a * y b) := by
  unfold Gy
  rw [uj_norm hjk]
  simp [uj, vy, Matrix.vecMulVec_apply, haj, hak, hbj, hbk]

end HamiltonsCubic.DiagSquare
