# I106a, the tangency exclusion at $\lvert J\rvert=3$: the working note, 2026-09-16, on Opus

**The item.** [R28](../routes.md)'s first sub-step. *Theorem: on the open stratum, at fixed total norm, the record's linear functional on the $3\times3$ orthostochastic variety has no interior critical point that is a maximum, so the maximum sits on the split locus, which is [L229](../findings/second-order.md).* Owed in order: the variety's equation, the Lagrange conditions, the norm-trade step.

**Searched the repository first, by object, and the objects are absent.** *The orthostochastic equation, a Lagrange treatment on a variety of frames, and the frame functional itself: no findings file, no script, no lemma.* **One trap recorded for the next search**: `∘2` already appears in the record with a DIFFERENT meaning, the Hadamard square of a sectional matrix, in [target.md](../findings/target.md)'s Dirichlet form and [diagonal-half.md](../findings/diagonal-half.md)'s $M^{\circ2}+M^2=\theta M+\mathop{\mathrm{diag}}(s)$, so a grep on that symbol finds the wrong object.

## Piece 1, the variety's equation, and it needs less than the source assumes

**The source's form** ([Bengtsson, Ericsson, Kuś, Tadej and Życzkowski](../references/au-yeung-poon-1979-orthostochastic-numerical-ranges/notes.md) section 3, carrying Au-Yeung and Poon 1979). For a bistochastic matrix laid out as $\begin{pmatrix}x&y&\star\\z&w&\star\\a&b&\star\end{pmatrix}$, it is orthostochastic if and only if $(\sqrt x,\sqrt z,\sqrt a)$ and $(\sqrt y,\pm\sqrt w,\pm\sqrt b)$ are orthogonal for some choice of signs, that is $\sqrt{xy}+\varepsilon_1\sqrt{zw}+\varepsilon_2\sqrt{ab}=0$.

**The derivation, three lines, and it uses only the orthogonality of two columns.** Put $u=q_{00}q_{01}$, $v=q_{10}q_{11}$, $t=q_{20}q_{21}$ for the entrywise products of the first two columns of $Q$. Orthogonality of those columns is
$$u+v+t=0 .$$
The entrywise squares are $xy=u^2$, $zw=v^2$ and $ab=t^2=(u+v)^2$, so
$$ab-xy-zw=(u+v)^2-u^2-v^2=2uv,\qquad 4xyzw=4u^2v^2=(2uv)^2,$$
and therefore $(ab-xy-zw)^2=4xyzw$. $\square$ **The source's sign choices $\varepsilon_1,\varepsilon_2$ are exactly the signs of $u$, $v$ and $t$**, which is why the polynomial form carries none and why no case analysis is needed.

**What this proves that the source states with more hypotheses.** *Bistochasticity is never used, positivity is never used, and no relation among the remaining three entries is used.* **The equation is a fact about any real matrix with two orthogonal columns**, and bistochasticity enters only at the next step, to put the equation in the published shape.

**The bridge to the published form.** On a bistochastic matrix the column sums give $a=1-x-z$ and $b=1-y-w$, and then $ab-xy-zw=1-x-y-z-w+xw+yz$, so the equation reads
$$\boxed{\ (1-x-y-z-w+xw+yz)^2=4xyzw\ }$$
which is the constraint R28 maximises against.

**Typed and proved** in [I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean) as `orthostochastic_eq`, `bridge` and `orthostochastic_poly`, on the standard three axioms, no `sorry`.

**The converse is PROVED, 2026-09-16**, this note's former standing debt. *That the equation cuts out the orthostochastic matrices rather than a larger set*: for non-negative entries it forces $\sqrt{ab}$, $\sqrt{xy}$, $\sqrt{zw}$ into a degenerate triangle, so signs exist with $U+\varepsilon_1V+\varepsilon_2T=0$, the two columns built with those signs are orthonormal, and their cross product completes $Q$. **Typed as `degenerate_triangle` and `columns_from_equation`**, audit clean, reached independently by [r963](REVIEW_r963.md) and [r964](REVIEW_r964.md) and validated here before folding.

**What this does NOT settle is whether R28 is exact.** *R28's object is a coupled PAIR $(R,S)$ sharing the fixed rotation $G=E^{\mathsf T}F$ between the eigenframes, and the two equations constrain each factor while leaving that rotation free, so the relaxation now sits WHOLLY in the coupling.* **Both reviewers concluded that the converse makes R28 exact, and that does not follow.** *The framing came from this note and from the Lean header, both written before piece 2 found the coupled pair, and it was quoted into their brief, so two independent readers agreed on a consequence neither had checked.* **That is the lesson worth keeping**: agreement between readers given the same unchecked premise is not corroboration of it.

**Gate 1.** (b) *Reached a second way.* The identity is proved in Lean from column orthogonality and, independently, screened at $2.5\cdot10^{-16}$ over $20000$ random $Q\in O(3)$ built by QR; the bridge is checked symbolically. (c) *Screen with its control.* The converse direction is sampled rather than assumed, and reported as a screen. (d) *Ceiling.* The derived form matches the published one, which is the source's own statement, so agreement is with the literature rather than with this project's arithmetic.

## What comes next, in the item's order

