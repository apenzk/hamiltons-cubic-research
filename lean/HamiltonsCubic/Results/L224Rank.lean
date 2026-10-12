import Mathlib
import HamiltonsCubic.Results.L57Bridge

set_option linter.style.longLine false

/-!
# L224 step 5, rank one: at an L57 maximiser with `v_j = -v_k`, `⟨B', G_z⟩ = t⟨v, z⟩²` on the plane

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, step 5: *Since $G_z$ is swap-even, $q_E=q_{B'}$, and expanding,
$q_{B'}(z)=(\alpha_A+\alpha_B-2\gamma)\big(\sum_{a\in A'}z_a\big)^2$ … On $\{\sum z=0\}$ this is $c\langle\bar u,z\rangle^2$.* Here the
maximiser is read in L57's form $w=t\,Z'(v)$ ([L57Bridge.lean](L57Bridge.lean)), with $v_a^2=1/n$ and $v_j=-v_k$ ($j,k$ in different
blocks), and the expansion is a finite sum.

* `innerOp2_coordOp`: $\langle a\odot\cdot,b\odot\cdot\rangle=\tfrac12\sum_{i\ne l}a_{il}b_{il}$ at symmetric weights;
* `uj_swap`, `vy_swap`, `Gy_swap`: $G_z$ is swap-even;
* **`inner_Zp_Gy`**: $\langle t\,Z'(v)\odot\cdot,\,G_z\rangle=t\langle v,z\rangle^2$ for $z$ in the plane.
-/

namespace HamiltonsCubic.L224Rank

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.I117S HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.L222Swap HamiltonsCubic.OddPart
  HamiltonsCubic.FrameOp2 HamiltonsCubic.FamilyLayer HamiltonsCubic.L57Critical HamiltonsCubic.PairNorm

variable {n : ℕ} {j k : Fin n}

/-- **The pairing of two coordinate-diagonal operators.** -/
theorem innerOp2_coordOp (a b : Matrix (Fin n) (Fin n) ℝ) (ha : aᵀ = a) (hb : bᵀ = b) :
    innerOp2 (coordOp a) (coordOp b) = (1 / 2) * ∑ i, ∑ l, (if i = l then 0 else a i l * b i l) := by
  unfold innerOp2
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => ?_
  have e : ∀ c : Matrix (Fin n) (Fin n) ℝ, cᵀ = c → applyPhi (coordOp c) i l = c i l • phi i l := fun c hc => by
    show ((coordOp c ⟨phi i l, phi_mem_skewSub i l⟩ : skewSub (Fin n)) : Matrix (Fin n) (Fin n) ℝ) = _
    rw [coordOp_coe c hc]; exact hadamard_phi c hc i l
  rw [e a ha, e b hb, FamilyLayer.inner2_smul_left, FamilyLayer.inner2_smul_right, FamilyLayer.inner2_phi_phi]
  by_cases h : i = l
  · subst h; simp
  · simp [h, Ne.symm h]

theorem uj_swap (hjk : j ≠ k) (p : Fin n) : uj j k (Equiv.swap j k p) = -uj j k p := by
  unfold uj
  by_cases h1 : p = j
  · subst h1; simp [Equiv.swap_apply_left, Ne.symm hjk]
  · by_cases h2 : p = k
    · subst h2; simp [Equiv.swap_apply_right, h1]
    · rw [Equiv.swap_apply_of_ne_of_ne h1 h2]; simp [h1, h2]

theorem vy_swap (y : Fin n → ℝ) (p : Fin n) : vy j k y (Equiv.swap j k p) = vy j k y p := by
  unfold vy
  by_cases h1 : p = j
  · subst h1; simp [Equiv.swap_apply_left]
  · by_cases h2 : p = k
    · subst h2; simp [Equiv.swap_apply_right]
    · rw [Equiv.swap_apply_of_ne_of_ne h1 h2]

/-- **`G_z` is swap-even.** -/
theorem Gy_swap (hjk : j ≠ k) (z : Fin n → ℝ) :
    rotR (swapM j k) (coordOp (Gy j k z)) = coordOp (Gy j k z) := by
  rw [rotR_swap_coordOp j k _ (Gy_sym j k z)]
  congr 1
  ext p q
  simp only [Matrix.of_apply, Gy, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul,
    uj_swap hjk, vy_swap]
  ring

