# Verifier v402, Lemma L66 (no maximiser of $P$ is $\circ$-decomposable): definition, additivity, total symmetry of $T$, the strict chain, $M(n)>0$, the remarks of Passages A and C, and the Lean files

The brief ([BRIEF_L66r2.md](BRIEF_L66r2.md)) was cold. I worked from the definitions it quotes and from Nienhaus's thesis ([nienhaus-2311.02404.pdf](https://arxiv.org/abs/2311.02404), its text extraction, Proposition 2.25 at printed page 23, with Lemmas 2.12, 2.13, 2.19, 2.22 and the $\mathbb{CP}^2$ computation of printed page 27 read for conventions). No numerical work was done, no scripts were written, and the Lean files were read, not built. Every value below is exact, and every value on a constructed object is a hand screen, never evidence for a positive claim. The log is at [agent_logs/verify-L66-v402.log](../agent_logs/verify-L66-v402.log).

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | The definition of $\circ$-decomposable agrees across Passages A, B, C | CONFIRMED | same six clauses in all three. The slot placement of $T$ differs between A and C/D, and total symmetry makes that immaterial |
| 2 | $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is totally symmetric (Passage D) | CONFIRMED | $\mathop{\mathrm{tr}}(XYZ)$ is $S_3$-invariant on symmetric operators, and the $\#$ part permutes two antisymmetric $c$'s at sign $(-1)^2$ |
| 3 | Additivity $P(W)=\sum_ia_i^3P(A_i)$ | CONFIRMED | terms $i\ne j$ die at slot 1-2, terms $i=j\ne l$ need one slot-3 move, which is exactly total symmetry |
| 4 | $\lvert P(A_i)\rvert\le M(n)$ | CONFIRMED | $P$ cubic hence odd, and $-A_i$ is also a unit element of $\mathcal W_n$ |
| 5 | The chain $\sum a_i^3P(A_i)\le M\sum\lvert a_i\rvert^3\le M\max\lvert a_i\rvert<M$ | CONFIRMED | each step closes, the strict step uses $M>0$ and $\max\lvert a_i\rvert<1$ |
| 6 | $\max_i\lvert a_i\rvert<1$ | CONFIRMED | $a_i^2=1-\sum_{j\ne i}a_j^2$ and some $j\ne i$ exists with $a_j\ne0$ |
| 7 | $M(n)>0$ at every $n\ge4$ via Nienhaus Proposition 2.25 | CONFIRMED | $(k,l)=(2,n-2)$ gives $\theta=\sqrt{(n-1)(n-3)}/(n-2)>0$, formula matches the PDF, $W_{S_{k,l}}$ is unit by definition, $\#$ conventions agree |
| 8 | The absolute-value remark at $(\tfrac35,-\tfrac45)$ with pieces at $\pm M$ | CONFIRMED AS ALGEBRA | $\tfrac{91}{125}M$ and $-\tfrac{37}{125}M$ both exact, and a screen realises pieces at $\pm M$ inside the definition at $n=4$ |
| 9 | "Criticality of the pieces is not needed", "Nothing else is used" | CONFIRMED | the proof reads no criticality, padding, monotonicity or support |
| 10 | Criticality with Frobenius orthogonality differs from $\circ$-orthogonality (run at $n=8$, $\approx0.664$, $\approx0.273$) | HYPOTHESIS-DEBT | the figures rest on a run only. A hand screen at $n=4$ finds a closed-form pair consistent with the qualitative claim. Unused by the proof |
| 11 | Passage C detail: $\lvert P(W)\rvert$ chain, "runs against $M(n)$", "$0<0$", "no induction on $n$" | CONFIRMED | $\lvert P(W)\rvert$ bound is valid and stronger than A's, the $0<0$ reading is correct, the lemma is about maximisers only |
| 12 | Passage C landscape: $\lvert\theta\rvert<\min(\lvert\theta_A\rvert,\lvert\theta_B\rvert)$ from the harmonic-square law, and the limit $a_1\to1$ | CONFIRMED AS ALGEBRA | the consequence follows from the law when $\theta_A,\theta_B\ne0$. The law itself is outside the brief. Screened exactly at $S^2\times S^2$ |
| 13 | Lean: [L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean) states the claim | CONFIRMED | abstract trilinear form with 1-2 symmetry and slot-(2,3) orthogonality for all $X$, $M>0$ and the upper bound as hypotheses, conclusion matches |
| 14 | Lean: [L66.lean](../lean/HamiltonsCubic/Results/L66.lean) | CONFIRMED AS ALGEBRA | the strict chain and the witness arithmetic are correct, it states no lemma, and three declarations match no passage |

