# Review r419, Lemma L133, the balanced-orbit stability threshold

**Verdict: CONFIRMED, with six corrections to the surrounding prose and citations and one scope line the lemma should carry. Nothing in the mathematics falls.**

*Adversarial audit, brief to break the claim from the definitions. Analysis only, per [analysis-only.md](../.claude/rules/analysis-only.md): everything below is derived by hand except one nine-line screen of an already-derived closed form, flagged where it appears. Log at [r419-L133.log](../agent_logs/r419-L133.log).*

## The claim list, and what happened to each

| # | clause of [Lemma L133](../findings/second-order.md) | verdict |
|---|---|---|
| 1 | $W^*$ is two-eigenvalued, $+\propto m/(2m-1)$ at multiplicity $m(m-1)$ and $-\propto-(m-1)/(2m-1)$ at $m^2$ | **confirmed**, recomputed from the product metric |
| 2 | $\mathrm{Alt}(W^*_-)=0$, so $\delta^2$ vanishes to second order | **confirmed**, by a shorter argument than the one given |
| 3 | $DW_-$ is entrywise with coefficients $1,0,c=\tfrac{m-1}{2m-1}$ | **confirmed**; $c$ is scale-free and does drop out |
| 4 | $\mathrm{Alt}\circ DW_-$ is supported on the $(2,2)$ four-sets, and sees only $x$ | **confirmed**, all three rows of the table checked |
| 5 | $\gamma=2$, common to the three signed coordinates, and it cancels | **confirmed**, including the sign convention the brief doubted |
| 6 | $\mu=2/(n-2)$, eigenvector $(2,-1,-1)$ at $+\mu$, $(0,1,-1)$ at $-\mu$ | **confirmed**, re-derived independently from [Lemma L121](../findings/second-order.md)'s $G$ |
| 7 | every block has $L_e\le\tfrac12$ off the orbit | **confirmed**, and **unconditionally**, the granted diagonal case is not needed |
| 8 | the sup is one $(2,2)$ block, at $\beta=0$ | **confirmed**; the maximiser set is larger than stated |
| 9 | $\kappa_n^{\mathrm{Hess}}=\tfrac{27}2\theta_0\big(\tfrac2{n-2}-\tfrac12\big)$ | **confirmed** |
| 10 | $\kappa_n^{\mathrm{Hess}}\le\kappa_n$ strictly for all $n\ge12$ | **confirmed**; the "factor" sentence is backwards |

## Attack 1, the spectrum of $W^*$, recomputed from the definition

**Independent, from the product metric rather than from the record.** With unit round factors $R=\mathrm{id}$ on $\Lambda^2V_1\oplus\Lambda^2V_2$ and $0$ on $V_1\wedge V_2$; $\mathrm{Ric}=(m-1)g$, so $s=2m(m-1)$ and the metric is Einstein; hence $W^*\propto R-\frac{s}{n(n-1)}\mathrm{id}$ with $\frac{s}{n(n-1)}=\frac{2m(m-1)}{2m(2m-1)}=\frac{m-1}{2m-1}$. That is the lemma's constant exactly. Eigenvalues $1-\frac{m-1}{2m-1}=\frac m{2m-1}$ at multiplicity $2\binom m2=m(m-1)$ and $-\frac{m-1}{2m-1}$ at $m^2$; trace $\frac{m^2(m-1)-m^2(m-1)}{2m-1}=0$. **Every number in step 1 stands.**

**The unit normalisation, which the lemma does not print and which the later steps need.** Writing $W^*=s_n(R-\frac{m-1}{2m-1}\mathrm{id})$ and imposing $\sum_\alpha\lambda_\alpha^2=1$ gives $s_n^2m^2(m-1)/(2m-1)=1$, so $s_n=\sqrt{2m-1}/(m\sqrt{m-1})$. **This is the quantity that makes $\mu$ come out right in attack 5, and its absence is why the $\mu$ step reads as an import rather than a check.**

