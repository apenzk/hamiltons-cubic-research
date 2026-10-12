# Review r926, Lemma L214's frame split, and the reduction it claims

**The round read the written derivation link by link and re-derived every step before accepting it.** *Read: the [L214 block](../findings/second-order.md) and its neighbours [L120](../findings/second-order.md), [L121](../findings/second-order.md), [L122](../findings/second-order.md), [L123](../findings/second-order.md) and [L24](../findings/second-order.md); [L57](../findings/problem.md) with its canonical statement and its two undelivered identities; [conventions.md](../findings/conventions.md) on $t$, $\Theta_n$ and $\theta_0(n)$; [DERIVE-mx1.md](DERIVE-mx1.md) in full; [Route D of the 2026-09-13b sweep](2026-09-13b-LIT-step8-sweep.md), which is the block's origin; [plan.md](../plan.md), [routes.md](routes.md) and [L214FrameSplit.lean](../lean/HamiltonsCubic/Results/L214FrameSplit.lean).* Log: [agent_logs/gate2-l214-r926.log](../agent_logs/gate2-l214-r926.log).

| # | Item | Verdict | Reason |
|---|---|---|---|
| 1 | Does any step use the eigenframe | **CONFIRMED** | every step holds in an arbitrary orthonormal $F$, and the one place [DERIVE-mx1](DERIVE-mx1.md) failed, $X\perp W$, is proved here rather than assumed |
| 2 | Is $t_F$ replaced by $\max_Ft_F$ | **CONFIRMED** | $t$ is the frame's own value at every appearance, and evaluating in the frame that maximises $t$ instantiates a per-frame statement rather than substituting into it |
| 3 | Is L120 applicable at $D$ | **CONFIRMED** | the quoted hypothesis is $\Gamma$-fixedness with criticality unused, $D\in\mathcal D_n$ is $\Gamma$-fixed, and the one-line proof that $\mathcal D_n$ is exactly the fixed subspace is correct |
| 4 | Is $D$ in $\mathcal W_n$ | **CONFIRMED** | Ricci-flatness reads $\sum_bM_{ab}=0$ on frame-diagonal entries alone and Bianchi is empty on the pair diagonal, so the truncation is the orthogonal projection onto $\mathcal D_n$ and lands in $\mathcal W_n$ |
| 5 | The two relations | **CONFIRMED** | re-derived independently, and the total symmetry of $\langle X\circ Y,Z\rangle$ holds for both halves of $Q$ by the record's own structure-constant argument |
| 6 | The cancellation, step 3 | **CONFIRMED** | six trilinear terms expanded symbolically, coefficient of $a$ is $3t^2-2t$ then exactly $-1$, remainder exactly $\theta t(1-t)$, and the two vanishing terms are cancelled rather than dropped |
| 7 | The test vector | **CONFIRMED** | $X\perp W$ and $\lVert X\rVert^2=t(1-t)$ both re-derived, and at $t\in\{0,1\}$ the lemma degenerates to true equalities rather than to a false claim |
| 8 | L24's scope | **GAP** | the cap is a hypothesis of the lemma, so nothing false is asserted, but *which L24 gives at every maximiser* is not owed at a local maximiser with $\theta=0$, which the record's own L24 scope lists as OWED |
| 9 | The consequence and $\Theta_n$ | **CONFIRMED** | the algebra of $\theta=\sqrt tP(d)+(1-t)\langle L_d\nu,\nu\rangle/\sqrt t$ is exact, the normalisations agree, and $\Theta_n$ is right because [L57](../findings/problem.md)'s canonical form bounds $P$ at EVERY diagonal $W$, with the unstated hypothesis $0<t<1$ the only omission |
| 10 | Is the reduction real | **REFUTED** | $\Lambda_n\ge\sqrt3/2>\Theta_n/2$ forces the bound above $\Theta_n$ at every $t\in(0,1)$, so no lower bound on the diagonal mass and no closed form for $\Lambda_n$ can bring it to $\sqrt{3/2}$, or even to the granted diagonal value |
| 11 | Already on the record | **CONFIRMED** | no frame-split relation exists outside the same-session sweep that derived it, and the $t_F$ bookkeeping the block reuses is credited where [DERIVE-mx1](DERIVE-mx1.md) credits it |
| 12 | What would break it | **CONFIRMED** | four candidate falsifiers named and each closed for the lemma, and the one aimed at the reduction landed, from the sweep file's own witness |

