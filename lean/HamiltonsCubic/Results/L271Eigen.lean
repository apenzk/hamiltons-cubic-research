import Mathlib
import HamiltonsCubic.Results.I117Statements
import HamiltonsCubic.Results.TraceOp

set_option linter.style.longLine false

/-!
# L271 (4): the second eigenvalue of `C # ·` on `span(C_P, C_Q)`

[findings/second-order.md](../../../findings/second-order.md), Lemma L271 (4): *"For $C\ne I/c$ ..., with
$C_P$ and $C_Q$ orthogonal with sum $C$, the second eigenvalue of $C\#\cdot$ on
$\operatorname{span}(C_P,C_Q)$ is
$\tfrac12-\frac{\lVert C_Q\rVert^2}{2\lVert C_P\rVert^2}+\frac{q\operatorname{tr}Q^3}{4\lVert C_P\rVert^2\lVert C_Q\rVert^2}$,
$q=\lVert C\rVert^2$, above $\tfrac12$ exactly when $q\operatorname{tr}Q^3>2\lVert C_Q\rVert^4$."* The L271 row owes
*"(4)'s eigenvalue formula and threshold"*; [I117Statements.lean](I117Statements.lean)'s `L271_split_core`
proves the split and `F(C, C_P, C_Q) = ½‖C_Q‖² - ¼ tr Q³`. With `L = (F(C, C_k, C_l))` and
`G = diag(‖C_P‖², ‖C_Q‖²)`, `C # C = C` makes `L`'s rows sum to `G`, so on the span `C # ·` has the
eigenvector `C` at `1` and `H = C_P - (‖C_P‖²/‖C_Q‖²) C_Q` at `1 - L_PQ(1/‖C_P‖² + 1/‖C_Q‖²)`:

* `L271_eigen`: at every solution of the torus system with `C_P`, `C_Q` nonzero,
  `F(C, H, Y) = λ₂ ⟨H, Y⟩` and `F(C, C, Y) = ⟨C, Y⟩` for `Y = C_P, C_Q`, with `λ₂` the record's value;
* `L271_threshold`: `λ₂ > ½ ⟺ 2‖C_Q‖⁴ < q tr Q³`.
-/

namespace HamiltonsCubic.L271Eigen

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.I117S Matrix Finset

variable {m : ℕ}

