# Verifier v317, the bound psi(phi) at most 1 on [0, 0.5748] in the proof of Lemma L20 (round L100, step A2)

The brief [ADJ_L100_A2.md](ADJ_L100_A2.md) was read cold, together with the files it links ([route-a.md](../findings/route-a.md) lines 127-139, [conventions.md](../findings/conventions.md) line 81, [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean)). No numerical work was done and no scripts were written. Every value below is exact: the only decimals are terminating decimals used as rationals, and every inequality between them is carried by an integer product shown in full. The log is [agent_logs/verify-L100-v317.log](../agent_logs/verify-L100-v317.log).

| # | Claim (from [route-a.md](../findings/route-a.md) line 139) | Verdict |
|---|---|---|
| 1 | $\psi\le1\iff\sin\varphi\le s^*$, $s^*$ the real root of $s^3+s^2+s=1$, for $\varphi\in[0,\pi/2)$ | CONFIRMED |
| 2 | $s^*\in(0.5436,0.5437)$ | CONFIRMED |
| 3 | $\sin(0.5748)\le s^*$ | CONFIRMED |
| 4 | The minimum of $\psi$ on the interval sits at $\sin\varphi=\tfrac{\sqrt3-1}2$, and $\psi$ decreases before it and increases after | CONFIRMED AS ALGEBRA |
| 5 | The first crossing of $\psi=1$ after $0$ is $\varphi=\arcsin s^*$, and $0.5748$ lies below it | CONFIRMED |
| 6 | **The step: $\psi(\varphi)\le1$ for every $\varphi\in[0,0.5748]$** | CONFIRMED |

**Summary: the step is VALID, by an exact factorisation reducing it to $\sin(0.5748)\le s^*$, which a hand Taylor bound and a hand cubic sign check settle with margin above $8\times10^{-6}$.**

## 0. Conventions, fixed once

- $\psi(\varphi)=\dfrac{\cos\varphi}{1-\sin^3\varphi}$, as defined in the last display of the brief's context.
- $s=\sin\varphi$, $c=\cos\varphi$.
- $g(s)=s^3+s^2+s-1$, and $s^*$ is its real root in $(0,1)$.
- $0.5748$ denotes the rational $5748/10000$, and $\varphi$ is a real angle in radians. The step is a statement about a real function of one variable, so the geodesic versus chord question of [conventions.md](../findings/conventions.md) line 81 does not enter it. That question decides whether the $\varphi$ of the lemma is this angle, which lies upstream of the step.

## Hypothesis inventory

- H1: $\varphi\in[0,0.5748]$. Stated in the step.
- H2: $\psi$ is the displayed quotient. Stated in the context. Its denominator is positive on the interval (section 1), so $\psi$ is well defined there.
- Nothing else is used. In particular the step uses neither $\alpha\le1/3$, nor $\gamma_V\le m$, nor the first-variation condition. Those feed the inequality $m\le\psi(\varphi)$, which is the previous step.

## 1. Signs on the interval

Since $\pi>3$, $0.5748<1.5<\pi/2$. So on $[0,0.5748]$ one has $s\in[0,1)$, $c=\sqrt{1-s^2}>0$, and $1-s^3>0$. Also $\sin$ is strictly increasing on $[0,\pi/2]$.

## 2. The exact reduction (claim 1)

Because $1-s^3>0$, $\psi\le1\iff c\le1-s^3$. Both sides are non-negative, so this is equivalent to $c^2\le(1-s^3)^2$, that is $1-s^2\le1-2s^3+s^6$, that is
$$0\le s^2-2s^3+s^6=s^2(s^4-2s+1).$$
The quartic factors as $s^4-2s+1=(s-1)(s^3+s^2+s-1)$. Expanding the right side gives $s^4+s^3+s^2-s-s^3-s^2-s+1=s^4-2s+1$. This factorisation is also kernel-checked as quartic_factors in [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean). Hence
$$\psi(\varphi)\le1\iff s^2(1-s)\,(1-s-s^2-s^3)\ge0.$$
For $s\in[0,1)$ the factor $1-s$ is positive and $s^2\ge0$. So the condition holds at $s=0$ and, for $s\in(0,1)$, holds exactly when $g(s)\le0$. The function $g$ is strictly increasing on $s\ge0$ (its derivative $3s^2+2s+1$ is positive), with $g(0)=-1<0<2=g(1)$, so it has exactly one root $s^*\in(0,1)$ and $g(s)\le0\iff s\le s^*$ on $[0,1)$. Since $s^*>0$, the case $s=0$ is included in $s\le s^*$. Therefore on $[0,\pi/2)$, $\psi(\varphi)\le1\iff\sin\varphi\le s^*$, with equality in $\psi=1$ exactly at $s\in\{0,s^*\}$. Claim 1 is CONFIRMED.

## 3. A lower bound for $s^*$ (claims 2 and 3)

I show $g(0.54368)<0$, which by monotonicity gives $s^*>0.54368$.

