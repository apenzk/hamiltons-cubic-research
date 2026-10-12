# Verifier v404, adjudication of step K1 in round L66-r2

*Cold brief ([ADJ_L66r2_K1.md](ADJ_L66r2_K1.md) and Nienhaus Proposition 2.25 only). No numerical work: no scripts were written and no computations were run. Every value below is exact and checked by hand. Log: [agent_logs/verify-L66-v404.log](../agent_logs/verify-L66-v404.log).*

| Claim | Verdict |
|---|---|
| K1a. There exist critical unit $A,B\in\mathcal W_n$ for some $n\ge4$ with $\langle A,B\rangle=0$ and $A\circ B\ne0$ | **TRUE**, by the closed-form witness of §2.3 at $n=4$ |
| K1b. The paragraph "Criticality with ordinary orthogonality is a different hypothesis from $\circ$-orthogonality" establishes K1a | **FAILS**: the paragraph contains no object, only a report of a run, and says itself that no closed-form witness is on file |
| K1 as written (K1a together with K1b) | **FAILS** |
| Screen: the normalisation $Q=3(\cdot^2)_0$ on $\mathcal W^+_4$ used in §2.2 agrees with the brief's $\mathrm{id}^\#=(n-2)\mathrm{id}$ and with Nienhaus's $\theta_{2,2}=\tfrac{\sqrt3}2$ | **CONSISTENT** (screen, not evidence) |

**Summary: the non-implication the paragraph asserts is true, witnessed at $n=4$ by the unit self-dual tensors $A=\mathrm{diag}(2,-1,-1)/\sqrt6$ and $B=(J-I)/\sqrt6$ on $\Lambda^+$, both critical with $\theta=\tfrac{\sqrt6}2$, Frobenius-orthogonal, with $A\circ B=\tfrac14M\ne0$, but the paragraph rests only on a numerical run and so does not establish it.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, viewed as symmetric operators on $\Lambda^2\mathbb R^n$, with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$."
- "$Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself"
- "$(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ ... the halved Böhm–Wilking product's $(n-2)\mathrm{id}$"
- "the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric structure constants"
- "**The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$"
- The step: "$Q(A)=\theta_AA$ and $Q(B)=\theta_BB$, with $\langle A,B\rangle=0$ and $A\circ B\ne0$".
- "A claim supported only by a run is `HYPOTHESIS-DEBT`."

Below, the Frobenius inner product on symmetric operators of $\Lambda^2\mathbb R^4$ is $\langle X,Y\rangle=\operatorname{tr}(XY)$ in an orthonormal basis of $\Lambda^2\mathbb R^4$. Criticality, orthogonality and $A\circ B\ne0$ are each unchanged when the inner product is multiplied by a positive constant (only the value of $\theta$ rescales), so the witness serves under any positive multiple of this convention.

## 1. Hypothesis inventory

| # | Hypothesis the step needs | Source | Check |
|---|---|---|---|
| H1 | $Q$ maps $\mathcal W_n$ into $\mathcal W_n$ | brief, conventions table | Given. Used in §2.2 to fix the constant $\kappa^2$ |
| H2 | The structure constants $c_{abc}$ of $\mathfrak{so}(n)\cong\Lambda^2\mathbb R^n$ in an orthonormal basis are totally antisymmetric | Passage D | Given, and standard for a bi-invariant inner product |
| H3 | $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$ | brief | Given. Only the resulting block formula of §2.2 is used |
| H4 | At $n=4$: $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ orthogonally, $\Lambda^\pm$ commuting ideals each isomorphic to $\mathfrak{so}(3)$, and $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ | standard (Singer–Thorpe decomposition) | Standard mathematics, stated as such |
| H5 | Existence of a witness, which the paragraph takes from "A run at $n=8$" | Passage A, the paragraph | Not available to a reader. The paragraph names no tensor, and ends "No closed-form witness is on file." Under the brief this is `HYPOTHESIS-DEBT` |

H1 to H4 suffice for K1a. H5 is the only support the paragraph offers for K1a, and it is the point where K1b fails.

## 2. The argument

### 2.1 What the step claims, in its strongest reading

The strongest reading is existential: criticality of two unit Weyl tensors together with Frobenius orthogonality does not force $A\circ B=0$. A single pair at a single $n\ge4$ settles it. The step adds a second clause, that the quoted paragraph establishes this. The two clauses are judged separately.

### 2.2 $Q$ and $\circ$ on the self-dual block at $n=4$

