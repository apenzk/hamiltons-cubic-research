# Verifier v239, L46: step (A) against Richard–Seshadri Lemma 4.1, the shift to W, the theta displays under lambda != 0, Passage D's reformulation, Passage E's proof, and the Lean statement

The brief ([BRIEF_L46.md](BRIEF_L46.md)) was cold. No numerical work was done, every value is exact, and no scripts were written. Every closed-form check below was done by hand and is reported as a screen. Log: [agent_logs/verify-L46-v239.log](../agent_logs/verify-L46-v239.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Step (A): Richard–Seshadri Lemma 4.1 gives Q(R) = lambda R at a locally symmetric Einstein space, lambda != 0 of either sign, no completeness | HYPOTHESIS-DEBT |
| 2 | Steps (B), (B'), (C): from Q(R) = lambda R, Q(W) = lambda W | CONFIRMED |
| 3 | theta(W/‖W‖) = lambda/‖W‖ and criticality, under the hypothesis lambda != 0 | REFUTED AS STATED (true with W != 0 added) |
| 4 | The lambda = 0 argument of Passage B's first paragraph | HYPOTHESIS-DEBT (not load-bearing) |
| 5 | The display theta^2 = 1/(4(‖R‖^2 - (tr R)^2/N)) in Passages A, C, E, the identity ‖W‖^2 = ‖R‖^2 - (tr R)^2/N, and Petersen–Stanfield's lambda = 1/2 | CONFIRMED (at lambda = 1/2, W != 0) |
| 6 | Passage D as stated (compact, general lambda, theta^2 display) | REFUTED AS STATED |
| 6' | Passage D's reformulation at lambda = 1/2 (tr R = n/4, c, the floor, 9/55, n^2 - 12n + 8) | CONFIRMED AS ALGEBRA |
| 7 | Passage E's four-line proof | CONFIRMED AS ALGEBRA |
| 8 | Passage F's Lean statements | CONFIRMED AS ALGEBRA (three docstring claims false) |
| 9 | Attack item 11: the pointer sentence and the closing annotation read as sentences | REFUTED AS STATED |

**What the round should do:** add W != 0 to every statement of L46, either restrict step (A) to what Richard–Seshadri Lemma 4.1 states (a nonnegatively curved Einstein symmetric space, lambda > 0) or file an argument for Q(R) = lambda R at lambda < 0 and at locally symmetric spaces, correct Passage D's theta^2 display to lambda = 1/2, and repair the Lean docstrings and the two broken sentences.

## 0. Conventions, fixed once

- Lambda^2 R^n carries the inner product with e_i∧e_j orthonormal. This is Richard–Seshadri's Remark 1.2, Böhm–Wilking's "e1∧e2, ..., en−1∧en is an orthonormal basis", and the Lean layer's `inner2` (half Frobenius, `phi i j` of norm 1). N = binom(n,2) = ‖I‖^2.
- Q(R) = R^2 + R#, with # as in Böhm–Wilking (4). B(X,Y) = (1/2)(Q(X+Y) − Q(X) − Q(Y)) = (1/2)(XY + YX) + X#Y, which is Richard–Seshadri's B (text lines 287–289 of the extraction). The brief writes X∘Y for B(X,Y).
- The scalar curvature is twice tr R (Richard–Seshadri, "the scalar curvature of an algebraic curvature operator is just twice its trace"; Petersen–Stanfield Proposition 2.2, "scal = 2trR"). For Ric = lambda g this gives tr R = n·lambda/2.
- The Einstein decomposition is R = cI + W with W Weyl, tr W = ⟨W, I⟩ = 0, and c = lambda/(n−1). Böhm–Wilking (3) gives R_I = (lambda-bar/(n−1)) id∧id with lambda-bar = tr(Ric)/n = lambda, and id∧id = I. Consistency: tr(cI) = cN = n·lambda/2 = tr R.
- P(W) = ⟨W, Q(W)⟩ and theta(W) = P(W)/‖W‖^3, as the brief defines them. theta is homogeneous of degree 0.
- Screening objects used below, all with curvature operators exact in the orthonormal basis (e12, e34, e13, e14, e23, e24) or its analogue:
  - S^2 × S^2 with both factors of curvature k: R = diag(k, k, 0, 0, 0, 0), Ric = k g. R# = 0 because the image of R is spanned by e12 and e34, which commute in so(4).
  - H^2 × H^2 with both factors of curvature −1: R = diag(−1, −1, 0, 0, 0, 0), Ric = −g, R# = 0 for the same reason.
  - S^n of curvature 1: R = I, lambda = n − 1, W = 0.

## Hypothesis inventory

**Statement (Passage A).** Locally symmetric (nabla R = 0); Einstein, Ric = lambda g; W = R − cI with c = lambda/(n−1); the parenthetical (lambda != 0) attached to the theta display; for the second display, lambda = 1/2. No dimension range, no compactness, no completeness, no irreducibility. Passage C adds nothing. Passage D adds compactness and drops lambda != 0 from the body (it stays in the heading).

**Richard–Seshadri Lemma 4.1, read at source** ([richard-seshadri-1308.1190.pdf](https://arxiv.org/abs/1308.1190), page 10, text lines 510–513):

```
Lemma 4.1. Let (M n , g0 ) be a non negatively curved Einstein symmetric space, then
its curvature operator R satisfies :
                                          Q(R) = λ R                                           (3)
where λ > 0 is such that Ricg0 = λg0 .
```

- Hypotheses: (i) nonnegatively curved, (ii) Einstein, (iii) a symmetric space. The conclusion carries lambda > 0.
- Its proof (page 11, text lines 526–532) imports Proposition 3 of [Bre10a] ("Since (M n , g0 ) is Einstein, we can use Proposition 3 of [Bre10a] to get ... ∆g0 Rg0 +2Q(Rg0 ) = λ R") and nabla R = 0. [Bre10a] is Brendle, Duke Math. J. 151 (2010). **It is not filed.** Its hypotheses cannot be read.
- Against the object: (i) fails at every lambda < 0 space and is unargued at locally symmetric lambda > 0 spaces, (ii) holds, (iii) fails for a locally symmetric space that is not globally symmetric, which is what Passage B's "with no completeness hypothesis" asserts coverage of. See Section 1.

**Böhm–Wilking Lemma 2.1, read at source** ([boehm-wilking-math0606187.txt](https://arxiv.org/abs/math/0606187), lines 216–218):

```
Lemma 2.1. Let R ∈ SB (so(n)). Then
                                                n−2
                R + R #I = (n − 1) RI +             RRic0 = Ric ∧ id .
                                                 2
```

- Hypothesis: R is an algebraic curvature operator (first Bianchi). W is Weyl, so it holds. Its proof verifies the Weyl kernel directly at n = 4 and embeds for n >= 5. At n = 2, 3 the Weyl space is 0.
- Consequences used: W + W#I = 0 (W Weyl), and at R = I, I + I#I = (n−1)I, so I#I = (n−2)I and Q(I) = (n−1)I.

**Total symmetry of (X,Y,Z) ↦ ⟨B(X,Y), Z⟩**: Böhm–Wilking (5) and the sentence after it ("tri is symmetric in all three components"), text lines 186–187, repeated by Richard–Seshadri at text lines 408–410. Used for criticality and for the consistency check in step (C).

**Petersen–Stanfield's normalisation, read at source** ([petersen-stanfield-2508.11236.txt](https://arxiv.org/abs/2508.11236), lines 37–41 and 294):

```
We consider compact simply-connected symmetric spaces: M = G/H, where G
is a compact semi-simple Lie group [...] we equip G/H with the G-invariant
submersion metric induced by −Bg . With this metric, M is Einstein with Einstein
constant 21 .
```

(the extraction renders 1/2 as "21", and line 294 prints Ric = (1/2) g = −(1/2) B_g). Hypotheses: G compact semisimple, metric induced by −B_g. It is a choice of scale.

**Used but unstated.** W != 0 (Section 3). For step (A) at lambda < 0 or at a locally symmetric space that is not a nonnegatively curved symmetric space: the identity Q(R) = lambda R itself (Section 1). Compactness is stated in Passage D and used nowhere.

## 1. Step (A) against its source

**Derivation checked.** Passage B, line 616: "[Richard–Seshadri](...) Lemma 4.1 gives it directly for a locally symmetric Einstein space, with no completeness hypothesis." Passage A applies it under (lambda != 0), and the annotation at problem.md line 624 (displayed for item 11) adds "*$\lambda<0$ is harmless*".

The source's proof, as printed on page 11 (checked on the rendered PDF, not only the extraction), reads ΔR + 2Q(R) = λR, then "since g0 is symmetric, R is parallel and ΔR = 0. This proves that Q(R) = λR."

### Finding 1a. The cited lemma does not state the object it is applied to (HYPOTHESIS-DEBT)

1. **Location.** problem.md line 616, quoted above, against Richard–Seshadri text lines 510–513.
2. **Closed-form failure of the citation.** H^2 × H^2, both factors of curvature −1: a symmetric space, Einstein with lambda = −1, W = R + (1/3)I with eigenvalues (−2/3, −2/3, 1/3, 1/3, 1/3, 1/3), so W != 0. It is not nonnegatively curved, and lambda > 0 fails. Lemma 4.1's hypotheses do not hold, so the lemma does not deliver step (A) there. The compact quotient Σ × Σ of two closed hyperbolic surfaces is a compact locally symmetric Einstein space with the same curvature operator at every point. It sits inside Passage D's hypotheses and outside Lemma 4.1's.
3. **Charitable reading.** The proof of Lemma 4.1 uses neither nonnegative curvature nor lambda > 0 nor global symmetry: it uses an Einstein identity and nabla R = 0, both pointwise. On that reading the proof reaches every locally symmetric Einstein space. The reading stands only if Brendle's Proposition 3 holds for Einstein metrics of either sign without completeness, and that source is not filed. The identity is not false at the screen: at H^2 × H^2, R^2 = diag(1, 1, 0, 0, 0, 0) and R# = 0, so Q(R) = −R = lambda R. The screen is consistent with the claim and is no evidence for it. **The candidate survives as debt, not as a refutation.**

**What would have to be proved:** for every Einstein metric Ric = lambda g with nabla R = 0, lambda of either sign, no completeness, the pointwise identity Q(R) = lambda R. Through Richard–Seshadri's route this is a filed statement of Brendle's identity with its hypotheses, in the normalisation where it reads ΔR + 2Q(R) = 2λR (Finding 1b). For lambda > 0 alone, a filed argument that a locally symmetric Einstein space's curvature operator at a point is that of a nonnegatively curved Einstein symmetric space would bring it under Lemma 4.1 as stated.

### Finding 1b. The source's printed intermediate identity does not yield its conclusion (recorded against the import)

1. **Location.** Richard–Seshadri page 11, text line 528: "∆g0 Rg0 +2Q(Rg0 ) = λ R".
2. **Closed-form failure.** With ΔR = 0 the printed identity gives Q(R) = (lambda/2) R, not the conclusion Q(R) = lambda R. At S^n of curvature 1, R = I, lambda = n − 1, ΔR = 0, and Q(I) = (n−1)I by Böhm–Wilking Lemma 2.1. Then ΔR + 2Q(R) = 2(n−1)I while lambda R = (n−1)I. The printed identity is false at S^n, n >= 2.
3. **Charitable reading.** A factor-2 misprint. The conclusion Q(R) = lambda R agrees with the sphere screen, and the proof goes through with 2λR on the right. The constant 2λR is what the conclusion requires, but the constant's source is the unfiled [Bre10a], so the correct form cannot be read at source. **The candidate survives as a defect of the imported proof.** It does not change L46's conclusion, and it strengthens Finding 1a's debt: the one on-file route to step (A) passes through an identity printed wrong and sourced to an unfiled theorem.

**Verdict for claim 1: HYPOTHESIS-DEBT.** Within Lemma 4.1's stated hypotheses (nonnegatively curved Einstein symmetric space, lambda > 0) the step is a published lemma read at source.

## 2. Steps (B), (B'), (C)

**(B).** Bilinearity of B and B(X,X) = Q(X) give Q(W + cI) = Q(W) + 2c B(W,I) + c^2 Q(I). With Q(R) = lambda R and R = W + cI:

lambda W + lambda c I = Q(W) + 2c (W∘I) + c^2 (n−1) I,

so Q(W) = lambda W + lambda c I − c^2 (n−1) I − 2c (W∘I), exactly the printed line. The remainder with W∘I = 0 is c(lambda − c(n−1)) I, which vanishes at c = lambda/(n−1). Correct.

**(B').** B(X, I) = (1/2)(XI + IX) + X#I = X + X#I. So W∘I and W#I differ by +W. Correct. The record's pointer "Φ(I,W) = W − W = 0" names a Φ the brief does not define, so that line was not checked. The step does not need it: (B') and (C) give W∘I = W + (−W) = 0 directly.

**(C).** Böhm–Wilking Lemma 2.1 at R = W (R_I = 0, R_Ric0 = 0) gives W + W#I = 0, so W#I = −W. Correct at source. The record's own argument (the Casimir expansion and isotropy-cap.md's −2 eigenvalue) is not quoted in the brief and was not checked. It is not needed. Consistency line: tr(W#) = ⟨W#W, I⟩ = ⟨W#I, W⟩ by total symmetry of ⟨B(·,·),·⟩ restricted to its # part (Böhm–Wilking (5) states the symmetry of tr(2(R1#R2)R3) directly), and this equals −‖W‖^2. Correct.

**Chain.** Given Q(R) = lambda R, the three steps yield Q(W) = lambda W at every n, including W = 0 where it is trivial. **CONFIRMED.**

### Withdrawn candidate 2w

- "c = λ/(n−1) is the choice that kills the remainder" reads as if c were free. (1) line 618. (2) c = 0 also kills c(lambda − c(n−1)). (3) c is not chosen: the definitions fix c as the I-coefficient of R, and W∘I = 0 holds only for that c because W must be Weyl. The sentence is loose wording under a correct chain. **Withdrawn.**

## 3. theta(W/‖W‖) = lambda/‖W‖ and criticality under lambda != 0

**Derivation.** For W != 0, theta(W/‖W‖) = P(W)/‖W‖^3 = ⟨W, lambda W⟩/‖W‖^3 = lambda/‖W‖. Criticality of W/‖W‖ for P on the unit sphere of the Weyl space: by total symmetry of ⟨B(·,·),·⟩, dP_W(H) = 3⟨Q(W), H⟩ = 3 lambda ⟨W, H⟩, which vanishes for H ⊥ W. The multiplier at unit norm is lambda/‖W‖. Both follow from Q(W) = lambda W once W != 0.

### Finding 3. lambda != 0 does not exclude W = 0 (REFUTED AS STATED)

1. **Location.** Passage A, problem.md line 630: "θ(W/‖W‖) = λ/‖W‖ (λ≠0)". Passage B line 614: "THE HYPOTHESIS λ≠0 IS PART OF THE STATEMENT, at λ=0 ... W=0 and θ is undefined". Passage C (results.md line 106) and Passage E (graded-half.md line 210) carry the same hypothesis.
2. **Closed-form failure.** S^4 of curvature 1: locally symmetric, Einstein with lambda = 3 != 0, R = I, c = 1, W = 0. W/‖W‖ and lambda/‖W‖ are undefined, and no critical point exists. The same holds at every space form of nonzero curvature in every n, at every n = 3 space (the Weyl space is 0), and at every n = 2 space. In Petersen–Stanfield's own normalisation, S^n = SO(n+1)/SO(n) has lambda = 1/2 and W = 0, so the second display's denominator ‖R‖^2 − (tr R)^2/N is 0.
3. **Charitable reading.** One could read (lambda != 0) as shorthand for "nondegenerate case". The record rules that out: Passage B presents lambda != 0 as the hypothesis making theta defined, and the annotation at problem.md line 624 already says "**the conclusion needs $W\ne0$ and neither the block nor the canon says so**" while the statement at line 630 still carries only lambda != 0. The Lean statement uses 0 < ‖W‖, which is the right hypothesis. **The candidate survives.**

**Corrected hypothesis:** W != 0. With it the conclusion holds (given step (A)), and lambda != 0 is then redundant for the conclusion, since the formula would return theta = 0 at lambda = 0 if W != 0 there.

## 4. The lambda = 0 argument

Passage B line 614 asserts that a locally symmetric Ricci-flat space is flat and places the work in "the decomposition of L210 with the definiteness of β on an irreducible factor". L210 and β are not quoted or defined in the brief, so the argument cannot be checked from it. Two observations from the displayed source lines:

- The argument is not load-bearing. It only justifies excluding lambda = 0, and the corrected hypothesis W != 0 makes the exclusion automatic.
- The record contradicts itself on the instrument. Line 614 says "THE INSTRUMENT IS NOT CARTAN--AMBROSE--HICKS". Line 624, in the same block, still says "flat by Cartan". Passage F's docstring, which calls itself "quoted verbatim from problem.md", says "flat by Cartan–Ambrose–Hicks with de Rham", a sentence line 614 no longer contains.

**Verdict: HYPOTHESIS-DEBT, not load-bearing.** What would have to be proved is locally symmetric plus Ricci-flat implies R = 0, at the pointer L210.

## 5. The theta^2 display, the ‖W‖^2 identity, and lambda = 1/2

**‖W‖^2 = ‖R‖^2 − (tr R)^2/N.** R = cI + W with ⟨W, I⟩ = tr W = 0 gives ‖R‖^2 = c^2 N + ‖W‖^2. tr R = cN, so c^2 N = (tr R)^2/N. Correct for every Einstein R.

**The display.** theta^2 = lambda^2/‖W‖^2 = lambda^2/(‖R‖^2 − (tr R)^2/N). It equals 1/(4(‖R‖^2 − (tr R)^2/N)) exactly when lambda^2 = 1/4, and it needs W != 0.

| Passage | Under which lambda it prints the display | Status |
|---|---|---|
| A (line 632–634) | "In Petersen–Stanfield's normalisation ... λ=1/2" | holds (W != 0 owed, Section 3) |
| C (results.md 106) | "under the Einstein normalisation" | holds if that names lambda = 1/2, which the sentence does not say |
| D (results.md 390) | in the "Then" clause, for "a scalar λ", before normalising | fails, Section 6 |
| E (graded-half.md 222) | "λ=1/2 ... in Petersen–Stanfield's normalisation", also printing theta = 1/(2‖W‖) | holds (W != 0 owed) |

**Petersen–Stanfield, attack item 8.** At source (lines 37–41, 294) every compact simply-connected symmetric space G/H of compact type with the metric induced by −B_g is Einstein with constant 1/2. That covers every compact irreducible one, the type II Lie groups included (G = H × H), and also reducible products of compact type. The phrase "λ=1/2 for every compact irreducible symmetric space" is correct as a statement about that normalisation. It is a scale choice, and theta(W/‖W‖) is scale-invariant while the right-hand side of the display is not, so the display applies to the PS-scaled curvature operator only.

Screen: S^2 × S^2 at k = 1/2 (PS-scaled). ‖R‖^2 = 1/2, tr R = 1 = n/4, (tr R)^2/N = 1/6, ‖W‖^2 = 1/3. theta = (1/2)/sqrt(1/3) = sqrt(3)/2, theta^2 = 3/4 = 1/(4 · 1/3). Q(R) = R^2 = (1/2)R. Consistent.

**Verdict: CONFIRMED at lambda = 1/2 (or −1/2) with W != 0.**

### Withdrawn candidate 5w

- "λ=1/2 for every compact irreducible symmetric space" might be read to confine the display to irreducible spaces while Passage D applies it to S^6 × S^6. (1) line 632. (2) S^6 × S^6 is reducible. (3) The display uses only lambda = 1/2 and W != 0, and PS's normalisation gives lambda = 1/2 on products of compact type too. **Withdrawn.**

## 6. Passage D

### Finding 6. The theta^2 display is asserted at an unnormalised lambda (REFUTED AS STATED)

1. **Location.** results.md line 390: "Then $Q(W)=W^2+W^\#=\lambda W$ for a scalar $\lambda$, so ... its value is $\theta=\lambda/\lVert W\rVert$ with $\theta^2=\frac1{4(\lVert R\rVert^2-(\operatorname{tr}R)^2/N)}$. Normalising to Einstein constant $\tfrac12$ makes ..."
2. **Closed-form failure.** S^2 × S^2 with both factors of curvature 1/4: compact, symmetric, Einstein with lambda = 1/4, R = diag(1/4, 1/4, 0, 0, 0, 0). ‖R‖^2 = 1/8, tr R = 1/2, (tr R)^2/N = 1/24, ‖W‖^2 = 1/12. Passage D's own value theta = lambda/‖W‖ = (1/4)·sqrt(12) = sqrt(3)/2 gives theta^2 = 3/4. Passage D's display gives 1/(4 · 1/12) = 3. The two conclusions of the same sentence disagree, 3/4 != 3.
3. **Charitable reading.** The next sentence normalises to lambda = 1/2, so the author may have meant the display under that normalisation. The display sits in the "Then" clause before the normalisation is introduced, with lambda declared "a scalar", so as written it asserts the display at every lambda. **The candidate survives.**

Passage D's body also lacks both lambda != 0 and W != 0 (only its heading says lambda != 0). A flat torus (compact, locally symmetric, lambda = 0, W = 0) and a closed hyperbolic 4-manifold (lambda = −3, W = 0) satisfy its hypotheses, and "W/‖W‖ is a critical point" is undefined at both. It also includes lambda < 0 objects such as Σ × Σ, where step (A) carries Finding 1a's debt.

**Attack item 6, compactness.** The proof uses no compactness: steps (A) (on the charitable reading of the source proof), (B), (B'), (C) are pointwise. Passage D's "compact" is an unused restriction, and it does not exclude lambda < 0. Passage C at line 106 says "compactness is not needed, this entry required it", while Passage D at line 390 still says compact. The two canonical forms disagree.

### Claim 6'. The reformulation at lambda = 1/2 (CONFIRMED AS ALGEBRA)

- tr R = n·lambda/2 = n/4. Correct.
- c = lambda/(n−1) = 1/(2(n−1)). Correct.
- theta = 1/(2‖W‖) > 0, so for theta_0(n) > 0: theta <= theta_0(n) iff 1/(4‖W‖^2) <= theta_0(n)^2 iff ‖W‖^2 >= 1/(4 theta_0(n)^2). Correct. theta_0(n) is not defined in the brief, and positivity is assumed.
- S^6 × S^6 balanced: each factor has Ric = 5k g = (1/2) g, so k = 1/10. R has eigenvalue 1/10 with multiplicity 30 and 0 with multiplicity 36. ‖R‖^2 = 3/10, tr R = 3 = 12/4, N = 66, (tr R)^2/N = 3/22, ‖W‖^2 = 3/10 − 3/22 = 18/110 = 9/55. Correct. 9/55 < 1/6 since 54 < 55. Correct.
- "attaining θ0(12) exactly": theta_0 is undefined in the brief. Internal consistency only: if 1/(4 theta_0(n)^2) = n^2/(8(n−1)(n−2)), as the final sentence's juxtaposition implies, then at n = 12 this is 144/880 = 9/55, the S^6 × S^6 value. Consistent.
- 1/6 = n^2/(8(n−1)(n−2)) iff 8(n−1)(n−2) = 6n^2 iff n^2 − 12n + 8 = 0 iff n = 6 ± 2 sqrt(7). The root 6 − 2 sqrt(7) lies in (0, 1), outside any dimension, so "only at n = 6 + 2√7" is right on n >= 2. It is not an integer since sqrt(7) is irrational. Correct.
- For n >= 3 (positive denominator), 1/6 >= n^2/(8(n−1)(n−2)) iff n^2 − 12n + 8 >= 0. Correct. On integers this is n >= 12, and for 3 <= n <= 11 the inequality is reversed. Whether "the two halves meet" is enough for L47 and L48 is outside L46 and was not assessed.

### Withdrawn candidate 6w

- "coincide only at n = 6 + 2√7" omits the root 6 − 2√7. (1) line 390. (2) 6 − 2√7 also solves n^2 − 12n + 8 = 0. (3) It is below 1 and no dimension. **Withdrawn.**

## 7. Passage E's four-line proof

- **Line 1**, Q(R) = lambda R "(∇R=0⇒ΔR=0, and the metric shrinks homothetically under Ricci flow)". This is a sketch. The evolution equation it relies on is Hamilton's ∂R/∂t = ΔR + 2Q(R), stated at Richard–Seshadri text lines 259–262 (citing [Ham86], not filed). The homothety step is asserted, not derived. "shrinks" holds at lambda > 0 only. At lambda < 0, which E's hypothesis lambda != 0 admits, g(t) = (1 − 2λt)g expands. Wording defect. Passage B itself calls this route "the weaker route".
- **Line 2**, Q(I) = (n−1)I since I# = (n−2)I. Correct by Böhm–Wilking Lemma 2.1 at R = I.
- **Line 3**, total symmetry "collapses P(W) and λ‖W‖^2 to the same expression". P(W) = ⟨W, Q(W)⟩ = lambda ‖W‖^2 follows from Q(W) = lambda W directly. Correct.
- **Line 4**, R#I = λI − R gives R∘I = λI. Böhm–Wilking Lemma 2.1 at Einstein R (R_Ric0 = 0): R + R#I = (n−1)·(lambda/(n−1)) I = lambda I. Then R∘I = R + R#I = lambda I. Correct.
- The route through line 4 is equivalent to (B)–(C): Q(R) = Q(W) + 2c R∘I − c^2 Q(I) gives the same cancellation.
- E's statement carries lambda != 0 without W != 0 (Finding 3).
- "Reviewer 86 ... bridge identity λ_i = 1/(c_i+2)" uses symbols the brief does not define. Not checked. The quoted values "HP^m, CP^m, Gr_C(2,2) = 14/27, Gr_C(2,3) = 275/774" rest on tables the brief does not quote. Not checked as evidence. The notation leaves unsaid whether 14/27 is theta or theta^2. Its form 1/(4‖W‖^2) suggests theta^2.

**Verdict: CONFIRMED AS ALGEBRA** (lines 2–4). Line 1 is a sketch that step (A) of Passage B supersedes, and it carries Finding 1a's scope question.

### Withdrawn candidate 7w

- Passage B line 616 says the flow route "needs short-time existence". (1) line 616. (2) Showing the claim false would require exhibiting that Hamilton's evolution equation applies to the explicit homothetic family without an existence theorem, which is an argument not on file, and this verifier does not supply one. (3) The sentence comments on a route the proof does not take. **Withdrawn: not load-bearing, and no closed-form failure without supplying an argument.**

## 8. Passage F, the Lean statements

Passage F agrees with [L46Statement.lean](../lean/HamiltonsCubic/Results/L46Statement.lean) on disk except for one trailing blank line (the brief says 152 lines, the file has 151). The file contains no `sorry`. It was read, not built.

**shift_kills_remainder.** Binders: `Qb : E →ₗ[ℝ] E →ₗ[ℝ] E`, `hsymm`, `I W : E`, `n : ℕ`, `lam c : ℝ`, `hn : (n:ℝ) − 1 ≠ 0`, `hQI : Qb I I = (n−1) • I`, `hWI : Qb W I = 0`, `hc : c = lam/(n−1)`, `hcrit : Qb (W + c•I) (W + c•I) = lam • (W + c•I)`. Conclusion `Qb W W = lam • W`.

- The proof expands to Qb W W + (c·c·(n−1)) • I = lam • W + (lam·c) • I and uses c·c·(n−1) = lam·c at c = lam/(n−1), which is lam^2/(n−1) on both sides. Directions of all equalities match Section 2.
- `hn` excludes n = 1 only. `hWI` is the Weyl condition W∘I = 0, and no Weyl W is excluded. `hcrit` is step (A), taken as a hypothesis. Nothing in the hypotheses excludes an intended instance.
- The statement is step (B) with (A), (B'), (C) as inputs. The theorem's docstring says so. The module doc's "`shift_kills_remainder` is the whole of steps (A)–(C)" overstates it, since (A) and (C) enter as binders.

**theta_of_eigenvalue.** Binders `R`, `lam`, `hnn : 0 ≤ normSq R`, `hpos : 0 < norm R`, `hP : Pcubic R = lam * normSq R`. Conclusion `theta R = lam / norm R`. theta R = lam·norm^2/norm^3 = lam/norm. Correct. `hpos` excludes W = 0, which is the right hypothesis (Section 3).

**petersen_stanfield.** All binders are real scalars. `hw : w^2 = nR^2 − trR^2/NN` and `hth : th = (1/2)/w` give th^2 = 1/(4w^2). Correct. It is a scalar identity: nothing ties `w`, `nR`, `trR`, `NN` to W, R, N, and the ‖W‖^2 identity of Section 5 is a hypothesis.

### Finding 8a. The docstring's reason for not bridging Q to P is false against the layer it imports (CONFIRMED)

1. **Location.** L46Statement.lean module doc: "the real Weyl layer carries `Pcubic` and `normSq` but no operator `Q` with `P(R) = ⟨Q(R), R⟩`."
2. **Failure.** [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), which the file imports, defines `def Qop (R ...) := fun X => compOp R X + sharpOp R X` ("Hamilton's map `Q(R) = R² + R#`"), defines `IsCritical R th` as `Qop R (phi i j) = th • R (phi i j)`, and proves `theorem Pcubic_eq_inner_Qop (R ...) : Pcubic R = innerOp R (Qop R)` with no `sorry`. By `git log`, those entered in ad9bf8b3 (2026-09-09), after L46Statement's first commit fe950b39 (2026-09-08).
3. **Charitable reading.** The sentence was true when written. It is stale, and a reader of the file today is told a bridge is missing that the base layer supplies. WeylReal's own note says `Pcubic_eq_inner_Qop` is a tautology of the definitions, so the bridge it gives certifies no normalisation of #. That does not rescue the sentence, which asserts that no such operator exists. **Survives.**

### Finding 8b. The "verbatim" quotation of the lambda = 0 parenthetical no longer matches its source (CONFIRMED)

1. **Location.** L46Statement.lean: "> at $\lambda=0$ a locally symmetric Ricci-flat space is flat by Cartan–Ambrose–Hicks with de Rham, so $W=0$ and $\theta$ is undefined", under "quoted verbatim from problem.md".
2. **Failure.** problem.md line 614 reads "at $\lambda=0$ a locally symmetric Ricci-flat space is flat, so $W=0$ and $\theta$ is undefined. **THE INSTRUMENT IS NOT CARTAN--AMBROSE--HICKS, WHICH AN EARLIER VERSION OF THIS PARENTHETICAL NAMED**".
3. **Charitable reading.** The quotation predates the correction. It is still labelled verbatim and quotes the attribution the source now withdraws. **Survives.**

### Finding 8c. The hypothesis W != 0 is called a form of lambda != 0, and the non-vacuity witness types less than it claims (CONFIRMED)

1. **Location.** `theta_of_eigenvalue` docstring: "`hpos` is the record's `λ ≠ 0` clause in the form it is actually needed, `W ≠ 0`". The non-vacuity example docstring: "A witness for `shift_kills_remainder`'s hypotheses, so the theorem is not vacuous".
2. **Failure.** At S^4, lambda = 3 != 0 and W = 0 (Section 3), so W != 0 is not a form of lambda != 0. It is a different, stronger hypothesis. The example proves only the conjunction `Qb I I = (n−1) • I ∧ Qb 0 I = 0`, that is `hQI` and `hWI`. It does not exhibit `hsymm`, `hc`, `hcrit` or `hn`, and it quantifies over all `n : ℕ` including n = 1, where `hn` is false.
3. **Charitable reading.** The remaining hypotheses are easily met at that instance (multiplication on ℝ is symmetric, `c` can be defined, and with W = 0 `hcrit` reads (c(n−1))^2 = lam·c(n−1), true at c = lam/(n−1)). The theorem is not vacuous. The example as typed still witnesses two of six hypotheses, and its W = 0 makes the conclusion trivial. The Lean hypothesis `hpos` is correct. The prose is what is wrong. **Survives as a documentation defect, with no effect on what is proved.**

**Verdict for claim 8: CONFIRMED AS ALGEBRA.** The three theorems type what their docstrings say they type, as algebra over abstract or scalar inputs. The link to the curvature operator (Qb as B, `Pcubic` as P, `w` as ‖W‖) is absent, as the file states.

### Withdrawn candidate 8w

- `hnn : 0 ≤ normSq R` may be derivable from the definitions. (1) the binder. (2) If derivable, it is a redundant hypothesis. (3) A redundant hypothesis excludes nothing, and `innerOp`'s definition was not read to settle it. **Withdrawn.**

## 9. Attack item 11, the sentences

### Finding 9. Two sentences in the record do not read as sentences, and the pointer sentence contradicts the block beneath it (REFUTED AS STATED)

1. **Location.**
   - problem.md line 626: "*The statement is below; the section it used to point at is". The line ends there, with no complement and no closing asterisk.
   - results.md line 106 (Passage C): "... gives the identity flow-free.*act locally symmetric Einstein space, $Q(W)=\lambda W$, so $W/\lVert W\rVert$ is a critical point ...".
   - problem.md line 612, the pointer sentence heading the block: "*The argument is not elsewhere in this file: [graded-half.md](graded-half.md) carries a four-line proof labelled as this lemma's, and **the result is published**, Richard–Seshadri Lemma 4.1, in [references/](../references/).*"
2. **Failure.**
   - Line 626 breaks off after "is". The unclosed `*` leaves the emphasis unterminated before the statement at line 628.
   - Line 106 splices "*act locally symmetric Einstein space" (apparently the tail of "compact locally symmetric Einstein space") onto the end of the italic annotation. "act locally symmetric Einstein space, Q(W) = λW, so ..." has no subject or verb of its own.
   - Line 612 is grammatical. It says the argument is not in problem.md, while lines 614–622 of problem.md hold a three-step proof. graded-half.md line 212 in turn says "the four-line argument below is its proof", so two files each point at a different proof as the lemma's.
3. **Charitable reading.** These are editing remnants. Line 612 may predate the proof block. None changes the mathematics, and each still misleads a reader on where the proof lives or what the canon says. **Survives, as editorial.**

## 10. Boundary, attack item 10 and standing item 3

| Edge | Result |
|---|---|
| lambda < 0 | The algebra (B)–(C) holds. Step (A) carries Finding 1a's debt. Screen at H^2 × H^2 is consistent with Q(R) = lambda R. theta = lambda/‖W‖ < 0, and theta^2 is unchanged at lambda = −1/2. |
| lambda = 0 | Excluded by hypothesis. Its justification is Section 4's debt. With W != 0 as the hypothesis the exclusion is automatic if L210 holds. |
| W = 0 | Not excluded by lambda != 0 (Finding 3). Excluded by the Lean `hpos`. |
| n = 2, 3 | Weyl space 0, so W = 0 at every such space. The theta conclusions are undefined throughout. Q(W) = lambda W is trivially true. |
| n = 4 | Böhm–Wilking's proof of the Weyl kernel is the direct n = 4 verification. The SO(4) splitting of the Weyl space plays no part. S^2 × S^2 and H^2 × H^2 screens are n = 4. No finding. |
| Reducible | Covered. The statement needs no irreducibility, and PS's normalisation gives lambda = 1/2 on compact-type products. S^2 × S^2 and S^6 × S^6 are consistent. No finding. |
| ker W != 0 | No step inverts W or uses its spectrum. No finding. |

## 11. Standing items

**Quantifier order and scope (item 2).** The statement is universal over locally symmetric Einstein spaces, pointwise at each x, with c determined by lambda and n. No step exchanges quantifiers. The one scope issue is the lambda of the second display: in Passage A it is fixed by the normalisation, in Passage D it is left free (Finding 6). No further finding.

**Proven against stated or used (item 4).** Proven, from filed sources: Q(W) = lambda W at every Einstein curvature operator R with Q(R) = lambda R. Also proven: theta(W/‖W‖) = lambda/‖W‖, criticality at W != 0, and the theta^2 display at lambda = 1/2, W != 0. Q(R) = lambda R itself is proven by a filed lemma only for nonnegatively curved Einstein symmetric spaces. Stated: all locally symmetric Einstein spaces with lambda != 0, no W != 0, and in Passage D the display at every lambda. Used downstream (Passage D): the lambda = 1/2 reformulation, which is correct as algebra on the corrected statement.

**Falsifier (item 7).** The statement's core would be falsified by a locally symmetric Einstein space with W != 0 and Q(W) != lambda W, equivalently (by Section 2's algebra) Q(R) != lambda R. The natural place to look is outside Lemma 4.1's hypotheses, at lambda < 0. What was done: exact hand screens at S^n (R = I), S^2 × S^2 at k = 1/2 and k = 1/4, and H^2 × H^2 at k = −1. Each satisfies Q(R) = lambda R. No falsifier of the core was found, and the screens are not evidence for it. The theta display under lambda != 0 alone is falsified at S^4 (Finding 3), and Passage D's theta^2 display at S^2 × S^2 with k = 1/4 (Finding 6).

## Overall verdict

**HYPOTHESIS-DEBT.**

- The algebraic chain (B), (B'), (C) is correct.
- The theta conclusions need W != 0, which no statement carries.
- Step (A) cites Richard–Seshadri Lemma 4.1 beyond its stated hypotheses (nonnegatively curved Einstein symmetric space, lambda > 0). The extension to lambda < 0 and to locally symmetric spaces rests on reading a proof whose one import, Brendle's Proposition 3, is not filed and whose printed intermediate identity is off by a factor of 2.
- Restricted to nonnegatively curved Einstein symmetric spaces with W != 0, the lemma is PROVEN (hypotheses corrected) from filed sources.
