# Gate 2 review r770, L176, the coordinate-diagonal locus's minimum degree

**Cold brief, worked from [BRIEF-g2-l176.md](BRIEF-g2-l176.md) and nothing else; [findings/](../findings/) was left unread.** No numerical work was done: every value below is exact, every case analysis is finite and written out, and the one external fact the block imports was read at a source rather than recalled. Log: [agent_logs/g2-l176-r770.log](../agent_logs/g2-l176-r770.log).

## Claims

| # | claim | verdict |
| --- | --- | --- |
| 1 | The locus characterisation, coordinate-diagonal $W\in\mathcal W_n$ $\Leftrightarrow$ $K$ hollow symmetric with vanishing row sums | **CONFIRMED** |
| 2 | The eigenvalue identity $W(f_a\wedge f_b)=K_{ab}f_a\wedge f_b$ and $\mathop{\mathrm{rank}}=\lvert E(G)\rvert$ | **CONFIRMED** |
| 3 | L176, degree part, every vertex of $G$ has degree $0$ or $\ge2$ | **CONFIRMED** |
| 4 | L176, edge part, $\lvert E(G)\rvert\ge4$, hence $\Lambda^2$-rank $\ge4$ | **CONFIRMED** |
| 5 | L176's word "equivalently", joining the two-part conclusion to the rank bound | **REFUTED AS STATED**, only the second conjunct is equivalent to the rank bound |
| 6 | Sharpness, the four-cycle with values $c,-c,c,-c$ lies in $\mathcal W_n$ and has $\Lambda^2$-rank exactly four | **CONFIRMED** |
| 7 | Corollary 1, a Weyl tensor of $\Lambda^2$-rank $\le3$ is coordinate-diagonal in no frame | **REFUTED AS STATED**, $W=0$ has rank $0\le3$ and is coordinate-diagonal in every frame; the repair is the hypothesis $W\ne0$ that L176 carries and the corollary drops |
| 8 | Corollary 2, padded $W_{\mathbb{CP}^2}$ is coordinate-diagonal in no frame | **CONFIRMED**, and its two premises now rest on a source |
| 9 | $\mathbb{CP}^2$'s spectrum, $W^-=0$ and $W^+\propto(2,-1,-1)$ with no zero eigenvalue | **CONFIRMED** at source, in closed form: $\Lambda^2$ spectrum $(4,-2,-2,0,0,0)$ |
| 10 | The padding, zero-embedding keeps $W\in\mathcal W_n$ and adds zero eigenvalues alone | **CONFIRMED** |
| 11 | Corollary 3, $\kappa^2(W)<2\lVert W\rVert^2$ strictly at every Weyl tensor of $\Lambda^2$-rank $\le3$ | **REFUTED AS STATED**, the same $W=0$ gives equality |
| 12 | Corollary 3's imported equality clause, "$\kappa^2\le2\lVert M\rVert_F^2$ with equality **exactly** at coordinate-diagonal" | **HYPOTHESIS-DEBT**, the block carries no argument for it, and the direction it needs is the harder one |

**Act on this:** L176 and its proof stand as written; add the hypothesis $W\ne0$ to Corollaries 1 and 3, demote L176's "equivalently" to "in particular", and give Corollary 3's equality clause a citation to the numbered result that proves the direction *equality $\Rightarrow$ coordinate-diagonal* or mark it as debt.

## 0. Conventions, fixed once

- $\mathcal W_n\subset\bigotimes^4(\mathbb R^n)^*$ is the **space** of algebraic Weyl tensors: $W_{abcd}=-W_{bacd}=-W_{abdc}=W_{cdab}$, the first Bianchi identity $W_{abcd}+W_{acdb}+W_{adbc}=0$, and $\sum_b W_{abcb}=0$ for all $a,c$. Being a linear subspace it contains $0$; this fact does the work in §7 and §11.
- The frame $\{f_a\}$ is **orthonormal** for the standard positive-definite inner product on $\mathbb R^n$, and indices are raised and lowered by $\delta$. §1 shows the block uses this and states it nowhere.
- $\Lambda^2\mathbb R^n$ carries the inner product making $\{f_a\wedge f_b\}_{a<b}$ orthonormal, and $W$ acts by $W(f_a\wedge f_b)=\sum_{c<d}W_{abcd}\,f_c\wedge f_d$, equivalently $(W\omega)_{ab}=\tfrac12\sum_{c,d}W_{abcd}\omega_{cd}$.
- **Coordinate-diagonal** in $\{f_a\}$: $W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$ as unordered pairs. **Sectional matrix** $K_{ab}=W_{abab}$ (no sum). $G$ is the simple graph on $\{1,\dots,n\}$ with edge set $E=\{\{a,b\}:a\ne b,\ K_{ab}\ne0\}$.
- Kulkarni–Nomizu is used nowhere below; the Weyl tensor of $\mathbb{CP}^2$ in §9 is built by subtracting the constant-curvature tensor from the full curvature tensor, and the subtraction is written out.