**One imprecision.** Step 1 justifies $\mathrm{Alt}(W^*_-)=0$ by "each summand of which is the curvature operator of a round sphere". $P_{\Lambda^2V_1}$ is the curvature operator of $S^m\times\mathbb R^m$, not of a round sphere. The conclusion is untouched, and there is a shorter reason that needs no geometry: $\mathrm{id}$, $P_{\Lambda^2V_1}$ and $P_{\Lambda^2V_2}$ have no entries at all on four distinct indices, so their $\Lambda^4$ parts vanish for free.

## Attack 2, Daleckii–Krein, and whether the basis is legitimate

**It is.** In a frame adapted to $V_1\oplus V_2$ every coordinate $2$-plane is an eigenvector of $W^*$, so the coordinate-plane basis *is* an orthonormal eigenbasis; the divided-difference formula holds in any eigenbasis, and inside a degenerate eigenspace all divided differences collapse to $f'(\lambda)$, so the entrywise reading is basis-independent within blocks and no choice is smuggled in.

**The three coefficients.** $f(t)=t\mathbf 1_{t<0}$ agrees near $\mathrm{spec}(W^*)$ with an analytic function, the spectrum being bounded away from $0$. Then $f^{[1]}(\lambda_-,\lambda_-)=1$, $f^{[1]}(\lambda_+,\lambda_+)=0$, and $f^{[1]}(\lambda_-,\lambda_+)=\lambda_-/(\lambda_--\lambda_+)$. Since $\lambda_--\lambda_+=-s_n$ and $\lambda_-=-s_n\frac{m-1}{2m-1}$, that ratio is $\frac{m-1}{2m-1}$, **the lemma's $c$, and it is scale-free, so the unit normalisation genuinely cannot enter it.** *And $c$ multiplies exactly the entries $\mathrm{Alt}$ kills, as claimed.*

## Attack 3, the support claim, row by row

All three rows check, and the split types are exhaustive over a $4$-subset.

- **$(4,0)$**: four indices in one factor, all six planes at $\lambda_+$, coefficient $f^{[1]}(\lambda_+,\lambda_+)=0$. Zero.
- **$(3,1)$**, say $i,j,k\in V_1$, $l\in V_2$: $\{ij|kl\}$ is $(+,\text{mixed})$, $\{ik|jl\}$ is $(+,\text{mixed})$, $\{il|jk\}$ is $(\text{mixed},+)$, **all three at $c$**, so $DW_-[H]=cH$ on the block and $\mathrm{Alt}(cH)=0$ **because $H$ is a Weyl tensor and satisfies first Bianchi**. That hypothesis is load-bearing and the lemma does not name it; it is available, since $H\in T_{W^*}S\subset\mathcal W_n$.
- **$(2,2)$**, $i,j\in V_1$, $k,l\in V_2$: $x=H_{ij,kl}$ pairs $\Lambda^2V_1$ with $\Lambda^2V_2$, both $+$, coefficient $0$; $y$ pairs two mixed planes, $z$ likewise, coefficient $1$. So $(0,y,z)$, and $y+z=-x$.

**$\mathrm{Alt}$ is the orthogonal projection onto $\mathbf 1$.** The $\Lambda^4$ part of a pair-symmetric tensor on four distinct indices is the component along the direction whose three signed coordinates are equal; the pair-matrix inner product is $\gamma(x^2+y^2+z^2)$ with one $\gamma$, hence Euclidean in $(x,y,z)$, hence the projection is orthogonal and equals $\tfrac{x+y+z}3\mathbf 1$. Diagonal and pair blocks carry no four-distinct-index entry, so they contribute nothing, **confirmed**. Distinct $4$-subsets give $\Lambda^4$ components on disjoint index sets, so the denominator's block sum is an orthogonal sum, **confirmed**.

