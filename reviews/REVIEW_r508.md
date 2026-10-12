# REVIEW r508, Lemma L120

**Target**: Lemma L120, "$L_M$ is block-diagonal over the sign characters at every diagonal critical point", `findings/second-order.md` (heading `#### Lemma L120`, line 601) through the next heading.

**Reviewer**: r508, cold brief, analysis-only footing (no searches, sweeps, censuses; screening only).

**Phase plan**

1. P1, read `findings/conventions.md`, then L120 verbatim.
2. P2, dimension count of the asserted decomposition against $\dim\mathcal W_n$.
3. P3, derive the three characters; check distinctness across four-sets and pairs.
4. P4, the passage from $\mathrm{Sym}^2(\Lambda^2)$ to $\mathcal W_n$.
5. P5, "at every diagonal critical point": what the support argument and the equivariance route each need.
6. P6, the consequence (block sizes $n-3$ and $2$) and its compatibility with L24's $W^\perp$ criterion.
7. P7, index row 120, label/anchor, cross-file grep for contradicting restatements.
8. P8, verdict.

VERDICT: CONFIRMED, the theorem and both block sizes are right; four repairs listed at the foot, R2 (the unstated $W^\perp$ cut of $\mathcal D_n$) being the one that matters to the 13 citations.

## Findings

(appended as found)

### F1, the dimension count CLOSES exactly (P2)

`findings/conventions.md` **carries no $\dim\mathcal W_n$ entry**; its $\mathcal W_n$ row reads only "the space of algebraic Weyl curvature operators on $\mathbb R^n$" and points at `README.md`. The brief instructed me to take the dimension from there, and it is absent. Derived cold instead, three ways agreeing:

- $\dim\mathrm{Sym}^2(\Lambda^2)=\binom{N+1}2$, $N=\binom n2$; algebraic curvature tensors $=n^2(n^2-1)/12$; $\dim\Lambda^4=\binom n4$; $\dim\mathrm{Sym}^2(\mathbb R^n)=n(n+1)/2$.
- $\dim\mathcal W_n=n^2(n^2-1)/12-n(n+1)/2=n(n+1)(n+2)(n-3)/12$.

The block's identity:
$$\tfrac{n(n-3)}2+2\binom n4+(n-3)\binom n2=\tfrac{n(n-3)}2\Big[1+\tfrac{(n-1)(n-2)}6+(n-1)\Big]=\tfrac{n(n-3)}2\cdot\tfrac{(n+1)(n+2)}6=\tfrac{n(n+1)(n+2)(n-3)}{12}.$$
The bracket is $\big(6+(n^2-3n+2)+(6n-6)\big)/6=(n^2+3n+2)/6$. **Exact.** The block's own printed factorisation is the same one and is right. Spot check $n=4$: $2+2\cdot1+1\cdot6=10=\dim\mathcal W_4$. $n=6$: $9+2\cdot15+3\cdot15=84=\dim\mathrm{Weyl}_6$, which matches the figure the file quotes at Lemma L126.

The block's own caveat, that the identity "is transcription insurance and nothing more" and "holds verbatim at $n=4,6,8$ where the isotypic claim fails", is honest and correct, so I did not stop at the count.

### F2, the three characters are right, and they separate (P3)

$\Gamma\cong(\mathbb Z/2)^n$ acts on $\Lambda^2$ by $\gamma\cdot e_{ij}=\varepsilon_i\varepsilon_j\,e_{ij}$, so on $\mathrm{Sym}^2(\Lambda^2)$ the basis vector $e_\alpha\odot e_\beta$ ($\alpha,\beta$ two-sets) is an eigenvector with eigenvalue $\prod_{i\in\alpha}\varepsilon_i\prod_{j\in\beta}\varepsilon_j$. Repeated indices contribute $\varepsilon^2=1$, so the character is $\chi_S$ with $S=\alpha\triangle\beta$. Case by case, exactly as the block states:

