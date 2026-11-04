# Review r772, L177's incidence characterisation and L178's rank-three bound

Gate 2, adversarial. The brief [BRIEF-g2-l177-l178.md](BRIEF-g2-l177-l178.md) was cold: I worked from its statements and definitions and did not open [findings/](../findings/) or [results.md](../results.md). **No numerical work was done and every value in this report is exact.** Each claim below was derived by hand first; I then ran one exact symbolic screen, rational and radical arithmetic only, no floating point, on objects I constructed for the purpose, to catch transcription slips in my own derivations. It is reported as a screen and is not offered as evidence for anything. The coordinator's mid-task correction, replacing L177's whole-graph edge count with a per-component one, arrived before I wrote and is audited here; the looser form the brief carries is audited alongside it as a separate finding, as instructed. Log: [agent_logs/g2-l178-r772.log](../agent_logs/g2-l178-r772.log).

## Claim table

| # | Claim | Verdict |
| --- | --- | --- |
| L177(1) | Coordinate-diagonal Weyl tensors inside $G$ are $\ker N$, of dimension $\lvert E\rvert-\lvert V\rvert+b(G)$ | CORRECT |
| L177 rank | $\mathop{\mathrm{rank}}N=\lvert V\rvert-b(G)$ | CORRECT, with two hypotheses used and unstated |
| L177(2) | Support exactly $G$ iff $\ker N$ has a full-support vector | CORRECT BUT VACUOUS, it restates the definition and decides nothing |
| L177(2)′ | The converse a reader will reach for, $\ker N\ne0$ gives a full-support vector | FALSE, refuted in closed form |
| L177(3) | At $K_n$, $n\ge3$, the locus has dimension $\binom n2-n$ | CORRECT |
| L177 edges, per-component form | Every component has $\ge4$ edges, so $\lvert E\rvert\ge4$ | CORRECT |
| L177 edges, brief's whole-graph form | "otherwise a non-bipartite component needs $\lvert E_i\rvert\ge\lvert V_i\rvert+1$" | INVALID AS WRITTEN, refuted in closed form; conclusion survives, the inference does not |
| L177 edges, the five | Smallest non-bipartite graph with $\lvert E\rvert\ge\lvert V\rvert+1$ has five edges | CORRECT as a lower bound; the five is **not attained** as a support |
| L178 step 1 | Trace-free on a 3-space is never rank one; rank $\le3$ kills a summand | CORRECT, every split checked |
| L178 step 2, $\gamma^2=2$ | The structure constant | CORRECT, derived independently two ways, and corroborated by the record's own $6+2\sqrt7$ |
| L178 step 2, adjugate | $W^\#=\gamma^2\mathop{\mathrm{cof}}W$ and $\langle W,W^\#\rangle=6e_3$ | CORRECT, and true in any orthonormal basis, not only the diagonalising one |
| L178 step 3, padding | $\#$ commutes with the zero-embedding; $\theta$ unchanged | CONCLUSION CORRECT, STATED REASON A NON-SEQUITUR |
| L178 step 4 | $e_1=0$, Newton, $\theta=9e_3$, the norm | CORRECT |
| L178 step 5, the bound | $\theta\le\sqrt{3/2}$ | CORRECT |
| L178 step 5, equality clause | "$W_{\mathbb{CP}^2}$ up to scale, sign and frame" | WRONG, "sign" is false and "scale" must be positive |
| L178 scope | Four-dimensional support assumed, not derived | LOAD-BEARING AND HONESTLY DECLARED, a hazard only if a parent block drops it |

**One-line actionable summary.** Both inequalities hold and $\sqrt{3/2}$ is the right constant, but three written things need repair: delete "sign" from L178's equality clause and make the scale positive, replace step 3's stated reason with the total antisymmetry of $c$, and adopt the per-component edge count because the brief's whole-graph version is refuted by $C_4\sqcup K_3$.

## 0. Conventions, fixed once

