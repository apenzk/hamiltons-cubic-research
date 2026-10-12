import HamiltonsCubic.Base.WeylModule
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false

/-!
# `weylModule` has a NONZERO RADICAL, so it is not the record's `𝒲ₙ`

**Found 2026-09-19 while formalising [I36](../../../plan.md).** *The item needs local maximality on
the Weyl operators, which needs a topology, which the record would take from its own pairing
`innerOp`. That pairing is not definite.*

**`symOp : X ↦ X + Xᵀ` is linear, lies in `weylModule`, is nonzero, and has `‖·‖² = 0`.** It kills
every bivector, a skew `X` having `X + Xᵀ = 0`, and every clause of
[WeylReal.lean](../Base/WeylReal.lean)'s `IsWeyl` only ever reads an operator on bivectors, so it
satisfies all four while being invisible to all of them.

**Three consequences, and the third is the sharp one.**

- `innerOp` is a SEMI-inner product on `weylModule`, so no norm instance comes from it directly and
  `IsLocalMaxOn` cannot be given the record's meaning there by that route.
- `theta R = P(R)/‖R‖³` DIVIDES BY ZERO on this subspace.
- **The module the layer calls `𝒲ₙ` contains operators that are not curvature operators at all**,
  and every statement quantifying over it is quantifying over them too.

**WHERE THAT IS A DEFECT AND WHERE IT IS INERT** ([r1004](../../../reviews/REVIEW_r1004.md)).
*Everything reading an operator on bivectors alone is untouched, `ProblemP` included, and so is
every prose finding.* **What it breaks is the TRACE and the DIMENSION**:
[WeylTraceStatement.lean](../Base/WeylTraceStatement.lean)'s three `sorry`-carrying statements take
a trace over this space, which splits as a radical term plus the record's, and the radical term is
not even a function of the operator restricted to `Λ²`.

*This is [r1003](../../../reviews/REVIEW_r1003.md)'s non-injectivity of `toTensor` promoted from a
property of that map to a property of the module. The cause is the same: an operator is defined on
ALL matrices while every clause sees only its restriction to `Λ²`.*
-/

namespace HamiltonsCubic.WeylRadical

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer Matrix

