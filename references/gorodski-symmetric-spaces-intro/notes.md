# Gorodski, *An Introduction to Riemannian Symmetric Spaces*, transcription

Extraction: `gorodski-symmetric-spaces.txt`, from `pdftotext -layout`. Line numbers below are that file's.

## The setting, quoted

An **OIL-algebra** (orthogonal involutive Lie algebra), quoted from the source rather than paraphrased, because an earlier version of this transcription dropped two clauses that its own proofs use (line 621):

> An abstract orthogonal involutive Lie algebra is a triple $(\mathfrak g,s,B)$, where $\mathfrak g$ is a real finite-dimensional Lie algebra, $s$ is an involutive automorphism of $\mathfrak g$, **the fixed point set $\mathfrak k$ of $s$ does not contain nontrivial ideals of $\mathfrak g$** and $B$ is an $\mathrm{ad}_{\mathfrak k}$-invariant **inner product** on the $-1$-eigenspace $\mathfrak p$ of $s$.

**Both emphasised clauses are load-bearing and were once missing here.** *The form is an INNER PRODUCT, so positive definite rather than merely nondegenerate. And the no-ideals-in-$\mathfrak k$ clause, effectiveness, is what turns $\mathfrak p_0=0$ into $\mathfrak g_0=0$: without it a lemma can prove the $-1$ eigenspace of a factor trivial and say nothing about the factor.* For a symmetric space $M$ at $x$ the same page gives the geometric origin: $\mathfrak k$ acts faithfully on $\mathfrak p$ since the isotropy representation of $K$ on $T_xM$ is faithful, and $B$ is an $\mathrm{Ad}_K$-invariant positive definite inner product on $\mathfrak p$.

Writing $\beta$ for the Killing form, from p. 20 (line 987):

> An OIL-algebra $(\mathfrak g,s,B)$ is called **Euclidean** if $[\mathfrak p,\mathfrak p]=0$, and it is called **irreducible** if it is not Euclidean and the adjoint representation of $\mathfrak k$ on $\mathfrak p$ is irreducible.

## The statements this project uses

> **Proposition 2.1.3 (Decomposition).** Let $(\mathfrak g,s,B)$ be an OIL-algebra. Then there is a decomposition
> $$\mathfrak g=\mathfrak g_0\oplus\mathfrak g_1\oplus\cdots\oplus\mathfrak g_r$$
> into a direct sum of ideals such that:
> a. each $\mathfrak g_i$ is $s$-invariant;
> b. $(\mathfrak g_0,s|_{\mathfrak g_0},B|_{\mathfrak p_0})$ is Euclidean;
> c. $(\mathfrak g_i,s|_{\mathfrak g_i},B|_{\mathfrak p_i})$ is irreducible for $i=1,\dots,r$.

*(p. 20, line 992. Proof at lines 1005 to 1022: $A:\mathfrak p\to\mathfrak p$ defined by $B(AX,Y)=\beta(X,Y)$ has real eigenvalues $\lambda_0=0,\lambda_1,\dots,\lambda_t$ with $B$-orthogonal eigenspaces, $\mathrm{ad}_{\mathfrak k}$ preserves each, and each $\mathfrak q_i$ with $i>0$ decomposes into $\mathrm{ad}_{\mathfrak k}$-irreducibles. **The whole argument is linear algebra on $\mathfrak p$ and carries no topological hypothesis.**)*

> **Proposition 3.1.2.** Let $M$ be a locally symmetric space, $x\in M$ and $X,Y,Z\in T_xM$. Then
> $$(3.1.3)\qquad R_x(X,Y)Z=-[[X,Y],Z]_x,$$
> where on the right-hand side we use the infinitesimal transvection induced by the corresponding tangent vector.

*(p. 42, line 2213 region. Sign convention fixed at line 2122 as $R(X,Y)Z=\nabla_X\nabla_YZ-\nabla_Y\nabla_XZ-\nabla_{[X,Y]}Z$. **The hypothesis is LOCALLY symmetric**, so neither completeness nor simple connectivity nor compactness enters.)*

> **Corollary 2.1.5.** If $\mathfrak g$ is simple then $(\mathfrak g,s,B)$ is irreducible. If $(\mathfrak g,s,B)$ is irreducible then $\mathfrak k$ is a maximal subalgebra of $\mathfrak g$ and its own normalizer in $\mathfrak g$. $\mathfrak g$ is semisimple if and only if $(\mathfrak g,s,B)$ has no Euclidean factor.

*(line 1034.)*

> **Remark 2.1.6.** With just a little bit more work one can show that the decomposition in Proposition 2.1.3 is unique, up to permutation of the simple factors.

*(line 1038.)*

## The geometric form, stated in the introduction rather than as a numbered theorem

