# Review r836: Gate 2 on the Lefschetz route to the surviving rank-three question

*Cold brief: I worked from [BRIEF](/tmp/brief_r836.md), derived every step by hand before opening [findings/diagonal-half.md](../findings/diagonal-half.md) to confirm the quotation, and I read neither the sibling reviewer's log nor its report. **Two screens were run**, both permitted under the analysis-only rule as screening of claims I was about to record: one on the closed-form $\dim=8$ object of section 9, one on the $\dim=4$ quaternionic triple of section 3. Both objects were constructed by hand first and the screens confirm arithmetic I had already done, so nothing below rests on them. Log: [agent_logs/g2-lefschetz-r836.log](../agent_logs/g2-lefschetz-r836.log). **One disclosure**: the session scratchpad is shared with a concurrent agent, my second screen file was overwritten by a file of the same name belonging to another agent, and I saw that file's output before noticing. Every finding below was derived before either screen was written, and I moved to a private subdirectory on noticing. I read [REVIEW_r834.md](REVIEW_r834.md) and [REVIEW_r835.md](REVIEW_r835.md), which are prior rounds cited by the block, to avoid re-reporting known material.*

## Claim table

| # | Claim under audit | Verdict |
|---|---|---|
| 1 | Hard Lefschetz on a symplectic vector space is linear algebra, needing only nondegeneracy | **CORRECT, AND IT IS THE VECTOR-SPACE STATEMENT. THE RANGE IS OMITTED: THE ISOMORPHISM IS $L^{m-k}:\Lambda^k\to\Lambda^{2m-k}$ FOR $0\le k\le m$ ONLY** |
| 2 | $L:\Lambda^2\to\Lambda^4$ is injective at every $m\ge3$ because $L^{m-2}$ factors through it | **CORRECT. THE ISOMORPHISM NEEDS $m\ge2$, THE FACTORING NEEDS $m\ge3$, AND AT $m=3$ IT IS THE TRIVIAL FACTORING $L^1=\mathrm{id}\circ L$** |
| 3 | At $m=2$, $L$ maps six dimensions to one and is never injective, which is where the witness lives | **CORRECT AND UNDER-STATED. $\ker L_\gamma$ IS THE FIVE-PLANE $(\star\gamma)^\perp$, THE WITNESS'S $\alpha$ LIES IN IT, AND $\alpha$ IS NONDEGENERATE, WHICH IS THE SHARP FAILURE. THE PRIORITY CLAIM IS RHETORIC** |
| 4 | $\omega_2=\pm\omega_1$ contradicts trace-orthogonality | **CORRECT. $\langle\omega_1,\omega_2\rangle=\pm m\ne0$ AT EVERY $m\ge1$, AND THE BLOCK'S $\operatorname{tr}(J_1J_2)=\mp2m$ CARRIES THE RIGHT SIGN** |
| 5 | $T=-J_1J_2$ orthogonal, $J_1\pm J_2=J_1(I\pm T)$, and $\operatorname{tr}T=0$ is trace-orthogonality | **ALL THREE CORRECT AND THE SIGN ASSIGNMENT IS RIGHT: $J_1-J_2$ SINGULAR IS $+1\in\operatorname{spec}T$. THE IDENTITY $\operatorname{tr}T=2\langle\omega_1,\omega_2\rangle$ IS INDEPENDENT OF WHICH OF THE TWO $\omega_J$ SIGN CONVENTIONS IS USED** |
| 6 | $J_1TJ_1^{-1}=T^{-1}$, hence $E_\pm$ are $J_1$-invariant and even-dimensional | **DERIVATION CORRECT. EVENNESS IS $J_1^2=-I$ ON AN INVARIANT PIECE AND USES NOTHING OF $T$. ORTHOGONALITY OF $T$ IS LOAD-BEARING ELSEWHERE, FOR $E_+\perp E_-\perp R$ AND FOR $R$ TO EXIST AT ALL** |
| 7 | $J_2=J_1$ on $E_+$ and $J_2=-J_1$ on $E_-$ | **BOTH CORRECT. $E_\pm$ ARE $J_2$-INVARIANT AUTOMATICALLY, AND THAT IS NEEDED, THOUGH THE SHORTER ROUTE IS $\ker\alpha=E_+$ AND $\ker\beta=E_-$ EXACTLY** |
| 8 | $\alpha$ is $2\omega_1$ on $E_-$ and zero on $E_+$, cross terms vanishing by invariance and orthogonality | **THE STATED REASON IS THE RIGHT ONE AND IT COVERS THE $R$ CROSS TERMS TOO. INCOMPLETE AS A DESCRIPTION OF $\alpha$: THE $\Lambda^2R$ BLOCK IS OMITTED, AND THE NEXT PARAGRAPH SILENTLY RESTORES IT** |
| 9 | If $R=0$ then $\alpha\wedge\beta$ has $\alpha\otimes\beta\ne0$ in $\Lambda^2E_-\otimes\Lambda^2E_+$, a contradiction | **THE ARGUMENT IS CORRECT AND $R=0$ IS NOT USED BY ANY PART OF IT. SEE D1** |
| 10 | The surviving shape is $\pm1$ present with even multiplicity and $R\ne0$, at all three pairs at once | **THE INHERITANCE TO THREE PAIRS IS CORRECT. THE SHAPE IS EMPTY, SO THE CONCLUSION IS VOID. THE CHEAP FACT AT $m=4$ IS THE COCYCLE $T_{12}T_{23}=T_{13}$, WHICH IS NOT NEEDED** |
| 11 | Falsifiers | **NAMED. THE SECOND ONE EXISTS AND IS D1** |
| **D1** | "If $R=0$ then ... What survives the whole Lefschetz route is therefore: both $\pm1$ eigenvalues present, each with even multiplicity, AND a nontrivial rotation part, at all three pairs at once" | **REAL, AS A COMPLETENESS DEFECT RATHER THAN AN ERROR. THE SAME COMPONENT COMPUTATION WITH $R\ne0$ FORCES $E_+=0$ OR $E_-=0$, SO ONE OF $\alpha,\beta$ IS NONDEGENERATE AND THE BLOCK'S OWN LEFSCHETZ STEP CLOSES THE BRANCH. NOTHING SURVIVES AT ANY $m\ge3$** |
| **D2** | $\operatorname{tr}T=0$ "permits both and forbids neither" | **TRUE AND A STRICT WEAKENING. IN FULL IT READS $p-q+\sum_j\cos\theta_j=0$, WHICH FORCES $\dim E_+=\dim E_-=m$ WHENEVER $R=0$ AND FORBIDS $R=0$ OUTRIGHT AT ODD $m$** |

