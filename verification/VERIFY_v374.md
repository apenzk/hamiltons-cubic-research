# Verifier v374, Lemma L20: the exact expansion, the transverse bound from L21, the bootstrap to m ≤ ψ(φ), the radius step, the witness at both parities, the degenerate branch, the canonical statement and the Lean layer

Cold brief ([BRIEF_L20r2.md](BRIEF_L20r2.md)), no numerical work, no scripts written, no Lean build run. Every value below is exact or is a hand evaluation of an exact rational expression whose digits are written out. Sources opened: the brief, the cited lines of [route-a.md](../findings/route-a.md) (103, 121, 123, 125, 127, 129, 131, 133, 135, 174) and [results.md](../results.md) (321, 1063, 1065) to confirm the quotations, [conventions.md](../findings/conventions.md), and [Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) with its extraction at lines 1470–1500, 4655–4672 and 4715–4735. Log: [agent_logs/verify-L20-v374.log](../agent_logs/verify-L20-v374.log).

| # | claim | verdict |
| --- | --- | --- |
| 1 | the expansion $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ is exact with no linear term | CONFIRMED |
| 2 | $\alpha\le\tfrac13$ on the transverse space, from Lemma L21 as given | CONFIRMED (conditional on L21, whose debt is L21's) |
| 3 | $\gamma_V\le m$ and $m\le\psi(\varphi)$ | CONFIRMED |
| 4 | $\psi\le1$ on $[0,0.5748]$: the reduction, the Taylor bound, the bracket | CONFIRMED |
| 5 | the decimals $0.9785933$, $0.3747372$, $0.5748263$, $0.9999937$, and the chord remark | CONFIRMED AS ALGEBRA (closed forms and inequalities), the seventh digits HYPOTHESIS-DEBT and unused |
| 6 | the witness at both parities and "both clear from $n\ge12$" | CONFIRMED |
| 7 | the degenerate branch $\varphi=0$ and "the contradiction is with the value" | CONFIRMED |
| 7a | "that it too lies outside the tube follows afterwards" (the sphere product) | GAP (unused, no argument on file) |
| 8 | the three "further hypotheses" of Passage A | CONFIRMED (each holds unconditionally, so none restricts the lemma) |
| 9 | "without the first-variation step the bound would be $\alpha\le\tfrac12$, at which the interval is empty" | CONFIRMED AS ALGEBRA |
| 10 | Passage C, [results.md](../results.md) line 1065: "contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains" | REFUTED AS STATED (false at odd $n$, the proof survives with $\Theta_n$) |
| 11 | Passage C line 1065 states L20 without L21's conditional status, against line 321 and Passage A | GAP (status inconsistency, statement-level) |
| 12 | Lean: [L20Statement.lean](../lean/HamiltonsCubic/Results/L20Statement.lean), [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean), [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean) against Passages A and C | CONFIRMED AS ALGEBRA (the scalar core only, one `sorry` which the paper discharges) |

**What the round should do**: replace $\theta_0(n)$ by $\Theta_n$ in the witness sentence of [results.md](../results.md) line 1065, add L21's conditional status to that block as line 321 already carries it, restate Passage A's three "hypotheses" as facts with their one-line reasons, and either argue or delete the closing clause about the sphere product lying outside the tube.

## 0. Conventions, fixed once

- $\mathcal W_n=\mathrm{Weyl}_n$ with the record's inner product. $P(W)=\langle W,Q(W)\rangle$, $Q(W)=W^2+W^\#$, $T$ the fully symmetric polarisation with $T(X,X,X)=P(X)$ ([conventions.md](../findings/conventions.md) line 24).
- $u=W_{\mathbb{CP}^2}$ padded, $\lVert u\rVert=1$, $\theta^*=P(u)=\sqrt{3/2}$, $Q(u)=\theta^*u$.
- $d$ is geodesic angular distance, $\cos d(X,Y)=\langle X,Y\rangle$, and $d(X,\mathcal O)=\min_{Y\in\mathcal O}d(X,Y)$ ([conventions.md](../findings/conventions.md) line 81). $\mathcal O=SO(n).u$.
- $m$ in L20 is $\sqrt{2/3}\max P$. In L21 (Passage B) $m=n-4$. The collision is tabled at [conventions.md](../findings/conventions.md) line 63 and I read each from its block.
- $\Theta_n$ is the best two-factor sphere product value: $\Theta_n^2=\theta_0(n)^2=2(n-1)(n-2)/n^2$ at even $n$, $\Theta_n^2=2(n-1)(n-3)/((n-2)(n+1))$ at odd $n$.
- $c=\cos\varphi$, $s=\sin\varphi$, $s^*$ the real root of $s^3+s^2+s=1$.

## Hypothesis inventory

**The statement (Passage C line 1065).** The hypotheses are $n\ge12$ and $W^*$ a maximizer of $P$ on the unit sphere of $\mathcal W_n$. The conclusion is $d(W^*,\mathcal O)>0.5748$. The metric is fixed by convention. No hypothesis on $\ker W^*$, on parity, or on criticality beyond maximality.

**Hypotheses Passage A says it uses, each checked against its object.**

| hypothesis | where used | status |
| --- | --- | --- |
| unit sphere compact, $\max P$ attained | defines $m$ and $W^*$ | holds, $\mathcal W_n$ finite-dimensional, $P$ continuous |
| $d$ is $SO(n)$-invariant | rotating the nearest orbit point to $u$ | holds: $SO(n)$ acts on $\mathcal W_n$ by orthogonal maps, so $\langle gX,gY\rangle=\langle X,Y\rangle$ |
| the orbit is a compact embedded submanifold, a nearest point exists, first variation holds | $V\perp T_u\mathcal O$ | holds: existence needs only compactness of $\mathcal O$ (continuous image of $SO(n)$), and first variation needs only that $g\mapsto\langle W^*,g.u\rangle$ is smooth on $SO(n)$ and maximal at $g=e$ |
| $\varphi>0$ | defining $V=(W^*-cu)/s$ | holds on the main branch, $\varphi=0$ treated separately |
| $P$ is $SO(n)$-invariant | replacing $W^*$ by $g^{-1}W^*$, again a maximizer | holds, $P$ built from $SO(n)$-equivariant operations |
| $Q(u)=\theta^*u$ | vanishing linear term | holds, it is Nienhaus Theorem 4.14(a), $F_u(u)=Q(u)=\sqrt{3/2}\,u$ |
| $T(u,V,V)=\langle F_uV,V\rangle$ | identifying the middle coefficient with $\alpha$ | holds, see Section 1 |
| $\cos\varphi\ge0$ | $3cs^2\alpha\le cs^2$ | holds on $[0,0.5748]\subset[0,\pi/2)$, used without being written at that step (it is written at the radius step) |
| $\sin^3\varphi\ge0$ | $s^3\gamma_V\le s^3m$ | holds on the range, unwritten at that step |
| $1-\sin^3\varphi>0$ | dividing to $m\le\psi$ | holds, written |

**Imported results and their hypotheses.**

| imported | its hypotheses | checked against the object |
| --- | --- | --- |
| Lemma L21 (Passage B) | $n\ge9$, $u$ padded and unit, $V$ unit in $u^\perp\cap T_u(SO(n).u)^\perp$ | $n\ge12\ge9$. $V$ is unit, $\perp u$ by construction, $\perp T_u\mathcal O$ by first variation. The subspace is literally the same in Passages A and B. |
| sphere product value $\Theta_n$ ([Nienhaus](../references/nienhaus-2023-second-best-einstein/notes.md) Proposition 2.25, extraction line 1483) | a split $k+l=n$ | $(n/2,n/2)$ at even $n$, $((n-1)/2,(n+1)/2)$ at odd $n$. From $\theta_{k,l}^2=2\frac{(k-1)(l-1)}{kl}\frac{n-1}{n-2}$: the even split gives $2\frac{(n-2)^2}{n^2}\frac{n-1}{n-2}=\theta_0(n)^2$ and the odd split gives $2\frac{n-3}{n+1}\frac{n-1}{n-2}=\Theta_n^2$. Since $Q(W_S)=\theta W_S$ and $P(W_S)=\theta$, $\lVert W_S\rVert=1$. |
| $\sin x\le x-\tfrac{x^3}6+\tfrac{x^5}{120}$, $x\ge0$ | $x\ge0$ | $x=0.5748$. Standard, by integrating $\cos t\le1$ four times from $0$. |
| monotonicity of $\sin$ on $[0,\pi/2]$ | $0\le\varphi\le0.5748<\pi/2$ | holds |
| [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean) bracket_tight | none | its statement is $\mathrm{cubic}(0.5436890)<0$, which with strict monotonicity on $s\ge0$ gives $0.5436890<s^*$ |

**Unused hypotheses and unstated ones.** No stated hypothesis is idle, but the three Passage A calls "hypotheses" are consequences of the setting (see claim 8). Two sign conditions ($c\ge0$ at the $\alpha$ step, $s^3\ge0$ at the $\gamma$ step) are used a line before they are written, and both follow from the range. $m\ge0$ is never used. $\ker W^*$ is never read.

## 1. The exact expansion

**The step.** For $\varphi>0$ write $W^*=cu+sV$ with $V$ unit, $V\perp u$. Trilinearity and symmetry of $T$ give
$$P(cu+sV)=c^3P(u)+3c^2s\,T(u,u,V)+3cs^2\,T(u,V,V)+s^3P(V).$$
This is the binomial expansion of a symmetric trilinear form and is exact.

**The linear term.** $dP_u(V)=\langle V,Q(u)\rangle+2\langle u,B_Q(u,V)\rangle$ with $B_Q$ the symmetric bilinear form of $Q$. Full symmetry of $\langle X,B_Q(Y,Z)\rangle$ makes the second term $2\langle Q(u),V\rangle$, so $3T(u,u,V)=dP_u(V)=3\langle Q(u),V\rangle$ and $T(u,u,V)=\theta^*\langle u,V\rangle=0$. **This uses only $V\perp u$ and $Q(u)=\theta^*u$.** The first-variation condition is not needed for the linear term.

**The middle coefficient.** $T(u,V,V)=\langle u,Q(V)\rangle$ by the same symmetry. Splitting $Q=(\cdot)^2+(\cdot)^\#$: the square part polarises to $\tfrac12(\mathrm{tr}XYZ+\mathrm{tr}XZY)$, giving $\mathrm{tr}(uV^2)=\langle\tfrac12(uV+Vu),V\rangle$. The $\#$ part gives $\langle u,V\#V\rangle=\langle u\#V,V\rangle$. So $T(u,V,V)=\langle F_uV,V\rangle$ with $F_u(h)=\tfrac12(uh+hu)+u\#h$, as Passage A writes. Nienhaus uses the identical form, $\mathrm{tri}(R,S,T)=\mathrm{tr}((R\circ S+S\circ R+2R\#S)T)$ symmetric, extraction line 4719, with $\mathrm{tri}=2T$.

**Normalisation.** Multiplying by $\sqrt{2/3}$: $\sqrt{2/3}P(u)=1$, $\sqrt{2/3}\cdot3cs^2T(u,V,V)=3cs^2\alpha$, $\sqrt{2/3}s^3P(V)=s^3\gamma_V$, and $\sqrt{2/3}P(W^*)=m$. The display is correct.

**Which hypotheses each step uses.** Invariance of $d$ and of $P$: the rotation. Nearest point and first variation: $V\perp T_u\mathcal O$, which is consumed only by claim 2. $\varphi>0$: the definition of $V$.

*Candidate 1a, "the linear term needs the first-variation condition".* Located at Passage A line 123, "orthogonal also to $T_u(SO(n).u)$ by the first-variation condition". Failure exhibited: none, the linear term vanishes from $V\perp u$ alone as shown. Charitable reading: Passage A attributes the vanishing to $Q(u)=\theta^*u$ and $\langle u,V\rangle=0$, which is correct, and cites first variation for the transverse space only. **Withdrawn**, no misattribution.

Verdict: **CONFIRMED**.

## 2. The bound $\alpha\le\tfrac13$

**What Passage B gives.** For $n\ge9$, $u$ padded unit, and every unit $V\in u^\perp\cap T_u(SO(n).u)^\perp$, $\alpha=\sqrt{2/3}\langle F_uV,V\rangle\le\tfrac13$, attained. The statement is a Rayleigh-quotient bound on the named subspace, so it needs no claim that the subspace is $F_u$-invariant.

**Match with Passage A.** The subspace, the operator $F_u$, the normalisation $\sqrt{2/3}$ and the object $u$ coincide symbol for symbol. $n\ge12$ lies in $n\ge9$. The $V$ of Passage A satisfies Passage B's hypotheses (Section 1). $\tfrac13\theta^*\cdot\sqrt{2/3}=\tfrac13$, so Passage A's eigenvalue phrasing and Passage B's Rayleigh phrasing state the same bound.

**Debts.** The brief gives L21 with the debt its own block records. L20 therefore holds conditional on that debt and on nothing further. Passage A calls the bound "the lemma's one unproved input", and the landscape line 321 says "conditional on one input nothing on the record proves". Line 1065 says neither (claim 11).

*Candidate 2a, "Nienhaus 4.14(c) is cited for the bound and does not carry it".* Passage A itself records this and cites Remark 4.16, which I read at source (extraction line 4657): on $T_u\mathcal O$, $F(W)=\tfrac12\sqrt{3/2}\,W$. So $\tfrac12\theta^*$ is removed by transversality exactly as Passage A says. The record already carries the defect in its own text. **Withdrawn** as a new finding, it is the record's stated debt.

Verdict: **CONFIRMED**, conditional on L21.

## 3. $\gamma_V\le m$ and $m\le\psi(\varphi)$

- $V=(W^*-cu)/s$ lies in $\mathcal W_n$ and has unit norm, so $\gamma_V=\sqrt{2/3}P(V)\le\sqrt{2/3}\max P=m$. This holds for every unit $V$ and needs no property of $W^*$.
- With $c\ge0$ and $s^2\ge0$, $3cs^2\alpha\le cs^2$. With $s^3\ge0$, $s^3\gamma_V\le s^3m$. So $m\le c^3+cs^2+s^3m=c+s^3m$, using $c^3+cs^2=c(c^2+s^2)=c$.
- $1-s^3>0$ since $0\le s<1$. Hence $m(1-s^3)\le c$ and $m\le c/(1-s^3)=\psi(\varphi)$.
- **$m\ge0$ is not used.** The inequality $s^3\gamma_V\le s^3m$ is linear in $m$ with a nonnegative coefficient and holds at any sign of $m$.

*Candidate 3a, "the division needs $m\ge0$".* Failure exhibited: none, dividing $m(1-s^3)\le c$ by the positive $1-s^3$ is sign-free in $m$. **Withdrawn.**

Verdict: **CONFIRMED**.

## 4. The radius step

**The reduction.** On $[0,0.5748]$, $c>0$ and $1-s^3>0$, so $\psi\le1\iff c\le1-s^3\iff c^2\le(1-s^3)^2$. Now $(1-s^3)^2-(1-s^2)=s^2-2s^3+s^6=s^2(s^4-2s+1)$, and $s^4-2s+1=(s-1)(s^3+s^2+s-1)$, which is `quartic_factors` in [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean). So the difference is $s^2(1-s)(1-s-s^2-s^3)$, as Passage A writes. For $0\le s<1$ it is $\ge0$ iff $s=0$ or $s^3+s^2+s\le1$. The cubic $s^3+s^2+s-1$ has derivative $3s^2+2s+1$, of discriminant $4-12<0$, hence strictly increasing on $\mathbb R$, so it has one real root $s^*\in(0,1)$ and the condition is $s\le s^*$ (which includes $s=0$). The reduction is exact on $[0,\pi/2)$.

**The Taylor bound, by hand in exact decimals.** $x=0.5748$, $x^2=0.33039504$, $x^3=0.189911068992$, $x^3/6=0.031651844832$, $x^5=x^3x^2=0.06274567\ldots$, $x^5/120=0.00052288\ldots$ Then $x-x^3/6+x^5/120=0.5436710\ldots<0.543672$, with margin about $9.6\times10^{-7}$ against truncation errors below $10^{-9}$. The claim holds.

**The bracket.** `bracket_tight` states $\mathrm{cubic}(5436890/10^7)<0$, so by monotonicity $0.5436890<s^*$. A hand check agrees: at $s=0.543689$, $s^2=0.2955977\ldots$, $s^3=0.1607132\ldots$, and $s+s^2+s^3=0.99999996\ldots<1$. Chain: $\sin\varphi\le\sin(0.5748)<0.543672<0.5436890<s^*$.

*Candidate 4a, "the Taylor inequality is asserted without proof".* Located at Passage A line 131, "$\sin x\le x-\tfrac{x^3}6+\tfrac{x^5}{120}$ for $x\ge0$". Failure exhibited: none, the inequality is standard and follows from $\cos t\le1$ by four integrations from $0$. Charitable reading: a textbook fact cited by name. **Withdrawn.**

Verdict: **CONFIRMED**.

## 5. The decimals and the chord remark

None of these values is consumed by the proof. The proof uses only $\sin(0.5748)<s^*$.

- **Minimum location, closed form.** $\frac{d\psi}{d\varphi}=\frac{-s(1-s^3)+3s^2c^2}{(1-s^3)^2}=\frac{-s(s-1)(2s^2+2s-1)}{(1-s^3)^2}$, zero in $(0,1)$ exactly at $s=\frac{\sqrt3-1}2$, negative before and positive after. At that point $s^2=\frac{2-\sqrt3}2$, $c=(3/4)^{1/4}$, $s^3=\frac{3\sqrt3-5}4$, so $\psi_{\min}=\frac{4\,(3/4)^{1/4}}{9-3\sqrt3}$. A hand evaluation gives $0.978593\ldots$, agreeing with $0.9785933$ to six places. CONFIRMED AS ALGEBRA.
- **$0.3747372$** is $\arcsin\frac{\sqrt3-1}2$. The series gives $0.37473\ldots$ by hand. The seventh digit rests on no argument on file.
- **$0.5748263$** is $\arcsin s^*$, the exact crossing by Section 4, since $\psi=1$ on $(0,1)$ only at $s=s^*$ and $\psi>1$ beyond. That $0.5748<\arcsin s^*$ is proved. The seventh digit rests on no argument on file.
- **$\psi(0.5748)=0.9999937$**: that it is $\le1$ is proved. The digits rest on no argument on file.
- **Chord remark.** A chord $0.5748$ on the unit sphere is the angle $2\arcsin(0.2874)$. Then $\sin(2\arcsin 0.2874)=0.5748\sqrt{1-0.2874^2}=0.5748\cdot0.95781\ldots=0.55055\ldots>0.5436891>s^*$, so $\psi>1$ at the chord reading's outer radius and the argument gives no contradiction there. The qualitative claim is CONFIRMED AS ALGEBRA. The digits $0.5830224$ and $1.0020125$ rest on no argument on file.

Verdict: **CONFIRMED AS ALGEBRA** for every closed form and inequality. The seven-digit decimals are **HYPOTHESIS-DEBT** and unused.

## 6. The contradiction at both parities

- **Even $n$.** $\theta_0(n)^2>\tfrac32\iff4(n-1)(n-2)>3n^2\iff n^2-12n+8>0$, roots $6\pm2\sqrt7$, so at integers from $n=12$: $12^2-144+8=8>0$, $11^2-132+8=-3$. Witness at $n=12$: $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}>\tfrac{54}{36}$.
- **Odd $n$.** $\Theta_n^2>\tfrac32\iff4(n-1)(n-3)>3(n-2)(n+1)\iff n^2-13n+18>0$, roots $\frac{13\pm\sqrt{97}}2$, the larger between $11$ and $12$ since $n=11$ gives $-4$ and $n=12$ gives $6$. First odd case $n=13$: $\Theta_{13}^2=\tfrac{120}{77}>\tfrac32$ since $240>231$.
- **"Both clear from $n\ge12$"** is true of both polynomials at every real $n\ge12$ (their larger roots are $6+2\sqrt7<12$ and $\frac{13+\sqrt{97}}2<12$), and the parity that matters at each integer is then covered.
- **The witness is a unit Weyl operator** by Proposition 2.25 (inventory), so $\max P\ge\Theta_n>\sqrt{3/2}$, i.e. $m>1$, against $m\le1$.

