import Mathlib
import HamiltonsCubic.Results.L263Ideal
import HamiltonsCubic.Results.L264Support

set_option linter.style.longLine false

/-!
# Compact subalgebras of so(n): trivial centre, or spanned by brackets, gives semisimple

L263 needs its fourteen-dimensional $\mathfrak h\subset\mathfrak{so}(7)$ to be compact semisimple (U's scope), and
L264 (1) needs the range of the maximiser's idempotent, a subalgebra spanned by its own brackets, to be semisimple.
Both steps were prose. This file proves them in Mathlib's sense (`LieAlgebra.IsSemisimple`):

* `isSemisimple_of_center`: a finite-dimensional real Lie algebra with a positive-definite invariant form and trivial
  centre is semisimple, through Mathlib's `isSemisimple_of_nondegenerate`, an abelian atom ideal being central by
  definiteness; `center_trivial_of_perfect`: a perfect one has trivial centre;
* `lieOf`, `traceForm`, `traceForm_inv`: a subspace of $\mathfrak{so}(n)$ closed under the bracket, as a Lie subalgebra
  of the matrices with the trace form $\tfrac12\operatorname{tr}(x^{\mathsf T}y)$, invariant by `inner2_brS_skew`;
* `isSemisimple_sub`, `isSemisimple_perfect`: such a subalgebra is semisimple when its centre is trivial, or when it is
  spanned by its brackets;
* `L263_semisimple`, `gopC_range`: L263's $\mathfrak h=\operatorname{span}(g_k)$ is semisimple, from `center_zero`,
  and it is the range of the witness `gop lamC`;
* `L264_one_semisimple`: at a positive semidefinite maximiser, the range of $C=X/F(X)$ is semisimple, from `L264_one`.
-/

namespace HamiltonsCubic.CompactSemisimple

open LieAlgebra

variable {L : Type*} [LieRing L] [LieAlgebra ℝ L] [Module.Finite ℝ L]

/-- **A real Lie algebra with a positive-definite invariant form and trivial centre is semisimple.** An abelian atom
ideal `I` is central: for `a ∈ I` and any `x`, `⁅a, x⁆ ∈ I` is orthogonal to `I` by invariance and abelianness, so it
vanishes by definiteness. -/
theorem isSemisimple_of_center (Φ : LinearMap.BilinForm ℝ L) (hinv : Φ.lieInvariant L)
    (hsymm : ∀ x y, Φ x y = Φ y x) (hpos : ∀ x, x ≠ 0 → 0 < Φ x x)
    (hcen : ∀ z : L, (∀ x : L, ⁅x, z⁆ = 0) → z = 0) : IsSemisimple ℝ L := by
  have hdef : ∀ x, Φ x x = 0 → x = 0 := fun x h => by
    by_contra hx; exact absurd h (hpos x hx).ne'
  refine InvariantForm.isSemisimple_of_nondegenerate Φ ?_ hinv ?_ ?_
  · refine ⟨fun x hx => hdef x (hx x), fun x hx => hdef x (by rw [hsymm]; exact hx x)⟩
  · intro x y h; rw [hsymm]; exact h
  · intro I hI hab
    apply hI.1
    rw [eq_bot_iff]
    intro a ha
    rw [LieSubmodule.mem_bot]
    refine hcen a fun x => ?_
    have hxa : ⁅a, x⁆ ∈ I := by
      have := I.lie_mem (x := x) ha
      rw [← lie_skew] at this
      exact (neg_mem_iff).mp this
    have horth : Φ ⁅a, x⁆ ⁅a, x⁆ = 0 := by
      rw [hinv a x ⁅a, x⁆]
      have : ⁅a, ⁅a, x⁆⁆ = 0 := by
        have h := hab.trivial ⟨a, ha⟩ ⟨⁅a, x⁆, hxa⟩
        exact congrArg Subtype.val h
      rw [this, map_zero, neg_zero]
    have h0 := hdef _ horth
    rw [← lie_skew, h0, neg_zero]

/-- **A perfect real Lie algebra with a positive-definite invariant form has trivial centre**: a central `z` is
orthogonal to every bracket. -/
theorem center_trivial_of_perfect (Φ : LinearMap.BilinForm ℝ L) (hinv : Φ.lieInvariant L)
    (hsymm : ∀ x y, Φ x y = Φ y x) (hpos : ∀ x, x ≠ 0 → 0 < Φ x x)
    (hperf : ∀ w : L, w ∈ Submodule.span ℝ {u | ∃ x y : L, ⁅x, y⁆ = u}) :
    ∀ z : L, (∀ x : L, ⁅x, z⁆ = 0) → z = 0 := by
  intro z hz
  have hperp : ∀ w ∈ Submodule.span ℝ {u | ∃ x y : L, ⁅x, y⁆ = u}, Φ w z = 0 := by
    intro w hw
    induction hw using Submodule.span_induction with
    | mem u hu =>
      obtain ⟨x, y, rfl⟩ := hu
      rw [hinv x y z, hz x, map_zero, neg_zero]
    | zero => simp
    | add u v _ _ hu hv => rw [map_add, LinearMap.add_apply, hu, hv, add_zero]
    | smul c u _ hu => rw [map_smul, LinearMap.smul_apply, hu, smul_zero]
  by_contra hne
  exact absurd (hperp z (hperf z)) (hpos z hne).ne'

section Layer

open HamiltonsCubic.RealLayer HamiltonsCubic.I117S

attribute [local instance] LieRing.ofAssociativeRing LieAlgebra.ofAssociativeAlgebra

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- A subspace of `𝔰𝔬(n)` closed under the bracket, as a Lie subalgebra of the matrices. -/
def lieOf (h : Submodule ℝ (skewSub ι)) (hbr : ∀ X ∈ h, ∀ Y ∈ h, brS X Y ∈ h) : LieSubalgebra ℝ (Matrix ι ι ℝ) where
  carrier := {A | ∃ X : skewSub ι, X ∈ h ∧ (X : Matrix ι ι ℝ) = A}
  add_mem' := by
    rintro _ _ ⟨X, hX, rfl⟩ ⟨Y, hY, rfl⟩; exact ⟨X + Y, h.add_mem hX hY, rfl⟩
  zero_mem' := ⟨0, h.zero_mem, rfl⟩
  smul_mem' := by
    rintro c _ ⟨X, hX, rfl⟩; exact ⟨c • X, h.smul_mem c hX, rfl⟩
  lie_mem' := by
    rintro _ _ ⟨X, hX, rfl⟩ ⟨Y, hY, rfl⟩
    exact ⟨brS X Y, hbr X hX Y hY, by rw [Ring.lie_def]; rfl⟩

variable (h : Submodule ℝ (skewSub ι)) (hbr : ∀ X ∈ h, ∀ Y ∈ h, brS X Y ∈ h)

theorem lieOf_skew (x : lieOf h hbr) : ∃ X : skewSub ι, X ∈ h ∧ (X : Matrix ι ι ℝ) = x := x.2

/-- The trace form `⟨x, y⟩ = ½ tr(xᵀ y)` on the subalgebra. -/
noncomputable def traceForm : LinearMap.BilinForm ℝ (lieOf h hbr) :=
  LinearMap.mk₂ ℝ (fun x y => inner2 ((x : Matrix ι ι ℝ)) ((y : Matrix ι ι ℝ)))
    (fun x x' y => by simp [i2_add_l])
    (fun c x y => by simp [i2_smul_l])
    (fun x y y' => by simp [i2_add_r])
    (fun c x y => by simp [i2_smul_r])

theorem traceForm_apply (x y : lieOf h hbr) : traceForm h hbr x y = inner2 (x : Matrix ι ι ℝ) (y : Matrix ι ι ℝ) := rfl

theorem traceForm_inv : (traceForm h hbr).lieInvariant (lieOf h hbr) := fun x y z => by
  obtain ⟨X, -, hX⟩ := lieOf_skew h hbr x
  obtain ⟨Y, -, hY⟩ := lieOf_skew h hbr y
  obtain ⟨Z, -, hZ⟩ := lieOf_skew h hbr z
  simp only [traceForm_apply, LieSubalgebra.coe_bracket, Ring.lie_def, ← hX, ← hY, ← hZ]
  exact inner2_brS_skew X Y Z

theorem traceForm_symm (x y : lieOf h hbr) : traceForm h hbr x y = traceForm h hbr y x := by
  simp only [traceForm_apply]; exact HamiltonsCubic.L33Statement.inner2_comm _ _

theorem traceForm_pos (x : lieOf h hbr) (hx : x ≠ 0) : 0 < traceForm h hbr x x := by
  rw [traceForm_apply]
  rcases (HamiltonsCubic.FrameExtension.inner2_self_nonneg (x : Matrix ι ι ℝ)).lt_or_eq with hlt | heq
  · exact hlt
  · exact absurd (Subtype.ext (HamiltonsCubic.FrameExtension.inner2_self_eq_zero heq.symm)) hx

/-- **A subalgebra of `𝔰𝔬(n)` with trivial centre is semisimple.** -/
theorem isSemisimple_sub (hcen : ∀ Z ∈ h, (∀ X ∈ h, brS X Z = 0) → Z = 0) : IsSemisimple ℝ (lieOf h hbr) := by
  refine isSemisimple_of_center (traceForm h hbr) (traceForm_inv h hbr) (traceForm_symm h hbr) (traceForm_pos h hbr) ?_
  intro z hz
  obtain ⟨Z, hZh, hZ⟩ := lieOf_skew h hbr z
  have hZ0 : Z = 0 := hcen Z hZh fun X hX => by
    have e := congrArg Subtype.val (hz ⟨(X : Matrix ι ι ℝ), X, hX, rfl⟩)
    rw [LieSubalgebra.coe_bracket, Ring.lie_def, ← hZ] at e
    exact Subtype.ext e
  exact Subtype.ext (by rw [← hZ, hZ0]; rfl)

/-- **A subalgebra of `𝔰𝔬(n)` spanned by its brackets is semisimple**: a central `Z` is orthogonal to every bracket
by invariance, hence to the subalgebra, hence zero. -/
theorem isSemisimple_perfect
    (hperf : h ≤ Submodule.span ℝ {W | ∃ A B, A ∈ h ∧ B ∈ h ∧ W = brS A B}) : IsSemisimple ℝ (lieOf h hbr) := by
  refine isSemisimple_sub h hbr fun Z hZh hZ => ?_
  have hperp : ∀ W ∈ Submodule.span ℝ {W | ∃ A B, A ∈ h ∧ B ∈ h ∧ W = brS A B},
      inner2 (W : Matrix ι ι ℝ) (Z : Matrix ι ι ℝ) = 0 := by
    intro W hW
    induction hW using Submodule.span_induction with
    | mem u hu =>
      obtain ⟨A, B, hA, -, rfl⟩ := hu
      rw [inner2_brS_skew, hZ A hA]; simp [inner2]
    | zero => simp [inner2]
    | add u v _ _ hu hv => rw [Submodule.coe_add, i2_add_l, hu, hv, add_zero]
    | smul c u _ hu => rw [Submodule.coe_smul, i2_smul_l, hu, mul_zero]
  exact HamiltonsCubic.I117S.skew_zero_of_inner' Z (hperp Z (hperf hZh))

end Layer

section Apps

open HamiltonsCubic.RealLayer HamiltonsCubic.I117S

attribute [local instance] LieRing.ofAssociativeRing LieAlgebra.ofAssociativeAlgebra

theorem gv_span_closed : ∀ X ∈ Submodule.span ℝ (Set.range gv), ∀ Y ∈ Submodule.span ℝ (Set.range gv),
    brS X Y ∈ Submodule.span ℝ (Set.range gv) := by
  set h : Submodule ℝ (skewSub (Fin 7)) := Submodule.span ℝ (Set.range gv) with hh
  have hgen : ∀ i j, brS (gv i) (gv j) ∈ h := fun i j => by
    rw [gv_br]; exact Submodule.sum_mem _ fun m _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨m, rfl⟩)
  have key : ∀ i, ∀ Y ∈ h, brS (gv i) Y ∈ h := by
    intro i Y hY
    induction hY using Submodule.span_induction with
    | mem y hy => obtain ⟨j, rfl⟩ := hy; exact hgen i j
    | zero => rw [HamiltonsCubic.OddTorus.brS_zero_right]; exact h.zero_mem
    | add y z _ _ hy hz => rw [brS_add_right]; exact h.add_mem hy hz
    | smul a y _ hy => rw [brS_smul_right]; exact h.smul_mem a hy
  intro X hX Y hY
  induction hX using Submodule.span_induction with
  | mem x hx => obtain ⟨i, rfl⟩ := hx; exact key i Y hY
  | zero => rw [HamiltonsCubic.OddTorus.brS_zero_left]; exact h.zero_mem
  | add x z _ _ hx hz => rw [brS_add_left]; exact h.add_mem hx hz
  | smul a x _ hx => rw [brS_smul_left]; exact h.smul_mem a hx

/-- **L263's `𝔥 = span gv ⊂ 𝔰𝔬(7)` is semisimple**, so the witness is inside U's scope. -/
theorem L263_semisimple : IsSemisimple ℝ (lieOf (Submodule.span ℝ (Set.range gv)) gv_span_closed) := by
  refine isSemisimple_sub _ gv_span_closed fun Z hZ hcen => ?_
  obtain ⟨c, rfl⟩ := (Submodule.mem_span_range_iff_exists_fun ℝ).mp hZ
  have hc := HamiltonsCubic.L263Ideal.center_zero c fun k => by
    have := hcen (gv k) (Submodule.subset_span ⟨k, rfl⟩)
    rw [brS_neg, this, neg_zero]
  simp [hc]

/-- **The witness is supported on `𝔥`**: `range (gop lamC) = span gv`, so `L263_semisimple`'s subalgebra is the one
`L263_witness`'s idempotent lives on. -/
theorem gopC_range : LinearMap.range (gop lamC : skewSub (Fin 7) →ₗ[ℝ] skewSub (Fin 7)) = Submodule.span ℝ (Set.range gv) := by
  apply le_antisymm
  · rintro _ ⟨X, rfl⟩
    show gop lamC X ∈ _
    rw [gop_expand]
    exact Submodule.sum_mem _ fun i _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨i, rfl⟩)
  · rw [Submodule.span_le]
    rintro _ ⟨k, rfl⟩
    have h := HamiltonsCubic.L263Ideal.C_gv k
    have hne : (if k ∈ su3idx then (9 / 28 : ℝ) else 3 / 28) ≠ 0 := by split_ifs <;> norm_num
    refine ⟨(if k ∈ su3idx then (9 / 28 : ℝ) else 3 / 28)⁻¹ • gv k, ?_⟩
    show gop lamC _ = gv k
    rw [map_smul, h, smul_smul, inv_mul_cancel₀ hne, one_smul]

/-- **L264 (1)'s range is semisimple**: at a positive semidefinite maximiser `X`, `C = X/F(X)` has its range closed
under the bracket and spanned by brackets (`L264_one`), so the range is a semisimple Lie algebra. -/
theorem L264_one_semisimple {ι : Type*} [Fintype ι] [DecidableEq ι] (hn : 3 ≤ Fintype.card ι) (X : CurvOp2 ι)
    (hX : IsSelfAdjoint2 X) (hXp : IsPSD2 X) (hunit : normSq2 X = 1)
    (hmax : ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X) :
    ∃ hbr : ∀ A ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
        ∀ B ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
        brS A B ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
      IsSemisimple ℝ (lieOf _ hbr) := by
  obtain ⟨-, -, -, -, hcl, hspan, -⟩ := HamiltonsCubic.L264Support.L264_one hn X hX hXp hunit hmax
  exact ⟨fun A hA B hB => hcl A B hA hB, isSemisimple_perfect _ _ hspan.le⟩

end Apps

end HamiltonsCubic.CompactSemisimple
