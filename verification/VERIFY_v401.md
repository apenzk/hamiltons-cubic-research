# Verifier v401, Lemma L66 (no maximizer is $\circ$-decomposable): definition, total symmetry of $T$, additivity, the strict chain, $M(n)>0$ via Nienhaus Proposition 2.25, the remarks of Passages A and C, and the Lean statement

The brief was cold and I worked from the definitions it quotes, from Nienhaus Proposition 2.25 at source (text extraction lines 1040-1200, 1318-1345, 1380-1510, and PDF pages 22-23 and 26-28 in the thesis numbering), and from nothing else in the repository. No numerical work was done and every value below is exact. No scripts were written and no Lean build was run: the Lean passages were checked by reading their statements. Every closed-form check on a constructed object is labelled a screen and is not offered as evidence for a positive claim. The log is [agent_logs/verify-L66-v401.log](../agent_logs/verify-L66-v401.log).

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | The definition of $\circ$-decomposable agrees across Passages A, B, C | CONFIRMED | Same five clauses in all three, the slot convention for $T$ differs but coincides under total symmetry |
| 2 | $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is totally symmetric (Passage D), both parts, with the $\tfrac12$ | CONFIRMED | Trace part is $S_3$-invariant as the sum of both cyclic classes, $\#$ part picks up $(-1)^2$ under each transposition, the $\tfrac12$ is a uniform scalar |
| 3 | Additivity $P(W)=\sum_ia_i^3P(A_i)$ | CONFIRMED | Terms with distinct indices in the two product slots die directly, the $(i,j,j)$ term needs one slot move, which total symmetry supplies |
| 4 | $\lvert P(A_i)\rvert\le M(n)$ | CONFIRMED | $P$ is cubic hence odd, $-A_i$ is a unit element of $\mathcal W_n$ |
| 5 | $\max_i\lvert a_i\rvert<1$ | CONFIRMED | $a_i^2=1-\sum_{j\ne i}a_j^2$ and some $a_j\ne0$ with $j\ne i$ exists since $k\ge2$ |
| 6 | The chain $\sum a_i^3P(A_i)\le M\sum\lvert a_i\rvert^3\le M\max\lvert a_i\rvert<M$ | CONFIRMED | Each step closes, the last two use $M\ge0$ and $M>0$ respectively |
| 7 | $M(n)>0$ for every $n\ge4$ via Proposition 2.25 | CONFIRMED | $k=2$, $l=n-2$ realises every $n\ge4$, $W_{S_{k,l}}$ is unit by construction, the formula matches the PDF, Nienhaus's $\#$ matches the record's pin |
| 8 | Absolute-value remark at $(\tfrac35,-\tfrac45)$ with pieces at $\pm M$ | CONFIRMED AS ALGEBRA | $\tfrac{91}{125}M$ and $-\tfrac{37}{125}M$ are exact, the remark needs no existence of pieces at exactly $\pm M$ |
| 9 | "Criticality of the pieces is not needed", "Nothing else is used" | CONFIRMED | The proof reads only the five definitional clauses, oddness, and $M(n)>0$ |
| 10 | Criticality with Frobenius orthogonality is a different hypothesis from $\circ$-orthogonality | HYPOTHESIS-DEBT | Supported on file only by a run at $n=8$ with decimal values, the passage itself says no closed-form witness is on file |
| 11 | Passage C detail: $\lvert P(W)\rvert$ bound, bound against $M(n)$, "reads $0<0$", "no induction on $n$" | CONFIRMED | Triangle inequality gives the two-sided form, the $0<0$ reading is exact algebra |
| 12 | Passage C landscape: $\lvert\theta\rvert<\min(\lvert\theta_A\rvert,\lvert\theta_B\rvert)$ from the harmonic-square law, and the limit as a coefficient tends to $1$ | CONFIRMED AS ALGEBRA | Both follow from the displayed law and from additivity, the law itself is cited from a file outside the brief |
| 13 | Passage E states L66 | CONFIRMED | Abstract form over any trilinear $T$ with a weaker symmetry hypothesis, maximality and $M>0$ enter as binders, which the passages discharge |
| 14 | The boundary: $n=4$, $k=2$ at $a_i^2=\tfrac12$, negative pieces, existence of a $\circ$-decomposable $W$ at each $n\ge4$ | CONFIRMED | Every edge closes, and a screen exhibits $W_{S_{2,2}}$ itself as $\circ$-decomposable at $n=4$ with padded copies at every $n\ge4$ |