- $54368^2=(54000+368)^2=2916000000+39744000+135424=2955879424$, so $0.54368^2=0.2955879424$ exactly.
- $0.54368^3=0.2955879424\times0.54368<0.29559\times0.54368$, and $29559\times54368=29559\times54000+29559\times368=1596186000+10877712=1607063712$, so $0.54368^3<0.1607063712$.
- Then $g(0.54368)<0.1607063712+0.2955879424+0.54368-1=0.9999743136-1=-0.0000256864<0$.

So $s^*>0.54368>0.5436$. The upper end $s^*<0.5437$ is bracket_upper in [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean), a norm_num certificate that $g(5437/10000)>0$, and the same file certifies the tighter $s^*>0.5436890$. Claim 2 is CONFIRMED. The hand bound above is independent of the Lean file and is the one used below.

## 4. An upper bound for $\sin(0.5748)$ (claim 3)

For every real $x\ge0$, $\sin x\le x-\tfrac{x^3}6+\tfrac{x^5}{120}$. This is standard: integrating $\cos t\le1$ from $0$ gives $\sin x\le x$, integrating again gives $\cos x\ge1-x^2/2$, then $\sin x\ge x-x^3/6$, then $\cos x\le1-x^2/2+x^4/24$, then the stated bound. Take $x=0.5748$.

- $5748^2=(5700+48)^2=32490000+547200+2304=33039504$, so $x^2=0.33039504$.
- $33039504\times5748=165197520000+23127652800+1585896192=189911068992$, so $x^3=0.189911068992$ and $x^3/6=0.031651844832$ (as $6\times31651844832=189911068992$).
- $x^5=x^3x^2<0.18992\times0.3304$, and $18992\times3304=62749568$, so $x^5<0.062749568<0.06276$ and $x^5/120<0.000523$.

Hence $\sin(0.5748)<0.5748-0.031651844832+0.000523=0.543671155168<0.54368<s^*$. With section 2 and the monotonicity of $\sin$ from section 1, this is claim 3, CONFIRMED, with margin $s^*-\sin(0.5748)>0.54368-0.543671155168>8.8\times10^{-6}$.

## 5. Shape of $\psi$ (claims 4 and 5)

$\dfrac{d}{d\varphi}\big(c/(1-s^3)\big)$ has numerator $-s(1-s^3)+3s^2c^2=-s+s^4+3s^2(1-s^2)=s(-1+3s-2s^3)$ over the positive denominator $(1-s^3)^2$, and $-2s^3+3s-1=(1-s)(2s^2+2s-1)$ (expand: $2s^2+2s-1-2s^3-2s^2+s$). So on $(0,\pi/2)$ the sign of $\psi'$ is the sign of $2s^2+2s-1$, which is negative for $s<\tfrac{\sqrt3-1}2$ and positive after. Therefore $\psi$ strictly decreases from $\psi(0)=1$ to its minimum at $\sin\varphi=\tfrac{\sqrt3-1}2$ and strictly increases afterwards. Claim 4 is CONFIRMED AS ALGEBRA. The exact minimum value is $\sqrt{\sqrt3/2}\cdot\dfrac{4}{9-3\sqrt3}$ (from $s_0^2=\tfrac{2-\sqrt3}2$, $c_0^2=\tfrac{\sqrt3}2$, $s_0^3=\tfrac{3\sqrt3-5}4$). The seven-place decimals printed in the passage ($0.9785933$, $0.3747372$, $0.5748263$, $0.9999937$, $0.5436669$) are not arguments and nothing in the step rests on them, so I did not reproduce them. By section 2 the only point of $(0,\pi/2)$ where $\psi=1$ is $\arcsin s^*$, so it is the first crossing, and section 4 puts $0.5748$ strictly below it. Claim 5 is CONFIRMED.

## 6. The step, argued both ways

Direct proof. Let $\varphi\in[0,0.5748]$. By section 1, $\sin\varphi\le\sin(0.5748)$. By section 4 and section 3, $\sin(0.5748)<s^*$. By section 2, $\psi(\varphi)\le1$, with equality only at $\varphi=0$.

Second route, matching the wording "$\psi\le\psi(0)=1$". By section 5, $\psi$ on $[0,0.5748]$ is maximised at an endpoint, and $\psi(0.5748)<1$ by sections 2 to 4. So $\max_{[0,0.5748]}\psi=\psi(0)=1$, which is the sentence as written.

Attempted refutation. A failure would need either a sign error in the squaring (excluded because both $c$ and $1-s^3$ are positive on the interval), a second root of $g$ in $(0,1)$ (excluded by strict monotonicity), or $\sin(0.5748)>s^*$ (excluded by the exact bounds with margin above $8\times10^{-6}$). The only reading under which the radius fails is the chord reading of $d$, which changes which angle $\varphi$ the lemma feeds to $\psi$ and so belongs to the step before this one. As a statement about $\psi$ on the stated interval, no reading makes it fail.

## Verdict

**VALID.** For $\varphi\in[0,\pi/2)$, $\psi(\varphi)\le1$ is exactly $\sin\varphi\le s^*$ by the factorisation $s^2(1-s)(1-s-s^2-s^3)\ge0$, and $\sin(0.5748)<0.5436712<0.54368<s^*$ by the Taylor bound and $g(0.54368)<0$, both checked in exact integer arithmetic.
