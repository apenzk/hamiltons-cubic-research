# Brief for round L28

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical statement, from results.md lines 439-445

```markdown
##### Lemma L28, the $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$

For every $m\ge3$, the $\mathfrak u(m)$-invariant line in $\mathrm{Weyl}_{2m}$ is spanned by a critical $W_{\mathbb{CP}^m}$ with $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, and

$$\dim E(\tfrac12)=\dim(\text{orbit})=m(m-1),\qquad \lambda_{\max}(L_e|_{W^\perp})=\frac{m+2}{2(m+1)}=\tfrac12+\frac1{2(m+1)} .$$

So $\mathbb{CP}^m$ is Morse–Bott nondegenerate and, since $\lambda_{\max}>\tfrac12$, is not a maximiser.
```

## B. The landscape statement, from results.md line 142

```markdown
- **Lemma L28 (landscape). The $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$.** The $U(m)$-decomposition is multiplicity-free, so Schur fixes one eigenvalue per summand, and each is $1-\frac{c_S+q_S^2}{4(m+1)}$. Only $\tfrac2{m+1}$ reaches $\tfrac12$, at $m=3$, where that summand is empty.
```

## C. The block in findings/nondegeneracy.md, lines 512-546

```markdown
#### Lemma L28, the $\mathbb{CP}^m$ family is nondegenerate at every $m\ge3$, canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

Needed because route R2 closes only if **every** graded critical point is nondegenerate: a nondegenerate orbit is
open in $\mathrm{Crit}(P)$ and $S=0$ is closed, so the graded set would then be a union of connected components
and $S\ge c>0$ on the rest by compactness. Lemma L27 settles the two-block sphere products; the graded
classification leaves the $\mathbb{CP}^m$ family, which is this entry.

**Statement.** For every $m\ge3$, the $\mathfrak u(m)$-invariant line in $\mathrm{Weyl}_{2m}$ is spanned by a critical
$W_{\mathbb{CP}^m}$ with $\theta^2=\frac{(m+1)(2m-1)}{3m(m-1)}$, and
$$\dim E(\tfrac12)=\dim(\text{orbit})=m(m-1),\qquad \lambda_{\max}(L_e|_{W^\perp})=\frac{m+2}{2(m+1)}=\tfrac12+\frac1{2(m+1)} .$$
So $\mathbb{CP}^m$ is Morse–Bott nondegenerate and, since $\lambda_{\max}>\tfrac12$, is not a maximiser.

**Argument.** $\mathrm{Weyl}_{2m}\otimes\mathbb C$ is $U(m)$-multiplicity-free with **ten** summands (the $GL_m\subset O_{2m}$ branching rule at $\lambda=(2,2)$), falling into **seven** classes over $\mathbb R$, three of them conjugate pairs. Since $e$ is $U(m)$-invariant, $L_e$ is equivariant and Schur makes it a **scalar** on each summand, so each value is an eigenvalue and not merely a Rayleigh lower bound.

| $GL(m)$ highest weight | real dimension | $L_e$ | $c_S+q_S^2$ |
|---|---|---|---|
| $(0^m)$, the line $\langle W\rangle$ | $1$ | $1$ | $0$ |
| $(1,0^{m-2},-1)$, the $\mathfrak{su}(m)$ adjoint | $m^2-1$ | $\frac{m+2}{2(m+1)}$ | $2m$ |
| $(1,1,0^{m-2})\oplus$ dual, $\Lambda^2E\oplus\Lambda^2\bar E$, the orbit tangent | $m(m-1)$ | $\tfrac12$ | $2(m+1)$ |
| $(1,1,0^{m-4},-1,-1)$, $V_{(1,1);(1,1)}$, **absent at $m=3$** | $\frac{m^2(m+1)(m-3)}4$ | $\frac2{m+1}$ | $4(m-1)$ |
| $(2,1,0^{m-3},-1)\oplus$ dual | $\frac{2m^2(m^2-4)}3$ | $0$ | $4(m+1)$ |
| $(2,0^{m-2},-2)$, $V_{(2);(2)}$, Bochner | $\frac{m^2(m-1)(m+3)}4$ | $0$ | $4(m+1)$ |
| $(2,2,0^{m-2})\oplus$ dual | $\frac{m^2(m^2-1)}6$ | $-\frac3{m+1}$ | $4(m+4)$ |

The seven real dimensions sum to $\dim\mathcal W_{2m}=\frac{m(m+1)(2m+1)(2m-3)}3$ identically in $m$. **The same table stands at [second-order.md](second-order.md), with the explicit $c_S=\sum_i\nu_i(\nu_i+m+1-2i)$ and $q_S=\sum_i\nu_i$ and the $\sharp$ closed forms behind it.**

**Nondegeneracy is arithmetic**: $\lambda_S=1-\frac{c_S+q_S^2}{4(m+1)}$ equals $\tfrac12$ exactly when $c_S+q_S^2=2(m+1)$. That holds identically on the orbit, and among the rest only $4(m-1)$ can meet it, at $m=3$ alone, **where that summand is absent.** It needs four rows of a Young diagram against the $m=3$ available, so the branching rule does not produce it, and $\frac{m^2(m+1)(m-3)}4$ vanishing there is the analytic continuation agreeing with the absence rather than the reason for it. **Hence $E(\tfrac12)$ is the orbit tangent at every $m\ge3$**, and *equals* it rather than merely containing it, since multiplicity-freeness makes $E(\tfrac12)$ a sum of whole summands. With **no exception**, unlike the sphere products. $\square$

**Two identities check the whole list, and each fails if any single value is wrong by a rational function of $m$.** Fox's Theorem 1.3, at [algebra.md](algebra.md), gives $\mathop{\mathrm{tr}}L(x)=0$ and $\mathop{\mathrm{tr}}(L(x)L(y))=\kappa_F\langle x,y\rangle$ with $\kappa_F(n)=\frac{(2n-1)(n-1)}4$. The seven rows satisfy both identically in $m$: $\mathop{\mathrm{tr}}L_e=0$, and $\mathop{\mathrm{tr}}(L_e^2)=\frac{3m(m-1)(4m-1)}{4(m+1)}=\kappa_F(2m)\lVert e\rVert^2$.

**And the trace identity derives the row the conclusion rests on.** Only $\lambda=1$ on $\langle W\rangle$ and $\lambda=\tfrac12$ on the orbit are structural, $Q(e)=e$ gives the first, and $O(n)$-equivariance of $Q$ differentiated along the orbit gives the second. The other five are computed, and the one carrying "not a maximiser" is $\lambda_{\max}$ on the $\mathfrak{su}(m)$ adjoint. Holding the rest fixed and solving $\mathop{\mathrm{tr}}L_e=0$ for the unknown $y$ there,
$$1+(m^2-1)y+\frac{m(m-1)}2+\frac{m^2(m-3)}2-\frac{m^2(m-1)}2=0,\qquad (m^2-1)y=\frac{(m+2)(m-1)}2,\qquad y=\frac{m+2}{2(m+1)} .$$
The same solve returns $\frac2{m+1}$, $-\frac3{m+1}$ and $0$ on each remaining class, **each uniquely from the other four**. So $\lambda_{\max}$ rests on more than the charge formula, which matters, since the charge formula is where this block's one arithmetic error stood.
```
