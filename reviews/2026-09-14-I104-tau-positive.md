# I104, the overlapping case with $\tau>0$: what L221's chain reaches, 2026-09-14, on Opus

**Written while [L221](../findings/second-order.md) is in Gate 2** ([r941](REVIEW_r941.md), [r942](REVIEW_r942.md)), in a file its brief does not link.

## The chain with the pinning weakened

With $\tau>0$, L221(b)'s step 2 gives only $\tfrac{\sqrt3}2u_i\ge\tfrac\theta2-\tau/N_i$. Using the constant $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$, DERIVED in the next section, $u_i\ge(\theta-y_i)/\sqrt3$ with $y_i=\sqrt{N_jN_k/N_i}$. Step 4's inequality is unchanged, its pinning term being bounded above in either sign, so its left side at the weaker lower bound gives, after multiplying by $\sqrt3$,
$$\tfrac16(\theta-y_i)(5\theta+y_i)\ \le\ 1-\tfrac N2+N_i\qquad\text{whenever }y_i\le\theta .$$

## Where it closes and where it does not, at $\theta^2=\tfrac32$

- **Small block mass closes.** At $N_i=N$ and $y_i\to0$ the left side is $\tfrac56\theta^2=1.25>1$, a contradiction, and for balanced $N_1=N_2=N_3=\nu$ summing the three inequalities gives $(\theta-\sqrt\nu)(5\theta+\sqrt\nu)\le6-3\nu$, false at $\nu=0.1$ ($5.85>5.70$).
- **Moderate block mass does not.** The same sum holds at $\nu=0.2$ ($5.11\le5.40$), so the chain as written admits $\theta=\sqrt{3/2}$ there.

**The losses are the lossy coupling bound $\kappa_i\le\tfrac{u_i}{\sqrt3}(t-u_i^2)$, which ignores that $r_i$ contains the other two patterns' components, and the cross-term angle $\tfrac13$, which is a worst case over shapes.** *Both are attained only at shapes the pinning does not select.* **The Gram-system attempt this sentence recommends STANDS, 2026-09-16, see the section added below**: the three planes meet at principal cosines exactly $(\tfrac13,0)$, and the scalar corollary in $t$ alone is exactly $\sum u_i^2\le\tfrac53t$, which is the bound already screened as insufficient. *The joint system carries strictly more than that corollary, so what remains is the system's $x$-dependence alongside the coupling bound $\kappa_i$.* **The restricted screens found no multi-component critical point above $0.66$ at $n=8$**, so the gap is in the estimates, not, on present evidence, in the claim.

## The product constant, derived: $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$

**The bilinear formula** (read off the product on basis tensors at $n=8$, exact to the digit, and linear in each factor). For $Q_1=\{i,j,k,l\}$, $Q_2=\{i,j,m,p\}$ sharing $\{i,j\}$ and signed coordinates $(a_1,b_1,c_1)$, $(a_2,b_2,c_2)$ on their pairings, $\nu_1\circ\nu_2\in V_{Q_3}$, $Q_3=\{k,l,m,p\}$, has pairing coefficients
$$\tfrac12a_1a_2\ \text{on }(kl,mp),\qquad\tfrac12(b_1b_2+c_1c_2)\ \text{on }(km,lp),\qquad+\tfrac12(b_1c_2+c_1b_2)\ \text{on }(kp,lm).$$

*The third sign is fixed by cyclic symmetry, which the section at the foot of this file derives: read as a minus the form is not cyclically invariant, and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is proved symmetric.*

**THE COORDINATE CONVENTION ON THIS FORMULA IS UNSETTLED, AND THE CYCLIC TEST CANNOT SEE IT** ([r1077](REVIEW_r1077.md)). *The formula is labelled as being in SIGNED coordinates, as the prose around it is throughout, but it closes into $V_{Q_3}$ only when read in RAW pairing coordinates, where Bianchi is $a-b+c=0$.* **The corrected $+$ sign is right under either reading**, which is why the cyclic test settled the sign and not the convention. *The two readings give DIFFERENT $\tau$ at the same configuration: $\tfrac32r^3$ against $\tfrac12r^3$ at $\gamma\equiv0$.* **[r1077](REVIEW_r1077.md) computed its whole round under both and every result was invariant**, so nothing recorded from it depends on the answer. *Settling it needs the formula rebuilt from the Fox product, which is the open-ended run the analysis-only rule reserves and the one that killed [r1075](REVIEW_r1075.md); it was not opened.* **Three calibrations stand in for it and all passed**: the product-bound maximum $f=1$ at $\nu\propto(0,1,-1)$, the maximiser's location, and [I110](../plan.md)'s corner shape. *The record's own rule is to settle a convention against a DERIVED IDENTITY rather than a numeral, and those three do not separate the readings, so the question stays open and is flagged here rather than assumed away.*
**The bound.** With the operator norm $\lVert\nu\rVert^2=2(a^2+b^2+c^2)=:2S$, $\lVert\nu_1\circ\nu_2\rVert^2=\tfrac12A$ with $A=a_1^2a_2^2+(b_1b_2+c_1c_2)^2+(b_1c_2+c_1b_2)^2$. The last two terms sum to $(b_1^2+c_1^2)(b_2^2+c_2^2)+4b_1c_1b_2c_2\le2(b_1^2+c_1^2)(b_2^2+c_2^2)$ by $2\lvert bc\rvert\le b^2+c^2$, so $A\le a_1^2a_2^2+2(b_1^2+c_1^2)(b_2^2+c_2^2)\le2S_1S_2$. Hence $\lVert\nu_1\circ\nu_2\rVert\le\sqrt{S_1S_2}=\tfrac12\sqrt{N_1N_2}$ and $\lvert\tau\rvert\le\lVert\nu_1\circ\nu_2\rVert\lVert\nu_3\rVert\le\tfrac12\sqrt{N_1N_2N_3}$. $\square$ *Equality at $a_1=a_2=0$, $b=-c$, matching the screened maximum $\tfrac12$, and it is REACHABLE under Bianchi with the sign above, the maximum over the three Bianchi planes being $\sqrt2\sqrt{S_1S_2S_3}$ exactly. The bound's PROOF needs no Bianchi, and its sharpness on the space $\nu_i$ live in does.* **One condition of the equality case is unstated above and is free**: the first step needs $b_1c_1b_2c_2\ge0$ as well, which Bianchi with $a=0$ supplies, since $bc=-b^2\le0$ in each block ([r1061](REVIEW_r1061.md)).

## The scalar chains with the derived constant, screened jointly: short by $0.02$

*Keeping the pinning term exact on the right ($\tfrac\theta2N_i-\tau$ rather than its upper bound) and its weakened lower bound $u_i\ge(\theta-2\tau/N_i)/\sqrt3$ on the left, with $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$, $t=1-N$ and $u_i\le\sqrt t$: at $\theta^2=\tfrac32$ the per-block slack $F_i(u)=\theta u^2-\tfrac{u^3}{2\sqrt3}-\tfrac u{\sqrt3}\big(t+\tfrac{N-N_i}2\big)-N_i\big(\tfrac\theta2-\tfrac\tau{N_i}\big)$ is negative somewhere on every block's admissible $u$-interval on a whole region of the grid, not at one point: the most negative value of the largest block slack is $-0.020$, at $N_1=N_2=N_3=0.268$ with $\tau$ at its bound $0.069$, and a later count found $379$ grid configurations where all three blocks admit $\theta=\sqrt{3/2}$.* **So the three scalar chains together do not close the $\tau>0$ case: they fail on a region whose worst shortfall is $0.02$.** *An earlier version of this paragraph said they fail at one configuration only, which misread the minimum of the slack as the whole failure set.* *The $0.02$ is the price of the two worst-case estimates named above.* **The Gram half of that price is a scalar corollary rather than the whole system** (section below, 2026-09-16): the cross-plane geometry is rigid and the bound in $t$ alone is exact, so the $0.02$ must come out of the coupling bound $\kappa_i$ or out of the joint system's $x$-dependence. A screen of the scalar system, not of $\mathcal W_n$.

## The vector system, following the hint's reading: it adds the norm condition and nothing past it

**Derived.** Write $\nu_i=\alpha f_++\beta f_-$ in the $\pm e_i$ eigenvectors of $L_{q_i}$ on $V_{Q_i}$, $d_i=\theta-2e_i$. The $\chi_{Q_i}$ equation $(\theta-2L_{q_i})\nu_i=2\nu_j\circ\nu_k$ gives, in norm, $d_i^2\alpha^2+(\theta+2e_i)^2\beta^2=4\lVert\nu_j\circ\nu_k\rVert^2\le N_jN_k$, and paired with $\nu_i$ it gives $\tau=\tfrac12d_iN_i+2e_i\beta^2$. Eliminating $\beta^2$:
$$\tau\ \le\ \frac{N_jN_k+(\theta^2-3u_i^2)N_i}{4\theta},$$
**a new upper bound on $\tau$ in terms of the pinned norm**, sharp where $u_i\to\theta/\sqrt3$, where it reads $\tau\le N_jN_k/4\theta$. *Combined with the scalar pinning $\tau\ge\tfrac\theta2N_i-\tfrac{\sqrt3}2u_iN_i$ it reduces to $N_i(\theta-\sqrt3u_i)^2\le N_jN_k$, which is the norm of the equation, so the quadratic structure of each block is already spent by the two scalar facts.* **At the screen's failing configuration** ($N_i=0.268$, $u_i\approx0.41$) the new bound gives $\tau\le0.069$, equal to the product bound, so it does not close the $0.02$. *What is left for the gap is the coupling between blocks through $D$, the Gram system of the three pattern projections, not the per-block quadratic.*

## The Gram bound on the three projections, screened: it does not close either

*The three pattern planes meet pairwise at cosine at most $\tfrac13$, so $\sum_iu_i^2\le(1+\tfrac23)\,t$ for the projections of $D$. Over the $379$ configurations where every block's chain admits $\theta=\sqrt{3/2}$, taking each block's smallest admissible $u_i$, this bound excludes some and not all: the most permissive case is $N_1=N_2=N_3=0.134$, $\tau=0.025$, $u_i=0.496$, where $\sum u_i^2$ is $0.26$ below $\tfrac53t$.* **So neither the per-block quadratic nor the Gram bound closes $\tau>0$ with these estimates, and the shortfall is spread over moderate block masses rather than concentrated at a point.** *The restricted screens of $\mathcal W_n$ itself still show no multi-component critical point above $0.66$, so the claim stands on evidence and the estimates are what fail.*


## The Gram CONSTANT is exact, and the system it comes from is not spent, 2026-09-16

**The cross-plane geometry is rigid.** $\Pi_{Q_1}$ and $\Pi_{Q_2}$ share exactly one matrix entry, the pair $ij$, and likewise $kl$ for $(Q_1,Q_3)$ and $mp$ for $(Q_2,Q_3)$. So $\langle q_1,q_2\rangle=x_1x_2$ factors through a single linear functional on each plane: **the cross-Gram has rank one, and the principal cosines are exactly $(\tfrac13,0)$** rather than "at most $\tfrac13$". *Each pairing $(ij\vert kl)$ of $Q_1$ carries one coefficient on both of its pairs, which is why only three numbers $x_1,x_2,x_3$ appear across all three overlaps.*

**What the joint system then gives.** Writing $q_i=\alpha_i\hat e_i+\beta_i\hat f_i$ with $\hat e$ the shared channel and $\hat f$ orthogonal to every other plane, $\sum_iu_i^2\le\lambda_{\max}(G_e)\,t$ with $G_e$ the $3\times3$ matrix of unit diagonal and off-diagonals $\pm\tfrac13$.

**The parity constraint works AGAINST the bound.** The three cosines are $x_1x_2$, $x_1x_3$, $x_2x_3$, whose product is $(x_1x_2x_3)^2\ge0$, so an even number of them are negative. *The odd sign patterns give $\lambda_{\max}=\tfrac43$ and are geometrically impossible, so every admissible pattern gives $\tfrac53$.* **And $\sum u_i^2\le\tfrac53t$ is attained**, at $D$ along $G_e$'s top eigenvector.

**What is exact is the scalar corollary in $t$ alone.** The bound $\sum u_i^2\le\tfrac53t$ cannot be improved as a statement in $t$, because the geometry it rests on is exact rather than estimated, so the $0.02$ will not come from sharpening that constant.

