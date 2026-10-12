import Mathlib
import HamiltonsCubic.Results.FourL220
import HamiltonsCubic.Results.SubFermat
import HamiltonsCubic.Results.CompChar
import HamiltonsCubic.Results.L224Eq

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L220's `n ≥ 12` clause on the operators: `P ≤ Θ` on `𝒮_Q`, with equality only on `𝒟ₙ`

[findings/second-order.md](../../../findings/second-order.md), Lemma L220: *Hence at $n\ge12$, $\sup P=\Theta_n$ on the unit
sphere of $\mathcal S_Q$, attained only on $\mathcal D_n$.* … *At $n\ge12$, $\Theta_n>\sqrt{3/2}$ (and $\Theta_{11}<\sqrt{3/2}$),
$\Theta_n$ is attained in $\mathcal D_n$ by the balanced product ([Nienhaus Proposition 2.25](problem.md)), and L57 bounds
$\mathcal D_n$, so every maximiser on $\mathcal S_Q$ has $\nu=0$.*

`SW {i,j,k,l}` is `𝒮_Q ∩ 𝒲ₙ` ([SubFermat.lean](SubFermat.lean)). A maximiser of `P` on its unit sphere exists by
compactness in `weylR`, it is critical by `L220_step1_crit`, and `L220_bound` caps its value at `√(3/2)` when its `V_Q`
component is nonzero.

* `exists_SW_maximiser`: a maximiser of `P` on the unit sphere of `𝒮_Q ∩ 𝒲ₙ` exists;
* `SW_split`: an element of `𝒮_Q ∩ 𝒲ₙ` is `D + ν` with `D` Weyl of character `1` and `ν` Weyl of character `χ_Q`;
* **`L220_sup_le`**: for any `Θ > 0` with `Θ² > 3/2` bounding `𝒟ₙ` as L57 does, `P ≤ Θ` on the unit sphere of `𝒮_Q ∩ 𝒲ₙ`,
  and **`L220_attained_diag`**: `P(W) = Θ` there forces `W` of character `1`, so `W ∈ 𝒟ₙ`;
* **`L220_n12_even`**, **`L220_n12_odd`**: the two instances, `Θ = θ₀(n)` at `n ≥ 12` through `L57_even`, and
  `Θ = √(thetaOddSq n)` at odd `n ≥ 13` through `L57_odd`.
-/

namespace HamiltonsCubic.FourN12

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourProd HamiltonsCubic.FourPi HamiltonsCubic.FourStep5
  HamiltonsCubic.BlockSub HamiltonsCubic.SubFermat HamiltonsCubic.FourL220 HamiltonsCubic.L221Ops

variable {n : ℕ} {i j k l : Fin n}

