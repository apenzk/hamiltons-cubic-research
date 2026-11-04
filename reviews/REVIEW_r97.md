# Review r97, four claims about cubic invariants of algebraic Weyl tensors

Reviewer 97, cold brief, independent implementation. All code in [scripts/reviewers/r97/](../scripts/reviewers/r97/); log at [agent_logs/reviewer97.log](../agent_logs/reviewer97.log). Nothing under [scripts/](../scripts/) was imported or read.

## Verdicts

| Claim | Verdict |
|---|---|
| A, $\alpha=8\mathop{\mathrm{tr}}(M^3)$, $\beta=2\langle M^\#,M\rangle$ | **CONFIRMED** (and stronger than stated) |
| B, $\theta=\tfrac32\mathop{\mathrm{tr}}(M^3)-\tfrac12\mathop{\mathrm{tr}}(\mathring W^3)$, $\mathop{\mathrm{tr}}(\mathring W^2)=3\|M\|_F^2$ | **CONFIRMED**, sign as written, in Li's $iklj$ order |
| C, $\beta=\tfrac12\alpha$ as a trilinear form iff $n\le5$; constant $-64$ | **CONFIRMED**, and the constant is exactly $-64$ |
| D, [findings/fence-posts.md](../findings/fence-posts.md) post F2g is wrong at $n=5$ | **CONFIRMED**, 2g's conclusion is false, by a witness inside 2g's own framework |

## Method and sample adequacy

$\mathcal W_n$ was built from scratch: parametrise symmetric $M$ over the $\binom n2$ pairs, impose first Bianchi ($n^4$ rows) and $\sum_k W_{ikjk}=0$ ($n^2$ rows), take the SVD nullspace. Dimensions came out $10,35,84,168,300$ at $n=4,\dots,8$, matching $n(n+1)(n+2)(n-3)/12$ exactly; residuals of all four symmetry families $<2\times10^{-14}$.

Spanning check as requested: coefficient matrices of $120$–$600$ random samples had **rank equal to $\dim\mathcal W_n$ at every $n=4,\dots,8$** (10/10, 35/35, 84/84, 168/168, 300/300). No deficient sample anywhere in this review.

Structure constants $c_{abc}=\langle[\phi_a,\phi_b],\phi_c\rangle$ were extracted directly from matrix commutators of $\phi_{ij}=E_{ij}-E_{ji}$; the resulting $c$ is totally antisymmetric, and $M^\#$ used the brief's $\tfrac12$ normalisation verbatim.

## Claim A, CONFIRMED, and it needs less than claimed

$\max|\alpha-8\mathop{\mathrm{tr}}M^3|$ and $\max|\beta-2\langle M^\#,M\rangle|$ were $\le7\times10^{-16}$ at every $n=4,\dots,8$ over $25$ unit-norm samples each.

The stronger fact: **neither identity uses the Bianchi identity or trace-freeness.** Feeding a generic symmetric $M$ over pairs (no Bianchi, no trace condition) through the same code gives both residuals $<5\times10^{-16}$ at $n=4,5,6,7$. Both are consequences of pair symmetry alone, so Claim A holds on all of $S^2(\Lambda^2)$, not merely on $\mathcal W_n$. For $\alpha$ this is one line, summing $t,p$ and $s,q$ and $k,l$ over ordered pairs is $2^3$ times the sum over $i<j$, giving $8\mathop{\mathrm{tr}}(M^3)$ directly. Recording the wider hypothesis is worth doing: it means Claim A survives any later relaxation of the trace-free convention.

## Claim B, CONFIRMED, sign verified independently

Built $\mathring W$ from Li's (2.2) in the stated $iklj$ order on an orthonormal basis of $S^2_0$ (off-diagonals $ (E_{ij}+E_{ji})/\sqrt2$, plus a Gram–Schmidt traceless diagonal set), dimension $(n-1)(n+2)/2$ confirmed as $9,14,20,27,35$. The operator matrix is symmetric to $10^{-10}$.

Over 12 unit-norm samples per dimension, $n=4,\dots,8$:

- $\max\bigl|\theta-\bigl(\tfrac32\mathop{\mathrm{tr}}M^3-\tfrac12\mathop{\mathrm{tr}}\mathring W^3\bigr)\bigr| \le 3.4\times10^{-16}$
- $\max|\mathop{\mathrm{tr}}\mathring W^2-3|\le1.8\times10^{-15}$ (and $\mathop{\mathrm{tr}}\mathring W^2/\|M\|_F^2=3.000000$ at $\|M\|_F=2.7$, so the quadratic statement is scale-correct)

