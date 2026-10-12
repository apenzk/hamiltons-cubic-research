# Verifier v379, the six decimals of Lemma L20's radius paragraph and chord remark (step G3)

*Cold brief [ADJ_L20r2_G3.md](ADJ_L20r2_G3.md). No numerical work in the sense of the brief: no scripts written, nothing run. Every value is fixed by an exact closed form, and every decimal claim below is settled by a finite rational inequality checkable by hand (squares of terminating decimals, Taylor polynomials with the sign of the remainder known). Log: [agent_logs/verify-L20-v379.log](../agent_logs/verify-L20-v379.log).*

| # | Claim | Exact object | Verdict |
|---|---|---|---|
| 1 | the minimum of $\psi$ is $0.9785933$ | $\psi_{\min}=\sqrt{(12+8\sqrt3)/27}\in(0.97859315,\,0.97859325)$ | REFUTED AS STATED (last digit high by one, correct as an upper rounding) |
| 2 | it is attained at $\sin\varphi=\tfrac{\sqrt3-1}2$ | root of $2s^2+2s-1$ | CONFIRMED |
| 3 | that is $\varphi=0.3747372$ | $\varphi_0=\arcsin\tfrac{\sqrt3-1}2\in(0.37473,\,0.3747348)$ | REFUTED (true value $0.3747344\ldots$) |
| 4 | first crossing of $\psi=1$ at $0.5748263$ | $\varphi^*=\arcsin s^*$, $s^{*3}+s^{*2}+s^*=1$ | CONFIRMED |
| 5 | $\psi(0.5748)=0.9999937$ | $\cos(0.5748)/(1-\sin^3 0.5748)$ | CONFIRMED |
| 6 | chord $0.5748$ is the angle $0.5830224$ | $2\arcsin(0.2874)$ | CONFIRMED |
| 7 | $\psi=1.0020125$ there | $C/(1-(1-C^2)^{3/2})$, $C=0.83480248$ exactly | CONFIRMED (thin rounding margin, stated) |
| 8 | each value is supported by an argument in the passages | | REFUTED: the passages argue the closed forms of 2 and 4 and the inequality $\psi\le1$ on $[0,0.5748]$, and no decimal |
| 9 | the errors in 1 and 3 reach Lemma L20 | | REFUTED: the proof uses only $\psi\le1$ on $[0,0.5748]$, which holds exactly |

**Summary: the step FAILS as written, since $0.3747372$ is wrong in its sixth decimal (true $0.3747344$), $0.9785933$ is one unit high in its seventh, and none of the six decimals carries an argument in the passages. Nothing load-bearing for L20 is affected.**

## 0. Conventions, fixed once

- $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$ on $[0,\pi/2)$, as in Passage A and the Lean definition psi in [L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean).
- $s=\sin\varphi$, $c=\cos\varphi$. On $[0,\pi/2)$ the map $\varphi\mapsto s$ is an increasing bijection onto $[0,1)$, so statements in $s$ transfer to $\varphi$ with order preserved.
- $d$ is geodesic angle on the unit sphere, $\cos d=\langle X,Y\rangle$. The chord is $\|X-Y\|=\sqrt{2-2\cos d}=2\sin(d/2)$.
- "Correct as printed" for a 7-place decimal $x$ is read first as: the true value rounds to $x$, i.e. lies in $[x-5\cdot10^{-8},\,x+5\cdot10^{-8})$. The weaker reading "within one unit of the last place" is also reported where it changes a verdict.
- $s^*$ is the unique real root of $f(s)=s^3+s^2+s-1$, unique because $f'(s)=3s^2+2s+1>0$, and $f$ is convex on $s\ge0$ because $f''=6s+2>0$.

## 1. Hypothesis inventory

- H1. $d$ is geodesic angle (fixed by Passage A and the conventions copy). Needed only for reading claim 6 as a translation from chord to angle.
- H2. The decimals are 7-place roundings (Section 0). Claims 1 and 3 are judged under H2 and under the weaker one-unit reading.
- No hypothesis about $\mathrm{Weyl}_n$, $F_u$ or Lemma L21 enters: every claim in the step is a statement about the one-variable function $\psi$.

## 2. The shape of $\psi$ and the minimiser (claims 2 and 3)

Differentiating, $\psi'(\varphi)=\dfrac{-s(1-s^3)+3s^2c^2}{(1-s^3)^2}=\dfrac{-s+3s^2-2s^4}{(1-s^3)^2}$ after $c^2=1-s^2$. The numerator is $-s(2s^3-3s+1)=-s(s-1)(2s^2+2s-1)$, so $\psi'(\varphi)=\dfrac{s(1-s)(2s^2+2s-1)}{(1-s^3)^2}$.

