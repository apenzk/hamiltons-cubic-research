# Verifier v275, Lemma L67: the three-value second-kind spectrum of the normalised Weyl tensor of S^m x S^m, the constant A and its sign, Passage B's proof, Passage D's route through Li's Theorem 1.8, and the surrounding claims (p3 values, closure, 2.7%, fourth value, corroboration, Lean statement)

*The brief ([BRIEF_L67.md](BRIEF_L67.md)) was cold. No numerical work was done: every value below is exact, no script was written or run, and the Lean file was read and not built. Log: [agent_logs/verify-L67-v275.log](../agent_logs/verify-L67-v275.log).*

| # | Claim | Source | Verdict |
|---|---|---|---|
| C1 | At $S^m\times S^m$, $n=2m$, $\lVert W\rVert_F=1$, $m\ge2$, $\mathring W$ has exactly three values $mA$, $-(m-1)A$, $-2m(m-1)A$ with multiplicities $(m-1)(m+2)$, $m^2$, $1$ | A, E | CONFIRMED |
| C2 | $R=G^{(1)}+G^{(2)}$ is the curvature of the unit product and $c=(m-1)/(2m-1)$ makes $W=R-cG$ trace-free | B | CONFIRMED |
| C3 | $\mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-ch$ on $S^2_0$, in Passage G's $iklj$ order | B | CONFIRMED |
| C4 | Three $O(m)\times O(m)$-invariant summands with eigenvalue ratio $m:-(m-1):-2m(m-1)$ | B | CONFIRMED (under the reading the ratio forces, see W1) |
| C5 | Passage D's route: Li Theorem 1.8, then subtraction of the Einstein part | D | CONFIRMED (Li's Example 2.1 is used and uncited) |
| C6 | $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)>0$ in the $iklj$ order, fixed by $\lVert W\rVert_F=1$ | C, D, E | CONFIRMED |
| C7 | The hypothesis $m\ge2$, and $m=1$ | A, E | CONFIRMED (E omits $m\ge2$, and E is vacuous at $m=1$) |
| C8 | $p_3(\mu)=A$ and $p_3(\omega)=-(4m^2-6m-1)A$ | D | CONFIRMED AS ALGEBRA |
| C9 | $A$ equals $2\sqrt2/\big(n\sqrt{(n-1)(n-2)}\big)$ at $n=2m$ | D | CONFIRMED AS ALGEBRA |
| C10 | $\sqrt{4m^4-12m^3+13m^2-6m+1}=2m^2-3m+1$ | D | CONFIRMED AS ALGEBRA |
| C11 | $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\theta_0(2m)$ identically in $m$ | D, E | HYPOTHESIS-DEBT |
| C12 | "$p_3(\mu)$ is worth $2.7\%$ at $m=6$" | E | CONFIRMED AS ALGEBRA |
| C13 | "the unbalanced products have a fourth value" | E | HYPOTHESIS-DEBT |
| C14 | Corroboration: $0.210818511$ at $S^3\times S^3$ "is this lemma's $B$-block value to nine digits" | B | HYPOTHESIS-DEBT |
| C15 | The Lean file states a fragment of L67 (the tabulated list), and does not state the lemma | H | CONFIRMED |

**Summary: L67 is PROVEN. Passage B's operator formula is correct in Li's $iklj$ convention and yields the three eigenspaces and $A$ by direct substitution. The side claims resting on $\theta_0$, on runs, and on unbalanced products are HYPOTHESIS-DEBT and none is used by the lemma.**

## 0. Conventions, fixed once

