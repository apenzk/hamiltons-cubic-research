# The stratum with at most two negative eigenvalues

Closed at every dimension. The one-positive lemma, the low-rank lemma, the padding reduction, and the assembled $\dim\mathfrak m\le2$ result.

Part of [findings/INDEX.md](INDEX.md), the index that says which file to open.

---

#### The one-positive case, in development form

*The statement and its proof are [Lemma L29](#lemma-l29-one-positive-and-two-negative-eigenvalues-cap-theta-at-sqrt32-canonical-statement-and-proof) below; this is the working it came from.*

**Statement.** Let $W\in\mathrm{Weyl}_n$ have $\|W\|=1$ and exactly one positive and two negative eigenvalues, $\lambda_1>0>-a\ge-b$. Then $\theta(W)\le\sqrt{3/2}$, with equality **at** the spectrum $(2,-1,-1)/\sqrt6$, padded $W_{\mathbb{CP}^2}$. The bound is dimension-free, and since $\sqrt{3/2}<\theta_0(n)$ from $n=12$, it **excludes this whole stratum at $n\ge12$**. *The converse (that equality forces that spectrum), is reduced but not closed: see the equality clause below.*

**Proof.** Expand $\langle W,W^\#\rangle=\tfrac12\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ in an eigenbasis, $T=c'^2$ nonnegative and totally symmetric, and split by the signs of the three indices. Three of the four blocks vanish, each structurally:

* $(+++)$ needs three positive indices and there is one, while $T$ vanishes whenever two indices coincide;
* $(++-)$ needs two distinct positive indices, likewise unavailable;
* $(---)$ needs three indices in a $2$-dimensional space, and $c'$ is antisymmetric in three indices.

Only $(+--)$ survives, equal to $3\,T_{1,N-1,N}\lambda_1ab$. The pair cap $\sum_\gamma T_{\alpha\beta\gamma}=\|[v_\alpha,v_\beta]\|^2\le2$ (on record as proven through $\|\mathrm{ad}_X\|_{\rm op}\le\sqrt2$), gives $T_{1,N-1,N}\le2$, so

$$\langle W,W^\#\rangle\le6\lambda_1ab,\qquad \mathop{\mathrm{tr}}W^3=\lambda_1^3-(a^3+b^3)\ \text{exactly}.$$

Trace-freeness gives $\lambda_1=a+b$ and unit norm gives $(a+b)^2+a^2+b^2=1$. Both are scale-free in $t=b/a$, and substituting collapses the bound to one closed form:

$$\theta\le f(t)=\frac{9\sqrt2\,t(t+1)}{4\,(t^2+t+1)^{3/2}} .$$

$f$ has a unique stationary point on $t\ge0$, at $t=1$, with $f(1)=\sqrt{3/2}$, while $f(0)=0$ and $f\to0$ as $t\to\infty$. So the maximum is $\sqrt{3/2}$, attained only at $a=b$. $\square$

**The stratum is a one-parameter family, not a point.** $\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, so $W^+=\mathrm{diag}(q+r,-q,-r)$ with $W^-=0$ is a stratum member for every $q,r>0$, padded into every $n\ge4$ with Bianchi and Ricci residual exactly $0$; padded $W_{\mathbb{CP}^2}$ is its $q=r$ member. On it $\theta=9qr(q+r)/\|W\|^3$ **exactly**, to twelve digits at six $(q,r)$ and at $n=4,6,7$ (Reviewer 58, independently of 59).

**The one inequality is an identity on this stratum** (Reviewer 59). Ricci-flatness here reads $\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$, all three terms positive semidefinite, so $\mathrm{im}\,v_2,\mathrm{im}\,v_3\subseteq\mathrm{im}\,v_1$ and **the support of $W$ is exactly $\mathrm{im}\,v_1$, of even dimension $r$**. Every stratum element is therefore a padding of a full-support $\mathrm{Weyl}_r$ element, and at $r=4$ that is the self-dual family with $\Lambda^+$ spectrum $(a+b,-a,-b)$, where $v_2,v_3$ are an orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$, and **every** orthonormal pair there brackets to norm-squared $2$. So the pair cap is saturated **identically**, not merely at the extremiser, and $\theta=f(t)$ **exactly** for every $t$, verified to all printed digits at $t=0.1\ldots1.0$.

**The equality clause, closed.** The argument gives equality $\Rightarrow$ spectrum $(2,-1,-1)/\sqrt6$; the converse needs that no other configuration attains $\sqrt{3/2}$. The bracket-cap characterisation forces $\mathrm{im}\,v_2=\mathrm{im}\,v_3$ of dimension $4$, hence $r=4$, so the *iff* is **equivalent to**: no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ exists for even $r\ge6$. Excluded numerically at $r=6,8,10$, residual floors $1.8\times10^{-2}$, $2.1\times10^{-2}$, $2.6\times10^{-2}$, decaying like $\delta^2$ as the rank constraint relaxes, so no separate branch, with **$r\ge12$ untested**. The bound itself is untouched by this.

**The Lemma extends to two positive eigenvalues, for the same reason.** $(+++)$ needs three *distinct* positive indices, so it vanishes at $k=2$ as well; maximising the resulting bound over the whole two-parameter family returns $\sqrt{3/2}$ again, attained only in the limit $\lambda_2\to0$, $a=b$, padded $W_{\mathbb{CP}^2}$ once more. **So the Lemma covers $k\le2$, i.e. rank $\le4$.**

**The general case is a near miss, and the gap is $0.2\%$.** For $k\ge3$ the $(+++)$ block is live, and the pair cap bounds it by $2\lambda_1(\sigma_2^2-p_2)$ with $\sigma_2=\sigma-\lambda_1$, $p_2=p-\lambda_1^2$, sharper than $2\lambda_1(\sigma^2-p)$ because every distinct triple carries two indices below the top one. With $\mathop{\mathrm{tr}}W^3\le\lambda_1p-(a^3+b^3)$, trace-freeness $\sigma=a+b$ and $p+m=1$, the whole stratum reduces to a two-parameter maximisation in $(a,b)$. On the symmetric slice it is exact:

$$\text{regime I}\ (a\le1/\sqrt6):\ 6a^3+2a,\qquad\text{maximum }\sqrt6/2=\sqrt{3/2}\ \text{at the regime boundary},$$

and $a=1/\sqrt6$ is exactly padded $W_{\mathbb{CP}^2}$. **Past that boundary the bound reaches $1.2274$ at $a=b=1/\sqrt{4.5}$**, against $\sqrt{3/2}=1.2247$, over by $0.22\%$. Whether that configuration is realisable by a Weyl tensor is unchecked; the chain's feasible set is larger than the realisable one, and the recorded numerics put the stratum's true maximum at exactly $\sqrt{3/2}$.

**A feasibility constraint that is easy to drop, and does not rescue the case.** $\lambda_1=\sqrt p$ forces $p_2=0$, hence $\sigma_2=0$, hence $k=1$: a top eigenvalue carrying all the positive mass leaves nothing for the others to sum to. For finite $n$ the constraint is $\sigma_2^2\le(k-1)p_2$ with $k\le N-2$, which looked like it might cut the overshoot away. **It does not.** The chain is steep near the cap, at $\lambda_1/\sqrt p=0.99,\,0.999,\,0.99999$ the value runs $1.2071,\,1.2254,\,1.2274$, so a scan sampling $\lambda_1$ at half-percent resolution reports the stratum closing, and a fine one reports it failing. Enforced exactly, the supremum over feasible $\lambda_1$ is $1.226297$ at $n=12$, $1.227426$ at $n=100$: **over the target at every $n$, by $0.13\%$ at $n=12$.** A coarse-grid pass suggesting otherwise was a resolution artefact and is not on record as a result.

**The pair cap is loose by a factor of six, and an exact identity says so.** Write $\epsilon_{\alpha\beta}=2-\|[v_\alpha,v_\beta]\|^2\ge0$ for the deficit from the cap. The Killing marginal $\sum_\beta\|[v_\alpha,v_\beta]\|^2=2(n-2)$ gives

$$\sum_{\beta}\epsilon_{\alpha\beta}=2(N-n+1)\quad\text{for every }\alpha,$$

constant in $\alpha$ and verified at $20$, $42$, $72$ for $n=6,8,10$. So the **mean** of $\|[v_\alpha,v_\beta]\|^2$ is $2(n-2)/(N-1)$, which **collapses to $4/(n+1)$** since $N-1=(n-2)(n+1)/2$ (the $(n-2)$ cancels, so the mean does not depend on it), giving $\tfrac47$, $\tfrac49$, $\tfrac4{11}$, $\tfrac4{13}$ at $n=6,8,10,12$, the printed $0.571$, $0.444$, $0.364$, $0.308$. Against the cap $2$ the chain spends everywhere the ratio is $2/(n+1)$, so the waste **widens with $n$**, a factor $3.5$ at $n=6$ against $6.5$ at $n=12$. The constant verified above is $(n-1)(n-2)$. *([BracketMean.lean](../lean/HamiltonsCubic/Results/BracketMean.lean).)* And $\mathop{\mathrm{tr}}(W^\#)=-\|W\|^2$, which holds because $Q$ preserves the trace-free Weyl space, is exactly

$$\sum_{\alpha\ne\beta}\epsilon_{\alpha\beta}\lambda_\alpha\lambda_\beta=0,$$

verified to $10^{-15}$ across the catalogue. Since $\epsilon\ge0$ and the $(+,+)$ and $(-,-)$ products are positive, **the deficit must be concentrated on the mixed-sign pairs**, a balance condition, not an inequality, and one the chain never used. Feeding it in gives a second closed bound, from $S_-=S_++2$ together with $\sum_\gamma T_{\alpha\beta\gamma}\lambda_\gamma\in[-bu_{\alpha\beta},\lambda_1u_{\alpha\beta}]$:

$$\langle W,W^\#\rangle\le(\lambda_1+b)\big[(\sigma^2-p)+2ab\big]+b,$$

which is **exactly tight at padded $W_{\mathbb{CP}^2}$**, $0.816497$ against $0.816497$, at $n=6,8,12$ alike, with the $(\sigma^2-p)$ term vanishing there. **At the failing configuration it is looser**, giving $1.4178$ where the first chain gives $1.2274$: the two bounds are tight at different places, so neither dominates and the stratum needs them combined rather than either alone. Neither is what fence post F15 closes, that LP carried no stratum condition and returned $1.6059$ where these return $1.2263$.

**What pair-cap equality costs the eigenvectors.** The chain's dominant term $(+--)\le6\lambda_1ab$ is tight only when $\|[v_{N-1},v_N]\|^2=2$, and ascent over orthonormal pairs in $\mathfrak{so}(n)$ attains that cap with **both bivectors of matrix rank $4$**, at $n=6$, $8$ and $12$ alike, so the structure does not vary with dimension. Simple bivectors do not attain it: $[\varphi_{12},\varphi_{13}]=\pm\varphi_{23}$ has norm $1$. So equality pins the two negative eigenvectors to a $2$-plane of rank-$4$ bivectors, which by the Plücker criterion already on record is precisely a plane containing no decomposable element, the same condition that certifies non-diagonalisability. The estimate cannot be tight and the point coordinate-diagonal at once.

**What the failing configuration requires.** At $n=12$ the supremum sits at $\lambda_1=0.744939$ against a cap of $0.745356$, with $\sigma_2^2/p_2$ pushed to its ceiling $N-3=63$, so it needs about $63$ positive eigenvalues alongside the two negative ones, essentially all of $\Lambda^2$. Whether $\mathrm{Weyl}_{12}$ admits a spectrum of $63$ positive, $2$ negative and $1$ zero eigenvalue in those proportions is a structural question, and it is the one the next attempt should answer rather than another estimate.

> **THE ARGMAX IS A MULTIPLE OF THE IDENTITY PLUS A RANK-THREE CORRECTION, AND IT IS UNREALISABLE, WHICH CLOSES NOTHING.** *Attaining $\sigma_2^2/p_2$'s ceiling $N-3$ forces $k_2=N-3$ AND equality, so those eigenvalues are equal; at $n=12$ the spectrum fills as $1+63+2=66$, and a zero eigenvalue is EXCLUDED rather than present.* **So $W=\mu\,\mathrm{Id}_{\Lambda^2}+K$ with $\mathop{\mathrm{rank}}K\le3$**, the exceptional eigenvectors being the top one and the two negatives, and $W$ has trivial kernel on $\Lambda^2$.

> **THE ARGMAX CANNOT BE A WEYL TENSOR** ([r830](../reviews/REVIEW_r830.md) and [r831](../reviews/REVIEW_r831.md), independently). *Trivial kernel with Ricci-flatness forces $\ker v_{N-1}\cap\ker v_N=0$, while tightness of the chain's dominant $(+--)$ term forces $\lVert[v_{N-1},v_N]\rVert^2=2$, and [Lemma L31](#lemma-l30-a-small-negative-eigenspace-forces-a-small-support) then gives equal rank-four images with a common kernel of dimension $n-4$.* **Contradictory at every $n>4$.** *This is the realisability argument the obstruction paragraph below asks for, and [the paragraph above](#the-low-rank-case-in-development-form) already carries it: what that paragraph also records is that it DOES NOT REACH THE ESTIMATE.* **The chain still overshoots at $52$ positive eigenvalues**, so "about $63$ of $66$" described the argmax rather than the cause, and killing the argmax leaves the overshoot where it was.

> **WHAT THE CENSUS FORM BUYS, STATED WITHOUT THE CONCLUSION IT DOES NOT SUPPORT.** *Write $c_\alpha=\lambda_\alpha-\mu$ over the three exceptional eigenvectors. Trace-freeness gives $\sum c_\alpha=-N\mu$, and the two conditions read $\sum c_\alpha\Phi(v_\alpha)=(\mu(n-1)\mathrm{Id},0)$ for [L183](diagonal-half.md)'s $\Phi(\omega)=(\omega^2,\omega\wedge\omega)$.* **Dividing by the weight sum makes it affine, and both $\mu$ and the multiplicity cancel:**
> $$\sum_{\alpha}\frac{c_\alpha}{-N\mu}\,\Phi(v_\alpha)=B,\qquad B:=\Big(-\tfrac2n\,\mathrm{Id}_{\mathbb R^n},\,0\Big),\qquad \sum_\alpha\frac{c_\alpha}{-N\mu}=1 .$$
> *So $B$ lies in the affine hull of a TRIANGLE of points of the surface $\Phi(\Lambda^2\mathbb R^n)$, where [L183](diagonal-half.md)'s three-point form puts the target at the origin and makes the points affinely dependent.* ([ShiftedCensus.lean](../lean/HamiltonsCubic/Results/ShiftedCensus.lean) types the cancellation.) **The weights carry one negative sign, at the top eigenvector, so $B$ lies outside the triangle.**

> **AND $B$ IS NOT ON THE SURFACE at any $n\ge2$.** *$\omega^2=-\tfrac2n\mathrm{Id}$ makes $\omega$ a scaled complex structure, of full rank, while $\omega\wedge\omega=0$ makes it decomposable, of rank two.* **So the three points cannot coincide**, which is the branch [L183](diagonal-half.md) carries separately.

> **THE FIRST COMPONENT IS AN ISOTROPY CONDITION AT EVERY VECTOR.** *Pairing against $x$ and using $\langle v^2x,x\rangle=-\lvert vx\rvert^2$ gives $\sum_\alpha w_\alpha\lvert v_\alpha x\rvert^2=\tfrac2n\lvert x\rvert^2$ for every $x$, and $2/n$ is exactly the spherical average of $\lvert vx\rvert^2$ at a unit bivector.* **So the weighted combination is its own average uniformly in $x$ rather than on average.** *The trace is uninformative and $B$ says why: every $\Phi(\omega)$ at a unit $\omega$ has first component of trace $-2$, and $\mathop{\mathrm{tr}}(-\tfrac2n\mathrm{Id})=-2$ exactly.*

**The obstruction, stated so the next attempt does not repeat these.** Combining the two bounds does not close the stratum: their minimum still overshoots, by $0.139\%$ at $n=12$, $0.189\%$ at $n=20$ and $0.220\%$ as $n\to\infty$, because **the second bound is slack exactly where the first breaks**, at $a\approx b\approx0.46$ with $\lambda_1$ at its cap, bound 2 gives $1.4178$ against bound 1's $1.2274$. Three separate attempts have now left that number where it was: the finite-$n$ feasibility constraint, the deficit identity, and the combination. **What is blocking it is that every bound tried is tight at padded $W_{\mathbb{CP}^2}$ and slack at the failing configuration, so none of them separates the two.** A fourth estimate of the same kind is not worth attempting; what is needed is either a realisability argument ruling the configuration out (it requires about $63$ of $66$ eigenvalues positive at $n=12$) or a bound built at that configuration rather than at the extremiser.

**What it does not reach**, stated exactly: $k\ge3$ positive eigenvalues alongside two negative ones. ([b_two_negative_stratum.py](../scripts/route-b/b_two_negative_stratum.py))

#### Lemma L29, one positive and two negative eigenvalues cap $\theta$ at $\sqrt{3/2}$, canonical statement and proof


Needed because the residual of route R9 is a value bound rather than a classification, and the sharpest
competitor sits where the hypothesis defining that residual is vacuous. The slack is the structure mass
carried by the negative eigenspace, $S(W)=\sum_{\lambda<0}c'^2_{\alpha\beta\gamma}$, and $c'$ is
antisymmetric in three indices, so $S$ vanishes identically once $\dim\mathfrak m\le2$. Padded
$W_{\mathbb{CP}^2}$ has spectrum $(2,-1,-1)/\sqrt6$ and lies in that stratum.

**Statement.** Let $W\in\mathrm{Weyl}_n$ have $\|W\|=1$ and exactly one positive and two negative
eigenvalues, $\lambda_1>0>-a\ge-b$. Then $\theta(W)\le\sqrt{3/2}$, attained at the spectrum
$(2,-1,-1)/\sqrt6$. The bound carries no dimension restriction. The converse, that equality forces
that spectrum, **is closed in three lines by [Lemma L31](#lemma-l31-the-bracket-cap-characterised-canonical-statement-and-proof), at every $n$ and with no numerics**: equality forces
$T_{1,N-1,N}=2$, hence $\lVert[v_{N-1},v_N]\rVert^2=2$, hence $\mathop{\mathrm{im}}v_2=\mathop{\mathrm{im}}v_3$ of dimension $4$, hence $r=4$ through Ricci-flatness.
[Lemma L33](#lemma-l33-one-eigenvalue-of-one-sign-forces-the-tensor-to-vanish-canonical-statement-and-proof) closes it by a second route.

> **THE CREDIT ONCE GIVEN HERE TO [LEMMA L72](#lemma-l72-the-rank-3-stratum-is-overdetermined-and-its-converse-clause-closes-in-three-lines) IS WITHDRAWN, AND THE CONTAINMENT RUNS THE OTHER WAY.** L72 quantifies over **critical** points; this clause quantifies over **equality** points, and by this lemma together with L72 the critical points are a *subset* of the equality points, so L72 is the weaker statement and cannot close it. *What the numerics at $r=6,8,10$ hedged was the realisability of a full-support rank-$3$ element, which the criticality rows do not touch.* *Gate 2, [r541](../reviews/REVIEW_r541.md) and [r542](../reviews/REVIEW_r542.md) on identical briefs, agreeing.*

**Proof.** In an eigenbasis, $\langle W,W^\#\rangle=\tfrac12\sum T_{\alpha\beta\gamma}\lambda_\alpha
\lambda_\beta\lambda_\gamma$ with $T=c'^2$ nonnegative and totally symmetric. Split by the signs of the
three indices. Three blocks vanish, each structurally rather than numerically: $(+++)$ and $(++-)$ need
two or three distinct positive indices while only one exists and $T$ vanishes on repeated indices;
$(---)$ needs three indices in a $2$-dimensional space, where a form antisymmetric in three indices is
identically zero. Only $(+--)$ survives, equal to $3\,T_{1,N-1,N}\lambda_1ab$, and the pair cap
$\sum_\gamma T_{\alpha\beta\gamma}=\|[v_\alpha,v_\beta]\|^2\le2$ bounds it, giving
$\langle W,W^\#\rangle\le6\lambda_1ab$ against the exact $\mathop{\mathrm{tr}}W^3=\lambda_1^3-(a^3+b^3)$.
Trace-freeness gives $\lambda_1=a+b$ and unit norm $(a+b)^2+a^2+b^2=1$; both are scale-free in $t=b/a$,
and substituting collapses the estimate to

$$\theta\le f(t)=\frac{9\sqrt2\,t(t+1)}{4\,(t^2+t+1)^{3/2}},$$

whose unique stationary point on $t\ge0$ is $t=1$, with $f(1)=\sqrt{3/2}$, $f(0)=0$ and $f\to0$ as
$t\to\infty$. Hence the maximum is $\sqrt{3/2}$, attained only at $a=b$. $\square$

**The single inequality is an identity on this stratum.** Ricci-flatness reads
$\lambda_1v_1v_1^{\mathsf T}=a\,v_2v_2^{\mathsf T}+b\,v_3v_3^{\mathsf T}$ with all three terms positive
semidefinite, so the support of $W$ is exactly $\mathrm{im}\,v_1$, of even dimension, and at dimension
four $v_2,v_3$ are an orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$, where every orthonormal pair
brackets to norm-squared $2$. The pair cap is therefore saturated identically and $\theta=f(t)$ exactly,
not merely at the maximiser. **Gate 2 passed** ([r513](../reviews/REVIEW_r513.md) and [r514](../reviews/REVIEW_r514.md), both CONFIRMED, each re-deriving the chain cold; earlier by Reviewers 58 and 59 on identical briefs, independent
implementations, both CONFIRMED, and both found the stratum to be the one-parameter family
$W^+=\mathrm{diag}(q+r,-q,-r)$ with $\theta=9qr(q+r)/\|W\|^3$ exactly
([b_two_negative_stratum.py](../scripts/route-b/b_two_negative_stratum.py)).

**What it settles and what it does not.** Since $\sqrt{3/2}<\Theta_n$ (**the constant is $\Theta_n$, not $\theta_0(n)$, which is attained only at even $n$**), the threshold being $n^2-13n+18>0$ at odd $n$ and $n^2-12n+8>0$ at even, so "from $n=12$" survives at both parities. Since $\sqrt{3/2}<\Theta_n$ from $n=12$, no maximiser in that
dimension range has this spectrum, which excludes the nearest known competitor without any enumeration,
and enumeration has since been refuted on both halves of the residual. **It reaches $k=2$ as well, and the reason first given for stopping at $k=1$ is wrong on both counts**, *and [Lemma L35](../results.md) discharges the $k=2$ claim, its machine-checked proof (`L35` in [L35Statement.lean](../lean/HamiltonsCubic/Results/L35Statement.lean)) covering every number of positives with no use of this lemma.* $(+++)$ does not reappear at $k=2$, needing three distinct positive indices; and $(++-)$ reappearing costs nothing, since it enters with $\lambda_+\lambda_+\lambda_-<0$ against $T\ge0$ and is free to drop from an upper bound. What the extension actually turns on is the **joint** cap $T_{1,N-1,N}+T_{2,N-1,N}\le2$ rather than the per-index one, which alone would give $3a$ with maximum $1.5$. *Gate 2, [r513](../reviews/REVIEW_r513.md) and [r514](../reviews/REVIEW_r514.md) on identical briefs, both CONFIRMED and reaching the same correction.* **Three or more positive eigenvalues stay outside**, and are covered by [Lemma L35](#lemma-l35-at-most-two-negative-eigenvalues-caps-theta-at-sqrt32-unconditionally).


#### Lemma L33, one eigenvalue of one sign forces the tensor to vanish, canonical statement and proof


Needed because item B0 had been reduced to exactly this question, and two independent searches over $520$
starts had failed to settle it either way.

**Statement.** Let $W\in\mathrm{Weyl}_m$ have a **one-dimensional** eigenspace on one side, exactly one eigenvalue counted *with multiplicity*. If that eigenvector is not
a multiple of a complex structure on a $4$-dimensional subspace, then $W=0$. In particular no rank-$3$
$\mathrm{Weyl}_m$ tensor at even $m\ge6$ has a nondegenerate minority-side eigenvector.

> **"Exactly one eigenvalue of one sign" was ambiguous, and the lemma is FALSE under the other reading.** Counted as *one distinct value at any multiplicity*, a witness sits already in $\mathrm{Weyl}_4$: $W^+=W^-=\mathop{\mathrm{diag}}(2,-1,-1)$ has spectrum $(2,2,-1,-1,-1,-1)$, its $+2$ eigenspace contains a rank-$2$ element that is no complex structure, and $W\ne0$. [Lemma L34](#lemma-l34-full-support-with-two-negative-eigenvalues-at-m6-and-m8-canonical-statement-and-proof) supplies a second witness at $m=8$. **This file's own convention counts with multiplicity, so the statement was correct in place**, and it is quoted in [results.md](../results.md) and in the report, where that convention does not travel. *Gate 2, [r511](../reviews/REVIEW_r511.md) and [r512](../reviews/REVIEW_r512.md) on identical briefs, both CONFIRMED, each building the witness independently.*
>
> **The exception is realised and complete**, checked by cases on the degenerate ranks by both reviewers with no second family, unlike [Lemma L11](route-a.md), whose single stated exception this audit found to be two. **And [Lemma L32](isotropy-cap.md)'s missing hypothesis never reaches here**: $\mathfrak c=0$ would force $m\le3$, where $\mathrm{Weyl}_m=0$, so L33 is unconditional. *Three true clauses were dropped in the move, notably that the result covers odd $m$ and degenerate minority eigenvectors.*

**The identity the proof runs on.** Pairing the first Bianchi identity against $u\otimes u$ for arbitrary skew
$u$, the term $\mathop{\mathrm{tr}}(u^2v_\alpha^2)$ that appears is annihilated by Ricci-flatness, leaving an
operator identity on $\mathfrak{so}(m)$:

$$\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W,\qquad\text{i.e.}\qquad
\sum_\alpha\lambda_\alpha N_{v_\alpha}=0,\quad N_v:=2\,v\otimes v-\mathrm{ad}(v)^2 .$$

**This is derived here and needs no outside source.** *Two independent derivations were built for it in one round.* The first closes $\lVert[v,u]\rVert^2=\mathop{\mathrm{tr}}(u^2v^2)-\mathop{\mathrm{tr}}(uvuv)$, whose first term is $-\mathop{\mathrm{tr}}(\mathrm{Ric}\,u^2)$ and whose second is $X=\sum W_{abcd}u_{ac}u_{bd}$: **first Bianchi enters exactly once**, closing $X+Y+Z=0$ with $Y=-4\langle u,Wu\rangle$ and $Z=X$, neither of which uses it, so $X=2\langle u,Wu\rangle$. The second runs by Schur: the map is an equivariant endomorphism of $\mathrm{Sym}^2(\Lambda^2)$ whose four summands have distinct highest weights, so one hand evaluation at padded $W_{\mathbb{CP}^2}$ pins it at $2$ on $\mathcal W_m$ for every $m\ge4$. **And the record already held it**: [isotropy-cap.md](isotropy-cap.md)'s operator $T(A)=-\sum_k\mathrm{ad}(f_k)A\,\mathrm{ad}(f_k)$, forty-five lines above [L32](isotropy-cap.md), carries the same quadratic form, and its tabled value $-2$ on $\mathrm{Weyl}_n$ **is this identity**.

*Not Besse, [Einstein Manifolds](https://link.springer.com/book/10.1007/978-3-540-74311-8) §1.143, a section [references/](../references/) does not hold, on the Lichnerowicz Laplacian for **symmetric $2$-tensors** rather than $2$-forms, and transferred from a manifold statement to an algebraic curvature operator without comment. [Petersen–Wink Proposition 1.6](https://arxiv.org/abs/1908.09958) gives the eigenbasis rewriting and not the evaluation, and [its notes on file](../references/petersen-wink-2019-bochner-technique/notes.md) carry a derivation the block did not use.* **First Bianchi is the load-bearing hypothesis**, it alone
gives $\mathcal A(R)=2R-(\mathrm{Ric}\cdot\omega+\omega\cdot\mathrm{Ric})$, while Ricci-flatness only
deletes the correction, and fails on its own because $\Lambda^4$ is itself Ricci-flat and carries eigenvalue
$-4$ rather than $+2$.

**What is new is the splitting.** $\mathrm{ad}(v)$ is skew-adjoint on $\mathfrak{so}(m)$, so
$\langle u,N_vu\rangle=2\langle v,u\rangle^2+\|[v,u]\|^2$ and each $N_v$ is positive semidefinite with
$\ker N_v=v^\perp\cap\mathfrak z(v)$. The identity is therefore a balance of positive semidefinite operators
between the two halves of the spectrum.

**Proof.** Rescale so the identity reads $N_x=\sum_iN_{y_i}$, $x$ the minority-side eigenvector. All terms
being positive semidefinite, $\ker N_x\subseteq\bigcap_i\ker N_{y_i}$: the space
$\mathfrak c=\mathfrak z(x)\cap x^\perp$ commutes with every $y_i$ and is orthogonal to each. So every
$y_i\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp=\mathbb Rx$ by [Lemma L32](isotropy-cap.md), while $y_i\perp x$; hence every
$y_i=0$, $W=\pm x\otimes x$, and **the trace** then forces $x=0$. $\square$

**$\mathfrak c\ne0$ is automatic, and the count that gives it is [L32](isotropy-cap.md)'s own.** From $\dim\mathfrak z(x)=\sum_jm_j^2+\binom k2$, $\mathfrak c=0$ happens exactly at $m\in\{2,3\}$ with $\mathop{\mathrm{rank}}x=2$, so it cannot happen at any $m$ where $\mathcal W_m\ne0$. *The discharge offered before ("the torus spanned by $x$'s own $2$-blocks"), gives only $\dim\mathfrak z(x)\ge1$, exactly $1$ at $x=\varphi_{12}\in\mathfrak{so}(6)$, where the argument wanted $\lfloor m/2\rfloor$.*

> **THE OWED LINE IS WRITTEN, AS [Lemma L160](isotropy-cap.md).** [L32](isotropy-cap.md)'s two branches cover the two failure modes between them, and what neither wrote down is that the mixed summand $\mathop{\mathrm{Hom}}(\ker x,\mathop{\mathrm{im}}x)$ contributes nothing. **It does so if and only if $m\ne3$**, by two facts that decouple: at $\dim\ker x\ge2$ the standard representation of $\mathfrak{so}(\ker x)$ has no invariant vector, and at $\dim\ker x=1$ (where that fact is **false** rather than vacuous), $\mathfrak c_V$ has trivial common kernel on $\mathop{\mathrm{im}}x$, which holds exactly when $\mathop{\mathrm{rank}}x\ge4$. *They are jointly empty only at $m=3$.* **So L32's sharp hypothesis and this step's are the same hypothesis, and the degenerate branch is now a reduction onto the maximal-rank one rather than a resemblance to it.** *Gate 2, [I41a](../reviews/REVIEW_I41a.md) and [I41b](../reviews/REVIEW_I41b.md).*

**Where this leaves the result.** The main statement stands wherever [L32](isotropy-cap.md) does, **which is every $m\ne3$, with no debt outstanding.** *L33 is vacuous at $m=4$ in any case*: a single positive eigenvalue forces one of $W^\pm=0$, and every nonzero element of $\Lambda^\pm$ squares to $-\tfrac12\lvert c\rvert^2I$, so $m=4$ is always the exception, which is why the *"in particular"* clause's $m\ge6$ is sharp, false at $m=4$ with $W\vert_{\Lambda^2_+}=\mathop{\mathrm{diag}}(2,-1,-1)$ and $W\vert_{\Lambda^2_-}=0$.

**What consumes this result.** *Nothing load-bearing.* The B0 route it was built for is refuted by [Lemma L34](#lemma-l34-full-support-with-two-negative-eigenvalues-at-m6-and-m8-canonical-statement-and-proof), and its live use at [Lemma L29](#lemma-l29-one-positive-and-two-negative-eigenvalues-cap-theta-at-sqrt32-canonical-statement-and-proof)'s equality clause is a second route to something [Lemma L31](#lemma-l31-the-bracket-cap-characterised-canonical-statement-and-proof) already closes.

> **THE HYPOTHESIS $\mathfrak c\ne0$ WAS ADDED TO [LEMMA L32](isotropy-cap.md) AT THE 2026-09-04 AUDIT, AND THIS IS ITS ONE USE.** *It holds throughout the range this record works in.* For skew $x\ne0$ on $\mathbb R^n$, $\mathfrak z(x)$ contains the torus spanned by $x$'s own $2$-blocks, so $\dim\mathfrak z(x)\ge\lfloor n/2\rfloor$ and
> $$\dim\mathfrak c=\dim\big(\mathfrak z(x)\cap x^\perp\big)\ \ge\ \lfloor n/2\rfloor-1 ,$$
> **which vanishes only at $n\le3$**, precisely the $\mathfrak{so}(3)$ witness that refuted L32 as stated. *At $n\ge12$ the bound is at least $5$, so the step above is unaffected.*

**The exception is realised, and it explains the failed searches.** On $\mathbb R^4$ the self-dual forms are
complex structures, and $W_4(q,r)=-(q+r)\,w_1\otimes w_1+q\,w_2\otimes w_2+r\,w_3\otimes w_3$ lies in
$\mathrm{Weyl}_4$ with signature $(2,1)$; its negative is the base-case family at $\theta=+\sqrt{3/2}$, and it
is also the Weyl part of the Fubini–Study operator at $m=4$. Gate 2 passed by both reviewers through an
independent **convex** certificate rather than the centraliser argument: with the minority eigenvector fixed,
existence is a semidefinite feasibility problem, infeasible at every multiplicity pattern and both signs at
$m=6,8,10,12$, with a feasible degenerate control returning the padded $\mathrm{Weyl}_4$ element.


#### The low-rank case, in development form

*The statement and its proof are [Lemma L30](#lemma-l30-a-small-negative-eigenspace-forces-a-small-support) below; this is the working it came from.*

**Statement.** Let $W\in\mathrm{Weyl}_n$, and let $\mathfrak m$ be the span of its negative eigenvectors, *this file's $\mathfrak m$, not [conventions.md](conventions.md)'s $E_{\min}$, under which the hypothesis is weaker and the statement false.* If **$\mathfrak m$ has a nonzero common kernel**, $\bigcap_{v\in\mathfrak m}\ker v\ne0$, which a rank sum below $n$ is one sufficient condition for, then $W$ vanishes identically on an $(n-1)$-dimensional subspace of $\Lambda^2$, and hence has **at least $n-1$ zero eigenvalues**. **The descent is a single step, not one dimension at a time**: $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor with $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$, measured at $\dim U=4$ throughout (Reviewer 58). In particular the number of positive eigenvalues is at most $N-n-1$, at $n=12$, at most $53$ of $66$.

**The mechanism, in general form.** Ricci-flatness is exactly the PSD identity

$$\sum_\alpha\lambda_\alpha\,v_\alpha^{\mathsf T}v_\alpha=0 ,$$

since $\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\|v_\alpha x\|^2$ and $v^{\mathsf T}v\succeq0$ for skew $v$, verified at $3\times10^{-15}$ with both sides positive semidefinite to $10^{-17}$. So **the negative eigenvectors' images lie inside the combined image of the positive ones**, which is what makes a small negative eigenspace force a small support. With a single positive eigenvalue it collapses to $\lambda_1v_1^{\mathsf T}v_1=a\,v_2^{\mathsf T}v_2+b\,v_3^{\mathsf T}v_3$ and pins the support to $\mathrm{im}\,v_1$ exactly, of even dimension, Reviewer 59's route, and the reason the padding reduction below works at all.

**Proof.** Ricci-flatness is exactly the statement that for every unit $u$, the trace of $W$ on the $(n-1)$-dimensional subspace $u\wedge u^\perp$ vanishes: $\mathrm{Ric}(u,u)=\sum_j\langle W(u\wedge f_j),u\wedge f_j\rangle$ for $\{f_j\}$ an orthonormal basis of $u^\perp$. A skew matrix $v$ satisfies $v\perp u\wedge u^\perp$ precisely when $u\in\ker v$. Pick $u$ in the common kernel. *The hypothesis is stated invariantly for a reason (Reviewer 59): under a repeated negative eigenvalue the individual ranks are not determined by $W$, and the rank-sum form misses padded $W_{\mathbb{CP}^2}$ below $n=9$, where the ranks are $4+4=8$ while the conclusion holds anyway.* Then the negative part of $W$ contributes nothing to the trace on $u\wedge u^\perp$, while the positive part is positive semidefinite there with total trace zero, so it vanishes on the whole subspace. $\square$

**Screened with a control.** At padded $W_{\mathbb{CP}^2}$, both negative eigenvectors have rank $4$, so the common kernel has dimension $n-4$, $6$ at $n=10$ and $8$ at $n=12$, the pair pinning the rank since rank $5$ would give $5$ and $7$. For $u$ in it, $\|W|_{u\wedge u^\perp}\|$ is $1.4\times10^{-16}$ and $2.8\times10^{-16}$; for a generic $u$ it is $0.186$ and $0.106$, while the **trace** vanishes at $10^{-16}$ for both, so the vanishing is the kernel's doing and not Ricci-flatness alone.

**This refutes the configuration that was blocking B0.** The chain's overshoot sits at a spectrum needing about $63$ positive eigenvalues at $n=12$ against this Lemma's ceiling of $53$, and the chain reaches that overshoot only when its dominant term $(+--)$ is near-tight, which needs $\|[v_{N-1},v_N]\|^2$ near its cap $2$, which is attained exactly at **rank $4$** for both eigenvectors, giving rank sum $8<12$ and putting the hypothesis in force. What is still soft is the word *near*: the rank hypothesis is stated for exact tightness, and a quantitative version is what turns this into a closed proof of the stratum.

**The quantitative link exists and is monotone.** The right measure of "almost a common kernel" is $\epsilon_{\min}=\min_{\|u\|=1}(\|v_{N-1}u\|^2+\|v_Nu\|^2)$, the smallest eigenvalue of $v_{N-1}^{\mathsf T}v_{N-1}+v_N^{\mathsf T}v_N$, which is zero exactly when the kernels meet. Across $600$ orthonormal pairs at $n=12$, spread over the whole range of $\|[X,Y]\|^2$:

| $\|[X,Y]\|^2$ | $[0,0.5)$ | $[0.5,1)$ | $[1,1.5)$ | $[1.5,1.9)$ | $[1.9,1.99)$ | $\ge1.99$ |
|---|---|---|---|---|---|---|
| $\epsilon_{\min}$ range | $0.021$–$0.079$ | $0.015$–$0.059$ | $0.005$–$0.026$ | $0.0011$–$0.0091$ | $0.0001$–$0.0010$ | $\le1.2\times10^{-4}$ |

So a near-tight bracket does force a near-common kernel, and the collapse is by three orders of magnitude across the range. **The constant relating them is not recorded from this**: these are samples, and a constant entering a bound is a supremum that has to come from ascent. The shape to establish is $\epsilon_{\min}\le C\,(2-\|[X,Y]\|^2)$, with the perturbative consequence that $W_+$ has trace at most $\sigma\,\epsilon_{\min}$ on an $(n-1)$-plane.

**What is closed form, and what the ascent could not deliver.** Unconditionally $\epsilon_{\min}\le4/n$: the normalisation $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)=1$ gives $\mathop{\mathrm{tr}}(X^{\mathsf T}X+Y^{\mathsf T}Y)=4$, so the smallest of $n$ eigenvalues is at most $4/n$, with equality exactly when the sum is isotropic, **pigeonhole on an average, with no property of the operators entering**: the same bound holds for any $n$ nonnegative numbers of that sum ([MinEigenvalue.lean](../lean/HamiltonsCubic/Results/MinEigenvalue.lean)), $1/3$ at $n=12$, against the unconstrained ascent's $0.307809$. At the other end the bracket cap forces both to rank $4$, so the sum has rank exactly $4$ by [Lemma L31](#lemma-l31-the-bracket-cap-characterised-canonical-statement-and-proof), so certainly $\le8<n$ and $\epsilon_{\min}=0$. **The constrained constant, by continuation.** A penalty ascent leaves the feasible set and a cold retraction cannot reach the level sets near the cap, where the bracket's gradient vanishes. What works is continuation: ascend the bracket to $2$ first, then walk the target down and run a *projected* ascent of $\epsilon_{\min}$ on each level set $\{\|[X,Y]\|^2=2-\delta\}$, retracting after every step. The ratio $\epsilon_{\min}/\delta$ then rises monotonically, $0.1174$ at $\delta=0.35$, $0.1223$ at $0.5$, $0.1313$ at $0.8$, $0.1382$ at $1.0$, toward the unconstrained endpoint $0.3078/2=0.1539$ at $\delta=2$. Both ends of that range are closed form, so the conjectured sharp statement is

$$\epsilon_{\min}\ \le\ \frac{2}{n}\big(2-\|[X,Y]\|^2\big),$$

$2/n=0.1667$ at $n=12$ against the observed $0.1539$. **What is measured is the monotonicity of the ratio; the endpoints are proved.** That reduces the gap from an open search to a single one-line statement, and the consequence it feeds is $\mathop{\mathrm{tr}}\big(W_+|_{u\wedge u^\perp}\big)\le\sigma\,\epsilon_{\min}\le2\sigma\delta/n$, which by Ky Fan bounds the sum of the $n-1$ *smallest* positive eigenvalues.

**And that does not close the stratum either.** Carrying the deficit explicitly, so $(+--)\le3ab(2-\delta)\lambda_1$, and cutting the positive-count ceiling from $N-3$ to $N-n-2$ as the Ky Fan bound forces $n-1$ eigenvalues to vanish, the maximum moves from $1.226433$ to $1.226264$ at $n=12$, and from $1.227046$ to $1.227029$ at $n=20$. **The count was never the lever.** The earlier reading, that the overshoot needs about $63$ of $66$ eigenvalues positive, described the argmax rather than the cause: the chain still overshoots at $52$. So the realisability argument, correct as a Lemma, does not reach the estimate, and what drives the overshoot is something else in the chain, locating it is the next task, and a fifth estimate before that diagnosis is not worth attempting.

#### Lemma L30, a small negative eigenspace forces a small support

Needed because the sharp stratum's members turn out to be paddings, and that is what lets a bound proved in low dimension govern every $n$.

**Statement.** Let $W\in\mathrm{Weyl}_n$ and set $U=\sum_{\lambda_\alpha<0}\mathop{\mathrm{im}}v_\alpha$, the sum over **all** negative eigenvectors read as skew matrices. If $\dim U<n$ then $W$ vanishes on $u\wedge u^\perp$ for every $u\perp U$, and $W$ is a padding of a $\mathrm{Weyl}_{\dim U}$ tensor with the same norm and the same $\theta$.

**The hypothesis is on $U$, not on a count of negative eigenvalues.** *An earlier form read "at most two negative eigenvalues" with $U$ built from two named eigenvectors. The three steps below use no such count, and the count cannot be carried loosely*: read as "at most two **distinct**", $\mathrm{pad}_{V_1}(W_{\mathbb{CP}^2})+\mathrm{pad}_{V_2}(W_{\mathbb{CP}^2})$ on $\mathbb R^8$ has one distinct negative eigenvalue of multiplicity four, satisfies the hypothesis and **breaks the conclusion**, $W(e_5\wedge e_6)\ne0$ at $e_5\perp U$. **And read as "at most", the one-negative case leaves $U$ built partly from an undetermined kernel eigenvector, so $\dim U$ is not a function of $W$.** *Both failures are of the counting form and neither touches the argument.*

**Proof.** $\mathrm{Ric}(W)(x,x)=\sum_\alpha\lambda_\alpha\lVert v_\alpha x\rVert^2$, so Ricci-flatness is exactly $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$, an identity among positive semidefinite matrices, in an eigenbasis orthonormal for the half-trace pairing. Hence the positive and negative sides are the same matrix; **its image is $U$**, and since a sum of positive multiples of $v^{\mathsf T}v$ has image the sum of the $\mathop{\mathrm{im}}v$, every eigenvector with nonzero eigenvalue has its image inside $U$. For $u\perp U$ this gives $v_\alpha u=0$ **for every $\alpha$ with $\lambda_\alpha\ne0$**, *it fails at a kernel eigenvector, as $\varphi_{9,10}$ shows at $u=e_9$ for padded $W_{\mathbb{CP}^2}$ in $\mathcal W_{10}$; at $u=e_5$ there is no failure, so the witness must name its $u$*, and those are the only $\alpha$ the sum reaches, so $W(u\wedge w)=0$ for every $w$. The restriction to $\Lambda^2(U)$ is Ricci-flat because the terms of $\mathrm{Ric}$ involving directions outside $U$ vanish with $W$. $\square$

**The norm-and-$\theta$ clause is [Lemma L164](#lemma-l164-padding-preserves-the-norm-and-theta-which-is-l30s-owed-clause), proved below.** *Four steps, of which only the sharp term needs $\Lambda^2U=\mathfrak{so}(U)$ to be a subalgebra (which is what this block's audit predicted), the others being a shared orthonormal basis, an index-range restriction of first Bianchi, and this proof's own last line.* **Step (iii) proves the operator identity $Q(\mathrm{pad}\,W')=\mathrm{pad}\,Q(W')$ outright, for every symmetric operator supported on $\Lambda^2U$** (which is everything $\mathrm{pad}$ produces), *and $\theta$ consumes only the scalar $\langle W,Q(W)\rangle$ from it.*

> **AND MEMBERSHIP IN $\mathrm{Weyl}_{\dim U}$ IS ARGUED ONLY THROUGH RICCI-FLATNESS.** *Pair symmetry and first Bianchi are inherited rather than shown, and the review this block was written from carried the sentence.*

**Scope.** The hypothesis is $\dim U<n$ and **not** a condition on the individual ranks: under a repeated negative eigenvalue those are not determined by $W$, and the rank-sum form fails to apply at padded $W_{\mathbb{CP}^2}$ for $n=6,7,8$, where the ranks are $4+4=8\ge n$ while $\dim U=4$ and the conclusion holds. **The window in which the rank-sum form has content is $n=5,6,7,8$**, at $n=4$ the $\Lambda^\pm$ splitting forces $\dim U=4=n$ for every $W\ne0$, so the hypothesis is unsatisfiable. *That window is the rank-sum form's, not the lemma's: **L30 itself is consumed at $n=12$**, where the hypothesis is met by other means.*

*Normalisation, inert here and not for a quantitative consumer.* The identity above is written with $\mathrm{Ric}(\mathrm{Id})=(n-1)$, while [conventions.md](conventions.md) tables $\mathrm{ric}(\mathrm{Id})=\tfrac{n-1}2\mathrm{id}$. **Flatness divides the constant out, so nothing here moves; a consumer reading a value off this identity would be out by a factor of two.**

#### Lemma L164, padding preserves the norm and $\theta$, which is [L30](#lemma-l30-a-small-negative-eigenspace-forces-a-small-support)'s owed clause

*Gate 2, [r739](../reviews/REVIEW_r739.md) and [r740](../reviews/REVIEW_r740.md) on identical briefs, **both PROVEN, hypotheses corrected and agreeing on all three repairs**: the missing $W\ne0$, the $\#$ factor, and a disclaimer refuted by the proof standing above it.*

> **THE GLOSS IS THE STATEMENT, AND WITHOUT IT THE LEMMA IS FALSE.** *"Vanishes on $u\wedge u^\perp$" read as a quadratic form rather than as annihilation admits $W^+=\mathrm{diag}(2,-1,-1)=-W^-$ in $\mathcal W_4$, which has $\lVert W\rVert^2=12$ and $W'=0$.* **The clause "so that $W$ is supported on $\Lambda^2U$" is the only thing separating the two readings**, and both reviewers built the witness independently.

> **THE HYPOTHESIS IS GEOMETRIC SUPPORT, WHICH IS STRICTLY STRONGER THAN SUPPORT ON A SUBALGEBRA.** *Step (iii) reads nothing about $\Lambda^2U$ beyond its being a subalgebra, and $\Lambda^+\cong\mathfrak{su}(2)$ is the boundary case where the two part company.* **Bianchi and Ricci-flatness are idle for all three displayed equalities** and buy the membership clause alone; the norm, $P$ and $\theta$ agree for any symmetric operator supported on $\Lambda^2U$. *And $U$ is not a function of $W$ (the admissible subspaces are up-closed above a minimal member) which is harmless because the statement holds at every one of them, that ambient-independence being its content.*

**Statement.** Let $W\in\mathcal W_n$ be nonzero and vanish on $u\wedge u^\perp$ for every $u\perp U$, so that $W$ is supported on $\Lambda^2U$. Then the restriction $W'=W|_{\Lambda^2U}$ lies in $\mathcal W_{\dim U}$, and

$$\lVert W'\rVert=\lVert W\rVert,\qquad P(W')=P(W),\qquad \theta(W')=\theta(W).$$

**$W\ne0$ is a branch of the quantifier, not an isolated point.** *At $\dim U\le3$ step (iv) gives $W'\in\mathcal W_{\dim U}=0$ and hence $W=0$ by (i), so $\theta=P/\lVert W\rVert^3$ reads $0/0$ on that whole branch.* **The two norms are defined together by (ii)**, so one clause on the statement covers it.

**Proof.** *Four steps, and the third is the only one that needs anything.*

**(i) The support.** $\Lambda^2\mathbb R^n=\Lambda^2U\oplus(U\otimes U^\perp)\oplus\Lambda^2U^\perp$, and the hypothesis kills $W$ on the last two summands. **$W$ is self-adjoint, so a kernel containing $(\Lambda^2U)^\perp$ makes $\Lambda^2U$ invariant** (the step is false for an operator that is merely supported there) and $W$ therefore maps $\Lambda^2U$ into itself and annihilates its complement.

**(ii) The norm.** The coordinate bivectors $\varphi_{ij}$ with $i<j$ in $U$ are orthonormal for the half-trace pairing **in $\Lambda^2U$ and in $\Lambda^2\mathbb R^n$ alike**, so $\Lambda^2U\hookrightarrow\Lambda^2\mathbb R^n$ is an isometry and $\lVert W'\rVert=\lVert W\rVert$ by (i).

**(iii) The two quadratic terms.** $W^2$ restricts because $W$ preserves $\Lambda^2U$ and kills its complement. For the sharp, $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$, **the $\tfrac12$ is the record's, and without it the formula returns $\mathrm{id}^\#=2(n-2)\mathrm{id}$ against the halved Böhm--Wilking product's $(n-2)\mathrm{id}$**, which is what $Q(\mathrm{id})=(n-1)\mathrm{id}$ on the round sphere pins. The index support is what this step reads, and the factor does not touch it: **the factors $W_{ce},W_{df}$ force $c,d,e,f\in\Lambda^2U$**, and then $c_{acd}=\langle[v_c,v_d],v_a\rangle$ forces $a\in[\Lambda^2U,\Lambda^2U]\subseteq\Lambda^2U$, **since $\Lambda^2U=\mathfrak{so}(U)$ is a subalgebra**. *The basis is adapted to the splitting, which the step needs and $O(n)$-equivariance supplies free*: in an unadapted basis $\langle[\varphi_{13},\varphi_{23}],(\varphi_{12}+\varphi_{14})/\sqrt2\rangle=-1/\sqrt2$ is a nonzero $c_{acd}$ with $c,d$ inside and $a$ outside. *So $W^\#$ is supported on $\Lambda^2U$ and its entries there are computed with $\mathfrak{so}(U)$'s own structure constants, which are $\mathfrak{so}(n)$'s restricted.* Hence $Q(W)$ is supported on $\Lambda^2U$ and restricts to $Q(W')$.

**(iv) Membership.** First Bianchi at indices in $U$ is a sub-family of first Bianchi on $\mathbb R^n$, so it is inherited; pair symmetry likewise; and Ricci-flatness of the restriction is [L30](#lemma-l30-a-small-negative-eigenspace-forces-a-small-support)'s own last line. So $W'\in\mathcal W_{\dim U}$.

Then $P(W')=\langle W',Q(W')\rangle=\langle W,Q(W)\rangle=P(W)$ by (i)–(iii), and $\theta=P/\lVert W\rVert^3$ follows from that and (ii). $\square$

> **WHAT THE ROUND EXPECTED AND WHY IT IS SHORTER.** *[ROUND_L30](../verification/ROUND_L30.md) named four obligations and observed that the Lie-subalgebra property reaches only one of them, the $\#$ term, which is right, and the other three turn out not to need it.* **The isometry is a statement about a shared orthonormal basis, Bianchi is inherited by restriction of an index range, and Ricci-flatness was already proved in L30 itself.** *What made the clause look hard is that it was stated as a property of "padding" in the abstract, where the object is a $W$ whose support L30 has already located.*

> **AND STEP (iii) DELIVERS THE OPERATOR IDENTITY, NOT ONLY THE SCALAR.** *$Q$ commutes with padding as an operator identity for every symmetric operator supported on $\Lambda^2U$*, which is the whole image of $\mathrm{pad}$; **what fails is commuting with RESTRICTION off the support**, where $W^\#$ picks up terms the restriction has discarded. *$\theta$ needs only the scalar $\langle W,Q(W)\rangle$, which is the weaker half of what (iii) gives.*

#### The padding reduction: the stratum at every $n$ collapses to one base case

**The diagnosis first.** Decomposing the chain at its own argmax ($a=b=0.4570$, $\lambda_1=0.7628$, total $1.226386$) settles which inequality carries the overshoot:

| term | value | what it uses |
|---|---|---|
| $\lambda_1p$ | $+0.444125$ | replaces $\sum_+\lambda^3$ |
| $-(a^3+b^3)$ | $-0.190937$ | exact |
| $\lambda_1(\sigma_2^2-p_2)$ | $+0.017176$ | pair cap on distinct positive triples |
| $6\lambda_1ab$ | $+0.956022$ | **pair cap on the one negative pair** |

**The $(+--)$ term is $78\%$ of the total**, and the $(+++)$ term (which several cycles were spent sharpening), contributes $1.4\%$. The overshoot lives in a single inequality, applied to a single pair.

**And that inequality being tight is what closes the case.** $(+--)$ is tight only at $\|[v_{N-1},v_N]\|^2=2$, which forces both eigenvectors to rank $4$ and hence a common kernel. Then, for $u$ in it, the negative part contributes nothing to the trace of $W$ on $u\wedge u^\perp$, the positive part is positive semidefinite there with zero trace, so $P_uWP_u=0$, and since $W_+\succeq0$, that upgrades to $WP_u=0$, verified at $4.8\times10^{-16}$ against $\|W\|=1$.

**Proposition (padding reduction).** Let $W\in\mathrm{Weyl}_n$ with $\|W\|=1$ have at most two negative eigenvalues whose ranks as skew matrices satisfy $r_1+r_2<n$. Then $W$ is supported on $\Lambda^2(u^\perp)$ for any $u$ in the common kernel, that is, **$W$ is the padding of some $W'\in\mathrm{Weyl}_{n-1}$**, with $\|W'\|=\|W\|$, $\theta(W')=\theta(W)$, and the same two negative eigenvectors. The restriction is Ricci-flat because the terms of $\mathrm{Ric}$ involving $u$ vanish with $W$.

**So the stratum at every $n>r_1+r_2$ reduces to $n=r_1+r_2$.** With the pair cap attained, both ranks are $4$ and the base case is $n=8$. The chain's own values show the descent is worth having: it overshoots by $0.128\%$ at $n=12$ and by $0.057\%$ at $n=8$, and closes outright at $n=5$ ($1.224740$ against $\sqrt{3/2}=1.224745$).

**And the base case does not exist, because at the cap the supports nest.** The reduction was supposed to bottom out where $\ker v_{N-1}\cap\ker v_N$ becomes trivial, which for two rank-$4$ matrices would be $n=8$. Ascending the bracket to its cap and measuring the principal cosines between $\mathrm{im}\,v_{N-1}$ and $\mathrm{im}\,v_N$ gives **all cosines equal to $1$** at $n=8,10,12$ (one support contains the other rather than meeting it transversally) and the common kernel is nonempty at each: dimension $2$, $6$, $7$. At $n=8$ the ranks come out $4$ and $6$, so the descent continues there too. **Those figures are of an ascent towards the cap rather than of the cap itself, and at the cap they are forbidden**: [Lemma L31](#lemma-l31-the-bracket-cap-characterised-canonical-statement-and-proof) forces **both** matrices to rank $4$ with equal images, which at $n=8$ would make the common kernel $4$-dimensional rather than the $2$ measured here. *A sentence recording that as a rank-tolerance artefact stood here before a refactor removed it, leaving a withdrawn number ten lines above its own refutation.* *Gate 2, [r544](../reviews/REVIEW_r544.md).*

**So the induction runs down to $n=r$, where $r$ is the larger support dimension.** The cap needs $r\ge4$, and at $n=4$ the answer is already known exactly: $P=9(\det W^++\det W^-)$ on $\mathrm{Weyl}_4$ gives $\max P=\sqrt{3/2}$, on record and proved. Where the descent bottoms at $r=6$ instead, the chain itself closes to within $10^{-5}$: $1.224756$ against $\sqrt{3/2}=1.224745$ at $n=6$, and $1.224740$ (under), at $n=5$.

**And most of that statement is elementary.** With $\langle X,X\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}X)=1$ the singular values of a skew $X$ come in pairs $s_1,s_1,s_2,s_2,\dots$ with $\sum_is_i^2=1$. *An earlier version argued from $\|[X,Y]\|^2\le4s_1^2$ that the cap forces $s_1^2\ge\tfrac12$ and hence rank $4$; that is a **non-sequitur** (Reviewer 58), the profiles $s^2=(0.5,0.3,0.2)$ and $(0.6,0.3,0.1)$ satisfy both at rank $6$, and $4s_1^2$ reads $4$ at rank $2$ against a true maximum of $1$.* The correct statement comes from the root system: $\mathrm{ad}_X$ has eigenvalues $i(\pm s_i\pm s_j)$ and $i(\pm s_i)$, so

$$\max_{\|Y\|=1}\|[X,Y]\|^2=(s_1+s_2)^2\quad\textbf{exactly},$$

verified to twelve digits on seven profiles. Maximising $(s_1+s_2)^2$ subject to $\sum_is_i^2=1$ gives $2$ by Cauchy–Schwarz, with equality **only** at $s_1=s_2=1/\sqrt2$ and the rest zero, **rank exactly $4$**. Symmetric in $X$ and $Y$, so both. Measured at the ascent's optimum, the singular values are $(0.707107,0.707107,0.707107,0.707107,0,\dots)$ for both, at $n=8,10,12$ alike.

**And the equality case is fully determined.** $\|[X,Y]\|_F\le\|XY\|_F+\|YX\|_F=2\|XY\|_F\le2\|X\|_{\rm op}\|Y\|_F$, so the cap needs equality in both steps. Equality in $\|XY\|_F\le\|X\|_{\rm op}\|Y\|_F$ puts the columns of $Y$ in $X$'s top singular subspace, which is all of $\mathrm{im}\,X$ since the nonzero singular values are equal, so $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$, and symmetrically **$\mathrm{im}\,X=\mathrm{im}\,Y$**. Equality in the triangle step, with $\|XY\|_F=\|YX\|_F$, forces $XY=-YX$: **$X$ and $Y$ anticommute.** Measured at the optimum: $\|XY+YX\|_F=1.1\times10^{-8}$, $\|XY\|_F=\|X\|_{\rm op}\|Y\|_F=1$ exactly, and $\|P_{\mathrm{im}X}-P_{\mathrm{im}Y}\|_F=3.3\times10^{-13}$.

**Consequence, and it is stronger than a descent.** The PSD identity $\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha=0$ says the positive and negative sides are the *same* matrix. At the cap $\mathrm{im}\,v_{N-1}=\mathrm{im}\,v_N$ of dimension $4$, so the negative side has rank at most $4$, hence so does the positive side, and **every positive eigenvector's image lies in that same $4$-plane**. So all of $W$ is supported on $\Lambda^2$ of a fixed $4$-plane:

> **At the bracket cap, $W$ is a padded $\mathrm{Weyl}_4$ element**, whatever $n$ and whatever the number of positive eigenvalues, and $\max_{\mathrm{Weyl}_4}\theta=\sqrt{3/2}$ is proved on record.

Measured: rank of the positive side $=$ rank of the negative side $=4$ at $n=8,10,12$, the two sides agreeing to $10^{-15}$, while the individual negative ranks sum to $8$, the gap between $8$ and $4$ being exactly the image equality the cap forces. **The exact-cap case is therefore closed in three lines**, with no descent and no induction; the earlier route through $\ker X=\ker Y$ and repeated padding reached the same place the long way.

**What is left is a window, not a region.** Writing $\delta=2-\|[v_{N-1},v_N]\|^2$, the chain with the deficit carried explicitly closes for every $\delta\ge0.005$, $1.223893$ at $n=12$ and $1.224565$ at $n=20$, both under $\sqrt{3/2}$, and it overshoots only at $\delta$ below that. The two ends are done: $\delta=0$ by the descent above, $\delta\ge0.005$ by the chain. **The gap is the bridge across $0<\delta<0.005$**, which is what the perturbative statement $\epsilon_{\min}\le\frac2n\delta$ is for, an approximate common kernel giving an approximate padding. The threshold grows with $n$, so that dependence needs stating rather than assuming.

**And the window is narrower than that, because a second condition has to hold at the same time.** The chain's argmax sits with $\lambda_1$ at the cap $\min(\sigma,\sqrt p)$, and there it is $\sqrt p$, so $p_2=p-\lambda_1^2\to0$ while $\sigma_2>0$, which needs many positive eigenvalues. **Lemma L29 already closes $k\le2$ outright.** So the three arguments cover complementary regions:

| region | closed by |
|---|---|
| $k\le2$ positive eigenvalues | Lemma L29, dimension-free |
| $\delta=0$ (bracket at the cap) | anticommutation, equal supports, padding descent to $n=4$ |
| $\delta\ge0.005$ | the chain, carrying the deficit |
| **$k\ge3$ and $0<\delta<0.005$** | **open** |

What remains is that single intersection, and it is where the perturbative padding has to work: many positive eigenvalues of vanishing mass, with the bracket just short of its cap. An additive perturbation bound does not suffice there (it would give $\sqrt{3/2}+O(\delta)$ against a target of $\sqrt{3/2}$) so the error must be absorbed into the descent rather than added after it.

**And it can be, to first order, because $Q$ commutes with padding.** Write $W=\mathrm{pad}+E$ with $E$ supported on $u\wedge u^\perp$. Since padding a Weyl tensor gives a Weyl tensor and $Q$ commutes with the operation, $Q(\mathrm{pad})$ is itself supported on $\Lambda^2(u^\perp)$, hence **orthogonal to $E$**, so the first-order term $3\langle E,Q(\mathrm{pad})\rangle$ **vanishes identically**, measured at $10^{-17}$ across trials. Therefore

$$\theta(W)=\theta(\widehat{\mathrm{pad}})+C\,\|E\|^2+O(\|E\|^3),$$

with $C$ stable across $\|E\|$, measured at $-0.211$, $-0.113$ and $+0.010$ on three random paddings at $n=8$, each constant to three digits as $\|E\|$ shrinks by a decade. **The additive error is quadratic, not linear**, and with $\|E\|=O(\delta)$ that is $O(\delta^2)$.

**And the sign of $C$ is an eigenvalue bound, which holds with equality.** For $E\perp\mathrm{pad}$ of unit norm, expanding the normalised $\theta$ gives

$$C=3\langle E,L_{\mathrm{pad}}E\rangle-\tfrac32\theta_{\mathrm{pad}},\qquad\text{so}\qquad C\le0\iff\langle E,L_eE\rangle\le\tfrac12 ,$$

with $e=\mathrm{pad}/\theta_{\mathrm{pad}}$, **precisely Lemma L24's bound $\sigma(L_e|_{e^\perp})\subseteq(-\infty,\tfrac12]$**, restricted to the directions that leave the padding rather than to all of $e^\perp$. Computed on exactly that subspace at padded $W_{\mathbb{CP}^2}$:

| $n$ | directions leaving the padding | $\lambda_{\max}(L_e)$ there |
|---|---|---|
| 8 | 132 of 300 | $0.500000$ |
| 10 | 275 of 770 | $0.500000$ |
| 12 | 494 of 1638 | $0.500000$ |

**Exactly $\tfrac12$, at every dimension, and that is a property of the maximiser, not of the stratum.** *Item (iii) is refuted* (Reviewer 58). Computing $\lambda_{\max}(L_e)$ on the padding-leaving directions across the one-parameter stratum family gives $C=0$ **only** at $q=r$ and $C>0$ everywhere else: $0.524$ at $r/q=0.7$, $0.594$ at $0.5$, $0.670$ at $0.4$, $0.809$ at $0.3$, $1.416$ at $(q,r)=(2,0.3)$, $2.046$ at $0.1$, against the threshold $\tfrac12$. The recorded $0.500000$ is recovered exactly at $q=r$, which cross-validates the computation and identifies what produces it: **being the maximiser, not having a two-dimensional negative eigenspace.** So $\dim\mathfrak m\le2$ is not sufficient for $C\le0$, and **no proof from that hypothesis alone can exist.**

**And the reduction is the weaker of the two forms, so it is withdrawn as the vehicle.** $\lambda_{\max}(\mathring R_e)\le1$ fails below $\theta=0.6383\,\sqrt{3/2}$, while $2b\Sigma\le\theta$ fails already below $0.8607\,\sqrt{3/2}$ (the exact root of $4q^2-5qr-5r^2$) so the reduction discards a band in which the statement it replaces is still true. Three independent routes agree to nine digits. The programme's hedge that $C\le0$ is wanted only *near the top* survives, but "near" must now mean $\theta>0.6383\,\sqrt{3/2}$ at the very least, and $2b\Sigma$ cannot deliver even that.

**But it is not a general fact about paddings, and the stratum hypothesis is what carries it.** At padded $S^3\times S^3$ the same computation returns $\lambda_{\max}=0.600000$ on the padding-leaving directions, at $n=8$ and $n=10$ alike, **above $\tfrac12$**. That point has nine negative eigenvalues, so it lies outside the $\dim\mathfrak m\le2$ stratum and is no counterexample to what the argument needs; what it refutes is the tempting general form. The spectra also differ in shape: padded $W_{\mathbb{CP}^2}$ carries $-\tfrac16$ with multiplicity $15$ and $20$ and a large kernel, while padded $S^3\times S^3$ carries $\pm\tfrac14$, $\pm\tfrac1{10}$ and $-\tfrac3{20}$ in blocks. **So item (iii) has to be proved from $\dim\mathfrak m\le2$, not from paddedness**, and that it fails without the hypothesis is worth knowing before the attempt.

**And the violation is localised to one block, where $L_e$ has a special form.** Split the padding-leaving directions by how $E$ acts: block (a) maps $u\wedge u^\perp$ into itself, block (b) is the cross terms with $\Lambda^2(u^\perp)$. On block (a) the matrix part of $\circ$ **vanishes identically** ($e$ annihilates $u\wedge u^\perp$ and preserves $\Lambda^2(u^\perp)$, so $eE=Ee=0$), leaving $L_eE=\mathrm{sharp\_bilin}(e,E)$, purely the $\#$-bilinear part. At $n=8$:

| point | block (a), dim 27 | block (b), dim 105 |
|---|---|---|
| padded $W_{\mathbb{CP}^2}$ | $+0.333333$ | $+0.462528$ |
| padded $S^3\times S^3$ | $\mathbf{+0.600000}$ | $+0.572912$ |

**The $0.6$ lives in block (a)**, and that block is a classical operator. Under $u\wedge w\leftrightarrow w$, block (a) of $L_e$ is **exactly $\tfrac12\mathring R_e$**, where $(\mathring Rh)_{ij}=\sum_{k,l}e_{ikjl}h_{kl}$ is the curvature action on symmetric $2$-tensors, matched to $2.7\times10^{-16}$ with the constant $\tfrac12$ pinned, block leakage exactly $0$, and a third route through $\max_{\text{frames}}\lambda_{\max}(K)$ agreeing to nine digits. **One joint is unaudited** (Reviewer 58): the space of symmetric operators supported on $u\wedge u^\perp$ meets $\mathrm{Weyl}_n$ only in $\{0\}$, measured at $n=6,8$, so the passage from this identity to the Weyl-constrained $27$-dimensional block (a) is a step neither reviewer reproduced. And $\Sigma$'s role in the $2b\Sigma$ bound is **bookkeeping rather than geometry**: the derivation bounds $\sum_b|K_{ab}|$ over *all* negative eigenvectors and $\Sigma$ names only two, the full-sum version holding at every sphere product tried. So

$$\langle E,L_eE\rangle\le\tfrac12\ \text{on block (a)}\iff\lambda_{\max}\big(\mathring R_e\big)\le1 ,$$

on trace-free symmetric $2$-tensors, with $e=W/\theta$. That reads $2/3$ at padded $W_{\mathbb{CP}^2}$ and $1.2$ at padded $S^3\times S^3$, reproducing the $1/3$ and $0.6$ above, **the factor of two being the equivalence itself**, $\langle E,L_eE\rangle=\tfrac12\lambda_{\max}(\mathring R_e)$, so both pairs are one identity rather than two agreements. **And the $\mathbb{CP}^m$ column has a closed form**: $\lambda_{\max}(\mathring R)/\theta=\frac{3m}{(m+1)(2m-1)}$, giving $\tfrac23$, $\tfrac9{20}$ and $\tfrac{12}{35}$ at $m=2,3,4$, so the padded competitor and the two $\mathbb{CP}^m$ entries are one function at consecutive $m$, decreasing and below $1$ throughout ([SecondKindRatio.lean](../lean/HamiltonsCubic/Results/SecondKindRatio.lean)).

**Index order, settled, and this page is written in the OTHER one.** The $(\mathring Rh)_{ij}=\sum_{k,l}e_{ikjl}h_{kl}$ above is [Bourguignon–Karcher's](../references/bourguignon-karcher-1978-pinching/notes.md) §2.2(ii), p. 74: $\mathring R(h)(a,b)=\sum_{i,j}R(e_i,a,e_j,b)h(e_i,e_j)$, contracted on slots 1 and 3. The record standardises on Li's $iklj$ ([conventions.md](conventions.md)), and the two differ by an overall sign, so $\mathring R_e=-\mathring W_e$. **Everything on this page is correct as written, read in the BK order.** Two closed-form checks fix the dictionary: $\lambda_{\max}(\mathring R)=0.816497=\sqrt{2/3}$ at padded $W_{\mathbb{CP}^2}$, and the ratio $0.4500$ at $\mathbb{CP}^3$, are exactly $\mu$ and $\mu/\theta$ of [target.md](target.md), where $\mu=-\lambda_{\min}(\mathring W)$ in Li's order. **Converting this page changes result statements (item (iii) becomes the lower bound $\lambda_1(\mathring W_e)\ge-1$) so the rewrite belongs to a verification round rather than to a convention repair.** One consequence to carry into it: the paragraph headed *"The literature bounds the other end"* below is an artefact of the order, since in Li's convention item (iii) is a lower bound on $\lambda_1(\mathring R)$, which is the direction the field studies.

**This is the curvature operator of the second kind**, and the project already holds the relevant source: [Li 2024, sphere theorems for the second kind](../references/li-2024-sphere-theorems-second-kind/). **But the stored source bounds the wrong end.** Li's conditions $\mathring R\in C(\alpha,\theta)$ bound the *smallest* eigenvalues from below and drive sphere theorems; item (iii) needs an **upper** bound on the largest. Its eigenvalue count $(n-1)(n+2)/2$ is the one the programme reproduces ($27$ for the block on $\mathbb R^7$ at $n=8$) and its example spectra are usable as checks, so the source is now transcribed in [notes.md](../references/li-2024-sphere-theorems-second-kind/notes.md) rather than left as a bare PDF.

**Measured, the ratio $\lambda_{\max}(\mathring R_W)/\theta$ splits the catalogue by diagonality rather than by the negative count**: $1.2000$ at $S^3\times S^3$ and $1.3009$ at the $C_5$ blow-up, both coordinate-diagonal and both **over** $1$; against $0.4500=\tfrac9{20}$ at $\mathbb{CP}^3$, $0.3429=\tfrac{12}{35}$ at $\mathbb{CP}^4$ and $2/3$ at padded $W_{\mathbb{CP}^2}$, all non-diagonal and comfortably under. Only the last of the five is in the $\dim\mathfrak m\le2$ stratum ($\dim\mathfrak m$ is $9$, $20$, $6$ and $12$ at the others) so **one stratum data point is all this is**, and the apparent split by diagonality is a four-point pattern, not a finding.

**The literature bounds the other end, and that is worth recording so it is not searched again.** A sweep of the second-kind literature finds it uniformly concerned with *lower* bounds on $\lambda_1(\mathring R)$, driving sphere and rigidity theorems: Li's $C(\alpha,\theta)$ conditions, and [Einstein manifolds of negative lower bounds on the curvature operator of the second kind](https://arxiv.org/abs/2411.13912), whose result is that $\lambda_1\ge-\theta(n)\bar\lambda$ forces flat or round. **Those bounds are hypotheses of global theorems, and their normaliser vanishes on $\mathrm{Weyl}_n$**: each condition is normalised against the mean $\bar\lambda$ of the second-kind spectrum, and $\mathrm{Scal}=n(n-1)\bar\lambda$ on an Einstein manifold ([Cheng–Wang, Proposition 2.1](../references/cheng-wang-2024-negative-lower-bound-second-kind/notes.md)), which is $0$ for a Weyl tensor, so none of them concludes anything about $\lambda_{\max}$ there. So item (iii) has to be derived, from $\dim\mathfrak m\le2$, rather than cited.

**Reduced to a matrix, it is nearly elementary.** For $h$ symmetric with eigenvalues $\mu$ in an orthonormal frame $\{e_a\}$,

$$\langle\mathring Rh,h\rangle=\sum_{a\ne b}\mu_a\mu_b\,K_{ab},\qquad K_{ab}=\langle W(e_a\wedge e_b),e_a\wedge e_b\rangle,$$

so $\lambda_{\max}(\mathring R_W)=\max_{\text{frames}}\lambda_{\max}(K)$. That $K$ is symmetric with zero diagonal, and **its row sums vanish because $W$ is Ricci-flat**, $\sum_bK_{ab}=\mathrm{Ric}(e_a,e_a)$, checked at $10^{-16}$. It is exactly the "diagonal Weyl" shape the census used.

**And its norm is twice the coordinate-diagonal mass of $W$**: the $e_a\wedge e_b$ are orthonormal, so $\|K\|_F^2=2\sum_{a<b}K_{ab}^2\le2\|W\|^2=2$, with equality exactly when $W$ is coordinate-diagonal. Measured: $2.0000$ at $S^3\times S^3$ (diagonal), against $0.7500$ at $\mathbb{CP}^3$ and $0.6000$ at $\mathbb{CP}^4$. **That is the mechanism behind the apparent diagonality split**, which is therefore not a coincidence of four points.

Since $\lambda_{\max}(K)\le\sqrt{\tfrac{m-1}{m}\|K\|_F^2}$ for a trace-free symmetric $K$, the criterion becomes

$$\lambda_{\max}(\mathring R_W)\le\sqrt{2\cdot(\text{coordinate-diagonal mass of }W)} .$$

At padded $W_{\mathbb{CP}^2}$ the off-diagonal mass is $1/\sqrt2$, so the diagonal mass is $\tfrac12$ and the bound is $\le1<\theta=\sqrt{3/2}$, **item (iii) closes there by this route alone**. What it now needs is a lower bound on the off-diagonal mass across the $\dim\mathfrak m\le2$ stratum.

**The coordinate-diagonal half of the stratum closes outright, by a counting argument.** A diagonal $W$ is a symmetric $w$ with zero diagonal and (by Ricci-flatness), zero row sums, and its negative eigenvalues are its negative entries. Every coordinate in the support has a nonzero row, which must carry a negative entry or its row sum would be positive; so **the negative edges cover the support**. At most two negative eigenvalues means at most two edges, covering at most four coordinates:

> **A coordinate-diagonal Weyl tensor with at most two negative eigenvalues is a padding of a $\mathrm{Weyl}_4$ tensor**, hence $\theta\le\max_{\mathrm{Weyl}_4}\theta=\sqrt{3/2}$, which is proved on record.

An exhaustive LP sweep over sign patterns confirms it at $n=5,6,7,8$: every feasible $w$ has support exactly $\{0,1,2,3\}$, size $4$. **And routing through $\max_{\mathrm{Weyl}_4}\theta$ is very lossy**: on this stratum $\max\theta=\mathbf0$, not $\sqrt{3/2}$ (Reviewer 58), in dimension $4$ a diagonal Weyl tensor is $w_{12}=w_{34}=p$, $w_{13}=w_{24}=q$, $w_{14}=w_{23}=r$ with $p+q+r=0$ and every eigenvalue doubled, so at most two negative eigenvalues permits only one negative value among $p,q,r$, and a $401^2$ grid maxes at $0.000000000$.

**And the non-diagonal part reduces to a two-variable inequality, by bounding $K$'s rows through the negative eigenspace.** Since $K_{ab}\ge-b\,\|P_{\mathfrak m}(e_a\wedge e_b)\|^2$ and the row sums vanish, $\sum_b|K_{ab}|=2\sum_bK_{ab}^-\le2b\,\|P_{\mathfrak m}(e_a\wedge\cdot)\|^2$. That last factor is $\sum_k\|v_ke_a\|^2\le\Sigma:=s_1(v_{N-1})^2+s_1(v_N)^2$, so by Gershgorin

$$\lambda_{\max}\big(\mathring R_W\big)\le2b\,\Sigma,\qquad \Sigma\le2,$$

with $\Sigma=1$ exactly when both negative eigenvectors are rank $4$ with equal singular values, the configuration the bracket cap forces. **The bound is exactly tight at padded $W_{\mathbb{CP}^2}$**: $2b\Sigma=0.816497=\lambda_{\max}(\mathring R)$ at $n=6,8,10,12$ alike, against $\theta=\sqrt{3/2}$, a $50\%$ margin since $b=\theta/3$ and $\Sigma=1$ there.

**The hypothesis is load-bearing and visibly so.** Applied where $\dim\mathfrak m>2$ the bound fails, as it must: $4b=0.8433$ against a true $1.2649$ at $S^3\times S^3$ ($\dim\mathfrak m=9$), and similarly at $S^6\times S^6$ and $S^4\times S^8$.

So item (iii) is now the inequality $2b\,\Sigma\le\theta$ over the stratum, two scalars against one, all three computable from the spectrum and the negative eigenvectors' singular values.

**And it is not needed everywhere.** $C\le0$ enters only through $\theta(W)=\theta(\widehat{\mathrm{pad}})+C\|E\|^2$, whose conclusion $\theta(W)\le\sqrt{3/2}$ is wanted only where $\theta(\widehat{\mathrm{pad}})$ is already near $\sqrt{3/2}$: if the padding sits well below the target, a positive $C$ of size $O(\delta^2)$ cannot carry $W$ above it. So the inequality is owed **near the top of the stratum**, not across all of it, where $b\Sigma\le\theta/2\approx0.61$ against $b=0.408$, $\Sigma=1$ at padded $W_{\mathbb{CP}^2}$, a margin of a third. Stating the quantifier that way is what keeps the last step from being harder than the theorem. The blocks are not $L_e$-invariant, the full subspace reaches $0.5$ at padded $W_{\mathbb{CP}^2}$ while neither block does, so the bound is about the mixing as well, but the obstruction to a general proof is block (a). ([b_two_negative_stratum.py](../scripts/route-b/b_two_negative_stratum.py))

#### Lemma L34, full support with two negative eigenvalues, at $m=6$ and $m=8$, canonical statement and proof


Needed because item B0's descent had been recorded as closing once *no* $\mathrm{Weyl}_m$ element with at
most two negative eigenvalues has full support, a statement stronger than Lemma L33 settles, and one whose
claimed equivalence to the rank-3 question holds only at a single positive eigenvalue.

**Statement.** For $m=6$ and $m=8$ there is a $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues and
$\dim U=m$, where $U=\mathrm{im}\,v_{N-1}+\mathrm{im}\,v_N$.

**Construction, with the hypotheses it needs.** Take $q=r>0$ and pad two copies of $W_4(q,r)$ onto 4-planes of $\mathbb R^m$, then add. *Both $q,r>0$ and $q=r$ are load-bearing and neither was stated: $W_4(2,-1)$ has signature $(1,2)$, so two such copies give **four** negative eigenvalues, and the displayed spectra below need the equality.* Trace-freeness and the first Bianchi identity are both linear, so the sum lies in $\mathrm{Weyl}_m$ whatever the planes do, **once each padded summand is checked to lie there**, [conventions.md](conventions.md)'s padding bullet covers $Q$, the norm and $\theta$, and not membership.

**The negative count is two by subadditivity of inertia**, $n_-(A+B)\le n_-(A)+n_-(B)$, with the lower bound coming from the exhibited spectra. *The clause that stood here (that each summand contributes exactly one negative eigenvalue), is false at the $m=6$ witness, where each summand carries $-2$ while the sum carries $-3$ and $-1$ at $x\pm y$, so neither value nor either eigenvector belongs to a summand.* **And the support is contained in the union of the planes rather than equal to it**: at $m=6$, $\mathop{\mathrm{im}}v_{N-1}=\langle e_1,e_2,e_3,e_4\rangle$ lies in neither plane, and $\dim U=6$ holds because $v_N=\tfrac1{\sqrt6}(E_{12}+E_{34}+2E_{56})$ has rank $6$ on its own. **$\dim U=m$ is a per-witness computation at each of the two dimensions.**

**Orthogonal complementary planes at $m=8$** give spectrum $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$, $\lVert W\rVert^2=12$, $P=-36$ and $\theta=-\sqrt3/2$, with $\dim U=8$ for every choice from the degenerate eigenplane. **Planes meeting in a 2-plane at $m=6$**, in the alignment $\langle e_1,e_2,e_5,e_6\rangle$ and $\langle e_3,e_4,e_5,e_6\rangle$, give $(-3,-1,1,1,1,1)/\sqrt{14}$, $\lVert W\rVert^2=14$, $\mathop{\mathrm{tr}}W^3=-24$, $\langle W,W^\#\rangle=-30$, $P=-54$ and

$$\theta=-\frac{27}{7\sqrt{14}}=-\frac{27\sqrt{14}}{98}=-1.0308648\ldots$$

**The alignment is a hypothesis and not a consequence of the planes.** *Three inequivalent alignments of the same two planes give three different spectra, one of them $\{-2,(-1\pm\sqrt7)/2,1,1,1\}$*, so *"planes meeting in a 2-plane give $(-3,-1,\dots)$"* holds for the alignment named and not as a universal. **The same construction covers odd $m=7$ unchanged**, which the statement omits. $\square$

**What the construction cannot reach, and it is a proof rather than an admission.** Two 4-planes span at most eight dimensions, so $U\subseteq V_1+V_2$ caps the family at $m\le8$: **there is no extension to $m\ge10$ to be found**, and the $m\ge10$ case rests on the structured convex screen alone. *That is the dimension range the stratum argument needed.*

**$\mathop{\mathrm{tr}}W^\#=-\lVert W\rVert^2$ at both witnesses, and it is an identity at every element of $\mathrm{Weyl}_m$**, so recovering it distinguishes no object from any other. *[INDEX-results.md](INDEX-results.md) credited an earlier Gate 2 pair with recovering it as though it were evidence for these witnesses.* The control that does bite is Ricci-flatness, verified at $m=6$ coefficient by coefficient as $\sum_\alpha\lambda_\alpha u_\alpha u_\alpha^{\mathsf T}=0$.

**Why the recorded equivalence fails.** With one positive eigenvalue, Ricci-flatness forces
$U=\mathrm{im}\,v_1$, so full support means a nondegenerate eigenvector and Lemma L33 applies. With several
positive eigenvalues it reads
$\sum_{\lambda_\alpha>0}\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}=b\,yy^{\mathsf T}+c\,zz^{\mathsf T}$
and constrains no rank at all. That is the gap the witnesses occupy. **The citation of [Lemma L33](#lemma-l33-one-eigenvalue-of-one-sign-forces-the-tensor-to-vanish-canonical-statement-and-proof) needs $m\ge6$**: at $m=4$ a full-rank eigenvector *is* a complex structure, and $-W_4(q,r)$ is the counterexample.

**What it does not reach, stated plainly.** These witnesses do **not** all carry $\theta\le0$: $P$ is cubic and
additive only over Frobenius-orthogonal supports, so 4-planes in general position keep the cross term and
reach $\theta=+0.485408612$ at $m=6$ and $+0.115574271$ at $m=8$. **Both are measured rather than derived, and so is [isotropy-cap.md](isotropy-cap.md)'s $+0.6259$**, *which is not in conflict with them: it is the maximum of random general-position draws over this same $m=6$ family, where $+0.485408612$ is one exhibited member, so a sample maximum above an exhibited witness is what the two figures should show.* **What the family's supremum is remains a hypothesis debt**, and no figure here is a derivation. And two 4-planes span at most eight
dimensions, so the construction is silent at $m\ge10$, where a structured convex screen finds every rank class
infeasible and a one-parameter deformation shows the margin reaching zero only where the support degenerates.
**The consequence for B0 is that $\sup\theta\le\sqrt{3/2}$ on that stratum was unproved when this was written, and is **closed** by [Lemma L35](#lemma-l35-at-most-two-negative-eigenvalues-caps-theta-at-sqrt32-unconditionally) below rather than
differently proved**, the descent was its proof. Nothing found contradicts it, and both reviewers measured
$\sup\theta=\sqrt{3/2}$ exactly at $m=6,8,10,12$, attained at $\dim U=4$ on the padded family.

#### Lemma L31, the bracket cap, characterised, canonical statement and proof


Needed because the sharp stratum's one inequality is the pair cap, and knowing exactly when it is attained
converts that estimate into an identity.

**Statement, in two parts.** For **unit** $X,Y\in\mathfrak{so}(n)$:

$$\lVert[X,Y]\rVert^2\ \le\ 2,$$

**with equality if and only if** $XY=-YX$, both $X$ and $Y$ have rank $4$ with all **nonzero** singular values equal to $1/\sqrt2$, and $\mathrm{im}\,X=\mathrm{im}\,Y$.

**The cap is the half the consumers cite**, [conventions.md](conventions.md) and seven sites read L31 for $\lVert[X,Y]\rVert^2\le2$, *and it stood in the proof and not in the statement.* **Orthogonality is not a hypothesis**: the forward direction consumes only $\lVert X\rVert=\lVert Y\rVert=1$, and $XY=-YX$ gives $\mathop{\mathrm{tr}}(XY)=0$ by itself, so orthogonality is a **consequence** of the equality case rather than an input to it. *The rank is derived for $X$ and follows for $Y$ by the symmetry of the bracket in its two arguments.*

**The norm is this record's**, $\lVert Z\rVert^2=\tfrac12\mathop{\mathrm{tr}}(Z^{\mathsf T}Z)$, so $\sum_is_i^2=1$ is exactly $\lVert X\rVert=1$ and $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$. **That conversion is load-bearing in the chain below and was never written**: read in plain Frobenius the chain contradicts its own hypothesis. *The constant $2$ rests on this normalisation and on nothing else, and is pinned independently by [Lemma L29](#lemma-l29-one-positive-and-two-negative-eigenvalues-cap-theta-at-sqrt32-canonical-statement-and-proof) returning $\sqrt{3/2}$ at $(2,-1,-1)/\sqrt6$.*

**Proof.** The roots of $\mathfrak{so}(n)$ give $\mathrm{ad}_X$ the eigenvalues $i(\pm s_i\pm s_j)$, together with $i(\pm s_i)$ **at odd $n$ alone**, for the angles $s_i\ge s_2\ge\cdots$ of $X$ in a Cartan subalgebra containing it. $\mathrm{ad}_X$ is skew-adjoint for the Ad-invariant pairing, hence normal, so $\max_{\|Y\|=1}\|[X,Y]\|^2$ **is** its squared operator norm, $=(s_1+s_2)^2$ exactly, attained at a real admissible $Y$ automatically orthogonal to $X$, *the short roots are dominated, $s_1\le s_1+s_2$.* **The display is false at $n=2$, where $\mathrm{ad}_X\equiv0$**, and vacuous there, no orthonormal pair existing below $n=4$. With
$\sum_is_i^2=1$, Cauchy–Schwarz gives $(s_1+s_2)^2\le2$ with equality only at $s_1=s_2=1/\sqrt2$ and the
rest zero, rank exactly $4$. Equality in $\|[X,Y]\|_F\le\|XY\|_F+\|YX\|_F\le2\|X\|_{\rm op}\|Y\|_F$ then
forces the columns of $Y$ into $X$'s top singular subspace, which is all of $\mathrm{im}\,X$ since the
nonzero singular values coincide, so $\mathrm{im}\,Y\subseteq\mathrm{im}\,X$ and symmetrically; and the
triangle step with $\|XY\|_F=\|YX\|_F$ forces $XY=-YX$. Conversely, $X^2=Y^2=-P_V/2$ and $[X,Y]=2XY$ give
$\|[X,Y]\|^2=\mathop{\mathrm{tr}}(Y^{\mathsf T}Y)=2$. $\square$

**A correction carried into the statement.** An earlier derivation argued from $\|[X,Y]\|^2\le4s_1^2$ that
the cap forces rank $4$; that step is invalid, $s^2=(0.5,0.3,0.2)$ satisfies $s_1^2\ge\tfrac12$ at rank
$6$, and the root-system identity replaces it, **excluding that spectrum exactly**, since $(s_1+s_2)^2\le2(s_1^2+s_2^2)=\tfrac85<2$. *The replacement works because it is an identity where $4s_1^2$ was slack.*

**The equality set is non-empty, and no condition in it is droppable.** At $n=4$, $X=\tfrac1{\sqrt2}(\varphi_{12}+\varphi_{34})$ and $Y=\tfrac1{\sqrt2}(\varphi_{13}-\varphi_{24})$ give $[X,Y]=-(\varphi_{23}+\varphi_{14})=2XY$ with $\lVert[X,Y]\rVert^2=2$, and every $n\ge4$ follows by padding. **Three closed-form near-misses, one per condition**: a commuting pair at $n=4$ brackets to $0$; two disjoint $4$-blocks at $n=8$, which fail $\mathrm{im}\,X=\mathrm{im}\,Y$, bracket to $0$; and scaled complex structures on $\mathbb R^8$, which fail the singular-value clause, bracket to $1$. *The block asserted the conditions were independent and exhibited none of this.*

#### The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three named items

The target is $\theta\le\sqrt{3/2}$ for every $W\in\mathrm{Weyl}_n$ of unit norm with at most two negative eigenvalues, which excludes route R9s sharpest competitor at every $n\ge12$ without any enumeration. Four regions, each with its own mechanism, and the whole of the stratum is covered:

| region | mechanism | status |
|---|---|---|
| $k\le2$ positive eigenvalues | three sign-blocks of the cubic vanish structurally; the pair cap bounds the fourth; trace-freeness collapses it to $f(t)=9\sqrt2\,t(t+1)/(4(t^2+t+1)^{3/2})$, maximised at $t=1$ | **proved** (Lemma L29) |
| $k\ge3$, deficit $\delta\ge0.005$ | the chain with the deficit carried explicitly: $1.223893$ at $n=12$, $1.224565$ at $n=20$ | proved **modulo a numerical maximisation** |
| $k\ge3$, $\delta=0$ | cap $\Rightarrow$ $XY=-YX$, rank $4$, $\mathop{\mathrm{im}}X=\mathop{\mathrm{im}}Y$ $\Rightarrow$ $\ker X=\ker Y$ of dimension $n-4$ $\Rightarrow$ padding descent to $n=4$, where $\max\theta=\sqrt{3/2}$ | **proved** |
| $k\ge3$, $0<\delta<0.005$ | $W=\mathrm{pad}+E$; first order vanishes since $Q$ commutes with padding; $C\le0\iff\langle E,L_eE\rangle\le\tfrac12$, which holds with equality | proved **at padded $W_{\mathbb{CP}^2}$** |

**The three items owed, stated exactly**, *and [Lemma L35](#lemma-l35-at-most-two-negative-eigenvalues-caps-theta-at-sqrt32-unconditionally) below supersedes them, closing the stratum directly rather than by the descent this assembly was built for. Kept for the record of what the route needed.*

1. The second region's maximisation is a grid computation, not a symbolic one. Its margin is $9\times10^{-4}$ at $n=12$ and $1.8\times10^{-4}$ at $n=20$, and the threshold $\delta_*$ grows with $n$, so the $n$-dependence has to be derived rather than sampled.
2. $\|E\|=O(\delta)$ rests on $\epsilon_{\min}\le\frac2n\big(2-\|[X,Y]\|^2\big)$, whose two endpoints are proved and whose monotonicity in between is measured.
3. $\langle E,L_eE\rangle\le\tfrac12$ is computed at padded $W_{\mathbb{CP}^2}$, where it is exactly $\tfrac12$; it is owed at a general stratum maximiser.

**None of the three is an estimate.** Two are convergence questions about a computation and one is a spectral bound already proved in a wider form as Lemma L24, which is a different position from the four failed sharpenings that preceded them.

#### Lemma L35, at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, unconditionally

*It generalises the one-positive lemma above to **any** number of positive eigenvalues and needs no descent, the descent having been refuted by the full-support witnesses recorded above.*


Needed because Lemma L29 covered only one positive eigenvalue, and the descent that used to
reduce the general case to dimension four is refuted by Lemma L34. This closes the stratum
directly instead.

**Statement.** Let $W\in\mathrm{Weyl}_m$ have **unit norm** and at most two negative eigenvalues, at any number of positive ones, at any $m$. Then $\theta\le\sqrt{3/2}$.

*Content and sharpness both begin at $m=4$: zero negative eigenvalues is impossible by trace-freeness, and the bound is attained at $(2,-1,-1)/\sqrt6$.* **The argument below is written for exactly two negative eigenvalues. THE ONE-NEGATIVE CASE IS CLOSED, 2026-09-17, AND MORE STRONGLY THAN THIS LEMMA NEEDS: $\theta\le0$, not merely $\theta\le\sqrt{3/2}$. Gate 2 PASSED** ([r988](../reviews/REVIEW_r988.md), [r989](../reviews/REVIEW_r989.md), identical cold briefs).

**THE PROOF IS DIRECT AND USES NONE OF THIS LEMMA'S RELAXATION**, which is what both readers found independently. *With one negative eigenvalue $-s$ and the nonnegative eigenvalues $\lambda_P$ summing to $s$ by trace-freeness, $A$ their maximum and $u=\sum_P\lambda^2$:*

- $\sum_\alpha\lambda_\alpha^3=\sum_P\lambda_P^3-s^3\le Au-s^3$, since each $\lambda_P\le A$;
- every triple through the negative index has nonpositive product and drops, and **no triple carries two negatives**;
- $3\sum_{a<b<c}T\lambda\lambda\lambda=\sum_{a<b}\lambda_a\lambda_b\sum_cT_{abc}\lambda_c\le2A\cdot\tfrac{s^2-u}2=A(s^2-u)$ by the pair cap.

$$\theta\ \le\ Au-s^3+A(s^2-u)\ =\ As^2-s^3\ =\ s^2(A-s)\ \le\ 0 .$$

**It needs only $T\ge0$, the pair cap, $\lambda\le A$ and $A\le s$**, so it inherits none of the chain's hypotheses ([I48OneNegative.lean](../lean/HamiltonsCubic/Results/I48OneNegative.lean), standard axioms, no `sorry`; validated against $40000$ randomly constructed $T$ satisfying the pair cap and nothing else, worst slack $+0.000000000$ and attained, in [screen_I48_one_negative.py](../scripts/misc/screen_I48_one_negative.py)).

**THE EXHAUSTION HYPOTHESIS IS LOAD-BEARING.** *$A\le s$ holds because trace-freeness makes $s$ the total of the NONNEGATIVE eigenvalues, zeros included. A second negative eigenvalue makes $s$ no longer that total, $A>s$ becomes possible, and the conclusion REVERSES.* **And $P$ is the nonnegative part**: the $m=4$ witness carries three zeros.

**WHAT THE RESULT IS WORTH, and this is [r988](../reviews/REVIEW_r988.md)'s finding rather than a caveat.** *Ricci-flatness reads $b\,\Omega_0\Omega_0^{\mathsf T}=\sum_k\lambda_k\Omega_k\Omega_k^{\mathsf T}$ with $\lambda_k\ge0$, so every nonzero eigenform is supported in $\mathop{\mathrm{range}}\Omega_0$.* **Rank $2$ forces $W=0$, and rank $4$ forces at most two strictly positive eigenvalues**, so no all-positive triple exists there and the case is three lines with no relaxation whatever. *Rank $6$ balanced is impossible, the obstruction form's maximum on $\omega_0^\perp$ being exactly half the required value, while a skewed $\omega_0$ escapes.* **So rank $\ge6$ is open and is the only place this derivation can have content.**

**The stratum is NOT empty and the bound is SHARP**: $m=4$ with $W_+=\mathop{\mathrm{diag}}(1,1,-2)/\sqrt6$ and $W_-=0$ has spectrum $(1,1,-2,0,0,0)/\sqrt6$, exactly one negative, and $W_+=\mathop{\mathrm{diag}}(1,-1,0)/\sqrt2$ attains $\theta=0$.

**Two corrections to what the relaxation route recorded.** *The envelope is unconditional with no case split, $R\le s^2(A-s)+3bc(s+2A)$, since $s^3-b^3-c^3=3bcs$ at $s=b+c$, so the owed case is exactly where the obstruction term vanishes.* **And $bc=0$ is the OPPOSITE FACE of $\{1-u\le s^2\le2-2u\}$ rather than an interior point**, though the operative fact, that it is not the face $s^2=2-2u$ the two-negative endgame maximises on, stands. *Equality at $A=s$ characterises the BOUND rather than $\theta$.* **The chain covers it as it stands**: the monotonicity step $R(A,s,u)\le R_2(A,u)$ holds at every feasible $s$, $bc=0$ included, because $R_2$ is an upper bound evaluated at $s=\sqrt{2-2u}$ and needs no spectrum with $b=c$ to realise it, so $c=0$ runs through the same $R_2\le\sqrt{3/2}$. *Machine-checked: `L35_general` in [L35Weyl.lean](../lean/HamiltonsCubic/Results/L35Weyl.lean), whose `negatives` writes one or zero negatives as $c_0=0$ (and $b_0=0$).* I48's $\theta\le0$ is the sharper statement of that case. *And the chain never uses the first Bianchi identity, so what it proves is stronger than a statement about $\mathrm{Weyl}_m$, it holds for any trace-free symmetric operator on $\Lambda^2$ with the stated sign pattern.*

**The chain.** In an orthonormal eigenbasis, with $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$,

$$\theta=\sum_\alpha\lambda_\alpha^3+3\!\!\sum_{\alpha<\beta<\gamma}\!\!T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma,$$

an identity requiring no Weyl hypothesis, **but requiring $\lVert W\rVert=1$**, since the display is $P(W)$ and $\theta$ is $P/\lVert W\rVert^3$. *[Lemma L29](#lemma-l29-one-positive-and-two-negative-eigenvalues-cap-theta-at-sqrt32-canonical-statement-and-proof) states the norm where this dropped it, and [Lemma L70](../findings/bounds.md) lost the same hypothesis from the same kind of list.* The coefficient $3$ is confirmed twice by disjoint routes: against L29's half-sum-over-ordered-triples bookkeeping, and at $(2,-1,-1)/\sqrt6$, where $\sum\lambda^3=1/\sqrt6$ and $3T\lambda_1\lambda_2\lambda_3=2/\sqrt6$ with $T=2$ sum to exactly $\sqrt{3/2}$. Relaxing $T$ to any nonnegative totally symmetric
tensor with row marginals $m-2$ and pair caps $\sum_\gamma T_{\alpha\beta\gamma}\le2$ gives
$\theta\le\mathrm{LP}(\lambda)$. *The marginal is **[Lemma L153](bounds.md)** in its **unordered** form, the display here sums over $\beta<\gamma$, where the value is $m-2$, against L153's $2(m-2)$ over ordered pairs. Both are right and the factor $2$ is the reading, not an error; **[r569](../reviews/REVIEW_r569.md) logged the missing conversion, and [r695](../reviews/REVIEW_r695.md) and [r696](../reviews/REVIEW_r696.md) each reached it again auditing L153.** The pair cap is **[Lemma L31](#lemma-l31-the-bracket-cap-characterised-canonical-statement-and-proof)**.* Dropping the marginals, legitimate, since dropping constraints
only enlarges a maximum, gives $\mathrm{LP}\le G$, where $G$ is a pair-capped fractional
triangle packing supported on the nonzero eigenvalues alone and therefore **free of $m$ and of
$\binom m2$**. ***So this lemma states the row marginal and then discards it***: every step from here to $\sqrt{3/2}$ runs on $G$, whose inputs are nonnegativity, total symmetry and the pair caps, **so the bound would survive [L153](bounds.md) being false**, which is why L153's consumer table records L35 as a states-and-drops citation rather than a consumer. $G$ decouples exactly, **and it is an identity, not an inequality in the safe direction**: the $(+++)$ entries and the $(+--)$ entries consume **disjoint** pair caps, the $(++-)$ entries that would join them being zeroed by sign. The $(+--)$ transport is worth $2bc\lambda_1$ and the rest is a packing on the positives, giving
$G=\sum_P\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$ with $bc=(s^2+u-1)/2$, **the leading sum running over the POSITIVE eigenvalues alone**: over the whole spectrum it returns $8/(3\sqrt6)$ at $(2,-1,-1)/\sqrt6$ against $\theta=9/(3\sqrt6)$, so the chain would run backwards at its own equality point.

**What closes symbolically and what does not.** The interval $(0,\tfrac13]$ and the endpoint close in closed form, and every endpoint constant reproduces by hand, $g(A_0)=\sqrt6/2$, $g'(A_0)=0$, $-\tfrac12g''(A_0)=\tfrac94\sqrt6$. **The whole residual inequality is kernel-checked in Lean**, `L35_residual` in [L35Residual.lean](../lean/HamiltonsCubic/Results/L35Residual.lean), in three bands: $(0,\tfrac13]$ by the closed form at $\tfrac89$; $[\tfrac13,0.6733]$ by $32$ pieces of rational interval arithmetic carried out by the kernel, every constant rounded outward to denominator $10^6$; and $[0.6733,A_0]$ by an exact factorisation. There the cubic drops, $\alpha t+\beta t^2\le\alpha^2/(-4\beta)$ at $\beta<0$, and the scaling $A=wa$, $\sqrt{2-2A^2}=wv$, $w=\sqrt6/3$ puts the inequality on the ellipse $2a^2+v^2=3$; parametrised through its tangent point $(1,1)$ by $a=(m^2-2m-2)/(m^2+2)$ it reads $(m+2)^2Q(m)/(m^2+2)^4\ge0$ with $Q>0$ on $[-2,-\tfrac85]$, **the double root at $m=-2$ being the equality at $A_0$**. The outer bands are arguments a reader can follow; the middle band is mechanical and machine-checked. *The $200$-bit branch-and-bound certificate (its tiling $(\tfrac13,0.7096]$ by $73$ boxes and $[0.7096,A_0]$ by the sign of $Q$ in $21$) is an independent second check.*

**The middle of the proof**, transcribed from [REVIEW_r63](../reviews/REVIEW_r63.md) §(ii), where each step was derived and checked end to end. The symbols are local to this paragraph and the residual-gap section below, since $\alpha$, $\beta$, $\gamma$ and $T$ collide with the tensor indices above. Write the negatives as $-b,-c$ with $b,c\ge0$, the positives $\lambda_P$ with $A:=\lambda_1$ the largest, $s:=\sum_P\lambda=b+c$ (trace-freeness), $u:=\sum_P\lambda^2$, $d:=u-A^2$, and $K_0:=3/(2\sqrt2)$; unit norm gives $b^2+c^2=1-u$, so $bc=(s^2-1+u)/2\ge0$ and $(b-c)^2=2-s^2-2u\ge0$.

1. *Decoupling*: $G=\sum_P\lambda^3-b^3-c^3+6Abc+3M(\lambda_P)$, the display above with $M=\mathrm{FTP}$, the maximum of the $(+++)$ packing objective $\sum_{\alpha<\beta<\gamma}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ over nonnegative totally symmetric $t$ with pair caps $\le2$.
2. *LP duality* ([Lemma L42](#lemma-l42-the-sharp-dual-weight)): $3M\le h\,(s^2-u)$, $h$ the harmonic mean of the three largest positives.
3. $h\le\min(A,K_0\sqrt d)$: $h\le\max=A$, and dropping $1/\lambda_1$ gives $h\le3\lambda_2\lambda_3/(\lambda_2+\lambda_3)$, at most $K_0\sqrt d$ under $\lambda_2^2+\lambda_3^2\le d$.
4. $\sum_P\lambda^3\le A^3+\min(A,\sqrt d)\,d$, from $\sum_{a\ge2}\lambda_a^3\le\lambda_2\sum_{a\ge2}\lambda_a^2$ and $\lambda_2\le\min(A,\sqrt d)$.
5. $d\le(s-A)^2$, Cauchy–Schwarz on the non-leading positives.

Together $G\le R(A,s,u):=A^3+\min(A,\sqrt d)\,d+\min(A,K_0\sqrt d)(s^2-u)-s^3+3bc(s+2A)$. **$R$ increases in $u$ and in $s$** ($\partial_uR\ge\tfrac32s+2A>0$, $\partial_sR=2s\min(A,K_0\sqrt d)+6sA+3bc>0$), so both sit on the single constraint $s^2\le2-2u$, which is $b=c$, and with $s=\sqrt{2-2u}$
$$R_2(A,u)=A^3+\min(A,\sqrt d)\,d+\min(A,K_0\sqrt d)(2-3u)-\tfrac14(2-2u)^{3/2}+3A(1-u).$$
Three regions:

| region | bound | maximum |
|---|---|---|
| $d>A^2$, i.e. $A<\sqrt{u/2}$ | $R_2=5A(1-u)-\tfrac14(2-2u)^{3/2}$ | $1.017217$ |
| $\tfrac89A^2<d\le A^2$, i.e. $A<3\sqrt{u/17}$ | $R_2\le2A^3+A(5-6u)-\tfrac14(2-2u)^{3/2}$ | $1.067666$ |
| $0\le d\le\tfrac89A^2$, where $K_0\sqrt d\le A$ | $R_2\le g(A)+\psi(t)$, $t=\sqrt d$ | $\sqrt{3/2}$, only at $d=0$ |

The last row uses $(X-2t^2)^{3/2}\ge X^{3/2}-3t^2\sqrt X$ at $X=2-2A^2$, and its right side is [the residual inequality](#the-residual-gap-and-the-half-of-it-that-is-now-closed), with $t\le\tfrac{2\sqrt2}3A$ from $d\le\tfrac89A^2$. For $A>\sqrt{2/3}$, $\alpha\le0$, $\beta<0$, $\gamma<0$ give $\psi\le0$ and $R_2\le g(A)\le\sqrt{3/2}$, the last because $g'<0$ on $(\sqrt{2/3},1)$. *Steps 1 to 4 and the monotonicity are machine-checked from the sign split onward, `packing_le` in [L35Pack.lean](../lean/HamiltonsCubic/Results/L35Pack.lean) through `R3_le_R2` in [L35Mono.lean](../lean/HamiltonsCubic/Results/L35Mono.lean), the duality run at $\mu=\min(A,K_0\sqrt d)$ so no sorting of the positives is needed and step 5 is not consumed. $R_2\le\sqrt{3/2}$ on the whole domain is machine-checked, `R2_le` in [L35Reduce.lean](../lean/HamiltonsCubic/Results/L35Reduce.lean), the first two rows at once with the bound $\tfrac65$ and the last through `L35_residual` or, at $A>\sqrt{2/3}$, the signs of $\alpha,\beta,\gamma$ with $g\le\sqrt{3/2}$ past the endpoint.*

**The constant itself is predicted rather than fitted**, $\sqrt{3/2}$ enters the record as $\theta$ at an exhibited point, four days before the packing argument, so the shape [L107](../findings/bounds.md) was found to have this afternoon is absent here.

**The closing lemma is the sharp dual weight, [Lemma L42](#lemma-l42-the-sharp-dual-weight).** For a triple of positives the dual $z_{\alpha\beta}=\tfrac h3\lambda_\alpha\lambda_\beta$ is feasible exactly when $h$ is at least the triple's harmonic mean, so the binding triple is the three largest positives, $h$ is their harmonic mean, and weak duality gives $3M(\lambda_P)\le h\,(s^2-u)$. With $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$
and two further elementary bounds, $G$ is dominated by a three-parameter relaxation strictly
increasing in $s$ and $u$; forcing both to the constraint $s^2\le2-2u$ **forces $b=c$** and leaves
two variables, in three regions capped at $1.017217$, $1.067666$, and an envelope whose maximum is
exactly $\sqrt{3/2}$ at $A=\sqrt{2/3}$. **The cases of one and two positive eigenvalues close in exact closed form, and the closure is in [REVIEW_r63](../reviews/REVIEW_r63.md) rather than here**, reconciling with $G$ and reaching its maximum at $\sqrt{3/2}$. *[Lemma L29](#lemma-l29-one-positive-and-two-negative-eigenvalues-cap-theta-at-sqrt32-canonical-statement-and-proof)'s block declares the $k=2$ maximisation owed and names L35 as unable to discharge it, while this block declared it closed by L29, a loop with nothing in it, broken by the argument's real location rather than by either pointer.* **What the canonical record owes here is the transcription of the $k\le2$ closed forms, not the mathematics**; the $k\ge3$ middle is transcribed above. $\square$

**The residual inequality is closed, and rigorously**, *kernel-checked as `L35_residual` in [L35Residual.lean](../lean/HamiltonsCubic/Results/L35Residual.lean) with the tiling stated above*. The certificate below splits it into three ranges because no single argument reaches the whole interval: $(0,\tfrac13]$ in closed form at exactly $\tfrac89$, **the band peaking at its own right endpoint because the band stops there**, $\beta$ vanishing at $\tfrac13$ is a coincidence rather than the cause, the bound's derivative being $\tfrac{11}3>0$ at that point; $(\tfrac13,0.7096]$ by interval arithmetic; and $[0.7096,A_0]$ by the sign of $Q$, with $[0.7,0.7096]$ by bisection. **The endpoint expansion is not what closes the last band**: its constants are exact, $g(A_0)=\sqrt6/2$, $g'(A_0)=0$, $-\tfrac12g''(A_0)=\tfrac94\sqrt6$ against $\psi^*=\tfrac32\sqrt6\,\varepsilon^2$, margin $\tfrac34\sqrt6$, and it carries no remainder bound, so it certifies nothing outside an unspecified neighbourhood and the interval goes to bisection instead.

**Two cases the written inequality does not reach.** *Three equal positives with $b=c$* give $t/T=\tfrac32$ exactly, at every scale, which lies outside the range $t\in[0,\tfrac{2\sqrt2}3A]$ the residual inequality quantifies over. *And $W=0$* satisfies the canonical statement's hypotheses as written (zero negative eigenvalues, trace-free) while $\theta$ is $0/0$ there, which the unit-norm form of the statement excludes and the canonical form does not. Interval arithmetic at $200$ bits closes the whole of $(0,A_0]$ in $94$ adaptive
boxes with **no floating-point-only step**, and certifies $F'>0$ throughout rather than sampling it. Gate 2 passed by two
reviewers on identical briefs, agreeing on every claim and reaching this one by different routes,
one through a dual whose feasibility is Nesbitt's inequality, one through the five lemmas above.
They also corrected three claims made in deriving it: an inequality credited to the curvature identity that is in fact positivity of the cross terms on a nonnegative spectrum, a per-$k$ table of maxima that was a sampling artefact,
and a dropped factor of $3$.

#### Lemma L42, the sharp dual weight

*Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; **the argument is [its weak duality proof](#the-lemma-that-closes-it-is-the-sharp-dual-weight-and-it-is-now-proved-by-lp-weak-duality-not-verified) in this file**, machine-checked in [L42Statement.lean](../lean/HamiltonsCubic/Results/L42Statement.lean).* *Verified `PROVEN`, [ROUND_L42](../verification/ROUND_L42.md).*

Let $\lambda_P$ be at least three positive eigenvalues and let
\[
M(\lambda_P)\;=\;\max\Big\{\textstyle\sum_{\alpha<\beta<\gamma}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma\;:\;t\ge0,\ \sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}\le2\ \text{for every pair}\Big\}.
\]
Then $3M(\lambda_P)\le h\,(s^2-u)$, with $h$ the harmonic mean of the three largest positives, $s=\sum\lambda$ and $u=\sum\lambda^2$. **The constant cannot be improved.**



#### Lemma L72, the rank-3 stratum is overdetermined, and its converse clause closes in three lines

**At a critical point, the criticality rows close what the stratum analysis left open.** *[ELIM-stratum](../reviews/ELIM-stratum.md), verified here line by line.* With spectrum $(\lambda_1,-a,-b,0,\dots)$, $a,b>0$, the only bracket entry the rows see is $T:=T_{1,N-1,N}$, and the three non-kernel rows of $(W^\#)_{\beta\beta}=\lambda_\beta(\theta-\lambda_\beta)$ read

$$\text{(i)}\ Tab=\lambda_1(\theta-\lambda_1),\qquad\text{(ii)}\ T\lambda_1b=a(\theta+a),\qquad\text{(iii)}\ T\lambda_1a=b(\theta+b).$$

Three expressions for one number. (ii)$=$(iii) forces $a=b$ or $\theta=-(a^2+ab+b^2)/(a+b)$; on the second branch $\theta+a=-b^2/(a+b)$, so (ii) gives $T=-ab/(\lambda_1(a+b))=-ab/\lambda_1^2<0$ (using $\mathop{\mathrm{tr}}W=0$, i.e. $\lambda_1=a+b$), impossible for $T=c^2$; and $T=0$ fails the pair (i)&(ii), (i) forces $\theta=\lambda_1>0$ while (ii) forces $\theta=-a<0$, neither row killing it alone. **So $a=b$, and then $\lambda_1=2a$, $\theta=3a$, $T=2$, unit norm $6a^2=1$:**

> **LEMMA L72.** *Every critical point of $\mathcal W_n$ with exactly one positive and two negative eigenvalues has spectrum $(2,-1,-1)/\sqrt6$ on its support and $\theta=\sqrt{3/2}$, for every $n$, with no numerics and no case analysis.* The converse clause Lemma L29 left "reduced but not closed", hedged on solves at $r=6,8,10$ with $r\ge12$ untested, is closed by it, and the closure is a **different** statement from the clause, and the weaker of the two: the spectrum is forced at every **critical** point of the stratum, and by [Lemma L29](#lemma-l29-one-positive-and-two-negative-eigenvalues-cap-theta-at-sqrt32-canonical-statement-and-proof) those are a *subset* of the equality points. *The first version called it stronger, inverting the containment.* **What closes the clause is [Lemma L31](#lemma-l31-the-bracket-cap-characterised-canonical-statement-and-proof)**, in three lines.

**Why this stratum and no other**: the rows give $r$ equations against $\binom r3$ live entries, so $T$ is *overdetermined* at rank $3$, determined at rank $4$, and free from rank $5$ on, the collapse boundary is exactly where the count crosses. *The $N-1$ uncontracted rows are the survivor the audit names: only their $\lambda$-contraction (the tautology $\langle W,W^\#\rangle=\theta-\mathop{\mathrm{tr}}W^3$) has ever been used by this file.*

**The bridge across $0<\delta<0.005$ is an identity, not a conjecture.** The per-row Bianchi balance (Lemma L33 evaluated at a single $v_\beta$) gives $\sum_{\alpha\ne\beta}\lambda_\alpha\epsilon_{\alpha\beta}=0$ for every $\beta$; at $\beta=1$ this forces $\epsilon_{1,N-1}=\epsilon_{1,N}=0$ (positive coefficients against $\epsilon\ge0$), and row $N$ then kills $\epsilon_{N-1,N}$, **all three pair caps saturate in three lines**, replacing the Ricci-PSD support argument, the descent to $r=4$ and the $\mathfrak{su}(2)$ input; and rows $N-1$, $N$ added give $\sum_{p>0}\lambda_p(\epsilon_{p,N-1}+\epsilon_{p,N})=\sigma\delta$ **exactly**, which is the conjectured $\epsilon_{\min}$ bridge as an identity. *The same rows also say why $k\ge3$ is genuinely harder: at a positive $\beta$ the balance forces nothing.*

---

*Re-filed here 2026-09-02 from [isotropy-cap.md](isotropy-cap.md) by the parallel sort of [findings/](.). Conventions: [conventions.md](conventions.md).*

## The $\theta\le\mathrm{LP}\le G\le\sqrt{3/2}$ chain for two negative eigenvalues, its sharp dual weight, and the residual one-variable inequality
*From findings/isotropy-cap.md. Belongs in stratum-two-negative.md because its subject is $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues, the canonical Lemma L35 and Lemma L42 live there, and the Lemma L42 block there points at an argument it does not carry.*

#### B0's owed bound is proved, modulo one elementary inequality

For every $W\in\mathrm{Weyl}_m$ with exactly two negative eigenvalues, at every $m$ and any number $k$ of positive eigenvalues,

$$\theta\ \le\ \mathrm{LP}(\lambda)\ \le\ G(\lambda)\ \le\ \sqrt{3/2}.$$

*Gate 2 landed, Reviewers 62 and 63 on identical briefs, agreeing on all six claims and reaching the last one by different routes.*

#### The chain

In the eigenframe $\theta=\sum_\alpha\lambda_\alpha^3+3\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$, an identity needing no Weyl hypothesis. Relaxing $T$ to any nonnegative totally symmetric tensor with the row marginals and the pair cap gives $\mathrm{LP}(\lambda)$; **dropping the marginals gives $G$**, legitimate because dropping constraints only enlarges a maximum, and leaving a pair-capped fractional triangle packing on the $2+k$ nonzero indices with no $m$ and no $N$ in it. $G$ decouples exactly (Reviewer 62): the $(+--)$ transport is worth $2bc\lambda_1$ and the rest is a packing on the positives alone, so $G=\sum_P\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1)$ with $bc=(s^2+u-1)/2$, matched to the brute-force LP at $3\times10^{-16}$.

#### The lemma that closes it is the sharp dual weight, and it is now PROVED, by LP weak duality, not verified

#### The primal

$M(\lambda_P):=\max\sum_{\alpha<\beta<\gamma}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ over $t\ge0$ subject to the pair cap $\sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}\le2$ for every pair.

**Its dual** is $\min\ 2\sum_{\alpha<\beta}z_{\alpha\beta}$ subject to $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$ on every triple, $z\ge0$.

#### Feasibility of the product weight

Put $z_{\alpha\beta}=c\,\lambda_\alpha\lambda_\beta$. Dividing the triple constraint by $\lambda_\alpha\lambda_\beta\lambda_\gamma>0$ turns it into
$$c\Big(\tfrac1{\lambda_\alpha}+\tfrac1{\lambda_\beta}+\tfrac1{\lambda_\gamma}\Big)\ \ge\ 1,\qquad\text{i.e.}\qquad c\ \ge\ \tfrac13H(\alpha,\beta,\gamma),$$
with $H$ the **harmonic mean** of the triple, since $\sum1/\lambda=3/H$. The harmonic mean is increasing in each argument, so the binding triple is the **three largest positives** and $c=h/3$ is feasible.

#### Weak duality

With that $c$,
$$M(\lambda_P)\ \le\ 2\sum_{\alpha<\beta}z_{\alpha\beta}\ =\ 2\cdot\tfrac h3\cdot\tfrac{s^2-u}2\ =\ \tfrac h3(s^2-u),$$

$$\boxed{\ 3M(\lambda_P)\ \le\ h\,(s^2-u)\ },\qquad h=\text{harmonic mean of the three largest positives.}$$

#### It is sharp, and the equal case shows it

With $k$ equal positives $\lambda$: $h=\lambda$, $s^2-u=k(k-1)\lambda^2$, so the bound reads $3M\le k(k-1)\lambda^3$. *The pair-count $\sum t\le k(k-1)/3$ is the same upper bound again, not attainment*, **both Gate 2 reviewers flagged that, and both supplied the missing maximiser**: $t_{\alpha\beta\gamma}=2/(k-2)$ on every triple has pair marginal $(k-2)\cdot\frac2{k-2}=2$, feasible, with $\sum t=\binom k3\frac2{k-2}=k(k-1)/3$. So equality genuinely holds for $k\ge3$ and no constant in the lemma can be improved.

#### Hypothesis: at least three positives

At $k\le2$ there are no triples, $M=0$, and $h$ is undefined; those cases are closed elsewhere.

#### The residual gap, and the half of it that is now closed

The final one-variable inequality, $g(A)+\max_{0\le t\le\frac{2\sqrt2}{3}A}\psi(t)\le\sqrt{3/2}$ on $A\in(0,A_0]$, $A_0=\sqrt{2/3}$, was verified on a grid rather than argued symbolically, and equality at the endpoint rules out a Lipschitz certificate there. Here $A=\lambda_1$, $K_0=3/(2\sqrt2)$, $T=\tfrac{2\sqrt2}3A$ is the cap on $t$, and
$$\psi(t)=\alpha t+\beta t^2+\gamma t^3,\qquad\alpha=K_0(2-3A^2),\quad\beta=\tfrac34\sqrt{2-2A^2}-3A,\quad\gamma=1-3K_0<0,$$
*transcribed from [REVIEW_r63](../reviews/REVIEW_r63.md), lines 128–129, where the region-I reduction $R_2\le g(A)+\psi(t)$ is derived.*

**The endpoint is now closed in exact arithmetic.** With $g(A)=A^3-(1-A^2)^{3/2}/\sqrt2+3A(1-A^2)$:

$$g(A_0)=\tfrac{\sqrt6}{2}=\sqrt{3/2},\qquad g'(A_0)=0,\qquad -\tfrac12g''(A_0)=\tfrac94\sqrt6,$$

while $\alpha(A_0-\varepsilon)=3\sqrt3\,\varepsilon$ and $\beta(A_0)=-\tfrac34\sqrt6$ give $t^*=\sqrt2\,\varepsilon$ (well inside the cap, so the unconstrained cubic maximum is the operative one) and $\psi^*=\alpha^2/(4|\beta|)=\tfrac32\sqrt6\,\varepsilon^2$. So $g$ falls away at $\tfrac94\sqrt6\,\varepsilon^2$ against a climb of $\tfrac32\sqrt6\,\varepsilon^2$, an **endpoint margin of $\tfrac34\sqrt6>0$**, a clean factor $3/2$, every constant a surd, computed symbolically. *Also confirmed independently: $g'(A)=3-6A^2+\tfrac32A\sqrt{2-2A^2}$, whose only root in range is $A_0$; and over $4\times10^5$ points $F=g+\psi^*$ is strictly increasing on $(0,A_0]$, minimum forward difference $+7.7\times10^{-12}$, zero descending steps.*

#### The interior is now covered too, in three ranges

$\psi^*$ has a closed form: $\gamma<0$ makes the roots' product $\alpha/(3\gamma)<0$, so $\psi'$ has a unique positive root $t_c=\big(-\beta-\sqrt{\beta^2-3\gamma\alpha}\big)/(3\gamma)$ and $\psi^*=\psi(\min(t_c,T))$.

| range | argument | margin |
|---|---|---|
| $(0,\tfrac13]$ | closed form: dropping $\gamma t^3\le0$ gives $g+\alpha T+\beta T^2\le\tfrac89$, peaking at $A=\tfrac13$ where $\beta=0$ exactly ($\sqrt{2-2A^2}=4A\iff A^2=\tfrac19$) | $+0.336$ |
| $(\tfrac13,0.7]$ | Lipschitz certificate with a **derived** constant | $+0.0215$ |
| $(0.7,A_0]$ | the exact endpoint expansion above, **but see the withdrawal below: the expansion carries no remainder bound and certifies nothing outside an unspecified neighbourhood, so this interval is closed by bisection rather than by the expansion** | $\tfrac34\sqrt6$ |

#### The Lipschitz constant is derived, not measured

By the envelope theorem $F'=g'+\alpha't+\beta't^2$ on the interior branch and adds $(\alpha+2\beta T+3\gamma T^2)T'$ on the capped one, with $\alpha'=-\tfrac{9\sqrt2}{2}A$, $\beta'=-\tfrac{3\sqrt2A}{4\sqrt{1-A^2}}-3$, $T'=\tfrac{2\sqrt2}{3}$; bounding each on $[\tfrac13,0.7]$ gives $L\le13.7250$. At $h=1.83\times10^{-6}$ the certificate is $\max F+Lh/2=1.203242\le\sqrt{3/2}$, the slack exceeding the discretisation term by three orders. *Dropping the cubic is too lossy in this band, the envelope overshoots to $1.3026$, so the cubic is retained here and only here.*

#### Gate 2 landed (Reviewer 64), and the argument is now rigorous

The grid evaluation is replaced by interval arithmetic at $200$ bits: $F<\sqrt{3/2}$ on $(0,0.7096]$ in $73$ adaptive boxes, $Q<0$ on $[0.7096,A_0]$ in $21$, and $F(A_0)=\sqrt{3/2}$ exactly, **no floating-point-only step anywhere**. Branch-and-bound puts the middle band's maximum in $[1.20322955981,\,1.20322956076]$, confirming $1.203230$ with no interior spike, and monotonicity $F'>0$ is certified on $[10^{-12},0.8164]$ rather than sampled.

#### One repair, to the endpoint band

The second-order expansion has every constant exactly right but **carries no remainder bound and points the wrong way**: $(\sqrt{3/2}-F)/\varepsilon^2$ approaches $\tfrac34\sqrt6$ *from below*, so the model sits under $F$ away from $A_0$, by $-3.4\times10^{-3}$ at $A=0.7$, and certifies nothing outside an unspecified neighbourhood. Confirmed independently here. The repair is $F-\tfrac{\sqrt6}{2}\le\varepsilon^2Q(A)$ with $Q=\tfrac12\sup_{[A,A_0]}g''+9K_0^2(A_0+A)^2/(4|\beta|)$, from $\psi^*\le\alpha^2/(4|\beta|)$ and Taylor with integral remainder; dividing by $\varepsilon^2$ removes the degeneracy at $A_0$. $Q$ genuinely fails at $A=0.70$, so $[0.7,0.7096]$ goes to direct bisection instead.

#### Two further corrections

The branch switch $t_c=T$ sits at $A=0.4463$, **inside** the middle band, and $F$ is $C^1$ there because $\psi_t(A_{\rm sw},T)=0$ by the definition of $t_c$, so the capped branch's extra term vanishes and the one-sided derivatives agree, a check the original argument never made. And the derived $L\le13.7250$ is valid but $1.85\times$ loose: the true $\sup|F'|$ on the band is $\le7.4080$.

#### Three of this cycle's own claims are corrected

*(i)* $(b+c)^2+b^2+c^2\ge1$ is **positivity of the cross terms**, $(\sum_P\lambda)^2\ge\sum_P\lambda^2$ holds because the spectrum is nonnegative there, with trace-freeness and unit norm, true of any two-negative spectrum, Weyl or not. *Naming it Cauchy–Schwarz points the wrong way*: Cauchy–Schwarz gives $s^2\le k\,u$, the opposite direction, and it lives at the unnamed step $s^2\le2-2u$, which is $(b+c)^2\le2(b^2+c^2)$ and whose equality case is exactly what **forces $b=c$**. Calling the first an identity on the base-case family was vacuous: that family has one positive eigenvalue, where the cross-term sum is empty. The identity's real content is the sharper $2b^2+2c^2+bcR\ge1$, which applying $R\le2$ discards. *(ii)* **$\sup G=\sqrt{3/2}$ at every $k$**, not a decreasing sequence: the $k$-stratum closure contains every smaller one, and embedding the $k=1$ optimum by splitting its positive into $\varepsilon$-parts returns $\sqrt{3/2}$ to $10^{-13}$ at $k=2,3,5,7$. The recorded per-$k$ table was a maximum over random draws, hence a lower bound, and the "monotone decrease in $k$" read off it does not exist. *(iii)* $\theta\le9bc(b+c)$ **stands as a theorem** but its chain drops a factor $3$ in the $(+--)$ block and its appeal to the row-sum identity is removable, the pair cap alone giving the same constant; its "all steps tight on the base-case family" tests two of five steps, the rest being vacuous at $k=1$.

#### Another dual is worth trying

The three refuted ansätze are refuted, their duals are independently verified *feasible*, so the refutations are of the constants and not of the method, but they are wasteful by up to $3\lambda_1/\lambda_3$, and the sharp choice $\mu=h$ is precisely the lemma that closes the proof. **A shape is not dead because three of its constants are.**

---

*Re-filed here 2026-09-02 from [second-order.md](second-order.md) by the parallel sort of [findings/](.). Conventions: [conventions.md](conventions.md).*

## At $n=12$ no maximiser has fewer than three negative eigenvalues
*From findings/second-order.md. Belongs in stratum-two-negative.md because stratum-two-negative.md owns the $\dim\mathfrak m\le2$ stratum end to end, and this section measures exactly that stratum.*

#### At $n=12$ no maximiser has fewer than three negative eigenvalues

**The stratum where $S=0$ is vacuous is capped by $\sqrt{3/2}$ at every dimension tested**, and at $n=12$ that cap falls *below* $\theta_0$:

| $n$ | 6 | 8 | 10 | 12 |
|---|---|---|---|---|
| $\max\theta$ on $\dim\mathfrak m\le2$ | 1.224745 | 1.224745 | 1.224745 | 1.224745 |
| $\theta_0(n)$ | 1.054093 | 1.145644 | 1.200000 | **1.236033** |

So at $n=12$, **a maximiser cannot have at most two negative eigenvalues**, the whole stratum sits $0.9\%$ below the balanced sphere product. Below $n=12$ the ordering is the other way, which is exactly the crossover the record already places at $n=6+2\sqrt7\approx11.29$: padded $W_{\mathbb{CP}^2}$ wins there and loses from $n=12$ on. Dimensions $6$ and $8$ ran seven starts, $n=10$ two, $n=12$ one at $740$ s in $1638$ dimensions; every one returned $1.224745$ to six digits with the third-most-negative eigenvalue held below $10^{-8}$.

**And the stratum it excludes contains exactly one catalogued point, the sharp one.** Counting negative eigenvalues across the catalogue:

| point | $n$ | $\theta$ | $\dim\mathfrak m$ | $S$ | frame odm |
|---|---|---|---|---|---|
| padded $W_{\mathbb{CP}^2}$ | 12 | 1.224745 | **2** | 0 | 0.707 |
| $\mathbb{CP}^3$ | 6 | 1.054093 | 6 | $3\times10^{-30}$ | 0.791 |
| $\mathbb{CP}^4$ | 8 | 0.986013 | 12 | $3\times10^{-29}$ | 0.837 |
| $\mathbb{CP}^5$ | 10 | 0.948683 | 20 | $8\times10^{-29}$ | 0.866 |
| $S^3\times S^3$ | 6 | 1.054093 | 9 | 0 | 0 |
| $S^4\times S^8$ | 12 | 1.201561 | 32 | 0 | 0 |
| $S^6\times S^6$ | 12 | 1.236033 | 36 | 0 | 0 |
| $C_5$ blow-up | 10 | 0.670820 | 20 | 0 | 0 |
| $(S^4)^3$ | 12 | 0.829156 | 48 | 384 | 0 |

**Padded $W_{\mathbb{CP}^2}$ is the only one with $\dim\mathfrak m\le2$**, every other $S=0$ point has $\dim\mathfrak m\ge6$. So the stratum bound excludes precisely route R9s sharp case, the nearest non-diagonal competitor at $0.9909\,\theta_0(12)$ and the orbit Nienhaus 4.19 localises on, **without using any enumeration**. What is left of the residual is the complementary stratum, $\dim\mathfrak m\ge3$ with $S=0$ and non-diagonal, where the best found so far is $1.0560$ at $n=6$ and $1.1315$ at $n=8$.

**And $\dim\mathfrak m=2$ looks like the floor, not a special case.** Maximising the second-smallest eigenvalue over $\mathrm{Weyl}_n$ reaches $-0.0115$ at $n=6$ and $-0.0494$ at $n=8$, no Weyl tensor with fewer than two negative eigenvalues turned up, though an ascent maximum is a lower bound on the true one, so this is evidence and not a proof. If it holds, the excluded stratum is exactly the minimum possible negative eigenspace.

**A trap worth naming: a gradient ascent seeded at a critical point cannot move, because the gradient is zero there.** Two runs at $n=12$ seeded at $\mathbb{CP}^6$, $\theta=0.924962$, $S=3\times10^{-28}$, $\dim\mathfrak m=30$, frame-minimal off-diagonal mass $0.886$, returned it unchanged across five penalty levels, first with a $40$-direction subspace gradient and then with the **full** $1638$-dimensional gradient at $626$ s. The first was read as an optimiser failure; both are instead the definition of a critical point. Seeds for a search of this kind must be off the critical set.

**From a random start at $n=12$ the complementary stratum stays below both thresholds.** A full-gradient run reached $\theta=1.132418$ with $\dim\mathfrak m=34$ and frame-minimal off-diagonal mass $0.9860$ (strongly non-diagonal), against $\sqrt{3/2}=1.224745$ and $\theta_0(12)=1.236033$. Its $S$ is $2.9\times10^{-5}$, above the $10^{-6}$ the guard demands, so it is a near-miss of the constraint rather than a point on it. ([b_slack_constrained_max.py](../scripts/route-b/b_slack_constrained_max.py))

---


## Analysis the plan's items carried
*Step 7 leaves each item its identifier, theorem, grade, route and what is owed, and the reasoning comes here. Each was checked against the record first and none was a duplicate.*

### I7, the destination: $\theta\le\sqrt{3/2}$ on the compact non-pure set. No route known

> **ITS NAMED PRECONDITION NOW HAS A NUMBER.** *The paragraph below asks what a compact critical set at positive distance from every pure orbit gives. [Lemma L216](second-order.md#lemma-l216-an-explicit-isolation-radius-at-every-quantitatively-nondegenerate-critical-orbit) makes that distance explicit at every sphere product, $r=4\theta_0\gamma/(9(1+\sqrt{n-2}))$ with the gap closed form, and at padded $\mathbb{CP}^2$ conditionally on [I54](../plan-verification.md).* **What it does not supply is the localisation**, that every critical point above the rival value lies within that distance of some rigid orbit, which has no proposition on the record and must clear [R4](../routes.md)'s successor condition, not resting on $W_{\mathbb{CP}^2}$ remaining the maximiser.

**What the record offers toward it, none of it a route:** the $\le2$-negative stratum is capped at $\sqrt{3/2}$ ([L29–L36, L42](results.md)); no maximiser lies near the $\mathbb{CP}^2$ orbit ([L20–L22](results.md)); [Conjecture L16](findings/problem.md) would give it outright and is [R17](routes.md), whose open grant $J_5\ge0$ shares its objects with [I11](../plan.md#section-2-build-what-the-proofs-need). *When I5 lands, the next step 8 sweep asks what a compact critical set at positive distance from every pure orbit gives (a Morse-theoretic count, a minimax value, an equivariant index), with the [R12](routes.md) closure notes and [post F37](findings/INDEX-traps.md) as its fences.* **[Conjecture L16](findings/problem.md) does NOT give this outright**, audited 2026-09-04: it yields $\theta\le\sqrt{3/2}$ on $\{\delta^2\ge\tfrac19\}$ alone, an $n$-free condition excluding every catalogued point with $\theta\ge1$, and at zero defect its bound is $\theta_0(n)>\sqrt{3/2}$ for exactly $n\ge12$ ([r473](reviews/REVIEW_r473.md), [r474](reviews/REVIEW_r474.md)).

