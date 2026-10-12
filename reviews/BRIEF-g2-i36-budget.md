# Gate 2 brief: does `I36Budget` discharge what [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) carries?

**You are a cold reviewer.** You have not seen the work that produced this and you are not told what its author concluded.

**Your subject is whether the instantiation is the real thing, not whether the proofs are right.** Everything named is kernel-checked on the standard three axioms, so a manipulation error is not available to you. **An instantiation can type-check and discharge nothing**: by choosing a `Weyl` type nothing inhabits, by choosing an `IsUnit` no object satisfies, or by instantiating at predicates that are not the record's objects. That is what to hunt.

Read [reviews/_g2-standing.md](_g2-standing.md) and follow it. **Analysis only**: computation needs the user's approval for a specific task and it has not been given. The one allowance is screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. A run of a few minutes on objects already in hand is permitted. Name any sweep, census or unbounded search and stop.

**Log** to `agent_logs/r1002.log`.

## What to read

- [I36Budget.lean](../lean/HamiltonsCubic/Results/I36Budget.lean), the file under review.
- [L174.lean](../lean/HamiltonsCubic/Results/L174.lean), whose abstract `L94`, `I36_shape`, `I36_budget` and `shape_iff_budget` it instantiates.
- [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean), for `kappaSq`, `normM2`, `IsFrame`, `rotate`, `CoordinateDiagonal`, `kappaSq_eq_iff` and `kappaSq_eq_two_iff`.
- The record's own account: [findings/INDEX.md](../findings/INDEX.md), the file it names for the diagonal locus, [findings/LEDGER.md](../findings/LEDGER.md) for L94 as the record states it, and [plan.md](../plan.md)'s I36 item.

## Attack items

Answer every one in writing, including where you find nothing.

1. **Is `WeylT n` inhabited, and by anything interesting?** Exhibit a member. A subtype nothing satisfies makes every statement below vacuous.
2. **Is `IsUnitC` satisfiable together with `IsWeyl`?** Exhibit an object satisfying both, or show the conjunction is empty. `normM2 W = 1` is a normalisation, and the record elsewhere normalises by `tr M² = 2`: say whether these agree, and if not, whether `kappaSq_eq_two_iff` is stated at the normalisation its `κ² = 2` needs.
3. **Is `IsCoordDiagonalC` the record's "diagonal in some frame"?** It reads `CoordinateDiagonal (rotate F.1 W.1)`. Compare with what [plan.md](../plan.md)'s I36 means and with L94's own statement in [LEDGER.md](../findings/LEDGER.md).
4. **Is `kappaSqC` the record's `κ²`?** `kappaSq` is a `sSup` over frames. Say whether the supremum is attained, whether the file proves that, and whether an unattained supremum would break `kappaSq_eq_two_iff`.
5. **Does `l94_concrete` actually have the type `L94` at those instantiations**, with no implicit argument silently different from L174's? Check the binders.
6. **What does `shape_iff_budget_concrete` leave open?** State precisely what it does and does not give I36. `theta` and `IsLocalMax` are universally quantified in it: say whether that strengthens or weakens the statement, and whether the threshold `t` plays any role in the proof.
7. **Does this discharge [plan-lean.md](../plan-lean.md)'s `L94` row?** That row names two `Prop`s of the same name, in [L174.lean](../lean/HamiltonsCubic/Results/L174.lean) and [L174Statement.lean](../lean/HamiltonsCubic/Results/L174Statement.lean). Say which one this reaches and whether the other is also reachable.

## Verdict

Per item, one of `confirmed`, `refuted`, `withdrawn`, or `no argument on file`. **Silence is not a verdict.** File `reviews/REVIEW_r1002.md` and add your row to [reviews/INDEX.md](INDEX.md), committing only those two paths.
