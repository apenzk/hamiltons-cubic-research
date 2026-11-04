# Verifier v276, Lemma L67: the three-valued second-kind spectrum of the balanced product $S^m\times S^m$, its constant $A$ and sign, Passage B's three-line proof, Passage D's route through Li's Theorem 1.8, the side claims of Passages D and E, and the Lean statement

**The brief was cold** ([BRIEF_L67.md](BRIEF_L67.md), read in full). **No numerical work was done: no scripts, no runs, every value below is exact and derived by hand.** Li's Theorem 1.8 was read at source ([li-2209.02119.pdf](https://arxiv.org/abs/2209.02119), §1 and §2, pp. 5–10). The Lean file [L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean) was read in full and not built. Every quotation in the brief was checked against its cited lines only, and all seven match verbatim. Log: [agent_logs/verify-L67-v276.log](../agent_logs/verify-L67-v276.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | L67: at $m\ge2$, normalised $\mathring W$ at $S^m\times S^m$ has exactly the three values $mA$, $-(m-1)A$, $-2m(m-1)A$ with multiplicities $(m-1)(m+2)$, $m^2$, $1$ | CONFIRMED |
| 2 | Passage B: $R=G^{(1)}+G^{(2)}$, $c=(m-1)/(2m-1)$, the operator formula, three invariant summands, ratio $m:-(m-1):-2m(m-1)$ | CONFIRMED AS ALGEBRA |
| 3 | Passage D's route: Li Theorem 1.8 plus "subtracting the Einstein part" | GAP (closed by Passage B's $-ch$ term) |
| 4 | $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)>0$ in the $iklj$ order, from $\lVert W\rVert_F=1$, equivalently $\sum\omega^2=3$ | CONFIRMED |
| 5 | $p_3(\omega)=-(4m^2-6m-1)A$ | CONFIRMED AS ALGEBRA |
| 6 | $p_3(\mu)=A$ | HYPOTHESIS-DEBT |
| 7 | "$A$ is not a new constant": $A=2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$ at $n=2m$ | CONFIRMED AS ALGEBRA |
| 8 | The radical $\sqrt{4m^4-12m^3+13m^2-6m+1}=2m^2-3m+1$ | CONFIRMED AS ALGEBRA |
| 9 | Closure $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ | HYPOTHESIS-DEBT |
| 10 | "$p_3(\mu)$ is worth $2.7\%$ at $m=6$" | CONFIRMED AS ALGEBRA |
| 11 | "The unbalanced products have a fourth value" | HYPOTHESIS-DEBT |
| 12 | Passage B's corroboration, $0.210818511$ at $S^3\times S^3$ | CONFIRMED AS ALGEBRA |
| 13 | The Lean file states the lemma | REFUTED AS STATED (it states a fragment, and says so) |

**Summary: the lemma is PROVEN from Passage B's formula and Li's Theorem 1.8 under the charitable reading of B's undefined symbols. The side claims $p_3(\mu)=A$, the $\theta_0$ closure and the fourth value carry no argument in the passages, and none of them is used by the lemma.**

## 0. Conventions, fixed once

- $V=V_1\oplus V_2=\mathbb R^m\oplus\mathbb R^m$, $n=2m$, $P_i$ the orthogonal projection onto $V_i$, $g=I=P_1+P_2$. For $h\in S^2(V)$, $t_i=\mathop{\mathrm{tr}}(P_ih)$.
- **Curvature sign convention: $R_{ijij}=+\sec(e_i,e_j)$.** This is Li's. It is pinned by two identities at source: Li §2, Example 2.1, $\mathring R=\kappa\,\mathrm{id}_{S^2_0}$ on $S^n(\kappa)$, and the proof of Li's Lemma 2.3, $\mathring R_i(g_i)=-\mathrm{Ric}(R_i)$. With $\mathrm{Ric}_{il}=\sum_jR_{ijlj}$, the second reads $\sum_jR_{ijjl}=-\sum_jR_{ijlj}$, which holds only under $R_{ijij}=+\sec$ with the operator below.
- **Operator: $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$** (Passage G). Li's introduction writes the bilinear form $\mathring R(\varphi,\psi)=R_{ijkl}\varphi_{il}\psi_{jk}$ (txt line 33), whose operator is $(\mathring R\varphi)_{jk}=\sum_{il}R_{jilk}\varphi_{il}$, the same pattern. Li's §2 proofs compute $\sum_{j,k}R(e_i,e_j,e_k,e_l)\varphi(e_j,e_k)$, again the same pattern.
- **Source note, not load-bearing.** Li 2022 p. 7 displays $\mathring R(\varphi)_{ij}=\sum_{k,l}R_{ijkl}\varphi_{kl}$ (confirmed on the PDF page, not an extraction artefact). Read literally this vanishes on $S^2(V)$ by antisymmetry in $kl$, so it is a typo at source. Every computation in Li's §2 uses the $iklj$ pattern, and the record takes its convention from Li 2021 (2.2), so nothing downstream reads the typo.
- Constant-curvature tensors: $G_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$, $G^{(i)}_{ijkl}=(P_i)_{ik}(P_i)_{jl}-(P_i)_{il}(P_i)_{jk}$. Kulkarni–Nomizu product $(h\owedge k)_{ijkl}=h_{ik}k_{jl}+h_{jl}k_{ik}-h_{il}k_{jk}-h_{jk}k_{il}$, so $G=\tfrac12g\owedge g$ and $G^{(i)}=\tfrac12P_i\owedge P_i$.
- **$\Lambda^2$ normalisation: $M_{(ij),(kl)}=W_{ijkl}$ for $i<j$, $k<l$, on the orthonormal basis $e_i\wedge e_j$.** $\lVert W\rVert_F=\lVert M\rVert_F$, $\mu=\mathop{\mathrm{spec}}M$, so $\lVert W\rVert_F=1$ is $\sum\mu^2=1$. Then $|W|^2=\sum_{ijkl}W_{ijkl}^2=4\lVert M\rVert_F^2$. This choice is pinned by a derived identity in §4, which is the only reading under which the record's pair $\sum\mu^2=1$, $\sum\omega^2=3$ is consistent.
- $m$ is an integer, $m\ge2$ unless stated.