**Summary: Lemma L66's proof closes line by line from its stated hypotheses and Nienhaus Proposition 2.25, and the only debt is the non-load-bearing remark in Passage A that rests on an $n=8$ run.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, viewed as symmetric operators on $\Lambda^2\mathbb R^n$, with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$."
- "$(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$", pinned by "$\mathrm{id}^\#=(n-2)\mathrm{id}$" and "$Q(\mathrm{id})=(n-1)\mathrm{id}$".
- "The $\circ$ product: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$."
- "$T$, third sense: the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$." Passage A writes $T(X,Y,Z)=\langle X,Y\circ Z\rangle$. Section 1 records why the two agree.

Nienhaus, at source: $R\#S(v,w)=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}_v\circ R\circ\mathrm{ad}_w\circ S)$ (Definition 2.11), $Q(R)=R^2+R^\#$ (Lemma 2.13), $P(R)=\langle Q(R),R\rangle$ with $\langle R,S\rangle=\mathop{\mathrm{tr}}(R\circ S)$ (Definition 2.15 and Section 2.1), $W_{S_{k,l}}=\widetilde W_{S_{k,l}}/\lVert\widetilde W_{S_{k,l}}\rVert$ (page 23).

## 0.1 Hypothesis inventory

**The statement.** (H1) $n\ge4$. (H2) $W=\sum_{i=1}^ka_iA_i$. (H3) $k\ge2$. (H4) each $A_i\in\mathcal W_n$ with $\lVert A_i\rVert=1$. (H5) $\sum_ia_i^2=1$. (H6) every $a_i\ne0$. (H7) $A_i\circ A_j=0$ for $i\ne j$. (H8) $W$ is a maximizer of $P$ on the unit sphere, read as a global maximizer because the proof compares against $M(n)$, the global maximum.

**Imported, Nienhaus Proposition 2.25.** Its setting is $S_{k,l}=S^k\times S^l_r$ with $k+l=n$ and $r=\sqrt{(l-1)/(k-1)}$, which needs $k\ge2$ for $r$ to be defined and $l\ge2$ for $r>0$ and for the $\tfrac{k(k-1)}{(l-1)(n-1)}$ entry of $\widetilde W_{S_{k,l}}$. Its proof uses Lemma 2.22 (the curvature operator is diagonal in a standard basis, which (2.6) exhibits) and Lemma 2.17 (needs $\lambda>0$, here $\lambda=\tfrac{k-1}{n-1}>0$ at $k\ge2$). The passage applies it with $k,l\ge2$, which sits inside every one of these ranges. The normalisation of $\#$ matches: Lemma 2.22(b) at $R=\mathrm{Id}$ has $\widetilde R=J-I$ and $(\widetilde R^2)_{ij}=n-2$ off the diagonal, so $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, the record's pin. So Nienhaus's $P$ is the record's $P$ and $\theta_{k,l}$ transfers.

**Imported, Passage D.** Total symmetry of $T$. It uses total antisymmetry of the structure constants $c$ of $\mathfrak{so}(n)$ in an orthonormal basis for an $\mathrm{Ad}$-invariant inner product, a standard fact that the passage states and does not prove.

**What the written proof uses.** H3, H5, H6 for $\max\lvert a_i\rvert<1$. H4 for $\lvert P(A_i)\rvert\le M(n)$. H7 with total symmetry for additivity. H2 to expand. H8 to reach a contradiction with $P(W)<M(n)$. H1 only through $M(n)>0$ and $\mathcal W_n\ne0$. Nienhaus for $M(n)>0$.

**Unused.** $\lVert W\rVert=1$ is carried by H8 and is never used by the chain, which proves $P(W)<M(n)$ for every $\circ$-decomposable $W$ of any norm. The Lean binder `_hWnorm` is correspondingly unused. This is harmless: the hypotheses do not force $\langle A_i,A_j\rangle=0$, so a $\circ$-decomposable $W$ need not be unit, and the conclusion holds for it anyway.

**Used but unstated.** No finding: every step's hypothesis is written, with the standard antisymmetry of $c$ as the one textbook input.

## 1. The definition across Passages A, B, C