**Piece 2, the Lagrange conditions.** The functional is $\sum_k\big(\beta\nu_k^2\,p_k^{\mathsf T}\hat Up_k+\nu_k\,p_k^{\mathsf T}Cp_k\big)$, linear in the frame data with weights $(\beta\nu^2,\nu)$, screened to $6\cdot10^{-14}$ in the [sweep](2026-09-16-LIT-step8-sweep.md). *Its stationary points on the variety, with the equation above as the constraint, are what must be classified.* **Piece 3, the norm trade**, which [post F68](../findings/fence-posts.md) says is load-bearing and which the classical theory does not contain, since that theory fixes the spectra.

## Piece 2, first finding: the object is a COUPLED PAIR, not one variety, and R28's cell said otherwise

**The functional, written in the two eigenframes.** With $\hat U=E\mathop{\mathrm{diag}}(u)E^{\mathsf T}$, $C=F\mathop{\mathrm{diag}}(c)F^{\mathsf T}$ and the free frame $P$ carrying $V$'s eigenvectors,
$$p_k^{\mathsf T}\hat Up_k=(u^{\mathsf T}R)_k,\quad p_k^{\mathsf T}Cp_k=(c^{\mathsf T}S)_k,\qquad R=(E^{\mathsf T}P)^{\circ2},\ S=(F^{\mathsf T}P)^{\circ2},$$
so the frame-dependent part of the value is $\sum_k\beta\nu_k^2(u^{\mathsf T}R)_k+\sum_k\nu_k(c^{\mathsf T}S)_k$, **linear in the PAIR $(R,S)$**. *Screened to $1.8\cdot10^{-14}$ over 4000 random $(E,F,P,u,c,\nu)$.*

**And the pair is coupled.** $S=\big(G^{\mathsf T}(E^{\mathsf T}P)\big)^{\circ2}$ with $G=E^{\mathsf T}F$ the FIXED rotation between the two eigenframes, screened to $2.3\cdot10^{-15}$. *So $R$ determines $S$ once $G$ is fixed: the true parameter is $P\in SO(3)$, three dimensions, where two independent orthostochastic matrices would be six.*

**What this does to [R28](../routes.md), and the register is corrected in place.** *That route's cell read "a linear functional on the image of $O(\lvert J\rvert)$ under $Q\mapsto Q^{\circ2}$, the orthostochastic variety", singular.* **The object is a coupled pair of such images**, and [piece 1](#piece-1-the-varietys-equation-and-it-needs-less-than-the-source-assumes)'s equation constrains each factor separately while saying nothing about the coupling. **So maximising against the two equations alone is still a RELAXATION**, weaker than Birkhoff's polytope but not obviously exact, and the tangency exclusion must be carried out on the coupled $3$-manifold rather than on a $4$-dimensional variety.

**Classified against the record, and it is agreement rather than discovery.** *The [three-alignment entry](../ATTEMPTS.md) of 2026-09-16 already identified these objects*, as the three doubly stochastic matrices $(F^{\mathsf T}Q)^{\circ2}$, $(F^{\mathsf T}P)^{\circ2}$ and $(Q^{\mathsf T}P)^{\circ2}$, and recorded that relaxing them to INDEPENDENT ones overshoots by $3.82$. **What is new here is not the objects but the treatment**: the exact variety in place of Birkhoff's polytope, and the coupling retained rather than dropped. *The record's own diagnosis, that the three sorts genuinely conflict, is the same statement as the tangency this route must exclude.*

**What it leaves.** The route is not damaged, since the boundary is still the split locus and the mechanism is unchanged in shape. *What is owed is larger than the item said*: the coupling as an explicit constraint alongside the two equations, before any Lagrange computation is meaningful. **Gate 2 owed on this section, separately from piece 1.**

## Piece 2, second finding: the coupling AS AN EXPLICIT CONSTRAINT, three signed square roots per column

**Derived.** Write $Q=E^{\mathsf T}P$, so $R=Q^{\circ2}$ and $F^{\mathsf T}P=G^{\mathsf T}Q$, giving $S_{ik}=\big(\sum_jG_{ji}Q_{jk}\big)^2$. Expanding the square separates the part that sees only $R$ from the part that carries the coupling:
$$S_{ik}=\big((G^{\circ2})^{\mathsf T}R\big)_{ik}+2\sum_{j<l}G_{ji}G_{li}\,T^{(jl)}_k,\qquad T^{(jl)}_k:=Q_{jk}Q_{lk}.$$
**The three $T^{(jl)}_k$ are exactly the coupling**, and each is a SIGNED square root of a product of $R$'s own entries:
$$\big(T^{(jl)}_k\big)^2=R_{jk}R_{lk},\qquad T^{(12)}_kT^{(13)}_kT^{(23)}_k=R_{1k}R_{2k}R_{3k}\ \ge\ 0.$$
**CORRECTED 2026-09-16 after [r965](REVIEW_r965.md) and [r966](REVIEW_r966.md), which both found a third constraint missing.** The two displays above are PER COLUMN and tie the three columns to nothing, so at a generic $R$ they admit $4^3=64$ sign assignments where only $4$ come from a $Q\in O(3)$. **The omitted relation is $\sum_kT^{(jl)}_k=(QQ^{\mathsf T})_{jl}=0$, the ROW orthogonality of $Q$.** *The $60$ spurious branches keep $S$ non-negative and keep its COLUMN sums, and fail its ROW sums, so they leave the variety entirely.* **r965 PROVED, rather than screened, that the three conditions together cut out exactly the realisable assignments**, the $4$ being the row-sign group $Q\mapsto DQ$ modulo the global sign.