## One line someone can act on

**The block is step-for-step correct and stops one line short of its own conclusion.** The $\Lambda^2E_-\otimes\Lambda^2E_+$ component of $\alpha\wedge\beta$ is $\alpha|_{E_-}\otimes\beta|_{E_+}$ whether or not $R$ vanishes, because $\ker\alpha=E_+$ and $\ker\beta=E_-$ leave no other way to split four indices between the two factors, so $\alpha\wedge\beta=0$ forces $E_+=0$ or $E_-=0$, one of $\alpha,\beta$ is nondegenerate, and the block's own Lefschetz injectivity then gives $J_2=\pm J_1$. **The surviving rank-three question is EMPTY at every $m\ge3$, and $m=2$ is the only inhabited value.** [L195](../findings/diagonal-half.md)'s closing "OPEN at $m\ge4$" should be retired.

## Conventions, fixed before anything was derived

| object | reading used here | source |
|---|---|---|
| inner product on $2$-forms | $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ | brief, and [conventions.md](../findings/conventions.md) |
| complex structure | $J$ orthogonal and skew, so $J^2=-I$ and $J^{\mathsf T}=-J=J^{-1}$ | brief |
| the $2$-form of $J$ | $\omega_J(x,y)=\langle Jx,y\rangle$, so its matrix is $(\omega_J)_{ij}=\langle Je_i,e_j\rangle=J_{ji}$, that is $J^{\mathsf T}=-J$ | brief |
| norm | $\lVert\omega_J\rVert^2=\tfrac12\operatorname{tr}(J^{\mathsf T}J)=\tfrac12\operatorname{tr}I=m$ | brief, checked |
| the wedge of two $2$-forms | $(a\wedge b)_{ijkl}=\tfrac12\big(a_{ij}b_{kl}+b_{ij}a_{kl}-a_{ik}b_{jl}-b_{ik}a_{jl}+a_{il}b_{jk}+b_{il}a_{jk}\big)$, the `wbil` of [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) | Lean file on disk |
| symmetry | manifest in that formula, and $(a-b)\wedge(a+b)=a\wedge a-b\wedge b$ is `wbil_sub_add` | Lean file on disk |
| $L_\gamma$ | $\gamma\wedge\cdot$, in any fixed normalisation of $\wedge$, every claim below being invariant under rescaling $\wedge$ | block |
| $T$ | $-J_1J_2$, with $E_\pm=\ker(T\mp I)$ and $R=(E_+\oplus E_-)^\perp$ | block |

*One convention the block leaves open and which matters to item 1: the "adjoint" of $L$ needs a pairing on $\Lambda^\bullet$, and on a bare symplectic vector space the canonical choice is contraction with the dual bivector $\gamma^{-1}\in\Lambda^2W$, which needs nothing but nondegeneracy. The proof I give avoids the question entirely.*

## Hypothesis inventory

| step | hypotheses it uses | hypotheses it does NOT use |
|---|---|---|
| 1, hard Lefschetz | $\gamma$ nondegenerate, $\dim W=2m$, characteristic zero | any metric, any complex structure, closedness, compactness, a manifold |
| 2, injectivity of $L:\Lambda^2\to\Lambda^4$ | item 1 at $k=2$, and $m\ge3$ | nothing else |
| 4, the contradiction | trace-orthogonality, $m\ge1$ | equal self-wedges, the wedge at all |
| 5, 6, 7 | $J_1^2=J_2^2=-I$, and $T$ orthogonal for the orthogonal splitting only | trace-orthogonality, the wedge hypothesis |
| 8, the block structure | $E_+\perp E_-\perp R$, each $J_1$- and $J_2$-invariant | $R=0$ |
| 9 as the block writes it | all of the above plus $R=0$ | trace-orthogonality |
| 9 as it should be written (D1) | all of the above, **and nothing about $R$** | $R=0$, trace-orthogonality, $\operatorname{tr}T=0$ |

**Trace-orthogonality is spent exactly once in the whole route, at the last line of item 4.** Everything before it holds for any two orthogonal complex structures with a common self-wedge, which is why D1's theorem below carries no orthogonality hypothesis.

## 1. Hard Lefschetz on a symplectic vector space

**The block's statement is the linear-algebraic one and it is correct.** The Kähler-manifold theorem is about de Rham cohomology and needs $d\gamma=0$ and compactness. The statement here is about the exterior algebra of a single vector space, it involves no differential, and its proof uses only that $\gamma$ is nondegenerate.

**Proof, self-contained.** Let $(W,\gamma)$ be symplectic of dimension $2m$ over $\mathbb R$. Choose a symplectic basis, so $\gamma=\sum_{i=1}^m e^i\wedge f^i$. Then
$$\Lambda^\bullet W^*\;=\;\bigotimes_{i=1}^m\Lambda^\bullet\langle e^i,f^i\rangle,$$
each factor four-dimensional with basis $1,\ e^i,\ f^i,\ e^i\wedge f^i$. Set $L=\gamma\wedge\cdot=\sum_iL_i$ with $L_i=e^i\wedge f^i\wedge\cdot$, which acts only on the $i$-th factor. Inside that factor, $L_i$ sends $1\mapsto e^i\wedge f^i$ and kills $e^i\wedge f^i$, $e^i$ and $f^i$. So $\operatorname{span}\{1,e^i\wedge f^i\}$ is the two-dimensional irreducible $\mathfrak{sl}_2$-module $V_1$ with weights $-1,+1$, and $e^i,f^i$ each span a trivial module $V_0$ of weight $0$. Hence
$$\Lambda^\bullet W^*\;\cong\;(V_1\oplus V_0\oplus V_0)^{\otimes m}$$
as $\mathfrak{sl}_2$-modules, with $L$ the raising operator, the lowering operator $\Lambda$ the corresponding factorwise contraction, and $H=[L,\Lambda]$ acting on $\Lambda^kW^*$ as $k-m$ (add the weights: degree $0$ contributes $-1$, degree $2$ contributes $+1$, degree $1$ contributes $0$, over $m$ factors). Hard Lefschetz is then the standard $\mathfrak{sl}_2$ fact that in a finite-dimensional module over a field of characteristic zero the map $E^n$ from the weight $-n$ space to the weight $+n$ space is an isomorphism for every $n\ge0$.

