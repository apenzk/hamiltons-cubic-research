# REVIEW r538, Lemma L128

**Target.** Lemma L128, "the branching clause: block-checkable nondegeneracy at a pure critical point, and the isolation it gives", [findings/second-order.md](../findings/second-order.md), the `#### Lemma L128` heading at line 773 through [post F46](../findings/second-order.md) at line 807.

**Reviewer.** r538, cold, adversarial. Derived from the definitions before reading the record's proofs. Analysis-only footing inherited: no searches, sweeps or censuses were run. One hand screen is reported below and labelled as such.

**VERDICT: PLAUSIBLE.** All four statements (i)–(iv) are true and I derived each independently. The block is nonetheless not CONFIRMED, for two reasons that a reader cannot repair without noticing them: **the printed proof of (iv) contains a step that is false and, read literally, assumes the conclusion** (defect D1), and **the box's load-bearing witness is denied by name by the source it cites, [Lemma L11](../findings/nondegeneracy.md), as corrected earlier today** (defect D2). On D2 the lemma under review is the one that is right and L11 is the one that is wrong; the repair belongs in L11.

---

## Summary of findings

| # | where | finding | grade |
| --- | --- | --- | --- |
| D1 | [second-order.md:795](../findings/second-order.md), proof of (iv) | "$A$ is closed in the compact $S$, hence compact" is **false as justified and circular**. Repairable in one clause. | **defect, repairable** |
| D2 | [second-order.md:787](../findings/second-order.md), the box under (ii) | the witness "$S^2\times S^4$ … is **Morse–Bott nondegenerate** ([Lemma L11](../findings/nondegeneracy.md))" is contradicted by L11's statement as corrected 2026-09-04. **L128 is right, L11 is wrong.** | **defect in the input, not in L128** |
| D3 | [second-order.md:803](../findings/second-order.md), Corollary L128.1 | the bold headline still says "every two-block sphere product at $n\ge12$" while the body opens "Assume $p,q\ge3$". [r375](REVIEW_r375.md)/[r376](REVIEW_r376.md)'s repair reached the body only. | bookkeeping |
| D4 | four of six in-file anchors | four of the six markdown anchors pointing at L128 do not resolve; two of them use a **stale title**. | bookkeeping |
| D5 | [INDEX-results.md:146](../findings/INDEX-results.md) | the index titles L128 "…the isolation **and uniform separation** it gives"; the heading says only "…and the isolation it gives". | bookkeeping |
| C1 | part (i) | **CONFIRMED, and stronger than stated**: criticality is unused. | confirmed |
| C2 | part (ii) | **CONFIRMED** from the definitions, including the equivalence being exact. | confirmed |
| C3 | part (iii) | **CONFIRMED**. The isolation does follow from the nondegeneracy premise; nothing is asserted alongside it. | confirmed |
| C4 | parts (i)–(iv) | **no part needs maximality**, and nothing withdrawn survives anywhere in the text or in any citation. | confirmed |
| Q1 | the brief's question 1 | **false premise**: L128 has no use for [Lemma L37](../findings/target.md). |, |
| Q3 | the brief's question 3 | **false premise**: the block has **four** parts, (i)–(iv), not three. |, |

---

## Conventions, fixed first

Checked against the anchors before reading any proof. $\theta_0(n)^2=2(n-1)(n-2)/n^2$ gives $\theta_0(6)^2=40/36$, so $\theta_0(6)=\sqrt{10}/3$. $\dim\mathcal W_n=n(n-3)(n+1)(n+2)/12$ gives $84$ at $n=6$ and $1638$ at $n=12$. The half-trace pairing is the record's, under which $\lVert\varphi_{ab}\rVert^2=1$. "Diagonal" is [conventions.md](../findings/conventions.md)'s coordinate-$2$-plane sense, not diagonality on $\Lambda^2$.

---

## C1, part (i): CONFIRMED, and it needs less than the block grants it