**One line: the lemma is correct, the frame really is arbitrary, and the reduction it is the foundation of is dead, because the route's own witness pins $\Lambda_n\ge\sqrt3/2$ and the bound can then never beat the diagonal constant it starts from.**

## 1. No step uses the eigenframe

**Step by step, with what each needs.**

- **Step 1, the two relations.** Needs an orthonormal $F$ to define the pair basis, the sign group $\Gamma_F$, the subspace $\mathcal D_n(F)$ and the orthogonal splitting $W=D+N$, and then needs only $\langle D\circ D,N\rangle=0$. Holds in every orthonormal frame.
- **Step 2, the test vector.** Inner-product algebra in $\langle D,N\rangle=0$, $\lVert D\rVert^2=t$ and $\lVert N\rVert^2=1-t$. Frame-free once the splitting exists.
- **Step 3, the cancellation.** Trilinear algebra plus the same one scalar. Frame-free.
- **Step 4, the inequality.** [L24](../findings/second-order.md)'s cap on $W^\perp\cap\mathcal W_n$, applied at a vector whose membership in that space is proved in step 2 and whose membership in $\mathcal W_n$ follows from item 4. Holds in every frame.
- **Where it points.** [L57](../findings/problem.md) applies to $d$ because $d$ is a unit diagonal Weyl tensor of the frame $F$, and $\Lambda_n$ is a supremum over a pair of unit vectors, so both constants are frame-independent by $O(n)$-equivariance of $\circ$.

**And the contrast with [DERIVE-mx1](DERIVE-mx1.md) is exact rather than rhetorical.** That note applied [L121](../findings/second-order.md)'s four-index inequality at a test direction drawn from a four-set plane, and off the eigenframe $\langle X,W\rangle=\langle X,R\rangle\ne0$, so [L24](../findings/second-order.md)'s hypothesis failed. Here the test vector is built to satisfy it, $X=tN-(1-t)D$ being orthogonal to $W$ by construction in every frame, and no four-index inequality appears anywhere in the block. **The other half of mx1's failure, reading the frame's $t_F$ as the extremal $\max_Ft_F$ in a bound decreasing in $t_F$, is item 2.**

## 2. $t_F$ is never replaced by the extremal value

Every appearance of $t$ in the block is the fixed frame's own $\lVert D\rVert^2$: the two relations, the inequality, $\lVert X\rVert^2$, the definitions of $d$ and $\nu$, and the final bound. The Lean file carries $t$ as the hypothesis $ip\ D\ D = t$ for the same $D$ throughout, which is the frame's own value by construction.

**Evaluating the bound in the frame that maximises $t$, as [routes.md](routes.md) does, is sound and is a different operation from mx1's.** The bound holds for every frame, so it holds for that one, and $t$ there *is* $\max_Ft_F$ legitimately. mx1's error was the reverse move, putting the extremal value into a statement quantified over a fixed frame.

**One direction-of-monotonicity point, which the block does not state and which happens to fall the right way.** Passing from $t\ge\tau_n$ to $f(t)\le f(\tau_n)$, where $f(t)=\sqrt t\,\Theta_n+(1-t)\Lambda_n/\sqrt t$, needs $f$ decreasing, and $f'(t)=\frac1{2\sqrt t}\big[\Theta_n-\Lambda_n(1+1/t)\big]$ is negative on $(0,1]$ exactly when $\Lambda_n\ge\Theta_n/2$. That inequality does hold, by section 10's witness, so the plug-in step is valid. It is also what kills the route, since the same condition puts the whole curve above $\Theta_n$.

