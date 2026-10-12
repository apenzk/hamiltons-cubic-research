# Reviewer r420, [Lemma L133](../findings/second-order.md), the balanced-orbit stability threshold

**Verdict: CONFIRMED, with four corrections.** Both boxed claims are true, and I reached the closed form and the comparison independently from the definitions. Every attack in the brief was run; the one I expected to land (the normalisation $\gamma$), is refuted by an exact independent check. What breaks is four sentences of the write-up, one of them a factual error in the statement line itself.

*Analysis-only footing observed. One screen was run, the ratio $\kappa^{\mathrm{Hess}}_n/\kappa_n$ at $n=12,\dots,58,100,10^3,10^6$, seconds of arithmetic on numbers I constructed, and it is reported below as a screen, never as evidence for a positive claim. Everything else here is derivation.*

| # | claim | verdict |
| --- | --- | --- |
| 1 | $\kappa_n^{\mathrm{Hess}}=\tfrac{27}2\theta_0(n)\big(\tfrac2{n-2}-\tfrac12\big)$ | **CONFIRMED**, re-derived from the product metric, the Daleckii–Krein differential and [Lemma L121](../findings/second-order.md)'s block, with $\gamma$ verified against an external anchor |
| 1a | attained *exactly* on [Lemma L26](../findings/nondegeneracy.md)'s direction inside a $(2,2)$-split four-subset | **CORRECTED**, attained on the whole $\binom m2^2$-dimensional span of those directions, plus $T_{W^*}\mathcal O$; "exactly" is false as written |
| 2 | $\kappa_n^{\mathrm{Hess}}\le\kappa_n$ for every $n\ge12$, strictly | **CONFIRMED**, step 5's chain is valid as written |
| 2a | "by a factor of at least $5$ at $n=12$ growing to $5.6$ as $n\to\infty$" | **REFUTED as written**, the factor is $49.3$ at $n=12$ and *decreases* to the infimum $5.598$; the lemma's own numbers paragraph says so |
| 3 | the $\gamma$ cancellation and the $\mathrm{Alt}$ normalisation | **CONFIRMED**, by an independent computation of $\delta^2$ at the $\mathbb{CP}^2$-type competitor giving exactly $1/9$ |
| 4 | "the dependence on the granted diagonal case is confined to the $\mathcal D_n$ block" | **CONFIRMED but under-stated**, [Lemma L127](../findings/second-order.md)'s $\mathcal D_n$ row supplies the same bound unconditionally, at the cost of leaning on a summand list rigorous only to $n\le12$ |

---

## The check that decides the lemma, $\delta^2(\mathbb{CP}^2)=1/9$, recomputed by hand

The brief's sharpest attack is the normalisation: $\kappa_n=9(\sqrt{3/2}-\theta_0)$ is **calibrated** by $\delta^2(W_{\mathbb{CP}^2})=1/9$ ([Conjecture L16](../findings/problem.md)), so any mismatch between that norm and the $\gamma$-weighted Frobenius norm L133 uses would rescale $\kappa^{\mathrm{Hess}}$ and could invert the comparison. $\gamma$ cancelling inside the ratio does **not** protect against this, because a constant $c$ in $\lVert\mathrm{Alt}(\cdot)\rVert^2$ multiplies the denominator without touching the numerator.

I recomputed $\delta^2$ at the competitor from the definitions, in the normalisation L133 uses.

- Take $W=2c\,P_{\omega_1^+}-c\,P_{\omega_2^+}-c\,P_{\omega_3^+}$ on $\Lambda^2\mathbb R^4$, with $\omega_1^+=(e_{12}+e_{34})/\sqrt2$, $\omega_2^+=(e_{13}-e_{24})/\sqrt2$, $\omega_3^+=(e_{14}+e_{23})/\sqrt2$. Then $\lVert W\rVert^2=6c^2$, so $c=1/\sqrt6$ at unit norm.
- Raw four-index entries: $W_{12,34}=c$, $W_{13,24}=c/2$, $W_{14,23}=-c/2$. First Bianchi $W_{1234}+W_{1342}+W_{1423}=0$ reads $x_{\text{raw}}-y_{\text{raw}}+z_{\text{raw}}=0$, so **[Lemma L121](../findings/second-order.md)'s signed coordinates negate the middle entry**: signed $(c,-c/2,-c/2)\propto(2,-1,-1)$, sum zero.
- $W_-=-c(P_{\omega_2^+}+P_{\omega_3^+})$; its signed four-set coordinates are $(0,-c/2,-c/2)$, sum $-c$.
- $\mathrm{Alt}$ of a totally antisymmetric tensor has signed coordinates $A\mathbf 1$ with $A=(x+y+z)/3$, and each of the three entries carries multiplicity $2$ in the $\Lambda^2$ Frobenius norm, so $\gamma=2$ and $\lVert\mathrm{Alt}(W_-)\rVert^2=6A^2=\tfrac23(x+y+z)^2=\tfrac23c^2=\tfrac19$.

