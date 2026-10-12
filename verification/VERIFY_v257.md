# Verifier v257, Lemma L58: the Casimir two-eigenvalue step, the four witness rows, the canonical statements against the block, the threshold sentence and the consequence for L23 and L69

The brief ([BRIEF_L58.md](BRIEF_L58.md)) was read cold. No numerical work was done: every value below is exact, no script was written or run, and the Lean file was read, not built. Log: [agent_logs/verify-L58-v257.log](../agent_logs/verify-L58-v257.log).

| # | claim | verdict |
|---|---|---|
| 1 | Casimir step: $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ has exactly two eigenvalues for $0<r<N$, so three distinct eigenvalues exclude the family (A, B, C, D) | CONFIRMED (needs $c\ne0$, unstated but forced by unit norm, and nothing about $\mathfrak h$) |
| 2 | $\mathbb{CP}^3$ row: critical at $\theta_0(6)$, graded in all three senses, $\ker W=0$, three eigenvalues at multiplicities $6,8,1$ (A, B, C, D) | HYPOTHESIS-DEBT |
| 3 | $S^5\times S^7$ row: pair-graded, critical at $\theta=1.2282390$, eigenvalues $-\tfrac74,-\tfrac56,1$ at $10,21,35$ (A, B, C, D) | HYPOTHESIS-DEBT (pair-graded CONFIRMED from the definition, spectrum and $\theta$ carry no argument in the lemma) |
| 4 | $W_{\mathbb{CP}^2}$ row at $n=4$: graded, critical at $\sqrt{3/2}$, not a Casimir (A, B) | HYPOTHESIS-DEBT (graded holds in (C) and (B) only, by the record's own table) |
| 5 | Withdrawn $(\mathfrak{su}(3),\mathfrak{so}(3))$ row: $S=0$ with a $7$-dimensional kernel does not establish gradedness (A) | CONFIRMED |
| 6 | Canon C and D list $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $n=6$ as graded and outside the family | REFUTED AS STATED in sense (A), HYPOTHESIS-DEBT in (B) and (C) |
| 7 | Passage D: "whose family value there is $1.2742878$" at $r=31$, $n=12$ | REFUTED AS STATED (no family member exists at $(n,r)=(12,31)$), the formula value CONFIRMED AS ALGEBRA |
| 8 | "Since $S^5\times S^7$ sits above $\thstar$", and "no threshold repairs it" (A, B) | GAP |
| 9 | Consequence: L23's cap is about the family, "the graded case needs Lemma L69's classification instead" (D) | GAP (first half CONFIRMED, second half overstates L69's scope) |
| 10 | Headline: the graded set is not contained in the subalgebra family (A, B, C, D) | HYPOTHESIS-DEBT |
| 11 | [L58.lean](../lean/HamiltonsCubic/Results/L58.lean) checks what its docstring claims | CONFIRMED AS ALGEBRA (arithmetic on the block's numbers only, the docstring overclaims) |

**Summary:** the Casimir mechanism is correct and needs less than stated, but every witness's criticality, $\theta$ and spectrum is asserted without an argument in the lemma, the canon still carries the witness the block withdrew, and Passage D quotes a "family value" at a dimension where L23 proves the family is empty.

**Overall verdict: HYPOTHESIS-DEBT.**

## 0. Conventions, fixed once

- $n$ the dimension, $N=\binom n2=\tfrac{n(n-1)}2$, $\mathfrak h\subseteq\mathfrak{so}(n)=\Lambda^2\mathbb R^n$ of dimension $r$, $\mathfrak m=\mathfrak h^\perp$ of dimension $N-r$.
- A critical point is a unit $W\in\mathcal W_n$ with $Q(W)=\theta W$ ([conventions.md](../findings/conventions.md) line 151). $\theta=P(W)/\lVert W\rVert^3$ (line 17).
- The family is L23's: $W_{\mathfrak h}$ the unit-norm multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$, $\mathfrak h$ a subalgebra, $0<r<N$, critical.
- $\theta_0(n)$ is L23's equality value. From Passage E at $r=n(n-2)/4$: $N-r=n^2/4$, $rN/(N-r)=(n-1)(n-2)/2$, so $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$. Thus $\theta_0(4)^2=\tfrac34$, $\theta_0(6)^2=\tfrac{10}9$, $\theta_0(12)^2=\tfrac{55}{36}$.
- The three senses of graded, as defined in [graded-half.md](../findings/graded-half.md) lines 317-321: (C) pair-graded, $W$ is the $\mathrm{ad}(\mathfrak p)$-invariant Weyl tensor of a symmetric pair; (A) sign-graded, $\mathfrak p=E_+(W)$, $\mathfrak m=E_-(W)$ span $\mathfrak{so}(n)$ (so $\ker W=0$) and satisfy the $\mathbb Z_2$ bracket relations; (B) slice-graded, $W$ commutes with $\Lambda^2(\sigma)$ for some involution $\sigma$.
- $\theta^*$: the macro \thstar is defined in [report.tex](../report/report.tex) line 69 as $\theta^{*}$, and [conventions.md](../findings/conventions.md) line 64 sets $\theta^*=P(u)=\sqrt{3/2}$ for $u$ the unit $W_{\mathbb{CP}^2}$.
- Every quotation in the brief was checked against its cited source lines and matches verbatim.

## Hypothesis inventory

| source | hypothesis | used by the argument? |
|---|---|---|
| L58 statement (A, B, D) | $0<r<N$ | stated, used only for "exactly two", which the exclusion does not need (section 1) |
| L58 statement | $c\ne0$ | **used but unstated** for "exactly two". Forced by unit norm: $\lVert\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\rVert^2=\tfrac{r(N-r)}N>0$ |
| L58 statement | $\mathfrak h$ a subalgebra | unused by the mechanism, which holds for any subspace |
| L58 statement | "graded", sense unnamed in A's first sentence and in C and D | **used without a sense**, although Passage F says a claim in one sense does not transfer |
| L58 witnesses | each witness is a critical point at the stated $\theta$ | **used, no argument or citation in Passages A, B, C, D** |
| L58 witnesses | each witness's spectrum (values and multiplicities) | **used, no derivation on file**. Only $S^5\times S^7$ carries values |
| L58 witnesses | the sign of $W$ at the critical point | **used implicitly** by the (A) claim at $\mathbb{CP}^3$, fixed nowhere in the passages (section 2) |
| L58 witnesses | $\theta(S^p\times S^q)^2=\tfrac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ | used by the Lean file for $264/175$, absent from every quoted passage |
| L23 (E) | subalgebra, $0<r<N$, unit norm, $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ | used to define the family and in D's $r=31$ clause, whose hypotheses fail there (section 7) |
| L23 (E) | its gradedness is sense (C) ([graded-half.md](../findings/graded-half.md) line 430) | the family's "graded" is (C), where (C) and (A) coincide |
| L69 | $n\ge12$, equivariant, pair-graded (C), $\theta\ge\sqrt{3/2}$, $\ker W=0$, $n\ne8$, Cartan's classification (not held in references/) | cited in D's consequence. Its scope excludes two of L58's own witnesses (section 9) |
| senses (F) | (C) and (A) incomparable, each implies (B) | used silently, e.g. to pass from $S^5\times S^7$ (C) to (B) |

## 1. The Casimir step

**Passage B line 154:** "A Casimir $W_{\mathfrak h}=c\big(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}\big)$ has exactly two eigenvalues for $0<r<N$: $c(1-\tfrac rN)$ on $\mathfrak h$ and $-c\tfrac rN$ on $\mathfrak m$."

Derivation. $\Pi_{\mathfrak h}$ is $1$ on $\mathfrak h$ and $0$ on $\mathfrak m$, so $W_{\mathfrak h}$ is $c(1-\tfrac rN)$ on $\mathfrak h$ (dimension $r$) and $-c\tfrac rN$ on $\mathfrak m$ (dimension $N-r$). The two values differ by $c$. For $0<r<N$ both eigenspaces are nonzero, so the spectrum has exactly two points iff $c\ne0$. The trace is $cr(1-\tfrac rN)-c(N-r)\tfrac rN=0$.

- **$c\ne0$ is used and unstated** in A, B, C, D. Every family member is unit norm, so $c^2\cdot\tfrac{r(N-r)}N=1$ and $c\ne0$ holds on the family. No defect in substance.
- **The exclusion needs only "at most two".** For every $c$, every $r\in[0,N]$ and every subspace $\mathfrak h$, $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ has at most two distinct eigenvalues. So a $W$ with three distinct eigenvalues is not of that form for any $\mathfrak h$ at all. The quantifier over $\mathfrak h$ is correctly placed outside: nothing about $\mathfrak h$ (subalgebra, criticality, $r$) is needed. "Graded" and "critical" in the exclusion sentence are idle.
- A further consequence on the same footing: at $0<r<N$ neither Casimir eigenvalue is $0$, so any nonzero $W$ with $\ker W\ne0$ is outside the family.

Verdict: **CONFIRMED.**

## 2. The $\mathbb{CP}^3$ row

Claims located: Passage A line 333, "**yes**, in all three of the record's senses; $\ker W=0$ | three eigenvalues, at multiplicities $6,8,1$", at "$\theta_0(6)=1.054092553$". Passage B line 160 gives the gradedness evidence as "$S=2\times10^{-30}$". Passage D: "$\mathbb{CP}^3$ at $n=6$ with $\theta=\theta_0(6)$ and three eigenvalues".

- **Critical at $\theta_0(6)$.** No argument and no citation in A, B, C or D. The Lean file proves $2\cdot5\cdot4/36=10/9$, the value of $\theta_0(6)^2$, and a decimal bracket, neither of which touches $\mathbb{CP}^3$. Debt: $Q(W_{\mathbb{CP}^3})=\sqrt{10/9}\,W_{\mathbb{CP}^3}$ for the unit Weyl operator of $\mathbb{CP}^3$.
- **Three eigenvalues at multiplicities $6,8,1$.** The values are never given. The only check on file is $6+8+1=15$ (Lean). Debt: the spectrum of $W_{\mathbb{CP}^3}$ on $\Lambda^2\mathbb R^6$ with three distinct values at those multiplicities.
- **Graded in all three senses.** Passage B's evidence is a numerical slack, which is evidence of nothing, and it is the defect screen, an (A)-sense test only. The record's table at [graded-half.md](../findings/graded-half.md) line 329 marks $\mathbb{CP}^3$ yes, yes, yes with no argument beside it. For (C), the symmetric pair is $(\mathfrak{so}(6),\mathfrak u(3))$, and the $\mathfrak u(m)$ uniqueness is asserted in L69's statement. That (C) holds is plausible from the definition, but L58 quotes no argument.
- **(A) depends on a sign the passages never fix.** (A) requires $\mathfrak p=E_+(W)$ to be a subalgebra with $[\mathfrak m,\mathfrak m]\subseteq\mathfrak p$. For a pair-invariant $W$ whose eigenspaces are the pair's pieces, exactly one of $W$ and $-W$ can satisfy that. Critical points fix the sign: $Q$ is quadratic, so $Q(-W)=\theta W=-\theta(-W)$, and $W$ and $-W$ cannot both be critical with $\theta>0$. The (A) claim therefore needs the critical sign of $W_{\mathbb{CP}^3}$ to be positive on $\mathfrak u(3)$, and no passage establishes it. See the related withdrawn candidate 2.W1.
- Screen, not evidence: by hand, the Kähler decomposition $\Lambda^2\mathbb R^6=[\![\Lambda^{2,0}]\!]\oplus\mathfrak{su}(3)\oplus\mathbb R\omega$ has dimensions $6,8,1$ and the Fubini-Study Weyl operator is scalar on each piece with three distinct values and no zero, consistent with the row. This is reported as a screen only and repairs nothing.

Verdict: **HYPOTHESIS-DEBT** on criticality at $\theta_0(6)$, on the spectrum, and on sense (A) including the sign.

## 3. The $S^5\times S^7$ row

Claims located: Passage A line 334, "**yes**, pair-graded, a symmetric pair | three eigenvalues, $-\tfrac74$, $-\tfrac56$, $1$ at multiplicities $10,21,35$, trace $0$", at $\theta=1.2282390$. Passage D gives $\theta=1.228239$.

- **Pair-graded (C): CONFIRMED from the definition.** $(\mathfrak{so}(12),\mathfrak{so}(5)\oplus\mathfrak{so}(7))$ is the symmetric pair of the involution $\mathrm{diag}(I_5,-I_7)$, and the Weyl tensor of the product of round spheres is invariant under the isotropy $SO(5)\times SO(7)$. (B) then follows by the imported implication (C)$\Rightarrow$(B), and directly: the three stated eigenspaces $\Lambda^2\mathbb R^5$, $\Lambda^2\mathbb R^7$, $\mathbb R^5\otimes\mathbb R^7$ are sums of $\pm1$ eigenspaces of $\Lambda^2\sigma$.
- **The stated arithmetic: CONFIRMED AS ALGEBRA.** $10(-\tfrac74)+21(-\tfrac56)+35=-\tfrac{35}2-\tfrac{35}2+35=0$, $10=\binom52$, $21=\binom72$, $35=5\cdot7$, $10+21+35=66=\binom{12}2$, and the three values are distinct.
- **The spectrum's derivation: absent.** No passage derives $-\tfrac74,-\tfrac56,1$. Screen, not evidence: for an Einstein product with sectional curvatures $\lambda/4$ and $\lambda/6$, the curvature operator minus its scalar part $\lambda/11$ gives $\tfrac{7\lambda}{44},\tfrac{5\lambda}{66},-\tfrac\lambda{11}$, which is $-\tfrac\lambda{11}$ times the row, so the row agrees up to an overall scalar.
- **Criticality and $\theta$.** A, B, C, D give $\theta$ only as a decimal. The closed form $\theta^2=264/175$ appears only in the Lean docstring, from a product formula that no quoted passage states and that Lean evaluates but does not prove. Criticality is carried nowhere in L58. It can be read into L69's statement ("every such point is Morse-Bott nondegenerate"), but L58 does not cite L69 for it, and L69's own scope condition $\theta\ge\sqrt{3/2}$ is met here only via the uncited $264/175$.
- Screen, not evidence: the product formula at $p=q=n/2$ gives $\tfrac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$, consistent with L23's equality case $S^{n/2}\times S^{n/2}$.

Verdict: **HYPOTHESIS-DEBT.** What must be proved or cited: $W_{S^5\times S^7}$ is critical with $\theta^2=264/175$, and its spectrum is as stated.

## 4. The $W_{\mathbb{CP}^2}$ row at $n=4$

Claims located: Passage A line 335, "$W_{\mathbb{CP}^2}$ | $4$ | $\sqrt{3/2}$ | **yes**". Passage B line 162: "$W_{\mathbb{CP}^2}$ sits exactly *at* the threshold, graded, critical, and likewise not a Casimir."

- **Graded "yes", sense unnamed.** Passage F's W3 and [graded-half.md](../findings/graded-half.md) line 330 state $\mathbb{CP}^2$ is (C) and not (A), $\ker W=3$ of $6$. So "yes" is true in (C) and (B) and false in (A). Passage A's column header "graded?" carries no sense, and in its first row the same column says "in all three of the record's senses". A reader of the table can take "yes" as the same all-senses claim, which fails in (A).
- **Critical at $\sqrt{3/2}$.** Imported from [conventions.md](../findings/conventions.md) line 64 ($\theta^*=P(u)=\sqrt{3/2}$) and L69's statement (L47). Not argued in L58.
- **Not a Casimir.** "likewise" carries no eigenvalues. Debt: that $W_{\mathbb{CP}^2}$ has three distinct eigenvalues. The debt is shallow, since W3 records $\ker W\ne0$ and section 1 shows a Casimir at $0<r<N$ has no zero eigenvalue, but L58 does not make that step.
- Edge: $\theta_0(4)^2=\tfrac34<\tfrac32$, so this witness sits above the family's cap at $n=4$. That is consistent with L23, whose cap binds the family only.

Verdict: **HYPOTHESIS-DEBT**, and "yes" is true only in (C) and (B).

## 5. The withdrawn row

Claim located: Passage B line 161, "$S=0$ **only**, see below | three eigenvalues $\tfrac5{24},0,-\tfrac18$ at multiplicities $3,7,5$; equivalently a $7$-dimensional kernel". Passage A line 336 withdraws it, "**no**".

- On the record's own spectrum, $\ker W$ has dimension $7\ne0$. Sense (A) requires $\ker W=0$ by definition, so the point is not sign-graded. $S=0$ is the (A)-sense screen, which [graded-half.md](../findings/graded-half.md) records as vacuous wherever $\ker W\ne0$. So $S=0$ establishes nothing in any sense.
- Senses (C) and (B) need a symmetric pair or an involution. Neither is offered. The label is also unidentifiable from the passages: as a pair $(G,K)$, $\dim\mathfrak{su}(3)-\dim\mathfrak{so}(3)=5\ne6$, and Jensen's metric on $S^3\times S^3$ is not a symmetric metric (see 5.W1).
- "equivalently a $7$-dimensional kernel" is an implication, not an equivalence: a nonzero traceless $W$ with a kernel has at least three distinct eigenvalues, while three distinct eigenvalues need not include $0$. The loose word does not change the row.
- The arithmetic stated is consistent: $3+7+5=15$ and $3\cdot\tfrac5{24}-5\cdot\tfrac18=0$.

Verdict: **CONFIRMED** that the row establishes no gradedness, so Passage A's withdrawal is correct.

### 5.W1 Withdrawn candidate: the label names no six-dimensional symmetric space

1. Located: Passage B line 161, "$(\mathfrak{su}(3),\mathfrak{so}(3))$, Jensen's second Einstein metric on $S^3\times S^3$", and C, D "$(\mathfrak{su}(3),\mathfrak{so}(3))$ at $n=6$".
2. Exhibited: $SU(3)/SO(3)$ has dimension $8-3=5$, not $6$.
3. Charitable reading: the pair may name an auxiliary algebra pair in the construction of a six-dimensional Weyl operator, not the manifold $G/K$. **Withdrawn**: the label's intended object cannot be pinned from the passages, and the row's verdict (section 6) does not depend on it.

## 6. The canon against the block: the withdrawn witness is still listed

Located: Passage C, "$\mathbb{CP}^3$ at $n=6$, $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $n=6$ and $S^5\times S^7$ at $n=12$ are graded and outside it." Passage D, "the following are graded and outside it: ... $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $n=6$ with $\theta=\sqrt{6/5}$ and three eigenvalues".

Discrepancy protocol:

1. Location: the two quotations above, against Passage A line 336, "graded? **no** | *withdrawn as a witness*".
2. Failure in closed form: on the spectrum the record itself gives ($\tfrac5{24},0,-\tfrac18$ at $3,7,5$), $\dim\ker W=7\ne0$, so the point fails the definition of (A). Canon C and D assert "graded" with no sense, which Passage F forbids treating as transferable, and in sense (A) it is false.
3. Charitable reading: C and D may mean (B) or (C). Under those senses the claim is not refuted, but no argument exists on the record, and the source block the canon was taken from says "no". The charitable reading turns the claim into debt, not into a proof.

Further mismatches between C, D and A:

| item | Passage A (block) | Passage C | Passage D |
|---|---|---|---|
| $\mathbb{CP}^3$ | yes, all senses | graded | graded |
| $S^5\times S^7$ | yes, pair-graded | graded | graded, plus the $r=31$ clause |
| $W_{\mathbb{CP}^2}$ | yes | absent | absent |
| $(\mathfrak{su}(3),\mathfrak{so}(3))$ | **no**, withdrawn | **graded** | **graded** |
| sense of "graded" | per row | unnamed | unnamed |

Omitting $W_{\mathbb{CP}^2}$ from C and D is harmless: one sound witness suffices for the headline.

Verdict: **REFUTED AS STATED** in sense (A). **HYPOTHESIS-DEBT** in senses (B) and (C).

## 7. Passage D's "family value" at $r=31$

Located: Passage D, "$S^5\times S^7$ at $n=12$ with $\theta=1.228239$, whose isotropy $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ has $r=31$ and whose family value there is $1.2742878$". Passage B line 162 gives the same comparison as the reason "why not a Casimir".

Derivation, exact, from Passage E at $n=12$, $N=66$:

- L23's cap is $r\le n(n-2)/4=30$. Here $r=10+21=31>30$.
- Equivalently, L23's identity would give $S_{\mathfrak{mmm}}=(66-31)\big[20-\tfrac{4\cdot11\cdot31}{66}\big]=35\big[20-\tfrac{62}3\big]=-\tfrac{70}3<0$. A sum of squares cannot be negative, so $W_{\mathfrak{so}(5)\oplus\mathfrak{so}(7)}$ is not critical, and the family has no member at $(n,r)=(12,31)$.
- The formula value is $\theta^2=\tfrac{4}{144}\cdot\tfrac{31\cdot66}{35}=\tfrac{341}{210}$. Against $\theta_0(12)^2=\tfrac{55}{36}$: $\tfrac{341}{210}-\tfrac{55}{36}=\tfrac{2046-1925}{1260}=\tfrac{121}{1260}>0$. The quoted "family value" exceeds the cap that L23 proves every family member obeys.

Discrepancy protocol:

1. Location: the quotation above.
2. Failure: "family value there" names a value of the family at a point where L23 proves the family is empty, exhibited by $r=31>30$ and $S_{\mathfrak{mmm}}=-\tfrac{70}3$.
3. Charitable reading: "family value" means the value of L23's closed-form expression, offered to show $S^5\times S^7$ is not the Casimir of its own isotropy. The arithmetic is then true ($\sqrt{341/210}$), but the comparison is vacuous because that Casimir is not critical, and it addresses one $\mathfrak h$ only, where the family ranges over every subalgebra. The mechanism of section 1 carries the exclusion, so the clause is not load-bearing. The reading rewords the sentence rather than defending it.

Verdict: **REFUTED AS STATED**. The formula value is **CONFIRMED AS ALGEBRA**. Non-load-bearing for L58.

## 8. "Since $S^5\times S^7$ sits above $\thstar$" and "no threshold repairs it"

Located: Passage A line 343, "Since $S^5\times S^7$ sits *above* $\thstar$, restricting the family by a value threshold does not recover it." Passage B line 159, "they run past every threshold the question can carry", and line 162, "no threshold repairs it".

- **$\thstar$ is undefined in every quoted passage.** It is a LaTeX macro ([report.tex](../report/report.tex) line 69) inside a markdown findings file, and its value $\sqrt{3/2}$ is fixed only in [conventions.md](../findings/conventions.md) line 64. Passage B writes $\sqrt{3/2}$ explicitly instead.
- **"Above" holds exactly iff $\theta^2>\tfrac32$.** Given $\theta^2=\tfrac{264}{175}$: $264\cdot2=528>525=175\cdot3$, so it holds. But the passages give only $1.2282390$ against $1.2247449$, a comparison of decimals that is evidence of nothing, and $264/175$ is itself debt (section 3).
- **"Every threshold" is proven only below $\theta(S^5\times S^7)$.** The passages exhibit no witness with $\theta^2\ge\tfrac{264}{175}$. $\mathbb{CP}^3$ and $W_{\mathbb{CP}^2}$ sit lower ($\tfrac{10}9$, $\tfrac32$). A threshold $t$ with $t^2\ge\tfrac{264}{175}$ is covered by nothing on file. Note $\tfrac{264}{175}<\tfrac{55}{36}=\theta_0(12)^2$ ($9504<9625$), so this witness sits below the family's own maximum at $n=12$.

### 8.W1 Withdrawn candidate: at $n=12$ a threshold does repair the claim in sense (C)

1. Located: "no threshold repairs it", Passage B line 162.
2. Exhibited, conditional on imports: at $n=12$, sense (C), $\ker W=0$, take $t=\sqrt{264/175}$. By L69, a graded critical point with $\theta>t\ge\sqrt{3/2}$ is $S^p\times S^q$ with $p,q\ge5$, $p+q=12$, so $S^6\times S^6$ only, which is L23's equality case and lies in the family.
3. Charitable reading: the thresholds "the question can carry" are those up to $\theta^*=\sqrt{3/2}$, and the claim may be uniform in $n$. At $t\le\theta^*$ the witness suffices. **Withdrawn**: the candidate rests on L69's completeness (Cartan's classification, not held) and on a reading of "threshold" that the passage need not bear. The scope overreach remains and is recorded above as GAP.

Verdict: **GAP.** Proven at thresholds $t<\theta(S^5\times S^7)$, conditional on $\theta^2=264/175$. Stated at every threshold.

## 9. The consequence in Passage D

Located: "Consequently Lemma L23's cap at $\theta_0(n)$ is a statement about the family and the graded case needs Lemma L69's classification instead."

- **First half: CONFIRMED.** L23's hypothesis is $W=W_{\mathfrak h}$ for a subalgebra $\mathfrak h$, so its cap binds only that form. This follows from L23's statement alone. The witnesses show the restriction is not empty.
- **Second half: GAP.** L69's statement is restricted to $n\ge12$, equivariant pair-graded (C) points, $\theta\ge\sqrt{3/2}$, $\ker W=0$, $n\ne8$, and its "every" rests on Cartan's classification, which references/ does not hold. Concretely, outside that scope:
  - L58's own $\mathbb{CP}^3$ at $n=6$ and $W_{\mathbb{CP}^2}$ at $n=4$ ($n<12$),
  - any sign-graded (A) point that is not (C), such as the $n=8$ witness of W3,
  - every graded point with $\theta<\sqrt{3/2}$.

  "The graded case needs L69 instead" reads as L69 handling the graded case. What is supported is narrower: the pair-graded case at $n\ge12$ above $\sqrt{3/2}$ needs L69, conditional on Cartan.

Verdict: **GAP** (first half CONFIRMED).

## 10. The headline and its quantifiers

- **What is proven versus stated.** The argument proves non-containment: some graded critical point lies outside the family. "Strictly wider" read as a strict superset would also need family $\subseteq$ graded set, and L23 says a family member is graded exactly at $r=n(n-2)/4$. Passage B's body ("does not exhaust the graded critical set") fixes the reading as non-containment. See 10.W1.
- **Sense by sense.** In (C) and (B), non-containment rests on $S^5\times S^7$ (section 3) or on $W_{\mathbb{CP}^2}$ (section 4), both with criticality and spectrum undelivered in L58. In (A), it rests on $\mathbb{CP}^3$ alone, whose (A) claim has no argument and a sign dependence (section 2).
- **Quantifier order.** The exclusion is "for every $W$ with three distinct eigenvalues, for every $\mathfrak h$, $W\ne W_{\mathfrak h}$", which is correct (section 1). The witness claims are existential per sense, and C and D never name the sense.

Verdict: **HYPOTHESIS-DEBT.** What would discharge it, in any one sense: one witness with a written or cited proof of criticality and of at least three distinct eigenvalues (or $W\ne0$ with $\ker W\ne0$), and gradedness in that sense.

### 10.W1 Withdrawn candidate: "strictly wider" as a strict superset is false

1. Located: Passage C, "The graded set is strictly wider than the subalgebra family."
2. Exhibit: this would need an ungraded critical Casimir, some critical $W_{\mathfrak h}$ with $r<n(n-2)/4$. No such point is on file in the quoted passages, and none can be exhibited in closed form without $Q$. **Fails step 2.**
3. Charitable reading: non-containment, as Passage B's body says. **Withdrawn.**

## 11. The Lean file

[L58.lean](../lean/HamiltonsCubic/Results/L58.lean), read not built.

| theorem | what it checks | gap to the docstring |
|---|---|---|
| eigen_gap | $c(1-\tfrac rN)+\tfrac{cr}N=c$ given $N\ne0$ | no operator or spectrum. Distinctness needs $c\ne0$, stated by no theorem |
| casimir_traceless | $rc(1-\tfrac rN)-(N-r)\tfrac{cr}N=0$ | correct |
| three_excludes | three pairwise distinct rationals cannot all lie in $\{a,b\}$ | pigeonhole only. Uses neither $0<r<N$ nor $c\ne0$, so it is the "at most two" form of section 1, not "exactly two" |
| cp3_multiplicities, lambda2_six | $6+8+1=15$, $6\cdot5/2=15$ | nothing about $\mathbb{CP}^3$'s eigenvalues, which are never stated |
| theta0_six_sq, theta0_six_bracket | $\tfrac{2\cdot5\cdot4}{36}=\tfrac{10}9$ and a decimal bracket | does not link $\theta(\mathbb{CP}^3)$ to $\theta_0(6)$ |
| s5s7_traceless, s5s7_multiplicities, lambda2_twelve, s5s7_block_split, s5s7_three_distinct | the block's own numbers | spectrum taken as given, not derived |
| s5s7_theta_sq, s5s7_theta_bracket | the product formula evaluated at $(12,5,7)$ is $\tfrac{264}{175}$, plus a bracket | the formula itself is assumed |
| withdrawn_theta_sq_bracket, witnesses_distinct | decimal bracket, three distinct rationals | $W_{\mathbb{CP}^2}$ has no theorem of its own |

- The docstring's "The mechanism and both surviving witnesses are arithmetic and are checked here" overclaims. Criticality, $\theta$ values, spectra and gradedness are all outside the file, and the last is admitted.
- "Either survivor proves the lemma alone, and both check exactly" overclaims for $\mathbb{CP}^3$, whose three distinct eigenvalues are nowhere stated in the file.
- "exactly two eigenvalues for $0<r<N$ and $c\ne0$" is not a theorem in the file. Only the at-most-two exclusion is, which is all the lemma needs.

Verdict: **CONFIRMED AS ALGEBRA.**

## 12. Brief's attack items and standing list, cross-referenced

**Standing list**

1. Hypothesis inventory: the table above. Used but unstated: $c\ne0$, the sense of graded in C and D, each witness's criticality and spectrum, the critical sign of $W$, and the product $\theta$ formula.
2. Quantifier order and scope: sections 1 and 10. The exclusion's order is correct. Senses per witness: $\mathbb{CP}^3$ is claimed in all three, (A) undelivered. $S^5\times S^7$ is (C), hence (B). $W_{\mathbb{CP}^2}$ is (C) and (B), not (A). $(\mathfrak{su}(3),\mathfrak{so}(3))$ is not (A), and nothing is argued in (B) or (C).
3. Edges:
   - $n=4$: section 4. $W_{\mathbb{CP}^2}$ lies above $\theta_0(4)=\sqrt{3/4}$, with no contradiction.
   - $n=6$: sections 2 and 5. $\mathbb{CP}^3$ is claimed at the family's cap value $\theta_0(6)$, shared with $S^3\times S^3$.
   - $\ker W\ne0$: sections 1, 4 and 5. A Casimir at $0<r<N$ has no zero eigenvalue, (A) fails by definition, and $S$ is vacuous there.
   - $r=0$ or $r=N$: $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}=0$, so no unit member exists. The at-most-two exclusion still holds, since the spectrum is then $\{0\}$.