## Attack 4, the normalisation $\gamma$, and the objection the brief raised against it

**The brief's objection is answered, and the answer is a real sign convention rather than a patch.** [Lemma L26](../findings/nondegeneracy.md) records $X=\phi_\pi\odot\phi_\rho$ minus its $\Lambda^4$ part with coefficients $\tfrac23,\tfrac13,-\tfrac13$ and $\lVert X\rVert^2=\tfrac43$. First Bianchi on the raw entries reads $H_{ij,kl}-H_{ik,jl}+H_{il,jk}=0$, so the signed coordinate is $y=-H_{ik,jl}$; L26's triple is the **unsigned** one, and in signed coordinates it is $(\tfrac23,-\tfrac13,-\tfrac13)\propto(2,-1,-1)$, which sums to $0$ as it must. **Independent confirmation from the norm**: $\gamma=2$ because a symmetric pair matrix carries each off-diagonal entry twice, and $2(\tfrac49+\tfrac19+\tfrac19)=\tfrac43$ reproduces L26's recorded norm exactly. *Two independent readings of $\gamma$ agree, so the identification is not circular.*

**And $\gamma$ is genuinely common to the three coordinates**: they are the same kind of entry of the same matrix, permuted by relabelling the four indices, and the Frobenius norm is invariant under that relabelling.

**The one thing the lemma should say and does not: numerator and denominator must be in the same inner product, and they are.** $\gamma$ cancels only because $\lVert H\rVert^2$ in [Lemma L24](../findings/second-order.md)'s Hessian and $\lVert\mathrm{Alt}(\cdot)\rVert^2$ in $\delta^2$ are the same pairing. I checked this at the anchor that pins $\kappa_n$ rather than assuming it: for $W_{\mathbb{CP}^2}$, $W_-=-c(\omega_2\omega_2^{\mathsf T}+\omega_3\omega_3^{\mathsf T})$ on $\Lambda^2_+$, whose signed coordinates are $(0,-\tfrac c2,-\tfrac c2)$, so $\delta^2=\gamma\frac{(x+y+z)^2}3=\tfrac23c^2$; and $\sum\lambda^2=6c^2=1$ gives **$\delta^2=\tfrac19$ exactly**, which is [Conjecture L16](../findings/problem.md)'s recorded defect at the competitor. *So $\delta^2$ and $\mathrm{Hess}$ are in one convention, and $\kappa_n$ is in it too.* **This matters more than it looks**: $\kappa_n^{\mathrm{Hess}}$ scales as $1/\lambda$ if $\delta^2$ is measured in a norm $\lambda$ times the $\Lambda^2$ Frobenius one, and the $n\to\infty$ margin tolerates only $\lambda\le5.598$, so a convention slip of the kind [conventions.md](../findings/conventions.md) warns about ($\lvert W\rvert^2=4\lVert W\rVert_F^2$, and $\mathrm{Alt}(\lvert W\rvert)=2\mathrm{Alt}(W_-)$ in [isotropy-cap.md](../findings/isotropy-cap.md)) would have been fatal at large $n$ and invisible at $n=12$. **Add the convention line to the lemma's setting.**

## Attack 5, $\mu$, the eigenvector, and which coordinate carries the $2$

**This is the load-bearing arithmetic of the whole lemma and it is right.** Putting the $2$ on $y$ or $z$ instead of $x$ would multiply $\kappa_n^{\mathrm{Hess}}$ by $4$; reversing the sign of $\mu$ would replace $\mu-\tfrac12$ by $-\mu-\tfrac12$. I re-derived all three from [Lemma L121](../findings/second-order.md) rather than reading them off L26.

