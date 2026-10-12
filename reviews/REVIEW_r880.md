# Review r880: the $\kappa=1$ three-line theorem, and the $a=6$ symmetric ansatz at $n=6$

**Reviewer r880, cold, 2026-09-12. Analysis only: no search, sweep or census was run, and every value below is exact and hand-derived.** The three-line theorem is valid and its conclusion is right, but it runs on a hypothesis the block never states, namely that the positive eigenspace has an *orthonormal basis of decomposable* forms. The case is not vacuous: a closed-form witness exists at every even $n\ge4$, and the theorem's real content is that this witness is the only solution. On the item said to settle $n=6$, the Gram spectrum is exactly as claimed, and I can now show constructively why the Gram matrix cannot decide the question: the six icosahedral complex lines in $\mathbb C^3=\mathbb R^6$ realise the whole $t_{\alpha\beta}=2/5$ Gram datum, with $\sum_\alpha\Pi_\alpha=2\,\mathrm{Id}_6$ and even $\Theta(A)=2\,\mathrm{Id}_6$, and fail the ansatz only in the $\Lambda^2$-orthonormality.

## Claim table

| # | Claim as put to me | Verdict | Basis |
|---|---|---|---|
| 1 | $\sum_{\alpha\in A}\Pi_\alpha=\mathrm{Id}_n$ at $a=n/2$ | **Correct** | Given 4 at $\kappa=2a/n=1$, rederived in §1 |
| 1 | Multiplying by $\Pi_\alpha$ gives $\sum_{\beta\ne\alpha}\Pi_\alpha\Pi_\beta=0$ | **Correct, but needs idempotence** | §1. Idempotence is decomposability of $\omega_\alpha$, never stated in the block |
| 1 | $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\lVert\Pi_\alpha\Pi_\beta\rVert_F^2$ | **Correct** | $\operatorname{tr}(QPPQ)=\operatorname{tr}(PQ^2)=\operatorname{tr}(PQ)$, §1 |
| 1 | Nonnegativity forces every product to vanish | **Correct** | A Frobenius norm of zero is a zero matrix, §1 |
| 2 | Mutual orthogonality plus $\sum\Pi_\alpha=\mathrm{Id}$ gives a frame with $\omega_\alpha=f_{2\alpha-1}\wedge f_{2\alpha}$ | **Correct**, sign immaterial | §2 |
| 3 | $W=\lambda_-\mathrm{Id}+(\lambda_+-\lambda_-)\Pi_A$ and $W$ coordinate-diagonal | **Correct**, notation hazardous | §3. $\mathrm{Id}$ there is $\mathrm{Id}_{\Lambda^2}$, not $\mathrm{Id}_n$ |
| 3 | Headline "the $\kappa=1$ case is closed affirmatively at every even $n$" | **Overclaim as written** | §1.4. True of configurations with a decomposable orthonormal eigenbasis of $A$, which is a proper subclass |
| 4 | (Attack) is the theorem vacuous | **No, and the witness is unique up to $O(n)$** | §4, closed-form witness at every even $n\ge4$ |
| 5 | The $n=6$ chain leaves only $a=3$ and $a=6$ | **Arithmetic correct, scope understated** | §5. $a=5,7,8,10$ survive the rank count and die only to a *coordinate*-only divisibility |
| 6 | Each plane's total overlap is exactly $2$ at $a=6$, $\kappa=2$ | **Correct**, and it is the $\kappa$-general identity $2(\kappa-1)$ | §6 |
| 7 | Coordinate solutions at $a=6$ are the $2$-regular graphs on six vertices, exactly $C_6$ and $C_3+C_3$ | **Correct**, both satisfy every constraint | §7 |
| 8 | Gram spectrum of $t_{\alpha\beta}=2/5$ is $4$ and $8/5$ with multiplicity five | **Correct, exactly** | §8.1 |
| 8 | PSD-ness of the Gram matrix is insufficient to realise it by planes | **Correct, and now proved constructively** | §8.2, the icosahedral realisation |
| 8 | Item 8 "would settle $n=6$" | **Overclaim** | §8.5. It settles the symmetric candidate, not the non-symmetric $t$-patterns |
| 9 | The complex-line exclusion | **Correct, and narrower than it sounds** | §9. It bites only on pairs complex for one *fixed* $J$, and only when $t>0$ |

**One line.** Every computational step in the quoted block checks out, the case is non-vacuous with a unique witness, and the two live defects are an unstated decomposability hypothesis carrying the headline further than the proof and, at $a=6$, a symmetric ansatz that the Gram matrix provably cannot decide.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector, the inner product being $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- The norm on a four-index tensor is $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$.
- $(\omega\wedge\omega)_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$, twice the Pfaffian.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $\lVert W\rVert^2=\operatorname{tr}(W^2)$.

Two consistency checks I ran on these before using them, because the whole audit rests on them. With $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$ we get $e_a\wedge e_b=E_{ba}-E_{ab}=\varphi_{ab}$, and $\tfrac12\operatorname{tr}(\varphi_{ab}^{\mathsf T}\varphi_{ab})=1$, so the two normalisations in the brief agree. Setting $R_{ijkl}=\langle W(e_i\wedge e_j),e_k\wedge e_l\rangle$ and $W=\mathrm{Id}_{\Lambda^2}$ gives $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$, whence $\tfrac14\sum R_{ijkl}^2=\tfrac14(2n^2-2n)=\binom n2=\operatorname{tr}(\mathrm{Id}^2)$, so the four-index norm and the operator norm agree. Everything below uses this $R_{ijkl}$.

## Hypothesis inventory for the quoted block

| Hypothesis | Stated in the block | Used | Where |
|---|---|---|---|
| $W\in\mathcal W_n$, spectrum takes two values | Yes | Yes | Given 4, §3 |
| $a=\dim A=n/2$, so $n$ is even and $n\ge4$ | Yes | Yes | §1.1 |
| $A$ has an orthonormal basis $\{\omega_\alpha\}$ | Implicitly, via given 4 | Yes | §1.2, §2 |
| **Each $\omega_\alpha$, $\alpha\in A$, is decomposable** | **No** | **Yes, twice** | §1.2 for idempotence, §2 for the planes |
| First Bianchi | Named in $\mathcal W_n$, never invoked | Not needed | §3.3 shows why it is free here |

The fourth row is the finding of §1.

## 1. The three-line theorem, rederived

### 1.1 Isotropy at $a=n/2$

