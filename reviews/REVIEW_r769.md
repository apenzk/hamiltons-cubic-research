# Review r769, L176, the coordinate-diagonal locus's minimum degree

**Cold brief.** Worked from [BRIEF-g2-l176.md](BRIEF-g2-l176.md) and nothing else in [findings/](../findings/). **No numerical work was done; every value below is exact and every derivation is closed form.** Log: [agent_logs/g2-l176-r769.log](../agent_logs/g2-l176-r769.log).

One source was fetched for item 7 and filed at [references/itoh-1984-selfduality-kahler-surfaces/](../references/itoh-1984-selfduality-kahler-surfaces/) with a [notes.md](../references/itoh-1984-selfduality-kahler-surfaces/notes.md); per the launch instruction it is **left uncommitted**, this report is the only thing committed, and the parent should fold the reference folder in.

## Claim table

| # | Claim | Verdict |
| --- | --- | --- |
| A | **L176**, the statement: $W\ne0$ coordinate-diagonal $\Rightarrow$ every vertex of $G$ has degree $0$ or $\ge2$, and $\lvert E(G)\rvert\ge4$ | **CONFIRMED** |
| B | The locus is *hollow symmetric with vanishing row sums*, first Bianchi imposes nothing further, trace-freeness is exactly $\sum_b K_{ab}=0$ | **CONFIRMED** |
| C | The eigenvalue identity $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$, and $\mathop{\mathrm{rank}}=\lvert E(G)\rvert$ | **CONFIRMED** |
| D | The degree-sum counting at $\lvert E\rvert\le2$ and $\lvert E\rvert=3$ | **CONFIRMED** |
| E | The triangle system is nonsingular and its three equations are stated correctly | **CONFIRMED** |
| F | **Sharpness**, the four-cycle $K$ is a genuine element of $\mathcal W_n$, $n\ge4$, of $\Lambda^2$-rank exactly four | **CONFIRMED** |
| G | **Corollary 1**, a Weyl tensor of $\Lambda^2$-rank $\le3$ is coordinate-diagonal in no frame | **REFUTED AS STATED** |
| H | **Corollary 2**, padded $W_{\mathbb{CP}^2}$ is coordinate-diagonal in no frame | **CONFIRMED** |
| I | $\mathbb{CP}^2$: $W^-=0$ and $W^+\propto(2,-1,-1)$ with no zero eigenvalue | **CONFIRMED** (derived in closed form, source-anchored) |
| J | **The padding**, zero-extension stays in $\mathcal W_n$ and adds zero eigenvalues alone | **CONFIRMED** |
| K | **Corollary 3**, $\kappa^2(W)<2\lVert W\rVert^2$ strictly at every Weyl tensor of $\Lambda^2$-rank $\le3$ | **REFUTED AS STATED** |
| L | Corollary 3's imported equality clause, and the identity of $M$ with $W$ | **HYPOTHESIS-DEBT** |
| M | The frame is orthonormal | **HYPOTHESIS-DEBT** (used and unstated) |
| N | **Scope**, the block does not reach padded $\mathbb{HP}^2$ | **CONFIRMED** |

## Summary, one line an editor can act on

**L176 itself and its whole proof survive intact, including the four-cycle witness and the $\mathbb{CP}^2$ spectrum the brief flagged as most likely to break; the only defects are that Corollaries 1 and 3 drop L176's hypothesis $W\ne0$ and are false at $W=0$, which the zero tensor exhibits in closed form, and both are repaired by carrying $W\ne0$ across.**

## 0. Conventions, fixed once

- $\{f_a\}_{a=1}^n$ is an **orthonormal** frame of $\mathbb R^n$; indices are raised and lowered by $\delta$, so a trace is a bare $\sum_b$.
- $\mathcal W_n$: tensors $W_{abcd}$ with $W_{abcd}=-W_{bacd}=-W_{abdc}=W_{cdab}$, the first Bianchi identity $W_{abcd}+W_{acdb}+W_{adbc}=0$, and $\sum_b W_{abcb}=0$ for all $a,c$.
- $\Lambda^2$ action, fixed to the half convention: $(f_a\wedge f_b)_{cd}=\delta_{ac}\delta_{bd}-\delta_{ad}\delta_{bc}$ and $\mathcal W(\omega)_{cd}=\tfrac12 W_{cdef}\omega^{ef}$. Then $\{f_a\wedge f_b\}_{a<b}$ is a basis of $\Lambda^2\mathbb R^n$ and $\mathcal W$ is self-adjoint for the induced inner product. §3 records what the other convention changes.
- Coordinate-diagonal: $W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$. Sectional matrix $K_{ab}=W_{abab}$ (no sum), which is symmetric by pair exchange and hollow by antisymmetry.
- $G$: the graph on $\{1,\dots,n\}$ with edge $\{a,b\}$ when $K_{ab}\ne0$. Hollowness forbids loops and the edge set is a set of unordered pairs, so **$G$ is simple**, used silently in §4 and recorded here.
- Kulkarni–Nomizu, used only in §7: $(h\owedge k)_{abcd}=h_{ac}k_{bd}+h_{bd}k_{ac}-h_{ad}k_{bc}-h_{bc}k_{ad}$, so $(g\owedge g)_{abcd}=2(\delta_{ac}\delta_{bd}-\delta_{ad}\delta_{bc})$.

## Hypothesis inventory (item 1)

**Used, and stated.**

| Hypothesis | Where it does work |
| --- | --- |
| $W\ne0$ | Only at $\lvert E\rvert\ge1$, the first line of the edge count. It is the hypothesis Corollaries 1 and 3 drop; see §10 and §13. |
| $W$ coordinate-diagonal in the frame | Everywhere: it is what makes $\{f_a\wedge f_b\}$ an eigenbasis and what collapses trace-freeness onto $K$. |
| Riemann symmetries | $W_{abab}=W_{baba}$ gives $K$ symmetric; $W_{aacd}=0$ gives $K$ hollow; both feed the graph being simple. |
| Total trace-freeness | The row-sum equations, used three times: the degree-1 contradiction, the triangle system, and the verification of the witness. |

**Stated and unused: the first Bianchi identity.** §2 shows it holds identically on the coordinate-diagonal set, so as a constraint it is empty there. It does no work in L176 and cuts the locus down by nothing. This is worth saying rather than leaving silent, because it is the hypothesis one would reach for when asked whether the witness of §6 is "really" a Weyl tensor, and the answer is that it is free.

