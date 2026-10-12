import Mathlib
import HamiltonsCubic.Results.L219Prod
import HamiltonsCubic.Results.L24Weyl
import HamiltonsCubic.Results.SphereCurve
import HamiltonsCubic.Results.WeylMaximiser

set_option linter.style.longLine false

/-!
# L219's bound at a maximiser: $\lVert c\rVert^2\le\tfrac34$

[findings/second-order.md](../../../findings/second-order.md), Lemma L219, step 4: *on the plane $\{\alpha b+\beta c\}$ at unit
norm the two relations give $P=\tfrac\theta2(3\alpha-\alpha^3)$, which exceeds $\theta$ for $\alpha<-2$; the admissible range
reaches $\alpha=-(1-s^2)^{-1/2}$, so a global maximiser has $s^2\le\tfrac34$.* At a coordinate reflection on `CurvOp2`:

* **`odd_mass_max`**: at a unit Weyl global maximiser $W$ of $P$ with $Q(W)=\theta W$, $\theta>0$, the odd part
  $c=\tfrac12(W-\sigma W)$ has $\lVert c\rVert^2\le\tfrac34$. The line $V=\alpha b$, $\alpha=-\lVert b\rVert^{-1}$, is the
  record's $\beta=0$ end of the plane; $P(V)=\alpha^3P(b)=\tfrac\theta2(3\alpha-\alpha^3)$ by `L219_op`, and
  [L219Statement.lean](L219Statement.lean)'s `odd_mass_le` turns $P(V)\le\theta$ into $\lVert b\rVert^2\ge\tfrac14$.
  $b=0$ is excluded because it would make $P(W)=0<\theta$;
* `odd_mass_global`: at $n\ge4$ the global-maximiser hypothesis alone suffices, $Q(W)=P(W)W$ and $P(W)>0$ being derived.
-/

namespace HamiltonsCubic.L219Max

open HamiltonsCubic.RealLayer HamiltonsCubic.L214Op HamiltonsCubic.L219Op HamiltonsCubic.L219Diag

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem even_odd_orth (m : ι) (W : CurvOp2 ι) :
    innerOp2 ((1 / 2 : ℝ) • (W + sig m W)) ((1 / 2 : ℝ) • (W - sig m W)) = 0 := by
  set b : CurvOp2 ι := (1 / 2 : ℝ) • (W + sig m W) with hbdef
  set c : CurvOp2 ι := (1 / 2 : ℝ) • (W - sig m W) with hcdef
  have hb : sig m b = b := by
    rw [hbdef, LinearMap.map_smul, LinearMap.map_add, sig_sig]; congr 1; abel
  have hc : sig m c = -c := by
    have e : sig m (W - sig m W) = sig m W - W := ContinuousLinearMap.ext fun X => by
      simp only [sig_apply, ContinuousLinearMap.sub_apply, map_sub, cS_cS]
    rw [hcdef, LinearMap.map_smul, e]; module
  have e := innerOp2_sig m b c
  have hneg : innerOp2 b (-c) = -innerOp2 b c := by
    rw [show -c = (-1 : ℝ) • c by module, innerOp2_smul_right]; ring
  rw [hb, hc, hneg] at e
  linarith