4. Proven against stated: sections 7, 8, 9 and 10.
5. Lean: section 11.
6. Attack items: listed below.
7. Falsifiers: listed below.

**Brief's "What to attack" items**

1. The Casimir step: section 1, **CONFIRMED**. It needs nothing about $\mathfrak h$.
2. Each witness: sections 2, 3 and 4, all **HYPOTHESIS-DEBT** on criticality and spectrum. Only $S^5\times S^7$ carries eigenvalue values.
3. The withdrawn row: section 5, **CONFIRMED** that it establishes no gradedness.
4. Canon against block: sections 6 and 7. C and D carry the withdrawn witness. D's "family value" at $r=31$ contradicts L23's cap $r\le30$.
5. $\thstar$: section 8. It is undefined in the passages and equals $\sqrt{3/2}$ by conventions. "Above" holds exactly given the uncited $264/175$. "Every threshold" is a **GAP**.
6. The consequence: section 9, **GAP**.
7. Numerical entries, closed form versus decimal only:

| passage | closed form | decimal or numerical only |
|---|---|---|
| A | $\theta_0(6)$ (with decimal), $\sqrt{3/2}$, $\sqrt{6/5}$, $-\tfrac74,-\tfrac56,1$, multiplicities | $\theta(S^5\times S^7)=1.2282390$ |
| B | $\theta_0(6)$ (with decimal), $\sqrt{6/5}$ (with decimal), $\tfrac5{24},0,-\tfrac18$, $r=31$, $\sqrt{3/2}$ (with decimal) | $S=2\times10^{-30}$ (numerical slack), $1.2282390$, $1.2742878$ (closed form $\sqrt{341/210}$ derivable from E), "$S=0$" with no exactness stated |
| D | $\theta_0(6)$, $\sqrt{6/5}$, $r=31$ | $\theta=1.228239$, $1.2742878$ |

   $\mathbb{CP}^3$'s eigenvalue values appear in no passage in any form.

