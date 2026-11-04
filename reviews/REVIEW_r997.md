# Review r997: the bracket-trace bridge, and the Gram reading of Ricci-flatness

Gate 2, brief [BRIEF_I74_bridge.md](BRIEF_I74_bridge.md). Reviewer r997, one of two on identical briefs, working independently. Log at [agent_logs/r997-i74-bridge.log](../agent_logs/r997-i74-bridge.log).

Every row was derived here from the brief's definitions before any arithmetic was run. Numbers below are screens on objects built for the purpose, each one an assertion that passed, never a printed expectation.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | the bridge, $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)$ | **CONFIRMED**, and it is the orthogonal case of a general identity |
| 2 | the bracket is decomposable | **CONFIRMED**, and $\Lambda^2$-orthogonality is load-bearing |
| 3 | L31's pair cap sharpens from $2$ to $1$ | **CONFIRMED**, and it holds under a weaker hypothesis than stated |
| 4 | $\sum_{\beta\ne\alpha}\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=2(n-2)$ | **CONFIRMED** |
| 5 | $\sum_{\alpha\ne\beta}\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=n(n-1)(n-2)$ | **CONFIRMED** |
| 6 | Ricci-flatness of $W$ is exactly $S\lambda=0$ | **CONFIRMED**, non-vacuous at $n\ge4$, vacuous at $n=3$ |
| 7 | $S\succeq0$, trace $n(n-1)$, $\mathop{\mathrm{rank}}S=\dim\mathop{\mathrm{span}}\{\Pi_\alpha\}$, $\mathbf1$ at $2(n-1)$ | **CONFIRMED**, all four clauses |
| 8 | $S=A(J(n,2))+2\,\mathrm{Id}$, spectrum, $\lVert S\rVert_F^2=n^2(n-1)$ | **CONFIRMED**, recomputed two independent ways |
| 9 | relation (B) is $(S\lambda)_k=0$ | **CONFIRMED** as algebra, on the bridge |
| 10 | relation (C) summed gives $\lambda^{\mathsf T}S\lambda=0$, hence $S\lambda=0$ | **CONFIRMED**, with the brief's stated doubt dismissed and a different one raised |
| 11 | only the off-diagonal of $W^\#=\theta W-W^2$ can bite | **PLAUSIBLE**, with both halves corrected |

## The three things worth reading first

- **The bridge is the $\Lambda^2$-orthogonal case of a basis-free identity that holds at every pair of decomposable unit forms**: $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)-2\langle\omega_\alpha,\omega_\beta\rangle^2$. The record should carry this form, because it makes the orthogonality hypothesis visible as the term it kills rather than as a side condition on the normalisation.
- **Row 10 is correct and its entire content is one factor of $2$.** Relations (A), (B) and (C) are each *twice* the diagonal of the corresponding $\#$-identity. Read (C) without that factor and the same summation returns $\lambda^{\mathsf T}S\lambda=\lVert W\rVert^2$ instead of $0$, and the row is false. The brief's own doubt, that a singular $S$ might block $\lambda^{\mathsf T}S\lambda=0\Rightarrow S\lambda=0$, is unfounded and needs no repair.
- **No Lean declaration types row 1, not even at an instance.** [trace_instA_instB](../lean/HamiltonsCubic/Results/L201Statement.lean) and [frobSq_commutator_inst](../lean/HamiltonsCubic/Results/L201Statement.lean) type a *different* identity, $\lVert[\Pi_\alpha,\Pi_\beta]\rVert_F^2=2t(1-t)$, about the commutator of the two *projections* in the Frobenius norm. Row 1 is about the commutator of the two *bivectors* in the $\Lambda^2$ norm. Both are true, and the brief's table conflates them.

## Row 1, the bridge

**Principal position is available at every pair, with no exception.** For planes $P,Q$ take the $2\times2$ matrix $G_{ij}=\langle p_i,q_j\rangle$ of any orthonormal bases and apply its singular value decomposition. Rotating each basis by the corresponding singular vectors gives orthonormal $a,b$ of $P$ and $c,d$ of $Q$ with $a\cdot c=\gamma_1$, $b\cdot d=\gamma_2$, $a\cdot d=b\cdot c=0$, where $\gamma_1\ge\gamma_2\ge0$ are the singular values. An SVD exists for every real matrix, so the normal form exists at every pair including equal planes, planes meeting in a line, and orthogonal planes. The rotation changes $a\wedge b$ by $\det$ of a rotation, which is $+1$, and a basis reversal by $-1$, so $\omega_\alpha=\pm\,a\wedge b$ and every squared quantity below is unaffected.

