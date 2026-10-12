# Reviewer 394, Gate 2 on the quantitative-L57 build item and the two closing sections of ATTEMPTS.md

*2026-09-02. Adversarial review, cold derivation first, author's text opened only after. **Analysis only**; the four screens below are seconds of compute on objects built for the screen, reported as screens and never as evidence for a positive claim. Log: [agent_logs/gate2-ql57-B.log](../agent_logs/gate2-ql57-B.log).*

**Headline.** The build item's decisive question, *is a quantitative [Lemma L57](../findings/problem.md) available*, survives, and the SRG threat to it is absent by a factor of $1.4$. But the section that motivates the item, [The $\mathcal D_n$ clause is false off the band](../ATTEMPTS.md), **is refuted at its own headline witness**: it infers falsity from $\lambda_{\max}>\tfrac12$ when the clause it restates one paragraph earlier excludes the *value* $\tfrac12$, and at the $C_5$ blow-up the $\mathcal D_n$ spectrum misses $\tfrac12$ by $0.0286$. One of the item's three legs is not there.

---

## Verdict table

| # | claim | verdict |
|---|---|---|
| 1 | I20 is true / no SRG sits near $\Theta_n$ | **CONFIRMED**, with a new exact bound |
| 2 | the $\mathcal D_n$ clause is false off the band | **REFUTED**, witness below |
| 2a | the two witnesses sit below the band | **CONFIRMED** ($0.6708$ and $0.6411$) |
| 2b | the table's column units | **CONFIRMED**, it is $\lambda_{\max}(L_e)$ throughout |
| 3 | $c_n\le3\Theta_n/(2(m-1))$ and the second-order step | **CONFIRMED**, the step is valid; the cap is not the binding one |
| 4 | $d\le0.175$ at $n=12$; diameter $2\sqrt2$; vacuous near $n\approx180$ | **CONFIRMED / CONFIRMED / CORRECTED** to $n=190.8$ |
| 5 | all six routes spent the band only as a number | **REFUTED**, [ATTEMPTS.md](../ATTEMPTS.md) spends it structurally two entries earlier |
| 6 | the deficit is measured to the balanced orbit | **CORRECTED**, the orbit is empty at odd $n$, and the odd margin is misrecorded |

---

## The cold derivation, before the author's text

Reconstructed from the definitions in [findings/problem.md](../findings/problem.md) alone. Write $S:=\sum_{a,b}M_{ab}^3$ (entrywise) and $T:=\operatorname{tr}M^3$ (spectral), so $\theta=\tfrac12(S+T)$, an identity, being diagonal criticality contracted against $M$.

**Result 1 (spectral ceiling).** $M\mathbf1=0$ puts $0$ in the spectrum, so the other $n-1$ eigenvalues carry $\sum\mu=0$, $\sum\mu^2=2$. For a spectrum with the positive value at multiplicity $p$ and the negative at $q$, $p+q=n-1$, one gets $T=2^{3/2}(q-p)/\sqrt{pq(p+q)}$, maximised at $p=1$:
$$T\;\le\;T_{\max}(n)=\frac{2\sqrt2\,(n-3)}{\sqrt{(n-1)(n-2)}} .$$

**Result 2.** The balanced sphere product attains it, its spectrum being exactly $\big(\sqrt{2(n-2)/(n-1)},\ 0,\ -\sqrt2/\sqrt{(n-1)(n-2)}^{\ (n-2)}\big)$. *This is on record numerically at [diagonal-half.md](../findings/diagonal-half.md) ("to six digits"); Results 1 and 3 make it exact.*

**Result 3 (rigidity, new, and it settles item 6).** Equality forces $M=-bI+(a_++b)uu^{\mathsf T}+\tfrac bn\mathbf1\mathbf1^{\mathsf T}$; hollowness makes $u_i^2$ constant and $M\mathbf1=0$ makes $u\perp\mathbf1$, so $u=n^{-1/2}(\pm1,\dots,\pm1)$ with an **equal sign split**. Hence

