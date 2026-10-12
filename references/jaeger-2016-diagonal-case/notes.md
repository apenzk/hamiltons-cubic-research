# Notes, Jäger, *An algebraic characterization of the Weyl curvature of $S^m\times S^m$*

Transcribed from [diss_jaeger_florian.txt](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) (`pdftotext -layout` of [diss_jaeger_florian.pdf](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf)). Line numbers refer to the extraction. Index card in [README.md](../INDEX.md).

PhD thesis, Münster 2016; advisor Christoph Böhm, second referee Burkhard Wilking; 99 pages; not on arXiv. Located by a citation chain through Kevin Poljsak's 2022 thesis, which cites it for the diagonal $\#$-formula.

## Theorem A (L113), the granted diagonal case

> "Let $n\ge16$ be an even integer, and let $W\in\langle W\rangle_d$ with $\|W\|=1$ be given such that $W^2+W^\#=\theta W$ for a $\theta\ge\theta_0(n)$. Then $\theta=\theta_0(n)$, and $W$ is the normalized Weyl curvature of $S^{n/2}\times S^{n/2}$."

with (L111, L1659)

$$\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}{n}.$$

Since $P(W)=\theta$ at a critical point and every maximizer is critical, **this is the diagonal-case maximization result**.

## Three ways it covers less than the problem statement assumes

1. **The threshold is $n\ge16$, not $n\ge12$.** The sentence immediately following Theorem A: *"The conjecture is that this is also true for all even integers $n\ge12$ and all operators $W\in\langle W\rangle$."* So $n=12$ and $n=14$ are open **even in the diagonal case**, exactly the dimensions where the conjecture first bites.
2. **Even $n$ only.** Odd $n$ is not addressed; the analogous $S^m\times S^{m+1}$ statement is left explicitly conjectural.
3. **The proof is long.** Roughly 50 pages (§§3.1–3.6), by contradiction, via a scalar-curvature gap phenomenon, chained $\operatorname{tr}\mathrm{Ric}^3/\operatorname{tr}\mathrm{Ric}^4$ estimates, and a closing appeal to the classification of compact symmetric spaces.

## The setup is this project's vertex matrix (L28 of FINDINGS)

> "Those operators $W\in\langle W\rangle_d$ can be expressed as symmetric $n\times n$-matrices $(w_{ij})$ with $0$ on the diagonal via $W(e_i\wedge e_j)=w_{ij}e_i\wedge e_j$ … The condition that $W$ is Weyl then reduces to $\sum_i w_{ij}=0$ for all $j$."

A hollow symmetric matrix with vanishing row sums, independently rediscovered here before the thesis was located.

## Where the dimension threshold actually comes from

**Two** dimension constraints carry Theorem A: the $n\ge15$ pair inside Lemma 3.5.6, and Assumption 1's $m\ge8$. *The "every constraint flows from one lemma" once written here is false.* The first needs a single quantity to be negative and bounds it through a chain of rational roundings. The accumulated slack costs four dimensions.

- Evaluating his own expression exactly, at his own case endpoints, already reaches $n=14$.
- $n=12$ needs one further observation: he bounds $\operatorname{tr}S^3$ and $\operatorname{tr}S^4$ separately, and the worst case puts one at its floor while the other sits at its ceiling, but they are moments of a single operator, and that corner does not exist. Replacing the box by the true moment body closes the gap.
- A census of every dimension hypothesis in Chapter 3 finds Assumption 1's $m\ge8$ binding as well, *the line once here, that nothing else binds above $n=12$, states the opposite of what the census found.*

**So $n\ge16$ is rounding slack rather than a real obstruction.** Both threshold dimensions are closed here with exact and validated interval arithmetic; the record is in [ATTEMPTS.md](../../ATTEMPTS.md).

## §§3.2–3.6, lifted off the diagonal locus

The chapters were lifted off the diagonal locus with the Bianchi defect entering at one priced point; §3.3.5 is proven unconditionally. Two grants remain open, $J_5\ge0$ off the commuting class, and an independent audit of the E-track certificate. Detail in [findings/INDEX.md](../../findings/INDEX.md).

## Reconciling with the problem statement

The problem statement describes the diagonal case as solved "kurz und elegant" by an AI, while noting a colleague's thesis "could only show it in high dimensions". Jäger's $n\ge16$ is plainly that thesis; the short proof is an AI-produced argument **not in the literature** and not available here. So the granted assumption is stronger than anything published, and the gap it papers over ($n=12,14$ and all odd $n$), sits exactly at the threshold under study.
