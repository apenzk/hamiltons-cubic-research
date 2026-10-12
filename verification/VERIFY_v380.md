# Verifier v380, the six printed decimals of Lemma L20's radius paragraph and chord remark (step G3)

Cold brief ([ADJ_L20r2_G3.md](ADJ_L20r2_G3.md)). No numerical work in the sense of the brief: no scripts were written and nothing was run. Every quantity below is given in exact closed form, and every comparison that decides a verdict is reduced to an exact inequality between rationals (integer squares, or a Taylor polynomial with a remainder of known sign) that a reader can check by hand. Log: [agent_logs/verify-L20-v380.log](../agent_logs/verify-L20-v380.log).

| # | Printed claim | Exact quantity | Verdict |
|---|---|---|---|
| 1 | minimum of $\psi$ is $0.9785933$ | $\psi_{\min}=\sqrt{(12+8\sqrt3)/27}\in(0.97859315,\,0.97859325)$ | REFUTED AS STATED (seventh digit is 2, the printed value is an upward rounding) |
| 2 | attained at $\varphi=0.3747372$ | $\varphi_c=\arcsin\frac{\sqrt3-1}2\in(0.374734,\,0.374736)$ | REFUTED (wrong at the sixth decimal, true value $0.3747344$) |
| 2a | attained at $\sin\varphi=\frac{\sqrt3-1}2$ | stationary-point equation $s(1-s)(2s^2+2s-1)=0$ | CONFIRMED |
| 3 | first crossing of $\psi=1$ at $\varphi=0.5748263$ | $\varphi^*=\arcsin s^*$, $s^{*3}+s^{*2}+s^*=1$ | CONFIRMED (value), not supported by the passages to that precision |
| 4 | $\psi(0.5748)=0.9999937$ | $\cos(0.5748)/(1-\sin^3 0.5748)$ | CONFIRMED (value), no argument in the passages |
| 5 | chord $0.5748$ is the angle $0.5830224$ | $d_0=2\arcsin(0.2874)$ | CONFIRMED (value), no argument in the passages |
| 6 | $\psi=1.0020125$ there | $\psi(d_0)$ with $\cos d_0=0.83480248$ exactly | CONFIRMED (value), and $\psi(d_0)>1$ CONFIRMED exactly |

**Summary: the step FAILS as written, because two of the six printed values are wrong (the minimizer $0.3747372$ should be $0.3747344$, the minimum $0.9785933$ should be $0.9785932$) and four are bare decimals with no argument in the passages, while every load-bearing inequality of the lemma survives by exact argument.**

## 0. Conventions, fixed once

- $s=\sin\varphi$, $c=\cos\varphi$, $\psi(\varphi)=c/(1-s^3)$ on $[0,\pi/2)$, as in Passage A and in the Lean definition psi of Passage D.
- $s_c=\frac{\sqrt3-1}2$, $\varphi_c=\arcsin s_c$.
- $s^*$ is the unique real root of $s^3+s^2+s-1$ (unique because the derivative $3s^2+2s+1$ has negative discriminant), and $\varphi^*=\arcsin s^*$.
- $d$ is geodesic angle on the unit sphere, $\cos d=\langle X,Y\rangle$. The chord between unit vectors at angle $d$ is $\|X-Y\|=\sqrt{2-2\cos d}=2\sin(d/2)$, so a chord of length $0.5748$ corresponds to the angle $d_0=2\arcsin(0.2874)$.
- "Correct as printed" is read as: the printed decimal is the true value rounded to the number of places shown. The alternative reading "a valid one-sided bound" is examined wherever it changes a verdict.
- Rational bounds used for $\sqrt3$: $1.7320508^2=2.99999997378064<3<3.0000000084216561=1.73205081^2$.
- Taylor bounds used, valid for all $y\ge0$ by repeated integration of $\cos y\le1$: $y-\frac{y^3}6+\frac{y^5}{120}-\frac{y^7}{5040}\le\sin y\le y-\frac{y^3}6+\frac{y^5}{120}$.

## 1. Hypothesis inventory

- H1. $\psi$ is the function defined in Passage A, $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$, on $0\le\varphi<\pi/2$. Needed for all six items.
- H2. The printed decimals are rounded to the places shown (reading of "correct as printed"). Needed for items 1 to 6. Under the weaker reading "an outward bound", item 1 survives and item 2 still fails.
- H3. "Read as a chord" means that $0.5748$ is the Euclidean distance $\|W^*-Y\|$ between unit vectors, so the angle is $2\arcsin(0.5748/2)$. Needed for items 5 and 6. This is the only reading under which the chord remark has content, and it is the one [conventions.md](../findings/conventions.md) line 81 names.
- H4. "Supported by an argument in the passages" means a derivation or certificate appears in Passages A to D. Needed for the second half of the step.

