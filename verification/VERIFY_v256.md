# Verifier v256, Lemma L58: the Casimir two-eigenvalue step, the four witness rows (CP^3, S^5 x S^7, W_CP2, the withdrawn (su(3),so(3))), the canon against the block, the threshold sentence and the consequence for L23

The brief was read cold. No numerical work was done: no scripts, no computations, every value below is exact and every comparison is integer arithmetic by hand. Decimals in the record are treated as evidence of nothing and are not reproduced. Log: [agent_logs/verify-L58-v256.log](../agent_logs/verify-L58-v256.log).

| # | claim | passages | verdict |
|---|---|---|---|
| 1 | A Casimir $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$, $0<r<N$, has exactly two eigenvalues, so three distinct eigenvalues exclude every subalgebra at once | A, B, C, D | CONFIRMED |
| 2 | $\mathbb{CP}^3$ at $n=6$ is a graded critical point at $\theta_0(6)$ with three distinct eigenvalues | A, B, C, D | HYPOTHESIS-DEBT |
| 3 | $S^5\times S^7$ at $n=12$ is a pair-graded critical point with three eigenvalues $-\tfrac74,-\tfrac56,1$ at multiplicities $10,21,35$ | A, B, C, D | HYPOTHESIS-DEBT |
| 4 | $W_{\mathbb{CP}^2}$ at $n=4$ is graded, critical at $\sqrt{3/2}$, and not a Casimir | A, B | HYPOTHESIS-DEBT |
| 5 | $(\mathfrak{su}(3),\mathfrak{so}(3))$ at $\sqrt{6/5}$ is graded and outside the family (carried by C and D, withdrawn by A) | A, B, C, D | HYPOTHESIS-DEBT |
| 6 | Passage D: "whose family value there is $1.2742878$" at $r=31$, $n=12$ | B, D | REFUTED AS STATED |
| 7 | The canon (C, D) states the block (A) | A, C, D | GAP |
| 8 | "Since $S^5\times S^7$ sits above $\thstar$, restricting the family by a value threshold does not recover it" | A | CONFIRMED AS ALGEBRA |
| 9 | "at every threshold", "no threshold repairs it" | B | HYPOTHESIS-DEBT |
| 10 | Consequence: L23's cap is a statement about the family, and the graded case needs L69's classification instead | D | GAP |
| 11 | [L58.lean](../lean/HamiltonsCubic/Results/L58.lean) checks what it claims | Lean | CONFIRMED AS ALGEBRA |

**Summary.** The mechanism is proven and correct, but no witness the canon names has all three of gradedness, criticality and three distinct eigenvalues argued on file: the spectra are asserted, the $(\mathfrak{su}(3),\mathfrak{so}(3))$ row is graded in no established sense, and Passage D's $S^5\times S^7$ clause rests on a "family value" at an $r$ where L23 admits no family point.

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $N=\binom n2$. A critical point is a unit $W$ with $Q(W)=\theta W$.
- The subalgebra family of L23 (Passage E) is the set of unit $W_{\mathfrak h}\propto\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id}$ with $\mathfrak h$ a subalgebra, $0<r<N$, and $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$.
- $\theta_0(n)^2=2(n-1)(n-2)/n^2$, as used in [L58.lean](../lean/HamiltonsCubic/Results/L58.lean) and consistent with L23's formula at $r=n(n-2)/4$.
- The three senses of "graded" are those of [graded-half.md](../findings/graded-half.md) lines 317-323. (C) pair-graded: $W$ is the $\mathrm{ad}(\mathfrak p)$-invariant Weyl tensor of a symmetric pair. (A) sign-graded: $E_+(W)\oplus E_-(W)=\mathfrak{so}(n)$, equivalently $\ker W=0$, with the $\mathbb Z_2$ bracket relations. (B) slice-graded: $[W,\Lambda^2\sigma]=0$ for some involution $\sigma$.
- "On file" means an argument written in the quoted passages or in the statement of a result they cite. A check of my own that the record does not carry is labelled a screen and discharges nothing.
- Quotations: every passage of the brief matches its source lines verbatim, except that relative link targets in Passages E and F are rewritten with a leading `../` (the source reads [findings/bounds.md](../findings/bounds.md) from [results.md](../results.md)). No finding.

## Hypothesis inventory

