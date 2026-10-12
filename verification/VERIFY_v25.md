# VERIFY v25, L148: simultaneous diagonality on the $S^2_0(\mathbb R^m)$ summand, $\mathrm{Alt}(W(t)_-)=0$ for every $t$, and the clause "both defect branches are absent"

*Cold brief, from [ROUND_L148.md](ROUND_L148.md)'s provenance-stripped quotation of [Lemma L148](../findings/second-order.md). **No numerical work was done**: no script was run, and every value below is an exact hand evaluation of a closed form. Log: [agent_logs/verify-L148-v25.log](../agent_logs/verify-L148-v25.log).*

## Claim table

| # | claim, as the box states it | verdict |
|---|---|---|
| 1 | $W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes, for $H$ in $S^2_0(\mathbb R^m)$ | **PROVEN, HYPOTHESES CORRECTED.** True, and re-derived here from the Kulkarni–Nomizu definition. It needs a frame chosen to diagonalise $h$, which the box does not say, and it needs the $SO(V_1)\times SO(V_2)$-invariance of $W^*$ to make that choice free |
| 2 | hence so is $W(t)=W^*+tH$, and so is $W(t)_-$ | **PROVEN.** Both steps are trivial for a coordinate-diagonal operator, and the second needs only continuous functional calculus, no analyticity, no spectral gap, no Daleckii–Krein |
| 3 | therefore $\mathrm{Alt}(W(t)_-)=0$ for every $t$ | **PROVEN.** $\mathrm{Alt}$ annihilates every coordinate-diagonal element of $S^2(\Lambda^2)$; derived in full in §3 |
| 4 | *the defect is identically zero along the whole segment* | **PROVEN, AND STRONGER THAN STATED.** It holds for every real $t$, on the straight segment, on the great circle in $S$, and through every $t$ at which $W(t)$ acquires a kernel |
| 5 | on **both** $S^2_0(\mathbb R^m)$ copies (pre-registered question 1) | **TRUE, BUT UNWRITTEN.** The box names one copy. The extension to the joint two-copy eigenspace holds, by two independent rotations on disjoint blocks; that argument is nowhere on file |
| 6 | *both defect branches are absent there* | **REFUTED AS READ.** Under the record's own nearest antecedent, [Lemma L147](../findings/second-order.md) eight lines above, which calls branches 1 and 2 "both defect branches" and declares their joint absence *impossible in principle*, the clause is false: branch 1 equals $c_p/S$ on the summand, finite and non-zero. A charitable reading survives (§6) but the record supplies no definition to pick it |
| 7 | downstream use (a): it "makes $a=0$" and so branch 1 "is minimised at $w=0$" | **NOT SUPPORTED.** L148 gives $u=0$, not $a=0$; and $u=0$ makes branch 1 **largest**, not smallest, whenever $a>0$. Concrete falsifier at a named object in §7 |
| 8 | downstream use (b): a defect branch is *unbounded* at $w=0$ | **SUPPORTED**, once claim 5 is written down. $A\equiv0$ on the segment forces $\lVert A''\rVert=0$ and, by the identity theorem, the Cauchy supremum $M=0$ as well |

**One line the round can act on: the mathematics of L148 is correct and is stronger than the box claims, but the box must gain two hypotheses (an $H$-adapted frame, and both copies) and lose its final clause, and [Lemma L149](../findings/second-order.md)'s parenthetical "L148 makes $a=0$ … so the first is minimised at $w=0$" is a misuse that L148 cannot carry.**

## 0. Conventions, fixed once

- $\Lambda^2$ carries the coordinate $2$-plane basis $\{e_i\wedge e_j\}$. An element $R\in S^2(\Lambda^2)$ is **coordinate-diagonal** when $\langle R(e_i\wedge e_j),e_k\wedge e_l\rangle=0$ for $\{i,j\}\ne\{k,l\}$.
- $\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$, $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$, [conventions.md](../findings/conventions.md), line 94.
- $W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$, [conventions.md](../findings/conventions.md), line 95. On a diagonal operator with entries $\lambda_\alpha$ this is $\mathrm{diag}(\max(-\lambda_\alpha,0))$.
- $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$; $n=2m$; $V_1\oplus V_2=\mathbb R^n$ with orthonormal bases $B_1,B_2$; $W^*$ the unit-norm Weyl tensor of $S^m\times S^m$.
- $u:=\lVert D(\mathrm{Alt}\,W_-)_{W^*}[H]\rVert$, the defect's linear rate ([Lemma L133](../findings/second-order.md)); $w$ the weight of $H$ outside both $S^2_0$ copies; $S=\sup\lvert P\rvert$; $c_p$ the margin; $a$ the chain coefficient of [Lemma L147](../findings/second-order.md)'s $f(u)=(c_p+u^2)/(S+au)$.

