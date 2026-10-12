# REVIEW r482, Lemma L67, the second-kind spectrum of the balanced product

**Verdict: CONFIRMED.** The spectrum, the multiplicities and the closed-form constant are all correct, recomputed here from the definition without using Li's Theorem 1.8. Four defects are in the *statement and its bookkeeping*, none in the mathematics.

Target: [bispectral.md](../findings/bispectral.md) `#### Lemma L67` (line 450); canonical statement at [results.md](../results.md) line 738; index row at [INDEX-results.md](../findings/INDEX-results.md) line 81, which records no Gate 2 verdict.

## The claim

At $S^m\times S^m$, $n=2m$, normalised to $\lVert W\rVert_F=1$, $\operatorname{spec}(\mathring W)$ is $mA$ at multiplicity $(m-1)(m+2)$, $-(m-1)A$ at $m^2$, $-2m(m-1)A$ at $1$, with $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)$ supplied by the earlier unlabelled section of the same file.

## 1. Multiplicities sum to the dimension, HOLDS

$(m-1)(m+2)+m^2+1=m^2+m-2+m^2+1=2m^2+m-1$, and $\dim S^2_0(\mathbb R^{2m})=\binom{2m+1}2-1=m(2m+1)-1=2m^2+m-1$. Equal identically in $m$.

The two moment conditions [Lemma L50](../findings/bispectral.md) requires also hold identically:

- $\sum\omega=A(m-1)\big[m(m+2)-m^2-2m\big]=0$.
- $\sum\omega^2=A^2m^2(m-1)\big[(m+2)+(m-1)+4(m-1)\big]=3A^2m^2(m-1)(2m-1)=3$, using $A^2=1/\big(m^2(m-1)(2m-1)\big)$.

## 2. Recomputed from the definition, HOLDS, and the derivation is short

I did not use Li's Theorem 1.8. Take the unit-radius product, so $R=G^{(1)}+G^{(2)}$ with $G^{(i)}_{ijkl}=g^i_{ik}g^i_{jl}-g^i_{il}g^i_{jk}$ built from the two projections $P_1,P_2$. The metric is Einstein with $\rho=m-1$, $S=2m(m-1)$, so

$$W=R-\tfrac{S}{n(n-1)}\,G,\qquad \tfrac{S}{n(n-1)}=\tfrac{2m(m-1)}{2m(2m-1)}=\tfrac{m-1}{2m-1}=:c .$$

In [conventions.md](../findings/conventions.md)'s settled Li order $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$ one gets $\mathring G=+\mathrm{Id}$ on $S^2_0$ (this is the same one-line check that anchors the order), and

$$\mathring{G^{(i)}}h=P_ihP_i-\operatorname{tr}(P_ih)\,P_i,\qquad\text{so}\qquad \mathring Wh=P_1hP_1+P_2hP_2-t_1P_1-t_2P_2-c\,h .$$

Writing $h=\begin{pmatrix}X&B\\B^{\mathsf T}&Y\end{pmatrix}$ with $\operatorname{tr}X+\operatorname{tr}Y=0$, the three invariant summands are read off directly:

| eigenspace | dimension | eigenvalue | normalised |
| --- | --- | --- | --- |
| $X=Y=0$, $B$ free | $m^2$ | $-c$ | $-(m-1)A$ |
| $X,Y$ traceless, $B=0$ | $2\big(\tfrac{m(m+1)}2-1\big)=(m-1)(m+2)$ | $1-c=\tfrac m{2m-1}$ | $mA$ |
| $X=sI,\;Y=-sI$ | $1$ | $1-m-c=\tfrac{-2m(m-1)}{2m-1}$ | $-2m(m-1)A$ |

The unnormalised ratios are exactly $m:-(m-1):-2m(m-1)$, all over $2m-1$. **Every eigenvalue and every multiplicity of L67 is reproduced.**

Li's Theorem 1.8 as quoted at [bispectral.md](../findings/bispectral.md) line 173 gives the same thing, $\operatorname{spec}(\mathring R_i)=\{1\}$ at $\tfrac{m(m+1)}2-1$ from Li Example 2.4, $0$ at $n_1n_2=m^2$, and $-\tfrac{n_1\rho_2+n_2\rho_1}{n_1+n_2}=-(m-1)$, so the lemma's stated route and the direct route agree.

## 3. Normalisation, HOLDS, and it is cross-checked on the $\Lambda^2$ side

The constant $A$ is pinned by $\sum\omega^2=3$, which [conventions.md](../findings/conventions.md) records as the second-kind reading of $\lVert\mathring W\rVert_F^2=3\lVert W\rVert^2_{\Lambda^2}$ at $\lVert M\rVert_F=1$. I checked the *other* side independently rather than taking that identity on trust. On $\Lambda^2$, $W=\Pi_1+\Pi_2-c\,\mathrm{Id}$, giving $1-c$ at multiplicity $m(m-1)$ and $-c$ at $m^2$, trace zero, and