At $S^m\times S^m$ with $\{i,j\}\subset V_1$, $\{k,l\}\subset V_2$, the sectional entries are $\lambda_+$ within a factor and $\lambda_-$ across, so L121's opposite-pair sums are $A=M_{ij}+M_{kl}=2\lambda_+$ and $B=C=2\lambda_-$. With $B=C$, $G=\begin{pmatrix}A&B&B\\B&B&A\\B&A&B\end{pmatrix}$ gives $G(2,-1,-1)=(A-B)(2,-1,-1)$ and $G(0,1,-1)=-(A-B)(0,1,-1)$. Hence $L_{W^*}$ has $+\tfrac12(A-B)=\lambda_+-\lambda_-=s_n>0$ on $(2,-1,-1)$ and $-s_n$ on $(0,1,-1)$: **the $2$ sits on $A$'s coordinate, which is $x=H_{ij,kl}$, and its eigenvalue is the positive one.** Both as the lemma says.

**And the conversion to $L_e$ units closes the loop.** $L_e=L_{W^*}/\theta_0$, so
$$\mu=\frac{s_n}{\theta_0}=\frac{\sqrt{2m-1}}{m\sqrt{m-1}}\cdot\frac{2m}{\sqrt{2(2m-1)\cdot2(m-1)}}=\frac1{m-1}=\frac2{n-2},$$
identically in $m$. This agrees with [Lemma L26](../findings/nondegeneracy.md)'s $\frac{n-2}{2(p-1)(q-1)}$ at $p=q=m$ and with [Lemma L127](../findings/second-order.md)'s table. **Three independent routes to $\mu$, agreeing.** *The normalisation caveat in L127 ("the $\tfrac12$ threshold is in $L_e$ units, L121 and L122 giving $L_M$ eigenvalues"), is exactly the $\theta_0$ that this derivation spends, and L133 inherits it silently.*

## Attack 6, block additivity, and the hypotheses the mediant step actually needs

**The step is sound, and its hypothesis is narrower than the lemma states.** Write $B_+$ for the blocks with $\mathrm{den}_b>0$ (the $(2,2)$ four-sets with $x_b\ne0$) and $B_0$ for the rest. Then
$$\frac{\sum_{B_+}\mathrm{num}_b+\sum_{B_0}\mathrm{num}_b}{\sum_{B_+}\mathrm{den}_b}\;\le\;\frac{\sum_{B_+}\mathrm{num}_b}{\sum_{B_+}\mathrm{den}_b}\;\le\;\max_{b\in B_+}\frac{\mathrm{num}_b}{\mathrm{den}_b},$$
the first inequality needing $\mathrm{num}_b\le0$ **on $B_0$ only**, the second being a mediant and needing nothing beyond $\mathrm{den}_b>0$. **The sign hypothesis is not decorative**: a single block with $\mathrm{num}_b>0$ and $\mathrm{den}_b=0$ sends the sup to $+\infty$, so the whole lemma rests on it.

**Cross terms vanish and the blocks are orthogonal.** [Lemma L120](../findings/second-order.md) makes $L_e$ block-diagonal over the sign characters, which are pairwise distinct isotypics and hence mutually orthogonal, so both quadratic forms split with no cross terms. $H\in(W^*)^\perp$ passes to the blocks because $W^*\in\mathcal D_n$ and every other block is orthogonal to it, so $\langle H,W^*\rangle=\langle H_{\mathcal D_n},W^*\rangle$. **Silent scope**: L120's own box records that $\Gamma\cap SO(n)$ fuses complementary blocks at $n=4,6,8$; the repair is the full sign group, and $n\ge12$ is clear of it either way, but L133 should say it inherits L120's scope rather than leaving a reader to find the box.

**And the maximiser set is larger than "exactly on L26's direction inside a $(2,2)$-split four-subset".** A mediant of *equal* ratios equals them, so any combination of L26 directions across several $(2,2)$ four-subsets attains the sup, as does any such direction plus an arbitrary orbit component (which contributes $0$ to both). *Correct the word "exactly" to "attained on L26's direction in any single $(2,2)$-split four-subset, and on their joint span modulo the orbit".*

