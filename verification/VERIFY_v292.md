# Verifier v292, Lemma L84: the pair (C_2, C_4) separates the 24 blocks, the forcing argument, the c_2 and p_4 numbers, the C_2^2 sentence, and the Lean statement

The brief was cold. No numerical work was done: no scripts were written or run, nothing was compiled, and every value below is exact and obtained by hand from a stated label. Log: [agent_logs/verify-L84-v292.log](../agent_logs/verify-L84-v292.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Heading: "the PAIR $(C_2,C_4)$ separates all $24$", with $C_4$ any central element of degree $4$ (the brief's definition) | REFUTED AS STATED |
| 1' | The same heading with $C_4$ a quartic generator of $Z(U(\mathfrak{so}(5)))$ together with $C_2$ (the body's "the quartic generator") | CONFIRMED |
| 2 | Forcing: $\ell_1>\ell_2>0$ for dominant $\lambda$, $(p_2,p_4)(\ell)$ recovers $\lambda$, $Z\cong\mathbb C[p^2+q^2,p^2q^2]$ | CONFIRMED |
| 3 | "The quartic generator" separates the three pairs, and every choice of second generator does | CONFIRMED |
| 4 | $c_2$ takes $21$ values on Passage B's $24$ labels, collisions exactly $30$, $40$, $60$ as named | CONFIRMED AS ALGEBRA |
| 5 | The six $p_4$ values in the printed order | CONFIRMED AS ALGEBRA |
| 6 | "Reviewer 178; the $22$ this file carried came from a run made before $\rho$ was corrected" | HYPOTHESIS-DEBT |
| 7 | "$C_2^2$ is a legal degree-four central element and separates nothing" | CONFIRMED (read within its paragraph, as separating none of the three pairs) |
| 8 | Lean: casimir_pair_separates and companions | CONFIRMED AS ALGEBRA (states the injectivity of $\lambda\mapsto(p_2,p_4)(\lambda+\rho)$, and states nothing about $U(\mathfrak{so}(5))$) |

**Summary: the mathematics of L84 is correct, but its heading names $C_4$ without the generator hypothesis the body relies on, and the provenance sentence has nothing on file.**

## 0. Conventions, fixed once

- $\mathfrak g=\mathfrak{so}(5)$, type $B_2$, $\mathfrak h$ with orthonormal coordinates $e_1,e_2$. Positive roots $e_1\pm e_2$, $e_1$, $e_2$, so $2\rho=3e_1+e_2$ and $\rho=(3/2,1/2)$, $|\rho|^2=5/2$.
- Dominant integral weight $\lambda=(\lambda_1,\lambda_2)$, $\lambda_1\ge\lambda_2\ge0$ integers. $\ell=\lambda+\rho$. $p_{2k}(\ell)=\ell_1^{2k}+\ell_2^{2k}$, $e_1=\ell_1^2+\ell_2^2$, $e_2=\ell_1^2\ell_2^2$.
- $c_2(\lambda)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$. In sixteenths, $p_2(\ell)=((2\lambda_1+3)^2+(2\lambda_2+1)^2)/4$ and $p_4(\ell)=((2\lambda_1+3)^4+(2\lambda_2+1)^4)/16$.
- $\chi_\lambda(z)$ is the scalar by which $z\in Z(U(\mathfrak g))$ acts on $V_\lambda$. $\gamma$ is the $\rho$-shifted Harish-Chandra map, with $\chi_\lambda(z)=\gamma(z)(\lambda+\rho)$.
- "Separates" a set $S$ of labels: the map $\lambda\mapsto(\chi_\lambda(C_2),\chi_\lambda(C_4))$ is injective on $S$.
- Quotations were checked at source: [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 23-36, 38 and 54-60 agree verbatim with Passages A and B. The Lean table was read at [L83.lean](../lean/HamiltonsCubic/Results/L83.lean) lines 19-50 only.

## 1. Hypothesis inventory

Statement (heading, line 38):

- H1. $C_2$ is the degree-two Casimir, eigenvalue $c_2(\lambda)$. Stated (line 56 and the brief).
- H2. $C_4$ is a central element of degree $4$. The heading gives only the symbol, the brief defines it as any degree-four central element.
- H3. The $24$ labels are dominant integral $B_2$ weights. Stated by Passage B's table.

Imported results:

- I1. Harish-Chandra: $\gamma:Z(U(\mathfrak g))\to S(\mathfrak h)^W$ is an algebra isomorphism, $\chi_\lambda(z)=\gamma(z)(\lambda+\rho)$, and $\deg\gamma(z)\le$ the filtration degree of $z$. Classical and unfiled. The argument needs all three parts: the $\rho$-shift for "$\ell_i=\lambda_i+\rho_i$", the degree bound for "leading terms", and the isomorphism for "$Z(U(\mathfrak{so}(5)))$ is the ring of $W(B_2)$-invariants".
- I2. Chevalley for $W(B_2)$ (signed permutations, order $8$): $\mathbb C[x,y]^W=\mathbb C[x^2+y^2,x^2y^2]$. Classical and unfiled, stated on line 58 with $p,q$ undefined, read as the coordinates of $\ell$.
- I3. "The higher Casimirs have Harish-Chandra images whose leading terms are the power sums $p_{2k}(\ell)$". Unfiled, and "the higher Casimirs" are not defined in the passage.
- I4. Passage B's table (labels and multiplicities from a character computation by a script). Given for this round. L84's separation uses the labels only.

Used but unstated in the heading:

- U1. **$C_4$ generates $Z(U(\mathfrak g))$ together with $C_2$**, equivalently $\gamma(C_4)=\alpha p_4+\beta p_2^2+\gamma_1p_2+\delta$ with $\alpha\ne0$. The body supplies it ("the quartic generator", "the generator is what separates, not the degree"). The heading does not. See section 2.
- U2. $\gamma(C_2)=p_2-5/2$, which is the identity $p_2(\ell)=c_2(\lambda)+5/2$ (section 3, and Lean p2_eq_c2_add). Implicit in "$e_1=p_2$".

## 2. Claim 1, the heading

Line 38: "#### Lemma L84, Casimir separation is forced, not measured, the PAIR $(C_2,C_4)$ separates all $24$".

### Candidate 1.A, the heading is false for a legal $C_4$

1. Locate. Line 38, the phrase "the PAIR $(C_2,C_4)$ separates all $24$", with the brief's definition "$C_2,C_4$ are central elements of $U(\mathfrak{so}(5))$ of degrees $2$ and $4$".
2. Exhibit. Take $C_4:=C_2^2$, which line 60 itself calls "a legal degree-four central element". $\chi_\lambda(C_2^2)=c_2(\lambda)^2$. At $(4,1)$ and $(3,3)$: $c_2=4\cdot7+1\cdot2=30$ and $3\cdot6+3\cdot4=30$, so the pair reads $(30,900)$ at both labels, and both labels are in Passage B. The pair does not separate the $24$.
3. Charitable reading. The body (line 58) says "the quartic generator separates them", and line 60 says "the generator is what separates, not the degree". Read as one block, $C_4$ denotes a quartic generator. Under that reading the claim is true (claim 1', section 3). The candidate therefore survives as a statement defect only: the heading, which is what a citation of L84 quotes, carries the symbol $C_4$ without the hypothesis U1. It is a hypothesis to be written into the heading, and no mathematics is wrong.

Verdict: REFUTED AS STATED for claim 1, CONFIRMED for claim 1'.

"Forced, not measured": the separation of the $24$ follows from an injectivity statement over all dominant weights (section 3), which uses no value from the table. The phrase is supported. The count $21$ and the three collisions are arithmetic on the table's labels (section 4).

## 3. Claims 1' and 2, the forcing argument, and claim 3

Line 58, read link by link.

**Link a, "Harish-Chandra images whose leading terms are the power sums $p_{2k}(\ell)$".** With I1, $\chi_\lambda(C_4)=F(\ell)$ where $F\in S(\mathfrak h)^W$ has degree at most $4$. By I2 the $W$-invariants of degree at most $4$ are spanned by $1,p_2,p_2^2,p_4$ (odd degrees vanish since $-1\in W$, degree $2$ is $\mathbb C p_2$, degree $4$ is spanned by $p_2^2$ and $x^2y^2$, equivalently $p_2^2$ and $p_4$). So $F=\alpha p_4+\beta p_2^2+\gamma_1p_2+\delta$. "Leading term $p_4$" gives $\alpha\ne0$.

*Whether the leading term alone determines the eigenvalue.* It does not: $\beta,\gamma_1,\delta$ are free. The text proceeds from "leading term $p_4$" directly to using $p_4$. The missing sentence, that the lower terms are functions of $p_2$ alone, is on the page as the next sentence's "$Z(U(\mathfrak{so}(5)))$ is the ring of $W(B_2)$-invariants, generated by $p^2+q^2$ and $p^2q^2$": the invariants below degree $4$ are $\mathbb C[p_2]$. It is presented as "Equivalently" rather than as the link, which is an ordering weakness in the prose. No finding: the content is present.

**Link b, U2.** $p_2(\ell)=((2\lambda_1+3)^2+(2\lambda_2+1)^2)/4=\lambda_1^2+3\lambda_1+\lambda_2^2+\lambda_2+10/4=c_2(\lambda)+5/2$. So $\chi_\lambda(C_2)$ determines $p_2(\ell)$, and given $p_2(\ell)$ and $\alpha\ne0$, $\chi_\lambda(C_4)$ determines $p_4(\ell)=(F(\ell)-\beta p_2^2-\gamma_1p_2-\delta)/\alpha$.

**Link c, "$\ell_1>\ell_2>0$ for a dominant $B_2$ weight".** $\ell_2=\lambda_2+1/2\ge1/2>0$ and $\ell_1-\ell_2=\lambda_1-\lambda_2+1\ge1>0$. Correct, and strict on every wall.

**Link d, recovery.** $e_1=p_2$ by definition, and $p_2^2=p_4+2\ell_1^2\ell_2^2$ gives $e_2=(p_2^2-p_4)/2$. $\{\ell_1^2,\ell_2^2\}$ is the root multiset of $t^2-e_1t+e_2$. Link c gives $\ell_1^2>\ell_2^2>0$, so the larger root is $\ell_1^2$, positive square roots give $\ell$, and $\lambda=\ell-\rho$. Correct.

**Link e, "generated by $p^2+q^2$ and $p^2q^2$".** I2, with $\mathbb C[p_2,e_2]=\mathbb C[p_2,p_4]$ since $p_4=p_2^2-2e_2$. Correct as a statement about $W(B_2)$. Its use as "$Z(U(\mathfrak{so}(5)))$ is" that ring needs I1's isomorphism.

Conclusion of claims 1' and 2: if $\chi_\lambda(C_2)=\chi_{\lambda'}(C_2)$ and $\chi_\lambda(C_4)=\chi_{\lambda'}(C_4)$ for dominant $\lambda,\lambda'$, then $p_2,p_4$ agree at $\ell,\ell'$, hence $\lambda=\lambda'$. This holds on all dominant integral weights, so on any $24$ of them.

**Claim 3, "the quartic generator".** No element is distinguished: $C_4+C_2^2$ and $C_4+C_2$ are also degree-four elements with $\alpha\ne0$. Every $z$ with $Z=\mathbb C[C_2,z]$ has $\alpha\ne0$ (if $\alpha=0$ then $\gamma(z)\in\mathbb C[p_2]$ and $\gamma(\mathbb C[C_2,z])\subseteq\mathbb C[p_2]\ne S(\mathfrak h)^W$), and every $z$ with $\alpha\ne0$ separates by link b. So the definite article is loose and harmless: the separation holds for every choice. "The quartic generator separates them" (the three pairs) holds for the generator alone too, since on a pair with equal $p_2$ the value of $F$ differs exactly when $p_4$ does. It does not hold for a generator alone on all $24$, which the record does not claim.

## 4. Claims 4 and 5, the numbers

$c_2$ by hand on all $24$ of Passage B's labels:

| label | $c_2$ | label | $c_2$ | label | $c_2$ |
|---|---|---|---|---|---|
| $(4,2)$ | $34$ | $(3,0)$ | $18$ | $(5,4)$ | $60$ |
| $(2,2)$ | $16$ | $(2,0)$ | $10$ | $(5,3)$ | $52$ |
| $(3,2)$ | $24$ | $(6,6)$ | $96$ | $(5,1)$ | $42$ |
| $(5,2)$ | $46$ | $(6,4)$ | $74$ | $(5,0)$ | $40$ |
| $(4,3)$ | $40$ | $(6,3)$ | $66$ | $(3,3)$ | $30$ |
| $(4,4)$ | $48$ | $(6,2)$ | $60$ | $(1,0)$ | $4$ |
| $(4,1)$ | $30$ | $(6,0)$ | $54$ | $(0,0)$ | $0$ |
| $(3,1)$ | $20$ | $(4,0)$ | $28$ | | |
| $(2,1)$ | $12$ | | | | |

Sorted: $0,4,10,12,16,18,20,24,28,30,30,34,40,40,42,46,48,52,54,60,60,66,74,96$. The $24$ labels are pairwise distinct, the values take $21$ distinct numbers, and the repeated values are exactly $30$ at $(4,1),(3,3)$, $40$ at $(4,3),(5,0)$ and $60$ at $(6,2),(5,4)$. Claim 4 CONFIRMED AS ALGEBRA on the printed labels.

$p_4$ in sixteenths, $16p_4=(2\lambda_1+3)^4+(2\lambda_2+1)^4$:

| label | $16p_4$ | $p_4$ | printed |
|---|---|---|---|
| $(4,1)$ | $11^4+3^4=14641+81=14722$ | $7361/8$ | $7361/8$ |
| $(3,3)$ | $9^4+7^4=6561+2401=8962$ | $4481/8$ | $4481/8$ |
| $(4,3)$ | $14641+2401=17042$ | $8521/8$ | $8521/8$ |
| $(5,0)$ | $13^4+1=28562$ | $14281/8$ | $14281/8$ |
| $(5,4)$ | $28561+6561=35122$ | $17561/8$ | $17561/8$ |
| $(6,2)$ | $15^4+5^4=50625+625=51250$ | $25625/8$ | $25625/8$ |

Printed order is "first label of the named pair, then second", matching line 56's order. Cross-check at $(4,1)$ by link d: $p_2=65/2$, $e_2=(121/4)(9/4)=1089/16$, $p_2^2-2e_2=16900/16-2178/16=14722/16$. Claim 5 CONFIRMED AS ALGEBRA.

## 5. Claim 6, the Reviewer 178 provenance

Line 56: "*Reviewer 178; the $22$ this file carried came from a run made before $\rho$ was corrected to $(3/2,1/2)$.*"

The passages give the current formula $c_2=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$, which is $|\ell|^2-|\rho|^2$ for $\rho=(3/2,1/2)$ (U2), and that $\rho$ is correct for $B_2$ (section 0). Nothing on file in the brief records the earlier run, the earlier $\rho$, or that it produced $22$. The attribution is a historical claim with no argument on file. HYPOTHESIS-DEBT: what would have to be shown is the earlier formula and that it yields $22$ distinct values on these labels. It bears on no mathematical claim of L84, since $21$ is established directly in section 4.

## 6. Claim 7, "$C_2^2$ is a legal degree-four central element and separates nothing"

$C_2^2\in Z(U(\mathfrak g))$ has filtration degree at most $4$ and acts on $V_\lambda$ by $c_2(\lambda)^2$. On each of the three pairs $c_2$ agrees, so $c_2^2$ agrees: adjoining $C_2^2$ to $C_2$ separates none of them. Also $\gamma(C_2^2)=(p_2-5/2)^2$ has $\alpha=0$, consistent with section 3. CONFIRMED in the reading below.

### Withdrawn candidate 7.A, "separates nothing" is false

1. Locate. Line 60, "separates nothing".
2. Exhibit. Alone, $C_2^2$ separates $(0,0)$ from $(1,0)$: $0$ against $16$. Since $c_2\ge0$ on dominant weights and squaring is injective on non-negative rationals, $C_2^2$ has exactly $C_2$'s fibres and separates $21$ classes of the $24$.
3. Charitable reading. Line 58's "separates them" has "them" = the three colliding pairs, and line 60 answers it in parallel: $C_2^2$ separates none of them. Read in its paragraph the sentence is true. **Withdrawn at step 3.** A rewording to "separates none of the three pairs" would remove the ambiguity.

## 7. Claim 8, the Lean statement

[L84Statement.lean](../lean/HamiltonsCubic/Results/L84Statement.lean), lines 53-188, docstrings disregarded.

- **rho_strictly_dominant** (77): $b\le a\Rightarrow 0<b+1/2<a+3/2$ over $\mathbb N$. Link c.
- **p2_eq_c2_add** (85): U2, by ring.
- **pair_separates** (99): positive strictly ordered $(l_1,l_2),(m_1,m_2)$ with equal $p_2,p_4$ are equal. Link d.
- **casimir_pair_separates** (115): for $b\le a$, $b'\le a'$ in $\mathbb N$, equal $p_2$ and $p_4$ at the shifted weights give $(a,b)=(a',b')$. This is the injectivity of $\lambda\mapsto(p_2,p_4)(\lambda+\rho)$ on dominant integral weights. **It does not state the lemma**: no $U(\mathfrak{so}(5))$, no centre, no $C_4$, no Harish-Chandra map appears, so links a, b and e (the passage from Casimir eigenvalues to $p_2,p_4$) are outside Lean. Its name is a label.
- **quartic_shift_still_separates** (131): $p_4+\alpha p_2^2+\beta p_2+\gamma$ with equal $p_2$ separates, for every rational $\alpha,\beta,\gamma$. This is claim 3 with the $p_4$ coefficient normalised to $1$, which covers every nonzero coefficient after scaling.
- **alpha_half_collides** (142): a single generator $p_4-p_2^2/2=(\ell_1^2-\ell_2^2)^2/2$ collides at $(2,2)$ and $(1,0)$, value $18$ at both. By hand: $(49-25)/4=6$ and $(25-1)/4=6$, $36/2=18$. Not part of L84's claim.
- **sq_same_fibres**, **c2Q_nonneg** (149, 159): candidate 7.A step 2.
- **c2_distinct_21** (168), by decide on the imported table. **three_collisions** (172) evaluates $c_2$ at six Block literals. It does not assert their membership in table and does not itself state "no others". Membership holds by reading ([L83.lean](../lean/HamiltonsCubic/Results/L83.lean) lines 35-43 hold $\langle4,1,2\rangle$, $\langle3,3,1\rangle$, $\langle4,3,2\rangle$, $\langle5,0,1\rangle$, $\langle5,4,1\rangle$, $\langle6,2,1\rangle$), and "no others" follows from $24-21=3$ together with the three listed pairs having distinct values.
- **p4_splits_the_collisions**, **p4_collision_values** (178, 183): claim 5.

Imports: the file opens HamiltonsCubic.Blocks and uses Block and table. The import lines sit in the withheld lines 1-52 and were not read. Among files declaring that namespace, table and Block are defined in [L83.lean](../lean/HamiltonsCubic/Results/L83.lean) lines 22 and 35, whose $24$ entries match Passage B's labels and multiplicities exactly. No sorry or axiom appears in lines 53-188. The file was not compiled in this round.

Verdict: CONFIRMED AS ALGEBRA. Lean proves the elementary core and the numbers, and states the Casimir-level lemma nowhere.

## 8. The standing items

**Item 2, quantifier order and scope.** The separation is over all dominant integral weights (so over the $24$ labels and every other), by the pair $(C_2,C_4)$ with $C_4$ any element satisfying U1. $SO(5)$ against $O(5)$: $Z(U(\mathfrak{so}(5)))$ sees only $\mathfrak{so}(5)$ labels. An $O(5)$ irreducible $V_\lambda\otimes\det$ has the same Casimir scalars as $V_\lambda$, so no central element of $U(\mathfrak{so}(5))$ separates an $O(5)$ label from its $\det$-twist. Passage B labels blocks by $B_2$ weights only, so L84 as written is an $SO(5)$ statement and is correct as such. Whether both twists of a label could occur in the space of Passage B depends on $\mathcal W_5$, which the brief does not define. No finding. The argument also extends verbatim to half-integral (spin) weights ($\ell_2\ge1$), which the brief's integer definition excludes and Lean's $\mathbb N$ excludes.

**Item 3, edges.** $\lambda=0$: $\ell=(3/2,1/2)$, strict. Walls $\lambda_1=\lambda_2$ (labels $(6,6),(4,4),(3,3),(2,2),(0,0)$): $\ell_1-\ell_2=1$. Wall $\lambda_2=0$ (labels $(6,0),(5,0),(4,0),(3,0),(2,0),(1,0),(0,0)$): $\ell_2=1/2$. The recovery is unaffected at every edge. The three colliding pairs have equal $p_2$ ($65/2$, $85/2$, $125/2$) and unequal $p_4$ (section 4). No finding.

**Item 4, proven against stated.** Proven: with I1, I2, I3 and U1, the pair separates all dominant integral weights. Stated in the heading: the same without U1. The gap is U1 (section 2). The numbers are proven on the printed labels, the truth of the table being I4's debt and not L84's.

**Item 5, Lean.** Section 7: proves the $p_2,p_4$ injectivity and the numbers, and does not state the Casimir lemma.

**Item 7, falsifiers and the search.**

- Claim 1: a legal $C_4$ with a collision. Found: $C_4=C_2^2$ at $(4,1),(3,3)$. Resolved by U1.
- Claims 1', 2: dominant $\lambda\ne\lambda'$ with equal $(p_2,p_4)(\ell)$. Excluded by links c and d, checked at every edge.
- Claim 3: a quartic generator with $\alpha=0$, or one with $\alpha\ne0$ that fails. Both excluded in section 3.
- Claim 4: a label pair with equal $c_2$ outside the three, or a named pair unequal. All $24$ values evaluated.
- Claim 5: a printed $p_4$ that differs. All six evaluated in sixteenths and one cross-checked.
- Claim 6: a record of the earlier run. None on file in the brief.
- Claim 7: a colliding pair with different $c_2^2$. Impossible.
- Claim 8: a Lean hypothesis absent from the lemma, or a missing Casimir link. The link is missing, as recorded.

## 9. The brief's "What to attack"

1. The statement: section 2. The heading's $C_4$ lacks U1, which the body's "the quartic generator" supplies. "Forced, not measured" is supported.
2. The forcing argument: section 3. The leading term alone does not fix the eigenvalue. The lower terms lie in $\mathbb C[p_2]$ by I2, stated on line 58. $\ell_1>\ell_2>0$ holds, the recovery holds, and the ring statement is correct with I1.
3. "The quartic generator": no distinguished element exists, and every second generator separates (section 3).
4. The numbers: section 4, confirmed.
5. Reviewer 178: section 5, HYPOTHESIS-DEBT, with no bearing on the mathematics.
6. $C_2^2$: section 6, confirmed in context, literal reading withdrawn at step 3.
7. Scope: section 8 item 2. The separation claim is independent of the table's correctness. The count $21$ depends on the table's labels.
8. Passage C: section 7. It proves the elementary core and imports table and Block from L83.lean.

## Overall verdict

**PROVEN (hypotheses corrected).** The correction: the heading must say that $C_4$ generates $Z(U(\mathfrak{so}(5)))$ together with $C_2$ (equivalently, $\gamma(C_4)$ has nonzero $p_4$ coefficient modulo $\mathbb C[p_2]$), as the body already assumes. The Harish-Chandra and Chevalley theorems are classical and unfiled. The provenance sentence of line 56 is HYPOTHESIS-DEBT.