> $T=T_{\max}$ on $\mathcal D_n$ **iff** $n$ is even and $M$ is the balanced sphere product, up to permutation, and **at odd $n$ the balanced orbit is empty**.

**Result 4 (what the entrywise half does).** $S$ at the balanced product is $4\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)=O(n^{-2})$, $0.044941$ at $n=12$, while $S$ is $O(1)$ elsewhere: the zero-padded $S^2\times S^2$ carries $S=1/\sqrt3=0.5774$ at every $n$. **So the entrywise half is a liability, not a second cap**, and the deficit does not decompose into two nonnegative pieces. *This confirms the record's $1.213562+0.022471=1.236033$ split from the definitions; see the stale-figure note below.*

**Result 5 (the shape of any deficit inequality).** From $\Theta_n-\theta=\tfrac12(T_{\max}-T)+\tfrac12(S_{\text{bal}}-S)$, and $T_{\max}-T$ vanishing exactly on the balanced orbit by Result 3,
$$\theta\le\Theta_n-c_nd^2\quad\Longleftrightarrow\quad S-S_{\text{bal}}\;\le\;(1-\varepsilon)\,(T_{\max}-T),\ \varepsilon>0 .$$
**The $\varepsilon=0$ case is exactly [Lemma L57](../findings/problem.md).** So the quantitative L57 is L57 with a uniform gain, a strengthening of a proved theorem, and every bit of the work is in $\varepsilon>0$. *The section's phrase "a statement about the diagonal locus alone, the half this programme has already proved" reads as though the proved half is most of the way there; it is the $\varepsilon=0$ endpoint and supplies none of the content.* **Silently used hypothesis, now named.**

---

## 1. Is I20 true? The SRG family answers, and it is nowhere near

[Lemma L74](../findings/diagonal-half.md) was re-derived by hand and is **correct**: expanding $N^2$ on $\{I,A,J\}$ with $t=k/w$, $1+t=(v-1)/w$ gives $F_{\text{edge}}=\big[(v-1)^2\lambda+2k(v-1)-k^2v+w^2\big]/w^2$, matching the recorded closed form term for term.

**New exact result.** For the clique-union family $mK_c=\mathrm{SRG}(mc,\,c-1,\,c-2,\,0)$ the numerator factors as $(m-1)c(mc-1)(c-1)$, giving

> $$\frac{\lvert\theta\rvert}{\lVert W\rVert}\;=\;\frac1c\sqrt{\frac{2(mc-1)(c-1)}{m(m-1)}},\qquad\text{strictly increasing in }c,\quad\sup_c=\sqrt{\frac2{m-1}} .$$

At $m=2$ this returns $\Theta_{2c}$ exactly, the balanced sphere product. **At $m=3$ the supremum is exactly $1$**, and it decreases in $m$. So every clique-union point other than the sphere product sits below $1$, against a band floor of $\sqrt{3/2}=1.224745$.

**Screen** (exhaustive over feasible $(v,k,\lambda,\mu)$ (graph identity, eigenvalue-multiplicity integrality, conference case) for $v\le300$): the supremum of $\lvert\theta\rvert/\Theta_v$ over **non-sphere-product** parameter sets is $0.705919$, at $\mathrm{SRG}(300,99,98,0)=3K_{100}$; the largest absolute value is $0.993328$. The $3K_c$ family is the top row at every $v$ where it exists.

> **VERDICT: CONFIRMED, and the threat the brief was checking for does not exist.** No two-eigenvalue non-sphere-product diagonal critical point is even **inside the band**, let alone near $\Theta_n$. [Route R15](../routes.md)'s clearance criterion, *"a two-eigenvalue non-sphere-product critical point that saturates [Lemma L70](../findings/bounds.md) refutes [Lemma L71](../findings/bounds.md)"*, is empty by a margin of about $\sqrt2$ in $\theta$, not by a whisker.

