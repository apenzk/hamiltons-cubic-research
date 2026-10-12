# VERIFY v27, Lemma L148: simultaneous diagonality on the $S^2_0$ margin summand, the vanishing of $\mathrm{Alt}(W(t)_-)$ along the segment, and the clause that both defect branches are absent

**Cold brief.** Verifier v27 on [ROUND_L148](ROUND_L148.md), statement and proof quoted from [findings/second-order.md](../findings/second-order.md) lines 1183–1190, provenance stripped. **No numerical work of any kind was done: no script was run, and every value below is an exact hand evaluation from the record's own definitions.** No other verifier's report was read. Log: [agent_logs/verify-L148-v27.log](../agent_logs/verify-L148-v27.log).

## Verdicts

| # | claim, as the entry writes it | verdict |
|---|---|---|
| C1 | $W^*$ is diagonal on coordinate $2$-planes | **CONFIRMED**, in any frame adapted to $\mathbb R^n=V_1\oplus V_2$, and in every such frame |
| C2 | "$W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes", for $H$ in the summand | **REFUTED AS WRITTEN**, true under a per-$H$ frame, a closed-form witness is exhibited in §3 |
| C3 | hence $W(t)=W^*+tH$ is diagonal | **CONFIRMED**, granted C2 in its corrected reading |
| C4 | hence $W(t)_-$ is diagonal | **CONFIRMED**, and asserted with no argument; it needs no spectral gap and is indifferent to the sign convention |
| C5 | therefore $\mathrm{Alt}(W(t)_-)=0$ | **CONFIRMED** by hand from the record's own definition of $\mathrm{Alt}$; the entry carries no such computation |
| C6 | "the defect is identically zero along the whole segment" | **CONFIRMED, AND STRONGER THAN THE ENTRY CLAIMS**, every real $t$, past every eigenvalue crossing, with no analyticity used |
| C7 | "and both defect branches are absent there" | **REFUTED AS STATED.** Branch $1$ is present at $w=0$, equals $c_p/S$, and is the branch that proves the $\Theta(n^{-1})$ ceiling |
| C8 | scope: one $S^2_0(\mathbb R^m)$ copy or both | **ONE.** The extension to both is true and is one line, and that line is nowhere on file; both downstream citations need it |
| C9 | downstream use (a): $a=0$ in $(c_p+u^2)/(S+au)$, hence branch $1$ is minimised at $w=0$ | **HALF SUPPORTED.** $a=0$ on the named copy, yes; "minimised at $w=0$" does not follow and [Lemma L158](../findings/second-order.md) contradicts it in the same file |
| C10 | downstream use (b): the defect branch is unbounded at $w=0$ | **SUPPORTED IN SUBSTANCE**, subject to C8, $w=0$ is the joint two-copy eigenspace, which the written statement does not reach |
| C11 | the hypotheses the statement carries | **FOUR OMITTED**, one of them ($m\ge5$) needed by the entry's own title, §7.3 |

**One line the round can act on.** The vanishing is real, it is stronger than the entry says, and it survives every edge the brief names, but as written the lemma proves it for **one** $S^2_0$ copy under a diagonality premise that is false in a fixed frame, while both places that cite it need **both** copies, and its closing clause "both defect branches are absent there" is refuted by branch $1$'s own value $c_p/S$ at that very point.

**Verdict: `GAP`.**

## 0. Conventions, fixed once

Read from the record and used unchanged throughout.

- $n=2m$, $\mathbb R^n=V_1\oplus V_2$ with $\dim V_i=m$, blocks $B_1,B_2$ of indices. $W^*$ is the unit Weyl tensor of $S^m\times S^m$, a symmetric operator on $\Lambda^2\mathbb R^n$ ([second-order.md:887](../findings/second-order.md)).
- **$\mathrm{Alt}$ is the orthogonal projection of $S^2(\Lambda^2)$ onto $\Lambda^4$**, carrying its $\tfrac13$: $\mathrm{Alt}(R)_{ijkl}=\tfrac13(R_{ijkl}+R_{iklj}+R_{iljk})$ ([conventions.md:94](../findings/conventions.md)).
- **$W_-:=\tfrac12(\lvert W\rvert-W)\succeq0$** ([conventions.md:95](../findings/conventions.md)); [second-order.md:887](../findings/second-order.md) calls the same object "the negative spectral part". Both are spectral functions of $W$, which is all §5 uses.
- $\delta^2(W)=\lVert\mathrm{Alt}(W_-)\rVert^2$ is the defect ([second-order.md:887](../findings/second-order.md)).
- "Diagonal on coordinate $2$-planes" means diagonal in the orthogonal basis $\{e_i\wedge e_j\}_{i<j}$ of $\Lambda^2\mathbb R^n$ determined by an orthonormal frame $\{e_i\}$ of $\mathbb R^n$. **The frame is part of the assertion**, and which frame is the subject of §3.
- $\alpha=\tfrac{m-2}{2(m-1)}$, $\beta=\tfrac m{2(m-1)}$, $\lambda_m=\alpha$, $\mu$ from [Lemma L26](../findings/nondegeneracy.md), $c_p=3\theta_0/(n-2)$, $\theta_0=\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

