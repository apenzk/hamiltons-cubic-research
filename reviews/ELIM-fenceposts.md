# ELIM-fenceposts, elimination audit of findings/fence-posts.md and findings/problem.md

*Auditor ELIM-fenceposts. Both files read in full, no computation run. The test applied to every bound, reduction, equivalence and "what a successor must clear" in the two files: substitute $W^\#=\theta W-W^2$, $\mathrm{Ric}(W)=0$, first Bianchi and $\mathop{\mathrm{tr}}W=0$, then ask what free variable survives. [fence-posts.md](../findings/fence-posts.md) grew from 543 to 558 lines during the audit, a new post F42 appeared, and it independently reaches the same survivor this audit reached. That post is confirmed below and then pushed on.*

---

## Survivors, quantities a critical point carries that its spectrum and $\theta$ do not determine

### S1. The $\lambda^2$-weighted bracket moment $\sum_a\lambda_a^2m_a$ at a single eigenvector, confirmed independently, and it is now on the record

Reached here from [post F41](../findings/fence-posts.md#L516)'s own two displays before post F42 existed. With $v$ a unit eigenvector, $Wv=\lambda v$, $m_a=\lVert[v,\varphi_a]\rVert^2$:

- weight $1$: $\sum_am_a=2(n-2)$, the Killing mass, criticality-free;
- weight $\lambda$: $\sum_a\lambda_am_a=-2\langle v,Wv\rangle=-2\lambda$, the per-row identity $A(W)=2W$, Ricci-flatness only, criticality-free;
- the pair weight: $\tfrac12\sum_{ab}\lambda_a\lambda_bc_{vab}^2=\langle v,W^\#v\rangle=\lambda(\theta-\lambda)$, **pinned by criticality**;
- weight $\lambda^2$: $\sum_a\lambda_a^2m_a=\lVert\mathrm{ad}(v)W\rVert^2$, **pinned by none of these**.

Since [post F41](../findings/fence-posts.md#L516)'s $g_v=2\lVert\mathrm{ad}(v)W\rVert^2-4\langle v,W^\#v\rangle$, the entire free content of $g_v$ at a critical point is that $\lambda^2$ moment. Across the eigenbasis the record pins only two aggregates, $\sum_\gamma g_\gamma=4(n-1)$ and $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$; [post F25](../findings/fence-posts.md#L85) already reported the third weight "matching neither" and did not name it as the survivor.

**Post F42's census is correct, verified here by hand.** With $T_{abc}=c_{abc}^2$ totally symmetric and (A), (B), (C) holding for every $k$: $\{p,0,0\}\to2(n-2)\sum\lambda^p$; $\{p,1,0\}\to-2\sum\lambda^{p+1}$; $\{p,1,1\}\to2\theta\sum\lambda^{p+1}-2\sum\lambda^{p+2}$. Each is a function of $(\lambda,\theta)$. And $\sum_k\lambda_k^2g_k=2\sum\lambda_k^2\lambda_\alpha^2T-2\sum\lambda_k^2\lambda_\alpha\lambda_\beta T$, whose second term is $\{2,1,1\}$ and pinned, so $\sum_k\lambda_k^2g_k$ and $\{2,2,0\}$ agree modulo pinned data. The equivalence post F42 asserts holds.

**But post F42's "sharp in both directions" is half proved.** The first direction is an identity. The second (*"nothing on the record pins $\{2,2,0\}$"*), is an inventory statement about the record, and it is being read as freedom. Freedom needs a witness: **two critical points with the same $\Lambda^2$-spectrum and the same $\theta$ and different $\sum_k\lambda_k^2g_k$.** The record has no such pair. [Post F1](../findings/fence-posts.md#L25)'s $300$-tensor witness is the right shape but the wrong hypothesis, those tensors are diagonal and are not critical points at a common $\theta$. Until that witness exists, the correct statement is "the record's three relations do not pin $\{2,2,0\}$", which is weaker and is what a successor should be told.

### S2. $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$, the one lever in problem.md that the substitution does not touch

[Conjecture L16](../findings/problem.md#L299) is written in $\delta^2$, the $\Lambda^4$-part of the negative spectral half of $W$. Substituting criticality changes nothing: $W^\#=\theta W-W^2$ relates $W^\#$ to $W$, and says nothing about $W_-^\#$ or about how $W$'s eigenspaces sit inside $\Lambda^2\mathbb R^n$ as bivectors. [Lemma L15](../findings/problem.md#L173)'s identity $\mathop{\mathrm{scal}}(R^2+R^\#)=\lVert\mathrm{Ric}(R)\rVert^2+6\lVert\mathrm{Alt}(R)\rVert^2$ at $R=W_-$ gives $6\delta^2=\mathop{\mathrm{scal}}(W_-^2+W_-^\#)-\lVert\mathrm{Ric}(W_-)\rVert^2$, both terms quadratic in $W_-$ and neither spectral. **$\delta^2$ is genuine alignment data**, it is not a contraction of $T$ against any weight, so post F42's exponent test does not reach it, and it is the only quantity in either assigned file that survives the substitution while also carrying a proposed sharp bound.

### S3. The off-diagonal correlations are pinned to zero, and that is where Jacobi lives

Criticality forces $M_{kl}=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ for all $k\ne l$. That is information rather than a survivor, but it locates the remaining freedom precisely: at fixed $(\lambda,\theta)$ the free data sits in weights with **two exponents $\ge2$** and in the constraint set itself (Jacobi and frame-realizability), never in the values of the low-weight contractions. [Post F41](../findings/fence-posts.md#L541) names exactly this: at a maximal torus *"only the Jacobi identity forbids"* the saturating configuration, root brackets $[\mathfrak g_\alpha,\mathfrak g_\beta]\subseteq\mathfrak g_{\alpha+\beta}$ pushing $\tfrac{m-2}{m-1}$ of the bracket mass off $E_{\min}\times E_{\max}$. Jacobi is not among (A), (B), (C).

---

## Tautologies found

### T1. Post F41's opening premise is route R14, unflagged, fifteen lines above the post that closes it

> *"[Lemma L70](../findings/bounds.md) reduces the conjecture to bounding $D(v)$ below, so the first question is what data can do it."*, [fence-posts.md:514](../findings/fence-posts.md#L514)

Substitute. For $v\in E_{\min}$, $D(v)=\tfrac12\sum_{ab}(\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max})c_{vab}^2=\langle v,W^\#v\rangle-(n-2)\lambda_{\min}\lambda_{\max}$, using $\sum_{ab}c_{vab}^2=2(n-2)$. Criticality gives $\langle v,W^\#v\rangle=\lambda_{\min}(\theta-\lambda_{\min})$, so

$$D(v)=\lambda_{\min}\big(\theta-\lambda_{\min}-(n-2)\lambda_{\max}\big)=\lvert\lambda_{\min}\rvert\big(\lambda_{\min}+(n-2)\lambda_{\max}-\theta\big)$$

identically, $\lambda_{\min}<0$ being supplied by $\mathop{\mathrm{tr}}W=0$. So "bound $D$ below by the $\theta_0$ expression" is $\theta\le\theta_0(n)$ with $\lvert\lambda_{\min}\rvert(\lambda_{\min}+(n-2)\lambda_{\max})$ subtracted from both sides. This is r323's closure verbatim and it is written out in full in [bounds.md](../findings/bounds.md), which post F41 links, but post F41 itself states the reduction as live, and post F42 sits fifteen lines below it applying the same test to four other routes without touching this one.

**What the sentence should say, and it is a real statement rather than a tautology:** the honest reduction is *bound $\langle v,W^\#v\rangle$ below at the $\lambda_{\min}$ eigenvector using only Weyl membership, Jacobi and the spectrum, invoking $Q(W)=\theta W$ nowhere.* Any attempted proof of $D\ge f(\lambda)$ that uses criticality at any step returns $0=0$. Post F41's own LP program is of the honest kind (it carries (A), and r326 added (B)) which is why the post's conclusion survives while its premise does not.

### T2. Post F40's "route that remains" is closed by post F42's own test

> *"The route that remains is an identity rather than an estimate, computing $\mathop{\mathrm{tr}}(\mathrm{ad}(v)W\,\mathrm{ad}(v)W)$ from the structure constants at a critical point, not bounding it."*, [fence-posts.md:489](../findings/fence-posts.md#L489)

$\mathop{\mathrm{tr}}(\mathrm{ad}(v)W\,\mathrm{ad}(v)W)=-2\langle v,W^\#v\rangle$, which at a critical point is $-2\lambda(\theta-\lambda)$. In post F42's coordinates the weight is $\lambda_\beta\lambda_\gamma$ on the pair slots and $1$ on the free slot: pattern $\{0,1,1\}$, which is relation (C) itself. Two exponents are $\le1$, so post F42's rule closes it. **The recommendation is dead on arrival at a critical point** (the "computing" was already done by criticality) and it survives only under the same repair as T1: compute the trace *without* criticality, which makes it an identity on all of $\mathcal W_n$ and no longer "at a critical point". Post F40 still carries the sentence as the surviving shape, and [bounds.md](../findings/bounds.md) quotes it approvingly one paragraph before r323 closes it.

### T3. Post F31's $C-B$ vanishes on the whole critical set, not at one witness, and this is stronger than the post claims

> *"And it is worse than false: $C-B$ vanishes **exactly** at that witness, at the balanced product $Q(W)=\theta W$."*, [fence-posts.md:357](../findings/fence-posts.md#L357)

With $B=\langle Q(W),W\rangle^2$ and $C=\lVert W\rVert^2\lVert Q(W)\rVert^2$, $C-B\ge0$ is Cauchy–Schwarz, and equality holds **iff $Q(W)\parallel W$**, which is criticality. So $C-B\equiv0$ at *every* critical point, and the certificate target $\Theta_n^2A-B+\mu(C-B)$ reduces to $\Theta_n^2\lVert W\rVert^6-\theta^2\lVert W\rVert^6$ on all of $\mathrm{Crit}$, for every $\mu$. **The multiplier $\mu$ is identically inert exactly where the statement has to be proved.** Two consequences the post does not draw:

- the description set is empty for a structural reason, not because of one witness, no repair that keeps $C-B$ as the slack carrier can work;
- the post's own scope note, *"the **non-sharp** target $2A-B+\mu(C-B)$ is freely described"*, buys nothing on $\mathrm{Crit}$ either, so the surviving freely-described certificate is $2A-B$ alone, which asserts $\theta\le\sqrt2$.

That squeezes item 3c ([fence-posts.md:470](../findings/fence-posts.md#L470)), the last route the closure table leaves open: an $O(n)$-invariant SOS must carry its $n$-dependence somewhere post F31 does not kill *and* its slack somewhere other than $C-B$.

### T4. The subalgebra-family collapse, self-flagged, recorded for completeness

$S_{\mathfrak{mmm}}=0\iff r=\tfrac{n(n-2)}4\iff\theta=\theta_0(n)$ at [fence-posts.md:193](../findings/fence-posts.md#L193) is an equality condition on a monotone function of the single variable $r$, stated twice. The file says so itself at [line 207](../findings/fence-posts.md#L207), *"true and is nearly a tautology"*. No action beyond keeping that sentence attached whenever the display is quoted.

---

## Over-reach, two fences that may be fencing off a route that would work

### O1. Post F42 closes routes by the shape of the lever when only the constraint set can close them

> *"Name the weight pattern of its lever before anything else. If two of the three exponents are $\le1$, the route is closed by this post and no computation is needed to see it."*, [fence-posts.md:558](../findings/fence-posts.md#L558)

The census proves that such a lever's **value** is $h(\lambda,\theta)$. It does not prove the route is closed. A route that establishes $\text{lever}\ge f(\lambda)$ **without using criticality** yields $h(\lambda,\theta)\ge f(\lambda)$, which is a genuine bound on $\theta$ by a spectral function. What actually killed the $\Pi$-bound, the $\lambda$-weighted bound, the $\dim E_+$ form and R14 was that each proved its lower bound *from (A), (B), (C) alone* (the same relations that pin the value) so both sides carried the same terms. That is a statement about the constraint set, and r324's measured ceiling of $1.5$–$3.7\times\theta_0$ over (A), (B), (C), the row cap and $T\ge0$ is the honest closure.

Post F42 generalises that measurement to constraint sets it was never taken over. The clearest casualty is **Jacobi**: post F41, fifteen lines above, identifies Jacobi as the only thing forbidding the saturating configuration at a maximal torus, and post F42's *"they are all the record has"* does not list it. A $\{0,1,1\}$ lever bounded below by a Jacobi argument is not closed by post F42, and post F42 as written tells a successor to abandon it without computing. **The rule should be restated over constraints, not exponents:** *a route is closed if both its lever's value and its lower bound come from (A), (B), (C); a lever with two exponents $\le1$ is a warning that its value is pinned, not a proof that its bound is circular.*

### O2. problem.md item 5 carries the sentence fence-posts.md post F1 declares untrue, and post F470 cites it as a proof

> *"…so no purely eigenvalue-based inequality can ever close the gap"*, [problem.md:150](../findings/problem.md#L150)

[Post F1](../findings/fence-posts.md#L23) opens: *"REWRITTEN, and narrowed, the previous wording was false. It read 'eigenvalue-only inequalities can never be sharp', which is literally untrue: the target $P\le\theta_0(n)\lVert W\rVert^3$ is itself norm-only and sharp."* [Post F2d](../findings/fence-posts.md#L149) says the same again: *"'a spectral bound cannot suffice' is a **non-sequitur**, the fibrewise supremum is itself a spectral function."* What is proved is the narrower fact that $P$ is not a *function* of the $\Lambda^2$-spectrum ($300$ tensors, one spectrum, $P\in\{-24,0,+24\}$).

Item 5 still carries the refuted form, and [fence-posts.md:470](../findings/fence-posts.md#L470) then leans on it, *"problem.md item 5 **proves** the spectrum cannot decide it"*, to explain why every (G) row closed and to single out 3c as the survivor. So a load-bearing closure summary rests on a premise the same file withdrew twice. The pattern claim needs restating in the post-1 form, and the conclusion drawn from it (that only a spectrum-blind construction can survive) does not follow.

---

## Weak evidence

| where | the claim | why it is weak |
|---|---|---|
| [fence-posts.md:211](../findings/fence-posts.md#L211) | the r318 repair: raise the threshold to $\theta_0(n)$, then *"step 2 has no counterexample on the catalogue"* | Step 2 is positivity of $S$ at every **ungraded** critical point of a compact set. The catalogue is built from symmetric constructions, and [line 193](../findings/fence-posts.md#L193) shows $S=0$ tracks the cap-saturating (graded) points on the subalgebra family, so the catalogue is precisely the population in which the premise cannot fail. The arithmetic of the repair is sound ($\theta_0(12)^2=55/36>3/2$, $\theta_0$ increasing); the evidence for step 2 is not. |
| [problem.md:154](../findings/problem.md#L154) | item 9's $\langle W^\#,W\rangle$ vertex bound *"survived every off-diagonal stress test run … five random genuine Weyl tensors at $n=6$"* | The identity is explicitly a coordinate-diagonal-frame fact, and the claim being screened is a **tensorial** extension of it. Random Weyl tensors are never coordinate-diagonal, so the screen cannot reach the family the identity lives on. [bounds.md](../findings/bounds.md) documents this exact blindness in r326's finding that a random-Weyl screen passed a bracket identity that every diagonal Weyl tensor fails. Same defect, unflagged here. |
| [problem.md:299](../findings/problem.md#L299) | Conjecture L16 *"has survived a full adversarial battery … every catalogued critical point, random sampling, seeded gradient ascent"* | Catalogue and random screen together, on the record's flagship candidate inequality. Its survivor status (S2) is real; its evidence is the two populations the brief names. |
| [problem.md:299](../findings/problem.md#L299) | *"The shape is forced, not fitted: equality holds at both named maximizers by construction"* | $\kappa_n=9(\sqrt{3/2}-\theta_0(n))$ is solved from the single equation $\theta_0+\kappa_n\cdot\tfrac19=\sqrt{3/2}$, the competitor's defect being exactly $1/9$. Equality at the $\mathbb{CP}^2$ point is therefore arithmetic, and equality at the sphere product is $\delta=0$ there, i.e. the conjecture's own equality case. Tightness at both extrema follows from the fitting and the normalisation, not from a mechanism. *"By construction"* and *"not fitted"* are in the same sentence and contradict each other. |
| [fence-posts.md:495](../findings/fence-posts.md#L495) | post F40's positive half holds at every padding-free catalogued point and at none of $33$ generic critical points | Already correctly self-flagged as *"a catalogue property, not a mechanism"*. Recorded only to note the flag is in place. |
| [fence-posts.md:161](../findings/fence-posts.md#L161) vs [bounds.md](../findings/bounds.md) | post F10's LP overshoot is *"a factor near $0.80\sqrt{n-2}$"*; bounds.md quotes *"post F10's closed marginal LP at $1.52\times$"* | $0.80\sqrt{10}=2.53$ at $n=12$, against $1.52$. Either post F10's phrase means the additive excess rather than the factor, or one of the two figures is attached to the wrong LP. One word fixes it; as it stands the two files disagree about a number that post F42 now uses to rank relaxations. Flagged for checking, not asserted as an error, no computation was run. |
| [fence-posts.md:17](../findings/fence-posts.md#L17) | route **A**, the universal certificate, *"is closed by the `analytic` gate in SKILL.md rather than by a post"* | A closure a successor cannot check mathematically. Every other row of the table carries a criterion; this one carries a process rule. Given T3, route A now has a mathematical closure available, write it. |

---

## Clean, passed the substitution, one line each

- **Post F1**, the $300$-tensor witness at $n=6$: exhaustive and exact; proves $P$ is not a spectral function, and scopes itself correctly.
- **Post F2**, $B_\#/\theta_0+\mathop{\mathrm{tr}}(W^3)/P=1$ identically at the balanced product: the two closed forms are consistent with item 9's $\sqrt2(n-3)/\sqrt{(n-1)(n-2)}$, checked here.
- **Post F2c**, $\langle W^\#,W\rangle=2\mathop{\mathrm{tr}}(W^3)$ at $n=4$ via $c^\pm=\mp\sqrt2\,\varepsilon$ and $\#=2\mathop{\mathrm{adj}}$: a stated identity, correctly scoped to ideals by 2e2.
- **Post F2g**, the Lovelock six-index identity for $n\le5$: mechanism supplied, and the quantifier-inversion diagnosis of the previous version is right.
- **Post F23**, no linear relation among the five invariants at $n\ge6$: uses rank in the sound direction, and correctly separates "no identity" from "no sharp inequality".
- **Post F30**, Levin–Chandrasekaran's finite-index hypothesis fails for $\{O_n\}$: a definitional obstruction, quoted from the source.
- **Post F31's monotonicity**, $\tfrac{d}{dn}\Theta_n^2=2(3n-4)/n^3>0$: verified by hand.
- **Post F34**, $\cos\varphi$ is a definition so the Cauchy–Schwarz relaxation is $\theta\le\theta_0$ restated: a correctly identified tautology, with the successor criterion stated in the right currency.
- **Post F35**, padded $W_{\mathbb{CP}^2}$ carries $\mathop{\mathrm{tr}}(M^3)+\lVert M^\#\rVert_F=1+1/\sqrt6$ for all $n$: $n$-independence is padding-invariance, which is a mechanism.
- **Post F36**, the cone reformulation is vacuous because $C=\mathbb R_+W^\ast$ satisfies it: correct vacuity argument.
- **Post F37**, differentiating equivariance gives $L_Wz=\tfrac\theta2z$ and $Bu=z\circ z$ with no maximality hypothesis: a real derived identity, and the post correctly refuses to claim it closes the calculus.
- **problem.md, the $\theta_0$ bridge at $a=0$**: $c(n-1)=\sqrt{2(n-1)(n-2)}/n$ from $\lVert I\rVert^2=\binom n2$, re-derived here and it comes out.
- **problem.md Lemma L44**, $n\ge12$ necessary: $\theta_0(n)<\sqrt{3/2}\iff n^2-12n+8<0$, verified.
- **problem.md Lemma L46/47/48**: $\dim\mathfrak h\le3n^2(n-1)/(2(7n-4))\Rightarrow\lVert W\rVert^2\ge\tfrac16\Rightarrow\theta^2\le\tfrac32$, the algebra reproduces exactly, as does $\tfrac16\ge\tfrac{n^2}{8(n-1)(n-2)}\iff n^2-12n+8\ge0$.
- **problem.md steps 1–3, the diagonal theorem**: $\lvert Z\rvert^2_{\max}$ chains to $\Theta_n^2$ at both parities, re-derived symbolically here, even case giving $(n-2)/(2(n-1))$ and odd case $n^2(n-3)/(2(n-2)(n^2-1))$, both landing on the stated constants. The odd equality-case ratios $Z_{aa}/Z_{ab}=-(n+1)/(n-3)$ and $Z_{bb}/Z_{ab}=-1$ also come out identically in $n$.
- **problem.md Lemma L18 (unconditional)**: the radius $0.5748$ is the root of $\cos\varphi+\sin^3\varphi=1$, so $\psi(\varphi)\le1$ is exactly tight there, internally consistent, and the contradiction is with the value rather than the location, as claimed.
- **problem.md, Nienhaus 4.19 is conditional**: the correction is right and is quoted from the source.

*One residual: [problem.md:342](../findings/problem.md#L342) is headed "the all-$n$ diagonal theorem is COMPLETE" and its own last clause still owes a cross-check that step 1 and the record's Dirichlet step coincide. Small, but a completeness header should not carry an open item.*