**Used and unstated: the frame is orthonormal**, verdict `HYPOTHESIS-DEBT` (item M). Two separate steps need it and the brief says only "frame":

1. The trace condition is written $\sum_b W_{abcb}=0$ with no metric. In a non-orthonormal frame the condition is $g^{bd}W_{abcd}=0$, and its restriction to a diagonal $W$ is $\sum_b g^{bb}K_{ab}+(\text{off-diagonal }g^{bd}\text{ terms})$, which is **not** the vanishing of the plain row sums. The entire locus characterisation is orthonormal-frame-specific.
2. "$W$ acts on $\Lambda^2$ as a self-adjoint operator" needs the inner product; and the $\Lambda^2$-rank is to be frame-independent, which it is, but only because the change of frame is orthogonal.

Nothing breaks (the record plainly means an orthonormal frame) but the word is missing from the statement and one sentence would close it: *"coordinate-diagonal in some **orthonormal** frame"*.

**Used and unstated, minor: $G$ is simple.** Recorded in §0; it follows from the two stated symmetries, so it is derivable rather than owed.

## 1. Claim A, L176's statement

**CONFIRMED**, with one wording flag.

The proof is correct as written; §§2–5 verify each of its four steps independently. The flag is on *"equivalently $\mathop{\mathrm{rank}}(W)\ge4$"*. Two conclusions precede it (the degree condition and $\lvert E\rvert\ge4$) and the rank statement is equivalent to the **second alone**, by §3's $\mathop{\mathrm{rank}}=\lvert E\rvert$.

It is not equivalent to the first, and not to the conjunction in a useful sense: the degree condition on its own gives only $\lvert E\rvert\ge3$, because a graph with no degree-1 vertex and at least one edge contains a cycle, and the smallest such graph is the triangle. The triangle is eliminated in §5 by the row sums, **not** by degrees. So the degree condition is a genuinely weaker intermediate step, and "equivalently" should be attached to the edge count only. Suggested reading: *"…and $\lvert E(G)\rvert\ge4$; the latter equivalently $\mathop{\mathrm{rank}}(W:\Lambda^2\to\Lambda^2)\ge4$."*

## 2. Claim B, the locus characterisation (item 2)

**CONFIRMED**, in both halves, and this is the load-bearing section: it is what makes item 6 come out clean.

**First Bianchi is identically satisfied on the coordinate-diagonal set.** Let $W$ be coordinate-diagonal and take any $a,b,c,d$. The cyclic sum is $S=W_{abcd}+W_{acdb}+W_{adbc}$, and a term $W_{xyzw}$ survives only when $\{x,y\}=\{z,w\}$ with $x\ne y$. Enumerate by the multiset $\{a,b,c,d\}$:

- **Four distinct.** Each term pairs $\{a,b\}$ against $\{c,d\}$, $\{a,c\}$ against $\{d,b\}$, $\{a,d\}$ against $\{b,c\}$; all three pairings are unequal as sets, so $S=0$.
- **Exactly three distinct.** Every case has one repeated index. If $b=a$: $S=W_{aacd}+W_{acda}+W_{adac}$; the first vanishes by antisymmetry, the second needs $\{a,c\}=\{d,a\}$ hence $c=d$ which is excluded here, the third needs $\{a,d\}=\{a,c\}$ hence $d=c$, excluded. If $c=a$: $S=W_{abad}+W_{aadb}+W_{adba}$; the first needs $b=d$, excluded, the second vanishes by antisymmetry, the third needs $\{a,d\}=\{b,a\}$ hence $d=b$, excluded. If $d=a$: $S=W_{abca}+W_{acab}+W_{aabc}$; first needs $b=c$, second needs $c=b$, third vanishes. Symmetrically for $c=b$, $d=b$, $d=c$. So $S=0$.
- **Two distinct.** The only pattern with a surviving term is, up to relabelling, $(a,b,c,d)=(1,2,1,2)$: $S=W_{1212}+W_{1122}+W_{1221}=K_{12}+0-K_{12}=0$. The patterns $(1,2,2,1)$, $(1,1,2,2)$, $(1,2,1,1)$ and their relabellings give $S=0$ term by term or by the same cancellation.
- **One distinct.** All terms vanish by antisymmetry.

So the Bianchi identity is free on the locus: **it imposes nothing further**, exactly as the record's characterisation implies.

**Trace-freeness is exactly $\sum_b K_{ab}=0$, with no factor and no extra term.** Compute $\sum_b W_{abcb}$ for a coordinate-diagonal $W$. A summand $W_{abcb}$ needs $\{a,b\}=\{c,b\}$ as sets with $a\ne b$ and $c\ne b$; that forces $a=c$. The summand with $b=a$ vanishes by antisymmetry in the first pair, and the summand with $b=c$ vanishes by antisymmetry in the second pair. Hence

$$\sum_b W_{abcb}=\delta_{ac}\sum_{b\ne a}W_{abab}=\delta_{ac}\sum_b K_{ab}.$$

Two consequences worth separating:

1. The **off-diagonal** traces $a\ne c$ vanish *identically* on the locus, they are not conditions at all.
2. The **diagonal** trace $a=c$ is the row sum, with coefficient exactly $1$. No factor of $2$, no $\tfrac12$, no additive remainder.

**This settles the brief's suspicion at item 6 before it arises.** The brief warns that "the row sums are one consequence of trace-freeness and the brief may be quoting a necessary condition as if it were sufficient." On the coordinate-diagonal set the row sums are necessary **and sufficient**, because the only other components of the trace are the off-diagonal ones and those vanish for free. The characterisation is an equality of sets, not an inclusion.

**External corroboration.** [references/jaeger-2016-diagonal-case/notes.md](../references/jaeger-2016-diagonal-case/notes.md) transcribes the same reduction from Jäger's 2016 Münster thesis: *"Those operators $W\in\langle W\rangle_d$ can be expressed as symmetric $n\times n$-matrices $(w_{ij})$ with $0$ on the diagonal via $W(e_i\wedge e_j)=w_{ij}e_i\wedge e_j$ … The condition that $W$ is Weyl then reduces to $\sum_i w_{ij}=0$ for all $j$."* Same locus, same absence of a factor, and the same $\Lambda^2$ normalisation as §3 below.

