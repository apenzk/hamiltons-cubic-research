# Verifier v408, Lemma L67 (the second-kind spectrum of the balanced product), its canonical statement, the evaluation at the balanced product, and the Lean declarations

The brief [BRIEF_L67r2.md](BRIEF_L67r2.md) was read cold, and every check below works from the definitions it quotes. For item 7 only, Li 2022 was read at source ([li-2209.02119.txt](https://arxiv.org/abs/2209.02119) lines 1-125 and 225-640, and page 7 of the PDF). No numerical work was done, no scripts were written, no Lean was built, and every value reported is exact. Hand screens on constructed objects are labelled as screens. The log is [agent_logs/verify-L67-v408.log](../agent_logs/verify-L67-v408.log).

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | "normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation" | HYPOTHESIS-DEBT | holds only when $\lVert W\rVert_F$ denotes $\lVert M\rVert_F$ in the orthonormal $e_i\wedge e_j$ ($i<j$) basis, a reading written nowhere. With the 4-index Frobenius norm, $\sum\omega^2=3/4$ and every eigenvalue halves |
| 2 | $R=G^{(1)}+G^{(2)}$, Ricci $(m-1)I$, $G$'s $(2m-1)I$, $c=\frac{m-1}{2m-1}$, $W=R-cG$ | CONFIRMED | each contraction closes, and $R-cG$ is trace-free and differs from $R$ by a multiple of $G$ |
| 3 | $\mathring G^{(a)}h=P_ahP_a-t_aP_a$, $\mathring Gh=h$ in the $iklj$ order | CONFIRMED | direct contraction, with signs fixed by $G^{(a)}_{ijij}=+1$ |
| 4 | three invariant summands, eigenvalues $\frac m{2m-1}$, $-\frac{m-1}{2m-1}$, $-\frac{2m(m-1)}{2m-1}$, filling $S^2_0$ | CONFIRMED | each eigen-equation closes. Filling needs the summands independent, which the proof leaves implicit but which follows from the block structure |
| 5 | unnormalised $\sum\omega^2=\frac{3m^2(m-1)}{2m-1}$, $s$, $A=s/(2m-1)$, $A>0$ | CONFIRMED | bracket is $3(2m-1)$, and $s/(2m-1)$ reduces to $A$ |
| 6 | $m\ge2$, and "at $m=1$ the product is flat and $W=0$" | CONFIRMED | rank-one $P_a$ gives $G^{(a)}=0$, and $c=0$ |
| 7 | Passage B against Passage A, and "Li's Theorem 1.8 gives the same spectrum as a product rule" | CONFIRMED | every clause and placement matches. Li's theorem gives $\mathring R$, and the shift by $-c$ (stated in Passage D, left implicit in B) returns the same spectrum |
| 8a | $\Lambda^2$ spectrum, "the same scale $s$ normalises both", $p_3(\mu)=A$, $p_3(\omega)$, $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$, the radical | CONFIRMED AS ALGEBRA | closes by hand identically in $m$ |
| 8b | "with Lemma L50 the two spectra return $\theta=\theta_0(2m)$" as a value of $\langle W,Q(W)\rangle$ | HYPOTHESIS-DEBT | inherits L50's underived link (a), and the sign of the $\Lambda^2$ action that makes $p_3(\mu)=+A$ is stated nowhere in the passages |
| 9 | "$A$ is not a new constant", equal to $2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$ at $n=2m$ | CONFIRMED AS ALGEBRA | the quoted closed form reduces to $A$ by hand |
| 10 | Passage F states the lemma | CONFIRMED AS ALGEBRA | the declarations type only scalar identities on the three numbers and multiplicities. No tensor, operator, eigenvector or norm is typed |
| 11 | boundary: $m=2$, zero eigenvalues, $ikjl$ | CONFIRMED | at $m=2$ the spectrum is $\{2A^{(4)},-A^{(4)},-4A^{(1)}\}$ with $A=1/(2\sqrt3)$. No eigenvalue of $\mathring W$ or $M$ vanishes at $m\ge2$, and $ikjl$ negates all three |

**Summary: the spectrum is proven under $\sum\omega^2=3$, and the statement's "$\lVert W\rVert_F=1$" should be restated as $\lVert M\rVert_F=1$ (equivalently $\sum\omega^2=3$), because with the 4-index Frobenius norm it halves every eigenvalue. Passage B's $\theta=\theta_0(2m)$ carries L50's link (a) and an unstated sign convention for $M$.**

## 0. Conventions, fixed once

Quoted from the brief.

- "With $R_{ijij}$ the sectional curvature and $\mathring W$ in Li's $iklj$ order" (Passage A).
- "$(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$" (Passages C and E).
- "$W_{ikjl}$ in place of $W_{iklj}$ negates $\mathring W$ and flips the sign of the bi-spectral identity's $-\tfrac12$ term" (Passage E).
- "Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$ ... $\sum\mu^2=1,\quad\sum\omega^2=3$" (Passage C).
- "$S^2_0$ is the space of trace-free symmetric $n\times n$ matrices, $p_3$ the sum of cubes of a spectrum, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$" (Definitions).
- "The passages use both $\lVert W\rVert_F$ and $\lVert M\rVert_F$, and fix no relation between them beyond what they state" (Definitions).

Working reading used below, and named wherever it matters: $M_{(ij),(kl)}=W_{ijkl}$ in the orthonormal basis $\{e_i\wedge e_j\}_{i<j}$. This is the reading under which Passage D's "$R$ acts on $\Lambda^2$ as the identity on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$" holds.

## 1. Hypothesis inventory

**The statement's hypotheses.**

| Hypothesis | Where the proof uses it | Checked against the object |
|---|---|---|
| $m\ge2$ | $A$ finite and positive, $W\ne0$ so normalisation is possible, the three eigenvalues distinct, the within-factor summand nonempty | yes, see section 7 |
| $n=2m$ | $\dim S^2_0=2m^2+m-1$, $c=\frac{m-1}{2m-1}$ | yes |
| $W$ is the Weyl tensor of $S^m\times S^m$ | $R=G^{(1)}+G^{(2)}$ takes both factors of equal (unit) radius. The overall radius is absorbed by normalisation, but equal radii are load-bearing (unequal radii make the product non-Einstein and the three-summand computation changes). "Balanced" and $S^m\times S^m$ carry this | yes |
| $\lVert W\rVert_F=1$ | used only through "which is $\sum\omega^2=3$". The proof's scale $s$ enforces $\sum\omega^2=3$ | finding 1 |
| $R_{ijij}$ is the sectional curvature | fixes $G^{(a)}_{ijij}=+1$, hence the sign of $\mathring G^{(a)}$ | yes |
| $iklj$ order | fixes the sign of $\mathring W$ | yes |

**Imported results.**

| Import | Its hypotheses | Checked against the object | Used by |
|---|---|---|---|
| Lemma L50's norm relation $\sum\omega^2=3$ at $\lVert M\rVert_F=1$ | $W\in\mathrm{Weyl}_n$, $\lVert M\rVert_F=1$, $iklj$ order | $W=R-cG$ is an algebraic curvature tensor with zero Ricci contraction (section 3), so it is in $\mathrm{Weyl}_{2m}$. At this object the ratio $\sum\omega^2/\sum\mu^2=3$ is confirmed directly by Passage D's two sums (section 9), so the lemma does not depend on the general relation | the statement's normalisation clause only |
| Lemma L50's identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ | as above, plus its own recorded links (a) and (b) | only link (a) enters, since (b) concerns the $n\le5$ collapse | Passage B's last sentence and Passage D's closing identity |
| Li 2022 Theorem 1.8 (Proposition 2.1) | $(M_i,g_i)$ Einstein with $\mathrm{Ric}=\rho_ig_i$, $n_i\ge1$, product metric, curvature $R=R_1\oplus R_2$ | unit $S^m$ has $\mathrm{Ric}=(m-1)g$, $n_i=m\ge2$. Li's (2.3) is exactly $R=G^{(1)}+G^{(2)}$ | the corroborating sentence only, never a step of the proof |

**Hypotheses nobody uses, or used but unstated.** Nothing in the statement goes unused. One convention is used without being stated: the identification of $\lVert W\rVert_F$ with $\lVert M\rVert_F$ (finding 1). Passage B's further claim also uses an unstated sign for the $\Lambda^2$ action (finding 8b).

## 2. Finding 1, the normalisation clause (brief item 1): HYPOTHESIS-DEBT

**Locate.** Passage A: "normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation". Passage C states the norm relation under $\lVert M\rVert_F=1$. The step needs $\lVert W\rVert_F=\lVert M\rVert_F$, and the passages contain no such relation (the brief's Definitions say so).

**Exhibit.** Unnormalised $W=R-cG$ at general $m$, with the working reading of $M$.

- $\lVert M\rVert_F^2=\sum_{i<j,\,k<l}W_{ijkl}^2$. By Passage D's $\Lambda^2$ spectrum this is $\frac{m^2(m-1)}{2m-1}$.
- The 4-index Frobenius norm is $\sum_{i,j,k,l}W_{ijkl}^2=4\lVert M\rVert_F^2=\frac{4m^2(m-1)}{2m-1}$, since each $(i<j,k<l)$ entry appears four times under the antisymmetries.
- The proof's $\sum\omega^2=\frac{3m^2(m-1)}{2m-1}$.

So $\sum\omega^2=\tfrac34\sum_{ijkl}W_{ijkl}^2$. Normalising the 4-index norm to $1$ gives $\sum\omega^2=3/4$, scale $s/2$, and eigenvalues $\tfrac m2A$, $-\tfrac{m-1}2A$, $-m(m-1)A$. That contradicts the statement's values.

*Hand screen at $m=2$, $n=4$, $c=1/3$.* The nonzero entries of $W$ are $W_{ijij}=-W_{ijji}=2/3$ on the 4 ordered same-factor pairs and $W_{ijij}=-W_{ijji}=-1/3$ on the 8 ordered mixed pairs. That gives $\sum_{ijkl}W^2=8\cdot\tfrac49+16\cdot\tfrac19=\tfrac{16}3$, $\lVert M\rVert_F^2=\tfrac43$, and $\sum\omega^2=4\cdot\tfrac49+4\cdot\tfrac19+\tfrac{16}9=4$. So $\sum\omega^2=3\lVert M\rVert_F^2=\tfrac34\sum_{ijkl}W^2$, as above.

The other common convention for $M$ does not rescue the identification. Take $(M\omega)_{ij}=\sum_{kl}W_{ijkl}\omega_{kl}$ without the factor $\tfrac12$. Then $\lVert M\rVert_F$ equals the 4-index norm, but every $\mu$ doubles, $\sum\omega^2/\sum\mu^2$ becomes $3/4$, and Lemma L50's own relation fails. Given L50's relation, no convention for $M$ makes $\lVert M\rVert_F$ equal the 4-index Frobenius norm of $W$.

**Argue the opposite.** The most charitable reading is that the record writes $\lVert W\rVert_F$ as shorthand for the Frobenius norm of $W$'s action on $\Lambda^2$, that is $\lVert M\rVert_F$ (L50's first sentence introduces $W$ "act[ing] on $\Lambda^2\mathbb R^n$ as $M$"). Under that reading the clause is true, and the proof's $s$ meets it (section 9 confirms $\sum\mu^2=1$ at the same $s$). This reading rescues the claim, but it is a convention written nowhere, and the plain reading of a Frobenius norm of a 4-tensor gives wrong eigenvalues by a factor $2$.

**Grade.** HYPOTHESIS-DEBT. What must be written down: "$\lVert W\rVert_F$ denotes $\lVert M\rVert_F$ with $M_{(ij),(kl)}=W_{ijkl}$ on the orthonormal basis $\{e_i\wedge e_j\}_{i<j}$", or the statement should normalise $\sum\omega^2=3$ directly. The scale $s$ in the proof meets $\sum\omega^2=3$, which is the second of the two conditions the statement names.

## 3. The curvature of the product (brief item 2): no finding

- $G^{(a)}_{ijkl}=(P_a)_{ik}(P_a)_{jl}-(P_a)_{il}(P_a)_{jk}$ has $G^{(a)}_{ijij}=1$ for $i\ne j$ in factor $a$, the unit sphere with $R_{ijij}$ sectional. It is antisymmetric in each pair, symmetric under pair swap, and satisfies Bianchi, being the Kulkarni-Nomizu square of $P_a$ up to a factor.
- $R=G^{(1)}+G^{(2)}$ is Li's (2.2)/(2.3) for the unit factors: it vanishes unless all four indices lie in one factor.
- Ricci, with $\mathrm{Ric}_{jl}=\sum_iR_{ijil}$: $\sum_i\big((P_a)_{ii}(P_a)_{jl}-(P_a)_{il}(P_a)_{ji}\big)=m(P_a)_{jl}-(P_a)_{jl}=(m-1)(P_a)_{jl}$. The sum over $a$ is $(m-1)I$. For $G$ the same computation with $\operatorname{tr}I=2m$ gives $(2m-1)I$.
- $R-cG$ has Ricci $(m-1)I-c(2m-1)I=0$ exactly at $c=\frac{m-1}{2m-1}$. The Weyl tensor is the component of $R$ orthogonal to the Kulkarni-Nomizu image of symmetric 2-tensors. $cG$ lies in that image, and $R-cG$ is totally trace-free, so $R-cG$ is that component. The proof's "since $G$ has Ricci tensor $(2m-1)I$" compresses this standard step, and the step holds. Cross-check: $\mathrm{scal}/(n(n-1))=2m(m-1)/(2m(2m-1))=c$.

## 4. The contraction in the $iklj$ order (brief item 3): no finding

- $G^{(a)}_{iklj}=(P_a)_{il}(P_a)_{kj}-(P_a)_{ij}(P_a)_{kl}$.
- So $(\mathring G^{(a)}h)_{ij}=\sum_{kl}(P_a)_{il}h_{kl}(P_a)_{kj}-(P_a)_{ij}\sum_{kl}(P_a)_{kl}h_{kl}=(P_ahP_a)_{ji}-t_a(P_a)_{ij}=(P_ahP_a-t_aP_a)_{ij}$, using the symmetry of $P_ahP_a$ and $t_a=\operatorname{tr}(P_ah)$.
- With $P_a\to I$: $\mathring Gh=h-(\operatorname{tr}h)I=h$ on $S^2_0$.
- The sign matches Passage E and Li's Example 2.1 ($\mathring R=\kappa\,\mathrm{id}_{S^2_0}$ on $S^n(\kappa)$).
- $\mathring Wh$ is trace-free without projection: $\operatorname{tr}\mathring Wh=t_1+t_2-m(t_1+t_2)=(1-m)\operatorname{tr}h=0$. So the record's operator without $\pi$ agrees with Li's $\pi\circ\mathring R$ here (see withdrawn W3).
- Passage E's matrix form follows from $h=\tfrac12\sum h_{ij}e_i\odot e_j$. The output coefficient is $\sum_{ij}R_{iklj}h_{ij}$ at $(k,l)$, which is symmetric in $(k,l)$ because $R_{ilkj}=R_{kjil}$ and relabelling $i\leftrightarrow j$ returns $R_{iklj}$. Relabelled, it is $(\mathring Wh)_{ij}=\sum W_{kijl}h_{kl}$ with $W_{kijl}=W_{iklj}$.

## 5. The three summands (brief item 4): no finding

- **Within factor 1** ($h=P_1hP_1$, $t_1=0$): $P_2hP_2=P_2P_1hP_1P_2=0$ and $t_2=\operatorname{tr}(P_2P_1hP_1)=0$. So $\mathring Wh=h-ch=\frac m{2m-1}h$. The space is trace-free symmetric $m\times m$, of dimension $\binom{m+1}2-1$. Factor 2 is symmetric. Total $m(m+1)-2=(m-1)(m+2)$.
- **Cross block** ($P_1hP_1=P_2hP_2=0$): $t_a=\operatorname{tr}(P_ah)=\operatorname{tr}(P_ahP_a)=0$. So $\mathring Wh=-ch=-\frac{m-1}{2m-1}h$. The block is an arbitrary $m\times m$ matrix, dimension $m^2$.
- **Line** $h=P_1-P_2$: $t_1=m$, $t_2=-m$, $P_1hP_1=P_1$, $P_2hP_2=-P_2$. So $\mathring Wh=P_1-P_2-mP_1+mP_2-ch=(1-m-c)h$. And $1-m-c=(1-m)\frac{2m}{2m-1}=-\frac{2m(m-1)}{2m-1}$.
- **Invariance** follows from the three eigen-equations.
- **Filling.** Any $h\in S^2_0$ splits by blocks as $P_1hP_1+P_2hP_2+(P_1hP_2+P_2hP_1)$. Then $P_ahP_a=(P_ahP_a-\tfrac{t_a}mP_a)+\tfrac{t_a}mP_a$ and $t_2=-t_1$, so the two scalar parts combine to $\tfrac{t_1}m(P_1-P_2)$. The three summands are mutually orthogonal and span. The proof argues filling by the dimension count alone, which needs independence. Independence holds here, as the block splitting shows and as distinct eigenvalues also give (withdrawn W2).
- **"Exactly three".** At $m\ge2$ the values $\frac m{2m-1}>0>-\frac{m-1}{2m-1}>-\frac{2m(m-1)}{2m-1}$ are distinct (the last inequality is $1<2m$). Each summand is nonzero, so each value is attained.

## 6. The scale and $A$ (brief item 5): no finding

- $\sum\text{mult}\cdot\lambda^2=\frac{m^2(m-1)}{(2m-1)^2}\big[(m+2)+(m-1)+4(m-1)\big]$, and the bracket is $6m-3=3(2m-1)$. So the sum is $\frac{3m^2(m-1)}{2m-1}$, as written.
- $s^2=\frac{2m-1}{m^2(m-1)}$ gives $s^2\cdot\frac{3m^2(m-1)}{2m-1}=3$, with $s>0$.
- $s\cdot\frac m{2m-1}=mA$ with $A=\frac s{2m-1}=\frac{\sqrt{2m-1}}{m\sqrt{m-1}\,(2m-1)}=\frac1{m\sqrt{(m-1)(2m-1)}}$. The other two values scale to $-(m-1)A$ and $-2m(m-1)A$.
- $A>0$ for $m>1$.
- Trace: $(m-1)(m+2)m-m^2(m-1)-2m(m-1)=m(m-1)\big[(m+2)-m-2\big]=0$.

## 7. $m\ge2$ and $m=1$ (brief item 6): no finding

- At $m=1$, $P_a=e_ae_a^{\mathsf T}$ has rank one and $G^{(a)}_{ijkl}=e_ie_ke_je_l-e_ie_le_je_k=0$. So $R=0$, $S^1\times S^1$ is flat, $c=0$ and $W=0$, as stated.
- At $m=1$ the unnormalised values are consistent with this: the within-factor summand has dimension $0$, and $-c=0$ and $1-m-c=0$. The normalisation $\sum\omega^2=3$ is impossible and $A$ has a zero denominator, so $m\ge2$ is exactly the needed range.

## 8. Passage B against Passage A, and Li's Theorem 1.8 (brief item 7): no finding

**Clause by clause.**

- *Landscape entry.* Its hypotheses ($S^m\times S^m$, $n=2m$, $m\ge2$, $\lVert W\rVert_F=1$, $iklj$), the three values, the multiplicities and $A$ all match Passage A. It repeats the $\lVert W\rVert_F$ convention of finding 1 without the "$\sum\omega^2=3$" gloss, so the same debt applies there with less context.
- *Detail entry.* The placements match Passage A's proof: $mA$ on the within-factor trace-free parts, $-(m-1)A$ on the cross block, $-2m(m-1)A$ on $P_1-P_2$.
- "The multiplicities sum to $\dim S^2_0=2m^2+m-1$" and "$W=G^{(1)}+G^{(2)}-\frac{m-1}{2m-1}G$" both match.

**Li's Theorem 1.8 at source** (txt lines 241-249, Proposition 2.1 and Lemmas 2.1-2.3 at lines 318-560, Example 2.3 at lines 596-602). For Einstein factors with $\mathrm{Ric}_i=\rho_ig_i$, $n_i\ge1$, the spectrum of $\mathring R$ on the product is:

- $\mathrm{spec}(\mathring R_1)\cup\mathrm{spec}(\mathring R_2)$,
- $0$ with multiplicity $n_1n_2$ (the cross block $\xi_{pq}$),
- $-\frac{n_1\rho_2+n_2\rho_1}{n_1+n_2}$ with multiplicity one, on $n_2g_1-n_1g_2$.

At unit $S^m\times S^m$ this is $1$ with multiplicity $(m-1)(m+2)$ (Example 2.1 twice), $0$ with multiplicity $m^2$, and $-\frac{2m(m-1)}{2m}=-(m-1)$ with multiplicity one, on $m(P_1-P_2)$. Example 2.3 at $\kappa_i=1$, $n_i=m$ gives the same. Since $\mathring W=\mathring R-c\,\mathrm{id}$ on $S^2_0$ (section 4), the spectrum shifts to $1-c$, $-c$, $-(m-1)-c$ on the same eigenvectors. That is Passage A's unnormalised spectrum, summand by summand.

Li's hypotheses hold at the object (section 1). "Gives the same spectrum as a product rule" is accurate once "after subtracting $c\,\mathrm{id}$ and rescaling" is read in. Passage D states the subtraction explicitly, and Passage B leaves it implicit. That is loose wording and no error.

**Li's index convention.** Li 2022's Section 2 display (PDF page 7) reads $\mathring R(\varphi)_{ij}=\sum_{k,l}R_{ijkl}\varphi_{kl}$. Read literally, this is identically zero on symmetric $\varphi$. Li's own usage is consistent with $iklj$ and $R_{ijij}=+\kappa$ throughout:

- the introduction's bilinear form $R_{ijkl}\varphi_{il}\psi_{jk}$,
- the Lemma 2.1 and 2.2 computations $\sum_{j,k}R(e_i,e_j,e_k,e_l)\varphi(e_j,e_k)$ with output $(i,l)$,
- $\mathring R_i(g_i)=-\mathrm{Ric}(R_i)$ in Lemma 2.3,
- $\mathring R=\kappa\,\mathrm{id}$ on $S^n(\kappa)$.

So Theorem 1.8 transfers to the record's convention with no sign change (withdrawn W1).

## 9. Passage B's further claims and Passage D (brief item 8)

### 9a. The algebra: CONFIRMED AS ALGEBRA

- **$\Lambda^2$ spectrum.** Under the working reading, $R$ is $+\mathrm{Id}$ on $e_i\wedge e_j$ within a factor (dimension $2\binom m2=m(m-1)$) and $0$ on mixed pairs (dimension $m^2$). $G=\mathrm{Id}$. So $W$ has $\frac m{2m-1}$ with multiplicity $m(m-1)$ and $-\frac{m-1}{2m-1}$ with multiplicity $m^2$. The dimensions total $2m^2-m=\binom{2m}2$. Trace: $m(m-1)m-m^2(m-1)=0$.
- **Sum of squares.** $\frac{m^2(m-1)[m+(m-1)]}{(2m-1)^2}=\frac{m^2(m-1)}{2m-1}$, a third of the $\omega$ sum. So the same $s$ gives $\sum\mu^2=1$ and $\sum\omega^2=3$ together, as claimed.
- **$p_3(\mu)$.** $s^3\frac{m^2(m-1)[m^2-(m-1)^2]}{(2m-1)^3}=s^3\frac{m^2(m-1)}{(2m-1)^2}$. With $s^3=\frac{(2m-1)^{3/2}}{m^3(m-1)^{3/2}}$ this is $\frac1{m\sqrt{(m-1)(2m-1)}}=A$.
- **$p_3(\omega)$.** $A^3m^2(m-1)\big[m(m+2)-(m-1)^2-8m(m-1)^2\big]=A^3m^2(m-1)(-8m^3+16m^2-4m-1)$. Since $A^2m^2(m-1)=\frac1{2m-1}$ and $8m^3-16m^2+4m+1=(2m-1)(4m^2-6m-1)$, this is $-(4m^2-6m-1)A$, as Passage D writes.
- **Identity.** $\tfrac32A+\tfrac12(4m^2-6m-1)A=(2m^2-3m+1)A=(2m-1)(m-1)A=\frac{\sqrt{(m-1)(2m-1)}}m$. And $\theta_0(2m)=\frac{\sqrt{2(2m-1)(2m-2)}}{2m}=\frac{\sqrt{(2m-1)(m-1)}}m$. The difference is identically $0$.
- **Radical.** $(2m^2-3m+1)^2=4m^4-12m^3+13m^2-6m+1$, and $2m^2-3m+1=(2m-1)(m-1)\ge0$ for $m\ge1$, so the positive root is the right branch.

Passage D supports "closes symbolically" and "identically zero difference" by pointing to runs. The algebra closes by hand, so no debt remains on those sentences. Passage D's "verified here to $1.8\times10^{-15}$" for Li's formula is run-only support, but Li proves the formula at source (section 8), so nothing rests on the run.

### 9b. Finding 8b, "$\theta=\theta_0(2m)$" as a value of $\langle W,Q(W)\rangle$: HYPOTHESIS-DEBT

**Locate.** Passage B: "with Lemma L50 the two spectra return $\theta=\theta_0(2m)$ identically in $m$". $\theta$ is defined as $\langle W,Q(W)\rangle$ (Passage C), and the passage evaluates it through L50's coefficient pair $(\tfrac32,-\tfrac12)$.

**Which of L50's links it uses.** Link (a), $\beta=2\langle M^\#,M\rangle$, fixes the coefficient pair. Passage C records that "the whole coefficient pair is that constant" and that the link "has no derivation anywhere". So the claim inherits link (a) in full. Link (b), the generalised-Kronecker proportionality, and "only there" concern the $n\le5$ collapse, and this claim does not use them. The norm relation is also used, and it is confirmed at this object by 9a.

**A second unstated input: the sign of $M$.** Passage D's "$R$ acts on $\Lambda^2$ as the identity" holds for $M_{(ij),(kl)}=+R_{ijkl}$. Under $M_{(ij),(kl)}=R_{ijlk}$ (a curvature-operator convention in use elsewhere), $\mu\to-\mu$ and $p_3(\mu)=-A$. Then $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=(2m^2-3m-2)A\ne(2m^2-3m+1)A$, so the value is not $\theta_0(2m)$. The passages fix the scale of $M$ only indirectly, through L50's ratio $3$, and they fix its sign nowhere.

**Argue the opposite.** Charitably, the record's $M$ is $M_{(ij),(kl)}=W_{ijkl}$, the reading consistent with "$R_{ijij}$ the sectional curvature" and with Passage D's own sentence. L50's identity would then be stated in that convention. This makes the sign question a convention to write down, not an error. Link (a), however, is a missing derivation, and it survives any reading.

**Grade.** HYPOTHESIS-DEBT on Passage B's last sentence. What must be proved: L50's link (a), $\beta=2\langle M^\#,M\rangle$, for all $W\in\mathrm{Weyl}_n$ (or at least at this object). What must be stated: the sign and basis convention of $M$. The spectrum of $\mathring W$, which is the lemma, is unaffected.

## 10. "$A$ is not a new constant" (brief item 9): CONFIRMED AS ALGEBRA

At $n=2m$: $\frac{2\sqrt2}{2m\sqrt{(2m-1)(2m-2)}}=\frac{2\sqrt2}{2m\sqrt2\sqrt{(2m-1)(m-1)}}=\frac1{m\sqrt{(m-1)(2m-1)}}=A$. The passage does not say which spectral quantity "$\operatorname{tr}(W^3)$" denotes. Reading it as $\operatorname{tr}(M^3)=p_3(\mu)$ at $\lVert M\rVert_F=1$ makes it agree with 9a. The quoted closed form is a given of the record, and its derivation is outside the brief.

## 11. Passage F against Passage A (brief item 10)

**[L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean)** (over $\mathbb R$, $m:\mathbb R$). It defines `Aconst`, `spec`, `mult` as the three numbers and multiplicities, and proves:

- `Aconst_pos`: $2\le m\Rightarrow A>0$.
- `Aconst_sq`: $A^2=1/(m^2(m-1)(2m-1))$.
- `mult_sum` and `dim_sym_traceless`: the multiplicities total $\frac{2m(2m+1)}2-1$.
- `spec_trace_zero`: $\sum\text{mult}\cdot\text{spec}=0$.
- `spec_normalisation`: $\sum\text{mult}\cdot\text{spec}^2=3$ at $m\ge2$.
- `spec_strict_order`: the three values are strictly ordered, hence distinct.
- `mult_pos`.

I checked each statement's arithmetic by hand, and each is true. The binder $m:\mathbb R$ with $2\le m$ covers more than the integers, which is harmless for a universal statement.

**What is typed.** The scalar consequences only: that the proposed spectrum has trace $0$, sum of squares $3$, three distinct values, and multiplicities filling $\dim S^2_0$.

**What is not typed.**

- No tensor $W$, product curvature, projection $P_a$, operator $\mathring W$, space $S^2_0$, eigenvector, norm $\lVert W\rVert_F$ or $\lVert M\rVert_F$, or index order.
- The claim that $\mathring W$ has these eigenvalues is not stated.
- The $m=1$ examples do not type "$W=0$". `Aconst 1 = 0` holds because Lean sets $1/0=0$, which is a totalisation artefact, not the flatness claim.

**[L67.lean](../lean/HamiltonsCubic/Results/L67.lean)** (over $\mathbb Q$). `multiplicities_sum`, `dim_S2_zero`, `spectrum_traceless` and `sum_squares` (with bracket $3(2m-1)$) are ring identities matching sections 5 and 6.

- `A_from_omega` divides the norm equation by $3$, and its hypothesis `hm` is unused. Over $\mathbb Q$ its premise has no solution at $m=2$ ($A^2=1/12$) or $m=3$ ($A^2=1/90$), so it is vacuous there. It is a correct linear rearrangement all the same (withdrawn W4).
- `A_closed_form` is $x^{-1}x=1$ for $x=m^2(m-1)(2m-1)\ne0$, and it does not mention $A$.
- `multiplicities_at_one`, `A_denominator_vanishes`, `A_sq_at_three` ($9\cdot2\cdot5=90$), `B_block_sq` ($4/90=2/45$, the square of $(m-1)A$ at $m=3$) and `bottom_sq_at_three` ($144/90=8/5$, the square of $2m(m-1)A$ at $m=3$) are all true.
- `B_block_bracket` holds by exact integer squaring: $210818510^2=44444444158620100<\tfrac2{45}\cdot10^{18}<44444445001894144=210818512^2$.

None of these types the operator either.

**Grade.** CONFIRMED AS ALGEBRA. The Lean files state and check the arithmetic of sections 5 and 6, not the lemma.

## 12. The boundary (brief item 11): no finding

- **$m=2$, $n=4$.** Unnormalised $\{2/3^{(4)},-1/3^{(4)},-4/3^{(1)}\}$ on $\dim S^2_0=9$, with sum of squares $4$, matching $\frac{3m^2(m-1)}{2m-1}=4$. Normalised $\{2A,-A,-4A\}$ with $A=\frac1{2\sqrt3}$. Li's Example 2.3 at $n_i=2$ gives $\{1^{(4)},0^{(4)},-1^{(1)}\}$, which shifted by $-\tfrac13$ agrees. Nothing in the proof uses $n\ge5$, and the $n=4$ splitting $W=W^+\oplus W^-$ plays no role.
- **Zero eigenvalues.** At $m\ge2$ all three $\mathring W$ values are nonzero (signs $+,-,-$), so $\ker\mathring W=0$. Both $M$ values $\frac m{2m-1}$ and $-\frac{m-1}{2m-1}$ are nonzero. The $m^2$-dimensional kernel of $\mathring R$ (Li's Lemma 2.1) is moved to $-c\ne0$ by the Weyl shift.
- **$ikjl$ in place of $iklj$.** $W_{ikjl}=-W_{iklj}$ by antisymmetry in the last pair, so all three eigenvalues negate to $-mA$, $(m-1)A$, $2m(m-1)A$. The statement fixes $iklj$, and the signs of section 4 confirm it.

## 13. Withdrawn candidates

- **W1. Li 2022 uses $ijkl$, so Theorem 1.8 is in a different convention.** Located at the Section 2 display on PDF page 7. It fails step 2: read literally the display is the zero operator, which contradicts Li's Example 2.1. It also fails step 3: the introduction, the Lemma 2.1-2.3 computations and $\mathring R_i(g_i)=-\mathrm{Ric}$ all use $iklj$ with $R_{ijij}=+\kappa$. The display is a typo in Li. Withdrawn.
- **W2. "Fill $S^2_0$" is argued by dimension count alone.** Located at "which together fill $S^2_0$ since $(m-1)(m+2)+m^2+1=\dim S^2_0$". It fails step 2: no failure can be exhibited, because the three summands are eigenspaces for distinct eigenvalues at $m\ge2$ and are therefore independent. The block splitting also gives the span. The omitted sentence is immediate. Withdrawn.
- **W3. Li's operator is $\pi\circ\mathring R$, and the record's has no projection.** It fails step 2: $\operatorname{tr}\mathring Wh=(1-m)\operatorname{tr}h=0$ on $S^2_0$, so the projection acts trivially. Withdrawn.
- **W4. `A_from_omega` is vacuous over $\mathbb Q$ and has an unused hypothesis.** This is a remark on typing, not a defect of the lemma. The implication is true, and it is used only as a rearrangement. It fails step 3 as a finding against the result. Withdrawn, and recorded in section 11.
- **W5. $R-cG$ is not shown to be "the" Weyl tensor.** It fails step 2: trace-free together with a difference in the Kulkarni-Nomizu image determines the Weyl part uniquely (section 3). Withdrawn.

## 14. What would break it

- **An element of $S^2_0$ outside the three summands, or a summand that is not invariant.** The block splitting of section 5 rules both out for every $m\ge2$.
- **A sign convention under which $G^{(a)}_{ijij}=-1$, or the $ikjl$ order.** Either negates the spectrum. I checked the statement's two conventions against Passage E and against Li's Example 2.1, and they agree.
- **A norm under which $\lVert W\rVert_F=1$ is not $\sum\omega^2=3$.** This one exists: the 4-index Frobenius norm, exhibited in closed form and screened at $m=2$ (finding 1). It breaks the statement's normalisation clause and not the spectrum under $\sum\omega^2=3$.
- **For Passage B's $\theta$ claim, a Weyl tensor at which $\beta\ne2\langle M^\#,M\rangle$, or the opposite sign for $M$.** The second is exhibited in finding 8b. The first would need link (a) refuted, which is outside this brief and would require computation or a derivation not on file.

## 15. Verdict

`PROVEN, hypotheses corrected`

The three-eigenvalue spectrum, its eigenspaces, multiplicities, scale and $A$ are proven at every $m\ge2$ under the normalisation $\sum\omega^2=3$. The statement's "$\lVert W\rVert_F=1$" must be corrected to $\lVert M\rVert_F=1$ with $M_{(ij),(kl)}=W_{ijkl}$ on $\{e_i\wedge e_j\}_{i<j}$, or to $\sum\omega^2=3$ directly. Passage B's closing claim $\theta=\theta_0(2m)$ is correct algebra that carries L50's link (a) and an unstated sign convention for $M$ as hypothesis debt. At the time of writing, the git index held no files staged by other verifiers.