**Exactly $1/9$.** So three things are settled at once: $\gamma=2$ is right, $\mathrm{Alt}$ really is $\big(\tfrac{x+y+z}3\big)\mathbf 1$ in signed coordinates with the ambient Frobenius norm on the image, and the norm in which L133's denominator is taken is *the same one* that pins $\kappa_n$. The numerator's inner product is the same $\gamma$-weighted one, since $\mathrm{Hess}=6\theta_0(L_e-\tfrac12)$ is a form in that inner product. **The $\gamma$ attack fails.**

As a by-product this reconciles the $\gamma=2$ derivation independently of [Lemma L26](../findings/nondegeneracy.md)'s recorded numbers: $\lVert H\rVert^2=2(x^2+y^2+z^2)$ on a four-set block because each of the three pairings appears twice in the pair-basis Frobenius norm.

## Attack 1, Daleckii–Krein, and the spectrum of $W^*$

**Both hold.** I rebuilt the spectrum from the product metric rather than from L133's line.

For $S^m\times S^m$ with unit factors, $R=\mathrm{id}$ on $\Lambda^2V_1\oplus\Lambda^2V_2$ and $0$ on the $m^2$ mixed planes; $\mathrm{Ric}=(m-1)g$, $\mathrm{scal}=2m(m-1)$, so the Einstein subtraction is $\mathrm{scal}/(n(n-1))=(m-1)/(2m-1)$ and

$$W^*_{\text{un}}=R-\tfrac{m-1}{2m-1}\mathrm{id}:\qquad \tfrac m{2m-1}\ \text{on}\ \Lambda^2V_1\oplus\Lambda^2V_2\ (\text{mult }m(m-1)),\qquad -\tfrac{m-1}{2m-1}\ \text{on the mixed planes}\ (\text{mult }m^2),$$

trace zero. **Two eigenvalues, the multiplicities and signs as claimed**, $0$ not in the spectrum, so $W\mapsto W_-$ is analytic near $W^*$ and the coordinate $2$-planes are a spectral eigenbasis, which is what Daleckii–Krein needs. The divided differences for $f(t)=t\mathbf 1_{t<0}$ are then $f'(\lambda_+)=0$, $f'(\lambda_-)=1$ and $\lambda_-/(\lambda_--\lambda_+)$; with $\lambda_--\lambda_+=-\lVert W^*_{\text{un}}\rVert^{-1}$ this last is $\tfrac{m-1}{2m-1}$. **All three coefficients confirmed.**

The independent cross-check that the normalisation is the record's: $\lVert W^*_{\text{un}}\rVert^2=m^2(m-1)/(2m-1)$, so the unit sectional matrix has $M_{ab}=1/\sqrt{(m-1)(2m-1)}$ within a factor and $-\sqrt{m-1}/(m\sqrt{2m-1})$ across, whose **ordered** square sum is $2$, [conventions.md](../findings/conventions.md)'s $t=2$ at a unit coordinate-diagonal $W$.

$\mathrm{Alt}(W^*_-)=0$ is also right, and the reason given is right: $W^*_-\propto\mathrm{id}-P_{\Lambda^2V_1}-P_{\Lambda^2V_2}$, and each of $\mathrm{id}$, $P_{\Lambda^2V_1}$, $P_{\Lambda^2V_2}$ is the curvature operator of a product of a round sphere with a flat factor, hence Bianchi.

## Attack 2, the support claim

**The table is correct, entry by entry.** With $V_1=\{1,2\}$, $V_2=\{3,4\}$ inside a $(2,2)$ split:

| pairing | planes | eigenvalue types | DK coefficient |
| --- | --- | --- | --- |
| $x=H_{12,34}$ | $\{1,2\}\subset V_1$, $\{3,4\}\subset V_2$ | $(+,+)$ | $0$ |
| $y=H_{13,24}$ | both mixed | $(-,-)$ | $1$ |
| $z=H_{14,23}$ | both mixed | $(-,-)$ | $1$ |

so $DW_-[H]=(0,y,z)$ in signed coordinates and $\mathrm{Alt}=\tfrac{y+z}3\mathbf 1=-\tfrac x3\mathbf 1$ using $x+y+z=0$. On a $(4,0)$ set all six planes are $+$, giving $0$; on a $(3,1)$ set **every** pairing couples one within-factor plane with one mixed plane, giving the same coefficient $c$ on all three, hence $c\,\mathrm{Alt}(H)=0$ because $H$ is a Weyl tensor. Diagonal and pair blocks carry at most three distinct indices, and $\mathrm{Alt}$ is determined by its values on four distinct ones, so they contribute nothing, and $DW_-$ being entrywise preserves that. **Nothing here is vacuous**: the $(3,1)$ row is the only one that uses $H\in\mathcal W_n$ rather than pure support, and it is exactly the row that would otherwise contribute.

That $\mathrm{Alt}$ is the orthogonal projection onto $\mathbf 1$ in signed coordinates is confirmed above and agrees with [Lemma L15](../findings/problem.md)'s $\mathrm{Alt}=$ projection onto $\Lambda^4$.

## Attack 3, the block-additivity step

**Valid, and the sign hypotheses are correctly identified.** Three ingredients, all present:

- **Numerator splits.** $\tfrac12\mathrm{Hess}[H,H]=3\theta_0\langle(L_e-\tfrac12)H,H\rangle$ and $L_e$ is block-diagonal ([Lemma L120](../findings/second-order.md)), with distinct sign characters mutually orthogonal, so there are no cross terms.
- **Denominator splits.** $\mathrm{Alt}\,DW_-[H_b]$ for a four-set $b$ lives on the single basis element $e_i\wedge e_j\wedge e_k\wedge e_l$ of $\Lambda^4$; distinct four-subsets give orthogonal images. So $\lVert\cdot\rVert^2=\sum_b\tfrac\gamma3x_b^2$.
- **The mediant.** $(\sum a_b)/(\sum d_b)\le\max_b a_b/d_b$ over $d_b>0$ needs **no** sign hypothesis on $a_b$. The nonpositivity $\mathrm{num}_b\le0$ is needed only to discard blocks with $d_b=0$, but there it is load-bearing: a single block with $L_e>\tfrac12$ and $d_b=0$ would make $\kappa^{\mathrm{Hess}}=+\infty$. Step 3's "every block" claim is therefore essential to the *value*, not decoration, and the lemma is right to prove it block by block.

Within one $(2,2)$ block, $H=\alpha(2,-1,-1)+\beta(0,1,-1)$ exhausts $\mathbf 1^\perp$, the two vectors are orthogonal ($0-1+1=0$), $\lVert(2,-1,-1)\rVert^2=6\gamma$, $\lVert(0,1,-1)\rVert^2=2\gamma$ and $x=2\alpha$. Substituting reproduces step 4's display exactly, and $\beta$ only makes the numerator more negative at fixed denominator, so $\beta=0$. The value is $18\theta_0(\mu-\tfrac12)/(4/3)=\tfrac{27}2\theta_0(\mu-\tfrac12)$.

**Correction 1a.** Because every $(2,2)$ block has the *same* per-block ratio, the mediant is an equality on every combination $H=\sum_b\alpha_b(2,-1,-1)_b$, and adding any orbit direction changes neither numerator nor denominator. So the sup is attained on a subspace of dimension $\binom m2^2+\dim\mathcal O$, not on one direction. Replace "attained exactly on L26's direction inside any $(2,2)$-split four-subset" with "attained on the span of L26's directions over the $(2,2)$-split four-subsets".

## Attack 4, every block below $\tfrac12$, and the $\mathcal D_n$ grant

