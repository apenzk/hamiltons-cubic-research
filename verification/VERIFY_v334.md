# Verifier v334, L111 step D2: the bracket form is strictly weaker than criticality on the Weyl space

*Cold brief ([ADJ_L111_D2.md](ADJ_L111_D2.md)). No numerical work, no scripts written, every value below exact and derived by hand. Log: [agent_logs/verify-L111-v334.log](../agent_logs/verify-L111-v334.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | The displayed bracket form, $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ whenever $\lambda_k\ne\lambda_l$, is exactly $[W,Q(W)]=0$ | CONFIRMED |
| 2 | Criticality $Q(W)=\theta W$ implies the bracket form | CONFIRMED |
| 3 | Every coordinate-diagonal Weyl tensor satisfies the bracket form | CONFIRMED |
| 4 | The coordinate-diagonal Weyl tensors form an $n(n-3)/2$-dimensional family | CONFIRMED |
| 5 | Some $W\in\mathcal W_n$ satisfies the bracket form and is not critical, for every $n\ge4$ (the step) | CONFIRMED |
| 6 | Every diagonal Weyl tensor is "nowhere near critical" | REFUTED AS STATED |
| 7 | The six-element measurement in Passage A establishes the step | REFUTED (evidence, not an argument) |
| 8 | The Lean theorem bracket_form_strictly_weaker establishes the step | REFUTED (it proves strictness for free variables at $N=2$, a size no $\mathcal W_n$ has) |

**Summary: the step is VALID for $n\ge4$, with the exact witness $w_{12}=w_{34}=1$, $w_{13}=w_{24}=-1$, $w_{14}=w_{23}=0$ (zero elsewhere), but neither support offered in the passages proves it.**

## 0. Conventions, fixed once

- $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ with the ad-invariant inner product in which $\{e_i\wedge e_j\}_{i<j}$ is orthonormal. $N=\binom n2$.
- $c_{abc}=\langle[v_a,v_b],v_c\rangle$ in an orthonormal basis, totally antisymmetric.
- $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ (Passage B), $Q(W)=W^2+W^\#$.
- Critical means $Q(W)=\theta W$ for some $\theta\in\mathbb R$ (Passage B). On $\{\lVert W\rVert=1\}$ pairing with $W$ forces $\theta=P(W)$. Section 4 also treats the projected reading $\pi_{\mathcal W_n}Q(W)=\theta W$.
- $\{\varphi_k\}$ is an orthonormal eigenbasis of $W$, $W\varphi_k=\lambda_k\varphi_k$, and $M_{kl}=\operatorname{tr}(\mathrm{ad}(\varphi_k)W\,\mathrm{ad}(\varphi_l)W)$.
- A coordinate-diagonal operator has $W(e_i\wedge e_j)=w_{ij}\,e_i\wedge e_j$, with $w_{ij}=w_{ji}$ and the convention $w_{ii}=0$.

## Hypothesis inventory

- **H1, $n\ge4$.** For $n\le3$ the space $\mathcal W_n$ is $\{0\}$ and $W=0$ is critical with $\theta$ arbitrary, so no witness exists. The passages quote $n(n-3)/2$ and measure at $n=6$, so $n\ge4$ is the meant range.
- **H2, the bracket form is read basis-free** as $[W,Q(W)]=0$, equivalently the displayed relation in any eigenbasis. Section 1 shows the two agree, so this is a convenience rather than a restriction.
- **H3, the inner product is ad-invariant and makes the coordinate 2-planes orthogonal.** This fixes the triangle support of $c_{abc}$ used in Section 2. The scale of $c$ and the $\tfrac12$ in $\#$ do not matter (Section 4).
- **H4, "critical" is $Q(W)=\theta W$ or its projection onto $\mathcal W_n$.** The witness is non-critical under both.

## 1. The bracket form is $[W,Q(W)]=0$

In the eigenbasis, $(\mathrm{ad}\,v)_{\alpha\beta}=\langle\varphi_\alpha,[v,\varphi_\beta]\rangle=\sum_a v_a c_{a\beta\alpha}$. Hence $\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)=\sum_{a,b,\alpha,\beta}v_av_b\,c_{a\beta\alpha}c_{b\alpha\beta}\lambda_\alpha\lambda_\beta=-\sum v_av_b\,c_{a\alpha\beta}c_{b\alpha\beta}\lambda_\alpha\lambda_\beta=-2\langle v,W^\#v\rangle$, which is Passage A's identity. $M$ is symmetric by cyclicity of the trace, so polarising gives

