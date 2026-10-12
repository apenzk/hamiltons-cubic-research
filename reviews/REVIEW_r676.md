# REVIEW r676, Observation L144: the closed form and the structural claim are right, the imprimitive half is missing two qualifiers, and the primitive half is *provable*

**Review number: r676.** Reviewer B of an independent pair on identical briefs; r675 was worked concurrently and neither report, log, nor any coordination was seen. Target: [Observation L144](../findings/diagonal-half.md), line 523 of [diagonal-half.md](../findings/diagonal-half.md). Log: [agent_logs/audit-L144-b.log](../agent_logs/audit-L144-b.log).

> **VERDICT: GAP, and the gap runs in the block's favour.** The closed form is **CONFIRMED** by cold derivation, including its absolute value, which is exactly the repair that [L96](../findings/diagonal-half.md) failed to make. "Every strongly regular graph is a diagonal critical point" is **CONFIRMED** and is a full-sphere statement, not a locus-relative one. The imprimitive half is **CONFIRMED as an inequality and GAPPED as a maximiser statement**: "maximised uniquely at $g=n/2$" omits that $g$ ranges over divisors of $n$ with $g\le n/2$, that $g=n/2$ therefore needs $n$ **even**, and that "uniquely" holds only up to complementation. *This is the same omission a companion audit refuted [L96](../findings/diagonal-half.md) for today, and the qualifier is already written out 150 lines above L144 in this same file.* The primitive half's self-grade is **honest but pessimistic**: §4 below proves $\theta<\tfrac12$ for **every** primitive strongly regular graph, uniformly, with no census, so the Observation can become a Lemma. The provenance note is **FALSE**: at the moment of migration the record held a second copy in [routes.md](../routes.md), and that copy is still there, still unhedged.

**On the analysis-only rule.** No search, sweep, census or falsifier hunt was run, and the screened range was not extended. One screen is reported in §4, seconds of compute on tuples constructed here to test an inequality proved by hand first; it is reported as a screen and is evidence for nothing positive.

---

## Readings adopted, stated before anything is derived

Quoted from [conventions.md](../findings/conventions.md), which is where every one of these lives:

- **Norm.** $\lVert W\rVert=1$ in the half-trace $\Lambda^2$ pairing, under which $\{\varphi_{ab}\}_{a<b}$ is orthonormal; on the diagonal locus this is $\operatorname{tr}M^2=\sum_{a\ne b}M_{ab}^2=2$, the sum over **ordered** pairs.
- **$\theta$.** $P(W)/\lVert W\rVert^3$, and $Q(W)=\theta W$ at a critical point. **$\theta$ is odd**: $\pm M$ are both critical and $\theta\mapsto-\theta$.
- **$\theta_0(n)$.** The closed form $\theta_0^2=2(n-1)(n-2)/n^2$ **and nothing more**, equal to the balanced-product value **at even $n$ only**. I use it only at even $n$ and say so at each use.
- **The vertex matrix.** $M=K$ symmetric, hollow, $M\mathbf1=0$ (Ricci-flatness), $\operatorname{tr}M^2=2$; the $\Lambda^2$ spectrum is the multiset of **entries** of $M$, not its eigenvalues.
- **Criticality on the locus**, from this file's own boxed criterion: $M^{\circ2}+M^2=\theta M+\operatorname{diag}(s)$, $s_i=\sum_jM_{ij}^2$, whose only content is the off-diagonal equation $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$.
- **"The band."** *Not tabled in [conventions.md](../findings/conventions.md), and the record uses it in two inequivalent senses*, see §5. I read L144's "the band" as [I18](../plan.md)'s and [I5](../plan.md)'s, namely $\theta\ge\sqrt{3/2}$ at $n\ge12$, because that is the only reading under which "except the balanced product" is not vacuous.

**Graph parameters.** $\Gamma=\mathrm{srg}(n,k,\lambda,\mu)$ with adjacency $A$, complement adjacency $\bar A=J-I-A$, $w:=n-1-k$, and eigenvalues $k>r\ge0>s$ with $r,s$ the roots of $x^2-(\lambda-\mu)x-(k-\mu)$. I write $s=-m$ and $S:=m-1$ throughout §4.

