### Reviewer 306: the disconnected lemma, the $C_5$-edge family, and the diagonal-only cushion

**Verdicts.**

| | claim | verdict |
|---|---|---|
| **K1** | a scaled direct sum of diagonal critical points is critical with $\theta=(\sum\theta_i^{-2})^{-1/2}$, and **every** disconnected diagonal critical point with $\theta>0$ has $\lambda_{\max}\ge\theta$ and fails second-order maximality, with the violating eigenvector written down | **REFUTED as stated**, the construction is right (and is already on the record twice, in a stronger form), the consequence is false at padded points, and the eigenvector as written is not in $e^\perp$. The repaired statement is confirmed and is an instance of Krasnov–Tkachev's "1 simple" |
| **K2** | the twenty $C_5$-edge directions are constant-Rayleigh at $\tfrac23$, not an eigenspace, with $\lVert r\rVert=1/(3\sqrt2)$ for every unit $u$ | **CONFIRMED**, and sharpened: the residual Gram is exactly $\tfrac1{18}I_{20}$, so the constancy is an identity rather than a coincidence |
| **K3** | the factor-two cushion for V3 is diagonal-only; the $n=8$ non-diagonal witness has $\theta=1.088948$, $\lambda_{\max}=0.608885$, and refutes $\Delta>0\Rightarrow\lambda_{\max}\ge\theta$ off the locus | **CONFIRMED** on substance (every witness number reproduced to the digit), with two corrections: the quoted ratio $0.5592$ is in a different normalisation from the census statistic it is compared against, and the census floor is $1.025$, not $1.0417$ |

**No refutation of V3 was found.** An independent diagonal census at $n=6,7,8,9,10,12$ ($315$ critical points with $\theta>0$, $282$ of them with $\Delta>0$), puts every one at $\lambda_{\max}(L_e)\ge1.025$. And the prize as the brief describes it is *unreachable on the diagonal locus*, for a reason proved below rather than measured: the diagonal locus is an $L_W$-invariant subspace of $\mathrm{Weyl}_n$, so the full $\lambda_{\max}$ is never below the diagonal one, and no diagonal $\Delta>0$ point on record comes within a factor of two of $\tfrac12$.

---

#### Method, and the gates it passed before any claim was tested

Everything below runs on an implementation written from the definitions, importing nothing under audit. Code in [scripts/reviewers/r306/](../scripts/reviewers/r306/), run [r306_k1.py](../scripts/reviewers/r306/r306_k1.py) first to build the pool, then the battery, the padded counterexample, [r306_k2.py](../scripts/reviewers/r306/r306_k2.py) and [r306_diagcensus.py](../scripts/reviewers/r306/r306_diagcensus.py); log at [agent_logs/r306-disconnected.log](../agent_logs/r306-disconnected.log). The Lie-algebra square is built from the structure constants $c_{\alpha\beta\gamma}=\langle[b_\alpha,b_\beta],b_\gamma\rangle$ of $\mathfrak{so}(n)$ in the orthonormal pair basis, and its one free normalisation is fixed by the record's own diagonal anchor $Q(W)_{ab}=M_{ab}^2+\sum_kM_{ak}M_{bk}$. $\mathrm{Weyl}_n$ is the joint nullspace of the first Bianchi identity and Ricci-flatness in pair coordinates.

Gates, none of them tuned:

- $\dim\mathrm{Weyl}_n=n(n+1)(n+2)(n-3)/12$ at $n=5,\dots,10$: $35$, $84$, $168$, $300$, $495$, $770$.
- $\theta_0(6)=1.054092553$, $\theta(\mathbb{CP}^2)=1.224744871=\sqrt{3/2}$, $\theta(C_5\text{ blow-up})=0.670820393$.
- $\Delta=12.000000$ at the $C_5$ blow-up, $0$ at every sphere product, $1.512231$ at the $n=8$ witness, the record's numbers on the first attempt, which leaves the normalisation no freedom.
- The whole lossiness table of [diagonal-half.md](../findings/diagonal-half.md) reproduced independently: diagonal/full $\lambda_{\max}$ at $S^2\!\times\!S^3$ $0.25/0.75$, $S^2\!\times\!S^4$ $0.333/0.667$, $S^2\!\times\!S^6$ $0.4/0.6$, $S^3\!\times\!S^5$ $0.375/0.5$, $S^4\!\times\!S^4$ $0.333/0.5$.
- $L_W$ preserves the diagonal locus **exactly** (off-diagonal mass identically $0$, at random *non-critical* diagonal $W$ as well) and the pair-diagonal of $W\circ H$ equals $\mathrm{hollow}(M\circ N+\tfrac12\{M,N\})$ to $6\times10^{-16}$. Diagonal $W$ lies in $\mathrm{Weyl}_n$ with mass $1.8\times10^{-15}$ outside it.