## 1. Hypothesis inventory

**Carried by the statement, explicitly.** Exactly two: that $H$ lies in $S^2_0(\mathbb R^m)$, and that the base point is $W^*$. No dimension, no parity, no kernel condition, no orthogonality condition appears in the box.

**Used by the written proof but absent from the statement.**

| hypothesis | why the proof needs it | does it hold at the object? |
|---|---|---|
| $W^*$ is the balanced product's Weyl tensor, $n=2m$ | the whole diagonality claim; $W^*=\text{const}\cdot(P_{\Lambda^2V_1}+P_{\Lambda^2V_2}-\tfrac{m-1}{2m-1}\mathrm{id})$ is what is diagonal in *every* $V_1\oplus V_2$-adapted frame | yes, [Lemma L133](../findings/second-order.md) step 1 |
| $W^*$ is $SO(V_1)\times SO(V_2)$-invariant | licenses choosing the frame *after* $H$ is given, which is what makes the claim true for non-diagonal $h$ | yes, each of $\mathrm{id}$, $P_{\Lambda^2V_1}$, $P_{\Lambda^2V_2}$ is fixed by $\Lambda^2 g$ for $g\in SO(V_1)\times SO(V_2)$ |
| $\mathrm{Alt}$ and $x\mapsto x_-$ are $O(n)$-equivariant | transports the conclusion back out of the $H$-adapted frame | yes, $\mathrm{Alt}$ is a projection onto an $O(n)$-subrepresentation; $\lvert\cdot\rvert$ commutes with conjugation |
| the $S^2_0(\mathbb R^m)$ summand embeds as the Weyl image of $h\owedge g_q$, and that image is coordinate-diagonal | supplies the diagonality of $H$ itself | yes, [Lemma L146](../findings/second-order.md), re-derived from scratch in §2 below |
| $m\ge3$ | at $m=2$, $S^2_0(\mathbb R^m)$ drops out of $\mathrm{Weyl}_n$ entirely ([nondegeneracy.md](../findings/nondegeneracy.md), line 682), so the statement is vacuous rather than false | inherited, unstated |

**Hypotheses the neighbouring lemmas carry that L148 does *not* use.** $\ker W^*=0$; the spectral gap $g_n$; real-analyticity of $W\mapsto W_-$; $H\perp W^*$; $H\perp T_{W^*}\mathcal O$; $n\ge12$; $m\ge5$ or $m\ge6$. **No finding here, and this is the lemma's real strength:** every one of these is needed by [Lemma L145](../findings/second-order.md), [Lemma L147](../findings/second-order.md) and [Lemma L149](../findings/second-order.md), and none of them is needed by L148, because functional calculus on a diagonal matrix is entrywise whether or not the spectrum meets zero. The two orthogonality conditions hold anyway: $S^2_0(\mathbb R^m)$ is one of [Lemma L27](../findings/nondegeneracy.md)'s ten summands, distinct from $\langle W\rangle$ and from the orbit summand $\mathbb R^p\otimes\mathbb R^q$.

**Imports, each checked at source.** [Lemma L146](../findings/second-order.md)'s embedding table (checked in §2, exactly); [conventions.md](../findings/conventions.md)'s $\mathrm{Alt}$ and $W_-$ (checked in §3); [Lemma L133](../findings/second-order.md) step 1's spectral data for $W^*$ and step 2's support table (checked in §4); [Lemma L27](../findings/nondegeneracy.md)'s ten-summand decomposition, used only to place $S^2_0(\mathbb R^m)$ inside $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$.

## 2. The embedding is coordinate-diagonal, derived, not cited

[Lemma L146](../findings/second-order.md) asserts the table this lemma rests on. I rebuild it from the Kulkarni–Nomizu definition, because everything downstream turns on the single word *diagonal*.

Write $(h\owedge k)_{ijkl}=h_{ik}k_{jl}+h_{jl}k_{ik}-h_{il}k_{jk}-h_{jk}k_{il}$, take $h\in S^2_0(V_1)$ extended by zero, and $g_q=I_{V_2}$, $g_p=I_{V_1}$, $g=g_p+g_q$.

