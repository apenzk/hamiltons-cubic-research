# Gate 2 brief: the norm trade at fixed total norm, and what it excludes

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note this block was drawn from, do not import the script under review, and do not read the other reviewer's report. Your independence comes from your implementation, not from your instructions.

## The setting, as a given

$\hat U,V$ are real traceless symmetric $3\times3$ matrices. Write

$$\Phi(\hat U,V)=\alpha\mathop{\mathrm{tr}}\hat U^3+\beta\mathop{\mathrm{tr}}(\hat UV^2)+\langle\hat U,A\rangle+\langle V,C\rangle,\qquad\alpha=\tfrac{15}4,\ \beta=\tfrac94,$$

$$n_U=\lvert\hat U\rvert^2,\quad n_V=\lvert V\rvert^2,\quad p_3=\mathop{\mathrm{tr}}\hat U^3,\quad q=\mathop{\mathrm{tr}}(\hat UV^2),\qquad T=\tfrac32n_U+\tfrac12n_V .$$

$A$ and $C$ are the Lagrange fields, **given and not under review**: $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$ and $C\equiv\mu V-\beta\{\hat U,V\}$, each up to a multiple of $I$.

**Given, verbatim from the record, batch 20's two pairings.** From the $\hat U$ equation, $3\alpha p_3+\beta q+\langle\hat U,A\rangle=3\mu n_U$. From the $V$ equation $\beta\{\hat U,V\}+C\equiv\mu V$, using $\mathop{\mathrm{tr}}(V\{\hat U,V\})=2\mathop{\mathrm{tr}}(\hat UV^2)$, $2\beta q+\langle V,C\rangle=\mu n_V$.

**Given, verbatim from the record, batch 21's condition.** At every local maximum, for all traceless symmetric $X,Y$ with $3\mathop{\mathrm{tr}}(\hat UX)+\mathop{\mathrm{tr}}(VY)=0$,
$$6\alpha\mathop{\mathrm{tr}}(\hat UX^2)+4\beta\mathop{\mathrm{tr}}(XVY)+2\beta\mathop{\mathrm{tr}}(\hat UY^2)\ \le\ \mu\big(3\lvert X\rvert^2+\lvert Y\rvert^2\big).$$

**Given, verbatim from the record, batch 35.** Three non-commuting critical points clear batch 18, batch 21 and batch 33's orbit bound together: $(1,-3,2)$ with $\mu=11.60060$, $(-1,-3,4)$ with $\mu=24.43870$, and $(19,-20,1)$ with $\mu=762.38453$. Batch 18 needs $\mu\ge9.3675$ at the first and batch 21 needs $\mu\ge15$.

## The block under review, quoted verbatim from disk

> **First order.** With $\lvert\hat U\rvert=a$, $\lvert V\rvert=b$ and $3a^2+b^2=2T$, stationarity along the trade is $b\,\partial_a\Phi=3a\,\partial_b\Phi$, which expands to
> $$\frac{3\alpha p_3+\beta q+\langle\hat U,A\rangle}{3\lvert\hat U\rvert^2}=\frac{2\beta q+\langle V,C\rangle}{\lvert V\rvert^2},$$
> and **both sides are $\mu$** by batch 20's two Lagrange pairings, so it holds at every critical point.
>
> **Second order.** The tangent is $X=\lambda\hat U$, $Y=\kappa V$ with $3\lambda\lvert\hat U\rvert^2+\kappa\lvert V\rvert^2=0$, admissible in batch 21's quantifier, and eliminating $\kappa$ and using $3n_U+n_V=2T$ gives
> $$\mu\ \ge\ \frac{\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)}{Tn_Un_V}.$$
>
> **And it excludes nothing.** At the three survivors the bound needs $-19.64468$, $-7.18323$ and $-33.26116$ respectively.

## The claims to attack

