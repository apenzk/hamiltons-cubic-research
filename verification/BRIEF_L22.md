# Brief for round L22

**Verbatim extracts. Nothing here is paraphrased. Where the record states the same thing twice, both are given unlabelled.**

## A. The canonical entry, results.md lines 725-729

```markdown
##### Observation L22, the estimate the localization theorem needs, at $n=12,14,16$

Nienhaus's localization theorem holds for $10\le n\le11$, and what stops it above $11$ is a single estimate inside his Theorem 4.17, which he states and records that he could not supply. For every $n\ge12$ that estimate holds: at the maximiser of the inner problem the configuration is forced, so both couplings are evaluated at one pair, the inner maximisation is a hard-case trust-region problem with a closed-form frontier, and two branches cover complementary intervals of the parameter at every $n$. **Lemma L20's bootstrap does not consume it.** *This is the fourth place to name [Observation L22](findings/route-a.md) as an input to L20; the proof invokes it nowhere, and had it done so L20 would inherit L22's conditionality instead of being free of it* (a prior audit)).

**Proof:** [route-a.md](findings/route-a.md)
```

## B. The landscape statement, results.md line 236

```markdown
- **Observation L22 (localization). The localization theorem's missing estimate, at $n=12,14,16$, RELABELLED from Lemma, its inputs being measurements.** *Its load-bearing input is [Observation L102](findings/route-a.md), verified numerically at $n=12,14,16$ and not proven; both branches take the sphere-product value as their constant, which makes the estimate conditional on Conjecture A at critical points past $n=12$ and therefore circular against this programme's goal; and the overlap claim rests on an $n\to\infty$ limit with margin $+0.0074$ and no monotonicity proof (a prior audit).* Nienhaus states it and records that he could not supply it. At the maximiser the configuration is forced, so both couplings are evaluated at one pair, and the inner maximisation is a hard-case trust-region problem with a closed-form frontier. Two branches then cover complementary intervals at every $n$.
```

## C. A summary line elsewhere in results.md, line 41

```markdown
- **The neighbourhood of the rival is closed** for every $n\ge12$ (Lemmas 20–22), including the estimate Nienhaus states and leaves open, **conditional on the eigenvalue bound $\alpha\le\tfrac13$**, which no argument on the record proves, and note that the bundle contains the conditional Observation L22.
```

## D. The block, findings/route-a.md lines 534-564

