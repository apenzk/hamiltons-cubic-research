# Review r857 on the integrality condition on plane configurations: the two exact identities, the scalar bound $\Xi\le n^2(n-1)$, the theorem that integrality forces a common frame, and what the $\sup\Xi$ reformulation actually buys

*Reviewer r857, 2026-09-10. The brief was cold: this review read the brief and [L201Statement.lean](../lean/HamiltonsCubic/Results/L201Statement.lean) and nothing else of the record. No numerical work beyond screening was done, in the sense of the analysis-only footing: every derivation below is by hand, every value reported is exact and closed-form, and the machine was used only to re-run algebra already done on paper on objects constructed for that purpose. Log: [agent_logs/review-r857-integrality.log](../agent_logs/review-r857-integrality.log).*

## Claim table

| # | Claim | Verdict | Reason |
|---|---|---|---|
| C1 | Per-index identity $\sum_{\beta\ne\alpha}\operatorname{tr}(\Pi_\alpha\Pi_\beta)=2(n-2)$ at every $\alpha$ | **CONFIRMED** | one line from completeness and $\operatorname{tr}(\Pi_\alpha^2)=\operatorname{tr}\Pi_\alpha=2$, and it needs the family to be a BASIS, which the block has |
| C2 | $\langle u\wedge v,u'\wedge v'\rangle=\cos\vartheta_1\cos\vartheta_2$, $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\cos^2\vartheta_1+\cos^2\vartheta_2$, so orthogonality gives $\operatorname{tr}\in[0,1]$ with endpoints "shares a line" and "orthogonal" | **CONFIRMED** | the pairing is $\det M$ exactly in the record's normalisation, up to the orientation sign, and the two endpoint readings are correct |
| C3 | Fixed total $\sum_{\alpha\ne\beta}\operatorname{tr}=n(n-1)(n-2)$, both routes, and $\Xi=\lVert\sum\Pi_\alpha\otimes\Pi_\alpha\rVert^2=\sum_{\alpha\beta}\operatorname{tr}(\Pi_\alpha\Pi_\beta)^2=n^2(n-1)$ at a coordinate configuration | **CONFIRMED** | both routes agree, the tensor-norm identification is the standard $\langle A\otimes A,B\otimes B\rangle=\langle A,B\rangle^2$, screened at $n=3,4,5,6$ |
| C4 | $\Xi\le n(n-1)(n-2)+2n(n-1)=n^2(n-1)$, equality exactly at integrality | **CONFIRMED AS ALGEBRA** | termwise $t^2\le t$ on $[0,1]$ is sound and the diagonal $2n(n-1)$ is exact, and the clause "takes it at no other" IS the theorem, so the bound is not independent support for the theorem |
| C5 | The theorem: integrality forces a common frame, in four steps and an induction | **CONFIRMED** (sound as written, two elisions) | every step follows, the sub-configuration inherits exactly the hypotheses the induction consumes, and completeness at $x^\perp$ is derived rather than assumed. The prose asserts "exactly two lines" one sentence before the rank argument that gives it, and step (4) silently needs $n-1\ge3$ |
| C6 | The theorem is neither vacuous nor trivially true | **CONFIRMED** | coordinate configurations satisfy every hypothesis at each $n\ge3$, and the rotated witness is an orthonormal decomposable basis that is not coordinate, so the integrality hypothesis is load-bearing |
| C7 | Nothing in the block needs $\lambda_\alpha\ne0$ or a simple spectrum | **CONFIRMED for the theorem** | the theorem's hypotheses name no eigenvalue at all, so a kernel is invisible to it. The kernel bites only the reformulation, where an eigenvalue-zero eigenspace of dimension $\ge2$ removes the simple-spectrum branch |
| C8 | Integrality is necessary at a coordinate configuration, and it is a property of the CHOSEN basis rather than of $W$, with the rotated witness as proof | **CONFIRMED** | coordinate pairs share one index or none, and at the witness $\Xi=48-2\sin^2 2t<48$ while the operator itself is coordinate-diagonal |
| C9a | $\sup\Xi=n^2(n-1)$ over admissible reselections is equivalent to coordinate-diagonality | **CONFIRMED** (conditional on C5) | both directions hold, the sup is attained because the admissible set is compact, and it is nonempty by hypothesis |
| C9b | "Where the spectrum is simple ... coordinate-diagonality is exactly the single equation $\Xi(W)=n^2(n-1)$", offered as meeting I73's target | **REFUTED AS STATED at $n=4$** | a coordinate-diagonal Ricci-flat $W$ at $n=4$ has eigenvalues $a,a,b,b,c,c$, so simple spectrum and coordinate-diagonality are mutually exclusive there and the single equation can only ever return "no" |
| C10 | $\mathrm{Alt}(W^2)\propto\lVert W^+\rVert^2-\lVert W^-\rVert^2$, and at $W_{\mathbb{CP}^2}$: $\lVert W\rVert^2=6c^2$, $P=18c^3$, $\theta=\sqrt{3/2}$, so the $\Lambda^4$ test fails at a genuine local maximum | **CONFIRMED** | all four values reproduce exactly, the proportionality constant is $\tfrac16$ per given 6, and the failure sits AT $\sqrt{3/2}$ rather than above it, which is what leaves the strict-threshold version open |
| C11 | What a counterexample looks like | **answered** | it must fail step (4): a pencil direction misaligned with the recursive frame, possible only when $n-1=2$, which is why the base case must be $n=3$ |

## One line to act on

The identities, the bound and the theorem's written proof all hold, so the reformulation is real, and the one thing to fix is the last paragraph's payoff clause: at $n=4$ spectral simplicity and coordinate-diagonality exclude each other, so I73 cannot serve I36 there and the "single scalar equation" branch exists only for $n\ge5$.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- $u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$, the orthogonal projection onto $P=\mathrm{span}\{u,v\}$. **This holds for exactly this normalisation**: the $1/\sqrt2$ convention returns $\tfrac12\Pi_P$.
- $\omega$ is **decomposable** when $\omega=u\wedge v$, equivalently $\omega\wedge\omega=0$. The record's wedge is TWICE the Pfaffian.
- $\mathcal W_n$ is the space of algebraic Weyl tensors: symmetric operators on $\Lambda^2\mathbb R^n$, first Bianchi, Ricci-flat, trace-free. $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.
- $\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$.

