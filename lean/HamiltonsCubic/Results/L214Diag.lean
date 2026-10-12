import Mathlib
import HamiltonsCubic.Results.L219Diag
import HamiltonsCubic.Results.L120Decomp
import HamiltonsCubic.Results.L214Op

set_option linter.style.longLine false

/-!
# L214 at the coordinate-diagonal split: the frame input $T(D,D,N)=0$ proved

[findings/second-order.md](../../../findings/second-order.md), Lemma L214 splits $W=D+N$ with $D$ the coordinate-diagonal part
and needs $T(D,D,N)=0$ from L120. [L214Op.lean](L214Op.lean)'s `L214_op` and `L214_op_max` take it, and
$\langle D,N\rangle=0$, as hypotheses. This file supplies both at the split of
[L120Decomp.lean](L120Decomp.lean), $D$ the sign-fixed component `comp ∅ W`, which [L120Ident.lean](L120Ident.lean)
identifies with the diagonal operator of a weight, and $N=W-D$ the sum of the other components:

* `sig_of_hasChar_c`, `comp_sig_neg`: a component of index set $t\ni m$ is odd under the reflection $\sigma_{e_m}$;
* **`L214_diag`**: at a unit Weyl $W$ with $Q(W)=\theta W$, $\langle D,N\rangle=0$, $T(D,D,N)=0$ (each term $T(D,D,N_t)$ is
  negated by a reflection that fixes $D$, through `Tsym_sig`), and L214's two relations
  $\theta t=P(D)+T(D,N,N)$, $\theta(1-t)=2T(D,N,N)+P(N)$ with $t=\lVert D\rVert^2$;
* `L214_diag_max`: at a local maximiser with $\theta>0$, $T(D,N,N)\ge\tfrac\theta2t(1-t)$.
-/

namespace HamiltonsCubic.L214Diag

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L120Decomp HamiltonsCubic.L214Op HamiltonsCubic.L219Op HamiltonsCubic.L219Diag

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem sig_of_hasChar_c (k : ι) (V : CurvOp2 ι) {c : ℝ} (h : HasChar c (Results.flip k) V) : sig k V = c • V := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  have hX : IsSkew (X : Matrix ι ι ℝ) := X.2
  have e := h (X : Matrix ι ι ℝ) hX
  have e1 := extend_apply V (cS k X)
  rw [cS_coe] at e1
  have e2 := extend_apply V X
  rw [e1, e2] at e
  rw [sig_apply, cS_coe, ContinuousLinearMap.smul_apply, Submodule.coe_smul]
  rw [flip_T] at e ⊢
  exact e

theorem comp_empty_fix (R : CurvOp2 ι) (h : IsWeyl2 R) : SignChar (fun _ => 1) (comp ∅ R h) := fun ε hε => by
  have := comp_char ∅ R h ε hε
  simpa [setChar] using this

