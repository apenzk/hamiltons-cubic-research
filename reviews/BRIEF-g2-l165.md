# Gate 2 brief, the frontier requirement in closed form

**You are one of two reviewers working from identical briefs, cold and independently.** Work from what is below and from sources you fetch yourself. Do not read the findings file this came from until you have formed your own verdict on every claim.

## Standing rules

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic; a floating-point residual argues nothing in either direction.

**Log** to `agent_logs/g2-l165-r<N>.log`: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Write** `reviews/REVIEW_r<N>.md`, **index it in `reviews/INDEX.md` in the same commit**, and commit both as `review(l165): r<N> <verdict>`. **Stage by path; never `git add -A`; leave nothing staged.**

## The setting, quoted

An estimate inside a localization theorem requires

$$\gamma_{\max}(\alpha)<\frac{3-5\alpha}{\sqrt3}\qquad\text{for every }\alpha<\tfrac13,$$

where $\alpha=\sqrt{2/3}\langle F_uW,W\rangle$ and $\gamma=\sqrt{2/3}P(W)$ at a competitor $u$ with $\theta^*=\sqrt{3/2}$. Writing $W=\cos\beta\,W_1+\sin\beta\,K$ with $W_1$ in the $V_{1/3}$ eigenspace of $F_u$ and $K\in\ker F_u$, the maximiser has $s^2=3\varepsilon$ with $s=\sin\beta$, $\varepsilon=\tfrac13-\alpha$. With $t=s/\cos\beta$ the inner maximisation over $K$ has value

$$V(t)=\begin{cases}\sqrt{5/6}, & t\le t^*\\[2pt]\dfrac5{16t}+\dfrac{2t}3, & t>t^*\end{cases}\qquad t^*=\tfrac34\sqrt{\tfrac56}=\tfrac{\sqrt{30}}8,$$

and the record's threshold is $\alpha^*=32/141$. The constant $\theta$ below stands for $\sup\{P(K):K\in\ker F_u,\lVert K\rVert=1\}$, bounded by the balanced sphere-product value: $\theta_0(n)^2=\frac{2(n-1)(n-2)}{n^2}$ at even $n$ and $\tilde\theta_0(n)^2=\frac{2(n-1)(n-3)}{(n+1)(n-2)}$ at odd $n$. Also on the record: $Q(W_1)$ for unit $W_1\in V_{1/3}$ lies in $\langle u\rangle\oplus\ker F_u$ with squared norms $\tfrac16$ and $\tfrac56$.

## The statement under review

> Put $\sigma^2=1-3\alpha$, so $\sigma=s=\sin\beta$, $c=\cos\beta=\sqrt{1-\sigma^2}$, $t=\sigma/c$. The requirement, multiplied through by $\sqrt{3/2}$, is
> $$H_\theta(\sigma):=\frac{4+5\sigma^2}{3\sqrt2}-3c^2\sigma\,V(t)-\theta\,\sigma^3>0,\qquad\sigma\in[0,1].$$
> **(0)** $3-5\alpha=\tfrac13(4+5\sigma^2)$ exactly, and $t^*=\sqrt{30}/8$ gives $\sigma^{*2}=15/47$, hence $\alpha^*=32/141$.
> **(1)** $P(W)=3c^2\sigma[A+tB]+\sigma^3P(K)$ with $A=T(W_1,W_1,K)$, $B=T(W_1,K,K)$; the $c^3$ term is absent because $P(W_1)=0$ on $V_{1/3}$. Then $V(t)=\max_K[A+tB]$ and $P(K)\le\theta$, so $H_\theta$ bounds $\gamma_{\max}$ from **above**.
> **(2)** $3c^2\sigma V(t)$ equals $\tfrac{\sqrt{30}}2\sigma(1-\sigma^2)$ for $\sigma\le\sigma^*$ and $\tfrac{\sqrt{1-\sigma^2}(15+17\sigma^2)}{16}$ for $\sigma\ge\sigma^*$.
> **(3)** On $\sigma\le\sigma^*$, $3\sqrt2\,H_\theta(\sigma)=(3\sqrt{15}-3\sqrt2\theta)\sigma^3+5\sigma^2-3\sqrt{15}\sigma+4$. This decreases in $\theta$; both parities have $\theta<\sqrt2$, since $\theta_0(n)^2=2-\frac{2(3n-2)}{n^2}$ and $(n-1)(n-3)-(n+1)(n-2)=5-3n<0$ for $n\ge2$. At $\theta=\sqrt2$ the cubic's discriminant is $12312\sqrt{15}-48197<0$, because $15\cdot12312^2=2{,}273{,}780{,}160<2{,}322{,}950{,}809=48197^2$. One real root; leading coefficient $3(\sqrt{15}-2)>0$ and value $4$ at $\sigma=0$, so the root is negative and the cubic is positive on all of $\sigma\ge0$. **Hence the requirement holds for every $\alpha\in[\tfrac{32}{141},\tfrac13)$, at every $n$ and both parities.**
> **(4)** At $\sigma=\tfrac34$, where $c=\sqrt7/4$, $H_\theta(\tfrac34)=\frac{109\sqrt2}{96}-\frac{393\sqrt7}{1024}-\frac{27}{64}\theta$, so the requirement at $\alpha=\tfrac7{48}$ holds exactly when $\theta<\Theta_{3/4}:=\frac{218\sqrt2}{81}-\frac{131\sqrt7}{144}=1.39925\ldots<\sqrt2$. **Since $\theta_0(n)$ increases to $\sqrt2$ it crosses $\Theta_{3/4}$, so the reach downward from $\tfrac13$ stops at some $\alpha\ge\tfrac7{48}$ once $n$ is large enough.**