---

### K1, REFUTED as stated

#### The construction is right, and the derivation is one line

Writing $M=\bigoplus_ic_iM_i$ over disjoint index blocks, every product in $\Phi(M)=M\circ M+M^2$ is block-local, so block $i$ of $\Phi$ is $c_i^2\big(\theta_iM_i+\mathrm{diag}(s^i)\big)$ while the required right-hand side is $\theta c_iM_i+\mathrm{diag}(c_i^2s^i)$. The diagonal matches for free and the off-diagonal forces $c_i\theta_i=\theta$; unit norm then gives $\sum c_i^2=1$, i.e. $\theta^2\sum\theta_i^{-2}=1$. Cross-block entries vanish on both sides because $M_{ak}M_{kb}$ needs $k$ in two blocks at once.

Tested over $205$ direct sums drawn from a pool of $21$ **connected** diagonal critical points, the sphere products $S^2\!\times\!S^2$ through $S^4\!\times\!S^4$, the $C_5$ blow-up at $n=10$, and twelve solved non-sphere points at $n=5,\dots,8$ carrying $\theta=0.0870$, $0.0934$, $0.0946$, $0.1619$, $0.1629$, $0.2775$, $0.3086$, $0.4629$, $0.5557$, $0.6455$, $0.6794$, $0.6814$, with two, three and four summands, unequal block sizes, and totals to $n=25$:

- worst criticality residual of the scaled sum: $3.5\times10^{-14}$;
- worst $\lvert\theta-(\sum\theta_i^{-2})^{-1/2}\rvert$: $3.3\times10^{-16}$;
- worst $\lVert\mathcal LN-\theta N\rVert_\infty/\max\lvert N\rvert$ for the component-indicator: $1.4\times10^{-13}$;
- equal scaling gives residuals up to $1.7\times10^{-1}$ and drops to $10^{-16}$ exactly when the summands share a $\theta$, the record's $7\times10^{-3}$ is one value in that range rather than a bound.

**The "diagonal" qualifier is unnecessary, and dropping it costs nothing.** In the algebra language the hypothesis is $W_1\circ W_2=0$: then $L_W W_i=c_i\theta_iW_i=\theta W_i$ and both summands are $\theta$-eigenvectors, with no coordinates anywhere in the argument. Checked in the full space at $n=8$: a *rotated* $S^2\!\times\!S^2$ (off-diagonal mass $0.371$) summed with a diagonal one gives criticality $1.2\times10^{-16}$, $\theta$ on the predicted value, and $\lambda_{\max}(L_e\vert_{e^\perp})=4/3$; $W_{\mathbb{CP}^2}\oplus W_{\mathbb{CP}^2}$ gives $\theta=0.86602540$ and $\lambda_{\max}=1.000000000$; $W_{\mathbb{CP}^2}\oplus S^2\!\times\!S^2$ gives $\theta=0.70710678$ and $\lambda_{\max}=1.000000000$.

#### And none of that is new, it is on the record twice, in a stronger form

[nondegeneracy.md](../findings/nondegeneracy.md) already carries the whole thing: *"criticality forces $\theta=a\theta_A=b\theta_B$ and with $a^2+b^2=1$, $1/\theta^2=\sum1/\theta_i^2$"*, verified at twenty-five held-out block sums with three and four blocks, unequal dimensions, scattered coordinates and ambient padding. It states the sign caveat this cycle's version omits, $\lvert\theta\rvert<\min_i\lvert\theta_i\rvert$, with $(+\mathrm{Fox})\oplus(-\mathrm{Fox})$ as the witness, and it already identifies the correct hypothesis as $W_A\circ W_B=0$ rather than coordinate-disjointness. [target.md](../findings/target.md) quotes the same law as the reason no direct sum can climb above the threshold. So the `Searched: none` trailer on commit `a8b0597` missed a recorded lemma two files away, and the new statement is the recorded one restricted to a special case.

