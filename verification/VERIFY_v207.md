# VERIFY_v207, Lemma L13, the spectral-moment ceiling

**Cold read of [BRIEF_L13.md](BRIEF_L13.md), sections A–C, against [conventions.md](../findings/conventions.md), [curvature-invariants.md](../findings/curvature-invariants.md), [second-order.md](../findings/second-order.md), [results.md](../results.md), [ATTEMPTS.md](../ATTEMPTS.md), [INDEX-results.md](../findings/INDEX-results.md) and [L13.lean](../lean/HamiltonsCubic/Results/L13.lean). No numerical work of any kind was done: no script, no Sage, no Python, no floating-point evaluation. Every number below is exact rational arithmetic or a rational bracket on a square root, done by hand on an object constructed for the purpose, and reported as a screen. Log: [agent_logs/verify-L13-v207.log](../agent_logs/verify-L13-v207.log).**

## Claim table

| # | claim, as the record states it | verdict |
| --- | --- | --- |
| 1 | results.md's canonical entry for L13 | **STATES NOTHING**, heading plus proof pointer, no statement between them |
| 2 | The chain $\theta^2(1+k_0/4)\le\kappa_n$ from criticality alone | **PROVEN**, four lines, rebuilt below; uses no cap and no maximality |
| 3 | The ceiling $\theta\le2-o(1)$, "derived at every $n$" | **PROVEN at even $n\ge6$; HYPOTHESIS-DEBT at odd $n$ and at $n=4$** |
| 4 | The Peirce cap is used | **REFUTED**, the cap is stated and never used; the orbit-tangent *equality* is what the chain consumes |
| 5 | $\kappa_n=(n-1)(2n-1)/4$ | **PROVEN at even $n\ge6$; FITTED at odd $n$**, verified numerically at $n=4\ldots13$, derived analytically only from the balanced sphere product |
| 6 | Excess $58.9\times$ at $n=12$ under the denominator $(\text{bound}-\theta_0)/(\theta_0-\sqrt{3/2})$ | **CORRECT for the block's displayed level-2 chain**, bracketed at $58.919$ below |
| 7 | "$58.9$ is not a competing reading but an unreachable one … reaching $58.9$ needs $k_0\ge74>66$" | **BROKEN**, self-contradictory, and a botched substitution of the retired figure $49.7$ |
| 8 | The record's two figures $58.9$ (findings) and $49.7$ (ATTEMPTS.md) | **CONFLATED**, they are the level-2 and level-3 bounds, two different objects, and $74$ is the fictitious $k_0$ of the level-3 number |
| 9 | Asymptotic excess $3.09\times$ | **CORRECT**, bracketed in $(3.09,3.10)$; the level-2 and level-3 bounds coincide in the limit, which is why it matched |
| 10 | "Attained on a subspace of dimension **exactly** $\dim(O(n)\cdot u)$" | **REFUTED**, $18$ against $9$, $60$ against $21$, both reproduced in closed form below |
| 11 | Only "at least" is consumed downstream | **CONFIRMED**, the trace bound increases in the multiplicity |
| 12 | "Spectral moments of $L_u$ are the wrong invariants" | **OVERSTATED**, and the annotation's "BACKWARDS" is **overstated in the other direction** |
| 13 | "A hard ceiling that no refinement of it escapes" (results.md line 186) | **GAP**, universal claim, no witness; the record's own $18>15=\binom62$ shows the capped quantity is not the quantity a refinement must use |
| 14 | "The fourth moment reaches only $14\times$ even granting an oracle" | **GAP**, no argument on file; rests on an undisplayed level-3/level-4 grid search |
| 15 | "The figure is now $58.9\times$ throughout the record" | **FALSE**, [ATTEMPTS.md:663](../ATTEMPTS.md) still reads $49.7$, correctly, for a different bound |
| 16 | Symbols $B$, $u$, $\lambda$, $k_0$ | **UNDEFINED, and the annotation's own count is wrong**, $B$ is at least a *fifth* sense, and $u$ collides too |
| 17 | The excess formula's range | **UNSTATED AND LOAD-BEARING**, its denominator vanishes at $n=6+2\sqrt7$ and is negative below, so the formula is meaningless for $n\le11$ |

**Verdict: BROKEN.** The mathematical core is sound and short (a correct four-line inequality and a correct ceiling) but the block's headline number is attached to the wrong bound, the annotation that "settled" it contradicts itself inside three sentences, the canonical entry states nothing, and the constant the whole chain rests on is unproven at odd $n$, which the block's own $n\ge12$ range contains.

## 0. Conventions, fixed once

Quoted, not restated.

- $\theta$: "$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$", [conventions.md](../findings/conventions.md).
- $\theta_0(n)$: "**the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more.** *It is the value at the balanced sphere product **at even $n$ only**…*; the target of Problem P is $\Theta_n$", [conventions.md](../findings/conventions.md).
- $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$ ("$10$ at $n=4$, $84$ at $n=6$, $1638$ at $n=12$"), [conventions.md](../findings/conventions.md).
- $\kappa_n$: "**The algebra's Killing constant** is $\kappa_n=(2n-1)(n-1)/4$. It has appeared under two symbols inside one file.", [conventions.md](../findings/conventions.md). And the collision: "*This table's other $\kappa_n$ is the algebra's Killing constant … which is $63.25$ at $n=12$*", against [L17](../findings/route-a.md)'s penalty coefficient "$\kappa_n=9(\sqrt{3/2}-\theta_0(n))$, **negative exactly at $n\ge12$**".
- $B$: "**THE LETTER $B$ MEANS TWO THINGS, live**" and, separately, "$B=\tfrac\theta2\mathrm{Id}-L_W$ at a critical point … *This is a third object under the letter $B$ in this record*", and [L48](../findings/problem.md)'s "$B=\sum_af(n_a)-\tfrac n{8(n-1)}$, *a fourth or fifth object under that letter*".
- The polarisation, from [ATTEMPTS.md](../ATTEMPTS.md)'s setup: "With $B(X,Y)=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ the polarization of $Q$, define the self-adjoint multiplication operator $L_W(H)=B(W,H)$", matching [conventions.md](../findings/conventions.md)'s "$F_u(h)=\tfrac12(uh+hu)+u\#h$".
- The $\tfrac12$-inclusion, from [second-order.md](../findings/second-order.md): "**The $\tfrac12$-inclusion is proven, not measured.** Differentiating the equivariance $Q(gW)=gQ(W)$ along a one-parameter subgroup shows the orbit tangent lies in the $\tfrac12$-eigenspace at every critical point".

