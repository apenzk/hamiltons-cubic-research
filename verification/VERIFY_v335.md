# Verifier v335, L111 step D2: the bracket form is strictly weaker than criticality on the Weyl space

*Cold brief ([ADJ_L111_D2.md](ADJ_L111_D2.md)). No numerical work, no scripts written, every value below exact and derived by hand. Log: [agent_logs/verify-L111-v335.log](../agent_logs/verify-L111-v335.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | The bracket form is equivalent to $[W,W^\#]=0$, hence to $[W,Q(W)]=0$, and is independent of the eigenbasis chosen | CONFIRMED |
| 2 | Criticality forces $(W^\#)_{kl}=0$ for all $k\ne l$ in every orthonormal eigenbasis | CONFIRMED |
| 3 | Every coordinate-diagonal Weyl tensor satisfies the bracket form | CONFIRMED |
| 4 | The coordinate-diagonal Weyl tensors form a linear family of dimension $n(n-3)/2$ ($n\ge4$) | CONFIRMED |
| 5 | **The step: some $W\in\mathcal W_n$ satisfies the bracket form and is not critical** ($n\ge4$) | CONFIRMED |
| 6 | "Every diagonal Weyl tensor satisfies it while being nowhere near critical" (Passage A) | REFUTED AS STATED |
| 7 | The measurement in Passage A establishes the step | REFUTED |
| 8 | bracket_form_strictly_weaker in Passage C establishes the step | REFUTED |
| 9 | bracket_form_strictly_weaker as a statement about the abstract predicates | CONFIRMED AS ALGEBRA |

**Summary: the step is VALID for every $n\ge4$, witnessed in closed form by $\mu_{12}=\mu_{34}=1$, $\mu_{13}=\mu_{24}=-1$, other $\mu_{ij}=0$, whose $Q(W)$ has entry $-2$ on the plane $e_1\wedge e_4$ where $W$ has $0$. Neither support the passages give establishes it, and the universal "every diagonal Weyl tensor is nowhere near critical" is false.**

## 0. Conventions, fixed once

- $\mathcal W_n$ is the space of algebraic Weyl tensors, read as symmetric operators on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with orthonormal coordinate basis $e_i\wedge e_j$ ($i<j$), $N=\binom n2$.
- $c_{abc}=\langle[v_a,v_b],v_c\rangle$ is totally antisymmetric (Passage B). In the coordinate basis, $c_{abc}\ne0$ exactly when the planes $a,b,c$ are $e_i\wedge e_j$, $e_j\wedge e_k$, $e_i\wedge e_k$ for three distinct indices, and the record's normalisation gives $c_{abc}^2=1$ there. This is what relation (A) of Passage B pins: plane $e_i\wedge e_j$ has exactly $2(n-2)$ ordered pairs $(c,d)$ completing it to a triangle, and $\sum_{cd}T_{acd}=2(n-2)$.
- $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ (Passage B, with the $\tfrac12$). $Q(W)=W^2+W^\#$.
- "Critical" means $Q(W)=\theta W$ for some real $\theta$. For $W\ne0$ this forces $\theta=\langle W,Q(W)\rangle/\lVert W\rVert^2$, which is $P(W)$ on the unit sphere. Since $Q(tW)=t^2Q(W)$, criticality of $W\ne0$ is invariant under $W\mapsto tW$ ($t\ne0$), so the normalisation $\lVert W\rVert=1$ is immaterial to every claim below.
- "Bracket form" is the display in Passage A: $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ whenever $\lambda_k\ne\lambda_l$, over an orthonormal eigenbasis $\{\varphi_k\}$ of $W$.
- A coordinate-diagonal $W$ is written $W(e_i\wedge e_j)=\mu_{ij}\,e_i\wedge e_j$ with $\mu_{ij}=\mu_{ji}$.

## Hypothesis inventory

- **H1, $n\ge4$.** $\mathcal W_3=0$, so for $n\le3$ the only element is $W=0$, which satisfies $Q(0)=\theta\cdot0$ and admits no witness. The step as written names no $n$ and is read for $n\ge4$.
- **H2, criticality read as $Q(W)=\theta W$ for some $\theta\in\mathbb R$**, on $W\ne0$ (Definitions of the brief). The witness in Section 3 fails this for every $\theta$, so the reading $\theta=P(W)$ is covered as well.
- **H3, the bracket form read over an orthonormal eigenbasis of $W$**, as the Definitions give. Section 1 shows the condition does not depend on which eigenbasis is taken.
- **H4, the record's normalisation $c_{abc}^2=1$ on triangles.** The step (Section 3) needs only $c_{abc}^2=s$ for some constant $s\ne0$, so it survives the factor-of-two clash that Passage B records. The side finding of Section 5 uses $s=1$.

## 1. The bracket form is $[W,W^\#]=0$

Let $A=\mathrm{ad}(v_a)$, $B=\mathrm{ad}(v_b)$ in an orthonormal basis. From $[v_a,v_c]=\sum_d c_{acd}v_d$ the matrix entries are $A_{dc}=c_{acd}$ and $B_{ef}=c_{bfe}=-c_{bef}$. Then

$$\mathop{\mathrm{tr}}(AWBW)=\sum A_{dc}W_{ce}B_{ef}W_{fd}=-\sum c_{acd}c_{bef}W_{ce}W_{fd}=-2(W^\#)_{ab},$$

using $W_{fd}=W_{df}$. So $M_{kl}=-2(W^\#)_{kl}$, which is the definition Mmat in Passage C. In an eigenbasis $W_{ce}=\lambda_c\delta_{ce}$, and

$$M_{kl}=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c_{k\alpha\beta}c_{l\alpha\beta}.$$

The bracket form is therefore $(W^\#)_{kl}=0$ whenever $\lambda_k\ne\lambda_l$. That says $W^\#$ maps each eigenspace $E_\lambda$ of $W$ into itself (its block between distinct eigenspaces vanishes), which for symmetric $W$ is equivalent to $[W,W^\#]=0$. Both descriptions refer only to the eigenspace decomposition, so the condition is the same in every orthonormal eigenbasis (H3). Since $W^2$ commutes with $W$, it is also $[W,Q(W)]=0$. The abstract counterpart of this equivalence is commutes_iff_bracket_form in Passage C, whose statement matches. Claim 1 CONFIRMED.

## 2. What criticality adds

In an eigenbasis, $Q(W)=\theta W$ reads $\lambda_k^2\delta_{kl}+(W^\#)_{kl}=\theta\lambda_k\delta_{kl}$, that is $(W^\#)_{kl}=\lambda_k(\theta-\lambda_k)\delta_{kl}$, equivalently $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$. This is the matrix form of Passage A and matrix_form_is_criticality of Passage C. It forces $(W^\#)_{kl}=0$ for every $k\ne l$, including pairs inside one eigenspace, and in every eigenbasis, since $W^\#=\theta W-W^2$ is a polynomial in $W$. Claim 2 CONFIRMED.

Criticality thus carries two families of conditions the bracket form omits: the diagonal values $(W^\#)_{kk}=\lambda_k(\theta-\lambda_k)$ with one common $\theta$, and the requirement that $W^\#$ restrict to a scalar on each eigenspace. A witness to the step must violate one of them, and the witness below violates the first.

## 3. The coordinate-diagonal family and a closed-form witness

**The family (Claim 4).** A symmetric operator on $\Lambda^2$ diagonal in the coordinate basis has $R_{ijkl}=0$ unless $\{k,l\}=\{i,j\}$. Its component in $\Lambda^4$ (the first Bianchi obstruction) is the total antisymmetrisation of $R_{ijkl}$ over four distinct indices, which vanishes. So every such operator is an algebraic curvature operator. Its Ricci tensor is diagonal with $\mathrm{Ric}_{ii}=\pm\sum_{j\ne i}\mu_{ij}$, and it is Weyl exactly when every row sum $\sum_{j\ne i}\mu_{ij}$ vanishes. The row-sum map is the vertex-edge incidence map of the complete graph $K_n$, which has rank $n$ for $n\ge3$ because $K_n$ is connected and contains a triangle (odd cycle). The family has dimension $\binom n2-n=n(n-3)/2$. CONFIRMED under H1.

**$W^\#$ is coordinate-diagonal (Claim 3).** With $W$ diagonal, $(W^\#)_{ab}=\tfrac12\sum_{cd}c_{acd}c_{bcd}\mu_c\mu_d$. A nonzero term needs both $\{a,c,d\}$ and $\{b,c,d\}$ to be triangles. Then $c=e_i\wedge e_j$ and $d=e_j\wedge e_k$ share exactly one index, and the plane completing them to a triangle is $e_i\wedge e_k$, uniquely. So $a=b$, and $W^\#$ is diagonal in the coordinate basis. With H4,

$$(W^\#)_{ij,ij}=\tfrac12\cdot2\,s\sum_{k\ne i,j}\mu_{ik}\mu_{jk}=s\sum_{k\ne i,j}\mu_{ik}\mu_{jk}.$$

Hence $Q(W)$ is diagonal in the same basis as $W$, $[W,Q(W)]=0$, and by Section 1 the bracket form holds. CONFIRMED, for every coordinate-diagonal Weyl tensor.

**The witness (Claim 5).** For $n\ge4$ set

$$\mu_{12}=\mu_{34}=1,\qquad \mu_{13}=\mu_{24}=-1,\qquad \text{every other }\mu_{ij}=0.$$

Row sums: row 1 is $1-1+0=0$, row 2 is $1+0-1=0$, row 3 is $-1+0+1=0$, row 4 is $0-1+1=0$, and rows $5,\dots,n$ are $0$. So $W\in\mathcal W_n$, $W\ne0$, and by Claim 3 it satisfies the bracket form. On the plane $e_1\wedge e_4$,

$$Q(W)_{14,14}=\mu_{14}^2+s\big(\mu_{12}\mu_{42}+\mu_{13}\mu_{43}+\textstyle\sum_{k\ge5}\mu_{1k}\mu_{4k}\big)=0+s\big(1\cdot(-1)+(-1)\cdot1+0\big)=-2s,$$

while $\theta W_{14,14}=\theta\cdot0=0$. Since $s\ne0$, no $\theta$ satisfies $Q(W)=\theta W$. So $W$ is not critical, under H2 in either reading, and independently of scale. The step holds.

**Size of the witness set.** Within the diagonal family, $\{\mu:\ Q(\mu)\wedge\mu=0\}$ is a real algebraic set (the $2\times2$ minors of the pair of vectors $\mu$ and $Q(\mu)$), and for $\mu\ne0$ it is exactly the critical set together with nothing else. It is proper, since it misses the witness. Its complement is therefore a nonempty Zariski-open, hence open and dense, subset of an $n(n-3)/2$-dimensional linear space. So the non-critical elements satisfying the bracket form contain an open family of full dimension $n(n-3)/2$, which is the strongest reading of Passage A's "$n(n-3)/2$-dimensional family".

**Arguing the opposite.** A defender of the claim that the bracket form implies criticality would need the diagonal entries $(W^\#)_{kk}$ to be tied to $\lambda_k$ through one $\theta$ by the bracket data. Relation (C) of Passage B does that, but (C) is listed there as a consequence of criticality, and the Section 3 computation shows it failing: on $e_1\wedge e_4$ one has $\lambda=0$, and (C) would require $\sum\lambda_\beta\lambda_\gamma T_{k\beta\gamma}=0$, while the sum is $2\cdot(-2s)\ne0$ by the formula of Section 1. No other hypothesis in the passages constrains the diagonal of $W^\#$, so the opposite reading has nothing to stand on.

## 4. What the passages offer as support

**The measurement in Passage A (Claim 7).** It reports decimals on six elements of $\mathcal W_6$: off-diagonal residual $0$ and criticality residuals $0.527$ to $0.741$. Decimals on sampled elements are evidence, never an argument, and the brief's standard is an argument or closed form. The measured objects are not given in closed form, so the residuals cannot be checked from the passage. It is consistent with Section 3 and establishes nothing by itself. REFUTED as an establishment of the step.

**The Lean theorem bracket_form_strictly_weaker (Claims 8 and 9).** Its predicates take the spectrum lam and the matrix Ws as independent inputs. Nothing in Passage C ties Ws to $W^\#$ of a Weyl tensor with spectrum lam. The witness is lam $=(1,-1)$ on Fin 2 with Ws $=0$. An index set of size $2$ is $\binom n2$ for no $n$, so this pair is the eigendata of no element of any $\mathcal W_n$, and the theorem says nothing about $\mathcal W_n$. As algebra it is correct: BracketForm holds vacuously for Ws $=0$, and IsCriticalHere at $(0,0)$ and $(1,1)$ gives $1=\theta$ and $1=-\theta$. CONFIRMED AS ALGEBRA, REFUTED as support for the step. The second file, L111.lean (namespace BracketStrictness), proves multiplicity and dimension counts only and bears on the step not at all.

## 5. Side finding: some diagonal Weyl tensors are critical

Passage A says every diagonal Weyl tensor satisfies the bracket form "while being nowhere near critical". The universal is false. Take $n\ge4$ and, under H4 with $s=1$,

$$\mu_{12}=\mu_{34}=2,\qquad \mu_{13}=\mu_{24}=\mu_{14}=\mu_{23}=-1,\qquad \text{every other }\mu_{ij}=0.$$

Row sums on indices $1$ to $4$ are $2-1-1=0$, so $W\in\mathcal W_n$. The diagonal of $Q(W)$ on the six planes of $\{1,2,3,4\}$:

| plane | $\mu^2$ | $\sum_k\mu_{ik}\mu_{jk}$ | $Q_{ij,ij}$ | $\theta\mu_{ij}$ with $\theta=3$ |
|---|---|---|---|---|
| $12$ | $4$ | $(-1)(-1)+(-1)(-1)=2$ | $6$ | $6$ |
| $34$ | $4$ | $(-1)(-1)+(-1)(-1)=2$ | $6$ | $6$ |
| $13$ | $1$ | $2\cdot(-1)+(-1)\cdot2=-4$ | $-3$ | $-3$ |
| $24$ | $1$ | $2\cdot(-1)+(-1)\cdot2=-4$ | $-3$ | $-3$ |
| $14$ | $1$ | $2\cdot(-1)+(-1)\cdot2=-4$ | $-3$ | $-3$ |
| $23$ | $1$ | $2\cdot(-1)+(-1)\cdot2=-4$ | $-3$ | $-3$ |

Planes meeting an index $m\ge5$ have $\mu_{im}=0$ and $\sum_k\mu_{ik}\mu_{mk}=0$, so $Q=0=\theta\cdot0$ there, and $Q(W)$ is diagonal by Claim 3. So $Q(W)=3W$ and $W$ is critical, with $P(W/\lVert W\rVert)=3/\lVert W\rVert$ under the Frobenius norm $\lVert W\rVert^2=\sum_{i<j}\mu_{ij}^2=12$. The correct statement is the one of Section 3: the non-critical elements form an open dense subset of the diagonal family. This does not touch the step, which is existential.

## Verdict

**VALID.** Some $W\in\mathcal W_n$ satisfies the bracket form and is not critical, for every $n\ge4$: the coordinate-diagonal Weyl tensor $\mu_{12}=\mu_{34}=1$, $\mu_{13}=\mu_{24}=-1$, other $\mu_{ij}=0$ has $Q(W)$ coordinate-diagonal, so $[W,Q(W)]=0$, and $Q(W)_{14,14}=-2s\ne0=\theta W_{14,14}$ for every $\theta$. The reading needs H1 ($n\ge4$), H2 (criticality as $Q(W)=\theta W$ for some $\theta$, on $W\ne0$), H3 (the bracket form over an orthonormal eigenbasis, basis-independent by Section 1) and H4 in its weak form ($c_{abc}^2$ a nonzero constant on triangles). The support the passages give does not establish the step: the measurement is decimals on unexhibited samples, and the Lean witness is abstract eigendata of no Weyl tensor. The accompanying universal "every diagonal Weyl tensor is nowhere near critical" is false (Section 5).
