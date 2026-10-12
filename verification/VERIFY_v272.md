# Verifier v272, Lemma L66 (no maximizer is circ-decomposable): additivity, the coefficient chain, M(n) > 0, the Lean statement, and the side claims of Passages B and C

Cold brief ([BRIEF_L66.md](BRIEF_L66.md)). No numerical work, every value exact, no scripts. Log: [agent_logs/verify-L66-v272.log](../agent_logs/verify-L66-v272.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Passage A's pointer: the argument is the opening section of [support-dichotomy.md](../findings/support-dichotomy.md) | CONFIRMED |
| 2 | Additivity: $A_i\circ A_j=0$ for $i\ne j$ gives $P(W)=\sum_ia_i^3P(A_i)$, every cross term dying | CONFIRMED |
| 3 | Total symmetry of $T$, as cited by Passages B and D | CONFIRMED |
| 4 | The maximum exists, $P$ is odd, $\lvert P(A_i)\rvert\le M(n)$ | CONFIRMED |
| 5 | $M(n)>0$ for every $n$ with $\mathcal W_n\ne0$ | CONFIRMED (on a filed import the lemma does not cite) |
| 6 | The chain $\sum_ia_i^3P(A_i)\le M\sum_i\lvert a_i\rvert^3\le M\max_i\lvert a_i\rvert<M$ and $\max_i\lvert a_i\rvert<1$ | CONFIRMED |
| 7 | Passage B line 11: the witness at $(a,b)=(0.6,-0.8)$ | CONFIRMED AS ALGEBRA |
| 8 | Passage B line 15: criticality does not derive circ-orthogonality from Frobenius orthogonality (witnesses $0.664362$, $0.272738$) | HYPOTHESIS-DEBT |
| 9 | Passage B line 15: at $k=2$, criticality plus Frobenius orthogonality gives exact additivity, "strictly weaker than the hypothesis used here" | HYPOTHESIS-DEBT |
| 10 | Passage B line 17 and Passage C: $(S^4)^3=S^4\times S^8\oplus S^4\times S^4$ and the $\Lambda^+/\Lambda^-$ pair are circ-orthogonal splittings with full-dimension pieces | HYPOTHESIS-DEBT |
| 11 | Passage C: the absolute form $\lvert P(W)\rvert<M(n)$, and "reads $0<0$" against $\max_i\lvert P(A_i)\rvert$ | CONFIRMED |
| 12 | Passage C: at a decomposable critical point the harmonic-square law gives $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$ | HYPOTHESIS-DEBT |
| 13 | Passage C: sending one coefficient to $1$ sends $P(W)$ above $\min_i\lvert\theta_i\rvert$ "whenever the pieces differ" | CONFIRMED AS ALGEBRA |
| 14 | Passage F: [L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean) states and proves the lemma | CONFIRMED AS ALGEBRA (abstract core, the $\mathcal W_n$ instantiation is hypotheses, file read and not built) |

**Summary: the lemma's proof is correct link by link at every $n$ (vacuously at $n\le3$). Its only external fact, $M(n)>0$, holds by Nienhaus Prop 2.25 as filed. Four side remarks of Passages B and C, none used by the proof, carry hypothesis debt.**

**Overall verdict: PROVEN.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$ as symmetric operators on $\Lambda^2\mathbb R^n$, with the Frobenius inner product. It is finite-dimensional, it is $0$ for $n\le3$, and $n=4$ is the smallest $n$ with $\mathcal W_n\ne0$.
- $Q(W)=W^2+W^\#$ with $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ ([conventions.md](../findings/conventions.md) line 77), $c$ totally antisymmetric (line 61).
- $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ ([conventions.md](../findings/conventions.md) line 136). So $W\circ W=\tfrac12(Q(2W)-2Q(W))=Q(W)$ and $P(W)=\langle W,Q(W)\rangle=\langle W,W\circ W\rangle$.
- Two conventions for $T$ appear: Passage B's $T(X,Y,Z)=\langle X,Y\circ Z\rangle$ and Passage D's and C's $T(X,Y,Z)=\langle X\circ Y,Z\rangle$. They name the same form once $T$ is totally symmetric (claim 3). Below, $T$ is Passage B's.
- "$A_i\circ A_j=0$" is read in its weakest form, $\langle X,A_i\circ A_j\rangle=0$ for every $X\in\mathcal W_n$ (the projection of $A_i\circ A_j$ to $\mathcal W_n$ vanishes). The unprojected reading implies it, so the lemma proven under the weak reading covers both.
- A maximizer is a global maximizer of $P$ on the unit sphere of $\mathcal W_n$, and $M(n)$ is that maximum.

## Hypothesis inventory

| Hypothesis | Source | Used where | Satisfiable |
|---|---|---|---|
| $n$ arbitrary | statement | only through $\mathcal W_n$ | at $n\le3$ the statement is vacuous (no unit element, no maximizer, no decomposable $W$) |
| $k\ge2$ | statement | $\max_i\lvert a_i\rvert<1$ | yes |
| each $A_i$ unit in $\mathcal W_n$ | statement | $\lvert P(A_i)\rvert\le M(n)$ | yes for $n\ge4$ |
| $\sum_ia_i^2=1$ | statement | $\sum\lvert a_i\rvert^3\le\max\lvert a_i\rvert$ and $\max\lvert a_i\rvert<1$ | yes |
| every $a_i\ne0$, any sign | statement | $\max_i\lvert a_i\rvert<1$ | yes |
| $A_i\circ A_j=0$, $i\ne j$ | statement | additivity | the record names coordinate-disjoint blocks and the $\Lambda^+/\Lambda^-$ pair, neither with an argument in the passages (claim 10). Unsatisfiable would make the lemma vacuous, not false |
| $T$ totally symmetric (one transposition consumed) | imported, [second-order.md](../findings/second-order.md) line 63, [conventions.md](../findings/conventions.md) line 24 | killing $T(A_i,A_j,A_j)$ | true (claim 3) |
| $P$ odd | cubic homogeneity | $\lvert P(A_i)\rvert\le M$ | true |
| maximum attained | unstated: compact unit sphere, continuous $P$, $\dim\mathcal W_n<\infty$ | the definition of $M(n)$ and of "maximizer" | true for $n\ge4$ |
| $M(n)>0$ | imported, stated without citation | strictness of the last inequality | true at $n\ge4$ by [Nienhaus Prop 2.25](../references/nienhaus-2023-second-best-einstein/notes.md) (claim 5) |

Not required and not used: $\lVert W\rVert=1$ for a decomposable $W$ (the definition does not force Frobenius orthogonality of the $A_i$, and the proof bounds $P(W)$ for every decomposable $W$, unit or not), distinctness of the $A_i$, criticality of $W$ or of the pieces, support dimensions.

## 1. Passage A's pointer

Displayed at source: [support-dichotomy.md](../findings/support-dichotomy.md) lines 1-17 match Passage B verbatim, lines 33-37 match Passage A, [results.md](../results.md) lines 334 and 1096 match Passage C. The definition, theorem and proof sit at lines 3, 5 and 7-9, immediately under the file's title.

**Verdict: CONFIRMED.** One candidate withdrawn, 1.W below.

### 1.W Withdrawn

- **"Above every heading".** (1) Passage A: "the argument is the opening section of this file, above every heading". (2) Line 1 is itself a heading (`# Every maximiser is ...`), so nothing sits above every heading. (3) Charitable reading: under the file's title and above every section heading. The argument is exactly there. Withdrawn.

## 2. Additivity

Expand with trilinearity: $P(W)=T(W,W,W)=\sum_{i,j,l}a_ia_ja_l\,T(A_i,A_j,A_l)$, $T(A_i,A_j,A_l)=\langle A_i,A_j\circ A_l\rangle$. Every index triple falls in exactly one case.

- $j\ne l$: $\langle A_i,A_j\circ A_l\rangle=0$ by hypothesis at $X=A_i$.
- $j=l\ne i$: $T(A_i,A_j,A_j)=T(A_j,A_i,A_j)=\langle A_j,A_i\circ A_j\rangle=0$, using the transposition of slots 1 and 2 and then the hypothesis at $X=A_j$.
- $i=j=l$: $a_i^3T(A_i,A_i,A_i)=a_i^3P(A_i)$.

So $P(W)=\sum_ia_i^3P(A_i)$, every cross term dead. No Frobenius orthogonality, no criticality, no restriction on $k$ enters. Passage B's account ("dies only after moving the first slot to $\langle A_j,A_i\circ A_j\rangle=0$") is this case analysis.

**Verdict: CONFIRMED.** Passage C's shorter phrasing is candidate 2.W.

### 2.W Withdrawn

- **Passage C omits the symmetry step.** (1) Passage C: "every cross term $T(A_i,A_j,\cdot)=\langle A_i\circ A_j,\cdot\rangle$ vanishes, so $P(W)=\sum_ia_i^3P(A_i)$". (2) With C's $T(x,y,z)=\langle x\circ y,z\rangle$ the terms $T(A_i,A_i,A_l)=\langle Q(A_i),A_l\rangle$, $l\ne i$, are not of the form $T(A_i,A_j,\cdot)$ with $i\ne j$. (3) Charitable reading: C's $T$ is the record's fully symmetric form (Passage D, conventions line 24), so $T(A_i,A_i,A_l)=T(A_i,A_l,A_i)$ is such a term. The sentence is then complete. Withdrawn.

## 3. Total symmetry of $T$

**What Passage B cites.** "Symmetry in the last two slots is free from the polarisation" holds: $\circ$ is symmetric by its definition. "Symmetry in the first holds because $\nabla P=3Q$, recorded at second-order.md."

**The implication is correct.** $P(W)=\langle W,W\circ W\rangle$ gives $dP_W(Z)=\langle Z,Q(W)\rangle+2\langle W,W\circ Z\rangle$. So $\nabla P=3Q$ is equivalent to $T(W,W,Z)=T(Z,W,W)$ for all $W,Z$. Polarise in $W$ and write $a,b,c$ for $T$ with $X$, $Y$, $Z$ in the first slot (each already symmetric in its last two). This gives $a+b=2c$, and by the same identity at the other two orderings $b+c=2a$ and $a+c=2b$. Subtracting, $a=b=c$. So $\nabla P=3Q$ implies total symmetry, and conversely.

**The cited derivation of $\nabla P=3Q$, read at source.** [second-order.md](../findings/second-order.md) line 63 opens "$P$ is a cubic form, so $\nabla P=3Q(W)$". Cubicity alone does not give it. Closed form in $\mathbb R^2$: $Q(x,y)=(0,x^2)$, $P=\langle W,Q(W)\rangle=x^2y$, $\nabla P=(2xy,x^2)\ne3Q$. The same line, however, carries the direct argument: "$T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$." [conventions.md](../findings/conventions.md) line 24 repeats it. Checked link by link.

- $W^2$ part: $X\circ Y$ contributes $\tfrac12(XY+YX)$, so $\langle X\circ Y,Z\rangle_{W^2}=\tfrac12(\operatorname{tr}XYZ+\operatorname{tr}YXZ)$. Cyclicity of the trace gives $\operatorname{tr}XZY=\operatorname{tr}YXZ$ and $\operatorname{tr}ZXY=\operatorname{tr}XYZ$, so the expression is invariant under both transpositions $X\leftrightarrow Y$ and $Y\leftrightarrow Z$.
- $\#$ part: $E(X,Y,Z)=\sum c_{acd}c_{bef}X_{ce}Y_{df}Z_{ab}$. For $X\leftrightarrow Z$, rename $a\leftrightarrow c$, $b\leftrightarrow e$: $c_{cad}c_{ebf}=(-c_{acd})(-c_{bef})$, and $X,Z$ symmetric, so $E(Z,Y,X)=E(X,Y,Z)$. The transposition $X\leftrightarrow Y$ is the same computation with $c\leftrightarrow d$, $e\leftrightarrow f$. Two transpositions generate $S_3$.

So total symmetry is established at the cited file, and $\nabla P=3Q$ follows from it. The fact the proof consumes (one transposition) is carried.

**Verdict: CONFIRMED.** The circular ordering is candidate 3.W.

### 3.W Withdrawn

- **Circular citation.** (1) Passage B: "symmetry in the first holds because $\nabla P=3Q$", and the source's "$P$ is a cubic form, so $\nabla P=3Q(W)$". (2) $\nabla P=3Q$ is equivalent to the symmetry it is cited for, and cubicity does not yield it (the $\mathbb R^2$ example above). (3) Charitable reading: the pointer to second-order.md lands on a line that proves full symmetry directly from the trace and the structure constants, from which $\nabla P=3Q$ follows. The sentence is then true, and only the order of the two facts is reversed in B's wording. Withdrawn. A reader following B's "because" to the words "$P$ is a cubic form" finds a non sequitur, so the wording deserves a fix.

## 4. Existence of the maximum, oddness, $\lvert P(A_i)\rvert\le M(n)$

- For $n\ge4$ the unit sphere of the finite-dimensional $\mathcal W_n$ is compact and nonempty, and $P$ is a polynomial, so the maximum is attained. For $n\le3$ it does not exist, and no statement about it is needed (section 6, edges).
- $P(-W)=-P(W)$ by homogeneity of degree $3$.
- For unit $A$: $P(A)\le M$, and $-P(A)=P(-A)\le M$ since $\lVert-A\rVert=1$. So $\lvert P(A)\rvert\le M$. This holds for padded, non-critical and negative-$P$ pieces alike.

**Verdict: CONFIRMED.**

## 5. $M(n)>0$

Passage B: "$M(n)>0$, since any sphere product attains a positive value", with no citation, and the brief states no source is filed for the lemma. It is load-bearing: were $P\equiv0$ on some $\mathcal W_n$ with $n\ge4$, polarisation would give $T\equiv0$, so $\circ\equiv0$ on $\mathcal W_n$, every unit point would be a maximizer, and any $W=\tfrac35A_1+\tfrac45A_2$ with $A_1\perp A_2$ unit would be a decomposable maximizer. So the lemma is false at such an $n$.

**Read at source.** [Nienhaus notes](../references/nienhaus-2023-second-best-einstein/notes.md) line 19, Proposition 2.25: "$W_{S_{k,l}}^2+W_{S_{k,l}}^\#=\theta_{k,l}\cdot W_{S_{k,l}}$, where $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}$. Moreover, $P(W_{S_{k,l}})=\theta_{k,l}$." The notes record it as unconditional (line 112). Hypotheses against the object: $k+l=n$, and $\theta_{k,l}>0$ exactly when $k,l\ge2$, available for every $n\ge4$ ($k=2$, $l=n-2$). $P(W)=\theta$ with $Q(W)=\theta W$ forces $\lVert W\rVert=1$, so this is a unit element with positive $P$. The normalisation of $\#$ agrees with the record's by [conventions.md](../findings/conventions.md) line 75 ($\#\mapsto c\#$ matches $\theta_0$ only at $c=1$). [problem.md](../findings/problem.md) line 168 carries the squared form from the same proposition.

**Verdict: CONFIRMED (on a filed import the lemma does not cite).** The citation should be added. One candidate withdrawn, 5.W.

### 5.W Withdrawn

- **"Any sphere product".** (1) "since any sphere product attains a positive value". (2) $S^1\times S^{n-1}$ is a sphere product with $\theta_{1,n-1}=0$ (and zero Weyl tensor). (3) Charitable reading: any sphere product with a nonzero Weyl tensor, $k,l\ge2$, since only unit elements of $\mathcal W_n$ are in play. One such product suffices. Withdrawn.

## 6. The chain, and the edges

For each $i$: $a_i^3P(A_i)\le\lvert a_i\rvert^3\lvert P(A_i)\rvert\le\lvert a_i\rvert^3M$. Summing, $P(W)\le M\sum_i\lvert a_i\rvert^3$. Next $\lvert a_i\rvert^3=\lvert a_i\rvert a_i^2\le(\max_j\lvert a_j\rvert)a_i^2$, so $\sum_i\lvert a_i\rvert^3\le\max_j\lvert a_j\rvert$, and $M\ge0$ preserves the direction. If $\lvert a_{i_0}\rvert=1$ then $\sum_{i\ne i_0}a_i^2=0$, contradicting $k\ge2$ and every $a_i\ne0$. So $\max_i\lvert a_i\rvert<1$, and $M>0$ gives $M\max_i\lvert a_i\rvert<M$. Hence $P(W)<M(n)$ and $W$ is no maximizer.

**Edges.**

| Edge | Result |
|---|---|
| $k=2$ | every step holds, $\max(\lvert a\rvert,\lvert b\rvert)<1$ from $a,b\ne0$ |
| $n\le3$ | $\mathcal W_n=0$: no unit $A_i$, no maximizer, statement vacuous. The proof's "$M(n)>0$" is then undefined but never invoked |
| $n=4$ | $M(4)\ge\theta_{2,2}=\sqrt{2\cdot\tfrac12\cdot\tfrac12\cdot\tfrac32}=\sqrt{3/4}>0$, chain applies |
| negative coefficient | handled by the absolute values in the first step |
| piece with $P(A_i)\le0$ | $a_i^3P(A_i)\le\lvert a_i\rvert^3\lvert P(A_i)\rvert$ still holds. All pieces at $P=0$ give $P(W)=0<M$ |
| $\ker W\ne0$ (padded) | supports never enter, $\lvert P(A_i)\rvert\le M(n)$ is taken in $\mathcal W_n$ itself |
| repeated pieces $A_i=A_j$, $i\ne j$ | forces $Q(A_i)$ orthogonal to $\mathcal W_n$, the expansion is unchanged |
| $W$ non-unit | the bound holds for every decomposable $W$ |

**Verdict: CONFIRMED.**

## 7. The witness at $(a,b)=(0.6,-0.8)$

Exact values: $a=\tfrac35$, $b=-\tfrac45$, $a^2+b^2=1$. Pieces at $P(A_1)=M$, $P(A_2)=-M$: $P(W)=\tfrac{27}{125}M+(-\tfrac{64}{125})(-M)=\tfrac{91}{125}M=0.728M$. The chain without absolute values bounds by $M(a^3+b^3)=\tfrac{27-64}{125}M=-\tfrac{37}{125}M=-0.296M$. Passage B's figures are these in units of $M$. "Fails at any negative coefficient": for any admissible coefficients with some $a_i<0$, values $P_i=M\operatorname{sgn}a_i$ give $\sum a_i^3P_i=M\sum\lvert a_i\rvert^3>M\sum a_i^3$.

The witness is an instance of the inequality step over real values $P_i\in[-M,M]$. Realising it by a circ-orthogonal pair in some $\mathcal W_n$ at $P=\pm M(n)$ is not shown and is not needed to show that the modified step is not a valid inference.

**Verdict: CONFIRMED AS ALGEBRA.**

## 8. "Criticality does not derive circ-orthogonality from ordinary orthogonality"

The support is two decimals, $\lVert A\circ B\rVert=0.664362$ (padded $W_{\mathbb{CP}^2}$ copies at $n=8$) and $0.272738$ (a rotated $S^4\times S^4$ pair). No closed form, no argument. The lemma does not use the claim.

**Verdict: HYPOTHESIS-DEBT.** What would have to be exhibited: two critical, Frobenius-orthogonal unit $A,B\in\mathcal W_n$ with $A\circ B\ne0$ in closed form.

## 9. "At $k=2$, criticality plus ordinary orthogonality already gives exact additivity"

No argument appears in the passages. The lemma does not use it. The comparison "strictly weaker than the hypothesis used here" also carries no witness in either direction: nothing on file exhibits non-critical circ-orthogonal pieces (needed for "circ-orthogonality does not imply criticality plus orthogonality"), and the converse direction rests on claim 8's decimals.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: that $Q(A)=\theta_AA$, $Q(B)=\theta_BB$ and $\langle A,B\rangle=0$ make both mixed terms $T(A,A,B)$ and $T(A,B,B)$ vanish. For "strictly weaker": a closed-form circ-orthogonal pair with a non-critical piece, and claim 8's witness.

## 10. The support examples

**$(S^4)^3=S^4\times S^8\oplus S^4\times S^4$.** A screen of the linear identity only: with blocks $B_1,B_2,B_3$ of size $4$, $S^8$ on $B_2\cup B_3$ and $S^4\times S^4$ on $B_2,B_3$ padded, the curvature operators are block-constant diagonal. The kernel of the Weyl projection is $\{h\owedge g\}$, which on $e_i\wedge e_j$ acts by $h_i+h_j$. Requiring $R_{(S^4)^3}-\alpha R_{S^4\times S^8}-\beta R_{S^4\times S^4}=h\owedge g$ with $h$ constant $x_s$ on $B_s$ gives: within $B_1$, $2x_1=1-\alpha$; within $B_2$ and $B_3$, $2x_2=2x_3=1-\alpha-\beta$; across $B_1B_2$ and $B_1B_3$, $x_1+x_2=x_1+x_3=0$; across $B_2B_3$, $x_2+x_3=-\alpha$. So $\alpha=\tfrac12$, $\beta=1$, and $W_{(S^4)^3}=\tfrac12W_{S^4\times S^8}+W_{S^4\times S^4}$ holds (raw, unit-curvature factors). The span identity is not refuted. **The circ-orthogonality of the two pieces, which share eight coordinates, has no argument in the passages.** $W_{S^4\times S^8}$ has support $12$.

**The $\Lambda^+/\Lambda^-$ pair.** Passage E asserts $W^+\circ W^-=0$ with no argument in lines 356-359. "$n_i=n=4$" follows from $\mathcal W_3=0$: a nonzero element of $\mathcal W_4$ cannot be padded from fewer coordinates.

Passage C's "a circ-decomposable $W$ can have summands of full dimension $n$, so it supports no induction on $n$" rests on these same two examples. None of this is used by the proof.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: $W_{S^4\times S^8}\circ W_{S^4\times S^4}=0$ at $n=12$, and $W^+\circ W^-=0$ on $\mathcal W_4=\mathcal W^+\oplus\mathcal W^-$ (both the $W^+W^-+W^-W^+$ part and the $W^+\#W^-$ part).

## 11. Passage C's absolute form and "$0<0$"

$\lvert P(W)\rvert=\lvert\sum_ia_i^3P(A_i)\rvert\le\sum_i\lvert a_i\rvert^3\lvert P(A_i)\rvert\le M\max_i\lvert a_i\rvert<M$. This is correct and stronger than Passage B's $P(W)<M$ (it also excludes global minimizers, $P=-M$). With $m=\max_i\lvert P(A_i)\rvert$ in place of $M$, the last step reads $m\max_i\lvert a_i\rvert<m$, which is $0<0$ when $m=0$. The sentence is conditional and asserts no such splitting exists.

**Verdict: CONFIRMED.**

## 12. The harmonic-square clause

Passage C: "At a decomposable critical point the harmonic-square law $\frac1{\theta^2}=\sum_i\frac1{\theta_i^2}$ gives the sharper $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$". Passage E, read at [nondegeneracy.md](../findings/nondegeneracy.md) lines 356-360: the law is introduced for **disjoint coordinate blocks**, extended by assertion to any pair with $W_A\circ W_B=0$, and "criticality forces $\theta=a\theta_A=b\theta_B$" has no derivation. Line 360 supports it by "verified at twenty-five held-out block sums to $9\times10^{-16}$", a run.

Given $\theta=a_i\theta_i$ for every $i$ with $\theta\ne0$: $a_i^2=\theta^2/\theta_i^2$ and $\sum a_i^2=1$ give the law, and $k\ge2$ gives $1/\theta^2>1/\theta_i^2$, so $\lvert\theta\rvert<\lvert\theta_i\rvert$ for every $i$. That algebra is sound. The premise is the debt. The clause also leaves open whether "critical" means $W$ or every piece, what $\theta_i$ is for a non-critical piece, the case $\theta=0$, and Frobenius orthogonality of the pieces, which circ-decomposability does not state. The lemma does not use the clause.

**Verdict: HYPOTHESIS-DEBT.** What would have to be proved: that $Q(W)=\theta W$ with $W=\sum_ia_iA_i$ circ-decomposable forces $\theta=a_i\theta_i$ for every $i$, with $\theta_i$ defined for each piece, under whatever orthogonality of the pieces that needs.

## 13. "Sending one coefficient to $1$"

With the pieces fixed, circ-orthogonality is independent of the coefficients, so every admissible coefficient vector gives a decomposable $W$ with $P(W)=\sum_ia_i^3P(A_i)$. Letting $a_1\to1$ with the others nonzero and tending to $0$, $P(W)\to P(A_1)$. Reading $\theta_i:=P(A_i)$ and choosing the piece of largest $\lvert\theta_i\rvert$: if the $\lvert\theta_i\rvert$ are not all equal, $\lvert P(W)\rvert>\min_i\lvert\theta_i\rvert$ for $a_1$ near $1$. So $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$ fails without criticality, as C says.

**Verdict: CONFIRMED AS ALGEBRA.** One candidate withdrawn, 13.W.

### 13.W Withdrawn

- **"Whenever the pieces differ".** (1) "above $\min_i\lvert\theta_i\rvert$ whenever the pieces differ". (2) Pieces with $\theta_2=-\theta_1$ differ, yet $\lvert P(W)\rvert\to\lvert\theta_1\rvert=\min_i\lvert\theta_i\rvert$, never above. Replacing $A_2$ by $-A_2$ in any circ-orthogonal pair with $P(A_1)=P(A_2)$ produces this, but no such pair with an argument is on file (disjoint-block circ-orthogonality is itself asserted in Passage E only), so the exhibit is conditional. (3) Charitable reading: "differ" means the $\lvert\theta_i\rvert$ differ, and "above" compares absolute values. The sentence holds under that reading. Withdrawn, on steps 2 and 3.

## 14. The Lean statement

[L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean), read in full. Not built: this verifier runs no computation.

- **What it states.** Over any real normed space $E$ with a trilinear $T$, $P X=T\,X\,X\,X$. `IsCircDecomposable` carries all five clauses, with circ-orthogonality encoded as `T X (A i) (A j) = 0` for every `X` and $i\ne j$. `no_maximizer_is_circDecomposable` assumes `hsym12` (swap of slots 1 and 2), `0 < M`, `M` an upper bound on the unit sphere, `‖W‖ = 1` and `Pf T W = M`, and concludes that $W$ is not decomposable.
- **Which symmetry.** Only the transposition of slots 1 and 2, which is exactly what section 2 consumes. Symmetry of slots 2 and 3 is not needed because the orthogonality hypothesis is stated for the ordered pair in slots 2 and 3 and every $i\ne j$.
- **How $\lvert P(A_i)\rvert\le M$ enters.** `habs`, from `hM` at $A_i$ and at $-A_i$ plus oddness `hodd`, proved from trilinearity.
- **Encoding against the record.** Under Passage B's $T(X,Y,Z)=\langle X,Y\circ Z\rangle$, `T X (A i) (A j) = 0` for all `X` is the weak reading of $A_i\circ A_j=0$ fixed in section 0. It is faithful, and $P=\langle W,W\circ W\rangle=T(W,W,W)$ matches `Pf`.
- **What is not formalised, and says so.** $\mathcal W_n$, $Q$, $\circ$, total symmetry of the record's $T$, $M(n)>0$ and existence of the maximum all enter as hypotheses. The file proves the lemma's algebraic core. It does not prove the lemma about $\mathcal W_n$.
- **Non-vacuity.** The example uses the zero form, so it shows the definition is satisfiable while `0 < M` fails. The theorem's hypotheses are jointly satisfiable in general ($E=\mathbb R$, $T(x,y,z)=xyz$, $M=1$, $W=1$), which the file does not display.
- **The absolute-value witness** is checked as exact rationals, $\tfrac{91}{125}M$ against $-\tfrac{37}{125}M$, agreeing with section 7.
- The file's "verbatim" quotation of the proof carries "`---` the cross term" and "and `---` the part that widens the reach `---`", where the current source reads ", the cross term" and "(the part that widens the reach)". The quotation is stale. The mathematics is unchanged.

**Verdict: CONFIRMED AS ALGEBRA.**

## Structured families against every universal sentence

| Universal sentence | Diagonal | Padded | Sphere products | $\mathbb{CP}^2$ | $\Lambda^+/\Lambda^-$ |
|---|---|---|---|---|---|
| no maximizer is decomposable | no conflict: the proof is uniform in $W$ | two coordinate-disjoint padded copies at $n=8$ (if circ-orthogonal) give $P=\sqrt{3/2}(a^3+b^3)<\sqrt{3/2}\le M(8)$, consistent | $(S^4)^3$, if its splitting is circ-orthogonal, gives $P<M(12)$, consistent | no conflict: the lemma only says $W_{\mathbb{CP}^2}$, if a maximizer, admits no circ-orthogonal splitting, and no splitting of it is on file | $aW^++bW^-$ with $ab\ne0$ has $P=a^3P(W^+)+b^3P(W^-)<M(4)$, consistent |
| $P$ additive on circ-orthogonal splittings | no exception | no exception, supports unused | no exception | no exception | no exception |
| $\lvert P(A_i)\rvert\le M(n)$ for unit $A_i$ | holds | holds, $P$ unchanged by padding and $M(n)$ taken in $\mathcal W_n$ | holds | holds | holds |
| "any sphere product attains a positive value" | n/a | padded products keep $\theta_{k,l}$ | fails literally at $k=1$ only (5.W) | n/a | n/a |

No universal sentence of the proof fails on any family.

## Falsifiers named, and the search for each

| Claim | Falsifying object | What was done |
|---|---|---|
| lemma | $n\ge4$ with $P\equiv0$ on $\mathcal W_n$ (then decomposable maximizers exist, section 5) | excluded at every $n\ge4$ by Nienhaus Prop 2.25 read at source |
| additivity | a pair with $\langle X,A_i\circ A_j\rangle=0$ for all $X$ and $\langle A_i,Q(A_j)\rangle\ne0$, requiring $T$ not symmetric in slots 1 and 2 | total symmetry checked term by term for the $W^2$ and $\#$ parts |
| chain | admissible coefficients with $\sum\lvert a_i\rvert^3\ge1$, or $\max\lvert a_i\rvert=1$ | both excluded by the two-line arguments in section 6 |
| $\lvert P(A_i)\rvert\le M$ | a unit $A$ with $P(A)<-M$ | excluded by oddness |
| claim 8 | a critical Frobenius-orthogonal pair in closed form with $A\circ B=0$ always | none constructed. The claim has no closed-form support either way |
| claim 9 | critical orthogonal $A,B$ with $T(A,A,B)\ne0$ | not constructed. The claim has no argument on file |
| claim 10 | $W_{S^4\times S^8}\circ W_{S^4\times S^4}\ne0$, or $W^+\circ W^-\ne0$ | the span identity for $(S^4)^3$ screened by hand and holds. Circ-orthogonality not settled, no argument on file |
| claim 12 | a decomposable critical $W$ with $\lvert\theta\rvert\ge\min_i\lvert\theta_i\rvert$ | not constructed. The premise $\theta=a_i\theta_i$ is asserted and run-supported only |
| claim 13 | pieces with $\lvert\theta_i\rvert$ unequal and $\lvert P(W)\rvert\le\min\lvert\theta_i\rvert$ as $a_1\to1$ | excluded by continuity |
| Lean | a mismatch between `T X (A i) (A j) = 0` and $A_i\circ A_j=0$ | none: the encoding is the weak reading, implied by both readings |

## Overall verdict

**PROVEN.** The lemma as stated in Passages A, B and C holds at every $n$ by the argument on file, with the one external fact $M(n)>0$ carried by Nienhaus Prop 2.25, which the lemma should cite. The hypothesis debts sit in side remarks (claims 8, 9, 10, 12) that the proof does not use.