**$\Lambda^2$-orthogonality is exactly $\gamma_1\gamma_2=0$.** $\langle a\wedge b,c\wedge d\rangle=(a\cdot c)(b\cdot d)-(a\cdot d)(b\cdot c)=\det G$, and in principal position $\det G=\gamma_1\gamma_2$. So yes, $\Lambda^2$-orthogonality forces $\cos\vartheta_1\cos\vartheta_2=0$, and it is equivalent to it. Also $\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=\sum_{ij}\langle p_i,q_j\rangle^2=\lVert G\rVert_F^2=\gamma_1^2+\gamma_2^2$.

**The bracket in general.** With $a\wedge b$ carried to the skew matrix $b\,a^{\mathsf T}-a\,b^{\mathsf T}$, expanding $AB-BA$ gives
$$[a\wedge b,c\wedge d]=(a\cdot c)\,b\wedge d-(a\cdot d)\,b\wedge c-(b\cdot c)\,a\wedge d+(b\cdot d)\,a\wedge c,$$
so in principal position two of the four terms vanish, leaving $\gamma_1\,b\wedge d+\gamma_2\,a\wedge c$. **The record's proof says three of four vanish, which is true only under the orthogonality hypothesis.** Taking norms, $\lVert b\wedge d\rVert^2=1-\gamma_2^2$, $\lVert a\wedge c\rVert^2=1-\gamma_1^2$, and the cross term $\langle b\wedge d,a\wedge c\rangle=(b\cdot a)(d\cdot c)-(b\cdot c)(d\cdot a)=0$, whence
$$\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\gamma_1^2+\gamma_2^2-2\gamma_1^2\gamma_2^2=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)-2\langle\omega_\alpha,\omega_\beta\rangle^2 .$$
At $\gamma_2=0$ this is the claimed bridge, with the common value $\gamma_1^2=\cos^2\vartheta_1\in[0,1]$. Screened as an assertion at $1200$ random decomposable pairs with no orthogonality imposed at $n=3,5,7$ and at $1200$ orthogonal pairs built in principal position at $n=4,5,6,8$.

**The three edge cases the brief asks for.**

- *Equal planes.* $\gamma_1=\gamma_2=1$, so $\lvert\langle\omega_\alpha,\omega_\beta\rangle\rvert=1$ and the pair is **not** $\Lambda^2$-orthogonal. The case cannot occur in the hypothesis and needs no separate treatment. Both sides are $0$ and $2$ respectively, so the *unqualified* bridge is false here, which is why orthogonality cannot be dropped.
- *Planes meeting in a line.* $\gamma_1=1,\gamma_2=0$. Orthogonal, $t=1$, bracket $=b\wedge d$, a unit decomposable form. The principal vector $c$ coincides with $a$ and the vector $e$ of the decomposition $c=\gamma_1a+\sigma e$ degenerates, but it appears in no formula, so the derivation is unaffected.
- *Orthogonal planes.* $\gamma_1=\gamma_2=0$, $t=0$, bracket $=0$.

**The norm convention is a live hazard.** The brief's inner product makes $\varphi_{ab}$ orthonormal, and $\lVert\varphi_{ab}\rVert_F^2=2$, so the $\Lambda^2$ norm is *half* Frobenius. Under the Frobenius norm the bridge reads $2\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)$ and the row is off by a factor of $2$. Screened at the Lean file's own instance: $\lVert[\omega_A,\omega_B]\rVert^2=9/25$ in the $\Lambda^2$ norm, against $\lVert[\Pi_A,\Pi_B]\rVert_F^2=288/625$ for the projections.

## Row 2, decomposability of the bracket

**CONFIRMED.** At an orthogonal pair the bracket is $\gamma_1\,(b\wedge d)$ with $b\in P$ unit, $d\perp P$ unit, so $b\cdot d=0$ and $b\wedge d$ is a unit decomposable form. With integrality, $\gamma_1^2=t\in\{0,1\}$, so the bracket is zero or a unit bivector, as claimed. Screened as a rank assertion: the bracket matrix has rank at most $2$ at every orthogonal pair tested.