*One completeness gap in both versions.* $c_i\theta_i=\theta$ is sign-blind, so $\theta=-(\sum\theta_i^{-2})^{-1/2}$ is an equally valid solution; the displayed formula gives the magnitude, and the positive branch has to be chosen, not derived.

#### The consequence is false as written, padded points

The record derives liveness from *"$\dim\ker M$ is the number of connected components"*, and concludes that at **every** disconnected point the family delivers a *non-radial* admissible $N$. It does not. A component with no edges, an isolated vertex, i.e. padding, contributes nothing to $N_{ij}=2M_{ij}(a_i+a_j)$, so the family collapses onto the radial direction and produces no test vector at all.

| point | $n$ | components | $\dim\ker M$ | $\theta$ | diagonal $\lambda_{\max}$ | full $\lambda_{\max}$ |
|---|---|---|---|---|---|---|
| $S^3\!\times\!S^3$ + $1$ isolated vertex | $7$ | $2$ | $2$ | $1.054093$ | $0.600000$ | $0.600000$ |
| $S^3\!\times\!S^4$ + $1$ isolated vertex | $8$ | $2$ | $2$ | $1.095445$ | $0.583333$ | $0.583333$ |
| $S^4\!\times\!S^4$ + $1$ isolated vertex | $9$ | $2$ | $2$ | $1.145644$ | $0.571429$ | $0.571429$ |
| $S^2\!\times\!S^2$ + $3$ isolated vertices | $7$ | $4$ | $4$ | $0.866025$ | $0.666667$ |, |

Each row is disconnected by the record's own criterion, has $\theta>0$, and has $\lambda_{\max}$ well below $\theta$, $0.571\theta$ at the $n=9$ row. The indicator $N$ the lemma writes down has $\cos(N,M)=+1.000000$ at every padded point tested, which is the refutation in one number: it is the radial direction. Three of the rows refute the claim in the full space as well as on the locus; $S^2\!\times\!S^2$ padded reaches $1$ in the full space, but through directions the lemma does not name. The claim "$\lambda_{\max}\ge\theta$ at every disconnected diagonal critical point with $\theta>0$" is therefore false, and so is the "non-radial" clause it rests on. *These points do still fail Lemma L24*, at $0.57$–$0.67$ against $\tfrac12$, but for a different reason and with a margin of $1.14$–$1.33\times$ rather than $2\times$, so the failure is not the one the lemma asserts. [nondegeneracy.md](../findings/nondegeneracy.md) states the correct scope in advance: *"Padding is not covered by any of this ... it is the $b=0$ degenerate case and the law says nothing about it."* The new lemma contradicts that warning.

**The repair is exact, because the structure theorem is exact.** If $M$ is block-diagonal over its components and critical, then each nonzero block is $c_iN_i$ with $N_i$ critical of unit norm and $c_i\theta_i=\theta$, and each zero block is a set of isolated vertices. So:

> a diagonal critical point with $\theta>0$ whose support graph has $k\ge2$ components **carrying an edge** has $\mathcal L$-eigenvalue $\theta$ with multiplicity $\ge k$, hence $\lambda_{\max}(L_e\vert_{e^\perp})\ge1$ and fails Lemma L24.

Isolated vertices contribute to $\dim\ker M$ and not to $k$, which is exactly where the record's inference broke.

#### The written-down eigenvector is not in $e^\perp$