**Two things withdrawn.** *The non-negativity is VACUOUS*: the right side is a product of squares, so it holds whatever the coupling does. *And "the three signs' product is pinned to $+1$" is false wherever an $R_{jk}$ vanishes*, where two $T$ vanish and the third's sign is free, which is the split locus this route aims at. **The comparison to `degenerate_triangle` is also withdrawn**, that being a linear relation among non-negative reals against a multiplicative one among signed reals.

**It needs NO orthogonality**, being the expansion of a square, exactly as piece 1's equation needed only column orthogonality. *The hypotheses enter only where the signs are pinned.*

**What this does to the relaxation.** Maximising against the two equations alone treats $(R,S)$ as independent, which the record already measured as overshooting by $3.82$. **With the display above the pair is a $3$-manifold again**, and the tangency exclusion can be posed on it rather than on a $4$-dimensional variety.

**Gate 1.** (b) *Reached a second way*: the identity is the expansion of $(\sum_jG_{ji}Q_{jk})^2$ and is checked symbolically by `ring` in Lean. (c) *Screened* over $20000$ random $(E,F,P)\in O(3)^3$: the identity to $2.9\cdot10^{-15}$, the squares to $8.3\cdot10^{-17}$, the parity to $2.1\cdot10^{-17}$, and zero sign violations. (d) *Ceiling*: at $G=I$ it collapses to $S=R$, which is right, though [r965](REVIEW_r965.md) notes the test is DEGENERATE, the cross term vanishing at $G=I$ for every value of the $T$ and at every signed permutation, so it checks the first term's index convention and nothing about the coupling. **Gate 2 LANDED 2026-09-16** ([r965](REVIEW_r965.md), [r966](REVIEW_r966.md)).

**Classified against the record, and the classification was WRONG.** *I searched outward, for the Hadamard square of the frame rotation and for signed square roots of entry products, across [findings/](../findings/), [reviews/](../reviews/) and [ATTEMPTS.md](../ATTEMPTS.md), and recorded "genuinely new".* **[r966](REVIEW_r966.md) refuted that one theorem above the code**: the $T^{(jl)}_k$ ARE `orthostochastic_eq`'s three column products read at $Q^{\mathsf T}$, and the omitted row relation IS that theorem's own hypothesis, so it already applied to the coupling. *Reproduced here at max difference $0$ before folding.* **The rule that would have caught it is already in the skill**, to read and grep the file being written into before deriving, and the derivation was written into that very file, about sixty lines below the theorem.


## Piece 2 is FENCED by the record, post F69 for a fifth time, 2026-09-16

**The piece as stated.** *Its stationary points on the variety, with the equation above as the constraint, are what must be classified.* Varying the frame $P$ moves $V$'s eigenvectors while $\hat U$, $C$ and $V$'s spectrum stay fixed, so the tangent is $\dot{\hat U}=0$, $\dot V=[\Omega,V]$ for skew $\Omega$.

**First order is vacuous.** The frame-dependent part is $\beta\mathop{\mathrm{tr}}(\hat UV^2)+\mathop{\mathrm{tr}}(VC)$, whose variation is $\mathop{\mathrm{tr}}\big([\Omega,V](\beta\{\hat U,V\}+C)\big)$, so stationarity for every skew $\Omega$ is $[V,\beta\{\hat U,V\}+C]=0$. **Batch 20's own $V$ equation is $\beta\{\hat U,V\}+C\equiv\mu V$**, so the bracket is $[V,\mu V]=0$ identically. *This is [post F69](../findings/fence-posts.md)'s prescribed test passed in the negative, and on a direction distinct from batch 33's joint conjugation.*

**Second order is batch 21 at $X=0$.** Evaluating batch 21's joint condition at $(X,Y)=(0,[\Omega,V])$ reproduces the frame second variation exactly. **Batch 21's own $X=0$ specialisation covers it**, needing only $\mathop{\mathrm{tr}}(VY)=0$, which a frame direction satisfies identically. *[Batch 22](2026-09-15-I106-m3-derivation.md) was cited here and does NOT cover it* ([r967](REVIEW_r967.md)): its coefficient $a$ lives on $W=\{Z:\mathop{\mathrm{tr}}(\hat UZ)=\mathop{\mathrm{tr}}(VZ)=0\}$, while $\mathop{\mathrm{tr}}(\hat U[\Omega,V])=-\mathop{\mathrm{tr}}(\Omega K)$, so frame directions meet $W$ only for $\Omega\perp K$, the commuting stratum. **Validated here: $0$ of $20000$ random frame directions lay in $W$.** And batch 21 closed saying its condition *"is not settled by any specialisation to one variable, which is all that has been extracted from it so far"*, which is what this piece is.

**So R28's second owed step was on the record before it opened**, and the route's remaining content is piece 3, the norm trade, which [post F68](../findings/fence-posts.md) names load-bearing and the classical theory does not carry, since that theory fixes the spectra.