*Candidate 6a, "at odd $n$ the witness $\theta_0(n)$ is not attained".* This is correct of the canonical statement, and Passage A already fixes it. Reported at claim 10.

Verdict: **CONFIRMED**.

## 7. The degenerate branch and "value, not location"

- At $\varphi=0$, $W^*\in\mathcal O$, so $\max P=P(W^*)=P(u)=\sqrt{3/2}$, contradicting $\max P\ge\Theta_n>\sqrt{3/2}$. Also the general display at $s=0$ reads $m=1$. CONFIRMED.
- **Value, not location.** The contradiction is between $\max P\le\sqrt{3/2}$ and the existence of one unit operator with larger $P$. Nothing about the witness's distance to $\mathcal O$ enters. CONFIRMED.
- **Quantifier order.** Fix $n\ge12$. For every maximizer $W^*$ (the argument uses only $P(W^*)=\max P$), $d(W^*,\mathcal O)>0.5748$. The radius is independent of $n$, and "within" is read closed, which is what the supposition $\varphi\le0.5748$ covers. CONFIRMED.

### 7a. "that it too lies outside the tube follows afterwards"

- **Locate.** [route-a.md](../findings/route-a.md) line 135: "nothing is assumed about where the sphere product sits, and that it too lies outside the tube follows afterwards".
- **Exhibit.** The L20 bootstrap does not apply to the sphere product $W_S$: for a non-maximizer the same expansion gives $\sqrt{2/3}P(W_S)\le\cos\varphi+m\sin^3\varphi$, which does not reduce to $\le1$ because $m$ is the unknown global value. So the clause does not follow from L20. No other argument is on file in what the brief quotes.
- **Charitable reading.** The clause may intend a separate distance computation. A test against the balanced witness at $n=12$ shows the claim is true there: $W_S$ has eigenvalue $\tfrac6{11}$ on $\Lambda^2V_1\oplus\Lambda^2V_2$ (dimension $30$) and $-\tfrac5{11}$ on $V_1\otimes V_2$ (dimension $36$), norm $\sqrt{1980}/11$, so the unit operator has operator norm $\frac{6}{\sqrt{1980}}$. Every $g.u$ is supported on some $\Lambda^2E$ with $\dim E=4$, so $\langle W_S,g.u\rangle\le\lVert\Pi_EW_S\Pi_E\rVert_F\le\sqrt6\cdot\frac6{\sqrt{1980}}=\frac{36}{\sqrt{11880}}<\frac{36}{108}=\frac13$, far below $\cos(0.5748)>0.83$. **What would have to be proved**: $\sqrt6\,\lVert W_{S}\rVert_{\mathrm{op}}<\cos(0.5748)$, or a direct bound on $\max_g\langle W_S,g.u\rangle$, for the best split at every $n\ge12$.

