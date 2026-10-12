# VERIFY v85, where branch 2 is minimised over $w\in[0,1]$ at $n=12$

*Adjudication of the disagreement between the kink reading and the interior reading of [Lemma L158](../findings/second-order.md)'s branch 2. **No numerical work was done: no script was run, and every value below is an exact hand evaluation of a closed form.** Log: [agent_logs/verify-kink-v85.log](../agent_logs/verify-kink-v85.log).*

**POSITION A.** The minimum is the kink $w_0=\tfrac23$, and it is strict: the left log-derivative there is $-0.24054$ and the right is $+0.35946$. Position B's $+0.0943$ is a **left** derivative, and it is the left derivative of a **different function**, branch 2 with $K$ frozen against $w$. Its $w\approx0.605$ is that frozen function's stationary point, reproduced here as $0.60547$. B's arithmetic is right and its objective is wrong, the record stating in [L157](../findings/second-order.md) and again in [L158](../findings/second-order.md) that $t$, hence $\eta^*$, hence $K$, moves with $w$.

## The one identity everything rests on, stated first

Write $N(w)=\sqrt{c_p+\rho^{\text{eff}}_nw^2}$ for branch 2's numerator, $\beta=\lambda/(2C)$, so that [L157](../findings/second-order.md)'s reach parameter is driven by $t=\beta N$ and $s=\sqrt{1+4t}$, $\eta^*=\tfrac{s-1}{s+1}$, $1-\eta^*=\tfrac2{s+1}$. Then

$$K(w)N(w)=\frac{\lambda}{\sqrt2 J}\cdot\frac4{(s+1)^2}\cdot\frac{s^2-1}{4\beta}=\frac{\lambda}{\sqrt2 J\beta}\cdot\frac{s-1}{s+1}=\frac{\lambda}{\sqrt2 J\beta}\,\eta^* ,$$

using $N=t/\beta$ and $t=(s^2-1)/4$. **Branch 2 is the reach parameter itself over the envelope**, $\tfrac{\lambda}{\sqrt2J\beta}\cdot\eta^*(w)/(n\phi(w))$, which is what it should be, the reach being $r=\eta^*\rho$ with $\rho=\gamma g_n/\lVert H\rVert_{op}$ and $\lVert H\rVert_{op}\le\phi$. Differentiating the closed form,

