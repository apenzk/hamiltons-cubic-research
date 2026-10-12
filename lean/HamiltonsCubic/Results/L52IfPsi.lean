import HamiltonsCubic.Results.L52RecordEq
import HamiltonsCubic.Results.L54Direct
import HamiltonsCubic.Results.L52S20

set_option linter.style.longLine false

/-!
# L52's "if" half with the `ψ` stipulation

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L52: the bound is exact when both operators are diagonal in
one shared frame and the `ψ`-basis is an eigenbasis of `K`, the stipulation without which the "if" half is false.
[L52RecordEq.lean](L52RecordEq.lean)'s `L52_record_if` needs `Bw w (ringW R)` diagonal. This file supplies it at the
stipulated basis:

* **`coordDiag_frame`**: at a coordinate-diagonal `W` (`IsCoordDiag`, both operators diagonal in the frame `e`), `M` in
  the pair basis is diagonal and so is `W̊` in `{φ_ab} ∪ {diag w_k}` at `w = wK`, an eigenbasis of `K`: the pair block by
  `Bw_pair_off`, the pair–`ψ` block by `Bw_pair_psi`, the `ψ` block by `psi_block`;
* **`coordDiag_of_Mpair`**: conversely `M` diagonal in the pair basis gives `IsCoordDiag`, so at `wK` the "if" half
  needs only `M` diagonal;
* **`L52_if_psi`**: so at a first-Bianchi unit-norm coordinate-diagonal `W` the bound is an equality in the stipulated
  basis;
* **`L52_if_psi_S20`**: `L52_if_psi` on `S²₀` at a Ricci-flat `W`, through L52S20's `sum_diag_split`.

This is [L54Direct.lean](L54Direct.lean)'s `L54_direct` with coordinate-diagonality taken as the hypothesis rather than
derived from `t_F = 2`.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR hskew hsym

/-- **At a coordinate-diagonal `W`, both operators are diagonal in the stipulated basis.** -/
theorem coordDiag_frame (hcd : IsCoordDiag R) :
    (∀ p q, p ≠ q → Mpair R p q = 0) ∧
      (∀ u v, u ≠ v → Bw (wK R hR hskew hsym) (ringW R) u v = 0) := by
  constructor
  · intro p q hpq
    show R4 R p.1.1 p.1.2 q.1.1 q.1.2 = 0
    refine hcd _ _ _ _ ?_
    rintro (⟨h1, h2⟩ | ⟨h1, h2⟩)
    · exact hpq (Subtype.ext (Prod.ext h1.symm h2.symm))
    · have := q.2; rw [h1, h2] at this; exact lt_asymm p.2 this
  · intro u v huv
    rcases u with p | j <;> rcases v with q | k
    · exact Bw_pair_off R _ hcd p q (fun h => huv (congrArg Sum.inl h))
    · exact Bw_pair_psi R _ hcd p k
    · rw [← (Bw_isHermitian R hR hskew hsym _ (wK_complete R hR hskew hsym)).apply]
      simp only [star_trivial]
      exact Bw_pair_psi R _ hcd q j
    · have hjk : j ≠ k := fun h => huv (congrArg Sum.inr h)
      show frob (ringW R (Matrix.diagonal (wK R hR hskew hsym j))) (Matrix.diagonal (wK R hR hskew hsym k)) = 0
      rw [psi_block R hR hskew hsym _ _ (wK_eigen R hR hskew hsym) (wK_orth R hR hskew hsym), if_neg hjk]

/-- **L52's "if" half in the stipulated basis**: at a first-Bianchi unit-norm coordinate-diagonal `W`, the bound
`L52_record` at `w = wK` is an equality. -/
theorem L52_if_psi (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1) (hcd : IsCoordDiag R)
    (Mp m : ℝ) :
    Pcubic R = (3 / 2) * (∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 3
          + 3 * Mp * (1 - ∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 2))
        - (1 / 2) * (∑ u, Bw (wK R hR hskew hsym) (ringW R) u u ^ 3
          + 3 * m * (∑ u, Bw (wK R hR hskew hsym) (ringW R) u u ^ 2 - 3)) :=
  L52_record_if R hR hskew hsym (wK R hR hskew hsym) (wK_complete R hR hskew hsym) hB hunit Mp m
    (coordDiag_frame R hR hskew hsym hcd).1 (coordDiag_frame R hR hskew hsym hcd).2