**The joint system carries strictly more, and it is what the recommendation above asked for.** With $q_a=\alpha_a\hat e_a+\beta_a\hat f_a$, $u_a^2=\alpha_a^2+\beta_a^2$ and $G_e^{-1}=\tfrac32I-\tfrac3{10}J$, minimality of the $e$-part gives
$$t\ \ge\ \sum_a\beta_a^2+\tfrac32\sum_a\alpha_a^2-\tfrac3{10}\Big(\sum_a\alpha_a\Big)^2,\qquad\langle q_a,q_b\rangle=\tfrac13\alpha_a\alpha_b,$$
an identity on $\Sigma$, equivalently $\sum_iu_i^2\le t-\tfrac32\sum_ix_i^2+\tfrac9{10}(\sum_ix_i)^2$ under $\alpha_i=\sqrt3x_i$. **The scalar bound is the $x$-independent relaxation of this**, and the two are the same statement only where $\sum x_i^2$ vanishes.

**The bound was never binding where the chain fails.** At the most permissive surviving configuration recorded four paragraphs above, $N_a=0.134$, $u_a=0.496$, $t=0.598$, one has $\sum u_a^2/t=1.234$ against $\tfrac53$, so the inequality is slack by $0.26$ there, which is the figure that section already carried. The $\tfrac53$ is attained at a different $D$, lying wholly in the three $e$-channels with $\beta_a=0$. *Exactness of a worst case over all $D$ says nothing about the configuration that survives.*

**So the $0.02$ has two live sources**, the coupling bound $\kappa_i\le\tfrac{u_i}{\sqrt3}(t-u_i^2)$, whose slack is that $r_i=D-q_i$ still carries the other two patterns' components, confined by the rank-one structure to the single $\hat e_i$ channel, and the $x$-dependence of the joint system above. *That confinement is itself the Gram system entering $\kappa_i$, which is the form in which the recommendation should now be carried.*

**Corrected 2026-09-16** after [r963](REVIEW_r963.md) and [r964](REVIEW_r964.md), which independently refuted the previous heading "The Gram route is EXHAUSTED" and the withdrawal of the two recommending sentences above, both now restored. *Validated by an independent route before folding: $G_e$ rebuilt from its definition gives $\lambda_{\max}=\tfrac53$ and $G_e\cdot(\tfrac32I-\tfrac3{10}J)=I$ exactly, the two reviewers' systems agree in $200000$ random draws under $\alpha=\sqrt3x$, and the $0.26$ slack reproduces from this file's own numbers.*

**Gate 1.** (c) *Screen*, [screen_I104_gram.py](../scripts/misc/screen_I104_gram.py), which computes the principal cosines from explicit patterns at $n=8$, the spectrum over all eight sign patterns with the impossible ones marked, and the attainment. (d) *Ceiling*: the bound reproduces L221 step 3's $\tfrac13$ as its nonzero principal cosine, so it agrees with the record where the record speaks. **Gate 2 owed.**


## A candidate for the $0.02$, REFUTED: steps 7 and 8 want the SAME shape

**The candidate.** The chain's two shape-dependent losses are [L220](../findings/second-order.md) step 7, $P(q)=18xyz\le\tfrac{\sqrt3}2\lVert q\rVert^3$, and step 8, $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2\le\tfrac1{\sqrt3}\lVert q\rVert\lVert r\rVert^2$. *If they were maximised at DIFFERENT patterns, neither could be tight where the other is, the chain's sum would fall strictly below the sum of its maxima, and that gap would be the $0.02$.* **This is [post F68](../findings/fence-posts.md)'s conflict pattern**, where Fan's ordering and von Neumann's disagree and a rotation trades between them.

**Refuted.** Over the circle of unit patterns with $x+y+z=0$ and $2(x^2+y^2+z^2)=1$, both are maximised at the SAME point, $(x,y,z)=(0.577350,-0.288675,-0.288675)$, the $S^2\times S^2$ shape:

| bound | its maximum | value at the OTHER bound's maximiser | deficit |
|---|---|---|---|
| step 7, $18xyz$ | $0.866025=\tfrac{\sqrt3}2$ | $0.866025$ | $0$ |
| step 8, $\max(x,y,z)$ | $0.577350=\tfrac1{\sqrt3}$ | $0.577350$ | $0$ |

*So the two bounds can be tight simultaneously and there is no trade between them.* **This is consistent with L220's own equality case**, which forces exactly that shape with $r=0$, so the chain is sharp there rather than lossy. *The $0.02$ at moderate block mass therefore does not come from a shape conflict between these two steps.*

**What survives, NARROWED 2026-09-17.** *This paragraph claimed the OTHER slack in step 8 as shape-independent, the step putting all of $\lVert r\rVert^2$ on $L_{\hat q}$'s top eigenvalue.* **That is REFUTED in L220's own setting**: the bound is ATTAINED over $\mathcal D_n\ominus\Pi_Q$, so it carries no slack there at all ([screen_I104_step8_tight.py](../scripts/misc/screen_I104_step8_tight.py)). *What survives is only that $r_i=D-q_i$ obeys a FURTHER constraint in I104, carrying the other two patterns' components, which that screen does not impose.* *And the sharper question is how much slack each of the chain's four bounds carries at the FAILING configuration rather than at the extremal one, which is measurable and not yet measured.*

**Gate 1.** (c) *Screened* in [screen_I104_shape_conflict.py](../scripts/misc/screen_I104_shape_conflict.py) over $2\cdot10^6$ patterns on the circle, with the constraints asserted rather than assumed. (d) *Ceiling*: both maxima reproduce their recorded closed forms, $\tfrac{\sqrt3}2$ and $\tfrac1{\sqrt3}$, to six decimals. **A refuted candidate, recorded so it is not retried.**


## Where a gain in step 8 can and cannot live, derived

**Step 8 contains two maximisations, and only one survives the refutation above.** Its bound is $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2$, which (i) takes $\max(x,y,z)$ at its own extreme $\tfrac1{\sqrt3}$, and (ii) assigns ALL of $\lVert r\rVert^2$ to that top coefficient. *The shape half is settled: steps 7 and 8 peak together, so (i) cannot be traded against step 7.* **What is left is (ii).**

**Why (ii) looked non-empty, and why that reading is now REFUTED.** $Q_i$ and $Q_j$ share exactly two indices, so $q_j$'s support on $Q_i$'s pairings is the SINGLE shared pair, which carries that pair's coefficient rather than $\max(x,y,z)$. **But that argument concerns the EXTRA constraint I104 puts on $r_i$, not step 8**, and step 8's own bound is attained: over $\mathcal D_n\ominus\Pi_Q$ the supremum of $\langle L_{\hat q}r,r\rangle/\lVert r\rVert^2$ equals $\max(x,y,z)$ exactly, at every shape tried. *So (ii) is empty as stated and survives only in the narrower form below.*

**But the gain vanishes exactly where the Gram bound is attained, and that is derivable.** Attainment puts $D$ along $G_e$'s top eigenvector, which is $\pm(1,1,1)$ since $G_e$ has unit diagonal and off-diagonals $+\tfrac13$. **BOTH SIGNS ATTAIN THE BOUND, AND THE MINUS ONE IS WHAT THE CORNER TAKES** ([r1063](REVIEW_r1063.md)), *so the line below computes the $+$ branch and is not the general case.* So all $\alpha_i$ are equal and maximal, and on the $+$ branch $\alpha_i=1$ gives $x_i=\tfrac1{\sqrt3}$, and $x_i+y_i+z_i=0$ with $2(x_i^2+y_i^2+z_i^2)=1$ then forces $y_i=z_i=-\tfrac1{2\sqrt3}$. **So the shared-pair coefficient EQUALS $\max(x,y,z)$ there, and step 8 is tight at the same configuration.**

**The consequence is a localisation ON THE $+$ BRANCH ONLY, and the restriction is what makes [I111](../plan.md) possible** ([r1064](REVIEW_r1064.md) caught this paragraph contradicting that item). *On the $+$ branch a gain from (ii) must come from configurations where the Gram bound is SLACK, since where it is attained both steps are simultaneously tight.* **On the $-$ BRANCH THEY ARE NOT SIMULTANEOUSLY TIGHT**: there $x_i=-\tfrac1{\sqrt3}$ and $y_i=z_i=+\tfrac1{2\sqrt3}$, so the shared-pair coefficient is $-0.577350$ while $\max(x,y,z)=0.288675$, and step 8 is loose by the difference. *That is the whole of I111: the corner attains the Gram bound AND carries a gain, which the $+$ branch forbids and the $-$ branch permits.*

*The Gram bound is slack by $0.26$ at the note's own most permissive surviving configuration on the $+$ branch, so there the two sources are slack at the same places.*

## Step 8 is TIGHT, so the gain must live in I104's extra constraint, 2026-09-17