Passage A: $k\ge2$, unit $A_i\in\mathrm{Weyl}_n$, $\sum a_i^2=1$, all $a_i\ne0$, $A_i\circ A_j=0$ for $i\ne j$. Passage B: identical wording. Passage C landscape: "each $A_i$ a unit Weyl tensor", same remaining clauses. Passage C detail: same, adding "$\circ$ is the symmetric product with $\langle x\circ y,z\rangle=T(x,y,z)$".

The only variation is the slot convention: Passage A has $T(X,Y,Z)=\langle X,Y\circ Z\rangle$, Passages C and D have $\langle X\circ Y,Z\rangle$. Since $\circ$ is symmetric by its polarisation formula, the two forms are related by a cyclic shift of arguments, and they coincide exactly when $T$ is totally symmetric, which Section 2 confirms. The clause $A_i\circ A_j=0$ is an operator identity in all three passages, independent of the convention. **No finding.**

## 2. Total symmetry of $T$

**Trace part.** With the Frobenius product on symmetric operators, $\langle\tfrac12(XY+YX),Z\rangle=\tfrac12(\mathop{\mathrm{tr}}XYZ+\mathop{\mathrm{tr}}YXZ)$. $\mathop{\mathrm{tr}}XYZ$ is invariant under the cyclic subgroup of $S_3$, and $\mathop{\mathrm{tr}}YXZ=\mathop{\mathrm{tr}}XZY$ is the other coset. A transposition exchanges the two cosets, so their sum is $S_3$-invariant. Passage D's "symmetrisation of $\mathop{\mathrm{tr}}(XYZ)$" is this. It closes.

**$\#$ part, with the $\tfrac12$.** Polarising $(W^\#)_{ab}=\tfrac12c_{acd}c_{bef}W_{ce}W_{df}$ gives $(X\#Y)_{ab}=\tfrac14c_{acd}c_{bef}(X_{ce}Y_{df}+Y_{ce}X_{df})$. Renaming $c\leftrightarrow d$, $e\leftrightarrow f$ in the second term costs $(-1)^2$, so $(X\#Y)_{ab}=\tfrac12c_{acd}c_{bef}X_{ce}Y_{df}$ and $\langle X\#Y,Z\rangle=\tfrac12\sum c_{acd}c_{bef}X_{ce}Y_{df}Z_{ab}$. Here $X$ sits on the second slots of both $c$'s, $Y$ on the third, $Z$ on the first. Exchanging two of $X,Y,Z$ and renaming the corresponding index pairs applies the same transposition to both $c$'s, sign $(-1)^2=1$. Transpositions generate $S_3$. The $\tfrac12$ multiplies every term and is invisible to symmetry, so the brief's warning that "a step reading a value off it is out by two" does not touch this step, which reads no value. It closes.

**Independent at source.** Nienhaus Definition 2.15 states that Huisken's $\mathrm{tri}(R,S,T)=\langle Q(R,S),T\rangle$ "is fully symmetric", with $Q(R,S)=\tfrac12(RS+SR)+R\#S$ the same polarisation. This is a statement without proof there and is recorded as agreement, not as the argument. **CONFIRMED.**

## 3. Additivity

$T(W,W,W)=\sum_{i,j,l}a_ia_ja_lT(A_i,A_j,A_l)$ by trilinearity. Take Passage A's convention $T(X,Y,Z)=\langle X,Y\circ Z\rangle$.

- $j\ne l$: $T(A_i,A_j,A_l)=\langle A_i,A_j\circ A_l\rangle=0$ by H7.
- $j=l$, $i\ne j$: $T(A_i,A_j,A_j)=\langle A_i,Q(A_j)\rangle$, which H7 does not reach. Total symmetry moves it to $T(A_j,A_i,A_j)=\langle A_j,A_i\circ A_j\rangle=0$.
- $i=j=l$: $T(A_i,A_i,A_i)=P(A_i)$.

So $P(W)=\sum_ia_i^3P(A_i)$, exactly Passage A's account including which slot moves. Under Passages C and D's convention the roles swap: $\langle A_i\circ A_j,A_j\rangle$ dies directly and $\langle Q(A_j),A_i\rangle$ needs the move. Either way one transposition beyond the automatic symmetry of $\circ$ is required, and together they generate $S_3$, so "total symmetry" is exactly the requirement. Passage C's "every term of $T(W,W,W)$ carrying two distinct indices vanishes" is the same claim.