**The Ricci tensor.** $\mathrm{Ric}(h\owedge g_q)_{jl}=\sum_i(h\owedge g_q)_{ijil}=\operatorname{tr}(h)(g_q)_{jl}+q\,h_{jl}-(hg_q)_{jl}-(g_qh)_{jl}$. Here $\operatorname{tr}(h)=0$ and $hg_q=g_qh=0$, the two tensors having disjoint support, so $\mathrm{Ric}(h\owedge g_q)=q\,h=m\,h$. **This reproduces [Lemma L146](../findings/second-order.md)'s corrected line exactly**, and it is the reason the projection term survives.

**The Weyl projection.** With the record's projector ([nondegeneracy.md](../findings/nondegeneracy.md), line 375) $P(X)=Y-\tfrac2{n-2}\mathrm{KN}(\rho_0)-\tfrac1{n(n-1)}s\,\mathrm{KN}(g)$, $Y=X-\mathrm{Alt}(X)$ and $\mathrm{KN}(h)=\tfrac12(h\owedge g)$: here $\mathrm{Alt}(X)=0$ by §3, $\rho_0=mh$ is already traceless, and $s=\operatorname{tr}\mathrm{Ric}=0$. Hence
$$H\;=\;P(h\owedge g_q)\;=\;(h\owedge g_q)-\tfrac{m}{2m-2}\big(h\owedge g_p+h\owedge g_q\big)\;=\;\alpha\,(h\owedge g_q)-\beta\,(h\owedge g_p),$$
$$\alpha=1-\tfrac{m}{2m-2}=\tfrac{m-2}{2(m-1)},\qquad\beta=\tfrac{m}{2(m-1)},$$
matching [Lemma L146](../findings/second-order.md)'s $\alpha$ and $\beta$ on the nose.

**Diagonality, and the three plane types.** For diagonal $h$, an entry $(h\owedge k)_{ijkl}$ with $\{i,j\}\ne\{k,l\}$ needs $h_{ik}k_{jl}\ne0$, hence $i=k$ and $j=l$, hence $\{i,j\}=\{k,l\}$, a contradiction; the other three terms fail the same way. **So $h\owedge g_q$ and $h\owedge g_p$ are both coordinate-diagonal, and so is $H$.** Evaluating the diagonal entries:

| plane | $(h\owedge g_q)$ | $(h\owedge g_p)$ | $H$ |
|---|---|---|---|
| $e_a\wedge e_b$, $a\in B_1$, $b\in B_2$ | $h_a$ | $0$ | $\alpha h_a$ |
| $e_a\wedge e_{a'}$, $a,a'\in B_1$ | $0$ | $h_a+h_{a'}$ | $-\beta(h_a+h_{a'})$ |
| $e_b\wedge e_{b'}$, $b,b'\in B_2$ | $0$ | $0$ | $0$ |

This is [Lemma L146](../findings/second-order.md)'s displayed table, recovered independently. **No finding: the import L148 leans on is correct where L148 leans on it.**

## 3. $\mathrm{Alt}$ annihilates every coordinate-diagonal $R$

Let $R\in S^2(\Lambda^2)$ be coordinate-diagonal. Two cases exhaust $\mathrm{Alt}(R)_{ijkl}$.

- **Four distinct indices.** $R_{ijkl}$ pairs the planes $e_i\wedge e_j$ and $e_k\wedge e_l$, which are distinct; $R_{iklj}$ pairs $e_i\wedge e_k$ with $e_l\wedge e_j$, distinct; $R_{iljk}$ pairs $e_i\wedge e_l$ with $e_j\wedge e_k$, distinct. All three vanish, so the sum does.
- **A repeated index**, say $k=i$ with $j\ne l$. Then $\mathrm{Alt}(R)_{ijil}=\tfrac13(R_{ijil}+R_{iilj}+R_{ilji})$. The first pairs $e_i\wedge e_j$ with $e_i\wedge e_l$, distinct planes, so zero; the second vanishes because $e_i\wedge e_i=0$; the third is $-R_{ilij}$, again off-diagonal, so zero.

Hence $\mathrm{Alt}(R)=0$. Applied to $W(t)_-$: $W(t)=W^*+tH$ is coordinate-diagonal in the $H$-adapted frame, $W(t)_-=\mathrm{diag}(\max(-\lambda_\alpha(t),0))$ is coordinate-diagonal in the same frame, and $\mathrm{Alt}(W(t)_-)=0$ for every $t\in\mathbb R$. $\square$

**Calibration of the convention, by hand.** At the $\mathbb{CP}^2$-type competitor the record has $\mathrm{Alt}(u_-)=a\star$ with $a=\tfrac1{3\sqrt6}$ and $\lVert\star\rVert^2=6$, giving $\delta^2=6a^2=\tfrac6{54}=\tfrac19$, the record's own value. So the $\mathrm{Alt}$ and $W_-$ used above are the ones the rest of the file uses, and the vanishing proved here is a vanishing of the same quantity.

## 4. Quantifier order and scope, step by step

The brief asks what makes each transfer legitimate. Naming them in order:

1. **$W^*$ diagonal.** Legitimate in *any* orthonormal frame with $B_1\subset V_1$ and $B_2\subset V_2$, because $W^*$ is a linear combination of $\mathrm{id}$, $P_{\Lambda^2V_1}$ and $P_{\Lambda^2V_2}$, each $SO(V_1)\times SO(V_2)$-invariant.
2. **$H$ diagonal.** Legitimate only in a frame in which $h$ is diagonal. **This is the load-bearing quantifier, and the box hides it.** Read literally against a fixed coordinate system, "the tensors $W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes" is *false* for every $h$ that is not diagonal in that system, and $S^2_0(\mathbb R^m)$ is mostly such $h$.
3. **The repair, which is available and unwritten.** Given $H$, pick $g\in SO(V_1)$ diagonalising $h$; step 1 says $W^*$ survives it. The conclusion $\mathrm{Alt}(W(t)_-)=0$ is a frame-free statement about a tensor, and $\mathrm{Alt}$ and $x\mapsto x_-$ are $O(n)$-equivariant, so proving it in the rotated frame proves it. **Quantifier order after repair: for every $H$ in the summand there exists a frame such that … ; the conclusion then holds for every $H$.** The box's order (one frame, all $H$), is not what the argument delivers and is not true.
4. **$W(t)$ diagonal.** Sum of two diagonals; legitimate, uniformly in $t$.
5. **$W(t)_-$ diagonal.** $W_-=\tfrac12(\lvert W\rvert-W)$ is a continuous function applied by spectral calculus; on a diagonal matrix it acts entrywise. **Legitimate at every $t$, including every $t$ at which $W(t)$ is singular**, the step needs continuity of $x\mapsto x_-$, not differentiability, so no spectral gap and no analyticity is consumed.
6. **$\mathrm{Alt}(W(t)_-)=0$.** §3.

**Cross-check against a Gate-2-confirmed result.** [Lemma L133](../findings/second-order.md)'s step-2 support table says $\mathrm{Alt}\,DW_-[H]$ is carried only by $x=H_{ij,kl}$ on $(2,2)$-split four-sets. For $H$ in the summand every such $x$ is an off-diagonal entry, hence zero, hence $u=0$. **So the first-order half of L148 is already in the record, inside a lemma that passed Gate 2** ([r419](../reviews/REVIEW_r419.md), [r420](../reviews/REVIEW_r420.md)); L148's contribution is the all-orders upgrade, and the two agree where they overlap. That is corroboration, not evidence.

**Pre-registered question 2, answered.** *"Identically"* is claimed for every $t$, and the proof establishes **both** quantifiers (every $t\in\mathbb R$ **and** every direction in the summand) but the direction quantifier is delivered only through the frame repair of item 3. Two further scopes the box does not claim and the argument nonetheless gives:

- **The curve.** The chain works on the unit sphere $S$, not on the straight segment. This costs nothing: $\cos t\,W^*+\sin t\,H$ lies in $\mathrm{span}\{W^*,H\}$, hence is coordinate-diagonal, hence has zero defect directly; and for $\cos t>0$ it equals $\cos t\,(W^*+\tan t\,H)$, so positive homogeneity $(\lambda W)_-=\lambda W_-$ makes the two statements the same one. **No finding.**
- **Kernel crossings.** $W(t)$ acquires a kernel at any $t$ where an entry $\lambda_\alpha(t)$ crosses zero; at those $t$ the map $W\mapsto W_-$ is not differentiable, and $u$, $\rho$, $M$ are undefined. The claim survives because it is a claim about a *value*. **No finding, and worth recording as a strength.**

## 5. The edge of every range

- **Smallest admissible dimension.** The box states none. The argument needs $m\ge3$: at $m=2$ the summand is not in $\mathrm{Weyl}_n$ at all ([nondegeneracy.md](../findings/nondegeneracy.md), line 682), so the statement is vacuous. It does **not** need $n\ge12$, $m\ge5$ or $m\ge6$; those govern where the *margin* sits ([Lemma L146](../findings/second-order.md)) and what the downstream chain may do with the conclusion, not whether the defect vanishes.
- **Odd $n$.** Out of scope: $W^*=S^m\times S^m$ forces $n=2m$. The box does not say so, and the sentence "at $W^*$" is the only thing carrying it. No claim is made at odd $n$ and none is needed.
- **$\ker W\ne0$, and the named witness.** $W_{\mathbb{CP}^2}$, Morse–Bott nondegenerate with $\dim\ker W=3$: **L148 asserts nothing there.** Its base point is fixed to the balanced product, where $\ker W^*=0$ and the gap is $g_n=\sqrt{2(n-2)}/(n\sqrt{n-1})$; and $S^2_0(\mathbb R^m)$ is a summand of [Lemma L27](../findings/nondegeneracy.md)'s sphere-product decomposition, which has no meaning at the competitor. The point that matters for the round: the witness voids $g_n$, $\rho$, $M$ and branches 2–3 for [Lemma L147](../findings/second-order.md) and [Lemma L149](../findings/second-order.md), **and it does not touch L148**, whose only analytic ingredient is continuity. If anything, the witness is the reason to prefer L148's route: it is the one link in this chain that a kernel cannot break.

## 6. The clause "both defect branches are absent there"

**Locate.** [findings/second-order.md](../findings/second-order.md), line 1187, closing the box: *"the defect is identically zero along the whole segment, **and both defect branches are absent there**."*

**Exhibit the failure concretely.** Eight lines above, [Lemma L147](../findings/second-order.md) at line 1179 names the pair: *"So the cubic branch always shadows the quartic, and 'both defect branches moved out of the way' is impossible in principle."* Under that naming, "both defect branches" is branch 1 (cubic) together with branch 2 (quartic). On the summand, branch 1 is
$$f(0)=\frac{c_p+0^2}{S+a\cdot0}=\frac{c_p}{S}=\Theta(n^{-1-\beta}),$$
finite, non-zero, and **exactly the quantity [Lemma L149](../findings/second-order.md)'s headline $r_n\gtrsim n^{-1-\beta}$ reports**. A branch that supplies the chain's published bound has not been absented. So the two adjacent lemmas assert a proposition and its negation about the same pair of branches.

**Argue the opposite.** The most charitable reading the words support: *"the defect branches"* means the branches that exist **only** to control the defect, branch 2, whose denominator is $\lVert A''\rVert$, and branch 3, the validity cap $\rho/2$, which is imposed solely so the Cauchy estimate on $A$ is legal. Both are vacuous when $A\equiv0$, so under this reading the clause is true. Every downstream consumer reads it this way: [Lemma L149](../findings/second-order.md)'s *"the branch is unbounded there"* and [Lemma L157](../findings/second-order.md)'s *"At $w=0$ there is no branch 2 to optimise"* both keep branch 1 alive at $c_p/S$.

**Standing.** The finding survives all three steps as an ambiguity that inverts the meaning, not as an outright error: the record supplies no definition of "defect branch", its nearest usage is [Lemma L147](../findings/second-order.md)'s and makes the clause false, and its downstream usage is the other one and makes it true. **The clause should be struck and replaced by what is actually proved, branches 2 and 3 are vacuous on the summand, branch 1 takes the value $c_p/S$ there.**

## 7. The gap between what is proven and what is used

### (a) Setting $a=0$ in $(c_p+u^2)/(S+au)$, **not supported**

**Locate.** [Lemma L149](../findings/second-order.md), line 1212: *"the first is minimised at $w=0$, right on the summand where it is applied, since [L148] makes $a=0$ on both $S^2_0$ copies and $f$'s minimum is interior only for $a>0$."*

**Exhibit the failure concretely, at a named object.** L148 delivers $\mathrm{Alt}(W(t)_-)\equiv0$, hence $u=0$ on the summand. It says nothing whatever about $a$, which is a coefficient of the chain, not a function of the direction, [Lemma L157](../findings/second-order.md), line 1262, prices it as $a\propto(1-\eta)^{-2}$. Now take [Lemma L26](../findings/nondegeneracy.md)'s direction inside a single $(2,2)$-split four-subset, in [Lemma L133](../findings/second-order.md)'s signed coordinates $H=\alpha(2,-1,-1)$. It is a named object of this record, and step 2 of L133 gives it
$$\lVert\mathrm{Alt}\,DW_-[H]\rVert^2=\tfrac{\gamma}{3}x^2=\tfrac{\gamma}{3}(2\alpha)^2>0,\qquad\text{so }u>0 .$$
With $a>0$ and $f'(0)=-ac_p/S^2<0$, that direction has $f(u)<f(0)=c_p/S$. **So $w=0$ is where branch 1 is largest, not smallest**, L148 forces the argument of $f$ to the one point at which $f$ attains its maximum over $[0,u^*]$, and the interior minimum $f(u^*)=\Theta(\min(c_p/S,\sqrt{c_p}/a))$ that [Lemma L147](../findings/second-order.md) line 1179 identifies is untouched.

**Argue the opposite.** Read $a$ as "the coefficient of the defect's contribution to the remainder, as seen on the summand": there the contribution is identically zero, so the effective coefficient is zero and $f\vert_{\text{summand}}\equiv c_p/S$. Under that reading the parenthetical states a true fact (branch 1 *evaluates to* $c_p/S$ on the summand) and the clause "$f$'s minimum is interior only for $a>0$" is vacuous, there being no $u$ left to vary. **But the true fact is an evaluation, not a minimisation, and [Lemma L149](../findings/second-order.md)'s headline needs the minimisation:** $r_n\gtrsim n^{-1-\beta}$ *over every direction* requires $\inf_H$ of branch 1, which sits at the interior $u^*$ and needs a bound on $a$ that is nowhere on file. The record half-notices this at [Lemma L158](../findings/second-order.md), line 1274 (*"L148 changes where the infimum is attained, not its value"*) which is the opposite of line 1212's use.

**Standing: the finding holds.** L148's written statement supports "branch 1 equals $c_p/S$ on the summand" and nothing more; it does not support "$a=0$", and it does not support "the first is minimised at $w=0$".

### (b) Making a defect branch unbounded at $w=0$, **supported**

**Locate.** [Lemma L149](../findings/second-order.md), line 1232: *"At $w=0$ the defect vanishes identically, so the branch is unbounded there rather than $\Theta(n^{-1})$."* Branch 2 is $\lambda\sqrt c/\lVert A''\rVert$ with $A(t)=\mathrm{Alt}(W(t)_-)$.

**Check.** $A\equiv0$ on a real interval gives $\lVert A''\rVert=0$ and branch $2=+\infty$. If the chain instead uses the Cauchy form $\lVert A''(s)\rVert\le2M/(\rho-\lvert s\rvert)^2$ with $M=\sup_{\lvert z\rvert=\rho}\lVert A(z)\rVert$ over a complex disc, the conclusion is the same: $\ker W^*=0$ makes the Riesz-projection extension of $A$ holomorphic on that disc, and a holomorphic function vanishing on a real interval vanishes on the connected disc, so $M=0$. **Supported under either form of the denominator.**

**The one thing it needs that the box does not give.** In [Lemma L149](../findings/second-order.md), $w$ is *"the weight outside **both**"* copies, so $w=0$ means $H$ lies in the joint two-copy eigenspace. The box names one copy. See §8.

## 8. Pre-registered question 1, one copy or both

**What the box gives.** One: *"For $H$ in $S^2_0(\mathbb R^m)$"*, singular, with a single $h$.

**What the argument gives, and why.** Both, and the joint sum. Let $H=H(h)+H(k)$ with $h\in S^2_0(V_1)$ and $k\in S^2_0(V_2)$. The mirror of §2 gives $H(k)$ diagonal with $\alpha k_b$ on $e_a\wedge e_b$, $-\beta(k_b+k_{b'})$ on $e_b\wedge e_{b'}$, and $0$ inside $B_1$; summing, the mixed planes carry
$$\alpha(h_a+k_b),$$
which is precisely the *cross-plane branch* [Lemma L146](../findings/second-order.md)'s box reports on the joint eigenspace, an independent confirmation that the two-copy picture here is the record's. The frame is available because $h$ is diagonalised by a rotation of $V_1$ and $k$ by a rotation of $V_2$, **acting on disjoint blocks**, and $W^*$ is fixed by the product of the two. So $W^*+t(H(h)+H(k))$ is coordinate-diagonal and §3 applies unchanged.

**Standing.** The extension is true; the argument for it is three lines; **those three lines are on no page of this record.** [Lemma L149](../findings/second-order.md) uses "both copies" twice and cites L148 for it. That is a hypothesis correction, not a defect in the mathematics, but until it is written, use (b) rests on a step nobody has stated.

## 9. What would falsify the statement, and what I did to look for it

**The falsifier.** A direction $H$ in either $S^2_0(\mathbb R^m)$ copy (or in their joint span), together with a real $t$ for which $\mathrm{Alt}\big((W^*+tH)_-\big)\ne0$. Equivalently, a $(2,2)$-split four-subset $\{i,j,k,l\}$ and a $t$ at which $(W^*+tH)_-$ has a non-zero entry pairing $e_i\wedge e_j$ with $e_k\wedge e_l$.

**Where I looked, in closed form and by hand.**

- **An $h$ whose Weyl image has an off-diagonal entry.** Ruled out in §2 by direct evaluation of $h\owedge g_q$, $h\owedge g_p$ and the Weyl projector: an off-diagonal Kulkarni–Nomizu entry forces $\{i,j\}=\{k,l\}$, and the projector's three terms are each Kulkarni–Nomizu products of diagonal tensors.
- **A $t$ at which $W(t)$ becomes singular and $W_-$ leaves the diagonal.** Ruled out: $\tfrac12(\lvert x\rvert-x)$ is applied entrywise on a diagonal matrix at every $t$, degenerate spectrum included.
- **A non-diagonal $h$, where the box's literal reading fails.** Found (this is §4, item 2) but it falsifies the *sentence*, not the *statement*: the conclusion is frame-free and the repair in §4 item 3 recovers it for every $h$.
- **A second copy that refuses to co-diagonalise with the first.** Ruled out in §8: the two rotations act on disjoint blocks.
- **A curve in $S$ leaving $\mathrm{span}\{W^*,H\}$.** The great circle does not leave it (§4); a general curve with tangent $H$ would, but the chain's segments are geodesics from the orbit, and the lemma's own segment is the straight one.

**No falsifier exists**, and the reason is structural rather than dimensional: $\mathrm{Alt}$ vanishes on the whole cone of coordinate-diagonal operators, and the summand's image plus $W^*$ never leaves it.

## Verdict

**`PROVEN, hypotheses corrected`**, for claims 1–5 and 8 of the table, with clause 6 struck and use 7(a) refuted.

**The three repairs the entry owes, in the order they matter.**

1. **State the frame.** Replace *"the tensors $W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes"* with: *in an orthonormal frame adapted to $V_1\oplus V_2$ and chosen to diagonalise $h$, available because $W^*$ is $SO(V_1)\times SO(V_2)$-invariant, and sufficient because $\mathrm{Alt}$ and $x\mapsto x_-$ are $O(n)$-equivariant.* Without it the sentence is false for every non-diagonal $h$.
2. **Say "both copies", and say why.** Add the disjoint-block rotation argument of §8. Two rounds already cite L148 for both copies.
3. **Strike "both defect branches are absent there."** Replace with what is proved: *branches 2 and 3 are vacuous on the summand, and branch 1 takes its $u=0$ value $c_p/S$ there.* As written the clause contradicts [Lemma L147](../findings/second-order.md) line 1179 verbatim.

**And one correction outside the entry.** [Lemma L149](../findings/second-order.md)'s line 1212 must lose *"L148 makes $a=0$ … and $f$'s minimum is interior only for $a>0$"*: L148 gives $u=0$, which places branch 1 at its **maximum** over $u$, so the parenthetical proves the reverse of what it is cited for. [Lemma L158](../findings/second-order.md) line 1274 already says as much and is not joined to it.

**What is added to the record rather than subtracted.** L148 consumes no spectral gap, no analyticity and no kernel hypothesis; it holds at every real $t$, through singular $W(t)$, on the segment and on the great circle alike. It is the only link in the tube-radius chain that the $W_{\mathbb{CP}^2}$ witness cannot reach.
