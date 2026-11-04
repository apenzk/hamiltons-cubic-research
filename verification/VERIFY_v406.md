# Verifier v406, Lemma L67 (the second-kind spectrum of $S^m\times S^m$), its canonical statements, Passage D's evaluation and the Lean files

The brief was cold and I worked from the definitions and the quoted passages alone, with Li 2022 (arXiv:2209.02119) read at source for item 7 only. No numerical work was done and every value below is exact. No scripts were written. Every hand check on a constructed object is labelled a screen. The log is at agent_logs/verify-L67-v406.log.

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | "normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation" | HYPOTHESIS-DEBT | L50 needs $\lVert M\rVert_F=1$, and the passages never say that $\lVert W\rVert_F$ means $\lVert M\rVert_F$. Under the entrywise tensor norm the stated spectrum has $\lVert W\rVert_F=2$ |
| 2 | $R=G^{(1)}+G^{(2)}$, Ricci $(m-1)I$, $G$ Ricci $(2m-1)I$, $W=R-cG$ | CONFIRMED | each contraction closes, and $c=\mathrm{scal}/(n(n-1))$ is the Einstein Weyl shift |
| 3 | $\mathring G^{(a)}h=P_ahP_a-t_aP_a$, $\mathring Gh=h$, the display for $\mathring Wh$ | CONFIRMED | the $iklj$ contraction closes, with signs matching Passage E and Li's Example 2.1 |
| 4 | three summands, eigenvalues, dimensions, filling $S^2_0$ | CONFIRMED | each eigenvalue closes, the eigenvalues are distinct for $m\ge2$ and the summands are mutually orthogonal |
| 5 | unnormalised $\sum\omega^2$, $s$, $A=s/(2m-1)$, $A>0$ | CONFIRMED AS ALGEBRA | $(m+2)+(m-1)+4(m-1)=3(2m-1)$ and $A^2=1/(m^2(m-1)(2m-1))$ |
| 6 | $m\ge2$, and "$m=1$ flat, $W=0$" | CONFIRMED | rank-one $G^{(a)}$ vanishes, and $A$ is undefined at $m=1$ |
| 7 | Passage B against A, and "Li's Theorem 1.8 gives the same spectrum" | CONFIRMED | every clause matches A. Li gives $\mathrm{spec}\,\mathring R$, and $\mathring W=\mathring R-c\,\mathrm{Id}$ followed by the scale $s$ reproduces A's spectrum |
| 8a | $\Lambda^2$ spectrum, same $s$, $p_3(\mu)=A$, $p_3(\omega)$ | CONFIRMED AS ALGEBRA | each closes by hand |
| 8b | "with Lemma L50 the two spectra return $\theta=\theta_0(2m)$" | HYPOTHESIS-DEBT | the algebra closes, but the coefficient pair $\tfrac32,-\tfrac12$ is L50's link (a), which has no derivation on file |
| 9 | "$A$ is not a new constant", equal to $2\sqrt2/(n\sqrt{(n-1)(n-2)})$ at $n=2m$ | CONFIRMED AS ALGEBRA | the two closed forms agree exactly. What "$\mathop{\mathrm{tr}}(W^3)$" denotes is left unfixed in the passages |
| 10 | Passage F states L67 | CONFIRMED AS ALGEBRA | Lean types the arithmetic of the proposed spectrum only. No tensor, operator or eigenvalue claim is stated |
| 11 | boundary $m=2$, zero eigenvalues, $ikjl$ order | CONFIRMED | $m=2$ closes, there is no zero eigenvalue of $\mathring W$ or $M$ at $m\ge2$, and $ikjl$ negates the spectrum |

**Summary: the spectrum and its proof are correct for the normalisation $\sum\omega^2=3$ (equivalently $\lVert M\rVert_F=1$ with $G\mapsto\mathrm{Id}$ on $\Lambda^2$), but the statement names $\lVert W\rVert_F=1$ without defining that norm, which is off by a factor 2 under the entrywise reading and should be rewritten as $\lVert M\rVert_F=1$. Passage B's $\theta=\theta_0(2m)$ sentence also silently inherits L50's underived link (a).**

## 0. Conventions, fixed once

Quoted from the brief:

- Passage E: "$(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$", Li's order, and "$W_{ikjl}$ in place of $W_{iklj}$ negates $\mathring W$".
- Passage A: "With $R_{ijij}$ the sectional curvature and $\mathring W$ in Li's $iklj$ order".
- Passage C: "Let $W\in\mathrm{Weyl}_n$ act on $\Lambda^2\mathbb R^n$ as $M$, with $\lVert M\rVert_F=1$ and spectrum $\mu$ ... $\sum\mu^2=1,\quad\sum\omega^2=3$."
- Definitions: "$S^2_0$ is the space of trace-free symmetric $n\times n$ matrices, $p_3$ the sum of cubes of a spectrum, and $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$." "The passages use both $\lVert W\rVert_F$ and $\lVert M\rVert_F$, and fix no relation between them beyond what they state."
- Passage D fixes the $\Lambda^2$ action implicitly: "$R$ acts on $\Lambda^2$ as the identity on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$". With $R_{ijij}$ the sectional curvature this is the convention $M_{(ij),(kl)}=W_{ijkl}$ in the orthonormal basis $e_i\wedge e_j$, $i<j$, under which $G\mapsto\mathrm{Id}$. I use this convention throughout.
- Ricci contraction: $\mathrm{Ric}_{jl}=\sum_iR_{ijil}$, the contraction under which $R_{ijij}$ sectional gives positive Ricci on the sphere. The passages do not write it, but it is the only one consistent with "Ricci tensor $(m-1)I$".

## 1. Hypothesis inventory

**The statement (Passage A).**

- H1: $m\ge2$, and $m$ an integer (implicit, since $m$ is a dimension). Used in the division by $m-1$ in $s$, in $A>0$, and in the distinctness of the three eigenvalues.
- H2: $n=2m$, and $W$ is the Weyl tensor of $S^m\times S^m$. The proof takes both factors to be unit spheres. "Balanced" and "$S^m$" support equal radii, and a common radius is absorbed by the normalisation. Unequal radii give a non-Einstein product and a different spectrum. The proof uses equal radii and the statement relies on the reader reading $S^m$ as the round unit sphere, as Li does ("$S^n$ ... with constant sectional curvature 1"). No finding, but the equal-radii reading is load-bearing.
- H3: $\lVert W\rVert_F=1$, "which is $\sum\omega^2=3$". The proof uses only $\sum\omega^2=3$. See section 2 for the gap between the two.
- H4: $R_{ijij}$ sectional, $iklj$ order. Used in every sign. Consistent with Li (section 8).
- The statement is pointwise. The product is homogeneous, so the spectrum does not depend on the point. This is unstated and trivial.

**Imported results and their hypotheses.**

- Lemma L50's norm relation, hypothesis $W\in\mathrm{Weyl}_n$ with $\lVert M\rVert_F=1$. The object is the scaled $sW$. It is a Weyl tensor (section 3). Its $\lVert M\rVert_F=1$ follows from Passage D's $\sum\mu^2=1$. The statement, however, names $\lVert W\rVert_F=1$ (section 2). L50's recorded debts (a) and (b) concern the cubic coefficient pair and the $n\le5$ collapse, not the quadratic relation $\sum\omega^2=3\lVert M\rVert_F^2$. Screen in section 2: that relation holds for every algebraic Weyl tensor under the convention of section 0, by a short hand derivation. This is reported as a screen only.
- Li 2022 Theorem 1.8 (Proposition 2.1): hypotheses $(M_i,g_i)$ Einstein with $\mathrm{Ric}(g_i)=\rho_ig_i$ and $n_i\ge1$. On the object, $S^m$ is Einstein with $\rho=m-1$ and $n_i=m\ge2$, so both hypotheses are met. The theorem is cited as corroboration and is not used in A's proof.
- Standard decomposition fact: an algebraic curvature tensor $R$ with $\mathrm{Ric}=\lambda g$ has Weyl part $R-\frac{\lambda}{n-1}G$. This is used without statement in "$W=R-cG$ ... since $G$ has Ricci tensor $(2m-1)I$". It is standard (section 3).

**Hypotheses stated but unused.** In the lemma, none. In the Lean file L67.lean, `A_from_omega` carries `hm : 2 ≤ m` and its proof, `linear_combination hnorm / 3`, never uses it (section 11).

**Hypotheses used but unstated.** Equal radii (H2, benign). The meaning of $\lVert W\rVert_F$ (H3, section 2). The Ricci contraction index pair (section 0, benign).

## 2. Item 1, the normalisation: HYPOTHESIS-DEBT

**Locate.** Passage A: "normalised to $\lVert W\rVert_F=1$, which is $\sum\omega^2=3$ by Lemma L50's norm relation". Passage B repeats it twice. Passage C states the relation under "$\lVert M\rVert_F=1$". No passage defines $\lVert W\rVert_F$, and the brief's definitions confirm that no relation to $\lVert M\rVert_F$ is fixed.

**Exhibit.** I take the entrywise norm $\lVert W\rVert_F^2=\sum_{ijkl}W_{ijkl}^2$, with $M$ in Passage D's convention.