## 3. L120 at $D$, and $\mathcal D_n$ as the fixed subspace

**The quoted hypothesis is the right one and $D$ satisfies it.** [L120](../findings/second-order.md)'s sentence reads *at every diagonal $M$, criticality is unused, $\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed*, and that clause carries a Gate 2 verdict of its own ([r345](REVIEW_r345.md), [r346](REVIEW_r346.md), [r507](REVIEW_r507.md), [r508](REVIEW_r508.md)). The title's *at every diagonal critical point* is the heading's scope, not the statement's hypothesis. $D$ is diagonal in $F$ by construction, so the lemma applies at $D$ whether or not $D$ is critical.

**The one-line proof that $\mathcal D_n$ is exactly the $\Gamma$-fixed subspace is correct.** A sign flip acts on $e_{ij}$ by $\varepsilon_i\varepsilon_j$, hence on the entry $e_{ij}\odot e_{kl}$ by the character $\varepsilon_i\varepsilon_j\varepsilon_k\varepsilon_l$, which is trivial exactly when $\{i,j\}=\{k,l\}$, because otherwise the symmetric difference is a nonempty even set and flipping one of its indices flips the sign. So the trivial isotypic of $\mathrm{Sym}^2(\Lambda^2)$ is the pair diagonal, and intersecting with the Weyl conditions gives $\mathcal D_n$, which is [L120](../findings/second-order.md)'s own character computation read at $S=\emptyset$. **The block's wording compresses the character to $\varepsilon_i\varepsilon_j$ where the entry's character is the product of four signs**, a cosmetic slip with the right conclusion.

**And the scalar the block needs has a second, shorter proof that avoids block-diagonality altogether.** $\circ$ is $O(n)$-equivariant and $Q(\mathcal W_n)\subseteq\mathcal W_n$, so for $g\in\Gamma$, $g\cdot(D\circ D)=(g\cdot D)\circ(g\cdot D)=D\circ D$: the product is $\Gamma$-fixed, so it lies in $\mathcal D_n$ and is orthogonal to $N$. **This matters for scope**, because the full sign group separates all even-subset characters at every $n$, so the $n=4,6,8$ fusion that breaks the determinant-one argument never enters.

## 4. $D$ is in $\mathcal W_n$, and the record already says why

$\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf1=0\}$, the vertex matrices of coordinate-diagonal Weyl operators ([conventions.md](../findings/conventions.md)), and [problem.md](../findings/problem.md) proves the correspondence is a bijection: on the diagonal locus first Bianchi is automatic and Ricci-flatness is exactly $S\mathbf1=0$.

**The row-sum condition survives the projection, which is the load-bearing fact.** Ricci-flatness of $W$ gives $\sum_bW_{abab}=0$ for every $a$, a condition on frame-diagonal entries only, so the pair-diagonal truncation of any $W\in\mathcal W_n$ already satisfies it, and first Bianchi relates only off-diagonal entries, which the truncation sets to zero. Hence the truncation lies in $\mathcal D_n$, and being the orthogonal projection onto the pair diagonal it is the orthogonal projection onto $\mathcal D_n$. **The record states this verbatim** in the [L123](../findings/second-order.md) block: *Ricci-flatness of $W$ reads $\sum_bM_{ab}=0$, a condition on frame-diagonal entries only, so $\operatorname{diag}(M)\in\mathcal W_n$ in every frame and the split sits inside the Weyl space.*

**Why the item is not decoration.** If $\pi_F$ were projection onto diagonal operators without the Weyl conditions, then $D\notin\mathcal W_n$, $X\notin T_WS$, and [L24](../findings/second-order.md)'s cap would not apply to $X$ at all, which is the same defect that felled mx1 by a different door.

## 5. The two relations, re-derived, and the symmetry they rest on

