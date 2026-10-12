# Gate 2 brief: is L220 step 8's coupling bound attained, and is the refinement vacuous?

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note this block was drawn from and do not import the script under review.

**One reviewer, not two, and deliberately.** This round compares a computed supremum against a bound the record already states. There is no argument being made, only a constant to check and one vacuity claim, so a second reader would perform the same comparison and report it in different words.

## The setting, quoted verbatim from the record, and NOT restated

*Lemma L220's step 8, in full, as the findings file carries it. The block under review adds nothing to this statement and only asks whether its bound is attained.*

> 8. **The coupling.** For unit $\hat q=(x,y,z)$ and $r\perp\Pi_Q$, split $r$ into its $Q$-internal entries $p,p',a',b',c',d'$ on the pairs $ij,kl,ik,jl,il,jk$, its columns $c_m=(r_{am})_{a\in Q}$ for $m\notin Q$, and the rest. Then $2\langle L_{\hat q}r,r\rangle=2[x(p^2+p'^2)+y(a'^2+b'^2)+z(c'^2+d'^2)]+2\Sigma+\sum_mc_m^{\mathsf T}\hat qc_m$ with $\Sigma=z(p+p')(a'+b')+y(p+p')(c'+d')+x(a'+b')(c'+d')$, the entries outside $Q$'s rows not entering. Orthogonality to $\Pi_Q$ is $p+p'=a'+b'=c'+d'=:s$, so $\Sigma=s^2(x+y+z)=0$, and $\hat q$ has spectrum $\{0,2x,2y,2z\}$ on $\mathbb R^Q$. So $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2\le\tfrac1{\sqrt3}\lVert q\rVert\lVert r\rVert^2=\tfrac\theta3\lVert r\rVert^2$.

**Given, and not under review.** $\Pi_Q$ is the plane of sectional matrices supported on the four-set $Q=\{i,j,k,l\}$, with $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$ and $x+y+z=0$, unit when $2(x^2+y^2+z^2)=1$. $\mathcal D_n$ is the space of symmetric hollow zero-row-sum matrices, of dimension $n(n-3)/2$. The norm is $\lVert w\rVert^2=\sum_{a<b}w_{ab}^2$.

**Given, why this is being asked.** [I104](../plan.md)'s chain is short by $0.02$ at moderate block masses, and its working note recorded step 8 as carrying a shape-independent loss, namely that the bound assigns ALL of $\lVert r\rVert^2$ to the top coefficient while $r$ carries components the top coefficient does not see.

## The block under review, quoted verbatim from disk

> **The supremum equals the bound.** Over $\mathcal D_n\ominus\Pi_Q$, of dimension $18$ at $n=8$, $\sup_r\langle L_{\hat q}r,r\rangle/\lVert r\rVert^2=\max(x,y,z)$ to twelve digits, at the $S^2\times S^2$ shape and at three others. **So step 8 is ATTAINED and its own slack is zero.**
>
> **A refinement of this parent's, derived and then killed by its own vacuity check.** $\hat q$ annihilates $\mathbf 1_Q$, the sectional matrix on $Q$ having row sums $x+y+z=0$, so the sharper bound keeps only the part orthogonal to $\mathbf 1_Q$, discarding $2\max(x,y,z)\sum_m\langle c_m,\mathbf 1_Q\rangle^2/4$ with $\langle c_m,\mathbf 1_Q\rangle=\sum_{a\in Q}D_{am}$. *It is valid and strictly better pointwise, unviolated over $20000$ draws.* **And it is VACUOUS where it would have to act**: at $n=8$ a unit $r$ meeting every condition with all those components zero exists on a $14$-dimensional subspace of the $20$-dimensional $\mathcal D_n$.
>
> **What this leaves, stated narrowly.** The screen imposes only $r\in\mathcal D_n$ and $r\perp\Pi_Q$. **In I104 the residual $r_i=D-q_i$ carries the other two patterns' components, which is a further constraint**, so any gain must live in that extra structure. *This is a localisation and not a closure.*

## The claims to attack

| # | claim | kind |
|---|---|---|
| 1 | $\hat q$ has spectrum $\{0,2x,2y,2z\}$ on $\mathbb R^Q$ and $\mathbf 1_Q$ spans its kernel | mathematics |
| 2 | $\sup_r\langle L_{\hat q}r,r\rangle/\lVert r\rVert^2$ over $\mathcal D_n\ominus\Pi_Q$ equals $\max(x,y,z)$ | mathematics |
| 3 | Hence step 8's bound is ATTAINED and carries no slack of its own | mathematics |
| 4 | The $\mathbf 1_Q$ refinement is valid and strictly better pointwise | mathematics |
| 5 | It is vacuous where it must act, a unit $r$ with all $\langle c_m,\mathbf 1_Q\rangle=0$ existing on a $14$ of $20$ dimensional subspace at $n=8$ | mathematics |
| 6 | So any gain must live in I104's extra constraint on $r_i$, and this is a localisation not a closure | about a route |

## The Lean declarations, one row per claim

| # | Lean |
|---|---|
| 1 | none: $\mathcal D_n$, the sectional plane and the operator $L_{\hat q}$ are not objects in the base layer, which carries matrices and no $\circ$-algebra on $\mathcal D_n$. *The analogous zero-diagonal spectrum fact IS typed for a different map, as `dphi_diag_eq_zero` in [I106bSingularLocus.lean](../lean/HamiltonsCubic/Results/I106bSingularLocus.lean), and is not this statement* |
| 2 | none: a supremum of a Rayleigh quotient over a subspace, which needs an eigenvalue object the layer does not have |
| 3 | none: it is claim 2 restated against the recorded bound, and the bound itself is prose in [second-order.md](../findings/second-order.md) rather than a declaration |
| 4 | none: an inequality between two bounds on an untyped quantity |
| 5 | none: a dimension count of a solution space, and rank is not typed in this layer |
| 6 | none: a claim about where a route's remaining gain can live, which is not a proposition |

## What to do

1. **Claim 2 is the whole round and you should compute it independently**, building $\mathcal D_n$ and the form from their definitions rather than from the block's code. Report the supremum at the $S^2\times S^2$ shape and at shapes of your own choosing, and say whether it equals $\max(x,y,z)$ or falls short.
2. **Claim 1 is checkable by hand** and is what makes the refinement possible at all. Confirm the spectrum and the kernel, and say whether the kernel is exactly $\mathbf 1_Q$ or larger at special shapes, for instance where two of $x,y,z$ coincide.
3. **Claim 3 is an inference from claim 2 and it hides a quantifier.** Attained over WHICH set? The block says $\mathcal D_n\ominus\Pi_Q$. Say whether that is the set step 8 actually quantifies over, and whether "the entries outside $Q$'s rows not entering" changes it.
4. **Claim 5 is the vacuity check and the block's own conclusion rests on it.** Verify the dimension count, and say whether the surviving subspace contains an $r$ that is admissible for I104 rather than merely for L220.
5. **Claim 6 asks what a localisation is entitled to.** The block says the gain must live in I104's extra constraint. Is that exhaustive, or could the gain live somewhere neither the block nor this brief has named?
6. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 3 in particular: a bound attained on a set larger than the one the lemma uses is not the same as a bound attained where the lemma applies it.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, and any run finishing in a few minutes on objects already in hand.

**A control is an assertion, never a printed expectation.**

**Report.** Write `reviews/REVIEW_r<N>.md`, skeleton in your first phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`. **Never amend.** **Do not write to [reviews/INDEX.md](INDEX.md).**

**Log** to `agent_logs/<task-name>.log`: PID and phase plan on the first line, a line per phase, a heartbeat at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