For $0<s<1$ the sign is that of $2s^2+2s-1$, whose positive root is $s_0=\tfrac{\sqrt3-1}2$. So $\psi$ strictly decreases on $[0,\varphi_0]$ and strictly increases on $[\varphi_0,\pi/2)$, with $\varphi_0=\arcsin s_0$. Claim 2 is CONFIRMED.

Claim 3 is a decimal for $\varphi_0$. Put $x=0.3747372$. Then $x^2=0.14042796906$ (exact to the digits shown, from $0.3747^2=0.14040009$), $x^3=0.052623583927\ldots$, $x^5=0.0073898230\ldots$, $x^7=0.00103774\ldots$. For $x\ge0$ the alternating Taylor bound gives $\sin x\ge x-\tfrac{x^3}6+\tfrac{x^5}{120}-\tfrac{x^7}{5040}$, and the right side is $0.3747372-0.0087705973+0.0000615819-0.0000002059=0.36602798$ to the places shown, so $\sin x>0.366027$.

On the other side, $1.7320509^2=3.00000032\ldots>3$, so $\sqrt3<1.7320509$ and $s_0<0.36602545$. Hence $\sin(0.3747372)>s_0$ with a margin above $2.5\cdot10^{-6}$. Since $\sin$ is 1-Lipschitz, $\sin(0.3747372-\delta)>s_0$ for every $\delta\le2.5\cdot10^{-6}$, so $\varphi_0<0.3747348$.

For a lower bound, $1.7320508^2=2.99999997378064<3$ gives $s_0>0.3660254$. The upper Taylor bound adds $x^9/362880<10^{-9}$, so $\sin(0.3747372)<0.3660282$, and with $\cos\ge0.92$ on $[0,0.375]$ one gets $\sin(0.37473)<0.3660282-0.92\cdot7.2\cdot10^{-6}<0.366022<s_0$, so $\varphi_0>0.37473$.

So $\varphi_0\in(0.37473,\,0.3747348)$, and the series $\arcsin s_0=s_0+\tfrac{s_0^3}6+\tfrac{3s_0^5}{40}+\tfrac{5s_0^7}{112}+\cdots$ summed through $s_0^{19}$ gives $\varphi_0=0.37473443\ldots$. The printed $0.3747372$ exceeds it by about $2.8\cdot10^{-6}$, 28 units of the last place, and fails under either reading of H2.

*Arguing the opposite.* The passage writes "at $\sin\varphi=\tfrac{\sqrt3-1}2$, i.e. $\varphi=0.3747372$", so the decimal is offered as the arcsine of that exact number and no other variable is in play. The obvious alternative readings do not produce it: the chord of $\varphi_0$ is $2\sin(\varphi_0/2)\approx0.3725$, and the angle whose chord is $\varphi_0$ is $2\arcsin(\varphi_0/2)\approx0.3769$. Claim 3 is REFUTED.

## 3. The minimum value (claim 1)

At $s_0$: $s_0^2=\tfrac{2-\sqrt3}2$, so $c_0^2=\tfrac{\sqrt3}2$, and $s_0^3=\tfrac{(\sqrt3-1)^3}8=\tfrac{6\sqrt3-10}8=\tfrac{3\sqrt3-5}4$, so $1-s_0^3=\tfrac{3(3-\sqrt3)}4$. Then
$$\psi_{\min}^2=\frac{\sqrt3/2}{\tfrac9{16}(3-\sqrt3)^2}=\frac{8\sqrt3}{9(12-6\sqrt3)}=\frac{4\sqrt3}{27(2-\sqrt3)}=\frac{4\sqrt3(2+\sqrt3)}{27}=\frac{12+8\sqrt3}{27},$$
equivalently $\psi_{\min}=\sqrt2(\sqrt3+1)/3^{5/4}$.

Upper bound: $1.732051^2=3.000000666601>3$, so $12+8\sqrt3<25.856408$. And $0.97859325^2=(0.9786-0.00000675)^2=0.95765796-0.0000132111+0.0000000000455625=0.9576447489455625$, whose product with $27$ is $25.8564082215301875>25.856408$. So $\psi_{\min}<0.97859325$.

Lower bound: $\sqrt3>1.7320508$ gives $12+8\sqrt3>25.8564064$, and $27\cdot0.97859315^2=27\cdot0.9576445532269225=25.85640293712\ldots<25.8564064$. So $\psi_{\min}>0.97859315$.

