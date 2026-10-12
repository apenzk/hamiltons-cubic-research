import Mathlib
import HamiltonsCubic.Results.FourStep4

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220 step 5: the eigenvalue fixes `‖q‖`, `θ² = 3‖q‖²`

[findings/second-order.md](../../../findings/second-order.md), Lemma L220, step 5: *By [L121] $L_q$ on $V_Q$ has eigenvalues
$\pm\tfrac12\sqrt E$ … so $E=3\lVert q\rVert^2$ … With $\theta>0$ and $\nu\ne0$, $\lVert q\rVert^2=\theta^2/3$.* Here the eigenvalue
equation $2q\circ\nu=\theta\nu$ is paired against the two sandwiches spanning $V_Q$, which gives a $2\times2$ system
$2Mc=\theta Gc$ with $c\ne0$, and $\det(2M-\theta G)=0$ is $\theta^2=3\lVert q\rVert^2$.

* `inner_PiQ`: $\langle\Pi_Q(x,y,z)\odot\cdot,\,b\odot\cdot\rangle=x(b_{ij}+b_{kl})+y(b_{ik}+b_{jl})+z(b_{il}+b_{jk})$ at symmetric $b$;
* `normSq2_PiQ`: $\lVert\Pi_Q(x,y,z)\odot\cdot\rVert^2=2(x^2+y^2+z^2)$;
* `norm_w4`, `norm_sig`, `inner_AB`: the Gram matrix of $(\sigma_A,\sigma_B)$ is $\begin{pmatrix}4&-2\\-2&4\end{pmatrix}$;
* `M_A`, `M_B`, `M_C`: $\langle q,\sigma\circ\sigma\rangle$ on the three pairings;
* **`step5`**: $2q\circ\nu=\theta\nu$ with $q=\Pi_Q(x,y,z)$, $x+y+z=0$, and $0\ne\nu\in V_Q$ give $\theta^2=3\lVert q\rVert^2$.
-/

namespace HamiltonsCubic.FourStep5

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.L224Rank HamiltonsCubic.PairNorm
  HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer

variable {n : ℕ} {i j k l : Fin n}

theorem W4_T {a b c d : Fin n} : (W4 a b c d)ᵀ = W4 a b c d := by
  ext p q; simp only [W4, Matrix.transpose_apply, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, smul_eq_mul]
  ring

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