Ricci-flatness in the form of given 3, applied to the two-value spectrum, is $\lambda_+\Theta(A)+\lambda_-\Theta(B)=0$ with $B=A^\perp$. Additivity and the total value in given 1 give $\Theta(A)+\Theta(B)=(n-1)\mathrm{Id}_n$, so $(\lambda_+-\lambda_-)\Theta(A)=-\lambda_-(n-1)\mathrm{Id}_n$. The eigenvalues are distinct and both nonzero, the latter because trace-freeness $a\lambda_++(N-a)\lambda_-=0$ turns $\lambda_-=0$ into $\lambda_+=0$. Hence $\Theta(A)=\kappa\,\mathrm{Id}_n$, and taking the trace against $\operatorname{tr}\Theta(A)=2a$ gives $\kappa=2a/n$. At $a=n/2$ this is $\kappa=1$. **The first step is correct.**

Worth recording: this derivation never uses decomposability. What it delivers is $\sum_{\alpha\in A}\omega_\alpha\omega_\alpha^{\mathsf T}=\mathrm{Id}_n$. The block writes that sum as $\sum_{\alpha\in A}\Pi_\alpha$, which silently upgrades each $\omega_\alpha\omega_\alpha^{\mathsf T}$ into a plane projection. That upgrade is given 2 and holds only for decomposable $\omega_\alpha$.

### 1.2 Multiplying by $\Pi_\alpha$

For $\alpha\in A$, multiply $\sum_{\beta\in A}\Pi_\beta=\mathrm{Id}_n$ by $\Pi_\alpha$:
$$\Pi_\alpha=\Pi_\alpha\sum_{\beta\in A}\Pi_\beta=\Pi_\alpha^2+\sum_{\beta\ne\alpha}\Pi_\alpha\Pi_\beta=\Pi_\alpha+\sum_{\beta\ne\alpha}\Pi_\alpha\Pi_\beta,$$
so $\sum_{\beta\ne\alpha}\Pi_\alpha\Pi_\beta=0$. **The step is correct, and it turns entirely on $\Pi_\alpha^2=\Pi_\alpha$.** For a non-decomposable unit $\omega$, $\omega\omega^{\mathsf T}$ is a positive semidefinite matrix of trace $2$ and rank up to $n$, and it is idempotent only in the decomposable case, where given 2 makes it $\Pi_P$. So the step imports decomposability. This is the defect: the block presents the argument as needing nothing beyond isotropy, and it needs one more hypothesis than it states.

### 1.3 The trace, and vanishing

For orthogonal projections $P,Q$,
$$\lVert PQ\rVert_F^2=\operatorname{tr}\big((PQ)^{\mathsf T}PQ\big)=\operatorname{tr}(QP^2Q)=\operatorname{tr}(QPQ)=\operatorname{tr}(PQ^2)=\operatorname{tr}(PQ),$$
using symmetry and idempotence of both. **So the identity the block asserts is correct.** Tracing $\sum_{\beta\ne\alpha}\Pi_\alpha\Pi_\beta=0$ then gives $\sum_{\beta\ne\alpha}\lVert\Pi_\alpha\Pi_\beta\rVert_F^2=0$, a sum of nonnegative reals, so every term is zero, and a matrix of zero Frobenius norm is the zero matrix. Hence $\Pi_\alpha\Pi_\beta=0$ for all $\alpha\ne\beta$ in $A$, which is mutual orthogonality of the planes. **Nonnegativity is enough, and the inference is not merely to $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=0$ but to $\Pi_\alpha\Pi_\beta=0$, exactly because the trace *is* the squared norm.** Given 6 gives the same conclusion by a second route: $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\cos^2\vartheta$ vanishes precisely when the planes are mutually orthogonal.

### 1.4 What the three lines prove, and what the headline says

Proved: *a two-eigenvalue Ricci-flat trace-free symmetric operator on $\Lambda^2\mathbb R^n$ whose positive eigenspace $A$ of dimension $n/2$ admits an orthonormal basis of decomposable forms is coordinate-diagonal, for the frame those planes induce.* The headline "THE $\kappa=1$ CASE IS CLOSED AFFIRMATIVELY AT EVERY EVEN $n$, IN THREE LINES" asserts more, since the $\kappa=1$ case as given 4 defines it places no decomposability demand on the eigenbasis. The correction is one clause in the statement, and the three lines survive it intact.

The closing italic, "no dimension count, no divisibility and no rank argument enters", is right in substance. One nuance: the divisibility $n\mid 2a$ of given 4 is not absent, it is automatic, since $2a=n$.

## 2. From mutual orthogonality to a frame

The $\Pi_\alpha$, $\alpha\in A$, are now pairwise orthogonal idempotents summing to $\mathrm{Id}_n$, so $\mathbb R^n=\bigoplus_{\alpha\in A}P_\alpha$ is an orthogonal direct sum. The dimension count is consistent and does not need to be assumed: $\sum_\alpha\operatorname{tr}\Pi_\alpha=2\cdot(n/2)=n=\operatorname{tr}\mathrm{Id}_n$. **So yes, they span $\mathbb R^n$ orthogonally.**

Choosing an orthonormal basis $f_{2\alpha-1},f_{2\alpha}$ of each $P_\alpha$ concatenates to an orthonormal frame of $\mathbb R^n$. On the sign: the unit decomposable forms with plane $P_\alpha$ are exactly $\pm f_{2\alpha-1}\wedge f_{2\alpha}$, since $\Lambda^2 P_\alpha$ is one-dimensional and the form is unit. So $\omega_\alpha=\varepsilon_\alpha f_{2\alpha-1}\wedge f_{2\alpha}$ with $\varepsilon_\alpha\in\{\pm1\}$, and the block's unsigned equality is reached by swapping the two basis vectors in any plane where $\varepsilon_\alpha=-1$. **The sign is fixable, and it is also irrelevant, because $W$ depends on $\omega_\alpha$ only through $\omega_\alpha\otimes\omega_\alpha$.** No defect.

## 3. From $\Pi_A$ to $W$

### 3.1 The spectral form