/-- **L219's bound at a maximiser, at a coordinate reflection.** -/
theorem odd_mass_max (m : ι) (W : CurvOp2 ι) (hW : IsWeyl2 W) (hW1 : normSq2 W = 1) {θ : ℝ}
    (hQ : Qop2 W = θ • W) (hθ : 0 < θ)
    (hmax : ∀ R : CurvOp2 ι, IsWeyl2 R → normSq2 R = 1 → Pcubic2 R ≤ Pcubic2 W) :
    normSq2 ((1 / 2 : ℝ) • (W - sig m W)) ≤ 3 / 4 := by
  have hWs : IsSelfAdjoint2 W := hW.isSelfAdjoint2
  obtain ⟨_, hPb, _, hPW⟩ := L219_op m W hWs hQ
  set b : CurvOp2 ι := (1 / 2 : ℝ) • (W + sig m W) with hbdef
  set c : CurvOp2 ι := (1 / 2 : ℝ) • (W - sig m W) with hcdef
  have hbc : b + c = W := by rw [hbdef, hcdef]; module
  have horth : innerOp2 b c = 0 := even_odd_orth m W
  have hnorm : normSq2 b + normSq2 c = 1 := by
    have e : normSq2 (b + c) = normSq2 b + normSq2 c := by
      unfold normSq2
      rw [innerOp2_add_left, innerOp2_add_right, innerOp2_add_right, horth, innerOp2_comm c b, horth]
      ring
    rw [← e, hbc, hW1]
  have hPWθ : Pcubic2 W = θ := by
    rw [← Tsym_diag, Tsym_crit hWs hQ, show innerOp2 W W = normSq2 W from rfl, hW1, mul_one]
  have hb0 : 0 < normSq2 b := by
    rcases (normSq2_nonneg b).lt_or_eq with h | h
    · exact h
    · exfalso
      have hb : b = 0 := normSq2_eq_zero h.symm
      rw [hb] at hPW
      have h0 : Pcubic2 (0 : CurvOp2 ι) = 0 := by
        have := Pcubic2_smul 0 (0 : CurvOp2 ι)
        rw [show (0 : ℝ) • (0 : CurvOp2 ι) = 0 by module] at this
        rw [this]; ring
      have hT0 : Tsym (0 : CurvOp2 ι) c c = 0 := by
        have := Tsym_smul_left 0 (0 : CurvOp2 ι) c c
        rw [show (0 : ℝ) • (0 : CurvOp2 ι) = 0 by module] at this
        rw [this]; ring
      rw [h0, hT0] at hPW
      linarith
  set t := normSq2 b with htdef
  set α : ℝ := -(Real.sqrt t)⁻¹ with hαdef
  have hst : 0 < Real.sqrt t := Real.sqrt_pos.mpr hb0
  have hs2 : Real.sqrt t ^ 2 = t := Real.sq_sqrt hb0.le
  have hα : α < 0 := by rw [hαdef]; exact neg_neg_of_pos (inv_pos.mpr hst)
  have hαt : α ^ 2 * t = 1 := by
    rw [hαdef, neg_sq, inv_pow, hs2, inv_mul_cancel₀ hb0.ne']
  have hVW : IsWeyl2 (α • b) := isWeyl2_smul α (even_odd_isWeyl2 m hW).1
  have hV1 : normSq2 (α • b) = 1 := by rw [normSq2_smul, hαt]
  have hV := hmax (α • b) hVW hV1
  rw [Pcubic2_smul, hPb, hPWθ] at hV
  have hc2 : normSq2 c = 1 - t := by linarith
  rw [hc2] at hV
  have hplane : θ * (3 * α - α ^ 3) / 2 ≤ θ := by
    have e : α ^ 3 * (θ * (t - (1 - t) / 2)) = θ * (3 * α - α ^ 3) / 2 := by
      have h3 : α ^ 3 * t = α := by
        calc α ^ 3 * t = α * (α ^ 2 * t) := by ring
          _ = α := by rw [hαt, mul_one]
      linear_combination (3 / 2 * θ) * h3
    linarith
  have ht := HamiltonsCubic.L219Statement.odd_mass_le θ t α hθ hα hαt hplane
  linarith

/-- **The record's hypothesis set**: at `n ≥ 4`, a global maximiser of `P` on the unit Weyl sphere alone gives
`‖c‖² ≤ ¾`, `Q(W) = P(W) W` by Fermat (`Qop2_eq_smul_weyl`) and `P(W) ≥ √(3/2) > 0` by the maximiser's own competitor
(`exists_weyl_maximiser`). -/
theorem odd_mass_global {n : ℕ} (hn : 4 ≤ n) (m : Fin n) (W : CurvOp2 (Fin n)) (hW : W ∈ weylSphereSet (Fin n))
    (hmax : IsMaxOn Pcubic2 (weylSphereSet (Fin n)) W) :
    normSq2 ((1 / 2 : ℝ) • (W - sig m W)) ≤ 3 / 4 := by
  have hQ := Qop2_eq_smul_weyl hW.1 hW.2 hmax.localize
  obtain ⟨a, ha, -, hpa⟩ := exists_weyl_maximiser hn
  have hθ : 0 < Pcubic2 W := by
    have h1 : Pcubic2 a ≤ Pcubic2 W := hmax ha
    have h2 : 0 < Real.sqrt (3 / 2) := Real.sqrt_pos.mpr (by norm_num)
    linarith
  exact odd_mass_max m W hW.2 hW.1 hQ hθ fun R hR hR1 => hmax ⟨hR1, hR⟩

end HamiltonsCubic.L219Max
