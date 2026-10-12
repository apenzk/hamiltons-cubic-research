# ROUND_L19, the lift, the rigidity and the sharpening

**Date:** 2026-09-07. **Phase:** 6, closed without a verifier dispatch. **Verdict:** the entry was already `WITHDRAWN` in [findings/](../findings/); the round's work was propagation and a sweep.

## Why no verifiers were spawned

**The entry carries two Gate 2 verdicts of `NO CHECKABLE STATEMENT` already**, [r605](../reviews/REVIEW_r605.md) and [r606](../reviews/REVIEW_r606.md), independently, and [problem.md](../findings/problem.md) heads it `WITHDRAWN`. *A round on a withdrawn entry buys less than a round on a live one*, which is the queue's own standing reason, recorded when L152 was demoted for exactly this.

**What was live is what the withdrawal never reached.** [results.md](../results.md) still headed it `Lemma L19` over a heading with **no statement under it at all** (a bare `Proof:` pointer) and its landscape bullet still asserted all three claims as facts, including the *"strictly weaker than [Conjecture L16](../findings/problem.md)"* the withdrawal calls incomparable.

## The sweep this round ran, and it bounds the failure

**Three consecutive rounds had found the same shape, a repair landing in [findings/](../findings/) and never reaching [results.md](../results.md).** Three instances is a pattern worth measuring rather than repairing one at a time, so every block that [findings/](../findings/) heads `WITHDRAWN` was checked against its canonical entry.

**Ten withdrawn blocks. Eight propagated correctly. Two did not: L19, and L14.** Both presented the same way, an empty heading with a bare proof pointer, and a landscape bullet still asserting the claim.

- **L14** promised a bound on $\langle W^\#,W\rangle$ and displayed no inequality, withdrawn by [r462](../reviews/REVIEW_r462.md) and [r463](../reviews/REVIEW_r463.md); its landscape bullet described the candidate as live work.

**Both are now withdrawn in [results.md](../results.md), canonical entry and landscape bullet.** *The failure rate is one in five and not the systemic collapse three consecutive instances suggested, which is why the sweep was worth more than a fourth repair.*

## Queue change

**L19 leaves the queue as `WITHDRAWN`, not as checked.** A withdrawn entry has no proposition for three verifiers to attack, and the audit's unit is a claim.