**Exactly which $k$ and $m$.** With $n=m-k$ the statement is
$$L^{m-k}:\Lambda^kW^*\xrightarrow{\ \sim\ }\Lambda^{2m-k}W^*\qquad\textbf{for }0\le k\le m .$$
**The block states the isomorphism without a range**, which is the one gap in item 1. For $k>m$ the exponent is negative and there is nothing to assert, the content in that range being the mirror statement $L^{k-m}:\Lambda^{2m-k}\to\Lambda^k$. The omission costs nothing here because the block uses only $k=2$, and $2\le m$ holds throughout its own range $m\ge3$.

**Sources.** The result is classical and is stated for a symplectic vector space rather than a Kähler one in Dong Yan, *Hodge structure on symplectic manifolds*, Advances in Mathematics **120** (1996), section 1, whose whole point is that the $\mathfrak{sl}_2$ and the Lefschetz isomorphism are pointwise linear algebra and survive without a metric or a complex structure. The same proof, in the Hermitian dress, is in Huybrechts, *Complex Geometry: An Introduction*, section 1.2 (the "hard Lefschetz theorem for the exterior algebra"), in Griffiths and Harris, *Principles of Algebraic Geometry*, chapter 0 section 7, and in Voisin, *Hodge Theory and Complex Algebraic Geometry I*, section 6.2. *I give the proof in full above rather than lean on a page number I cannot check offline.*

**VERDICT: CORRECT, with the range $0\le k\le m$ owed.**

## 2. The injectivity step

$L^{m-2}:\Lambda^2\to\Lambda^{2m-2}$ is an isomorphism by item 1, which requires $k=2\le m$, that is $m\ge2$. Writing $L^{m-2}=L^{m-3}\circ L$ requires $m-2\ge1$, that is $m\ge3$. An injective composite forces the first factor injective, so $L:\Lambda^2\to\Lambda^4$ is injective at every $m\ge3$. **Both range constraints are as the block needs them and neither is stated.**

**At $m=3$** the factoring is $L^{m-2}=L^1$ and $\Lambda^{2m-2}=\Lambda^4$, so the map is its own iterate and the "factoring" is $L=\mathrm{id}\circ L$. That is degenerate but valid, and it is not a special case to be argued separately: $L:\Lambda^2\mathbb R^6\to\Lambda^4\mathbb R^6$ is itself the Lefschetz isomorphism, both spaces having dimension $15$.

**At $m=4$** the map is $\Lambda^2\mathbb R^8\to\Lambda^4\mathbb R^8$, dimensions $28$ and $70$, injective and far from surjective, and $L^2:\Lambda^2\to\Lambda^6$ is the isomorphism.

**At $m=2$** the argument yields nothing, $L^{m-2}=L^0$ being the identity of $\Lambda^2$, which factors through no application of $L$ at all. This is the correct place for the argument to fail.

**VERDICT: CORRECT.**

## 3. The $m=2$ exception

**What $\ker L$ is.** On $\Lambda^2\mathbb R^4$ the wedge defines a symmetric bilinear form $q$ by $\eta\wedge\zeta=q(\eta,\zeta)\,\mathrm{vol}$. It is nondegenerate of signature $(3,3)$: $\Lambda^+$ is positive definite, since $(e^{12}+e^{34})\wedge(e^{12}+e^{34})=2\,e^{1234}$, and $\Lambda^-$ negative definite, since $(e^{12}-e^{34})\wedge(e^{12}-e^{34})=-2\,e^{1234}$. Since $q(\eta,\zeta)$ is a positive multiple of $\langle\eta,\star\zeta\rangle$,
$$\ker L_\gamma=\{\eta:\gamma\wedge\eta=0\}=(\star\gamma)^{\perp}\quad\text{in the Euclidean metric},$$
a **five-dimensional hyperplane** whenever $\gamma\ne0$. The map $L_\gamma$ is nonzero precisely when $\gamma$ is nondegenerate, since $\gamma\wedge\gamma=2\operatorname{Pf}(\gamma)\,\mathrm{vol}$, so the kernel is exactly five-dimensional there.

**Whether the quaternionic triple's $\alpha$ lies in it.** Yes, and this is the sharp form of the exception. Take $\omega_1,\omega_2,\omega_3$ the quaternionic triple, each of norm $\sqrt2$ in $\Lambda^+$. Put $\beta=\omega_1+\omega_2$ and $\alpha=\omega_1-\omega_2$. Then $\beta\in\Lambda^+$, so $\star\beta=\beta$ and $\ker L_\beta=\beta^\perp$, and $\langle\alpha,\beta\rangle=\lVert\omega_1\rVert^2-\lVert\omega_2\rVert^2=0$, so $\alpha\in\ker L_\beta$. **Both $\alpha$ and $\beta$ are nondegenerate**, every nonzero element of $\Lambda^+$ being so, since $\eta\wedge\eta=\lVert\eta\rVert^2\mathrm{vol}$ there. *Screened: $\det\alpha=\det\beta=4$ and $\alpha\wedge\beta=0$ exactly.*

**So is the block's reason the right one, or a coincidence of that dimension?** It is the right one, and it understates itself. The precise obstruction is not "$L$ is not injective" but **"$\ker L_\beta$ contains a nondegenerate form"**, which is strictly stronger and is what the $m\ge3$ argument denies. At $m=2$ the five-plane $\beta^\perp$ meets $\Lambda^+$ in a two-plane, every nonzero element of which is nondegenerate, so nondegenerate elements of the kernel are abundant rather than accidental.