```markdown
#### Observation L22, the estimate the localization theorem needs, at $n=12,14,16$

> **THIS BLOCK CARRIES THE LABEL Observation, AND THE RECORD'S RULE FOR THAT LABEL IS LITERAL.** *The record's rule is literal, `Lemma` asserts Gate 2 passed, `Observation` asserts numerical verification at the dimensions named, and this one's four vanishings are measured at $n=12,14,16$. **That is true of [Observation L102](../findings/route-a.md#observation-l102-m_w_1cdotpi_kerqw_10-residual-le85times10-15-at-n121416-load-bearing-for-observation-l22) alone**; the other three were measured elsewhere and at other dimensions (a prior audit)).* **The displayed algebra is exact and stands**; $\alpha^*=32/141$ and the tangential meeting of $V(t)$'s branches at $t^*=\sqrt{30}/8$ were re-derived at audit. **What overreached was the label and the range.** *Its load-bearing input is [Observation L102](../findings/route-a.md#observation-l102-m_w_1cdotpi_kerqw_10-residual-le85times10-15-at-n121416-load-bearing-for-observation-l22), which asserts numerical verification at $n=12,14,16$ and nothing more.* **A result inherits the status of its weakest input**, so this is an Observation at those dimensions rather than a Lemma for every $n\ge12$. **Further, both branches take the sphere-product value as their constant**, which makes the estimate conditional on Conjecture A at critical points past $n=12$ (*circular against the goal this programme is for*) and the overlap claim rests on an $n\to\infty$ limit with margin $+0.0074$ and no monotonicity proof (a prior audit).

*Moved here from [results.md](../results.md) on 2026-08-31, where the argument was the only copy. That file now carries the statement and points here.*

Nienhaus's localization theorem holds for $10\le n\le11$, and what stops it above $11$ is a single estimate inside his Theorem 4.17. He sets out the route to it and writes that he could not complete it.

Write $\theta^*=\sqrt{3/2}$, $F_u$ for the linearisation of $Q$ at the competitor, $\alpha=\sqrt{2/3}\langle F_uW,W\rangle$ and $\gamma=\sqrt{2/3}P(W)$. Since $f'(\varphi)=3\sin\varphi\cdot\tilde f(\varphi)$ with $\tilde f(\pi/6)=(5\alpha+\sqrt3\gamma-3)/4$, the estimate required is exactly

$$\gamma_{\max}(\alpha)<\frac{3-5\alpha}{\sqrt3}\qquad\text{for every }\alpha<\tfrac13 .$$

At $\alpha=1/3$ the right side is $4/(3\sqrt3)$, which is what his own bound returns, borderline by construction, so the larger constant forced above $n=11$ breaks it, and only near $\alpha=1/3$.

**The configuration is forced.** Writing $W=\cos\beta\,W_1+\sin\beta\,W_2$ with $W_1$ in the $\tfrac13\theta^*$-eigenspace and $W_2$ in the non-positive part, the maximiser has $W_2$ lying **entirely in $\ker F_u$**, with $s^2=3\varepsilon$ an equality, $s=\sin\beta$ and $\varepsilon=\tfrac13-\alpha$. So the two couplings $A=T(W_1,W_1,K)$ and $B=T(W_1,K,K)$ are evaluated at one and the same pair, and bounding them by separate suprema (the natural route), pays for both at once.

**The frontier is exact, not estimated.** For every $W_1$ in the eigenspace, $M_{W_1}\cdot\Pi_{\ker}Q(W_1)=0$, which makes the inner maximisation over $K$ a *hard-case* trust-region problem and so globally solvable. Its value is monotone in both constants and both suprema are attained at the same $W_1$, giving, with $t=s/\cos\beta$,

$$V(t)=\begin{cases}\sqrt{5/6}, & t\le t^*\\[2pt] \dfrac{5}{16t}+\dfrac{2t}{3}, & t>t^*\end{cases}\qquad t^*=\tfrac34\sqrt{\tfrac56}=\tfrac{\sqrt{30}}8 .$$

Since $t$ and $s^2=3\varepsilon$ together fix $\alpha$, this reads: $B=0$ exactly for $\alpha\ge\alpha^*=32/141$, with $A$ pinned at $\sqrt{5/6}$.

**The two branches cover complementary intervals.** Nienhaus's own bound is sharp for small $\alpha$ and degenerates at $\tfrac13$; this one vanishes at $\tfrac13$ and stops at $\alpha^*$. His reaches $\alpha\le0.3223$ at $n=12$ and $0.2350$ at $n=100$, falling with $n$; this one covers $\alpha\ge0.2270$ at every $n$. They overlap for **every $n\ge12$**, with worst margin $+0.0074$ at $\alpha\approx0.223$ in the limit. $\square$ *The two figures do not sit together as printed: this branch is given as covering $\alpha\ge0.2270=\alpha^*$, and $0.223<32/141$ by about $0.0040$, the same order as the quoted margin, so not a rounding artefact. Either the margin is between quantities other than the two coverage endpoints, or one figure is off; the arithmetic settles only that they are inconsistent as written.* **And the tangential meeting has a reason**: the constant branch is the minimum of the other, since $a/t+bt$ with $a=\tfrac5{16}$, $b=\tfrac23$ minimises at $t^2=a/b=\tfrac{15}{32}=(\sqrt{30}/8)^2$ with minimum value squared $4ab=\tfrac56$, so $V=\min$ of the two and a minimum has zero slope. *Checked in [L22.lean](../lean/HamiltonsCubic/Results/L22.lean).*

**Scope.** Both branches use the sphere-product value as their constant, so the estimate is conditional on the conjecture at critical points past $n=12$. The vanishing $M_{W_1}\Pi_{\ker}Q(W_1)=0$ is verified at $n=12,14,16$ rather than proven; dimensions $20$ and $24$ are checked by zero-padding, which gives monotonicity in $n$ as a lower bound.

**Where a large-$n$ test belongs.** The ratio of 

*The display above is the same identity derived in context earlier in this file; it is repeated here so the block stands alone, and any correction must touch both.*
the true value to the requirement peaks near $\alpha=0.23$ and grows with the constant, so it is there rather than near $\alpha=0.295$ that the estimate is tightest.

```