Derived cold. Let $W$ be pair-diagonal in the fixed frame, $We_{ab}=M_{ab}e_{ab}$. For $A=E_{jk}$ the induced $\rho(E_{jk})$ on $\Lambda^2$ has nonzero matrix entries only between $e_{ji}$ and $e_{ki}$, $i\notin\{j,k\}$, and annihilates $e_{jk}$ and every $e_{ab}$ with $a,b\notin\{j,k\}$. Since $W$ is diagonal,
$$[\rho(E_{jk}),W]_{\alpha\beta}=(M_\beta-M_\alpha)\rho(E_{jk})_{\alpha\beta},$$
so the commutator is supported on the monomials $e_{ji}\odot e_{ki}$, which is [Lemma L122](../findings/second-order.md)'s basis of $V_{jk}$. The three block families of [Lemma L120](../findings/second-order.md) are spanned by **disjoint** sets of monomials ($e_{ab}\odot e_{ab}$ for $\mathcal D_n$; $e_{ij}\odot e_{kl}$ for the four-sets; $e_{ji}\odot e_{ki}$ for the pairs), so the four-set and $\mathcal D_n$ components vanish identically. Linearity over $A=\sum a_{jk}E_{jk}$ finishes it.

**The answer to the brief's question 2.** The derivation used **only** that $W$ is pair-diagonal in the frame. Criticality, unit norm, $\theta>0$ and maximality are all unused, so (i) holds at *every* frame-diagonal $W$, not merely at a pure critical point and a fortiori not merely at a sphere product. It is also the reason the $pq$-dimensional count is a sphere-product fact rather than a general one: $\dim T_W\mathcal O=\#\{\{j,k\}:o^{jk}\ne0\}$, since the $o^{jk}$ live in distinct blocks and are therefore independent whenever nonzero. At $S^p\times S^q$ that count is the $pq$ cross-factor pairs, matching the brief.

**A sign the block hedges rather than fixes.** The proof writes that $\rho(E_{jk})$ "joins $e_{ji}$ to $e_{ki}$, with the sign convention that makes the commutator's coefficient $M_{ki}-M_{ji}$". Under the natural convention $E_{jk}:e_j\mapsto e_k,\ e_k\mapsto-e_j$ the coefficient comes out $M_{ji}-M_{ki}$, the negative. This is [r373](REVIEW_r373.md)'s finding, and the current text answers it by naming a convention it never writes down. Benign ($o^{jk}$ is used only as a spanning eigenvector, so its sign is free) but it is a hole a reader will fall into once.

**And (i) is over-hypothesised without saying so.** [Lemma L121](../findings/second-order.md) opens by separating "the block and its spectrum need diagonality alone" from "the necessary condition below is the part that needs a maximiser", and [Lemma L122](../findings/second-order.md) does the same in three grades. L128 states one hypothesis line for all four parts and never records that (i) uses none of it. That is the mirror image of the failure mode the brief warns about, and harmless, but it is the file's own house style going unapplied.

---

## C2, part (ii): CONFIRMED, and the equivalence is exact

Derived cold. With $F(X)=3(Q(X)-P(X)X)$ and $\nabla P=3Q$,
$$dF_W(V)=6\,W\circ V-9\langle Q(W),V\rangle W-3P(W)V,$$
which at a unit-norm critical point ($Q(W)=\theta W$, $P(W)=\theta$, $W\circ V=\theta L_eV$) is
$$dF_W(V)=6\theta\big(L_e-\tfrac12\mathrm{Id}\big)V-9\theta\langle W,V\rangle W.$$
So $dF_W(W)=-6\theta W$ and $dF_W|_{W^\perp}=6\theta(L_e-\tfrac12)$, reproducing both numbers the block prints, and matching [Lemma L24](../findings/second-order.md)'s $\mathrm{Hess}(P|_S)_W=6\theta(L_e-\tfrac12\mathrm{Id})$. Hence $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp$, an **eigenspace**, which is exactly why the criterion must exclude the value rather than bound the spectrum.

The block reduction is then clean. $L_e$ preserves each summand ([L120](../findings/second-order.md)) and preserves $W^\perp$ ($L_ee=e$ plus self-adjointness, [L24](../findings/second-order.md)), and $W^\perp$ cuts $\mathcal D_n$ and nothing else, which is why (ii) writes $\mathcal D_n\cap W^\perp$ against the bare four-set and pair blocks, correctly. Each $o^{jk}$ is a $\tfrac12$-eigenvector by [L122](../findings/second-order.md), so $\ker\mathrm{Hess}\supseteq T_W\mathcal O$ unconditionally, and equality is precisely "no block contributes a $\tfrac12$-vector beyond the $o^{jk}$". Because the $o^{jk}$ sit in distinct blocks, the per-block condition is **equivalent** to the global one rather than merely sufficient. $\square$

