# REVIEW r393, Gate 2 on the $\mathcal D_n$ refutation and I20: the units are right, the refutation is of a withdrawn statement, and the deficit constant is a factor $n$ smaller than the Hessian cap

*Adversarial review of the last two sections of [ATTEMPTS.md](../ATTEMPTS.md), "The $\mathcal D_n$ clause is false off the band" and "What all three clauses need is one missing theorem: a quantitative Lemma L57". Everything below was derived cold from the definitions before the sections were reopened: the sphere-product family and its $\theta$, the full $L_e$ spectrum on $\mathcal D_n$ at $S^p\times S^q$, the spherical Hessian of the value cubic, the SRG-to-$M$ normalisation and the closed form of $\theta$ on the whole DGK family. Analysis only. Three screens were run, each on objects constructed here from a hand derivation, each reported as a screen: a machine-precision criticality check on the constructed sphere products, an arithmetic evaluation of closed forms already derived by hand, and an arithmetic sweep of SRG parameter tuples against a bound proved by hand first.*

## Verdict table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | the $\mathcal D_n$ clause is false off the band; the table's two violators refute it | **REFUTED, for a reason the section itself states three paragraphs earlier.** The units check out (the column is $L_e$, off $M$), both points are genuine pure critical points, and both are below the band. But $\lambda_{\max}>\tfrac12$ refutes the *inequality* $\lambda_{\max}\le\tfrac12$, which [Gate 2 withdrew](../ATTEMPTS.md) as "the wrong encoding", and says **nothing** about the surviving clause $\tfrac12\notin\mathop{\mathrm{spec}}$ |
| 2 | therefore any proof must spend $\theta\ge\sqrt{3/2}$, and no bound valid at all pure critical points exists | **REFUTED as an inference.** Both witnesses sit at $n=9$ and $n=10$, where **the band is empty** ($\Theta_n<\sqrt{3/2}$ for every $n\le11$) so they cannot separate "spends the band" from "spends $n\ge12$". Padding repairs $n$ but makes both witnesses $\circ$-decomposable, so they cannot separate it from "spends indecomposability" either |
| 3 | all three I18 clauses are band-dependent | **REFUTED, by [plan.md](../plan.md)'s own sentence.** The pair clause is *closed* on every non-orbit-free pair and "**needs only $\theta\ge1$, not the band**". [Post F47](../findings/INDEX-traps.md) and F48 fence *methods*; [post F50](../findings/INDEX-traps.md) kills a *route* and the record says in as many words "the clause itself is untouched" |
| 4 | I20 $\theta\le\Theta_n-c_nd^2$, $d=\mathop{\mathrm{dist}}(M,SO(n)\cdot M_{\text{bal}})$ in $\mathcal D_n$ | **The shape is right; the orbit is wrong.** $SO(n)$ conjugation does **not** preserve $\mathcal D_n$, it destroys both hollowness and the zero row sums. The object is the **finite** orbit $S_n\cdot M_{\text{bal}}=SO(n)\cdot M_{\text{bal}}\cap\mathcal D_n$, and its finiteness is what makes the whole second-order calculation clean |
| 5 | $c_n\le3\Theta_n/(2(m-1))$, from the Hessian's least-negative eigenvalue | **CONFIRMED, in the $\Lambda^2$ normalisation $\lVert W\rVert^2=\tfrac12\mathop{\mathrm{tr}}M^2=1$**, re-derived cold. The direction of the inequality is **right**, a global inequality restricted to small $d$ is exactly what the expansion constrains. **But the cap is only valid if I20 is the all-$M$ statement**, and the application needs only the critical-point statement, for which no local expansion is available |
| 6 | $d\le0.175$ at $n=12$; diameter $2\sqrt2$; vacuous near $n\approx180$ | **$0.175$ CONFIRMED** (in $\Lambda^2$ units, $0.2467$ Frobenius). **The diameter is $2$, not $2\sqrt2$**, in the same units the $0.175$ is in. **$n\approx180$ is REFUTED and is the artefact of that mixed pair**: done consistently the Hessian-cap window closes at $n=102$ |
| 7 | is I20 true? | **TRUE with some $c_n>0$**, one line from L57's uniqueness plus compactness, so this is not the open question. **But the constant is $O(n^{-2})$, not $O(n^{-1})$**, and the binding competitor is on record: $S^{m-1}\times S^{m+1}$ forces $c_{12}\le0.0126$, **thirty times** below the Hessian cap. **The consequence the item wants is vacuous from $n=14$ up** |
| 7b | are the DGK/SRG solutions the falsifier? | **NO, and this closes [R15](../routes.md)'s falsifier question.** $\theta$ on the whole SRG family in closed form; **primitive** SRGs cap at $\theta<\tfrac12$; the imprimitive ones are $\sqrt{2(n-1)(g-1)/(n(n-g))}$, maximised uniquely at $g=n/2$, which **is** the balanced product. **No SRG point is in the band except the maximiser itself** |

