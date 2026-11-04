# REVIEW r392, Gate 2 on I18's $\mathcal D_n$ clause: every constant is right, the inequality is the wrong statement, and the form is already on record

*Adversarial review of the last section of [ATTEMPTS.md](../ATTEMPTS.md), "I18's $\mathcal D_n$ clause is the polarisation of the value formula". Derived cold from the definitions before the section was opened, the value cubic, the second variation, the $\langle X,L_eX\rangle$ formula and the full $\mathcal D_n$ spectrum at $S^p\times S^q$ were all obtained from criticality alone, then compared. Analysis only; the two numerical runs are screens of claims derived by hand first, reported as screens, and each agreed to every digit shown.*

## Verdict table

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | $F(M)=\tfrac12(\langle M,M\circ M\rangle+\mathop{\mathrm{tr}}M^3)$ is the value, $d^2F(X)=3(\langle M,X\circ X\rangle+\mathop{\mathrm{tr}}(MX^2))$, $\mu=3\theta/2$ | **CONFIRMED, every constant.** Derived cold: criticality forces the cubic up to scale, and [Lemma L24](../findings/second-order.md)'s $6\theta$ independently pins that scale |
| 2 | $\langle X,L_eX\rangle=\dfrac{\langle M,X\circ X\rangle+\mathop{\mathrm{tr}}(MX^2)}{2\theta}$ | **CONFIRMED.** The $2\theta$ denominator is right *given* $\langle A,B\rangle=\sum_{a,b}A_{ab}B_{ab}$ (both index orders) and $\lVert X\rVert^2=\tfrac12\mathop{\mathrm{tr}}X^2$. Equivalently $\langle X,L_eX\rangle=\tfrac1\theta\sum_{a<b}M_{ab}\big(X_{ab}^2+(X^2)_{ab}\big)$ |
| 3 | the boxed clause $\langle M,X\circ X\rangle+\mathop{\mathrm{tr}}(MX^2)<\tfrac\theta2\mathop{\mathrm{tr}}X^2$ on $\mathcal D_n\cap M^\perp$ | **The $\theta/2$ is the right constant** (the box is exactly $\langle X,L_eX\rangle<\tfrac12\langle X,X\rangle$), **but the statement is CORRECTED: it is not the clause.** It is $\lambda_{\max}(L_e|_{\mathcal D_n\cap M^\perp})<\tfrac12$, strictly stronger than "$\tfrac12$ is not an eigenvalue", which is what [Lemma L128](../findings/second-order.md)(ii) and [I18](../plan.md) ask. **Two record witnesses where the box fails at a pure critical point** |
| 4 | $X\perp M$ is the right orthogonality; the constraint surface | **CONFIRMED.** Frobenius and Weyl orthogonality are proportional, so $X\perp M$ is unambiguous and is exactly $T_M\{g=1\}$; $g=\tfrac12\mathop{\mathrm{tr}}M^2=1$ *is* $\lVert W\rVert=1$; $\mathcal D_n$ is linear, so it needs no multiplier of its own. **One hypothesis is used silently**, that $\mathcal D_n$ is $L_e$-invariant |
| 5 | "it is the value formula polarised, term for term" | **CONFIRMED as structure**: $\langle X,L_eX\rangle=F(M,X,X)/\theta$ with $F$ the same cubic, and $X=M$ returns criticality. **The polarisation is genuine, not decorative** |
| 6 | "that is why [diagonal-half.md](../findings/diagonal-half.md)'s $98.18\%$ split bears on it directly … the same two-term balance survives one differentiation" | **REFUTED.** The split does not transfer. Entrywise share of the polarised form at $S^6\times S^6$: $45.5\%$, an exact cancellation, $7.27\%$, $1.82\%$ on the four $\mathcal D_n$ eigendirections. At $S^5\times S^7$ the **binding** direction's entrywise term is **negative** |
| 7 | is the clause TRUE at the in-band points? | **CONFIRMED at every $S^p\times S^q$, with the exact spectrum.** $\lambda_{\max}$ off $M$ is $\dfrac{Q-2}{2(Q-1)}$, $Q=\max(p,q)$; margin $\dfrac1{2(Q-1)}$, $\tfrac1{10}$ at $S^6\times S^6$, $\tfrac1{12}$ at $S^5\times S^7$, decaying like $1/n$ |
| 8 | "screened against [findings/](../findings/) for the two-term form, nothing found" | **REFUTED.** The two-term Rayleigh form, the operator $L_e=\mathcal L/\theta$ and the boxed inequality itself are all in [diagonal-half.md:126–147](../findings/diagonal-half.md), the file the section cites two paragraphs later for the split |

