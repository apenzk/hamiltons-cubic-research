import Mathlib
import HamiltonsCubic.Results.L120Decomp

set_option linter.style.longLine false

/-!
# L120 with L24: second order at a diagonal critical point is an eigenvalue bound per block

[findings/second-order.md](../../../findings/second-order.md), Lemma L24: the Hessian of $P$ on the sphere at a unit
critical point is $6\theta(L_e-\tfrac12)$ on $W^\perp$, so at $\theta>0$ second-order optimality is
$\langle L_ev,v\rangle\le\tfrac12\lVert v\rVert^2$ there. Lemma L120 makes that checkable block by block.
[L120Decomp.lean](L120Decomp.lean)'s `hess_blocks` states it for the Hessian form; this file states it in L24's
eigenvalue form:

* `hessQ_eq_Le`: $\mathrm{hessQ}(v)=6\theta\,(\langle L_ev,v\rangle-\tfrac12\lVert v\rVert^2)$ on $W^\perp$;
* **`eigen_blocks`**: at a $\Gamma$-fixed unit critical Weyl $a$ with $\theta=P(a)>0$,
  $\langle L_ev,v\rangle\le\tfrac12\lVert v\rVert^2$ on all of $W^\perp$ exactly when it holds on every sign-isotypic block.
-/

namespace HamiltonsCubic.L120Eigen

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L120Decomp

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The Hessian form in L24's eigenvalue form.** -/
theorem hessQ_eq_Le {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (v : weylPerpR a) :
    hessQ a (tanV v) = 6 * Pcubic2 a * (innerOp2 (LeLin a (tanV v)) (tanV v) - (1 / 2) * normSq2 (tanV v)) := by
  rw [hessQ_op ha hWa hcrit hθ, hessOp_apply, innerOp2_smul_left, innerOp2_sub_left', innerOp2_smul_left]
  rfl

theorem hessQ_nonpos_iff {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : 0 < Pcubic2 a) (v : weylPerpR a) :
    hessQ a (tanV v) ≤ 0 ↔ innerOp2 (LeLin a (tanV v)) (tanV v) ≤ (1 / 2) * normSq2 (tanV v) := by
  rw [hessQ_eq_Le ha hWa hcrit hθ.ne' v]
  constructor
  · intro h
    by_contra hc
    push Not at hc
    have : 0 < 6 * Pcubic2 a * (innerOp2 (LeLin a (tanV v)) (tanV v) - (1 / 2) * normSq2 (tanV v)) :=
      mul_pos (by linarith) (by linarith)
    linarith
  · intro h
    exact mul_nonpos_of_nonneg_of_nonpos (by linarith) (by linarith)

/-- **L24's criterion, block by block.** At a `Γ`-fixed unit critical Weyl `a` with `θ = P(a) > 0`, `⟨L_e v, v⟩ ≤ ½‖v‖²`
holds on all of `W^⊥` exactly when it holds on every sign-isotypic block. -/
theorem eigen_blocks {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : 0 < Pcubic2 a) (hfix : SignChar (fun _ => 1) a) :
    (∀ v : weylPerpR a, innerOp2 (LeLin a (tanV v)) (tanV v) ≤ (1 / 2) * normSq2 (tanV v)) ↔
      ∀ t : Finset ι, ∀ v : weylPerpR a, SignChar (setChar t) (tanV v) →
        innerOp2 (LeLin a (tanV v)) (tanV v) ≤ (1 / 2) * normSq2 (tanV v) := by
  have key := hess_blocks ha hWa hcrit hθ.ne' hfix
  simp only [hessQ_nonpos_iff ha hWa hcrit hθ] at key
  exact key

end HamiltonsCubic.L120Eigen