---

## 0. What the cold derivation gives, and every number below rests on it

**The diagonal family, from criticality alone.** Take $M$ block-constant on $A\sqcup B$ with $\lvert A\rvert=p$, $\lvert B\rvert=q$, $p+q=n$: value $a$ inside $A$, $b$ inside $B$, $c$ across. Zero row sums give $(p-1)a+qc=0$ and $(q-1)b+pc=0$. The cross criticality equation $M_{ij}^2+(M^2)_{ij}=\theta M_{ij}$ reads $c^2-nc^2=\theta c$, so

$$c=-\frac{\theta}{n-1},\qquad a=\frac{q\theta}{(n-1)(p-1)},\qquad b=\frac{p\theta}{(n-1)(q-1)},$$

and the two within-block equations are then **identities**, every $(p,q)$ is critical. Imposing $\mathop{\mathrm{tr}}M^2=2$:

$$\boxed{\ \theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{pq\,(n-2)}\ }$$

which returns $\Theta_n^2=2(n-1)(n-2)/n^2$ at $p=q$, $1.115547$ at $(3,5)$ and $1.228239$ at $(5,7)$, the record's own three values, reproduced from criticality and the normalisation with nothing borrowed. *Screen: the constructed matrices have row sums $10^{-16}$, $\mathop{\mathrm{tr}}M^2=2.000000$ and criticality residual $5.6\times10^{-17}$ at $(n,p)=(12,6),(12,5),(12,4),(8,3)$.*

**The full $L_e$ spectrum on $\mathcal D_n$ at $S^p\times S^q$, derived here.** $\mathcal L(N)=\mathop{\mathrm{hollow}}(M\circ N+\tfrac12(MN+NM))$ splits $\mathcal D_n$ into four $S_p\times S_q$-types, and each is an eigenspace:

| type | description | dimension | $L_e$ eigenvalue |
| --- | --- | --- | --- |
| radial | $N=M$ | $1$ | $1$ |
| vector, $A$-side | $N_{ij}=s(u_i+u_j)$ on $A$, $xu_i$ across, $u\perp\mathbf1$, $s(p-2)+qx=0$ | $p-1$ | $\dfrac{p-2}{2(p-1)}$ |
| vector, $B$-side | the mirror | $q-1$ | $\dfrac{q-2}{2(q-1)}$ |
| block-internal | $N$ supported inside one factor, in $\mathcal D_p$ or $\mathcal D_q$ | $\tfrac{p(p-3)}2+\tfrac{q(q-3)}2$ | $0$ |
| cross | $N$ supported on $A\times B$, both marginals zero | $(p-1)(q-1)$ | $\dfrac{c-\tfrac{a+b}2}{\theta}<0$ |

Dimensions sum to $n(n-3)/2=\dim\mathcal D_n$. **So $\lambda_{\max}(L_e\vert_{\mathcal D_n\cap M^\perp})=\frac{Q-2}{2(Q-1)}$ with $Q=\max(p,q)$**, independently confirming [r392](REVIEW_r392.md)'s claim 7 and [r375](REVIEW_r375.md)'s $\mathcal D_n$ row, and giving $\tfrac38=0.375$ at $Q=5$ and $\tfrac4{10}=0.400$ at $Q=6$.

**That settles the brief's units question outright.** $0.375$ and $0.400$ are the $L_e$ eigenvalues, not $\mathcal L$ eigenvalues (those would be $\theta$ times as large, $0.418$ and $0.494$), so [diagonal-half.md](../findings/diagonal-half.md)'s column is $L_e$ off $M$ and $\tfrac12$ is the right comparison. Two further confirmations from inside the record: [nondegeneracy.md](../findings/nondegeneracy.md) writes the $C_5$ blow-up entry as "$\lambda_{\max}(L_e\vert_{W^\perp})=1.206011$" in as many words, and [Observation L98](../findings/diagonal-half.md)'s floor $\min\lambda_{\max}=1+\frac1{2(n-3)(n-4)}$ converges to $1$, which is $M$'s own $L_e$ eigenvalue and is a nonsense number in any other normalisation. **The section's arithmetic is clean. What fails is one logical step and it is the section's own correction of two paragraphs earlier.**

