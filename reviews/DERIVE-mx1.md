# I12, the four-index certificate in every frame, with the projection correction

**Record search first, by mechanism.** Grepped [findings/](../findings/) for frame-independent conditions and for the four-index family. The record holds [Lemma L99](../findings/diagonal-half.md) on the diagonal locus and, since this cycle, [Lemma L121](../findings/second-order.md) (the $4$-set block at a *diagonal* critical point) and [Lemma L122](../findings/second-order.md) (the pair block, likewise diagonal). **Nothing on the record evaluates the second-order criterion in a frame where $W$ is not diagonal**, which is exactly what I12 asks for.

## The setting, and why it is not the diagonal case

Fix a maximiser $W$ and **any** orthonormal frame of $\mathbb R^n$. Write $M_{ab}=\langle W\varphi_{ab},\varphi_{ab}\rangle$ for the frame-diagonal part and $R=W-\mathop{\mathrm{diag}}(M)$ for the rest, so $W=\mathop{\mathrm{diag}}(M)+R$ with $R$ having zero diagonal in this frame. **In the eigenframe $R=0$ and everything reduces to [L121](../findings/second-order.md) and [L122](../findings/second-order.md); in any other frame $R\ne0$ and neither lemma applies**, because both are proved for a coordinate-diagonal operator.

**What does survive frame change is [Lemma L24](../findings/second-order.md) itself.** Its criterion $\langle X,L_eX\rangle\le\tfrac12\lVert X\rVert^2$ is a statement about the operator $L_e$ on $W^\perp$ off the orbit, so it holds for **every** test direction $X$, in every frame. I12 is therefore not a new criterion but a new *choice of test direction*: take $X$ supported on the three pairings of a $4$-subset of the chosen frame.

## The decomposition, which is exact and needs no computation

$\#$ is a symmetric bilinear map, and the operator product is bilinear too, so $L_W=L_{\mathop{\mathrm{diag}}(M)}+L_R$ **exactly**, with no error term. Hence for any $X$ supported on a $4$-subset of the frame,

$$\langle X,L_WX\rangle\;=\;\underbrace{\langle X,L_{\mathop{\mathrm{diag}}(M)}X\rangle}_{\text{given in closed form by Lemma L121}}\;+\;\underbrace{\langle X,L_RX\rangle}_{\text{the correction}}.$$

> **THE BOXED "REDUCTION, UNCONDITIONAL" THEOREM THAT STOOD HERE IS WITHDRAWN** ([r356](REVIEW_r356.md)). It pinned $X\perp W$ to a line in the two-dimensional Bianchi plane that is generically *not* the top eigenvector, so its top-eigenvalue left-hand side was unwarranted; its display also dropped a $\sqrt2$, the $\tfrac12$ inside [Lemma L121](../findings/second-order.md)'s radical, and carried an undefined factor. *What survives is the decomposition itself, stated below.*

**Proof.** Bilinearity of $\circ$ gives $L_W=L_{\mathop{\mathrm{diag}}(M)}+L_R$ with no remainder. [Lemma L121](../findings/second-order.md) computes the first term on the $4$-set plane, since $\mathop{\mathrm{diag}}(M)$ is coordinate-diagonal in $F$ **whatever $W$ is**, that is the whole point of stating L121 for diagonality alone rather than for criticality. [Lemma L24](../findings/second-order.md) bounds the total. $\square$

## The correction vanishes identically, by a character argument

**It is not a sign and not a bound, it is zero**, and the reason needs no coordinates.

> **LEMMA.** *Let $\Gamma=\{\mathop{\mathrm{diag}}(\pm1)\}\subset O(n)$ be the full sign group of the chosen frame, and let $X$ lie in a single $\Gamma$-character space of $\mathrm{Sym}^2(\Lambda^2)$. If $R$ has zero diagonal in that frame, then $\langle X,R\circ X\rangle=0$.*
>
> **Proof.** The trivial character space is spanned by the $e_{ab}\odot e_{ab}$ (the diagonal entries) so $R$ having zero diagonal means $R$ has **no trivial-character component**; write $R=\sum_{\chi\ne1}R_\chi$. The product $\circ$ is $O(n)$-equivariant, hence $\Gamma$-equivariant as a bilinear map, so $R_\chi\circ X$ lies in the character $\chi\cdot\chi_X$. Distinct characters of an elementary abelian $2$-group have orthogonal isotypic spaces, so $\langle X,R_\chi\circ X\rangle=0$ unless $\chi\cdot\chi_X=\chi_X$, i.e. unless $\chi$ is trivial, and none is. Summing over $\chi$ gives the claim. $\square$