## 1. The hypothesis inventory

**Hypotheses the statement carries in its own words:** exactly one, "$H$ in $S^2_0(\mathbb R^m)$ at $W^*$". Nothing else is stated. No dimension, no parity, no condition on $\ker W^*$, no orthogonality.

**Hypotheses the written proof actually uses**, step by step:

| step | what it needs | is it stated? | does it hold? |
|---|---|---|---|
| $W^*$ diagonal | the base point is the balanced product $S^m\times S^m$, so $n=2m$ is even and $W^*$ is $O(m)\times O(m)$-invariant | **no**, "$W^*$" is a bare symbol here, defined 300 lines earlier | yes, [second-order.md:897](../findings/second-order.md) |
| $H$ diagonal | $H$ is the **Weyl image** of $h\owedge g_q$ for $h\in S^2_0(\mathbb R^m)$, not $h$ itself; and the frame diagonalises $h$ | **no**, twice over | yes, [Lemma L146](../findings/second-order.md), re-derived by hand in §4 |
| simultaneity | the frame may be re-chosen per $H$ inside $O(m)\times O(m)$ | **no** | yes, §3 |
| $W(t)_-$ diagonal | $x\mapsto x_-$ is a spectral function | **no** | yes, either sign convention, §5 |
| $\mathrm{Alt}(W(t)_-)=0$ | $\mathrm{Alt}$ annihilates coordinate-diagonal operators | **no** | yes, §6 |
| the title's "**margin** summand" | $\lambda_m\ge\mu$, i.e. $m\ge5$ (with a tie at $m=4$) | **no** | fails at $m=3$, §7 |

**Hypotheses of the results it imports, checked against the object.**

- **[Lemma L146](../findings/second-order.md)** supplies the diagonality of $H$ ("*Diagonality does survive, both Kulkarni–Nomizu factors being diagonal in the same frame*"). Its hypotheses are $n=2m$, $m\ge3$, $\lVert H\rVert_F=1$ and **a single** $h$. The unit-norm hypothesis is idle here (diagonality is scale-free) but the *single* $h$ is not idle: it is exactly C8. L146 closed `PROVEN, hypotheses corrected` at [ROUND_L146](ROUND_L146.md); I re-derived its embedding independently in §4 rather than take it, because L146's own box records that the first version of that embedding was wrong.
- **[Lemma L27](../findings/nondegeneracy.md)** supplies the summand. Its hypotheses are $p,q\ge3$ and $(p,q)\ne(3,3)$; at $p=q=m$ that excludes $m=3$. Its decomposition lists $S^2_0(\mathbb R^p)$ and $S^2_0(\mathbb R^q)$ as **two** distinct multiplicity-free summands, the source of C8.
- **[conventions.md](../findings/conventions.md)** supplies $\mathrm{Alt}$ and the sign of $W_-$; both carry no hypotheses.

**Hypotheses the statement does *not* need, and this is worth recording as a positive.** The lemma needs **no** spectral gap, **no** analyticity of $W\mapsto W_-$, **no** $\ker W^*=0$, and **no** $n\ge12$, all four of which [Lemma L147](../findings/second-order.md) and [Lemma L149](../findings/second-order.md) do need, and which [ROUND_L147](ROUND_L147.md) records as unstated debts there. L148 is the one member of the L145–L149 chain whose mechanism survives a kernel. §7.4 says what that does and does not buy at $W_{\mathbb{CP}^2}$.