---

## 1. The $\mathcal D_n$ refutation refutes a statement the record already withdrew

**The clause, in the form Gate 2 left standing**, is quoted correctly at the head of the section: $\tfrac12\notin\mathop{\mathrm{spec}}(L_e\vert_{\mathcal D_n\cap M^\perp})$, an **eigen-equation**, not an inequality. The section then refutes $\lambda_{\max}\le\tfrac12$ with a table of two points at $1.206011$ and $1.303584$.

**A point with $\lambda_{\max}=1.206011$ is silent on whether $\tfrac12$ is in the spectrum.** The record makes exactly this correction one screen higher, on the same page: *"no quadratic-form inequality in $X$ can encode that, since a Rayleigh range is an interval and may straddle $\tfrac12$ without containing it"*, and prints the witness that shows it, a $54$-dimensional $\mathcal D_n$ spectrum $\{-0.5,-0.3,-0.15,0,0.25,0.45,0.6,1.0,1.2\}$ with **$\tfrac12$ absent and $\lambda_{\max}=1.2$**, where "the clause holds while the box fails". The new section reproduces that pattern at two more points and reads it the opposite way.

**What the two points do establish, and it is worth keeping**: the *inequality* form of the $\mathcal D_n$ clause is false at pure critical points, so the route from [Lemma L24](../findings/second-order.md)'s maximiser bound to I18 cannot go through a Rayleigh bound. **What they do not establish is anything about I18(d).** Deciding that needs the $\mathcal D_n$ spectra of those two points read for the *value* $\tfrac12$, which is a check on objects already on file, and which the record has run once before at r391's witness with the answer "absent".

**Both points are genuine.** The $C_5$ blow-up is [catalogued](../findings/nondegeneracy.md) at $n=10$, blocks $(2,2,2,2,2)$, entries $4:-2:+1$, criticality residual $1.3\times10^{-16}$, trivial kernel, $\theta=0.670820393$, a pure (frame-diagonal) critical point in the sense [plan.md](../plan.md) defines. The $n=9$ witness is on the same table with $\Delta=12.07$. Neither is a padding artefact.

**And both are trivially below the band, for a reason the section does not give.** $\Theta_9=1.171080$, $\Theta_{10}=1.200000$, $\Theta_{11}=1.217162$, all $<\sqrt{3/2}=1.224745$; $\Theta_{12}=1.236033$ is the first above it. **The band $[\sqrt{3/2},\Theta_n]$ is empty at every $n\le11$** (which is exactly where the $n\ge12$ threshold comes from) so no $n=9$ or $n=10$ critical point can be in it, whatever its $\theta$. The section's "$\theta=0.6708$, so below the band" is true and is not the operative fact.

---

## 2. "Must spend the band" does not follow

**The clause as stated in [plan.md](../plan.md) carries two hypotheses**, $n\ge12$ **and** $\theta\ge\sqrt{3/2}$. Both witnesses violate the first. Since the band is empty below $n=12$, a witness at $n\le11$ **cannot distinguish which of the two hypotheses is load-bearing**, and the section's conclusion, "any proof of this clause must therefore spend $\theta\ge\sqrt{3/2}$; an attempt that never uses the band is refuted before it starts", is not supported by them.

**The repair is available and the section should make it.** Padding is legitimate: appending zero rows preserves hollowness, symmetry, zero row sums, $\mathop{\mathrm{tr}}M^2=2$ and every criticality equation (both sides vanish on a padded index), and $\mathcal D_{n_0}\hookrightarrow\mathcal D_n$ is $\mathcal L$-equivariant on the supported block, so $\lambda_{\max}$ cannot fall. The $C_5$ blow-up padded to $n=12$ is a pure critical point at $n=12$ with $\theta=0.670820$ and $\lambda_{\max}(L_e\vert_{\mathcal D_{12}})\ge1.206011$. **With that step the dimension hypothesis is genuinely eliminated.**

