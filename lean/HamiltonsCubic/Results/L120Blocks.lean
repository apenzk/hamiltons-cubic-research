import Mathlib
import HamiltonsCubic.Results.L120Hess
import HamiltonsCubic.Results.L123Avg

set_option linter.style.longLine false

/-!
# L120, "checkable block by block": the Hessian carries no cross terms between sign characters

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: at a diagonal critical point the Hessian of
$P$ on the sphere is block-diagonal over the sign characters, so second-order optimality is **checkable block by
block**. [L120Hess.lean](L120Hess.lean)'s `hessOp_char` proves that the Hessian keeps each sign character. This file
proves the sentence that follows from it:

* `char_orth`: two operators on $\Lambda^2$ whose sign characters take opposite values at one sign vector are
  orthogonal, since conjugating by that sign matrix preserves `innerOp2` and multiplies the pairing by $-1$;
* `hess_blockwise`: at a $\Gamma$-fixed unit critical Weyl $a$ with $P(a)\ne0$, the Hessian quadratic form of a sum
  of tangent vectors with pairwise separated characters is the sum of the forms of the summands;
* `hess_nonpos_blockwise`: so the form is nonpositive on the sum once it is nonpositive on every summand;
* `setChar_sep`: the characters $\varepsilon\mapsto\prod_{i\in t}\varepsilon_i$ of distinct index sets are separated,
  which covers the trivial block ($t=\varnothing$), the pair blocks ($t=\{j,k\}$) and the four-set blocks.
-/

namespace HamiltonsCubic.L120Blocks

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- A sign conjugation preserves `inner2`. -/
theorem inner2_signConj (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) (X Y : Matrix ι ι ℝ) :
    inner2 (signMat ε * X * (signMat ε)ᵀ) (signMat ε * Y * (signMat ε)ᵀ) = inner2 X Y := by
  simp only [inner2_eq_sum, signMat, Matrix.diagonal_transpose, Matrix.diagonal_mul, Matrix.mul_diagonal]
  congr 1
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  calc ε a * X a b * ε b * (ε a * Y a b * ε b) = (ε a * ε a) * (ε b * ε b) * (X a b * Y a b) := by ring
    _ = X a b * Y a b := by rw [hε a, hε b]; ring

theorem sq_sign (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) (i j : ι) : (ε i * ε j) * (ε i * ε j) = 1 := by
  calc (ε i * ε j) * (ε i * ε j) = (ε i * ε i) * (ε j * ε j) := by ring
    _ = 1 := by rw [hε i, hε j]; ring

/-- **A character read at `φ_ij`**: `S (A φ_ij) Sᵀ = c ε_i ε_j · A φ_ij`. -/
theorem char_phi {c : ℝ} {ε : ι → ℝ} (hε : ∀ i, ε i * ε i = 1) {A : CurvOp2 ι}
    (h : HasChar c (signMat ε) A) (i j : ι) :
    signMat ε * applyPhi A i j * (signMat ε)ᵀ = (c * (ε i * ε j)) • applyPhi A i j := by
  have h1 := h (phi i j) (phi_isSkew i j)
  rw [signConj_phi] at h1
  have hlin : extend A ((ε i * ε j) • phi i j) = (ε i * ε j) • extend A (phi i j) :=
    (isLinOp_extend A).2 _ _
  have hΦ : extend A (phi i j) = applyPhi A i j := extend_apply A ⟨phi i j, phi_mem_skewSub i j⟩
  rw [hlin, hΦ, Matrix.mul_smul, Matrix.smul_mul] at h1
  calc signMat ε * applyPhi A i j * (signMat ε)ᵀ
      = ((ε i * ε j) * (ε i * ε j)) • (signMat ε * applyPhi A i j * (signMat ε)ᵀ) := by
        rw [sq_sign ε hε, one_smul]
    _ = (ε i * ε j) • ((ε i * ε j) • (signMat ε * applyPhi A i j * (signMat ε)ᵀ)) := by rw [smul_smul]
    _ = (ε i * ε j) • (c • applyPhi A i j) := by rw [h1]
    _ = (c * (ε i * ε j)) • applyPhi A i j := by rw [smul_smul, mul_comm]

