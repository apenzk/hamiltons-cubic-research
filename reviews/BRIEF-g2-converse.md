# Gate 2 brief: the converse restriction, forced linearity, and the quadratic expansion

**You are a cold reviewer.** You have not seen the work that produced these and are not told what its author concluded.

**Everything here is kernel-checked on the standard three axioms**, so a manipulation error is not available to you. **The failure to hunt is a lemma that is true and says less than its name claims**, or a construction that type-checks on a class nothing inhabits.

Read [reviews/_g2-standing.md](_g2-standing.md) and follow it, **including its warning that a bare `lean` is the wrong toolchain**: run every check through `lake env lean`. **Analysis only**: computation needs the user's approval for a specific task and it has not been given. The one allowance is screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on objects already in hand is permitted. Name any sweep, census or unbounded search and stop.

**When you check a defeq or instance claim, name both sides explicitly and add a control that must fail.**

**Log** to `agent_logs/r1010.log`.

## What to read

- [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), the file under review.
- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for `IsWeyl`, `br`, `inner2`, and [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) for `IsLinOp` and `IsWeylOp`.
- [r1009](REVIEW_r1009.md), whose owed list this round follows.

## Attack items

Answer every one in writing, including where you find nothing.

1. **`isWeyl_add` and `isWeyl_smul`: does the record's `IsWeyl` really force linearity on `Λ²`?** Check the argument. **Then state its reach exactly**: is linearity forced on all of `Λ²`, or only where the hypotheses are skew? Does anything follow for non-skew arguments?
2. **The consequence claimed for the layer.** The file says [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean)'s `IsWeylOp = IsLinOp ∧ IsWeyl` has a free first conjunct **on bivectors**. *Is that right, and is `IsLinOp` therefore redundant where the layer uses it, or does the layer use it off `Λ²` where it is not?* **This decides whether a real simplification is available or only an appearance of one.**
3. **`restrict` and `isWeyl2_restrict`.** Is `restrict hW` genuinely the restriction of `R`, and is the continuity it claims from finite dimensionality sound? **Check that `restrict` and `extend` compose to the identity in both directions**, or say which way fails.
4. **`brS_add_left`, `brS_add_right`.** The record's `br` is bilinear on matrices. Is anything lost or added in carrying that to the submodule?
5. **`sharpTerm_add`, the quadratic expansion.** Verify it. **Then say whether it is enough for `sharpBil2` to be bilinear**, or what else is needed, naming it. *The file claims it is what bilinearity rests on.*
6. **`theta2`, `theta2_of_unit`, `normSq_extend`.** Are these the record's `theta` and the right link? Check `theta2`'s denominator against [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean)'s `theta`.

## Verdict

Per item, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a verdict.** File `reviews/REVIEW_r1010.md` and add your row to [reviews/INDEX.md](INDEX.md), committing only those two paths.
