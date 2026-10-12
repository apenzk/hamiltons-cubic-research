# Brief, round L91

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict is included.**

## Passage A, the heading and the argument ([findings/sym3-blocks.md](../findings/sym3-blocks.md) line 175, and lines 189-195)

#### Lemma L91, the identity Gram on $K$ gives the unconditional lower bound $1$

- **Lower bound $1$, unconditionally.** The identity Gram on $K$ is one of the $36$ invariant forms and maps to $\Delta=\sum_a q_a^2$ over an apolar-orthonormal basis of $K$, a sum of squares of cubics of $K$, psd, vanishing on the orbit, and nonzero ($\Delta/\lVert W\rVert^6\approx0.5$ at random points). *This replaces an earlier "$F_5$ lies in the image", which assumed what the route exists to establish.*
- **$36-\mathrm{rank}$ is the dimension of the solution set only when the system is consistent**, and consistency is exactly the open necessary condition: $F_5$ must lie in the image, or the route dies.
- **Tightness is open, reduced to one question:** $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$, a space containing $\mathcal A(W_0^6)$, with a dimension count putting every other intersection at $14+29-65<0$. So $13$ holds unless a second coincidence occurs.

**$\Delta$ is a live lead for the search.** It is psd, invariant, a sum of squares of cubics of $K$ by construction, and appears to vanish exactly on the orbit cone, the zero set $F_5$ is conjectured to have. $F_5$ is **not** proportional to it: $F_5/\Delta$ ranges over $[2.50,3.15]$ across twelve random unit points, staying bounded and positive, which makes $F_5-\lambda\Delta$ with $\lambda\approx2.5$ the natural recentring for a search over the $36$.

**Two of the three Casimir collisions vanish with them.** At $c=60$ both $(5,4)$ and $(6,2)$ die; at $c=40$ the block $(5,0)$ dies and leaves $(4,3)$ alone. **Only $c=30$ survives, the pair $(4,1)$ and $(3,3)$, both with odd second label.**

## Passage B, Lemma L90, a given ([findings/sym3-blocks.md](../findings/sym3-blocks.md) line 153)

**Statement, conditional on one measured rank.** Let $K$ be the cubics with $\sigma_\lambda(W_0)=0$, $\mu_K$ the map from invariant Grams on $K$ to sextics, and $\mathrm{ev}$ evaluation at a finite point set $S$. Then $\ker(\mathrm{ev}\circ\mu_K)\supseteq\ker\mu_K$, so $\mathrm{rank}(\mathrm{ev}\circ\mu_K)=\mathrm{rank}\,\mu_K$ makes $\mathrm{ev}$ injective on $\operatorname{im}\mu_K$, and a sextic in the image agreeing with $F_5$ on $S$ is then $F_5$. **The cap $\mathrm{rank}\,\mu_K\le13$ is proved**: a product of two cubics of $K$ vanishes at $W_0$, and evaluation at $W_0$ is a nonzero functional on the invariant sextics. **The lower bound $\mathrm{rank}(\mathrm{ev}\circ\mu_K)\ge13$ at the certificate's $40$ points is a rank computed modulo a prime**, and reading it as the rational rank needs three hypotheses on file nowhere: that the restricted space modulo $p$ is the reduction of the rational one, that every denominator is invertible modulo $p$, and that the sampled points are the certificate's. Granting it, $13\le\mathrm{rank}(\mathrm{ev}\circ\mu_K)\le\mathrm{rank}\,\mu_K\le13$, both ranks equal $13$, and the conclusion holds.

## Definitions and sources

- $\mathcal W_5$ is the space of algebraic Weyl tensors on $\mathbb R^5$ with $O(5)$ acting, $W_0$ the padded Weyl tensor of $\mathbb{CP}^2$, $K$ the cubics with $\sigma_\lambda(W_0)=0$, the $36$ the invariant symmetric forms on $K$, the $14$ the invariant sextics. $\mathrm{Cat}_F$ is the catalecticant of a sextic $F$ and $\mathcal A$ the apolar map, as the passages use them.
- **This loop does no numerical work**; a statement supported only by a script, a run or a measurement is HYPOTHESIS-DEBT.
- The lemma has **no entry in [results.md](../results.md)** and no Lean file.

## What to attack, beyond the standing list

1. **What the lemma bounds**: the heading's "the unconditional lower bound $1$" and the first bullet, against the quantity named in Passage B. Name the rank being bounded.
2. **"Lower bound $1$, unconditionally"**: whether the identity Gram argument proves $\mathrm{rank}\ge1$, what "nonzero ($\Delta/\lVert W\rVert^6\approx0.5$ at random points)" contributes, and whether a two-line argument for nonvanishing exists without sampling.
3. **"$36-\mathrm{rank}$ is the dimension of the solution set only when the system is consistent"**: linear against affine against the positive semidefinite set.
4. **"Tightness is open, reduced to one question: $\mathrm{rank}=14-\dim\{F:\mathrm{Cat}_F(K,K)=0\}$"**, which sextics $F$ range over, and the dimension count $14+29-65<0$.
5. **The three bullets against Passage B**, which gives the rank as $13$ given one measurement.
6. **"$\Delta$ is a live lead ... appears to vanish exactly on the orbit cone ... $F_5/\Delta$ ranges over $[2.50,3.15]$"**: which of these are argued.
7. **"Two of the three Casimir collisions vanish with them"** and the surviving pair.
8. **Scope**: whether the lemma adds anything to Passage B.
