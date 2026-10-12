# Gate 2 brief: the frame variation's first and second order, and what the record already holds

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note this block was drawn from. Argue from the definitions rather than importing any script under review.

**This round is a COMPARISON against text already fixed on the record**, so you are one reviewer rather than two. Your job is to decide whether each claim below is true, and in particular whether the two passages quoted as givens say what the block says they say.

## The setting, as a given

$\hat U$ and $V$ are real traceless symmetric $3\times3$ matrices. $A$ and $C$ are the Lagrange fields of the criticality system, and their forms, **given and not under review**, are

$$A\ \equiv\ 3\mu\hat U-3\alpha\hat U^2-\beta V^2,\qquad C\ \equiv\ \mu V-\beta\{\hat U,V\},$$

each up to a multiple of $I$, where $\{X,Y\}=XY+YX$ and $K=[\hat U,V]$. Write $\Omega$ for a real skew $3\times3$ matrix.

**Given, quoted verbatim from the record, batch 20:**

> from the $V$ equation $\beta\{\hat U,V\}+C\equiv\mu V$, using $\operatorname{tr}\big(V\{\hat U,V\}\big)=2\operatorname{tr}(\hat UV^2)$,
> $$2\beta\operatorname{tr}(\hat UV^2)+\langle V,C\rangle=\mu\lvert V\rvert^2 .$$

**Given, quoted verbatim from the record, batch 21's condition.** At every local maximum, for all traceless symmetric $X,Y$ tangent to the constraint surface,
$$6\alpha\operatorname{tr}(\hat UX^2)+4\beta\operatorname{tr}(XVY)+2\beta\operatorname{tr}(\hat UY^2)\ \le\ \mu\big(3\lvert X\rvert^2+\lvert Y\rvert^2\big).$$

**Given, quoted verbatim from the record, batch 22:**

> *The coefficient $a$ is the $X=0$ case of the same condition and $c$ is three times the $Y=0$ case, so both are already known to be at most zero.*

**Given, quoted verbatim from the record, batch 21's closing line:**

> **It is not settled by any specialisation to one variable**, which is all that has been extracted from it so far.

## The block under review, quoted verbatim from disk

> **The piece as stated.** Varying the frame $P$ moves $V$'s eigenvectors while $\hat U$, $C$ and $V$'s spectrum stay fixed, so the tangent is $\dot{\hat U}=0$, $\dot V=[\Omega,V]$ for skew $\Omega$.
>
> **First order is vacuous.** The frame-dependent part is $\beta\operatorname{tr}(\hat UV^2)+\operatorname{tr}(VC)$, whose variation is $\operatorname{tr}\big([\Omega,V](\beta\{\hat U,V\}+C)\big)$, so stationarity for every skew $\Omega$ is $[V,\beta\{\hat U,V\}+C]=0$. **Batch 20's own $V$ equation is $\beta\{\hat U,V\}+C\equiv\mu V$**, so the bracket is $[V,\mu V]=0$ identically.
>
> **Second order is batch 21 at $X=0$.** Evaluating batch 21's joint condition at $(X,Y)=(0,[\Omega,V])$ reproduces the frame second variation exactly.

## The claims to attack

| # | claim |
|---|---|
| 1 | Varying $P$ alone gives tangent $\dot{\hat U}=0$, $\dot V=[\Omega,V]$, and that curve stays on the constraint surface |
| 2 | The frame-dependent part of the value is $\beta\operatorname{tr}(\hat UV^2)+\operatorname{tr}(VC)$ |
| 3 | Its variation is $\operatorname{tr}\big([\Omega,V](\beta\{\hat U,V\}+C)\big)$, so stationarity for every skew $\Omega$ is $[V,\beta\{\hat U,V\}+C]=0$ |
| 4 | Substituting $C$'s own form makes that bracket vanish for every $\hat U$, $V$, $\mu$, $\beta$ |
| 5 | With a GENERIC symmetric field in place of $C$ the same bracket does NOT vanish |
| 6 | Batch 21's condition at $(X,Y)=(0,[\Omega,V])$ reproduces the frame second variation exactly |
| 7 | The quoted batch 22 sentence covers the direction of claim 6 |
| 8 | Nothing else on the record already states claim 3 or claim 4 under another name |