## Hypothesis inventory (brief item 1)

**Used, and stated.**

| hypothesis | where it is used |
| --- | --- |
| $W\ne0$ | the single step $\lvert E\rvert\ge1$, which starts the edge count |
| coordinate-diagonal in some frame | throughout; it is what makes $K$ and $G$ defined at all |
| antisymmetry in the first and in the last index pair | $K_{aa}=W_{aaaa}=0$, so $K$ is hollow and $G$ is loopless |
| pair-exchange symmetry | $K_{ab}=K_{ba}$, so $G$ is undirected and $W$ is self-adjoint on $\Lambda^2$ |
| total trace-freeness | the row sums $\sum_bK_{ab}=0$, **the only condition in the whole list that constrains a diagonal $W$** |

**Stated, and imposing nothing.** The first Bianchi identity. §2 shows every instance of it holds identically once $W$ is coordinate-diagonal, whatever $K$ is. It is therefore free in both directions: it costs the forward proof nothing and it costs the sharpness witness nothing.

**Used, and unstated.**

- **Orthonormality of $\{f_a\}$.** The trace condition is written $\sum_bW_{abcb}=0$ with the summation index repeated in slots two and four; in a non-orthonormal frame the invariant condition carries $g^{bd}$ and the row-sum reading fails. The block says "in a frame".
- **Riemannian signature.** Same point: in indefinite signature the contraction picks up signs and the $n$ row sums become $\sum_b\epsilon_b K_{ab}=0$, which changes the $\lvert E\rvert=3$ elimination.
- **Simplicity of $G$.** The proof's degree-sum arithmetic needs no loops and no multi-edges. Both follow from the conventions ($K$ hollow; $E$ a set of unordered pairs), so this is sound, and it is worth saying rather than assuming, see §4.
- **$W\ne0$ in Corollaries 1 and 3.** L176 states it; the corollaries drop it; §7 and §11 show they are false without it.
- **In Corollary 2**, that the padding splits $\mathbb R^n=\mathbb R^4\oplus\mathbb R^{n-4}$ *orthogonally*, otherwise §10's block-triangular reading of the $\Lambda^2$ action does not follow.

## 1. The locus characterisation (brief item 2)

**Both directions, in full.**

*Forward.* Let $W\in\mathcal W_n$ be coordinate-diagonal. Antisymmetry gives $W_{aaaa}=0$, so $K$ is hollow. Pair exchange plus double antisymmetry gives $K_{ba}=W_{baba}=W_{abab}=K_{ab}$, so $K$ is symmetric. For the traces, compute $\sum_bW_{abcb}$ for arbitrary $a,c$. A term survives only when $\{a,b\}=\{c,b\}$ as unordered pairs, with $a\ne b$ and $c\ne b$ forced by antisymmetry. If $c\ne a$ this is impossible, so the off-diagonal traces vanish identically and impose nothing. If $c=a$ the surviving terms are $W_{abab}=K_{ab}$ over all $b\ne a$, so the condition reads $\sum_bK_{ab}=0$, **exactly the row sums, with no factor and no extra term.**

*Converse.* Given hollow symmetric $K$ with vanishing row sums, set $W_{abab}=W_{baba}=K_{ab}$, $W_{abba}=W_{baab}=-K_{ab}$ for $a\ne b$, all other components zero. Equivalently $W=\sum_{a<b}K_{ab}\,\theta^{ab}\otimes\theta^{ab}$ with $\theta^{ab}=f^a\wedge f^b$, which is manifestly Riemann-symmetric. The traces vanish by the computation just made. Bianchi is checked in §2. So the tensor lies in $\mathcal W_n$.