With spectrum $\lambda_+$ on $A$ and $\lambda_-$ on $A^\perp$, the spectral theorem gives $W=\lambda_+\Pi_A+\lambda_-(\mathrm{Id}_{\Lambda^2}-\Pi_A)=\lambda_-\mathrm{Id}_{\Lambda^2}+(\lambda_+-\lambda_-)\Pi_A$. **Correct.** The two eigenvalues are themselves determined up to scale by $a$ and $N=\binom n2$ through trace-freeness, so on the unit sphere $W$ is determined by $A$ alone, as the block says. At $a=n/2$,
$$\frac{\lambda_+}{\lambda_-}=-\frac{N-a}{a}=-\frac{\tfrac12 n(n-1)-\tfrac12 n}{\tfrac12 n}=-(n-2).$$

### 3.2 The notation collision, which is real

The block uses $\Pi$ for two different objects inside four lines. In "$\sum_{\alpha\in A}\Pi_\alpha=\mathrm{Id}_n$" and "$\Pi_\alpha\Pi_\beta$", $\Pi$ is an $n\times n$ projection onto a plane of $\mathbb R^n$. In "$(\lambda_+-\lambda_-)\Pi_A$", $\Pi_A$ is an $N\times N$ projection onto a subspace of $\Lambda^2\mathbb R^n$, and the accompanying $\mathrm{Id}$ is $\mathrm{Id}_{\Lambda^2}$, not the $\mathrm{Id}_n$ of the isotropy line two clauses earlier. The mathematics is right and the reader has to supply the disambiguation. **Presentational defect, not an error: the two subscripts should be typographically distinguished, and the $\mathrm{Id}$ in the spectral form should carry its $\Lambda^2$ subscript.**

### 3.3 Does $\Pi_A$ diagonal make $W$ coordinate-diagonal

Yes. The frame $\{f_i\}$ of §2 induces the orthonormal basis $\{f_i\wedge f_j\}_{i<j}$ of $\Lambda^2\mathbb R^n$. The $n/2$ forms $f_{2\alpha-1}\wedge f_{2\alpha}$ lie in $A$ and are eigenvectors with $\lambda_+$. Every other $f_i\wedge f_j$ is orthogonal to all of them, and they span $A$, so every other $f_i\wedge f_j$ lies in $A^\perp$ and is an eigenvector with $\lambda_-$. So the whole induced basis is an eigenbasis and $W$ is diagonal in it. **Correct.**

A fact the block leaves implicit and which is worth adding to the record, because it is what makes the case cheap. **A symmetric operator $W=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$ over an orthonormal eigenbasis of *decomposable* forms satisfies first Bianchi automatically.** The Bianchi component of $\omega\otimes\eta$ is the total antisymmetrisation of $\omega_{ij}\eta_{kl}$, proportional to $\omega\wedge\eta$, so $b(W)\propto\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$, each term vanishing by Plücker. Equivalently, in the coordinate case $R_{ijkl}=0$ whenever $\{i,j\}\ne\{k,l\}$, so the antisymmetrisation over four distinct indices has nothing to act on. So the block's silence about Bianchi is harmless *given* decomposability, and §8.3 shows it stops being harmless the moment decomposability of the orthonormal basis is dropped.

## 4. Is the theorem vacuous? No, and the witness is unique

**Witness, in closed form, at every even $n=2m\ge4$.** Take the frame $e_1,\dots,e_n$, the perfect matching $P_\alpha=\operatorname{span}\{e_{2\alpha-1},e_{2\alpha}\}$ for $\alpha=1,\dots,m$, and $A=\operatorname{span}\{\omega_\alpha=e_{2\alpha-1}\wedge e_{2\alpha}\}$. Define $W$ by $\mu_{ij}=n-2$ on the $m$ matched pairs and $\mu_{ij}=-1$ on the remaining $N-m$ pairs, diagonal in $\{e_i\wedge e_j\}$.

- **Symmetric on $\Lambda^2$**: diagonal in an orthonormal basis.
- **Two eigenvalues**: $\lambda_+=n-2$ and $\lambda_-=-1$ are distinct for $n\ge4$, with $a=m=n/2$.
- **Ricci-flat**: by given 3 the condition is $\sum_{i<j}\mu_{ij}(e_ie_i^{\mathsf T}+e_je_j^{\mathsf T})=0$, that is $\sum_{j\ne i}\mu_{ij}=0$ for every $i$. Each $i$ has exactly one matched partner and $n-2$ unmatched ones, giving $(n-2)+(n-2)(-1)=0$.
- **Trace-free**: $m(n-2)+\big(\tfrac12 n(n-1)-m\big)(-1)=\tfrac n2(n-2)-\tfrac{n(n-2)}2=0$.
- **First Bianchi**: automatic by §3.3.
- **Isotropy check**: $\Theta(A)=\sum_\alpha\Pi_{P_\alpha}=\mathrm{Id}_n$, so $\kappa=1$ and $a=n/2$, as required.

At $n=4$ this is $\lambda_+=2$ on $\{e_1\wedge e_2,e_3\wedge e_4\}$ and $\lambda_-=-1$ on the other four, that is $W=3\Pi_A-\mathrm{Id}_{\Lambda^2}$. A second, independent check at $n=4$: in the Hodge splitting $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$, the subspace $A=\operatorname{span}\{\omega_{12},\omega_{34}\}$ is spanned by $(\omega_{12}+\omega_{34})/\sqrt2\in\Lambda^+$ and $(\omega_{12}-\omega_{34})/\sqrt2\in\Lambda^-$, so $\Pi_A$ is block-diagonal, the off-diagonal block that carries trace-free Ricci is zero, and $W^\pm=\operatorname{diag}(2,-1,-1)$ is trace-free on each factor. So $W$ lies in $\mathcal W_4$. At $n=6$ the same construction gives $\lambda_+=4$ on $\{\omega_{12},\omega_{34},\omega_{56}\}$, $\lambda_-=-1$ on the other twelve, and $3\cdot4+12\cdot(-1)=0$.

**So the case is inhabited at $n=4$, at $n=6$ and at every even $n\ge4$, and the theorem is not vacuous.** Better than that, the theorem's content is a uniqueness statement: since all perfect matchings of a frame are carried onto one another by a permutation, which lies in $O(n)$, the witness above is the *only* $\kappa=1$ two-eigenvalue configuration with a decomposable orthonormal eigenbasis, up to $O(n)$ and up to the sign swap of given 7. The theorem is therefore a classification with a one-element answer, which is the strongest form a positive result of this kind can take.

## 5. The $n=6$ enumeration

$n=6$, $N=15$, $\kappa=2a/6=a/3$. Working the chain in order.

