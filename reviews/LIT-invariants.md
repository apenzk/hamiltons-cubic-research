# LIT-invariants, what the standard theory owns of the $T_{abc}$ contraction classification

Literature search against [findings/bounds.md](../findings/bounds.md) §"What a critical point carries beyond its spectrum". The record derived, from scratch, that a monomial contraction $\sum\lambda_a^p\lambda_b^q\lambda_c^r\,T_{abc}$ is a function of $(\lambda,\theta)$ exactly when at least two of $p,q,r$ are $\le1$, with $\{2,2,0\}$ the first free one. The question put to this search was how much of that is already known.

**Verdict in one line: the ingredients are published and already on this shelf, the conclusion drawn from them is not published anywhere I could find, and the conclusion is weaker than the record states, the free degree-4 data is at least two-dimensional, and $S_{22}$ is one coordinate on it rather than the whole of it.**

> **READ [LIT-jacobi](LIT-jacobi.md) FIRST, it ran in the same window and its §5 supersedes half of this report.** That search derived, from Schur applied to the record's own $\mathcal A$, the closed law $\sum_{abc}f(\lambda_a)g(\lambda_b)T_{abc}=-\sum_ia_i\langle\pi_if(W),\pi_ig(W)\rangle$ over the four isotypic summands of $\mathrm{Sym}^2(\Lambda^2)$, verified to $10^{-15}$ at $n=6,\dots,10$. **That law re-derives the record's whole pinned/free boundary in one clause** ($f$ or $g$ affine gives a pure-Weyl argument, hence a spectral answer), **and it is strictly better than the exponent count**, because it explains the boundary's failure at a two-eigenvalue spectrum where $\lambda^2$ is affine. Everything below about *why* (A) and (B) are the only linear relations is a weaker version of that. What survives as additive is F2, F3, F4 and the negatives.

---

## The four findings, ranked

