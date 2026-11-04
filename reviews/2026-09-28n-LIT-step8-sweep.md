# Step 9 sweep, 2026-09-28n: P's remaining node after the I117 cycles

*Position file: [2026-09-28n-step8-position.md](2026-09-28n-step8-position.md).*

## Batch 1: the position file's three questions against the record (screened)

- **Question 1, the largest-weight row applied to P, is on file.** The row argument needs a subsystem linear in the unknowns with nonnegative coefficients. P's criticality equation at a maximiser is linear in the off-diagonal part $B$ through $L_A$, the multiplication by the diagonal part, which is sign-indefinite, and its eigenmode reading of $B$'s mass is [R53](../routes.md)'s knapsack, blocked with [I121](../plan.md#blocked). *No new subsystem.*
- **Question 2, a pairing that reads $\theta$ against the diagonal mass, is on file** as [L284](../findings/second-order.md)'s mixing-gap variance identity, the frame-split pairing at a critical point.
- **Question 3, an extremal idempotent inside an associative subalgebra**: searched below (batch 2). The filed metrised-algebra sources carry no such statement; Fox's sectional nonassociativity casts maximal associative subalgebras as flat submanifolds under a nonnegativity hypothesis the Weyl algebra fails ([fox-2022](../references/fox-2022-sectional-nonassociativity/README.md)'s verdict).

## Batch 2: literature (searched)

- *"extremal idempotent metrised commutative nonassociative algebra associative subalgebra cubic form"*: returns the filed Tkachev, Krasnov–Tkachev and Fox papers and nothing new.
- *"maximum of the cubic invariant of the Weyl tensor … sharp bound"*: returns one source not on file, **[Branca–Kröncke 2025](../references/branca-kroncke-2025-isolation-stability/README.md)** (arXiv 2506.13248v2, July 2026). It uses the Bochner–Weitzenböck cubic $Q$ with $\lvert Q\rvert\le C(n)\lvert W\rvert^3$ and cites sharp constants only at $n=4,5,6$ (Huisken, Tran, Huisken after Tachibana), with a Cauchy–Schwarz constant for $n\ge7$. **So as of mid-2026 the sharp constant is open in the literature above $n=6$**, and every isolation and stability theorem of that paper improves with it. No method for the maximiser.

## Batch 3: the simplest coupling is neutral (derived, unreviewed)

**The identity shift cancels between the two halves.** For a Weyl operator $W$ ($\mathop{\mathrm{tr}}W=0$, $\langle W,I\rangle=0$, $I^\#W=-W$ by [L265](../findings/second-order.md), $I^\#I=(n-2)I$) and $X=W+cI$,
$$\mathop{\mathrm{tr}}X^3=\mathop{\mathrm{tr}}W^3+3c\lVert W\rVert^2+c^3N,\qquad\langle X^\#X,X\rangle=\langle W^\#W,W\rangle-3c\lVert W\rVert^2+c^3(n-2)N,$$
so $\mathop{\mathrm{tr}}X^3+\langle X^\#X,X\rangle=P(W)+c^3(n-1)N$: the $\lVert W\rVert^2$ terms cancel. The $\#$ half's identity lift (I117's) gains from a shift of one sign, and the cubic half's from the other, so a bound on $G(X)=\mathop{\mathrm{tr}}X^3+\langle X^\#X,X\rangle$ over all of $\mathop{\mathrm{Sym}}^2\mathfrak{so}(n)$ reaches P only as $P\le\sup G/\lVert X\rVert^3$ at $c=0$. That supremum is at least $G(I)/\lVert I\rVert^3=(n-1)/\sqrt N=\sqrt{2(n-1)/n}$, which is $1.354$ at $n=12$ against $\theta_0(12)=1.236$. **So a coupling of the two halves cannot be a bound on $\mathop{\mathrm{Sym}}^2$ lifted through $I$; it has to use structure only the Weyl subspace has.** *This is [F26](../findings/INDEX-traps.md)'s fact (the halves maximised apart) seen from the lift: the two shifts that sharpen the halves pull in opposite directions.*

## Phase 3a, the screen

The coupling candidate's mechanism was grepped in [findings/](../findings/) under "coupling", "both halves", "identity lift" and $c^3(n-1)N$: the halves-apart fact is [F26](../findings/INDEX-traps.md) and [28m](2026-09-28m-LIT-step8-sweep.md) question 2, and the neutrality of the shared shift is not on file. The diagonality candidates are fenced as in [28m](2026-09-28m-LIT-step8-sweep.md).

## Phase 3b, the routes

| route | closes | attackable | margin | analytic | value | how close to P |
|---|---|---|---|---|---|---|
| a coupling of both halves on the Weyl subspace, exact on the products | 3 | 1 | 1 | 1 | **3** | P outright; its first constraint is batch 3 (no lift through $I$), and no mechanism is named |
| H by [I117](../plan.md): the torus cases for $\mathfrak g_2$, $\mathfrak{sp}(2)$, $\mathfrak{sp}(3)$ now settled for H, the rest a trace lower bound | 2 | 1 | 1 | 1 | **2** | the $\#$ half, a component of P only inside a coupling |
| diagonality at the maximiser ([I36](../plan.md), [I73](../plan.md#blocked), [I121](../plan.md#blocked)) | 3 | 0 | 1 | 1 | **0** | P with L57, blocked by the two requirements |

**Outcome: the coupling is the top route for the second sweep running, and this one gives it a first constraint instead of none.** It is registered as a plan item and started, with I117 kept as the secondary whose sub-steps are concrete. *The coupling's reach is the whole range $n\ge12$, so the reach gate does not fire.*