**Total symmetry of $T(X,Y,Z)=\langle X\circ Y,Z\rangle$.** $\circ$ is the polarisation of the quadratic $Q(X)=X^2+X^\#$, so $T$ is trilinear symmetric in its first two slots. For the $X^2$ half, $\langle\tfrac12(XY+YX),Z\rangle=\tfrac12\operatorname{tr}(XYZ+YXZ)$, the symmetrisation of $\operatorname{tr}(XYZ)$, invariant under every permutation. For the $\#$ half, the form is $\sum c_{abc}c_{a'b'c'}X_{aa'}Y_{bb'}Z_{cc'}$, and permuting the three slots permutes the indices of both totally antisymmetric $c$'s, so the two signs cancel. **This is the record's own argument** in [L24](../findings/second-order.md), credited to [r285](REVIEW_r285.md) Claim 1, and I verified the mechanism rather than re-deriving the structure constants.

**Relation one.** $\langle W,D\rangle=t$ since $N\perp D$, and $Q(W)=D\circ D+2D\circ N+N\circ N$ pairs with $D$ to $P(D)+2T(D,N,D)+T(N,N,D)$. Total symmetry sends $T(D,N,D)\mapsto T(D,D,N)=0$ and $T(N,N,D)\mapsto T(D,N,N)=a$. So $\theta t=P(D)+a$.

**Relation two.** $\langle W,N\rangle=1-t$ since $\lVert W\rVert=1$, and pairing with $N$ gives $T(D,D,N)+2a+P(N)$ with the first term zero. So $\theta(1-t)=2a+P(N)$.

**Both rest on the single scalar $T(D,D,N)=0$**, and the block's claim that its two quoted consequences of [L120](../findings/second-order.md) deliver one number is right: $\langle D\circ D,N\rangle$ and $\langle D\circ N,D\rangle$ are the same entry of a totally symmetric form.

## 6. The cancellation

$W\circ X=(D+N)\circ(tN-(1-t)D)=(2t-1)D\circ N-(1-t)D\circ D+tN\circ N$, as written. Pairing with $X$ gives six trilinear terms:

$$\langle L_WX,X\rangle=(2t-1)\big[t\,T(D,N,N)-(1-t)T(D,N,D)\big]-(1-t)\big[t\,T(D,D,N)-(1-t)T(D,D,D)\big]+t\big[t\,T(N,N,N)-(1-t)T(N,N,D)\big].$$

With $T(D,N,D)=T(D,D,N)=0$ and $T(N,N,D)=a$, the $a$ coefficient is $t(2t-1)-t(1-t)=3t^2-2t$ and the rest is $(1-t)^2P(D)+t^2P(N)$, which is the block's line. Substituting the two relations, the $a$ coefficient is $3t^2-2t-(1-t)^2-2t^2=-1$ identically, and the remainder is $\theta t(1-t)^2+\theta t^2(1-t)=\theta t(1-t)$. **So $\langle L_WX,X\rangle=\theta t(1-t)-a$, done symbolically in $t$ and not at a point.**

**Nothing was dropped.** The two terms that disappear are $T(D,N,D)$ and $T(D,D,N)$, both instances of the one scalar the block proves to vanish, and every other term is carried to the end. The Lean certificate `linear_combination (-(1-t)^2) * hr1 - t^2 * hr2` is exactly the substitution above with the two relations weighted $-(1-t)^2$ and $-t^2$, which is what the kernel checks.

## 7. The test vector and its two ends

$\langle X,W\rangle=t(1-t)-(1-t)t=0$ and $\lVert X\rVert^2=t^2(1-t)+(1-t)^2t=t(1-t)$, both re-derived. **At the ends the lemma says nothing false.**

