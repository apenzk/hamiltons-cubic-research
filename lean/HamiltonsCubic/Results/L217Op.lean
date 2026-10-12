import Mathlib
import HamiltonsCubic.Results.L214Op
import HamiltonsCubic.Results.L217Statement

set_option linter.style.longLine false

/-!
# L217 at the operator: the value bootstrap for `P` on the Weyl sphere

[findings/second-order.md](../../../findings/second-order.md), Lemma L217: *"Let $u$ be a unit critical point of
$P$ on the unit sphere of $\mathcal W_n$ with $\theta_u=P(u)>0$ and $e=u/\theta_u$, and suppose
$\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp u$ orthogonal to the orbit tangent ... Let $W^\ast$
be a global maximiser of $P$ on the unit sphere, $m=P(W^\ast)$, at geodesic distance $\varphi\in[0,\tfrac\pi2]$
from $\mathcal O$ with $\sin\varphi\le\min(3\gamma,\tfrac12)$. Then $m\le\theta_u$, and ... $m=\theta_u$."*
[L217Statement.lean](L217Statement.lean) proves the chain for an abstract symmetric trilinear form. This file
instantiates it at `P` through [L214Op.lean](L214Op.lean)'s `Tsym`:

* `L217_op`: at a unit self-adjoint `u` with `Q(u) = θu`, `θ > 0`, and a unit Weyl `v ⊥ u` carrying the gap
  `Tsym u v v ≤ θ(½ - γ)` (the record's `⟨L_e v, v⟩ ≤ ½ - γ`, `Tsym u v v = θ⟨L_e v, v⟩`), every
  `W* = cos φ · u + sin φ · v` with `sin φ ≤ min(3γ, ½)` whose value bounds `P` on the unit Weyl sphere has
  `P(W*) ≤ θ`, the bound `γ ≥ 0` following from `0 ≤ sin φ ≤ 3γ`;
* `L217_op_eq`: when `u` is itself Weyl, so `W*` is a unit Weyl operator and maximises `P` there, `P(W*) = θ`.

The nearest-point decomposition, that a maximiser at geodesic distance `φ` from the orbit is `cos φ · u' + sin φ · v`
with `u'` on the orbit and `v` a unit vector orthogonal to `u'` and to the orbit tangent at `u'`, enters as the
hypotheses `hW` and on `v`: the first-variation step and the orbit are the record's.
-/

namespace HamiltonsCubic.L217Op

open HamiltonsCubic.RealLayer HamiltonsCubic.L214Op

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

set_option maxHeartbeats 800000 in
/-- **L217 at the operator.** -/
theorem L217_op {u v Wst : CurvOp2 ι} {θ γ s c : ℝ} (hu : IsSelfAdjoint2 u) (hQ : Qop2 u = θ • u)
    (hu1 : normSq2 u = 1) (hθ : 0 < θ)
    (hvW : IsWeyl2 v) (hv1 : normSq2 v = 1) (hvu : innerOp2 u v = 0)
    (hgap : Tsym u v v ≤ θ * (1 / 2 - γ))
    (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hcs : c ^ 2 + s ^ 2 = 1) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2)
    (hW : Wst = c • u + s • v)
    (hmax : ∀ R : CurvOp2 ι, IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 Wst) :
    Pcubic2 Wst ≤ θ := by
  have hγ0 : 0 ≤ γ := by linarith
  have h12 : ∀ x y z : CurvOp2 ι, TsymL x y z = TsymL y x z := fun x y z => Tsym_12 x y z
  have h23 : ∀ x y z : CurvOp2 ι, TsymL x y z = TsymL x z y := fun x y z => Tsym_23 x y z
  have huu : TsymL u u u = θ := by
    rw [TsymL_apply, Tsym_crit hu hQ, show innerOp2 u u = normSq2 u from rfl, hu1, mul_one]
  have hcrit : TsymL u u v = 0 := by rw [TsymL_apply, Tsym_crit hu hQ, hvu, mul_zero]
  have hm : Pcubic2 Wst = TsymL Wst Wst Wst := by rw [TsymL_apply, Tsym_diag]
  have hvv : TsymL v v v ≤ Pcubic2 Wst := by rw [TsymL_apply, Tsym_diag]; exact hmax v hvW hv1
  have hc : c ^ 2 = 1 - s ^ 2 := by linarith
  have hgap' : TsymL u v v ≤ θ * (1 / 2 - γ) := by rw [TsymL_apply]; exact hgap
  exact HamiltonsCubic.L217Statement.value_bootstrap (V := CurvOp2 ι) (T := TsymL) (u := u) (v := v) (W := Wst)
    (θ := θ) (γ := γ) (m := Pcubic2 Wst) (s := s) (c := c) h12 h23 hθ hγ0 hs0 hc0 hc hs hshalf hW hm
    huu hcrit hgap' hvv

/-- **The orbit is maximal**: when `u` is Weyl, `P(W*) = θ`. -/
theorem L217_op_eq {u v Wst : CurvOp2 ι} {θ γ s c : ℝ} (huW : IsWeyl2 u) (hQ : Qop2 u = θ • u)
    (hu1 : normSq2 u = 1) (hθ : 0 < θ)
    (hvW : IsWeyl2 v) (hv1 : normSq2 v = 1) (hvu : innerOp2 u v = 0)
    (hgap : Tsym u v v ≤ θ * (1 / 2 - γ))
    (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hcs : c ^ 2 + s ^ 2 = 1) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2)
    (hW : Wst = c • u + s • v)
    (hmax : ∀ R : CurvOp2 ι, IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 Wst) :
    Pcubic2 Wst = θ := by
  refine le_antisymm (L217_op huW.isSelfAdjoint2 hQ hu1 hθ hvW hv1 hvu hgap hs0 hc0 hcs hs hshalf hW hmax) ?_
  have hPu : Pcubic2 u = θ := by
    rw [← Tsym_diag, Tsym_crit huW.isSelfAdjoint2 hQ, show innerOp2 u u = normSq2 u from rfl, hu1, mul_one]
  rw [← hPu]
  exact hmax u huW hu1

end HamiltonsCubic.L217Op