**The hypothesis is not decorative.** At $P=\mathop{\mathrm{span}}\{e_1,e_2\}$ and $Q=\mathop{\mathrm{span}}\{(e_1+e_3)/\sqrt2,(e_2+e_4)/\sqrt2\}$, which is decomposable and *not* $\Lambda^2$-orthogonal, the bracket is $\tfrac12(e_1\wedge e_3+e_2\wedge e_4)$, of rank $4$. So "the bracket of two decomposable forms is decomposable" is false in general, and the row is true only as stated.

## Row 3, the sharpened pair cap

**CONFIRMED, and true under a weaker hypothesis than the row states.** For a unit decomposable $\omega$, $\mathop{\mathrm{ad}}(\omega)$ annihilates $\omega$ itself and every $e_k\wedge e_l$ with $k,l\perp P$, and acts on each $\mathop{\mathrm{span}}\{e_1\wedge e_k,e_2\wedge e_k\}$, $k\perp P$, as a quarter-turn. So $\lVert\mathop{\mathrm{ad}}(\omega)\rVert_{\mathrm{op}}=1$ exactly, and therefore
$$\lVert[\omega,v]\rVert^2\le\lVert v\rVert^2=1$$
for **every** unit $v$, decomposable or not, orthogonal to $\omega$ or not. **The cap $1$ needs only one of the two arguments to be decomposable**, where the row asks for the whole locus. Screened as an operator-norm assertion at random decomposable units for $n=4,5,6$.

**The equality case.** Among $\Lambda^2$-orthogonal decomposable pairs, the bridge gives equality exactly at $t=1$, that is $\gamma_1=1$, that is $\vartheta_1=0$: the two planes share a line, and share exactly a line since $\gamma_2=0$ excludes equality of the planes. Confirmed.

**Whether the general cap needs rank four in both arguments: yes, and that is what forces the sharpening.** At a self-dual unit $\omega=(e_1\wedge e_2+e_3\wedge e_4)/\sqrt2$, $\lVert\mathop{\mathrm{ad}}(\omega)\rVert_{\mathrm{op}}=\sqrt2$, which is where the recorded cap $2$ comes from. Since one decomposable argument already caps the value at $1$, equality at $2$ requires *both* arguments to have rank at least $4$, and a decomposable form has rank $2$. Screened as an assertion against $\sqrt2$.

## Rows 4 and 5, the two marginals

**Both CONFIRMED, from completeness alone.** For an orthonormal basis of $\Lambda^2$ by decomposable forms, $\Pi_\alpha=-\omega_\alpha^2=\omega_\alpha\omega_\alpha^{\mathsf T}$, and $\sum_\alpha\Pi_\alpha=(n-1)\mathrm{Id}$, which is basis-independent and checks on the coordinate basis, each index appearing in $n-1$ planes. Then
$$\sum_{\beta\ne\alpha}\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=\mathop{\mathrm{tr}}\!\big(\Pi_\alpha((n-1)\mathrm{Id}-\Pi_\alpha)\big)=2(n-1)-2=2(n-2),$$
using $\mathop{\mathrm{tr}}\Pi_\alpha^2=\mathop{\mathrm{tr}}\Pi_\alpha=2$. Summing over the $N=\binom n2$ indices gives $\tfrac{n(n-1)}2\cdot2(n-2)=n(n-1)(n-2)$. Neither row needs decomposability of the *other* basis elements beyond what makes $\Pi_\alpha$ a rank-two projection, and neither needs integrality.

## Rows 6 and 7, the Gram matrix and the positivity argument

**Ricci-flatness is $M=0$.** For $W=\sum_\alpha\lambda_\alpha\,\omega_\alpha\otimes\omega_\alpha$ the tensor is $R_{ijkl}=\sum_\alpha\lambda_\alpha(\omega_\alpha)_{ij}(\omega_\alpha)_{kl}$, so $\mathrm{Ric}_{ik}=\sum_jR_{ijkj}=\sum_\alpha\lambda_\alpha(\omega_\alpha\omega_\alpha^{\mathsf T})_{ik}=M_{ik}$. **The Ricci tensor of $W$ IS the brief's $M$**, up to the overall sign convention, which does not affect vanishing.