| # | Finding | Standing against the record |
| --- | --- | --- |
| **F1** | Relations (A) and (B) are both [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md) **Lemma 2.1** | **Cites**, the record already knew the lemma; [bounds.md](../findings/bounds.md) was the one place not connected to it. Superseded on completeness by [LIT-jacobi §5](LIT-jacobi.md) |
| **F2** | $T_{abc}$ is the Wang–Ziller structure-constant tensor $L_{ijk}$, a primary object of the homogeneous-Einstein programme | **Names** the object, and **corrects** LIT-jacobi's negative that no literature treats the squares beyond the Killing form |
| **F3** | $S_{22}=2\mathop{\mathrm{tr}}(W^2\,\#\,W^2)$, verified to $2\times10^{-16}$ | **Names** the first free monomial, in Hamilton's own calculus |
| **F4** | At fixed spectrum, $S_{22}$ and $\lVert W^\#\rVert^2$ vary **independently**; at $n=6$ the free space is $54$-dimensional | **Corrects** the record: $\{2,2,0\}$ is the first free *monomial*, not the first free *invariant* |

---

## F1. Relations (A) and (B) are one published lemma, which the record already cites, in two other files

*Scope, stated first. [findings/target.md](../findings/target.md) and [findings/problem.md](../findings/problem.md) already carry Lemma 2.1 and $W\#I=-W$; [findings/bounds.md](../findings/bounds.md) derives relations (A) and (B) afresh without connecting them to it. **The finding is the connection, not the lemma.** The completeness argument below is the weaker predecessor of [LIT-jacobi §5](LIT-jacobi.md)'s four-summand law and is kept only because it is the shortest route to the two relations bounds.md actually uses.*

**Böhm–Wilking, *Manifolds with positive curvature operators are space forms*, Annals 167 (2008), [arXiv:math/0606187](https://arxiv.org/abs/math/0606187), Lemma 2.1**, verbatim, from the copy in [references/boehm-wilking-2008-space-forms/](../references/boehm-wilking-2008-space-forms/notes.md):

> The bilinear map $\#$ induces a linear $O(n)$-equivariant map given by $R\mapsto R\,\#\,I$. The normalization of our parameters is related to the eigenvalues of this map.
>
> **Lemma 2.1.** Let $R\in S^2_B(\mathfrak{so}(n))$. Then $R+R\,\#\,I=(n-1)R_I+\frac{n-2}2R_{\mathrm{Ric}_0}=\mathrm{Ric}\wedge\mathrm{id}$.
>
> [Proof, in part] For $n=4$ one verifies directly that $\langle W\rangle$ is in the kernel of the map $R\mapsto R+R\,\#\,I$. Since there is a natural embedding of the Weyl curvature operators in $S^2_B(\mathfrak{so}(4))$ to the Weyl curvature operators in $S^2_B(\mathfrak{so}(n))$ this implies the same result for $n\ge5$.

Reading it off, in the record's own convention $\langle A\,\#\,B,C\rangle=\tfrac12\sum_{abc}T_{abc}A_aB_bC_c$ for simultaneously diagonal $A,B,C$:

- **$R=I$**: $I\,\#\,I=(n-2)I$, whose $k$-th diagonal entry is $\tfrac12\sum_{\beta\gamma}T_{k\beta\gamma}$. This is **relation (A)**, $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$.
- **$R=W$ Weyl**: $W$ is in the kernel, so $W\,\#\,I=-W$, whose $k$-th diagonal entry is $\tfrac12\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}$. This is **relation (B)**, $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$.

**Checked here at $n=6$** against $\dim\mathcal W_6=84$ built from [weyl.py](../scripts/lib/weyl.py): $\lVert I\#I-(n-2)I\rVert_\infty=0$ exactly, and $\lVert W\#I+W\rVert_\infty=1.1\times10^{-16}$ at a random unit $W\in\mathcal W_6$. **The conventions agree with no rescaling**, so the record can cite Lemma 2.1 directly, in [bounds.md](../findings/bounds.md) as it already does in [target.md](../findings/target.md).

**The completeness half, and its better version.** The record asserts that (A), (B), (C) "are the whole of what the Killing form, Ricci-flatness and criticality give" without an argument for the "whole". Lemma 2.1 supplies a partial one: $R\mapsto R\,\#\,I$ is $O(n)$-equivariant, $S^2_B(\mathfrak{so}(n))=\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$ is multiplicity-free, so **Schur forces $\#I$ to act by a scalar on each summand and Lemma 2.1 names all three: $n-2$, $\tfrac{n-4}2$, $-1$**, no fourth summand, hence no third relation of that shape. **[LIT-jacobi §5](LIT-jacobi.md) does this properly**: its $\mathcal A$ is scalar on all four summands of $\mathrm{Sym}^2(\Lambda^2)$ including $\Lambda^4$, which is where $W^2$ hides the free data, and it therefore reaches the whole two-weight family rather than the two relations. **Cite theirs.**

*Filed*: the lemma is transcribed into [references/boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md), which previously held the paper's $\#$ definition and Huisken's trilinear form but not this.

## F2. $T_{abc}$ has a standard name and a standard home, the homogeneous-Einstein literature

**Bettiol–Friedman, *Counting Homogeneous Einstein Metrics*, [arXiv:2509.09830](https://arxiv.org/abs/2509.09830), §2.2**, now filed as [references/bettiol-friedman-2025-counting-homogeneous-einstein/](../references/bettiol-friedman-2025-counting-homogeneous-einstein/notes.md). Verbatim:

> Define the structure constants $L_{ijk}:=\sum_{v_\alpha\in\mathfrak m_i,\,v_\beta\in\mathfrak m_j,\,v_\gamma\in\mathfrak m_k}Q([v_\alpha,v_\beta],v_\gamma)^2$. Note that $L_{ijk}$ does not depend on the choice of $Q$-orthonormal basis, but only on the decomposition (2.1). The constants $L_{ijk}$ are nonnegative and $L_{ijk}=0$ if and only if $[\mathfrak m_i,\mathfrak m_j]$ is $Q$-orthogonal to $\mathfrak m_k$. Moreover, $L_{ijk}$ is symmetric in its 3 indices.

Take $\mathfrak g=\mathfrak{so}(n)$, trivial isotropy, and the decomposition into the $N=\binom n2$ eigenlines of $W$: then $d_i=1$ and $L_{abc}=T_{abc}$ exactly. This tensor has been the working object of the Wang–Ziller / Böhm–Wang–Ziller programme since 1986.

Two of that programme's standard facts land on the record:

- **The record's (A) is their $b_i$ identity.** $b_i$ is fixed by $B|_{\mathfrak m_i}=-b_iQ|_{\mathfrak m_i}$ against the Cartan–Killing form; on $\mathfrak{so}(n)$ with $Q=-\tfrac12\mathop{\mathrm{tr}}$ this gives $b_i=2(n-2)$, and with trivial isotropy the row-sum identity reads $\sum_{j,k}L_{ijk}=d_ib_i=2(n-2)$. Identical to relation (A).
- **The record's monomial family is their scalar curvature.** Their (3.1) reads $\mathrm{scal}(x)=\sum_i\frac{d_ib_i}{2x_i}-\frac14\sum_{ijk}L_{ijk}\frac{x_k}{x_ix_j}$, a member of $\sum\lambda_a^p\lambda_b^q\lambda_c^rT_{abc}$ with weight $\{1,-1,-1\}$.

**Standing: names the object, and corrects one negative in the sibling report.** [LIT-jacobi §4](LIT-jacobi.md) records that "no source treats $T_{abc}=c_{abc}^2$ for a compact simple Lie algebra as an object" and that "the canonical squared-structure-constants object in the literature **is** the Killing form". **The homogeneous-Einstein programme is the exception**: $L_{ijk}$ is defined for any $Q$-orthogonal decomposition, it is the primary variable of Wang–Ziller and everything downstream of it, and (3.1) contracts it against $x_k/(x_ix_j)$, a weight the Killing form does not undo. The correction does not change LIT-jacobi's conclusion, since that literature still asks nothing the record needs, but the negative as written is too strong.

**What it does not settle.** That programme treats $L$ as free parameters describing the group and asks how many solutions the Einstein system has; nothing there plays the role of the record's spectrum, so the record's question is never posed. What is available for borrowing is the Newton-polytope/BKK machinery for counting critical points of a Laurent polynomial in the $x_i$ with $L$ as coefficients, a template if the record ever wants to count critical points of a $T$-moment functional.

## F3. The first free invariant is a Hamilton-$\#$ trace

From $\langle A\,\#\,B,C\rangle=\tfrac12\sum_{abc}T_{abc}A_aB_bC_c$ on simultaneously diagonal arguments,

$$S_{22}=\sum_{abc}\lambda_a^2\lambda_b^2T_{abc}=2\mathop{\mathrm{tr}}\big(W^2\,\#\,W^2\big),$$

**checked at $n=6$ to $2\times10^{-16}$** against the record's own $S_{22}=\sum_{k,\alpha}\lVert[We_k,We_\alpha]\rVert^2$. More generally the record's whole monomial family is $\sum\lambda^p\lambda^q\lambda^rT=2\langle W^p\,\#\,W^q,\,W^r\rangle$, so the classification reads, in Hamilton's calculus:

> $\langle W^p\,\#\,W^q,W^r\rangle$ is determined by $(\lambda,\theta)$ exactly when at least two of $p,q,r$ are $\le1$.

**Nothing in the searched literature carries a name for $\mathop{\mathrm{tr}}(W^2\# W^2)$ or for $\sum_{ij}\lVert[Ae_i,Ae_j]\rVert^2$ with $A$ symmetric on a compact Lie algebra.** The nearest structurally similar object is Lauret's $\lVert\mu\rVert^2$ on the variety of Lie algebras ([arXiv:math/0206046](https://arxiv.org/abs/math/0206046)), where $GL(n)$ acts by $g\cdot\mu(x,y)=g\,\mu(g^{-1}x,g^{-1}y)$, the record's quantity is the same shape with the outer $g^{-1}$ dropped, so the moment-map theory there does **not** apply. Report this as a genuine negative: the quantity is unnamed.

## F4. The correction, the free degree-4 data is bigger than the record says

**The record's sharpness claim is sharp only inside its own family.** "Everything below it is pinned by (A), (B) or (C), and nothing on the record pins $\{2,2,0\}$" is right; "the first quantity a critical point carries that its spectrum and $\theta$ do not determine" overstates it, because the monomial family reaches only the invariants $\langle W^p\# W^q,W^r\rangle$, that is, only the **diagonal** entries of $W^\#$-type operators in $W$'s eigenbasis. Degree-4 invariants using the off-diagonal entries are outside the family entirely.

Two measurements at $n=6$, both on the isospectral set through a random unit $W\in\mathcal W_6$:

| measurement | result |
| --- | --- |
| $S_{22}$ at frozen spectrum ($\max\lvert\Delta\lambda\rvert=1.7\times10^{-9}$) | ranges over $[0.4633,\,0.6166]$ about a base value $0.5375$ |
| rank of $[1,\;S_{22},\;\lVert W^\#\rVert^2]$ over 7 isospectral points ($\max\lvert\Delta\lambda\rvert\le2.3\times10^{-7}$, $\mathop{\mathrm{tr}}W^4$ constant to $1.2\times10^{-7}$ relative) | **3**, singular values $3.05\,/\,0.055\,/\,0.032$ |

The first row **independently confirms the record's freeness claim**, $S_{22}$ is demonstrably not a function of the spectrum, which the record had only from the absence of a pinning relation. *[LIT-jacobi §5](LIT-jacobi.md) reaches the same conclusion analytically and better, by exhibiting the two nonnegative coordinates $\lVert\pi_{\Lambda^4}(W^2)\rVert^2$ and $\lVert\pi_{\mathrm{Sym}^2_0}(W^2)\rVert^2$ that carry all of $S_{22}$'s non-spectral content. The measurement here is a check on that, not a substitute.*

The second row is the part neither report had: $\lVert W^\#\rVert^2$ is a free degree-4 invariant that is **outside the $T$-family altogether**, so it is not among the coordinates either report reaches through $T$, though whether it is independent of LIT-jacobi's two norms is untested, and the measurement establishes only that the free degree-4 space has dimension at least $2$. In the eigenbasis it collects $(W^\#)_{ab}=\tfrac12\sum_{pq}c_{apq}c_{bpq}\lambda_p\lambda_q$ for $a\ne b$, and $T=c^2$ sees only $a=b$.

> **THE SCOPE OF THAT SECOND ROW IS $\mathcal W_n$ AT LARGE, AND IT COLLAPSES ON THE CRITICAL LOCUS.** The sampled tensors are random elements of $\mathcal W_6$, not critical points. At a critical point $W^\#=\theta W-W^2$, so $\lVert W^\#\rVert^2=\theta^2\lVert W\rVert^2-2\theta\mathop{\mathrm{tr}}W^3+\mathop{\mathrm{tr}}W^4$ is a function of $(\lambda,\theta)$, [routes.md](../routes.md) R14's circularity, applying here. **$S_{22}$ escapes it precisely because $W^2\#W^2$ is not a polynomial in $W$**, which is the structural reason the record's $\{2,2,0\}$ was the right thing to find. So the honest reading of the table is: the record's classification correctly identifies the free monomial, and the free space it sits in is larger than one dimension *off* the critical locus, while *on* it the LIT-jacobi pair remains the only named free data.

**The structural ceiling, and it is far above two.** For generic $W$ the $O(n)$-orbit in $\mathcal W_n$ has dimension $\tbinom n2$, so the number of independent invariants is $\dim\mathcal W_n-\tbinom n2$, of which the spectrum supplies $\tbinom n2$. At $n=6$: $84-15=69$ invariants, $15$ of them spectral, **$54$ free**. The record's $\{2,2,0\}$ is one direction in a 54-dimensional space of things the spectrum does not determine.

Degree by degree, the ambient count comes from [Weingart 2024](../references/graphical-calculus-stable-invariants-2024/notes.md), already on the shelf, whose §1 states the reduced graph algebra is free graded-commutative on $1,2,5,15,54,270,1639$ generators in degrees $1$ to $7$, so $\dim[\mathrm{Sym}^4(\mathrm{Curv}^-T)^*]^{O(T,g)}=26$ in the stable range, against two spectral quantities ($\mathop{\mathrm{tr}}W^4$ and $(\mathop{\mathrm{tr}}W^2)^2$) at that degree. Graph-side the same statement is the one the record's notes already quote: $17$ colored trivalent graphs with 8 vertices, exactly two relations, $15$ generators.

---

## The negatives, stated plainly so the next cycle does not re-search

- **The classification itself is not in the literature.** No source states, in any notation, that a $T$-moment is spectrum-determined exactly when two of its three exponents are $\le1$, nor identifies $\{2,2,0\}$ as a first free case. Searched: curvature-invariant bases, $O(n)$ invariant theory of $\mathrm{Sym}^2(\Lambda^2)$, homogeneous Einstein structure constants, Ricci-flow $\#$-calculus. **The corollary is elementary once (A) and (B) are in hand, contract a per-row identity against an arbitrary weight on the free index, then use total symmetry, which is probably why nobody wrote it down.**
- **There is no "spectrum determines the curvature operator" theorem to cite, in either direction.** [Coley–Hervik, arXiv:1002.0505](https://arxiv.org/abs/1002.0505) is the nearest hit and is a different question: whether a *pseudo-Riemannian manifold* is locally characterised by its scalar polynomial invariants, with the answer running through analytic metric extension. It says nothing about two algebraic curvature tensors sharing a spectrum. The dimension count in F4 is the honest substitute and it is rigorous.
- **Nothing new on critical points of $Q(R)=R^2+R^\#$.** Searches for the extremal problem returned only the material [references/](../references/INDEX.md) already holds, Böhm–Wilking, Wilking's Lie-algebraic cones, Richard's curvature cones, the second-kind family. **Conjecture A remains unaddressed in the literature.**
- **Weyl's first and second fundamental theorems add nothing here.** The record already holds the [polarization primer](../references/weyl-polarization-primer/notes.md), whose own conclusion is that restitution settles the trivial half and that the passage from $V^{\otimes4}$ to the Weyl subspace (which is where all the content is), is not a polarization statement. That verdict stands and this search found no route around it.
- **Fulling–King–Wybourne–Cummins is the right classical ancestor and I could not obtain it.** *Normal forms for tensor polynomials. I. The Riemann tensor*, Class. Quantum Grav. **9** (1992) 1151, note the author list is Fulling, King, Wybourne, Cummins, not Matschull. It gives a basis for scalar Riemann polynomials through order 8 in metric derivatives, which is degree 4 in $R$: exactly the degree where the record's free data starts. **It is behind a paywall and no folder was filed**; Weingart 2024 is its modern successor and is already read here, so the loss is small.
- **One unverified number, flagged rather than used.** Search snippets from the higher-curvature-gravity literature repeatedly assert "in generic dimension $D\ge8$ the basis of quartic curvature invariants has 7 elements", with "seven Weyl invariants from complete contractions of four Weyl tensors". Every PDF carrying the claim failed text extraction, so **it is recorded as unconfirmed and nothing above rests on it.** If a cycle wants it, the leads are [arXiv:2410.16097](https://arxiv.org/abs/2410.16097) and [arXiv:1703.11007](https://arxiv.org/abs/1703.11007). Note also that [Boulanger–Erdmenger, hep-th/0405228](https://arxiv.org/abs/hep-th/0405228) is a false lead, its "Weyl invariants" are conformally invariant densities including derivatives, a different object.

---

## What the programme should do with this

1. **Cite [LIT-jacobi §5](LIT-jacobi.md)'s isotypic law in [bounds.md](../findings/bounds.md), and Lemma 2.1 beside it for (A) and (B).** The law is the completeness argument the classification section is missing; Lemma 2.1 is the one-line source of the two relations the section actually writes down.
2. **Rewrite the free-data claim with its true scope.** $\{2,2,0\}$ is the first free member of the family $\langle W^p\# W^q,W^r\rangle$; the free space at degree 4 is at least two-dimensional and at $n=6$ the total free space is $54$-dimensional. The elimination test in [fence-posts.md](../findings/fence-posts.md) is unaffected (it screens weights, and every weight it admits or rejects is classified correctly) but the sentence "the first quantity a critical point carries that its spectrum and $\theta$ do not determine" should become "the first such quantity **in the monomial family**".
3. **Take $\lVert W^\#\rVert^2$ seriously as the next lever.** It is free, degree 4, manifestly nonnegative, and (unlike $S_{22}$), it is built from the off-diagonal entries of $W^\#$, which [bounds.md](../findings/bounds.md) already identifies as "the only place the Jacobi identity can enter a bound on $D$". The record's moment-problem closure says positivity and support of the $g$-distribution cannot leave the pinned class; $\lVert W^\#\rVert^2$ is outside the $g$-distribution altogether, so that closure does not reach it. **At a critical point $W^\#=\theta W-W^2$, so $\lVert W^\#\rVert^2=\theta^2\lVert W\rVert^2-2\theta\mathop{\mathrm{tr}}W^3+\mathop{\mathrm{tr}}W^4$ collapses to the spectrum**, which is the same trap [routes.md](../routes.md) R14 records, and it applies to $\lVert W^\#\rVert^2$ but *not* to $S_{22}$, whose $W^2\#W^2$ form is not a polynomial in $W$. **So the measurement above is about $\mathcal W_n$ at large; on the critical locus the useful free coordinate is still the LIT-jacobi pair.**
4. **Do not re-search this ground.** Items F1–F4 and the six negatives above are the yield; the classification is the record's own, and its best proof is LIT-jacobi's.

---

## Artefacts

| what | where |
| --- | --- |
| New source, filed with transcription | [references/bettiol-friedman-2025-counting-homogeneous-einstein/](../references/bettiol-friedman-2025-counting-homogeneous-einstein/notes.md) |
| Lemma 2.1 transcribed into an existing folder | [references/boehm-wilking-2008-space-forms/notes.md](../references/boehm-wilking-2008-space-forms/notes.md) |
| Degree-by-degree count added to an existing folder | [references/graphical-calculus-stable-invariants-2024/notes.md](../references/graphical-calculus-stable-invariants-2024/notes.md) |
| Index row and count | [references/INDEX.md](../references/INDEX.md) |
| Phase plan, heartbeats, every number above | [agent_logs/lit-invariants.log](../agent_logs/lit-invariants.log) |

All numerical checks were run at $n=6$ against $\mathcal W_6$ built by [weyl.py](../scripts/lib/weyl.py); the scripts are throwaway and live in the session scratchpad, with every figure reproduced in the log.