The clause is outside the statement and unused. Verdict: **GAP** (unused, no argument on file, true at the tested witness).

## 8. The three "further hypotheses"

- **Locate.** Passage A line 123: "Three further hypotheses are used and are stated here rather than assumed: that $d$ is $SO(n)$-invariant, that the orbit is a compact embedded submanifold so a nearest point exists and its first-variation condition holds, and that $\varphi>0$".
- **Each is a fact.** Invariance: $SO(n)$ acts orthogonally on $\mathcal W_n$. The orbit: it is the continuous image of the compact group $SO(n)$, hence compact, so $\max_g\langle W^*,g.u\rangle$ is attained. It is also an embedded submanifold, as every orbit of a compact Lie group acting smoothly is, but the proof needs only that $h(t)=\langle W^*,\exp(tX).u\rangle$ is smooth with a maximum at $t=0$, giving $\langle W^*,X.u\rangle=0$ for all $X\in\mathfrak{so}(n)$. Since $\lVert g.u\rVert=1$, also $\langle u,X.u\rangle=0$, so $s\langle V,X.u\rangle=0$. $T_u\mathcal O=\{X.u\}$ (Remark 4.16, extraction line 4671). $\varphi>0$: a case split, with $\varphi=0$ handled.
- **Charitable reading.** Passage A lists them to make the proof's inputs explicit, and Passage C's statement correctly carries none of them. No reader is misled about the scope, though "hypotheses" suggests a restriction where there is none.
- **Item 10 of the brief, "the nearest point when the orbit is not a manifold".** The situation does not arise, and the argument would not need it.