omit hij hik hil hjk hjl hkl in
theorem double_single (p q : Fin n) (b : Matrix (Fin n) (Fin n) ℝ) :
    ∑ a, ∑ c, vecMulVec (Pi.single p (1 : ℝ)) (Pi.single q 1) a c * b a c = b p q := by
  simp [Matrix.vecMulVec_apply, Pi.single_apply, ite_mul, Finset.sum_ite_eq']

/-- **The pairing with an element of `Π_Q`.** -/
theorem inner_PiQ (x y z : ℝ) (b : Matrix (Fin n) (Fin n) ℝ) (hb : bᵀ = b) :
    innerOp2 (coordOp (PiQ i j k l x y z)) (coordOp b)
      = x * (b i j + b k l) + y * (b i k + b j l) + z * (b i l + b j k) := by
  have hs : ∀ p q, b p q = b q p := fun p q => by rw [← Matrix.transpose_apply b q p, hb]
  rw [innerOp2_coordOp _ _ (PiQ_T hij hik hil hjk hjl hkl x y z) hb]
  have e : ∀ a c, (if a = c then 0 else PiQ i j k l x y z a c * b a c) = PiQ i j k l x y z a c * b a c := by
    intro a c
    by_cases h : a = c
    · subst h; rw [if_pos rfl, PiQ_hollow hij hik hil hjk hjl hkl, zero_mul]
    · rw [if_neg h]
  simp only [e]
  simp only [PiQ, E2, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul, add_mul, mul_add, mul_assoc,
    Finset.sum_add_distrib, ← Finset.mul_sum, double_single]
  rw [hs j i, hs l k, hs k i, hs l j, hs l i, hs k j]
  ring

theorem normSq2_PiQ (x y z : ℝ) :
    normSq2 (coordOp (PiQ i j k l x y z)) = 2 * (x ^ 2 + y ^ 2 + z ^ 2) := by
  unfold normSq2
  rw [inner_PiQ hij hik hil hjk hjl hkl x y z _ (PiQ_T hij hik hil hjk hjl hkl x y z)]
  simp [PiQ, E2, Matrix.vecMulVec_apply, Pi.single_apply, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik,
    Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl]
  ring

/-- `⟨q, σ_A ∘ σ_A⟩ = 2x + 2z - 4y`. -/
theorem M_A (x y z : ℝ) :
    innerOp2 (coordOp (PiQ i j k l x y z)) (coordOp (W4 i k j l)) = 2 * x + 2 * z - 4 * y := by
  rw [inner_PiQ hij hik hil hjk hjl hkl x y z _ W4_T]
  simp [W4, ind2, uj, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, hij, hik, hil, hjk, hjl, hkl,
    Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl]
  ring

/-- `⟨q, σ_B ∘ σ_B⟩ = 2y + 2z - 4x`. -/
theorem M_B (x y z : ℝ) :
    innerOp2 (coordOp (PiQ i j k l x y z)) (coordOp (W4 i j k l)) = 2 * y + 2 * z - 4 * x := by
  rw [inner_PiQ hij hik hil hjk hjl hkl x y z _ W4_T]
  simp [W4, ind2, uj, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, hij, hik, hil, hjk, hjl, hkl,
    Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl]
  ring

/-- `⟨q, σ_C ∘ σ_C⟩ = 2x + 2y - 4z`. -/
theorem M_C (x y z : ℝ) :
    innerOp2 (coordOp (PiQ i j k l x y z)) (coordOp (W4 i l j k)) = 2 * x + 2 * y - 4 * z := by
  rw [inner_PiQ hij hik hil hjk hjl hkl x y z _ W4_T]
  simp [W4, ind2, uj, Matrix.add_apply, Matrix.smul_apply, Matrix.vecMulVec_apply, hij, hik, hil, hjk, hjl, hkl,
    Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl]
  ring

end

section
variable {a b c d : Fin n} (hab : a ≠ b) (hcd : c ≠ d) (hac : a ≠ c) (had : a ≠ d) (hbc : b ≠ c) (hbd : b ≠ d)
include hab hcd hac had hbc hbd

/-- `‖w ⊙ ·‖² = 4`. -/
theorem norm_w4 : normSq2 (coordOp (w4 a b c d)) = 4 := by
  rw [normSq2_coordOp _ (w4_T hab hcd hac had hbc hbd)]
  have e : ∀ p q, (if p = q then 0 else w4 a b c d p q ^ 2) = w4 a b c d p q ^ 2 := by
    intro p q
    by_cases h : p = q
    · subst h; rw [if_pos rfl, w4_hollow hab hcd hac had hbc hbd, sq, zero_mul]
    · rw [if_neg h]
  simp only [e]
  simp only [w4, Matrix.add_apply, Matrix.vecMulVec_apply]
  rw [sum_sq_rank_two _ _ (uj_dis hab hcd hac had hbc hbd)]
  have h1 : ∑ p, uj a b p ^ 2 = 2 := by rw [← uj_norm hab]; exact Finset.sum_congr rfl fun p _ => by ring
  have h2 : ∑ p, uj c d p ^ 2 = 2 := by rw [← uj_norm hcd]; exact Finset.sum_congr rfl fun p _ => by ring
  rw [h1, h2]; norm_num

/-- **`‖σ‖² = 4`**, the rotation being an isometry. -/
theorem norm_sig : normSq2 (sig4 a b c d) = 4 := by
  have hcs := c45_facts.2.2
  rw [sig_eq hab hcd hac had hbc hbd,
    normSq2_rotR (isOrth_transpose (Rot_orth hab hcs))
      (rotR_isWeyl2 (isOrth_transpose (Rot_orth hcd hcs)) (w4_weyl hab hcd hac had hbc hbd)),
    normSq2_rotR (isOrth_transpose (Rot_orth hcd hcs)) (w4_weyl hab hcd hac had hbc hbd), norm_w4 hab hcd hac had hbc hbd]

end

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **`⟨σ_A, σ_B⟩ = -2`**, by polarising `‖σ_A + σ_B‖² = ‖σ_C‖²`. -/
theorem inner_AB : innerOp2 (sig4 i k j l) (sig4 i j k l) = -2 := by
  have hA := norm_sig hik hjl hij hil (Ne.symm hjk) hkl
  have hB := norm_sig hij hkl hik hil hjk hjl
  have hC := norm_sig hil hjk hij hik (Ne.symm hjl) (Ne.symm hkl)
  have hsum := sig_sum hij hik hil hjk hjl hkl
  have hneg : normSq2 (-(sig4 i l j k)) = normSq2 (sig4 i l j k) := by
    unfold normSq2
    rw [show -(sig4 i l j k) = (-1 : ℝ) • sig4 i l j k by module, innerOp2_smul_left, innerOp2_smul_right]
    ring
  have e : normSq2 (sig4 i k j l + sig4 i j k l)
      = normSq2 (sig4 i k j l) + 2 * innerOp2 (sig4 i k j l) (sig4 i j k l) + normSq2 (sig4 i j k l) := by
    unfold normSq2
    rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, innerOp2_comm (sig4 i j k l) (sig4 i k j l)]
    ring
  rw [hsum, hneg, hC, hA, hB] at e
  linarith