**The sign is right and it is load-bearing.** The opposite order gives $\mathring W_{ikjl}=-\mathring W_{iklj}$ exactly, so $\mathop{\mathrm{tr}}\mathring W^3$ flips; at a sample $n=6$ point the correct order gives $0.0562257371$ against $\theta=0.0562257371$, while the flipped order gives $-0.0399370901$. Anyone using $ikjl$ gets a wrong $\theta$, not a wrong sign convention that cancels.

**On the Dai–Fu specialisation.** The specialisation is legitimate, and (more usefully), it does not have to be trusted. I verified $\mathop{\mathrm{tr}}\mathring R^3=-\beta+\tfrac18\alpha$ *directly* on algebraic $\mathcal W_n$ at $n=4,\dots,8$ (max residual $10^{-15}$), so the $s=0$ instance of Lemma 3.3 is established here independently of Dai–Fu's setting. As to whether the lemma smuggles in a differential hypothesis: the Einstein condition it assumes is pointwise algebraic ($\mathrm{Ric}=\tfrac sn g$), and the identity is a contraction identity at a point. Schur's lemma making $s$ constant is a consequence of the differential setting, not an input to the algebra. Nothing differential is used.

**Named points all check out** (all with $\|M\|_F=1$, all verified to satisfy Bianchi and trace-freeness before use):

| point | $\theta$ | Claim B RHS | $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$ |
|---|---|---|---|
| $S^2\times S^2$, $n=4$ | 0.866025404 | 0.866025404 | 0.866025404 |
| $S^3\times S^3$, $n=6$ | 1.054092553 | 1.054092553 | 1.054092553 |
| $S^4\times S^4$, $n=8$ | 1.145643924 | 1.145643924 | 1.145643924 |
| $S^5\times S^5$, $n=10$ | 1.200000000 | 1.200000000 | 1.200000000 |
| $\mathbb{CP}^2$, $n=4$ | 1.224744871 | 1.224744871 | $\sqrt{3/2}=1.224744871$ |

Unbalanced products were checked too ($S^2\!\times\!S^3$, $S^2\!\times\!S^4$, $S^3\!\times\!S^4$, $S^4\!\times\!S^5$): Claim B holds at all of them, and each sits strictly below $\theta_0(n)$, as it should if the balanced product is the vertex.

## Claim C, CONFIRMED, including "only $n\le5$" and the constant $-64$

**Diagonal.** $\max|\beta-\tfrac12\alpha|$ over 15 unit-norm samples: $1.1\times10^{-15}$ at $n=4$, $1.3\times10^{-15}$ at $n=5$, then $2.3\times10^{-1}$ at $n=6$, $1.8\times10^{-1}$ at $n=7$, $1.4\times10^{-1}$ at $n=8$, against $|\alpha|$ of order $0.3$, so the failure is $O(1)$ relative, not numerical noise.

**Trilinear.** Tested on three *independently drawn* $X,Y,Z\in\mathcal W_n$, both the raw contraction and the full $6$-term symmetrisation. Residuals $\le4.7\times10^{-16}$ at $n=4,5$ and $\ge4\times10^{-2}$ at $n=6,7,8$. Worth recording: at $n\le5$ the identity holds **already in the raw, unsymmetrised form** $\beta(X,Y,Z)=\tfrac12\alpha(X,Y,Z)$, stronger than the claim, which only asserts equality of the symmetrised forms.

**The Kronecker constant.** I expanded $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ as $\sum_{\pi\in S_6}\mathop{\mathrm{sgn}}(\pi)\prod\delta$, giving $720$ signed six-index contractions of $W\otimes W\otimes W$, and evaluated it directly. Result at $n=6,7,8,9$: ratio to $\beta-\tfrac\alpha2$ is $-64.00000000$ at every sample, to eight digits. At $n=4,5$ both sides vanish identically. **The constant $-64$ is confirmed independently.**

