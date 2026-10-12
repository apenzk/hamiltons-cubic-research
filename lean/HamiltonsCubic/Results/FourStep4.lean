import Mathlib
import HamiltonsCubic.Results.FourPi
import HamiltonsCubic.Results.L66Weyl

set_option linter.style.longLine false

/-!
# L220 step 4: `L_r ν = 0`, so `L_q ν = ½θν`

[findings/second-order.md](../../../findings/second-order.md), Lemma L220, step 4: *$L_r\nu=0$. $L_r\nu\in V_Q$, and
$\langle L_r\nu,\nu'\rangle=\langle r,\nu\circ\nu'\rangle=0$ for $\nu'\in V_Q$, as $\nu\circ\nu'\in\Pi_Q\perp r$. So $L_q\nu=\tfrac\theta2\nu$.*

* `PiQ_lin`: $\Pi_Q$ is linear in its three values; `PiQ_closed`, the product of two elements of $\Pi_Q$ stays in $\Pi_Q$; `Dnu_mem`, $D\circ\nu\in V_Q$, Weyl of character $\chi_Q$;
* **`mixed_sq`**: $\nu\circ\nu'\in\Pi_Q$ for $\nu,\nu'\in V_Q$, by polarising FourProd's `nu_sq`;
* `inner_fox_move`: $\langle a\circ b,c\rangle=\langle a,b\circ c\rangle$ at self-adjoint $a,b,c$, from `foxTri2`'s symmetries;
* **`Lr_zero`**: $r\circ\nu=0$ at a Weyl $r$ of character $1$ orthogonal to $\Pi_Q$ and $\nu\in V_Q$, since
  $\lVert r\circ\nu\rVert^2=\langle r,\nu\circ(r\circ\nu)\rangle=0$;
* **`Lq_eigen`**: with $D=q+r$ and step 3's $2D\circ\nu=\theta\nu$, $2q\circ\nu=\theta\nu$, for any $q$ (in L220's use $q\in\Pi_Q$).
-/

namespace HamiltonsCubic.FourStep4

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi

variable {n : ℕ} {i j k l : Fin n}

theorem PiQ_lin (a b x y z x' y' z' : ℝ) :
    a • PiQ i j k l x y z + b • PiQ i j k l x' y' z' = PiQ i j k l (a * x + b * x') (a * y + b * y') (a * z + b * z') := by
  ext p q
  simp only [PiQ, Matrix.add_apply, Matrix.smul_apply, smul_eq_mul]
  ring