-- The symmetrisation map X ↦ X + Xᵀ, as a bundled linear operator.
noncomputable def symOp (ι : Type*) [Fintype ι] [DecidableEq ι] : CurvLin ι where
  toFun X := X + Xᵀ
  map_add' X Y := by ext p q; simp [Matrix.add_apply, Matrix.transpose_apply]; ring
  map_smul' c X := by ext p q; simp [Matrix.smul_apply, Matrix.transpose_apply]; ring

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **THE RADICAL IS A WHOLE `Hom(Sym, M)`, not one witness**: ANY linear map killing every
bivector lies in `weylModule`, every clause of `IsWeyl` reading an operator on bivectors alone.
*So restriction to `Λ²` is a surjection `weylModule → 𝒲ₙ` whose kernel is entirely unconstrained,
and `dim weylModule = dim 𝒲ₙ + n²·n(n+1)/2`, which is 170 against 10 at `n = 4`*
([r1004](../../../reviews/REVIEW_r1004.md)). -/
theorem mem_weylModule_of_kills_skew (R : CurvLin ι) (h : ∀ X, IsSkew X → R X = 0) :
    R ∈ weylModule ι := by
  have hphi : ∀ i j : ι, R (phi i j) = 0 := fun i j => h _ (phi_isSkew i j)
  refine ⟨fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · show IsSkew (R X)
    rw [h X hX]
    show (0 : Matrix ι ι ℝ)ᵀ = -0
    simp
  · show inner2 (R X) Y = inner2 X (R Y)
    rw [h X hX, h Y hY]
    simp [inner2_zero_left', inner2_zero_right']
  · show inner2 (R (phi i j)) (phi k l) + inner2 (R (phi i k)) (phi l j)
        + inner2 (R (phi i l)) (phi j k) = 0
    rw [hphi i j, hphi i k, hphi i l]
    simp [inner2_zero_left']
  · show ∑ c : ι, inner2 (R (phi a c)) (phi b c) = 0
    have : ∀ c : ι, inner2 (R (phi a c)) (phi b c) = 0 := by
      intro c; rw [hphi a c]; simp [inner2_zero_left']
    simp [this]

/-- It KILLS every bivector, since a skew `X` has `X + Xᵀ = 0`. -/
theorem symOp_skew (X : Matrix ι ι ℝ) (hX : IsSkew X) : symOp ι X = 0 := by
  show X + Xᵀ = 0
  rw [hX]; abel

/-- So it lies in `weylModule`: every clause only ever sees it on bivectors. -/
theorem symOp_mem : symOp ι ∈ weylModule ι :=
  mem_weylModule_of_kills_skew _ symOp_skew

private theorem symOp_mem_long : symOp ι ∈ weylModule ι := by
  have hphi : ∀ i j : ι, (symOp ι) (phi i j) = 0 :=
    fun i j => symOp_skew _ (phi_isSkew i j)
  refine ⟨fun X hX => ?_, fun X Y hX hY => ?_, fun i j k l => ?_, fun a b => ?_⟩
  · show IsSkew ((symOp ι) X)
    rw [symOp_skew X hX]
    show (0 : Matrix ι ι ℝ)ᵀ = -0
    simp
  · show inner2 ((symOp ι) X) Y = inner2 X ((symOp ι) Y)
    rw [symOp_skew X hX, symOp_skew Y hY]
    simp [inner2_zero_left', inner2_zero_right']
  · show inner2 ((symOp ι) (phi i j)) (phi k l) + inner2 ((symOp ι) (phi i k)) (phi l j)
        + inner2 ((symOp ι) (phi i l)) (phi j k) = 0
    rw [hphi i j, hphi i k, hphi i l]
    simp [inner2_zero_left']
  · show ∑ c : ι, inner2 ((symOp ι) (phi a c)) (phi b c) = 0
    have : ∀ c : ι, inner2 ((symOp ι) (phi a c)) (phi b c) = 0 := by
      intro c; rw [hphi a c]; simp [inner2_zero_left']
    simp [this]

/-- Its norm is ZERO, every clause of `innerOp` reading it on bivectors alone. -/
theorem symOp_normSq : normSq (fun X => (symOp ι) X) = 0 := by
  unfold normSq innerOp
  have h : ∀ i j : ι, inner2 ((symOp ι) (phi i j)) ((symOp ι) (phi i j)) = 0 := by
    intro i j
    rw [symOp_skew _ (phi_isSkew i j)]
    simp [inner2_zero_left']
  show (1/2 : ℝ) * ∑ i : ι, ∑ j : ι, inner2 ((symOp ι) (phi i j)) ((symOp ι) (phi i j)) = 0
  simp [h]

/-- And it is NOT zero, at a type with at least one index. -/
theorem symOp_ne_zero [Nonempty ι] : symOp ι ≠ 0 := by
  intro h
  obtain ⟨a⟩ := ‹Nonempty ι›
  have := congrArg (fun R => (R (Matrix.single a a (1:ℝ))) a a) h
  simp [symOp, Matrix.single_apply, Matrix.transpose_apply] at this

/-! ## And a member that is NOT in the radical, which is a different debt

**[weylTrace_id](../Base/WeylModule.lean)'s docstring records that no nonzero member of
`weylModule` was exhibited anywhere in the layer, so every statement there was consistent with
`dim 𝒲ₙ = 0`.** *`symOp` above does not discharge that* ([r1004](../../../reviews/REVIEW_r1004.md)):
it is nonzero, and it lies in the RADICAL, so it witnesses that the module is nonzero while saying
nothing about the Weyl space the module is supposed to be.

**A diagonal operator does discharge it.** *It moves `φ_ab` by `w_ab`, so it survives restriction
to `Λ²`, and the record's own `sphereWeight` supplies a weight with a nonzero entry at every
admissible split.*
-/

/-- `diagOp w` bundled as a linear map, which `diagOp_add` and `diagOp_smul_arg` supply. -/
noncomputable def diagOpL (w : Matrix ι ι ℝ) : CurvLin ι where
  toFun := diagOp w
  map_add' := diagOp_add w
  map_smul' c X := by simpa using diagOp_smul_arg w c X

/-- It lies in `weylModule` at every weight of `𝒟ₙ`. -/
theorem diagOpL_mem {w : Matrix ι ι ℝ} (h : IsWeight w) : diagOpL w ∈ weylModule ι :=
  diagOp_isWeyl h

/-- **IT IS NOT IN THE RADICAL**, moving `φ_ab` whenever `w_ab` is nonzero. *So the Weyl space
itself is nonzero, which is the debt `symOp` leaves standing and this closes.* -/
theorem diagOpL_phi_ne_zero {w : Matrix ι ι ℝ} (h : IsWeight w) {a b : ι}
    (hab : a ≠ b) (hw : w a b ≠ 0) : diagOpL w (phi a b) ≠ 0 := by
  show diagOp w (phi a b) ≠ 0
  rw [diagOp_phi w h.symm]
  intro hz
  have hval : w a b * (phi a b) b a = 0 := by
    have := congrFun (congrFun hz b) a
    simpa [Matrix.smul_apply] using this
  rw [show (phi a b) b a = (1:ℝ) by simp [phi, hab]] at hval
  exact hw (by linarith)

/-- **The witness, at the record's own sphere weight.** *Every admissible split has cross entries
`-1`, so this is a member of `weylModule` that restriction to `Λ²` does not kill, at every `n` with
a split into two blocks of at least two.*

**WHAT IT GIVES AND WHAT IT DOES NOT** ([r1006](../../../reviews/REVIEW_r1006.md)). *It exhibits a
member surviving restriction to `Λ²`, where `symOp` dies, so the distinction the debt was for is
drawn.* **No declaration here states `dim 𝒲ₙ ≥ 1`, or even `weylModule ≠ ⊥`**: the restriction map
is not built, so the space the claim is about has no name in the layer. **And the witness is empty
below `n = 4`**, which is the right boundary since `dim 𝒲₃ = 0`, *so `symOp` remains the witness for
the module's own non-vacuity at every `n`.* -/
theorem sphereWeight_diagOpL_ne_zero (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card)
    {a b : ι} (ha : a ∈ S) (hb : b ∉ S) :
    diagOpL (sphereWeight S) (phi a b) ≠ 0 := by
  have hab : a ≠ b := fun h => hb (h ▸ ha)
  refine diagOpL_phi_ne_zero (sphereWeight_isWeight S hp hq) hab ?_
  rw [sphereWeight_cross S ha hb]
  norm_num

end HamiltonsCubic.WeylRadical
