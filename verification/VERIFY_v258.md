# Verifier v258, L58: the Casimir two-eigenvalue step, the four witness rows, and the canon against the block

The brief ([BRIEF_L58.md](BRIEF_L58.md)) was read cold. No numerical work was done, every value below is exact, and no scripts were written or run. Log: [agent_logs/verify-L58-v258.log](../agent_logs/verify-L58-v258.log).

**Disclosure.** Locating Lemma L69's statement, a `grep` over [results.md](../results.md) printed lines 38, 65 and 479 besides the statement at line 194. None is a verdict file. Line 479 is another result's text that mentions L58, and nothing in this report rests on it.

| # | claim | verdict |
|---|---|---|
| 1 | A Casimir $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, $0<r<N$, has exactly two eigenvalues, so three or more distinct eigenvalues exclude every Casimir | CONFIRMED (with $c\ne0$, supplied by L23's unit norm) |
| 2 | $\mathbb{CP}^3$, $n=6$: critical at $\theta_0(6)$, graded in all three senses, $\ker W=0$, three eigenvalues at multiplicities $6,8,1$ | HYPOTHESIS-DEBT |
| 3a | $S^5\times S^7$, $n=12$: eigenvalues $-\tfrac74,-\tfrac56,1$ at multiplicities $10,21,35$, trace $0$ | CONFIRMED AS ALGEBRA |
| 3b | $S^5\times S^7$: critical, $\theta=1.2282390$, pair-graded | HYPOTHESIS-DEBT |
| 4 | $W_{\mathbb{CP}^2}$, $n=4$: critical at $\sqrt{3/2}$, graded, not a Casimir | HYPOTHESIS-DEBT |
| 5 | The withdrawn row $(\mathfrak{su}(3),\mathfrak{so}(3))$: $S=0$ with a $7$-dimensional kernel | HYPOTHESIS-DEBT (neither "graded" nor "not graded" is argued) |
| 6 | Canon, Passages C and D, against the block, Passage A | REFUTED AS STATED |
| 7 | "Since $S^5\times S^7$ sits *above* $\thstar$" | GAP |
| 8 | "L23's cap is a statement about the family and the graded case needs L69's classification instead" | GAP |
| 9 | [L58.lean](../lean/HamiltonsCubic/Results/L58.lean) checks what it claims | CONFIRMED AS ALGEBRA (its docstring overclaims) |

**Summary:** the Casimir exclusion is proven, but no witness has an argument on file for being critical and graded, so the existence half of L58 is owed. The canon still lists the withdrawn witness as graded and cites a "family value" at an $r$ where L23 excludes every family point.

## 0. Conventions, fixed once

- $N=\binom n2$, $\mathcal W_n$ the algebraic Weyl operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, a critical point a unit $W$ with $Q(W)=\theta W$. The brief does not define $Q$, so no $\theta$ is computed here.
- $\theta_0(n)$ is L23's cap. At $r=n(n-2)/4$ one has $N-r=n^2/4$ and $rN/(N-r)=(n-1)(n-2)/2$, so $\theta_0(n)^2=2(n-1)(n-2)/n^2$. This gives $\theta_0(4)^2=\tfrac34$, $\theta_0(6)^2=\tfrac{10}9$ and $\theta_0(12)^2=\tfrac{55}{36}$.
- The "family" is L23's: subalgebras $\mathfrak h$ with $0<r<N$ and $W_{\mathfrak h}$ the unit multiple of $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$, critical.
- "Graded" is used in the three senses of Passage F: (C) pair, (A) sign, (B) slice. Their definitions are not quoted in the brief. Only the implications (C) ⇒ (B), (A) ⇒ (B), and the facts "$\mathbb{CP}^2$ is (C) not (A)" and "(C), (A) incomparable" are available.
- Operators on $\Lambda^2$ that are diagonal in a basis $e_i\wedge e_j$ are written by their value on each block. Where I use a curvature normalisation for a screen, I state it.

## Hypothesis inventory

| source | hypothesis | used by the argument? |
|---|---|---|
| Statement (A, B, C, D) | $0<r<N$ | yes, for "exactly two". The exclusion itself holds without it (see §1) |
| Statement | $c\ne0$ | **used but unstated** in A to D. It is supplied by L23's "unit-norm multiple", since $c=0$ gives the zero operator |
| Statement | $\mathfrak h$ a subalgebra | not used by the Casimir step. The count holds for any subspace |
| Statement | the sense of "graded" | **unstated** in the statement sentences of A, C and D. Only the rows name senses |
| Statement | "critical" for each witness | asserted, no argument on the cited lines |
| L23 | $\mathfrak h$ subalgebra, $0<r<N$, unit norm, $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ | defines the family. **Its $\theta$ formula is used in B and D at $r=31$, $n=12$, where its hypothesis cannot hold** (§6) |
| L23 | conclusion $r\le n(n-2)/4$, $\theta\le\theta_0(n)$ | used by D's consequence (§8) |
| L69 (results.md line 194) | pair-graded, equivariant, $\ker W=0$, $n\ne8$, $n\ge12$, $\theta\ge\sqrt{3/2}$, and a Cartan enumeration the record does not hold | invoked by D's consequence **without its scope** (§8) |
| Passage F | (C) and (A) incomparable, each implies (B), no transfer | violated in spirit by the unqualified "graded" in C and D (§2) |
| Used, never defined | $\thstar$ (A), the slack $S$ (B), the sign and normalisation of each witness representative | §7, §5, §3 |

## 1. The Casimir step (attack item 1)

**Derivation.** Let $\mathfrak h$ be any subspace of dimension $r$ with $0<r<N$ and $c\in\mathbb R$. Then $\Pi_{\mathfrak h}$ has eigenvalue $1$ on $\mathfrak h$ and $0$ on $\mathfrak h^\perp$, so $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ acts as $c(1-\tfrac rN)$ on $\mathfrak h$ (dimension $r\ge1$) and as $-c\tfrac rN$ on $\mathfrak h^\perp$ (dimension $N-r\ge1$). The difference is $c$. So there are exactly two eigenvalues iff $c\ne0$, and one eigenvalue if $c=0$.

**The exclusion.** For every $\mathfrak h$, every $r\in\{0,\dots,N\}$ and every $c$, the spectrum of $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ has at most two elements. At $r=0$ or $r=N$ the operator is $0$. So an operator with three or more distinct eigenvalues equals no such operator. **Nothing about $\mathfrak h$ is needed**, not even that it is a subalgebra. Gradedness and $\theta$ play no role, as Passage B says.

**A stronger form the record does not use.** For $0<r<N$ and $c\ne0$ both eigenvalues are nonzero, so every Casimir has $\ker W=0$. Any $W$ with $\ker W\ne0$ is also outside the family, whatever its eigenvalue count.

**Verdict:** CONFIRMED, with $c\ne0$ read from L23's unit norm (candidate 1.W below).

### 1.W Withdrawn candidates

- **1.W1, "exactly two" fails at $c=0$.** (1) Located in Passage A line 330: "with $0<r<N$ has exactly *two* eigenvalues". (2) $c=0$ gives the zero operator, one eigenvalue. (3) Charitable reading: the family consists of unit operators (Passage E), so $c\ne0$. **Withdrawn at step 3.**

## 2. Quantifier order and scope

- The lemma has two parts. **(i)** For all graded critical $W$ with at least three distinct eigenvalues, $W$ is outside the family. **(ii)** There exists a graded critical $W$ outside the family. Part (i) is §1 and needs no gradedness. Part (ii) carries the content of "strictly wider" and rests entirely on the witnesses.
- **"The graded set" is a different set in each sense.** By Passage F no claim transfers between (C) and (A). The rows claim: $\mathbb{CP}^3$ in all three senses; $S^5\times S^7$ in (C) only (hence (B)); $W_{\mathbb{CP}^2}$ with no sense named (by W3 it is (C), hence (B), and not (A)).
- **So in sense (A), part (ii) rests on $\mathbb{CP}^3$ alone.** If $\mathbb{CP}^3$'s (A) claim failed, the table would hold no (A) witness. The statement sentences of A, C and D say "graded" without a sense and so do not register this.
- Passage C's title "strictly wider" reads as family $\subsetneq$ graded set. Passage B's body says "does not exhaust", which is graded $\not\subseteq$ family. See candidate 2.W1.

### 2.W Withdrawn candidates

- **2.W1, the family is not a subset of the graded set.** (1) Located in results.md line 192: "The graded set is strictly wider than the subalgebra family." (2) L23 (Passage E) says a critical family member with $S_{\mathfrak{mmm}}>0$ is not $\mathbb Z_2$-graded. A closed-form critical family member with $r<n(n-2)/4$ would exhibit it, but the brief supplies none, and I have no $Q$ to test one. (3) Charitable reading: "wider" means "not exhausted by", which is Passage B's own wording. **Withdrawn at step 2**, as no concrete family member is exhibited.

## 3. $S^5\times S^7$ at $n=12$ (attack item 2)

**Stated:** "three eigenvalues, $-\tfrac74$, $-\tfrac56$, $1$ at multiplicities $10,21,35$, trace $0$", "pair-graded, a symmetric pair", $\theta=1.2282390$ (Passage A line 334). In Passage B line 162, "symmetric pair", with isotropy $r=31$.

**What the record derives.** Nothing on the cited lines. The values and multiplicities are printed without a source.

**Check of the eigenvalue data as algebra.** Write $\mathbb R^{12}=V_1\oplus V_2$, $\dim V_1=5$, $\dim V_2=7$, and let $W$ act as $w_1$ on $\Lambda^2V_1$, $w_2$ on $\Lambda^2V_2$, $w_3$ on $V_1\wedge V_2$, of dimensions $\binom52=10$, $\binom72=21$, $5\cdot7=35$. These sum to $66=N$.

- Trace: $10(-\tfrac74)+21(-\tfrac56)+35=-\tfrac{35}2-\tfrac{35}2+35=0$.
- Ricci contraction at $e_i\in V_1$: $4w_1+7w_3=4(-\tfrac74)+7=0$. At $e_i\in V_2$: $6w_2+5w_3=6(-\tfrac56)+5=0$. Off-diagonal Ricci terms vanish because $W$ is diagonal in the $e_i\wedge e_j$ basis.
- First Bianchi: $W_{ijkl}\ne0$ only when $\{k,l\}=\{i,j\}$, so the cyclic sum over three distinct indices vanishes.
- So the stated operator is an algebraic Weyl operator with three distinct eigenvalues. The two contractions force $w_1=-\tfrac q{p-1}w_3$ and $w_2=-\tfrac p{q-1}w_3$ with $(p,q)=(5,7)$, so the diagonal block Weyl operators form a single line and the stated values are that line's point with $w_3=1$.
- $\dim(\mathfrak{so}(5)\oplus\mathfrak{so}(7))=10+21=31$, as stated.

**Verdict 3a:** CONFIRMED AS ALGEBRA.

**Criticality, $\theta$ and pair-gradedness.** No argument on the cited lines. $\theta$ is given only as the decimal $1.2282390$, and the closed form $\theta^2=264/175$ appears only in the Lean file, from a formula $2(n-1)(p-1)(q-1)/((n-2)pq)$ that has no source on the brief. What would have to be proved: that $Q(W)=\theta W$ at this $W$ with $\theta^2=264/175$, and that $W$ is pair-graded in the sense (C) of the record's definition.

**Verdict 3b:** HYPOTHESIS-DEBT.

**Falsifier search.** A falsifier would be a proof that this $W$ is not critical, or not (C)-graded, or has at most two eigenvalues.

- The eigenvalue count is settled above.
- Screen only, not supplied as proof: the $SO(5)\times SO(7)$-invariant symmetric operators on $\Lambda^2$ form a $3$-dimensional space. The invariant symmetric $2$-tensors on $\mathbb R^{12}$ give $2$ Ricci conditions, and $\Lambda^4(V_1\oplus V_2)$ has no invariants. So invariant Weyl operators form a line, and an equivariant $Q$ maps this line into itself. That does not fix $\theta$ or its sign. **No falsifier found.**
- Consistency screen on the Lean formula: at $p=q=n/2$ it returns $2(n-1)(n-2)/n^2=\theta_0(n)^2$, L23's equality case, at $n=4,6,12$ alike.

### 3.W Withdrawn candidates

- **3.W1, sign of the representative.** (1) Passage A line 334 names the operator $(-\tfrac74,-\tfrac56,1)$ "$S^5\times S^7$". (2) With curvature operator $\kappa_1\mathrm{Id}$ and $\kappa_2\mathrm{Id}$ on the factors ($\kappa_i>0$), $0$ across, Ricci values $\rho_1=4\kappa_1$ and $\rho_2=6\kappa_2$, the cross-block Weyl value is $\big[(1-q)\rho_1+(1-p)\rho_2\big]/((n-1)(n-2))=-(6\rho_1+4\rho_2)/110<0$. So the geometric Weyl operator is a negative multiple of the tabulated one. (3) Charitable reading: the brief fixes no sign convention for the curvature operator, and $\pm W$ are one geometric direction with $\theta$ of opposite sign. The row claims only (C), which the brief does not tie to a sign. **Withdrawn at step 3.**

## 4. $\mathbb{CP}^3$ at $n=6$ and $W_{\mathbb{CP}^2}$ at $n=4$ (attack item 2)

### 4.1 $\mathbb{CP}^3$

**Stated:** $\theta=\theta_0(6)=1.054092553$, "**yes**, in all three of the record's senses; $\ker W=0$", "three eigenvalues, at multiplicities $6,8,1$" (Passage A line 333). Passage B line 160 gives the graded column as "$S=2\times10^{-30}$", a numerical slack, and "three eigenvalues".

**What the record derives.** Nothing. No eigenvalues are printed, only multiplicities. No argument is given for criticality, for $\theta=\theta_0(6)$, for $\ker W=0$, or for any of the three senses. Passage B's gradedness entry is a decimal slack, which is evidence of nothing.

**Verdict:** HYPOTHESIS-DEBT. Owed: $Q(W)=\theta_0(6)W$ at $W_{\mathbb{CP}^3}$; the eigen-decomposition with its values; membership in (C), (A) and (B) separately under the record's definitions; $\ker W=0$.

**Falsifier search, screens only.**

- $\Lambda^2\mathbb R^6=\mathbb R\omega\oplus\mathfrak{su}(3)\oplus[\![\Lambda^{2,0}]\!]$ under $U(3)$ has dimensions $1,8,6$, matching the stated multiplicities.
- A Kähler curvature operator vanishes on $[\![\Lambda^{2,0}]\!]$. With holomorphic sectional curvature $4$, Fubini–Study has values $8$ on $\omega$ and $2$ on $\mathfrak{su}(3)$ (trace $24=\mathrm{scal}/2$). For an Einstein metric $W=\mathcal R-\tfrac{\mathrm{scal}}{n(n-1)}\mathrm{Id}=\mathcal R-\tfrac85\mathrm{Id}$, giving $\tfrac{32}5,\tfrac25,-\tfrac85$ at multiplicities $1,8,6$. That is three distinct nonzero values with trace $0$, consistent with the row and with $\ker W=0$.
- The invariant Weyl operators form a line: $3$ block scalars, less $1$ Ricci condition and $1$ Bianchi condition from the invariant $\omega\wedge\omega\in\Lambda^4$.
- **No falsifier found.** The debt stands, since none of this is on file.

### 4.2 $W_{\mathbb{CP}^2}$

**Stated:** $n=4$, $\theta=\sqrt{3/2}$, graded "**yes**", "the point that anchors the threshold sentence below, dropped from this table in the move" (Passage A line 335). In Passage B line 164 it is "graded, critical, and likewise not a Casimir".

- **No sense is named in the row.** Passage F's W3 fixes it as (C), hence (B), and not (A), with $\ker W=3$ of $6$.
- **"Not a Casimir" is proven by §1's stronger form alone:** $\ker W\ne0$ excludes every Casimir. The record gives no eigenvalues for this row.
- **Criticality and $\theta=\sqrt{3/2}$ carry no argument** on the cited lines.
- The row's own remark is inconsistent. It says the point was "dropped from this table" while it is in the table. It also says it "anchors the threshold sentence below", yet that sentence (line 343) names only $S^5\times S^7$ and $\thstar$.

**Verdict:** HYPOTHESIS-DEBT. Owed: criticality at $\theta=\sqrt{3/2}$ and gradedness in a named sense, argued.

## 5. The withdrawn row $(\mathfrak{su}(3),\mathfrak{so}(3))$ (attack item 3)

**Stated.** In Passage B line 161: "$S=0$ **only**", "three eigenvalues $\tfrac5{24},0,-\tfrac18$ at multiplicities $3,7,5$; equivalently a $7$-dimensional kernel". In Passage A line 336: graded "**no**", "*withdrawn as a witness*, see below".

**Algebra.** Trace $3\cdot\tfrac5{24}-5\cdot\tfrac18=\tfrac58-\tfrac58=0$ and $3+7+5=15=N$. Three distinct values, one of them $0$, so it is outside the family by §1 in either form.

**Does $S=0$ with a $7$-dimensional kernel establish gradedness?**

- $S$ is not defined in any quoted passage, so $S=0$ implies no sense on the brief.
- The kernel works against (A). W3's example of (C)-not-(A) is $\mathbb{CP}^2$, and the reason W3 gives is its kernel.
- No eigenspace is identified with a subspace of $\mathfrak{so}(6)$, so neither (C) nor (B) can be read off.
- **So the record establishes gradedness in no sense.**

**The block's "no" is also unargued on the lines the brief quotes.** "See below" points outside the quoted range. The record thus shows "not established", which is weaker than "not graded".

**Verdict:** HYPOTHESIS-DEBT in both directions. Owed, for reinstatement: gradedness in a named sense. Owed, for "no": a proof of non-gradedness.

### 5.W Withdrawn candidates

- **5.W1, the row might be (C)-graded after all.** (1) Passage A line 336: "graded? **no**". (2) The dimensions fit $\mathfrak{so}(3)\subset\mathfrak{su}(3)\subset\mathfrak u(3)\subset\mathfrak{so}(6)$, where the complement of $\mathfrak{so}(3)$ in $\mathfrak{su}(3)$ has dimension $5$ and the complement of $\mathfrak{su}(3)$ in $\mathfrak{so}(6)$ has dimension $7$. If the $0$-eigenspace were that complement, $W$ would preserve the symmetric pair $\mathfrak u(3)\oplus[\![\Lambda^{2,0}]\!]$. The record identifies no eigenspace, and the brief does not define (C), so no concrete failure is exhibited. (3) Charitable reading: "no" means "not established". **Withdrawn at step 2.**

## 6. The canon against the block (attack item 4)

**Which witnesses each passage carries.**

| passage | $\mathbb{CP}^3$ | $(\mathfrak{su}(3),\mathfrak{so}(3))$ | $S^5\times S^7$ | $W_{\mathbb{CP}^2}$ |
|---|---|---|---|---|
| A, findings block, lines 333–336 | graded, all three senses | **withdrawn, graded "no"** | pair-graded | graded |
| B, argument, lines 160–164 | "$S=2\times10^{-30}$" | "$S=0$ **only**" | symmetric pair | in prose |
| C, results.md line 192 | graded | **graded** | graded | absent |
| D, results.md line 669 | graded | **graded** | graded | absent |

**Candidate 6.1, the canon carries the withdrawn witness as graded.** (1) Located at results.md line 192, "$(\mathfrak{su}(3),\mathfrak{so}(3))$ at $n=6$ … are graded and outside it", and line 669, "the following are graded and outside it: … $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $n=6$ with $\theta=\sqrt{6/5}$". (2) Passage A line 336 marks the same object "graded? **no**, *withdrawn as a witness*", and §5 finds no sense in which the record argues gradedness. (3) Charitable reading: the canon predates the withdrawal and the lemma survives on the other rows. That makes the canon stale, not correct. **Stands.**

**Candidate 6.2, "whose family value there is $1.2742878$".** (1) Located at results.md line 669, "whose isotropy $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ has $r=31$ and whose family value there is $1.2742878$". Passage B line 162 has "the family's $\theta$ at $r=31$ is $1.2742878$". (2) At $n=12$, $N=66$, L23's cap is $r\le n(n-2)/4=30<31$. Evaluating L23's own slack at $r=31$:
$$S_{\mathfrak{mmm}}=(66-31)\Big[2\cdot10-\frac{4\cdot11\cdot31}{66}\Big]=35\Big[20-\frac{62}3\Big]=-\frac{70}3<0,$$
which is impossible for a sum of squares. So **no subalgebra of dimension $31$ in $\mathfrak{so}(12)$ gives a critical family point**, and "the family value there" has no referent. The formula's value at $r=31$ is $\theta^2=\tfrac4{144}\cdot\tfrac{31\cdot66}{35}=\tfrac{341}{210}$. That exceeds the cap $\theta_0(12)^2=\tfrac{55}{36}$, since $341\cdot36=12276>11550=55\cdot210$. (3) Charitable reading: the clause names only the value of L23's formula at $r=31$, as a remark that $W_{S^5\times S^7}$ is not its isotropy's Casimir. As algebra, $\theta^2=341/210$ is the formula's value. But the passage calls it the "family value", it lies above the family's cap, and it is not load-bearing because §1 already excludes the point. **Stands as stated**, while the charitable reading holds as algebra only.

**A related exact comparison.** $S^5\times S^7$'s $\theta^2=264/175$ (Lean only) lies *below* the true family cap at its own $n$: $264\cdot36=9504<9625=55\cdot175$. The decimal $1.2742878$ in B and D suggests the opposite ordering.

**Omissions.** C and D omit $W_{\mathbb{CP}^2}$, the only row whose claimed $\theta$ exceeds its $n$'s cap ($\tfrac32>\tfrac34$). D's consequence needs that row (§8).

**Verdict:** REFUTED AS STATED.

## 7. "Since $S^5\times S^7$ sits *above* $\thstar$" (attack item 5)

- (1) Located at Passage A line 343.
- **$\thstar$ is a macro defined in no quoted passage.** Passage B line 164 makes the parallel statement with $\sqrt{3/2}=1.2247449$, so the charitable reading is $\thstar=\sqrt{3/2}$.
- Under that reading the inequality holds exactly *if* $\theta(S^5\times S^7)^2=264/175$: $264\cdot2=528>525=175\cdot3$, a margin of $\tfrac3{350}$. The record, however, gives $\theta(S^5\times S^7)$ only as a decimal. The closed form $264/175$ exists only in the Lean file, from an unsourced formula. The brief records no derivation of it.
- "Restricting the family by a value threshold does not recover it" follows from §1 alone at any threshold: the point is outside the family by its spectrum, whatever $\theta$ is.

**Verdict:** GAP. The symbol is undefined in the block, and the inequality rests on a $\theta$ with no closed-form derivation on file (debt shared with §3b).

## 8. The consequence (attack item 6)

**Stated:** "Consequently Lemma L23's cap at $\theta_0(n)$ is a statement about the family and the graded case needs Lemma L69's classification instead" (results.md line 669).

- **The first half is true, but by L23's hypotheses, not as a consequence of L58.** L23 is stated for subalgebra Casimirs (Passage E). L58 shows only that some graded points lie outside that hypothesis. That L23's cap fails to bound graded points needs a graded point above $\theta_0(n)$. Among the rows, only $W_{\mathbb{CP}^2}$ is such a point ($\theta^2=\tfrac32>\tfrac34=\theta_0(4)^2$, itself owed, §4.2), and C and D dropped that row. $\mathbb{CP}^3$ sits *at* $\theta_0(6)$, and $S^5\times S^7$ sits below $\theta_0(12)$ (§6).
- **The second half overreaches L69's scope.** L69 (results.md line 194) covers only equivariant **pair-graded** points with $\ker W=0$, $n\ne8$, $n\ge12$, $\theta\ge\sqrt{3/2}$, and its "every" rests on a classification the record does not hold. It says nothing about sense (A) or (B), nor about $n<12$ or $\ker W\ne0$.
- **Concrete object outside L69:** $W_{\mathbb{CP}^2}$ at $n=4$, (C)-graded by W3, with $\ker W\ne0$ and $n<12$. Charitable reading: "needs" means "requires a classification of L69's kind", not "is supplied by L69".

**Verdict:** GAP. The consequence is a pointer, not a derived implication, and the cited result's scope is narrower than "the graded case".

## 9. The Lean file (standing item 5)

What [L58.lean](../lean/HamiltonsCubic/Results/L58.lean) proves, read without building (no computation run):

| theorem | content | status |
|---|---|---|
| eigen_gap, casimir_traceless | $c(1-\tfrac rN)-(-\tfrac{cr}N)=c$, and $r\cdot$hi $+(N-r)\cdot$lo $=0$ over $\mathbb Q$, $N\ne0$ | correct algebra |
| three_excludes | three pairwise distinct rationals cannot all lie in a two-element set | correct pigeonhole, but it never mentions an operator or a spectrum |
| cp3_multiplicities, lambda2_six | $6+8+1=15=6\cdot5/2$ | arithmetic only, no $\mathbb{CP}^3$ eigenvalue appears |
| theta0_six_sq, theta0_six_bracket | $2\cdot5\cdot4/36=10/9$, decimal bracket | agrees with §0's derivation from L23 |
| s5s7_traceless, multiplicities, block_split, three_distinct | the §3 trace and counts, distinctness | correct. **The Ricci contractions of §3 are not checked** |
| s5s7_theta_sq, bracket | $2\cdot11\cdot4\cdot6/(10\cdot35)=264/175$ | arithmetic of an unsourced formula |
| withdrawn_theta_sq_bracket, witnesses_distinct | decimal bracket of $6/5$, three distinct rationals | arithmetic |

- **The docstring overclaims.** "The mechanism and both surviving witnesses are arithmetic and are checked here" and "Either survivor proves the lemma alone, and both check exactly" go beyond the file. Criticality, $\theta$, gradedness, the Weyl conditions and the identification of eigenvalues with the named manifolds are not checked, and the header itself says gradedness "stays imported".
- The file does not record the §6 contradiction at $r=31$.

**Verdict:** CONFIRMED AS ALGEBRA.

## 10. Numerical entries (attack item 7)

| entry | where | form |
|---|---|---|
| $\theta_0(6)$ | A, B, D | closed form via L23, $\sqrt{10/9}$, printed as decimal $1.054092553$ |
| $\sqrt{6/5}$, $\sqrt{3/2}$ | A, B, D | closed form, with decimals $1.095445115$ and $1.2247449$ in B |
| $-\tfrac74,-\tfrac56,1$ and $10,21,35$ | A | closed form, checked in §3 |
| $\tfrac5{24},0,-\tfrac18$ and $3,7,5$ | B | closed form |
| $6,8,1$ | A | closed form multiplicities, no eigenvalues |
| $\theta(S^5\times S^7)=1.2282390$ / $1.228239$ | A, B, D | **decimal only** on the record |
| family value $1.2742878$ | B, D | **decimal only**. Its closed form $\sqrt{341/210}$ lies above L23's cap (§6) |
| $S=2\times10^{-30}$ for $\mathbb{CP}^3$ | B | **numerical slack**, carried as the gradedness evidence |
| $S=0$ for $(\mathfrak{su}(3),\mathfrak{so}(3))$ | B | exact value of an undefined quantity |

## 11. The boundary (attack item 8, standing item 3)

- **$r=0$ or $r=N$:** $\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}=0$, one eigenvalue, no unit multiple. Excluded by $0<r<N$ and not needed by the exclusion (§1).
- **$\ker W\ne0$:** every Casimir with $0<r<N$, $c\ne0$ has trivial kernel (§1), so $W_{\mathbb{CP}^2}$ ($\ker=3$) and the withdrawn row ($\ker=7$) are outside the family on that ground alone. Under Passage F, a nonzero kernel is exactly what separates (C) from (A).
- **$n=4$:** $N=6$, cap $r\le2$, $\theta_0(4)^2=\tfrac34$. $W_{\mathbb{CP}^2}$ claims $\theta^2=\tfrac32$, twice the cap. This is the only row that would show the cap fails for graded points. It is absent from C and D.
- **$n=6$:** $N=15$, cap $r\le6$, attained at $\mathfrak{so}(3)\oplus\mathfrak{so}(3)$ with $\theta_0(6)^2=\tfrac{10}9$. $\mathbb{CP}^3$ claims exactly this value, so at $n=6$ it ties the family maximum rather than running "past every threshold" (Passage B line 156). The withdrawn row claims $\tfrac65>\tfrac{10}9$.
- **$n=12$:** cap $r\le30$. The isotropy $r=31$ is past it (§6).

