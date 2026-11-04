# Notes, Ziller, *Lie Groups. Representation Theory and Symmetric Spaces* (§1.6, §2.1, §4.5, §4.6 and Ch. 6 read; the rest skimmed)

Stored 2026-09-07. [ziller-lie-groups-reps.pdf](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf), [ziller-lie-groups-reps.txt](https://www2.math.upenn.edu/~wziller/math650/LieGroupsReps.pdf) (`pdftotext -layout`, 178 pages). Extraction is clean apart from the Dynkin diagrams, which come out as ASCII-art `◦`/`h` glyphs.

## Proposition 4.43, verbatim (p. 80)

> "Let $K$ be a compact semisimple simply connected Lie group and $\mathfrak g=\mathfrak k^{\mathbb C}$ with Dynkin diagram $D(\mathfrak g)$. Then
> $$\mathrm{Aut}(K)/\mathrm{Int}(K)\simeq\mathrm{Aut}(\mathfrak k)/\mathrm{Int}(\mathfrak k)\simeq\mathrm{Aut}(\mathfrak g)/\mathrm{Int}(\mathfrak g)\simeq\mathrm{Sym}(D(\mathfrak g))$$
> where $\mathrm{Sym}(D(\mathfrak g))$ is the group of symmetries of the Dynkin diagram."

The proof is complete in the source, resting on Lemma 4.44 (an automorphism restricting to the identity on a Cartan subalgebra is $e^{\mathrm{ad}X}$ for some $X$ in it).

## Example 4.45, verbatim (p. 81), the orthogonal cases

> "The Dynkin diagrams $B_n$, $C_n$, $G_2$, $F_4$, $E_7$, $E_8$ have no symmetries and hence for these Lie algebras and corresponding compact groups, every automorphism is inner. For $A_n=\mathfrak{sl}(n,\mathbb C)$ there is one outer automorphism, up to inner ones, given by $\varphi(A)=\bar A$, and the same for $SU(n)$. For $\mathfrak{so}(2n,\mathbb C)$ or $SO(2n,\mathbb R)$ we can choose conjugation with $\mathrm{diag}(-1,1,\dots,1)$ to represent the outer automorphism. Most interesting is the diagram for $\mathfrak{so}(8,\mathbb C)$: [the $D_4$ diagram] which has the permutation group $S_3$ as its symmetry group. Rotation by 180 degrees gives rise to so called triality automorphisms, which we will discuss in a later section."

Two readings the record's caveat needs, both printed:

- **Odd $n$.** Type $B_n$ is $\mathfrak{so}(2n+1)$ and has no diagram symmetry, so $\mathrm{Aut}=\mathrm{Int}$ there. The distinction the record warns about is vacuous at odd $n$.
- **Even $n\ne8$.** The one outer class of $\mathfrak{so}(2n)$ is represented by conjugation with an element of $O(2n)$ of determinant $-1$. Exercise 2.5(2) (p. 23) makes the membership explicit: *"Let $g=\mathrm{diag}(-1,1,\dots,1)$. Clearly $g$ lies in $O(n)$ but not in $SO(n)$. Show that $\mathrm{Ad}(g)$ lies in $\mathrm{Aut}(\mathfrak{so}(n))$ but not in $\mathrm{Int}(\mathfrak{so}(n))$."*
- **$n=8$.** $\mathrm{Sym}(D_4)=S_3$, strictly larger than the $\mathbb Z_2$ that $O(8)$-conjugation realises.

## What the triality remark in §4.5 turns into

Remark 4.55 (p. 88) is the only other place the notes touch $\mathfrak{so}(8)$'s exceptionality, and it is about groups rather than involutions:

> "for $n>4$, there exists only one outer automorphism $A$ of $\mathrm{Spin}(n)$, and it descends to an outer automorphism of $SO(4n)$ as well. … Notice though that $SO(8)\simeq SO_0(8)$ due to the triality automorphism."

The promised later section on triality **does not appear** in this version of the notes: `triality` occurs exactly twice in the whole extraction, at Example 4.45 and Remark 4.55. So Ziller supplies the group-theoretic *statement* that $D_4$'s outer group is $S_3$ and no construction of the triality automorphisms themselves, for that, see [yokota-2009-exceptional-lie-groups](../yokota-2009-exceptional-lie-groups/) Theorem 1.3.5.

## What the source does not cover

- **No table of symmetric pairs.** Chapter 6 develops symmetric spaces (Cartan involutions §6.2, examples §6.3, duality §6.5) but stops before any classification list. §6.6 opens by saying *"the classification of symmetric spaces is easier for the one's of compact type, and by duality implies the classification of symmetric spaces of non-compact type"* and then studies the non-compact geometry instead of listing anything. So this source does **not** carry fact 1 or fact 3; use [holland-ion-2012-symmetric-spaces](../holland-ion-2012-symmetric-spaces/) for those.
- **No conjugacy statement about involutions.** Proposition 4.43 is about the automorphism group as a whole. Reading it as "$\mathrm{Aut}$-conjugacy of involutions is $O(n)$-conjugacy for $n\ne8$" is a step past what is printed, and this folder does not license it.
- **The notes are a working draft.** Exercise 4.46(1) reads *"Show that the real forms of $o(n,\mathbb C)$ are …. and those of $\mathfrak{sp}(n,\mathbb C)$ are ….",* with the lists left unfilled, a reminder to check any quotation against the page rather than the surrounding narrative.

## Proposition 6.38, verbatim (p. 158), which carries the compactness of each factor

**This is the statement [I91](../../plan.md) needs, and it was on this shelf before the item opened.** *[Gorodski](../gorodski-symmetric-spaces-intro/notes.md) defines compact type and never states that a space of compact type is compact, so the clause [Lemma L211](../../findings/problem.md) leaves owed against the symmetric-space Theorem is a citation here rather than a derivation.*

> **Definition 6.37.** Let $(G,K)$ be a symmetric pair with $B$ the Killing form of $\mathfrak g$. The symmetric pair is called **of compact type** if $B|_{\mathfrak p}<0$, **of non-compact type** if $B|_{\mathfrak p}>0$ and **of euclidean type** if $B|_{\mathfrak p}=0$.

> **Proposition 6.38.** Let $(G,K)$ be a symmetric pair. (a) If $(G,K)$ is irreducible, it is either of compact type, non-compact type or euclidean type. (b) If $M=G/K$ is simply connected, then $M$ is isometric to a Riemannian product $M=M_0\times M_1\times M_2$ with $M_0$ of euclidean type, $M_1$ of compact type and $M_2$ of non-compact type. (c) If $(G,K)$ is of compact type, then $G$ is semisimple and $G$ and $M$ are compact. (d) If $(G,K)$ is of non-compact type, then $G$ is semisimple and $G$ and $M$ are non-compact. (e) $(G,K)$ is of euclidean type iff $[\mathfrak p,\mathfrak p]=0$. Furthermore, if $G/K$ is simply connected, it is isometric to $\mathbb R^n$.

*(txt line 6893. **Clause (c) is the whole of what the Theorem owed**, and its proof is four lines: $d\sigma$ preserves $B$ and inverts $\mathfrak p$, so $B(\mathfrak k,\mathfrak p)=0$; $K$ compact gives an inner product making $\mathrm{ad}_X$ skew for $X\in\mathfrak k$, so $B(X,X)=\mathop{\mathrm{tr}}\mathrm{ad}_X^2\le0$ with equality only on the centre, and $\mathfrak z(\mathfrak g)\cap\mathfrak k=0$ **because $\mathfrak g$ and $\mathfrak k$ share no ideal**, which is the effectiveness clause of the OIL definition; hence $B|_{\mathfrak k}<0$, so compact type gives $B<0$ on all of $\mathfrak g$ and $G$, with it $M$, is compact.)*

**What its hypotheses require of an application.** *$(G,K)$ must be a symmetric PAIR in this source's sense, so $K$ compact and $\mathfrak g,\mathfrak k$ sharing no ideal. Clause (b) is stated for $M$ simply connected, which is where the de Rham factors of a universal cover come from, and clause (c) needs no simple connectivity at all.*

## Definition 6.31, the symmetric pair, which is 6.38(c)'s subject

**Transcribed 2026-09-13 because Gate 2 asked what 6.38(c) requires of the object it is applied to** ([r925](../../reviews/REVIEW_r925.md)). *The answer is $K$ compact, which the record supplied nowhere until [Gorodski](../gorodski-symmetric-spaces-intro/notes.md)'s section 1.5 was transcribed.*

> **Definition 6.31.** A **symmetric pair** is a pair $(G,K)$ where $G$ is a connected Lie group, $K\subset G$ a **compact** subgroup, and $\sigma$ an involutive automorphism of $G$ with $(G^\sigma)_0\subset K\subset G^\sigma$, the metric on $M=G/K$ being $G$-invariant.

*(txt line 6748, read at source. **So 6.38(c) is applicable exactly when $K$ is compact and $\mathfrak g,\mathfrak k$ share no ideal**, the second being the effectiveness clause the OIL definition already carries.)*

**AND ITS PRINTED PROOF ELIDES THE GROUP STEP.** *Ziller writes "then $B<0$ and hence $G$, and thus also $M$, is compact", which is the passage a compact Killing form gives a compact GROUP, needing Weyl's finiteness of the centre. So the record cites 6.38(c) as a published statement and does not rebuild it: the reconstruction is what both Gate 2 readers found unargued* ([r924](../../reviews/REVIEW_r924.md), [r925](../../reviews/REVIEW_r925.md)).