- At $t=0$, $D=0$, so $X=0$, and relation one reads $0=0+a$, forcing $a=0$. The inequality reads $0\ge0$, true and empty.
- At $t=1$, $N=0$, so $X=0$ and $a=0$. Relation one reads $\theta=P(D)$, relation two $0=0$, and the second form $P(D)\le\tfrac\theta2t(1+t)$ reads $\theta\le\theta$. **The inequality is exactly attained at $t=1$ rather than vacuous**, which is the same statement as the bound of section 9 returning $\Theta_n$ in that limit.

**The omission is one paragraph later.** *Where it points* divides by $\sqrt t$ and by $1-t$, so $d$, $\nu$ and the final bound require $0<t<1$, which the block does not say.

## 8. L24's scope, and the quantifier in the statement

**The lemma is conditional, so its own logic is safe.** Its hypothesis is *if in addition $L_W\le\tfrac\theta2$ on $W^\perp$*, and everything downstream uses only that. The inequality is therefore claimed at exactly the critical points that satisfy the cap, a set that contains the maximisers and may contain non-maximisers.

**The attribution clause is what overreaches.** [L24](../findings/second-order.md) gives $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ at a local maximiser, and converting that to $L_W\le\tfrac\theta2$ multiplies by $\theta$, so $\theta>0$ is needed twice, once for $e=W/\theta$ and once for the direction of the inequality. The record's own scope for [L24](../findings/second-order.md) says $\theta>0$ is automatic at a GLOBAL maximiser, that a LOCAL maximiser is known only to satisfy $\theta\ge0$, and that the $\theta=0$ branch is **OWED**, with *every consumer applying L24 at a local maximiser inherits that debt*. **So *which L24 gives at every maximiser* should read *at every global maximiser, and at every local maximiser with $\theta>0$*, and L214 is one of the consumers that inherits the owed branch.** This is a GAP in the wording rather than in the mathematics: the cap is a hypothesis, and the open statement the route aims at concerns $\theta$ near $\sqrt{3/2}>0$, where the debt is inert.

## 9. The consequence, and $\Theta_n$ as the constant

**The algebra is exact.** $P(D)=t^{3/2}P(d)$ and $a=\sqrt t(1-t)\langle L_d\nu,\nu\rangle$, so relation one becomes $\theta\sqrt t=tP(d)+(1-t)\langle L_d\nu,\nu\rangle$, which rearranges to both forms the block prints, for $0<t<1$.

**The normalisations agree, and the factor of two is handled.** In the pair-basis Frobenius convention $\lVert W\rVert^2=\operatorname{tr}(W^2)=\sum_{i<j}M_{ij}^2$ on the diagonal locus, and the record's other convention is $t=\lVert K\rVert_F^2=2\sum_{i<j}M_{ij}^2\le2$. So [L57](../findings/problem.md)'s $\operatorname{tr}S^2=2$ is exactly $\lVert W\rVert=1$ here, and the block's $t\in[0,1]$ is the record's $t\in[0,2]$ halved. **The cross-check is [DERIVE-mx1](DERIVE-mx1.md)'s padded $\mathbb{CP}^2$ table at $t_F=1$ against the sweep's $t=\tfrac12$ for the same point**, which is the same factor read in both files.

**$\Theta_n$ is the right constant, and the brief's two worries both resolve.** The critical-point form quoted in the brief is not the record's canonical one: [problem.md](../findings/problem.md) states [L57](../findings/problem.md) as $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ **for every diagonal $W$ at every $n\ge4$**, and names *the bridge from a critical point to every diagonal $W$* as one of its five proved steps. That is exactly $\sup P(d)\le\Theta_n$ over unit $d\in\mathcal D_n$, and since $\mathcal D_n$ is a linear space and $P$ is odd it is also $\sup\lvert P(d)\rvert$. **The independent argument is available too**: $P$ attains its maximum on the compact unit sphere of $\mathcal D_n$, and [L120](../findings/second-order.md) makes $Q(\mathcal D_n)\subseteq\mathcal D_n$, so the constrained critical point equation is $Q(d)=\lambda d$ in the full space with $\lambda=P(d)$, which is L57's hypothesis with nothing lost to the projection. **And $\Theta_n$ rather than $\theta_0(n)$ is the correct choice**, the two agreeing at even $n$ and $\Theta_n<\theta_0(n)$ at odd $n$, so the block's constant is the stronger one where they differ. The sweep's draft wrote $\theta_0(n)$ and the block corrected it.