Take $n=4$ and an orthonormal basis $f_1,f_2,f_3$ of $\Lambda^+$, extended by an orthonormal basis of $\Lambda^-$. By H4, $[\Lambda^+,\Lambda^-]=0$ and $[\Lambda^+,\Lambda^+]\subset\Lambda^+$, so $c_{abc}=0$ unless $a,b,c$ all lie in the same block. Restricted to $\Lambda^+$, $c$ is a totally antisymmetric 3-tensor on a 3-dimensional space (H2), hence $c_{abc}=\kappa\,\varepsilon_{abc}$ for one real $\kappa$.

Let $A$ be a symmetric traceless $3\times3$ matrix on $\Lambda^+$, extended by $0$ on $\Lambda^-$. By H4 it lies in $\mathcal W_4$. In H3 every nonzero term has $c,d,e,f\in\Lambda^+$, which forces $a,b\in\Lambda^+$, so $A^\#$ lives on $\Lambda^+$ and there $(A^\#)_{ab}=\tfrac12\kappa^2\sum\varepsilon_{acd}\varepsilon_{bef}A_{ce}A_{df}=\kappa^2\operatorname{cof}(A)_{ab}$. The identity $\sum\varepsilon_{acd}\varepsilon_{bef}A_{ce}A_{df}=2\operatorname{cof}(A)_{ab}$ is standard, and at $a=b=1$ it reads $2(A_{22}A_{33}-A_{23}A_{32})$ by direct expansion.

Cayley–Hamilton for a $3\times3$ matrix with $\operatorname{tr}A=0$ gives $\operatorname{adj}(A)=A^2-\sigma_1A+\sigma_2I=A^2-\tfrac12\operatorname{tr}(A^2)\,I$, since $\sigma_1=0$ and $\sigma_2=\tfrac12\big((\operatorname{tr}A)^2-\operatorname{tr}A^2\big)$. For symmetric $A$, $\operatorname{cof}(A)=\operatorname{adj}(A)$. Hence
$$Q(A)=(1+\kappa^2)A^2-\tfrac{\kappa^2}2\operatorname{tr}(A^2)\,I_{\Lambda^+}.$$
By H1, $Q(A)\in\mathcal W_4$ is traceless on $\Lambda^+$, and $\operatorname{tr}Q(A)=(1+\kappa^2-\tfrac32\kappa^2)\operatorname{tr}A^2=(1-\tfrac{\kappa^2}2)\operatorname{tr}A^2$. Any $A\ne0$ forces $\kappa^2=2$, so on $S^2_0(\Lambda^+)$
$$Q(A)=3A^2-\operatorname{tr}(A^2)\,I,\qquad X\circ Y=\tfrac32(XY+YX)-\operatorname{tr}(XY)\,I.$$
The second formula follows from the first by expanding $\tfrac12\big(Q(X+Y)-Q(X)-Q(Y)\big)$.

*Screen of the normalisation, not load-bearing.* With $\kappa^2=2$, $\mathrm{id}^\#$ on $\Lambda^+$ is $\kappa^2\operatorname{adj}(I_3)=2I=(n-2)\,\mathrm{id}$ at $n=4$, as the brief's convention requires. And for $S^2\times S^2$ the normalised Weyl tensor is $(A_++A_-)/\sqrt2$ with $A_\pm$ unit of eigenvalue pattern $(2,-1,-1)$ on $\Lambda^\pm$, so by §2.3 below $Q$ acts on it with factor $\tfrac{\sqrt6}2\cdot\tfrac1{\sqrt2}=\tfrac{\sqrt3}2$, which is Nienhaus's $\theta_{2,2}=\sqrt2\sqrt{\tfrac12\cdot\tfrac12\cdot\tfrac32}=\tfrac{\sqrt3}2$ from Proposition 2.25.

### 2.3 The witness

Let $J$ be the $3\times3$ all-ones matrix, $E_{11}$ the matrix unit, and set, on $\Lambda^+$ and extended by $0$ on $\Lambda^-$,
$$A=\tfrac1{\sqrt6}(3E_{11}-I)=\tfrac1{\sqrt6}\mathrm{diag}(2,-1,-1),\qquad B=\tfrac1{\sqrt6}(J-I).$$
Both are symmetric and traceless, hence in $\mathcal W_4$ by H4. Each property is checked by hand.

