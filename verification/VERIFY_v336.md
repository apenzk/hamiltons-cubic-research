# Verifier v336, L111 step D3: every coordinate-diagonal Weyl tensor satisfies the bracket form and is nowhere near critical

*Cold brief [ADJ_L111_D3.md](ADJ_L111_D3.md). No numerical work was done and no scripts were written. Every value below is exact and derived by hand. Log: [agent_logs/verify-L111-v336.log](../agent_logs/verify-L111-v336.log).*

| Claim | Verdict |
|---|---|
| D3a. Every coordinate-diagonal Weyl tensor satisfies the bracket form $[W,Q(W)]=0$ | CONFIRMED |
| D3b. Every coordinate-diagonal Weyl tensor is non-critical | REFUTED AS STATED |
| D3c. Coordinate-diagonal Weyl tensors are "nowhere near critical" (criticality residual bounded away from zero on the family) | REFUTED |
| D3d. The diagonal family contains non-critical elements for every $n\ge4$, so the bracket form is strictly weaker than criticality | CONFIRMED |
| D3e. The diagonal family has dimension $n(n-3)/2$ | CONFIRMED AS ALGEBRA |

**Summary: the unit Weyl tensors of $S^2\times S^2$ and $S^3\times S^3$ are coordinate-diagonal and critical, with $Q(W)=\tfrac{\sqrt3}{2}W$ and $Q(W)=\tfrac{\sqrt{10}}{3}W$, so "every diagonal Weyl tensor is nowhere near critical" fails, while "a generic diagonal Weyl tensor is non-critical" holds and suffices for strictness.**

## 0. Conventions, fixed once

- $\mathcal W_n\subset\mathrm{Sym}(\Lambda^2\mathbb R^n)$, Frobenius inner product, $N=\binom n2$. $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$. Critical on the unit sphere means $Q(W)=\theta W$ with $\theta=P(W)$, as Passage B fixes it.
- $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $E_{ij}=e_ie_j^{\mathsf T}-e_je_i^{\mathsf T}$ ($i<j$) and $\langle A,B\rangle=-\tfrac12\operatorname{tr}(AB)$, so $\{E_{ij}\}$ is orthonormal. For distinct $i,j,k$ one has $[E_{ij},E_{jk}]=E_{ik}$, brackets of disjoint planes vanish, so every nonzero structure constant in this basis is $c_{abc}=\pm1$.
- The index formula carries the $\tfrac12$ of Passage B: $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$. This normalisation is the one that returns $\mathrm{id}^\#=(n-2)\mathrm{id}$ and relation (A), $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$, because the plane $E_{ij}$ is the bracket of exactly the $2(n-2)$ ordered pairs $(E_{ik},E_{jk})$, $(E_{jk},E_{ik})$ with $k\notin\{i,j\}$.
- A coordinate-diagonal Weyl tensor is $W E_{ij}=\mu_{ij}E_{ij}$. Encode it as the symmetric $n\times n$ matrix $\mu$ with zero diagonal. $\mu^2$ denotes the matrix square of $\mu$, and $\mathbf 1$ the all-ones vector.
- The criticality residual of a unit $W$ is $\rho(W)=\lVert Q(W)-P(W)W\rVert$. Section 2 shows $Q(W)\in\mathcal W_n$ on the diagonal family, so $\rho$ is the norm of the tangential part of $Q(W)$ and $\rho(W)=0$ is exactly criticality.

## Hypothesis inventory

- **H1.** $n\ge4$. For $n=3$ the space $\mathcal W_3$ is zero and the step is vacuous.
- **H2.** The $\tfrac12$ in the index formula for $\#$ (Passage B). Under the doubled $\#$ the literal equation $Q(W)=\theta W$ acquires a trace part on the diagonal family, and criticality must then be read as $\mathrm{pr}_{\mathcal W_n}Q(W)=\theta W$. Section 3.3 shows the conclusion about $S^2\times S^2$ is unchanged under that reading.
- **H3.** "Critical" means $Q(W)=\theta W$ on the unit sphere, as in Passage B and the brief.
- **H4 (the reading that makes the step VALID).** "Nowhere near critical" is read as "not contained in the critical set, and non-critical off a proper real-algebraic subset of the family". The literal universal reading needs no extra hypothesis and is false.

## 1. The diagonal family and its dimension (D3e)