**And the brief's own framing needs correcting.** "*If one has $\theta$ near $\Theta_n$ while being far from the balanced orbit, no deficit inequality with a positive constant can hold*" is false as stated: a point at $\theta=\Theta_n-\epsilon$ with $d=\Omega(1)$ caps $c_n$ at $\epsilon/d^2$, which is positive. Only $\theta=\Theta_n$ **exactly** at $d>0$ refutes positivity; a *family* over $n$ with $\epsilon_n\to0$ and $d_n$ bounded below refutes $n$-uniformity. That distinction is what the screen above actually rules out.

---

## 2. The $\mathcal D_n$ clause is NOT false off the band, the section refutes the wrong statement

**2b first, since the brief asks: the units are consistent.** *Screen.* Building $\mathcal L(N)=M\circ N+\tfrac12(MN+NM)$, hollowed, on hollow symmetric zero-row-sum $N$, and restricting to $M^\perp$ (the radial direction sits at $L_e$-eigenvalue $1$ exactly, by criticality), $\lambda_{\max}(\mathcal L)/\theta$ returns $\tfrac{Q-2}{2(Q-1)}$ with $Q=\max(p,q)$ at every sphere product in the table, $0.250000$ at $S^2\times S^3$, $0.333333$ at $S^2\times S^4$, $0.400000$ at $S^2\times S^6$ and at $S^6\times S^6$, $0.375000$ at $S^3\times S^5$ and $S^5\times S^5$. **The column is $\lambda_{\max}(L_e)$ throughout, against a threshold of $\tfrac12$. The brief's units worry is dismissed.**

**2a: both witnesses do sit below the band.** The $C_5$ blow-up is at $n=10$, blocks $(2,2,2,2,2)$, $\theta=0.670820393$ ([b_c5_blowup.py](../scripts/lib/b_c5_blowup.py)); the unpadded $n=9$ witness is at $\theta=0.641090782$ ([second-order.md:534](../findings/second-order.md)). Both below $\sqrt{3/2}$. **CONFIRMED.** *Though the $n=9$ point is also outside $n\ge12$, so it corroborates nothing a claim about $n\ge12$ needs, and citing it as a second independent witness overstates the base.*

**2: and now the defect.** The section opens by correctly restating the surviving clause as

$$\tfrac12\notin\operatorname{spec}\big(L_e|_{\mathcal D_n\cap M^\perp}\big),$$

then tabulates $\lambda_{\max}$ and concludes falsity from $1.206011>\tfrac12$. **That inference is invalid, and the record says so twice.** [Lemma L128](../findings/second-order.md)'s own Gate 2 box: *"A block **above** $\tfrac12$ is possible because the hypothesis is criticality, not maximality"*, with $S^2\times S^4$ pure, critical and Morse–Bott nondegenerate while its four-set blocks sit at $\tfrac23$. And [r391](REVIEW_r391.md), quoted two entries above this section: *"a Rayleigh range is an interval and may straddle $\tfrac12$ without containing it."*

**Screen, at the section's own headline witness.** The $C_5$ blow-up rebuilt from [b_c5_blowup.py](../scripts/lib/b_c5_blowup.py)'s entries (within-block $4$, adjacent $-2$, non-adjacent $+1$), normalised to $\operatorname{tr}M^2=2$; row sums $0$ exactly, off-diagonal criticality residual $1.4\times10^{-17}$, $\theta=0.670820393$. The $35$-dimensional $L_e$ spectrum on $\mathcal D_n$, radial direction removed:

$$\big\{-\tfrac23^{(5)},\ -0.471405^{(5)},\ -\tfrac13^{(5)},\ -0.206011^{(2)},\ 0^{(7)},\ 0.460655^{(2)},\ 0.471405^{(5)},\ 0.539345^{(2)},\ 1.206011^{(2)}\big\}$$

$\lambda_{\max}=1.206011$ reproduces the table exactly, **and $\tfrac12$ is absent**, the nearest eigenvalues being $0.460655$ and $0.539345$, each $0.0286$ away, and summing to $1.000000$.

