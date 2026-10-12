import HamiltonsCubic.Results.L83
import Mathlib.Algebra.MvPolynomial.Funext
import Mathlib.Data.Real.Basic
import Mathlib.LinearAlgebra.FiniteDimensional.Defs
import Mathlib.LinearAlgebra.Dimension.Finite

/-!
# L91, the witness `Δ = Σ q_a²` is nonzero

[sym3-blocks.md](../../../findings/sym3-blocks.md), Lemma L91: the identity Gram on `K` maps to
`Δ = Σ_a q_a²` over an apolar-orthonormal basis `{q_a}` of `K`, and `Δ ≠ 0` because `K ≠ 0`, its codimension
in `Sym³` being at most `3570 < 7770`, so some `q_a ≠ 0` and `Δ(W) ≥ q_a(W)² > 0` at a real `W` with
`q_a(W) ≠ 0`.

Proved here, the argument behind `Δ ≠ 0`:

* **`sos_pos`**: a finite sum of squares of real polynomials with one nonzero term is positive at some real
  point, since a nonzero real polynomial is nonzero somewhere (`MvPolynomial.funext`);
* **`K_ne_bot`**: a subspace of codimension at most L83's even-block cap (`3570`, `cap_even`) in a space of
  dimension L83's multiplicity total (`7770`, `sum_mult_dim`) is nonzero;
* **`L91_witness`**: the two together, for any family spanning `K`. Spanning `K` is what supplies a nonzero
  member, so the block's apolar-orthonormal basis is one instance.

The map `μ_K` from invariant Grams to invariant sextics, and the identification of the identity Gram's image
with `Δ`, are not typed: the layer has no model of the apolar product on `Sym³ 𝒲₅` or of its invariants.
-/

namespace HamiltonsCubic.L91Proof

open MvPolynomial Module HamiltonsCubic.Blocks

/-- **A sum of squares with a nonzero term is positive somewhere.** -/
theorem sos_pos {σ ι : Type*} (s : Finset ι) (q : ι → MvPolynomial σ ℝ) {a : ι} (ha : a ∈ s)
    (hq : q a ≠ 0) : ∃ x : σ → ℝ, 0 < eval x (∑ b ∈ s, q b ^ 2) := by
  by_contra h
  simp only [not_exists, not_lt] at h
  apply hq
  have : Infinite ℝ := Infinite.of_injective (fun n : ℕ => (n : ℝ)) Nat.cast_injective
  apply MvPolynomial.funext
  intro x
  have hle := h x
  rw [map_sum] at hle
  have hterm : eval x (q a ^ 2) ≤ ∑ b ∈ s, eval x (q b ^ 2) :=
    Finset.single_le_sum (f := fun b => eval x (q b ^ 2)) (fun b _ => by rw [map_pow]; exact sq_nonneg _) ha
  rw [map_pow] at hterm
  have : eval x (q a) ^ 2 = 0 := le_antisymm (by linarith) (sq_nonneg _)
  rw [map_zero]
  exact pow_eq_zero_iff (two_ne_zero) |>.mp this

/-- **`K ≠ 0`**: its codimension is at most L83's even-block cap, below L83's total. -/
theorem K_ne_bot {V : Type*} [AddCommGroup V] [Module ℝ V] [FiniteDimensional ℝ V] (K : Submodule ℝ V)
    (hV : finrank ℝ V = (table.map (fun B => B.mult * B.d)).sum)
    (hcodim : finrank ℝ V - finrank ℝ K ≤ ((table.filter Block.evenSecond).map Block.d).sum) : K ≠ ⊥ := by
  rw [sum_mult_dim] at hV
  rw [cap_even] at hcodim
  intro hK
  rw [hK, finrank_bot ℝ V] at hcodim
  omega

/-- **L91's witness.** Let `S` be a space of real polynomials of dimension `7770` and `K ≤ S` of codimension at
most `3570`, spanned by a finite family `q`. Then `Δ = Σ_a q_a²` is positive at some real point, so `Δ ≠ 0`. -/
theorem L91_witness {σ ι : Type*} [Fintype ι] (S K : Submodule ℝ (MvPolynomial σ ℝ)) [FiniteDimensional ℝ S]
    (hKS : K ≤ S) (hS : finrank ℝ S = (table.map (fun B => B.mult * B.d)).sum)
    (hcodim : finrank ℝ S - finrank ℝ K ≤ ((table.filter Block.evenSecond).map Block.d).sum)
    (q : ι → MvPolynomial σ ℝ) (hspan : Submodule.span ℝ (Set.range q) = K) :
    ∃ x : σ → ℝ, 0 < eval x (∑ a, q a ^ 2) := by
  have hK' : K.comap S.subtype ≠ ⊥ := by
    refine K_ne_bot (K.comap S.subtype) hS ?_
    have : finrank ℝ (K.comap S.subtype) = finrank ℝ K := by
      have e := Submodule.comapSubtypeEquivOfLe hKS
      exact e.finrank_eq
    rw [this]; exact hcodim
  have hK : K ≠ ⊥ := fun h => hK' (by rw [h, Submodule.comap_bot, Submodule.ker_subtype])
  obtain ⟨a, ha⟩ : ∃ a, q a ≠ 0 := by
    by_contra h
    simp only [not_exists, not_not] at h
    apply hK
    rw [← hspan, Submodule.span_eq_bot]
    rintro _ ⟨a, rfl⟩
    exact h a
  exact sos_pos Finset.univ q (Finset.mem_univ a) ha

end HamiltonsCubic.L91Proof