**But the repair costs the conclusion the rest of its force.** A padded point has a zero row, hence is $\circ$-decomposable, and [plan.md](../plan.md) names $\circ$-indecomposability as the other candidate hypothesis in the same item, "free at a maximiser and exactly what a maximiser has that a critical point does not". So after padding the witnesses separate the clause from *pure criticality alone*, and from nothing finer. **The honest statement is: the $\mathcal D_n$ inequality needs some hypothesis beyond pure criticality, and the record's two witnesses do not say which.** Both $\theta\ge\sqrt{3/2}$ and indecomposability remain live, and they are not the same hypothesis.

---

## 3. "All three clauses are band-dependent" is refuted by the record

Checked against the three cited posts, one at a time.

| clause | what the cited post actually says | band-dependent? |
| --- | --- | --- |
| **pair**, [post F47](../findings/INDEX-traps.md) | $\widetilde No=(\theta+M_{jk})o$ at every pure critical point, so in a non-orbit-free block the clause is an **exact equality** and no lossy estimate can certify it. A statement about **which methods can reach it** | **No.** [plan.md](../plan.md), same item: the pair half "is **CLOSED** on every non-orbit-free pair … **It needs only $\theta\ge1$, not the band**, and it holds at a critical point rather than a maximiser" |
| **pair**, post F48 | $\lambda_{\max}(\widetilde N)\le\theta+M_{jk}$ is **false at padded pairs**, so no sharpening reaches it; the clause is a separation and "that survives padding". A statement about a **proof target** | **No**, and [Lemma L129](../findings/diagonal-half.md) then closes the padded sub-case outright at every pure critical point |
| **four-set**, [post F50](../findings/INDEX-traps.md) | the **mass-only criterion** is refuted and both projection repairs fail, the second on an equality at $\sqrt{3/2}$. [plan.md](../plan.md), one sentence later: "**The clause itself is untouched: $\Sigma=0$ at every witness**" | **Unknown, and certainly not shown false off the band.** A route dying on a band-boundary equality is a fact about the route |
| **$\mathcal D_n$** | this section's table | **The only one of the three with any evidence**, and it establishes only that the *inequality* form needs a hypothesis beyond pure criticality (§1–2) |

**The claim conflates three distinct things**: a clause being *false* without the band (which is what "band-dependent" means and what the $\mathcal D_n$ table gestures at), a *method* being unable to prove it without the band (F47, F48), and a *route* dying at the band boundary (F50). Only the first is a property of the clause. **And on the pair clause the record asserts the opposite of the section's claim, in bold, in the item the section is working.**

*The section's conclusion "none of the six routes spent the band except through $\theta^2\ge\tfrac32$ as a number" is separately true and is the section's real content; it does not need the band-dependence claim to stand.*

---

## 4. The orbit is the wrong object, and the right one is better

**$SO(n)$ acting by conjugation does not preserve $\mathcal D_n$.** For $g\in SO(n)$, $(gMg^{\mathsf T})_{ii}\ne0$ in general, so hollowness fails; and $gMg^{\mathsf T}\mathbf1=gM(g^{\mathsf T}\mathbf1)$, which is zero only when $g^{\mathsf T}\mathbf1$ is in $\ker M$, so the zero row sums fail too. **"$\mathop{\mathrm{dist}}(M,\ SO(n)\cdot M_{\text{bal}})$ in $\mathcal D_n$" is therefore not well posed as written**, the set it measures distance to is not in the space the metric is on. *(The sign group does no better: $DMD$ for $D=\mathop{\mathrm{diag}}(\pm1)$ is hollow but has row sums $DM\epsilon\ne0$.)*

**The correct object is $S_n\cdot M_{\text{bal}}$**, the permutation orbit, which is exactly $SO(n)\cdot M_{\text{bal}}\cap\mathcal D_n$: the frames in which the balanced product's Weyl tensor is coordinate-diagonal are $O(m)\times O(m)$ times a permutation, and $O(m)\times O(m)$ fixes $M$ pointwise because each factor's curvature tensor is $O(m)$-invariant.

**This is a correction that makes the item easier, not harder.** The permutation orbit is **finite**, so it has no tangent space, so the second-order expansion of §5 has no orbit directions to quotient out and $d(M(t))=\lVert M(t)-M_{\text{bal}}\rVert$ exactly for small $t$. Under the $SO(n)$ reading the orbit would be positive-dimensional and $d$ strictly smaller, making I20 a strictly stronger statement than the one the item wants.

