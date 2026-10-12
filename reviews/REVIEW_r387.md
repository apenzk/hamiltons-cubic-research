# Review r387, the separation attack, Gate 2

*Adversarial review of the last section of [ATTEMPTS.md](../ATTEMPTS.md), "The separation attack, opened". Analysis only; every line below is hand algebra from the definitions, with no run. Derived cold, then read against the record.*

## Verdict table

| Claim | Verdict |
| --- | --- |
| **1** Constraint 1, $\langle u\circ u,x\rangle=2M_{jk}\langle u,x\rangle$ | **Correct**, self-adjointness step clean. Derived independently below |
| **2** the codimension-two reading, empty "exactly when $u$ is constant on its support" | **REFUTED, and the error is the dangerous direction.** The emptiness set is larger, and emptiness is *equivalent to the clause failing* |
| **3** Constraint 2, the quadratic inequality | **Correct, every coefficient and every sign.** But it is **nearly always vacuous**, and I give the exact window in which it can bite |
| **4** Constraint 3, from the top eigenvector | **Correct, and stronger than claimed**: $\lambda_1$ simple is **not needed** and never was |
| **5** the framing ("one condition per known image, three on record") | **General principle correct; the counting is wrong.** The record supplies **$n-1$** such conditions, not three, and the three it names collapse to **two** at every sphere product |
| **6** survival under padding, and the reading of post F48's witness | **Conclusion right, both stated reasons wrong.** $T$ is **not** in $\operatorname{spec}(\widetilde N)$ at F48's witness. And the padded-pair clause is **exactly $\theta\notin\operatorname{spec}(M)$**, which the recorded gap does not give |

**Headline for the parent.** The separation clause does **not** fail at the padded pair, so the reframing survives, but not for the reason written. The section's two most consequential errors are in claims 2 and 5, and the correction to claim 2 turns Constraint 1 from "a condition that costs nothing" into a **dichotomy**: in band, at $n\ge5$, Constraint 1 is vacuous **if and only if** the clause is false. Separately I prove the clause **outright at every within-factor twin pair and every padded pair of every $S^p\times S^q$**, two independent ways.

---

## 0. Two facts the section uses without stating, one of which it double-counts

**Fact A, $\widetilde N\mathbf1=0$ at every pair, twin or not.** $(\widetilde N\mathbf1)_i=\sum_{l\in I}M_{il}+u_i+v_i=(0-M_{ij}-M_{ik})+u_i+v_i=0$, using $M\mathbf1=0$. *This is implicit in [Lemma L122](../findings/second-order.md) ($\widetilde N=-\Delta^{(jk)}$ is a graph Laplacian up to sign) but the section treats $x\perp\mathbf1$ as one of two conditions it imposes.*

**Fact B, $T\ne0$ at a twin pair.** $T=0$ forces $M_{jk}=-\theta$, and the twin relation $M_{jk}^2-\theta M_{jk}+\lVert u\rVert^2=0$ then reads $2\theta^2+\lVert u\rVert^2=0$. Impossible for $\theta>0$.

**Consequence.** By A and B, **every $T$-eigenvector is automatically $\perp\mathbf1$**: $T\langle x,\mathbf1\rangle=\langle\widetilde Nx,\mathbf1\rangle=\langle x,\widetilde N\mathbf1\rangle=0$. So "$\mathbf1^\perp$" is not a condition the argument gets to spend; the codimension-two claim of claim 2 counts a free condition as one of its two.

---

## 1. Constraint 1, verified