**Gate 1.** (b) *Reached a second way*: the first-order collapse is one substitution by hand, and the $X=0$ identification is algebraic. (c) *Screened* over $20000$ random $(\hat U,V,\Omega,\mu,\alpha,\beta)$: the generic field gives $23.79$, the Lagrange form $3.7\cdot10^{-15}$, and the batch 21 gap is $0$ exactly. (d) *Ceiling*: the contrast between the two field cases shows the bracket is NOT identically zero, and [r967](REVIEW_r967.md) supplies the exact hypothesis-free form $[V,\beta\{\hat U,V\}+C]=\beta[V^2,\hat U]+[V,C]$, which is stronger than the screen. *It does NOT separate "the substitution rather than the geometry", a generic symmetric field not being a critical point's field at all, and that phrase is withdrawn.* **Gate 2 LANDED 2026-09-16** ([r967](REVIEW_r967.md), one reviewer, the round comparing against fixed text): claims 1 to 6 CONFIRMED, claims 7 and 8 REFUTED, **the fencing itself standing**.

**Classified against the record, by grepping the files this would have been written into FIRST.** *That is [proposal 126](../.claude/skill-proposals.md)'s rule, filed earlier the same day after the opposite order cost a round.* The file-local grep on this note and on [I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean) found no Lagrange treatment, and the record search by object then found both halves already present, at batch 20 and at batch 21's own $X=0$ case. *[r967](REVIEW_r967.md) refuted the first version of this sentence too, which cited batch 22, and added that batch 21's standing premise already states the first-order vacuity outright.* **Agreement, not discovery.**


## The split locus is STRICTLY WEAKER than commuting, so R28 is not the $[\hat U,C]=0$ route renamed

**The worry, and it was worth raising.** [L229](../findings/second-order.md) closes with *"the statement to aim at is therefore $[\hat U,C]=0$ at every global maximum"* and *"what stands is the value comparison at equal total norm"*, so R28's remaining step and the record's own open question could have been one gap in two vocabularies. *Working a renamed question as new is what cost this session two rounds already.*

**They are different, and R28's target is the weaker one.** A split $3\times3$ orthogonal matrix preserves a coordinate vector, which on the block problem is the stratum where $\hat U$ and $V$ SHARE AN EIGENVECTOR of the field frame. For symmetric $3\times3$ that is strictly weaker than $[\hat U,V]=0$: sharing $e_2$ leaves a $2\times2$ block each on $e_2^\perp$, and those commute only when their traceless parts are proportional. **Witness**: $\hat U$ and $V$ with blocks $\mathop{\mathrm{diag}}(1,-1)$ and $\begin{pmatrix}0&1\\1&0\end{pmatrix}$ share $e_2$ and have $\lvert[\hat U,V]\rvert=2$. *Screened: $20000$ of $20000$ random pairs sharing $e_2$ fail to commute, so the containment is generic rather than exceptional.*

**So R28 reaches the node by a weaker sufficient condition**, and [L229](../findings/second-order.md) finishes from the split locus, which it covers in full. *That is a point in the route's favour rather than against it.* **Gate 2 owed on this section.**


## Piece 3, the norm trade: its first order is vacuous and its second order excludes nothing

**First order is criticality restated**, [post F69](../findings/fence-posts.md) for a sixth time. With $\lvert\hat U\rvert=a$, $\lvert V\rvert=b$ and $3a^2+b^2=2T$, stationarity along the trade is $b\,\partial_a\Phi=3a\,\partial_b\Phi$, which expands to
$$\frac{3\alpha p_3+\beta q+\langle\hat U,A\rangle}{3\lvert\hat U\rvert^2}=\frac{2\beta q+\langle V,C\rangle}{\lvert V\rvert^2},$$
and **both sides are $\mu$** by batch 20's two Lagrange pairings, so it holds at every critical point. *Screened at $3.4\cdot10^{-15}$ over $20000$ draws.*

**Second order is a JOINT direction, so unlike piece 2 it is not empty.** The tangent is $X=\lambda\hat U$, $Y=\kappa V$ with $3\lambda\lvert\hat U\rvert^2+\kappa\lvert V\rvert^2=0$, admissible in batch 21's quantifier, and eliminating $\kappa$ and using $3n_U+n_V=2T$ gives the closed form
$$\mu\ \ge\ \frac{\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)}{Tn_Un_V},\qquad n_U=\lvert\hat U\rvert^2,\ n_V=\lvert V\rvert^2.$$
*Checked against batch 21 at the same direction to $5\cdot10^{-11}$.*

**And it excludes NOTHING.** At the three non-commuting critical points then believed to clear batch 18, batch 21 and batch 33's orbit bound together, and since shown to VIOLATE batch 21 ([r973](REVIEW_r973.md), validated at [screen_I106a_signature.py](../scripts/misc/screen_I106a_signature.py)), reconstructed with the record's own [screen_I106_value_survivors.py](../scripts/misc/screen_I106_value_survivors.py):

| spectrum | $\mu$ | the radial bound needs | margin |
|---|---|---|---|
| $(1,-3,2)$ | $11.60060$ | $-19.64468$ | $31.24528$ |
| $(-1,-3,4)$ | $24.43870$ | $-7.18323$ | $31.62193$ |
| $(19,-20,1)$ | $762.38453$ | $-33.26116$ | $795.64569$ |

