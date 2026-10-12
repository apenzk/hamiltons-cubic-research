import Mathlib
import HamiltonsCubic.Results.L222Swap
import HamiltonsCubic.Results.L214Frame

set_option linter.style.longLine false

/-!
# L224, step 3 on the operators: the parity and character expansion of the cubic on `𝒮_jk`

[findings/second-order.md](../../../findings/second-order.md), Lemma L224, step 3: *in $P(W)=T(W,W,W)$ a term with an odd number
of factors $D^-_y$ vanishes, $\sigma$ being an automorphism that fixes $E$ and $\nu_x$ and reverses $D^-_y$. A term with an odd
number of factors $\nu_x$ vanishes by the character $\varepsilon_j\varepsilon_k$. What remains is
$P(E)+3T(E,D^-_y,D^-_y)+3T(E,\nu_x,\nu_x)$.* Both vanishings are one statement: a frame change is an isometry of $T$ on Weyl
operators, so if it scales $x,y,z$ by $a,b,c$ with $abc=-1$ then $T(x,y,z)=0$. The swap $\sigma$ scales $E,D^-,\nu$ by $1,-1,1$
([L222Swap.lean](L222Swap.lean)'s `pair_swap_even`), and the flip at $j$ scales them by $1,1,-1$ (their characters).

* `rotR_of_hasChar`: an operator of sign character $c$ is scaled by $c$ under the frame change of that sign matrix;
* `Tsym_char_zero`: $T(x,y,z)=0$ when an orthogonal frame change scales the Weyl $x,y,z$ by $a,b,c$ with $abc=-1$;
* **`L224_cubic`**, **`L224_cubic_pair`**: at Weyl $D$ of character $1$ (so $D\in\mathcal D_n$, L120Ident's `trivial_block_iff`) and $\nu$ of character
  $\varepsilon_j\varepsilon_k$ (so $\nu\in V_{jk}$, `pair_block_iff`), with $E,D^-$ the swap-even and
  swap-odd parts of $D$, $P(D+\nu)=P(E)+3T(E,D^-,D^-)+3T(E,\nu,\nu)=P(E)+3\langle E,D^-\circ D^-\rangle+3\langle E,\nu\circ\nu\rangle$.
-/

namespace HamiltonsCubic.L224Cubic

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.FrameOp2 HamiltonsCubic.L214Op HamiltonsCubic.L222Op HamiltonsCubic.L222Swap
  HamiltonsCubic.FrameLayer

variable {n : ℕ}

/-- **A sign character is the scaling under its sign matrix's frame change.** -/
theorem rotR_of_hasChar {c : ℝ} {S : Matrix (Fin n) (Fin n) ℝ} {A : CurvOp2 (Fin n)} (h : HasChar c S A) :
    rotR S A = c • A := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  have e1 := extend_rotR S A X.2
  rw [extend_apply, h _ X.2, extend_apply] at e1
  rw [e1]
  rfl

/-- **`T` vanishes on a triple an orthogonal frame change scales by `a, b, c` with `abc = −1`.** -/
theorem Tsym_char_zero {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {x y z : CurvOp2 (Fin n)} (hx : IsWeyl2 x)
    (hy : IsWeyl2 y) (hz : IsWeyl2 z) {a b c : ℝ} (ha : rotR U x = a • x) (hb : rotR U y = b • y)
    (hc : rotR U z = c • z) (habc : a * b * c = -1) : Tsym x y z = 0 := by
  have e := Tsym_rotR hU hx hy hz
  rw [ha, hb, hc, Tsym_smul_left, Tsym_smul_mid, Tsym_smul_right] at e
  have h2 : a * (b * (c * Tsym x y z)) = (a * b * c) * Tsym x y z := by ring
  rw [h2, habc] at e
  linarith

/-- **L224 (3), the cubic on `𝒮_jk`**: `P(D + ν) = P(E) + 3T(E, D⁻, D⁻) + 3T(E, ν, ν)`, with `E, D⁻ = ½(D ± σD)`. -/
theorem L224_cubic {j k : Fin n} (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) :
    Pcubic2 (D + ν) = Pcubic2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D))
      + 3 * Tsym ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) ((1 / 2 : ℝ) • (D - rotR (swapM j k) D))
          ((1 / 2 : ℝ) • (D - rotR (swapM j k) D))
      + 3 * Tsym ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) ν ν := by
  have hM := swapM_orth j k
  set σD := rotR (swapM j k) D with hσDdef
  set E : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (D + σD) with hEdef
  set M : CurvOp2 (Fin n) := (1 / 2 : ℝ) • (D - σD) with hMdef
  have hσDW : IsWeyl2 σD := rotR_isWeyl2 hM hDW
  have hEW : IsWeyl2 E := isWeyl2_smul _ (isWeyl2_add hDW hσDW)
  have hMW : IsWeyl2 M := by
    have e : M = (1 / 2 : ℝ) • (D + (-1 : ℝ) • σD) := by rw [hMdef]; module
    rw [e]; exact isWeyl2_smul _ (isWeyl2_add hDW (isWeyl2_smul _ hσDW))
  have hσσ : rotR (swapM j k) σD = D := by
    rw [hσDdef, L219GenOps.rotR_comp, swapM_sq, L219GenOps.rotR_one]
  have hσE : rotR (swapM j k) E = (1 : ℝ) • E := by
    rw [hEdef, LinearMap.map_smul, LinearMap.map_add, hσσ]; module
  have hσM : rotR (swapM j k) M = (-1 : ℝ) • M := by
    have e : M = (1 / 2 : ℝ) • D + (-(1 / 2) : ℝ) • σD := by rw [hMdef]; module
    rw [e, LinearMap.map_add, LinearMap.map_smul, LinearMap.map_smul, hσσ]; module
  have hσV : rotR (swapM j k) ν = (1 : ℝ) • ν := by rw [pair_swap_even hjk hνW hν]; module
  set S := signMat (Results.sgn j) with hSdef
  have hε := Results.sgn_mul_self j
  have hSo : IsOrth S := signMat_orth _ hε
  have hσD1 : SignChar (fun _ => 1) σD := signChar_rotR_swap j k hD fun _ _ => rfl
  have hE1 : SignChar (fun _ => 1) E := signChar_smul (signChar_add hD hσD1) _
  have hM1 : SignChar (fun _ => 1) M := by
    have h1 := signChar_add hD (signChar_smul hσD1 (-1))
    rw [show D + (-1 : ℝ) • σD = D - σD by module] at h1
    exact signChar_smul h1 _
  have hfE : rotR S E = (1 : ℝ) • E := rotR_of_hasChar (hE1 _ hε)
  have hfM : rotR S M = (1 : ℝ) • M := rotR_of_hasChar (hM1 _ hε)
  have hχ : setChar {j, k} (Results.sgn j) = -1 := by
    rw [setChar_pair hjk]; simp [Results.sgn, Ne.symm hjk]
  have hfV : rotR S ν = (-1 : ℝ) • ν := by
    have h := hν _ hε
    rw [hχ] at h
    exact rotR_of_hasChar h
  have zEEM : Tsym E E M = 0 :=
    Tsym_char_zero (swapM_orth j k) hEW hEW hMW hσE hσE hσM (by norm_num)
  have zEEV : Tsym E E ν = 0 :=
    Tsym_char_zero hSo hEW hEW hνW hfE hfE hfV (by norm_num)
  have zEME : Tsym E M E = 0 :=
    Tsym_char_zero (swapM_orth j k) hEW hMW hEW hσE hσM hσE (by norm_num)
  have zEMV : Tsym E M ν = 0 :=
    Tsym_char_zero (swapM_orth j k) hEW hMW hνW hσE hσM hσV (by norm_num)
  have zEVE : Tsym E ν E = 0 :=
    Tsym_char_zero hSo hEW hνW hEW hfE hfV hfE (by norm_num)
  have zEVM : Tsym E ν M = 0 :=
    Tsym_char_zero (swapM_orth j k) hEW hνW hMW hσE hσV hσM (by norm_num)
  have zMEE : Tsym M E E = 0 :=
    Tsym_char_zero (swapM_orth j k) hMW hEW hEW hσM hσE hσE (by norm_num)
  have zMEV : Tsym M E ν = 0 :=
    Tsym_char_zero (swapM_orth j k) hMW hEW hνW hσM hσE hσV (by norm_num)
  have zMMM : Tsym M M M = 0 :=
    Tsym_char_zero (swapM_orth j k) hMW hMW hMW hσM hσM hσM (by norm_num)
  have zMMV : Tsym M M ν = 0 :=
    Tsym_char_zero hSo hMW hMW hνW hfM hfM hfV (by norm_num)
  have zMVE : Tsym M ν E = 0 :=
    Tsym_char_zero (swapM_orth j k) hMW hνW hEW hσM hσV hσE (by norm_num)
  have zMVM : Tsym M ν M = 0 :=
    Tsym_char_zero hSo hMW hνW hMW hfM hfV hfM (by norm_num)
  have zMVV : Tsym M ν ν = 0 :=
    Tsym_char_zero (swapM_orth j k) hMW hνW hνW hσM hσV hσV (by norm_num)
  have zVEE : Tsym ν E E = 0 :=
    Tsym_char_zero hSo hνW hEW hEW hfV hfE hfE (by norm_num)
  have zVEM : Tsym ν E M = 0 :=
    Tsym_char_zero (swapM_orth j k) hνW hEW hMW hσV hσE hσM (by norm_num)
  have zVME : Tsym ν M E = 0 :=
    Tsym_char_zero (swapM_orth j k) hνW hMW hEW hσV hσM hσE (by norm_num)
  have zVMM : Tsym ν M M = 0 :=
    Tsym_char_zero hSo hνW hMW hMW hfV hfM hfM (by norm_num)
  have zVMV : Tsym ν M ν = 0 :=
    Tsym_char_zero (swapM_orth j k) hνW hMW hνW hσV hσM hσV (by norm_num)
  have zVVM : Tsym ν ν M = 0 :=
    Tsym_char_zero (swapM_orth j k) hνW hνW hMW hσV hσV hσM (by norm_num)
  have zVVV : Tsym ν ν ν = 0 :=
    Tsym_char_zero hSo hνW hνW hνW hfV hfV hfV (by norm_num)
  have hW : D + ν = E + M + ν := by rw [hEdef, hMdef]; module
  rw [hW, ← Tsym_diag, ← Tsym_diag]
  simp only [Tsym_add_left, Tsym_add_mid, Tsym_add_right]
  have s1 := Tsym_12 M E M
  have s2 := Tsym_23 M M E
  have s3 := Tsym_12 ν E ν
  have s4 := Tsym_23 ν ν E
  have s5 := Tsym_23 E M M
  have s6 := Tsym_12 M M E
  have s7 := Tsym_23 E ν ν
  have s8 := Tsym_12 ν ν E
  linarith [zEEM, zEEV, zEME, zEMV, zEVE, zEVM, zMEE, zMEV, zMMM, zMMV, zMVE, zMVM, zMVV, zVEE, zVEM, zVME, zVMM, zVMV, zVVM, zVVV]