$$M_{kl}=-2(W^\#)_{kl}=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}.$$

The criticality equation in the eigenbasis reads $(W^\#)_{kl}=(\theta\lambda_k-\lambda_k^2)\delta_{kl}$, which is $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$. This is claim 2's matrix half, and it matches matrix_form_is_criticality with $Ws=W^\#$.

The displayed relation says $(W^\#)_{kl}=0$ whenever $\lambda_k\ne\lambda_l$. That holds exactly when $W^\#$ maps each eigenspace of $W$ into itself, which is $[W,W^\#]=0$. Since $[W,W^2]=0$, this is $[W,Q(W)]=0$, independent of the eigenbasis chosen inside a repeated eigenspace. This matches commutes_iff_bracket_form. Criticality gives $W^\#=\theta W-W^2$, a polynomial in $W$, so it commutes with $W$: claim 2.

## 2. Every coordinate-diagonal Weyl tensor satisfies the bracket form

With $v_{ij}=e_i\wedge e_j$, the bracket $[v_{ij},v_{jk}]$ is $\pm v_{ik}$ for distinct $i,j,k$, and brackets of disjoint or equal planes vanish. So $c_{abc}\ne0$ only when the planes $a,b,c$ are the three edges $\{ij\},\{jk\},\{ik\}$ of a triangle, and then $c_{abc}^2=1$ in the normalisation of Section 0.

Take $W$ coordinate-diagonal. Then $(W^\#)_{ab}=\tfrac12\sum_{c,d}c_{acd}c_{bcd}w_cw_d$. A nonzero term needs both $\{a,c,d\}$ and $\{b,c,d\}$ to be triangles. Two edges $c,d$ of a triangle share one vertex and determine the third edge uniquely, so $a=b$. Therefore $W^\#$ is diagonal in the same basis as $W$, the two commute, and $[W,Q(W)]=0$. For $a=\{ij\}$ the pairs are $(c,d)=(\{ik\},\{jk\})$ and its transpose, $k\ne i,j$, which gives the closed form

$$(W^\#)_{ij}=\sum_{k\ne i,j}w_{ik}w_{jk}=(w^2)_{ij},\qquad Q(W)_{ij}=w_{ij}^2+(w^2)_{ij},$$

where $w=(w_{ij})$ is the symmetric $n\times n$ matrix with zero diagonal. The check $W=\mathrm{id}$ gives $\mathrm{id}^\#=(n-2)\mathrm{id}$, as Passage B pins. This proves claim 3.

## 3. The family is $\mathcal W_n$-valued and of dimension $n(n-3)/2$

- **Bianchi.** A coordinate-diagonal symmetric operator has $R_{ijkl}\ne0$ only when $\{k,l\}=\{i,j\}$. For four distinct indices every term of the cyclic sum vanishes, and with a repeated index the identity holds for any curvature-type tensor. So every such operator is an algebraic curvature operator.
- **Ricci.** $\mathrm{Ric}_{ik}=\sum_jR_{ijkj}$ vanishes for $i\ne k$ by the support, and $\mathrm{Ric}_{ii}=\sum_{j}w_{ij}$ up to a fixed sign. So $W$ is Weyl exactly when every row of $w$ sums to zero.
- **Dimension.** The row-sum map $\mathbb R^N\to\mathbb R^n$ is the unsigned incidence map of the complete graph $K_n$, which has rank $n$ when $K_n$ contains an odd cycle, that is for $n\ge3$. The kernel has dimension $\binom n2-n=n(n-3)/2$. This proves claim 4.

## 4. An exact non-critical witness for every $n\ge4$

**At $n=4$.** Zero row sums force $w_{12}=w_{34}=a$, $w_{13}=w_{24}=b$, $w_{14}=w_{23}=c$ with $a+b+c=0$ (a 2-dimensional family, matching $n(n-3)/2=2$). Section 2 gives

$$Q_{12}=Q_{34}=a^2+2bc,\qquad Q_{13}=Q_{24}=b^2+2ac,\qquad Q_{14}=Q_{23}=c^2+2ab.$$

Take $(a,b,c)=(1,-1,0)$. Then $Q(W)$ has entries $(1,1,-2)$ against $W$'s $(1,-1,0)$. The $\{12\}$ entry forces $\theta=1$ and the $\{13\}$ entry forces $\theta=-1$, so $Q(W)\ne\theta W$ for every $\theta$. Scaling to the unit sphere changes nothing, since $Q(tW)=t^2Q(W)$.

- **Projected reading.** The row sums of $Q(W)$ are $a^2+b^2+c^2+2(ab+bc+ca)=(a+b+c)^2=0$, so $Q(W)\in\mathcal W_4$ already and $\pi_{\mathcal W_4}Q(W)=Q(W)$. The witness is non-critical under this reading too.
- **Normalisation of $\#$.** With $\#$ scaled by any $s$ (for instance the doubled display Passage B warns of), $Q_{12}=a^2+2sbc=1$ and $Q_{13}=b^2+2sac=1$ at $c=0$, against $W_{12}=1$, $W_{13}=-1$. Non-proportionality survives every $s$.

**At every $n\ge4$.** Extend $w$ by zero outside $\{1,2,3,4\}$. Rows $5,\dots,n$ are zero and rows $1$ to $4$ keep their zero sums, so $W\in\mathcal W_n$. In $(w^2)_{ij}=\sum_kw_{ik}w_{jk}$ every $k\ge5$ contributes zero, so $Q(W)$ is the $n=4$ matrix $(1,1,-2)$ extended by zero, still Weyl and still not proportional to $W$. By Section 2 this $W$ satisfies the bracket form. This proves claim 5, the step.

## 5. The "nowhere near critical" clause overstates

Passage A says every diagonal Weyl tensor satisfies the bracket form "while being nowhere near critical". The first half is Section 2. The second half fails as a statement about every element: at $n=4$ take $(a,b,c)=(2,-1,-1)$, which gives $Q_{12}=4+2=6$, $Q_{13}=1-4=-3$, $Q_{14}=1-4=-3$, so $Q(W)=3W$ exactly and this diagonal Weyl tensor is critical with $\theta=3$ before normalisation. Extended by zero it is critical in every $\mathcal W_n$, $n\ge4$, by the argument of Section 4. The step needs only one non-critical member, so the overstatement leaves it untouched, but the sentence should read "generic diagonal Weyl tensors are not critical" or cite an explicit element.

## 6. What the passages' support establishes

- **The measurement.** Six floating-point elements of $\mathcal W_6$, unspecified in the passage, with criticality residuals $0.527$ to $0.741$ and a projection error $\le5\times10^{-17}$. Residuals that far from zero are persuasive that those elements are not critical, but the elements are not given, the residual is not defined, and the elements lie in $\mathcal W_6$ only to rounding. A decimal is evidence, and the step requires an exact element, which Section 4 supplies.
- **The Lean theorem.** bracket_form_strictly_weaker works over free data: lam and Ws are independent variables, and nothing ties Ws to $W^\#$ of an element of $\mathcal W_n$. Its witness is lam $=(1,-1)$, Ws $=0$ on Fin 2. That is an index set of size $N=2$, and $\binom n2=2$ has no integer solution, so no Lie-algebra datum realises it. The theorem proves that BracketForm does not imply IsCriticalHere as predicates in free variables, which is strictly weaker than the step: on $\mathcal W_n$ Ws is constrained to equal $W^\#(W)$, and a free-variable counterexample need not be realisable. The second file (HamiltonsCubic.BracketStrictness) contains only binomial counts and does not bear on the step.

## 7. Verdict

**VALID**, for $n\ge4$ (H1), reading the bracket form as $[W,Q(W)]=0$ (H2, shown equivalent to the display in Section 1), with an ad-invariant inner product orthonormal on coordinate planes (H3), and criticality as $Q(W)=\theta W$ or its projection to $\mathcal W_n$ (H4). The witness is $w_{12}=w_{34}=1$, $w_{13}=w_{24}=-1$, all other $w_{ij}=0$, with $Q(W)$ entries $(1,1,-2)$ against $(1,-1,0)$. The support printed in the record does not establish the step: the measurement is decimal evidence on unspecified elements, and the Lean theorem proves free-variable strictness at a size no $\mathcal W_n$ has. The accompanying clause "every diagonal Weyl tensor ... nowhere near critical" is REFUTED AS STATED by the critical diagonal element $(2,-1,-1)$.