$$\textstyle\sum\mu^2\big|_{\text{unnorm}}=\frac{m^2(m-1)}{2m-1}\ \Longrightarrow\ \text{scale }s=\frac{\sqrt{2m-1}}{m\sqrt{m-1}},$$

which is *exactly* the scale that $\sum\omega^2=3$ forces. The two normalisations agree identically in $m$, so no factor of $2$ or $\tfrac13$ is missing. And the $\tfrac12$-at-the-$\Lambda^2$-level convention is respected: putting it at the operator level would inflate the scale by $\sqrt2$ and break the agreement.

Third, independent corroboration from a file that never mentions L67: [nondegeneracy.md](../findings/nondegeneracy.md) line 178 records the smallest nonzero modulus at $S^3\times S^3$ as $0.210818511$. That is $c\,s$ at $m=3$, the value this lemma's own $B$-block carries, to nine digits.

**Downstream closure holds.** $p_3(\mu)=A$ and $p_3(\omega)=-(4m^2-6m-1)A$, so $\tfrac32p_3(\mu)-\tfrac12p_3(\omega)=A(2m-1)(m-1)=\frac{\sqrt{(m-1)(2m-1)}}m=\theta_0(2m)$, identically in $m$. Likewise $-\min\omega=2m(m-1)A=\frac{2\sqrt{m-1}}{\sqrt{2m-1}}=\frac n{n-1}\theta_0(n)$, so [bispectral.md](../findings/bispectral.md) line 199's use of the isolated bottom eigenvalue is inside the lemma and correct.

**Screen** (permitted under [analysis-only.md](../.claude/rules/analysis-only.md), reported as a screen and not as evidence): the product metric built by Kulkarni–Nomizu, Ricci-flatness and first Bianchi asserted, $\mathring W$ assembled in Li's order and restricted to $S^2_0$. At $m=2,\dots,7$ the full spectrum matches the claim to $7\times10^{-16}$, with $\sum\mu^2=1$, $\sum\omega^2=3$, $\theta=\theta_0(n)$ and $-\min\omega=\tfrac n{n-1}\theta_0(n)$ at every $m$.

## 4. Defect A, the canonical statement never defines $A$, and is ambiguous up to a global sign

[results.md](../results.md) line 740 says "where $A$ is the constant fixed by the normalisation"; [INDEX-results.md](../findings/INDEX-results.md) line 256's row says "with $A$ the normalising constant"; the [bispectral.md](../findings/bispectral.md) block at line 454 says neither. The closed form lives only in the earlier unlabelled section at line 183.

The normalisation fixes $A^2$, **not $A$**. Both $\sum\omega=0$ and $\sum\omega^2=3$ are satisfied by $-A$ as well, and the two sign choices are the two index orders, the one hazard [conventions.md](../findings/conventions.md) flags hardest for second-kind spectra ("Comparing a BK-order spectrum with a Li-order one without flipping the sign is the trap"). As recorded, the canonical statement does not say which side of that trap it is on, and a reader cannot conclude from it that the *bottom* of the spectrum is $-2m(m-1)A$, the very thing its only real consumer uses. **Fix: state $A=1/\big(m\sqrt{(m-1)(2m-1)}\big)>0$ in the block and in results.md.**

## 5. Defect B, results.md over-claims what L67 plus Lemma L50 gives

> "with Lemma L50 the spectrum returns $\theta=\theta_0(2m)$", [results.md](../results.md) line 745.

[Lemma L50](../findings/bispectral.md) is $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ and needs **both** cubic moments. L67 supplies $\omega$ alone, and L50's side conditions ($\sum\mu=0$, $\sum\mu^2=1$) do not determine $p_3(\mu)$. The $\Lambda^2$ spectrum is a separate input, present in [bispectral.md](../findings/bispectral.md) but absent from L67's statement. The contribution is not negligible bookkeeping either, at $m=6$, $\tfrac32p_3(\mu)=0.0337$ against $\theta_0(12)=1.2360$, so without it the identity misses by $2.7\%$ rather than closing. **Fix: either name the $\Lambda^2$ spectrum as a second input, or fold $\mu=\{(1-c)^{m(m-1)},(-c)^{m^2}\}$ into the lemma, which the same computation delivers for free.**

## 6. Defect C, the block contains no argument, and its pointer is inaccurate

The block reads "*The argument is the surrounding material in this file*". Nothing surrounds it: the material is at lines 169–193, some $260$ lines earlier, behind two intervening Post F26 sections, and the pointer names no heading. This is the pattern the brief warns about, in its milder form, the block is headed as a lemma and carries a locator instead of a proof.