**Row 7, all four clauses CONFIRMED.** $S_{\alpha\beta}=\langle\Pi_\alpha,\Pi_\beta\rangle$ is a Gram matrix in $\mathrm{Sym}^2\mathbb R^n$, hence positive semidefinite with $\mathop{\mathrm{rank}}S=\dim\mathop{\mathrm{span}}\{\Pi_\alpha\}$. Its trace is $\sum_\alpha\mathop{\mathrm{tr}}\Pi_\alpha^2=2N=n(n-1)$. And $(S\mathbf1)_\alpha=\mathop{\mathrm{tr}}(\Pi_\alpha\cdot(n-1)\mathrm{Id})=2(n-1)$, so $\mathbf1$ is an eigenvector at $2(n-1)$.

**Row 6, CONFIRMED, and the one-line argument is sound.** $(S\lambda)_\beta=\langle M,\Pi_\beta\rangle$, so $M=0$ gives $S\lambda=0$. Conversely $M=\sum_\alpha\lambda_\alpha\Pi_\alpha$ **is by construction a linear combination of the $\Pi_\alpha$**, so it lies in their span, and $S\lambda=0$ says it is orthogonal to every spanning vector, hence to itself. The pairing $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$ restricted to symmetric matrices is $\mathop{\mathrm{tr}}(A^{\mathsf T}B)$, the Frobenius inner product, positive definite on all of $\mathrm{Sym}^2$ and therefore on the span. So $M=0$. Both halves check out and nothing hidden is used.

**Vacuity.** The Ricci-flat weightings are exactly $\ker S$. At a coordinate configuration row 8's spectrum gives $\dim\ker S=\binom n2-n=\tfrac{n(n-3)}2$, which is positive for $n\ge4$ and zero at $n=3$. **So row 6 describes an empty set at $n=3$ and a space of dimension $\tfrac{n(n-3)}2$ at every coordinate configuration with $n\ge4$.** At $n=4$ it is two-dimensional, spanned by weightings such as $\lambda_{12}=\lambda_{34}=1$, $\lambda_{13}=\lambda_{24}=-1$, $\lambda_{14}=\lambda_{23}=0$, which is traceless and, because every $\omega_\alpha$ is decomposable so that $\sum_\alpha\lambda_\alpha\,\omega_\alpha\wedge\omega_\alpha=0$, satisfies the first Bianchi identity as well. **The row is therefore non-vacuous in the strict Weyl-tensor sense from $n=4$ up.** Screened as assertions at $n=4$ through $8$.

**But it is vacuous at some configurations, which is the useful half.** At the six icosahedral axes, built here as a genuine orthonormal decomposable basis of $\Lambda^2\mathbb R^4$ with $\sum\Pi_\alpha=3\,\mathrm{Id}$, the Gram matrix is $S=\tfrac45\mathbf1\mathbf1^{\mathsf T}+\tfrac65\mathrm{Id}$, of spectrum $6$ and $\tfrac65$ at multiplicities $1$ and $5$, hence **nonsingular**, so the only Ricci-flat weighting there is $\lambda=0$. Every off-diagonal entry is $\tfrac45$, so this configuration is non-integral, and the bridge was verified to return $\tfrac45$ at each of its thirty ordered pairs.

## Row 8, the Johnson graph

**CONFIRMED in every part.** At a coordinate configuration $S_{\alpha\beta}=\mathop{\mathrm{tr}}(\Pi_{ij}\Pi_{kl})=\lvert\{i,j\}\cap\{k,l\}\rvert$, so $S-2\,\mathrm{Id}$ is a zero-diagonal $0/1$ matrix adjacent exactly at pairs meeting in one index. **That is the Johnson graph $J(n,2)$, equivalently the triangular graph $T(n)$, equivalently the line graph of $K_n$**, and the identification is right. Its spectrum is $2(n-2)$, $n-4$ and $-2$ at multiplicities $1$, $n-1$ and $\tfrac{n(n-3)}2=\binom n2-n$, so adding $2\,\mathrm{Id}$ gives $2n-2$, $n-2$ and $0$ at those multiplicities, as the row states.