> The universal covering of a symmetric space is also a symmetric space. Every simply-connected symmetric space is a Riemannian product of irreducible symmetric spaces. The nonflat irreducible symmetric spaces are separated into compact type and non-compact type, which are interchanged by Cartan duality.

*(p. 1, line 45. **This is prose in the introduction and carries no theorem number**, which is why this project takes the algebraic pair 2.1.3 and 3.1.2 instead: the geometric statement needs simple connectivity and would oblige a universal-cover step and a compactness step, where the algebraic one obliges neither.)*

Also recorded, for the type vocabulary: an OIL-algebra is **of compact type** (resp. noncompact type) according to the sign of the Killing form on $\mathfrak p$, and a symmetric space is of that type when its OIL-algebra is (lines 1194 to 1197).

## What each proof cites

Proposition 2.1.3 cites only its own Lemma 2.1.2 (on $\beta$-orthogonality of ideals). Proposition 3.1.2 cites the Jacobi-field characterisation of Killing fields along a geodesic. **Neither reaches outside the notes**, so the citation graph stops here and no further source is needed for the reduction.

## Not transcribed

The classification tables, Cartan duality, the rank and root-system material, and the totally geodesic submanifold theory of §3.2 onward. **The noncompact-type material is NO LONGER excluded**, an earlier version of this line having excluded it while [Lemma L211](../../findings/problem.md) went on to cite two statements from it, which both Gate 2 readers of that lemma caught. *The two are transcribed below.*

## The statements an earlier version of these notes omitted, each now used by [Lemma L210](../../findings/problem.md)

> **(2.1.4)** $[\mathfrak p_i,\mathfrak p_j]=0$ for $i,j>0$, $i\ne j$, and $[\mathfrak p_0,\mathfrak p]=0$.

*(line 1023, inside the proof of 2.1.3. **The second clause is strictly stronger than the Euclidean condition $[\mathfrak p_0,\mathfrak p_0]=0$** and shortens the Euclidean-factor step: $\mathfrak p_0$ brackets trivially against ALL of $\mathfrak p$, not only against itself.)*

> **Lemma 2.1.2.** Denote by $\beta$ the Killing form of $\mathfrak g$. Then: a. $\beta(\mathfrak k,\mathfrak p)=0$; b. $\beta|_{\mathfrak k}$ is negative-definite; c. if $\mathfrak a$ and $\mathfrak b$ are $\beta$-orthogonal subspaces of $\mathfrak p$ and $\mathfrak b$ is $\mathrm{ad}_{\mathfrak k}$-invariant then $[\mathfrak a,\mathfrak b]=0$.

*(line 963. (c) is the mechanism behind (2.1.4), and (b) is what fixes the SIGN of curvature on a factor.)*

> **Corollary 3.1.4.** Let $M$ be an irreducible locally symmetric space, $x\in M$, and consider the OIL-algebra $(\mathfrak g,s,B)$ at $x$. Recall that $B=\lambda\beta|_{\mathfrak p\times\mathfrak p}$ for some $\lambda\ne0$, where $\beta$ is the Killing form of $\mathfrak g$. Then the sectional curvature of the 2-plane spanned by an orthonormal pair $X,Y\in T_xM\cong\mathfrak p$ is given by
> $$K(X,Y)=\lambda\beta([X,Y],[X,Y]).$$

*(p. 43. **This is what pins the TYPE of an irreducible factor.** With $[X,Y]\in\mathfrak k$ and Lemma 2.1.2(b) giving $\beta|_{\mathfrak k}$ negative definite, $K$ has one sign throughout, opposite to that of $\lambda$. So each irreducible factor is of a single type, and a global Einstein condition with one constant forces the same type on every factor at once.)*

## The noncompact-type statements, cited by [Lemma L211](../../findings/problem.md)

> **Corollary 2.4.7.** A symmetric space of noncompact type is simply-connected, and the isotropy subgroup of its transvection group at a point is connected and a maximal compact subgroup.

