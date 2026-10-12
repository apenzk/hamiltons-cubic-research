# Verifier v410, adjudication of step L2 in round L67-r2

*Cold brief: only [ADJ_L67r2_L2.md](ADJ_L67r2_L2.md) was read. No numerical work was done, no scripts were written or run, and every value below is exact and derived by hand. Log: [agent_logs/verify-L67-v410.log](../agent_logs/verify-L67-v410.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | The $\omega$-spectrum of Passage A (three values, multiplicities, $A$) is correct, and the passages derive it | VALID |
| 2 | $\sum\omega=0$ and $\sum\omega^2=3$ at that spectrum | VALID |
| 3 | $p_3(\omega)=-(4m^2-6m-1)A$ | VALID, value stated in Passage D without the intermediate line, supplied below |
| 4 | The $\Lambda^2$ spectrum, $\sum\mu^2=1$ under the same scale $s$, and $p_3(\mu)=A$ | VALID |
| 5 | With Lemma L50's identity, $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ identically in $m\ge2$ | VALID, conditional on L50 as given. Passage D backs the last line by a run, and the hand closure is two lines |
| 6 | "Normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$" | VALID ONLY AS A LABEL for $\lVert M\rVert_F=1$. Under the entrywise 4-index Frobenius norm, $\lVert W\rVert_F=1$ gives $\sum\omega^2=\tfrac34$ |
| 7 | The step is free of anything the sentence leaves unstated | VALID WITH NAMED HYPOTHESES: L50's debt (a) is inherited and load-bearing, and the sign convention for $M$ is fixed only implicitly |
| 8 | Out of scope: Passage C's reparametrisation $\tfrac{2+c}{c}p_3(\mu)-\tfrac1cp_3(\omega)$ reproduces the display at $\beta=2\langle M^\#,M\rangle$ | FAILS, at $c=2$ it gives $2p_3(\mu)-\tfrac12p_3(\omega)$, not $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ |

**Summary: at the balanced product the two spectra give $p_3(\mu)=A$ and $p_3(\omega)=-(4m^2-6m-1)A$, so L50 yields $\theta=(m-1)(2m-1)A=\sqrt{(m-1)(2m-1)}/m=\theta_0(2m)$ exactly for every $m\ge2$, and the step is valid conditional on Lemma L50 with the normalisation read as L50's $\lVert M\rVert_F=1$.**

## 0. Conventions, fixed once

Quoted from the brief.

- "$S^2_0$ is the space of trace-free symmetric $n\times n$ matrices, $p_3$ the sum of cubes of a spectrum, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$."
- "A 4-tensor $W$ acts on $\Lambda^2\mathbb R^n$ as the operator $M$. The passages use both $\lVert W\rVert_F$ and $\lVert M\rVert_F$, and fix no relation between them beyond what they state."
- Passage E: "$(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$", Li's $iklj$ order, which "is load-bearing".
- Passage C (L50): "Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$ ... Then $\theta=\langle W,Q(W)\rangle=\tfrac32\,p_3(\mu)-\tfrac12\,p_3(\omega)$, $\sum\mu=\sum\omega=0$, $\sum\mu^2=1$, $\sum\omega^2=3$."
- Passage A: "With $R_{ijij}$ the sectional curvature".

## 1. Hypothesis inventory

| Hypothesis | What it is | Status |
|---|---|---|
| H1 | $W=G^{(1)}+G^{(2)}-cG$ with $c=\frac{m-1}{2m-1}$ is an algebraic Weyl tensor, so L50 applies | HOLDS. $G^{(a)}$ and $G$ are algebraic curvature tensors (pair symmetry, antisymmetry, Bianchi), $\mathrm{Ric}(G^{(a)})=(m-1)P_a$, $\mathrm{Ric}(G)=(2m-1)I$, so $\mathrm{Ric}(W)=(m-1)I-c(2m-1)I=0$. For an Einstein tensor the Weyl part is $R-\frac{\mathrm{scal}}{n(n-1)}G$ with $\frac{2m(m-1)}{2m(2m-1)}=c$, standard |
| H2 | The normalisation is L50's $\lVert M\rVert_F=1$, equivalently $\sum\mu^2=1$ and $\sum\omega^2=3$ | HOLDS UNDER THE READING $\lVert W\rVert_F:=\lVert M\rVert_F$. Both sums are checked at scale $s$ in the passages and below. See Section 2.6 for the entrywise norm |
| H3 | $M$ is the curvature operator with $M_{(ij),(kl)}=W_{ijkl}$ on the orthonormal basis $e_i\wedge e_j$, $i<j$, so the unit sphere acts as $+\mathrm{Id}$ | IMPLICIT. Passage A fixes $R_{ijij}$ as sectional curvature, and Passage D uses "$R$ acts on $\Lambda^2$ as the identity", which is this convention. The opposite sign negates $p_3(\mu)$ and breaks the equality, so it is load-bearing |
| H4 | $\mathring W$ in Li's $iklj$ order | STATED (Passages A, B, E) and used |
| H5 | Lemma L50's identity with coefficients $(\tfrac32,-\tfrac12)$ holds at $n=2m\ge4$ | GIVEN, carrying debt (a) of Passage C, which is exactly the coefficient pair. Debt (b) and the "only there" gap concern $n\le5$ collapse and do not enter this step |
| H6 | $\theta$ is defined by the left side of L50, $\langle W,Q(W)\rangle$ | $Q$ is undefined in the passages, so the value of $\theta$ at this $W$ reaches the step only through H5 |

## 2. The argument

### 2.1 The second-kind operator

For $G^{(a)}_{ijkl}=(P_a)_{ik}(P_a)_{jl}-(P_a)_{il}(P_a)_{jk}$, the $iklj$ contraction gives $\sum_{k,l}\big((P_a)_{il}(P_a)_{kj}-(P_a)_{ij}(P_a)_{kl}\big)h_{kl}=(P_ahP_a)_{ij}-t_a(P_a)_{ij}$, using $h$ symmetric. With $P_a=I$ this is $h-\operatorname{tr}(h)I=h$ on $S^2_0$. Hence Passage A's formula $\mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-ch$ holds.

- Within factor $a$, $h=P_ahP_a$, $t_a=0$: the other factor's terms vanish and $t_b=\operatorname{tr}(P_bP_ahP_a)=0$, so the eigenvalue is $1-c=\frac m{2m-1}$, on a space of dimension $2\big(\frac{m(m+1)}2-1\big)=(m-1)(m+2)$.
- Cross block, $h=P_1hP_2+P_2hP_1$: $P_ahP_a=0$ and $t_1=\operatorname{tr}(P_1hP_2)=\operatorname{tr}(P_2P_1h)=0$, likewise $t_2=0$, so the eigenvalue is $-c=-\frac{m-1}{2m-1}$, dimension $m^2$.
- Line $h=P_1-P_2$: $P_1hP_1=P_1$, $P_2hP_2=-P_2$, $t_1=m$, $t_2=-m$, so $\mathring Wh=(1-m-c)h$ with $1-m-c=-(m-1)\frac{2m}{2m-1}$.

The three spaces are mutually orthogonal in the Frobenius product and their dimensions sum to $2m^2+m-1=\dim S^2_0(\mathbb R^{2m})$, so the spectrum is complete. The three values are distinct for $m\ge2$ since $\frac m{2m-1}>0>-\frac{m-1}{2m-1}>-\frac{2m(m-1)}{2m-1}$.

Screen, not evidence: Li's product rule in Passage D, specialised to unit $S^m$ factors ($\mathring R_a=\mathrm{Id}$ on $S^2_0(\mathbb R^m)$, $\rho_a=m-1$), gives $1$, $0^{(m^2)}$ and $-(m-1)$, and subtracting $c$ reproduces the three values above.

### 2.2 Normalisation of $\omega$

Unnormalised, $\sum\omega^2=\frac{m^2(m-1)(m+2)+m^2(m-1)^2+4m^2(m-1)^2}{(2m-1)^2}=\frac{m^2(m-1)(6m-3)}{(2m-1)^2}=\frac{3m^2(m-1)}{2m-1}$. The scale $s=\sqrt{(2m-1)/(m^2(m-1))}$ makes it $3$, and $s\frac m{2m-1}=mA$ with $A=\frac s{2m-1}=\frac1{m\sqrt{(m-1)(2m-1)}}$, since $A^2=\frac1{m^2(m-1)(2m-1)}$.

Directly on the normalised values: $\sum\omega=A\,m(m-1)\big[(m+2)-m-2\big]=0$ and $\sum\omega^2=A^2m^2(m-1)\big[(m+2)+(m-1)+4(m-1)\big]=3A^2m^2(m-1)(2m-1)=3$.

### 2.3 $p_3(\omega)$

$p_3(\omega)=A^3\big[m^3(m-1)(m+2)-m^2(m-1)^3-8m^3(m-1)^3\big]=A^3m^2(m-1)\big[m^2+2m-(m-1)^2-8m(m-1)^2\big]$.

The bracket is $4m-1-8m^3+16m^2-8m=-(8m^3-16m^2+4m+1)=-(2m-1)(4m^2-6m-1)$, checked by expansion: $(2m-1)(4m^2-6m-1)=8m^3-12m^2-2m-4m^2+6m+1$.

With $A^3m^2(m-1)(2m-1)=A\cdot A^2m^2(m-1)(2m-1)=A$, this gives $p_3(\omega)=-(4m^2-6m-1)A$, Passage D's value.

### 2.4 The $\Lambda^2$ side

Under H3, each $G^{(a)}$ acts on $\Lambda^2$ as the projection onto $\Lambda^2(\operatorname{im}P_a)$, since $G^{(a)}_{ijkl}$ for $i<j$, $k<l$ is $\delta_{ik}\delta_{jl}$ when both indices lie in factor $a$ and $0$ otherwise. $G$ acts as $\mathrm{Id}$. So $W$ has eigenvalue $1-c=\frac m{2m-1}$ on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$, dimension $m(m-1)$, and $-c$ on the mixed part $\mathbb R^m\wedge\mathbb R^m$, dimension $m^2$. The dimensions sum to $m(2m-1)=\dim\Lambda^2\mathbb R^{2m}$.

Unnormalised $\sum\mu^2=\frac{m^3(m-1)+m^2(m-1)^2}{(2m-1)^2}=\frac{m^2(m-1)(2m-1)}{(2m-1)^2}=\frac{m^2(m-1)}{2m-1}$, one third of the $\omega$ sum, so the same $s$ gives $\sum\mu^2=1$. This is the consistency that makes H2 coherent: one scalar multiple of $W$ meets both of L50's normalisations at once. Also $\sum\mu=A\,m(m-1)\big[m-m\big]=0$.

$p_3(\mu)=A^3\big[m^3\cdot m(m-1)-(m-1)^3m^2\big]=A^3m^2(m-1)\big[m^2-(m-1)^2\big]=A^3m^2(m-1)(2m-1)=A$.

### 2.5 The closure

By L50 (H5), $\theta=\tfrac32A+\tfrac12(4m^2-6m-1)A=\tfrac12(4m^2-6m+2)A=(2m^2-3m+1)A=(m-1)(2m-1)A$.

So $\theta=\frac{(m-1)(2m-1)}{m\sqrt{(m-1)(2m-1)}}=\frac{\sqrt{(m-1)(2m-1)}}m$.

And $\theta_0(2m)=\frac{\sqrt{2(2m-1)(2m-2)}}{2m}=\frac{\sqrt{4(2m-1)(m-1)}}{2m}=\frac{\sqrt{(m-1)(2m-1)}}m$.

The two agree for every $m\ge2$, with no radical to resolve. Passage D's "residual radical" identity $\sqrt{4m^4-12m^3+13m^2-6m+1}=2m^2-3m+1$ is also correct for $m\ge2$, since $(2m^2-3m+1)^2=4m^4-12m^3+13m^2-6m+1$ and $2m^2-3m+1=(m-1)(2m-1)>0$, but the passages back that line by a run, and the hand closure above replaces it.

Screen, not evidence: Passage D's remark that $A$ equals $2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$ at $n=2m$ holds, since that expression is $\frac{2\sqrt2}{2m\sqrt2\sqrt{(2m-1)(m-1)}}=A$. It does not enter the step.

### 2.6 The normalisation label

Passages A and B say "normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation". Read literally with $\lVert W\rVert_F^2=\sum_{i,j,k,l}W_{ijkl}^2$, this is off by a factor. Standard mathematics:

- Each unordered pair appears in two orders, so $\sum_{i,j,k,l}W_{ijkl}^2=4\sum_{i<j,\,k<l}W_{ijkl}^2=4\lVert M\rVert_F^2=4\sum\mu^2$.
- The operator $K:h\mapsto\sum_{k,l}W_{iklj}h_{kl}$ on all $n\times n$ matrices has matrix $K_{(ij),(kl)}=W_{iklj}$, which is symmetric in the two double indices by pair symmetry, so $\operatorname{tr}K^2=\sum W^2$. $K$ commutes with transposition, kills $I$ (trace of $W$ is zero) and preserves $S^2_0$, so $\operatorname{tr}K^2=\sum\omega^2+\operatorname{tr}(K|_{\Lambda^2})^2$. On antisymmetric $h$ the Bianchi identity gives $2\sum_{k,l}W_{iklj}h_{kl}=-\sum_{k,l}W_{ijkl}h_{kl}$, and in the orthonormal basis $(E_{ij}-E_{ji})/\sqrt2$ the right side is $-2M$, so $K|_{\Lambda^2}=-M$ and $\operatorname{tr}(K|_{\Lambda^2})^2=\sum\mu^2$.
- Hence $\sum\omega^2=3\sum\mu^2$, which is L50's norm relation, and $\sum_{i,j,k,l}W_{ijkl}^2=4\sum\mu^2=\tfrac43\sum\omega^2$.

So the entrywise $\lVert W\rVert_F=1$ gives $\sum\mu^2=\tfrac14$ and $\sum\omega^2=\tfrac34$, and L50's $\lVert M\rVert_F=1$ corresponds to entrywise $\lVert W\rVert_F=2$. At the entrywise normalisation, L50's hypothesis fails and $\theta$, being cubic in $W$, would be $\theta_0(2m)/8$.

This does not break the step, because the step's "same point" is fixed by the computation itself: the passages normalise by $\sum\omega^2=3$ and verify $\sum\mu^2=1$, which is exactly L50's hypothesis. The strongest reading is that "$\lVert W\rVert_F$" names $\lVert M\rVert_F$, and the gloss "which is $\sum\omega^2=3$" states that identification. The label is a presentational defect in the result's statement, recorded here and outside the step's value.

### 2.7 What the sentence leaves unstated, and the defence

The sentence under adjudication compresses five things. Each is supplied by Passage D or by the lines above.

- The $\Lambda^2$ spectrum and its normalisation: Passage D, checked in 2.4.
- The value $p_3(\omega)$: stated in Passage D with "Hence", derived in 2.3.
- The final arithmetic: Passage D cites a run, and 2.5 gives the two-line closure.
- The sign convention H3: implicit in "$R_{ijij}$ the sectional curvature" and in Passage D's "$R$ acts on $\Lambda^2$ as the identity", the standard convention in which the round sphere has positive curvature operator. Under the opposite sign, $\theta$ would be $-\tfrac32A+\tfrac12(4m^2-6m-1)A=(2m^2-3m-2)A$, which differs from $\theta_0(2m)$ by $3A\neq0$.
- The dependence on L50: the step says "with Lemma L50", and Passage C presents L50 as a given whose debt (a), $\beta=2\langle M^\#,M\rangle$, fixes the coefficient pair. The step is therefore exactly as strong as L50 at $n=2m$. Since $Q$ is undefined in the passages (H6), no independent check of $\theta$ at this $W$ is possible from the brief.

Attempted failure: the only candidate defects are the normalisation label (2.6) and the conditionality on L50. The first is resolved by the passages' own operative normalisation, and the second is the declared structure of the step. Neither locates an incorrect inference from the stated premises.

### 2.8 Out of scope observation on Passage C

Passage C's italic remark says "with $\beta=c\sigma$ the identity reads $\tfrac{2+c}{c}p_3(\mu)-\tfrac1cp_3(\omega)$". For the display to be the case $\beta=2\langle M^\#,M\rangle$, the remark must return $(\tfrac32,-\tfrac12)$ at $c=2$. It returns $(\tfrac{4}{2},-\tfrac12)=(2,-\tfrac12)$. No $c$ matches both coefficients, since $\tfrac1c=\tfrac12$ forces $c=2$ and $\tfrac{2+c}c=\tfrac32$ forces $c=4$. The remark is internally inconsistent with the display it annotates. This concerns L50's block, and the step uses L50's display, so it does not change the verdict here. It should be routed to L50's owner.

**Verdict: VALID**