Verdict: **CONFIRMED**. The round should restate them as facts.

## 9. "Without the first-variation step the bound would be $\alpha\le\tfrac12$, at which the interval is empty"

With $\alpha\le\tfrac12$ the bootstrap gives $m(1-s^3)\le c(1+\tfrac{s^2}2)$. The analogue of $\psi\le1$ is $c(1+\tfrac{s^2}2)\le1-s^3$, which after squaring (both sides positive) is $(1-s^2)(1+\tfrac{s^2}2)^2\le(1-s^3)^2$, i.e. $1-\tfrac34s^4-\tfrac14s^6\le1-2s^3+s^6$, i.e. $s^3\bigl(2-\tfrac34s-\tfrac54s^3\bigr)\le0$. The bracket is decreasing on $[0,1]$ and equals $0$ at $s=1$, so it is positive on $[0,1)$. The inequality therefore fails for every $s\in(0,1)$, and only $\varphi=0$ survives. Verdict: **CONFIRMED AS ALGEBRA**.

## 10. Passage C's witness sentence at odd $n$

- **Locate.** [results.md](../results.md) line 1065: "forces $\max P\le\theta^*$, contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains."
- **Exhibit, $n=13$.** Every sphere product $S^k\times S^l$ with $k+l=13$ has $\theta_{k,l}^2=2\bigl(1-\tfrac{12}{kl}\bigr)\tfrac{12}{11}$ by Proposition 2.25, maximal at $kl=42$, giving $\tfrac{120}{77}$. And $\theta_0(13)^2=\tfrac{264}{169}$. Since $264\cdot77=20328>20280=120\cdot169$, $\theta_0(13)>\Theta_{13}$, so no sphere product attains $\theta_0(13)$. The same holds at every odd $n$ by the gap $\theta_0^2-\Theta_n^2=\frac{8(n-1)}{n^2(n+1)(n-2)}>0$ tabled at [conventions.md](../findings/conventions.md) line 18.
- **Charitable reading.** "$\theta_0(n)$" might be shorthand for "the sphere product value". [conventions.md](../findings/conventions.md) line 18 defines $\theta_0$ as the closed form "and nothing more" and names exactly this gloss as the one that regrew a refuted constant. Passage A says the opposite of line 1065: "at odd $n$ the balanced sphere product is not one, it does not exist". The charitable reading fails.
- **Impact.** The sentence is false at odd $n\ge13$. The lemma survives: $\Theta_n>\theta^*$ at every odd $n\ge13$ (Section 6) supplies the contradiction. The correction is one symbol, $\theta_0(n)\to\Theta_n$.

