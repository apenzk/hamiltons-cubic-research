import HamiltonsCubic.Results.L37Statement

set_option linter.style.longLine false

/-!
# L163, L37's two witnesses, and why a constant block certifies non-diagonality

**The record's statement**, [target.md](../../../findings/target.md)'s Lemma L163, Gate 2 passed by
[r737](../../../reviews/REVIEW_r737.md) and [r738](../../../reviews/REVIEW_r738.md):

> (a) `ker Φ_{W_ℂPᵐ} = ℝ·Id` at every `m ≥ 2`.
> (b) `dim ker Φ_{W₀⊕0} = dim ker Φ_{W₀} + C(k+1,2) + k·dim K(W₀)`, an EQUALITY.
> (c) Padded `W_ℂP²` at `n = 8` has `dim ker Φ = 11 > 8 = n` **and is non-diagonal**, so
> [L37](L37Statement.lean)'s corollary runs one way only.

## What is proved here

**(c)'s mechanism, stated abstractly.** *The record's argument is that every kernel element is
`a·Id₄ ⊕ B`, whose sum `aᵢ + aⱼ` equals `2a` six times over on the first block, so no kernel element
has pairwise-distinct sums.* **What carries that is a fact about the spectrum alone**: a value
repeated at four indices defeats [L37](L37Statement.lean)'s `DistinctSums`, whatever the matrix.

*This is the half that generalises. The record reaches it through `W_ℂP²` at one dimension; the
obstruction is the repeated block, and stating it that way makes the witness an instance.*

## What is NOT proved here

**(a) and (b).** *(a) needs `δ_{A₀}` exchanging `Λ⁺` and `Λ⁻` for trace-free symmetric `A₀`, which
needs the self-dual splitting at `n = 4` as an `SO(4)`-representation; (b) is a dimension count over
a padded decomposition.* Neither is stated as a Lean proposition here, so neither reads as proved.

**And [L37](L37Statement.lean)'s own `diagonality_criterion` carries a `sorry`**, so the chain from
this lemma to non-diagonality is complete only once that closes. *That debt is L37's, not this
file's.*
-/

namespace HamiltonsCubic.L163Statement

open Matrix Finset HamiltonsCubic.L37

variable {n : ℕ}

/-- **A value repeated at four distinct indices defeats `DistinctSums`.** *If `a` is constant on
`{i, j, k, l}` with `i < j`, `k < l` and `(i,j) ≠ (k,l)`, the two pairs carry the same sum while
being different pairs, which is exactly what `DistinctSums` forbids.* -/
theorem not_distinctSums_of_const_four {A : Matrix (Fin n) (Fin n) ℝ}
    (g : Matrix (Fin n) (Fin n) ℝ) (hg : gᵀ * g = 1) (a : Fin n → ℝ)
    (hA : A = g * Matrix.diagonal a * gᵀ)
    (i j k l : Fin n) (hij : i < j) (hkl : k < l) (hne : ¬(i = k ∧ j = l))
    (hc : a i = a k) (hc2 : a j = a l) :
    ¬ (∀ p q r s : Fin n, p < q → r < s → a p + a q = a r + a s → p = r ∧ q = s) := by
  intro h
  exact hne (h i j k l hij hkl (by rw [hc, hc2]))

/-- **The constant block, in the form the record uses it.** *On a block where `a` takes one value
at four indices, the two pairs `(i,j)` and `(k,l)` from that block carry the same sum, so the
spectrum cannot have pairwise-distinct sums.* -/
theorem const_block_repeats_sums (a : Fin n → ℝ) (c : ℝ)
    (i j k l : Fin n) (hij : i < j) (hkl : k < l) (hne : ¬(i = k ∧ j = l))
    (hi : a i = c) (hj : a j = c) (hk : a k = c) (hl : a l = c) :
    a i + a j = a k + a l ∧ ¬(i = k ∧ j = l) := by
  refine ⟨?_, hne⟩
  rw [hi, hj, hk, hl]

end HamiltonsCubic.L163Statement