## 2. The shape of $\psi$, exact

Differentiating, $\psi'(\varphi)=\dfrac{-s(1-s^3)+3s^2c^2}{(1-s^3)^2}=\dfrac{-s+3s^2-2s^4}{(1-s^3)^2}=\dfrac{s(1-s)(2s^2+2s-1)}{(1-s^3)^2}$, using $c^2=1-s^2$ and $2s^3-3s+1=(s-1)(2s^2+2s-1)$.

- On $0<s<1$ the sign of $\psi'$ is the sign of $2s^2+2s-1$, whose positive root is $s_c=\frac{-1+\sqrt3}2$.
- So $\psi$ decreases strictly on $[0,\varphi_c]$ from $\psi(0)=1$ and increases strictly on $[\varphi_c,\pi/2)$ to $+\infty$. The minimum is at $\sin\varphi=\frac{\sqrt3-1}2$, which confirms item 2a.
- Hence $\psi<1$ exactly on $(0,\varphi^*)$, where $\varphi^*$ is the unique zero of $\psi-1$ in $(\varphi_c,\pi/2)$. Passage A's factorization $1-s^2\le(1-s^3)^2\iff s^2(1-s)(1-s-s^2-s^3)\ge0$ is correct (expand: $(1-s^3)^2-(1-s^2)=s^2-2s^3+s^6=s^2(s-1)(s^3+s^2+s-1)$), so $\varphi^*=\arcsin s^*$. "First exceeds 1 at $\varphi^*$" is correct in this sense.

## 3. Item 1, the minimum value

**Closed form.** With $s_c=\frac{\sqrt3-1}2$: $s_c^2=\frac{2-\sqrt3}2$, $c^2=\frac{\sqrt3}2$, $s_c^3=\frac{3\sqrt3-5}4$, $1-s_c^3=\frac{3(3-\sqrt3)}4$. Therefore
$$\psi_{\min}^2=\frac{\sqrt3/2}{9(3-\sqrt3)^2/16}=\frac{8\sqrt3}{9(12-6\sqrt3)}=\frac{4\sqrt3}{27(2-\sqrt3)}=\frac{4\sqrt3(2+\sqrt3)}{27}=\frac{12+8\sqrt3}{27}.$$

**Upper certificate, $\psi_{\min}<0.97859325$.** Exactly, $97859325^2=9576447489455625$, so $27\cdot0.97859325^2-12=13.8564082215301875$. And $138564082^2=19200004820502724$, so $13.8564082^2=192.00004820502724>192=(8\sqrt3)^2$. Hence $8\sqrt3<13.8564082<27\cdot0.97859325^2-12$, that is $\psi_{\min}^2<0.97859325^2$.

**Lower certificate, $\psi_{\min}>0.97859315$.** Exactly, $97859315^2=9576445532269225$, so $27\cdot0.97859315^2-12=13.8564029371269075<13.856403$. And $13856403^2=191999904098409$, so $13.856403^2=191.999904098409<192$. Hence $27\cdot0.97859315^2-12<8\sqrt3$.

