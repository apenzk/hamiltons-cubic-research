# Every maximiser is $\circ$-indecomposable, one line

> **Definition.** $W$ is **$\circ$-decomposable** if $W=\sum_{i=1}^k a_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathrm{Weyl}_n$, $\sum a_i^2=1$, all $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$.

> **Theorem.** *For $n\ge4$, no maximiser of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $\circ$-decomposable.* At $n\le3$, $\mathrm{Weyl}_n=0$.

**Proof.** Write $M(n)=\max\{P(A):A\in\mathcal W_n,\lVert A\rVert=1\}$ for the global maximum; $M(n)>0$ at every $n\ge4$, since $S^k\times S^l$ with $k,l\ge2$ has $P(W_{S_{k,l}})=\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}k\cdot\frac{l-1}l\cdot\frac{n-1}{n-2}}>0$ ([Nienhaus, Proposition 2.25](../references/nienhaus-2023-second-best-einstein/notes.md)), and **the final inequality below is strict only because of that**. $A_i\circ A_j=0$ makes $P$ **additive**: $P(W)=\sum_ia_i^3P(A_i)$. *That step uses the **total** symmetry of $T(X,Y,Z)=\langle X,Y\circ Z\rangle$*, the cross term $\langle A_i,Q(A_j)\rangle=T(A_i,A_j,A_j)$ dies only after moving the first slot to $\langle A_j,A_i\circ A_j\rangle=0$. The full symmetry is proved in Lemma L24's argument at [second-order.md](second-order.md): the $W^2$ part is the symmetrisation of $\operatorname{tr}(XYZ)$, and permuting the arguments of the $\#$ part permutes the slots of both totally antisymmetric structure constants, at sign $(-1)^2$. Hence
$$P(W)=\sum_ia_i^3P(A_i)\;\le\;M(n)\sum_i\lvert a_i\rvert^3\;\le\;M(n)\max_i\lvert a_i\rvert\;<\;M(n),$$
using $\sum_i\lvert a_i\rvert^3\le\max_i\lvert a_i\rvert\cdot\sum_ia_i^2=\max_i\lvert a_i\rvert$, and $\max_i\lvert a_i\rvert<1$ because $\sum a_i^2=1$ with $k\ge2$ and every $a_i\ne0$. $\square$

*The absolute values are load-bearing: with $a_i^3$ in place of $\lvert a_i\rvert^3$ the chain fails at any negative coefficient, and at $(a,b)=(\tfrac35,-\tfrac45)$ with pieces at $\pm M$ it gives $P(W)=\tfrac{91}{125}M$ against a bound of $-\tfrac{37}{125}M$.*

**Criticality of the pieces is not needed.** With $A_i\circ A_j=0$ as the *hypothesis*, as the definition above states it, additivity is immediate and criticality never enters.

**Criticality with ordinary orthogonality is a different hypothesis from $\circ$-orthogonality.** At $n=4$ on the self-dual block $\Lambda^+$, in an orthonormal basis, $Q(A)=3A^2-\operatorname{tr}(A^2)I$ and $X\circ Y=\tfrac32(XY+YX)-\operatorname{tr}(XY)I$. The unit pair $A=\mathrm{diag}(2,-1,-1)/\sqrt6$ and $B=(J-I)/\sqrt6$, with $J$ the all-ones matrix, has $Q(A)=\tfrac{\sqrt6}2A$, $Q(B)=\tfrac{\sqrt6}2B$ and $\operatorname{tr}(AB)=0$, while $A\circ B=\tfrac14M$ with $M=\begin{pmatrix}0&1&1\\1&0&-2\\1&-2&0\end{pmatrix}$, of norm $\tfrac{\sqrt3}2$. $B$ is an $SO(4)$-rotate of $A$, so the two are Frobenius-orthogonal critical copies of $W_{\mathbb{CP}^2}$ that are not $\circ$-orthogonal.

**Nothing else is used.** No padding, no monotonicity of $M$, no harmonic-square law, and (the part that widens the reach), **no criticality of the pieces**. $A_i$ is a unit element of $\mathrm{Weyl}_n$ and $P$ is odd, so $\lvert P(A_i)\rvert\le M(n)$ outright and the pieces' support dimensions never enter.

**Additivity verified** at a coordinate-disjoint pair at $n=8$: $P(aA+bB)=a^3P(A)+b^3P(B)$ to $10^{-16}$ at five $(a,b)$, including a negative coefficient, and at the $\Lambda^+/\Lambda^-$ pair, $P(aA+bB)=(a^3+b^3)\sqrt{3/2}$ to twelve digits, two of the three points non-critical.

## This is not new

The **direct-sum saddle lemma** excludes decomposable *local* maxima and not merely global ones, and it lives in [ATTEMPTS.md](../ATTEMPTS.md), [nondegeneracy.md](nondegeneracy.md) mentions it as being on record rather than stating it. **It is incomparable with the theorem above rather than stronger**: its hypothesis is a split over disjoint coordinate blocks with each piece critical, which is narrower than $\circ$-orthogonality, so it reaches conclusions this does not and this reaches splittings it does not, non-critical pieces, and pieces sharing coordinates. [second-order.md](second-order.md) carries it as *"decomposable points are capped by their own pieces and can never set a new maximum."*

*What this file contributes is the short proof and the retraction of an over-equipped one.* An earlier version stated the branch as an induction on $n$ conditional on base cases $5\le n_i\le11$; the induction does not descend, the base cases were never needed, and the inductive claim $\lvert\theta_i\rvert\le\theta_0(n_i)$ is false at the one base case that is proved ($M(4)=\sqrt{3/2}$ against $\theta_0(4)=0.866$, the maximum attained at $W_{\mathbb{CP}^2}$), **$M$ here is the global maximum and not $\Theta_4$**, which is the *diagonal* maximum and equals $\theta_0(4)$.

## What remains, and it is everything

**The $\circ$-indecomposable branch**, containing the sharp case: padded $W_{\mathbb{CP}^2}$ at $\sqrt{3/2}$, $\circ$-indecomposable with $\dim E(1)=1$.

*And the mechanism once proposed for it is spent: extending $r\le n(n-2)/4$ off the graded family via $S_{\mathfrak{mmm}}$ misreads [Lemma L23](../results.md), where $S_{\mathfrak{mmm}}\ge0$ **is** the cap and $S_{\mathfrak{mmm}}=0$ is the equality case, and both $r$ and $S_{\mathfrak{mmm}}$ are undefined off the **subalgebra** family, which every unbalanced sphere product already leaves.*

#### Lemma L66, no maximizer is $\circ$-decomposable

*Audited in [ROUND_L66](../verification/ROUND_L66.md): `PROVEN, hypotheses corrected`. The argument is the opening section of this file.*

Call $W$ *$\circ$-decomposable* if $W=\sum_{i=1}^ka_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathrm{Weyl}_n$, $\sum_ia_i^2=1$, every $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$. Then for $n\ge4$ no maximizer of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $\circ$-decomposable.