**The characterisation is exact.** The row sums are the whole of the trace condition on this locus, not a consequence of it.

**On "totally" trace-free.** For a tensor with the Riemann symmetries every contraction is $\pm$ the Ricci one or identically zero, $\sum_aW_{aacd}=0$ by antisymmetry, and the remaining pairings differ from $\sum_bW_{abcb}$ by a sign. So "totally trace-free" adds nothing beyond the $n(n+1)/2$ Ricci equations, of which $n$ survive here.

## 2. The first Bianchi identity on the locus (brief item 2, second half)

**It imposes nothing.** Take $W$ coordinate-diagonal and evaluate $B(a,b,c,d):=W_{abcd}+W_{acdb}+W_{adbc}$.

- **$b,c,d$ pairwise distinct and distinct from $a$.** Then $\{a,b\}\ne\{c,d\}$, $\{a,c\}\ne\{d,b\}$, $\{a,d\}\ne\{b,c\}$, since each equality would force a repetition among the four indices. All three terms vanish.
- **$d=b$.** $B=W_{abcb}+W_{acbb}+W_{abbc}$. The middle term vanishes by antisymmetry in its last pair. The first is nonzero only when $c=a$, and then $W_{abab}+W_{abba}=K_{ab}-K_{ab}=0$; when $c\ne a$ both remaining terms vanish.
- **$c=b$.** $B=W_{abbd}+W_{abdb}+W_{adbb}$. The last vanishes by antisymmetry; the first two are negatives of each other by antisymmetry in the last pair.
- **$c=d$, or $a\in\{b,c,d\}$.** Every term carries a repeated index inside an antisymmetric pair or reduces to a case above.

The list is exhaustive, so $B\equiv0$ on the whole diagonal locus. **Bianchi is a stated hypothesis that constrains nothing here**, which is precisely why it cannot be the thing that breaks the sharpness witness in §6.

## 3. The eigenvalue identity (brief item 3)

With $\omega=f_a\wedge f_b$, so $\omega_{cd}=\delta_{ca}\delta_{db}-\delta_{cb}\delta_{da}$, the convention $(W\omega)_{pq}=\tfrac12\sum_{c,d}W_{pqcd}\omega_{cd}$ gives $(W\omega)_{pq}=W_{pqab}$, nonzero only for $\{p,q\}=\{a,b\}$, with $(W\omega)_{ab}=K_{ab}$ and $(W\omega)_{ba}=-K_{ab}$. Hence $W\omega=K_{ab}\,\omega$. **The identity as written is right under the half-convention.**

**The other normalisations.** Dropping the $\tfrac12$ gives $2K_{ab}$; rescaling the basis to $\tfrac1{\sqrt2}f_a\wedge f_b$ leaves the eigenvalue alone. In every case the operator is diagonal in the basis $\{f_a\wedge f_b\}_{a<b}$ of $\Lambda^2\mathbb R^n$, so its rank is the number of $a<b$ with $K_{ab}\ne0$, which is $\lvert E(G)\rvert$. **No convention changes the count**, because all of them scale the spectrum by a nonzero constant.

**The stronger worry the brief raises (a wrong identification of the operator), is answered independently in §9**, where the same convention applied to $\mathbb{CP}^2$ reproduces $W^+=(4,-2,-2)$, the value Derdziński's Proposition 2 gives for a Kähler four-manifold of scalar curvature $24$. An operator identified one slot wrong would not land on that.

## 4. The degree-sum counting (brief items 3–4)

**Degree.** Let $a$ have degree exactly one, with sole neighbour $b$. Then $K_{ac}=0$ for every $c\ne b$, so $0=\sum_cK_{ac}=K_{ab}$, contradicting $\{a,b\}\in E$. So no vertex has degree one, and every vertex has degree $0$ or $\ge2$. **Correct as written.**

**$\lvert E\rvert\ge1$.** On the locus $W$ is determined by $K$, so $W\ne0$ forces some $K_{ab}\ne0$.

**$\lvert E\rvert=2$ is impossible.** Degree sum $2\lvert E\rvert=4$; every support vertex has degree $\ge2$; so at most two vertices carry support. A simple graph on at most two vertices has at most one edge. Contradiction.