/-- **`𝒮_Q ∩ 𝒲ₙ` splits into Weyl components**: `W = D + ν`, `D` Weyl of character `1`, `ν` Weyl of character `χ_Q`. -/
theorem SW_split {W : CurvOp2 (Fin n)} (hW : W ∈ SW ({i, j, k, l} : Finset (Fin n))) :
    ∃ D ν : CurvOp2 (Fin n), IsWeyl2 D ∧ IsWeyl2 ν ∧ SignChar (fun _ => 1) D ∧
      SignChar (setChar {i, j, k, l}) ν ∧ W = D + ν := by
  obtain ⟨hWW, D, ν, hD, hν, rfl⟩ := hW
  obtain ⟨hDW, hνW⟩ := CompChar.split_weyl (m := 1) (t := fun _ => ({i, j, k, l} : Finset (Fin n)))
    (fun _ => ⟨i, by simp⟩) (fun a b h => absurd (Subsingleton.elim a b) h) (A := fun _ => ν) hWW hD
    (fun _ => hν) (by rw [Fin.sum_univ_one])
  exact ⟨D, ν, hDW, hνW 0, hD, hν, rfl⟩

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **A maximiser of `P` on the unit sphere of `𝒮_Q ∩ 𝒲ₙ` exists**, by compactness in `weylR`. -/
theorem exists_SW_maximiser :
    ∃ a : CurvOp2 (Fin n), (normSq2 a = 1 ∧ a ∈ SW ({i, j, k, l} : Finset (Fin n))) ∧
      IsMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ SW ({i, j, k, l} : Finset (Fin n))} a := by
  have : ProperSpace (weylR (Fin n)) := FiniteDimensional.proper_real _
  set f : weylR (Fin n) →ₗ[ℝ] CurvOp2 (Fin n) := RecCurv.equiv.symm.toLinearMap ∘ₗ (weylR (Fin n)).subtype with hf
  set M : Submodule ℝ (weylR (Fin n)) := (SW ({i, j, k, l} : Finset (Fin n))).comap f with hM
  have hMc : IsClosed (M : Set (weylR (Fin n))) := M.closed_of_finiteDimensional
  set K : Set (weylR (Fin n)) := weylSphere (Fin n) ∩ (M : Set (weylR (Fin n))) with hK
  have hKc : IsCompact K := by
    rw [hK, weylSphere_eq_sphere]; exact (isCompact_sphere 0 1).inter_right hMc
  -- nonempty: `q = Π_Q(1/2, -1/2, 0)` is a unit element of `𝒟ₙ`
  have hs : (1 / 2 : ℝ) + (-1 / 2) + 0 = 0 := by norm_num
  have hw := PiQ_weight hij hik hil hjk hjl hkl hs
  set q := coordOp (PiQ i j k l (1 / 2) (-1 / 2) 0) with hqdef
  have hqW : IsWeyl2 q := by rw [hqdef, coordOp_eq_restrict hw]; exact isWeyl2_restrict _
  have hq1 : normSq2 q = 1 := by rw [hqdef, normSq2_PiQ hij hik hil hjk hjl hkl]; norm_num
  have hqS : q ∈ SW ({i, j, k, l} : Finset (Fin n)) := by
    refine ⟨hqW, q, 0, ?_, signChar_zero _, (add_zero q).symm⟩
    rw [hqdef, coordOp_eq_restrict hw]
    exact (L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hw, rfl⟩
  set B : weylR (Fin n) := ⟨RecCurv.equiv q, hqW⟩
  have hBK : B ∈ K := ⟨hq1, hqS⟩
  obtain ⟨x, hx, hxmax⟩ := hKc.exists_isMaxOn ⟨B, hBK⟩ (continuous_Pcubic2_cv (ι := Fin n)).continuousOn
  refine ⟨cv x, ⟨hx.1, hx.2⟩, fun R hR => ?_⟩
  have hRW : RecCurv.equiv R ∈ weylR (Fin n) := hR.2.1
  have hy : (⟨RecCurv.equiv R, hRW⟩ : weylR (Fin n)) ∈ K := ⟨hR.1, hR.2⟩
  have h : Pcubic2 (cv ⟨RecCurv.equiv R, hRW⟩) ≤ Pcubic2 (cv x) := hxmax hy
  exact h

/-- **The critical-point step**: a unit critical `W` of `𝒮_Q ∩ 𝒲ₙ` with `P(W) = θ > 0` and `θ² > 3/2` has character `1`. -/
theorem crit_charOne {W : CurvOp2 (Fin n)} (hW1 : normSq2 W = 1) (hWS : W ∈ SW ({i, j, k, l} : Finset (Fin n)))
    (hcrit : Qop2 W = Pcubic2 W • W) (hθ : 0 < Pcubic2 W) (hθ2 : 3 / 2 < Pcubic2 W ^ 2) :
    SignChar (fun _ => 1) W := by
  obtain ⟨D, ν, hDW, hνW, hD, hν, rfl⟩ := SW_split hWS
  by_cases hν0 : ν = 0
  · rw [hν0]; convert hD using 1; exact add_zero D
  · exact absurd (L220_bound hij hik hil hjk hjl hkl hDW hD hνW hν hν0 hθ hcrit hW1) (not_le.mpr hθ2)

/-- **L220's `n ≥ 12` clause, the bound**: for any `Θ > 0` with `Θ² > 3/2` bounding `𝒟ₙ` as L57 does, `P ≤ Θ` on the
unit sphere of `𝒮_Q ∩ 𝒲ₙ`. -/
theorem L220_sup_le {Θ : ℝ} (hΘ : 0 < Θ) (hΘ2 : 3 / 2 < Θ ^ 2)
    (hL57 : ∀ w : Matrix (Fin n) (Fin n) ℝ, IsWeight w → Pcubic (diagOp w) ≤ Θ * RealLayer.norm (diagOp w) ^ 3)
    {R : CurvOp2 (Fin n)} (hR1 : normSq2 R = 1) (hRS : R ∈ SW ({i, j, k, l} : Finset (Fin n))) :
    Pcubic2 R ≤ Θ := by
  obtain ⟨a, ⟨ha1, haS⟩, hmax⟩ := exists_SW_maximiser hij hik hil hjk hjl hkl
  have hcrit := L220_step1_crit _ ha1 haS hmax.localize
  have hle : Pcubic2 R ≤ Pcubic2 a := hmax ⟨hR1, hRS⟩
  refine hle.trans ?_
  by_contra hcon
  push Not at hcon
  have hθ : 0 < Pcubic2 a := hΘ.trans hcon
  have hθ2 : 3 / 2 < Pcubic2 a ^ 2 := by nlinarith
  have h1 := crit_charOne hij hik hil hjk hjl hkl ha1 haS hcrit hθ hθ2
  have hle' := L224Eq.charOne_le hL57 haS.1 h1
  rw [ha1, Real.sqrt_one, one_pow, mul_one] at hle'
  linarith

/-- **L220's `n ≥ 12` clause, the equality**: under the same `Θ`, a unit `W ∈ 𝒮_Q ∩ 𝒲ₙ` with `P(W) = Θ` has character `1`,
so it lies in `𝒟ₙ`. -/
theorem L220_attained_diag {Θ : ℝ} (hΘ : 0 < Θ) (hΘ2 : 3 / 2 < Θ ^ 2)
    (hL57 : ∀ w : Matrix (Fin n) (Fin n) ℝ, IsWeight w → Pcubic (diagOp w) ≤ Θ * RealLayer.norm (diagOp w) ^ 3)
    {W : CurvOp2 (Fin n)} (hW1 : normSq2 W = 1) (hWS : W ∈ SW ({i, j, k, l} : Finset (Fin n))) (hP : Pcubic2 W = Θ) :
    SignChar (fun _ => 1) W := by
  have hmax : IsMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ SW ({i, j, k, l} : Finset (Fin n))} W := fun R hR => by
    show Pcubic2 R ≤ Pcubic2 W
    rw [hP]; exact L220_sup_le hij hik hil hjk hjl hkl hΘ hΘ2 hL57 hR.1 hR.2
  have hcrit := L220_step1_crit _ hW1 hWS hmax.localize
  exact crit_charOne hij hik hil hjk hjl hkl hW1 hWS hcrit (hP ▸ hΘ) (hP ▸ hΘ2)

