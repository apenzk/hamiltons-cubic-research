# Gate 2 brief: is `Bivectors2` the ambient space it claims to be?

**You are a cold reviewer.** You have not seen the work that produced this and are not told what its author concluded.

**Your subject is whether the construction does what is claimed of it.** Everything is kernel-checked on the standard three axioms, so a manipulation error is not available to you. **What survives a build is a construction that type-checks and solves nothing**: a submodule nothing interesting lives in, a definiteness theorem whose hypothesis no operator satisfies, or a topology that is not the one the record means.

Read [reviews/_g2-standing.md](_g2-standing.md) and follow it. **Analysis only**: computation needs the user's approval for a specific task and it has not been given. The one allowance is screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on objects already in hand is permitted. Name any sweep, census or unbounded search and stop.

**Log** to `agent_logs/r1005.log`.

## What to read

- [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), the file under review.
- [WeylRadical.lean](../lean/HamiltonsCubic/Results/WeylRadical.lean) for the defect it answers, and [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean) for the space it replaces.
- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) for `inner2`, `phi`, `IsSkew`, `skew_expand`, `innerOp`, `normSq`, `theta`, `IsWeyl`.
- The record's own account: [findings/INDEX.md](../findings/INDEX.md), [findings/conventions.md](../findings/conventions.md), and [plan.md](../plan.md)'s I36 item.

## Attack items

Answer every one in writing, including where you find nothing.

1. **Is `skewSub` the record's `Λ²`?** Check the three submodule clauses, and say whether the record means by a bivector exactly a skew matrix or something narrower.
2. **`eq_zero_of_phi`.** It is `skew_expand` read as a spanning statement. Verify the derivation, and say whether it needs `Fintype` or `DecidableEq` for a reason or only for the `φ` indexing.
3. **`eq_zero_of_innerOp_self`, the payoff.** **Exhibit an operator satisfying its hypothesis non-trivially**, or show the hypothesis forces `T = 0` so cheaply that the theorem says nothing. Then check the contrast claimed against [weylModule](../lean/HamiltonsCubic/Base/WeylModule.lean): is the same sum genuinely degenerate there?
4. **`CurvOp2` and the topology.** The file claims `IsLocalMaxOn` elaborates over `CurvOp2` and over neither `CurvLin` nor `Module.End`, and that the choice of norm is immaterial because all norms on a finite-dimensional real space induce one topology. **Check all three claims**, and say whether `skewSub` is in fact finite-dimensional and whether the file proves it or assumes it.
5. **Does continuity cost anything?** The file says it does not, every linear map being continuous in finite dimensions. Verify, and say whether the file's `CurvOp2` therefore holds every operator the bare type did apart from the radical.
6. **What remains before [I36](../plan.md)'s shape claim is a Lean statement over `CurvOp2`?** Name each missing piece.

## Verdict

Per item, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a verdict.** File `reviews/REVIEW_r1005.md` and add your row to [reviews/INDEX.md](INDEX.md), committing only those two paths.