**The item should also say which norm $d$ is in.** The record carries two, differing by $\sqrt2$ in $d$ and $2$ in $c_n$, $\lVert X\rVert^2_{\Lambda^2}=\tfrac12\mathop{\mathrm{tr}}X^2$ (the canonical one, in which $\lVert W\rVert=1$) and Frobenius. §6 shows the section mixes them.

---

## 5. Re-deriving the cap: the direction is right, the constant is right, and the hypothesis it needs is stronger than the one the item wants

**The value functional on the locus.** $F(M)=\tfrac12\big(\sum_{i,j}M_{ij}^3+\mathop{\mathrm{tr}}M^3\big)$, with $F(M)=\theta$ at a critical point (contract criticality against $M$). Its derivatives:

$$DF(M)[N]=\tfrac32\big(\langle M^{\circ2},N\rangle+\langle M^2,N\rangle\big),\qquad D^2F(M)[N,N]=3\big(\langle M\circ N,N\rangle+\mathop{\mathrm{tr}}(MN^2)\big)=3\langle N,\mathcal LN\rangle .$$

**The spherical Hessian.** On $\{\mathop{\mathrm{tr}}X^2=2\}$, $\mathop{\mathrm{Hess}}=D^2F-\frac{\langle\nabla F,M\rangle}{\lVert M\rVert^2}\mathop{\mathrm{Id}}$ with $\langle\nabla F,M\rangle=3F(M)=3\theta$, so in **Frobenius** units $\mathop{\mathrm{Hess}}=3\theta\,(L_e-\tfrac12)$, and in the $\Lambda^2$ units where $\lVert M\rVert^2=1$ it is $6\theta\,(L_e-\tfrac12)$, **[r375](REVIEW_r375.md)'s operator exactly**. Its least-negative eigenvalue is $6\theta(\lambda_m-\tfrac12)=-3\theta/(m-1)$ at the top $\mathcal D_n$ direction $\lambda_m=\frac{m-2}{2(m-1)}$ of §0, and halving for the quadratic gives

$$c_n\ \le\ \frac{3\Theta_n}{2(m-1)}\quad(\Lambda^2),\qquad\qquad c_n\ \le\ \frac{3\Theta_n}{4(m-1)}\quad(\text{Frobenius}).$$

**Confirmed, and the attribution to r375 is right.** *The two forms are one statement; anyone comparing them across the record's two norms will see a spurious factor of two, which is why §6's mixed pair matters.*

**The brief's worry about direction is misplaced, and this is worth stating plainly.** A *global* inequality $\Theta_n-F(M)\ge c_nd^2$ holds in particular for small $d$, and restricting it there is exactly what the expansion constrains, a small-$d$ expansion is a perfectly valid source of a **necessary** condition on a global constant. The failure mode a cap-from-above has is the opposite one: it bounds how good the best possible inequality is, which is how the section uses it.

**The real defect is elsewhere: the cap needs a hypothesis the application does not.** The expansion moves along a great circle $M(t)=\cos t\,M_{\text{bal}}+\sin t\,\hat N$ whose points are **not critical**. So the cap constrains I20 only in its *all-$M$* reading, "$F(M)\le\Theta_n-c_nd^2$ for every $M$ on the sphere in $\mathcal D_n$". The use I18 makes of it (confining a *critical* point with $\theta\ge\sqrt{3/2}$), needs only the critical-point reading, which admits a larger constant and is not capped by any local expansion. **As stated, the item over-states its own hypothesis and then reports the resulting cap as a limitation.** §7 shows this does not rescue it, because the binding constraint turns out to come from critical points anyway, but the item should be restated with the two readings separated, since only one of them is what I18 consumes.

**One presentational point.** The displayed chain

$$d^2\le\frac{\Theta_n-\sqrt{3/2}}{c_n}\ \ge\ \frac{2(m-1)(\Theta_n-\sqrt{3/2})}{3\Theta_n}$$

is a non-implication as written, "$d^2\le X$ and $X\ge Y$" gives no bound by $Y$. The prose around it is correct ("even a sharp deficit inequality confines only to"), so this is a display to fix rather than a claim to withdraw.

---

## 6. The three numbers