## Attack 7, $L_e\le\tfrac12$ on every block, and the $\mathcal D_n$ grant

**The claim is true, the grant is unnecessary, and one citation is of the wrong kind.**

**The grant is removable, and this strengthens the lemma.** [Lemma L27](../findings/nondegeneracy.md) states $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ at $W_{p,q}$ **attained exactly on the orbit tangent**, for every $p,q\ge3$ with $(p,q)\ne(3,3)$, which covers every $p=q=m\ge6$, i.e. every $n=2m\ge12$. That is precisely step 3's conclusion, for all blocks at once, proved from Nienhaus's multiplicity-free decomposition and Schur rather than from the diagonal case. **So L133's closing sentence "The dependence on the granted diagonal case is confined to the $\mathcal D_n$ block of step 3" should read: the lemma depends on the granted diagonal case nowhere.** *This is worth fixing rather than leaving as modesty: [README.md](../README.md) states the grant as holding "only in high dimensions", and although this record discharges it at all $n$ ([result 57](../findings/INDEX-results.md)), a lemma that needs no grant should not advertise one.*

**And the grant does not deliver what step 3 claims from it.** Maximality on $\mathcal D_n\cap S$ gives $\mathrm{Hess}\preceq0$, i.e. $L_e\le\tfrac12$ **non-strictly**. Step 3's next sentence, "equality nowhere off the orbit for $n\ge12$ … it is $<0$ on every block except the orbit's own", is therefore unsupported by the citation it follows, for the $\mathcal D_n$ block. It *is* supported, by L27, whose $\tfrac12$ is attained on the orbit summand alone. **Same conclusion, different source.**

**The citation of [Corollary L128.1](../findings/second-order.md) is a category error.** L128.1 delivers clause (ii) of [Lemma L128](../findings/second-order.md), which is "$\tfrac12$ is **not an eigenvalue**", not "the spectrum is $\le\tfrac12$". L128's own box installs exactly that distinction after [r373](REVIEW_r373.md)/[r374](REVIEW_r374.md) refuted the strict-bound wording, with the witness $\mu_{2,4}=\tfrac23>\tfrac12$ at a pure, critical, nondegenerate point. **So "which is Corollary L128.1's nondegeneracy in the form the ratio needs" repeats the error L128 was corrected for.** The $\le\tfrac12$ the ratio needs comes from the computed $\mu=\tfrac2{n-2}\le\tfrac15$ and from L27, both of which L133 already has. *Replace the citation; the mathematics does not move.*

**The pair-block rows check.** [Lemma L127](../findings/second-order.md) gives the cross-factor spectrum $\{\tfrac12\text{ simple},0^{n-4}\}$ and the within-factor top $\frac{m-2}{2(m-1)}$, which is $\tfrac25$ at $n=12$ and $<\tfrac12$ at every $m$. The $pq=m^2$ cross-factor $\tfrac12$'s account for the whole of $\dim\mathcal O=\binom n2-2\binom m2=m^2$, an arithmetic identity that also confirms the pair blocks carry the orbit and the four-set blocks and $\mathcal D_n$ do not ([Lemma L128](../findings/second-order.md)(i)).

## Attack 8, steps 4 and 5, every sign and every direction

**Step 4, re-derived.** With $H=\alpha(2,-1,-1)+\beta(0,1,-1)$, the two vectors being orthogonal: $\lVert H\rVert^2=\gamma(6\alpha^2+2\beta^2)$, $\langle H,L_eH\rangle=\gamma\mu(6\alpha^2-2\beta^2)$, so
$$\tfrac12\mathrm{Hess}[H,H]=3\theta_0\gamma\big[6\alpha^2(\mu-\tfrac12)-2\beta^2(\mu+\tfrac12)\big],$$
matching the lemma verbatim. $x=2\alpha$, so the denominator is $\tfrac\gamma3\cdot4\alpha^2$. Since $\mu<\tfrac12$ the $\alpha^2$ coefficient is negative and the $\beta^2$ coefficient is negative too, so the ratio is $\frac{A}{C}-\frac BC\frac{\beta^2}{\alpha^2}$ and $\beta=0$ maximises. Value $\frac{18\theta_0(\mu-\frac12)}{4/3}=\frac{27}2\theta_0(\mu-\tfrac12)$. **Confirmed.** The maximiser is a genuine tangent vector: supported on four distinct indices it is automatically trace-free, it satisfies Bianchi by $x+y+z=0$, and it is orthogonal to the coordinate-diagonal $W^*$.

