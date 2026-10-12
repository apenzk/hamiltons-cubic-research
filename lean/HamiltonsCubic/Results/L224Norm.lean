import Mathlib
import HamiltonsCubic.Results.L224Pair
import HamiltonsCubic.Results.PairNorm

set_option linter.style.longLine false

/-!
# L224 step 1's norm identity: `‖D + ν‖² = ‖E‖² + 2(‖y‖² + ‖x‖²)`

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, step 1: *$D^-_y$ … with $\lVert D^-_y\rVert^2=2\lVert y\rVert^2$.
Every element of $V_{jk}$ is $\nu_x$ … with $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$ … So $W=E+D^-_y+\nu_x$ and
$\lVert W\rVert^2=\lVert E\rVert^2+2s$ with $s=\lVert y\rVert^2+\lVert x\rVert^2$.* The three summands are pairwise orthogonal: $E$ and
$D^-_y$ by the swap, which fixes one and negates the other, and both against $\nu_x$ by the flip at $j$, which fixes the
character-$1$ operators and negates the character-$\varepsilon_j\varepsilon_k$ ones.

* `inner_flip_zero`: an orthogonal frame change fixing $A$ and negating $B$ makes $\langle A,B\rangle=0$;
* `inner_char_pair`: $\langle A,B\rangle=0$ for Weyl $A$ of character $1$ and $B$ of character $\varepsilon_j\varepsilon_k$;
* **`L224_norm`**: $\lVert D+\nu\rVert^2=\lVert E\rVert^2+2(\lVert y\rVert^2+\lVert x\rVert^2)$, with $y,x$ those of `L224_cubic_G`.
-/

namespace HamiltonsCubic.L224Norm

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.I117S HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent HamiltonsCubic.L222Swap
  HamiltonsCubic.OddPart HamiltonsCubic.L224Cubic HamiltonsCubic.FrameOp2 HamiltonsCubic.L222Op HamiltonsCubic.L120Blocks
  HamiltonsCubic.PairNorm HamiltonsCubic.L224Pair HamiltonsCubic.FrameLayer

variable {n : ℕ} {j k : Fin n}

/-- **An orthogonal frame change that fixes `A` and negates `B` makes them orthogonal.** -/
theorem inner_flip_zero {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {A B : CurvOp2 (Fin n)} (hA : IsWeyl2 A)
    (hB : IsWeyl2 B) (hUA : rotR U A = A) (hUB : rotR U B = (-1 : ℝ) • B) : innerOp2 A B = 0 := by
  have h := innerOp2_rotR hU hA hB
  rw [hUA, hUB, innerOp2_smul_right] at h
  linarith

/-- **Characters `1` and `ε_j ε_k` are orthogonal**, through the flip at `j`. -/
theorem inner_char_pair (hjk : j ≠ k) {A B : CurvOp2 (Fin n)} (hAW : IsWeyl2 A) (hBW : IsWeyl2 B)
    (hA : SignChar (fun _ => 1) A) (hB : SignChar (setChar {j, k}) B) : innerOp2 A B = 0 := by
  set ε : Fin n → ℝ := fun i => if i = j then -1 else 1 with hεdef
  have hε : ∀ i, ε i * ε i = 1 := fun i => by by_cases h : i = j <;> simp [hεdef, h]
  have hU : IsOrth (signMat ε) := ⟨(signMat_orth ε hε).1, (signMat_orth ε hε).2⟩
  have hA' : rotR (signMat ε) A = A := by rw [rotR_of_hasChar (hA ε hε), one_smul]
  have hB' : rotR (signMat ε) B = (-1 : ℝ) • B := by
    rw [rotR_of_hasChar (hB ε hε)]
    congr 1
    simp [setChar, Finset.prod_pair hjk, hεdef, Ne.symm hjk]
  exact inner_flip_zero hU hAW hBW hA' hB'

/-- **L224 (1), the norm**: `‖D + ν‖² = ‖E‖² + 2(‖y‖² + ‖x‖²)`, `E = ½(D + σD)`, `D⁻_y = ½(D − σD)`, `ν = ν_x`. -/
theorem L224_norm (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) :
    ∃ y x : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ x j = 0 ∧ x k = 0 ∧ ∑ i, x i = 0 ∧
      (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k y) ∧ ν = nuX j k x ∧
      normSq2 (D + ν) = normSq2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D))
        + 2 * (∑ c, y c ^ 2 + ∑ c, x c ^ 2) := by
  obtain ⟨y, x, hyj, hyk, hy, hxj, hxk, hx, hM, hνx, -⟩ := L224_cubic_G hjk hDW hνW hD hν
  refine ⟨y, x, hyj, hyk, hy, hxj, hxk, hx, hM, hνx, ?_⟩
  have hσ := swapM_orth j k
  have hσDW : IsWeyl2 (rotR (swapM j k) D) := rotR_isWeyl2 hσ hDW
  have hσD1 : SignChar (fun _ => 1) (rotR (swapM j k) D) := signChar_rotR_swap j k hD fun _ _ => rfl
  set E : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (D + rotR (swapM j k) D) with hEdef
  set M : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (D - rotR (swapM j k) D) with hMdef
  have eM : M = (1 / 2 : ℝ) • (D + (-1 : ℝ) • rotR (swapM j k) D) := by rw [hMdef]; module
  have hEW : IsWeyl2 E := isWeyl2_smul _ (isWeyl2_add hDW hσDW)
  have hMW : IsWeyl2 M := by rw [eM]; exact isWeyl2_smul _ (isWeyl2_add hDW (isWeyl2_smul _ hσDW))
  have hE1 : SignChar (fun _ => 1) E := signChar_smul (signChar_add hD hσD1) _
  have hM1 : SignChar (fun _ => 1) M := by rw [eM]; exact signChar_smul (signChar_add hD (signChar_smul hσD1 (-1))) _
  have hσσ : rotR (swapM j k) (rotR (swapM j k) D) = D := by
    rw [L219GenOps.rotR_comp, swapM_sq, L219GenOps.rotR_one]
  have hσE : rotR (swapM j k) E = E := by
    rw [hEdef, LinearMap.map_smul, LinearMap.map_add, hσσ]; module
  have hσM : rotR (swapM j k) M = (-1 : ℝ) • M := by
    rw [eM, LinearMap.map_smul, LinearMap.map_add, LinearMap.map_smul, hσσ]; module
  have hEM : innerOp2 E M = 0 := inner_flip_zero hσ hEW hMW hσE hσM
  have hEν : innerOp2 E ν = 0 := inner_char_pair hjk hEW hνW hE1 hν
  have hMν : innerOp2 M ν = 0 := inner_char_pair hjk hMW hνW hM1 hν
  have hsplit : D + ν = E + M + ν := by rw [hEdef, hMdef]; module
  have hnM : normSq2 M = 2 * ∑ c, y c ^ 2 := by rw [hM, normSq2_Dminus hjk, vy_of_zero y hyj hyk]
  have hnν : normSq2 ν = 2 * ∑ c, x c ^ 2 := by
    rw [hνx, normSq2_nuX hjk x (by rw [vy_of_zero x hxj hxk]; exact hx), vy_of_zero x hxj hxk]
  rw [hsplit]
  unfold normSq2 at hnM hnν ⊢
  simp only [innerOp2_add_left, innerOp2_add_right]
  rw [innerOp2_comm M E, innerOp2_comm ν E, innerOp2_comm ν M, hEM, hEν, hMν, hnM, hnν]
  ring

end HamiltonsCubic.L224Norm