**Summary: Lemma L66 is proven as written, every step of Passage A closes from stated hypotheses and a correctly applied Proposition 2.25, and the only debt is the run-cited side paragraph on criticality with Frobenius orthogonality, which the proof never uses.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, viewed as symmetric operators on $\Lambda^2\mathbb R^n$, with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$."
- "$(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ ... the formula returns $\mathrm{id}^\#=2(n-2)\mathrm{id}$ [without the $\tfrac12$] against the halved Böhm–Wilking product's $(n-2)\mathrm{id}$, which is what $Q(\mathrm{id})=(n-1)\mathrm{id}$ on the round sphere pins."
- "The $\circ$ product: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$."
- "$T$, third sense: the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$."
- Passage A writes $T(X,Y,Z)=\langle X,Y\circ Z\rangle$. Section 1 records why both placements are the same form.

Consequences used below, each immediate from the quoted definitions: $\circ$ is bilinear and symmetric, $X\circ X=Q(X)$, and $P(W)=T(W,W,W)$ under either slot placement.

## Hypothesis inventory

**The statement.** For $n\ge4$, $W$ with $\lVert W\rVert=1$ and $P(W)=M(n)$, and a decomposition with $k\ge2$, $A_i\in\mathcal W_n$, $\lVert A_i\rVert=1$, $\sum a_i^2=1$, all $a_i\ne0$, $A_i\circ A_j=0$ for $i\ne j$.

| Hypothesis | Used by the proof at | Note |
|---|---|---|
| $n\ge4$ | $M(n)>0$ through $S^2\times S^{n-2}$ | at $n\le3$ the sphere is empty and the statement is vacuous |
| $\lVert W\rVert=1$ | nowhere | harmless: the proof shows $P(W)<M(n)$ for every $\circ$-decomposable $W$ of any norm, and a maximiser has $P(W)=M(n)$. The Lean binder is `_hWnorm`, unused, consistently |
| $P(W)=M(n)$ | the contradiction | |
| $k\ge2$ | $\max\lvert a_i\rvert<1$ | |
| $A_i\in\mathcal W_n$, $\lVert A_i\rVert=1$ | $\lvert P(A_i)\rvert\le M(n)$ | |
| $\sum a_i^2=1$ | $\sum\lvert a_i\rvert^3\le\max\lvert a_i\rvert$ and $\max\lvert a_i\rvert<1$ | |
| every $a_i\ne0$ | $\max\lvert a_i\rvert<1$ | only "each $i$ has a nonzero partner $j\ne i$" is needed, which "every $a_i\ne0$" with $k\ge2$ gives |
| $A_i\circ A_j=0$, $i\ne j$ | additivity | |

**Used but not in the statement.** Total symmetry of $T$ (stated and argued in Passage D, checked in section 1). Existence of the maximum $M(n)$ (continuous $P$ on the compact unit sphere of a finite-dimensional space, unstated and standard). That $\langle A,B\rangle=\mathop{\mathrm{tr}}(AB)$ on symmetric operators and that the $c$'s are totally antisymmetric structure constants in an orthonormal basis (both carried by Passage D's wording). No hypothesis is used without being available in the passages.

**The imported result, Nienhaus Proposition 2.25.** Hypotheses: $k,l\in\mathbb N$, $k+l=n$, the product $S^k\times S^l_r$ with $r=\sqrt{(l-1)/(k-1)}$, which needs $k\ge2$. $W_{S_{k,l}}=\widetilde W_{S_{k,l}}/\lVert\widetilde W_{S_{k,l}}\rVert$ with $\lVert\widetilde W_{S_{k,l}}\rVert^2=\tfrac{kl}2\cdot\tfrac{k-1}{l-1}\cdot\tfrac{n-2}{n-1}$ (printed page 23), which is nonzero for $k,l\ge2$, so the unit element exists. $P$ is Nienhaus's Definition 2.15, $P(R)=\langle Q(R),R\rangle$ with $Q(R,S)=\tfrac12(RS+SR)+R\#S$ (Lemma 2.13). Checked against the application: Passage A takes $k,l\ge2$, which meets every hypothesis, and the convention checks are in section 7.