**The Frobenius norm, two independent ways.** From the spectrum,
$$\lVert S\rVert_F^2=(2n-2)^2+(n-1)(n-2)^2=(n-1)\big[4n-4+n^2-4n+4\big]=n^2(n-1).$$
From the entries, the diagonal contributes $4N=2n(n-1)$ and the off-diagonal entries lie in $\{0,1\}$ so their squares sum to their values, which is row 5's $n(n-1)(n-2)$, and $2n(n-1)+n(n-1)(n-2)=n^2(n-1)$. The two agree. Screened as assertions at $n=4$ through $10$, including the degree $2(n-2)$, the row sum $2(n-1)$, the trace $n(n-1)$ and $\mathop{\mathrm{rank}}S=n$.

## Row 9, relation (B)

**CONFIRMED as algebra.** Writing $T_{k\beta\gamma}=c_{k\beta\gamma}^2$ with $c_{\alpha\beta\gamma}=\langle[\omega_\alpha,\omega_\beta],\omega_\gamma\rangle$, Parseval gives $\sum_\gamma T_{k\beta\gamma}=\lVert[\omega_k,\omega_\beta]\rVert^2$, which the bridge turns into $S_{k\beta}$ for $\beta\ne k$ and into $0$ at $\beta=k$, since $[\omega_k,\omega_k]=0$ while $S_{kk}=2$. **That mismatch at the diagonal is precisely why the shift is $\hat S=S-2\,\mathrm{Id}$ and not something else.** Hence
$$\sum_{\beta\gamma}T_{k\beta\gamma}\lambda_\beta=\sum_{\beta\ne k}S_{k\beta}\lambda_\beta=(\hat S\lambda)_k=(S\lambda)_k-2\lambda_k,$$
so relation (B), $(\hat S\lambda)_k=-2\lambda_k$, is $(S\lambda)_k=0$. Screened at coordinate configurations for $n=4,5,6$ against every kernel vector, and at the icosahedral configuration for random $\lambda$.

**A consistency check worth recording.** Applying the same reduction with weight $1$ gives $\sum_{\beta\gamma}T_{k\beta\gamma}=\sum_{\beta\ne k}S_{k\beta}=2(n-2)$, which is relation (A). **So row 4 and relation (A) are the same identity read through the bridge**, and relations (A) and (B) are the weight-$1$ and weight-$\lambda_\beta$ rows of a single computation.

## Row 10, the upgrade

**CONFIRMED, and the brief's stated doubt does not arise.**

**What "relation (C) summed" gives.** Relation (C) at index $k$ is the diagonal of criticality, $(W^\#)_{kk}=\lambda_k(\theta-\lambda_k)$, which in the $T$-form is $\sum_{\beta\gamma}T_{k\beta\gamma}\lambda_\beta\lambda_\gamma=2\lambda_k(\theta-\lambda_k)$. Summing over $k$ and using total symmetry of $T$, $\sum_kT_{k\beta\gamma}=\lVert[\omega_\beta,\omega_\gamma]\rVert^2$, which the bridge sends to $S_{\beta\gamma}$ off the diagonal and to $0$ on it:
$$\sum_{k\beta\gamma}T_{k\beta\gamma}\lambda_\beta\lambda_\gamma=\lambda^{\mathsf T}S\lambda-2\lVert\lambda\rVert^2,\qquad 2\theta\sum_k\lambda_k-2\lVert\lambda\rVert^2=-2\lVert\lambda\rVert^2 ,$$
so $\lambda^{\mathsf T}S\lambda=0$. **Trace-freeness is exactly enough**, and it is needed only to kill the $\theta$ term. $\lVert\lambda\rVert^2=\lVert W\rVert^2$ cancels on both sides and is never used, so no normalisation of $W$ enters.

**The psd step is sound for a singular $S$ and needs no lemma at all.** $\lambda^{\mathsf T}S\lambda=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)=\mathop{\mathrm{tr}}(M^2)=\lVert M\rVert_F^2$. **The quadratic form is literally the squared Frobenius norm of the Ricci tensor**, so its vanishing is Ricci-flatness directly, and row 6 then returns $S\lambda=0$. The general fact is true anyway: for $S=B^{\mathsf T}B\succeq0$, $\lambda^{\mathsf T}S\lambda=\lVert B\lambda\rVert^2=0$ gives $B\lambda=0$ and hence $S\lambda=0$, with no invertibility used. **The brief's worry about a possibly singular $S$ is unfounded and no repair is needed.** Screened as an assertion that $\lambda^{\mathsf T}S\lambda=\mathop{\mathrm{tr}}(M^2)$ at $n=3$ through $8$.