*Screen, $S^2\times S^2$ at $n=4$.* By (2.6) and page 23, $\widetilde W_{S_{2,2}}$ is $\tfrac23$ on $\mathrm{span}\{e_{12},e_{34}\}=\mathrm{span}\{\omega^+,\omega^-\}$ and $-\tfrac13$ on the four mixed planes, so in $\Lambda^+\oplus\Lambda^-$ it is $\tfrac13\mathop{\mathrm{diag}}(2,-1,-1)\oplus\tfrac13\mathop{\mathrm{diag}}(2,-1,-1)$. Hence $W_{S_{2,2}}=\tfrac1{\sqrt2}(A+B)$ with $A=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(2,-1,-1)\oplus0$ and $B=0\oplus\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(2,-1,-1)$, both unit. $AB=BA=0$, and by Lemma 2.19 (for Weyl operators the off-diagonal block vanishes and $\#$ is $2\mathop{\mathrm{adj}}$ on each block) $(A+B)^\#=A^\#+B^\#$, so $A\#B=0$ and $A\circ B=0$. Each piece is Nienhaus's redefined $W_{\mathbb{CP}^2}$ up to orientation, with $P=\sqrt{3/2}$ (page 27). Additivity predicts $P(W_{S_{2,2}})=2\cdot2^{-3/2}\sqrt{3/2}=\tfrac{\sqrt3}2$, and Proposition 2.25 gives $\theta_{2,2}=\sqrt{2\cdot\tfrac12\cdot\tfrac12\cdot\tfrac32}=\tfrac{\sqrt3}2$. The screen matches exactly. **CONFIRMED.**

## 4. $\lvert P(A_i)\rvert\le M(n)$

$P(-A)=T(-A,-A,-A)=-P(A)$. $-A_i\in\mathcal W_n$ has norm $1$, so $P(A_i)\le M(n)$ and $-P(A_i)=P(-A_i)\le M(n)$. The maximum exists because the unit sphere of the finite-dimensional $\mathcal W_n$ is compact and $P$ is continuous, a fact the passages take for granted in writing $\max$. **CONFIRMED.**

## 5. $\max_i\lvert a_i\rvert<1$

Fix $i$. By H3 there is $j\ne i$, by H6 $a_j^2>0$, so $a_i^2\le1-a_j^2<1$. The index set is finite, so the maximum is attained and is $<1$. H6 is genuinely needed: with $k=2$ and $a=(1,0)$ the decomposition would be $W=A_1$ and the chain would give no strictness. **CONFIRMED.**

## 6. The chain

- $a_i^3P(A_i)\le\lvert a_i\rvert^3\lvert P(A_i)\rvert\le M(n)\lvert a_i\rvert^3$, by $x\le\lvert x\rvert$ and Section 4. Summed: $P(W)\le M(n)\sum\lvert a_i\rvert^3$.
- $\sum\lvert a_i\rvert^3=\sum\lvert a_i\rvert a_i^2\le\max\lvert a_i\rvert\sum a_i^2=\max\lvert a_i\rvert$, then multiplied by $M(n)\ge0$.
- $M(n)\max\lvert a_i\rvert<M(n)$ needs $M(n)>0$ and Section 5.

The sign of each $a_i$ and each $P(A_i)$ is absorbed by the absolute values in the first step. Passage A's "strict only because of that" is exact: at $M(n)=0$, oddness would force $P\equiv0$ on the sphere, every unit $W$ would be a maximizer, and the chain would give only $\le$. H8 gives $P(W)=M(n)$, contradiction. **CONFIRMED.**

## 7. $M(n)>0$ against Proposition 2.25 as printed

- PDF page 23: $\theta_{k,l}=\sqrt2\cdot\sqrt{\tfrac{k-1}k\cdot\tfrac{l-1}l\cdot\tfrac{n-1}{n-2}}$ and $P(W_{S_{k,l}})=\theta_{k,l}$. The passage's formula is identical.
- $W_{S_{k,l}}=\widetilde W_{S_{k,l}}/\lVert\widetilde W_{S_{k,l}}\rVert$ is unit by definition, with $\lVert\widetilde W_{S_{k,l}}\rVert^2=\tfrac{kl}2\cdot\tfrac{k-1}{l-1}\cdot\tfrac{n-2}{n-1}>0$ at $k,l\ge2$. It is a Weyl operator because $\mathcal R_{S_{k,l}}$ is Einstein (Lemma 2.23) and the scalar part is removed.
- Every $n\ge4$ is realised by $(k,l)=(2,n-2)$. All three factors are positive at $k,l\ge2$, $n\ge4$, so $\theta_{k,l}>0$.
- *Screen of the imported value at $(2,2)$ by Lemma 2.22(b).* $\widetilde R$ has entries $\tfrac23$ at $(1,2),(3,4)$ and $-\tfrac13$ at the four mixed pairs. $(\widetilde R^2)_{12}=\tfrac29$ and $\widetilde W_{12}^2=\tfrac49$, sum $\tfrac23=\widetilde W_{12}$. $(\widetilde R^2)_{13}=-\tfrac49$ and $\widetilde W_{13}^2=\tfrac19$, sum $-\tfrac13=\widetilde W_{13}$. So $Q(\widetilde W)=\widetilde W=(k-1)\widetilde W$ as the proof says, and $\theta_{2,2}=1/\lVert\widetilde W\rVert=\sqrt{3/4}=\tfrac{\sqrt3}2$.

**CONFIRMED.**

## 8. The absolute-value remark

With $(a,b)=(\tfrac35,-\tfrac45)$, $P(A_1)=M$, $P(A_2)=-M$: $P(W)=\tfrac{27}{125}M+\tfrac{64}{125}M=\tfrac{91}{125}M$, and the signed bound $M(a^3+b^3)=\tfrac{27-64}{125}M=-\tfrac{37}{125}M$. Both numbers are exact, and $a^2+b^2=\tfrac{9+16}{25}=1$.

Whether pieces at exactly $\pm M$ with $A_1\circ A_2=0$ exist is not argued anywhere, and the remark does not need it: it shows the signed inequality is invalid as a step. The same failure appears at pieces $\pm p$ for any $p>0$, since $\tfrac{91}{125}p\le-\tfrac{37}{125}M$ is false, and disjoint-support pieces at $\pm p$ exist by the construction in Section 14. **CONFIRMED AS ALGEBRA.**

### 8.1 Withdrawn candidate: "the chain fails at any negative coefficient"

1. Locate: Passage A line 17, "with $a_i^3$ in place of $\lvert a_i\rvert^3$ the chain fails at any negative coefficient".
2. Exhibit: at $(\tfrac35,-\tfrac45)$ with $P(A_1)=P(A_2)=M$, the signed step reads $-\tfrac{37}{125}M\le-\tfrac{37}{125}M$, which holds. So the signed inequality does not fail for every choice of pieces.
3. Argue the opposite: "the chain fails" reads naturally as "the step is invalid", meaning some admissible piece values break it. With $a_j<0$, setting $P(A_j)=-M$ and the others to $M$ gives $\sum a_i^3P(A_i)-M\sum a_i^3=-2Ma_j^3>0$. So at every negative coefficient the step is invalid.

**Withdrawn**, the charitable reading is the natural one and is true.

## 9. "Criticality of the pieces is not needed" and "Nothing else is used"

Sections 3 to 6 use H2 to H7, oddness, total symmetry, and $M(n)>0$. No criticality of $A_i$, no padding, no monotonicity of $M$, no harmonic-square law, and no support dimension appears. **CONFIRMED.**

## 10. Criticality with Frobenius orthogonality versus $\circ$-orthogonality

The claim that the two hypotheses differ rests on "A run at $n=8$ found two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ with $\lVert A\circ B\rVert\approx0.664$, and a rotated $S^4\times S^4$ pair at $\approx0.273$", followed by "No closed-form witness is on file." On the brief's rule a claim supported only by a run is debt. What would have to be proved: a closed-form pair $A,B\in\mathcal W_n$, both unit and critical, with $\langle A,B\rangle=0$ and $A\circ B\ne0$.

*Screen, reported as a screen only.* In $\Lambda^+$ at $n=4$, for traceless symmetric $3\times3$ blocks Lemma 2.19 and Cayley–Hamilton give $X\circ Y=\tfrac32(XY+YX)-\mathop{\mathrm{tr}}(XY)I$, which reproduces Nienhaus's $Q(\mathop{\mathrm{diag}}(-1,2,-1))=\mathop{\mathrm{diag}}(-3,6,-3)$ on page 27. With $A'=3uu^T-I$, $B'=3vv^T-I$, $u=e_1$, $v=\tfrac1{\sqrt3}(1,1,1)$: $Q(A')=3A'$ and $Q(B')=3B'$, $\mathop{\mathrm{tr}}(A'B')=9(u\cdot v)^2-3=0$, and $A'B'+B'A'=\begin{pmatrix}0&1&1\\1&0&-2\\1&-2&0\end{pmatrix}\ne0$. The screen is consistent with the remark. It is not in the record, and the grade stands. The remark is non-load-bearing for L66. **HYPOTHESIS-DEBT.**

