import Mathlib
import HamiltonsCubic.Results.L264Semi

set_option linter.style.longLine false

/-!
# L264 (3)'s reduction: the maximiser's idempotent lives on a simple subalgebra

[findings/second-order.md](../../../findings/second-order.md), Lemma L264 (3): *"By (1) and (2) the maximiser's $C$ is
a stable positive-definite idempotent on a simple $\mathfrak h\subseteq\mathfrak{so}(n)$"*. This file composes
[L264Support.lean](L264Support.lean)'s `L264_one`, [CompactSemisimple.lean](CompactSemisimple.lean)'s
`L264_one_semisimple` and [L264Semi.lean](L264Semi.lean)'s `L264_semisimple_unstable`:

* `L264_three_full`: the record's sentence whole, `C` a stable idempotent positive definite on its range, which is
  simple;
* `L264_three_simple`: that range is a simple Lie algebra (Mathlib's `LieAlgebra.IsSimple`), the record's
  "simple $\mathfrak h$";
* `L264_three_one_atom`: at a positive semidefinite unit maximiser $X$ of $F$ on the self-adjoint operators, $n\ge3$,
  the range of $C=X/F(X)$ is a semisimple Lie algebra with at most one simple ideal: any two atoms of its ideal
  lattice coincide.

The reading of $\mathfrak h$'s own `#` and stability as $\mathfrak{so}(n)$'s restricted stays with the record, as in (2).
-/

namespace HamiltonsCubic.L264Three

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.CompactSemisimple

attribute [local instance] LieRing.ofAssociativeRing LieAlgebra.ofAssociativeAlgebra

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **At the maximiser, the idempotent's range has one simple ideal at most.** -/
theorem L264_three_one_atom (hn : 3 ≤ Fintype.card ι) (X : CurvOp2 ι) (hX : IsSelfAdjoint2 X) (hXp : IsPSD2 X)
    (hunit : normSq2 X = 1)
    (hmax : ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X) :
    ∃ hbr : ∀ A ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
        ∀ B ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
        brS A B ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
      LieAlgebra.IsSemisimple ℝ (lieOf _ hbr) ∧
      ∀ I J : LieIdeal ℝ (lieOf _ hbr), IsAtom I → IsAtom J → I = J := by
  obtain ⟨hidem, hstab, hCsa, -, hcl, hspan, hpd⟩ := HamiltonsCubic.L264Support.L264_one hn X hX hXp hunit hmax
  set C : CurvOp2 ι := (1 / Ftri X X X) • X with hC
  have hbr : ∀ A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι), ∀ B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι),
      brS A B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι) := fun A hA B hB => hcl A B hA hB
  have hss := isSemisimple_perfect _ hbr hspan.le
  refine ⟨hbr, hss, fun I J hI hJ => ?_⟩
  by_contra hIJ
  exact HamiltonsCubic.L264Semi.L264_semisimple_unstable _ hbr hss ⟨I, J, hI, hJ, hIJ⟩ C hCsa hidem
    (fun Z => ⟨Z, rfl⟩) (fun Y hY hY0 => hpd Y hY hY0) hstab