| hypothesis | where stated | used by | status |
|---|---|---|---|
| $0<r<N$ | A, B, D, E | "exactly two" | Stated. Omitted in C, harmless there since C speaks of family members, which carry it through E |
| $c\ne0$ | nowhere | "exactly two" (the gap between the eigenvalues is $c$) | Used, unstated. Implied by unit norm. The exclusion itself needs no hypothesis |
| $\mathfrak h$ a subalgebra | E | nothing in the mechanism | The mechanism is spectral and holds for every subspace $\mathfrak h$ |
| $Q(W_{\mathfrak h})=\theta W_{\mathfrak h}$ | E | defining the family, the formula $\theta=\frac2n\sqrt{rN/(N-r)}$ and the cap $r\le n(n-2)/4$ | Used by B and D at $r=31$, $n=12$, where it fails (section 6) |
| each witness lies in $\mathcal W_n$ and is critical | asserted in A, B ("critical") | every witness row | Imported. On file for $\mathbb{CP}^m$ via L10's closed form and for pair-graded points via L69's statement. For the $(\mathfrak{su}(3),\mathfrak{so}(3))$ point only a numerical residual is on file |
| sense of "graded" per witness | A for $\mathbb{CP}^3$ (all three) and $S^5\times S^7$ ((C)). Unstated for $W_{\mathbb{CP}^2}$ in A and for every witness in B, C, D | the conclusion "graded set wider" | Passage F warns that a claim in one sense does not transfer |
| L69: $n\ge12$, equivariant pair-graded, $\ker W=0$, $n\ne8$, $\theta\ge\sqrt{3/2}$, Cartan's classification | L69's statement ([results.md](../results.md) line 675) | D's consequence | None of these scope conditions appears in D |
| normalisation and sign of listed eigenvalues | nowhere | A's $S^5\times S^7$ values, B's Jensen values | Used projectively, scale unstated (section 3, withdrawn candidate) |

## 1. The Casimir step

**Derivation.** Take $\Pi_{\mathfrak h}$ as the orthogonal projection onto an $r$-dimensional $\mathfrak h\subseteq\Lambda^2\mathbb R^n$. On $\mathfrak h$ it acts as $1$ and on $\mathfrak h^\perp$ as $0$. So $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ acts as $c(1-\tfrac rN)$ on $\mathfrak h$ (dimension $r$) and as $-c\tfrac rN$ on $\mathfrak h^\perp$ (dimension $N-r$). For $0<r<N$ both eigenspaces are nonzero, and the two values differ by exactly $c$. Hence for $c\ne0$ the spectrum is exactly two values, as A, B and D state, with the values they state. The trace is $rc(1-\tfrac rN)-(N-r)c\tfrac rN=0$.

**The exclusion.** The spectrum of every such operator is a subset of two values, for every $c$, every $r$ (including $r=0,N$, where the operator is $0$) and every subspace $\mathfrak h$. A spectrum of three pairwise distinct values is not a subset of a two-element set. So "three or more distinct eigenvalues excludes every Casimir" needs nothing about $\mathfrak h$: not the subalgebra property, not criticality, not $0<r<N$, not $c\ne0$. Conjugation by $O(n)$ and the sign of the unit multiple preserve the count.

**A consequence used silently in section 4.** For $0<r<N$ and $c\ne0$ neither eigenvalue is $0$, so every family member has $\ker W=0$. This is immediate from the step's own values, but the block never writes it.

Verdict: CONFIRMED.

## 2. The $\mathbb{CP}^3$ witness, $n=6$

**On file.**
- $\theta=\theta_0(6)$: L10 ([graded-half.md](../findings/graded-half.md) line 504 onward) gives $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, which is $\tfrac{10}9$ at $m=3$, and $\theta_0(6)^2=\tfrac{40}{36}=\tfrac{10}9$. Exact and on file.
- Pair-graded (C): L69's statement reads "at a $\mathfrak u(m)$ pair the unique invariant is $\mathbb{CP}^m$", and $\mathbb{CP}^3$ is the $(\mathfrak{so}(6),\mathfrak u(3))$ point ([graded-half.md](../findings/graded-half.md) line 115 notes that the dimensions agree exactly at $m=3$). Imported, on file.
- (B) follows from (C) by the record's stated implication.

