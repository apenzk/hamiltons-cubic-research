# Verifier v333, whether the bracket form of L111 is equivalent to the matrix form of criticality

*Cold brief ([ADJ_L111_D1.md](ADJ_L111_D1.md)), no numerical work, no scripts written, every value below exact and checked by hand. Log: [agent_logs/verify-L111-v333.log](../agent_logs/verify-L111-v333.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | $M_{kl}=-S_{kl}$ and $(W^\#)_{kl}=\tfrac12S_{kl}$, where $S_{kl}=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$ | CONFIRMED AS ALGEBRA |
| 2 | Criticality $Q(W)=\theta W$ is equivalent to $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ for all $k,l$ | CONFIRMED |
| 3 | Matrix form implies $S_{kl}=0$ whenever $\lambda_k\ne\lambda_l$ | CONFIRMED |
| 4 | $S_{kl}=0$ whenever $\lambda_k\ne\lambda_l$ implies the matrix form (the converse the "i.e." asserts) | REFUTED |
| 5 | The bracket form is exactly $[W,Q(W)]=0$ | CONFIRMED |
| 6 | The equivalence holds once the diagonal relations (C) and the within-eigenspace vanishing are added | CONFIRMED |
| 7 | Side remark on Passage A: "every diagonal Weyl tensor satisfies it while being nowhere near critical" | REFUTED AS STATED |

**Summary: the step FAILS. The forward direction holds, the converse fails on an explicit coordinate-diagonal Weyl tensor in $\mathcal W_4$ that satisfies the bracket form in every eigenbasis and is critical for no $\theta$.**

## 0. Conventions, fixed once

- $\{\varphi_k\}$ is an orthonormal eigenbasis of $W$ on $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$, $W\varphi_k=\lambda_k\varphi_k$, with the ad-invariant inner product for which the coordinate planes $e_i\wedge e_j$ are orthonormal.
- $c_{abc}=\langle[\varphi_a,\varphi_b],\varphi_c\rangle$, totally antisymmetric.
- $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$, the halved convention of Passage B, so $\mathrm{id}^\#=(n-2)\mathrm{id}$.
- $Q(W)=W^2+W^\#$, criticality is $Q(W)=\theta W$ (on the unit sphere $\theta=P(W)$, and for any $W$ with $Q(W)=\theta W$ one has $\theta=P(W)/\lVert W\rVert^2$).
- $S_{kl}:=\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c_{k\alpha\beta}c_{l\alpha\beta}$, symmetric in $k,l$.
- "Matrix form" is $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ for all $k,l$. "Bracket form" is $S_{kl}=0$ for all $k,l$ with $\lambda_k\ne\lambda_l$.

## Hypothesis inventory

- **H1.** The basis is orthonormal and diagonalises $W$. Used everywhere.
- **H2.** Total antisymmetry of $c$ (ad-invariance of the inner product). Used in Section 1.
- **H3.** The halved index formula for $\#$. Fixes the factor in $W^\#=\tfrac12S$ and so the constant $2$ in the matrix form. Vanishing statements are untouched by it.
- **H4 (missing from the step, needed for a VALID reading).** The diagonal relations $S_{kk}=2\lambda_k(\theta-\lambda_k)$ for every $k$, which is relation (C) of Passage B.
- **H5 (missing from the step, needed for a VALID reading).** $S_{kl}=0$ also for $k\ne l$ with $\lambda_k=\lambda_l$, or equivalently the eigenbasis is chosen inside each eigenspace to diagonalise $W^\#$ there.

## 1. The bracket coordinates of $M$ and $W^\#$

In the basis $\{\varphi_\alpha\}$ the matrix of $\mathrm{ad}(\varphi_k)$ has entries $(\mathrm{ad}\,\varphi_k)_{\beta\alpha}=\langle\varphi_\beta,[\varphi_k,\varphi_\alpha]\rangle=c_{k\alpha\beta}$, and $W=\mathrm{diag}(\lambda_\alpha)$. Hence

$$M_{kl}=\sum_{\alpha\beta}(\mathrm{ad}\,\varphi_k)_{\alpha\beta}\,\lambda_\beta\,(\mathrm{ad}\,\varphi_l)_{\beta\alpha}\,\lambda_\alpha=\sum_{\alpha\beta}c_{k\beta\alpha}c_{l\alpha\beta}\lambda_\alpha\lambda_\beta=-S_{kl}$$

by H2. From the index formula with $W_{ce}=\lambda_c\delta_{ce}$, $(W^\#)_{kl}=\tfrac12\sum_{cd}c_{kcd}c_{lcd}\lambda_c\lambda_d=\tfrac12S_{kl}$. So $M=-2W^\#$ entrywise, which agrees with the polarised identity $\langle v,W^\#v\rangle=-\tfrac12\operatorname{tr}(\mathrm{ad}(v)W\mathrm{ad}(v)W)$ and with the Lean definition `Mmat Ws k l = -2 * Ws k l`. Claim 1 CONFIRMED AS ALGEBRA.

## 2. Criticality is the matrix form

$Q(W)=\theta W$ reads entrywise $\lambda_k^2\delta_{kl}+(W^\#)_{kl}=\theta\lambda_k\delta_{kl}$, that is $(W^\#)_{kl}=\lambda_k(\theta-\lambda_k)\delta_{kl}$. Multiplying by $-2$ and using Section 1 gives $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$, and every step reverses. Claim 2 CONFIRMED, under H1 to H3.

## 3. The forward direction of the step

The matrix form gives $S_{kl}=-M_{kl}=0$ for every $k\ne l$. A pair with $\lambda_k\ne\lambda_l$ has $k\ne l$, so $S_{kl}=0$ there. Claim 3 CONFIRMED. The implication is in fact stronger than the step records: criticality gives $W^\#=\theta W-W^2$, which is a scalar on each eigenspace, so $S_{kl}=0$ for all $k\ne l$ in every orthonormal eigenbasis.

## 4. What the bracket form is

$[W,Q(W)]=[W,W^\#]$ since $W$ commutes with $W^2$, and $([W,W^\#])_{kl}=(\lambda_k-\lambda_l)(W^\#)_{kl}=\tfrac12(\lambda_k-\lambda_l)S_{kl}$. This vanishes for all $k,l$ exactly when $S_{kl}=0$ at every pair with $\lambda_k\ne\lambda_l$. Claim 5 CONFIRMED. The condition is basis-independent, and it says only that $W^\#$ preserves each eigenspace of $W$. It carries no information about the diagonal entries $S_{kk}$ and none about $S_{kl}$ inside an eigenspace.

## 5. The converse fails, closed-form counterexample

**Where.** The line of Passage A: "$M_{kl}=2\lambda_k(\lambda_k-\theta)\,\delta_{kl},\qquad\text{i.e.}\qquad \sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,c_{k\alpha\beta}c_{l\alpha\beta}=0\ \text{ whenever }\lambda_k\ne\lambda_l$", read, as "criticality is equivalent to" requires, as an equivalence.

**The tensor.** Take $n=4$ and the coordinate-diagonal operator on $\Lambda^2\mathbb R^4$ with eigenvalue $a$ on $e_1\wedge e_2$ and $e_3\wedge e_4$, $b$ on $e_1\wedge e_3$ and $e_2\wedge e_4$, $c$ on $e_1\wedge e_4$ and $e_2\wedge e_3$, where $a+b+c=0$. Write $\lambda_{ij}$ for the eigenvalue on $e_i\wedge e_j$.

- *It is an algebraic Weyl tensor.* A curvature operator diagonal on coordinate planes has $R_{ijkl}\ne0$ only when $\{i,j\}=\{k,l\}$. In the first Bianchi sum $R_{ijkl}+R_{iklj}+R_{iljk}$ at most two terms survive, and they are $R_{ijij}$ and $R_{ijji}=-R_{ijij}$, so the sum vanishes. Ricci: $\mathrm{Ric}_{ij}=\sum_kR_{ikjk}$ vanishes for $i\ne j$, and $\mathrm{Ric}_{ii}=\pm\sum_{j}\lambda_{ij}$ equals $\pm(a+b+c)=0$ for each $i$ (each index $i$ lies on exactly one plane of each of the three types). Scalar curvature is then zero too.
- *$W^\#$ is diagonal in the coordinate basis.* Here $c_{abc}\in\{0,\pm1\}$ and is nonzero only for triples of planes $\{e_i\wedge e_j,\ e_j\wedge e_k,\ e_i\wedge e_k\}$, which is consistent with $\mathrm{id}^\#=(n-2)\mathrm{id}$. A pair of planes $(c,d)$ with $c_{acd}\ne0$ determines $a$ uniquely, so $(W^\#)_{ab}=0$ for $a\ne b$, and $(W^\#)_{ij,ij}=\sum_{k\notin\{i,j\}}\lambda_{ik}\lambda_{jk}$. This gives
  - $(W^\#)_{12,12}=\lambda_{13}\lambda_{23}+\lambda_{14}\lambda_{24}=2bc$, and likewise $(W^\#)_{34,34}=2bc$,
  - $(W^\#)_{13,13}=(W^\#)_{24,24}=2ac$,
  - $(W^\#)_{14,14}=(W^\#)_{23,23}=2ab$.

**The instance.** Take $(a,b,c)=(1,-1,0)$. Then $W$ has eigenvalues $1$ on $\mathrm{span}(e_{12},e_{34})$, $-1$ on $\mathrm{span}(e_{13},e_{24})$, $0$ on $\mathrm{span}(e_{14},e_{23})$, and

$$W^\#=\mathrm{diag}\big(0,\,0,\,-2\big)\ \text{on those three eigenspaces, each block a scalar.}$$

- *The bracket form holds, in every orthonormal eigenbasis.* $W^\#$ is a scalar on each eigenspace, so in any orthonormal eigenbasis $S_{kl}=2(W^\#)_{kl}=0$ for all $k\ne l$, and in particular whenever $\lambda_k\ne\lambda_l$.
- *The matrix form fails for every $\theta$.* $M_{kk}=-2(W^\#)_{kk}$. On $e_{12}$: $M=0$ against $2\cdot1\cdot(1-\theta)$, forcing $\theta=1$. On $e_{13}$: $M=0$ against $2\cdot(-1)\cdot(-1-\theta)$, forcing $\theta=-1$. No $\theta$ satisfies both. At $\theta=P(W)$ the defect is visible on $e_{14}$ as well: $M=4$ against $2\cdot0\cdot(0-\theta)=0$.
- *Cross-check through $Q$.* $Q(W)=W^2+W^\#=\mathrm{diag}(1,1,-2)$ on the three eigenspaces against $W=\mathrm{diag}(1,-1,0)$. $\lVert W\rVert^2=4$ and $\langle W,Q(W)\rangle=2(1-1+0)=0$, so $\theta=P(W/2)=0$ while $Q(W)\ne0$. The normalised tensor $W/2$ lies on the unit sphere, satisfies $[W,Q(W)]=0$, and is not critical.

Claim 4 REFUTED. The failure sits entirely in the diagonal entries $S_{kk}$, which the bracket form never mentions.

**Arguing the opposite.** Could the "i.e." be read so that it survives? Three readings were tried.

- *"i.e." as a gloss on the off-diagonal part only.* Then the display asserts the implication of Section 3, which is valid, but Passage A introduces it with "criticality is equivalent to", so this reading drops the equivalence the sentence claims.
- *The diagonal is already known.* Relation (C) of Passage B is the diagonal of the matrix form, and the record derives it from criticality, so it cannot be supplied for free on the right-hand side without assuming what is to be shown. The counterexample violates (C): on $e_{12}$, $S_{kk}=0$ while $2\lambda_k(\theta-\lambda_k)=2(\theta-1)$, and on $e_{13}$, $S_{kk}=0$ while $2\lambda_k(\theta-\lambda_k)=-2(\theta+1)$.
- *The Weyl constraints might force the diagonal.* The tensor above is an honest element of $\mathcal W_4$, so they do not.

## 6. The strongest valid reading

**Proposition.** Under H1 to H3, the following are equivalent for a given $\theta$:

1. $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$ for all $k,l$.
2. $S_{kl}=0$ whenever $\lambda_k\ne\lambda_l$, together with H4 ($S_{kk}=2\lambda_k(\theta-\lambda_k)$ for all $k$) and H5 ($S_{kl}=0$ for $k\ne l$ with $\lambda_k=\lambda_l$).

*Proof.* (1)⇒(2) is Section 3 plus the diagonal of (1) through $M=-S$. For (2)⇒(1), the three clauses cover every entry: $S$ is diagonal with $S_{kk}=2\lambda_k(\theta-\lambda_k)$, so $M=-S$ is the matrix form. ∎

H5 is a choice of basis, never an extra restriction on $W$: the bracket form makes $W^\#$ preserve each eigenspace, so an orthonormal basis of each eigenspace diagonalising the symmetric block of $W^\#$ exists, and in it H5 holds. H4 is the substantive missing content, $N$ scalar equations that the bracket form does not imply. Claim 6 CONFIRMED.

## 7. Side remark on Passage A

Passage A's boxed text says every diagonal Weyl tensor satisfies the bracket form "while being nowhere near critical". The first half is right (Section 5 shows $W^\#$ is diagonal for every coordinate-diagonal $W$, in any $n$, by the uniqueness of the third plane). The second half fails as stated: in the family of Section 5 take $(a,b,c)=(2,-1,-1)$. Then $(W^\#)$ equals $2bc=2$, $2ac=-4$, $2ab=-4$ on the three eigenspaces, so $Q(W)=\mathrm{diag}(4+2,\,1-4,\,1-4)=\mathrm{diag}(6,-3,-3)=3W$, and this coordinate-diagonal Weyl tensor is critical with $Q(W)=3W$. Claim 7 REFUTED AS STATED. The strictness of the bracket form, which is what the passage needs, stands on Section 5. This remark lies outside the step adjudicated.

## Verdict

**FAILS.** The step's "if and only if" holds only in the direction matrix form ⇒ bracket form. The converse is refuted by the unit Weyl tensor $W/2$ of Section 5 in $\mathcal W_4$, eigenvalues $(1,-1,0)$ each of multiplicity two on opposite coordinate planes, which satisfies the bracket form in every eigenbasis and is critical for no $\theta$. A VALID reading needs H1 to H3 and, on the right-hand side, the added hypotheses H4 (the diagonal relations (C) for every $k$) and H5 (vanishing inside eigenspaces, a free choice of basis).
