# REVIEW r1648: L127DnCount.lean (dn_dim_sum, dn_finrank_sum) and r1646's repairs, commit 80fe82af

**Verdict: CONFIRMED WITH GAPS.** Both declarations are correct, faithful and clean on the axiom audit, and r1646's G1 and G2 are repaired. Two sibling headers now carry stale "not yet declared" lines that this commit's count, or the earlier L127DnDim, discharged.

Reviewer: cold adversarial Gate 2, analysis only. Log: [agent_logs/review-l127dncount.log](../agent_logs/review-l127dncount.log). Screen run: `python3 scripts/misc/axiom_audit.py --only L127DnCount.lean`, a screen of the axioms only.

Source: [findings/second-order.md](../findings/second-order.md), "#### Lemma L127", the `D_n` row, `σ(L_e|D_n) = {1, λ_p^{p−1}, λ_q^{q−1}, (−μ)^{(p−1)(q−1)}, 0^rest}`, with `D_n` the symmetric hollow zero-row-sum weights of dimension `n(n−3)/2` (second-order.md:1184, :1639).

## Claims

| # | Claim | Verdict | Notes |
| --- | --- | --- | --- |
| 1 | `dn_dim_sum` is correct at p, q ≥ 3 and is the record's count | CONFIRMED | By hand: `1 + (p−1) + (q−1) + (p−1)(q−1) = pq` and `binom(p+q,2) = binom p 2 + binom q 2 + pq`, so both sides equal `binom p 2 + binom q 2 + pq − p − q`. Every ℕ-subtraction is untruncated at p, q ≥ 3 (`binom 3 2 − 3 = 0`). The hypothesis is load-bearing: at p = 2 the truncated `binom 2 2 − 2 = 0` replaces the true `−1` and the LHS exceeds the RHS by exactly 1. The rest count `p(p−3)/2 + q(q−3)/2` is the record's `0^rest`, since `λ_p = (p−2)/(2(p−1)) > 0`, `−μ < 0` and `1` are nonzero at p, q ≥ 3 (L127DnUnits.lean:18-19). |
| 2 | `dn_finrank_sum` adds exactly `dn_decomp`'s six families and equals `finrank_weights` | CONFIRMED | The six submodules are `span{sphereWeight T}`, `range (lamMap T (dnK T))`, `range (lamMap Tᶜ (dnK Tᶜ))`, `crossSub T` (`IsCrossW T`), `withinSub T` and `withinSub Tᶜ` (`IsWithinW`), which are `dn_decomp`'s conjuncts at L127DnSpan.lean:171-174 with the same κ = `dnK`. `lamMap`'s range is exactly the `lamW` of functions summing to zero on S, since `lamW` reads `h` only on S (`mem_range_lamMap` one way, `extF` the other). The RHS is `finrank (ker rowSumL)`, the record's `D_n`. The statement is about named subspaces, so it is a dimension statement and is faithful. Its proof is the declared finrank lemmas plus `dn_dim_sum`, which is expected. |
| 3a | r1646 G1 repaired | CONFIRMED | lean/INDEX.md:495 now reads "forcing $c=0$, $h=0$ on $T$ and $h'=0$ on $T^c$", matching L127DnDirect.lean:15-16. |
| 3b | r1646 G2 repaired | CONFIRMED | L127DnDim.lean:7 is titled "the dimension of each", :26-27 call them "the counts the record's row carries" and :27-28 owe the passage to multiplicities. |
| 3c | No passage claims eigenvalue multiplicities as declared | CONFIRMED WITH GAPS | The L127 row names "multiplicit" once, in **Owed**. L127DnCount.lean:13 reads "so `0^{rest}` counts ...", a gloss that is correct by claim 1 and states a count in the record's notation. Stale sibling lines remain: G1, G2. |
| 4 | Axiom audit | CONFIRMED | 2/2 clean, resting on the standard three alone, matching the commit body and the INDEX's "2/2". |

## What would break each claim, and where I looked

- **Claim 1**: an ℕ-truncation making the identity hold vacuously or only by `omega` on garbage. I evaluated both sides symbolically and at p = 2 to confirm the p, q ≥ 3 hypothesis is the true boundary.
- **Claim 2**: a family in the sum differing from `dn_decomp`'s (a different κ, the sphere line at `Tᶜ`, a within family not hollow or not zero-row-sum) or the RHS being a space other than `D_n`. I read `IsCrossW`, `IsWithinW`, `lamW`, `lamMap`, `sphereWeight`, `rowSumL` and `dn_decomp` side by side.
- **Claim 3**: any L127 row or `D_n` file sentence presenting the six dimensions as eigenvalue multiplicities. I grepped the INDEX row and every L127Dn*.lean header for "multiplicit".

## Gaps

- **G1 (prose, minor, downstream), [L127DnUnits.lean:23-24](../lean/HamiltonsCubic/Results/L127DnUnits.lean).** "*Not yet declared*: the multiplicities, `1 + (p − 1) + ... = n(n − 3)/2` at `p, q ≥ 3`" presents as undeclared the identity `dn_dim_sum` now declares. It should cite L127DnCount's `dn_dim_sum` and owe only the passage to multiplicities.
- **G2 (prose, minor, pre-existing), [L127DnSpan.lean:30-31](../lean/HamiltonsCubic/Results/L127DnSpan.lean).** "*Not yet declared*: the multiplicities, the dimension of each family, ..." has been stale since L127DnDim declared the family dimensions. It should point to L127DnDim and L127DnCount and keep the p = 2 or q = 2 spanning.
- **G3 (scope note), [L127DnCount.lean:6 and :40](../lean/HamiltonsCubic/Results/L127DnCount.lean).** The header's "exhaust `D_n`" is a dimension count. No declaration yet combines `dn_decomp`, `dn_direct` and `dn_finrank_sum` into an internal direct sum, and **Owed** already carries that.
