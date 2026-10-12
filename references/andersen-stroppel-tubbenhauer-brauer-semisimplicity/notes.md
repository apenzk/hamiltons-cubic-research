# The semisimplicity criterion for the Brauer algebra

**Theorem 7.1 verbatim**, from [aswt-1507.07676.pdf](https://doi.org/10.1016/j.jcta.2004.11.009) p. 27, extraction line 1367, *"$B_d(\delta)$ is semisimple if and only if one of the following conditions hold"*, of which the two this programme uses are:

> **(3)** $\delta_0\ne0$, $\operatorname{char}(K)=0$ and $d\le\delta_0+1$.
> **(5)** $\delta_0=0$, $\operatorname{char}(K)=0$ and $d\in\{1,3,5\}$.

Clause (3) with $\delta_0=n$ and $d=f$ is the inequality $f\le n+1$, i.e. $n\ge f-1$. Clause (5) is why the *iff* fails at $\delta=0$.

**The folder was named for Rui until 2026-09-02**, whose paper states the same criterion and is paywalled with no preprint, no arXiv version, Elsevier 403, Unpaywall `oa_status: closed`. **Nothing here ever rested on Rui's text**: the criterion, both corrections and the independent reproduction all come from the source above or from this record's own work. The folder now carries the paper it actually rests on.


**H. Rui, *A criterion on the semisimple Brauer algebras*, J. Combin. Theory Ser. A 111 (2005) 78–88**, [ScienceDirect](https://www.sciencedirect.com/science/article/pii/S0097316505001858), and the sequel **Rui–Si, *A criterion on the semisimple Brauer algebras II*, JCTA 113 (2006)**, [ScienceDirect](https://www.sciencedirect.com/science/article/pii/S0097316505001858). Building on **Wenzl, *On the structure of Brauer's centralizer algebras*, Ann. of Math. 128 (1988)**.

## The criterion, in the form this programme uses

For the Brauer algebra $B_f(\delta)$ over a field $k$ with $\delta = n$ a positive integer:

> $B_f(n)$ is **semisimple** $\iff$ $n \ge f-1$, for $\delta = n$ a **positive** integer and $\operatorname{char} k = 0$ or $\operatorname{char} k > f$.

Over $\mathbb{Q}$ the characteristic clause is automatic, so the criterion is the single inequality $n \ge f-1$.

**PRIMARY SOURCE, and the paper this folder holds.** Found by r259, open access: Andersen–Stroppel–Tubbenhauer, [*Semisimplicity of Hecke and (walled) Brauer algebras*](https://arxiv.org/abs/1507.07676), **Theorem 7.1(3)**: for $\operatorname{char}K=0$ and $\delta_0=|\delta|\ne0$, $B_d(\delta)$ is semisimple iff $d\le\delta_0+1$, which is $n\ge f-1$ verbatim.

**Two corrections to what this note first said**, both found by r259 and r260:

- **$\delta=-2n$ obeys a different bound.** The claim *"same statement holds for $\delta=-2n$"* was false; there the criterion reads $f\le 2n+1$.
- **The *iff* fails at $\delta=0$.** ASWT Theorem 7.1(5): for $\delta_0=0$ in characteristic zero, $B_d(0)$ is semisimple exactly for $d\in\{1,3,5\}$. Both reviewers rediscovered this independently, $B_3(0)$ and $B_5(0)$ are semisimple although $0\ge d-1$ fails.

**Independently reproduced, without the paywalled text.** Dickson's criterion (characteristic zero: semisimple iff the regular trace form is nondegenerate), applied to diagram multiplication built from scratch, agrees in **both** directions at all $32$ pairs with $f\le5$, $n\ge1$, boundaries $(4,3)$ and $(5,4)$ nondegenerate, $(5,3)$ degenerate at rank $706$ of $945$.

## Applied here

The degree-3 covariants are functionals on $V^{\otimes 12}$, three Weyl tensors, four legs each. The relevant algebra acting on the leg set is $B_{12}(n)$, so $f = 12$ and the criterion reads $n \ge 11$.

At $n = 12$: $12 \ge 11$ holds, with **one dimension of margin**. $B_{12}(12)$ is semisimple over $\mathbb{Q}$.

This is a *different* threshold from [Lehrer–Zhang Theorem 3.4](../lehrer-zhang-sft-orthogonal/notes.md), and the two govern different objects, so **neither ranking nor a shared "slack" scale is meaningful**. Applied to $B_{12}(n)$ (the algebra the diagram-realisation theorem uses), Lehrer–Zhang gives injectivity of $\nu$ only for $n\ge12$, zero slack at $n=12$. **Both are decoration**: the theorem needs neither, since it uses only that $M_\lambda$ is irreducible over the *image*.

## What it buys

**Less than this note first claimed.** The diagram-realisation theorem needs $M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$ irreducible over the **image** $\nu(B_{12}(n))$, and the double centraliser gives that at **every** $n$ with no inequality, see [brauer-pairing.md](../../findings/brauer-pairing.md).

What Rui's criterion adds is the identification of $M_\lambda$ with the **abstract** cell module $\Delta_\lambda$, which the theorem does not use and only the verification's $\sum(\dim\Delta_\lambda)^2$ form relies on.
