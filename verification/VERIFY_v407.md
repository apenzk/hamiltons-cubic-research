# Verifier v407, Lemma L67 (the second-kind spectrum of $S^m\times S^m$) with Passages B, D and F

The brief was cold and I worked from the definitions it quotes. No numerical work was done, every value below is exact, and no scripts were written or run. The only source read beyond the brief is Li 2022 (arXiv:2209.02119), text and PDF page 7, for item 7. Log: `agent_logs/verify-L67-v407.log`.

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | "normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation" | HYPOTHESIS-DEBT | no passage defines $\lVert W\rVert_F$, and under the full four-index Frobenius norm the condition is $\sum\omega^2=\tfrac34$, while the proof's $s$ meets $\sum\omega^2=3$ and $\sum\mu^2=1$ |
| 2 | $R=G^{(1)}+G^{(2)}$, $\mathrm{Ric}=(m-1)I$, $c=\frac{m-1}{2m-1}$, $W=R-cG$ | CONFIRMED | Ricci contractions close, and $c$ agrees with the explicit Ricci decomposition, whose uniqueness the proof leaves implicit |
| 3 | $\mathring G^{(a)}h=P_ahP_a-t_aP_a$, $\mathring Gh=h$ in the $iklj$ order | CONFIRMED | direct contraction with $G_{ijij}=+1$ |
| 4 | the three summands, their eigenvalues, and that they fill $S^2_0$ | CONFIRMED | each eigenvalue closes, the summands are independent, and the dimensions sum to $2m^2+m-1$ (distinctness is left to inspection, and Lean types it) |
| 5 | unnormalised $\sum\omega^2$, $s$, $A=s/(2m-1)$, $A>0$ | CONFIRMED | the arithmetic closes |
| 6 | $m\ge2$, and "at $m=1$ the product is flat and $W=0$" | CONFIRMED | rank-one $P_a$ kills $G^{(a)}$, and $c=0$ |
| 7a | Passage B against Passage A, clause by clause | CONFIRMED | every eigenvalue sits on the same summand with the same multiplicity |
| 7b | "Li's Theorem 1.8 gives the same spectrum as a product rule" | CONFIRMED AS ALGEBRA | Li gives the spectrum of $\mathring R$, and it matches only after the shift by $-c$ and the scale $s$, a step Passage D writes and Passages A and B leave out |
| 8a | $\Lambda^2$ spectrum, "the same scale $s$ normalises both", $p_3(\mu)=A$, $p_3(\omega)$, the radical, $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ | CONFIRMED AS ALGEBRA | each closes by hand from the displayed spectra |
| 8b | "with Lemma L50 the two spectra return $\theta=\theta_0(2m)$", read as $\langle W,Q(W)\rangle$ | HYPOTHESIS-DEBT | this uses L50's coefficient pair, which is link (a) $\beta=2\langle M^\#,M\rangle$, underived on the record |
| 9 | $A$ equals $2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$ at $n=2m$ | CONFIRMED AS ALGEBRA | the closed form reduces to $A$ identically, and the passages never define $\operatorname{tr}(W^3)$ |
| 10 | Passage F against Passage A | CONFIRMED AS ALGEBRA | Lean types the arithmetic of the list (sum, trace, normalisation, positivity, order) and nothing about $W$, $\mathring W$ or the eigenspaces |
| 11 | boundary: $m=2$, zero eigenvalues, $ikjl$ order | CONFIRMED | the $m=2$ screen closes, no eigenvalue of $\mathring W$ or $M$ vanishes at $m\ge2$, and $ikjl$ negates the spectrum, as the proof's fixed order anticipates |

**Summary: the spectrum is proven for the normalisation $\sum\omega^2=3$ (equivalently $\lVert M\rVert_F=1$, with $M_{(ij)(kl)}=W_{ijkl}$ for $i<j$, $k<l$), so the round should replace "$\lVert W\rVert_F=1$" by that condition in Passages A and B and mark Passage B's $\theta$ clause as resting on Lemma L50's link (a).**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathring W$ acts on $S^2_0$, and **the index order is load-bearing**: $W_{ikjl}$ in place of $W_{iklj}$ negates $\mathring W$ and flips the sign of the bi-spectral identity's $-\tfrac12$ term." The matrix form is "$(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$".
- "$R_{ijij}$ the sectional curvature."
- "$S^2_0$ is the space of trace-free symmetric $n\times n$ matrices, $p_3$ the sum of cubes of a spectrum, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$."
- "A 4-tensor $W$ acts on $\Lambda^2\mathbb R^n$ as the operator $M$. The passages use both $\lVert W\rVert_F$ and $\lVert M\rVert_F$, and fix no relation between them beyond what they state."
- Lemma L50: "Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$ ... $\sum\mu=\sum\omega=0,\ \sum\mu^2=1,\ \sum\omega^2=3$."

Working conventions I derive from the passages and use throughout. Frobenius inner product on matrices. $G_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$, so $G_{ijij}=1$ for $i\ne j$. Ricci is $\mathrm{Ric}_{jl}=\sum_iR_{ijil}$, the contraction that makes the sphere's Ricci positive when $R_{ijij}$ is the sectional curvature. The $\Lambda^2$ action is the one Passage D uses ("$R$ acts on $\Lambda^2$ as the identity on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$"), which forces $M_{(ij)(kl)}=W_{ijkl}$ for $i<j$, $k<l$ in the basis $e_i\wedge e_j$, since in that basis the unit sphere's $G$ acts as the identity.