One convention the block uses without declaring it: the inner product on the $\Pi_\alpha$, which are symmetric operators on $\mathbb R^n$ rather than bivectors, is the plain Hilbert-Schmidt $\langle A,B\rangle=\operatorname{tr}(AB)$ with no factor $\tfrac12$. This is forced by the stated value $\Xi=n^2(n-1)$: the brief's $\tfrac12\operatorname{tr}$ applied to the tensor square would return $\tfrac14 n^2(n-1)$. The $\tfrac12$ is correct where the brief declares it, on $\Lambda^2\mathbb R^n$, and this review verified the two are used consistently.

## Hypothesis inventory

| Claim | Hypotheses as stated | Held by the object it is applied to? |
|---|---|---|
| C1 per-index identity | $\{\omega_\alpha\}$ an orthonormal BASIS of $\Lambda^2\mathbb R^n$ by decomposable forms, and each $\Pi_\alpha$ a rank-two orthogonal projection | Yes. Completeness $\sum\Pi_\alpha=(n-1)\mathrm{Id}$ is given 1 applied to $E=\Lambda^2\mathbb R^n$, and it FAILS for a proper orthonormal set, where $\Theta(E)$ is not a multiple of the identity. Decomposability is what makes $\Pi_\alpha$ rank two and idempotent. |
| C2 angle reading | Two unit decomposable forms, plus $\Lambda^2$-orthogonality for the $[0,1]$ range | Yes for a basis. The range needs orthogonality: without it $\operatorname{tr}(\Pi_\alpha\Pi_\beta)$ reaches $2$ at equal planes. |
| C3 fixed total | As C1 | Yes, and the second route additionally uses only completeness plus $\operatorname{tr}(\Pi_\alpha^2)=2$. |
| C4 bound | Every off-diagonal term in $[0,1]$ (from C2), every diagonal term exactly $4$ (from decomposability) | Yes. The diagonal accounting is where decomposability enters a second time: for a non-decomposable unit $\omega$, $\operatorname{tr}(\omega\omega^{\mathsf T})=2$ still but $\operatorname{tr}((\omega\omega^{\mathsf T})^2)$ drops, for instance to $1$ at $\tfrac1{\sqrt2}(e_{12}+e_{34})$. |
| C5 theorem | $n\ge3$, an orthonormal basis of $\Lambda^2\mathbb R^n$, all of it decomposable, and $\operatorname{tr}(\Pi_\alpha\Pi_\beta)\in\{0,1\}$ for $\alpha\ne\beta$ | Yes for the induction's sub-configuration: the $\binom{n-1}2$ planes inside $x^\perp$ are orthonormal, decomposable, integral, and their completeness $(n-2)\mathrm{Id}_{x^\perp}$ is DERIVED in step (3) rather than assumed. Step (4) additionally needs $n-1\ge3$, which the prose does not state and the $n=3$ base supplies. |
| C6 non-vacuity | none beyond C5's | The coordinate configuration satisfies all of them at every $n\ge3$. |
| C7 | The theorem states no spectral hypothesis | Correct: the theorem is about a configuration of planes, so $\ker W\ne0$ cannot reach it. |
| C8 necessity | Coordinate configuration | Holds. |
| C9 reformulation | $W$ symmetric with at least one orthonormal decomposable eigenbasis, and reselections "admissible inside the eigenspaces" | The domain is the closed subset of $\prod_\mu O(\dim E_\mu)$ cut out by the decomposability equations $\omega_\alpha\wedge\omega_\alpha=0$, which is not a subgroup. The block's word "admissible" carries this, and compactness of that closed subset is what makes the sup attained. |
| C10 | given 3 (block structure at $n=4$), given 5 ($W_{\mathbb{CP}^2}$ critical, local max, $\theta=\sqrt{3/2}$), given 6 (the $\mathrm{Alt}$ formula) | All three are used correctly, and given 6's factor $\tfrac16$ is the one thing the prose drops. |

## 1. The per-index identity

Completeness is given 1 at $E=\Lambda^2\mathbb R^n$: $\sum_\alpha\Pi_\alpha=\Theta(\Lambda^2\mathbb R^n)=(n-1)\mathrm{Id}$, with the trace check $2\dim\Lambda^2\mathbb R^n=n(n-1)=\operatorname{tr}((n-1)\mathrm{Id})$. Contracting with $\Pi_\alpha$,

$$\sum_\beta\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\operatorname{tr}\big(\Pi_\alpha\,(n-1)\mathrm{Id}\big)=2(n-1),$$

and the $\beta=\alpha$ term is $\operatorname{tr}(\Pi_\alpha^2)=\operatorname{tr}(\Pi_\alpha)=2$ because $\Pi_\alpha$ is an idempotent of rank two. Hence $\sum_{\beta\ne\alpha}\operatorname{tr}(\Pi_\alpha\Pi_\beta)=2(n-1)-2=2(n-2)$, which is the block's own parenthetical. **No finding.**

That $\Pi_\alpha=\omega_\alpha\omega_\alpha^{\mathsf T}$ is the plane projection is the brief's normalisation and this review re-derived it: $\omega=vu^{\mathsf T}-uv^{\mathsf T}$ is skew, so $\omega\omega^{\mathsf T}=-\omega^2$, and $\omega^2=-\left(uu^{\mathsf T}+vv^{\mathsf T}\right)$ at orthonormal $u,v$.

**Does it need a basis rather than an orthonormal set?** It does, and the block is right to invoke $\Theta(\Lambda^2\mathbb R^n)=(n-1)\mathrm{Id}$ rather than $\Theta(E)$ for a subspace. For a proper orthonormal decomposable set the correct statement is $\sum_{\beta\ne\alpha}\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\operatorname{tr}(\Pi_\alpha\Theta(E))-2$, and $\Theta(E)$ is then not a multiple of the identity, so the value moves with $\alpha$. Take $n=4$ and $E=\mathrm{span}\{e_1\wedge e_2,e_1\wedge e_3\}$: at $\alpha=e_1\wedge e_2$ the sum is $1$, not $2(n-2)=4$.

**The coordinate configuration.** At the coordinate planes $P_{ij}=\mathrm{span}\{e_i,e_j\}$, $\operatorname{tr}(\Pi_{ij}\Pi_{kl})$ counts the shared indices, so it is $1$ for the $2(n-2)$ planes meeting $\{i,j\}$ in one index and $0$ for the disjoint ones. The sum is $2(n-2)$ exactly.

**Given 4's rotated witness.** With $g_2=\cos t\,e_2+\sin t\,e_3$, $g_3=-\sin t\,e_2+\cos t\,e_3$ and the six planes in the brief's order, the trace table is exact and symmetric:

$$\operatorname{tr}(\Pi_i\Pi_j)=\begin{pmatrix}2&1&1&1&\cos^2t&\sin^2t\\ 1&2&1&1&\sin^2t&\cos^2t\\ 1&1&2&0&1&1\\ 1&1&0&2&1&1\\ \cos^2t&\sin^2t&1&1&2&1\\ \sin^2t&\cos^2t&1&1&1&2\end{pmatrix}$$

Every row's off-diagonal sum is $4=2(n-2)$, the two non-integral entries per row pairing as $\cos^2t+\sin^2t=1$. This is the sharpest thing the identity says: it is blind to integrality, holding at a configuration that is not coordinate, so it can carry no part of the theorem's weight on its own.

## 2. Principal angles, the range $[0,1]$ and the two endpoints

Write $M=\begin{pmatrix}\langle u,u'\rangle&\langle u,v'\rangle\\ \langle v,u'\rangle&\langle v,v'\rangle\end{pmatrix}$ for orthonormal spanning pairs of $P$ and $P'$. The singular values of $M$ are $\cos\vartheta_1,\cos\vartheta_2$, the cosines of the principal angles.

**The pairing.** With $\omega=vu^{\mathsf T}-uv^{\mathsf T}$ and $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, expanding the four terms gives $\operatorname{tr}(\omega^{\mathsf T}\omega')=2\big(\langle u,u'\rangle\langle v,v'\rangle-\langle u,v'\rangle\langle v,u'\rangle\big)$, so

$$\langle u\wedge v,\ u'\wedge v'\rangle=\det M=\pm\cos\vartheta_1\cos\vartheta_2 .$$

The factor is right in the record's normalisation: the $2$ from the expansion and the $\tfrac12$ from the inner product cancel exactly. The block's formula is therefore correct up to the sign that the orientation of the chosen spanning pairs fixes, and the sign is immaterial to every use, all of which are vanishing statements. This is also exactly the expression carried by the hypothesis `horth` of [integrality_forces_frame](../lean/HamiltonsCubic/Results/L201Statement.lean), which is one point in the Lean file's favour.

**The trace.** $\operatorname{tr}(\Pi_P\Pi_{P'})=\lVert M\rVert_F^2=\cos^2\vartheta_1+\cos^2\vartheta_2$, unconditionally, with no orthogonality needed. So the block's identification is right, and the range without orthogonality is $[0,2]$.

**Orthogonality forces a right angle.** $\det M=0$ makes one singular value zero, that is $\cos\vartheta_2=0$. Principal angles lie in $[0,\pi/2]$ and their cosines are the singular values, so this is exactly one right principal angle. Then $\operatorname{tr}(\Pi_P\Pi_{P'})=\cos^2\vartheta_1\in[0,1]$.

**The endpoints.** Value $1$ means $\cos\vartheta_1=1$, that is a unit vector in $P\cap P'$, so the planes share a line, and conversely a shared line gives $\cos\vartheta_1=1$. Value $0$ gives $\lVert\Pi_P\Pi_{P'}\rVert_F^2=\operatorname{tr}(\Pi_P\Pi_{P'}^2)=\operatorname{tr}(\Pi_P\Pi_{P'})=0$, hence $\Pi_P\Pi_{P'}=0$, which is mutual orthogonality of the planes, and conversely. The block's own justification for the second endpoint, "because $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\lVert\Pi_\alpha\Pi_\beta\rVert_F^2$", is the correct one and this review reproduced it. **No finding.**

## 3. The fixed total and the identification of $\Xi$

Summing section 1 over the $\binom n2$ indices gives $\sum_{\alpha\ne\beta}\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\tfrac{n(n-1)}2\cdot 2(n-2)=n(n-1)(n-2)$. The block's second route agrees: $\operatorname{tr}\big((\sum_\alpha\Pi_\alpha)^2\big)=\operatorname{tr}\big((n-1)^2\mathrm{Id}\big)=n(n-1)^2$ and $\sum_\alpha\operatorname{tr}(\Pi_\alpha^2)=2\binom n2=n(n-1)$, whose difference is $n(n-1)(n-2)$. Both are checked at the rotated witness above, where the total is $24=4\cdot3\cdot2$.

**The tensor norm.** For symmetric $A,B$ the Hilbert-Schmidt product satisfies $\langle A\otimes A,B\otimes B\rangle=\langle A,B\rangle^2=\operatorname{tr}(AB)^2$, so

$$\Big\lVert\sum_\alpha\Pi_\alpha\otimes\Pi_\alpha\Big\rVert^2=\sum_{\alpha,\beta}\operatorname{tr}(\Pi_\alpha\Pi_\beta)^2 .$$

Correct, subject to the undeclared normalisation noted in the conventions section above.

**The coordinate value.** Diagonal terms contribute $\binom n2\cdot 2^2=2n(n-1)$ and the off-diagonal terms, all $0$ or $1$, contribute their own sum $n(n-1)(n-2)$, giving

$$\Xi=n(n-1)(n-2)+2n(n-1)=n(n-1)\big((n-2)+2\big)=n^2(n-1).$$

Screened at $n=3,4,5,6$ as $18,48,100,180$. **No finding.**

## 4. The bound and its equality case

The off-diagonal terms lie in $[0,1]$ by section 2, so $t^2\le t$ termwise and $\sum_{\alpha\ne\beta}\operatorname{tr}^2\le n(n-1)(n-2)$. The diagonal terms are not bounded but computed: each is exactly $\operatorname{tr}(\Pi_\alpha^2)^2=4$. Hence $\Xi\le n^2(n-1)$ with equality if and only if every off-diagonal trace is $0$ or $1$, since $t^2=t$ on $[0,1]$ only at the endpoints. Sound, and the maximum is attained, so $\max\Xi=n^2(n-1)$ unconditionally.

**Two things worth stating that the block leaves implicit.**

- The diagonal step uses decomposability a second time, independently of the range argument. For a non-decomposable unit $\omega$ the trace $\operatorname{tr}(\omega\omega^{\mathsf T})$ is still $2$, but $\operatorname{tr}((\omega\omega^{\mathsf T})^2)$ is smaller: at $\omega=\tfrac1{\sqrt2}(e_{12}+e_{34})$ one has $\omega\omega^{\mathsf T}=\tfrac12\mathrm{Id}_4$ and the value is $1$. So the stipulation that $\Xi$ is "defined on orthonormal decomposable bases and on nothing wider" is doing real work: the formula extends, and the bound's accounting does not.
- **The clause "and by the theorem below it takes it at no other" is the theorem, not a corollary of the bound.** The bound gives equality if and only if integrality, a statement entirely within the scalar algebra. That integrality holds only at coordinate configurations is the theorem. The two must not be cited as independent evidence for one another, and in the Lean layer the distinction is visible: the scalar half is proved and the geometric half is a `sorry`.

## 5. The theorem's four steps

Each step below is re-derived, then judged. The conclusion of this section is that the written proof is correct, with two elisions to repair in the prose.

**Step (1), the neighbour's form.** Let $\operatorname{tr}(\Pi_\alpha\Pi_\beta)=1$. By section 2 the planes share a line $\mathbb Ru$ with $u$ a unit vector, and $\Lambda^2 P$ is one-dimensional, so $\omega_\alpha=\pm u\wedge u'$ for the unit $u'\in P_\alpha$ orthogonal to $u$, and likewise $\omega_\beta=\pm u\wedge v$ with $v\in P_\beta$, $v\perp u$. Then $\langle u\wedge v,u\wedge u'\rangle=\det\begin{pmatrix}1&\langle u,u'\rangle\\ \langle v,u\rangle&\langle v,u'\rangle\end{pmatrix}=\langle v,u'\rangle$, and orthogonality of distinct basis elements gives $\langle v,u'\rangle=0$. With $\langle v,u\rangle=0$ by construction, $v\perp P_\alpha$. Correct as written, and the rewriting of $\omega_\alpha$ in the adapted frame is legitimate because a plane has exactly two unit decomposable forms, $\pm$ each other.

**Step (2), exactly two orthogonal shared lines with $n-2$ neighbours on each.** For neighbours $\beta,\beta'$ of $\alpha$ with shared unit directions $u,u'\in P_\alpha$ and second directions $v,v'\perp P_\alpha$, step (1) kills the cross terms: $\langle u,v'\rangle=\langle v,u'\rangle=0$. Hence

$$\operatorname{tr}(\Pi_\beta\Pi_{\beta'})=\langle u,u'\rangle^2+\langle v,v'\rangle^2,\qquad \langle\omega_\beta,\omega_{\beta'}\rangle=\langle u,u'\rangle\langle v,v'\rangle=0 .$$

If $0<\lvert\langle u,u'\rangle\rvert<1$ the second equation forces $\langle v,v'\rangle=0$ and the first leaves $\operatorname{tr}=\langle u,u'\rangle^2\in(0,1)$, against integrality. So any two shared lines are parallel or orthogonal, and in a two-plane a family of pairwise parallel-or-orthogonal lines has at most two members. Both parts correct.

Compressing completeness by $\Pi_\alpha$ gives the count. For a neighbour, $\Pi_\alpha\Pi_\beta\Pi_\alpha=u_\beta u_\beta^{\mathsf T}$. For a non-neighbour, $\operatorname{tr}=0$ forces $\Pi_\alpha\Pi_\beta=0$, so the term vanishes. The $\beta=\alpha$ term is $\Pi_\alpha$. So

$$\sum_{\beta\sim\alpha}u_\beta u_\beta^{\mathsf T}=(n-1)\Pi_{P_\alpha}-\Pi_{P_\alpha}=(n-2)\Pi_{P_\alpha},$$

whose trace is the degree $2(n-2)$ and which, being $(n-2)$ times a rank-two projection with $n\ge3$, has rank two. **This rank is what excludes a single shared line**, since one line would give $\sum_\beta u_\beta u_\beta^{\mathsf T}=k\,xx^{\mathsf T}$ of rank one, and it is what then splits the count: writing the two orthogonal lines as $\mathbb Rx,\mathbb Ry$ with $x,y$ an orthonormal basis of $P_\alpha$, $a\,xx^{\mathsf T}+b\,yy^{\mathsf T}=(n-2)(xx^{\mathsf T}+yy^{\mathsf T})$ gives $a=b=n-2$.

*Elision, first of two.* The prose asserts "the shared directions take exactly two orthogonal lines" as the step's headline and only later says "whose two-line split forces $n-2$ on each", so the sentence that rules out a single line, namely the rank of $(n-2)\Pi_{P_\alpha}$, appears nowhere. The step is true and one clause repairs it. This is a writing defect and not a gap in the mathematics.

**Step (3), orthonormal second directions, saturation and the inherited completeness.** Fix the line $\mathbb Rx$ and let $\beta,\beta'$ be two of its $n-2$ neighbours. Then $\langle u_\beta,u_{\beta'}\rangle=\pm1$, so step (2)'s formula gives $\operatorname{tr}(\Pi_\beta\Pi_{\beta'})=1+\langle v_\beta,v_{\beta'}\rangle^2$, and integrality forces the value $1$ and $\langle v_\beta,v_{\beta'}\rangle=0$. Distinct indices give distinct planes, since $P_\beta=P_{\beta'}$ would make $\omega_\beta=\pm\omega_{\beta'}$ against orthonormality. So the $v_\beta$ are $n-2$ orthonormal vectors in the $(n-2)$-dimensional $P_\alpha^\perp$, hence a basis of it.

The planes containing $x$ are $P_\alpha$ and those $n-2$ neighbours, so $x$ lies in $n-1$ of them. Applying completeness to the unit vector $x$,

$$\sum_\gamma\lvert\Pi_{P_\gamma}x\rvert^2=\sum_\gamma\langle x,\Pi_{P_\gamma}x\rangle=n-1,$$

each term lying in $[0,1]$ and equal to $1$ exactly when $x\in P_\gamma$. The $n-1$ planes through $x$ already supply $n-1$, so every other plane has $\Pi_{P_\gamma}x=0$, that is $x\perp P_\gamma$. **This is the step's real content and it is correct**: without it a plane could be neither through $x$ nor perpendicular to $x$, and integrality alone against $P_\alpha$ does not exclude that for planes far from $\alpha$.

Counting, $\binom n2-(n-1)=\binom{n-1}2$ planes remain, all inside $x^\perp$, orthonormal, decomposable, and integral because integrality is inherited by any sub-family. Their completeness is derived, not assumed: the planes through $x$ are $\mathrm{span}\{x,y\}$ and the $\mathrm{span}\{x,v_\beta\}$, whose projections sum to

$$(n-1)xx^{\mathsf T}+yy^{\mathsf T}+\sum_\beta v_\beta v_\beta^{\mathsf T}=(n-1)xx^{\mathsf T}+\Pi_{x^\perp},$$

because $x^\perp=\mathbb Ry\oplus P_\alpha^\perp$ as an orthogonal sum of dimensions $1+(n-2)$. Subtracting from $(n-1)\mathrm{Id}=(n-1)xx^{\mathsf T}+(n-1)\Pi_{x^\perp}$ leaves $(n-2)\Pi_{x^\perp}$, which is exactly the completeness relation of $\Lambda^2\mathbb R^{n-1}$. **So the sub-configuration inherits exactly the hypotheses the induction consumes, and none of them is assumed.** As it happens the derivation is belt and braces, since completeness follows from being an orthonormal decomposable basis by given 1 anyway.

**The base $n=3$.** Every element of $\Lambda^2\mathbb R^3$ is decomposable, $\Lambda^4\mathbb R^3$ being zero. The Hodge star is an isometry $\Lambda^2\mathbb R^3\to\mathbb R^3$ in this normalisation, taking $e_i\wedge e_j$ to $\pm e_k$, so an orthonormal basis $\omega_1,\omega_2,\omega_3$ goes to an orthonormal frame $f_1,f_2,f_3$, and the plane of $\omega_i$ is $(\star\omega_i)^\perp=\mathrm{span}\{f_j,f_k\}$. The base holds and, notably, holds without integrality: at $n=3$ every orthonormal decomposable basis is a coordinate configuration. Correct as written.

**Step (4), aligning the pencil with the recursive frame.** The induction supplies an orthonormal frame $f_1,\dots,f_{n-1}$ of $x^\perp$ whose coordinate two-planes are exactly the remaining $\binom{n-1}2$ planes. Each plane through $x$ is $\mathrm{span}\{x,w\}$ with $w$ a unit vector of $x^\perp$, and since every $Q=\mathrm{span}\{f_i,f_j\}$ lies in $x^\perp$,

$$\operatorname{tr}(\Pi_{\mathrm{span}\{x,w\}}\Pi_Q)=\lvert\Pi_Qx\rvert^2+\lvert\Pi_Qw\rvert^2=c_i^2+c_j^2,\qquad w=\sum_i c_if_i,\ \sum_ic_i^2=1 .$$

Integrality gives $c_i^2+c_j^2\in\{0,1\}$ for every pair. If two coefficients $c_i,c_j$ are nonzero then $c_i^2+c_j^2=1$ and every other coefficient vanishes. Taking the pair $(i,k)$ with $k\notin\{i,j\}$ gives $c_i^2\in\{0,1\}$, hence $c_i^2=1$ and $c_j=0$, a contradiction. So exactly one coefficient is nonzero and $w=\pm f_i$. The $n-1$ planes through $x$ are then $n-1$ distinct members of the $n-1$ available $\mathrm{span}\{x,f_i\}$, so they are all of them, and $\{x,f_1,\dots,f_{n-1}\}$ is a frame whose $\binom n2$ coordinate planes are exactly the configuration. Correct.

*Elision, second of two.* **The third index $k$ must exist, so step (4) needs $n-1\ge3$.** At $n-1=2$ the constraint set is only $c_1^2+c_2^2=1$, which every unit $w$ satisfies, and the argument gives nothing. The proof is not damaged, because the recursion invokes step (4) only for $n\ge4$ and $n=3$ is the base case, but the prose states neither the requirement nor the reason the base case has to be handled by the Hodge star rather than by the same coefficient argument. This is precisely where a counterexample would have to live, so the condition deserves to be written down.

**Verdict on C5.** The four steps and the induction establish the theorem. Nothing in them assumes what it should derive, and the two elisions are both repairable by one clause each.

## 6. Vacuity and triviality

**Not vacuous.** The coordinate configuration at any $n\ge3$ satisfies every hypothesis: orthonormal, all decomposable, complete with $\sum\Pi=(n-1)\mathrm{Id}$ since each $e_i$ lies in $n-1$ coordinate planes, and integral since two distinct coordinate planes share one index or none. This review checked all five hypotheses of the Lean statement literally at $n=3,4,5,6$, including the determinant form of orthogonality, and the conclusion holds with $f=e$.

**Not trivially true either.** For the conclusion to be automatic, every orthonormal decomposable basis of $\Lambda^2\mathbb R^n$ would have to be coordinate. Given 4's rotated witness is one that is not, for any $\sin 2t\ne0$, and this review verified from scratch that its six forms are orthonormal, all decomposable, and complete. A wider family makes the same point: for ANY rotation $R\in SO(3)$ of $e_1^\perp$ at $n=4$, the six planes $\mathrm{span}\{e_1,Re_i\}$ together with the three coordinate planes of $e_1^\perp$ form an orthonormal decomposable basis with $\sum\Pi=3\,\mathrm{Id}$, and integrality is what cuts this three-parameter family down to signed permutations. So the integrality hypothesis carries the whole theorem, and the theorem's content is the rigidity.

**What vacuity would look like.** It would take an incompatibility between integrality and the other hypotheses, so that the hypothesis set had no model. Then the statement would still be provable in Lean by deriving a contradiction from the hypotheses, and the tell would be that no instance could be exhibited. The exhibited coordinate configuration settles that this is not the situation, and the near-miss family settles that the hypotheses are not so tight that they force the conclusion trivially.

## 7. The kernel and the spectrum

**The theorem is immune.** Its hypotheses name no eigenvalue, so a nontrivial $\ker W$ cannot reach it, and its conclusion, a frame carrying the planes, survives unchanged. Nothing in the block's proof of the theorem quietly assumes $\lambda_\alpha\ne0$ or simplicity.

**The reformulation is where the kernel bites, in two ways.**

- The configuration is defined only once a decomposable orthonormal eigenbasis is CHOSEN, and the kernel is an eigenspace like any other, so the choice includes a basis of $\ker W$ that must itself be decomposable. A kernel of dimension $\ge2$ therefore contributes reselection freedom to the sup, in the same way as any other repeated eigenvalue. Given 7 does not directly constrain it, because the requirement is that SOME orthonormal basis of the eigenspace be decomposable, which is weaker than every element being decomposable.
- A kernel of dimension $\ge2$ removes the simple-spectrum branch outright, so the "single scalar equation" reading is unavailable exactly in the case this record calls its recurring obstruction.

## 8. Necessity, and integrality as a property of the basis

**Necessity holds.** Two distinct coordinate planes $\mathrm{span}\{e_i,e_j\}$ and $\mathrm{span}\{e_k,e_l\}$ have $\operatorname{tr}(\Pi\Pi')=\lvert\{i,j\}\cap\{k,l\}\rvert\in\{0,1\}$. So a coordinate configuration is integral, and with the theorem the two conditions are equivalent.

**Integrality is a property of the chosen basis, and the witness proves it exactly as the block says.** Given 4's Ricci-flat weights, in the brief's order, are $(\tfrac12,\tfrac12,-1,-1,\tfrac12,\tfrac12)$. Reading them onto planes, $\lambda_{12}=\lambda_{13}=\lambda_{24}=\lambda_{34}=\tfrac12$ and $\lambda_{14}=\lambda_{23}=-1$, and all four Ricci rows vanish: $\tfrac12+\tfrac12-1=0$ at each index. The operator is coordinate-diagonal, its $\tfrac12$-eigenspace is four-dimensional and contains both $e_1\wedge g_2$ and $e_1\wedge g_3$, so the rotated family IS an orthonormal decomposable eigenbasis of the same operator. Its configuration is not integral, and the exact value of the invariant is

$$\Xi=44+4(\cos^4t+\sin^4t)=48-2\sin^2 2t,$$

which equals $48=n^2(n-1)$ precisely at $\sin2t=0$. So $\Xi$ separates the two eigenbases of one coordinate-diagonal operator, and it cannot be a function of $W$. **No finding: the block's claim and its proof are both right, and the witness measures the failure.**

## 9. The $\sup\Xi$ reformulation

**Unique up to signs at simple spectrum.** For a symmetric operator with $\binom n2$ distinct eigenvalues, every eigenspace is a line and an orthonormal eigenbasis is determined up to the sign of each vector. Since $\Pi_\alpha=\omega_\alpha\omega_\alpha^{\mathsf T}$ is insensitive to the sign, $\Xi$ is then a function of $W$ alone. Correct.

**Both directions of the sup statement hold, conditionally on the theorem.** If $W$ is coordinate-diagonal in a frame $f$, the coordinate bivectors $f_i\wedge f_j$ are an orthonormal decomposable eigenbasis, and any two orthonormal eigenbases are related by an element of $\prod_\mu O(\dim E_\mu)$, so that configuration is admissible and $\Xi$ attains $n^2(n-1)$. Conversely, the admissible set is a closed subset of the compact $\prod_\mu O(\dim E_\mu)$, cut out by the decomposability equations, so it is compact and a continuous $\Xi$ attains its supremum: a sup of $n^2(n-1)$ is achieved at an integral configuration, and the theorem turns that into a common frame in which every eigen-plane is a coordinate plane, which is coordinate-diagonality. The block's phrase "reselections admissible inside the eigenspaces" is the right guard, since a bare element of $\prod_\mu O(\dim E_\mu)$ generically produces non-decomposable basis vectors, where $\Xi$ is not defined.

**The payoff clause fails at $n=4$, and this is the review's substantive finding.** Take a coordinate-diagonal $W\in\mathcal W_4$, with weights $\lambda_{ij}$ on the six coordinate planes. First Bianchi is automatic, each $e_i\wedge e_j$ being decomposable, so by given 6 every term of $\mathrm{Alt}(W)$ vanishes. Ricci-flatness is the four equations $\sum_{j\ne i}\lambda_{ij}=0$, whose solution space is

$$\lambda_{12}=\lambda_{34}=a,\qquad \lambda_{13}=\lambda_{24}=b,\qquad \lambda_{14}=\lambda_{23}=c,\qquad a+b+c=0 .$$

Opposite-plane weights are forced equal, so **the spectrum of a coordinate-diagonal Ricci-flat $W$ at $n=4$ is $a,a,b,b,c,c$ and is never simple.** Two consequences for the block's last two sentences.

- At $n=4$ the sentence "where the spectrum is simple ... coordinate-diagonality is exactly the single equation $\Xi(W)=n^2(n-1)$" is true and empty: both sides are false for every $W$ with simple spectrum, so the equation has no solutions there and can only ever return the negative answer.
- Therefore at $n=4$ the claim that this "meets I73's target from the other side" is the wrong way round. Establishing spectral simplicity at a maximiser at $n=4$ would establish that the maximiser is NOT coordinate-diagonal, which is the opposite of what I36 wants. Simplicity and coordinate-diagonality are mutually exclusive at $n=4$, so the two targets cannot be composed there.

The obstruction is specific to $n=4$ and does not extend. At $n=5$ the map from edge weights to vertex sums on $K_5$ has a five-dimensional kernel in which no coordinate coincidence is forced: $\lambda_{12}-\lambda_{34}$ is not in the row space, and an explicit Ricci-flat coordinate-diagonal weight vector with all ten weights distinct is $(\lambda_{12},\dots,\lambda_{45})=(39,26,-29,-36,-42,1,2,5,11,23)$. So the single-equation branch is non-empty for $n\ge5$ and the recommendation is to state the reformulation's payoff for $n\ge5$ and to drop the $n=4$ reading of I73.

A second, sharper reason to be careful at $n=4$: the same weights give $\theta$ a hard cap on the coordinate-diagonal locus. With $\mathcal A=\mathcal B=\mathrm{diag}(a,b,c)$ and $a+b+c=0$, given 3 gives $W^\#\vert_{\Lambda^\pm}=2\,\mathrm{diag}(a^2,b^2,c^2)-(a^2+b^2+c^2)\mathrm{Id}_3$, so with $q=a^2+b^2+c^2$ and $r=a^3+b^3+c^3=3abc$,

$$\lVert W\rVert^2=2q,\qquad \operatorname{tr}(W^3)=2r,\qquad \langle W,W^\#\rangle=4r,\qquad \theta=\frac{6r}{(2q)^{3/2}}=\frac{18abc}{(2q)^{3/2}} .$$

Because $a+b+c=0$, the three numbers are the roots of $x^3-\tfrac q2x-abc$, whose non-negative discriminant gives $(abc)^2\le q^3/54$, hence $\lvert\theta\rvert\le 18/(\sqrt{54}\cdot2^{3/2})=18/(12\sqrt3)=\sqrt3/2=\theta_0(4)$, attained at $(a,b,c)=(-1,-1,2)$ up to scale. **So no coordinate-diagonal Ricci-flat $W$ at $n=4$ has $\theta$ above $\theta_0(4)=0.866025$, let alone above $\sqrt{3/2}=1.224745$.** This is consistent with I36 being a reductio engine rather than a defect in the block, and it is the reason the $n=4$ instance of I36 can only be discharged by way of a contradiction. It is worth writing into the block, because it says what a successful I36 at $n=4$ delivers.

## 10. The $W_{\mathbb{CP}^2}$ paragraph

**The $\Lambda^4$ test and its necessity.** If $W$ has an orthonormal decomposable eigenbasis then so does every $W^k$, with eigenvalues $\lambda_\alpha^k$, and given 6 makes $\mathrm{Alt}(W^k)=\tfrac16\sum_\alpha\lambda_\alpha^k\,\omega_\alpha\wedge\omega_\alpha=0$ term by term. So $\mathrm{Alt}(W^k)\ne0$ for a single $k$ refutes the existence of such a basis. The direction the block needs is the correct one.

**The chirality reading at $n=4$.** For unit $\omega\in\Lambda^\pm$ the record's wedge is $\pm1$ times the volume form: at $\omega=\tfrac1{\sqrt2}(e_{12}+e_{34})$ the Pfaffian is $\tfrac12$ and the wedge, being twice it, is $1$, and the anti-self-dual sign is $-1$. So for symmetric $A$ on $\Lambda^2\mathbb R^4$,

$$\mathrm{Alt}(A)=\tfrac16\sum_\alpha\mu_\alpha\big(\lvert\omega_\alpha^+\rvert^2-\lvert\omega_\alpha^-\rvert^2\big)\,\mathrm{vol}=\tfrac16\big(\operatorname{tr}(A\Pi_+)-\operatorname{tr}(A\Pi_-)\big)\,\mathrm{vol},$$

and with $A=W^2$ and $W$ block diagonal this is $\tfrac16(\lVert W^+\rVert^2-\lVert W^-\rVert^2)\mathrm{vol}$. **The proportionality claim is correct.** The one slip is a normalisation: the block writes that $\mathrm{Alt}(W^2)$ "equals $\lVert W\rVert^2$", whereas $\mathrm{Alt}(W^2)=\tfrac16\lVert W\rVert^2\,\mathrm{vol}=c^2\,\mathrm{vol}$ and it is the trace difference that equals $\lVert W\rVert^2$. Read with "which" bound to the trace difference the sentence is exact, so this is an ambiguity to tighten rather than an error of substance, and the conclusion $\mathrm{Alt}(W^2)\ne0$ is untouched.

**The values, all exact.** With $\mathcal A=c\,\mathrm{diag}(2,-1,-1)$, $c>0$, and $\mathcal B=0$:

| quantity | value |
|---|---|
| $\lVert W\rVert^2=\operatorname{tr}(\mathcal A^2)+\operatorname{tr}(\mathcal B^2)$ | $6c^2$ |
| $\operatorname{tr}(W^3)$ | $6c^3$ |
| $W^\#\vert_{\Lambda^+}=2\mathcal A^2-\operatorname{tr}(\mathcal A^2)\mathrm{Id}_3$ | $c^2\,\mathrm{diag}(2,-4,-4)$ |
| $\langle W,W^\#\rangle$ | $12c^3$ |
| $P=\operatorname{tr}(W^3)+\langle W,W^\#\rangle$ | $18c^3$ |
| $\theta=P/\lVert W\rVert^3$ | $18/6^{3/2}=3/\sqrt6=\sqrt{3/2}$ |
| $\lVert W^+\rVert^2-\lVert W^-\rVert^2$ | $6c^2=\lVert W\rVert^2$ |
| $\mathrm{Alt}(W)=\tfrac16(\operatorname{tr}\mathcal A-\operatorname{tr}\mathcal B)$ | $0$, so first Bianchi holds |

Every entry reproduces the block. The pair of last two rows is the point: Bianchi holds at the level of $W$ and fails at the level of $W^2$.

**The conclusion is correct, with one qualification the block itself states.** $W_{\mathbb{CP}^2}$ is a critical point and a local maximum by given 5, and it has no orthonormal decomposable eigenbasis, so that property does not follow from criticality or from local maximality. Its value is $\theta=\sqrt{3/2}$ exactly, so it sits AT the threshold and not above it, and it therefore leaves the strict-threshold conditional untouched. The block says exactly this when it says the link "must consume the strict threshold".

**The contrast claim is right.** Section 9 derives it: a coordinate-diagonal Ricci-flat $W$ at $n=4$ has $\lambda_{12}=\lambda_{34}$, $\lambda_{13}=\lambda_{24}$, $\lambda_{14}=\lambda_{23}$, hence $\mathcal A=\mathcal B=\mathrm{diag}(a,b,c)$ in the respective chirality bases, so $\lVert W^+\rVert^2-\lVert W^-\rVert^2=0$ and the test passes. The contrast with $\mathcal B=0$ is as sharp as the block says.

## 11. What would break the theorem, and what was done to look for it

**The falsifier.** An orthonormal basis $\{\omega_\alpha\}_{\alpha=1}^{\binom n2}$ of $\Lambda^2\mathbb R^n$, $n\ge3$, with every $\omega_\alpha$ decomposable and every $\operatorname{tr}(\Pi_\alpha\Pi_\beta)\in\{0,1\}$ for $\alpha\ne\beta$, whose $\binom n2$ planes are not the coordinate two-planes of any single orthonormal frame of $\mathbb R^n$.

**Where it would have to hide.** Steps (1) to (3) are unconditional consequences of integrality, so any falsifier has the local structure they describe: every index has $2(n-2)$ neighbours split $n-2$ and $n-2$ across two orthogonal lines of its own plane, every direction of a plane lies in $n-1$ planes and is perpendicular to all the others, and the planes missing a chosen direction $x$ form an integral orthonormal decomposable basis of $\Lambda^2(x^\perp)$. So a falsifier at $n$ produces, by induction, a coordinate frame of $x^\perp$ and must break step (4): a plane $\mathrm{span}\{x,w\}$ with $w$ misaligned with that frame. Section 5 shows this needs $c_i^2+c_j^2\in\{0,1\}$ for every pair of coefficients of $w$, which is satisfiable with more than one nonzero coefficient only when the frame has exactly two members, that is only at $n-1=2$. **The single pressure point of the whole theorem is the interface between step (4) and the base case.**

**What was done.** Two constructions, both closed form, both screened exactly rather than searched.

- Given 4's rotated witness, the record's own non-coordinate orthonormal decomposable basis, which is exactly a step-(4) misalignment at $n=4$: its trace table is in section 1, four entries are $\cos^2t$ or $\sin^2t$, and $\Xi=48-2\sin^2 2t<48$ for $\sin2t\ne0$. It is a near-miss and not a counterexample.
- The three-parameter family that generalises it: for any $R\in SO(3)$ acting on $e_1^\perp$ at $n=4$, the planes $\mathrm{span}\{e_1,Re_i\}$ plus the three coordinate planes of $e_1^\perp$ form an orthonormal decomposable basis with $\sum\Pi=3\,\mathrm{Id}$ for every $R$. Writing $R$ in Euler angles $(\alpha,\beta,\gamma)$, the first cross trace is $\cos^2\beta$, whose integrality already forces $\cos^2\beta\in\{0,1\}$, and the remaining eight cross traces are of the same shape. This is step (4)'s coefficient argument seen as an explicit constraint system, and it has only the signed-permutation solutions.

**Not searched, and deliberately.** Under the analysis-only footing no sweep over configurations was run. The claim recorded here is the structural one, that a falsifier must be a step-(4) misalignment, plus the closed-form verification that the record's own candidate is not one.

## The Lean file, statement by statement

| Declaration | Is it the prose claim it is named for? |
|---|---|
| [sum_trace_off](../lean/HamiltonsCubic/Results/L201Statement.lean) | **Wider, and it contains the prose claim.** It assumes only $P\,a\cdot P\,a=P\,a$, $\operatorname{tr}(P\,a)=2$ and $\sum_aP\,a=(n-1)\cdot 1$, with no symmetry and no bivector anywhere, and concludes $2(n-2)$. The plane projections satisfy all three, so the prose identity is an instance. Two honest observations: completeness is a HYPOTHESIS here rather than a consequence of being a basis, which is where given 1 would have to enter, and the index count $N$ is unconstrained but pinned to $\binom n2$ by the trace of the hypothesis, so the statement is not spuriously general. |
| [sum_sq_le_sum](../lean/HamiltonsCubic/Results/L201Statement.lean) and [sum_sq_eq_sum_iff](../lean/HamiltonsCubic/Results/L201Statement.lean) | **Strictly weaker: the scalar kernel only.** They are the correct statements that $\sum t^2\le\sum t$ on $[0,1]$ with equality exactly at $t\in\{0,1\}$. What the prose bullet claims and these do not: that $t_{\alpha\beta}=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$ lies in $[0,1]$, which is the geometric content and needs $\Lambda^2$-orthogonality; the identification of $\Xi$ with the tensor norm; the diagonal contribution $2n(n-1)$; and the constant $n^2(n-1)$, which appears nowhere in the file. The file's own docstring says as much, calling them "the scalar half". |
| [integrality_forces_frame](../lean/HamiltonsCubic/Results/L201Statement.lean) | **The prose theorem, faithfully, with the proof as the gap.** `hu`, `hv`, `huv` make each pair orthonormal, so each $\omega_a$ is a unit decomposable form and `planeProj` is genuinely the plane projection; `horth` is exactly $\det M=0$, which section 2 confirms is $\Lambda^2$-orthogonality in the record's normalisation; `hint` is integrality; `hcomplete` stands in for basis-ness and is equivalent to it here, since $\binom n2$ orthonormal elements of a $\binom n2$-dimensional space are a basis. Two fine points: the conclusion asserts that every plane IS a coordinate plane of one frame without asserting that $a\mapsto\{i\,a,j\,a\}$ is a bijection, which follows from the planes being distinct and equal in number to the coordinate planes, so the letter is marginally weaker than the prose's "exactly its coordinate two-planes"; and $N$ is again pinned by the trace of `hcomplete`. |

Built clean at commit time with `lake build HamiltonsCubic.Results.L201Statement`. Axiom check: `sum_trace_off`, `sum_sq_le_sum` and `sum_sq_eq_sum_iff` each depend on `propext, Classical.choice, Quot.sound` and nothing else, so they carry no gap axiom, and `integrality_forces_frame` depends additionally on `sorryAx`, so the theorem is stated and not proved in the layer.

## Verdict

**The written chain holds link by link.** The two identities are exact and this review re-derived both from completeness alone, the principal-angle reading is correct in the record's normalisation including the factor, the scalar bound and its equality case are sound, and the theorem's four steps and induction do establish that integrality forces a common frame, with the sub-configuration inheriting exactly the hypotheses the induction consumes and its completeness derived rather than assumed. The theorem is neither vacuous nor trivial, and the reformulation of "diagonal in some frame" as an extremal case is real.

**Three things to change in the block, none of them fatal.**

1. **Add the rank clause to step (2)** that excludes a single shared line, since "exactly two orthogonal lines" is asserted before the argument that gives it, and the argument is that $(n-2)\Pi_{P_\alpha}$ has rank two for $n\ge3$.
2. **State that step (4) needs $n-1\ge3$**, and say that this is why the base case is $n=3$ and is discharged by the Hodge star. This is the theorem's single pressure point and the place a counterexample would have to live.
3. **Restrict the payoff clause to $n\ge5$.** At $n=4$ a coordinate-diagonal Ricci-flat $W$ has spectrum $a,a,b,b,c,c$ with $a+b+c=0$, so simple spectrum and coordinate-diagonality exclude each other, the "single scalar equation $\Xi(W)=n^2(n-1)$" can only return the negative answer, and I73 cannot serve I36 there. At $n\ge5$ the branch is non-empty, witnessed by the distinct weights $(39,26,-29,-36,-42,1,2,5,11,23)$ on $K_5$. While that paragraph is being rewritten, the same weights give the cap $\theta\le\theta_0(4)=\sqrt3/2$ on the coordinate-diagonal locus at $n=4$, which is worth recording because it says what a successful I36 at $n=4$ actually delivers.

**Two smaller repairs.** Declare that the inner product on the $\Pi_\alpha$ is the plain $\operatorname{tr}(AB)$ rather than the brief's $\tfrac12\operatorname{tr}$, which the value $n^2(n-1)$ requires. And bind the "equals $\lVert W\rVert^2$" of the $W_{\mathbb{CP}^2}$ sentence to the trace difference rather than to $\mathrm{Alt}(W^2)$, which carries given 6's factor $\tfrac16$.

**On the Lean layer.** The three proved statements carry no gap axiom, `sum_trace_off` is a faithful and slightly wider abstraction of the per-index identity, the two scalar lemmas are the arithmetic kernel and not the geometric bullet they sit under, and the theorem is typed correctly and unproved. The gap between the file and the block is therefore exactly the theorem, which is the honest place for it.