Re-derived from the definitions. For $i\in I$,
$$(Nu)_i=\sum_{l\in I}M_{il}M_{lj}=(M^2)_{ij}-M_{ij}M_{jj}-M_{ik}M_{kj}=(M^2)_{ij}-v_iM_{jk},$$
and diagonal criticality at $(i,j)$, $i\ne j$, gives $(M^2)_{ij}=\theta u_i-u_i^2$. At a twin ($v=u$),
$$(Nu)_i=(\theta-M_{jk})u_i-u_i^2,\qquad (\widetilde Nu)_i=(Nu)_i+2u_i^2=(\theta-M_{jk})u_i+u_i^2 .$$
So $\widetilde Nu=(\theta-M_{jk})u+u\circ u$, as recorded. Pairing against a $T$-eigenvector $x$: $\widetilde N=N+\operatorname{diag}(u+v)$ is real symmetric ($N$ symmetric, the correction diagonal), so $\langle\widetilde Nu,x\rangle=\langle u,\widetilde Nx\rangle=T\langle u,x\rangle$ with **no side condition whatever**. Then
$$\langle u\circ u,x\rangle=(T-\theta+M_{jk})\langle u,x\rangle=2M_{jk}\langle u,x\rangle .\qquad\checkmark$$

**The self-adjointness step is sound.** Hypotheses actually used: $u=v$, criticality at $(i,j)$ for $i\in I$, and $\widetilde N$ symmetric. Nothing else.

---

## 2. The codimension-two reading, REFUTED, and the correction inverts its meaning

Write $\mu=M_{jk}$, $d=n-2=\lvert I\rvert$, and $r_u:=(\widetilde N-T)u=u\circ u-2\mu u$.

### 2a. When is Constraint 1 empty? Not when the section says

Constraint 1 is vacuous relative to $x\perp\mathbf1$ exactly when $r_u\in\operatorname{span}(\mathbf1)$, i.e. $u_i^2-2\mu u_i=c$ for all $i\in I$ and some scalar $c$. Every $u_i$ is then a root of $t^2-2\mu t-c$, so:

> **$u$ takes at most two values on $I$, and if it takes two distinct values $r_\pm$ they satisfy $r_++r_-=2\mu$.**

The section's characterisation, "$u$ is constant on its support", is the sub-case $c=0$. **That sub-case is not merely incomplete, given $M\mathbf1=0$ it is empty of content**: row $j$ of $M\mathbf1=0$ gives $\langle u,\mathbf1\rangle=-\mu$, so if $u_i\in\{0,2\mu\}$ on a support of size $s$ then $2\mu s=-\mu$, forcing $\mu=0$ and hence $u=0$. **The named exception *is* the padded pair, and nothing else.**

The genuinely non-trivial degeneracy is the two-value one, and the record's own twin relations do **not** exclude it. Setting $r_\pm=\mu\pm\delta$ on sets of sizes $a,b$ with $a+b=d$:
$$(d+1)\mu=-(a-b)\delta,\qquad d\,\delta^2=\theta\mu+(d+1)\mu^2 ,$$
from $\langle u,\mathbf1\rangle=-\mu$ and $\lVert u\rVert^2=\theta\mu-\mu^2$. Two equations, three free parameters $(\mu,\delta,a)$; consistent for any $\mu>0$. *Whether a full critical point carries such a pair is open, but it is not closed by anything the section cites.*

### 2b. Emptiness is not benign: it **is** the counterexample

This is the finding that matters. Suppose $r_u=c\mathbf1$. Then $\widetilde Nu=Tu+c\mathbf1$, and since $\widetilde N\mathbf1=0$ and $T\ne0$, put
$$y:=u+\tfrac cT\mathbf1\ \Longrightarrow\ \widetilde Ny=\widetilde Nu=Tu+c\mathbf1=Ty .$$
So **$y$ is a $T$-eigenvector**, automatically $\perp\mathbf1$ by Fact A, and $y\ne0$ unless $u\in\operatorname{span}(\mathbf1)$.

*Consistency check that the algebra is right:* in the two-value case $c=\delta^2-\mu^2$, and $\langle y,\mathbf1\rangle=-\mu+cd/T$ must vanish. Indeed $cd=d\delta^2-d\mu^2=\theta\mu+(d+1)\mu^2-d\mu^2=\mu(\theta+\mu)=\mu T$. It vanishes identically, the two twin relations conspire exactly as Fact A demands.

