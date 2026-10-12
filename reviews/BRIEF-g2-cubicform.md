# Gate 2 brief: Fermat at the operators, and the transported cubic form

**You are a cold reviewer.** You have not seen the work that produced these and are not told what its author concluded.

**Your subject is whether the transported definitions are the record's and whether the instances are sound.** Everything is kernel-checked on the standard three axioms. **Two failure modes**: a definition that type-checks and differs from the record's by a factor, a range or a domain; and an instance registered where one already exists, or whose topology is not the ambient one.

Read [reviews/_g2-standing.md](_g2-standing.md) and follow it, **including its warning that a bare `lean` is the wrong toolchain**: run every check through `lake env lean`. **Analysis only**: computation needs the user's approval for a specific task and it has not been given. The one allowance is screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on objects already in hand is permitted. Name any sweep, census or unbounded search and stop.

**When you check a defeq or instance claim, name both sides explicitly and add a control that must fail.** This author wrote a check this session whose two sides resolved to the same instance, so it could not fail.

**Log** to `agent_logs/r1008.log`.

## What to read

- [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), the file under review.
- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for `sharpQF`, `sharpBil`, `sharpOp`, `sharpPair`, `Pcubic`, `trCube`, `br`, `innerOp`, `normSq`.
- [r1007](REVIEW_r1007.md), whose verdict this round follows, and [WeylRadical.lean](../lean/HamiltonsCubic/Results/WeylRadical.lean) for the defect the domain change answers.

## Attack items

Answer every one in writing, including where you find nothing.

1. **`brS`, `sharpQF2`, `sharpBil2` against the record's.** Check the `¼`, the `½`, the summation ranges and the order of the two brackets. **Is `sharpQF2 R η` the record's `sharpQF` of the same operator read as a bare function, at every `η` in `Λ²`?**
2. **`sharpMap` against `sharpOp`.** The file claims it lands in `Λ²` by construction and so needs no skewness side condition. Verify, and say whether dropping that condition changes what the map is on the record's own domain.
3. **`sharpPair2` and `Pcubic2`.** Are they the record's, with the domain changed and nothing else?
4. **THE THREE INSTANCE REGISTRATIONS.** `NormedAddCommGroup (CurvOp2 ι)`, `NormedSpace ℝ (CurvOp2 ι)`, and the scoped Frobenius norm they rest on. **Does any of them shadow or conflict with an instance already in the layer or in Mathlib?** Is the topology they induce on `CurvOp2` the one `IsLocalMaxOn` was already using before they were added? *That last question decides whether every earlier statement over `CurvOp2` still means what it meant.*
5. **Fermat.** `isLocalMaxOn_fderivWithin_nonpos` and its two-sided form. Are they Mathlib's theorems at this type with nothing weakened? **Exhibit a use**, or show the hypotheses cannot be met here.
6. **What remains before [I36](../plan.md)'s shape claim is a Lean statement over `CurvOp2`?** The file says coordinate-diagonality and a `CurvOp2 → Tensor4` bridge. Confirm or correct, and name anything else.

## Verdict

Per item, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a verdict.** File `reviews/REVIEW_r1008.md` and add your row to [reviews/INDEX.md](INDEX.md), committing only those two paths.