**Hypotheses the upgrade consumes**, exactly: the eigenbasis is orthonormal and decomposable, which is what the bridge needs; $\mathop{\mathrm{tr}}W=0$; relation (C) at every index, which is criticality's diagonal; and positive semidefiniteness of $S$, which is free because $S$ is a Gram matrix. **It does NOT consume relation (B), completeness $\sum\Pi_\alpha=(n-1)\mathrm{Id}$, the first Bianchi identity, any normalisation of $W$, or any bound on $\theta$.** That is a real redundancy: on this locus the $N$ equations of (B) follow from the single scalar consequence of (C) plus the Gram structure.

**The one thing that can break it is the factor of two, and the brief does not flag it.** Relations (A), (B) and (C) are each **twice** the diagonal of the corresponding $\#$-identity, $2(I\#I)_{kk}=2(n-2)$, $2(W\#I)_{kk}=-2\lambda_k$ and $2(W\#W)_{kk}=2\lambda_k(\theta-\lambda_k)$, the factor coming from Hamilton's $\tfrac12$ against ordered slots. Drop it from (C) alone and the same summation returns
$$\lambda^{\mathsf T}S\lambda-2\lVert\lambda\rVert^2=-\lVert\lambda\rVert^2,\qquad\text{that is}\qquad \lambda^{\mathsf T}S\lambda=\lVert W\rVert^2\ne0,$$
and the row is false with no other error anywhere in it. **The row is safe only because (A) and (B) pin the same convention**, (A) reproducing row 4's $2(n-2)$ and (B) its $-2$, both of which were verified here independently of (C). A future edit that renormalises $T$ or $\#$ in one relation and not the others silently breaks this row and nothing else.

**One correction to the framing, not to the mathematics.** "A consequence of criticality's diagonal rather than a hypothesis beside it" is right inside the relaxation, where (A), (B), (C) are imposed relations on $T$ and $\lambda$. It is not a new fact about Weyl tensors, since Ricci-flatness is part of what $W\in\mathcal W_n$ means, and summed relation (C) is exactly $\mathop{\mathrm{tr}}(W^\#)=-\lVert W\rVert^2$, which is (B) paired against $W$. **The honest statement is that on the decomposable locus relation (B) is redundant given (C), trace-freeness and the Gram structure**, which is a statement about the relaxation's presentation. Stated that way it is strong and it is what row 10 should claim.

## Row 11, which off-diagonal families can bite

**PLAUSIBLE, with both of the brief's two halves corrected.**

**The (A) family is inert, and for a better reason than "a non-integral example satisfies it".** Its off-diagonal is $\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}=-\mathop{\mathrm{tr}}\big(\mathop{\mathrm{ad}}(\omega_\alpha)\mathop{\mathrm{ad}}(\omega_\beta)\big)$, the Killing form of $\mathfrak{so}(n)$, which is a multiple of $\langle\omega_\alpha,\omega_\beta\rangle$ and therefore zero at **every** orthonormal basis, decomposable or not, under no hypothesis whatever. It reads $0=0$ identically and cuts nothing. Screened as an assertion at coordinate bases and at the icosahedral basis, where it returned $2(n-2)\delta_{\alpha\beta}$ exactly.

**The (B) family is inert on the target locus, and the brief's justification is the weaker of the two available.** Its off-diagonal is the off-diagonal block of $W\#I=-W$, an identity at every Ricci-flat curvature operator satisfying the first Bianchi identity, hence at every Weyl tensor. Screened at coordinate configurations for $n=4,5,6$: at every Ricci-flat $\lambda$ the whole matrix identity holds, and at a non-Ricci-flat $\lambda$ the **diagonal** fails while the **off-diagonal still vanishes**, so the off-diagonal block carries nothing beyond what the diagonal already says.

**On the brief's logical question.** "Cannot force integrality" does follow from "is satisfied by a non-integral example", and the inference is valid, but for these two families it is the weaker ground. **They are identities**, satisfied at every configuration in their scope, so they cut nothing at all, and that is a stronger and more stable statement than exhibiting one survivor. Reserve the example argument for families that are not identities.