The escape $u\in\operatorname{span}(\mathbf1)$ is either $u=0$ (padded) or, solving $\lVert u\rVert^2=\theta\mu-\mu^2$ with $u=-\tfrac\mu d\mathbf1$, the single point $\mu=\tfrac{\theta d}{d+1}$. That one is killed by the Frobenius budget: $s_j=s_k=\theta\mu=\tfrac{\theta^2d}{d+1}$ ([diagonal-half.md](../findings/diagonal-half.md), $s_a=\lVert M_a\rVert^2$, equality in $2\theta M_{ab}\le s_a+s_b$ exactly at twins), and $s_j+s_k\le\sum_as_a=\lVert M\rVert_F^2=2$ gives $\theta^2\le1+\tfrac1{n-2}$, below $3/2$ for every $n\ge5$.

> **Corollary (the correct reading of Constraint 1).** *At a twin pair with $u\ne0$, in band, $n\ge5$:*
> $$\text{Constraint 1 is vacuous}\iff\text{the separation clause FAILS at that pair.}$$

So the section has it backwards in the most costly way. It reports emptiness as a harmless boundary case ("correctly saying nothing"); emptiness is the *only* way the constraint can be reported, and it announces a counterexample. **Conversely, Constraint 1 being non-vacuous is a genuine (and necessary), one-dimensional cut.** "Codimension two" is literally true when it holds, but one of the two codimensions is free (Fact A), so Constraint 1 buys **one** condition, not two.

---

## 3. Constraint 2, the expansion recomputed line by line, and it is right

Extend $x$ by zeros at $j,k$ to $X\in\mathbb R^n$. Then $\widetilde Nx=Nx+2\,u\circ x=Tx$ gives $Nx=Tx-2\,u\circ x$. ✓

**The two pieces.** $(MX)_i=(Nx)_i$ for $i\in I$; $(MX)_j=\langle u,x\rangle=c$; $(MX)_k=\langle v,x\rangle=c$ at a twin. So $\lVert MX\rVert^2=\lVert Nx\rVert^2+2c^2$ ✓, and $X^\top MX=x^\top Nx$ ✓ since $X$ vanishes at $j,k$.

**The substitution.** With $\lVert x\rVert=1$, $S_1=\sum u_ix_i^2$, $S_2=\sum u_i^2x_i^2$:
$$\lVert Nx\rVert^2=T^2-4TS_1+4S_2,\qquad x^\top Nx=T-2S_1 .$$
The gap $M^2-\theta M\succeq0$ (which is $\operatorname{spec}(M)\subseteq(-\infty,0]\cup[\theta,\infty)$) gives $\lVert MX\rVert^2\ge\theta X^\top MX$, i.e.
$$T^2-4TS_1+4S_2+2c^2-\theta T+2\theta S_1\ \ge\ 0 .$$
Now $T^2-\theta T=T(T-\theta)=TM_{jk}$ and $-4T+2\theta=-2\theta-4M_{jk}$, so
$$\boxed{\,TM_{jk}-(2\theta+4M_{jk})S_1+4S_2+2c^2\ \ge\ 0\,}$$
**exactly as printed.** Every coefficient and the sign check out.

### 3a. But it is a weak instrument, and here is exactly how weak

Two free simplifications the section did not take. First $TM_{jk}=\theta\mu+\mu^2=2\theta\mu-\lVert u\rVert^2$ by the twin relation. Second (and this is the point), the whole left-hand side **factors** once $S_2$ is split into its mean and variance parts. Writing $\operatorname{Var}=S_2-S_1^2\ge0$ (Cauchy–Schwarz under the probability weights $x_i^2$):
$$\text{LHS}=4\big(S_1-\tfrac T2\big)\big(S_1-\tfrac\mu2\big)+4\operatorname{Var}+2c^2 .$$
*Check of the factorisation:* $4S_1^2-2(T+\mu)S_1+T\mu$ has $2(T+\mu)=2\theta+4\mu$ ✓ and constant term $T\mu$ ✓; the discriminant is $4\theta^2$, roots $T/2$ and $\mu/2$.

**Consequences, all adverse to the section's hopes.**