## Hypothesis inventory

**Statement of L67.**

| Hypothesis | Used by the proof? |
|---|---|
| $m\ge2$ | yes, for $A>0$ and real, for $c$ finite, and for the three values to be distinct |
| $n=2m$ | yes, in $c=\frac{m-1}{2m-1}$ and in $\dim S^2_0$ |
| $W$ the Weyl tensor of $S^m\times S^m$ | yes, it is the object |
| normalisation "$\lVert W\rVert_F=1$, which is $\sum\omega^2=3$" | only the gloss $\sum\omega^2=3$ is used (by $s$), and the symbol $\lVert W\rVert_F$ never enters the proof (finding 1) |
| $R_{ijij}$ the sectional curvature | yes, it fixes the sign of $G^{(a)}$ and hence of every eigenvalue |
| $\mathring W$ in Li's $iklj$ order | yes, in the contraction |

**Imported results.**

| Import | Its hypotheses | Checked against the object | Used by the L67 proof? |
|---|---|---|---|
| Lemma L50's norm relation | $W\in\mathrm{Weyl}_n$, $\lVert M\rVert_F=1$ | $W=R-cG$ is Weyl (section 2). After scaling by $s$, $\sum\mu^2=s^2\frac{m^2(m-1)}{2m-1}=1$ under Passage D's $\Lambda^2$ convention (section 8), so $\lVert M\rVert_F=1$ holds | only to name the normalisation. The proof computes $\sum\omega^2$ on the object directly and depends on no content of L50 |
| Lemma L50's identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ | as above | as above | not by the L67 proof. Used only by Passage B's $\theta$ clause (8b) |
| Li 2022 Theorem 1.8 | $(M_i,g_i)$ Einstein with $\mathrm{Ric}(g_i)=\rho_ig_i$ and $n_i\ge1$ | unit $S^m$ is Einstein with $\rho_i=m-1$, $n_i=m\ge2$ | not by the proof. Cited as a cross-check (7b) |
| uniqueness of the Ricci decomposition (implicit) | algebraic curvature tensor | $R$, $G$ satisfy the curvature symmetries and Bianchi | implicitly, in "$W=R-cG$ ... since" (section 2) |

No hypothesis is stated and left unused, apart from the symbol $\lVert W\rVert_F$ (finding 1). Every hypothesis a step uses is stated, apart from the implicit uniqueness of the Ricci decomposition. That is a textbook fact and I record no finding on it.

## Standing list

1. **Hypotheses.** Given in the inventory above.
2. **Quantifier order and scope.** The statement is "for each $m\ge2$, the operator has this spectrum". The proof fixes $m$ and works pointwise, so the order is right. No finding.
3. **Range edges.** For $m=2$, see section 11. For $m=1$, see section 6. No eigenvalue of $\mathring W$ is zero at $m\ge2$ (the values are $m$, $-(m-1)$ and $-2m(m-1)$ times $A>0$). No eigenvalue of $M$ is zero either (the values are $\frac m{2m-1}$ and $-\frac{m-1}{2m-1}$ times $s$). No finding.
4. **Proven versus used.** The proof covers exactly $S^m\times S^m$ at $m\ge2$, and the statement claims nothing more. Passage B's "identically in $m$" is algebra in $m$, and the Lean file extends the arithmetic to real $m\ge2$. That extension is harmless because Lean claims only the arithmetic. No finding.
5. **Lean.** See section 10.

## Traps, by name

- **$\ker W\ne0$.** The objects are $\mathring W$ on $S^2_0$ and $M$ on $\Lambda^2$, and both are invertible at $m\ge2$ (standing item 3). The kernel of $\mathring R$ is the cross block ($m^2$ dimensions, Li Lemma 2.1), and the shift by $-c$ moves it to $-c\ne0$. No finding.
- **Range boundaries.** Sections 6 and 11. No finding.
- **Subfamily used in general.** Standing item 4. No finding.
- **Hypothesis stated but unused, or used but unstated.** Finding 1 on $\lVert W\rVert_F$ (the statement names it, and the proof uses a different condition). In Lean, `A_from_omega` binds `hm : 2 ≤ m` and never uses it (section 10). The implicit uniqueness of the Ricci decomposition is recorded in the inventory, with no finding.
- **Universal claim with no witness.** "Exactly three eigenvalues" is witnessed by explicit eigenspaces that span $S^2_0$. No finding.
- **Imported result whose hypotheses were never checked.** Li Theorem 1.8's hypotheses are met (inventory). L50's $\lVert M\rVert_F=1$ is met under Passage D's convention, but the statement never checks it and instead asserts it through the undefined $\lVert W\rVert_F$ (finding 1).
- **Normalisation or index convention from the wrong source.** The record takes $iklj$ from Li 2021, which I did not read. Li 2022 page 7 prints "$\mathring R(\varphi)_{ij}=\sum_{k,l}R_{ijkl}\varphi_{kl}$", which read literally vanishes on symmetric $\varphi$ because $R_{ijkl}$ is antisymmetric in $kl$. Its proofs compute "$\mathring R(\xi_{pq})(e_i,e_l)=\sum_{j,k}R(e_i,e_j,e_k,e_l)\xi_{pq}(e_j,e_k)$" and use "$\mathring R_i(g_i)=-\mathrm{Ric}(R_i)$". That is the $iklj$ order with $R_{ijij}=+$sectional curvature, and it agrees with Passage E and with Li's Example 2.1, "$\mathring R=\kappa\,\mathrm{id}_{S^2_0}$ on $S^n(\kappa)$". The printed display in Li 2022 is a typographical slip, and the record does not take its convention from it. No finding against the record. The normalisation convention is finding 1.

