# Review r569, Lemma L35

Reviewer r569, independent adversarial audit. Target: `Lemma L35, at most two negative eigenvalues caps $\theta$ at $\sqrt{3/2}$, unconditionally`, in [findings/stratum-two-negative.md](../findings/stratum-two-negative.md).

Analysis-only footing: no computation was run beyond screening claims about to be recorded; any screen is labelled as such and is never offered as evidence for a positive claim.

Verdicts are appended below as they are reached.

## Verdict, up front

**CONFIRMED as a mathematical claim.** Every step of the chain that is stated on the record is correct, and I reconstructed the two pieces the block leaves implicit (the meaning of $A$ and the origin of $g(A)$), from the definitions alone, by a route that shares nothing with the block's presentation. The bound is attained, and attained exactly where the record says.

**Six defects, none of them fatal to the bound.** Four are statement defects; one is a reconstructibility gap that stops a reader closing the argument by hand; one is a stale forward reference inside the block's own file. They are listed below with drop-in repairs. I did not edit [findings/stratum-two-negative.md](../findings/stratum-two-negative.md), because a second reviewer works this brief in parallel and two concurrent edits to the same lines would collide.

---

## What the block is, and where its argument lives

[Lemma L35](../findings/stratum-two-negative.md) sits at line 435 of [stratum-two-negative.md](../findings/stratum-two-negative.md). The block states the claim its heading announces, and it carries a summary of the argument rather than the argument. **The argument is elsewhere in the same file**, the re-filed section beginning at line 512, `The $\theta\le\mathrm{LP}\le G\le\sqrt{3/2}$ chain for two negative eigenvalues`. That section is the fourth in this audit series to carry a block's proof away from the block, and the block does not link to it.

---

## Defect D1, the identity omits unit norm. Verdict: REAL

The block writes

$$\theta=\sum_\alpha\lambda_\alpha^3+3\!\!\sum_{\alpha<\beta<\gamma}\!\!T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma,\qquad\text{"an identity requiring no Weyl hypothesis"}.$$

**The "no Weyl hypothesis" half is right, and I checked it rather than took it.** Writing $W^\#$ through the structure constants, $(W^\#)_{\alpha\alpha}=\tfrac12\sum_{\gamma\delta}c_{\alpha\gamma\delta}^2\lambda_\gamma\lambda_\delta$ in any orthonormal eigenbasis of $W$, so $\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\gamma\delta}T\lambda\lambda\lambda=3\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$, the factor $3$ is the record's own, and it agrees with [Lemma L29](../findings/stratum-two-negative.md)'s $\langle W,W^\#\rangle=\tfrac12\sum T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma$ and with its $(+--)$ block $3T_{1,N-1,N}\lambda_1ab$. Nothing in that derivation uses the first Bianchi identity, trace-freeness, or that $W$ lands in $\mathcal W_m$. It uses only that $W$ is a symmetric operator on $\Lambda^2\mathbb R^m$.

**What it does use, and the block omits, is $\lVert W\rVert=1$.** By [conventions.md](../findings/conventions.md), $\theta=P(W)/\lVert W\rVert^3$. The right-hand side above is $P(W)$, homogeneous of degree $3$; the two agree only at $\lVert W\rVert=1$. This is the identical omission [L70](../findings/bounds.md)'s audit found in its "what the identity does not need" list, in a second block, on a second day.

**Repair.** *"an identity requiring no Weyl hypothesis, at $\lVert W\rVert=1$"*.

## Defect D2, the chain consumes two hypotheses the block never names. Verdict: REAL

Once past the identity, the chain uses $\mathop{\mathrm{tr}}W=0$ and $\lVert W\rVert=1$ twice more and says so nowhere:

- $s=b+c$, where $s=\sum_{\lambda>0}\lambda$ and $-b,-c$ are the negatives, this is trace-freeness.
- $bc=(s^2+u-1)/2$ with $u=\sum_{\lambda>0}\lambda^2$, from $b^2+c^2=1-u$, which is unit norm, together with $(b+c)^2=s^2$.