- Antisymmetry in each pair gives $\sum_{ijkl}W_{ijkl}^2=4\sum_{i<j,\,k<l}W_{ijkl}^2=4\lVert M\rVert_F^2$.
- Screen on $G$ at $n=2$: $G_{1212}=G_{2121}=1$ and $G_{1221}=G_{2112}=-1$, so the entrywise $\lVert G\rVert_F^2=4$. Meanwhile $M_G=[1]$, so $\lVert M_G\rVert_F^2=1$.
- Screen of the quadratic relation for any algebraic Weyl tensor. Let $T(X)_{ij}=\sum_{kl}W_{iklj}X_{kl}$ act on all $n\times n$ matrices.
  - Pair symmetries give $W_{kijl}=W_{iklj}$, so $\mathop{\mathrm{tr}}T^2=\sum W_{iklj}W_{kijl}=\lVert W\rVert_F^2$.
  - $T$ commutes with transposition. It kills $I$ and preserves trace-free matrices, because $W$ is Ricci-flat. So $\mathop{\mathrm{tr}}_{S^2_0}T^2=\mathop{\mathrm{tr}}T^2-\mathop{\mathrm{tr}}_{\Lambda^2}T^2$.
  - On antisymmetric $X$ the first Bianchi identity gives $W_{iklj}-W_{ilkj}=-W_{ijkl}$, hence $T(X)_{ij}=-\tfrac12\sum_{kl}W_{ijkl}X_{kl}$. In the orthonormal basis $(E_{kl}-E_{lk})/\sqrt2$ this is $-M$, so $\mathop{\mathrm{tr}}_{\Lambda^2}T^2=\lVert M\rVert_F^2=\tfrac14\lVert W\rVert_F^2$.
  - Hence $\sum\omega^2=\tfrac34\lVert W\rVert_F^2=3\lVert M\rVert_F^2$.
- On the object itself: A's scaled spectrum has $\sum\omega^2=3$ (section 6), so entrywise $\lVert W\rVert_F^2=4$ and $\lVert W\rVert_F=2$. Conversely, entrywise $\lVert W\rVert_F=1$ would give $\sum\omega^2=\tfrac34$ and every eigenvalue halved: $\tfrac m2A$, $-\tfrac{m-1}2A$, $-m(m-1)A$.

**Argue the opposite.** Many authors write $\lVert W\rVert$ for the norm of $W$ as an operator on $\Lambda^2$, or define $|R|^2=\tfrac14R_{ijkl}R^{ijkl}$. Under either reading $\lVert W\rVert_F=\lVert M\rVert_F$, and the statement is correct. The proof itself normalises by $\sum\omega^2=3$ directly, so no number in the lemma depends on the reading. The candidate therefore does not survive as a refutation. It survives as a missing definition: the equivalence the statement asserts holds only under a convention the passages never state, and the default meaning of a Frobenius norm on a 4-tensor gives a factor 2.

**What would discharge it.** Replace "$\lVert W\rVert_F=1$" by "$\lVert M\rVert_F=1$" (equivalently $\sum\mu^2=1$ or $\sum\omega^2=3$), or state $\lVert W\rVert_F:=\lVert M\rVert_F$ with the $\Lambda^2$ convention of Passage D.

**Does $s$ meet the condition the statement names?** It meets $\sum\omega^2=3$, and by Passage D also $\sum\mu^2=1$, that is, $\lVert M\rVert_F=1$ with $M$ symmetric. It meets entrywise $\lVert W\rVert_F=1$ only under the charitable reading.

## 3. Item 2, the curvature of the product: CONFIRMED

- Sectional curvature: for orthonormal $e_i,e_j$ in factor 1, $G^{(1)}_{ijij}=(P_1)_{ii}(P_1)_{jj}-(P_1)_{ij}^2=1$. For $e_i$ in factor 1 and $e_j$ in factor 2, both $G^{(a)}_{ijij}$ vanish. This is the unit product.
- Ricci of $G^{(a)}$: $\sum_i\big[(P_a)_{ii}(P_a)_{jl}-(P_a)_{il}(P_a)_{ij}\big]=m(P_a)_{jl}-(P_a^2)_{jl}=(m-1)(P_a)_{jl}$. The sum over $a$ is $(m-1)(P_1+P_2)=(m-1)I$.
- Ricci of $G$: $\sum_i(\delta_{ii}\delta_{jl}-\delta_{il}\delta_{ij})=(2m-1)\delta_{jl}$.
- $\mathrm{Ric}(R-cG)=(m-1)I-c(2m-1)I=0$ exactly when $c=\frac{m-1}{2m-1}$.
- Weyl identification. The proof writes only the Ricci contraction. The missing sentence is the Einstein form of the decomposition, $W=R-\frac{\mathrm{scal}}{2n(n-1)}g\owedge g$, with $g\owedge g=2G$ and $\mathrm{scal}=2m(m-1)$. That gives $W=R-\frac{2m(m-1)}{2m(2m-1)}G=R-cG$. Equivalently, $R-cG$ satisfies the Bianchi identity and has zero Ricci contraction, and $cG$ lies in the Ricci part, so uniqueness of the orthogonal decomposition identifies it as $W$. This is textbook material, not a gap.

