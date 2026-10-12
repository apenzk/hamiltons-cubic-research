# Gate 2 brief: the non-vacuity witness, the inner product, and three carried corrections

**You are a cold reviewer.** You have not seen the work that produced these and are not told what its author concluded.

**Your subject is whether each statement is the one claimed.** All are kernel-checked on the standard three axioms, so a manipulation error is not available to you. **Two failure modes to hunt**: a witness that satisfies a debt's letter while missing what the debt was for, and an instance that type-checks while shadowing or contradicting one already present.

Read [reviews/_g2-standing.md](_g2-standing.md) and follow it. **Analysis only**: computation needs the user's approval for a specific task and it has not been given. The one allowance is screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on objects already in hand is permitted. Name any sweep, census or unbounded search and stop.

**Log** to `agent_logs/r1006.log`.

## What to read

- [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) and [WeylRadical.lean](../lean/HamiltonsCubic/Results/WeylRadical.lean), the files under review.
- [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean) for `weylTrace_id` and the debt it records, and [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) for `diagOp`, `IsWeight`, `sphereWeight`.
- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for `inner2`, `phi`, `normSq`, `theta`.
- The record's own conventions: [findings/conventions.md](../findings/conventions.md) and [findings/INDEX.md](../findings/INDEX.md).

## Attack items

Answer every one in writing, including where you find nothing.

1. **`sphereWeight_diagOpL_ne_zero`, the non-vacuity witness.** [weylTrace_id](../lean/HamiltonsCubic/Base/WeylModule.lean)'s docstring recorded that every statement there was consistent with `dim 𝒲ₙ = 0`. **Does this witness actually establish `dim 𝒲ₙ ≥ 1`, or only that some member of `weylModule` is nonzero?** The distinction is the whole point: `symOp` in the same file is nonzero and lies in the radical. State precisely what the witness gives.
2. **`diagOpL`.** Is it the same operator as `diagOp`, bundled, with nothing changed? Check `map_add'` and `map_smul'` against the lemmas they cite.
3. **`skewCore` and the inner product.** Check all five fields against the record's `inner2`. **Is the resulting norm the record's?** `norm_phi` claims `‖φ_ij‖ = 1`: verify, and say whether that is the normalisation under which the record's catalogued θ values were computed, quoting [conventions.md](../findings/conventions.md).
4. **The no-diamond claim.** The file says the topology the norm induces is the same INSTANCE as the subtype one, checked by `rfl`. **Verify it**, and say whether any instance declared here shadows or competes with one already in the layer.
5. **The three corrections carried from [r1005](REVIEW_r1005.md)**: that the topology comes from the arrow rather than the domain, that `Fintype` is load-bearing in `eq_zero_of_phi`, and that `eq_zero_of_phi_sq_sum` is not about `innerOp`. **Were they carried faithfully, or overstated in either direction?**
6. **The stated boundary.** The file says `Norm (skewSub ι →L[ℝ] skewSub ι)` does not synthesize and calls this library plumbing. **Confirm or refute**, and if you can name the import that would supply it, do.

## Verdict

Per item, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a verdict.** File `reviews/REVIEW_r1006.md` and add your row to [reviews/INDEX.md](INDEX.md), committing only those two paths.