## 11. Passage C detail

- $\lvert P(W)\rvert\le\sum\lvert a_i\rvert^3\lvert P(A_i)\rvert$ is the triangle inequality on additivity, then Sections 4 to 6. It is two-sided and therefore implies Passage A's one-sided form. No finding.
- "The bound runs against $M(n)$ rather than against $\max_i\lvert P(A_i)\rvert$": with $m=\max_i\lvert P(A_i)\rvert$ the same chain gives $P(W)\le m\max\lvert a_i\rvert$, whose strict version $<m$ needs $m>0$ and at $m=0$ reads $0<0$. Exact.
- "Supplies no induction on $n$": the lemma's conclusion concerns $W$ only, and nothing in it bounds the support of any $A_i$. No finding.
- "$M(n)=\max\{P(A):\lVert A\rVert=1\}$ is the global maximum, positive because $S^k\times S^l$ with $k,l\ge2$ has $P=\theta_{k,l}>0$": Section 7.

**CONFIRMED.**

## 12. Passage C landscape

- Given $\tfrac1{\theta^2}=\tfrac1{\theta_A^2}+\tfrac1{\theta_B^2}$ with $\theta_A,\theta_B\ne0$, $\tfrac1{\theta^2}>\tfrac1{\theta_A^2}$, so $\theta^2<\theta_A^2$, and the same for $B$. So $\lvert\theta\rvert<\min(\lvert\theta_A\rvert,\lvert\theta_B\rvert)$ follows as algebra. The law is cited from a file outside the brief and its derivation is not under audit here.
- "As one coefficient tends to $1$, $P(W)$ tends to that piece's own value": at $k=2$, $a\to1$ forces $b^2=1-a^2\to0$, and additivity gives $P(W)=a^3P(A)+b^3P(B)\to P(A)$. Without criticality nothing ties $P(A)$ to $P(B)$, so the sharper bound cannot hold in general.

