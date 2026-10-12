import Mathlib
import HamiltonsCubic.Results.FourStep5
import HamiltonsCubic.Results.L224Norm
import HamiltonsCubic.Results.L220Statement

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220 steps 6 and 7 on the operators, and the norm split

[findings/second-order.md](../../../findings/second-order.md), Lemma L220:
*6. Pair the $\mathcal D_n$ equation with $q$ … so $P(q)+\kappa+\tfrac\theta2\lVert\nu\rVert^2=\tfrac{\theta^3}3$.*
*7. $P$ on $\Pi_Q$. $P(q)=\ldots=2(x^3+y^3+z^3)+12xyz=18xyz$ … so $P(q)\le\tfrac{\sqrt3}2\lVert q\rVert^3=\tfrac{\theta^3}6$.*
Step 9's norm split $\lVert W\rVert^2=\lVert q\rVert^2+\lVert r\rVert^2+\lVert\nu\rVert^2$ is here too, feeding
[L220Statement.lean](L220Statement.lean)'s `theta_sq_le` its hypotheses `hunit`, `hpair` and `hp`.

* `P_PiQ`: $P(\Pi_Q(x,y,z))=2(x^3+y^3+z^3)+12xyz$, which is $18xyz$ at $x+y+z=0$;
* **`step7`**: at $x+y+z=0$, $\theta\ge0$ and $3\lVert q\rVert^2=\theta^2$, $6P(q)\le\theta^3$;
* **`step6`**: $P(q)+\kappa+\tfrac\theta2\lVert\nu\rVert^2=\theta\lVert q\rVert^2$ with $\kappa=\langle r\circ r,q\rangle$;
* `inner_char_four`, **`norm_split`**: characters $1$ and $\chi_Q$ are orthogonal, and
  $\lVert q+r+\nu\rVert^2=\lVert q\rVert^2+\lVert r\rVert^2+\lVert\nu\rVert^2$.
-/

namespace HamiltonsCubic.FourStep67

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.FourStep5 HamiltonsCubic.FrameOp2
  HamiltonsCubic.FrameLayer HamiltonsCubic.L224Norm HamiltonsCubic.L224Cubic

variable {n : ℕ} {i j k l : Fin n}

/-- **Characters `1` and `χ_Q` are orthogonal**, through the flip at `i`, which `χ_Q` sends to `-1` whatever `j, k, l`
are (r1838 O1). -/
theorem inner_char_four {A B : CurvOp2 (Fin n)} (hAW : IsWeyl2 A)
    (hBW : IsWeyl2 B) (hA : SignChar (fun _ => 1) A) (hB : SignChar (setChar {i, j, k, l}) B) : innerOp2 A B = 0 := by
  set ε : Fin n → ℝ := fun p => if p = i then -1 else 1 with hεdef
  have hε : ∀ p, ε p * ε p = 1 := fun p => by by_cases h : p = i <;> simp [hεdef, h]
  have hU : IsOrth (signMat ε) := ⟨(signMat_orth ε hε).1, (signMat_orth ε hε).2⟩
  have hA' : rotR (signMat ε) A = A := by rw [rotR_of_hasChar (hA ε hε), one_smul]
  have hB' : rotR (signMat ε) B = (-1 : ℝ) • B := by
    rw [rotR_of_hasChar (hB ε hε)]
    congr 1
    have hi : i ∈ ({i, j, k, l} : Finset (Fin n)) := by simp
    unfold setChar
    rw [← Finset.mul_prod_erase _ _ hi, Finset.prod_eq_one fun a ha => by simp [hεdef, Finset.ne_of_mem_erase ha]]
    simp [hεdef]
  exact inner_flip_zero hU hAW hBW hA' hB'

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **`P` on `Π_Q`.** -/
theorem P_PiQ (x y z : ℝ) :
    Pcubic2 (coordOp (PiQ i j k l x y z)) = 2 * (x ^ 3 + y ^ 3 + z ^ 3) + 12 * (x * y * z) := by
  rw [Pcubic2_eq_innerOp2, ← foxProd2_self, PiQ_mul hij hik hil hjk hjl hkl,
    inner_PiQ hij hik hil hjk hjl hkl x y z _ (PiQ_T hij hik hil hjk hjl hkl _ _ _)]
  simp [PiQ, E2, Matrix.vecMulVec_apply, Pi.single_apply, hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik,
    Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl]
  ring