1. **Rank count** (given 7): $a=3$ or $a\ge5$, and the same for $15-a$, that is $15-a=3$ or $15-a\ge5$. The first leaves $\{3,5,6,\dots,15\}$, the second leaves $\{12\}\cup\{a\le10\}$. The intersection is $a\in\{3,5,6,7,8,9,10,12\}$. In particular $a=4$ dies to the first condition and $a\in\{11,13,14\}$ die to the second, since $15-a\in\{4,2,1\}$ is neither $3$ nor at least $5$.
2. **Divisibility**: $\kappa=a/3$ must be a positive integer for a coordinate configuration, because in a coordinate configuration $\Theta(A)=\sum_i\deg(i)\,e_ie_i^{\mathsf T}$ and $\Theta(A)=\kappa\,\mathrm{Id}_6$ forces every degree to equal $\kappa$. So $3\mid a$, leaving $a\in\{3,6,9,12\}$.
3. **Swap** $a\leftrightarrow15-a$ (given 7), which exchanges $A$ with $A^\perp$ and negates $W$: it pairs $3\leftrightarrow12$ and $6\leftrightarrow9$.

**So yes, the chain leaves exactly $a=3$ and $a=6$ up to sign, and the arithmetic is right.** The check is internally consistent: $a=3$ gives $\kappa=1$, closed by §1, and its swap $a=12$ gives $\kappa=4$, the complement of a perfect matching, the cocktail-party graph $K_{2,2,2}$. The swap of $a=6$ is $a=9$ with $\kappa=3$, and the complements of the two graphs of §7 are the prism $\overline{C_6}$ and $K_{3,3}=\overline{C_3+C_3}$, both $3$-regular, as the swap requires.

**A value the chain admits and does not list.** Step 2 is necessary only for coordinate configurations. So $a\in\{5,7,8,10\}$ survives the rank count and is excluded by nothing in this chain once the configuration is allowed to be non-coordinate. Those four values, and their swaps $\{10,8,7,5\}$, are the unlisted admissible sizes. This does not damage the enumeration if the block's ambition is the coordinate classification, and it does damage any reading of the block as enumerating the two-eigenvalue cases at $n=6$. The same caution applies to $a=6$ itself, whose non-coordinate configurations are exactly what §8 is about.

## 6. The overlap identity

Write $t_{\alpha\beta}=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$ for $\alpha,\beta\in A$ and assume the planes come from decomposable orthonormal eigenvectors, so $\sum_{\alpha\in A}\Pi_\alpha=\kappa\,\mathrm{Id}_n$. Multiply by $\Pi_\beta$ and take the trace:
$$\sum_{\alpha\in A}t_{\alpha\beta}=\kappa\operatorname{tr}\Pi_\beta=2\kappa.$$
The diagonal term is $\operatorname{tr}(\Pi_\beta^2)=\operatorname{tr}\Pi_\beta=2$, so
$$\boxed{\ \sum_{\alpha\ne\beta}t_{\alpha\beta}=2(\kappa-1)\ }$$
**At $a=6$, $n=6$ we have $\kappa=2$ and the total overlap of each plane with the others is exactly $2$. The claim is correct.** Two remarks that the identity earns. First, at $\kappa=1$ it reads $\sum_{\alpha\ne\beta}t_{\alpha\beta}=0$ with nonnegative terms by given 6, which is §1.3 again, so **the three-line theorem is nothing but the $\kappa=1$ instance of this one identity**, and the record would be tidier stating it that way. Second, since each $t_{\alpha\beta}\in[0,1]$ by given 6, the identity bounds how many planes any one plane can meet: at $\kappa=2$ a plane meets at most two others in a line, and meets at least two others at all.

## 7. The coordinate solutions at $a=6$

A coordinate configuration at $a=6$ is a set of six distinct coordinate $2$-planes of one frame, that is six edges of a simple graph $G$ on the six frame vertices. Then $t_{\alpha\beta}=\operatorname{tr}(\Pi_{\{i,j\}}\Pi_{\{k,l\}})=|\{i,j\}\cap\{k,l\}|$, which is $1$ when the edges share a vertex and $0$ when they are disjoint, matching given 6 exactly.

- **Isotropy**: $\Theta(A)=\sum_{\{i,j\}\in E}(e_ie_i^{\mathsf T}+e_je_j^{\mathsf T})=\sum_i\deg(i)\,e_ie_i^{\mathsf T}$, and $=2\,\mathrm{Id}_6$ if and only if $G$ is $2$-regular. **So the coordinate solutions at $\kappa=2$ are exactly the $2$-regular graphs on six vertices.** The edge count is then automatic, $|E|=\tfrac12\sum\deg=6=a$, which is a consistency check rather than a second condition.
- **Classification**: a $2$-regular simple graph is a disjoint union of cycles of length at least $3$. The partitions of $6$ into parts of size at least $3$ are $6$ and $3+3$, so up to isomorphism there are exactly two, $C_6$ and $C_3+C_3$. **Correct.** A $C_4+C_2$ term is unavailable because a $2$-cycle is a repeated edge, and the six planes are distinct $2$-subsets.
- **Both satisfy every constraint.** $\Lambda^2$-orthonormality: the $\omega_{ij}$ over distinct pairs $\{i,j\}$ of one frame are orthonormal in $\Lambda^2$ by construction, so this holds for any graph and in particular for both. Ricci-flatness by given 3 is $\sum_{j\ne i}\mu_{ij}=0$ for each $i$: each vertex carries $2$ edges at $\lambda_+$ and $3$ non-edges at $\lambda_-$, so $2\lambda_++3\lambda_-=0$. Trace-freeness is $6\lambda_++9\lambda_-=0$, the same relation, so the two are consistent and $(\lambda_+,\lambda_-)=(3,-2)$ up to scale. First Bianchi is automatic by §3.3. **Both are genuine elements of $\mathcal W_6$.**
- **The overlap identity confirms both**, as §6 requires: in $C_6$ an edge shares a vertex with two edges and is disjoint from three, total $2$. In $C_3+C_3$ an edge shares a vertex with the two other edges of its own triangle and is disjoint from the three of the other, total $2$.

One open point I will not overstate. $C_6$ and $C_3+C_3$ are non-isomorphic graphs, so no permutation of the frame carries one configuration to the other. Whether the resulting $W$ are inequivalent under the full $O(6)$ needs an invariant beyond the spectrum, which is common to both. I did not find one by hand and I do not claim the two are $O(6)$-inequivalent.

## 8. The symmetric ansatz $t_{\alpha\beta}=2/5$, the item said to settle $n=6$