## What to attack, answering every item in writing

**Silence is not a verdict.** Answer each item, including where you find nothing.

1. **The change of variable.** Is $\sigma=\sin\beta$ actually forced by $s^2=3\varepsilon$, and is the identity $3-5\alpha=\tfrac13(4+5\sigma^2)$ right? Does $\sigma^{*2}=15/47$ follow from $t^{*2}=15/32$, and does $\alpha^*=32/141$ come out?
2. **The expansion in (1).** Expand $P(cW_1+\sigma K)$ yourself and check every coefficient, including the factor $3$ and the identification $3cs^2B=3c^2s\,tB$. **Is $P(W_1)=0$ on $V_{1/3}$ genuinely a consequence of the decomposition quoted above, or does it need something else?** The record's own headline for that decomposition is about $V_{1/2}$, a different eigenspace, say whether the step survives that.
3. **The direction of the bound.** $H_\theta$ uses $\max_K[A+tB]$ and $P(K)\le\theta$ separately, at possibly different $K$. Check that this makes $H_\theta$ an upper bound on $\gamma_{\max}$ and that the claim in (1) about which way failure argues is right.
4. **The collection in (2).** Verify $\tfrac{15}{16}c^3+2c\sigma^2=\tfrac{c(15+17\sigma^2)}{16}$, the constant $3\sqrt{5/6}=\sqrt{30}/2$, and that the two pieces agree at $\sigma^*$, the branches meet tangentially, so a mismatch there is a finding.
5. **The discriminant.** Recompute $\Delta=18abcd-4b^3d+b^2c^2-4ac^3-27a^2d^2$ for $(a,b,c,d)=(3\sqrt{15}-6,\ 5,\ -3\sqrt{15},\ 4)$ from scratch, and check the integer comparison. **Check the sign convention**: does $\Delta<0$ mean one real root in the convention you are using? Then check that the argument from "one real root" to "positive on $\sigma\ge0$" is complete.
6. **The monotonicity in $\theta$.** The claim is that the $\sigma^3$ coefficient decreasing in $\theta$ makes the whole cubic $\ge$ its value at $\theta=\sqrt2$. Is that right on $\sigma\ge0$, and does the argument use $\sigma\ge0$ anywhere it should?
7. **The witness in (4).** Recompute $H_\theta(3/4)$ from the piece in (2), and $\Theta_{3/4}$ from it. Check $\tfrac9{16}>\tfrac{15}{47}$, so that $\sigma=\tfrac34$ is on the branch the formula is taken from. Check $\Theta_{3/4}<\sqrt2$ exactly.
8. **Hypothesis inventory.** Every hypothesis of the statement, then of every imported fact, checked against the object it applies to. **Which stated hypotheses does the argument use, and which does it not?** Note that the whole construction inherits three unproved inputs of the block it analyses ($c_0=1$, $\lambda=\tfrac23$, and a vanishing measured at three dimensions) and say whether the statement's scope is honest about that.
9. **The edges.** $\sigma=0$ and $\sigma=1$; $\alpha=\tfrac13$ exactly; $\alpha=\alpha^*$, where the two pieces meet; $n=12$, the smallest dimension in scope; odd $n$; and whether "$\theta_0(n)$ increases to $\sqrt2$" needs $n\ge$ something.
10. **A universal claim with no witness.** The positivity claim in (3) is universal over $\sigma\in[0,\sigma^*]$ and over $n$. Try to break it.
11. **Name what would break it.** End by naming the object or parameter value that, if it existed, would falsify the statement, and say what you did to look for it.

## Before you write a discrepancy down

Clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

## Report format

Title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections with each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.
