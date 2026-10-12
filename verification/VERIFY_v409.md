# Verifier v409, adjudication of step L2 in round L67-r2

Cold brief ([ADJ_L67r2_L2.md](ADJ_L67r2_L2.md)) read in full and nothing else in the repository. No numerical work: every value below is exact and derived by hand, no scripts were written or run. Log: agent_logs/verify-L67-v409.log.

| # | Claim | Verdict |
|---|---|---|
| 1 | $W=G^{(1)}+G^{(2)}-\frac{m-1}{2m-1}G$ is the Weyl tensor of the unit $S^m\times S^m$ | PROVEN |
| 2 | The unnormalised $\Lambda^2$ spectrum is $\frac m{2m-1}$ (mult. $m(m-1)$) and $-\frac{m-1}{2m-1}$ (mult. $m^2$), with the positive convention in which the round $G$ acts as the identity | PROVEN |
| 3 | The unnormalised $\omega$ spectrum and its sum of squares $\frac{3m^2(m-1)}{2m-1}$, three times the $\mu$ one | PROVEN |
| 4 | One scale $s$ gives $\sum\mu^2=1$ and $\sum\omega^2=3$ at once, which is Lemma L50's normalisation | PROVEN |
| 5 | $p_3(\mu)=A$ | PROVEN |
| 6 | $p_3(\omega)=-(4m^2-6m-1)A$ | PROVEN (stated without algebra in Passage D, supplied here) |
| 7 | $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ identically in $m$ | PROVEN (run-cited in Passage D, closed here by one line of exact algebra) |
| 8 | $\theta=\theta_0(2m)$ at the normalised point, via Lemma L50 | VALID, conditional on Lemma L50 as a given |
| 9 | Independent screen: $\langle M,M^2+M^\#\rangle=\theta_0(2m)$ in Hamilton's convention | AGREES (screen, reading of $Q$ assumed) |
| 10 | The name "$\lVert W\rVert_F=1$" as the 4-index Frobenius norm | MISNAMED under that reading, harmless under the reading the passages fix |

**Summary: the step is valid: the two spectra quoted in Passages A and D, normalised by the single scale $s$ that realises Lemma L50's $\sum\mu^2=1$, $\sum\omega^2=3$, give $\tfrac32A+\tfrac12(4m^2-6m-1)A=(m-1)(2m-1)A=\sqrt{(m-1)(2m-1)}/m=\theta_0(2m)$ exactly, conditional on Lemma L50 as given, with the $p_3(\omega)$ algebra and the closure left undisplayed on the record and supplied here.**

## 0. Conventions, fixed once

Quoted from the brief.

- "$S^2_0$ is the space of trace-free symmetric $n\times n$ matrices, $p_3$ the sum of cubes of a spectrum, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$."
- "A 4-tensor $W$ acts on $\Lambda^2\mathbb R^n$ as the operator $M$. The passages use both $\lVert W\rVert_F$ and $\lVert M\rVert_F$, and fix no relation between them beyond what they state."
- Passage E: "$(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$", Li's $iklj$ order.
- Passage C (Lemma L50): "$\theta=\langle W,Q(W)\rangle=\tfrac32\,p_3(\mu)-\tfrac12\,p_3(\omega),\qquad \sum\mu=\sum\omega=0,\quad\sum\mu^2=1,\quad\sum\omega^2=3$", with $\lVert M\rVert_F=1$.
- Passage A: "$G^{(a)}_{ijkl}=(P_a)_{ik}(P_a)_{jl}-(P_a)_{il}(P_a)_{jk}$", $R_{ijij}$ the sectional curvature, $c=\frac{m-1}{2m-1}$, $A=\frac1{m\sqrt{(m-1)(2m-1)}}$.

Throughout, $d=2m-1$ and $m\ge2$.

## 1. Hypothesis inventory