**Holds at $p=q=m\ge6$, and [Lemma L128](../findings/second-order.md)'s warning does not bite here.** L128's caveat is that *criticality* permits a block above $\tfrac12$, its witness is $S^2\times S^4$ with $\mu_{2,4}=\tfrac23$. That witness is a $p=2$ split; at $p=q=m$ the four-set top is $\mu=1/(m-1)\le\tfrac15$ for $m\ge6$, so the gap is not marginal. The remaining rows come from [Lemma L127](../findings/second-order.md) (cross-factor pair $\{\tfrac12,0^{n-4}\}$ with the $\tfrac12$ on the orbit; within-factor top $(m-2)/(2(m-1))<\tfrac12$) and are proved there from [Lemma L122](../findings/second-order.md)'s Laplacian.

**The $\mathcal D_n$ grant is applied correctly.** $\mathcal D_n$ is a linear subspace, so $\mathcal D_n\cap S$ is a great subsphere of $S$ and $W^*$ is a critical point of $P|_S$; therefore $\mathrm{Hess}(P|_{\mathcal D_n\cap S})_{W^*}$ *is* the restriction of $\mathrm{Hess}(P|_S)_{W^*}$, with no second-fundamental-form correction. The granted statement, $\langle Q(W),W\rangle\le\Theta_n\lvert W\rvert^3$ on the diagonal locus with equality at the balanced split, $\Theta_n=\theta_0(n)$ at even $n$ ([problem.md](../findings/problem.md), [conventions.md](../findings/conventions.md)), makes $W^*$ a maximiser of $P$ on $\mathcal D_n\cap S$, hence $\mathrm{Hess}\preceq0$ there, hence $L_e\le\tfrac12$ on that block. **Sound.**

**Correction (scope note, not a defect).** The lemma's closing "the dependence on the granted diagonal case is confined to the $\mathcal D_n$ block" is true but sells the position short in one direction and long in another. [Lemma L127](../findings/second-order.md)'s $\mathcal D_n$ row already gives $\sigma(L_e|_{\mathcal D_n\cap(W^*)^\perp})=\{\lambda_m^{\,m-1},\lambda_m^{\,m-1},(-\mu)^{(m-1)^2},0\}$ with $\lambda_m=(m-2)/(2(m-1))<\tfrac12$ (the eigenvalue $1$ being $W^*$ itself, which the tangent space excludes) so the block is available *without* the grant. But that route runs through [Lemma L27](../findings/nondegeneracy.md)'s summand list, which [Lemma L26](../findings/nondegeneracy.md)'s own scope note calls "verified numerically at 44 splits to $n=16$ and rigorous only at $n\le12$". **So the grant is the stronger of the two available routes for general $n$, and the lemma should say that rather than present the dependence as a cost.**

**Miscitation.** Step 3's closing sentence attributes $\mu\le\tfrac15$ to [Corollary L128.1](../findings/second-order.md). L128.1 establishes $\tfrac12\notin\mathrm{spec}$ (an exclusion, per L128's own box), and the *value* $\mu=2/(n-2)$ is [Lemma L126](../findings/second-order.md)'s and [Lemma L127](../findings/second-order.md)'s. The anchor used there (`#lemma-l128--the-branching-clause-of-the-sign-character-decomposition`), also does not exist in the file; the heading is "the branching clause: block-checkable nondegeneracy at a pure critical point, and the isolation it gives".

## Attack 5, [Lemma L26](../findings/nondegeneracy.md)'s eigenvector, and the coefficients that sum to $2/3$

**The identification is right; the sentence justifying it is self-inconsistent and should be rewritten.**

The reconciliation the brief asks about is real, and I pinned it above: L121's signed coordinates negate the middle pairing, because first Bianchi reads $T_{1234}-T_{1324}+T_{1423}=0$. So L26's recorded $(\tfrac23,\tfrac13,-\tfrac13)$ are the **raw** entries, whose signed form is $(\tfrac23,-\tfrac13,-\tfrac13)\propto(2,-1,-1)$, sum zero. Two independent confirmations that this is the right reading:

- $\lVert X\rVert^2=2\big((\tfrac23)^2+(\tfrac13)^2+(\tfrac13)^2\big)=\tfrac43$, matching L26's recorded norm and giving $\gamma=2$, the same $\gamma$ the $\mathbb{CP}^2$ check produces.
- The $\mathbb{CP}^2$ Weyl tensor's own four-set signed coordinates are $\propto(2,-1,-1)$, and it satisfies Bianchi by construction.

