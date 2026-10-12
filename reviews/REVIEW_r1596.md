# Review r1596: the fold of r1593/r1594 into L273 (commit ab4c5cba)

Log: agent_logs/r1596.log

Overall: CONFIRMED WITH GAPS. Every finding of both reports that asks for a change is applied in substance, and the m = 4 reconciliation is faithful and its value is right. The gaps: the L273 Gate 2 line and the INDEX-results row 273 drop r1593's PLAUSIBLE on T4, ATTEMPTS.md keeps the overstated threshold sentence that the fold narrowed in the block, and the new m = 4 sentence states r1593's Hessian screen as a fact.

| claim | verdict | reason in one line |
|---|---|---|
| F1 each r1593/r1594 finding applied in ab4c5cba, and nothing else changed in meaning | PLAUSIBLE | all six requested edits land as asked; ATTEMPTS.md:9041 still says (2) "is where statement H's threshold comes from on this family"; the symmetry images r1593 asked named are absent; "strict local maximum" enters the record without its screen label |
| F2 the reconciliation of their disagreement on m = 4 is faithful to both reports and true | CONFIRMED | r1593's claim is local at the uniform point, r1594's is a global sup; both hold; 2/sqrt 3 rechecked two ways (screen), against kappa_4 = 6/sqrt 28 = 1.1339 |
| F3 index rows (findings/INDEX-results.md row 273, reviews/INDEX.md rows r1593, r1594) match the reports | REFUTED (in part) | reviews/INDEX.md rows are faithful; the L273 Gate 2 line reads "independently: CONFIRMED" and row 273 "two wording repairs", both silent on r1593's T4 PLAUSIBLE and both undercounting the repairs |

## F1

Findings raised and where they land:

| report | finding | applied? |
|---|---|---|
| r1593 T1, r1594 T1 | equality in (1) needs A a non-negative multiple of A_mu | yes, Statement (1) now reads "when A is a non-negative multiple of A_mu" |
| r1593 T4, r1594 T4 | Lagrange rescaling needs nu > 0 | yes, "at every critical point ... whose multiplier nu = (1/2)(3T + 4 lambda_m g^2) is positive (every maximiser)"; the formula matches both reports' 2 nu = 3T + 4 lambda g^2 |
| r1593 LEAN, r1594 LEAN | jh_zero docstring says L273 (1) | yes, now (2) |
| r1594 LEAN | the m = 4 failure missing from the prose list | yes, added to the provenance line |
| r1593 T4 | "nothing else" unproven: mark as screened, or read as describing the edge | yes, both: "Q_12 the only non-zero entries), the two equality cases the screens find" |
| r1593 T4 | name the images under P <-> Q, Q -> SQS and index permutations | no |
| r1593 T4 | threshold sentence overstated; drop "of statement H" | yes in the block ("this route's threshold m >= 5 enters"); no in ATTEMPTS.md:9041, which still reads "which is where statement H's threshold comes from on this family" |
| r1594 T3 | cosmetic: T for both torus and cubic trace | no (cosmetic; the L273 block itself uses T only for the cubic trace) |
| r1593 LEAN | m = 4 failure could be typed (optional) | no, and nothing claims it is |

Changes in meaning that no report asked for:

- The new sentence "On the m = 4 slice H itself fails globally, at the torus-invariant Lambda^2_+ point with F/||X||^3 = 2/sqrt 3 > kappa_4, while the uniform point stays a strict local maximum there." The first half is a true exact statement (F2). The second half is r1593's screen (a) ("screen, local only") written as a fact, with no screen label. The same unlabelled phrase is in the new ATTEMPTS.md Gate 2 note. Repair: "stays a strict local maximum there (r1593's Hessian screen)".
- STATUS.md's generated count moved 131 to 132 and 104 to 105. Generated block, outside the reports; not assessed.

Corrections owed: narrow ATTEMPTS.md:9041 as the block was narrowed; label the local-maximum clause as a screen in both places; optionally name the symmetry images of the edge.

## F2

- r1593 claims only a local fact: the uniform point is a strict local maximum of F/||X||^3 on the m = 4 slice (Hessian screen, minimum eigenvalue 1.633 for the exact second-order test), and says the lemma gives no evidence H fails at m = 4. r1594 claims a global fact: its BFGS sup of the torus ratio at m = 4 is 1.15470 against kappa = 1.13389. These do not contradict, and the commit's reading (failure global, uniform point locally maximal) is faithful to both. r1594 did not name the maximising point; the attribution to Lambda^2_+ is the fold's own, and it is correct.
- Value, screen by the brief's route: Lambda^2_+ in so(4) inside so(8) is an ideal of so(4), so its projection is Ad(SO(4))-invariant and hence torus-invariant. With P_+ # P_+ = 2 P_+, X = P_+/2 is idempotent with ||X||^2 = 3/4, and F/||X||^3 = ||X||^2/||X||^3 = 2/sqrt 3 = 1.1547.
- Value, screen by the lemma's own chain: at the edge T = 0 and g = 1, and (1) is tight at A = a A_mu/||A_mu||, so F/||X||^3 = 3a/(1 + a^2)^{3/2}, maximised at a^2 = 1/2 with value 3(1/sqrt2)/(3/2)^{3/2} = 2/sqrt 3. The two routes agree, and the value is independent of m, which is why H survives at m = 5 (kappa_5 = 8/sqrt 45 = 1.1926).
- kappa_4 = 2(m-1)/sqrt(m(2m-1)) = 6/sqrt 28 = 1.1339 = c/sqrt N with c = 6, N = 28. So 2/sqrt 3 > kappa_4 holds.
- The m = 4 failure point (g = 1) sits away from where (2) fails (g just above 1/2), which is the content of r1593's objection and why "this route's threshold" is the right narrowing.

## F3

- reviews/INDEX.md r1593 row: "CONFIRMED with minor gaps", names T4 as PLAUSIBLE and the local maximum as "its Hessian screen". Faithful.
- reviews/INDEX.md r1594 row: "CONFIRMED with minor gaps", lists its four minor points and the 2/sqrt 3 screen. Faithful. The "Reconciled with r1593" clause is the fold's addition, correctly attributed as such by wording.
- L273 Gate 2 line: "by r1593 and r1594, independently: CONFIRMED, the equality case in (1) and the Lagrange sentence's positivity condition written in." This upgrades r1593, whose overall verdict is CONFIRMED WITH MINOR GAPS with T4 PLAUSIBLE, and it omits the two T4 repairs (edge marked as screened, threshold sentence narrowed). The precedent is r1592's repair of L271's Gate 2 line to record r1587's PLAUSIBLE. Correction: "CONFIRMED with minor gaps, r1593 PLAUSIBLE on *What it gives*: the equality case in (1), the Lagrange sentence's positivity condition, the edge equality marked as screened and the threshold sentence narrowed to this route's".
- INDEX-results row 273: "Gate 2 passed (r1593, r1594, two wording repairs)". Same omission of the PLAUSIBLE, and "two" undercounts (four record edits plus a docstring). Correction: "(r1593, r1594, r1593 PLAUSIBLE on *What it gives*; wording repairs and the threshold sentence narrowed)". Pre-existing and outside the fold: the row's "holds exactly when 4(m-2) >= 3(m-1)" says more than (2) proves, which is sufficiency for m >= 5 and failure at m = 4.
- The commit message's "both CONFIRMED with wording gaps" is accurate as a summary of the overall verdicts.