**What this buys, and it is worth stating positively.** The chain never touches the first Bianchi identity. So what L35 actually proves is *stronger* than what it claims: **the bound $\theta\le\sqrt{3/2}$ holds for every trace-free unit-norm symmetric operator on $\Lambda^2\mathbb R^m$ with at most two negative eigenvalues, Weyl or not.** The pair cap is [Lemma L31](../findings/stratum-two-negative.md), which is a fact about orthonormal pairs in $\mathfrak{so}(m)$ and asks nothing of $W$. The record already half-knows this, correction *(i)* in the same file says the Cauchy–Schwarz step is "true of any two-negative spectrum, Weyl or not", and does not draw the conclusion.

## Defect D3, the row marginal, and the number behind it. Verdict: MINOR, and the brief's premise needs one correction

The block relaxes to tensors "with row marginals $m-2$". **That value is right under the unordered reading and wrong under the record's stated default.** [conventions.md](../findings/conventions.md) fixes "sums over pairs are over ORDERED pairs unless the line says otherwise" and records the Killing marginal as $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$. I re-derived that constant rather than quoting it: $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=-\mathop{\mathrm{tr}}(\mathrm{ad}_{v_\alpha}^2)=-B(v_\alpha,v_\alpha)=-(n-2)\mathop{\mathrm{tr}}(v_\alpha^2)=2(n-2)$. Halving for unordered $\{\beta,\gamma\}$ gives $m-2$, which is what the objective's $\sum_{\alpha<\beta<\gamma}$ convention wants. So the block is self-consistent and reads against the file that governs it.

**It costs the bound nothing, and the reason matters.** If the marginal were read as an equality at the wrong value, the true $T$ would be *infeasible* and the very first step $\theta\le\mathrm{LP}(\lambda)$ would fail. It survives only because the marginals are dropped one line later. **A constraint that is stated ambiguously and then discarded is safe; the same ambiguity in a constraint that is kept is not.**

The brief is right that the marginal carries no result number anywhere. It is a Casimir identity, three lines, and would carry one cheaply.

## Defect D4, undefined load-bearing symbols. Verdict: REAL, and it is the largest defect here

**Nine symbols carry the argument and none of them is defined on the record.** I grepped [findings/](../findings/), [results.md](../results.md) and [report/](../report/) for each.

| symbol | where it is load-bearing | status |
| --- | --- | --- |
| $A$ | the whole endgame, "an envelope whose maximum is exactly $\sqrt{3/2}$ at $A=\sqrt{2/3}$" | **defined nowhere** |
| $d$ | $h\le\min(\lambda_1,\tfrac3{2\sqrt2}\sqrt d)$ | **defined nowhere**, and collides with [conventions.md](../findings/conventions.md)'s $d=(d_\varphi,d_\psi)$, the diagonal of $\mathring W$ |
| $\mathrm{FTP}$ | the decoupled formula for $G$ | **defined nowhere**; it is [Lemma L42](../findings/stratum-two-negative.md)'s $M(\lambda_P)$ under a second name |
| $\psi$, $\alpha$, $\beta$, $\gamma$ | the residual one-variable inequality, all three ranges | **defined nowhere**, only $\alpha'$, $\beta'$ and two point values appear |
| $T$ (the cap $\tfrac{2\sqrt2}{3}A$) | the constrained branch | **defined nowhere**, and collides with $T_{\alpha\beta\gamma}$, the bracket tensor, used twenty lines earlier in the same argument |
| $K_0$ | the repair $Q=\tfrac12\sup g''+9K_0^2(A_0+A)^2/(4\lvert\beta\rvert)$ | **defined nowhere** |

**$M$ is now a fourth object under one letter.** [conventions.md](../findings/conventions.md) already tables $M(n)$ the global maximum, $M$ the sectional matrix, and warns on the pair. [Lemma L42](../findings/stratum-two-negative.md) adds $M(\lambda_P)$, the triangle-packing optimum. The L35 block then calls the same quantity $\mathrm{FTP}$, so the file uses two names for one object and one name for four.

**I recovered $A$ and $d$ from the definitions, and they are what makes the block checkable.** Both come out of the arithmetic, not out of a search:

- **$d=u-\lambda_1^2$.** The three bounds the block half-states then all hold, each in one line: $d\le(s-\lambda_1)^2$ is Cauchy–Schwarz on the positives past the first; $\sum_P\lambda^3\le\lambda_1^3+\min(\lambda_1,\sqrt d)\,d$ from $\sum_{\alpha\ge2}\lambda^3\le\lambda_2\sum_{\alpha\ge2}\lambda^2$ with $\lambda_2\le\min(\lambda_1,\sqrt d)$; and $h\le\tfrac3{2\sqrt2}\sqrt d$ because $h\le\tfrac32\,\mathrm{HM}(\lambda_2,\lambda_3)\le\tfrac32\sqrt{(\lambda_2^2+\lambda_3^2)/2}\le\tfrac32\sqrt{d/2}$.
- **$A=\lambda_1$.** Forced by $A_0=\sqrt{2/3}=2/\sqrt6$, which is $\lambda_1$ at the spectrum $(2,-1,-1)/\sqrt6$.

**Repair.** A definitions line in the block: *$A=\lambda_1$, $d=u-\lambda_1^2$, $t=\sqrt d$ with cap $T=\tfrac{2\sqrt2}3A$, and $\mathrm{FTP}(\lambda_P)=M(\lambda_P)$ of [Lemma L42](../findings/stratum-two-negative.md)*; and either a definition of $\psi(t)=\alpha t+\beta t^2+\gamma t^3$ with its three coefficients as functions of $A$, or a pointer to where they are derived.

---

## What I confirmed, and by what route

### The decoupling is an identity, and "exactly" is the right word. CONFIRMED

The brief asks whether "$G$ decouples exactly" is an identity or an inequality dressed as one. **It is an identity, and the reason is a constraint-graph argument the block does not give.**

With positives $\lambda_1\ge\dots\ge\lambda_k>0$ and negatives $-b,-c$, sort the triples by sign:

| type | product | optimal $t$ | pairs it consumes |
| --- | --- | --- | --- |
| $(+++)$ | $>0$ | as large as the caps allow | $(++)$ pairs only |
| $(++-)$ | $<0$ | $0$, since $t\ge0$ and the term is free to drop |, |
| $(+--)$ | $>0$ | as large as the caps allow | the single $(--)$ pair, and $(+-)$ pairs |
| $(---)$ | (| no such triple exists with two negatives |), |

**The two live families consume disjoint pair constraints**, so the maximum splits with no loss. On the $(+--)$ side the binding constraint is the single $(--)$ pair, $\sum_\gamma t_{\gamma,N-1,N}\le2$; the $(+-)$ caps are slacker, each permitting $2$ on its own. So all of it goes to the largest positive and the family is worth exactly $2bc\lambda_1$, entering the identity with its factor $3$ as $6bc\lambda_1$. On the $(+++)$ side nothing has been touched, so it is $\mathrm{FTP}(\lambda_P)$ unchanged.

**And the block's closed form is then exactly right**, which I checked term by term. Using $b^3+c^3=s^3-3bcs$,

$$\textstyle\sum_\alpha\lambda_\alpha^3=\sum_P\lambda^3-s^3+3bcs,\qquad G=\sum_P\lambda^3+3\,\mathrm{FTP}(\lambda_P)-s^3+3bc(s+2\lambda_1),$$

which is the block's formula, provided $\sum\lambda^3$ there is read over the **positives only**. The block writes it as a bare $\sum\lambda^3$ twenty lines after using $\sum_\alpha\lambda_\alpha^3$ over all eigenvalues for the same-looking sum. That is a seventh naming collision inside one argument; the formula is correct under the positives reading and false under the other.

### The relaxation contains the true $T$. CONFIRMED

Nonnegativity holds because $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$. Total symmetry holds because the structure constants are totally antisymmetric ([conventions.md](../findings/conventions.md)) and squaring restores symmetry. The pair caps hold by [Lemma L31](../findings/stratum-two-negative.md), which is a statement about any orthonormal pair in $\mathfrak{so}(m)$ under the half-trace norm, the norm the record runs in, so no conversion is owed. The marginals hold as equalities, at the value D3 discusses.