omit hij hik hil hjk hjl hkl in
/-- **`θ₀(n)² > 3/2` at `n ≥ 12`**: `2(n-1)(n-2)/n² > 3/2` is `n(n-12) + 8 > 0`. -/
theorem theta0_sq_gt (hn : 12 ≤ n) : 3 / 2 < (Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ)) ^ 2 := by
  have hn' : (12 : ℝ) ≤ n := by exact_mod_cast hn
  have hpos : 0 ≤ 2 * ((n : ℝ) - 1) * ((n : ℝ) - 2) := by
    have h1 : 0 ≤ (n : ℝ) - 1 := by linarith
    have h2 : 0 ≤ (n : ℝ) - 2 := by linarith
    positivity
  rw [div_pow, Real.sq_sqrt hpos, lt_div_iff₀ (by positivity)]
  nlinarith

omit hij hik hil hjk hjl hkl in
/-- **`thetaOddSq n > 3/2` at `n ≥ 13`**: `2(n-1)(n-3)/((n+1)(n-2)) > 3/2` is `n(n-13) + 18 > 0`. -/
theorem thetaOdd_sq_gt (hn : 13 ≤ n) : 3 / 2 < Real.sqrt (L57Critical.thetaOddSq (n : ℝ)) ^ 2 := by
  have hn' : (13 : ℝ) ≤ n := by exact_mod_cast hn
  have hden : 0 < ((n : ℝ) + 1) * ((n : ℝ) - 2) := by
    have h1 : 0 < (n : ℝ) + 1 := by linarith
    have h2 : 0 < (n : ℝ) - 2 := by linarith
    positivity
  have hpos : 0 ≤ L57Critical.thetaOddSq (n : ℝ) := by
    unfold L57Critical.thetaOddSq
    have h1 : 0 ≤ (n : ℝ) - 1 := by linarith
    have h2 : 0 ≤ (n : ℝ) - 3 := by linarith
    positivity
  rw [Real.sq_sqrt hpos]
  unfold L57Critical.thetaOddSq
  rw [lt_div_iff₀ hden]
  nlinarith