## 3. Claim C, the eigenvalue identity (item 3)

**CONFIRMED.** With $\omega=f_a\wedge f_b$ and the half convention of §0,

$$\mathcal W(f_a\wedge f_b)_{cd}=\tfrac12 W_{cdef}\bigl(\delta_{ae}\delta_{bf}-\delta_{af}\delta_{be}\bigr)=\tfrac12\bigl(W_{cdab}-W_{cdba}\bigr)=W_{cdab}.$$

For a coordinate-diagonal $W$ this is $K_{ab}$ when $(c,d)=(a,b)$, $-K_{ab}$ when $(c,d)=(b,a)$, and $0$ otherwise, that is, $K_{ab}(f_a\wedge f_b)_{cd}$. So $\mathcal W(f_a\wedge f_b)=K_{ab}\,f_a\wedge f_b$ **exactly**, as written.

**What the other convention does.** Dropping the $\tfrac12$, i.e. $\mathcal W(\omega)_{cd}=W_{cdef}\omega^{ef}$, gives $\mathcal W(f_a\wedge f_b)=2K_{ab}f_a\wedge f_b$. A third common convention normalises the basis to $\lVert f_a\wedge f_b\rVert=1$ and changes nothing at all here, since each $f_a\wedge f_b$ is already an eigenvector and rescaling an eigenvector does not move its eigenvalue.

**No convention can change the count.** Every convention in use differs by a nonzero global scalar on $\Lambda^2$, and $\lambda\mapsto c\lambda$ with $c\ne0$ fixes the zero set. So $\#\{(a,b): a<b,\ K_{ab}\ne0\}=\lvert E(G)\rvert$ is convention-free, and since $\{f_a\wedge f_b\}_{a<b}$ is a **basis** of $\Lambda^2\mathbb R^n$ consisting of eigenvectors, the spectrum of $\mathcal W$ *with multiplicity* is exactly $\{K_{ab}\}_{a<b}$ and

$$\mathop{\mathrm{rank}}(\mathcal W)=\lvert E(G)\rvert.$$

**The failure mode the brief asks about (a wrong identification of the operator), does not occur.** The one identification that would break the count is confusing $\mathcal W$ with the *second-kind* operator on $S^2\mathbb R^n$, or with the Ricci-type contraction; neither is used, and the proof's operator is pinned by the displayed formula $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$, which as computed above holds only for the $\Lambda^2$ action.

## 4. Claim D, the degree-sum counting (item 4)

**CONFIRMED**, both cases, and the objections the brief raises are all closed.

**Preliminaries.** $G$ is simple (§0), so the handshake identity $\sum_a \deg(a)=2\lvert E\rvert$ holds with no correction for loops (which would count twice) and no multi-edge collapse. Vertices outside the support have degree $0$ and are explicitly permitted by the statement, so their presence cannot break a count that only ever bounds the number of vertices of **positive** degree.

**Degree $1$ is impossible.** If $\deg(a)=1$ with sole neighbour $b$, then $K_{ac}=0$ for every $c\ne b$, so the row sum reads $0=\sum_c K_{ac}=K_{ab}$, contradicting $\{a,b\}\in E$. Hence every degree is $0$ or $\ge2$. (Note this uses only the row sum at the single index $a$; no global structure.)

**$\lvert E\rvert=1$.** The unique edge's two endpoints have degree $1$. Excluded.