## 4. Item 3, the contraction: CONFIRMED

- $(\mathring G^{(a)}h)_{ij}=\sum_{kl}\big[(P_a)_{il}(P_a)_{kj}-(P_a)_{ij}(P_a)_{kl}\big]h_{kl}=(P_ahP_a)_{ji}-(P_a)_{ij}\mathop{\mathrm{tr}}(P_ah)$. The first term equals $(P_ahP_a)_{ij}$ by symmetry, so $\mathring G^{(a)}h=P_ahP_a-t_aP_a$.
- $(\mathring Gh)_{ij}=h_{ji}-\delta_{ij}\mathop{\mathrm{tr}}h=h_{ij}$ on $S^2_0$.
- The display then follows by linearity, with $W=G^{(1)}+G^{(2)}-cG$.
- Output lies in $S^2_0$ with no projection needed: $\mathop{\mathrm{tr}}(\mathring Wh)=t_1+t_2-m(t_1+t_2)-0=(1-m)\mathop{\mathrm{tr}}h=0$.
- Sign check against the sources. $\mathring G=\mathrm{Id}$ on $S^2_0$ agrees with Li's Example 2.1, "$\mathring R=\kappa\,\mathrm{id}_{S^2_0}$ on $S^n(\kappa)$". Li's operator in Section 2 is $\mathring R(\varphi)_{il}=\sum R_{ijkl}\varphi_{jk}$ with $\mathring R_i(g_i)=-\mathrm{Ric}$, which is the $iklj$ pattern with $R_{ijij}$ sectional. This agrees with Passage E.

## 5. Item 4, the three summands: CONFIRMED

- Within a factor, say $h=P_1hP_1$ with $t_1=\mathop{\mathrm{tr}}h=0$. Then $P_2hP_2=0$ and $t_2=0$, so $\mathring Wh=(1-c)h=\frac m{2m-1}h$. Dimension: $2\big(\tfrac{m(m+1)}2-1\big)=m^2+m-2=(m-1)(m+2)$.
- Cross block, $h=P_1hP_2+P_2hP_1$. Here $P_ahP_a=0$ and $t_1=\mathop{\mathrm{tr}}(P_1hP_2)=\mathop{\mathrm{tr}}(hP_2P_1)=0$, and likewise $t_2=0$. So $\mathring Wh=-ch$, on a space of dimension $m^2$.
- The line $h=P_1-P_2$. Here $\mathop{\mathrm{tr}}h=0$, $t_1=m$, $t_2=-m$, $P_1hP_1=P_1$ and $P_2hP_2=-P_2$. So $\mathring Wh=(1-m)(P_1-P_2)-ch=(1-m-c)h$, and $1-m-c=-(m-1)\frac{2m}{2m-1}$.
- Invariance: each summand is an eigenspace.
- Orthogonality in the Frobenius product: the block-diagonal and off-diagonal parts are orthogonal, and $\langle P_1-P_2,h\rangle=t_1-t_2=0$ for $h$ in the trace-free factor parts. The written proof relies on dimension count alone. Orthogonality (or distinctness of eigenvalues) supplies the independence that the count needs. It is evident from the block form but not written. No finding.
- Distinctness at $m\ge2$: $\frac m{2m-1}>0>-\frac{m-1}{2m-1}$, and $-2m(m-1)=-(m-1)$ forces $2m=1$. So there are exactly three eigenvalues. The count $(m-1)(m+2)+m^2+1=2m^2+m-1=\frac{2m(2m+1)}2-1$ matches $\dim S^2_0(\mathbb R^{2m})$.

## 6. Item 5, the scale and $A$: CONFIRMED AS ALGEBRA

- Unnormalised sum: $\frac{m^2}{(2m-1)^2}\big[(m-1)(m+2)+m^2\cdot\tfrac{(m-1)^2}{m^2}+4(m-1)^2\big]=\frac{m^2(m-1)}{(2m-1)^2}\big[(m+2)+(m-1)+4(m-1)\big]=\frac{m^2(m-1)\cdot3(2m-1)}{(2m-1)^2}=\frac{3m^2(m-1)}{2m-1}$.
- $s^2=\frac{2m-1}{m^2(m-1)}$ gives $3$. The scale $s>0$ keeps the signs, which matters because the spectrum is not symmetric.
- $\mathring W$ is linear in $W$, so the spectrum scales by $s$.
- $s\cdot\frac m{2m-1}=mA$ with $A=\frac s{2m-1}$, and $A^2=\frac{2m-1}{m^2(m-1)(2m-1)^2}=\frac1{m^2(m-1)(2m-1)}$. So $A=\frac1{m\sqrt{(m-1)(2m-1)}}>0$ at $m\ge2$. The other two eigenvalues follow the same way.