**The complete answer at $m=2$, which the record can have for free.** If $J$ is an orthogonal complex structure on $\mathbb R^4$ then $\omega_J^2=-I$, so $\omega_J$ has singular values $1,1$ and is a norm-$\sqrt2$ element of $\Lambda^+$ or of $\Lambda^-$ according to the orientation $J$ induces, and conversely every such element squares to $-I$. And $\omega\wedge\omega=+2\,\mathrm{vol}$ on the whole norm-$\sqrt2$ sphere of $\Lambda^+$ and $-2\,\mathrm{vol}$ on that of $\Lambda^-$. **Hence at $m=2$ equal self-wedges is exactly "same orientation", and the solution set of the surviving question is exactly an orthogonal triple inside $\Lambda^+$ or inside $\Lambda^-$, scaled to norm $\sqrt2$.** That is the quaternionic triple up to $\mathrm O(4)$, and it explains "INHABITED at $m=2$" completely rather than by exhibiting one point.

**The priority claim, "the first structural reason on the record for why four dimensions is special", I cannot confirm and do not treat as mathematics.** It is also in tension with [L184](../findings/diagonal-half.md)'s case 2, which closes $m=3$ by injectivity of $\star:\Lambda^2\mathbb R^6\to\Lambda^4\mathbb R^6$, the same mechanism one dimension up.

**VERDICT: CORRECT, and sharper than stated.**

## 4. The conclusion from nondegeneracy

$\alpha\wedge\beta=0$ with $\beta$ nondegenerate reads $L_\beta(\alpha)=0$, and $L_\beta$ is injective on $\Lambda^2$ at $m\ge3$ by item 2, so $\alpha=0$. With $\alpha$ nondegenerate, symmetry of the wedge gives $\alpha\wedge\beta=L_\alpha(\beta)=0$ and so $\beta=0$. **The symmetry is essential and is exactly `wbil_sub_add`'s premise, typed at $\dim=6$ in [PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean).**

$\alpha=0$ is $\omega_2=\omega_1$, hence $J_2=J_1$. And $\beta=0$ is $\omega_2=-\omega_1$, hence $J_2=-J_1$.

**The contradiction, computed.** Under the conventions above the matrix of $\omega_J$ is $-J$, so
$$\langle\omega_1,\omega_2\rangle=\tfrac12\operatorname{tr}\big((-J_1)^{\mathsf T}(-J_2)\big)=\tfrac12\operatorname{tr}(J_1^{\mathsf T}J_2)=-\tfrac12\operatorname{tr}(J_1J_2).$$
At $J_2=J_1$: $\operatorname{tr}(J_1J_2)=\operatorname{tr}(J_1^2)=\operatorname{tr}(-I)=-2m$, so $\langle\omega_1,\omega_2\rangle=+m$. At $J_2=-J_1$: $\operatorname{tr}(J_1J_2)=+2m$, so $\langle\omega_1,\omega_2\rangle=-m$. **Both are nonzero at every $m\ge1$**, and the block's rendering $\operatorname{tr}(J_1J_2)=\mp2m$ for $J_2=\pm J_1$ carries exactly the right sign.

*In full, rather than only what the block takes: the constraint is $\lvert\langle\omega_1,\omega_2\rangle\rvert=m=\lVert\omega_1\rVert\lVert\omega_2\rVert$, that is equality in Cauchy-Schwarz. So the extreme cases are ruled out not by a numerical accident but because $\omega_2=\pm\omega_1$ saturates the inequality that orthogonality makes vanish.*

**VERDICT: CORRECT.**

## 5. $T=-J_1J_2$, and the signs

**Orthogonal.** $J_1,J_2\in\mathrm O(2m)$ and $-I\in\mathrm O(2m)$, so $T\in\mathrm O(2m)$. Directly, $T^{\mathsf T}=-J_2^{\mathsf T}J_1^{\mathsf T}=-J_2J_1$ and $T^{-1}=(-J_1J_2)^{-1}=-J_2^{-1}J_1^{-1}=-J_2J_1$, so $T^{\mathsf T}=T^{-1}$.

**The factorisations.** $J_1^{-1}=-J_1$, so $J_1^{-1}J_2=-J_1J_2=T$ and therefore
$$J_1+J_2=J_1(I+J_1^{-1}J_2)=J_1(I+T),\qquad J_1-J_2=J_1(I-T).$$
$J_1$ is invertible, so **$J_1-J_2$ is singular exactly when $+1\in\operatorname{spec}T$, and $J_1+J_2$ exactly when $-1\in\operatorname{spec}T$.** The block's assignment is correct, and it is corroborated three ways: $\ker\alpha=\ker(J_1-J_2)=\ker(I-T)=E_+$ and $\ker\beta=E_-$, which agrees with item 7's $J_2=J_1$ on $E_+$ making $\alpha$ vanish there, and with $J_2=J_1$ giving $T=-J_1^2=I$ so that $E_+$ is everything.

**Trace-orthogonality.** $\operatorname{tr}T=-\operatorname{tr}(J_1J_2)=2\langle\omega_1,\omega_2\rangle$ by the computation of item 4, so $\operatorname{tr}T=0$ is exactly trace-orthogonality. **This is convention-robust**: under the alternative reading $\omega_J(x,y)=\langle x,Jy\rangle$, whose matrix is $+J$, one gets $\langle\omega_1,\omega_2\rangle=\tfrac12\operatorname{tr}(J_1^{\mathsf T}J_2)=-\tfrac12\operatorname{tr}(J_1J_2)$ again. The brief's worry about a sign error swapping the two singularities does not materialise.

**VERDICT: ALL THREE CORRECT.**

## D2, recorded here because it is a constraint the block weakens

