import Mathlib
import HamiltonsCubic.Results.L217Op
import HamiltonsCubic.Results.L24HessOp
import HamiltonsCubic.Results.L24Weyl
import HamiltonsCubic.Results.L216Bern

set_option linter.style.longLine false

/-!
# L217 with the record's gap: $\langle L_eH,H\rangle\le\tfrac12-\gamma$

[findings/second-order.md](../../../findings/second-order.md), Lemma L217 assumes *$\langle L_eH,H\rangle\le\tfrac12-\gamma$
for every unit $H\perp u$ orthogonal to the orbit tangent*, $e=u/\theta_u$. [L217Op.lean](L217Op.lean)'s `L217_op` takes
the gap as `hgap : Tsym u v v ≤ θ(½ − γ)`, in the symmetrised cubic. This file joins the two:

* `Tsym_eq_Le`: at a self-adjoint $u$ with $P(u)\ne0$ and a self-adjoint $v$,
  $T(u,v,v)=\langle u,Q(v)\rangle=P(u)\,\langle L_ev,v\rangle$, through `Tsym_quad`, `Pcubic2Quad_selfAdjoint` and
  `innerOp2_foxProd2_self`;
* `Pcubic2_crit`: at a unit critical $u$ with $Q(u)=\theta u$, $P(u)=\theta$;
* **`L217_op_Le`**: `L217_op` with the gap in the record's inequality, $\langle L_ev,v\rangle\le\tfrac12-\gamma$, at the single
  direction $v$ the proof uses; that $v$ lies in the record's orbit-normal family is its step 1;
* `no_critical_in_tube_Le`: [L216Bern.lean](L216Bern.lean)'s step 5 at a critical point with the same gap, for
  [L216](../../../findings/second-order.md)'s $\langle L_eH,H\rangle\le\tfrac12-\gamma$; as in `no_critical_in_tube_crit`, $H$ carries
  no unit-norm hypothesis, and the record's reading is at unit $H$.
-/

namespace HamiltonsCubic.L217Le

open HamiltonsCubic.RealLayer HamiltonsCubic.L214Op HamiltonsCubic.L217Op

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The symmetrised cubic's quadratic slot is `L_e`'s form**: `T(u, v, v) = P(u) ⟨L_e v, v⟩`. -/
theorem Tsym_eq_Le {u v : CurvOp2 ι} (hu : IsSelfAdjoint2 u) (hv : IsSelfAdjoint2 v) (hP : Pcubic2 u ≠ 0) :
    Tsym u v v = Pcubic2 u * innerOp2 (LeLin u v) v := by
  have h1 := Tsym_quad u v
  rw [Pcubic2Quad_selfAdjoint hv] at h1
  have h2 : innerOp2 (LeLin u v) v = (Pcubic2 u)⁻¹ * innerOp2 u (Qop2 v) := by
    show innerOp2 (foxProd2 ((Pcubic2 u)⁻¹ • u) v) v = _
    rw [foxProd2_smul_left, innerOp2_smul_left, innerOp2_foxProd2_self hu hv]
  rw [h2, ← mul_assoc, mul_inv_cancel₀ hP, one_mul]
  linarith

/-- **At a unit critical point `P(u) = θ`.** -/
theorem Pcubic2_crit {u : CurvOp2 ι} (hu : IsSelfAdjoint2 u) {θ : ℝ} (hQ : Qop2 u = θ • u) (hu1 : normSq2 u = 1) :
    Pcubic2 u = θ := by
  rw [← Tsym_diag, Tsym_crit hu hQ, show innerOp2 u u = normSq2 u from rfl, hu1, mul_one]

/-- **L217 with the record's gap inequality at the direction `v`.** At a unit critical `u` with `Q(u) = θu`, `θ > 0`, a unit Weyl `v ⊥ u` with
`⟨L_e v, v⟩ ≤ ½ − γ`, and a global maximiser `W* = c u + s v` with `c² + s² = 1`, `0 ≤ s ≤ min(3γ, ½)`: `P(W*) ≤ θ`. -/
theorem L217_op_Le {u v Wst : CurvOp2 ι} {θ γ s c : ℝ} (hu : IsSelfAdjoint2 u) (hQ : Qop2 u = θ • u)
    (hu1 : normSq2 u = 1) (hθ : 0 < θ)
    (hvW : IsWeyl2 v) (hv1 : normSq2 v = 1) (hvu : innerOp2 u v = 0)
    (hgap : innerOp2 (LeLin u v) v ≤ 1 / 2 - γ)
    (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hcs : c ^ 2 + s ^ 2 = 1) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2)
    (hW : Wst = c • u + s • v)
    (hmax : ∀ R : CurvOp2 ι, IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 Wst) :
    Pcubic2 Wst ≤ θ := by
  have hP := Pcubic2_crit hu hQ hu1
  have hT : Tsym u v v ≤ θ * (1 / 2 - γ) := by
    rw [Tsym_eq_Le hu hvW.isSelfAdjoint2 (by rw [hP]; exact hθ.ne'), hP]
    exact mul_le_mul_of_nonneg_left hgap hθ.le
  exact L217_op hu hQ hu1 hθ hvW hv1 hvu hT hs0 hc0 hcs hs hshalf hW hmax

/-- **L216's step 5 at a critical point, with the record's gap** `⟨L_e H, H⟩ ≤ ½ − γ`. -/
theorem no_critical_in_tube_Le (W H : CurvOp2 ι) (hWs : IsSelfAdjoint2 W) (hHs : IsSelfAdjoint2 H) {θ γ M s : ℝ}
    (hQ : Qop2 W = θ • W) (hW : normSq2 W = 1) (hWH : innerOp2 W H = 0) (hθ : 0 < θ)
    (hM0 : 0 < M) (hM : ∀ x y : ℝ, x ^ 2 + y ^ 2 = 1 → |Pcubic2 (x • W + y • H)| ≤ M)
    (hgap : innerOp2 (LeLin W H) H ≤ 1 / 2 - γ) (hs0 : 0 < s) (hsr : s < 4 * θ * γ / (9 * M)) :
    HamiltonsCubic.L216Bern.cub (HamiltonsCubic.L216Bern.Dq (HamiltonsCubic.L216Bern.qP W H))
      (Real.cos s) (Real.sin s) < 0 := by
  have hP := Pcubic2_crit hWs hQ hW
  have hT : Tsym W H H ≤ θ * (1 / 2 - γ) := by
    rw [Tsym_eq_Le hWs hHs (by rw [hP]; exact hθ.ne'), hP]
    exact mul_le_mul_of_nonneg_left hgap hθ.le
  exact HamiltonsCubic.L216Bern.no_critical_in_tube_crit W H hWs hQ hW hWH hM0 hM hT hs0 hsr

end HamiltonsCubic.L217Le