**CONFIRMED AS ALGEBRA.**

### 12.1 Withdrawn candidate: pieces with $\theta_A=0$

1. Locate: Passage C landscape, "At a critical point split into two critical pieces with $A\circ B=0$" states no condition $\theta_A\theta_B\ne0$.
2. Exhibit: I could not exhibit a unit critical Weyl operator with $Q(A)=0$ in closed form. At $n=4$ inside one block, $X^2+2\mathop{\mathrm{adj}}X=0$ with $\mathop{\mathrm{tr}}X=0$ forces the eigenvalues equal and hence $X=0$, so the $n=4$ block family supplies none.
3. Argue the opposite: the displayed law contains $\tfrac1{\theta_A^2}$ and $\tfrac1{\theta_B^2}$, so it presupposes both nonzero on its face.

**Withdrawn**, failing step 2, and the display itself carries the hypothesis.

### 12.2 Withdrawn candidate: $\sum a_i^2=1$ does not make $W$ unit

1. Locate: H5 constrains coefficients, and no clause asks $\langle A_i,A_j\rangle=0$, so $\lVert W\rVert^2=1+2\sum_{i<j}a_ia_j\langle A_i,A_j\rangle$ may differ from $1$.
2. Exhibit: nothing in the definition forces the cross terms to vanish.
3. Argue the opposite: the proof never uses $\lVert W\rVert=1$. It shows $P(W)<M(n)$ for every $\circ$-decomposable $W$, and a maximizer is unit by H8, so the conclusion stands for all of them.

**Withdrawn**, no step depends on it.

### 12.3 Withdrawn candidate: "maximizer" read as local

