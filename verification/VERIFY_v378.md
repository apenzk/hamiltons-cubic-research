# Verifier v378, step G2 of round L20-r2: L20 as its heading and detail entry state it, for every n at least 12

*Cold brief ([ADJ_L20r2_G2.md](ADJ_L20r2_G2.md)). No numerical work, no scripts written, no computations run. Every value used is exact: rational arithmetic by hand on the terminating decimal $0.5748=5748/10^4$, polynomial identities, and the Lean statements the brief quotes. Log: [agent_logs/verify-L20-v378.log](../agent_logs/verify-L20-v378.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | The three "further hypotheses" of Passage A (invariance of $d$, existence of a nearest orbit point with its first-variation condition, $\varphi>0$ on the non-degenerate branch) | CONFIRMED, all three are automatic |
| 2 | The expansion $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ is exact with no linear term | CONFIRMED AS ALGEBRA |
| 3 | $m\le\psi(\varphi)$ from $\alpha\le\frac13$ (Lemma L21, a given) and $\gamma_V\le m$ | CONFIRMED |
| 4 | $\psi\le1\iff s\le s^*$ for $0\le s<1$, with $s^*$ the real root of $s^3+s^2+s=1$ | CONFIRMED AS ALGEBRA |
| 5 | $\sin(0.5748)<s^*$ | CONFIRMED |
| 6 | Even $n\ge12$: the sphere product attains $\theta_0(n)>\theta^*$ | CONFIRMED |
| 7 | Detail entry at odd $n$: "contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains" | REFUTED AS STATED |
| 8 | Odd $n\ge13$: the best sphere product attains $\Theta_n>\theta^*$, which carries the contradiction | CONFIRMED |
| 9 | The step: L20 holds for every $n\ge12$ as the heading and detail entry state it | VALID |

**Summary: the lemma's statement holds for every $n\ge12$ given Lemma L21 as quoted, read with "maximizer" as global maximizer, while the detail entry's proof sentence names the wrong witness value at odd $n$ and must cite $\Theta_n$ there.**

## 0. Conventions, fixed once

- $\mathcal W_n$ carries the Frobenius inner product, $SO(n)$ acts on it orthogonally by conjugation, and $\mathcal O=SO(n).u$ with $u=W_{\mathbb{CP}^2}$ padded, $|u|=1$, $Q(u)=\theta^*u$, $\theta^*=\sqrt{3/2}$.
- $d$ is geodesic angular distance on the unit sphere $S\subset\mathcal W_n$, $\cos d(X,Y)=\langle X,Y\rangle$, $d\in[0,\pi]$.
- $m=\sqrt{2/3}\,\max_S P$, so $m\le1\iff\max_SP\le\theta^*$.
- $s=\sin\varphi$, $c=\cos\varphi$, $\psi(\varphi)=c/(1-s^3)$, and $s^*$ is the unique real root of $s^3+s^2+s-1$.
- $\Theta_n$ is the value of the best two-factor sphere product, $\theta_0(n)$ at even $n$ and $\Theta_n^2=\frac{2(n-1)(n-3)}{(n-2)(n+1)}$ at odd $n$, as the brief defines it.

## Hypothesis inventory

- **H1 (given).** Lemma L21 as quoted in Passage B: $\alpha\le\frac13$ for every unit $V\in u^\perp\cap T_u\mathcal O^\perp$, at every $n\ge9$. The brief makes it a given, and the landscape entry records that it carries an unproved input. The VALID verdict inherits that debt.
- **H2 (standard).** $\langle X,Y\#Z\rangle$ is fully symmetric in $X,Y,Z$, and $\langle X,YZ\rangle=\mathop{\mathrm{tr}}(XYZ)$ is fully symmetric on symmetric operators. This is the Böhm–Wilking structure behind $P$ and its polarisation $T$.
- **H3 (given).** The sphere-product values $\Theta_n$ of the Definitions, each attained by a unit Weyl operator.
- **H4 (reading).** "Maximizer" means global maximizer of $P$ on $S$. The bootstrap $\gamma_V\le m$ uses exactly this, and the argument says nothing about local maximizers or other critical points.
- **H5 (written).** "Angular distance" is the geodesic distance of Section 0. The landscape entry says "geodesic angular", the detail entry says "angular", and both fix the reading.

Nothing else is needed. In particular Passage A's three "further hypotheses" are consequences, shown in Section 1.

## 1. The three further hypotheses are automatic

- **Invariance.** Each $g\in SO(n)$ acts orthogonally on $\mathcal W_n$, so $\langle gX,gY\rangle=\langle X,Y\rangle$ and $d(gX,gY)=d(X,Y)$.
- **Nearest point and first variation.** $d(W^*,g.u)=\arccos\langle W^*,g.u\rangle$ is minimised exactly where $f(g)=\langle W^*,g.u\rangle$ is maximised. $f$ is continuous on the compact group $SO(n)$, so it attains its maximum at some $g_0$. Replacing $W^*$ by $g_0^{-1}W^*$ (still a global maximizer since $P$ is invariant, at the same distance from $\mathcal O$ by invariance) puts the nearest point at $u$. For every $X\in\mathfrak{so}(n)$, $t\mapsto\langle W^*,\exp(tX).u\rangle$ has a maximum at $t=0$, so $\langle W^*,X.u\rangle=0$. The vectors $X.u$ span $T_u\mathcal O$. This uses only compactness of the group and smoothness of the action, and needs no embedded-submanifold structure on $\mathcal O$ (which holds anyway, as an orbit of a compact group).
- **The decomposition.** Write $\varphi=d(W^*,u)\in[0,\pi]$. If $\varphi>0$ then $\sin\varphi>0$ (since $\varphi\le0.5748<\pi$) and $V:=(W^*-\cos\varphi\,u)/\sin\varphi$ is a unit vector orthogonal to $u$. Every $X.u$ is orthogonal to $u$ because $\langle u,X.u\rangle=\frac12\frac{d}{dt}|\exp(tX).u|^2\big|_{t=0}=0$. So $0=\langle W^*,X.u\rangle=\sin\varphi\,\langle V,X.u\rangle$ gives $V\perp T_u\mathcal O$. Hence $V\in u^\perp\cap T_u\mathcal O^\perp$, the domain of H1.
- **The branch $\varphi=0$.** Then $W^*=u$ and $m=\sqrt{2/3}\,P(u)=1$, which Sections 5 and 6 contradict directly.

## 2. The expansion is exact

By H2 the polarisation of $P(W)=\mathop{\mathrm{tr}}(W^3)+\langle W,W\#W\rangle$ is $T(X,Y,Z)=\mathop{\mathrm{tr}}(XYZ)_{\mathrm{sym}}+\langle X,Y\#Z\rangle_{\mathrm{sym}}$, and reading off coefficients of $P(u+tV)$:

- linear coefficient $3\mathop{\mathrm{tr}}(u^2V)+3\langle u\#u,V\rangle=3\langle Q(u),V\rangle$, so $T(u,u,V)=\langle Q(u),V\rangle=\theta^*\langle u,V\rangle=0$,
- quadratic coefficient $3\mathop{\mathrm{tr}}(uV^2)+\langle u,V\#V\rangle+2\langle V,u\#V\rangle=3\langle\frac12(uV+Vu)+u\#V,V\rangle$, so $T(u,V,V)=\langle F_uV,V\rangle$.

Cubic homogeneity then gives $P(cu+sV)=c^3P(u)+3c^2s\,T(u,u,V)+3cs^2\,T(u,V,V)+s^3P(V)$. Multiplying by $\sqrt{2/3}$ and using $\sqrt{2/3}\,P(u)=1$ yields Passage A's formula with $\alpha=\sqrt{2/3}\langle F_uV,V\rangle$ and $\gamma_V=\sqrt{2/3}\,P(V)$, with no remainder and no linear term.

## 3. The bootstrap inequality

- $0\le\varphi\le0.5748<\pi/2$ gives $c\ge0$ and $s\ge0$ (the Lean lemma trig_nonneg states the same, using $\pi>3$).
- H1 and $3cs^2\ge0$ give $3cs^2\alpha\le cs^2$.
- $V\in S$ and H4 give $\gamma_V\le m$, and $s^3\ge0$ gives $s^3\gamma_V\le s^3m$.
- $c^3+cs^2=c(c^2+s^2)=c$.

So $m\le c+s^3m$, and since $s\le s^*<1$ (Section 5) one has $1-s^3>0$ and $m\le\psi(\varphi)$. This is the content of max_le_one_of_sin_le in Passage D, whose hypotheses are exactly these.

## 4. The reduction of psi at most 1

With $c>0$ and $1-s^3>0$, $\psi\le1\iff c\le1-s^3\iff1-s^2\le(1-s^3)^2$. Expanding, $(1-s^3)^2-(1-s^2)=s^2-2s^3+s^6=s^2(s^4-2s+1)$, and $s^4-2s+1=(s-1)(s^3+s^2+s-1)$ (this is quartic_factors in TubeRadius.lean). So the difference is $s^2(1-s)(1-s-s^2-s^3)$. For $0\le s<1$ it is non-negative exactly when $s=0$ or $s^3+s^2+s\le1$, and since $s\mapsto s^3+s^2+s$ has derivative $3s^2+2s+1>0$, the latter is $s\le s^*$. The algebra is exactly as Passage A writes it.

As a side confirmation of Passage A's minimiser: $\frac{d\psi}{d\varphi}=\frac{-s(1-s^3)+3s^2c^2}{(1-s^3)^2}=\frac{-s(2s^3-3s+1)}{(1-s^3)^2}$, and $2s^3-3s+1=(s-1)(2s^2+2s-1)$ vanishes in $(0,1)$ only at $s=\frac{\sqrt3-1}2$. The decimals attached to it play no role in the step.

## 5. The radius lies inside the root

- **The Taylor bound.** For $x\ge0$, integrating $\sin t\le t$ repeatedly gives $\cos x\ge1-\frac{x^2}2$, then $\sin x\ge x-\frac{x^3}6$, then $\cos x\le1-\frac{x^2}2+\frac{x^4}{24}$, then $\sin x\le x-\frac{x^3}6+\frac{x^5}{120}$.
- **Exact rationals at $x=5748/10^4$.** $5748^2=33039504$ and $5748^3=189911068992$, so $x^3/6=0.031651844832$ exactly. Also $x^2=0.33039504<0.3304$ and $x^3<0.19$, so $x^5<0.19\cdot0.3304=0.062776$ and $x^5/120<0.000523134$. Hence $\sin(0.5748)<0.5748-0.031651844832+0.000523134=0.543671289168$.
- **The root.** bracket_tight in TubeRadius.lean gives $s^3+s^2+s-1<0$ at $s=0.5436890$, and cubic_strict_mono makes the cubic increasing on $[0,\infty)$, so $s^*>0.5436890$.
- **Monotonicity.** $\sin$ increases on $[0,\pi/2]\ni0.5748$, so $\sin\varphi\le\sin(0.5748)<0.543672<0.5436890<s^*$ on the whole tube.

So $\psi\le1$ on $[0,0.5748]$ and $m\le1$, that is $\max_SP\le\theta^*$ whenever some global maximizer lies in the tube. The same bound also discharges sin_radius_le ($\sin0.5748\le0.54368$), which Passage D leaves as sorry: that sorry is a gap in the Lean file, and the inequality it states is true by the rational bound above.

## 6. The witness, by parity

**Even $n$.** $\theta_0(n)^2>\frac32\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$. For $n\ge12$, $n^2-12n+8=n(n-12)+8\ge8>0$. The heading's "exactly when $n>6+2\sqrt7$" is correct for $n\ge1$, the other root $6-2\sqrt7$ lying in $(0,1)$ since $2<\sqrt7<3$. At even $n$ the Definitions make $\theta_0(n)$ attained, so claim 6 holds.

**Odd $n$, where the detail entry fails as stated.** The detail entry's last sentence reads "contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains", with no parity restriction. At odd $n$ the Definitions make the best sphere-product value $\Theta_n$, and a direct subtraction gives the closed form

$$\theta_0(n)^2-\Theta_n^2=2(n-1)\,\frac{(n-2)^2(n+1)-(n-3)n^2}{n^2(n-2)(n+1)}=\frac{8(n-1)}{n^2(n-2)(n+1)}>0,$$

using $(n-2)^2(n+1)=n^3-3n^2+4$. So at every odd $n\ge3$ the best sphere product has value strictly below $\theta_0(n)$, and no sphere product attains $\theta_0(n)$. At $n=13$, for instance, $\Theta_{13}^2=\frac{120}{77}$ (thirteen_witness) while $\theta_0(13)^2=\frac{264}{169}$. The sentence is REFUTED AS STATED at odd $n$.

**The opposite argued, and the repair.** The contradiction needs only some unit Weyl operator with $P>\theta^*$, and $\Theta_n$ supplies it. $\Theta_n^2>\frac32\iff4(n-1)(n-3)>3(n-2)(n+1)\iff n^2-13n+18>0$ (odd_threshold, witness_condition). For odd $n\ge13$, $n^2-13n+18=n(n-13)+18\ge18>0$. Every $n\ge12$ is either even and at least 12 or odd and at least 13, so $\max_SP>\theta^*$, that is $m>1$, at every $n\ge12$. This is exactly what Passage A's proof states, so the defect is confined to the wording of the detail entry's sketch and does not reach the lemma's conclusion.

## 7. Assembly

Take $n\ge12$ and any global maximizer $W^*$ (H4). Suppose $d(W^*,\mathcal O)\le0.5748$. If the distance is $0$, then $m=1$ (Section 1). Otherwise Sections 1 to 5, with H1, H2 and H5, give $m\le1$. Section 6, with H3, gives $m>1$. The contradiction shows $d(W^*,\mathcal O)>0.5748$. The tube_exclusion theorem of Passage D records the final implication in the same form: from the exact expansion, $\alpha\le\frac13$, $\gamma\le m$ and $1<m$ it concludes $0.5748<\varphi$ (modulo the sin_radius_le sorry discharged in Section 5).

Lemma L21 is needed only at $n\ge12$, inside its stated range $n\ge9$.

## Verdict

**VALID.** L20 holds for every $n\ge12$ as the heading and the detail entry state it, on the following hypotheses:

- H1, Lemma L21's bound $\alpha\le\frac13$, taken as the given the brief makes it (the landscape entry correctly flags its unproved input),
- H2, full symmetry of the trace and sharp trilinear forms,
- H3, the sphere-product values $\Theta_n$ of the Definitions,
- H4, "maximizer" read as global maximizer,
- H5, geodesic angular distance, which both entries write.

Passage A's three "further hypotheses" are consequences (Section 1) and need not be assumed. One correction is owed to the detail entry: its closing clause should read "contradicting the value $\Theta_n>\theta^*$ the best sphere product attains ($\Theta_n=\theta_0(n)$ at even $n$)", because at odd $n$ the value $\theta_0(n)$ exceeds every sphere product's value by $\frac{8(n-1)}{n^2(n-2)(n+1)}$ in the square.