## 7. Item 6, $m\ge2$ and $m=1$: CONFIRMED

- At $m=1$, $P_a=vv^T$ has rank one, and $G^{(a)}_{ijkl}=v_iv_kv_jv_l-v_iv_lv_jv_k=0$. So $R=0$, $c=0$, $W=0$, and the flat torus claim holds.
- At $m=1$, $A$ has denominator $1\cdot\sqrt{0}=0$ and is undefined. The statement correctly excludes $m=1$ from the spectrum claim. The formal multiplicities at $m=1$ are $0,1,1$, summing to $\dim S^2_0(\mathbb R^2)=2$, with every eigenvalue $0$.
- $m\ge2$ is used in: $s$ (division by $m-1$), $A>0$, distinctness, and $(m-1)(m+2)>0$ so that the first summand is nonempty.

## 8. Item 7, Passage B against A, and Li's Theorem 1.8: CONFIRMED

Passage B, clause by clause:

- $S^m\times S^m$, $n=2m$, $m\ge2$, $\lVert W\rVert_F=1$: identical to A, and it carries the same debt (section 2).
- $iklj$ order and $R_{ijij}$ sectional: identical.
- Eigenvalues, multiplicities and $A$: identical.
- Placement. $mA$ on the trace-free parts within each factor, $-(m-1)A$ on the cross block, $-2m(m-1)A$ on $P_1-P_2$. All three match A's bullets. Minor remark: B's detail statement uses $P_1,P_2$ and "cross block", which are defined only inside A's proof. This is presentation, not correctness.
- "multiplicities sum to $\dim S^2_0=2m^2+m-1$": correct.
- "The proof substitutes $W=G^{(1)}+G^{(2)}-\frac{m-1}{2m-1}G$": matches A.
- "(second-order)" in the landscape line is a label without content to check. No finding.

"Li's Theorem 1.8 gives the same spectrum as a product rule", read at source.

- Li's statement, arXiv:2209.02119 p. 5: "the eigenvalues of $\mathring R$ are precisely those of $\mathring R_1$ and $\mathring R_2$, and 0 with multiplicity $n_1n_2$, and $-\frac{n_1\rho_2+n_2\rho_1}{n_1+n_2}$ with multiplicity one". The hypotheses are Einstein factors with $n_i\ge1$. Passage D's formula matches Li's verbatim.
- Operator and sign. Li acts on $S^2_0$ as $\pi\circ\mathring R$ with $\mathring R(\varphi)_{il}=\sum R_{ijkl}\varphi_{jk}$, and states "same notations and conventions as [Li21]". This is Passage E's convention (section 4).
- Application to unit $S^m\times S^m$: $\mathring R_a=\mathrm{Id}$ on $S^2_0(\mathbb R^m)$ by Li's Example 2.1, $\rho_a=m-1$, $n_a=m$. So $\mathrm{spec}\,\mathring R$ is $1$ with multiplicity $2\cdot\frac{(m-1)(m+2)}2$, then $0$ with multiplicity $m^2$, then $-\frac{2m(m-1)}{2m}=-(m-1)$ with multiplicity 1. Li's eigenvector $n_2g_1-n_1g_2=m(P_1-P_2)$ and his cross tensors $e_p\odot e_q$ are A's summands.
- Passage to $W$: $\mathring W=\pi\circ\mathring R-c\,\pi\circ\mathring G=\pi\circ\mathring R-c\,\mathrm{Id}$, so the eigenvectors are shared and the eigenvalues become $1-c$, $-c$ and $-(m-1)-c$. These are A's unnormalised values, and the scale $s$ then gives A's spectrum.
- Charitable reading needed: the sentence in A and B compresses the shift by $-c\,\mathrm{Id}$ and the scale $s$. Passage D states the shift explicitly ("subtracting the multiple $\frac{m-1}{2m-1}G$"). With that reading the sentence is correct. No finding beyond the compression.
- Passage D's "verified here to $1.8\times10^{-15}$" is a run and carries no weight here. The theorem stands at source.

## 9. Item 8, Passage B's further claims and Passage D

### 9a. $\Lambda^2$ side, $p_3(\mu)$, $p_3(\omega)$: CONFIRMED AS ALGEBRA