The mechanism is sound as stated: the order-$6$ generalised Kronecker delta is the determinant of a $6\times6$ matrix of $\delta$'s with indices in $\{1,\dots,n\}$, hence identically zero when $n\le5$; with the constant $-64$ verified at $n\ge6$, $\beta=\tfrac\alpha2$ on $\mathcal W_n$ for $n\le5$ follows. Necessity ("only $n\le5$") is the numerical half and is established by the $n=6,7,8$ failures above.

## Claim D, CONFIRMED. Post F2g's arithmetic is right; its conclusion is false

I reproduced **every row of post F2g's collapse-space table** with my own code, the dimension of $\{(T,\kappa):\sum_{\alpha<\beta<\gamma}T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma=\kappa\,e_3$ on the constrained $\lambda$-space$\}$:

| $\lambda$-space | 2g | r97 |
|---|---|---|
| $N=6$, one global | 1 of 20 | 1 of 20 |
| $N=6$, two ($3{+}3$) | 7 of 20 | 7 of 20 |
| $N=6$, three ($2{+}2{+}2$) | 14 of 20 | 14 of 20 |
| $N=7$, one global | 1 of 35 | 1 of 35 |
| $N=7$, two ($3{+}4$) | 10 of 35 | 10 of 35 |
| $N=9$, three ($3{+}3{+}3$) | 38 of 84 | 38 of 84 |
| $N=10$, one global ($n=5$) |, | **1 of 120** |
| $N=15$, one global ($n=6$) |, | **1 of 455** |

So the linear algebra is correct, and so is "with a single trace condition the collapse space is one-dimensional, $T$ constant". So is "constant $T$ is never realised".

**And the conclusion drawn from them is still false at $n=5$.** Take a generic $W\in\mathcal W_5$, diagonalise $M$ on $\Lambda^2\mathbb R^5$ ($N=10$), and form $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$ in that eigenframe. Two samples:

| | $T_{\min}$ | $T_{\max}$ | mean | std | $S/e_3$ |
|---|---|---|---|---|---|
| $n=5$, sample 1 | 0 | 0.6717 | 0.08333 | 0.1271 | **2.000000** |
| $n=5$, sample 2 | 0 | 0.8051 | 0.08333 | 0.1350 | **2.000000** |
| $n=6$, sample 1 | 0 | 0.5062 | 0.04396 | 0.0655 | 5.462384 |
| $n=6$, sample 2 | 0 | 0.7323 | 0.04396 | 0.0750 | 1.911756 |