**No finding on orthogonality.** The chain's domain is $T_{W^*}S\cap T_{W^*}\mathcal O^\perp$, i.e. $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$. L148 states neither, and needs neither, but it satisfies both for free, since $S^2_0(\mathbb R^p)$ is a summand of [Lemma L27](../findings/nondegeneracy.md)'s decomposition distinct from $\langle W\rangle$ and from the orbit summand $\mathbb R^p\otimes\mathbb R^q$, and the decomposition is orthogonal. So the directions L148 speaks about are admissible directions for the chain that cites it. No debt here.

## 2. Pre-registered question 2, answered first because everything else reads through it: what does "identically" quantify over

**The words claim two different things in two places.** The statement's own sentence quantifies over $t$: "$\mathrm{Alt}(W(t)_-)=0$ **for every $t$**: the defect is identically zero **along the whole segment**". That is a quantifier over the segment at a **fixed** $H$. The entry's *title* and its displacement box quantify over directions: "the defect vanishes identically **on the margin summand**", "*a summand where $A\equiv0$*".

**What the proof establishes.** Both, but not in the order the words suggest. The argument is entirely per-direction: fix $H$, choose a frame, conclude for all $t$. Because the argument can be run at each $H$ separately, and the conclusion is frame-free, the direction-quantifier follows. **What does not follow is the reading a fixed frame invites**, that one frame diagonalises the whole summand at once. It does not; the coordinate-diagonal elements of the summand form an $(m-1)$-dimensional slice of a summand of dimension $\tfrac{m(m+1)}2-1$. §3 makes this exact.

So: **for every direction in the summand, and then for every $t$, with the frame chosen after the direction.** The written proof supports that; its wording asserts the stronger and false "$W^*$ and $H$ are simultaneously diagonal" with no frame named.

## 3. The one discrepancy in the premise, under the three-step protocol

**Locate it.** [findings/second-order.md:1187](../findings/second-order.md), the lemma's first clause: *"For $H$ in $S^2_0(\mathbb R^m)$ at $W^*$, the tensors $W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes"*.

**Exhibit the failure concretely, in closed form at a named object.** Take $m=3$, $n=6$, $B_1=\{1,2,3\}$, $B_2=\{4,5,6\}$, and the traceless symmetric $h$ with $h_{12}=h_{21}=1$ and every other entry $0$. Its Weyl image is $H=h\owedge g_q-\tfrac m{n-2}\,h\owedge g$ (§4). Evaluate the component joining the two **distinct** coordinate $2$-planes $e_1\wedge e_4$ and $e_2\wedge e_4$, using $(u\owedge v)_{ijkl}=u_{ik}v_{jl}+u_{jl}v_{ik}-u_{il}v_{jk}-u_{jk}v_{il}$:

$$(h\owedge g_q)_{1424}=h_{12}(g_q)_{44}+h_{44}(g_q)_{12}-h_{14}(g_q)_{42}-h_{42}(g_q)_{14}=1,\qquad (h\owedge g)_{1424}=h_{12}g_{44}=1,$$

so $H_{1424}=1-\beta=\alpha=\tfrac{m-2}{2(m-1)}=\tfrac14\ne0$. **An off-diagonal entry between two coordinate $2$-planes: $H$ is not diagonal on the coordinate $2$-planes of the standard frame, and $h$ is an ordinary element of $S^2_0(\mathbb R^3)$.** The same computation gives a nonzero entry at every $m\ge3$, so this is not a low-dimensional artefact.

**Argue the opposite, the most charitable reading the words support.** The frame is chosen *after* $H$. Diagonalise $h$ inside $V_1$ by the spectral theorem; the diagonalising rotation lies in $O(m)\times\{1\}\subset O(m)\times O(q)$, which fixes $W^*$, since $W^*$ acts as one scalar on $\Lambda^2V_1\oplus\Lambda^2V_2$ and another on $V_1\wedge V_2$ and both subspaces are $O(m)\times O(m)$-invariant ([second-order.md:897](../findings/second-order.md)). In the rotated frame both tensors are coordinate-diagonal, and the conclusion $\mathrm{Alt}(W(t)_-)=0$ is $O(n)$-equivariant, hence frame-free. In the witness above, $h=\left(\begin{smallmatrix}0&1\\1&0\end{smallmatrix}\right)\oplus(0)$ becomes $\mathrm{diag}(1,-1,0)$ in the frame $\tfrac1{\sqrt2}(e_1\pm e_2),e_3$, and the conclusion holds there.

