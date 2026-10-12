# Notes, Queffélec and Zarouf, On Bernstein's inequality for polynomials

**Read at the abstract and section 1.1, lines 20 to 112 of the extraction.** *Only the classical statement is used on this record.*

## The abstract's statement

*"Bernstein's classical inequality asserts that given a trigonometric polynomial $T$ of degree $n\ge1$, the sup-norm of the derivative of $T$ does not exceed $n$ times the sup-norm of $T$."* (txt line 26)

## Theorem 1.1, as the survey quotes it (section 1.1, txt line 93)

> **Theorem 1.1.** Let $T(x)=\sum_{k=-n}^{n}a_ke^{ikx}$ be a trigonometric polynomial of degree $\le n$. Then $$\sup_{x\in\mathbb R}\lvert T'(x)\rvert\le n\sup_{x\in\mathbb R}\lvert T(x)\rvert,$$ and the constant $n$ is optimal in general ($T(x)=e^{inx}$).

*Introduced there as the form in which "Bernstein's inequality is generally quoted", with Bernstein's original cited as the survey's reference [4].*

## How [Lemma L216](../../findings/second-order.md) uses it

**Real trigonometric polynomials are the case with $a_{-k}=\overline{a_k}$**, so the theorem covers them. *The function $\phi(\sigma)=P(\cos\sigma\,W_1+\sin\sigma\,H)$ is a homogeneous cubic in $(\cos\sigma,\sin\sigma)$, which expands into frequencies $\pm1$ and $\pm3$, so it has degree at most $3$.*

**The third-derivative bound is the theorem applied three times.** *$T'$ has the same frequencies as $T$, hence degree at most $n$ again, so $\lVert T'''\rVert_\infty\le n\lVert T''\rVert_\infty\le n^2\lVert T'\rVert_\infty\le n^3\lVert T\rVert_\infty$, and at $n=3$ that is the factor $27$.* **This iteration is the record's one-line argument, not a statement of the survey.**

## Not transcribed

The survey's proofs of Theorem 1.1, the $L^p$ extensions for $p\ge0$, the interpolation and Riesz-formula approaches, and the algebraic-polynomial inequalities on the disc. *None enters L216.*
