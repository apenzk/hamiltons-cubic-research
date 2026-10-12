import HamiltonsCubic.Results.L66Weyl
import HamiltonsCubic.Results.L234Split
import HamiltonsCubic.Results.CP2Real

set_option linter.style.longLine false

/-!
# L66 without the hypothesis `M(n) > 0`

[findings/support-dichotomy.md](../../../findings/support-dichotomy.md), Lemma L66, takes
`M(n) > 0` from Nienhaus's Proposition 2.25. [L66Weyl.lean](L66Weyl.lean) proves L66 with it as a
hypothesis. **This file discharges it at every `n ≥ 4`** with the padded `ℂP²` operator
[CP2Real.lean](CP2Real.lean)'s `Wc n`, a unit Weyl operator with `P = √(3/2)`:

- `Wc_isLinOp`: `Wc n` is linear;
- `Pcubic2_restrict_Wc` and `normSq2_restrict_Wc`: carried to `CurvOp2` by `restrict`, it has
  `P = √(3/2)` and unit norm;
- `Pcubic_Wc`: `P(Wc n) = √(3/2)`;
- `L66_weyl_n4`: **for `n ≥ 4`, a Weyl `W` attaining an upper bound `M` of `P` on the unit Weyl
  sphere is not `∘`-decomposable**, with `M ≥ √(3/2) > 0` supplied rather than assumed. `W` need
  not have unit norm, which generalises the record.
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.L66Statement HamiltonsCubic.TensorBridge HamiltonsCubic.CP2Real

variable {n : ℕ}

theorem Wc_isLinOp : IsLinOp (Wc n) := by
  constructor
  · intro X Y
    unfold Wc
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [FamilyLayer.inner2_add_left, mul_add, add_smul]
  · intro c X
    unfold Wc
    rw [Finset.smul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [FamilyLayer.inner2_smul_left, smul_smul]; ring_nf

theorem restrict_eq_restrictLin (hn : 4 ≤ n) :
    restrict (Wc_weyl hn) = restrictLin Wc_isLinOp (Wc_weyl hn).1 :=
  ContinuousLinearMap.ext fun _ => rfl

/-- `P` of the restriction is `P` of `Wc n`. -/
theorem Pcubic2_restrict_Wc (hn : 4 ≤ n) : Pcubic2 (restrict (Wc_weyl hn)) = Pcubic (Wc n) := by
  rw [restrict_eq_restrictLin hn, Pcubic2_eq_innerOp2, innerOp2_comm, ← foxProd2_self]
  have h := foxTri_eq_foxTri2_restrictLin Wc_isLinOp (Wc_weyl hn).1 Wc_isLinOp (Wc_weyl hn).1
    Wc_isLinOp (Wc_weyl hn).1
  rw [foxTri_self _ Wc_isLinOp] at h
  rw [h]; rfl

/-- The norm of the restriction is that of `Wc n`. -/
theorem normSq2_restrict_Wc (hn : 4 ≤ n) : normSq2 (restrict (Wc_weyl hn)) = normSq (Wc n) := by
  rw [← normSq_extend, restrict_eq_restrictLin hn]
  unfold normSq innerOp
  refine congrArg (fun x => (1 / 2 : ℝ) * x) ?_
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [extend_restrictLin_on_skew _ _ _ (phi_isSkew i j)]

/-- **`P(Wc n) = √(3/2)`.** -/
theorem Pcubic_Wc (hn : 4 ≤ n) : Pcubic (Wc n) = Real.sqrt (3 / 2) := by
  obtain ⟨_, hc, hs⟩ := Wc_values hn
  rw [Pcubic, hc, hs, sqrt32]; ring

/-- **L66 AT EVERY `n ≥ 4`, WITH `M(n) > 0` PROVED.** -/
theorem L66_weyl_n4 (hn : 4 ≤ n) (M : ℝ)
    (hM : ∀ B : weylR (Fin n), normSq2 (cv B) = 1 → Pcubic2 (cv B) ≤ M)
    (W : weylR (Fin n)) (hmax : Pcubic2 (cv W) = M) :
    ¬ IsCircDecompWeyl W := by
  set B : weylR (Fin n) := ⟨show RecCurv (Fin n) from restrict (Wc_weyl hn), isWeyl2_restrict _⟩
  have hB1 : normSq2 (cv B) = 1 := by
    show normSq2 (restrict (Wc_weyl hn)) = 1
    rw [normSq2_restrict_Wc hn]; exact (Wc_values hn).1
  have hBP : Pcubic2 (cv B) = Real.sqrt (3 / 2) := by
    show Pcubic2 (restrict (Wc_weyl hn)) = _
    rw [Pcubic2_restrict_Wc hn, Pcubic_Wc hn]
  have hMpos : 0 < M := lt_of_lt_of_le (by positivity) (hBP ▸ hM B hB1)
  exact L66_weyl M hMpos hM W hmax

end HamiltonsCubic.RealLayer