- $V=V_1\oplus V_2$, $\dim V_a=m$, $n=2m$, orthonormal basis adapted to the splitting. $P_a$ is the orthogonal projection onto $V_a$, so $P_1+P_2=g=I$ and $\mathop{\mathrm{tr}}P_a=m$.
- For a symmetric $P$ write $G^P_{ijkl}=P_{ik}P_{jl}-P_{il}P_{jk}$. Then $G^{(a)}=G^{P_a}$, $G=G^I$, and $t_a=\mathop{\mathrm{tr}}(P_ah)$. **None of these symbols is defined in the passages** (brief item 2). This is the reading under which Passage B's displayed operator formula holds, and §3 shows the formula pins it.
- **Index order.** $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$ (Passage G). Li 2022 uses the same order: the introduction's form $\mathring R(\varphi,\psi)=R_{ijkl}\varphi_{il}\psi_{jk}$ equals $\langle\psi,X\rangle$ with $X_{jk}=\sum R_{ijkl}\varphi_{il}=\sum R_{jilk}\varphi_{il}$, which is the $iklj$ pattern, and the proof of Lemma 2.1 computes $\mathring R(\xi)(e_i,e_l)=\sum R(e_i,e_j,e_k,e_l)\xi(e_j,e_k)$, the same pattern. The display at the head of Li's §2, $\mathring R(\varphi)_{ij}=\sum R_{ijkl}\varphi_{kl}$, vanishes on every symmetric $\varphi$ by antisymmetry in $(k,l)$, so it is a misprint and the computations are what the theorem proves (W5).
- **Tensor sign.** Li's convention is $R_{ijij}=$ sectional curvature, pinned by two identities Li states: Example 2.1, $\mathring R=\kappa\,\mathrm{id}_{S^2_0}$ on $\mathbb S^n(\kappa)$, and Lemma 2.3's $\mathring R_i(g_i)=-\mathrm{Ric}(R_i)$. Derivation for $G$: $(\mathring Gh)_{ij}=\sum_{k,l}(\delta_{ik}\delta_{lj}-\delta_{ij}\delta_{kl})h_{kl}=h_{ij}-\delta_{ij}\mathop{\mathrm{tr}}h$. So $\mathring G=\mathrm{id}$ on $S^2_0$ and $\mathring G(g)=-(n-1)g=-\mathrm{Ric}(G)$, with $\mathrm{Ric}_{kl}=\sum_iG_{ikil}=(n-1)\delta_{kl}$. Both identities hold, so $G$ is the unit-sphere curvature in Li's sign. The opposite tensor sign gives $\mathring G=-\mathrm{id}$ and contradicts Example 2.1.
- **$\Lambda^2$ normalisation.** $M_{(ab),(cd)}=W_{abcd}$ for $a<b$, $c<d$, so $\sum\mu^2=\lVert M\rVert_F^2=\tfrac14|W|^2$ with $|W|^2=\sum_{ijkl}W_{ijkl}^2$. This is the convention the Lean file states ($|W|^2=4\lVert M\rVert_F^2$). It is positive on the round sphere.
- **The trace identity linking the two normalisations**, derived for every algebraic Weyl tensor $W$. Let $T$ act on all $n\times n$ matrices by $(TX)_{ij}=\sum W_{iklj}X_{kl}$.
  1. $T$ is self-adjoint for the Frobenius product: $T_{(kl)(ij)}=W_{kijl}=-W_{ikjl}=W_{iklj}=T_{(ij)(kl)}$.
  2. $\mathop{\mathrm{tr}}T^2=\sum W_{iklj}W_{kijl}=-\sum W_{iklj}W_{ikjl}=\sum W_{ikjl}^2=|W|^2$.
  3. $T$ commutes with transposition: $(TX^{\mathsf T})_{ij}=\sum W_{ilkj}X_{kl}=\sum W_{jkli}X_{kl}=(TX)_{ji}$. So $T$ preserves $S^2$ and $\Lambda^2$.
  4. On $\Lambda^2$: the Bianchi identity $W_{iklj}+W_{iljk}+W_{ijkl}=0$ and $W_{ilkj}=-W_{iljk}$ give $(TX)_{ij}=\tfrac12\sum(W_{iklj}-W_{ilkj})X_{kl}=-\tfrac12\sum W_{ijkl}X_{kl}$. In the orthonormal basis $E_{(cd)}=(e_ce_d^{\mathsf T}-e_de_c^{\mathsf T})/\sqrt2$ the map $X\mapsto\tfrac12\sum W_{ijkl}X_{kl}$ has entries $W_{abcd}$, so $T|_{\Lambda^2}=-M$ and $\mathop{\mathrm{tr}}(T|_{\Lambda^2})^2=\tfrac14|W|^2$.
  5. On $S^2$: $T(g)_{ij}=\sum_kW_{ikkj}=-\mathrm{Ric}(W)_{ij}=0$, and $\mathop{\mathrm{tr}}(TX)=\sum W_{ikli}X_{kl}=-\sum\mathrm{Ric}(W)_{kl}X_{kl}=0$, so $T$ maps $S^2_0$ into itself and Li's projection $\pi$ acts trivially.
  6. Hence $\sum\omega^2=\mathop{\mathrm{tr}}_{S^2_0}T^2=|W|^2-\tfrac14|W|^2=\tfrac34|W|^2=3\sum\mu^2$.
  So $\lVert W\rVert_F=1$ is the same condition as $\sum\omega^2=3$.

## 1. Hypothesis inventory

