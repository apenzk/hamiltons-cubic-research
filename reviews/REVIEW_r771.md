# Gate 2, reviewer r771, L177's incidence characterisation and L178's rank-three bound

**Cold brief.** I worked from [BRIEF-g2-l177-l178.md](BRIEF-g2-l177-l178.md) and the coordinator's mid-task correction to its minimum-edge argument, and read nothing in [findings/](../findings/). **No numerical work was done and every value in this report is exact**, the two constants $\gamma^2=2$ and $\sqrt{3/2}=3/\sqrt6$ are derived symbolically, twice each by independent routes, and the graph kernels are exhibited as integer vectors. One **screen** was run, in exact rational arithmetic, on five graphs I constructed for the purpose, purely to guard my own hand arithmetic against a slip; it is reported as a screen in §3.4 and no positive claim rests on it. Log: [agent_logs/g2-l178-r771.log](../agent_logs/g2-l178-r771.log).

## The claim table

| # | Claim | Verdict |
| --- | --- | --- |
| L177 (1) | Coordinate-diagonal Weyl tensors supported inside $G$ are exactly $\ker N$, of dimension $\lvert E\rvert-\lvert V\rvert+b(G)$ | **SOUND**, two hypotheses used and unstated (char $\ne2$; looplessness) |
| L177 (1a) | $\mathop{\mathrm{rank}}N=\lvert V\rvert-b(G)$ | **SOUND AND SOURCED**, Zaslavsky Thm IV.1 / Ex. IV.F.2, orig. van Nuffelen |
| L177 (2) | $G$ carries a tensor of support exactly $G$ **iff** $\ker N$ has a full-support vector | **SOUND BUT VACUOUS**, it is a restatement of the definition, not a criterion |
| L177 (2a) | The reading "$\ker N\ne0$ suffices" | **REFUTED IN CLOSED FORM**, $C_4$ with a pendant edge |
| L177 (3) | At $G=K_n$, $n\ge3$, the locus has dimension $\binom n2-n$ | **SOUND** |
| L177 (4a) | The brief's **whole-graph** minimum-edge case split | **UNSOUND AS WRITTEN**, the non-bipartite branch is a non sequitur; conclusion survives |
| L177 (4b) | The coordinator's **per-component** minimum-edge argument | **SOUND AFTER ONE QUALIFIER**, "every component" must read "every component carrying an edge" |
| L177 (4c) | "The smallest non-bipartite graph with $\lvert E\rvert\ge\lvert V\rvert+1$ containing an odd cycle has five edges" | **TRUE, AND NOT ATTAINED AS A SUPPORT**, $K_4-e$ realises 5 edges but its kernel is not fully supported |
| L178 step 1 | Trace-free on a three-space is never rank one; rank $\le3$ forces a summand to vanish | **SOUND**, all nine splits checked |
| L178 step 2 | $\gamma^2=2$ | **CONFIRMED INDEPENDENTLY, TWICE**, value right, justifying sentence loose |
| L178 step 2' | $W^\#=\gamma^2\mathop{\mathrm{cof}}W$ and $\langle W,W^\#\rangle=6e_3$ | **SOUND** |
| L178 step 3 | $\#$ commutes with the zero-embedding; the anchor is read at $n=4$ | **SOUND, AND THE $n$ IS THE RIGHT ONE** |
| L178 step 4 | $e_1=0$, Newton, $\theta=9e_3$ | **SOUND**, first Bianchi identity stated and unused |
| L178 step 5 | $\theta\le\sqrt{3/2}$ | **SOUND** |
| L178 step 5' | Equality "exactly when $W$ is $W_{\mathbb{CP}^2}$ up to scale, **sign** and frame" | **FALSE AS STATED**, $\theta$ is odd, so $-W_{\mathbb{CP}^2}$ gives $-\sqrt{3/2}$ |
| L178 scope | Four-dimensional support assumed, not derived | **HONEST BUT LOAD-BEARING** |

**Overall verdict: CONFIRMED-WITH-DEFECTS.** Both bounds are right and $\gamma^2=2$ survives an independent derivation by two routes; two written clauses are wrong, L178's equality clause is false as stated because it is closed under sign, and the brief's whole-graph form of L177's minimum-edge argument asserts a per-component inequality the global one does not deliver.

**Actionable in one line:** delete "sign" from L178's equality clause (or restate the bound as $\lvert\theta\rvert\le\sqrt{3/2}$ with equality up to scale, sign and frame), and replace L177's whole-graph case split with the per-component one, qualified to components carrying at least one edge.

## 0. Conventions, fixed once

Everything below uses the brief's conventions verbatim: $\mathcal W_n$ with the Riemann symmetries, first Bianchi and total trace-freeness; $W$ self-adjoint on $\Lambda^2\mathbb R^n$ with $\{f_a\wedge f_b\}_{a<b}$ orthonormal; $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)$; $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$; $P=\langle W,W^2+W^\#\rangle$, $\theta=P/\lVert W\rVert^3$; $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ with $c$ the $\mathfrak{so}(n)$ structure constants in that orthonormal basis; anchor $\mathrm{id}^\#=(n-2)\mathrm{id}$.

Two further conventions I fix here because the checks need them, and the brief leaves them implicit.

- **The realisation of $\Lambda^2\cong\mathfrak{so}(n)$.** I take $L_{ab}=E_{ab}-E_{ba}$, so $(L_{ab})_{ij}=\delta_{ai}\delta_{bj}-\delta_{bi}\delta_{aj}$, with $f_a\wedge f_b\mapsto L_{ab}$. Then $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$ makes $\{L_{ab}\}_{a<b}$ orthonormal, matching the brief. The bracket is $[L_{ab},L_{cd}]=\delta_{bc}L_{ad}-\delta_{ac}L_{bd}-\delta_{bd}L_{ac}+\delta_{ad}L_{bc}$. §6.1 verifies that the anchor $\mathrm{id}^\#=(n-2)\mathrm{id}$ holds in exactly this realisation, so the calibration the brief relies on is internally consistent rather than assumed.
- **Graphs.** Finite, simple (no loops, no multiple edges), forced, since an edge is an unordered pair $\{a,b\}$ with $a\ne b$ indexing a hollow symmetric $K$. Ground field $\mathbb R$.

## Hypothesis inventory (item 1)

### L177