The block says $\operatorname{tr}T=0$ "permits both and forbids neither", which is true and is a strict weakening. **In full**, $T$ is orthogonal, so it is semisimple over $\mathbb R$ with $\mathbb R^{2m}=E_+\oplus E_-\oplus R$ orthogonally, $R$ splitting into two-dimensional rotation blocks at angles $\theta_1,\dots,\theta_r$ with $\theta_j\notin\{0,\pi\}$. Write $\dim E_+=2p$ and $\dim E_-=2q$, both even by item 6, so $p+q+r=m$ and
$$\operatorname{tr}T=2p-2q+2\sum_{j=1}^r\cos\theta_j=0,\qquad\text{that is}\qquad p-q+\sum_{j=1}^r\cos\theta_j=0 .$$
Two consequences the block does not take:

- **$R=0$ forces $\dim E_+=\dim E_-=m$**, hence both are nonzero. *This independently supplies the one hypothesis item 9 needs and does not check.*
- **$R=0$ is impossible at odd $m$**, and when $r\ge1$ the constraint reads $\lvert p-q\rvert<r$, since each $\cos\theta_j$ lies strictly inside $(-1,1)$.

*All of this is moot given D1, and I record it because the brief asks for the full content of every constraint the block derives, and because it is the same failure mode the round was told to watch for.*

## 6. $J_1TJ_1^{-1}=T^{-1}$ and the evenness

**The derivation.** $J_1^{-1}=-J_1$, so
$$J_1TJ_1^{-1}=J_1(-J_1J_2)(-J_1)=J_1^2J_2J_1=(-I)J_2J_1=-J_2J_1=T^{-1},$$
the last equality being the computation of $T^{-1}$ in item 5. **This is exactly the block's line.**

**The eigenspace consequence.** Rewrite it as $J_1T=T^{-1}J_1$. If $Tv=\lambda v$ over $\mathbb C$ then $T^{-1}(J_1v)=J_1Tv=\lambda J_1v$, so $J_1v$ is a $\lambda$-eigenvector of $T^{-1}$, that is a $\lambda^{-1}$-eigenvector of $T$. At $\lambda=\pm1$ we have $\lambda^{-1}=\lambda$, so **$E_+$ and $E_-$ are $J_1$-invariant**, and this needs no complexification: $x\in\ker(T\mp I)$ gives $T(J_1x)=J_1T^{-1}x=J_1(\pm x)=\pm J_1x$ directly.

**Is $J_1$-invariance really what gives evenness, and does the argument need $T$ orthogonal?** Invariance is what gives it, and $T$ orthogonal is **not** needed for this step. On a $J_1$-invariant subspace $E$, the restriction $J_1|_E$ satisfies $(J_1|_E)^2=-\mathrm{id}_E$, which makes $E$ a complex vector space and hence of even real dimension. All the argument uses is $J_1^2=-I$ and the invariance. *The derivation of $J_1TJ_1^{-1}=T^{-1}$ itself uses $J_1^2=J_2^2=-I$ and nothing about orthogonality either.*

**Where $T$ orthogonal is load-bearing.** Three places, none of them evenness. It gives $E_+\perp E_-$, since $x\in E_+$ and $y\in E_-$ have $\langle x,y\rangle=\langle Tx,Ty\rangle=-\langle x,y\rangle$. It gives $R=(E_+\oplus E_-)^\perp$ as a $T$-invariant complement, so that "the sum of the eigenspaces at $\lambda\ne\pm1$" is a genuine complement rather than a subspace of one. And it makes $T$ semisimple, without which "the sum of the eigenspaces" would not exhaust anything. **Defining $R$ as $(E_+\oplus E_-)^\perp$ rather than as a sum of eigenspaces would be the cleaner statement**, the two agreeing precisely because $T$ is orthogonal.

**"Both singularities together need $\dim\ge4$".** Correct: $\dim E_+\ge2$ and $\dim E_-\ge2$ and they are orthogonal. In full, since $R$ is also $J_1$-invariant, hence even-dimensional, the branch hypothesis together with $R\ne0$ needs $2m\ge6$, that is $m\ge3$. **That has no bite inside the block's own range.**

**VERDICT: DERIVATION CORRECT, ATTRIBUTION OF THE EVENNESS CORRECT, AND $T$ ORTHOGONAL IS NOT WHAT DELIVERS IT.**

## 7. The restriction claim

For $x\in E_+$, $-J_1J_2x=x$. Apply $J_1$ and use $J_1^2=-I$: $-J_1^2J_2x=J_1x$, that is $J_2x=J_1x$. For $x\in E_-$, $-J_1J_2x=-x$, so $J_1J_2x=x$, and applying $J_1$ gives $J_1^2J_2x=J_1x$, that is $-J_2x=J_1x$, so $J_2x=-J_1x$. **Both correct.**

**Are $E_\pm$ also $J_2$-invariant?** Yes, and automatically: on $E_+$ we have just shown $J_2=J_1$ pointwise, and $E_+$ is $J_1$-invariant, so $J_2(E_+)=J_1(E_+)=E_+$, and likewise on $E_-$. $R$ is $J_2$-invariant too, since $J_2=J_1T$ and both factors preserve each of $E_+,E_-,R$.

**Is it needed?** It is needed for the block's stated reason in item 8 to work as stated, because that reason is that each of $\omega_1$ and $\omega_2$ separately is block-diagonal with respect to $E_+\oplus E_-\oplus R$, which requires the pieces to be $J_2$-invariant as well as $J_1$-invariant. **The shorter route bypasses it**: $\ker\alpha=\ker(J_1-J_2)=E_+$ exactly, and $\alpha$ is skew, so $\alpha$ vanishes on every pair with an $E_+$ entry and lives in $\Lambda^2(E_+^\perp)=\Lambda^2(E_-\oplus R)$. Symmetrically $\beta\in\Lambda^2(E_+\oplus R)$. This uses only $T$ orthogonal, and it is the form section 9 needs.

**VERDICT: BOTH DERIVATIONS CORRECT, THE INVARIANCE IS AUTOMATIC AND IS USED.**

## 8. The cross terms, explicitly

Take an orthonormal basis adapted to $\mathbb R^{2m}=E_+\oplus E_-\oplus R$, writing $a,b$ for indices in $E_-$, $p,q$ for indices in $E_+$, and $u,v$ for indices in $R$. Recall $\alpha(x,y)=\langle(J_1-J_2)x,y\rangle$ and $\beta(x,y)=\langle(J_1+J_2)x,y\rangle$.

