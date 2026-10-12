# Gate 2 brief: four claims about the two-layer bridge and the layer's own `𝒲ₙ`

**You are a cold reviewer.** You have not seen the work that produced these and are not told what its author concluded.

**Your subject is whether each statement is the one claimed, not whether its proof is right.** All are kernel-checked on the standard three axioms, so a manipulation error is not available to you. **What survives a build is a statement that type-checks and is not the result**: quantified over the wrong class, weakened to something it implies, vacuous, or true of an object nobody means.

Read [reviews/_g2-standing.md](_g2-standing.md) and follow it. **Analysis only**: computation needs the user's approval for a specific task and it has not been given. The one allowance is screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on objects already in hand is permitted. Name any sweep, census or unbounded search and stop.

**Log** to `agent_logs/r1004.log`.

## What to read

- [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) and [WeylRadical.lean](../lean/HamiltonsCubic/Results/WeylRadical.lean), the files under review.
- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for `inner2`, `phi`, `IsWeyl`, `bianchi`, `Ric`, `normSq`, `theta`; [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean) for `CurvLin`, `IsWeylL`, `weylModule`; [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) for `normM2`, `full4`, `normM2_quarter`; [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) for `sum_inner2_phi`.
- The record's own account: [findings/INDEX.md](../findings/INDEX.md), [findings/conventions.md](../findings/conventions.md), and [plan.md](../plan.md)'s I36 and I108 items.

## Attack items

Answer every one in writing, including where you find nothing.

1. **`Rphi_swap`, that `IsWeyl` alone gives `R φ_ba = -R φ_ab`.** The argument runs through `Z = R φ_ba + R φ_ab` being skew, self-adjointness at both arguments, and the pairing being a sum of squares over `ℝ`. Check each step, and say whether the conclusion needs the first clause of `IsWeyl` or only the second.
2. **`normM2_toTensor`, that the bridge is an isometry with no factor.** Verify it against `sum_inner2_phi` and `normM2_quarter` independently of the file's own route. **State whether the equality would survive rescaling `inner2`**, and if not, say which side moves.
3. **The bundled restatement.** `toTensorL`, `isWeyl_toTensorL`, `normM2_toTensorL`, `isWeyl_toTensorL_mem` and `finiteDimensional_weylModule`. Do these say anything the bare versions do not, or are they the same theorems retyped? Say plainly which.
4. **`symOp`, the radical claim.** That `X ↦ X + Xᵀ` is linear, lies in `weylModule`, is nonzero, and has `normSq = 0`. **Check the membership clause by clause**, and then answer the consequence: is it correct that `innerOp` is therefore not definite on `weylModule`, and that `theta` divides by zero there?
5. **The scope of item 4.** Which recorded results, if any, quantify over `IsWeyl` or `weylModule` in a way this radical makes weaker or vacuous? Name them, or say that none does. *This is the item that decides whether the finding is a curiosity or a defect.*
6. **What the four together do and do not give [I36](../plan.md).** State precisely what remains before I36's shape claim can be written as a Lean statement.

## Verdict

Per item, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a verdict.** File `reviews/REVIEW_r1004.md` and add your row to [reviews/INDEX.md](INDEX.md), committing only those two paths.