| Hypothesis | Where stated | Used by | Satisfiable |
|---|---|---|---|
| The manifold is $S^m\times S^m$, $n=2m$ | A, E | all | yes |
| Radii: unit and equal | B only, through $R=G^{(1)}+G^{(2)}$ | B, D (Einstein) | yes. The statement is silent, and the normalised spectrum is radius-independent (W4) |
| $\lVert W\rVert_F=1$ | A, E | the value of $A$ | iff $W\ne0$, iff $m\ge2$ (§7) |
| $m\ge2$ | A only | $A$ finite, three nonzero multiplicities, Li Example 2.1 on the factors | yes, witness $m=2$ |
| Index order $iklj$ | G, C | sign of $A$ | yes |
| Tensor sign $R_{ijij}=\sec$ | unstated in the passages, carried by "the record's convention is Li's" (G) | sign of $A$ | yes |
| $\Lambda^2$ matrix $M=W_{abcd}$ | Lean file only | the meaning of $\lVert W\rVert_F$ | yes |
| Li Thm 1.8: $(M_i,g_i)$ Einstein, $\mathrm{Ric}=\rho_ig_i$, $n_i\ge1$ | filed, read at source | D | round $S^m$ is Einstein with $\rho=m-1$, $n_i=m\ge1$ |
| Li Example 2.1: $\mathbb S^n(\kappa)$, $n\ge2$, $\kappa>0$, $\mathring R=\kappa\,\mathrm{id}$ | filed, read at source, **uncited by D** | D (factor spectra at $n=m$, and $\mathring G=\mathrm{id}$ at $n=2m$) | needs $m\ge2$ on the factors |
| $\sum\omega^2=3\sum\mu^2$ for Weyl tensors | "the normalisation the identity requires" (D), Lean comment | D's route to $A$ | derived in §0, unfiled in the brief |
| Lemma L50 and $\theta_0$ | E | C11 only | L50 carries two owed links (Passage F), and $\theta_0$ is undefined in the brief |
| Runs (run_li_thm18_check.py, run_maximiser_closed_form.py) | D | cited as checks | not evidence here |

No hypothesis is used and unstated except the tensor sign (carried by Passage G's adoption of Li's convention) and Li's Example 2.1 (filed, uncited). The radius hypothesis is unstated and unneeded.

## 2. C2: the curvature, and the constant $c$

- $R=G^{(1)}+G^{(2)}$ is Li's $R_1\oplus R_2$ of (2.2)–(2.3) with $R_a=G^{P_a}$ the unit-sphere curvature on $V_a$ (§0 sign). So it is the curvature of the unit $S^m\times S^m$.
- $\mathrm{Ric}(G^{P_a})_{kl}=\sum_i\big((P_a)_{ii}(P_a)_{kl}-(P_a)_{il}(P_a)_{ki}\big)=m(P_a)_{kl}-(P_a)_{kl}=(m-1)(P_a)_{kl}$. So $\mathrm{Ric}(R)=(m-1)g$, Einstein with $\rho=m-1$ and scalar curvature $2m(m-1)$.
- $\mathrm{Ric}(G)=(2m-1)g$, so $\mathrm{Ric}(R-cG)=\big((m-1)-c(2m-1)\big)g=0$ iff $c=(m-1)/(2m-1)$.
- $R-W=cG=\tfrac c2\,g\owedge g$ is pure trace, so $W$ is the Weyl part of $R$, consistent with $\mathop{\mathrm{scal}}/\big(n(n-1)\big)=2m(m-1)/\big(2m(2m-1)\big)=c$.

CONFIRMED.

## 3. C3: the operator formula

- $G^{(a)}_{iklj}=(P_a)_{ik}(P_a)_{lj}-(P_a)_{ij}(P_a)_{kl}$, so $\sum_{k,l}G^{(a)}_{iklj}h_{kl}=(P_ahP_a)_{ij}-t_a(P_a)_{ij}$.
- $\mathring Gh=h-(\mathop{\mathrm{tr}}h)g$ (§0).
- Sum: $\mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-ch+c(\mathop{\mathrm{tr}}h)g$. On $S^2_0$ the last term is $0$, which is Passage B's formula.
- Restriction to $S^2_0$: $\mathop{\mathrm{tr}}(\mathring Wh)=t_1+t_2-mt_1-mt_2=(1-m)\mathop{\mathrm{tr}}h=0$, so the output is trace-free and no projection is needed.
- The formula pins the conventions: the within-factor coefficient $+1$ on $P_ahP_a$ is the $iklj$ order with $R_{ijij}=\sec$. Either reversal negates the $G^{(a)}$ terms.