- **H1, Lemma L50 holds as stated.** Needed, and taken as a given by the brief. Its own block records two underived links (Passage C). The step inherits these debts and adds none. Section 3 gives an independent screen at this point that does not route through L50.
- **H2, the $\Lambda^2$ operator is the positive one.** $M(e_i\wedge e_j)=\sum_{k<l}W_{ijkl}\,e_k\wedge e_l$ on the orthonormal basis $\{e_i\wedge e_j\}_{i<j}$, so that the unit sphere's $G$ acts as $+\mathrm{Id}$. Not written in the sentence. Passage D fixes it implicitly by "$R$ acts on $\Lambda^2$ as the identity on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$", and it agrees with $R_{ijij}$ being the sectional curvature. The sign matters: the opposite sign negates $p_3(\mu)$ and breaks the closure. Checked, holds under the reading.
- **H3, L50's $M$ is this $M$.** Needed so that L50's $\mu$ is the spectrum computed in D. Under H2 it is the standard curvature operator, and the screen of Section 3 confirms the coefficients at this point under that convention. Holds under the reading.
- **H4, the normalisation is L50's.** The sentence speaks of "$\lVert W\rVert_F=1$". The passages define this as "$\sum\omega^2=3$ by Lemma L50's norm relation", which is $\lVert M\rVert_F=1$. Checked in 2.4: one scale realises both. If $\lVert W\rVert_F$ were read as the 4-index norm $\big(\sum_{ijkl}W_{ijkl}^2\big)^{1/2}$, then under H2 $\sum_{ijkl}W_{ijkl}^2=4\sum\mu^2$ and $\sum\omega^2=\tfrac34\sum_{ijkl}W_{ijkl}^2$ at this point (from 2.2 and 2.3), so that reading would give $\sum\omega^2=\tfrac34$, not $3$, and $\theta=\theta_0(2m)/8$. The passages exclude that reading by stating the identification, so the name is imprecise and the value is unaffected.
- **H5, Li's $iklj$ order for $\mathring W$.** Stated in A, B, C and E. Checked in 2.3.
- **H6, $m\ge2$.** Stated. Every radicand $(m-1)(2m-1)$ is positive and every division is by a nonzero quantity.

## 2. The argument

### 2.1 The Weyl tensor

With $P_1+P_2=I$ and an adapted basis, $\mathrm{Ric}(G^{(a)})_{ik}=\sum_j G^{(a)}_{ijkj}=(P_a)_{ik}\operatorname{tr}P_a-(P_a)_{ik}=(m-1)(P_a)_{ik}$, so $\mathrm{Ric}(R)=(m-1)I$ and $\mathrm{scal}=2m(m-1)$. $G$ has $\mathrm{Ric}=(2m-1)I$. A curvature tensor with pure-trace Ricci has Weyl part $R-\frac{\mathrm{scal}}{n(n-1)}G$ (standard Weyl decomposition), and $\frac{2m(m-1)}{2m(2m-1)}=c$. Each $G^{(a)}$ and $G$ is an algebraic curvature tensor, so $W$ has the symmetries and first Bianchi identity, and $\mathrm{Ric}(W)=(m-1)I-c(2m-1)I=0$.

### 2.2 The $\Lambda^2$ spectrum (H2)

For $i<j$ in the same factor $a$, $G^{(a)}_{ijkl}$ with $k<l$ equals $1$ at $(k,l)=(i,j)$ and $0$ otherwise, and $G^{(b)}$, $b\ne a$, vanishes on it. For $i$ in factor 1 and $j$ in factor 2, $(P_1)_{jl}=(P_1)_{jk}=0$ and symmetrically for $P_2$, so $R$ kills the mixed part. $G$ acts as $\mathrm{Id}$. Hence $M=R-c\,\mathrm{Id}$ has $1-c=\frac md$ on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$ (multiplicity $2\binom m2=m(m-1)$) and $-c=-\frac{m-1}d$ on the mixed part (multiplicity $m^2$). Then $\sum\mu=\frac{m^2(m-1)-m^2(m-1)}d=0$ and
$$\sum\mu^2=\frac{m^3(m-1)+m^2(m-1)^2}{d^2}=\frac{m^2(m-1)(2m-1)}{d^2}=\frac{m^2(m-1)}d .$$

### 2.3 The $\omega$ spectrum (H5)

$G^{(a)}_{iklj}=(P_a)_{il}(P_a)_{kj}-(P_a)_{ij}(P_a)_{kl}$, so $\sum_{kl}G^{(a)}_{iklj}h_{kl}=(P_ahP_a)_{ij}-t_a(P_a)_{ij}$ with $t_a=\operatorname{tr}(P_ah)$, and $\mathring Gh=h-(\operatorname{tr}h)I=h$ on $S^2_0$. This is Passage A's operator. On its three summands:

- $h=P_ahP_a$, $t_a=0$: $P_1hP_1+P_2hP_2=h$, both $t$ vanish, eigenvalue $1-c=\frac md$, multiplicity $2\big(\binom{m+1}2-1\big)=(m-1)(m+2)$.
- $h=P_1hP_2+P_2hP_1$: $P_ahP_a=0$ and $t_a=\operatorname{tr}(P_ahP_a)=0$, eigenvalue $-\frac{m-1}d$, multiplicity $m^2$.
- $h=P_1-P_2$: $P_1hP_1+P_2hP_2=h$, $t_1=m$, $t_2=-m$, so $-t_1P_1-t_2P_2=-mh$, eigenvalue $1-m-c=\frac{(1-m)d-(m-1)}d=-\frac{2m(m-1)}d$, multiplicity $1$.

Dimensions: $(m-1)(m+2)+m^2+1=2m^2+m-1=\binom{2m+1}2-1$, so the summands fill $S^2_0$. Sum: $\frac{m(m-1)}d\big((m+2)-m-2\big)=0$. Squares:
$$\sum\omega^2=\frac{m^2(m-1)\big((m+2)+(m-1)+4(m-1)\big)}{d^2}=\frac{3m^2(m-1)(2m-1)}{d^2}=\frac{3m^2(m-1)}d ,$$
exactly three times $\sum\mu^2$.

### 2.4 One scale for both (H4)

With $s=\sqrt{d/(m^2(m-1))}>0$, $\sum(s\mu)^2=1$ and $\sum(s\omega)^2=3$ simultaneously, and both trace conditions are scale-invariant. So $sW$ meets every normalisation Lemma L50 lists. The normalised eigenvalues are $\frac{sm}d=mA$, $-\frac{s(m-1)}d=-(m-1)A$ and $-\frac{2sm(m-1)}d=-2m(m-1)A$, since $\frac sd=\frac1{\sqrt{d}\,m\sqrt{m-1}}=A$. Two useful forms: $A^2m^2(m-1)=\frac1d$, and $A\,(m-1)(2m-1)=\frac{\sqrt{(m-1)(2m-1)}}m$.

### 2.5 The two cubes

$$p_3(\mu)=A^3\big(m^3\cdot m(m-1)-(m-1)^3m^2\big)=A^3m^2(m-1)\big(m^2-(m-1)^2\big)=A^3m^2(m-1)\,d=A .$$

$$p_3(\omega)=A^3m^2(m-1)\big(m(m+2)-(m-1)^2-8m(m-1)^2\big)=\frac Ad\big(-8m^3+16m^2-4m-1\big).$$

The bracket: $m^2+2m-(m^2-2m+1)-(8m^3-16m^2+8m)=-8m^3+16m^2-4m-1$. And $(2m-1)(4m^2-6m-1)=8m^3-16m^2+4m+1$, so $p_3(\omega)=-(4m^2-6m-1)A$, Passage D's value.

### 2.6 The closure

$$\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\frac A2\big(3+4m^2-6m-1\big)=(2m^2-3m+1)A=(m-1)(2m-1)A=\frac{\sqrt{(m-1)(2m-1)}}m .$$

$$\theta_0(2m)=\frac{\sqrt{2(2m-1)(2m-2)}}{2m}=\frac{\sqrt{4(m-1)(2m-1)}}{2m}=\frac{\sqrt{(m-1)(2m-1)}}m .$$

The two agree for every $m>1$, so by Lemma L50 $\theta=\theta_0(2m)$ identically in $m$. Passage D's radical identity is also exact: $(2m^2-3m+1)^2=4m^4-12m^3+13m^2-6m+1$. Endpoint sanity at $m=2$: $\theta=\sqrt3/2=\sqrt{12}/4=\theta_0(4)$.

## 3. Screen independent of Lemma L50

This is a hand screen on the object in hand, reported as a screen. It reads $Q(W)$ as Hamilton's $M^2+M^\#$ with $\langle W,Q(W)\rangle=\langle M,M^2+M^\#\rangle$ and the normalisation $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ on $\mathfrak{so}(n)$, which the passages do not write.