8. Boundary: standing item 3 above.

**Falsifiers sought**

| claim | falsifying object | what was done |
|---|---|---|
| Casimir step | a $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with three distinct eigenvalues | derived the spectrum for arbitrary $c$, $r$, subspace $\mathfrak h$. None exists |
| $\mathbb{CP}^3$ row | a two-eigenvalue or kernel-carrying $W_{\mathbb{CP}^3}$, or a sign under which $E_+$ is not a subalgebra | hand screen of the Kähler decomposition, consistent. The sign is not fixable from the passages (2.W1) |
| $S^5\times S^7$ row | a spectrum differing from $-\tfrac74,-\tfrac56,1$ at $10,21,35$ up to scalar | hand screen of the Einstein product, agrees up to $-\tfrac\lambda{11}$ |
| $W_{\mathbb{CP}^2}$ "graded yes" | a sense in which it fails | (A), by the record's own W3 ($\ker W=3$) |
| canon's third witness | failure of a sense's definition on the record's own spectrum | (A) fails by $\ker W=7$ |
| D's $r=31$ clause | a critical Casimir at $(12,31)$ | L23 excludes it, $S_{\mathfrak{mmm}}=-\tfrac{70}3$ |
| "every threshold" | a threshold with no non-family graded point above it | 8.W1, withdrawn under the $t\le\theta^*$ reading. No witness on file above $\sqrt{264/175}$ |
| consequence | a graded point outside L69's scope | $\mathbb{CP}^3$ ($n=6$), $W_{\mathbb{CP}^2}$ ($n=4$) |