> **One ambiguity worth a clause.** (ii) reads *"in every pair block $\tfrac12$ is either absent or simple with eigenvector $o^{jk}$."* In an **orbit-free** pair block $o^{jk}=0$, the within-factor blocks of every $S^p\times S^q$, six of the fifteen at $S^3\times S^3$ by [L122](../findings/second-order.md)'s own closing paragraph, and there "simple with eigenvector $0$" is not an available alternative, so the only admissible branch is "absent". True as written, on the reading that an eigenvector is nonzero; but the block never says which pair blocks have $o^{jk}=0$, and a consumer checking the criterion block by block has to supply that himself.

---

## C3, part (iii): CONFIRMED, and the isolation genuinely follows from the premise

This was the brief's question 5, and the answer is that the implication is earned, not asserted.

**What is isolated, and from what.** The *orbit* $\mathcal O$, not the point, and the topology is the norm topology of $\mathcal W_n$ restricted to $S$. The conclusion is that some open neighbourhood of $\mathcal O$ in $S$ meets $\mathrm{Crit}(P|_S)$ only in $\mathcal O$.

**The chain, checked step by step.** (a) $\mathrm{Crit}(P|_S)=F^{-1}(0)\cap S$: at $\lVert X\rVert=1$ the multiplier is $\langle\nabla P,X\rangle=3P(X)$, so $\nabla P=\lambda X$ is $Q(X)=P(X)X$. (b) Near $W$ with $P>0$, $F^{-1}(0)$ carries no radial direction (if $X=tY$ with $\lVert Y\rVert=1$ then $F(X)=0$ forces $t^2P(Y)=P(Y)$, hence $t=\pm1$) so working in the ambient space costs nothing, and correspondingly $dF_W(W)=-6\theta W\ne0$. (c) $dF_W$ is self-adjoint, being a sum of $L_e$, a rank-one orthogonal projection and the identity, so under (ii) $\ker dF_W=T_W\mathcal O$ in the **ambient** space. (d) With $V'=(T_W\mathcal O)^\perp$, self-adjointness gives $\mathop{\mathrm{im}}dF_W=(\ker dF_W)^\perp=V'$ and makes $V'$ invariant, so $\Pi_{V'}dF_W|_{V'}=dF_W|_{V'}$ is invertible. (e) The implicit function theorem applied to $\Pi_{V'}F=0$ puts $F^{-1}(0)$ locally inside a graph of dimension $\dim T_W\mathcal O=\dim\mathcal O$. (f) $\mathcal O$ is a submanifold of that dimension inside it: for small $U$, $\mathcal O\cap U$ is open in the graph (equal dimension) and closed in it ($\mathcal O$ compact), and the graph over a small ball is connected, so the two coincide. (g) Equivariance of $F$ carries the same neighbourhood to every $gW$, and the union is an open neighbourhood of $\mathcal O$.

Nothing here needs a slice, and nothing here needs maximality. The step the withdrawn version was missing, an equivariant slice and a Lyapunov–Schmidt reduction, per [Lemma L127](../findings/second-order.md)'s withdrawal box, is genuinely not used.

---

## D1, part (iv): "$A$ is closed" is FALSE as justified, and read literally it assumes the conclusion

Verbatim, [second-order.md](../findings/second-order.md), proof of (iv):

> **Proof of (iv).** $B$ is the continuous image of the compact $O(n)\times(\mathcal D_n\cap S)$, hence compact; **$A$ is closed in the compact $S$, hence compact.**

$A=\{\text{non-pure critical}\}\cap\{\theta\ge c\}$. The set $\mathrm{Crit}\cap\{\theta\ge c\}$ is closed, but "non-pure" is the complement of $B$, and $B$ is **compact**, so its complement is **open**. $A$ is a closed set intersected with an open set, and there is no argument on the page that it is closed.

**Worse, the assertion is equivalent to the conclusion.** A limit of points of $A$ is critical with $\theta\ge c$ by continuity, so $\overline A\subseteq A\cup(\text{pure critical}\cap\{\theta\ge c\})$, whence
$$A\ \text{closed}\iff\overline A\cap B=\varnothing,$$
which is precisely what the next two sentences set out to prove. The proof's own structure shows this: it goes on to say *"A point of $\overline A\cap B$ is critical …, pure, and has $\theta\ge c$"*, a sentence with nothing to do if $A$ were already known closed.

**The repair is one clause, and the statement survives intact.** $\overline A$ is a closed subset of the compact $S$, hence compact, with no hypothesis at all; $B$ is compact as printed; the (iii)-argument gives $\overline A\cap B=\varnothing$; two disjoint compact sets have $d(\overline A,B)>0$; and $A\subseteq\overline A$ gives $d(A,B)\ge d(\overline A,B)>0$. So **replace "$A$ is closed in the compact $S$, hence compact" with "$\overline A$ is closed in the compact $S$, hence compact"**, and (iv) is proved.

*The rest of (iv) checks.* The $\overline A\cap B$ argument is right: such a point is critical because $\mathrm{Crit}$ is closed, pure because $B$ is exactly the unit-norm points diagonal in some frame, and carries $\theta\ge c$ by continuity, so the hypothesis delivers (ii) at it, (iii) gives it a critical-point-free punctured neighbourhood, and membership in $\overline A$ contradicts that. The closing note that the threshold must be **closed** ($\theta\ge c$, not $\theta>c$) is correct and is the load-bearing observation of the paragraph: the limit point is reached, so an open threshold would let it escape the hypothesis.

*One downstream miscue this exposes.* [ATTEMPTS.md:3715](../ATTEMPTS.md) reads *"[Lemma L128](../findings/second-order.md)(iv) needs $B=O(n)\cdot(\mathcal D_n\cap S)$ compact, which is now proved rather than assumed, the separation argument's second compact set was the one nobody had checked."* $B$'s compactness is one line and is already on the page. The set nobody had checked is $A$.

---

## D2, the box's witness is denied by the source it cites, and L128 is the one that is right

Verbatim, the box under (ii):

> A block **above** $\tfrac12$ is possible because the hypothesis is criticality, not maximality: **$S^2\times S^4$ at $n=6$ is pure, critical and Morse–Bott nondegenerate ([Lemma L11](nondegeneracy.md))**, while its $(2,2)$ four-set blocks sit at $\mu_{2,4}=\tfrac23>\tfrac12$ …

[Lemma L11](../findings/nondegeneracy.md), **corrected 2026-09-04, today**, states the opposite in its first line:

> **STATEMENT, CORRECTED 2026-09-04.** *For $p,q\ge3$ with $(p,q)\ne(3,3)$, $S^p\times S^q$ is Morse–Bott nondegenerate …* **The exceptions are two families, not one**, $(3,3)$, and **every product with $\min(p,q)=2$**.

So L128's named witness is asserted by L128 and denied by L11 on the same day, and L128 cites L11 for it.

**L11's correction is the error.** Its reason is:

> *[Lemma L26](../findings/nondegeneracy.md), sixty lines above it in this file, records that the dangerous eigenvalue **reaches** $\tfrac12$ at $p=2$ with excess $\tfrac1{2(n-3)}>0$*, a direction outside the orbit carrying the orbit's own eigenvalue, which is degeneracy.

[Lemma L26](../findings/nondegeneracy.md) uses "reaches $\tfrac12$" for $\mu\ge\tfrac12$, and distinguishes the two cases in the same sentence: *"exactly at $p=2$, where it gives the recorded excess $\tfrac1{2(n-3)}$, and at $(p,q)=(3,3)$, where it is an **equality**."* At $p=2$, $\tfrac12-\mu=\tfrac{-1}{2(q-1)}$, so $\mu=\tfrac12+\tfrac1{2(n-3)}$ **strictly above** $\tfrac12$. A direction strictly above $\tfrac12$ is not in the $\tfrac12$-eigenspace and contributes nothing to $\ker\mathrm{Hess}$. **$\mu>\tfrac12$ refutes maximality; degeneracy needs $\tfrac12$ itself.** L11's correction conflates the two, the very conflation L128's box exists to warn against, and which L11's own legacy paragraph twelve lines below still gets right: *"$S^2\times S^4$ at the same $n=6$ is nondegenerate."* L11 now contradicts itself.

**Screen (hand arithmetic, on the block data, reported as a screen).** The full $L_e$ census at $S^2\times S^4$, $n=6$, $\dim\mathcal W_6=84$, from [L121](../findings/second-order.md), [L122](../findings/second-order.md) and [L127](../findings/second-order.md) including L127's own $p=2$ correction box:

| block family | count | dim | spectrum |
| --- | --- | --- | --- |
| four-set, $(2,2)$-split | $6$ | $2$ | $\pm\tfrac23$ |
| four-set, other | $9$ | $2$ | $0,0$ |
| pair, cross-factor | $8$ | $3$ | $\tfrac12,0,0$ |
| pair, within-$F_1$ ($p=2$) | $1$ | $3$ | $(-\tfrac23)^3$ |
| pair, within-$F_2$ ($q=4$) | $6$ | $3$ | $\tfrac13,-\tfrac23,0$ |
| $\mathcal D_6$ | $1$ | $9$ | $1,\ \lambda_2\!=\!0,\ (\tfrac13)^3,\ (-\tfrac23)^3,\ 0$ |

Four independent checks close it. $\mathop{\mathrm{tr}}L_e=0+0+4-2-2=0$, which [L27](../findings/nondegeneracy.md) proves unconditionally. Multiplicity of $-\mu$: $6+3+6+3=18=\dim(S^2_0\otimes S^2_0)$. Multiplicity of $+\mu$: $6=\dim(\Lambda^2\mathbb R^2\otimes\Lambda^2\mathbb R^4)$. Multiplicity of $\tfrac12$: $8=\dim(\mathbb R^2\otimes\mathbb R^4)=pq=\dim\mathcal O$. The zero count comes to $42$ against the summand list's $44$, which is exactly the recorded $86$-against-$84$ over-count, sitting entirely at $L_e=0$ where $\mathrm{Weyl}_2$'s polynomial dimension $-2$ replaces its true $0$.

$\tfrac12$ occurs **eight times and only on the orbit**. So $\ker\mathrm{Hess}=T_W\mathcal O$ and **$S^2\times S^4$ is Morse–Bott nondegenerate**, while $\mu_{2,4}=\tfrac23$ keeps it off the maximisers. The box's witness stands and its point stands with it.

**The repair belongs in [L11](../findings/nondegeneracy.md), not here.** Its second exceptional family should be withdrawn and the $\min(p,q)=2$ case restated as what L26 actually gives: *not a local maximum*, nondegenerate all the same. Until that happens L128's box cites a source that denies it, and a reader who follows the link is left with two flatly opposed statements and no way to tell which won.

*Independently of the witness, the box's own claim is not at risk.* That (ii) excludes a value rather than bounding a spectrum is forced by $\ker\mathrm{Hess}=E_{L_e}(\tfrac12)\cap W^\perp$ being an eigenspace, which needs no example at all.

---

## C4, the hypotheses, part by part, and the withdrawn material

The brief's question 3 rests on a false premise: **the block has four parts, (i)–(iv), not three.** What each needs:

| part | needs | stated? |
| --- | --- | --- |
| (i) | frame-diagonality **alone** | over-granted: the shared line adds criticality, unit norm and $\theta>0$, and the block never says (i) uses none of them |
| (ii) | frame-diagonality, criticality, unit norm, $\theta>0$ | yes, in the shared line |
| (iii) | everything (ii) needs, plus (ii) itself | yes |
| (iv) | (ii) at **every** pure critical point with $\theta\ge c>0$; compactness of $S$ | yes |

**No part needs maximality**, so the failure mode the brief names (a hypothesis-free part run together with one needing maximality), does not arise here. It is the reverse: the one part that could have been stated hypothesis-free is not.

**The withdrawn material (question 4) leaves no residue.** The first version's strict inequalities are gone from (ii), which now reads as an exclusion of the value; the affine slice is gone from (iii), which is proved in the ambient space by the argument above. I checked every consumer:

- **Inside the block.** [Corollary L128.1](../findings/second-order.md) puts the four-set leg as "$\tfrac12$ exactly when $\Sigma=\theta^2$" and the "Where it is used" paragraph as "$\Sigma\ne\theta^2$ at every four-subset", both in the $\ne$ form. Where the corollary does use strict inequalities (the within-factor tops, the $\mathcal D_n$ values) it uses them only as a sufficient route to $\ne\tfrac12$, which is legitimate.
- **Later in the same file.** [second-order.md:859](../findings/second-order.md) (post F47) states the pair clause as $T\notin\mathop{\mathrm{spec}}(\widetilde N|_{\mathbf1^\perp})$ and says so explicitly; [second-order.md:912](../findings/second-order.md) (L133 step 3) *removes* a citation of L128.1 for "$L_e\le\tfrac12$" precisely because L128.1 delivers "$\tfrac12$ is not an eigenvalue"; [second-order.md:1220](../findings/second-order.md) (L150, withdrawn) cites the box for exactly the criticality-not-maximality point. All three are consistent with the current text, none with the withdrawn one.
- **Outside.** [ATTEMPTS.md:2991](../ATTEMPTS.md), [:3403](../ATTEMPTS.md), [:3659](../ATTEMPTS.md), [:3978](../ATTEMPTS.md) and [plan.md:182](../plan.md) all take (ii) in the exclusion form.

---

## Q6, what the fourteen citations take

Outside [reviews/](.), L128 and L128.1 are cited at these places. Grouped by what each consumes:

| what is taken | citations |
| --- | --- |
| **(ii), as an exclusion of the value $\tfrac12$** | [plan.md:182](../plan.md) (I18's theorem statement, and its closing "what the theorem still owes"), [ATTEMPTS.md:2991](../ATTEMPTS.md) ("degenerate by L128(ii)"), [ATTEMPTS.md:3403](../ATTEMPTS.md) ("L128(ii) is untouched"), [ATTEMPTS.md:3659](../ATTEMPTS.md) ("L128(ii)'s four-set clause follows from…"), [second-order.md:859](../findings/second-order.md) (post F47), [second-order.md:976](../findings/second-order.md) (post F50) |
| **the box under (ii), criticality is not maximality** | [ATTEMPTS.md:3978](../ATTEMPTS.md) ("L128(ii) warns that a block may sit above $\tfrac12$"), [second-order.md:1220](../findings/second-order.md) (L150) |
| **(iii), the isolation** | [plan.md:182](../plan.md) ("with L128 every such orbit is isolated"), [second-order.md:761](../findings/second-order.md) (L127's withdrawal box, reinstated by (iii)), [LEDGER.md:866](../findings/LEDGER.md) (the same, as a forward pointer) |
| **(iv), the uniform separation** | [second-order.md:769](../findings/second-order.md) (the threshold is closed), [ATTEMPTS.md:3715](../ATTEMPTS.md) (I5's compactness) |
| **Corollary L128.1** | [plan.md:184](../plan.md) (I18 sub-step (b) SETTLED), [ATTEMPTS.md:3067](../ATTEMPTS.md) ("L128.1 is untouched"), [plan.md:186](../plan.md) (I18e, "the L128 route") |

**No citation takes anything withdrawn**, and none takes (i) as a standalone. Two observations on the set:

- **[plan.md:184](../plan.md) marks I18 sub-step (b) SETTLED on [Corollary L128.1](../findings/second-order.md)**, which is the citation D3 bites: the corollary's headline promises every two-block sphere product at $n\ge12$ and its proof delivers only $p,q\ge3$. The item is in fact safe, the corollary's stated range floor for the band is $\min(p,q)\ge5$, and my census above extends to $p=2$ anyway, but the bold sentence a citation quotes is not the sentence that was proved.
- **[ATTEMPTS.md:3715](../ATTEMPTS.md)** takes (iv) and names the wrong compact set, as recorded under D1.

---

## D3, D4, D5, the bookkeeping

**D3.** [Corollary L128.1](../findings/second-order.md)'s bold headline reads *"every two-block sphere product at $n\ge12$ satisfies the criterion, hence is isolated"*, and its first body sentence reads *"**Assume $p,q\ge3$**"*. [r375](REVIEW_r375.md) wrote *"L128.1 should read '**every $S^p\times S^q$ with $p,q\ge3$ and $n\ge12$**'"*; the repair went into the body and left the headline. This is the failure [Lemma L120](../findings/second-order.md)'s own box names, *"THE CUT IS NOT OPTIONAL, AND THE SENTENCE ABOVE IS THE ONE EVERY CITATION QUOTES."*

**D4.** Six markdown anchors point at L128 from inside [findings/](../findings/); **four do not resolve.** The heading generates `#lemma-l128--the-branching-clause-block-checkable-nondegeneracy-at-a-pure-critical-point-and-the-isolation-it-gives`. Lines [769](../findings/second-order.md) and [1220](../findings/second-order.md) use it truncated at `…-at-a-pure-critical-point`; lines [879](../findings/second-order.md) and [912](../findings/second-order.md) use a **stale title**, `…-the-branching-clause-of-the-sign-character-decomposition`, which is no heading in the file. Only [line 761](../findings/second-order.md) resolves.

**D5.** [INDEX-results.md:146](../findings/INDEX-results.md) titles the result *"the branching clause: block-checkable nondegeneracy at a pure critical point, and the isolation **and uniform separation** it gives"*; the heading omits the second half although (iv) is in the block. The index's title is the better one.

---

## Q1, "pure (frame-diagonal)", the frame, and [Lemma L37](../findings/target.md)

**The brief's question 1 rests on a false premise, and the answer is that L128 has no use for L37.** "Pure (frame-diagonal)" is [conventions.md](../findings/conventions.md)'s sense, diagonal on the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame of $\mathbb R^n$, *not* diagonal as an operator on $\Lambda^2$, and it is exactly [L37](../findings/target.md)'s "diagonal in *some* orthonormal frame". But purity is L128's **hypothesis**, with the frame handed to it ("in a fixed frame"); L37 is a *test* for purity, which a consumer needs and L128 does not. Citing it here would be noise.

**Frame-dependence, since the brief asks.** (i) and (ii) are stated relative to the blocks of the fixed frame, so their content is per-frame; but (ii)'s left-hand side, $\ker\mathrm{Hess}(P|_S)_W=T_W\mathcal O$, is frame-free. Hence the block criterion holds in one diagonalising frame if and only if it holds in all of them, a corollary the block never remarks on, and one a consumer checking (ii) in a frame of his own choosing would want in writing.

---

## Cross-check against the rest of the record

Grepped [findings/](../findings/) for restatements of the same content. [nondegeneracy.md:678](../findings/nondegeneracy.md) and [:742](../findings/nondegeneracy.md) restate sphere-product nondegeneracy at $p,q\ge3$, consistently with [L27](../findings/nondegeneracy.md) and silent on $p=2$; [algebra.md:45](../findings/algebra.md) restates the balanced case; [graded-half.md:329](../findings/graded-half.md) restates the $p,q\ge5$ classification. **The only restatement in conflict with L128 is [L11](../findings/nondegeneracy.md)'s corrected statement**, D2.

Read [second-order.md](../findings/second-order.md) below the block for the pattern the brief warns of, a later passage silently correcting the one above. Posts F46–F51, [L133](../findings/second-order.md), [L141](../findings/second-order.md) and the withdrawn [L150](../findings/second-order.md) and [L151](../findings/second-order.md) were checked; every one that touches L128 **agrees** with it, and two of them ([:912](../findings/second-order.md), [:1220](../findings/second-order.md)) exist partly to enforce L128's own distinction against other results. **No later passage in this file contradicts the block.**

---

## Computation

**None run beyond one hand screen.** The census in D2 is arithmetic on block spectra already on the record, done to check a claim I was about to write down about $S^2\times S^4$, and it is reported as a screen rather than as evidence.

**What a run would decide, were one approved.** Nothing this review turns on. The one place a computation would settle rather than illustrate is the direct kernel dimension of $\mathrm{Hess}(P|_S)$ at $S^2\times S^4$ in exact arithmetic over $\mathbb Q$ at $n=6$: it would decide D2 against [L11](../findings/nondegeneracy.md)'s corrected statement outright rather than through the block census. A kernel of $8$ confirms L128's box and refutes L11's second exceptional family; a kernel above $8$ would refute the box and send me back to the census. I have not run it.

---

**VERDICT: PLAUSIBLE**, statements (i), (ii), (iii) and (iv) are all true and derived here independently, but the printed proof of (iv) contains a false and circular step (D1, repairable in one clause), and the box's witness is contradicted by name by [Lemma L11](../findings/nondegeneracy.md) as corrected today (D2, where L128 is right and the repair belongs in L11).
