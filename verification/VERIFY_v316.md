# Verifier v316, the bound psi at most 1 on [0, 0.5748] in the proof of Lemma L20 (step A2 of round L100)

The brief ([ADJ_L100_A2.md](ADJ_L100_A2.md)) was read cold. No numerical work was done and no scripts were written. Every value below is exact: the one inequality that compares a transcendental number with an algebraic one is settled by exact rational bounds that a reader checks by hand, together with the kernel-checked bracket in [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean). The log is [agent_logs/verify-L100-v316.log](../agent_logs/verify-L100-v316.log).

| # | Claim (from [route-a.md](../findings/route-a.md) line 139) | Verdict |
|---|---|---|
| 1 | $\psi(\varphi)\le1$ for every $\varphi\in[0,0.5748]$ (the step) | CONFIRMED |
| 2 | The reduction is exact: $\psi\le1\iff\sin\varphi\le s^*$, $s^*$ the real root of $s^3+s^2+s=1$ | CONFIRMED |
| 3 | $s^*\in(0.5436,0.5437)$ | CONFIRMED |
| 4 | $\sin(0.5748)$ lies below $s^*$ (the record prints $0.5436669$) | CONFIRMED |
| 5 | The minimum of $\psi$ is at $\sin\varphi=\tfrac{\sqrt3-1}2$ | CONFIRMED AS ALGEBRA |
| 6 | $\psi$ first exceeds $1$ at $\varphi=\arcsin s^*$, and $0.5748$ is that crossing truncated in the safe direction | CONFIRMED |
| 7 | Printed decimals $0.9785933$, $0.3747372$, $0.5748263$, $0.9999937$ | Not load-bearing, closed forms given, decimals not evaluated |

**Summary: the step is VALID, because $\psi\le1$ is exactly $\sin\varphi\le s^*$ on $[0,\pi/2)$, and $\sin(0.5748)<0.5436714<0.5436890<s^*$ by an exact Taylor bound and the kernel-checked bracket.**

## 0. Conventions, fixed once

- $\psi(\varphi)=\dfrac{\cos\varphi}{1-\sin^3\varphi}$, as defined in the passage.
- $s=\sin\varphi$, $c=\cos\varphi$.
- $g(s)=s^3+s^2+s$, and $s^*$ is the unique real $s$ with $g(s)=1$. It is unique because $g'(s)=3s^2+2s+1=2s^2+(s+1)^2>0$ for every real $s$.
- $0.5748$ means the rational $5748/10^4$, and all decimals in Section 3 are finite decimals, that is exact rationals.
- The step concerns the real function $\psi$ only. The metric question (geodesic against chord) decides whether the lemma's $\varphi$ is the argument of $\psi$, which is the context's commitment, and it does not enter the step.

## 1. Hypothesis inventory

| # | Hypothesis | Where stated | Status |
|---|---|---|---|
| H1 | $\varphi\in[0,0.5748]$ real | the step | given |
| H2 | $\psi$ as in Section 0 | route-a.md line 138 | given |
| H3 | $0.5748<\pi/2$, so $\sin$ is increasing and $\cos\ge0$ on $[0,0.5748]$ | implicit | true, since $\pi>3$ gives $\pi/2>1.5$ |
| H4 | $1-\sin^3\varphi>0$, so $\psi$ is defined | implicit | true, since $0\le\sin\varphi<1$ by H3 |
| H5 | $s^*\in(0.5436890,\,0.5436891)$ | [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean) theorem bracket_tight, with cubic_strict_mono and the sign change | kernel-checked over $\mathbb Q$, and the transfer to the real root is Section 2's monotonicity |
| H6 | $\sin x\le x-\tfrac{x^3}{6}+\tfrac{x^5}{120}$ for $x\ge0$ | standard | proved in Section 3 |

No other input of the lemma (the eigenvalue bound $\alpha\le\tfrac13$, the first-variation condition, $\gamma_V\le m$) is used by this step.

## 2. The reduction is exact

Let $\varphi\in[0,\pi/2)$, so $s\in[0,1)$, $c=\sqrt{1-s^2}\ge0$ and $1-s^3>0$. Then $\psi\le1$ is equivalent to $c\le1-s^3$. Both sides are nonnegative, so this is equivalent to $c^2\le(1-s^3)^2$, that is $1-s^2\le1-2s^3+s^6$, that is

$$0\le s^2-2s^3+s^6=s^2\,(s^4-2s+1)=s^2\,(1-s)\,(1-s-s^2-s^3).$$

The factorisation $s^4-2s+1=(s-1)(s^3+s^2+s-1)$ expands directly, since $(s-1)(s^3+s^2+s-1)=s^4+s^3+s^2-s-s^3-s^2-s+1=s^4-2s+1$, and it is theorem quartic_factors of the Lean file. For $s\in(0,1)$ the factors $s^2$ and $1-s$ are positive, so the condition is $g(s)\le1$, which is $s\le s^*$ because $g$ is strictly increasing. At $s=0$ the condition holds with equality ($\psi(0)=1$) and $0<s^*$ holds as well. **So on $[0,\pi/2)$, $\psi(\varphi)\le1\iff\sin\varphi\le s^*$, with equality in $\psi$ exactly at $\varphi=0$ and $\varphi=\arcsin s^*$.** Claim 2 is CONFIRMED.