/-- **L271 (4), the eigenvalue.** -/
theorem L271_eigen (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V)
    (hsys : TorusSystem U V) :
    let C := torusOp (Amu U V) U V;
    let CP := torusOp (Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • (U + V)) ((1 / 2 : ℝ) • (U + V));
    let CQ := torusOp (Amu U V - Matrix.diagonal (dvec U V)) ((1 / 2 : ℝ) • (U - V)) (-((1 / 2 : ℝ) • (U - V)));
    let gP := normSq2 CP;
    let gQ := normSq2 CQ;
    let t := Matrix.trace ((U - V) * (U - V) * (U - V));
    let lam2 := 1 / 2 - gQ / (2 * gP) + (gP + gQ) * t / (4 * gP * gQ);
    let H := CP + (-(gP / gQ)) • CQ;
    0 < gP → 0 < gQ →
    Ftri C C CP = innerOp2 C CP ∧ Ftri C C CQ = innerOp2 C CQ ∧
      Ftri C H CP = lam2 * innerOp2 H CP ∧ Ftri C H CQ = lam2 * innerOp2 H CQ := by
  intro C CP CQ gP gQ t lam2 H hP0 hQ0
  obtain ⟨hsum, horth, hsplit⟩ := L271_split_core U V hU hV hsys
  have hAt : (Amu U V)ᵀ = Amu U V := by
    ext k l; rw [Matrix.transpose_apply, Amu_symm U V hU.1 hV.1]
  have hidem : IsIdem C := L268_converse (Amu U V) U V hAt hU hV rfl hsys
  have hdt : (Matrix.diagonal (dvec U V))ᵀ = Matrix.diagonal (dvec U V) := Matrix.diagonal_transpose _
  have hQt : (Amu U V - Matrix.diagonal (dvec U V))ᵀ = Amu U V - Matrix.diagonal (dvec U V) := by
    rw [Matrix.transpose_sub, hAt, hdt]
  have hCsa : IsSelfAdjoint2 C := torusOp_isSelfAdjoint2 _ U V hAt
  have hPsa : IsSelfAdjoint2 CP := torusOp_isSelfAdjoint2 _ _ _ hdt
  have hQsa : IsSelfAdjoint2 CQ := torusOp_isSelfAdjoint2 _ _ _ hQt
  have hCeq : C = CP + CQ := hsum
  have hPQ : innerOp2 CP CQ = 0 := horth
  have hQP : innerOp2 CQ CP = 0 := by rw [innerOp2_comm]; exact hPQ
  set L := Ftri C CP CQ with hL
  have hLval : L = gQ / 2 - t / 4 := by
    rw [show L = (1 / 2) * gQ - (1 / 4) * t from hsplit]; ring
  -- `F(C, C, Y) = ⟨C, Y⟩`
  have hCY : ∀ Y, Ftri C C Y = innerOp2 C Y := fun Y => by rw [Ftri_idem hidem, innerOp2_comm]
  have hCCP : innerOp2 C CP = gP := by
    rw [hCeq, innerOp2_add_left, hQP, add_zero]; rfl
  have hCCQ : innerOp2 C CQ = gQ := by
    rw [hCeq, innerOp2_add_left, hPQ, zero_add]; rfl
  -- the rows of `L` sum to `G`
  have hQPL : Ftri C CQ CP = L := Ftri_symm23 hCsa CQ CP
  have e1 : Ftri C (CP + CQ) CP = Ftri C CP CP + Ftri C CQ CP := Ftri_add_mid _ _ _ _
  have e2 : Ftri C (CP + CQ) CQ = Ftri C CP CQ + Ftri C CQ CQ := Ftri_add_mid _ _ _ _
  rw [← hCeq, hCY, hCCP, hQPL] at e1
  rw [← hCeq, hCY, hCCQ] at e2
  -- `e1 : gP = F(C,CP,CP) + L`, `e2 : gQ = L + F(C,CQ,CQ)`
  have hHP : Ftri C H CP = Ftri C CP CP + (-(gP / gQ)) * L := by
    show Ftri C (CP + (-(gP / gQ)) • CQ) CP = _
    rw [Ftri_add_mid, Ftri_smul_mid, hQPL]
  have hHQ : Ftri C H CQ = L + (-(gP / gQ)) * Ftri C CQ CQ := by
    show Ftri C (CP + (-(gP / gQ)) • CQ) CQ = _
    rw [Ftri_add_mid, Ftri_smul_mid]
  have hIP : innerOp2 H CP = gP := by
    show innerOp2 (CP + (-(gP / gQ)) • CQ) CP = _
    rw [innerOp2_add_left, innerOp2_smul_left, hQP, mul_zero, add_zero]; rfl
  have hIQ : innerOp2 H CQ = -(gP / gQ) * gQ := by
    show innerOp2 (CP + (-(gP / gQ)) • CQ) CQ = _
    rw [innerOp2_add_left, innerOp2_smul_left, hPQ, zero_add]; rfl
  have hgP : gP ≠ 0 := ne_of_gt hP0
  have hgQ : gQ ≠ 0 := ne_of_gt hQ0
  refine ⟨hCY CP, hCY CQ, ?_, ?_⟩
  · rw [hHP, hIP]
    have hPP : Ftri C CP CP = gP - L := by linarith
    rw [hPP, hLval]
    show _ = (1 / 2 - gQ / (2 * gP) + (gP + gQ) * t / (4 * gP * gQ)) * gP
    field_simp
    ring
  · rw [hHQ, hIQ]
    have hQQ : Ftri C CQ CQ = gQ - L := by linarith
    rw [hQQ, hLval]
    show _ = (1 / 2 - gQ / (2 * gP) + (gP + gQ) * t / (4 * gP * gQ)) * _
    field_simp
    ring

/-- **The threshold**: `λ₂ > ½` exactly when `2‖C_Q‖⁴ < q tr Q³`, `q = ‖C_P‖² + ‖C_Q‖² = ‖C‖²`. -/
theorem L271_threshold {gP gQ t : ℝ} (hP0 : 0 < gP) (hQ0 : 0 < gQ) :
    1 / 2 < 1 / 2 - gQ / (2 * gP) + (gP + gQ) * t / (4 * gP * gQ) ↔ 2 * gQ ^ 2 < (gP + gQ) * t := by
  have e : 1 / 2 - gQ / (2 * gP) + (gP + gQ) * t / (4 * gP * gQ) - 1 / 2
      = ((gP + gQ) * t - 2 * gQ ^ 2) / (4 * gP * gQ) := by
    field_simp
    ring
  have hden : 0 < 4 * gP * gQ := by positivity
  constructor
  · intro h
    have : 0 < ((gP + gQ) * t - 2 * gQ ^ 2) / (4 * gP * gQ) := by linarith
    have := (div_pos_iff_of_pos_right hden).mp this
    linarith
  · intro h
    have : 0 < ((gP + gQ) * t - 2 * gQ ^ 2) / (4 * gP * gQ) := div_pos (by linarith) hden
    linarith

end HamiltonsCubic.L271Eigen
