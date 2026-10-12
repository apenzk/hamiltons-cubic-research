# Verifier v337, L111 step D3: coordinate-diagonal Weyl tensors satisfy the bracket form and are nowhere near critical

*Cold brief ([ADJ_L111_D3.md](ADJ_L111_D3.md)). No numerical work, no scripts written, every value below is exact and derived by hand. Log: [agent_logs/verify-L111-v337.log](../agent_logs/verify-L111-v337.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | Every coordinate-diagonal Weyl tensor satisfies the bracket form, in every eigenbasis | CONFIRMED |
| 2 | The coordinate-diagonal Weyl tensors form an $n(n-3)/2$-dimensional family | CONFIRMED |
| 3 | Every coordinate-diagonal Weyl tensor is not critical | REFUTED AS STATED |
| 4 | Every coordinate-diagonal Weyl tensor is "nowhere near critical" (bounded away from the critical set) | REFUTED |
| 5 | Some coordinate-diagonal Weyl tensor satisfies the bracket form and is not critical, in every $\mathcal W_n$ with $n\ge4$ (the bracket form is strictly weaker) | CONFIRMED |

**Summary: the unit Weyl tensors of $S^2\times S^2$ and $S^3\times S^3$ are coordinate-diagonal and exactly critical, with $Q(W)=W$ and $Q(W)=2W$ before normalisation, so "every" and "nowhere near" fail, while the strictness conclusion the sentence serves survives on an explicit non-critical diagonal element.**

## 0. Conventions, fixed once

- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $e_{ij}=e_i\wedge e_j$ ($i<j$) orthonormal, identified with the matrix $E_{ij}-E_{ji}$. The bracket is the matrix commutator, and $[e_{ij},e_{jk}]=\pm e_{ik}$ for distinct $i,j,k$, while brackets of planes sharing no index or both indices vanish. So in this basis every structure constant $c_{abc}$ lies in $\{0,\pm1\}$, and for a fixed ordered pair $(c,d)$ the bracket $[c,d]$ is a multiple of at most one basis element.
- $(W^\#)_{ab}=\tfrac12\sum_{cdef}c_{acd}c_{bef}W_{ce}W_{df}$, the halved convention of Passage B. It gives $\mathrm{id}^\#_{aa}=\tfrac12\sum_{cd}c_{acd}^2=\tfrac12\cdot2(n-2)=n-2$, which is the pin $Q(\mathrm{id})=(n-1)\mathrm{id}$ that Passage B names, so the basis normalisation above is the record's.
- $Q(W)=W^2+W^\#$. "Critical" is $Q(W)=\theta W$ on $\lVert W\rVert=1$, with $\theta=P(W)$. Since $Q$ is homogeneous quadratic, $Q(W)=\mu W$ for $W\ne0$ is equivalent to $Q(\hat W)=(\mu/\lVert W\rVert)\hat W$ for $\hat W=W/\lVert W\rVert$, so criticality can be tested before normalising.
- A **coordinate-diagonal** $W$ has $We_{ij}=w_{ij}e_{ij}$, with $w$ a symmetric array indexed by unordered pairs. The eigenvalue $w_{ij}$ is the sectional curvature $W_{ijij}$ in the convention where the unit sphere has curvature operator $+\mathrm{id}$. The sign convention is immaterial for criticality, because $Q(-W)=Q(W)$ turns a critical $W$ with multiplier $\theta$ into a critical $-W$ with multiplier $-\theta$.
- The bracket form is $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=0$ whenever $\lambda_k\ne\lambda_l$, over an orthonormal eigenbasis $\{\varphi_k\}$ of $W$ (Passage A).

## Hypothesis inventory

- **H1 (halved $\#$).** The index formula carries the $\tfrac12$ of Passage B. Claim 3's refutation uses it: under the doubled product $W^2+2W^\#$ neither product tensor is critical (Section 4.3).
- **H2 (Weyl conditions).** $\mathcal W_n$ is the space of algebraic curvature operators with vanishing Ricci contraction. First Bianchi is automatic for coordinate-diagonal operators (Section 2).
- **H3 (frame).** The product tensors are written in an orthonormal frame adapted to the factors, as the brief specifies. Criticality is $O(n)$-invariant, so the frame choice changes nothing but the coordinates.
- **H4 (reading of "diagonal").** "Diagonal Weyl tensor" in Passage A means coordinate-diagonal in the sense of the brief. Section 6 argues the opposite reading.

## 1. The bracket form is $[W,W^\#]=0$, basis-independently

In an orthonormal eigenbasis, $W_{ce}=\lambda_c\delta_{ce}$, so the index formula collapses to $(W^\#)_{kl}=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}$. The bracket form therefore says $(W^\#)_{kl}=0$ whenever $\lambda_k\ne\lambda_l$. For a symmetric $W^\#$ this holds in one eigenbasis if and only if $W^\#$ maps each eigenspace of $W$ into itself, which is $[W,W^\#]=0$, a basis-free condition. Since $W^2$ commutes with $W$, this is $[W,Q(W)]=0$, as Passage A states.

Cross-check against the matrix $M$ of Passage A: $(\mathrm{ad}\,\varphi_k)_{\alpha\beta}=\langle\varphi_\alpha,[\varphi_k,\varphi_\beta]\rangle=c_{k\beta\alpha}$, so $M_{kl}=\sum_{\alpha\beta}c_{k\beta\alpha}\lambda_\beta c_{l\alpha\beta}\lambda_\alpha=-\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=-2(W^\#)_{kl}$. Criticality $W^\#=\theta W-W^2$ gives $M_{kl}=2\lambda_k(\lambda_k-\theta)\delta_{kl}$, matching the lemma's matrix form.

## 2. The coordinate-diagonal family

A coordinate-diagonal curvature operator has $R_{ijkl}\ne0$ only when $\{k,l\}=\{i,j\}$. The first Bianchi sum $R_{ijkl}+R_{jkil}+R_{kijl}$ vanishes identically: with $i,j,k$ distinct every term has index sets that differ, and with a repeated index it reduces to the pair symmetries. The Ricci contraction is $\mathrm{Ric}_{ii}=\sum_{j\ne i}w_{ij}$ and $\mathrm{Ric}_{ik}=\sum_j R_{ijkj}=0$ for $i\ne k$. So a coordinate-diagonal Weyl tensor is exactly a symmetric zero-diagonal array $w$ with

$$\sum_{j\ne i}w_{ij}=0\quad\text{for every }i.$$

These $n$ row conditions are independent for $n\ge3$ (the incidence matrix of $K_n$, which is non-bipartite for $n\ge3$, has full row rank $n$), so the family has dimension $\binom n2-n=n(n-3)/2$. **Claim 2 CONFIRMED.**

## 3. $W^\#$ and $Q(W)$ on the family, in closed form

Take $a=e_{ij}$. By Section 0, $c_{acd}\ne0$ and $c_{bcd}\ne0$ force both $a$ and $b$ to be the single basis direction of $[c,d]$, hence $a=b$, so $(W^\#)_{ab}=\tfrac12\sum_{cd}c_{acd}c_{bcd}w_cw_d$ vanishes for $a\ne b$. The ordered pairs $(c,d)$ with $[c,d]=\pm e_{ij}$ are $(e_{ik},e_{kj})$ and $(e_{kj},e_{ik})$ for $k\notin\{i,j\}$. Hence

$$(W^\#)e_{ij}=\Big(\sum_{k\notin\{i,j\}}w_{ik}w_{jk}\Big)e_{ij},\qquad Q(W)e_{ij}=q_{ij}e_{ij},\qquad q_{ij}=w_{ij}^2+\sum_{k\notin\{i,j\}}w_{ik}w_{jk}.$$

$W^\#$ and $Q(W)$ are diagonal in the same basis as $W$, so $[W,Q(W)]=0$, and by Section 1 the bracket form holds in every eigenbasis of $W$, including eigenbases that mix coordinate planes inside a repeated eigenvalue. **Claim 1 CONFIRMED.**

Sanity check of the formula on a curvature operator whose $Q$ is known: for $S^2\times S^2$ with unit factors, $R$ has $r_{12}=r_{34}=1$ and $r=0$ on the four mixed planes. Then $q_{12}=1+r_{13}r_{23}+r_{14}r_{24}=1$ and $q_{13}=0+r_{12}r_{32}+r_{14}r_{34}=0$, so $Q(R)=R$. That is the Ricci-flow identity $Q(R)=\mu R$ for a locally symmetric Einstein space with $\mathrm{Ric}=\mu g$ (here $\mu=1$), since $\partial_tR=2Q(R)$ and $R(t)=R/(1-2\mu t)$.

**Criticality on the family** is therefore the system $q_{ij}=\theta w_{ij}$ for all pairs $i<j$.

## 4. The product tensors are critical

### 4.1 $S^2\times S^2$ in $\mathcal W_4$

Frame $\{e_1,e_2\}\cup\{e_3,e_4\}$, unit factors. $\mathrm{Ric}=g$, scalar curvature $4$, so $W=R-\tfrac{4}{12}\mathrm{id}=R-\tfrac13\mathrm{id}$:

$$w_{12}=w_{34}=\tfrac23,\qquad w_{13}=w_{14}=w_{23}=w_{24}=-\tfrac13.$$

Row sums are $\tfrac23-\tfrac13-\tfrac13=0$. Then

- $q_{12}=\tfrac49+w_{13}w_{23}+w_{14}w_{24}=\tfrac49+\tfrac19+\tfrac19=\tfrac23=w_{12}$, and $q_{34}=w_{34}$ by the factor swap.
- $q_{13}=\tfrac19+w_{12}w_{32}+w_{14}w_{34}=\tfrac19-\tfrac29-\tfrac29=-\tfrac13=w_{13}$, and the other mixed planes follow by the symmetries of the frame.

So $Q(W)=W$. With $\lVert W\rVert^2=2\cdot\tfrac49+4\cdot\tfrac19=\tfrac43$, the unit tensor $\hat W=\tfrac{\sqrt3}{2}W$ (entries $\tfrac1{\sqrt3}$ and $-\tfrac1{2\sqrt3}$) satisfies $Q(\hat W)=\tfrac{\sqrt3}2\hat W$, and $\theta=P(\hat W)=\tfrac{\sqrt3}2$. **It is critical.**

The whole four-dimensional picture is explicit. Summing the rows as $1+2-3-4$ gives $w_{12}=w_{34}$, and likewise $w_{13}=w_{24}$, $w_{14}=w_{23}$, so the family is $(a,b,c)=(w_{12},w_{13},w_{14})$ with $a+b+c=0$, and $q=(a^2+2bc,\ b^2+2ac,\ c^2+2ab)$. Subtracting equations gives $(a-b)(3c+\theta)=0$, $(b-c)(3a+\theta)=0$, $(a-c)(3b+\theta)=0$. Distinct $a,b,c$ would force $a=b=c$, a contradiction, and two equal values, say $b=c$, give $a=-2b$ and $\theta=-3b$, which satisfies the remaining equation $a^2+2bc=-3b\,a$ identically. So the critical points of the unit circle of diagonal elements are exactly the six points $\pm(-2,1,1)/\sqrt6$ and permutations: $\pm$ the $S^2\times S^2$ tensor for each of the three pairings of $\{1,2,3,4\}$.

### 4.2 $S^3\times S^3$ in $\mathcal W_6$

Frame $\{e_1,e_2,e_3\}\cup\{e_4,e_5,e_6\}$, unit factors. $\mathrm{Ric}=2g$, scalar curvature $12$, so $W=R-\tfrac{12}{30}\mathrm{id}$:

$$w_{ij}=\tfrac35\ \text{(both indices in one factor)},\qquad w_{ij}=-\tfrac25\ \text{(mixed)}.$$

Row sums are $2\cdot\tfrac35-3\cdot\tfrac25=0$. Then

- $q_{12}=\tfrac9{25}+w_{13}w_{23}+\sum_{k=4}^6w_{1k}w_{2k}=\tfrac9{25}+\tfrac9{25}+3\cdot\tfrac4{25}=\tfrac65=2w_{12}$.
- $q_{14}=\tfrac4{25}+\sum_{k=2,3}w_{1k}w_{4k}+\sum_{k=5,6}w_{1k}w_{4k}=\tfrac4{25}-2\cdot\tfrac6{25}-2\cdot\tfrac6{25}=-\tfrac45=2w_{14}$.

Every within-factor plane is conjugate to $e_{12}$ and every mixed plane to $e_{14}$ under the frame permutations preserving the splitting, so $Q(W)=2W$. With $\lVert W\rVert^2=6\cdot\tfrac9{25}+9\cdot\tfrac4{25}=\tfrac{18}5$, the unit tensor $\hat W=\sqrt{5/18}\,W$ (entries $\tfrac1{\sqrt{10}}$ and $-\tfrac2{3\sqrt{10}}$) satisfies $Q(\hat W)=\tfrac{\sqrt{10}}3\hat W$, and $\theta=\tfrac{\sqrt{10}}3$. **It is critical.**

### 4.3 Dependence on the $\tfrac12$ (H1)

Under the doubled product $W^2+2W^\#$ that Passage B warns against, $S^2\times S^2$ gives $\tfrac49+\tfrac49=\tfrac89=\tfrac43w_{12}$ against $\tfrac19-\tfrac89=-\tfrac79=\tfrac73w_{13}$, which is not proportional. The refutation is a statement about the record's halved $\#$, the convention the lemma is written in.

### 4.4 Where Passage A fails

The line is "**every diagonal Weyl tensor satisfies it while being nowhere near critical**". Sections 4.1 and 4.2 exhibit, in the two dimensions the brief names, coordinate-diagonal unit Weyl tensors with $Q(\hat W)=\theta\hat W$ exactly. The "every ... not critical" half is false (**Claim 3 REFUTED AS STATED**). The criticality residual $\min_\theta\lVert Q(\hat W)-\theta\hat W\rVert$ is continuous on the unit sphere of the family and vanishes at these points, so diagonal elements with arbitrarily small residual exist, and "nowhere near critical" as a uniform statement is false as well (**Claim 4 REFUTED**). Only the two named cases are verified here, and two exact counterexamples are all the refutation needs.

## 5. What survives: the bracket form is strictly weaker

The purpose of the sentence is strictness, and one non-critical diagonal element per dimension suffices. In $\mathcal W_4$ take $(a,b,c)=(1,-1,0)$, that is $w_{12}=w_{34}=1$, $w_{13}=w_{24}=-1$, $w_{14}=w_{23}=0$. Then $q=(1+0,\ 1+0,\ 0-2)=(1,1,-2)$, and $q=\theta(1,-1,0)$ would need $\theta=1$ and $\theta=-1$. Not critical, and by Claim 1 it satisfies the bracket form.

For $n\ge5$, extend by $w_{ij}=0$ whenever $i\ge5$ or $j\ge5$. Row sums stay zero. For $i<j\le4$ the added $k\ge5$ terms of $q_{ij}$ vanish, so $q$ restricted to those planes is still $(1,1,-2)$ against $w=(1,-1,0)$, and criticality still fails. **Claim 5 CONFIRMED**, and with it the lemma's conclusion that the bracket form is strictly weaker than criticality on genuine Weyl tensors, for every $n\ge4$.

On the family, the critical locus is the real algebraic set cut out by $q_{ij}w_{kl}=q_{kl}w_{ij}$, and Section 5 shows it is proper in each $\mathcal W_n$, $n\ge4$. So the sentence holds with "every" replaced by "a generic" (outside a proper algebraic subset), and "nowhere near critical" holds only on compact subsets of the family avoiding that locus.

## 6. Arguing the opposite

- **"Diagonal" could mean something narrower than coordinate-diagonal.** Passage A calls its sample "six diagonal elements of $\mathcal W_6$" and counts "an $n(n-3)/2$-dimensional family". That dimension is exactly the coordinate-diagonal family of Section 2, and Passage B repeats "every diagonal Weyl tensor". No narrower reading (distinct eigenvalues, or a generic sample) is written, and $S^3\times S^3$ lies in the counted family. Under the narrower reading "generic diagonal", Claims 3 and 5 hold and Claim 4 still needs a compactness restriction.
- **"Critical" could require something beyond $Q(W)=\theta W$, for instance a sign on $\theta$ or a maximum.** Passage B fixes "critical point" as the first-order condition $Q(W)=\theta W$, and both product tensors have $\theta>0$ in any case.
- **The six measured residuals $0.527$ to $0.741$ could be taken as evidence for "nowhere near".** Six samples of a family containing exact critical points bound nothing, and a decimal is not an argument. The closed forms of Section 4 settle the point.
- **The sign convention for $W$.** If the record's curvature operator has the opposite sign, the product tensors become $-W$, which are critical with multiplier $-\theta$ (Section 0).
- **The Lean witness.** `bracket_form_strictly_weaker` in [L111Statement.lean](../lean/HamiltonsCubic/Results/L111Statement.lean), as quoted in the brief, takes $\lambda=(1,-1)$ and $W^\#=0$ on a two-element index set, an abstract spectral model that is not a Weyl tensor. It certifies strictness of the abstract implication and is silent on the diagonal family, so it neither supports nor contradicts Claims 3 and 4.

## Verdict

**FAILS as written.** The step asserts that every coordinate-diagonal Weyl tensor is not critical, and the coordinate-diagonal unit Weyl tensors of $S^2\times S^2$ ($Q(W)=W$, $\theta=\tfrac{\sqrt3}2$) and $S^3\times S^3$ ($Q(W)=2W$, $\theta=\tfrac{\sqrt{10}}3$) are exactly critical under the record's halved $\#$ (H1).

**The VALID repair** reads: every coordinate-diagonal Weyl tensor satisfies the bracket form (unconditional, Claim 1), and a generic one is not critical, the critical locus in the $n(n-3)/2$-dimensional family being a proper algebraic subset containing the product-of-spheres tensors, as witnessed by the explicit element $(1,-1,0)$ of Section 5 for every $n\ge4$. That reading needs H1, H2 and H4, and it carries the lemma's strictness conclusion unchanged. "Nowhere near critical" must be dropped or restricted to compact sets avoiding the critical locus.