| quantity | record | this review |
| --- | --- | --- |
| $\Theta_{12}-\sqrt{3/2}$ | $0.0113$ | $1.236033-1.224745=\mathbf{0.011288}$ ✓ |
| best-case $d$ at $n=12$ | $0.175$ | $\mathbf{0.17448}$ ✓, **in $\Lambda^2$ units** ($0.24675$ Frobenius) |
| diameter | $2\sqrt2$ | **$2$**, in the units the $0.175$ is in. $2\sqrt2$ is the Frobenius diameter, $2\lVert M\rVert_F$ |
| goes vacuous at | $n\approx180$ | **$n=102$.** The record's threshold solves $\frac{2(m-1)(\Theta_n-\sqrt{3/2})}{3\Theta_n}\ge8$ and returns $n=192$; the consistent condition is $\ge4$ and returns $n=102$ |

**So the "$n\approx180$" is exactly the mixed-convention artefact §4 warned about**: an $\Lambda^2$ radius compared against a Frobenius diameter. Everything else in the paragraph, the $1/n$ decay of the margin, the band widening to $\sqrt2-\sqrt{3/2}=0.189469$, the growth of the best-case radius like $\sqrt m$, is right.

*Screen: all four rows are closed-form arithmetic in $n$, evaluated on the formulas derived in §0 and §5.*

---

## 7. Is I20 true, and what is the constant really?

### (a) True, and trivially so, which means the item is asking the wrong question

$K=\{M\in\mathcal D_n:\mathop{\mathrm{tr}}M^2=2\}$ is compact; $F$ is continuous; [Lemma L57](../findings/problem.md) gives $F\le\Theta_n$ with equality **exactly** on $S_n\cdot M_{\text{bal}}$. So $(\Theta_n-F)/d^2$ is continuous off the orbit, and near it tends to the Hessian quotient, which is $\ge\frac32\Theta_n(\tfrac12-\lambda_m)>0$ by §5. Its infimum over $K$ is therefore attained and positive. **I20 holds with $c_n=\min_K(\Theta_n-F)/d^2>0$, in one paragraph.** The open question was never existence; it is the *size* of $c_n$, which is what confinement consumes.

### (b) The binding competitor is on record and it is not an SRG

**$S^{m-1}\times S^{m+1}$ is a diagonal critical point at distance $O(1)$ from the balanced orbit with a value deficit $O(n^{-3})$.** From §0, at $n=2m$,

$$1-\frac{\theta(m-1,m+1)^2}{\Theta_n^2}=\frac{2m-1}{(m-1)^2(m^2-1)}\ \sim\ \frac{2}{m^3},\qquad\text{so}\qquad \Theta_n-\theta\ \sim\ \frac{\sqrt2}{m^3},$$

while the distance does **not** shrink like the deficit: moving one vertex between the factors changes $\approx4m$ entries by $\approx\theta/m$ each, so $d_F^2\approx 4\theta^2/m\to 8/m$. Hence

$$c_n\ \le\ \frac{\Theta_n-\theta(m-1,m+1)}{d^2}\ \sim\ \frac{\sqrt2}{8m^2}\ \ (\text{Frobenius}),\qquad \frac{\sqrt2}{4m^2}\ \ (\Lambda^2),$$

against the Hessian cap's $\sim\frac{3\sqrt2}{4m}$. **The true constant is a factor $\sim n$ smaller than the cap the item is using.** Exact values, computed from the closed forms of §0 with the distance minimised over the permutation orbit (only the overlap $\lvert P\cap B_1\rvert$ matters, and the maximum is at full overlap):

| $n$ | $\Theta_n$ | $\theta(S^{m-1}\!\times\! S^{m+1})$ | $\Theta_n-\theta$ | $d^2_{\Lambda^2}$ | $c_n$ forced $(\Lambda^2)$ | Hessian cap | confinement $d^2_{\Lambda^2}\le$ |
| --- | --- | --- | --- | --- | --- | --- | --- |
| $12$ | $1.236033$ | $1.228239$ | $0.007794$ | $0.61987$ | $\mathbf{0.012574}$ | $0.370810$ | $\mathbf{0.898}$ |
| $14$ | $1.261680$ | $1.256925$ | $0.004755$ | $0.53615$ | $0.008869$ | $0.315420$ | $\mathbf{4.165}$ |
| $16$ | $1.280869$ | $1.277753$ | $0.003116$ | $0.47248$ | $0.006594$ | $0.274472$ | $8.511$ |
| $20$ | $1.307670$ | $1.306120$ | $0.001550$ | $0.38192$ | $0.004058$ | $0.217944$ | $20.43$ |