- $G^{(1)}_{ijkl}$ vanishes unless $i,j,k,l$ all lie in factor 1, and on $\Lambda^2\mathbb R^m$ of factor 1 it acts as $\mathrm{Id}$. So $R$ acts as $\mathrm{Id}$ on $\Lambda^2\mathbb R^m\oplus\Lambda^2\mathbb R^m$ (dimension $m(m-1)$) and as $0$ on the mixed part (dimension $m^2$). $G$ acts as $\mathrm{Id}$.
- $W=R-c\,\mathrm{Id}$ has eigenvalues $\frac m{2m-1}$ with multiplicity $m(m-1)$ and $-\frac{m-1}{2m-1}$ with multiplicity $m^2$. The trace is $\frac{m^2(m-1)-m^2(m-1)}{2m-1}=0$.
- $\sum\mu^2$ unnormalised is $\frac{m^3(m-1)+m^2(m-1)^2}{(2m-1)^2}=\frac{m^2(m-1)(2m-1)}{(2m-1)^2}=\frac{m^2(m-1)}{2m-1}$. That is a third of the $\omega$ sum, so $s$ gives $\sum\mu^2=1$ and $\sum\omega^2=3$ at once. This is consistent with the screen $\sum\omega^2=3\lVert M\rVert_F^2$ of section 2.
- $p_3(\mu)=s^3\frac{m^4(m-1)-m^2(m-1)^3}{(2m-1)^3}=s^3\frac{m^2(m-1)(m^2-(m-1)^2)}{(2m-1)^3}=s^3\frac{m^2(m-1)}{(2m-1)^2}=s\cdot\frac{2m-1}{m^2(m-1)}\cdot\frac{m^2(m-1)}{(2m-1)^2}=\frac s{2m-1}=A$.
- $p_3(\omega)=A^3\big[(m-1)(m+2)m^3-m^2(m-1)^3-8m^3(m-1)^3\big]=A^3m^2(m-1)\big[-8m^3+16m^2-4m-1\big]$. Here $A^3m^2(m-1)=\frac A{2m-1}$ and $(2m-1)(4m^2-6m-1)=8m^3-16m^2+4m+1$, so $p_3(\omega)=-(4m^2-6m-1)A$, matching Passage D.

### 9b. "with Lemma L50 the two spectra return $\theta=\theta_0(2m)$ identically in $m$": HYPOTHESIS-DEBT

- The algebra closes. $\tfrac32A+\tfrac12(4m^2-6m-1)A=A(2m^2-3m+1)=A(2m-1)(m-1)=\frac{\sqrt{(m-1)(2m-1)}}m$. Also $\theta_0(2m)=\frac{\sqrt{2(2m-1)(2m-2)}}{2m}=\frac{\sqrt{(2m-1)(m-1)}}m$. The difference is identically zero.
- The radical: $(2m^2-3m+1)^2=4m^4-12m^3+13m^2-6m+1$, and $2m^2-3m+1=(2m-1)(m-1)>0$ at $m\ge2$, so the positive root is the right one. On file this closing is supported by a script, but it is one line of algebra from Passage D's own displays.
- Which of L50's links it uses. The step "$\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$" is exactly the coefficient pair that Passage C says is determined by $\beta=2\langle M^\#,M\rangle$, link (a): "The whole coefficient pair is that constant". Link (a) "has no derivation anywhere". Link (b), the generalised-Kronecker proportionality and the $n\le5$ collapse, is not used, because both spectra are computed directly. The normalisation hypothesis $\lVert M\rVert_F=1$ is met by $s$ (9a).
- The debt: Passage B states the $\theta$ return as a fact without marking that it is conditional on link (a). What would have to be proved is $\beta=2\langle M^\#,M\rangle$ for Weyl tensors, or at least at this $W$.

## 10. Item 9, "$A$ is not a new constant": CONFIRMED AS ALGEBRA

- At $n=2m$: $\frac{2\sqrt2}{2m\sqrt{(2m-1)(2m-2)}}=\frac{2\sqrt2}{2m\sqrt2\sqrt{(2m-1)(m-1)}}=\frac1{m\sqrt{(m-1)(2m-1)}}=A$. The equality is exact.
- 9a shows $A=p_3(\mu)=\mathop{\mathrm{tr}}M^3$ at $\lVert M\rVert_F=1$. The quoted "record's $\mathop{\mathrm{tr}}(W^3)$" matches it if $W^3$ means $M^3$ in Passage D's convention. The passages do not say what that closed form is the value of, or where it is derived, so the agreement is confirmed only as an equality of the two expressions.

## 11. Item 10, the Lean files: CONFIRMED AS ALGEBRA, the lemma itself is not stated

**What L67Statement.lean states.** Its variable is a real number $m$, not a natural number.