## 1. Hypothesis inventory

Everything the chain consumes, and where the block states it.

| # | hypothesis | stated in the block? | used? |
| --- | --- | --- | --- |
| H1 | $\mathcal W_n$ is $O(n)$-irreducible | no | yes, it is the whole proof that $\mathop{\mathrm{tr}}(L_xL_y)\propto\langle x,y\rangle$ |
| H2 | $Q$ is $O(n)$-equivariant | no | yes, gives the orbit-tangent eigenvalue |
| H3 | $L_u$ is self-adjoint | no | yes, needed to read the cap as an eigenvalue bound and to write $\mathop{\mathrm{tr}}(L_u^2)=\sum\mu_i^2$ |
| H4 | $u$ is critical: $Q(u)=\lambda u$ | "from criticality alone", yes | yes |
| H5 | $\lVert u\rVert=1$ | **no** | **yes**, without it the right side is $\kappa_n\lVert u\rVert^2$ and the inequality as printed is false by homogeneity |
| H6 | $\lambda>0$ | no | yes, separates the $\lambda$ and $\lambda/2$ eigenspaces, and orients the ceiling |
| H7 | $k_0=\dim(O(n)\cdot u)$ | **no**, $k_0$ appears in the inequality never having been defined | yes |
| H8 | $\kappa_n=(n-1)(2n-1)/4$ as a *closed form in $n$* | asserted | yes, and it is what carries the parity debt (§4) |
| H9 | $u$ is a **local maximum** | no | **no**, the Peirce cap is the only thing that needs it, and the cap is never used (§3) |
| H10 | $\mathop{\mathrm{tr}}(L_W)=0$ | yes | **no**, stated and consumed nowhere |
| H11 | $n\ge12$, for the excess figure's denominator to be positive | **no** | yes (§6) |

Two entries are the classic pair the brief names: H5 and H7 are steps used but never stated; H9 and H10 are stated but never used.

## 2. Section A, the canonical entry states nothing, and what it would have to say

[results.md](../results.md) lines 577–579 are, in full, a heading and a proof pointer:

```
##### Lemma L13, spectral-moment method

**Proof:** [curvature-invariants.md](findings/curvature-invariants.md)
```

The record's own rule for this, from the [L14](../findings/curvature-invariants.md) withdrawal four blocks above: "**A numbered result must state something a reader can check**". L13's canonical entry does not. It is the same defect L14 was withdrawn for, one degree worse, L14 at least named a quantity.

**The canonical statement, drawn from the argument as written**, is:

> **Lemma L13 (direct). The second-moment ceiling.** Let $n\ge5$, let $u\in\mathcal W_n$ satisfy $\lVert u\rVert=1$ and $Q(u)=\lambda u$ with $\lambda>0$, and let $k_0=\dim(O(n)\cdot u)$. Then
> $$\lambda^2\Big(1+\frac{k_0}4\Big)\le\kappa_n=\frac{(n-1)(2n-1)}4 .$$
> Since $k_0\le\binom n2$, no critical point yields from this inequality a bound better than
> $$\lambda^2\le\frac{2(n-1)(2n-1)}{n^2-n+8}\;<\;4,\qquad\text{which increases to }4,$$
> so the ceiling of the method is $\lambda\le2-o(1)$, against $\Theta_n<\sqrt2$.

That is checkable, and §3 proves it. Everything else in the block (the margins, the fourth moment, the "wrong invariants" diagnosis), is commentary of a different grade and belongs under different labels (§9).

## 3. The ceiling, derived, and the cap is not used

Four lines. Write $T(X,Y,Z)=\langle B(X,Y),Z\rangle$, totally symmetric because $B$ is the polarisation of the gradient of the cubic form $P$; hence $L_u$ is self-adjoint (H3).

**(a) $u$ is an eigenvector.** $L_uu=B(u,u)=Q(u)=\lambda u$. Criticality alone.

**(b) The orbit tangent is an eigenspace at $\lambda/2$.** Differentiate the equivariance $Q(gug^{-1})=gQ(u)g^{-1}$ at $g=I$ along $A\in\mathfrak{so}(n)$, writing $\rho(A)u=[\hat A,u]$:
$$DQ(u)[\rho(A)u]=2B(u,\rho(A)u)=2L_u(\rho(A)u),\qquad \rho(A)Q(u)=\lambda\,\rho(A)u,$$
so $L_uH=\tfrac\lambda2H$ for **every** orbit tangent $H$. This is [second-order.md](../findings/second-order.md)'s "$\tfrac12$-inclusion is proven, not measured", and it uses criticality and equivariance and nothing else. The orbit tangent is orthogonal to $u$, since $\langle[\hat A,u],u\rangle=0$ by skew-adjointness of $\mathrm{ad}\,\hat A$.