**Step 5, re-derived.** $\tfrac{27}2\theta_0(\mu-\tfrac12)\le9(\sqrt{3/2}-\theta_0)$ divides to $\tfrac32\theta_0(\mu-\tfrac12)\le\sqrt{3/2}-\theta_0$, i.e. $\theta_0\big(\tfrac3{n-2}+\tfrac14\big)\le\sqrt{3/2}$. The bracket is at most $0.55$ at $n\ge12$ and $\theta_0<\sqrt2$ since $2<3n$, giving $0.778<1.2247$. **Every direction correct.**

**The one arithmetic sentence that is wrong is in the Statement, not the proof.** "strictly, and by a factor of at least $5$ at $n=12$ growing to $5.6$ as $n\to\infty$" has the monotonicity backwards. *Screen, permitted under the standing rule as a check on a claim I am recording, nine lines evaluating the lemma's own closed form:* the ratio $\kappa^{\mathrm{Hess}}_n/\kappa_n$ is $49.27$ at $n=12$, $17.08$ at $14$, $12.23$ at $16$, $9.20$ at $20$, $7.28$ at $30$, $5.63$ at $10^3$, and $\to5.598$, **monotonically decreasing, from $49$ down to $5.6$.** The lemma's own "Numbers" paragraph says this correctly ("a factor of $5.6$, which is the ratio's minimum over $n\ge12$"), so the two paragraphs contradict each other. The mathematical content (strict, by a factor of at least $5$), survives; **replace "growing to" with "falling to".**

## Attack 9, is $\kappa_n^{\mathrm{Hess}}$ the right object, and can $O(t^3)$ move it

**As an algebraic quantity it is well defined and the lemma computes it correctly; as the object [Conjecture L16](../findings/problem.md) needs, the lemma's own "Leaves" paragraph is honest, and one point in its favour is stronger than stated.**

- **Directions excluded from the sup are harmless.** If $D(\mathrm{Alt}\,W_-)[H]=0$ then $\delta^2=O(t^3)$ while $P-\theta_0=\tfrac{t^2}2\mathrm{Hess}[H,H]\le0$, so the L16 ratio runs to $-\infty$ rather than threatening the bound. **The $\le0$ here is the same block claim as attack 7 and the lemma does not flag that it is used twice.**
- **There is no direction where the second-order test is inconclusive off the orbit.** By L27, $\ker\mathrm{Hess}(P|_S)_{W^*}=T_{W^*}\mathcal O$ exactly, and $P\equiv\theta_0$, $\delta^2\equiv0$ along the orbit. So $\mathrm{Hess}$ is negative **definite** normal to the orbit and the deferred $O(t^3)$ can only perturb a strict inequality. *That is a stronger statement than "the remainder is a bounded computation", and it is already on the record.*
- **Restricting to the orbit's normal space is legitimate** because orbit components contribute $0$ to numerator and $0$ to denominator; the sup over $T_{W^*}S$ and over the normal space coincide.

## Attack 10, is any of this vacuous