## 1. The definition, across Passages A, B and C (brief item 1)

Passage A, Passage B and Passage C's detail list the same clauses: $k\ge2$, unit $A_i$ in $\mathcal W_n$ (A and B write $\mathrm{Weyl}_n$, C writes $\mathcal W_n$ or "unit Weyl tensor"), $\sum a_i^2=1$, every $a_i\ne0$, $A_i\circ A_j=0$ for $i\ne j$. C's detail adds "$\circ$ is the symmetric product with $\langle x\circ y,z\rangle=T(x,y,z)$", which is the conventions' definition read backwards and agrees with it.

No finding. The one difference is the slot placement of $T$ (candidate W1, withdrawn).

## 2. Total symmetry of $T$ (brief item 2, second half)

$T(X,Y,Z)=\langle X\circ Y,Z\rangle=\tfrac12\bigl(\mathop{\mathrm{tr}}(XYZ)+\mathop{\mathrm{tr}}(YXZ)\bigr)+\langle X\#Y,Z\rangle$, with $X\#Y$ the polarisation of $\#$.

**The $W^2$ part.** $\mathop{\mathrm{tr}}(XYZ)$ is invariant under cyclic permutations. For symmetric $X,Y,Z$, $\mathop{\mathrm{tr}}(XYZ)=\mathop{\mathrm{tr}}((XYZ)^{\mathsf T})=\mathop{\mathrm{tr}}(ZYX)$, the reversal. Cycles and one reversal generate $S_3$, so $\mathop{\mathrm{tr}}(XYZ)$ is already totally symmetric and the symmetrisation equals it. Passage D's "symmetrisation of $\mathop{\mathrm{tr}}(XYZ)$" is correct.

**The $\#$ part.** From the index formula, $\langle X\#Y,Z\rangle=\tfrac12\sum c_{acd}c_{bef}X_{ce}Y_{df}Z_{ab}$ (the polarisation needs no extra symmetrisation because swapping $(c,d)$ and $(e,f)$ together costs $(-1)^2$). Here $X$ occupies the second index of each $c$, $Y$ the third, $Z$ the first. Exchanging the roles of $X$ and $Z$ and renaming $a\leftrightarrow c$, $b\leftrightarrow e$ gives $c_{cad}c_{ebf}=(-1)(-1)c_{acd}c_{bef}$. The same holds for $X\leftrightarrow Y$ and $Y\leftrightarrow Z$. The factor $\tfrac12$ is a common scalar and does not enter. Passage D's argument closes once the $c$'s are totally antisymmetric, which D states.

Verdict CONFIRMED.

## 3. Additivity (brief item 2, first half)

$P(W)=T(W,W,W)=\sum_{i,j,l}a_ia_ja_l\,T(A_i,A_j,A_l)$. With $T(X,Y,Z)=\langle X\circ Y,Z\rangle$:

- $i\ne j$: $T(A_i,A_j,A_l)=\langle A_i\circ A_j,A_l\rangle=0$ directly.
- $i=j\ne l$: $T(A_i,A_i,A_l)=\langle Q(A_i),A_l\rangle$. The hypothesis says nothing about this pairing. Moving slot 3 to slot 2 by total symmetry gives $T(A_i,A_l,A_i)=\langle A_i\circ A_l,A_i\rangle=0$.
- $i=j=l$: $T(A_i,A_i,A_i)=P(A_i)$.

So $P(W)=\sum_ia_i^3P(A_i)$. The step needs symmetry between slot 3 and the others, which is more than the symmetry of $\circ$ and is exactly what section 2 supplies. Passage A's wording, the cross term $\langle A_i,Q(A_j)\rangle=T(A_i,A_j,A_j)$ moved to $\langle A_j,A_i\circ A_j\rangle$, is the same move in A's slot convention.