| Hypothesis | Status |
| --- | --- |
| $G$ finite and **simple** | **used, unstated.** A multi-edge would give a "bipartite cycle" of length 2 and break the $\ge4$ in §4.2; a loop breaks the rank identity's source statement. Forced by the indexing, so harmless, but it is a hypothesis. |
| Ground field of **characteristic $\ne2$** | **used, unstated.** The odd-walk step is literally $\epsilon_v=-\epsilon_v\Rightarrow\epsilon_v=0$. Over $\mathbb F_2$ the identity is $\mathop{\mathrm{rank}}N=\lvert V\rvert-c$ and biparticity is invisible; the source says so explicitly (§2). $\mathbb R$ is the field here, so the identity applies. |
| An edgeless component counts as **bipartite** | **used, unstated.** Needed for the formula to be insensitive to isolated vertices; true under the standard definition and under the source's (a one-vertex component is vacuously balanced). |
| Whether $V=[n]$ or only the vertices meeting an edge | **immaterial, and worth saying so.** An isolated vertex adds $1$ to $\lvert V\rvert$ and $1$ to $b$, so $\lvert E\rvert-\lvert V\rvert+b$ is unchanged. |
| $n\ge3$ in claim (3) | **stated and genuinely used.** It is what makes $K_n$ non-bipartite so $b=0$. It is load-bearing for the *formula* as well: at $n=2$, $\binom22-2=-1$, whereas the true dimension is $1-2+1=0$. |

### L178

| Hypothesis | Status |
| --- | --- |
| $W\ne0$ | **used**, $\theta$ is undefined at $W=0$. Note $0\in\mathcal W_n$, so this is not idle. |
| Support in $\Lambda^2V$, $\dim V=4$ | **used, and load-bearing**, see §13. |
| $\mathop{\mathrm{rank}}W\le3$ | **used** in step 1 only. |
| An **orientation** on $V$ | **used, unstated.** $\Lambda^\pm$ needs one. The conclusion is orientation-blind (reversing it swaps $W^\pm$, and both summands carry $\gamma^2=2$), so this costs nothing, but the step-1 sentence presumes a choice that the statement never makes. |
| $W\vert_V\in\mathcal W_4$ | **used, unstated, and true.** For $a,c\in V$, $\sum_{b\in[n]}W_{abcb}=\sum_{b\in V}W_{abcb}$ because every other term has an index pair outside $V$; so the restriction is totally trace-free on $V$, and the symmetries and Bianchi restrict verbatim. Without this, step 1's four-dimensional splitting would not be available. |
| Total trace-freeness | **used twice**, for $\mathop{\mathrm{tr}}W=0$ in step 4, and (see §5.1) for the vanishing of the mixed $\Lambda^+\to\Lambda^-$ block in step 1. |
| **First Bianchi identity** | **stated and unused.** The proof never invokes it. In general one needs it to force $\mathop{\mathrm{tr}}W^+=\mathop{\mathrm{tr}}W^-$ separately; here one summand is already zero, so $\mathop{\mathrm{tr}}W^+=\mathop{\mathrm{tr}}W=0$ follows from trace-freeness alone. The argument as written would go through for any trace-free self-adjoint $\ast$-commuting operator on $\Lambda^2V$. |
| $n\ge12$, the conjecture's range | **not a hypothesis of L178 at all**, and correctly so, see §12. |
| $\ker W\ne0$ | **never assumed away**, see §11. |

## 1. L177 claim (1): the locus is $\ker N$, of dimension $\lvert E\rvert-\lvert V\rvert+b$

Taking as given (the brief permits it) that the coordinate-diagonal locus is exactly the hollow symmetric $K$ with $\sum_bK_{ab}=0$, "supported inside $G$" means $K_{ab}=0$ for $\{a,b\}\notin E$, so $K$ is determined by its values $x_e:=K_e$ on $E$ and the constraint at vertex $v$ reads $\sum_{e\ni v}x_e=0$, i.e. $Nx=0$. The identification of the locus with $\ker N$ is therefore exact, and linear. Then rank–nullity: $\dim\ker N=\lvert E\rvert-\mathop{\mathrm{rank}}N=\lvert E\rvert-\lvert V\rvert+b$.

**Verdict: SOUND.** The two unstated hypotheses in the inventory (characteristic, looplessness) hold in the record's setting.

## 2. The rank identity, read at a source (item 2)

