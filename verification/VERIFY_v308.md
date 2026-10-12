# Verifier v308, Lemma L91: the identity Gram lower bound on rank of mu_K, the consistency remark, the catalecticant rank formula and its dimension count, the Delta remarks, and the Casimir collisions

The brief ([BRIEF_L91.md](BRIEF_L91.md)) was read cold. No numerical work was done, every value below is exact, and no scripts were written or run. The quotations were checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 175, 189-195 and 153 only, and match verbatim. Log: agent_logs/verify-L91-v308.log.

| # | Claim | Verdict |
|---|---|---|
| 1 | The quantity bounded is rank mu_K. The identity Gram is an invariant form, and Delta is a sum of squares of cubics of K, psd, invariant, and vanishes on the orbit cone | CONFIRMED |
| 2 | Delta is nonzero, hence rank mu_K >= 1 "unconditionally" | HYPOTHESIS-DEBT |
| 3 | 36 - rank is the dimension of the solution set only when the system is consistent | CONFIRMED AS ALGEBRA |
| 4 | rank = 14 - dim{F : Cat_F(K,K) = 0}, a space containing A(W_0^6) | CONFIRMED AS ALGEBRA |
| 5 | The dimension count 14 + 29 - 65 < 0, "so 13 holds unless a second coincidence occurs" | HYPOTHESIS-DEBT |
| 6 | Delta vanishes exactly on the orbit cone, F_5 is not proportional to Delta, F_5/Delta in [2.50, 3.15], bounded and positive | HYPOTHESIS-DEBT |
| 7 | Casimir equalities at c = 60, 40, 30 and "both with odd second label" | CONFIRMED AS ALGEBRA |
| 8 | "Two of the three Casimir collisions vanish", which blocks die, and that c = 30 survives | HYPOTHESIS-DEBT |
| 9 | Scope against Lemma L90 | CONFIRMED |

**Summary:** the headline bound rank mu_K >= 1 is true, but the record supports its one nontrivial link (Delta is nonzero) only by a sampled value, and the tightness count, the Delta remarks and the block deaths carry no argument on file. Overall verdict: HYPOTHESIS-DEBT.

## 0. Conventions, fixed once