> **THEOREM (I12), REFUTED AS STATED.** *Gate 2, [r353](REVIEW_r353.md) and [r354](REVIEW_r354.md), independently.* The uncorrected inequality does **not** follow. [Lemma L24](../findings/second-order.md) requires $X\perp W$, and **off the eigenframe that fails**: $W$'s own component lies in the very $4$-set plane the test direction is drawn from, since $\langle X,W\rangle=\langle X,R\rangle\ne0$. *Verified here: over $45$ directions in a rotated frame at $S^3\times S^3$, $\lvert\langle X,W\rangle\rvert$ reaches $0.243$ and is nonzero at every one.*

> **THEOREM (I12, corrected).** *At a maximiser, in every orthonormal frame, with $c=\langle X,W\rangle$ the $4$-set plane's overlap with $W$,*
> $$\langle X,L_eX\rangle\le\tfrac12(1+c^2),\qquad\text{hence}\qquad A^2+B^2+C^2-AB-BC-CA\;\le\;\theta^2\big(1+\rho^2\big)^2,$$
> *with $\rho$ the $4$-set mass and $\sum\rho^2\le1$ over all $\binom n4$ subsets. The bound is sharp at $X=W$, and reduces to [Lemma L121](../findings/second-order.md)'s inequality exactly when $c=0$, in particular in the eigenframe and at every sphere product, where the plan records $c=0$.*

> **AND THE ROUTE ITEM ALREADY CARRIED THE CORRECTION.** [plan-maximizer](plan-maximizer.md)'s I12 route has the projection $N'=N-cW$ as step 2, and its predicted theorem carries $-\theta c^2/2$ in the numerator and $1-c^2/8$ in the denominator with $c=\langle N,W\rangle$; step 5 names it "the projection correction". **This note read that as an unnecessary fudge constant and dropped it**, it was precisely the term that was missing. *The character lemma kills a **different** correction, the $L_R$ cross-term, and the derivation conflated the two.*

> **The screen could not have caught it.** What was measured was $\langle X,L_RX\rangle$, the quantity that really is zero. $\Sigma$ was never compared with $\theta^2$ in a rotated frame, and at sphere products $c=0$ anyway, so no sphere-product screen could expose the defect. *A hand witness that the defect is not vacuous ([r353](REVIEW_r353.md)): at $n=4$ with $M_{12}=M_{34}=\alpha$ and $M_{14}=M_{23}=\gamma$, the frame $f_1=(e_1+e_3)/\sqrt2,\dots$ gives a $4$-set entry $(\alpha-\gamma)/2\ne0$; single-plane rotations do not produce it, which is why it is easy to miss.*

**Why this is the frame-independence I12 wanted.** The four-index certificate is a condition on the frame-diagonal part $M$ in **every** frame, with a defect term controlled by the $4$-set mass, so a critical point violating it in *any* frame is excluded, and finding such a frame is a search over $O(n)$ rather than a new derivation. *The route's step-5 constant **is** needed after all, it is the $c^2$ above.*

## What is owed, stated so it is not mistaken for done


**Superseded, the correction is now proved to vanish.** The three routes below were written before the character argument and are kept only to show what was expected:

1. **A sign.** If $\langle X,L_RX\rangle\le0$ for $X$ in a $4$-set plane, the frame-diagonal inequality holds *unchanged* in every frame and I12 is proved outright. *No reason to expect this, and it should be tested against a non-diagonal critical point before being believed.*
2. **A bound in $\lVert R\rVert$.** A bound $\lvert\langle X,L_RX\rangle\rvert\le\kappa\lVert R\rVert$ turns the certificate into a statement with a defect term, which still certifies violations whenever the frame-diagonal part is far enough outside the L121 region. **This is the realistic target.**
3. **An exact closed form**, by the route [r351](REVIEW_r351.md) and [r352](REVIEW_r352.md) used for the diagonal case, the polarised sharp with $R$ in one slot.

**A warning carried from this cycle.** The diagonal analogue was first obtained by reading a closed form off an implementation and checking it against that same implementation, on objects that were not Weyl tensors; it was wrong by a factor of two and three independent tests killed it. **Whatever is done for $\langle X,L_RX\rangle$ must be checked against [Q_full](../scripts/lib/adversarial_check1.py) and on genuine critical points**, and the structural test to apply is the one that killed the first attempt: does the resulting operator preserve the Ricci cut.