*Every threshold is NEGATIVE where $\mu$ is large and positive, so the bound is far from binding and is much weaker than batch 18's, which needed $9.3675$ and $15$ at the first two.* **So the norm trade is a third joint specialisation of batch 21 that excludes nothing the record does not already exclude**, exactly as batch 33's orbit was.

**What this leaves of [R28](../routes.md).** Piece 1 is done and Gate 2 passed, piece 2 is fenced, and piece 3 is now empty. *The route's own mechanism, excluding an interior tangency, has no first-order lever and no second-order lever left at $\lvert J\rvert=3$.* **The node reverts to the record's standing position**, that what remains is $[\hat U,C]=0$ at every global maximum with the value comparison the only lever standing ([L229](../findings/second-order.md)).

**Gate 1.** (b) *A second route*: the first-order collapse is one substitution by hand, the closed form is one elimination, both checked symbolically. (c) *Screened* in [screen_I106a_norm_trade.py](../scripts/misc/screen_I106a_norm_trade.py), with two controls: $\lVert[A,C]\rVert$ at each point lands in the record's own range for them, and the bound is breached by $9967$ of $20000$ random configurations, so it is WEAK rather than vacuous. (d) *Ceiling*: the bound is dominated by batch 18's at all three points, which is the expected ordering for a redundant condition. **Gate 2 owed.**


## An error in this round's own brief, caught by both reviewers

**[BRIEF_I106a_norm_trade.md](BRIEF_I106a_norm_trade.md) misquoted a given.** It states *"Batch 18 needs $\mu\ge9.3675$ at the first and batch 21 needs $\mu\ge15$"*, attaching both to $(1,-3,2)$. **[Batch 33](2026-09-15-I106-m3-derivation.md)'s table carries $9.3675$ and $15$ against the spectrum $(3,1,-4)$**, at $\mu=-6.06130$ and $-24.43870$, which are EXCLUDED points rather than survivors. *The correct thresholds at the three survivors are batch 18 $=6.8739$, $9.3675$, $50.7124$ and $\alpha\lvert u_{\min}\rvert=11.25$, $11.25$, $75$.*

**Both [r968](REVIEW_r968.md) and [r969](REVIEW_r969.md) reported it independently**, which is what the skill predicts for a misquoted premise: it invents a hypothesis debt the record does not carry, and two readers return it identically, so the agreement is worthless as corroboration. *Their verdicts are unaffected, both having computed the thresholds themselves rather than taking the brief's.* **The brief was NOT edited mid-round**, since both had already read it and altering it would leave their reports citing a version that no longer exists.


## Gate 2 on piece 3: the closure STANDS, and its argument was the wrong one

**Landed 2026-09-16, [r968](REVIEW_r968.md) and [r969](REVIEW_r969.md) on identical cold briefs.** Claims 1 to 6 CONFIRMED by both, claims 7 and 8 qualified. *The conclusion holds and the reasoning under it was replaced.*

**The redundancy is a THEOREM, not a three-point screen.** Both reviewers give the same upgrade: the radial direction is ONE admissible tangent inside batch 21's quantifier, so batch 21's full condition implies the trade bound POINTWISE, and nothing can satisfy batch 21 while failing the trade bound, at any configuration. *This is exactly the upgrade [r961](REVIEW_r961.md) and [r962](REVIEW_r962.md) applied to batch 33's orbit, and it is two lines from claim 1.* **Validated here by an independent route**: over $50000$ random $(\hat U,V,\mu,\lambda)$ the trade bound and batch 21 at the radial direction never disagree in sign, $0$ of $50000$, the connecting factor $6\lambda^2/n_V^2$ being positive throughout. **So the table below is demoted to a screen.**

**The thresholds label a STRATUM, not points** ([r969](REVIEW_r969.md)). Releasing all five $V$ parameters at the same $(u,\mu)$, $[A,C]=0$ has a continuum of genuinely non-commuting solutions at $(1,-3,2)$ with thresholds from $-19.97$ to $+2.99$. *The verdict survives, none reaching $\mu=11.60060$, but the stratum must be named beside the numbers.* **And the bound is WEAK rather than vacuous**: its threshold is positive in about half of random pairs and is homogeneous of degree one, so it is a real constraint these points clear widely. *My stated reason, that every threshold is negative, is a fact about the three points and not about the bound.*

**Claim 8 is PLAUSIBLE on both reports**, not confirmed: that R28 has no lever left needs a completeness premise, that pieces 1, 2 and 3 exhaust the mechanism. *That premise is not established here, so the route is recorded as spent on present evidence rather than closed outright.*

**What the round added beyond the claims.** [r968](REVIEW_r968.md): the radial direction DOES move the internal part, $3\alpha\lambda p_3+\beta(\lambda+2\kappa)q$ being generically non-zero, and it closes anyway, so batch 33's lesson is necessary and not sufficient. **What both closed levers share is containment in batch 21, and that is what a successor direction has to escape.** *That is the sharpest statement this round produced.*

**Reported honestly by [r969](REVIEW_r969.md)**: a grep for the batch 35 figures printed lines 106 to 110 of this note, which it was barred from reading. It did not open the file and computed its figures independently, and it recorded the spillage rather than hiding it.


## The completeness premise: what is proved, and what stays a judgement