/-- **`Π_Q` is closed under `∘`** (r1831 O1): with FourPi's `PiQ_mul`, the product of two elements of `Π_Q` has values
summing to zero. -/
theorem PiQ_closed {x y z x' y' z' : ℝ} (hs : x + y + z = 0) (_hs' : x' + y' + z' = 0) :
    (x * x' + y * z' + z * y') + (y * y' + z * x' + x * z') + (z * z' + x * y' + y * x') = 0 := by
  have : (x * x' + y * z' + z * y') + (y * y' + z * x' + x * z') + (z * z' + x * y' + y * x')
      = (x + y + z) * (x' + y' + z') := by ring
  rw [this, hs, zero_mul]

/-- **`D ∘ ν ∈ V_Q`** (r1831 O2): Weyl, and of character `χ_Q`. -/
theorem Dnu_mem {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hD : SignChar (fun _ => 1) D) (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) :
    IsWeyl2 (foxProd2 D ν) ∧ SignChar (setChar {i, j, k, l}) (foxProd2 D ν) :=
  ⟨isWeyl2_foxProd2 hDW hνW, Dnu_char hD hν⟩

/-- **`⟨a ∘ b, c⟩ = ⟨a, b ∘ c⟩`** at self-adjoint `a, b, c`. -/
theorem inner_fox_move {a b c : CurvOp2 (Fin n)} (ha : IsSelfAdjoint2 a) (hb : IsSelfAdjoint2 b)
    (hc : IsSelfAdjoint2 c) : innerOp2 (foxProd2 a b) c = innerOp2 a (foxProd2 b c) := by
  have h : foxTri2 a b c = foxTri2 b c a := by
    rw [foxTri2_symm_right a b c hb hc, foxTri2_comm, foxTri2_symm_right c a b ha hb, foxTri2_comm]
  unfold foxTri2 at h
  rw [h, innerOp2_comm]

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **`ν ∘ ν' ∈ Π_Q`** for `ν, ν' ∈ V_Q`. -/
theorem mixed_sq {ν ν' : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν) (hν : SignChar (setChar {i, j, k, l}) ν)
    (hν'W : IsWeyl2 ν') (hν' : SignChar (setChar {i, j, k, l}) ν') :
    ∃ x y z : ℝ, x + y + z = 0 ∧ foxProd2 ν ν' = coordOp (PiQ i j k l x y z) := by
  obtain ⟨a1, b1, c1, h1, -, hQ1⟩ := nu_sq hij hik hil hjk hjl hkl (isWeyl2_add hνW hν'W) (signChar_add hν hν')
  obtain ⟨a2, b2, c2, h2, -, hQ2⟩ := nu_sq hij hik hil hjk hjl hkl hνW hν
  obtain ⟨a3, b3, c3, h3, -, hQ3⟩ := nu_sq hij hik hil hjk hjl hkl hν'W hν'
  have hadd := L219Prod.Qop2_add ν ν'
  rw [hQ1, hQ2, hQ3] at hadd
  set X1 := 2 * a1 ^ 2 - b1 ^ 2 - c1 ^ 2
  set Y1 := 2 * b1 ^ 2 - c1 ^ 2 - a1 ^ 2
  set Z1 := 2 * c1 ^ 2 - a1 ^ 2 - b1 ^ 2
  set X2 := 2 * a2 ^ 2 - b2 ^ 2 - c2 ^ 2
  set Y2 := 2 * b2 ^ 2 - c2 ^ 2 - a2 ^ 2
  set Z2 := 2 * c2 ^ 2 - a2 ^ 2 - b2 ^ 2
  set X3 := 2 * a3 ^ 2 - b3 ^ 2 - c3 ^ 2
  set Y3 := 2 * b3 ^ 2 - c3 ^ 2 - a3 ^ 2
  set Z3 := 2 * c3 ^ 2 - a3 ^ 2 - b3 ^ 2
  refine ⟨(1 / 2) * (X1 - X2 - X3), (1 / 2) * (Y1 - Y2 - Y3), (1 / 2) * (Z1 - Z2 - Z3), by ring, ?_⟩
  have e : foxProd2 ν ν' = (1 / 2 : ℝ) • (coordOp (PiQ i j k l X1 Y1 Z1) - coordOp (PiQ i j k l X2 Y2 Z2)
      - coordOp (PiQ i j k l X3 Y3 Z3)) := by
    rw [hadd]; module
  rw [e, ← HamiltonsCubic.ItemFour.coordOp_sub, ← HamiltonsCubic.ItemFour.coordOp_sub, ← coordOp_smul']
  congr 1
  ext p q
  simp only [PiQ, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, smul_eq_mul]
  ring

/-- **L220 (4), `L_r ν = 0`**: at a Weyl `r` of character `1` orthogonal to `Π_Q` and `ν ∈ V_Q`, `r ∘ ν = 0`. -/
theorem Lr_zero {r ν : CurvOp2 (Fin n)} (hrW : IsWeyl2 r) (hr : SignChar (fun _ => 1) r)
    (hperp : ∀ x y z : ℝ, x + y + z = 0 → innerOp2 r (coordOp (PiQ i j k l x y z)) = 0)
    (hνW : IsWeyl2 ν) (hν : SignChar (setChar {i, j, k, l}) ν) : foxProd2 r ν = 0 := by
  have hwW : IsWeyl2 (foxProd2 r ν) := isWeyl2_foxProd2 hrW hνW
  have hwc : SignChar (setChar {i, j, k, l}) (foxProd2 r ν) := Dnu_char hr hν
  obtain ⟨x, y, z, hs, hm⟩ := mixed_sq hij hik hil hjk hjl hkl hνW hν hwW hwc
  apply normSq2_eq_zero
  unfold normSq2
  rw [inner_fox_move hrW.isSelfAdjoint2 hνW.isSelfAdjoint2 hwW.isSelfAdjoint2, hm, hperp x y z hs]

/-- **L220 (4), so `L_q ν = ½θν`**: with `D = q + r`, `r` as in `Lr_zero` and any `q`, `2 D ∘ ν = θν` gives `2 q ∘ ν = θν`. -/
theorem Lq_eigen {q r ν : CurvOp2 (Fin n)} {θ : ℝ} (hrW : IsWeyl2 r) (hr : SignChar (fun _ => 1) r)
    (hperp : ∀ x y z : ℝ, x + y + z = 0 → innerOp2 r (coordOp (PiQ i j k l x y z)) = 0)
    (hνW : IsWeyl2 ν) (hν : SignChar (setChar {i, j, k, l}) ν)
    (hD : (2 : ℝ) • foxProd2 (q + r) ν = θ • ν) : (2 : ℝ) • foxProd2 q ν = θ • ν := by
  rw [HamiltonsCubic.RealLayer.foxProd2_add_left, Lr_zero hij hik hil hjk hjl hkl hrW hr hperp hνW hν] at hD
  convert hD using 2
  exact (add_zero (foxProd2 q ν)).symm

end

end HamiltonsCubic.FourStep4