| overlap | $S$ | character | count per $S$ |
| --- | --- | --- | --- |
| two indices ($\alpha=\beta$) | $\emptyset$ | trivial | $\binom n2$ vectors $e_{ij}\odot e_{ij}$ in one block |
| one index ($\alpha=\{i,j\}$, $\beta=\{i,k\}$) | $\{j,k\}$ | $\varepsilon_j\varepsilon_k$ | $n-2$ (the shared $i$ runs over $[n]\setminus\{j,k\}$) |
| none | $\{i,j,k,l\}$ | $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$ | $3$ (the three pairings of the $4$-set) |

**Separation holds.** $S\mapsto\chi_S$ is a group isomorphism $2^{[n]}\to\widehat\Gamma$: $\chi_S=\chi_T\Rightarrow\chi_{S\triangle T}\equiv1\Rightarrow S\triangle T=\emptyset$. So distinct $4$-sets, distinct pairs, and $\emptyset$ give **pairwise distinct** characters at every $n$, nothing merges, and the three families above are the *full* isotypic components, the block sizes are therefore maximal, not merely upper bounds. The $\Gamma$-invariance of the trace pairing then makes the summands mutually orthogonal.

**The $\Gamma\cap SO(n)$ box is correct, including its list.** On $\Gamma\cap SO(n)$, $\chi_{[n]}\equiv1$ so $\chi_S=\chi_{S^{\mathsf c}}$; a fusion between two *occurring* characters needs $|S|,|S^{\mathsf c}|\in\{0,2,4\}$, hence $n\le8$ **and $n$ even** (odd $n$ makes $|S^{\mathsf c}|$ odd, which never occurs). That leaves exactly $n=4$ ($\emptyset$ with the $4$-set), $n=6$ ($2$-set with $4$-set), $n=8$ (two complementary $4$-sets), the three the box lists, and no others.

### F3, the passage to $\mathcal W_n$: the $2$ and the $n-3$ ARE the post-subtraction dimensions (P4)

This was the brief's sharpest question and the answer is that the block already did the subtraction. $\mathcal W_n$ is $\Gamma$-invariant and the Weyl conditions are $\Gamma$-equivariant, so they cut each character space separately. Per character:

- **Trivial.** A tensor here is $R_{ijij}=M_{ij}$ only. First Bianchi is empty (it is non-trivial only on four distinct indices, with a repetition it collapses to $0=0$ by pair symmetry and antisymmetry). $\mathrm{Ric}_{ab}=\sum_cR_{acbc}$ has index symmetric difference $\{a,b\}$, so only $\mathrm{Ric}_{aa}=\sum_cM_{ac}$ survives: **$n$ conditions**, and they are independent (the row-sum map on hollow symmetric matrices is onto $\mathbb R^n$ for $n\ge3$; checked by hand at $n=4$, rank $4$, kernel dimension $2$). $\binom n2-n=\tfrac{n(n-3)}2=\dim\mathcal D_n$. **✓**
- **Pair $\{j,k\}$.** $\Lambda^4$ contributes nothing (it lives only on four distinct indices). $\mathrm{Ric}_{jk}=\sum_{i\notin\{j,k\}}x_i$ is the one and only surviving Ricci component and gives **one** condition; Bianchi is empty. $(n-2)-1=n-3$. **✓** The Ricci part $\mathrm{Sym}^2(\mathbb R^n)$ sits here with exactly one dimension per pair (the off-diagonal $h_{jk}$ of the Kulkarni–Nomizu factor), which is the same count from the other side.
- **$4$-set.** $\mathrm{Ric}$ is identically zero (a trace needs a repeated index), Bianchi gives the single relation $R_{ijkl}+R_{iklj}+R_{iljk}=0$. $3-1=2$, and the removed line is exactly the $1$-dimensional $\Lambda^4$ component of that $4$-set. **✓**

