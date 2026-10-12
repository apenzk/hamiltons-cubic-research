# Review r613, Lemma L119, the sharpened $\lambda$-weighted bound

*Reviewer A of an independent pair on identical briefs; the other reviewer takes r614. Target: [bounds-relaxations.md:300](../findings/bounds-relaxations.md#L300), the block `Lemma L119, the sharpened $\lambda$-weighted bound`, read to the next numbered result at line 322. Derived cold from [conventions.md](../findings/conventions.md), [Lemma L41](../findings/target.md#L679) and [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7; the block's own reasoning was read only after the derivation closed. Analysis-only footing observed: the one machine run below is a screen of figures I derived by hand first, and is reported as a screen.*

## Verdict: **CONFIRMED**

The identity is an identity, the split is exact, both inequality steps go in the direction claimed, and **both halves of the improvement claim are theorems, not measurements**, "never weaker" and "strictly stronger wherever $\Delta>0$" each fall out in one line, and the second is *forced*, with no coincident points. The $C_5$ equality that the block presents as a measured pair of six-digit figures is likewise **derivable exactly**, and the derivation is supplied below; the block's own hedge that it "rests on one witness" understates what is provable about that witness and overstates the loneliness of the witness.

Five defects sit around the result rather than in it. Two are live errors on the record, a stale exclusivity claim that is now false, and an equality case inherited from [Lemma L41](../findings/target.md#L679) that the record contradicts on its own next line, and three are naming and scoping faults that make the statement unreadable outside its own paragraph.

---

## 1. The identity, and what it consumes

Write $R_{\alpha\beta}=\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2$ in an orthonormal eigenbasis $\{v_\gamma\}$ of $W$ on $\Lambda^2$, with $T_{\alpha\beta\gamma}=c_{\alpha\beta\gamma}^2$ totally symmetric by [conventions.md](../findings/conventions.md)'s ad-invariance bullet. Three standing facts:

| | statement | source |
| --- | --- | --- |
| (P) | $g_\gamma=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{\gamma\alpha\beta}$ | [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7, quoted at [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118) |
| (B) | $\sum_\beta\lambda_\beta R_{\alpha\beta}=-2\lambda_\alpha$ for every $\alpha$, the per-row form of $A(W)=2W$, i.e. $W\#I=-W$ | [bounds.md:237](../findings/bounds.md#L237), [plan.md:9](../plan.md#L9) |
| (Q) | $\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}=2\langle W,W^\#\rangle$, free of Bianchi and Ricci-flatness | [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118) |

(P) itself I re-derived rather than took: $[\mathrm{ad}\,v_\gamma,W]$ is symmetric, its $(\alpha\beta)$ entry is $(\lambda_\beta-\lambda_\alpha)c_{\gamma\beta\alpha}$, and squaring gives (P) with the plain Frobenius norm on $\mathrm{End}(\Lambda^2)$. That fixes the normalisation the whole block runs in, and §4 below reproduces $\sum_\gamma g_\gamma=4(n-1)$ from it at an explicit point, which is the check that the $\tfrac12$ of the half-trace pairing has not been applied twice.

Then, expanding the square in (P) and using the total symmetry of $T$ in $\alpha\leftrightarrow\beta$,

$$\sum_\gamma\lambda_\gamma g_\gamma=2\sum_{\alpha\gamma}\lambda_\gamma\lambda_\alpha^2R_{\alpha\gamma}-2\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}\overset{\text{(B),(Q)}}{=}2\sum_\alpha\lambda_\alpha^2(-2\lambda_\alpha)-4\langle W,W^\#\rangle=-4\,\langle W,W^2+W^\#\rangle=-4P(W).$$

**So the identity is $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$, and the block's $-4\theta$ is that at $\lVert W\rVert=1$.** It consumes, exactly:

- **total antisymmetry of the structure constants**, i.e. ad-invariance of the pairing, this is what makes $T$ totally symmetric and licenses the $\alpha\leftrightarrow\beta$ folding;
- **first Bianchi together with Ricci-flatness**, both inside (B), which is why the block's own residual jumps to $0.20$ off $\mathrm{Weyl}_n$;
- **unit norm**, and only to write $P(W)$ as $\theta$; the identity itself is homogeneous of degree three.

**It consumes no criticality.** The block says so and is right. The record is the thing that is wrong here: [results.md:550](../results.md#L550) opens L41 with *"Let $W\in\mathcal W_n$ be a critical point"*, and the hypothesis is never used. Same for $\sum_\gamma g_\gamma=4(n-1)$, which follows from (B) and [conventions.md](../findings/conventions.md)'s Killing marginal $\sum_\beta R_{\alpha\beta}=2(n-2)$ as $4(n-2)+4$, with no criticality and, worth noting against the scoping at [bounds-relaxations.md:118](../findings/bounds-relaxations.md#L118), **no $n\ge5$ either**: the $n\ge5$ hypothesis belongs to the Casimir-and-Schur route to the same constant, and the two-marginal route needs neither irreducibility nor $n\ge5$.

## 2. The split, and the sign at each step

$\mathfrak p$, $\mathfrak m$, $\ker$ partition the eigenvalues by sign, so

$$-4\theta=\sum_{\mathfrak p}\lambda_\gamma g_\gamma+\sum_{\mathfrak m}\lambda_\gamma g_\gamma+0=B-A,\qquad A=\sum_{\mathfrak m}\lvert\lambda_\gamma\rvert g_\gamma\ge0,\quad B=\sum_{\mathfrak p}\lambda_\gamma g_\gamma\ge0,$$

i.e. $4\theta=A-B$ as displayed. Two steps, and each is a one-sided estimate in the direction that raises the right-hand side:

1. **$A\le\lvert\lambda_{\min}\rvert M$** with $M:=\sum_{\mathfrak m}g_\gamma=4(n-1)-\Delta-G_0$, since $\lvert\lambda_\gamma\rvert\le\lvert\lambda_{\min}\rvert$ on $\mathfrak m$ and $g_\gamma\ge0$. **$A$ enters with a plus sign, so over-estimating it is legitimate.**
2. **$B\ge\lambda^{\min}_{\mathfrak p}\Delta$** with $\lambda^{\min}_{\mathfrak p}:=\min\{\lambda_\gamma:\lambda_\gamma>0\}$ and $\Delta=\sum_{\mathfrak p}g_\gamma$, again since $g_\gamma\ge0$. **$B$ enters with a minus sign, so under-estimating it is the legitimate direction.** The recorded bound takes the extreme under-estimate $B\ge0$.

Together $4\theta\le\lvert\lambda_{\min}\rvert M-\lambda^{\min}_{\mathfrak p}\Delta$, which is the claim. **The constant $4$ is the $4$ of the identity and nothing else**, and it is the same $4$ in both bounds; nothing in the split introduces a second factor.

**$-\lambda^{\min}_{\mathfrak p}\Delta$ is a genuine subtraction.** $\mathrm{tr}_{\Lambda^2}W=0$ with $\lVert W\rVert=1$ forces both $\mathfrak p$ and $\mathfrak m$ non-empty, so $\lambda^{\min}_{\mathfrak p}$ is a minimum over a non-empty finite set of *strictly* positive numbers and is itself strictly positive. There is no degenerate case in which the term is an addition in disguise, and no case in which the symbol is undefined.

A restatement that makes the shape visible: at fixed $\lvert\lambda_{\min}\rvert$, $\lambda^{\min}_{\mathfrak p}$ and $G_0$,

$$\text{RHS}=\frac{\lvert\lambda_{\min}\rvert\big(4(n-1)-G_0\big)-\big(\lvert\lambda_{\min}\rvert+\lambda^{\min}_{\mathfrak p}\big)\Delta}{4},$$

so L119 is L41 with the slope in $\Delta$ steepened from $-\lvert\lambda_{\min}\rvert/4$ to $-(\lvert\lambda_{\min}\rvert+\lambda^{\min}_{\mathfrak p})/4$. That is the "upper bound on $\theta$ decreasing in $\Delta$" [plan.md](../plan.md) asks for, with a strictly larger decrease rate.

## 3. "Never weaker, strictly stronger wherever $\Delta>0$", both proven

- **Never weaker.** The two right-hand sides differ by $-\lambda^{\min}_{\mathfrak p}\Delta/4\le0$ at every admissible $W$, since $\lambda^{\min}_{\mathfrak p}>0$ and $\Delta\ge0$. **PROVEN**, and it is an inequality between the right-hand sides, so it holds whether or not either bound is attained.
- **Strictly stronger wherever $\Delta>0$.** The gap is $\lambda^{\min}_{\mathfrak p}\Delta/4$, and $\lambda^{\min}_{\mathfrak p}>0$ is *forced* by tracelessness as above, never an extra hypothesis. **PROVEN, and there are no $\Delta>0$ points at which the two bounds coincide.** The strictness the brief asked me to test for is unconditional.

**What strictness does not carry is a size.** $\inf\{\lambda^{\min}_{\mathfrak p}\Delta/4:\Delta>0\}=0$, because $\lambda^{\min}_{\mathfrak p}\to0^+$ along any path in $\mathcal W_n$ on which one positive eigenvalue crosses zero while another positive eigenvalue retains positive $g$-mass, and the bound is valid at every Weyl tensor, so such paths need not stay critical. So no statement of the form "sharpened $\le$ unsharpened $-\varepsilon$" holds on $\{\Delta>0\}$, and the sharpening cannot upgrade a pointwise statement into a uniform one. This is the same zero-crossing at which [conventions.md](../findings/conventions.md) records $\Delta$ itself as discontinuous, and at which [diagonal-half.md:118](../findings/diagonal-half.md#L118) records the tolerance episode; the factor $\lambda^{\min}_{\mathfrak p}$ is what makes the *product* continuous there even though $\Delta$ is not, which is a small point in the sharpening's favour that the block does not make.

## 4. The $C_5$ blow-up: the equality is **derived**, and here is the derivation

The block gives $0.894427\to0.670820$ as figures from a script. They are exact, and both they and the equality follow from the structure of the example in half a page. **The block's label is safe and its evidence is weaker than what is available.**

**The point.** Five blocks of two on a $5$-cycle, $n=10$; block-constant sectional matrix $M$ with in-block entry $x$, adjacent-block $y$, non-adjacent-block $z$; hollow and symmetric by construction. Ricci-flatness is the row sum $x+4y+4z=0$. The diagonal-locus criticality equation $M^{\circ2}+M^2=\theta M+\mathrm{diag}(s_i)$ of [bounds-relaxations.md:292](../findings/bounds-relaxations.md#L292) reads off-diagonally, per entry type,

$$x^2+4y^2+4z^2=\theta x,\qquad y^2+2xy+4yz+2z^2=\theta y,\qquad z^2+2xz+2y^2+4yz=\theta z.$$

Subtracting the last from the middle and dividing by $y-z$ gives $\theta=2x-(y+z)$; with $s:=y+z$ and $x=-4s$ this is $\theta=-9s$. Feeding both into the first equation gives $yz=-2s^2$, so $y$ and $z$ are the roots of $u^2-su-2s^2$, namely $2s$ and $-s$. Unit norm, $\sum_{a\ne b}M_{ab}^2=2$, is $360s^2=2$, so $s=-1/(6\sqrt5)$ on the $\theta>0$ branch, and

$$x=\tfrac{2}{3\sqrt5},\qquad y=-\tfrac{1}{3\sqrt5},\qquad z=\tfrac{1}{6\sqrt5},\qquad \boxed{\theta=-9s=\tfrac{3}{2\sqrt5}=0.6708203932\ldots}$$

**The spectrum.** On the diagonal locus the $\Lambda^2$ spectrum is the multiset of *entries* of $M$ ([conventions.md](../findings/conventions.md)): $x$ with multiplicity $5$, $y$ with $20$, $z$ with $20$. So $\dim\mathfrak m=20$, $\dim\ker=0$, $\dim\mathfrak p=25$, **matching the $C_5$ row of the table at [bounds.md:123](../findings/bounds.md#L123) column for column**, which is an independent check of the reconstruction against a part of the record that knows nothing about this bound. Also $\lambda_{\min}=y$ and $\lambda^{\min}_{\mathfrak p}=z$.

**The densities.** On the diagonal locus the only non-vanishing structure constant is $[\varphi_{ab},\varphi_{bd}]=\varphi_{ad}$ ([diagonal-half.md:88](../findings/diagonal-half.md#L88)), so (P) collapses to $g_{ab}=2\sum_{d\ne a,b}(M_{ad}-M_{bd})^2$, the same formula that makes [diagonal-half.md:96](../findings/diagonal-half.md#L96)'s twin criterion true. Evaluating with $s^2=1/180$:

| pair type | $\lambda$ | multiplicity | $g$ | mass |
| --- | --- | --- | --- | --- |
| in-block | $x=+0.298142$ | $5$ | $0$ | $0$ |
| adjacent-block | $y=-0.149071$ | $20$ | $216s^2=1.2$ | $24$ |
| non-adjacent-block | $z=+0.074536$ | $20$ | $108s^2=0.6$ | $12$ |

$\sum_\gamma g_\gamma=36=4(n-1)$, $\Delta=12$, $G_0=0$, $M=24$, reproducing the record's $\Delta=12$ at [bounds.md:130](../findings/bounds.md#L130) and confirming the norm convention of §1.

**The two bounds, exactly.**

$$\text{L41}=\frac{\lvert\lambda_{\min}\rvert M}{4}=\frac{1}{3\sqrt5}\cdot6=\frac{2}{\sqrt5}=0.8944271910\ldots,\qquad \text{L119}=\frac{\frac{8}{\sqrt5}-\frac{2}{\sqrt5}}{4}=\frac{3}{2\sqrt5}=\theta.$$

**The mechanism, which is the part worth recording.** Equality in L119 needs equality in *both* steps of §2, and the example supplies each for a structural reason:

- $\mathfrak m$ is a **single** eigenvalue ($y$, multiplicity $20$), so step 1 is an equality automatically;
- $\mathfrak p$ carries **two** eigenvalues, but $g$ vanishes identically on the larger one, because the two vertices of each block are twins ($M_{ad}=M_{bd}$ for every outside $d$) and the in-block bivector is therefore an infinitesimal symmetry, so $B=z\Delta=\lambda^{\min}_{\mathfrak p}\Delta$ exactly.

So "recovers all the slack" is **derived, not measured**, and its cause is nameable. What it is *not* is a statement about a family: it is an [Observation](../findings/INDEX-results.md) about this witness that happens to admit a proof, and the general fact behind it is the equality case in §5 below.

*Screen (permitted allowance; seconds of compute on an object constructed for the purpose, reported as a screen and not as evidence for any positive claim).* The $10\times10$ matrix above, built from the closed forms, returns row sums $0$, $\lVert M\rVert_F^2=2.0$, $\sum\lambda^2=1$, criticality residual $1.4\times10^{-17}$, $\sum g=36$, $\sum\lambda g=-2.68328=-4\theta$, $\Delta=12$, $G_0=0$, $M=24$, $(\dim\mathfrak m,\dim\ker,\dim\mathfrak p)=(20,0,25)$, L41 $=0.894427190999916$ and L119 $=\theta=0.6708203932499369$. Every hand value above is reproduced; nothing here is offered as evidence for anything not already proved.

## 5. Five defects, all outside the mathematics

**(D1), LIVE ERROR. "$C_5$ is the only catalogued critical point with $\Delta>0$" is false.** It was true when written: the sentence entered on 2026-08-24 by `1c0f1d2b`, *"feat(conjecture-a): the bound's discarded term IS the Delta term"*. It is contradicted today by four places, one of them **twenty lines above it in its own file**:

- [bounds-relaxations.md:292](../findings/bounds-relaxations.md#L292), the block immediately preceding, $\ge61$ circulant $\Delta>0$ witnesses, $\ge22$ of them in the band;
- [bounds.md:82](../findings/bounds.md#L82), *"$35$ independent $\Delta>0$ critical classes at $n=6,8,10$ plus the $C_5$ blow-up"*, entered 2026-09-01;
- [diagonal-half.md:199](../findings/diagonal-half.md#L199), $66$ distinct $\Delta>0$ points;
- [INDEX-values.md:40](../findings/INDEX-values.md#L40), the $n=12$ diagonal point at $\theta=0.716134$, $\Delta=16.3998$, *"it displaces the $C_5$ blow-up as the ceiling"*.

The sentence is the sole support for the block's own hedge that the improvement rests on one witness, so the hedge is now understated rather than overstated. **And the block's own file already carries a strictly better second witness that it does not connect to L119**: at [bounds-relaxations.md:296](../findings/bounds-relaxations.md#L296) the $n=12$ point with $\theta=0.728768$ has L41 $=1.348672$ and L119 $=1.123155$, the sharpening does not merely recover slack there, it carries the bound from above $\Theta_{12}=\theta_0(12)=1.236033$ to below it, which is the only recorded instance of the sharpening deciding something the unsharpened bound could not.

**(D2), LIVE ERROR, inherited. The equality case on the canon is too strong, and the record refutes it on its own next line.** [Lemma L41](../findings/target.md#L679) and [results.md:550](../results.md#L550) both state equality *"exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace"*. Equality in L41 forces $B=0$ and $A=\lvert\lambda_{\min}\rvert M$, i.e. $g$ vanishes on $\mathfrak p$ and on $\mathfrak m\setminus E_{\lambda_{\min}}$, **and says nothing about $\ker W$, whose mass is subtracted out through $G_0$.** [bounds-relaxations.md:316](../findings/bounds-relaxations.md#L316), sixteen lines below L119, records equality at both padded points *"with $G_0=16$ and $8$"*, i.e. at points where $g$ is manifestly not supported on $E_{\lambda_{\min}}$. The correct condition is

$$\text{L41 equality}\iff g\ \text{supported on}\ E_{\lambda_{\min}}\oplus\ker W,$$

and L119's analogue, which **the block states nowhere and which is what makes §4 a proof rather than a coincidence**, is

$$\text{L119 equality}\iff g\ \text{supported on}\ E_{\lambda_{\min}}\oplus E_{\lambda^{\min}_{\mathfrak p}}\oplus\ker W.$$

That belongs in the block. One consequence is free and worth recording with it: since $\Delta>0\Rightarrow B>0$, **L41 is strictly slack at every $\Delta>0$ point**, so the block's *"nowhere else"* is provable on that side even though its stated *"why"* is only half the reason, $\Delta=0$ is necessary for L41 equality and not sufficient.

**(D3), NAMING. $M$ and $\lambda^{\min}_{\mathfrak p}$ are defined nowhere the reader will look, and $M$ collides.** The block's $M=4(n-1)-\Delta-G_0$ is the $\mathfrak m$-mass of $g$. [conventions.md](../findings/conventions.md) already tables $M(n)$ as **the global maximum of $P$ on the unit sphere** and $M$ as the $n\times n$ sectional matrix. The heading at [bounds-relaxations.md:300](../findings/bounds-relaxations.md#L300) uses the symbol before the definition appears at line 310, and **[INDEX-results.md:137](../findings/INDEX-results.md#L137) reproduces the heading with no definition at all**, a reader who takes the tabled sense reads a false statement, since $M(n)\ge\sqrt{3/2}$ while the true $M$ runs to $4(n-1)$. $\lambda^{\min}_{\mathfrak p}$ appears at four places on the record ([fence-posts.md:85](../findings/fence-posts.md#L85) among them) and is defined at none. Both need a line in [conventions.md](../findings/conventions.md), or the mass needs a letter that is not $M$.

**(D4), SCOPING. $\mathfrak m$ must be the whole negative eigenspace, and the block does not say so.** [conventions.md](../findings/conventions.md) tables $\mathfrak m=E_{\min}$ at a critical point, flagging that the letter carries three incompatible senses. **Under the tabled sense the displayed identity $4\theta=A-B$ is false**, since the intermediate negative eigenvalues would be dropped from a partition that must be exhaustive. The block needs [L36](../findings/isotropy-cap.md)'s sense, and never names it. The $C_5$ witness cannot catch this: there $\mathfrak m$ is a single eigenvalue and the two senses coincide, so the block's only worked example is exactly the one blind to the ambiguity.

**(D5), SCOPING. "that is, everywhere in the band not already handed to step H" asserts an equivalence where only one inclusion holds, and the inclusion needed does hold.** [bounds.md:108](../findings/bounds.md#L108) proves $\Delta=0\Rightarrow$ graded, hence $\{\Delta=0\}\subseteq$ H's territory, hence $\text{band}\setminus\text{H}\subseteq\{\Delta>0\}$, which is the direction the claim needs, so **the operative content survives**. The converse is explicitly withdrawn at [target.md:530](../findings/target.md#L530), which catalogues a graded critical point at $n=8$ with $\Delta=1.512$; so $\{\Delta>0\}$ properly contains $\text{band}\setminus\text{H}$ and the "that is" is wrong as an identification. The inclusion also carries two hypotheses the block omits, **$S=0$ and trivial kernel**, the second being [W1](../findings/INDEX-traps.md)'s standing trap, under which *"$\Delta=0\Rightarrow$ equivariant"* is recorded as unsound.

## 6. Scope, and what it buys

**What the statement owes, as opposed to what the proof uses.** Every $n\ge4$, every $W\in\mathcal W_n$ with $\lVert W\rVert=1$. **No criticality, no diagonality, no $S=0$, no $n\ge5$, no kernel hypothesis.** The splitting is available everywhere, $\mathfrak p$, $\mathfrak m$, $\ker$ partition any spectrum, and tracelessness keeps $\mathfrak p$ non-empty, so nothing about availability restricts the scope. The block reaches the same conclusion by a different route and is right; the record around it ([results.md:550](../results.md#L550)) still carries the unnecessary criticality hypothesis and should drop it.

**What it buys toward $\Theta_n$: nothing yet, and the reason is structural rather than quantitative.**

- **On $\{\Delta=0\}$ the two bounds are the same function.** That set contains every catalogued symmetric-space point and the conjectured maximiser, and [bounds-relaxations.md:316](../findings/bounds-relaxations.md#L316) records the bound returning $\theta_0(12)=1.236033$ there exactly. At $n=12$, even, $\Theta_{12}=\theta_0(12)$ and the block's use of $\theta_0$ is correct, **the block names $\theta_0$ at even $n$ only and does not conflate it with $\Theta_n$ anywhere**, so the trap the brief warns of is not sprung here. The consequence, though, is that **the sharpening buys exactly zero at the one point where the bound is known to be sharp**.
- **On $\{\Delta>0\}$ the gain is $\lambda^{\min}_{\mathfrak p}\Delta/4$ with infimum $0$** (§3), so it cannot be converted into a uniform improvement.
- **The obstruction is untouched.** The block's own closing sentence at line 316 names it (*"the missing ingredient is control of $\lvert\lambda_{\min}\rvert$"*) and $\lvert\lambda_{\min}\rvert$ multiplies the leading term in both bounds identically. L119 changes the coefficient of $\Delta$ and nothing else.

**By how much and at which $n$ it still misses is not on the record, and settling it needs computation I do not have approval for.** The recorded excess figures are all for the *unsharpened* bound: $1.367$ at $n=8$ against $\Theta_8=\theta_0(8)=1.145644$, an excess of $0.221$ at random points ([bounds-relaxations.md:316](../findings/bounds-relaxations.md#L316)). **The supremum of the sharpened bound is reported nowhere.** The run that would decide it is a maximisation of the L119 right-hand side over unit $W\in\mathcal W_n$ at $n=8,10,12$, and its outcomes read: a supremum below $\Theta_n$ would close the band by this bound alone and is the strongest outcome available to this route; a supremum above $\Theta_n$ attained on $\{\Delta>0\}$ would locate the residual precisely and price the missing $\lvert\lambda_{\min}\rvert$ control; a supremum above $\Theta_n$ attained on $\{\Delta=0\}$ would show the sharpening irrelevant to the obstruction, which §6's first bullet already makes the expected answer. **Blocked here, and recorded as blocked.**

## 7. Pointers

All resolve. [b_sharpened_lambda_bound.py](../scripts/route-b/b_sharpened_lambda_bound.py), [b_lambda_weighted_bound.py](../scripts/route-b/b_lambda_weighted_bound.py) and [b_circulant_band_witnesses.py](../scripts/lib/b_circulant_band_witnesses.py) exist at the paths given; [r341](REVIEW_r341.md), [r342](REVIEW_r342.md), [r73](REVIEW_r73.md) and [r74](REVIEW_r74.md) exist. Two notes:

- **The block's provenance is true and unlinked.** *"Both reviewers found it holds at non-critical Weyl tensors too"* traces by phrase grep to `d657dcc4`, *"fix(conjecture-a): Gate 2 reviewers 73 and 74"*, so the reviewers are [r73](REVIEW_r73.md) and [r74](REVIEW_r74.md), linked in the neighbouring block and not in this one. **Checked, and clean**, against the checklist's warning.
- **The brief's scoping note is confirmed.** The Gate 2 by [r341](REVIEW_r341.md) and [r342](REVIEW_r342.md) sits under the *next* section heading, at [bounds-relaxations.md:318](../findings/bounds-relaxations.md#L318), and covers the linear-programme reduction and [Lemma L105](../findings/bounds-relaxations.md#L341). L119's own block says *"Gate 2 pending"* and [INDEX-results.md:137](../findings/INDEX-results.md#L137) says *"no verdict on the record"*. **Nothing in the block claims the LP audit as support for the bound.**
- **Two unnumbered `####` headings sit inside the L119 block** (line 302 and line 314) and line 314's *"Reproduced in the tree"* is L41's numerics, filed under L119's number. A reader taking the block as "line 300 to the next numbered result" inherits L41's measurements as L119's.

## 8. What the record may cite

| claim | status |
| --- | --- |
| $\sum_\gamma\lambda_\gamma g_\gamma=-4P(W)$ on $\mathcal W_n$, no criticality | **proved**, §1 |
| $\theta\le[\lvert\lambda_{\min}\rvert M-\lambda^{\min}_{\mathfrak p}\Delta]/4$ at every unit $W\in\mathcal W_n$, $n\ge4$ | **proved**, §2 |
| never weaker than L41 | **proved**, §3 |
| strictly stronger wherever $\Delta>0$, with no coincident points | **proved**, §3 |
| the gain has no uniform positive lower bound on $\{\Delta>0\}$ | **proved**, §3 |
| equality iff $g$ is supported on $E_{\lambda_{\min}}\oplus E_{\lambda^{\min}_{\mathfrak p}}\oplus\ker W$ | **proved**, §5 (D2), not on the record |
| at the $C_5$ blow-up the sharpened bound equals $\theta=3/(2\sqrt5)$ exactly, for a nameable structural reason | **proved**, §4, the block records it as measurement |
| "$C_5$ is the only catalogued critical point with $\Delta>0$" | **false today**, §5 (D1), strike it |
| L41 equality "exactly when $g$ is supported on the $\lambda_{\min}$ eigenspace" | **false**, §5 (D2), correct it on [results.md](../results.md) and [target.md](../findings/target.md) |
| the size of the improvement on the band | **unsupported**, and the block says so; two witnesses now, not one |
| the sharpened bound's supremum, hence its reach toward $\Theta_n$ | **blocked**, §6, needs computation, outcomes named |