| block | $\alpha$ | $\beta$ | reason |
|---|---|---|---|
| $\Lambda^2E_+$ | $0$ | $2\omega_1|_{E_+}$ | $J_1-J_2=0$ on $E_+$, $J_1+J_2=2J_1$ there |
| $\Lambda^2E_-$ | $2\omega_1|_{E_-}$ | $0$ | $J_1-J_2=2J_1$ on $E_-$, $J_1+J_2=0$ there |
| $E_+\wedge E_-$ | $0$ | $0$ | $(J_1-J_2)x=0$ on $E_+$, and $(J_1-J_2)x=2J_1x\in E_-\perp E_+$ on $E_-$ |
| $E_+\wedge R$ | $0$ | $0$ | $(J_1-J_2)x=0$ on $E_+$, and $(J_1+J_2)x=2J_1x\in E_+\perp R$ there |
| $E_-\wedge R$ | $0$ | $0$ | $(J_1+J_2)x=0$ on $E_-$, and $(J_1-J_2)x=2J_1x\in E_-\perp R$ there |
| $\Lambda^2R$ | $\omega_1|_R-\omega_2|_R$, in general nonzero | $\omega_1|_R+\omega_2|_R$, in general nonzero | nothing forces either to vanish |

**Every vanishing above is an instance of exactly the reason the block gives**, namely that each piece is invariant under both $J_i$ and the three pieces are mutually orthogonal, which makes $\omega_1$ and $\omega_2$ each block-diagonal and therefore makes every cross block of $\alpha$ and of $\beta$ vanish. **So the stated reason is correct and it does cover the $R$ cross terms, which the block does not mention.**

**One incompleteness.** As written, "$\alpha=\omega_1-\omega_2$ is $2\omega_1$ on $E_-$ and zero on $E_+$" describes $\alpha$ on two of the three pieces and is not a full description of $\alpha$: the $\Lambda^2R$ block is generally nonzero. The very next paragraph introduces $R$ and treats $R=0$ as a case, so the block clearly knows this. **I record it as imprecision, not as a defect**, and note that the cleanest true statement is the one of item 7: $\ker\alpha=E_+$ and $\ker\beta=E_-$ exactly, so $\alpha\in\Lambda^2(E_-\oplus R)$ and $\beta\in\Lambda^2(E_+\oplus R)$.

**VERDICT: CORRECT, WITH THE $\Lambda^2R$ BLOCK OWED IN THE STATEMENT.**

## 9. The rotation-free contradiction, and D1

### 9.1 The block's argument, as stated, is correct

Suppose $R=0$, so $\mathbb R^{2m}=E_-\oplus E_+$ orthogonally. By section 8, $\alpha\in\Lambda^2E_-$ and $\beta\in\Lambda^2E_+$. For complementary subspaces $A\oplus B$ one has the standard decomposition
$$\Lambda^4(A\oplus B)=\bigoplus_{i+j=4}\Lambda^iA\otimes\Lambda^jB,$$
and under it the wedge of $\alpha\in\Lambda^2A$ with $\beta\in\Lambda^2B$ is the image of $\alpha\otimes\beta$ under the injection $\Lambda^2A\otimes\Lambda^2B\hookrightarrow\Lambda^4(A\oplus B)$. **So the $\Lambda^2E_-\otimes\Lambda^2E_+$ component of $\alpha\wedge\beta$ is $\alpha|_{E_-}\otimes\beta|_{E_+}$, and it vanishes only if one factor does.** In coordinates, and in the `wbil` normalisation, the coefficient at the index set $\{a,b,p,q\}$ is
$$(\alpha\wedge\beta)_{abpq}=\tfrac12\big(\alpha_{ab}\beta_{pq}+\underbrace{\beta_{ab}}_{0}\alpha_{pq}-\underbrace{\alpha_{ap}}_{0}\beta_{bq}-\underbrace{\beta_{ap}}_{0}\alpha_{bq}+\underbrace{\alpha_{aq}}_{0}\beta_{bp}+\underbrace{\beta_{aq}}_{0}\alpha_{bp}\big)=\tfrac12\,\alpha_{ab}\beta_{pq}.$$

**Are both factors nonzero?** $E_-$ is $J_1$-invariant, so for $0\ne x\in E_-$ we have $J_1x\in E_-$ and
$$\alpha(x,J_1x)=\langle2J_1x,J_1x\rangle=2\lVert x\rVert^2>0,$$
so $\alpha|_{E_-}\ne0$ whenever $E_-\ne0$, and it is in fact nondegenerate, being twice the Kähler form of the complex structure $J_1|_{E_-}$. Symmetrically $\beta|_{E_+}\ne0$ whenever $E_+\ne0$.

**Both are nonzero under the hypothesis.** The branch the block is inside is "both $J_1+J_2$ and $J_1-J_2$ singular", which by item 5 is exactly $E_+\ne0$ and $E_-\ne0$. So the contradiction is legitimate. **If one of them were zero** we would not be in the branch at all: $E_+=0$ makes $\alpha$ nondegenerate and $E_-=0$ makes $\beta$ nondegenerate, and either is closed at $m\ge3$ by the block's earlier paragraph. *Independently, D2 shows $R=0$ forces $\dim E_+=\dim E_-=m>0$, so in the block's own case the two are nonzero for a second reason.*

**One wording point.** The block calls $\alpha$ and $\beta$ "nondegenerate forms on complementary subspaces". As forms on $\mathbb R^{2m}$ they are degenerate, with kernels $E_+$ and $E_-$. The intended and correct reading is that their restrictions to $E_-$ and to $E_+$ are nondegenerate. The argument needs only that those restrictions are nonzero.

### 9.2 D1: $R=0$ is not used anywhere in that argument

**Locate it exactly.** The sentence is *"If $R=0$ then $\alpha$ and $\beta$ are nondegenerate forms on complementary subspaces, and their wedge has $\alpha\otimes\beta\ne0$ as its $\Lambda^2E_-\otimes\Lambda^2E_+$ component, against $\alpha\wedge\beta=0$"*, and the conclusion drawn from it is *"What survives the whole Lefschetz route is therefore: both $\pm1$ eigenvalues present, each with even multiplicity, AND a nontrivial rotation part, at all three pairs at once."* **The hypothesis it invokes and does not need is $R=0$.**