## What the cold derivation gives, and it agrees with the section

**The cubic is forced.** On hollow symmetric matrices the two cubics with the right gradient are $A(M)=\sum_{a<b}M_{ab}^3$, with pair-gradient $3M_{ab}^2$, and $\mathop{\mathrm{tr}}M^3$, with pair-gradient $6(M^2)_{ab}$. Diagonal criticality $M_{ab}^2+(M^2)_{ab}=\theta M_{ab}$ therefore forces the combination $P=A+\tfrac12\mathop{\mathrm{tr}}M^3=\tfrac12(\langle M,M\circ M\rangle+\mathop{\mathrm{tr}}M^3)$ up to scale, with $\nabla P=3\theta M$ on $\mathcal D_n$ and $P(M)=\tfrac13\langle\nabla P,M\rangle=\theta$ at $\lVert W\rVert=1$. **The scale is then pinned twice over**: by $P(W)=\theta$ and, independently, by the $6\theta$ in [Lemma L24](../findings/second-order.md).

**The second variation.** $P(M+tX)$ has $t^2$-coefficient $3\sum_{a<b}M_{ab}X_{ab}^2+\tfrac32\mathop{\mathrm{tr}}(MX^2)$, so $d^2P(X)=3(\langle M,X\circ X\rangle+\mathop{\mathrm{tr}}(MX^2))=6P(M,X,X)$, and on the unit sphere $\mathrm{Hess}=d^2P-3P\langle X,X\rangle$ with $3P=3\theta$ the multiplier. Against [Lemma L24](../findings/second-order.md):

$$\langle X,L_eX\rangle=\frac{P(M,X,X)}{\theta}=\frac{\langle M,X\circ X\rangle+\mathop{\mathrm{tr}}(MX^2)}{2\theta}=\frac1\theta\sum_{a<b}M_{ab}\big(X_{ab}^2+(X^2)_{ab}\big).$$

**Every constant in the section survives.** The $2\theta$ denominator, the $\theta/2$ on the right, the multiplier $3\theta/2$, the cancellation of the $\lVert X\rVert^2$ terms, all correct, and the $\lVert X\rVert^2=\tfrac12\mathop{\mathrm{tr}}X^2$ conversion is applied consistently on both sides. *There is no factor discrepancy anywhere in the derivation.* The one place a factor could have hidden is the $\langle\cdot,\cdot\rangle$ convention, and the section's definition $\langle A,B\rangle=\sum_{a,b}A_{ab}B_{ab}$ over **both** index orders is what makes $2\theta$ right rather than $\theta$; this matches [diagonal-half.md:147](../findings/diagonal-half.md)'s "the $\Lambda^2$ pairing is half of it".

## Defect 1, the strict inequality is not the clause, and the record has witnesses

**Three statements, strictly nested.**

| | statement | meaning |
| --- | --- | --- |
| (A) | $\tfrac12\notin\mathop{\mathrm{spec}}(L_e|_{\mathcal D_n\cap M^\perp})$ | **what [Lemma L128](../findings/second-order.md)(ii) and [I18](../plan.md) ask**, $L_e-\tfrac12$ invertible on the block |
| (B) | $\langle X,L_eX\rangle\ne\tfrac12\langle X,X\rangle$ for all $X\ne0$ | $L_e-\tfrac12$ **definite** on the block |
| (C) | the boxed $<$ | $L_e-\tfrac12$ **negative** definite: $W$ is a strict local maximum of $P$ along $\mathcal D_n$ |

(C) $\Rightarrow$ (B) $\Rightarrow$ (A), and both implications are strict. (B) is stronger than (A) because the Rayleigh quotient is continuous on a connected sphere, so an indefinite $L_e-\tfrac12$ **attains** the value $0$ while having no kernel. **The section's "So the clause is one inequality with no $L_e$ in it" asserts an equivalence with (A), and that is false.**

