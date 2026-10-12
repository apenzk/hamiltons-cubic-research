# Verifier v310, Lemma L91: the identity Gram lower bound, the solution-set dimension, the tightness reduction, the Delta lead and the Casimir collisions

Cold brief ([BRIEF_L91.md](BRIEF_L91.md)), quotations checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 153, 175 and 189-195 only, all verbatim. No numerical work: every value is exact, no scripts were written or run, and every arithmetic step below is done by hand in the text. Log: [agent_logs/verify-L91-v310.log](../agent_logs/verify-L91-v310.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Heading and bullet 1: the identity Gram gives $\mathrm{rank}\,\mu_K\ge1$ unconditionally | HYPOTHESIS-DEBT |
| 2 | Bullet 2: $36-\mathrm{rank}$ is the solution-set dimension only when the system is consistent, and consistency is $F_5\in\operatorname{im}\mu_K$ | CONFIRMED |
| 3 | Bullet 3, the identity $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$, a space containing $\mathcal A(W_0^6)$ | HYPOTHESIS-DEBT |
| 4 | Bullet 3, the count $14+29-65<0$ and "$13$ holds unless a second coincidence occurs" | HYPOTHESIS-DEBT |
| 5 | $\Delta$ as a lead: psd, invariant, sum of squares, vanishing exactly on the orbit cone, $F_5/\Delta\in[2.50,3.15]$ bounded and positive | HYPOTHESIS-DEBT |
| 6 | The three Casimir collisions at $c=60,40,30$ and the labels of the pairs | CONFIRMED AS ALGEBRA |
| 7 | Blocks $(5,4)$, $(6,2)$, $(5,0)$ die, $(4,1)$ and $(3,3)$ survive, "two of the three collisions vanish" | HYPOTHESIS-DEBT |

**Summary.** Nothing in L91 is false under its most charitable reading, but its one headline claim, $\mathrm{rank}\,\mu_K\ge1$, names no rank and rests on sampled nonvanishing of $\Delta$, and every other claim is either textbook linear algebra, an unwritten identity, a heuristic count, a sample, or an unargued block vanishing.

## 0. Conventions, fixed once

- $\mathcal W_5$: algebraic Weyl tensors on $\mathbb R^5$, $\dim\mathcal W_5=35$, with its $O(5)$-invariant inner product. $W_0\ne0$ the padded Weyl tensor of $\mathbb{CP}^2$.
- $K$: the cubics with $\sigma_\lambda(W_0)=0$, taken as in L90: an $O(5)$-stable subspace of real cubics on $\mathcal W_5$ each vanishing at $W_0$ (this is what L90's cap "a product of two cubics of $K$ vanishes at $W_0$" uses).
- $\langle\cdot,\cdot\rangle$: the apolar inner product on polynomials. $q_1,\dots,q_k$ an apolar-orthonormal basis of $K$.
- Grams: symmetric $k\times k$ matrices $G$, $\mu_K(G)=\sum_{a,b}G_{ab}q_aq_b$. The $36$: the $O(5)$-invariant ones. $V$: the $14$-dimensional space of invariant sextics, the codomain of $\mu_K$ as in L90.
- $\mathrm{rank}\,\mu_K=\dim\operatorname{im}\mu_K\subseteq V$. $\mathrm{rank}(\mathrm{ev}\circ\mu_K)$ is L90's rank at a finite set $S$.
- $L_0=\langle\cdot,W_0\rangle$, so $\mathcal A(W_0^6)$ is read as the sextic $L_0^6$ (up to a nonzero constant), with $\langle P,L_0^6\rangle\propto P(W_0)$ for every sextic $P$. $R$: the Reynolds (Haar average) projection onto invariants.
- Casimir of the $SO(5)$ block with partition label $(\lambda_1,\lambda_2)$: $c=\langle\lambda,\lambda+2\rho\rangle=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$, $\rho=(3/2,1/2)$. Section 6 shows this is the convention the stated values fit.
- Verdicts attach to the written chain in the cited lines. Where I say an argument exists, that answers the brief's question and is not credited to the record.

## Hypothesis inventory

| Hypothesis | Where used | Stated? |
|---|---|---|
| H1. $K$ is $O(5)$-stable | invariance of the identity Gram, "vanishing on the orbit", invariance of $\Delta$ | implicit in "invariant forms on $K$" |
| H2. every $q\in K$ vanishes at $W_0$ | "vanishing on the orbit", $\mathcal A(W_0^6)$ in the annihilator | yes, via L90's definition and cap |
| H3. the apolar inner product on cubics is $O(5)$-invariant ($O(5)$ acts orthogonally on $\mathcal W_5$) | "the identity Gram on $K$ is one of the $36$ invariant forms" | no |
| H4. $K\ne0$ | $\Delta\ne0$, hence the bound $1$ | no, presupposed by "the $36$" and by "a basis of $K$" |
| H5. real coefficients, real points | "psd", "sum of squares" | no |
| H6. $F_5$ is an invariant sextic, $F_5\in V$ | bullet 2 (a system with right side in $V$), $F_5/\Delta$ comparisons | no |
| H7. in bullet 3, $F$ ranges over $V$, not over all sextics | the identity $\mathrm{rank}=14-\dim\{\cdot\}$ | no |
| H8. $\operatorname{im}\mu_K=R(\operatorname{span}K\cdot K)$ and $\langle\cdot,\cdot\rangle$ is nondegenerate and invariant on $V$ | the identity in bullet 3 | no |
| H9. the meaning of $29$ and $65$ | the count $14+29-65$ | no |
| H10. the list of blocks among which "three" collisions occur, and what "them" refers to | Casimir paragraph | not in the cited lines |
| Given L90: cap $\mathrm{rank}\,\mu_K\le13$ (proved), and evaluation at $W_0$ nonzero on $V$ | edges rank $13,14$, the annihilator containing $R(L_0^6)\ne0$ | yes, as given |
| Given L90: $\mathrm{rank}(\mathrm{ev}\circ\mu_K)\ge13$, measured modulo $p$ | not used by L91's bullets, only compared in item 5 | yes, as conditional |

Every use of L90 in L91 matches what L90 states: L91 never uses the measured rank as proved, and its "Tightness is open" matches L90's "conditional on one measured rank".

## 1. Bullet 1 and the heading: the lower bound $1$

**Which rank (attack item 1).** The heading says "gives the unconditional lower bound $1$" and bullet 1 says "Lower bound $1$, unconditionally". Neither names a rank. Passage B names two: $\mathrm{rank}\,\mu_K$ (capped at $13$, proved) and $\mathrm{rank}(\mathrm{ev}\circ\mu_K)$ (measured $\ge13$). The argument offered, a nonzero element $\Delta\in\operatorname{im}\mu_K$, bounds $\mathrm{rank}\,\mu_K$. It bounds $\mathrm{rank}(\mathrm{ev}\circ\mu_K)$ only if $\Delta$ is nonzero at a point of $S$, which is not argued. The rank bounded is $\mathrm{rank}\,\mu_K$, the dimension of $\operatorname{im}\mu_K$ in the $14$-dimensional $V$.

**The written chain, link by link.**

1. "The identity Gram on $K$ is one of the $36$ invariant forms." Correct under H1 and H3: the identity matrix in an orthonormal basis is the matrix of the inner product, and an $O(5)$-invariant inner product on an $O(5)$-stable $K$ is an invariant form. H3 is not stated.
2. "maps to $\Delta=\sum_aq_a^2$." Correct by the definition of $\mu_K$. $\Delta$ is independent of the orthonormal basis, since an orthogonal change of basis preserves $\sum_aq_a^2$.
3. "a sum of squares of cubics of $K$, psd." Correct under H5.
4. "vanishing on the orbit." Correct: for $g\in O(5)$, $q_a(gW_0)=(g^{-1}\cdot q_a)(W_0)=0$ since $g^{-1}\cdot q_a\in K$ (H1) and elements of $K$ vanish at $W_0$ (H2). By homogeneity it vanishes on the orbit cone.
5. "and nonzero ($\Delta/\lVert W\rVert^6\approx0.5$ at random points)." The only support on file is the sampled value. By the brief's rule, a statement supported only by a measurement is HYPOTHESIS-DEBT.
6. $\Delta\ne0$ and $\Delta\in\operatorname{im}\mu_K$ give $\mathrm{rank}\,\mu_K\ge1$. This step is not written but is immediate.

**Attack item 2.** The identity Gram argument proves $\mathrm{rank}\,\mu_K\ge1$ once $\Delta\ne0$ is proved. The parenthetical sample contributes only a numerical indication that $\Delta$ is not the zero polynomial. A two-line argument without sampling exists and is not on file: a real polynomial vanishing at every real point is zero, so $\sum_aq_a^2=0$ forces every $q_a=0$, which contradicts $q_a$ being basis vectors as soon as $K\ne0$ (H4). The same argument shows more: $\mu_K(G)\ne0$ for every nonzero psd $G$.

**What would have to be proved.** $\Delta\ne0$ as a polynomial, which reduces to H4, $K\ne0$. H4 is presupposed by the count $36$ (an invariant symmetric form on the zero space is zero, so $K=0$ gives $0$ forms), but the derivation of $36$ is not in the cited lines.

**"Unconditionally."** The bound needs H4 and H3, neither stated. It is unconditional relative to L90's measured rank, which is the evident intent, and in that sense the word is accurate.

**Edges (item 3).** $K=0$: $\Delta=0$, $\mathrm{rank}\,\mu_K=0$, the bound fails, so H4 is load-bearing. Rank $0$: occurs exactly when $K=0$, by the two-line argument above. Ranks $13$ and $14$: the bound $1$ is compatible with both, and rank $14$ is excluded by L90's cap, not by L91.

**Verdict: HYPOTHESIS-DEBT.** The chain is correct except link 5, whose only support is a sample. The debt is $K\ne0$ plus the sum-of-squares step.

### 1.1 Candidate withdrawn: "the lower bound $1$" as a bound on $\mathrm{rank}(\mathrm{ev}\circ\mu_K)$

1. Locate: line 175, "the unconditional lower bound $1$", with L90's measured quantity $\mathrm{rank}(\mathrm{ev}\circ\mu_K)$ the rank named in Passage B's lower bound.
2. Exhibit: L90's statement allows any finite $S$. Take $S=\{W_0\}$. Every element of $\operatorname{im}\mu_K$ vanishes at $W_0$ (L90's cap), so $\mathrm{ev}\circ\mu_K=0$ and $\mathrm{rank}(\mathrm{ev}\circ\mu_K)=0<1$.
3. Charitable reading: the bound is on $\mathrm{rank}\,\mu_K$, the only rank the identity Gram argument addresses, and the same rank as bullet 3's formula over the $14$. Under that reading the exhibit is irrelevant.

Withdrawn: the charitable reading is the natural one. It is recorded here because the heading leaves the quantity unnamed.

## 2. Bullet 2: the solution-set dimension

**Derivation.** The system is $\mu_K(G)=F_5$ with $G$ in the $36$-dimensional space of invariant Grams. Under H6 the right side lies in $V$. The solution set is empty when $F_5\notin\operatorname{im}\mu_K$. Otherwise it is $G_0+\ker\mu_K$ for any particular solution $G_0$, an affine subspace of dimension $\dim\ker\mu_K=36-\mathrm{rank}\,\mu_K$ by rank-nullity. "Consistent" is then literally "$F_5\in\operatorname{im}\mu_K$", so the second clause is a tautology and correct. It is a necessary condition for any route representing $F_5=\mu_K(G)$.

**Attack item 3, linear, affine, psd.**

- Linear: the homogeneous system $\mu_K(G)=0$ is always consistent with solution space of dimension $36-\mathrm{rank}$.
- Affine: the bullet's statement, correct as above.
- Psd: the set $\{G\succeq0:\mu_K(G)=F_5\}$ is the intersection of that affine space with the psd cone of invariant forms. Its dimension is at most $36-\mathrm{rank}$ and can be strictly smaller. Consistency of the linear system is necessary for a psd solution and not sufficient.
- Which rank: if "the system" is the $40$-point system $\mathrm{ev}\circ\mu_K(G)=\mathrm{ev}(F_5)$, rank-nullity gives $36-\mathrm{rank}(\mathrm{ev}\circ\mu_K)$ for that system. Its solution set contains that of $\mu_K(G)=F_5$ and equals it exactly when the two ranks agree, which is L90's conditional conclusion.

**Edges.** Under L90's proved cap, $36-\mathrm{rank}\ge23$. Under L90 granted, it is exactly $23$.

**Verdict: CONFIRMED** for the affine solution set, which is what the bullet says.

### 2.1 Candidate withdrawn: $36-\mathrm{rank}$ as the dimension of the psd solution set

1. Locate: line 190, "$36-\mathrm{rank}$ is the dimension of the solution set".
2. Exhibit: for right side $0$, the psd solutions are $\ker\mu_K\cap\{G\succeq0\}=\{0\}$, dimension $0$. Proof in closed form: a nonzero psd $G=\sum_i\lambda_iv_iv_i^{\mathsf T}$ with $\lambda_i>0$ maps to $\sum_i\lambda_i\big(\sum_av_{i,a}q_a\big)^2$, a positive combination of squares of nonzero real cubics, hence nonzero. The affine solution set has dimension $36-\mathrm{rank}\ge23$.
3. Charitable reading: the bullet never mentions positivity and speaks of "the system", a linear system. The exhibit uses right side $0$, not $F_5$.

Withdrawn: the bullet is a statement about the linear system. The psd set is bounded above by it, and the route's psd requirement is a separate condition the bullet does not address.

## 3. Bullet 3: the identity $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$

**Attack item 4, which $F$.** $\mathrm{Cat}_F(K,K)=0$ means $\langle qq',F\rangle=0$ for all $q,q'\in K$, that is $F\perp\operatorname{span}(K\cdot K)$. The range of $F$ is not stated (H7).

- **All sextics.** The identity is impossible. Every product $qq'$ with $q,q'\in K$ vanishes to order $2$ at $W_0\ne0$. In coordinates with $W_0$ along $e_1$, the sextics vanishing to order $2$ at $W_0$ are those with zero coefficient on $x_1^6$ and on the $34$ monomials $x_1^5x_j$ ($j\ge2$), a subspace of codimension $35$ (value plus $34$ transverse derivatives, the radial derivative following by Euler's relation), so its annihilator has dimension $35$. Hence $\dim\{F\ \text{all sextics}:\mathrm{Cat}_F(K,K)=0\}\ge35$, and $14-35<0\le\mathrm{rank}$. This reading is excluded.
- **Invariant sextics $V$.** The identity holds if one proves H8: $\operatorname{im}\mu_K=R(\operatorname{span}K\cdot K)$ (the equivariant map $\operatorname{Sym}^2K\to\operatorname{span}K\cdot K$ carries invariants onto invariants for the compact group $O(5)$), and for $F\in V$, $\langle F,P\rangle=\langle F,RP\rangle$ by invariance of the apolar form, so $F\perp K\cdot K$ iff $F\perp\operatorname{im}\mu_K$ inside $V$. Positive definiteness on $V$ then gives dimension $14-\mathrm{rank}\,\mu_K$. None of this is on file.

**"A space containing $\mathcal A(W_0^6)$."** Read literally, $L_0^6$ is not invariant: $\mathcal W_5$ is an irreducible nontrivial $O(5)$-module, so the orbit of $W_0$ spans $\mathcal W_5$ and contains some $gW_0\ne\pm W_0$, and $\langle\cdot,gW_0\rangle^6\ne L_0^6$. So $L_0^6$ lies in the all-sextics annihilator (since $\mathrm{Cat}_{L_0^6}(q,q')\propto q(W_0)q'(W_0)=0$), not in $V$. Its Reynolds image $R(L_0^6)$ lies in the $V$-annihilator, represents evaluation at $W_0$ on $V$, and is nonzero because L90 states that functional is nonzero. That is the reading under which "containing" is right, and it reproduces L90's cap by the same functional.

**Edges.** Rank $14$: excluded, the space contains $R(L_0^6)\ne0$. Rank $13$: exactly when the $V$-annihilator is the line through $R(L_0^6)$. Rank $0$: annihilator all of $V$, which section 1 excludes under H4.

**Verdict: HYPOTHESIS-DEBT.** The identity is asserted without derivation, and the range of $F$ it needs is unstated. What would have to be proved: H7 and H8, with $\mathcal A(W_0^6)$ read as its invariant projection. Under that reading I found no failure.

### 3.1 Candidate withdrawn: the identity is false

1. Locate: line 191, "$\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$, a space containing $\mathcal A(W_0^6)$".
2. Exhibit: over all sextics the space has dimension at least $35$ (above), giving a negative rank. The literal $\mathcal A(W_0^6)$ is a non-invariant sextic, so containment forces the all-sextics reading, which is the failing one.
3. Charitable reading: "$14$" fixes the ambient as $V$, and $\mathcal A(W_0^6)$ is meant as the element of $V$ representing evaluation at $W_0$. Under that reading both halves hold.

Withdrawn: the charitable reading is coherent and consistent with L90. The two halves of the sentence need two different ambients when read literally, and that is recorded in the debt.

## 4. Bullet 3: the count $14+29-65<0$

**Derivation.** $14+29-65=-22<0$ is correct arithmetic. The numbers $29$ and $65$ are not defined in the cited lines (H9), so what is being intersected is not identifiable.

**What such a count can give.** An expected-dimension count $\dim X+\dim Y-n$ is a lower bound on the dimension of every component of a nonempty intersection of subvarieties in a smooth ambient. It is never an upper bound: intersections in special position exceed it. The passage itself exhibits one: the line through $R(L_0^6)$ is a nonempty intersection, and the passage calls it a "coincidence" and excludes it from "every other intersection". A negative expected dimension therefore cannot exclude a second one. Moreover the object in question, $\{F\in V:F\perp K\cdot K\}$, is a linear subspace whose dimension is fixed by linear algebra, not by a genericity count.

**Against Passage B (attack item 5).** "So $13$ holds unless a second coincidence occurs" and "Tightness is open" agree with L90, where $\mathrm{rank}\,\mu_K=13$ is conditional on the modular rank. The count adds heuristic weight only.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: that the $V$-annihilator of $K\cdot K$ is spanned by $R(L_0^6)$, equivalently $\mathrm{rank}\,\mu_K\ge13$. The count is not an argument for it. The falsifying object is a second invariant sextic $F\in V$, independent of $R(L_0^6)$, with $\mathrm{Cat}_F(K,K)=0$. I cannot exhibit one or rule it out in closed form from the brief.

## 5. The $\Delta$ paragraph (attack item 6)

Claim by claim:

| Sentence part | Status |
|---|---|
| psd | argued, by construction (H5) |
| invariant | argued, by construction (H1, H3) |
| sum of squares of cubics of $K$ | argued, by construction |
| vanishes on the orbit cone | argued, section 1 link 4 |
| vanishes **exactly** on the orbit cone | not argued. Hedged as "appears". Needs the real common zero set of $K$ to equal the orbit cone |
| the orbit cone is the zero set $F_5$ is conjectured to have | stated as a conjecture, not a claim |
| $F_5$ not proportional to $\Delta$ | supported only by sampled ratios |
| $F_5/\Delta\in[2.50,3.15]$ across twelve points | a sample |
| "staying bounded and positive" | not argued. Twelve points do not bound a function on the sphere |
| $\lambda\approx2.5$ the natural recentring | heuristic, no claim |

**Observation on the global reading.** If "bounded and positive, in $[2.50,3.15]$" is read on the whole unit sphere off the zero set of $\Delta$, then $2.5\,\Delta\le F_5\le3.15\,\Delta$ there. By continuity this gives $F_5\ge0$ everywhere and $Z(F_5)=Z(\Delta)$ on real points. With "exactly on the orbit cone", this is the conjectured zero set of $F_5$. The sentence read globally therefore carries the conjecture, and read as a sample it proves nothing. Non-proportionality alone would follow from two exact points with different ratios, and none is on file.

**Edges.** On the orbit cone $F_5/\Delta$ is undefined (both vanish, $F_5$ by conjecture). Its boundedness near the cone depends on vanishing orders of $F_5$ and $\Delta$ there, which are not discussed.

**Verdict: HYPOTHESIS-DEBT.** The construction properties are confirmed. Exact vanishing, non-proportionality and the ratio range are measurements or appearances. What would have to be proved: $Z_{\mathbb R}(K)=$ orbit cone, and an exact point pair with $F_5/\Delta$ distinct (for non-proportionality).

## 6. The Casimir values of the three collisions (attack item 7, arithmetic)

With $c(\lambda_1,\lambda_2)=\lambda_1(\lambda_1+3)+\lambda_2(\lambda_2+1)$:

- $c(5,4)=5\cdot8+4\cdot5=40+20=60$, and $c(6,2)=6\cdot9+2\cdot3=54+6=60$.
- $c(5,0)=5\cdot8=40$, and $c(4,3)=4\cdot7+3\cdot4=28+12=40$.
- $c(4,1)=4\cdot7+1\cdot2=28+2=30$, and $c(3,3)=3\cdot6+3\cdot4=18+12=30$.

All three pairs collide at exactly the stated values. The Dynkin-label reading $\lambda=a\omega_1+b\omega_2=(a+b/2,\,b/2)$ does not fit: $(5,4)\mapsto(7,2)$ gives $76$ and $(6,2)\mapsto(7,1)$ gives $72$. So the labels are partitions in the orthogonal basis. "Both with odd second label": $1$ and $3$ are odd, correct.

**On "the three".** The Casimir spectrum has further collisions, for example $c(5,5)=40+30=70=7\cdot10=c(7,0)$. Whether the relevant block list contains any such further pair cannot be checked, since the list is not in the cited lines (H10). I record this as a scope limit, not a finding.

**Verdict: CONFIRMED AS ALGEBRA** for the three stated collisions and the parity remark.

## 7. Which blocks die (attack item 7, the claims)

"Two of the three Casimir collisions vanish with them. At $c=60$ both $(5,4)$ and $(6,2)$ die; at $c=40$ the block $(5,0)$ dies and leaves $(4,3)$ alone. Only $c=30$ survives."

- The referent of "them" is not in the cited lines. The sentence follows the $\Delta$ paragraph, which names no blocks.
- No argument is given that $(5,4)$, $(6,2)$, $(5,0)$ are absent, or that $(4,3)$, $(4,1)$, $(3,3)$ are present, in whatever module is meant.
- Internal consistency holds: removing both blocks at $60$ and one at $40$ leaves one collision, at $30$, which is "two of the three vanish".

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: the multiplicity of each named block in the module under discussion (zero for $(5,4)$, $(6,2)$, $(5,0)$, positive for $(4,3)$, $(4,1)$, $(3,3)$), and that the module's block list has no other Casimir collision. The falsifying object is a nonzero copy of $(5,4)$, $(6,2)$ or $(5,0)$ in that module, or a vanishing of $(4,1)$ or $(3,3)$. I could not look for it: the module is not identified in the brief.

## 8. Scope against Passage B (attack items 5 and 8)

- **Bullet 1 against B.** $\mathrm{rank}\,\mu_K\ge1$ is consistent with B and far weaker than B's conditional $13$. Unconditionally, L91 plus L90's cap gives $1\le\mathrm{rank}\,\mu_K\le13$. With L90's measurement granted, bullet 1 adds nothing.
- **Bullet 2 against B.** Consistent: $36-13=23$ under B. B's conclusion (injectivity of ev on the image) does not assert $F_5\in\operatorname{im}\mu_K$, and bullet 2 correctly leaves it open.
- **Bullet 3 against B.** Consistent: "Tightness is open" matches B's conditional status. The formula reproduces B's cap via the same functional (evaluation at $W_0$), so it is a reformulation, not a new bound.
- **What L91 adds.** A proof-shaped route to $\mathrm{rank}\,\mu_K\ge1$ (with the sampled step), a correct rank-nullity remark, and an unwritten duality reformulation of tightness. The $\Delta$ paragraph and the Casimir paragraph are search leads with no proved content beyond the construction properties of $\Delta$ and the collision arithmetic.

## 9. Falsifiers sought (standing item 6)

| Claim | Falsifying object | What I did |
|---|---|---|
| 1 | $K\ne0$ with $\Delta=0$ | shown impossible by the sum-of-squares argument, so none exists given H4. $K=0$ is the only failure |
| 1 (other reading) | $S$ with $\mathrm{rank}(\mathrm{ev}\circ\mu_K)=0$ | $S=\{W_0\}$, exhibited, withdrawn under the charitable reading |
| 2 | consistent system with affine solution set of dimension $\ne36-\mathrm{rank}$ | none can exist (rank-nullity). Psd set with smaller dimension exhibited (right side $0$), withdrawn |
| 3 | $\dim\{F:\mathrm{Cat}_F(K,K)=0\}\ne14-\mathrm{rank}$ | over all sextics exhibited (dimension $\ge35$), withdrawn. Over $V$ none, under H8 |
| 4 | second invariant sextic annihilating $K\cdot K$ | not exhibitable in closed form from the brief. Debt recorded |
| 5 | real $W$ off the orbit cone with $\Delta(W)=0$, or a unit point with $F_5/\Delta\notin[2.50,3.15]$ | not exhibitable without the explicit $K$ and $F_5$. Debt recorded |
| 6 | a stated pair with unequal Casimir | checked by hand, all equal |
| 7 | a nonzero copy of a block said to die | the module is not identified. Debt recorded |

## Overall verdict

**HYPOTHESIS-DEBT.** The lemma's stated content, $\mathrm{rank}\,\mu_K\ge1$, is correct under the charitable reading, but the one nontrivial step, $\Delta\ne0$, is supported on file only by a sample, and $K\ne0$ and the invariance of the apolar form are used unstated. The rank identity in bullet 3 is unwritten and needs $F$ restricted to invariant sextics. The count, the $\Delta$ properties beyond construction, and the block vanishings are unargued. Nothing is BROKEN, and every withdrawn candidate fails only under a reading the passage does not intend.