Worse, the pointed-to material is not a derivation. Its whole specialisation step is one clause, "Specialising to the balanced $S^m\times S^m$ at $n=2m$ and subtracting the Einstein part to reach the Weyl tensor, the $\omega$-spectrum is three values", followed by the table. It states neither $c$, nor $\operatorname{spec}(\mathring R_{S^m})$, nor which eigenspace carries which multiplicity; what stands beside it is a numerical verification of Li's Theorem 1.8 to $1.8\times10^{-15}$, which is a check of the *input*, not of the specialisation.

**This is a shallow gap, not a hole.** Every input is already on the record, Li's Theorem 1.8 quoted at line 173, Li Example 2.4 quoted in [conventions.md](../findings/conventions.md), and §2 above closes it in three lines. **Fix: put those three lines in the block.**

## 7. Defect D, the missing hypothesis $m\ge2$

$A$ divides by $\sqrt{m-1}$. At $m=1$ the manifold is the flat torus, $W=0$, and there is no unit normalisation at all. The multiplicity identity $(m-1)(m+2)+m^2+1=2m^2+m-1$ is a polynomial identity in $m$ and so **holds vacuously at $m=1$**, which is exactly why the multiplicity check alone cannot supply the hypothesis. $m=2$ is genuine: $n=4$, $A=1/(2\sqrt3)$, multiplicities $4,4,1$ summing to $\dim S^2_0(\mathbb R^4)=9$.

## 8. Two clauses that survive, one against my own suspicion

- **"the unbalanced products have a fourth value"** ([results.md](../results.md) line 745), **holds**, and more broadly than Li's hypothesis. For an Einstein $S^{m_1}(r_1)\times S^{m_2}(r_2)$ the same computation gives $-c$, $k_1-c$, $k_2-c$, $-\rho-c$, and these are pairwise distinct whenever $m_1\ne m_2$ (Einstein forces $(m_1-1)k_1=(m_2-1)k_2$, hence $k_1\ne k_2$, and forces $m_i\ge2$). Screened at $S^2\times S^4$ and $S^3\times S^5$ (Einstein) and at unit $S^3\times S^4$ (**not** Einstein, so outside Li's theorem): four distinct values in every case.
- **An equal-radii hypothesis is NOT needed.** I suspected one ($S^m(r_1)\times S^m(r_2)$ with $r_1\ne r_2$ is not Einstein, so Li's theorem does not reach it) and screened it: the normalised second-kind spectrum at radius ratio $2$ is identical to the equal-radius one to eight digits. The Weyl part of $G^{(1)}-G^{(2)}$ vanishes when the factors have equal dimension. **My suspicion was wrong and is recorded as withdrawn.**

## 9. Citers, and a notation hazard beside the lemma

Everything citing L67 is inside its hypotheses.

| citer | what it takes | inside? |
| --- | --- | --- |
| [bispectral.md](../findings/bispectral.md) line 197 | the isolated bottom eigenvalue, to prove $-\min\omega=\tfrac n{n-1}\theta_0(n)$ | yes, verified exact above |
| [results.md](../results.md) line 50 | the Li 2022 attribution | yes |
| [results.md](../results.md) line 745 | $\theta$ via L50 | see Defect B |
| [plan-verification.md](../plan-verification.md) line 86 | unchecked row |, |

**No competing copy of this spectrum exists.** [Lemma L133](../findings/second-order.md) records a balanced-orbit *Hessian* threshold and [Lemma L27](../findings/nondegeneracy.md) the $L_e$ spectrum at $S^p\times S^q$, different operators on different spaces, so there is nothing for L67 to disagree with. Searching by quantity rather than identifier turned up one number in common, [nondegeneracy.md](../findings/nondegeneracy.md)'s $0.210818511$, and it **agrees** (§3).

**Hazard, adjacent and live.** Within thirty lines [bispectral.md](../findings/bispectral.md) uses $\mu$ for two objects: $p_3(\mu)$ at line 185 is [conventions.md](../findings/conventions.md)'s $\Lambda^2$ spectrum, while line 199 sets $\mu:=-\min\omega$, a scalar off the *second-kind* spectrum, the convention [target.md](../findings/target.md) then carries throughout. L67's chief consumer is that line. This belongs in [conventions.md](../findings/conventions.md) under "The words with more than one meaning".

## Verdict

**CONFIRMED**, under the hypotheses: $m\ge2$; the round product metric, either factor radius; the second-kind operator in [conventions.md](../findings/conventions.md)'s settled Li $iklj$ order; and $\lVert W\rVert_F=1$ read as $\lVert M\rVert_F=1$ on $\Lambda^2$, equivalently $\sum\omega^2=3$.

**The label it deserves: *proved, statement incomplete*.** The mathematics is right and I reproduced it two ways. The block should not be marked Gate-2-passed until $A$'s closed form and sign are in the statement (Defect A), the $\Lambda^2$ input is named or folded in (Defect B), the three-line derivation replaces the locator (Defect C), and $m\ge2$ is stated (Defect D). None of these changes the spectrum.
