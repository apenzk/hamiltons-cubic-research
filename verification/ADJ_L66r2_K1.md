# Adjudication brief, round L66-r2, step K1

**Cold brief. The passages are quoted verbatim with their source lines.**

## The step

From Passage A's paragraph beginning "**Criticality with ordinary orthogonality is a different hypothesis from $\circ$-orthogonality.**"

**The step: there exist critical unit elements $A,B$ of $\mathcal W_n$ for some $n\ge4$, meaning $Q(A)=\theta_AA$ and $Q(B)=\theta_BB$, with $\langle A,B\rangle=0$ and $A\circ B\ne0$, so criticality together with Frobenius orthogonality does not imply $\circ$-orthogonality, and the paragraph establishes this.**

## Passage A, the section carrying the argument ([findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 1-17)

# Every maximiser is $\circ$-indecomposable, one line

> **Definition.** $W$ is **$\circ$-decomposable** if $W=\sum_{i=1}^k a_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathrm{Weyl}_n$, $\sum a_i^2=1$, all $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$.

> **Theorem.** *For $n\ge4$, no maximiser of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $\circ$-decomposable.* At $n\le3$, $\mathrm{Weyl}_n=0$.

**Proof.** Write $M(n)=\max\{P(A):A\in\mathcal W_n,\lVert A\rVert=1\}$ for the global maximum; $M(n)>0$ at every $n\ge4$, since $S^k\times S^l$ with $k,l\ge2$ has $P(W_{S_{k,l}})=\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}k\cdot\frac{l-1}l\cdot\frac{n-1}{n-2}}>0$ ([Nienhaus, Proposition 2.25](../references/nienhaus-2023-second-best-einstein/notes.md)), and **the final inequality below is strict only because of that**. $A_i\circ A_j=0$ makes $P$ **additive**: $P(W)=\sum_ia_i^3P(A_i)$. *That step uses the **total** symmetry of $T(X,Y,Z)=\langle X,Y\circ Z\rangle$*, the cross term $\langle A_i,Q(A_j)\rangle=T(A_i,A_j,A_j)$ dies only after moving the first slot to $\langle A_j,A_i\circ A_j\rangle=0$. The full symmetry is proved in Lemma L24's argument at [second-order.md](../findings/second-order.md): the $W^2$ part is the symmetrisation of $\mathop{\mathrm{tr}}(XYZ)$, and permuting the arguments of the $\#$ part permutes the slots of both totally antisymmetric structure constants, at sign $(-1)^2$. Hence
$$P(W)=\sum_ia_i^3P(A_i)\;\le\;M(n)\sum_i\lvert a_i\rvert^3\;\le\;M(n)\max_i\lvert a_i\rvert\;<\;M(n),$$
using $\sum_i\lvert a_i\rvert^3\le\max_i\lvert a_i\rvert\cdot\sum_ia_i^2=\max_i\lvert a_i\rvert$, and $\max_i\lvert a_i\rvert<1$ because $\sum a_i^2=1$ with $k\ge2$ and every $a_i\ne0$. $\square$

*The absolute values are load-bearing: with $a_i^3$ in place of $\lvert a_i\rvert^3$ the chain fails at any negative coefficient, and at $(a,b)=(\tfrac35,-\tfrac45)$ with pieces at $\pm M$ it gives $P(W)=\tfrac{91}{125}M$ against a bound of $-\tfrac{37}{125}M$.*

**Criticality of the pieces is not needed.** With $A_i\circ A_j=0$ as the *hypothesis*, as the definition above states it, additivity is immediate and criticality never enters.

**Criticality with ordinary orthogonality is a different hypothesis from $\circ$-orthogonality.** *A run at $n=8$ found two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ with $\lVert A\circ B\rVert\approx0.664$, and a rotated $S^4\times S^4$ pair at $\approx0.273$. No closed-form witness is on file.*

**Nothing else is used.** No padding, no monotonicity of $M$, no harmonic-square law, and (the part that widens the reach), **no criticality of the pieces**. $A_i$ is a unit element of $\mathrm{Weyl}_n$ and $P$ is odd, so $\lvert P(A_i)\rvert\le M(n)$ outright and the pieces' support dimensions never enter.

## Passage B, the result's block in the same file ([findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 33 and 37)

#### Lemma L66, no maximizer is $\circ$-decomposable

Call $W$ *$\circ$-decomposable* if $W=\sum_{i=1}^ka_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathrm{Weyl}_n$, $\sum_ia_i^2=1$, every $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$. Then for $n\ge4$ no maximizer of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $\circ$-decomposable.

## Passage C, the canonical statement ([results.md](../results.md) line 347, landscape, and lines 1161 and 1163, detail)

- **Lemma L66 (second-order). No maximizer is $\circ$-decomposable.** Call $W=\sum_{i=1}^ka_iA_i$ $\circ$-decomposable if $k\ge2$, each $A_i$ a unit Weyl tensor, $\sum a_i^2=1$, every $a_i\ne0$ and $A_i\circ A_j=0$ for $i\ne j$. Then for $n\ge4$ no maximizer of $P$ on the unit sphere of $\mathcal W_n$ is $\circ$-decomposable. **No criticality of the pieces is needed**, which is what makes the statement reach non-critical splittings and ones sharing coordinates. At a critical point split into two critical pieces with $A\circ B=0$, the harmonic-square law $\frac1{\theta^2}=\frac1{\theta_A^2}+\frac1{\theta_B^2}$ ([nondegeneracy.md](../findings/nondegeneracy.md)) gives the sharper $\lvert\theta\rvert<\min(\lvert\theta_A\rvert,\lvert\theta_B\rvert)$. **That bound needs the criticality this lemma disclaims**: without it, as one coefficient tends to $1$, $P(W)$ tends to that piece's own value.