## 12. Falsifying objects and the search (standing item 7)

| claim | falsifier | search |
|---|---|---|
| 1 | an operator $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with three eigenvalues | impossible by the two-block form, §1 |
| 2 | a proof that $W_{\mathbb{CP}^3}$ is not critical, not graded in one sense, or has a kernel | Kähler block screen and invariant-line screen, §4.1. None found |
| 3a | a violated Weyl condition or a coincident eigenvalue | trace, both Ricci contractions and Bianchi checked exactly, §3. None |
| 3b | non-criticality or non-(C)-gradedness of $S^5\times S^7$ | invariant-line screen, §3. None found |
| 4 | $W_{\mathbb{CP}^2}$ non-critical, or $\theta\ne\sqrt{3/2}$ | nothing on the brief to test. Debt |
| 5 | a named sense in which $S=0$ and $\ker=7$ imply gradedness, or a proof of non-gradedness | §5. Neither on file |
| 6 | the canon's graded $(\mathfrak{su}(3),\mathfrak{so}(3))$ against A's "no", and a family point at $r=31$, $n=12$ | found, $S_{\mathfrak{mmm}}=-70/3$ |
| 7 | $\theta(S^5\times S^7)\le\sqrt{3/2}$ | the Lean closed form gives $528>525$, but that form is unsourced |
| 8 | a graded point outside L69's scope | $W_{\mathbb{CP}^2}$, $n=4$, $\ker\ne0$ |
| 9 | a Lean theorem whose statement differs from its docstring | the docstring's "both witnesses checked" against the arithmetic content |

## Overall verdict

**HYPOTHESIS-DEBT.**

- The exclusion half of L58 is proven for every $\mathfrak h$ with no hypothesis beyond $c\ne0$.
- The existence half ("the graded set is strictly wider") needs at least one witness argued to be critical and graded in a named sense. The record carries none: $\mathbb{CP}^3$'s gradedness rests on a numerical slack or a bare "yes", and $S^5\times S^7$'s criticality and $\theta$ on a decimal and an unsourced Lean formula. $W_{\mathbb{CP}^2}$ has no argument on the cited lines.
- Independently, the canon (results.md lines 192 and 669) is **refuted as stated**. It lists the withdrawn $(\mathfrak{su}(3),\mathfrak{so}(3))$ row as graded, and it cites a "family value" at $r=31$, $n=12$, where L23's slack is $-70/3$ and no family point exists.