**Why it is not needed.** Restore $R$ and decompose $\Lambda^4$ by how many indices fall in each of $E_-,E_+,R$. By section 8, $\alpha$ carries no $E_+$ index and $\beta$ carries no $E_-$ index. At the index set $\{a,b,p,q\}$ with $a,b\in E_-$ and $p,q\in E_+$ there are, up to sign, three ways to split four indices two-and-two between the factors, and two of them ask $\alpha$ for an $E_+$ index or $\beta$ for an $E_-$ index. **Only the split $\alpha\mapsto\{a,b\}$, $\beta\mapsto\{p,q\}$ survives, and the $R$ blocks of $\alpha$ and $\beta$ contribute no term at all, carrying no index in $E_+\cup E_-$.** The displayed six-term computation of 9.1 is therefore valid verbatim with $R\ne0$, every crossed-out term vanishing for the same reason as before. Hence, with no hypothesis on $R$,
$$\alpha\wedge\beta=0\ \Longrightarrow\ \alpha|_{E_-}\otimes\beta|_{E_+}=0\ \Longrightarrow\ E_-=0\ \text{ or }\ E_+=0 .$$

**Exhibit the failure concretely.** The block's declared surviving shape is nonempty as a set of pairs $(J_1,J_2)$, and its members do not satisfy $\alpha\wedge\beta=0$. Take $m=4$ on $\mathbb R^8$, $J_1=\operatorname{diag}(j,j,j,j)$ with $j$ the right-angle rotation, $je_1=e_2$ and $je_2=-e_1$, and
$$T=I_2\ \oplus\ (-I_2)\ \oplus\ T_R,\qquad T_R:\ e_5\mapsto e_7,\ e_6\mapsto-e_8,\ e_7\mapsto-e_5,\ e_8\mapsto e_6,$$
$T_R$ being the quaternionic structure on $\operatorname{span}(e_5,\dots,e_8)\cong\mathbb C^2$, which is orthogonal, anticommutes with $J_1$, and has $T_R^2=-I$. Then $J_1TJ_1^{-1}=T^{-1}$ holds blockwise, so $J_2:=J_1T$ satisfies $J_2^2=J_1TJ_1T=T^{-1}J_1^2T=-I$ and is an orthogonal complex structure. **This pair meets every condition of the block's surviving shape**: $\dim E_+=\dim E_-=2$, both even and both nonzero, $\dim R=4$ nontrivial, and $\operatorname{tr}T=2-2+0=0$, so the pair is trace-orthogonal. Yet
$$(\alpha\wedge\beta)_{3412}=\tfrac12\,\alpha_{34}\beta_{12}=\tfrac12\cdot2\cdot2=2\ne0,$$
so $\omega_1\wedge\omega_1\ne\omega_2\wedge\omega_2$. *Screened, and the screen returns $(\alpha\wedge\beta)_{3412}=2$ against the predicted $2$, with $\operatorname{tr}(J_1J_2)=0$ and $\operatorname{spec}T=\{1,1,-1,-1,\pm i,\pm i\}$.*

**Argue the opposite.** The most charitable reading the words support is that "what survives the whole Lefschetz route" is a claim about what the route **as executed in the block** leaves untouched, not a claim that the leftover set contains anything. Under that reading no sentence of the block is false, and the paragraph is an honest statement of where its author stopped. I accept that reading, which is why D1 is recorded as a completeness defect rather than an error. **What makes it worth recording anyway** is that the same paragraph's conclusion is carried upward: [L195](../findings/diagonal-half.md)'s closing box says the question is "OPEN at $m\ge4$", and [REVIEW_r834.md](REVIEW_r834.md) names the $\dim V=8$ scalar stratum "the honest frontier". Both statements are now false, and both will otherwise reach the report.

### 9.3 What the block therefore proves, stated as a theorem