- $\mathcal W_n$: algebraic Weyl tensors on $\mathbb R^n$, Riemann symmetries, first Bianchi $W_{abcd}+W_{acdb}+W_{adbc}=0$, total trace-freeness $\sum_bW_{abcb}=0$. A linear subspace, so $0\in\mathcal W_n$ and $-W\in\mathcal W_n$ whenever $W\in\mathcal W_n$. That closure under negation is used against the equality clause in §10.
- $W$ acts self-adjointly on $\Lambda^2\mathbb R^n$ with $\{f_a\wedge f_b\}_{a<b}$ orthonormal; $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)=\sum_\alpha\lambda_\alpha^2$ over the $\Lambda^2$ spectrum; $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$.
- $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P/\lVert W\rVert^3$. $P$ is homogeneous of degree three, $\lVert W\rVert^3$ of degree three in $\lvert t\rvert$; so $\theta(tW)=\mathop{\mathrm{sgn}}(t)\,\theta(W)$. **$\theta$ is odd, not even.**
- $(W^\#)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\epsilon\zeta}W_{\gamma\epsilon}W_{\delta\zeta}$, Greek indices running over an orthonormal $\Lambda^2$ basis, $c$ the $\mathfrak{so}(n)\cong\Lambda^2$ structure constants. Anchor $\mathrm{id}^\#=(n-2)\,\mathrm{id}$.
- The concrete model I compute in: $f_a\wedge f_b\leftrightarrow L_{ab}=E_{ab}-E_{ba}$, with $\langle X,Y\rangle_{\mathfrak{so}}=-\tfrac12\mathop{\mathrm{tr}}(XY)$, under which $\{L_{ab}\}_{a<b}$ is orthonormal and $c_{\alpha\beta\gamma}=\langle[e_\alpha,e_\beta],e_\gamma\rangle$ is **totally antisymmetric**. This model reproduces the anchor, so it is the record's convention and not a substitute for it (§6).
- Coordinate-diagonal: $W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$; $K_{ab}=W_{abab}$; the locus is the hollow symmetric $K$ with vanishing row sums, taken as given.
- $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$; $\theta_0(12)=\sqrt{55}/6=1.236033\ldots$; the threshold $\sqrt{3/2}=1.224745\ldots$; the crossover $6+2\sqrt7=11.2915\ldots$

## 1. Hypothesis inventory

### L177

**Used and stated.** $G=(V,E)$ a graph; $N$ the unsigned $\{0,1\}$ incidence matrix; $b(G)$ counting bipartite connected components.

**Used and unstated, three.**

1. **Characteristic $\ne2$.** The rank identity is false over $\mathbb F_2$, where the rank is $\lvert V\rvert-c(G)$ and biparticity is invisible. The written proof uses it at exactly one point: "$\epsilon_v=-\epsilon_v$" concludes $\epsilon_v=0$ only when $2\ne0$. The statement of L177 names no field. Over $\mathbb R$ this is harmless, but it is a live hypothesis carrying no label.
2. **Looplessness and simplicity.** A loop would put a $2$ (or, by another convention, a $1$) in a column and break the identity; parallel edges would create a bipartite $2$-cycle and destroy the "bipartite cycle has length $\ge4$" step in §4. Both are inherited free of charge ($K$ is hollow, so no loops, and indexed by unordered pairs, so no parallel edges) but neither is written down, and the second is genuinely load-bearing.
3. **$b$ counts edgeless components.** A one-vertex component with no edges is bipartite, contributing $1$ to $\lvert V\rvert$ and $1$ to $b$ and $0$ to the rank. Unless this convention is fixed, the dimension formula is ambiguous for a support graph read on all of $[n]$ rather than on the vertices meeting an edge. With it fixed, the formula is insensitive to which reading is taken, which is the useful fact, and it should be stated rather than left to the reader.

**Stated and unused.** None. **Used and unstated at the interface**: the identification of coordinate-diagonal tensors with edge weights needs $V\subseteq[n]$, and the row-sum condition at a vertex outside $V(G)$ is vacuous, true, and worth one clause.

### L178

**Used and stated.** $W\in\mathcal W_n$ nonzero (needed for $\lVert W\rVert\ne0$, so $\theta$ is defined at all); support in $\Lambda^2V$ with $\dim V=4$; $\mathop{\mathrm{rank}}(W)\le3$.

**Used and unstated, five.**

1. **$n\ge4$**, implied by the existence of a four-dimensional subspace, never written.
2. **An orientation on $V$**, without which $\Lambda^\pm$ is not defined. Harmless (every four-space has one, and the two choices swap the labels) but step 1 opens with a splitting that presupposes it.
3. **The first Bianchi identity**, once, and precisely located. Step 1 asserts two things without naming a source: that $W|_{\Lambda^2V}$ is block-diagonal with no $\Lambda^+\!\to\!\Lambda^-$ part, and that $\mathop{\mathrm{tr}}W^+=\mathop{\mathrm{tr}}W^-=0$ **separately** rather than only in sum. They have different provenance. The off-diagonal block needs no Bianchi: on $\mathop{\mathrm{Sym}}^2(\Lambda^2\mathbb R^4)$ it is the summand $\Lambda^+\otimes\Lambda^-$, which is $SO(4)$-irreducible of dimension $9$, and the Ricci map carries it by a nonzero equivariant map onto $\mathop{\mathrm{Sym}}^2_0\mathbb R^4$, also of dimension $9$, so by Schur the map is an isomorphism and total trace-freeness alone kills the block. The separate traces do need it: $\mathop{\mathrm{tr}}W^++\mathop{\mathrm{tr}}W^-=\mathop{\mathrm{tr}}W=0$ is trace-freeness, but $\mathop{\mathrm{tr}}W^+-\mathop{\mathrm{tr}}W^-$ is the $\Lambda^4$ component, proportional to $\epsilon^{abcd}W_{abcd}$, which is exactly the first Bianchi identity's failure and vanishes only because Bianchi holds. So **Bianchi is used once, for the difference of the traces**, and it is the largest unstated hypothesis in L178. For a self-adjoint operator on $\Lambda^2\mathbb R^4$ with zero total trace but no Bianchi, the summands are block-diagonal with traces $\pm\tau$ for some $\tau\ne0$, the never-rank-one lemma fails on both, and step 1 collapses. *(Disclosure: I attributed the block-diagonality to Bianchi as well in my first draft. I saw the claim that Bianchi is unused there while looking up [reviews/INDEX.md](INDEX.md)'s row format, checked the Schur argument myself, found it right, and corrected this paragraph. Everything else in this report is my own cold work.)*
4. **"Supported on $\Lambda^2V$" means $W_{abcd}=0$ unless all four indices lie in $V$**, not merely that the operator's image and kernel are adapted. Step 3's support argument reads the strong version.
5. **Positive scaling** in the normalisation $\lVert W\rVert^2=1$. $\theta$ is invariant under $t>0$ and changes sign under $t<0$; the normalisation is legitimate only because one may take $t>0$. This is the same defect that surfaces in the equality clause (§10).

**Verified, not assumed.** The zero-padding of a four-dimensional Weyl tensor into $\mathcal W_n$ really lands in $\mathcal W_n$: for $a,c\in V$, $\sum_{b=1}^nW_{abcb}=\sum_{b\in V}W_{abcb}=0$, and every trace with a free index outside $V$ vanishes termwise. So the hypothesis set is consistent, the object L178 quantifies over exists.

## 2. The rank identity, read at a source

**Verdict: CORRECT, with the two side conditions above.**