---

## 1. The closed form, derived cold, CONFIRMED, absolute value included

Put $M=a\big(A-t\bar A\big)$, the only shape available if the entries are to take one value on edges and one on non-edges.

**The normalisation is fixed by the record's own two constraints and nothing else.** $M\mathbf1=0$ reads $ak-atw=0$, so $t=k/w$. Then, over ordered pairs,
$$\operatorname{tr}M^2=a^2\big(nk+nw t^2\big)=a^2nk\frac{w+k}{w}=\frac{a^2nk(n-1)}{w}=2\ \Longrightarrow\ a=\sqrt{\frac{2w}{nk(n-1)}} .$$
**No DGK convention enters.** The block's hedge *"pinned from criticality alone"* is therefore substantially right and verbally loose: criticality is scale-covariant ($tM$ is critical at $t\theta$), so what pins $a$ is the **unit-norm constraint**, and criticality then pins $\theta$. Nothing is transcribed either way.

With $b=a(1+t)$, $c=at$ and $A^2=(k-\mu)I+(\lambda-\mu)A+\mu J$,
$$M^2=\big[b^2(k-\mu)+c^2\big]I+\big[b^2(\lambda-\mu)+2bc\big]A+\big[b^2\mu+c^2(n-2)-2bck\big]J,$$
which is line 460's display with $a$ factored out. Writing $\alpha,\beta$ for the $A$- and $J$-coefficients, criticality on a non-edge ($M_{ab}=-c$) gives
$$\theta=-\frac{c^2+\beta}{c}=\frac{a(n-1)\big[k^2-(n-1)\mu\big]}{wk},$$
and on an edge ($M_{ab}=a$) it gives $\theta=(a/w^2)\big[w^2+(n-1)^2\lambda+2k(n-1)(1-k)+k^2(n-2)\big]$. **Equating the two collapses to**
$$k(1+\lambda)-k^2+w\mu=0,\qquad\text{i.e.}\qquad k(k-\lambda-1)=(n-k-1)\mu,$$
the standard strongly-regular identity, this file's line 467 with the same reduction. Substituting it back, $k^2=k(\lambda+1)+w\mu$ gives $(n-1)(\lambda+1)-k^2=w(1+\lambda-\mu)$, whence
$$\boxed{\ \theta=(1+\lambda-\mu)\sqrt{\frac{2(n-1)}{nk(n-1-k)}}\ }$$
on the branch $a>0$, and $\lvert1+\lambda-\mu\rvert$ on whichever of $\pm M$ carries $\theta>0$. **L144's display is correct as written.**

**Three independent anchors, all agreeing.**

| anchor | check |
| --- | --- |
| [L74](../findings/diagonal-half.md), same file | its $F=\big[(n-1)^2\lambda+2k(n-1)-k^2n+w^2\big]/w^2$ simplifies to $(n-1)(1+\lambda-\mu)/w$, so $aF$ **is** the boxed form. L74 is the **signed** copy, L144 the absolute one; they differ by the $\pm M$ branch and both files say so |
| [DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) Theorem 5.1 | $\hat\theta=\lvert\lambda-\mu+1\rvert\sqrt{(n-1)/(nrr^c)}$, and the notes' conversion $\theta_{\text{record}}=\sqrt2\,\hat\theta$ returns the boxed form verbatim |
| the balanced product | $2K_m=\mathrm{srg}(2m,m-1,m-2,0)$ gives $(m-1)\sqrt{2(2m-1)/(2m\cdot m(m-1))}=\sqrt{(m-1)(2m-1)}/m=\theta_0(2m)$ |

**The sign branch, which is the whole reason L144 exists.** $K_{m,m}=\mathrm{srg}(2m,m,0,m)$ has $1+\lambda-\mu=1-m<0$, so on the positive root it returns $-\theta_0$; $2K_m$ has $1+\lambda-\mu=m-1>0$ and returns $+\theta_0$. The companion audit's finding on [L96](../findings/diagonal-half.md) (*"its named maximiser is the minimiser"*), is exactly this, and **L144's absolute value is the correct repair**. It is also the right one on the record's own reading of the balanced product, whose positive edges are the within-factor pairs, i.e. $2K_{n/2}$, its negative graph $K_{n/2,n/2}$ being triangle-free as the file's opening section requires.