### 8.1 The Gram spectrum is exactly as claimed

Let $T$ be the $6\times6$ matrix $T_{\alpha\beta}=t_{\alpha\beta}$, the Gram matrix of the $\Pi_\alpha$ in the Frobenius inner product. Diagonal entries are $\operatorname{tr}(\Pi_\alpha^2)=2$, off-diagonal entries are $2/5$, so
$$T=2\,\mathrm{Id}_6+\tfrac25(J-\mathrm{Id}_6)=\tfrac85\,\mathrm{Id}_6+\tfrac25 J,$$
with $J$ the all-ones matrix, whose spectrum is $6$ once and $0$ five times. Hence $T$ has eigenvalue $\tfrac85+\tfrac{12}5=4$ once and $\tfrac85$ with multiplicity five. **Correct, exactly.** Two corroborations. The row sums are $4$, and §6 demands $\sum_\alpha t_{\alpha\beta}=2\kappa=4$, so the top eigenvalue on the all-ones vector had to be $4$. And $T\succ0$ with rank $6$, so any realisation has six linearly independent $\Pi_\alpha$, consistent with $\dim A=6$.

It is also worth recording the trace-free picture, since it is what the $8/5$ really is. Put $\hat\Pi_\alpha=\Pi_\alpha-\tfrac13\mathrm{Id}_6$, so $\sum_\alpha\hat\Pi_\alpha=2\,\mathrm{Id}_6-2\,\mathrm{Id}_6=0$ and $\langle\hat\Pi_\alpha,\hat\Pi_\beta\rangle=t_{\alpha\beta}-\tfrac23$, which is $\tfrac43$ on the diagonal and $-\tfrac4{15}$ off it. That Gram matrix is $\tfrac{24}{15}(\mathrm{Id}_6-\tfrac16J)$, with eigenvalue $0$ on the all-ones vector and $\tfrac85$ on its complement. **The ansatz says precisely that the six trace-free parts form a regular simplex spanning a five-dimensional subspace of $S^2_0(\mathbb R^6)$.**

### 8.2 Positive semidefiniteness is insufficient, and here is the closed-form reason

The Gram matrix is positive definite, and that is the only thing PSD-ness can give: six symmetric matrices with the prescribed inner products. It says nothing about the three conditions that matter, namely that each $X_\alpha$ be a rank-$2$ orthogonal projection, that $\sum_\alpha X_\alpha=2\,\mathrm{Id}_6$, and that the associated bivectors be **orthonormal in $\Lambda^2$**. The last of these is invisible to $T$, and that is the crux. By given 6 the $\Lambda^2$ inner product of two unit decomposables is $\langle\omega_\alpha,\omega_\beta\rangle=\det[\langle a_i,b_j\rangle]=\pm\cos\vartheta_1\cos\vartheta_2$ over the principal angles, while $t_{\alpha\beta}=\cos^2\vartheta_1+\cos^2\vartheta_2$. So $t_{\alpha\beta}=2/5$ is met both by the orthogonal pair $(\cos^2\vartheta_1,\cos^2\vartheta_2)=(2/5,0)$ and by the isoclinic pair $(1/5,1/5)$, and only the first is admissible. **$T$ fixes the trace and leaves the determinant free, so it cannot see the condition the ansatz needs.**

That is an argument in principle. Here is the fact, in closed form. **The whole Gram datum is realisable by six genuine $2$-planes in $\mathbb R^6$, and the realisation is isoclinic, hence inadmissible.**

Let $\hat x_1,\dots,\hat x_6\in\mathbb R^3$ be unit vectors along the six diagonals of the regular icosahedron, and realise $\mathbb R^6=\mathbb C^3=\mathbb R^3\otimes\mathbb R^2$ with complex structure $J$. Put $P_\alpha=\mathbb C\hat x_\alpha=\operatorname{span}_{\mathbb R}\{\hat x_\alpha,J\hat x_\alpha\}$ and $\omega_\alpha=\hat x_\alpha\wedge J\hat x_\alpha$, a unit decomposable form since $\langle\hat x,J\hat x\rangle=0$ and $\lVert J\hat x\rVert=1$.

- **Equiangularity, exact.** With vertices $(0,\pm1,\pm\phi)$ and cyclic, $\phi=\tfrac{1+\sqrt5}2$, the squared norm is $1+\phi^2=\phi+2=\tfrac{5+\sqrt5}2$ and any two distinct axes have $|\langle x,y\rangle|=\phi$. So $\cos^2=\dfrac{\phi^2}{(1+\phi^2)^2}=\dfrac{\phi+1}{(\phi+2)^2}=\dfrac{(3+\sqrt5)/2}{(15+5\sqrt5)/2}=\dfrac{3+\sqrt5}{5(3+\sqrt5)}=\dfrac15$, for all fifteen pairs.
- **Tight frame.** The icosahedral group acts irreducibly on $\mathbb R^3$ and permutes the six axes, so $\sum_\alpha\hat x_\alpha\hat x_\alpha^{\mathsf T}=c\,\mathrm{Id}_3$, and the trace $6$ gives $c=2$.
- **The Gram datum is met.** $\Pi_\alpha=\hat x_\alpha\hat x_\alpha^{\mathsf T}\otimes\mathrm{Id}_2$, so $t_{\alpha\beta}=2\langle\hat x_\alpha,\hat x_\beta\rangle^2=\tfrac25$ for every pair, and $\sum_\alpha\Pi_\alpha=2\,\mathrm{Id}_3\otimes\mathrm{Id}_2=2\,\mathrm{Id}_6$.
- **Isotropy is met too, which is the surprise.** $\Theta(A)$ commutes with the $\mathbb R^3\otimes\mathbb R^2$ factorisation and with the icosahedral action, irreducible on the first factor, and with the circle action of $J$ on the second, so $\Theta(A)=c'\,\mathrm{Id}_6$, and $\operatorname{tr}\Theta(A)=2\dim A=12$ gives $c'=2$. So $\Theta(A)=2\,\mathrm{Id}_6$ with $a=6$ and $\kappa=2$, exactly as given 4 demands, and the eigenvalue relation $2\lambda_++3\lambda_-=0$ of §7 is available.
- **And the ansatz fails, in the one place $T$ cannot see.** The principal-angle Gram of the pair is $\begin{pmatrix}\langle\hat x_\alpha,\hat x_\beta\rangle^2&0\\0&\langle\hat x_\alpha,\hat x_\beta\rangle^2\end{pmatrix}=\tfrac15\mathrm{Id}_2$, because $\langle\hat x_\alpha,J\hat x_\beta\rangle=0$ for real $\hat x$. So the pair is isoclinic with both squared cosines $1/5$, and $\langle\omega_\alpha,\omega_\beta\rangle=\det\begin{pmatrix}\langle x_\alpha,x_\beta\rangle&0\\0&\langle x_\alpha,x_\beta\rangle\end{pmatrix}=\langle\hat x_\alpha,\hat x_\beta\rangle^2=+\tfrac15\ne0$. **The six bivectors have Gram matrix $\tfrac45\mathrm{Id}_6+\tfrac15J$, spectrum $2$ once and $\tfrac45$ five times, so they are independent and span $A$, and they are not orthonormal.**