**One inherited debt to state.** [L57](../findings/problem.md)'s own block records that $\lvert Z(v)\rvert^2=\frac{n^2-3n+3}{2(n-1)(n-2)}-\frac n{2(n-2)}\sum v_i^4$ has **no derivation on file**, that every constant in $\Theta_n$ comes off that line, and that *a consumer of L57 inherits them*. L214's consequence is such a consumer.

## 10. The reduction is refuted, by the route's own witness

**Write the bound as $f(t)=\sqrt t\,\Theta_n+(1-t)\Lambda_n/\sqrt t$ on $0<t<1$, and note first that $f(t)\le\Theta_n$ is equivalent, with $u=\sqrt t<1$, to $\Lambda_n(1+u)\le\Theta_nu$, hence to $\Lambda_n\le\Theta_nu/(1+u)<\Theta_n/2$.** So the moment $\Lambda_n\ge\Theta_n/2$, the bound exceeds $\Theta_n$ at every $t\in(0,1)$ and equals it only in the limit $t\to1$, which is the diagonal case the programme grants.

**$\Lambda_n\ge\sqrt3/2=0.866025$ at every $n\ge4$, and two independent derivations give the same number.**

- **From [L121](../findings/second-order.md), which needs diagonality alone.** Take $d$ with sectional matrix $M_{12}=M_{34}=\tfrac12$, $M_{13}=M_{24}=-\tfrac12$, zero elsewhere, padded into $\mathcal D_n$. Row sums vanish, and $\operatorname{tr}M^2=2$, so $d$ is a unit element of $\mathcal D_n$. On the four-set $\{1,2,3,4\}$ the opposite-pair sums are $A=1$, $B=-1$, $C=0$, so $\Sigma=A^2+B^2+C^2-AB-BC-CA=3$ and the four-set block of $L_d$ has top eigenvalue $\tfrac12\sqrt\Sigma=\sqrt3/2$ on a unit $\nu\in V_{1234}\subset\mathcal D_n^\perp$.
- **From the record.** [Route D of the sweep](2026-09-13b-LIT-step8-sweep.md) writes, of padded $\mathbb{CP}^2$'s natural frame, *the split is $d=W_{S^2\times S^2}$, $t=\tfrac12$, and the relation returns $\langle L_d\nu,\nu\rangle=\sqrt3-\tfrac{\sqrt3}2=\tfrac{\sqrt3}2$ exactly.* It is the same $d$ and the same number, reached through criticality instead of through L121. *The cross-check that the two agree: $\theta(S^2\times S^2)=\sqrt{3}/2$ and [L121](../findings/second-order.md)'s $L_e$ value $\frac{n-2}{2(p-1)(q-1)}=1$ at $n=4$ multiply to the same $\sqrt3/2$.*

**And $\Theta_n/2<\sqrt2/2=0.7072<\sqrt3/2$ at every $n$, so the condition fails at every dimension, not only at $n=12$.**

**The numbers the brief asks for, at $n=12$ with $\Theta_{12}=1.236033$ and target $\sqrt{3/2}=1.224745$.** Minimising $f$ gives $t^*=\Lambda_n/(\Theta_n-\Lambda_n)$ and $\min f=2\sqrt{\Lambda_n(\Theta_n-\Lambda_n)}$, so the bound reaches the target at some $t$ only if

$$\Lambda_{12}\ \le\ \tfrac12\Big(\Theta_{12}-\sqrt{\Theta_{12}^2-\tfrac32}\Big)\ =\ 0.534683,$$