/-- **L224 (3) in the record's pairing form**: `P(D + ν) = P(E) + 3⟨E, D⁻∘D⁻⟩ + 3⟨E, ν∘ν⟩`, through
`T(E, X, X) = ⟨E∘X, X⟩ = ⟨E, X∘X⟩` at self-adjoint `E, X` (L214Frame's `Tsym_eq_fox`, L24Eigen's `innerOp2_foxProd2_self`). -/
theorem L224_cubic_pair {j k : Fin n} (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) :
    Pcubic2 (D + ν) = Pcubic2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D))
      + 3 * innerOp2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D))
          (foxProd2 ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)))
      + 3 * innerOp2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) (foxProd2 ν ν) := by
  have hM := swapM_orth j k
  have hσDW : IsWeyl2 (rotR (swapM j k) D) := rotR_isWeyl2 hM hDW
  have hEW : IsWeyl2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) := isWeyl2_smul _ (isWeyl2_add hDW hσDW)
  have hMW : IsWeyl2 ((1 / 2 : ℝ) • (D - rotR (swapM j k) D)) := by
    have e : (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = (1 / 2 : ℝ) • (D + (-1 : ℝ) • rotR (swapM j k) D) := by module
    rw [e]; exact isWeyl2_smul _ (isWeyl2_add hDW (isWeyl2_smul _ hσDW))
  have pair : ∀ E X : CurvOp2 (Fin n), IsWeyl2 E → IsWeyl2 X → Tsym E X X = innerOp2 E (foxProd2 X X) :=
    fun E X hE hX => by
      rw [HamiltonsCubic.L214Frame.Tsym_eq_fox hE.isSelfAdjoint2 hX.isSelfAdjoint2,
        innerOp2_foxProd2_self hE.isSelfAdjoint2 hX.isSelfAdjoint2, foxProd2_self]
  rw [L224_cubic hjk hDW hνW hD hν, pair _ _ hEW hMW, pair _ _ hEW hνW]

end HamiltonsCubic.L224Cubic
