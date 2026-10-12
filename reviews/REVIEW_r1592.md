# Review r1592: the folds of r1586/r1587 (commit 48282337) and r1589/r1590 (commit 9dbdbd6b) into L270, L271, L272

Log: agent_logs/r1592.log

Overall: CONFIRMED WITH MINOR GAPS. Every finding of the four reports is applied, and the applied text says what each report asked. The downstream edits are true consequences of L270. The index rows compress one PLAUSIBLE and misattribute two details, all minor.

| claim | verdict | reason in one line |
|---|---|---|
| F1 each r1586/r1587 finding applied in 48282337, and nothing else changed in meaning | CONFIRMED | all five distinct gaps applied as asked (reverse inequality, Q != 0, PD at idempotents, stable-idempotent wording, the 0.38 value); F80's and L264's downstream sentences follow from L270 (2)-(3) |
| F2 each r1589/r1590 finding applied in 9dbdbd6b, and nothing else changed in meaning | CONFIRMED | range widened to 1.006-1.083 with 13/12 named, source of P o Q o Q >= 0 named, count sharpened to m - abs(S) - 1, docstring clean; screen: 4b^2 + 2a_s^2 = 40/576 + 8/576 = 1/12 at n = 8 from L267's a_s, b |
| F3 index rows (findings/INDEX-results.md rows 270-272, reviews/INDEX.md rows r1586, r1587, r1589, r1590) match the reports | CONFIRMED, minor gaps | verdicts stated faithfully; L271's Gate 2 line and ATTEMPTS omit r1587's PLAUSIBLE on Q5 (r1586 confirmed that item); the r1589 row puts the author's L267 validation and a truncated L268 quote in r1589's mouth |

## F1. Commit 48282337 against r1586 and r1587

Finding by finding:

- r1586 H3 minor gap (H is an equality, and the half kappa_n >= (n-2)/sqrt N is left implicit). Applied in L270 (3)'s proof: "so kappa_n <= (n-2)/sqrt N; the reverse inequality is the value at I (L259 (2)), so equality, which is H". L259 (2) states that I attains (n-2)/sqrt N, so the citation is correct.
- r1586 H3 wording note and r1587 H5 wording point ("What H needs on the torus family" overstates, H needs it only for stable idempotents). Applied: the sentence now reads "On the torus family U_s' asks that no stable torus-invariant positive-definite idempotent be lighter than I/c; the norm form, that none is lighter at all, is a sufficient target". The reports' secondary remark (the torus family alone does not give H) is met implicitly, because the sentence no longer ascribes the requirement to H. Nothing further is owed.
- r1586 Q4 and r1587 Q4 gap ((4) divides by norm(C_Q)^2, needs Q != 0). Applied: "(4) For C != I/c (so Q != 0 by (3)), ...". This is the hypothesis both reports named.
- r1587 Q2 wording point (PD is P > abs(Q) only at an idempotent). Applied: "At an idempotent, positive definiteness is P_ij > abs(Q_ij) (the Cartan block A = A_mu is then positive definite by L268)". L268's statement carries the characterisation C > 0 iff A = 2 sum mu^2 u u^T with mu positive, so the citation holds. r1586 gave the same reason (the D_m roots span t).
- r1586 Q5 and r1587 Q5 (the m = 4 edge solution, 0.380, missing from the list). Applied: "(4)'s eigenvalue there runs from 0.35 to 0.43 (0.38 at L267's for m = 4)". The reports' values 0.351, 0.380, 0.419, 0.426 all lie in the range. Identifying the m = 4 edge solution as L267's is consistent with both reports (q = 0.8611 there, and L267's norm at n = 8 is 496/576 = 0.8611, screened).
- r1587 Q5 PLAUSIBLE on the slice range 0.55 to 0.63 (not screened by r1587). No text change was asked for. r1586 screened it (0.549 to 0.630) and confirmed it, so the sentence stands.
- r1587 H3 (M is undefined in the brief, the step rests on L260 (3)). An observation, with no change asked.

Unrequested changes in meaning, and the declared downstream sweep:

- F80's successor clause (findings/fence-posts.md) adds: "The invariant plane of C and I destabilises only idempotents heavier than I/c, which are harmless to H, so a second-order argument must reach the light ones (L270)". This follows from L270 (2) (lambda_I > 1/2 forces q > d/c^2) and L270 (3) (H follows from U_s', which asks nothing of heavier idempotents). The invariant plane named here is span{C, I}, which L270 (2) identifies with F80's plane span(P_k, P_p). True consequence.
- L264's What it gives: "U_s on simple algebras, and already its weaker form U_s' (L270)". L270 (3) states that U_s implies U_s' and that U_s' suffices for H. True consequence.
- The Gate 2 lines, INDEX-results rows, reviews/INDEX rows and ATTEMPTS are bookkeeping, covered under F3. No other change of meaning appears in the diff.

## F2. Commit 9dbdbd6b against r1589 and r1590

Finding by finding:

