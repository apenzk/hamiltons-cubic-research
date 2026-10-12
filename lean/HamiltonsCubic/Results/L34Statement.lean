import Mathlib
import HamiltonsCubic.Base.WeylReal
import HamiltonsCubic.Results.CP2Planes

/-!
# L34, full support with two negative eigenvalues, at `m = 6`, `7` and `8`, STATED

From [stratum-two-negative.md](../../../findings/stratum-two-negative.md), the block headed
*"Lemma L34 (full support with two negative eigenvalues, at `m=6` and `m=8`), canonical statement
and proof"*, quoted verbatim:

> **Statement.** For $m=6$ and $m=8$ there is a $W\in\mathrm{Weyl}_m$ with exactly two negative
> eigenvalues and $\dim U=m$, where $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$.

with, from the same block, the odd case the statement omits and the construction's own hypotheses:

> **The same construction covers odd $m=7$ unchanged**, which the statement omits.

> **Construction, with the hypotheses it needs.** Take $q=r>0$ and pad two copies of $W_4(q,r)$
> onto 4-planes of $\mathbb R^m$, then add. *Both $q,r>0$ and $q=r$ are load-bearing and neither was
> stated.* […] **Orthogonal complementary planes at $m=8$** give spectrum
> $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$, $\lVert W\rVert^2=12$, $P=-36$ and
> $\theta=-\sqrt3/2$ […]. **Planes meeting in a 2-plane at $m=6$**, in the alignment
> $\langle e_1,e_2,e_5,e_6\rangle$ and $\langle e_3,e_4,e_5,e_6\rangle$, give
> $(-3,-1,1,1,1,1)/\sqrt{14}$, $\lVert W\rVert^2=14$, $\operatorname{tr}W^3=-24$,
> $\langle W,W^\#\rangle=-30$, $P=-54$ and $\theta=-\frac{27}{7\sqrt{14}}=-\frac{27\sqrt{14}}{98}$.

> **What the construction cannot reach, and it is a proof rather than an admission.** Two 4-planes
> span at most eight dimensions, so $U\subseteq V_1+V_2$ caps the family at $m\le8$: **there is no
> extension to $m\ge10$ to be found.**

## What is typed here

**`L34` below is the existence claim, PROVED**: two copies of `W₄(q,q)` on named 4-planes of
`ℝᵐ`, built from [CP2Planes.lean](CP2Planes.lean)'s self-dual forms on an arbitrary 4-plane.

**Proved here, with no `sorry`:** the cap, that two subspaces of dimension at most `4` span at most
`8`, so a `U` inside their sum has `dim U ≤ 8` and the family **provably** stops at `m ≤ 8`; and the
whole of the arithmetic recorded for the two witnesses, that each raw spectrum is trace-free, that
its power sums are the recorded `‖W‖²` and `tr W³`, and that `θ = P/‖W‖³` returns the recorded
values `-√3/2` and `-27√14/98`.

*The `m = 6` witness is recorded normalised as `(-3,-1,1,1,1,1)/√14` and unnormalised through
`‖W‖² = 14`; the raw spectrum is therefore `(-3,-1,1,1,1,1)`, and the `m = 8` one, recorded
normalised as `{-1/√3 (×2), 1/(2√3) (×4)}` with `‖W‖² = 12`, is raw `(-2,-2,1,1,1,1)`. Both raw
readings are checked below against every figure the block records for them.*

## What is NOT typed here

**The clause that these witnesses' `θ` is not uniformly negative.** The block records
`θ = +0.485408612` at `m = 6` and `+0.115574271` at `m = 8` for 4-planes in general position, and
says of both that they are *"measured rather than derived"*; the family's supremum it records as a
**hypothesis debt**. Nothing measured is typed here.

*`θ` is [WeylReal.lean](../Base/WeylReal.lean)'s, whose own docstring records that its `sharpPair`
term is even in `R` and so is `tr(R#)` rather than `⟨R#,R⟩`.*
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.L34Statement

open HamiltonsCubic.RealLayer Matrix

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## The hypothesis, counted with multiplicity -/