- Constraint 2 has **no content at all** unless $S_1$ lies strictly between $\mu/2$ and $T/2$, an interval of length $\theta/2$ in a quantity whose range is the spread of $u$.
- The most negative the first term can ever be is $-\tfrac{(T-\mu)^2}4=-\tfrac{\theta^2}4$, at $S_1=\tfrac{T+\mu}4$. So Constraint 2 is violated **only if** $4\operatorname{Var}_{x^2}(u)+2c^2<\theta^2/4$, with $\theta^2/4\approx0.38$ in band, this demands the $x^2$-weighted variance of $u$ be under $\approx0.095$ *and* $\langle u,x\rangle$ nearly zero simultaneously.
- It is one scalar inequality against a hypothetical eigenvector in $\mathbb R^{n-2}$. **It is not a route on its own** and it does not combine with Constraint 1 the way the section's "first moment against a second moment" gloss suggests: Constraint 1 pins $\langle u\circ u-2\mu u,x\rangle$, which is a *linear* functional of $x$, while $S_1,S_2$ are quadratic. No cancellation is available between them.

*The factored form is worth keeping in the record regardless, it is the sharpest statement of what the gap inequality buys at a twin pair.*

---

## 4. Constraint 3, correct, and simplicity is not needed

For $i\in I$, $\lambda_1w_i=(Mw)_i=(N\Pi w)_i+u_iw_j+v_iw_k$, so at a twin with $w_j=w_k=w_0$:
$$N\Pi w=\lambda_1\Pi w-2w_0u,\qquad \widetilde N\Pi w=\lambda_1\Pi w-2w_0u+2\,u\circ\Pi w,$$
and pairing against $x$ gives the printed
$$(\lambda_1-T)\langle\Pi w,x\rangle-2w_0\langle u,x\rangle+2\langle u\circ\Pi w,x\rangle=0 .\qquad\checkmark$$

**Is $\lambda_1$ simple needed? No.** Let $P$ be the transposition $(jk)$. At a twin pair $u=v$, so $(PMP)_{ab}=M_{\sigma(a)\sigma(b)}=M_{ab}$: $M$ **commutes with $P$**. Every $M$-eigenspace is therefore $P$-invariant, hence splits into its $P$-eigenparts, and $P$'s $(-1)$-eigenspace is the line $\operatorname{span}(e_j-e_k)$. So a top eigenvector fails $w_j=w_k$ only if $e_j-e_k$ is itself a $\lambda_1$-eigenvector. But $M(e_j-e_k)=-M_{jk}(e_j-e_k)$ **always**, at a twin pair (the $I$-components are $u_i-v_i=0$), so that would need $\lambda_1=-\mu$, and then the twin relation reads $\lambda_1^2+\theta\lambda_1+\lVert u\rVert^2=0$, impossible for $\lambda_1,\theta>0$.

> **Every top eigenvector of $M$ satisfies $w_j=w_k$ at a twin pair. The simplicity hypothesis in the setup is free to delete.**

*Bonus from the same argument:* $e_j-e_k$ is an eigenvector of $M$ at $-M_{jk}$ at every twin pair, so $-M_{jk}\in\operatorname{spec}(M)$ there. Combined with the gap, $-M_{jk}\le0$ or $\ge\theta$; the latter with the twin relation is impossible, so **$M_{jk}\ge0$ at every twin pair**. I do not find this on record; it is one line and it rules out negative-entry twins outright.

**Same dichotomy as Constraint 1.** $(\widetilde N-T)\Pi w\in\operatorname{span}(\mathbf1)$ would give the $T$-eigenvector $\Pi w+\tfrac cT\mathbf1$, nonzero unless $\Pi w\in\operatorname{span}(\mathbf1)$. Constraint 3 is vacuous only when the clause fails or $w$ is constant on $I$.

---

## 5. The framing, principle right, counting wrong, and the count is off by $n-4$

**The general principle is stated correctly.** For symmetric $A=\widetilde N-T$, $\ker A=(\operatorname{ran}A)^\perp$, so every $y$ with a known image contributes $\langle Ay,x\rangle=0$. ✓