## 1. The normalisation (brief item 1)

**The claim.** Passage A says "normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation". Passage B's landscape bullet says "normalised to $\lVert W\rVert_F=1$", and its detail repeats Passage A.

**What the proof actually imposes.** It imposes $s^2\cdot\frac{3m^2(m-1)}{2m-1}=3$, which is $\sum\omega^2=3$. By Passage D's $\Lambda^2$ spectrum (checked in section 8), the same $s$ gives $\sum\mu^2=1$. So the proof meets the gloss $\sum\omega^2=3$ and L50's hypothesis $\lVert M\rVert_F=1$ under $M_{(ij)(kl)}=W_{ijkl}$, $i<j$, $k<l$.

**Candidate 1: "$\lVert W\rVert_F=1$" and "$\sum\omega^2=3$" are different conditions.**

1. *Locate.* The statement's clause "normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation". L50 states its norm relation for "$\lVert M\rVert_F=1$", not for $\lVert W\rVert_F$. No passage defines $\lVert W\rVert_F$, and the brief confirms that "the passages ... fix no relation between them".
2. *Exhibit.* Take $\lVert W\rVert_F^2=\sum_{i,j,k,l}W_{ijkl}^2$, the Frobenius norm of the four-tensor. Every entry $M_{(ij)(kl)}$ with $i<j$, $k<l$ appears in that sum as the four entries $W_{ijkl}$, $W_{jikl}$, $W_{ijlk}$, $W_{jilk}$, all of equal square, so $\lVert W\rVert_F^2=4\lVert M\rVert_F^2$ for any algebraic curvature tensor. Concretely, at $m=2$ with factors $\{1,2\}$ and $\{3,4\}$, the unscaled $W=R-\tfrac13G$ is diagonal on $\Lambda^2$. It has $W_{1212}=W_{3434}=\tfrac23$ and $W_{1313}=W_{1414}=W_{2323}=W_{2424}=-\tfrac13$, so $\lVert M\rVert_F^2=2\cdot\tfrac49+4\cdot\tfrac19=\tfrac43$ and $\lVert W\rVert_F^2=\tfrac{16}3$. The proof's scale at $m=2$ is $s^2=\tfrac34$, which gives $\lVert sM\rVert_F=1$, $\sum\omega^2=3$, and $\lVert sW\rVert_F=2$. Under this reading, normalising to $\lVert W\rVert_F=1$ needs the scale $s/2$, which gives $\sum\omega^2=\tfrac34$ and eigenvalues $\tfrac12mA$, $-\tfrac12(m-1)A$, $-m(m-1)A$. At $m=2$ the top eigenvalue would be $\tfrac1{2\sqrt3}$ against the stated $mA=\tfrac1{\sqrt3}$.
3. *Argue the opposite.* The record may use $\lVert W\rVert_F$ as a name for $\lVert M\rVert_F$, the Frobenius norm of $W$ viewed as an operator on $\Lambda^2$. That reading is supported by three things. The statement glosses the condition as $\sum\omega^2=3$ and cites L50, whose hypothesis is $\lVert M\rVert_F$. The proof meets that gloss exactly. Passage D's $\Lambda^2$ convention makes $\sum\mu^2=1$ under the same $s$. Under this reading the statement is correct. Nothing on file fixes the reading, however, and the standard meaning of the Frobenius norm of a four-tensor is the other one.

**Status.** The candidate survives steps 1 and 2. Step 3 shows a consistent reading, but no passage establishes it. It is recorded as **HYPOTHESIS-DEBT**. What must be written down is the definition $\lVert W\rVert_F:=\lVert M\rVert_F$ with $M_{(ij)(kl)}=W_{ijkl}$ ($i<j$, $k<l$), or the statement's normalisation must be replaced by $\sum\omega^2=3$ (equivalently $\lVert M\rVert_F=1$). The spectrum as displayed is right for that condition and is off by a factor $\tfrac12$ under the four-index norm.

**A screen, not evidence.** On this object I checked by hand that $\sum\omega^2=3\sum\mu^2$ holds before scaling: $\frac{3m^2(m-1)}{2m-1}$ against $\frac{m^2(m-1)}{2m-1}$. So the L67 normalisation does not depend on L50's norm relation holding in general.

## 2. The curvature of the product (brief item 2)