## Hypothesis inventory

| # | Hypothesis | Where stated | Used by | Satisfiable |
|---|---|---|---|---|
| H1 | $m\ge2$ | Passage A. **Absent from Passage E.** | $A$'s denominator, $W\ne0$, distinctness of the three values | Yes, $m=2$. At $m=1$ $W=0$ (§3), so E's "normalised to $\lVert W\rVert_F=1$" already forces H1 (withdrawn candidate W1) |
| H2 | Round product metric with equal radii | Implicit: B's $R=G^{(1)}+G^{(2)}$, D's "balanced" | B's formula, D's Einstein subtraction | Yes. Scope check in §1.4: unequal radii give the same normalised $W$ |
| H3 | Curvature sign $R_{ijij}=+\sec$ | **Used but unstated in Passages C and G**, which attribute the sign of $A$ to the index order alone | The sign of $A$, hence which value is the bottom | Yes. Supplied by "the record's convention is Li's" (withdrawn candidate W3) |
| H4 | Index order $iklj$ | Passage G | Sign of $\mathring W$ | Yes |
| H5 | $\Lambda^2$ normalisation $M_{(ij),(kl)}=W_{ijkl}$ | Brief's definitions, loosely ("Frobenius norm of $W$ acting on $\Lambda^2$") | Magnitude of $A$ | Yes, pinned in §4 |
| H6 | Li Thm 1.8: $(M_i,g_i)$ Einstein, $\mathrm{Ric}(g_i)=\rho_ig_i$, $n_i\ge1$ | Li, at source | Passage D | Yes: unit $S^m$ has $\rho=m-1$, $n_i=m\ge1$ |
| H7 | $\mathop{\mathrm{spec}}\mathring R_i$ on round $S^m$: $\kappa$ on $S^2_0(V_i)$ | Li Example 2.1 (stated without proof, $n\ge2$). Not cited by the record | Passage D (Thm 1.8 needs the factor spectra as input) | Yes, and B's formula restricted to one factor gives it (§1.2) |
| H8 | The product is Einstein, $\rho_1=\rho_2$ | Implicit in D's "Einstein part" | The shift $\mathring W=\mathring R-c\,\mathrm{id}$ | Yes at equal radii |
| H9 | $\sum\omega^2=3\sum\mu^2$ on $\mathcal W_n$ | Not in the passages. The Lean file cites "the source's $\tfrac34|W|^2$" without quoting it | Equivalence of $\lVert W\rVert_F=1$ with $\sum\omega^2=3$ | Holds, derived in §4 as the normalisation-settling identity |
| H10 | Meanings of $G^{(1)},G^{(2)},G,P_1,P_2,t_1,t_2$ | **Nowhere in the passages** | Passage B | Charitable reading (§0) makes every B claim true (withdrawn candidate W2) |

## 1. Claim 1, the spectrum (CONFIRMED)

### 1.1 The curvature, the Weyl tensor, and $c$