Verdict: **REFUTED AS STATED**.

## 11. Passage C against Passage A: range, metric, conditionality

| aspect | Passage A (route-a 103–135) | line 321 (landscape) | line 1065 (detail) |
| --- | --- | --- | --- |
| range | $n\ge12$ | $n\ge12$ | $n\ge12$ |
| metric | geodesic angular, fixed in conventions | "geodesic angular" | "angular distance" |
| radius | $0.5748$, closed | $0.5748$ | $0.5748$ |
| status of $\alpha\le\tfrac13$ | "the lemma's one unproved input" | "conditional on one input nothing on the record proves" | cited as "the eigenvalue bound $\alpha\le\tfrac13$ of Lemma L21", no condition |
| witness | $\Theta_n$, both parities | "the sphere product's larger value" | $\theta_0(n)$ (claim 10) |
| "unconditionally" or similar | absent | absent | absent |

- **Locate.** Line 1065, "with the eigenvalue bound $\alpha\le\tfrac13$ of [Lemma L21]".
- **Exhibit.** A reader of line 1065 alone takes L20 as unconditional, while line 321 and Passage A make it conditional on the same input. The discrepancy is in one file, 744 lines apart.
- **Charitable reading.** Citing L21 by number imports whatever status L21 carries, so a reader who follows the link finds the debt. The charitable reading weakens the finding but does not remove it, because line 1065 is a result statement and line 321 shows the record's own practice is to state the condition in the statement.

