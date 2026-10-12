# Case–Tyrrell, transcription

Conventions: $\sigma_k(A)$ the $k$-th elementary symmetric function of the eigenvalues, $p_k(A)=\sigma_k(A)/\binom nk$, so $p_k(\lambda I)=\lambda^k$. $\mathring A$ is trace-free.

> **Lemma 2.1** (sharp Newton, cited to [6, Section 2]). Let $A\in\operatorname{End}(V^n)$ and $1\le k\le n-1$. Then $p_k(A)^2\ge p_{k-1}(A)p_{k+1}(A)$, with equality if and only if $A$ is proportional to the identity or $\dim\ker A\ge n-k+1$. (p. 3)

> **Proposition 2.2.** Let $\mathring A\in\operatorname{End}(V^n)$, $n\ge3$, with $p_1(\mathring A)=0$. Then $p_3(\mathring A)^2+4p_2(\mathring A)^3\le0$, with equality if and only if $\mathring A$ has an eigenspace of dimension at least $n-1$. (p. 3)

**Proof, the $\lambda$-method** (p. 3–4, transcribed because the record may reuse it). $p_k(A+\lambda I)=\sum_j\binom kj\lambda^jp_{k-j}(A)$. With $p_1=0$ and $p_2<0$, Lemma 2.1 at $k=2$ applied to $\mathring A+\lambda I$ gives $0\le(p_2+\lambda^2)^2-\lambda(p_3+3\lambda p_2+\lambda^3)=p_2^2-\lambda p_3-\lambda^2p_2$ for every real $\lambda$, equality iff an eigenspace of dimension $n-1$. Multiplying by $4p_2<0$: $0\ge-(2\lambda p_2+p_3)^2+4p_2^3+p_3^2$, and $\lambda=-p_3/2p_2$ gives the claim.

**In norms** (p. 1): $\operatorname{tr}\mathring A^3\le\frac{n-2}{\sqrt{n(n-1)}}\lvert\mathring A\rvert^3$, since $p_2=-\lvert\mathring A\rvert^2/(n(n-1))$ and $p_3=\operatorname{tr}\mathring A^3/\binom n3\cdot\tfrac13$... in the paper's words, "$(\operatorname{tr}\mathring A^3)^2\le\frac{(n-2)^2}{n(n-1)}\lvert\mathring A\rvert^6$".

> **Theorem 1.1.** Let $V$ be an $n$-dimensional inner product space, $n\ge4$, and $\mathring A\in\operatorname{End}(V)$ trace-free. Then $\lvert\mathring A^2\rvert^2\le\frac{n^2-3n+3}{n(n-1)}\lvert\mathring A\rvert^4$, with equality if and only if $\mathring A$ has an eigenspace of dimension at least $n-1$. (p. 1)

**What the record takes.** At $n=3$ the cubic bound reads $\operatorname{tr}(M^0)^3=3\det M^0\le\tfrac1{\sqrt6}\lvert M^0\rvert^3$, equality at $\operatorname{diag}(2,-1,-1)/\sqrt6$ in some frame. The constant $\frac{n^2-3n+3}{n(n-1)}$ of Theorem 1.1 is the same constant as in [L57](../../findings/problem.md)'s $\lvert Z(v)\rvert^2$ formula, $\frac{n^2-3n+3}{2(n-1)(n-2)}$ up to the shift $n\to n-1$ and a factor, which is not an accident: both come from the fourth moment of a two-value vector.
