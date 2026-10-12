import Mathlib
import HamiltonsCubic.Results.L224Step4
import HamiltonsCubic.Results.L0Witness
import HamiltonsCubic.Results.L57Odd

set_option linter.style.longLine false

/-!
# L224's inequality on the operators: `P(W) ≤ Θ_n ‖W‖³` on `𝒮_jk`

[findings/second-order.md](../../../findings/second-order.md), Lemma L224: *Every unit $W\in\mathcal S_{jk}$ has $P(W)\le\Theta_n$*, and
step 4's last link, *$P(W')\le\Theta_n$ by L57*. [L224Step4.lean](L224Step4.lean)'s `L224_step4` gives a Weyl $W'$ of character $1$ with
$\lVert W'\rVert=\lVert W\rVert$ and $P(W)\le P(W')$; L120's `trivial_block_iff` writes $W'$ as a diagonal operator, and L57
([L57Diagonal.lean](L57Diagonal.lean), [L57Odd.lean](L57Odd.lean)) bounds it.

* **`L224_bound`**: $P(D+\nu)\le\theta_0(n)\lVert D+\nu\rVert^3$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, at $n\ge4$, L57's constant and the
  record's $\Theta_n$ at even $n$;
* **`L224_bound_odd`**: $P(D+\nu)\le\sqrt{\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}}\,\lVert D+\nu\rVert^3$ at odd $n\ge5$, the record's $\Theta_n$ at odd $n$.
-/

namespace HamiltonsCubic.L224Bound

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.FamilyLayer HamiltonsCubic.L222Swap HamiltonsCubic.L224Step4

variable {n : ℕ} {j k : Fin n}

/-- A Weyl operator of character `1` is a diagonal operator, with its `P` and its norm. -/
theorem charOne_diag {W : CurvOp2 (Fin n)} (hW : IsWeyl2 W) (h1 : SignChar (fun _ => 1) W) :
    ∃ w : Matrix (Fin n) (Fin n) ℝ, IsWeight w ∧ Pcubic2 W = Pcubic (diagOp w) ∧ normSq2 W = normSq (diagOp w) := by
  obtain ⟨w, hw, rfl⟩ := (L120Ident.trivial_block_iff W hW).mp h1
  exact ⟨w, hw, Pcubic2_restrict (isLinOp_diagOp w) _, normSq2_restrict (isLinOp_diagOp w) _⟩

/-- **L224 on the operators, `θ₀(n)` form**: `P(D + ν) ≤ θ₀(n) ‖D + ν‖³` for `D` Weyl of character `1` and `ν` Weyl of
character `ε_j ε_k`, `n ≥ 4`. -/
theorem L224_bound (hn : 4 ≤ n) (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) :
    Pcubic2 (D + ν) ≤ Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) * Real.sqrt (normSq2 (D + ν)) ^ 3 := by
  obtain ⟨W', hW'W, hW'1, hnorm, hle⟩ := L224_step4 hjk hDW hνW hD hν
  obtain ⟨w, hw, hP, hN⟩ := charOne_diag hW'W hW'1
  have hL := L57Critical.L57_diagonal (by rw [Fintype.card_fin]; exact hn) w hw
  rw [Fintype.card_fin] at hL
  rw [← hnorm, hN]
  unfold RealLayer.norm at hL
  linarith

/-- **L224 on the operators at odd `n`**: `P(D + ν) ≤ √(2(n-1)(n-3)/((n+1)(n-2))) ‖D + ν‖³`, `n ≥ 5` odd. -/
theorem L224_bound_odd (hn : 5 ≤ n) (hodd : ¬ Even n) (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D)
    (hνW : IsWeyl2 ν) (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) :
    Pcubic2 (D + ν) ≤ Real.sqrt (L57Critical.thetaOddSq (n : ℝ)) * Real.sqrt (normSq2 (D + ν)) ^ 3 := by
  obtain ⟨W', hW'W, hW'1, hnorm, hle⟩ := L224_step4 hjk hDW hνW hD hν
  obtain ⟨w, hw, hP, hN⟩ := charOne_diag hW'W hW'1
  have hL := L57Critical.L57_diagonal_odd (by rw [Fintype.card_fin]; exact hn) (by rw [Fintype.card_fin]; exact hodd) w hw
  rw [Fintype.card_fin] at hL
  rw [← hnorm, hN]
  unfold RealLayer.norm at hL
  linarith

end HamiltonsCubic.L224Bound
