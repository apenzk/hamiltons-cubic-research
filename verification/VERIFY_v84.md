# VERIFY v84, where branch 2 is minimised over $w\in[0,1]$ at $n=12$

*Adjudication of the disagreement between the kink reading and the interior reading of [Lemma L158](../findings/second-order.md)'s branch 2. **No numerical work was done: every value below is an exact hand evaluation from closed forms, and every decimal is a truncation of one.** Log: [agent_logs/verify-kink-v84.log](../agent_logs/verify-kink-v84.log).*

**POSITION A.** The minimum of branch 2 over $w\in[0,1]$ at $n=12$ is at the homogeneity kink $w_0=\tfrac23$, and it is a strict kink minimum: the left log-derivative is $-0.2405$ and the right is $+0.3595$. Position B's $+0.0943$ is a **left** log-derivative, of a different objective. It is $\tfrac{N'}N-\tfrac{\phi'}\phi$ at $w_0$, which is branch 2 **with $K$ held constant in $w$**; the exact identity $0.6943408-\tfrac35=0.0943408$ fixes the provenance beyond doubt. The two positions measure different functions, and the one the record and the brief both state carries $K(w)$.

## The constants, all exact, at $n=12$ ($m=6$)

| quantity | closed form | value |
|---|---|---|
| $\theta_0$ | $\sqrt{2(n-1)(n-2)}/n=\sqrt{55}/6$ | $1.23603308$ |
| $c_p$ | $3\theta_0/(n-2)=\sqrt{55}/20$ | $0.37080992$ |
| $\kappa=nc_p$ | $3\sqrt{55}/5$ | $4.4497191$ |
| $\rho:=\rho^{\text{eff}}_{12}$ | $\sqrt6-\tfrac7{30}\sqrt{55}$ | $0.71904343$ |
| $a_0n^{-1/2}$ | $\sqrt{2/(n-2)}=1/\sqrt5$ | $0.44721360$ |
| $\lvert\kappa_{12}\rvert$ | $9(\theta_0-\sqrt{3/2})=\tfrac32\sqrt{55}-9\sqrt{3/2}$ | $0.10159389$ |
| $\lambda$ | $2/\sqrt{\lvert\kappa_{12}\rvert}$ | $6.2747660$ |
| $C$ | $(4+2D)/D$ at $D=\tfrac{11}5$, i.e. $\tfrac{42}{11}$ | $3.8181818$ |
| $\beta=\lambda/(2C)$ | $11\lambda/84$ | $0.82169480$ |

Write $N(w)=\sqrt{c_p+\rho w^2}$, $\phi(w)=\min\big(\tfrac1{\sqrt5}\sqrt{1-w^2}+w,\ 1\big)$, $t(w)=\beta N(w)$, $q(w)=\sqrt{1+4t(w)}$. Then $1-\eta^*=2/(q+1)$, so $K=\lambda(1-\eta^*)^2/(\sqrt2J)=\tfrac{4\lambda}{\sqrt2J(q+1)^2}$, and branch $2=\tfrac{\lambda}{\sqrt2Jn}\cdot\tfrac{G(w)}{\phi(w)}$ with $G=4N/(q+1)^2$. The brief's $s=\sqrt{1+4t}$ is this $q$.

**Two independent checks that this constant chain is the record's own.** $G(w_0)=4N(w_0)/(q(w_0)+1)^2=3.3235760/8.5941327=0.3867242$, which is the entry's printed $0.38673$. And $T=\kappa\sqrt2J/(\lambda G(w_0))=4.4497191\times9.8176494/2.4266332=18.003$, which is the entry's printed $18.00$ at $J=J^*=6.9421$. *This also settles that the $s_\rho(w_0)$ inside $T$ is $N(w_0)$, a third meaning of the letter $s$ in the entry, see §4.*

## 1. The two one-sided log-derivatives at $w_0=\tfrac23$, and which side each is

**The elasticity, derived from scratch.** $\log G=\log4+\log N-2\log(q+1)$ and $q^2=4\beta N+1$ gives $q\,\mathrm dq=2\beta\,\mathrm dN$, so

$$\frac{\mathrm d\log G}{\mathrm d\log N}=1-\frac{2N}{q+1}\cdot\frac{2\beta}{q}=1-\frac{q^2-1}{q(q+1)}=1-\frac{q-1}q=\frac1q .$$

This reproduces the entry's $\mathrm d\log(K\sqrt{c_p+\rho w^2})/\mathrm d\log s=1/\sqrt{4t+1}$, and it is the whole of the disagreement: the factor $1/q$ damps the numerator's rise. Hence, everywhere on $[0,1]$,

$$\frac{\mathrm d\log(\text{branch }2)}{\mathrm dw}=\frac1q\frac{N'}N-\frac{\phi'}\phi .$$

**The numerator term at $w_0$.** $N'/N=\rho w/(c_p+\rho w^2)$, so at $w=\tfrac23$

$$\frac{N'}N(w_0)=\frac{\tfrac23\rho}{c_p+\tfrac49\rho}=\frac{6\rho}{9c_p+4\rho}=\frac{360\sqrt6-84\sqrt{55}}{240\sqrt6-29\sqrt{55}}=\frac{4.3142606}{6.2134630}=0.6943408 .$$

$N(w_0)^2=0.37080992+0.31957486=0.69038478$, so $N(w_0)=0.83089397$; $t(w_0)=\beta N(w_0)=0.68274128$; $q(w_0)=\sqrt{3.73096512}=1.9315706$. Therefore

$$\frac1q\frac{N'}N\bigg|_{w_0}=\frac{0.6943408}{1.9315706}=0.3594694 .$$

**Right side, $w\to w_0^+$.** There $\phi\equiv1$ and $\phi'=0$, so the derivative is the numerator term alone:

$$\boxed{\ \frac{\mathrm d\log(\text{branch }2)}{\mathrm dw}\bigg|_{w_0^+}=+0.3594694\ }\qquad\textbf{(right)}$$

**Left side, $w\to w_0^-$.** There $\phi(w_0)=1$ and $\phi'(w_0^-)=\tfrac35$ (§3), so

$$\boxed{\ \frac{\mathrm d\log(\text{branch }2)}{\mathrm dw}\bigg|_{w_0^-}=0.3594694-0.6=-0.2405306\ }\qquad\textbf{(left)}$$

Negative on the left, positive on the right: **a strict kink minimum**, exactly the shape Position A asserts. Neither number is $+0.0943$ on either side.

## 2. The AM–GM step: correct, $0.4019$ is its value, and it is uniform

**The inequality.** For $w\ge0$, AM–GM gives $c_p+\rho w^2\ge2\sqrt{c_p\rho}\,w$, whence

$$\frac{N'}N=\frac{\rho w}{c_p+\rho w^2}\le\frac{\rho w}{2\sqrt{c_p\rho}\,w}=\frac{\sqrt\rho}{2\sqrt{c_p}},$$

with equality exactly at $w=\sqrt{c_p/\rho}$. Multiplying by $1/q\le1/s_{\min}$, where $s_{\min}=\min q$, gives the entry's $\tfrac1q\tfrac{N'}N\le\tfrac{\sqrt\rho}{2\sqrt{c_p}\,s_{\min}}$. **The step is correct.**

**Its value.** $\rho/c_p=0.71904343/0.37080992=1.9391230$, so $\tfrac{\sqrt\rho}{2\sqrt{c_p}}=\tfrac12\sqrt{1.9391230}=\tfrac12(1.3925239)=0.6962620$. Since $N$ increases in $w$, so does $q$, and $s_{\min}=q(0)=\sqrt{1+4\beta\sqrt{c_p}}$: $\sqrt{c_p}=0.60894164$, $t(0)=0.50035836$, $s_{\min}=\sqrt{3.00143344}=1.7324647$. Hence

$$\frac{\sqrt\rho}{2\sqrt{c_p}\,s_{\min}}=\frac{0.6962620}{1.7324647}=0.4018908 .$$

**$0.4019$ is right to four figures.** It holds not merely on $[0,w_0]$ but on all of $[0,1]$, both factors being bounded there by the same argument. *It is loose on $[0,w_0]$: the AM–GM equality point $w=\sqrt{c_p/\rho}=0.7181$ lies **above** $w_0$, so on $[0,w_0]$ the true supremum is the endpoint value $0.3594694$ of §1, a factor $1.12$ of slack, which the conclusion does not need.*

**One step the entry uses and does not state.** The entry compares the bound against $\phi'(w_0)=\tfrac35$, a value at a single point, but the conclusion "strictly decreasing on $[0,w_0)$" needs $\phi'/\phi\ge\tfrac35$ throughout. That holds, $\phi_-'(w)=1-\tfrac w{\sqrt5\sqrt{1-w^2}}$ is decreasing, and $\phi_-$ is increasing on $[0,w_0]$ (its derivative is positive for $w^2<\tfrac56$) so $\phi_-\le1$ there, giving $\phi_-'/\phi_-\ge\phi_-'(w_0)/1=\tfrac35$, but **the entry does not say it**, and recording it is the entry's to do. I flag it as an unstated step rather than a defect: the conclusion stands.

## 3. $\phi'(w_0)$ from scratch, and its closed form in $n$

With $\phi_-(w)=b\sqrt{1-w^2}+w$ and $b=a_0n^{-1/2}=\sqrt{2/(n-2)}$, $\phi_-'(w)=1-\dfrac{bw}{\sqrt{1-w^2}}$. At $w_0=(n-4)/n$,

$$1-w_0^2=\Big(\frac4n\Big)\Big(\frac{2n-4}n\Big)=\frac{8(n-2)}{n^2},\qquad\sqrt{1-w_0^2}=\frac{2\sqrt{2(n-2)}}n,$$

so $\dfrac{bw_0}{\sqrt{1-w_0^2}}=\sqrt{\dfrac2{n-2}}\cdot\dfrac{(n-4)/n}{2\sqrt{2(n-2)}/n}=\dfrac{n-4}{2(n-2)}$, and

$$\phi'(w_0^-)=1-\frac{n-4}{2(n-2)}=\frac{n}{2(n-2)} .$$

At $n=12$ this is $\tfrac{12}{20}=\tfrac35$ **exactly**, confirming the entry; directly, $\sqrt{1-\tfrac49}=\tfrac{\sqrt5}3$ so $w_0/\sqrt{1-w_0^2}=2/\sqrt5$ and $\phi'=1-\tfrac1{\sqrt5}\tfrac2{\sqrt5}=1-\tfrac25=\tfrac35$. The closed form $n/(2(n-2))$ also makes the entry's "$\phi'(w_0)\downarrow\tfrac12$" exact rather than asymptotic, and it belongs on the record.

## 4. Where the minimum is, and what each position measures

**The minimum of branch 2 as stated (with $K(w)$ inside), is at $w_0=\tfrac23$, and $\tfrac23$ is right.**

- On $(w_0,1]$: $\phi\equiv1$, so $\tfrac{\mathrm d}{\mathrm dw}\log(\text{branch }2)=\tfrac1q\tfrac{N'}N>0$ for every $w>0$. Strictly increasing.
- On $[0,w_0)$: $\tfrac1q\tfrac{N'}N\le0.4019<\tfrac35\le\phi'/\phi$, so the derivative is $\le-0.198$. Strictly decreasing.

Hence $w_0$ is the unique minimiser on $[0,1]$, attained, and the minimum is not a stationary point.

**What Position B measures.** Its $+0.0943$ is $\tfrac{N'}N-\tfrac{\phi'}\phi$ at $w_0$, i.e. the same expression with the elasticity factor $1/q$ deleted: $0.6943408-0.6=0.0943408$, agreeing to every digit B reports. Deleting $1/q$ is exactly holding $K$ constant in $w$. And $0.605$ is that objective's stationary point: at $w=0.605$, $N'/N=0.4350210/0.6339900=0.6861639$ while $\phi'/\phi=0.6601819/0.9610826=0.6869122$, equal to three parts in $10^4$, the residual is rounding in $0.605$, and the sign change across it ($-0.183$ at $w=0.5$, $+0.069$ at $w=0.65$) confirms it is that objective's interior minimum.

**The two objectives ranked at both points**, which settles the matter without appeal to derivatives. Writing $F=G/\phi$ for branch 2 up to its constant $\lambda/(\sqrt2Jn)$:

| $w$ | $N/\phi$ (B's objective) | $F=G/\phi$ (branch 2 as stated) |
|---|---|---|
| $0.605$ | $0.796235/0.9610826=0.8284755$ | $0.3782218/0.9610826=0.3935367$ |
| $\tfrac23=w_0$ | $0.8308940/1=0.8308940$ | $0.3867242/1=0.3867242$ |

B's objective is $0.29\%$ lower at $0.605$; **branch 2 as stated is $1.76\%$ higher there**. The two objectives rank the two points oppositely, which is the disagreement in one line.

**Why the stated objective is the right one, and it is the entry's own ruling.** [L157](../findings/second-order.md) makes $\eta^*$ a fixed point of $t=\beta\sqrt{c_p+\rho w^2}$, so $K$ is a function of $w$ and not a constant. [L158](../findings/second-order.md)'s Gate-2 box lists "$\eta^*$ was read at $w=0$" among the four constants the entry had wrong, and the elasticity identity $\mathrm d\log(KN)/\mathrm d\log s=1/\sqrt{4t+1}$ was derived by r715 precisely to keep $K$'s $w$-dependence inside the minimisation. Freezing $K$ is the superseded reading.

**The defect this adjudication does record, and it is a notation collision rather than an error.** [findings/second-order.md:1342](../findings/second-order.md) reads

> below it the envelope's slope is $\phi'(w_0)=\tfrac35$ exactly against $\tfrac1s\tfrac{N'}N\le\tfrac{\sqrt\rho}{2\sqrt{c_p}\,s_{\min}}=0.4019$ uniformly, by AM–GM.

The letter $s$ carries **three** meanings inside this one entry: $s=\sqrt{c_p+w^2}$ in the "settled without arithmetic" box; $s=\sqrt{1+4t}$ in the line quoted, which is what makes $0.4019$ come out; and $s_\rho(w_0)=N(w_0)=0.830894$ in the threshold $T=18.00$, as my reproduction of $T$ above forces. A reader who drops the $\tfrac1s$ as an artifact of the collision lands on $0.0943$ and on $w\approx0.605$, which is exactly what Position B did. **The entry's mathematics is right; its notation manufactures Position B.** Naming the three is owed.

## The strongest case for Position B, stated and then answered

*Its best form.* $t$ enters through L157's self-consistency $r\le\sqrt c/\sup_{\lvert s\rvert\le r}\lVert A''\rVert$, which is a bound that must hold along a whole segment. One could argue that $\eta^*$ should therefore be taken at the worst direction and held fixed while $w$ varies, since a reach parameter that re-optimises pointwise is not obviously a single admissible tube. Under that reading $K$ is a constant, B's objective is the right one, and the minimum is interior at $0.605$, and B would then be correcting an entry that let a prefactor float.

*Why it fails.* The self-consistency is **per direction**: $\eta^*$ is defined by the fixed point of the bound at that $H$, and the radius $r(H)$ the chain delivers is a pointwise lower bound over $H$, minimised afterwards. Nothing in [L157](../findings/second-order.md) ties one $\eta$ across directions; it is the freezing of $\eta=\tfrac12$ that L157 exists to remove. And the objection is self-defeating on its own terms: a constant $K$ must be the worst-case one, $K(w)$ is decreasing in $w$ (as $q$ increases), so the worst case is $K(1)$, under which the objective is $K(1)N/(n\phi)$, still a positive multiple of B's, so its minimiser stays at $0.605$ but every value drops by the same factor, and the comparison with branch 1 that [L158](../findings/second-order.md) exists to make would be strictly weakened rather than corrected. The pointwise reading is both the record's and the sharper one.

*B is therefore `withdrawn`*, not for a false computation, its $0.0943$ being an exact value, but for **measuring branch 2 with $K$ frozen where the lemma, the brief, and L157 all carry $K(w)$.**

## 5. What [results.md](../results.md):363 should read

The sentence as it stands is **correct and understated**. It currently reads:

> *its minimum sits at the homogeneity kink $w_0=(n-4)/n$, which is $\tfrac23$ at $n=12$, the envelope being $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ and equal to $1$ above $w_0$*

It should keep every word and gain the four facts this adjudication establishes, that the minimum is strict and one-sided, its two derivatives, the exact $\phi'(w_0)$, and the dimension the argument is claimed at:

> *its minimum sits at the homogeneity kink $w_0=(n-4)/n$, which is $\tfrac23$ at $n=12$, the envelope being $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ and equal to $1$ above $w_0$, **a strict kink minimum and not a stationary point**, the log-derivative being $-0.2405$ on the left of $w_0$ and $+0.3595$ on the right at $n=12$, since $\phi'(w_0^-)=n/(2(n-2))=\tfrac35$ exceeds $\tfrac1q\tfrac{N'}N\le\tfrac{\sqrt\rho}{2\sqrt{c_p}\,s_{\min}}=0.4019$ while above $w_0$ the envelope is constant and only the numerator moves. **The $\tfrac1q$ is the elasticity $\mathrm d\log(K\sqrt{c_p+\rho w^2})/\mathrm d\log\sqrt{c_p+\rho w^2}=1/\sqrt{4t+1}$ and it is load-bearing**: deleting it (freezing $K$), moves the minimum to $w\approx0.605$, where the stated branch 2 is $1.76\%$ **higher**. The sufficient condition is claimed at $n=12$ only.*

*The last clause is the entry's own $n$-locality caveat, and it earns its place: at $n=14$ the same chain gives $\tfrac{\sqrt\rho}{2\sqrt{c_p}s_{\min}}\approx0.586$ against $\phi'(w_0)=\tfrac{14}{24}=0.5833$, so **the sufficient condition fails there**. That is a screen and not a verdict, the AM–GM bound is loose on $[0,w_0]$ by a factor $1.12$ at $n=12$, so its failure at $n=14$ leaves the kink's status at $n=14$ open rather than refuted.*

**Nothing downstream moves.** $G(w_0)=0.38672$, $T=18.00$, the ruling that branch 2 binds at $n=12$, and [L149](../findings/second-order.md)'s $g_\rho\ge0.71979/n$ all stand, all three reproduced here from the closed forms.