The first Bianchi identity holds for any $R$ with $R_{ijkl}$ supported on $\{i,j\}=\{k,l\}$: the three terms of $R_{ijkl}+R_{jkil}+R_{kijl}$ can be nonzero only when two of the pairs coincide as sets, and a direct check of those cases gives zero. The Weyl condition is then that the Ricci contraction vanishes, $\sum_{j}\mu_{ij}=0$ for every $i$, that is $\mu\mathbf 1=0$. Symmetric zero-diagonal matrices form a space of dimension $\binom n2$, and the $n$ row-sum functionals are linearly independent on it for $n\ge4$ (H1), so the family has dimension $\binom n2-n=n(n-3)/2$. For $n=4$ this is the plane $\mu_{12}=\mu_{34}=x$, $\mu_{13}=\mu_{24}=y$, $\mu_{14}=\mu_{23}=z$ with $x+y+z=0$.

## 2. $Q(W)$ on the diagonal family, and the bracket form (D3a)

**$W^\#$ is diagonal in the coordinate basis.** With $W$ diagonal, $(W^\#)_{ab}=\tfrac12\sum_{c,d}c_{acd}c_{bcd}\,\mu_c\mu_d$. A product $c_{acd}c_{bcd}\neq0$ requires $[c,d]$ to have a component along both $a$ and $b$. The bracket of two coordinate planes is $\pm$ one coordinate plane or zero, so $a=b$. For $a=E_{ij}$ the contributing ordered pairs are the $2(n-2)$ listed in Section 0, each with $c^2=1$, so

