# Review r166, Gate 2 on the sign repairs, D1's run, and the n=6,7 adjudication

**Verdict.** Claim 1's sign is **CONFIRMED**, independently and from the definitions, and both tight-at-extremum figures reproduce. Claim 2's "control" reading is right about the exclusion and wrong about what the run establishes. **Claim 3's padding half is right, already on the record verbatim, and its consequence does not follow**: the target's hypothesis is about $\lambda_{\max}(L_e|_{W^\perp})$, and padding transports criticality without transporting that spectrum. Three separate stale-sign or stale-quantifier passages are still live in the record, one of them stating $C$ and $-C$ two lines apart.

| claim | verdict |
| --- | --- |
| 1. $C=-40\operatorname{tr}(W^3)+8\langle W^{\#},W\rangle$, $\theta=6\operatorname{tr}(W^3)+\tfrac18C$, upper bound operative | **CONFIRMED**, derived here from the round sphere, and both $C$ values reproduced by hand |
| 1. $1.79781$ ($1.45\times$) and $2.66678$ ($2.17\times$) | **BOTH VERIFIED**, $1.79784$ and $2.66688$ from the second-kind spectra derived below |
| 1. "no uniform sign flip explains one positive and one negative" | **sound in its labelled form, vacuous in the brief's paraphrase**, see §1.3 |
| 2. D1 is a control | right about the *exclusion*, **under-credited** as evidence for item 1's own target; and it left the one question the record had asked of it unanswered |
| 3. padding preserves criticality at every $n\ge4$ | **TRUE, and NOT NEW**, [nondegeneracy.md](../findings/nondegeneracy.md) already carries it with the same reason |
| 3. therefore the $n\ge12$ escape hatch is unavailable | **DOES NOT FOLLOW.** The hatch is about $\lambda_{\max}$, which is on record for the padded point only at $n=5$ and $n=8$ |
| (a) | the padding argument, and the "escape hatch" it closes was already replaced by the record's own support restriction |
| (b) | **re-attribution is CORRECT**, verified: $(-48,+8)$ *is* the corrected $C$ |
| (c) | **three closures rest on grounds that do not hold**: 3a on a withdrawn number, 3b on a computation outside its scope, and item 1's repair on a sentence [second-order.md](../findings/second-order.md) has withdrawn |

---

## Setup, what I derive everything from

$Q(W)=W^2+W^{\#}$, criticality $Q(W)=\theta W$ at $\lVert W\rVert=1$, $\theta=\operatorname{tr}(W^3)+\langle W^{\#},W\rangle$. For a $\Lambda^2$-diagonal tensor with vertex matrix $M_{pq}$ ($M_{pp}=0$), $\operatorname{tr}(W^3)=\sum_{p<q}M_{pq}^3$ and $\langle W^{\#},W\rangle=3\sum_{p<q<r}M_{pq}M_{pr}M_{qr}=\tfrac12\operatorname{tr}(M^3)$, the second from $(W^{\#})_{pq,pq}=\sum_{r}M_{pr}M_{qr}$, which follows from $c^{pq}_{\gamma\delta}\ne0$ only for $\{\gamma,\delta\}=\{(p,r),(r,q)\}$. $\lVert W\rVert^2=\sum_{p<q}M_{pq}^2$.

## CLAIM 1, the sign, derived rather than assumed

### 1.1 The convention is pinned by the round sphere, and it forces $+M_{pq}$

The brief's formula and the record's differ in index order, and they are negatives of each other, that is the trap, so both are computed here. With $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ on the unit sphere and $\varphi$ trace-free:

- $R_{ikjl}\varphi_{kl}=\delta_{ij}\operatorname{tr}\varphi-\varphi_{ij}=-\varphi_{ij}$, this is the **brief's** order, and it gives $-\mathrm{Id}$.
- $R_{iklj}\varphi_{kl}=+\varphi_{ij}$, this is **[nondegeneracy.md](../findings/nondegeneracy.md) line 223's** order, and it gives $+\mathrm{Id}$.

The literature's convention is $\mathring R=\mathrm{Id}$ on the round sphere (it is what makes Nishikawa's conjecture a positivity statement), so the record's index order is the right one. It then forces the eigenvalue on $E_{pq}$: for $\varphi_{kl}=\delta_{kp}\delta_{lq}+\delta_{kq}\delta_{lp}$ and $W$ $\Lambda^2$-diagonal,

$$\mathring W(\varphi)_{pq}=R_{ppqq}+R_{pqpq}=+M_{pq},$$

and on trace-free **diagonal** $\varphi=\mathrm{diag}(d)$, $\mathring W(\varphi)_{ii}=\sum_kR_{ikki}d_k=-\sum_kM_{ik}d_k$, i.e. $\mathring W=-M|_{\mathbf 1^\perp}$ there. Both check against the sphere ($M=J-I$ gives $+\mathrm{Id}$ on both blocks). **So the two sign questions the brief separates are one question: $+\mathrm{Id}$ on the sphere and $+M_{pq}$ on $E_{pq}$ stand or fall together.**

### 1.2 The sign of $C$ falls straight out of that

$S=E_{pq}/\sqrt2$ acting on a diagonal $W$ has exactly one family of nonzero components, $(S\!\cdot\!W)_{pxqx}=M_{px}+M_{qx}$ for $x\ne p,q$, with eight index arrangements each, so $\lvert E_{pq}W\rvert^2=4\sum_{x}(M_{px}+M_{qx})^2$, **the record's own formula, re-derived, plus sign included**. Then the cross term of $\sum_{p<q}M_{pq}\lvert E_{pq}W\rvert^2$ is

$$4\cdot2\sum_{p<q}\sum_x M_{pq}M_{px}M_{qx}=8\cdot3\!\!\sum_{p<q<x}\!\!M_{pq}M_{px}M_{qx}=+8\langle W^{\#},W\rangle .$$

**The alignment cubic enters $C$ with coefficient $+8$.** That is the boxed line 204 and rules out its negative. Likewise $D=\mathrm{diag}(d)$ gives $(D\!\cdot\!W)_{pqpq}=2(d_p+d_q)M_{pq}$, hence $\lvert DW\rvert^2=16\sum_{p<q}(d_p+d_q)^2M_{pq}^2=16\,d^{\mathsf T}(\mathrm{diag}(r)+A)d$ with $r_p=\sum_qM_{pq}^2$, $A_{pq}=M_{pq}^2$, the record's second ingredient, re-derived, **$+A$ confirmed**.

### 1.2a A LIVE CONTRADICTION: the file states $C$ and $-C$ two lines apart

Line 206 reads *"On the $\Lambda^2$-diagonal tensors $C=40\sum_{i<j}M_{ij}^3-4\operatorname{tr}(M^3)$"*. Since $\operatorname{tr}(M^3)=2\langle W^{\#},W\rangle$, that is $C=+40\operatorname{tr}(W^3)-8\langle W^{\#},W\rangle$, **the exact negative of the boxed formula two lines above it**, and it evaluates to $-8.809541$ at $S^6\times S^6$ against the boxed $+8.809545$. The two ingredients quoted on that same line are correct and imply the *boxed* sign, as §1.2 shows. **The sentence is a survivor of the pre-flip text: its ingredients were repaired and its conclusion was not.** This is the fourth appearance of the same inversion and it is the one still on the page.

### 1.3 Is the "one positive, one negative" argument sound?

**In its labelled form, yes; in the brief's paraphrase, no.** Stripped of the point labels, "one positive and one negative" is invariant under a global flip (it maps $(+,-)$ to $(-,+)$, which is again one of each) so as stated it carries zero information. What the record actually asserts is stronger and is sound: the script returns $+8.81$ **at $S^6\times S^6$** and $-4.19$ **at $S^3\times S^9$**, and the negated closed form predicts $-8.81$ and $+4.19$, disagreeing at *both* labelled points. A per-point convention fault could reproduce the pattern only if the script chose its convention per point; it evaluates one formula. **But neither version establishes the absolute convention** (script and closed form could be jointly flipped) which is why §1.1's round-sphere derivation is the load-bearing step, and it is the one the record has only in a single line.

### 1.4 Both tight-at-extremum figures verified

The second-kind spectrum, from §1.1, at $\lVert W\rVert=1$, $n=12$:

| point | $\mathring W$ spectrum (multiplicity) | $\sum\mu_j^2$ |
|---|---|---|
| $S^6\times S^6$ | $0.134839^{(40)},\ -0.112366^{(36)},\ -1.348391^{(1)}$ | $3.000$ |
| $S^5\times S^7$ | $0.195411^{(14)},\ 0.093051^{(27)},\ -0.111658^{(35)},\ -1.339950^{(1)}$ | $3.000$ |

($\sum\mu^2=3=4\cdot\tfrac34\lVert W\rVert^2$, Lemma 3.1 in the $(0,4)$ normalisation, an independent check on the spectra.) With $T=\sum_j\lvert S^jW\rvert^2=\kappa\lvert W\rvert^2_{(0,4)}=\tfrac{74}3\cdot4=98.6667$:

$$\theta\ \le\ 6\operatorname{tr}(W^3)+\tfrac18\cdot\tfrac{\mu_{N-1}+\mu_N}2\,T$$

gives $0.134842+1.663=\mathbf{1.79784}$ at $S^6\times S^6$ ($1.4545\times$) and $0.256831+2.41008=\mathbf{2.66688}$ at $S^5\times S^7$ ($2.171\times$). **Both recorded figures confirmed.** I also reproduce $C$ from its definition $\sum_j\mu_j\lvert S^jW\rvert^2$ term by term at $S^6\times S^6$: $E$-block $+9.5279$, diagonal block $-0.7193$, total $\mathbf{+8.8086}$ against the recorded $8.809545$, agreement limited by my six-digit inputs.

### 1.5 The table's caption does not match its entries

The header reads $6\operatorname{tr}(W^3)-\tfrac18\cdot\tfrac{\mu_1+\mu_2}2T$. Evaluated literally with $\mu_1,\mu_2$ the two **smallest** ($-1.348391$ and $-0.112366$, sum $-1.460757$) it returns $\mathbf{9.1428}$, precisely the figure the record has withdrawn. The entries $1.79781$ and $2.66678$ come from the two **largest** with a **plus**. **The caption is the discarded formula sitting above the corrected numbers.**

### 1.6 A REGRESSION introduced by commit `260a804`

The commit deleted r163's diagnosis, *"$\mu_1+\mu_2=-1.460767$, the bottom of the correct spectrum, fed into the negated identity gives $9.142905$; the consistent value $-0.269680$ gives $1.797866$"*, and replaced it with r164's *"the bottom pair $\{-12,-1\}$"*. **The deleted version is exactly right**: I compute the bottom pair as $-1.348391-0.112366=-1.460757$ and the top pair as $+0.269678$. **The replacement is wrong on its numbers**, $\{-12,-1\}$ is not the bottom pair of $\mathring W$ at $S^6\times S^6$ in any normalisation on the record ($\lVert W\rVert=1$ gives $\{-1.348,-0.112\}$; unnormalised, $\{-5.455,-0.455\}$), though right in kind. A verified account was overwritten by an unverified one.

## CLAIM 2, D1's run

### 2.1 $\lambda_{\max}$ off $e$ is computed correctly, and the reason is structural

$\circ$ polarises the cubic $P$, so $\langle X\circ Y,Z\rangle$ is totally symmetric and $L_e$ is **self-adjoint**; $L_ee=Q(W)/\theta^2=e$. Hence $e^\perp$ is $L_e$-invariant and deflating $e$ then taking the top eigenvalue is exact. The one failure mode is $\lambda=1$ having multiplicity $>1$, which would leave a spurious $1$ after deflation, and [target.md](../findings/target.md) records exactly that bug in the older screen (*"the strip rule kept $e$'s own eigenvalue whenever $\lambda_{\max}>1$"*). D1's range $[1.138,1.560]$ contains no value at or near $1.000$, so the bug is not present. **Procedure sound.**

### 2.2 "Control not test" is right about the exclusion and wrong about the run

Right: every one of the 71 sits at $\theta\in[0.43,0.59]$, and $\theta_0(6)=1.054093$ already excludes them as maximisers on value alone. Lemma L24 adds nothing there, so as an *exclusion device* the run is a control. **But item 1's own target is not a statement about maximisers**, it reads *"$W$ ungraded and critical $\Rightarrow\lambda_{\max}(L_e|_{W^\perp})\ge c>\tfrac12$"*, quantified over critical points. Against that statement the 71 are 71 confirming instances, and they move a number the plan calls load-bearing: the observed floor drops from $1.17$ to $\mathbf{1.138}$, and *"find the mechanism setting the $1.17$ floor"* is the standing debt under item 1. **The run is a control for Lemma L24 and evidence for the target; the record credits only the first.**

### 2.3 And it left the record's own question unanswered

[plan.md](../plan.md) item 1 says the evidence base *"still needs re-reading under the restriction: the question is whether any of those $155$ points at $n=6$ is unpadded."* D1 produced 71 fresh $n=6$ critical points and **did not report whether any is padded**, and the question is live for exactly this sweep, since [nondegeneracy.md](../findings/nondegeneracy.md) records that padded $W_{\mathbb{CP}^2}$ *lies in $\sigma(2,4)$*, one of the cones swept. One padding test on 71 points converts a control into the answer to a standing debt. **Owed.**

## CLAIM 3, the n=6,7 adjudication, and the consequence

### 3.1 The padding argument is right, and it is already on the record, in full

$\mathrm{pad}(W)\in\mathrm{Weyl}_n$: first Bianchi is pointwise and survives padding; $\mathrm{Ric}(\mathrm{pad}\,W)_{ij}=\sum_kW_{ikjk}$ vanishes off the block and equals $\mathrm{Ric}_{n_0}(W)=0$ on it. And $(\mathrm{pad}\,W)^{\#}$ stays in the block because $(W^{\#})_{\alpha\beta}=\tfrac12c^\alpha_{\gamma\delta}c^\beta_{\varepsilon\zeta}W_{\gamma\varepsilon}W_{\delta\zeta}$ needs $c^\alpha_{\gamma\delta}\ne0$ with $\gamma,\delta\in\mathfrak{so}(n_0)$, forcing $\alpha\in[\mathfrak{so}(n_0),\mathfrak{so}(n_0)]=\mathfrak{so}(n_0)$. So the recorded $2\times10^{-1}$ and $8\times10^{-2}$ cannot be criticality residuals of the padded point. **Confirmed.**

**But this is [nondegeneracy.md](../findings/nondegeneracy.md)'s own paragraph**, *"Padding is a critical-point-preserving operation, exactly"*, with the identical reason, *"$[\Lambda^2\mathbb R^{n_0},\Lambda^2\mathbb R^{n_0}]\subseteq\Lambda^2\mathbb R^{n_0}$ forces $W^{\#}$ back into the block"*, and the same conclusion, *"every critical point pads to a critical point with the same $\theta$ and the same $S$"*. The adjudication's own footnote concedes *"four other places in the record compute the padded point at $n=6,7$ and find it well behaved"*. **What commit `019d339` filed as a refutation is the deletion of one wrong sentence; the supporting argument was already held.** This is question (a)'s answer.

### 3.2 THE CONSEQUENCE DOES NOT FOLLOW

The target the hatch would rescue is *$W$ ungraded and critical $\Rightarrow\lambda_{\max}(L_e|_{W^\perp})>\tfrac12$*. To refute it at $n\ge12$ the witness must satisfy three things there: critical, ungraded, and $\lambda_{\max}\le\tfrac12$. Padding delivers the first two at every $n$, the third is a different object, and **padding demonstrably does not transport it.** The record says so itself, twice:

- *"Padding does **not** preserve nondegeneracy"*, $S^3\times S^3$ carries excess $9$ into every larger $n$;
- *"**Padding creates degeneracy rather than only inheriting it**"*, the whole $S^2\times S^k$ family is nondegenerate natively and degenerate at **every** padding, excess $q(n-n_0)$.

Degeneracy is a statement about $\dim E(\tfrac12)$, so those are direct evidence that the $L_e$ spectrum **changes** in the added directions. Structurally: with $\Lambda^2\mathbb R^n=\Lambda^2V\oplus(V\otimes V')\oplus\Lambda^2V'$, $L_e$ annihilates $\mathrm{Sym}^2(\Lambda^2V')$ and acts on $\mathrm{Sym}^2(V\otimes V')$ through $e^{\#}$ alone. That block grows with $n$ and is where every new eigenvalue lives. **It is plausible its eigenvalues are $n$-independent**, the $\mathfrak{so}(n_0)$-action factors through $V$, which would explain multiplicities growing linearly at fixed eigenvalue, exactly the $4(n-4)$ pattern, **but the Weyl projection carries explicit $n$ in its trace coefficients, and nothing on the record closes that gap.**

**What is actually verified.** $\lambda_{\max}(L_e|_{W^\perp})=0.5000000000$ for padded $W_{\mathbb{CP}^2}$ at $n=5$ ([second-order.md](../findings/second-order.md)) and at $n=8$ ([target.md](../findings/target.md)'s screen table). **There is no entry at $n=12$ or above anywhere in the record**, which is precisely the range the escape hatch names. The witness therefore stands at $n=5,8$, not "at every $n\ge4$", and the hatch is **untested**, not unavailable.

### 3.3 And it closes a hatch the record had already discarded

[plan.md](../plan.md) item 1 already replaced the dimension restriction with a **support** restriction and gave the better reason: *"$\{S=0\}$ is closed under padding while gradedness is not, so padding manufactures exactly this class of artefact"*, and *"restricting by dimension instead substitutes the global value crossover for a local Hessian condition, the same substitution the record already caught once."* The support restriction is **untouched by claim 3**, a point padded at $n=12$ is still padded. So the consequence, even if it were established, costs item 1 nothing.

## Questions

### (a) Asserted as new, already held

Two. §3.1's padding argument, held verbatim in [nondegeneracy.md](../findings/nondegeneracy.md). And the closure of the $n\ge12$ restriction, which [plan.md](../plan.md) had already superseded with the support restriction (§3.3).

### (b) The 159/160 re-attribution, CORRECT, verified

$(-48,+8)$ is a fit of $C$ against $\big(\operatorname{tr}(W^3),\theta\big)$, not against the two cubics: $-40\operatorname{tr}(W^3)+8\langle W^{\#},W\rangle=-48\operatorname{tr}(W^3)+8\theta$. Checked at both points: $-48(0.0224736)+8(1.236033)=+8.80955$ and $-48(0.277663)+8(1.141798)=-4.19295$. **160's recorded coefficients already carried the corrected sign**, so the earlier "159 and 160 agreed" was the error and the re-attribution restores it. Note the consequence: **the right sign was sitting in the record's own parenthesis for three commits**, in a form no one read as a sign statement.

### (c) Closures whose stated ground does not hold, THREE

**1. Item 3a, closed on a withdrawn number.** [plan.md](../plan.md) reads *"**CLOSED on the tight-at-the-extremum test.** … the bound with exact inputs gives $9.14$ there against the true $1.236$, loose"*. That $9.14$ is withdrawn; the figure is $1.798$. The same paragraph still carries $C=40\operatorname{tr}(W^3)-8\langle W^{\#},W\rangle$, $\theta=6\operatorname{tr}(W^3)-\tfrac18C$ and *"the operative side is the **lower** bound on $C$"*, **all three withdrawn in [nondegeneracy.md](../findings/nondegeneracy.md), all three still live in the ranking file a reader consults first.** The verdict survives on the corrected number, but two further things are wrong with it: (i) the closure reaches only the *named estimate*, since $8\theta=C+48\operatorname{tr}(W^3)$ is an **identity** and any tight bound on $C$ still closes the route; (ii) the honest statement of the deficit is that Cheng–Wang's top-pair estimate gives $C\le0.134839\times98.667=13.30$ against the true $8.8095$, **a factor of $1.51$ on $C$**, not a structural obstruction. The record has over-closed this item once already (*"Non-proportionality closes nothing, and the route never needed it"*).

**2. Item 3b, retired on a computation outside its scope.** The ground is *"Morse–Bott nondegeneracy gives the component structure at $W_{\mathbb{CP}^2}$ directly"*, resting on RESULT 1, verified at **$n=6,8,10$**. The target it serves is a statement at $n\ge12$, and the padded point's Morse–Bott status is on record nowhere in that range. Worse, the argument runs *"the orbit of interest is a union of components, at the point where the supremum is attained"*, and which point attains the supremum is the conclusion, so the retirement is at minimum owed a non-circular attainment step.

**3. Item 1's repair rests on a withdrawn sentence.** [plan.md](../plan.md) still reads *"The witness stands at $n=5$ alone; a padded construction built here at $n=6,7$ is not critical."* [second-order.md](../findings/second-order.md) withdrew exactly that sentence, and the adjudication the brief calls Claim 3 is the withdrawal. **The plan's item 1 and the findings file now contradict each other on the fact both use.**

### (c-adjacent) A FALSE QUANTIFIER on a boxed identity, introduced in the fold-in

[nondegeneracy.md](../findings/nondegeneracy.md) boxes $\operatorname{tr}(W^3)/\theta=2/\big((n-1)(n-2)\big)$ *"exactly at **every sphere product**"*. **It is false off the balanced product**, and the counterexample is the next paragraph of the same file: at $S^3\times S^9$, $n=12$, the ratio is $0.277663/1.141798=\mathbf{0.2432}$ against $2/110=0.01818$, a factor of $13.4$. At $S^5\times S^7$ it is $0.03485$. The source reviewer's own text says *"the ratio is for the **balanced product only**"* and *"nothing here bounds $\operatorname{tr}(W^3)/\theta$ at an unknown maximiser"*; **the fold-in dropped both scope statements and promoted the quantifier.** The downstream sentence, *"so problem.md item 5 is a theorem rather than an observation at one point"*, survives, because item 5 concerns the maximiser only. Fix the quantifier, restore the caveat.

## What is owed

1. **Repair line 206**, it states $-C$. Its two ingredients are correct and imply the boxed sign.
2. **Repair the tight-at-extremum table's caption**, it is the withdrawn $9.14$ formula sitting above the corrected entries. Correct: $6\operatorname{tr}(W^3)+\tfrac18\cdot\tfrac{\mu_{N-1}+\mu_N}2T$, top pair, plus.
3. **Restore r163's $\mu_1+\mu_2=-1.460757$ diagnosis** and drop $\{-12,-1\}$, which matches no normalisation of $\mathring W$ at that point.
4. **Compute $\lambda_{\max}(L_e|_{W^\perp})$ for padded $W_{\mathbb{CP}^2}$ at $n=12$.** One eigenvalue at one known point, it is [plan.md](../plan.md)'s own D3, and it is the *only* thing that decides claim 3's consequence. Until then the $n\ge12$ hatch is untested rather than closed.
5. **Fix the "every sphere product" quantifier** and restore the balanced-product scope.
6. **Sync [plan.md](../plan.md) item 3a and item 1** with [nondegeneracy.md](../findings/nondegeneracy.md) and [second-order.md](../findings/second-order.md); four withdrawn statements are live there.
7. **Report whether D1's 71 points are padded**, it answers a standing debt at no new cost.