- W_5 is the 35-dimensional space of algebraic Weyl tensors on R^5 with its standard O(5)-invariant inner product, and O(5) acts orthogonally on it.
- K is an O(5)-stable space of real cubics on W_5 (stability is forced by the phrase "the 36 invariant symmetric forms on K", which presupposes an O(5)-action on K). Every q in K vanishes at W_0: Lemma L90 as given states that q q' vanishes at W_0 for all q, q' in K, and q' = q gives q(W_0)^2 = 0.
- The apolar inner product on cubics is the one induced from the inner product on W_5. Its normalization is not stated in the brief. (q_a) is an orthonormal basis of K for it.
- S^6_inv is the 14-dimensional space of O(5)-invariant sextics. G_inv is the 36-dimensional real space of O(5)-invariant symmetric Grams on K (all symmetric invariant forms, psd or not).
- mu_K : G_inv -> S^6_inv, G -> sum_{a,b} G_ab q_a q_b. "rank" with no qualifier means the rank of this linear map over R.
- Cat_F(q, q') for a sextic F means the apolar pairing <F, q q'>, up to a fixed nonzero constant. For a point p of W_5, l_p denotes the linear form <p, .>, so <l_p^6, P> is a nonzero constant times P(p) for every sextic P.
- Casimir labels (l1, l2) are read in the orthogonal (partition) basis of B2 = so(5), with l1 >= l2 >= 0, rho = (3/2, 1/2), and c(l1, l2) = <l, l + 2 rho> = l1(l1 + 3) + l2(l2 + 1). In this basis W_5 is the irreducible (2, 2).

## Hypothesis inventory

| Hypothesis | Source | Used where | Stated? |
|---|---|---|---|
| K is O(5)-stable | implicit in "the 36 invariant forms on K" | identity Gram is invariant, Delta is invariant | implicit in the definitions |
| Every q in K vanishes at W_0 | definition of K, and L90's cap premise | Delta vanishes on the orbit | yes, in L90 |
| The apolar inner product is O(5)-invariant | standard (induced from an invariant inner product on W_5) | "the identity Gram on K is one of the 36 invariant forms" | no, used without mention |
| K is nonzero | follows from dim G_inv = 36 | Delta is nonzero | no |
| F_5 is an O(5)-invariant sextic | not in the brief | "F_5 must lie in the image" of mu_K, whose codomain is S^6_inv | no |
| F in the rank formula ranges over S^6_inv | not in the brief | bullet 3's formula | no, and the formula is false over all sextics (Section 4) |
| The apolar pairing is positive definite on sextics and the Frobenius form is positive definite on G_inv | standard | bullet 3's formula | no |
| The meaning of 29 and 65 | nowhere on file | bullet 3's count | no |
| Which Casimir blocks occur, and the criterion for a block to "die" | nowhere on file | Casimir paragraph | no |
| Lemma L90 (cap, and rank 13 conditional on one measured rank and three hypotheses) | given | Sections 3, 4, 9 | yes, taken as stated |

Every use of L90 in the passage matches what L90 states: L91 invokes only the cap rank mu_K <= 13 (implicitly, through "13 holds unless") and never the measured lower bound.

## 1. What is bounded, and the identity Gram (attack items 1 and 2, first half)

**The quantity.** Neither the heading ("the unconditional lower bound 1") nor the first bullet names the quantity bounded. Bullets 2 and 3 use "rank" with 36 and 14, which fixes it as rank mu_K. This is the rank L90's cap bounds above. It is a different quantity from rank(ev o mu_K) at the certificate's 40 points, which is the quantity L90's open measurement concerns.

**Derivation, link by link.**

1. The identity Gram is invariant. In an orthonormal basis the identity Gram is the element sum_a q_a (x) q_a of Sym^2 K, which is the inner product itself. For g in O(5), (g.q_a) is again an orthonormal basis of K because K is stable and the apolar inner product is invariant, so the element is fixed. The record asserts this without argument, and it rests on the unstated invariance of the apolar inner product (inventory row 3). That fact is standard, so no finding is raised.
2. mu_K(Id) = sum_a q_a^2 = Delta. Direct from the definition.
3. Delta is psd and a sum of squares of cubics of K. Direct.
4. Delta is invariant. Delta(g W) = sum_a (g^{-1}.q_a)(W)^2, which is the same sum over another orthonormal basis, and the sum is basis independent.
5. Delta vanishes on the orbit cone. Delta(t g W_0) = t^6 Delta(W_0) = t^6 sum_a q_a(W_0)^2 = 0.

Verdict for claim 1: CONFIRMED.

## 2. Delta is nonzero, hence rank mu_K >= 1 (attack item 2, second half)

**What the record writes.** "and nonzero ($\Delta/\lVert W\rVert^6\approx0.5$ at random points)" (line 189). The only support on file for nonvanishing is a sampled value.

**What the sampled value contributes.** Nothing to the argument. It is also not well defined as written: rescaling the apolar inner product by c > 0 rescales every orthonormal basis by c^{-1/2} and Delta by 1/c, so the value 0.5 depends on a normalization the brief never fixes.

**Whether a two-line argument without sampling exists.** One exists, and it uses only facts already in the brief. The record does not contain it, so the verifier does not supply it and records the debt. The statement that would have to be proved: (a) K is nonzero, which follows from dim G_inv = 36, and (b) a sum of squares of real polynomials that vanishes identically as a function on R^35 has every summand zero. From (a) and (b), Delta is a nonzero sextic, so mu_K is nonzero and rank mu_K >= 1.

**Candidate record.**

1. Locate: line 189, "nonzero ($\Delta/\lVert W\rVert^6\approx0.5$ at random points)".
2. Exhibit: the brief's rule reads "a statement supported only by a script, a run or a measurement is HYPOTHESIS-DEBT", and the parenthetical is the only support written for "nonzero". The same bullet states "a sum of squares of cubics of K" but never draws from it the inference to nonvanishing.
3. Opposite reading: the sum-of-squares clause is the argument and the parenthetical is illustration. Even on this reading the step from "sum of squares" to "nonzero" needs K nonzero, and the bullet never states that. The candidate stands, as a debt that is cheap to discharge.

Verdict for claim 2: HYPOTHESIS-DEBT. The conclusion is true, and the word "unconditionally" becomes accurate once (a) and (b) are written.

## 3. "36 - rank is the dimension of the solution set only when the system is consistent" (attack item 3)

The system is mu_K(G) = F_5 with G in G_inv.

- **Linear.** The homogeneous solution set is ker mu_K, of dimension 36 - rank.
- **Affine.** The solution set is empty when F_5 is not in im mu_K. Otherwise it is G* + ker mu_K, an affine subspace of dimension 36 - rank. The bullet is correct for this set.
- **Psd.** The set the route needs is (G* + ker mu_K) intersected with the psd cone of G_inv. Its dimension is at most 36 - rank and can be smaller, or the set can be empty even when the system is consistent. The bullet's "the solution set" is correct only when read as the affine set.
- "consistency is exactly the open necessary condition: F_5 must lie in the image" is the definition of consistency. It is a necessary condition for a psd Gram and is not sufficient.
- **Against L90.** Granting L90, rank mu_K = 13 and im mu_K lies in {F in S^6_inv : F(W_0) = 0}. That set is a hyperplane (dimension 13), because evaluation at W_0 is a nonzero functional on S^6_inv (L90). So im mu_K equals that hyperplane, and consistency is equivalent to the single scalar condition F_5(W_0) = 0. The bullet calls consistency open without recording this reduction. This is a gap in exposition, and it does not make the bullet false. It also uses the unstated hypothesis that F_5 is invariant (inventory row 5).

Verdict for claim 3: CONFIRMED AS ALGEBRA, for the affine solution set in G_inv.

## 4. rank = 14 - dim{F : Cat_F(K,K) = 0} (attack item 4, first half)

**Derivation, with F ranging over S^6_inv.** The record gives the formula with no derivation. The check runs as follows.

1. The apolar pairing is positive definite on sextics, so its restriction to S^6_inv is nondegenerate. Hence rank mu_K = 14 - dim (im mu_K)^perp, where the orthogonal complement is taken inside S^6_inv.
2. For F in S^6_inv, F is in (im mu_K)^perp iff sum_{a,b} G_ab Cat_F(q_a, q_b) = 0 for every G in G_inv.
3. For invariant F, the form Cat_F restricted to K x K is invariant, so it lies in G_inv. The expression in step 2 is the Frobenius pairing tr(G Cat_F|K) between two elements of G_inv. The Frobenius form is positive definite, so its restriction to G_inv is nondegenerate, and step 2 holds iff Cat_F|K = 0.

The formula is correct as algebra when F ranges over S^6_inv.

**A(W_0^6) lies in the space.** Read A(W_0^6) as the apolar representative of evaluation at W_0 restricted to invariants, that is the O(5)-average R(l_{W_0}^6). Then Cat_{R(l_{W_0}^6)}(q, q') is a nonzero constant times the average over g of q(g W_0) q'(g W_0), which is 0. It is nonzero because evaluation at W_0 is nonzero on S^6_inv (L90). So the space has dimension >= 1, and the formula gives rank <= 13, which reproduces L90's cap.

**Candidate A (withdrawn): the formula read over all sextics.**

1. Locate: line 191, "$\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$". The set-builder does not say where F ranges.
2. Exhibit: over all sextics the space contains l_p^6 for every p in the orbit O(5).W_0, because Cat_{l_p^6}(q, q') is a nonzero constant times q(p) q'(p) = 0. W_5 is irreducible under O(5), so the orbit spans W_5, and there are 35 linearly independent orbit points p_1, ..., p_35. Their sixth powers are linearly independent: with (e_j) the dual basis, <l_{p_i}^6, e_j^6> is a nonzero constant times delta_ij. So the space has dimension >= 35, and the formula would give rank <= 14 - 35 < 0, which is absurd.
3. Opposite reading: the passage's "14" is the dimension of S^6_inv, so F is meant to range over it. Under that reading the formula holds (above). **Withdrawn**, because the charitable reading is the natural one. The record should still state the range, since under the other reading the formula is false.

**Candidate B (withdrawn): A(W_0^6) is non-invariant, so it is not in the invariant space.** The literal l_{W_0}^6 is not O(5)-invariant, so it lies in the space only under the all-sextics reading of Candidate A. The opposite reading: "A the apolar map, as the passages use them" (brief) leaves room for A to land in invariants, and its invariant average does lie in the space (above). **Withdrawn** as a notation issue.

Verdict for claim 4: CONFIRMED AS ALGEBRA, with F ranging over the 14 invariant sextics. The record holds no derivation, and the range of F is unstated.

## 5. The dimension count 14 + 29 - 65 < 0 (attack item 4, second half)

**Candidate record.**

1. Locate: line 191, "with a dimension count putting every other intersection at $14+29-65<0$. So $13$ holds unless a second coincidence occurs."
2. Exhibit: (i) The numbers 29 and 65 are defined nowhere in the passage or the brief, and neither is "every other intersection". In Section 4 the space in question is the kernel of a linear map on the 14-dimensional S^6_inv, and no 29-dimensional object in a 65-dimensional ambient appears in it. (ii) An expected-dimension count gives no upper bound on a specific intersection. Two linear subspaces of dimensions 14 and 29 in R^65 always meet in dimension at least max(0, 14 + 29 - 65) = 0, and can meet in any dimension up to 14. Closed-form example: span(e_1, ..., e_14) and span(e_1, e_2, e_15, ..., e_41) in R^65 have dimensions 14 and 29 and meet in span(e_1, e_2), of dimension 2. (iii) "13 holds unless a second coincidence occurs" is equivalent, by Section 4, to "rank = 13 iff the space has dimension 1", which is a restatement of the question.
3. Opposite reading: the bullet opens "Tightness is open", so the count is offered as a heuristic and not as a proof. On this reading the bullet overclaims nothing about rank 13. The candidate still stands for the count itself: as written, it is a number whose terms are undefined and which could not bound the intersection even if they were defined.

Verdict for claim 5: HYPOTHESIS-DEBT. To be proved: the space {F in S^6_inv : Cat_F(K,K) = 0} has dimension exactly 1, or equivalently rank mu_K = 13, by an argument valid for these specific subspaces. Separately, the objects of dimensions 29 and 65 must be defined.

## 6. The Delta remarks (attack item 6)

| Sub-claim (line 193) | Argued? | Status |
|---|---|---|
| Delta is psd, invariant, a sum of squares of cubics of K | yes (Section 1) | confirmed |
| Delta vanishes on the orbit cone (inclusion) | follows from the definitions (Section 1) | confirmed |
| Delta vanishes **exactly** on the orbit cone | no. "appears to" marks it as observed | debt |
| The orbit cone is the zero set F_5 is conjectured to have | labelled a conjecture | recorded as conjecture, no finding |
| F_5 is not proportional to Delta | only through sampled ratios | debt |
| F_5/Delta in [2.50, 3.15], "bounded and positive" | twelve random unit points | debt |
| lambda ~ 2.5 as a recentring | heuristic for a search | carries no mathematical claim, no finding |

**Candidate record.**

1. Locate: line 193, "appears to vanish exactly on the orbit cone" and "$F_5/\Delta$ ranges over $[2.50,3.15]$ across twelve random unit points, staying bounded and positive".
2. Exhibit: the zero set of Delta is exactly the common real zero set of K, and nothing on file shows that this set is the orbit cone. Twelve points bound nothing on the unit sphere. Near the orbit cone both Delta and (conjecturally) F_5 vanish, so boundedness of F_5/Delta there is a comparison of vanishing orders, and no argument for it is on file. The falsifying objects are: a unit W off the orbit cone with q(W) = 0 for every q in K (against "exactly"), and a sequence of unit points tending to the orbit along which F_5/Delta is unbounded, or a unit point with F_5/Delta <= 0 (against "bounded and positive"). Under the no-computation rule the verifier searched for none of them by sampling. No closed-form one is available from the brief, which does not define F_5.
3. Opposite reading: the paragraph is headed "a live lead for the search" and hedges with "appears", so it presents observations and not claims. Accepted as a description of intent, but the loop's rule classifies every measured statement as debt.

Verdict for claim 6: HYPOTHESIS-DEBT, for exact vanishing, non-proportionality, and the range, boundedness and positivity of the ratio.

## 7. Casimir equalities (attack item 7, arithmetic)

With c(l1, l2) = l1(l1 + 3) + l2(l2 + 1):

- c(5, 4) = 40 + 20 = 60 and c(6, 2) = 54 + 6 = 60.
- c(5, 0) = 40 + 0 = 40 and c(4, 3) = 28 + 12 = 40.
- c(4, 1) = 28 + 2 = 30 and c(3, 3) = 18 + 12 = 30.
- The second labels 1 and 3 are odd.

All six labels satisfy l1 >= l2, as the partition basis requires. **Convention check:** in Dynkin labels (a, b) with l = (a + b/2, b/2), (5, 4) becomes (7, 2) with c = 76 and (6, 2) becomes (7, 1) with c = 72, so no collision. The equalities therefore hold in the partition basis and fail in the Dynkin basis. The record does not name its basis, and the partition basis is the one in which the stated collisions hold.

Verdict for claim 7: CONFIRMED AS ALGEBRA, in the partition basis.

## 8. "Two of the three Casimir collisions vanish with them" (attack item 7, content)

**Candidate record.**

1. Locate: line 195, "Two of the three Casimir collisions vanish with them. At $c=60$ both $(5,4)$ and $(6,2)$ die; at $c=40$ the block $(5,0)$ dies and leaves $(4,3)$ alone. Only $c=30$ survives".
2. Exhibit: (i) "with them" has no antecedent inside the quoted passage. (ii) The set of blocks in play is not given, so "three" cannot be checked. The same Casimir has further collisions in the partition basis: c(7, 0) = 70 = c(5, 5) and c(8, 1) = 90 = c(7, 4). Whether these count depends on which blocks occur, and the record states none of that. (iii) No criterion for a block to "die" is written, and no argument is on file that (5, 4), (6, 2) and (5, 0) die while (4, 1), (3, 3) and (4, 3) survive. The falsifying object would be one of the three "dead" blocks occurring in the relevant space (presumably K or its Grams), or a fourth collision among the blocks that do occur. Neither can be examined without the block list.
3. Opposite reading: the paragraph reports the output of a decomposition defined elsewhere in the file, and "with them" refers to blocks removed by passing to K. Even so, the decomposition and the death criterion are not on file in the brief, and the loop's rule leaves them as debt.

Verdict for claim 8: HYPOTHESIS-DEBT. To be proved: the list of SO(5) blocks in the relevant space, the criterion for a block to die, and that it removes exactly the named blocks.

## 9. Scope against Lemma L90 (attack items 5 and 8)

- **Bullet 1.** It gives rank mu_K >= 1 unconditionally, which is consistent with L90's cap (rank <= 13) and with its conditional value 13. It says nothing about rank(ev o mu_K), the quantity L90's measurement concerns. It would give rank(ev o mu_K) >= 1 only if Delta were nonzero somewhere on S, and the record claims nothing about S.
- **Bullet 2.** It is correct linear algebra. It omits that under L90, consistency reduces to F_5(W_0) = 0 (Section 3).
- **Bullet 3.** It is the dual form of L90's cap: the invariant representative of evaluation at W_0 gives dimension >= 1, which is rank <= 13. "Tightness is open" agrees with L90, where rank 13 rests on the measured rank and three unstated hypotheses. It adds no independent route to 13, because the count in Section 5 proves nothing.
- **Remarks.** The Delta and Casimir paragraphs are observations for a search, and the lemma is not built on them.
- No use of L90 in the passage misstates L90.

The lemma adds to L90 exactly one unconditional fact, rank mu_K >= 1, and that fact becomes a proof once the debt in Section 2 is written.

Verdict for claim 9: CONFIRMED (consistent with L90, and adds only the lower bound 1).

## 10. Standing items

### 10.1 Hypothesis inventory

See the inventory table above. The hypotheses used but unstated are: invariance of the apolar inner product, K nonzero, F_5 invariant, F ranging over S^6_inv, and the definitions behind 29, 65 and the Casimir block list.

### 10.2 Quantifier order and scope

- "rank" is the rank of mu_K : G_inv (dimension 36, all invariant symmetric Grams, psd or not) -> S^6_inv (dimension 14), over R. The rank is unchanged over any extension field.
- The solution-set dimension in bullet 2 is that of the affine set in G_inv, which differs from the psd set.
- The catalecticant space in bullet 3 must be taken inside S^6_inv. Over all sextics the formula fails (Section 4, Candidate A).

### 10.3 Edges

| Edge | Status |
|---|---|
| K = 0 | excluded, since dim G_inv = 36 > 0 |
| rank 0 | excluded by Delta nonzero (Section 2, once the debt is written) |
| rank 13 | L90, conditional. Equivalent to the catalecticant space having dimension 1 |
| rank 14 | excluded by L90's cap, and dually by the nonzero invariant representative of evaluation at W_0 lying in the catalecticant space |
| 36 - rank at rank 13 | the affine solution set, when consistent, has dimension 23 |
| Orbit cone | Delta vanishes there (confirmed). F_5/Delta is undefined there, including at W = 0, and the "unit points" presumably avoid it. Boundedness near it is unargued (Section 6) |

### 10.4 Proven against stated

| Proven | Stated |
|---|---|
| rank mu_K >= 1, modulo writing K nonzero and the sum-of-squares step | "the unconditional lower bound 1", with the quantity unnamed |
| The affine solution-set dimension | "the solution set" |
| The rank formula over S^6_inv | the formula with the range of F unstated |
| Nothing about tightness | "reduced to one question", with a count that proves nothing |
| Delta vanishes on the orbit cone | "exactly on the orbit cone" |
| The Casimir equalities in the partition basis | the equalities, which blocks die, and that c = 30 survives |

### 10.5 Falsifying objects, and what was done to look for them

| Claim | Falsifying object | What was done |
|---|---|---|
| 1 | an orthogonal g not preserving the apolar orthonormality of K | none can exist, given K stable and the pairing invariant (Section 1) |
| 2 | K with Delta the zero polynomial | impossible for nonzero K (Section 2) |
| 3 | a consistent system whose affine solution set has dimension other than 36 - rank | impossible by rank-nullity |
| 4 | a nonzero invariant F with Cat_F\|K = 0 lying in im mu_K, or orthogonal to it without Cat_F\|K = 0 | excluded by the two nondegeneracy steps. The all-sextics reading is falsified in closed form (Candidate A) |
| 5 | two subspaces of dimensions 14 and 29 in R^65 meeting in dimension >= 2 | exhibited in closed form: span(e_1..e_14) and span(e_1, e_2, e_15..e_41) |
| 6 | a unit point off the orbit cone where all of K vanishes, or unbounded or nonpositive F_5/Delta | no closed form available from the brief. Sampling is forbidden. Left as debt |
| 7 | a label pair whose Casimirs differ | all three pairs computed exactly and equal. The Dynkin basis breaks them |
| 8 | a "dead" block that occurs, or a fourth collision among occurring blocks | extra collisions (7,0)/(5,5) at 70 and (8,1)/(7,4) at 90 exhibited. Whether they occur cannot be checked from the brief |

## Overall verdict

**HYPOTHESIS-DEBT.**

- The lemma's headline, rank mu_K >= 1 unconditionally, is true. Its nonvanishing link is on file only as a sampled value, and the two-line argument that would discharge it (K nonzero, and a nonzero sum of real squares is a nonzero polynomial) is not written.
- The consistency remark is correct for the affine solution set, and the rank formula is correct over the invariant sextics.
- The tightness count, the Delta remarks and the block deaths are unargued.
- Nothing in the lemma is refuted as stated under the charitable readings, and nothing misuses L90.