**Consequence.** $\psi_{\min}\in(0.97859315,0.97859325)$, so the seven-place rounding is $0.9785932$, and the printed $0.9785933$ is wrong in its last digit. Arguing the opposite: $0.9785933$ is a true upper bound for $\psi_{\min}$, so under an "outward-rounded" reading it is acceptable, and nothing in the lemma uses the value (the proof only needs $\psi\le1$ on $[0,0.5748]$, which §2 and Passage A's reduction deliver without it). As a printed value it is incorrect. **REFUTED AS STATED.**

## 4. Item 2, where the minimum is attained

**Closed form.** $\varphi_c=\arcsin\frac{\sqrt3-1}2$, and Passage A itself writes this closed form next to the decimal.

**Upper certificate, $\varphi_c<0.374736$.** Let $y=0.374736$. Exactly $y^2=0.140427069696$ and $y^3=0.052623078389600256$ (from $140427069696\cdot374736=52623078389600256$), so $y^3/6=0.008770513064933376$. Then $y^5=y^3y^2>0.052623\cdot0.140427>0.0073896$, so $y^5/120>0.00006158$, and $y^7=y^5y^2<0.0074\cdot0.1405<0.0010397$, so $y^7/5040<0.0000002063$. The lower Taylor bound gives
$$\sin y>0.374736-0.008770513064933376+0.00006158-0.0000002063>0.3660268.$$
And $s_c<\frac{1.73205081-1}2=0.366025405<0.3660268$. Since $\sin$ increases on $[0,\pi/2]$, $\varphi_c<0.374736$.

**Lower certificate, $\varphi_c>0.374734$.** Let $y=0.374734$. Exactly $y^2=0.140425570756$ and $y^3=0.052622235831679...$ (from $140425570756\cdot374734$), so $y^3/6>0.0087703726$. And $y^5<0.0526223\cdot0.1404256<0.00738952$, so $y^5/120<0.0000615794$. The upper Taylor bound gives $\sin y<0.374734-0.0087703726+0.0000615794=0.3660252068<0.3660254=\frac{1.7320508-1}2<s_c$. Hence $\varphi_c>0.374734$.

**Consequence.** $\varphi_c\in(0.374734,0.374736)$, and the printed $0.3747372$ lies outside this interval by more than $1.2\times10^{-6}$. It is wrong at the sixth decimal (true value $0.3747344$ to seven places, from the arcsine series $\arcsin x=x+\frac{x^3}6+\frac{3x^5}{40}+\dots$ at $x=s_c$ with $s_c^3=\frac{3\sqrt3-5}4$, $s_c^5=\frac{11\sqrt3-19}8$, $s_c^7=\frac{41\sqrt3-71}{16}$, $s_c^9=\frac{153\sqrt3-265}{32}$).

**Arguing the opposite.** No reading rescues it. The printed number disagrees with the closed form printed beside it, in the same sentence. It is not the angle whose chord is $\varphi_c$ (that is about $0.3769$), nor the chord of $\varphi_c$ (about $0.3725$), nor $\arctan s_c$ (about $0.351$). It cannot be an artefact of the flat minimum either: $\psi''(\varphi_c)=\frac{(-1+6s_c-8s_c^3)\,c}{(1-s_c^3)^2}$ is about $0.83$, so an error of $2.8\times10^{-6}$ in location changes $\psi$ by about $3\times10^{-12}$, which is why a value accurate to eight digits can coexist with a location wrong at the sixth. The location is decorative in the proof, so the error is harmless to the lemma, but the printed value is false under either reading of H2 (it is not an outward bound of anything the lemma uses). **REFUTED.**

## 5. Item 3, the crossing $\varphi^*=0.5748263$

**Exact reduction.** §2 gives $\varphi^*=\arcsin s^*$ exactly. Passage D's bracket_tight kernel-checks $s^*\in(0.5436890,0.5436891)$. Pushed through $\arcsin$ this pins $\varphi^*$ only to an interval of width about $1.2\times10^{-7}$, namely about $(0.57482628,0.57482640)$, which straddles the rounding boundary $0.57482635$. **So the passages do not support the seventh digit.**

**Value.** The cubic at $0.543689$ is $0.1607132335305918+0.295597728721+0.543689-1=-3.77484082\times10^{-8}$ (exact products), its derivative there is $2.974171186163$, and the second derivative is below $6$, so one Newton step places $s^*=0.5436890126921$ to within $10^{-15}$. The sine at $a=0.5748$ from the alternating series through $y^{13}$, whose first two dominant terms are exact ($a^3=0.189911068992$), is $\sin a=0.5436669413476$ and $\cos a=0.8393010525940$, each to within $10^{-12}$. Solving $\sin(a+h)=s^*$ to second order gives $h=2.62975\times10^{-5}$, so $\varphi^*=0.57482630$ to eight places, with distance about $4.7\times10^{-8}$ to the nearer rounding boundary against an arithmetic error below $10^{-11}$. The printed $0.5748263$ is correct, and $0.5748<\varphi^*$ confirms "truncated in the safe direction". **CONFIRMED** as a value, unsupported by the passages at seven places.

## 6. Item 4, $\psi(0.5748)=0.9999937$

With $\sin a$ and $\cos a$ as in §5, $\sin^2a=0.295573743119$, $\sin^3a=0.160693672865$, $1-\sin^3a=0.839306327135$, and $\psi(a)=1-\frac{0.839306327135-0.839301052594}{0.839306327135}=1-6.28442\times10^{-6}=0.99999371558$. The rounding boundaries are $0.99999365$ and $0.99999375$, each more than $3\times10^{-8}$ away. **CONFIRMED** as a value. The passages give no computation of it. What they do support exactly is the qualitative $\psi(0.5748)<1$, via $\sin(0.5748)<0.543672<0.5436890<s^*$ and §2.

## 7. Items 5 and 6, the chord remark

**Item 5.** Under H3, $d_0=2\arcsin(0.2874)$. The arcsine series at $x=0.2874$ with $x^2=0.08259876$ and $x^3=0.023738883624$ exact gives $\arcsin x=0.29151120398808$ (terms through $x^{23}$, tail below $10^{-15}$), so $d_0=0.58302240798$. The boundaries $0.58302235$ and $0.58302245$ are each more than $4\times10^{-8}$ away. **CONFIRMED.**

**Item 6, qualitative part, exact.** $\cos d_0=1-2(0.2874)^2=0.83480248$ exactly, and $\sin^2d_0=1-0.83480248^2=0.3031048193858496$ exactly (from $83480248^2=6968951806141504$). Since $s^*<0.5436891$ and $0.5436891^2=0.29559783740881<0.3031048193858496$, one has $\sin d_0>s^*$, so $d_0>\varphi^*$ and $\psi(d_0)>1$ by §2. This is a closed-form proof of the remark's load-bearing content, "$\psi>1$ there and the argument reaches no contradiction", which the passages assert but do not prove.

**Item 6, the printed value.** $\sin d_0=\sqrt{0.3031048193858496}=0.550549561243899$ (check: $0.5505495612^2=0.30310481933751254544$, short by $4.834\times10^{-11}$). Then $\sin^3d_0=0.16687422532379$, $1-\sin^3d_0=0.83312577467621$, and $\psi(d_0)=1+\frac{0.00167670532379}{0.83312577467621}=1.00201254765$. At the printed angle $0.5830224=d_0-7.98\times10^{-9}$, with $\psi'(d_0)=\frac{-s+3s^2-2s^4}{(1-s^3)^2}\approx0.252$, $\psi(0.5830224)=1.00201254564$. Both round to $1.0020125$. The margin to the boundary $1.00201255$ is about $2.3\times10^{-9}$ at $d_0$ and $4.4\times10^{-9}$ at the printed angle, against an arithmetic error below $10^{-12}$ in the chain above (every product was carried to at least 14 significant digits). **CONFIRMED** as a value, with the caveat that this margin is thin and the passages give no computation of it.

## 8. Is each value "supported by an argument in the passages"?

- Item 2a ($\sin\varphi=\frac{\sqrt3-1}2$): stated without derivation. It follows in two lines from $\psi'$ (§2), which is standard, so the reading "supported" is generous but defensible.
- Items 1 and 2: bare decimals. No derivation, no closed form for the value, and item 2 contradicts the closed form beside it.
- Item 3: the reduction to $s^*$ is argued exactly and the $s$-bracket is kernel-checked, but that bracket does not fix the seventh decimal of $\arcsin s^*$ (§5).
- Item 4: bare decimal. The passages support only $\psi(0.5748)<1$.
- Items 5 and 6: bare decimals. The qualitative claim $\psi(d_0)>1$ is not argued in the passages either, though §7 supplies an exact argument.
- A side observation within the quoted Passage D: sin_radius_le, the Lean form of $\sin(0.5748)\le0.54368$, is closed by sorry. The prose Taylor argument in Passage A is correct ($0.5748-\frac{0.189911068992}6+\frac{a^5}{120}=0.5436710358<0.543672$), so the inequality holds, but "kernel-checked" in Passage A covers only the $s^*$ bracket, which is what it says.

## 9. Verdict

**FAILS.** The step asserts that all six values are correct as printed and argued. Two are incorrect as printed:

- The minimizer is $\arcsin\frac{\sqrt3-1}2\in(0.374734,0.374736)$, so $0.3747372$ is wrong at the sixth decimal and should read $0.3747344$ (§4).
- The minimum is $\sqrt{(12+8\sqrt3)/27}\in(0.97859315,0.97859325)$, so $0.9785933$ is wrong in the seventh digit and should read $0.9785932$ (§3). It is a valid upper bound.

The other four ($0.5748263$, $0.9999937$, $0.5830224$, $1.0020125$) are correct to the places shown, but none is supported to that precision by an argument in the passages.

**What a VALID repaired reading needs, and what survives.** Replace the two decimals by their closed forms (or by $0.3747344$ and $0.9785932$), and read the remaining four as illustrative values. Under H1 and H3 every inequality the lemma actually uses holds exactly:

- $\psi\le1$ on $[0,0.5748]$, by §2 and Passage A's reduction with $\sin(0.5748)<0.543672<s^*$.
- $0.5748<\varphi^*$.
- $\psi>1$ at the chord angle $2\arcsin(0.2874)$, by $\sin^2d_0=0.3031048193858496>0.5436891^2>s^{*2}$ (§7).

The errors are therefore confined to decorative decimals and do not touch the tube exclusion.