| # | claim |
|---|---|
| 1 | $X=\lambda\hat U$, $Y=\kappa V$ with $3\lambda n_U+\kappa n_V=0$ is traceless symmetric and tangent, so batch 21 applies to it |
| 2 | Stationarity along the trade is $b\,\partial_a\Phi=3a\,\partial_b\Phi$, and it expands to the displayed equality |
| 3 | Both sides of that equality are $\mu$, so the first order holds at every critical point and is vacuous |
| 4 | Batch 21 at that direction, after eliminating $\kappa$ and $T$, is a POSITIVE multiple of $\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)-\mu Tn_Un_V$ |
| 5 | Hence the trade contributes exactly $\mu\ge[\alpha p_3n_V^2+\beta qn_U(3n_U-2n_V)]/(Tn_Un_V)$ |
| 6 | At the three survivors that bound needs $-19.64468$, $-7.18323$ and $-33.26116$ |
| 7 | So the bound excludes none of them, and is redundant against what the record already has |
| 8 | **Therefore** R28's mechanism has no first-order and no second-order lever left at $\lvert J\rvert=3$ |

## The Lean declarations, one row per claim

Every claim has a row. A cell names the declaration that types it, or the reason none can exist. File: [I106Criticality.lean](../lean/HamiltonsCubic/Results/I106Criticality.lean).

| # | Lean |
|---|---|
| 1 | none as a tangency statement, the layer carrying no curve object. The algebraic relation is `radial_elimination`'s hypothesis `htan` |
| 2 | none: a derivative identity, and the base layer has no differential |
| 3 | none: it is batch 20's two pairings divided, and neither pairing is typed as its own declaration |
| 4 | `radial_elimination`, over reals, with `hnV`, `htan` and `hT` as stated |
| 5 | `radial_elimination` gives it on dividing by the positive factor $6\lambda^2/n_V^2$; that division is not separately typed |
| 6 | none: numerical values at reconstructed points are not propositions |
| 7 | none: a comparison of computed numbers against a recorded threshold |
| 8 | none: a claim about what a route's mechanism still has, which is not a proposition |

**NOT typed, and it matters for claim 4**: that batch 21's TRACE expression equals `radial_elimination`'s left side at the radial direction. That is a substitution of traces needing cyclicity, the same obstacle that leaves `orbit_equals_batch21` standing with a named `sorry`. It is screened at $5\cdot10^{-11}$ and no more.

## What to do

1. **Derive, do not reimplement.** Settle claims 1 to 5 by hand or symbolically.
2. **Claim 4 is the load-bearing algebra**, and the gap named above sits directly under it. Check the elimination, and check separately whether the trace substitution it rests on is legitimate, including whether it needs symmetry of $\hat U$ or $V$ that is not stated.
3. **Claim 3 is where a reader is most likely to wave something through.** Ask whether "both sides are $\mu$" needs anything beyond the two pairings, and whether the first order is vacuous at every critical point or only at some.
4. **Claim 6 is reproducible and you should reproduce it**, rebuilding the three points from the criticality system rather than trusting the figures. Say what you get.
5. **Claim 7 asks about REACH.** Three points is three points. Say what the claim is entitled to: redundant at these three, or redundant in general, and whether the block's wording overstates it.
6. **Claim 8 is a claim about a route, not about mathematics.** Decide whether it follows from claims 1 to 7 or whether it needs something further, and name what.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 5 in particular: a bound whose threshold is always negative may be weak rather than informative, so say which.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim, and any run finishing in a few minutes on objects already in hand. **What waits**: a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts. *The test is whether you can say in advance what it will cost and what it will decide.*

**Report.** Write `reviews/REVIEW_r<N>.md`. **Commit a skeleton in your first phase**: the title, the claim table with every verdict `NOT REACHED`, and the log path. Update one row per phase. **Commit that file by path only**, never `git add -A` and never `git commit -a`. **Never amend.**

**Do not write to [reviews/INDEX.md](INDEX.md).** The parent files every row after the last report lands, so neither reviewer publishes verdicts where the other will read them.

**Log** to `agent_logs/<task-name>.log`: first line carrying your PID and phase plan, a line at every phase transition, a heartbeat at least every 3 minutes carrying live state, and a closing line that **OPENS** with `DONE ` or `FAILED `, after at most a timestamp, as the last line written to the file.