**Verdict on the item: the claim that PSD-ness is insufficient is correct, and it is stronger than "insufficient in principle". The Gram datum is genuinely realisable by planes, with the tight-frame and isotropy conditions satisfied, and the realisation is excluded only by the $\Lambda^2$-orthonormality. So no argument that reads only $T$ can decide the ansatz.**

### 8.3 What the icosahedral object also shows, and it bears on §1

Because the six decomposable $\omega_\alpha$ span $A$ without being orthonormal, $\Pi_A$ acquires cross terms, and first Bianchi stops being free. Explicitly, with Gram $G=\tfrac45\mathrm{Id}+\tfrac15J$ we get $G^{-1}=\tfrac54\mathrm{Id}-\tfrac18J$, verified by $(\tfrac45\mathrm{Id}+\tfrac15J)(\tfrac54\mathrm{Id}-\tfrac18J)=\mathrm{Id}+(-\tfrac1{10}+\tfrac14-\tfrac6{40})J=\mathrm{Id}$. Then $\Pi_A=\sum_{\alpha\beta}(G^{-1})_{\alpha\beta}\,\omega_\alpha\otimes\omega_\beta$ and, the diagonal terms dying by Plücker,
$$b(\Pi_A)\ \propto\ \sum_{\alpha\ne\beta}(G^{-1})_{\alpha\beta}\,\omega_\alpha\wedge\omega_\beta=-\tfrac18\Big(\Omega\wedge\Omega-\sum_\alpha\omega_\alpha\wedge\omega_\alpha\Big)=-\tfrac18\,\Omega\wedge\Omega,\qquad \Omega=\sum_\alpha\omega_\alpha.$$
And $\Omega$ is computable in closed form. Writing $\omega_\alpha=(J\hat x_\alpha)\hat x_\alpha^{\mathsf T}-\hat x_\alpha(J\hat x_\alpha)^{\mathsf T}=J\hat x_\alpha\hat x_\alpha^{\mathsf T}+\hat x_\alpha\hat x_\alpha^{\mathsf T}J$ using $J^{\mathsf T}=-J$, and summing with $\sum_\alpha\hat x_\alpha\hat x_\alpha^{\mathsf T}=2P$ for $P$ the projection onto the real form,
$$\Omega=2(JP+PJ)=2J,$$
since in the splitting $\mathbb R^6=\mathbb R^3\oplus J\mathbb R^3$ we have $JP=\begin{pmatrix}0&0\\ \mathrm{Id}&0\end{pmatrix}$ and $PJ=\begin{pmatrix}0&-\mathrm{Id}\\0&0\end{pmatrix}$. Cross-check on norms: $\lVert\Omega\rVert^2=\sum_{\alpha\beta}\langle\omega_\alpha,\omega_\beta\rangle=6\cdot2=12$ from the row sums of $G$, and $\lVert2J\rVert^2=4\cdot\tfrac12\operatorname{tr}(J^{\mathsf T}J)=4\cdot3=12$. Now $J$ is a nondegenerate $2$-form, so in a frame where $J=\omega_{12}+\omega_{34}+\omega_{56}$ the component $(J\wedge J)_{1234}=2(J_{12}J_{34}-J_{13}J_{24}+J_{14}J_{23})=2J_{12}J_{34}\ne0$, hence $\Omega\wedge\Omega=4J\wedge J\ne0$.

**So the icosahedral $A$ satisfies isotropy at $\kappa=2$ with $a=6$ and violates first Bianchi.** Two consequences for the record. First, $\Theta(A)=\kappa\,\mathrm{Id}_n$ does not encode first Bianchi once $A$ lacks an orthonormal decomposable basis, so isotropy is not by itself a sufficient condition on $A$, and any enumeration run on isotropy alone must carry Bianchi separately. Second, this is independent evidence that the decomposability hypothesis flagged in §1 is doing real work rather than being a technicality: it is what buys first Bianchi for free in §3.3.

### 8.4 The obstruction I looked for, the reformulation I found, and what is still open

I could not close the ansatz by hand, and I will say exactly where the attempt stops.

**Local conditions are satisfiable, so no cheap contradiction exists.** Compressing $\sum_\beta\Pi_\beta=2\,\mathrm{Id}$ to $P_\alpha$ gives $\sum_{\beta\ne\alpha}G^{\alpha\beta}=\mathrm{Id}_{P_\alpha}$ for the principal-angle Grams $G^{\alpha\beta}=\Pi_\alpha\Pi_\beta\Pi_\alpha|_{P_\alpha}$, each of trace $2/5$, and the trace matches, $5\cdot\tfrac25=2$. Under the admissible alternative each $G^{\alpha\beta}=\tfrac25 w_{\alpha\beta}w_{\alpha\beta}^{\mathsf T}$ is rank one, so the requirement becomes $\sum_{\beta\ne\alpha}w_{\alpha\beta}w_{\alpha\beta}^{\mathsf T}=\tfrac52\mathrm{Id}_2$, five unit vectors forming a tight frame in a plane, which the regular pentagon directions satisfy. So each plane's local picture is consistent, and any obstruction has to be global.