> **VERDICT: REFUTED.** The witness **satisfies** the clause. What the table falsifies is the *box* (negative definiteness along $\mathcal D_n$) which Gate 2 had already withdrawn as the wrong encoding in the entry immediately above. The section is the same error committed a second time, on the same day, against the same two witnesses.
>
> **Downstream.** "*All three of [I18](../plan.md)'s clauses are band-dependent... this one is outright false off the band*" loses its third leg. The $\mathcal D_n$ clause has **no** counterexample, in band or out, and may well be provable without spending the band at all. *Whether $\tfrac12$ enters the $n=9$ witness's spectrum is untested here; the same gap applies, and rebuilding that point needs its vertex matrix.*

---

## 3. The cap $c_n\le3\Theta_n/(2(m-1))$, valid, and superseded by a better one the section never looks for

**The step is valid, and the brief's suspicion is misplaced.** [Lemma L24](../findings/second-order.md) gives $\mathrm{Hess}(P|_S)=6\theta(L_e-\tfrac12\mathrm{Id})$; the least-negative eigenvalue along $\mathcal D_n$ at the balanced product is $6\theta\big(\tfrac{m-2}{2(m-1)}-\tfrac12\big)=-3\theta/(m-1)$, so the value drop is $\tfrac12\lvert\lambda\rvert d^2+O(d^3)$ and a **global** inequality must survive $d\to0$, forcing $c_n\le\tfrac12\lvert\lambda\rvert=3\Theta_n/(2(m-1))$. **A second-order expansion at an extremiser legitimately caps a constant in a global inequality**, because the global statement must hold in a neighbourhood too.

**Two hypotheses it uses silently, both true, recorded because the argument fails without them.**

- **Transversality.** $P$ is $SO(n)$-invariant, so $T_W\mathcal O$ lies in the $L_e$-eigenspace at $\tfrac12$; the extremal direction sits at $\tfrac{m-2}{2(m-1)}<\tfrac12$ **strictly**, so it is an eigenvector for a different eigenvalue and is therefore orthogonal to the orbit tangent. Hence $d(M_{\text{bal}}+tX,\mathcal O)=t\lVert X\rVert+O(t^2)$ and the ratio is what the cap claims. *Had the extremal direction carried an orbit component, $d$ would be $o(t)$ and the cap would be vacuous.*
- **No remainder hazard.** $P$ is a homogeneous cubic, so the expansion terminates.

**But the cap is not the binding constraint, and the section stops one step short.** Any critical point $M^\ast$ caps $c_n\le\big(\Theta_n-\theta(M^\ast)\big)/d(M^\ast)^2$, and the record is full of critical points. *Screen*, at the $C_5$ blow-up ($n=10$), against the $S_n$-orbit of the balanced product: $\max_\sigma\langle M^\ast,\sigma M_{\text{bal}}\rangle=0.894427$, so $d_F^2=4-2(0.894427)=2.211146$ and

$$c_{10}\;\le\;\frac{1.2-0.670820}{2.211146}\;=\;0.239324,$$

**against the Hessian cap $3\Theta_{10}/8=0.45$, a factor $1.88$ tighter.** *Reported as a screen: it uses the $S_n$-orbit distance, and $d$ to the full $SO(n)$-orbit could be smaller, which would weaken it. The record does not say which orbit $d$ means, and it matters here.* The mechanism is general and mechanical: **every catalogued diagonal critical point supplies a cap, and the confinement radius is $\sqrt{\Theta_n-\sqrt{3/2}}$ over the smallest of them, not over the Hessian's.**

---

## 4. The numbers

| figure | check | verdict |
|---|---|---|
| $c_{12}\le3\Theta_{12}/10=0.370810$ | recomputed | CONFIRMED |
| $d\le0.175$ at $n=12$ | $d^2\le0.011288/0.370810=0.030442$, $d\le0.174476$ | **CONFIRMED** |
| diameter $2\sqrt2$ | $\lVert M\rVert_F=\sqrt2$, antipode $-M_{\text{bal}}\in\mathcal D_n$ | **CONFIRMED**, in the Frobenius norm |
| band $\to0.189$ | $\sqrt2-\sqrt{3/2}=0.1894687$ | CONFIRMED |
| vacuous near $n\approx180$ | crossing $d^2=8$ is at $n=190.8$; at $n=180$, $d\le2.7417$ against $2.8284$ | **CORRECTED** |

