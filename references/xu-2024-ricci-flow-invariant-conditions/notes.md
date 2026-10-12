# Xu 2024, what the paper contains

Transcribed 2026-08-26. The record cited this paper for its $n\ge11$ polynomial obstruction but had never transcribed it; the two things that matter are that it **states this project's conjecture verbatim** and that it **quantifies how much of it is open**.

## The conjecture, restated (Conjecture 1, citing Beitz §6.3.2)

$$\Omega(a)=\Big\{R\in S^2_B(\mathfrak{so}(n))\ \Big|\ \Big(\tfrac{n-2}4+a\Big)\lVert R\rVert^2\le\lVert\mathrm{Ric}\rVert^2,\ \mathrm{scal}>0\Big\},\qquad n\ge12,\ a\in[0,\tfrac n4],$$

invariant under the Hamilton ODE. Equation (1.2) gives the decomposition form, $a\lVert R_{\mathrm{Ric}_0}\rVert^2+\frac{n-2+4a}4\lVert W\rVert^2\le\frac{n-4a}4\lVert R_I\rVert^2$, and the paper states outright: **"for $a>n/4$ the sets $\Omega(a)$ are empty. For $a=n/4$, $\Omega(n/4)=\mathbb R^+I$."** That is independent published confirmation of the endpoint analysis in [findings/problem.md](../../findings/problem.md), which was derived here from Beitz's display before this paper was read.

## How much is proved (Theorem 1.1)

$$\epsilon_n=\tfrac1n\ (n\ge11),\qquad\text{invariance holds for }a\in[\tfrac n4-\epsilon_n,\tfrac n4].$$

Xu's contribution over Beitz is **quantitative**: Beitz gives an unspecified $\epsilon$, Xu an explicit one, via Huisken's estimate rather than a second-derivative test. The proved fraction of the parameter interval $[0,\frac n4]$ is $\frac{4}{n^2}$:

| $n$ | proved range | fraction proved | open |
|---|---|---|---|
| 11 | $[2.6591,\ 2.75]$ | $3.31\%$ | $96.69\%$ |
| **12** | $[2.9167,\ 3.00]$ | $\mathbf{2.78\%}$ | $\mathbf{97.22\%}$ |
| 16 | $[3.9375,\ 4.00]$ | $1.56\%$ | $98.44\%$ |
| 30 | $[7.4667,\ 7.50]$ | $0.44\%$ | $99.56\%$ |

**Both published attacks sit at the degenerate end**, shrinking as $n$ grows. This project's target, $a=0$, is the far end of the interval, and the whole interior is untouched.

## Proposition 2.7, the block structure of $Q$, and it settles an assumption made here

> (1) $R,S\in\langle I\rangle\Rightarrow Q(R,S)\in\langle I\rangle$; (2) $R\in\langle I\rangle,S\in\langle\mathrm{Ric}_0\rangle\Rightarrow Q(R,S)\in\langle\mathrm{Ric}_0\rangle$; (3) $R\in\langle I\rangle,S\in\langle W\rangle\Rightarrow Q(R,S)=0$; (4) $R,S\in\langle W\rangle\Rightarrow Q(R,S)\in\langle W\rangle$; (5) $R\in\langle\mathrm{Ric}_0\rangle,S\in\langle W\rangle\Rightarrow Q(R,S)\in\langle\mathrm{Ric}_0\rangle$.

Items (3) and (4) are exactly the two facts the $\theta_0$ derivation in [findings/problem.md](../../findings/problem.md) took from BW08 Lemma 2.1 and eq. (6), **published here as a single proposition**, so that derivation rests on cited results rather than on a re-derivation. Its proof also uses **the symmetric property of the trilinear map $\mathrm{tri}$** explicitly ($\langle Q(R,S),T\rangle=\frac12\mathrm{tri}(R,S,T)=\langle Q(S,T),R\rangle$), which is the symmetry that derivation assumed without proof. It is standard.

**Item (5) is the tool for going off the slice.** The $\langle\mathrm{Ric}_0\rangle$–$\langle W\rangle$ cross term lands in $\langle\mathrm{Ric}_0\rangle$, so it feeds the Ricci side of the invariance criterion and contributes nothing to the Weyl block, which is what a general-$R_{\mathrm{ric}_0}$ version of the collapse needs.

## Also in the paper

Theorem 1.2 ($n\ge4$, a compact pinching result), Theorem 1.3 (a Kähler analogue, complex dimension $m\ge2$), Lemma 2.8 (Huisken's identity, reproduced because it is not an independent lemma in [16]), Corollary 2.11 ($\Omega(a)$ for $a$ near $n/4$ lies inside the positive-Ricci cone), and the observation that $\Omega(a)_{a\in[n/4-\epsilon_n,n/4)}$ is a pinching family, giving a differentiable sphere theorem.