*Screen: the criticality of every matrix in this table was checked to $5.6\times10^{-17}$; the $\theta$, $d^2$ and $c$ columns are evaluations of the §0 closed forms; the $d^2$ at $(12,5)$ was also computed by hand from the five pair classes and agrees to five digits. The other splits were swept and $(m-1,m+1)$ binds at every $n$ in the table.*

**The confinement the item wants is therefore vacuous from $n=14$ up.** Any two points of $\{ \mathop{\mathrm{tr}}X^2=2\}$ satisfy $d^2_{\Lambda^2}\le4$; the table's last column exceeds $4$ already at $n=14$. **At $n=12$, the only dimension where anything survives**, I20 confines to $d_{\Lambda^2}\le0.94751$ ($d_F\le1.34$), against $d_F=1.11$ for the very point that forces the constant, $d_F=1.897$ for the antipode $-M_{\text{bal}}$, and $d_F\approx1.84$ for a typical point of $\mathcal D_{12}$ on the sphere. **So the confinement is a ball that barely contains the competitor that produced it, at one value of $n$.**

*This is a strictly stronger closure than the Hessian cap gives, and it does not share the cap's weakness: $S^{m-1}\times S^{m+1}$ is a genuine critical point, so the bound survives restricting I20 to critical points, which is the reading I18 consumes.*

### (c) The DGK/SRG family is not the falsifier, and this closes [R15](../routes.md)'s open question

[plan.md](../plan.md) blocks quoting any SRG $\theta$ until "the SRG-to-$W$ normalisation is pinned". **It is pinned here, from criticality alone.** Write $M=zA+y(J-I)$ for a $k$-regular graph $A$ on $n$ vertices. Zero row sums force $y=-kz/(n-1)$. Criticality separates into

$$\text{(off-graph coefficient)}\quad z^2(1+\lambda-\mu)=\theta z,\qquad\text{(constant)}\quad z^2\mu+2zyk+y^2(n-1)=\theta y,$$

and substituting $y$ makes the second **exactly** the strongly-regular identity $k(k-1-\lambda)=\mu(n-1-k)$. *So every strongly regular graph is a diagonal critical point, and no other two-value $M$ is, DGK's theorem, re-derived from this record's own equation.* Then $\mathop{\mathrm{tr}}M^2=2$ gives $z^2=\frac{2(n-1)}{nk(n-1-k)}$ and

$$\boxed{\ \theta(\Gamma)=\lvert 1+\lambda-\mu\rvert\sqrt{\frac{2(n-1)}{n\,k\,(n-1-k)}}=\lvert1+r+s\rvert\sqrt{\frac{2(n-1)}{n\,k\,(n-1-k)}}\ }$$

with $r,s$ the restricted eigenvalues. *Check: $K_{m,m}=\mathrm{SRG}(2m,m,0,m)$ returns $\sqrt{(2m-1)(m-1)}/m=\Theta_{2m}$, the record's own value at [diagonal-half.md](../findings/diagonal-half.md); and $2K_m$ returns the same number because it returns the **same matrix** $M$, which is why the record calls them one point.*

**The imprimitive family is $K_{t\times g}$ and $mK_g$** ($n=tg$), for which the formula collapses to

$$\theta=\sqrt{\frac{2(n-1)(g-1)}{n(n-g)}},$$

**strictly increasing in $g$**, so maximised at $g=n/2$, $t=2$, the balanced sphere product. The runner-up $t=3$ gives $\sqrt{(n-1)(n-3)}/n\to1$, below $\sqrt{3/2}$ at every $n$: $0.829156$ at $n=12$, $0.944036$ at $n=36$, $0.795990$ at the best $t\ge3$ split of $n=100$.

**The primitive family is bounded away from the band by a wide margin.** With $r\ge1$, $\sigma=-s\ge2$, $\mu=k-r\sigma\ge1$ and $n-1-k=\frac{k(1+r)(\sigma-1)}{k-r\sigma}$, the formula becomes $\theta^2\le\frac{2(1+r-\sigma)^2(k-r\sigma)}{k^2(1+r)(\sigma-1)}$, maximised over real $k$ at $k=2r\sigma$, giving

$$\theta^2\ \le\ \frac{(u-v)^2}{2u(u-1)v(v-1)},\qquad u=1+r\ge2,\ v=\sigma\ge2,$$

