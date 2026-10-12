# REVIEW r864: I77, the triangle-type linear programme

**Reviewer r864, 2026-09-10. The brief was cold**: I read [brief-r864-r865.md](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/brief-r864-r865.md) and, of the record, only [L202TriangleLP.lean](../lean/HamiltonsCubic/Results/L202TriangleLP.lean). **Disclosure**: while locating that file I also read the I77 row of [lean/INDEX.md](../lean/INDEX.md), which states the file's own "what it leaves out". My list in section 14 was read off the file itself and agrees with that row. **No numerical work beyond screening was done and every value below is exact.** Every algebraic identity in this report was derived by hand first. Exact rational arithmetic (Python `fractions`, no floats in any comparison) was then used to screen the hand results, and one finite exact enumeration of the triangles of two explicit graphs on twelve vertices was run for the same purpose. Nothing here rests on a search, a sweep or a float. **Log**: [agent_logs/review-r864-trianglelp.log](../agent_logs/review-r864-trianglelp.log).

## Claim table

| # | Claim as quoted from the record | Verdict |
|---|---|---|
| 1 | $\theta=\sum_\alpha\lambda_\alpha^3+\tfrac12T(\lambda,\lambda,\lambda)$ at unit norm, with the $\tfrac12$ | **CONFIRMED** |
| 2 | $\sum_jt_j=2N(n-2)=M$ at every orthonormal basis | **CONFIRMED** |
| 3 | $\sum_jj\,t_j=6(n-2)a=J$ at every orthonormal basis | **CONFIRMED** (identity right, the stated counting reason is garbled) |
| 4 | "The coefficients alternate in sign … so the optimum puts all mass on $j\in\{1,3\}$" | **GAP**: the sign pattern alone does not force it. The conclusion is right exactly when $s\ge N/3$, by a concave-hull argument the block does not give |
| 5 | "feasible exactly when $N/3\le s\le N$" | **CONFIRMED** for the vertex, with $s=N$ degenerate, so the live range is $N/3\le s\le N-1$ |
| 6 | The closed form $\bigl[(N-2s)+(n-2)(N-s)(4s-N)/(2s)\bigr]/\sqrt{sN(N-s)}$ | **CONFIRMED** |
| 7 | $\operatorname{tr}(W^3)=(N-2s)/\sqrt{sN(N-s)}$ | **CONFIRMED** |
| 8 | Balanced product at $n=12$: $t_3=240$, $t_1=1080$, $t_0=t_2=0$, and these are the vertex | **CONFIRMED** |
| 9 | $330/\sqrt{71280}=\theta_0(12)$ and $6/\sqrt{48}=\theta_0(4)$ | **CONFIRMED** exactly |
| 10 | "at $n=4$ the programme CLOSES the two-eigenvalue decomposable case exactly" | **OVERSTATED**: $s=1$ is outside the stated feasibility range and the programme's own optimum there is $12/\sqrt{30}=2.19$. The claim becomes true only once Ricci-flatness is used, which this block explicitly disclaims |
| 11 | $s=31$ gives $331.42/\sqrt{71610}=1.2385$, above $\theta_0(12)$ | **CONFIRMED** exactly: the numerator is $10274/31$ and the excess is strict |
| 12 | "So the programme alone leaves a $0.2\%$ gap at $n=12$, against the record's standing factor of $2.47$" | **REFUTED**. Read over the $s$ the programme itself admits, the bound at $n=12$ is $\ge 3.8536$ at $s=6$ and $10.7484$ at $s=1$, both worse than the standing $3.0509$. The $0.2\%$ figure is the maximum over $s\ge N/3$ only |
| 13 | "no configuration is known to carry" $\mu:\nu=35:(-31)$ | **STRENGTHENED**: $s=31$ is impossible on **every** coordinate configuration at $n=12$, because Ricci-flatness forces the positive level set to be a regular graph of degree $2s/n=31/6\notin\mathbb Z$ |
| 14 | "No cap is used, only the marginal, nonnegativity and the two-valued structure, so the bound holds wherever those do" | **CONFIRMED** as an accounting of the hypotheses, and it is the source of finding 12: with so little used, small $s$ cannot be excluded |
| 15 | "For the two-eigenvalue case L105 is still better" | **CONFIRMED**, with no contradiction between them anywhere |
| 16 | Three eigenvalues: three marginal equalities $\sum_{j,k}t_{ijk}=2(n-2)a_i$ | **CONFIRMED** |
| 17 | Three eigenvalues: six cap inequalities $\sum_kt_{ijk}\le a_ia_j$, $\sum_kt_{iik}\le a_i(a_i-1)$ | **CONFIRMED**, hollowness correction included |
| 18 | "At two eigenvalues the vertex was forced without them, which is why the cap never appeared there" | **REFUTED**: the cap is violated by the programme's own optimal vertex for every $s<2n-3$, which is exactly the range the block leaves uncovered. At $n=12$, $s=6$ the cap drops the bound from $3.8536$ to $\sqrt{33/20}=1.28452$ |
| 19 | "The closed form and both checks are machine-checked and gap-free" in the Lean file | **CONFIRMED**: builds, and all four declarations rest on `propext`, `Classical.choice`, `Quot.sound` alone |
| 20 | New, mine, needing its own review: the missing constraint is not a realisability constraint on $s$ but three **exact equalities** from Ricci-flatness plus the trace bridge, and they close $n=12$ at $\theta_0(12)$ | **DERIVED**, screened against two explicit configurations |

## Summary

**The algebra of the programme is correct and the Lean file is sound, and the headline is not: as a bound over the $s$ the programme actually admits, it is $3.8536$ at $n=12$ rather than $1.2385$, so it does not improve the record's standing $3.0509$. The $1.2385$ is the maximum over $s\ge N/3$ alone. Adding Ricci-flatness and the trace bridge turns the discarded pair cap into three exact equalities, which cut the feasible set at fixed $s$ down to a segment, and their maximum over all admissible $s$ at $n=12$ is exactly $\theta_0(12)$.**

## Conventions, quoted from the brief