**Two defects in the presentation of the same display.**

**(a) The inequality chain is sign-reversed and asserts nothing.** The section prints
$$d^2\le\frac{\Theta_n-\sqrt{3/2}}{c_n}\ \ge\ \frac{2(m-1)(\Theta_n-\sqrt{3/2})}{3\Theta_n},$$
i.e. "$d^2\le X$ where $X\ge Y$", from which $d^2\le Y$ does **not** follow. The surrounding prose ("even a sharp deficit inequality confines only to") carries the right reading (the best case is the largest admissible $c_n$) so this is notation rather than mathematics, but the two signs point opposite ways on one line and a reader checking the display alone gets nothing.

**(b) A metric mismatch that would move every number by $\sqrt2$.** $d$ is quoted against a diameter of $2\sqrt2$, so it is Frobenius on $n\times n$; $c_n$ comes from $\mathrm{Hess}(P|_S)$ on the $\Lambda^2$ sphere $\lVert W\rVert=1$. The two norms differ by exactly the factor this record has been caught on repeatedly (*"the $\Lambda^2$ pairing is half of it"*), and [Route R16](../routes.md)'s own needs list still reads "**the Hessian-to-$L_e$ constant pinned**". If the constant carries the other convention, $c_n\le3\Theta_n/(4(m-1))$, $d\le0.2467$ at $n=12$, and the vacuity crossing drops to $n=101.2$. **The item should pin that constant before any of these figures is quoted again.**

**(c) And the diameter is the wrong yardstick for "vacuous".** $\mathcal D_{12}$ is a $54$-sphere; a cap of chord radius $0.955$ on a radius-$\sqrt2$ sphere at $n=32$ has measure $\sim e^{-210}$. Confinement stays overwhelmingly strong in measure long after it looks weak against the diameter. What genuinely fails at large $n$ is the *perturbation* requirement $Cd\lesssim\theta/(2(m-1))$, which [ATTEMPTS.md](../ATTEMPTS.md) already states correctly as closing like $m^{3/2}$, that is the honest death, and the diameter comparison adds nothing to it.

---

## 5. "All six routes spent the band only as a number", refuted from the record

**Two entries above the claim, the same file spends the band structurally.** [ATTEMPTS.md](../ATTEMPTS.md), *I18's four-set clause*: a four-supported $M$ is a padding of a $4\times4$ hollow zero-row-sum matrix, so [Lemma L57](../findings/problem.md) caps it at $\Theta_4=\sqrt{12}/4=0.866<\sqrt{3/2}$, and therefore **a pure critical point in the band cannot concentrate its mass on a four-set**. That converts $\theta\ge\sqrt{3/2}$ into a constraint on $M$'s *support* (structure, not a number) and it does so through L57's value on a sub-locus, which is precisely the machinery the final section says "no attempt has yet invoked."

Two further instances: [post F50](../findings/INDEX-traps.md)'s equality (*the maximal four-supported concentrator sits at exactly $\sqrt{3/2}$*), is the band constant appearing as a support threshold; and the $p=5$ analysis (*"the band's floor is $\min(p,q)\ge5$"*) turns the band into a constraint on factor sizes.

> **VERDICT: REFUTED as written.** The accurate residual claim, which is still worth stating, is narrower: **no attempt has invoked L57's *equality case*, the rigidity that the maximiser is the balanced product.** The band has been spent as structure through L57's *value*; what is untried is spending it through L57's *extremiser*.

---

## 6. Measure the deficit to what? The odd case is worse than recorded

