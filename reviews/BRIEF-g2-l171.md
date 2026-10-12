# Gate 2 brief, the inner maximisation's constants

**You are one of two reviewers working from identical briefs, cold and independently.** Work from what is below and from sources you fetch yourself. Do not read the findings file this came from until you have formed your own verdict on every claim.

## Standing rules for this brief

**Analysis only.** Computation requires the user's approval for a specific task and it has not been given here. The one allowance is **screening a claim you are about to record**, seconds of compute, on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim. Everything else waits: searches, sweeps, optimisations, censuses, falsifier hunts. **All arithmetic exact**, rational or symbolic.

**Log** to the path your dispatch names: PID and phase plan on the first line, a line at every tool round carrying live state, and a closing `DONE <verdict>`. Say in the log before a long reasoning stretch what you are about to derive.

**Committing, under a shared index.** Other reviewers are committing concurrently to the same working tree. **Name your paths on the commit itself**, `git commit -- reviews/REVIEW_r<N>.md reviews/INDEX.md -m "..."`, so a sibling's staged file cannot ride into your commit; staging by path alone does not prevent it. Leave nothing staged. Your scope is your own report, your index row, and any `references/` folder you create. If your index row conflicts, re-read `reviews/INDEX.md` and re-apply it.

**Before you write a discrepancy down**, clear all three or report it `withdrawn` with the reason: **locate it exactly** (step, line, the hypothesis it lacks); **exhibit the failure concretely** in closed form; **argue the opposite**, the strongest reading the words support.

**Silence is not a verdict.** Answer every attack item in writing, including where you find nothing.

## Report format

`reviews/REVIEW_r<N>.md`: title naming the claims; a standfirst saying the brief was cold, that no numerical work was done and every value is exact, and the log path; **the claim table before any prose**, one row per claim with a verdict in caps; a one-line actionable summary; `## 0. Conventions, fixed once`; the hypothesis inventory; numbered sections carrying each derivation in full; the overall verdict from `PROVEN`, `PROVEN (hypotheses corrected`, `GAP`, `BROKEN`, `HYPOTHESIS-DEBT`, `UNRESOLVED), needs computation`.

**You check the written proof; you do not build your own.** Where a claim has no argument on file the finding is *"this claim has no argument on file"*, full stop, and the verdict is `HYPOTHESIS-DEBT` naming what would have to be proved.

## The setting

At a competitor $u$ with $\theta^*=\sqrt{3/2}$, a maximiser is written $W=cW_1+\sigma K$ with $W_1$ in the $\tfrac13\theta^*$-eigenspace $V_{1/3}$ of $F_u$ and $K\in\ker F_u$ of unit norm. Write $T$ for the symmetric trilinear polarisation of $P$, and set

$$q=\Pi_{\ker F_u}Q(W_1),\qquad a=\lVert q\rVert,\qquad A=T(W_1,W_1,K)=\langle q,K\rangle,\qquad B=T(W_1,K,K)=\langle M_{W_1}K,K\rangle,$$

with $M_{W_1}$ symmetric on $\ker F_u$ and $\lambda$ its top eigenvalue. **On the record**: $a=\sqrt{5/6}$, derived; $M_{W_1}q=0$, measured at $n=12,14,16$; and the displayed value of the inner maximisation is

$$V(t)=\max_{\lVert K\rVert=1}[A+tB]=\begin{cases}\sqrt{5/6}, & t\le t^*\\[2pt] \dfrac5{16t}+\dfrac{2t}3, & t>t^*\end{cases}\qquad t^*=\tfrac34\sqrt{\tfrac56}=\tfrac{\sqrt{30}}8 .$$

The record states $\lambda=\tfrac23$ and notes it has no derivation anywhere.

## The statement under review

> Under $M_{W_1}q=0$,
> $$V(t)=\begin{cases}a, & t\le t^*\\[4pt] \dfrac{a^2}{4\lambda t}+\lambda t, & t\ge t^*\end{cases}\qquad t^*=\frac a{2\lambda}.$$
> **So the record's three constants are two**: given $a=\sqrt{5/6}$, each of $\tfrac5{16}$ and $t^*=\sqrt{30}/8$ pins $\lambda=\tfrac23$, independently and in agreement.

## The proof as written