Screen of additivity against the imported proposition, at $n=4$. By Nienhaus Lemma 2.19, $R^\#=\begin{pmatrix}A^\#&B^\#\\ (B^\#)^{\mathsf T}&C^\#\end{pmatrix}$ with $A^\#=2\mathop{\mathrm{adj}}(A)$ on $\Lambda^\pm$. For $A\in\mathcal W^+$ and $C\in\mathcal W^-$, $AC=0$ and $(A+C)^\#=A^\#+C^\#$, so $A\circ C=0$. On a traceless $3\times3$ block with eigenvalues $\lambda$, $P=\sum\lambda^3+6\lambda_1\lambda_2\lambda_3=9\lambda_1\lambda_2\lambda_3$. The unit $W_{S_{2,2}}$ has $\mathcal W^\pm$ parts each $\tfrac1{\sqrt2}\mathop{\mathrm{diag}}(2,-1,-1)/\sqrt6$ (from $\widetilde W=\tfrac23$ on $e_{12},e_{34}$ and $-\tfrac13$ on the mixed planes). Additivity predicts $P=2\cdot(\tfrac1{\sqrt2})^3\cdot\tfrac{3}{\sqrt6}=\tfrac{\sqrt3}2$, and Proposition 2.25 gives $\theta_{2,2}=\sqrt2\sqrt{\tfrac12\cdot\tfrac12\cdot\tfrac32}=\tfrac{\sqrt3}2$. The two agree. Reported as a screen.

Verdict CONFIRMED.

## 4. $\lvert P(A_i)\rvert\le M(n)$ (brief item 3)

$P(-A)=-P(A)$ because $P$ is a homogeneous cubic ($Q(-A)=Q(A)$). $-A_i$ lies in $\mathcal W_n$ with norm 1, so $-P(A_i)=P(-A_i)\le M(n)$, and $P(A_i)\le M(n)$ directly. Passage A gives this in its "Nothing else is used" paragraph, after the chain that uses it, which is a presentation order, not a gap.

Verdict CONFIRMED.

## 5. The chain and its strictness (brief item 4)

- $a_i^3P(A_i)\le\lvert a_i\rvert^3\lvert P(A_i)\rvert\le\lvert a_i\rvert^3M(n)$, by section 4 and $\lvert a_i\rvert^3\ge0$. Summing gives the first inequality, for either sign of $a_i$ or $P(A_i)$.
- $\sum\lvert a_i\rvert^3=\sum\lvert a_i\rvert\,a_i^2\le\max\lvert a_i\rvert\sum a_i^2=\max\lvert a_i\rvert$, then multiplied by $M(n)\ge0$.
- $M(n)\max\lvert a_i\rvert<M(n)$ needs $M(n)>0$ (section 7) and $\max\lvert a_i\rvert<1$ (section 6).

Verdict CONFIRMED. Passage A's "strict only because of that" (candidate W4) is withdrawn.

## 6. $\max_i\lvert a_i\rvert<1$ (brief item 5)

Fix $i$. Since $k\ge2$ there is $j\ne i$, and $a_j\ne0$, so $a_i^2=1-\sum_{l\ne i}a_l^2\le1-a_j^2<1$. The maximum is over finitely many indices, so it is attained and is $<1$.

Edge: $k=2$, $a_1^2=a_2^2=\tfrac12$ gives $\max\lvert a_i\rvert=\tfrac1{\sqrt2}$ and $\sum\lvert a_i\rvert^3=\tfrac1{\sqrt2}$, so the middle inequality is an equality there and strictness still comes from the last step.

Verdict CONFIRMED.

## 7. $M(n)>0$ at every $n\ge4$ against Proposition 2.25 (brief item 6)