- `Aconst`, `spec` and `mult` are the three proposed values and multiplicities.
- `Aconst_pos` proves $A>0$ at $m\ge2$.
- `Aconst_sq` proves $A^2=1/(m^2(m-1)(2m-1))$.
- `mult_sum` proves the multiplicities sum to $2m^2+m-1$.
- `dim_sym_traceless` is the ring identity $\frac{2m(2m+1)}2-1=2m^2+m-1$. It is not a statement about the dimension of any space.
- `spec_trace_zero` proves $\sum\mathrm{mult}\cdot\omega=0$ for all real $m$.
- `spec_normalisation` proves $\sum\mathrm{mult}\cdot\omega^2=3$ at $m\ge2$.
- `spec_strict_order` proves $-2m(m-1)A<-(m-1)A<mA$.
- `mult_pos` proves the multiplicities are positive.
- The examples at $m=1$ and $m=2$ instantiate these. `example : Aconst 1 = 0` holds only because Lean defines $1/0=0$. Mathematically $A$ is undefined at $m=1$, so this example says nothing about the lemma.

**What L67.lean states**, over $\mathbb Q$:

- The same multiplicity and dimension identities, and tracelessness for arbitrary $A$.
- The sum of squares as $3m^2(m-1)(2m-1)A^2$, which I checked in section 6.
- `A_from_omega`, which divides by 3. Its hypothesis `hm : 2 ≤ m` is unused, a stated-but-unused hypothesis.
- `A_closed_form`, the tautology $\frac1X\cdot X=1$ for $X\ne0$. It is not connected to `A_from_omega` by any theorem, so the file never states $A=1/(m\sqrt{\cdots})$.
- Instances at $m=1$ (vanishing denominator) and $m=3$: $A^2=\frac1{90}$, $(2A)^2=\frac2{45}$, $(12A)^2=\frac85$. The bracket gives $0.210818510<\sqrt{2/45}<0.210818512$, and $\sqrt{2/45}=0.2108185106\ldots$ lies inside. All are correct.

**What is not typed.** No Weyl tensor, no product manifold or projections $P_a$, no space $S^2_0$, no operator $\mathring W$, no eigenvalue or eigenvector statement, no $\lVert W\rVert_F$ or $\lVert M\rVert_F$, and no index order. The Lean files check that the proposed triple is trace-free, has $\sum\mathrm{mult}\cdot\omega^2=3$, is strictly ordered and has positive $A$. They do not state that it is the spectrum of anything. Every declaration agrees with Passage A's arithmetic and none contradicts it.

## 12. Item 11, the boundary: CONFIRMED

- $m=2$, $n=4$: $A=\frac1{2\sqrt3}$, and the eigenvalues are $\frac1{\sqrt3}$ with multiplicity 4, $-\frac1{2\sqrt3}$ with multiplicity 4, and $-\frac2{\sqrt3}$ with multiplicity 1. Screen: $\frac4{\sqrt3}-\frac2{\sqrt3}-\frac2{\sqrt3}=0$, and $\frac43+\frac13+\frac43=3$. On $\Lambda^2$ the values are $\frac23$ with multiplicity 2 and $-\frac13$ with multiplicity 4, which agrees with the known $W^\pm=\mathrm{diag}(\tfrac23,-\tfrac13,-\tfrac13)$ shape of $S^2\times S^2$. Nothing in the proof uses $n\ge5$.
- Zero eigenvalues: $mA$, $-(m-1)A$ and $-2m(m-1)A$ are all nonzero at $m\ge2$, and so are $\frac{m}{2m-1}s$ and $-\frac{m-1}{2m-1}s$. Hence $\ker\mathring W=0$ on $S^2_0$ and $\ker M=0$. The $0^{(m^2)}$ in Li's $\mathrm{spec}\,\mathring R$ moves to $-c\ne0$ in $\mathring W$. The $\ker W\ne0$ trap does not arise.
- $ikjl$ order: $W_{ikjl}=-W_{iklj}$, which gives the spectrum $-mA$, $(m-1)A$, $2m(m-1)A$ and flips the sign of $p_3(\omega)$. The lemma states Li's order, and Li's Example 2.1 fixes the sign of $\mathring G=+\mathrm{Id}$ in that order. Consistent.

## 13. The standing list and the named traps

1. Hypothesis inventory: section 1.
2. Quantifier order and scope. For each integer $m\ge2$ there is one tensor up to the normalisation, and the claim is a finite spectrum statement. There is no quantifier inversion. "Exactly three" is supported by distinctness (section 5). No finding.
3. Range edges. $m=2$ (section 12). $m=1$ is excluded and handled (section 7). There are no zero eigenvalues (section 12). No finding.
4. Subfamily used in general. The lemma is stated only on the balanced product, and Passages B and D claim nothing beyond it. Li's general theorem is applied to a member of its family. No finding.
5. Lean: section 11. The lemma is not stated in Lean, only its arithmetic.