CONFIRMED.

## 4. C4 and C1: the eigenspaces, eigenvalues and multiplicities

Evaluate the formula of §3 on three subspaces.

- $U_1=S^2_0(V_1)\oplus S^2_0(V_2)$, i.e. $h=P_1hP_1+P_2hP_2$ with $t_1=t_2=0$. Then $\mathring Wh=(1-c)h=\dfrac m{2m-1}h$. $\dim U_1=2\big(\tfrac{m(m+1)}2-1\big)=m^2+m-2=(m-1)(m+2)$.
- $U_2$, the cross block, $h=P_1hP_2+P_2hP_1$. Then $P_ahP_a=0$ and $t_a=0$, so $\mathring Wh=-ch=-\dfrac{m-1}{2m-1}h$. $\dim U_2=m^2$.
- $U_3=\mathbb R\zeta$, $\zeta=P_1-P_2$ (trace-free). $P_1\zeta P_1=P_1$, $P_2\zeta P_2=-P_2$, $t_1=m$, $t_2=-m$. So $\mathring W\zeta=(1-m-c)\zeta=-(m-1)\dfrac{2m}{2m-1}\zeta$. $\dim U_3=1$.
- **They exhaust $S^2_0$.** A block-diagonal trace-free $h=h_1+h_2$ decomposes as $h_a=h_a^0+\tfrac{t_a}mP_a$ with $t_1+t_2=0$, so its pure part is $\tfrac{t_1}m\zeta$. Hence $U_1\oplus U_3$ is the block-diagonal trace-free space, and adding $U_2$ gives $S^2_0$: $(m-1)(m+2)+m^2+1=2m^2+m-1=\binom{2m+1}2-1$.
- Each $U_i$ is $O(m)\times O(m)$-invariant.
- **Normalisation.** For $\lambda>0$ the operator of $\lambda W$ has eigenvalues $\lambda m/(2m-1)$, $-\lambda(m-1)/(2m-1)$, $-2\lambda m(m-1)/(2m-1)$. With $A=\lambda/(2m-1)$ these are $mA$, $-(m-1)A$, $-2m(m-1)A$ on $U_1$, $U_2$, $U_3$. The ratio is $m:-(m-1):-2m(m-1)$ and the multiplicities are $(m-1)(m+2)$, $m^2$, $1$, in the order the statement assigns.
- **Exactly three distinct values at $m\ge2$.** With $A>0$ (§6): $mA>0>-(m-1)A$, and $-(m-1)A-(-2m(m-1)A)=(m-1)(2m-1)A>0$.

C4 CONFIRMED under the reading W1 records. C1 CONFIRMED once $A$ is fixed (§6).

## 5. C5: Passage D's route through Li's Theorem 1.8