- **The formula.** PDF printed page 23: $\theta_{k,l}=\sqrt2\cdot\sqrt{\tfrac{k-1}k\cdot\tfrac{l-1}l\cdot\tfrac{n-1}{n-2}}$, "Moreover, $P(W_{S_{k,l}})=\theta_{k,l}$". Passage A's formula is identical.
- **Unit.** $W_{S_{k,l}}$ is defined as $\widetilde W_{S_{k,l}}/\lVert\widetilde W_{S_{k,l}}\rVert$ with the norm nonzero for $k,l\ge2$.
- **Every $n\ge4$.** $(k,l)=(2,n-2)$ satisfies $k,l\ge2$ and $k+l=n$, with $\theta_{2,n-2}=\sqrt{(n-1)(n-3)}/(n-2)>0$. At $n=4$ this is $\tfrac{\sqrt3}2$.
- **Conventions.** Nienhaus's $\#$ satisfies $\mathrm{Id}^\#=(n-2)\mathrm{Id}$ by his Lemma 2.22(b) ($\widetilde{\mathrm{Id}}=J-I$, and the off-diagonal entries of $(J-I)^2$ are $n-2$), which is the record's halved normalisation as quoted. $Q(\mathrm{Id})=(n-1)\mathrm{Id}$ matches Nienhaus's Einstein constant $n-1$ for $S^n$. Positivity of $P$ survives any positive rescaling of the inner product.
- **Screen at $n=4$, $k=l=2$.** $\widetilde W=\tfrac23$ on $e_{12},e_{34}$ and $-\tfrac13$ on the four mixed planes, column sums zero, $\lVert\widetilde W\rVert^2=\tfrac43$ (Nienhaus's formula gives $\tfrac{4}{2}\cdot1\cdot\tfrac23=\tfrac43$). By Lemma 2.22, $\widetilde W^2$ has entries $\tfrac49,\tfrac19$ and $\widetilde W^\#$ has entries $\tfrac29,-\tfrac49$, so $Q(\widetilde W)=\widetilde W$ and the unit value is $\tfrac43/(\tfrac43)^{3/2}=\tfrac{\sqrt3}2=\theta_{2,2}$. A screen, agreeing with the proposition.

Verdict CONFIRMED.

## 8. The absolute-value remark (brief item 7)

- True value: $(\tfrac35)^3M+(-\tfrac45)^3(-M)=\tfrac{27+64}{125}M=\tfrac{91}{125}M$.
- Signed bound: $\bigl((\tfrac35)^3+(-\tfrac45)^3\bigr)M=-\tfrac{37}{125}M$.
- With absolute values the bound is $\tfrac{91}{125}M\le\tfrac45M=\tfrac{100}{125}M$, consistent.

**Can pieces at $\pm M$ meet the definition?** Screen at $n=4$. $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ and every $W$ splits as $aA+bC$ with $A\in\mathcal W^+$, $C\in\mathcal W^-$, $A\circ C=0$ (section 3). By the lemma's own additivity and $\lvert a\rvert^3+\lvert b\rvert^3\le1$, $M(4)$ is attained inside $\mathcal W^+$ at some $A_1$. An orientation-reversing isometry carries $A_1$ to $A_1'\in\mathcal W^-$ with $P(A_1')=M(4)$ (O(n)-equivariance, Nienhaus Lemma 2.12(ii)). Then $A_2=-A_1'$ has $P(A_2)=-M(4)$, $A_1\circ A_2=0$, and $(a,b)=(\tfrac35,-\tfrac45)$ meets every clause. The remark's configuration is realisable.

Verdict CONFIRMED AS ALGEBRA. Candidate W3 ("fails at any negative coefficient") is withdrawn.

## 9. "Criticality of the pieces is not needed" and "Nothing else is used" (brief item 8, first half)

The steps of sections 3 to 7 use: total symmetry of $T$, $\circ$-orthogonality, oddness of $P$, unit norm of the pieces, the coefficient conditions, and one positive value of $P$. No step reads $Q(A_i)=\lambda A_i$, padding, monotonicity of $M$, the harmonic-square law, or any support dimension.

Verdict CONFIRMED.

## 10. Criticality with Frobenius orthogonality (brief item 8, second half)

**Location.** Passage A: "A run at $n=8$ found two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ with $\lVert A\circ B\rVert\approx0.664$, and a rotated $S^4\times S^4$ pair at $\approx0.273$. No closed-form witness is on file."

**What is on file.** The two figures rest on a run and nothing else, which the brief grades `HYPOTHESIS-DEBT`. To discharge it, a closed-form pair of unit critical elements with $\langle A,B\rangle=0$ and $A\circ B\ne0$ is needed. The $n=8$ values would need their own exact derivation.

**Screen (not a repair, and not on file).** At $n=4$ on $\Lambda^+$, Nienhaus Lemma 2.19 gives $X^\#=2\mathop{\mathrm{adj}}X=2X^2-\mathop{\mathrm{tr}}(X^2)I$ for traceless $X$, so $X\circ Y=\tfrac32(XY+YX)-\mathop{\mathrm{tr}}(XY)I$. Take $A=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(2,-1,-1)$ (Nienhaus's $W_{\mathbb{CP}^2}$ block) and $B=\tfrac1{\sqrt6}(J-I)$.
- $Q(A)=3A^2-I=\mathop{\mathrm{diag}}(1,-\tfrac12,-\tfrac12)=\sqrt{3/2}\,A$ and $Q(B)=\tfrac12(J+I)-I=\sqrt{3/2}\,B$, so both are critical.
- $\mathop{\mathrm{tr}}(AB)=0$.
- $A\circ B=\tfrac14\begin{pmatrix}0&1&1\\1&0&-2\\1&-2&0\end{pmatrix}\ne0$, of Frobenius norm $\tfrac{\sqrt3}2$.

The qualitative claim holds by this screen, at $n=4$ rather than $n=8$. The paragraph is unused by the proof and does not affect the verdict.

Verdict HYPOTHESIS-DEBT, confined to the side paragraph.

## 11. Passage C, detail and landscape (brief item 9)

**$\lvert P(W)\rvert$.** $\lvert\sum a_i^3P(A_i)\rvert\le\sum\lvert a_i\rvert^3\lvert P(A_i)\rvert$ by the triangle inequality. This bounds $\lvert P(W)\rvert$, which is stronger than Passage A's bound on $P(W)$ and valid. C compresses the steps $\lvert P(A_i)\rvert\le M$ and $\sum\lvert a_i\rvert^3\le\max\lvert a_i\rvert$ that A carries (candidate W5, withdrawn).

**"Runs against $M(n)$", "$0<0$".** With $m=\max_i\lvert P(A_i)\rvert$ in place of $M(n)$ the last step reads $m\max\lvert a_i\rvert<m$, false at $m=0$. Screen: such a splitting exists at $n=4$, $A=\tfrac1{\sqrt2}\mathop{\mathrm{diag}}(1,0,-1)$ in $\mathcal W^+$ with $P=9\lambda_1\lambda_2\lambda_3=0$ and its mirror in $\mathcal W^-$. Correct.

**"No induction on $n$".** The lemma concludes only about maximisers and says nothing about the support of the $A_i$. Correct.

**Harmonic-square consequence.** From $\tfrac1{\theta^2}=\tfrac1{\theta_A^2}+\tfrac1{\theta_B^2}$ with both terms positive, $\theta^2<\theta_A^2$ and $\theta^2<\theta_B^2$. The law is written only for $\theta_A,\theta_B\ne0$. The law is cited from a file outside the brief, so I check only the consequence. Screen at $W_{S_{2,2}}$, split into critical $\mathcal W^\pm$ pieces with $\theta_A=\theta_B=\sqrt{3/2}$: $\tfrac1{\theta^2}=\tfrac43$, so $\theta=\tfrac{\sqrt3}2=\theta_{2,2}$, agreeing with Proposition 2.25.

**"As one coefficient tends to 1".** $P(W)=a_1^3P(A_1)+a_2^3P(A_2)\to P(A_1)$ as $a_1\to1$. With $P(A_2)=0$ (the $\mathcal W^-$ piece above) and $P(A_1)\ne0$, $\lvert P(W)\rvert$ exceeds $\min_i\lvert P(A_i)\rvert=0$ near the limit, so the min-bound fails without criticality. Correct under the reading that $\theta$ is replaced by $P(W)$ off criticality.

**"Reach non-critical splittings and ones sharing coordinates".** As a scope statement it is correct: the hypotheses do not mention criticality or supports. Existence is not on file. Screen: at every $n\ge4$, a padded $\mathcal W^+$ piece and a padded $\mathcal W^-$ piece on the same four coordinates are $\circ$-orthogonal (the structure constants between $\Lambda^+$ and $\Lambda^-$ vanish inside $\mathfrak{so}(n)$), and a non-critical choice exists, e.g. $\tfrac1{\sqrt2}\mathop{\mathrm{diag}}(1,0,-1)$, whose $Q=(\tfrac12,-1,\tfrac12)$ is not proportional to it.

Verdicts: detail CONFIRMED, landscape CONFIRMED AS ALGEBRA.

## 12. The Lean files (brief item 10, standing item 5)

**[L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean).**
- `IsCircDecomposable T W` has $k\ge2$, unit $A_i$, $\sum a_i^2=1$, $a_i\ne0$, $W=\sum a_iA_i$, and orthogonality as `∀ X i j, i ≠ j → T X (A i) (A j) = 0`. Under Passage A's placement $T(X,Y,Z)=\langle X,Y\circ Z\rangle$ this is $A_i\circ A_j=0$ by nondegeneracy. Under C's placement it is the same through total symmetry.
- `Pf_additive` assumes only `hsym12`. Reading the proof: the inner sum kills $l\ne j$ by `horth (A i) j l`, the middle sum kills $j\ne i$ by `hsym12` and then `horth (A j) i j`. That is sound for the abstract form. The record's slot-3 move is absorbed into the $\forall X$ form of `horth`.
- `Pf_lt_max` and `no_maximizer_is_circDecomposable` take $0<M$ and $\forall B,\ \lVert B\rVert=1\to P(B)\le M$ as hypotheses, and conclude $P(W)<M$ and $\neg$`IsCircDecomposable` at $P(W)=M$. Oddness uses only $\lVert-B\rVert=\lVert B\rVert$, valid for any norm. `_hWnorm` is unused, matching the inventory.
- **What enters as hypothesis rather than proof.** Total symmetry of the record's $T$, the instantiation $E=\mathcal W_n$, and $M(n)>0$ (Proposition 2.25). The theorem is the abstract core, stated correctly, with the bridge to $\mathcal W_n$ unformalised.
- The final `example` exhibits `IsCircDecomposable` only for $T=0$, which shows the predicate is satisfiable and is no witness in $\mathcal W_n$.

**[L66.lean](../lean/HamiltonsCubic/Results/L66.lean).**
- `strict_below` proves the chain from `hadd` and `hPi` given as hypotheses, with an extra `hbound : ∀ i, |a i| ≤ max |a j| |a k|`. That is satisfiable for every admissible $a$ by taking $j$ an arg-max and $k$ any other index (candidate W6, withdrawn).
- The `witness_*` theorems reproduce section 8's $\tfrac{91}{125}$, $-\tfrac{37}{125}$, margin $\tfrac{128}{125}$ and absolute sum $\tfrac{91}{125}$. All correct.
- `theta0_four` ($2\cdot3\cdot2/16=\tfrac34$), `M4_exceeds` ($\tfrac34<\tfrac32$) and `M4_ratio` ($\tfrac32=2\cdot\tfrac34$) are true and correspond to no passage of the brief. Their likeliest reading is $\theta_4^2=\tfrac34<\tfrac32=P(W_{\mathbb{CP}^2})^2$, but nothing in L66 cites them. This file states no lemma.

I did not build either file.

## 13. The boundary (brief item 11, standing item 3)

- **$n=4$.** $\theta_{2,2}=\tfrac{\sqrt3}2>0$, and decomposables exist ($\mathcal W^+\oplus\mathcal W^-$).
- **$k=2$, $a_1^2=a_2^2=\tfrac12$.** $W_{S_{2,2}}$ is itself $\circ$-decomposable with these coefficients, with $P=\tfrac{\sqrt3}2<\sqrt{3/2}=P(W_{\mathbb{CP}^2})\le M(4)$. The lemma's conclusion holds there by screen.
- **Pieces with $P(A_i)<0$.** Handled by $a_i^3P(A_i)\le\lvert a_i\rvert^3\lvert P(A_i)\rvert$. Example: $A_2=-A_1'$ in section 8.
- **$\ker W\ne0$, padded objects.** No step uses invertibility or support. Padded $\mathcal W^\pm$ pieces at $n\ge5$ have nonzero kernel and fall under the same chain.
- **Existence at every $n\ge4$.** By screen, padded $\mathcal W^\pm$ pairs at every $n\ge4$. The theorem is a universal negative and needs no witness for its truth.
- **Smallest admissible $k$ in the import.** $k=2$ is the smallest with $r$ defined and $\theta_{k,l}>0$.

## 14. Quantifiers and subfamilies (standing items 2 and 4)

The order is: for all $n\ge4$, for all unit $W$ with $P(W)=M(n)$, no finite $k$ and coefficients and pieces exist. $M(n)$ depends on $n$ only and is fixed before $W$. Proposition 2.25 is proven on the family $S_{k,l}$ and used only existentially, for one positive value, which is all a family result can give and all the proof needs. Total symmetry is proven on all symmetric operators, so it covers $\mathcal W_n$.

No finding.

## 15. Withdrawn candidates

**W1. Slot placement of $T$ differs between Passage A and Passages C, D.**
1. Location: A writes $T(X,Y,Z)=\langle X,Y\circ Z\rangle$, and C, D and the conventions write $\langle X\circ Y,Z\rangle$.
2. Failure: none exists. The two forms differ by a cyclic permutation of slots, and section 2 shows $T$ is totally symmetric.
3. Charitable reading: one form under two notations.
Withdrawn, fails step 2.

**W2. The definition does not force $\lVert W\rVert=1$, since $A_i\circ A_j=0$ does not force $\langle A_i,A_j\rangle=0$.**
1. Location: the definition in A, B, C.
2. Failure: the proof never uses $\lVert W\rVert$ (inventory), and a maximiser is unit by its own hypothesis.
3. Charitable reading: the definition is a predicate on $W$, and the theorem applies it to unit $W$.
Withdrawn, fails step 2.

**W3. "The chain fails at any negative coefficient" is too strong.**
1. Location: Passage A's italic remark.
2. Failure: with $a_j<0$ and $P(A_j)=M$, $a_j^3P(A_j)=a_j^3M$ and the signed step holds for that term.
3. Charitable reading: at any negative coefficient the signed step stops being valid, since pieces exist that break it (section 8 realises them).
Withdrawn, fails step 3.

**W4. "Strict only because of $M(n)>0$" omits $\max\lvert a_i\rvert<1$.**
1. Location: Passage A, first sentence of the proof.
2. Failure: the strictness uses both facts.
3. Charitable reading: $M(n)>0$ is the one ingredient beyond coefficient arithmetic, and the next sentence supplies $\max\lvert a_i\rvert<1$.
Withdrawn, fails step 3.

**W5. Passage C's chain skips $\lvert P(A_i)\rvert\le M$ and $\sum\lvert a_i\rvert^3\le\max\lvert a_i\rvert$.**
1. Location: Passage C line 1163.
2. Failure: both steps hold (sections 4 and 5).
3. Charitable reading: C summarises A, which carries both.
Withdrawn, fails steps 2 and 3.

**W6. `strict_below` carries an extra hypothesis `hbound`.**
1. Location: [L66.lean](../lean/HamiltonsCubic/Results/L66.lean).
2. Failure: `hbound` is satisfiable for every admissible coefficient vector with $k\ge2$ by choosing $j$ as an arg-max.
3. Charitable reading: a convenient encoding of $\max_i\lvert a_i\rvert$.
Withdrawn, fails step 2.

**W7. Lean assumes 1-2 symmetry only, while the record uses total symmetry.**
1. Location: `Pf_additive`, `hsym12` and `horth`.
2. Failure: none. The $\forall X$ slot-(2,3) form of `horth` carries the part of total symmetry the proof needs, and the record's $T$ satisfies both hypotheses by section 2.
3. Charitable reading: an abstraction that assumes the minimum.
Withdrawn, fails step 2.

## 16. What would break it

- A unit $W$ at some $n\ge4$ with $P(W)=M(n)$ and a $\circ$-orthogonal decomposition. By sections 3 to 7 this requires one of the following.
- **A failure of total symmetry,** a triple with $T(X,Y,Z)\ne T(Z,Y,X)$. Excluded by the index argument of section 2.
- **A unit piece with $\lvert P(A)\rvert>M(n)$.** Excluded by oddness.
- **$M(n)\le0$ at some $n\ge4$.** Excluded by $\theta_{2,n-2}=\sqrt{(n-1)(n-3)}/(n-2)>0$, checked against the PDF and screened at $n=4$.

What I did to look: screened, by hand and in closed form, the $n=4$ decomposables $\mathcal W^+\oplus\mathcal W^-$, including $W_{S_{2,2}}$ at equal coefficients, pieces at $\pm M$, pieces with $P=0$ and non-critical pieces, and the padded versions of these at $n\ge5$. Every one agreed with the lemma.

## 17. Verdict

**PROVEN.** The proof in Passage A closes from its stated hypotheses. The imported Proposition 2.25 is applied within its hypotheses and conventions. Passage C's detail is a correct strengthening to $\lvert P(W)\rvert$. The Lean statement file states the abstract core faithfully. The one debt is the run-cited side paragraph on critical, Frobenius-orthogonal pairs, which the proof does not use and which a closed-form $n=4$ screen supports qualitatively. No other file was staged when I checked `git status` before committing.
