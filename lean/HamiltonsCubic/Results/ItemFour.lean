import Mathlib
import HamiltonsCubic.Results.PairNorm

set_option linter.style.longLine false

/-!
# L222 item 4: `L_{G_x}` on the odd part is `y ↦ ½‖x‖² y + x⟨x, y⟩`

[findings/second-order.md](../../../findings/second-order.md), Lemma L222, item 4: *on the odd part, identified with
$\{y:\sum y=0\}$, $L_{G_x}$ acts as $y\mapsto\tfrac12\lVert x\rVert^2y+x\langle x,y\rangle$.* The odd part is $D^-_y$ of
[DiagSquare.lean](DiagSquare.lean), and the product of two coordinate-diagonal operators is the polarisation of `Qop2_coordOp`:

* `foxProd2_coordOp`: $(a\odot\cdot)\circ(b\odot\cdot)=(a\odot b+\tfrac12(ab+ba))\odot\cdot$ at symmetric weights with zero diagonal;
* `coordOp_congr_off`: a coordinate operator reads its weight off the diagonal only;
* **`LG_Dminus`**: $G_x\circ D^-_y=D^-_z$ with $z=\tfrac12\lVert x\rVert^2y+\langle x,y\rangle x$, $x,y$ taken off $\{j,k\}$, with no condition on the sums.

The odd part is parametrised here by $y\mapsto D^-_y$. [OddPart.lean](OddPart.lean) proves that every swap-odd Weyl operator of
character $1$ is some $D^-_y$ with $\sum y=0$ (`odd_eq_Dminus`) and states item 4 on that set (`LG_odd`).
-/

namespace HamiltonsCubic.ItemFour

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare
  HamiltonsCubic.PairNorm

variable {n : ℕ} {j k : Fin n}

theorem coordOp_congr_off {a b : Matrix (Fin n) (Fin n) ℝ} (h : ∀ p q, p ≠ q → a p q = b p q) : coordOp a = coordOp b := by
  rw [← coordOp_offDiag a, ← coordOp_offDiag b]
  congr 1
  funext p q
  unfold I117S.offDiag
  split_ifs with hpq
  · rfl
  · exact h p q hpq