- r1589 P5 correction (the range 1.006 to 1.050 omits the m = 4 solution with rho = 1.08333). Applied: "(1.006 to 1.083, the top being L267's rho = 13/12 at m = 4, where d_i = 4b^2 + 2a_s^2 = 1/12 off S, against 1.10 to 1.17)". This matches r1589's first suggested wording to rounding (13/12 = 1.0833).
- r1589 and r1590 LEAN cosmetic point (perron_row's docstring describes perron_row_eq's equality case). The committed docstring of perron_row states only the inequality, so the point is met.
- r1590 minor 1 (name P > abs(Q) as the source of P o Q o Q >= 0). Applied as "P o Q o Q >= 0 (P > 0)". Nonnegativity of P_ij Q_ij^2 needs only P >= 0, so naming P > 0 is correct and sufficient.
- r1590 minor 2 (count with multiplicity, sharpened by simplicity of rho). Applied: "counted with multiplicity, lie in {rho, 1 - rho}, and since rho is simple at least m - abs(S) - 1 of them equal 1 - rho". rho is simple by Perron-Frobenius, since X has positive off-diagonal entries and is irreducible.
- r1590 minor 3 (docstring). Same as above, met.

Screen of the commit message's arithmetic, from L267's closed form at n = 8 (m = 4):

- a_s = 1/(4(n-5)) = 1/12, and b = sqrt(3n-14)/(8(n-5)) = sqrt10/24, so b^2 = 10/576. Both match the commit message.
- For i off S (the two Cartan indices inside so(n-4)), the roots eps_i +- eps_l with l in S carry mu = b (four roots) and the two roots on the other so(4) index carry mu = a_s. So d_i = 4b^2 + 2a_s^2 = 40/576 + 8/576 = 48/576 = 1/12, which also equals A_ii = a_s, as it must.
- By L272 (2), rho = 1 + d_i = 13/12 = 1.08333, which is r1589's screen value. The commit's validation holds.

Unrequested changes in meaning: 9dbdbd6b introduces L272, so the reviewed text and the committed text can differ only in the folds, and the folds listed above are the only statement-level changes the commit message and the Gate 2 line declare. The What it gives also cites screens at m = 6 (rho = 1.0357, 1.0057) that neither reviewer ran. They fall inside the quoted range and bear only on a screen, which is how the text presents them.

## F3. Index rows and Gate 2 lines

| row | report verdict | recorded | faithful? |
|---|---|---|---|
| L270 Gate 2 line, INDEX-results 270 | r1586, r1587 CONFIRMED on every H item (r1586 overall CONFIRMED WITH MINOR GAPS) | CONFIRMED, reverse inequality written in, What it gives narrowed | yes |
| L271 Gate 2 line, INDEX-results 271 | r1586 all CONFIRMED with minor gaps; r1587 Q4 "CONFIRMED, one gap", Q5 PLAUSIBLE | CONFIRMED, (4) restricted to Q != 0, PD clause restricted, screen list completed | mostly: r1587's Q5 PLAUSIBLE is not mentioned |
| L272 Gate 2 line, INDEX-results 272 | r1589 CONFIRMED WITH A MINOR GAP (P5 with a minor correction); r1590 CONFIRMED | CONFIRMED, screen range widened, count sharpened | yes |
| reviews/INDEX r1586 | CONFIRMED WITH MINOR GAPS | CONFIRMED with minor gaps, four gaps listed | yes |
| reviews/INDEX r1587 | CONFIRMED on ten items, Q5 PLAUSIBLE | CONFIRMED with gaps, the slice range "left unchecked as too slow for a screen" | yes, the PLAUSIBLE is described in substance |
| reviews/INDEX r1589 | CONFIRMED WITH A MINOR GAP | CONFIRMED with a minor gap | verdict yes, two details misattributed |
| reviews/INDEX r1590 | CONFIRMED | CONFIRMED, presentational points folded | yes |

Minor gaps:

1. L271's Gate 2 line says "CONFIRMED" for both reviewers and ATTEMPTS says both confirmed "with the same minor gaps", while r1587 marked Q5 PLAUSIBLE because it did not screen the slice range 0.55 to 0.63. The upgrade is small, since r1586 screened and confirmed that range and the reviews/INDEX row for r1587 records the omission. Suggested repair: append "r1587 leaving the slice-eigenvalue range unscreened, r1586 confirming it" to L271's Gate 2 line.
2. The reviews/INDEX row for r1589 places "(validated from L267's closed form, d_i = 4b^2 + 2a_s^2 = 1/12 off S)" inside r1589's summary. r1589 found rho = 1.08333 with d = 1/12 off S by screen and did not identify the solution as L267's. The identification and the closed-form check are the author's (correct, per F2). Suggested repair: mark the parenthetical as the fold's validation.
3. The same row says "the brief's quotations of L268 and L271 were cut at their first line". r1589 reports only L271's quotation as truncated, and r1590 likewise names L271 only. Suggested repair: "L271" alone, unless the brief's L268 quote is checked and found cut as well.

Incidental, outside the named files: the diff of 9dbdbd6b shows batch 48 of the working note still saying "The torus-family statement H needs is the norm form", the sentence r1586 and r1587 flagged in L270's What it gives. The record's block is corrected. The working note is a log, and this review did not open it beyond the diff.