**But then "with its $\Lambda^4$ part removed" is vacuous**, since the signed coordinates already sum to zero, and if it were *not* vacuous, removing a $\Lambda^4$ part would change $\lVert X\rVert^2$ away from $\tfrac43$, so the same sentence could not also read $\gamma$ off that norm. The sentence asserts both. **Correction: state the sign convention explicitly** ("L26's recorded coefficients are raw entries; L121's signed coordinates negate the middle pairing, so $X$ is $(2,-1,-1)$ and already Bianchi-clean"), and drop the $\Lambda^4$ clause or move it to L26 where the ambient object $\phi_\pi\odot\phi_\rho$ genuinely has one.

I independently checked the eigenvector claim rather than taking it: at a $(2,2)$ split $B=C$, so [Lemma L121](../findings/second-order.md)'s $G$ has $G(2,-1,-1)=(A-B)(2,-1,-1)$ and $G(0,1,-1)=-(A-B)(0,1,-1)$, giving $+\mu$ on $(2,-1,-1)$ and $-\mu$ on $(0,1,-1)$ with $\mu=(A-B)/(2\theta_0)$. Since $A>0>B$, $\mu>0$ and the assignment is the right way round.

## Attack 6, $\mu=2/(n-2)$

**Confirmed, computed from the sectional matrix and not read off L26.** At a $(2,2)$ split, $A=2/\sqrt{(m-1)(2m-1)}$ and $B=C=-2\sqrt{m-1}/(m\sqrt{2m-1})$, so

$$A-B=\frac2{\sqrt{2m-1}}\cdot\frac{m+(m-1)}{m\sqrt{m-1}}=\frac{2\sqrt{2m-1}}{m\sqrt{m-1}},\qquad \theta_0=\frac{\sqrt{(2m-1)(m-1)}}m,\qquad \mu=\frac{A-B}{2\theta_0}=\frac1{m-1}.$$

And $1/(m-1)=2/(n-2)=(n-2)/\big(2(m-1)^2\big)$, so L133's three expressions agree with each other, with [Lemma L26](../findings/nondegeneracy.md)'s $\mu_{p,q}=(n-2)/(2(p-1)(q-1))$ at $p=q=m$, and with [Lemma L127](../findings/second-order.md)'s table. The $\theta_0$ appearing here is the same value the record carries, and it reproduces [Lemma L127](../findings/second-order.md)'s $\theta=(n-1)\lvert\gamma_{\text{cross}}\rvert$.

**Note the normalisation trap that this passes and could have failed**: [Lemma L121](../findings/second-order.md) gives $L_M$, not $L_e$, so the $\tfrac12\sqrt\Sigma$ it prints must be divided by $\theta_0$. Without that division $\mu$ would come out $\sqrt{2m-1}/(m\sqrt{m-1})$, $0.2472$ rather than $0.2$ at $n=12$, and the boxed constant would be wrong by $24\%$. L133 does it correctly, and [Lemma L127](../findings/second-order.md)'s own italic normalisation note flags the same hazard.

## Attack 7, [Lemma L24](../findings/second-order.md) and step 5's arithmetic

**Both clean.** $P$ cubic with $\nabla P=3Q(W)$ gives $D^2P=6\,W\circ(\cdot)=6\theta_0L_e$; the sphere multiplier contributes $-\langle\nabla P,W\rangle\mathrm{Id}=-3\theta_0\mathrm{Id}$; hence $6\theta_0(L_e-\tfrac12)$. This constant multiplies $\kappa^{\mathrm{Hess}}$ directly, so it is load-bearing, and it is right.

Step 5: $\tfrac{27}2\theta_0(\mu-\tfrac12)\le9(\sqrt{3/2}-\theta_0)$ divides by $9$ to $\tfrac32\theta_0\mu-\tfrac34\theta_0\le\sqrt{3/2}-\theta_0$, i.e. $\theta_0\big(\tfrac3{n-2}+\tfrac14\big)\le\sqrt{3/2}$, the displayed form, with every sign right. The bracket is decreasing in $n$ and at most $0.55$ for $n\ge12$; $\theta_0^2=2(n-1)(n-2)/n^2<2$ because $(n-1)(n-2)<n^2$; $0.55\sqrt2=0.7778<1.2247$. **Uniform in $n$, with no numerics.**