/-- **L220's `n ≥ 12` clause at `Θ = θ₀(n)`**: on the unit sphere of `𝒮_Q ∩ 𝒲ₙ`, `P ≤ θ₀(n)`, and `P = θ₀(n)` only on `𝒟ₙ`. -/
theorem L220_n12_even (hn : 12 ≤ n) {W : CurvOp2 (Fin n)} (hW1 : normSq2 W = 1)
    (hWS : W ∈ SW ({i, j, k, l} : Finset (Fin n))) :
    Pcubic2 W ≤ Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) ∧
      (Pcubic2 W = Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / (n : ℝ) → SignChar (fun _ => 1) W) :=
  ⟨L220_sup_le hij hik hil hjk hjl hkl (L224Eq.theta0_pos (by omega)) (theta0_sq_gt hn)
      (L224Eq.L57_even (by omega)) hW1 hWS,
    L220_attained_diag hij hik hil hjk hjl hkl (L224Eq.theta0_pos (by omega)) (theta0_sq_gt hn)
      (L224Eq.L57_even (by omega)) hW1 hWS⟩

/-- **L220's `n ≥ 12` clause at odd `n`, `Θ = √(thetaOddSq n)`**: `P ≤ Θ` on the unit sphere of `𝒮_Q ∩ 𝒲ₙ`, and `P = Θ`
only on `𝒟ₙ`. -/
theorem L220_n12_odd (hn : 13 ≤ n) (hodd : ¬ Even n) {W : CurvOp2 (Fin n)} (hW1 : normSq2 W = 1)
    (hWS : W ∈ SW ({i, j, k, l} : Finset (Fin n))) :
    Pcubic2 W ≤ Real.sqrt (L57Critical.thetaOddSq (n : ℝ)) ∧
      (Pcubic2 W = Real.sqrt (L57Critical.thetaOddSq (n : ℝ)) → SignChar (fun _ => 1) W) :=
  ⟨L220_sup_le hij hik hil hjk hjl hkl (L224Eq.thetaOdd_pos (by omega)) (thetaOdd_sq_gt hn)
      (L224Eq.L57_odd (by omega) hodd) hW1 hWS,
    L220_attained_diag hij hik hil hjk hjl hkl (L224Eq.thetaOdd_pos (by omega)) (thetaOdd_sq_gt hn)
      (L224Eq.L57_odd (by omega) hodd) hW1 hWS⟩

end

end HamiltonsCubic.FourN12