**Not on file.**
- **(A) sign-graded and $\ker W=0$.** Passage A asserts "all three senses; $\ker W=0$". The graded-half table and line 335 repeat the assertion with no derivation. Passage B's cell is "$S=2\times10^{-30}$", a numerical slack, and the source's own line 176 says a vanishing slack "certifies a $\mathbb Z_2$-grading only inside the subalgebra family", which $\mathbb{CP}^3$ is claimed to lie outside.
- **Three distinct eigenvalues.** A gives multiplicities $6,8,1$ and no values. B and D say "three eigenvalues" and give no values. The nearest thing on file is Petersen–Stanfield Prop 2.2 as cited at [graded-half.md](../findings/graded-half.md) line 113, which separates the centre's eigenvalue from $\mathfrak{su}(m)$'s. That leaves room for the $\mathfrak m$ eigenvalue to equal one of them, which would give a two-value spectrum on dimensions $7,8$ or $14,1$. A two-value spectrum is not excluded by the step of section 1, so Prop 2.2 does not supply three.

**What would have to be proved.** The $(\mathfrak{so}(6),\mathfrak u(3))$-invariant Weyl operator acts by three pairwise distinct scalars on $\mathbb R\omega$, $\mathfrak{su}(3)$ and $\mathfrak m$, and it has no zero among them (for (A)). Then the $\mathbb Z_2$ relations for $E_\pm$.