**Correction 2a, the only outright false sentence in the lemma.** The statement reads "strictly, and by a factor of at least $5$ at $n=12$ growing to $5.6$ as $n\to\infty$". The ratio $\kappa^{\mathrm{Hess}}_n/\kappa_n$ is $49.27$ at $n=12$ and **decreases** to $5.598$; the lemma's own numbers paragraph gets this right ("a factor of $49$ … a factor of $5.6$ … the ratio's minimum"), so the statement contradicts its own body. *Screened at $n=12,14,\dots,58,100,10^3,10^6$: $49.27,17.08,\dots,6.28,5.956,5.630,5.598$, decreasing throughout, with $\lim=\tfrac{27\sqrt2/4}{9(\sqrt2-\sqrt{3/2})}=5.5981$.* Two further points on the same sentence: $5.6$ is an **infimum, not a minimum** (it is approached and never attained; and "at least $5$" is *not proved anywhere in the lemma*), step 5 proves only the factor $\ge1$, which is all the conclusion needs. Suggested replacement: "*strictly, the margin being a factor $49.3$ at $n=12$ and decreasing to the infimum $\tfrac{3\sqrt2}{2(\sqrt2-\sqrt{3/2})}=5.598$*", with the factor stated as a screened value rather than a proved bound.

## Attack 8, is $\kappa^{\mathrm{Hess}}$ the right second-order object?

**Yes, and the deferred third-order remainder is genuinely routine, I checked, rather than taking the lemma's word.**

The neighbourhood form of [Conjecture L16](../findings/problem.md) at $W^*$ is $F(u)\le0$ for $F(u):=\tfrac12\mathrm{Hess}[u,u]-\kappa_n\,d(u)$, $d(u)=\lVert D(\mathrm{Alt}\,W_-)[u]\rVert^2$. Since $\kappa_n<0$ for $n\ge12$, the penalty term enters with a **positive** sign and genuinely fights the Hessian, the comparison is not free. Three things then have to hold, and all three do:

- On $d>0$: $F(u)\le(\kappa^{\mathrm{Hess}}-\kappa_n)d(u)<0$, which is claim 2.
- On $d=0$ off the orbit: $F(u)=\tfrac12\mathrm{Hess}[u,u]<0$, which is step 3's "$<0$ on every block except the orbit's own". **The boxed statement does not carry this**, so a reader lifting the box alone gets an incomplete criterion; the $d=0$ clause should be in the statement.
- $F(u)=0\Rightarrow u\in T_{W^*}\mathcal O$: if $F(u)=0$ then $0\le(\kappa^{\mathrm{Hess}}-\kappa_n)d(u)\le0$ with $\kappa^{\mathrm{Hess}}-\kappa_n<0$, forcing $d(u)=0$ and then $\mathrm{Hess}[u,u]=0$.

So $F$ is a quadratic form vanishing exactly on $T_{W^*}\mathcal O$, hence $F\preceq-c\lVert u\rVert^2$ on the normal space by compactness. **That is what makes the $O(\lVert u\rVert^3)$ remainder absorbable, and it is the right reason**, the lemma's stated reason ("$P$ is cubic so $D^3P$ is constant, and $\delta^2$'s third derivative is controlled through the spectral gap") supplies the upper bound on the remainder but not the definiteness that the remainder must be beaten against. Both halves are needed; the lemma states one.

**One gap in the write-up, not in the mathematics.** $\kappa^{\mathrm{Hess}}$ is defined as a sup over $T_{W^*}S$, while step 3 argues on $T_{W^*}\mathcal O^\perp$. The two suprema coincide here (orbit directions sit in pair blocks with $\mathrm{num}=0$ and $\mathrm{den}=0$) but the *legitimacy of restricting to the normal space* for the neighbourhood statement rests on $O(n)$-invariance of both $P$ and $\delta^2$ (move any nearby $W$ by the group to the normal slice), which the lemma never states. It is true, $\delta^2\equiv0$ on $\mathcal O$ because $\mathrm{Alt}$ and $W\mapsto W_-$ are equivariant and $\mathrm{Alt}(W^*_-)=0$, and it should be one line in step 1.

## Vacuity