## 2. "Every strongly regular graph is a diagonal critical point", CONFIRMED, and it is a statement about $P$ on the whole sphere

**What the derivation consumes, exactly three things.**

1. **Regularity**, to make $M\mathbf1=0$ solvable with a two-valued $M$: it is what fixes $t=k/w$, and without it no scalar $t$ works.
2. **The two-class structure** $A^2\in\langle I,A,J\rangle$, which is strong regularity itself: it is what confines $M^2$ to $\langle I,A,J\rangle$ and so makes $(M^2)_{ab}$ two-valued off the diagonal, matching $M$. **This is the load-bearing step.** With three or more classes the off-diagonal equation has more values than $M$ has and generically fails.
3. **Criticality as two scalar equations.** The diagonal of the boxed criterion is automatic ($(M^{\circ2})_{ii}=0$, $(M^2)_{ii}=s_i$), so the whole content is the edge equation and the non-edge equation; their **consistency** is one scalar condition, and §1 shows it *is* $k(k-\lambda-1)=w\mu$, an identity every strongly regular graph satisfies. Hence the claim, with no admissibility side condition. The only tacit hypotheses are $k\ge1$ and $w\ge1$ (neither $\Gamma$ nor its complement empty), which the formula's denominator already demands.

**It is genuine criticality of $P$ on the unit sphere of $\mathcal W_n$, not merely of $P$ restricted to $\mathcal D_n$**, and the block does not say which, though the file does. The "if" direction runs through symmetric criticality, and it checks out: $(\mathbb Z/2)^n$ acting by coordinate sign flips is a compact group of isometries preserving $P$, and $W_{ijkl}=\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_lW_{ijkl}$ forces every index to repeat, so its fixed set in $\mathcal W_n$ **is** the coordinate-diagonal locus. This matters because [I18](../plan.md) and [I5](../plan.md) quantify over critical points of $P$, not of $P|_{\mathcal D_n}$.

**Is a converse claimed, and does it hold?** L144 claims none. [L74](../findings/diagonal-half.md), 55 lines above, calls the correspondence *"[DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md)'s one-to-one correspondence"*, **and DGK's is one-to-one only for solutions whose off-diagonal entries take precisely two values** (Theorem 5.1, and the abstract's "eigenvalue spectrum consists of precisely two real numbers"). Read without that clause the phrase asserts a converse, and the converse is **false with a witness in this same file**: the unbalanced products $S^4\times S^8$ and $S^5\times S^7$ are verified diagonal critical points at $10^{-16}$ and have **three** off-diagonal values, and DGK's own §3 proof says so in as many words. *This costs L144 nothing, but the unqualified phrase in L74 is one clause away from a false statement and should carry DGK's two-value hypothesis.*

## 3. The imprimitive half, the formula is right, "maximised uniquely at $g=n/2$" is not, and the fix is one clause

An imprimitive strongly regular graph is $mK_g$ ($n=mg$, $m\ge2$, $g\ge2$) or its complement $K_{m\times g}$. For $mK_g$: $k=g-1$, $\lambda=g-2$, $\mu=0$, $w=n-g$, so $1+\lambda-\mu=g-1$ and
$$\theta=(g-1)\sqrt{\frac{2(n-1)}{n(g-1)(n-g)}}=\sqrt{\frac{2(n-1)(g-1)}{n(n-g)}} .$$
**CONFIRMED**, and it agrees with [DGK](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md) Example 5.2 after the $\sqrt2$ conversion.