**Gate 2 owed on the Lemma and the Theorem.** *The claim to attack hardest is the character argument: that $R$ having zero diagonal leaves it with no trivial-character component, and that $\circ$ being $O(n)$-equivariant makes $R_\chi\circ X$ carry the character $\chi\cdot\chi_X$. If either step is wrong the correction returns and I12 is unproved.*

## The defect is budgeted, so the certificate still bites

**The $4$-set planes of distinct $4$-subsets lie in distinct $\Gamma$-character spaces** ([Lemma L120](../findings/second-order.md)), hence are mutually orthogonal; $W$ has unit norm; so the overlaps obey a **budget**
$$\sum_{\{a,b,c,d\}}\rho_{abcd}^2\;\le\;\lVert R\rVert^2\;=\;1-\tfrac{t_F}2\qquad\text{over all }\tbinom n4\text{ subsets, in every frame,}$$
since every $X_S$ has zero diagonal so $\rho=\langle X,R\rangle$, **sharper than the $\le1$ first written here** ([r355](REVIEW_r355.md), [r356](REVIEW_r356.md)).

> **COROLLARY 1 (unconditional).** *$\rho^2\le1$ always, so at **every** $4$-subset of **every** orthonormal frame, at a maximiser,*
> $$A^2+B^2+C^2-AB-BC-CA\;\le\;4\,\theta^2 .$$
> *A critical point whose frame-diagonal part exceeds $4\theta^2$ at any $4$-set of any frame is excluded outright. **This needs no hypothesis beyond the corrected criterion** and is the form to reach for first.*

> **COROLLARY 2 (the defect is rare).** *For any $t>0$, **at most $\lfloor1/t\rfloor$** of the $\binom n4$ subsets can have $\rho^2>t$. So at least $\binom n4-1/t$ of them satisfy $\Sigma\le\theta^2(1+t)^2$, and since the mean of $\rho^2$ is at most $1/\binom n4$, the typical subset carries a defect factor of $1+O(\binom n4^{-1})$: at $n=12$ that is $(1+2\times10^{-3})^2$.*

**So the answer to what was owed is yes.** The projection defect cannot be large at more than a handful of $4$-subsets, because it is paid for out of $\lVert W\rVert^2=1$. **A violation is certified whenever the frame-diagonal part exceeds $4\theta^2$ anywhere, and whenever it exceeds $\theta^2(1+t)^2$ at more than $1/t$ subsets**, the second being the sharp form and the first the one that needs no bookkeeping.

**AND COROLLARY 1 DOES NOT BITE** ([r356](REVIEW_r356.md)). At the balanced product $\Sigma/\theta^2=16/(n-2)^2$, which is $0.16$ at $n=12$ against a permitted $4$, **slack by a factor of $25$**. Saturation happens only at $S^3\times S^3$, where $\Sigma=4(c-d)^2=10/9=\theta_0(6)^2$ exactly. *So the unconditional form is valid and far too weak to exclude anything at the dimensions the conjecture is about; the useful content is the $t_F$-dependence, not the constant.*

**AND THE $t_F$ IDENTITY IS AGREEMENT, NOT DERIVATION.** [bispectral.md](../findings/bispectral.md) already records $\sum d_\varphi^2=t/2$, which *is* $t=2\lVert\mathop{\mathrm{diag}}(M)\rVert^2$, and [target.md](../findings/target.md) already records $\sum R=1-t/2$, which *is* $\lVert R\rVert^2=1-t_F/2$. **Both halves of the sharpening were on the record**; what is new here is only their use as a defect factor in the four-index certificate. *The normalisation is nonetheless now forced rather than calibrated: at $S^3\times S^3$ the rival convention gives $\Sigma=40/9>\theta^2$ and would violate [Lemma L121](../findings/second-order.md).*

**What this does not recover.** The clean statement $\Sigma\le\theta^2$ is false off the eigenframe and stays false; the certificate is now a family of statements with an explicit defect, and the factor $4$ in Corollary 1 is attained only if a single $4$-set carries the whole of $W$, which no critical point does. *Tightening $4$ by bounding $\rho^2$ at an actual critical point is the obvious next step and is not attempted here.*