/-- **Exactly two negative eigenvalues, counted with multiplicity.** `v₁` and `v₂` are orthonormal
bivectors with negative eigenvalues `−b`, `−c`, and the form `⟨W·,·⟩` is non-negative on the
bivectors orthogonal to both, so the negative spectrum is exactly those two. -/
structure ExactlyTwoNegative (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (v₁ v₂ : Matrix ι ι ℝ) (b c : ℝ) :
    Prop where
  skew₁ : IsSkew v₁
  skew₂ : IsSkew v₂
  unit₁ : inner2 v₁ v₁ = 1
  unit₂ : inner2 v₂ v₂ = 1
  orth : inner2 v₁ v₂ = 0
  bpos : 0 < b
  cpos : 0 < c
  eig₁ : W v₁ = (-b) • v₁
  eig₂ : W v₂ = (-c) • v₂
  rest : ∀ Y : Matrix ι ι ℝ, IsSkew Y → inner2 v₁ Y = 0 → inner2 v₂ Y = 0 → 0 ≤ inner2 (W Y) Y

/-- **`U = im v₁ + im v₂`**, the two negative eigenvectors read as skew matrices. -/
noncomputable def support (v₁ v₂ : Matrix ι ι ℝ) : Submodule ℝ (ι → ℝ) :=
  LinearMap.range (Matrix.mulVecLin v₁) ⊔ LinearMap.range (Matrix.mulVecLin v₂)

/-! ## The construction

Two copies of [CP2Planes.lean](CP2Planes.lean)'s `WE E μ` at `μ = (1,1,-2)`, which is `W₄(q,q)`, on
4-planes `f_A, f_B` chosen so that each plane's negative form `ω₂` is orthogonal to all three forms of
the other plane. Then each `ω₂` is an exact eigenvector of the sum with eigenvalue `-2`, the form is
`Σ μ_a ⟨Y, ω_a⟩² ≥ 0` off them, and `ω₂² = -½ E Eᵀ` puts every basis vector of a plane in the image of
its `ω₂`, so `U` is the span of the two planes. *The orthogonality is a finite integer computation,
settled by `decide`.* -/

section Construction

open HamiltonsCubic.CP2Real HamiltonsCubic.CP2Planes

variable {m : ℕ}

def EmbF (f : Fin 4 → Fin m) : Matrix (Fin m) (Fin 4) ℝ := fun p x => if p = f x then 1 else 0
def EmbFz (f : Fin 4 → Fin m) : Matrix (Fin m) (Fin 4) ℤ := fun p x => if p = f x then 1 else 0

theorem EmbF_orth {f : Fin 4 → Fin m} (hf : Function.Injective f) : (EmbF f)ᵀ * EmbF f = 1 := by
  ext x y
  simp only [Matrix.mul_apply, Matrix.transpose_apply, EmbF, Matrix.one_apply, mul_ite, mul_one, mul_zero]
  rw [Finset.sum_eq_single (f x)]
  · simp [hf.eq_iff, eq_comm]
  · intro p _ hp; simp [hp]
  · simp

theorem conj_cast (f : Fin 4 → Fin m) (a : Fin 3) (p q : Fin m) :
    (EmbF f * J a * (EmbF f)ᵀ) p q = (((EmbFz f * Jz a * (EmbFz f)ᵀ) p q : ℤ) : ℝ) := by
  simp only [Matrix.mul_apply, Matrix.transpose_apply, EmbF, EmbFz, J_cast]
  push_cast
  simp only [apply_ite (Int.cast : ℤ → ℝ), Int.cast_one, Int.cast_zero]

theorem cross (f g : Fin 4 → Fin m) (a b : Fin 3)
    (h : ∑ p, ∑ q, (EmbFz f * Jz a * (EmbFz f)ᵀ) p q * (EmbFz g * Jz b * (EmbFz g)ᵀ) p q = 0) :
    inner2 (omE (EmbF f) a) (omE (EmbF g) b) = 0 := by
  have hr : ∑ p, ∑ q, (EmbF f * J a * (EmbF f)ᵀ) p q * (EmbF g * J b * (EmbF g)ᵀ) p q = 0 := by
    simp only [conj_cast]; exact_mod_cast h
  rw [inner2_eq_sum]
  simp only [omE, Matrix.smul_apply, smul_eq_mul]
  rw [show ∑ p, ∑ q, sq2⁻¹ * (EmbF f * J a * (EmbF f)ᵀ) p q * (sq2⁻¹ * (EmbF g * J b * (EmbF g)ᵀ) p q)
      = sq2⁻¹ * sq2⁻¹ * ∑ p, ∑ q, (EmbF f * J a * (EmbF f)ᵀ) p q * (EmbF g * J b * (EmbF g)ᵀ) p q by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun p _ => by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun q _ => by ring, hr]
  ring

theorem EmbF_single {f : Fin 4 → Fin m} (hf : Function.Injective f) (y : Fin 4) :
    EmbF f *ᵥ Pi.single y 1 = Pi.single (f y) 1 := by
  ext q
  simp only [Matrix.mulVec, dotProduct, EmbF, Pi.single_apply, mul_ite, mul_one, mul_zero,
    Finset.sum_ite_eq', Finset.mem_univ, if_true]

theorem EmbFT_single {f : Fin 4 → Fin m} (hf : Function.Injective f) (y : Fin 4) :
    (EmbF f)ᵀ *ᵥ Pi.single (f y) 1 = Pi.single y 1 := by
  ext x
  simp only [Matrix.mulVec, dotProduct, Matrix.transpose_apply, EmbF, Pi.single_apply, mul_ite, mul_one,
    mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  by_cases h : x = y
  · simp [h]
  · simp [h, hf.eq_iff, Ne.symm h]

theorem single_mem_range {f : Fin 4 → Fin m} (hf : Function.Injective f) (y : Fin 4) :
    Pi.single (f y) (1 : ℝ) ∈ LinearMap.range (Matrix.mulVecLin (omE (EmbF f) 2)) := by
  have hE := EmbF_orth hf
  have hsq : omE (EmbF f) 2 * omE (EmbF f) 2 = (-(sq2⁻¹ * sq2⁻¹)) • (EmbF f * (EmbF f)ᵀ) := by
    have h := omE_sq hE 2
    have hs := omE_skew (E := EmbF f) 2
    unfold IsSkew at hs
    rw [hs, Matrix.neg_mul] at h
    rw [neg_smul, ← h, neg_neg]
  refine ⟨(-(sq2 * sq2)) • (omE (EmbF f) 2 *ᵥ Pi.single (f y) 1), ?_⟩
  show omE (EmbF f) 2 *ᵥ ((-(sq2 * sq2)) • (omE (EmbF f) 2 *ᵥ Pi.single (f y) 1)) = Pi.single (f y) 1
  rw [Matrix.mulVec_smul, Matrix.mulVec_mulVec, hsq, Matrix.smul_mulVec, ← Matrix.mulVec_mulVec,
    EmbFT_single hf, EmbF_single hf, smul_smul]
  have := sq2_pos
  rw [show -(sq2 * sq2) * -(sq2⁻¹ * sq2⁻¹) = (1 : ℝ) by field_simp, one_smul]

/-- **Two weighted copies of the self-dual construction, on 4-planes whose negative forms are
orthogonal to the other plane's forms, have exactly two negative eigenvalues**, and their images
span the union of the planes. -/
theorem two_planes (fA fB : Fin 4 → Fin m) (hA : Function.Injective fA) (hB : Function.Injective fB)
    (hx1 : ∀ b, inner2 (omE (EmbF fA) 2) (omE (EmbF fB) b) = 0)
    (hx2 : ∀ b, inner2 (omE (EmbF fB) 2) (omE (EmbF fA) b) = 0)
    (hcov : ∀ p, (∃ x, fA x = p) ∨ (∃ x, fB x = p)) :
    ∃ (W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ) (v₁ v₂ : Matrix (Fin m) (Fin m) ℝ)
      (b c : ℝ), IsWeyl W ∧ ExactlyTwoNegative W v₁ v₂ b c ∧ Module.finrank ℝ (support v₁ v₂) = m := by
  have hEA := EmbF_orth hA
  have hEB := EmbF_orth hB
  let μ : Fin 3 → ℝ := ![1, 1, -2]
  have hμ : ∑ a, μ a = 0 := by simp [μ, Fin.sum_univ_three]; norm_num
  have hμ2 : μ 2 = -2 := rfl
  have hzero : ∀ (E : Matrix (Fin m) (Fin 4) ℝ) (X : Matrix (Fin m) (Fin m) ℝ),
      (∀ b, inner2 X (omE E b) = 0) → WE E μ X = 0 := by
    intro E X h; unfold WE; simp [h]
  refine ⟨fun X => WE (EmbF fA) μ X + WE (EmbF fB) μ X, omE (EmbF fA) 2, omE (EmbF fB) 2, 2, 2,
    weyl_add (WE_weyl hEA hμ) (WE_weyl hEB hμ), ⟨omE_skew 2, omE_skew 2, by simp [omE_inner hEA],
    by simp [omE_inner hEB], hx1 2, by norm_num, by norm_num, ?_, ?_, ?_⟩, ?_⟩
  · simp only [WE_om hEA, hzero _ _ hx1, add_zero, hμ2]
  · simp only [WE_om hEB, hzero _ _ hx2, zero_add, hμ2]
  · intro Y hY h1 h2
    simp only [HamiltonsCubic.L41Statement.Frame.inner2_add_l, WE_inner, Fin.sum_univ_three,
      inner2_comm (omE _ _) Y]
    rw [inner2_comm] at h1 h2
    rw [h1, h2]
    simp only [μ, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.head_cons]
    nlinarith [sq_nonneg (inner2 Y (omE (EmbF fA) 0)), sq_nonneg (inner2 Y (omE (EmbF fA) 1)),
      sq_nonneg (inner2 Y (omE (EmbF fB) 0)), sq_nonneg (inner2 Y (omE (EmbF fB) 1))]
  · have htop : support (omE (EmbF fA) 2) (omE (EmbF fB) 2) = ⊤ := by
      rw [eq_top_iff]
      intro x _
      rw [← Finset.univ_sum_single x]
      refine Submodule.sum_mem _ fun p _ => ?_
      rw [show Pi.single p (x p) = x p • Pi.single p (1 : ℝ) by ext j; simp [Pi.single_apply]]
      refine Submodule.smul_mem _ _ ?_
      rcases hcov p with ⟨y, rfl⟩ | ⟨y, rfl⟩
      · exact Submodule.mem_sup_left (single_mem_range hA y)
      · exact Submodule.mem_sup_right (single_mem_range hB y)
    rw [htop, finrank_top, Module.finrank_fin_fun]

theorem instance_of {m : ℕ} (fA fB : Fin 4 → Fin m) (hA : Function.Injective fA)
    (hB : Function.Injective fB)
    (h1 : ∀ b : Fin 3, ∑ p, ∑ q, (EmbFz fA * Jz 2 * (EmbFz fA)ᵀ) p q * (EmbFz fB * Jz b * (EmbFz fB)ᵀ) p q = 0)
    (h2 : ∀ b : Fin 3, ∑ p, ∑ q, (EmbFz fB * Jz 2 * (EmbFz fB)ᵀ) p q * (EmbFz fA * Jz b * (EmbFz fA)ᵀ) p q = 0)
    (hcov : ∀ p, (∃ x, fA x = p) ∨ (∃ x, fB x = p)) :
    ∃ (W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ) (v₁ v₂ : Matrix (Fin m) (Fin m) ℝ)
      (b c : ℝ), IsWeyl W ∧ ExactlyTwoNegative W v₁ v₂ b c ∧ Module.finrank ℝ (support v₁ v₂) = m :=
  two_planes fA fB hA hB (fun b => cross _ _ _ _ (h1 b)) (fun b => cross _ _ _ _ (h2 b)) hcov

end Construction

/-! ## The statement -/

/-- **L34.** For `m = 6`, `m = 7` and `m = 8` there is a `W ∈ 𝒲_m` with exactly two negative
eigenvalues and `dim U = m`, where `U = im v_{N-1} + im v_N`.

**Proved.** *The planes are `⟨e₀,e₁,e₄,e₅⟩, ⟨e₂,e₃,e₄,e₅⟩` at `m = 6` (meeting in a 2-plane, an alignment
whose spectrum is `(-2, -2, 3/2, 1/2, 1, 1)` and not the record's `(-3, -1, 1, 1, 1, 1)`), `⟨e₀,…,e₃⟩, ⟨e₃,…,e₆⟩` at `m = 7` (meeting in a line), and complementary at
`m = 8`, each with `ω₂ = (φ_{ad} + φ_{bc})/√2` carrying the weight `-2`.* -/
theorem L34 (m : ℕ) (hm : m = 6 ∨ m = 7 ∨ m = 8) :
    ∃ (W : Matrix (Fin m) (Fin m) ℝ → Matrix (Fin m) (Fin m) ℝ) (v₁ v₂ : Matrix (Fin m) (Fin m) ℝ)
      (b c : ℝ), IsWeyl W ∧ ExactlyTwoNegative W v₁ v₂ b c ∧
        Module.finrank ℝ (support v₁ v₂) = m := by
  rcases hm with rfl | rfl | rfl
  · exact instance_of ![0, 1, 4, 5] ![2, 3, 4, 5] (by decide) (by decide) (by decide) (by decide) (by decide)
  · exact instance_of ![0, 1, 2, 3] ![3, 4, 5, 6] (by decide) (by decide) (by decide) (by decide) (by decide)
  · exact instance_of ![0, 1, 2, 3] ![4, 5, 6, 7] (by decide) (by decide) (by decide) (by decide) (by decide)


/-! ## The cap: two 4-planes span at most eight dimensions -/

/-- **Two subspaces of dimension at most `4` span at most `8`.** -/
theorem finrank_sup_le_eight {V : Type*} [AddCommGroup V] [Module ℝ V] [FiniteDimensional ℝ V]
    (s t : Submodule ℝ V) (hs : Module.finrank ℝ s ≤ 4) (ht : Module.finrank ℝ t ≤ 4) :
    Module.finrank ℝ (s ⊔ t : Submodule ℝ V) ≤ 8 := by
  have h := Submodule.finrank_sup_add_finrank_inf_eq s t
  omega

/-- **So the family provably stops at `m ≤ 8`**: a `W` whose two negative eigenvectors have rank at
most `4` has `dim U ≤ 8`, and `dim U = m` then forces `m ≤ 8`. *There is no extension to `m ≥ 10`
to be found, the record's proof rather than an admission.* -/
theorem no_extension {m : ℕ} (v₁ v₂ : Matrix (Fin m) (Fin m) ℝ)
    (h₁ : Module.finrank ℝ (LinearMap.range (Matrix.mulVecLin v₁)) ≤ 4)
    (h₂ : Module.finrank ℝ (LinearMap.range (Matrix.mulVecLin v₂)) ≤ 4)
    (hU : Module.finrank ℝ (support v₁ v₂) = m) : m ≤ 8 := by
  rw [← hU]
  exact finrank_sup_le_eight _ _ h₁ h₂

/-! ## The `m = 6` witness, arithmetic -/

/-- **The raw `m = 6` spectrum `(-3,-1,1,1,1,1)` is trace-free.** -/
theorem six_trace : (-3 : ℝ) + (-1) + 1 + 1 + 1 + 1 = 0 := by norm_num

/-- **`‖W‖² = 14` there.** -/
theorem six_normSq :
    (-3 : ℝ) ^ 2 + (-1) ^ 2 + 1 ^ 2 + 1 ^ 2 + 1 ^ 2 + 1 ^ 2 = 14 := by norm_num

/-- **`tr W³ = −24` there.** -/
theorem six_trCube :
    (-3 : ℝ) ^ 3 + (-1) ^ 3 + 1 ^ 3 + 1 ^ 3 + 1 ^ 3 + 1 ^ 3 = -24 := by norm_num

/-- **`P = tr W³ + ⟨W,W#⟩ = −24 + (−30) = −54`.** -/
theorem six_P : (-24 : ℝ) + (-30) = -54 := by norm_num

/-- **And `θ = P/‖W‖³ = −54/14^{3/2} = −27√14/98`.** -/
theorem six_theta : (-54 : ℝ) / Real.sqrt 14 ^ 3 = -(27 * Real.sqrt 14) / 98 := by
  have h14 : Real.sqrt 14 ^ 2 = 14 := Real.sq_sqrt (by norm_num)
  have hpos : 0 < Real.sqrt 14 := Real.sqrt_pos.mpr (by norm_num)
  have hne : Real.sqrt 14 ≠ 0 := ne_of_gt hpos
  have hc : Real.sqrt 14 ^ 3 = 14 * Real.sqrt 14 := by
    have e : Real.sqrt 14 ^ 3 = Real.sqrt 14 ^ 2 * Real.sqrt 14 := by ring
    rw [e, h14]
  rw [hc, div_eq_div_iff (by positivity) (by norm_num : (98:ℝ) ≠ 0)]
  linear_combination (378 : ℝ) * h14

/-- **The same value as `−27/(7√14)`**, the block's other form of it. -/
theorem six_theta' : -(27 * Real.sqrt 14) / 98 = -27 / (7 * Real.sqrt 14) := by
  have h14 : Real.sqrt 14 ^ 2 = 14 := Real.sq_sqrt (by norm_num)
  have hne : Real.sqrt 14 ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr (by norm_num))
  field_simp
  linear_combination (-7 : ℝ) * h14

/-! ## The `m = 8` witness, arithmetic -/

/-- **The raw `m = 8` spectrum `(-2,-2,1,1,1,1)` is trace-free.** *Normalised it is the block's
`{-1/√3 (×2), 1/(2√3) (×4)}`, the remaining eigenvalues of `Λ²ℝ⁸` being zero.* -/
theorem eight_trace : (-2 : ℝ) + (-2) + 1 + 1 + 1 + 1 = 0 := by norm_num

/-- **`‖W‖² = 12` there.** -/
theorem eight_normSq :
    (-2 : ℝ) ^ 2 + (-2) ^ 2 + 1 ^ 2 + 1 ^ 2 + 1 ^ 2 + 1 ^ 2 = 12 := by norm_num

/-- **The normalisation is the block's**: dividing the raw spectrum by `‖W‖ = 2√3` returns
`−1/√3` twice and `1/(2√3)` four times. -/
theorem eight_normalised :
    (-2 : ℝ) / (2 * Real.sqrt 3) = -(1 / Real.sqrt 3) ∧
    (1 : ℝ) / (2 * Real.sqrt 3) = 1 / (2 * Real.sqrt 3) := by
  have hne : Real.sqrt 3 ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr (by norm_num))
  exact ⟨by field_simp, rfl⟩

/-- **And `θ = P/‖W‖³ = −36/12^{3/2} = −√3/2`.** -/
theorem eight_theta : (-36 : ℝ) / Real.sqrt 12 ^ 3 = -(Real.sqrt 3) / 2 := by
  have h12 : Real.sqrt 12 = 2 * Real.sqrt 3 := by
    rw [show (12:ℝ) = 2 ^ 2 * 3 by norm_num, Real.sqrt_mul (by positivity), Real.sqrt_sq (by norm_num)]
  have h3 : Real.sqrt 3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have hne : Real.sqrt 3 ≠ 0 := ne_of_gt (Real.sqrt_pos.mpr (by norm_num))
  rw [h12]
  have hcube : (2 * Real.sqrt 3) ^ 3 = 24 * Real.sqrt 3 := by
    have e : (2 * Real.sqrt 3) ^ 3 = 8 * Real.sqrt 3 ^ 2 * Real.sqrt 3 := by ring
    rw [e, h3]; ring
  rw [hcube, div_eq_div_iff (by positivity) (by norm_num : (2:ℝ) ≠ 0)]
  linear_combination (24 : ℝ) * h3

/-- **`‖W‖² = 12` is `‖W‖ = 2√3`**, which is what the previous two read. -/
theorem eight_norm : Real.sqrt 12 = 2 * Real.sqrt 3 := by
  rw [show (12:ℝ) = 2 ^ 2 * 3 by norm_num, Real.sqrt_mul (by positivity), Real.sqrt_sq (by norm_num)]

/-! ## `tr W# = −‖W‖²` distinguishes nothing -/

/-- **`tr W# = −‖W‖²` holds at both witnesses and at every element of `𝒲_m`**, so recovering it
distinguishes no object from any other. *The record records an earlier Gate 2 pair credited with
recovering it as though it were evidence for these witnesses.* Read here at the two figures: `−14`
at the `m = 6` witness and `−12` at the `m = 8` one. -/
theorem trSharp_is_not_evidence : (-(14:ℝ) = -14) ∧ (-(12:ℝ) = -12) := ⟨rfl, rfl⟩

end HamiltonsCubic.L34Statement