/-- **Distinct sign characters are orthogonal**: if `c ε · c' ε = −1` at one sign vector, every `c`-isotypic
operator is orthogonal to every `c'`-isotypic one. -/
theorem char_orth {c c' : (ι → ℝ) → ℝ} {A B : CurvOp2 ι} (hA : SignChar c A) (hB : SignChar c' B)
    {ε : ι → ℝ} (hε : ∀ i, ε i * ε i = 1) (hcc : c ε * c' ε = -1) : innerOp2 A B = 0 := by
  have hz : ∀ i j, inner2 (applyPhi A i j) (applyPhi B i j) = 0 := by
    intro i j
    have e := inner2_signConj ε hε (applyPhi A i j) (applyPhi B i j)
    rw [char_phi hε (hA ε hε) i j, char_phi hε (hB ε hε) i j, FamilyLayer.inner2_smul_left,
      FamilyLayer.inner2_smul_right] at e
    have hk : c ε * (ε i * ε j) * (c' ε * (ε i * ε j)) = -1 := by
      calc c ε * (ε i * ε j) * (c' ε * (ε i * ε j)) = (c ε * c' ε) * ((ε i * ε j) * (ε i * ε j)) := by ring
        _ = -1 := by rw [hcc, sq_sign ε hε]; ring
    linear_combination (-(1 / 2) : ℝ) * e + (inner2 (applyPhi A i j) (applyPhi B i j) / 2) * hk
  unfold innerOp2
  simp [hz]

/-- **L120, checkable block by block.** At a `Γ`-fixed unit critical Weyl `a` with `P(a) ≠ 0`, the Hessian quadratic
form of a sum of tangent vectors whose sign characters are pairwise separated is the sum of their forms. -/
theorem hess_blockwise {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (hfix : SignChar (fun _ => 1) a)
    {κ : Type*} (s : Finset κ) (v : κ → weylPerpR a) (c : κ → (ι → ℝ) → ℝ)
    (hv : ∀ k ∈ s, SignChar (c k) (tanV (v k)))
    (hsep : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → ∃ ε : ι → ℝ, (∀ i, ε i * ε i = 1) ∧ c k ε * c l ε = -1) :
    hessQ a (tanV (∑ k ∈ s, v k)) = ∑ k ∈ s, hessQ a (tanV (v k)) := by
  have hin : ∀ x y : weylPerpR a, innerOp2 (tanV x) (tanV y) = inner ℝ x y := fun _ _ => rfl
  rw [hessQ_op ha hWa hcrit hθ]
  simp_rw [hessQ_op ha hWa hcrit hθ, hin, map_sum, sum_inner, inner_sum]
  refine Finset.sum_congr rfl fun k hk => ?_
  rw [Finset.sum_eq_single k]
  · intro l hl hlk
    obtain ⟨ε, hε, hcc⟩ := hsep k hk l hl (Ne.symm hlk)
    rw [← hin]
    exact char_orth (hessOp_char ha hWa hcrit hθ hfix (v k) (hv k hk)) (hv l hl) hε hcc
  · intro h
    exact absurd hk h

/-- **So nonpositivity is checked block by block.** -/
theorem hess_nonpos_blockwise {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (hfix : SignChar (fun _ => 1) a)
    {κ : Type*} (s : Finset κ) (v : κ → weylPerpR a) (c : κ → (ι → ℝ) → ℝ)
    (hv : ∀ k ∈ s, SignChar (c k) (tanV (v k)))
    (hsep : ∀ k ∈ s, ∀ l ∈ s, k ≠ l → ∃ ε : ι → ℝ, (∀ i, ε i * ε i = 1) ∧ c k ε * c l ε = -1)
    (hneg : ∀ k ∈ s, hessQ a (tanV (v k)) ≤ 0) :
    hessQ a (tanV (∑ k ∈ s, v k)) ≤ 0 := by
  rw [hess_blockwise ha hWa hcrit hθ hfix s v c hv hsep]
  exact Finset.sum_nonpos hneg

/-- The sign character of an index set, `ε ↦ ∏_{i ∈ t} ε_i`. -/
def setChar (t : Finset ι) (ε : ι → ℝ) : ℝ := ∏ i ∈ t, ε i

theorem setChar_pair {j k : ι} (h : j ≠ k) (ε : ι → ℝ) : setChar {j, k} ε = ε j * ε k := by
  unfold setChar
  rw [Finset.prod_pair h]

/-- **Distinct index sets have separated characters**: flipping one coordinate of their symmetric difference. -/
theorem setChar_sep {t u : Finset ι} (h : t ≠ u) :
    ∃ ε : ι → ℝ, (∀ i, ε i * ε i = 1) ∧ setChar t ε * setChar u ε = -1 := by
  obtain ⟨x, hx⟩ : ∃ x, x ∈ symmDiff t u := by
    by_contra hne
    push_neg at hne
    apply h
    ext y
    have := hne y
    rw [Finset.mem_symmDiff] at this
    tauto
  refine ⟨fun i => if i = x then -1 else 1, fun i => by beta_reduce; split_ifs <;> norm_num, ?_⟩
  have hp : ∀ w : Finset ι, setChar w (fun i => if i = x then -1 else 1) = if x ∈ w then -1 else 1 := by
    intro w
    simp only [setChar, Finset.prod_ite_eq']
  rw [hp, hp]
  rcases Finset.mem_symmDiff.mp hx with ⟨h1, h2⟩ | ⟨h1, h2⟩ <;> simp [h1, h2]

end HamiltonsCubic.L120Blocks