- $G^{(a)}_{ijij}=(P_a)_{ii}(P_a)_{jj}-(P_a)_{ij}^2$ equals $1$ for $i\ne j$ both in factor $a$, and $0$ otherwise. So $G^{(a)}$ is the curvature of the unit sphere on factor $a$, extended by zero. Mixed sectional curvatures of $G^{(1)}+G^{(2)}$ vanish, as a Riemannian product requires (Li's equation (2.2)). The symmetries and first Bianchi identity hold for $G^{(a)}$ because it has the form $B_{ik}B_{jl}-B_{il}B_{jk}$ with $B$ symmetric.
- Ricci: $\sum_iG^{(a)}_{ijil}=\operatorname{tr}(P_a)(P_a)_{jl}-(P_a^2)_{jl}=(m-1)(P_a)_{jl}$. Summing gives $(m-1)(P_1+P_2)=(m-1)I$. For $G$ the same computation gives $(2m-1)I$. Confirmed.
- $\mathrm{Ric}(R-cG)=(m-1)I-c(2m-1)I=0$ at $c=\frac{m-1}{2m-1}$. Confirmed.
- *That $R-cG$ is the Weyl tensor.* The proof writes "since $G$ has Ricci tensor $(2m-1)I$", which shows $R-cG$ is Ricci-free, and leaves implicit that a Ricci-free algebraic curvature tensor differing from $R$ by a multiple of $g\owedge g$ is the Weyl part. The explicit decomposition gives the same answer. With $\mathrm{Ric}=(m-1)g$ the traceless Ricci term vanishes, $\mathrm{scal}=2m(m-1)$, and $(g\owedge g)_{ijkl}=2G_{ijkl}$, so $W=R-\frac{\mathrm{scal}}{2n(n-1)}g\owedge g=R-\frac{2m(m-1)}{2\cdot2m(2m-1)}\cdot2G=R-\frac{m-1}{2m-1}G$. Confirmed.

No finding.

## 3. The contraction in the $iklj$ order (brief item 3)

- $(\mathring G^{(a)}h)_{ij}=\sum_{k,l}\big[(P_a)_{il}(P_a)_{kj}-(P_a)_{ij}(P_a)_{kl}\big]h_{kl}$. The first term is $\sum_{k,l}(P_a)_{il}h_{lk}(P_a)_{kj}=(P_ahP_a)_{ij}$ by the symmetry of $h$. The second is $(P_a)_{ij}\operatorname{tr}(P_ah)$. So $\mathring G^{(a)}h=P_ahP_a-t_aP_a$. Confirmed.
- $(\mathring Gh)_{ij}=h_{ji}-\delta_{ij}\operatorname{tr}h$, which is $h$ on $S^2_0$. Confirmed. The sign agrees with Li 2022 Example 2.1 ($\mathring R=\kappa\,\mathrm{id}$ on $S^n(\kappa)$) and with $\mathring G(I)=-(n-1)I=-\mathrm{Ric}$, Li's relation $\mathring R_i(g_i)=-\mathrm{Ric}$.
- *The output lies in $S^2_0$.* $\operatorname{tr}(P_ahP_a-t_aP_a)=(1-m)t_a$, and $t_1+t_2=\operatorname{tr}h=0$, so $\mathring Wh$ is trace-free without Li's projection $\pi$. The proof does not say this. It follows, and it is the reason the formula is the operator on $S^2_0$. No finding.
- *Screens on components at $m=2$, not evidence.* For $h=E_{11}-E_{22}$: $(\mathring Wh)_{11}=-W_{1221}=W_{1212}=\tfrac23$, and $(\mathring Wh)_{33}=W_{3113}-W_{3223}=\tfrac13-\tfrac13=0$. Both agree with $(1-c)h$. For $h=P_1-P_2$: $(\mathring Wh)_{11}=W_{1221}-W_{1331}-W_{1441}=-\tfrac23-\tfrac13-\tfrac13=-\tfrac43=(1-m-c)$. For $h=E_{13}+E_{31}$: $(\mathring Wh)_{13}=W_{1313}=-\tfrac13=-c$.

## 4. The three summands (brief item 4)

- *Within factor $a$*, $h=P_ahP_a$ with $t_a=0$. For $b\ne a$, $P_bhP_b=0$ and $t_b=\operatorname{tr}(P_bP_ahP_a)=0$. So $\mathring Wh=h-ch=\frac m{2m-1}h$. The dimension per factor is $\binom{m+1}2-1$, and twice that is $m^2+m-2=(m-1)(m+2)$. Confirmed.
- *Cross block*, $h=P_1hP_2+P_2hP_1$. Here $P_ahP_a=0$ and $t_a=\operatorname{tr}(P_1hP_2)=\operatorname{tr}(hP_2P_1)=0$. So $\mathring Wh=-ch$, and the dimension is $m^2$ (the free $m\times m$ block). Confirmed.
- *Line*, $h=P_1-P_2$, with $t_1=m$, $t_2=-m$, $P_1hP_1=P_1$, $P_2hP_2=-P_2$. So $\mathring Wh=(1-m-c)h$, and $1-m-c=-(m-1)\big(1+\tfrac1{2m-1}\big)=-\frac{2m(m-1)}{2m-1}$. Confirmed.
- *Invariance.* Each summand is an eigenspace, so it is invariant.
- *Filling $S^2_0$.* The proof gives only the dimension count. The count needs the sum to be direct, which the proof does not state. It holds because the summands are mutually Frobenius-orthogonal. The two within-factor pieces and the cross block have disjoint supports, and $\langle h,P_1-P_2\rangle=t_1-t_2=0$ on the within-factor pieces. Also $(m-1)(m+2)+m^2+1=2m^2+m-1=\frac{2m(2m+1)}2-1$. Confirmed.
- *"Exactly three".* This needs the three values distinct. The prose does not say so. It is visible from the displayed values at $m\ge2$: $m>0>-(m-1)>-2m(m-1)$, the last strict because $(m-1)(2m-1)>0$. Lean's `spec_strict_order` types it. I record this as an observation, not a finding, because the written values exhibit it.

No finding.

## 5. The scale and $A$ (brief item 5)

- $\frac{m^2(m-1)}{(2m-1)^2}\big((m+2)+(m-1)+4(m-1)\big)=\frac{m^2(m-1)(6m-3)}{(2m-1)^2}=\frac{3m^2(m-1)}{2m-1}$. The three terms come from $(m-1)(m+2)m^2$, $m^2(m-1)^2$ and $4m^2(m-1)^2$ over $(2m-1)^2$. Confirmed.
- $s^2=\frac{2m-1}{m^2(m-1)}$ gives $\sum\omega^2=3$. Confirmed.
- $A=\frac s{2m-1}=\frac{\sqrt{2m-1}}{m\sqrt{m-1}\,(2m-1)}=\frac1{m\sqrt{(m-1)(2m-1)}}$, positive and real for $m\ge2$. Confirmed.

No finding.

## 6. $m\ge2$ and the $m=1$ clause (brief item 6)

- At $m=1$, $P_a$ has rank one, $P_a=u u^{\mathsf T}$, and $u_iu_ku_ju_l-u_iu_lu_ju_k=0$, so $G^{(a)}=0$ and $R=0$. Also $c=0$, so $W=0$. The product $S^1\times S^1$ is flat. Confirmed.
- The proof's formulas need $m\ge2$ in three places: $A$ divides by $\sqrt{m-1}$, the values $-(m-1)A$ and $-2m(m-1)A$ coincide when $m=1$, and $s$ divides by $m-1$. The statement restricts to $m\ge2$ and treats $m=1$ separately, so no formula is used outside its range.

No finding.

## 7. Passage B against Passage A, and Li's Theorem 1.8 (brief item 7)

**7a. Clause by clause.**

| Clause | Passage A | Passage B | Match |
|---|---|---|---|
| range | $m\ge2$, $n=2m$ | same, in both entries | yes |
| normalisation | "$\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by L50" | landscape: "$\lVert W\rVert_F=1$" only. Detail: as in A | yes, with finding 1 in both |
| index order and sign | $iklj$, $R_{ijij}$ sectional | landscape: $iklj$. Detail: both | yes |
| $mA$ | multiplicity $(m-1)(m+2)$ | "on the trace-free parts within each factor, multiplicity $(m-1)(m+2)$" | yes, the placement matches A's first bullet |
| $-(m-1)A$ | multiplicity $m^2$ | "on the cross block, multiplicity $m^2$" | yes |
| $-2m(m-1)A$ | multiplicity $1$ | "on $P_1-P_2$, multiplicity $1$" | yes |
| $A$ | $\frac1{m\sqrt{(m-1)(2m-1)}}>0$ | same, without "$>0$" | yes |
| dimension | $2m^2+m-1=\dim S^2_0$ | same | yes |
| substitution | $W=R-cG$ | "$W=G^{(1)}+G^{(2)}-\frac{m-1}{2m-1}G$" | yes |
| $m=1$ | "flat and $W=0$" | absent | an omission, not a conflict |

Confirmed.

**7b. "Li's Theorem 1.8 gives the same spectrum as a product rule".**

*Li at source* (arXiv:2209.02119, Theorem 1.8 in the text at lines 241-250, restated as Proposition 2.1 on page 7): "Let $(M_i,g_i)$ be an $n_i$-dimensional Einstein manifold with $\mathrm{Ric}(g_i)=\rho_ig_i$ and $n_i\ge1$ ... Then the eigenvalues of $\mathring R$ are precisely those of $\mathring R_1$ and $\mathring R_2$, and $0$ with multiplicity $n_1n_2$, and $-\frac{n_1\rho_2+n_2\rho_1}{n_1+n_2}$ with multiplicity one." The spectrum is that of $\pi\circ\mathring R$ on $S^2_0$ (page 7). The hypotheses are met for unit $S^m\times S^m$ (inventory). With Example 2.1 at $\kappa=1$, Li gives the spectrum of $\mathring R$ as $1^{((m-1)(m+2))}$, $0^{(m^2)}$, $-(m-1)^{(1)}$, with eigenvector $n_2g_1-n_1g_2=m(P_1-P_2)$.

**Candidate 2: Li's theorem gives the spectrum of $\mathring R$, not the stated spectrum of $\mathring W$.**

1. *Locate.* Passage A's closing italic sentence, repeated in both entries of Passage B. Theorem 1.8 applies to $R=R_1\oplus R_2$. $W=R-cG$ is not of that form, because $G$ has mixed components $G_{ijij}=1$ with $i$ in one factor and $j$ in the other.
2. *Exhibit.* Li's spectrum $\{1,0,-(m-1)\}$ is not $\{mA,-(m-1)A,-2m(m-1)A\}$. At $m=2$ the first is $\{1,0,-1\}$ and the second is $\{\tfrac1{\sqrt3},-\tfrac1{2\sqrt3},-\tfrac2{\sqrt3}\}$.
3. *Argue the opposite.* Since $\mathring Gh=h$ on $S^2_0$ (section 3), $\mathring W=\mathring R-c\,\mathrm{id}$ there. Li's spectrum shifted by $-c$ is $\{\frac m{2m-1},-\frac{m-1}{2m-1},-\frac{2m(m-1)}{2m-1}\}$ on the same eigenspaces (Li's $\varphi_p$, $\xi_{pq}$, $\zeta$ are the proof's three summands), and the scale $s$ turns that into the stated spectrum. Passage D, in the same file, writes out this step: "subtracting the multiple $\frac{m-1}{2m-1}G$ of the round curvature tensor to reach the Weyl tensor". The sentence reads naturally as "gives the same spectrum once shifted and scaled".

**Status.** Withdrawn as a defect under step 3, because the charitable reading is supported on file and closes. The sentence is recorded as **CONFIRMED AS ALGEBRA**. The shift-and-scale step it relies on appears in Passage D, not in Passages A or B.

## 8. Passage B's further claims and Passage D (brief item 8)

**The $\Lambda^2$ spectrum.** In the basis $e_i\wedge e_j$, $G^{(a)}_{ijkl}$ with $i<j$, $k<l$ is nonzero only for $\{i,j\}=\{k,l\}$ inside factor $a$, where it equals $1$. $G$ is the identity. So $R=\mathrm{Id}\oplus\mathrm{Id}\oplus0$ on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m\oplus(\text{mixed})$, and $W=R-c\,\mathrm{Id}$ has eigenvalue $\frac m{2m-1}$ with multiplicity $2\binom m2=m(m-1)$ and $-\frac{m-1}{2m-1}$ with multiplicity $m^2$. The total is $m(2m-1)=\dim\Lambda^2\mathbb R^{2m}$. Confirmed.

**Trace and norm.** $\sum\mu\propto m(m-1)\cdot m-m^2(m-1)=0$. The sum of squares is $\frac{m(m-1)m^2+m^2(m-1)^2}{(2m-1)^2}=\frac{m^2(m-1)(2m-1)}{(2m-1)^2}=\frac{m^2(m-1)}{2m-1}$, a third of $\frac{3m^2(m-1)}{2m-1}$. So the same $s$ gives $\sum\mu^2=1$ and $\sum\omega^2=3$. "The same scale $s$ normalises both" is confirmed.

**$p_3(\mu)$.** $\frac{s^3}{(2m-1)^3}\big(m(m-1)m^3-m^2(m-1)^3\big)=\frac{s^3m^2(m-1)\big(m^2-(m-1)^2\big)}{(2m-1)^3}=\frac{s^3m^2(m-1)}{(2m-1)^2}$. Since $s^2=\frac{2m-1}{m^2(m-1)}$, this equals $\frac s{2m-1}=A$. Confirmed.

**$p_3(\omega)$.** Passage D displays the value and gives no derivation of it. Following the displayed spectrum, $p_3(\omega)=A^3\big((m-1)(m+2)m^3-m^2(m-1)^3-8m^3(m-1)^3\big)=A^3m^2(m-1)\big(-8m^3+16m^2-4m-1\big)$. The cubic vanishes at $m=\tfrac12$ and factors as $(2m-1)(-4m^2+6m+1)$: expanding gives $-8m^3+12m^2+2m+4m^2-6m-1$, which is the cubic. With $A^2m^2(m-1)=\frac1{2m-1}$, $p_3(\omega)=-(4m^2-6m-1)A$. That matches the display. Confirmed as algebra.

**The closing identity.** $\tfrac32A+\tfrac12(4m^2-6m-1)A=A(2m^2-3m+1)=A(2m-1)(m-1)=\frac{\sqrt{(m-1)(2m-1)}}m$. And $\theta_0(2m)=\frac{\sqrt{2(2m-1)(2m-2)}}{2m}=\frac{\sqrt{4(2m-1)(m-1)}}{2m}=\frac{\sqrt{(m-1)(2m-1)}}m$. The difference is identically zero. The radical: $(2m^2-3m+1)^2=4m^4-12m^3+13m^2-6m+1$, and $2m^2-3m+1=(2m-1)(m-1)\ge0$ for $m\ge1$, so the principal root is $2m^2-3m+1$. Confirmed as algebra. Passage D supports the closure by citing a run, and the hand closure above follows the passage's own displayed values.

**Which L50 links the $\theta$ clause uses.** Passage B reads "with Lemma L50 the two spectra return $\theta=\theta_0(2m)$". As a statement about $\theta=\langle W,Q(W)\rangle$, it uses the identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$. Passage C records that "the whole coefficient pair is that constant", meaning link **(a)**, $\beta=2\langle M^\#,M\rangle$, which "has no derivation anywhere". The clause does not use link **(b)** (the generalised-Kronecker proportionality, which concerns the $n\le5$ collapse), nor "only there". It uses the hypotheses $W\in\mathrm{Weyl}_n$ and $\lVert M\rVert_F=1$, both met (inventory). It also uses the $iklj$ order, since $ikjl$ flips the sign of the $-\tfrac12$ term. Verdict on 8b: **HYPOTHESIS-DEBT**, inherited from L50 link (a). The debt is to derive $\beta=2\langle M^\#,M\rangle$, equivalently the coefficient pair $(\tfrac32,-\tfrac12)$.

## 9. "$A$ is not a new constant" (brief item 9)

At $n=2m$, $\frac{2\sqrt2}{n\sqrt{(n-1)(n-2)}}=\frac{2\sqrt2}{2m\sqrt{(2m-1)\cdot2(m-1)}}=\frac1{m\sqrt{(2m-1)(m-1)}}=A$, using $\sqrt{2(m-1)}=\sqrt2\sqrt{m-1}$ for $m\ge1$. Confirmed as algebra. The passages never define "$\operatorname{tr}(W^3)$". If it means $\operatorname{tr}(M^3)=p_3(\mu)$ at $\lVert M\rVert_F=1$, it agrees with section 8's $p_3(\mu)=A$. That the record's closed form is correct in its own context is outside this brief. The support on file is "checked to be identically zero difference", and the hand reduction above follows the displayed expressions.

## 10. Passage F against Passage A (brief item 10)

The Lean proofs were not built, because building them would be computation. I audit the declared statements only.

**L67Statement.lean** (over $\mathbb R$, $m$ real).

| Declaration | States | Hypotheses | Against Passage A |
|---|---|---|---|
| `Aconst`, `spec`, `mult` | definitions of $A$, the list $(mA,-(m-1)A,-2m(m-1)A)$, the list $((m-1)(m+2),m^2,1)$ | none | the order and values match A |
| `Aconst_pos` | $0<A$ | $2\le m$ | A's "$A>0$" |
| `Aconst_sq` | $A^2=\frac1{m^2(m-1)(2m-1)}$ | $2\le m$ | arithmetic of $A$ |
| `mult_sum` | $\sum$ mult $=2m^2+m-1$ | none | A's dimension count |
| `dim_sym_traceless` | $\frac{2m(2m+1)}2-1=2m^2+m-1$ | none | a ring identity. It does not state $\dim S^2_0$ |
| `spec_trace_zero` | $\sum\text{mult}\cdot\text{spec}=0$ | none | Passage D's $\sum\omega=0$ |
| `spec_normalisation` | $\sum\text{mult}\cdot\text{spec}^2=3$ | $2\le m$ | the gloss $\sum\omega^2=3$ |
| `spec_strict_order` | $\text{spec}_2<\text{spec}_1<\text{spec}_0$ | $2\le m$ | distinctness, which the prose leaves to inspection |
| `mult_pos` | every multiplicity positive | $2\le m$ | nonempty eigenspaces at $m\ge2$ |
| examples at $m=1$ | $\sum$ mult $=2$, and `Aconst 1 = 0` | none | see below |
| example at $m=2$ | mult $=(4,4,1)$, sum $9$, trace $0$, squares $3$ | none | the $m=2$ arithmetic of section 11 |

**L67.lean** (namespace `SecondKind`, over $\mathbb Q$, no square roots).

| Declaration | States | Remark |
|---|---|---|
| `multiplicities_sum`, `dim_S2_zero` | the same identities as above | ring identities |
| `spectrum_traceless`, `sum_squares` | for arbitrary $A$, trace $0$ and $\sum$ squares $=3m^2(m-1)(2m-1)A^2$ | this is the proof's unnormalised sum with $A=s/(2m-1)$ substituted: $s^2\frac{3m^2(m-1)}{2m-1}=3m^2(m-1)(2m-1)A^2$ |
| `A_from_omega` | from $3m^2(m-1)(2m-1)A^2=3$, conclude $A^2m^2(m-1)(2m-1)=1$ | binds `hm : 2 ≤ m` and never uses it (a hypothesis stated but unused, harmless). It fixes $A^2$, not the sign of $A$ |
| `A_closed_form` | $\frac1{m^2(m-1)(2m-1)}\cdot m^2(m-1)(2m-1)=1$ | a cancellation. The closed form $A=1/(m\sqrt{\cdot})$ is not stateable over $\mathbb Q$ |
| `multiplicities_at_one`, `A_denominator_vanishes` | $m=1$ arithmetic | the denominator of $A^2$ vanishes |
| `A_sq_at_three`, `B_block_sq`, `bottom_sq_at_three` | at $m=3$: $A^2=\frac1{90}$, $(2A)^2=\frac2{45}$, $(12A)^2=\frac85$ | these match $-(m-1)A=-2A$ and $-2m(m-1)A=-12A$ at $m=3$ |
| `B_block_bracket` | a decimal bracket on $\sqrt{2/45}$ | a numeral check, outside Passage A |

**What is typed.** The arithmetic of the displayed spectrum is typed: its multiplicities, trace, normalisation, sign of $A$, strict order, and the identity $\frac{n(n+1)}2-1=2m^2+m-1$.

**What is not typed.** None of the following is typed: the tensor $W$, its identification as the Weyl tensor, the operator $\mathring W$ or its $iklj$ order, the three eigenspaces, the eigenvalue equations, that the summands fill $S^2_0$, the $m=1$ claim $W=0$, and the normalisation's link to $\lVert W\rVert_F$ or $\lVert M\rVert_F$. The Lean files state necessary consistency conditions on the list, and none of them states Lemma L67.

**Observation on `Aconst 1 = 0`.** Lean proves this because $\sqrt0=0$ and $1/0=0$ by Lean's division convention. Mathematically $A$ is undefined at $m=1$. The example says nothing about the statement's "$W=0$" at $m=1$, and a reader should not take it as typing that clause. Without the docstrings I cannot tell how the file presents it. This is an observation, not a finding against Passage A.

## 11. The boundary (brief item 11)

- **$m=2$, $n=4$** (a screen). $c=\tfrac13$, $A=\frac1{2\sqrt3}$. The eigenvalues are $\tfrac1{\sqrt3}$ ($\times4$), $-\tfrac1{2\sqrt3}$ ($\times4$) and $-\tfrac2{\sqrt3}$ ($\times1$), with $4+4+1=9=\dim S^2_0(\mathbb R^4)$. The trace is $\tfrac4{\sqrt3}-\tfrac2{\sqrt3}-\tfrac2{\sqrt3}=0$. The squares give $\tfrac43+\tfrac13+\tfrac43=3$. On $\Lambda^2$: $s=\tfrac{\sqrt3}2$, eigenvalues $\tfrac1{\sqrt3}$ ($\times2$) and $-\tfrac1{2\sqrt3}$ ($\times4$), squares $\tfrac23+\tfrac13=1$, $p_3(\mu)=\tfrac2{3\sqrt3}-\tfrac4{24\sqrt3}=\tfrac1{2\sqrt3}=A$. Also $\theta=3A=\tfrac{\sqrt3}2=\theta_0(4)$. Every step of the proof is valid at $m=2$ with no division by zero. No finding.
- **Zero eigenvalues.** None for $\mathring W$ or $M$ at $m\ge2$ (standing item 3).
- **The $ikjl$ order.** $W_{ikjl}=-W_{iklj}$ by antisymmetry in the last pair, so that operator is $-\mathring W$, with spectrum $-mA$, $(m-1)A$, $2m(m-1)A$. The stated signs and placements hold only in $iklj$, which the statement and proof fix explicitly and which Li 2022's computations use (see the conventions trap). No finding.

## Withdrawn candidates

- **Candidate 2** (Li's Theorem 1.8 gives the spectrum of $\mathring R$, not that of $\mathring W$). Withdrawn at step 3: the shift by $-c$ via $\mathring Gh=h$ and the scale $s$ reproduce the stated spectrum on the same eigenspaces, and Passage D writes out that shift. Recorded in section 7b.
- **Candidate 3** ("exactly three eigenvalues" without an argument that they are distinct). Withdrawn at step 3: the displayed values $mA>0>-(m-1)A>-2m(m-1)A$ exhibit distinctness at $m\ge2$ by inspection, and Lean's `spec_strict_order` types it. Recorded in section 4.
- **Candidate 4** ($\mathring Wh$ may leave $S^2_0$, so Li's projection $\pi$ would be needed). Withdrawn at step 2: $\operatorname{tr}\mathring Wh=(1-m)(t_1+t_2)-c\operatorname{tr}h=0$ for every $h\in S^2_0$, so no failure can be exhibited. Recorded in section 3.

Candidate 1 (the normalisation) survives and is graded HYPOTHESIS-DEBT in section 1.

## What would break it

- **The spectrum.** A falsifier would be some $h\in S^2_0$ orthogonal to all three summands, or one component of $\mathring Wh$ disagreeing with the claimed eigenvalue on a summand. The summands are orthogonal and their dimensions reach $\dim S^2_0$, so the first cannot exist. For the second, I checked component-wise at $m=2$ on one representative of each summand, by hand, and each agreed (section 3). I also rederived all three eigenvalues from the contraction for general $m$.
- **The sign.** A falsifier would be a convention under which $R_{ijij}$ is minus the sectional curvature, or the operator is $ikjl$. Either negates the spectrum. Both are excluded by the statement's explicit conventions, and Li 2022's computations use the same ones.
- **The normalisation.** The object that breaks the stated clause is the four-index Frobenius norm. Under it, $\lVert sW\rVert_F=2$ at the proof's scale (exhibited at $m=2$ in section 1), and the displayed eigenvalues are twice those of the $\lVert W\rVert_F=1$ tensor. This is what finding 1 records.
- **The $\theta$ clause.** It would break if L50's coefficient pair were other than $(\tfrac32,-\tfrac12)$, that is, if $\beta\ne2\langle M^\#,M\rangle$. I did not attempt that derivation. It lies outside this lemma, and the brief forbids supplying it.

## Verdict

**PROVEN, hypotheses corrected.** The three eigenvalues, their eigenspaces and multiplicities, $A$, and the $m=1$ clause all follow from the written proof. The normalisation must read $\sum\omega^2=3$, equivalently $\lVert M\rVert_F=1$ with $M_{(ij)(kl)}=W_{ijkl}$ for $i<j$, $k<l$, rather than an undefined $\lVert W\rVert_F=1$, which under the four-index Frobenius norm is a condition off by a factor $2$. Passage B's clause $\theta=\theta_0(2m)$ is correct as algebra and, read as $\langle W,Q(W)\rangle$, rests on Lemma L50's underived link (a).