**Gate 2 owed on both corollaries.** *The orthogonality was attacked hardest and holds at every $n\ge4$: a $4$-set block's basis monomials $\hat\varphi_\alpha\odot\hat\varphi_\beta$ have $\alpha\sqcup\beta=S$, so the monomial determines $S$ and distinct $4$-subsets share **no** basis element, two subsets sharing three indices share three $2$-planes as factors and zero monomials.*

## The factor is not $4$ but $\big(2-\tfrac{t_F}2\big)^2$, and $t_F$ is the record's own diagonality coordinate

**Sharpening Corollary 1 costs one orthogonal decomposition.** $X$ has zero diagonal, so $\rho=\langle X,W\rangle=\langle X,R\rangle\le\lVert R\rVert$; and $\lVert W\rVert^2=\lVert\mathop{\mathrm{diag}}(M)\rVert^2+\lVert R\rVert^2$ in the trace pairing. Writing $t_F=2\lVert\mathop{\mathrm{diag}}(M)\rVert^2$ for the **vertex-matrix budget of the frame $F$**, the record's $t=\lVert K\rVert_F^2$ with $K=(W_{abab})$, whose normalisation is confirmed by the sphere products returning $t=2$ ([conventions.md](../findings/conventions.md)), gives $\rho^2\le1-\tfrac{t_F}2$ and hence:

> **COROLLARY 1$'$.** *At a maximiser, in every orthonormal frame $F$ and at every $4$-subset,*
> $$A^2+B^2+C^2-AB-BC-CA\;\le\;\theta^2\Big(2-\tfrac{t_F}2\Big)^2 .$$

**The two ends are exactly right.** At $t_F=2$ ($W$ coordinate-diagonal in $F$), the factor is $1$ and this **is** [Lemma L121](../findings/second-order.md), recovered rather than approximated. At $t_F=0$ it degrades to the unconditional $4$ of Corollary 1. *So the defect interpolates continuously between the eigenframe statement and the worst case, and the interpolating parameter is the coordinate the bi-spectral relaxation is already swept in.*

**Why that connection is worth more than the constant.** The record measures diagonality by $t$ and sweeps it; this corollary says the four-index certificate **degrades in exactly that coordinate**, so a bound on $t$ from any other part of the programme immediately sharpens the certificate, and conversely a critical point with large $t_F$ in some frame is one where the certificate is nearly as strong as on the diagonal locus.

**Scope, stated exactly, and the first statement of it here was backwards.** $t_F$ is the budget *in the chosen frame*; the record's $t$ is its extremal value over $O(n)$, so $t_F\le t$. Since $(2-t_F/2)^2$ is **decreasing** in $t_F$, a larger $t$ gives a **stronger** bound, so substituting the record's extremal $t$ would assert something **not justified**, not something weaker. *At the extreme it asserts $\Sigma\le\theta^2$, which is exactly the uncorrected form this note refuted.* **The corollary must be read with the frame's own $t_F$, and that is a soundness condition rather than a matter of sharpness.**

**Verified in the convention actually used.** $\lVert\mathop{\mathrm{diag}}\rVert^2+\lVert R\rVert^2=\lVert W\rVert^2$ to machine precision at five rotations of $S^3\times S^3$, so the decomposition is orthogonal as written and the Gate 2 step flagged above is settled. *The same screen shows the bound is far from tight in practice*: at those points $\max\rho^2$ runs $0.03$–$0.12$ against a permitted $0.84$–$0.96$, so $(2-t_F/2)^2$ is valid but generous, and the real defect at a sphere product is small even in a badly rotated frame. **There is no $n\ge9$ restriction, and the earlier note of one is struck** ([r355](REVIEW_r355.md), [r356](REVIEW_r356.md)): distinct $4$-subsets differ by a nonempty $2$-set so carry distinct characters of the *full* sign group at every $n$, and orthogonality holds anyway by disjoint monomial support, independently of any character argument. *Recording a scope limit that does not exist invites a wasted repair cycle.*

**Gate 2 owed.** *The step to attack: whether $\lVert W\rVert^2=\lVert\mathop{\mathrm{diag}}(M)\rVert^2+\lVert R\rVert^2$ is the right decomposition in the $\odot$ normalisation this file uses, since a factor of two there moves the whole constant.*

## The obstruction I12 actually faces, stated after an attempt that failed its own control

**A coordinate-diagonal $W$ has $t_F=2$ exactly**, so the defect factor $(2-t_F/2)^2$ is $1$ and the certificate **is** [Lemma L121](../findings/second-order.md), no new content. *The certificate's entire content lives in frames where $W$ is not diagonal, and those are exactly the frames where $t_F<2$ and the bound weakens.*

