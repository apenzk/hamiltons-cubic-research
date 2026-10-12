# VERIFY_v188, Lemma L44, cold verification

Cold reading of [BRIEF_L44.md](BRIEF_L44.md), with every quoted passage re-read at its source file. **No numerical work was done**, no script, no Sage, no Python, no numeric evaluation; every number below is exact arithmetic carried out by hand on objects built for the purpose, and the one witness rebuild is reported as a derivation, not as a screen. Log: [agent_logs/verify-L44-v188.log](../agent_logs/verify-L44-v188.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | Zero-padded $W_{\mathbb{CP}^2}$ is critical in $\mathcal W_n$ at every $n\ge4$ with $\theta=\sqrt{3/2}$ | **PROVEN**, rebuilt from the $\mathfrak{so}(4)$ structure constants; $Q(W)=3aW$ and $a=1/\sqrt6$ |
| 2 | $cI+W$ at the pinned $c=\tfrac1n\sqrt{2(n-2)/(n-1)}$ lies on $\partial\Omega_0$ | **PROVEN**, re-derived from the boundary equation, and confirmed independently by $F(cI+W)=\tfrac4{n-2}$ exactly |
| 3 | The Weyl tensor itself does not lie on $\partial\Omega_0$ | **PROVEN**, and by three independent reasons, only one of which the block gives |
| 4 | [Lemma L43](../results.md)'s collapse of $dF_R(\Phi(R))\le0$ to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ | **PROVEN**, re-derived line by line; the cancellation is exact and holds on the whole Einstein slice |
| 5 | That collapse is "the block's only step" | **REFUTED**, the same block names a second input three sentences later; four further inputs are used silently |
| 6 | The criterion demands $\theta_0(n)$ at both parities, $\Theta_n$ being what the diagonal locus attains | **PROVEN in substance**, the repair is right and load-bearing; the word "rational" in its justification is **wrong**, $\theta_0(n)$ is irrational in $n$ and only $\theta_0(n)^2$ is rational |
| 7 | Elementary route: $n^2-13n+18<0$ at odd $n$, upper root $\tfrac{13+\sqrt{97}}2$ | **PROVEN**, $\approx11.4244$ |
| 8 | Elementary route: $n^2-12n+8<0$ at even $n$, upper root $6+2\sqrt7$ | **PROVEN**, $\approx11.2915$ |
| 9 | No integer lies between the two roots | **PROVEN**, both lie strictly between $11$ and $12$ |
| 10 | *Invariance $\Rightarrow G\le0$* "holds in two lines … and is now stated rather than assumed" | **HYPOTHESIS-DEBT**, the two lines are on **no** canonical page; the one reason [problem.md:70](../findings/problem.md#L70) does give is not a proof of the implication, and was refuted by [r92](../reviews/REVIEW_r92.md) without being folded in |
| 11 | The needed direction is unavailable in the literature the project holds | **REFUTED**, [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Proposition 2.2 states it as an **iff**, in the stored full text, uncited by both L43 and L44 |
| 12 | Xu's (3.1)–(3.4) are verified against the stored full text, and the notes do not carry them | **PROVEN** on both halves, I read (3.1)–(3.4) at source and they are absent from the notes |
| 13 | Xu's (2.34), displayed in full at [problem.md:110](../findings/problem.md#L110) | **PROVEN**, matches the source term for term, coefficient $\tfrac3{n-2}$ included |
| 14 | The Xu note's transcription of Conjecture 1 | **BROKEN**, the source's $\tfrac14\lvert\mathrm{Ric}\rvert^2$ is transcribed as $\lVert\mathrm{Ric}\rVert^2$; a dropped denominator of exactly the kind the record warns about |
| 15 | [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 2.3.4's direction | **PROVEN as described**, the notes give sufficiency only, so the block's characterisation of it is accurate |
| 16 | $\ker W\ne0$ at the padded witness | **no step breaks**, every step used is kernel-blind; [W4](../findings/INDEX-traps.md), the one screen that is vacuous there, is not used |

**One line.** L44's conclusion is correct and its elementary route is complete as written; the cone route is correct wherever it is written down, but it turns on one implication whose only on-record justification does not establish it, and the implication is published, as an *iff*, in a paper this project stores and this block does not cite.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md) rather than restated.

- $Q(W)$: "Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself"; $P(W)$: "the cubic form $\langle W,Q(W)\rangle$"; $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$".
- $\theta_0(n)$: "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**, at odd $n$ the balanced split gives $\Theta_n<\theta_0(n)$*".
- $\Theta_n$: "the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$".
- $\Omega_0$: "**[Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s invariant cone**, whose boundary is $\tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$. **A Weyl tensor never lies on it** ($\mathrm{ric}=0$ is where the defining function blows up and $\Omega_0$ is undefined), *so the boundary point a $W$ furnishes is $cI+W$ at the pinned $c=\tfrac1n\sqrt{2(n-2)/(n-1)}$, and placing $W$ itself there is the error [L44](../findings/problem.md)'s audit found in three sites.*"
- $R_I$, $R_{\mathrm{ric}_0}$, $R_W$: "the three $O(n)$-irreducible pieces … $R_{\mathrm{ric}_0}=0$ makes a slice **Einstein**; Ricci-flat additionally needs the scalar part, i.e. $c=0$, *which is the one value $c$ cannot take on $\partial\Omega_0$*".
- Norms: "The inner product is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ at the $\Lambda^2$ level and plain Frobenius on the pair matrix", with $\lVert\varphi_{ab}\rVert^2=1$ and $\operatorname{tr}(v^2)=-2$ for a unit bivector.
- $\#$: "$\#$ is the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$".
- Structure constants: "$c_{abc}=\langle[v_a,v_b],v_c\rangle$ are **totally antisymmetric** … so $T_{abc}=c_{abc}^2$ is totally symmetric and vanishes when two indices coincide"; and "**Sums over pairs are over ORDERED pairs** unless the line says otherwise."
- Padding: "**Padding commutes with $Q$**, and preserves both the norm and $\theta$."
- $N$: "$\binom n2=\dim\Lambda^2\mathbb R^n$", which is the $\lVert I\rVert^2$ the boundary equation consumes.

## Hypothesis inventory

Everything L44's block consumes, where it comes from, and whether the block says so.

| # | input | source | discharged | named in the block |
| --- | --- | --- | --- | --- |
| H1 | $n\ge4$, so $\mathcal W_n\ne0$ and $\Lambda^2\mathbb R^4$ embeds | the statement | yes | yes |
| H2 | $W_{\mathbb{CP}^2}$ is a critical point at $n=4$ with $\theta=\sqrt{3/2}$ | rebuilt below; on the record at [L38](../results.md) and [L46](../results.md) | yes | asserted, **cited to nothing** |
| H3 | padding preserves criticality, norm and $\theta$ | [conventions.md](../findings/conventions.md), "Padding commutes with $Q$" | yes | no |
| H4 | $\mathrm{ric}(W)=0$ for a padded Weyl operator | definition of $\mathcal W_n$ | yes | used implicitly |
| H5 | $W\#I=-W$, hence $\Phi(I,W)=0$ | [BW08](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1, verbatim in the notes | yes | in the derivation at [problem.md:48](../findings/problem.md#L48), **not** in the L44 block |
| H6 | $I\#I=(n-2)I$, hence $\Phi(I)=(n-1)I$ | same lemma at $R=I$ | yes | same |
| H7 | $Q(W)$ is again Weyl; in particular $\mathrm{scal}(Q(W))=0$ | [BW08](../references/boehm-wilking-2008-space-forms/notes.md) eq. (6); [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Prop. 2.7(4) | yes | same |
| H8 | $\lVert I\rVert^2=\binom n2$ | [conventions.md](../findings/conventions.md) | yes | yes |
| H9 | $\partial\Omega_0$ is $\tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$ on the $\operatorname{scal}>0$ nappe | [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) p. 96; [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) (1.2) | yes | yes |
| H10 | $\operatorname{scal}(R)>0$ selects the positive root for $c$ | [Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s own cone definition | yes | in the derivation, not in the block |
| H11 | $F$ is smooth at $cI+W$, i.e. $\mathrm{ric}(cI+W)\ne0$ | $c>0$ | yes | implicit in the block's own "$\mathrm{ric}=0$ … is where $F$ blows up" |
| H12 | **invariance $\Rightarrow G\le0$ at a boundary point** | nothing on the canonical record | **NO** | yes, and asserted to hold "in two lines" |
| H13 | $\Theta_n\le\theta_0(n)$, needed to pass from the cone clause to the conjecture's clause | [conventions.md](../findings/conventions.md), $\theta_0^2-\Theta_n^2=\tfrac{8(n-1)}{n^2(n+1)(n-2)}\ge0$ | yes | no, the block reaches the same conclusion by the separate elementary route instead |

**H12 is the whole of the debt.** Everything else is either discharged on the record or discharged below.

## 1. The witness, rebuilt from the $\mathfrak{so}(4)$ structure constants

I did not take the witness from the record. I built it, in the record's own normalisations, and read $\theta$ off the result.

**The bracket.** In $\Lambda^2\mathbb R^4\cong\mathfrak{so}(4)$ with $\varphi_{ab}=E_{ab}-E_{ba}$ and the half-trace pairing of [conventions.md](../findings/conventions.md), $\varphi_{ab}^{\mathsf T}\varphi_{ab}=E_{aa}+E_{bb}$ gives $\lVert\varphi_{ab}\rVert^2=1$, so $\{\varphi_{ab}\}_{a<b}$ is orthonormal, and the bracket is $[\varphi_{ab},\varphi_{cd}]=\delta_{bc}\varphi_{ad}-\delta_{ac}\varphi_{bd}-\delta_{bd}\varphi_{ac}+\delta_{ad}\varphi_{bc}$.

**The self-dual frame.** $\omega_1^\pm=\tfrac1{\sqrt2}(\varphi_{12}\pm\varphi_{34})$, $\omega_2^\pm=\tfrac1{\sqrt2}(\varphi_{13}\mp\varphi_{24})$, $\omega_3^\pm=\tfrac1{\sqrt2}(\varphi_{14}\pm\varphi_{23})$, orthonormal because the $\varphi$'s are. Expanding,

$$[\omega_1^+,\omega_2^+]=\tfrac12\big([\varphi_{12},\varphi_{13}]-[\varphi_{12},\varphi_{24}]+[\varphi_{34},\varphi_{13}]-[\varphi_{34},\varphi_{24}]\big)=\tfrac12\big(-\varphi_{23}-\varphi_{14}-\varphi_{14}-\varphi_{23}\big)=-\sqrt2\,\omega_3^+,$$

and cyclically; every bracket of a $+$ with a $-$ vanishes. So the only nonzero structure constants inside $\Lambda^+$ are $c_{123}^+=\pm\sqrt2$, giving $T_{123}=2$ on every permutation.

**Two independent checks on that constant, from numbered results rather than from my own algebra.** [Lemma L31](../findings/stratum-two-negative.md)'s pair cap reads $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$, and here it is exactly $2$, the equality case. [Lemma L153](../findings/bounds.md)'s row marginal reads $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$; at $v=\omega_1^+$ in $n=4$ the only contributing ordered pairs are $(2,3)$ and $(3,2)$, giving $2+2=4=2(4-2)$.

**The tensor.** Take $W$ diagonal in this frame with $\lambda=(2a,-a,-a)$ on $\Lambda^+$ and $0$ on $\Lambda^-$, the spectrum [Lemma L29](../results.md) names, "*attained at $(2,-1,-1)/\sqrt6$, padded $W_{\mathbb{CP}^2}$*". It is a Weyl operator: [BW08](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1's relation (B), $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, reads $2\lambda_2+2\lambda_3=-4a=-2\lambda_1$ at $k=1$ and $2\lambda_1+2\lambda_3=2a=-2\lambda_2$ at $k=2$. Both hold.

**The norm.** $\lVert W\rVert^2=\operatorname{tr}(W^2)=4a^2+a^2+a^2=6a^2$, so $\lVert W\rVert=1$ at $a=1/\sqrt6$.

**The cubic.** With $\#$ the halved product, $W^\#=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\,u_{\alpha\beta}u_{\alpha\beta}^{\mathsf T}$ with $u_{\alpha\beta}=[v_\alpha,v_\beta]$, so

$$\langle W,W^\#\rangle=\tfrac12\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma},\qquad \langle W,W^2\rangle=\sum_\alpha\lambda_\alpha^3 .$$

The six ordered triples of $\{1,2,3\}$ each carry $T=2$ and $\lambda_1\lambda_2\lambda_3=2a^3$, so $\langle W,W^\#\rangle=\tfrac12\cdot6\cdot2\cdot2a^3=12a^3$, and $\sum\lambda^3=8a^3-a^3-a^3=6a^3$. Hence $P(W)=18a^3$, and at $a=1/\sqrt6$,

$$P(W)=\frac{18}{6\sqrt6}=\frac3{\sqrt6}=\frac{\sqrt6}2=\sqrt{3/2}.$$

**A normalisation anchor that does not assume the answer.** $\operatorname{tr}(W^\#)=\tfrac12\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta\sum_\gamma T_{\alpha\beta\gamma}=\sum_{\alpha\ne\beta}\lambda_\alpha\lambda_\beta=(\sum\lambda)^2-\sum\lambda^2=-6a^2=-\operatorname{tr}(W^2)$, which is $\operatorname{scal}(Q(W))=0$. So the $\#$ normalisation I used is the one under which $Q$ preserves $\mathcal W_n$, and no factor of $2$ has been dropped.

**Criticality.** $W^2$ is $(4a^2,a^2,a^2)$; and since $u_{\alpha\beta}u_{\alpha\beta}^{\mathsf T}=2\,\omega_\gamma\omega_\gamma^{\mathsf T}$ for $\{\alpha,\beta,\gamma\}=\{1,2,3\}$, $W^\#$ is diagonal with entry $2\lambda_\alpha\lambda_\beta$ at $\gamma$: $(2a^2,-4a^2,-4a^2)$. So

$$Q(W)=(6a^2,-3a^2,-3a^2)=3a\cdot(2a,-a,-a)=3a\,W,$$

which is $Q(W)=\theta W$ with $\theta=3a=3/\sqrt6=\sqrt{3/2}$, agreeing with $P(W)$ as it must.

**The padding.** $W$ is supported on $\Lambda^2\mathbb R^4\subset\Lambda^2\mathbb R^n$. Its Ricci contraction is unchanged, since $\mathrm{ric}(W)_{ij}=\sum_kW_{ikjk}$ has no term outside the block; $W^2$ is manifestly the padding of $W^2$; and $W^\#$ is built from brackets of elements of $\mathfrak{so}(4)$, which stay in $\mathfrak{so}(4)$, so $W^\#$ is the padding of $W^\#$. Hence $Q$ commutes with padding, $\lVert W\rVert$ and $\theta$ are unchanged, and (because $Q$ maps $\mathcal W_n$ to itself), the gradient of $P$ on the unit sphere of $\mathcal W_n$ is $3(Q(W)-\theta W)=0$ at the padded point. **Claim 1 holds at every $n\ge4$.**

*Cross-checks against the record's own closed forms, neither used in the derivation.* [Lemma L38](../results.md) gives $\theta^2=(m+1)(2m-1)/(3m(m-1))$ on the $\mathbb{CP}^m$ family, which is $9/6=3/2$ at $m=2$; and $\theta^2=m(m+1)/((m-1)(m+2))$ on the second family, which is $6/4=3/2$ at $m=2$. Both agree.

## 2. The boundary placement, both halves

**Half one: $cI+W$ is on $\partial\Omega_0$.** By [conventions.md](../findings/conventions.md) the boundary is $\tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$. For $R=cI+W$ with $W$ Weyl, $R_I=cI$ and $R_W=W$, so with $\lVert W\rVert=1$ and $\lVert I\rVert^2=\tfrac{n(n-1)}2$,

$$\frac{n-2}n=c^2\frac{n(n-1)}2\quad\Longrightarrow\quad c^2=\frac{2(n-2)}{n^2(n-1)}\quad\Longrightarrow\quad c=\frac1n\sqrt{\frac{2(n-2)}{n-1}},$$

the positive root, selected by $\operatorname{scal}(R)=c\operatorname{scal}(I)>0$. This is the block's pinned $c$ exactly, and it gives $c(n-1)=\tfrac1n\sqrt{2(n-1)(n-2)}=\theta_0(n)$.

**And a second, independent confirmation, which the record does not perform.** The cone is also $F^{-1}\big((-\infty,\tfrac4{n-2}]\big)$ at $a=0$. At this $R$, $\lVert R\rVert^2=c^2\binom n2+1=\tfrac{n-2}n+1=\tfrac{2n-2}n$, and $\lVert\mathrm{ric}(R)\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2=\tfrac{n-1}2\cdot\tfrac{n-2}n$, so

$$F(R)=\frac{(2n-2)/n}{(n-1)(n-2)/(2n)}=\frac{2(n-1)}{n}\cdot\frac{2n}{(n-1)(n-2)}=\frac4{n-2},$$

which is the $a=0$ threshold on the nose. The two routes to the boundary agree, so the placement is not an artefact of either display.

**Half two: the Weyl tensor itself is not there, and for three reasons.** The block gives one: $\mathrm{ric}(W)=0$, so $F=\lVert W\rVert^2/0$ blows up and $\Omega_0$ is undefined at $W$. [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) says the same at source (*"A Weyl tensor has $\mathrm{ric}=0$, which is where $F$ blows up"*) and [Xu](https://arxiv.org/abs/2412.13633) §3.1 defines $F$ on $\operatorname{scal}^+$ precisely so that *"Since $\mathrm{Ric}(R)\ne0$ … the function $F$ is well-defined."* Two more, which the block does not give and which do not need the $F$ formulation at all: in the decomposition form the $a=0$ condition at $R=W$ reads $\tfrac{n-2}4\lVert W\rVert^2\le0$, false for $W\ne0$, so a nonzero Weyl operator is strictly *outside* $\Omega_0$ rather than on its boundary; and $\operatorname{scal}(W)=0$ fails the cone's own $\operatorname{scal}>0$ clause. **The repair is correct, and it is over-determined.** Note that the second reason places $W$ outside a set the first says is undefined there, both are true statements about different presentations of $\Omega_0$, and neither puts $W$ on the boundary.

**The repaired placement is the load-bearing one.** Had the record kept $W$ itself on $\partial\Omega_0$, the criterion evaluated there would have been $\langle W,Q(W)\rangle\le F(W)\langle\mathrm{ric}W,\mathrm{ric}\,\Phi(W)\rangle$ with both factors on the right ill-defined, and no constant would have come out. The shift by $cI$ is what produces $\theta_0(n)$, and $c=0$ (the Ricci-flat choice), is the one value the boundary equation forbids, exactly as [conventions.md](../findings/conventions.md) records.

## 3. The collapse, and whether it is the only step

**The criterion.** With $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ and $G(R)=dF_R(\Phi(R))$, the quotient rule gives $dF_R(S)=\tfrac2{\lVert\mathrm{ric}R\rVert^2}\big(\langle R,S\rangle-F(R)\langle\mathrm{ric}R,\mathrm{ric}S\rangle\big)$, so $G(R)\le0\iff\langle R,\Phi(R)\rangle\le F(R)\langle\mathrm{ric}R,\mathrm{ric}\,\Phi(R)\rangle$. This is [Xu](https://arxiv.org/abs/2412.13633) (3.1)–(3.2) verbatim and [Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s display, and I re-derived it rather than copying it.

**The expansion.** $\Phi(cI+W)=c^2\Phi(I)+2c\Phi(I,W)+\Phi(W)=c^2(n-1)I+Q(W)$, using $\Phi(I)=(n-1)I$ and $\Phi(I,W)=\tfrac12(IW+WI)+I\#W=W-W=0$, both from [BW08](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 as the notes quote it.

**The left side.** $\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+c\langle I,Q(W)\rangle+c^2(n-1)\langle W,I\rangle+\langle W,Q(W)\rangle$. The middle two vanish: $\langle W,I\rangle=0$ by irreducible orthogonality, and $\langle I,Q(W)\rangle$ is a multiple of $\operatorname{tr}Q(W)=\tfrac12\operatorname{scal}(Q(W))=0$.

**The right side.** $\mathrm{ric}(R)=c\,\mathrm{ric}(I)$ and $\mathrm{ric}(\Phi(R))=c^2(n-1)\mathrm{ric}(I)+\mathrm{ric}(Q(W))$. Here $\mathrm{ric}(I)$ is a multiple of the metric, so $\langle\mathrm{ric}(I),\mathrm{ric}(Q(W))\rangle$ is a multiple of $\operatorname{tr}\mathrm{ric}(Q(W))=\operatorname{scal}(Q(W))=0$, **so $\operatorname{scal}(Q(W))=0$ really is enough here and the stronger $\mathrm{ric}(Q(W))=0$ is not needed**, which vindicates the block's own list at [problem.md:78](../findings/problem.md#L78). Hence the right side is $F(R)\cdot c^3(n-1)\lVert\mathrm{ric}(I)\rVert^2=\big(c^2\lVert I\rVert^2+\lVert W\rVert^2\big)c(n-1)$, the $\lVert\mathrm{ric}(I)\rVert^2$ cancelling against $F$'s denominator.

**The residue.** Subtracting, $c^3(n-1)\lVert I\rVert^2$ is common to both sides and

$$G(R)\le0\iff\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2,$$

with **nothing left over**, for every $c>0$ on the slice, an identity, not a boundary accident, exactly as [L43](../findings/problem.md#L528) claims. Pinning $c$ to $\partial\Omega_0$ and normalising $\lVert W\rVert=1$ turns it into $\theta\le\theta_0(n)$. **Claim 4 holds.**

**The trilinear symmetry is genuinely not load-bearing**, as [L43](../results.md) asserts: the derivation above uses bilinearity, $\Phi(I,W)=0$, $\Phi(I)=(n-1)I$, $\langle I,W\rangle=0$ and $\operatorname{scal}(Q(W))=0$, and no permutation of $T$'s arguments.

**But "the block's only step" is false.** Three sentences after calling the collapse *"the block's only step"*, [problem.md:215](../findings/problem.md#L215) opens *"Two things the argument uses and did not say"* and names invariance $\Rightarrow G\le0$, an input that is not in L43 and not derivable from it. Beyond that, the block uses H2, H3, H10 and H11 of the inventory above without stating them, and the whole elementary route at [problem.md:217](../findings/problem.md#L217) is a second, independent argument for the same conclusion, which is by definition not "the only step". The phrase is a self-contradiction inside one block, and it understates a dependency the same block goes on to disclose.

## 4. The parity claim

**The substance is right, and it matters.** The collapse produces the constant $c(n-1)$, where $c$ solves $\tfrac{n-2}n\lVert W\rVert^2=c^2\binom n2$. Both $\tfrac{n-2}n$ and $\binom n2$ are polynomial in $n$; nothing in either depends on $n\bmod2$; and no sphere product, balanced or unbalanced, enters the derivation at any point. So the criterion tests every unit Weyl operator against $\theta_0(n)$ at both parities, and $\Theta_n$, which by [conventions.md](../findings/conventions.md) is "the diagonal maximum" and by [Lemma L57](../results.md) is attained at $S^{\lfloor n/2\rfloor}\times S^{\lceil n/2\rceil}$, is what a family *attains*, not what the criterion *demands*. **Claim 6's substance holds, and it is exactly the distinction whose loss [conventions.md](../findings/conventions.md) records as having "regrown [L0](../findings/problem.md)'s refuted constant".**

**The justification's wording is wrong.** [problem.md:213](../findings/problem.md#L213) says the constant "is a rational function of $n$ with no parity in it". It is not rational: $c(n-1)=\tfrac1n\sqrt{2(n-1)(n-2)}$ is irrational in $n$ for all but finitely many integers, at $n=12$ it is $\tfrac{\sqrt{220}}{12}$. What is rational is its **square**, $\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}$. The parity-freeness the sentence wants follows from the square being a rational function, and survives the correction untouched; the sentence as printed asserts something false about $\theta_0(n)$ in a file whose whole purpose is to keep $\theta_0$ and $\Theta_n$ apart.

**A second reading I tested and rejected.** One could read "the constant" as $c^2(n-1)^2$ or as the boundary equation's coefficient, either of which is rational. But the sentence's subject is named two clauses earlier as "$c(n-1)$", and $c(n-1)=\theta_0(n)$ is stated as such in [L43](../results.md). The charitable reading is unavailable.

**Does the parity distinction change any integer?** No, and I checked. At even $n$, $\Theta_n=\theta_0(n)$ and the two constants coincide. At odd $n$ they separate by $\theta_0^2-\Theta_n^2=\tfrac{8(n-1)}{n^2(n+1)(n-2)}>0$, so the criterion's demand is the *weaker* one; at $n=11$, $\theta_0(11)^2=\tfrac{180}{121}=1.4876\ldots$ against $\Theta_{11}^2=\tfrac{40}{27}=1.4814\ldots$, and their difference $\tfrac{80}{13068}$ matches the closed form. **Both are below $3/2$**, so the witness defeats the criterion at $n=11$ under either constant, and the distinction costs the conclusion nothing. It would have mattered had an odd integer fallen between the two crossovers; §5 shows none does.

## 5. The elementary route

**Odd $n$.** $\Theta_n^2=\tfrac{2(n-1)(n-3)}{(n+1)(n-2)}<\tfrac32\iff4(n-1)(n-3)<3(n+1)(n-2)$, i.e. $4n^2-16n+12<3n^2-3n-6$, i.e. $n^2-13n+18<0$. Roots $\tfrac{13\pm\sqrt{97}}2$; with $9.8^2=96.04$ and $9.9^2=98.01$, $\sqrt{97}\in(9.84,9.85)$ and the upper root is in $(11.42,11.425)$. **The block's $\tfrac{13+\sqrt{97}}2\approx11.42$ is right.**

**Even $n$.** $\Theta_n^2=\theta_0(n)^2=\tfrac{2(n-1)(n-2)}{n^2}<\tfrac32\iff4(n-1)(n-2)<3n^2$, i.e. $4n^2-12n+8<3n^2$, i.e. $n^2-12n+8<0$. Roots $6\pm2\sqrt7$; with $2.645^2=6.996\ldots$ and $2.646^2=7.001\ldots$, $\sqrt7\in(2.6457,2.6458)$ and the upper root is in $(11.2914,11.2916)$. **The block's $6+2\sqrt7\approx11.29$ is right.**

**No integer between them.** $11<11.2915<11.4244<12$. Both floor to $11$, so both parities give the integer threshold $n\ge12$, *the same threshold from two different polynomials*, as claimed. **Claims 7, 8 and 9 hold.**

**The two polynomials are checked at their own parities and only there.** $n^2-13n+18$ is evaluated at odd $n$: $-22$ at $n=5$, $-4$ at $n=11$, $+6$ at $n=13$. $n^2-12n+8$ is evaluated at even $n$: $-24$ at $n=4$, $-16$ at $n=10$, $+8$ at $n=12$. Every integer $4\le n\le11$ is strictly negative at its own parity's polynomial, and $n=12$ is strictly positive. The margin at $n=11$ is $-4$, small, and it is the tightest point of the whole statement.

**The route needs no cone theory, and that is correct.** $\Theta_n$ is the conjecture's asserted supremum. Padded $W_{\mathbb{CP}^2}$ is a unit element of $\mathcal W_n$ with $P=\sqrt{3/2}$. If $\Theta_n<\sqrt{3/2}$ then $\sup\{P(W):\lVert W\rVert=1\}>\Theta_n$ and the conjecture's conclusion is false at that $n$, full stop. No $F$, no $\Omega_0$, no invariance criterion, no owed direction. **The elementary route carries L44's headline conclusion on its own, and it carries none of the debt of §6.**

**Trap [W5](../findings/INDEX-traps.md) is not sprung here.** The block writes "the sphere-product maximum is $\Theta_n$", which is the diagonal maximum correctly named as the value the sphere product attains ([L57](../results.md)); it does not read $\Theta_n$ as the global maximum. Indeed the argument's whole point is to exhibit something *above* $\Theta_n$, which is the opposite error to W5's.

## 6. The direction the block supplies in prose

**What the block says.** [problem.md:215](../findings/problem.md#L215): *"It needs invariance $\Rightarrow G\le0$, where [Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s Lemma 2.3.4 supplies only the converse; the direction holds in two lines, by evaluating the flow's normal component at the boundary point, and is now stated rather than assumed."*

**Are those two lines on the record?** I searched every markdown file in the repository for the phrase and for the implication. **They are on no canonical page.** [problem.md](../findings/problem.md) states the dependency twice (at line 70 and at line 215) and writes the argument neither time. [results.md](../results.md) does not mention it. What exists is the following, and none of it is a proof in the record's own sense:

| where | what stands there | status |
| --- | --- | --- |
| [problem.md:70](../findings/problem.md#L70) | *"it holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$"* | **a wrong reason for a true claim**, see below |
| [problem.md:215](../findings/problem.md#L215) | *"holds in two lines, by evaluating the flow's normal component at the boundary point"* | a description of an argument, not the argument; and a *different* mechanism from line 70's |
| [REVIEW_r90.md:31](../reviews/REVIEW_r90.md), [REVIEW_r523.md:94](../reviews/REVIEW_r523.md), [REVIEW_r557.md:74](../reviews/REVIEW_r557.md) | the $\tfrac d{dt}F(R(t))\big|_0=G(R)>0$ argument, written out | **reviews, not the canonical record**; each of the three recommends folding it in, and none was |
| [REVIEW_r92.md:185](../reviews/REVIEW_r92.md) | *"the scalar-curvature fact is not what supplies that direction … Correct conclusion, wrong reason"* | a refutation of line 70 that was never applied, **line 70 still reads as it did** |

**Why line 70's reason does not establish line 70's claim.** $\tfrac d{dt}\operatorname{scal}=2\lVert\mathrm{ric}\rVert^2>0$ says the trajectory stays inside the open clause $\operatorname{scal}>0$. It says nothing whatever about $F$, whose sublevel set is the other clause and the one the criterion is about. Concretely: let $C=\{F\le\tau\}\cap\{\operatorname{scal}>0\}$ and let $R_0\in\partial C$. Knowing $\operatorname{scal}$ increases along the trajectory through $R_0$ is compatible with $F$ increasing, decreasing, or staying put, so it cannot distinguish "the solution leaves $C$" from "the solution stays". The implication being asserted is precisely about which of those happens. **[r92](../reviews/REVIEW_r92.md) said this fourteen review-numbers ago and the line was not repaired.**

**Locate–exhibit–oppose, applied.** *Locate:* [problem.md:70](../findings/problem.md#L70), the clause after the semicolon. *Exhibit:* the counter-instance above, any $F$ and any trajectory on which $\operatorname{scal}$ rises; the hypothesis constrains a different function from the conclusion's. *Oppose:* could $\tfrac d{dt}\operatorname{scal}>0$ be a *component* of the argument rather than the whole of it, ensuring the boundary point's neighbourhood in $\partial\Omega_0$ is the smooth $F$-level set? Yes, and that is its honest role, but the sentence writes "it holds via", presenting it as the reason, and [r92](../reviews/REVIEW_r92.md) further notes even that supporting role is superfluous since continuity of the solution already keeps it in $\operatorname{scal}^+$ for small $t$. The opposing reading does not save the sentence. **Real.**

**I do not supply the missing argument.** What L44 owes, stated exactly: *for $R_0\in\partial\Omega_0$ with $\operatorname{scal}(R_0)>0$ and $\mathrm{ric}(R_0)\ne0$, if the Hamilton ODE preserves $\Omega_0$ then $dF_{R_0}(\Phi(R_0))\le0$.* That proposition has no proof in [findings/](../findings/) or [results.md](../results.md).

**And it did not have to be owed.** [Xu](https://arxiv.org/abs/2412.13633) Proposition 2.2, read at source (lines 435–437), states an **iff**:

> Proposition 2.2. A closed convex $O(n)$-invariant subset $C\subset S^2_B(\mathfrak{so}(n))$ is invariant under the Hamilton ODE (2.28) if and only if for all $R\in\partial C$ we have $Q(R)\in T_RC$, the tangent cone of $C$ at $R$.

The "normal component at the boundary point" the block gestures at is exactly this tangent-cone condition, so the block's prose sketch is describing a published theorem it does not cite. **[r91](../reviews/REVIEW_r91.md) found this too, and it was not folded in either.** Two cautions a repair would have to clear, and this is where the "imported theorem whose hypotheses were never checked" trap sits: Proposition 2.2 requires $C$ **closed** convex, and $\Omega_0$ carries the *open* clause $\operatorname{scal}>0$, so the citation must be to $\overline{\Omega_0}$ or to $\Omega_0\cup\{0\}$, Xu himself handles this separately at line 1175, *"This is also true for $\Omega(a)$ since positive scalar curvature is [preserved]"*; and the passage from $Q(R)\in T_RC$ to $dF_R(Q(R))\le0$ needs $dF_R\ne0$ at the point, so that the tangent cone is the half-space the differential cuts out.

## 7. The sources, and what a consumer can check from the notes alone

**Xu's (3.1)–(3.4): the block's claim is accurate on both halves.** I read them at [xu-2412.13633.txt](https://arxiv.org/abs/2412.13633) lines 817–834, (3.1) the differential of $F$, (3.2) its value at $S=Q(R)$, (3.3) $dF_R(Q(R))\le0$ on $\partial\Omega(a)$, (3.4) the same written out, and they are as the record describes. They are **absent from** [notes.md](../references/xu-2024-ricci-flow-invariant-conditions/notes.md), which the block also says.

**What [the Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) alone will support.** Conjecture 1 and the cone family; the endpoint analysis $\Omega(a)=\emptyset$ for $a>n/4$ and $\Omega(n/4)=\mathbb R^+I$; Theorem 1.1's $\epsilon_n=1/n$ and the table of proved fractions; and Proposition 2.7 quoted in full, whose items (3) and (4) are two of the collapse's inputs. **What they will not support:** (3.1)–(3.4), which are the criterion's own derivation; Lemma 2.8 / equation (2.34), named but not displayed, while [problem.md:110](../findings/problem.md#L110) displays it in full and attributes it to Xu; and Proposition 2.2, the iff of §6, which the notes omit entirely and which is the single most useful thing in the paper for this lemma. So a consumer working from the notes can check the *cone* and the *block structure*, and must go to the stored full text for the *criterion*.

**I checked (2.34) at source anyway.** Lines 519–526 of the full text carry it with $\tfrac n{2(n-1)}\bar\lambda^3$, $\tfrac3{2(n-1)}\bar\lambda\lvert\mathrm{Ric}_0\rvert^2$, $\tfrac3{n-2}\langle\mathrm{Ric}_0\wedge\mathrm{Ric}_0,W\rangle$, $-\tfrac2{(n-2)^2}\langle(\mathrm{Ric}_0^2)_0,\mathrm{Ric}_0\rangle$ and $\langle Q(W),W\rangle$. **[problem.md](../findings/problem.md)'s display is faithful term for term, coefficient $\tfrac3{n-2}$ included.**

**One transcription defect in the Xu notes.** *Locate:* [notes.md](../references/xu-2024-ricci-flow-invariant-conditions/notes.md), the display under "The conjecture, restated (Conjecture 1 …)", which prints $\big(\tfrac{n-2}4+a\big)\lVert R\rVert^2\le\lVert\mathrm{Ric}\rVert^2$. *Exhibit:* the source's (1.1), at [xu-2412.13633.txt](https://arxiv.org/abs/2412.13633) lines 81–85, has $\le\tfrac14\lvert\mathrm{Ric}\rvert^2$, the denominator sitting on the following line, and the $\tfrac14$ is independently forced by the same paper's §3.1, which states $F(R)\le\tfrac1{n-2}$ on $\Omega(0)$ and $F(I)=\tfrac1{2(n-1)}$, neither of which is consistent with the note's display. *Oppose:* could the note be silently converting to Beitz's $\mathrm{ric}$, which is half Xu's $\mathrm{Ric}$ and would absorb the $\tfrac4$? Under that reading the cone is the right set, but the note writes Xu's own capital-$\mathrm{Ric}$ spelling, presents the line as Xu's Conjecture 1, and records no conversion; and the note's next paragraph reproduces (1.2), which is scale-free in $\mathrm{Ric}$ and cannot disambiguate. So the display is false of the source as written. **Real, and it is the pdftotext dropped-denominator failure [problem.md:82](../findings/problem.md#L82) already warns about by name.** Severity: it touches L44 not at all, every step of L43 and L44 runs in Beitz's normalisation, and [problem.md](../findings/problem.md) already carries the factor-$4$ note explicitly.

**[Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 2.3.4, read at source.** The notes give it as *"a sublevel set of a function $F$ is invariant when $dF_R(\Phi(R))\le0$ on the relevant region"*, sufficiency, one direction. **The block's characterisation of it is exactly right.** I note in passing that [REVIEW_r89.md:38](../reviews/REVIEW_r89.md) asserts Lemma 2.3.4 "gives both directions"; that assertion is inconsistent with the transcribed notes and with the block, and nothing in [references/](../references/) supports it.

**No search-tool prose was used as a citation.** Every source claim above is read from a file in [references/](../references/).

## 8. The traps, answered by name

| trap | finding |
| --- | --- |
| $\ker W\ne0$ | **The witness is padded by construction: at $n=12$ its kernel is $63$ of $66$**, as [W4](../findings/INDEX-traps.md) records. Every step used is kernel-blind, criticality ($Q(W)=\theta W$, computed on the rank-$3$ support), $\lVert W\rVert=1$, $\mathrm{ric}(W)=0$, the collapse (bilinearity plus three identities holding at every $W$), and the boundary equation (a function of $\lVert W\rVert$ alone). **Nothing breaks.** The one instrument that *is* vacuous at $\ker W\ne0$ (the gradedness screen $S(W)$), is not used by L44 at any point, and the block would be wrong if it were. |
| boundary of every stated range | $n\ge4$: the witness lives in $\Lambda^2\mathbb R^4$, so $n=4$ is where it first exists, and $\mathcal W_n=0$ below. $n=11$ and $n=12$ are §5. $a=0$ is the cone endpoint L43 is stated at, and L43 says so. $c>0$ is forced; $c=0$ is the excluded Ricci-flat value. |
| smallest admissible dimension | $n=4$. Padding is trivial there, and $\theta_0(4)=\tfrac{\sqrt{2\cdot3\cdot2}}4=\tfrac{\sqrt{12}}4=\tfrac{\sqrt3}2<\sqrt{3/2}$, so the criterion fails, matching $n^2-12n+8=-24$. The cone is non-degenerate at $n=4$ ($\tfrac{n-2}n=\tfrac12>0$) and Xu's Theorem 1.1 studies $\Omega(a)$ down to $n=4$, so the statement is not vacuous at the endpoint. |
| odd $n$ | The criterion's constant carries no parity (§4); the elementary route's does, and the odd polynomial is checked separately (§5) at $n=5,7,9,11$. The two crossovers differ, and the difference changes no integer. **This is the block's own repair and it survives the test.** |
| $n=11$ against $n=12$ | $n=11$: $\theta_0^2=\tfrac{180}{121}<\tfrac32$ and $\Theta_{11}^2=\tfrac{40}{27}<\tfrac32$, both fail, margins $-3$ and $-4$ in the two polynomials. $n=12$: $\theta_0(12)^2=\tfrac{2\cdot11\cdot10}{144}=\tfrac{220}{144}=\tfrac{55}{36}>\tfrac32$, margin $+8$. The crossing is between them, twice. |
| a claim proven on a subfamily, used in general | L43 is proved on the Einstein slice $R_{\mathrm{ric}_0}=0$ and L44 uses it **only** at $R=cI+W$, which is on that slice. The conclusion (non-invariance of $\Omega_0$), is general, but one violating boundary point suffices for it, so there is no overreach. |
| a hypothesis stated but never used | None found. $n\ge4$, the Einstein slice, $\operatorname{scal}>0$ and $\lVert W\rVert=1$ all do work. The trilinear symmetry is *stated* by L43 as a theorem and explicitly flagged as not load-bearing, which §3 confirms, that is a disclosure, not an unused hypothesis. |
| a step using a hypothesis never stated | **Four**: H2 (the witness's criticality at $n=4$, asserted with no citation, though [L38](../results.md) and [L46](../results.md) would discharge it), H3 (padding commutes with $Q$, in [conventions.md](../findings/conventions.md), uncited here), H10 ($\operatorname{scal}>0$ selects the positive root) and H11 ($F$ smooth at the point). All four are true and discharged; none is cited in the L44 block. |
| a universal claim with no witness | The lemma *is* a witness claim, and the witness is explicit and rebuilt in §1. The universal half ("$\Omega_0$ is invariant at $n\ge12$"), is disclaimed in the last sentence of [results.md:282](../results.md#L282), correctly. |
| an imported theorem whose hypotheses were never checked | None sprung, **because the one import that would spring it is not made**: [Xu](https://arxiv.org/abs/2412.13633) Proposition 2.2 requires $C$ *closed* convex and $\Omega_0$ is not closed. A repair citing it must close the set first (§6). The imports that *are* made, [BW08](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 and eq. (6), [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) p. 96, hold for every $R\in S^2_B(\mathfrak{so}(n))$ with no hypothesis to check. |
| $\Omega_0$ | Used in [conventions.md](../findings/conventions.md)'s single sense throughout, and the repair this round is checking is exactly that entry's own correction. Clean. |
| $c$ | **[conventions.md](../findings/conventions.md) records two constants under $c$**, and both live in [problem.md](../findings/problem.md): L44's pinned $\partial\Omega_0$ constant $\tfrac1n\sqrt{2(n-2)/(n-1)}$, and [L46](../results.md)'s centre constant $\tfrac1{2(n-1)}$ at Einstein normalisation $\tfrac12$. They are unequal at every $n$, at $n=12$, $0.1231\ldots$ against $\tfrac1{22}=0.04545\ldots$. L44's block says "the pinned $c$", which disambiguates; L43's block writes bare $c$ and relies on the reader carrying the boundary equation. Live but not sprung. |
| $F$ | $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ here. **This collides with [L17](../findings/route-a.md)'s $F$**, the quantity in $d^+\delta^2=-2aF$ with $F\ge0$, which [conventions.md](../findings/conventions.md) mentions without tabling the collision. Not sprung inside L44, but the letter is unqualified in both blocks. |
| $R_I$ | One sense, [conventions.md](../findings/conventions.md)'s. Used correctly: $R_I=cI$ at $R=cI+W$, which is what pins $c$. |
| $\Pi$ | **Not used anywhere in L43 or L44.** The four-way collision [conventions.md](../findings/conventions.md) records is not reached by this block. |
| $\Phi$ | **Live and unqualified.** [conventions.md](../findings/conventions.md) records four objects under $\Phi$; L43 and L44 mean sense (ii), "Hamilton's map $Q$ itself, in [Böhm–Wilking](../references/boehm-wilking-2008-space-forms/notes.md)'s notation", and say so nowhere. Worse, the same sentence at [problem.md:213](../findings/problem.md#L213) writes both $\Phi(R)$ and $Q(W)$ **for the same map**, without saying they are the same map. A reader resolving $\Phi$ against sense (iii), $\Phi(M)=M^{\circ2}+M^2$ on the diagonal locus, reads the criterion as a statement about a locus the witness is not on. |

## 9. What would falsify the statement, and what I did to look for it

**The object.** A dimension $n$ with $4\le n\le11$ at which $\Omega_0$ *is* invariant under the Hamilton ODE, equivalently, since the criterion collapses with no residue, the failure of any one link in the chain: a unit padded $W_{\mathbb{CP}^2}$ whose $\theta$ is not $\sqrt{3/2}$; a $c$ at which $cI+W$ misses $\partial\Omega_0$; a residual term surviving the collapse and shifting the demanded constant upward past $\sqrt{3/2}$; or an integer $n$ with $\Theta_n\ge\sqrt{3/2}$ and $n\le11$, which would break the elementary route independently.

**What I did.** I rebuilt the witness from the $\mathfrak{so}(4)$ brackets rather than reading its spectrum off the record, checked its structure constants against [L31](../findings/stratum-two-negative.md)'s pair cap and [L153](../findings/bounds.md)'s row marginal, verified it satisfies the Weyl relation (B), and pinned its normalisation by $\operatorname{tr}(W^\#)=-\operatorname{tr}(W^2)$, which is independent of the value being computed. I derived $c$ from the boundary equation and then confirmed the placement a second time by computing $F(cI+W)=\tfrac4{n-2}$ exactly, a route the record does not use. I re-derived the collapse term by term and found the residue empty. I evaluated both crossover polynomials at every integer $4\le n\le12$ at its own parity. **No falsifier appeared, and the two routes to the same integer threshold are genuinely independent**, one runs through $\theta_0(n)$ and the cone, the other through $\Theta_n$ and nothing else.

**Where a falsifier could still hide.** Not in the arithmetic, which is over-determined, but in H12: if *invariance $\Rightarrow G\le0$* failed at a boundary point of this kind, the cone clause of L44 would be unsupported while the elementary clause stood untouched. That is the single load the record has not discharged.

## Verdict

**HYPOTHESIS-DEBT.**

The lemma's conclusion is correct and I could not break it. Every computation in the block is right: the witness is critical at $\sqrt{3/2}$ at every $n\ge4$, the shifted operator sits on $\partial\Omega_0$ at the pinned $c$ and the Weyl tensor does not, the collapse to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$ leaves no residue, both crossover roots are as stated, and no integer separates them. The parity repair is right and load-bearing.

**What is owed, exactly.** *For $R_0\in\partial\Omega_0$ with $\operatorname{scal}(R_0)>0$, invariance of $\Omega_0$ under the Hamilton ODE implies $dF_{R_0}(\Phi(R_0))\le0$.* It is stated twice in [problem.md](../findings/problem.md) and proved neither time; the one justification the file gives, at [problem.md:70](../findings/problem.md#L70), constrains $\operatorname{scal}$ where the conclusion is about $F$, and was refuted by [r92](../reviews/REVIEW_r92.md) without being corrected; and the promised "two lines" appear on no canonical page. The debt is confined to the **cone** clause. L44's headline (that $n\ge12$ cannot be weakened), rests on the elementary route of [problem.md:217](../findings/problem.md#L217), which needs none of it and which I verified end to end.

**Repairs a maintainer would make, in order of size.**

1. Discharge H12, or cite [Xu](https://arxiv.org/abs/2412.13633) Proposition 2.2's iff, clearing its *closed* convex hypothesis against $\Omega_0$'s open $\operatorname{scal}>0$ clause first. Add Proposition 2.2 to [the Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md), which omit it.
2. Correct [problem.md:70](../findings/problem.md#L70), which still carries a reason [r92](../reviews/REVIEW_r92.md) refuted.
3. Delete "is the block's only step" at [problem.md:213](../findings/problem.md#L213); the same block names a second input two sentences later and runs a second, independent argument two paragraphs later.
4. Replace "a rational function of $n$" with a statement about $\theta_0(n)^2$, which is what is rational.
5. Restore the $\tfrac14$ to Conjecture 1 in [the Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md).
6. Say once, in both blocks, that $\Phi$ is [conventions.md](../findings/conventions.md)'s sense (ii) and is the same map as $Q$.