and then only in the window around $t^*=0.7624$. If instead the frame is the one the Schur average supplies, $\bar t=6/((n+1)(n+2))=0.032967$, the requirement tightens to $\Lambda_{12}\le0.18785$. **The true value is at least $0.866025$, so the first requirement fails by a factor of $1.62$ and the second by $4.6$, and no $\tau_n$ repairs either**: with $\Lambda_{12}=0.866025$ the curve is strictly decreasing on $(0,1]$ with infimum $f(1)=\Theta_{12}=1.236033$, above the target at every $t<1$.

**The same arithmetic at the conjectured extremal non-diagonal point.** At padded $\mathbb{CP}^2$, $\theta=\sqrt{3/2}$ and $t=\tfrac12$ in its natural frame, and $f(\tfrac12)=1.486380$. The bound is valid there and slack by $21\%$, which is the shape of the loss: the chain replaces one Rayleigh quotient at one point by a supremum over all unit diagonal $d$ and all unit $\nu$, and that supremum is realised by a padded $S^2\times S^2$ which is not a maximiser at all. **[L121](../findings/second-order.md)'s own maximiser inequality $\Sigma\le\theta^2$ fails at that witness, $3$ against $0.75$, which is the sense in which $\Lambda_n$ throws criticality away.**

**So the two ingredients the block names, [I92](../plan.md) and [I93](../plan.md), cannot close the open statement.** *What a repair would need is a bound on $\langle L_d\nu,\nu\rangle$ at the actual split of a maximiser rather than a dimension constant, and the natural source is the second relation with L24's cap, which gives $\Lambda_n\ge\tfrac\theta2\sqrt{t_F}$ in every frame and so constrains any closed form I93 produces from below.* **The lemma's exact relations survive this verdict untouched.** They hold in every frame at every critical point, and they are the first statement on the record constraining a critical point through an arbitrary frame, which is worth keeping whatever the route does.

## 11. Nothing of this is already on the record

**The two relations and the inequality appear in exactly one earlier place, [Route D of the 2026-09-13b sweep](2026-09-13b-LIT-step8-sweep.md), which is the block's own origin and is cited as such.** The sweep's cancellation is written as $\langle L_WX,X\rangle=P(D)-\theta t^2$, which is the block's $\theta t(1-t)-a$ after relation one, so the two agree. **The block improved two things over its origin**: $\Theta_n$ in place of $\theta_0(n)$, and the observation that the two frame inputs are one scalar.

**What was already on file, and is credited there rather than here.** [DERIVE-mx1](DERIVE-mx1.md) records the orthogonal decomposition $\lVert\operatorname{diag}(M)\rVert^2+\lVert R\rVert^2=\lVert W\rVert^2$, and states that both halves of the $t_F$ bookkeeping were already on the record, $\sum d_\varphi^2=t/2$ in [bispectral.md](../findings/bispectral.md) and $\lVert R\rVert^2=1-t_F/2$ in [target.md](../findings/target.md). **None of those is a projection of the criticality equation**, so the relations are new. The [L120](../findings/second-order.md) to [L123](../findings/second-order.md) blocks carry the ingredients, the isotypic decomposition, the block forms and the zero-diagonal Rayleigh vanishing, and none carries the split. A search of [findings/](../findings/), [reviews/](.) and [verification/](../verification/) for the split, for $\langle L_DN,N\rangle$ and for $\Lambda_n$ returned only the block, its index rows and the sweep.

## 12. What would break it, and what I did to look

**For the lemma, four candidates, all closed.**

- **A frame where $\langle D\circ D,N\rangle\ne0$.** It would need $\mathcal D_n$ to be strictly smaller than the $\Gamma$-fixed subspace, or $Q$ to leave $\mathcal W_n$. I checked both, and the scalar has two independent proofs, L120's block-diagonality and the bare equivariance argument of section 3.
- **A maximiser and a frame where $X\not\perp W$.** This is mx1's falsifier and it cannot recur, the orthogonality being an identity in $t$ rather than a property of the frame.
- **A term dropped in step 3.** I expanded all six trilinear terms rather than following the block's grouping, and the two that vanish are instances of the one scalar.
- **$D$ outside $\mathcal W_n$.** Checked against the definition of $\mathcal D_n$ and the row-sum argument, and it is the projection onto the Weyl diagonal locus.