**Complement-invariance is a theorem, not a coincidence.** For any $\Gamma$: $k'=w$, $w'=k$, $\lambda'=n-2-2k+\mu$, $\mu'=n-2k+\lambda$, so $1+\lambda'-\mu'=-(1+\lambda-\mu)$ while $k'w'=kw$. Hence $\theta(\bar\Gamma)=-\theta(\Gamma)$ signed, $\lvert\theta\rvert$ equal, which is [L74](../findings/diagonal-half.md)'s "$\pm M$, one point up to sign", and DGK note the same at L590–591. $K_{m\times g}$ accordingly returns the identical value, as it must.

**Now the defect.** Set $f(g)=2(n-1)(g-1)/\big(n(n-g)\big)$. Then
$$\frac{d}{dg}\frac{g-1}{n-g}=\frac{n-1}{(n-g)^2}>0,$$
so $f$ is **strictly increasing on $g<n$ and has no stationary point at all**. The maximum is a **boundary** maximum, and the boundary is supplied entirely by the constraint the block never writes down: $g$ must **divide $n$** with $n/g=m\ge2$, i.e. $g\le n/2$. Three consequences the block omits:

- **$g=n/2$ requires $n$ even.** At odd $n$ the largest admissible $g$ is $n/p$ for $p$ the least prime factor, hence $g\le n/3$; **at odd prime $n$ there is no imprimitive strongly regular graph at all**. *[L96](../findings/diagonal-half.md) was refuted today for precisely this omission, and its refutation, 150 lines above L144 in this same file, spells the qualifier out: "at odd $n$, $K_{n/2,n/2}$ does not exist".*
- **"Uniquely" is unique in $g$, not in the graph.** $mK_g$ and $K_{m\times g}$ share $g$ and share $\lvert\theta\rvert$; at $g=n/2$ they are $2K_{n/2}$ and $K_{n/2,n/2}$, two non-isomorphic graphs. The "up to" the brief predicts is missing, and again the file already has it, L74 calls them *"complements, hence one point up to sign"*. **Under the record's signed $\theta$ the maximiser is unique** (it is $2K_{n/2}$ on the $a>0$ branch) so the repair is to say *up to complementation*, or to drop the absolute value at this one sentence.
- **The reason is monotonicity, and it is missing.** A reader who checks "maximised uniquely at $g=n/2$" by differentiating finds no critical point and may read the claim as false. [r393](REVIEW_r393.md) had the word *"strictly increasing"*; L144 dropped it in the migration.

**The repair, which is stronger than what the block claims and needs no parity split.** For every imprimitive $\Gamma$, $\theta\le\theta_0(n)$, with equality **iff $n$ is even and $g=n/2$**; and every other imprimitive member has
$$\theta^2\le\frac{2(n-1)(n/3-1)}{n\cdot\tfrac23n}=\frac{(n-1)(n-3)}{n^2}<1<\tfrac32 .$$
So the runner-up family is out of the band **at every $n$, by a clean margin, with no threshold arithmetic**, which is what the discharge actually needs. *The even-$n$ omission is therefore a defect of statement, not of consequence: L144's conclusion survives it intact, and at odd $n$ the true statement is the stronger "no imprimitive DGK point is in the band at all".*

## 4. The primitive half, the grade is honest but pessimistic, and here is the proof

**First, the route the brief asks about is real but insufficient.** Eliminating $\lambda$ through the identity gives $1+\lambda-\mu=\big(k^2-(n-1)\mu\big)/k$, so
$$\theta^2=\frac{2(n-1)\big(k^2-(n-1)\mu\big)^2}{nk^3(n-1-k)},$$
a genuine **parabola in $\mu$** at fixed $(n,k)$, convex, maximised at an endpoint of any interval. The companion reviewer's observation is **CONFIRMED**. But the inference does not follow, and the witness is cheap: at $(n,k,\mu)=(100,50,1)$ the identity gives $\lambda=48.02\ge0$ and $1\le\mu\le k-1$, and
$$\theta^2=\frac{2\cdot99\cdot(2500-99)^2}{100\cdot50^3\cdot49}=1.8636>\tfrac32 .$$
**So convexity in $\mu$ plus $1\le\mu\le k-1$ plus $\lambda\ge0$ cannot even place the family below the band, let alone below $\tfrac12$.** What kills that tuple is $\lambda\notin\mathbb Z$. **Integrality is the load-bearing hypothesis**, the same conclusion the [L96](../findings/diagonal-half.md) refutation reached from the other side, where multiplicity integrality was named as "the hypothesis that actually works".

