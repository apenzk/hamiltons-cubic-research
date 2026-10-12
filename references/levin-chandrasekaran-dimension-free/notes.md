# Levin & Chandrasekaran, *Dimension-Free Descriptions of Convex Sets*

arXiv:2307.04230v3 (23 Oct 2025), 56 pages. Stored as [paper.pdf](https://arxiv.org/abs/2307.04230).

## Why it is here

The programme's open crux after the stability theorem: **a certificate at $n=12$ settles Conjecture A at $n=12$, and nothing carries it upward.** This paper is about exactly that gap, its stated contributions include *"extendability of a single set in a given dimension to a freely-described sequence"*.

## What it does

Convex sets that make sense in every dimension (the simplex, the spectraplex, the elliptope, unit balls of Schatten norms), often admit **conic descriptions instantiable in any dimension**. The paper shows such *dimension-free descriptions* arise from **representation stability**, the same phenomenon that makes our block table constant for $n\ge12$.

**The orthogonal group is one of its consistent sequences**, listed as $O_n=\{g\in\mathbb R^{n\times n}:g^\top g=I_n\}$, so the framework covers our setting rather than only $S_n$.

## Theorem 3.5, the one that matters

*Parametrizing freely-described and compatible sequences.* Given a consistent sequence $\mathcal V_0$ of $\{G_n\}$-representations and $\mathcal V_0$-modules $V,W,U$ generated in degrees $d_V,d_U,d_W$ and **presented in degree $k$**, and a sequence of cones $\{K_n\subseteq U_n\}$ that is intersection- and projection-compatible:

Fix $n_0\ge k$. Given $u_{n_0}\in U_{n_0}^{G_{n_0}}$ and equivariant $A_{n_0},B_{n_0}$ satisfying

$$A_{n_0}(V_j)\subseteq U_j \ (j\le d_V),\qquad B_{n_0}(W_j)\subseteq U_j \ (j\le d_W),\qquad B_{n_0}(W_j^\perp)\subseteq U_j^\perp \ (j\le d_U),$$

**there are unique extensions to morphisms $\{A_n\},\{B_n\}$ for every $n$, and a unique extension of $u_{n_0}$ to a freely-described $\{u_n\}$.** Parts (a) and (b) then give compatibility of the resulting cone sequence from $u_{n+1}-u_n\in K_{n+1}$ (plus a $\perp$ condition for projection-compatibility).

**The hypotheses are finitely checkable at $n_0$ alone.** That is the whole point: conditions in one dimension, conclusions in all of them.

## What this would take here

| ingredient | ours |
|---|---|
| the group sequence | $O(n)$, listed in their table |
| $n_0$ | $12$, which must be $\ge$ the **presentation degree** $k$ |
| the cone $K_n$ | PSD cone on the block-diagonal Gram |
| $u_n$ | the target $F_{\mu,n}$ |

**The presentation degree is the quantity to determine, and it decides whether $n_0=12$ is admissible.** Appendix B, *Deriving the Presentation Degree from Extendability*, is where that is computed; Proposition B.1(b)'s condition (32) is said to fully characterise extendability.

**One hypothesis will not be free.** $u_n$ must be a *freely-described element*, and our target carries $\Theta_n=\sqrt{2(n-1)(n-2)}/n$, irrational and $n$-dependent. Whether $F_{\mu,n}$ is freely described in their sense, or must first be cleared of that square root, is the first thing to settle.

## Also seen, unread

The same search returned Blekherman–Riener, *Symmetric Non-Negative Forms and Sums of Squares*, where uniform representations of symmetric SOS cones are given as **matrix polynomials with coefficients rational in $n$**. That is the $S_n$ analogue of what would be wanted here, and is worth reading if Theorem 3.5's hypotheses fail.


## Read further: two limits, and a threshold that may not be $12$

**Their SOS corollary is for FINITE groups.** Theorem 1.11 (formally 5.1) (invariant sections of $\{\mathrm{Sym}^2_+(V_n)\}$ admit constant-sized descriptions), is stated for the **classical Weyl groups** $\{S_n\},\{B_n\},\{D_n\}$, not for $O(n)$. $O(n)$ appears in their Table 1 as a consistent sequence and the general Theorem 3.5 is stated for general $\{G_n\}$, so the machinery is not closed to us; but *the packaged SOS result is not ours to cite*, and the continuous case would have to be worked.

**The gate is $n\ge d+k$, not $n\ge k$.** Theorem 1.11 gives constant-sized descriptions for $n\ge d+k$, with $d$ the generation and $k$ the presentation degree, both boundable by the calculus of Theorem 2.11.

**And $d$ looks large here.** $\mathcal W_n$ is built from $\mathbb R^n$ as $\Lambda^2\to\mathrm{Sym}^2(\Lambda^2)\to$ Bianchi $\to$ traceless, so it is generated in degree about $4$; then $\mathrm{Sym}^3(\mathcal W_n)$ is generated in degree about $12$. With $k\ge d$, the gate $n\ge d+k$ lands near $\boxed{n\ge24}$ rather than $n\ge12$.

*This is an estimate from the construction, not a computation of $d$ and $k$, and getting the actual numbers is the next step.* If it holds, **a dimension-free certificate would have to be built at $n=24$, not $n=12$**, where the block table has the same $71/184/477$ shape by our own stability theorem, so the SDP is the same size and only the covariant construction grows.

## The other hypothesis, still open

$u_n$ must be a *freely-described element*, and the target carries $\Theta_n=\sqrt{2(n-1)(n-2)}/n$, irrational and $n$-dependent. Whether $F_{\mu,n}$ qualifies, or must first be cleared of that square root, is unsettled and is independent of the degree question.