**No, and the place it could have been is worth recording.** The comparison $\kappa^{\mathrm{Hess}}_n\le\kappa_n$ is equivalent to $\mu\le\tfrac23\big(\sqrt{3/2}/\theta_0-\tfrac14\big)$, which is $\mu\le0.4939$ at $n=12$ and $\mu\le0.4107$ as $n\to\infty$. **At $\mu=\tfrac12$ it fails outright** ($\theta_0>\sqrt{3/2}$ for $n\ge12$) so the clause genuinely consumes the four-set nondegeneracy and is not a statement about any tensor. *Equally, the margin is wide: the comparison would survive any $\mu$ below $0.41$, so it is the boxed formula and not the comparison that carries the lemma's precision.* The $n=6$ "independent consistency check" is **not** independent in the sense claimed: $\kappa^{\mathrm{Hess}}(6)=0$ is $\mu_{3,3}=\tfrac12$ substituted into a formula whose only $n$-dependence beyond $\theta_0$ is $\mu$, and [Lemma L126](../findings/second-order.md)'s $n=6$ threshold is the same equation $\frac1{p-1}+\frac1{q-1}=1$. **Keep it as a transcription check, drop "which no step of the derivation was arranged to produce".**

## The corrections, collected

1. **Statement**: "growing to $5.6$" → **"falling to $5.6$"**; the factor is $49.3$ at $n=12$ and decreases monotonically. The "Numbers" paragraph already has it right.
2. **Step 3**: drop the appeal to the granted diagonal case. [Lemma L27](../findings/nondegeneracy.md) gives $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ attained exactly on the orbit for all $p,q\ge3$, $(p,q)\ne(3,3)$, hence for all $n=2m\ge12$. **The closing "What this settles" paragraph should say the lemma is unconditional throughout.**
3. **Step 3**: the citation of [Corollary L128.1](../findings/second-order.md) for "$L_e\le\tfrac12$" confuses an exclusion of $\tfrac12$ with a bound on the spectrum, the distinction [Lemma L128](../findings/second-order.md)'s own box installs. Cite the computed $\mu$ and L27.
4. **Step 3**: strictness off the orbit does not follow from the grant (which gives $\preceq0$); it follows from L27.
5. **Statement**: "attained exactly on L26's direction inside a $(2,2)$-split four-subset" → attained on that direction in **any** single $(2,2)$ four-subset, and on their joint span modulo the orbit.
6. **Setting**: add the convention line, $\delta^2$, $\lVert H\rVert^2$ and $\kappa_n$ are all in the $\Lambda^2$ pair-matrix pairing, the one in which $\delta^2(W_{\mathbb{CP}^2})=\tfrac19$. Without it $\gamma$'s cancellation is a claim about two different norms.
7. **Step 1**: $P_{\Lambda^2V_i}$ is the curvature operator of $S^m\times\mathbb R^m$; and the $\Lambda^4$ parts vanish for the simpler reason that neither $\mathrm{id}$ nor $P_{\Lambda^2V_i}$ has any four-distinct-index entry.
8. **Step 2**: name the hypothesis the $(3,1)$ row uses, $H$ satisfies first Bianchi, which is available because $H\in\mathcal W_n$.
9. **Step 4**: state the sign hypothesis in the form the mediant needs, $\mathrm{num}_b\le0$ on the blocks with zero denominator, where a single positive one would send the sup to $+\infty$.
10. **Scope**: L133 inherits [Lemma L120](../findings/second-order.md)'s full-sign-group requirement and L127's $L_e$-versus-$L_M$ normalisation; both are clear at $n\ge12$ and neither is stated.
11. **The $n=6$ check** is a transcription check, not an independent one.

## What I could not break

The two claims under review. The boxed value survives an independent recomputation of every input, the spectrum, the divided differences, the support table, $\gamma$, $\mu$, the eigenvector's coordinate and sign, the Hessian normalisation and both steps of arithmetic, and the comparison with $\kappa_n$ survives with a margin no error found here could close.

*Reviewer r419. Analysis only; the single screen is identified where it occurs and supports a correction to prose, not a positive mathematical claim.*
