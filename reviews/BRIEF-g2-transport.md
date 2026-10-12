# Gate 2 brief: the withdrawal, the inverted ranking, and the transported definitions

**You are a cold reviewer.** You have not seen the work that produced these and are not told what its author concluded.

**Your subject is whether each claim is the one the record needs.** Everything is kernel-checked on the standard three axioms, so a manipulation error is not available to you. **The failure to hunt is a transported definition that type-checks and is not the record's**, differing by a factor, a quantifier, or a domain, in a way no build can see.

Read [reviews/_g2-standing.md](_g2-standing.md) and follow it. **Analysis only**: computation needs the user's approval for a specific task and it has not been given. The one allowance is screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on objects already in hand is permitted. Name any sweep, census or unbounded search and stop.

**Log** to `agent_logs/r1007.log`.

## What to read

- [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), the file under review, and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for the definitions it transports: `inner2`, `innerOp`, `normSq`, `compOp`, `trCube`, `br`, `sharpQF`, `Pcubic`.
- [WeylRadical.lean](../lean/HamiltonsCubic/Results/WeylRadical.lean) for the defect the change of domain answers.
- The record's own account: [findings/conventions.md](../findings/conventions.md), [findings/INDEX.md](../findings/INDEX.md), [plan.md](../plan.md)'s I36 item.

## Attack items

Answer every one in writing, including where you find nothing.

1. **`innerOp2` and `normSq2` against `innerOp` and `normSq`.** Are they the record's definitions with the domain changed and nothing else? **Check the `½` and the summation range**, and say whether `normSq2 R` and `normSq` of the same operator read as a bare function agree where both are defined.
2. **`normSq2_eq_zero`.** Verify it, and say what it would take for the hypothesis to be met non-trivially. Then check the contrast: is `normSq` genuinely degenerate on [weylModule](../lean/HamiltonsCubic/Base/WeylModule.lean)?
3. **`br_mem_skewSub`.** Verify the transposition argument. Then say whether it is enough to express `sharpQF` on this domain, or whether something further is needed, naming it.
4. **`compOp2` and `trCube2`.** Is composition of continuous linear maps the record's `compOp`? Is `trCube2` its `trCube`?
5. **THE CLAIM THAT A `Norm` INSTANCE IS NOT ON THE CRITICAL PATH.** The file argues from two facts: that `IsLocalMaxOn` over `CurvOp2` elaborates without one, and that the record states unit norm as `normSq R = 1` rather than `‖R‖ = 1`. **Check both, and check the inference.** Is there anything in the record or in [r1005](REVIEW_r1005.md) that a missing `Norm` would still block?
6. **The withdrawal of the norm instances.** The file says registering `skewCore` produced an inconsistent diamond and that the elementwise matrix norm would not. **Verify both**, including the claim that the elementwise norm's topology is defeq to the one already on `Matrix`.

## Verdict

Per item, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a verdict.** File `reviews/REVIEW_r1007.md` and add your row to [reviews/INDEX.md](INDEX.md), committing only those two paths.