**Screen (not the record's argument, discharges nothing).** For Fubini–Study with holomorphic sectional curvature $4$ the curvature operator is $8$ on $\omega$, $2$ on $\Lambda^{1,1}_0$ and $0$ on $[\![\Lambda^{2,0}]\!]$, and $\mathrm{scal}/(n(n-1))=\tfrac85$. So $W$ is $\tfrac{32}5,\tfrac25,-\tfrac85$ at multiplicities $1,8,6$: three distinct values, trace $0$, no kernel, consistent with A. No falsifier was found.

Verdict: HYPOTHESIS-DEBT (the spectrum and sense (A) are asserted, not derived).

## 3. The $S^5\times S^7$ witness, $n=12$

**On file.**
- $\theta^2=\tfrac{264}{175}$: [L58.lean](../lean/HamiltonsCubic/Results/L58.lean) evaluates the sphere-product closed form $2(n-1)(p-1)(q-1)/((n-2)pq)$ at $(12,5,7)$, and [results.md](../results.md) line 479 records that L69's ideal-wise system reproduces $\tfrac{264}{175}$. Passages A, B and D print only a decimal.
- Pair-graded (C) and critical: L69's statement, "at an $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ pair the $\mathrm{ad}(\mathfrak p)$-commutant in $\mathcal W_n$ is one-dimensional, so the equivariant point is the sphere product". Imported, on file. The source's line 176 relies on this: "a symmetric pair and graded with nothing owed".
- Trace $0$ of the listed values: $10(-\tfrac74)+21(-\tfrac56)+35=-\tfrac{35}2-\tfrac{35}2+35=0$. Multiplicities $10+21+35=66=N$, split as $\binom52,\binom72,5\cdot7$. Correct.

**Not on file.** The values $-\tfrac74,-\tfrac56,1$ are printed with no derivation. [L58.lean](../lean/HamiltonsCubic/Results/L58.lean) says so itself: "a decomposition the block prints as three numbers without saying where they come from". B's and D's non-Casimir argument for this row is a different one, the comparison with "the family's $\theta$ at $r=31$", and section 6 shows it compares against no family point.

**What would have to be proved.** The $\mathrm{ad}(\mathfrak{so}(5)\oplus\mathfrak{so}(7))$-invariant Weyl operator acts by pairwise distinct scalars on $\mathfrak{so}(5)$, $\mathfrak{so}(7)$ and $\mathbb R^5\otimes\mathbb R^7$.

**Screen (discharges nothing).** Invariance makes $W$ a scalar $a,b,c$ on the three blocks. Ricci-flatness at $e_i\in\mathbb R^5$ reads $4a+7c=0$, and at $e_j\in\mathbb R^7$ it reads $6b+5c=0$. So $(a,b,c)=c(-\tfrac74,-\tfrac56,1)$, exactly A's values at $c=1$, pairwise distinct for $c\ne0$. No falsifier was found.

### 3.1 Withdrawn candidate: the sign of the listed eigenvalues

1. **Location.** Line 334, "three eigenvalues, $-\tfrac74$, $-\tfrac56$, $1$", in the same row as $\theta=1.2282390>0$.
2. **Closed form.** For an Einstein locally symmetric metric with $\mathrm{Ric}=\lambda g$, the homothetic Ricci flow gives $\mathcal R^2+\mathcal R^\#=\lambda\mathcal R$. With $\mathcal R=W+\mu\mathrm{Id}$, $\mu=\lambda/(n-1)$, $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ and $\mathrm{Id}\#W=-W$, this gives $W^2+W^\#=\lambda W$. That normalisation reproduces the record's $W_{\mathbb{CP}^2}=\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ at $+\sqrt{3/2}$ ([report/sections/03-setup.tex](../report/sections/03-setup.tex) line 23) and $\theta_0(6)$ at $S^3\times S^3$. At $S^5\times S^7$ with $\lambda=1$ the curvatures are $\tfrac14$ and $\tfrac16$ and $\mu=\tfrac1{11}$, so $W=(\tfrac7{44},\tfrac5{66},-\tfrac1{11})$, which is $-\tfrac1{11}$ times A's list. The listed operator therefore has $\theta<0$.
3. **Charitable reading.** The row's use of the values is projective: "three eigenvalues" and "trace $0$" are invariant under any nonzero rescaling, sign included. By the screen above, the list is the commutant generator at $c=1$, not the unit critical representative. Row 3 claims only (C), which is sign-free, so no sense is misassigned. **Withdrawn.** It is worth a normalisation note: read under sense (A), the printed sign would make $E_+$ the $35$-dimensional block, which is not a subalgebra.

Verdict: HYPOTHESIS-DEBT (the spectrum is asserted, not derived).

## 4. The $W_{\mathbb{CP}^2}$ row, $n=4$

- **Critical at $\sqrt{3/2}$.** L10 at $m=2$ gives $\tfrac32$, on file.
- **Graded.** A says "**yes**" with no sense. On file: (C), from the unique $\mathrm{ad}(\mathfrak u(2))$-invariant tensor ([graded-half.md](../findings/graded-half.md) line 317), and so (B). Passage F's W3 says it is **not** (A), $\ker W=3$ of $6$. So A's unqualified "yes" holds in (C) and (B) and fails in (A).
- **Not a Casimir.** A's "why it is not a Casimir" cell reads "the point that anchors the threshold sentence below, dropped from this table in the move". That is provenance, and it gives no reason. B says "likewise not a Casimir" without a reason. On file elsewhere, and not cited by the block: $\ker W=3$ (Passage F) and the explicit $\mathrm{diag}(0,0,0,-1,-1,2)/\sqrt6$ in the report, three distinct values. The link "nonzero kernel, therefore not a Casimir" is one line from section 1, but the block does not write it.
- **"The threshold sentence below"** (line 343) mentions $S^5\times S^7$ and $\thstar$, and does not mention $W_{\mathbb{CP}^2}$.
- **Also unwritten.** L23's cap alone excludes the point from the family: $\theta_0(4)^2=\tfrac34<\tfrac32$.

What would have to be proved: that $W_{\mathbb{CP}^2}$ is not of Casimir form, by its spectrum or its kernel, written against the row. Verdict: HYPOTHESIS-DEBT (the reason cell is empty, and the sense of "graded" is unstated where (A) fails).

## 5. The $(\mathfrak{su}(3),\mathfrak{so}(3))$ row, and attack item 3

**What is on file.**
- $\theta=\sqrt{6/5}$, and a spectrum $\tfrac5{24},0,-\tfrac18$ at multiplicities $3,7,5$ (trace $\tfrac58-\tfrac58=0$).
- "Critical: residual $3\times10^{-16}$" (line 172), a numerical value that is evidence of nothing.
- "$S=0$ **only**" (B), and line 176: "calling that point graded outright overstates what was measured".
- A withdraws it: "graded? **no**".
- **C and D still assert it is graded.**

**Does $S=0$ with a $7$-dimensional kernel establish gradedness in any sense? No.**
- (A) is excluded **by definition**. (A) requires $E_+\oplus E_-=\mathfrak{so}(6)$, equivalently $\ker W=0$, and here $\dim\ker W=7$. The record's labelling table ([graded-half.md](../findings/graded-half.md) line 431) calls the slack screen "vacuous wherever $\ker W\ne0$", so $S=0$ carries no information here.
- (C) is not established. No symmetric pair $(\mathfrak{so}(6),\mathfrak k)$ is named whose invariant this is. The pair $(\mathfrak{su}(3),\mathfrak{so}(3))$ of line 166 is a symmetric pair of $\mathfrak{su}(3)$, and $\mathfrak{su}(3)$ is not the fixed algebra of an involution of $\mathfrak{so}(6)$ ($\mathfrak u(3)$ is). The source argues against (C) at line 174 ("Not a symmetric space"), via L69's identification of pair-graded points with Weyl operators of compact symmetric spaces. That line lists only $S^6,\mathbb{CP}^3,Q_3$ and omits the reducible six-dimensional symmetric spaces, a gap in line 174, which is not load-bearing for L58.
- (B) is neither established nor excluded. No involution $\sigma$ with $[W,\Lambda^2\sigma]=0$ is exhibited or ruled out.

Consequences:
- Passage A's "**no**" is supported in (A), argued with a gap in (C), and open in (B).
- Passages C and D's "graded and outside it" for this witness has no argument in any sense.
- "Outside the family" is on file twice, by the cap (line 178: $\theta_0(6)^2=\tfrac{10}9<\tfrac65$, since $50<54$) and by the nonzero kernel.

### 5.1 Withdrawn candidate: "equivalently a $7$-dimensional kernel"

1. **Location.** Passage B's row: "three eigenvalues $\tfrac5{24},0,-\tfrac18$ at multiplicities $3,7,5$; equivalently a $7$-dimensional kernel".
2. **Closed form.** The two are not equivalent. For nonzero traceless $W$, a nonzero kernel implies at least three distinct eigenvalues (a kernel plus one nonzero value contradicts trace $0$), but it does not determine $\dim\ker=7$ or the listed values. Conversely, three distinct eigenvalues need no zero.
3. **Charitable reading.** "Equivalently" is meant as "equally sufficient for the exclusion", and the kernel does exclude the point from the family by section 1. **Withdrawn**, as wording.

What would have to be proved for C and D: an involution $\sigma$ with $[W,\Lambda^2\sigma]=0$ (for (B)) or a symmetric pair of $\mathfrak{so}(6)$ with this invariant (for (C)). Otherwise the witness must leave C and D, as it has left A. Verdict: HYPOTHESIS-DEBT.

## 6. Passage D's "whose family value there is $1.2742878$"

1. **Location.** Passage D: "$S^5\times S^7$ at $n=12$ with $\theta=1.228239$, whose isotropy $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ has $r=31$ and whose family value there is $1.2742878$". Passage B, row 3, says the same.
2. **Closed form.** L23 (Passage E) proves that every family member satisfies $r\le n(n-2)/4$, which is $30$ at $n=12$. So the family has no point at $r=31$. The number is L23's formula evaluated outside its hypothesis: $\theta^2=\tfrac1{36}\cdot\tfrac{31\cdot66}{35}=\tfrac{341}{210}$. This exceeds $\theta_0(12)^2=\tfrac{55}{36}$, since $341\cdot36=12276>11550=55\cdot210$, and so contradicts L23's cap. Independently, $W_{\mathfrak h}$ for $\mathfrak h=\mathfrak{so}(5)\oplus\mathfrak{so}(7)$ lies outside $\mathcal W_{12}$: $\mathrm{Ric}(\Pi_{\mathfrak h})=\mathrm{diag}(4\,I_5,6\,I_7)$ and $\mathrm{Ric}(\tfrac{31}{66}\mathrm{Id})=\tfrac{31}6 I_{12}$, so $\mathrm{Ric}(W_{\mathfrak h})\propto\mathrm{diag}(-\tfrac76 I_5,\tfrac56 I_7)\ne0$.
3. **Charitable reading.** "Family value" means "what the family formula would give at this $r$", offered to show that $S^5\times S^7$ is not its own isotropy's Casimir. Under that reading the comparison is vacuous, because that Casimir is not a Weyl operator and is not critical. It is also insufficient, because it compares against one subalgebra only, while membership in the family requires excluding every $\mathfrak h$. D carries no eigenvalue count for this row, so D's "outside it" for $S^5\times S^7$ rests on this comparison alone. **Survives.**

Verdict: REFUTED AS STATED. Row 3 of A replaces the comparison with an eigenvalue list, which section 3 grades as debt.

## 7. The canon against the block (attack item 4)

| witness | A (block) | B (argument) | C (landscape) | D (detail) |
|---|---|---|---|---|
| $\mathbb{CP}^3$ | graded, all three senses, multiplicities $6,8,1$ | "$S=2\times10^{-30}$", three eigenvalues | graded | graded, three eigenvalues |
| $(\mathfrak{su}(3),\mathfrak{so}(3))$ | **withdrawn**, not graded | "$S=0$ only" | **graded** | **graded**, three eigenvalues |
| $S^5\times S^7$ | pair-graded, values $-\tfrac74,-\tfrac56,1$ | symmetric pair, $r=31$ comparison | graded | graded, $r=31$ "family value" |
| $W_{\mathbb{CP}^2}$ | graded, no sense, no reason | "graded, critical, not a Casimir" | absent | absent |

- The canon lags the block. C and D keep a witness A withdraws, omit the one A adds, and D keeps the $r=31$ comparison A replaced.
- No canonical statement names the sense of "graded", against Passage F's warning.
- C's heading, "the graded set is strictly wider", drops "critical", which the body restores.

Verdict: GAP.

## 8. "Since $S^5\times S^7$ sits *above* $\thstar$" (attack item 5)

- **Definition.** $\thstar$ is defined in none of Passages A–F. In the markdown it is an undefined LaTeX macro (a repository search finds no macro file for it). The report defines $\thstar:=\sqrt{3/2}$ ([report/sections/03-setup.tex](../report/sections/03-setup.tex) line 23), and Passage B uses $\sqrt{3/2}$ as the threshold.
- **The inequality.** With that reading, $\tfrac{264}{175}>\tfrac32$ holds exactly, since $528>525$.
- **The sentence as written.** "Restricting the family by a value threshold does not recover it" is true for a trivial reason: a subset of the family contains no non-member. The intended content, that "the family exhausts the graded critical points with $\theta>\thstar$" is false, holds by the same inequality, given row 3's gradedness, criticality and non-Casimir status (sections 3 and 6).
- **The value.** A prints $S^5\times S^7$'s $\theta$ as a decimal. The closed form $\tfrac{264}{175}$ is only in the Lean file and at L69.

Verdict: CONFIRMED AS ALGEBRA, conditional on row 3, with $\thstar$ undefined in the block.

## 9. "At every threshold", "no threshold repairs it" (Passage B)

1. **Location.** B's heading, "strictly wider than the subalgebra family, at every threshold", and "no threshold repairs it", "A proof of (H) cannot classify subalgebras alone at any threshold".
2. **The gap.** The witnesses on file have $\theta^2\in\{\tfrac{10}9,\tfrac32,\tfrac{264}{175}\}$. For a threshold $t$ with $t^2\ge\tfrac{264}{175}$, no graded non-Casimir critical point above $t$ is exhibited. The source's line 180 asserts that every unbalanced $S^p\times S^q$ is off the family, "because the family's $\theta$ depends on $\mathfrak h$ through $\dim\mathfrak h$ alone while the product's depends on the partition". Different functional dependence does not show that the values differ at a given point, so that is no argument.
3. **Charitable reading.** "Every threshold the question can carry" means thresholds up to the ones (H) uses, $\sqrt{3/2}$ and $\theta_0(n)$. At $\sqrt{3/2}$ the claim holds by $S^5\times S^7$, and at $\theta_0(12)$ it has no witness ($\tfrac{264}{175}<\tfrac{55}{36}$, since $9504<9625$). The reading does not rescue "every". **Survives, as debt.**

- **Scope.** The canon (C, D) does not carry the phrase. [report/sections/06-shape.tex](../report/sections/06-shape.tex) line 40 does ("above every threshold (Lemma 58)").
- **What would have to be proved.** For every $t$ below the supremum of $\theta$ over graded critical points, a graded critical point above $t$ with three distinct eigenvalues.

Verdict: HYPOTHESIS-DEBT.

## 10. The consequence in Passage D (attack item 6)

- **"L23's cap at $\theta_0(n)$ is a statement about the family".** True by L23's hypotheses (Passage E), with no witness needed. Confirmed.
- **What D's witnesses show.** They show only that graded points exist off the family. None of D's witnesses exceeds the cap: $\mathbb{CP}^3$ equals $\theta_0(6)$, and $S^5\times S^7$ lies below $\theta_0(12)$ (section 9). The witness that does exceed the cap for graded points, $W_{\mathbb{CP}^2}$ ($\tfrac32>\tfrac34$), is absent from D.
- **"The graded case needs Lemma L69's classification instead".** L69 as stated reaches only the equivariant pair-graded points with $\ker W=0$, $n\ne8$, $n\ge12$ and $\theta\ge\sqrt{3/2}$, and it rests on Cartan's classification, which [references/](../references/) does not hold. It does not reach (A)-only or (B)-only graded points, $n<12$, $n=8$, or kernels. So "the graded case" is wider than what L69 classifies.
- **What would have to be proved.** A classification of graded critical points in the sense the downstream use needs, or D restricted to L69's scope.

Verdict: GAP.

## 11. The Lean file (standing item 5)

[L58.lean](../lean/HamiltonsCubic/Results/L58.lean) was read, and not built.

**What it proves** (arithmetic over $\mathbb Q$ and $\mathbb N$):
- The two Casimir values differ by $c$, and the Casimir trace is zero.
- Three pairwise distinct rationals cannot each equal one of two values (`three_excludes`, sound).
- The sums $6+8+1=15$ and $10+21+35=66$, and the block split $10,21,35$.
- $\theta_0(6)^2=\tfrac{10}9$ and $\tfrac{264}{175}$ as typed closed forms.
- Decimal brackets, and the pairwise distinctness of $\tfrac{10}9,\tfrac{264}{175},\tfrac32$.

**What it does not check:**
- that any listed number is an eigenvalue of any operator (no operator is built)
- criticality
- gradedness (the docstring says so)
- that $\mathbb{CP}^3$ has three distinct eigenvalues (only its multiplicities sum to $15$, which is compatible with two values)
- the closed forms themselves, which are typed in as definitions.

**Overstatements.**
- The docstring's "Either survivor proves the lemma alone, and both check exactly" claims more than the file checks.
- The docstring's "both surviving witnesses" disagrees with `witnesses_distinct`'s "three surviving witnesses".
- The decimal brackets bracket decimals that carry no evidential weight.

Verdict: CONFIRMED AS ALGEBRA.

## 12. Standing items 1–4 and 7, and attack items 7–8

**1. Hypothesis inventory.** See the table above. Used but unstated: $c\ne0$, criticality and $\mathcal W_n$-membership of each witness, the sense of "graded" in B, C and D, and the normalisation of eigenvalue lists.

**2. Quantifier order and scope.** "No graded critical point with three or more eigenvalues lies in the family" is $\forall W$ with a spectral hypothesis only, and it is correct. "The graded set is strictly wider" is $\exists W$ and needs one fully argued witness (sections 2–5 find none fully on file). Senses per witness:

| witness | sense claimed | sense on file |
|---|---|---|
| $\mathbb{CP}^3$ | all three (A) | (C) and (B) |
| $S^5\times S^7$ | (C) (A) | (C) and (B) |
| $W_{\mathbb{CP}^2}$ | unstated | (C) and (B), and not (A) |
| $(\mathfrak{su}(3),\mathfrak{so}(3))$ | graded (C, D), not graded (A) | none |

B's "at every threshold" puts $\forall t$ before $\exists W$ and is supported only for $t^2<\tfrac{264}{175}$.

**3 and attack item 8. Edges.**
- **$n=4$.** $W_{\mathbb{CP}^2}$ is (C) and not (A). It lies outside the family by the cap ($\tfrac34<\tfrac32$) and by its kernel, and neither is written. L69 does not reach $n=4$.
- **$n=6$.** $\mathbb{CP}^3$ shares $\theta_0(6)$ with $S^3\times S^3$, the cap's equality case, so only the spectrum can separate them. That is the link held as debt in section 2. The Jensen point is excluded by the cap on file (line 178).
- **$\ker W\ne0$.** Every family member has $\ker W=0$ (section 1), so a nonzero traceless $W$ with a kernel lies outside the family automatically. Sense (A) is vacuous there (Jensen, $W_{\mathbb{CP}^2}$).
- **$r=0$ or $N$.** $W_{\mathfrak h}=0$, which cannot be normalised and is not in the family. "Exactly two" fails there (one eigenvalue), and the exclusion is unaffected. C omits $0<r<N$ (section 1 inventory, harmless).

**4. Proven against stated.**
- Proven: the spectral exclusion.
- Stated but not proven: every witness's three-eigenvalue claim; $\mathbb{CP}^3$'s (A); the Jensen point's gradedness (C, D); "every threshold" (B); L69 covering "the graded case" (D).
- Stated and false: D's family value at $r=31$.

**Attack item 7. Numerical entries.**
- Closed form: $\sqrt{3/2}$, $\sqrt{6/5}$, $\theta_0(6)$ (with $\tfrac{10}9$ via L10), $-\tfrac74,-\tfrac56,1$, $\tfrac5{24},0,-\tfrac18$, and all multiplicities.
- Decimal only in A, B and D: $S^5\times S^7$'s $1.2282390$ / $1.228239$ (closed form $\tfrac{264}{175}$ only in the Lean file and at L69) and the "family value" $1.2742878$ (closed form $\tfrac{341}{210}$, nowhere on file).
- Decimal alongside a closed form: $1.054092553$, $1.095445115$, $1.2247449$.
- Numerical slack: $S=2\times10^{-30}$ for $\mathbb{CP}^3$ (B), which is B's only gradedness entry for that row.
- Numerical residual: $3\times10^{-16}$ for the Jensen point's criticality (line 172), its only criticality argument.

**7. Falsifiers sought.**

| claim | falsifying object | what I did |
|---|---|---|
| Casimir step | an operator $c(\Pi_{\mathfrak h}-\tfrac rN\mathrm{Id})$ with three distinct eigenvalues | Derived its spectrum for every $\mathfrak h,r,c$ in closed form. None exists |
| $\mathbb{CP}^3$ row | a coincidence among its three block scalars, or a zero one | Exact Fubini–Study screen ($\tfrac{32}5,\tfrac25,-\tfrac85$). None found |
| $S^5\times S^7$ row | an invariant Weyl operator with two equal block scalars | Solved the Ricci conditions exactly. None exists at $c\ne0$. Found the sign normalisation (withdrawn) |
| $W_{\mathbb{CP}^2}$ row | a Casimir with a kernel | Section 1 shows none exists |
| Jensen gradedness | an involution $\sigma$ commuting with $W$ (would confirm (B)) or its impossibility (would refute) | Neither is on file. (A) is refuted by definition |
| D's $r=31$ clause | a family point at $n=12$, $r=31$ | L23's cap excludes it. $W_{\mathfrak h}$ is not Ricci-flat (clause refuted) |
| B's "every threshold" | a threshold with no graded non-Casimir point above it | None on file above $\tfrac{264}{175}$ (debt, not refuted) |
| D's consequence | a graded point outside L69's scope | $W_{\mathbb{CP}^2}$ at $n=4$ ($\ker W=3$, $n<12$) |

## Overall verdict

**HYPOTHESIS-DEBT.**
- **Proven and correct:** the two-eigenvalue mechanism, and its independence from $\mathfrak h$.
- **Debt:** "the graded set is strictly wider" needs one witness whose gradedness, criticality and non-Casimir spectrum are all argued. Every witness the canon names lacks the spectral link on file. $\mathbb{CP}^3$ and $S^5\times S^7$ have (C) and $\theta$ on file, and their spectra are asserted. The $(\mathfrak{su}(3),\mathfrak{so}(3))$ point is graded in no established sense, yet C and D still carry it.
- **Refuted as stated:** D's "family value" at $r=31$ names no family point.
- **Gaps:** the canon lags the block, and D's consequence points to L69 for more than L69 covers.
- **Nearest discharge:** $W_{\mathbb{CP}^2}$ at $n=4$ comes closest, with (C), $\theta=\sqrt{3/2}$ and $\ker W=3$ all on file. The one unwritten line is that a nonzero kernel excludes a Casimir.