/-- **A component whose index set contains `m` is odd under `σ_{e_m}`.** -/
theorem comp_sig_neg {t : Finset ι} {m : ι} (hm : m ∈ t) (R : CurvOp2 ι) (h : IsWeyl2 R) :
    sig m (comp t R h) = -(comp t R h) := by
  have hc := comp_char t R h (Results.sgn m) (Results.sgn_mul_self m)
  have hv : setChar t (Results.sgn m) = -1 := by
    simp [setChar, Results.sgn, Finset.prod_ite_eq', hm]
  rw [hv] at hc
  rw [sig_of_hasChar_c m _ (hc : HasChar (-1) (Results.flip m) (comp t R h))]
  module

/-- **L214 at the coordinate-diagonal split.** -/
theorem L214_diag (W : CurvOp2 ι) (hWW : IsWeyl2 W) (hW1 : normSq2 W = 1) {θ : ℝ} (hQ : Qop2 W = θ • W) :
    innerOp2 (comp ∅ W hWW) (W - comp ∅ W hWW) = 0 ∧
      Tsym (comp ∅ W hWW) (comp ∅ W hWW) (W - comp ∅ W hWW) = 0 ∧
      θ * normSq2 (comp ∅ W hWW) = Pcubic2 (comp ∅ W hWW) + Tsym (comp ∅ W hWW) (W - comp ∅ W hWW) (W - comp ∅ W hWW) ∧
      θ * (1 - normSq2 (comp ∅ W hWW))
        = 2 * Tsym (comp ∅ W hWW) (W - comp ∅ W hWW) (W - comp ∅ W hWW) + Pcubic2 (W - comp ∅ W hWW) := by
  set D := comp ∅ W hWW with hDdef
  have hN : W - D = ∑ t ∈ univ.erase ∅, comp t W hWW := by
    have hs := sum_comp W hWW
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ ∅)] at hs
    calc W - D = (comp ∅ W hWW + ∑ t ∈ univ.erase ∅, comp t W hWW) - D := by conv_lhs => rw [← hs]
      _ = ∑ t ∈ univ.erase ∅, comp t W hWW := by rw [hDdef]; abel
  have hDN : innerOp2 D (W - D) = 0 := by
    rw [hN, innerOp2_sum']
    exact Finset.sum_eq_zero fun t ht => comp_perp_ne (comp_empty_fix W hWW) (Finset.ne_of_mem_erase ht) W hWW
  have hperp : Tsym D D (W - D) = 0 := by
    rw [hN]
    have hsum : Tsym D D (∑ t ∈ univ.erase ∅, comp t W hWW) = ∑ t ∈ univ.erase ∅, Tsym D D (comp t W hWW) := by
      rw [← TsymL_apply, map_sum]
      rfl
    rw [hsum]
    refine Finset.sum_eq_zero fun t ht => ?_
    obtain ⟨m, hm⟩ := Finset.nonempty_iff_ne_empty.mpr (Finset.ne_of_mem_erase ht)
    have hD : sig m D = D := sig_of_hasChar m D ((comp_empty_fix W hWW) (Results.sgn m) (Results.sgn_mul_self m))
    have e := Tsym_sig m D D (comp t W hWW)
    rw [hD, comp_sig_neg hm W hWW] at e
    have hneg : Tsym D D (-(comp t W hWW)) = -Tsym D D (comp t W hWW) := by
      rw [show -(comp t W hWW) = (-1 : ℝ) • comp t W hWW by module, Tsym_smul_right]; ring
    rw [hneg] at e
    linarith
  have hsplit : W = D + (W - D) := by abel
  have hNN : innerOp2 (W - D) (W - D) = 1 - normSq2 D := by
    have e : innerOp2 (D + (W - D)) (D + (W - D)) = normSq2 D + innerOp2 (W - D) (W - D) := by
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, hDN, innerOp2_comm (W - D) D, hDN]
      unfold normSq2
      ring
    rw [← hsplit] at e
    have hW1' : innerOp2 W W = 1 := hW1
    linarith
  obtain ⟨r1, r2⟩ := L214_op hWW.isSelfAdjoint2 hQ hsplit hDN rfl hNN hperp
  exact ⟨hDN, hperp, r1, r2⟩

/-- **L214's inequality at the coordinate-diagonal split**, at a local maximiser with `θ > 0`. -/
theorem L214_diag_max (W : CurvOp2 ι) (hWW : IsWeyl2 W) (hW1 : normSq2 W = 1) {θ : ℝ} (hQ : Qop2 W = θ • W)
    (hmax : IsLocalMaxOn Pcubic2 {R : CurvOp2 ι | normSq2 R = 1 ∧ IsWeyl2 R} W) (hθ : 0 < θ) :
    θ / 2 * (normSq2 (comp ∅ W hWW) * (1 - normSq2 (comp ∅ W hWW)))
      ≤ Tsym (comp ∅ W hWW) (W - comp ∅ W hWW) (W - comp ∅ W hWW) := by
  obtain ⟨hDN, hperp, -, -⟩ := L214_diag W hWW hW1 hQ
  set D := comp ∅ W hWW with hDdef
  have hsplit : W = D + (W - D) := by abel
  have hNN : innerOp2 (W - D) (W - D) = 1 - normSq2 D := by
    have e : innerOp2 (D + (W - D)) (D + (W - D)) = normSq2 D + innerOp2 (W - D) (W - D) := by
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, hDN, innerOp2_comm (W - D) D, hDN]
      unfold normSq2
      ring
    rw [← hsplit] at e
    have hW1' : innerOp2 W W = 1 := hW1
    linarith
  exact L214_op_max hW1 hWW hQ hmax hθ (comp_isWeyl2 ∅ W hWW) hsplit hDN rfl hNN hperp

end HamiltonsCubic.L214Diag