Verdict: **GAP** (statement-level, no mathematical consequence).

## 12. The Lean layer against Passages A and C

| declaration | what it states | what it stands for |
| --- | --- | --- |
| `psi`, `psi_at_zero` | $\psi(\varphi)=\cos\varphi/(1-\sin^3\varphi)$, $\psi(0)=1$ | the definition, faithful |
| `sStar_bracket` | $0.54368<s^*<0.54369$ as cubic signs | a weaker bracket than TubeRadius's, sufficient |
| `cos_add_sin_cube_le_one` | $0\le s\le0.54368$, $c\ge0$, $c^2=1-s^2$ $\Rightarrow c+s^3\le1$ | the reduction of Section 4 |
| `max_le_one_of_sin_le` | $c\ge0$, $s\ge0$, $s\le0.54368$, **hexp**, **hα** $\alpha\le\tfrac13$, **hγ** $\gamma\le m$ $\Rightarrow m\le1$ | Section 3 plus Section 4, with $c\ge0$ and $s\ge0$ explicit where the paper leaves them implicit |
| `sin_radius_le` | $\sin0.5748\le0.54368$, **`sorry`** | the Taylor step, which Section 4 discharges on paper ($0.5436710\ldots\le0.54368$) |
| `sin_le_of_le_radius`, `trig_nonneg` | monotonicity and signs on $[0,0.5748]$ | faithful, depends on the `sorry` |
| `tube_exclusion` | $0\le\varphi$, hexp, hα, hγ, $1<m$ $\Rightarrow0.5748<\varphi$ | the contrapositive scalar core, depends on the `sorry` |
| `theta0Sq`, `thetaOddSq`, `even_threshold`, `odd_threshold` | $\tfrac32<\theta_0^2\iff n^2-12n+8>0$ ($n\ge3$), $\tfrac32<\Theta_n^2\iff n^2-13n+18>0$ ($n>3$) | Section 6, over $\mathbb R$, faithful |
| `thresholds_at_eleven_twelve`, `thresholds_positive`, `crossover_bracket` | the integer values, positivity at real $n\ge12$, $11<6+2\sqrt7<12$ | faithful |
| [TubeRadius.lean](../lean/HamiltonsCubic/Results/TubeRadius.lean) | factorisation, monotonicity on $a\ge0$, brackets to $10^{-7}$ over $\mathbb Q$ | faithful, no `sorry` in the quoted file |
| [OddWitness.lean](../lean/HamiltonsCubic/Results/OddWitness.lean) | the odd threshold over $\mathbb Q$ at $n\ge4$, $\Theta_{13}^2=\tfrac{120}{77}>\tfrac32$ | faithful, the denominator ordered $(n+1)(n-2)$, the same value |