theorem coordOp_sub (a b : Matrix (Fin n) (Fin n) ℝ) : coordOp (a - b) = coordOp a - coordOp b := by
  have e : a - b = a + (-1 : ℝ) • b := by module
  rw [e, coordOp_add, coordOp_smul']
  module

/-- **The product of two coordinate-diagonal operators.** -/
theorem foxProd2_coordOp (a b : Matrix (Fin n) (Fin n) ℝ) (ha : aᵀ = a) (hb : bᵀ = b) (ha0 : ∀ x, a x x = 0)
    (hb0 : ∀ x, b x x = 0) :
    foxProd2 (coordOp a) (coordOp b) = coordOp (a ⊙ b + (1 / 2 : ℝ) • (a * b + b * a)) := by
  have hab : (a + b)ᵀ = a + b := by rw [transpose_add, ha, hb]
  have hab0 : ∀ x, (a + b) x x = 0 := fun x => by rw [Matrix.add_apply, ha0, hb0, add_zero]
  unfold foxProd2
  rw [← coordOp_add, Qop2_coordOp _ hab hab0, Qop2_coordOp a ha ha0, Qop2_coordOp b hb hb0]
  have hW : a ⊙ b + (1 / 2 : ℝ) • (a * b + b * a)
      = (1 / 2 : ℝ) • ((a + b) ⊙ (a + b) + (a + b) * (a + b) - (a ⊙ a + a * a) - (b ⊙ b + b * b)) := by
    ext p q
    simp only [Matrix.smul_apply, Matrix.add_apply, Matrix.sub_apply, Matrix.hadamard_apply, Matrix.mul_add,
      Matrix.add_mul, smul_eq_mul]
    ring
  rw [hW, coordOp_smul', coordOp_sub, coordOp_sub]

/-- **L222 (4)**: `G_x ∘ D⁻_y = D⁻_z` with `z = ½‖x‖² y + ⟨x, y⟩ x`, `x, y` taken off `{j, k}`. -/
theorem LG_Dminus (hjk : j ≠ k) (x y : Fin n → ℝ) :
    foxProd2 (coordOp (Gy j k x)) (coordOp (Dminus j k y))
      = coordOp (Dminus j k (fun i => (1 / 2 : ℝ) * (∑ c, vy j k x c * vy j k x c) * vy j k y i
          + (∑ c, vy j k x c * vy j k y c) * vy j k x i)) := by
  set u := uj j k with hudef
  set a := vy j k x with hadef
  set b := vy j k y with hbdef
  set V2 := ∑ c, a c * a c with hV2
  set Sab := ∑ c, a c * b c with hSab
  set Sa2b := ∑ c, a c ^ 2 * b c with hSa2b
  have hU2 : ∑ c, u c * u c = 2 := uj_norm hjk
  have hGT := Gy_sym j k x
  have hGh : (I117S.offDiag (Gy j k x))ᵀ = I117S.offDiag (Gy j k x) := by
    ext p q; simp only [Matrix.transpose_apply, I117S.offDiag]
    split_ifs with h1 h2 h2
    · rfl
    · exact absurd h1.symm h2
    · exact absurd h2.symm h1
    · rw [← Matrix.transpose_apply (Gy j k x) p q, hGT]
  have hGh0 : ∀ p, I117S.offDiag (Gy j k x) p p = 0 := fun p => by simp [I117S.offDiag]
  have hDT : (Dminus j k y)ᵀ = Dminus j k y := vv_sym _ _
  rw [← coordOp_offDiag (Gy j k x), foxProd2_coordOp _ _ hGh hDT hGh0 (Dminus_hollow j k y)]
  apply coordOp_congr_off
  intro p q hpq
  have hG : ∀ p r, Gy j k x p r = u p ^ 2 * a r ^ 2 + a p ^ 2 * u r ^ 2 + V2 * (u p * u r) + 2 * (a p * a r) := by
    intro p r
    simp only [Gy, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul]
    rw [hU2]; simp only [hudef, hadef, hV2]; ring
  have hD : ∀ r q, Dminus j k y r q = u r * b q + b r * u q := fun r q => by
    simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply]; rfl
  have hua : ∀ i, u i * a i = 0 := uj_vy j k x
  have hub : ∀ i, u i * b i = 0 := uj_vy j k y
  have s1 : ∑ r, a r ^ 2 * u r = 0 := Finset.sum_eq_zero fun r _ => by
    rw [show a r ^ 2 * u r = a r * (u r * a r) by ring, hua]; ring
  have s2 : ∑ r, u r ^ 3 = 0 := by
    simp only [hudef, uj]
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j), if_pos rfl,
      ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hjk, Finset.mem_univ k⟩), if_neg (Ne.symm hjk), if_pos rfl,
      Finset.sum_eq_zero fun c hc => by
        rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]; ring]
    ring
  have s3 : ∑ r, u r ^ 2 * b r = 0 := Finset.sum_eq_zero fun r _ => by
    rw [show u r ^ 2 * b r = u r * (u r * b r) by ring, hub]; ring
  have s4 : ∑ r, u r ^ 2 = 2 := by rw [← hU2]; exact Finset.sum_congr rfl fun r _ => by ring
  have s5 : ∑ r, u r * b r = 0 := Finset.sum_eq_zero fun r _ => hub r
  have s6 : ∑ r, a r * u r = 0 := Finset.sum_eq_zero fun r _ => by rw [mul_comm, hua]
  have hrow : ∀ p q, ∑ r, Gy j k x p r * Dminus j k y r q
      = u p ^ 2 * u q * Sa2b + 2 * V2 * u p * b q + 2 * a p * u q * Sab := by
    intro p q
    have e : ∀ r, Gy j k x p r * Dminus j k y r q
        = u p ^ 2 * b q * (a r ^ 2 * u r) + u p ^ 2 * u q * (a r ^ 2 * b r) + a p ^ 2 * b q * u r ^ 3
          + a p ^ 2 * u q * (u r ^ 2 * b r) + V2 * u p * b q * u r ^ 2 + V2 * u p * u q * (u r * b r)
          + 2 * a p * b q * (a r * u r) + 2 * a p * u q * (a r * b r) := by
      intro r; rw [hG, hD]; ring
    rw [Finset.sum_congr rfl fun r _ => e r]
    simp only [Finset.sum_add_distrib, ← Finset.mul_sum]
    rw [s1, s2, s3, s4, s5, s6]
    ring
  have hoff : ∀ p q, p ≠ q → I117S.offDiag (Gy j k x) p q = Gy j k x p q := fun p q h => by
    simp [I117S.offDiag, h]
  have hmul : ∀ p q, (I117S.offDiag (Gy j k x) * Dminus j k y) p q
      = ∑ r, Gy j k x p r * Dminus j k y r q - Gy j k x p p * Dminus j k y p q := by
    intro p q
    rw [Matrix.mul_apply]
    have e : ∀ r, I117S.offDiag (Gy j k x) p r * Dminus j k y r q
        = Gy j k x p r * Dminus j k y r q - if r = p then Gy j k x p p * Dminus j k y p q else 0 := by
      intro r
      by_cases h : r = p
      · subst h; simp [I117S.offDiag]
      · simp [I117S.offDiag, Ne.symm h, h]
    rw [Finset.sum_congr rfl fun r _ => e r, Finset.sum_sub_distrib]
    simp
  have hswap : Dminus j k y * I117S.offDiag (Gy j k x) = (I117S.offDiag (Gy j k x) * Dminus j k y)ᵀ := by
    rw [Matrix.transpose_mul, hDT, hGh]
  have hmul2 : (Dminus j k y * I117S.offDiag (Gy j k x)) p q = (I117S.offDiag (Gy j k x) * Dminus j k y) q p := by
    rw [hswap]; rfl
  simp only [Matrix.add_apply, Matrix.smul_apply, Matrix.hadamard_apply, smul_eq_mul, hmul2, hmul p q, hmul q p,
    hrow, hoff p q hpq]
  simp only [hG, hD]
  simp only [Dminus, Matrix.add_apply, Matrix.vecMulVec_apply]
  -- the entries of `u`, `a`, `b` by the position of `p` and `q`
  have hvj : ∀ f : Fin n → ℝ, vy j k f j = 0 := fun f => by simp [vy]
  have hvk : ∀ f : Fin n → ℝ, vy j k f k = 0 := fun f => by simp [vy]
  have hvo : ∀ f : Fin n → ℝ, ∀ i, i ≠ j → i ≠ k → vy j k f i = f i := fun f i h1 h2 => by simp [vy, h1, h2]
  by_cases hpj : p = j
  · subst hpj
    by_cases hqk : q = k
    · subst hqk; simp [hudef, hadef, hbdef, uj, hvj, hvk, Ne.symm hjk]
    · have hqj : q ≠ p := Ne.symm hpq
      simp [hudef, hadef, hbdef, uj, hvj, hvo _ q hqj hqk, hqj, hqk]; ring
  · by_cases hpk : p = k
    · subst hpk
      by_cases hqj : q = j
      · subst hqj; simp [hudef, hadef, hbdef, uj, hvj, hvk, hpj]
      · have hqk : q ≠ p := Ne.symm hpq
        simp [hudef, hadef, hbdef, uj, hvk, hvo _ q hqj hqk, hqj, hqk, hpj]; ring
    · by_cases hqj : q = j
      · subst hqj; simp [hudef, hadef, hbdef, uj, hvj, hvo _ p hpj hpk, hpj, hpk]; ring
      · by_cases hqk : q = k
        · subst hqk; simp [hudef, hadef, hbdef, uj, hvk, hvo _ p hpj hpk, hpj, hpk, hqj]; ring
        · simp [hudef, hadef, hbdef, uj, hvo _ p hpj hpk, hvo _ q hqj hqk, hpj, hpk, hqj, hqk]

end HamiltonsCubic.ItemFour