**The right coordinates are the eigenvalues, and they close it.** For a primitive strongly regular graph write $s=-m$, $S=m-1$; primitivity is exactly $r\ge1$ and $m\ge2$, i.e. $S\ge1$, and for a non-conference graph $r,S$ are positive integers. Then $k=\mu-rs=\mu+rm$ and
$$1+\lambda-\mu=1+r+s=1+r-m=r-S=:f,\qquad k=r(S+1)+\mu .$$
Put $A=k$, $B=S(r+1)$, $C=rS+\mu=k-r$, $D=A+S+1=k+m$. From $n=(k-r)(k-s)/\mu=CD/\mu$ and $w=n-1-k$ one gets $w=k(m-1)(r+1)/\mu=AB/\mu$, hence $n-1=k+w=A(\mu+B)/\mu$, and the closed form becomes
$$\theta^2=\frac{2(n-1)f^2}{nkw}=\frac{2f^2\mu(\mu+B)}{A\,B\,C\,D}.$$

> **CLAIM. $\theta<\tfrac12$ for every primitive strongly regular graph, at every $n$, with no census.**
>
> **Proof.** *Conference graphs* have $\lambda-\mu=-1$, so $f=1+r+s=0$ and $\theta=0$. *Otherwise* $r,S\ge1$ are integers and $\mu\ge1$. Since $\theta$ is complement-invariant (§3) and the complement of a primitive graph is primitive with $(r',S')=(S,r)$, **assume $r\ge S$**. Now $D>A$ and, by AM–GM on $A=r(S+1)+\mu$, $A^2\ge4\mu r(S+1)$. Hence
> $$\theta^2<\frac{2f^2\mu(\mu+B)}{A^2BC}\le\frac{2f^2\mu(\mu+B)}{4\mu r(S+1)BC}=\frac{f^2(\mu+B)}{2r(S+1)\,S(r+1)\,(rS+\mu)} ,$$
> so it suffices that $2(r-S)^2\big(\mu+S(r+1)\big)\le rS(S+1)(r+1)(rS+\mu)$. Both sides are affine in $\mu$, so it suffices to compare the two coefficients:
> - **$\mu$:** $2(r-S)^2\le rS(S+1)(r+1)$. With $r\ge S\ge1$ the left side is largest and the right smallest at $S=1$, where it reads $2(r-1)^2\le2r(r+1)$, i.e. $1\le3r$. ✓
> - **constant:** $2(r-S)^2S(r+1)\le rS(S+1)(r+1)\cdot rS$, i.e. $2(r-S)^2\le r^2S(S+1)$; again worst at $S=1$, where it reads $2(r-1)^2\le2r^2$. ✓
>
> Both hold for all $r\ge S\ge1$, so $\theta^2<\tfrac14$. $\square$

**The constant $\tfrac12$ is exactly right and is never attained.** Writing $\mu=cr$ and letting $r\to\infty$ at fixed $S$, $\theta^2\to2c/\big(S(S+1+c)^2\big)$, maximised at $c=S+1$ with value $1/\big(2S(S+1)\big)$; the supremum is $\tfrac14$, at $S=1$, i.e. $m=2$, $k/r\to4$, $\mu/r\to2$, and the complement-conjugate regime $r=1$, $m\to\infty$. **So $\theta<\tfrac12$ is sharp as a uniform bound, which is why the census stopped where it did**, the screened maximum $0.4758$ is the family creeping toward $\tfrac12$, not a coincidence of the range.

*Screen, reported as a screen and evidence for nothing.* Over integer $r,S\le60$, $\mu\le240$ (objects constructed here, exact rational arithmetic): the $(r,S,\mu)$ form and the $(n,k,\lambda,\mu)$ closed form agree identically at every tuple; no tuple reaches $\theta^2=\tfrac14$, the largest being $0.23712$ at $(r,S,\mu)=(1,60,61)$; both coefficient inequalities hold wherever $r\ge S$. Spot values against real graphs: $T(6)=\mathrm{srg}(15,8,4,4)$ gives $\theta^2=7/180$, the Schläfli graph $\mathrm{srg}(27,16,10,8)$ gives $\theta=0.32913$, both matching the $(n,k,\lambda,\mu)$ form.