- "$\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector. The inner product is $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$."
- "$u\wedge v=vu^{\mathsf T}-uv^{\mathsf T}$. At orthonormal $u,v$ this is a unit bivector and $(u\wedge v)(u\wedge v)^{\mathsf T}=uu^{\mathsf T}+vv^{\mathsf T}=\Pi_P$, the orthogonal projection onto $P=\mathrm{span}\{u,v\}$."
- "$\mathcal W_n$ is the space of algebraic Weyl tensors … $P(W)=\langle W,W^2+W^\#\rangle$, $\theta=P(W)/\lVert W\rVert^3$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$."
- "$\sqrt{3/2}=1.224745$ and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$."
- Operator norm: given 13, "the record's norm is $\lVert W\rVert^2=\sum_\alpha\lambda_\alpha^2$", so the pairing on operators is the plain Frobenius one and $\langle W,A\rangle=\sum_k\lambda_kA_{kk}$ in $W$'s eigenbasis.
- Throughout: $N=\binom n2$, $s=a=\lvert A\rvert$, $u=N-s$, $v=s$, $k=(sN(N-s))^{-1/2}$, $M=2N(n-2)$, $J=6(n-2)s$, $\bar\jmath=J/M=3s/N$.

## Hypothesis inventory

What the two-eigenvalue programme, as written, actually uses:

| Ingredient | Where from | Used for |
|---|---|---|
| $W$ symmetric on $\Lambda^2\mathbb R^n$, diagonal in an orthonormal basis $\omega_1,\dots,\omega_N$ | setup | the whole calculation is in that basis |
| $\lVert W\rVert=1$ | normalisation | $\theta=P(W)$, and the scale $k$ |
| $\operatorname{tr}W=0$ with exactly two eigenvalues | given 18 | $\mu:\nu=(N-s):(-s)$ |
| $(W^\#)_{kk}=\tfrac12\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}$ | given 14 | the objective |
| $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ | given 15, L153 | both linear constraints |
| $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2\ge0$, totally symmetric, hollow | given 12, given 14 | $t_j\ge0$ and the symmetrisation in constraint 2 |

Not used, and each absence matters: criticality (so the bound holds off the critical set too), first Bianchi, Ricci-flatness, decomposability, the pair cap, L201, the scalar bound $\Xi$. The block says as much itself, and section 12 below is what that costs.

## 1. The objective, and the factor $\tfrac12$

$P(W)=\langle W,W^2+W^\#\rangle=\operatorname{tr}(W^3)+\langle W,W^\#\rangle$. In $W$'s orthonormal eigenbasis $\operatorname{tr}(W^3)=\sum_\alpha\lambda_\alpha^3$, and because the pairing is Frobenius and $W$ is diagonal there, $\langle W,W^\#\rangle=\sum_k\lambda_k(W^\#)_{kk}$. Given 14 supplies $(W^\#)_{kk}=\tfrac12\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}$, so

$$P(W)=\sum_\alpha\lambda_\alpha^3+\tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=\sum_\alpha\lambda_\alpha^3+\tfrac12T(\lambda,\lambda,\lambda),$$

and $\theta=P(W)$ at $\lVert W\rVert=1$. **CONFIRMED.**

**The $\tfrac12$ pinned independently of the block.** Relation (C) of given 12 gives, at a critical point, $\sum_{\beta\gamma}\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=2\lambda_k(\theta-\lambda_k)$ at every $k$. Contract with $\lambda_k$:

$$\tfrac12T(\lambda,\lambda,\lambda)=\tfrac12\sum_k\lambda_k\cdot2\lambda_k(\theta-\lambda_k)=\theta\lVert W\rVert^2-\sum_k\lambda_k^3=\theta-\sum_k\lambda_k^3 .$$

Substituting into the display returns $P(W)=\theta$, which is the definition of $\theta$ at unit norm. With any other constant $c$ in place of $\tfrac12$ the same contraction gives $P=\sum\lambda^3+2c(\theta-\sum\lambda^3)$, equal to $\theta$ for all admissible spectra only at $c=\tfrac12$. So the constant is pinned by relation (C) and given 14 independently of each other, and the two agree.

**What a wrong constant would do.** The bound is $\operatorname{tr}(W^3)+2c\cdot(\text{vertex value})$ with the vertex value positive in the whole feasibility range, so $c=1$ would roughly double the second term: at $n=12$, $s=30$ it would give $(6+648)/\sqrt{71280}=2.4497$ instead of $\theta_0(12)$, and the exact agreement with $\theta_0$ at the balanced product would be destroyed. That agreement is therefore itself a check on the constant, and it passes.

## 2. The first constraint

$T$ has no constraint tying different first indices, so summing the marginal is immediate:

$$\sum_jt_j=\sum_{\alpha\beta\gamma}T_{\alpha\beta\gamma}=\sum_\alpha\Bigl(\sum_{\beta\gamma}T_{\alpha\beta\gamma}\Bigr)=\sum_\alpha 2(n-2)=2N(n-2)=M .$$

The partition of the ordered triples by $j=\#\{\text{indices in }A\}$ is a partition of all $N^3$ of them, so the left side is the total. **CONFIRMED.** At $n=12$: $M=1320$.

## 3. The second constraint, and the scepticism it was owed

The identity is right. The stated reason ("counting, for a triple with $j$ indices in $A$, the $j$ positions at which the first index lies in $A$") is not a statement one can follow: a triple has one first index, not $j$ of them. Here is the argument that works, and it needs the total symmetry of $T$, which the block does not invoke at this step. Write $\mathbb 1=\mathbb 1_A$. For an ordered triple, $j=\mathbb 1(\alpha)+\mathbb 1(\beta)+\mathbb 1(\gamma)$, so

$$\sum_jj\,t_j=\sum_{\alpha\beta\gamma}\bigl(\mathbb 1(\alpha)+\mathbb 1(\beta)+\mathbb 1(\gamma)\bigr)T_{\alpha\beta\gamma}=3\sum_{\alpha\in A}\sum_{\beta\gamma}T_{\alpha\beta\gamma}=3\cdot s\cdot2(n-2)=6(n-2)s=J,$$

the middle step being the total symmetry of $T$ (the three terms are equal) followed by the marginal. **CONFIRMED**, with the caveat that as written the justification is not a proof and a reader cannot repair it without noticing that total symmetry is what carries it.

**Independent check on the balanced product's own counts.** At $n=12$, $s=30$ the record's counts are $t_1=1080$, $t_3=240$, $t_0=t_2=0$. Then $\sum_jt_j=1320=M$ and $\sum_jj\,t_j=1080+720=1800=6\cdot10\cdot30=J$. Both hold on the nose.

## 4. The vertex

**The signs are right.** With $c_j=\tfrac12k^3(N-s)^j(-s)^{3-j}$ and $0<s<N$, the sign of $c_j$ is the sign of $(-s)^{3-j}$: negative at $j=0,2$ and positive at $j=1,3$. **CONFIRMED.**

**The inference from the signs is not valid.** A linear programme with two equality constraints can be forced to load a negative-coefficient variable: the mean $\bar\jmath=J/M=3s/N$ must be matched, and if $\bar\jmath<1$ no measure supported on $\{1,3\}$ can match it. So the sign pattern alone cannot force the support. The correct argument is a moment argument. Every feasible $t$ is $M$ times a probability vector $p$ on $\{0,1,2,3\}$ with mean $\bar\jmath$, and $\sum_jc_jp_j\le\hat c(\bar\jmath)$ where $\hat c$ is the concave hull of the four points $(j,c_j)$, with equality attained on the hull's supporting segment. So the optimum is the pair of hull vertices straddling $\bar\jmath$. Dropping the positive factor $\tfrac12k^3$ and writing $u=N-s$, $v=s$, so that $c_j\propto u^j(-v)^{3-j}$:

- $j=2$ is never on the hull: $c_2=-u^2v<0<u(u^2+v^2)/2=\tfrac12(c_1+c_3)$, so $(2,c_2)$ lies strictly below the chord from $(1,c_1)$ to $(3,c_3)$ at every $u,v>0$. **The block's conclusion that no mass sits at $j=2$ is therefore right, and for this reason rather than for the sign of $c_2$.**
- $(1,c_1)$ lies above the chord from $(0,c_0)$ to $(3,c_3)$ exactly when $3uv^2>u^3-2v^3$, that is when $u^3-3uv^2-2v^3=(u-2v)(u+v)^2<0$, that is when $u<2v$, that is when $s>N/3$.

And $\bar\jmath\ge1$ is the same condition, $3s/N\ge1$. So in the range where the $\{1,3\}$ vertex is feasible it is also optimal, and outside it the hull over $[0,\bar\jmath]$ is the chord $0$ to $3$ and the optimum is the $\{0,3\}$ vertex. **The two coincide, so the block's answer is right where it is stated and its argument is a gap rather than an error.**

**The vertex and its range.** $t_1+t_3=M$, $t_1+3t_3=J$ give $t_3=(J-M)/2=(n-2)(3s-N)$ and $t_1=(3M-J)/2=3(n-2)(N-s)$, nonnegative exactly when $M\le J\le3M$, that is $N/3\le s\le N$. **CONFIRMED**, and $s=N$ is degenerate (section 13), so the live range is $N/3\le s\le N-1$.

**Could a different vertex beat it? Below $N/3$, yes, and this is finding 12.** The $\{0,3\}$ vertex is $t_0=2(n-2)(N-s)$, $t_3=2(n-2)s$, and its value collapses to a one-line closed form:

$$\tfrac12k^3\bigl[t_0(-s^3)+t_3(N-s)^3\bigr]=k^3(n-2)s(N-s)\bigl[(N-s)^2-s^2\bigr]=k(n-2)(N-2s),$$

using $k^3sN(N-s)=k$, so that

$$\boxed{\ \theta\le\frac{(n-1)(N-2s)}{\sqrt{sN(N-s)}}\quad\text{for }s\le N/3.\ }$$

At $n=12$ this is $10.7484$ at $s=1$, $3.8536$ at $s=6$, $2.2340$ at $s=12$, $1.3819$ at $s=18$ and $0.9574$ at $s=22=N/3$, where it agrees with the other branch, as it must. At $n=4$ it is $12/\sqrt{30}=2.1909$ at $s=1$.

## 5. The closed form

At the vertex the cubic term is $\tfrac12k^3\bigl[t_1uv^2+t_3u^3\bigr]$ with $t_1=3(n-2)u$ and $t_3=(n-2)(2v-u)$, the latter because $3s-N=3v-(u+v)=2v-u$. So

$$\tfrac12k^3(n-2)u^2\bigl[3v^2+u(2v-u)\bigr]=\tfrac12k^3(n-2)u^2\bigl[3v^2+2uv-u^2\bigr]=\tfrac12k^3(n-2)u^2(3v-u)(u+v),$$

since $3v^2+2uv-u^2=-(u-3v)(u+v)$. Now $u+v=N$ and $3v-u=3s-(N-s)=4s-N$, and $k^3=k/(sN(N-s))$, so the term is

$$\frac{k(n-2)(N-s)^2N(4s-N)}{2sN(N-s)}=k\cdot\frac{(n-2)(N-s)(4s-N)}{2s},$$

which with section 5's trace term gives the block's display exactly. **CONFIRMED.** The one place to slip is $3s-N=2v-u$ and not $3v-u$: taking the latter gives $4710/11$ in place of $330$ at the balanced product, so the check of section 7 catches it.

**The trace term.** With $\mu=k(N-s)$ on $A$ and $\nu=-ks$ off it, $\sum\lambda^2=k^2\bigl[s(N-s)^2+(N-s)s^2\bigr]=k^2sN(N-s)$, so unit norm is $k=(sN(N-s))^{-1/2}$, and

$$\operatorname{tr}(W^3)=k^3\bigl[s(N-s)^3-(N-s)s^3\bigr]=k^3s(N-s)N(N-2s)=k(N-2s)=\frac{N-2s}{\sqrt{sN(N-s)}} .$$

**CONFIRMED.**

## 6. The balanced product's counts

For the coordinate basis $\varphi_{ab}$, $T_{\alpha\beta\gamma}=1$ exactly when the three edges $\alpha,\beta,\gamma$ of $K_n$ form a triangle, and $0$ otherwise. This follows from $[\varphi_{12},\varphi_{23}]=-\varphi_{13}$, which I checked from the brief's own convention: with $A=E_{21}-E_{12}$ and $B=E_{32}-E_{23}$, $AB=E_{13}$ and $BA=E_{31}$, so $[A,B]=E_{13}-E_{31}=-\varphi_{13}$, a unit vector, giving $c^2=1$. Disjoint edge pairs commute and edges sharing a vertex produce the third edge only. The marginal is then a count: $\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$, two orderings for each of the $n-2$ third vertices, which agrees with given 15 and is an independent check on the identification.

At $S^6\times S^6$ the eigenbasis is the coordinate one for a frame adapted to $\mathbb R^{12}=\mathbb R^6\oplus\mathbb R^6$, $A$ is the set of within-factor edges, $s=2\binom62=30$ and $A^c$ is the edge set of $K_{6,6}$, $36$ of them. Given 16's values $6/11$ and $-5/11$ are in the ratio $36:(-30)=(N-s):(-s)$, so the spectrum is exactly the pinned one, and the trace is $30\cdot\frac6{11}-36\cdot\frac5{11}=0$. The triangle types of $K_{12}$ under this splitting:

- three vertices in one factor: all three edges within-factor, $j=3$, and there are $2\binom63=40$ such triangles, each contributing $3!=6$ ordered triples, so $t_3=240$. **CONFIRMED.**
- two vertices in one factor and one in the other: one within-factor edge and two cross edges, $j=1$, and there are $2\binom62\cdot6=180$, so $t_1=1080$. **CONFIRMED.**
- $t_2=0$: if two edges of a triangle are within-factor they share a vertex, so all three vertices lie in one factor and the third edge is within-factor too. A triangle with exactly two within-factor edges does not exist. **CONFIRMED.**
- $t_0=0$: three cross edges would be a triangle in the bipartite $K_{6,6}$, which has no odd cycle. **CONFIRMED.**

Total $40+180=220=\binom{12}3$, so no type is missed. And $t_1=1080=3(n-2)(N-s)=3\cdot10\cdot36$, $t_3=240=(n-2)(3s-N)=10\cdot24$: **the counts are the vertex.** Screened by exact enumeration of the $220$ triangles of $K_{12}$ against the edge set $K_6\sqcup K_6$, which returns $(t_0,t_1,t_2,t_3)=(0,1080,0,240)$.

Because the counts are the vertex, the LP is **tight** at the balanced product, so the check of section 7 is a genuine identity between the bound and an attained value, not a coincidence of two independently computed numbers.

## 7. The two exact checks

At $n=12$, $N=66$, $s=30$: numerator $=6+\dfrac{10\cdot36\cdot54}{60}=6+324=330$, denominator $\sqrt{30\cdot66\cdot36}=\sqrt{71280}$, and

$$\frac{330^2}{71280}=\frac{108900}{71280}=\frac{55}{36}=\frac{2\cdot11\cdot10}{144}=\theta_0(12)^2 .$$

At $n=4$, $N=6$, $s=2$: numerator $=2+\dfrac{2\cdot4\cdot2}{4}=6$, denominator $\sqrt{48}$, and $36/48=3/4=2\cdot3\cdot2/16=\theta_0(4)^2$. **Both CONFIRMED exactly**, and the block's squared forms $6^2/48=3/4$ and $330^2/71280=220/144$ are the same two statements.

## 8. The $n=4$ closure claim

The enumeration the block gives, $s=2,3,4$, is:

| $s$ | numerator | bound |
|---|---|---|
| 2 | $2+4=6$ | $6/\sqrt{48}=\sqrt3/2=\theta_0(4)$ |
| 3 | $0+6=6$ | $6/\sqrt{54}=2/\sqrt6=0.816497$ |
| 4 | $-2+5=3$ | $3/\sqrt{48}=0.433013$ |
| 5 | $-4+\tfrac{14}5=-\tfrac65$ | $-1.2/\sqrt{30}=-0.219089$ |

so the maximum over $s\ge2$ is at $s=2$ and equals $\theta_0(4)$. **CONFIRMED as far as it goes, and the claim to have closed the case is OVERSTATED**: $s=1$ is admissible for every hypothesis the block lists, lies outside the feasibility range, and the programme's own optimum there is the $\{0,3\}$ vertex with value $12/\sqrt{30}=2.1909$, which is more than twice $\theta_0(4)$ and above the conjectured maximum $\sqrt{3/2}$. The stated closed form is not an upper bound there either: it evaluates to $-6/\sqrt{30}<0$ while the LP maximum is positive, which is the signature of an infeasible vertex being substituted.

**What repairs it, and it is not in the block.** Ricci-flatness plus the trace bridge give $s\ge n/2$ (section 16), which at $n=4$ is exactly $s\ge2$. So the block's enumeration is complete for a reason the block disclaims one line earlier when it says no cap is used. Under Ricci-flatness the sharpened programme of section 16 also shows $s=3$ is infeasible at $n=4$ and $s=4$ carries $\theta<0$, so the case really does close, at $s=2$ and $\theta_0(4)$, on the stronger hypotheses.

## 9. The $s=31$ excess, and whether $s=31$ exists

**The value.** At $n=12$, $s=31$: $(n-2)(N-s)(4s-N)/(2s)=10\cdot35\cdot58/62=10150/31$, so the numerator is $4+10150/31=10274/31=331.419\ldots$ and the bound is $\dfrac{10274/31}{\sqrt{71610}}$. **CONFIRMED**, matching the block's $331.42/\sqrt{71610}=1.2385$. The excess over $\theta_0(12)$ is strict, and exactly so: comparing squares, $\dfrac{10274^2}{31^2\cdot71610}$ against $\dfrac{55}{36}$ cross-multiplies to $105555076\cdot36=3799982736$ against $55\cdot68817210=3784946550$, a positive difference of $15036186$. So the record's "two parts in a thousand" is real and not a rounding artefact.

**Realisability. On no coordinate configuration.** Let $A$ be the positive level set, $\Theta_A=\sum_{\alpha\in A}\Pi_\alpha$. Given 2's Ricci-flatness reads $\mu\Theta_A+\nu\Theta_{A^c}=0$, and given 1 gives $\Theta_A+\Theta_{A^c}=(n-1)\mathrm{Id}$, so $(\mu-\nu)\Theta_A=-(n-1)\nu\,\mathrm{Id}$ and with the pinned ratio

$$\Theta_A=\frac{(n-1)s}{N}\,\mathrm{Id}=\frac{2s}{n}\,\mathrm{Id}.$$

The trace of this is $2s$, as given 1 demands, so there is no obstruction at the level of traces. For a coordinate configuration, however, $\Pi_\alpha$ is a coordinate $2$-plane projection and $\Theta_A=\mathrm{diag}(\deg_1,\dots,\deg_n)$ for the graph $A\subseteq K_n$. So **a two-valued Ricci-flat weighting on a coordinate configuration requires $A$ to be a regular graph of degree $d=2s/n$**, hence $s=nd/2$. At $n=12$ that is $s\in\{6,12,\dots,60\}$, and $s=31$ is not among them: $31/6$ is not an integer. The balanced product is the case $d=5$, $A=K_6\sqcup K_6$, and $s=30$. **So the excess vertex needs a genuinely non-coordinate decomposable basis**, and by given 9 (L201) such a basis must have some pair with $\operatorname{tr}(\Pi_\alpha\Pi_\beta)\in(0,1)$. Given 4 shows non-coordinate decomposable bases exist at $n=4$, and that Ricci-flatness on that family collapses back to a coordinate-diagonal operator, which is weak evidence in the same direction and nothing more.

**And it does not matter, because $s=31$ is bounded well below $\theta_0(12)$ by section 16.** The sharpened programme gives $\theta\le\dfrac{9119/31}{\sqrt{71610}}=1.09926$ at $s=31$, on any configuration, coordinate or not. So the vertex the record could not exclude is excluded, and the route is a constraint rather than a realisability census.

## 10. Is it an upper bound at all

Yes, in the range where the vertex is feasible, and the relaxation direction is right. The chain has three links. Fix $s$, and the spectrum is pinned by trace-freeness and unit norm, so the objective is an affine functional of $(t_0,t_1,t_2,t_3)$ with fixed coefficients. The true $t$-vector of any configuration with that $s$ is feasible for the programme, because both equalities hold at every orthonormal basis (sections 2 and 3) and $t_j\ge0$ holds because $T$ is a square. Therefore $\theta=\text{objective}(t^{\text{true}})\le\max_{\text{feasible}}\text{objective}=\text{vertex value}$, and maximising over a superset can only raise the maximum. **CONFIRMED.**

No step needs a discarded constraint. The objective identity of section 1 holds at any $W$ diagonal in the basis, the spectrum pinning needs only $\operatorname{tr}W=0$ and two values, and the marginal holds at every orthonormal basis of $\mathfrak{so}(n)$ with no decomposability. Two consequences the block does not draw:

- **Criticality is not used**, so the bound is really a statement about every unit-norm two-valued trace-free symmetric operator on $\Lambda^2\mathbb R^n$, in the stated $s$ range.
- **Decomposability is not used either**, so the phrase "of the decomposable locus" in the quoted bound is decoration. That is exactly why the bound cannot beat L105, which is the same generality with a better conclusion.

The failure is not of direction but of coverage: the maximum over $s$ has to run over every $s$ a configuration could have, and the programme's own admissible set includes $s<N/3$, where its optimum is the other vertex. **This is finding 12 in the table and it is the review's central finding.** At $n=12$, taking Ricci-flatness on board only to the extent of $s\ge n/2=6$, the programme's bound is $\max\bigl(3.8536,\ 1.2385\bigr)=3.8536$, worse than the record's standing $3.0509$. Without Ricci-flatness, $s=1$ is admissible and the bound is $10.7484$.

## 11. Against L105

**L105 is better on its own ground and there is no contradiction.** L105 (given 17) gives $\theta\le\theta_0(n)$ at every critical point whose whole spectrum takes two values, with no decomposability. The programme gives a larger number at $s=31$, $n=12$ and a smaller one at most other $s$, and both are upper bounds, so nothing collides: two valid upper bounds may be incomparable. The one way a contradiction could arise is the programme's bound falling **below** a value actually attained. The place to look is where the programme is smallest and configurations are known, and the balanced product is exactly that test: the programme's bound at $s=30$, $n=12$ equals the attained $\theta_0(12)$, with equality, so the margin is zero and the test is passed at the tightest available point. At $n=4$ the two-eigenvalue bound is $\sqrt3/2=0.866$, well below the conjectured maximum $\sqrt{3/2}=1.224745$, and no contradiction arises because $W_{\mathbb{CP}^2}$ is not two-valued: given 5 makes its $\Lambda^2$ spectrum $(2c,-c,-c,0,0,0)$, three values. **CONFIRMED**, and worth recording that the two-eigenvalue case at $n=4$ is $29\%$ below the true maximum there, so closing it closes little.

## 12. The three-eigenvalue setup

**The three marginal equalities. CONFIRMED.** With $t_{ijk}$ the sum of $T$ over ordered triples whose first, second and third indices lie in $A_i,A_j,A_k$, summing over ordered $(j,k)$ gives $\sum_{j,k}t_{ijk}=\sum_{\alpha\in A_i}\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)a_i$. Their sum over $i$ is $2(n-2)N=M$, as the block says. The ten types are the multisets of size three from three level sets, and the objective's sum over ordered $(i,j,k)$ carries the multiplicities, which is consistent as long as the $t_{ijk}$ are read positionally. The block's "symmetric in $(i,j,k)$" is right and the reader has to keep the positional reading to avoid double counting.