Hence $\psi_{\min}\in(0.97859315,\,0.97859325)$, and it rounds to $0.9785932$ (its value is $0.97859321\ldots$). The printed $0.9785933$ is one unit high in the seventh place. Under the rounding reading claim 1 is REFUTED AS STATED. Under the one-unit reading, or read as an upper rounding, it holds, since $0.9785933-\psi_{\min}<10^{-7}$. The value plays no role in the proof, which needs only $\psi\le1$.

## 4. The crossing (claim 4)

Passage A's reduction is exact and I confirm it: for $0\le s<1$, $\psi\le1$ iff $1-s^2\le(1-s^3)^2$ iff $s^2(1-2s+s^4)\ge0$, and $1-2s+s^4=(1-s)(1-s-s^2-s^3)$ by expansion. So on $(0,1)$, $\psi\le1$ iff $s\le s^*$, with equality iff $s=s^*$. Since $\psi(0)=1$ and $\psi$ dips below 1 on $(0,\varphi^*)$, the first return to $1$ is $\varphi^*=\arcsin s^*$, and $\psi>1$ on $(\varphi^*,\pi/2)$.

Bracketing $s^*$ beyond the Lean bracket: $0.543689^2=0.295597728721$ and $0.543689^3=0.1607132335\ldots$, so $f(0.543689)=-3.7748\ldots\cdot10^{-8}$, and $f'(0.543689)=2.97417\ldots$. Convexity gives $f(0.54368902)\ge f(0.543689)+f'(0.543689)\cdot2\cdot10^{-8}>-3.78\cdot10^{-8}+5.94\cdot10^{-8}>0$, so $s^*\in(0.5436890,\,0.54368902)$, the left end from bracket_tight in [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean) together with cubic_strict_mono.

At $x=0.5748263$: $x^2=0.33042527517\ldots$, $x^3=0.18993713835\ldots$, $x^5=0.0627600312\ldots$, $x^7=0.0207375006\ldots$, $x^9=0.006852194\ldots$. The Taylor polynomials give $\sin x\in[0.5436889959,\,0.5436890149]$, the lower end through $x^7$ and the upper through $x^9$. Moving the argument by $5\cdot10^{-8}$ moves $\sin$ by more than $0.839\cdot5\cdot10^{-8}>4.1\cdot10^{-8}$ in the same direction, since $\cos>0.839$ there. So $\sin(0.57482635)>0.5436889959+4.1\cdot10^{-8}>0.54368903>s^*$ and $\sin(0.57482625)<0.5436890149-4.1\cdot10^{-8}<0.5436890<s^*$. Hence $\varphi^*\in(0.57482625,\,0.57482635)$, which rounds to $0.5748263$ ($\varphi^*=0.57482630\ldots$). Claim 4 is CONFIRMED.

The passages do not carry this decimal: the Lean bracket $s^*\in(0.5436890,0.5436891)$ gives only $\varphi^*\in(0.5748262,\,0.5748265)$ after the arcsine, an interval of width about $1.2\cdot10^{-7}$ that straddles the rounding boundary $0.57482635$, and no arcsine step appears in the passages.

## 5. The value at the stated radius (claim 5)

At $x=0.5748$: $x^2=0.33039504$ exactly, and the Taylor polynomials give $\sin x=0.5436669413\ldots$ and $\cos x=0.8393010526\ldots$, each enclosed to within $10^{-10}$ by the next omitted term ($x^{11}/11!<6\cdot10^{-11}$, $x^{12}/12!<3\cdot10^{-12}$). Consistency check: $\sin^2x+\cos^2x$ evaluates to $1$ within $10^{-10}$.

Then $\sin^3x=0.1606936728\ldots$, $1-\sin^3x=0.8393063272\ldots$, and $\psi(0.5748)=1-\dfrac{0.8393063272-0.8393010526}{0.8393063272}=1-6.2845\cdot10^{-6}=0.99999371\ldots$. The enclosure errors move this by under $10^{-9}$, while the distance to the rounding boundaries $0.99999365$ and $0.99999375$ exceeds $3\cdot10^{-8}$. An independent check agrees: $\psi(\varphi^*)=1$, and $\psi'(\varphi^*)=\dfrac{s^*(1-s^*)(2s^{*2}+2s^*-1)}{(1-s^{*3})^2}=0.2390\ldots$, so $\psi(0.5748)\approx1-0.2390\cdot2.630\cdot10^{-5}=1-6.285\cdot10^{-6}$. Claim 5 is CONFIRMED. The passages support only $\psi(0.5748)\le1$ (via $\sin0.5748<0.543672<s^*$), not the value.

## 6. The chord remark (claims 6 and 7)