> $M_{W_1}$ is symmetric and $M_{W_1}q=0$, so a top eigenvector $v$ with $M_{W_1}v=\lambda v$, $\lambda\ne0$, is orthogonal to $q$. Write a unit $K=\cos\varphi\,\hat q+\sin\varphi\,v$; then $\langle q,K\rangle=a\cos\varphi$ and $\langle M_{W_1}K,K\rangle=\lambda\sin^2\varphi$, the $\hat q$ term vanishing and the cross term with it. Maximising $f(c)=ac+t\lambda(1-c^2)$ over $c\in[-1,1]$ gives the interior point $c^*=\tfrac a{2t\lambda}$ exactly when $t\ge\tfrac a{2\lambda}$, with value $\tfrac{a^2}{4\lambda t}+\lambda t$; below that the maximum sits at $c=1$ and equals $a$. $\square$

Three claims are made around it:

> **(a) The tangency is structural.** The frontier branch's minimum is at $t=\tfrac a{2\lambda}=t^*$, of value $2\sqrt{\tfrac{a^2}{4\lambda}\lambda}=a$, the constant branch exactly.
>
> **(b) What it settles.** It does **not** derive $\lambda_{\max}(M_{W_1})=\tfrac23$ from the structure. What it removes is the appearance of three independent measurements, so the record's internal agreement among them is not evidence.
>
> **(c) What $c_0=1$ buys.** The derivation takes the maximiser's $W_2$ to lie entirely in $\ker F_u$, which is what $c_0=1$ asserts; with any component in the non-positive part $N$ the display gains a term in $T(W_1,N,N)$ and neither the reduction nor the closed form survives. So $c_0=1$ is a hypothesis, not a constant to derive.

## What to attack

1. **The ansatz $K=\cos\varphi\,\hat q+\sin\varphi\,v$ is a restriction, and the proof treats it as general.** A unit $K$ in $\ker F_u$ has components outside $\mathrm{span}\{q,v\}$. **Does the maximum really lie in that plane?** Construct the argument that it does, or show it does not, this is the step the whole lemma rests on and the proof asserts it by choosing coordinates.
2. **The hard-case hypothesis.** $M_{W_1}q=0$ gives $q\perp$ the image of $M_{W_1}$ restricted how, exactly? Check that a top eigenvector is orthogonal to $q$, including when $\lambda$ has multiplicity greater than one and when $\lambda=0$.
3. **The cross term.** $\langle M_{W_1}K,K\rangle=\lambda\sin^2\varphi$ needs $\langle M_{W_1}\hat q,v\rangle=0$ **and** $\langle M_{W_1}\hat q,\hat q\rangle=0$. Derive both from $M_{W_1}q=0$, and say whether symmetry of $M_{W_1}$ is used and where.
4. **The one-variable maximisation.** Maximise $f(c)=ac+t\lambda(1-c^2)$ over $[-1,1]$ yourself, including the sign of $\lambda$ and of $t$, and the boundary cases $c=\pm1$. **Is the interior point a maximum or a minimum?** That depends on the sign of $t\lambda$, and the proof does not say.
5. **The admissibility threshold.** $c^*\le1\iff t\ge\tfrac a{2\lambda}$, check it, and check what happens on $t<\tfrac a{2\lambda}$, where the proof says the maximum sits at $c=1$ with value $a$. **Is $f(1)=a$?** Verify: $f(1)=a\cdot1+t\lambda(1-1)=a$.
6. **The two pinnings.** Verify $\tfrac{a^2}{4\lambda}=\tfrac5{16}$ and $t^*=\tfrac a{2\lambda}=\tfrac{\sqrt{30}}8$ at $a^2=\tfrac56$, $\lambda=\tfrac23$; then check that each **independently** forces $\lambda=\tfrac23$ given $a$, and that they agree. **A single algebraic slip here would make an agreement out of a coincidence**, which is the claim's whole content.
7. **Claim (a).** Is the minimum of $\alpha/t+\beta t$ at $t=\sqrt{\alpha/\beta}$ with value $2\sqrt{\alpha\beta}$, and does that equal $a$ here? Check the signs.
8. **Claim (b)'s epistemics.** *"Their mutual agreement is not evidence"*, is that right? If $\tfrac5{16}$ and $t^*$ were measured **separately** rather than derived from one $\lambda$, their agreement would be evidence. **Which is it on the record?** Say what you checked.
9. **Claim (c).** Does the derivation actually use $W_2\in\ker F_u$, and where? Would a component in $N$ really break it, or only complicate it?
10. **Hypothesis inventory**, and which stated hypotheses go unused.
11. **The edges.** $\lambda=0$; $\lambda<0$; $a=0$; $t=0$ and $t<0$; $q=0$; and $\ker F_u$ one-dimensional.
12. **Name what would break it.**