which is $\le\tfrac14$ for all $u,v\ge2$, the expression being symmetric in $u\leftrightarrow v$: at $u=2$ it is $\frac{(v-2)^2}{4v(v-1)}$, and $(v-2)^2\le v(v-1)\iff 4\le3v$; for $v\ge u\ge3$ it is at most $\frac{(v-3)^2}{12v(v-1)}<\frac{v}{12(v-1)}\le\tfrac18$. **So every primitive strongly regular graph has $\theta<\tfrac12$.** *Screen over every arithmetically feasible primitive parameter tuple with $n\le200$, integral eigenvalues or conference parameters, $\mu$ from the identity: the maximum is $0.475755$ at $(195,66,1,33)$, consistent with the bound and far below $\sqrt{3/2}=1.224745$.*

**Verdict on point 7's central worry: the DGK/SRG solutions contain no second point near $\Theta_n$.** At every $n$ the balanced product is the **unique** SRG point in the band, and the gap to the family's runner-up is at least $\Theta_n-1\ge0.236$ and grows. R15's clearance criterion ("a two-eigenvalue non-sphere-product critical point that saturates Lemma L70"), has no candidate in the band, and its falsifier role in [I18](../plan.md)(a) is discharged: **evaluating L121/L122 at a DGK point cannot produce an in-band counterexample, because no DGK point is in band.** *That is a closure of a live sub-step, obtained analytically, and it is the useful half of this review.*

**What kills I20's usefulness is the family the route was not looking at**: the unbalanced sphere products $S^{m-1}\times S^{m+1}$, which are three-valued rather than two-valued, hence invisible to the SRG classification, and which the record has held since $S^5\times S^7$ refuted the middle-band-on-slack claim.

---

## Recommendation

**Do not open the I20 build item.** It would prove a theorem that is true, whose constant is already pinned within a factor by a point on record, and whose consequence (confinement of an in-band critical point to a small ball around the balanced orbit), is **vacuous for every $n\ge14$** and worth $d_F\le1.34$ against a typical $1.84$ at $n=12$. *The item's own diagnosis is right in shape and wrong in size: it identified that the Hessian caps $c_n$ from above and confinement needs it from below, then computed the cap and not the true constant, which is smaller by a factor $n$.*

**Three things from this review are worth folding into the record regardless.**

1. **The SRG normalisation and $\theta(\Gamma)$ in closed form** (§7c), with the two corollaries: every SRG is a diagonal critical point, and the balanced product is the unique SRG point in the band at every $n$. That is [I18](../plan.md) sub-step (a) delivered analytically and [R15](../routes.md)'s falsifier question answered.
2. **The full $L_e$ spectrum on $\mathcal D_n$ at $S^p\times S^q$** (§0), five eigenspaces with dimensions summing to $\dim\mathcal D_n$, which subsumes the isolated values [Lemma L127](../findings/second-order.md) and [r375](REVIEW_r375.md) carry.
3. **The band is empty at $n\le11$** (§1) ($\Theta_9,\Theta_{10},\Theta_{11}<\sqrt{3/2}<\Theta_{12}$) which is a one-line derivation of the $n\ge12$ threshold from [Lemma L57](../findings/problem.md) and which retires "below the band" as an observation about any witness at $n\le11$.

## Screens run

Three, each on objects constructed here from a hand derivation, each after the claim it tests was derived analytically, none offered as evidence for a positive claim.

1. **Criticality of the constructed sphere products**, row sums $\le1.4\times10^{-16}$, $\mathop{\mathrm{tr}}M^2=2.000000$, criticality residual $\le5.6\times10^{-17}$ at $(n,p)=(12,6),(12,5),(12,4),(8,3)$. Confirms §0's closed form for $a,b,c,\theta$.
2. **Arithmetic evaluation of §0/§5/§6's closed forms** across $n=12\ldots180$, including the permutation-orbit distance (a finite maximisation over the single overlap parameter), and the $n=12$ distance reproduced by hand from the five pair classes. The two orientation figures for $n=12$, the antipode at $d_F=1.897$ and a median $d_F=1.844$ over $300$ constructed points of $\mathcal D_{12}$ on the sphere, come from the same evaluation and are offered only as scale, not as evidence.
3. **Sweep of arithmetically feasible SRG parameter tuples, $n\le200$**, against the hand-proved bound $\theta<\tfrac12$ for primitive SRGs. Maximum $0.475755$; no violation.

*No search, sweep, census or falsifier hunt was opened.*
