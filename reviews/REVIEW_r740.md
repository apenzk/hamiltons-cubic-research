# Gate 2, L164: the restriction lies in $\mathcal W_{\dim U}$, and padding preserves $\lVert\cdot\rVert$, $P$ and $\theta$ (reviewer r740)

*Brief read cold: [BRIEF-g2-l164.md](BRIEF-g2-l164.md) was the only file open until a verdict had been formed on every claim, after which [conventions.md](../findings/conventions.md), [stratum-two-negative.md](../findings/stratum-two-negative.md) and [VERIFY_v211.md](../verification/VERIFY_v211.md) were opened solely to check whether the three findings below are already recorded. No search, sweep, census, optimisation or falsifier hunt was run. Two screens were run, each seconds of exact integer and rational arithmetic on an object built for the purpose, and each is labelled a screen where it appears; every value in this report is exact. Log: [agent_logs/g2-l164-r740.log](../agent_logs/g2-l164-r740.log).*

## The claims

| # | claim | verdict | reason, in a clause |
|---|---|---|---|
| C1 | **(i)** the hypothesis makes $W$ preserve $\Lambda^2U$ and annihilate its complement | **CONFIRMED** | $\{u\wedge w:u\in U^\perp\}$ spans the last two summands exactly, and self-adjointness turns "kills the complement" into "preserves $\Lambda^2U$" |
| C2 | **(ii)** $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is an isometry for the half-trace pairing | **CONFIRMED** | $\tfrac12\operatorname{tr}(\varphi_{ij}^{\mathsf T}\varphi_{ij})=1$ in either dimension, the value being independent of $n$ |
| C3 | **(ii)** hence $\lVert W'\rVert=\lVert W\rVert$ for the *operator* norm | **CONFIRMED, one line elided** | the bivector isometry is not the operator statement; the missing line is that $W$ is block-diagonal in an adapted orthonormal basis, so its Frobenius sum collapses to the $U$-block |
| C4 | **(iii)** $W^\#$ is supported on $\Lambda^2U$ | **CONFIRMED** | $W=\sum\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ with every $v_\alpha\in\mathfrak{so}(U)$, and $[\mathfrak{so}(U),\mathfrak{so}(U)]\subseteq\mathfrak{so}(U)$ |
| C5 | **(iii)** the entries there are $\mathfrak{so}(U)$'s own structure constants | **CONFIRMED** | bracket and half-trace pairing both restrict on the nose, so $c^U_{abc}=c_{abc}$ for indices inside |
| C6 | **(iii)** the displayed formula $(W^\#)_{ab}=\sum c_{acd}c_{bef}W_{ce}W_{df}$ | **DISCREPANCY, inert here** | it is **twice** the record's own $\#$: it returns $\operatorname{id}^\#=2(n-2)\operatorname{id}$ where $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ returns $(n-2)\operatorname{id}$; the argument reads off the index *support* only, so the factor never enters |
| C7 | **(iv)** first Bianchi is inherited | **CONFIRMED** | at $i,j,k,l\in U$ the identity involves only components with all four indices in $U$, so it is a genuine sub-family with nothing thrown away |
| C8 | **(iv)** pair symmetry "likewise" | **CONFIRMED** | $R_{ijkl}=R_{klij}$ at indices in $U$ is a sub-family in the same sense; equivalently a self-adjoint operator restricted to an invariant subspace is self-adjoint |
| C9 | **(iv)** Ricci-flatness of the restriction | **CONFIRMED** | $\operatorname{Ric}(W')_{ik}=\sum_{j\in U}W_{ijkj}=\sum_{j=1}^nW_{ijkj}=0$, the $j\in U^\perp$ terms vanishing with $W$; via the adjoint definition, restricting the test space $h$ to $U$ |
| C10 | the chain $P(W')=\langle W',Q(W')\rangle=\langle W,Q(W)\rangle=P(W)$ | **CONFIRMED** | padding is an isometry of $\operatorname{End}$ onto the block, and only the $U$-block of $Q(W)$ can pair with $W$ at all |
| C11 | $\theta(W')=\theta(W)$ | **HYPOTHESIS-DEBT, one clause** | stated with no nonvanishing hypothesis; at $W=0$, and at every $\dim U\le3$ which forces $W=0$, both sides are $0/0$ |
| C12 | the disclaimer: the operator identity $Q(\operatorname{pad}W')=\operatorname{pad}Q(W')$ is "neither proved nor needed" | **HALF REFUTED** | *not needed* is right (the equalities want only the $U$-block; *not proved* is wrong), step (iii) proves it verbatim for every symmetric operator supported in $\Lambda^2U$, which is everything $\operatorname{pad}$ can produce, and [VERIFY_v211.md](../verification/VERIFY_v211.md) already says so |
| C13 | the statement's hypothesis inventory | **OVER-HYPOTHESISED, benign** | first Bianchi and Ricci-flatness are used only for the membership clause; the three displayed equalities hold for *any* symmetric operator on $\Lambda^2\mathbb R^n$ supported in $\Lambda^2U$ |
| C14 | the statement quantified over every $W$ and every admissible $U$ | **CONFIRMED consistent** | the hypothesis holds for a whole flag of $U$'s above a canonical minimal $U_{\min}(W)$, and all of them return the same three numbers |

**Act on this:** the mathematics of L164 is right and the proof on file establishes it, including the stronger operator identity the block disclaims; add $W\ne0$ to the $\theta$ clause, put the record's $\tfrac12$ back into the displayed $\#$ formula in step (iii), and delete or restate the "what is NOT proved" callout, which contradicts both step (iii) and [VERIFY_v211.md](../verification/VERIFY_v211.md).

## 0. Conventions, fixed once

- $\Lambda^2\mathbb R^n$ carries $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\varphi_{ab}=E_{ab}-E_{ba}$ has $\lVert\varphi_{ab}\rVert^2=1$ and $\{\varphi_{ab}\}_{a<b}$ is orthonormal. Every basis in this report is orthonormal for that pairing.
- On $\operatorname{End}(\Lambda^2)$ the pairing is plain Frobenius, $\langle A,B\rangle=\sum_{a,b}A_{ab}B_{ab}$ **in an orthonormal basis of $\Lambda^2$**. The two conventions are consistent precisely because the $\tfrac12$ is what makes $\{\varphi_{ab}\}$ orthonormal; and since a global rescaling of the $\Lambda^2$ metric leaves an operator's matrix in the rescaled orthonormal basis unchanged, nothing in this report turns on the choice.
- $c_{abc}=\langle[v_a,v_b],v_c\rangle$, totally antisymmetric; in the $\varphi$ basis of $\mathfrak{so}(n)$ these are $0,\pm1$, nonzero exactly on the six orderings of a triangle $\{\varphi_{ij},\varphi_{jl},\varphi_{il}\}$. Sample: $[\varphi_{12},\varphi_{23}]=\varphi_{13}$ and $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$.
- $\#$ is the **halved** Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$, extended bilinearly, $W^\#=W\#W$. This is [conventions.md](../findings/conventions.md)'s convention and the one this report computes in. See §6 for its clash with the formula the proof displays.
- $\operatorname{pad}$ is extension by zero along $\Lambda^2\mathbb R^n=\Lambda^2U\oplus(U\wedge U^\perp)\oplus\Lambda^2U^\perp$; "inside" means an index in the first summand.
- $R_{ijkl}$ denotes the matrix entry $W_{(ij)(kl)}$ extended antisymmetrically in each pair; $\operatorname{Ric}(W)_{ik}=\sum_jR_{ijkj}$.

## 1. Hypothesis inventory

**Stated by L164.**

| # | hypothesis | where the proof uses it | verdict |
|---|---|---|---|
| H1 | $W$ is a symmetric operator on $\Lambda^2\mathbb R^n$ | (i), silently, "kills the complement" gives "preserves $\Lambda^2U$" only through self-adjointness; and (iii) needs a spectral decomposition, which needs symmetry | **used, unflagged** |
| H2 | $W$ satisfies first Bianchi | (iv) only | **used for the membership clause alone** |
| H3 | $W$ is Ricci-flat | (iv) only | **used for the membership clause alone** |
| H4 | $U\subseteq\mathbb R^n$ is a linear subspace | throughout, $\mathfrak{so}(U)$ is a subalgebra because $U$ is a subspace | **used** |
| H5 | $W(u\wedge w)=0$ for every $u\in U^\perp$, $w\perp u$ | (i), (iii), (iv), and the final chain | **used, and it is the whole engine** |

**Used but not stated.**

| # | unstated hypothesis | where | is it free? |
|---|---|---|---|
| U1 | the orthonormal basis is **adapted to $U$**, i.e. $\{v_a\}$ splits into a basis of $\mathfrak{so}(U)$ and a basis of its orthogonal complement | (ii) writes "$\varphi_{ij}$ with $i<j$ in $U$", which presumes $U$ is coordinate; (iii) needs $v_a\perp\mathfrak{so}(U)$ for $a$ outside | **yes**, $\mathcal W_n$, the half-trace pairing, $\#$, $Q$, $P$ and $\theta$ are all $O(n)$-equivariant or invariant, so rotate $U$ onto $\operatorname{span}(e_1,\dots,e_k)$. Free, but it is an unwritten step and §4 shows the argument is *false without it* |
| U2 | $W\ne0$ | the $\theta$ clause | **no.** This is the finding of §7 |
| U3 | the identification $U\cong\mathbb R^{\dim U}$ that gives sense to "$W'\in\mathcal W_{\dim U}$" | the membership clause | **yes**, by $O(\dim U)$-invariance of $\mathcal W_{\dim U}$; the conclusion does not depend on the chosen orthonormal basis of $U$ |

**Imported facts, and their own hypotheses.**

| fact | hypothesis it carries | met here? |
|---|---|---|
| $\Lambda^2\mathbb R^n=\Lambda^2U\oplus(U\wedge U^\perp)\oplus\Lambda^2U^\perp$, orthogonally | $U$ a subspace of a Euclidean space | yes; the proof writes $U\otimes U^\perp$ for $U\wedge U^\perp$, which is the standard abuse and is even an isometry here ($u\otimes w\mapsto u\wedge w$ carries unit to unit under the half-trace pairing) |
| $\mathfrak{so}(U)\subseteq\mathfrak{so}(n)$ is a Lie subalgebra, isometrically embedded | $U$ a subspace; the embedding sends a $k\times k$ skew matrix to one vanishing on $U^\perp$ | yes, and $\tfrac12\operatorname{tr}(X^{\mathsf T}X)$ is unchanged by the padding of the matrix, so the embedding is isometric as well as a homomorphism, **both halves are needed and only the first is named** |
| the index formula for $\#$ | an orthonormal basis of $\Lambda^2$ | basis fine; **normalisation wrong by a factor $2$**, §6 |
| $\operatorname{Ric}$ is the adjoint of $\cdot\wedge\operatorname{id}$ | a fixed dimension, since the adjoint is taken against $\operatorname{id}_{\mathbb R^n}$ | yes, and §9 shows the dimension change is harmless because flatness is tested by *restricting* the space of test tensors $h$ |

## 2. Step (i), the support, and the one thing it needs that it does not say

The hypothesis is "$W$ vanishes on $u\wedge u^\perp$ for every $u\perp U$". As $u$ ranges over $U^\perp$ and $w$ over $u^\perp$, the bivectors $u\wedge w$ span $U^\perp\wedge\mathbb R^n=(U\wedge U^\perp)\oplus\Lambda^2U^\perp$: for $u\in U^\perp$ and any $w$, decompose $w=\alpha u+w'$ with $w'\perp u$, and $u\wedge w=u\wedge w'$. So the hypothesis is exactly $\ker W\supseteq(\Lambda^2U)^\perp$, no more and no less.

**Self-adjointness then does the rest, and the proof does not say so.** From $\ker W\supseteq(\Lambda^2U)^\perp$ and $W=W^{\mathsf T}$ we get $\operatorname{im}W=(\ker W)^\perp\subseteq\Lambda^2U$, so $W(\Lambda^2U)\subseteq\Lambda^2U$. Without symmetry the implication fails outright: on $\Lambda^2\mathbb R^4$ the map sending $\varphi_{12}\mapsto\varphi_{34}$ and everything else to $0$ annihilates $(\Lambda^2U)^\perp$ for $U=\operatorname{span}(e_1,e_2)$ and does not preserve $\Lambda^2U$. Symmetry is H1, a stated hypothesis of $\mathcal W_n$, so this is a presentational gap only, but it is the hypothesis (i) actually consumes, and (i) names the direct-sum decomposition instead.

**Charitable reading, which I accept.** "The hypothesis kills $W$ on the last two summands, so $W$ maps $\Lambda^2U$ into itself" is a compressed way of saying "a self-adjoint operator killing a subspace preserves its orthogonal complement". Verdict on C1: **CONFIRMED**.

## 3. Step (ii), the isometry is not the norm equality, and the norm equality is still true

**The isometry.** $\varphi_{ij}=E_{ij}-E_{ji}$ has $\tfrac12\operatorname{tr}(\varphi_{ij}^{\mathsf T}\varphi_{ij})=\tfrac12(1+1)=1$ whether the matrix is $k\times k$ or $n\times n$, and distinct $\varphi$'s are orthogonal in both. So $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is an isometry. **This is exactly where the $\tfrac12$ earns its keep in a way the record should keep visible: the claim is not that the $\tfrac12$ makes the inclusion isometric (any fixed multiple of the trace pairing would) but that the $\tfrac12$ is what makes the coordinate bivectors *orthonormal*, which is what lets "plain Frobenius on operators" be a basis-free statement in both dimensions at once.**

**The gap the brief asks about is real but one line wide.** $\lVert W\rVert$ is Frobenius on $\operatorname{End}(\Lambda^2\mathbb R^n)$, not the bivector norm, and an isometry of $\Lambda^2$'s does not by itself say anything about operators, it says something about the *induced* map on $\operatorname{End}$, which is what is wanted, and (ii) does not perform that induction. The line is:

extend $\{\varphi_{ij}\}_{i<j\le k}$ to the full coordinate orthonormal basis of $\Lambda^2\mathbb R^n$; by (i) the matrix of $W$ in it is block-diagonal with the inside block equal to the matrix of $W'$ in $\Lambda^2U$'s own orthonormal basis and every other entry $0$; hence $\lVert W\rVert^2=\sum_{a,b}W_{ab}^2=\sum_{a,b\ \mathrm{inside}}W_{ab}^2=\lVert W'\rVert^2$.

**Does the $\operatorname{End}$ pairing inherit the $\tfrac12$?** It does not, by the record's own stipulation, and it does not matter: had one instead put $\tfrac12$ on $\operatorname{End}$ as well, both sides of $\lVert W'\rVert=\lVert W\rVert$ would acquire the same factor. What *would* matter is computing the operator Frobenius norm in a basis that is not orthonormal, e.g. taking $\{\varphi_{ab}\}$ as orthogonal-but-not-normalised under a full-trace pairing on $\Lambda^2$, and there the "$\tfrac12$ at the $\Lambda^2$ level" convention is precisely the guard. Verdict on C2: **CONFIRMED**; on C3: **CONFIRMED with one line elided**, a presentational finding, not a defect.

## 4. Step (iii), first half, the sharp is supported on $\Lambda^2U$

Take the basis adapted (U1). Write $I=\{a:v_a\in\mathfrak{so}(U)\}$.

**The index-forcing, in full.** $(W^\#)_{ab}$ is a sum over all $c,d,e,f$. A term survives only if $W_{ce}\ne0$ and $W_{df}\ne0$; by (i) the matrix of $W$ has support in $I\times I$, so $c,e\in I$ and $d,f\in I$, all four inside. That disposes of the brief's first question: yes, the vanishing of $W$ off $\Lambda^2U$ kills every term with any of $c,d,e,f$ outside, because each of those four indices sits on a factor of $W$.

**The bracket computation the proof asserts.** For $a\notin I$ and $c,d\in I$: write $v_c,v_d$ as skew $n\times n$ matrices vanishing on $U^\perp$ and preserving $U$. Then $v_cv_d$ and $v_dv_c$ both vanish on $U^\perp$ and preserve $U$, so $[v_c,v_d]$ does too, i.e. $[v_c,v_d]\in\mathfrak{so}(U)$. Concretely in coordinates, for $i,j,k,l\in U$,
$$[\varphi_{ij},\varphi_{kl}]=\delta_{jk}\varphi_{il}-\delta_{ik}\varphi_{jl}-\delta_{jl}\varphi_{ik}+\delta_{il}\varphi_{jk},$$
every term of which is a $\varphi$ with both indices in $U$. Hence $c_{acd}=\langle[v_c,v_d],v_a\rangle=0$ for $a\notin I$, **because the basis is adapted and $v_a$ is therefore orthogonal to $\mathfrak{so}(U)$.** Symmetrically $c_{bef}=0$ for $b\notin I$. So $(W^\#)_{ab}=0$ unless $a,b\in I$. Verdict on C4: **CONFIRMED**.

**The brief's item 3 is a real requirement, and it is met.** "$[\Lambda^2U,\Lambda^2U]\subseteq\Lambda^2U$" is a statement about a subspace of the Lie algebra; the step from it to "$c_{acd}=0$ for $a$ outside" needs the *inner product* to see the splitting, i.e. it needs $\operatorname{span}\{v_a:a\notin I\}=\mathfrak{so}(U)^\perp$. Without adaptedness the step is false as stated: in $\mathfrak{so}(4)$ with $U=\operatorname{span}(e_1,e_2,e_3)$, replace the orthonormal basis by one containing $u=(\varphi_{12}+\varphi_{14})/\sqrt2$; then $u\notin\mathfrak{so}(U)$, yet $\langle[\varphi_{13},\varphi_{23}],u\rangle=\langle-\varphi_{12},u\rangle=-1/\sqrt2\ne0$, a nonzero structure constant with $c,d$ inside and $a$ outside. **The subalgebra property alone does not deliver the conclusion; the subalgebra property together with an adapted orthonormal basis does.** Since $\#$ and everything else in sight is $O(n)$-equivariant, choosing such a basis is free, but the proof neither chooses it nor says it may. Recorded as the U1 finding: presentational, and the one place where the missing "WLOG" is load-bearing rather than cosmetic.

**The cleaner route, which the proof half-takes anyway.** Spectrally, $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ with all $v_\alpha$ of nonzero eigenvalue lying in $\operatorname{im}W\subseteq\mathfrak{so}(U)$; bilinearity gives $W^\#=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\tfrac12[v_\alpha,v_\beta][v_\alpha,v_\beta]^{\mathsf T}$, and each $[v_\alpha,v_\beta]\in\mathfrak{so}(U)$. This needs no basis choice at all and is immune to the trap above.

## 5. Step (iii), second half, the entries are $\mathfrak{so}(U)$'s own

Two things must agree between $\mathfrak{so}(U)$ and $\mathfrak{so}(n)$ for $(W^\#)_{ab}$ with $a,b\in I$ to be computable inside $U$: the bracket and the pairing. The bracket agrees because $\mathfrak{so}(U)\subseteq\mathfrak{so}(n)$ is a subalgebra with the *same* commutator, and the pairing agrees because padding a $k\times k$ skew matrix with zeros changes no entry, hence changes no $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$. Therefore $c^U_{abc}=c_{abc}$ for $a,b,c\in I$, and $(W^\#)_{ab}=((W')^\#)_{ab}$ there. The proof names the first and takes the second for granted; both are true and only the first is the interesting one. Verdict on C5: **CONFIRMED**.

**Screen, exact.** In $\mathfrak{so}(6)$ with $U=\operatorname{span}(e_1,\dots,e_4)$: with $A=\operatorname{pad}(\operatorname{id}_{\Lambda^2U})$, i.e. the orthogonal projection onto $\mathfrak{so}(U)$, the halved product returns $A^\#=(k-2)A=2A$ exactly, with $k=\dim U=4$ and **no dependence on $n=6$**. Computed inside $\mathfrak{so}(4)$ the same object returns $\operatorname{id}^\#=(4-2)\operatorname{id}$. Had $\#$ leaked the ambient dimension the first figure would have read $n-2=4$. This is a screen on an object I built for the purpose, in exact integer arithmetic; it is a consistency check on the claim above, not evidence for it, the argument is the paragraph, not the number. The general identity behind it, also exact: for a subalgebra $\mathfrak h$ with orthogonal projection $\pi_{\mathfrak h}$, $\operatorname{tr}(\pi_{\mathfrak h}^\#)=\tfrac12\sum_{a,b\in\mathfrak h}\lVert[v_a,v_b]\rVert^2=\tfrac12\sum_{a,b,c\in\mathfrak h}c_{abc}^2$, which for $\mathfrak h=\mathfrak{so}(k)$ is $\tfrac12\cdot6\binom k3=\tfrac12k(k-1)(k-2)$ against $\operatorname{tr}\pi_{\mathfrak h}=\binom k2$, giving the ratio $k-2$.

## 6. The displayed $\#$ formula is twice the record's $\#$

**Locate it.** Step (iii), the line *"$(W^\#)_{ab}=\sum c_{acd}c_{bef}W_{ce}W_{df}$"*, reproduced identically at [ATTEMPTS.md](../ATTEMPTS.md):5527.

**Exhibit the failure, in closed form.** Put $W=vv^{\mathsf T}+ww^{\mathsf T}$ for $v,w\in\Lambda^2$. The displayed formula returns
$$\sum_{c,d,e,f}c_{acd}c_{bef}(v_cv_e+w_cw_e)(v_dv_f+w_dw_f)=2[v,w]_a[v,w]_b,$$
the two pure terms vanishing by antisymmetry of $c_{acd}$ in $c,d$ and the two cross terms each contributing $[v,w]_a[v,w]_b$ via $\sum_{c,d}c_{acd}v_cw_d=\langle v_a,[v,w]\rangle$. The definition $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$ with bilinear extension returns $0+2\cdot\tfrac12[v,w][v,w]^{\mathsf T}+0=[v,w][v,w]^{\mathsf T}$. **Factor $2$.** At $W=\operatorname{id}$ the same clash reads $\operatorname{id}^\#=2(n-2)\operatorname{id}$ from the displayed formula against $(n-2)\operatorname{id}$ from the definition; screened exactly at $n=3,4,5$, returning $\{2,4,6\}$ and $\{1,2,3\}$ respectively.

**Which one is the record's.** The halved one. [conventions.md](../findings/conventions.md) fixes $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$; [VERIFY_v139.md](../verification/VERIFY_v139.md):36 carries the eigenbasis form *with* the $\tfrac12$ and checks it against $Q(I)=(n-1)I$, which needs $I^\#=(n-2)I$; [VERIFY_v211.md](../verification/VERIFY_v211.md):150 writes $\langle Z,X\#Y\rangle=\tfrac12\sum c_{acd}c_{bef}X_{ce}Y_{df}Z_{ab}$, again with the $\tfrac12$. **So the defect is that step (iii) dropped the $\tfrac12$ from an otherwise standard line.**

**Argue the opposite.** The most charitable reading is that the displayed line is the *unhalved* Böhm–Wilking product, which is a legitimate object and for which the formula is right as written; the author then simply omitted to say which $\#$ is meant. That reading does not survive the surrounding text, since the same lemma's conclusion is about $P$ and $\theta$, which are record quantities computed with the halved $\#$, and $Q=W^2+W^\#$ mixes an unambiguous $W^2$ with an ambiguous $W^\#$, so the two conventions give genuinely different values of $P$ and $\theta$, not a rescaling.

**Impact on L164: none.** The argument of (iii) reads off only *which indices can carry a nonzero entry*, and that is unchanged by a positive scalar. Both candidate products are $O(n)$-equivariant and both restrict to the corresponding product on $\mathfrak{so}(U)$. So C6 is a transcription discrepancy to repair in the text, and it moves no verdict. **A quantitative consumer reading $P$ off that line would be out by a factor of two on the $\#$ part**, which is the same trap [conventions.md](../findings/conventions.md) already books twice elsewhere.

## 7. The $\theta$ clause has no nonvanishing hypothesis, and the edges make that bite

**Locate it.** The statement's third equality, $\theta(W')=\theta(W)$, with $\theta(W)=P(W)/\lVert W\rVert^3$ and no hypothesis excluding $W=0$.

**Exhibit the failure.** $W=0$ satisfies the hypothesis for *every* subspace $U$, including $U=0$, and both sides read $0/0$. This is not an idle corner, because a second stated edge forces it: **for $\dim U\le3$ the hypothesis is satisfiable only by $W=0$**. Indeed $W'\in\mathcal W_{\dim U}=0$ by the membership clause, and $W=\operatorname{pad}W'$, so $W=0$. The same holds at $\dim U=0$. So the whole range $\dim U\le3$ of the statement's quantifier consists of instances where the third equality is ill-formed and the first two are the trivial $0=0$.

**Argue the opposite.** Two readings save it. (a) $\theta$ is a partial function and the equality is asserted where both sides are defined, legitimate, and by (ii) the two sides are defined or undefined *together*, since $\lVert W'\rVert=\lVert W\rVert$; so the repair is genuinely one clause and costs nothing. (b) The record only ever consumes L164 at $W\ne0$, the block's own Scope paragraph reasons at "$\dim U=4=n$ for every $W\ne0$", so the author was working under the hypothesis without writing it into the lemma. Both readings agree on the fix.

**The repair.** Add "$W\ne0$" to the $\theta$ clause, or state the lemma as $\lVert W'\rVert=\lVert W\rVert$ and $P(W')=P(W)$, with $\theta(W')=\theta(W)$ following whenever $W\ne0$. Verdict on C11: **HYPOTHESIS-DEBT, one clause, no consumer affected.**

**The other edges, each answered.**

- **$\dim U=n$.** $U^\perp=0$, the hypothesis is vacuous, $W'=W$, and all three equalities are identities. The conclusion reads correctly; the membership clause reads $W\in\mathcal W_n$, which is the assumption. No finding.
- **$\dim U=4$.** Non-vacuous and the interesting case: the $\Lambda^\pm$ splitting gives $\dim\mathcal W_4=10$, and $\operatorname{pad}$ of any $W'\in\mathcal W_4$ does land in $\mathcal W_n$ (symmetry and pair symmetry are clear; first Bianchi holds because a triple with any index outside $U$ has all three terms carrying that index, hence all three zero; and $\operatorname{Ric}(\operatorname{pad}W')_{ik}$ is $\operatorname{Ric}(W')_{ik}$ for $i,k\in U$ and $0$ otherwise). So the statement has witnesses. No finding.
- **Odd $\dim U$.** Nothing in (i)–(iv) is parity-sensitive; $\mathcal W_5\ne0$ supplies witnesses. No finding.
- **$\dim U\le3$.** As above: satisfiable only at $W=0$, which is where the $\theta$ clause fails to parse. Folded into C11.

## 8. Step (iv), and the two inheritances the brief singles out

**First Bianchi, in index form.** The identity is $R_{ijkl}+R_{iklj}+R_{iljk}=0$ for all $i,j,k,l$. Fix $i,j,k,l\in U$. Every component appearing ($R_{ijkl}$, $R_{iklj}$, $R_{iljk}$), has all four indices in $U$, hence equals the corresponding component of $W'$ by (i). **So the identity at indices in $U$ is literally one of the identities $W$ satisfies on $\mathbb R^n$, and no component the restriction discards appears in it.** That answers the brief's question directly: it is a genuine sub-family, and the identity on $U$ involves no thrown-away index. Verdict on C7: **CONFIRMED**.

**Pair symmetry.** *"Likewise"* is, on inspection, the whole argument and it is sufficient, for the same reason and by the same sentence: $R_{ijkl}=R_{klij}$ at $i,j,k,l\in U$ involves only components with all four indices in $U$. Equivalently and basis-free: $W'$ is the restriction of a self-adjoint operator to an invariant subspace, hence self-adjoint. **The word "likewise" hides that the second reason is a different argument from the first, Bianchi is an index-range restriction, pair symmetry is a restriction-of-a-symmetric-operator fact, but both are one line and both are right.** I note that the block already carries a callout to this effect ("PAIR SYMMETRY AND FIRST BIANCHI ARE INHERITED RATHER THAN SHOWN"); this report discharges it rather than repeating it. Verdict on C8: **CONFIRMED**.

## 9. Ricci-flatness, both definitions

**Index form.** For $i,k\in U$: $\operatorname{Ric}(W')_{ik}=\sum_{j\in U}R'_{ijkj}=\sum_{j\in U}R_{ijkj}$, and $\sum_{j\in U^\perp}R_{ijkj}=0$ since each such component has an index outside $U$. Hence $\operatorname{Ric}(W')_{ik}=\operatorname{Ric}(W)_{ik}=0$.

**Adjoint form, which is the definition the brief fixes.** $\operatorname{Ric}$ is the adjoint of $h\mapsto h\wedge\operatorname{id}$, so Ricci-flatness of $W$ is $\langle W,h\wedge\operatorname{id}_{\mathbb R^n}\rangle=0$ for every symmetric $h$ on $\mathbb R^n$. **The dimension change is harmless because it happens on the side that shrinks.** For $h$ supported on $U$ the components of $h\wedge\operatorname{id}_{\mathbb R^n}$ with all four indices in $U$ are $h_{ik}\delta_{jl}-h_{il}\delta_{jk}-h_{jk}\delta_{il}+h_{jl}\delta_{ik}$ with $\delta$ restricted to $U$, i.e. exactly the components of $h'\wedge\operatorname{id}_U$; and by (i) only those components can pair with $W$. So $\langle W',h'\wedge\operatorname{id}_U\rangle=\langle W,h\wedge\operatorname{id}_{\mathbb R^n}\rangle=0$ for every $h'$ on $U$, which is $\operatorname{Ric}(W')=0$. Any $n$-dependent constant in "the adjoint" divides out of a vanishing statement. Verdict on C9: **CONFIRMED**.

**One citation note.** The record's own step (iv) discharges this by citing [L30](../findings/stratum-two-negative.md)'s last line rather than arguing it, while L164 is quantified over *every* $U$ meeting the support hypothesis and L30 proves its clause for the particular $U$ it constructs. The citation survives, because L30's sentence ("the terms of $\operatorname{Ric}$ involving directions outside $U$ vanish with $W$"), uses only the support and not L30's construction of $U$. The brief's version of step (iv) inlines that reasoning, which is the better form. No finding, but the dependency should be read as "L30's sentence, which is generic" rather than "L30's conclusion, which is not".

## 10. The final chain, on the nose

$$P(W')\overset{\text{def}}{=}\langle W',Q(W')\rangle,\qquad Q(W')=(W')^2+(W')^\#.$$
By (i), $W=\operatorname{pad}W'$. By (i) again, $W^2=\operatorname{pad}((W')^2)$: for $a,b$ inside, $(W^2)_{ab}=\sum_cW_{ac}W_{cb}$ and only $c$ inside contributes; for $a$ or $b$ outside the row or column of $W$ is zero. By §4–§5, $W^\#=\operatorname{pad}((W')^\#)$. Hence $Q(W)=\operatorname{pad}(Q(W'))$, and
$$\langle W,Q(W)\rangle=\sum_{a,b}W_{ab}Q(W)_{ab}=\sum_{a,b\ \mathrm{inside}}W'_{ab}Q(W')_{ab}=\langle W',Q(W')\rangle,$$
because padding inserts only zeros and the surviving block is an orthonormal-basis Frobenius sum in both dimensions. **Restricting an operator to an invariant subspace preserves the trace pairing exactly when the complement is annihilated on both factors, and here it is annihilated on $W$ alone, which already suffices**, since a zero factor kills the term whatever the other factor does. Then $\theta(W')=P(W')/\lVert W'\rVert^3=P(W)/\lVert W\rVert^3=\theta(W)$ by this and §3, for $W\ne0$. Verdict on C10: **CONFIRMED**.

**Screen, exact.** $W'\in\mathcal W_4$ self-dual with eigenvalues $(1,1,-2)$ on $\Lambda^+$ and $0$ on $\Lambda^-$ (the record's $W_{\mathbb{CP}^2}$ up to sign), checked to satisfy first Bianchi and $\operatorname{Ric}=0$ exactly, then padded to $\mathbb R^6$: $\operatorname{pad}W'$ satisfies first Bianchi and $\operatorname{Ric}=0$ in $\mathbb R^6$; $(\operatorname{pad}W')^\#$ is supported on $\Lambda^2U$ and its $U$-block equals $(W')^\#$ computed in $\mathfrak{so}(4)$; $\lVert\cdot\rVert^2=6$ and $P=-18$ on both sides, whence $\theta^2=P^2/\lVert\cdot\rVert^6=3/2$ on both sides, i.e. $\lvert\theta\rvert=\sqrt{3/2}$, reproducing the record's $\theta^*=\sqrt{3/2}$ for $W_{\mathbb{CP}^2}$ in the $(2,-1,-1)$ normalisation. Exact rational arithmetic throughout; reported as a screen.

## 11. The disclaimer

**What the block says.** *"What is NOT proved, and is not needed, is the operator identity $Q(\operatorname{pad}W')=\operatorname{pad}Q(W')$: $\theta$ needs only the scalar $\langle W,Q(W)\rangle$ to agree"*, with the justification *"the argument above runs on tensors supported in $\Lambda^2U$, not on arbitrary ones"*.

**"Not needed" is right, and sharper than stated.** §10 shows the displayed equalities need only that the **$\Lambda^2U$-block** of $Q(W)$ equal $Q(W')$; whether $Q(W)$ has entries outside that block is irrelevant, since they meet only zeros of $W$ in the pairing. So the scalar statement suffices, and even less than the block identity would do for $P$ alone.

**"Not proved" is wrong.** Step (iii) concludes in its own words that *"$W^\#$ is supported on $\Lambda^2U$"* and that *"$Q(W)$ is supported on $\Lambda^2U$ and restricts to $Q(W')$"*, which is the operator identity, verbatim. And the justification offered for the disclaimer is a distinction without a difference: **$\operatorname{pad}W'$ is, by construction, supported in $\Lambda^2U$ for every $W'$ whatsoever**, so "runs on tensors supported in $\Lambda^2U$, not on arbitrary ones" excludes nothing that the identity quantifies over. Nor does the argument of (iii) use first Bianchi or Ricci-flatness (it uses symmetry and support only) so the identity it proves holds for every symmetric operator on $\Lambda^2U$, not merely the Weyl ones.

**The record already contradicts itself here.** [VERIFY_v211.md](../verification/VERIFY_v211.md):151 states the opposite in as many words: *"it is the stronger operator statement rather than the quadratic form … So $W\#W$ is itself supported in $\mathfrak{so}(U)$ and equals $W'\#W'$ there, i.e. $Q\circ\operatorname{pad}=\operatorname{pad}\circ Q$."* One of the two lines has to go, and it is the disclaimer.

**Argue the opposite.** There is a true statement in the neighbourhood, and it is probably what was meant: **$Q$ does not commute with *restriction* for tensors that are not supported in $\Lambda^2U$**, $Q(W)|_{\Lambda^2U}\ne Q(W|_{\Lambda^2U})$ in general, because $W^\#$ then picks up brackets of bivectors that leave $\mathfrak{so}(U)$. That disclaimer would be correct, useful, and is a different sentence from the one on file. Verdict on C12: **the "not needed" half CONFIRMED, the "not proved" half REFUTED**; repair by restating the callout as the restriction claim.

## 12. Kernels, and whether $U$ is determined by $W$

**$U$ is not determined by $W$, and the statement is consistent with that.** Call $U$ *admissible* for $W$ if $\ker W\supseteq(\Lambda^2U)^\perp$. If $U_1,U_2$ are admissible then so is $U_1\cap U_2$, since $\operatorname{im}W\subseteq\Lambda^2U_1\cap\Lambda^2U_2=\Lambda^2(U_1\cap U_2)$ and symmetry converts that back into the kernel condition. So there is a **canonical minimal** $U_{\min}(W)$, and the admissible $U$ are exactly the subspaces containing it. The statement therefore quantifies over a whole flag at each $W$, and it is consistent across the flag, because every member returns the same three numbers, namely the ambient $\lVert W\rVert$, $P(W)$, $\theta(W)$. **This coherence is a nontrivial check on the statement and it passes.** No finding.

**A large kernel changes nothing in the argument.** $\ker W$ always contains $(\Lambda^2U)^\perp$ by hypothesis, and may additionally meet $\Lambda^2U$; the proof never divides by an eigenvalue, never separates $\ker W$ from its complement, and the spectral form of §4 simply drops the zero eigenvalues. The one place a kernel is known to bite on this record (L30's construction of $U$ from eigenvectors, where a kernel eigenvector breaks $v_\alpha u=0$), sits **upstream** of L164 and is L30's problem: L164 takes the support as a hypothesis rather than building $U$. **That is exactly why L164 is the clean half of the pair, and it should be read as insulated from the kernel obstruction, not as inheriting it.** No finding.

## 13. The named families

The statement is universal, so a witness cannot prove it; what the families can do is show whether the hypothesis is ever met non-vacuously and whether the conclusion holds where it is.

- **Sphere products $W_{p,q}$, inside $\mathbb R^{p+q}$: the hypothesis holds only vacuously.** $W_{p,q}$ is $O(p)\times O(q)$-invariant, and $U_{\min}$ is canonically attached to $W_{p,q}$, hence $O(p)\times O(q)$-invariant, hence one of $0$, $\mathbb R^p$, $\mathbb R^q$, $\mathbb R^{p+q}$. The middle two are excluded: $W_{p,q}$ restricted there would be an $O(p)$-invariant element of $\mathcal W_p$, and $\mathcal W_p$ carries no trivial $O(p)$-summand. So $U_{\min}=\mathbb R^{p+q}$ for $W_{p,q}\ne0$, and the only admissible $U$ is everything. **The statement is true and empty there.**
- **$W_{\mathbb{CP}^m}$, inside $\mathbb R^{2m}$: likewise.** $U(m)$ acts irreducibly on $\mathbb R^{2m}$, so the only invariant subspaces are $0$ and $\mathbb R^{2m}$, and $U_{\min}=\mathbb R^{2m}$.
- **Paddings of both: this is where the statement lives.** $\operatorname{pad}(W_{p,q})$ and $\operatorname{pad}(W_{\mathbb{CP}^m})$ into $\mathbb R^n$ satisfy the hypothesis at $U=\mathbb R^{p+q}$ resp. $\mathbb R^{2m}$ and at every larger $U$, and the conclusion holds, screened exactly for $\operatorname{pad}(W_{\mathbb{CP}^2})$ from $\mathbb R^4$ to $\mathbb R^6$ in §10, reproducing $\lvert\theta\rvert=\sqrt{3/2}$ on both sides. **The trap worth naming: $\operatorname{pad}$ of an algebraic Weyl tensor is an algebraic Weyl tensor, but it is not the Weyl tensor of the padded geometry**, the Weyl part of $S^p\times S^q\times\mathbb R^{n-p-q}$ is recomputed in dimension $n$ and is a different object. L164 is a statement about the first and says nothing about the second.
- **Subalgebra-Casimir tensors $\pi_{\mathfrak h}$ with $\mathfrak h\subseteq\mathfrak{so}(U)$.** Supported on $\Lambda^2U$ by construction, so they satisfy the hypothesis; they are **not** Ricci-flat ($\operatorname{Ric}(\pi_{\mathfrak{so}(U)})_{ik}=(\dim U-1)\delta_{ik}$ on $U$), so they lie outside $\mathcal W_n$ and test (i)–(iii) rather than the whole lemma. They test it usefully, because (i)–(iii) never use Ricci-flatness: §5's exact screen is precisely this family at $\mathfrak h=\mathfrak{so}(4)\subseteq\mathfrak{so}(6)$, and it returns $(k-2)$ rather than $(n-2)$.
- **Tori.** For a torus $\mathfrak t\subseteq\mathfrak{so}(U)$, $\pi_{\mathfrak t}^\#=0$ on the nose, $\mathfrak t$ being abelian, in both $\mathfrak{so}(U)$ and $\mathfrak{so}(n)$. The padding claim is trivially consistent and this family cannot distinguish the two $\#$ conventions of §6 either, worth knowing, since a factor-$2$ error is invisible on it.

## 14. What a counterexample would have to be, and what I did

**Name it.** A falsifier is a symmetric $W$ on $\Lambda^2\mathbb R^n$, in $\mathcal W_n$, with $\ker W\supseteq(\Lambda^2U)^\perp$ for some subspace $U$, such that one of: (a) $W$ fails to preserve $\Lambda^2U$; (b) $\lVert W|_{\Lambda^2U}\rVert\ne\lVert W\rVert$; (c) $W^\#$ has a nonzero entry with an index outside $\mathfrak{so}(U)$, or an inside entry differing from $(W')^\#$; (d) $W'$ violates first Bianchi, pair symmetry or Ricci-flatness on $U$; (e) $W\ne0$ with $\theta(W')\ne\theta(W)$.

**Where each is closed off.** (a) needs $W$ non-symmetric, excluded by $\mathcal W_n$, and §2 exhibits the non-symmetric map that would do it. (b) needs the half-trace norm of a bivector to depend on the ambient dimension, $\tfrac12\operatorname{tr}(\varphi^{\mathsf T}\varphi)=1$ in every dimension. (c) needs a structure constant $c_{acd}$ with $c,d\in\mathfrak{so}(U)$ and $a\perp\mathfrak{so}(U)$, i.e. a subspace $U$ for which $\Lambda^2U$ is not closed under the bracket, and $\mathfrak{so}(U)$ is a subalgebra for every subspace, the bracket table of §4 exhibiting the closure term by term. **This is the only place the statement could have failed, and it is the one place the proof does real work.** (d) needs an identity on $U$ that reaches a component with an index outside, §8 and §9 show every such identity is closed in $U$. (e) is (b) and (c) combined.

**What I did to look for one.** Analysis only: I checked the closure of $\mathfrak{so}(U)$ in coordinates, exhibited the *non-adapted* basis in which the structure-constant step genuinely fails (§4) to see whether the real proof depends on something the written one omits (it does, and the omission is repairable by $O(n)$-equivariance) and ran two exact screens on objects I constructed, reported as screens. **No search, sweep or census.** The statement is not one a hunt could break: the failure modes above are all closed by identities, not by parameter ranges.

## Overall verdict

**PROVEN, hypotheses corrected.**

The lemma is true, the proof on file establishes it, and every step survives attack. Three things to fix in the text, none of which moves the conclusion:

1. **Add $W\ne0$** to the $\theta$ clause. Without it the clause is $0/0$ at $W=0$, and the whole $\dim U\le3$ range of the quantifier consists of exactly that instance.
2. **Restore the $\tfrac12$** in step (iii)'s displayed formula, which as written is twice the record's $\#$, screened exactly at $\operatorname{id}^\#$, $2(n-2)$ against $(n-2)$, for $n=3,4,5$.
3. **Restate the "what is NOT proved" callout.** Step (iii) does prove $Q\circ\operatorname{pad}=\operatorname{pad}\circ Q$, for every symmetric operator supported in $\Lambda^2U$ (which is every operator $\operatorname{pad}$ can produce) and [VERIFY_v211.md](../verification/VERIFY_v211.md) already says so. The true nearby claim is that $Q$ does not commute with *restriction* for tensors **not** supported in $\Lambda^2U$.

Two presentational notes, recorded rather than charged: **(ii) elides the step from the bivector isometry to the operator norm**, which is one line via block-diagonality; and **(iii) needs the orthonormal basis to be adapted to $U$**, which is free by $O(n)$-equivariance but is used without being claimed, and without which §4 exhibits a nonzero $c_{acd}$ of exactly the forbidden shape. Finally, the three displayed equalities use **neither first Bianchi nor Ricci-flatness** (those enter only for membership in $\mathcal W_{\dim U}$) so the norm, $P$ and $\theta$ half of the lemma holds for every symmetric operator supported on $\Lambda^2U$, which is the form a consumer outside $\mathcal W_n$ would want.