- **At source** ([li-2209.02119.txt](https://arxiv.org/abs/2209.02119) lines 241–249 and §2): the eigenvalues of $\mathring R$ on $M_1\times M_2$ are those of $\mathring R_1$, $\mathring R_2$, $0$ with multiplicity $n_1n_2$, and $-\frac{n_1\rho_2+n_2\rho_1}{n_1+n_2}$ with multiplicity one. The proof of Proposition 2.1 exhibits the eigenbasis $\{\varphi_p\}\cup\{\psi_q\}\cup\{\xi_{pq}\}\cup\{\zeta\}$ with $\zeta\propto n_2g_1-n_1g_2$, which is $U_1$, $U_2$, $U_3$ of §4.
- **Hypotheses against the factors.** $S^m$ round is Einstein with $\rho=m-1$ and $n_i=m\ge1$. The theorem is pointwise (Li: "our approach is of pointwise nature") through Proposition 2.1.
- **Factor spectra.** Theorem 1.8 needs $\mathring R_a$. That is Li's Example 2.1 at $n=m\ge2$, $\kappa=1$: the value $1$ on $S^2_0(V_a)$. D does not cite it.
- **Spectrum of $\mathring R$.** $1$ with multiplicity $(m-1)(m+2)$, $0$ with multiplicity $m^2$, and $-\frac{m(m-1)+m(m-1)}{2m}=-(m-1)$ with multiplicity $1$.
- **"Subtracting the Einstein part".** $W=R-cG$ and $\mathring G=\mathrm{id}$ on $S^2_0$ (Example 2.1 at $n=2m$, or §0), so $\mathring W=\mathring R-c\,\mathrm{id}$ on the same eigenvectors. This gives $1-c=\frac m{2m-1}$, $-c$, and $-(m-1)-c=-\frac{2m(m-1)}{2m-1}$, agreeing with §4.
- The step is valid, and the fact it rests on ($\mathring G=\mathrm{id}$ on $S^2_0$) is unstated in D. It is filed as Li's Example 2.1.

CONFIRMED. Brief item 1: Passage D establishes the spectrum through two filed Li results (one uncited). Passage B establishes it independently through the formula of §3, importing nothing but the $iklj$ convention.

## 6. C6: the constant $A$ and its sign

**By $\sum\mu^2=1$.**

- On $\Lambda^2$, $M^{G^{(a)}}_{(ab)(cd)}=(P_a)_{ac}(P_a)_{bd}-(P_a)_{ad}(P_a)_{bc}$. This is the identity on $\Lambda^2V_a$ and $0$ on every other basis 2-form. $M^G$ is the identity.
- So $W=R-cG$ has $\mu=1-c=\frac m{2m-1}$ with multiplicity $2\binom m2=m(m-1)$, and $\mu=-c$ with multiplicity $m^2$ (the mixed 2-forms).
- $\sum\mu^2=\dfrac{m(m-1)m^2+m^2(m-1)^2}{(2m-1)^2}=\dfrac{m^2(m-1)}{2m-1}$.
- For $\lambda W$, $\lambda^2m^2(m-1)/(2m-1)=1$. So $A^2=\lambda^2/(2m-1)^2=1/\big(m^2(m-1)(2m-1)\big)$.

**By $\sum\omega^2=3$.**

- $\sum\omega^2=A^2\big[(m-1)(m+2)m^2+m^2(m-1)^2+4m^2(m-1)^2\big]=A^2m^2(m-1)(6m-3)=3A^2m^2(m-1)(2m-1)$.
- Setting this to $3$ returns the same $A^2$.
- The unscaled sums stand in ratio $3m^2(m-1)/(2m-1):m^2(m-1)/(2m-1)=3$, which is the identity of §0 read on this tensor, a derived cross-check.

**Which fixes it.** Both do, and they are one condition, since $\sum\omega^2=3\sum\mu^2$ for every Weyl tensor (W3). The stated hypothesis is $\lVert W\rVert_F=1$, i.e. $\sum\mu^2=1$, and $\sum\omega^2=3$ is its image under §0.

**Sign.**

- The normalisation fixes $A^2$ only, as Passage C says. Normalising means $\lambda=1/\lVert W\rVert_F>0$, so $A=\lambda/(2m-1)>0$ in the convention of §0.
- Under $ikjl$, $\mathring W$ is negated. The table then holds with $A<0$, or equivalently with the bottom value becoming $2m(m-1)|A|$ at the top.
- So "the bottom eigenvalue is $-2m(m-1)A$" is correct exactly in the $iklj$ order with Li's tensor sign.

**Passage E.** The landscape line's "with $A$ the normalising constant" and the detail's "the constant fixed by the normalisation" fix only $A^2$. The detail's later sentence states $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$ in the $iklj$ order, which fixes the sign. So E states $A$, and E's first clause alone does not.

CONFIRMED. The written record displays neither the $\Lambda^2$ spectrum nor the conversion of §0, so "confirmed two independent ways" names checks whose arithmetic is not on file. Both are verified above.

## 7. C7: $m\ge2$, the edges, the kernel, the crossover

- **$m=1$.** $S^1\times S^1$ is flat ($G^{P_a}=0$ on a line), so $W=0$, and $\mathcal W_2=\{0\}$ in any case. $\lVert W\rVert_F=1$ is unsatisfiable, the radicand $(m-1)(2m-1)$ is $0$, and the first multiplicity is $0$. The unscaled $\sum\mu^2=m^2(m-1)/(2m-1)$ vanishes exactly at $m=1$. Passage A carries $m\ge2$. Passage E omits it, and E is vacuous at $m=1$ because its normalisation cannot be met, so E is true there.
- **$m=2$** ($S^2\times S^2$, $n=4$). Multiplicities $4,4,1$ sum to $9=\dim S^2_0(\mathbb R^4)$. $A=1/(2\sqrt3)$, values $1/\sqrt3$, $-1/(2\sqrt3)$, $-2/\sqrt3$. $\sum\omega=4\cdot2A-4A-4A=0$ and $\sum\omega^2=A^2(16+4+16)=36/12=3$. Li's Example 2.1 on the factors needs $n=2$, which it allows.
- **Kernel.** For $m\ge2$, $\mathring W$ on $S^2_0$ is injective (three nonzero values). Li's kernel $E$ of $\mathring R$ (Lemma 2.1) is $U_2$, which becomes the $-(m-1)A$ eigenspace after the shift. On all of $S^2$, $T(g)=0$ (§0), and that line lies outside $S^2_0$.
- **Crossover $n=6+2\sqrt7$.** It bears on nothing here. At $m=3+\sqrt7$: $4m^2-6m-1=64+24\sqrt7-18-6\sqrt7-1=45+18\sqrt7\ne0$, and $(m-1)(2m-1)$, $2m^2-3m+1$ are positive. The only sign change among the passages' expressions, $4m^2-6m-1=0$, sits at $m=(3+\sqrt{13})/4<2$, so $p_3(\omega)<0$ throughout $m\ge2$.

CONFIRMED.

## 8. C8, C9, C10, C12: the further closed forms

- **C8.** $p_3(\mu)=\lambda^3\dfrac{m(m-1)m^3-m^2(m-1)^3}{(2m-1)^3}=\lambda^3\dfrac{m^2(m-1)(2m-1)}{(2m-1)^3}=A^3m^2(m-1)(2m-1)=A$, using $A^2m^2(m-1)(2m-1)=1$.
- **C8, continued.** $p_3(\omega)=A^3m^2(m-1)\big[m(m+2)-(m-1)^2-8m(m-1)^2\big]=A^3m^2(m-1)(-8m^3+16m^2-4m-1)$. Since $(2m-1)(4m^2-6m-1)=8m^3-16m^2+4m+1$, this is $-(4m^2-6m-1)A$. The same computation gives $\sum\omega=A\,m(m-1)\big[(m+2)-m-2\big]=0$. Both formulas use the $\Lambda^2$ spectrum of §6 and the convention $M=W_{abcd}$, neither displayed in the passages.
- **C9.** At $n=2m$: $\dfrac{2\sqrt2}{2m\sqrt{(2m-1)(2m-2)}}=\dfrac{2\sqrt2}{2m\sqrt2\sqrt{(2m-1)(m-1)}}=A$. "$\mathop{\mathrm{tr}}(W^3)$" is not defined in the passages. If it denotes $p_3(\mu)$, the equality is C8's.
- **C10.** $(2m^2-3m+1)^2=4m^4-12m^3+13m^2-6m+1$, and $2m^2-3m+1=(2m-1)(m-1)\ge0$ for $m\ge1$, so it is the principal root.
- **C12.** From C8, $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=\tfrac A2\big(3+4m^2-6m-1\big)=A(m-1)(2m-1)=\sqrt{(m-1)(2m-1)}/m$. The share of the $\tfrac32p_3(\mu)$ term is $\dfrac{3/2}{(m-1)(2m-1)}$, which is $3/110$ at $m=6$. Since $2.97<3<3.003$, $2.7\%<3/110<2.73\%$, so "$2.7\%$" is $3/110$ rounded. The other reading, $p_3(\mu)$ against the sum, gives $1/55$, which lies between $1.8\%$ and $1.82\%$. The quoted figure matches the weighted reading only.

## 9. C11: the closure $\theta=\theta_0(2m)$

- The sum is $\sqrt{(m-1)(2m-1)}/m$ exactly (§8).
- $\theta_0$ is not defined in any passage. The claim that $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ is L50, whose canonical entry records two owed links (Passage F). The only support D cites for "identically in $m$" is the run run_maximiser_closed_form.py.
- **HYPOTHESIS-DEBT.** What would have to be proved: $\theta_0(2m)=\sqrt{(m-1)(2m-1)}/m$ from $\theta_0$'s definition, with L50's owed links closed. L67's spectrum does not use this claim.

## 10. C13: "the unbalanced products have a fourth value"

- No argument is on file in the passages.
- **HYPOTHESIS-DEBT.** What would have to be proved: for $S^{n_1}\times S^{n_2}$ with $n_1\ne n_2$, in a stated scaling, the normalised $\mathring W$ has four distinct eigenvalues. The lemma does not use it.

## 11. C14: the corroboration $0.210818511$

- Located at [nondegeneracy.md:177](../findings/nondegeneracy.md#L177): "the smallest nonzero modulus at $S^3\times S^3$ is $0.210818511$". The sentence concerns the spectral gap of $W$ on $\Lambda^2$, so the numeral is a $\Lambda^2$ modulus.
- At $m=3$, $A=1/(3\sqrt{10})$. The $\Lambda^2$ values of §6 are $mA=\sqrt{10}/10$ and $-(m-1)A=-\sqrt{10}/15$, so the smallest modulus is $\sqrt{10}/15$. The $S^2_0$ cross-block value $U_2$ is $-(m-1)A=-\sqrt{10}/15$ too, because both equal $-\lambda c$.
- The coincidence therefore tests $|A|$ at $m=3$ through a different operator. It tests neither the $S^2_0$ splitting nor the sign. "$B$-block" is undefined in the passages.
- **HYPOTHESIS-DEBT.** The claim that the decimal agrees with $\sqrt{10}/15$ to nine digits is numerical and is not checked here. The lemma does not use it.

## 12. C15: the Lean file

- [L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean) types `Aconst`, `spec` and `mult` as real functions of $m$ and proves positivity of $A$, $A^2$, the multiplicity sum, the trace, $\sum\omega^2=3$, strict ordering, positivity of multiplicities, the $m=1$ remarks and an $m=2$ witness.
- It does not type $\mathring W$, $S^2_0$, the product $S^m\times S^m$ or its Weyl tensor. Its own text says so ("the theorem below is about the tabulated spectrum as a list of values with multiplicities, and not about W̊"). So it states arithmetic consequences of the table and does not state L67, as it claims.
- Every typed statement agrees with §4, §6 and §7 by reading. The file was not built.
- Wording notes, none a finding:
  - The multiplicity identity "holds vacuously at $m=1$" holds genuinely ($0+1+1=2$).
  - `spec_trace_zero`'s "the block never uses" sits beside D's written $\sum\omega=0$.
  - "$\sum\mu^2=1$ is a different sum over a different space" is true, and the two conditions are equivalent by §0.
  - `Aconst 1 = 0` is Lean's $1/0=0$, the file's point being that $A$ is undefined there.

## 13. The standing list

1. **Hypothesis inventory:** §1. Nothing used is unsatisfiable at $m\ge2$. The tensor sign and Li's Example 2.1 are used without being stated or cited.
2. **Quantifier order and scope:** for each fixed integer $m\ge2$, with $\lVert W\rVert_F$ read as $\sum\mu^2=\tfrac14|W|^2$ ($M=W_{abcd}$) and the index order $iklj$ with $R_{ijij}=\sec$. No finding: $A$ depends on $m$ only, and every passage uses this order and normalisation consistently.
3. **Edges:** §7. No finding: $m=1$ is vacuous, $m=2$ checks exactly, the kernel is trivial on $S^2_0$, and the crossover bears on nothing.
4. **Gap between proven and stated or used.** No finding against the lemma. Recorded:
   - E omits $m\ge2$ (vacuous).
   - E's first clause fixes only $A^2$, and its later sentence fixes the sign.
   - D's heading "Proved symbolically in $m$" sits over checks that cite runs.
   - D uses Example 2.1 uncited.
   - B's symbols are undefined.
   - C11, C13 and C14 are debts outside the lemma.
5. **Lean:** §12. It states a fragment and proves that fragment.
6. **Brief items:**
   1. §5: both B and D establish the spectrum. B imports only the convention, and D imports Li Theorem 1.8 and Example 2.1.
   2. §0 and §2: the symbols are undefined, the reading of §0 makes $R$ the unit product's curvature, and $c$ is correct.
   3. §3: correct in Passage G's convention, with trace-free output.
   4. §4 and W1.
   5. §5.
   6. §6 and W3.
   7. §7.
   8. §8 to §10: C8, C9, C10 and C12 hold as algebra, C11 and C13 are debts, and the lemma uses none of them.
   9. §11.
   10. §12.
   11. §7, and §6 on $ikjl$ against $iklj$.
7. **Falsifiers sought:**
   - C1, C4: an eigenvector outside $U_1\oplus U_2\oplus U_3$, excluded by the dimension count of §4.
   - C3: an $h$ on which the formula fails, excluded by the entrywise derivation.
   - C6: a convention satisfying Passage G with $A<0$, examined as W2.
   - C7: a satisfiable normalisation at $m=1$, excluded since $W=0$.
   - C8 to C10, C12: a value of $m$ breaking a polynomial identity, excluded since each holds as a polynomial or rational identity.
   - C1, literal statement: unequal radii, examined as W4.
   - C11: a definition of $\theta_0$ disagreeing with $\sqrt{(m-1)(2m-1)}/m$, not on file.
   - C13: an unbalanced product with three values, not sought (debt).
   - C14: the decimal against $\sqrt{10}/15$, not evaluated (numerical).

### Withdrawn candidates

- **W1. B's parenthetical names the wrong summands.**
  1. Location: line 507, "splits $S^2_0$ into three $O(m)\times O(m)$-invariant summands (the two within-factor trace-free parts and the cross block)".
  2. Failure under the natural reading. $S^2_0(V_1)$, $S^2_0(V_2)$ and the cross block have dimensions summing to $2m^2+m-2=\dim S^2_0-1$. Their eigenvalues (§4) are $m$, $m$, $-(m-1)$ times $1/(2m-1)$, which is two distinct values, and $\zeta=P_1-P_2$ with $-2m(m-1)$ is omitted.
  3. Charitable reading. The block-diagonal trace-free space has two invariant parts, $U_1$ and $\mathbb R(P_1-P_2)$, both literally within-factor and trace-free. With the cross block they give the three summands and exactly the stated ratio, and the sentence's own three-value ratio forces this reading.
  - **Withdrawn.** Residue: B assigns no eigenvalue or multiplicity to any named summand, the identification B says the earlier locator lacked. Li's Proposition 2.1 at source supplies it through D.
- **W2. The sign of $A$ also depends on the tensor sign, not only on the index order.**
  1. Location: line 511, "the two signs are the two index orders".
  2. Failure: with $R_{ijji}=\sec$ and $iklj$, $\mathring G=-\mathrm{id}$ on $S^2_0$, every value negates, and $A<0$.
  3. Charitable reading: Passage G adopts Li's convention, and Li's Example 2.1 and Lemma 2.3 pin $R_{ijij}=\sec$ (§0). Within that convention the index order is the only remaining sign.
  - **Withdrawn.**
- **W3. "confirmed two independent ways" are not independent.**
  1. Location: line 513.
  2. Failure: $\sum\omega^2=3\sum\mu^2$ for every algebraic Weyl tensor (§0), so they are one condition.
  3. Charitable reading: two separate computations over two different spectra, each able to catch an arithmetic error in its own table.
  - **Withdrawn**, recorded as a note in §6.
- **W4. Unequal radii falsify the literal statement.**
  1. Location: E, "Let $W$ be the Weyl tensor of $S^m\times S^m$", with no radii given, while B's proof assumes unit radii.
  2. Attempted failure: $S^m(\kappa_1)\times S^m(\kappa_2)$ with $\kappa_1\ne\kappa_2$ is not Einstein, so B and D do not apply. No failure can be exhibited, because $G^{P_a}=\tfrac12P_a\owedge P_a$ and $P_a\owedge g=P_a\owedge P_a+P_1\owedge P_2$ is pure trace. So the Weyl parts satisfy $W(P_1\owedge P_1)=W(P_2\owedge P_2)=-W(P_1\owedge P_2)$, and $W(\kappa_1G^{(1)}+\kappa_2G^{(2)})=\tfrac{\kappa_1+\kappa_2}2W(G^{(1)}+G^{(2)})$, a positive multiple for $\kappa_1,\kappa_2>0$. The normalised tensor is the unit-radius one.
  3. The charitable reading (unit round spheres) is anyway standard.
  - **Withdrawn.**
- **W5. Li's §2 display is in $ijkl$ order, against Passage G.**
  1. Location: [li-2209.02119.txt](https://arxiv.org/abs/2209.02119), "R̊(ϕ)ij = Σ Rijkl ϕkl".
  2. Failure: read literally, it annihilates every symmetric $\varphi$.
  3. Charitable reading: it is a misprint, since Li's introduction and every computation in Lemmas 2.1–2.3 use the $iklj$ pattern (§0).
  - **Withdrawn.** Theorem 1.8 holds in Passage G's convention.

## Overall verdict

**PROVEN.**

- The statement (Passages A and E) is true for every $m\ge2$, with $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)>0$ in the $iklj$ order and Li's tensor sign.
- Passage B's formula is correct, and it determines the eigenspaces $U_1$, $U_2$, $\mathbb R(P_1-P_2)$, with multiplicities $(m-1)(m+2)$, $m^2$, $1$.
- Passage D's route through Li's Theorem 1.8 at source is correct, with Example 2.1 as its uncited second input.
- Presentational defects, none blocking:
  - B's symbols are undefined.
  - B's summand naming is ambiguous (W1).
  - The normalisation arithmetic behind $A$ is unwritten.
  - E omits $m\ge2$ (vacuous).
- Outside the lemma: C11 (closure to $\theta_0$), C13 (fourth value) and C14 (decimal corroboration) are HYPOTHESIS-DEBT.