**A second census number that is also a closed form.** The screened *"non-sphere supremum $0.7059\,\Theta_v$ over $v\le300$"* is the imprimitive runner-up family at $g=n/3$: at even $n$,
$$\frac{\theta(g=n/3)^2}{\theta_0(n)^2}=\frac{(n-1)(n-3)/n^2}{2(n-1)(n-2)/n^2}=\frac{n-3}{2(n-2)}\ \nearrow\ \tfrac12 ,$$
so the ratio is $1/\sqrt2=0.707107$ as a supremum, **never attained**, and at $n=300$ it is $0.705920$, the record's $0.7059$ **exactly**. *The census figure is the endpoint of the range, not a maximum; the closed form says so and removes the $v\le300$ cutoff, exactly as [L130](../findings/diagonal-half.md)(i) did for $r400$'s $0.28125$.*

> **CONSEQUENCE.** With §3's repair and this section, **both halves are proved and L144 is a Lemma, not an Observation.** Nothing is left screened: primitive $\theta<\tfrac12$ uniformly; imprimitive $\theta\le\theta_0(n)$ with equality iff $n$ is even and $g=n/2$, every other member below $1$. *The block's self-assessment of the primitive half is honest, it grades its evidence correctly and refuses the word "settled" that [L96](../findings/diagonal-half.md) took for a weaker check, but it is pessimistic, and this is the audit's most valuable outcome.*

## 5. Scope, what "the band" means, and $n\ge12$

**The record uses "the band" in two inequivalent senses and [conventions.md](../findings/conventions.md) tables neither.**

| sense | where | does the balanced product lie in it? |
| --- | --- | --- |
| $\theta\ge\sqrt{3/2}$, at $n\ge12$ | [I18](../plan.md), [I5](../plan.md), [problem.md](../findings/problem.md) | **yes**, $\theta_0(12)=1.236033>1.224745$ |
| $3\le\dim\mathfrak m<\lfloor n^2/4\rfloor$ | [target.md](../findings/target.md) | **no**, "balanced products sit *at* the cap and are outside" |

Under the second reading "no DGK point lies in the band **except the balanced product**" would name an exception that is excluded by definition, so the first is meant. **L144 should say so**, and the phrase belongs in [conventions.md](../findings/conventions.md)'s table of words with more than one meaning, it is the same class of collision as $\mathfrak m$, $B$, $M$ and $d$ already tabled there.

**Does the conclusion bear on $n\ge12$? Yes, and only there.** The band is empty below $n=12$, since $\theta_0(n)\ge\sqrt{3/2}$ exactly for $n\ge12$ ([problem.md](../findings/problem.md)); §3 and §4 are uniform in $n$; and for $n\ge12$ the only DGK point with $\theta\ge\sqrt{3/2}$ is $g=n/2$ at even $n$. **At odd $n\ge12$ the correct statement is that no DGK point is in the band at all.** So [R15](../routes.md)'s falsifier question is closed and [I18](../plan.md)(a) cannot be supplied from this family, the discharge stands, and after §4 it no longer *"inherits the status of its weakest input"*, because there is no longer a screen among its inputs.

## 6. Provenance, duplication, pointers

**Provenance, FALSE, and this is the one flat error.** L144 says it was *"migrated from [I18](../plan.md)(a) on 2026-09-03, where it was the sub-step's whole content and the record's only copy."* By `git log -S`:

| commit | when | what it did |
| --- | --- | --- |
| ae6fdf39 | 2026-09-02 22:12 | wrote the four claims into **both** [plan.md](../plan.md) I18(a) **and** [routes.md](../routes.md) R15's outcome column |
| c6902f8f | 2026-09-03 14:28 | the migration; its message says *"Four pieces of mathematics were checked for a second home before cutting, and three had none"* |
| 85482b1e | 2026-09-03 20:25 | added a third copy at [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) |

