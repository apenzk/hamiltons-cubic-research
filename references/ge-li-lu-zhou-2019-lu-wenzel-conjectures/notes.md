# Transcription notes

Read on 2026-09-23: the introduction's conjecture statements (pp. 2–4). Proofs of the special cases were not transcribed.

## Conventions

$\lVert X\rVert^2=\mathop{\mathrm{tr}}XX^*$, the Frobenius norm, twice the record's bivector norm on $\mathfrak{so}(n)$.

## Statements

> **Conjecture 1.** Let $B_1,\dots,B_m\in M(n,\mathbb R)$ satisfy $\mathop{\mathrm{tr}}\big(B_\alpha[B_\gamma,B_\beta]\big)=0$ for all $\alpha,\beta,\gamma$. Then $\sum_{\alpha,\beta}\lVert[B_\alpha,B_\beta]\rVert^2\le\big(\sum_\alpha\lVert B_\alpha\rVert^2\big)^2$.

> **Conjecture 2.** (LW Conjecture) Let $B,B_2,\dots,B_m\in M(n,\mathbb R)$ with (i) $\mathop{\mathrm{tr}}(B_\alpha B_\beta^*)=0$ for $\alpha\ne\beta$ and (ii) $\mathop{\mathrm{tr}}(B_\alpha[B,B_\beta])=0$ for $2\le\alpha,\beta\le m$. Then $\sum_{\alpha\ge2}\lVert[B,B_\alpha]\rVert^2\le\big(\max_\alpha\lVert B_\alpha\rVert^2+\sum_\alpha\lVert B_\alpha\rVert^2\big)\lVert B\rVert^2$.

> **Conjecture 3.** For $\lVert X\rVert=1$ and $T_X(Y)=[X^*,[X,Y]]$ with eigenvalues $\lambda_1\ge\lambda_2\ge\cdots$, $\lambda_1(T_X)+\lambda_3(T_X)\le3$.

> **Conjecture 4.** For $\lVert X\rVert=1$, $\sum_{i=1}^{2k}\lambda_i(T_X)\le2k+2$ for $k=1,\dots,[n^2/2]$.

> **Conjecture 5.** For $\lVert X\rVert=1$, the spectrum of $T_X$ is weakly majorised by $\{2^2,1^{2n-4},0^{(n-1)^2+1}\}$.

> **Conjecture 6.** Conjecture 2 without hypothesis (ii).

The paper proves Conjecture 2 in special cases, shows Conjectures 2, 4, 5, 6 equivalent, and bounds Conjecture 3's left side by $2+\sqrt{10}/2$ (abstract).

## What it cites

Böttcher–Wenzel, the DDVV proofs of Lu and Ge–Tang, and Ge's skew-symmetric DDVV ([ge-2014-ddvv-skew-symmetric](../ge-2014-ddvv-skew-symmetric/README.md)).