$$(W^\#)_{ij,ij}=\sum_{k\notin\{i,j\}}\mu_{ik}\mu_{jk}=(\mu^2)_{ij},\qquad Q(W)E_{ij}=q_{ij}E_{ij},\quad q_{ij}=\mu_{ij}^2+(\mu^2)_{ij},$$

the restriction $k\notin\{i,j\}$ being automatic because $\mu$ has zero diagonal.

**$Q(W)$ is itself a diagonal Weyl tensor.** Its Ricci contraction at $i$ is $\sum_{j\ne i}q_{ij}=(\mu^2)_{ii}+(\mu^2\mathbf 1)_i-(\mu^2)_{ii}=(\mu(\mu\mathbf 1))_i=0$. Its trace is $\tfrac12\mathbf 1^{\mathsf T}\mu^2\mathbf 1=\tfrac12\lVert\mu\mathbf 1\rVert^2=0$. So $Q(W)\in\mathcal W_n$ with no projection needed, and criticality on the family is the $\binom n2$ scalar equations $q_{ij}=\theta\mu_{ij}$.

**The bracket form holds.** $W$ and $Q(W)$ are both diagonal in the basis $\{E_{ij}\}$, so $[W,Q(W)]=0$. In bracket coordinates: in any orthonormal eigenbasis $\{\varphi_k\}$ of $W$ the index formula gives $\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta c_{k\alpha\beta}c_{l\alpha\beta}=2(W^\#)_{kl}$. Since $W^\#$ commutes with $W$ it preserves each eigenspace of $W$, so $(W^\#)_{kl}=0$ whenever $\lambda_k\ne\lambda_l$. This holds in every eigenbasis, including the non-coordinate ones that exist when eigenvalues repeat. D3a is CONFIRMED.

## 3. The object: $S^p\times S^p$ is coordinate-diagonal and critical (D3b)

### 3.1 The Weyl tensor

Take unit-curvature factors on $\mathbb R^p\oplus\mathbb R^p$, $n=2p$, in a product-adapted orthonormal frame. The curvature operator is $1$ on planes inside one factor and $0$ on mixed planes, the metric is Einstein with $\mathrm{Ric}=(p-1)g$ and scalar curvature $2p(p-1)$, so $W=R-\tfrac{p-1}{2p-1}\,\mathrm{id}$ on $\Lambda^2$. Up to the positive factor $\tfrac1{2p-1}$:

$$\mu_{ij}=a=p\ \text{ if $i,j$ lie in the same factor},\qquad \mu_{ij}=b=-(p-1)\ \text{ if they lie in different factors}.$$

Row sums: $(p-1)p+p\cdot(-(p-1))=0$. This is coordinate-diagonal and matches the object of the brief.

### 3.2 Criticality, exactly

From Section 2, for $i\ne j$ in the same factor $(\mu^2)_{ij}=(p-2)a^2+pb^2$, and for $i,j$ in different factors $(\mu^2)_{ij}=2(p-1)ab$. Hence

$$q_{\text{same}}=a^2(p-1)+pb^2=p^2(p-1)+p(p-1)^2=p(p-1)(2p-1)=(p-1)(2p-1)\,a,$$

$$q_{\text{cross}}=b^2+2(p-1)ab=(p-1)^2-2p(p-1)^2=-(p-1)^2(2p-1)=(p-1)(2p-1)\,b.$$

So $Q(W)=(p-1)(2p-1)\,W$ for this $W$. Its norm is $\lVert W\rVert^2=p(p-1)a^2+p^2b^2=p^2(p-1)(2p-1)$, so the unit tensor $\hat W=W/\lVert W\rVert$ satisfies, by homogeneity of degree two of $Q$,

$$Q(\hat W)=\theta\hat W,\qquad \theta=P(\hat W)=\frac{\sqrt{(p-1)(2p-1)}}{p}.$$

- $p=2$, $S^2\times S^2\subset\mathcal W_4$: $\mu$ values $(2,-1)$, $Q(W)=3W$, $\theta=\tfrac{\sqrt3}{2}$. Check: $q_{\text{same}}=4+2=6=3\cdot2$, $q_{\text{cross}}=1-4=-3=3\cdot(-1)$.
- $p=3$, $S^3\times S^3\subset\mathcal W_6$: $\mu$ values $(3,-2)$, $Q(W)=10W$, $\theta=\tfrac{\sqrt{10}}{3}$. Check: $q_{\text{same}}=18+12=30=10\cdot3$, $q_{\text{cross}}=4-24=-20=10\cdot(-2)$.

Both are coordinate-diagonal, both satisfy the bracket form by Section 2, and both are critical with residual $\rho=0$ exactly. The sentence quoted in the step, "every diagonal Weyl tensor satisfies it while being nowhere near critical" (Passage A, [findings/bounds.md](../findings/bounds.md) line 660), and its echo "is satisfied by every diagonal Weyl tensor" read with "strictly weaker" in Passage B, are false as universal statements about criticality. $-\hat W$ is critical too, with $\theta$ replaced by $-\theta$, since $Q$ is even. D3b is REFUTED AS STATED.

### 3.3 Robustness under H2

If $\#$ were doubled, $Q'(W)=W^2+2W^\#$ has trace $\tfrac12\lVert\mu\rVert_F^2+\big(\mathbf 1^{\mathsf T}\mu^2\mathbf 1-\operatorname{tr}\mu^2\big)=\tfrac12\lVert\mu\rVert_F^2-\lVert\mu\rVert_F^2=-\tfrac12\lVert\mu\rVert_F^2\neq0$, so $Q'(W)\notin\mathcal W_n$ and criticality means $Q'(W)-c\,\mathrm{id}=\theta W$ for some $c$. For $S^2\times S^2$ with $\mu$ values $(2,-1)$: $q'_{\text{same}}=4+2\cdot2=8$, $q'_{\text{cross}}=1-8=-7$, and $c=-2$ gives $10=5\cdot2$, $-5=5\cdot(-1)$. The object is critical under either normalisation once criticality is the first-order condition on $\mathcal W_n$. The refutation does not rest on H2.

## 4. "Nowhere near critical" fails quantitatively (D3c): the whole of $\mathcal W_4$'s diagonal circle

On $n=4$, write $s=x^2+y^2+z^2$. With $x+y+z=0$, $yz=(xy+yz+zx)+x^2=x^2-\tfrac s2$, so

$$q_{12}=x^2+2yz=3x^2-s,\quad\text{and cyclically}\quad q_{13}=3y^2-s,\ q_{14}=3z^2-s.$$

**Critical points.** $3t^2-s=\theta t$ for $t\in\{x,y,z\}$ forces $x,y,z$ to be roots of one quadratic, hence to take at most two values. With $x+y+z=0$ and $W\ne0$ this is exactly $(x,y,z)\propto(1,1,-2)$ up to permutation, and $(t,t,-2t)$ is critical with $\theta\lVert W\rVert=-3t$ in both slots ($-3t^2=\theta t$ and $6t^2=\theta(-2t)$). These are $S^2\times S^2$ for its three product splittings of $\mathbb R^4$ and their negatives: six unit points.

**The residual in closed form.** Unit norm is $2s=1$. Parametrise $x=\tfrac1{\sqrt3}\cos\varphi$, $y=\tfrac1{\sqrt3}\cos(\varphi+\tfrac{2\pi}3)$, $z=\tfrac1{\sqrt3}\cos(\varphi+\tfrac{4\pi}3)$, which gives $x+y+z=0$ and $s=\tfrac12$. Then $\sum x^3=3xyz=\tfrac{\cos3\varphi}{4\sqrt3}$, so $P=2\sum x(3x^2-s)=6\sum x^3=\tfrac{\sqrt3}2\cos3\varphi$. With $\sum x^4=\tfrac12s^2=\tfrac18$ (valid when $\sum x=0$), $\lVert Q\rVert^2=2\sum(3x^2-\tfrac12)^2=2(\tfrac98-\tfrac32+\tfrac34)=\tfrac34$. Since $\langle Q,W\rangle=P$ and $\lVert W\rVert=1$,

$$\rho(W)^2=\lVert Q\rVert^2-P^2=\tfrac34\sin^2 3\varphi,\qquad \rho(W)=\tfrac{\sqrt3}{2}\,\lvert\sin3\varphi\rvert.$$

- $\rho=0$ at $\varphi\in\tfrac\pi3\mathbb Z$, the six critical points of the previous paragraph ($\varphi=0$ gives $(2,-1,-1)/(2\sqrt3)$, which is $S^2\times S^2$, with $P=\tfrac{\sqrt3}2$ as in Section 3.2).
- $\rho$ attains its maximum $\tfrac{\sqrt3}2$ at $\varphi\in\tfrac\pi6+\tfrac\pi3\mathbb Z$, for example $(x,y,z)=(\tfrac12,-\tfrac12,0)$ with $P=0$.
- $\rho$ is continuous and takes every value in $[0,\tfrac{\sqrt3}2]$, so diagonal Weyl tensors arbitrarily close to $S^2\times S^2$ are arbitrarily close to critical.

No positive lower bound on $\rho$ holds over the diagonal family. D3c is REFUTED.

## 5. The strictness the sentence exists to deliver (D3d)

The lemma needs only one diagonal Weyl tensor that satisfies the bracket form and is not critical. For every $n\ge4$ take $\mu_{12}=\mu_{34}=1$, $\mu_{13}=\mu_{24}=-1$ and all other $\mu_{ij}=0$. Row sums vanish, so $W\in\mathcal W_n$. For indices in $\{1,2,3,4\}$, $\mu^2$ agrees with the $n=4$ computation because rows $5,\dots,n$ of $\mu$ vanish, so $q_{14}=3z^2-s=-2$ with $z=0$, $s=2$. Criticality would require $q_{14}=\theta\mu_{14}=0$. So $W$ is not critical for any $\theta$, and it satisfies the bracket form by Section 2. This is the Lean witness `bracket_form_strictly_weaker` realised by an actual Weyl tensor.

Genericity follows. Criticality on the family is the vanishing of all $2\times2$ minors $q_{ij}\mu_{kl}-q_{kl}\mu_{ij}$, a real-algebraic condition on the $n(n-3)/2$-dimensional family. The witness shows the condition is not identically satisfied, so the critical diagonal tensors form a proper algebraic subset, of empty interior, and the non-critical ones are open and dense in the family. D3d is CONFIRMED.

## 6. Arguing the opposite

- *"Nowhere near critical" could mean only the six sampled elements.* The sentence quantifies over "every diagonal Weyl tensor", and the sampled residuals are cited as evidence for that universal. On the sampled elements the claim is a statement about decimals this verifier does not evaluate. As a statement about the family it is refuted by Sections 3 and 4.
- *Perhaps the frame of $S^2\times S^2$ is excluded.* The brief defines coordinate-diagonal as diagonal on the coordinate planes $e_i\wedge e_j$, and the product-adapted frame makes $S^p\times S^p$ exactly that. Any orthonormal frame is a coordinate frame after an $O(n)$ rotation, and both the diagonal condition and criticality are read in it.
- *Perhaps criticality is meant with a projection or another normalisation of $\#$.* Section 2 shows $Q(W)\in\mathcal W_n$ on the family under the record's $\#$, so projection changes nothing, and Section 3.3 shows the doubled $\#$ with projection gives the same critical point.
- *Perhaps "critical" means a critical point of $P$ that is also a maximum, or non-degenerate.* Passage B defines "critical point" as $Q(W)=\theta W$, and the step's contrast is with that condition.

## 7. Verdict for the step

**FAILS as written.** The quoted line "every diagonal Weyl tensor satisfies it while being nowhere near critical" is false: the unit Weyl tensors of $S^2\times S^2$ and $S^3\times S^3$ in product-adapted frames are coordinate-diagonal and critical, $Q(\hat W)=\tfrac{\sqrt3}2\hat W$ and $Q(\hat W)=\tfrac{\sqrt{10}}3\hat W$, and on the diagonal circle of $\mathcal W_4$ the criticality residual is $\tfrac{\sqrt3}2\lvert\sin3\varphi\rvert$, which vanishes at six points and is arbitrarily small near them.

**VALID under the repaired reading** "every coordinate-diagonal Weyl tensor satisfies the bracket form, and off a proper real-algebraic subset of the $n(n-3)/2$-dimensional diagonal family (six unit points when $n=4$, containing $\pm S^p\times S^p$ when $n=2p$) it is not critical". That reading needs H1 ($n\ge4$), H3 (criticality is $Q(W)=\theta W$ on the unit sphere), and H2 (the $\tfrac12$ in $\#$) or, equivalently for this purpose, criticality read as the first-order condition on $\mathcal W_n$. It delivers everything the lemma uses the sentence for, namely that the bracket form is strictly weaker than criticality.