**$\lvert E\rvert=1$ is impossible** by the degree part: the unique edge's two endpoints have degree one.

*The block's phrasing compresses these two into one sentence and leaves the reader to supply "so $\lvert E\rvert\le1$, and $\lvert E\rvert=1$ was already excluded". The compression is recoverable and the conclusion is right.*

**$\lvert E\rvert=3$ forces $K_3$.** Degree sum $6$ with every support degree $\ge2$ gives at most three support vertices; a simple graph on at most two vertices carries at most one edge, so there are exactly three, each of degree exactly $2$, and the only such simple graph is the triangle.

**The three failure modes the brief names.**

- **Loops** are excluded because $K$ is hollow, which §1 derives from antisymmetry rather than assuming.
- **Multi-edges** are excluded because $E$ is a set of unordered index pairs; there is one component $K_{ab}$ per pair.
- **A vertex outside the support** has degree $0$, which the conclusion permits and the degree sum ignores. Its own row sum reads $0=0$ and constrains nothing. **It cannot break the count**, because the count is over support vertices only.

## 5. The triangle system (brief item 5)

On $K_3$ with vertices $a,b,c$, every entry of $K$ outside $\{ab,ac,bc\}$ vanishes, so each row sum runs over the triangle alone:

$$K_{ab}+K_{ac}=0,\qquad K_{ab}+K_{bc}=0,\qquad K_{ac}+K_{bc}=0.$$

**All three are stated correctly in the block.** In the unknowns $(K_{ab},K_{ac},K_{bc})$ the matrix is $\begin{pmatrix}1&1&0\\1&0&1\\0&1&1\end{pmatrix}$ with determinant $-2\ne0$, so the system is **nonsingular** and the only solution is zero. The block's route is the same: rows one and two give $K_{ac}=K_{bc}=-K_{ab}$, row three then gives $-2K_{ab}=0$. Over $\mathbb R$ this forces $K_{ab}=0$, contradicting $\{a,b\}\in E$.

*The determinant $-2$ is the one place the argument uses that the ground field has characteristic other than two; over $\mathbb F_2$ the triangle would survive. The record works over $\mathbb R$, so this is a remark rather than a defect.*

## 6. The sharpness witness (brief item 6, the one flagged most likely to break)

**It does not break.** Take $n\ge4$ and $K_{12}=K_{21}=c$, $K_{23}=K_{32}=-c$, $K_{34}=K_{43}=c$, $K_{14}=K_{41}=-c$, every other entry zero, $c\ne0$.

- **Hollow and symmetric:** by construction.
- **Row sums:** row $1$ is $c+(-c)=0$; row $2$ is $c+(-c)=0$; row $3$ is $-c+c=0$; row $4$ is $c+(-c)=0$; rows $5,\dots,n$ are empty.
- **Riemann symmetries:** the tensor is $W=\sum_{a<b}K_{ab}\,\theta^{ab}\otimes\theta^{ab}$ with $\theta^{ab}=f^a\wedge f^b$, antisymmetric in each pair and symmetric under pair exchange by inspection.
- **First Bianchi:** §2 proves it holds for **every** coordinate-diagonal tensor, so it holds here. Spot-check at the one index quadruple where a failure could hide: $W_{1234}+W_{1342}+W_{1423}=0+0+0=0$, since none of $\{1,2\}=\{3,4\}$, $\{1,3\}=\{4,2\}$, $\{1,4\}=\{2,3\}$ holds.
- **Totally trace-free:** §1 shows this is exactly the row sums on the diagonal locus, which are checked above. **The brief's suspicion (that the row sums are merely necessary), is answered by the converse in §1: they are necessary and sufficient.**

**Rank.** The $\Lambda^2$ eigenvalues are $K_{12}=c$, $K_{13}=0$, $K_{14}=-c$, $K_{23}=-c$, $K_{24}=0$, $K_{34}=c$, together with zeros from every pair meeting $\{5,\dots,n\}$. Exactly four are nonzero, so the $\Lambda^2$-rank is **four**, matching the bound. The witness is genuine and L176 is sharp.