- $R=G^{(1)}+G^{(2)}$ is the curvature of unit $S^m\times S^m$: by Li (2.2) the product curvature is the direct sum, and unit $S^m$ has curvature $G^{(i)}$ in convention H3.
- $\mathrm{Ric}(G^{(i)})_{il}=\sum_jG^{(i)}_{ijlj}=\mathop{\mathrm{tr}}(P_i)(P_i)_{il}-(P_i)_{il}=(m-1)(P_i)_{il}$. So $\mathrm{Ric}(R)=(m-1)g$, $s=2m(m-1)$.
- For an Einstein tensor the trace-free Ricci part vanishes and $W=R-\frac{s}{n(n-1)}G$, with $\frac{s}{n(n-1)}=\frac{2m(m-1)}{2m(2m-1)}=\frac{m-1}{2m-1}=c$.
- Derived check: $\mathrm{Ric}(W)=(m-1)g-c(n-1)g=(m-1)g-(m-1)g=0$. **$c$ is the right constant.**

### 1.2 The operator formula (Passage B, Passage G)

- $\sum_{k,l}G^{(1)}_{iklj}h_{kl}=\sum_{kl}\big[(P_1)_{il}(P_1)_{kj}-(P_1)_{ij}(P_1)_{kl}\big]h_{kl}=(P_1hP_1)_{ij}-t_1(P_1)_{ij}$.
- Likewise $\mathring G^{(2)}h=P_2hP_2-t_2P_2$ and $\mathring Gh=h-(\mathop{\mathrm{tr}}h)g$.
- Hence $\mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-c\,h+c(\mathop{\mathrm{tr}}h)g$, which on $S^2_0$ is **exactly B's formula**.
- $\mathring W$ maps $S^2_0$ into itself with no projection: $\mathop{\mathrm{tr}}\mathring Wh=t_1+t_2-m t_1-m t_2=(1-m)\mathop{\mathrm{tr}}h=0$.
- Restricted to one factor, $\mathring G^{(1)}=\mathrm{id}$ on $S^2_0(V_1)$, which is H7 at $\kappa=1$.

### 1.3 The three summands, values and multiplicities

Write $h=\begin{pmatrix}a&b\\b^{\mathsf T}&d\end{pmatrix}$, $a,d\in S^2(\mathbb R^m)$, $b\in\mathbb R^{m\times m}$, $\mathop{\mathrm{tr}}a+\mathop{\mathrm{tr}}d=0$. Then $\mathring Wh=\begin{pmatrix}a-(\mathop{\mathrm{tr}}a)I&0\\0&d-(\mathop{\mathrm{tr}}d)I\end{pmatrix}-c\,h$.

| Summand | Elements | $\mathring Wh$ | Eigenvalue | Dimension |
|---|---|---|---|---|
| $E_1=S^2_0(V_1)\oplus S^2_0(V_2)$ | $b=0$, $\mathop{\mathrm{tr}}a=\mathop{\mathrm{tr}}d=0$ | $(1-c)h$ | $\frac{m}{2m-1}$ | $2\cdot\frac{(m-1)(m+2)}2=(m-1)(m+2)$ |
| $E_2$, cross block | $a=d=0$ | $-c\,h$ | $-\frac{m-1}{2m-1}$ | $m^2$ |
| $E_3=\mathbb R(P_1-P_2)$ | $a=I$, $d=-I$, $b=0$ | $(1-m)h-c\,h$ | $-\frac{2m(m-1)}{2m-1}$ | $1$ |

- The three are mutually orthogonal, and $(m-1)(m+2)+m^2+1=2m^2+m-1=\binom{2m+1}2-1=\dim S^2_0$, so they exhaust $S^2_0$. Any $h$ decomposes with $a=a_0+\frac{\mathop{\mathrm{tr}}a}mI$, $d=d_0-\frac{\mathop{\mathrm{tr}}a}mI$.
- Unnormalised values: $A_0\{m,-(m-1),-2m(m-1)\}$ with $A_0=\frac1{2m-1}>0$. **The ratio and the assignment of multiplicities are as stated.**
- **Independent route via Li.** Thm 1.8 with $\mathring R_i=\mathrm{id}$ (H7) gives $\mathop{\mathrm{spec}}\mathring R=\{1^{((m-1)(m+2))},0^{(m^2)},-(m-1)^{(1)}\}$, the last from $-\frac{m\rho+m\rho}{2m}$ at $\rho=m-1$. Subtracting $c\,\mathrm{id}$ (§1.2) gives $\{1-c,-c,-(m-1)-c\}$, the same table. The eigenvectors also agree: Li's $E$ is $E_2$, Li's $\zeta\propto n_2g_1-n_1g_2$ is $E_3$.
- Distinctness at $m\ge2$ with $A>0$: $-2m(m-1)A<-(m-1)A$ iff $(2m-1)(m-1)A>0$, and $-(m-1)A<mA$ iff $(2m-1)A>0$. **Exactly three values, bottom $-2m(m-1)A$.**

### 1.4 Scope check on H2, unequal radii (a candidate falsifier, not a repair)