- **hexp and hα are inputs**, not conclusions. The expansion (Section 1) and L21 (Section 2) are hypotheses of the Lean theorem, as they are external inputs of the paper proof.
- **What is not typed.** $\mathcal W_n$, $P$, $Q$, $T$, the orbit, the metric $d$, maximality, the nearest point and first variation, $V$, Lemma L21, Proposition 2.25, and the link between the threshold lemmas and the hypothesis `hm : 1 < m`. The Lean layer certifies the scalar inequality chain and the threshold algebra only.
- **Direction and binders.** `tube_exclusion` has the right direction ($1<m$ gives $\varphi>0.5748$), all four reals universally bound, no hypothesis stronger than the paper's. `max_le_one_of_sin_le` carries $\cos\varphi\ge0$ and $\sin\varphi\ge0$, which the paper uses without writing (inventory).
- **Passage A's Lean claim** is only that "$0.5436890<s^*$ is kernel-checked in TubeRadius.lean", which `bracket_tight` states. Passage A makes no Lean claim for the Taylor step, so the `sorry` contradicts nothing the record says.

*Candidate 12a, "the Lean layer proves L20".* No passage says so. **Withdrawn.**

Verdict: **CONFIRMED AS ALGEBRA**.

## Withdrawn candidates

| candidate | reason withdrawn |
| --- | --- |
| 1a, the linear term needs first variation | it vanishes from $V\perp u$ and $Q(u)=\theta^*u$ alone, and Passage A says so |
| 2a, Nienhaus 4.14(c) does not carry $\alpha\le\tfrac13$ | the record states this debt itself, and Remark 4.16 at source matches its description |
| 3a, the division needs $m\ge0$ | division by $1-s^3>0$ is sign-free in $m$ |
| 4a, the Taylor inequality is unproved | standard, four integrations of $\cos t\le1$ |
| 6a, the odd witness | a defect of line 1065 only, reported as claim 10 |
| 12a, the Lean layer is presented as proving L20 | no passage claims it |
| ker $W^*\ne0$ | no step reads the spectrum or kernel of $W^*$. $u$ itself has a large kernel and is handled by L21, which is stated for the padded object |
| the smallest admissible dimension | $n=12$ (even witness $\tfrac{55}{36}>\tfrac32$) and $n=13$ (odd witness $\tfrac{120}{77}>\tfrac32$) both close. At $n=11$ both polynomials are negative, so the lemma's lower edge is exactly where its witness starts |
| the orbit might not be a manifold | orbits of compact group actions are compact embedded submanifolds, and the proof needs only compactness and a smooth orbit map |
| "rival maximizer" names a non-maximizer | a heading label, not a claim, and the proof nowhere assumes $u$ maximises |