**An independent confirmation at $n=4$.** The tensor commutes with the Hodge star: it acts as $c\cdot\mathrm{id}$ on $\langle f_1\wedge f_2,f_3\wedge f_4\rangle$, as $0$ on $\langle f_1\wedge f_3,f_2\wedge f_4\rangle$, and as $-c\cdot\mathrm{id}$ on $\langle f_1\wedge f_4,f_2\wedge f_3\rangle$, each of which is star-invariant. Reading off, $W^+$ and $W^-$ both have spectrum $(c,0,-c)$, each trace-free on its three-dimensional summand, the signature every element of $\mathcal W_4$ must have. **A tensor failing trace-freeness could not produce two trace-free triples**, so this is a second, structurally independent check that the witness lies in $\mathcal W_4$.

## 7. Corollary 1 (brief item 12, and the defect)

**As stated: "A Weyl tensor of $\Lambda^2$-rank $\le3$ is coordinate-diagonal in no frame." This is false, and the counterexample is exhibited in closed form: $W=0$.**

- $\mathcal W_n$ is a linear space, so $0\in\mathcal W_n$.
- $\mathop{\mathrm{rank}}(0:\Lambda^2\to\Lambda^2)=0\le3$.
- $0$ satisfies "$W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$" vacuously, in **every** frame.

So the zero tensor has rank $\le3$ and is coordinate-diagonal in every frame. **The hypothesis $W\ne0$ that L176 carries is dropped when the corollary is formed.** With it restored the corollary is immediate and correct: if $W\ne0$ were coordinate-diagonal in some frame, L176 would give rank $\ge4$.

*This is a defect of statement rather than of mathematics, the intended content, "$1\le\mathop{\mathrm{rank}}\le3$ excludes coordinate-diagonality", survives untouched, and the repair is two characters. It is reported because a corollary quoted downstream is quoted as written.*

## 8. Corollary 2

**Correct, and unaffected by §7's defect**, since $W_{\mathbb{CP}^2}\ne0$. The chain is: $\mathbb{CP}^2$'s Weyl tensor has $\Lambda^2$-rank three (§9); padding preserves both membership in $\mathcal W_n$ and the rank (§10); a nonzero tensor of rank three is coordinate-diagonal in no frame (§7, repaired). Each link is established below.

**What the corollary does *not* give**, and correctly does not claim: L176 is a **necessary** condition for coordinate-diagonality. It can rule coordinate-diagonality out and can never certify it.

## 9. $\mathbb{CP}^2$'s spectrum, read at a source (brief item 7)