The real root lies in the rational bracket of H5 because $g$ is strictly increasing on $\mathbb R$ and the Lean file shows $g(0.5436890)<1<g(0.5436891)$. This gives Claim 3, CONFIRMED, and the tighter bracket used next.

## 3. The comparison $\sin(0.5748)<s^*$

**The Taylor bound H6.** For $x\ge0$ start from $\cos t\le1$ and integrate over $[0,x]$ repeatedly, each integration preserving the inequality: $\sin x\le x$, then $1-\cos x\le x^2/2$, so $\cos x\ge1-x^2/2$, then $\sin x\ge x-x^3/6$, then $1-\cos x\ge x^2/2-x^4/24$, so $\cos x\le1-x^2/2+x^4/24$, then $\sin x\le x-x^3/6+x^5/120$.

**Exact values at $x=0.5748$.**

- $5748^2=(5700+48)^2=32490000+547200+2304=33039504$, so $x^2=0.33039504$.
- $33039504\cdot5748=165197520000+23127652800+1585896192=189911068992$, so $x^3=0.189911068992$.
- $189911068992/6=31651844832$ (check: $31651844832\cdot6=189911068992$), so $x^3/6=0.031651844832$.
- $x^5=x^3\cdot x^2<0.19\cdot0.3304=0.062776$, so $x^5/120<0.062776/120<0.0005232$ (since $0.0005232\cdot120=0.062784>0.062776$).

**Hence** $\sin(0.5748)<0.5748-0.031651844832+0.0005232=0.543671355168<0.5436890<s^*$.

The margin is $0.5436890-0.543671355168=0.000017644832>0$, positive with no rounding anywhere in the chain. Claim 4 is CONFIRMED. The printed value $0.5436669$ is not needed, and it is consistent with the upper bound.

## 4. The step

Let $\varphi\in[0,0.5748]$. By H3, $\sin$ is increasing on $[0,\pi/2]\supset[0,0.5748]$, so $\sin\varphi\le\sin(0.5748)<s^*$. By Section 2, $\psi(\varphi)\le1$. Equality holds only at $\varphi=0$, and $\psi<1$ on $(0,0.5748]$. **Claim 1 is CONFIRMED.**

The phrase "$\psi\le\psi(0)=1$" is read as "$\psi$ is bounded by its value at $0$, which is $1$". That reading is exactly what was proved, and it makes no claim of monotonicity (which would be false, see Section 5).

## 5. Side claims

**The minimum.** Differentiating, $\psi'(\varphi)=\dfrac{-s(1-s^3)+3s^2c^2}{(1-s^3)^2}=\dfrac{-s+3s^2-2s^4}{(1-s^3)^2}=\dfrac{-s\,(2s^3-3s+1)}{(1-s^3)^2}=\dfrac{-s\,(s-1)(2s^2+2s-1)}{(1-s^3)^2}$. On $(0,\pi/2)$ the factor $-s(s-1)=s(1-s)$ is positive, so $\psi'$ has the sign of $2s^2+2s-1$, negative below $s_0=\tfrac{\sqrt3-1}2$ and positive above. So $\psi$ decreases then increases, with minimum at $\sin\varphi=s_0$. Claim 5 is CONFIRMED AS ALGEBRA. In closed form $s_0^2=\tfrac{2-\sqrt3}2$, $c_0=(\sqrt3/2)^{1/2}$, $s_0^3=\tfrac{3\sqrt3-5}4$, so $\psi_{\min}=\dfrac{4\,(\sqrt3/2)^{1/2}}{3(3-\sqrt3)}$ at $\varphi=\arcsin\tfrac{\sqrt3-1}2$. It is below $1$ because $g(s_0)=\tfrac{3\sqrt3-3}4<1$ (as $27<49$), so $s_0<s^*$. The decimals $0.9785933$ and $0.3747372$ were not evaluated.

**The crossing.** By Section 2, $\psi>1$ exactly for $\sin\varphi\in(s^*,1)$, so the first crossing after $0$ is $\varphi_c=\arcsin s^*$. Section 3 gives $0.5748<\varphi_c$, so $0.5748$ lies on the safe side of the true crossing. Claim 6 is CONFIRMED. Whether $0.5748$ is the four-place truncation of $\varphi_c$ (the printed $0.5748263$) needs the upper bound $\varphi_c<0.5749$, which the step does not use. The value $\psi(0.5748)=0.9999937$ was not evaluated, and Section 4 shows only $\psi(0.5748)<1$.

**Argued the opposite.** A failure would need a $\varphi\in[0,0.5748]$ with $\psi(\varphi)>1$. By Section 2 that requires $\sin\varphi>s^*$, hence $\sin(0.5748)>0.5436890$, which Section 3 excludes exactly. The squaring in Section 2 introduces no spurious direction because both sides were nonnegative, and the only extra root of the quartic, $s=1$, is outside $[0,1)$.

## Verdict

**VALID.** On $[0,\pi/2)$ the inequality $\psi\le1$ is exactly $\sin\varphi\le s^*$, and $\sin(0.5748)<0.543671355168<0.5436890<s^*$ by the degree-5 Taylor bound and the kernel-checked rational bracket, so $\psi\le1$ on the whole interval, with equality only at $\varphi=0$.