**For the reduction, the falsifier the sweep itself names, *$\Lambda_n$ so large that the bound never reaches $\sqrt{3/2}$*, and it exists.** I looked for it by asking what $\Lambda_n$ must satisfy before asking what it is, which gave the threshold $\Theta_n/2$, and then by evaluating [L121](../findings/second-order.md)'s closed form at the most concentrated four-set configuration in $\mathcal D_n$. The witness is the padded $S^2\times S^2$, the same object the sweep had already evaluated at padded $\mathbb{CP}^2$'s frame and recorded the number for. **The refutation was on the page that proposed the route.**

## The Lean file

**What type-checks is the block's vector algebra exactly, with the two facts about $\mathcal W_n$ as hypotheses, and the file says so.** `T` is an abstract totally symmetric trilinear form, symmetry entering as the two transpositions that generate $S_3$, criticality as $T\,W\,W\,x=\theta\,ip\,W\,x$ for every $x$, unit norm as $ip\ N\ N = 1-t$ beside $ip\ D\ D = t$ and $ip\ D\ N = 0$, and L120's output as `hperp : T D D N = 0`. The eight declarations are the two relations, the two test-vector facts, the cancellation and the inequality, with `expand_pair` and `perm_values` as lemmas.

**The abstraction drops nothing the block's proof silently uses.** The written proof needs bilinearity, total symmetry, the paired criticality equation, one vanishing scalar and the orthogonal splitting with its norms, and all five are hypotheses in the file. The identities are in fact proved more generally than the block needs, `ip` being any symmetric bilinear form and $t$ unconstrained, so no positivity or range is assumed.

**Two seams to record.** `maximiser_ineq` takes the cap already evaluated at the test vector and already written as $\tfrac\theta2(t(1-t))$, so composing it with [L24](../findings/second-order.md) needs `test_perp`, `test_norm` and the multiplication by $\theta>0$, none of which the file joins into a single theorem. And nothing in the file touches the two real debts, that $\mathcal D_n$ is the $\Gamma$-fixed subspace and that the cap holds, which [lean/INDEX.md](../lean/INDEX.md) states plainly.

## Verdicts

**Lemma L214: CONFIRMED.** *Both relations and the inequality are correct as stated, every step holds in an arbitrary orthonormal frame, $t$ is the frame's own value throughout, and neither of [DERIVE-mx1](DERIVE-mx1.md)'s two mistakes recurs. Two wording repairs are owed: the attribution of the cap to* every maximiser *should name the global maximiser and the local maximiser with $\theta>0$, inheriting [L24](../findings/second-order.md)'s owed $\theta=0$ branch, and the* where it points *paragraph should state $0<t<1$.*

**The reduction of item 10: REFUTED.** *The bound $\theta\le\sqrt t\,\Theta_n+(1-t)\Lambda_n/\sqrt t$ exceeds $\Theta_n$ at every $t\in(0,1)$ whenever $\Lambda_n\ge\Theta_n/2$, and $\Lambda_n\ge\sqrt3/2$ at every $n$, from a padded $S^2\times S^2$ through [L121](../findings/second-order.md) and equally from the sweep's own padded $\mathbb{CP}^2$ datum. At $n=12$ reaching $\sqrt{3/2}$ needs $\Lambda_{12}\le0.534683$, and reaching it in the Schur-average frame needs $\Lambda_{12}\le0.18785$. So [I92](../plan.md)'s lower bound on the diagonal mass and [I93](../plan.md)'s closed form for $\Lambda_n$ do not suffice however they turn out, and a route built on them should be re-planned around a bound on the Rayleigh quotient at the maximiser's own split rather than a dimension constant.*