**So the second-home check was run and got this one wrong**: [routes.md](../routes.md) R15 had held the same closed form, the same $\tfrac12$, the same $0.7059\,\Theta_v$ and the same *"no DGK point is in the band except the balanced product"* for sixteen hours before the migration, and **still holds them today**. That copy is worse than the one L144 replaced: it states *"primitive SRGs sit below $\tfrac12$"* as flat fact with **no** screened/proved split and no range, which is exactly the overstatement L144's two-halves note exists to prevent. The report copy is honest on that point (*"over the range examined"*) but repeats *"maximised uniquely at $g=n/2$"* without the parity qualifier. **Three copies, one of them unhedged; after §4 the hedge is moot and all three can carry the theorem.**

**Duplication of the closed form, the three copies in [diagonal-half.md](../findings/diagonal-half.md) now agree.** Line 462 (the $F$-form, signed), [L74](../findings/diagonal-half.md) (the $F$-form, signed, $F=(n-1)(1+\lambda-\mu)/w$ after the identity) and L144 (absolute value); the signed/absolute difference is the $\pm M$ branch, which both blocks state. [L96](../findings/diagonal-half.md) was the wrong fourth copy and is already refuted in place.

**Does the file already settle it? Twice, above.** The [L96](../findings/diagonal-half.md) refutation block, 150 lines above L144, carries **both** qualifiers L144 omits, the odd-$n$ non-existence of $K_{n/2,n/2}$, and complement-invariance with the "one point up to sign" reading, and [L74](../findings/diagonal-half.md), 55 lines above, carries the second in the same words. *The pattern the checklist predicts holds again: the answer was in the same file, above the claim.*

**Pointers, all resolve.** The [L74](../findings/diagonal-half.md) anchor `#lemma-l74--theta-in-closed-form-for-every-strongly-regular-graph` matches its heading; [references/deninger-grundhoefer-kramer-2023-srg-quadratic/](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/) exists and its notes carry Theorem 5.1 and the $\sqrt2$ conversion; [plan.md](../plan.md) and [routes.md](../routes.md) resolve. L144 is indexed at [INDEX-results.md](../findings/INDEX-results.md) line 163 as *"Gate 2: no verdict on the record"*, which is **accurate**, [r393](REVIEW_r393.md) and [r394](REVIEW_r394.md) were Gate 2 on [ATTEMPTS.md](../ATTEMPTS.md) and produced this material as a by-product, so no reviewer has audited L144 as such until now. *One unrelated observation in passing: that index's closing line still reads "132 numbered results. Next free number: 133" against 149 rows.*

---

## What I would change, in order

1. **[routes.md](../routes.md) R15's outcome column**, the only unhedged copy on the record. Highest priority even before §4 lands, because it is the copy a reader of the routes table meets first.
2. **The imprimitive sentence.** Replace *"maximised uniquely at $g=n/2$"* with: *"$\theta$ is **strictly increasing** in $g$, and $g$ runs over the divisors of $n$ with $g\le n/2$; so the maximum is $\theta_0(n)$, attained **iff $n$ is even and $g=n/2$**, uniquely up to complementation, and every other imprimitive member has $\theta<1$."*
3. **Promote to a Lemma on §4's proof**, and replace the $0.7059$ census figure with $\sqrt{(n-3)/(2(n-2))}\nearrow1/\sqrt2$.
4. **Name the band's sense** in L144, and table the word in [conventions.md](../findings/conventions.md).
5. **Correct the provenance note**, and give [L74](../findings/diagonal-half.md)'s "one-to-one correspondence" DGK's two-value hypothesis.

**And the thing worth recording as such**: L144 grades its own two halves *correctly*. Faced with a wider range than [L96](../findings/diagonal-half.md) checked, it wrote *"this is a census over a finite range, so it is evidence rather than a theorem, and a uniform bound over all primitive parameter sets is owed"*, and then the discharge below it says in one clause that it inherits the status of its weakest input. **After a day of blocks overstating their support, this one understated it.** The uniform bound it declared owed is §4.