**Fetched and filed:** [references/derdzinski-1983-self-dual-kaehler/](../references/derdzinski-1983-self-dual-kaehler/), Andrzej Derdziński, *Self-dual Kähler manifolds and Einstein manifolds of dimension four*, [Compositio Mathematica 49 (1983), 405–433](http://www.numdam.org/item?id=CM_1983__49_3_405_0), with the PDF, a `pdftotext` extraction, a README and a [notes.md](../references/derdzinski-1983-self-dual-kaehler/notes.md) carrying the transcription and the derivation repeated here.

**What Derdziński's Proposition 2 (p. 415) states.** For a Kähler manifold of real dimension four, oriented naturally, $W(\omega)=u\omega/6$ where $u$ is the scalar curvature and $\omega$ the Kähler form, and $\#\mathop{\mathrm{spec}}_{\Lambda^+}(W^+)\le2$. Since $W^+$ is trace-free on the three-dimensional $\Lambda^+$, the spectrum is forced to $(u/6,-u/12,-u/12)$, that is $\tfrac{u}{12}(2,-1,-1)$. His clause (ii), $u^2=24\lvert W^+\rvert^2$, is the internal check: $(u/6)^2+2(u/12)^2=u^2/24$. His Corollary 4 (p. 424) gives $W^-=0$ for any orientable, locally irreducible, locally symmetric four-manifold, which covers $\mathbb{CP}^2$.

**The numbers for $\mathbb{CP}^2$ itself, computed in closed form from a second source already on file.** [Bourguignon–Karcher §5.1](../references/bourguignon-karcher-1978-pinching/) gives the curvature tensor of $\mathbb{CP}^n$ outright, in the normalisation with sectional curvature in $[1,4]$:

$$R(a,b,c,d)=\langle a,c\rangle\langle b,d\rangle-\langle a,d\rangle\langle b,c\rangle+\langle Ja,c\rangle\langle Jb,d\rangle-\langle Ja,d\rangle\langle Jb,c\rangle+2\langle Ja,b\rangle\langle Jc,d\rangle.$$

Take the orthonormal frame $e_1,\ e_2=Je_1,\ e_3,\ e_4=Je_3$, and write $\Omega_{ab}=\langle Je_a,e_b\rangle$, so $\Omega_{12}=\Omega_{34}=1$ and all other entries above the diagonal vanish.

- **Sectional curvature:** $R(a,b,a,b)=1+3\langle Ja,b\rangle^2$, giving $4$ on holomorphic planes and $1$ on totally real ones, the stated range, which confirms the frame and the normalisation.
- **Ricci and scalar:** $\mathop{\mathrm{Ric}}_{11}=R_{1212}+R_{1313}+R_{1414}=4+1+1=6$, so $\mathop{\mathrm{Ric}}=6g$ and $u=24$.
- **Weyl:** in dimension four an Einstein tensor has $W=R-\tfrac{u}{12}(g_{ac}g_{bd}-g_{ad}g_{bc})$ with $\tfrac{u}{12}=2$, so $W(a,b,c,d)=-(g_{ac}g_{bd}-g_{ad}g_{bc})+(\Omega_{ac}\Omega_{bd}-\Omega_{ad}\Omega_{bc})+2\Omega_{ab}\Omega_{cd}$.
- **Components:** $W_{1212}=W_{3434}=2$; $W_{1313}=W_{1414}=W_{2323}=W_{2424}=-1$; $W_{1234}=2$; $W_{1324}=1$; $W_{1423}=-1$; all others zero. Bianchi: $W_{1234}+W_{1342}+W_{1423}=2-1-1=0$. Trace: $2-1-1=0$.
- **The operator**, in the convention of §0, is block diagonal on the three pair-planes with matrices $\begin{pmatrix}2&2\\2&2\end{pmatrix}$, $\begin{pmatrix}-1&1\\1&-1\end{pmatrix}$, $\begin{pmatrix}-1&-1\\-1&-1\end{pmatrix}$, whose eigenvalues are $\{4,0\}$, $\{-2,0\}$, $\{-2,0\}$.
- **Sorting by the star.** With orientation $e_1\wedge e_2\wedge e_3\wedge e_4$: $\star(e_1\wedge e_2)=e_3\wedge e_4$, $\star(e_1\wedge e_3)=-e_2\wedge e_4$, $\star(e_1\wedge e_4)=e_2\wedge e_3$. So $\Lambda^+=\langle e_1\wedge e_2+e_3\wedge e_4,\ e_1\wedge e_3-e_2\wedge e_4,\ e_1\wedge e_4+e_2\wedge e_3\rangle$, which is exactly the span of the eigenvectors with eigenvalues $4,-2,-2$, and $\Lambda^-$ is the span of the three with eigenvalue $0$.

**Result, exact.** $W^-=0$; $W^+$ has spectrum $(4,-2,-2)=2\cdot(2,-1,-1)$, **no zero eigenvalue**; the full $\Lambda^2\mathbb R^4$ spectrum is $(4,-2,-2,0,0,0)$ and the $\Lambda^2$-rank is **three**. This agrees with Derdziński's Proposition 2 evaluated at $u=24$. **Both premises the brief asks about are confirmed, from two sources that agree.**

*A by-product worth recording: $W_{1234}=2\ne0$, so $\mathbb{CP}^2$'s Weyl tensor is not coordinate-diagonal even in the frame adapted to $J$, which is the frame one would try first.*

## 10. The padding (brief item 8)

Split $\mathbb R^n=\mathbb R^4\oplus V$ orthogonally, $V=\langle f_5,\dots,f_n\rangle$, and define $W$ by keeping $W_{\mathbb{CP}^2}$ on indices $\le4$ and setting every component with an index in $V$ to zero.

- **Riemann symmetries:** each is a componentwise identity relating components with the same index set, so it holds on both blocks.
- **First Bianchi:** with all four indices $\le4$ it is the identity in $\mathcal W_4$; with any index $>4$ all three terms vanish.
- **Trace-free:** $\sum_{b=1}^nW_{abcb}$ equals $\sum_{b\le4}W_{abcb}=0$ when $a,c\le4$, and is a sum of zeros when $a>4$ or $c>4$.

So the padded tensor lies in $\mathcal W_n$.

**No mixing.** $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^4\oplus(\mathbb R^4\wedge V)\oplus\Lambda^2V$. If $\{a,b\}\not\subset\{1,\dots,4\}$ then $W_{abcd}=0$ for all $c,d$, so the last two summands lie in the kernel. If $\{a,b\}\subset\{1,\dots,4\}$ then $W_{abcd}=0$ unless $\{c,d\}\subset\{1,\dots,4\}$, so $\Lambda^2\mathbb R^4$ is invariant. **The operator is the block sum $W_{\mathbb{CP}^2}\oplus0$**, its spectrum is $(4,-2,-2)$ together with $\binom n2-3$ zeros, and the rank stays three. Padding adds zero eigenvalues alone.

## 11. The kernel (brief item 9)

**No step assumes $\ker W=0$, and the block's own objects have large kernels.**

- L176's proof works with the diagonal matrix of eigenvalues and counts the nonzero ones. Zeros in the spectrum ($K_{ab}=0$ for a non-edge), are what the counting is *about*.
- The sharpness witness of §6 has kernel of dimension $\binom n2-4$, and the argument uses that fact rather than fighting it.
- The padded tensor of §10 is almost all kernel: rank three inside a $\binom n2$-dimensional space. §10's block decomposition is the statement that the added kernel stays added.
- Corollaries 1 and 2 are statements *about* high-kernel tensors, so a hidden invertibility assumption would make them vacuous rather than false; there is none.

## 12. Corollary 3 (brief item 10)

**Two separate findings.**

**(a) The inference is sound in the direction used; the imported clause is not on file.** To conclude strict inequality at a tensor of rank $\le3$ the argument needs *equality $\Rightarrow$ coordinate-diagonal*, contraposed against Corollary 1. The brief quotes the clause as an "iff" and uses only that half, **the half that is the substantive one**, since the converse (coordinate-diagonal $\Rightarrow$ equality) would be a computation on the locus and is not what is invoked. The block supplies no proof, no definition of $\kappa$, and no definition of $M$ or of the relation between $\lVert M\rVert_F$ and $\lVert W\rVert$. **Verdict `HYPOTHESIS-DEBT`: this claim has no argument on file.** What would have to be proved: *for every $W\in\mathcal W_n$, if $\kappa^2(W)=2\lVert W\rVert^2$ then $W$ is coordinate-diagonal in some frame*, together with the $O(n)$-invariance of $\kappa$ and $\lVert\cdot\rVert$ that lets "some frame" and "the frame at hand" be interchanged, which is asserted nowhere. **I do not supply it.**

**(b) The corollary is false as stated, by the same object as §7.** At $W=0$ the quoted inequality reads $\kappa^2(0)\le0$; since $\kappa^2$ is a square it is nonnegative, so $\kappa^2(0)=0=2\lVert0\rVert^2$ and equality holds. Yet $\mathop{\mathrm{rank}}(0)=0\le3$. **Verdict `REFUTED AS STATED`, with the repair again the single hypothesis $W\ne0$.** *This is consistent rather than paradoxical: $W=0$ is coordinate-diagonal in every frame, so the equality clause predicts equality there, it is Corollary 1 and Corollary 3, not the clause, that forget to exclude it.*

## 13. The boundary (brief item 11)

| $n$ | reading |
| --- | --- |
| $n\le2$ | $\dim\Lambda^2\le1$, so rank $\ge4$ is unattainable; L176 therefore asserts that no nonzero coordinate-diagonal $W$ exists, and the proof delivers that: $K$ is a hollow symmetric $2\times2$ matrix with $K_{12}=0$ from row one |
| $n=3$ | $\dim\Lambda^2=3<4$, and the proof's own $\lvert E\rvert=3$ case does the work: a hollow symmetric $3\times3$ matrix with vanishing row sums is zero, by the nonsingular triangle system of §5. **The proof derives the vanishing of the diagonal locus at $n=3$ rather than importing $\mathcal W_3=0$**, which is a genuine internal consistency check |
| $n=4$ | the bound is attained, by §6; $\dim\Lambda^2=6$, leaving two zero eigenvalues, and $W^\pm$ each read $(c,0,-c)$ |
| $n=5$ and every odd $n$ | the four-cycle sits on $\{1,2,3,4\}$ and the remaining rows are empty; parity enters nowhere in the argument, which is graph-theoretic and metric-free past the row sums |
| below the conjecture's range | the cold brief fixes no range for Conjecture A, so this is answered as far as the brief permits: L176 is stated for all $n$, is vacuous where $\mathcal W_n=0$, and its proof never assumes $n$ large |

## 14. Scope (brief item 12)

**The block claims no more than it reaches.** Its restraint about padded $W_{\mathbb{HP}^2}$ is correct and for the right reason: Corollary 1's criterion is a rank threshold at three, and $\mathbb{HP}^2$'s Weyl tensor lives on $\Lambda^2\mathbb R^8$, where the rank is far above three, Bourguignon–Karcher §5.4 already exhibits a three-dimensional eigenspace $\langle I,J,K\rangle$ inside a much larger spectrum. So L176 has nothing to say about it in either direction, and the block says so.

**The one presentational over-claim is L176's own word "equivalently"** (claim 5 in the table). The stated conclusion is a conjunction (every vertex has degree $0$ or $\ge2$, **and** $\lvert E(G)\rvert\ge4$) and only the second conjunct is equivalent to $\mathop{\mathrm{rank}}\ge4$. The degree condition is strictly more information: a path on five vertices has four edges, hence would have rank four, while carrying two vertices of degree one. Read as an equivalence the sentence asserts that rank $\ge4$ implies the degree condition **for an arbitrary graph**, which is false; read as "in particular, $\mathop{\mathrm{rank}}\ge4$" it is exactly right. *The mathematics is unharmed (on the locus both conjuncts hold) but a downstream user who inverts the "equivalently" gets a false statement.*

## Name what would break it

**The falsifier is a single object: a nonzero $W\in\mathcal W_n$, coordinate-diagonal in some orthonormal frame, whose sectional matrix $K$ is hollow, symmetric, has all row sums zero, and has at most three nonzero entries above the diagonal**, equivalently a support graph with a degree-one vertex, or with one, two or three edges.

**What I did to look for it.** No search, no sweep, no census; this is an analysis-only audit and none was run. Instead the space of falsifiers was closed by hand, and it is finite: the degree-one case dies on one row sum (§4), $\lvert E\rvert\in\{1,2\}$ dies on the degree sum together with simplicity of $G$ (§4), and $\lvert E\rvert=3$ reduces to the single graph $K_3$ whose row-sum system has determinant $-2$ and hence only the zero solution (§5). **Every case is exhausted in closed form, so no falsifier exists.** The complementary object (a coordinate-diagonal Weyl tensor of rank exactly four), was exhibited in closed form in §6 and verified against all three defining conditions plus the $\Lambda^\pm$ trace test, so the bound is attained and cannot be raised.

**The one place a falsifier could still live is Corollary 3's imported equality clause**, whose falsifier would be a $W$ with $\kappa^2(W)=2\lVert W\rVert^2$ that is coordinate-diagonal in no frame. **I looked for none**, because the clause's proof is not in the block and auditing an unstated claim's falsifiers is not something the brief asks for; the finding there is the debt recorded in §12.

## Overall verdict

**`REFUTED AS STATED`.**

- **L176 itself and its proof are `CONFIRMED`**, the locus characterisation is exact in both directions, the trace condition really is the row sums with no factor, Bianchi imposes nothing, the eigenvalue identity is right in every normalisation that matters, the counting and the triangle system are correct, and the sharpness witness is a genuine element of $\mathcal W_n$ of rank exactly four. The item the brief flagged as most likely to break survives an independent second check.
- **Corollary 2 is `CONFIRMED`**, and its two premises now rest on a fetched source plus a closed-form computation from a second, with the two agreeing.
- **Corollaries 1 and 3 are false as written**, both by the same exhibited object $W=0$, and both repaired by restoring the hypothesis $W\ne0$ that L176 carries.
- **Corollary 3 additionally rests on an imported equality clause with no argument on file**, in the direction *equality $\Rightarrow$ coordinate-diagonal*; that is `HYPOTHESIS-DEBT` and is not supplied here.
- **L176's "equivalently" should read "in particular".**
