# Gate 2 brief: I36 stated in Lean, and the class its quantifier ranges over

**You are a cold reviewer.** You have not seen the work that produced these and are not told what its author concluded.

**Your subject is whether the statement is the record's claim.** It is a definition, not a theorem, so there is no proof to break. **What breaks a statement is its quantifier**: a range wider than the record's makes it false, a range narrower makes it weaker than advertised, and both type-check. *[WeylReal.lean:114](../lean/HamiltonsCubic/Base/WeylReal.lean) records that getting exactly this range wrong once made `ProblemP` a false proposition.*

Read [reviews/_g2-standing.md](_g2-standing.md) and follow it, **including its warning that a bare `lean` is the wrong toolchain**: run every check through `lake env lean`. **Analysis only**: computation needs the user's approval for a specific task and it has not been given. The one allowance is screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on objects already in hand is permitted. Name any sweep, census or unbounded search and stop.

**When you check a defeq or instance claim, name both sides explicitly and add a control that must fail.**

**Log** to `agent_logs/r1009.log`.

## What to read

- [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) and [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), the files under review.
- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for `IsWeyl` and the note at its definition, and [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) for `IsFrame`, `CoordinateDiagonal`, `rotate`, `kappaSq`, `normM2`.
- [plan.md](../plan.md)'s I36 item and [diagonal-half.md](../findings/diagonal-half.md)'s I36 section, for what the record means by the claim.
- [r1008](REVIEW_r1008.md), whose verdict this round follows.

## Attack items

Answer every one in writing, including where you find nothing.

1. **`IsWeyl2` against the record's `IsWeyl`.** Three clauses against four. **Is the missing one genuinely supplied by the type**, or is something weaker being claimed? Check the other three word for word.
2. **`isWeyl_extend`.** It claims `IsWeyl2 R` gives the record's `IsWeyl` on `extend R`. Verify. **Then ask the converse**: does every record-Weyl bare operator restrict to an `IsWeyl2` operator? If not, `IsWeyl2` is narrower than the record's class and `I36Shape` is weaker than the item.
3. **`skewProj`, `extend`, `extend_apply`, `toTensor2`, `toTensor2_apply`.** Is `extend R` an extension of `R`, and is `toTensor2` the record's tensor of it?
4. **`I36Shape`, clause by clause, against [plan.md](../plan.md)'s statement of the item.** The item says *every local maximiser above √(3/2) is coordinate-diagonal*. **Check the threshold, the norm, the maximality and the conclusion each separately**, and say for each whether it is the record's.
5. **Is `I36Shape` non-vacuous?** Exhibit an operator meeting `IsWeyl2` and `normSq2 R = 1`, or show the conjunction is empty. *The zero operator will not do, having norm zero.*
6. **Is `I36Budget` the budget form the record pairs with the shape?** Compare with [L174.lean](../lean/HamiltonsCubic/Results/L174.lean)'s `I36_budget` and with [L94](../findings/LEDGER.md)'s equality case.

## Verdict

Per item, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a verdict.** File `reviews/REVIEW_r1009.md` and add your row to [reviews/INDEX.md](INDEX.md), committing only those two paths.