**Both reports left claim 8 PLAUSIBLE for the same reason**, that "R28 has no lever left" needs a premise nobody established: that pieces 1 to 3 exhaust the mechanism. *This section separates the half that is mathematics from the half that is not.*

**Proved: every DIRECTIONAL lever is contained in batch 21.** That batch's own premise is already a completeness statement, quoted verbatim: *"At a critical point the first differential of $\Phi-\mu T$ vanishes, so along any curve on the constraint surface the second derivative is $D^2(\Phi-\mu T)$ applied to the tangent vector alone, with no contribution from the curve's acceleration. Hence at every local maximum, for all traceless symmetric $X,Y$ with $3\mathop{\mathrm{tr}}(\hat UX)+\mathop{\mathrm{tr}}(VY)=0$"*. **So any lever that picks a tangent direction and computes the second variation along it IS batch 21 evaluated there**, hence implied by batch 21 and unable to exclude anything batch 21 does not. *Three instances are now on the record, each found independently*: the conjugation orbit ([r962](REVIEW_r962.md), batch 33), the frame variation (piece 2), and the radial trade (piece 3, validated here at $0$ sign disagreements over $50000$). **And the first-order side is empty by [post F69](../findings/fence-posts.md), now at six instances**, the Lagrange forms collapsing each stationarity condition to an identity.

**Not proved, and it is a judgement rather than a theorem: that every lever of R28's mechanism is directional.** *R28 excludes an interior tangency by first and second order on the orthostochastic data, and both of those are directional, which is why all three instances landed inside batch 21.* **But "the mechanism has no other lever" is a claim about a method, not about the objects**, and no argument here rules out a lever of a different shape. *That is exactly why both reviewers stopped at PLAUSIBLE, and recording it as proved would be the overreach [proposal 125](../.claude/skill-proposals.md) was filed for.*

**The known escape is non-directional, and the record already names it.** The value comparison of batch 29 tests $\Phi$ at the point against $\Phi$ at a different configuration of the same total norm. *It is not a local condition at all, so nothing above touches it*, which is why [L229](../findings/second-order.md) closes by saying what stands is the value comparison. **So the honest statement is that R28's mechanism is spent among directional levers, and the node's remaining lever is one that does not test a direction.** *Gate 2 owed on this section.*


## Why the directional family can NEVER reach the value comparison, a sign obstruction

**Recorded 2026-09-17, AFTER [r970](REVIEW_r970.md) and [r971](REVIEW_r971.md) were dispatched.** *It does not alter the block their brief quotes, and they have not seen it.*

**The value comparison is an UPPER bound on $\mu$.** Batch 20's identity, typed as `value_at_critical`, gives $\Phi=2\mu T-2P_3$ at any critical point, so the comparison $\Phi_{\text{point}}<\Phi_{\text{diag}}(T)$ is exactly
$$\mu\ <\ \frac{\Phi_{\text{diag}}(T)+2P_3}{2T}.$$
*And batch 20 is recorded as owing precisely that, an upper bound on $\mu$ or a lower bound on $P_3$, so the comparison and batch 20's standing debt are the SAME statement.* **That equivalence is nowhere on the record**, searched by the object across [findings/](../findings/) and [reviews/](../reviews/).

**But batch 21 can only ever produce a LOWER bound.** Its condition is $\text{LHS}(X,Y)\le\mu(3\lvert X\rvert^2+\lvert Y\rvert^2)$, and the coefficient of $\mu$ is positive at every nonzero tangent, vanishing only at $X=Y=0$. *So the inequality always rearranges the same way.* **Screened over $200000$ nonzero admissible tangents, smallest coefficient $0.747$, never non-positive**, and typed as `batch21_gives_lower_bound`.

**So the obstruction is the SIGN of the coefficient, not the strength of any direction.** *This explains the pattern rather than restating it*: batch 18, batch 21 itself, batch 33's orbit and the radial trade all read $\mu\ge\cdots$, and four came back redundant in a row because no member of that family can point the other way. **It also sharpens the completeness premise under audit**: the reason every directional lever fails is not that batch 21 happens to be strong, but that the comparison needs an inequality of the opposite sense.

*What this does NOT give*: a proof of the comparison. It says where one cannot come from. **Gate 2 owed.**


### The obstruction covers BOTH branches of batch 20's debt

**Recorded 2026-09-17, checking a LEAD from [r970](REVIEW_r970.md)'s log rather than its report, which has not landed.** *To be reconciled when it does, and the credit for the bound is r970's.*

**The objection.** Batch 20 owes *an upper bound on $\mu$ OR a lower bound on $P_3$*, and the section above framed the obstruction only in $\mu$. r970's log reports deriving the second: a tangent-trace bound $P_3\ge-3\mu T$. *If a lower bound on $P_3$ could serve, the obstruction would be incomplete.*

**It cannot, and the reason is the same sign.** With $\Phi=2\mu T-2P_3$, a bound $P_3\ge g$ gives $\Phi\le2\mu T-2g$, and at $g=-3\mu T$ that is $\Phi\le8\mu T$. **The coefficient of $\mu$ is $8T>0$, so the bound GROWS with $\mu$, while every recorded lever bounds $\mu$ from BELOW and none from above.** *So the bound is unbounded above and cannot be compared with $\Phi_{\text{diag}}(T)$ at all.*

