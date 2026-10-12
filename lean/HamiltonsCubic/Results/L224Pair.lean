import Mathlib
import HamiltonsCubic.Results.OddPart
import HamiltonsCubic.Results.L224Cubic

set_option linter.style.longLine false

/-!
# L224 step 3 in the record's coordinates: `P(D + ν) = P(E) + 3⟨E, G_y⟩ + 3⟨E, G_x⟩`

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, steps 1 to 3: *a diagonal $D$ splits as $D=E+D^-_y$
with $E$ swap-even*, *every element of $V_{jk}$ is $\nu_x$*, *$\nu_x\circ\nu_x=G_x$*, *$D^-_y\circ D^-_y$ … is $G_y$*, and the cubic
reduces to $P(E)+3T(E,D^-_y,D^-_y)+3T(E,\nu_x,\nu_x)$, which total symmetry turns into pairings with $G_y$ and $G_x$.
[L224Cubic.lean](L224Cubic.lean)'s `L224_cubic_pair` carries the pairing form with $D^-\circ D^-$ and $\nu\circ\nu$;
[OddPart.lean](OddPart.lean)'s `Q_odd_half` and [PairIdent.lean](PairIdent.lean)'s `Q_pair` identify the two squares.

* **`L224_cubic_G`**: at a Weyl $D$ of character $1$ and a Weyl $\nu$ of character $\varepsilon_j\varepsilon_k$, there are $y,x$ zero at
  $j,k$ with $\sum y=\sum x=0$, $\tfrac12(D-\sigma D)=D^-_y$, $\nu=\nu_x$ and $P(D+\nu)=P(E)+3\langle E,G_y\rangle+3\langle E,G_x\rangle$.
-/

namespace HamiltonsCubic.L224Pair

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.I117S HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent HamiltonsCubic.L222Swap
  HamiltonsCubic.OddPart HamiltonsCubic.L224Cubic HamiltonsCubic.FrameOp2 HamiltonsCubic.L222Op HamiltonsCubic.L120Blocks

variable {n : ℕ} {j k : Fin n}

/-- **L224 (1)–(3) in coordinates**: `P(D + ν) = P(E) + 3⟨E, G_y⟩ + 3⟨E, G_x⟩`, `E = ½(D + σD)`, `D⁻_y = ½(D − σD)`, `ν = ν_x`. -/
theorem L224_cubic_G (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) :
    ∃ y x : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ x j = 0 ∧ x k = 0 ∧ ∑ i, x i = 0 ∧
      (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k y) ∧ ν = nuX j k x ∧
      Pcubic2 (D + ν) = Pcubic2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D))
        + 3 * innerOp2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) (coordOp (Gy j k y))
        + 3 * innerOp2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) (coordOp (Gy j k x)) := by
  obtain ⟨y, hyj, hyk, hy, hM, hQM⟩ := Q_odd_half hjk hDW hD
  obtain ⟨x, hxj, hxk, hx, hνx, hQν⟩ := Q_pair hjk hνW hν
  refine ⟨y, x, hyj, hyk, hy, hxj, hxk, hx, hM, hνx, ?_⟩
  rw [L224_cubic_pair hjk hDW hνW hD hν, foxProd2_self, foxProd2_self, hQM, hQν]

end HamiltonsCubic.L224Pair