*(line 1624. **The maximal-compact clause is what L211's last step needs**, and the hypothesis is noncompact type, which that step has as its contradiction hypothesis rather than as an assumption.)*

> **Corollary 5.5.2.** A semisimple Lie algebra is compact if and only if its Killing form is negative definite.

*(line 3172. **Section 5.5 DEFINES a compact Lie algebra as the Lie algebra of a compact group**, so the passage from the algebra to the group is a definition here rather than a theorem, and no question of centres or coverings arises.)*

## The compact-type statements, which carry each factor's own compactness

**These are what the symmetric-space Theorem still owes**: [Lemma L211](../../findings/problem.md) delivers compact *type* for every irreducible factor, while [L47](../../findings/problem.md)'s census is of compact spaces, so the passage from type to compactness needs stating. *All three statements below are the source's, and the argument they compose is written in [problem.md](../../findings/problem.md) rather than here.*

> **Theorem 5.5.1.** Let $\mathfrak g$ be a Lie algebra. The following assertions are equivalent: a. $\mathfrak g$ is a compact Lie algebra; b. $\mathrm{Inn}(\mathfrak g)$ is compact; c. $\mathfrak g$ admits an $\mathrm{ad}$-invariant positive definite inner product; d. $\mathfrak g=\mathfrak z\oplus[\mathfrak g,\mathfrak g]$ where $\mathfrak z$ is the centre and $[\mathfrak g,\mathfrak g]$ is semisimple with negative definite Killing form.

*(line 3138. **Clause (b) is the one that reaches a group**, and it is what turns a statement about the algebra into compactness of the transvection group. Clause (d) is why a centre costs nothing: it splits off as an ideal.)*

> **Proposition 2.2.1.** Let $(\mathfrak g,s,B)$ be an OIL-algebra. Then: a. if $(\mathfrak g,s,B)=\sum_{i=0}^r(\mathfrak g_i,s_i,B_i)$ is the decomposition of Proposition 2.1.3, then $(\mathfrak g,s,B)^*=\sum_{i=0}^r(\mathfrak g_i,s_i,B_i)^*$ is the corresponding decomposition; b. if $(\mathfrak g,s,B)$ is irreducible, then precisely one of $\mathfrak g$, $\mathfrak g^*$ is compact.

*(line 1072. **The proof of (b) is the identification the type vocabulary hides**: with $\beta$ negative definite on $\mathfrak k$ by Lemma 2.1.2(b) and $\beta(\mathfrak k,\mathfrak p)=0$, the sign of $\beta$ on $\mathfrak p$ decides the sign on all of $\mathfrak g$, so **compact type is exactly $\mathfrak g$ being a compact Lie algebra** rather than a separate condition. Cartan duality flips $\lambda$, which is why precisely one of the pair is compact.)*

> **Section 5.5, the definition.** A Lie algebra $\mathfrak g$ is called **compact** if there exists a compact Lie group whose Lie algebra is isomorphic to $\mathfrak g$.

*(line 3135, quoted because the word carries two readings in this record and the source's is this one.)*

## Section 1.5, Myers--Steenrod and the presentation, which [Lemma L213](../../findings/problem.md)'s step 4 needs

**Transcribed 2026-09-13 after Gate 2 found step 4 reaching for the wrong group** ([r924](../../reviews/REVIEW_r924.md), [r925](../../reviews/REVIEW_r925.md), independently). *The block had gone through $\mathrm{Inn}(\mathfrak g_i)$, and $\mathrm{Inn}(\mathfrak g_i)=G_i/Z(G_i)$, so a compact $\mathrm{Inn}$ gives a compact $G_i$ only when the centre is finite. These two statements avoid the detour: they present $M_i$ as $G_i/K_i$ with $K_i$ compact, which is exactly what [Ziller](../ziller-2010-lie-groups-symmetric-spaces/notes.md)'s Proposition 6.38(c) requires of a symmetric pair.*

> **Section 1.5, Myers--Steenrod.** The isometry group $G$ of a Riemannian manifold $M$, equipped with the compact-open topology, has a natural structure of Lie group such that the action of $G$ on $M$ is smooth and represents its Lie algebra $\mathfrak g$ as the Lie algebra of Killing vector fields on $M$. Convergence of a sequence of isometries in $G$ in the compact-open topology is equivalent to pointwise convergence in $M$. **Finally, the isotropy group $G_x$ at a point $x\in M$ is compact.**

*(line 561. **The last sentence is the one the record lacked**, and [Corollary 2.4.7](#the-noncompact-type-statements-cited-by-lemma-l211), the record's only other isotropy-compactness statement, is for noncompact type alone.)*

> **Proposition 1.5.1.** Let $M$ be a globally symmetric space with Lie group of isometries $G$. Fix $x\in M$, write $K$ for the isotropy group at $x$, and $P$ for the set of transvections at $x$. Also denote by $\mathfrak g$ and $\mathfrak k$ the Lie algebras of $G$, $K$, and by $\mathfrak p$ the set of infinitesimal transvections at $x$. Then: (i) $M=G/K$ and $G=KP=PK$; (ii) $s=\mathrm{Ad}\,s_x$ defines an involutive automorphism of $\mathfrak g$, and $\mathfrak g=\mathfrak k+\mathfrak p$ is the $\pm1$-eigenspace decomposition.

*(line 569. **Clause (i) is the presentation** and clause (ii) is the spanning $\mathfrak g=\mathfrak k+\mathfrak p$ that the typed definiteness step takes as a binder. Both need $M$ GLOBALLY symmetric, which is where L213's inventory was wrong to say global symmetry is spent only inside [L211](../../findings/problem.md).)*