**Derived, then screened** ([screen_I104_step8_tight.py](../scripts/misc/screen_I104_step8_tight.py)). *L220 step 8 supplies the form explicitly, so no product formula for $\mathcal D_n$ is needed:* $\langle L_{\hat q}r,r\rangle=x(p^2+p'^2)+y(a'^2+b'^2)+z(c'^2+d'^2)+\tfrac12\sum_mc_m^{\mathsf T}\hat qc_m$, the cross term vanishing by orthogonality to $\Pi_Q$.

**The supremum equals the bound.** Over $\mathcal D_n\ominus\Pi_Q$, of dimension $18$ at $n=8$, $\sup_r\langle L_{\hat q}r,r\rangle/\lVert r\rVert^2=\max(x,y,z)$, and [r980](REVIEW_r980.md) strengthened this from a sample to a universal statement by building an exact maximiser at every shape. **But 'step 8 is ATTAINED and its own slack is zero' was scoped to the WRONG INEQUALITY and is REFUTED** ([r980](REVIEW_r980.md)).

**A refinement of this parent's, derived and then killed by its own vacuity check.** $\hat q$ annihilates $\mathbf 1_Q$, the sectional matrix on $Q$ having row sums $x+y+z=0$, so the sharper bound keeps only the part orthogonal to $\mathbf 1_Q$, discarding $2\max(x,y,z)\sum_m\langle c_m,\mathbf 1_Q\rangle^2/4$ with $\langle c_m,\mathbf 1_Q\rangle=\sum_{a\in Q}D_{am}$. *It is valid and strictly better pointwise, unviolated over $20000$ draws.* **And it is VACUOUS where it would have to act**: at $n=8$ a unit $r$ meeting every condition with all those components zero exists on a $14$-dimensional subspace of the $20$-dimensional $\mathcal D_n$, so the gain is exactly $0$ there. *Recorded so it is not retried.*

**What this leaves, stated narrowly.** The screen imposes only $r\in\mathcal D_n$ and $r\perp\Pi_Q$. **In I104 the residual $r_i=D-q_i$ carries the other two patterns' components, which is a further constraint**, so any gain must live in that extra structure. *This is a localisation and not a closure, and it removes the generic reading of source (ii) rather than the source itself.*

**Gate 1.** (a) The $\mathcal D_n$ dimension $n(n-3)/2=20$ is reproduced as a control. (b) The spectrum $\{0,2x,2y,2z\}$ is checked against its closed form over $200$ draws. (c) Every expectation in the screen is ASSERTED rather than printed, per [proposal 130](../.claude/skill-proposals.md). (d) The computed supremum is compared against $\max(x,y,z)$, the ceiling step 8 claims. **Gate 2 owed.**

## Step 8 is a CHAIN of two, and the parent audited only the first, 2026-09-17

**[r980](REVIEW_r980.md), sole reviewer, and its headline refutes this note's own previous section.** Step 8 reads

$$\kappa\ \le\ \max(x,y,z)\lVert q\rVert\lVert r\rVert^2\ \le\ \tfrac1{\sqrt3}\lVert q\rVert\lVert r\rVert^2\ =\ \tfrac\theta3\lVert r\rVert^2 .$$

*The FIRST link is sharp at every shape, which is what the previous section established and which r980 confirmed and strengthened.* **The SECOND link is an equality only at the three relabellings of $(2,-1,-1)$ and is slack everywhere else**, by $0.0105$ at $(3,-1,-2)$, $0.0148$ at $(1,-0.3,-0.7)$ and $0.0774$ at $(1,-1,0)$ ([screen_I104_step8_second_link.py](../scripts/misc/screen_I104_step8_second_link.py)).

**And both consuming chains take the second form**, which is the check r980 named as decisive and which is confirmed against the files here: [L220](../findings/second-order.md) step 9 reads *"Steps 6 to 8 give $\tfrac{\theta^3}6-\tfrac\theta2\lVert\nu\rVert^2\le\tfrac\theta3\lVert r\rVert^2$"*, and this note's own chain carries $\kappa_i\le\tfrac{u_i}{\sqrt3}(t-u_i^2)$. **So the slack is unclaimed by either, and it is of this item's own order**, the chain being short by $0.02$.

**Two corrections to the previous section's refinement, both r980's.** *"Strictly better pointwise" is FALSE on exactly the $14$-dimensional subspace where the maximisers live, where the two bounds are equal; the $20000$ clean draws are consistent with that, since random draws miss a codimension-four subspace with probability one.* And the discard constant is right only against the doubled quantity $2\langle L_{\hat q}r,r\rangle$, half that against $\langle L_{\hat q}r,r\rangle$, so the normalisation must be named.

**r980 also upgrades the vacuity from observation to theorem**: every maximiser is forced to have a zero $Q^{\mathsf c}\times Q^{\mathsf c}$ block, those entries entering the denominator alone, and the zero-row-sum condition then forces every $\langle c_m,\mathbf 1_Q\rangle=0$. *So the discarded term vanishes at ALL maximisers, at any $n$ and any shape, rather than on a subspace that happens to exist.* **That argument is r980's alone and is four lines, so it is the thing a second reader should check.**

**What this reopens, and the answer is NOTHING, checked the same hour.** *The parent recorded r980's finding as reopening a live source for the $0.02$. That inference does not hold.* **The chain also bounds $P(q)$ by step 7, and step 7 is tight at exactly the same shape.** Since the chain must hold at EVERY shape, what matters is the worst case over shapes of the TOTAL the two bounds give up, and a $200001$-point sweep of the shape circle puts that minimum at $0$, attained at the $S^2\times S^2$ shape where both slacks are exactly zero ([screen_I104_combined_slack.py](../scripts/misc/screen_I104_combined_slack.py)). **So this is the section four headings above, *A candidate for the $0.02$, REFUTED: steps 7 and 8 want the SAME shape*, arriving in new dress.** *What r980 genuinely adds is that the second link is WHERE step 8 gives something up, and what this check adds is that it gives it up only where step 7 does too.* **r980's claim-3 verdict stands as far as it goes**: the parent did audit only the first link and did conclude about the whole. *The step from there to a live source is the parent's own and is withdrawn.* **Gate 2 owed on this withdrawal, and r980 was a sole reviewer by design, so its own two new arguments still want a second reader.**

## An attempt on the $x\to\kappa_i$ link, recorded elsewhere and NOT a result, 2026-09-17

**The constrained maximum of $\kappa_1$ was computed with all three block norms imposed, and it is written up in [the I106b face note](2026-09-17-I106b-face.md), which is where the cycle was working when it happened.** *Pointer left here so it is findable from the item it concerns rather than only from the file it was typed into.*

**Nothing from it is a result.** *Its control passes, dropping the other two block constraints returns the chain's bound to $10^{-6}$, so the machinery reaches the bound.* **But it imposed all three block norms at $u_i=0.41$ simultaneously, which this file never asserts**: $0.41$ is a point in ONE block's admissible interval, $u_i\le\sqrt t=0.4427$, not a joint three-block configuration. *A successor should impose $\sum_iu_i^2\le\tfrac53t$ instead.*

**AND ITS KILLER ARGUMENT WAS MADE AT A POINT THE GRAM BOUND EXCLUDES, so it does not stand.** *The attempt was abandoned because at $N_i=0.268$, $t=0.196$ the ENTIRE coupling bound $\kappa_i\le\tfrac{u_i}{\sqrt3}(t-u_i^2)$ is $0.0066$, below the deficit, so driving $\kappa$ to zero could not close it there.* **At the surviving $t=0.346$, with $u$ pinned by the Gram bound to $[0.437539,0.438432]$, the same bound gives $[0.038926,0.039044]$, which is $2.63$ times the $0.0148$ deficit.** *The ordering flips, so the coupling source is live rather than spent* ([screen_I104_kappa_at_survivor.py](../scripts/misc/screen_I104_kappa_at_survivor.py), which reproduces the recorded $0.0066$ first as its control). **This says the source has the magnitude, not that any of it is recoverable.**

### The link itself, derived: $p+p'=\tfrac13(x_2+x_3)$

**[L220](../findings/second-order.md) step 8 carries $r_1$'s entries on the pairs $ij$ and $kl$ against $\hat q$'s coefficient $x$, then discards the whole form for $\max(x,y,z)\lVert q\rVert\lVert r\rVert^2$.** *This file already says $r_i$ carries the other two patterns "confined by the rank-one structure to the single $\hat e_i$ channel". That confinement is a number.* With $p=r_1[i,j]$ and $p'=r_1[k,l]$,

$$p+p'=\tfrac13(x_2+x_3).$$

**Derived from this file's own geometry.** *$q_1$ lies in $\Pi_{Q_1}$, whose $ij$ and $kl$ entries share a pairing and are therefore EQUAL, so $(q_1)_{ij}+(q_1)_{kl}=2c$ with $c$ the first-pairing coefficient. $D_{ij}=x_1+x_2$ and $D_{kl}=x_1+x_3$, since $Q_3$ misses $ij$ and $Q_2$ misses $kl$. So $p+p'=2x_1+x_2+x_3-2c$, and the cross-Gram's principal cosine of exactly $\tfrac13$ gives $c=x_1+\tfrac13(x_2+x_3)$.*

**GATE 2 LANDED, and it corrected this subsection in three places and then retired the route** ([r986](REVIEW_r986.md), [r987](REVIEW_r987.md), identical cold briefs).

**The link is STRONGER than first recorded.** *Both readers refuted the claim that $p$ and $p'$ are only jointly determined: $p=\tfrac13(2x_2-x_3)$ and $p'=\tfrac13(2x_3-x_2)$ are each pinned, so the link feeds the IDENTITY $p^2+p'^2=\tfrac19(5x_2^2-8x_2x_3+5x_3^2)$, and the inequality above throws away $\tfrac12(x_2-x_3)^2$.* **The first pass tested one guess, $p=x_2/3$, and read its failure as non-existence.**

**And the SCOPE was coordinates rather than mathematics.** *Written in the pairing sums it is unconditional:* $p+p'=\tfrac13\sum_{a<b\in Q_1}D_{ab}$ **for every $D\in\mathcal D_n$, with no hypothesis at all**, reducing to the form above in span because $\Pi_{Q_1}$'s six entries sum to zero. *Validated here by a route sharing nothing with r986's, to $1.5\cdot10^{-15}$ over $2000$ generic $D$.* **The two readers reconcile rather than conflict**: the $\Sigma$ form is unconditional, the $x_2+x_3$ form is scoped for $n\ge7$, and [r987](REVIEW_r987.md)'s $\tau_1$ is exactly their difference, with $\sup\lvert\tau_1\rvert=0,0.258,0.352,0.414,0.459$ at $n=6\ldots10$.

**A SYMBOL COLLISION this file owns.** *$\langle q_1,q_2\rangle=c_1c_2$ in PROJECTION coefficients, not $x_1x_2$ in component ones, the two related by $c_a=\tfrac23x_a+\tfrac13S$ with $S=x_1+x_2+x_3$.* **The $x_a$ of the derivation above are COMPONENT coefficients and are a different object from the $x_a$ of the cross-Gram statement.** *Confirmed independently, $600/600$ draws each way.*

**AND THE ROUTE IS RETIRED ON SIZE, which is the finding that matters.** *Spent inside the expansion rather than the operator-norm bound, the gain is $(\mu-x)(p^2+p'^2)\lVert q\rVert$ with $\mu=\max(x,y,z)$, so the coefficient is never negative and the sign worry does not bite* ([r986](REVIEW_r986.md)). **But with every factor pushed independently to its own extreme, a strict over-estimate, the ceiling is $0.0089895$ against the $0.0148$ deficit: $60.8\%$ of it, short by a factor $1.65$** ([r987](REVIEW_r987.md)). *Rebuilt here from the definitions before folding, a refutation retiring a route carrying the heavier burden* ([screen_I104_kappa_at_survivor.py](../scripts/misc/screen_I104_kappa_at_survivor.py)). **So the link cannot close this deficit, and the item's last live source is spent as a closer.**

*What [r987](REVIEW_r987.md) offers instead, and the item should carry it: with $s=\tfrac13(x_2+x_3)$ known and $d=p-p'$ free, the expansion's whole dependence on the two channels is $\tfrac x2(s^2+d^2)+s[z(a'+b')+y(c'+d')]$, one free parameter with the sign condition visible rather than hidden, and the linear term in $\Sigma$ fully determined.*

## The joint system's $x$-dependence, QUANTIFIED at last, 2026-09-17

**The note's other live source, flagged above as carried by the system's $x$-dependence, is now a number.** *With the coupling-bound source closed twice over, this is the only one left.*

**What the system forces, AT THE CONFIGURATION THAT SURVIVES THE GRAM BOUND.** That configuration is $t=0.346$, at $N_i=0.218$ and $\tau=0.0509$. There the Gram bound pins $u$ from BOTH sides, which the interval recorded in this file does not: $\sum_au_a^2=3u^2\le\tfrac53t$ forces $u\le\sqrt{5t/9}=0.438432$, well inside this file's own $u\le\sqrt t=0.588218$, so the admissible interval is $[0.437539,0.438432]$ and is $0.0009$ wide. With $\sum u_a^2=0.574322$ the $x$-FREE part reads $\sum u^2\le t=0.346$, VIOLATED by $0.228322$, and Cauchy--Schwarz gives $S_1^2\le3S_2$, hence $\tfrac9{10}S_1^2-\tfrac32S_2\le1.2\,S_2$, so

$$S_2=\sum_ix_i^2\ \ge\ \frac{0.228322}{1.2}=0.190268,$$

**with equality only when all $x_i$ are equal**, and over the whole admissible interval $S_2$ runs $[0.190268,0.192222]$, a window of $1.0\%$.

**The scalar corollary is NEARLY TIGHT here, and this is the correction that matters.** At $t=0.346$ it gives $\tfrac53t=0.576667$ against $\sum u_a^2=0.574322$, slack $0.002345$. *The $0.2586$ this section carried is the slack at $t=0.598$, which the Gram bound EXCLUDES, and it is larger by a factor of $110$.* **So the joint system's extra content over the scalar corollary, at the configuration that actually survives, is a hundredth of what was claimed** ([r983](REVIEW_r983.md), validated and located in [screen_I104_r983_validation.py](../scripts/misc/screen_I104_r983_validation.py)).

**WHAT THIS DOES NOT DO, stated plainly.** *It does not close the $0.02$.* Closing it needs the link from $x$ to the coupling bound $\kappa_i$, and that link is NOT established. **So the item's remaining work is exactly that link, and it is now the only thing between the joint system and the gap.**

**A NAMING TRAP, recorded so nobody walks into it.** *These $x_i$ are the SHARED-CHANNEL coefficients of the Gram system. They are NOT [L220](../findings/second-order.md)'s sectional shape $(x,y,z)$.* **Same letter, different object**, and the record's own rule is to search by the object rather than by the vocabulary. *The two appear within a few paragraphs of each other in this file.*

**Gate 1.** (a) The system's two forms are asserted to agree before either is used. (b) The forced bound is reached by two independent routes that are asserted equal. (c) The configuration is the one already on record rather than a new one. (d) The forced $S_2$ is compared against $0$, which is what "the scalar corollary loses nothing" would require. **Gate 2 owed.**

## The recorded $0.02$ sits at a configuration the GRAM BOUND excludes, 2026-09-17

**The chain's worst shortfall is at an infeasible point, and the deficit that survives is smaller.** *The Gram bound $\sum_iu_i^2\le\tfrac53t$ is a THEOREM, proved exact in the section above.*

**The worst is $-0.020422$, at $N_1=N_2=N_3=0.278$ with $\tau$ at its bound $0.0733$.** *This file once named $N_i=0.268$, $\tau=0.069$ instead, which gives $-0.019646$ and is a different point* ([r983](REVIEW_r983.md)).

**At the $N_i=0.268$ point the admissible interval starts at $u_{\mathrm{lo}}=(\theta-2\tau/N_i)/\sqrt3=0.4098$**, so the smallest admissible $\sum_iu_i^2$ is $3\cdot0.4098^2=0.504$, against $\tfrac53t=0.327$. **The same test excludes the true worst at $N_i=0.278$**, which is the assertion the screen carries. **Neither configuration can occur.**

*Why testing at $u_{\mathrm{lo}}$ is the right test: it MINIMISES $\sum_iu_i^2$ over the interval, so if even the minimum violates the bound then every admissible triple there does, and the test is the most permissive one available.*

| sweep | worst shortfall | at |
|---|---|---|
| all configurations | $-0.020422$ | $N_i=0.278$, $\tau=0.0733$, EXCLUDED by the Gram bound |
| Gram-admitted, $\tau\le\tfrac12N_i^{3/2}$ | $-0.014793$ | $N_i=0.218$, $\tau=0.0509$ |
| *beyond the derived $\tau$ bound, INADMISSIBLE* | *$-0.051512$* | *$N_i=0.3030$, $\tau=0.1265$ against the derived $0.0834$, recorded only to show what r983's sweep reached* |

**THE $\tau$ CEILING IS THIS FILE'S OWN DERIVED CONSTANT, SO THE DEFICIT IS $0.0148$.** *The sweep runs $\tau$ up to $\tfrac12N_i^{3/2}$, which on the equal-$N_i$ diagonal it sweeps is exactly $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$, [derived above](#the-product-constant-derived-lverttaurvertletfrac12sqrtn_1n_2n_3) from $\lVert\nu_1\circ\nu_2\rVert\le\tfrac12\sqrt{N_1N_2}$ and $\lvert\tau\rvert\le\lVert\nu_1\circ\nu_2\rVert\lVert\nu_3\rVert$.* **So the sweep implements a theorem, and every point it tabulates sits at that bound, which is what "with $\tau$ at its bound" means.** *[r983](REVIEW_r983.md) swept past the bound and found $-0.0515$ at $\tau=0.1265$ where the derived constant allows $0.0834$, so those configurations are inadmissible and the figure says nothing about the item.* **The reviewer was right that the brief never stated the ceiling, and it was the BRIEF that omitted it rather than the record.** *A cold reader cannot tell a theorem from a loop bound, which is what the rule about quoting every constant an attack item needs is for.*

**A CORRECTION THIS FILE OWES ITSELF.** *An earlier pass of this section recorded the ceiling as unstated and the deficit as $0.0148$ or $0.0515$ pending a decision. That was wrong, and the derivation stood under its own heading a hundred lines above, in this file, unread.* **The rule it broke is step 1's first: search THIS repository before deriving, and read the file you are about to write into.**

**What this is worth.** *It shrinks the gap the estimates must find rather than finding any of it*, and it does so from a bound the file already had and already called exact, which is the cheapest kind of progress available.

**WHAT IT DOES NOT SUPPORT, and this file asserted it for a day.** *The sentence that the two sources above "now have $0.0148$ to cover" joined two blocks standing at DIFFERENT configurations*, the exclusion block at $t=0.196$ and $t=0.166$, the surviving point at $t=0.346$, the forcing block at $t=0.598$. **Four configurations, so the arithmetic joining them was never well posed** ([r983](REVIEW_r983.md), reproduced from $t=1-3N_i$ alone). *The forcing is now restated at $t=0.346$ above, which is the one configuration both sections may speak about.* **Gate 2 LANDED, and this section is what it corrected.**

## The joint system's algebra is TYPED, 2026-09-17

**The Gate 2 brief for the two claims above named two steps as typeable and untyped, and both are now closed** in [I104GramSystem.lean](../lean/HamiltonsCubic/Results/I104GramSystem.lean). *Neither needs a matrix, so both type in the base layer exactly as they stand, and recording them as a debt would have been the easier and wrong move.*

| declaration | what it types |
|---|---|
| `joint_system_substitute` | the step this note performs in words, $\beta_a^2=u_a^2-\alpha_a^2$ turning the first form into $\sum u_a^2+\tfrac12\sum\alpha_a^2-\tfrac3{10}(\sum\alpha_a)^2$ |
| `alpha_to_x` | the rescaling under $\alpha_i=sx_i$, $s^2=3$, carrying $(\tfrac12,\tfrac3{10})$ to $(\tfrac32,\tfrac9{10})$ |
| `sum_sq_three` | Cauchy--Schwarz at three terms |
| `forcing` | if the $x$-dependent part must supply at least $d$, then $\sum x_i^2\ge\tfrac56d$ |

**`joint_system_substitute` is the one worth having.** *It is the step stated as a clause rather than a display, and a sign or a coefficient going wrong there is invisible in prose while changing the forcing constant.*

**And `forcing` settles a spelling.** *This note writes the constant as $1/1.2$; it is $\tfrac56$, out of $\tfrac{27}{10}-\tfrac32=\tfrac65$.* **Two spellings of one number, and only one of them is checkable by eye**, which is the whole reason the step was worth a declaration.

*`alpha_to_x` is stated against a constant with $s^2=3$ rather than against $\sqrt3$, so its content is the scaling and not a square-root lemma.* **NOT typed**: that the system HOLDS, which is this file's own derivation from minimality of the $e$-part and needs $G_e$ and its inverse. All four on standard axioms.

## What [r1059](REVIEW_r1059.md) adds, and what it deletes, 2026-09-21

**A section stood here claiming the second link fails on LOCATION, its slack vanishing at "the conjecture's own equality case". IT IS DELETED RATHER THAN CORRECTED, because the right statement is a hundred lines above it in this file** ([the combined-slack paragraph](#)), *which prices the worst case over shapes of the TOTAL the two bounds give up at $0$ on a $200001$-point sweep, attained where both slacks are exactly zero.* **That argument is rigorous, general, and was written the same hour [r980](REVIEW_r980.md) found the slack.**

**THE DELETED VERSION ALSO CARRIED A FALSE OBJECT CLAIM**, that $(2,-1,-1)$ is the conjecture's extremal object. *No sphere product is in this stratum at any $n$, being diagonal with every block component zero against [I104](../plan.md)'s two nonzero ones, and it could not be, since $\theta_0(12)^2=1.5278$ against $\theta^2\le\tfrac65$.* **The record's own "$S^2\times S^2$ shape" at step 7 is sound about a four-set sectional shape and says nothing about which configuration carries it.** *A shape name was read as an object identity.*

**WHAT SURVIVES IS [r1059](REVIEW_r1059.md)'S OWN PRICING AT THE BINDING CORNER, WHICH IS NEW.** *At [post F70](../findings/fence-posts.md)'s $t=0.346$ the upper $u$-pin $0.438432$ IS the Gram bound $\sqrt{5t/9}$, verified to six places, and this file's forcing $S_2\ge0.190268$ gives $\lvert c\rvert\ge0.575579$ against $\tfrac1{\sqrt3}$ (**the forcing is on the MAGNITUDE and this sentence read it as $\max(x,y,z)$**, [r1063](REVIEW_r1063.md); at the forced shape $\max(x,y,z)=0.288675$): slack at most $0.001771$, gain at most $0.00012$, under $1\%$ of the deficit.* **Two conditions it carries and the deleted version stated neither**: equal $N_i$, which [commit 269f871e](../findings/LEDGER.md) already flags as owing a reviewer, and $x_i>0$. *At $x_i<0$ the link gives up $0.2505$, seventeen times the deficit, and that regime is not the binding one because the chain is not worst there.*

**AND TWO FIGURES IN THIS FILE ARE STALE**, both [r1059](REVIEW_r1059.md)'s. *The deficit is set by the GRAM BOUND rather than by this file's $\tau$ ceiling, which was already in force when the figure read $0.02$; and [screen_I104_step8_second_link.py](../scripts/misc/screen_I104_step8_second_link.py)'s own closing line still prices the chain as short by $0.02$ where it is $0.0148$.*

## BOTH NAMED LOSSES IN THE CHAIN ARE NOW ACCOUNTED FOR, 2026-09-21

**This file's own opening names exactly two**, the lossy coupling bound $\kappa_i\le\tfrac{u_i}{\sqrt3}(t-u_i^2)$ and the cross-term angle $\tfrac13$. *Neither can supply the $0.0148$, and the reasons are different.*

- **The coupling bound is PRICED AT $0.0089895$** by [post F70](../findings/fence-posts.md), $60.8\%$ of the deficit, short by a factor $1.65$, with every factor already at its own extreme.
- **The cross-term angle $\tfrac13$ IS THE GRAM GEOMETRY AND IS EXACT.** *It is the pairwise cosine between the three pattern planes, which gives $\sum_iu_i^2\le\tfrac53t$, and [this file](#) records that bound as a THEOREM proved exact.* **So it has no slack to give, and it is the bound that PINS the binding corner**, $u=\sqrt{5t/9}=0.438432$ at $t=0.346$.

**WHICH SHARPENS WHAT A SUCCESSOR NEEDS, FROM `a new source` TO SOMETHING CHECKABLE.** *The deficit sits where the chain is WORST, and that is by construction where every bound is tight. A source slack elsewhere and zero at the binding corner closes nothing, which is what killed step 8's second link and what makes the $x_i<0$ regime irrelevant despite its $0.2505$.* **So the requirement is a step that is LOSSY AT THE BINDING CORNER ITSELF**, where the Gram bound saturates and $\lvert c\rvert\ge0.575579$ (**magnitude, not $\max$**, [r1063](REVIEW_r1063.md)). *Neither named loss is, and no third loss is named in this file.*

**AND THE SWEEP'S OWN HYPOTHESIS IS NOW TESTED AND HOLDS, 2026-09-21** ([screen_I104_unequal_N.py](../scripts/misc/screen_I104_unequal_N.py)). *The pricing assumes the three blocks share one $N_i$, which [commit 269f871e](../findings/LEDGER.md) flags as owing a reviewer, and if unequal $N_i$ admitted a worse configuration the $0.0148$ would itself be unpriced.* **Over the full three-dimensional grid the minimiser IS the diagonal, and unequal $N_i$ buys $0.000000$ of extra shortfall.** *The control reproduces the recorded $-0.020422$ at $N_i=0.278$ to six decimals before anything else is reported.*

**What that limits.** *The grid spacing is $0.005$ and misses $0.278$, so it reports $-0.020195$ where the record has $-0.020422$: the LOCATION finding is what this settles, and the exact value stays the record's.* **It is a screen over a grid and not a proof that the diagonal is optimal**, which would need the first-order condition in $N_i$.

## The second $\tau$ bound is not independent information at the binding corner, 2026-09-21

**Checked because the accounting above leaves no named loss, so a second bound on $\tau$ would be the obvious next source.** *It is not one.*

**The bound is $\tau\le\big(N_jN_k+(\theta^2-3u_i^2)N_i\big)/4\theta$ and it DEPENDS ON $u_i$.** *Its reduced form $\tau\le N_jN_k/4\theta$ is the value at $u_i\to\theta/\sqrt3$ and not the bound.* **At the binding configuration the full bound gives $0.069131$ against the product bound's $0.069370$**, agreeing to three decimals, which is what [the section deriving it](#) already records as *"equal to the product bound, so it does not close the $0.02$"*.

**A TRUNCATION OF IT APPEARS TO CLOSE THE ITEM OUTRIGHT, WHICH IS WORTH RECORDING AS A TRAP.** *Using the reduced form at $u_i\approx0.41$ gives $\tau\le0.014661$, which drives the admissible interval empty at every grid point, $u\ge0.6416$ against $u\le0.4074$, and so excludes every configuration.* **The dropped term $(\theta^2-3u_i^2)N_i$ is the whole of that apparent closure**, and it is positive and large away from $u_i=\theta/\sqrt3=0.7071$.

*So the per-block quadratic structure is spent, exactly as the deriving section concludes, and the accounting stands: $0.0090$ of recoverable slack against $0.0148$, with no third loss named.*

## The deficit is a CUBIC in $\sqrt{N_i}$, and the corner is exact in radicals, 2026-09-21

**Opening [I110](../plan.md), the deficit is derived rather than swept, and every quantity at the worst configuration is an algebraic number.** *Typed in [I110Deficit.lean](../lean/HamiltonsCubic/Results/I110Deficit.lean).*

**Write $s=\sqrt{N_i}$, on the equal-$N_i$ diagonal with $\tau$ at its bound $\tfrac12N_i^{3/2}=\tfrac12s^3$.** Then $2\tau/N_i=s$ exactly, so the criticality bound's lower end is $u_{\mathrm{lo}}=(\theta-s)/\sqrt3$ with no square root left to estimate, and $t+N_i=1-2s^2$.

**Substituting gives the deficit in closed form, with every $\sqrt3$ cancelling:**

$$d(s)\;=\;-F\!\left(\tfrac{\theta-s}{\sqrt3}\right)\;=\;\frac{s^3}{9}-\frac{\sqrt6\,s^2}{6}+\frac{5s}{12}-\frac{\sqrt6}{24}.$$

**A cubic, so the sweep was never needed.** *Its derivative is $d'(s)=\big((2s-\sqrt6)^2-1\big)/12$, positive for $s<(\sqrt6-1)/2=0.724745$, and the Gram-feasible range stops at $0.467647$, so $d$ is strictly increasing there and the sign is not delicate.*

**THEREFORE THE DEFICIT IS ATTAINED AT THE GRAM-FEASIBILITY BOUNDARY**, which is the root of $36s^2-6\sqrt6\,s-1=0$, namely

$$s_*=\frac{\sqrt6+\sqrt{10}}{12},\qquad N_i=\frac19+\frac{\sqrt{15}}{36},\qquad t=\frac23-\frac{\sqrt{15}}{12},\qquad u=\frac{15\sqrt2-\sqrt{30}}{36},$$

numerically $0.467647$, $0.218694$, $0.343918$, $0.437110$.

**BOTH CONSTRAINTS ARE ACTIVE THERE, AS AN IDENTITY.** *At $s_*$ the criticality end squares to exactly $5t/9$, the Gram pin: $u_{\mathrm{lo}}^2-\tfrac59t=0$ on the nose, which is the same equation as the boundary root and is why the two meet.*

**And the deficit at the corner is $\dfrac{11\sqrt{10}}{486}-\dfrac{5\sqrt6}{216}=0.0148730342706614$**, against the record's $0.0148$, which it reproduces to four figures and now explains.

**So [I110](../plan.md)'s premise holds with the corner pinned exactly, and its question stands as posed**: substitute that configuration into the FULL criticality system for $D_n\oplus V_{Q_1}\oplus V_{Q_2}\oplus V_{Q_1\triangle Q_2}$, and decide whether it is feasible.

**One trap worth the line: a grid cannot find this point.** *The maximiser sits on a constraint boundary, so a sweep of spacing $0.005$ reports an argmin at $N_i=0.2172$ with Gram slack $1.45\times10^{-2}$ and makes the two constraints look independent. The closed form shows they are the same equation.*

## The second $\tau$ bound is the product bound, IDENTICALLY, and that pins every surviving block, 2026-09-21

**The section above records the two bounds agreeing to three decimals at one configuration. They agree exactly, everywhere on the equal diagonal, and the proof is one line.**

**With $N_i=s^2$ equal, $\tau=\tfrac12s^3$ at the product bound and $u_i=u_{\mathrm{lo}}=(\theta-s)/\sqrt3$**, the vector system's bound $\tau\le\big(N_jN_k+(\theta^2-3u_i^2)N_i\big)/4\theta$ has numerator

$$s^4+\big(\theta^2-(\theta-s)^2\big)s^2\;=\;s^4+(2\theta s-s^2)s^2\;=\;2\theta s^3,$$

which is $4\theta\cdot\tfrac12s^3$. **So the vector bound is SATURATED at $\tau$'s product bound, for every $s$, not merely at the configuration the earlier section checked.** *The $s^4$ cancels against the $-s^4$ the square expansion leaves, which is why the two bounds are the same number rather than two numbers that happen to be close.*

**THE CONSEQUENCE IS RIGIDITY, AND IT IS WHAT [I110](../plan.md) NEEDS.** *Saturation of the vector bound forces equality in the step it was derived through, $4\lVert\nu_j\circ\nu_k\rVert^2=N_jN_k$, which is the product bound's own equality case.* **That case is explicit**: in the signed coordinates $(a,b,c)$ on a block's three pairings it is $a_1=a_2=0$ together with $\lvert b\rvert=\lvert c\rvert$, and under Bianchi's $a+b+c=0$ the second condition follows from the first. **So at the binding corner every $\nu_i$ vanishes on the pairing that pairs its two shared pairs against each other, and $\nu_3$ is parallel to $\nu_1\circ\nu_2$**, cyclically. *Each $\nu_i$ is then determined up to sign by $N_i$ alone, which turns the three vector equations $(\theta-2L_{q_i})\nu_i=2\nu_j\circ\nu_k$ into scalars.*

**The three conditions are consistent, which is worth checking because they look like three demands on one block.** *$Q_1$ meets $Q_2$ in $\{i,j\}$ and $Q_3$ in $\{k,l\}$, and the pairing $(ij\vert kl)$ is the same pairing of $Q_1$ either way, so the two products involving $\nu_1$ kill the same coordinate.*

**And $\tau$ cannot be much below its bound anywhere on the surviving region.** *Writing $\tau=f\cdot\tfrac12s^3$, the deficit is*

$$d(s,f)=\frac{f(3-f^2)s^3}{18}+\frac{5fs}{12}-\frac{\sqrt6\,(1+f^2)s^2}{12}-\frac{\sqrt6}{24},$$

*and $\partial d/\partial s=0$ on $d=0$ only at $s=\sqrt{10}/4$ and $s=\sqrt2$, both outside the Gram-feasible range, so the least $f$ on the surviving set sits where $d=0$ meets the Gram boundary.* **That root is $f=0.891690$ at $s=0.441973$, $N_i=0.195340$**, so **every surviving configuration has $\tau$ within $11\%$ of its product bound**, and the corner has it exactly.

## $F$ is increasing on the whole admissible interval ON THE EQUAL-$N_i$ DIAGONAL, derived rather than sampled, 2026-09-21

**The closed form above rests on the minimum of $F$ sitting at $u_{\mathrm{lo}}$, and that step was checked at five points. It is a two-line consequence of two discriminants, and it holds everywhere.**

**Step 1, the derivative at the lower end is a quadratic with no real root.** With $\theta^2=\tfrac32$, $t+N_i=1-2s^2$ and $u_{\mathrm{lo}}=(\theta-s)/\sqrt3$,

$$F'(u)=2\theta u-\frac{\sqrt3}{2}u^2-\frac{1-2s^2}{\sqrt3},\qquad F'(u_{\mathrm{lo}})=\frac{1}{\sqrt3}\left(\frac{3s^2}{2}-\frac{\sqrt6\,s}{2}+\frac54\right)=\frac{1}{\sqrt3}\left(\frac32\Big(s-\frac{\sqrt6}{6}\Big)^2+1\right).$$

**So $F'(u_{\mathrm{lo}})\ge1/\sqrt3$ for every $s$**, the quadratic's discriminant being $\tfrac64-4\cdot\tfrac32\cdot\tfrac54=-6$. *The sampled values $+0.5773$ to $+0.5804$ are this expression near its minimum, which is why they looked flat.*

**Step 2, the interval ends before $F'$ can turn.** $F'$ is a downward parabola in $u$ with roots $\sqrt2\pm\tfrac23\sqrt{3+3s^2}$, so its upper root is at least $\sqrt2+\tfrac{2\sqrt3}{3}=2.5690$, while the admissible interval ends at $u_i\le\sqrt t\le1$.

**THEREFORE $F'>0$ ON ALL OF $[u_{\mathrm{lo}},\sqrt t\,]$, SO $F$ IS STRICTLY INCREASING THERE AND ITS MINIMUM IS AT $u_{\mathrm{lo}}$.** *The deficit's closed form is a theorem about the interval, not about the point where it was sampled.*

**THE SCOPE IS THE EQUAL-$N_i$ DIAGONAL, AND STEP 1 IS WHERE IT ENTERS** ([r1061](REVIEW_r1061.md)). *The substitution $t+\tfrac{N-N_i}2=1-2s^2$ holds only there.* **Off the diagonal the minimum can be INTERIOR**: at $N=(0.02,0.30,0.30)$ the criticality end is $u_{\mathrm{lo},1}=-0.5176$, so $F_1'(0)=-0.3926$ and the minimum sits at $0.1706$. *The trap is that $F_1(0)=+0.00897$ while the minimum is about $-0.0235$, so reading the lower end alone reports an exclusion that is not there.* **Any use of this step off the diagonal minimises over the interval rather than evaluating at its end.**


## THE PRINTED BILINEAR FORMULA CARRIES A WRONG SIGN, AND THE PRODUCT BOUND STANDS, 2026-09-21

**The $(kp,lm)$ output coefficient reads $-\tfrac12(b_1c_2+c_1b_2)$ and is $+\tfrac12(b_1c_2+c_1b_2)$.** *Found by [r1060](REVIEW_r1060.md) and confirmed here.*

**THE TEST IS CYCLIC SYMMETRY, AND IT IS DECISIVE BECAUSE THE RECORD PROVES THE FORM IS SYMMETRIC.** $\tau=\langle\nu_1\circ\nu_2,\nu_3\rangle$ is $T(\nu_1,\nu_2,\nu_3)$, and [second-order.md](../findings/second-order.md) proves $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ **fully symmetric**. *As printed it is not: the cyclic defect is exactly $2c_2(b_3c_1-b_1c_3)$, nonzero. With the sign flipped it is invariant under cyclic rotation and under transposition both.*

**The flip costs nothing and fixes everything.** *It leaves $\lVert\nu_1\circ\nu_2\rVert^2=\tfrac12A$ untouched, since $A$ carries that coefficient squared, so the derivation of $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$ is unaffected.*

**AND THE BOUND IS ATTAINED UNDER BIANCHI.** *Maximising over the three Bianchi planes gives $\max\lvert\tau\rvert/\sqrt{S_1S_2S_3}=\sqrt2$ with the corrected sign, against $\sqrt6/3$ with the printed one.* **So the product bound is sharp on the space $\nu_i$ actually live in, the equality case is reachable, and $f=1$ is available.**

**A REFUTATION RECORDED HERE EARLIER IS WITHDRAWN IN FULL.** *It read the printed sign as the mathematics, concluded the bound was lossy by $\sqrt3$, and closed I104's chain on the equal-$N_i$ diagonal with margin $0.0374$. Every step of it was correct about the printed formula and none of it is about the Fox product.* **I104's $\tau>0$ case is exactly where it was**, short by $0.0148$ at the corner this file pins.

**THE LESSON IS THE CHEAP INVARIANT.** *A trilinear form the record proves symmetric has a one-line test, and a printed formula for it is checkable in seconds against a cyclic permutation. Three sections of derivation were built on a coefficient nobody had permuted.*

## THE FULL CRITICALITY SYSTEM AT THE CORNER, GATHERED IN ONE PLACE, 2026-09-21

**This is what [I110](../plan.md) owes before its substitution, and every piece of it is already on the record.** *Gathered rather than derived.*

**The splitting.** [L221's step 1](../findings/second-order.md) gives it verbatim: the characters trivial on $\ker\chi_{Q_1}\cap\ker\chi_{Q_2}$ are $\{1,\chi_{Q_1},\chi_{Q_2},\chi_{Q_3}\}$, so $\mathcal S$ is a subalgebra and **criticality splits into four equations**, one per character:

$$D\circ D+\sum_i\nu_i\circ\nu_i=\theta D,\qquad 2D\circ\nu_i+2\nu_j\circ\nu_k=\theta\nu_i\ \ \text{for }\{i,j,k\}=\{1,2,3\}.$$

**The three block equations reduce to the plane.** [L220's step 4](../findings/second-order.md) gives $\langle D\circ\nu_i,\nu_i\rangle=\langle L_{q_i}\nu_i,\nu_i\rangle$ with $q_i$ the projection of $D$ on $\Pi_{Q_i}$, so the $\chi_{Q_i}$ equation is

$$(\theta-2L_{q_i})\,\nu_i=2\,\nu_j\circ\nu_k,$$

**an equation between two vectors in the TWO-dimensional $V_{Q_i}$**, since first Bianchi cuts a four-set block from three dimensions to two ([L120's proof](../findings/second-order.md)). *So the three block equations are SIX scalar equations, not nine.*

**The unknowns at the corner.** *$N_i$, $t$, $u_i$ and $\tau$ are all fixed by the radicals above. What is free is the DIRECTION of each $\nu_i$ in its own plane, three angles, together with the diagonal part $D$ subject to $\lVert D\rVert^2=t$ and to its three projections having the pinned norms $u_i$ at the pinned mutual cosines $(\tfrac13,0)$.*

**So the substitution is six scalar equations in three angles, with the $\mathcal D_n$ equation on top.** *Overdetermined by three, which is why an answer is reachable: three angles cannot generically satisfy six equations, and the question is whether this configuration is the exception.*

**Two things the substitution must carry, both from Gate 2.** *The closed form above is the equal-$N_i$ diagonal, and $\nu_1\circ\nu_2$ must be computed with the CORRECTED sign on the $(kp,lm)$ slot, since the printed one is not the product.*

## I110 IS SETTLED: THE CORNER IS EXCLUDED, BECAUSE ITS OWN TWO CONDITIONS FORCE $P(q_i)$ TO ITS MINIMUM, 2026-09-22

**[I110](../plan.md) asked whether I104's binding corner exists. It does not.** *Gate 2, [r1062](REVIEW_r1062.md) and [r1063](REVIEW_r1063.md) on identical cold briefs, both refuting the same claim by different routes, and validated here from [L121](../findings/second-order.md)'s matrix independently of both.*

**Two conditions hold at the corner, and each was derived separately.**

1. **The pinning is tight**, since $u_i=u_{\mathrm{lo}}$, so $\nu_i$ is the TOP eigenvector of $L_{q_i}$ on the Bianchi plane. *[r1062](REVIEW_r1062.md) strengthens this: L220 step 5's $E=3\lVert q\rVert^2$ makes $e_i=\tfrac{\sqrt3}2u_i$ an IDENTITY for every $q\in\Pi_Q$, not a bound that might go unattained.*
2. **The product bound is saturated**, since the two sides of the block equation have equal norm, so $\nu_i$ is the equality case and has a vanishing signed coordinate, $\nu_i\propto(0,1,-1)$.

**PUT TOGETHER THEY PIN $q_i$'S SHAPE, AND TO THE WRONG SIGN.** With [L121](../findings/second-order.md)'s $G=\begin{pmatrix}A&C&B\\C&B&A\\B&A&C\end{pmatrix}$, condition 2 forces $B=C$ and then

$$G(0,1,-1)=(B-A)(0,1,-1),\qquad G(2,-1,-1)=(A-B)(2,-1,-1),$$

*so the two eigenvalues on $\mathbf1^\perp$ are exactly $\pm(B-A)$.* **Condition 1 picks the top one, which is $\nu_i\propto(0,1,-1)$ only when $B>A$**, and $q_i$'s $\mathbf1^\perp$-component is then $\tfrac{B-A}3(-2,1,1)$, a POSITIVE multiple of $(-2,1,1)$.

**THAT IS THE NEGATIVE OF THE SHAPE WHERE $P$ IS MAXIMISED, SO $P(q_i)=-\tfrac{\sqrt3}2u_i^3$ WHERE THE CHAIN'S STEP 7 ALLOWED $+\tfrac{\sqrt3}2u_i^3$.** *Substituting the forced value into the exact $q_i$-pairing identity moves $F$ by $\sqrt3u^3=0.1446553$, from $-0.0148730$ to $+0.1297823$.* **$F>0$ excludes the configuration, so the corner is not merely off the boundary of realisability, it is outside it.**

**AND $D$ IS UNIQUE, WHICH GIVES A SECOND EXCLUSION BY A DIFFERENT QUANTITY** ([r1063](REVIEW_r1063.md)). *The three projections at cosine $\tfrac13$ give $\lVert\tfrac35\sum_aq_a\rVert^2=\tfrac95u^2$, which is exactly $t$ at the corner because $u_{\mathrm{lo}}^2=\tfrac59t$, so any other $D$ has strictly larger norm. This holds at every $n\ge6$.* **That $D$ then fails the $\mathcal D_n$ equation**: contracting $D\circ D+\sum_a\nu_a\circ\nu_a=\theta D$ with $D$ requires $P(D)=+0.172853$, while the forced $D$ gives $P(D)=-0.9\sqrt3\,u_{\mathrm{lo}}^3=-0.130190$. *Wrong sign, gap $0.303$, twenty times the deficit.*

**So the exclusion is reached twice, through $P(q_i)$ and through $P(D)$, by two readers who did not see each other's work.**

**AND NOTHING GIVES THE FLIP BACK.** *At that configuration the pinning term and the cross term sit EXACTLY at the ceilings the chain assigns them, $0.08278634$ and $0.05519090$ ([r1062](REVIEW_r1062.md), matching to eight places). Read as a demand on the coupling it needs a Rayleigh quotient of $1.1014$ against L220 step 8's cap of $0.2524$, a factor of $4.4$.*

**THE CORNER SITS IN THE $x_i<0$ REGIME THIS FILE DISMISSED, AND THAT IS A ROUTE RATHER THAN ONLY AN ERROR** ([r1063](REVIEW_r1063.md)). *The file set that regime aside because the chain is not worst there, which is a statement about the RELAXATION's argmin, and the argmin is the infeasible point.*

**THE GAIN AT THE CORNER IS $0.0192874$ AGAINST A DEFICIT OF $0.0148730$, A MARGIN OF $30\%$** ([r1062](REVIEW_r1062.md)'s halved step-8 cap, connected to the route by [r1064](REVIEW_r1064.md)). *So the successor step this file has been asking for is one it already holds, by a margin that is real and is NOT large.*

**AND THE FIGURE $0.2505$ MUST NOT BE COMPARED TO THE DEFICIT DIRECTLY, WHICH AN EARLIER VERSION OF THIS PARAGRAPH DID** ([r1064](REVIEW_r1064.md)). *It is a bare SHAPE factor $\tfrac1{\sqrt3}-\max(x,y,z)$, and [r1059](REVIEW_r1059.md) converts such factors with $u(t-u^2)$ before comparing them to anything in $F$'s units. At the corner that factor is $0.066813$, so $0.2505$ is $0.016737$, a ratio of $1.13$ rather than seventeen.* **It is also quoted at the wrong shape**: r1059's configuration has $y\ne z$ while [I110](../plan.md) forces $y=z$.

*Exact at $s_*$ alone, so it is a route with a named gap and not a closure: what is owed is that the forced shape persists off the corner, and at a $30\%$ margin that persistence has to be shown rather than assumed.*

**WHAT THIS DECIDES, IN [I110](../plan.md)'S OWN WORDS**: *excluded, and the true worst case moves to a less-pinned configuration where the Gram bound is slack, reopening [R25](../routes.md)'s far region.* **The $0.0148$ deficit stands, and the configuration carrying it is now known not to be a critical point.**

### What was claimed here before, and is withdrawn

**A section dated 2026-09-21 concluded the opposite, that the norm half said FEASIBLE and the corner sat exactly on the boundary.** *Its steps 1 to 6 are confirmed and are reproduced above. Its step 7 inferred feasibility from the equality case being ATTAINABLE IN ISOLATION, which is true, and never asked whether the same configuration also satisfies the eigenvector condition. It does not: the two conditions are compatible only at the sign that kills it.* **The lesson is the one the file keeps paying for: two conditions each satisfiable alone were treated as jointly satisfiable, and the joint question is one matrix.**


## I111 REDUCES TO A WINDOW OF WIDTH $0.0415$, AND THE CORNER IS THE WORST CASE RATHER THAN THE TYPICAL ONE, 2026-09-22

**The surviving region is $s\in(0.358719,\,0.467647]$**, the lower end being the root of $d(s)=0$ and the upper the Gram boundary $s_*$. *So $N_i$ runs over $(0.128680,\,0.218694]$.*

**THE CORNER IS WHERE THE ROUTE IS WEAKEST, NOT WHERE IT IS STRONGEST.** *With the shape forced as [I110](../plan.md) proves it there, the gain is $\big(\tfrac1{\sqrt3}-\max(x,y,z)\big)u(t-u^2)=\tfrac{1}{2\sqrt3}u(t-u^2)$, and the ratio to the deficit runs*

| $s$ | $0.3587$ | $0.4004$ | $0.4408$ | $0.4676=s_*$ |
|---|---|---|---|---|
| gain$/d$ | huge | $6.39$ | $2.37$ | $\mathbf{1.297}$ |

*so the $30\%$ margin recorded above is the MINIMUM over the region, attained at the corner.* **That is the opposite of what a route usually owes**, and it means the persistence question is not about the corner at all.

**AND THE TWO BRANCHES SPLIT THE REGION AT ONE POINT.** *On the $+$ branch the shared-pair coefficient is bounded below by [r1059](REVIEW_r1059.md)'s forcing $\sum_ix_i^2\ge(3u^2-t)/1.2$, so the gain is $\big(\tfrac1{\sqrt3}-x/u\big)u(t-u^2)$ with $x/u$ rising to exactly $\tfrac1{\sqrt3}$ at $s_*$.* **The $+$ branch gain crosses the deficit at**

$$s_c=0.4261220,\qquad N_i=0.1815799,\qquad d(s_c)=\text{gain}=0.0099563.$$

**SO THE ITEM SPLITS IN TWO, AND ONLY ONE HALF IS OPEN.**

- **$s\in(0.358719,\,s_c)$, width $0.0674$: CLOSED on the $+$ branch alone**, since the forcing's own gain already exceeds the deficit there, whichever branch the configuration is on.
- **$s\in[s_c,\,s_*]$, width $0.0415$: OPEN.** *There the $+$ branch gives less than the deficit, reaching exactly $0$ at $s_*$, so the closure needs the $-$ branch, which [I110](../plan.md) proves forced only AT $s_*$.*

**WHAT I111 OWES IS THEREFORE NARROWER THAN THE PLAN STATES IT.** *Not that the forced shape persists across the surviving region, but that it persists on a window of width $0.0415$ in $s$, one end of which is already proved.* **A screen, not a derivation**: the crossing and the ratios are computed from the closed forms above and have not been through Gate 2.

## THE FORCING HOLDS AT EVERY $s$, AND WHAT I111 ACTUALLY OWES IS THE PINNING SLACK IN $u$, 2026-09-22

**The window of the section above is the wrong frame, and this replaces it.**

**BOTH OF [I110](../plan.md)'S FORCINGS ARE IDENTITIES IN $s$, NOT FACTS ABOUT THE CORNER.** *The block equation's two sides have norms $(\theta-\sqrt3u_{\mathrm{lo}})\sqrt{N}=s\cdot s=s^2=N$ and at most $2\cdot\tfrac12\sqrt{N_jN_k}=N$, and $\theta-\sqrt3u_{\mathrm{lo}}=s$ holds for every $s$ (`coeff_at_uLo`).* **So wherever $u=u_{\mathrm{lo}}$ the product bound is saturated, $\nu_a\propto(0,1,-1)$, the pinning is tight, $\nu_a$ is $L_{q_a}$'s top eigenvector, and $q_a$ is forced to $(-2,1,1)$** by the eigenvalue computation, which is algebra in $A,B,C$ and carries no $s$. *Checked at six values across the surviving range: the two norms agree to $10^{-12}$ at every one.*

**AND WITH THAT SHAPE THE ROUTE CLOSES THROUGHOUT**: $\min_s\text{gain}/d=1.296955$, attained at $s_*$.

**WHAT IS NOT FORCED IS $u=u_{\mathrm{lo}}$ ITSELF.** *A critical point carries whatever $u$ it carries, and the chain fails on the whole sub-interval where $F(u)<0$, not only at $F$'s minimum. The forcing needs the pinning TIGHT, so it is exact at the interval's left endpoint and weakens across it.*

**THE INTERVAL'S WIDTH IS THE ITEM, AND IT DEGENERATES AT THE CORNER.**

| $s$ | $u_{\mathrm{lo}}$ | $u$ at $F=0$ | width |
|---|---|---|---|
| $0.35882$ | $0.499942$ | $0.499971$ | $0.000029$ |
| $0.40000$ | $0.476167$ | $0.487077$ | $0.010910$ |
| $0.44000$ | $0.453073$ | $0.472752$ | $0.019679$ |
| $s_*=0.46765$ | $0.437110$ | $0.437110$ | $\mathbf{0}$ |

***At $s_*$ the interval is a POINT**, since $u_{\mathrm{lo}}$, the $F=0$ root and the Gram cap coincide there, which is why [I110](../plan.md)'s forcing was exact at the corner and needed no extra argument.* **Both ends of the surviving range pinch to zero width and the middle is widest at about $0.02$.**

**SO I111 IS: does the forced shape survive the pinning slack across an interval of width at most $0.02$ in $u$?** *Not whether it persists in $s$, which is settled, and not a window in $s$, which was the wrong frame. A screen, not a derivation: the widths are root-finds on the closed forms and have not been through Gate 2.*

## THE CLAIMED CLOSURE IS WITHDRAWN: THE PIN IS THE PRODUCT BOUND RESTATED, 2026-09-22

**A section here claimed I104's $\tau>0$ case closed on the equal-$N_i$ diagonal. It does not. Gate 2 refuted it twice, independently** ([r1067](REVIEW_r1067.md), [r1068](REVIEW_r1068.md)), *and the refutation is verified here from the algebra rather than taken on their authority.*

**THE ALGEBRA WAS RIGHT AND THE CONCLUSION DID NOT FOLLOW.** *Carrying $\tau$ free instead of substituting $\tfrac12s^3$ at the first step, the cancellation survives verbatim and gives $g_a=3u_a^2-\theta^2+4\theta\tau/N_a$. The two constraints the argument played against each other are then*

$$\text{criticality: }3u_a^2\ge\Big(\theta-\frac{2\tau}{N_a}\Big)^2,\qquad\text{norm test: }3u_a^2\le\frac{N_bN_c}{N_a}+\theta^2-\frac{4\theta\tau}{N_a},$$

**and their difference is EXACTLY $\dfrac{N_aN_bN_c-4\tau^2}{N_a^2}$**, which is the product bound $\lvert\tau\rvert\le\tfrac12\sqrt{N_aN_bN_c}$ written as a width. *It vanishes if and only if $\tau$ attains that bound.* **So the pin $u=u_{\mathrm{lo}}$ is the product bound restated, and the argument proved what it had assumed.** *[r1067](REVIEW_r1067.md)'s form needs neither the equal-$N_i$ diagonal nor $\theta^2=\tfrac32$, so it is stronger than the claim it kills.*

**THE ERROR WAS FIXING $\tau$ AT ITS BOUND, AND THIS FILE HAD ALREADY DERIVED THAT IT IS NOT.** *Writing $\tau=f\cdot\tfrac12s^3$, the pinning end is $u_{\mathrm{lo}}(f)=(\theta-fs)/\sqrt3$ and $g(u_{\mathrm{lo}}(f))=f^2N$, so $g\le N$ leaves the band $u_{\mathrm{lo}}(f)^2\le u^2\le u_{\mathrm{lo}}(f)^2+\tfrac{s^2(1-f^2)}3$, which collapses to a point at $f=1$ and nowhere else.* **The section deriving $f\ge0.891690$ on the surviving set sits four sections above**, and at $f=0.8917$ the permitted $u$ exceeds the claimed pin by $0.044987$, larger than the whole window the sections before it called the item.

**WHAT SURVIVES.**

- **[I110](../plan.md)'s corner exclusion is untouched.** *At $s_*$ the Gram cap forces $f=1$, which is exactly why the corner forcing needed no extra argument. What falls is only its extension inward.*
- **The cancellation $g=\theta^2+3u^2-2\sqrt3\theta u_{\mathrm{lo}}$ is correct but is not new**: it is L220 step 5's $\lVert L_q\nu\rVert=e\lVert\nu\rVert$, and $g\le N$ is verbatim the record's vector bound, already known saturated at $f=1$.
- **The gain ratio at the corner is $1.2968015$**, not the $1.296955$ printed by a minimisation here, and this file's [I110](../plan.md) section prints $0.0192874/0.0148730=1.2968063$. *Two neighbouring sections disagreed and the minimiser was reported to more digits than it had.*
- **Two attack lines cleared**: comparing the full-space norm bound against an in-plane left side runs in the safe direction, and the block equation is sound as a vector equation, L220 step 4 giving $L_r\nu=0$ outright. *The record's prose states only the weaker pairing form, which is worth repairing.*

**SO I111 IS OPEN, WITH A SHARPER STATEMENT THAN BEFORE**: does the forced shape persist under product-bound slack $1-f$ over $f\in[0.891690,1)$? *The margin to spend is $23\%$ of the gain, the eigenvector misalignment is bounded by $\beta\le6.32^\circ$ over the surviving set, and [r1067](REVIEW_r1067.md) names two analytic routes needing no sweep.*


## I111'S SURVIVING SET, MEASURED IN $(s,f)$: BOTH ENDS PINCH TO $f=1$ BY DIFFERENT MECHANISMS, 2026-09-22

**Following [r1067](REVIEW_r1067.md)'s second route, eliminating $f$ against Gram.** *The criticality end must be Gram-feasible, $u_{\mathrm{lo}}(f)\le\sqrt{5t/9}$, which is $f\ge\big(\theta-\sqrt{5t/3}\big)/s$. The deficit must be positive, which is $d(s,f)>0$.* **Together they leave:**

| $s$ | Gram needs $f\ge$ | $d>0$ needs $f\ge$ | surviving width in $f$ |
|---|---|---|---|
| $0.35882$ | $0.594602$ | $\mathbf{0.999828}$ | $0.000172$ |
| $0.40000$ | $0.734489$ | $0.938499$ | $0.061501$ |
| $0.44000$ | $0.883823$ | $0.893602$ | $0.106398$ |
| $0.46000$ | $\mathbf{0.966465}$ | $0.875364$ | $0.033535$ |
| $s_*=0.46765$ | $\mathbf{1.000000}$ | $0.869022$ | $\mathbf{0}$ |

**BOTH ENDS OF THE SURVIVING RANGE PINCH $f$ TO $1$, AND THE TWO MECHANISMS ARE DIFFERENT.** *At the top the GRAM cap does it, which is why [I110](../plan.md)'s corner forcing needed no extra argument and is the fact that section reported as three numbers coinciding. At the bottom the DEFICIT does it, since $d>0$ barely holds there at all.* **The slack is entirely in the middle and peaks at $0.106$ near $s=0.44$.**

**AND THE MISALIGNMENT IT BUYS IS SMALL.** *Maximising $\beta$ with $\cos2\beta=u_{\mathrm{lo}}(f)/u$ over the whole surviving set gives*

$$\beta\le6.3125^\circ,\qquad\text{at }s=0.432160,\ f=0.901459,\ u=0.494133,$$

*and the maximiser sits essentially ON the Gram cap, $0.494133$ against $0.494252$.* **Reproduced independently of [r1067](REVIEW_r1067.md), which reported $6.32^\circ$.**

**SO I111 IS ONE QUANTITATIVE QUESTION**: does [I110](../plan.md)'s eigenvalue forcing, which pins $q\propto(-2,1,1)$ at $\beta=0$, degrade by less than $23\%$ of the gain when $\beta$ is allowed up to $6.3125^\circ$? *A perturbation bound on $G$'s eigenvectors in $\beta$ would settle it, which is [r1067](REVIEW_r1067.md)'s first named route and needs no sweep.* **A screen, not a derivation**: the table and the bound on $\beta$ are root-finds on closed forms and have not been through Gate 2.

**AND THE PERTURBATION ROUTE DOES EXIST. THE CLAIM THAT IT DOES NOT IS REFUTED**, by [r1069](REVIEW_r1069.md) and [r1070](REVIEW_r1070.md) on identical cold briefs, independently and on different grounds.

**THE EIGENFRAME IS THE SHAPE, WHICH IS THE WHOLE ERROR.** *The withdrawn claim read the surviving conditions as fixing $\nu_a$'s angle RELATIVE TO $L_{q_a}$'s eigenframe while saying nothing about where that frame sits.* **It is backwards.** From [L121](../findings/second-order.md)'s matrix alone, the block restricts to $e\,R(\psi)$ in the signed basis and the top eigenvector turns at HALF the shape rate, so the shape circle maps bijectively onto the circle of in-plane directions and $\delta\psi=2\,\delta\gamma$. *Both readers derived the half rate independently, [r1070](REVIEW_r1070.md) checking it against L121 at twenty-five angles and three norms to $10^{-12}$ and recovering [I110](../plan.md)'s $\psi=\pi\Rightarrow(0,1,-1)$, [r1069](REVIEW_r1069.md) to $10^{-31}$.* **So $q_a$'s shape is a FUNCTION of the angle the conditions fix, and there was never a free quantity.**

**AND THE SHARED-PAIR COEFFICIENT IS A SHAPE COORDINATE**, $x_a=\tfrac u{\sqrt3}\cos\psi_a$ ([r1070](REVIEW_r1070.md)). *So [r1059](REVIEW_r1059.md)'s forcing, which this file carries four sections above, is a constraint on the three shape angles and was available to the withdrawn claim throughout.*

**WHERE THE TWO READERS AGREE, AND WHERE THEY DO NOT.**

| claim | [r1069](REVIEW_r1069.md) | [r1070](REVIEW_r1070.md) | reconciled |
|---|---|---|---|
| M1, the surviving $(s,f)$ table | CONFIRMED, bisection at 25 digits | CONFIRMED, 40 dps, 7 digits | **CONFIRMED**, a genuine root-find |
| M2, both ends pinch $f\to1$ | CONFIRMED | CONFIRMED | **CONFIRMED** |
| M3, the $\beta$ cap | $6.3166682^\circ$, maximiser corrected | REFUTED, $5.4755^\circ$ | **$5.4755^\circ$**, see below |
| M4, the forcing is codimension one | **REFUTED** | **REFUTED** | **REFUTED** |
| M5, the cyclic vector system remains | CONFIRMED, understated | CONFIRMED, and SQUARE | **CONFIRMED** |

**THE M3 DISAGREEMENT IS TWO QUESTIONS, NOT AN ERROR.** *[r1069](REVIEW_r1069.md) maximised $\beta$ over the surviving set AS THIS FILE DEFINED IT and corrected the third digit. [r1070](REVIEW_r1070.md) imposed this file's own survival condition $F(u)<0$ as well, and found the reported maximiser sits exactly on the deficit floor with $F=+0.0074991$, so the chain already closes there and the configuration is excluded.* **The second is the right question, because a configuration the chain excludes cannot bound anything the chain still owes.** *So the cap is $\beta\le5.4755^\circ$ at $s=0.444591$, $f=0.935953$, $u=0.475521$, where the Gram cap binds, and the file's $6.3125^\circ$ was quoted at a point outside its own surviving set.*

**WHAT SURVIVES OF THE WITHDRAWN CLAIM IS ITS CONCLUSION ON ONE BRANCH.** *The gain genuinely has no positive lower bound on the $+$ branch, so [I111](../plan.md) reduces to excluding $\psi_1=\psi_2=\psi_3=0$, the unique point of $\{1,-\tfrac12\}^3$ the Gram system admits ([r1070](REVIEW_r1070.md)).* **On the $-$ branch the bound the claim declared impossible is explicit**, closing the block for $s\le0.380969$ and $s\ge0.463562$ and short by at worst $26\%$ near $s\approx0.42$. *[r1069](REVIEW_r1069.md) reaches the same shape from the other side: $h_a\ge f\ge0.891861>1/\sqrt3$ puts every $\nu_a$ within $\arccos f$ of $(0,1,-1)$, and at $\eta=0$ no partner can supply $h$ above $1/\sqrt3$, so the $+$ branch dies everywhere.* **Neither reader closes I111**, and both say so.

## I111'S $-$ BRANCH CLOSES ON THE MAXIMUM OF TWO BOUNDS THE RECORD ALREADY HELD, 2026-09-22

**Derived on Fable, screened here, and NOT yet through Gate 2.** *Full working at [the $-$ branch note](2026-09-22-I111-minus-branch.md).*

**The new step is one line and it is the whole result: both bounds hold at every surviving point, so their MAXIMUM does.** *[r1070](REVIEW_r1070.md)'s bound comes from the Gram shape pin $\Phi(c)\ge K=3-t/u^2$ and is short by $26\%$ near $s\approx0.416$. [r1069](REVIEW_r1069.md)'s comes from $\lvert\psi_a-\pi\rvert\le2\arccos f+2\beta$ with $\cos2\beta=u_{\mathrm{lo}}(f)/u$, and is short by $80\%$ near $s\approx0.446$.* **AND "NEITHER READER TOOK THE OTHER'S" IS FALSE** ([r1078](REVIEW_r1078.md)): *[r1069](REVIEW_r1069.md)'s line 45 already carries $\sum_a\cos^2\psi_a\ge\tfrac52K$, and with $\sum m^2\le3M^2$ that is exactly [r1070](REVIEW_r1070.md)'s $g_{\mathrm{Gram}}$, checked here at five values of $K$ to twelve digits.* **r1069 held BOTH bounds, so the combination sits inside one review.** *The check run was whether r1070 held r1069's bound, and never the reverse.* **What survives is the EVALUATION**, that the two together clear the deficit everywhere with margin $1.43\%$, which neither reader computed.

$$\min_{(s,f,u)}\frac{\max\big(g_{\mathrm{Gram}},\,g_{\mathrm{dir}}\big)\,u(t-u^2)}{-F(s,f,u)}=1.014293\quad\text{at }s=0.455838,\ f=0.992111,\ u=0.446191.$$

**At that point the two bounds are EQUAL to $3.9\times10^{-6}$**, $0.16163$ each, *which is what a max-of-two minimax looks like when it is real: each bound is loose exactly where the other is tight.* **Gate 1**: $F$ and the gain multiplier reproduce the corner's recorded $0.0148730342706614$ and $0.0192874$ to every digit, and the ratio there is $1.2968015$, [r1068](REVIEW_r1068.md)'s corrected figure. *A $400\times120\times120$ scan with every constraint enforced finds the same basin at $1.018045$ and no other.* **A first refinement returned $0$ and was wrong, having dropped the Gram floor on $f$.*

**SCOPE, AND IT IS THE WHOLE CAVEAT.** *This is the equal-$N_i$, equal-$u$ ansatz, which is what the $(s,f,u)$ parametrisation encodes. Both input bounds were derived on it and [post F75](../findings/fence-posts.md) scopes the invertibility to it.* **Nothing here reaches off that ansatz, and lifting it is a separate item.** *The margin is $1.43\%$.*

**AND M5 IS SHARPER THAN THIS FILE STATED IT.** *$\theta-2L_{q_a}$ is invertible throughout the surviving set, $\theta-\sqrt3u\ge0.3587$, so $\nu_a=(\theta-2L_{q_a})^{-1}(2\nu_b\circ\nu_c)$ exactly and the three directions are not free in the cycle.* **The system is SQUARE, six scalar equations in six angles**, rather than overdetermined by three as the corner section reported.

**Validation owed**: both refutations are applied here on the strength of two independent readers agreeing, and neither has been reproduced by a third route in this file. *The half-rate eigenframe map is the piece to reproduce first, since every other correction rests on it.*

## THE PINNING SUM AND $\tau$: THE IDENTITY IS [L221](../findings/second-order.md) ITEM 2 SUMMED, AND IS NOT NEW, 2026-09-22

**THE NOVELTY CLAIM BELOW IS WITHDRAWN IN FULL** ([r1072](REVIEW_r1072.md), found while this section was still being written). *[L221](../findings/second-order.md) item 2 already states the identity PER BLOCK, in the file this section cites throughout:* **"pairing the $\chi_{Q_i}$ equation with $\nu_i$ gives $\langle L_{q_i}\nu_i,\nu_i\rangle=\tfrac\theta2N_i-\tau$"**, *Gate 2 passed by [r941](REVIEW_r941.md) and [r942](REVIEW_r942.md).*  **AND IT IS NOT KERNEL-CHECKED, WHICH A FIRST VERSION OF THIS WITHDRAWAL CONCEDED** ([r1074](REVIEW_r1074.md)): *[L221Statement.lean](../lean/HamiltonsCubic/Results/L221Statement.lean) types `nu_square_norm`, `per_block`, `sum_three` and `sum_two`, and takes the pinning's CONSEQUENCE as a hypothesis.* **The identity is Gate-2-passed prose.** *Conceding more than the evidence supports leaves the record weaker than the truth, which is the same defect as an overclaim pointing the other way.*

**SO THE BOXED IDENTITY BELOW IS THAT ONE SUMMED OVER THE THREE BLOCKS, AND IS STRICTLY WEAKER THAN WHAT THE RECORD ALREADY HELD.** *And the "closed form" $g_a=\tfrac12N(\theta-fs)$ is the same statement with $\tau=\tfrac12fs^3$ and $N=s^2$ substituted.* **What remains genuinely absent from the record is smaller**: the two named collapses $a=\sum_ag_a$ and $P(N)=6\tau$, the redundancy of the $\mathcal D_n$ shadow recorded as [post F75](../findings/fence-posts.md), and the Lean typing.

**THE RULE THIS BROKE IS THE ONE WRITTEN FOR EXACTLY IT.** *The loop requires grepping the DESTINATION file for the statement before deriving it. This section's destination cites [L221](../findings/second-order.md) on nearly every page, and the identity sits in that lemma's item 2.* **The grep that was run searched for `fully symmetric` and `trilinear`, the vocabulary of the ARGUMENT, rather than for the pinning term, the OBJECT.** *That is the difference the rule names, and searching by vocabulary is what it forbids.*

## The derivation as written, retained for its collapses and its Lean, 2026-09-22

**This is a SPECIALISATION of a relation the record already carries, not a new one.** *[second-order.md](../findings/second-order.md)'s $(D,N)$ pair gives $\theta t=P(D)+a$ and $\theta(1-t)=2a+P(N)$ with $a=\langle D\circ N,N\rangle$, both proved there from total symmetry of $T$ alone. What is new is what those two quantities ARE once $N=\nu_1+\nu_2+\nu_3$ is split by character.*

**Both collapse, and the collapse is the content.** With $g_a:=\langle L_{q_a}\nu_a,\nu_a\rangle$ the block pinning terms and $\tau=T(\nu_1,\nu_2,\nu_3)$:

$$a=\sum_a g_a,\qquad P(N)=6\tau.$$

*Each is three lines of character orthogonality. $\nu_a\circ\nu_b\in V_{Q_c}$ is orthogonal to $\mathcal D_n$, which kills every cross term in $a$ and leaves $\sum_aT(D,\nu_a,\nu_a)$, then [L220 step 4](../findings/second-order.md) reads $T(D,\nu_a,\nu_a)$ as $g_a$. In $P(N)$, $\nu_a\circ\nu_a$ lands in the TRIVIAL character component and is orthogonal to every $\nu_b$, so the equal-index and twice-repeated terms all vanish and the six distinct-index terms are each $\tau$.*

**So the second relation is an EQUALITY between the two quantities the chain bounds separately:**

$$\boxed{\ \sum_a g_a\ +\ 3\tau\ =\ \tfrac12\,\theta\,(1-t)\ }$$

**THE CHAIN'S STEP 7 CEILING ON THE PINNING AND ITS STEP 8 CEILING ON THE CROSS TERM ARE THEREFORE TIED.** *Raising $\tau$ by $\delta$ lowers $\sum_ag_a$ by exactly $3\delta$, so a configuration cannot sit at both ceilings unless the ceilings happen to satisfy this line.*

**AND THE LINE YIELDS NO NEW EXCLUSION, BECAUSE ITS FEASIBILITY CONDITION IS THE PINNING CONSTRAINT ITSELF.** *On the equal-$N_i$ diagonal the identity gives the pinning term in closed form,*

$$g_a=\tfrac12N(\theta-fs)=\tfrac{\sqrt3}2\,N\,u_{\mathrm{lo}}(f),$$

*reproducing [r1062](REVIEW_r1062.md)'s $0.08278634$ at the corner.* **Testing it against step 7's ceiling $g_a\le\tfrac{\sqrt3}2uN$ gives $u\ge u_{\mathrm{lo}}(f)$ EXACTLY**, which is the pinning constraint the $(s,f)$ surviving set was already measured with. *Checked at four points of the window, agreeing to machine precision.* **So a first version of this section, claiming the surviving set had been measured without it, is WITHDRAWN.**

**WHAT THE IDENTITY DOES BUY, STATED WITHOUT THE OVERCLAIM.** *The closed form $g_a=\tfrac12N(\theta-fs)$, which the file did not carry; the reason the chain's two ceilings are linked rather than independent, which no per-step check can see; and $P(D)$ as a function of $(s,f)$ alone.* **Off the equal-$N_i$ diagonal the identity constrains only the SUM, so it is strictly WEAKER there than three per-block pinning bounds**, and a route reaching outside that diagonal gains nothing from it.

**And the first relation then gives $P(D)$ in closed form**, with no reference to $D$'s shape:

$$P(D)=\tfrac32\theta t-\tfrac12\theta+3\tau.$$

**THIS HALF IS CORROBORATION, NOT DISCOVERY.** *[r1069](REVIEW_r1069.md) reached it independently and in the same hours, as $P(D)=\theta t-\tfrac{3\theta}2N+3\tau$, reporting it reproduces [r1063](REVIEW_r1063.md)'s corner figures to eight places.* **The two are the SAME relation**: on the equal-$N_i$ diagonal $t=1-3N$, and both sides collapse to $\theta-\tfrac92\theta N+3\tau$, agreeing to sixteen digits when evaluated. *The form above is the one stated at general $t$, so it survives off that diagonal, which is where [I111](../plan.md) has to work.*

**Screened at the corner, where every figure is recorded independently.** *At $s_*=(\sqrt6+\sqrt{10})/12$ with $\tau=\tfrac12s_*^3$: the identity gives $g_a=0.082786343$, against [r1062](REVIEW_r1062.md)'s pinning ceiling $0.08278634$, every recorded digit; and $P(D)=0.17285284$, against the $+0.172853$ the $\mathcal D_n$ equation was reported to require. **Two numbers reached by different readers through different quantities, both reproduced from one line.***

**A COROLLARY, AND IT IS WEAK HERE.** *[L24](../findings/second-order.md) gives $a\ge\tfrac\theta2t(1-t)$, so $6\tau=\theta(1-t)-2a\le\theta(1-t)^2$, an upper bound on $\tau$ owing nothing to the product bound.* **On the equal-$N_i$ diagonal it is $\tau\le\tfrac32\theta s^4$ against the product bound's $\tfrac12s^3$, and the ratio $3\theta s$ exceeds $1$ for $s>0.2722$**, so throughout the surviving region $s\in(0.3587,0.4676]$ the product bound is the binding one and this corollary says nothing. *Recorded because it is an independent route to the same quantity and fixes where each bound wins.*

**WHAT THIS CHANGES FOR [I111](../plan.md).** *The item asks whether [I110](../plan.md)'s forced shape persists off $s_*$. The trade-off says the question can be asked without the shape at all: the chain's deficit is the amount by which $\sum_ag_a$ and $\tau$ fail to be CO-MAXIMISABLE, and that failure is now an exact line rather than two separate estimates.* **Gate 2 is owed on this section before it is cited.**

## Off the ansatz: invertibility holds at every surviving block, and the lift is a certificate, 2026-09-26

**[Post F75](../findings/fence-posts.md)'s scope caveat on invertibility is removed.** *At $\theta^2=\tfrac32$, a block with $\sqrt3u_a\ge\theta$ has chain slack $F_a(u_a)>0$ and is excluded, with no equal-$N_i$ or equal-$u$ hypothesis* (`surviving_block_invertible`, [I111Invertible.lean](../lean/HamiltonsCubic/Results/I111Invertible.lean)). **Proof.** If $N_a>\tfrac12$ then $u_a^2\le t=1-N<\tfrac12=\theta^2/3$. Otherwise write $m=\sqrt3\,\theta$, $m^2=\tfrac92$, $u_0=m/3=\theta/\sqrt3$ and $c=t+\tfrac{N-N_a}2\le1$. Then $2\sqrt3F_a(u)=E(u)+2\sqrt3\tau$ with $E(u)=2mu^2-u^3-2cu-mN_a$, and
$$E(u)=\tfrac m6\,(1+2N-4N_a)+(u-u_0)\big(2m(u+u_0)-(u^2+uu_0+u_0^2)-2c\big).$$
*The first term is at least $\tfrac m6(1-2N_a)\ge0$. On $u_0\le u\le1$ the bracket is at least $4mu_0-3-2=1$, so $E(u)\ge0$ and $F_a(u)\ge\tau>0$, where $u\le1$ because $u_a\le\sqrt t\le1$.* $\square$ *So every block in the chain's surviving set $F_a(u_a)\le0$ has $\sqrt3u_a<\theta$, strictly, at $\theta^2=\tfrac32$ and $\tau>0$; the expanded slack $-N_a\theta/2+\tau$ is the form used, and $\tau>0$ makes every $\nu_a$ nonzero. Gate 2: [r1208](REVIEW_r1208.md), [r1209](REVIEW_r1209.md), CONFIRMED, with the Lean hypothesis widened from $F<0$ to $F\le0$ and the constant corrected from $\tau/\sqrt3$ to $\tau$ on their findings.* *The Gram bound alone permits $u_a$ up to $\sqrt{5t/3}$, which is what F75 measured. Once the chain has run, no block survives there.*

**The lift of the gain bounds is a certificate, and I111's `analytic` factor is $0$.** *The $-$ branch closure on the ansatz is the numerical minimum $1.014293$ of a transcendental ratio over three dimensions ([I111MinusBranch.lean](../lean/HamiltonsCubic/Results/I111MinusBranch.lean) types only its monotone pieces and says the minimax needs interval arithmetic).* **Off the ansatz the same ratio is a minimax over $(N_1,N_2,N_3,f,u_1,u_2,u_3)$ with the Gram pin in its weighted form** $\tfrac3{10}\big(\sum_au_ac_a\big)^2-\tfrac12\sum_au_a^2c_a^2\ge\sum_au_a^2-t$, $c_a=\cos\psi_a$, **across a wider surviving set**: a scalar-chain screen ([screen_I111_offansatz.py](../scripts/misc/screen_I111_offansatz.py)) finds survivors with $N_a\in[0.14,0.28]$, ratios $N_3/N_1$ up to $1.8$ and $f\in[0.90,0.98]$, where the ansatz window had $N\le0.219$. *At a $1.43\%$ margin on the diagonal, the closure off it would be a seven-dimensional numerical minimax, which is a machine certificate and not a proof a reader holds.*
