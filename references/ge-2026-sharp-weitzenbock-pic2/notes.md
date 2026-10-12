# Ge, *Sharp Weitzenböck and PIC2 Estimates from Sectional-Scalar Curvature Pinching* (arXiv:2607.18216, 20 Jul 2026)

Stored 2026-08-24. [paper.pdf](https://arxiv.org/abs/2607.18216), [paper.txt](https://arxiv.org/abs/2607.18216) (`pdftotext -layout`).

## The identification that makes this relevant, verified

> **Definition 2.2.** For an algebraic curvature tensor $E$, define its Weitzenböck curvature endomorphism acting on two-forms by $q_2(E):=\mathrm{Ric}(E)^\sharp{}^{[2]}-2R_E$, i.e. $(q_2(E)\omega)_{ij}=\mathrm{Ric}_{ki}\omega_{kj}+\mathrm{Ric}_{kj}\omega_{ik}-2E_{ikjl}\omega_{kl}$.

Weyl tensors are Ricci-flat, so the first term dies and **$q_2(W)=-2W$ exactly**, screened at residual $10^{-16}$ at $S^3\times S^3$, $\mathbb{CP}^3$, $\mathbb{CP}^4$. Hence

$$\lambda_{\min}(W)=-\tfrac12\lambda_{\max}\big(q_2(W)\big),\qquad \lambda_{\max}(W)=-\tfrac12\lambda_{\min}\big(q_2(W)\big).$$

**Every sharp pointwise bound on the spectrum of $q_2$ in this literature is therefore a bound on the spectrum of $W$**, which is exactly the ingredient [b_lambda_weighted_bound.py](../../scripts/b_lambda_weighted_bound.py) is missing.

## The main estimate, and why its hypothesis is vacuous here

> We prove the sharp pointwise estimate $q_2(E)\ge-\dfrac{2(\ell-1)}{3\ell}\,\mathrm{Scal}$ for every algebraic curvature tensor $E$ on $V$ with nonnegative sectional curvature, $n\ge4$, $\ell=\lfloor n/2\rfloor$.

**Inapplicable to $\mathrm{Weyl}_n$ as stated.** Scalar curvature vanishes there, so the estimate reads $q_2(W)\ge0$, i.e. $W\preceq0$, and a tensor with nonnegative sectional curvature and zero scalar curvature is flat. The hypothesis and the conclusion are both empty on our objects. *Recorded so a later cycle does not try to apply it directly.*

> **Theorem 1.5 (Sharp criterion for PIC2).** With $K_{\min}(R)=\min_{\sigma\in\mathrm{Gr}_2(V)}K_R(\sigma)$ and $S_0(R)=\mathrm{Scal}(R)/(n(n-1))$: if $K_{\min}(R)\ge\frac{n(n-1)}{n^2-n+12}S_0(R)$ then $R$ lies in the PIC2 cone, strictly if the inequality is strict. **The coefficient is sharp among pointwise algebraic criteria of this form**: for every $\gamma<\frac{n(n-1)}{n^2-n+12}$ there is an algebraic curvature tensor with $K_{\min}>\gamma S_0$ that does not even have nonnegative isotropic curvature.

## What is actually transferable

The **homogeneous four-frame estimate** the paper builds its sharpness on. It is a pointwise algebraic technique for bounding $q_2$'s spectrum over the Grassmannian of 2-planes, and the equality case is $\mathbb{CP}^\ell$ with Fubini–Study, a point already central to this project ($\mathbb{CP}^m$ sits on the $\Delta=0$ list and $W_{\mathbb{CP}^2}$ sets the $\sqrt{3/2}$ threshold). **That coincidence of extremisers is the reason to read the proof rather than the theorem.**

*Owed:* extract the four-frame estimate and ask what it gives on a scalar-flat, Ricci-flat tensor with no sign hypothesis on sectional curvature, the class $\mathrm{Weyl}_n$ actually inhabits.