Lemma L24 constrains $L_e$ on $e^\perp$, so the test vector must be orthogonal to $W$. For $a$ constant on components the row sums of $N$ vanish for *any* $a$ (component sizes never enter, so the record's admissibility check was never at risk) but

$$\langle N,M\rangle=8\sum_ca_cc_c^2=8\theta^2\sum_c\frac{a_c}{\theta_c^2},$$

so the stated normalisation $\sum a=0$ enforces neither admissibility nor orthogonality. It does no work at all. Measured over the same $205$ sums with $a=(1,-1,0,\dots)$, the cosine $\langle N,M\rangle/\lVert N\rVert\lVert M\rVert$ reaches $0.99$ and is zero only when the summands share a $\theta$. The correct condition is $\sum_ca_c/\theta_c^2=0$; at $S^3\!\times\!S^3\oplus S^2\!\times\!S^4$ the record's $a$ gives cosine $-0.0847$ and the repaired $a$ gives $0.0$, both with $\mathcal LN=\theta N$ to $2.2\times10^{-16}$. The consequence survives regardless, because the $\theta$-eigenspace is $k$-dimensional and contains $M$, so a $(k-1)$-dimensional slice of it lies in $e^\perp$ whenever $k\ge2$.

#### The diagonal-versus-full worry does not bite, and the conclusion is cheaper than the lemma

The brief's central concern is that the diagonal $\lambda_{\max}$ is only a lower bound. That is the harmless direction. Diagonal Weyl tensors form a subspace of $\mathrm{Weyl}_n$ on which $L_W$ acts by $\mathcal L$ (both verified above at non-critical points, so neither is a coincidence of the test set), hence every diagonal Rayleigh quotient is a full-space Rayleigh quotient and $\lambda_{\max}^{\text{full}}\ge\lambda_{\max}^{\text{diag}}$. Exceeding $\tfrac12$ on the locus certifies failure; lossiness only obstructs the *upper* bound. Measured, the two coincide exactly at genuine disconnected points: $4/3$, $1.291667$, $1.266667$, $1.25$ at $S^2\!\times\!S^2\oplus S^2\!\times\!S^2$, $\oplus\,S^2\!\times\!S^3$, $\oplus\,S^3\!\times\!S^3$ and $S^2\!\times\!S^3\oplus S^2\!\times\!S^3$.

**But no operator is needed for the conclusion.** $P$ restricted to the family $\bigoplus x_iM_i$ is exactly $\sum_ix_i^3\theta_i$ (verified to $3\times10^{-16}$ at random $x$) and on $\sum x_i^2=1$ that function's interior critical point is a strict local **minimum** along the circle through it: second derivative $+2.14$ at $S^3\!\times\!S^3\oplus S^2\!\times\!S^4$, while the vertex $x=e_i$ gives $\max_i\theta_i>\theta$. One line of single-variable calculus, no $\mathcal L$, no eigenvector.

**And the general fact is prior art already quoted in this record.** Krasnov–Tkachev Proposition 6.6, as [second-order.md](../findings/second-order.md) states it twice, says an extremal idempotent has $\sigma(L_c\vert_{c^\perp})\subseteq(-\infty,\tfrac12]$ **with $1$ simple**. A direct sum makes $1$ non-simple, so it is non-extremal by the cited proposition alone. [fence-posts.md](../findings/fence-posts.md) and [nondegeneracy.md](../findings/nondegeneracy.md) already record the same mechanism at $(2,2)$: *"$e=e^++e^-$ is non-primitive under the Hodge splitting"*, spectrum $(-1)^4,(\tfrac12)^4,1^2$, *"and $1$ is not simple"*. The disconnected lemma is that sentence with "components of the support graph" in place of "Hodge splitting".

---

### K2, CONFIRMED, and the residual is exact

Rebuilt at the $C_5$ blow-up ($n=10$, $\theta=0.670820393$, criticality $1.7\times10^{-13}$, $\dim\mathrm{Weyl}_{10}=770$). The twenty generators $A=E_{ab}+E_{ba}$ with $a,b$ in $C_5$-adjacent blocks give $H_A=D_AW+WD_A$ whose Weyl projection spans exactly $20$ dimensions, $31.6\%$ of the mass of $H_A$ lies outside $\mathrm{Weyl}_n$, so the projection is load-bearing. On that span:

- the compression is $\tfrac23$ times the identity, $\lVert C-\tfrac23I_{20}\rVert_\infty=7.5\times10^{-13}$, every eigenvalue $0.666666666666$;
- the residual Gram $R^{\mathsf T}R$ with $R=L_eU-UC$ is $\tfrac1{18}I_{20}$, $\lVert G-\tfrac1{18}I\rVert_\infty=1.1\times10^{-13}$, so $\lVert r\rVert=1/\sqrt{18}=1/(3\sqrt2)=0.235702260$ for **every** unit $u$ in the span, minimum and maximum agreeing to nine digits;
- the span is orthogonal to $W$ ($2.4\times10^{-16}$) and to the $40$-dimensional orbit tangent (largest principal cosine $2.2\times10^{-15}$).

So the residual is exact rather than numerical (its constancy is the statement $R^{\mathsf T}R=\tfrac1{18}I$, not an average) and the family is emphatically not $L_e$-invariant. The record's correction stands.

**The phenomenon is not special to the edge family, which sharpens what it does and does not show.** At the same point, the five within-block generators give compression $0$ with residual $0$ (an honest eigenspace, the kernel) and the twenty non-adjacent generators give compression $47/114=0.412280702$ with residual $0.099243057$, again constant to nine digits across the span. Reviewer 302's table lists $0.412281$ at multiplicity $20$, which is this. And at two-block products the cross-block family *is* invariant: $S^3\!\times\!S^5$, $S^2\!\times\!S^6$ and $S^3\!\times\!S^4$ all give compression exactly $\tfrac12$ with residual $0$ to machine precision, while $S^4\!\times\!S^4$ projects to zero, the record's "$\tfrac12$ at unbalanced maximizers, empty at balanced ones", and $c^\ast=0$ at $p=q$, both reproduced.

---

### K3, CONFIRMED, with two corrections

Every number attached to [w_n8_nondiagonal_witness.npy](../scripts/data/w_n8_nondiagonal_witness.npy) reproduces independently:

| quantity | record | rebuilt here |
|---|---|---|
| $\lVert W\rVert^2$ | $1$ | $1.0000000000000002$ |
| criticality $\lVert Q(W)-\theta W\rVert_\infty$ |, | $5.1\times10^{-16}$ |
| $\theta$ | $1.088948$ | $1.0889480525$ |
| $\Delta$ | $1.512$ | $1.512230534$ |
| $\lambda_{\max}(L_e\vert_{e^\perp})$ | $0.608885$ | $0.608885447$ |
| ratio | $0.5592$ | $0.5591501$ |
| kernel | trivial | $\min\lvert\lambda\rvert=0.0667$ |

Non-diagonality is confirmed by the record's own frame-independent certificate rather than by an off-diagonal norm: the top eigenvalue $0.573115$ is simple and its eigenvector has bivector rank $4$, so no orthonormal frame diagonalises $W$. Its mass outside $\mathrm{Weyl}_8$ is $2.3\times10^{-15}$. Below the top eigenvalue the spectrum of $L_e$ has $\tfrac12$ repeated, as the orbit forces. So the sharpened form $\Delta>0\Rightarrow\lambda_{\max}\ge\theta$ does fail off the diagonal locus, V3 survives at the witness, and the margin is $0.608885/0.5=1.2178\times$, the record's $1.22\times$, correct.

**Correction 1, the ratio is quoted in a third normalisation.** The census statistic is $\lambda_{\max}/\theta$ read as $\lambda_{\max}(L_W)/\theta=\lambda_{\max}(L_e)$, which is what makes "they clear not merely $\tfrac12$ but $1$" and the $C_5$ blow-up's $1.206011$ mean the same thing. The witness's $0.5592$ is instead $\lambda_{\max}(L_e)/\theta$, i.e. $\lambda_{\max}(L_W)/\theta^2$. Like for like the witness contributes $0.608885$ against a census floor of $1.0417$, so the conclusion is unchanged and only the arithmetic in the sentence is. It is worth fixing because "$\lambda_{\max}\ge\theta$" compares a dimensionless number with one that carries a scale, so it is not invariant under the record's own two conventions.

**Correction 2, the floor is lower than $1.0417$.** An independent diagonal census, solving $\mathrm{hollow}(\Phi(M))=\theta M$ from random admissible seeds, gives $315$ critical points with $\theta>0$ across $n=6,7,8,9,10,12$, of which $282$ have $\Delta>0$:

| $n$ | $\Delta>0$ points | $\min\lambda_{\max}(L_e)$ | at |
|---|---|---|---|
| $6$ | $28$ | $2.315522$ | $\theta=0.308607$, $\Delta=5.714286$ |
| $7$ | $48$ | $1.041667$ | $\theta=0.648886$, $\Delta=2.245614$ |
| $8$ | $52$ | $1.025000$ | $\theta=0.681429$, $\Delta=2.089552$ |
| $9$ | $49$ | $1.083333$ | $\theta=0.651751$, $\Delta=6.796460$ |
| $10$ | $52$ | $1.085619$ | $\theta=0.546964$, $\Delta=2.963841$ |
| $12$ | $53$ | $1.885105$ | $\theta=0.307533$, $\Delta=14.101936$ |

The recorded $1.0417$ is reproduced exactly at $n=7$ and is beaten at $n=8$ by a point at $1.025$. The cushion is real and it is not quite a factor of two.

**What I could not do, and it leaves K3's scoping claim resting on one point.** A full-space census on $\mathrm{Weyl}_7$ and $\mathrm{Weyl}_8$, damped Newton on $Q(W)-P(W)W=0$ with the analytic Jacobian $2L_W-3W\otimes Q(W)-\theta$, $95$ random starts before I stopped it, converged $47$ times and **every** time to padded $W_{\mathbb{CP}^2}$ at $\theta=\sqrt{3/2}$, $\Delta=0$, $\lambda_{\max}=0.500000$ exactly. That is [fence post F13](../findings/fence-posts.md) again, and it means I supply no second non-diagonal $\Delta>0$ witness. The brief's concern that one point is a thin basis for a scoping claim stands unresolved; what I can say is that the one point is exact.

---

### No refutation of V3, and why the diagonal route to one is closed

Nothing in $282$ diagonal $\Delta>0$ points, in the direct-sum family, or in the $C_5$ blow-up comes near $\lambda_{\max}\le\tfrac12$. More usefully, **a diagonal critical point with $\Delta>0$ and full-space $\lambda_{\max}\le\tfrac12$ cannot exist unless the diagonal census's floor is wrong**: $\lambda_{\max}^{\text{full}}\ge\lambda_{\max}^{\text{diag}}$ is a theorem, proved above from $L_W$-invariance of the locus and checked at non-critical points, and the diagonal value never dropped below $1.025$. Any V3 counterexample must therefore be non-diagonal, and the only non-diagonal $\Delta>0$ point anyone has is the $n=8$ witness at $0.608885$.

*One trap worth recording, because I nearly filed it as a refutation.* $\Delta$ is not sign-symmetric: it traces over the **strictly positive** eigenspace, so $\Delta(-W)$ sums a different set of densities. Padded $W_{\mathbb{CP}^2}$ at $n=8$ has $\Delta=0$ on the $\theta>0$ branch, one positive eigenvalue $0.816497$ carrying $g=0$, matching [bounds.md](../findings/bounds.md), and $\Delta=12$ on the $\theta<0$ branch, where two positive eigenvalues carry $g=6$ each. Since that point has $\lambda_{\max}=\tfrac12$ exactly, reading $\Delta$ off the wrong branch turns a local maximum into an apparent counterexample to V3. Every $\Delta$ statement on the record needs its sign branch named alongside its positivity threshold.

---

### What should change in the record

1. [diagonal-half.md](../findings/diagonal-half.md)'s disconnected lemma needs its scope narrowed from "disconnected" to "at least two components carrying an edge", and its inference from $\dim\ker M$ withdrawn, $\dim\ker M$ counts isolated vertices, which supply no test direction.
2. The stated eigenvector needs $\sum_ca_c/\theta_c^2=0$ in place of $\sum a=0$; as written it is not orthogonal to $W$, which is what Lemma L24 requires.
3. The lemma should be attributed: the scaling law is [nondegeneracy.md](../findings/nondegeneracy.md)'s block-sum law restricted to the diagonal locus, and the non-maximality is the "$1$ simple" clause of Krasnov–Tkachev Proposition 6.6 already quoted in [second-order.md](../findings/second-order.md). Its cheapest proof is that $P$ restricted to the direct-sum family is $\sum x_i^3\theta_i$, whose interior critical point is a local minimum.
4. The $C_5$-edge paragraph can be strengthened: the residual Gram is exactly $\tfrac1{18}I_{20}$, and the same constant-compression-with-constant-residual behaviour holds for the non-adjacent family at $47/114$, while the two-block cross families are genuine $\tfrac12$-eigenspaces.
5. The $\Delta>0$ census floor should read $1.025$, and the witness's comparable ratio $0.608885$ rather than $0.5592$.
