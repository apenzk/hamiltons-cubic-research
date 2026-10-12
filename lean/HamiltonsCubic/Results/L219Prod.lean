import Mathlib
import HamiltonsCubic.Results.L219Diag
import HamiltonsCubic.Results.L24Eigen

set_option linter.style.longLine false

/-!
# L219's operator identities: $b\circ b+c\circ c=\theta b$ and $2\,b\circ c=\theta c$

[findings/second-order.md](../../../findings/second-order.md), Lemma L219: *if $Q(W)=\theta W$, then
$b\circ b+c\circ c=\theta b$ and $2\,b\circ c=\theta c$*, from $\sigma(x\circ y)=\sigma x\circ\sigma y$. At a coordinate
reflection on `CurvOp2`:

* `sharp_sig`, `Qop2_sig`: the reflection commutes with $\#$ and so with $Q$, the first by duality from
  [L219Op.lean](L219Op.lean)'s `phiTri_sig`, since $\langle S,R^\#\rangle=-\tfrac12\Phi(S;R,R)$;
* **`L219_ops`**: at $Q(W)=\theta W$ with $b,c=\tfrac12(W\pm\sigma W)$, $Q(b)+Q(c)=\theta b$ and $2\,b\circ c=\theta c$, where
  $b\circ c$ is `foxProd2 b c` and $Q(x)=x\circ x$ (`foxProd2_self`): $Q(b\pm c)$ expand as $Q(b)+Q(c)\pm2\,b\circ c$, and
  $Q(b-c)=Q(\sigma W)=\theta(b-c)$.
-/

namespace HamiltonsCubic.L219Prod

open HamiltonsCubic.RealLayer HamiltonsCubic.L219Op

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem innerOp2_sig_left (m : ι) (S X : CurvOp2 ι) : innerOp2 (sig m S) X = innerOp2 S (sig m X) := by
  rw [← innerOp2_sig m (sig m S) X, sig_sig]

/-- **The reflection commutes with `#`.** -/
theorem sharp_sig (m : ι) (R : CurvOp2 ι) : sharpMapCL (sig m R) = sig m (sharpMapCL R) :=
  eq_of_innerOp2 fun S => by
    rw [← innerOp2_sig_left, innerOp2_sharpMap_eq_phiTri, innerOp2_sharpMap_eq_phiTri,
      ← phiTri_sig m (sig m S) R R, sig_sig]

/-- **… and so with `Q`.** -/
theorem Qop2_sig (m : ι) (R : CurvOp2 ι) : Qop2 (sig m R) = sig m (Qop2 R) := by
  unfold Qop2 compOp2
  rw [sig_comp, sharp_sig, ← LinearMap.map_add]

theorem Qop2_add (x y : CurvOp2 ι) : Qop2 (x + y) = Qop2 x + Qop2 y + (2 : ℝ) • foxProd2 x y := by
  unfold foxProd2
  module

theorem Qop2_sub (x y : CurvOp2 ι) : Qop2 (x - y) = Qop2 x + Qop2 y - (2 : ℝ) • foxProd2 x y := by
  have e : x - y = x + (-1 : ℝ) • y := by module
  rw [e, Qop2_add, Qop2_smul, foxProd2_smul_right]
  module

/-- **L219's operator identities at a coordinate reflection.** -/
theorem L219_ops (m : ι) (W : CurvOp2 ι) {θ : ℝ} (hQ : Qop2 W = θ • W) :
    Qop2 ((1 / 2 : ℝ) • (W + sig m W)) + Qop2 ((1 / 2 : ℝ) • (W - sig m W)) = θ • ((1 / 2 : ℝ) • (W + sig m W)) ∧
      (2 : ℝ) • foxProd2 ((1 / 2 : ℝ) • (W + sig m W)) ((1 / 2 : ℝ) • (W - sig m W))
        = θ • ((1 / 2 : ℝ) • (W - sig m W)) := by
  set b : CurvOp2 ι := (1 / 2 : ℝ) • (W + sig m W) with hbdef
  set c : CurvOp2 ι := (1 / 2 : ℝ) • (W - sig m W) with hcdef
  have hbc : b + c = W := by rw [hbdef, hcdef]; module
  have hbmc : b - c = sig m W := by rw [hbdef, hcdef]; module
  have hσ : Qop2 (sig m W) = θ • sig m W := by rw [Qop2_sig, hQ, LinearMap.map_smul]
  have E1 : θ • (b + c) = Qop2 b + Qop2 c + (2 : ℝ) • foxProd2 b c := by
    rw [← Qop2_add, hbc, hQ]
  have E2 : θ • (b - c) = Qop2 b + Qop2 c - (2 : ℝ) • foxProd2 b c := by
    rw [← Qop2_sub, hbmc, hσ]
  refine ⟨?_, ?_⟩
  · calc Qop2 b + Qop2 c
        = (1 / 2 : ℝ) • ((Qop2 b + Qop2 c + (2 : ℝ) • foxProd2 b c) + (Qop2 b + Qop2 c - (2 : ℝ) • foxProd2 b c)) := by
          module
      _ = (1 / 2 : ℝ) • (θ • (b + c) + θ • (b - c)) := by rw [← E1, ← E2]
      _ = θ • b := by module
  · calc (2 : ℝ) • foxProd2 b c
        = (1 / 2 : ℝ) • ((Qop2 b + Qop2 c + (2 : ℝ) • foxProd2 b c) - (Qop2 b + Qop2 c - (2 : ℝ) • foxProd2 b c)) := by
          module
      _ = (1 / 2 : ℝ) • (θ • (b + c) - θ • (b - c)) := by rw [← E1, ← E2]
      _ = θ • c := by module

end HamiltonsCubic.L219Prod