**The six cap inequalities. CONFIRMED, hollowness included.** $\sum_kt_{ijk}=\sum_{\alpha\in A_i,\beta\in A_j}\sum_\gamma T_{\alpha\beta\gamma}=\sum_{\alpha\in A_i,\beta\in A_j}S_{\alpha\beta}$ with $S_{\alpha\beta}=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$ by Parseval. For $i\ne j$ the level sets are disjoint, so all $a_ia_j$ ordered pairs have $\alpha\ne\beta$ and the bridge cap $S_{\alpha\beta}\le1$ gives $\sum_kt_{ijk}\le a_ia_j$. For $i=j$ the $a_i$ diagonal pairs contribute $S_{\alpha\alpha}=0$, leaving $a_i(a_i-1)$ ordered distinct pairs, so $\sum_kt_{iik}\le a_i(a_i-1)$. Three off-diagonal and three diagonal, six in all, and each is half the general cap of $2$. All correct.

**"At two eigenvalues the vertex was forced without them, which is why the cap never appeared there." REFUTED.** The cap is slack at the vertex only for large $s$. In the two-eigenvalue language the same computation gives $t_3\le s(s-1)$, and the $\{0,3\}$ vertex that the programme itself selects for $s<N/3$ has $t_3=2(n-2)s$, so it violates the cap whenever $2(n-2)s>s(s-1)$, that is for every $s<2n-3$. At $n=12$ that is $s\le20$, which contains the whole of the range the block leaves uncovered. So the cap does work at two eigenvalues, in precisely the place the argument fails. Adding it changes the numbers materially. Solving the capped programme by hand at three admissible $s$ at $n=12$, each optimum confirmed by its reduced costs and then screened by exact vertex enumeration:

| $s$ | uncapped bound | capped optimum $t$ | capped bound |
|---|---|---|---|
| 6 | $3.85357$ | $(1020,270,0,30)$ | $198/\sqrt{23760}=\sqrt{33/20}=1.28452$ |
| 12 | $2.23400$ | $(864,324,0,132)$ | $297/\sqrt{42768}=\sqrt{33}/4=1.43614$ |
| 18 | $1.38193$ | $(852,162,0,306)$ | $(1221/4)/\sqrt{57024}=1.27828$ |
| 30 | $1.23603$ | cap slack | $1.23603$ |

So even with the cap the two-eigenvalue programme does not reach $\theta_0(12)$: its worst admissible $s$ is $12$, at $\sqrt{33}/4$, which is $16\%$ high, not $0.2\%$. What does close it is stronger than the cap, and it is in section 16.

**On the three-eigenvalue prospect.** The shape the block describes is right, and the same criticism applies in advance: a bound over ten variables at fixed spectrum is only a bound once the maximisation over spectra covers every admissible $(a_i,\mu_i)$, including the small-$a_1$ corners where the objective's coefficients are large. The two-eigenvalue instance shows the corners are where the programme is weakest, so the promised vertex enumeration should be organised around them rather than around the balanced case.

## 13. Degenerate cases and the kernel

