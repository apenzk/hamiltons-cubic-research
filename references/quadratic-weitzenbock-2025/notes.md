# Wang–Yang, *Weitzenböck–Bochner–Kodaira formulas with quadratic curvature terms* (arXiv:2509.00468, 30 Aug 2025)

Stored 2026-08-23. [paper.pdf](https://arxiv.org/abs/2509.00468), [paper.txt](https://arxiv.org/abs/2509.00468) (`pdftotext -layout`, 8 pages).

## What it is

Rewrites the Weitzenböck curvature term as a quadratic form in the curvature operator on $\Lambda^2$, evaluated on a bivector-valued companion of the form. Mostly Kähler; **Theorem 1.8 = Theorem 6.1 is the Riemannian one and is the only part that touches this project.**

## Theorem 6.1, verbatim

For $\omega\in\Omega^p(M)$ define $\mathbb T_\omega:\Gamma(T^*M)\times\Gamma(T^*M)\to\Omega^p(M)$ by

> $\mathbb T_\omega(\alpha,\beta)=\alpha\wedge I_{\beta^\sharp}\omega-\beta\wedge I_{\alpha^\sharp}\omega$  (6.1)

so $\mathbb T_\omega\in\Gamma(M,\Lambda^2TM\otimes\Lambda^pT^*M)$ (6.2). Then

> $\langle\Delta_d\omega,\omega\rangle=\langle D^*D\omega,\omega\rangle+\big\langle(\mathfrak R\otimes\mathrm{Id}_{\Lambda^pT^*M})(\mathbb T_\omega),\mathbb T_\omega\big\rangle$  (6.3)

with $D$ the induced connection on $\Lambda^pT^*M$ and $\mathfrak R$ the curvature operator on 2-forms.

## The pointwise algebraic content

At a point, in an orthonormal frame, (6.9) and the display after it give the identity this project can use:

$$\langle\Theta_p\omega,\omega\rangle=\sum_{i,j,k,\ell}R_{ij\ell k}\,\big\langle dx^i\wedge I_j\omega,\;dx^k\wedge I_\ell\omega\big\rangle .$$

The Weitzenböck term on $p$-forms is the curvature operator itself, paired against $\mathbb T_\omega$. Positivity of $\mathfrak R$ therefore transfers to $\Theta_p$ for every $p$ at once.

> Theorem 6.2. For any $\omega\in\Omega^k(M)$, $|\mathbb T_\omega|^2\le2\min\{k,n-k\}|\omega|^2$  (6.10)

## Attribution, and what it is worth here

**Theorem 6.2 is established in [PW21a]**, i.e. Petersen–Wink, and the authors say so; the reformulation (6.3) is the same algebraic move as Petersen–Wink's, extended to the Kähler and bundle-valued settings. So for this project the Riemannian half is **not new literature**, it is a second, cleaner exposition of [petersen-wink-2019-bochner-technique](../petersen-wink-2019-bochner-technique/notes.md).

**Where it still helps.** It states the identity for every degree $p$ simultaneously and pointwise-algebraically, which is the form in which a Weyl tensor can be fed to it. It supplies no bound on $\theta$ by itself: for a Ricci-flat $W$, $\Theta_2=-2\mathring W$ rather than $0$, so no free constraint drops out.
