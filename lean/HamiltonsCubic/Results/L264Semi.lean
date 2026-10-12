import Mathlib
import HamiltonsCubic.Results.L264Two
import HamiltonsCubic.Results.CompactSemisimple

set_option linter.style.longLine false

/-!
# L264 (2) on a semisimple subalgebra with two simple ideals

[findings/second-order.md](../../../findings/second-order.md), Lemma L264 (2): *"On a compact semisimple $\mathfrak h$
with two or more simple ideals, no positive-definite idempotent is stable."* [L264Two.lean](L264Two.lean)'s `L264_two`
proves it from a split $\mathfrak h=\mathfrak h_1\oplus\mathfrak h_2$ into commuting ideals with $\mathfrak h_1$
perfect. This file produces the split from Mathlib's `LieAlgebra.IsSemisimple` on the subalgebra
([CompactSemisimple.lean](CompactSemisimple.lean)'s `lieOf`):

* `psi`, `lift`, `subOf`: a Lie ideal of `lieOf h` as a subspace of $\mathfrak{so}(n)$, with `subOf_le`,
  `subOf_closed`, `subOf_comm` (ideals meeting in $\bot$ commute), `subOf_perfect` ($\lbrack I,I\rbrack=I$ gives the
  span of brackets), `subOf_ne`, `subOf_sup`;
* `L264_semisimple_unstable`: with two distinct atoms, take one atom $I$ against the supremum of the others, which
  meet in $\bot$ (independence of atoms) and span $\mathfrak h$ (their supremum is $\top$), $I$ being perfect as a
  non-abelian atom; `L264_two` then gives instability.

The reading of $\mathfrak h$'s own `#` and stability as those of $\mathfrak{so}(n)$ restricted to operators supported
on $\mathfrak h$ stays with the record.
-/

namespace HamiltonsCubic.L264Semi

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.CompactSemisimple

attribute [local instance] LieRing.ofAssociativeRing LieAlgebra.ofAssociativeAlgebra

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable (h : Submodule ℝ (skewSub ι)) (hbr : ∀ X ∈ h, ∀ Y ∈ h, brS X Y ∈ h)

theorem lieOf_skewMem (x : lieOf h hbr) : (x : Matrix ι ι ℝ) ∈ skewSub ι := by
  obtain ⟨X, -, hX⟩ := lieOf_skew h hbr x
  rw [← hX]; exact X.2

/-- The subalgebra's elements back in `𝔰𝔬(n)`. -/
noncomputable def psi : lieOf h hbr →ₗ[ℝ] skewSub ι where
  toFun x := ⟨(x : Matrix ι ι ℝ), lieOf_skewMem h hbr x⟩
  map_add' _ _ := rfl
  map_smul' _ _ := rfl

theorem psi_coe (x : lieOf h hbr) : ((psi h hbr x : skewSub ι) : Matrix ι ι ℝ) = x := rfl

theorem psi_mem (x : lieOf h hbr) : psi h hbr x ∈ h := by
  obtain ⟨X, hXh, hX⟩ := lieOf_skew h hbr x
  have : psi h hbr x = X := Subtype.ext (by rw [psi_coe, hX])
  rw [this]; exact hXh

theorem psi_br (x y : lieOf h hbr) : brS (psi h hbr x) (psi h hbr y) = psi h hbr ⁅x, y⁆ := by
  apply Subtype.ext
  show br (x : Matrix ι ι ℝ) (y : Matrix ι ι ℝ) = ((⁅x, y⁆ : lieOf h hbr) : Matrix ι ι ℝ)
  rw [LieSubalgebra.coe_bracket, Ring.lie_def]; rfl

theorem psi_inj : Function.Injective (psi h hbr) := fun x y hxy =>
  Subtype.ext (congrArg (fun Z : skewSub ι => (Z : Matrix ι ι ℝ)) hxy)

/-- An element of `𝔥` as an element of the Lie algebra. -/
def lift (X : skewSub ι) (hX : X ∈ h) : lieOf h hbr := ⟨(X : Matrix ι ι ℝ), X, hX, rfl⟩

theorem psi_lift (X : skewSub ι) (hX : X ∈ h) : psi h hbr (lift h hbr X hX) = X := rfl

/-- A Lie ideal as a subspace of `𝔰𝔬(n)`. -/
noncomputable def subOf (K : LieIdeal ℝ (lieOf h hbr)) : Submodule ℝ (skewSub ι) :=
  (K : Submodule ℝ (lieOf h hbr)).map (psi h hbr)

theorem subOf_le (K : LieIdeal ℝ (lieOf h hbr)) : subOf h hbr K ≤ h := by
  rintro _ ⟨x, -, rfl⟩; exact psi_mem h hbr x

theorem subOf_closed (K : LieIdeal ℝ (lieOf h hbr)) :
    ∀ X ∈ subOf h hbr K, ∀ Y ∈ subOf h hbr K, brS X Y ∈ subOf h hbr K := by
  rintro _ ⟨x, hx, rfl⟩ _ ⟨y, hy, rfl⟩
  rw [psi_br]
  exact ⟨⁅x, y⁆, K.lie_mem hy, rfl⟩

theorem subOf_comm (I J : LieIdeal ℝ (lieOf h hbr)) (hIJ : I ⊓ J = ⊥) :
    ∀ X ∈ subOf h hbr I, ∀ Y ∈ subOf h hbr J, brS X Y = 0 := by
  rintro _ ⟨x, hx, rfl⟩ _ ⟨y, hy, rfl⟩
  rw [psi_br]
  have hmem : ⁅x, y⁆ ∈ I ⊓ J := LieSubmodule.lie_le_inf I J (LieSubmodule.lie_mem_lie hx hy)
  rw [hIJ, LieSubmodule.mem_bot] at hmem
  rw [hmem, map_zero]

theorem subOf_perfect (I : LieIdeal ℝ (lieOf h hbr)) (hperf : ⁅I, I⁆ = I) :
    subOf h hbr I ≤ Submodule.span ℝ {W | ∃ A B, A ∈ subOf h hbr I ∧ B ∈ subOf h hbr I ∧ W = brS A B} := by
  have hI : (I : Submodule ℝ (lieOf h hbr)) = Submodule.span ℝ {m | ∃ (x : I) (n : I), ⁅(x : lieOf h hbr), (n : lieOf h hbr)⁆ = m} := by
    conv_lhs => rw [← hperf]
    exact LieSubmodule.lieIdeal_oper_eq_linear_span I I
  rintro _ ⟨x, hx, rfl⟩
  have hx' : x ∈ Submodule.span ℝ {m | ∃ (x : I) (n : I), ⁅(x : lieOf h hbr), (n : lieOf h hbr)⁆ = m} := by
    rw [← hI]; exact hx
  clear hx
  induction hx' using Submodule.span_induction with
  | mem u hu =>
    obtain ⟨a, n, rfl⟩ := hu
    exact Submodule.subset_span ⟨psi h hbr a, psi h hbr n, ⟨a, a.2, rfl⟩, ⟨n, n.2, rfl⟩, (psi_br h hbr a n).symm⟩
  | zero => rw [map_zero]; exact Submodule.zero_mem _
  | add u v _ _ hu hv => rw [map_add]; exact Submodule.add_mem _ hu hv
  | smul c u _ hu => rw [map_smul]; exact Submodule.smul_mem _ c hu

theorem subOf_ne (I : LieIdeal ℝ (lieOf h hbr)) (hI : I ≠ ⊥) : ∃ Y ∈ subOf h hbr I, Y ≠ 0 := by
  obtain ⟨x, hx, hx0⟩ : ∃ x ∈ I, x ≠ 0 := by
    by_contra hc
    apply hI
    rw [LieSubmodule.eq_bot_iff]
    intro m hm
    by_contra hm0
    exact hc ⟨m, hm, hm0⟩
  refine ⟨psi h hbr x, ⟨x, hx, rfl⟩, fun h0 => hx0 (psi_inj h hbr (by rw [h0, map_zero]))⟩

theorem subOf_sup (I J : LieIdeal ℝ (lieOf h hbr)) (hIJ : I ⊔ J = ⊤) : h ≤ subOf h hbr I ⊔ subOf h hbr J := by
  intro X hX
  have hx : lift h hbr X hX ∈ I ⊔ J := by rw [hIJ]; exact LieSubmodule.mem_top _
  obtain ⟨a, ha, b, hb, hab⟩ := (LieSubmodule.mem_sup I J _).mp hx
  rw [← psi_lift h hbr X hX, ← hab, map_add]
  exact Submodule.add_mem_sup ⟨a, ha, rfl⟩ ⟨b, hb, rfl⟩

/-- **L264 (2) on a semisimple subalgebra.** If `𝔥 ⊆ 𝔰𝔬(n)` is semisimple (Mathlib's `IsSemisimple`) with two distinct
simple ideals (atoms), no self-adjoint `#`-idempotent with range in `𝔥`, positive definite there, is stable. The split
is one atom `I` against the supremum of the others: they meet in `⊥` and span `𝔥` by semisimplicity, and `I` is
perfect, being a non-abelian atom. -/
theorem L264_semisimple_unstable (hss : LieAlgebra.IsSemisimple ℝ (lieOf h hbr))
    (htwo : ∃ I J : LieIdeal ℝ (lieOf h hbr), IsAtom I ∧ IsAtom J ∧ I ≠ J)
    (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hidem : IsIdem C) (hran : ∀ X, C X ∈ h)
    (hpd : ∀ Y ∈ h, Y ≠ 0 → 0 < inner2 ((C Y : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ)) :
    ¬ IsStable C := by
  obtain ⟨I, J, hI, hJ, hIJ⟩ := htwo
  set A : Set (LieIdeal ℝ (lieOf h hbr)) := {K | IsAtom K} with hA
  set J' := sSup (A \ {I}) with hJ'
  have hinf : I ⊓ J' = ⊥ := (hss.sSupIndep_isAtom hI).eq_bot
  have hsup : I ⊔ J' = ⊤ := by
    have e : A = insert I (A \ {I}) := by rw [Set.insert_sdiff_singleton, Set.insert_eq_of_mem (show I ∈ A from hI)]
    rw [← hss.sSup_atoms_eq_top]
    show I ⊔ sSup (A \ {I}) = sSup A
    conv_rhs => rw [e]
    rw [sSup_insert]
  have hJ'ne : J' ≠ ⊥ := by
    intro h0
    have hle : J ≤ J' := le_sSup ⟨hJ, fun h' => hIJ (Set.mem_singleton_iff.mp h').symm⟩
    rw [h0] at hle
    exact hJ.1 (le_bot_iff.mp hle)
  have hperf : ⁅I, I⁆ = I := lie_eq_self_of_isAtom_of_nonabelian I hI (hss.non_abelian_of_isAtom I hI)
  exact HamiltonsCubic.L264Two.L264_two h (subOf h hbr I) (subOf h hbr J') (subOf_sup h hbr I J' hsup)
    (subOf_le h hbr I) (subOf_le h hbr J') (subOf_closed h hbr I) (subOf_closed h hbr J')
    (subOf_comm h hbr I J' hinf) (subOf_perfect h hbr I hperf) (subOf_ne h hbr I hI.1) (subOf_ne h hbr J' hJ'ne)
    C hC hidem hran hpd

end HamiltonsCubic.L264Semi