**This is the correction [r373](REVIEW_r373.md) and [r374](REVIEW_r374.md) already made, to the neighbouring clause, on the same day.** [plan.md](../plan.md) records it: "the four-set target is $\Sigma\ne\theta^2$, not $\Sigma<\theta^2$, a block **above** $\tfrac12$ leaves the point nondegenerate, and $S^2\times S^4$ is the witness", and [post F48](../findings/INDEX-traps.md) names the general trap as proving a sufficient condition strictly stronger than the clause. The $\mathcal D_n$ section reintroduces it verbatim.

**And it is not a formality here: the record carries pure critical points where (C) fails inside $\mathcal D_n$.** [diagonal-half.md:134–135](../findings/diagonal-half.md) lists the diagonal $\lambda_{\max}$ against the full-space one:

| point | $\lambda_{\max}(L_e|_{W^\perp})$ | diagonal | (C) |
| --- | --- | --- | --- |
| $C_5$ blow-up, $n=10$, $\theta=0.670820$ | $1.206011$ | $1.206011$, **equal** | **fails** |
| unpadded $n=9$ witness, $\theta=0.641091$ | $1.303584$ | $1.303584$, **equal** | **fails** |

At both, the top eigendirection lies in $\mathcal D_n$ and is orthogonal to $W$, automatic, since $L_eM=M$ and $1.206\ne1$, and confirmed at the blow-up by the orbit component $1.1\times10^{-15}$ recorded at [bounds.md:36](../findings/bounds.md). **Both sit below the band** ($\theta<\sqrt{3/2}$), so neither refutes the box *within* [I18](../plan.md)'s hypotheses, but they refute it as a restatement of the clause, and they show the band is doing all the work in (C) while (A) needs none of it.

**The correct $L_e$-free form of the clause is an eigen-equation, not an inequality.** Polarising the Rayleigh form gives the operator, the one [diagonal-half.md:126](../findings/diagonal-half.md) already states, with the hollowing [diagonal-half.md:147](../findings/diagonal-half.md) already insists on:

$$\boxed{\ \text{the clause is: } \mathop{\mathrm{hollow}}\!\big(M\circ X+\tfrac12(MX+XM)\big)=\tfrac\theta2X \text{ has no solution } 0\ne X\in\mathcal D_n.\ }$$

The hollowing preserves $\mathcal D_n$ (the row sums cancel, screened to $2\times10^{-16}$ at $(p,q)=(2,4),(2,10),(3,3),(5,7),(6,6)$) and no $X\perp M$ hypothesis is needed, since an eigenvector at $\theta/2\ne\theta$ is orthogonal to $M$ automatically. *This is a linear-algebra statement about one explicit $n\times n$-supported operator, which is a better target than a quadratic-form inequality that has to be sharp to $O(1/n)$.*

## Defect 2, the two-term form is on record, in the file the section cites

The novelty line reads "screened against [findings/](../findings/) for the two-term form, nothing found". [diagonal-half.md](../findings/diagonal-half.md) has all three pieces:

- **line 126**: $\mathcal L(N)=M\circ N+\tfrac12(MN+NM)=\tfrac12D\Phi(M)[N]$, $L_e=\mathcal L/\theta$, the operator, verified there to $6\times10^{-17}$ at $S^3\times S^5$, $S^6\times S^6$ and the $C_5$ blow-up;
- **line 147**: "the Rayleigh form $\sum_{ij}M_{ij}N_{ij}^2+\mathop{\mathrm{tr}}(MN^2)$ is exact and proved, in the $n\times n$ Frobenius normalisation", the section's numerator, verbatim;
- **line 145**: "a diagonal local maximum needs $\lambda_{\max}(\mathcal L)\le\tfrac\theta2$ over hollow symmetric $N$ with zero row sums", the boxed inequality, in its correct non-strict maximiser form.

**What is actually new in the section** is the *attachment* to [I18](../plan.md)'s third clause and the reading of the numerator as a polarisation. That is worth keeping; the derivation is a re-derivation. *The same file also supplies the caveat the section omits: the restriction to $\mathcal D_n$ is **strictly lossy**, so the $\mathcal D_n$ clause can never certify nondegeneracy on its own, which is why [I18](../plan.md) has three clauses and not one.*

