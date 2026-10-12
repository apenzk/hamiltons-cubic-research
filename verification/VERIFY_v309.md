# Verifier v309, Lemma L91: the identity Gram lower bound, the solution-set dimension, the tightness reduction, and the Delta and Casimir remarks

The brief was cold. No numerical work was done, every value below is exact, and no scripts were written or run. The quotations were checked against [findings/sym3-blocks.md](../findings/sym3-blocks.md) lines 153, 175 and 189-195 only, and match the brief verbatim. Log: [agent_logs/verify-L91-v309.log](../agent_logs/verify-L91-v309.log).

| # | Claim | Verdict |
|---|---|---|
| C1a | Bullet 1: the identity Gram is an invariant form, maps to $\Delta=\sum_a q_a^2$, which is an invariant psd sum of squares vanishing on the orbit | CONFIRMED (hypotheses H1-H3 used, unstated) |
| C1b | Heading and bullet 1: "lower bound $1$, unconditionally", resting on "nonzero ($\Delta/\lVert W\rVert^6\approx0.5$ at random points)" | HYPOTHESIS-DEBT |
| C2 | Bullet 2: $36-\mathrm{rank}$ is the dimension of the solution set only when the system is consistent | CONFIRMED |
| C3a | Bullet 3: $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$, a space containing $\mathcal A(W_0^6)$ | HYPOTHESIS-DEBT |
| C3b | Bullet 3: the count $14+29-65<0$ for "every other intersection" | HYPOTHESIS-DEBT |
| C4a | $\Delta$ is psd, invariant, a sum of squares of cubics of $K$, vanishing on the orbit cone | CONFIRMED |
| C4b | $\Delta$ vanishes exactly on the orbit cone, $F_5$ is not proportional to $\Delta$, $F_5/\Delta\in[2.50,3.15]$, bounded and positive | HYPOTHESIS-DEBT |
| C5a | Casimir values: $(5,4),(6,2)$ at $60$, $(5,0),(4,3)$ at $40$, $(4,1),(3,3)$ at $30$, second labels of the last pair odd | CONFIRMED AS ALGEBRA |
| C5b | Which blocks "die", that there are three collisions, that only $c=30$ survives | HYPOTHESIS-DEBT |
| C6 | Scope and consistency of the lemma with Lemma L90 | CONFIRMED (no contradiction, small increment) |

**Summary.** The headline bound $\mathrm{rank}\,\mu_K\ge1$ is true, but its only written support for $\Delta\ne0$ is a sample, the tightness formula is stated without a derivation or a domain for $F$, and everything past the three bullets is measurement or unargued block bookkeeping. Overall verdict: **HYPOTHESIS-DEBT**.

## 0. Conventions, fixed once