**$\lvert E\rvert=2$.** Degree sum $4$, every positive degree is $\ge2$, so at most $\lfloor 4/2\rfloor=2$ vertices carry positive degree. A **simple** graph on $2$ vertices has at most one edge, so $\lvert E\rvert\le1$, contradicting $\lvert E\rvert=2$. Excluded. (The proof's phrasing compresses this into one clause; it is right, and the simplicity of $G$ is exactly what it leans on, with a multi-edge allowed, two parallel edges on $\{a,b\}$ would give both endpoints degree $2$ and survive. Simplicity is guaranteed by §0, so the gap is only in the writing, not the mathematics. I flag it as worth one added word: *"a simple graph on two vertices has at most one edge"*.)

Direct cross-check without the vertex bound: the two shapes with two edges are the path $a\!-\!b\!-\!c$ (endpoints $a,c$ of degree $1$) and the disjoint pair (all four vertices of degree $1$). Both excluded by the degree rule. Same answer.

**$\lvert E\rvert=3$.** Degree sum $6$; every positive degree is $\ge2$, so at most $3$ vertices carry positive degree. A simple graph with $3$ edges needs at least $3$ vertices (on $2$ vertices at most $1$ edge). So exactly $3$ vertices carry positive degree, their degrees are three positive integers, each $\ge2$, summing to $6$ (hence all equal $2$) and the unique simple $2$-regular graph on $3$ vertices is $K_3$. Correct as written.

## 5. Claim E, the triangle system (item 5)

**CONFIRMED**, statement and nonsingularity both.

Let the support be $\{a,b,c\}=K_3$. Every other entry of $K$ in these rows vanishes, so the three row sums are precisely

$$K_{ab}+K_{ac}=0,\qquad K_{ab}+K_{bc}=0,\qquad K_{ac}+K_{bc}=0,$$

which is exactly the triple the proof writes. (Row $a$ pairs $ab$ with $ac$; row $b$ pairs $ab$ with $bc$; row $c$ pairs $ac$ with $bc$. Each of the three unknowns appears in exactly two of the three equations, which is the incidence structure of the triangle. The proof has this right.)

In the unknowns $(K_{ab},K_{ac},K_{bc})$ the matrix is

$$\begin{pmatrix}1&1&0\\1&0&1\\0&1&1\end{pmatrix},\qquad \det = 1\cdot(0-1)-1\cdot(1-0)+0 = -2 \ne 0.$$

**Nonsingular**, so the only solution is $K_{ab}=K_{ac}=K_{bc}=0$, contradicting all three being edges. The proof's own elimination reaches the same place: the first two give $K_{ac}=K_{bc}=-K_{ab}$, the third then gives $-2K_{ab}=0$. Both routes agree.

*Remark, since it is the same determinant.* The $-2$ is the reason the coordinate-diagonal locus is trivial at $n=3$: for $n=3$ the entire locus is this system, so $\mathcal W_3$'s diagonal part is $\{0\}$. That is consistent with the classical $\mathcal W_3=\{0\}$ and is a free sanity check on the whole characterisation.

## 6. Claim F, the sharpness witness (item 6, the brief's flagged risk)

**CONFIRMED.** The four-cycle example is a genuine element of $\mathcal W_n$ for every $n\ge4$, with $\Lambda^2$-rank exactly four. The brief's suspicion is unfounded, and §2 says why: on the coordinate-diagonal set the row-sum condition is not merely necessary for trace-freeness, it is equivalent to it.

**The tensor, written out.** Fix $c\ne0$ and $n\ge4$. Set

$$K_{12}=K_{21}=c,\quad K_{23}=K_{32}=-c,\quad K_{34}=K_{43}=c,\quad K_{41}=K_{14}=-c,$$

all other $K_{ab}=0$ (including $K_{13}=K_{24}=0$ and every entry touching an index $>4$), and define $W$ by $W_{abab}=W_{baba}=K_{ab}$, $W_{abba}=W_{baab}=-K_{ab}$ for $a\ne b$, and $W_{abcd}=0$ whenever $\{a,b\}\ne\{c,d\}$.

**Riemann symmetries.** $W_{abcd}=-W_{bacd}$ and $W_{abcd}=-W_{abdc}$ hold by the sign rule just given; $W_{abcd}=W_{cdab}$ holds because $K$ is symmetric and the two surviving index patterns $(a,b,a,b)$ and $(a,b,b,a)$ are each fixed by pair exchange up to the recorded sign. ✔

**First Bianchi.** Free, by §2, the identity holds for *every* coordinate-diagonal tensor, whatever $K$ is. ✔

**Totally trace-free.** By §2 this is exactly the four row sums, at every index:

$$\text{row }1:\ K_{12}+K_{13}+K_{14}=c+0-c=0,$$
$$\text{row }2:\ K_{21}+K_{23}+K_{24}=c-c+0=0,$$
$$\text{row }3:\ K_{32}+K_{34}=-c+c=0,$$
$$\text{row }4:\ K_{43}+K_{41}=c-c=0,$$

and for $a>4$ the row is identically zero. The off-diagonal traces vanish identically. ✔ So $W\in\mathcal W_n$.

**Rank exactly four.** By §3 the spectrum with multiplicity is $\{K_{ab}\}_{a<b}$: four entries equal to $\pm c\ne0$ and $\binom n2-4$ zeros. Rank $=4$. ✔ And $W\ne0$ since $c\ne0$. ✔

**An independent check at $n=4$, which is where it would break if anywhere.** Solve the locus equations at $n=4$ in closed form. Subtracting row $1$ from row $2$ gives $K_{13}+K_{14}=K_{23}+K_{24}$; subtracting row $4$ from row $3$ gives $K_{13}+K_{23}=K_{14}+K_{24}$. Adding these two gives $K_{13}=K_{24}$, subtracting gives $K_{14}=K_{23}$, and the same manipulation on the other pairing gives $K_{12}=K_{34}$. Row $1$ then reads $K_{12}+K_{13}+K_{14}=0$. So

$$\mathcal W_4\cap\{\text{diagonal in this frame}\}=\{(p,q,r):\ K_{12}=K_{34}=p,\ K_{13}=K_{24}=q,\ K_{14}=K_{23}=r,\ p+q+r=0\},$$

a **two-dimensional** family. The witness is $(p,q,r)=(c,0,-c)$, which lies in it. ✔ Two further facts fall out:

- At $n=4$ the rank of a nonzero element of the locus is $4$ or $6$ and **never** $5$: if two of $p,q,r$ vanish the third does too, so at most one vanishes, and the ranks are $2\cdot3=6$ or $2\cdot2=4$. So L176's bound is attained on a full one-parameter subfamily, not by accident.
- Because opposite pairs are forced equal, every diagonal $W\in\mathcal W_4$ preserves $\Lambda^\pm$, with $W^\pm$ spectra $(p,q,r)$, trace-free on each side, as it must be. For the witness, $W^+=W^-=\mathop{\mathrm{diag}}(c,0,-c)$, giving $2+2=4$ nonzero eigenvalues. This is an entirely independent route to the rank and it agrees.

**What was checked and what was not.** Everything above is a hand identity in the symbol $c$; no numerical work of any kind was performed, and none was needed.

## 7. Claim I, $\mathbb{CP}^2$'s spectrum (item 7, the brief's second flagged risk)

**CONFIRMED**: $W^-=0$, $W^+$ has spectrum proportional to $(2,-1,-1)$, no zero eigenvalue, $\Lambda^2$-rank exactly $3$. Read at sources rather than recalled, and derived in closed form rather than quoted.

### 7a. The printed statements

Fetched and filed at [references/itoh-1984-selfduality-kahler-surfaces/](../references/itoh-1984-selfduality-kahler-surfaces/), Mitsuhiro Itoh, *Self-duality of Kähler surfaces*, Compositio Mathematica **51** (1984) 265–273, [numdam](http://www.numdam.org/item?id=CM_1984__51_2_265_0), with a [notes.md](../references/itoh-1984-selfduality-kahler-surfaces/notes.md). Two sentences bear:

> "It is shown by a straight computation that a Kâhler surface of constant holomorphic curvature is self-dual with respect to the canonical orientation." (p. 266)

> "THEOREM C [2,3,5]: Let $(M,g)$ be a compact, self-dual Kâhler surface. Then $(M,g)$ is either a space of constant holomorphic curvature ($P^2(\mathbb C)$, …)" (pp. 266–267)

giving $W^-=0$ for $\mathbb{CP}^2$ with the Fubini–Study metric in the complex orientation, and

> "THEOREM 2: Let $(M,g)$ be a Kâhler surface. Then it is anti-self-dual if and only if its scalar curvature vanishes everywhere." (p. 267)

giving $W^+\ne0$, since $s>0$. **Itoh stops short of what Corollary 2 needs**: $W^+\ne0$ leaves open whether one of its three eigenvalues vanishes, which would drop the rank to $2$ and put $\mathbb{CP}^2$ back inside Corollary 1's reach for the wrong reason. So the eigenvalues are derived next.

### 7b. The eigenvalues, derived in closed form

The source is already on file: [references/bourguignon-karcher-1978-pinching/notes.md](../references/bourguignon-karcher-1978-pinching/notes.md) §5.1 records the Fubini–Study curvature tensor, at the normalisation with sectional curvature ranging over $[1,4]$:

$$R(a,b,c,d) = (a,c)(b,d) - (a,d)(b,c) + (Ja,c)(Jb,d) - (Ja,d)(Jb,c) + 2(Ja,b)(Jc,d).$$

Take $n=2$, real dimension $4$, and the orthonormal frame $e_1,\ e_2=Je_1,\ e_3,\ e_4=Je_3$, so that the only nonzero $J_{ab}=(Je_a,e_b)$ are $J_{12}=J_{34}=1=-J_{21}=-J_{43}$.

**Sectional curvatures.** $R(a,b,a,b)=\lvert a\rvert^2\lvert b\rvert^2-(a,b)^2+3(Ja,b)^2$, so on the frame $K^{\mathrm{sec}}_{ab}=1+3J_{ab}^2$:

$$K^{\mathrm{sec}}_{12}=K^{\mathrm{sec}}_{34}=4,\qquad K^{\mathrm{sec}}_{13}=K^{\mathrm{sec}}_{14}=K^{\mathrm{sec}}_{23}=K^{\mathrm{sec}}_{24}=1,$$

which is the $[1,4]$ range the source names, and $s=2\sum_{a<b}K^{\mathrm{sec}}_{ab}=2(4+4+1+1+1+1)=24$.

**Off-diagonal components.** With three distinct indices every term needs a pairing that does not occur, e.g. $R_{1213}=0+0+J_{11}J_{23}-J_{13}J_{21}+2J_{12}J_{13}=0$; likewise all others. With four distinct indices:

$$R_{1234}=2J_{12}J_{34}=2,\qquad R_{1324}=J_{12}J_{34}=1,\qquad R_{1423}=J_{12}J_{43}=-1,$$

and the first Bianchi identity checks: $R_{1234}+R_{1342}+R_{1423}=2-1-1=0$. ✔

**The Weyl tensor.** $\mathbb{CP}^2$ is Einstein, so $W=R-\tfrac{s}{2n(n-1)}\,g\owedge g$ with $n=4$ and $\tfrac{s}{2\cdot4\cdot3}=\tfrac{24}{24}=1$; and $(g\owedge g)_{abab}=2$, $(g\owedge g)_{abcd}=0$ for $\{a,b\}\cap\{c,d\}=\emptyset$. Hence

$$W_{1212}=W_{3434}=4-2=2,\qquad W_{1313}=W_{1414}=W_{2323}=W_{2424}=1-2=-1,$$
$$W_{1234}=2,\qquad W_{1324}=1,\qquad W_{1423}=-1,$$

with the three-distinct-index components zero. Trace-free check, row $1$: $2-1-1=0$ ✔; row $3$: $-1-1+2=0$ ✔.

**The operator.** With §0's convention $\mathcal W(e_a\wedge e_b)=\sum_{c<d}W_{cdab}\,e_c\wedge e_d$. Write $e_{ab}=e_a\wedge e_b$:

$$\mathcal W(e_{12})=2e_{12}+2e_{34},\qquad \mathcal W(e_{34})=2e_{12}+2e_{34},$$
$$\mathcal W(e_{13})=-e_{13}+e_{24},\qquad \mathcal W(e_{24})=e_{13}-e_{24},$$
$$\mathcal W(e_{14})=-e_{14}-e_{23},\qquad \mathcal W(e_{23})=-e_{14}-e_{23}.$$

On the self-dual basis $\omega^+_1=e_{12}+e_{34},\ \omega^+_2=e_{13}-e_{24},\ \omega^+_3=e_{14}+e_{23}$:

$$\mathcal W\omega^+_1=4\,\omega^+_1,\qquad \mathcal W\omega^+_2=-2\,\omega^+_2,\qquad \mathcal W\omega^+_3=-2\,\omega^+_3.$$

On the anti-self-dual basis $\omega^-_1=e_{12}-e_{34},\ \omega^-_2=e_{13}+e_{24},\ \omega^-_3=e_{14}-e_{23}$:

$$\mathcal W\omega^-_1=0,\qquad \mathcal W\omega^-_2=0,\qquad \mathcal W\omega^-_3=0.$$

**So $W^-=0$ and $W^+$ has spectrum $(4,-2,-2)$, proportional to $(2,-1,-1)$, trace-free as required, with no zero eigenvalue. $\mathop{\mathrm{rank}}(W:\Lambda^2\mathbb R^4\to\Lambda^2\mathbb R^4)=3$ exactly.** ✔

**Cross-check 1, against the same source's own table.** [bourguignon-karcher-1978-pinching/notes.md](../references/bourguignon-karcher-1978-pinching/notes.md) §5.2 lists the spectrum of $\hat R_{\mathbb{CP}^n}$ at this normalisation: eigenvalue $4n+4$ on $\mathbb R\cdot J$ (dimension $1$), $0$ on $\{u\wedge v-Ju\wedge Jv\}$ (dimension $n(n-1)$), $4$ on $\{u\wedge v+Ju\wedge Jv\}$ (dimension $n(n-1)$), $4$ on $\{u\wedge Ju-v\wedge Jv\}$ (dimension $n-1$). At $n=2$ that is $\{12,0,0,4,4,4\}$ on a $1+2+2+1=6$-dimensional space. Their $\hat R$ is twice the operator of §0, their top eigenvalue is $12$ where the computation above gives $\mathcal R(e_{12}+e_{34})=6(e_{12}+e_{34})$, so halving gives $\{6,2,2,2,0,0\}$. The direct computation gives $\mathcal R$ eigenvalues $6$ on $\omega^+_1$, $2$ on $\omega^-_1$, $2$ on $\omega^-_2$, $2$ on $\omega^-_3$, $0$ on $\omega^+_2$, $0$ on $\omega^+_3$, the same multiset. Subtracting $\tfrac{s}{2n(n-1)}\cdot 2=2$ from each recovers $\{4,0,0,0,-2,-2\}$, i.e. $W^+=(4,-2,-2)$ and $W^-=(0,0,0)$. **Exact agreement.**

**Cross-check 2, against the Kähler formula.** For a Kähler surface $W^+$ has eigenvalues $(s/6,-s/12,-s/12)$; at $s=24$ that is $(4,-2,-2)$. Agreement, but note this is the *recalled* statement and it is listed here as a check on the derivation, not as its support.

**Orientation, and why it does not matter.** Which of $W^\pm$ vanishes flips with the orientation (Itoh, p. 265: *"a self-dual 4-manifold is anti-self-dual if the orientation is reversed"*). Corollary 2 depends only on $\mathop{\mathrm{rank}}(W)=3$, which is orientation-independent. So the corollary survives either convention, and the sentence "$\mathbb{CP}^2$ is self-dual Einstein so $W^-=0$" is a convention-dependent way of saying an orientation-free thing. Worth one clause in the record; it is not an error.

## 8. Claim J, the padding (item 8)

**CONFIRMED**, in both halves.

Let $V=\mathop{\mathrm{span}}(f_5,\dots,f_n)$ and define $\widetilde W_{abcd}=W_{abcd}$ when $a,b,c,d\le4$ and $0$ if any index exceeds $4$.

**It stays a Weyl tensor.** Riemann symmetries: each permutes the index set, so a component with an index $>4$ maps to another such, and both are $0$; components entirely in $\{1,\dots,4\}$ inherit the symmetries. ✔ First Bianchi: the three terms $\widetilde W_{abcd}+\widetilde W_{acdb}+\widetilde W_{adbc}$ share the *same* four indices, so either all four are $\le4$ (and the identity is the original one) or every term contains the offending index and all three vanish. ✔ Trace: $\sum_{b=1}^n \widetilde W_{abcb}$, summands with $b>4$ vanish, so the sum equals $\sum_{b=1}^4 W_{abcb}=0$ when $a,c\le4$, and is identically $0$ when $a>4$ or $c>4$. ✔

**It adds zero eigenvalues alone, with no mixing.** Split $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^4\oplus(\mathbb R^4\wedge V)\oplus\Lambda^2V$. By §3, $\widetilde{\mathcal W}(f_a\wedge f_b)_{cd}=\widetilde W_{cdab}$, which is nonzero only when **all four** of $a,b,c,d$ are $\le4$. Hence:

- on $\Lambda^2\mathbb R^4$, $\widetilde{\mathcal W}$ restricts to $\mathcal W$ and lands in $\Lambda^2\mathbb R^4$;
- on $\mathbb R^4\wedge V$ and on $\Lambda^2 V$, $\widetilde{\mathcal W}$ is identically zero;
- nothing maps *into* $(\mathbb R^4\wedge V)\oplus\Lambda^2V$, since a nonzero image coefficient $\widetilde W_{cdab}$ forces $c,d\le4$.

So $\widetilde{\mathcal W}=\mathcal W\oplus 0$ as a block-diagonal operator, with **no off-diagonal block**. The spectrum is the old spectrum together with $\binom n2-6$ additional zeros, and $\mathop{\mathrm{rank}}\widetilde W=\mathop{\mathrm{rank}}W=3$. ✔

**Corollary 2 therefore holds** (claim H, **CONFIRMED**), *once Corollary 1 is repaired as in §10*: padded $W_{\mathbb{CP}^2}$ is nonzero and has $\Lambda^2$-rank $3\le3$, so by the repaired Corollary 1 it is coordinate-diagonal in no orthonormal frame of $\mathbb R^n$, $n\ge4$. The defect in Corollary 1 does not touch this instance, because the hypothesis it drops is one $\mathbb{CP}^2$ satisfies.

*Consistency check, free.* §7's frame is one in which $W_{\mathbb{CP}^2}$ is manifestly **not** diagonal ($W_{1234}=2\ne0$) as it must not be. And §6's $n=4$ classification says every diagonal element of $\mathcal W_4$ has $W^+$ and $W^-$ spectra **equal** to each other; $\mathbb{CP}^2$ has $(4,-2,-2)$ against $(0,0,0)$, so it is excluded by that route too, independently of the rank count. Two routes, same conclusion.

## 9. Claim on the kernel (item 9)

**No step assumes $\ker W=0$**, and I looked at each one specifically because the brief names this as the record's recurring obstruction.

| Step | Kernel dependence |
| --- | --- |
| $\mathcal W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$ | None. It is an identity for each basis vector; the ones with $K_{ab}=0$ are kernel vectors and the identity is what *exhibits* them. |
| $\mathop{\mathrm{rank}}=\lvert E\rvert$ | None, it is a statement *about* the kernel, of the right form: $\dim\ker\mathcal W=\binom n2-\lvert E\rvert$, computed rather than assumed. |
| Degree $0$ or $\ge2$ | Degree $0$ is explicitly allowed. Vertices outside the support are exactly kernel directions and the statement accommodates them by name. |
| $\lvert E\rvert\le2$, $\lvert E\rvert=3$ counting | Bounds the number of **positive-degree** vertices; unbounded numbers of degree-$0$ vertices are harmless. Only $n\ge$ (support size) is used, never $n=$ support size. |
| Triangle system | Uses row sums at the three support indices; rows at kernel indices are $0=0$ and are not used. |
| Padding (§8) | The padded tensor is $\binom n2-3$ dimensional kernel and the argument is explicitly a direct-sum decomposition, so it is *about* the kernel and assumes nothing. |

**The one place a hidden assumption could have lived** is the phrase "the eigenvalues are the $K_{ab}$", if $\{f_a\wedge f_b\}$ were merely a spanning set rather than a basis, repeated eigenvalues could cancel and the rank could drop. It is a basis, because $\{f_a\}$ is a frame. ✔

## 10. Claim G, Corollary 1 (the defect)

**REFUTED AS STATED.**

> *"Corollary 1. A Weyl tensor of $\Lambda^2$-rank $\le3$ is coordinate-diagonal in no frame."*

**The falsifier, exhibited in closed form: $W=0$.**

- $W=0\in\mathcal W_n$, every symmetry, the Bianchi identity and every trace hold trivially.
- $\mathop{\mathrm{rank}}(0:\Lambda^2\to\Lambda^2)=0\le3$, so it satisfies Corollary 1's hypothesis.
- $W=0$ **is** coordinate-diagonal, in *every* frame: the defining condition "$W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$" is satisfied vacuously, and its sectional matrix $K=0$ is hollow, symmetric and has vanishing row sums, so it lies in the locus of §2.

So the conclusion "coordinate-diagonal in no frame" is false for $W=0$, while the hypothesis holds. **Corollary 1 as written is false.**

**Where it comes from.** L176 carries the hypothesis $W\ne0$ and uses it, §4, the step $\lvert E\rvert\ge1$. The contrapositive of L176 is therefore *"a **nonzero** Weyl tensor of $\Lambda^2$-rank $\le3$ is coordinate-diagonal in no frame"*, and Corollary 1 drops the word.

**The repair, one word.** *"A **nonzero** Weyl tensor of $\Lambda^2$-rank $\le3$ is coordinate-diagonal in no orthonormal frame."* Equivalently *"of $\Lambda^2$-rank $r$ with $1\le r\le3$"*. With that word the corollary is the exact contrapositive of L176 and inherits its proof verbatim.

**Blast radius: small but real.** Corollary 2 is untouched (§8: padded $W_{\mathbb{CP}^2}\ne0$). Corollary 3 inherits the same defect and needs the same word (§11). Any downstream use of Corollary 1 that reasons *"$W$ has small rank, hence $W$ is not diagonal, hence …"* without separately knowing $W\ne0$ is unsound at the degenerate point, and the point $W=0$ is one a limiting or compactness argument can actually reach, which is why this is worth fixing rather than waving through as pedantry.

## 11. Claim K and L, Corollary 3 (item 10)

**Claim K: REFUTED AS STATED. Claim L: HYPOTHESIS-DEBT.**

> *"Corollary 3. $\kappa^2(W)<2\lVert W\rVert^2$ strictly at every Weyl tensor of $\Lambda^2$-rank $\le3$, since $\kappa^2\le2\lVert M\rVert_F^2$ holds with equality **exactly** at coordinate-diagonal."*

**The direction actually needed (item 10).** The inference is

$$\text{rank}\le3 \;\xRightarrow{\ \text{Cor.\,1}\ }\; \text{not coordinate-diagonal} \;\Longrightarrow\; \text{equality fails} \;\Longrightarrow\; \text{strict}.$$

The middle implication is the **contrapositive of "equality $\Rightarrow$ coordinate-diagonal"**. So the direction used is:

- **needed:** equality in $\kappa^2\le2\lVert M\rVert_F^2$ $\Longrightarrow$ $W$ is coordinate-diagonal (in some frame);
- **not needed:** coordinate-diagonal $\Longrightarrow$ equality.

The block quotes the clause as an "iff" and consumes only the first half. That is safe (a stronger import than required is not an error) but it should be recorded, because if the imported result ever weakens to just the *easy* direction (diagonal $\Rightarrow$ equality, which is the direction one proves by computing both sides on the locus), Corollary 3 collapses entirely while looking unchanged.

**Why REFUTED AS STATED.** Corollary 3 inherits §10's defect through Corollary 1: at $W=0$ the rank is $0\le3$, but $W=0$ *is* coordinate-diagonal, so the chain's first implication fails. And the conclusion itself fails there for any $\kappa$ vanishing at $0$, which is every candidate the displayed inequality $\kappa^2\le2\lVert M\rVert_F^2$ admits, since a quantity bounded by a norm-square that vanishes at $0$ must vanish at $0$, giving $0<0$. **Same one-word repair:** *"at every **nonzero** Weyl tensor of $\Lambda^2$-rank $\le3$"*.

**HYPOTHESIS-DEBT, claim L, two distinct debts.**

1. **The equality clause has no argument on file.** The cold brief quotes *"$\kappa^2\le2\lVert M\rVert_F^2$ holds with equality **exactly** at coordinate-diagonal"* as an import with no proof and no reference. Per the brief's own instruction I do not supply one. **What would have to be proved:** that for every $W$ in the relevant class, $\kappa^2(W)=2\lVert M(W)\rVert_F^2$ implies $W$ is coordinate-diagonal in some orthonormal frame. Only that direction, and only for the class Corollary 3 quantifies over.
2. **The objects are not identified.** The inequality is stated with $\lVert M\rVert_F$ and the conclusion with $\lVert W\rVert$. The brief never defines $M$, never defines $\kappa$, and never asserts $\lVert M\rVert_F=\lVert W\rVert$. If $M$ is a matrix attached to $W$ (the sectional matrix $K$ is the obvious candidate, and on the locus $\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$ is *not* equal to the natural $\lVert W\rVert^2$ under most normalisations), then the step from the inequality to the conclusion carries an unwritten identification. **What would have to be proved or stated:** the definitions of $\kappa$ and $M$, and the identity $\lVert M\rVert_F=\lVert W\rVert$ under the record's normalisation, or the corollary restated in one symbol throughout.
3. **Frame-invariance, a third silent step.** "Coordinate-diagonal in **some** frame" is what Corollary 1 negates, so the equality clause must also be read frame-existentially, which in turn requires $\kappa$ and $\lVert\cdot\rVert$ to be frame-invariant (or the clause to hold at the optimising frame). The brief says nothing either way. This is small, but it is the difference between a valid and an invalid contrapositive.

## 12. The boundary (item 11)

| Regime | Status |
| --- | --- |
| $n\le2$ | $\dim\Lambda^2\mathbb R^n\le1$ and $\mathcal W_n=\{0\}$. L176 is vacuous, no $W\ne0$ exists. |
| $n=3$ | $\mathcal W_3=\{0\}$ classically, so vacuous. **Independently confirmed by the proof's own machinery:** at $n=3$ the whole locus *is* the triangle system of §5, whose matrix has determinant $-2$, so $K=0$. The two facts agreeing is a free consistency check on §2's characterisation. |
| $n=4$ | The first non-vacuous case, and **sharp there**: §6 computes the locus to be the two-dimensional family $K_{12}=K_{34}$, $K_{13}=K_{24}$, $K_{14}=K_{23}$ with the three values summing to zero, on which the rank is $4$ or $6$ and $4$ is attained on a one-parameter subfamily. The bound $\ge4$ is therefore attained at the smallest $n$ where anything exists. |
| $n=5$, and all $n\ge5$ | The witness of §6 is defined for every $n\ge4$ and the verification in §6 is uniform in $n$: rows $5,\dots,n$ are identically zero. Rank stays exactly $4$. |
| Odd $n$ | **No parity enters anywhere.** §§2–5 are graph counting and linear algebra over an arbitrary index set. The $\Lambda^\pm$ splitting appears only inside §7, at $n=4$ (even by construction), before the padding of §8, and §8 needs no splitting. So odd $n$ is not a special case. |
| "$n$ below the conjecture's range" | **I cannot check this sub-item.** The cold brief does not state the conjecture or its range of $n$, and the launch instruction forbids reading [findings/](../findings/) for it. What can be said unconditionally: L176 is non-vacuous exactly for $n\ge4$, and vacuous below. If the conjecture's range starts above $4$, L176 is *stronger* than needed and nothing is lost; if it starts at or below $4$, the table above covers it. Recorded as unchecked rather than passed. |

## 13. Scope (item 12)

**CONFIRMED**, nothing in the block over-reaches, and the $\mathbb{HP}^2$ disclaimer is right.

**What the block actually reaches.** L176 constrains coordinate-diagonal tensors. Its contrapositive, Corollary 1, is a **rank-$\le3$ test and nothing else**: it says nothing whatsoever about a Weyl tensor of $\Lambda^2$-rank $\ge4$, which may or may not be coordinate-diagonal (the witness of §6 *is*, at rank $4$; so rank $4$ is genuinely undecided by this block, and that is sharp).

**Padded $\mathbb{HP}^2$.** $\mathbb{HP}^2$ has real dimension $8$, so $\Lambda^2\mathbb R^8$ is $28$-dimensional. Whatever the rank of $W_{\mathbb{HP}^2}$ is, the block's disclaimer is correct **for a reason that does not require computing it**: Corollary 1 is vacuous the moment the rank exceeds $3$, and no plausible reading puts an $8$-dimensional symmetric space's Weyl operator at rank $\le3$. I did **not** compute the rank, that would be an unapproved computation and it is not needed to certify the disclaimer, which is a statement about the criterion's reach rather than about $\mathbb{HP}^2$. The block saying "it does not reach $\mathbb{HP}^2$" is accurate and appropriately modest.

**One thing the block could claim and does not, correctly.** §6 shows that at $n=4$ the diagonal locus forces $W^+$ and $W^-$ to have the *same* spectrum. That is a much sharper obstruction at $n=4$ than the rank bound, it rules out every Einstein $4$-manifold with $W^+\ne W^-$ as spectra, $\mathbb{CP}^2$ among them, without ever counting edges. The block does not claim it, so there is no over-reach; it is noted here as available rather than as owed.

## What would falsify L176, and what I did to look for it

**The falsifier.** A real symmetric hollow $n\times n$ matrix $K\ne0$, $n\ge3$, with every row sum zero and **at most three** nonzero entries above the diagonal. Equivalently: a nonzero coordinate-diagonal $W\in\mathcal W_n$ of $\Lambda^2$-rank $\le3$. Equivalently again, by §4's degree step: a simple graph on $\le3$ edges with no vertex of degree $1$, carrying a nonzero real edge-weighting whose weights sum to zero at every vertex.

**What I did.** No search, no sweep, no numerics of any kind. The counting of §4 is a **closed-form exhaustion** of the finitely many possibilities, and I re-derived it independently rather than reading it: with $\lvert E\rvert\le3$ the degree condition and the handshake identity leave exactly one graph shape, $K_3$; §5's determinant $-2$ kills it. There is nothing left to search, which is why no search was run. The secondary falsifier (a frame diagonalising $W_{\mathbb{CP}^2}$), is closed by §7's rank $3$ together with $\mathbb{CP}^2\ne0$ and the repaired Corollary 1, and by §8's independent $W^+\ne W^-$ route.

**The falsifier that *does* exist, and that I did exhibit in closed form**, is not a falsifier of L176 but of Corollary 1 and Corollary 3 as stated: **$W=0$** (§10). It is found by taking L176's hypothesis list and the corollaries' hypothesis lists and differencing them, the only entry that disappears is $W\ne0$, so the only candidate falsifier is the tensor that entry excludes. That is the whole of the method, and it took no computation.

## Overall verdict

**L176 and its proof: CONFIRMED, in full, including both items the brief flagged as most likely to break.** §2 shows the coordinate-diagonal locus is *exactly* the hollow symmetric matrices with vanishing row sums (the first Bianchi identity is free there and the off-diagonal traces vanish identically) so the row-sum condition is sufficient and not merely necessary, and the four-cycle witness of §6 is a genuine algebraic Weyl tensor of rank exactly four (item 6, **CONFIRMED**). §7 derives $\mathbb{CP}^2$'s Weyl spectrum in closed form from a source already on file, cross-checked against that source's own eigenvalue table and against a printed self-duality statement newly fetched from Itoh 1984: $W^-=0$, $W^+=(4,-2,-2)\propto(2,-1,-1)$, rank exactly three (item 7, **CONFIRMED**).

**Two defects, both the same one word, both repairable in place.**

1. **Corollary 1 is REFUTED AS STATED**: it drops L176's hypothesis $W\ne0$, and $W=0$ has rank $0\le3$ while being coordinate-diagonal in every frame. Insert "nonzero".
2. **Corollary 3 is REFUTED AS STATED**, inheriting the same gap through Corollary 1, and additionally carries **HYPOTHESIS-DEBT** on its imported equality clause: that clause has no argument on file, its objects $\kappa$ and $M$ are undefined in the block, and the identification $\lVert M\rVert_F=\lVert W\rVert$ plus the frame-invariance of both sides are used and unstated. The direction of the clause the corollary needs is *equality $\Rightarrow$ coordinate-diagonal*, and only that direction.

**One further HYPOTHESIS-DEBT:** the frame must be **orthonormal** for the trace condition to read as row sums and for the $\Lambda^2$ operator to be self-adjoint. Used throughout, stated nowhere.

**Corollary 2 stands** once Corollary 1 carries its word, since padded $W_{\mathbb{CP}^2}$ is nonzero; §8 confirms the padding stays in $\mathcal W_n$ and is exactly block-diagonal, adding zeros with no mixing. **Nothing in the block over-reaches**, and the $\mathbb{HP}^2$ disclaimer is correct.