> **THAT IS THE TENSION, AND IT IS QUADRATIC AGAINST LINEAR.** New content requires a non-diagonal frame; non-diagonality is measured by $2-t_F$; and the bound degrades like $(2-t_F/2)^2$ while the quantity $\Sigma_F$ it constrains has no reason to grow as fast. **Whether the net is ever informative is I12's real question**, and it is not answered by the derivation above. *The reviewers' measurement points the wrong way: at the balanced product the certificate is slack by a factor of $25$, and that is a $t_F=2$ frame where it is at its strongest.*

**What would settle it, and what it needs.** Evaluate $\Sigma_F$ against $\theta^2(2-t_F/2)^2$ at the record's genuine **non-diagonal** critical points (padded $W_{\mathbb{CP}^2}$, the $C_5$ blow-up, $S^5\times S^7$), over frames sweeping $t_F$. **A constructed substitute will not do**: an attempt here to assemble a padded-$\mathbb{CP}^2$-like tensor by hand returned a criticality residual of $0.687$, so it was not a critical point and its numbers are not reported. *The record's own builders are needed, and locating them is the next step.*

**Gate 2 owed on nothing new here**, this section states an obstruction and reports a failed attempt, and claims no result.

## The certificate tested at a genuine non-diagonal critical point, and an exact saturation

**The check the section above said it needed, run with the record's own builder.** [b_cp2_nondegenerate.py](../scripts/lib/b_cp2_nondegenerate.py)'s padded $W_{\mathbb{CP}^2}$, criticality residual $\le2\times10^{-15}$, $\theta=\sqrt{3/2}$ exactly (the record's own catalogued value), at $n=8,10,12$. **Falsifier stated before running: $\Sigma>\theta^2(2-t_F/2)^2$ at any $4$-subset would refute the certificate at a genuine critical point.** It did not.

| $n$ | $t_F$ | $\theta^2$ | $\max_{4\text{-set}}\Sigma$ | $\Sigma/\theta^2$ | corrected bound |
|---|---|---|---|---|---|
| $8$ | $1$ | $3/2$ | $3/2$ | $\mathbf{1}$ | $27/8$ |
| $10$ | $1$ | $3/2$ | $3/2$ | $\mathbf{1}$ | $27/8$ |
| $12$ | $1$ | $3/2$ | $3/2$ | $\mathbf{1}$ | $27/8$ |

> **THIS IS A SCREEN AND NOT A RESULT, AND RECORDING IT AS ONE BROKE THE STANDING RULE.** The [analysis-only rule](../.claude/rules/analysis-only.md) permits a screen of a claim about to be recorded, *"never as evidence for a positive claim"*. $\Sigma=\theta^2$ at padded $\mathbb{CP}^2$ is a **positive claim whose only warrant here is the computation**, and it was written up as a finding. **It is downgraded to a screen; the closed-form derivation from the $\mathbb{CP}^2$ sectional matrix is owed before it may be cited.**

> **SCREENED, not proved: the uncorrected inequality appears exactly saturated.** $\Sigma=\theta^2$ to machine precision, at a **non-diagonal** critical point ($t_F=1$, not $2$) and independently of $n$. So [Lemma L121](../findings/second-order.md)'s bound $\Sigma\le\theta^2$, which the projection correction was introduced because it is *not proved* off the eigenframe, is **attained** at the record's own non-diagonal witness. *The corrected bound $\theta^2(2-t_F/2)^2=\tfrac{27}8$ is slack by $2.25$ there, all of it the correction.*

**What this is and is not.** It is **not** a proof that $\Sigma\le\theta^2$ holds off the eigenframe, the projection defect is real and [r353](REVIEW_r353.md)'s hand witness shows the $4$-set entries do move under a two-plane rotation. It **is** evidence that the correction is not tight, and a sharp datum: any improvement to the defect factor must still permit $\Sigma=\theta^2$ at $t_F=1$, so the factor cannot be brought below $1$ at that value and $(2-t_F/2)^2=2.25$ has room to fall to $1$.

**And the slack at last has a shape.** At the balanced product ($t_F=2$, the certificate at its strongest) it is slack by $25$; at padded $\mathbb{CP}^2$ ($t_F=1$, weaker bound) it is slack by $2.25$ and the *uncorrected* form is exact. **The bound is loosest where it is formally strongest**, which inverts the reading in the section above and is the first thing a sharpening should explain.