Under H1, a chord of length $0.5748$ corresponds to the angle $d$ with $2\sin(d/2)=0.5748$, i.e. $d=2\arcsin(0.2874)$, and $\cos d=1-\tfrac{0.5748^2}2=0.83480248$ exactly. The arcsine series with $0.2874^2=0.08259876$ exactly and $0.2874^3=0.023738883624$ exactly has positive terms decreasing geometrically with ratio below $0.0826$, and summed through the $s^{21}$ term gives $\arcsin(0.2874)=0.2915112039875\ldots$ with a tail below $10^{-14}$. So $d=0.58302240797\ldots$, which rounds to $0.5830224$ with margin $4\cdot10^{-8}$. Claim 6 is CONFIRMED.

For claim 7 put $C=0.83480248$, $S=\sqrt{1-C^2}$. Here $C^2=0.6968951806141504$ exactly, so $S^2=0.3031048193858496$ exactly and $S=0.55054956124390\ldots$ (its square reproduces $S^2$ to $2\cdot10^{-15}$). Then $S^3=0.16687422532379\ldots$.

The rounding test $\psi(d)<b:=1.00201255$ is equivalent to $bS^3<b-C$, i.e. $S^3<1-C/b$. With $1/b=0.99799149222233\ldots$ (alternating series in $0.00201255$), $1-C/b=0.166874227273845\ldots$. The difference is $1.95\cdot10^{-9}$, positive, against arithmetic error below $10^{-13}$. Stated without division, the inequality is $b^2(1-C^2)^3<(b-C)^2$, a rational inequality between terminating decimals. The lower test $\psi(d)\ge1.00201245$ holds with margin near $10^{-7}$. So $\psi(d)=1.00201254765\ldots$, which rounds to $1.0020125$.

If "there" means the printed angle $0.5830224$ rather than $d$: $\psi$ is increasing there (Section 2) with $\psi'<0.26$, and $d-0.5830224<8\cdot10^{-9}$, so $\psi(0.5830224)\in(1.0020125456,\,1.0020125477)$, which rounds to $1.0020125$ as well. Claim 7 is CONFIRMED under both readings. Its rounding margin is the thinnest in the step, $2.35\cdot10^{-9}$, and a reader re-deriving it needs about ten significant digits.

The qualitative content of the remark is also right: $d>\varphi^*$, so $\psi(d)>1$ by Section 4, and at chord radius $0.5748$ the bound $m\le\psi$ no longer yields $m\le1$.

## 7. What the passages argue, and what reaches L20 (claims 8 and 9)

- Argued in the passages: the reduction $\psi\le1\iff s\le s^*$, the Taylor bound $\sin(0.5748)<0.543672$ (I confirm it: $x-\tfrac{x^3}6+\tfrac{x^5}{120}=0.5436710358\ldots<0.543672$ at $x=0.5748$), the Lean inequality $0.5436890<s^*$, and the exact location $\sin\varphi_0=\tfrac{\sqrt3-1}2$ (asserted, and derivable as in Section 2).
- Not argued anywhere in the passages: the decimals $0.9785933$, $0.3747372$, $0.5748263$, $0.9999937$, $0.5830224$ and $1.0020125$. None has a derivation, and the Lean bracket is too coarse to fix the seventh place of $0.5748263$ (Section 4).
- Load-bearing for L20: only "$\psi\le1$ on $[0,0.5748]$". That follows from $\sin\varphi\le\sin0.5748<0.543672<0.5436890<s^*$ and the exact reduction, and it is independent of claims 1 and 3. The phrase "the stated radius is the true crossing truncated in the safe direction" is correct, since $0.5748<\varphi^*=0.57482630\ldots$.

## 8. Verdict

**FAILS.** The step as written asserts that all six values are correct as printed and supported by the passages. Two fail the first test in closed form: $\varphi_0=\arcsin\tfrac{\sqrt3-1}2\in(0.37473,0.3747348)$ against the printed $0.3747372$, and $\psi_{\min}=\sqrt{(12+8\sqrt3)/27}\in(0.97859315,0.97859325)$ against the printed $0.9785933$. All six fail the second, since the passages give no argument for any decimal.

The strongest reading that survives needs H1 and H2 and replaces two values. With $\varphi=0.3747344$ and $\psi_{\min}=0.9785932$ (or the exact forms $\arcsin\tfrac{\sqrt3-1}2$ and $\sqrt2(\sqrt3+1)/3^{5/4}$), and read as numerical remarks outside the proof, the step is correct: $0.5748263$, $0.9999937$, $0.5830224$ and $1.0020125$ are right to every printed place, with the derivations in Sections 4 to 6 supplying the arguments the passages omit. Lemma L20's proof is unaffected, because it uses only $\psi\le1$ on $[0,0.5748]$, which the passages prove exactly.