**Source fetched:** Thomas Zaslavsky, *Matrices in the Theory of Signed Simple Graphs*, arXiv:[1303.3083](https://arxiv.org/abs/1303.3083), filed as [references/zaslavsky-2013-signed-graph-matrices/](../references/zaslavsky-2013-signed-graph-matrices/) with [README.md](../references/zaslavsky-2013-signed-graph-matrices/README.md) and [notes.md](../references/zaslavsky-2013-signed-graph-matrices/notes.md). **That folder is left uncommitted, per my instruction; the parent folds it in.**

Zaslavsky Theorem IV.1 (attributed to Jeurissen and to Zaslavsky): for a signed graph $\Sigma$ on $n$ vertices, $H(\Sigma)$ has rank $n-c(\Sigma)$ in characteristic 2 and $n-b(\Sigma)$ otherwise, with $b$ counting balanced components. Example IV.F.2 specialises it in the exact words the record needs: the unoriented $(0,1)$ incidence matrix of $\Gamma$ is an incidence matrix of the all-negative signed graph $-\Gamma$, which is balanced iff $\Gamma$ is bipartite (Corollary I.3, Harary's Balance Theorem with an empty part allowed), so *"the rank of the matrix (except in characteristic 2) equals $n-b$ where $b$ is the number of bipartite components of $\Gamma$."* Original attribution: van Nuffelen (1973).

**Against the brief's proof of it.** The brief's argument is Zaslavsky's, unsigned. Both block over components first ($N=\bigoplus_iN_i$) then handle a connected component. Bipartite: the $\pm1$ colour vector $\epsilon$ has $\epsilon^{\mathsf T}N=0$ since each edge crosses the parts, and connectivity makes the left null space at most one-dimensional (a left null vector satisfies $\epsilon_u=-\epsilon_v$ on every edge, so it is determined by one vertex), hence rank $\lvert V_i\rvert-1$. Non-bipartite: an odd closed walk gives $\epsilon_v=-\epsilon_v$, so $2\epsilon_v=0$ and, over $\mathbb R$, $\epsilon_v=0$; propagating along the connected component kills $\epsilon$, so rank $\lvert V_i\rvert$. Correct.

**The brief's five test cases, answered explicitly.**

| case | $\lvert V\rvert-b$ | true rank | agree |
| --- | --- | --- | --- |
| over $\mathbb R$ | $\lvert V\rvert-b$ | $\lvert V\rvert-b$ | yes (fails in char 2) |
| isolated vertex | contributes $1-1=0$ | zero row, contributes 0 | yes |
| disconnected | additive over blocks | additive over blocks | yes |
| single edge | $2-1=1$ | $N=\binom11$, rank 1 | yes |
| no edges at all | $\lvert V\rvert-\lvert V\rvert=0$ | $N$ has no columns, rank 0 | yes |

**Verdict: SOUND AND SOURCED.**

## 3. L177 claim (2): the full-support criterion (item 3, the brief's flagged risk)

### 3.1 The stated equivalence is correct, and empty

"Support exactly $G$" means: $K_e\ne0$ for every $e\in E$ and $K_e=0$ off $E$. By §1 that is precisely "$x\in\ker N$ with $x_e\ne0$ for all $e$", i.e. a full-support vector of $\ker N$. So the "iff" is true, but it is the definition rewritten, not a criterion. It buys nothing that $\ker N$'s *dimension* could not already say, and in particular it does **not** reduce the realisability question to a rank computation.

### 3.2 The reading the brief warns about is false, and here is the object

**Claim.** $\ker N\ne0$ does **not** imply that $\ker N$ contains a full-support vector.

**Counterexample, exhibited in closed form.** $G$ = a 4-cycle with one pendant edge: $V=\{1,2,3,4,5\}$, $E=\{12,23,34,41,45\}$. It is connected and bipartite (parts $\{1,3,5\}$, $\{2,4\}$), so $b=1$ and
$$\dim\ker N=\lvert E\rvert-\lvert V\rvert+b=5-5+1=1\ne0 .$$
The vertex-5 constraint is the single equation $x_{45}=0$. Hence **every** vector of $\ker N$ vanishes on the edge $45$, and $\ker N=\mathop{\mathrm{span}}\{(x_{12},x_{23},x_{34},x_{41},x_{45})=(1,-1,1,-1,0)\}$, which has support $\{12,23,34,41\}$, not $E$. So $\ker N\ne0$ while no coordinate-diagonal Weyl tensor has support exactly $G$.

The mechanism is general and worth naming positively: a full-support vector exists iff no coordinate functional $x\mapsto x_e$ vanishes identically on $\ker N$ (a finite union of proper subspaces of $\ker N$ cannot cover it). Any pendant edge forces its own coordinate to zero, so **no graph with a pendant edge is ever an exact support**, however large its kernel.

### 3.3 Does the defect propagate?

**Not in the arguments the brief shows.** The minimum-edge count uses only the safe direction, *exact support $\Rightarrow$ full-support vector $\Rightarrow\ker N\ne0\Rightarrow\lvert E\rvert\ge\lvert V\rvert-b+1$*. The trap is latent: any downstream use of $\lvert E\rvert\ge\lvert V\rvert-b+1$ as a *sufficient* condition for realisability is wrong, and $C_4$-plus-pendant is the witness. I could not check whether such a use exists, because the brief is cold and I did not read [findings/](../findings/); the parent should check.

**Verdict: the "iff" is SOUND BUT VACUOUS; the sufficiency reading is REFUTED IN CLOSED FORM.**

### 3.4 The screen

I ran one exact-rational nullspace computation on five graphs I constructed for this report ($C_4$+pendant, $K_4-e$, the bowtie, $C_4\sqcup K_2$, $C_4\sqcup C_3$), to guard the hand arithmetic in §3.2, §4.3 and §4.4 against a slip. Every kernel came out integral and identical to the vector I had derived by hand. **This is a screen. No claim in this report rests on it**; each of those kernels is derived in closed form in the text.

## 4. L177's minimum-edge argument (item 4, and the coordinator's correction)

### 4.1 Is the brief's whole-graph case split sound as written? **No.**

The brief argues: a support needs $\lvert E\rvert\ge\lvert V\rvert-b+1$; *all-bipartite* gives an independent cycle, which is even, so $\ge4$ edges; *otherwise a non-bipartite component needs $\lvert E_i\rvert\ge\lvert V_i\rvert+1$*, and the smallest such graph with an odd cycle has five edges.

The first branch is fine. **The second branch does not follow from the global inequality it is derived from.** $\lvert E\rvert\ge\lvert V\rvert-b+1$ says only that *some* component has excess; it says nothing about the non-bipartite one. Exhibit: $G=C_4\sqcup C_3$ on $V=\{1,\dots,7\}$, $E=\{12,23,34,41\}\cup\{56,67,75\}$. Here $\lvert V\rvert=7$, $\lvert E\rvert=7$, $b=1$ (the $C_4$), and $\lvert V\rvert-b+1=7\le\lvert E\rvert$, the global hypothesis holds. Yet the non-bipartite component $C_3$ has $\lvert E_i\rvert=3=\lvert V_i\rvert$, flatly contradicting the branch's asserted $\lvert E_i\rvert\ge\lvert V_i\rvert+1$. (Its kernel is $(1,-1,1,-1,0,0,0)$, the triangle's coordinates are forced to zero, so this $G$ is not a support either; that is a *different* fact, and it is the per-component argument, not the global inequality, that sees it.)

So the brief's transcription reaches its conclusion through a step that is a non sequitur. **The conclusion $\lvert E\rvert\ge4$ is nevertheless true**, and even survives on the loose reading if one repairs the second branch crudely: with $\lvert E\rvert=3$ the only graph containing an odd cycle is a triangle plus isolated vertices, whose kernel is $3-3+0=0$, so it is not a support.

**Verdict: UNSOUND AS WRITTEN, CONCLUSION SAFE.**

### 4.2 The per-component form: the three attacks the coordinator names

**(a) "$x$ restricted to a component lies in that component's kernel", is it as free as it looks?** Yes, with one exception that must be written in. Every edge has both endpoints in one component and every vertex row meets only edges of its own component, so $N=\bigoplus_iN_i$ after reordering, Zaslavsky's proof opens with exactly this block form. Restriction to $G_i$ is literally the projection onto a block summand, so $\ker N=\bigoplus_i\ker N_i$ and the restriction of a full-support $x$ is a full-support element of $\ker N_i$. **The exception: a component with no edges.** There $E_i=\varnothing$, $\ker N_i$ is the zero space, and "fully supported" holds vacuously for the empty vector, so $\ker N_i\ne0$ *fails*, and the componentwise inequality $\lvert E_i\rvert\ge\lvert V_i\rvert-b_i+1$ reads $0\ge1$, which is false. The argument's phrase "hence $\ker N_i$ is nonzero for EVERY component" is therefore false as stated, and its conclusion "every component has at least 4 edges" is false for an isolated vertex. **Repair, one clause:** restrict the quantifier to components carrying at least one edge. The conclusion $\lvert E\rvert\ge4$ is untouched, since edgeless components contribute no edges.

**(b) Does the bipartite case really force a cycle, rather than merely $\lvert E_i\rvert\ge\lvert V_i\rvert$?** It forces a cycle. A connected acyclic graph is a tree and has exactly $\lvert V_i\rvert-1$ edges; $\lvert E_i\rvert\ge\lvert V_i\rvert>\lvert V_i\rvert-1$ therefore rules out acyclicity. The cycle lies in a bipartite graph, so it is even; in a **simple** graph a cycle has length $\ge3$, so an even one has length $\ge4$, and its 4 edges lie in $E_i$. Hence $\lvert E_i\rvert\ge4$. The step is sound, and its dependence on simplicity is worth stating, with multi-edges a digon is an even cycle of length 2 and the bound collapses to 2.

**(c) Is 5 right for the non-bipartite minimum, or does some component shape beat it?** 5 is right, by exhaustion on $\lvert V_i\rvert$ with $\lvert E_i\rvert\le\binom{\lvert V_i\rvert}2$ (simple, connected, non-bipartite, $\lvert E_i\rvert\ge\lvert V_i\rvert+1$):

| $\lvert V_i\rvert$ | required $\lvert E_i\rvert$ | available $\binom{\lvert V_i\rvert}2$ | possible |
| --- | --- | --- | --- |
| 1 | $\ge2$ | 0 | no |
| 2 | $\ge3$ | 1 | no |
| 3 | $\ge4$ | 3 | no |
| 4 | $\ge5$ | 6 | **yes**, $K_4-e$, 5 edges, contains a triangle |
| $\ge5$ | $\ge6$ |, | yes, but $\ge6>5$ edges |

So no shape beats 5, and $5\ge4$, which is all the branch owes.

### 4.3 The five is real but never attained as a support

$K_4-e$ meets the graph-theoretic description at 5 edges, but it is **not** an exact support. On $V=\{1,2,3,4\}$, $E=\{12,13,14,23,24\}$: the vertex-3 and vertex-4 rows give $x_{23}=-x_{13}$ and $x_{24}=-x_{14}$; vertex 2 then gives $x_{12}=x_{13}+x_{14}$; vertex 1 gives $2(x_{13}+x_{14})=0$, so $x_{13}=-x_{14}$ and $x_{12}=0$. Hence $\ker N=\mathop{\mathrm{span}}\{(0,1,-1,-1,1)\}$, supported on the 4-cycle $1$–$3$–$2$–$4$–$1$, and the edge $12$ is forced to zero. This is the §3.2 phenomenon again.

Consequently no non-bipartite component is an exact support at 5 edges: a 5-edge non-bipartite component must be $K_4-e$ by the table above (a 4-edge non-bipartite component would need $\lvert V_i\rvert\le3$, hence $\le3$ edges). The smallest that is, is the **bowtie**, two triangles sharing a vertex, $\lvert V\rvert=5$, $\lvert E\rvert=6$, $\dim\ker N=6-5+0=1$, with kernel $(x_{12},x_{13},x_{23},x_{14},x_{15},x_{45})=(1,1,-1,-1,-1,1)$, fully supported.

This does not damage the $\lvert E\rvert\ge4$ conclusion. It does mean the "five edges" in the record's text is a statement about a graph class, not about a realisable support, and a reader who takes it as the latter will be wrong by one.

**Verdict on 4b: SOUND AFTER THE EDGELESS-COMPONENT QUALIFIER. Verdict on 4c: TRUE, AND NOT ATTAINED.**

## 5. L178 step 1: the splitting and the rank arithmetic (item 5)

### 5.1 Why $W$ is block diagonal

The brief asserts the splitting without argument. It is true, and the reason is worth writing down because it identifies which hypothesis pays for it. Under $SO(4)$, $\mathop{\mathrm{Sym}}^2(\Lambda^2\mathbb R^4)$ (dimension 21) decomposes as $\mathop{\mathrm{Sym}}^2\Lambda^+\oplus\mathop{\mathrm{Sym}}^2\Lambda^-\oplus(\Lambda^+\otimes\Lambda^-)$ with dimensions $6+6+9$; the mixed block is the 9-dimensional summand, isomorphic to $\mathop{\mathrm{Sym}}^2_0\mathbb R^4$. The Ricci contraction $R\mapsto(\sum_bR_{abcb})_0$ is a nonzero $SO(4)$-map onto that irreducible 9-dimensional target, so by Schur it annihilates $\mathop{\mathrm{Sym}}^2\Lambda^\pm$ and is injective on the mixed block. **Total trace-freeness therefore kills the mixed block exactly**, and $W=W^+\oplus W^-$. The first Bianchi identity is not needed for this, it is what would separately force $\mathop{\mathrm{tr}}W^+=\mathop{\mathrm{tr}}W^-$, and here $\mathop{\mathrm{tr}}W=0$ plus $W^-=0$ already gives what step 4 wants. Recording this as a **citation debt, not a defect**: the block should say why the splitting holds.

### 5.2 "Trace-free on a three-space, hence never rank one"

$W^\pm$ is self-adjoint on a 3-dimensional space with $\mathop{\mathrm{tr}}W^\pm=0$ (see §5.1 and §9). If exactly one eigenvalue were nonzero the trace would equal it and be nonzero. So $\mathop{\mathrm{rank}}\in\{0,2,3\}$. **Correct.**

### 5.3 Every split, checked

$\mathop{\mathrm{rank}}W=\mathop{\mathrm{rank}}W^++\mathop{\mathrm{rank}}W^-$ because the blocks are orthogonal.

| $(\mathop{\mathrm{rank}}W^+,\mathop{\mathrm{rank}}W^-)$ | total | $\le3$? |
| --- | --- | --- |
| $(0,0)$ | 0 | yes, $W=0$, excluded by hypothesis |
| $(2,0)$, $(0,2)$ | 2 | yes |
| $(3,0)$, $(0,3)$ | 3 | yes |
| $(2,2)$ | 4 | **no** |
| $(2,3)$, $(3,2)$ | 5 | **no** |
| $(3,3)$ | 6 | **no** |

Every admissible row has a vanishing summand. **The claim "rank $\le3$ forces a summand to vanish" is right, and the $2+1$ shape the brief asks about cannot arise because rank 1 is impossible at all.** The rank-2 case has a zero eigenvalue in the surviving block, so $e_3=\det=0$ and $\theta=9e_3=0<\sqrt{3/2}$; the bound holds strictly there and the equality analysis is confined to the rank-3 case, as step 5 assumes.

**Verdict: SOUND.**

## 6. L178 step 2, the constant $\gamma^2$ (item 6, derived independently, twice)

The brief warns that a factor of two here changes the answer. I derived $\gamma^2$ from scratch by two routes that share no arithmetic, and both give $\gamma^2=2$.

### 6.1 First, the anchor itself is verified, not assumed

With $L_{ab}$ as in §0 and $W=\mathrm{id}$, the index formula gives $(\mathrm{id}^\#)_{\alpha\beta}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}$. Take $\alpha=\beta=L_{12}$. From the bracket relation, for each $d\ge3$,
$$[L_{12},L_{1d}]=-L_{2d},\qquad [L_{12},L_{2d}]=+L_{1d},$$
and every other bracket $[L_{12},L_{cd}]$ vanishes (either $\{c,d\}\cap\{1,2\}=\varnothing$, or $\{c,d\}=\{1,2\}$). So $\sum_{\gamma\delta}c_{12,\gamma\delta}^2=2(n-2)$, one contribution $(-1)^2$ for each of the $n-2$ choices $\gamma=L_{1d}$, one $(+1)^2$ for each $\gamma=L_{2d}$, and $(\mathrm{id}^\#)_{12,12}=\tfrac12\cdot2(n-2)=n-2$. Equivariance gives the off-diagonal entries zero. **$\mathrm{id}^\#=(n-2)\mathrm{id}$ holds in the very realisation the brief's orthonormality convention picks out.** The calibration is therefore not circular.

### 6.2 Route A, the brackets of an orthonormal $\Lambda^+$ basis, computed

Orthonormal basis of $\Lambda^+$ (each is $1/\sqrt2$ times a sum of two orthonormal $L$'s, hence unit):
$$\omega_1=\tfrac1{\sqrt2}(L_{12}+L_{34}),\quad \omega_2=\tfrac1{\sqrt2}(L_{13}-L_{24}),\quad \omega_3=\tfrac1{\sqrt2}(L_{14}+L_{23}).$$
Compute $[\omega_1,\omega_2]=\tfrac12\big([L_{12},L_{13}]-[L_{12},L_{24}]+[L_{34},L_{13}]-[L_{34},L_{24}]\big)$ term by term from the bracket relation:
$$[L_{12},L_{13}]=-L_{23},\quad [L_{12},L_{24}]=+L_{14},\quad [L_{34},L_{13}]=L_{41}=-L_{14},\quad [L_{34},L_{24}]=-L_{32}=+L_{23}.$$
Hence $[\omega_1,\omega_2]=\tfrac12(-L_{23}-L_{14}-L_{14}-L_{23})=-(L_{14}+L_{23})=-\sqrt2\,\omega_3$.

So in an **orthonormal** basis of $\Lambda^+$ the structure constants are $c_{ijk}=\gamma\epsilon_{ijk}$ with $\gamma=-\sqrt2$, i.e. $\boxed{\gamma^2=2}$. The sign depends on the orientation convention fixing $\omega_2$, and is irrelevant: $\#$ is quadratic in $c$.

### 6.3 Route B, the Casimir sum, with no bracket computed twice

For $\alpha\in\Lambda^+$, $\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}$ over all of $\mathfrak{so}(4)$ equals $2(n-2)\delta_{\alpha\beta}=4\delta_{\alpha\beta}$ at $n=4$ by §6.1. Because $\mathfrak{so}(4)=\Lambda^+\oplus\Lambda^-$ is a sum of **ideals**, $c_{\alpha\gamma\delta}=0$ unless all three indices sit in the same summand, so that full sum equals the sum restricted to $\Lambda^+$, which with $c=\gamma\epsilon$ is $\gamma^2\sum_{cd}\epsilon_{acd}\epsilon_{bcd}=2\gamma^2\delta_{ab}$. Thus $2\gamma^2=4$ and $\gamma^2=2$. **Agrees with Route A.**

### 6.4 Is the brief's own justification sound?

Its value is right; its sentence is loose. The brief computes $(\mathrm{id}^\#)_{ab}=\tfrac12\gamma^2\sum\epsilon_{acd}\epsilon_{bcd}=\gamma^2\delta_{ab}$, but the $\mathrm{id}$ on the left is the identity of the **three-dimensional** $\Lambda^+$, whereas the anchor $\mathrm{id}^\#=(n-2)\mathrm{id}$ is about the identity of the **six-dimensional** $\Lambda^2\mathbb R^4$. These are different operators and the brief slides between them without comment. The equation it writes is nonetheless true, because the ideal structure makes $\#$ additive across the two summands: writing $P^\pm$ for the projections, $(P^++P^-)^\#=(P^+)^\#+(P^-)^\#$ with no cross term, and both summands are alike, so $2\,\mathrm{id}=\mathrm{id}^\#=(P^+)^\#+(P^-)^\#$ forces $(P^\pm)^\#=2P^\pm$. **Correct value, loose justification**, the block owes one sentence saying why the two identities may be interchanged, and §6.2 is a cleaner substitute that avoids the question entirely.

**Verdict: $\gamma^2=2$ CONFIRMED INDEPENDENTLY, TWICE. No factor of two is lost here.**

## 7. L178 step 2, the adjugate (item 7)

For a $3\times3$ matrix, $\mathop{\mathrm{cof}}(M)_{ab}=\tfrac12\epsilon_{acd}\epsilon_{bef}M_{ce}M_{df}$, the classical cofactor identity; the normalisation is checked at $M=I$, where the right-hand side is $\tfrac12\epsilon_{acd}\epsilon_{bcd}=\delta_{ab}=\mathop{\mathrm{cof}}(I)_{ab}$. Substituting $c=\gamma\epsilon$ into the index formula gives exactly $\gamma^2$ times that expression, so
$$W^\#=\gamma^2\mathop{\mathrm{cof}}(W)=2\mathop{\mathrm{cof}}(W).$$
This is basis-free on $\Lambda^+$ (both sides are $SO(3)$-equivariant), so the brief's restriction to "the diagonalising basis" is a convenience, not a hypothesis.

$W$ is symmetric, so $\mathop{\mathrm{cof}}(W)=\mathop{\mathrm{adj}}(W)$ and $W\mathop{\mathrm{adj}}(W)=(\det W)\,I_3$, giving
$$\langle W,W^\#\rangle=\mathop{\mathrm{tr}}(W\cdot2\mathop{\mathrm{adj}}W)=2\cdot3\det W=6e_3 .$$
The factor 3 is the trace of $I_3$, i.e. it is the dimension of $\Lambda^+$, not of $\Lambda^2\mathbb R^n$, and that is right because $W^\#$ is supported on $\Lambda^+$ (§8).

**Verdict: SOUND.**

## 8. L178 step 3, the padding, and *which $n$* (item 8)

**Does $\#$ commute with the zero-embedding?** Yes, and the brief's reason is the right one. Choose the orthonormal frame so $f_1,\dots,f_4$ span $V$; then $\{f_a\wedge f_b\}$ is an orthonormal basis of $\Lambda^2\mathbb R^n$ whose first six vectors span $\Lambda^2V$. In $(W^\#)_{\alpha\beta}=\tfrac12\sum c_{\alpha cd}c_{\beta ef}W_{ce}W_{df}$, a nonzero $W_{ce}$ needs $c,e\in\Lambda^2V$ and a nonzero $W_{df}$ needs $d,f\in\Lambda^2V$. Since $\mathfrak{so}(V)$ is a **subalgebra** of $\mathfrak{so}(n)$, $[E_c,E_d]\in\mathfrak{so}(V)$ for $c,d\in\Lambda^2V$, so $c_{\alpha cd}=0$ unless $\alpha\in\Lambda^2V$, and then the surviving $c$'s are literally $\mathfrak{so}(4)$'s own structure constants, which do not depend on $n$. So $W^\#$ is supported on $\Lambda^2V$ and is computed intrinsically. Combined with §5.1, the same argument run inside $\mathfrak{so}(4)=\Lambda^+\oplus\Lambda^-$ (now a sum of **ideals**) confines $W^\#$ further to $\Lambda^+$.

**Is the anchor read at the right $n$?** Yes, and this is the trap the brief points at. The $n$-dependent anchor must **not** be applied to $\mathrm{id}_{\Lambda^2V}\oplus0\in\mathfrak{so}(n)$: by the padding argument just given, that operator's $\#$ is $(4-2)\,\mathrm{id}_{\Lambda^2V}=2\,\mathrm{id}_{\Lambda^2V}$, **not** $(n-2)\,\mathrm{id}_{\Lambda^2V}$. Reading it at the ambient $n$ would inflate $\gamma^2$ by $(n-2)/2$, a factor 5 at $n=12$, and $\theta$ scales as $3e_3+3\gamma^2e_3$, so it would turn the bound $\sqrt{3/2}$ into $(3+3\cdot10)/(3\sqrt6)=11/\sqrt6=4.4907$, far above every threshold the programme watches. **The record does not make this error.** Its $n=4$ is the $n$ of the algebra in which the calibrating object $\mathrm{id}_{\Lambda^2V}$ actually is the identity, which is the only reading under which the anchor applies at all. §6.2 confirms the value $\gamma^2=2$ with no anchor, so the conclusion does not even depend on getting the reading right.

The brief's own phrasing, *"$\theta$ is an invariant of the four-dimensional piece, which is why step 2 reads the anchor at $n=4$"*, states the correct reason. I would sharpen it: $\gamma^2$ is a property of $\mathfrak{so}(4)$'s brackets and is $n$-free; there is no "reading at an $n$" to get wrong once that is said.

**Verdict: SOUND, AND THE $n$ IS THE RIGHT ONE.**

## 9. L178 step 4 (item 9)

- **$\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)$ is the norm $\theta$ is defined against.** The brief's conventions fix it: $\lVert W\rVert^2=\mathop{\mathrm{tr}}(W^2)=\sum_\alpha\lambda_\alpha^2$ over the $\Lambda^2$ spectrum, and $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$, so $P=\langle W,Q(W)\rangle$ and the norm use the same pairing. Internally consistent. **One convention risk to flag for the parent, since I cannot check it from a cold brief:** the tensor norm $\sum_{abcd}W_{abcd}^2$ equals $4\mathop{\mathrm{tr}}(W^2)$ under the operator convention $M_{(ab),(cd)}=W_{abcd}$ for $a<b$, $c<d$, which the brief's own coordinate-diagonal fact $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$ pins down. If any other block of the record measures $\lVert W\rVert$ tensorially, $\theta$ there differs from $\theta$ here by $2^{-1}$ and the two must not be compared. Nothing in L178 depends on the answer.
- **$p_1=e_1=0$.** $\mathop{\mathrm{tr}}(W\vert_{\Lambda^2})=\sum_{a<b}W_{abab}=\tfrac12\sum_{a,b}W_{abab}=0$ by total trace-freeness. With $W^-=0$ this is $\mathop{\mathrm{tr}}W^+=e_1=0$.
- **Newton.** $p_1=e_1=0$; $p_2=e_1p_1-2e_2=-2e_2$; $p_3=e_1p_2-e_2p_1+3e_3=3e_3$. Both used correctly.
- **$\theta=9e_3$.** $P=\langle W,W^2\rangle+\langle W,W^\#\rangle=\mathop{\mathrm{tr}}W^3+6e_3=p_3+6e_3=3e_3+6e_3=9e_3$, and with $\lVert W\rVert=1$, $\theta=P$. ✓

**Verdict: SOUND.**

## 10. L178 step 5: the bound, and the equality clause (item 10)

### 10.1 The bound

$e_1=0$ and $p_2=1$ give $e_2=-\tfrac12$, so the characteristic polynomial of $W^+$ is $x^3-e_1x^2+e_2x-e_3=x^3-\tfrac12x-e_3$. For $x^3+px+q$ the discriminant is $\Delta=-4p^3-27q^2$; with $p=-\tfrac12$, $q=-e_3$,
$$\Delta=-4\left(-\tfrac18\right)-27e_3^2=\tfrac12-27e_3^2 .$$
$W^+$ is a **real symmetric** operator, so its three eigenvalues are real and $\Delta\ge0$ automatically, the implication runs from self-adjointness to the constraint, which is the right direction. Hence $e_3^2\le\tfrac1{54}$, $\lvert e_3\rvert\le\tfrac1{\sqrt{54}}=\tfrac1{3\sqrt6}$, and
$$\theta=9e_3\le\frac9{3\sqrt6}=\frac3{\sqrt6},\qquad\left(\frac3{\sqrt6}\right)^2=\frac96=\frac32 .$$
Sign convention, arithmetic and the identification $3/\sqrt6=\sqrt{3/2}$ all check. **SOUND.**

### 10.2 The equality case: the spectrum

$\Delta=0$ forces a repeated root. At $e_3=\tfrac1{3\sqrt6}$, substituting $x=2/\sqrt6$: $\tfrac8{6\sqrt6}-\tfrac1{\sqrt6}-\tfrac1{3\sqrt6}=\tfrac{4-3-1}{3\sqrt6}=0$; and $x=-1/\sqrt6$: $-\tfrac1{6\sqrt6}+\tfrac1{2\sqrt6}-\tfrac1{3\sqrt6}=\tfrac{-1+3-2}{6\sqrt6}=0$. So the spectrum is $\tfrac1{\sqrt6}(2,-1,-1)$, with checks $\sum\lambda=0$, $\sum\lambda^2=\tfrac{4+1+1}6=1$, $\prod\lambda=\tfrac2{6\sqrt6}=\tfrac1{3\sqrt6}$. All three ✓. That ratio $(2,-1,-1)$ is the self-dual Weyl spectrum of a Kähler surface, $\mathbb{CP}^2$ with the Fubini–Study metric among them.

### 10.3 The uniqueness statement is **false as written**, "sign" must go

$P$ is homogeneous of degree 3 and $\lVert W\rVert^3$ of degree 3 in $\lVert W\rVert$, so
$$\theta(-W)=\frac{P(-W)}{\lVert -W\rVert^3}=\frac{-P(W)}{\lVert W\rVert^3}=-\theta(W).$$
**$\theta$ is odd.** Hence $-W_{\mathbb{CP}^2}$, whose $\Lambda^+$ spectrum is $\tfrac1{\sqrt6}(-2,1,1)$ and whose $e_3=-\tfrac1{3\sqrt6}$, has $\theta=-\sqrt{3/2}$, it satisfies the bound strictly in the sense of being far below it, and does **not** attain equality. The clause "equality exactly when $W$ is $W_{\mathbb{CP}^2}$ up to scale, sign and frame" therefore fails in the *sufficiency* direction: it names a family half of whose members miss equality by $2\sqrt{3/2}$. The *necessity* direction is fine.

The same remark applies to "scale" if negative scalars are admitted: $\theta(\lambda W)=\mathop{\mathrm{sgn}}(\lambda)\theta(W)$, so only $\lambda>0$ preserves equality.

**Two clean repairs, either acceptable.** (i) Drop "sign": *equality exactly when $W$ is a positive multiple of $W_{\mathbb{CP}^2}$ up to frame.* (ii) Keep "sign" and state the two-sided bound: $\lvert\theta\rvert\le\sqrt{3/2}$, with equality exactly when $W$ is $W_{\mathbb{CP}^2}$ up to scale, sign and frame.

**Does "frame" cover the anti-self-dual mirror?** Yes. An orientation-reversing element of $O(4)$ interchanges $\Lambda^+$ and $\Lambda^-$, carrying the self-dual extremiser to the anti-self-dual one; and the mirror attains equality on its own account, since both summands are ideals isomorphic as Lie algebras with the same $\gamma^2=2$, so §§6–9 run verbatim on $\Lambda^-$. So the mirror is genuinely in the equality set and "up to frame" is the right word for it, provided "frame" is read as all of $O(4)$ and not only $SO(4)$. That is a second, milder wording debt.

**One naming note.** "$W_{\mathbb{CP}^2}$" is a *spectral* identification: every Kähler surface has $W^+$ spectrum in the ratio $(2,-1,-1)$, so the algebraic tensor characterised here is realised by more than $\mathbb{CP}^2$. As a statement about algebraic Weyl tensors it is nonetheless unambiguous, spectrum plus $W^-=0$ determines the tensor up to frame.

**Verdict: the bound SOUND; the equality clause FALSE AS STATED, repairable by deleting one word.**

## 11. The kernel (item 11)

$W$ has an enormous kernel: $\Lambda^2\mathbb R^n$ has dimension $\binom n2$ (66 at $n=12$), $W$ is supported on a 6-dimensional $\Lambda^2V$, of which one 3-dimensional summand is zero, and the surviving block has rank 3 at most. **No step assumes $\ker W=0$**, and the places where it might have bitten all survive:

- $p_2=\mathop{\mathrm{tr}}(W^2)$ and $p_3=\mathop{\mathrm{tr}}(W^3)$ over $\Lambda^2\mathbb R^n$ equal the same power sums of the three block eigenvalues, since power sums are blind to adjoined zeros.
- $e_1,e_2,e_3$ likewise: elementary symmetric functions are unchanged by adjoining zeros (every monomial involving a zero eigenvalue vanishes). So no ambiguity arises from whether they are read on the block or on the whole spectrum.
- Step 5 does need the **characteristic polynomial of the $3\times3$ block**, not of the whole operator, the whole operator's is $x^{\binom n2-3}(x^3-\tfrac12x-e_3)$, and the discriminant argument applies to the cubic factor. The brief leaves this implicit; it is correct, but it is the one place where "almost all kernel" could have been misread, and it deserves a clause.
- $\langle W,W^\#\rangle$ picks up only the $\Lambda^+$ block because $W^\#$ is supported there (§8), which is what makes the factor $3=\dim\Lambda^+$ in §7 right.

**Verdict: NO STEP ASSUMES A TRIVIAL KERNEL.**

## 12. The boundary (item 12)

- **$n=4$ exactly.** $V=\mathbb R^4$, the padding of §8 is the identity map, and the proof is unchanged. Fine.
- **$n=5$, and odd $n$ generally.** The proof is $n$-free after §8, nothing in it distinguishes parity, and $\mathfrak{so}(V)\subset\mathfrak{so}(n)$ is a subalgebra for every $n\ge4$. Fine.
- **$n<4$.** The hypothesis "a four-dimensional $V\subseteq\mathbb R^n$" is vacuous, so the statement is vacuously true. Worth noting that $\mathcal W_3=0$ anyway, consistent with L177 (3) giving $\binom32-3=0$.
- **$n=6+2\sqrt7\approx11.2915$.** Plays no role. The bound $\sqrt{3/2}$ is independent of $n$, so the crossover the record watches cannot interact with L178.
- **$n$ below $n\ge12$.** L178 is not a statement about the conjecture's range and does not need it. This is a strength, not a gap: the bound holds for every $n\ge4$.
- **Consistency with the anchor.** $\sqrt{3/2}=1.224745<1.236033=\theta_0(12)$, so at $n=12$ a rank-$\le3$, four-dimensionally supported $W$ sits strictly below the record's anchor, by $0.011288$. Whatever L178 is for downstream, the numbers do not contradict.

## 13. Scope (item 13)

**The four-dimensional support hypothesis is load-bearing and is not derived.** It pays for the entire $\Lambda^\pm$ splitting: outside $n=4$ there is no Hodge star on $\Lambda^2$, no $W^+\oplus W^-$, and step 1's "trace-free on a three-space" has no referent. The lemma is honest about this, it *assumes* the support rather than claiming rank $\le3$ implies it.

**Whether rank $\le3$ implies four-dimensional support is a separate question with no argument in the brief.** I did not attempt to settle it: constructing a rank-$\le3$ $W\in\mathcal W_n$ whose support needs more than four dimensions would be a falsifier hunt, which the standing rule reserves, and settling the implication in the affirmative would be supplying an argument the brief tells me not to supply. **If any downstream block treats L178 as a bound on all rank-$\le3$ Weyl tensors, that step carries `HYPOTHESIS-DEBT`**, the implication is unproved on this file. As stated and as scoped, L178 claims nothing it does not reach.

## 14. What would break each claim, and what I did to look

| Claim | The falsifier | What I did |
| --- | --- | --- |
| L177 (1) | A graph where $\dim\ker N\ne\lvert E\rvert-\lvert V\rvert+b$ | Read the rank identity at [Zaslavsky Thm IV.1](../references/zaslavsky-2013-signed-graph-matrices/notes.md) and re-derived the component-blocked proof; checked the five degenerate cases (§2). None breaks. |
| L177 (2), sufficiency reading | A graph with $\ker N\ne0$ and no full-support vector | **Found one, in closed form**: $C_4$ plus a pendant edge (§3.2). Not a search, the pendant construction is the direct negation of the claim. |
| L177 (4) | A support graph with $\lvert E\rvert\le3$ | Exhausted by hand: $\le3$ edges forces every component to be a tree or a triangle, both with zero kernel (§4.1, §4.2c). None exists. |
| L177 (4), whole-graph form | A graph satisfying $\lvert E\rvert\ge\lvert V\rvert-b+1$ whose non-bipartite component violates $\lvert E_i\rvert\ge\lvert V_i\rvert+1$ | **Found one**: $C_4\sqcup C_3$ (§4.1). Exhibited, not searched. |
| L178 step 1 | A rank-$\le3$ $W$ with both summands nonzero | Impossible by the nine-row table (§5.3); the obstruction is that rank 1 cannot occur at all. |
| L178 step 2 | $\gamma^2\ne2$, the factor the brief warns of | Derived it twice from scratch, by explicit $\mathfrak{so}(4)$ brackets (§6.2) and by the Casimir sum (§6.3), after first verifying the anchor itself (§6.1). All three agree. |
| L178 step 3 | An $n$-dependence in $W^\#$ for padded $W$ | The subalgebra argument closes it (§8); I also computed what the wrong reading would give ($11/\sqrt6$ at $n=12$) to confirm the error would be visible, and it is not present. |
| L178 step 5, bound | A trace-free real symmetric $3\times3$ with $p_2=1$ and $e_3>\tfrac1{3\sqrt6}$ | Excluded by $\Delta\ge0$, which is automatic for real symmetric matrices. No such object. |
| L178 step 5, equality clause | A member of the claimed equality family that misses equality | **Found one**: $-W_{\mathbb{CP}^2}$, with $\theta=-\sqrt{3/2}$ (§10.3). Exhibited in closed form. |

No searches, sweeps, censuses or optimisations were run. The one computation was the exact-rational screen of §3.4, on five graphs I constructed to check my own hand arithmetic; every counterexample above is exhibited in closed form and derived by hand in the text.

## Verdict

**CONFIRMED-WITH-DEFECTS.**

- **L177's mathematics is right and now sourced**; its claim (2) is a definition in disguise, and the sufficiency reading of it is false, with $C_4$-plus-pendant as the witness. The brief's whole-graph minimum-edge case split is a non sequitur; the per-component form is sound once "every component" is qualified to "every component carrying an edge". The conclusion $\lvert E\rvert\ge4$ stands throughout, and the "five edges" is a true statement about graphs that is never attained by an actual support.
- **L178's bound $\theta\le\sqrt{3/2}$ is right, and $\gamma^2=2$ survives two independent derivations**, the factor of two the brief flagged is not lost, and the $n$-dependent anchor is read at the only $n$ where it applies. **Its equality clause is false as stated**: $\theta$ is odd, so "up to sign" admits $-W_{\mathbb{CP}^2}$, which attains $-\sqrt{3/2}$. One word, or one restatement as $\lvert\theta\rvert\le\sqrt{3/2}$, repairs it.
- **Three citation debts, none fatal**: the $\Lambda^\pm$ block-diagonality of a four-dimensional Weyl tensor is asserted without argument (§5.1); step 2's interchange of $\mathrm{id}_{\Lambda^+}$ with $\mathrm{id}_{\Lambda^2\mathbb R^4}$ is stated without the ideal argument that licenses it (§6.4); and step 5's cubic is the block's characteristic polynomial, not the operator's, which is left implicit (§11).
- **The fetched source** [references/zaslavsky-2013-signed-graph-matrices/](../references/zaslavsky-2013-signed-graph-matrices/) **is left uncommitted**, per instruction; only this report is committed.
