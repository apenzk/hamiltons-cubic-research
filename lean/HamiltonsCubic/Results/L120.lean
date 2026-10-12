import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith

/-!
# L120, the sign-character decomposition, and two corrections

[second-order.md](../../../findings/second-order.md)'s Lemma L120. The decomposition is exact
and the block sizes are the full isotypic dimensions; two things around it needed repair.

**The printed `n-3` fails at exactly one dimension.** The largest non-diagonal block is
`max(2, n-3)`, and the two agree from `n = 5` on, so within the range `n ≥ 4` they differ
**only at `n = 4`**, where the printed value is `1` and the true one is `2`. That is proved as
an implication, so the exception is located rather than spotted.

**The omitted quotient made the condition unsatisfiable.** The sentence all thirteen citations
quote left out cutting `𝒟ₙ` by `⟨M⟩`. The reason is the record's: `e = M/θ` lies in `𝒟ₙ` and
`L_e e = e`, so read without the cut the criterion meets `λ_max(L_e|_{𝒟ₙ}) ≥ 1 > ½`, and the
literal reading excludes every diagonal critical point. Both facts are declared in
[L120Cut.lean](L120Cut.lean): `diag_e_eigen` (`L_e e = e` at a unit critical diagonal Weyl
operator) and `diag_in_trivial` (the diagonal operator is fixed by every sign flip, so lies in
`𝒟ₙ`). The same file ties `blockSize` to the proved summand dimensions (`blockSize_eq`).

**Criticality is unused** (diagonality alone suffices), the sixth block found carrying a
hypothesis its proof does not touch: [L120Block.lean](L120Block.lean)'s `L120_block_diag` takes a
diagonal operator and the sign group, and no critical-point hypothesis.
-/

namespace HamiltonsCubic.SignCharacters

/-! ## The block size -/

/-- The true largest non-diagonal block. -/
def blockSize (n : ℕ) : ℕ := max 2 (n - 3)

/-- **From `n = 5` on the printed `n-3` is right.** -/
theorem agrees_from_five (n : ℕ) (hn : 5 ≤ n) : blockSize n = n - 3 := by
  unfold blockSize; omega

/-- **At `n = 4` it is not**: the printed value is `1` and the true one is `2`. -/
theorem differs_at_four : blockSize 4 = 2 ∧ (4 : ℕ) - 3 = 1 := by
  refine ⟨by decide, by decide⟩

/-- **And `n = 4` is the only exception in range**, proved as an implication, so the
exception is located rather than spotted. -/
theorem only_exception (n : ℕ) (hn : 4 ≤ n) (h : blockSize n ≠ n - 3) : n = 4 := by
  unfold blockSize at h; omega

end HamiltonsCubic.SignCharacters
