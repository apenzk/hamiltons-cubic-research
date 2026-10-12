# REVIEW_r980: L220 step 8, is the coupling bound attained and is the refinement vacuous

Reviewer r980, sole reviewer of this round, working from [BRIEF_I104_step8.md](BRIEF_I104_step8.md) and the mathematics alone. The working note the block was drawn from was not read and the script under review was not imported. The quadratic form was rebuilt from the displayed identity for $2\langle L_{\hat q}r,r\rangle$ that the brief quotes from the record.

**Sole-reviewer caveat.** Every verdict below is r980's claim rather than a verdict backed by a second reader. The section [Where a second pair of eyes is owed](#where-a-second-pair-of-eyes-is-owed) names the three places where that matters.

## Verdicts

| # | claim | verdict |
|---|---|---|
| 1 | spectrum $\{0,2x,2y,2z\}$, kernel $\mathbf 1_Q$ | CONFIRMED, with a correction to when the kernel grows |
| 2 | $\sup_r\langle L_{\hat q}r,r\rangle/\lVert r\rVert^2=\max(x,y,z)$ | CONFIRMED, and stronger than stated |
| 3 | step 8's bound is attained, its own slack zero | PLAUSIBLE for the first link, REFUTED for the chain |
| 4 | the $\mathbf 1_Q$ refinement is valid and strictly better pointwise | PLAUSIBLE, valid but "strictly" is false and the constant is ambiguous |
| 5 | vacuous, the surviving subspace is $14$ of $20$ at $n=8$ | CONFIRMED, and provable rather than observed |
| 6 | any gain must live in I104's extra constraint, a localisation | PLAUSIBLE, the localisation is not exhaustive |

## Claim 1, the spectrum and the kernel: CONFIRMED

The proof is two lines and needs no computation. On $Q$ let $P_1,P_2,P_3$ be the permutation matrices of the three perfect matchings $\{ij,kl\}$, $\{ik,jl\}$, $\{il,jk\}$. They are the three non-identity elements of a Klein four-group, so they commute and are simultaneously diagonalised by its four characters, each sending $P_1,P_2,P_3$ to $\pm1$ with an even number of minus signs. Since $\hat q=xP_1+yP_2+zP_3$, the eigenvalues are $x+y+z$, $x-y-z$, $-x+y-z$, $-x-y+z$, which under $x+y+z=0$ are $0,2x,2y,2z$.

The trivial character gives the eigenvector $\mathbf 1_Q$, and the other three give $(1,1,-1,-1)$, $(1,-1,1,-1)$, $(1,-1,-1,1)$ for $2x$, $2y$, $2z$ respectively.

**The correction.** The brief asks whether the kernel is larger "at special shapes, for instance where two of $x,y,z$ coincide". It is not. Two coinciding coefficients, say $y=z$ and therefore $x=-2y$, give a repeated eigenvalue $2y$ but a kernel that is still exactly $\mathrm{span}(\mathbf 1_Q)$. The kernel grows to two dimensions exactly when one of $x,y,z$ **vanishes**, which under $x+y+z=0$ forces the other two to be $\pm$ one another, the shape $(1,-1,0)$ up to scale and relabelling. This matters for the refinement of claim 4, because at that shape $\hat q$ annihilates a second direction that the $\mathbf 1_Q$ refinement does not exploit, and the refinement is still vacuous there (checked below).

## Claim 2, the supremum: CONFIRMED, and stronger than the block states

**By hand, an exact maximiser at every shape.** Relabel so $x=\max(x,y,z)$, which is positive because $x+y+z=0$ and the shape is unit. Let $v=(1,1,-1,-1)$, the $2x$-eigenvector, and note $\langle v,\mathbf 1_Q\rangle=0$. Take $r$ supported entirely on the $Q$-to-outside entries, with $c_5=v$, $c_6=-v$ and every other $c_m$ zero, and with the $Q$-internal block and the $Q^c$ block both zero. Then $r$ is symmetric, hollow, and has zero row sums: rows in $Q$ sum to $v_a(1-1)=0$ and rows outside $Q$ sum to $\pm\langle v,\mathbf 1_Q\rangle=0$. It is orthogonal to $\Pi_Q$ because its $Q$-internal block vanishes. The form reduces to $\tfrac12\sum_m c_m^{\mathsf T}\hat qc_m=\tfrac12\cdot2x(\lVert v\rVert^2+\lVert v\rVert^2)=8x$ against $\lVert r\rVert^2=8$, so the quotient is exactly $x$.