/-- **`M` diagonal in the pair basis is coordinate-diagonality**, the converse of `coordDiag_frame`'s first conjunct: an
entry `R4 i j k l` off the two pairings `(k, l) = (i, j)` or `(j, i)` is `±` an off-diagonal `Mpair` entry after ordering
both pairs, or vanishes at a repeated index. -/
theorem coordDiag_of_Mpair (hM : ∀ p q, p ≠ q → Mpair R p q = 0) : IsCoordDiag R := by
  intro i j k l hne
  by_cases hij : i = j
  · subst hij; exact R4_self_left R hR i k l
  by_cases hkl : k = l
  · subst hkl; have := R4_anti2 R hR i j k k; linarith
  have e : ∀ {a b c d : Fin n} (hab : a < b) (hcd : c < d), ¬(c = a ∧ d = b) → R4 R a b c d = 0 :=
    fun {a b c d} hab hcd h => hM ⟨(a, b), hab⟩ ⟨(c, d), hcd⟩ (fun e => h (by
      have := congrArg Subtype.val e
      simp only [Prod.mk.injEq] at this
      exact ⟨this.1.symm, this.2.symm⟩))
  have a1 := fun a b c d => R4_anti1 R hR hskew hsym a b c d
  have a2 := fun a b c d => R4_anti2 R hR a b c d
  rcases lt_or_gt_of_ne hij with h1 | h1 <;> rcases lt_or_gt_of_ne hkl with h2 | h2
  · exact e h1 h2 (fun h => hne (Or.inl h))
  · have := e h1 h2 (fun h => hne (Or.inr ⟨h.2, h.1⟩)); have := a2 i j l k; linarith
  · have := e h1 h2 (fun h => hne (Or.inr h)); have := a1 j i k l; linarith
  · have := e h1 h2 (fun h => hne (Or.inl ⟨h.2, h.1⟩)); have := a1 j i l k; have := a2 i j l k; linarith

/-- **L52's "if" half on `S²₀`**: at a first-Bianchi, unit-norm, Ricci-flat, coordinate-diagonal `W`, the display with
the record's `K'` on `S²₀` (`d_φ` on the pairs and `d_ψ = −spec(K on 𝟏^⊥)`) is an equality, `L52_if_psi` read through
L52S20's `sum_diag_split`. -/
theorem L52_if_psi_S20 (hn : 0 < n) (hB : ∀ i j k l, bianchi R i j k l = 0) (hunit : normSq R = 1)
    (hRic : ∀ a b, Ric R a b = 0) (hcd : IsCoordDiag R) (Mp m : ℝ) :
    let w := wK R hR hskew hsym
    let TK := Matrix.toEuclideanLin (Kmat R)
    let hTK : TK.IsSymmetric := Matrix.isSymmetric_toEuclideanLin_iff.mpr (Kmat_isHermitian R hR hskew hsym)
    let gK : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 (fun _ => 1)
    ∃ hWK : ∀ x ∈ (ℝ ∙ gK)ᗮ, TK x ∈ (ℝ ∙ gK)ᗮ,
      Pcubic R = (3 / 2) * (∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 3
            + 3 * Mp * (1 - ∑ p : Pairs n, Kmat R p.1.1 p.1.2 ^ 2))
          - (1 / 2) * ((Multiset.map (· ^ 3) (Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p))
                Finset.univ.val + Multiset.map (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i) Finset.univ.val)).sum
            + 3 * m * ((Multiset.map (· ^ 2) (Multiset.map (fun p : Pairs n => Bw w (ringW R) (Sum.inl p) (Sum.inl p))
                Finset.univ.val + Multiset.map (fun i => -(hTK.restrict_invariant hWK).eigenvalues rfl i) Finset.univ.val)).sum
              - 3)) := by
  intro w TK hTK gK
  obtain ⟨hWK, h3⟩ := sum_diag_split R hR hskew hsym hn hRic (· ^ 3) (by norm_num)
  obtain ⟨_, h2⟩ := sum_diag_split R hR hskew hsym hn hRic (· ^ 2) (by norm_num)
  refine ⟨hWK, ?_⟩
  have e := L52_if_psi R hR hskew hsym hB hunit hcd Mp m
  rw [e]
  simp only at h3 h2
  rw [h3, h2]

end HamiltonsCubic.SecondKind