## The falsifying object, and the search for it

**The object.** A dimension $n\ge12$ and a unit $W^*\in\mathcal W_n$ with $P(W^*)=\max P$ and $d(W^*,SO(n).u)\le0.5748$. Given L21, such an object forces $\max P\le\sqrt{3/2}$, so the only escapes are a failure of L21 at some transverse unit $V$ (a $V$ with $\sqrt{2/3}\langle F_uV,V\rangle>\tfrac13$), or a failure of the witness.

**What I did.**

- **The witness.** Recomputed $\Theta_n$ from Nienhaus Proposition 2.25 at both parities in closed form and checked unit norm from $Q(W_S)=\theta W_S$, $P(W_S)=\theta$. It holds from $n=12$ (even) and $n=13$ (odd).
- **Diagonal and padded objects.** $u$ padded is the expansion's base point, and every step is linear algebra on $\mathcal W_n$ without a kernel assumption. A padded $W^*$ is covered.
- **Sphere products.** At $n=12$ the balanced product has $\cos d\le\tfrac13$ to $\mathcal O$ (claim 7a), so it is not a candidate falsifier inside the tube.
- **$\mathbb{CP}^m$.** Not a Weyl operator on $\mathbb R^n$ at $n\ge12$ except by padding a $\mathbb{CP}^m$ Weyl tensor of real dimension $2m\le n$. Such an object is a unit Weyl operator and enters only as a value $P$, which could raise $\max P$ further and so only strengthens the contradiction. It cannot supply a falsifier without breaking L21.
- **L21 itself.** Given as a given, with its debt, and not re-derived. Any falsifier of L20 is a falsifier of L21.

No falsifier found. The proof is complete relative to L21.

## Overall verdict

**PROVEN (hypotheses corrected).** Given Lemma L21 as stated, every step from the expansion to $\varphi>0.5748$ follows, at both parities, at $n=12$ and $n=13$, at $\varphi=0$, and with $\ker W^*\ne0$. The corrections are to the canonical statement at [results.md](../results.md) line 1065: the witness value is $\Theta_n$, and the block must carry L21's conditional status as line 321 does. Passage A's three "hypotheses" hold unconditionally and should be restated as facts. The clause that the sphere product lies outside the tube has no argument on file and is not used.
