import Mathlib
import HamiltonsCubic.Results.L217Op
import HamiltonsCubic.Results.L219GenOps

set_option linter.style.longLine false

/-!
# L217 along the orbit: the `O(n)`-equivariance carrying criticality and the gap from `u` to `u'`

[findings/second-order.md](../../../findings/second-order.md), Lemma L217 applies its bound at the nearest point $u'$ of
the orbit of $u$, and needs criticality and the gap there. [L217Op.lean](L217Op.lean)'s `L217_op` and `L217_op_eq` take
both at the point they are applied to. Here they are carried from $u$ to every $u'=UuU^{\mathsf T}$, $U$ orthogonal, by
[FrameOp2.lean](FrameOp2.lean)'s invariances and [L219GenOps.lean](L219GenOps.lean)'s `Qop2_rotR`:

* `crit_rotR`, `unit_rotR`: $Q(u')=\theta u'$ and $\lVert u'\rVert=1$ at every point of the orbit of a unit critical Weyl $u$;
* `normal_rotR`, `normal_rotR_surj`: the frame change carries the unit Weyl directions $v\perp u$ onto the unit Weyl
  directions $v'\perp u'$, every one of them reached, with $T(u',v',v')=T(u,v,v)$, so the gap at $u$ along $v$ is the gap
  at $u'$ along $v'$;
* **`L217_orbit`**: at $u'=UuU^{\mathsf T}$ and $v'=UvU^{\mathsf T}$, every $W^\ast=c\,u'+s\,v'$ as in L217 maximising $P$ on the
  unit Weyl sphere has $P(W^\ast)=\theta$, from criticality and the gap stated at $u$ and $v$ alone.
-/

namespace HamiltonsCubic.L217Orbit

open Matrix HamiltonsCubic.RealLayer HamiltonsCubic.L214Op HamiltonsCubic.L217Op HamiltonsCubic.FrameOp2
  HamiltonsCubic.L219GenOps HamiltonsCubic.FrameLayer

variable {n : ℕ}

/-- **Criticality is carried along the orbit.** -/
theorem crit_rotR {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {u : CurvOp2 (Fin n)} (huW : IsWeyl2 u) {θ : ℝ}
    (hQ : Qop2 u = θ • u) : Qop2 (rotR U u) = θ • rotR U u := by
  rw [Qop2_rotR hU huW, hQ, LinearMap.map_smul]

theorem unit_rotR {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {u : CurvOp2 (Fin n)} (huW : IsWeyl2 u)
    (hu1 : normSq2 u = 1) : normSq2 (rotR U u) = 1 := by
  rw [normSq2_rotR hU huW, hu1]

/-- **A unit Weyl direction `v ⊥ u` goes to a unit Weyl direction `v' ⊥ u'` with the same gap value.** -/
theorem normal_rotR {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {u v : CurvOp2 (Fin n)} (huW : IsWeyl2 u)
    (hvW : IsWeyl2 v) (hv1 : normSq2 v = 1) (hvu : innerOp2 u v = 0) :
    IsWeyl2 (rotR U v) ∧ normSq2 (rotR U v) = 1 ∧ innerOp2 (rotR U u) (rotR U v) = 0 ∧
      Tsym (rotR U u) (rotR U v) (rotR U v) = Tsym u v v :=
  ⟨rotR_isWeyl2 hU hvW, by rw [normSq2_rotR hU hvW, hv1], by rw [innerOp2_rotR hU huW hvW, hvu],
    Tsym_rotR hU huW hvW hvW⟩

/-- **Every unit Weyl direction `v' ⊥ u'` is reached** from a unit Weyl direction `v ⊥ u`. -/
theorem normal_rotR_surj {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {u v' : CurvOp2 (Fin n)} (huW : IsWeyl2 u)
    (hv'W : IsWeyl2 v') (hv'1 : normSq2 v' = 1) (hv'u : innerOp2 (rotR U u) v' = 0) :
    ∃ v : CurvOp2 (Fin n), IsWeyl2 v ∧ normSq2 v = 1 ∧ innerOp2 u v = 0 ∧ rotR U v = v' := by
  have hUt := isOrth_transpose hU
  have hvW := rotR_isWeyl2 hUt hv'W
  refine ⟨rotR Uᵀ v', hvW, by rw [normSq2_rotR hUt hv'W, hv'1], ?_, rotR_inv hU v'⟩
  rw [← innerOp2_rotR hU huW hvW, rotR_inv hU]
  exact hv'u

/-- **L217 at every point of the orbit**, criticality and the gap stated at `u` and `v`. -/
theorem L217_orbit {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) {u v Wst : CurvOp2 (Fin n)} {θ γ s c : ℝ}
    (huW : IsWeyl2 u) (hQ : Qop2 u = θ • u) (hu1 : normSq2 u = 1) (hθ : 0 < θ)
    (hvW : IsWeyl2 v) (hv1 : normSq2 v = 1) (hvu : innerOp2 u v = 0)
    (hgap : Tsym u v v ≤ θ * (1 / 2 - γ))
    (hs0 : 0 ≤ s) (hc0 : 0 ≤ c) (hcs : c ^ 2 + s ^ 2 = 1) (hs : s ≤ 3 * γ) (hshalf : s ≤ 1 / 2)
    (hW : Wst = c • rotR U u + s • rotR U v)
    (hmax : ∀ R : CurvOp2 (Fin n), IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 Wst) :
    Pcubic2 Wst = θ := by
  obtain ⟨hv'W, hv'1, hv'u, hT⟩ := normal_rotR hU huW hvW hv1 hvu
  exact L217_op_eq (rotR_isWeyl2 hU huW) (crit_rotR hU huW hQ) (unit_rotR hU huW hu1) hθ hv'W hv'1 hv'u
    (by rw [hT]; exact hgap) hs0 hc0 hcs hs hshalf hW hmax

end HamiltonsCubic.L217Orbit
