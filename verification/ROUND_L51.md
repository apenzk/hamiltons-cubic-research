# ROUND_L51, the variation calculus is an identity along a critical orbit

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `GAP`, repaired, impact `CONTAINED`. **Verifiers:** v194, v195, v196.

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md) lines 743–750 |
| Landscape statement | [results.md](../results.md) line 246 |
| The block | [second-order.md](../findings/second-order.md) lines 185–202 |
| A third copy | [fence-posts.md](../findings/fence-posts.md) line 307 |
| Brief | [BRIEF_L51.md](BRIEF_L51.md) |

## Findings from phase 0

**1. The two statements disagree on whether positivity is needed.** [results.md](../results.md) says *"**where $B\vert_{W^\perp}\succeq0$** the fourth-order supremum over correctors equals $0$ exactly"*, conditional. The block says the fourth-order value at the stationary corrector is $\langle b,B^+b\rangle=\theta/2$ *"giving $0$ exactly"* and that **"the equality needs no positivity either"**, positivity licensing *"only the word **supremum**"*. **One conditions the result on a hypothesis the other says it does not need.**

**2. The refuted guard survives in a third copy.** The bare $B\succeq0$ **names the empty set** ($BW=-\tfrac\theta2W$ at every $\theta>0$, so $B$ is never positive semidefinite) and must read $B\vert_{W^\perp}\succeq0$. *[r287](../reviews/REVIEW_r287.md) wrote it correctly and the write-up lost it into four copies.* **Eight sites now carry the guard and [fence-posts.md](../findings/fence-posts.md) line 307 still carries the bare form**, in a live clause: *"so where $B\succeq0$ the fourth-order supremum equals $0$."*

## What the verifiers are asked beyond the standing list

Whether $2L_Wz=\theta z$ and $Bu=z\circ z$ follow from differentiating $Q(e^{tX}\!\cdot\!W)=\theta\,e^{tX}\!\cdot\!W$ once and twice; whether the fusion rule $\langle z\circ z,y\rangle=0$ for $y\in\ker B$ needs anything beyond self-adjointness of $B$; whether the exact jet's $[t^3]$ and $[t^4]$ coefficients are right; **whether the fourth-order equality genuinely needs no positivity**, resting on $B(\Pi u)=b$, on $b\perp\ker B$, and on $[t^4]=0$ along the orbit since $P$ is constant there; and whether the counterexample $P(x,y)=x^3+\tfrac32xy^2+\alpha y^3$ at $(1,0)$ does show $B\vert_{W^\perp}\succeq0$ strictly weaker than local maximality at $\alpha\ne0$.

**And the standing question for a result stated in two strengths**: which one a consumer may cite.

## Clustering, all three in, agreeing on every step

**`PROVEN, hypotheses corrected`, and the dispute is settled constructively.**

### The block's reading wins, with a witness

**The fourth-order equality needs no positivity**; $Bert_{W^\perp}\succeq0$ licenses only the word *supremum*. *The value derivation uses only the second identity, $BW=-\tfrac\theta2W$, self-adjointness, skewness of $X$, and $P$ constant on the orbit, it never touches the spectrum's sign.* **Concavity IS positivity, so without it $\sup F=+\infty$ while $F(\Pi u)=0$ is untouched.**

**And a positive witness settles it**: $P=x_3(x_1^2+x_2^2)+2x_4^2x_3$ on $\mathbb R^4$ has $Be_4=-\tfrac1{3\sqrt3}e_4$, so $B\vert_{W^\perp}\not\succeq0$ and $W$ is no local maximum, **yet every L51 conclusion holds verbatim.**

| id | finding | support |
|---|---|---|
| **S1**, **A MISSING NORMALISATION IN TWO DISPLAYS** | the $[t^4]$ constant is $-\tfrac{3\theta}8\lVert z\rVert^4$ and not $-\tfrac{3\theta}8$, *the stated form not being homogeneous*, **at $z=0$, an isotropy direction, the printed form returns $-\tfrac{3\theta}8$ for a constant curve**; and $\langle b,B^+b\rangle=\tfrac\theta2\lVert z\rVert^4$, not $\tfrac\theta2$. **Closed-form witness**: $P(x)=x_3(x_1^2+x_2^2)$ on $\mathbb R^3$ with $SO(2)$ on $(e_1,e_2)$ gives $\tfrac4{27\sqrt3}$ against the recorded $\tfrac1{3\sqrt3}$, *differing by exactly $\lVert z\rVert^4=\tfrac49$.* **It is a hypothesis correction rather than a value error**, this file already normalising "for every unit $z$" elsewhere and already writing $-\tfrac38\theta\lVert z\rVert^4$ at another line | v195 |
| **S2** | *"concave on $W^\perp$"* is asserted flat **two lines after the Statement disclaims positivity**; and *"because $P$ is constant along the orbit"* skips a real step, the chordal ray and the orbit ray part at order $t^3$ | v195 |
| **S3** | the bare $B\succeq0$ at [fence-posts.md](../findings/fence-posts.md) **names the empty set, so a live fence post asserts nothing**; *"$u$ is the stationary point"* should read $\Pi u$, and *"concave"* there precedes its own guard | v194, v195 |
| **S4**, **AND IT IS WRONG TWICE** | **[conventions.md](../findings/conventions.md) contradicts itself inside one cell**: *"$b:=z\circ z$"* against *"$B(\Pi u)=b$"*. **Under the tabled $b$ the recorded value is $0$ at every critical orbit**, $B^+W=-\tfrac2\theta W$ cancelling the radial part exactly. *The true statement is $\langle\Pi b,B^+\Pi b\rangle=\tfrac\theta2\lVert z\rVert^4$, and the record's own consumer already uses $b=\Pi(z\circ z)$*, **and the same cell's $B(\Pi u)=b$ should read $B(\Pi u)=\Pi b$** | v194, v195 |
| **S5** | **$\theta>0$ is stated and not consumed**, only $\theta\ne0$ is spent, once, for $A(\tfrac12)=\ker B$; **compactness likewise**, only *"Lie group acting orthogonally"* being used. *Unstated and used: $\lVert z\rVert=1$, $X$ skew twice, and finite-dimensionality for $B^+$* | v195 |
| **S6** | *"Krasnov–Tkachev applies verbatim"* is an **over-claim**, contradicted by this record's own [fence-posts.md](../findings/fence-posts.md) (no unit) and by KT's *extremal* meaning maximiser. **Load-bearing for nothing**: the Argument imports no line of it | v195 |