**An exact reformulation, which is the useful thing I can hand back.** Let $U_\alpha$ be $6\times2$ with orthonormal columns spanning $P_\alpha$ and $U=[U_1|\cdots|U_6]$, so $\sum_\alpha\Pi_\alpha=UU^{\mathsf T}=2\,\mathrm{Id}_6$. Then $M=\tfrac12U^{\mathsf T}U$ is an orthogonal projection on $\mathbb R^{12}$ of rank $\operatorname{tr}M=6$, in $2\times2$ blocks with $M_{\alpha\alpha}=\tfrac12\mathrm{Id}_2$ and $\lVert M_{\alpha\beta}\rVert_F^2=\tfrac14t_{\alpha\beta}$. The correspondence is exact in both directions, since any such $M$ factors as $\tfrac12U^{\mathsf T}U$ with $UU^{\mathsf T}=2\,\mathrm{Id}_6$ and $U_\alpha^{\mathsf T}U_\alpha=\mathrm{Id}_2$. Under it,
$$G^{\alpha\beta}=4M_{\alpha\beta}M_{\alpha\beta}^{\mathsf T},$$
so **the ansatz is equivalent to: a rank-$6$ orthogonal projection on $\mathbb R^{12}$, block $2\times2$, with every diagonal block $\tfrac12\mathrm{Id}_2$ and every off-diagonal block of rank exactly one and squared Frobenius norm $\tfrac1{10}$.** Writing $M_{\alpha\beta}=\tfrac1{\sqrt{10}}\,\epsilon_{\alpha\beta}\,p_{\alpha\beta}p_{\beta\alpha}^{\mathsf T}$ with unit $p\in\mathbb R^2$ and $\epsilon_{\alpha\beta}=\epsilon_{\beta\alpha}\in\{\pm1\}$, idempotence off the diagonal reduces to fifteen equations
$$\sum_{\gamma\ne\alpha,\beta}\epsilon_{\alpha\gamma}\epsilon_{\gamma\beta}\,\langle p_{\gamma\alpha},p_{\gamma\beta}\rangle\;p_{\alpha\gamma}\,p_{\beta\gamma}^{\mathsf T}=0,$$
and on the diagonal to the six tight-frame conditions $\sum_{\gamma\ne\alpha}p_{\alpha\gamma}p_{\alpha\gamma}^{\mathsf T}=\tfrac52\mathrm{Id}_2$. That is thirty angles and fifteen signs against a system whose naive count is heavily overdetermined: thirty-three moduli for six planes modulo $O(6)$ against twenty-one equations for $\sum\Pi_\alpha=2\,\mathrm{Id}$, nine further independent trace conditions once the six row sums are subtracted, and fifteen rank conditions. **The count points to emptiness and proves nothing, because symmetric ansätze routinely beat it.**

**Both symmetric realisations I could write down are isoclinic.** Besides the complex lines of §8.2, take the two three-dimensional icosahedral representations $3$ and $3'$ of $A_5$ and set $P_\alpha=\mathbb R\hat x_\alpha\oplus\mathbb R\hat y_\alpha$ with $\hat x$ and $\hat y$ the corresponding axes in the two summands. Then $\sum\Pi_\alpha=2\,\mathrm{Id}_3\oplus2\,\mathrm{Id}_3=2\,\mathrm{Id}_6$ and $t_{\alpha\beta}=\tfrac15+\tfrac15=\tfrac25$, and the principal-angle Gram is again $\tfrac15\mathrm{Id}_2$ because the cross terms $\langle\hat x_\alpha,\hat y_\beta\rangle$ vanish between the summands. Isoclinic again, so inadmissible again. Whether isocliny is *forced* at $t=2/5$ is exactly the open question, and I found no invariant that forces it: the natural candidates all reduce to triple products $\operatorname{tr}(\Pi_\alpha\Pi_\beta\Pi_\gamma)$, which $T$ does not determine. The second-moment attempt makes this concrete: $\operatorname{tr}\big((\sum_{\beta\ne\alpha}G^{\alpha\beta})^2\big)=2$ expands to $\tfrac45-2\sum_{\beta\ne\alpha}\langle\omega_\alpha,\omega_\beta\rangle^2+\sum_{\beta\ne\gamma}\operatorname{tr}(G^{\alpha\beta}G^{\alpha\gamma})$, and the last sum is a triple-product term, so the determinants are not pinned.

**Analysis-only block, declared.** Deciding whether a non-isoclinic realisation exists needs a run, and I do not have approval for one. The run I would propose is a solve of the block-projection system of this section, which is small and exact: thirty angles and fifteen signs, or equivalently a Gröbner or numerical-then-certified solve for the fifteen matrix equations above. **A solution realises a non-coordinate two-eigenvalue Weyl tensor at $n=6$, $a=6$, which would be the first of its kind in the programme and would refute any classification that lists only $C_6$ and $C_3+C_3$. No solution refutes the symmetric candidate and leaves the non-symmetric $t$-patterns of §8.5 as the remaining route.** I am stopping here rather than starting it.

### 8.5 The item does not settle $n=6$

The brief calls item 8 "the item that would settle $n=6$". It would settle the symmetric candidate only. §6 says the admissible overlap patterns at $a=6$, $\kappa=2$ are the points of $\{t_{\alpha\beta}\in[0,1]:\sum_{\beta\ne\alpha}t_{\alpha\beta}=2\ \forall\alpha\}$, a nine-dimensional polytope of which $t\equiv2/5$ is the barycentre and the two graphs of §7 are vertices. Refuting the barycentre leaves the rest of the polytope. **Settling $n=6$ requires an argument over the whole polytope, and the constant pattern is one point of it.**

## 9. The complex-line exclusion, and exactly what it excludes

The argument, reconstructed from given 8 and given 6, is correct and it is two lines. Two complex lines of a fixed complex structure $J$ on $\mathbb R^{2m}$ have equal principal angles $\vartheta_1=\vartheta_2=\vartheta$ by given 8, so $\langle\omega_\alpha,\omega_\beta\rangle=\pm\cos\vartheta_1\cos\vartheta_2=\pm\cos^2\vartheta$ and $t_{\alpha\beta}=2\cos^2\vartheta$. Hence $\langle\omega_\alpha,\omega_\beta\rangle=0$ if and only if $\cos\vartheta=0$ if and only if $t_{\alpha\beta}=0$. **A pair of complex lines of one $J$ is $\Lambda^2$-orthogonal exactly when the planes are mutually orthogonal.** §8.2 is the case in hand: $t=2/5$ gives $\cos^2\vartheta=1/5$ and $\langle\omega_\alpha,\omega_\beta\rangle=1/5$.

What it excludes, stated tightly.