**But the record does not supply three such $y$. It supplies $n-1$, all of them explicit.** Section 4's symmetry argument applies to *every* eigenvector: pick an $M$-eigenbasis adapted to $P$; the $(-1)$-part is $e_j-e_k$ alone, so the remaining $n-1$ basis vectors $z^{(1)},\dots,z^{(n-1)}$ all satisfy $z_j=z_k$, and for each
$$(\widetilde N-T)\Pi z^{(a)}=(\lambda_a-T)\Pi z^{(a)}-2z^{(a)}_j\,u+2\,u\circ\Pi z^{(a)} .$$
Nothing here is unknown: $u\circ\Pi z$ is an entrywise product of two known vectors. $\mathbf1$, $u$ and $\Pi w$ are three members of a family of $n-1$, and $\Pi$ maps the $P$-fixed space ($\dim n-1$) **onto** $\mathbb R^I$ ($\dim n-2$), so the family's images span $\operatorname{ran}(\widetilde N-T)$ exactly.

**So the honest statement of the mechanism is an equivalence, not a chain:**

> The separation clause holds at a twin pair **iff** the $n-1$ explicit vectors $(\lambda_a-T)\Pi z^{(a)}-2z^{(a)}_ju+2u\circ\Pi z^{(a)}$ span $\mathbb R^{n-2}$.

**Are the section's three independent? No, at every sphere product they are two, one of which is free.** At $S^p\times S^q$ with $j,k$ in the same factor (see §6 for the closed forms), $u$ is constant on each of $F_1\setminus\{j,k\}$ and $F_2$, and so are $\Pi w$ and $u\circ\Pi w$. Hence $\mathbf1$, $r_u$ and $r_w$ all lie in the **two**-dimensional space of two-block-constant vectors. $r_w\in\operatorname{span}\{\mathbf1,r_u\}$ identically. Since the $\mathbf1$ condition is free (Fact A), **Constraints 1 and 3 together are one condition on $x$ at the record's only worked family.** The claim that the record supplies three is refuted at the only point where it can be tested.

**And "closing the chain needs one relation that terminates it" mis-locates the obstruction twice.**

- *Constraint 1 is a consequence of the Constraint-3 family, not an addition to it.* Since $\{\Pi z^{(a)}\}$ spans $\mathbb R^I$, $u=\sum c_a\Pi z^{(a)}$ and $(\widetilde N-T)u=\sum c_a(\widetilde N-T)\Pi z^{(a)}$.
- *The $\circ$-power chain does open a new unknown at every step, and the unknown has a name.* Computing $\widetilde N(u\circ u)$ from criticality:
$$\big(N(u\circ u)\big)_i=\theta(Nu)_i-(M^3)_{ij}+u_i\big(2\theta M_{jk}-M_{jk}^2\big),$$
using $M_{lj}^2=\theta M_{lj}-(M^2)_{lj}$, then $(M^2)_{jj}=s_j=\theta M_{jk}$ and $(M^2)_{kj}=\lVert u\rVert^2=\theta M_{jk}-M_{jk}^2$. **The whole obstruction is the single quantity $(M^3)_{ij}$**, a third-moment object that the criticality relations, which are second-order in $M$, do not reach. The section is right that the chain is obstructed; the obstruction is one named entry, and it is the same third moment the plan already records as what a successor needs.
- *Counting never closes by itself for large $n$.* The conditions are all consequences of the hypothesis $\widetilde Nx=Tx$, so they are automatically consistent, they can only kill $x$ by **spanning**, which needs $n-2$ of them. Three, or two, is not short of the target by a constant; it is short by $n-4$.

---

## 6. Padding, the conclusion survives, both stated reasons do not

### 6a. The mechanical claim: correct

At a padded pair $u=v=0$, $M_{jk}=0$, $T=\theta$, $\widetilde N=N$. Constraint 1 reads $0=0$ ✓. Constraint 2 reads $0\ge0$ ✓, also vacuous, the section does not say so. Constraint 3 is **not** vacuous: row $j$ of $Mw=\lambda_1w$ is $0=\lambda_1w_j$, so $w_0=0$ and Constraint 3 becomes $(\lambda_1-T)\langle\Pi w,x\rangle=0$, i.e. $x\perp w$ whenever $\lambda_1>\theta$. Correct, and consistent with §2b (emptiness of Constraint 1 is harmless here precisely because $u=0\in\operatorname{span}(\mathbf1)$, the one exception).