Let $\mathfrak h=\mathfrak{so}(m)\oplus\mathfrak{so}(m)$ and $\mathfrak m$ the mixed part, with $[\mathfrak h,\mathfrak h]\subset\mathfrak h$, $[\mathfrak h,\mathfrak m]\subset\mathfrak m$, $[\mathfrak m,\mathfrak m]\subset\mathfrak h$. For $M=x$ on $\mathfrak h$ and $y$ on $\mathfrak m$, the diagonal entry of $M^\#$ at a basis element of one $\mathfrak{so}(m)$ collects $(m-2)x^2$ from pairs inside that $\mathfrak{so}(m)$ and $\big((n-2)-(m-2)\big)y^2=my^2$ from pairs in $\mathfrak m$. At a basis element of $\mathfrak m$ it collects $(n-2)xy=(2m-2)xy$. So
$$\langle M^\#,M\rangle=m(m-1)\,x\big((m-2)x^2+my^2\big)+m^2\,y\,(2m-2)xy .$$
With $x=\frac md$, $y=-\frac{m-1}d$: the first term is $\frac{m^3(m-1)(2m^2-4m+1)}{d^3}$, the second $\frac{2m^3(m-1)^3}{d^3}$, total $\frac{m^3(m-1)(4m^2-8m+3)}{d^3}=\frac{m^3(m-1)(2m-3)}{d^2}$. With $\operatorname{tr}M^3=\frac{m^2(m-1)}{d^2}$ from 2.5, the unnormalised total is $\frac{m^2(m-1)}{d^2}\big(1+m(2m-3)\big)=\frac{m^2(m-1)^2}d$. Multiplying by $s^3=\frac{d^{3/2}}{m^3(m-1)^{3/2}}$ gives $\frac{\sqrt{(m-1)(2m-1)}}m=\theta_0(2m)$.

The screen agrees with Section 2, and at this point it also reproduces L50's coefficients: $p_3(\mu)-2\langle M^\#,M\rangle=\big(1-2m(2m-3)\big)A=-(4m^2-6m-1)A=p_3(\omega)$, which is the relation $\theta=p_3(\mu)+\langle M^\#,M\rangle=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$. So at the balanced product the value does not depend on L50's recorded debts, under this reading of $Q$.

*Observation outside the step.* Passage C's italic parametrisation "with $\beta=c\sigma$ the identity reads $\tfrac{2+c}{c}p_3(\mu)-\tfrac1cp_3(\omega)$" has no $c$ that yields the stated pair $(\tfrac32,-\tfrac12)$: $\tfrac1c=\tfrac12$ forces $c=2$, and then $\tfrac{2+c}c=2$. The family $\tfrac{1+c}{c}p_3(\mu)-\tfrac1cp_3(\omega)$ does give the stated pair at $c=2$ and matches the screen above. This concerns L50's block text, not the step.

## 4. Strongest defence, and where the record falls short

- **Strongest reading.** Under H1 to H6 the sentence's chain is complete and exact: the $\Lambda^2$ spectrum gives $p_3(\mu)=A$ (shown in D), the $\omega$ spectrum of L67 gives $p_3(\omega)$, one scale meets L50's normalisation (shown in D), and the combination equals $\theta_0(2m)$ for all $m\ge2$.
- **Attempted failure, the normalisation.** "$\lVert W\rVert_F=1$" read as the 4-index norm would put the point at $\sum\mu^2=\tfrac14$ and outside L50's hypotheses. The passages close this by defining the normalisation as $\sum\omega^2=3$, and 2.4 shows that is exactly $\sum\mu^2=1$. The name is imprecise, the value stands.
- **Attempted failure, the sign of $M$.** A negative convention flips $p_3(\mu)$ and gives $-\tfrac32A+\tfrac12(4m^2-6m-1)A\ne\theta_0(2m)$. Passage D's "acts as the identity" fixes the positive convention, and the screen confirms it is the one under which L50's coefficients hold here.
- **What the passages leave undisplayed.** The algebra behind $p_3(\omega)=-(4m^2-6m-1)A$ and the closure itself are stated in D with a run citation rather than derived. Both are supplied exactly in 2.5 and 2.6, so this is a presentation gap and the value is right.
- **What is inherited.** The step is as strong as Lemma L50, whose block records underived links. Section 3 removes that dependence at this particular point under Hamilton's reading of $Q$.

**Verdict: VALID**