**(c) The trace.** $x\mapsto\mathop{\mathrm{tr}}(L_x^2)$ is an $O(n)$-invariant quadratic form on the irreducible module $\mathcal W_n$ (H1), hence a multiple of $\lVert x\rVert^2$, [second-order.md](../findings/second-order.md)'s "the left side is an invariant form on an irreducible module". So $\mathop{\mathrm{tr}}(L_u^2)=\kappa_n$ at $\lVert u\rVert=1$. Since $\lambda\ne\lambda/2$, the two eigenspaces of (a) and (b) are automatically orthogonal, and
$$\kappa_n=\sum_i\mu_i^2\;\ge\;\lambda^2+k_0\Big(\frac\lambda2\Big)^2=\lambda^2\Big(1+\frac{k_0}4\Big).$$

**(d) The ceiling.** $k_0\le\dim\mathfrak{so}(n)=\binom n2$, so the best value the inequality can return is
$$\lambda^2\le\frac{(n-1)(2n-1)/4}{1+n(n-1)/8}=\frac{2(n-1)(2n-1)}{n^2-n+8}.$$
$4(n^2-n+8)-2(n-1)(2n-1)=2n+30>0$, so the right side is strictly below $4$ at every $n$ and increases to $4$. Hence $\lambda\le2-o(1)$. At $n=12$ it is exactly $\tfrac{506}{140}=\tfrac{253}{70}$, matching [L13.lean](../lean/HamiltonsCubic/Results/L13.lean)'s `ceiling_at_cap`.

**Is the Peirce cap used? No.** The cap is the *upper* bound $\langle L_uH,H\rangle\le\tfrac\lambda2\lVert H\rVert^2$ on $u^\perp$. Step (c) is a *lower* bound on a sum of squares; an upper bound on eigenvalues contributes nothing to it. What (c) consumes is the *equality* of step (b). The annotation in section C is right on this point, and it matters twice over: the cap is the one ingredient that requires **local maximality** rather than criticality, so the block's "from criticality alone" is correct precisely because the clause it puts in the same sentence is inert.

*What that costs: the block advertises as its input a fact it does not use, and omits from its input list the fact it does use (H2, H3, H5, H7). A reader auditing the sentence as written cannot reconstruct the proof.*

## 4. $\kappa_n$, proven at even $n\ge6$, fitted at odd $n$, and the $n\ge12$ range contains odd $n$

Three separate statuses live under one formula, and the block prints only the formula.

- **Proportionality, $\mathop{\mathrm{tr}}(L_xL_y)=\kappa_n\langle x,y\rangle$: proven at every $n$**, by Schur on the irreducible module. [second-order.md](../findings/second-order.md) states the argument in one line and marks the pair of identities "**Gate 2 landed**".
- **The closed form's origin: a fit.** [second-order.md](../findings/second-order.md): "*It was first fitted to those four points and then checked at them, which is no derivation*". [ATTEMPTS.md](../ATTEMPTS.md): "$\kappa_W=(2n-1)(n-1)/4$ **fitted** from $n=5,6,8,9,10$". [nondegeneracy.md](../findings/nondegeneracy.md): "**$\kappa_F(n)=\frac{(2n-1)(n-1)}4$ is not Fox's**: his Remark 1.4 leaves $\kappa$ uncomputed above $\dim V=4$, and the closed form is a fit".
- **The derivation that exists is even-$n$ only.** [second-order.md](../findings/second-order.md): "*two Gate 2 reviewers independently supplied the real one at every even $n$, by summing the six recorded Peirce families to $\sum\lambda^2=m^2(4m-1)/(4(m-1))$*". Screened: with $n=2m$, $\theta_0(n)^2=\frac{2(2m-1)(2m-2)}{4m^2}=\frac{(2m-1)(m-1)}{m^2}$, so
$$\kappa_n=\theta_0^2\sum\lambda^2=\frac{(2m-1)(m-1)}{m^2}\cdot\frac{m^2(4m-1)}{4(m-1)}=\frac{(2m-1)(4m-1)}4=\frac{(n-1)(2n-1)}4 .$$
Exact. **And the input is the balanced sphere product, which exists only at even $n$**, that, and nothing about the argument's shape, is the whole parity restriction. [nondegeneracy.md](../findings/nondegeneracy.md) adds that the same row list "carries a negative dimension of $-3$" at $m=2$, which is why the range starts at $n\ge6$.
- **The derivation's independence is itself disputed on the record.** [second-order.md](../findings/second-order.md): "*Whether this is genuine corroboration or circular is disputed and unresolved, one reviewer holds the six families independently derived from the Casimir, the other holds both sides to descend from the same eigensolver runs*."