- $R=aG^{(1)}+bG^{(2)}$, $a,b>0$. $G^{(1)}-G^{(2)}=\tfrac12(P_1\owedge P_1-P_2\owedge P_2)=\tfrac12(P_1-P_2)\owedge g$ because $\owedge$ is symmetric. A Kulkarni–Nomizu product with $g$ has zero Weyl part, so $W(G^{(1)})=W(G^{(2)})$.
- Hence $W(R)=\frac{a+b}2W(G^{(1)}+G^{(2)})$, a positive multiple of the equal-radii Weyl tensor. **After normalisation the spectrum is independent of the radii**, so this object does not falsify the statement. This is the verifier's scope check, recorded so the reading "$S^m\times S^m$ with any round radii" is known to be harmless. The lemma as written does not need it.

## 2. Claim 2, Passage B (CONFIRMED AS ALGEBRA)

- Every algebraic assertion of B checks under the §0 reading: $R$, $c$, the formula, $O(m)\times O(m)$-invariance of $E_1,E_2,E_3$ (each is defined by block shape and traces, preserved by $\mathrm{diag}(Q_1,Q_2)$), and the ratio.
- **What B does not write:** the definitions of its seven symbols (H10), the curvature sign convention (H3), the evaluation of the formula on each summand, and which multiplicity goes with which ratio entry. The multiplicities are on file only in Passage D's table.
- The verdict is AS ALGEBRA because B asserts results whose one-line verifications are omitted. Each verification is a substitution into B's own formula, and §1.3 performs them as checks.

### 2.1 Withdrawn candidates for Claim 2

**W2, undefined symbols.** (1) Line 507: "Write $R=G^{(1)}+G^{(2)}$ and $W=R-cG$ … $P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-ch$", no definition in any passage. (2) Under a different reading, for instance $G$ the curvature of radius-$r$ spheres or $t_i=\mathop{\mathrm{tr}}h_{ii\text{-block}}/m$, $c$ and the formula change. (3) Charitable reading: $P_i$ the factor projections, $t_i=\mathop{\mathrm{tr}}(P_ih)$, $G^{(i)}$ and $G$ the unit constant-curvature tensors. This is the only reading under which $c=(m-1)/(2m-1)$ makes $W$ trace-free, so the symbols are determined by B's own constant. **Withdrawn**, with the text owing the definitions.

**W2b, the parenthetical names the wrong three summands.** (1) Line 507: "three $O(m)\times O(m)$-invariant summands (the two within-factor trace-free parts and the cross block)". (2) Literal reading $S^2_0(V_1)$, $S^2_0(V_2)$, cross block: dimensions sum to $2m^2+m-2$, missing $P_1-P_2$, and the first two share the eigenvalue $mA_0$, so no ratio of three distinct entries can be read off them. The missing line is exactly the eigenspace of $-2m(m-1)A_0$. (3) Charitable reading: the within-factor block $\{b=0\}\cap S^2_0$ splits into two trace-free parts, the factorwise trace-free part $E_1$ and the trace line $E_3$, plus the cross block $E_2$. That reading gives the correct three summands. **Withdrawn**, with the parenthetical owing the words "and the line $\mathbb R(P_1-P_2)$".

## 3. Claim 3, Passage D's route (GAP, closed by Passage B)

- **Li Thm 1.8 at source (p. 5):** "Let $(M_i,g_i)$ be an $n_i$-dimensional Einstein manifold with $\mathrm{Ric}(g_i)=\rho_ig_i$ and $n_i\ge1$ … Then the eigenvalues of $\mathring R$ are precisely those of $\mathring R_1$ and $\mathring R_2$, and $0$ with multiplicity $n_1n_2$, and $-\frac{n_1\rho_2+n_2\rho_1}{n_1+n_2}$ with multiplicity one." D's transcription matches.
- **Proof at source.** Li's Lemmas 2.1–2.3 and the orthonormal basis of Prop. 2.1 were read link by link. Lemma 2.2 checks $\mathring R\varphi_p$ on the $V_1$ block and the $V_2$ block and omits the mixed block $i\le n_1<l$, where (2.3) gives $0$ at once. Lemma 2.3's projection computation checks: the $g_1$ coefficient is $-n_2\rho_1+\frac{n_1n_2(\rho_1-\rho_2)}{n_1+n_2}=-\frac{n_2(n_1\rho_2+n_2\rho_1)}{n_1+n_2}$. No defect that reaches L67.
- **Hypotheses against the object.** Unit $S^m$ is Einstein, $\rho=m-1$, $n_i=m\ge1$. At $m=1$ H6 still holds ($\rho=0$), but Thm 1.8 then describes $R=0$.
- **The gap.** D's step "subtracting the Einstein part to reach the Weyl tensor" is one phrase. D states neither $c$ nor that the Einstein part acts as $c\,\mathrm{id}$ on $S^2_0$ (which is $\mathring Gh=h-(\mathop{\mathrm{tr}}h)g$), nor the factor spectra H7 that Thm 1.8 takes as input. The table and $A$ are then attributed to [run_maximiser_closed_form.py](../scripts/runs/run_maximiser_closed_form.py), and the Thm 1.8 check to a run at $1.8\times10^{-15}$, which adds nothing to a filed, proven theorem.
- **Closure.** Passage B's $-ch$ term, with its formula restricted to a factor for H7, supplies exactly the missing step. Since B is at the lemma's own block, the lemma's chain is complete even though Passage A's locator ("the surrounding material") points to the half with the gap.