### 2.W1 Withdrawn candidate: the $S^5\times S^7$ row's sign contradicts the family's

1. Located: Passage A line 334, eigenvalues $-\tfrac74,-\tfrac56$ on $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ and $1$ on $\mathbb R^5\otimes\mathbb R^7$, so $E_+(W)=\mathfrak m$.
2. Exhibit: graded-half.md line 430 says $\mathfrak p,\mathfrak m$ "genuinely are $E_\pm$" on L23's family, which would put the isotropy in $E_+$ at the critical sign, the opposite of this row's sign pattern. But the critical sign of $S^5\times S^7$ is set by $P$, which no quoted passage gives, and the sign pattern need not persist from $p=q$ to $p\ne q$. **Fails step 2**: no closed-form failure without $P$.
3. Charitable reading: the row lists eigenvalues up to an overall scalar, which is all the three-eigenvalue mechanism uses. **Withdrawn.** The sign question survives only as part of the $\mathbb{CP}^3$ (A) debt in section 2.

## Overall verdict

**HYPOTHESIS-DEBT.** The mechanism (section 1) is sound and needs only "at most two eigenvalues". The lemma's content, a graded critical point outside the family, rests on witnesses whose criticality, $\theta$ and spectrum the lemma asserts without argument or citation. Separately, the canon (C, D) still lists the withdrawn $(\mathfrak{su}(3),\mathfrak{so}(3))$ witness as graded, D quotes a family value at $(n,r)=(12,31)$ where L23 proves the family empty, "every threshold" is proven only below $\theta(S^5\times S^7)$, and the L69 consequence overstates L69's scope.