**Dropping the marginals is safe**, as the block says. **Restricting to the nonzero eigenvalues is also safe, and the block asserts it without the reason**: the objective involves no index with $\lambda=0$, and the pair caps on the surviving pairs are unchanged by deleting the rest, so the two maxima coincide. Both steps go the enlarging way. So does the whole chain: $\theta\le\mathrm{LP}(\lambda)\le G$.

### The endgame reproduces $\sqrt{3/2}$ from a closed form, and the value is predicted rather than fitted. CONFIRMED

This is the brief's question (2), and the answer is the opposite of what [L107](../findings/bounds.md)'s audit found. **The constant falls out of an exact stationarity computation, and I did the computation by hand.**

Set $A=\lambda_1$ and put the relaxation on the boundary $s^2=2-2u$, which the block reaches by monotonicity and which is exactly $b=c$, since $(b+c)^2\le2(b^2+c^2)$ with equality iff $b=c$. At $d=0$ the whole of $G$ becomes, with $b=c=\sqrt{(1-A^2)/2}$,

$$G=A^3-2b^3+6b^2A=A^3-\frac{(1-A^2)^{3/2}}{\sqrt2}+3A(1-A^2),$$

**which is the block's $g(A)$ on the nose.** So $g$ is not an ansatz: it is $G$ restricted to the corner of its own feasible region.

**The domain is forced, not chosen.** $u\ge\lambda_1^2=A^2$ and $s\ge\lambda_1=A$ give $A^2\le s^2=2-2u\le2-2A^2$, hence $A\le\sqrt{2/3}=A_0$. **The maximum of $g$ therefore sits at the right-hand endpoint of an interval whose endpoint the constraints put there.**

Then, all by hand:

$$g(A_0)=\sqrt6\Big(\tfrac4{18}-\tfrac1{18}+\tfrac6{18}\Big)=\tfrac{\sqrt6}2=\sqrt{3/2},\qquad g'(A)=3-6A^2+\tfrac32A\sqrt{2-2A^2},\qquad g'(A_0)=-1+1=0,$$

$$g''(A)=-12A+\tfrac32\sqrt{2-2A^2}-\tfrac{3A^2}{\sqrt{2-2A^2}},\qquad -\tfrac12g''(A_0)=\tfrac{27}4\sqrt{\tfrac23}=\tfrac94\sqrt6 .$$

Every one of these matches the block. **So the argument predicts the value.** Chronologically the value did come first, `git log -S` puts `def42aff` (2026-08-23, the one-positive case proved at $\sqrt{3/2}$) before `cb65b285`, `3884b68b` and `2917be82` the same day, but the general chain reaches it through a stationarity condition that knows nothing about the earlier proof, and the two agree because both are describing padded $W_{\mathbb{CP}^2}$.

### The undefined $\alpha$ and $\beta$ are internally consistent, which is worth recording. CONFIRMED

Neither is defined, but the block leaves enough to reconstruct them, and the reconstruction closes on three independent point values it also states. Integrating $\beta'=-\tfrac{3\sqrt2A}{4\sqrt{1-A^2}}-3$ and fixing the constant by "$\beta$ vanishes exactly at $\tfrac13$":

$$\beta(A)=\tfrac34\sqrt{2-2A^2}-3A,$$