##### Lemma L66, no maximizer is $\circ$-decomposable

Let $W=\sum_{i=1}^ka_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathcal W_n$, $\sum_ia_i^2=1$, every $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$, where $\circ$ is the symmetric product with $\langle x\circ y,z\rangle=T(x,y,z)$. Then for $n\ge4$, $W$ is no maximizer of $P$ on the unit sphere of $\mathcal W_n$: $T$ is fully symmetric and $T(A_i,A_j,\cdot)=\langle A_i\circ A_j,\cdot\rangle$, so every term of $T(W,W,W)$ carrying two distinct indices vanishes, so $P(W)=\sum_ia_i^3P(A_i)$, and with $\lvert a_i\rvert<1$ for every $i$, $\lvert P(W)\rvert\le\sum_i\lvert a_i\rvert^3\lvert P(A_i)\rvert\le M(n)\max_i\lvert a_i\rvert<M(n)$, where $M(n)=\max\{P(A):\lVert A\rVert=1\}$ is the global maximum, positive because $S^k\times S^l$ with $k,l\ge2$ has $P=\theta_{k,l}>0$ (Nienhaus, Proposition 2.25). **The bound runs against $M(n)$ rather than against $\max_i\lvert P(A_i)\rvert$**, which reads $0<0$ at a splitting whose every piece has $P(A_i)=0$. The lemma is a statement about maximizers and bounds nothing about the summands' support dimensions, so it supplies no induction on $n$.

## Passage D, the givens the argument cites

**Lemma L24's argument, which Passage A cites for the total symmetry of $T$** ([findings/second-order.md](../findings/second-order.md) line 67):

**Argument.** $P$ is a cubic form, so $\nabla P=3Q(W)$ and the second differential is $6\,\theta\,L_e$; the constraint $\|W\|^2=1$ contributes $-3\theta\,\mathrm{Id}$ through its multiplier, leaving $6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space. Two steps the first version left implicit. **$L_e$ is self-adjoint**, so $\lambda_{\max}$ is defined at all: $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, the $W^2$ part as the symmetrisation of $\mathop{\mathrm{tr}}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$ ([r285](../reviews/REVIEW_r285.md) Claim 1). **And $W^\perp$ is $L_e$-invariant**, since $L_ee=e$ by criticality and self-adjointness then carries the complement, so the restriction is a genuine operator rather than a compression, which is [Lemma L125](../findings/second-order.md#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs) one heading below.

**Nienhaus, Proposition 2.25**, from the text extraction of the paper, [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) lines 1483-1490, with the PDF [nienhaus-2311.02404.pdf](https://arxiv.org/abs/2311.02404) beside it. Read the PDF where the extraction garbles a formula, and nothing else in that folder.

```text
Proposition 2.25. The Weyl curvature of Sk,l satisfies

                                      WS2k,l + WS#k,l = θk,l · WSk,l ,

               √        q
                            k−1 l−1 n−1
where θk,l =       2·        k · l · n−2 . Moreover, P (WSk,l ) = θk,l .

```

**Definitions from the record's conventions** ([findings/conventions.md](../findings/conventions.md) lines 15, 24, 77 and 136):

| $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself | [README.md](../README.md) |
| $T$, third sense | **the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**, whose symmetry is what makes $L_e$ self-adjoint and hence [L24](../findings/second-order.md)'s $\lambda_{\max}$ well defined at all, the $W^2$ part as the symmetrisation of $\mathop{\mathrm{tr}}(XYZ)$, the $\#$ part because permuting the arguments permutes the slots of two totally antisymmetric $c$'s at sign $(-1)^2$. **It was tabled nowhere while the letter already carried the bracket tensor $T_{\alpha\beta\gamma}$ and [L35](../findings/stratum-two-negative.md)'s cap $\tfrac{2\sqrt2}3A$** | [second-order.md](../findings/second-order.md) |

**THE INDEX FORMULA FOR $\#$ CARRIES A $\tfrac12$, AND A DISPLAY WITHOUT IT IS TWICE THE RECORD'S $\#$.** $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$; dropped, the formula returns $\mathrm{id}^\#=2(n-2)\mathrm{id}$ against the halved Böhm–Wilking product's $(n-2)\mathrm{id}$, which is what $Q(\mathrm{id})=(n-1)\mathrm{id}$ on the round sphere pins. *A step reading only the index support of $W^\#$ is untouched by the factor; a step reading a value off it is out by two.* **Two reviewers derived the clash independently, each from $\mathrm{id}^\#$.**

- **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

## Definitions

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, viewed as symmetric operators on $\Lambda^2\mathbb R^n$, with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$.
- **This loop does no numerical work.** A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim.

## The question

**Prove the step above valid as written, from the passages and standard mathematics, or exhibit exactly where it fails.** Give the strongest reading the words support, and say which hypotheses that reading needs. Where the step's claim is true but the paragraph does not establish it, say both. **No numerical work**: a closed-form object checked by hand settles existence, and a run does not. Return a verdict of VALID or FAILS, with the argument.