Named traps:

- $\ker W\ne0$: absent (section 12).
- Range boundaries: section 7 and section 12. No finding.
- Subfamily used in general: no finding (above).
- Hypothesis stated but unused: `hm` in `A_from_omega` (Lean only).
- Hypothesis used but unstated: the meaning of $\lVert W\rVert_F$ (section 2), plus benign equal radii and the Ricci contraction pair.
- A universal claim with no witness: none. Each summand has explicit eigenvectors.
- An imported result whose hypotheses were never checked against the object: L50's norm relation is applied under the name $\lVert W\rVert_F=1$ while its hypothesis is $\lVert M\rVert_F=1$ (section 2). Li's hypotheses are met (section 8). L50's coefficient pair is used in Passage B with link (a) unmarked (section 9b).
- Normalisation or index-order convention taken from the wrong source: the index order matches Li at source. The $\lVert W\rVert_F$ versus $\lVert M\rVert_F$ convention is the finding of section 2.

## 14. Withdrawn candidates

- **"The Weyl identification $W=R-cG$ has no argument."** Located at "$W=R-cG$ with $c=\frac{m-1}{2m-1}$, since $G$ has Ricci tensor $(2m-1)I$". It cannot be exhibited as a failure: the Einstein formula $W=R-\frac{\mathrm{scal}}{n(n-1)}G$ gives the same $c$ (section 3). The charitable reading, that the zero Ricci contraction plus uniqueness of the orthogonal decomposition is meant, is standard. Withdrawn at step 2.
- **"Filling $S^2_0$ by dimension count needs independence that is not stated."** Located at "together fill $S^2_0$ since $(m-1)(m+2)+m^2+1=\dim S^2_0$". No failure can be exhibited: the summands are eigenspaces for three distinct eigenvalues, hence independent, and they are also visibly orthogonal. Withdrawn at step 2.
- **"Li's Theorem 1.8 gives $\mathrm{spec}\,\mathring R$, not the Weyl spectrum."** Located at the sentence in A and B. Step 3 defeats it: Passage D names the shift by $cG$, and $\mathring G=\mathrm{Id}$ makes the passage exact (section 8). Withdrawn.
- **"Passage B uses $P_1,P_2$ undefined in the statement."** This is presentation only, with no mathematical failure. Withdrawn at step 2 and recorded as a remark in section 8.

## 15. What would break it

- **Objects that would falsify the statement:**
  - an $h\in S^2_0$ orthogonal to all three summands, which is impossible by the dimension count.
  - a coincidence of two eigenvalues at some $m\ge2$, which is impossible (section 5).
  - a sign flip from the index order, which is excluded by Li's Example 2.1 (section 4).
  - a scale inconsistent with the named normalisation. This one is found under the entrywise reading of $\lVert W\rVert_F$ (section 2).
- **What I did to look:**
  - followed every contraction by hand (sections 3 to 5).
  - screened $G$ at $n=2$ for the norm factor and derived by hand the quadratic relation $\sum\omega^2=\tfrac34\lVert W\rVert_F^2=3\lVert M\rVert_F^2$ for any algebraic Weyl tensor.
  - screened $m=2$ and $m=1$.
  - read Li's Theorem 1.8, Proposition 2.1, Lemmas 2.1 to 2.3 and Example 2.1 at source to fix the operator, the sign and the hypotheses.
  - checked that the $\theta$ algebra closes and traced which L50 link it needs.
- **For Passage B's $\theta$ sentence:** a counterexample to $\beta=2\langle M^\#,M\rangle$ at this $W$ would break it. I did not look for one, since that is L50's result and out of this brief's scope.

## 16. Verdict

**PROVEN, hypotheses corrected.** The three-eigenvalue spectrum with its multiplicities, eigenspaces and constant $A$ is proven for the normalisation $\sum\omega^2=3$, equivalently $\lVert M\rVert_F=1$ with $G\mapsto\mathrm{Id}$ on $\Lambda^2$.

Corrections the round should make:

- Replace "$\lVert W\rVert_F=1$" by "$\lVert M\rVert_F=1$" (or define $\lVert W\rVert_F:=\lVert M\rVert_F$) in Passage A and both places in Passage B. Under the entrywise tensor norm the stated spectrum has $\lVert W\rVert_F=2$.
- In Passage B, mark the $\theta=\theta_0(2m)$ sentence as conditional on Lemma L50's link (a).

Staged files from other sessions: none were present when I ran git status before committing.
