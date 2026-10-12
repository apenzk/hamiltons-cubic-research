# Reviewer 291, PARTIAL

**This is a salvaged log, not a verdict. Nothing in it may be cited until rebuilt from the object's own definition.**

Reviewer 291 audited the same brief as [Reviewer 292](REVIEW_r292.md), the symmetry defect on the diagonal locus, claims C1–C9. It ran for over three hours, wrote its scripts to [scripts/reviewers/r291/](../scripts/reviewers/r291/) including one named `r291_final.py`, and stopped with no process and no report. Its log stops after the phase-3 transition, so the phases covering C4 onward and the C7–C9 addendum are unrepresented here even though scripts for them exist.

**What this costs:** the round on Lemma L68 is single-audited, resting on Reviewer 292 alone. See [LEDGER.md](../findings/LEDGER.md).

## The log, verbatim

```
PID 14050 START 2026-08-31T20:12:04Z phases: 1 read-defs 2 derive-C1 3 numeric-check-C1C2 4 C3 5 C4 6 C5 7 C6 8 report
20:15:47 PHASE2 done: C1 verified analytically (c_abc=+-1 iff triangle) and numerically (sorted g matches, Delta matches record to 1e-16, n=4..8). C3 total=4(n-1)-2||M1||^2 exact on 9 non-Ricci-flat samples.
21:09:50 ADDENDUM C7-C9 received. Killed slow n>=8 job (einsum N^6). Derived: g_ab = 2(s_a+s_b) - 4 M_ab^2 - 4 (M^2)_ab for ANY hollow symmetric M; criticality (M^2)_ab = theta M_ab - M_ab^2 turns it into C7. C7 summed with weight M_ab and row-sum-zero gives the record's -4theta. C9 = C7 summed over G+ plus sum_+ M = ||M||_1/2.
21:10:46 PHASE3: fast diagonal defect validated against record defect() and my slow rotated-einsum path at n=4..8 (identical to 1e-10); my theta = P matches theta_screened. C1,C2,C3,C5 confirmed; C4 brute force clean at n=4,5 over all integer locus points in {-2..2}.
21:16:36 PHASE4: C6 numerics: max theta on the diagonal locus = theta_0 for n=4,6,8,10,12 (no violation); odd n falls short. C7/C8/C9 exact (1e-15) at 8 sphere products + C5 blow-up; C8 equality at all of them incl C5. C8 off-criticality violated by up to +0.31 => not vacuous. Cap sup over the locus ~2x theta_0 => entry-free relaxation is lossy.
```