## 4. Claim 4, the constant $A$ (CONFIRMED)

### 4.1 The normalisation identity (settles H5 and H9)

- Let $T$ act on $V\otimes V$ by $(Th)_{ij}=\sum_{kl}W_{iklj}h_{kl}$. Its Hilbert–Schmidt norm squared is $\sum_{ijkl}W_{iklj}^2=|W|^2$.
- $T$ is self-adjoint ($W_{kijl}=W_{iklj}$ by the two antisymmetries) and commutes with transpose ($(Th)_{ji}=\sum W_{ilkj}h_{kl}=(Th^{\mathsf T})_{ij}$), so $V\otimes V=S^2\oplus\Lambda^2$ splits $\lVert T\rVert^2$. $T(g)_{ij}=\sum_kW_{ikkj}=-\mathrm{Ric}(W)_{ij}=0$, so $\lVert T|_{S^2}\rVert^2=\sum\omega^2$.
- On antisymmetric $h$, the first Bianchi identity $W_{ijkl}+W_{iklj}+W_{iljk}=0$ contracted with $h_{kl}$ gives $\sum W_{ijkl}h_{kl}+2(Th)_{ij}=0$. In the orthonormal coordinates $x_{kl}=\sqrt2h_{kl}$ ($k<l$) this is $T|_{\Lambda^2}=-M$, so $\lVert T|_{\Lambda^2}\rVert^2=\sum\mu^2$.
- **Derived identity: $|W|^2=\sum\omega^2+\sum\mu^2$, and with $|W|^2=4\sum\mu^2$, $\sum\omega^2=3\sum\mu^2$ on every $W\in\mathcal W_n$.**
- If instead the $\Lambda^2$ operator carried a factor $2$ ($M'=2M$), then $\sum\mu'^2=1$ would force $\sum\omega^2=\tfrac34$, contradicting the record's $3$. So H5 is the record's normalisation, and $\lVert W\rVert_F=1$ is equivalent to $\sum\omega^2=3$. **Neither of C's two confirmations is independent of the other as a constraint.** They are independent as computations only.

### 4.2 Magnitude

- From §1.3, $\sum\omega^2=A^2m^2(m-1)\big[(m+2)+(m-1)+4(m-1)\big]=3A^2m^2(m-1)(2m-1)$. Setting it to $3$: $A^2=\frac1{m^2(m-1)(2m-1)}$.
- Cross-check through $\Lambda^2$: $M_W=\Pi_{\Lambda^2V_1}+\Pi_{\Lambda^2V_2}-c\,I$, values $\frac m{2m-1}$ (mult. $m(m-1)$) and $-\frac{m-1}{2m-1}$ (mult. $m^2$), trace $0$, $\sum\mu_0^2=\frac{m^2(m-1)}{2m-1}$, and $\sum\omega_0^2=3A_0^2m^2(m-1)(2m-1)=\frac{3m^2(m-1)}{2m-1}=3\sum\mu_0^2$. With $\lambda^2=\frac{2m-1}{m^2(m-1)}$, $A^2=\lambda^2A_0^2=\frac1{m^2(m-1)(2m-1)}$. Agrees.

### 4.3 Sign

- The normalised tensor is $\lambda W_0$ with $\lambda>0$: $W$ is "the Weyl tensor of $S^m\times S^m$", and metric rescaling multiplies orthonormal-frame curvature by a positive number. So $A=\lambda A_0>0$, given H3 and H4.
- Under $ikjl$ the operator negates (antisymmetry in the last pair), so $A<0$ in the table's form. Passage G's statement of this is correct.
- **Passage E states $A$**: its statement sentence says only "the constant fixed by the normalisation", which fixes $A^2$, but the same entry then writes "$A=1/(m\sqrt{(m-1)(2m-1)})$ in the record's $iklj$ order". So the canon states it, one sentence after the statement.

### 4.4 Withdrawn candidate W3, the sign source

(1) Line 511: "the two signs are the two index orders". (2) With $iklj$ fixed but $R_{ijji}=+\sec$, $G$ changes sign, $\mathring G=-\mathrm{id}$ on $S^2_0$, and $A<0$: the bottom value becomes $+2m(m-1)|A|$ read off the same table. So the index order alone does not fix the sign. (3) Charitable reading: Passage G adopts "Li's convention", and Li's convention includes the curvature sign through $\mathring R=\kappa\,\mathrm{id}$ on $S^n(\kappa)$ and $\mathring R(g)=-\mathrm{Ric}$ (§0). With the curvature convention fixed, the only remaining freedom is the index order, and C's sentence is then true. **Withdrawn**, with H3 recorded as used and unstated in the passages.

## 5. Claims 5 to 12, the side claims of Passages D and E

**Which the lemma uses:** none. L67's statement is the table and $A$. Claims 5 to 11 feed L50's closure and the canon's commentary.

### 5.1 Claim 5, $p_3(\omega)$ (CONFIRMED AS ALGEBRA)

- $p_3(\omega)=A^3m^2(m-1)\big[m(m+2)-(m-1)^2-8m(m-1)^2\big]=A^3m^2(m-1)(-8m^3+16m^2-4m-1)$.
- $-8m^3+16m^2-4m-1=(2m-1)(-4m^2+6m+1)$, expanded: $-8m^3+12m^2+2m+4m^2-6m-1$. With $A^2m^2(m-1)(2m-1)=1$, $p_3(\omega)=-(4m^2-6m-1)A$. D's "Hence" follows from the table by algebra.

### 5.2 Claim 6, $p_3(\mu)=A$ (HYPOTHESIS-DEBT)

- D writes $p_3(\mu)$ after "Hence", but the table is the $\omega$-spectrum and no passage gives the $\Lambda^2$ spectrum. The claim rests on [run_maximiser_closed_form.py](../scripts/runs/run_maximiser_closed_form.py).
- **What would have to be proved:** that normalised $M_W$ at $S^m\times S^m$ has values $\lambda\frac m{2m-1}$ (mult. $m(m-1)$) and $-\lambda\frac{m-1}{2m-1}$ (mult. $m^2$), $\lambda^2=\frac{2m-1}{m^2(m-1)}$.
- The verifier's exact check of §4.2 gives $p_3(\mu)=\lambda^3\frac{m^2(m-1)(m^2-(m-1)^2)}{(2m-1)^3}=\frac{\lambda^3m^2(m-1)}{(2m-1)^2}=\frac1{m\sqrt{(m-1)(2m-1)}}=A$. The value is right. The check is the verifier's and does not discharge the record's debt.

### 5.3 Claim 7, "$A$ is not a new constant" (CONFIRMED AS ALGEBRA)

- At $n=2m$: $\frac{2\sqrt2}{2m\sqrt{(2m-1)(2m-2)}}=\frac{\sqrt2}{m\sqrt2\sqrt{(2m-1)(m-1)}}=A$.
- The identification of "the record's $\mathop{\mathrm{tr}}(W^3)$" with $p_3(\mu)$ is not written in the passages, and "checked to be identically zero difference" is a run. The equality of the two closed forms is exact.

### 5.4 Claim 8, the radical (CONFIRMED AS ALGEBRA)

$(2m^2-3m+1)^2=4m^4-12m^3+13m^2-6m+1$, and $2m^2-3m+1=(2m-1)(m-1)\ge0$ for $m\ge1$, so the positive root is taken.

### 5.5 Claim 9, the $\theta_0$ closure (HYPOTHESIS-DEBT)

- $\theta_0$ is defined in no passage of the brief, so the equation cannot be checked here. The closure is attributed to a run.
- What the left side is, exactly: $\tfrac32A+\tfrac12(4m^2-6m-1)A=A(2m^2-3m+1)=A(2m-1)(m-1)=\frac{\sqrt{(m-1)(2m-1)}}m=\frac{\sqrt{2(n-1)(n-2)}}n$ at $n=2m$.
- **What would have to be proved:** $\theta_0(2m)=\sqrt{(m-1)(2m-1)}/m$ from $\theta_0$'s definition, plus L50's identity and its sign in the $iklj$ order (L50 itself records two owed links).

### 5.6 Claim 10, "$2.7\%$ at $m=6$" (CONFIRMED AS ALGEBRA, conditional on Claim 9)

- Reading: the share of $\theta$ carried by the $\tfrac32p_3(\mu)$ term. It is $\frac{(3/2)A}{A(2m-1)(m-1)}=\frac3{2(m-1)(2m-1)}$, which at $m=6$ is $\frac3{110}=0.02\overline{72}$, i.e. $2.7\%$.
- The other reading, $p_3(\mu)/\theta=\frac1{55}$, gives $1.8\%$, so the record means the first. The claim presupposes that the left side of Claim 9 is $\theta$.

### 5.7 Claim 11, "the unbalanced products have a fourth value" (HYPOTHESIS-DEBT)

- No argument in the passages.
- **What would have to be proved**, for $S^p\times S^q$, $p\ne q$: by §1.4's radii independence (which holds for any $p,q$) take Einstein radii $(p-1)\kappa_1=(q-1)\kappa_2=\rho$. Li's Thm 1.8 then gives $\mathring W$ values $\kappa_1-c'$, $\kappa_2-c'$, $-c'$, $-\rho-c'$ with $c'=\rho/(n-1)$, four distinct when $p,q\ge2$.
- **Boundary candidate, withdrawn as a refutation.** (1) Passage E: "the unbalanced products have a fourth value". (2) $S^1\times S^q$, $q\ge2$: $G^{(1)}=0$ on a line, so $R=bG^{(2)}$ and $W=bW(G^{(2)})=bW(G^{(1)})=0$. There is no spectrum to normalise and no fourth value. (3) Charitable reading: the family in context is products with normalisable $W$, i.e. $p,q\ge2$, matching Li's Example 2.1 range $n\ge2$. Withdrawn, and the canon owes "$p,q\ge2$".

### 5.8 Claim 12, the $0.210818511$ corroboration (CONFIRMED AS ALGEBRA, magnitude only)

- At $m=3$: $A=\frac1{3\sqrt{10}}$, values $\frac1{\sqrt{10}}$, $-\frac2{3\sqrt{10}}=-\frac{\sqrt{10}}{15}$, $-\frac4{\sqrt{10}}$.
- $\frac{\sqrt{10}}{15}=0.21081851067\ldots$, which rounds to $0.210818511$. So the record's number is $|-(m-1)A|$ at $m=3$, the cross-block value with its sign dropped.
- "$B$-block" is defined in no passage and [nondegeneracy.md](../findings/nondegeneracy.md) is not quoted in the brief, so the identification is unchecked. A numeral matching in magnitude carries no weight on the sign, which is settled in §4.3 by derived identity. It carries no weight for the lemma either way.

## 6. Claim 13, the Lean file (REFUTED AS STATED as a statement of L67)

- **What it types:** $A$ as a real function, the three values and multiplicities as lists over real $m$, and proves $A>0$ and $A^2$ at $m\ge2$, the multiplicity sum, $\sum\text{mult}\cdot\text{spec}=0$, $\sum\text{mult}\cdot\text{spec}^2=3$, strict ordering, positivity of multiplicities, and an $m=2$ witness. Each theorem is a true statement, checked against §1.3 and §4.2.
- **What it does not type:** $\mathring W$, the Weyl tensor of $S^m\times S^m$, $\lVert W\rVert_F$, or that the list is a spectrum. **The file says so** (lines 33–48). So it does not state L67, and it makes no claim that it does.
- **Normalisation surrogate.** The lemma's hypothesis is $\lVert W\rVert_F=1$, i.e. $\sum\mu^2=1$. The file encodes $\sum\omega^2=3$ and calls $\sum\mu^2=1$ "a different sum over a different space". The two are equivalent on $\mathcal W_n$ by §4.1, so nothing is wrong mathematically, but the file proves the consequence rather than the hypothesis.
- `Aconst 1 = 0` is Lean's $1/0=0$, not a value of $A$. The docstring reads it correctly as a zero denominator.
- **Stale quotation, no mathematical impact.** (1) Lean lines 19–25 claim to quote the block verbatim. (2) Source lines 511–513 contain "which [conventions.md] flags as the sharpest hazard here" (absent in Lean) and end "The bottom eigenvalue is $-2m(m-1)A$, which is what every citer takes and what the canon must state", where Lean has "A reader of the canon could not previously conclude that the bottom eigenvalue is $-2m(m-1)A$, which is what every citer takes". (3) Most charitable reading: the block was edited after the file was written, and both texts assert the same bottom eigenvalue. The discrepancy is real and documentary. It is recorded, not verdict-bearing.
- "Holds vacuously at $m=1$" (Lean lines 30, 157) misuses the word: $0+1+1=2$ holds non-vacuously. Documentary.

## 7. The standing list

**Item 1, hypotheses.** The inventory table above. Used but unstated: H3 (sign convention), H9 (the $\tfrac34|W|^2$ identity), H10 (B's symbols), H7 (factor spectra, which D needs and does not cite). All satisfiable.

**Item 2, quantifier order and scope.** For every integer $m\ge2$, for the round product (any radii, §1.4), normalised with $\lambda>0$ to $\lVert W\rVert_F=1$ in the $\Lambda^2$ normalisation H5, with index order $iklj$ and curvature sign H3, the spectrum is the table with $A=A(m)$. $A$ depends on $m$ only. The Lean file's real $m\ge2$ contains the integer case. No finding: the order is unambiguous once H3 and H5 are fixed.

**Item 3, edges.**
- $m=1$: $n=2$, $\mathcal W_2=0$, $G^{(i)}=0$, $c=0$, $R=0$, $W=0$. The normalisation is impossible and $m\sqrt{(m-1)(2m-1)}=0$. The $(m-1)(m+2)=0$ multiplicity and the vanishing of the other two values agree.
- $m=2$ ($n=4$, $S^2\times S^2$): $A=\frac1{2\sqrt3}$, values $\frac1{\sqrt3}$ (×4), $-\frac1{2\sqrt3}$ (×4), $-\frac2{\sqrt3}$ (×1). Trace $\frac4{\sqrt3}-\frac2{\sqrt3}-\frac2{\sqrt3}=0$, squares $\frac43+\frac13+\frac43=3$. Equal multiplicities $4,4$ with distinct values. No finding.
- Kernel: $\ker\mathring R=E_2$ (Li Lemma 2.1) is shifted to $-c$. At $m\ge2$ all three values are nonzero, so $\mathring W$ is injective on $S^2_0$. No finding.
- The crossover $n=6+2\sqrt7$ (root of $n^2-12n+8$) bears on no claim here: the ordering of the three values holds for all $m\ge2$, and the only sign change in the side claims, $4m^2-6m-1=0$, sits at $m=\frac{3+\sqrt{13}}4<2$. No finding.

**Item 4, proven against stated and used.** The lemma as stated in Passages A and E is proven by B plus Li. E omits $m\ge2$ (implied, W1). The canon's commentary adds Claims 6, 9 and 11, which rest on runs or on nothing in the passages and are not used by L67. D's heading "Proved symbolically in $m$" overstates what D writes, since D's own chain has the §3 gap and attributes its closed forms to runs.

**Item 5, Lean.** §6: a fragment, correctly self-described, which does not state the lemma.

**Item 6, the brief's attack items.**
1. Where the argument is: B establishes the spectrum given its symbols. D alone has the §3 gap. A's locator points to D. Imports: Li Thm 1.8 (D), H7 and H3 (both, unstated).
2. B's objects: undefined in every passage (W2). $R=G^{(1)}+G^{(2)}$ is the unit-sphere product curvature in convention H3. $c$ is the trace-free constant (§1.1).
3. The operator formula agrees with Passage G on $S^2_0$, and is off $S^2_0$ by $c(\mathop{\mathrm{tr}}h)g$ (§1.2).
4. Summands and ratio correct under the charitable reading. Literal parenthetical omits $\mathbb R(P_1-P_2)$ (W2b). Multiplicities assigned correctly (§1.3).
5. Li at source, hypotheses satisfied. The Einstein subtraction is unwritten in D (§3).
6. $A$ and its sign CONFIRMED. Both sums fix $A^2$, equivalently by §4.1. E states the value one sentence after its statement (§4.3).
7. $m\ge2$ is forced. At $m=1$ $W=0$ (Item 3).
8. Claims 5, 7, 8, 10 algebra. Claims 6, 9, 11 debt. The lemma uses none (§5).
9. Magnitude of the cross-block value at $m=3$. Sign dropped, "$B$-block" undefined (§5.8).
10. §6.
11. $m=1$, $m=2$: Item 3. $ikjl$ against $iklj$: negation, with the curvature sign as a second, unstated source of sign (W3).

**Item 7, falsifiers and what was done to look.**

| Claim | Falsifying object | Search |
|---|---|---|
| 1 | An $h\in S^2_0$ outside $E_1\oplus E_2\oplus E_3$, or a summand on which $\mathring W$ is not scalar | Exhaustive dimension count, formula evaluated on each summand, and Li's eigenbasis compared independently (§1.3) |
| 1 | Unequal radii | Weyl part of $G^{(1)}-G^{(2)}$ shown zero (§1.4) |
| 4 | A $\Lambda^2$ normalisation with a factor $2$ | Excluded by $\sum\omega^2=3\sum\mu^2$ (§4.1) |
| 4 | Opposite curvature sign | Excluded by Li's $\mathring R(g)=-\mathrm{Ric}$ and Example 2.1 (§0, W3) |
| 1, E | $m=1$ | $W=0$ (Item 3) |
| 5 | A non-factoring cubic | Factorisation by $(2m-1)$ expanded (§5.1) |
| 11 | $S^1\times S^q$ | $W=0$, withdrawn under the $p,q\ge2$ reading (§5.7) |
| 12 | A sign mismatch | Found. The numeral is the magnitude, and the sign is settled by §4.3 |

## Overall verdict

**PROVEN.** L67's three values, multiplicities and $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)>0$ follow from Passage B's formula, checked link by link, and independently from Li's Theorem 1.8 read at source.

Owed by the text, none of which changes the statement:
- definitions of B's symbols
- the curvature sign convention beside the index order
- the line $\mathbb R(P_1-P_2)$ in B's parenthetical
- $m\ge2$ in Passage E
- an argument for $p_3(\mu)=A$, for the $\theta_0$ closure, and for the fourth value (with $p,q\ge2$)