## Defect 3, the $98.18\%$ split does not survive the differentiation

**The structural half is right**: the polarised form carries the same entrywise and spectral terms, one degree lower. **The quantitative half is not.** Splitting $\langle M,X\circ X\rangle+\mathop{\mathrm{tr}}(MX^2)$ per $\mathcal D_n$ eigendirection, at $\mathop{\mathrm{tr}}X^2=1$:

| point | direction | $L_e$ value | entrywise | spectral | entrywise share |
| --- | --- | --- | --- | --- | --- |
| $S^6\times S^6$ | $X=M$ | $1$ | $0.022473$ | $1.213560$ | $1.82\%$, reproduces the record's split |
| | $\mathcal D_p\oplus\mathcal D_q$ | $0$ | $+0.134840$ | $-0.134840$ | **exact cancellation** |
| | $S^2_0\otimes S^2_0$ | $-\tfrac15$ | $-0.112367$ | $-0.134840$ | $45.5\%$ |
| | **binding**, $S^2_0(\mathbb R^6)$ | $\tfrac25$ | $+0.035957$ | $+0.458456$ | $7.27\%$ |
| $S^5\times S^7$ | $X=M$ | $1$ | $0.042802$ | $1.185437$ | $3.48\%$ |
| | **binding**, $S^2_0(\mathbb R^7)$ | $\tfrac5{12}$ | $\mathbf{-0.009305}$ | $+0.521071$ | $\mathbf{-1.82\%}$ |

In closed form, the entrywise share of the binding direction is

$$\frac{2\big[p^2-(q-1)(q-2)\big]}{(n-1)(n-2)(q-2)},\qquad q=\max(p,q),$$

which **changes sign** at $p^2=(q-1)(q-2)$ (positive at $S^6\times S^6$, negative at $S^5\times S^7$) while the value's share $\tfrac1{(2m-1)(m-1)}$ at $p=q=m$ is positive always. Their ratio is $(3m-2)/(m-2)$: exactly $4$ at $m=6$, tending to $3$. **So the balance does not survive one differentiation**, it is off by a factor of three to four at the balanced products and inverted in sign at the unbalanced ones. *The $98.18\%$ figure is a fact about one direction, $X=M$, and the clause is a statement about the directions orthogonal to it.*

## The clause is true at the in-band points, and here is the whole spectrum

**Derived cold from the polarised form, then checked against [Lemma L127](../findings/second-order.md).** For $X=\begin{pmatrix}x&Y\\Y^\top&y\end{pmatrix}\in\mathcal D_n$ at the two-block point ($\alpha$ within $p$, $\beta$ within $q$, $\gamma$ across, $\theta=-(n-1)\gamma$), the numerator collapses to a function of $Y$ alone:

$$\langle M,X\circ X\rangle+\mathop{\mathrm{tr}}(MX^2)=(\alpha+\beta-2\gamma)\big[\lvert Y\mathbf1\rvert^2+\lvert Y^\top\mathbf1\rvert^2-\lVert Y\rVert_F^2\big],$$

because the zero row sums pin $x\mathbf1=-Y\mathbf1$ and $y\mathbf1=-Y^\top\mathbf1$. With the identity $q(q-1)+p(p-1)+2(p-1)(q-1)=(n-1)(n-2)$ this diagonalises to

$$\sigma\big(L_e|_{\mathcal D_n}\big)=\Big\{1,\ \Big(\tfrac{q-2}{2(q-1)}\Big)^{q-1},\ \Big(\tfrac{p-2}{2(p-1)}\Big)^{p-1},\ 0^{\,\frac{p(p-3)}2+\frac{q(q-3)}2},\ \Big(-\tfrac{n-2}{2(p-1)(q-1)}\Big)^{(p-1)(q-1)}\Big\},$$