## The Lean declarations, one row per claim

Every claim has a row. A cell names the declaration that types it, or the reason none can exist. Files: [I106Criticality.lean](../lean/HamiltonsCubic/Results/I106Criticality.lean), [I106aOrthostochastic.lean](../lean/HamiltonsCubic/Results/I106aOrthostochastic.lean).

| # | Lean |
|---|---|
| 1 | none: a statement about a curve of frames, and the base layer carries no `O(3)` curve object to state tangency over |
| 2 | none: an identification of which part of the value depends on the frame, not a proposition about matrices |
| 3 | none for the UNSUBSTITUTED condition: the variation is a derivative and the layer has no differential. `frame_first_order_vacuous` states only the substituted bracket |
| 4 | `frame_first_order_vacuous`, proved by `module` over `Cfield`, with no hypothesis beyond the field's own form |
| 5 | none: a NON-vanishing claim needs an explicit witness, and no witness is typed. *Screened only, at $23.79$ against $3.7\cdot10^{-15}$* |
| 6 | none for this specialisation: `second_variation_expansion` types batch 21's expansion and `orbit_equals_batch21` its evaluation along the JOINT conjugation, neither at $(0,[\Omega,V])$ |
| 7 | none: a claim about what a recorded sentence covers is not a proposition |
| 8 | none: a claim about the contents of the record is not a proposition |

## What to do

1. **Derive, do not reimplement.** Settle claims 1 to 4 and 6 by hand or symbolically.
2. **Claim 3 is the one to press.** The block asserts a variation without computing it in the brief. Check the trace manipulation, including whether $\operatorname{tr}(\hat UV^2)$'s variation really contributes $\{\hat U,V\}$ and whether any step needs symmetry of $\hat U$ or $V$ that is not stated.
3. **Claim 5 is the control**, and without it claim 4 proves nothing about the geometry. Decide whether it holds, and whether a generic field is the right control or a straw one.
4. **Claim 6 is where a reader is most likely to be fooled.** Batch 21 quantifies over tangent $X,Y$. Check that $(0,[\Omega,V])$ is genuinely tangent, and that "reproduces exactly" is not hiding a factor or a missing term.
5. **Claim 7 asks whether a quoted sentence reaches further than it says.** Batch 22's $a$ is a coefficient in a specific quadratic on a specific three-dimensional subspace. Decide whether that covers every $(0,Y)$ direction or only some.
6. **Claim 8**: search the record by the OBJECT rather than by vocabulary, and say what you searched.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 4 in particular is an identity, so ask what it would take for it to be uninformative.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, reported as a screen and never as evidence for a positive claim, and any run finishing in a few minutes on objects already in hand. **What waits**: a sweep over a parameter range, a census of a family, an optimisation whose cost is unknown before it starts. *The test is whether you can say in advance what it will cost and what it will decide.*

**Report.** Write `reviews/REVIEW_r967.md`. **Commit a skeleton in your first phase**: the title, the claim table with every verdict `NOT REACHED`, and the log path. Update one row per phase. **Commit that file by path only**, never `git add -A` and never `git commit -a`. **Never amend.**

**Do not write to [reviews/INDEX.md](INDEX.md).** The parent files the row after your report lands.

**Log** to `agent_logs/r967-fencing.log`: first line carrying your PID and phase plan, a line at every phase transition, a heartbeat at least every 3 minutes carrying live state, and a closing line that **OPENS** with `DONE ` or `FAILED `, after at most a timestamp, as the last line written to the file.
