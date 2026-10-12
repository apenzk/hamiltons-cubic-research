import HamiltonsCubic.Results.L66Statement
import HamiltonsCubic.Results.L24Restrict

set_option linter.style.longLine false

/-!
# L66 on the Weyl operators: no maximiser of `P` is `∘`-decomposable

[findings/support-dichotomy.md](../../../findings/support-dichotomy.md), Lemma L66.
[L66Statement.lean](L66Statement.lean) proves the lemma over an abstract real space `E` and a
trilinear form `T` symmetric in its first two slots, with `∘`-orthogonality read as `T X Aᵢ Aⱼ = 0`;
`Pf_lt_max_on` takes the unit sphere as any set closed under negation.
**This file instantiates it at the record's objects**:

- `weylR ι`: the Weyl operators, a submodule of `RecCurv ι` (where submodules carry their additive
  group), with `weylSphere ι`, the record's unit sphere `normSq2 = 1`, closed under negation;
- `foxT`: `T(X, Y, Z) = ⟪X ∘ Y, Z⟫`, trilinear by the bilinearity of `foxProd2`, symmetric in its
  first two slots by commutativity of `∘`;
- `Pf_foxT`: its diagonal is `Pcubic2`, the record's `P`;
- `IsCircDecompWeyl`: `∘`-decomposability in the record's own form, `Aᵢ ∘ Aⱼ = 0` for `i ≠ j`,
  which `circDecomp_of_weyl` converts to the abstract form through the full symmetry of `T` at Weyl
  arguments;
- `L66_weyl`: **a Weyl `W` attaining `M = max P` on the Weyl sphere, `M > 0`, is not
  `∘`-decomposable**; the proof never uses `‖W‖`, so `W` carries no unit-norm hypothesis.

**`M > 0` stays a hypothesis**: the record takes it from Nienhaus's Proposition 2.25, and on
`weylR ι` it needs a nonzero Weyl operator with `P > 0`, which is dimension-dependent.
-/

namespace HamiltonsCubic.RealLayer

open HamiltonsCubic.L66Statement

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The Weyl operators, under the record's norm.** -/
def weylR (ι : Type*) [Fintype ι] [DecidableEq ι] : Submodule ℝ (RecCurv ι) where
  carrier := {v | IsWeyl2 (show CurvOp2 ι from v)}
  add_mem' := fun hv hw => isWeyl2_add hv hw
  zero_mem' := isWeyl2_zero
  smul_mem' := fun c _ hv => isWeyl2_smul c hv

/-- The underlying `CurvOp2` operator. -/
def cv (x : weylR ι) : CurvOp2 ι := show CurvOp2 ι from (x : RecCurv ι)

theorem cv_weyl (x : weylR ι) : IsWeyl2 (cv x) := x.2

theorem cv_add (x y : weylR ι) : cv (x + y) = cv x + cv y := rfl

theorem cv_smul (c : ℝ) (x : weylR ι) : cv (c • x) = c • cv x := rfl

/-- **The record's unit sphere on the Weyl operators**, `normSq2 = 1`. -/
def weylSphere (ι : Type*) [Fintype ι] [DecidableEq ι] : Set (weylR ι) := {x | normSq2 (cv x) = 1}

theorem weylSphere_neg (x : weylR ι) (hx : x ∈ weylSphere ι) : -x ∈ weylSphere ι := by
  show normSq2 (cv (-x)) = 1
  have e : cv (-x) = (-1 : ℝ) • cv x := by
    rw [← cv_smul, neg_one_smul]
  unfold normSq2
  rw [e, innerOp2_smul_left, innerOp2_smul_right, ← normSq2, hx]; norm_num