| spectrum | $\mu$ | $T$ | $\Phi\le8\mu T$ | actual $\Phi$ | best diagonal |
|---|---|---|---|---|---|
| $(1,-3,2)$ | $11.60060$ | $178.2407$ | $16541.59$ | $2143.11$ | $3290.16$ |
| $(-1,-3,4)$ | $24.43870$ | $645.4986$ | $126201.17$ | $19982.02$ | $28862.02$ |
| $(19,-20,1)$ | $762.38453$ | $350181.3948$ | $2135783024.71$ | $526210564.02$ | $577574913.52$ |

*The bound sits above even the diagonal value at all three, so it is useless for the comparison exactly where the comparison is needed.* **So the $P_3$ branch inherits the obstruction rather than escaping it**, and the statement strengthens: no lower bound on $P_3$ that grows in $\mu$ can serve either, for the same reason no lower bound on $\mu$ can. *A lower bound on $P_3$ that is independent of $\mu$, or decreasing in it, would escape, and none is on the record.* **Gate 2 owed, together with the section above.**


## Gate 2 on the completeness premise: the headline is REFUTED and a fourth lever exists

**Landed 2026-09-17, [r970](REVIEW_r970.md) and [r971](REVIEW_r971.md) on identical cold briefs.** *The mathematics stands in full and the judgement built on it does not.*

**The fourth shape, and it is the round's result.** r971 gives an exact identity along the great circle $\gamma(\theta)=\cos\theta\,p+\sin\theta\,Z$, for $Z$ tangent with $\lVert Z\rVert=\lVert p\rVert$:
$$\Phi(\gamma(\theta))-\Phi(p)=-\tfrac12\Phi(p)(c-1)^2(c+2)+\tfrac12cs^2Q(Z)+s^3\big(\Xi(Z)-S(Z)\big),$$
with $Q$ batch 21's expression INCLUDING its $-\mu(3\lvert X\rvert^2+\lvert Y\rvert^2)$ term, $S(Z)=D\Psi(p)[Z]=-(\langle A,X\rangle+\langle C,Y\rangle)$ and $\Xi(Z)=\alpha\mathop{\mathrm{tr}}X^3+\beta\mathop{\mathrm{tr}}(XY^2)$. **Validated here at $4000$ critical points, four angles each, max residual $2.3\cdot10^{-13}$** ([screen](../scripts/misc/screen_I106a_great_circle.py)). *A first run failed at $61.6$ because this note's author used batch 21's bare expression for $Q$; a fitted-$Q$ diagnostic located that as the author's error rather than the finding's, and it is recorded because the failure looked like a refutation.*

**So batch 21 and the value comparison were never two kinds of thing.** $\theta^2$ is batch 21, $\theta^3$ at a degenerate direction is $\Xi(Z)=S(Z)$, $\theta^4$ gives $\Phi(p)\ge0$, and finite $c$ is batch 29's comparison, every point of the sphere lying on a great circle through $p$. **The $\theta^3$ lever carries NO $\mu$**, which is exactly why it escapes the sign obstruction recorded above: that obstruction binds the family that bounds $\mu$, and this one does not belong to it.

**What was refuted, and it is mine.** *Claim 7, that R28's mechanism is spent among directional levers, is REFUTED by both.* The proved statement was that a lever computing the SECOND VARIATION along a direction is batch 21 evaluated there. **The leap to every DIRECTIONAL lever is the error**, since a directional lever may compute a higher-order term, and order three is exactly where this one lives. *r970 states the same refutation with its own fourth shape, $P_3(Z)+(T(Z)/T)\ell(Z)=0$ at a direction where batch 21 is tight, validated here as generically non-zero over $400$ tight directions, so it is a real condition rather than a restatement.*

**Claim 8 splits and the two reports reconcile rather than conflict.** The weak half stands, the comparison is not a local condition. *But "nothing above touches it" is REFUTED*: it is the finite-$c$ behaviour of the same expansion. **And claim 5's "empty" is too strong** ([r971](REVIEW_r971.md)): batch 30's commuting route still yields exclusions.

**So R28 is NOT spent, and its own target is where the new lever bites**, a tangency being the degenerate case that the $\theta^3$ condition governs. *The route reopens.*


## The fourth shape is the record's OWN higher-variation calculus, and that calculus is already scoped

**Classified before working it, 2026-09-17.** *Both reviewers were cold and could not have known, so this is the parent's to catch.* **The record has carried this object since reviewers 287 and 288**, in [second-order.md](../findings/second-order.md) under *"The higher-variation calculus, and what it can and cannot see"*, stated for $P$ on $\mathcal W_n$ rather than for $\Phi$ on the block problem.

**The ladder, extracted exactly by series from the validated identity** rather than by finite differences:

| coefficient | value |
|---|---|
| $[\theta^2]$ | $Q/2$, batch 21 |
| $[\theta^3]$ | $\Xi-S$, unconditionally |
| $[\theta^4]$ | $-\tfrac38\Phi_0-\tfrac5{12}Q$, hence $-\tfrac38\Phi_0$ at $Q=0$ |
| $[\theta^5]$ | $-(\Xi-S)/2$ |