whose zero is $\sqrt{2-2A^2}=4A$ (the block's own criterion) and whose value at $A_0$ is $-\tfrac94\sqrt{2/3}=-\tfrac34\sqrt6$, the block's own constant. Integrating $\alpha'=-\tfrac{9\sqrt2}2A$ and fixing it by $\alpha(A_0)=0$ gives $\alpha=\tfrac{9\sqrt2}4(\tfrac23-A^2)$, so $\alpha(A_0-\varepsilon)=\tfrac{9\sqrt2}4\cdot2\sqrt{\tfrac23}\,\varepsilon=3\sqrt3\,\varepsilon$, again the block's constant. Then

$$t^*=-\frac\alpha{2\beta}=\sqrt2\,\varepsilon,\qquad \psi^*=\frac{\alpha^2}{4\lvert\beta\rvert}=\frac{27\varepsilon^2}{3\sqrt6}=\tfrac32\sqrt6\,\varepsilon^2,$$

against a fall of $\tfrac94\sqrt6\,\varepsilon^2$, margin $\tfrac34\sqrt6\,\varepsilon^2$, the clean factor $3/2$ the block claims. **Six constants reproduced from two derivatives and three anchors. Nothing in the endpoint band is fitted.**

### The bound is attained, and the chain is tight exactly there. CONFIRMED

At $(2,-1,-1)/\sqrt6$: $s=2/\sqrt6$, $u=2/3$, $bc=(s^2+u-1)/2=1/6$, and $\mathrm{FTP}=0$ since $k=1$. The two cubes cancel, $\sum_P\lambda^3=s^3=8/(6\sqrt6)$, leaving

$$G=3bc\,s+6bc\lambda_1=\tfrac1{\sqrt6}+\tfrac2{\sqrt6}=\tfrac3{\sqrt6}=\sqrt{3/2}.$$

The true $\theta$ there, with $T_{1,N-1,N}=2$ from [Lemma L72](../findings/stratum-two-negative.md), is

$$\theta=\sum_\alpha\lambda_\alpha^3+3T_{1,N-1,N}\lambda_1bc=\tfrac{6}{6\sqrt6}+3\cdot2\cdot\tfrac2{\sqrt6}\cdot\tfrac16=\tfrac1{\sqrt6}+\tfrac2{\sqrt6}=\sqrt{3/2}.$$

**So $\theta=\mathrm{LP}=G=\sqrt{3/2}$ at the extremiser: no step in the chain is lossy where it matters.** As a second anchor I ran the same arithmetic on [Lemma L34](../findings/stratum-two-negative.md)'s $m=8$ witness, spectrum $\{-1/\sqrt3\ (\times2),\ 1/(2\sqrt3)\ (\times4)\}$: there $bc=1/3$ agrees with $(s^2+u-1)/2$, $3\,\mathrm{FTP}=k(k-1)\lambda^3=0.2887$ from the equal-positives maximiser, and $G=0.5774$ against a true $\theta=-\sqrt3/2$. The chain is loose there and correct.

---

## Defect D5, the block's endpoint argument is stale against a repair recorded in its own file. Verdict: REAL

The L35 block closes with the endpoint expansion, $-\tfrac12g''(A_0)=\tfrac94\sqrt6$ against $\psi^*=\tfrac32\sqrt6\varepsilon^2$, "a margin of $\tfrac34\sqrt6$", presented as what closes the third range $(0.7,A_0]$.

**Ninety lines further down, the same file withdraws exactly that.** Under `One repair, to the endpoint band`: *"The second-order expansion has every constant exactly right but carries no remainder bound and points the wrong way … and certifies nothing outside an unspecified neighbourhood."* The repair replaces it with $F-\tfrac{\sqrt6}2\le\varepsilon^2Q(A)$, and then records that **$Q$ itself fails at $A=0.70$, so $[0.7,0.7096]$ goes to direct bisection.**

**So the range the block credits to the endpoint expansion is the one range the expansion does not close.** This is the brief's item 6 landing for the third time in this audit: the settling fact was inside the block's own file.

The bound survives, because the block also cites the interval-arithmetic closure, which is the real one and whose box counts are consistent, $73+21=94$.

**Repair.** Replace the block's endpoint sentence with the interval-arithmetic closure as the argument and the expansion as the reason the margin is positive, adding *"the expansion is asymptotic and carries no remainder bound; the certification is the interval enclosure"*.

**One further overstatement in the same sentence.** The block says the enclosure *"certifies $F'>0$ throughout"*. The argument section certifies $F'>0$ on $[10^{-12},0.8164]$, and $A_0=0.816497$. The value certification does cover $(0,A_0]$; the monotonicity certification does not, and the block runs the two together.

**And this is where the analysis-only footing has to be stated plainly.** The middle band $(\tfrac13,0.7]$ is closed by a Lipschitz certificate and by branch-and-bound at $200$ bits, and $[0.7,0.7096]$ by bisection. Those are rigorous, and they are **not checkable by hand**. The honest status of L35 is *proved, with its residual one-variable inequality closed by validated numerics on three sub-intervals*. The block's "closed, and rigorously" is true; a reader looking for a derivation they can check gets one on $(0,\tfrac13]$ and at $A_0$, and a certificate everywhere between.

## Defect D6, the assembly directly above L35 is superseded and says so nowhere. Verdict: REAL

Immediately above the L35 block sits `The $\dim\mathfrak m\le2$ stratum, assembled, closed modulo three named items`, whose table marks two of four regions *"proved modulo a numerical maximisation"* and *"proved at padded $W_{\mathbb{CP}^2}$"*, and which then lists **"The three items owed, stated exactly."**

**L35, eleven lines later, owes none of them.** Its chain does not use the deficit $\delta$, the perturbation $E$, or $\langle E,L_eE\rangle\le\tfrac12$. A reader arriving in file order reads the stratum as owing three items and then reads it closed, with nothing connecting the two.

The same file already carries this defect once, at line 389 (*"$\sup\theta\le\sqrt{3/2}$ on that stratum was unproved when this was written"*) and there it was caught and given a forward clause. The assembly block was not.

**Repair.** One sentence on the assembly's "three items owed": *"All three are superseded by [Lemma L35](../findings/stratum-two-negative.md#lemma-l35-at-most-two-negative-eigenvalues-caps-theta-at-sqrt32-unconditionally) below, which closes the same target by a route using none of them."*

**A dead anchor in the same neighbourhood.** Line 389 links to `#lemma-l35--the-sharp-stratum-bound-and-what-it-costs`. **No heading of that text exists anywhere in the repository.** The live anchor is `#lemma-l35--at-most-two-negative-eigenvalues-caps-theta-at-sqrt32-unconditionally`.

---

## The quantifier "any $m$"

**The smallest $m$ at which the claim has content is $m=4$, and the bound is attained there.** $\mathcal W_m$ is trivial below $4$ and has dimension $10$ at $m=4$. At $m=4$, $W=W_+\oplus W_-$ with both blocks trace-free $3\times3$; taking $W_-=0$ and $W_+\propto\mathop{\mathrm{diag}}(2,-1,-1)$ gives $W_{\mathbb{CP}^2}$, whose $\Lambda^2$ spectrum is $(2,-1,-1,0,0,0)/\sqrt6$, exactly two negative eigenvalues, and $\theta=\sqrt{3/2}$. **So the hypothesis is non-vacuous and the bound sharp at the smallest dimension in range**, and by the padding row of [conventions.md](../findings/conventions.md) it stays attained at every larger $m$.

**How L35 relates to [Lemma L29](../findings/stratum-two-negative.md).** L29 assumes *exactly one positive and two negative*; L35 assumes *at most two negative, any number of positive*. **L35 strictly generalises L29's hypothesis and reaches the same constant**, and it does not merely extend it: at $k=1$ the chain collapses to $g(A)$, whose maximum over the forced domain $A\le A_0$ is $\sqrt{3/2}$ at $A=A_0$, L29's conclusion, by L35's own machinery. The two are consistent on their overlap, which I checked at the shared extremiser above.

**One hypothesis mismatch, and it is real.** L35 says *at most two* negative eigenvalues. The section that carries the argument opens *"For every $W\in\mathrm{Weyl}_m$ with **exactly two** negative eigenvalues"*, and the whole derivation runs on $b,c>0$, $s=b+c$, $bc=(s^2+u-1)/2$, the $(+--)$ transport, the corner $b=c$. **The one-negative case is inside L35's statement and outside its argument as filed.**

It is not a hole in the bound. With one negative the $(+--)$ family is empty and $G=\sum_P\lambda^3-s^3+3\,\mathrm{FTP}(\lambda_P)$ with $s=b$; the formula $bc=(s^2+u-1)/2$ degenerates correctly to $0$, since $b^2=1-u$ forces $s^2=1-u$. Screening the equal-positives family by hand ($k$ positives $\lambda$, one negative $k\lambda$, so $\lambda^2=1/(k+k^2)$), gives $G=k^2(1-k)\lambda^3\le0$ at every $k\ge1$, and at $k\le2$ the packing is empty and $G=\sum_P\lambda^3-s^3<0$. *That is a screen, on objects constructed for it, and it is not evidence.* **What is owed is one line saying the one-negative case is dominated, or the statement narrowed to "exactly two".** The zero-negative case is vacuous: a trace-free nonzero symmetric operator has a negative eigenvalue.

---

## The refuted descent

The block says the descent reducing the general case to dimension four *"is refuted by [Lemma L34](../findings/stratum-two-negative.md)"*. **Checked against L34's own statement, the reading is correct, and it is correct about one of the two descents in this file, which the block does not distinguish.**

- **The support descent.** L34's own preamble names its target: B0's descent *"had been recorded as closing once no $\mathrm{Weyl}_m$ element with at most two negative eigenvalues has full support"*. L34 exhibits such elements at $m=6$ and $m=8$, so the premise is false and the padding reduction at line 249 (which needs $r_1+r_2<n$), does not apply on the stratum generally. **This is the descent L35's preamble means, and L34 does refute it.**
- **The $\delta=0$ descent survives.** The assembly's third row descends by a different route: cap $\Rightarrow XY=-YX$ and rank $4$ by [Lemma L31](../findings/stratum-two-negative.md), hence a common kernel of dimension $n-4$. L34's witnesses do not touch it, and cannot: the $m=8$ witness puts $v_{N-1},v_N$ on orthogonal $4$-planes, so $[v_{N-1},v_N]=0$ and the deficit is $\epsilon=2$, the far end of the range from $\delta=0$.

**So "the descent" is two descents, and the block's definite article picks neither.** The direction is safe either way, because L35 uses no descent at all.

**L34 does not contradict L35.** Its witnesses carry $\theta=-\sqrt3/2$ and $-1.030865$ on the recorded spectra, and at most $+0.485408612$ on the general-position family, all under $\sqrt{3/2}$. I verified the two recorded spectra are admissible: $2\cdot\tfrac13+4\cdot\tfrac1{12}=1$ and $-\tfrac2{\sqrt3}+\tfrac4{2\sqrt3}=0$; $(9+1+1+1+1+1)/14=1$ and $(-3-1+4)/\sqrt{14}=0$.

---

## What cites L35, and whether the uses are inside its hypotheses

$91$ occurrences of the identifier, in $39$ files. Grepping the **statement** rather than the identifier, the load-bearing uses are these.

| user | the use | inside the hypotheses? |
| --- | --- | --- |
| [results.md](../results.md) line 40 | *"the low strata are closed"* | **yes** |
| [results.md](../results.md) line 456 | restatement | **yes**, but the heading drops *"unconditionally"*, the two headings differ |
| [plan-maximizer.md](plan-maximizer.md) I25 step 3, and [REVIEW_r350](REVIEW_r350.md) | at a maximiser with $n\ge12$, $\theta\ge\theta_0(n)>\sqrt{3/2}$, so $q\le2$ is excluded | **yes** |
| [REVIEW_r283](REVIEW_r283.md) | at $n\ge12$ a maximiser is outside the stratum, so tightness of the chain there is moot | **yes** |
| [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex) §`sec:stratum` | the LaTeX statement, verbatim | **yes** |
| [stratum-two-negative.md](../findings/stratum-two-negative.md) line 116 | *"three or more positive eigenvalues … are covered by Lemma L35"* | **yes** |

**I re-derived the threshold the downstream uses turn on**, since it is the one place a hypothesis could be exceeded: $\theta_0(n)^2>3/2\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$, which is $-3<0$ at $n=11$ and $+8>0$ at $n=12$. **The switch-on point is exactly the conjecture's own $n\ge12$**, and the uses respect it.

**One use to watch, and it is clean.** Line 345 of the same file routes a *diagonal* two-negative $W$ through $\max_{\mathrm{Weyl}_4}\theta=\sqrt{3/2}$ and says so is "very lossy", the true stratum maximum there is $0$. That is a remark about slack, not a misuse.

**No use I found applies L35 outside "at most two negative eigenvalues", and none of them leans on the one-negative case the argument omits.**

---

## Convention check

- **The norm.** Read against [conventions.md](../findings/conventions.md) rather than the block: $\theta=P(W)/\lVert W\rVert^3$ and $\sum_\alpha\lambda_\alpha^2=\mathop{\mathrm{tr}}(W^2)=1$ at unit norm. The pair cap $\lVert[X,Y]\rVert^2\le2$ is stated in the half-trace pairing, which is the pairing the $\Lambda^2$ spectrum lives in, so **no conversion is owed anywhere in the chain** and none is silently taken. The $\sqrt2$ trap of the $M$/$W$ row does not arise: L35 never touches the sectional matrix.
- **The index order.** [conventions.md](../findings/conventions.md) records that this whole file is written in Bourguignon–Karcher's $ikjl$ while the record is on Li's $iklj$. **L35 is immune**: nothing in it mentions $\mathring W$, and $\theta$, $Q$, $W^\#$ and the pair cap are all order-free.
- **Warning [W5](../findings/INDEX-traps.md).** $\Theta_n$ against $M(n)$. L35 never writes $\Theta_n$, and the comparison it feeds is against $\theta_0(n)$, which is the right object. **Clean.** The neighbouring section at line 606 also uses $\theta_0(n)$ correctly.
- **$\Pi$, $\mathfrak m$, $B$, $b$, $d$, $t$, $M$.** Of the collisions [conventions.md](../findings/conventions.md) tables, four are live in this block: $b$ (here a negative eigenvalue's magnitude), $d$, $t$ and $M$. Only $d$ and $M$ are load-bearing and undefined; see D4.

---

## Verdicts

| # | defect | verdict |
| --- | --- | --- |
| D1 | the identity is stated as needing no hypothesis; it needs $\lVert W\rVert=1$ | **REAL**, repair given, one clause |
| D2 | the chain consumes $\mathop{\mathrm{tr}}W=0$ and $\lVert W\rVert=1$ and names neither | **REAL**, and it hides a stronger theorem than the one claimed |
| D3 | the row marginal $m-2$ reads against [conventions.md](../findings/conventions.md)'s ordered-pair default, and carries no result number | **MINOR**, right under the unordered reading, and harmless because the constraint is dropped |
| D4 | nine load-bearing symbols undefined anywhere on the record; $d$, $T$ and $M$ collide with defined objects | **REAL**, and the largest defect here |
| D5 | the block credits $(0.7,A_0]$ to an endpoint expansion its own file withdraws, and overstates the $F'>0$ certificate | **REAL**, bound unaffected |
| D6 | the assembly above L35 still lists three owed items that L35 supersedes; and a dead anchor at line 389 | **REAL** |

**Overall: CONFIRMED.**

$\theta\le\sqrt{3/2}$ for every $W\in\mathrm{Weyl}_m$ with at most two negative eigenvalues, at any $m$. Every inequality in the chain goes the enlarging way, the relaxed feasible set genuinely contains the true $T$, the decoupling is an identity rather than an inequality in disguise, the constant is produced by an exact stationarity computation rather than read off a solver, and the bound is attained at $m=4$ and at every $m$ above it.

**Two qualifications on the word "unconditionally" in the heading.**

1. **The one-negative case is inside the statement and outside the argument.** The section carrying the proof quantifies over *exactly two*. What is owed is one line, and my screen suggests the line is easy; the screen is not evidence.
2. **The last step is validated numerics, not a derivation.** $(0,\tfrac13]$ closes in closed form and $A_0$ closes in exact arithmetic; $(\tfrac13,0.7096]$ closes by interval arithmetic and branch-and-bound at $200$ bits, and $[0.7,0.7096]$ by bisection. **Rigorous, and not checkable by hand.** The heading's "unconditionally" is about the hypotheses on $W$, and it is earned; it should not be read as "by a hand argument".

**What I did not do.** No computation was run. The two spectrum evaluations and the one-negative family above are hand arithmetic on objects constructed for the screen, reported as screens.

**Nothing here shifts a downstream conclusion.** All six load-bearing consumers of L35 use it inside its hypotheses, and the $n\ge12$ threshold they turn on re-derives correctly.