- **$s=0$ and $s=N$.** Trace-freeness with one eigenvalue forces $W=0$, which fails unit norm, and $k=(sN(N-s))^{-1/2}$ is undefined at both. The stated feasibility range includes $s=N$, so the range is loose at its top end by one point. The correct live range for the vertex is $N/3\le s\le N-1$.
- **$s$ outside the range.** Covered in sections 4 and 8: the stated closed form is not an upper bound below $N/3$, it can be negative there, and the programme's true optimum is the other branch. The block flags the feasibility range and then, in the sentence that carries the headline, reasons as if the range were all of $s$.
- **A zero eigenvalue.** Given 18 rules it out on the decomposable locus at two eigenvalues, and it is also incompatible with the pinning: $\mu=k(N-s)$ and $\nu=-ks$ vanish only at $s=N$ and $s=0$. If a kernel were admitted the spectrum would take three values and the two-eigenvalue programme would not apply. Given 2 confirms the kernel contributes nothing to Ricci-flatness, so the three-value programme is where a kernel belongs, as one level set with $\mu_i=0$, which kills every $t_{ijk}$ touching it in the objective while leaving its marginal equality in force.
- **Equal level sets.** At $s=N/3$ the vertex degenerates to $t_1=M$ alone, and the closed form still holds since $t_3=0$. At $n=12$ that is $s=22$, and the two branches agree there at $0.95743$, which is a check on both.

## 14. The Lean file

**It builds and it is clean.** `lake build HamiltonsCubic.Results.L202TriangleLP` completed successfully, and `#print axioms` on all four theorems returns `[propext, Classical.choice, Quot.sound]`. No `sorryAx` and no `Lean.ofReduceBool`, so nothing there rests on a `sorry` or on `native_decide`.

**Each statement says what the prose says.**

- [lpNumerator](../lean/HamiltonsCubic/Results/L202TriangleLP.lean) is the prose numerator $(N-2s)+(n-2)(N-s)(4s-N)/(2s)$, verbatim.
- `lp_vertex_closed_form` is the section 5 identity with $k$ factored out: its left side is $\bigl[s^2(N-s)t_1+(N-s)^3t_3\bigr]/2$ divided by $sN(N-s)$ at $t_1=3(n-2)(N-s)$ and $t_3=(n-2)(3s-N)$, which is $\tfrac12k^3\bigl[t_1uv^2+t_3u^3\bigr]$ with the factor $k$ removed, and its right side is the closed form's second term. Correct, and the hypotheses $s\ne0$, $N\ne0$, $N-s\ne0$ are exactly what `field_simp` needs.
- `lp_bound_sq_n4` and `lp_bound_sq_n12` are the section 7 checks, in squared form, against $\theta_0(n)^2=2(n-1)(n-2)/n^2$ written out at $n=4$ and $n=12$. Both denominators are $sN(N-s)$ at the right $s$. Correct.
- `lp_gap_n12` is the strict inequality between the squared bounds at $s=30$ and $s=31$, which is the section 9 cross-multiplication. Correct.

**What the file does not type**, and the list is longer than the two items its docstring names:

1. The linear programme: no feasible set, no $t_j$, no nonnegativity, no marginal, no $M$ or $J$.
2. That the substituted $(t_1,t_3)$ is the **optimum**. The concave-hull step of section 4 is nowhere, and neither is the sign pattern.
3. The feasibility range. `lpNumerator` is a function of three real arguments with no constraint relating them, and it is negative at, for instance, $n=4$, $N=6$, $s=1$. Nothing in the file distinguishes the range where the expression bounds anything from the range where it does not.
4. $\theta$, $W$, $P$, $\mathcal W_n$, decomposability, Ricci-flatness. **No object of the programme appears anywhere in the file.** The four theorems are identities and one inequality between real numbers, and $\theta_0(n)^2$ appears only as the literal $2(n-1)(n-2)/n^2$ with $n$ substituted.
5. $\operatorname{tr}(W^3)=(N-2s)/\sqrt{sN(N-s)}$. The term $(N-2s)$ enters `lpNumerator` as a literal.
6. The balanced product's counts. Neither $240$ nor $1080$ occurs in the file, so the $n=12$ check tests the closed form at $s=30$ and not the claim that the product's own counts are the vertex, which is the check the block says matters.
7. That $N=\binom n2$. `lpNumerator 12 66 30` passes $66$ as data, so a typo in $N$ would be invisible to the file and visible only to the reader.

So the machine-checked content is the algebra of section 5 and the arithmetic of sections 7 and 9. Everything this review found wrong is in the untyped part, which is consistent rather than reassuring: **the file's soundness is not evidence for the claim, because the claim's load-bearing steps are the ones it declines to state.** The block's sentence "the closed form and both checks are machine-checked and gap-free" is accurate and its scope is easy to over-read.

## 15. What would break it, and what I did to look

**The object: a two-eigenvalue configuration with $s<N/3$.** It breaks the headline rather than the algebra, because the programme's own optimum there is the $\{0,3\}$ vertex and its value exceeds the record's standing bound at $n=12$. I did not have to find one to make the point: the bound is a maximum over $s$, and the record's own hypothesis list admits every $s\in[1,N-1]$, so the burden is on the claim. Still, I looked for what constrains $s$, using only the givens:

- Ricci-flatness forces $\Theta_A=\frac{2s}{n}\mathrm{Id}$ (section 9). Taking Frobenius norms and using given 8, $\sum_{\alpha\ne\beta\in A}\operatorname{tr}(\Pi_\alpha\Pi_\beta)=\frac{4s^2}n-2s\ge0$, so $s\ge n/2$, and the same on $A^c$ gives $s\le N-n/2$. At $n=12$ this leaves $6\le s\le60$, so $s=6$ survives and the headline does not.
- On coordinate configurations $s$ is a multiple of $n/2$ (section 9), which at $n=12$ leaves $s\in\{6,12,\dots,60\}$ and still admits $s=6$.

**The exhibited configurations.** Two coordinate configurations at $n=12$ carry closed-form counts I could compute by hand and screen exactly: the balanced product ($A=K_6\sqcup K_6$, $s=30$, $t=(0,1080,0,240)$, $\theta=\theta_0(12)$) and the four disjoint triangles ($A=4C_3$, $s=12$, $t=(648,648,0,24)$, $\theta=132/\sqrt{42768}=0.63828$), together with the twelve-cycle ($A=C_{12}$, $s=12$, $t=(672,576,72,0)$, $\theta=0.24822$). All three are honest algebraic Weyl tensors: trace-free by construction, Ricci-flat because the graph is regular, and first Bianchi automatically because every basis element is decomposable, so $\omega_\alpha\wedge\omega_\alpha=0$ and given 6's sum vanishes term by term. The second of these is the object that makes section 16's identities checkable at a second, unbalanced $s$.

**What I could not do under this footing.** Deciding whether a non-coordinate decomposable orthonormal basis of $\Lambda^2\mathbb R^{12}$ with $\Theta_A=\frac{31}6\mathrm{Id}$ exists is a search, and it is not needed: section 16 bounds $s=31$ at $1.09926$ without it.

## 16. The repair, which is new work and needs its own review

**The constraint the block says is missing is not a realisability constraint on $s$. It is three exact equalities, and they come from Ricci-flatness plus given 8.** Write $S_{\alpha\beta}=\sum_\gamma T_{\alpha\beta\gamma}=\lVert[\omega_\alpha,\omega_\beta]\rVert^2$, which given 8 identifies with $\operatorname{tr}(\Pi_\alpha\Pi_\beta)$ on the decomposable locus, and recall $\Theta_A=\frac{2s}n\mathrm{Id}$ and $\Theta_{A^c}=\frac{2(N-s)}n\mathrm{Id}$ from section 9. Summing $S$ over each block of ordered pairs and splitting the third index by whether it lies in $A$:

$$\sum_{\alpha,\beta\in A}S_{\alpha\beta}=t_3+\tfrac13t_2,\qquad\sum_{\alpha,\beta\notin A}S_{\alpha\beta}=t_0+\tfrac13t_1,\qquad\sum_{\alpha\in A,\beta\notin A}S_{\alpha\beta}=\tfrac13t_2+\tfrac13t_1,$$

the factors $\tfrac13$ because $t_1$ and $t_2$ count all three positions of the odd index while each block fixes it. The left sides are traces of products of the $\Theta$'s, less the diagonal $\operatorname{tr}(\Pi_\alpha^2)=2$ where the block is square, so

$$\text{(E1)}\ \ 3t_3+t_2=\frac{12s^2}n-6s,\qquad\text{(E2)}\ \ 3t_0+t_1=\frac{12(N-s)^2}n-6(N-s),\qquad\text{(E3)}\ \ t_1+t_2=\frac{12s(N-s)}n .$$

These are equalities, not caps, and they are half of the record's programme's constraints made exact. Their consequences:

1. **They subsume the record's second constraint**: (E1) $+$ (E3) is $t_1+2t_2+3t_3=\frac{12s^2+12sN-12s^2}{n}-6s=\frac{12sN}n-6s=6(n-2)s=J$, using $N=\frac{n(n-1)}2$. So $J$ is not new information once the three are in hand.
2. **With $M$ they leave one degree of freedom.** Parameterising by $\tau=t_2\ge0$,
$$t_1=\frac{12(N-s)s}n-\tau,\qquad t_3=\frac{4s^2}n-2s-\frac\tau3,\qquad t_0=\frac{4(N-s)(N-2s)}n-2(N-s)+\frac\tau3,$$
and $\sum_jt_j=\frac{4N^2}n-2N=2N(n-2)=M$ identically, so $M$ is implied too. **The feasible set at fixed $s$ is a segment, not a polytope with four vertices.**
3. **$t_3\ge0$ at $\tau=0$ forces $s\ge n/2$, and $t_0\ge0$ on $A^c$ forces $s\le N-n/2$**, recovering section 15's range from the same identities.
4. **The objective is strictly decreasing in $\tau$**, at the constant rate
$$\frac{d}{d\tau}\Bigl(\tfrac12k^3\sum_jt_jc_j\Bigr)=\tfrac12k^3\Bigl[\tfrac13c_0-c_1+c_2-\tfrac13c_3\Bigr]=-\tfrac16k^3(u+v)^3=-\tfrac16k^3N^3<0,$$
with $c_j=u^j(-v)^{3-j}$. So the bound sits at the least feasible $\tau$, which is $0$ when $s\le n(n-2)/4$ and $\tau_{\min}=\frac{6(N-s)\bigl(n-2(N-2s)\bigr)}n$ beyond that, where $t_0=0$.
5. **The two branches in closed form.** At $\tau=0$ every term collapses:
$$\theta\ \le\ \frac2n\sqrt{\frac{sN}{N-s}}\qquad\Bigl(\frac n2\le s\le\frac{n(n-2)}4\Bigr),$$
strictly increasing in $s$, and at the right endpoint $s=\frac{n(n-2)}4$ it is exactly
$$\frac2n\sqrt{\frac{n(n-2)N/4}{N-n(n-2)/4}}=\frac2n\sqrt{\frac{n^2(n-1)(n-2)/8}{n^2/4}}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$
Beyond the endpoint, with $t_0=0$,
$$\theta\ \le\ \frac{\dfrac{(n-2)(N-s)^2}s-2(N-s)-s}{\sqrt{sN(N-s)}},$$
which agrees with the first branch at the endpoint and falls away from it.
6. **At $n=12$ this closes the case.** The endpoint is $s=\frac{12\cdot10}4=30$, the balanced product, where both branches give $330/\sqrt{71280}=\theta_0(12)$. Branch one is increasing on $6\le s\le30$, so its maximum is there. On $30\le s\le60$ the numerator $g(s)=\frac{10(66-s)^2}s-132+s$ has $g'(s)=1-\frac{10(66-s)(66+s)}{s^2}<0$ for $s^2<3960$, so $g$ is strictly decreasing on the whole range, and $\sqrt{sN(N-s)}$ increases up to $s=33$, which handles $30\le s\le33$, and for $s\ge36$ the bound is at most $g(36)/\min_{[36,60]}\sqrt{sN(N-s)}=154/154.14<1$, with $s=34,35$ checked individually at $0.75821$ and $0.66357$. So

$$\theta\le\theta_0(12)\ \text{ at every two-valued, unit-norm, Ricci-flat }W\text{ with a decomposable orthonormal eigenbasis at }n=12,$$

with equality forcing $s=30$ and $t=(0,1080,0,240)$, the balanced product's own counts. In particular $s=31$ gives $\frac{9119/31}{\sqrt{71610}}=1.09926$, and the record's excess vertex is gone. At $n=4$ the same system makes $s=1,3,5$ infeasible, leaves $s=2$ at $\sqrt3/2=\theta_0(4)$ and $s=4$ at $-\sqrt3/2$, so the case closes there too.

**Hypotheses of the repair**, all from the brief's givens: given 1 for $\Theta$, given 2 for Ricci-flatness, given 8 for the bridge $S_{\alpha\beta}=\operatorname{tr}(\Pi_\alpha\Pi_\beta)$, given 14 for the objective, given 15 for Parseval, given 18 for the pinned spectrum. It therefore assumes more than the block's version, which is the price of the conclusion. **It does not use criticality**, so within the two-eigenvalue decomposable class it is stronger than L105 in conclusion at $n=12$ (equality only at the balanced counts) and weaker in generality (L105 needs no decomposability).

**Screening, reported as a screen.** Exact rational arithmetic confirmed: (E1), (E2), (E3) at all three exhibited configurations, including $C_{12}$, whose counts $(672,576,72,0)$ are exactly the $\tau=72$ point of the segment at $s=12$ while $4C_3$'s $(648,648,0,24)$ are its $\tau=0$ point, which is a two-point check that the segment is right and that the $\tau$-monotonicity has the sign claimed; the feasible range $6\le s\le60$ at $n=12$; branch one's closed form against the segment's value at every $s$ in it; the branch values quoted above. **None of this is evidence for the repair. The derivations above are, and they should be reviewed independently before anything is recorded.**

## Verdict

**The programme's mathematics is correct and its headline is not.** Every algebraic step the block takes is right, once the vertex argument is replaced by the one that works, and the Lean file is sound over the fragment it types. The bound at $s=31$, $n=12$ is exactly $\frac{10274/31}{\sqrt{71610}}$ and its excess over $\theta_0(12)$ is real. But the quoted claim, "the programme alone leaves a $0.2\%$ gap at $n=12$, against the record's standing factor of $2.47$", **is false**: over the level-set sizes the programme's own hypotheses admit, its bound at $n=12$ is $3.8536$ at $s=6$ and $10.7484$ at $s=1$, so the programme as stated does not improve the standing bound at all. The $0.2\%$ is the maximum over $s\ge N/3$, a restriction the block states as a feasibility remark and then reasons past. Two further claims fail: the $n=4$ closure holds only once Ricci-flatness is imported, and "the cap never appeared at two eigenvalues" is wrong for every $s<2n-3$, which is exactly the uncovered range.

**Recommended disposition.** The I77 block should not be recorded as a bound on $\theta$ at $n=12$. What it does establish, and what is worth keeping, is the method: at fixed $s$, $\theta$ is an affine functional of the triple-type counts under constraints from L153, and the balanced product sits at a vertex of the relaxation, which is why the relaxation is exact there. The way forward is section 16 rather than a realisability census for $s=31$: Ricci-flatness and the trace bridge turn the discarded cap into three equalities, the feasible set at fixed $s$ becomes a segment, and the maximum over $s$ is $\theta_0(n)$ attained only at $s=n(n-2)/4$. That derivation is mine, it is new to this review, and it is owed an independent check before it enters the record.
