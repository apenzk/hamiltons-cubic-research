# Li, *New Sphere Theorems under Curvature Operator of the Second Kind*, transcription

Source: [li-2407.13847.pdf](https://arxiv.org/abs/2407.13847), arXiv:2407.13847. Transcribed for what the Conjecture A programme needs from it; line numbers refer to the `pdftotext -layout` dump.

## The operator

$\mathring R$ acts on **symmetric $2$-tensors**, and the paper works with its restriction to the trace-free ones, where it has

$$N=\frac{(n-1)(n+2)}{2}\quad\text{eigenvalues},\qquad \lambda_1\le\dots\le\lambda_N,$$

with $\bar\lambda$ their average (lines 14, 105, 152). This is the count the programme's block-(a) computation reproduces: at $n=8$ the padding-leaving block sits on $\mathbb R^{7}$ and has dimension $(7-1)(7+2)/2=27$.

## What the paper proves, and in which direction

It introduces a two-parameter family of **lower** bound conditions $\mathring R\in C(\alpha,\theta)$, read as: *the average of the smallest $\alpha$ eigenvalues of $\mathring R$ is bounded from below by $-\theta\bar\lambda$* (lines 137, 167–168). From these it derives sphere theorems, with products of spheres as the boundary models.

It also records that the average of the smallest three eigenvalues of $\mathring R$ is negative on **all** compact symmetric spaces (line 172), and collects the eigenvalues of $\mathring R$ on examples including $S^{n-1}\times S^1$ (Example 2.2, line 464) and Hermitian symmetric spaces of classical type (line 116).

## Verdict for this programme

> **The direction is wrong for what is needed.** The programme's item (iii) reduces to an **upper** bound, $\lambda_{\max}(\mathring R_e)\le1$ on trace-free symmetric $2$-tensors; this paper bounds the *smallest* eigenvalues from below. Its example computations remain useful as a source of exact spectra to check against, and its normalisation and eigenvalue count are the ones the programme uses.

## A cautionary record attached to this source

A search-summarisation layer once fabricated a "Conjecture A" reference in this paper; the phrase does not occur in the full text. That is the origin of the standing rule that search-tool prose is a lead to verify, never a citation.