**The finding is not vacuous, but its headline is stronger than its content.** The formula is specific: it consumes $\mu$ at the balanced split, $\theta_0(n)$, [Lemma L24](../findings/second-order.md)'s constant and $\gamma$, and it would change if any of them changed. The consistency check at $n=6$, $\mu=\tfrac12$, $\kappa^{\mathrm{Hess}}=0$, matching the nine four-set $\tfrac12$-eigenvectors at $S^3\times S^3$, is a genuine external anchor that no step was arranged to produce.

What *is* oversold is "the balanced orbit is not where its constant is decided". $\kappa_n$ was calibrated at the $\mathbb{CP}^2$-type competitor and $\delta^2(W^*)=0$, so $W^*$ satisfies L16 with equality for reasons having nothing to do with $\kappa_n$; the second-order test then asks only whether the Hessian's negativity outruns $\lvert\kappa_n\rvert$ times the defect's growth rate. Given that $W^*$ is a local maximum of $P$ on $S$, which [Corollary L128.1](../findings/second-order.md) already gives at $n\ge12$, a *positive* answer was the expected one, and the factor $5$–$49$ measures how far from marginal it is rather than establishing anything about where $\kappa_n$'s value comes from. The lemma's own "Does not touch" paragraph says as much for scenarios (β) and (γ); the boldface conclusion should be softened to match it.

---

## Corrections to record, in order of weight

1. **[second-order.md](../findings/second-order.md), L133 statement.** "by a factor of at least $5$ at $n=12$ growing to $5.6$ as $n\to\infty$" is false and contradicts the lemma's own numbers paragraph. The factor is $49.3$ at $n=12$, decreasing to the **infimum** $5.598$; and "at least $5$" is asserted, never proved, step 5 proves the factor $\ge1$.
2. **L133 statement, attainment.** "attained exactly on L26's direction inside any $(2,2)$-split four-subset", the equality set is the full span of the $\binom m2^2$ such directions together with $T_{W^*}\mathcal O$.
3. **L133 step 3, L26 reconciliation.** Say the sign convention outright: L26's $\tfrac23,\tfrac13,-\tfrac13$ are raw entries, L121's signed coordinates negate the middle pairing, hence $(2,-1,-1)$ with sum zero, hence $\gamma=2$ from $\lVert X\rVert^2=\tfrac43$. Drop "with its $\Lambda^4$ part removed", which is vacuous in signed coordinates and would invalidate the $\gamma$ reading if it were not.
4. **L133 step 3, citation.** The $\mu\le\tfrac15$ value is [Lemma L126](../findings/second-order.md)/[Lemma L127](../findings/second-order.md)'s, not [Corollary L128.1](../findings/second-order.md)'s (which excludes the value $\tfrac12$ rather than bounding); and the anchor `#lemma-l128--the-branching-clause-of-the-sign-character-decomposition` does not exist in the file.
5. **L133 statement, completeness.** Add the $d=0$ clause ($\mathrm{Hess}(P|_S)\prec0$ on $T_{W^*}\mathcal O^\perp$), to the boxed statement, since $\kappa^{\mathrm{Hess}}\le\kappa_n$ alone does not give the neighbourhood inequality.
6. **L133 step 1.** One line on $O(n)$-invariance, licensing the reduction to the normal slice.
7. **L133 closing paragraph.** The $\mathcal D_n$ grant is the *stronger* of the two available routes, [Lemma L127](../findings/second-order.md)'s row leaning on [Lemma L27](../findings/nondegeneracy.md)'s summand list, which is rigorous only to $n\le12$. Recording it as a cost understates the position.
8. **[conventions.md](../findings/conventions.md), symbol clash.** $\kappa_n$ is already the algebra's Killing constant $(2n-1)(n-1)/4$ there, and is [Conjecture L16](../findings/problem.md)'s penalty constant here. One of them wants renaming.

*Suggested addition to the record, independent of the corrections: the hand computation $\delta^2(W_{\mathbb{CP}^2})=\tfrac23c^2=\tfrac19$ at $c=1/\sqrt6$ is worth carrying somewhere, since it pins $\gamma=2$, the $\mathrm{Alt}$ formula in signed coordinates and $\kappa_n$'s calibration in three lines, and the record currently states the $1/9$ without a derivation a reader can check.*
