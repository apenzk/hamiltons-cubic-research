# Brief for round L48

**Verbatim extracts. Nothing here is paraphrased.**

## A. The canonical entry, from results.md lines 543-545, reproduced in full

```markdown
##### Lemma L48, the reducible case, and the symmetric-space theorem

**Proof:** [problem.md](findings/problem.md)
```

## B. The landscape statement, from results.md line 172

```markdown
- **Lemma L48 (landscape). The reducible case, and the symmetric-space theorem.** For a product the mixed terms vanish, so $\lVert W\rVert^2$ depends on the partition alone; Jensen puts the minimum at the balanced split. The two halves meet at $n^2-12n+8$, the threshold polynomial, recovered rather than assumed.
```

## C. The block in findings/problem.md, lines 252-262

```markdown
#### Lemma L48, (the reducible case, and the symmetric-space theorem) · (B), canonical statement and proof

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

**Statement and argument.** For a product, $R$ is block-diagonal on $\Lambda^2$ and **zero on the mixed terms**, so factorwise $\lVert W\rVert^2=\sum_a\lVert W_a\rVert^2+B$ with $B=\sum_af(n_a)-\frac n{8(n-1)}$ and $f(m)=\frac m{8(m-1)}$, depending on the **partition alone**. Since $f$ is decreasing and convex, Jensen minimises $\sum f$ at the balanced split for fixed $k$, and $k\,f(n/k)=\frac{kn}{8(n-k)}$ increases in $k$; each $\lVert W_a\rVert^2\ge0$ vanishes exactly when that factor is a sphere. So the reducible minimum sits at $S^{n/2}\times S^{n/2}$, where $\lVert W\rVert^2=\frac{n^2}{8(n-1)(n-2)}=\frac1{4\theta_0(n)^2}$.

The two halves meet with no gap because $\tfrac16\ge\frac{n^2}{8(n-1)(n-2)}\iff n^2-12n+8\ge0$, **the same polynomial as the threshold $n=6+2\sqrt7$**, which the argument recovers rather than assumes.

> **Theorem.** For every $n\ge12$, every compact **Einstein** symmetric space of dimension $n$ satisfies $\theta\le\theta_0(n)$, with equality exactly at $S^{n/2}\times S^{n/2}$ **with both factors of constant curvature and equal Einstein constant**, when $n$ is even.

> **TWO HYPOTHESES WERE MISSING, AND NEITHER CHANGES A VALUE.** *[r462](../reviews/REVIEW_r462.md) and [r463](../reviews/REVIEW_r463.md) both found the quantifier too wide and the equality case understated.* **Einstein is load-bearing**: the $\theta$ above comes from [Lemma L46](../findings/problem.md#lemma-l46-at-a-locally-symmetric-einstein-space-the-weyl-part-is-critical-and-theta-is-quadratic)'s identity $Q(W)=\lambda W$, which needs $\mathrm{Ric}=\lambda g$, *and a reducible symmetric space whose factors carry different Einstein constants is not Einstein, so the formula never applied to it.* **The equality case needs the factors round**, since "sphere" alone does not fix the metric that attains $\theta_0(n)$. At odd $n$ the best split falls strictly below, $\theta^2=\tfrac{120}{77}$ against $\theta_0^2=\tfrac{264}{169}$ at $n=13$. $\square$
```

## D. The consumer that quotes the Theorem, results.md line 567

```markdown
Let $n\ge12$ and let $W$ be an equivariant graded critical point, the Weyl operator of a compact symmetric space, the correspondence proved by the invariant count in [graded-half.md](findings/graded-half.md) rather than by Lemma L8, which assumes it, with $\theta\ge\sqrt{3/2}$. Then $W$ is the Weyl tensor of a two-factor sphere product $S^p\times S^q$ with $p,q\ge5$, and every such point is Morse–Bott nondegenerate with $\lambda_{\max}(L_e\vert_{W^\perp})=\tfrac12$ attained exactly on the orbit tangent. Irreducible spaces have $\theta\le\sqrt{3/2}$ with equality only at $\mathbb{CP}^2$ (Lemma L47); for reducible ones $\lVert W\rVert^2$ depends on the partition alone with every non-sphere factor adding to it (Lemma L48), so above the threshold every factor is a sphere and $k=2$; and with $f(m)=\frac m{8(m-1)}$ the condition $\lVert W\rVert^2\le\frac16$ reads $\frac1{p-1}+\frac1{q-1}-\frac1{n-1}\le\frac13$, which fails outright at $p\le4$ for every $n$ and at $p=5$ is $n^2-7n-54\ge0$, i.e. $n\ge12$. Nondegeneracy is Lemma L27, whose gap to the next eigenvalue is $\frac1{2(M-1)}$ with $M=\max(p,q)$. At an $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ pair the $\mathrm{ad}(\mathfrak p)$-commutant in $\mathcal W_n$ is one-dimensional, so the equivariant point is the sphere product by that alone; at a $\mathfrak u(m)$ pair the unique invariant is $\mathbb{CP}^m$, which the threshold excludes. The lemma is stated in the pair-graded sense and reaches no non-equivariant graded point; the $\mathbb Z_2$-grading enumeration it quotes is complete for $n\ne8$, and $\Delta=0$ certifies equivariance only where $\ker W=0$.
```