$$\frac{\mathrm d\log(KN)}{\mathrm dw}=\frac{\mathrm d\log\eta^*}{\mathrm dw}=\frac2{s^2-1}\cdot\frac{2\beta N'}{s}=\frac{4\beta N'}{s\cdot 4\beta N}=\frac1s\frac{N'}N ,$$

an **identity, not a small-$t$ expansion**. So the log-derivative of branch 2 is $\tfrac1s\tfrac{N'}N-\tfrac{\phi'}\phi$ throughout, and the whole question is whether the factor $\tfrac1s$ is present.

**The constants, and the three independent checks that they are the record's.** At $n=12$: $c_p=\kappa/n=\tfrac{\sqrt{55}}{20}=0.37080992$; $\rho^{\text{eff}}_{12}=\sqrt6-\tfrac7{30}\sqrt{55}=0.71904343$; $\lvert\kappa_{12}\rvert=9(\theta_0-\sqrt{3/2})=0.10159389$ so $\lambda=2/\sqrt{\lvert\kappa_{12}\rvert}=6.2747233$; [L156](../findings/second-order.md) gives $C=C^*=\tfrac{42}{11}$ and $J^*=6.9421$, whence $\beta=\lambda/(2C)=0.8216898$. Three values fall out of these and match what the record prints: $\beta\sqrt{c_p}=0.5003613$ against [L156](../findings/second-order.md)'s $t\in[0.50036,\dots]$; $G(w_0)=(1-\eta^*)^2N(w_0)=0.386724$ against [L158](../findings/second-order.md)'s $0.38673$; and branch 2 at $w_0$ equal to $\tfrac{\lambda}{\sqrt2J\beta}\eta^*/12=0.0205981$ against [L158](../findings/second-order.md)'s $0.0206$.

## 1. The two one-sided log-derivatives at $w_0=\tfrac23$, $n=12$

**Both are of $\log\big(K(w)N(w)/(n\phi(w))\big)$, and the side is named for each.**

The pieces at $w_0=\tfrac23$:

- $\rho w_0^2=\tfrac49\big(\sqrt6-\tfrac7{30}\sqrt{55}\big)=\tfrac49\sqrt6-\tfrac{14}{135}\sqrt{55}=1.0886621-0.3982768=0.3195749$, so $N(w_0)^2=c_p+\rho w_0^2=0.6903848$ and $N(w_0)=0.8308940$.
- $\dfrac{N'}N\Big|_{w_0}=\dfrac{\rho w_0}{c_p+\rho w_0^2}=\dfrac{0.4793623}{0.6903848}=0.6943341$.
- $t(w_0)=\beta N(w_0)=0.8216898\times0.8308940=0.6827370$, so $s(w_0)=\sqrt{1+4t}=\sqrt{3.7309480}=1.9315637$.
- $\dfrac1s\dfrac{N'}N\Big|_{w_0}=\dfrac{0.6943341}{1.9315637}=0.3594591$.
- $\phi(w_0)=1$, $\phi'(w_0^-)=\tfrac35$ (section 3), $\phi'(w_0^+)=0$.

Hence

| side | $\tfrac1s\tfrac{N'}N$ | $\tfrac{\phi'}\phi$ | log-derivative of branch 2 |
|---|---|---|---|
| **left**, $w\uparrow w_0$ | $0.3594591$ | $0.6$ | $\mathbf{-0.2405409}$ |
| **right**, $w\downarrow w_0$ | $0.3594591$ | $0$ | $\mathbf{+0.3594591}$ |

**Negative on the left, positive on the right: $w_0$ is a strict kink minimum.** And the conclusion is global rather than local, because both signs persist away from $w_0$: on $(w_0,1]$ the envelope is constant so the log-derivative is $\tfrac1s\tfrac{N'}N>0$ throughout; on $(0,w_0)$ the slope $\phi'(w)=1-\tfrac{w}{\sqrt{(m-1)(1-w^2)}}$ **decreases** in $w$, so $\phi'\ge\phi'(w_0)=\tfrac35$ there while $\phi\le1$, giving $\tfrac{\phi'}\phi\ge\tfrac35>0.40189\ge\tfrac1s\tfrac{N'}N$ by section 2. So branch 2 strictly decreases on $[0,w_0]$ and strictly increases on $[w_0,1]$, and $w_0$ is its unique minimiser on $[0,1]$.

## 2. The AM–GM step

**Correct, $0.40189$ at $n=12$, and uniform on $[0,w_0]$, indeed on all of $[0,1]$.**

Two independent bounds multiplied, both factors positive:

- $c_p+\rho w^2\ge2\sqrt{c_p\rho}\,w$ is AM–GM on the pair $(c_p,\rho w^2)$, valid for every $w\ge0$ with equality at $w=\sqrt{c_p/\rho}$. Hence $\dfrac{N'}N=\dfrac{\rho w}{c_p+\rho w^2}\le\dfrac{\rho w}{2\sqrt{c_p\rho}\,w}=\dfrac{\sqrt\rho}{2\sqrt{c_p}}$ for $w>0$, and the left side is $0$ at $w=0$.
- $s=\sqrt{1+4\beta N(w)}$ is strictly increasing in $w$, $N$ being so; hence $\tfrac1s\le\tfrac1{s_{\min}}$ with $s_{\min}=s(0)=\sqrt{1+4\beta\sqrt{c_p}}=\sqrt{3.0014452}=1.7324679$.

The value: $\tfrac{\sqrt\rho}{2\sqrt{c_p}}=\tfrac12\sqrt{\rho/c_p}=\tfrac12\sqrt{1.939116}=\tfrac12(1.3925214)=0.6962607$, and $0.6962607/1.7324679=0.40189$. **So $0.4019$ is right.**

*Its slack, recorded because the step is stated as if tight.* AM–GM's equality point is $\sqrt{c_p/\rho}=0.71812$, which lies **above** $w_0$, so on $[0,w_0]$ the first factor is not attained: the true supremum of $N'/N$ there is its value at $w_0$, $0.6943341$ against the bound's $0.6962607$, loose by $0.28\%$. The second factor is loose by more, $s$ running from $1.7325$ to $1.9316$ across the interval. None of it matters, $0.40189<\tfrac35$ with $49\%$ to spare.

## 3. $\phi'(w_0)$, from scratch

**$\phi'(w_0^-)=\tfrac35$ exactly at $n=12$, and $\tfrac n{2(n-2)}$ in general.**

Write $b=a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$, which is $1/\sqrt5$ at $n=12$, $m=6$. On the branch where the linear form is the smaller, $\phi(w)=b\sqrt{1-w^2}+w$ and $\phi'(w)=1-\dfrac{bw}{\sqrt{1-w^2}}$.

The crossing first. $b\sqrt{1-w^2}+w=1$ gives $b\sqrt{1-w^2}=1-w$; squaring, $b^2(1-w)(1+w)=(1-w)^2$, so either $w=1$ or $b^2(1+w)=1-w$, i.e. $w_0=\dfrac{1-b^2}{1+b^2}=\dfrac{1-\tfrac2{n-2}}{1+\tfrac2{n-2}}=\dfrac{n-4}n$, which is $\tfrac23$ at $n=12$. Above $w_0$ the linear form exceeds $1$, at $w=\tfrac45$, $\tfrac1{\sqrt5}\cdot\tfrac35+\tfrac45=0.2683+0.8=1.0683$, so $\phi\equiv1$ on $[w_0,1]$ and $\phi'(w_0^+)=0$.

The slope. At $w_0=\tfrac{n-4}n$: $1-w_0^2=\dfrac{n^2-(n-4)^2}{n^2}=\dfrac{8(n-2)}{n^2}$, so $\sqrt{1-w_0^2}=\dfrac{2\sqrt{2(n-2)}}n$ and

$$\frac{bw_0}{\sqrt{1-w_0^2}}=\sqrt{\frac2{n-2}}\cdot\frac{n-4}n\cdot\frac n{2\sqrt{2(n-2)}}=\frac{n-4}{2(n-2)},\qquad \phi'(w_0^-)=1-\frac{n-4}{2(n-2)}=\frac n{2(n-2)} .$$

At $n=12$ this is $\tfrac{12}{20}=\tfrac35$. **Confirmed.** Directly: $\sqrt{1-\tfrac49}=\tfrac{\sqrt5}3$ and $\tfrac1{\sqrt5}\cdot\tfrac23\cdot\tfrac3{\sqrt5}=\tfrac25$, so $\phi'=1-\tfrac25=\tfrac35$. The general form also confirms [L158](../findings/second-order.md)'s statement that the slope falls to $\tfrac12$, which is why the sufficient condition is $n$-local.

## 4. Where the minimum is, and what each position measures

**The minimum is at $w_0=\tfrac23$. The two positions measure different objectives.**

- **Position A measures branch 2 as [L158](../findings/second-order.md) defines it**, $K(w)N(w)/(n\phi(w))$ with $K$ carrying $(1-\eta^*(w))^2$, equivalently, by the identity above, $\eta^*(w)/(n\phi(w))$ up to a constant. This is the objective the chain produces: the reach is determined pointwise in $w$ by [L157](../findings/second-order.md)'s self-consistency condition $t(1-\eta)^2=\eta$ with $t=\lambda N/(2J\gamma)$, and $N$ moves with $w$.
- **Position B measures $N(w)/(n\phi(w))$**, branch 2 with $K$ held constant against $w$. Its two numbers are exactly this function's: $N'/N-\phi'=0.6943341-0.6=+0.0943341$ at $w_0$, which is B's $+0.0943$ to four digits and is a **left** derivative; and its stationary point, the root of $\dfrac{\rho w}{c_p+\rho w^2}=\dfrac{1-bw/\sqrt{1-w^2}}{b\sqrt{1-w^2}+w}$, which sits at $w^*=0.60547$, the left side is $0.686180$ against $0.686900$ at $w=0.605$ and $0.687085$ against $0.680076$ at $w=0.61$. That is B's $0.605$.

**So the two positions differ in exactly one factor, $\tfrac1{s(w_0)}=\tfrac1{1.9316}$ on the numerator's log-derivative**, and that factor is what decides the sign: $0.6943>\tfrac35$ but $0.6943/1.9316<\tfrac35$. The record settles which is right and says so twice, [L157](../findings/second-order.md) prints $t=\lambda\sqrt{c_p+\rho^{\text{eff}}_nw^2}/(2J\gamma)$, and [L158](../findings/second-order.md) closes with "**A $w$-dependence the entry ignored.** $K$ is not constant: [L157](../findings/second-order.md)'s $t$ depends on $w$". **$0.605$ is therefore the minimiser of a function the chain does not bound the radius by, and $\tfrac23$ is right.**

**The strongest case for Position B, and why it fails.** One could argue that $\eta$ is a single reach fixed once for the whole tube rather than direction by direction, in which case $K$ is a genuine constant, B's objective is the real one, and the minimum is interior at $0.60547$. Two things defeat it. First, a $w$-independent $\eta$ has to be admissible at the worst $w$, and freezing it at any fixed value gives a **smaller** reach at every other $w$ than the pointwise root does, [L157](../findings/second-order.md) prices exactly this, the frozen $\eta=\tfrac12$ costing $2.9$–$3.4$, so the frozen reading yields a weaker bound and cannot be the one the chain wants. Second, even granting the frozen reading, B's own conclusion would not be a repair to A: at $w^*=0.60547$ the frozen objective's value is *below* its value at $w_0$, so the frozen reading lowers the recorded infimum rather than relocating a correct one. The dispute is over which function is bounded below, and [L157](../findings/second-order.md)'s fixed point answers it.

*And a numerical coincidence worth naming so it is not mistaken for corroboration: B's $+0.0943$ and A's $+0.3595$ are both positive, so a reader who does not check which side a derivative is on can read either as confirming "increasing above the kink". They are not the same statement, one is the left slope of the frozen objective, the other the right slope of the true one.*

## 5. What [results.md](../results.md):363 should read

**The branch-2 clause is correct in substance and overstated in range.** It reads

> Branch 2 has an infimum of order $n^{-1}$, *its minimum sits at the homogeneity kink $w_0=(n-4)/n$, which is $\tfrac23$ at $n=12$, the envelope being $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$ and equal to $1$ above $w_0$*

The location, the envelope, the crossing point and the "equal to $1$ above $w_0$" all stand as verified here. What the line claims beyond its proof is the **range**: it states the minimum at $w_0=(n-4)/n$ for general $n$, where the argument on file is the comparison $\phi'(w_0)=\tfrac n{2(n-2)}$ against $\tfrac1s\tfrac{N'}N\le\tfrac{\sqrt\rho}{2\sqrt{c_p}s_{\min}}$, whose left side falls to $\tfrac12$ while its right side grows like $0.243\sqrt n$, so the two cross and [L158](../findings/second-order.md) itself records the condition as $n$-local and not claimed beyond $n=12$. [results.md](../results.md) carries the conclusion without that restriction.

The clause should read:

> Branch 2 has an infimum of order $n^{-1}$, *at $n=12$ its minimum sits at the homogeneity kink $w_0=(n-4)/n=\tfrac23$ and sits there strictly, the one-sided log-derivatives being $-0.2405$ below and $+0.3595$ above; the envelope is $\lVert H\rVert_{op}\le\min(a_0n^{-1/2}\sqrt{1-w^2}+w,1)$, equal to $1$ above $w_0$, with slope $\phi'(w_0)=\tfrac n{2(n-2)}=\tfrac35$ there against $\tfrac1s\tfrac{N'}N\le0.4019$. **The location is established at $n=12$ only**: $\phi'(w_0)$ falls to $\tfrac12$ while the numerator's bound grows like $0.243\sqrt n$, so the comparison reverses at large $n$*

**And one correction the line needs independently of the range.** Its next clause, "the $n^{-1}$ cancels, so which branch binds is an inequality between absolute constants", is contradicted three sentences later by the same entry's $T=18.00$ at $n=12$ against $\approx35$ in the limit, whose $n$-dependence [L158](../findings/second-order.md) calls "the largest dimension-dependence in the entry". That is outside the question put here and is recorded rather than adjudicated.

## Verdict

**POSITION A**, on all four checked points: $\phi'(w_0)=\tfrac35$ exactly, the AM–GM bound is valid and equal to $0.40189$ uniformly, the left log-derivative at $w_0$ is $-0.24054$ and the right is $+0.35946$, and $w_0=\tfrac23$ is the unique minimiser on $[0,1]$. Position B is **withdrawn** on the ground that its objective freezes a factor the record twice states is $w$-dependent; its arithmetic reproduces exactly, and its $+0.0943$ is the left log-derivative of $N/(n\phi)$ rather than of branch 2.