($S:=\sum_{\alpha<\beta<\gamma}T\lambda\lambda\lambda$; the identity $\theta=p_3+3S$ was verified to $3\times10^{-16}$ at each point, and $\sum T=\binom n3$ frame-independently, so the mean is $\binom n3/\binom I3=1/12$ at $n=5$, 2g's own predicted constant value.)

At $n=5$ the realised $T$ has standard deviation $1.5\times$ its mean and ranges over $[0,0.67]$ (as far from constant as 2g says it must be), **and $S/e_3$ is nevertheless exactly $2$, i.e. $\theta=3\mathop{\mathrm{tr}}M^3$, i.e. the collapse happens.** At $n=6$ the same ratio wanders with $W$ (5.46, then 1.91), and there is no collapse.

**Where the argument breaks.** 2g asks: for which $T$ does $\sum T\lambda\lambda\lambda=\kappa e_3$ hold *for all* $\lambda$ in the traceless hyperplane? That is a polynomial identity with $T$ held fixed. What collapse actually requires is that the scalar equation hold at the *single* $\lambda(W)$ that comes attached to $T(W)$. As $W$ ranges over $\mathcal W_n$, the pair $(\lambda,T)$ traces a subvariety of $\{e_1=0\}\times\{$realisable $T\}$, and at $n=5$ that subvariety lies inside $\{S=2e_3\}$ without $T$ being constant. 2g quantifies over a product where only a graph is available.

The reason the gap has room to hide is that 2g's accounting sees $\lambda$ only. It reads off "one trace condition" from the $O(n)$-irreducibility of $\mathrm{Weyl}_n$ and stops. But the Bianchi identity is a constraint on the **frame relative to $\lambda$**, not on $\lambda$: traceless symmetric operators on $\Lambda^2\mathbb R^5$ form a $54$-dimensional space while $\dim\mathcal W_5=35$, so $19$ conditions are being discarded, exactly the ones that could tie $T$ to $\lambda$. The two-summand story at $n=4$ works only because there the extra conditions happen to be expressible as a second linear condition on $\lambda$.

**Repairable or false?** The conclusion is false and no repair preserves it. What 2g proves is the strictly weaker, correct statement: *constant $T$ is the only $\lambda$-uniform mechanism for collapse.* That statement decides no dimension at all, because collapse at $n\le5$ is not $\lambda$-uniform. The reducibility-of-$\mathrm{Weyl}_n$ story must be withdrawn as "the corrected reason $n=4$ is special": $n=4$ is not special for the cubic, $n\le5$ is, and the reason is the vanishing of $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ (Claim C), which is a fence-post at $6>n$, not at the irreducibility of a module.

Note also that the header of 2g inherits post F2f's ill-posedness complaint in reverse: 2f was criticised for "silently supplying a quantifier that the conclusion asserts"; 2g supplies the opposite over-strong quantifier and reaches a false conclusion by it.

## Corrections to the record

1. **Post F2g must be marked REFUTED** in [findings/fence-posts.md](../findings/fence-posts.md), with the $n=5$ witness above. Its table survives; its conclusion, and its claim to be "the corrected reason $n=4$ is special", do not.
2. **The collapse threshold is $n\le5$, not $n=4$.** Anything downstream that treats $n=5$ as non-spectral needs rechecking.
3. **Claim A can be stated on all of $S^2(\Lambda^2)$**, Bianchi and trace-freeness are not used by either half.
4. **Claim C holds unsymmetrised**, $\beta(X,Y,Z)=\tfrac12\alpha(X,Y,Z)$ for independent $X,Y,Z\in\mathcal W_{n\le5}$, before any symmetrisation.
5. **Claim B's index order must be written $iklj$ wherever $\mathring W$ appears**; the $ikjl$ order produces a numerically different $\theta$, not an equivalent convention.


---

## Synthesis carried in REVIEW.md

### Reviewer 97: the bi-spectral identity, the dictionary, and the $n\le5$ syzygy

Full report: [reviews/REVIEW_r97.md](reviews/REVIEW_r97.md). Own nullspace construction of $\mathcal W_n$; dimensions $10,35,84,168,300$ at $n=4$–$8$ match $n(n+1)(n+2)(n-3)/12$, and the sample rank equalled $\dim\mathcal W_n$ at every $n$ over 120–600 samples, so no verdict rests on a deficient sample.

| Claim | Verdict |
|---|---|
| $\alpha=8\mathop{\mathrm{tr}}(M^3)$, $\beta=2\langle M^\#,M\rangle$ | **CONFIRMED**, and stronger than stated, it holds on all of $S^2(\Lambda^2)$, with Bianchi and trace-freeness unused |
| $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$, Li's convention | **CONFIRMED**; the sign is right and the index order is not an equivalent convention |
| $\beta=\tfrac12\alpha$ for $n\le5$ only; the constant $-64$ | **CONFIRMED**, including unsymmetrised, and $-64.00000000$ at $n=6,7,8,9$ from a direct $720$-term $S_6$ expansion |
| Post F2g is false at $n=5$ | **CONFIRMED** |

**What it cost, and it is the substantive part.** 97 reproduced *every row* of post F2g's collapse table exactly ($1/20$, $7/20$, $14/20$, $1/35$, $10/35$, $38/84$) so the linear algebra was never in question; the conclusion drawn from it was. At $n=5$ the realised eigenframe $T$ has standard deviation $0.127$ about mean $\tfrac1{12}$ and range $[0,0.67]$ (as non-constant as 2g requires) and the cubic collapses anyway, $S/e_3=2.000000$. **The gap is a quantifier and it is not repairable**: 2g asks which fixed $T$ satisfies the collapse for *all* traceless $\lambda$, whereas collapse needs it only at the single $\lambda(W)$ attached to $T(W)$. Bianchi constrains the frame *relative to* $\lambda$, $54$ dimensions of traceless operators on $\Lambda^2\mathbb R^5$ against $\dim\mathcal W_5=35$, so nineteen conditions are discarded. What 2g proves is the weaker true statement that constant $T$ is the only $\lambda$-uniform mechanism, which decides no dimension at all.

**Also established:** Dai–Fu's Lemma 3.3 needs no differential hypothesis, verified directly on algebraic $\mathcal W_n$ at $n=4$–$8$ to $10^{-15}$, so the $s=0$ specialisation is legitimate. Named points match to nine digits.