**The two statements do not contradict.** *[results.md](../results.md)'s conditional is true and under-strength, and **its guard is non-vacuous**, four points in [second-order.md](../findings/second-order.md)'s own table satisfy it.* So the repair is to state the unconditional equality and keep the supremum clause under its guard.

**Cleared, and one hypothesis found doing nothing.** Both identities rebuilt from equivariance; the fusion rule needs $Bu=z\circ z$ and self-adjointness and nothing more; **orthogonality does two load-bearing jobs** (invariance of $P$ giving equivariance of $Q$, and $X$ skew), **while compactness does none**. $\theta>0$ is consumed **only as $\theta\ne0$**, in three places, the sign being a normalisation. *The counterexample verifies: $\theta=1$, $B\vert_{W^\perp}=0$, $P\vert_{S^1}=1+\alpha\sigma^3+O(\sigma^4)$.* **And the Krasnov–Tkachev unitality trap is moot, L51 imports no theorem at all.**

## Adjudication

**Verdict `GAP`, repaired. Impact `CONTAINED`.** Two verifiers said `PROVEN, hypotheses corrected` and one `GAP`; **the `GAP` is right**, because the conclusion the block leans on has **no argument on file** and the route it names does not supply one.

### The gap, and why the obvious escape does not work

The fourth-order value at the stationary corrector is $\tfrac34\langle Bu,u\rangle$, so *"$[t^4]=0$"* is exactly **$\langle Bu,u\rangle=0$, a third orbit identity, not implied by $Bu=z\circ z$ and self-adjointness together.** *And the appeal to "$P$ is constant along the orbit" does not close it*: the parabolic curve is only the $2$-jet of the orbit and differs from it at $O(t^3)$, **which contaminates $[t^4]$ at the same order.** Two short routes would work, the fourth derivative of $P$ along the orbit, or $D^2g(W)z=0$, **and neither is written.**

*One verifier offered the constant-on-the-orbit route as complete and this round wrote it into the block on that basis; the third verifier's report showed why it is not, and the block now says so.* **A repair made mid-round and corrected inside the same round.**

**CLOSED 2026-09-17, and this paragraph is kept as the record of what was believed then.** *The gap it names is filled: $\langle Bu,u\rangle=0$ follows from the infinitesimal invariance of $T$ evaluated at $(z,z,z)$, using no criticality, no fourth derivative and no skew-adjointness, and the caution above is side-stepped rather than met, since that argument differentiates no curve.* **The current statement, its scope and its Lean file are at [L51](../findings/second-order.md)'s own block**; Gate 2 passed on [r984](../reviews/REVIEW_r984.md) and [r985](../reviews/REVIEW_r985.md). *Recorded here so a later round does not reopen it from this page.*

### The dispute settled, with two witnesses

**The block's reading wins**: the equality needs no positivity, which licenses only the word *supremum*, without it $f(\Pi u+sw_0)\to+\infty$ while $f(\Pi u)=0$ is untouched. **[results.md](../results.md)'s conditional is true, strictly weaker, and its guard is non-vacuous**, so it is brought to the block's form rather than deleted.

**And the missing $\lVert z\rVert^4$ has a hard witness.** On $\mathrm{Sym}_0(3)$ with $P=\mathop{\mathrm{tr}}A^3$ and $SO(3)$ acting by conjugation, at $W=\tfrac1{\sqrt6}\mathop{\mathrm{diag}}(2,-1,-1)$ and $X=E_{12}-E_{21}$: **the printed display returns $[t^4]=\sqrt6/2>0$ on an orbit along which $P$ is constant.** The normalised one returns $0$.

### The repairs, all applied

| finding | what changed |
|---|---|
| S1 | $\lVert z\rVert^4$ into both displays, with the isotropy case and the $\mathrm{Sym}_0(3)$ witness recorded |
| S4 | [conventions.md](../findings/conventions.md)'s cell now reads $b:=\Pi(z\circ z)$ throughout, **with what the unprojected reading did, collapsing the headline value to $0$, so the record asserted $0=\theta/2$** |
| S3 | [fence-posts.md](../findings/fence-posts.md) carries $\Pi u$, the restricted guard, and the note that the bare form named the empty set, *the one place the **sign** of $\theta$ is consumed anywhere in this calculus* |
| the dispute | [results.md](../results.md) states the unconditional equality and keeps the supremum under its guard |
| S5 | compactness recorded as unused, $\theta>0$ as spent only through $\theta\ne0$, and $X$ skew and finite-dimensionality named as used-but-unstated |
| S6 | *"Krasnov–Tkachev applies verbatim"* scoped, **this lemma imports no theorem**, and the claim contradicts the record's own non-unitality fence |
| the gap | stated in the block, with both unwritten routes named |

### Queued to [plan.md](../plan.md)

**I53, $\langle Bu,u\rangle=0$ along a critical orbit.** *One identity, two candidate routes, neither written; it is the last step of L51's fourth-order clause and of every consumer that quotes "giving $0$ exactly".*
