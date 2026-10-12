# Böhm–Wilking, *Manifolds with positive curvature operators are space forms*, transcription

Source: [boehm-wilking-math0606187.pdf](https://arxiv.org/abs/math/0606187), arXiv math/0606187. Transcribed for the definitions and structural facts the Conjecture A programme relies on; page/section numbers refer to the arXiv text dump.

## The curvature-operator setting

Under the Ricci flow (Hamilton), with $R_t:\Lambda^2T_pM\to\Lambda^2T_pM$ and $\Lambda^2T_pM$ identified with $\mathfrak{so}(T_pM)$,

$$\frac{\partial R}{\partial t}=\Delta R+2(R^2+R^\#),\qquad R^\#=\mathrm{ad}\circ(R\wedge R)\circ\mathrm{ad}^* .$$

**The round sphere of radius one has curvature operator the identity.** This fixes the normalisation used throughout.

$S^2_B(\mathfrak{so}(n))$ is defined as "the vectorspace of curvature operators, that is the vectorspace of selfadjoint endomorphisms of $\mathfrak{so}(n)$ satisfying the Bianchi identity."

**Hamilton's maximum principle** asserts that a closed convex $O(n)$-invariant subset $C\subseteq S^2_B(\mathfrak{so}(n))$ invariant under the ODE

$$\frac{dR}{dt}=R^2+R^\#$$

defines a Ricci-flow-invariant curvature condition.

> **What this does and does not say.** The ODE is stated on $S^2_B$, so $R\mapsto R^2+R^\#$ carries $S^2_B$ into itself: **the sum preserves the Bianchi identity.** The paper makes no such claim for $R^\#$ on its own, and it is false, see the Conjecture A record for the cancellation $b(R^\#)=-b(R^2)$, both sides nonzero at $\mathbb{CP}^3$ and $\mathbb{CP}^4$.

## The $\#$ operation (eq. 4, p. 3–4)

Hamilton's second natural $O(n)$-equivariant bilinear map $\#:S^2(\mathfrak{so}(n))\times S^2(\mathfrak{so}(n))\to S^2(\mathfrak{so}(n))$:

$$\langle(R\,\#\,S)(h),h\rangle=\frac12\sum_{\alpha,\beta=1}^{N}\big\langle[R(b_\alpha),S(b_\beta)],h\big\rangle\cdot\big\langle[b_\alpha,b_\beta],h\big\rangle$$

for $h\in\mathfrak{so}(n)$ and $b_1,\dots,b_N$ an orthonormal basis of $\mathfrak{so}(n)$.

**The factor $\tfrac12$ is a normalisation artefact**, stated explicitly: it "stems from the fact that we are using the scalar product $-\tfrac12\operatorname{tr}(AB)$ instead of $-\operatorname{tr}(AB)$ as in [H2]". Any comparison with Hamilton's constants must carry it.

Invariantly, $R\,\#\,S=S\,\#\,R=\mathrm{ad}\circ(R\wedge S)\circ\mathrm{ad}^*$ with $\mathrm{ad}:\Lambda^2\mathfrak{so}(n)\to\mathfrak{so}(n)$, $u\wedge v\mapsto[u,v]$. And $R^\#:=R\,\#\,R$.

## The trilinear form and the potential (eq. 5, p. 4)

$$\mathrm{tri}(R_1,R_2,R_3)=\operatorname{tr}\big((R_1R_2+R_2R_1+2\,R_1\,\#\,R_2)\cdot R_3\big),$$

**symmetric in all three arguments** (attributed to Huisken), because

$$\operatorname{tr}\big(2(R_1\,\#\,R_2)\cdot R_3\big)=\sum_{\alpha,\beta,\gamma=1}^{N}\big\langle[R_1(b_\alpha),R_2(b_\beta)],R_3(b_\gamma)\big\rangle\cdot\big\langle[b_\alpha,b_\beta],b_\gamma\big\rangle,$$

which is manifestly symmetric. Huisken also observed that the ODE is the **gradient flow** of

$$P(R)=\tfrac13\operatorname{tr}(R^3+R\,R^\#)=\tfrac16\,\mathrm{tri}(R,R,R).$$

> This is the programme's $P$ up to the factor $\tfrac13$, and it is the reason $\langle W,Q(W)\rangle$ is the right functional: it is the potential whose gradient flow is the ODE the maximum principle is stated for.

## Ricci of the reaction term (eq. 6)

With $e_1,\dots,e_n$ an orthonormal eigenbasis of $\mathrm{Ric}$,

$$\mathrm{Ric}(R^2+R^\#)_{ij}=\sum_k \mathrm{Ric}_{kk}R_{kijk}.$$

> **THIS IS BW'S OWN INDEX CONVENTION AND IS SIGN-FLIPPED AGAINST THE RECORD'S.** In [conventions.md](../../findings/conventions.md)'s $4$-tensor order, $\sum_kR_{kijk}=-\mathrm{Ric}_{ij}$, so the right side above carries a minus against the record's $\mathring{\ }$. *Anchor: at $R=\mathrm{Id}$ the left side is $(n-1)^2\mathrm{id}$ and the right side as written is $-(n-1)^2\mathrm{id}$.* **The record's form is $\mathrm{Ric}(R^2+R^\#)=\mathring R(\mathrm{Ric}\,R)+\tfrac32\mathcal A(R)$** ([ATTEMPTS.md](../../ATTEMPTS.md), Result 2 of the Jäger-lift section). *The [2026-09-03b sweep](../../reviews/2026-09-03b-LIT-step8-sweep.md) took the pattern from here without the flip and closed a route on the resulting sign; see [DERIVE-j5](../../reviews/DERIVE-j5.md) batch 4, [r703](../../reviews/REVIEW_r703.md) and [r704](../../reviews/REVIEW_r704.md).*

## Lemma 2.1, the identity that owns the record's relations (A) and (B)

*Added 2026-09-01 by [LIT-invariants](../../reviews/LIT-invariants.md). The record derived both relations from scratch; they are one published lemma of this already-shelved paper.*

Verbatim, §2 of the arXiv text (paper.txt lines 210–225):

> The bilinear map $\#$ induces a linear $O(n)$-equivariant map given by $R\mapsto R\,\#\,I$. The normalization of our parameters is related to the eigenvalues of this map.
>
> **Lemma 2.1.** Let $R\in S^2_B(\mathfrak{so}(n))$. Then
> $$R+R\,\#\,I=(n-1)R_I+\frac{n-2}2R_{\mathrm{Ric}_0}=\mathrm{Ric}\wedge\mathrm{id}.$$
>
> *Proof.* One can write
> $$R+R\,\#\,I=\tfrac14\big[(R+I)^2+(R+I)^\#-(R-I)^2-(R-I)^\#\big].$$
> The result on the eigenvalues of the map corresponding to the subspaces $\langle\mathrm{Ric}_0\rangle$ and $\langle I\rangle$ now follows from equation (6) by a straightforward computation. For $n=4$ one verifies directly that $\langle W\rangle$ is in the kernel of the map $R\mapsto R+R\,\#\,I$. Since there is a natural embedding of the Weyl curvature operators in $S^2_B(\mathfrak{so}(4))$ to the Weyl curvature operators in $S^2_B(\mathfrak{so}(n))$ this implies the same result for $n\ge5$. $\square$

**Read off the two statements the record needs.**

- $\langle W\rangle$ is in the kernel: $W+W\,\#\,I=0$, i.e. $\boxed{W\,\#\,I=-W}$ for every algebraic Weyl operator. In row form, $\tfrac12\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=(W\#I)_{kk}=-\lambda_k$, the record's **relation (B)**, $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$.
- At $R=I$ (so $R_I=I$, $R_{\mathrm{Ric}_0}=0$): $I+I\,\#\,I=(n-1)I$, i.e. $I\,\#\,I=(n-2)I$. In row form $\tfrac12\sum_{\beta\gamma}T_{k\beta\gamma}=n-2$, the record's **relation (A)**, $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$.

**Both checked here at $n=6$ against the record's own conventions** ($\dim\mathcal W_6=84$ built from [weyl.py](../../scripts/lib/weyl.py)): $\lVert I\#I-(n-2)I\rVert_\infty=0$ and $\lVert W\#I+W\rVert_\infty=1.1\times10^{-16}$ at a random unit $W\in\mathcal W_6$. The conventions agree with no rescaling.

**And Lemma 2.1 explains why there are exactly two such relations and no more.** $R\mapsto R\#I$ is $O(n)$-equivariant, and $S^2_B(\mathfrak{so}(n))=\langle I\rangle\oplus\langle\mathrm{Ric}_0\rangle\oplus\langle W\rangle$ is multiplicity-free, so Schur forces $\#I$ to act by a scalar on each summand. Lemma 2.1 names all three: $n-2$, $\tfrac{n-4}2$, $-1$. **There is no third linear relation to find**, which is the part of the record's classification that had been asserted rather than argued.

## What this source settles for the programme

- The definition of $\#$ in the exact normalisation the scripts use, with the $\tfrac12$ accounted for.
- That $P$ is the gradient-flow potential, not an arbitrary cubic.
- That $R^2+R^\#$ preserves the Bianchi subspace, **and only the sum**.

## What it does not cover

It says nothing about the maximum of $P$ on the trace-free Weyl part, which is the programme's question; its subject is invariant cones and pinching, not extremal values.