### 6b. "$T$ genuinely in the spectrum of $\widetilde N$ but not with an eigenvector violating the clause", FALSE, twice

**First, the sentence is incoherent as a possibility.** At a twin pair $o=0$, so "off the orbit direction" is vacuous, and by Fact A **any** $T$-eigenvector is $\perp\mathbf1$. So $T\in\operatorname{spec}(\widetilde N)$ at a twin pair violates the clause, full stop. The escape hatch the sentence imagines does not exist.

**Second, $T$ is not in the spectrum at F48's witness.** Compute it. At $S^p\times S^q$, write $-g<0$ for the cross entry, $\alpha_1,\alpha_2>0$ for the within-factor entries. Ricci-flatness gives $\alpha_1=\tfrac{gq}{p-1}$, $\alpha_2=\tfrac{gp}{q-1}$; criticality on a within-$F_1$ pair gives $(p-1)\alpha_1^2+qg^2=\theta\alpha_1$, i.e.
$$\theta=g(n-1),\qquad \lambda_1=\alpha_1(p-1)+\alpha_2(q-1)=gn,$$
$$\operatorname{spec}(M)=\{\,0,\ gn,\ -\alpha_1^{\,(p-1)},\ -\alpha_2^{\,(q-1)}\,\}.$$
*Cross-check against the record:* [Lemma L127](../findings/second-order.md)'s cross-factor row gives $\theta=(n-1)\lvert\gamma\rvert$, the same identity, independently.

At F48's witness, $\widetilde N=M'$ is the unpadded $S^6\times S^6$ matrix and $T=\theta=11g$; the spectrum is $\{0,12g,-\tfrac65g^{(10)}\}$. **$T\notin\operatorname{spec}(\widetilde N)$.** What F48 established was $\lambda_{\max}(\widetilde N)\ge T$, strictly, a refutation of the *inequality*, saying nothing about membership.

