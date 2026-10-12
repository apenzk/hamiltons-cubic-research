# REVIEW_r514, Lemma L29

**Target.** Lemma L29, "one positive and two negative eigenvalues cap $\theta$ at $\sqrt{3/2}$", in [stratum-two-negative.md](../findings/stratum-two-negative.md) at the `#### Lemma L29` heading (line 69), down to the next heading.

**Reviewer.** r514, cold, adversarial, analysis-only footing.

**Phase plan.**

1. Fix conventions against the known anchors ($Q_{ab}$, $\operatorname{tr}W^\#=-1$, $\theta_0(6)=\sqrt{10}/3$, $\dim\mathcal W_n$).
2. Read the block verbatim.
3. Attack the hypothesis: eigenvalues of what, counted how (the L33 defect).
4. Attack the constant $\sqrt{3/2}$ vs $\sqrt3/2$ and its normalisation.
5. Sharpness: padded $W_{\mathbb{CP}^2}$, spectrum $(2,-1,-1)/\sqrt6$, attainment.
6. The vanishing claim: $c'$ antisymmetry, $\dim\mathfrak m\le2$, and vacuity of R2's residual hypothesis.
7. Dimension-freeness and padding.
8. The 11 citations: as-stated or strengthened.
9. Contradictions elsewhere in `findings/` and later in the same file.
10. Provenance line against git.

**VERDICT: CONFIRMED**, the bound, the proof and the attainment all hold; six defects found in the surrounding claims and citations, listed at the foot.

---

## Phase 1, conventions fixed against the anchors, by hand

Everything below is derived in the block's own normalisation, which I pinned before reading the proof.

| anchor | what I derived independently | agrees |
| --- | --- | --- |
| inner product | $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\varphi_{ij}=E_{ij}-E_{ji}$ is a **unit** vector. The block's own sentence *"$[\varphi_{12},\varphi_{13}]=\pm\varphi_{23}$ has norm $1$"* pins this reading; I get $[\varphi_{12},\varphi_{13}]=-\varphi_{23}$ from $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$ | yes |
| pair cap $\lVert[v_\alpha,v_\beta]\rVert^2\le2$ | $\mathrm{ad}_X$ on $\mathfrak{so}(n)$ has eigenvalues $\pm i(s_j\pm s_k)$, $j<k$ (type $D$/$B$ roots carry no $2e_j$), so $\lVert\mathrm{ad}_X\rVert_{\rm op}=\max_{j<k}(s_j+s_k)\le\sqrt{2\sum s^2}=\sqrt2$ | yes |
| cap saturated on $\Lambda^+$ | $\omega_1=(\varphi_{12}+\varphi_{34})/\sqrt2$ etc.: $[\omega_1,\omega_2]=-\sqrt2\,\omega_3$, norm$^2=2$ **exactly** | yes |
| $\langle W,W^\#\rangle=\tfrac12\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ | from $W^\#_{\alpha\beta}=\tfrac12\sum_{\gamma\delta}c'_{\alpha\gamma\delta}c'_{\beta\gamma\delta}\lambda_\gamma\lambda_\delta$ | yes |
| $\operatorname{tr}W^\#=-1$ | $\operatorname{tr}W^\#=\tfrac12\sum_{\gamma\ne\delta}\lVert[v_\gamma,v_\delta]\rVert^2\lambda_\gamma\lambda_\delta$; at padded $W_{\mathbb{CP}^2}$ every mixed bracket is $2$, giving $\sigma^2-p=0-1=-1$ | yes |
| $\theta_0(6)=\sqrt{10}/3$ | reproduced from my own diagonal formula $\langle W,W^\#\rangle=3\sum_{i<j<k}K_{ij}K_{jk}K_{ik}$ on $S^3\times S^3$: $\lVert W\rVert^2=22.5$, $P=112.5$, $\theta=112.5/22.5^{3/2}=1.0540926=\sqrt{10}/3$ | yes |

**The constant is the UNDEFLATED one.** $\sqrt{3/2}=1.2247449$, not $\sqrt3/2=0.8660$. The proof produces $f(1)=9\sqrt2\cdot2/(4\cdot3^{3/2})=18\sqrt2/(4\cdot3\sqrt3)=\sqrt6/2=1.2247449$, and $\sqrt6/2=\sqrt{3/2}$ identically. **No normalisation error.** Cross-check: $P=18a^3$ at $a=1/\sqrt6$ gives $18/(6\sqrt6)=3/\sqrt6=\sqrt6/2$, same number by a second route.

## Phase 3, the hypothesis. **L29 does NOT carry L33's multiplicity defect.**

The brief asked whether *"one positive and two negative eigenvalues"* is ambiguous between *with multiplicity* and *distinct values*, as L33's *"exactly one eigenvalue of one sign"* was. It is not, for two independent reasons internal to the statement:

1. **The displayed chain pins it.** The statement writes $\lambda_1>0>-a\ge-b$, three eigenvalue *slots*, and the weak inequality $-a\ge-b$ **explicitly admits $a=b$**. A distinct-value reading would have to write $-a>-b$. So the statement itself lists the spectrum with multiplicity.
2. **The distinct-value reading destroys the block's own equality case.** At the extremiser $a=b$, the spectrum $(2,-1,-1)/\sqrt6$ has *one* distinct negative value. Under the distinct reading the extremiser would fall **outside** the hypothesis, and the clause *"attained at the spectrum $(2,-1,-1)/\sqrt6$"* would be self-contradictory. Only the with-multiplicity reading is coherent.

**And the proof uses that reading**, correctly: $(+++)$ is disposed of by *"only one exists"*, which is a statement about multiplicity, not about distinct values. Under the distinct reading a positive eigenvalue of multiplicity $\ge3$ would make $(+++)$ live and the proof would collapse, but that reading is already excluded by (1) and (2).

*Screen for a witness under the alternate reading, reported as a screen:* I looked at the family the alternate reading would have to be refuted by, $O(p)\times O(q)$-invariant diagonal tensors, $K=\alpha_1\Pi_1+\alpha_2\Pi_2+\beta\Pi_{12}$ with $(p-1)\alpha_1+q\beta=0$, $(q-1)\alpha_2+p\beta=0$. Taking $\beta>0$ gives exactly one distinct positive value and two distinct negative values whenever $p\ne q$, $p,q\ge2$, and $\theta$ there is **negative** ($-0.707$ at $(p,q)=(2,3)$), because it is the sign-flip of the sphere-product branch. So this family supplies no witness, and I record no claim that none exists.

**One hypothesis is implicit and unstated.** *"Exactly one positive and two negative eigenvalues"* silently requires the remaining $N-3$ eigenvalues to be **zero**, i.e. $\operatorname{rank}W=3$ on $\Lambda^2$. The proof needs it (the sign split has only four blocks), and [isotropy-cap.md](../findings/isotropy-cap.md) reads the lemma exactly that way (*"Lemma L29 covers rank 3 only"*). Stating "and $N-3$ zero eigenvalues" would cost four words and remove the reading under which the lemma is about a *signature* rather than a *spectrum*.

## Phase 4, the constant and the algebra: re-derived line by line, correct

With $b=ta$, $\lambda_1=a(1+t)$: unit norm gives $a^2\cdot2(t^2+t+1)=1$. Then
$$\operatorname{tr}W^3+6\lambda_1ab=a^3\big[(1+t)^3-1-t^3+6t(1+t)\big]=a^3\big[3t(1+t)+6t(1+t)\big]=9a^3t(1+t),$$
and $9t(1+t)/(2(t^2+t+1))^{3/2}=9\sqrt2\,t(t+1)/(4(t^2+t+1)^{3/2})$, **the stated $f(t)$ exactly**.

Stationarity, done by hand rather than asserted: $\frac{\rm d}{{\rm d}t}\log f=0$ gives $\frac{2t+1}{t(1+t)}=\frac{3(2t+1)}{2(t^2+t+1)}$, and since $2t+1>0$ this reduces to $2(t^2+t+1)=3t(t+1)$, i.e. $t^2+t-2=(t+2)(t-1)=0$. **Unique root $t=1$ on $t>0$.** $f$ is moreover invariant under $t\mapsto1/t$ (checked algebraically), so the domain $t\ge1$ forced by $a\le b$ and the domain $t\ge0$ the proof argues on give the same maximum, a gap that could have existed and does not.

## Phase 5, sharpness: the cap is ATTAINED, verified by hand

$\mathrm{Weyl}_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$. Take $W^+=\operatorname{diag}(2,-1,-1)/\sqrt6$, $W^-=0$.

- $\lVert W\rVert^2=(4+1+1)/6=1$. ✓
- $\Lambda^2$ spectrum is $(2,-1,-1)/\sqrt6$ **together with three zeros from $\Lambda^-$**, one positive, two negative, rest zero, so the hypothesis holds. ✓
- $\operatorname{tr}W^3=(8-1-1)/6^{3/2}=6/(6\sqrt6)=1/\sqrt6$; $\langle W,W^\#\rangle=6\lambda_1ab=6\cdot2/6^{3/2}=2/\sqrt6$; $P=3/\sqrt6=\sqrt6/2=\sqrt{3/2}$. ✓

So this is **a sharp theorem, not an unattained cap**. The block's separate claim that the inequality is an *identity* on the whole stratum also checks: I verified $[\omega_1,\omega_2]=-\sqrt2\omega_3$ directly, so every orthonormal pair in $\Lambda^+\cong\mathfrak{su}(2)$ saturates the pair cap, and $\theta=f(t)$ holds with equality for every $t$, not only at $t=1$.

## Phase 6, the vanishing claim: correct, and the threshold is sharp

*"$c'$ is antisymmetric in three indices, so $S$ vanishes identically once $\dim\mathfrak m\le2$."*

- **The antisymmetry is in the indices claimed.** $c'_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle$ is totally antisymmetric by ad-invariance of the inner product, [conventions.md](../findings/conventions.md) states this, and it is what makes $T=c'^2$ totally symmetric, which the same proof uses two lines earlier.
- **$\dim\mathfrak m\le2$ is exactly the right threshold, neither weaker nor stronger.** $c'\big|_{\mathfrak m}$ is an alternating $3$-form on $\mathfrak m$, and $\Lambda^3(\mathbb R^d)=0$ **iff** $d\le2$. At $d=3$ it need not vanish: $\Lambda^+$ itself has $c'_{123}=\sqrt2\ne0$ (my Phase 1 computation). So the bound is sharp in $\dim\mathfrak m$.
- **The $(---)$ block step is the same fact** and is correct as written.

**The vacuity consequence holds, and is the record's own W3 trap.** At padded $W_{\mathbb{CP}^2}$, $\ker W$ has dimension $N-3$ (three of six at $n=4$), so the sign-graded split (A), which [graded-half.md](../findings/graded-half.md) defines as requiring $\ker W=0$, does not even apply; $S=0$ there is forced by dimension count alone and certifies nothing. That is exactly [W3](../findings/INDEX-traps.md), and the preamble is consistent with it.

## Phase 7, dimension-freeness: confirmed, with padding checked

**No step needs a bound on $n$.** The four ingredients are: the eigenbasis expansion of $\langle W,W^\#\rangle$ (any $n$); $T$ vanishing on repeated indices (any $n$); $\Lambda^3$ of a $2$-space being zero (any $n$); and the pair cap $\lVert[v_\alpha,v_\beta]\rVert^2\le2$, which I re-proved above from the root system of $\mathfrak{so}(n)$ for **every** $n$. The only implicit restriction is $n\ge4$, where $\mathrm{Weyl}_n\ne0$.

**Padding preserves both the hypothesis and the value**, so the statement survives it: padding a $\mathrm{Weyl}_m$ tensor into $\mathbb R^n$ adds **only zero eigenvalues**, leaving the positive and negative counts at $1$ and $2$; and $\lVert W\rVert$ and $\theta$ are preserved ([conventions.md](../findings/conventions.md)). The proof does not go through padding at all (it runs at arbitrary $n$ directly) so this is a check, not a dependency.

**The exclusion arithmetic checks.** $\sqrt{3/2}<\theta_0(n)$ iff $2(n-1)(n-2)>\tfrac32n^2$ iff $n^2-12n+8>0$, i.e. $n\ge12$ ($n=11$ gives $-3$, $n=12$ gives $+8$). At odd $n$ the diagonal maximum is the smaller $\Theta_n$, and that too clears the cap from $n=13$ ($1.2484$), so *"excludes this whole stratum at $n\ge12$"* holds under either ceiling.

## Phase 8, the citations. **Two cite a scope the block's own text denies.**

| site | what it claims L29 gives | as stated, or a strengthening |
| --- | --- | --- |
| [results.md:144](../results.md) | the cap, dimension-free, attained at $(2,-1,-1)/\sqrt6$ | **as stated** |
| [results.md:412](../results.md) | the statement verbatim, converse delegated to L72 | **as stated**, and fresher than the findings block |
| [results.md:767](../results.md) | L72 closes L29's converse clause | **as stated** |
| [plan.md:96](../plan.md) | "the $\le2$-negative stratum is capped at $\sqrt{3/2}$ (L29–L36, L42)" | **as stated**, the stratum claim is carried by the group, and L35 is the member that covers any $k$ |
| [stratum-two-negative.md:11](../findings/stratum-two-negative.md) | pointer to the canonical block | **as stated** |
| [stratum-two-negative.md:272](../findings/stratum-two-negative.md) | *"Lemma L29 already closes $k\le2$ outright"* | **STRENGTHENING** |
| [stratum-two-negative.md:276](../findings/stratum-two-negative.md) | table row: "$k\le2$ positive eigenvalues, Lemma L29, dimension-free" | **STRENGTHENING** |
| [stratum-two-negative.md:421](../findings/stratum-two-negative.md) | table row: "$k\le2$ positive eigenvalues … **proved** (Lemma L29)" | **STRENGTHENING** |
| [stratum-two-negative.md:438](../findings/stratum-two-negative.md) | *"Lemma L29 covered only one positive eigenvalue"* | **as stated**, and it contradicts the three rows above it in the same file |
| [stratum-two-negative.md:501](../findings/stratum-two-negative.md) | L72 closes the converse clause | **as stated** |
| [isotropy-cap.md:290](../findings/isotropy-cap.md) | *"Lemma L29 covers rank 3 only"* | **as stated**, and the correct scope |

**The strengthening is what the canonical block itself refuses.** L29's closing paragraph reads: *"It does not reach two or more positive eigenvalues alongside the two negative ones, where the $(+++)$ and $(++-)$ blocks reappear and the pair cap alone controls neither."* Three citations (two of them tables in the **same file**), nonetheless bill L29 as covering $k\le2$. The source of the strengthening is the development block above L29, which asserts *"$(+++)$ needs three distinct positive indices, so it vanishes at $k=2$ as well; … So the Lemma covers $k\le2$."*

**I derived the $k=2$ case to see how far the strengthening is from true, and the answer is: true, but not for the reason given, and not by L29's argument.**

- The stated reason is **incomplete**: $(+++)$ does vanish at $k=2$, but $(++-)$ does **not**, with two positive indices $1,2$ and one negative, $T_{12\gamma}$ need not vanish. What rescues it is that $(++-)$ carries $\lambda_1\lambda_2\lambda_\gamma<0$, so it is $\le0$ and may be dropped from an **upper** bound. The block never says this.
- The surviving $(+--)$ block at $k=2$ is $3ab\big(T_{1,N-1,N}\lambda_1+T_{2,N-1,N}\lambda_2\big)$, and the pair cap applies to the pair $(N-1,N)$ **jointly**: $T_{1,N-1,N}+T_{2,N-1,N}\le2$. Using the joint form gives $\le6ab\lambda_1$; on the symmetric slice $a=b$ the bound is then $-6a^3+3a+6a^2\sqrt{(1-4a^2)/2}$ on $a\in[1/\sqrt6,1/2]$, which is $1.224745$ at $a=1/\sqrt6$ (padded $W_{\mathbb{CP}^2}$, $\lambda_2=0$) and falls away from it, $1.224676$ at $a=0.41$, $1.221545$ at $0.42$, $1.177739$ at $0.45$.
- **Applying the cap per-index instead (the reading L29's own single-index use invites), breaks the extension.** Bounding each $T_{i,N-1,N}\le2$ separately gives $6ab(\lambda_1+\lambda_2)$, and on the symmetric slice that collapses to exactly $3a$, whose maximum on $a\le\tfrac12$ is $\mathbf{1.5}>\sqrt{3/2}$. So the $k\le2$ extension lives or dies on a step (the joint pair cap) that appears nowhere in the text.

**The scope is now moot but the citations are not.** [Lemma L35](../findings/stratum-two-negative.md) covers at most two negative eigenvalues at **any** number of positive ones, so the $k\le2$ region has a lemma that genuinely proves it. The three rows should cite L35, not L29.

## Phase 9, the block against the rest of its own file, and the record

**(a) The block contradicts itself about Gate 2.** Line 105: *"**Gate 2 passed**: Reviewers 58 and 59 on identical briefs, independent implementations, both CONFIRMED."* Line 113, the block's last sentence: *"Gate 2 is pending."* Both are inside the L29 block. The first is the true one, [REVIEW_r58.md](REVIEW_r58.md) and [REVIEW_r59.md](REVIEW_r59.md) exist and both return CONFIRMED on the bound.

**(b) The statement's converse clause is stale by 430 lines.** L29's **Statement** still hedges: *"reduced to 'no full-support rank-$3$ signature-$(1,2)$ element of $\mathrm{Weyl}_r$ for even $r\ge6$', excluded numerically at $r=6,8,10$ and untested at $r\ge12$."* [Lemma L72](../findings/stratum-two-negative.md) at line 501 of the same file closes exactly that clause analytically, from the three criticality rows, *"with no numerics and no case analysis"*, and says so explicitly. [results.md:412](../results.md) has already been updated to *"The converse … is Lemma L72"*; the canonical block has not. **The canonical proof is the stalest copy of its own statement.**

**(c) One asserted identity is proved only at $r=4$.** *"The pair cap is therefore saturated identically and $\theta=f(t)$ exactly, not merely at the maximiser"* is derived through *"at dimension four $v_2,v_3$ are an orthonormal pair in $\Lambda^+$"*. The support is shown even-dimensional, not four-dimensional, so for stratum elements of support $r\ge6$ the identity rests on the same unclosed non-existence the converse clause names. The **bound** is untouched; the **identity** is conditional. (I checked the $r=4$ reduction independently: with only one positive eigenvalue in total and each of $W^\pm$ trace-free, a nonzero $W^-$ would force $W^+=0$, so one factor vanishes and $v_2,v_3$ are indeed a self-dual orthonormal pair, the WLOG is sound.)

**(d) The route number is wrong.** The block's first line of motivation reads *"the residual of **route R2** is a value bound rather than a classification"*. [routes.md](../routes.md) gives **R2** as *"Cauchy–Schwarz on the sharp term"*, closed by post F34 for restating $\theta\le\theta_0$, nothing to do with $S=0$, with a classification residual, or with $W_{\mathbb{CP}^2}$. The route meant is **R9**, bi-spectral coupling, whose sharp case *is* padded $W_{\mathbb{CP}^2}$. Three independent confirmations:
- [second-order.md:471](../findings/second-order.md), the passage this preamble is a compression of, says *"route **R9**s sharp case sits precisely where the $S=0$ hypothesis carries no information"*;
- [stratum-two-negative.md:417](../findings/stratum-two-negative.md), 348 lines below, says *"which excludes route **R9**s sharpest competitor at every $n\ge12$"*;
- the mechanism of the error is visible in [routes.md](../routes.md)'s own "formerly" column: **R2 was route B and R9 was route B$'$**, so a rename dropping the prime lands on exactly R2.

**(e) $S(W)$ carries two different definitions in the record**, and the block uses the one that is not in the file [conventions.md](../findings/conventions.md) points at. The block's $S(W)=\sum_{\lambda<0}c'^2_{\alpha\beta\gamma}$ is [second-order.md:465](../findings/second-order.md)'s eigenbasis form; [ungraded-slack.md:286](../findings/ungraded-slack.md), the file conventions.md names as $S(W)$'s home, defines $S(W):=\lVert\mathrm{Ric}(W_-)\rVert^2+6\delta^2-\theta\operatorname{tr}(W_-)-\operatorname{tr}(W_-^2)$, and the identification of the two is recorded there as **conditional on bracket conditions that generic critical points violate** (*"the ratio is $11.5$ rather than $\tfrac12$"*). The block's use is self-contained and correct on its own definition; what is missing is the pointer saying which $S$ it means. This is the same class as the $B$, $M$ and $\mu$ collisions conventions.md already tables.

## Phase 10, the provenance line is **FALSE**, and git says so plainly

The block opens: *"Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy."*

The move is commit `84cada75` *"refactor(findings): the four proofs that lived only in results.md move to findings"*. At its parent `94962a6f`, **`findings/stratum-two-negative.md` already contained a complete statement and proof of this lemma**, at its own line 9, headed *"#### Lemma. One positive and two negative eigenvalues force $\theta\le\sqrt{3/2}$"*, carrying the identical **Statement** sentence, the identical four-block **Proof**, the identical $(---)$ line *"needs three indices in a $2$-dimensional space"*, the identical $f(t)$, and the identical *"unique stationary point on $t\ge0$"*:

```
$ git grep -ln "9\\sqrt2\\,t(t+1)"     94962a6f -- '*.md'
94962a6f:findings/stratum-two-negative.md
94962a6f:results.md
94962a6f:scripts/README.md
$ git grep -ln "three indices in a"    94962a6f -- '*.md'
94962a6f:findings/stratum-two-negative.md
94962a6f:results.md
```

So the argument was **not** the only copy, and the destination file was one of the places already holding it. That duplicate is still in place today, at [stratum-two-negative.md:7–67](../findings/stratum-two-negative.md), under the heading *"The one-positive case, in development form"*, which is why this lemma's proof appears **twice** in one file, 60 lines apart. This is the third such provenance line checked against git this session and the third found false; the pattern is a boilerplate sentence applied to a move that was a de-duplication rather than a rescue. [Lemma L33](../findings/stratum-two-negative.md), immediately below, has already had its copy of this sentence corrected in place, so the correction is available as a template.

---

## VERDICT: CONFIRMED

**The statement is true, the proof is complete, and the cap is attained.** Every step re-derived from the definitions: the four-block split is exhaustive and three blocks vanish for the reasons given; the pair cap $\le2$ is a theorem I re-proved from the $\mathfrak{so}(n)$ root system; the collapse to $f(t)$ is exact algebra; the stationary point is unique by $(t+2)(t-1)=0$; the value is $\sqrt6/2=\sqrt{3/2}$ in the record's undeflated normalisation; and padded $W_{\mathbb{CP}^2}$ is a genuine member of the stratum realising it. The hypothesis is unambiguous (**L29 does not carry the multiplicity defect that nearly falsified L33**) and the bound is genuinely dimension-free.

**Six defects, none of them in the theorem.** In descending order of consequence:

1. **Three citations bill L29 as covering $k\le2$ positive eigenvalues** ([272](../findings/stratum-two-negative.md), [276](../findings/stratum-two-negative.md), [421](../findings/stratum-two-negative.md)), which the block's own closing sentence refuses. The extension is true but needs the **joint** pair cap $T_{1,N-1,N}+T_{2,N-1,N}\le2$; under the per-index reading its bound is $3a$, maximum $1.5$. Repoint them at [Lemma L35](../findings/stratum-two-negative.md).
2. **The provenance line is false**, established against git: the destination file already held a complete copy, which is still there.
3. **The block contradicts itself on Gate 2**, "passed" at line 105, "pending" at line 113.
4. **The converse clause is stale**, superseded in the same file by [Lemma L72](../findings/stratum-two-negative.md) and already updated in [results.md](../results.md).
5. **"Route R2" should read "route R9"**, per [routes.md](../routes.md) and two parallel sentences in the record.
6. **The "identity on this stratum" claim is proved at support $4$ only**, and inherits the $r\ge6$ question. The bound does not.

**One wording improvement.** The hypothesis silently requires the other $N-3$ eigenvalues to vanish. Writing *"exactly one positive and two negative eigenvalues, the remaining $N-3$ zero"* closes the only reading under which the statement could be misapplied.
