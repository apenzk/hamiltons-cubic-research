# Verifier v403, Lemma L66 (no maximizer is $\circ$-decomposable): the definition, additivity, total symmetry of $T$, the chain to $M(n)$, $M(n)>0$ via Nienhaus Proposition 2.25, the side remarks, and the Lean statement

The brief was cold, and I worked from the definitions it quotes and from Nienhaus's thesis at source (the .txt, Definition 2.11, Lemmas 2.12 to 2.14 and 2.22, Definition 2.15, Lemma 2.23 and Proposition 2.25 with its proof). No numerical work was done, no scripts were written, no build was run, and every value below is exact. Hand screens on constructed objects are reported as screens. The log is agent_logs/verify-L66-v403.log.

| # | Claim attacked | Verdict | Reason |
|---|---|---|---|
| 1 | The definition of $\circ$-decomposable agrees across Passages A, B, C | CONFIRMED | same five clauses in all three, only the slot convention for $T$ differs (row 3) |
| 2 | Additivity $P(W)=\sum_ia_i^3P(A_i)$ | CONFIRMED | $P(W)=T(W,W,W)$, every term with two distinct indices dies after one slot move |
| 3 | Total symmetry of $T$ (Passage D's sketch) | CONFIRMED AS ALGEBRA | both parts close from the index formula, the $\tfrac12$ is a constant and plays no role |
| 4 | $\lvert P(A_i)\rvert\le M(n)$ | CONFIRMED | $P$ cubic hence odd, $-A_i$ unit |
| 5 | The chain $\le M\sum\lvert a_i\rvert^3\le M\max\lvert a_i\rvert<M$ | CONFIRMED | each step valid for either sign of $a_i$ and $P(A_i)$, strictness from $M>0$ and $\max\lvert a_i\rvert<1$ |
| 6 | $\max_i\lvert a_i\rvert<1$ | CONFIRMED | a second nonzero coefficient forces $a_i^2<1$ |
| 7 | $M(n)>0$ at every $n\ge4$ via Proposition 2.25 | CONFIRMED | $(k,l)=(2,n-2)$ realises every $n\ge4$, conventions of $P$ and $\#$ match the record's, screen at $S^2\times S^2$ gives $\sqrt3/2$ |
| 8 | Absolute-value remark at $(\tfrac35,-\tfrac45)$ | CONFIRMED AS ALGEBRA | $\tfrac{91}{125}M$ and $-\tfrac{37}{125}M$ both exact |
| 9 | "Criticality of the pieces is not needed", "Nothing else is used" | CONFIRMED | the proof uses no criticality, padding, monotonicity or harmonic-square law |
| 10 | Criticality with Frobenius orthogonality differs from $\circ$-orthogonality (the $n=8$ run) | HYPOTHESIS-DEBT | supported only by a run, no closed-form witness, unused by the proof |
| 11 | Passage C detail: $\lvert P(W)\rvert$ bound, "runs against $M(n)$", "$0<0$", "no induction on $n$" | CONFIRMED | triangle inequality gives the stronger two-sided bound, the $0<0$ reading is exact |
| 12 | Passage C landscape: $\lvert\theta\rvert<\min(\lvert\theta_A\rvert,\lvert\theta_B\rvert)$ and the limit $a_1\to1$ | CONFIRMED AS ALGEBRA | follows from the cited law, whose proof is outside the brief |
| 13 | Passage E states and proves the abstract core | CONFIRMED | $\mathrm{hsym12}$ plus $\mathrm{horth}$ is exactly what additivity needs, the Weyl instance and $M>0$ enter as hypotheses |
| 14 | Existence of a $\circ$-decomposable $W$ at each $n\ge4$ (brief item 11) | CONFIRMED (screen) | padded $A_+\in\mathcal W_+$, $A_-\in\mathcal W_-$ from $n=4$ satisfy $A_+\circ A_-=0$, a screen not required by the lemma |

**Summary: the written proof of Lemma L66 closes step by step from the stated hypotheses and the imported Proposition 2.25, whose hypotheses and conventions match the object, so the round can record PROVEN, with one side paragraph (the $n=8$ run) carried as HYPOTHESIS-DEBT and two wording notes (the slot convention of $T$ in Passage A, and $S^k\times S^l$ for $S^k\times S^l_r$ in Passages A and C) that change nothing.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, viewed as symmetric operators on $\Lambda^2\mathbb R^n$, with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$."
- "$T$, third sense: the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$."
- "$(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$", with "$\mathrm{id}^\#=(n-2)\mathrm{id}$" and "$Q(\mathrm{id})=(n-1)\mathrm{id}$ on the round sphere".
- "The $\circ$ product: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$."
- Passage A writes $T(X,Y,Z)=\langle X,Y\circ Z\rangle$. Passages C and D write $\langle X\circ Y,Z\rangle$. Section 3 shows the two coincide once total symmetry holds.

From Nienhaus at source: $R\#S(v,w)=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}_v\circ R\circ\mathrm{ad}_w\circ S)$ (Definition 2.11), $Q(R,S)=\tfrac12(RS+SR)+R\#S$, Weyl when $R,S$ are (Lemma 2.13), $P(R)=\langle Q(R),R\rangle$ (Definition 2.15), and the inner product on $S^2_B(\mathfrak{so}(n))$ is $\sum_{i<j}\langle RS(e_i\wedge e_j),e_i\wedge e_j\rangle$, the trace on $\Lambda^2$ with $\{e_i\wedge e_j\}$ orthonormal (proof preceding line 913 of the .txt).

## 1. Hypothesis inventory

**The statement's hypotheses.**

| Hypothesis | Used by the proof at | Checked |
|---|---|---|
| $n\ge4$ | only through $M(n)>0$ | yes, and at $n\le3$ the unit sphere is empty so the statement is vacuous |
| $W$ a maximizer of $P$ on the unit sphere | $P(W)=M(n)$ is what the strict bound contradicts | yes, it also guarantees the maximum is attained, so no compactness argument is needed |
| $k\ge2$ | $\max_i\lvert a_i\rvert<1$ | yes |
| each $A_i$ a unit element of $\mathcal W_n$ | $\lvert P(A_i)\rvert\le M(n)$ | yes |
| $\sum_ia_i^2=1$ | $\max_i\lvert a_i\rvert<1$ and $\sum\lvert a_i\rvert^3\le\max\lvert a_i\rvert$ | yes |
| every $a_i\ne0$ | $\max_i\lvert a_i\rvert<1$ (a second nonzero coefficient) | yes |
| $A_i\circ A_j=0$ for $i\ne j$ | additivity | yes |
| $\lVert W\rVert=1$ | **stated, unused**: the proof shows $P(W)<M(n)$ for every $\circ$-decomposable $W$, whatever its norm | no finding, the statement is simply stronger than needed, and Lean marks the binder $\_hWnorm$ unused |

The definition does not require the $A_i$ to be Frobenius-orthogonal, so $\lVert W\rVert=1$ is not automatic from $\sum a_i^2=1$. Nothing in the proof needs it. No finding.

**Givens used but not proved in the passages.**

- Total symmetry of $T$: argued in Passage D, checked in Section 3.
- Total antisymmetry of the structure constants $c_{abc}$: asserted in Passage D and the conventions. This is the ad-invariance of the inner product on $\mathfrak{so}(n)$ in an orthonormal basis, a property of the defined object. Recorded as a given, no finding.
- $Q(W)=W\circ W$: from the polarisation definition, $W\circ W=\tfrac12(Q(2W)-2Q(W))=\tfrac12(4-2)Q(W)=Q(W)$. Closes.
- $A_i\circ A_j\in\mathcal W_n$: needed only for the Lean bridge (Section 13), supplied by Nienhaus Lemma 2.13.

**The imported result, Nienhaus Proposition 2.25, against the object.**

| Hypothesis or convention of Prop. 2.25 | On the object | Checked |
|---|---|---|
| $k,l\in\mathbb N$, $k+l=n$, $S_{k,l}=S^k\times S^l_r$ with $r=\sqrt{(l-1)/(k-1)}$ | needs $k\ge2$ for $r$ defined and $l\ge2$ for $r>0$ | the passages impose $k,l\ge2$, which is exactly the range where the construction is nondegenerate |
| $W_{S_{k,l}}=\widetilde W/\lVert\widetilde W\rVert$ is a unit Weyl operator | needs $\widetilde W\ne0$ | $\theta_{k,l}>0$ at $k,l\ge2$ forces it, and the screen in Section 7 exhibits it at $n=4$ |
| Nienhaus's $P$, $Q$, $\#$ and norm equal the record's | pinned in Section 7 | yes: $\mathrm{id}^\#=(n-2)\mathrm{id}$ in both, and the record's index formula reproduces Nienhaus Lemma 2.22 on diagonal operators, which is the class $S_{k,l}$ lies in |

## 2. Claim 1, the definition across Passages A, B, C

Passage A: $k\ge2$, unit $A_i\in\mathrm{Weyl}_n$, $\sum a_i^2=1$, all $a_i\ne0$, $A_i\circ A_j=0$ for $i\ne j$. Passage B: the same five clauses, with $\mathrm{Weyl}_n$. Passage C landscape: "each $A_i$ a unit Weyl tensor", otherwise identical. Passage C detail: "each $A_i$ a unit element of $\mathcal W_n$", identical, and adds "$\circ$ is the symmetric product with $\langle x\circ y,z\rangle=T(x,y,z)$".

The only divergence is the slot convention: Passage A has $T(X,Y,Z)=\langle X,Y\circ Z\rangle$, Passage C and the conventions have $\langle X\circ Y,Z\rangle$. Under total symmetry (Section 3) the two are the same trilinear form. Passage A's own sentence "the cross term $\langle A_i,Q(A_j)\rangle=T(A_i,A_j,A_j)$ dies only after moving the first slot to $\langle A_j,A_i\circ A_j\rangle=0$" is internally consistent with its own convention: $T(A_i,A_j,A_j)=\langle A_i,A_j\circ A_j\rangle=\langle A_i,Q(A_j)\rangle$, and the slot move gives $T(A_j,A_i,A_j)=\langle A_j,A_i\circ A_j\rangle=0$. Read with the conventions' $\langle X\circ Y,Z\rangle$ instead, $T(A_i,A_j,A_j)=\langle A_i\circ A_j,A_j\rangle$ is zero with no move, and the equality $\langle A_i,Q(A_j)\rangle=T(A_i,A_j,A_j)$ is the step that uses symmetry. Either way symmetry is used exactly once, so the argument is unaffected. Wording note, no finding.

Degenerate admissible decompositions, screened: $A_i=\pm A_j$ with $i\ne j$ is allowed when $Q(A_i)=0$, and then $P(A_i)=0$, which the chain handles. No finding.

## 3. Claims 2 and 3, additivity and total symmetry of $T$

**Total symmetry, the $W^2$ part.** Polarising $W^2$ gives $\tfrac12(XY+YX)$, so this part of $T$ is $\tfrac12(\mathop{\mathrm{tr}}(XYZ)+\mathop{\mathrm{tr}}(YXZ))$. By cyclicity $\mathop{\mathrm{tr}}(YXZ)=\mathop{\mathrm{tr}}(XZY)$, so the expression is $\tfrac12$ times the sum of one representative from each of the two cyclic classes of $\mathop{\mathrm{tr}}$ on three letters. Each class has three equal members, so this equals $\tfrac16\sum_{\sigma\in S_3}\mathop{\mathrm{tr}}(\sigma(XYZ))$, the symmetrisation. Passage D's description is exact and the part is fully symmetric.

**Total symmetry, the $\#$ part.** Write $B(X,Y)_{ab}=\tfrac12\sum c_{acd}c_{bef}X_{ce}Y_{df}$. Relabelling $c\leftrightarrow d$, $e\leftrightarrow f$ gives $B(Y,X)_{ab}=\tfrac12\sum c_{adc}c_{bfe}X_{ce}Y_{df}=B(X,Y)_{ab}$ at sign $(-1)^2$, so the polarisation $X\#Y$ equals $B(X,Y)$. Then $S(X,Y,Z):=\langle X\#Y,Z\rangle=\tfrac12\sum c_{acd}c_{bef}X_{ce}Y_{df}Z_{ab}$.

- Swapping $X$ and $Z$: relabel $a\leftrightarrow c$, $b\leftrightarrow e$ in $S(Z,Y,X)$ to get $\tfrac12\sum c_{cad}c_{ebf}X_{ce}Y_{df}Z_{ab}$, and $c_{cad}c_{ebf}=(-c_{acd})(-c_{bef})$. Equal.
- Swapping $Y$ and $Z$: relabel $a\leftrightarrow d$, $b\leftrightarrow f$ in $S(X,Z,Y)$ to get $c_{dca}c_{feb}=(-c_{acd})(-c_{bef})$. Equal.

Two transpositions generate $S_3$, so $S$ is fully symmetric. The factor $\tfrac12$ multiplies every term and cannot affect symmetry. Passage D's "permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$" is the argument that closes. Nienhaus Definition 2.15 independently asserts "tri$(R,S,T)=\langle Q(R,S),T\rangle$ ... is fully symmetric". CONFIRMED AS ALGEBRA, resting on the total antisymmetry of $c$ recorded as a given in Section 1.

**Additivity.** $P(W)=\langle Q(W),W\rangle=\langle W\circ W,W\rangle=T(W,W,W)=\sum_{i,j,l}a_ia_ja_lT(A_i,A_j,A_l)$ by trilinearity. For a triple $(i,j,l)$ not all equal, two of the indices differ. By total symmetry move that pair into the two slots of $\circ$, giving $\langle A_p\circ A_q,A_r\rangle$ with $p\ne q$, which is $0$. The surviving terms are $i=j=l$, giving $\sum_ia_i^3T(A_i,A_i,A_i)=\sum_ia_i^3P(A_i)$. For $k\ge3$ triples with three distinct indices vanish by the same move.

Is total symmetry what it needs? At minimum the step needs the pattern $(j,j,i)$, $\langle A_j\circ A_j,A_i\rangle$, turned into $\langle A_j\circ A_i,A_j\rangle$, which is self-adjointness of $L_{A_j}$, a symmetry beyond the trivial one of $\circ$. Total symmetry supplies it. CONFIRMED.

## 4. Claim 4, $\lvert P(A_i)\rvert\le M(n)$

$P(-A)=\langle Q(-A),-A\rangle=\langle Q(A),-A\rangle=-P(A)$, since $Q$ is quadratic. Each $A_i$ is a unit element by the definition, so $-A_i$ is too, and $P(A_i)\le M(n)$, $-P(A_i)=P(-A_i)\le M(n)$. CONFIRMED.

## 5. Claims 5 and 6, the chain and $\max_i\lvert a_i\rvert<1$

- $a_i^3P(A_i)\le\lvert a_i^3P(A_i)\rvert=\lvert a_i\rvert^3\lvert P(A_i)\rvert\le\lvert a_i\rvert^3M(n)$. Valid for every sign of $a_i$ and of $P(A_i)$. Summing gives the first inequality.
- $\lvert a_i\rvert^3=\lvert a_i\rvert a_i^2\le(\max_j\lvert a_j\rvert)a_i^2$, summed with $\sum a_i^2=1$, gives $\sum\lvert a_i\rvert^3\le\max\lvert a_i\rvert$. Multiplying by $M(n)$ keeps the direction since $M(n)>0$.
- $M(n)\max\lvert a_i\rvert<M(n)$ needs $M(n)>0$ and $\max\lvert a_i\rvert<1$. Passage A says the strictness rests on $M(n)>0$, which is accurate.
- $\max\lvert a_i\rvert<1$: for any $i$, $k\ge2$ gives $j\ne i$, and $a_i^2\le1-a_j^2<1$ since $a_j\ne0$.

Edge $k=2$, $a_1^2=a_2^2=\tfrac12$: $\max\lvert a_i\rvert=\tfrac1{\sqrt2}$ and $\sum\lvert a_i\rvert^3=2\cdot\tfrac1{2\sqrt2}=\tfrac1{\sqrt2}$, so the middle inequality is an equality and the strict one still holds with margin $M(n)(1-\tfrac1{\sqrt2})>0$. Pieces with $P(A_i)<0$: the first bullet covers them. CONFIRMED.

## 6. Claim 7, $M(n)>0$ against Proposition 2.25

**Which $(k,l)$.** $(k,l)=(2,n-2)$ has $k,l\ge2$ for every $n\ge4$, and so does $(n-2,2)$. At $n=4$ the only choice is $(2,2)$.

**The formula.** The .txt gives $\theta_{k,l}=\sqrt2\cdot\sqrt{\tfrac{k-1}k\cdot\tfrac{l-1}l\cdot\tfrac{n-1}{n-2}}$ with the root over the triple product, which is Passage A's formula. Two cross-checks pin the reading. At $k=l=n/2$ it reduces to $\sqrt2\cdot\tfrac{n-2}n\sqrt{\tfrac{n-1}{n-2}}=\tfrac1n\sqrt{2(n-1)(n-2)}$, Nienhaus's own even-$n$ value $\theta_n$ printed after the proof. And the screen below reproduces $\theta_{2,2}$. At $k,l\ge2$ and $n\ge4$ every factor is positive, so $\theta_{k,l}>0$.

**Unit element.** Nienhaus defines $W_{S_{k,l}}=\widetilde W_{S_{k,l}}/\lVert\widetilde W_{S_{k,l}}\rVert$, the Weyl part of an Einstein operator, normalised. The proof ends "by scaling the operator", with $\theta_{k,l}=(k-1)/\lVert\widetilde W\rVert$ and $P(W_{S_{k,l}})=\langle\theta W,W\rangle=\theta$.

**Conventions match.** The record's $\mathrm{id}^\#=(n-2)\mathrm{id}$ and Nienhaus's $\mathrm{id}\#\mathrm{id}(v,w)=-\tfrac12\mathop{\mathrm{tr}}(\mathrm{ad}_v\mathrm{ad}_w)$ agree: with $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$ on $\mathfrak{so}(n)$ the Killing form is $(n-2)\mathop{\mathrm{tr}}(XY)=-2(n-2)\langle X,Y\rangle$, giving $(n-2)\mathrm{id}$. On a diagonal operator with entries $\lambda_{ij}$, the record's formula gives $(W^\#)_{ik,ik}=\tfrac12\cdot2\sum_{j}\lambda_{ij}\lambda_{jk}$ (the two ordered pairs $(e_{ij},e_{jk})$ and $(e_{jk},e_{ij})$ with $c=\pm1$), and off-diagonal entries vanish since $c_{acd}c_{bcd}\ne0$ forces $a=b$. That is Nienhaus Lemma 2.22(b). The norm is the trace on $\Lambda^2$ with $\{e_i\wedge e_j\}$ orthonormal in both.

**Screen at $n=4$, $(k,l)=(2,2)$, $r=1$.** In $\widetilde R$ form (the $4\times4$ symmetric zero-diagonal matrix of Lemma 2.22), $\widetilde W_{12}=\widetilde W_{34}=\tfrac23$ and $\widetilde W_{13}=\widetilde W_{14}=\widetilde W_{23}=\widetilde W_{24}=-\tfrac13$, matching Nienhaus's block formula $\tfrac l{n-1}$, $\tfrac{k(k-1)}{(l-1)(n-1)}$, $-\tfrac{k-1}{n-1}$. Column sums are $0$, so it is Weyl (Lemma 2.21). Entry $12$: $\widetilde W_{12}^2+\sum_{m}\widetilde W_{1m}\widetilde W_{m2}=\tfrac49+\tfrac19+\tfrac19=\tfrac23=1\cdot\widetilde W_{12}$. Entry $13$: $\tfrac19+(\tfrac23)(-\tfrac13)+(-\tfrac13)(\tfrac23)=-\tfrac13=1\cdot\widetilde W_{13}$. So $Q(\widetilde W)=\widetilde W$, $\lVert\widetilde W\rVert^2=2\cdot\tfrac49+4\cdot\tfrac19=\tfrac43$, and the unit operator has $P=(\tfrac43)^{-1/2}=\tfrac{\sqrt3}2=\theta_{2,2}$. Screen agrees. CONFIRMED.

### 6.1 Candidate, withdrawn: "$S^k\times S^l$" names the wrong manifold

1. Located: Passage A "since $S^k\times S^l$ with $k,l\ge2$ has $P(W_{S_{k,l}})=\theta_{k,l}$", Passage C landscape and detail "$S^k\times S^l$ with $k,l\ge2$ has $P=\theta_{k,l}$". Nienhaus's object is $S_{k,l}=S^k\times S^l_r$ with $r=\sqrt{(l-1)/(k-1)}$.
2. Exhibited: at $(k,l)=(2,3)$ the unit-radius product has Ricci eigenvalues $1$ on $S^2$ and $2$ on $S^3$, so it is not Einstein and is not the operator Proposition 2.25 treats.
3. Opposite: Passage A's subscript $W_{S_{k,l}}$ and the symbol $\theta_{k,l}$ both name Nienhaus's $S_{k,l}$, and $M(n)>0$ needs one instance only. At even $n$ with $k=l$, $r=1$ and the two coincide. The charitable reading, $S^k\times S^l$ as shorthand for $S_{k,l}$, is what the argument uses.

Withdrawn. Wording note: write $S^k\times S^l_r$ or $S_{k,l}$.

## 7. Claim 8, the absolute-value remark

$(\tfrac35)^2+(\tfrac45)^2=\tfrac{9}{25}+\tfrac{16}{25}=1$. With $P(A_1)=M$, $P(A_2)=-M$: $P(W)=\tfrac{27}{125}M+(-\tfrac{64}{125})(-M)=\tfrac{91}{125}M$. The unsigned chain gives $M(\tfrac{27}{125}-\tfrac{64}{125})=-\tfrac{37}{125}M$, and $-\tfrac{37}{125}M<\tfrac{91}{125}M$, so it would assert a false bound. Both numbers exact.

Can pieces at $\pm M$ meet the definition? A piece at $-M$ is $-B$ for a maximizer $B$ (oddness), and $\circ$-orthogonality is insensitive to the sign. So the question is whether two $\circ$-orthogonal maximizers exist at some $n$. The passages do not claim they do, and the remark's point, that $a_i^3P(A_i)\le a_i^3M$ is invalid at $a_i<0$, holds without realisation. No finding.

### 7.1 Candidate, withdrawn: "the chain fails at any negative coefficient"

1. Located: Passage A, "with $a_i^3$ in place of $\lvert a_i\rvert^3$ the chain fails at any negative coefficient".
2. Exhibited: at $a_i<0$ the termwise step $a_i^3P(A_i)\le a_i^3M$ is equivalent to $P(A_i)\ge M$, which holds when $P(A_i)=M$. So at a negative coefficient on a maximizing piece the step holds, with equality.
3. Opposite: "fails" reads naturally as "is no longer a valid argument once negative coefficients are admitted", which is true, and the worked example is exactly a failing instance.

Withdrawn.

## 8. Claims 9 and 10, what the proof uses, and the run-cited paragraph

**Claim 9.** Tracing Sections 3 to 5: the proof uses total symmetry of $T$, oddness of $P$, the five definition clauses, $M(n)>0$, and nothing about criticality, padding, monotonicity of $M$, the harmonic-square law, or the pieces' support. "With $A_i\circ A_j=0$ as the hypothesis ... criticality never enters" is accurate. CONFIRMED.

**Claim 10.** "Criticality with ordinary orthogonality is a different hypothesis from $\circ$-orthogonality. A run at $n=8$ found two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ with $\lVert A\circ B\rVert\approx0.664$, and a rotated $S^4\times S^4$ pair at $\approx0.273$. No closed-form witness is on file." The claim rests on a run and the passage says so. Graded HYPOTHESIS-DEBT. What would discharge it: two explicit unit critical points $A,B\in\mathcal W_n$ with $\langle A,B\rangle=0$ and an exact nonzero entry of $A\circ B$. The lemma's proof does not use this paragraph, so the debt does not reach L66.

## 9. Claim 11, Passage C detail

- "$\lvert P(W)\rvert\le\sum_i\lvert a_i\rvert^3\lvert P(A_i)\rvert\le M(n)\max_i\lvert a_i\rvert<M(n)$": the triangle inequality on $\sum a_i^3P(A_i)$ gives the first step, Sections 4 and 5 the rest. This is two-sided and implies Passage A's one-sided $P(W)<M(n)$. Consistent.
- "The bound runs against $M(n)$ rather than against $\max_i\lvert P(A_i)\rvert$, which reads $0<0$ at a splitting whose every piece has $P(A_i)=0$": with $m=\max_i\lvert P(A_i)\rvert$ the analogous chain ends $m\max\lvert a_i\rvert<m$, false at $m=0$. Exact.
- "Bounds nothing about the summands' support dimensions, so it supplies no induction on $n$": a scope remark, accurate to the argument, which never reads supports.
- "$T$ is fully symmetric and $T(A_i,A_j,\cdot)=\langle A_i\circ A_j,\cdot\rangle$, so every term of $T(W,W,W)$ carrying two distinct indices vanishes": Section 3.

CONFIRMED.

## 10. Claim 12, Passage C landscape

- Given the harmonic-square law $\tfrac1{\theta^2}=\tfrac1{\theta_A^2}+\tfrac1{\theta_B^2}$ with both terms positive, $\tfrac1{\theta^2}>\tfrac1{\theta_A^2}$ and $>\tfrac1{\theta_B^2}$, so $\theta^2<\min(\theta_A^2,\theta_B^2)$ and $\lvert\theta\rvert<\min(\lvert\theta_A\rvert,\lvert\theta_B\rvert)$. The law itself is cited to a file outside the brief and I did not check it.
- "As one coefficient tends to $1$, $P(W)$ tends to that piece's own value": with the pieces fixed, $a_1\to\pm1$ forces $a_i\to0$ for $i\ge2$, and $\sum a_i^3P(A_i)\to\pm P(A_1)$, which is $P(\pm A_1)$. So the $\min$ bound cannot hold without criticality, which is what the sentence says.

CONFIRMED AS ALGEBRA.

## 11. Claim 13, the Lean files against Passages A to C

**L66Statement.lean.**

- $E$ is an abstract real normed space, $T$ an abstract trilinear form, $\mathrm{Pf}\,T\,X=T\,X\,X\,X$. The Weyl instance is not built. $P=\mathrm{Pf}\,T$ holds under either slot convention since $P(W)=T(W,W,W)$.
- $\mathrm{IsCircDecomposable}$: $\exists\,k\,a\,A$ with $2\le k$, $\lVert A_i\rVert=1$, $\sum a_i^2=1$, $a_i\ne0$, $\forall X\,i\,j,\ i\ne j\to T\,X\,(A_i)\,(A_j)=0$, $W=\sum a_i\cdot A_i$. Binders and order match the definition.
- $\circ$-orthogonality enters as $\mathrm{horth}$, orthogonality in slots 2 and 3 for every first argument. With Passage A's convention $T(X,Y,Z)=\langle X,Y\circ Z\rangle$ this is implied by $A_i\circ A_j=0$ directly. With the conventions' $\langle X\circ Y,Z\rangle$ it is implied after one use of symmetry. Only the direction "definition implies $\mathrm{horth}$" is needed for the theorem to apply, and it holds in both readings. (The converse would need $A_i\circ A_j\in\mathcal W_n$, which Nienhaus Lemma 2.13 supplies.)
- Symmetry enters as $\mathrm{hsym12}$ only, slots 1 and 2. $\mathrm{Pf\_additive}$ uses it once, at $T(A_i)(A_j)(A_j)=T(A_j)(A_i)(A_j)$, matching Section 3's single slot move. Under Passage A's convention $\mathrm{hsym12}$ is self-adjointness of $L_Z$, the nontrivial half of total symmetry. The Lean hypotheses are weaker than total symmetry, so the Lean theorem is a generalisation of the written one.
- $\mathrm{Pf\_lt\_max}$: $\mathrm{hodd}$ is oddness, $\mathrm{habs}$ is Section 4, $\mathrm{hterm}$ is the first chain step, $\mathrm{sum\_abs\_cube\_lt\_one}$ proves $\sum\lvert a_i\rvert^3<1$ directly from $\lvert a_i\rvert^3=\lvert a_i\rvert a_i^2<a_i^2$, which reaches the same conclusion as $\le\max\lvert a_i\rvert<1$.
- $\mathrm{no\_maximizer\_is\_circDecomposable}$: hypotheses $\mathrm{hsym12}$, $0<M$, $\forall B,\ \lVert B\rVert=1\to\mathrm{Pf}\,T\,B\le M$, $\mathrm{Pf}\,T\,W=M$. Conclusion $\neg\,\mathrm{IsCircDecomposable}\,T\,W$. Direction correct. $\lVert W\rVert=1$ is bound as $\_hWnorm$ and unused, matching Section 1.
- What enters as hypothesis rather than proof: the concrete $T$ on $\mathcal W_n$, its symmetry, and $M(n)>0$ (Nienhaus). All three are written down in the passages, so the Lean statement records its bridge honestly.
- The example with $T=0$ on $\mathbb R^2$ shows the abstract definition is satisfiable. It is not a Weyl witness.

**L66.lean.** $\mathrm{strict\_below}$ takes additivity as the hypothesis $\mathrm{hadd}$ and proves the chain against $\max(\lvert a_j\rvert,\lvert a_k\rvert)$ with a bound hypothesis selecting the maximum. The witness theorems are Section 7's numbers, all exact: $\tfrac{9}{25}+\tfrac{16}{25}=1$, $\tfrac{91}{125}$, $-\tfrac{37}{125}$, margin $\tfrac{128}{125}$. $\mathrm{theta0\_four}$ ($2\cdot3\cdot2/16=\tfrac34$), $\mathrm{M4\_exceeds}$ and $\mathrm{M4\_ratio}$ are correct arithmetic that corresponds to no sentence of Passages A to C. No finding against L66.

I read the proof terms and did not build them. CONFIRMED as a statement of the claim.

## 12. Claim 14 and the boundary (brief item 11)

**$n=4$.** $\Lambda^2\mathbb R^4=\Lambda_+\oplus\Lambda_-$ with $[\Lambda_+,\Lambda_-]=0$, and $\mathcal W_4=\mathcal W_+\oplus\mathcal W_-$. Screen: for unit $A_+\in\mathcal W_+$, $A_-\in\mathcal W_-$, $A_+A_-=0$ since their supports on $\Lambda^2$ are orthogonal, and $(A_+\#A_-)_{ab}=\tfrac12\sum c_{acd}c_{bef}(A_+)_{ce}(A_-)_{df}$ needs $c\in\Lambda_+$, $d\in\Lambda_-$ with $c_{acd}\ne0$, which $[\Lambda_+,\Lambda_-]=0$ excludes. So $A_+\circ A_-=0$ and $W=\tfrac1{\sqrt2}(A_++A_-)$ is $\circ$-decomposable with $k=2$, $a_1^2=a_2^2=\tfrac12$. The lemma is not vacuous at $n=4$.

**Every $n\ge4$, padded.** Pad $A_\pm$ by zeros into $\mathcal W_n$ (Ricci stays zero, Bianchi is preserved). The structure constants of $\mathfrak{so}(4)\subset\mathfrak{so}(n)$ in the basis $e_i\wedge e_j$ are the restricted ones, so the same argument gives $A_+\circ A_-=0$. These padded objects have $\ker W\ne0$, and nothing in the proof reads invertibility or kernel. Screens only, not required by the lemma.

**Pieces with $P(A_i)<0$**: covered in Section 5. **$n=4$ with $(k,l)=(2,2)$** for $M(4)>0$: Section 6's screen.

## 13. The standing list and the traps, answered

1. Hypothesis inventory: Section 1. One stated-but-unused hypothesis ($\lVert W\rVert=1$), harmless. No used-but-unstated hypothesis in the proof. Nienhaus's hypotheses checked against $S_{k,l}$.
2. Quantifier order: $\forall n\ge4$, $\forall$ maximizer $W$, $\neg\exists(k,a,A)$. $M(n)$ depends on $n$ only, the proof fixes an arbitrary decomposition. Lean has the same order. No finding.
3. Range edges: $n=4$ (Sections 6 and 12), $k=2$ at equal weights (Section 5), padded $\ker W\ne0$ (Section 12). No finding.
4. Proven versus used: the lemma is proved for all $\circ$-decomposable $W$ at every $n\ge4$, the family it is stated for. Proposition 2.25 is used only for one positive instance. No finding.
5. Lean states the claim: Section 11, as an abstract generalisation with the Weyl bridge as named hypotheses. No finding.

Traps: $\ker W\ne0$, no finding (Section 12). Range boundaries, no finding. Subfamily used in general, no finding. Hypothesis stated but unused, $\lVert W\rVert=1$, harmless. Used but unstated, none. Universal claim with no witness: diagonal $S_{2,2}$ screen, padded $\mathcal W_\pm$ screen, sphere products via Proposition 2.25. $\mathbb{CP}^m$ is not needed, since the lemma is a non-existence statement whose proof holds at every object. Imported result with unchecked hypotheses: checked in Sections 1 and 6.

## 14. The brief's items, by number

1. Definition: Section 2, the three agree, slot convention wording note.
2. Additivity and total symmetry: Section 3, both parts close with the $\tfrac12$ as defined.
3. $\lvert P(A_i)\rvert\le M(n)$: Section 4.
4. The chain: Section 5.
5. $\max\lvert a_i\rvert<1$: Section 5.
6. $M(n)>0$ against Proposition 2.25: Section 6, with the $S^k\times S^l$ candidate withdrawn in 6.1.
7. Absolute-value remark: Section 7, with 7.1 withdrawn.
8. Criticality remarks and the run: Section 8, the run paragraph HYPOTHESIS-DEBT.
9. Passage C: Sections 9 and 10.
10. Passage E: Section 11.
11. Boundary: Sections 5 and 12.

## 15. What would break it

- A $\circ$-decomposable unit $W$ with $P(W)=M(n)$. The proof excludes it by a chain every step of which I checked, so a counterexample would have to break total symmetry of $T$ or oddness of $P$. I looked for it by attacking the symmetry at index level (Section 3) and by screening the decomposable family at $n=4$, where $P(W)=\tfrac1{2\sqrt2}(P(A_+)+P(A_-))\le\tfrac1{\sqrt2}M(4)<M(4)$, in line with the lemma.
- A dimension $n\ge4$ with $M(n)\le0$. Excluded by $(k,l)=(2,n-2)$ in Proposition 2.25, whose conventions I matched to the record's and whose value I screened at $n=4$.
- A convention mismatch between the record's $\#$ and Nienhaus's that changed the sign of $P$ on $S_{k,l}$. Excluded in Section 6 on the diagonal class.

## 16. Verdict

**PROVEN.**

Staged files at the time of my commit: `git status` showed a clean index before I staged this report, so no other file was staged alongside it.