- **Excluded**: any configuration in which two of the planes are complex lines of a *common* complex structure and overlap, $t_{\alpha\beta}>0$. In particular every all-complex-lines ansatz with a nonzero overlap, which is what kills the icosahedral candidate and its $3\oplus3'$ cousin.
- **Not excluded, case (i), mixing.** A pair consisting of one complex line and one plane that is not $J$-invariant has no forced isocliny, so the argument says nothing about it. **The exclusion is a statement about pairs, not about configurations, and it does not cover mixed configurations.** A configuration containing one complex line and five other planes is untouched.
- **Not excluded, case (ii), different structures.** If $P_\alpha$ is $J_1$-invariant and $P_\beta$ is $J_2$-invariant with $J_1\ne J_2$, given 8 does not apply. Since **every** $2$-plane $P$ is a complex line for some complex structure, namely any $J$ preserving $P$ and $P^\perp$, the phrase "complex line" carries no content until $J$ is fixed once for the whole configuration. Any use of the exclusion must name that single $J$, or it proves nothing.
- **Not excluded, case (iii), orthogonal complex lines.** Complex lines with $t_{\alpha\beta}=0$ are admissible and indeed occur: the perfect-matching witness of §4 at $n=6$ is six-dimensional with three mutually orthogonal planes, which are the complex lines of the standard $J=\omega_{12}+\omega_{34}+\omega_{56}$.

## 10. What would break each claim, and what I did to look for it

| Claim | What would break it | What I did |
|---|---|---|
| Three-line theorem | A non-idempotent $\omega_\alpha\omega_\alpha^{\mathsf T}$, or $\operatorname{tr}(PQ)\ne\lVert PQ\rVert_F^2$, or nonnegativity failing | Rederived every step from givens 1 to 4 and 6. Found the idempotence dependence, §1.2, and confirmed the trace identity by $\operatorname{tr}(QPQ)=\operatorname{tr}(PQ^2)$, §1.3 |
| Frame construction | A plane admitting two independent unit decomposables, or the planes failing to span | $\dim\Lambda^2P_\alpha=1$ forces $\pm$, and orthogonal idempotents summing to $\mathrm{Id}$ force the orthogonal splitting, §2 |
| $\Pi_A$ to $W$ | The non-matched coordinate bivectors failing to be eigenvectors | Checked that they are orthogonal to a spanning set of $A$, hence in $A^\perp$, §3.3 |
| Non-vacuity | The witness violating any of the four defining conditions of $\mathcal W_n$ | Verified all four at general even $n$, then independently re-verified $n=4$ through the Hodge splitting, where $W^\pm=\operatorname{diag}(2,-1,-1)$, §4 |
| $n=6$ enumeration | An admissible $a$ the chain lets through | Enumerated all $a\in\{1,\dots,14\}$ against the rank count, then the divisibility, then the swap. Found $\{5,7,8,10\}$ admitted and unlisted, §5 |
| Overlap identity | A $\kappa$ where $2(\kappa-1)$ fails | Derived it for general $\kappa$ and cross-checked both ends, $\kappa=1$ against §1.3 and $\kappa=2$ against the two graphs of §7, §6 |
| $a=6$ coordinate solutions | A third $2$-regular graph, or a $2$-regular graph failing a constraint | Enumerated partitions of $6$ into cycles of length $\ge3$, and verified isotropy, Ricci-flatness, trace-freeness, Bianchi and $\Lambda^2$-orthonormality for both, §7 |
| Gram spectrum | An arithmetic slip in $\tfrac85+\tfrac{12}5$ | Computed $T$ in closed form, checked the top eigenvalue against the row sum $2\kappa=4$ forced by §6, and re-derived the same $\tfrac85$ from the trace-free simplex picture, §8.1 |
| PSD insufficiency | A realisation of $T$ that *is* $\Lambda^2$-orthonormal | Tried to build one. Built two realisations instead, both isoclinic and both exact, and derived the block-projection reformulation to localise what is left, §8.2 and §8.4 |
| Complex-line exclusion | A mixed or two-structure configuration the argument silently claims | Separated the three cases it does not reach and exhibited an admissible complex-line configuration at $t=0$, §9 |

Two process notes. **The brief promises "the one other file you may open is the Lean file named below" and names no Lean file, so I opened nothing but the brief.** And **no computation was run**: every number in this report, including the icosahedral $\cos^2=1/5$, the Gram inverse $G^{-1}=\tfrac54\mathrm{Id}-\tfrac18J$, and $\Omega=2J$, was derived by hand and cross-checked against an independently computed norm or trace.

## Verdict

**The three-line theorem is VALID and its conclusion is correct, subject to one hypothesis it does not state.** Every arithmetic and algebraic step checks out: isotropy at $\kappa=2a/n=1$, the multiplication by $\Pi_\alpha$, the identity $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\lVert\Pi_\alpha\Pi_\beta\rVert_F^2$, the passage to a frame, and the coordinate-diagonality of $W$. The hypothesis is that the positive eigenspace $A$ has an orthonormal basis of **decomposable** forms, which the block needs twice and states nowhere, and which §8.3 shows is not idle, since it is also what makes first Bianchi free.

**Two corrections to the record.**

1. **The headline overclaims.** Replace "the $\kappa=1$ case is closed affirmatively at every even $n$" with the qualified statement of §1.4. The three lines stand unchanged.
2. **The $n=6$ list is a coordinate list.** $a\in\{5,7,8,10\}$ survives the rank count and dies only to a divisibility valid for coordinate configurations, so it must be stated as such.

**Two claims confirmed and strengthened.** The overlap identity is the $\kappa$-general $\sum_{\beta\ne\alpha}t_{\alpha\beta}=2(\kappa-1)$, of which the three-line theorem is the $\kappa=1$ instance, so the record can carry one identity where it now carries two arguments. And the theorem is **not vacuous**: a closed-form witness exists at every even $n\ge4$ and is the unique solution up to $O(n)$, which makes the theorem a classification with a one-element answer.

**On the item said to settle $n=6$: the Gram spectrum is exactly $4$ and $8/5^{\times5}$, the insufficiency of PSD-ness is confirmed and now proved constructively, and the ansatz is NOT settled.** The six icosahedral complex lines realise the entire Gram datum with $\sum_\alpha\Pi_\alpha=2\,\mathrm{Id}_6$ and $\Theta(A)=2\,\mathrm{Id}_6$, failing only the $\Lambda^2$-orthonormality, and correspondingly violating first Bianchi. So no argument reading $T$ alone can decide the ansatz, and both symmetric realisations available by hand are isoclinic. The remaining question is exactly the block-projection system of §8.4, whose solve I name and do not start, and even a refutation would settle the barycentre of a nine-dimensional polytope of overlap patterns rather than $n=6$.