/-- **The pairing at L57's maximiser form**: with `v_a² = 1/n` and `v_j + v_k = 0`, `⟨t Z'(v), G_z⟩ = t⟨v, z⟩²` for `z`
zero at `j, k` with `Σ z = 0`. -/
theorem inner_Zp_Gy (hjk : j ≠ k) (v : Fin n → ℝ) (hv2 : ∀ a, v a ^ 2 = 1 / (n : ℝ)) (hvjk : v j + v k = 0) (t : ℝ)
    (z : Fin n → ℝ) (hzj : z j = 0) (hzk : z k = 0) (hzs : ∑ i, z i = 0) :
    innerOp2 (coordOp (Matrix.of fun a b => t * Zp v (n : ℝ) a b)) (coordOp (Gy j k z))
      = t * (∑ a, v a * z a) ^ 2 := by
  have hvz : vy j k z = z := HamiltonsCubic.PairIdent.vy_of_zero z hzj hzk
  set u := uj j k with hudef
  set κ : ℝ := (1 / (n : ℝ) + 1 / (n : ℝ)) / ((n : ℝ) - 2) - 1 / (((n : ℝ) - 1) * ((n : ℝ) - 2)) with hκ
  set V : ℝ := ∑ c, z c * z c with hV
  have hU : ∑ c, u c * u c = 2 := uj_norm hjk
  have hZT : (Matrix.of fun a b => t * Zp v (n : ℝ) a b)ᵀ = Matrix.of fun a b => t * Zp v (n : ℝ) a b := by
    ext a b; simp only [Matrix.transpose_apply, Matrix.of_apply, Zp]
    by_cases h : a = b
    · subst h; simp
    · rw [if_neg h, if_neg (Ne.symm h)]; ring
  rw [innerOp2_coordOp _ _ hZT (Gy_sym j k z)]
  have hG : ∀ i l, Gy j k z i l = u i ^ 2 * z l ^ 2 + z i ^ 2 * u l ^ 2 + V * (u i * u l) + 2 * (z i * z l) := by
    intro i l
    simp only [Gy, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul, hvz]
    rw [← hudef, hU]; simp only [hV]; ring
  have huz : ∀ i, u i * z i = 0 := fun i => by rw [hudef, ← hvz]; exact uj_vy j k z i
  -- off the diagonal, `t Z'(v) = t (v_i v_l + κ)`
  have hZ : ∀ i l, (if i = l then 0 else (Matrix.of fun a b => t * Zp v (n : ℝ) a b) i l * Gy j k z i l)
      = t * ((v i * v l + κ) * Gy j k z i l) - (if i = l then t * ((v i * v i + κ) * Gy j k z i i) else 0) := by
    intro i l
    by_cases h : i = l
    · subst h; simp
    · simp only [Matrix.of_apply, Zp, if_neg h, hv2, hκ]; ring
  simp only [hZ, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  -- the three sums
  have e1 : ∀ i l, (v i * v l + κ) * Gy j k z i l
      = (v i * u i ^ 2) * (v l * z l ^ 2) + (v i * z i ^ 2) * (v l * u l ^ 2) + V * ((v i * u i) * (v l * u l))
        + 2 * ((v i * z i) * (v l * z l)) + κ * (u i ^ 2 * z l ^ 2 + z i ^ 2 * u l ^ 2 + V * (u i * u l) + 2 * (z i * z l)) := by
    intro i l; rw [hG]; ring
  simp only [e1, Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.sum_mul]
  -- the sums over `u`, `z`, `v`
  have su2 : ∑ i, u i ^ 2 = 2 := by rw [← hU]; exact Finset.sum_congr rfl fun i _ => by ring
  have su : ∑ i, u i = 0 := by
    rw [hudef]; unfold uj
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j), if_pos rfl,
      ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hjk, Finset.mem_univ k⟩), if_neg (Ne.symm hjk), if_pos rfl,
      Finset.sum_eq_zero fun c hc => by
        rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]]
    ring
  have svu2 : ∑ i, v i * u i ^ 2 = v j + v k := by
    rw [hudef]; unfold uj
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j), if_pos rfl,
      ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hjk, Finset.mem_univ k⟩), if_neg (Ne.symm hjk), if_pos rfl,
      Finset.sum_eq_zero fun c hc => by
        rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]; ring]
    ring
  have svu : ∑ i, v i * u i = v j - v k := by
    rw [hudef]; unfold uj
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j), if_pos rfl,
      ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hjk, Finset.mem_univ k⟩), if_neg (Ne.symm hjk), if_pos rfl,
      Finset.sum_eq_zero fun c hc => by
        rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]; ring]
    ring
  have sz2 : ∑ i, z i ^ 2 = V := by rw [hV]; exact Finset.sum_congr rfl fun i _ => by ring
  have hvj2 : (v j - v k) ^ 2 = 4 / (n : ℝ) := by
    have hk : v k = -v j := by linarith
    rw [hk, show (v j - -v j) ^ 2 = 4 * v j ^ 2 by ring, hv2]; ring
  rw [su2, su, svu2, hvjk, sz2, hzs]
  have hsq : (∑ i, v i * u i) * (∑ i, v i * u i) = 4 / (n : ℝ) := by rw [svu, ← hvj2]; ring
  rw [hsq]
  have hz0 : ∀ x, u x ^ 2 * z x ^ 2 = 0 := fun x => by
    rw [show u x ^ 2 * z x ^ 2 = (u x * z x) ^ 2 by ring, huz x]; ring
  have f1 : ∑ x, v x ^ 2 * u x ^ 2 = 2 / (n : ℝ) := by
    simp only [hv2]; rw [← Finset.mul_sum, su2]; ring
  have f2 : ∑ x, u x ^ 2 * z x ^ 2 = 0 := Finset.sum_eq_zero fun x _ => hz0 x
  have f3 : ∑ x, z x ^ 2 * u x ^ 2 = 0 := Finset.sum_eq_zero fun x _ => by rw [mul_comm]; exact hz0 x
  have f4 : ∑ x, v x ^ 2 * u x ^ 2 * z x ^ 2 = 0 := Finset.sum_eq_zero fun x _ => by rw [mul_assoc, hz0 x, mul_zero]
  have f5 : ∑ x, v x ^ 2 * z x ^ 2 * u x ^ 2 = 0 :=
    Finset.sum_eq_zero fun x _ => by rw [mul_assoc, mul_comm (z x ^ 2), hz0 x, mul_zero]
  have f6 : ∑ x, v x ^ 2 * z x ^ 2 = V / (n : ℝ) := by
    simp only [hv2]; rw [← Finset.mul_sum, sz2]; ring
  ring_nf
  simp only [su2, f1, f2, f3, f4, f5, f6, sz2]
  ring