I read it rather than recalled it. The source is Zaslavsky, *Matrices in the Theory of Signed Simple Graphs*, [arXiv:1303.3083](https://arxiv.org/abs/1303.3083). **The folder [references/zaslavsky-2013-signed-graph-matrices/](../references/zaslavsky-2013-signed-graph-matrices/) already existed when I went to create it**, reviewer r771 fetched the same paper earlier the same day and wrote its [README.md](../references/zaslavsky-2013-signed-graph-matrices/README.md) and [notes.md](../references/zaslavsky-2013-signed-graph-matrices/notes.md). I deleted my duplicate download rather than write over another agent's in-flight work, and read their `pdftotext` extraction directly. **I have staged and committed nothing in [references/](../references/); that folder's state is r771's and the parent folds it in.**

What the paper says, read at the extraction and not at r771's summary:

> **Theorem IV.1** (Jeurissen; Zaslavsky). If $k$ has characteristic 2, then $H(\Sigma)$ has rank $n-c(\Sigma)$. Otherwise, $H(\Sigma)$ has rank $n-b(\Sigma)$.

and the specialisation, Example IV.F.2:

> The unoriented incidence matrix of $\Gamma$ is a $(0,1)$-matrix which has 1 in position $(v,e)$ if $v$ is an endpoint of $e$ and has 0 otherwise. […] It is an incidence matrix of the all-negative signed graph, $-\Gamma$. Since an all-negative graph is balanced if and only if it is bipartite (Corollary I.3), the rank of the matrix (except in characteristic 2) equals $n-b$ where $b$ is the number of bipartite components of $\Gamma$.

attributed in the paper to van Nuffelen (1973) as the original ad hoc proof.

Two things follow that bear on L177 beyond the identity itself. First, **Zaslavsky's proof blocks over connected components before doing anything else**, $H(\Sigma)$ is block diagonal in the components, so the connected case suffices. L177's proof does the same implicitly; the coordinator's per-component edge count in §4 makes that blocking explicit, which is the paper's own order of argument. Second, the characteristic hypothesis is carried in the theorem statement, where L177 leaves it out.

The brief's specific cases, all consistent with the identity:

| case | $\lvert V\rvert$ | $b$ | rank | check |
| --- | --- | --- | --- | --- |
| no edges, $m$ vertices | $m$ | $m$ | $0$ | $N$ has no columns |
| a single edge | $2$ | $1$ | $1$ | $N=(1,1)^{\mathsf T}$ |
| isolated vertices added | $+1$ each | $+1$ each | unchanged | the dimension formula is stable |
| disconnected | additive | additive | additive | rank blocks by component |
| $K_n$, $n\ge3$ | $n$ | $0$ | $n$ | connected, non-bipartite |

The written proof is complete on substance and short by one clause: it exhibits $\epsilon$ as a left null vector on a bipartite component, giving left nullity $\ge b$, and kills the left null space on a non-bipartite one, giving $\le b$, but it never says that on a bipartite component the left null space is **exactly** one-dimensional. It is, by the same alternation argument plus connectedness, and the omission costs one sentence. I record it as an exposition gap, not a defect.

## 3. L177 claim (2)

**Verdict: CORRECT BUT VACUOUS, and the converse a reader will reach for is FALSE.**

Read literally, claim (2) says: given claim (1), $G$ carries a coordinate-diagonal Weyl tensor whose support is exactly $G$ precisely when $\ker N$ contains a vector all of whose coordinates are nonzero. That is the definition of "support exactly $G$" transcribed through the identification of claim (1). It is true, it cannot fail, and **it supplies no criterion**: it converts one undecided question into a verbatim restatement of itself. If the block presents it as a characterisation, that is an overstatement of what has been achieved, though not an error.

The failure the brief is pointing at is the next step, which claim (2) invites and does not license:

> $\ker N\ne0$, therefore $G$ carries a tensor of support exactly $G$.

**This is false.** Closed-form refutation: let $G$ be the four-cycle $1$–$2$–$3$–$4$–$1$ with one pendant edge $\{1,5\}$. Then $\lvert V\rvert=5$, $\lvert E\rvert=5$, $G$ is connected and bipartite, so $b=1$, $\mathop{\mathrm{rank}}N=4$ and $\dim\ker N=5-5+1=1$, nonzero. But vertex $5$ has degree one, so its row reads $x_{15}=0$, and every kernel vector kills that edge. The kernel is spanned by

$$x_{12}=t,\quad x_{23}=-t,\quad x_{34}=t,\quad x_{41}=-t,\quad x_{15}=0,$$

whose support is the four-cycle, never $G$. Row sums: at vertex $1$, $t+(-t)+0=0$; at $2$, $t+(-t)=0$; at $3$, $-t+t=0$; at $4$, $t+(-t)=0$; at $5$, $0$. Every check is an identity in $t$.

The structural statement behind the counterexample: $\ker N$ has a full-support vector iff **no single edge is forced to zero**, because over $\mathbb R$ a subspace is never the union of finitely many proper subspaces, so the only obstruction is some $e$ with $x_e=0$ for all $x\in\ker N$, a coloop of the even-cycle matroid. L177 does not state this, and I am not supplying it as a proof of anything; I record only that **the criterion claim (2) appears to give is not one, and the gap between "$\ker N\ne0$" and "full support" is real and exhibited**. Anywhere the record reads claim (2) as licensing the converse, that reading is defective.

The dimension formula in claim (1) is at the same risk: dimension $\lvert E\rvert-\lvert V\rvert+b>0$ says the locus of tensors supported **inside** $G$ is nontrivial and says nothing about tensors supported **on** $G$.

## 4. The minimum-edge argument

### 4a. The per-component form (the coordinator's correction)

**Verdict: CORRECT.** I take the three attack points in turn.

**Is restriction to a component free?** Yes, and for a reason worth writing down rather than assuming. Every edge lies in exactly one component, so for $v\in V_i$ the constraint $\sum_{e\ni v}x_e=0$ involves only edges of $G_i$: the constraint matrix $N$ is block diagonal in the components, exactly as Zaslavsky's proof opens by observing. Hence $x\mapsto x|_{E_i}$ maps $\ker N$ into $\ker N_i$ and preserves the support pattern edge by edge, so a full-support $x$ restricts to a full-support element of each $\ker N_i$, and $\ker N_i\ne0$ for **every** component, including components that contribute nothing to the global surplus. That last point is the whole force of the correction. It is free, but only because of block-diagonality; on a constraint system coupling components it would fail.

**Does the bipartite case force a cycle?** Yes. $\ker N_i\ne0$ with $b_i=1$ gives $\lvert E_i\rvert\ge\lvert V_i\rvert$, so the cyclomatic number $\lvert E_i\rvert-\lvert V_i\rvert+1\ge1$ and $G_i$ contains a cycle. In a bipartite graph every cycle has even length; in a **simple** graph the shortest cycle has length $\ge3$; even and $\ge3$ gives $\ge4$. So $\lvert E_i\rvert\ge4$. The step from $\lvert E_i\rvert\ge\lvert V_i\rvert$ to "contains a cycle" is standard and correct, and simplicity is doing real work, a multigraph admits a bipartite $2$-cycle and the bound would drop to $2$. L177 gets simplicity free from $K$'s indexing, as noted in §1.

**Is five right for the non-bipartite minimum?** Yes, and no component shape beats it. $b_i=0$ forces $\lvert E_i\rvert\ge\lvert V_i\rvert+1$. Exhaustively, on a simple graph: $\lvert V_i\rvert\le2$ admits at most one edge and cannot be non-bipartite; $\lvert V_i\rvert=3$ needs $\ge4$ edges where at most $3$ exist; $\lvert V_i\rvert=4$ needs $\ge5$, and $K_4$ minus an edge has exactly $5$ and contains the triangle $1$–$2$–$3$; $\lvert V_i\rvert\ge5$ gives $\lvert E_i\rvert\ge6>5$. So the minimum over the non-bipartite branch is exactly $5$, attained only by $K_4-e$ up to isomorphism. Every component therefore has at least $4$ edges, and $\lvert E\rvert\ge4$, in fact $\lvert E\rvert\ge4c(G)$, which the argument gets for free and does not claim.

**A refinement the argument does not need and should not claim.** The five is a lower bound on edges, not an attained support size. $K_4-e$ on $\{1,2,3,4\}$ with edges $12,13,14,23,24$ has $\dim\ker N=5-4+0=1$, and the kernel is

$$x_{12}=0,\quad x_{13}=t,\quad x_{14}=-t,\quad x_{23}=-t,\quad x_{24}=t,$$

which kills the edge joining the two degree-three vertices; the residual support is the four-cycle $1$–$3$–$2$–$4$–$1$. Row sums: at $1$, $0+t-t=0$; at $2$, $0-t+t=0$; at $3$, $t-t=0$; at $4$, $-t+t=0$. So the unique five-edge non-bipartite candidate is **not** a support graph, and the true non-bipartite minimum-as-a-support exceeds five. This does not touch the argument, which uses $5>4$ only as an inequality, but it means the sentence "the smallest such graph containing an odd cycle has five edges" must never be read as "five nonzero entries are achievable on a non-bipartite support". It is another instance of the §3 gap.

The clause "containing an odd cycle" in the block's sentence is redundant: a non-bipartite graph contains an odd cycle by definition of non-bipartite. Harmless.

**The four is sharp**, achieved by $C_4$ with alternating weights $t,-t,t,-t$, and the given fact that the locus is exactly the hollow zero-row-sum $K$ makes that an actual tensor. So the bound stated in the conventions is tight.

**One ambiguity to resolve in the statement.** "A nonzero such $W$ has at least four nonzero $K_{ab}$" is sharp when $K_{ab}$ counts unordered pairs, that is edges. Counting ordered entries, $K$ is symmetric and the sharp count is eight, so "four" would be true but slack by a factor of two. The argument produces edges; the statement should say edges.

### 4b. The brief's whole-graph form

**Verdict: INVALID AS WRITTEN**, and the coordinator is right to have replaced it. The brief's sentence is

> a support needs $\lvert E\rvert\ge\lvert V\rvert-b+1$; all-bipartite that is an independent cycle, and a bipartite cycle has length $\ge4$; otherwise a non-bipartite component needs $\lvert E_i\rvert\ge\lvert V_i\rvert+1$

The first branch is sound: if every component is bipartite then $b=c$, the global surplus $\lvert E\rvert-\lvert V\rvert+b\ge1$ puts a cycle in some component, and that cycle has $\ge4$ edges.

The "otherwise" branch does not follow. The global inequality $\lvert E\rvert-\lvert V\rvert+b\ge1$ says **some** component has positive surplus; it does not say the non-bipartite one does. Closed-form refutation, at the level of the inference: let $G=C_4\sqcup K_3$, on $\{1,2,3,4\}$ and $\{5,6,7\}$. Then $\lvert V\rvert=7$, $\lvert E\rvert=7$, $b=1$ (the $C_4$ alone), so $\lvert E\rvert-\lvert V\rvert+b=1\ge1$, the branch's premise holds and the graph is not all-bipartite, so the brief routes it to "otherwise". But the non-bipartite component is the triangle, with $\lvert E_i\rvert=3=\lvert V_i\rvert$, **not** $\ge\lvert V_i\rvert+1$. The asserted implication fails on an explicit graph.

The conclusion is unharmed, $C_4\sqcup K_3$ has seven edges, and in any case it is not a support graph, since $\mathop{\mathrm{rank}}N=6$, $\dim\ker N=1$, and the kernel is the $C_4$ alternation with all three triangle edges zero. But the brief's premise is the **global** $\lvert E\rvert\ge\lvert V\rvert-b+1$, which is exactly the condition $C_4\sqcup K_3$ satisfies, so the counterexample is a counterexample to the inference as the brief licenses it. The repair is the per-component argument of §4a, which derives $\ker N_i\ne0$ for every component from full support rather than from a global count. **The looser form is not sound as written; it reaches a true conclusion through a step that is false.**

## 5. L178 step 1

**Verdict: CORRECT, all splits checked.**

**Never rank one.** A self-adjoint rank-one operator on a three-space has spectrum $(\lambda,0,0)$ with $\lambda\ne0$; trace-freeness gives $\lambda=0$, a contradiction. So $\mathop{\mathrm{rank}}W^\pm\in\{0,2,3\}$. Correct, and it depends on trace-freeness of **each summand separately**, the one place the first Bianchi identity is genuinely spent, as §1 sets out.

**The splitting.** $W$ restricted to $V$ is an algebraic Weyl tensor of $\mathbb R^4$ (first Bianchi inherited, and $\sum_{b\in V}W_{abcb}=\sum_{b=1}^nW_{abcb}=0$) so it is block diagonal on $\Lambda^+\oplus\Lambda^-$ with $\mathop{\mathrm{tr}}W^+=\mathop{\mathrm{tr}}W^-=0$. Correct, source unnamed, and the two halves have different sources: block-diagonality is Schur against the irreducible $\Lambda^+\otimes\Lambda^-$ and costs only trace-freeness, while the separate traces cost the first Bianchi identity, as §1 sets out.

**Every split, arithmetically.** With $r_\pm\in\{0,2,3\}$ and $r_++r_-\le3$:

| $(r_+,r_-)$ | total | admissible? |
| --- | --- | --- |
| $(0,0)$ | $0$ | yes, $W=0$, excluded by hypothesis |
| $(2,0)$, $(0,2)$ | $2$ | yes |
| $(3,0)$, $(0,3)$ | $3$ | yes |
| $(2,2)$ | $4$ | no |
| $(2,3)$, $(3,2)$ | $5$ | no |
| $(3,3)$ | $6$ | no |

Since a rank-two summand cannot be paired with anything nonzero, and $2+1$ is unavailable because rank one is impossible, one summand vanishes in every admissible case. The block's claim is exactly right, and the $2+1$ split the brief asks about is excluded by the never-rank-one lemma, not overlooked.

**The rank-two branch.** Spectrum $(\lambda,-\lambda,0)$ by trace-freeness, so $e_3=0$; step 4 then gives $\theta=9e_3=0<\sqrt{3/2}$, and consistently $e_2=-\lambda^2=-\tfrac12$ under $p_2=1$, so the branch sits inside step 5's family at $e_3=0$ rather than beside it. It contributes no equality case. Correct.

## 6. Step 2, the constant, derived independently

**Verdict: $\gamma^2=2$ is CORRECT.** I derive it three ways, none of which is the block's, and all three agree.

**Route one, the structure constants, computed.** In the model of §0, $[L_{ab},L_{bc}]=L_{ac}$. Put

$$A_1=L_{12}+L_{34},\qquad A_2=L_{13}-L_{24},\qquad A_3=L_{14}+L_{23},$$

the self-dual triple. Then

$$[A_1,A_2]=[L_{12},L_{13}]-[L_{12},L_{24}]+[L_{34},L_{13}]-[L_{34},L_{24}]=-L_{23}-L_{14}-L_{14}-L_{23}=-2A_3.$$

Each $A_i$ has $\lVert A_i\rVert^2=2$, so the **orthonormal** self-dual basis is $\omega_i=A_i/\sqrt2$, and

$$[\omega_1,\omega_2]=\tfrac12[A_1,A_2]=-A_3=-\sqrt2\,\omega_3.$$

Hence $c_{ijk}=-\sqrt2\,\epsilon_{ijk}$ in this orientation, so $\gamma=\mp\sqrt2$ and $\gamma^2=2$. Only $\gamma^2$ enters the $\#$ formula, so the sign is immaterial.

**This is exactly the factor-of-two trap the brief warns about.** $\Lambda^+\cong\mathfrak{su}(2)\cong\mathfrak{so}(3)$ as Lie algebras, and the textbook $\mathfrak{so}(3)$ basis has $c=\epsilon$, that is $\gamma=1$. The isomorphism $\Lambda^+\to\mathfrak{so}(3)$ is **not an isometry** for the norm $\Lambda^+$ inherits from $\Lambda^2\mathbb R^4$: the inherited norm is $\sqrt2$ times the one that makes $c=\epsilon$. Anyone who writes "$\Lambda^+\cong\mathfrak{su}(2)$" and then imports $c=\epsilon$ gets $\gamma^2=1$ and loses a factor of two in $\langle W,W^\#\rangle$. The block writes $c=\gamma\epsilon$ with $\gamma$ left to be determined and determines it correctly. **The record is right here.**

**Route two, the anchor, checked rather than assumed.** In the $\{L_{ab}\}$ basis, $(\mathrm{id}^\#)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}$. Fix $\alpha=(12)$: $[L_{12},L_\gamma]\ne0$ exactly when $\gamma$ shares one index with $\{1,2\}$, that is $\gamma\in\{(1c),(2c):c\ge3\}$, which is $2(n-2)$ basis elements, each contributing a single $\delta$ with $c=\pm1$. So $\tfrac12\cdot2(n-2)=n-2$, and $\mathrm{id}^\#=(n-2)\,\mathrm{id}$. **The anchor is a theorem in this convention, not a normalisation choice**, which means the block's use of it to pin $\gamma$ is legitimate rather than circular. Restricting to $\Lambda^+$: since $[\Lambda^+,\Lambda^-]=0$, for $\alpha,\beta\in\Lambda^+$ only $\gamma,\delta\in\Lambda^+$ contribute, so $\tfrac12\gamma^2\sum_{cd}\epsilon_{acd}\epsilon_{bcd}=\gamma^2\delta_{ab}$ must equal $2\delta_{ab}$ at $n=4$, giving $\gamma^2=2$. This is the block's own computation and it is right, including the restriction step it leaves implicit.

**Route three, the record's own crossover corroborates it.** $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ exceeds the L178 bound exactly when $2(n-1)(n-2)/n^2>3/2$, that is $n^2-12n+8>0$, that is $n>6+2\sqrt7$. **That is precisely the crossover the record watches**, and it is precisely why the conjecture's range starts at $n=12$: $\theta_0(11)=1.219673\ldots<\sqrt{3/2}<\theta_0(12)=1.236033\ldots$ Had $\gamma^2$ been $1$, the bound would read $\theta=6e_3\le2/\sqrt6=\sqrt{2/3}$ and the crossover would be at $(9+\sqrt{33})/4=3.686\ldots$, nowhere near $6+2\sqrt7$. **The record's crossover constant is consistent with $\gamma^2=2$ and with no other value**, which is an independent check that the factor of two has not been dropped anywhere between the $\#$ formula and the threshold.

**On "does the anchor evaluation use the right $n$":** see §8. The answer is yes, but not for the reason the block gives.

## 7. Step 2, the adjugate

**Verdict: CORRECT, and stronger than stated.**

With $c_{ijk}=\gamma\epsilon_{ijk}$ on the three-space,

$$(W^\#)_{ab}=\tfrac{\gamma^2}{2}\sum\epsilon_{acd}\epsilon_{bef}W_{ce}W_{df}=\gamma^2\mathop{\mathrm{cof}}(W)_{ab},$$

the second equality being the standard $3\times3$ cofactor identity $\mathop{\mathrm{cof}}(W)_{ab}=\tfrac12\epsilon_{acd}\epsilon_{bef}W_{ce}W_{df}$, which checks at $W=I$ as $\tfrac12\epsilon_{acd}\epsilon_{bcd}=\delta_{ab}=\mathop{\mathrm{cof}}(I)_{ab}$. So $W^\#=2\mathop{\mathrm{cof}}(W)$.

The block says this holds "on the diagonalising basis". It holds in **any** orthonormal basis of the three-space (both sides are basis-covariant under $SO(3)$) so the qualifier is over-cautious rather than wrong. Restricting to the diagonalising basis is harmless but costs generality that step 3 later wants back.

Then, $W$ symmetric so $\mathop{\mathrm{cof}}(W)=\mathop{\mathrm{adj}}(W)^{\mathsf T}=\mathop{\mathrm{adj}}(W)$, and $W\mathop{\mathrm{adj}}(W)=\det(W)I$ **without any invertibility hypothesis**:

$$\langle W,W^\#\rangle=2\mathop{\mathrm{tr}}(W\mathop{\mathrm{adj}}W)=2\cdot3\det W=6e_3.$$

Or diagonally, $\langle\mathop{\mathrm{diag}}(\lambda_i),2\mathop{\mathrm{diag}}(\lambda_j\lambda_k)\rangle=6\lambda_1\lambda_2\lambda_3$. Correct.

## 8. Step 3, the padding, the conclusion is right and the reason is not

**Verdict: CONCLUSION CORRECT, STATED REASON A NON-SEQUITUR.** This is the item the brief flags for the $n$-dependence, and there is something real here.

**The conclusion.** For $\alpha\notin\Lambda^2V$ and $W$ supported on $\Lambda^2V$, the $\#$ sum forces $\gamma,\delta,\epsilon,\zeta\in\Lambda^2V$ through the factors $W_{\gamma\epsilon}W_{\delta\zeta}$, leaving $c_{\alpha\gamma\delta}$ with $\gamma,\delta\in\Lambda^2V$. Total antisymmetry gives $c_{\alpha\gamma\delta}=c_{\gamma\delta\alpha}=\langle[e_\gamma,e_\delta],e_\alpha\rangle$, and $[e_\gamma,e_\delta]\in\mathfrak{so}(V)$ because $\mathfrak{so}(V)$ is a subalgebra, so the component along $e_\alpha\perp\mathfrak{so}(V)$ vanishes. Hence $W^\#$ is supported on $\Lambda^2V$ and is computed there by $\mathfrak{so}(4)$'s own constants. Both parts of the claim hold, and $\theta$ is unchanged by padding because $\lVert W\rVert^2$, $\mathop{\mathrm{tr}}W^3$ and $\langle W,W^\#\rangle$ all read off the $\Lambda^2V$ block alone. The same argument, applied inside $\mathfrak{so}(4)$, is what confines $W^\#$ to $\Lambda^+$ when $W$ lives on $\Lambda^+$, which step 2 needs in order to treat $W^\#$ as a $3\times3$ cofactor at all, and which the block never says.

**The ingredient that is missing.** The step's stated reason is "$\mathfrak{so}(V)$ is a subalgebra, so a $\#$-term needs all four structure-constant slots inside it". Being a subalgebra gives $[\mathfrak{so}(V),\mathfrak{so}(V)]\subseteq\mathfrak{so}(V)$, which is a statement about $c_{\gamma\delta\alpha}$; converting it into the statement about $c_{\alpha\gamma\delta}$ that the $\#$ formula actually contains requires **total antisymmetry of $c$**, which holds in an orthonormal basis with an ad-invariant form but is nowhere asserted. Without it the step is a hope. With it the step is a proof. One clause.

**The $n$-dependence, which is the sharp point.** The block writes: "$\theta$ is an invariant of the four-dimensional piece, which is why step 2 reads the anchor at $n=4$." That does not follow. $\theta$'s invariance under padding is a statement about $\theta$; the licence to evaluate an $n$-dependent anchor at $n=4$ is a statement about $c$. They are different facts and the first does not imply the second.

The correct licence is that the structure constants of $\mathfrak{so}(V)\subset\mathfrak{so}(n)$ in a compatible orthonormal basis **are** $\mathfrak{so}(4)$'s, independent of the ambient $n$; hence $\gamma^2=2$ for every $n\ge4$, and the anchor is being read as a self-contained fact about $\mathfrak{so}(4)$ rather than as the ambient anchor evaluated at the wrong argument.

That distinction is not pedantry, because **the ambient anchor genuinely does not apply to the padded object.** Let $\mathrm{id}_{\Lambda^2V}$ denote the identity on $\Lambda^2V$ padded by zero into $\Lambda^2\mathbb R^n$. Then

$$(\mathrm{id}_{\Lambda^2V})^\#=2\,\mathrm{id}_{\Lambda^2V},\qquad\text{not}\qquad(n-2)\,\mathrm{id}_{\Lambda^2V}.$$

The two agree only at $n=4$. So a reader who takes the block's stated reason at face value ("$\theta$ is invariant, therefore read the anchor wherever is convenient"), has been handed a principle that would equally license reading it at the ambient $n$, which is false for the padded identity. **The step reaches the right $n$ by the right route and explains it by the wrong one.** The repair is one sentence: the constants are intrinsic to the subalgebra.

## 9. Step 4

**Verdict: CORRECT.**

- **$e_1=0$.** $\mathop{\mathrm{tr}}_{\Lambda^2}W=\sum_{a<b}W_{abab}=\tfrac12\sum_{a,b}W_{abab}=0$ by total trace-freeness. On the relevant three-space, $e_1=p_1=\mathop{\mathrm{tr}}W^+=0$ by the separate trace-freeness of §5. Both hold; the block uses the second and cites the first.
- **Newton.** $p_3=e_1p_2-e_2p_1+3e_3$; with $e_1=p_1=0$ this is $p_3=3e_3$. The identity is correctly quoted and correctly specialised. Note that $p_3=\mathop{\mathrm{tr}}W^3$ over the whole of $\Lambda^2\mathbb R^n$ equals $p_3$ of the three nonzero eigenvalues, since every other eigenvalue is zero.
- **The norm.** $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)=\sum_\alpha\lambda_\alpha^2=p_2$, which is the norm $\theta$ is defined against by the stated convention. Setting $p_2=1$ is a positive rescaling, admissible by the degree-zero homogeneity of $\theta$ under $t>0$.
- **The assembly.** $P=\langle W,W^2\rangle+\langle W,W^\#\rangle=\mathop{\mathrm{tr}}W^3+6e_3=3e_3+6e_3=9e_3$, and $\theta=P$ at $\lVert W\rVert=1$. Correct.

**One convention hazard to record, though L178 does not trip it.** The operator norm here is a quarter of the tensor norm: $\sum_{abcd}W_{abcd}^2=4\sum_{a<b,c<d}W_{abcd}^2=4\mathop{\mathrm{tr}}(W_{\Lambda^2}^2)$. Since $\theta$ is a ratio of a cubic to a cube, switching conventions rescales $\theta$ by $1/8$, $\sqrt{3/2}$ would become $\sqrt{3/2}/8$. The brief's conventions are internally consistent and the anchor is a theorem in them (§6, route two), so L178 is safe; but any imported inequality stated in the tensor norm would arrive wrong by a factor of eight.

## 10. Step 5

**Verdict: the BOUND is CORRECT; the EQUALITY CLAUSE is WRONG.**

**The bound.** $e_1=0$ and $p_2=e_1^2-2e_2=1$ give $e_2=-\tfrac12$, so the eigenvalues are the roots of $x^3-\tfrac12x-e_3$. For the depressed cubic $x^3+px+q$ the discriminant is $\Delta=-4p^3-27q^2$; here $p=-\tfrac12$, $q=-e_3$, so $\Delta=\tfrac12-27e_3^2$. The block's sign convention is the standard one and its arithmetic is right, including $-4(-\tfrac12)^3=+\tfrac12$.

**The direction of the implication is the right one.** $W$ is self-adjoint, so its eigenvalues are real *a priori*, so $\Delta\ge0$ is a **consequence** used to constrain $e_3$, not a condition imposed. The block says "three real roots is a nonnegative discriminant", which is the correct direction. Then $e_3^2\le\tfrac1{54}$, $\lvert e_3\rvert\le\tfrac1{3\sqrt6}$ (since $\sqrt{54}=3\sqrt6$), and $\theta=9e_3\le\tfrac9{3\sqrt6}=\tfrac3{\sqrt6}=\sqrt{3/2}$.

**The equality spectrum.** $\Delta=0$ forces a repeated root; $x^3-\tfrac12x-\tfrac1{3\sqrt6}$ has roots $\tfrac1{\sqrt6}(2,-1,-1)$, verified by $e_1=0$, $e_2=\tfrac16(-2-2+1)=-\tfrac12$, $e_3=\tfrac{2}{6\sqrt6}=\tfrac1{3\sqrt6}$, and $p_2=\tfrac{4+1+1}6=1$. That is $\mathbb{CP}^2$'s self-dual spectrum, and $\theta=\sqrt{3/2}$ at it. All correct.

**Where it fails: "up to scale, sign and frame".**

- **"Sign" is false.** $P$ is homogeneous of degree three and $\lVert W\rVert^3$ is even, so $\theta(-W)=-\theta(W)$. Since $\mathcal W_n$ is a linear subspace, $-W_{\mathbb{CP}^2}\in\mathcal W_n$, is supported on the same $\Lambda^2V$, has the same rank $3$, and has spectrum $\tfrac1{\sqrt6}(-2,1,1)$, $e_3=-\tfrac1{3\sqrt6}$, hence $\theta=-\sqrt{3/2}$. **It attains the minimum of the same family, not the maximum**, and including it in the equality set of an upper bound is an error. It is the reflected root of the same discriminant condition, which is presumably how it got in.
- **"Scale" must be positive.** $\theta(tW)=\mathop{\mathrm{sgn}}(t)\theta(W)$, so negative scaling is sign flipping under another name; unqualified "up to scale" reintroduces the same false case.
- **"Frame" is right, provided the frame group is $O(n)$ and not $SO(n)$.** The anti-self-dual mirror ($W^+=0$ with $W^-$ carrying $\tfrac1{\sqrt6}(2,-1,-1)$, that is $\overline{\mathbb{CP}^2}$), has the same $\Lambda^2$ spectrum, hence the same $p_2$, $e_3$ and $\theta=\sqrt{3/2}$, so it **is** in the equality set and must be covered. An orientation-reversing orthogonal change of frame on $V$ swaps $\Lambda^+\leftrightarrow\Lambda^-$, so "up to frame" covers it under $O(n)$ and fails to cover it under $SO(n)$. The word "frame" is unqualified in the statement, so this is an ambiguity to close rather than a refuted claim, but the two readings differ on whether $\overline{\mathbb{CP}^2}$ is in the equality set, and the true answer is that it is.

**Repaired clause:** equality holds exactly when $W$ is a **positive** multiple of $W_{\mathbb{CP}^2}$ in some orthonormal frame of $V$, either orientation, equivalently, up to positive scale and $O(n)$ frame change; and $\theta=-\sqrt{3/2}$ is attained exactly on the negatives of those.

## 11. The kernel

**Verdict: no step assumes $\ker W=0$.** I checked each.

Every object here is almost all kernel: $W$ kills $\Lambda^2\mathbb R^n\ominus\Lambda^2V$, of dimension $\binom n2-6$, and kills one of $\Lambda^\pm$ entirely, and in the rank-two branch kills a further line. The places this could bite:

- **The cofactor.** $\mathop{\mathrm{cof}}$ and $\mathop{\mathrm{adj}}$ are polynomial in the entries and $W\mathop{\mathrm{adj}}(W)=\det(W)I$ needs no invertibility, so §7 survives $\det W=0$. In the rank-two branch $\mathop{\mathrm{cof}}(W)$ has rank one and $\langle W,W^\#\rangle=6e_3=0$ consistently.
- **Newton and the discriminant.** Both are polynomial identities in the eigenvalues; a zero eigenvalue is an ordinary point of the family, sitting at $e_3=0$ inside the interval $\lvert e_3\rvert\le\tfrac1{3\sqrt6}$ rather than at its edge.
- **Treating $W^\#$ as a $3\times3$ object.** This is where a kernel assumption could have hidden, and it does not: as shown in §8, $W^\#$ vanishes off the block $W$ lives on, so the reduction to $3\times3$ is a theorem rather than a convenience.
- **The normalisation $\lVert W\rVert=1$.** Needs $W\ne0$ only, which is hypothesised.

**One place the kernel is doing silent work for the argument rather than against it:** the padding argument in §8 is exactly a statement that the large kernel does not leak into $W^\#$. That is the good direction, and it is proved.

## 12. The boundary

- **$n=4$ exactly.** Everything applies; $\Lambda^2V=\Lambda^2\mathbb R^4$, the anchor reads $(n-2)=2$ directly with no padding at all, and the argument degenerates gracefully.
- **$n=5$ and odd $n$.** Nothing in L178 depends on the parity of $n$. The $\Lambda^\pm$ splitting is internal to the four-dimensional $V$ and needs only $\dim V=4$ plus an orientation on $V$; the ambient $\mathbb R^n$ contributes only the vanishing blocks. So the bound holds for every $n\ge4$, uniformly, with no $n$ in the constant.
- **$n$ below $12$.** The proof imports no lower bound on $n$, so the statement is true there too, but it stops being **useful** below the crossover, and this is the substantive boundary fact. $\theta_0(n)>\sqrt{3/2}$ iff $n^2-12n+8>0$ iff $n>6+2\sqrt7=11.2915\ldots$; $\theta_0(11)=1.219673\ldots$ and $\theta_0(12)=\sqrt{55}/6=1.236033\ldots$ So for $n\ge12$ L178 strictly excludes its class from being a maximiser, and for $n\le11$ it does not. That is not a defect; it is the reason the crossover constant is what it is, and it is a check that ties L178's constant to the record's threshold (§6, route three).
- **$n=6+2\sqrt7$.** Not an integer, so no tensor lives there. Its role is exactly the boundary above, and L178's own constant is $n$-free, so nothing in the proof interacts with it.

## 13. Scope

**Verdict: the four-dimensional hypothesis is LOAD-BEARING and HONESTLY DECLARED. The hazard is outside the block.**

The hypothesis is used four times over and cannot be weakened inside this argument:

1. The $\Lambda^\pm$ splitting exists only for $\dim V=4$, $\star$ is an involution on $\Lambda^2$ exactly in dimension four.
2. "Trace-free, hence never rank one" needs the summands to be three-dimensional.
3. The cofactor identity and $\langle W,W^\#\rangle=6e_3$ are $3\times3$ facts.
4. $\gamma^2=2$ is a fact about $\mathfrak{su}(2)$ inside $\mathfrak{so}(4)$ with the inherited norm.

For support of dimension $m\ne4$ there is no splitting, $\Lambda^2$ has dimension $\binom m2$, and no step transfers.

**L178 does not claim that rank $\le3$ implies four-dimensional support**, and it should not be read as doing so; the hypothesis is in the statement. The failure mode is one level up: if a parent block disposes of "the rank $\le3$ case" by citing L178, it needs $\mathop{\mathrm{rank}}(W)\le3\Rightarrow\dim\mathop{\mathrm{supp}}W=4$ as a separate result. **I looked for that implication in the material I was given and there is none, the brief supplies no argument for it, and I decline to supply one.** If the record relies on it anywhere, that reliance is `HYPOTHESIS-DEBT`; if the record only ever applies L178 with the support hypothesis independently verified, there is no debt. On the evidence in front of me I can say only that L178 itself is clean and that the gap is real if it is ever crossed.

## 14. What would break each claim, and what I did to look

**Analysis-only, honoured.** I ran no search, no sweep, no census and no falsifier hunt. The three counterexamples below were constructed by hand from the structure of the argument and are exhibited in closed form with their defining equations verified termwise; the only compute I ran was a single exact symbolic screen, over the rationals and $\sqrt6$, of objects I had already derived, and it is reported as a screen and used to catch my own transcription errors, never as evidence.

| Claim | The object that would break it | Found? |
| --- | --- | --- |
| L177 rank identity | A graph over $\mathbb R$ with $\mathop{\mathrm{rank}}N\ne\lvert V\rvert-b$ | No. Read at Zaslavsky Theorem IV.1 and Example IV.F.2; the identity is a theorem, and the only escapes are characteristic 2 and loops, both excluded here |
| L177 claim (2) as an iff | Nothing, it is a definitional restatement | Not applicable; the claim cannot fail and cannot decide anything |
| The converse "$\ker N\ne0\Rightarrow$ full support" | A graph with nonzero kernel where some edge is forced to zero | **Found**: $C_4$ plus a pendant edge, kernel one-dimensional and spanned by $(t,-t,t,-t,0)$ |
| L177 whole-graph edge split | A graph meeting the global surplus whose non-bipartite component has $\lvert E_i\rvert=\lvert V_i\rvert$ | **Found**: $C_4\sqcup K_3$, surplus $7-7+1=1$, triangle at $3=3$ |
| The five, as an attained support | A five-edge non-bipartite support graph | **Refuted**: $K_4-e$ is the only five-edge candidate and its kernel forces $x_{12}=0$, collapsing to a four-cycle |
| L178 step 1 | A rank-$\le3$ four-dimensional Weyl tensor with both summands nonzero | Cannot exist: the split table in §5 is exhaustive over $\{0,2,3\}^2$ |
| $\gamma^2=2$ | A computation of the $\mathfrak{su}(2)$ constants in the $\Lambda^2$-orthonormal basis giving anything but $2$ | No. Three independent routes give $2$; the counterfactual $\gamma^2=1$ moves the crossover from $6+2\sqrt7$ to $(9+\sqrt{33})/4$, contradicting the record's own constant |
| The bound $\theta\le\sqrt{3/2}$ | A trace-free $W$ on a three-space with $p_2=1$ and $e_3>\tfrac1{3\sqrt6}$ | Cannot exist: real spectrum forces $\Delta\ge0$, which is exactly $e_3^2\le\tfrac1{54}$ |
| The equality clause | A tensor in the stated equality set with $\theta\ne\sqrt{3/2}$ | **Found**: $-W_{\mathbb{CP}^2}$, admitted by "up to sign", has $\theta=-\sqrt{3/2}$ |
| Step 3's padding conclusion | A padded $W$ whose $\#$ leaks off $\Lambda^2V$ | Cannot happen, by total antisymmetry of $c$ and closure of $\mathfrak{so}(V)$; and the ambient anchor's failure on the padded identity ($2$, not $n-2$) shows the *reason* the block gives is unavailable even though the conclusion holds |

**The screen, stated in full for the record.** Exact symbolic arithmetic, no floating point, on objects I constructed: the four graph kernels above; the $\{L_{ab}\}$ structure constants at $n=4$ and $n=6$, confirming orthonormality under $-\tfrac12\mathop{\mathrm{tr}}$, total antisymmetry of $c$, $\mathrm{id}^\#=2\,\mathrm{id}$ at $n=4$ and $4\,\mathrm{id}$ at $n=6$; $[\omega_i,\omega_j]=\mp\sqrt2\,\epsilon_{ijk}\omega_k$; the padded $(\mathrm{id}_{\Lambda^2V})^\#=2\,\mathrm{id}_{\Lambda^2V}$ inside $\mathfrak{so}(6)$; and, for the $\mathbb{CP}^2$ spectrum inside $\mathfrak{so}(6)$, $\lVert W\rVert^2=1$, $\mathop{\mathrm{tr}}W^3=\sqrt6/6$, $\langle W,W^\#\rangle=\sqrt6/3$, $\theta=\sqrt6/2=\sqrt{3/2}$, and $W^\#$ supported on $\Lambda^2V$. Every one of these was derived by hand first and every one agreed. **None of it is offered as evidence for any positive claim in this report; the derivations above stand alone.**

## Overall verdict

**SOUND ON THE MATHEMATICS, WITH THREE WRITTEN CLAIMS THAT MUST BE REPAIRED BEFORE THE BLOCK IS CITED.**

In my own words: nobody has dropped a factor of two, and $\sqrt{3/2}$ is the right number, I derived $\gamma^2=2$ three ways, and the record's own $6+2\sqrt7$ is consistent with that value and with no other, which is the strongest corroboration available here. L177's rank identity is a theorem I read at a source and its dimension count is right. Both inequalities hold. What is defective is prose, in three places, one of which is a false statement rather than a loose one:

1. **L178's equality clause is wrong.** "Up to scale, sign and frame" admits $-W_{\mathbb{CP}^2}$, which realises $\theta=-\sqrt{3/2}$, the minimum. Scale must be positive, "sign" must go, and "frame" must be $O(n)$ so that $\overline{\mathbb{CP}^2}$ is covered. The bound is untouched; the uniqueness statement as written is false.
2. **Step 3 justifies the right move with the wrong fact.** $\theta$'s invariance under padding does not license evaluating an $n$-dependent anchor at $n=4$; what licenses it is that $\mathfrak{so}(V)$'s structure constants are ambient-independent. The distinction has teeth: the padded identity satisfies $\#=2\,\mathrm{id}$, not $(n-2)\,\mathrm{id}$, so the stated principle would sanction a false reading. The step also leans unnamed on the total antisymmetry of $c$ and on $W^\#$ vanishing off the summand $W$ lives on.
3. **The brief's whole-graph edge count is invalid as written**, refuted by $C_4\sqcup K_3$; the coordinator's per-component version is correct and is what should be recorded. Separately, L177's claim (2) is a restatement rather than a criterion, and the converse it invites (nonzero kernel gives full support), is false, refuted by $C_4$ plus a pendant.

None of these threatens the two theorems. All three would mislead a reader who took the block at its word, and the first is an error of fact.

**Committed alone**, as `review(L178): r772 sound-with-three-repairs`. **I fetched nothing into [references/](../references/)**: the Zaslavsky folder was already there from r771 when I went to create it, I deleted my duplicate download rather than disturb another agent's in-flight work, and I read their extraction. That folder's state is r771's and is not mine to fold in.