/-- `∘` is additive in its first slot. -/
theorem foxProd2_add_left (X X' Y : CurvOp2 ι) :
    foxProd2 (X + X') Y = foxProd2 X Y + foxProd2 X' Y := by
  rw [foxProd2_comm, foxProd2_add_right, foxProd2_comm Y, foxProd2_comm Y]

/-- **`T(X, Y, Z) = ⟪X ∘ Y, Z⟫` on the Weyl operators**, trilinear. -/
noncomputable def foxT : weylR ι →ₗ[ℝ] weylR ι →ₗ[ℝ] weylR ι →ₗ[ℝ] ℝ where
  toFun X := LinearMap.mk₂ ℝ (fun Y Z => innerOp2 (foxProd2 (cv X) (cv Y)) (cv Z))
    (fun Y Y' Z => by rw [cv_add, foxProd2_add_right, innerOp2_add_left])
    (fun c Y Z => by rw [cv_smul, foxProd2_smul_right, innerOp2_smul_left, smul_eq_mul])
    (fun Y Z Z' => by rw [cv_add, innerOp2_add_right])
    (fun c Y Z => by rw [cv_smul, innerOp2_smul_right, smul_eq_mul])
  map_add' X X' := by
    refine LinearMap.ext fun Y => LinearMap.ext fun Z => ?_
    simp only [LinearMap.mk₂_apply, LinearMap.add_apply]
    rw [cv_add, foxProd2_add_left, innerOp2_add_left]
  map_smul' c X := by
    refine LinearMap.ext fun Y => LinearMap.ext fun Z => ?_
    simp only [LinearMap.mk₂_apply, LinearMap.smul_apply, RingHom.id_apply, smul_eq_mul]
    rw [cv_smul, foxProd2_smul_left, innerOp2_smul_left]

theorem foxT_apply (X Y Z : weylR ι) :
    foxT X Y Z = innerOp2 (foxProd2 (cv X) (cv Y)) (cv Z) := rfl

theorem foxT_symm12 (X Y Z : weylR ι) : foxT X Y Z = foxT Y X Z := by
  rw [foxT_apply, foxT_apply, foxProd2_comm]

/-- **The diagonal of `T` is `P`.** -/
theorem Pf_foxT (X : weylR ι) : Pf foxT X = Pcubic2 (cv X) := by
  rw [Pf, foxT_apply, foxProd2_self, innerOp2_comm, Pcubic2_eq_innerOp2]

/-- **`∘`-DECOMPOSABILITY IN THE RECORD'S FORM**: `W = Σ aᵢAᵢ`, `k ≥ 2`, unit Weyl pieces,
`Σ aᵢ² = 1`, every `aᵢ ≠ 0`, and `Aᵢ ∘ Aⱼ = 0` for `i ≠ j`. -/
def IsCircDecompWeyl (W : weylR ι) : Prop :=
  ∃ (k : ℕ) (a : Fin k → ℝ) (A : Fin k → weylR ι),
    2 ≤ k ∧ (∀ i, normSq2 (cv (A i)) = 1) ∧ (∑ i, a i ^ 2 = 1) ∧ (∀ i, a i ≠ 0) ∧
      (∀ i j, i ≠ j → foxProd2 (cv (A i)) (cv (A j)) = 0) ∧
      W = ∑ i, a i • A i

/-- **The record's form gives the abstract one**: `T X Aᵢ Aⱼ = ⟪Aᵢ ∘ Aⱼ, X⟫` at Weyl arguments. -/
theorem circDecomp_of_weyl {W : weylR ι} (h : IsCircDecompWeyl W) :
    IsCircDecomposableOn foxT (weylSphere ι) W := by
  obtain ⟨k, a, A, hk, hunit, hsum, hne, horth, hdec⟩ := h
  refine ⟨k, a, A, hk, hunit, hsum, hne, fun X i j hij => ?_, hdec⟩
  rw [foxT_apply]
  change foxTri2 (cv X) (cv (A i)) (cv (A j)) = 0
  rw [foxTri2_comm, foxTri2_symm_right _ _ _ (cv_weyl X).isSelfAdjoint2
    (cv_weyl (A j)).isSelfAdjoint2]
  show innerOp2 (foxProd2 (cv (A i)) (cv (A j))) (cv X) = 0
  rw [horth i j hij]
  have := innerOp2_smul_left 0 (0 : CurvOp2 ι) (cv X)
  rwa [zero_mul, show (0 : ℝ) • (0 : CurvOp2 ι) = 0 from ContinuousLinearMap.ext fun Y => by simp]
    at this

/-- **L66 ON THE WEYL OPERATORS.** With `M > 0` the maximum of `P` on the unit Weyl sphere, a
Weyl `W` with `P(W) = M` is not `∘`-decomposable. -/
theorem L66_weyl (M : ℝ) (hMpos : 0 < M)
    (hM : ∀ B : weylR ι, normSq2 (cv B) = 1 → Pcubic2 (cv B) ≤ M)
    (W : weylR ι) (hmax : Pcubic2 (cv W) = M) :
    ¬ IsCircDecompWeyl W := by
  intro h
  have hbound : ∀ B ∈ weylSphere ι, Pf foxT B ≤ M := fun B hB => by
    rw [Pf_foxT]; exact hM B hB
  have hlt := Pf_lt_max_on foxT foxT_symm12 (weylSphere ι) weylSphere_neg M hMpos hbound W
    (circDecomp_of_weyl h)
  rw [Pf_foxT, hmax] at hlt
  exact lt_irrefl M hlt

end HamiltonsCubic.RealLayer