**The (C) family can carry information, but it is vacuous exactly where the argument wants to land.** Screened at the icosahedral configuration, its off-diagonal $\sum_{\gamma\delta}c_{\alpha\gamma\delta}c_{\beta\gamma\delta}\lambda_\gamma\lambda_\delta$ is nonzero at random $\lambda$, so the family is not an identity. **But on the coordinate locus it vanishes identically for every $\lambda$, critical or not**, screened at $n=4$ over twenty random weightings, which is the classical fact that a curvature operator diagonal in coordinate planes has $R^\#$ diagonal in the same basis. So its off-diagonal block is a condition that is automatically satisfied at the conclusion it is supposed to establish, and it is quadratic in the *signed* constants $c$ rather than in the $T$ the spectral machinery reads. **That is why the row's "can bite" should be read as "is the only one not already an identity", not as "carries spectral information".** PLAUSIBLE rather than CONFIRMED, because the row's positive half is an absence of an inertness proof rather than a demonstration of content.

## The question rows 6, 10 and 11 leave open, which I did not run

**Does any non-integral decomposable configuration have $\ker S\ne0$?** Row 10 delivers $S\lambda=0$, and row 6 says a nonzero Ricci-flat $W$ on this locus exists only where $S$ is singular. Every non-integral configuration I constructed at $n=4$ has $S$ **nonsingular**: the icosahedral one at $\mathop{\mathrm{rank}}S=6$, and every non-integral member of the family $\{e_1,e_2,e_3,Re_1,Re_2,Re_3\}$, $R\in SO(3)$, which is a tight frame for every $R$ and which passes through the coordinate configuration at $R=\mathrm{Id}$ with $\dim\ker S=2$ and jumps to $\mathop{\mathrm{rank}}S=6$ the moment $R$ moves off the identity. **Eight points of one family plus the icosahedron is a screen, not evidence**, and I record it as one.

**If the answer is yes, rows 10 and 6 close I74 outright** on the decomposable locus, with no need for row 11's off-diagonal families at all, and the out-of-scope fact "$\mathop{\mathrm{rank}}S\ge n$, equality exactly at the coordinate configurations" would strengthen to "$S$ is nonsingular off the integral locus". **If the answer is no**, the counterexample is a non-integral configuration carrying a nonzero Ricci-flat weighting, and row 11's third family becomes the only remaining instrument, at which point its vacuity on the coordinate locus is the obstacle to describe. **Deciding it is a census over the decomposable locus with no bound I can state in advance on where it looks, so I name it and stop** rather than open it under the standing analysis-only rule.

## Corrections owed to the record

1. **The brief's row 1 Lean citation is wrong.** [trace_instA_instB](../lean/HamiltonsCubic/Results/L201Statement.lean) and [frobSq_commutator_inst](../lean/HamiltonsCubic/Results/L201Statement.lean) type $\lVert[\Pi_\alpha,\Pi_\beta]\rVert_F^2=2t(1-t)$, not the bracket-trace bridge. The bridge is typed nowhere, at no instance.
2. **Row 1 should be recorded in its general form**, $\lVert[\omega_\alpha,\omega_\beta]\rVert^2=\mathop{\mathrm{tr}}(\Pi_\alpha\Pi_\beta)-2\langle\omega_\alpha,\omega_\beta\rangle^2$, with the orthogonal case as the corollary.
3. **The record's "three of the four terms vanish" is true only after orthogonality is used.** In principal position two vanish for free and the third needs $\gamma_2=0$.
4. **Row 3 holds when one argument is decomposable**, by $\lVert\mathop{\mathrm{ad}}(\omega)\rVert_{\mathrm{op}}=1$, with no orthogonality and no condition on the other argument.
5. **Row 10 should carry the factor-of-two warning** and should be stated as the redundancy of relation (B) given (C) on this locus.
6. **Row 10's stated doubt about singular $S$ should be struck**, and replaced by the identity $\lambda^{\mathsf T}S\lambda=\lVert\mathrm{Ric}(W)\rVert_F^2$, which makes the psd step unnecessary.
7. **Row 11's inertness arguments should rest on the two families being identities**, not on a non-integral survivor, and the row should say that the third family is vacuous on the coordinate locus.
8. **Row 6 is vacuous at $n=3$** and should carry $n\ge4$, where $\dim\ker S=\tfrac{n(n-3)}2$ at a coordinate configuration.