Cross-check from the other direction: $\dim\mathrm{Sym}^2(\mathbb R^n)=n+\binom n2$ splits as $n$ inside the trivial character (diagonal $h$) and $1$ per pair character; $\dim\Lambda^4=\binom n4$ sits one per $4$-set character. Subtracting these from $\binom n2$, $n-2$, $3$ gives $\tfrac{n(n-3)}2$, $n-3$, $2$. **So no, they are not the $\mathrm{Sym}^2(\Lambda^2)$ dimensions carried over unchanged**, the ambient ones are $\binom n2$, $n-2$, $3$, and the block prints the cut ones. This is the point on which a reviewer might have expected a break, and it does not break.

### F4, block-diagonality needs diagonality, and NOT criticality; the hypothesis is over-strong (P5)

*"Diagonal" here is `findings/conventions.md`'s sense: diagonal in the coordinate $2$-planes $e_i\wedge e_j$ of an orthonormal frame, i.e. as an element of $\mathrm{Sym}^2(\Lambda^2)$ a combination of $e_{ij}\odot e_{ij}$, **not** diagonal as an operator on $\Lambda^2$.*

**The equivariance route verifies cleanly, and $M$ is $\Gamma$-invariant for a sharp reason.** By Lemma L123's own step, the trivial character space is *precisely* the span of the $e_{ij}\odot e_{ij}$. So `conventions.md`'s "diagonal" is literally "lies in the $\Gamma$-trivial isotypic", which is "$\gamma\cdot M=M$ for all $\gamma\in\Gamma$". Then, $\circ$ being $O(n)$-equivariant and $\Gamma\subset O(n)$,
$$\gamma\cdot(M\circ X)=(\gamma\cdot M)\circ(\gamma\cdot X)=M\circ(\gamma\cdot X),$$
so $L_M$ is $\Gamma$-equivariant and preserves every isotypic component. **Criticality is never used.** The block's title and statement say "at every diagonal critical point $M$"; the true hypothesis is diagonality alone.

This is not a defect (it is an over-strong hypothesis, safe for every consumer) but it is an **internal inconsistency of the file**, because thirty lines below, Lemma L122 says "**Diagonality alone is needed, not criticality**" for its own pair-block form, and Lemma L123's scope paragraph says the same for L121. L120 is the parent claim and carries the *narrower* scope of its children. The wider scope is exactly what makes L120 applicable to $\operatorname{diag}(M)$ in a frame where $W$ is not diagonal, which is the use L123 puts it to.

**A step the block omits.** The support route is stated as showing "$L_M$ preserves each $4$-set and each pair block". That does not, on its face, cover the trivial block $\mathcal D_n$, which the decomposition also asserts. It follows, but only via **self-adjointness of $L_M$** (on record in Lemma L24, "$L_e$ is self-adjoint"): the trivial block is the orthogonal complement of the others, so a self-adjoint operator preserving them preserves it. The block does not say this. The equivariance route has no such gap.

**Robustness to the Weyl projection.** Whether $L_M$ maps $\mathcal W_n$ into itself directly (via $Q(\mathcal W_n)\subseteq\mathcal W_n$, cited to Böhm–Wilking at line 761) or only after $\Pi_{\mathcal W_n}$, block-diagonality survives, because $\Pi_{\mathcal W_n}$ is $O(n)$-equivariant hence $\Gamma$-equivariant. L120 therefore does not rest on that input.

### F5, the consequence: one of the two numbers is wrong at $n=4$, and the $W^\perp$ cut is unstated (P6)

The sentence audited: *"the largest block a non-diagonal direction occupies has size $n-3$, and $\binom n4$ of them have size $2$."*

**Second number: correct.** There are $\binom n4$ four-set blocks, each of dimension $2$ after the Bianchi cut. ✓

**First number: correct for $n\ge5$, FALSE at $n=4$.** The non-diagonal blocks are the $4$-sets (size $2$) and the pairs (size $n-3$), so the largest is $\max(2,n-3)$:

| $n$ | $\dim\mathcal D_n$ | $4$-set size | pair size $n-3$ | largest non-diagonal | claim |
| --- | --- | --- | --- | --- | --- |
| $4$ | $2$ | $2$ | $1$ | $\mathbf 2$ | says $1$, **wrong** |
| $5$ | $5$ | $2$ | $2$ | $2$ | right (tie) |
| $\ge6$ |, | $2$ | $n-3$ | $n-3$ | right |

At $n=4$ the decomposition itself is still exact ($2+2\cdot1+1\cdot6=10=\dim\mathcal W_4$); it is only the "largest is $n-3$" reading that inverts. Low severity ($n=4$ is also where the block's own $\Gamma\cap SO(n)$ warning bites hardest) but the sentence as printed is false at a dimension the programme uses.

### F6, the block-by-block check is compatible with L24, but ONE block is cut and the block does not say so

L24's criterion is $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, $W^\perp$ being the tangent space at $W$. At a **diagonal** critical point, $M$ lies in the trivial character space, i.e. **$M\in\mathcal D_n$**. Hence

$$W^\perp=\big(\mathcal D_n\ominus\langle M\rangle\big)\ \oplus\ \bigoplus_{\{i,j,k,l\}}V_{ijkl}\ \oplus\ \bigoplus_{\{j,k\}}V_{jk}.$$

**The restriction cuts exactly one block, $\mathcal D_n$, and cuts it by exactly one dimension.** Every $4$-set and every pair block lies wholly inside $W^\perp$ and is checkable whole, which is why L121 and L122 are entitled to state their inequalities on the full block. So block-by-block checking is compatible with L24. ✓

**But the omission is load-bearing on the one block that is cut.** By L24's own $L_ee=e$ (re-derived cold: $e\circ e=\tfrac12(Q(2e)-2Q(e))=Q(e)=Q(W)/\theta^2=e$), the trivial block contains an eigenvector of $L_e$ at eigenvalue $\mathbf 1$ (twice the bound), at **every** critical point. A consumer reading "L24's criterion is checkable block by block" literally and applying $\lambda_{\max}\le\tfrac12$ to the whole of $\mathcal D_n$ therefore concludes that **no** diagonal critical point is a maximiser, vacuously and falsely. The block's only hedge is the word "non-diagonal" in the following clause; it never states the $\mathcal D_n\ominus\langle M\rangle$ cut.

*The record does know this elsewhere*: `plan.md` line 51 says outright "**the restriction to $W^\perp$ is not optional**, since $L_ee=e$ forces $\lambda_{\max}(L_e)\ge1$", and Lemma L125 exists for precisely this. The gap is L120's own text, at the sentence the 13 citations quote.

### F7, the label, the anchor, and the index row (P7)

- **Dead anchor, confirmed.** Line 605's `[Lemma L24](#)` points nowhere, while the correct target `#lemma-l24--second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement` is used in the *same file* at lines 698, 751, 757, 761, 771, 865. Same defect at lines 619, 633, 652 (twice), 656, 682, the whole L120–L124 stretch links L24, L121, L122 and L123 with a bare `#` while later blocks link them properly. Cosmetic, but it is exactly the stretch a reader arrives at from the index.
- **The label is honest.** `findings/INDEX-results.md` row 138 reads `| **120** | Lemma | ... |` with no Gate 2 annotation. Under that file's own rule ("**Lemma** is proven, Gate 1 and Gate 2 passed"), a bare `Lemma` is a positive claim, and the block backs it: the section header carries "*Gate 2, [r345] and [r346] on identical briefs*", two reviewers, both of whom refuted the group and supplied the repair now printed in the box. **This is unlike the three results the brief flags**; L120 does not claim a Gate 2 it did not have. The short name in the index matches the heading verbatim. ✓
- One structural nit: the Gate 2 attribution sits above the `##` section heading, so it covers L120 *and* L121 without naming which reviewer verdict attaches to which.

### F8, downstream: two citations carry a restriction L120 removed

Grepped `findings/`, `plan.md` and `results.md` for restatements. No file states a different set of dimensions or a different group. Two over-restrictions, both in the safe direction:

- **`findings/second-order.md` line 761** (Lemma L127's scope): "the decomposing group is the full sign group of [Lemma L120], **harmless at $n\ge9$ where nothing fuses**." The $n\ge9$ threshold belongs to $\Gamma\cap SO(n)$. L120's own box says the repair is free and the full group's even-subset characters are "pairwise distinct at **every** $n$", which I verified in F2. So the caveat attached here is void, and it wrongly suggests L127 is limited to $n\ge9$.
- **`plan.md` line 167**: "harmless at $n\ge12$, where no complement of an occurring character occurs." The sharp threshold is $n\ge9$, which L120 prints correctly; $n\ge12$ is true but not sharp.
- **`plan.md` line 141** ("The $4$-set planes are mutually orthogonal at every $n\ge4$ ([Lemma L120])"), **does** follow: distinct $4$-sets carry distinct characters (F2) and the pairing is $\Gamma$-invariant. ✓

No passage in `findings/second-order.md` contradicts the block. Line 642's use of L120 as the test that kills the halved L122 (a form whose row sums vary, so it fails to preserve the Ricci cut) is a correct application of the decomposition.

## Verdict

**VERDICT: CONFIRMED**

The lemma's substance is correct and I rebuilt every step of it from the definitions without using the block's proof:

1. The decomposition is exact. The dimension identity closes to $n(n+1)(n+2)(n-3)/12$ with no slack in any summand (F1).
2. The three characters are the ones printed, and $S\mapsto\chi_S$ being injective, the summands are the **full** isotypic components and are mutually orthogonal, so the block sizes are exact, not bounds (F2).
3. The passage from $\mathrm{Sym}^2(\Lambda^2)$ to $\mathcal W_n$ is sound and the stated $2$ and $n-3$ are the **post-subtraction** dimensions, $\Lambda^4$ taking one line per $4$-set and $\mathrm{Sym}^2(\mathbb R^n)$ one per pair plus $n$ from the trivial block (F3).
4. Block-diagonality holds by $\Gamma$-equivariance, `conventions.md`'s "diagonal" being literally "$\Gamma$-fixed", and is robust to whether $L_M$ carries a Weyl projection (F4).
5. The $\Gamma\cap SO(n)$ warning box is correct in full, including that the fusions are exactly $n=4,6,8$ and that the full group's characters are distinct at every $n$ (F2).

**Four repairs the block needs, none of which touches the theorem.**

| # | where | what | severity |
| --- | --- | --- | --- |
| R1 | statement, last clause | "the largest block a non-diagonal direction occupies has size $n-3$" is **false at $n=4$**, where it is $2$. Write $\max(2,n-3)$, or restrict to $n\ge5$ (F5) | low, but printed and false |
| R2 | statement, "checkable block by block" | say that $W^\perp$ cuts $\mathcal D_n$ by $\langle M\rangle$ and cuts nothing else. Without it the literal reading is vacuously false at **every** critical point, since $L_ee=e$ sits in $\mathcal D_n$ (F6) | **highest**, this is the sentence the 13 citations quote |
| R3 | title and statement | criticality is **unused**; diagonality alone suffices. As printed, the parent claim is narrower than L122's and L123's own scope corrections thirty lines below (F4) | medium, safe direction |
| R4 | line 605 (and 619, 633, 652, 656, 682) | `[Lemma L24](#)` and siblings are dead anchors; the working anchors exist in the same file (F7) | cosmetic |

**Plus, downstream:** `findings/second-order.md` line 761 and `plan.md` line 167 attach an $n\ge9$ / $n\ge12$ restriction to the **full** sign group, which L120 itself removes (F8).

**And a record gap outside the target:** `findings/conventions.md` carries no $\dim\mathcal W_n$ entry, though the audit brief for this lemma directs reviewers to take it from there.

**No computation was run.** Every check above is arithmetic and linear algebra done by hand; nothing here required a screen.
