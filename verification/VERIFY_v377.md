# Verifier v377, step G2 of round L20-r2: L20 for every n at least 12 with no condition beyond its heading and detail entry

*Cold brief ([ADJ_L20r2_G2.md](ADJ_L20r2_G2.md)), with [conventions.md](../findings/conventions.md) lines 18, 19 and 81 opened because Passage A links it. No numerical work was done and no scripts were written. Every value used is exact or an exact rational bound checked by hand. The log is [agent_logs/verify-L20-v377.log](../agent_logs/verify-L20-v377.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | The cubic expansion $m=\cos^3\varphi+3\cos\varphi\sin^2\varphi\,\alpha+\sin^3\varphi\,\gamma_V$ is exact with no linear term | CONFIRMED |
| 2 | The three stated geometric hypotheses (invariance of $d$, compact embedded orbit, first variation) hold | CONFIRMED |
| 3 | $\alpha\le\tfrac13$ for $n\ge12$ | CONFIRMED given Lemma L21 (Passage B) |
| 4 | $\gamma_V\le m$ | CONFIRMED |
| 5 | $m\le\psi(\varphi)$ and $\psi\le1$ on $[0,0.5748]$, via $s^2(1-s)(1-s-s^2-s^3)\ge0$ | CONFIRMED AS ALGEBRA |
| 6 | $\sin(0.5748)<s^*$ | CONFIRMED |
| 7 | A unit Weyl operator with $P>\sqrt{3/2}$ exists for every $n\ge12$, both parities | CONFIRMED given the witness value $\Theta_n$ |
| 8 | Detail entry: the contradiction is with "the value $\theta_0(n)>\theta^*$ the sphere product attains" | REFUTED AS STATED at odd $n$, harmless to the conclusion |
| 9 | Heading and detail entry state L20 with no condition | CONFIRMED given L21 as a lemma, inconsistent with the landscape entry's own "conditional" wording |

**Summary: the conclusion of L20 holds for every $n\ge12$ from the passages, on two hypotheses the heading and detail entry do not write (Lemma L21 as a proved input, and a unit Weyl operator attaining $\Theta_n$), and the detail entry's named witness $\theta_0(n)$ is the wrong one at odd $n$.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors with the Frobenius inner product, $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$.
- $T(X,Y,Z)=\langle\tfrac12(XY+YX)+X\#Y,Z\rangle$, where $X\#Y$ is the polarisation of $\#$ with $X\#X=X^\#$.
- $u=W_{\mathbb{CP}^2}$ padded to unit norm, $Q(u)=\theta^*u$ in the sense $\langle Q(u),Z\rangle=\theta^*\langle u,Z\rangle$ for $Z\in\mathcal W_n$, $\theta^*=\sqrt{3/2}$.
- $\mathcal O=SO(n).u$, $d$ is geodesic angular distance, $\cos d(X,Y)=\langle X,Y\rangle$, $d(X,\mathcal O)=\min_{Y\in\mathcal O}d(X,Y)$ ([conventions.md](../findings/conventions.md) line 81).
- $m=\sqrt{2/3}\max\{P(W):\lVert W\rVert=1\}$, $s=\sin\varphi$, $c=\cos\varphi$.
- $\Theta_n$ is the diagonal maximum: $\theta_0(n)$ at even $n$, $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$ ([conventions.md](../findings/conventions.md) lines 18 and 19).

## Hypothesis inventory

- **H1 (written in Passage A).** $d$ is $SO(n)$-invariant. Holds: conjugation by $g\in SO(n)$ acts on $\Lambda^2\mathbb R^n$ orthogonally, hence orthogonally on $\mathcal W_n$, and preserves inner products.
- **H2 (written in Passage A).** $\mathcal O$ is a compact embedded submanifold of the unit sphere, so a nearest point exists and first variation holds. Holds: an orbit of a smooth action of a compact Lie group is a compact embedded submanifold, and it lies in the unit sphere by H1.
- **H3 (written in Passage A).** $\varphi>0$ for the first-variation step, with $\varphi=0$ treated separately. Holds as a case split.
- **H4 (unwritten in heading and detail, written as a debt in Passage A and the landscape entry).** Lemma L21: for $n\ge9$, $\alpha\le\tfrac13$ on unit $V\in u^\perp\cap T_u\mathcal O^\perp$. The brief makes L21 a given, and $n\ge12$ lies in its range.
- **H5 (unwritten in the detail entry, given in the brief's definitions).** For every $n\ge12$ some unit $W\in\mathcal W_n$ has $P(W)=\Theta_n$.
- **H6 (standard, unwritten).** $T$ is fully symmetric with $T(X,X,X)=P(X)$, so that $\nabla P=3Q$ and $T(u,h,h)=\langle F_uh,h\rangle$. Holds, see section 1.

## 1. The expansion (claims 1 and 4)

- For symmetric operators $\mathrm{tr}(XYZ)=\mathrm{tr}((XYZ)^T)=\mathrm{tr}(ZYX)=\mathrm{tr}(YXZ)$, and with cyclicity this makes $\mathrm{tr}(XYZ)$ invariant under all permutations. So $\langle\tfrac12(XY+YX),Z\rangle$ is fully symmetric.
- $\langle X\#Y,Z\rangle$ is fully symmetric (the standard Böhm–Wilking identity for the Lie-algebraic $\#$). Hence $T$ is fully symmetric and $T(X,X,X)=\langle X^2+X^\#,X\rangle=P(X)$, which is H6.
- Let $W^*$ be any maximizer and $\varphi=d(W^*,\mathcal O)\le0.5748$. By H2 a nearest point $g.u$ exists. Replace $W^*$ by $g^{-1}.W^*$: it is still a maximizer since $P$ is invariant, and its distance to $\mathcal O$ is unchanged by H1. Now $u$ is nearest.
- If $\varphi>0$, write $W^*=cu+sV$ with $V=(W^*-cu)/s$, a unit vector of $\mathcal W_n$ orthogonal to $u$ because $\langle W^*,u\rangle=c$.
- First variation: $u$ maximises $Y\mapsto\langle W^*,Y\rangle$ on $\mathcal O$, so $\langle W^*,\xi\rangle=0$ for $\xi\in T_u\mathcal O$. Since $\mathcal O$ lies in the unit sphere, $\langle u,\xi\rangle=0$, so $\langle V,\xi\rangle=0$. Thus $V\in u^\perp\cap T_u\mathcal O^\perp$.
- Trilinear expansion: $P(cu+sV)=c^3P(u)+3c^2sT(u,u,V)+3cs^2T(u,V,V)+s^3P(V)$, exact because $P$ is a cubic form.
- $T(u,u,V)=\langle Q(u),V\rangle=\theta^*\langle u,V\rangle=0$, so the linear term vanishes. $T(u,V,V)=\langle F_uV,V\rangle$ with $F_u(h)=\tfrac12(uh+hu)+u\#h$.
- Multiplying by $\sqrt{2/3}$ and using $\sqrt{2/3}\,\theta^*=1$ gives the displayed expansion exactly. Claim 1 CONFIRMED.
- $\gamma_V=\sqrt{2/3}P(V)\le m$ because $V$ is a unit element of $\mathcal W_n$. Claim 4 CONFIRMED.

## 2. The bootstrap inequality (claims 3 and 5)

- $\varphi\in[0,0.5748]\subset[0,\pi/2]$ since $0.5748<1.5<\pi/2$, so $c>0$ and $s\ge0$.
- By H4, $\alpha\le\tfrac13$, and $3cs^2\ge0$ gives $3cs^2\alpha\le cs^2$. By claim 4 and $s^3\ge0$, $s^3\gamma_V\le s^3m$.
- So $m\le c^3+cs^2+s^3m=c+s^3m$, using $c^2+s^2=1$. Since $s\le0.5748<1$, $1-s^3>0$ and $m\le\psi(\varphi)=c/(1-s^3)$.
- $\psi\le1$ is $c\le1-s^3$. Both sides are positive, so it is equivalent to $1-s^2\le(1-s^3)^2$.
- $(1-s^3)^2-(1-s^2)=s^2-2s^3+s^6=s^2(s^4-2s+1)$, and $(s-1)(s^3+s^2+s-1)=s^4-2s+1$ by expansion. So the difference is $s^2(1-s)(1-s-s^2-s^3)$.
- For $0\le s<1$ this is nonnegative exactly when $s=0$ or $s^3+s^2+s\le1$. The cubic $s^3+s^2+s-1$ has derivative $3s^2+2s+1>0$, value $-1$ at $0$ and $2$ at $1$, so it has one real root $s^*\in(0,1)$ and the condition is $s\le s^*$.
- Claim 5 CONFIRMED AS ALGEBRA. The Lean lemma max_le_one_of_sin_le in Passage D carries the same chain with the bound $\sin\varphi\le0.54368$ and $0.54368^3+0.54368^2+0.54368<1$.

## 3. The radius (claim 6)

- $\sin$ is increasing on $[0,\pi/2]$, so $s\le\sin(0.5748)$.
- For $x\ge0$: $\sin x\le x$ integrates to $\cos x\ge1-x^2/2$, then $\sin x\ge x-x^3/6$, then $\cos x\le1-x^2/2+x^4/24$, then $\sin x\le x-x^3/6+x^5/120$.
- At $x=0.5748$: $x^2=0.33039504$ and $x^3=0.189911068992$ exactly, so $x^3/6=0.031651844832$ exactly. Also $x^5=x^3x^2<0.19\cdot0.3304=0.062776$, so $x^5/120<0.0005232$.
- Hence $\sin(0.5748)<0.5748-0.031651844832+0.0005232=0.543671355168<0.543672$.
- TubeRadius.lean's bracket_tight gives $\mathrm{cubic}(0.5436890)<0$, and strict monotonicity on $[0,\infty)$ gives $s^*>0.5436890>0.543672$. Claim 6 CONFIRMED.
- Remark, outside the step: in L20Statement.lean the declaration sin_radius_le is closed by sorry. The prose argument above does not use it, so this is a gap in the formalisation only.

## 4. The witness by parity (claims 7 and 8)

- With $m\le1$, $\max P\le\sqrt{3/2}$, and a contradiction needs a unit Weyl operator with $P>\sqrt{3/2}$, that is H5 with $\Theta_n>\sqrt{3/2}$.
- Even $n$: $\Theta_n^2=\theta_0(n)^2=2(n-1)(n-2)/n^2>3/2$ iff $4(n^2-3n+2)>3n^2$ iff $n^2-12n+8>0$ iff $n>6+2\sqrt7$ (the smaller root $6-2\sqrt7<1$). Since $(2\sqrt7)^2=28<36$, $6+2\sqrt7<12$, so every even $n\ge12$ qualifies.
- Odd $n$: $\Theta_n^2>3/2$ iff $4(n-1)(n-3)>3(n+1)(n-2)$ iff $4n^2-16n+12>3n^2-3n-6$ iff $n^2-13n+18>0$. Its larger root is $(13+\sqrt{97})/2<(13+10)/2=11.5$, so every odd $n\ge13$ qualifies.
- So for every $n\ge12$, $m\ge\sqrt{2/3}\,\Theta_n>1$, contradicting $m\le1$. Claim 7 CONFIRMED given H5.
- **Where the detail entry fails as written.** Passage C, line 1065: *"forces $\max P\le\theta^*$, contradicting the value $\theta_0(n)>\theta^*$ the sphere product attains."* At odd $n$ there is no balanced sphere product, and the best odd split attains $\Theta_n<\theta_0(n)$, with $\theta_0(n)^2-\Theta_n^2=8(n-1)/(n^2(n+1)(n-2))>0$. Nothing on the brief's passages shows any unit Weyl operator attains $\theta_0(n)$ at odd $n$.
- **Arguing the opposite.** The inequality $\theta_0(n)>\theta^*$ is true at odd $n\ge13$ as arithmetic, and the lemma's statement sentence never names the witness. The step's conclusion survives because $\Theta_n$ also clears $\theta^*$ from $n=13$ at odd $n$, which is Passage A's repair. So the defect is a false sentence inside the detail entry's proof gloss, and the stated conclusion of L20 is unaffected. Claim 8 REFUTED AS STATED at odd $n$.

## 5. Degenerate branch and every maximizer

- $\varphi=0$: $W^*\in\mathcal O$, so $m=\sqrt{2/3}P(u)=1$, contradicting $m>1$ from section 4.
- The argument used only $P(W^*)=\max P$, so it applies to every maximizer, which is what "no maximizer" requires. The bound $\varphi\le0.5748$ includes equality, matching "within".

## 6. The conditionality (claim 9)

- The heading (Passage A line 103) and the detail entry's statement (Passage C line 1065) write no condition. The detail entry cites L21 as a lemma.
- The same record's landscape entry (Passage C line 321) calls the chain *"conditional on one input nothing on the record proves"*, and Passage A calls $\alpha\le\tfrac13$ *"the lemma's one unproved input"*. Section 2 shows the input is load-bearing: with $\alpha\le\tfrac12$ the bootstrap gives $m\le c+\tfrac12cs^2+s^3m$, and at small $s$ the right side is $c^3+\tfrac32cs^2+s^3=1+s^3+O(s^4)>1$, so the contradiction is lost at every small $\varphi>0$, in line with Passage A's remark that the interval becomes empty.
- Under the brief's instruction that L21 is a given, H4 holds for $n\ge9\supset n\ge12$ and the unconditional reading is valid. The reading needs L21 to be a proved lemma, which is exactly the condition the landscape entry records and the heading and detail entry omit.

## Verdict for the step

**VALID**, on this reading: L20's conclusion (no maximizer of $P$ on the unit sphere of $\mathcal W_n$ lies within geodesic angular distance $0.5748$ of $SO(n).W_{\mathbb{CP}^2}$) holds for every $n\ge12$. The reading needs:

- **H4**, Lemma L21 as a proved input for $n\ge9$. The heading and detail entry state L20 unconditionally, which is correct only while L21 is taken as given, and the landscape entry's "conditional" wording is the accurate one for the record as it stands.
- **H5**, a unit Weyl operator attaining $\Theta_n$ at each $n\ge12$, with the witness read as $\Theta_n$. The detail entry's "the value $\theta_0(n)>\theta^*$ the sphere product attains" is false at odd $n$ and must be replaced by $\Theta_n$, whose threshold polynomials $n^2-12n+8$ (even) and $n^2-13n+18$ (odd) both clear from $n=12$.
- **H1, H2, H3, H6**, all standard and all holding, as shown in sections 1 and 5.