theorem P_PiQ_zero {x y z : ℝ} (hs : x + y + z = 0) :
    Pcubic2 (coordOp (PiQ i j k l x y z)) = 18 * (x * y * z) := by
  rw [P_PiQ hij hik hil hjk hjl hkl]
  have hz : z = -x - y := by linarith
  subst hz; ring

/-- **L220 (7)**: `6 P(q) ≤ θ³` at `x + y + z = 0`, `θ ≥ 0`, `3‖q‖² = θ²`. -/
theorem step7 {x y z θ : ℝ} (hs : x + y + z = 0) (hθ : 0 ≤ θ)
    (ha : 3 * normSq2 (coordOp (PiQ i j k l x y z)) = θ ^ 2) :
    6 * Pcubic2 (coordOp (PiQ i j k l x y z)) ≤ θ ^ 3 := by
  rw [P_PiQ_zero hij hik hil hjk hjl hkl hs]
  rw [normSq2_PiQ hij hik hil hjk hjl hkl] at ha
  have hc := HamiltonsCubic.L220Statement.pattern_cubic_sq_le x y z hs
  have ha' : 2 * (x ^ 2 + y ^ 2 + z ^ 2) = θ ^ 2 / 3 := by linarith
  rw [ha'] at hc
  have h2 : (6 * (18 * (x * y * z))) ^ 2 ≤ (θ ^ 3) ^ 2 := by nlinarith [hc]
  have hθ3 : 0 ≤ θ ^ 3 := pow_nonneg hθ 3
  by_contra hcon
  push Not at hcon
  nlinarith [hcon, hθ3, h2]

/-- **L220 (6)**: pairing `D ∘ D + ν ∘ ν = θD` with `q`, `D = q + r`, gives `P(q) + κ + ½θ‖ν‖² = θ‖q‖²`,
`κ = ⟨r ∘ r, q⟩`. -/
theorem step6 {x y z θ : ℝ} (hs : x + y + z = 0) {r ν : CurvOp2 (Fin n)} (hrW : IsWeyl2 r)
    (hperp : ∀ a b c : ℝ, a + b + c = 0 → innerOp2 r (coordOp (PiQ i j k l a b c)) = 0)
    (hνW : IsWeyl2 ν)
    (hsplit : foxProd2 (coordOp (PiQ i j k l x y z) + r) (coordOp (PiQ i j k l x y z) + r) + foxProd2 ν ν
      = θ • (coordOp (PiQ i j k l x y z) + r))
    (heig : (2 : ℝ) • foxProd2 (coordOp (PiQ i j k l x y z)) ν = θ • ν) :
    Pcubic2 (coordOp (PiQ i j k l x y z)) + innerOp2 (foxProd2 r r) (coordOp (PiQ i j k l x y z))
      + θ / 2 * normSq2 ν = θ * normSq2 (coordOp (PiQ i j k l x y z)) := by
  set q := coordOp (PiQ i j k l x y z) with hqdef
  have hqW : IsWeyl2 q := by
    rw [hqdef, coordOp_eq_restrict (PiQ_weight hij hik hil hjk hjl hkl hs)]; exact isWeyl2_restrict _
  have hqs := hqW.isSelfAdjoint2
  have hrs := hrW.isSelfAdjoint2
  have hνs := hνW.isSelfAdjoint2
  -- `⟨q ∘ r, q⟩ = ⟨r, q ∘ q⟩ = 0`
  have hqq : foxProd2 q q = coordOp (PiQ i j k l (x * x + y * z + z * y) (y * y + z * x + x * z) (z * z + x * y + y * x)) :=
    PiQ_mul hij hik hil hjk hjl hkl x y z x y z
  have hqrq : innerOp2 (foxProd2 q r) q = 0 := by
    rw [foxProd2_comm, inner_fox_move hrs hqs hqs, hqq]
    exact hperp _ _ _ (PiQ_closed hs hs)
  -- `⟨ν ∘ ν, q⟩ = ⟨q ∘ ν, ν⟩ = ½θ‖ν‖²`
  have hνν : innerOp2 (foxProd2 ν ν) q = θ / 2 * normSq2 ν := by
    rw [innerOp2_comm, ← inner_fox_move hqs hνs hνs]
    have : foxProd2 q ν = (θ / 2) • ν := by
      have h2 := congrArg (fun T => (1 / 2 : ℝ) • T) heig
      simp only [smul_smul] at h2
      rw [show (1 / 2 : ℝ) * 2 = 1 by norm_num, one_smul, show 1 / 2 * θ = θ / 2 by ring] at h2
      exact h2
    rw [this, innerOp2_smul_left]; rfl
  have hrq : innerOp2 r q = 0 := hperp x y z hs
  have hP : Pcubic2 q = innerOp2 (foxProd2 q q) q := by
    rw [Pcubic2_eq_innerOp2, ← foxProd2_self, innerOp2_comm]
  have hpair := congrArg (fun T => innerOp2 T q) hsplit
  rw [innerOp2_add_left, innerOp2_smul_left, innerOp2_add_left, hrq] at hpair
  have hDD : foxProd2 (q + r) (q + r) = foxProd2 q q + (2 : ℝ) • foxProd2 q r + foxProd2 r r := by
    rw [foxProd2_self, L219Prod.Qop2_add, foxProd2_self, foxProd2_self]; abel
  rw [hDD, innerOp2_add_left, innerOp2_add_left, innerOp2_smul_left, hqrq, hνν, ← hP] at hpair
  unfold normSq2 at hpair ⊢
  linarith

/-- **The norm split**: `‖q + r + ν‖² = ‖q‖² + ‖r‖² + ‖ν‖²`. -/
theorem norm_split {x y z : ℝ} (hs : x + y + z = 0) {r ν : CurvOp2 (Fin n)} (hrW : IsWeyl2 r)
    (hr : SignChar (fun _ => 1) r)
    (hperp : ∀ a b c : ℝ, a + b + c = 0 → innerOp2 r (coordOp (PiQ i j k l a b c)) = 0)
    (hνW : IsWeyl2 ν) (hν : SignChar (setChar {i, j, k, l}) ν) :
    normSq2 (coordOp (PiQ i j k l x y z) + r + ν)
      = normSq2 (coordOp (PiQ i j k l x y z)) + normSq2 r + normSq2 ν := by
  set q := coordOp (PiQ i j k l x y z) with hqdef
  have hqW : IsWeyl2 q := by
    rw [hqdef, coordOp_eq_restrict (PiQ_weight hij hik hil hjk hjl hkl hs)]; exact isWeyl2_restrict _
  have hq1 : SignChar (fun _ => 1) q := by
    have hw := PiQ_weight hij hik hil hjk hjl hkl hs
    rw [hqdef, coordOp_eq_restrict hw]
    exact (L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hw, rfl⟩
  have hqr : innerOp2 q r = 0 := by rw [innerOp2_comm]; exact hperp x y z hs
  have hqν : innerOp2 q ν = 0 := inner_char_four hqW hνW hq1 hν
  have hrν : innerOp2 r ν = 0 := inner_char_four hrW hνW hr hν
  unfold normSq2
  simp only [innerOp2_add_left, innerOp2_add_right]
  rw [innerOp2_comm r q, innerOp2_comm ν q, innerOp2_comm ν r, hqr, hqν, hrν]
  ring

end

end HamiltonsCubic.FourStep67