- $\mathcal W_5$: algebraic Weyl tensors on $\mathbb R^5$, the $SO(5)$ irreducible of highest weight $(2,2)$ in the orthogonal basis, dimension $35$. $O(5)=SO(5)\times\{\pm I\}$ and $-I$ acts trivially on $4$-tensors, so $O(5)$- and $SO(5)$-invariance coincide on everything below.
- $\langle\cdot,\cdot\rangle$: the apolar (Bombieri) inner product on polynomials on $\mathcal W_5$, induced from the $O(5)$-invariant inner product $\lVert W\rVert^2$ on $\mathcal W_5$.
- $K\subset\mathrm{Sym}^3\mathcal W_5^*$: the cubics with $\sigma_\lambda(W_0)=0$, read (as Lemma L90's cap requires) as an $O(5)$-stable subspace every element of which vanishes at $W_0$.
- $\{q_a\}$: a real basis of $K$, orthonormal for $\langle\cdot,\cdot\rangle$.
- $\mathcal G$: the invariant symmetric forms on $K$ (the brief's $36$). $\mu_K:\mathcal G\to\mathcal S$, $G\mapsto\sum_{a,b}G_{ab}q_aq_b$, with $\mathcal S$ the invariant sextics (the brief's $14$).
- $\mathrm{ev}$: evaluation at the certificate's finite set $S$. "rank" unqualified in L91 is read as $\mathrm{rank}\,\mu_K$ (Section 1.2 gives the reason).
- $\mathrm{Cat}_F(q,q')$ for a sextic $F$ and cubics $q,q'$: the catalecticant pairing, equal to $c\,\langle F,qq'\rangle$ for a fixed nonzero constant $c$ depending only on the degrees.
- Casimir of $SO(5)$ at highest weight $(a,b)$, $a\ge b\ge0$ orthogonal coordinates, $\rho=(3/2,1/2)$: $c(a,b)=\langle\lambda,\lambda+2\rho\rangle=a^2+3a+b^2+b$.

## Hypothesis inventory

| Id | Hypothesis | Stated where | Used by |
|---|---|---|---|
| H1 | $K$ is $O(5)$-stable | Nowhere in the passages. Implicit in "invariant Grams on $K$" (Passage B) | C1a invariance of the identity Gram, C4a vanishing on the whole orbit |
| H2 | The apolar inner product is $O(5)$-invariant | Nowhere | C1a: the identity Gram is invariant only for an orthonormal basis of an invariant inner product |
| H3 | Every $q\in K$ vanishes at $W_0$ | Definition of $K$, and used in L90's cap | C1a, C4a vanishing on the orbit |
| H4 | $K\ne0$ | Only through the imported count "$36$" of invariant forms (which forces $\mathrm{Sym}^2K\ne0$) | C1b nonvanishing of $\Delta$ (not invoked by the text) |
| H5 | The $q_a$ are real polynomials | Implicit in "psd" | C1b, C4a |
| H6 | $F_5$ is an invariant sextic | Nowhere in the brief | C2 (otherwise the system is inconsistent by type), C4b |
| H7 | $F$ in bullet 3 ranges over the $14$ invariant sextics | Nowhere | C3a |
| H8 | The apolar pairing restricted to $\mathcal S$, and to $\mathcal G$, is nondegenerate | Nowhere | C3a |
| H9 | $\mathcal A(W_0^6)$ denotes an invariant sextic (the representer in $\mathcal S$ of evaluation at $W_0$) | Nowhere | C3a containment |
| H10 | Identities of the numbers $29$ and $65$ | Nowhere | C3b |
| H11 | The list of blocks (irreducibles) present and which of them "die" | Outside the quoted lines ("them") | C5b |
| G | Lemma L90 as stated: cap $\mathrm{rank}\,\mu_K\le13$ proved, equality conditional on a modular rank | Passage B, a given | C6, and used consistently by bullet 3 |

Imported counts $36$ and $14$ are taken from the brief's definitions and not rechecked.

## 1. C1, the identity Gram and the bound $1$

### 1.1 Derivation, link by link (C1a)

1. *Identity Gram is invariant.* For $g\in O(5)$, $g\cdot q_a=\sum_b\rho(g)_{ba}q_b$. By H1 the image stays in $K$ and by H2 the matrix $\rho(g)$ is orthogonal, so $\rho(g)^TI\rho(g)=I$. The identity is in $\mathcal G$. The text asserts this ("is one of the $36$ invariant forms") without naming H1 or H2.
2. *Image.* $\mu_K(I)=\sum_aq_a^2=\Delta$, directly from the definition of $\mu_K$.
3. *Invariance of $\Delta$.* $g\cdot\Delta=\sum_a(g\cdot q_a)^2=\sum_a q_a^2$ because $\{g\cdot q_a\}$ is another orthonormal basis. Follows from step 1.
4. *psd.* A sum of squares of real polynomials (H5) is $\ge0$ pointwise.
5. *Vanishing on the orbit.* $q_a(gW_0)=(g^{-1}\cdot q_a)(W_0)=0$ by H1 and H3, hence $\Delta(gW_0)=0$. Homogeneity of degree $6$ gives vanishing on $\mathbb R\cdot O(5)W_0$.

All five links hold under H1, H2, H3, H5. Verdict C1a: CONFIRMED, with H1 and H2 used and unstated.

### 1.2 Which rank is bounded (attack item 1)

- The heading says "the unconditional lower bound $1$" and never names the map. Passage B names two ranks, $\mathrm{rank}\,\mu_K$ and $\mathrm{rank}(\mathrm{ev}\circ\mu_K)$.
- The argument exhibits $\Delta\in\operatorname{im}\mu_K$. If $\Delta\ne0$ this gives $\mathrm{rank}\,\mu_K\ge1$.
- For $\mathrm{rank}(\mathrm{ev}\circ\mu_K)\ge1$ one needs $\Delta(s)\ne0$ for some $s\in S$. The text evaluates at "random points", which are not stated to be the certificate's $S$. Nothing on file gives that bound.
- Bullet 3's formula $\mathrm{rank}=14-\dim\{\dots\}$ involves no point set, so within the lemma "rank" is $\mathrm{rank}\,\mu_K$. The charitable reading is forced and adopted. The statement should name $\mu_K$.

### 1.3 Nonvanishing of $\Delta$ (C1b, attack item 2)

**Candidate: the link "nonzero" is supported on file only by a sample.**

1. *Location.* Line 189: "and nonzero ($\Delta/\lVert W\rVert^6\approx0.5$ at random points)".
2. *Failure exhibited.* The parenthetical is the only reason given. A value $\approx0.5$ at unspecified random points is a floating-point measurement, which the brief's rules classify as HYPOTHESIS-DEBT. Without $\Delta\ne0$, step 2 of 1.1 gives only $\Delta\in\operatorname{im}\mu_K$, which is compatible with $\mu_K=0$ (rank $0$).
3. *Charitable reading.* The same sentence says $\Delta$ is "a sum of squares of cubics of $K$" over a basis. One could read "nonzero" as a consequence of that description. The text does not draw that consequence: it offers the sample as the reason, and the consequence needs H4 ($K\ne0$) and H5 (reality), neither of which the sentence invokes. The reading does not make the written chain complete.

The finding stands. **What would have to be proved:** $\Delta\not\equiv0$ as a polynomial.

**Answer to item 2, whether a sampling-free argument exists.** Yes, in two lines and on hypotheses the record already carries: by H4 some $q_1\ne0$ in the basis, and a nonzero real polynomial is nonzero at some real $W$, so $\Delta(W)\ge q_1(W)^2>0$. The record does not contain it. The number $0.5$ contributes nothing to the proof beyond corroboration, and $\Delta/\lVert W\rVert^6$ is necessarily nonconstant (a constant ratio would make $\Delta$ nonzero at $W_0$, contradicting 1.1 step 5), so no single value characterises it.

Verdict C1b: HYPOTHESIS-DEBT.

### 1.4 "Unconditionally"

Relative to Passage B the adjective is accurate: the bound uses none of L90's three modular hypotheses. It does rest on H1-H5, of which H4 comes from the imported count $36$.

## 2. C2, the solution-set dimension (attack item 3)

The system is $\mu_K(G)=F_5$, $G\in\mathcal G$, $\dim\mathcal G=36$.

- *Linear.* The homogeneous solution set is $\ker\mu_K$, of dimension $36-\mathrm{rank}\,\mu_K$ by rank-nullity.
- *Affine.* The inhomogeneous solution set is empty when $F_5\notin\operatorname{im}\mu_K$, and otherwise $G_0+\ker\mu_K$, an affine space of dimension $36-\mathrm{rank}\,\mu_K$. This is exactly bullet 2's claim, and consistency is equivalent to $F_5\in\operatorname{im}\mu_K$, as the bullet says. H6 is needed for this to be a question at all.
- *psd set.* The set a sum-of-squares route needs is $(G_0+\ker\mu_K)\cap\{G\succeq0\}$. Its dimension is at most $36-\mathrm{rank}$, and it can be empty or lower-dimensional even when the system is consistent. The bullet speaks of "the solution set" of the linear system and calls consistency a necessary condition, never a sufficient one, so it makes no claim about the psd set.
- *Under the given.* If L90's equality $\mathrm{rank}\,\mu_K=13$ is granted, the solution space has dimension $23$ when consistent.

Verdict C2: CONFIRMED.

## 3. C3, the tightness reduction (attack item 4)

### 3.1 The identity (C3a)

**What is on file.** The formula $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$ and the containment of $\mathcal A(W_0^6)$ are stated with no derivation.

**Check of the algebra, reading H7-H9.** Let $\mathcal N=\{F\in\mathcal S:\mathrm{Cat}_F(q,q')=0\ \forall q,q'\in K\}$.

1. $\operatorname{im}\mu_K\subseteq\mathcal S$, so by H8 $\dim(\operatorname{im}\mu_K)^{\perp}\cap\mathcal S=14-\mathrm{rank}\,\mu_K$.
2. $F\in\mathcal S$ is orthogonal to $\operatorname{im}\mu_K$ iff $\sum_{a,b}G_{ab}\mathrm{Cat}_F(q_a,q_b)=0$ for every $G\in\mathcal G$.
3. For $F\in\mathcal S$ the form $B_F=\mathrm{Cat}_F|_{K\times K}$ is itself invariant (H1 and invariance of the pairing). Step 2 says $B_F$ is orthogonal to every element of $\mathcal G$, including $B_F$, so $B_F=0$ by definiteness of the trace pairing on real symmetric forms. Conversely $B_F=0$ gives step 2.
4. Hence $(\operatorname{im}\mu_K)^\perp\cap\mathcal S=\mathcal N$ and $\mathrm{rank}\,\mu_K=14-\dim\mathcal N$.

So the formula is correct under H7 and H8. Neither is stated, and no step of 1-4 is on file.

**Candidate: the formula and the containment cannot both hold as written.**

1. *Location.* Line 191: "$\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$, a space containing $\mathcal A(W_0^6)$".
2. *Failure exhibited.* Read $\mathcal A(W_0^6)$ literally as the sextic $\ell_{W_0}^6$ with $\ell_{W_0}=\langle W_0,\cdot\rangle$, the apolar dual of the point $W_0$. Then $\mathrm{Cat}_{\ell_{W_0}^6}(q,q')=c'\,q(W_0)q'(W_0)=0$ on $K$, so it lies in the set. But $\ell_{W_0}^6$ is not invariant: $g\cdot\ell_{W_0}^6=\ell_{gW_0}^6$, and $gW_0\ne W_0$ for some $g$ because $W_0\ne0$ and $(2,2)$ is a nontrivial irreducible with no nonzero fixed vector. So the set containing it is not inside $\mathcal S$. Over all sextics the identity of 3.1 is not the relation that holds: the duality in steps 1-4 is with $\mathcal N=\{\dots\}\cap\mathcal S$, and it uses $F\in\mathcal S$ in step 3.
3. *Charitable reading.* Take $F\in\mathcal S$ and $\mathcal A(W_0^6)$ as the invariant sextic representing evaluation at $W_0$ on $\mathcal S$, which is the $O(5)$-average $\int\ell_{gW_0}^6\,dg$. It lies in $\mathcal N$ because $\mathrm{Cat}$ of the average on $K\times K$ is $c'\int q(gW_0)q'(gW_0)\,dg=0$ by H1 and H3, and it is nonzero because it pairs with $\lVert W\rVert^6$ to a nonzero multiple of $\lVert W_0\rVert^6$. Under this reading both halves hold and $\dim\mathcal N\ge1$ reproduces L90's cap.

The charitable reading rescues the claim, so the refutation is withdrawn (Section 7). What survives is that H7 and H9 are unstated and the identity has no derivation.

**What would have to be proved:** steps 1-4 above with the domain $F\in\mathcal S$ and the meaning of $\mathcal A(W_0^6)$ stated.

Verdict C3a: HYPOTHESIS-DEBT.

### 3.2 The dimension count (C3b)

1. *Location.* Line 191: "with a dimension count putting every other intersection at $14+29-65<0$. So $13$ holds unless a second coincidence occurs."
2. *Failure exhibited.* The arithmetic is $14+29-65=-22$. The passage does not say which spaces have dimensions $29$ and $65$ (H10). An expected-dimension count bounds nothing for specific subspaces: two linear subspaces of dimensions $14$ and $29$ in a $65$-dimensional space can meet in any dimension from $0$ to $14$. Here the spaces are already known to meet in the line of $\mathcal A(W_0^6)$, of dimension $1>-22$, so they are not in general position, which is the only situation in which the count predicts anything.
3. *Charitable reading.* The bullet opens "Tightness is open" and closes "unless a second coincidence occurs", so the count is offered as a heuristic, not a proof. Read that way there is no overclaim. The sentence "So $13$ holds unless a second coincidence occurs" is then a restatement of $\dim\mathcal N=1\iff\mathrm{rank}=13$, which is true given 3.1.

No overclaim, but the count is unsupported and uninterpretable from the record. **What would have to be proved:** the identity of the $29$- and $65$-dimensional spaces, and $\dim\mathcal N=1$ itself, which is equivalent to tightness.

Verdict C3b: HYPOTHESIS-DEBT.

## 4. The three bullets against Passage B (attack item 5)

- **Bullet 1 against B.** B proves $\mathrm{rank}\,\mu_K\le13$ and grants $\ge13$ conditionally. L91 bullet 1 gives $\ge1$ on none of B's modular hypotheses. No conflict. It bounds $\mu_K$, not $\mathrm{ev}\circ\mu_K$ (1.2).
- **Bullet 2 against B.** B's conclusion ("a sextic in the image agreeing with $F_5$ on $S$ is then $F_5$") never asserts $F_5\in\operatorname{im}\mu_K$, and bullet 2 calls that membership open. No conflict. Granting B's equality, $\operatorname{im}\mu_K$ is a $13$-dimensional subspace of the hyperplane $\{F\in\mathcal S:F(W_0)=0\}$, which has dimension $13$, so the two coincide and consistency becomes the single condition $F_5(W_0)=0$. Neither passage records this. It is a scope observation, not a defect.
- **Bullet 3 against B.** B's cap is $\dim\mathcal N\ge1$ in the language of 3.1, and B's conditional equality is $\dim\mathcal N=1$. "Tightness is open" matches B's "conditional on one measured rank". No conflict.

No finding: the three bullets are consistent with the given as stated.

## 5. C4, the $\Delta$ paragraph (attack item 6)

### 5.1 What is argued (C4a)

"psd, invariant, a sum of squares of cubics of $K$ by construction" is 1.1 steps 2-4. Vanishing on the orbit cone is 1.1 step 5. Verdict C4a: CONFIRMED under H1-H3, H5.

### 5.2 What is not argued (C4b)

**Candidate 1: "vanish exactly on the orbit cone".**

1. *Location.* Line 193: "appears to vanish exactly on the orbit cone".
2. *Failure exhibited.* The inclusion $\{\Delta=0\}\subseteq\mathbb R\cdot O(5)W_0$ is equivalent to: every real $W$ at which all of $K$ vanishes lies in the cone. Nothing on file addresses the common real zero locus of $K$.
3. *Charitable reading.* "appears to" marks it as a conjecture. As a conjecture it is honest, but it is then not a property of $\Delta$ on file, and the paragraph's case that $\Delta$ is a "live lead" leans on it.

Stands as HYPOTHESIS-DEBT. **What would have to be proved:** $V_{\mathbb R}(K)=\mathbb R\cdot O(5)W_0$.

**Candidate 2: "$F_5$ is not proportional to it: $F_5/\Delta$ ranges over $[2.50,3.15]$ across twelve random unit points, staying bounded and positive".**

1. *Location.* Line 193, as quoted.
2. *Failure exhibited.* Non-proportionality, the interval, positivity and boundedness are each supported only by twelve sampled values. Boundedness of $F_5/\Delta$ on the unit sphere is a global statement about the orders of vanishing of $F_5$ and $\Delta$ along their common zero set, which twelve points cannot touch. The interval endpoints are decimals, not exact values.
3. *Charitable reading.* The paragraph presents these as search guidance ("the natural recentring"), and "$\lambda\approx2.5$" is openly approximate. That reading removes any overclaim for $\lambda$, but "$F_5$ is **not** proportional to it" is set in bold as a fact, and no argument for it is on file.

Stands as HYPOTHESIS-DEBT. **What would have to be proved:** $F_5\notin\mathbb R\Delta$ (for instance an exact point where $F_5/\Delta$ takes two different values), and if boundedness is to be used, a comparison of vanishing orders.

Verdict C4b: HYPOTHESIS-DEBT.

## 6. C5, the Casimir collisions (attack item 7)

### 6.1 Arithmetic (C5a)

With $c(a,b)=a^2+3a+b^2+b$:

| Block | $a^2+3a$ | $b^2+b$ | $c$ |
|---|---|---|---|
| $(5,4)$ | $40$ | $20$ | $60$ |
| $(6,2)$ | $54$ | $6$ | $60$ |
| $(5,0)$ | $40$ | $0$ | $40$ |
| $(4,3)$ | $28$ | $12$ | $40$ |
| $(4,1)$ | $28$ | $2$ | $30$ |
| $(3,3)$ | $18$ | $12$ | $30$ |

All three stated coincidences hold exactly, and the second labels $1$ and $3$ are odd. The convention (orthogonal coordinates, $a\ge b$) is not stated in the quoted lines, but it is the one in which all six values match.

Completeness under that convention, where the blocks are components of cubics on $\mathcal W_5$: weights of $\mathrm{Sym}^3$ of $(2,2)$ have first coordinate at most $6$. Listing $c(a,b)$ for $0\le b\le a\le6$ gives the values $0;4,6;10,12,16;18,20,24,30;28,30,34,40,48;40,42,46,52,60,70;54,56,60,66,74,84,96$. The only repeated values are $30$, $40$ and $60$, so among weights with $a\le6$ there are exactly three possible collisions, the three named. This confirms "three" as the maximum, not that all six weights occur.

Verdict C5a: CONFIRMED AS ALGEBRA.

### 6.2 Which blocks die (C5b)

1. *Location.* Line 195: "At $c=60$ both $(5,4)$ and $(6,2)$ die; at $c=40$ the block $(5,0)$ dies and leaves $(4,3)$ alone."
2. *Failure exhibited.* Nothing in the quoted passage says what "die" means or why these blocks do. The antecedent of "vanish with them" is not in the quoted lines. That each of the six weights occurs in the relevant space, and that $(5,4),(6,2),(5,0)$ are removed while $(4,1),(3,3),(4,3)$ remain, rests on H11, which is not on file here.
3. *Charitable reading.* The argument may exist in lines the brief withholds. The brief states it quotes every passage the round checks, so within the round the claim has no argument.

Stands. **What would have to be proved:** the multiplicities of $(5,4),(6,2),(5,0),(4,3),(4,1),(3,3)$ in $K$ (or whichever space the blocks live in) and the criterion under which a block dies.

Verdict C5b: HYPOTHESIS-DEBT.

## 7. C6, scope (attack item 8)

- The lemma's heading claims one thing, $\mathrm{rank}\,\mu_K\ge1$. Passage B does not contain that bound unconditionally, so it is new, and it is far weaker than B's conditional $13$.
- Bullet 2 is rank-nullity. Bullet 3 recasts B's cap and B's conditional equality as $\dim\mathcal N\ge1$ and $\dim\mathcal N=1$, a reformulation without new content about the value.
- The $\Delta$ paragraph and the Casimir paragraph are search commentary outside the heading's claim.

No finding against correctness: the lemma adds an unconditional nonzero-rank statement and a dual reformulation, and contradicts nothing in Passage B.

### Withdrawn candidates

- **"The tightness formula is false."** Located at line 191 and exhibited in 3.1: over all sextics, or with $\mathcal A(W_0^6)$ read as the non-invariant power $\ell_{W_0}^6$, the formula and the containment are incompatible. Withdrawn at step 3, since reading $F\in\mathcal S$ and $\mathcal A(W_0^6)$ as its invariant average makes both true. The residue is recorded in C3a.
- **"$\Delta$ vanishes on more than the orbit cone, at $-W_0$."** Located at line 193. Cubics are odd, so every $q\in K$ vanishes at $-W_0$ and $\Delta(-W_0)=0$. If "orbit cone" meant $\mathbb R_{\ge0}\cdot O(5)W_0$ and $-W_0\notin O(5)W_0$, this would be an extra zero. Withdrawn at step 3: $\Delta$ and $F_5$ are sextics, hence even, so the only consistent reading of "orbit cone" for both is the two-sided cone $\mathbb R\cdot O(5)W_0$, which contains $-W_0$.
- **"A fourth Casimir collision."** In the same convention $(7,0)$ and $(5,5)$ share $c=70$. Withdrawn at step 2: no failure can be exhibited, since $a=7$ exceeds the bound $a\le6$ for cubics, and 6.1 shows no other repeat exists within that range.
- **"The bound $1$ fails for $\mathrm{ev}\circ\mu_K$."** Located at line 175. Withdrawn at step 3: bullet 3's formula fixes "rank" as $\mathrm{rank}\,\mu_K$ (1.2). Recorded as an imprecision of the heading.

## 8. Standing items

1. **Hypothesis inventory.** Given above. Used but unstated: H1, H2, H6, H7, H8, H9, H10, H11. H4 enters only through the imported count $36$.
2. **Quantifier order and scope.** The bounded rank is $\mathrm{rank}\,\mu_K$ over $\mathcal G$ (the $36$ invariant forms) into $\mathcal S$ (the $14$ invariant sextics), not $\mathrm{rank}(\mathrm{ev}\circ\mu_K)$. The set in bullet 3 must be taken inside $\mathcal S$, not all sextics. Both are unstated (1.2, 3.1).
3. **Edges.** $K=0$: excluded only by the count $36$, and then $\mu_K=0$ and C1b's gap would be a real failure. Rank $0$: excluded exactly when $\Delta\ne0$ (C1b). Rank $13$: equivalent to $\dim\mathcal N=1$, open in L91 and conditional in L90. Rank $14$: impossible, since $\mathcal N$ contains the nonzero average of $\ell_{W_0}^6$, matching L90's cap. Orbit cone: must be the two-sided cone (withdrawn candidate 2).
4. **Proven against stated.** Proven on file: $\Delta\in\operatorname{im}\mu_K$, $\Delta$ invariant, psd, vanishing on the cone, and rank-nullity for the system. Stated beyond that: $\Delta\ne0$ (sampled), the tightness identity (no derivation), the count, the exact zero set, non-proportionality and ratio bounds (sampled), and the dying blocks (unargued).
5. **Brief items.** Items 1-8 are answered in 1.2, 1.3, 2, 3.1-3.2, 4, 5, 6 and 7 respectively.
6. **Falsifiers and search.**
   - C1b: $\mu_K=0$, which requires $K=0$ or complex $q_a$. Excluded by H4 and H5 in 1.3.
   - C2: a consistent system with solution dimension $\ne36-\mathrm{rank}$. Impossible by rank-nullity.
   - C3a: an $F\in\mathcal S$ orthogonal to $\operatorname{im}\mu_K$ with $\mathrm{Cat}_F|_K\ne0$. Excluded by step 3 of 3.1. The literal-power reading produced the withdrawn candidate.
   - C3b: $\dim\mathcal N\ge2$. The record contains no way to exhibit or exclude it, and it is not claimed excluded.
   - C4b: a real $W\notin\mathbb R\cdot O(5)W_0$ with $K(W)=0$, or $F_5=\lambda\Delta$. $-W_0$ was examined and withdrawn. $F_5$ is not defined in the brief, so no exact point could be evaluated.
   - C5a: a pair among the six with unequal $c$. All six were computed exactly and none exists. A collision beyond the three: all $c(a,b)$ with $a\le6$ were enumerated and none exists.
   - C5b: a listed block that is absent, or a surviving block that dies. Not decidable from the record.

## Overall verdict

**HYPOTHESIS-DEBT.** The headline $\mathrm{rank}\,\mu_K\ge1$ is correct, but the record supports $\Delta\ne0$ only by sampling. The one-line argument from $K\ne0$ is absent. Bullet 2 is confirmed. Bullet 3's identity is correct once $F$ is restricted to invariant sextics and $\mathcal A(W_0^6)$ is read as an invariant, but neither is stated and no derivation is on file. The $\Delta$ and Casimir paragraphs are confirmed only in their constructive and arithmetic parts, and the rest is measurement or unargued.