*The $\theta^4$ coefficient is slightly MORE informative than r971 stated, carrying $-\tfrac5{12}Q$ as well, and it needs only $Q=0$ rather than $Q=0$ and $\Xi=S$ together.*

**The correspondence is exact, and the constant is the tell.** The record's jet gives $[t^3]P(\gamma)=T(z,z,z)$ at $z\in\ker B$, a degenerate direction, and records that its chordal quartic is $-\tfrac{3\theta}8$ *"on the whole null cone of $B$, not only on eigenvectors"*. **Here it is $-\tfrac38\Phi_0$ on the null cone $Q=0$**: same constant, same hypothesis, and $T(z,z,z)$ is the cubic form at the direction, which is $\Xi$. *So the fourth shape is that calculus transported, not a new apparatus.*

**And the record already scopes it, which is what this classification buys.** Two of its results bear directly:
1. **The apparatus is VACUOUS along the orbit**, unconditionally and with no maximality: differentiating $Q(e^{tX}W)=\theta e^{tX}W$ twice gives $Bu=z\circ z$ and $L_Wz=\tfrac\theta2z$, so the orbit tangent lies in $\ker B$ and $T(z,z,z)=0$ there.
2. **The third-order content is the EXCESS alone**: splitting $z=o+e$ into orbit and excess parts, every term with an orbit factor dies and $T(z,z,z)=T(e,e,e)$. *The fourth order does not split this way.*

**So the new lever bites only where there is excess**, $\dim\ker B>\dim$ orbit tangent. *That is exactly the question r971 blocked and named as needing an unbounded search*, and the record's own answer is that excess is non-generic by an isotropy count which **cannot be upgraded**, since $P$ is not a generic cubic and the points carrying excess are the non-generic ones. **Gate 2 owed on this classification.**


### The classification is REFUTED, and the three survivors are not maxima at all

**Corrected 2026-09-17, within the hour, by the parent's own computation.**

**1. The orbit-vacuity does NOT transfer to the block problem.** The section above carried the record's result that the apparatus is vacuous along the orbit tangent. *That rests on $P$ being $O(n)$-INVARIANT, so that $Q(e^{tX}W)=\theta e^{tX}W$ can be differentiated.* **Here the fields $A$ and $C$ are FIXED**, so conjugating $(\hat U,V)$ alone is not a symmetry of $\Phi$, which is why batch 33 records $\Phi$ as varying along the orbit through $\langle\hat U,A\rangle+\langle V,C\rangle$. *Checked directly: at the three survivors $\max\lvert H(\text{orbit})\rvert$ is $5.4\cdot10^3$, $4.9\cdot10^4$ and $2.1\cdot10^9$, nowhere near zero.* **So that sentence is withdrawn**, and the transfer holds only for the parts that do not use invariance.

**2. The vacuity argument below was INVALID, and its points were not maxima.** *Its condition $\Xi(Z)=S(Z)$ applies at a DEGENERATE direction, where $Q(Z)=0$, and $\dim\ker H=0$ was read as putting no such direction there.* **That inference is false**: $\dim\ker H=0$ empties the null SPACE, while $Q(Z)=0$ is the null CONE, which is eight-dimensional at each point, and only DEFINITENESS would collapse one onto the other ([r972](REVIEW_r972.md) and [r973](REVIEW_r973.md), independently). **And the premise that would have supplied definiteness is itself false**: the second variation is INDEFINITE at all three, signature $6/3$, $6/3$ and $7/2$, so batch 21 is VIOLATED and these are critical points that are NOT local maxima.

| spectrum | tangent dim | $\dim\ker H$ | $\max\lvert H(\text{orbit})\rvert$ |
|---|---|---|---|
| $(1,-3,2)$ | $9$ | $0$ | $5.4467\cdot10^3$ |
| $(-1,-3,4)$ | $9$ | $0$ | $4.9261\cdot10^4$ |
| $(19,-20,1)$ | $9$ | $0$ | $2.0678\cdot10^9$ |

*A first run reported $\dim\ker H=1$ at every point, which was an artifact: it projected all $10$ basis pairs into a $9$-dimensional tangent space and kept them, so the matrix had a null direction by construction.* **Fixed by Gram-Schmidt to a genuine basis, and the tangent dimension of $9$ is the check that it is right.**

**What this leaves, after Gate 2.** *The lever is real and it cannot reach [R28](../routes.md), for a STRUCTURAL reason rather than a numerical one* ([r972](REVIEW_r972.md)). **Its hypothesis is a degenerate direction, so it is vacuous at every NONDEGENERATE critical point by construction**, and what manufactures degenerate directions in the record is the $O(n)$-invariance that this problem's fixed fields destroy. *So the record supplies them automatically through the orbit and the block problem supplies them not at all, which is the same withdrawal as item 1 read forward.* **And the three points are gone as obstacles**, not because the lever excluded them but because they were never maxima. *That leaves this node with no known non-commuting maximiser and with the value comparison as the standing lever, which now has nothing to be tested against until a genuine survivor is produced.* **The classification above is REFUTED and retained only as the record of what was believed**; its replacement is [r972](REVIEW_r972.md)'s proposition, that $[\theta^4]=-\tfrac38F(p)-\tfrac56[\theta^2]$ at any constrained critical point of any cubic-plus-linear functional, which is a better result than the transport it kills.