the multiplicities summing to $n(n-3)/2$. **This is [Lemma L127](../findings/second-order.md)'s $\mathcal D_n$ row with $\lambda_m=(m-2)/(2(m-1))$ and $\mu=(n-2)/(2(p-1)(q-1))$, reproduced independently**, and it identifies each summand: $\lambda_p$ on the traceless-diagonal part of $S^2_0(\mathbb R^p)$, $-\mu$ on that of $S^2_0\otimes S^2_0$, $0$ on $\mathcal D_p\oplus\mathcal D_q$, and **no $\tfrac12$**, since $\mathcal D_n\cap(\mathbb R^p\otimes\mathbb R^q)=0$, which is [Lemma L128](../findings/second-order.md)(i)'s "$\mathcal D_n$ carries no orbit direction", re-proved. *Screened against a generalised eigenproblem on an explicit $\mathcal D_n$ basis at $(p,q)=(2,4),(2,10),(3,3),(4,4),(5,7),(6,6),(3,10)$: agreement to $10^{-15}$.* **It also holds at $p=2$**, where [Lemma L27](../findings/nondegeneracy.md)'s summand decomposition over-counts, the $\lambda_p$ eigenvalue is then $0$ and merges with the zero block. That is the one genuinely new thing this review has to offer, and it is small.

**So the clause is true at every $S^p\times S^q$, with margin $\tfrac1{2(Q-1)}$, $Q=\max(p,q)$**, and the box's ratio $\mathrm{LHS}/\mathrm{RHS}=2\lambda$ is $0.800$ at $S^6\times S^6$ and $0.833$ at $S^5\times S^7$. **$S^5\times S^7$ is the tighter of the two in-band points**, not $S^6\times S^6$, and the binding eigenvalue belongs to the **larger** factor. The margin decays like $1/n$, which is the pair clause's decay exactly, and the record already knows this: [ATTEMPTS.md](../ATTEMPTS.md) records "the margin is **tied**, not owned by the pair block: [Lemma L121](../findings/second-order.md) puts the same $(p-2)/(2(p-1))$ inside $\mathcal D_n$ as well" ([r375](REVIEW_r375.md), [r376](REVIEW_r376.md)). **So the section's "why this clause is in better shape than the other two" is overstated on this axis**: the $\mathcal D_n$ clause inherits the same $1/n$ margin, so it is closed to a perturbation off the balanced product for the same reason, and the "first thing to try is [Lemma L57](../findings/problem.md)'s own machinery" runs into the same wall, L57 is a statement about the *maximum* of $F$, hence about (C), and (C) is the statement this review says is not the clause.

## Hypotheses used silently

1. **$\mathcal D_n$ is $L_e$-invariant.** The section computes the second variation of $F$ *restricted to* $\mathcal D_n$ and calls the result "the $\mathcal D_n$ block". Restriction of a quadratic form to a subspace is the block only when the subspace is invariant. It is, [diagonal-half.md:126](../findings/diagonal-half.md) proves it combinatorially and [Lemma L120](../findings/second-order.md) gives it as a sign-character block, but the section cites neither.
2. **$\theta>0$**, used to divide by $2\theta$ without reversing the inequality. Granted by the band and by [Lemma L128](../findings/second-order.md)'s hypotheses; unstated here.
3. **The hollowing.** The Rayleigh form is insensitive to it (a hollow $X$ annihilates any diagonal), so the *form* is safe, but the eigen-equation form of the clause is not, and [diagonal-half.md:147](../findings/diagonal-half.md)'s "the operator identity is off by a diagonal … measured up to $0.19$" is the warning that applies the moment the clause is read as the eigenvalue statement it is.
4. **$F$ is the value on the diagonal locus** and $\lVert W\rVert^2=\tfrac12\mathop{\mathrm{tr}}M^2$, both on record in [diagonal-half.md](../findings/diagonal-half.md), both correctly used.

## What should change in the record

- **Replace the box.** Keep the identity $\langle X,L_eX\rangle=(\langle M,X\circ X\rangle+\mathop{\mathrm{tr}}(MX^2))/2\theta$, which is right and useful; state the clause as the eigen-equation above, and demote the strict inequality to what it is, a sufficient condition, equivalent to "$W$ is a strict local maximum along $\mathcal D_n$", false at the $C_5$ blow-up and at the unpadded $n=9$ witness.
- **Withdraw the novelty line** and cite [diagonal-half.md:126–147](../findings/diagonal-half.md) instead.
- **Withdraw "the split bears on it directly"**, or restate it as the sign-change fact above, which is a real and checkable statement about the same two terms.
- **Add the $\mathcal D_n$ spectrum** in the closed form above to [Lemma L127](../findings/second-order.md)'s row as a second, representation-theory-free proof valid at $p=2$.