**Result 3 above proves the balanced orbit is empty at odd $n$.** So $d=\operatorname{dist}(M,SO(n)\cdot M_{\text{bal}})$ is a distance to a set with no member in dimension $n$, and the deficit inequality as written is **ill-posed at odd $n$**, not merely uncovered. The base must be the unbalanced product $S^{(n-1)/2}\times S^{(n+1)/2}$, at which $\Theta_n$ is not attained.

**Screen, at four odd points.** $S^3\times S^4$, $S^4\times S^5$, $S^5\times S^6$, $S^6\times S^7$: $\theta$ matches $\sqrt{2(n-1)(n-3)/((n-2)(n+1))}$ to nine digits, and $\lambda_{\max}(L_e)=\tfrac{Q-2}{2(Q-1)}$ with $Q=\tfrac{n+1}2$, so

$$\text{margin}\;=\;\tfrac12-\lambda_{\max}\;=\;\frac1{2(Q-1)}\;=\;\frac1{n-1}\qquad(0.166667,\ 0.125,\ 0.1,\ 0.083333\ \text{at}\ n=7,9,11,13).$$

> **[ATTEMPTS.md](../ATTEMPTS.md)'s "whose margin is $1/(n-3)$" is wrong.** It is $1/(n-1)$. The error is substituting the odd half-dimension into the even formula $1/(2(m-1))$ instead of using $Q=\max(p,q)$; and it errs in the **unsafe** direction, the true margin being tighter than recorded.

**And the same line mislabels a value.** "*$\Theta_{13}=1.2484$, so the odd band is wider*" quotes $1.248376$, which is $\theta$ at $S^6\times S^7$; $\Theta_{13}=\theta_0(13)=1.249852$. The conclusion survives, measured against the attained maximum the odd band is $0.023631$ at $n=13$ against $0.011288$ at $n=12$, genuinely wider, but the symbol $\Theta_n$ is carrying two different objects in one sentence.

**The odd-$n$ cap, for the record.** $c_n\le3\theta_{\text{unbal}}(n)/(n-1)$, giving $c_{13}\le0.312094$ and $d\le0.2752$, looser confinement than $n=12$'s $0.1745$, on the wider band.

---

## One stale figure, sitting below its own correction

[ATTEMPTS.md](../ATTEMPTS.md)'s four-set section closes with *"the spectral cap $\tfrac12\operatorname{tr}M^3\le\sqrt2(n-2)/\sqrt{n(n-1)}$, $1.2309$ against $\theta_0(12)$, so $99.6\%$ of the target comes from the spectrum alone"*. That is the superseded cap over $n$ free eigenvalues. Its own Gate 2 box, **26 lines above**, corrects it: *"ignoring the forced zero eigenvalue: the correct figure is $1.213562$, a share of $98.18\%$."* Result 1 confirms the correction from the definitions, $\tfrac12T_{\max}=\sqrt2(n-3)/\sqrt{(n-1)(n-2)}=1.213562$ at $n=12$, with $1.236033=1.213562+0.022471$ and $0.022471=\tfrac12S_{\text{bal}}$ exactly. **The paragraph should be struck.**

---

## What the item should do next

1. **Strike the "false off the band" section** and restate: the $\mathcal D_n$ clause has no counterexample. Test $\tfrac12\in\operatorname{spec}$ at the $n=9$ witness before any claim about it is reinstated.
2. **Pin the Hessian-to-$L_e$ constant's norm convention** before quoting $c_n$, $0.175$ or $n\approx180$ again, a factor $2$ is live in all three.
3. **Cap $c_n$ from the global critical set, not only from the Hessian.** The $C_5$ blow-up alone beats the Hessian cap by $1.88\times$ at $n=10$; the catalogue will do better.
4. **State the item at even $n$**, and open the odd case separately with base $S^{(n-1)/2}\times S^{(n+1)/2}$, margin $1/(n-1)$.
5. **Record Result 5**: the quantitative L57 is $S-S_{\text{bal}}\le(1-\varepsilon)(T_{\max}-T)$, and L57 itself is the $\varepsilon=0$ endpoint. The item is asking to strengthen a proved theorem, which is a fair thing to ask and should be labelled as such.