**Theorem (this reviewer's derivation, owing its own round).** *Let $J_1,J_2$ be orthogonal complex structures on $\mathbb R^{2m}$ with $m\ge3$ and $\omega_1\wedge\omega_1=\omega_2\wedge\omega_2$. Then $J_2=\pm J_1$.* **No orthogonality hypothesis, and no third structure.**

**Proof.** By the block's difference of squares, $\alpha\wedge\beta=0$ with $\alpha=\omega_1-\omega_2$ and $\beta=\omega_1+\omega_2$. Put $T=-J_1J_2$, orthogonal, with $E_\pm=\ker(T\mp I)$ and $R=(E_+\oplus E_-)^\perp$, so that $\ker\alpha=E_+$ and $\ker\beta=E_-$ by items 5 and 7. By 9.2, $E_+=0$ or $E_-=0$.

If $E_+=0$ then $\alpha$ is nondegenerate, and $L_\alpha:\Lambda^2\to\Lambda^4$ is injective at $m\ge3$ by item 2, so $L_\alpha(\beta)=\alpha\wedge\beta=0$ gives $\beta=0$, that is $J_2=-J_1$. Otherwise $E_-=0$, $\beta$ is nondegenerate, the same step gives $\alpha=0$, that is $J_2=J_1$. $\square$

**Corollary.** *Two trace-orthogonal orthogonal complex structures on $\mathbb R^{2m}$ with $m\ge3$ never share a common $J\wedge J$*, by item 4. **Hence the surviving rank-three question of [L195](../findings/diagonal-half.md) is EMPTY at every $m\ge3$**, since any two members of a coincident triple are such a pair, **and $m=2$ is the only inhabited value.** Translating back, a rank-three Weyl tensor with coincident images exists only when its common support has dimension four, which is padded $W_{\mathbb{CP}^2}$.

**Three independent checks of 9.2, since it carries the whole finding.** *(i)* The index computation displayed in 9.1, with the six terms and the reason each crossed-out one vanishes. *(ii)* The type computation: writing $\omega_1=\omega_++\omega_-+\omega_R$ and $\omega_2=\omega_+-\omega_-+\omega_{2,R}$, the four terms of $\alpha\wedge\beta$ have $(E_-,E_+,R)$ index types $(2,2,0)$, $(2,0,2)$, $(0,2,2)$ and $(0,0,4)$ respectively, so exactly one term reaches type $(2,2,0)$ and it is $4\,\omega_-\wedge\omega_+$. *(iii)* The closed-form object of 9.2, whose $\{1,2,3,4\}$ component is $2$ by hand. **All three agree, and the screen agrees with all three.** The consistency check that mattered most is that 9.2 is also true at $m=2$, where it says $E_+=0$ or $E_-=0$, and the quaternionic witness indeed has $T=-J_3$ with $E_+=E_-=0$ and $R=\mathbb R^4$: the theorem fails at $m=2$ only at the Lefschetz step, exactly as it must.

**VERDICT ON ITEM 9: THE ARGUMENT IS CORRECT AND IS STRICTLY STRONGER THAN THE BLOCK CLAIMS. D1 IS REAL AS A COMPLETENESS DEFECT.**

## 10. What survives

**The inheritance to three pairs is correctly done.** If $J_1,J_2,J_3$ are pairwise trace-orthogonal with a common $J\wedge J$, then each of the three pairs $(1,2)$, $(1,3)$, $(2,3)$ satisfies both hypotheses of the pair analysis, so the pair conclusion holds at each of them simultaneously. **That is a conjunction, and conjunctions of necessary conditions are what the block asserts**, so the step is sound.

**The conclusion is nevertheless void**, because 9.2 makes the per-pair conclusion unsatisfiable at $m\ge3$: no single pair can have both $E_+\ne0$ and $E_-\ne0$, so the conjunction over three pairs is empty a fortiori. **One pair already closes the question, and the third structure is never needed.**

**Is anything cheap available at $m=4$ from three such $T$'s on $\mathbb R^8$?** Nothing is needed, but the natural structure is worth one line for the record. Writing $T_{ij}=-J_iJ_j$, the three satisfy a cocycle relation,
$$T_{12}T_{23}=(-J_1J_2)(-J_2J_3)=J_1J_2^2J_3=-J_1J_3=T_{13},$$
each is conjugate to its inverse by both of its own structures, and each has trace zero. Before D1, the only cheap consequence of the three coexisting was the dimension count of item 6 applied three times, $\dim E_+^{ij}\ge2$, $\dim E_-^{ij}\ge2$ and $\dim R^{ij}\ge2$, giving $2m\ge6$ at each pair and therefore **nothing at $m=4$**. So the answer to the brief's question is that the three-pair route had no cheap purchase at $m=4$ and did not need one.

**VERDICT: INHERITANCE CORRECT, CONCLUSION VOID.**

## 11. Falsifiers, and what I did to look for them

**What would falsify the block, in the two directions the brief names.**

- **Inhabited direction.** A triple of pairwise trace-orthogonal orthogonal complex structures on $\mathbb R^8$ with a common self-wedge would refute the block's framing of $m\ge4$ as open-but-constrained and would refute my theorem. **I looked for one by construction rather than by search**, which is what the analysis-only rule permits: I built the general member of the block's own surviving shape, $T=I_{2p}\oplus(-I_{2q})\oplus T_R$ with $T_R$ orthogonal, anticommuting with $J_1$ and squaring to $-I$, checked that $J_2=J_1T$ is an orthogonal complex structure for every such $T$, and found $\alpha\wedge\beta\ne0$ for all of them in closed form. That failure is not a sampling result, it is the theorem of 9.3.
- **Closing direction.** An argument closing the rotation case refutes the block's claim that a gap remains. **This is what I found**, and it is D1. The falsifier of the block is the block's own paragraph read without its unnecessary hypothesis.

**What would falsify my finding.** Exactly one thing: a pair $J_1,J_2$ on $\mathbb R^{2m}$, $m\ge3$, with $E_+\ne0$, $E_-\ne0$ and $\alpha\wedge\beta=0$. By 9.2 that would need $\omega_1|_{E_-}=0$ or $\omega_1|_{E_+}=0$, which contradicts $\omega_1(x,J_1x)=\lVert x\rVert^2$ on a nonzero $J_1$-invariant subspace. **So the only way in is a failure of $J_1$-invariance of $E_\pm$, or of $E_+\perp E_-$, and both are items 5 and 6, which I re-derived from scratch above.**

**What I did.** I derived items 1 to 10 by hand from the givens before consulting the file; I re-derived $J_1TJ_1^{-1}=T^{-1}$, $\ker\alpha=E_+$ and the six-term wedge coefficient independently of the block's wording; I checked 9.2 by three routes, index, type and closed-form instance; I read [REVIEW_r834.md](REVIEW_r834.md) and confirmed that its anticommuting exclusion is exactly the case $E_+=E_-=0$ of my theorem, so the theorem generalises a result already on the record rather than contradicting one; and I ran the two permitted screens. **No sweep, no census and no falsifier hunt was run.**

## Verdict

**The block is SOUND. Every derivation in it is correct, every sign is right, and the two ranges it omits are ranges it happens to satisfy.** Items 1 through 8 pass without qualification beyond the omitted range $0\le k\le m$ in item 1, the missing $\Lambda^2R$ block in item 8, and the loose word "nondegenerate" in item 9.

**And the block is INCOMPLETE in the precise way the round was told to watch for.** Its item-9 computation is stated under $R=0$ and uses nothing of it. Without that hypothesis the same three lines give $E_+=0$ or $E_-=0$, hence one of $\alpha,\beta$ nondegenerate, hence by the block's own Lefschetz injectivity $J_2=\pm J_1$, hence a contradiction with trace-orthogonality. **The surviving rank-three question is empty at every $m\ge3$**, the coincident branch is inhabited only at $\dim V=4$, and the paragraph declaring a surviving shape describes an empty set. **The final paragraph should be replaced by the theorem of 9.3, and [L195](../findings/diagonal-half.md)'s "OPEN at $m\ge4$" retired, in a round of its own.**
