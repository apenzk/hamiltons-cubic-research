# Verifier v273, Lemma L66: additivity on a circ-orthogonal splitting, the chain P(W) < M(n), M(n) > 0, and the side claims of Passages B and C

The brief was cold. No numerical work was done, every value below is exact, and no script was written or run. Log: [agent_logs/verify-L66-v273.log](../agent_logs/verify-L66-v273.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | Passage A's pointer: the argument is the opening section of [support-dichotomy.md](../findings/support-dichotomy.md) | CONFIRMED |
| 2 | Additivity $P(W)=\sum_ia_i^3P(A_i)$ from $A_i\circ A_j=0$, and the total symmetry of $T$ it uses | CONFIRMED |
| 3a | The maximum $M(n)$ exists, $P$ is odd, $\lvert P(A_i)\rvert\le M(n)$ | CONFIRMED |
| 3b | $M(n)>0$, "since any sphere product attains a positive value" | HYPOTHESIS-DEBT |
| 4 | The chain $\sum_ia_i^3P(A_i)\le M\sum_i\lvert a_i\rvert^3\le M\max_i\lvert a_i\rvert<M$ and $\max_i\lvert a_i\rvert<1$ | CONFIRMED |
| 5 | The witness at $(a,b)=(0.6,-0.8)$ and "the chain fails at any negative coefficient" | CONFIRMED AS ALGEBRA |
| 6a | "Criticality does not derive $\circ$-orthogonality", with its two decimal witnesses | HYPOTHESIS-DEBT |
| 6b | "At $k=2$, criticality plus ordinary orthogonality already gives exact additivity", "strictly weaker" | HYPOTHESIS-DEBT |
| 7 | The support examples $(S^4)^3=S^4\times S^8\oplus S^4\times S^4$ and the $\Lambda^+/\Lambda^-$ pair as $\circ$-orthogonal splittings | HYPOTHESIS-DEBT |
| 8a | Passage C's $\lvert P(W)\rvert<M(n)$ and "reads $0<0$" | CONFIRMED |
| 8b | Passage C's harmonic-square clause $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$ against Passage E | HYPOTHESIS-DEBT |
| 8c | "Sending one coefficient to $1$ ... above $\min_i\lvert\theta_i\rvert$ whenever the pieces differ" | CONFIRMED (charitable reading, candidate withdrawn) |
| 8d | "Summands of full dimension $n$, so it supports no induction on $n$" | HYPOTHESIS-DEBT |
| 9 | [L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean) states and proves the lemma | CONFIRMED AS ALGEBRA (abstract core only, not the lemma on $\mathcal W_n$) |
| 10 | Boundary: $k=2$, negative coefficient, $P(A_i)\le0$, smallest $n$ with $\mathcal W_n\ne0$ | CONFIRMED, with 3b's debt at $n=4$ |

**Summary.** The written chain is correct link by link and uses exactly one input the passages do not carry with an argument, $M(n)>0$ (equivalently $P\not\equiv0$ on $\mathcal W_n$ for $n\ge4$), so the lemma stands as HYPOTHESIS-DEBT on that single sentence, while every side claim that is debt is illustrative and unused by the proof.

## 0. Conventions, fixed once

- $\mathcal W_n=\mathrm{Weyl}_n$, symmetric operators on $\Lambda^2\mathbb R^n$ with the Frobenius inner product, finite dimensional, $\dim\mathcal W_n=\tfrac{n(n+1)(n+2)(n-3)}{12}$, which is $0$ for $n\le3$ and $10$ at $n=4$.
- $Q$ is a homogeneous quadratic map, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ ([conventions.md:136](../findings/conventions.md#L136)), so $X\circ X=\tfrac12(Q(2X)-2Q(X))=Q(X)$ and $\circ$ is symmetric and bilinear.
- $T$ is the trilinear form with $\circ$ in two slots. Passage B writes $T(X,Y,Z)=\langle X,Y\circ Z\rangle$, Passage D and results.md write $\langle X\circ Y,Z\rangle$. These agree once $T$ is totally symmetric (Section 2), and I use Passage B's form below.
- $P(W)=\langle W,Q(W)\rangle=\langle W,W\circ W\rangle=T(W,W,W)$.
- "Maximizer" is a global maximizer of $P$ on the unit sphere, per the brief.
- Line numbers of [support-dichotomy.md](../findings/support-dichotomy.md) are file lines: the proof is line 7, the witness line 11, the criticality paragraphs lines 13 and 15, "Nothing else is used" line 17, the numbered block lines 33-37. Every quotation in the brief was compared against those lines, [results.md:334](../results.md#L334), [results.md:1096](../results.md#L1096), [conventions.md:24](../findings/conventions.md#L24), [conventions.md:136](../findings/conventions.md#L136), [second-order.md:63](../findings/second-order.md#L63) and [nondegeneracy.md:356-359](../findings/nondegeneracy.md#L356), and every one matches verbatim.

## Hypothesis inventory

| Hypothesis | Source | Used where | Stated? | Satisfiable? |
|---|---|---|---|---|
| $k\ge2$ | statement | $\max_i\lvert a_i\rvert<1$ | yes | yes |
| each $A_i$ unit | statement | $\lvert P(A_i)\rvert\le M(n)$ | yes | yes for $n\ge4$, empty for $n\le3$ |
| $\sum_ia_i^2=1$ | statement | $\sum\lvert a_i\rvert^3\le\max\lvert a_i\rvert$, $\max\lvert a_i\rvert<1$ | yes | yes |
| every $a_i\ne0$ | statement | $\max\lvert a_i\rvert<1$ | yes | yes |
| $A_i\circ A_j=0$, $i\ne j$ | statement | additivity | yes | on the record's objects, asserted (Passage E, and Passage B line 17) with no argument on file, see Section 7 |
| $W$ a maximizer | statement | only $P(W)=M(n)$ is used, $\lVert W\rVert=1$ is never used | yes | yes, by compactness |
| $\mathcal W_n$ finite dimensional, $P$ continuous, so $M(n)$ exists | imported | definition of $M(n)$ | unstated, elementary | yes |
| $Q$ homogeneous quadratic, so $X\circ X=Q(X)$ and $P=T(W,W,W)$ | imported, [conventions.md:136](../findings/conventions.md#L136) | additivity | unstated, immediate from the polarisation | yes |
| total symmetry of $T$ | imported, [second-order.md:63](../findings/second-order.md#L63), [conventions.md:24](../findings/conventions.md#L24) | the cross term $T(A_i,A_j,A_j)$ | yes | yes, argued at source |
| $P$ odd | imported | $\lvert P(A_i)\rvert\le M(n)$ | yes | yes, $P$ is cubic |
| $M(n)>0$ | imported, unfiled | strictness of the last inequality | yes, with an unfiled justification | HYPOTHESIS-DEBT, Section 3 |
| $n\ge4$ | implicit | $M(n)$ defined | unstated | for $n\le3$ the statement is vacuous (no unit elements, no maximizer) |

The Frobenius orthogonality of the pieces is neither assumed nor used. Consequently $\lVert\sum_ia_iA_i\rVert$ need not be $1$, and the statement's reach is to those decompositions that happen to land on the unit sphere. This is harmless: the chain bounds $P(W)$ for every decomposable $W$, unit or not.

## 1. Passage A's pointer

Passage A (line 35) says "the argument is the opening section of this file, above every heading". Lines 1-17 are the definition, theorem and proof, and the numbered block begins at line 33.

Candidate: line 1 is itself a heading (`# Every maximiser is ...`), so the argument sits below a heading, not above every heading. (1) Located at line 35. (2) Line 1 is an H1 heading and the proof is line 7. (3) Charitable reading: the H1 is the file title and "above every heading" means above every section heading of the body, which the argument is relative to the L66 block at line 33. I did not open lines 19-31 per the brief, so whether a section heading intervenes there is unchecked, and it does not matter: the argument is at the file's opening. **Withdrawn** under the charitable reading.

**Verdict: CONFIRMED.**

## 2. Additivity and the total symmetry of $T$

**The expansion.** Trilinearity gives $P(W)=T(W,W,W)=\sum_{i,j,l}a_ia_ja_lT(A_i,A_j,A_l)$. Sort the index triples.

- $j\ne l$: $T(A_i,A_j,A_l)=\langle A_i,A_j\circ A_l\rangle=0$ directly.
- $j=l\ne i$: $T(A_i,A_j,A_j)=\langle A_i,Q(A_j)\rangle$. Swapping slots 1 and 2 gives $T(A_j,A_i,A_j)=\langle A_j,A_i\circ A_j\rangle=0$.
- $i=j=l$: $a_i^3T(A_i,A_i,A_i)=a_i^3P(A_i)$.

Every cross term dies, so $P(W)=\sum_ia_i^3P(A_i)$. The step uses exactly the swap of the first two slots (with $\circ$ in slots 2 and 3) and nothing about criticality, as Passage B line 13 says. **"Criticality never enters"** is confirmed.

**Is total symmetry established by what is cited?** Passage B line 7 cites "symmetry in the first holds because $\nabla P=3Q$, recorded at [second-order.md](../findings/second-order.md)".

- The implication "$\nabla P=3Q\Rightarrow$ total symmetry" holds. $dP_W(H)=\langle H,Q(W)\rangle+2\langle W,W\circ H\rangle$, so $\nabla P=3Q$ says $T(W,W,H)=T(H,W,W)$ for all $W,H$. Polarising in $W$ and writing $u=T(X,Y,Z)$, $v=T(Y,X,Z)$, $w=T(Z,X,Y)$ (each symmetric in its last two slots) gives $u+v=2w$, $v+w=2u$, $u+w=2v$, whose only solution is $u=v=w$.
- Candidate on the source. [second-order.md:63](../findings/second-order.md#L63) opens "$P$ is a cubic form, so $\nabla P=3Q(W)$". (1) Located there. (2) Cubicity yields only Euler's identity $\langle\nabla P(W),W\rangle=3P(W)$. Concretely, on $\mathbb R^2$ take $Q(x,y)=(0,x^2)$: $P=\langle W,Q(W)\rangle=x^2y$ is cubic, $\nabla P=(2xy,x^2)$, and $3Q=(0,3x^2)$, so $\nabla P\ne3Q$. Read alone, the route of Passage B is circular: $\nabla P=3Q$ is equivalent to the symmetry it is cited to supply. (3) Charitable reading: the same line 63, two sentences later, proves full symmetry directly ("the $W^2$ part as the symmetrisation of $\mathop{\mathrm{tr}}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$"), and [conventions.md:24](../findings/conventions.md#L24) repeats it. From that, $\nabla P=3Q$ follows. I checked the direct argument: for symmetric $X,Y,Z$, $\mathop{\mathrm{tr}}(XYZ)=\mathop{\mathrm{tr}}((XYZ)^{\mathsf T})=\mathop{\mathrm{tr}}(ZYX)=\mathop{\mathrm{tr}}(XZY)$, so with cyclicity the $W^2$ part is $S_3$-invariant. For the $\#$ part, exchanging two arguments exchanges one index pair in each of the two structure-constant factors, each antisymmetric, sign $(-1)^2=+1$. Restricting to $X\in\mathcal W_n$ loses nothing, since $\langle X,\mathrm{pr}(Y\circ Z)\rangle=\langle X,Y\circ Z\rangle$. The fact is filed at the cited location with a correct argument. **Withdrawn** as a defect of L66. The residue is an order-of-justification note: the word "so" at line 63 and the "because" at Passage B line 7 point the wrong way.

- Candidate on Passage C. [results.md:1096](../results.md#L1096) says "every cross term $T(A_i,A_j,\cdot)=\langle A_i\circ A_j,\cdot\rangle$ vanishes". (1) Located there. (2) Terms $T(A_i,A_i,A_l)$ with $i\ne l$ are not of the form $T(A_i,A_j,\cdot)$ with $i\ne j$. (3) Charitable reading: the same sentence fixes $\circ$ through $T$, which [conventions.md:24](../findings/conventions.md#L24) tables as fully symmetric, and under that convention $T(A_i,A_i,A_l)=T(A_i,A_l,A_i)$ is a term of the stated form. **Withdrawn.**

**Verdict: CONFIRMED.**

## 3. $M(n)$, oddness, and $M(n)>0$

**3a. Existence, oddness, $\lvert P(A_i)\rvert\le M(n)$.** For $n\ge4$ the unit sphere of the finite-dimensional $\mathcal W_n$ is compact and nonempty and $P$ is a polynomial, so $M(n)$ is attained (unstated, elementary). $P(-A)=(-1)^3P(A)$. For a unit $A_i$, $P(A_i)\le M(n)$ and $-P(A_i)=P(-A_i)\le M(n)$. This holds for any unit piece, padded, critical or not, since $M(n)$ is taken over all of $\mathcal W_n$. **CONFIRMED.**

**3b. $M(n)>0$.** Oddness alone gives $M(n)\ge0$, with $M(n)>0$ exactly when $P\not\equiv0$ on $\mathcal W_n$. The record's reason is "any sphere product attains a positive value".

- No value of $P$ at any sphere product is carried by the passages, and no source is linked for it. The only nonzero values on file in the passages are decimals ($0.2152$ in Passage E, $0.664362$ and $0.272738$ in Passage B), which this loop cannot use.
- The strictness is load-bearing, as line 7 says: if $M(n)=0$ then $P\equiv0$, every unit tensor is a maximizer, and the chain ends at $P(W)\le0=M(n)$ with no contradiction.
- Candidate on "any". (1) Line 7, "any sphere product". (2) $S^1\times S^{n-1}$ is conformally flat, so its Weyl tensor is $0$ and it attains $P=0$, not a positive value. (3) Charitable reading: "sphere product" means a factor pair with nonzero Weyl tensor, normalised to unit length and taken with its geometric sign, and only one such object per $n$ is needed. **Withdrawn**, the universal reading being unnecessary.
- At the smallest dimension $n=4$ the only candidate product with nonzero Weyl tensor is $S^2\times S^2$, so the debt includes $n=4$.

**HYPOTHESIS-DEBT.** What would have to be proved: for every $n\ge4$ there is a unit $A\in\mathcal W_n$ with $P(A)\ne0$, for example an exact value of $P$ at the normalised Weyl tensor of $S^2\times S^2$ padded to $\mathbb R^n$ (padding into $\mathcal W_n$ would also have to be shown to preserve $P$, or a product with $p+q=n$ used at each $n$).

## 4. The chain

- $a_i^3P(A_i)\le\lvert a_i^3P(A_i)\rvert=\lvert a_i\rvert^3\lvert P(A_i)\rvert\le\lvert a_i\rvert^3M(n)$, by 3a and $M(n)\ge0$. Summing gives the first inequality.
- $\lvert a_i\rvert^3=\lvert a_i\rvert a_i^2\le(\max_j\lvert a_j\rvert)a_i^2$, and summing with $\sum a_i^2=1$ gives the second. Multiplying by $M(n)$ needs $M(n)\ge0$, which holds.
- $\max_i\lvert a_i\rvert<1$: for each $i$ pick $j\ne i$ (possible as $k\ge2$), then $a_i^2\le1-a_j^2<1$ as $a_j\ne0$.
- The last inequality $M(n)\max_i\lvert a_i\rvert<M(n)$ is strict exactly when $M(n)>0$ (Section 3b).
- Conclusion: $P(W)<M(n)$, so $W$ is not a maximizer. The unit norm of $W$ is not needed.

**Verdict: CONFIRMED** (the strict step carries 3b's debt).

## 5. The witness at $(a,b)=(0.6,-0.8)$

Exactly, $a=\tfrac35$, $b=-\tfrac45$, $a^3=\tfrac{27}{125}$, $b^3=-\tfrac{64}{125}$. With $P(A_1)=M$ and $P(A_2)=-M$:

- $P(W)=\tfrac{27}{125}M+\tfrac{64}{125}M=\tfrac{91}{125}M=0.728\,M$.
- The bound with signed cubes, $M(a^3+b^3)=-\tfrac{37}{125}M=-0.296\,M$.
- Since $M>0$, $\tfrac{91}{125}M>-\tfrac{37}{125}M$, so the signed-cube bound fails.

"Fails at any negative coefficient": for any $a_j<0$, set $P(A_j)=-M$ and $P(A_i)=M$ otherwise. Then $\sum_ia_i^3P(A_i)-M\sum_ia_i^3=-2a_j^3M>0$. So the signed step is invalid at every negative coefficient. Two notes, neither a defect: line 11 writes $0.728$ and $-0.296$ with the factor $M$ suppressed, and whether a $\circ$-orthogonal pair with values exactly $\pm M$ exists is not on file, which does not matter because the witness refutes an inference step whose only input is $\lvert P(A_i)\rvert\le M$.

**Verdict: CONFIRMED AS ALGEBRA.**

## 6. Passage B lines 13 and 15

**6a.** "Criticality does not derive $\circ$-orthogonality from ordinary orthogonality" rests on $\lVert A\circ B\rVert=0.664362$ for two critical, Frobenius-orthogonal padded $W_{\mathbb{CP}^2}$ at $n=8$ and $0.272738$ for a rotated $S^4\times S^4$ pair. Both are decimals from a run, with no exact value and no closed-form object (the embeddings and the rotation are unspecified). The lemma does not use either. **HYPOTHESIS-DEBT.** What would have to be proved: an explicitly specified pair of critical, Frobenius-orthogonal unit Weyl tensors with an exact nonzero $A\circ B$.

**6b.** "At $k=2$, criticality plus ordinary orthogonality already gives exact additivity" has no argument on file. The obligation is that for critical unit $A,B$ with $\langle A,B\rangle=0$ the two mixed terms of $P(aA+bB)$, namely $3a^2b\,T(A,A,B)$ and $3ab^2\,T(A,B,B)$, vanish. A screen of the claim found no falsifier: both terms reduce to multiples of $\langle A,B\rangle$ under total symmetry and criticality. The phrase "strictly weaker than the hypothesis used here" is also unargued. As hypotheses, $\circ$-orthogonality and criticality plus Frobenius orthogonality are comparable only if one implies the other, and the passages carry an implication in neither direction in exact form (6a is decimal). Read as "the conclusion is weaker" (only $k=2$) the phrase is apt. The lemma uses neither sentence. **HYPOTHESIS-DEBT.**

## 7. Passage B line 17, the support examples

- **$\Lambda^+/\Lambda^-$ pair at $n=4$.** That $n_i=n=4$ for each nonzero piece follows from $\dim\mathcal W_3=0$ once "support" is read as the smallest coordinate subspace from which the tensor is padded. That the pair is $\circ$-orthogonal is asserted here and in Passage E ("which a $\Lambda^+/\Lambda^-$ pair on the *same* four coordinates also satisfies") with no argument on file. What would have to be proved: $W^2$ maps $\Lambda^\pm$ to itself for $W\in\mathcal W_4^\pm$, so $AB+BA=0$ for $A\in\mathcal W^+$, $B\in\mathcal W^-$, and the structure constants of $\mathfrak{so}(4)$ never mix $\Lambda^+$ with $\Lambda^-$, so $A\#B=0$.
- **$(S^4)^3=S^4\times S^8\oplus S^4\times S^4$ at $n=12$.** Written without coefficients. The passages carry neither the decomposition with its coefficients nor the $\circ$-orthogonality of the two summands nor the support-12 claim for the $S^4\times S^8$ piece. What would have to be proved: an exact identity $W_{(S^4)^3}=\alpha W_{S^4\times S^8}+\beta\,W^{\mathrm{pad}}_{S^4\times S^4}$ with explicit $\alpha,\beta$, and $W_{S^4\times S^8}\circ W^{\mathrm{pad}}_{S^4\times S^4}=0$.
- The lemma uses neither example: they illustrate that the proof does not need $n_i<n$, which Section 4 confirms independently.

**Verdict: HYPOTHESIS-DEBT** (illustrative, unused).

## 8. Passage C's additions

**8a. $\lvert P(W)\rvert<M(n)$ and "reads $0<0$".** $\lvert\sum_ia_i^3P(A_i)\rvert\le\sum_i\lvert a_i\rvert^3\lvert P(A_i)\rvert\le M(n)\max_i\lvert a_i\rvert<M(n)$, the same chain as Section 4 with the triangle inequality first. It is stronger than Passage B's $P(W)<M(n)$ (it also excludes $P(W)=-M(n)$) and correct. Against $m=\max_i\lvert P(A_i)\rvert$ the same chain ends at $m\max_i\lvert a_i\rvert<m$, which is false when $m=0$, i.e. reads $0<0$ when every piece has $P(A_i)=0$. The sentence is conditional and asserts no such splitting exists. **CONFIRMED** (strictness carries 3b's debt).

**8b. The harmonic-square clause.** [results.md:334](../results.md#L334): "At a decomposable *critical* point the harmonic-square law $\frac1{\theta^2}=\sum_i\frac1{\theta_i^2}$ gives the sharper $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$".

- The algebra from the law to the bound is right: with $k\ge2$ and every term positive, $\frac1{\theta^2}>\frac1{\theta_j^2}$ for each $j$, so $\theta^2<\theta_j^2$. It is sharper than $\lvert\theta\rvert<M(n)$ since $\lvert\theta_i\rvert\le M(n)$.
- Passage E derives the law for **two** pieces ("$\theta=a\theta_A=b\theta_B$ and with $a^2+b^2=1$") and writes the conclusion with $\sum_i$. The case $k\ge3$ has no argument on file.
- The coefficient comparison "criticality forces $\theta=a\theta_A=b\theta_B$" presupposes that the pieces are themselves critical (so $\theta_A,\theta_B$ are defined), that $A$ and $B$ are linearly independent, and that $\theta_A,\theta_B\ne0$ (the law divides by them). None is stated in Passage E. Passage C's "decomposable *critical* point" names criticality of $W$, and only its later phrase "the criticality this lemma disclaims" identifies criticality of the pieces as the one needed.
- At $\theta=0$ with every $\theta_i=0$ the clause reads $0<0$. Whether such a splitting exists is not decided by the passages.

**HYPOTHESIS-DEBT.** What would have to be proved: for critical, pairwise $\circ$-orthogonal unit pieces with all $\theta_i\ne0$ and $W=\sum a_iA_i$ critical, $a_i\theta_i=\theta$ for every $i$, including linear independence of the pieces and $k\ge3$. The lemma does not use the clause.

**8c. "Sending one coefficient to $1$ sends $P(W)$ to that piece's own $\theta$, above $\min_i\lvert\theta_i\rvert$ whenever the pieces differ."**

- Without criticality, "that piece's own $\theta$" reads as $P(A_i)$. With the pieces fixed and $a_1\to1$ (others nonzero, $\to0$), $P(W)=\sum a_i^3P(A_i)\to P(A_1)$, and $\circ$-orthogonality does not depend on the coefficients, so the family exists given one splitting.
- Candidate. (1) Located at [results.md:334](../results.md#L334), "whenever the pieces differ". (2) Take distinct pieces with equal $\lvert P\rvert$, for instance $P(A_1)=P(A_2)=t>0$. Then $\lvert P(W)\rvert=t\lvert a^3+b^3\rvert\le t(\lvert a\rvert^3+\lvert b\rvert^3)<t=\min_i\lvert\theta_i\rvert$ for every admissible $(a,b)$, so no coefficient path goes above the minimum. Likewise sending to $1$ the coefficient of the piece with the smallest $\lvert P\rvert$ tends to the minimum, not above it. (3) Charitable reading: "the pieces differ" means their values $\lvert\theta_i\rvert$ differ, and "one coefficient" is the one on a piece of largest $\lvert\theta_i\rvert$. Then $\lvert P(W)\rvert\to\max_i\lvert\theta_i\rvert>\min_i\lvert\theta_i\rvert$ and the sentence is right, which is all it needs to show that the sharper bound fails without criticality. The concrete object in (2) also needs a splitting with equal $\lvert P\rvert$ realised on the record's objects, which I did not exhibit in closed form. **Withdrawn** (fails step 3, and step 2 is abstract). Wording note: "whenever the values $\lvert\theta_i\rvert$ differ, for the coefficient of a piece of largest $\lvert\theta_i\rvert$".

**CONFIRMED** under the charitable reading.

**8d. "A $\circ$-decomposable $W$ can have summands of full dimension $n$, so it supports no induction on $n$."** The existential rests on the examples of Section 7, whose $\circ$-orthogonality has no argument on file. The inference to "no induction" is a remark, not a claim with content to check. **HYPOTHESIS-DEBT**, same obligation as the $\Lambda^+/\Lambda^-$ item of Section 7.

## 9. The Lean file

[L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean), read in full. I did not build it (no computation), and I checked the text for `sorry` and `axiom` and found neither.

- **What it proves.** Over an arbitrary real normed space $E$ with a trilinear $T$, $P(X)=T(X,X,X)$, `hsym12` ($T(x,y,z)=T(y,x,z)$), an upper bound $M>0$ for $P$ on the unit sphere, and $W$ unit with $P(W)=M$: $W$ is not `IsCircDecomposable`. `Pf_lt_max` proves the stronger $P(W)<M$ for every decomposable $W$, unit or not.
- **Symmetry assumed.** Only the swap of slots 1 and 2, used once, in `hz`, for $T(A_i,A_j,A_j)=T(A_j,A_i,A_j)$. That matches Section 2 exactly. Total symmetry is not assumed and is not needed.
- **$\circ$-orthogonality.** Encoded as $T(X,A_i,A_j)=0$ for all $X$ and $i\ne j$. For $T(X,Y,Z)=\langle X,Y\circ Z\rangle$ on $\mathcal W_n$ this is $\mathrm{pr}_{\mathcal W_n}(A_i\circ A_j)=0$, equivalent to the record's hypothesis when $\circ$ lands in $\mathcal W_n$ and weaker otherwise, so the encoding is faithful or more general.
- **$\lvert P(A_i)\rvert\le M$.** Derived in `habs` from `hM` at $A_i$ and $-A_i$ plus oddness `hodd`, as in Section 3a.
- **The chain.** `sum_abs_cube_lt_one` proves $\sum\lvert a_i\rvert^3<1$ termwise ($\lvert a_i\rvert^3<a_i^2$), skipping the maximum, and the final step uses $M>0$ as a hypothesis.
- **What is not typed** (declared in the file's docstring): that the record's $T$ on $\mathcal W_n$ satisfies `hsym12`, that $P$ is its diagonal, that $M(n)$ exists and is positive. So the file states and proves the abstract core, and the lemma on $\mathcal W_n$ follows from it only with Section 2 and Section 3b as inputs. **3b's debt is a Lean hypothesis, not a Lean result.**
- **Non-vacuity.** The example exhibits `IsCircDecomposable` only at $T=0$, where `hMpos` fails, as the docstring says. Joint satisfiability of the theorem's hypotheses is not exhibited in the file (it holds at $E=\mathbb R$, $T(x,y,z)=xyz$, $M=1$, $W=1$, which is a screen, not a file fact).
- **Quotation drift.** The section headed "The record's statement, verbatim" reproduces the proof and line 17 with `---` where the current record reads ", the cross term" and "(the part that widens the reach)". The statement block itself matches Passage A.
- The exact witness `example` ($\tfrac{91}{125}M$ against $-\tfrac{37}{125}M$) matches Section 5.

**Verdict: CONFIRMED AS ALGEBRA** for the abstract implication, which is the lemma's chain with its inputs as hypotheses.

## 10. The boundary

- **$k=2$.** $\lvert a_1\rvert<1$ because $a_2\ne0$. The chain gives $P(W)\le M(\lvert a_1\rvert^3+\lvert a_2\rvert^3)<M$. No change.
- **A negative coefficient.** Handled by the absolute values, Section 5. No change.
- **A piece with $P(A_i)\le0$.** $a_i^3P(A_i)\le\lvert a_i\rvert^3\lvert P(A_i)\rvert\le\lvert a_i\rvert^3M$ still holds, and a piece with $P(A_i)=0$ contributes $0$. All pieces at $P=0$ give $P(W)=0<M(n)$, which is where the bound against $M(n)$ rather than $\max\lvert P(A_i)\rvert$ matters (8a).
- **A piece equal to $\pm$ another.** If $A_2=\pm A_1$ then $Q(A_1)=\pm A_1\circ A_2=0$, so $P(A_1)=P(A_2)=0$ and $P(W)=0<M(n)$. No change.
- **Padded objects (kernel of $W$ nonzero).** $M(n)$ is taken over all of $\mathcal W_n$, padded tensors included, and the proof never uses support. No change.
- **$n\le3$.** $\mathcal W_n=0$, the unit sphere is empty, there is no maximizer and no unit piece. The statement is vacuously true and $M(n)$ is undefined, so line 7's "$M(n)>0$" is meaningful only for $n\ge4$.
- **$n=4$**, the smallest $n$ with $\mathcal W_n\ne0$. The chain applies and $M(4)>0$ is 3b's debt.

**Verdict: CONFIRMED**, with 3b's debt at every $n\ge4$.

## 11. Universal sentences against the named families, and the falsifier for each claim

| Claim | Falsifying object | Search and result |
|---|---|---|
| L66 | a maximizer $W$ with a $\circ$-splitting, any $n\ge4$ | The chain of Section 4 bounds $P(W)<M(n)$ uniformly. Diagonal, padded, sphere-product, $\mathbb{CP}^2$ and $\Lambda^\pm$ pieces all satisfy $\lvert P(A_i)\rvert\le M(n)$, so no family can supply one given $M(n)>0$. The only escape is $M(n)=0$, i.e. $P\equiv0$ on $\mathcal W_n$. None found. |
| Additivity | a $\circ$-orthogonal splitting with a surviving cross term | Every index pattern checked in Section 2. None possible under total symmetry. |
| Total symmetry of $T$ | $X,Y,Z\in\mathcal W_n$ with $T(X,Y,Z)\ne T(Y,X,Z)$ | Checked the trace and structure-constant argument. None. The circular citation route has the $\mathbb R^2$ exhibit of Section 2, withdrawn. |
| $M(n)>0$ | an $n\ge4$ with $P\equiv0$ on $\mathcal W_n$ | No exact value on file to rule it out. $S^1\times S^{n-1}$ has $P=0$ but is not a unit tensor (withdrawn). Debt. |
| $\max\lvert a_i\rvert<1$ | $k\ge2$, all $a_i\ne0$, $\sum a_i^2=1$, some $\lvert a_i\rvert=1$ | Impossible, Section 4. |
| Signed chain fails at any negative coefficient | a negative $a_j$ where the signed bound holds for all admissible values | $P(A_j)=-M$ always breaks it. None. |
| 6a | a proof that criticality plus Frobenius orthogonality forces $A\circ B=0$ | Not searched beyond reading: the record's witnesses are decimal. Debt. |
| 6b | critical, Frobenius-orthogonal $A,B$ with nonzero mixed term | Screen: both mixed terms are multiples of $\langle A,B\rangle$. None. Debt for want of an argument on file. |
| $\Lambda^\pm$ pair $\circ$-orthogonal | $A\in\mathcal W^+_4$, $B\in\mathcal W^-_4$ with $A\circ B\ne0$ | Tried the block structure of $\Lambda^+\oplus\Lambda^-$. None seen. Debt. |
| $(S^4)^3$ splitting | nonzero $W_{S^4\times S^8}\circ W^{\mathrm{pad}}_{S^4\times S^4}$ | Coefficients absent on file. Debt. |
| Harmonic clause | a critical splitting with non-critical pieces, dependent pieces, or $\theta_i=0$ | Tried $B=\pm A$ (forces $\theta=0$) and the $\theta=0$ edge (reads $0<0$). No closed-form object realising a failure. Debt. |
| "above $\min\lvert\theta_i\rvert$ whenever the pieces differ" | distinct pieces with equal $\lvert P\rvert$ (Section 8c) | Fails literally, holds under the charitable reading. Withdrawn. |
| Lean abstract theorem | a model of its hypotheses with a decomposable maximizer | Proof read line by line. None. |

## Withdrawn candidates

1. **Passage A, "above every heading"** (Section 1). Line 1 is a heading. Withdrawn: the H1 is the file title.
2. **[second-order.md:63](../findings/second-order.md#L63), "$P$ is a cubic form, so $\nabla P=3Q$"** (Section 2). Cubicity gives only Euler's identity, $\mathbb R^2$ exhibit $Q(x,y)=(0,x^2)$. Withdrawn: the same line proves full symmetry of $T$ directly, from which $\nabla P=3Q$ follows, so the fact is filed with a correct argument at the cited location.
3. **Passage C, "every cross term $T(A_i,A_j,\cdot)$"** (Section 2). Misses $T(A_i,A_i,A_l)$ literally. Withdrawn: $T$ is fully symmetric by the convention the sentence invokes.
4. **"Any sphere product attains a positive value"** (Section 3b). $S^1\times S^{n-1}$ has zero Weyl tensor. Withdrawn: one normalised product with nonzero Weyl tensor per $n$ suffices, and that remaining obligation is recorded as debt.
5. **"Whenever the pieces differ"** (Section 8c). Fails at distinct pieces of equal $\lvert P\rvert$. Withdrawn: the charitable reading (values differ, coefficient of the largest piece) is correct, and the literal failure was not realised in closed form on the record's objects.

## Overall verdict

**HYPOTHESIS-DEBT.**

- The written proof of L66 is correct link by link: additivity (Section 2), $\lvert P(A_i)\rvert\le M(n)$ (3a), the chain and $\max_i\lvert a_i\rvert<1$ (Section 4), and every boundary case (Section 10).
- The single input without an argument on file is **$M(n)>0$ for every $n\ge4$**, equivalently $P\not\equiv0$ on $\mathcal W_n$, which the proof itself flags as the sole source of strictness and justifies only by the unfiled "any sphere product attains a positive value". Filing one exact nonzero value of $P$ per $n\ge4$ (or at $S^2\times S^2$ with padding shown to preserve $P$) would discharge it and make the lemma PROVEN with its hypotheses as stated.
- The Lean file proves the abstract implication with $M>0$ and the slot swap as hypotheses, so it confirms the chain and leaves the same debt.
- Side debts, none used by the proof: the decimal witnesses and the $k=2$ remark of Passage B lines 13-15, the $\circ$-orthogonality of the $\Lambda^\pm$ and $(S^4)^3$ examples, and the harmonic-square clause of Passage C, whose law is on file only for two pieces with unstated criticality of the pieces, linear independence and $\theta_i\ne0$.