**Disposition: the candidate stands as a defect of the written premise and not of the conclusion.** It survives all three steps: it is located, it is exhibited in closed form at a named object, and the charitable reading is available and stated, but the charitable reading is *a step the entry does not take*, and the record's own house standard is that such a step is written down ([Lemma L146](../findings/second-order.md): "*The clause was asserted without argument until [ROUND_L146](ROUND_L146.md)*"). What is owed is one sentence: **"in the frame that diagonalises $h$ inside $V_1$, which fixes $W^*$ by its $O(m)\times O(m)$-invariance."**

## 4. The import re-derived at source: L146's embedding, by hand

I did not take L146's eigenvalue list on trust, because L146's own text records that its first version had the embedding wrong in a way that "*the in-block planes it discarded are the ones that dominate the operator norm*". Using the record's own Weyl projector $P(X)=Y-\tfrac2{n-2}\mathrm{KN}(\rho_0)-\tfrac{s}{n(n-1)}\mathrm{KN}(g)$ with $Y=X-\mathrm{Alt}(X)$ and $\mathrm{KN}(h)=\tfrac12(h\owedge g)$ ([nondegeneracy.md:375](../findings/nondegeneracy.md)), at $X=h\owedge g_q$ with $h$ diagonal on $B_1$:

- $\mathrm{Alt}(X)=0$: a Kulkarni–Nomizu product satisfies the first Bianchi identity, so $Y=X$.
- Eigenvalue of $X$ on $e_i\wedge e_j$ is $h_i(g_q)_j+h_j(g_q)_i$: it is $h_a$ on a cross plane $e_a\wedge e_b$ ($a\in B_1$, $b\in B_2$), and $0$ on both in-block families.
- $\mathrm{Ric}(X)_{ii}=\sum_j X_{ijij}$ gives $m\,h_a$ at $i=a\in B_1$ and $\sum_{a}h_a=0$ at $i\in B_2$. So $\mathrm{Ric}(X)=m\,h$, traceless, hence $\rho_0=m\,h$ and $s=0$: the third term drops.
- $\mathrm{KN}(\rho_0)=\tfrac12(m\,h)\owedge g$ has eigenvalue $\tfrac m2(h_i+h_j)$ on $e_i\wedge e_j$, so the subtraction is $\tfrac{2}{n-2}\cdot\tfrac m2(h_i+h_j)=\beta(h_i+h_j)$ with $\beta=\tfrac m{n-2}=\tfrac m{2(m-1)}$.

Hence, with $\alpha:=1-\beta=\tfrac{m-2}{2(m-1)}$, **and $\alpha+\beta=1$ exactly**, a relation the record does not state and which is the cleanest check on the pair:

$$\alpha h_a\ \text{on } e_a\wedge e_b\ (a\in B_1,b\in B_2);\qquad -\beta(h_a+h_{a'})\ \text{on } e_a\wedge e_{a'};\qquad 0\ \text{inside } B_2.$$

**This reproduces [Lemma L146](../findings/second-order.md)'s corrected embedding exactly**, and it is manifestly diagonal. Two further exact checks: the total trace is $\alpha m\sum_a h_a-\beta(m-1)\sum_a h_a=0$, consistent with $\mathrm{scal}(W)=0$; and by multiplicity-freeness of [Lemma L27](../findings/nondegeneracy.md)'s decomposition the equivariant embedding of $S^2_0(\mathbb R^p)$ into $\mathcal W_n$ is unique up to scale, so **this realisation of the summand is forced and not chosen**, which closes the question of whether L148's $H$ could be some other object.

## 5. The step the entry asserts and does not argue: $W(t)_-$ is diagonal

$W(t)=W^*+tH$ is diagonal in the chosen frame with entries $d_{ij}(t)$. Under [conventions.md](../findings/conventions.md)'s $W_-=\tfrac12(\lvert W\rvert-W)$, the entries of $W(t)_-$ are $\tfrac12(\lvert d_{ij}(t)\rvert-d_{ij}(t))$: an entrywise function of a diagonal matrix, hence diagonal in the same basis. Three consequences the entry does not draw and which strengthen it:

1. **No spectral gap is used.** The transfer is algebraic, not analytic. It holds at every real $t$, including any $t$ at which an entry crosses $0$, where $W\mapsto W_-$ is not differentiable. The lemma's "for every $t$" is therefore literally right and unrestricted, unlike the surrounding chain, which lives inside the disc $\lvert t\rvert<g_n/\lVert H\rVert_{op}$.
2. **The sign convention is inert here.** Under the opposite convention $W_-$ is diagonal with entries $\min(d_{ij},0)$, still diagonal, still killed by §6. The record calls the sign collision the thing that "*refuted four lemmas in one day*"; it does not touch this one.
3. **The reparametrisation is inert too.** The chain's curves lie on the unit sphere, not on the straight segment: $\cos t\,W^*+\sin t\,H$ and $(W^*+tH)/\lVert W^*+tH\rVert$ are both combinations of two simultaneously diagonal tensors, hence diagonal, and $\mathrm{Alt}((cW)_-)=c\,\mathrm{Alt}(W_-)$ for $c>0$. So the gap between "the segment" (what the lemma says) and "the curve in $S$" (what the chain uses) costs nothing. **No finding.**

## 6. The step the entry states as a conclusion and does not compute: $\mathrm{Alt}$ kills a coordinate-diagonal operator

From [conventions.md:94](../findings/conventions.md)'s own formula. Let $D$ be diagonal on coordinate $2$-planes: $D_{ijkl}=d_{ij}$ when $(i,j)=(k,l)$, $-d_{ij}$ when $(i,j)=(l,k)$, and $0$ otherwise.

- **All four indices distinct.** $\mathrm{Alt}(D)_{ijkl}=\tfrac13(D_{ijkl}+D_{iklj}+D_{iljk})$. The three terms pair $\{i,j\}$ against $\{k,l\}$, $\{i,k\}$ against $\{l,j\}$, $\{i,l\}$ against $\{j,k\}$; in each the two index pairs are disjoint, hence unequal, hence the term is $0$. So $\mathrm{Alt}(D)_{ijkl}=0$.
- **Two indices equal, the live case $k=i$, $j\ne l$.** $D_{ijil}=0$ ($\{i,j\}\ne\{i,l\}$), $D_{iilj}=0$ (antisymmetry in the first pair), $D_{ilji}=0$ ($\{i,l\}\ne\{j,i\}$). Sum $0$.
- **$k=i$, $l=j$.** $\mathrm{Alt}(D)_{ijij}=\tfrac13(D_{ijij}+D_{iijj}+D_{ijji})=\tfrac13(d_{ij}+0-d_{ij})=0$.

So $\mathrm{Alt}(D)=0$ for every coordinate-diagonal $D$, and C5 is confirmed. **The entry contains none of this**; it writes "Therefore". The computation is three lines and is consistent with the record's own $\mathrm{Alt}(W^*_-)=0$, which [Lemma L145](../findings/second-order.md) justifies differently, by exhibiting $W^*_-=\lvert\lambda_-\rvert(\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2})$ as a sum of three Bianchi tensors. **The two justifications agree, and the diagonal one is the more general**: it needs no decomposition into named curvature operators.

## 7. Pre-registered question 1, and the edge of every range

### 7.1 One copy or both

**One.** "For $H$ in $S^2_0(\mathbb R^m)$" names a single summand, and the import it leans on ([Lemma L146](../findings/second-order.md)) says in its own capitals that it "**PRICES ONE COPY**". [Lemma L27](../findings/nondegeneracy.md) puts two distinct copies at $p=q=m$, and [Lemma L149](../findings/second-order.md) records the correction that reading them as one was "*wrong by a factor $n$ on a subspace of dimension $\Theta(n^2)$*".

**The extension is true.** For $H=H_h+H_k$ with $h\in S^2_0(V_1)$ and $k\in S^2_0(V_2)$: diagonalise $h$ inside $V_1$ and $k$ inside $V_2$ by two independent rotations, whose product lies in $O(m)\times O(m)$ and fixes $W^*$. In that one frame both images are diagonal, the cross planes carrying $\alpha(h_a+k_b)$, which is [Lemma L149](../findings/second-order.md)'s own "third, cross-plane branch", so $W^*+t(H_h+H_k)$ is diagonal and §6 applies. **The extension is nowhere on file, in L148 or anywhere else.** It is one sentence, and it is load-bearing: see §7.4.

**One half of the extension is free, and it matters which half.** $A'(0)=D(\mathrm{Alt}\,W_-)_{W^*}[\cdot]$ is *linear* in $H$, so $A'(0)[H_h+H_k]=A'(0)[H_h]+A'(0)[H_k]=0$ follows from the one-copy statement applied twice. **So [Lemma L149](../findings/second-order.md)'s "$A'(0)$ … vanishes on the margin subspace, hence $u\le w$" is safe under the written statement.** $A''$ is *not* linear in $H$, so the same trick does not deliver $a=0$ on a joint direction. The two uses are not in the same position, and the record treats them as if they were.

### 7.2 The smallest admissible dimension

- **$m=2$ ($n=4$): true and empty.** $\alpha=0$ and $h_1+h_2=0$ for traceless $h$, so every eigenvalue in §4's list is $0$: the Weyl image of the whole summand is $\{0\}$. The lemma holds vacuously.
- **$m=3$ ($n=6$): the vanishing holds, the title does not.** §4's embedding is nonzero ($\alpha=\tfrac14$), so the argument runs and $\mathrm{Alt}(W(t)_-)=0$. But this is [Lemma L27](../findings/nondegeneracy.md)'s excluded $(3,3)$, where $W^*$ is degenerate; and the margin is not here, see 7.3.
- **$m=4$:** the margin ties between this summand and $\Lambda^2\otimes\Lambda^2$; the vanishing is unaffected.

### 7.3 Where "the margin summand" is actually the margin summand

From [Lemma L26](../findings/nondegeneracy.md)'s $\tfrac12-\mu=\tfrac{(p-2)(q-2)-1}{2(p-1)(q-1)}$ at $p=q=m$:

$$\mu=\tfrac12-\tfrac{(m-2)^2-1}{2(m-1)^2}=\tfrac{(m-1)^2-(m-2)^2+1}{2(m-1)^2}=\tfrac{2m-2}{2(m-1)^2}=\frac1{m-1},\qquad \lambda_m-\mu=\frac{m-2}{2(m-1)}-\frac{2}{2(m-1)}=\frac{m-4}{2(m-1)}.$$

The margin is $3\theta_0(\tfrac12-\lambda)$ per summand, so the **smallest** margin sits where $\lambda$ is largest below $\tfrac12$: on the $S^2_0$ copies exactly when $\lambda_m\ge\mu$, i.e. **$m\ge5$**, with a tie at $m=4$ and a strict failure at $m=3$, where $\lambda_3=\tfrac14<\mu=\tfrac12$ and the margin sits on $\Lambda^2\otimes\Lambda^2$ instead. This reproduces [Lemma L146](../findings/second-order.md)'s $m\ge5$ exactly. **So L148's title is false at $m=3$ and $m=4$**, and the statement carries no hypothesis excluding them. The vanishing itself is indifferent; the *name* of the summand is not, and every downstream citation cites it by that name.

### 7.4 $\ker W\ne0$, and the named witness $W_{\mathbb{CP}^2}$

**What L148 asserts at $W_{\mathbb{CP}^2}$: nothing.** Its base point is $W^*=S^m\times S^m$, where $\ker W^*=0$ (the spectrum is two-valued, $\lambda_\pm$, [second-order.md:897](../findings/second-order.md)). $W_{\mathbb{CP}^2}$ is a different point and the lemma is silent there.

**Two things follow that are worth having.** First, unlike [Lemma L147](../findings/second-order.md) and [Lemma L149](../findings/second-order.md), whose $g_n$, $\rho$, $M$ and branches $2$–$3$ have no definition at a degenerate point, **L148's mechanism does not break at a kernel**: §5 uses no analyticity. So the mechanism, not the lemma, transports to a degenerate base point at which a common eigenframe exists. Second, **the hypothesis is not vacuous, and $W_{\mathbb{CP}^2}$ is the witness that it is not.** By [conventions.md:95](../findings/conventions.md), $\mathrm{Alt}(u_-)=a\star$ there with $a=\tfrac1{3\sqrt6}$ and $\lVert\star\rVert^2=6$, so

$$\delta^2(W_{\mathbb{CP}^2})=a^2\lVert\star\rVert^2=\frac{6}{54}=\frac19\ne0,$$

matching [problem.md](../findings/problem.md)'s "*whose defect is exactly $1/9$ in every ambient dimension*". By the contrapositive of §6, **$W_{\mathbb{CP}^2}$ is diagonal on the coordinate $2$-planes of no orthonormal frame whatever.** The converse direction stays open and the record already knows it: [problem.md:183](../findings/problem.md) records five explicit non-diagonal critical points with $\delta=0$, so $\{\delta=0\}$ is strictly larger than the diagonal locus. **L148 runs in the safe direction and claims nothing in the other.**

### 7.5 Odd $n$

$W^*=S^m\times S^m$ exists only at $n=2m$. At odd $n$ there is no balanced product, and the record notes separately that $\theta_0(n)$ is the sphere-product value "*at even $n$ only*" ([problem.md:347](../findings/problem.md)). **L148 is vacuous at odd $n$**, and the statement does not say so.

## 8. The clause that fails: "both defect branches are absent there"

**Locate it.** [findings/second-order.md:1187](../findings/second-order.md), the final clause of the lemma.

**Exhibit the failure concretely.** The chain has three branches ([second-order.md:1208](../findings/second-order.md)):

$$r(H)\gtrsim\min\left(\frac{c_p+u^2}{S+au},\ \frac{\sqrt{c_p+w^2}}{a_0n^{1/2}+nw},\ \frac{\rho(H)}2\right).$$

At a direction in this summand, $u=0$ and $a=\lVert A''\rVert=0$, so **branch $2$ is $\sqrt{c_p}/0$, unbounded, absent, as claimed. But branch $1$ evaluates to $c_p/S$, which is not absent and is not slack**: with $S\ge P(W^*)=\theta_0$ and $c_p=3\theta_0/(n-2)$,

$$\frac{c_p}{S}\le\frac{c_p}{\theta_0}=\frac{3\theta_0}{(n-2)\theta_0}=\frac3{n-2},$$

an identity in the middle step and an inequality only through $S\ge\theta_0$. **This is precisely the evaluation that proves the whole route's $\Theta(n^{-1})$ ceiling** ([second-order.md:1175](../findings/second-order.md): "*The $\Theta(n^{-1})$ ceiling is proved, by $c_p/S\le c_p/\theta_0=3/(n-2)$ alone*"). So at the very directions where L148 says both defect branches are absent, one of them is present, binding, and doing the load-bearing work of the section.

**Argue the opposite.** Branch $1$ is called the *cubic* or *$P$-side* branch and branch $2$ the *quartic* or *defect-tail* branch; on a reading where "the two defect branches" means the two places the **defect** enters (the $u$ and $au$ terms of branch $1$, and branch $2$ entire), the clause is true: $u=0$ kills the defect's contribution to branch $1$ and $a=0$ kills branch $2$. Under that reading the sentence says "the defect contributes to neither branch here", which is correct.

**Disposition: the candidate stands, as an overstatement rather than an error of fact.** It survives all three steps, and the record itself reads it in the stronger and wrong sense, [Lemma L158](../findings/second-order.md) twice calls $w=0$ "*the one direction [L148] empties*", once while computing a branch-$2$ prefactor there. The repair is to say what is absent: **the defect's contribution, not branch $1$.**

## 9. The gap between what is proven and what is used

### 9.1 Use (a), setting $a=0$ in $(c_p+u^2)/(S+au)$

Cited at [second-order.md:1212](../findings/second-order.md) inside Lemma L149's own statement: "*the first is minimised at $w=0$, right on the summand where it is applied, since [L148] makes $a=0$ on both $S^2_0$ copies and $f$'s minimum is interior only for $a>0$*", and again in [ROUND_L147](ROUND_L147.md)'s withdrawal of ROUND_L149's F12.

**The half that holds.** $f(u)=(c_p+u^2)/(S+au)$ has $f'(u)=\big[2u(S+au)-a(c_p+u^2)\big]/(S+au)^2$, so $f'(0)=-ac_p/S^2$. At $a=0$ this is $0$, $f(u)=(c_p+u^2)/S$ is increasing on $u\ge0$, and the minimum is at $u=0$ with value $c_p/S$. **Exact, and L148 does deliver $a=0$, on the copy it names.**

**The half that does not hold, and this is the finding.** "Branch $1$ is minimised at $w=0$" is a statement about the infimum over the whole feasible region, which the chain relaxes to $\{(u,w):0\le u\le w\le1\}$ because $u\le w$ is the only relation on file. L148 pins $u=a=0$ **only on the slice $w=0$**. On $w>0$ the direction leaves the summand, $a>0$ is reinstated, $f'(0)<0$, and the infimum moves to the interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$. **[Lemma L158](../findings/second-order.md) says exactly this, in the same file**: "*Branch 1 is not $(c_p+w^2)/S$: the chain's own form is $f(u)=(c_p+u^2)/(S+au)$ with $f'(0)<0$, so its infimum is strictly below $\kappa/(nS)$ and does not sit at $u=0$*". So the written statement supports the local evaluation and **not** the minimisation claim built on it. The inference conflates "the $w=0$ slice has its minimum at $u=0$" with "the infimum over all $w$ sits at $w=0$".

**And the two-copy problem bites here specifically.** $w$ is defined as the weight outside **both** copies ([second-order.md:1199](../findings/second-order.md)), so the set $\{w=0\}$ *is* the joint two-copy eigenspace. Since $a$ is second-order in $H$, §7.1's linearity shortcut is unavailable, and the written one-copy statement does not reach a general $w=0$ direction. **The claim "L148 makes $a=0$ on both $S^2_0$ copies" is a claim L148 does not make.** It is true; it is one sentence away; and that sentence is not on file.

### 9.2 Use (b), the defect branch unbounded at $w=0$

Cited at [second-order.md:1233](../findings/second-order.md): "*$\Omega$, not $\Theta$ … At $w=0$ the defect vanishes identically, so the branch is unbounded there rather than $\Theta(n^{-1})$*".

**Supported in substance.** With $A\equiv0$ along the segment, every derivative along it vanishes, so the true $\lVert A''\rVert=0$ and the true branch $2$ is $+\infty$. Note the chain's *written* branch $2$ has denominator $a_0n^{1/2}+nw$, an **upper** bound on $\lVert A''\rVert$, so the chain's own branch $2$ reads $\sqrt{c_p}/(a_0n^{1/2})=\Theta(n^{-1})$ at $w=0$: finite. **There is no contradiction (a lower bound on $r$ built from an upper bound on $\lVert A''\rVert$ is merely slack here) but the two statements are about different objects and the record does not distinguish them.** The consequence drawn, that the ceiling is $\Omega$ and not $\Theta$ because attainment cannot be read off branch $2$, is correct; and the ceiling itself survives through branch $1$ (§8).

**Subject to the same scope defect.** $\{w=0\}$ is again the joint eigenspace, so this citation too needs both copies.

## 10. What would falsify the statement, and what I did to look for it

**The falsifier.** A direction $H$ in the Weyl image of $S^2_0(\mathbb R^m)$ (one copy or the joint two), together with a real $t$ at which $\mathrm{Alt}\big((W^*+tH)_-\big)\ne0$. Equivalently, a member of that summand admitting no orthonormal frame diagonalising it simultaneously with $W^*$.

**Where I looked.**

1. **At the realisation of the summand.** If the summand were some object other than the Weyl image of $h\owedge g_q$, the diagonality import would collapse. It is not: §4 re-derives the embedding by hand from the record's own projector, and multiplicity-freeness of [Lemma L27](../findings/nondegeneracy.md)'s decomposition makes the equivariant embedding unique up to scale, so the realisation is forced.
2. **At the non-diagonal members of the summand**, which is where a quantifier failure would live. §3's $h_{12}=1$ witness does break the literal wording and does **not** break the conclusion, the obstruction being removable by an $O(m)\times\{1\}$ rotation that fixes $W^*$.
3. **At the joint two-copy directions**, the case both downstream citations actually need. The two blocks are orthogonal, so the two diagonalising rotations are independent and their product still fixes $W^*$; no falsifier there either, and the cross-plane eigenvalue $\alpha(h_a+k_b)$ is the record's own.
4. **Past the eigenvalue crossings**, where $W\mapsto W_-$ loses differentiability and every analytic argument in the neighbouring lemmas fails. §5's transfer is entrywise and algebraic, so nothing happens at a crossing.
5. **Under the other sign convention** for $W_-$, the collision the record says refuted four lemmas in one day. Inert here.
6. **At the one point in the record with a nonzero defect and a kernel**, $W_{\mathbb{CP}^2}$: its $\delta^2=\tfrac19$ is exactly consistent with §6 read contrapositively, and it is a different base point, so it falsifies nothing here.

**No falsifier of the conclusion exists, and I state that as a conclusion about the conclusion only.** The premise as written is falsified in §3, and the scope as written falls short of both uses in §9, which is what the verdict records.

**Verdict: `GAP`.** The vanishing $\mathrm{Alt}(W(t)_-)=0$ is correct, is correct for every real $t$ with no analyticity, and is correct for every direction of the named summand once the frame is chosen per direction. What is missing is written down and small: the frame sentence (§3), the four omitted hypotheses (§1), the two-copy sentence (§7.1) that both citations consume, and the correction of "both defect branches are absent" to the defect's contribution to them (§8). What is *not* small is §9.1: the minimisation claim that [Lemma L149](../findings/second-order.md) attributes to L148 does not follow from it, and [Lemma L158](../findings/second-order.md) contradicts it eighty lines later.
