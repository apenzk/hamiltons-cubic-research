import Mathlib
import HamiltonsCubic.Results.L120Hess
import HamiltonsCubic.Results.L120Cut
import HamiltonsCubic.Results.WeylTraceZero

set_option linter.style.longLine false

/-!
# L120: the Hessian at a diagonal critical point keeps the pair and four-set summands' characters

[L120Cut.lean](L120Cut.lean) puts the pair summand into `W^⊥` (`pair_mem_weylPerp`), with its
character stated one coordinate flip at a time on `CurvLin`; [L120Hess.lean](L120Hess.lean)'s
`hessOp_char` takes the character as `SignChar`, over every sign vector at once. This file joins
them ([r1693](../../../reviews/REVIEW_r1693.md) O4):

* `act_diag_set`: flip characters `χ` multiply, `act (diag_s) B = (∏_{i∈s} χ i) • B`, where `diag_s`
  flips the coordinates in `s`;
* `signMat_eq_diag_set`: every sign matrix is such a `diag_s`, `s = {i : εᵢ = -1}`;
* `pair_act_signMat`: a pair-summand operator with flip character `sgn m j · sgn m k` has character
  `ε_j ε_k` under every sign matrix;
* `four_act_signMat`, `hessOp_four`: the same for the four-set summand, character `ε_i ε_j ε_k ε_l`;
* `hessOp_pair`: **at a unit critical diagonal Weyl operator with `P ≠ 0`, the Hessian maps each
  pair-summand operator of `W^⊥` to an operator with the same character `ε_j ε_k`**.
-/

namespace HamiltonsCubic.L120HessPair

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results
  HamiltonsCubic.FamilyLayer HamiltonsCubic.L120Hess

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The diagonal sign matrix flipping exactly the coordinates in `s`. -/
def diagSet (s : Finset ι) : Matrix ι ι ℝ := Matrix.diagonal fun i => if i ∈ s then -1 else 1

theorem act_smul' (g : Matrix ι ι ℝ) (c : ℝ) (R : CurvLin ι) : act g (c • R) = c • act g R := by
  apply LinearMap.ext; intro Z
  simp only [act_apply, LinearMap.smul_apply, Matrix.mul_smul, Matrix.smul_mul]

theorem act_one (R : CurvLin ι) : act 1 R = R := by
  apply LinearMap.ext; intro Z
  simp [act_apply]