So the supremum is **attained**, it is a maximum rather than a limit, and it is attained at **every** shape, not at the $S^2\times S^2$ shape and three others. The block's "to twelve digits, at the $S^2\times S^2$ shape and at three others" understates its own result by reporting a sample where a universal statement holds.

**Independently computed, as the brief directs.** I built $\mathcal D_8$ as the null space of the eight row-sum functionals in the $28$ edge coordinates, checked $\dim=20=n(n-3)/2$, removed $\Pi_Q$ to get the $18$-dimensional subspace, assembled the form matrix directly from the quoted identity with $\Sigma$ **carried explicitly and never pre-set to zero**, and took the top eigenvalue of the Rayleigh quotient in an orthonormal basis.

| shape $(x,y,z)$, unit | $\sup\langle L_{\hat q}r,r\rangle/\lVert r\rVert^2$ | $\max(x,y,z)$ |
|---|---|---|
| $(2,-1,-1)$ normalised | $0.577350269190$ | $0.577350269190$ |
| $(-2,1,1)$ normalised | $0.288675134595$ | $0.288675134595$ |
| $(1,-1,0)$ normalised | $0.500000000000$ | $0.500000000000$ |
| $(3,-1,-2)$ normalised | $0.566946709514$ | $0.566946709514$ |
| $(1,-0.3,-0.7)$ normalised | $0.562543950463$ | $0.562543950463$ |
| $(1,1,-2)$ normalised | $0.288675134595$ | $0.288675134595$ |

Over those shapes plus $400$ random ones the worst discrepancy was $1.3\times10^{-15}$. The controls are assertions in the script and all held: the basis is orthonormal, the top eigenvector's Rayleigh quotient reproduces the eigenvalue, each shape is unit, and $\Sigma$ vanishes on the subspace because the three partial sums $p+p'$, $a'+b'$, $c'+d'$ agree there to $10^{-16}$.

## Claim 3, "attained, with no slack of its own": PLAUSIBLE for the first link, REFUTED for the chain

**The quantifier runs the safe way, contrary to the brief's worry.** The brief warns that a bound attained on a set larger than the one the lemma uses proves nothing. Here it is the reverse. Step 8's derivation of $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2$ uses only $r\perp\Pi_Q$, since that alone is what makes $\Sigma=s^2(x+y+z)=0$. Hollowness and the zero row sums are never invoked. So step 8's own quantifier is over $\{r\perp\Pi_Q\}$, and $\mathcal D_n\ominus\Pi_Q$ is a **subset** of it. Attainment on the subset is the stronger statement and implies attainment on the superset. The block's set is the right one to have used.

"The entries outside $Q$'s rows not entering" does not change the set. It makes the form degenerate on the $Q^c\times Q^c$ block, which adds to $\lVert r\rVert^2$ and nothing to the numerator. That is a property of the form, not a restriction on the domain, and it is what drives claim 5.

**Where the claim fails.** Step 8 is a chain of two inequalities, and the block audits only the first:

1. $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2$, which claim 2 shows is sharp at every shape.
2. $\max(x,y,z)\le\tfrac1{\sqrt3}$, hence $\kappa\le\tfrac\theta3\lVert r\rVert^2$.

The second link is an equality only at the three relabellings of $(2,-1,-1)$ normalised. Everywhere else it is strictly slack, and by an amount of exactly the order I104 is short: $0.0104$ at $(3,-1,-2)$, $0.0148$ at $(1,-0.3,-0.7)$, and $0.0774$ at $(1,-1,0)$, in units of $\lVert q\rVert\lVert r\rVert^2$. So **"step 8 is ATTAINED and its own slack is zero" is true of the coupling bound and false of step 8 as the record writes it.** If I104 consumes the $\theta/3$ form rather than the $\max(x,y,z)$ form, a shape-dependent gain of that size is sitting inside step 8, unclaimed, and the block's audit would have stepped straight over it.