/-- **At the maximiser, the idempotent lives on a simple subalgebra**: the range of `C = X/F(X)` is a simple Lie
algebra in Mathlib's sense. It is nonzero, so its atoms are nonempty; the single atom is `⊤`; and `⊤` being an atom
makes the ideal lattice simple, while semisimplicity makes the algebra non-abelian. -/
theorem L264_three_simple (hn : 3 ≤ Fintype.card ι) (X : CurvOp2 ι) (hX : IsSelfAdjoint2 X) (hXp : IsPSD2 X)
    (hunit : normSq2 X = 1)
    (hmax : ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X) :
    ∃ hbr : ∀ A ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
        ∀ B ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
        brS A B ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
      LieAlgebra.IsSimple ℝ (lieOf _ hbr) := by
  obtain ⟨hbr, hss, huniq⟩ := L264_three_one_atom hn X hX hXp hunit hmax
  refine ⟨hbr, ?_⟩
  have hpos := HamiltonsCubic.L264Support.maximiser_pos hn X hmax
  have hX0 : X ≠ 0 := fun h0 => by
    rw [h0] at hunit; simp [normSq2, innerOp2, applyPhi, inner2] at hunit
  obtain ⟨Z, hZ⟩ : ∃ Z, ((1 / Ftri X X X) • X : CurvOp2 ι) Z ≠ 0 := by
    by_contra hc
    simp only [not_exists, not_not] at hc
    apply hX0
    refine ContinuousLinearMap.ext fun W => ?_
    have := hc W
    rw [_root_.smul_apply] at this
    rw [_root_.zero_apply]
    exact (smul_eq_zero.mp this).resolve_left (by positivity)
  set w : lieOf _ hbr := ⟨((((1 / Ftri X X X) • X : CurvOp2 ι) Z : skewSub ι) : Matrix ι ι ℝ), _, ⟨Z, rfl⟩, rfl⟩
  have hw : w ≠ 0 := fun h0 => hZ (Subtype.ext (congrArg (fun v : lieOf _ hbr => (v : Matrix ι ι ℝ)) h0))
  have hne : (⊤ : LieIdeal ℝ (lieOf _ hbr)) ≠ ⊥ := fun h0 => by
    have hm : w ∈ (⊤ : LieIdeal ℝ (lieOf _ hbr)) := LieSubmodule.mem_top w
    rw [h0, LieSubmodule.mem_bot] at hm
    exact hw hm
  obtain ⟨I, hI⟩ : ∃ I : LieIdeal ℝ (lieOf _ hbr), IsAtom I := by
    by_contra hc
    simp only [not_exists] at hc
    have e := hss.sSup_atoms_eq_top
    rw [show {I : LieIdeal ℝ (lieOf _ hbr) | IsAtom I} = ∅ from Set.eq_empty_of_forall_notMem fun I h => hc I h,
      sSup_empty] at e
    exact hne e.symm
  have htop : I = ⊤ := by
    rw [← hss.sSup_atoms_eq_top]
    have : {J : LieIdeal ℝ (lieOf _ hbr) | IsAtom J} = {I} :=
      Set.ext fun J => ⟨fun hJ => huniq J I hJ hI, fun h => by rw [Set.mem_singleton_iff.mp h]; exact hI⟩
    rw [this, sSup_singleton]
  have hatop : IsAtom (⊤ : LieIdeal ℝ (lieOf _ hbr)) := htop ▸ hI
  have hnab : ¬ IsLieAbelian (lieOf _ hbr) := fun hab =>
    hss.non_abelian_of_isAtom ⊤ hatop ⟨fun x y => Subtype.ext (by
      have := hab.trivial (x : lieOf _ hbr) (y : lieOf _ hbr)
      simpa using this)⟩
  haveI : IsSimpleOrder (LieIdeal ℝ (lieOf _ hbr)) := isSimpleOrder_iff_isAtom_top.mpr hatop
  exact (LieAlgebra.isSimple_iff_of_not_isLieAbelian (R := ℝ) (L := lieOf _ hbr) hnab).mp this

/-- **L264 (3)'s sentence in one statement**: at a positive semidefinite unit maximiser, `C = X/F(X)` is a stable
`#`-idempotent, positive definite on its range, and that range is a simple Lie algebra. -/
theorem L264_three_full (hn : 3 ≤ Fintype.card ι) (X : CurvOp2 ι) (hX : IsSelfAdjoint2 X) (hXp : IsPSD2 X)
    (hunit : normSq2 X = 1)
    (hmax : ∀ Y : CurvOp2 ι, IsSelfAdjoint2 Y → normSq2 Y = 1 → Ftri Y Y Y ≤ Ftri X X X) :
    IsIdem ((1 / Ftri X X X) • X) ∧ IsStable ((1 / Ftri X X X) • X) ∧
      (∀ A : skewSub ι, A ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι) → A ≠ 0 →
        0 < inner2 (((((1 / Ftri X X X) • X : CurvOp2 ι) A : skewSub ι)) : Matrix ι ι ℝ) ((A : skewSub ι) : Matrix ι ι ℝ)) ∧
      ∃ hbr : ∀ A ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
          ∀ B ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
          brS A B ∈ LinearMap.range (((1 / Ftri X X X) • X : CurvOp2 ι) : skewSub ι →ₗ[ℝ] skewSub ι),
        LieAlgebra.IsSimple ℝ (lieOf _ hbr) := by
  obtain ⟨hidem, hstab, -, -, -, -, hpd⟩ := HamiltonsCubic.L264Support.L264_one hn X hX hXp hunit hmax
  exact ⟨hidem, hstab, hpd, L264_three_simple hn X hX hXp hunit hmax⟩

end HamiltonsCubic.L264Three