/-- **The pairing at a two-valued `v`**: whenever every `v_p` is `v_j` or `v_k`, `⟨t Z'(v), G_z⟩ = t⟨v, z⟩²` for `z` zero at
`j, k` with `Σ z = 0`. It covers L57's maximisers at both parities. -/
theorem inner_Zp_Gy_two (hjk : j ≠ k) (v : Fin n → ℝ) (h2 : ∀ p, (v p - v j) * (v p - v k) = 0) (t : ℝ)
    (z : Fin n → ℝ) (hzj : z j = 0) (hzk : z k = 0) (hzs : ∑ i, z i = 0) :
    innerOp2 (coordOp (Matrix.of fun a b => t * Zp v (n : ℝ) a b)) (coordOp (Gy j k z))
      = t * (∑ a, v a * z a) ^ 2 := by
  have hvz : vy j k z = z := HamiltonsCubic.PairIdent.vy_of_zero z hzj hzk
  set u := uj j k with hudef
  set N : ℝ := (n : ℝ) - 2 with hN
  set c0 : ℝ := 1 / (((n : ℝ) - 1) * ((n : ℝ) - 2)) with hc0
  set V : ℝ := ∑ c, z c * z c with hV
  have hU : ∑ c, u c * u c = 2 := uj_norm hjk
  have hZT : (Matrix.of fun a b => t * Zp v (n : ℝ) a b)ᵀ = Matrix.of fun a b => t * Zp v (n : ℝ) a b := by
    ext a b; simp only [Matrix.transpose_apply, Matrix.of_apply, Zp]
    by_cases h : a = b
    · subst h; simp
    · rw [if_neg h, if_neg (Ne.symm h)]; ring
  rw [innerOp2_coordOp _ _ hZT (Gy_sym j k z)]
  have hG : ∀ i l, Gy j k z i l = u i ^ 2 * z l ^ 2 + z i ^ 2 * u l ^ 2 + V * (u i * u l) + 2 * (z i * z l) := by
    intro i l
    simp only [Gy, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul, hvz]
    rw [← hudef, hU]; simp only [hV]; ring
  have huz : ∀ i, u i * z i = 0 := fun i => by rw [hudef, ← hvz]; exact uj_vy j k z i
  have hGd : ∀ i, Gy j k z i i = V * u i ^ 2 + 2 * z i ^ 2 := by
    intro i; rw [hG]
    have h0 : u i ^ 2 * z i ^ 2 = 0 := by rw [show u i ^ 2 * z i ^ 2 = (u i * z i) ^ 2 by ring, huz i]; ring
    linear_combination 2 * h0
  have hZ : ∀ i l, (if i = l then 0 else (Matrix.of fun a b => t * Zp v (n : ℝ) a b) i l * Gy j k z i l)
      = t * ((v i * v l + v i ^ 2 / N + v l ^ 2 / N - c0) * Gy j k z i l)
        - (if i = l then t * ((v i ^ 2 + 2 * (v i ^ 2 / N) - c0) * (V * u i ^ 2 + 2 * z i ^ 2)) else 0) := by
    intro i l
    by_cases h : i = l
    · subst h; rw [if_pos rfl, if_pos rfl, hGd]; ring
    · simp only [Matrix.of_apply, Zp, if_neg h, hN, hc0]; ring
  simp only [hZ, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have e1 : ∀ i l, (v i * v l + v i ^ 2 / N + v l ^ 2 / N - c0) * Gy j k z i l
      = (v i * u i ^ 2) * (v l * z l ^ 2) + (v i * z i ^ 2) * (v l * u l ^ 2) + V * ((v i * u i) * (v l * u l))
        + 2 * ((v i * z i) * (v l * z l))
        + (v i ^ 2 / N * u i ^ 2) * (z l ^ 2) + (v i ^ 2 / N * z i ^ 2) * (u l ^ 2) + V * ((v i ^ 2 / N * u i) * u l)
        + 2 * ((v i ^ 2 / N * z i) * z l)
        + (u i ^ 2) * (v l ^ 2 / N * z l ^ 2) + (z i ^ 2) * (v l ^ 2 / N * u l ^ 2) + V * (u i * (v l ^ 2 / N * u l))
        + 2 * (z i * (v l ^ 2 / N * z l))
        - c0 * ((u i ^ 2) * (z l ^ 2) + (z i ^ 2) * (u l ^ 2) + V * (u i * u l) + 2 * (z i * z l)) := by
    intro i l; rw [hG]; ring
  have e2 : ∀ i, t * ((v i ^ 2 + 2 * (v i ^ 2 / N) - c0) * (V * u i ^ 2 + 2 * z i ^ 2))
      = t * (V * (v i ^ 2 * u i ^ 2) + 2 * (v i ^ 2 * z i ^ 2) + 2 * V * (v i ^ 2 / N * u i ^ 2)
        + 4 * (v i ^ 2 / N * z i ^ 2) - c0 * V * u i ^ 2 - 2 * c0 * z i ^ 2) := fun i => by ring
  simp only [e1, e2, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.sum_mul]
  -- the sums over `u` and `z`
  have su2 : ∑ i, u i ^ 2 = 2 := by rw [← hU]; exact Finset.sum_congr rfl fun i _ => by ring
  have jk_sum : ∀ f : Fin n → ℝ, ∑ i, f i * u i ^ 2 = f j + f k := by
    intro f
    rw [hudef]; unfold uj
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j), if_pos rfl,
      ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hjk, Finset.mem_univ k⟩), if_neg (Ne.symm hjk), if_pos rfl,
      Finset.sum_eq_zero fun c hc => by
        rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]; ring]
    ring
  have jk_sum1 : ∀ f : Fin n → ℝ, ∑ i, f i * u i = f j - f k := by
    intro f
    rw [hudef]; unfold uj
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ j), if_pos rfl,
      ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hjk, Finset.mem_univ k⟩), if_neg (Ne.symm hjk), if_pos rfl,
      Finset.sum_eq_zero fun c hc => by
        rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)), if_neg (Finset.ne_of_mem_erase hc)]; ring]
    ring
  have su : ∑ i, u i = 0 := by
    have := jk_sum1 (fun _ => 1); simp only [one_mul, sub_self] at this; exact this
  have sz2 : ∑ i, z i ^ 2 = V := by rw [hV]; exact Finset.sum_congr rfl fun i _ => by ring
  have svu2 := jk_sum v
  have svu := jk_sum1 v
  have sv2u2 := jk_sum (fun i => v i ^ 2)
  have sfu := jk_sum1 (fun i => v i ^ 2 / N)
  have h2v : (v j + v k) * ∑ i, v i * z i ^ 2 - ∑ i, v i ^ 2 * z i ^ 2 = v j * v k * V := by
    rw [Finset.mul_sum, ← Finset.sum_sub_distrib, ← sz2, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    have := h2 i
    linear_combination (-(z i ^ 2)) * this
  simp only [su2, su, sz2, svu2, svu, sv2u2, sfu, hzs] at *
  linear_combination t * h2v

end HamiltonsCubic.L224Rank
