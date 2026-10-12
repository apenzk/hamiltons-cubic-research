# VERIFY_v214, Lemma L37, diagonality is decided by a single kernel

Verifier v214, cold read of [BRIEF_L37.md](BRIEF_L37.md) in its four sections A–D, against [conventions.md](../findings/conventions.md). **No numerical work of any kind was done**, no script, no Sage, no Python, no floating-point evaluation; every object below is exhibited in closed form and every check is exact arithmetic on an object constructed for the purpose. Log: [agent_logs/verify-L37-v214.log](../agent_logs/verify-L37-v214.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | $\delta_A(X)=AX+XA$ preserves the skew matrices | **HOLDS** |
| 2 | $\delta_A$ is the derivation extension $u\wedge v\mapsto Au\wedge v+u\wedge Av$ | **HOLDS** |
| 3 | $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$ in $A$'s eigenframe | **HOLDS** |
| 4 | forward: $A=\sum_i2^if_if_i^{\mathsf T}$ lies in $\ker\Phi_W$ when $W$ is diagonal in $\{f_i\}$ | **HOLDS** |
| 5 | the sums $2^i+2^j$ are pairwise distinct by binary uniqueness | **HOLDS** |
| 6 | "the distinctness … is never a genericity obstruction" | **HOLDS AS MEANT, WORDING RISK**, false on a one-clause misreading |
| 7 | converse: pairwise-distinct sums force pairwise-distinct $a_i$ | **HOLDS FOR $n\ge3$, FAILS AT $n=2$** |
| 8 | the range: A, B and C state no $n$; the proof uses $n\ge3$ | **GAP, a range in a proof and in no statement**; the statement is true at $n\le2$ for a reason the block does not give |
| 9 | simple spectrum of $\delta_A$ on $\Lambda^2$, eigenlines $\mathbb R\varphi_{ij}$ | **HOLDS** |
| 10 | $[W,\delta_A]=0$ makes $W$ preserve each eigenline, which is diagonality in $A$'s eigenframe | **HOLDS**, the brief's caution does not bite on a *line* |
| 11 | $A$'s eigenframe is orthonormal, so the conclusion is diagonality in the tabled sense | **HOLDS** |
| 12 | corollary: a diagonal $W$ puts an $n$-dimensional space of $A$ in $\ker\Phi_W$, so $\dim\ker\Phi_W<n$ excludes diagonality | **HOLDS**, "all $n$ diagonal matrices" is a miscount of a dimension |
| 13 | the corollary needs neither criticality nor $W\in\mathcal W_n$ | **HOLDS** |
| 14 | non-vacuity, $\dim\ker\Phi_W=1<4$ at $n=4$ | **TRUE, WITNESS UNNAMED**, the block names no $W$; it is $W_{\mathbb{CP}^2}$, and I verify it in closed form |
| 15 | the corollary is one-directional, the equivalence is not | **HOLDS**, witness unnamed in the block; padded $W_{\mathbb{CP}^2}$ at $n=8$ supplies one in closed form |
| 16 | the distinct-sums condition is the non-vanishing of a polynomial in $A$ | **TRUE, NO ARGUMENT ON FILE** (HYPOTHESIS-DEBT); the block asserts polynomiality of a condition it states in eigenvalues |
| 17 | vanish-identically-or-dense-open dichotomy on the subspace $\ker\Phi_W$ | **HOLDS** |
| 18 | "so 'some $A$ with distinct sums' is decided outright" | **OVERSTATED**, what follows is generic-or-never, hence one generic test; no decision procedure is exhibited |
| 19 | $\mathrm{Id}\in\ker\Phi_W$ always, with all sums equal | **HOLDS**; degenerates at $n=2$ exactly where claim 7 does |
| 20 | frame-independence $\ker\Phi_{gWg^{-1}}=g(\ker\Phi_W)g^{-1}$, $O(n)$-invariance of both clauses | **HOLDS**, two different conjugations written with one symbol |
| 21 | $W\in\mathcal W_n$ in A and D | **STATED, NEVER USED**, the equivalence holds for every linear operator on $\Lambda^2\mathbb R^n$ |
| 22 | A's clause "carries no information about $\theta$" | **UNPROVED IN A LEMMA MARKED PROVEN**, a measured claim from [post F22](../findings/target.md), false on its literal reading |

**Verdict: PROVEN, hypotheses corrected.** The equivalence and the corollary are correct and their proofs are correct, for $n\ge3$ as written and for $n\le2$ by an argument the block does not carry; three ancillary claims, the $n$-range, polynomiality, and the non-vacuity witness, carry one-line debts recorded below, and one stated hypothesis is never used.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- The meaning of *diagonal*, line 66: "**\"Diagonal\" means diagonal in coordinate $2$-planes $e_i\wedge e_j$** of an orthonormal frame of $\mathbb R^n$, *not* diagonal as an operator on $\Lambda^2\mathbb R^n$. A generic spectral eigenbasis is essentially never of that form, and conflating the two is what makes the diagonal case look liftable."
- The letter $\Phi$, line 51: "*(i)* $\Phi_W(A)=[W,\delta_A]$ with $\delta_A(X)=AX+XA$, the frame-independent diagonality test of [L37](../results.md), the sense every $\ker\Phi_W$ takes".
- The bivector normalisation, line 81: "$\lVert\varphi_{ab}\rVert^2=1$ under the half-trace pairing of the bullet above, which is the one every result uses and which makes $\{\varphi_{ab}\}_{a<b}$ orthonormal".
- $N$, line 46: "$\binom n2=\dim\Lambda^2\mathbb R^n$".
- $\dim\mathcal W_n$: "$\frac{n(n-3)(n+1)(n+2)}{12}$", which is $0$ at $n=3$ and negative at $n=2$, so $\mathcal W_n=0$ for $n\le3$ and the hypothesis $W\in\mathcal W_n$ is empty there.

Section D's own gloss, "*Diagonal* here means diagonal on the coordinate $2$-planes of the frame", agrees with line 66, and A's parenthesis "every $\varphi_{ij}=e_i\wedge e_j$ an eigenvector" is the same notion. **There is no collision on "diagonal" in this block.** The $\Phi$ collision is real on the record and is disambiguated correctly here: every $\Phi$ in A–D is sense (i).

## 1. Hypothesis inventory

*A pass with no inventory is not a pass.* Every hypothesis the block states, and every one its argument uses.

| hypothesis | stated where | used where | standing |
| --- | --- | --- | --- |
| $A$ symmetric | A, B, D | throughout: spectral theorem for the eigenframe; self-adjointness of $\delta_A$; $u^{\mathsf T}A=(Au)^{\mathsf T}$ in claim 2 | **stated and used** |
| $W$ a linear operator on $\Lambda^2\mathbb R^n$ | implicit in $[W,\delta_A]$ | forward and converse | **used, never stated as such** |
| $W\in\mathcal W_n$ | A ("For $W\in\mathcal W_n$"), D ("For $W\in\Weyl_n$") | **nowhere** | **stated, never used.** The block admits this for the corollary only ("It needs neither criticality nor $W\in\mathcal W_n$"); the equivalence has the same standing and the block does not say so |
| $W$ symmetric | inherited from $\mathcal W_n$ | **nowhere**, the converse concludes $W\varphi_{ij}\in\mathbb R\varphi_{ij}$ with no self-adjointness | **unused**; worth knowing, because it is what makes the criterion apply to the padded and non-curvature objects the corollary claims |
| criticality, $Q(W)=\theta W$ | disclaimed in the corollary | nowhere | **correctly disclaimed** |
| $n\ge3$ | **nowhere in A, B, C or D's statement** | the converse, at target.md line 642 | **used, never stated**, claim 8 |
| the $a_i$ listed with multiplicity | nowhere | the converse: $a_i=a_j$ for $i\ne j$ must be visible for the step to run | **used, never stated.** Reading "eigenvalues" as a *set* breaks the converse: $A=\mathrm{diag}(0,0,1,3)$ has distinct sums over the set $\{0,1,3\}$ but repeats them over the index list. The indexed form $a_i+a_j$ carries the intended reading, so this is a precision note rather than a defect |
| $\{\varphi_{ij}\}$ orthonormal in $\Lambda^2$ | conventions line 81 | needed for "diagonal in an *orthonormal* frame" to be the tabled notion | **available in conventions, uncited in the block** |
| $g\in O(n)$ in the frame-independence clause | "so both … are $O(n)$-invariant" | the clause | **stated and used**; it is what keeps $gAg^{-1}$ symmetric |

## 2. The action, the three claims, derived separately

**(a) $\delta_A$ preserves the skew matrices.** For $X^{\mathsf T}=-X$ and $A^{\mathsf T}=A$,

$$(AX+XA)^{\mathsf T}=X^{\mathsf T}A+AX^{\mathsf T}=-XA-AX=-(AX+XA).$$

**HOLDS**, and it uses $A$ symmetric, which is stated.

**(b) $\delta_A$ is the derivation extension.** With $u\wedge v=uv^{\mathsf T}-vu^{\mathsf T}$,

$$A(uv^{\mathsf T}-vu^{\mathsf T})+(uv^{\mathsf T}-vu^{\mathsf T})A=(Au)v^{\mathsf T}-(Av)u^{\mathsf T}+u(Av)^{\mathsf T}-v(Au)^{\mathsf T}=(Au)\wedge v+u\wedge(Av),$$

where $v^{\mathsf T}A=(Av)^{\mathsf T}$ is again $A=A^{\mathsf T}$. **HOLDS**, exactly as written, with no scale factor left over.

**(c) $\delta_A\varphi_{ij}=(a_i+a_j)\varphi_{ij}$.** Put $Af_i=a_if_i$; then (b) gives $\delta_A(f_i\wedge f_j)=a_if_i\wedge f_j+a_jf_i\wedge f_j$. **HOLDS.**

*Two further facts the block does not state and later steps need.* $\delta_A$ is self-adjoint for the $\Lambda^2$ pairing: $\langle\delta_AX,Y\rangle$ and $\langle X,\delta_AY\rangle$ both equal $\tfrac12(\operatorname{tr}(X^{\mathsf T}AY)+\operatorname{tr}(AX^{\mathsf T}Y))$, so its spectrum is real and $\{a_i+a_j\}_{i<j}$ is the whole of it. And $A$ real symmetric has an **orthonormal** eigenframe by the spectral theorem, the brief's question about claim 11, answered: yes, and when the $a_i$ are distinct that frame is unique up to signs and order, so "$A$'s eigenframe" is well defined at the point the converse uses it.

## 3. The forward direction

**The construction.** $W$ diagonal in the orthonormal frame $\{f_i\}$ means $W\varphi_{ij}=w_{ij}\varphi_{ij}$ for every $i<j$, with $\varphi_{ij}=f_i\wedge f_j$. Take $A=\sum_i2^if_if_i^{\mathsf T}$, so $Af_i=2^if_i$ and, by §2(c), $\delta_A\varphi_{ij}=(2^i+2^j)\varphi_{ij}$. Both $W$ and $\delta_A$ are diagonal in the same basis $\{\varphi_{ij}\}_{i<j}$ of $\Lambda^2$, hence commute, hence $\Phi_W(A)=[W,\delta_A]=0$ and $A\in\ker\Phi_W$. **HOLDS.**

**The distinctness, checked as stated.** The claim is about sums of two *distinct* powers: for $i\ne j$ the integer $2^i+2^j$ has exactly two $1$-bits, at positions $i$ and $j$, so by uniqueness of binary representation $\{i,j\}$ is recoverable from $2^i+2^j$ and distinct unordered pairs give distinct sums. **HOLDS.** It is robust to the one ambiguity in the phrase "pairwise-distinct sums $a_i+a_j$": on the inclusive reading that also admits $i=j$, the extra values are $2a_i=2^{i+1}$, single-bit integers, distinct from each other and from every two-bit sum, so the witness survives that reading too. The reading the converse needs is $i<j$, since those are the eigenvalues on $\Lambda^2$.

**One wording defect.** "$A$ commutes with $W$'s diagonal action" compares an $A\in\mathrm{Sym}^2(\mathbb R^n)$ with an operator on $\Lambda^2\mathbb R^n$. What commutes is $\delta_A$ with $W$, as above. The intended content is right and the repair is one clause.

**"Never a genericity obstruction", claim 6.** On its intended reading the sentence is true and can be said more strongly: a distinct-sums $A$ exists in *every* prescribed frame, and the set of distinct-sums $A$ is a dense Zariski-open subset of $\mathrm{Sym}^2(\mathbb R^n)$ (§7). **But it is one clause away from destroying the lemma.** Read as "$\ker\Phi_W$ always contains a distinct-sums $A$", it is false, and its falsity is the entire content of the criterion: $W_{\mathbb{CP}^2}$ has $\ker\Phi_W=\mathbb R\,\mathrm{Id}$ (§5), whose sums are all equal to $2$. The sentence sits inside the "*If $W$ is diagonal*" paragraph, which scopes it correctly; [LEDGER.md](../findings/LEDGER.md) line 701 repeats it as "distinctness is achievable at every $n$ and is never an obstruction", further from the scope that makes it true. Recorded as a wording risk, not a defect.

## 4. The converse, and the range, claims 7, 8, 9, 10, 11

**Pairwise-distinct sums force pairwise-distinct $a_i$, at $n\ge3$.** Suppose $a_i=a_j$ with $i\ne j$ and pick $k\notin\{i,j\}$, which needs $n\ge3$. Then $a_i+a_k=a_j+a_k$ with $\{i,k\}\ne\{j,k\}$, contradicting distinctness. **HOLDS**, and the threshold $n\ge3$ is exactly what the argument consumes.

**At $n=2$ the step is false.** $\Lambda^2\mathbb R^2$ is a line, there is a single pair $\{1,2\}$, so "pairwise-distinct sums" is vacuously satisfied by every $A$, in particular by $A=\mathrm{Id}$, whose eigenvalues are equal. The implication the proof asserts therefore fails at $n=2$, located exactly at [target.md](../findings/target.md) line 642.

**The opposite argued, which is what keeps this from being a defect in the statement.** At $n=2$ the *conclusion* holds anyway, for a reason the block does not give: $\dim\Lambda^2\mathbb R^2=1$, so every linear $W$ on it is a scalar, so $\varphi_{12}$ is an eigenvector in every orthonormal frame and $W$ is diagonal outright. Both sides of the equivalence are then identically true, the right-hand side too, since $W$ scalar commutes with everything, $\ker\Phi_W=\mathrm{Sym}^2(\mathbb R^2)$, and every $A$ in it passes the vacuous distinctness test. At $n\le1$, $\Lambda^2=0$ and both sides are vacuous. **So A, B and C are true with no range, and the proof is the thing that has a range.**

**The finding, stated as what it is.** Sections A, B and C state the equivalence for all $n$; the proof covers $n\ge3$ only, and the missing cases are true by an argument nowhere on file. This is the trap named in the brief (a range living in a proof and in no statement) and the repair is one clause in the block ("at $n\le2$ both sides hold trivially, $\Lambda^2\mathbb R^n$ being at most a line"), not a hypothesis on the statement. **Materiality is low but not zero**: $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ is $0$ at $n=3$ and negative at $n=2$, so the hypothesis $W\in\mathcal W_n$ empties the gap by itself, but the block's corollary explicitly discards that hypothesis, and [post F22](../findings/target.md) applies the machinery to objects outside $\mathcal W_n$, so the exclusion is not automatic where the block claims the widest scope.

**Simple spectrum, claim 9.** With the $a_i$ distinct and the sums pairwise distinct, $\delta_A$ has $\binom n2$ distinct eigenvalues on the $\binom n2$-dimensional $\Lambda^2$, so every eigenspace is a line and the lines are the $\mathbb R\varphi_{ij}$. **HOLDS.**

**Preserving a line, claim 10, the step the brief flags.** For $x\in\mathbb R\varphi_{ij}$, $\delta_A(Wx)=W\delta_Ax=(a_i+a_j)Wx$, so $Wx$ lies in the $(a_i+a_j)$-eigenspace, which is $\mathbb R\varphi_{ij}$ itself. Hence $W\varphi_{ij}=c_{ij}\varphi_{ij}$. **The brief's caution does not bite here**: "preserves a line" and "has that line's spanning vector as an eigenvector" differ for invariant subspaces of dimension $\ge2$, and coincide identically for a $1$-dimensional invariant subspace, which is what simple spectrum delivers. The step needs no self-adjointness of $W$, and does not use it. **HOLDS.**

**The frame, claim 11.** $A$ is real symmetric, so the spectral theorem supplies an orthonormal eigenframe $\{f_i\}$, unique up to sign and order because the $a_i$ are distinct; $\varphi_{ij}=f_i\wedge f_j$ is then the coordinate $2$-plane basis of an orthonormal frame, orthonormal in $\Lambda^2$ under the record's half-trace pairing ([conventions.md](../findings/conventions.md) line 81). So "diagonality in $A$'s eigenframe" is diagonality in the sense tabled at line 66, and the converse lands exactly on the notion A and D define. **HOLDS.**

## 5. The corollary, and its non-vacuity witness, claims 12, 13, 14

**The corollary.** If $W$ is diagonal in $\{f_i\}$ then every $A$ diagonal in $\{f_i\}$ has $\delta_A$ diagonal in $\{\varphi_{ij}\}$, hence commuting with $W$; those $A$ form an $n$-dimensional subspace of $\mathrm{Sym}^2(\mathbb R^n)$ contained in $\ker\Phi_W$, so $\dim\ker\Phi_W\ge n$, and $\dim\ker\Phi_W<n$ excludes diagonality. **HOLDS.** No injectivity of $A\mapsto\delta_A$ is needed, because the $n$ dimensions are counted upstairs in $\mathrm{Sym}^2$.

**A miscount in the wording.** D says "all $n$ diagonal matrices", which counts matrices where it means the dimension of a space of them. A gets it right: "the diagonal matrices in any frame supply an $n$-dimensional subspace". The block's phrasing should be A's.

**It needs neither criticality nor $W\in\mathcal W_n$, claim 13, HOLDS**, and more: nothing above uses symmetry of $W$ either, so the corollary holds for every linear operator on $\Lambda^2\mathbb R^n$.

**Non-vacuity, claim 14: the block names no $W$.** The clause "it is not vacuous, $\dim\ker\Phi_W=1<4$ at $n=4$" identifies no object, and the value it quotes is a measured one: it is the first row of [post F22](../findings/target.md)'s table, "$\mathbb{CP}^2,\mathbb{CP}^3,\mathbb{CP}^4,\mathbb{CP}^5$ | $1,1,1,1$", of which $\mathbb{CP}^2$ is the $n=4$ entry. **Recorded as the finding the brief asks for: the block does not name it.**

**The opposite argued, the claim is true, and here is the witness in closed form.** Let $n=4$ and $\Lambda^2\mathbb R^4=\Lambda^2_+\oplus\Lambda^2_-$.

*Parity lemma.* For traceless symmetric $A_0$, $\delta_{A_0}$ maps $\Lambda^2_\pm$ into $\Lambda^2_\mp$. Both sides are $SO(4)$-equivariant, $\delta_{gA_0g^{\mathsf T}}=\Lambda^2g\,\delta_{A_0}\,\Lambda^2g^{-1}$ by §2(b), and $\Lambda^2g$ preserves $\Lambda^2_\pm$, so take $A_0=\mathrm{diag}(a_1,\dots,a_4)$ with $\sum a_i=0$. Then, using $a_3+a_4=-(a_1+a_2)$,

$$\delta_{A_0}(\varphi_{12}+\varphi_{34})=(a_1+a_2)\varphi_{12}+(a_3+a_4)\varphi_{34}=(a_1+a_2)(\varphi_{12}-\varphi_{34})\in\Lambda^2_-,$$

and the same computation on $\varphi_{13}+\varphi_{42}$ and $\varphi_{14}+\varphi_{23}$, and on the three anti-self-dual generators.

*The kernel.* $W_{\mathbb{CP}^2}$ is, in any normalisation, zero on $\Lambda^2_-$ and invertible on $\Lambda^2_+$, where its eigenvalues are proportional to $(2,-1,-1)$ with the $2$ on the Kähler form $\omega$. Split $A=c\,\mathrm{Id}+A_0$; $\delta_{c\mathrm{Id}}=2c\,\mathrm{Id}$ commutes with everything, so $A\in\ker\Phi_W\iff[W,\delta_{A_0}]=0$. For $X\in\Lambda^2_-$: $\delta_{A_0}WX=0$ while $W\delta_{A_0}X$ has $\delta_{A_0}X\in\Lambda^2_+$ and $W$ invertible there, forcing $\delta_{A_0}X=0$. For $X\in\Lambda^2_+$ and any $Y\in\Lambda^2_-$, self-adjointness of $\delta_{A_0}$ gives $\langle\delta_{A_0}X,Y\rangle=\langle X,\delta_{A_0}Y\rangle=0$, and $\delta_{A_0}X\in\Lambda^2_-$, so $\delta_{A_0}X=0$. Hence $\delta_{A_0}=0$, so by §2(c) all $a_i+a_j=0$ for $i<j$, so at $n=4\ge3$ all $a_i$ are equal, so $A_0=0$ by tracelessness. **Therefore $\ker\Phi_{W_{\mathbb{CP}^2}}=\mathbb R\,\mathrm{Id}$ and $\dim\ker\Phi_W=1<4$**, in closed form, with no numerics, reproducing the recorded value.

*And the corollary's conclusion is independently right there.* The eigenvalue $2c$ of $W_{\mathbb{CP}^2}$ is simple with eigenvector $\omega=\varphi_{12}+\varphi_{34}$, of rank $4$; a diagonal $W$ has every simple eigenvector a multiple of some $f_i\wedge f_j$, of rank $2$. So $W_{\mathbb{CP}^2}$ is non-diagonal by a route that does not pass through L37, and L37's corollary agrees. **Two independent routes to the same verdict on the same object.**

*A second witness, in the range where the block disclaims $W\in\mathcal W_n$.* The Hodge star $\star$ on $\Lambda^2\mathbb R^4$ has eigenspaces $\Lambda^2_\pm$ with eigenvalues $\pm1$, both nonzero, so the same parity argument gives $\ker\Phi_\star=\mathbb R\,\mathrm{Id}$, $\dim=1<4$; and $\star$ is not an algebraic curvature operator, $\mathrm{Alt}(\star)=\star\ne0$ against [conventions.md](../findings/conventions.md) line 115. So the corollary is non-vacuous both inside and outside $\mathcal W_4$. It is also non-diagonal outright, since $\star\varphi_{12}=\pm\varphi_{34}$ in every orthonormal frame.

## 6. "Only the corollary is one-directional", claim 15, and the padded object

**The block asserts this and exhibits nothing.** A padded $W$ is the natural test of a diagonality criterion, so here is one, built rather than cited.

Let $n=8$, $U=\mathbb R^4\subset\mathbb R^8$, and let $W$ be $W_{\mathbb{CP}^2}$ on $\Lambda^2U$ and zero on $U\wedge U^\perp$ and on $\Lambda^2U^\perp$. Take $A=c\,\mathrm{Id}_U\oplus B$ with $B$ any symmetric operator on $U^\perp$. By §2(b), $\delta_A$ acts as the scalar $2c$ on $\Lambda^2U$, sends $u\wedge v\mapsto cu\wedge v+u\wedge Bv$ on $U\wedge U^\perp$, and preserves $\Lambda^2U^\perp$. So $\delta_A$ preserves the three summands, is scalar on the one where $W$ is nonzero, and $W$ is zero on the other two; hence $[W,\delta_A]=0$. These $A$ form a subspace of dimension $1+\binom{5}{2}=11$.

**So $\dim\ker\Phi_W\ge11>8=n$, while $W$ is non-diagonal**, its eigenvalue $2c$ is simple, $\dim\Lambda^2\mathbb R^8=28=1+2+25$ with $25$ the multiplicity of $0$, and its eigenvector $\omega$ has rank $4$. The corollary's converse therefore fails, and the equivalence is what decides the object: every $A$ in the constructed subspace has $a_1=a_2=a_3=a_4=c$, so $a_1+a_2=a_1+a_3$ and the distinct-sums test correctly returns non-diagonal. **The claim HOLDS and the block should carry this object or the record's own.**

*Two corroborations, neither numerical on my side.* The value $11$ is exactly what [post F22](../findings/target.md)'s table records for padded $\mathbb{CP}^2$ at $n=8$, so the construction reproduces a measured figure analytically. And [target.md](../findings/target.md) line 510 records the same object as the reason the dimension test alone is insufficient ("*Implementing only the dimension corollary was not enough) that wrongly called padded $W_{\mathbb{CP}^2}$ diagonal, contradicting its own rank-4 simple eigenvector; the distinct-sums search is load-bearing*". **The record has the witness; the block cites nothing.**

*The benign padding, for completeness.* Zero-padding a *diagonal* $W$ leaves it diagonal (the extra $\varphi_{ij}$ are eigenvectors with eigenvalue $0$) and $A=\sum_i2^if_if_i^{\mathsf T}$ in the padded frame is still in the kernel. And $W=0$ has $\ker\Phi_W=\mathrm{Sym}^2(\mathbb R^n)$, which contains distinct-sums $A$, and $0$ is diagonal in every frame. **The criterion is stable under padding in both directions**, which is the property the corollary alone lacks.

## 7. Decidability, claims 16, 17, 18

**The block's sentence.** "*On the linear subspace $\ker\Phi_W$ the distinct-sums condition is the non-vanishing of a polynomial, which therefore either vanishes identically on it or is non-zero on a dense Zariski-open subset.*"

**Is the condition really polynomial in $A$? The block does not say why, and its own phrasing raises the objection.** The condition is stated in terms of eigenvalues, and eigenvalues are not polynomial functions of a matrix, they are not even single-valued as functions of it. **This claim has no argument on file.** Recorded as HYPOTHESIS-DEBT.

**The opposite argued: the assertion is true, by either of two one-line routes, and neither is in the block.** (i) $A\mapsto\delta_A$ is *linear*, so the coefficients of $\chi_{\delta_A}$ are polynomials in the entries of $A$, and the discriminant $\mathrm{disc}(\chi_{\delta_A})$ is a polynomial in those coefficients; $\delta_A$ is self-adjoint (§2), so its spectrum is real and is exactly $\{a_i+a_j\}_{i<j}$, whence $\mathrm{disc}(\chi_{\delta_A})\ne0$ iff the sums are pairwise distinct. (ii) $\prod_{\{i,j\}\ne\{k,l\}}\big((a_i+a_j)-(a_k+a_l)\big)$ is a symmetric polynomial in $a_1,\dots,a_n$, hence a polynomial in the coefficients of $\chi_A$, hence in $A$. **So the debt is repairable in one clause; it is a missing argument, not a wrong one.**

**The dichotomy, claim 17, HOLDS.** $\ker\Phi_W$ is a linear subspace, so it is an irreducible affine variety and its real points are an $\mathbb R^k$; a polynomial restricted to it either vanishes identically or has non-vanishing locus Zariski-open, dense, and of full measure.

**"Decided outright", claim 18, OVERSTATED.** What the dichotomy gives is *generic-or-never on $\ker\Phi_W$*: the existential "some $A\in\ker\Phi_W$ with distinct sums" is equivalent to the same statement about a single generic $A\in\ker\Phi_W$. That is a real gain and is correctly described by the next sentence, "**decidable without an $O(n)$ search**", it replaces a minimisation over the orthogonal group by one evaluation on one element of a linear subspace. It is not by itself a decision procedure: producing a point certified off the hypersurface needs exact arithmetic at a Zariski-generic rational point of $\ker\Phi_W$, which the block does not mention. **The under-claim in the same paragraph is correct**, "including at $\dim\ker\Phi_W=n$ where the corollary says nothing" is right, the corollary being a one-sided certificate that fires only below $n$.

## 8. The quantifier and frame-independence, claims 19, 20

**$\mathrm{Id}\in\ker\Phi_W$ always.** $\delta_{\mathrm{Id}}(X)=X+X=2X$, the scalar $2$ on $\Lambda^2$, which commutes with every $W$. Its sums are $1+1=2$, all equal. So the criterion must be existential in $A$, and asking it of all $A$ would return "non-diagonal" for every $W$ including the diagonal ones. **HOLDS**, and it is load-bearing exactly as the block says.

**It degenerates at $n=2$, in the same place §4 does.** With one pair, "all sums equal" and "pairwise-distinct sums" are the same condition, so $\mathrm{Id}$ passes the test, and the verdict "diagonal" it produces is correct, because every $W$ is. The two boundary observations are the same observation, which is a second reason the block owes an $n\le2$ clause.

**Frame-independence.** For $g\in O(n)$, §2(b) gives $\delta_{gAg^{\mathsf T}}=\Lambda^2g\circ\delta_A\circ\Lambda^2g^{-1}$, so

$$\big[\Lambda^2g\,W\,\Lambda^2g^{-1},\ \delta_{gAg^{\mathsf T}}\big]=\Lambda^2g\,[W,\delta_A]\,\Lambda^2g^{-1},$$

whence $A\in\ker\Phi_W\iff gAg^{\mathsf T}\in\ker\Phi_{gWg^{-1}}$. The map $A\mapsto gAg^{\mathsf T}$ is a linear isomorphism, so the dimension is preserved, and $\operatorname{spec}(gAg^{\mathsf T})=\operatorname{spec}(A)$, so the distinct-sums clause is preserved. **HOLDS**, both clauses $O(n)$-invariant as claimed.

**A notational finding inside it.** In "$\ker\Phi_{gWg^{-1}}=g(\ker\Phi_W)g^{-1}$" the left $g$ is $\Lambda^2g$ acting on $\Lambda^2\mathbb R^n$ and the right $g$ is $g$ acting on $\mathbb R^n$: **two different conjugation actions written with one symbol**, in a record whose [conventions.md](../findings/conventions.md) exists to catch exactly that. Orthogonality of $g$ is what keeps $gAg^{-1}=gAg^{\mathsf T}$ symmetric, and the block carries it in "$O(n)$-invariant"; it would be clearer stated as a hypothesis on $g$.

## 9. The named traps, each answered

| trap | answer |
| --- | --- |
| $\ker W\ne0$ and padded objects | **Constructed, §6.** Padded $W_{\mathbb{CP}^2}$ at $n=8$: $\dim\ker\Phi_W\ge11>n$ and non-diagonal, so the corollary's converse fails and the equivalence is what decides it. The benign direction (zero-padding a diagonal $W$, and $W=0$), is stable under the criterion. $\ker W\ne0$ is the normal case here, not a special one: the padded object has $0$ with multiplicity $25$ out of $28$ |
| the boundary $n=2$ | **A finding, claim 8, §4.** The proof's step fails; the statement is true for a reason not on file |
| the boundary $n=3$ | **Clean for the proof**, it is the first $n$ where the converse's argument runs. Worth one note: $\dim\mathcal W_3=0$, so the stated hypothesis $W\in\mathcal W_3$ makes the lemma vacuous at exactly the $n$ where its proof first becomes non-vacuous, another face of claim 21 |
| the boundary $n=4$ | **The non-vacuity witness, §5.** True, and I give it in closed form; the block names no object |
| the crossover $n=6+2\sqrt7$ | **No contact.** A–D contain no inequality in $n$, no $\theta$-threshold and no comparison of families; nothing in this block can meet that crossover. Checked and clean |
| a claim proven on a subfamily and used in general | **None found.** The forward direction proves an existential with one explicit $A$ and uses only the existential; the converse takes an arbitrary $A\in\ker\Phi_W$; the corollary an arbitrary diagonal $W$. The one place the pattern could enter is "never a genericity obstruction", and it is scoped inside the diagonal paragraph, see claim 6 for the misreading that would introduce it |
| a hypothesis stated but never used | **Found: $W\in\mathcal W_n$**, in both A and D, and with it the symmetry of $W$. The block disclaims it for the corollary only; the equivalence has the same standing and the block does not say so. Claim 21 |
| a step using a hypothesis never stated | **Found: $n\ge3$** (claim 8), and the reading of "eigenvalues" as an indexed list with multiplicity (§1) |
| a universal claim with no witness | **Found twice**: the non-vacuity clause (claim 14) and "only the corollary is one-directional" (claim 15). Both true; neither names an object in the block, and the record carries witnesses for both |
| an imported theorem whose hypotheses were never checked | **None broken.** Three imports, all with hypotheses met: the spectral theorem for real symmetric matrices ($A$ symmetric, stated); uniqueness of binary representation (applied to sums of two *distinct* powers, which is the case at hand); the vanish-or-generic dichotomy (applied to a linear subspace, irreducible). **Nothing of the unital-algebra kind is imported**, no theorem here is applied to $\mathcal W_n$ as an algebra, and no property of $\mathcal W_n$ is used anywhere |
| symbol collisions in [conventions.md](../findings/conventions.md) | **$\Phi$**: four objects on the record; A–D use sense (i) throughout and A names L37, so this block is clean. **"diagonal"**: matches line 66 and D restates it compatibly. **$W$**: consistent. **$\delta$**: the record also carries $\delta$ as a scalar parameter (line 116's $d^+\delta^2$, [L7](../findings/bounds.md)'s $6\delta^2$), so $\delta_A$ is a third use of the letter, subscripted, so survivable. **$A$: a real collision, and it is not tabled.** Line 37 defines "$D_A$ … the induced derivation on $\Lambda^2$" for $A\in\mathrm{Sym}_0(\mathbb R^n)$, **the same operator as this block's $\delta_A$, under a different letter**, with $H_A=D_AW+WD_A$ the *anticommutator* sitting beside $\Phi_W(A)=[W,\delta_A]$, the commutator, on the identical pair. Conventions does not record that $D_A$ and $\delta_A$ are one object; recorded here as a repair owed to [conventions.md](../findings/conventions.md) |

**One further item, on the canonical entry rather than the block, claim 22.** A's sentence "The test is frame-independent, necessary and sufficient, and **carries no information about $\theta$**" sits inside a lemma the summary table marks **Proven**, and the block proves nothing of the kind. The clause is a measurement, [post F22](../findings/target.md)'s table, and trap 22 in [INDEX-traps.md](../findings/INDEX-traps.md), showing that $\dim\ker\Phi_W$ takes the value $1$ at objects whose $\theta$ differs by an order of magnitude. On its literal reading it is false: knowing $W$ diagonal bounds $\theta\le\Theta_n$ by [L57](../results.md), which is information about $\theta$. On its intended reading (the kernel does not *track* $\theta$), it is supported, and only by measurement. **A proved equivalence and a measured heuristic share one sentence in the canonical entry**; the two should be separated.

## 10. What would falsify it, and what I did to look

**The objects that would break the statement, named.**

1. **A $W$ that is diagonal in no orthonormal frame, yet with some $A\in\ker\Phi_W$ whose eigenvalues have pairwise-distinct sums.** This is the converse's falsifier. Where I looked: $W_{\mathbb{CP}^2}$ and $\star$ at $n=4$, where I computed $\ker\Phi_W=\mathbb R\,\mathrm{Id}$ in closed form (§5), all sums equal, so no falsifier; padded $W_{\mathbb{CP}^2}$ at $n=8$, where the $11$-dimensional kernel I constructed forces $a_1=a_2=a_3=a_4$ and so repeats sums (§6). The converse's own argument closes this off for every $n\ge3$, and the only crack in it is $n=2$, where the condition is vacuous, and there every $W$ *is* diagonal, so the crack is not a falsifier either. **None exists.**
2. **A $W$ diagonal in some orthonormal frame with no distinct-sums $A$ in $\ker\Phi_W$.** Closed off by the explicit $A=\sum_i2^if_if_i^{\mathsf T}$, which exists in every frame at every $n$ (§3). **None exists.**
3. **A diagonal $W$ with $\dim\ker\Phi_W<n$**, which would refute the corollary. Closed off by the same construction restricted to diagonal $A$, an $n$-dimensional subspace (§5). **None exists.**
4. **A non-diagonal $W$ with $\dim\ker\Phi_W\ge n$**, which would *not* falsify anything but would be needed to show the corollary is genuinely one-directional. I constructed one: padded $W_{\mathbb{CP}^2}$ at $n=8$, §6. **Exists, and the block should name it.**
5. **An $A\in\ker\Phi_W$ with distinct sums but a non-orthonormal eigenframe**, which would break the identification of the conclusion with the tabled meaning of "diagonal". Impossible: $A$ is symmetric by hypothesis (§2, §4).

**What I did to look.** I attacked each direction by trying to build the falsifier rather than by rereading the proof: the three padded and degenerate objects above, the two $n=4$ operators, $W=0$, and the $n\le2$ boundary, all in closed form and all by exact hand arithmetic on objects constructed for the purpose. **No script, no Sage, no Python, no floating-point evaluation was run at any point**, in keeping with the programme's analysis-only footing; the two places where the record's own figures are numerical ($\dim\ker\Phi_W=1$ at $n=4$ and $11$ at padded $\mathbb{CP}^2$), I reproduced analytically instead of re-measuring.

## Verdict

**PROVEN, hypotheses corrected.**

The equivalence and the corollary are true, and the proofs given for them are correct. Four things are owed, none of which touches the truth of A, B or C:

- **The range.** The converse's chain covers $n\ge3$ only; $n\le2$ is true because $\Lambda^2\mathbb R^n$ is then at most a line, an argument nowhere on file. One clause repairs it. *(Claim 8, the only GAP in the proof of the stated result.)*
- **Polynomiality.** The decidability paragraph's load-bearing step (that the distinct-sums condition is the non-vanishing of a polynomial in $A$), **has no argument on file**, and the block states the condition in eigenvalues, which are not polynomial in the matrix. It is true, by the discriminant of $\chi_{\delta_A}$ or by symmetry of $\prod((a_i+a_j)-(a_k+a_l))$, and one clause repairs it. *(Claim 16, HYPOTHESIS-DEBT, ancillary to the lemma.)*
- **Two witnesses.** "Not vacuous, $\dim\ker\Phi_W=1<4$ at $n=4$" names no $W$ and quotes a measured value; "only the corollary is one-directional" names no object at all. Both are true, and §5 and §6 supply $W_{\mathbb{CP}^2}$, $\star$ and padded $W_{\mathbb{CP}^2}$ in closed form. *(Claims 14, 15.)*
- **An unused hypothesis.** $W\in\mathcal W_n$ appears in A and D and is used nowhere; neither is symmetry of $W$. The equivalence holds for every linear operator on $\Lambda^2\mathbb R^n$, which is strictly stronger than what is stated and is what the corollary's own disclaimer already half-says. *(Claim 21.)*

Three wording defects should go with the repair: "$A$ commutes with $W$'s diagonal action" (the commuting pair is $\delta_A$ and $W$); "all $n$ diagonal matrices" (a dimension, not a count, and A words it correctly); and the two conjugation actions written with one $g$ in the frame-independence clause. Two record-level items fall out: the canonical entry folds the measured clause "carries no information about $\theta$" into a lemma marked Proven, and [conventions.md](../findings/conventions.md) carries this block's $\delta_A$ a second time as $D_A$ without saying they are the same operator.