/-- **Flip characters multiply** over a set of coordinates. -/
theorem act_diag_set (B : CurvLin ι) (χ : ι → ℝ) (h : ∀ m, act (Results.flip m) B = χ m • B)
    (s : Finset ι) : act (diagSet s) B = (∏ i ∈ s, χ i) • B := by
  induction s using Finset.induction_on with
  | empty =>
      have : diagSet (∅ : Finset ι) = 1 := by
        unfold diagSet; simp [Matrix.diagonal_one]
      rw [this, act_one, Finset.prod_empty, one_smul]
  | insert a s ha ih =>
      have hd : diagSet (insert a s) = Results.flip a * diagSet s := by
        unfold diagSet Results.flip
        rw [Matrix.diagonal_mul_diagonal]
        congr 1
        funext i
        by_cases hi : i = a
        · subst hi; simp [ha]
        · simp [hi]
      rw [hd, ← act_comp, ih, act_smul', h, smul_smul, Finset.prod_insert ha, mul_comm]

/-- **Every sign matrix flips a set**: `diag(ε) = diag_s` with `s = {i : εᵢ = -1}`. -/
theorem signMat_eq_diag_set (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    signMat ε = diagSet (Finset.univ.filter fun i => ε i = -1) := by
  unfold signMat diagSet
  congr 1
  funext i
  by_cases h : ε i = -1
  · simp [h]
  · have h1 : ε i = 1 := by
      have := hε i
      have : (ε i - 1) * (ε i + 1) = 0 := by ring_nf; linarith
      rcases mul_eq_zero.mp this with h' | h'
      · linarith
      · exact absurd (by linarith : ε i = -1) h
    simp [h1]

omit [Fintype ι] in
theorem prod_sgn (s : Finset ι) (j : ι) : ∏ i ∈ s, Results.sgn i j = if j ∈ s then -1 else 1 := by
  unfold Results.sgn
  exact Finset.prod_ite_eq s j (fun _ => (-1 : ℝ))

/-- **The pair summand's character over every sign matrix** is `ε_j ε_k`. -/
theorem pair_act_signMat (B : CurvLin ι) {j k : ι}
    (hiso : ∀ m, act (Results.flip m) B = (Results.sgn m j * Results.sgn m k) • B) (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    act (signMat ε) B = (ε j * ε k) • B := by
  rw [signMat_eq_diag_set ε hε, act_diag_set B _ hiso, Finset.prod_mul_distrib, prod_sgn, prod_sgn]
  congr 1
  have hv : ∀ i, (if i ∈ Finset.univ.filter (fun i => ε i = -1) then (-1 : ℝ) else 1) = ε i := by
    intro i
    by_cases h : ε i = -1
    · simp [h]
    · have := hε i
      have : (ε i - 1) * (ε i + 1) = 0 := by ring_nf; linarith
      rcases mul_eq_zero.mp this with h' | h'
      · simp [h]; linarith
      · exact absurd (by linarith : ε i = -1) h
  rw [hv j, hv k]

/-- The sign read off the flip set is the sign itself. -/
theorem sign_of_set (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) (i : ι) :
    (if i ∈ Finset.univ.filter (fun i => ε i = -1) then (-1 : ℝ) else 1) = ε i := by
  by_cases h : ε i = -1
  · simp [h]
  · have := hε i
    have : (ε i - 1) * (ε i + 1) = 0 := by ring_nf; linarith
    rcases mul_eq_zero.mp this with h' | h'
    · simp [h]; linarith
    · exact absurd (by linarith : ε i = -1) h

/-- **The four-set summand's character over every sign matrix** is `ε_i ε_j ε_k ε_l`. -/
theorem four_act_signMat (B : CurvLin ι) {i j k l : ι}
    (hiso : ∀ m, act (Results.flip m) B =
      (Results.sgn m i * Results.sgn m j * Results.sgn m k * Results.sgn m l) • B)
    (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    act (signMat ε) B = (ε i * ε j * ε k * ε l) • B := by
  rw [signMat_eq_diag_set ε hε, act_diag_set B _ hiso, Finset.prod_mul_distrib,
    Finset.prod_mul_distrib, Finset.prod_mul_distrib, prod_sgn, prod_sgn, prod_sgn, prod_sgn,
    sign_of_set ε hε, sign_of_set ε hε, sign_of_set ε hε, sign_of_set ε hε]

variable {n : ℕ}

/-- **L120's Hessian clause on the pair summand.** At a unit critical diagonal Weyl operator
`a = restrict (diagOp w)` with `P(a) ≠ 0`, the Hessian maps every pair-summand operator of `W^⊥`
(character `ε_j ε_k`) to an operator with the same character. -/
theorem hessOp_pair {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) {lam : ℝ}
    (ha : normSq2 (restrict (diagOp_isWeyl hwt)) = 1)
    (hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = lam • restrict (diagOp_isWeyl hwt))
    (hθ : Pcubic2 (restrict (diagOp_isWeyl hwt)) ≠ 0)
    (B : CurvLin (Fin n)) (hB : B ∈ weylModuleS (Fin n)) {j k : Fin n} (hjk : j ≠ k)
    (hiso : ∀ m, act (Results.flip m) B = (Results.sgn m j * Results.sgn m k) • B) :
    SignChar (fun ε => ε j * ε k)
      (tanV (hessOp ha (isWeyl2_restrict (diagOp_isWeyl hwt)) hcrit hθ
        ⟨restrict (hB.1 : IsWeyl (fun X => B X)), pair_mem_weylPerp hwt B hB hjk hiso⟩)) := by
  apply hessOp_char
  · exact signChar_diag (diagOp_isWeyl hwt)
  · intro ε hε
    refine hasChar_restrict (hB.1 : IsWeyl (fun X => B X)) fun Z _ => ?_
    have := congrArg (fun L : CurvLin (Fin n) => L Z) (pair_act_signMat B hiso ε hε)
    simpa only [act_apply, LinearMap.smul_apply] using this

/-- **L120's Hessian clause on the four-set summand.** At a unit critical diagonal Weyl operator
with `P ≠ 0`, the Hessian maps every four-set-summand operator of `W^⊥` (character
`ε_i ε_j ε_k ε_l`) to an operator with the same character. -/
theorem hessOp_four {w : Matrix (Fin n) (Fin n) ℝ} (hwt : IsWeight w) {lam : ℝ}
    (ha : normSq2 (restrict (diagOp_isWeyl hwt)) = 1)
    (hcrit : Qop2 (restrict (diagOp_isWeyl hwt)) = lam • restrict (diagOp_isWeyl hwt))
    (hθ : Pcubic2 (restrict (diagOp_isWeyl hwt)) ≠ 0)
    (B : CurvLin (Fin n)) (hB : B ∈ weylModuleS (Fin n)) {i j k l : Fin n} (hij : i ≠ j)
    (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
    (hiso : ∀ m, act (Results.flip m) B =
      (Results.sgn m i * Results.sgn m j * Results.sgn m k * Results.sgn m l) • B) :
    SignChar (fun ε => ε i * ε j * ε k * ε l)
      (tanV (hessOp ha (isWeyl2_restrict (diagOp_isWeyl hwt)) hcrit hθ
        ⟨restrict (hB.1 : IsWeyl (fun X => B X)),
          four_mem_weylPerp hwt B hB hij hik hil hjk hjl hkl hiso⟩)) := by
  apply hessOp_char
  · exact signChar_diag (diagOp_isWeyl hwt)
  · intro ε hε
    refine hasChar_restrict (hB.1 : IsWeyl (fun X => B X)) fun Z _ => ?_
    have := congrArg (fun L : CurvLin (Fin n) => L Z) (four_act_signMat B hiso ε hε)
    simpa only [act_apply, LinearMap.smul_apply] using this

end HamiltonsCubic.L120HessPair
