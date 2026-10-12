# Reviewer r341, the pinned polytope at a fixed spectrum, C1–C6

| claim | verdict |
| --- | --- |
| **C1**, $\Pi(\lambda)$ is a polyhedron, $\theta^\ast(\lambda)$ an LP value, and every critical point at that spectrum obeys it | **CONFIRMED**, with three precisions: the max needs $\Pi\ne\varnothing$ and a boundedness argument (supplied below), and the proved pair cap $\sum_cT_{abc}\le2$ is a valid constraint that $\Pi$ omits |
| **C2**, $G$-stability, averaging, and the value-type reduction | **CONFIRMED** in every step attacked. The one soft spot is the *count*: the variables are the **realisable** class-multisets, which is $\binom{d+2}3$ only when every $m_i\ge3$. Step 4 says this; the corollary table below it does not, and that is where a real error enters |
| **C3**, the reduced system $(\mathrm A_i),(\mathrm B_i),(\mathrm C_i)$ | **CONFIRMED**, every coefficient, including the $(\nu_j+\nu_k)$ against the $2$. Verified independently at a spectrum I built from scratch (the $n=6$ balanced product), all six reduced equations exact |
| **C4**, the dual certificate | **CONFIRMED**, direction and sign conditions both. Two additions: strong duality makes the family **complete**, and $F_{ijk}$ is not written down in the derivation and is easy to get wrong |
| **C5**, scope and novelty | **CONFIRMED with a correction.** The reduction is new; but the record already holds ([post F40](../findings/fence-posts.md)) that the $\Pi$-bound *is* [Lemma L23](../results.md)'s formula at a two-eigenvalue spectrum, which the derivation does not credit and which turns out to be half of the $d=2$ answer |
| **C6**, the rank | **rank $=3d-2$ CONFIRMED and now PROVED** (the addendum's "no third" argument is not a proof; mine is), under $m_i\ge3$. **"So $\max\theta$ is a genuine maximisation, never forced" is REFUTED**: at $d=2$ with $m_1=2$ the feasible set is a **point** and $\theta$ is forced, and at $m_1=1$ the system is **infeasible at every $n\ge5$** |

**And one result that is not on the record.** The $d=2$ programme can be solved in closed form, and its two branches are $t_{112}\ge0$ and $t_{222}\ge0$. The first is the $\Pi$-bound; the second is new and reproduces [Lemma L23](../results.md)'s dimension cap $r\le n(n-2)/4$ from $T\ge0$ alone. Together they give $\theta\le\theta_0(n)$ at **every** two-eigenvalue spectrum, for every $n\ge5$, with no subalgebra hypothesis and no computation, closing Conjecture A on the whole two-eigenvalue stratum, which [graded-half.md](../findings/graded-half.md) records as *not* a theorem. Section 7.

---

## 0. What I checked first, and what it cost the brief

I rebuilt the three relations from the definitions in [conventions.md](../findings/conventions.md) before reading anything else, because C3 asks for an independent verification and the relations are the whole input.

**(A) is the Killing marginal**, basis-free: $\sum_{b,c}T_{abc}=\sum_b\lVert[v_a,v_b]\rVert^2=-\operatorname{tr}(\mathrm{ad}_{v_a}^2)=-(n-2)\operatorname{tr}(v_a^2)=2(n-2)$, using $B(X,Y)=(n-2)\operatorname{tr}(XY)$ and $\operatorname{tr}(v^2)=-2$ from [conventions.md](../findings/conventions.md).

**(B) is Ricci-flatness, not Bianchi**, and the brief and the derivation both leave this unsaid. Write $\Phi(W)(X,Y):=\operatorname{tr}(W\,\mathrm{ad}_X\mathrm{ad}_Y)$. Then $\sum_{b,c}\lambda_bT_{abc}=-\Phi(W)(v_a,v_a)$, so (B) says $\Phi(W)=2W$ as a quadratic form. $\Phi$ is an $O(n)$-equivariant endomorphism of $S^2(\Lambda^2\mathbb R^n)$, which for $n\ge5$ splits into the four pairwise inequivalent irreducibles $\Lambda^4\oplus\mathrm{Weyl}\oplus S^2_0\oplus\mathbb R$, so by Schur $\Phi$ is a scalar on the Weyl summand. The scalar is $2$: at a coordinate-diagonal Weyl tensor with vertex matrix $K$, $\sum_{b,c}\lambda_bT_{(12)bc}=\sum_{k\ne1,2}(K_{1k}+K_{2k})=-2K_{12}$ by the row-sum-zero condition defining $\mathcal D_n$. **This matters**, $\Phi(\mathrm{Id})(X,X)=-2(n-2)\lVert X\rVert^2$, so (B) fails badly off $\mathcal W_n$, and it is exactly what excludes the non-Ricci-flat two-eigenvalue operators that [bounds.md](../findings/bounds.md) records as having tripped two reviewers.

**(C) is criticality plus the $\tfrac12$ in $W^\#$**: $(W^\#)_{aa}=\tfrac12\sum_{b,c}T_{abc}\lambda_b\lambda_c$, and $Q(W)=\theta W$ gives $(W^\#)_{aa}=\lambda_a(\theta-\lambda_a)$.

To fix that $\tfrac12$ against the record's normalisations I rebuilt $S^{n/2}\times S^{n/2}$ by hand. With $n=2m$ the vertex matrix is $K_{ij}=m/(2m-1)$ inside a factor and $-(m-1)/(2m-1)$ across; $\lVert K\rVert_F^2=2m^2(m-1)/(2m-1)$; $P=\sum_{i<j}K_{ij}^3+\tfrac12\operatorname{tr}(K^3)=m^2(m-1)^2/(2m-1)$; and

$$\theta=\frac{P}{\lVert W\rVert^3}=\frac{\sqrt{(m-1)(2m-1)}}m=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

That is an independent reproduction of $\theta_0(n)$ and it pins every normalisation the rest of this report uses.

## 1. C1, CONFIRMED, with three precisions

Linearity is right and is the whole point: $T\ge0$ is a linear inequality; hollowness and total symmetry are linear equalities; (A) and (B) are linear in $T$ with constant right-hand sides; (C) is $\sum_{bc}\lambda_b\lambda_cT_{abc}-2\lambda_a\theta=-2\lambda_a^2$, linear in the pair. So $\Pi(\lambda)$ is a polyhedron in $(T,\theta)$.

**Precision 1, the max needs boundedness, and it holds.** $T$ is bounded: $T\ge0$ with row sum $2(n-2)$ forces $0\le T_{abc}\le2(n-2)$. Then (C) at any row with $\lambda_a\ne0$ (one exists, since $\lVert\lambda\rVert=1$), bounds $\theta$. So $\Pi$ is compact and the max is attained. Without this line "$\max$" is unjustified.

**Precision 2, $\theta^\ast$ is a sup over a possibly empty set.** $\Pi(\lambda)$ can be empty; section 6 exhibits a whole family of spectra where it is. The definition should read $\theta^\ast(\lambda)=\sup\{\dots\}=-\infty$ when infeasible. This is not pedantry: infeasibility is a **stronger** conclusion than a bound, and the derivation has no vocabulary for it.

**Precision 3, a proved constraint is missing.** [conventions.md](../findings/conventions.md) records the pair cap $\sum_cT_{abc}=\lVert[v_a,v_b]\rVert^2\le2$ as a standing fact. $\Pi$ omits it. Omitting it only raises $\theta^\ast$, so C1's inequality survives; but the reduction inherits the omission, and in reduced variables the cap is the $G$-invariant family $\sum_k\mu_k^{(ij)}t_{ijk}\le2$, linear and cheap. It should be named as available and unused.

The final clause (every $\theta$-critical point with spectrum $\lambda$ has $\theta\le\theta^\ast(\lambda)$), is correct, and correctly indifferent to which orthonormal eigenbasis is chosen in a degenerate eigenspace: every choice yields a feasible $T$.

## 2. C2, CONFIRMED, and the count is where the error is

I checked $G$-stability index by index rather than taking the derivation's word. For $g\in G$ and $(g\cdot T)_{abc}=T_{g^{-1}a,g^{-1}b,g^{-1}c}$: (A) re-indexes to row $g^{-1}a$ and every row has the same total; (B) needs $\lambda_{gb}=\lambda_b$ **and** $\lambda_{g^{-1}a}=\lambda_a$, both true because $g$ preserves classes; (C) needs the same two facts and leaves $\theta$ untouched. Nonnegativity, hollowness and total symmetry are permutation-invariant. So $\Pi$ is $G$-stable, $\theta$ is $G$-fixed, and the average of a maximiser is a $G$-invariant maximiser at the **same** $\theta$. Convexity is immediate from polyhedrality.

Transitivity holds in all three cases, including the two the brief singles out: $S_{m_i}$ is transitive on ordered pairs of distinct elements and on ordered triples of distinct elements. So $G$-orbits of distinct-index triples correspond exactly to class multisets, **the realisable ones**.

**The realisability caveat is not cosmetic.** A type $\{i,i,j\}$ exists only when $m_i\ge2$, a type $\{i,i,i\}$ only when $m_i\ge3$. The system is self-consistent about this: a non-realisable type carries coefficient $\mu_i(\mu_i-1)$ or $2\mu_i\mu_j$ with the vanishing factor in **every** row it could appear in, so it is a variable with no coefficient anywhere. The LP value is therefore unaffected, but the **dimension count is**, and [derive-sp1.md](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/derive-sp1.md) states the caveat in step 4 and then drops it in the corollary table and in the addendum's consequence. Section 6 shows what that costs.

## 3. C3, CONFIRMED, verified at a spectrum I constructed

The ordered-pair counts are right: excluding $a$ leaves $\mu_j=m_j-\delta_{ij}$ of class $j$, so $2\mu_j\mu_k$ ordered pairs for $j\ne k$ and $\mu_j(\mu_j-1)$ for $j=k$. The weights then follow mechanically, $1$ in (A$_i$); $\nu_j$ for one order and $\nu_k$ for the other in (B$_i$), whence $\mu_j\mu_k(\nu_j+\nu_k)$ where (A$_i$) and (C$_i$) carry the $2$; and $\nu_j\nu_k$ in both orders in (C$_i$). The brief's suspicion about that asymmetry is unfounded: $2\mu_j\mu_k\cdot\tfrac{\nu_j+\nu_k}2=\mu_j\mu_k(\nu_j+\nu_k)$ is the same statement.

**Independent verification, by hand, at $n=6$.** From the $S^3\times S^3$ vertex matrix above: two classes, $\nu_1=1/\sqrt{10}$ with $m_1=6$ (same-factor pairs), $\nu_2=-\tfrac23/\sqrt{10}$ with $m_2=9$ (cross pairs), $N=15$, $\theta=\sqrt{10}/3=\theta_0(6)$.

*The unreduced relations first.* $T_{abc}=1$ exactly on the triangles $\{(ij),(jk),(ik)\}$ and $0$ elsewhere. At $a=(12)$: (A) $=2\cdot4=8=2(n-2)$; (B) $=2\nu_1+6\nu_2=-2\nu_1$; (C) $=2\nu_1^2+6\nu_2^2=0.466\overline6=2\nu_1(\theta-\nu_1)$. At $a=(14)$: (A) $=8$; (B) $=4(\nu_1+\nu_2)=-2\nu_2$; (C) $=8\nu_1\nu_2=-0.5\overline3=2\nu_2(\theta-\nu_2)$. All six exact.

*The reduced system.* No triangle has type $\{1,1,2\}$ or $\{2,2,2\}$, two same-factor pairs among three vertices force all three vertices into one factor, and three mutually crossing pairs need three factors, so $t_{112}=t_{222}=0$, while $t_{111}=12/120=1/10$ (two triangles, one per factor) and $t_{122}=36/432=1/12$. Then

| row | (A$_i$) | (B$_i$) | (C$_i$) |
| --- | --- | --- | --- |
| $i=1$ ($\mu=(5,9)$) | $20\cdot\tfrac1{10}+72\cdot\tfrac1{12}=8$ | $20\nu_1\tfrac1{10}+72\nu_2\tfrac1{12}=-2\nu_1$ | $20\nu_1^2\tfrac1{10}+72\nu_2^2\tfrac1{12}=2\nu_1(\theta-\nu_1)$ |
| $i=2$ ($\mu=(6,8)$) | $96\cdot\tfrac1{12}=8$ | $48(\nu_1{+}\nu_2)\tfrac1{12}=-2\nu_2$ | $96\nu_1\nu_2\tfrac1{12}=2\nu_2(\theta-\nu_2)$ |

All six exact, at the recorded $\theta$. C3 is correct as written.

## 4. C4, CONFIRMED, and completed

Summing $\alpha_i(\mathrm A_i)+\beta_i(\mathrm B_i)+\gamma_i(\mathrm C_i)$ gives exactly the stated right-hand side. With $F_{ijk}\le0$ and $t\ge0$ the left side is $\le0$, so the right side is $\le0$; with $\sum_i\gamma_i\nu_i>0$ the division preserves the direction. **The inequality direction and both sign conditions are correct**, and there is correctly no sign condition on $\alpha,\beta,\gamma$ themselves, the underlying constraints being equalities.

**Addition 1, the family is complete.** The primal is $\max\{\theta:Mt+v\theta=w,\ t\ge0\}$ with $\theta$ free. Its dual is $\min\{y^{\mathsf T}w:M^{\mathsf T}y\ge0,\ v^{\mathsf T}y=1\}$, and $v^{\mathsf T}y=2\sum_i\gamma_i\nu_i$, so the normalisation $\sum\gamma_i\nu_i>0$ *is* the dual feasibility condition, and $F=-M^{\mathsf T}y\le0$ *is* dual feasibility. Since the primal is feasible-or-not and bounded (section 1), strong duality says the **best** such certificate equals $\theta^\ast(\lambda)$ exactly. Nothing is lost by restricting attention to certificates.

**Addition 2, $F_{ijk}$ is not written down and is easy to get wrong.** A class contributes **one** term per row it owns, regardless of its multiplicity inside the multiset, and $\mu$ is row-dependent:

$$F_{iii}=(m_i-1)(m_i-2)\big[\alpha_i+\beta_i\nu_i+\gamma_i\nu_i^2\big],$$
$$F_{iij}=(m_i-1)m_j\big[2\alpha_i+\beta_i(\nu_i+\nu_j)+2\gamma_i\nu_i\nu_j\big]+m_i(m_i-1)\big[\alpha_j+\beta_j\nu_i+\gamma_j\nu_i^2\big],$$

and for distinct $i,j,k$ the three-term analogue with $m_jm_k$, $m_im_k$, $m_im_j$. Checked: at $\alpha\equiv1,\beta=\gamma=0$ and the $n=6$ spectrum this gives $20\cdot\tfrac1{10}+168\cdot\tfrac1{12}=16=2d(n-2)$.

**One over-claim.** *"Every spectral bound on the record is such a certificate"* is unsupported as written. Strong duality makes every bound **provable from $\Pi(\lambda)$** a certificate; a bound whose proof consumes Jacobi, first Bianchi, or Lie-theoretic input about $E_+$ is outside the class by construction, and [post F42](../findings/fence-posts.md)'s restated rule turns on exactly that distinction. The sentence should read *"every bound the record proves from (A), (B), (C) and $T\ge0$"*.

## 5. C5, CONFIRMED, with one credit the derivation withholds from the record

I looked for the fixed-spectrum full system in [bounds.md](../findings/bounds.md), [fence-posts.md](../findings/fence-posts.md), [target.md](../findings/target.md), [routes.md](../routes.md) and [reviews/](.). The **reduction** (that the maximisation may be restricted without loss to value-type-constant $T$), is nowhere on the record, and the claim of novelty is right. The distinction from [post F10](../findings/fence-posts.md) (marginal LP, (A) alone, free spectrum) and from the withdrawn [post F42](../findings/fence-posts.md) (single-row evidence) is stated correctly.

**What the derivation under-credits.** [Post F40](../findings/fence-posts.md) already records that the $\dim E_+$ form of [Lemma L23](../results.md) and the $\Pi$-bound $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ are the same statement, and that the $\dim E_+$ form fails off the two-eigenvalue class. Section 7 shows this is precisely one of the two branches of the $d=2$ programme, so the record's own fence post supplies half the $d=2$ answer, and the derivation should say so.

**Two small record facts.** [REVIEW_r331.md](REVIEW_r331.md) says the screen was exact at **six** catalogued spectra; [fence-posts.md](../findings/fence-posts.md) and [bounds.md](../findings/bounds.md) both say **seven**, and [derive-sp1.md](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/derive-sp1.md) repeats seven. One of the three is wrong. And "over spectra with a kernel class the bound fails outright" should say the bound goes vacuous, an upper bound cannot fail.

## 6. C6, the rank, proved; and "never forced" refuted

### 6.1 The two dependencies, with the addendum's weights corrected

Both come from total symmetry of $T$ plus $\operatorname{tr}W=0$, and both are identities of *functionals*, right-hand sides included:

$$\textbf{D1}:\quad \sum_a\lambda_a(\mathrm A_a)=\sum_a(\mathrm B_a),\qquad\textbf{D2}:\quad \sum_a\lambda_a(\mathrm B_a)=\sum_a(\mathrm C_a),$$

reduced to $\sum_im_i\nu_i(\mathrm A_i)=\sum_im_i(\mathrm B_i)$ and $\sum_im_i\nu_i(\mathrm B_i)=\sum_im_i(\mathrm C_i)$. Both sides of D1 are the contraction $\sum_{abc}\lambda_aT_{abc}$, with constants $2(n-2)\sum\lambda_a=0$ and $-2\sum\lambda_a=0$; both sides of D2 are $\sum_{abc}\lambda_a\lambda_bT_{abc}$, with constants $-2\lVert\lambda\rVert^2$ on each, the $\theta$ term dying because $\sum_i m_i\nu_i=0$. **The addendum in [derive-sp1.md](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/derive-sp1.md) has this right; the coordinator's restatement does not**, it pairs "(B$_i$) against $m_i$" with "(C$_i$) against $m_i$", where D2 needs (B$_i$) against $m_i\nu_i$. Both dependencies annihilate the $\theta$ column, so neither can pin $\theta$.

### 6.2 There is no third, a proof, under $m_i\ge3$

The addendum's *"a further dependency would have to re-sum against a weight $\lambda_a^2$"* is not an argument: a left-null vector of the reduced matrix need not be a re-summation of one relation. Here is the proof.

Let $y=(y^A_i,y^B_i,y^C_i)$ be a left-null vector and set $\varphi_i(x):=y^A_i+y^B_ix+y^C_ix^2$, with polarisation $\psi_i(x,y)=y^A_i+y^B_i\tfrac{x+y}2+y^C_ixy$. Reading the coefficient of each type, $y$ is left-null iff

$$(\ast)\ \ (m_i-1)(m_i-2)\,\varphi_i(\nu_i)=0,\qquad(\ast\ast)\ \ 2(m_i-1)m_j\,\psi_i(\nu_i,\nu_j)+m_i(m_i-1)\,\varphi_j(\nu_i)=0,$$

together with the three-term condition on distinct triples. Assume every $m_i\ge3$. Then $(\ast)$ gives $\varphi_i(\nu_i)=0$. Using $\psi_i(x,y)=\tfrac12(\varphi_i(x)+\varphi_i(y))-\tfrac12y^C_i(x-y)^2$, condition $(\ast\ast)$ becomes $m_j\varphi_i(\nu_j)+m_i\varphi_j(\nu_i)=m_jy^C_i\delta_{ij}^2$ with $\delta_{ij}=\nu_i-\nu_j$. Subtracting the $(j,i)$ instance and dividing by $\delta_{ij}^2\ne0$ gives $m_jy^C_i=m_iy^C_j$, so $y^C_i=-\kappa m_i$ for a single constant $\kappa$. Writing $f_i:=\varphi_i/m_i$, the same relation reads $f_i(\nu_j)+f_j(\nu_i)=-\kappa\delta_{ij}^2$; substituting $f_i(x)=(x-\nu_i)\big(b_i-\kappa(x+\nu_i)\big)$ (forced by $f_i(\nu_i)=0$ and the leading coefficient), turns it into $(\nu_j-\nu_i)(b_i-b_j)=-\kappa\delta_{ij}^2$, i.e. $b_i-\kappa\nu_i=\beta$ for a single constant $\beta$. Hence

$$\varphi_i(x)=m_i(x-\nu_i)(\beta-\kappa x),$$

a **two-parameter** family. $(\beta,\kappa)=(1,0)$ is D1 and $(0,-1)$ is D2, so the left-null space is exactly $\operatorname{span}\{D1,D2\}$ and the three-term condition is automatically satisfied. $\square$

**Consequence.** With every $m_i\ge3$, $\operatorname{rank}[M\mid v]=3d-2$ and, since both dependencies kill the $\theta$ column, $v$ lies in the column span of $M$, so $\theta$ is **non-constant** on the feasible affine set, whose dimension is $V+1-(3d-2)$ with $V$ the number of realisable types. At $m_i\ge3$, $V=\binom{d+2}3$ and the derivation's table is right: $d=2\to1$, $d=3\to4$, $d=4\to11$.

### 6.3 "Never forced" is REFUTED, the small-multiplicity cases

The clause *"So $\max\theta$ is a genuine maximisation, never forced"* fails in both available ways, both at $d=2$, and both because $V<\binom{d+2}3$.

**$m_1=2$: $\theta$ is forced.** The type $\{1,1,1\}$ is absent, so $V=3$ and the unknown count is $4$, not $5$. Condition $(\ast)$ for class $1$ is lost, and the left-null space of $M$ grows to dimension $3$; parametrising $\varphi_2(x)=(x-\nu_2)(px+q)$ and solving $(\ast\ast)$ for both orders leaves $(y^C_1,p,q)$ free, so some left-null vector has $y^{\mathsf T}v=-2\sum_iy^C_i\nu_i\ne0$ and $v\notin\operatorname{col}(M)$. Then $\operatorname{rank}[M\mid v]=4=$ the unknown count: **the equalities alone determine $(t,\theta)$ uniquely.** Note the rank is still $3d-2$; it is the variable count that moved.

**$m_1=1$: the system is infeasible at every $n\ge5$.** Let $a$ be the unique index of class $1$. Every $b\ne a$ has $\lambda_b=\nu_2$, so (B) at row $a$ reads $\nu_2\sum_{b,c}T_{abc}=2(n-2)\nu_2=-2\nu_1$, giving $\nu_1=-(n-2)\nu_2$. Tracelessness gives $\nu_1=-(N-1)\nu_2$. These agree only if $N=n-1$, false for every $n\ge3$. **So $\Pi(\lambda)=\varnothing$**, and since only (A) and (B) were used (both valid at every $W\in\mathcal W_n$, critical or not), this is a theorem about Weyl tensors:

> **No $W\in\mathcal W_n$, $n\ge5$, has a $\Lambda^2$-spectrum with exactly two distinct values one of which is simple.**

The correct blanket statement is therefore: *$\theta$ is a genuine maximisation whenever every class has multiplicity at least $3$; at $d=2$ with a doubled class it is forced by the equalities, and with a simple class the spectrum is impossible.*

### 6.4 One more place the corollary over-reaches

The corollary *"why the fixed-spectrum LP is exact at degenerate spectra and loose at generic ones"* uses $\binom{d+2}3-3d+3$ at a generic critical point where $d\approx N$ and every $m_i=1$. There **no** type $\{i,i,j\}$ or $\{i,i,i\}$ is realisable, so $V=\binom d3$, not $\binom{d+2}3$: at $n=6$, $455$ rather than $680$. The mechanism (variables cubic in $d$ against constraints linear in $d$), survives intact and is a good explanation; the formula quoted for it does not apply at the spectra it is quoted about.

## 7. What the derivation missed: the $d=2$ programme, solved

The derivation says the $d=2$ feasible set is a segment whose endpoints are "Theorem A's two branches". Both endpoints are computable in closed form, and one of them is not on the record.

**Set-up.** $d=2$, $\nu_1=u>0>\nu_2=-w$, $m_1=r=\dim E_+$, $m_2=N-r$, $\delta=u+w$. Tracelessness $ru=(N-r)w$ and $\lVert\lambda\rVert=1$ give $ru\delta=(N-r)w\delta=1$, hence

$$uw=\frac1N,\qquad \delta^2=\frac N{r(N-r)},\qquad u=\sqrt{\frac{N-r}{rN}},\qquad w=\sqrt{\frac r{N(N-r)}}.$$

**Solving row 1.** Writing $x=(m_1{-}1)(m_1{-}2)t_{111}$, $y=2(m_1{-}1)m_2t_{112}$, $z=m_2(m_2{-}1)t_{122}$, the three row-1 equations are $x+y+z=2(n-2)$, $u\,x+\tfrac{u-w}2y-w\,z=-2u$, $u^2x-uw\,y+w^2z=2u(\theta-u)$, whose $3\times3$ matrix has determinant $\tfrac12(\nu_2-\nu_1)^3\ne0$. Eliminating gives

$$y=\frac{4u}{\delta^2}\big[(n-1)w-\theta\big],\qquad z=\frac{2u}{\delta^2}\big[(n-1)u+\theta\big].$$

**Solving row 2**, with $X=m_1(m_1{-}1)t_{112}$, $Y=2m_1(m_2{-}1)t_{122}$, $Z=(m_2{-}1)(m_2{-}2)t_{222}=2(n-2)-X-Y$:

$$X=\frac{2w}{\delta^2}\big[(n-1)w-\theta\big],\qquad Y=\frac{4w}{\delta^2}\big[(n-1)u+\theta\big].$$

The two readings of $t_{112}$ agree iff $ru=(N-r)w$, and so do the two of $t_{122}$, tracelessness recovered twice as a consistency check.

**The two branches.** $z,Y>0$ always. The two decreasing coordinates give the whole answer:

- **branch (i), $t_{112}\ge0$:** $\ \theta\le(n-1)w=\dfrac2n\sqrt{\dfrac{rN}{N-r}}$, the $\Pi$-bound, which [post F40](../findings/fence-posts.md) already identifies with [Lemma L23](../results.md)'s $\dim E_+$ formula. Increasing in $r$.
- **branch (ii), $t_{222}\ge0$:** $\ \theta\le\dfrac{(n-2)\delta^2}w-(n-1)(w+2u)=(n-2)Nu^3-2u-\dfrac1{Nu}$. Strictly increasing in $u$ (its $u$-derivative is $3(n-2)Nu^2-2+1/(Nu^2)\ge2\sqrt{3(n-2)}-2>0$ for $n\ge5$), hence strictly **decreasing** in $r$.

For $m_2\le2$ branch (ii) still holds: the coefficient $(m_2-1)(m_2-2)$ vanishes, so row-2's (A) forces $Z=0$, which implies $Z\ge0$.

**The crossing.** Setting them equal, with $v=Nu^2$: $(n-2)v^2-2v-n=0$, so $v=n/(n-2)$, i.e. $(N-r)/r=n/(n-2)$, i.e.

$$r=\frac{n(n-2)}4,\qquad\text{where both branches equal }\ \frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

A decreasing curve meets an increasing one once, so the minimum of the two is maximised exactly there.

> **Theorem (r341).** *For every $n\ge5$ and every spectrum with exactly two distinct eigenvalues, $\theta^\ast(\lambda)\le\theta_0(n)$. Hence every $\theta$-critical $W\in\mathcal W_n$ whose $\Lambda^2$-spectrum takes two values satisfies $\theta\le\theta_0(n)$, with equality only at $r=\dim E_+=n(n-2)/4$, impossible at odd $n$, so the inequality is strict there.*

**Why this is worth recording.** [graded-half.md](../findings/graded-half.md) states plainly that *"$\theta\le\theta_0(n)$ is the conjecture, not a theorem, [Lemma L23](../results.md) proves it only on the subalgebra family, where $W_{\mathfrak h}$ is built from a subalgebra"*, and [post F40](../findings/fence-posts.md) records that the $\dim E_+$ extension of Lemma L23 is **false** in general, padded $W_{\mathbb{CP}^2}$ being the witness. Both are consistent with the theorem above: padded $W_{\mathbb{CP}^2}$ has a kernel and three distinct eigenvalues, so it is outside $d=2$; and a two-eigenvalue traceless $W$ has $\ker W=0$ automatically, since $\nu_2=0$ would force $\nu_1=0$. What the argument supplies that Lemma L23 needed a subalgebra for is **branch (ii)**: the dimension cap $r\le n(n-2)/4$ comes out of $t_{222}\ge0$, that is out of $T\ge0$, with no sum of squares, no Lie theory, and no hypothesis that $E_+$ is closed under bracket.

**And it shows the two-eigenvalue stratum is where the pinned class is exactly strong enough.** The record's standing worry, [T9](../plan.md), the pinned class overshooting to $1.34$–$1.39$ at $n=6$ with the spectrum free, is a statement about maximising over spectra. Restricted to $d=2$, the same class is **sharp**: it returns $\theta_0(n)$ and no more, and the balanced product's own $T$ attains it, since $t_{112}=t_{222}=0$ there puts it at the unique point where both branches bind.

**Checks I ran on the theorem.** At $n=6$, $r=6$: branch (i) $=5w=1.054093$ and branch (ii) $=1.897367-0.632456-0.210819=1.054093$, both $=\theta_0(6)$, and $Y=8$, $X=Z=0$ reproduce the hand-computed $t$ of section 3 exactly. At $n=10$, $r=10$ ($\mathfrak{so}(5)$ adjoint, a genuine two-eigenvalue critical point): branch (i) $=0.717137$, matching Lemma L23's exact value there, branch (ii) $=7.17$, so (i) binds and the bound is attained. At $n=8$, $r=8$ ($\mathfrak{su}(3)$ bi-invariant): branch (i) $=0.836660$, the recorded $0.8367$. At $n=12$, $r=31$: branch (ii) gives $1.0992$, **below** the $1.238486$ that $\mathfrak{so}(5)\oplus\mathfrak{so}(7)$'s two-eigenvalue operator carries, no contradiction, because [bounds.md](../findings/bounds.md) records that operator as having Ricci residual $0.288$, so it is not in $\mathcal W_{12}$ and relation (B), which is Ricci-flatness, is exactly what excludes it. That the theorem is tight enough to notice is the point of the last check.

## 8. What is owed

- **The theorem of section 7 needs a Gate 2 of its own**, and it is a positive claim, so it should not be folded in on one reviewer. The whole argument is four displayed lines of elimination plus a monotonicity check; it is checkable by hand in an hour.
- **Branch (ii) should be checked against $d=3$** before anyone reads it as a route: nothing here says the $d=3$ polytope, which is four-dimensional, has a comparable closed form.
- **The pair cap $\sum_cT_{abc}\le2$ is unused.** It is proved, it is $G$-invariant, and it tightens $\Pi$. If the $d=3$ programme is opened, it should be in from the start.