I cannot tell from the brief which form I104 actually consumes. That is the single highest-value thing for the parent to resolve, and it is cheap: read which of the two expressions enters the chain in [second-order.md](../findings/second-order.md).

## Claim 4, the refinement: PLAUSIBLE, valid but with two defects in the statement

**Valid, yes.** Splitting $c_m=\tfrac{\langle c_m,\mathbf 1_Q\rangle}{4}\mathbf 1_Q+c_m^\perp$ and using $\hat q\mathbf 1_Q=0$ gives $c_m^{\mathsf T}\hat qc_m=(c_m^\perp)^{\mathsf T}\hat qc_m^\perp\le2\max(x,y,z)\left(\lVert c_m\rVert^2-\langle c_m,\mathbf 1_Q\rangle^2/4\right)$. The refinement is exactly this, and it is sound.

**Defect one, the constant is ambiguous and the block does not say from what.** Measured in $\langle L_{\hat q}r,r\rangle$ the discarded amount is $\max(x,y,z)\sum_m\langle c_m,\mathbf 1_Q\rangle^2/4$. The block writes $2\max(x,y,z)\sum_m\langle c_m,\mathbf 1_Q\rangle^2/4$, which is right only when read against the doubled quantity $2\langle L_{\hat q}r,r\rangle$ that the record's step 8 displays. Both readings are defensible from the text, so the block should name the normalisation.

**Defect two, "strictly better pointwise" is false as written.** The refined bound is weakly better everywhere and strictly better exactly where $\sum_m\langle c_m,\mathbf 1_Q\rangle^2>0$. On the $14$-dimensional subspace of claim 5 the two bounds are **equal**, not merely close. The block's own vacuity finding is precisely that the maximisers live in that equality set, so "strictly better pointwise" and "vacuous" are in tension as phrased. The accurate statement is that the refinement is strict on a dense open set and equal on a codimension-four subspace which contains every maximiser. That the $20000$ draws never violated it is consistent with this, because a random draw misses a codimension-four subspace with probability one.

## Claim 5, the vacuity: CONFIRMED, and it is a theorem rather than an observation

**The dimension count holds.** At $n=8$, $\dim\mathcal D_n=20$, removing $\Pi_Q$ leaves $18$, and the four functionals $r\mapsto\langle c_m,\mathbf 1_Q\rangle$ for $m\notin Q$ are linearly independent on that subspace, leaving $14$. Independence is not automatic and is worth recording: the zero-row-sum condition on row $m$ gives $\langle c_m,\mathbf 1_Q\rangle=-\sum_{m'\notin Q}r_{mm'}$, so the four functionals are the degree map of the $Q^c$ block, and the unsigned incidence matrix of $K_4$ has full rank $4$ because $K_4$ is not bipartite. Elements of $\Pi_Q$ have every $c_m=0$, so removing $\Pi_Q$ does not lower that rank. My computation returns $14$.

**The block undersells it: the refinement is not merely vacuous somewhere, it is zero at every maximiser, and this is provable.** Since $\Sigma=0$ on the subspace, $\langle L_{\hat q}r,r\rangle\le\max(x,y,z)\left(\lVert r|_Q\rVert^2+\sum_m\lVert c_m\rVert^2\right)=\max(x,y,z)\left(\lVert r\rVert^2-\lVert r|_{Q^c\times Q^c}\rVert^2\right)$. At a maximiser the left side equals $\max(x,y,z)\lVert r\rVert^2$, and $\max(x,y,z)>0$, so $r|_{Q^c\times Q^c}=0$. The row-sum identity above then forces every $\langle c_m,\mathbf 1_Q\rangle=0$. So **every** maximiser sits in the $14$-dimensional subspace, and the quantity the refinement discards vanishes there identically. The refined bound therefore has the same supremum, $\max(x,y,z)$, as the unrefined one. It cannot improve the constant, at any $n$, at any shape, including the $(1,-1,0)$ shape where $\hat q$'s kernel is two-dimensional. I verified the forcing numerically as well: at every named shape, every vector in the top eigenspace has all $\langle c_m,\mathbf 1_Q\rangle$ zero to $10^{-10}$.

