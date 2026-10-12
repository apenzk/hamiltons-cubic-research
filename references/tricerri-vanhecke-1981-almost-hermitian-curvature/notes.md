# Extraction

## The one statement this project needs, quoted from the accessible restatement

Brozos-Vázquez–Gilkey–Nikčević, [arXiv:1105.0185](https://arxiv.org/abs/1105.0185), Introduction (their $m$ is the **real** dimension):

> "Tricerri and Vanhecke [25] gave a similar decomposition of $R$ in the almost Hermitian setting; the appropriate structure group there is the unitary group $U^\star$ and there are 10 irreducible unitary modules comprising the decomposition in dimension $m \ge 8$; if $m = 6$, then there are 9 summands and if $m = 4$, then there are 7 summands in the decomposition."

Same page, for the orthogonal comparison they are drawing:

> "Singer and Thorpe [23] showed that the space $R$ of Riemann curvature tensors has 3 irreducible components under the action of the orthogonal group $O$ in dimension $m \ge 4$; these are the space of Weyl conformal curvature tensors, the space of trace free Ricci tensors, and the space of constant sectional curvature tensors."

and, for the Kähler sub-case:

> "the Riemannian Kähler curvature tensors have 3 factors in their decomposition ($m \ge 4$) as unitary modules."

## How that lines up with this project's decomposition

Write $n = 2m_{\mathbb C}$ for the real dimension. Singer–Thorpe gives $R = \mathbb R \oplus S^2_0 \oplus \mathrm{Weyl}_n$ over $O(n)$, so restricting to $U(m_{\mathbb C})$,

$$\#\{\text{real } U\text{-summands of } R\} \;=\; \#\{\text{of } \mathrm{Weyl}_n\} \;+\; \#\{\text{of } S^2_0\} \;+\; 1 ,$$

and $S^2_0(\mathbb R^{2m})$ splits over $U(m)$ into exactly two real summands, the $(1,1)$ part $\mathfrak{su}(m)$ and the $(2,0)+(0,2)$ part $S^2E \oplus S^2\bar E$. So Tricerri–Vanhecke's count predicts $10 - 3 = 7$ real summands in $\mathrm{Weyl}_{2m}$ for $m_{\mathbb C} \ge 4$ and $9 - 3 = 6$ for $m_{\mathbb C} = 3$.

That is exactly what Reviewer 41's independent derivation and measurement give: seven real summands (ten complex ones, three of them conjugate pairs) for $m \ge 4$, and six for $m = 3$, the missing one being $V_{(1,1);(1,1)}$, whose dimension formula $m^2(m+1)(m-3)/4$ vanishes at $m=3$.

The Kähler sub-case also matches. The Kähler curvature tensors inside $R$ are $\mathbb R \oplus \mathfrak{su}(m) \oplus V_{(2);(2)}$, three unitary modules, with $V_{(2);(2)}$ the Bochner tensor, of dimension $m^2(m+3)(m-1)/4$; $27$ at $m=3$, $84$ at $m=4$, $200$ at $m=5$.

## What is *not* in this source

Tricerri–Vanhecke decompose the space; they do not compute the multiplication operator $L_e = e \circ (\cdot)$ of the Fox algebra at the $\mathbb{CP}^m$ idempotent, so the eigenvalue carried by each summand (the content of the nondegeneracy statement), is not prior art. Neither is the identification of which summand is the orbit tangent.

## Caveat on the citation

The primary source was not read: the AMS copy returns HTTP 403 and no open copy was located. Everything above is quoted from the secondary source stored alongside, whose author list is independent of Tricerri and Vanhecke. Any argument that needs the *labels* $W_1,\dots,W_{10}$, their explicit projections or their norms must go back to the 1981 paper; the count is all that was used here, and the count was in any case re-derived from scratch rather than taken on trust.
