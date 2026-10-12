# Verifier v241, L46: Q(W) = lambda W at a locally symmetric Einstein space, theta(W/||W||) = lambda/||W||, the Petersen-Stanfield display, the lambda = 0 exclusion, Passage D's reformulation and the Lean statement

The brief ([BRIEF_L46.md](BRIEF_L46.md)) was read cold. No numerical work was done, every value is exact, no scripts were written, and the Lean file was read and not compiled. Log: [agent_logs/verify-L46-v241.log](../agent_logs/verify-L46-v241.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | Steps (B), (B'), (C): given Q(R) = lambda R, the shift c = lambda/(n-1) gives Q(W) = lambda W | CONFIRMED AS ALGEBRA |
| C2 | Step (A): Richard-Seshadri Lemma 4.1 gives Q(R) = lambda R at a *locally* symmetric Einstein space, lambda of either sign, no completeness | HYPOTHESIS-DEBT |
| C3 | theta(W/norm W) = lambda/norm W under the hypothesis lambda != 0 (Passages A, B, C, E, Lean docstring) | REFUTED AS STATED (hypothesis corrected to W != 0) |
| C4 | The lambda = 0 exclusion: a locally symmetric Ricci-flat space is flat (Passage B first paragraph) | HYPOTHESIS-DEBT |
| C5a | norm W^2 = norm R^2 - (tr R)^2/N, and theta^2 = 1/(4(norm R^2 - (tr R)^2/N)) at lambda = 1/2 (Passages A, E) | CONFIRMED AS ALGEBRA |
| C5b | Passage D: the theta^2 display for every compact locally symmetric Einstein space, stated before any normalisation, and "normalising to Einstein constant 1/2" | REFUTED AS STATED |
| C6 | Passage D's reformulation: tr R = n/4, c = 1/(2(n-1)), theta <= theta_0 iff norm W^2 >= 1/(4 theta_0^2), 9/55 at S^6 x S^6, n^2 - 12n + 8 | CONFIRMED AS ALGEBRA |
| C7 | Petersen-Stanfield: lambda = 1/2 for every compact irreducible symmetric space in their normalisation | CONFIRMED |
| C8 | Lean Passage F: the three theorems type what they claim | CONFIRMED (theorems), with two docstring defects |
| C9 | Compactness is not needed (Passages A, B, C) against Passage D's "compact" | HYPOTHESIS-DEBT (inherits C2) |
| C10 | Item 11: the pointer sentence and "The statement is below; the section it used to point at is" read as sentences; Passage C's canon line | REFUTED AS STATED (fragment at problem.md line 626 and a truncated canon line at results.md line 106) |

**What the round should do:** replace the hypothesis lambda != 0 by W != 0 in the statement, the canon (Passages C, D, E) and the Lean docstring; move Passage D's theta^2 display after the normalisation and normalise to |lambda| = 1/2; either file a source for Q(R) = lambda R that reaches locally symmetric spaces with lambda < 0 or restrict step (A)'s scope to Richard-Seshadri's stated hypotheses; repair the two broken sentences.

## 0. Conventions, fixed once

- Lambda^2 R^n with e_i ^ e_j (i < j) orthonormal, <R,S> = tr(R S), I the identity on Lambda^2, N = binom(n,2) = norm I^2. This is Bohm-Wilking's convention at source ([boehm-wilking-math0606187.txt](https://arxiv.org/abs/math/0606187) lines 139-141: "e1 ^ e2, ..., en-1 ^ en is an orthonormal basis of Lambda^2 V"), with I = id ^ id since (A ^ B)(v ^ w) = 1/2(Av ^ Bw + Bv ^ Aw).
- Q(R) = R^2 + R^#, R^# = R # R, the convention of Richard-Seshadri at source ([richard-seshadri-1308.1190.txt](https://arxiv.org/abs/1308.1190) line 268, "Q(R) = R2 + R#", the # "found in [BW08]", line 285).
- B(X,Y) = 1/2(Q(X+Y) - Q(X) - Q(Y)) = 1/2(XY + YX) + X # Y (Richard-Seshadri line 289). The passages write X o Y for B(X,Y).
- P(W) = <W, Q(W)>, theta(W) = P(W)/norm W^3. The Lean layer agrees: `Pcubic R := trCube R + sharpPair R` = <R,R^2> + <R,R^#>, `theta R := Pcubic R / norm R ^ 3` ([WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) lines 170, 180).
- Sectional curvature k on S^m gives R = kI on Lambda^2 R^m and Ric = (m-1)k g. So an Einstein R with Ric = lambda g has R_I = cI with c = lambda/(n-1), the value that makes W = R - cI totally trace-free.
- theta_0(n) is used in Passage D and is not defined in the brief. Where it enters, the check is stated conditionally.

**Quotation check.** Passage A matches [problem.md](../findings/problem.md) lines 628-635, Passage B lines 614-622, Passage C [results.md](../results.md) line 106 (including its truncation, which is at source), Passage D lines 386-390, Passage E [graded-half.md](../findings/graded-half.md) lines 210-214 and 220-224, and Passage F the Lean file up to a trailing blank line. **Disclosure:** to read item 11's sentences I displayed problem.md lines 606-636, which include an annotation paragraph at lines 623-624 outside the quoted passages. The W = 0 candidate (C3) was logged before that display.

## Hypothesis inventory

| Source | Hypothesis | Checked against the object | Used by the proof |
|---|---|---|---|
| Statement (A) | locally symmetric, nabla R = 0 | carried | yes, in (A) only |
| Statement (A) | Einstein, Ric = lambda g | carried | yes, (A) and the value of c |
| Statement (A) | lambda != 0 | stated | **never used**: Q(W) = lambda W holds at lambda = 0 (W = 0 by C4), and theta needs W != 0, which lambda != 0 does not give (C3) |
| Needed, unstated | W != 0 | absent from A, C, D, E | yes, to form W/norm W and theta |
| Passage D | compact | stated in D only | not used by any step on file |
| Passages A, E | lambda = 1/2 (Petersen-Stanfield normalisation) | stated for the theta^2 display | yes, for the display only |
| Richard-Seshadri Lemma 4.1 | (M, g0) **symmetric** (not locally) | the object is locally symmetric | the proof's step "g0 symmetric, R parallel" uses only nabla R = 0 |
| Richard-Seshadri Lemma 4.1 | **non negatively curved** | the object may have lambda < 0 | not visibly used in the printed proof |
| Richard-Seshadri Lemma 4.1 | **lambda > 0** | the object has lambda of either sign | not visibly used in the printed proof |
| Richard-Seshadri Lemma 4.1 proof | Brendle [Bre10a] Proposition 3 for Einstein metrics | **not filed**, brief line 215 | yes, it is the whole proof |
| Richard-Seshadri Lemma 3.1 (due to BW) | W Weyl | W = R - cI is Weyl when Ric_0 = 0 | gives B(W,I) = 0 and Q(I) = (n-1)I directly |
| Bohm-Wilking Lemma 2.1 | R an algebraic curvature operator (Bianchi) | W is | gives W + W # I = 0 |
| Petersen-Stanfield | M = G/H compact simply connected, G semisimple, metric from -B_g | irreducible compact symmetric spaces are of this form | gives Ric = 1/2 g |

## 1. C1, steps (B), (B'), (C)

**Derivation.** B is symmetric bilinear, so Q(W + cI) = Q(W) + 2c B(W,I) + c^2 Q(I). This is Passage B's first display with W o I = B(W,I). Given Q(W + cI) = lambda(W + cI) and Q(I) = (n-1)I:

Q(W) = lambda W + (lambda c - c^2 (n-1)) I - 2c B(W,I),

which is Passage B's second display. With c = lambda/(n-1), lambda c - c^2(n-1) = lambda^2/(n-1) - lambda^2/(n-1) = 0.

- **Q(I) = (n-1)I.** Richard-Seshadri Lemma 3.1, first bullet, at source (lines 385-386). Independently, Bohm-Wilking Lemma 2.1 at R = I reads I + I # I = (n-1)I, so I^# = (n-2)I and Q(I) = I + (n-2)I = (n-1)I, as Passage E says.
- **(B'), B(X,I) = X # I + X.** B(X,I) = 1/2(XI + IX) + X # I = X + X # I. So W o I and W # I differ by +W, as stated.
- **(C), W # I = -W.** Bohm-Wilking Lemma 2.1 at source (lines 216-219): "R + R # I = (n-1) R_I + (n-2)/2 R_Ric0 = Ric ^ id". A Weyl operator has R_I = R_Ric0 = 0, so W + W # I = 0. Hence B(W,I) = 0, which is also Richard-Seshadri Lemma 3.1's second bullet verbatim. Passage B's own argument for (C) (the Casimir expansion and "the -2 eigenvalue that file records") points to isotropy-cap.md, which is outside the brief. The identity itself stands on Bohm-Wilking at source.
- **Consistency line.** <W^#, I> = <W # I, W> by the total symmetry of tr((R1 # R2) R3) (Bohm-Wilking lines 186-192), so tr W^# = -norm W^2. Correct.
- **Passage E's route.** Einstein gives Ric ^ id = lambda I (since I = id ^ id), so R # I = lambda I - R and B(R,I) = lambda I. Then Q(R - cI) = lambda R - 2c lambda I + c^2(n-1) I = lambda W + (lambda c - 2 lambda c + lambda c) I = lambda W. Correct.

The chain yields Q(W) = lambda W from Q(R) = lambda R. **CONFIRMED AS ALGEBRA.** Whether Q(R) = lambda R holds for the stated object is C2.

## 2. C2, step (A) against Richard-Seshadri Lemma 4.1 (attack item 1)

**Source, read at [PDF](https://arxiv.org/abs/1308.1190) pages 10-11 (txt lines 510-532).** "Lemma 4.1. Let (M^n, g0) be a non negatively curved Einstein symmetric space, then its curvature operator R satisfies: Q(R) = lambda R (3) where lambda > 0 is such that Ric_g0 = lambda g0." Proof: "Since (M^n, g0) is Einstein, we can use Proposition 3 of [Bre10a] to get that (note that our definition of Q differs from the one used by Brendle by a factor of 2): Delta R + 2Q(R) = lambda R. Then, since g0 is symmetric, R is parallel and Delta R = 0. This proves that Q(R) = lambda R."

**Candidate 2.1, the stated hypotheses do not cover the object.**
1. Location: Passage B (A), "Lemma 4.1 gives it directly for a locally symmetric Einstein space, with no completeness hypothesis", applied by Passages A and B to lambda of either sign (the statement excludes only lambda = 0).
2. Failure: the lemma's statement requires a symmetric space, nonnegative curvature and lambda > 0. A compact quotient of real hyperbolic space H^n/Gamma is locally symmetric Einstein with lambda = -(n-1) < 0 at sectional curvature -1, and is covered by none of the three hypotheses. The same holds for any incomplete open subset of a symmetric space against "symmetric". The citation "gives it directly" does not reach these objects.
3. Charitable reading: Remark 4.2 makes Q(R) = lambda R a pointwise algebraic equation, and the printed proof uses only Einstein plus nabla R = 0, so the proof, if Brendle's Proposition 3 is a local identity valid for every sign of lambda, reaches the object. But Brendle's Proposition 3 is not filed (brief line 215), and its scope cannot be read at source. The reading therefore rests on an unfiled import. The candidate stands.

**Candidate 2.2, the printed proof has a factor-2 misprint.**
1. Location: Richard-Seshadri page 11, "Delta_g0 R_g0 + 2Q(R_g0) = lambda R", followed by "This proves that Q(R_g0) = lambda R_g0".
2. Failure: with Delta R = 0 the printed identity gives Q(R) = (lambda/2) R, not lambda R. Closed-form check at the round S^n (sectional curvature 1): R = I, lambda = n - 1, and Richard-Seshadri's own Lemma 3.1 gives Q(I) = (n-1)I = lambda I. So the conclusion Q(R) = lambda R is right at S^n and the printed intermediate, 2Q(I) = 2(n-1)I against lambda I = (n-1)I, is off by 2.
3. Charitable reading: the intended identity is Delta R + 2Q(R) = 2 lambda R, consistent with Hamilton's evolution (line 263) and the homothetic Ricci flow. The conclusion is unaffected. This is a misprint in the imported proof, not a defect of L46, and it is recorded so that nobody quotes the intermediate line.

**Candidate 2.3, Passage B's claim that the Ricci-flow route "needs short-time existence, so it is the weaker route".**
1. Location: Passage B (A), italic sentence.
2. Failure: g(t) = (1 - 2 lambda t) g0 satisfies d/dt g = -2 lambda g0 = -2 Ric(g0) = -2 Ric(g(t)), since Ric is invariant under constant rescaling, so it is a Ricci flow by inspection on t < 1/(2 lambda) (lambda > 0) or t >= 0 (lambda < 0). Its curvature operator is R(t) = R0/(1 - 2 lambda t), so d/dt R at 0 is 2 lambda R0. No existence theorem enters.
3. Charitable reading: "short-time existence" may stand for the need to know Hamilton's evolution equation along the flow, which is a local computation valid for any smooth solution. Neither reading needs existence. The sentence is side commentary and not load-bearing, so this is recorded as a minor inaccuracy with no effect on the verdict. Passage E's "the metric shrinks homothetically" is also true only for lambda > 0 (it expands for lambda < 0), again without effect on the identity.

**Verdict.** For lambda > 0 and a nonnegatively curved Einstein symmetric space the conclusion is the published statement of Richard-Seshadri Lemma 4.1. For the object as stated (locally symmetric, lambda of either sign, no completeness), the record has no filed argument. **HYPOTHESIS-DEBT**: what would have to be proved (or filed) is that every Einstein metric with nabla R = 0 on an open set satisfies Q(R) = lambda R pointwise, for every real lambda. The reference notes' sentence "the identity itself holds for every Einstein locally symmetric metric" is the record's assertion, not the source's.

## 3. C3, lambda != 0 against W != 0 (attack items 3 and 10)

**Candidate 3.1.**
1. Location: Passage A, "theta(W/norm W) = lambda/norm W (lambda != 0)"; Passage B, "THE HYPOTHESIS lambda != 0 IS PART OF THE STATEMENT, at lambda = 0 ... W = 0 and theta is undefined"; Passage C's title "Locally symmetric Einstein spaces with lambda != 0 are critical"; Passage E, "Since lambda = 1/2 for every compact irreducible symmetric space ... theta = 1/(2 norm W)"; Passage F line 169-170, "hpos is the record's lambda != 0 clause in the form it is actually needed, W != 0".
2. Failure, in closed form: the round sphere S^n (n >= 2) with sectional curvature 1 is compact, irreducible, symmetric and Einstein with R = I, lambda = n - 1 != 0, c = 1, W = R - cI = 0. In Petersen-Stanfield's normalisation k = 1/(2(n-1)), lambda = 1/2, W = 0 still. W/norm W and theta(W) = P(W)/norm W^3 are 0/0. Compact real hyperbolic quotients H^n/Gamma (W = 0) do the same at lambda < 0. At n = 3 (and n = 2) the Weyl space is zero, so **every** instance has W = 0 and the display is undefined throughout. The hypothesis lambda != 0 excludes none of these.
3. Charitable reading: writing W/norm W presupposes W != 0, so a reader may take W != 0 as implicit and lambda != 0 as a redundant remark. This does not rescue the record as written, because Passage B names lambda != 0 as the hypothesis that makes theta defined, Passage E asserts the formula for every compact irreducible symmetric space (S^n included), and the Lean docstring identifies hpos : 0 < norm R with the lambda != 0 clause. The corrected hypothesis is W != 0. With W != 0, lambda != 0 follows (by C4, when that is discharged) and is redundant. The candidate stands.

**Derivation of the corrected claim.** For W != 0, theta(W/norm W) = P(W)/norm W^3 (degree 0 under positive scaling, P cubic) = <W, lambda W>/norm W^3 = lambda/norm W. Criticality: <B(X,Y),Z> is totally symmetric (Bohm-Wilking lines 186-192), so grad P(W) = 3 Q(W) projected to the Weyl space, which is 3 lambda W, parallel to W. Correct.

**Verdict. REFUTED AS STATED**, hypothesis corrected to W != 0. The other edges: lambda < 0 is harmless for C1 and C3 (theta = lambda/norm W < 0), subject to C2's debt. n = 4: W != 0 occurs (S^2 x S^2 with equal curvatures, CP^2), no finding. Reducible spaces: a product is Einstein only when its factors share lambda, and the algebra of C1 uses no irreducibility, no finding. ker W != 0 plays no role in any step, no finding.

## 4. C4, the argument at lambda = 0 (attack item 4)

Passage B asserts that a locally symmetric Ricci-flat space is flat, and assigns the work to "the decomposition of L210 with the definiteness of beta on an irreducible factor". L210 is not quoted in the brief, and beta is not defined there. The claim itself is not used by the proof of Q(W) = lambda W (at lambda = 0 that identity is the trivial one once W = 0, and without flatness it would still follow from C1 given Q(R) = 0 · R). It is used only to motivate lambda != 0, which C3 shows is the wrong hypothesis for theta in any case. **HYPOTHESIS-DEBT** for this brief: what would have to be on file is that an Einstein metric with nabla R = 0 and Ric = 0 has R = 0, i.e. that every non-flat irreducible factor of the local holonomy splitting has nonzero Ricci curvature. Note that the Lean docstring (Passage F lines 94-96) still quotes "flat by Cartan-Ambrose-Hicks with de Rham", which Passage B withdraws (C8).

## 5. C5a and C5b, the theta^2 display (attack item 5)

**Derivation.** R = cI + W with <W, I> = tr W = 0 (W totally trace-free). So norm R^2 = c^2 N + norm W^2 and tr R = cN, (tr R)^2/N = c^2 N. Hence norm W^2 = norm R^2 - (tr R)^2/N for every Einstein R, with no lambda condition. Then theta^2 = lambda^2/norm W^2 = lambda^2/(norm R^2 - (tr R)^2/N), which equals the display exactly when lambda^2 = 1/4.

- **Passage A** prints the display "in Petersen-Stanfield's normalisation, where lambda = 1/2". **Passage E** prints it after "Since lambda = 1/2". Both correct for W != 0. **C5a CONFIRMED AS ALGEBRA.**
- **Passage C** prints it "under the Einstein normalisation" without a value. Read charitably as lambda = 1/2, correct.

**Candidate 5.1, Passage D.**
1. Location: Passage D, "its value is theta = lambda/norm W with theta^2 = 1/(4(norm R^2 - (tr R)^2/N)). Normalising to Einstein constant 1/2 makes ...", for "a compact locally symmetric Einstein space".
2. Failure: the display is stated before the normalisation and is not scale invariant while theta is. Closed form: S^3 x S^3, each factor of sectional curvature 1, n = 6, lambda = 2, N = 15. norm R^2 = 3 + 3 = 6, tr R = 6, (tr R)^2/N = 12/5, norm W^2 = 18/5. Then theta^2 = lambda^2/norm W^2 = 4 · 5/18 = 10/9, while the display gives 1/(4 · 18/5) = 5/72. Separately, "Normalising to Einstein constant 1/2" is impossible for a compact quotient with lambda < 0, which the hypothesis "compact locally symmetric Einstein" admits (e.g. a compact quotient of complex hyperbolic space CH^2, n = 4, W != 0).
3. Charitable reading: the next sentence's normalisation is meant to govern the display. Then the display is correct at lambda = 1/2 (S^3 x S^3 rescaled to k = 1/4 gives norm W^2 = 9/40 and 1/(4 · 9/40) = 10/9, matching). For lambda < 0 the display holds at lambda = -1/2, since only lambda^2 enters, so the repair is to normalise to |lambda| = 1/2. As printed, the order and the value are wrong. The candidate stands as a statement defect with a one-line repair.

**C5b REFUTED AS STATED.**

## 6. C6, Passage D's reformulation (attack item 7)

- At lambda = 1/2: c = lambda/(n-1) = 1/(2(n-1)), tr R = cN = n/4. Correct, and it agrees with Petersen-Stanfield Proposition 2.2 ("1/2 dim M = scal = 2 tr R").
- theta = 1/(2 norm W) > 0, so for theta_0(n) > 0 and W != 0: theta <= theta_0 iff norm W >= 1/(2 theta_0) iff norm W^2 >= 1/(4 theta_0^2). Correct.
- S^m x S^m at lambda = 1/2: k = 1/(2(m-1)), norm R^2 = k^2 m(m-1), tr R = k m(m-1) = m/2, N = m(2m-1). norm W^2 = k^2 m(m-1)(1 - (m-1)/(2m-1)) = m^2/(4(m-1)(2m-1)) = n^2/(8(n-1)(n-2)) with n = 2m. At m = 6: 36/(4 · 5 · 11) = 9/55. Direct: k = 1/10, norm R^2 = 3/10, tr R = 3, N = 66, 3/10 - 9/66 = 3/10 - 3/22 = 9/55. Correct, and 9/55 < 1/6 since 54 < 55.
- 1/6 >= n^2/(8(n-1)(n-2)) iff 8(n-1)(n-2) >= 6n^2 (n >= 3) iff 2n^2 - 24n + 16 >= 0 iff n^2 - 12n + 8 >= 0. Roots 6 +- 2 sqrt 7. The larger is 6 + 2 sqrt 7, not an integer, and the smaller lies in (0,1), so "coincide only at n = 6 + 2 sqrt 7" is right on n >= 3. Correct.
- "attaining theta_0(12) exactly" and the identification 1/(4 theta_0(n)^2) = n^2/(8(n-1)(n-2)) hold if theta_0(n) is the balanced product's theta, whose square is 1/(4 norm W^2) = 2(n-1)(n-2)/n^2 by the computation above. theta_0 is not defined in the brief, so this identification is checked only conditionally.

**CONFIRMED AS ALGEBRA**, conditional on theta_0(n) being the balanced-product value, and on W != 0 (C3).

## 7. C7, Petersen-Stanfield's normalisation (attack item 8)

At source ([petersen-stanfield-2508.11236.txt](https://arxiv.org/abs/2508.11236) lines 37-42): "We consider compact simply-connected symmetric spaces: M = G/H, where G is a compact semi-simple Lie group ... we equip G/H with the G-invariant submersion metric induced by -B_g. With this metric, M is Einstein with Einstein constant 1/2." Also lines 296-299: "Ric = 1/2 g = -1/2 B_g restricted to p". Their curvature operator satisfies 2 tr R = scal (Proposition 2.2), the record's convention. Every compact irreducible symmetric space is covered, since its universal cover is of this form (and the statement is local). **CONFIRMED.** The word "irreducible" is stronger than the source needs, which is harmless.

## 8. C8, the Lean statement (attack item 9, standing item 5)

- **shift_kills_remainder.** Binders: an arbitrary R-module E, a bilinear Qb, symmetry hsymm, I W : E, n : N, lam c : R, hn : (n:R) - 1 != 0, hQI : Qb I I = (n-1) • I, hWI : Qb W I = 0, hc : c = lam/(n-1), hcrit : Qb (W + c•I) (W + c•I) = lam • (W + c•I). Conclusion Qb W W = lam • W. The equalities point the right way (hcrit is Q(R) = lambda R at R = W + cI). The proof expands to Qb W W + (c^2(n-1)) • I = lam • W + (lam c) • I and cancels with c^2(n-1) = lam c, which is C1 verbatim. hn excludes only n = 1, which no curvature statement needs. Nothing else is excluded. The theorem is what its docstring says.
- **theta_of_eigenvalue.** Binders R (playing W), lam, hnn : 0 <= normSq R, hpos : 0 < norm R, hP : Pcubic R = lam * normSq R. Conclusion theta R = lam / norm R. With the RealLayer definitions (section 0) this is P(W) = lambda norm W^2 implies P(W)/norm W^3 = lambda/norm W, proved by norm R^2 = normSq R and field_simp. Correct, and hpos is exactly the W != 0 hypothesis C3 finds missing from the record.
- **petersen_stanfield.** Pure real arithmetic: w > 0, w^2 = nR^2 - trR^2/NN, th = (1/2)/w give th^2 = 1/(4(nR^2 - trR^2/NN)). Correct. hw is taken as a hypothesis, as the docstring says.
- **Non-vacuity example.** It witnesses hQI and hWI only (W = 0, Qb = multiplication). hcrit and hc are also satisfied at W = 0, c = lam/(n-1), so the full binder is satisfiable. The example is weaker than its docstring suggests, with no effect on correctness.

**Candidate 8.1, the docstring equates hpos with lambda != 0.**
1. Location: Passage F lines 168-170, "hpos is the record's lambda != 0 clause in the form it is actually needed, W != 0".
2. Failure: lambda != 0 does not imply W != 0 (S^n, C3).
3. Charitable reading: the docstring means "the clause the record should have stated". It says "the record's lambda != 0 clause", so the identification is false as written. Stands, as a documentation defect.

**Candidate 8.2, the "quoted verbatim" block is stale.**
1. Location: Passage F lines 94-96, quoting "flat by Cartan-Ambrose-Hicks with de Rham" under "quoted verbatim from problem.md".
2. Failure: problem.md line 614 now reads "is flat, so W = 0 and theta is undefined. THE INSTRUMENT IS NOT CARTAN--AMBROSE--HICKS".
3. Charitable reading: the block was verbatim when written. It is not verbatim now, and it quotes the withdrawn attribution. Stands, as a documentation defect.

**Verdict.** The three theorems type what they claim, and none is vacuous. The Lean file types none of C2, C4 or the identification of Qb with the curvature Q, and says so. **CONFIRMED** for the typed content, with the two docstring defects above.

## 9. C9, compactness (attack item 6)

No step on file uses compactness. C1 is algebra. C3 and C5 are algebra. Step (A) as imported from Richard-Seshadri uses "symmetric" (which for a Riemannian symmetric space includes completeness) and the unfiled Brendle Proposition 3. So "compactness is not needed" is right for every step except (A), whose reach beyond the stated hypotheses is C2's debt. Passage D's "compact" is an extra hypothesis that also admits lambda < 0 spaces its normalisation cannot reach (C5b). **HYPOTHESIS-DEBT**, inherited from C2.

## 10. C10, the sentences (attack item 11)

- **Pointer sentence, problem.md line 612:** "The argument is not elsewhere in this file: graded-half.md carries a four-line proof labelled as this lemma's, and the result is published, Richard-Seshadri Lemma 4.1, in references/." It parses as a sentence. Its content overstates: Richard-Seshadri Lemma 4.1 publishes Q(R) = lambda R under the hypotheses of C2, and Q(R_W) = R_W (after rescaling) appears in the proof of their Proposition 4.3, but neither publishes the theta formula or the locally symmetric, lambda < 0 scope.
- **problem.md line 626:** "*The statement is below; the section it used to point at is". A fragment: the clause ends on "is" with no complement, and the opening asterisk is unclosed. It does not read as a sentence.
- **Passage C, results.md line 106:** "... gives the identity flow-free.*act locally symmetric Einstein space, Q(W) = lambda W, so ...". The statement sentence has lost its opening words (the surviving "act" suggests "compact"), so the canon's landscape form has no legible quantifier or hypothesis clause. This truncation is at source.

**REFUTED AS STATED** as prose.

## Withdrawn candidates

- **"c = lambda/(n-1) is the choice that kills the remainder" is not unique**, since lambda c - c^2(n-1) = c(lambda - c(n-1)) also vanishes at c = 0. Withdrawn: c is fixed by the statement as the trace constant, and only that value makes W Weyl, which step (C) needs. The passage calls it a choice loosely, not wrongly.
- **Step (B') lacks an argument on file** (the "Phi(I,W) = W - W = 0" bridge is not quoted). Withdrawn: B(X,I) = X + X # I follows in one line from Richard-Seshadri's definition of B at source (line 289), and B(W,I) = 0 is Richard-Seshadri Lemma 3.1 verbatim.
- **Step (C) rests only on isotropy-cap.md**, outside the brief. Withdrawn: Bohm-Wilking Lemma 2.1 at source gives W # I = -W, and the Lean docstring cites it.
- **Petersen-Stanfield's curvature convention differs from the record's by a factor 2** (their g(R(X ^ Y), Z ^ W) := 2R(X,Y,Z,W)). Withdrawn: their Proposition 2.2 gives 2 tr R = scal and eigenvalue 1/2 on the centre of h, both matching the record's convention (tr R = scal/2, R = kI at sectional curvature k).

## Standing items, answered

1. **Hypothesis inventory:** the table above. Used but unstated: W != 0. Stated but unused: lambda != 0, compactness (D). Imported hypotheses not met by the object: "symmetric", "non negatively curved", "lambda > 0" of Richard-Seshadri Lemma 4.1. Unfiled import: Brendle Proposition 3.
2. **Quantifier order and scope:** Passage D quantifies lambda as "a scalar" rather than the Einstein constant, then uses it as the Einstein constant (harmless, the Einstein constant is such a scalar). Passage D's theta^2 display sits outside the normalisation's scope (C5b). Passage C's quantifier is lost to truncation (C10). The Lean binders are in the right order.
3. **Edges:** lambda < 0 (C2 debt, otherwise harmless), lambda = 0 (C4), W = 0 (C3, refutes the lambda != 0 form), n = 3 (every instance has W = 0, C3), n = 4 (no finding), reducible spaces (no finding), ker W != 0 (no finding: no step uses invertibility of W).
4. **Proven against stated:** proven is Q(W) = lambda W given Q(R) = lambda R, and theta = lambda/norm W for W != 0. Stated is the same for locally symmetric spaces of either sign with only lambda != 0. The gap is C2's scope and C3's hypothesis.
5. **Lean:** C8.
6. **Attack items:** 1 is C2, 2 is C1, 3 is C3, 4 is C4, 5 is C5, 6 is C9, 7 is C6, 8 is C7, 9 is C8, 10 is C3 with section 3's edge list, 11 is C10.
7. **Falsifier:** for the theta clause, any Einstein locally symmetric space with lambda != 0 and W = 0, exhibited as the round S^n (section 3). For Q(W) = lambda W itself, a locally symmetric Einstein metric with Q(R) != lambda R. I looked for one by checking the identity at R = I (holds) and by testing the algebra of C1 in general (holds for every Einstein R once Q(R) = lambda R). No falsifier of Q(W) = lambda W was found. Its reach to lambda < 0 and to incomplete spaces is unproven on file rather than refuted.

## Overall verdict

**HYPOTHESIS-DEBT.** The algebra from Q(R) = lambda R to Q(W) = lambda W is correct, and so are the Lean theorems. The theta clause is refuted as stated and holds with W != 0 in place of lambda != 0. Passage D's display needs to follow the normalisation, at |lambda| = 1/2. Step (A) reaches locally symmetric spaces with lambda < 0 only through an unfiled source. Within Richard-Seshadri's stated hypotheses (nonnegatively curved Einstein symmetric, lambda > 0) and with W != 0, the lemma is PROVEN (hypotheses corrected) modulo that published lemma.
