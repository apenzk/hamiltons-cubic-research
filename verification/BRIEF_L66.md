# Brief, round L66

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the numbered block ([findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 33-37)

#### Lemma L66, no maximizer is $\circ$-decomposable

*Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The statement is below; **the argument is the opening section of this file, above every heading**.*

Call $W$ *$\circ$-decomposable* if $W=\sum_{i=1}^ka_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathrm{Weyl}_n$, $\sum_ia_i^2=1$, every $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$. Then no maximizer of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $\circ$-decomposable.

## Passage B, the opening section of the same file ([findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 1-17)

# Every maximiser is $\circ$-indecomposable, one line

> **Definition.** $W$ is **$\circ$-decomposable** if $W=\sum_{i=1}^k a_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathrm{Weyl}_n$, $\sum a_i^2=1$, all $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$.

> **Theorem.** *No maximiser of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $\circ$-decomposable.*

**Proof.** Write $M(n)=\max\{P(A):A\in\mathcal W_n,\lVert A\rVert=1\}$ for the global maximum; $M(n)>0$, since any sphere product attains a positive value, and **the final inequality below is strict only because of that**. $A_i\circ A_j=0$ makes $P$ **additive**: $P(W)=\sum_ia_i^3P(A_i)$. *That step uses the **total** symmetry of $T(X,Y,Z)=\langle X,Y\circ Z\rangle$*, the cross term $\langle A_i,Q(A_j)\rangle=T(A_i,A_j,A_j)$ dies only after moving the first slot to $\langle A_j,A_i\circ A_j\rangle=0$. Symmetry in the last two slots is free from the polarisation; symmetry in the first holds because $\nabla P=3Q$, recorded at [second-order.md](second-order.md). Hence
$$P(W)=\sum_ia_i^3P(A_i)\;\le\;M(n)\sum_i\lvert a_i\rvert^3\;\le\;M(n)\max_i\lvert a_i\rvert\;<\;M(n),$$
using $\sum_i\lvert a_i\rvert^3\le\max_i\lvert a_i\rvert\cdot\sum_ia_i^2=\max_i\lvert a_i\rvert$, and $\max_i\lvert a_i\rvert<1$ because $\sum a_i^2=1$ with $k\ge2$ and every $a_i\ne0$. $\square$

*The absolute values are load-bearing: with $a_i^3$ in place of $\lvert a_i\rvert^3$ the chain fails at any negative coefficient, and at $(a,b)=(0.6,-0.8)$ with pieces at $\pm M$ it gives $P(W)=+0.728$ against a bound of $-0.296$.*

**Criticality of the pieces is not needed.** With $A_i\circ A_j=0$ as the *hypothesis*, as the definition above states it, additivity is immediate and criticality never enters.

*Criticality does not **derive** $\circ$-orthogonality from ordinary orthogonality, and the witness is on the record: two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ at $n=8$ have $\lVert A\circ B\rVert=0.664362$, and a rotated $S^4\times S^4$ pair gives $0.272738$.* **What is true, and strictly weaker than the hypothesis used here:** at $k=2$, criticality plus *ordinary* orthogonality already gives exact additivity.

**Nothing else is used.** No padding, no monotonicity of $M$, no harmonic-square law, and (the part that widens the reach), **no criticality of the pieces**. $A_i$ is a unit element of $\mathrm{Weyl}_n$ and $P$ is odd, so $\lvert P(A_i)\rvert\le M(n)$ outright and the pieces' support dimensions never enter. *That matters, because a $\circ$-splitting does **not** force $n_i<n$: the record's $(S^4)^3=S^4\times S^8\oplus S^4\times S^4$ has a support-$12$ piece at $n=12$, and the $\Lambda^+/\Lambda^-$ pair on four shared coordinates has $n_i=n=4$.*

## Passage C, the canonical statement ([results.md](../results.md) line 334, landscape, and line 1096, detail)

- **Lemma L66 (second-order). No maximizer is $\circ$-decomposable.** Call $W=\sum_{i=1}^ka_iA_i$ $\circ$-decomposable if $k\ge2$, each $A_i$ a unit Weyl tensor, $\sum a_i^2=1$, every $a_i\ne0$ and $A_i\circ A_j=0$ for $i\ne j$. Then no maximizer of $P$ on the unit sphere of $\mathcal W_n$ is $\circ$-decomposable. **No criticality of the pieces is needed**, which is what makes the statement reach non-critical splittings and ones sharing coordinates. At a decomposable *critical* point the harmonic-square law $\frac1{\theta^2}=\sum_i\frac1{\theta_i^2}$ ([nondegeneracy.md](findings/nondegeneracy.md)) gives the sharper $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$; **that bound needs the criticality this lemma disclaims**, without it, sending one coefficient to $1$ sends $P(W)$ to that piece's own $\theta$, above $\min_i\lvert\theta_i\rvert$ whenever the pieces differ.

Let $W=\sum_{i=1}^ka_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathcal W_n$, $\sum_ia_i^2=1$, every $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$, where $\circ$ is the symmetric product with $\langle x\circ y,z\rangle=T(x,y,z)$. Then $W$ is no maximizer of $P$ on the unit sphere of $\mathcal W_n$: every cross term $T(A_i,A_j,\cdot)=\langle A_i\circ A_j,\cdot\rangle$ vanishes, so $P(W)=\sum_ia_i^3P(A_i)$, and with $\lvert a_i\rvert<1$ for every $i$, $\lvert P(W)\rvert\le\sum_i\lvert a_i\rvert^3\lvert P(A_i)\rvert\le M(n)\max_i\lvert a_i\rvert<M(n)$, where $M(n)=\max\{P(A):\lVert A\rVert=1\}>0$ is the global maximum. **The bound runs against $M(n)$ rather than against $\max_i\lvert P(A_i)\rvert$**, which reads $0<0$ at a splitting whose every piece has $P(A_i)=0$. The lemma is a statement about maximizers and induces nothing on the summands' dimensions: a $\circ$-decomposable $W$ can have summands of full dimension $n$, so it supports no induction on $n$.

## Passage D, the definitions the proof uses, quoted

From [findings/conventions.md](../findings/conventions.md) line 136:

- **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

From [findings/conventions.md](../findings/conventions.md) line 24, a table row:

| $T$, third sense | **the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**, whose symmetry is what makes $L_e$ self-adjoint and hence [L24](second-order.md)'s $\lambda_{\max}$ well defined at all, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$, the $\#$ part because permuting the arguments permutes the slots of two totally antisymmetric $c$'s at sign $(-1)^2$. **It was tabled nowhere while the letter already carried the bracket tensor $T_{\alpha\beta\gamma}$ and [L35](stratum-two-negative.md)'s cap $\tfrac{2\sqrt2}3A$** | [second-order.md](second-order.md) |

From [findings/second-order.md](../findings/second-order.md) line 63, its opening clause:

**Argument.** $P$ is a cubic form, so $\nabla P=3Q(W)$ and the second differential is $6\,\theta\,L_e$ [...]

## Passage E, the law Passage C cites ([findings/nondegeneracy.md](../findings/nondegeneracy.md) lines 356-359)

**Block sums over disjoint index blocks obey a harmonic-square law.** $Q$ is quadratic and additive over **disjoint coordinate blocks**, orthogonality as operators is *not* enough, since $\langle W_{S^3\times S^3},W_{\mathbb{CP}^2}\rangle=0$ at $n=6$ while the cross term is $0.2152$; the $c_{anm}$ triangle condition forces overlapping indices for a nonvanishing cross term. Coordinate-disjointness is sufficient but not necessary: the real condition is $W_A\circ W_B=0$, which a $\Lambda^+/\Lambda^-$ pair on the *same* four coordinates also satisfies. Where it applies, criticality forces $\theta=a\theta_A=b\theta_B$ and with $a^2+b^2=1$,

$$\frac1{\theta^2}=\sum_i\frac1{\theta_i^2},$$


## Passage F, the Lean statement

[lean/HamiltonsCubic/Results/L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean), read in full from disk.

## Definitions and sources

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, read as symmetric operators on $\Lambda^2\mathbb R^n$ with the Frobenius inner product. $Q(W)=W^2+W^\#$, with $\#$ the Lie-algebraic sharp product, $P(W)=\langle W,Q(W)\rangle$, and a critical point of $P$ on the unit sphere satisfies $Q(W)=\theta W$ with $\theta=P(W)$.
- A **maximizer** is a point of the unit sphere where $P$ attains its maximum over that sphere.
- No source is filed for this lemma. Say where the argument needs a fact the passages do not carry.
- **This loop does no numerical work**; a statement supported only by a run is HYPOTHESIS-DEBT.

## What to attack, beyond the standing list

1. **The pointer in Passage A**: whether the argument is where Passage A says.
2. **Additivity**, $A_i\circ A_j=0$ for $i\ne j$ giving $P(W)=\sum_ia_i^3P(A_i)$: whether every cross term of the expansion dies, and whether the total symmetry of $T$ it uses is established by what Passages B and D cite for it.
3. **$\lvert P(A_i)\rvert\le M(n)$ and $M(n)>0$**: that the maximum exists, that $P$ is odd, "$M(n)>0$, since any sphere product attains a positive value" and the dimensions at which it holds, including $n\le3$ and $n=4$.
4. **The chain** $\sum_ia_i^3P(A_i)\le M(n)\sum_i\lvert a_i\rvert^3\le M(n)\max_i\lvert a_i\rvert<M(n)$, and $\max_i\lvert a_i\rvert<1$.
5. **Passage B line 11**, the witness at $(a,b)=(0.6,-0.8)$, checked exactly.
6. **Passage B lines 13-15**: "criticality does not derive $\circ$-orthogonality from ordinary orthogonality" with its witnesses, and "at $k=2$, criticality plus *ordinary* orthogonality already gives exact additivity". Whether either is argued, and whether the lemma uses either.
7. **Passage B line 17**: the support examples $(S^4)^3=S^4\times S^8\oplus S^4\times S^4$ and the $\Lambda^+/\Lambda^-$ pair, and whether they are $\circ$-orthogonal splittings as claimed.
8. **Passage C's additions**: the absolute-value form $\lvert P(W)\rvert<M(n)$ against Passage B's $P(W)<M(n)$; "which reads $0<0$ at a splitting whose every piece has $P(A_i)=0$"; the harmonic-square clause $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$ against Passage E; "sending one coefficient to $1$ sends $P(W)$ to that piece's own $\theta$, above $\min_i\lvert\theta_i\rvert$ whenever the pieces differ"; and "a $\circ$-decomposable $W$ can have summands of full dimension $n$, so it supports no induction on $n$".
9. **Passage F**: whether the Lean statement is the lemma, in particular which symmetry of $T$ it assumes, how $\lvert P(A_i)\rvert\le M$ enters, and how $\circ$-orthogonality is encoded.
10. The boundary: $k=2$, a negative coefficient, a piece with $P(A_i)\le0$, and the smallest $n$ with $\mathcal W_n\ne0$.