**The parity split bites exactly where the brief says it does.** The block's ceiling is asserted at every $n$ and the block's range of interest is $n\ge12$, which contains $13,15,17,\dots$. At those $n$ the closed form is a numerical fit (checked to $n=13$, per [second-order.md](../findings/second-order.md)'s "exact across $n=4\ldots13$", and unchecked above). **So the ceiling is a Lemma at even $n\ge6$ and an Observation at odd $n\le13$ and a Conjecture at odd $n\ge15$**, and the section-C annotation, which calls the ceiling "a **Lemma**, derived at every $n$" *in the same sentence* as it calls $\kappa_n$ "proven at **even $n\ge6$ only**", contradicts itself: the ceiling consumes $\kappa_n$.

**The annotation's proposed closure is the one the record already refused.** It offers "one analytic lemma, $\kappa_n\dim\mathcal W_n=\lVert T\rVert^2$ … one contraction and no run". [second-order.md](../findings/second-order.md) records that identity and its status: "**It is a corollary of the second identity, not an independent route** … So it restates the constant rather than proving it, and $\lVert T\rVert^2$ inherits the closed form … rather than supplying it. **A proof still requires evaluating $\lVert T\rVert^2$ directly** as a contraction of the $\mathfrak{so}(n)$ structure constants against the Weyl projector, the route is real, but it is that computation, not this identity." The identity is one line from Schur, sum $\mathop{\mathrm{tr}}(L_{e_i}^2)=\kappa_n$ over an orthonormal basis, and settles nothing. **The debt is the direct evaluation of $\lVert T\rVert^2$, and "no run" is exactly what it cannot be.**

`HYPOTHESIS-DEBT`, stated precisely: *prove $\sum_{i,j,k}T(e_i,e_j,e_k)^2=\frac{(2n-1)(n-1)}{4}\cdot\frac{n(n-3)(n+1)(n+2)}{12}$ at odd $n$, by contraction of the $\mathfrak{so}(n)$ structure constants against the Weyl projector.*

## 5. The margin, the block's number is right for the block's bound, and wrong for the record's

### 5.1 What the number is a ratio of

Not a multiplicative excess. Under the denominator the annotation names,
$$R(n)=\frac{\text{bound}(n)-\theta_0(n)}{\theta_0(n)-\sqrt{3/2}},$$
it is *the distance from the method's ceiling down to the conjectured optimum, measured in units of the gap between the two rival maximisers*, $\theta_0(n)$ against the padded $W_{\mathbb{CP}^2}$'s $\sqrt{3/2}$. The plain multiplicative excess at $n=12$ is $1.9011/1.2360=1.538$, i.e. $1.54\times$; [ELIM-bounds.md](../reviews/ELIM-bounds.md) reads it against $\sqrt2$ and gets $1.34\times$. **"An excess of $58.9\times$" reads as the first and is the third.** The denominator is a fact about the two competitors, not about the method.

### 5.2 The exact bracket, at $n=12$

Screened by hand, exact rational bounds on squares, no root taken:

| quantity | value | bracket |
| --- | --- | --- |
| bound$^2$ | $253/70$ | $1.90112<\text{bound}<1.90113$, since $1.90112^2=3.61425\ldots<253/70=3.6142857\ldots<1.90113^2$ |
| $\theta_0(12)^2$ | $55/36$ | $1.236033<\theta_0<1.236034$ |
| $3/2$ |, | $1.224744<\sqrt{3/2}<1.224745$ |

Denominator $\theta_0-\sqrt{3/2}\in(0.011288,0.011290)$, which is [problem.md](../findings/problem.md)'s independently recorded "*width $0.011$ at $n=12$ … between $0.0112$ and $0.0113$*", the same number, so the two blocks do turn on one quantity as it says. Numerator $\in(0.665093,0.665096)$. Hence
$$R(12)\in(58.91,\,58.93),$$
rounding to $\mathbf{58.9}$. **The block's printed figure is correct for the block's displayed inequality.** [L13.lean](../lean/HamiltonsCubic/Results/L13.lean)'s `excess_at_twelve` proves the weaker $(58,59)$ from the same brackets, consistently.

Asymptotically, bound $\to2$ and $\theta_0\to\sqrt2$, giving $(2-\sqrt2)/(\sqrt2-\sqrt{3/2})$: with $1.4142135<\sqrt2<1.4142136$ this is between $0.5857864/0.1894692$ and $0.5857865/0.1894690$, i.e. in $(3.091,3.092)$, so strictly inside $(3.09,3.10)$. **Correct.**

### 5.3 The number is a pole, not a characterisation

Under the same formula and the same level-2 bound:

| $n$ | $\theta_0(n)$ | bound $=\sqrt{2(n-1)(2n-1)/(n^2-n+8)}$ | $R(n)$ |
| --- | --- | --- | --- |
| $12$ | $1.236033$ | $1.901128$ | $58.9$ |
| $14$ | $1.261680$ | $1.922170$ | $17.9$ |
| $20$ | $1.307670$ | $1.954380$ | $7.80$ |
| $100$ | $1.392983$ | $1.994190$ | $3.57$ |
| $\infty$ | $\sqrt2$ | $2$ | $3.09$ |

The denominator $\theta_0(n)-\sqrt{3/2}$ vanishes at $2(n-1)(n-2)/n^2=3/2$, i.e. $n^2-12n+8=0$, i.e. $n=6+2\sqrt7=11.2915\ldots$, the record's own crossover. **So $R$ has a pole just below $n=12$ and $58.9$ is large chiefly because $n=12$ is the first admissible dimension above it.** The block prints $58.9$ and $3.09$ side by side as though they characterised the method at two scales; they are two points on either side of a divergence. And for $n\le11$ the denominator is *negative*, so the excess formula returns a negative number and is meaningless, an unstated range condition (H11) on the block's headline figure.

### 5.4 The conflation, $58.9$ and $49.7$ are two different bounds, and $k_0=74$ is the tell

[ATTEMPTS.md](../ATTEMPTS.md)'s table, which is the block's source, reads

```
| n   | θ₀(n)   | gap*    | best bound | excess / gap* |
| 12  | 1.23603 | 0.01129 | 1.7974     | 49.7          |
| 14  | 1.26168 | 0.03694 | 1.8308     | 15.4          |
| 20  | 1.30767 | 0.08292 | 1.8856     | 7.0           |
| 100 | 1.39298 | 0.16824 | 1.9705     | 3.4           |
| ∞   | √2      | √2−√1.5 | 2          | 3.09          |
```

Screened: every row reproduces from the same denominator, $(1.7974-1.23603)/0.01129=49.72$, $(1.8308-1.26168)/0.03694=15.41$, $(1.8856-1.30767)/0.08292=6.97$, $(1.9705-1.39298)/0.16824=3.43$. So the table is internally coherent and the denominator reading is settled beyond doubt.

**But its "best bound" column is not the block's inequality.** At $n=12$ the level-2 chain with $k_0=\binom{12}2=66$ gives $1.901128$; the table gives $1.7974$. The table's column is the **level-3 bound**, the one using $\mathop{\mathrm{tr}}(L_W^3)$ as well, obtained by grid search, which [ATTEMPTS.md](../ATTEMPTS.md) describes as "level 3 sees it only at $O(n)$ scale" and which the block never displays. The section-C annotation names this correctly, "*The margins are **measured** at $n=12,14,20,100$ by grid search on a level-3 bound this block never displays*", and then fails to draw the consequence.

The consequence is the defect. Solve the level-2 formula for the $k_0$ that would reproduce the level-3 number: $\lambda=1.7974\Rightarrow\lambda^2=3.23065\Rightarrow1+k_0/4=63.25/3.23065=19.578\Rightarrow k_0=74.3$. **That is where $74$ comes from.** It is the fictitious orbit dimension you need to fake a level-3 bound inside a level-2 formula, and [L13.lean](../lean/HamiltonsCubic/Results/L13.lean) says so in as many words: "*Reaching `49.7` needs `λ ≤ 1.7971`, hence … **`k₀ ≥ 74`***".

So the record's two figures are both right, about different bounds:

| figure | bound it belongs to | where it stands |
| --- | --- | --- |
| $58.9\times$ | level 2, the block's displayed $\lambda^2(1+k_0/4)\le\kappa_n$ at $k_0=\binom n2$ | [results.md](../results.md), [curvature-invariants.md](../findings/curvature-invariants.md), [fence-posts.md](../findings/fence-posts.md), [INDEX-traps.md](../findings/INDEX-traps.md), [LEDGER.md](../findings/LEDGER.md) |
| $49.7\times$ | level 3, grid search, never displayed | [ATTEMPTS.md](../ATTEMPTS.md) |

And the substitution that installed $58.9$ ran over the annotation's *exclusion* clause too, where $49.7$ was the term being **refuted**. The result reads:

> "**Applied at $n=12$ that same formula gives strictly between $58$ and $59$** … And $58.9$ is not a competing reading but an unreachable one … so reaching $58.9$ needs $k_0\ge74>66$ … **The figure is now $58.9\times$ throughout the record.**"

which asserts, in three consecutive sentences, that the figure is in $(58,59)$, that $58.9$ is unreachable, and that the figure is $58.9$.

**Discrepancy protocol, all three cleared.**
1. *Located exactly*: [curvature-invariants.md](../findings/curvature-invariants.md) line 72, the sentence beginning "And $58.9$ is not a competing reading".
2. *Failure exhibited in closed form*: at $k_0=66$ the block's own inequality gives $\lambda^2\le253/70$ and $R(12)\in(58.91,58.93)$, §5.2, so $58.9$ is the rounded value **at** the admissible maximum, not above it. The threshold $74$ is exactly $63.25/1.7974^2-1$ scaled by $4$, i.e. the level-3 number's pseudo-$k_0$.
3. *Opposite argued*: could "unreachable" be salvaged? Only in the vacuous sense that $58.9<58.919$, so exact equality with $58.9$ needs $k_0=66.016$, a fraction of a unit above the cap, not $74$. Under that charitable reading the sentence's own quantifier "$k_0\ge74$" is still false, and its conclusion "no critical point produces it" contradicts the sentence before. There is no reading on which it stands.

**Not withdrawn. Confirmed defect.**

*And "the figure is now $58.9\times$ throughout the record" is false*: [ATTEMPTS.md](../ATTEMPTS.md) still carries $49.7$, correctly. The record now holds two numbers for "the excess at $n=12$" with nothing distinguishing the bounds they measure.

## 6. The refuted clause, and what is consumed downstream

**The clause.** "*a Peirce cap at $\lambda/2$ on $u^\perp$ attained on a subspace of dimension **exactly** $\dim(O(n)\cdot u)$*".

**Refuted, and both witnesses reproduce in closed form.** [second-order.md](../findings/second-order.md): "The multiplicity can exceed the orbit dimension ($18$ against $9$ at $S^3\times S^3$, and $60$ against $21$ at $S^2\times S^3\times S^3$) but the inclusion itself is a theorem." Screened, from the isotropy alone, with no numerics:

- $S^3\times S^3$ at $n=6$: $\dim(O(6)\cdot W)=\binom62-\dim(\mathfrak{so}(3)\oplus\mathfrak{so}(3))=15-3-3=9$. ✔
- $S^2\times S^3\times S^3$ at $n=8$: $\binom82-\dim(\mathfrak{so}(2)\oplus\mathfrak{so}(3)\oplus\mathfrak{so}(3))=28-1-3-3=21$. ✔
- The block's own $W^*$ at $n=12$, for control: $66-15-15=36$, which is [ATTEMPTS.md](../ATTEMPTS.md)'s "$36$ for $W^*$ at $n=12$". ✔

The multiplicities $18$ and $60$ are the record's own data ([second-order.md](../findings/second-order.md), three independent places for the $18$). **REFUTED.**

**And "at least" is what is consumed, confirmed twice.** Structurally: step 3(c) is $\sum\mu_i^2\ge\lambda^2+m(\lambda/2)^2$, monotone increasing in $m$, so any lower bound on $m$ serves and $m\ge k_0$ suffices. Textually, [second-order.md](../findings/second-order.md): "$\lambda=\tfrac12$ on **at least** the orbit tangent … Both multiplicities can exceed those floors … **which is harmless for the bound, since it uses them only as lower bounds and the expression increases in each.**" **CONFIRMED, and harmless.**

**The sting the annotation misses.** At $S^3\times S^3$, $\mathrm{mult}(\lambda/2)=18>15=\binom62$. **The multiplicity is not bounded by $\binom n2$, but the ceiling's step (d) is.** So the ceiling caps only those refinements that lower-bound the multiplicity by the *orbit dimension*; a refinement lower-bounding the multiplicity directly is not covered. That is precisely §8's falsifier.

## 7. Completeness, what the moments determine, and what the ceiling actually closes

Section B says "the wrong invariant for this problem". Section C says that is BACKWARDS. **Both overstate, and the true statement is neither.**

**The annotation's half is true and vacuous.** At a local maximum, [L24](../findings/second-order.md) gives every eigenvalue on $u^\perp$ at $\le\lambda/2<\lambda$, so $\lambda=\lambda_{\max}(L_u)$; the full moment sequence $\{\mathop{\mathrm{tr}}(L_u^k)\}_{k\ge1}$ determines the spectrum with multiplicity, hence the characteristic polynomial, hence $\lambda$. **True.** But knowing the full moment sequence of $L_u$ is knowing $L_u$ up to conjugacy, which is knowing the answer; it is a statement about an oracle, not about a method. Note also that this half *does* need local maximality (the cap), which the ceiling does not, so the annotation's own two headline claims rest on different hypotheses.

**What is actually available.** The record holds exactly three universal moment identities ([ATTEMPTS.md](../ATTEMPTS.md), [second-order.md](../findings/second-order.md)), and [second-order.md](../findings/second-order.md) records that no fourth exists and that "orders $k\ge2$ were never available". With $a=\langle W^2,W\rangle$, $b=\langle W^\#W,W\rangle$ and $\theta=a+b$:
$$m_1=0,\qquad m_2=\kappa_n\ \text{(constant on the unit sphere)},\qquad m_3=-\tfrac{5n-1}8a+\tfrac{n(n-5)}8b .$$
$m_1$ and $m_2$ are constants and separate nothing. $m_3$ and $\theta$ are two linear functionals of $(a,b)$; they are proportional iff $-\frac{5n-1}8=\frac{n(n-5)}8$, i.e. $n^2=1$. **So at every $n\ge4$ they are independent, and the three available moments leave $\theta$ with one free parameter.**

**That is the precise, defensible sense of "wrong invariant", and it is the only one that survives:**

> The universal spectral moments of $L_W$ available in closed form do not determine $\theta$: the first two are constants on the unit sphere of $\mathcal W_n$, and the third is a functional of $(a,b)$ linearly independent of $\theta$. Combined with the orbit-dimension floor on $\mathrm{mult}(\theta/2)$ they yield at best $\theta\le2-o(1)$, against $\Theta_n<\sqrt2$.

**What does NOT survive:** "spectral moments of $L_u$ are simply the wrong invariants for this problem" as an unqualified claim (the annotation is right that it is refuted by the full sequence), and "the moments are complete invariants for $\theta$" as a claim with method content (it is an oracle statement). The block's own diagnosis "$\mathop{\mathrm{tr}}(L_W^2)$ is constant in $W$, so it carries no information beyond the norm" is **PROVEN** and is the one thing here of theorem grade, and it is a statement about *one* moment, exactly as the annotation says.

**What the ceiling closes:** the family of bounds of the form "second moment, plus a lower bound on $\mathrm{mult}(\theta/2)$ by the orbit dimension". Nothing wider. The record already knows what would be needed and that it is circular, [second-order.md](../findings/second-order.md): "*What the method would need is a lower bound on $\mathop{\mathrm{mult}}(\tfrac12)$, which is equivalent to Conjecture A itself.*"

**The landscape claim is a `GAP`.** [results.md](../results.md) line 186 says "the method has a hard ceiling that **no refinement of it escapes**". No proof of that universal quantifier is on file. What is proved is a ceiling for one inequality. The $14\times$ fourth-moment figure offered as evidence for the wider claim is itself an unbacked number (§8), and [ATTEMPTS.md](../ATTEMPTS.md)'s own confidence note grades the level-4 assessment "**Moderate** … reported as a recommendation rather than a theorem".

**And the annotation's "the reason recorded for closing it was a stronger claim than the evidence" is corroborated where it says it is.** [second-order.md](../findings/second-order.md) carries "**DOWNGRADED to a heuristic, and it is the FOURTH telling of [fence post F6](../findings/fence-posts.md)**", and the theorem-grade replacement ("*What survives is a scale statement, and it needs no counting*"), sits in the same file, unlinked from the L13 block. **CONFIRMED.**

## 8. The traps, each answered by name

- **$\ker W\ne0$ and padded objects.** No effect on the chain: $L_u$ is defined on all of $\mathcal W_n$ and step 3 never touches $\ker W\subset\Lambda^2$. But padding bites the *interpretation*: the padded $W_{\mathbb{CP}^2}$ has isotropy $\mathfrak u(2)\oplus\mathfrak{so}(n-4)$, so $k_0=\binom n2-4-\binom{n-4}2=4n-14$, [ATTEMPTS.md](../ATTEMPTS.md)'s own value, $34$ at $n=12$. The inequality there returns $\lambda^2\le63.25/9.5=6.658$, i.e. $\lambda\le2.58$, and at the balanced product ($k_0=36$) $\lambda\le2.515$. **At every critical point the record actually holds, the bound is far worse than $1.901$.** The $1.901$ figure requires $k_0=66$, i.e. a critical point with finite stabiliser, of which the record has no witness. The block never says this. It does not break the ceiling (a ceiling correctly takes the best case) but it makes "$58.9\times$ short at $n=12$" a statement about a hypothetical point rather than about anything on file.
- **The smallest admissible $n$.** $\mathcal W_n\ne0$ needs $n\ge4$. Step 3(c) needs $O(n)$-irreducibility, which holds at $n=4$ (though [second-order.md](../findings/second-order.md) records the $SO(4)$ commutant as $2$, so the argument must be run over $O(n)$ and the block never says which group). $\kappa_4=21/4$ is anchored to Fox's own $n=4$ value, so the constant is safe there; the *excess formula* is not (next item).
- **Odd $n$.** §4. The load-bearing failure, and it sits inside the block's own $n\ge12$ range.
- **The crossover $n=6+2\sqrt7$.** §5.3. $\theta_0(n)=\sqrt{3/2}$ there, so the excess formula's denominator vanishes at $n=11.2915\ldots$ and is negative below. The formula is undefined for $n\le11$ and near-singular at $n=12$. **Unstated, and it is the entire reason the headline number is large.**
- **Proved on a subfamily, used in general.** The parity split (§4) is exactly this: $\kappa_n$ derived from the balanced sphere product, which exists only at even $n$, then used at all $n$.
- **A hypothesis stated but never used.** $\mathop{\mathrm{tr}}(L_W)=0$ (H10), and the Peirce cap itself (H9), the block's headline ingredient is inert in its own chain.
- **A step using a hypothesis never stated.** $\lVert u\rVert=1$ (H5), without it the printed inequality is false by homogeneity, since the right side scales as $\lVert u\rVert^2$ and the left as $\lambda^2\sim\lVert u\rVert^4$. Also $k_0$'s definition (H7), self-adjointness (H3), equivariance (H2).
- **A universal claim with no witness.** "no refinement of it escapes" (§7), and "attained … exactly" (§6, refuted with two witnesses).
- **An imported theorem whose hypotheses were never checked, the unital-algebra death.** **This one is clean.** The trace identities are attributed to [Fox 2019](../references/fox-2019-nonassociative-curvature-algebra/notes.md) Theorem 1.3, but [second-order.md](../findings/second-order.md) re-derives both from $O(n)$-irreducibility in two lines and does not lean on the import; and the constant is explicitly *not* Fox's ("his Remark 1.4 leaves $\kappa$ uncomputed above $\dim V=4$"). No unital hypothesis enters. Checked, passes.
- **Symbol collisions.** Below.

### Symbols, read in the right sense, and where the block gets it wrong

| symbol | the block's sense | the record's senses | verdict |
| --- | --- | --- | --- |
| $B$ | the polarisation $B(X,Y)=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, defined only in [ATTEMPTS.md](../ATTEMPTS.md) | (i) Killing form $(n-2)\mathop{\mathrm{tr}}(XY)$; (ii) [sym3-blocks](../findings/sym3-blocks.md)'s $-\tfrac12\mathop{\mathrm{tr}}(XY)$; (iii) $B=\tfrac\theta2\mathrm{Id}-L_W$; (iv) [L48](../findings/problem.md)'s partition scalar | **at least a fifth sense.** The annotation's "a fourth sense" undercounts. Worse, sense (iii) is *built from $L_W$*, so a reader resolving "$L_u\colon H\mapsto B(u,H)$" against [conventions.md](../findings/conventions.md) gets either a type error (that $B$ takes one argument) or a circle |
| $u$ | a unit critical point | [conventions.md](../findings/conventions.md)'s $\Pi$ row: "the orbit **acceleration** $u$ satisfies $\langle u,W\rangle=-\lVert z\rVert^2$, so $u\notin W^\perp$" | **collides, and the annotation does not flag it.** The two senses are orthogonality-incompatible: the block's $u$ *is* the base point, the record's $u$ is a vector at it |
| $\lambda$ | the record's $\theta$ | a $\Lambda^2$ eigenvalue ($\lambda_\alpha$ in the $g_k$ row); and an Einstein constant inside [L47](../findings/problem.md)'s citation | **the annotation is right**, and the collision is three-way, not two |
| $k_0$ | $\dim(O(n)\cdot u)$ | undefined anywhere | **appears in the displayed inequality having never been introduced** |
| $\kappa_n$ | $(n-1)(2n-1)/4$ | also [L17](../findings/route-a.md)'s penalty coefficient, $-0.1016$ at $n=12$ | the block is safe (it writes the formula out), but it inherits a collision [conventions.md](../findings/conventions.md) calls "same letter, same subscript, opposite sign, a factor of six hundred" |
| $\theta_0$, $\Theta_n$ | never written; the excess figure silently divides by $\theta_0(12)-\sqrt{3/2}$ | $\theta_0$ is the closed form, $\Theta_n$ the actual sphere-product value, equal only at even $n$ | **the block's headline number rests on a symbol it never names** |

## 9. What pieces the block contains, and each one's label

Decided independently of the annotation, under the record's literal rule, `Lemma` asserts a proof, `Observation` asserts numerical verification at the dimensions named, `Conjecture` a candidate. **I count four pieces, not three.**

| piece | statement | label I assign |
| --- | --- | --- |
| **1** | $\lambda^2(1+k_0/4)\le\kappa_n$ at every unit critical point, and $\lambda^2\le\kappa_n/(1+\binom n2/4)$ as the method's best case | **Lemma**, at every $n\ge4$, §3 is a complete proof, independent of $\kappa_n$'s value |
| **2** | $\kappa_n=(n-1)(2n-1)/4$ | **Lemma at even $n\ge6$**; **Observation at $n=4,5,7,9,11,13$** (verified, [second-order.md](../findings/second-order.md)); **Conjecture at odd $n\ge15$** |
| **3** | The numerical ceiling $\lambda\le2-o(1)$, and the margins $58.9\times$ at $n=12$, $3.09\times$ asymptotically | **Corollary** of 1 and 2, hence carrying 2's parity status; the two figures are exact under a denominator the block must state, and must be labelled *level 2* to separate them from [ATTEMPTS.md](../ATTEMPTS.md)'s $49.7$ |
| **4** | "Spectral moments of $L_u$ are the wrong invariants"; "no refinement escapes"; "the fourth moment reaches only $14\times$" | **not a numbered result.** The survivable core, that $\mathop{\mathrm{tr}}(L_W^2)$ is constant, and that the three available moments leave $\theta$ underdetermined, is a **Lemma** (§7); the universal quantifier and the $14\times$ are `GAP` |

The block as it stands carries all four under the single word **Lemma**, and [INDEX-results.md](../findings/INDEX-results.md) records the row as "Lemma | **Gate 2: REFUTED as stated**", which is the correct current status and is not reflected in [results.md](../results.md)'s empty entry.

## 10. What would falsify it, and what I did to look for it

**The object.** For **piece 1**: a unit critical point $u\in\mathcal W_n$, $Q(u)=\lambda u$, $\lambda>0$, with $\lambda^2(1+k_0/4)>\kappa_n$ where $k_0=\dim(O(n)\cdot u)$. Such a point cannot exist, because §3 derives the inequality from criticality, equivariance and Schur with no further input; a witness would have to break one of those, i.e. exhibit a reducible $\mathcal W_n$ or a non-equivariant $Q$. **None found, and none can be.**

For **piece 3 read as "no refinement escapes"**: a critical point at which $\mathrm{mult}(\lambda/2)>\binom n2$, since the ceiling's step (d) caps only the orbit dimension while step (c) is monotone in the true multiplicity. **This object exists and is on the record.** $S^3\times S^3$ at $n=6$: $\mathrm{mult}=18$ against $\binom62=15$. The refined bound there is $\lambda^2\le\frac{55/4}{1+18/4}=\frac{55}{22}=\frac52$, i.e. $\lambda\le1.5811$, strictly better than the ceiling's $\lambda\le\sqrt{55/19}=1.7014$. So the ceiling bounds a *particular* relaxation and not the method; it does not license the words "no refinement of it escapes".

**What I did to look for it.** Read [second-order.md](../findings/second-order.md)'s three independent records of the $S^3\times S^3$ multiplicity and its $S^2\times S^3\times S^3$ companion; reconstructed both orbit dimensions in closed form from the isotropy algebras; checked [ATTEMPTS.md](../ATTEMPTS.md)'s $36$ at $n=12$ and $4n-14$ for the competitor family as controls; read [nondegeneracy.md](../findings/nondegeneracy.md) on $\kappa_F$'s provenance, [algebra.md](../findings/algebra.md)'s boxed constant, [L13.lean](../lean/HamiltonsCubic/Results/L13.lean) in full, and every occurrence of $58.9$ and $49.7$ in the repository outside `reviews/` and `verification/`; screened all six margin figures and the ceiling formula in exact rational arithmetic by hand. **No script was run, no numerical evaluation was performed, and no search or sweep was opened.**

## Verdict

**BROKEN.**

The core is small, correct and worth keeping: the inequality of §3, the constancy of the second moment, and the ceiling as a statement about one relaxation. What is broken is everything wrapped around it.

- The canonical entry in [results.md](../results.md) **states no result at all**, the defect [L14](../findings/curvature-invariants.md) was withdrawn for.
- The annotation that "settled" the margin asserts in three consecutive sentences that the figure lies in $(58,59)$, that $58.9$ is unreachable, and that the figure is $58.9$, a botched substitution of the retired $49.7$ through a clause where $49.7$ was the term being refuted.
- The record now carries **two figures for one phrase**: $58.9$ (level 2, findings) and $49.7$ (level 3, [ATTEMPTS.md](../ATTEMPTS.md)), with nothing saying they measure different bounds; $k_0=74$ is the fingerprint of the confusion.
- The headline figure's denominator has a **pole at $n=6+2\sqrt7$** and is negative below it, and the block names neither the denominator nor the range.
- $\kappa_n$ is **unproven at odd $n$**, and the block's own range $n\ge12$ contains odd $n$; the closure the annotation proposes is the one [second-order.md](../findings/second-order.md) already recorded as a restatement.
- "No refinement of it escapes" is a **universal claim with no witness**, and the record's own $18>15$ shows the capped quantity is not the quantity a refinement must use.

**Owed, in order:** (i) write the statement of §2 into [results.md](../results.md); (ii) strike the "unreachable" clause and replace it with the level-2 / level-3 distinction of §5.4; (iii) name the denominator and the range $n\ge12$ beside the figure; (iv) discharge the odd-$n$ debt of §4 by evaluating $\lVert T\rVert^2$ directly; (v) replace "the wrong invariants" and "no refinement escapes" with the three-moment statement of §7.