1. Locate: Passages A, B, C say "maximizer of $P$ on the unit sphere" without "global".
2. Exhibit: the proof only reaches $P(W)<M(n)$, which excludes global maximizers and says nothing about a local maximizer below $M(n)$.
3. Argue the opposite: Passage A defines $M(n)$ as "the global maximum", Passage C repeats it, and the Lean statement takes $P(W)=M$ with $M$ an upper bound. The written statement means global maximizer throughout.

**Withdrawn**, the reading is fixed by the passages.

## 13. The Lean statement

- `IsCircDecomposable T W`: `2 ≤ k`, `‖A i‖ = 1`, `∑ a i ^ 2 = 1`, `a i ≠ 0`, `W = ∑ a i • A i` match H3 to H6 and H2. H7 enters as `∀ X, i ≠ j → T X (A i) (A j) = 0`, which is $\langle X,A_i\circ A_j\rangle=0$ for all $X$ in Passage A's convention. The mathematical H7 implies it trivially at $T(X,Y,Z)=\langle X,Y\circ Z\rangle$.
- `Pf_additive` assumes only `hsym12 : T x y z = T y x z`, one transposition, and no symmetry in slots 2 and 3. The proof of `hmid` uses it exactly where Section 3 moves a slot, and `hinner` handles $j\ne l$ with `horth`. Because `horth` quantifies both orders of $(i,j)$, symmetry of $\circ$ is not needed. The Lean hypothesis is weaker than total symmetry, so the abstract theorem is more general than L66 needs.
- `no_maximizer_is_circDecomposable` takes `hMpos : 0 < M`, `hM : ∀ B, ‖B‖ = 1 → Pf T B ≤ M`, `hmax : Pf T W = M`, and concludes `¬ IsCircDecomposable T W`. Quantifiers match the statement: for the given $W$, no decomposition exists.
- What stays outside Lean and is discharged in the passages: that $\mathcal W_n$ with Frobenius norm instantiates `E`, that Hamilton's form instantiates `T` with `Pf = P`, total symmetry (Section 2), existence of the maximum (Section 4), and `hMpos` (Section 7).
- [L66.lean](../lean/HamiltonsCubic/Results/L66.lean)'s `strict_below` carries an extra binder `hbound : ∀ i, |a i| ≤ max |a j| |a k|`. It is satisfiable for every admissible family by taking $j$ an index of maximal $\lvert a_j\rvert$ and $k$ any other index, so it restricts nothing. `theta0_four`, `M4_exceeds`, `M4_ratio` check $\theta_4^2=\tfrac34<\tfrac32$, which L66's proof does not use. The second `example` in L66Statement inhabits the definition at the zero form on $\mathbb R^2$, which shows the definition is consistent and says nothing about $\mathcal W_n$.

I did not build either file. **CONFIRMED** at the level of the statement.

## 14. The boundary