*(Numerical anchor, from the closed forms: $g=\lvert\gamma\rvert=\sqrt{5/396}=0.1123666$, $\theta=1.236033$, $\lambda_1=1.348399$, $T$ at a within-factor pair $=1.370873$, the section's own $1.37086$.)*

### 6c. The claim padding actually costs, and the section does not name it

At a padded pair $\widetilde N=M$ with the two zero rows deleted, so $\operatorname{spec}(M)=\operatorname{spec}(\widetilde N)\cup\{0,0\}$ and $T=\theta$. Therefore:

> **At every padded pair, the separation clause is exactly the statement $\theta\notin\operatorname{spec}(M)$.**

The recorded gap $\operatorname{spec}(M)\cap(0,\theta)=\varnothing$ is an **open** interval and permits $\theta\in\operatorname{spec}(M)$. So padding does not leave the clause "correctly saying nothing"; it converts a pair statement into a **global spectral statement about the whole critical point**, which the record has not proved and which is strictly harder than anything in the section. *Any pure critical point in band with $\theta$ as an eigenvalue of $M$ refutes [I18](../plan.md)'s pair clause.* This is the live falsifier the section should have named.

### 6d. What I can settle by hand: the clause holds on the whole catalogued family

Two independent derivations, both exact.

**(i) Direct spectrum.** At $S^p\times S^q$, $j,k$ in the same factor $F_1$: $I=F_1'\sqcup F_2$ with $\lvert F_1'\rvert=p-2$, $\mu=\alpha_1$, and $\widetilde N=N+2\operatorname{diag}(u)$ is
$$\alpha_1J_{p-2}+\alpha_1I\ \text{ on }F_1',\qquad \alpha_2J_q-(\alpha_2+2g)I\ \text{ on }F_2,\qquad -gJ\ \text{across.}$$
Its spectrum is $\{\,0,\ g(n-2),\ \alpha_1^{\,(p-3)},\ (-\alpha_2-2g)^{\,(q-1)}\,\}$, the two-block part being $\begin{psmallmatrix}gq&-gq\\-g(p-2)&g(p-2)\end{psmallmatrix}$, of determinant zero (that zero is Fact A) and trace $g(n-2)$. Against $T=\theta+\alpha_1=g\big[(n-1)+\tfrac q{p-1}\big]$: $T=g(n-2)$ needs $\tfrac q{p-1}=-1$; $T=\alpha_1$ needs $n=1$; the other two are $\le0$. **$T\notin\operatorname{spec}(\widetilde N)$ at every within-factor twin pair of every $S^p\times S^q$.**

*(Sanity at $S^6\times S^6$: $\lambda_{\max}(\widetilde N)=10g=1.123666$ against $T=1.370873$, consistent with the section's own trace-bound table.)*

**(ii) The record's own mechanism, extended past the top eigenvector, and it closes.** Run §5's family. The $-\alpha_2$ eigenvectors (zero-sum on $F_2$, all with $z_j=z_k=0$) give $(\widetilde N-T)\Pi z=(-\alpha_2-2g-T)\Pi z$, a nonzero multiple, so $x\perp$ zero-sum$(F_2)$: $q-1$ conditions. The $-\alpha_1$ eigenvectors with $z_j=z_k=0$ give $(\widetilde N-T)\Pi z=(\mu-T)\Pi z=-\theta\,\Pi z$, so $x\perp$ zero-sum$(F_1')$: $p-3$ conditions. So $x$ is two-block constant. Two more independent conditions from that block, $r_w$ and the $-\alpha_1$ eigenvector with $z_j\ne0$; at $m=6$, $g=1$ they are $(-0.2,\,4.2)$ and $(3.1,\,2)$, determinant $-13.42\ne0$, force $x=0$. Total $1+1+(p-3)+1+(q-1)=n-1$ conditions spanning all $n-2$ dimensions. **The clause is proved, by the section's own instrument.**

> **The mechanism was never three conditions short of closing; it was $n-4$ short, and the missing $n-4$ were sitting in the rest of $\operatorname{spec}(M)$, free.**

**(iii) Padded pairs of sphere products.** $\theta=g(n-1)\notin\{0,gn,-\alpha_1,-\alpha_2\}$, so by 6c the clause holds at every padded pair of every $S^p\times S^q$. **F48's witness satisfies the separation clause.** The reframing survives; the section's account of *why* does not.

---

## What to do with this

1. **Rewrite the codimension-two paragraph.** The emptiness set is $u\circ u-2M_{jk}u\in\operatorname{span}(\mathbf1)$, i.e. $u$ two-valued with values summing to $2M_{jk}$; and in band at $n\ge5$ emptiness **is** failure of the clause. §2b is the statement to record.
2. **Delete the $\lambda_1$-simplicity hypothesis** from the setup, by §4's $P$-symmetry argument; record $M_{jk}\ge0$ at every twin pair as its by-product.
3. **Replace "three conditions" with the $n-1$-vector family** of §5, and state the mechanism as the spanning equivalence rather than as a chain. Record that $(M^3)_{ij}$ is the sole obstruction to the $\circ$-power step.
4. **Record §6c**: at padded pairs the clause is $\theta\notin\operatorname{spec}(M)$, unproved in general, proved here for every $S^p\times S^q$. It is the item's cleanest falsifier target.
5. **Record §6d(ii)**: the clause is proved at every within-factor twin pair and every padded pair of every $S^p\times S^q$, all $p,q$, the first positive result on the twin half.
6. **Keep Constraint 2, with the factored form** $4(S_1-\tfrac T2)(S_1-\tfrac\mu2)+4\operatorname{Var}_{x^2}(u)+2c^2\ge0$, and the honest note that it can bite only when $4\operatorname{Var}+2c^2<\theta^2/4$.

**Blocked on computation, stated and stopped as the rule requires.** Deciding whether a non-sphere-product pure critical point in band has $\theta\in\operatorname{spec}(M)$, or carries a two-valued twin $u$ with $r_++r_-=2M_{jk}$, needs a run over the DGK/SRG points that [I18](../plan.md)(a) has not yet pinned. A positive hit on either refutes the pair clause outright; a clean sweep leaves both open but raises the cost of the counterexample. **I have not run it.** Everything above is closed-form algebra in $p,q,g$.
