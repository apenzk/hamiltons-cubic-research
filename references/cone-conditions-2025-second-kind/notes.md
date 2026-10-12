# Notes, Cheng–Wang, arXiv:2508.11226

Conventions: $\mathring R$ the second-kind operator on $S^2_0$, $N=(n+2)(n-1)/2$, eigenvalues $\lambda_1\le\cdots\le\lambda_N$, $\bar\lambda=\sum\lambda_i/N$.

## Theorem 1.1 (p. 1, L99)

> Let $(M^n,g)$ be a closed Einstein manifold, $n=4,5$ or $n\ge8$. If $(\lambda_1+\lambda_2)/2\ge-\theta(n)\bar\lambda$ then $M$ is flat or a round sphere.

with (1.2): $\theta(4)=1/2$, $\theta(5)=2/3$, and for $n\ge8$
$$\theta(n)=\frac{2N-9n+6}{N+6n-3}.$$

Strictly weaker than two-nonnegativity ($\theta=0$). The proof establishes $\langle\Delta R,R\rangle\ge0$ and runs rigidity from there; sharpness of $\theta(n)$ is stated as open (L123).

## Lemma 3.1 (L299), closed forms on Einstein, quoted from [8, Lemma 3.1] = Cheng–Wang's earlier paper

$$|R|^2=|W|^2+2n(n-1)\bar\lambda^2,\qquad\sum_{j=1}^N\lambda_j^2=\tfrac34|R|^2-(n-1)^2\bar\lambda^2.$$

## Lemma 3.2 (L313), THE ENGINE

> $n\ge6$, $\lambda_1+\lambda_2\ge-2\theta\bar\lambda$, $\theta\ge0$. Then
> $$\sum_{j=1}^N\lambda_j|S^jW|^2\ \ge\ -\frac{16(N-3)}{3n}\,\theta\bar\lambda\sum_{j=1}^N\lambda_j^2+\frac{16N(N-3)}{3n}\,\theta\bar\lambda^3.$$

$S^jW$ is the action of the eigenbasis element $S^j\in S^2_0$ on $W$ as a derivation (Definition 2.1, L216). Proof mechanism (L330–): split off the two lowest eigenvalues against $\max_i|S^iW|$, use $\lambda_1+\lambda_2\ge-2\theta\bar\lambda$ on that pair, and bound $\sum_j|S^jW|^2$ by a multiple of $|W|^2$, a partial-sum-to-cubic transfer.

**Why it matters here**: branch 1 of the record's dichotomy is a statement of exactly this shape, the bottom of the second-kind spectrum controlling the cubic. This lemma is a worked example of such a transfer, with the weight $|S^jW|^2$ playing the role the record's $g_\gamma$ plays in Petersen–Wink.

## Citation graph

Builds on Li's cone condition [18]=Li25, Dai–Fu [DF24] (the record holds dai-fu-2023), Cao–Gursky–Tran [6], Nienhaus–Petersen–Wink [23].