**The part of the brief's question I cannot answer.** The brief asks whether the surviving subspace contains an $r$ admissible for I104 rather than merely for L220. From the brief alone I know only that I104's residual is $r_i=D-q_i$ carrying two further patterns' components. I do not have those patterns, so I cannot test membership. What I can say is that the answer no longer matters for the refinement: the refinement is dead on the maximisers whatever I104 admits, because the forcing argument above uses only $r\in\mathcal D_n$ and $r\perp\Pi_Q$, and any further constraint only shrinks the set.

## Claim 6, the localisation: PLAUSIBLE, but it is not exhaustive

The block concludes that "any gain must live in that extra structure", meaning I104's constraint on $r_i$. That is one place gain can live. It is not the only one, and three others are visible from the brief alone.

- **The second link of step 8 itself**, as set out under claim 3. $\max(x,y,z)\le1/\sqrt3$ is slack at every non-extremal shape, by up to $0.077$ and by about $0.01$ to $0.015$ at mild shapes. This lives inside step 8, not in I104's extra structure, and the block's audit of the first link alone cannot see it.
- **The joint extremiser across the chain.** Step 8 bounds one term of a longer chain. Even with every link individually sharp, the chain is sharp only if a single $r$ extremises all links at once. The maximisers found here are a very thin set, supported entirely on $Q$-to-outside entries with each $c_m$ in a single eigenline and the $Q^c$ block zero. Slack that lives in the incompatibility of one step's maximiser with another's belongs to no step and would be invisible to any per-step audit, this one included.
- **The choice of $Q$ and the relation between $\kappa$ and the form.** If the lemma maximises over four-sets $Q$, the joint constraint across $Q$'s is another home for gain. Separately, the block treats the first "$\le$" in "So $\kappa\le\dots$" as though $\kappa$ were exactly the form, when the quoted text does not establish that. If that step is itself an inequality, it carries slack the block has attributed to nothing.

So "a localisation and not a closure" is the right self-assessment, and the localisation is narrower than the block claims. The honest form is: the coupling bound's first link has zero slack, so gain must come from somewhere else, and I104's extra constraint is one candidate among at least four.

## Vacuity check on my own findings

A finding here would be vacuous if it held for reasons independent of the object. Three checks.

- **Claim 2 would be vacuous if the maximiser were forced outside $\mathcal D_n$ or into $\Pi_Q$.** It is not: the exhibited maximiser is verified in $\mathcal D_n$, orthogonal to both spanning vectors of $\Pi_Q$, and nonzero.
- **Claim 5's dimension count would be vacuous if the four functionals were dependent**, leaving a larger subspace and a weaker statement, or if the subspace were all of $\mathcal D_n\ominus\Pi_Q$, making the condition no condition. Neither: the rank is exactly $4$ by the $K_4$ incidence argument, so $14<18$ strictly and the subspace is proper.
- **My claim-3 refutation would be vacuous if I104 never used the $\theta/3$ form.** I flag this as unresolved rather than asserting the gain exists. It is conditional and the condition is checkable in one reading of the record.

## Where a second pair of eyes is owed

The brief's reason for running one reviewer, that this round is a constant comparison with no argument in it, turned out to be wrong: claims 3, 4 and 6 required argument, and two of them moved.

1. **The claim-3 refutation is the finding that changes what the parent does, and it rests on my reading of a chain I was shown only one step of.** A second reader with the record open should confirm that step 8's chain really terminates in $\theta/3$ and that I104 consumes that form. If it consumes $\max(x,y,z)$ instead, my claim-3 verdict collapses to CONFIRMED and this round produces nothing new.
2. **The claim-5 forcing argument is mine and is new relative to the block.** It is four lines and I believe it, but it upgrades the block's numerical observation to a theorem, and an upgrade by a sole reviewer deserves a check. The load-bearing step is that $\lVert r\rVert^2$ splits with the $Q^c$ block appearing only in the denominator.
3. **Claim 5's I104-admissibility question is unanswered**, because the brief withheld the two further patterns. A reviewer with them can settle it in one computation, though by the forcing argument the answer no longer affects the refinement's fate.

Nothing here rests on a long or open-ended run. The computation took $0.13$ seconds on objects built for the purpose, within the screening allowance.