- **Unit.** $\operatorname{tr}A^2=\tfrac16(4+1+1)=1$. Since $J^2=3J$, $B^2=\tfrac16(J^2-2J+I)=\tfrac16(J+I)$, and $\operatorname{tr}B^2=\tfrac16(3+3)=1$.
- **$A$ is critical.** $Q(A)=3\cdot\tfrac16\mathrm{diag}(4,1,1)-I=\mathrm{diag}(1,-\tfrac12,-\tfrac12)=\tfrac{\sqrt6}2A$, so $\theta_A=\tfrac{\sqrt6}2$.
- **$B$ is critical.** $Q(B)=3\cdot\tfrac16(J+I)-I=\tfrac12(J-I)=\tfrac{\sqrt6}2B$, so $\theta_B=\tfrac{\sqrt6}2$.
- **Frobenius orthogonal.** $\sqrt6A$ is diagonal with diagonal $(2,-1,-1)$ and $\sqrt6B$ has zero diagonal, so $\operatorname{tr}(AB)=\tfrac16\sum_i(\sqrt6A)_{ii}(\sqrt6B)_{ii}=0$.
- **$A\circ B\ne0$.** Write $D=\mathrm{diag}(2,-1,-1)$ and $N=J-I$. Then $(DN+ND)_{ij}=N_{ij}(d_i+d_j)$, which is $0$ on the diagonal, $2-1=1$ at $(1,2)$ and $(1,3)$, and $-1-1=-2$ at $(2,3)$. So $AB+BA=\tfrac16M$ with $M=\begin{pmatrix}0&1&1\\1&0&-2\\1&-2&0\end{pmatrix}$, and since $\operatorname{tr}(AB)=0$, $A\circ B=\tfrac32\cdot\tfrac16M=\tfrac14M\ne0$. Its norm is $\lVert A\circ B\rVert^2=\tfrac1{16}\operatorname{tr}M^2=\tfrac{12}{16}$, so $\lVert A\circ B\rVert=\tfrac{\sqrt3}2$.
- **Cross-check against the total symmetry of $T$.** Criticality and orthogonality give $\langle A\circ B,B\rangle=\langle A,Q(B)\rangle=\theta_B\langle A,B\rangle=0$ and likewise $\langle A\circ B,A\rangle=0$. By hand, $\operatorname{tr}(MD)=0$ because $M$ has zero diagonal and $D$ is diagonal, and $\operatorname{tr}(MN)=2(1+1-2)=0$. Both agree.

The pair has a geometric reading, standard and not used above: $B=gAg^{\mathsf T}$ for any $g\in SO(3)$ with $ge_1=(1,1,1)/\sqrt3$, and $SO(4)\to SO(3)\times SO(3)$ is onto, so $B$ is an $SO(4)$-rotate of $A$. The eigenvalue pattern $(2,-1,-1)$ on $\Lambda^+$ with $W^-=0$ is that of the unit Weyl tensor of $\mathbb{CP}^2$, so the witness is two Frobenius-orthogonal copies of $W_{\mathbb{CP}^2}$ at $n=4$. The step's quantifier "for some $n\ge4$" admits $n=4$.

This proves K1a.

### 2.4 Whether the paragraph establishes it

The paragraph reads, in full: "*A run at $n=8$ found two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ with $\lVert A\circ B\rVert\approx0.664$, and a rotated $S^4\times S^4$ pair at $\approx0.273$. No closed-form witness is on file.*"

- **Location of the failure.** The whole support is the sentence beginning "A run at $n=8$ found". No tensor, rotation, value of $\theta$ or orthogonality check is given, so nothing in the paragraph can be checked by a reader.
- **Concrete exhibit.** The paragraph's last sentence, "No closed-form witness is on file", states the gap in its own words. Under the brief's rule a claim supported only by a run is `HYPOTHESIS-DEBT`, and the values $\approx0.664$ and $\approx0.273$ are approximate.
- **Strongest defence.** The claim is a non-implication, so one pair settles it, and a run that returns such a pair is at least a good screen. The paragraph is also an aside: Lemma L66 assumes $A_i\circ A_j=0$ outright, so nothing in the lemma's proof depends on K1. And K1a is in fact true, by §2.3. The defence reaches the truth of the claim and the harmlessness of the aside. It does not reach the word "establishes", because the paragraph supplies no argument and no object from which a reader could recover the pair.

K1b therefore fails, while K1a holds. The repair is to replace the run report with the witness of §2.3, or any other closed-form pair checked the same way.

**Verdict: FAILS**
