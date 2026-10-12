# Review r89, the Böhm–Wilking cone bridge and the origin of $\theta_0(n)$

**No numerical checking was used anywhere in this review.** Every computation below is hand algebra or exact symbolic/rational algebra (sympy `Symbol`/`Rational`, integer and radical arithmetic only). No floating point, no sampling, no solvers, no optimisation. The two scratch scripts written for this review print exact rationals and symbolic expressions only.

Worked cold: the six claims were re-derived from [diss_beitz.txt](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) and [boehm-wilking-math0606187.txt](https://arxiv.org/abs/math/0606187) before [findings/problem.md](../findings/problem.md), [notes.md](../references/beitz-2018-bianchi-convexity/notes.md) or [b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py) were opened.

## Verdicts

| # | Claim | Verdict |
|---|---|---|
| 1 | The bridge: $F=\lVert R\rVert^2/\lVert\mathrm{ric}R\rVert^2$, $\Omega_a=F^{-1}((-\infty,\frac4{n-2+4a}])$, quotient-rule expansion | **CONFIRMED** |
| 2 | Cone endpoints and the $\lVert\mathrm{ric}\rVert^2$ identity | **CONFIRMED** |
| 3 | Beitz proved the degenerate ($a\to\frac n4$) end; $n\ge12$ enters nowhere | **CONFIRMED** (one wording caveat) |
| 4 | The collapse to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$ | **CONFIRMED** (the symmetry of $T$ is true, but is *not* load-bearing) |
| 5 | $\partial\Omega_0$ fixes $c(n-1)=\theta_0(n)$; the constant is derived, not posited | **CONFIRMED, the match is genuine, not reverse-engineered.** The premise that Beitz uses $\lVert I\rVert^2=n(n-1)$ is **REFUTED**: the thesis uses $\frac{n(n-1)}2$, the same value as the project |
| 6 | Scope: the full cone conjecture is strictly more than Conjecture A | **CONFIRMED**, with a sharpening the record does not state (odd $n$) |

Two defects found, one of them in a passage explicitly written to guard against exactly this error.

---

## 1. The bridge, CONFIRMED

The thesis defines, on $\mathrm{scal}^+=\{\mathrm{scal}(R)>0\}$,

$$F:\mathrm{scal}^+\to\mathbb R,\qquad F(R)=\frac{\lVert R\rVert^2}{\lVert\mathrm{ric}(R)\rVert^2}\qquad(6.24)$$

verbatim. And $\Omega_a=\{(\frac{n-2}4+a)\lVert R\rVert^2\le\lVert\mathrm{ric}R\rVert^2,\ \mathrm{scal}>0\}$ rearranges to $F\le\frac4{n-2+4a}$ on the domain of $F$, so $\Omega_a=F^{-1}((-\infty,\frac4{n-2+4a}])$. The thesis states this for $a>0$ only (it wants strictly convex cones); the set identity is nonetheless valid at $a=0$ too, since $\mathrm{scal}>0$ is already the domain of $F$. No issue.

The quotient rule, re-derived independently: with $N=\lVert R\rVert^2$, $D=\lVert\mathrm{ric}R\rVert^2$, both quadratic and $\mathrm{ric}$ linear,

$$dF_R(S)=\frac{2\langle R,S\rangle D-N\cdot2\langle\mathrm{ric}R,\mathrm{ric}S\rangle}{D^2}=\frac2{\lVert\mathrm{ric}R\rVert^2}\Big(\langle R,S\rangle-F(R)\langle\mathrm{ric}R,\mathrm{ric}S\rangle\Big),$$

which is exactly the thesis's (6.25). Since $\lVert\mathrm{ric}R\rVert^2>0$ throughout $\mathrm{scal}^+$, putting $S=\Phi(R)$ gives the equivalence

$$G(R)=dF_R(\Phi(R))\le0\iff\langle R,\Phi(R)\rangle\le F(R)\,\langle\mathrm{ric}R,\mathrm{ric}\Phi(R)\rangle$$

with no sign subtlety. The invariance mechanism is Lemma 2.3.4 (thesis p. 28), which gives both directions: sublevel sets invariant $\Rightarrow$ $dF_v(\Phi(v))\le0$ on the region, and conversely. Since $F\ge\frac2{n-1}$ on all of $\mathrm{scal}^+$ (that is what "$\Omega_a=\emptyset$ for $a>\frac n4$" says), every point of $\Omega_0$ lies on $\partial\Omega_a$ for exactly one $a\in[0,\frac n4]$, so the conjecture is *equivalent* to $G\le0$ on $\Omega_0$, and evaluating at any single point of $\Omega_0$ yields a necessary condition. The bridge is sound.

## 2. The cone endpoints, CONFIRMED

Remark 6.3.10 (printed p. 97) states, verbatim,

$$\frac{4a-n}4\lVert R_I\rVert^2+a\lVert R_{\mathrm{ric}_0}\rVert^2+\Big(\frac{n-2}4+a\Big)\lVert R_W\rVert^2\le0,$$

and then, verbatim: empty for $a>\frac n4$; $\Omega_{n/4}=\mathbb R_{>0}\cdot I$; and

$$\Omega_0=\Big\{R\ \Big|\ \tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2,\ \mathrm{tr}(R)>0\Big\}.$$

All four sub-claims are the thesis's own words. $R_{\mathrm{ric}_0}$ carries coefficient $a$, so it is indeed unconstrained at $a=0$.

The normalisation claim is right, and I re-derived it two ways. From the equivalence itself, subtracting the display from $(\frac{n-2}4+a)\lVert R\rVert^2\le\lVert\mathrm{ric}R\rVert^2$ with $\lVert R\rVert^2=\lVert R_I\rVert^2+\lVert R_{\mathrm{ric}_0}\rVert^2+\lVert R_W\rVert^2$, every $a$ cancels and

$$\lVert\mathrm{ric}(R)\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2 .$$

Independently, from the thesis's (1.3) and (1.4): $\tfrac{n-1}2\lVert R_I\rVert^2=\tfrac{n-1}2\cdot\tfrac2{n(n-1)}\mathrm{scal}^2=\tfrac{\mathrm{scal}^2}n$ and $\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2=\lVert\mathrm{ric}_0\rVert^2$, and $\tfrac{\mathrm{scal}^2}n+\lVert\mathrm{ric}_0\rVert^2=\lVert\mathrm{ric}\rVert^2$ is exactly (1.4). Consistent.

Citation slip (cosmetic): the record cites this as "thesis p. 96". The printed page header puts Remark 6.3.10 on p. 97.

## 3. Which end Beitz proved, CONFIRMED

Lemma 6.3.16 states invariance "for $a\in[\frac n4-\varepsilon,\frac n4]$", the ray end. Its Hessian, re-derived from the thesis's own pieces rather than copied:

- $\mathrm{Hess}_IF(S,S)=\frac2{\lVert\mathrm{ric}(I)\rVert^2}\big(\lVert S\rVert^2-\tfrac2{n-1}\lVert\mathrm{ric}S\rVert^2\big)$, with $\frac2{\lVert\mathrm{ric}(I)\rVert^2}=\frac8{n(n-1)^2}$;
- on $\langle W\rangle$: $\mathrm{ric}(R_W)=0$, giving $\frac8{n(n-1)^2}\lVert R_W\rVert^2$, the thesis's (6.30);
- on $\langle\mathrm{ric}_0\rangle$: $\mathrm{ric}(R_{\mathrm{ric}_0})=\mathrm{ric}_0(R)$ and (1.3) gives $\lVert\mathrm{ric}_0\rVert^2=\frac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$, so the bracket is $\lVert R_{\mathrm{ric}_0}\rVert^2\big(1-\frac{n-2}{2(n-1)}\big)=\frac n{2(n-1)}\lVert R_{\mathrm{ric}_0}\rVert^2$, yielding $\frac4{(n-1)^3}\lVert R_{\mathrm{ric}_0}\rVert^2$, the thesis's (6.31);
- $\mathrm{Hess}_IG=-2\,\mathrm{Hess}_IF(R_{\mathrm{ric}_0},\cdot)-2(n-1)\mathrm{Hess}_IF(R_W,\cdot)$, giving

$$\mathrm{Hess}_IG(R,R)=-\frac8{(n-1)^3}\lVert R_{\mathrm{ric}_0}\rVert^2-\frac{16}{n(n-1)}\lVert R_W\rVert^2 .$$

Both coefficients are strictly negative for every $n\ge3$, and $R_I$ (the scale direction) is exactly $I^\perp$'s complement, so $\mathrm{Hess}_IG$ is negative definite on $I^\perp$ for **every** $n$. **$n\ge12$ does not appear anywhere in Lemma 6.3.16 or its inputs.** The thesis uses $n\ge12$ only in Theorem 6.3.17 and Remark 6.3.18, where it is inherited as a hypothesis from the conjecture. The claim stands.

One wording caveat, worth a line in the record. "Invariance is trivial since $\Phi(I)=(n-1)I$" is true at the endpoint $a=\frac n4$ exactly, $\Phi(cI)=c^2(n-1)I$ stays on the ray. It is *not* true on the interval $[\frac n4-\varepsilon,\frac n4]$, which is a genuine (if local, and with non-explicit $\varepsilon$) result. The record's own body text gets this right ("a neighbourhood of the ray, by showing $I$ is a local maximum of $G$"); only the table cell overstates.

## 4. The collapse, CONFIRMED; the symmetry claim is true but not load-bearing

Ingredients, checked against the primary source:

- **(a)** BW08 Lemma 2.1: $R+R\#I=(n-1)R_I+\frac{n-2}2R_{\mathrm{Ric}_0}=\mathrm{Ric}\wedge\mathrm{id}$. Both the explicit statement that $\langle W\rangle$ lies in the kernel and the closed form $\mathrm{Ric}\wedge\mathrm{id}$ give $W+W\#I=0$. With $\Phi(A,B)=\frac12(AB+BA)+A\#B$ (the polarisation with $\Phi(R,R)=R^2+R^\#$), $\Phi(I,W)=W+W\#I=0$. **Correct.** Cross-check: Beitz's (6.29), $\frac d{ds}\big|_0\Phi(I+sR)=2(n-1)R_I+(n-2)R_{\mathrm{ric}_0}$, is $2\Phi(I,R)$ and agrees exactly.
- **(b)** BW08 eq. (6): $\mathrm{Ric}(R^2+R^\#)_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$ in an orthonormal eigenbasis of $\mathrm{Ric}$. For $W$ with $\mathrm{Ric}(W)=0$ every basis is an eigenbasis and the right side vanishes, so $\mathrm{Ric}(Q(W))=0$ and $Q(W)$ is again Weyl. **Correct.** There is a cheaper route the record already lists but does not use here: Beitz's Example 2.3.5 gives $\mathrm{scal}(R^2+R^\#)=2\lVert\mathrm{ric}R\rVert^2$, so $\langle I,Q(W)\rangle=\mathrm{tr}\,Q(W)=\mathrm{scal}(Q(W))=0$ directly, which is all step (c) actually needs.
- **(c)** With $R=cI+W$, bilinearity of $\Phi$ gives $\Phi(R)=c^2(n-1)I+2c\Phi(I,W)+Q(W)$, and

$$\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+\underbrace{2c^2\langle I,\Phi(I,W)\rangle+2c\langle W,\Phi(I,W)\rangle}_{=0\ \text{by (a)}}+\underbrace{c\langle I,Q(W)\rangle}_{=0\ \text{by (b)}}+\underbrace{c^2(n-1)\langle W,I\rangle}_{=0\ \text{by }\langle W\rangle\perp\langle I\rangle}+\langle W,Q(W)\rangle.$$

**The full symmetry of $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ is not needed for this.** Bilinearity plus $\Phi(A,B)=\Phi(B,A)$ (immediate from $A\#B=B\#A$ and $\frac12(AB+BA)$) plus (a) and (b) suffice. The record's flag that the symmetry is "load-bearing for step (c)" is a false alarm.

It is also true, and the primary source states it: BW08 eq. (5) defines $\mathrm{tri}(R_1,R_2,R_3)=\mathrm{tr}((R_1R_2+R_2R_1+2R_1\#R_2)R_3)=2\,\mathrm{tr}(\Phi(R_1,R_2)R_3)=2T(R_3,R_1,R_2)$ and reports Huisken's observation that it is symmetric in all three. I re-derived the proof: $\mathrm{tr}(R_1R_2R_3)+\mathrm{tr}(R_2R_1R_3)$ is fully symmetric for symmetric operators, and $\mathrm{tr}(2(R_1\#R_2)R_3)=\sum_{\alpha\beta\gamma}\langle[R_1b_\alpha,R_2b_\beta],R_3b_\gamma\rangle\langle[b_\alpha,b_\beta],b_\gamma\rangle$, a contraction of two totally antisymmetric structure tensors, is symmetric under every transposition. So the assumption is correct, just not required here.

- **(d)** On the same slice, $\mathrm{ric}R=c\,\mathrm{ric}(I)$ and $\mathrm{ric}\Phi(R)=c^2(n-1)\mathrm{ric}(I)$, so $\langle\mathrm{ric}R,\mathrm{ric}\Phi R\rangle=c^3(n-1)\lVert\mathrm{ric}I\rVert^2$ and $F(R)=\frac{c^2\lVert I\rVert^2+\lVert W\rVert^2}{c^2\lVert\mathrm{ric}I\rVert^2}$. Exact symbolic expansion with $\lVert\mathrm{ric}I\rVert^2$ held as a free symbol:

$$F(R)\langle\mathrm{ric}R,\mathrm{ric}\Phi R\rangle-\langle R,\Phi(R)\rangle=c(n-1)\lVert W\rVert^2-\langle W,Q(W)\rangle,$$

with $\lVert\mathrm{ric}I\rVert^2$ absent from the result and $\lVert I\rVert^2$ cancelling identically. So

$$G\le0\iff\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2 .$$

Note this step is *independent of the Ricci normalisation*: rescaling $\mathrm{ric}\mapsto\kappa\,\mathrm{ric}$ scales $F$ by $\kappa^{-2}$ and the pairing by $\kappa^2$. **CONFIRMED.**

## 5. The constant, the match is genuine; the record's "convention warning" is itself wrong

This is the claim I was asked to attack hardest, and it survives. The attack premise does not.

### The alleged discrepancy does not exist

[findings/problem.md](../findings/problem.md) says: *"Beitz uses $\lVert I\rVert^2=n(n-1)$ (thesis p. 93), differing by a factor $2$ and shifting the constant by $\sqrt2$."* [b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py) repeats it in its docstring.

**That is false.** Beitz uses $\lVert I\rVert^2=\frac{n(n-1)}2$, the project's value. The thesis has exactly one occurrence of $\lVert I\rVert^2$ (line 5531 of the extraction, printed p. 98), and the extracted text reads

```
For the identity I, we find that F (I) = n−12
                                              , since kIk2 = n(n−1)
                                                                2
and ric(I) = n−12
                   id.
```

The isolated `2` on the following line is a **fraction denominator that `pdftotext` dropped below the baseline**, not a factor. Three independent confirmations:

1. **Layout.** Compare the same page's $F(I)$, which appears again inside the proof of Lemma 6.3.13 as `2` on the line *above* `n−1`, i.e. `pdftotext` puts numerators above and denominators below. Here the `2` is below `n(n−1)`, so it is the denominator.
2. **The thesis's own constant.** Equation (6.26)/(6.28) evaluates $\frac2{\lVert\mathrm{ric}(I)\rVert^2}=\frac8{n(n-1)^2}$, so $\lVert\mathrm{ric}(I)\rVert^2=\frac{n(n-1)^2}4$. And $F(I)=\frac2{n-1}$ (forced anyway, since $\Omega_{n/4}=\mathbb R_{>0}I$ means $F(I)=\frac4{n-2+n}$). Hence $\lVert I\rVert^2=F(I)\lVert\mathrm{ric}(I)\rVert^2=\frac2{n-1}\cdot\frac{n(n-1)^2}4=\frac{n(n-1)}2$. **This is derived from a displayed constant elsewhere in the same proof and cannot be a transcription artefact.**
3. **Definition 1.1.10.** Beitz's $\mathrm{ric}$ carries an explicit factor $\frac12$ relative to [BW08] (she flags this herself in the sentence after the definition) so $\mathrm{ric}(I)=\frac{n-1}2\mathrm{id}$ (matching the extraction's `ric(I) = n−12 id`), giving $\lVert\mathrm{ric}(I)\rVert^2=\frac{(n-1)^2}4\cdot n$, consistent with 2.

And $\frac{n(n-1)}2$ is forced in the project's convention too, for the reason the record gives: [weyl.py](../scripts/weyl.py) and [curvature_operator.py](../scripts/curvature_operator.py) build $R$ as a matrix in the basis $\varphi_{ij}=E_{ij}-E_{ji}$, which is orthonormal for $\langle A,B\rangle=\frac12\mathrm{tr}(A^\top B)$ on $\mathfrak{so}(n)$; the operator inner product is then plain Frobenius on $N\times N$ matrices, so $\lVert I\rVert^2=N=\dim\Lambda^2=\frac{n(n-1)}2$. Both conventions agree. There is nothing to convert.

### The derivation, redone

$\partial\Omega_0$ on the slice: $\frac{n-2}n\lVert W\rVert^2=c^2\lVert I\rVert^2=c^2\frac{n(n-1)}2$, so with $\lVert W\rVert=1$, $c=\frac1n\sqrt{\frac{2(n-2)}{n-1}}$ (positive root; $\mathrm{scal}(R)=c\,\mathrm{tr}(I)>0$ forces $c>0$) and

$$c(n-1)=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

Exact symbolic check of the squares: $c^2(n-1)^2=\frac{2(n-2)(n-1)}{n^2}=\theta_0(n)^2$. **CONFIRMED.** (With the erroneous $\lVert I\rVert^2=n(n-1)$ one gets $\frac{(n-2)(n-1)}{n^2}=\frac{\theta_0^2}2$, confirming the $\sqrt2$ sensitivity the record warns about, the warning's *arithmetic* is right, its *attribution* is not.)

### Is the match reverse-engineered? No, and here is the independent check

The obvious suspicion is that $\lVert I\rVert^2=\frac{n(n-1)}2$ was chosen because it made $\theta_0$ appear. It was not, and the decisive evidence is that $\theta_0(n)$ is reproduced by a computation on the *other* side of the bridge, with no cone, no $F$, and no $\lVert I\rVert^2$ in it.

I computed the value of $\theta=\langle W,Q(W)\rangle/\lVert W\rVert^3$ on the Weyl part of a product of round spheres from scratch, in exact arithmetic. For a diagonal operator $W(e_i\wedge e_j)=w_{ij}e_i\wedge e_j$ with hollow symmetric $A=(w_{ij})$ and vanishing row sums (the Weyl condition), $(W^\#)_{ij}=\sum_kw_{ik}w_{kj}$, so $\langle W,Q(W)\rangle=\frac12\big(\sum_{i,j}w_{ij}^3+\mathrm{tr}(A^3)\big)$ and $\lVert W\rVert^2=\frac12\mathrm{tr}(A^2)$. For the $(p,q)$ block pattern the row-sum conditions $(p-1)\alpha+q\gamma=0$, $(q-1)\beta+p\gamma=0$ pin $A$ up to scale, its spectrum is $\{-\alpha^{(p-1)},-\beta^{(q-1)},-n\gamma,0\}$, and the whole thing collapses to

$$\theta(p,q)^2=\frac{2(n-1)}{n-2}\Big(1-\frac{n-1}{pq}\Big),\qquad n=p+q,$$

which depends only on $pq$ and is therefore maximal at the balanced split. At $p=q=m$, $n=2m$:

$$\theta^2=\frac{(m-1)(2m-1)}{m^2}=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2 .$$

**Exactly $\theta_0$, from an entirely disjoint computation.** An exact-rational census over all partitions of $n$ into parts $\ge2$ (all Einstein products of $k\ge2$ round spheres, $k$ arbitrary) confirms nothing beats it, and that the Weyl part of a two-block product is independent of the radii:

| $n$ | max over sphere products | $\theta_0(n)^2$ | attained by |
|---|---|---|---|
| 10 | $36/25$ | $36/25$ | $S^5\times S^5$ |
| 11 | $40/27$ | $180/121$ | $S^6\times S^5$ (strictly below) |
| 12 | $55/36$ | $55/36$ | $S^6\times S^6$ |
| 13 | $120/77$ | $264/169$ | $S^7\times S^6$ (strictly below) |

The cone criterion and the sphere product agree on the nose at even $n$. That is not something a fudged norm produces. **The constant is derived, and the derivation is honest.**

### The odd-$n$ observation, which the record does not state

For odd $n$ the best sphere product gives $\frac{2(n-1)(n-3)}{(n-2)(n+1)}<\theta_0(n)^2$ (the table's $40/27$ and $120/77$ are this formula at $n=11,13$). So:

- the $a=0$ cone criterion on the $R_{\mathrm{ric}_0}=0$ slice is **exactly** $P(W)\le\theta_0(n)\lVert W\rVert^3$ at every $n$;
- that bound is **sharp only for even $n$**. At odd $n$, "sphere products maximise $P$" is a *strictly stronger* statement than what cone invariance demands.

This matters for how the record should phrase the correspondence: cone invariance at $a=0$ pins the *bound*, and for even $n$ pins it sharply; the *identification of the maximiser* is extra content the cone conjecture never asks for.

## 6. Scope, CONFIRMED, with the above sharpening

The record's statement is the right characterisation and the unconstrained $R_{\mathrm{ric}_0}$ does **not** break the correspondence. The logic is one-directional and that direction is the sound one:

- Points with $R_{\mathrm{ric}_0}=0$ genuinely lie in $\partial\Omega_0$ (take $R=cI+W$ with $c^2\lVert I\rVert^2=\frac{n-2}n\lVert W\rVert^2$, $c>0$, so $\mathrm{scal}>0$). The slice is a bona fide sub-family of the boundary, so the criterion there is a **necessary** condition for the conjecture.
- Interior points of the slice ($c$ larger than the boundary value) give the *same* inequality with a *larger* right-hand side, i.e. strictly weaker. The boundary is the binding case, so nothing is lost and nothing is over-claimed by evaluating there. "Exactly" is justified.
- The remaining directions ($R_{\mathrm{ric}_0}\ne0$) impose further conditions that Conjecture A says nothing about. Hence "strictly more than Conjecture A", as stated.

**One internal inconsistency in the record.** [notes.md](../references/beitz-2018-bianchi-convexity/notes.md) closes with a "Correction to the record" asserting that the cone formulation and the $P(W)$-maximisation formulation "are the same statement". They are not, and [findings/problem.md](../findings/problem.md)'s own scope paragraph says so ("strictly more than Conjecture A"). The notes' correction overshoots its own evidence; it should say the cone criterion *contains* the $P(W)$ bound as its $R_{\mathrm{ric}_0}=0$ slice, which is what was actually shown.

Two smaller things in the same passage. "Weyl tensors are the extremal directions of the cone family" is heuristic, not literal: a pure Weyl tensor has $\mathrm{scal}=0$, so it lies outside $\mathrm{scal}^+$ and outside every $\Omega_a$, it is an asymptotic direction, and $\Omega_0$ explicitly caps $\lVert R_W\rVert^2\le\frac n{n-2}\lVert R_I\rVert^2$. And Remark 6.3.15 is on printed p. 99, not p. 100.

---

## What should change in the record

1. **Delete or invert the "Convention warning" paragraph** in [findings/problem.md](../findings/problem.md) and the matching docstring line in [b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py). Beitz and this project use the *same* $\lVert I\rVert^2=\frac{n(n-1)}2$; there is no factor-2 conversion to apply, and the paragraph as written invites a reader to "correct" a correct number. If a convention warning is wanted, the real one is that **Beitz's $\mathrm{ric}$ carries a factor $\frac12$ relative to [BW08]** (Definition 1.1.10, flagged by her in Remark 1.1.15), harmless in the final criterion, where it cancels between $F$ and the pairing, but load-bearing for anything quoting $\lVert\mathrm{ric}\rVert$ or $\mathrm{scal}$ across the two sources, including $\Omega_a$'s own defining inequality.
2. **Drop the claim that the symmetry of $T$ is load-bearing** for the cross-term step. It is true (BW08 eq. (5), Huisken) but the collapse needs only bilinearity, $\Phi(I,W)=0$, and $\mathrm{scal}(Q(W))=0$.
3. **Add the even/odd sharpness split.** The derived bound $\theta_0(n)$ is attained by $S^{n/2}\times S^{n/2}$ for even $n$ and is strictly above every sphere-product value for odd $n$. This strengthens the "derived, not posited" claim (an independent computation lands on the same constant) while correcting "exactly Conjecture A" to "exactly the Conjecture A bound, sharp at even $n$".
4. **Fix the page citations**: cone decomposition p. 97 (not 96), $\lVert I\rVert^2$ p. 98 (not 93), Remark 6.3.15 p. 99 (not 100).
5. **Soften the $a=\frac n4$ table cell.** Invariance is trivial *at* the ray; Lemma 6.3.16's interval $[\frac n4-\varepsilon,\frac n4]$ is a real local result with non-explicit $\varepsilon$.

Nothing found here touches the load-bearing conclusion: the bridge is correct, the collapse is correct, and $\theta_0(n)$ is a derived consequence of $a=0$ cone invariance rather than a constant read off the sphere products.