- $n=4$: $M(4)\ge\theta_{2,2}=\tfrac{\sqrt3}2>0$. No finding.
- $k=2$, $a_1^2=a_2^2=\tfrac12$: $\max\lvert a_i\rvert=\tfrac1{\sqrt2}$ and $\sum\lvert a_i\rvert^3=\tfrac1{\sqrt2}<1$. No finding.
- Pieces with $P(A_i)<0$: absorbed by $a_i^3P(A_i)\le\lvert a_i\rvert^3\lvert P(A_i)\rvert$. No finding.
- $n\le3$: $\mathrm{Weyl}_n=0$, the unit sphere is empty and the statement is excluded by H1. No finding.
- $\ker W\ne0$ at a padded object: nothing in the proof reads the kernel or the support. *Screen:* pad $A,B$ of Section 3 from $\Lambda^2\mathbb R^4$ into $\Lambda^2\mathbb R^n$ by zeros (Nienhaus page 27 embeds $\mathrm{Weyl}_{n-1}\hookrightarrow\mathrm{Weyl}_n$). $AB=0$ persists, and $(A\#B)_{ab}$ needs $c_{acd}\ne0$ with $c,d$ in $\Lambda^2\mathbb R^4$, which forces $a\in\Lambda^2\mathbb R^4$, where the $n=4$ value is $0$. So padded $W_{S_{2,2}}=\tfrac1{\sqrt2}(A+B)$ is $\circ$-decomposable at every $n\ge4$, has kernel of dimension $\binom n2-6$ for $n\ge5$, and by L66 is no maximizer, consistent with $P=\tfrac{\sqrt3}2$ being the $n=4$ value and $M(n)$ being at least $M(4)$ by the same padding. Disjoint-block pieces at $n\ge8$ give $\circ$-orthogonal pairs with $P(A_1)=-P(A_2)=p$ for Section 8.
- Existence of a $\circ$-decomposable $W$ at each $n\ge4$: the padded screen above, so the lemma is not vacuous at any $n\ge4$.

**CONFIRMED.**

## 15. The brief's items, by number

1. Section 1. No finding.
2. Sections 2 and 3. Additivity needs one slot move beyond the symmetry of $\circ$, total symmetry supplies it, and Passage D's argument closes for both parts with the $\tfrac12$ as defined.
3. Section 4. No finding.
4. Section 6. No finding, strictness needs $M(n)>0$ as Passage A says.
5. Section 5. No finding.
6. Section 7. No finding, $(k,l)=(2,n-2)$, unit by construction, formula matches the PDF.
7. Section 8. Both numbers exact, existence of pieces at exactly $\pm M$ is unargued and unneeded, withdrawn candidate 8.1.
8. Sections 9 and 10. First two claims confirmed, the run-supported paragraph is HYPOTHESIS-DEBT.
9. Sections 11 and 12. Confirmed, the landscape consequences as algebra, withdrawn candidate 12.1.
10. Section 13. Lean uses a weaker symmetry hypothesis, enters H7 in the $\langle X,Y\circ Z\rangle$ convention for all $X$, proves the abstract implication, and takes maximality and $M>0$ as binders.
11. Section 14. No finding at any edge, and a $\circ$-decomposable $W$ exists at every $n\ge4$ by screen.

## 16. The standing list and the traps

1. Hypothesis inventory: Section 0.1. Unused: $\lVert W\rVert=1$, harmless. Used but unstated: none beyond the standard antisymmetry of $c$.
2. Quantifier order and scope: for each $n\ge4$ and each global maximizer $W$, no $(k,a,A)$ exists. The proof fixes an arbitrary decomposition. Lean has the same order. No finding.
3. Range edges: Section 14. No finding.
4. Subfamily used in general: no step is proven on a subfamily. The Nienhaus input is used only for its own family $S_{k,l}$, $k,l\ge2$, and only to show one positive value. No finding.
5. Lean: Section 13. No finding.
6. $\ker W\ne0$: Section 14, no finding.
7. Universal claim with no witness: the lemma is a universal negative. Sphere products: $W_{S_{2,2}}$ is decomposable and not a maximizer, consistent. Padded: same at every $n\ge4$. $\mathbb{CP}^2$ at $n=4$ lies in one block with $P=\sqrt{3/2}>\tfrac{\sqrt3}2$, consistent with $S^2\times S^2$ not being a maximizer. Diagonal: $W_{S_{k,l}}$ is diagonal in the standard basis and is covered by the same check. No finding.
8. Imported result's hypotheses checked against the object: Section 0.1 and Section 7. No finding.

## 17. What would break it

- A $\circ$-decomposable unit $W$ with $P(W)=M(n)$. Additivity plus the chain exclude it once total symmetry holds, so breaking the lemma requires breaking Section 2. I looked for an index configuration in the $\#$ part where the two $c$'s receive different permutations and found none: each argument occupies the same slot in both $c$'s.
- $M(n)=0$ at some $n\ge4$. Excluded by $\theta_{2,n-2}>0$ and the screen of $\theta_{2,2}$.
- A normalisation mismatch between Nienhaus's $P$ and the record's $P$ that flips a sign. Excluded by Lemma 2.22(b) returning $\mathrm{Id}^\#=(n-2)\mathrm{Id}$, and in any case $M(n)>0$ needs only $P\not\equiv0$, which a positive rescaling of $\#$ cannot destroy at $S_{2,2}$ where $Q(\widetilde W)=\widetilde W$ has both the $W^2$ and the $\#$ contributions of the same sign on the $(1,2)$ plane.

## 18. Verdict

**PROVEN.**

The HYPOTHESIS-DEBT in Section 10 sits on a remark that the proof does not use. At commit time git status showed no other staged files in the shared index, only this report as untracked.