/-- **L220 (5)**: `2 q ∘ ν = θν` with `q = Π_Q(x, y, z)`, `x + y + z = 0`, and `0 ≠ ν ∈ V_Q` give `θ² = 3‖q‖²`. -/
theorem step5 {x y z θ : ℝ} (hs : x + y + z = 0) {ν : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0)
    (h : (2 : ℝ) • foxProd2 (coordOp (PiQ i j k l x y z)) ν = θ • ν) :
    θ ^ 2 = 3 * normSq2 (coordOp (PiQ i j k l x y z)) := by
  obtain ⟨a, b, rfl⟩ := four_eq_sig hij hik hil hjk hjl hkl hνW hν
  set q := coordOp (PiQ i j k l x y z) with hqdef
  set sA := sig4 i k j l with hsA
  set sB := sig4 i j k l with hsB
  have hqW : IsWeyl2 q := by
    rw [hqdef, coordOp_eq_restrict (PiQ_weight hij hik hil hjk hjl hkl hs)]; exact isWeyl2_restrict _
  have hqs : IsSelfAdjoint2 q := hqW.isSelfAdjoint2
  have hAW : IsWeyl2 sA := sig_weyl hik hjl hij hil (Ne.symm hjk) hkl
  have hBW : IsWeyl2 sB := sig_weyl hij hkl hik hil hjk hjl
  have hνs : IsSelfAdjoint2 (a • sA + b • sB) := (isWeyl2_add (isWeyl2_smul _ hAW) (isWeyl2_smul _ hBW)).isSelfAdjoint2
  have hQA : Qop2 sA = coordOp (W4 i k j l) := Q_sig hik hjl hij hil (Ne.symm hjk) hkl
  have hQB : Qop2 sB = coordOp (W4 i j k l) := Q_sig hij hkl hik hil hjk hjl
  have hQC : Qop2 (sig4 i l j k) = coordOp (W4 i l j k) := Q_sig hil hjk hij hik (Ne.symm hjl) (Ne.symm hkl)
  -- `2 σ_A ∘ σ_B = Q_C - Q_A - Q_B`
  have hfox : (2 : ℝ) • foxProd2 sA sB = coordOp (W4 i l j k) - coordOp (W4 i k j l) - coordOp (W4 i j k l) := by
    have hAB : Qop2 (sA + sB) = coordOp (W4 i l j k) := by
      rw [hsA, hsB, sig_sum hij hik hil hjk hjl hkl,
        show -(sig4 i l j k) = (-1 : ℝ) • sig4 i l j k by module, Qop2_smul, hQC]
      norm_num
    have h2 := L219Prod.Qop2_add sA sB
    rw [hAB, hQA, hQB] at h2
    rw [h2]; abel
  have mA := M_A hij hik hil hjk hjl hkl x y z
  have mB := M_B hij hik hil hjk hjl hkl x y z
  have mC := M_C hij hik hil hjk hjl hkl x y z
  have mAB : innerOp2 q (foxProd2 sA sB) = ((2 * x + 2 * y - 4 * z) - (2 * x + 2 * z - 4 * y) - (2 * y + 2 * z - 4 * x)) / 2 := by
    have := congrArg (innerOp2 q) hfox
    rw [innerOp2_smul_right] at this
    have e2 : innerOp2 q (coordOp (W4 i l j k) - coordOp (W4 i k j l) - coordOp (W4 i j k l))
        = innerOp2 q (coordOp (W4 i l j k)) - innerOp2 q (coordOp (W4 i k j l)) - innerOp2 q (coordOp (W4 i j k l)) := by
      rw [innerOp2_comm, innerOp2_sub_left', innerOp2_sub_left', innerOp2_comm _ q, innerOp2_comm _ q, innerOp2_comm _ q]
    rw [e2, mA, mB, mC] at this
    linarith
  have gA := norm_sig hik hjl hij hil (Ne.symm hjk) hkl
  have gB := norm_sig hij hkl hik hil hjk hjl
  have gAB := inner_AB hij hik hil hjk hjl hkl
  -- pair the eigen-equation with `σ_A` and `σ_B`
  have pair : ∀ s : CurvOp2 (Fin n), IsWeyl2 s →
      2 * innerOp2 q (foxProd2 (a • sA + b • sB) s) = θ * (a * innerOp2 sA s + b * innerOp2 sB s) := by
    intro s hsW
    have := congrArg (fun T => innerOp2 T s) h
    rw [innerOp2_smul_left, innerOp2_smul_left, inner_fox_move hqs hνs hsW.isSelfAdjoint2, innerOp2_add_left,
      innerOp2_smul_left, innerOp2_smul_left] at this
    linarith
  have p1 := pair sA hAW
  have p2 := pair sB hBW
  rw [HamiltonsCubic.RealLayer.foxProd2_add_left, foxProd2_smul_left, foxProd2_smul_left, foxProd2_self,
    foxProd2_comm sB sA, innerOp2_add_right, innerOp2_smul_right, innerOp2_smul_right, hQA, mA, mAB] at p1
  rw [HamiltonsCubic.RealLayer.foxProd2_add_left, foxProd2_smul_left, foxProd2_smul_left, foxProd2_self,
    innerOp2_add_right, innerOp2_smul_right, innerOp2_smul_right, hQB, mB, mAB] at p2
  unfold normSq2 at gA gB
  rw [innerOp2_comm sB sA] at p1
  rw [gA, gAB] at p1
  rw [gAB, gB] at p2
  -- `(a, b) ≠ 0`
  have hab : a ≠ 0 ∨ b ≠ 0 := by
    by_contra hc
    push Not at hc
    apply hν0
    rw [hc.1, hc.2]; module
  have hz : z = -x - y := by linarith
  subst hz
  rw [normSq2_PiQ hij hik hil hjk hjl hkl]
  set A := 2 * (2 * x + 2 * (-x - y) - 4 * y) - 4 * θ with hA
  set B := 2 * (((2 * x + 2 * y - 4 * (-x - y)) - (2 * x + 2 * (-x - y) - 4 * y) - (2 * y + 2 * (-x - y) - 4 * x)) / 2) + 2 * θ with hB
  set D := 2 * (2 * y + 2 * (-x - y) - 4 * x) - 4 * θ with hD
  have e1 : A * a + B * b = 0 := by rw [hA, hB]; linear_combination p1
  have e2 : B * a + D * b = 0 := by rw [hB, hD]; linear_combination p2
  have hdet : A * D - B * B = 0 := by
    rcases hab with ha | hb
    · have : (A * D - B * B) * a = 0 := by linear_combination D * e1 - B * e2
      exact (mul_eq_zero.mp this).resolve_right ha
    · have : (A * D - B * B) * b = 0 := by linear_combination A * e2 - B * e1
      exact (mul_eq_zero.mp this).resolve_right hb
  rw [hA, hB, hD] at hdet
  linear_combination (1 / 12 : ℝ) * hdet

end

end HamiltonsCubic.FourStep5
