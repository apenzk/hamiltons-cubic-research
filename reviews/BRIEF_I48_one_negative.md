# Gate 2 brief: L35's owed one-negative case, and whether $\theta\le0$ there

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the findings files, the working notes, the screen or the Lean file under review.

**Two reviewers on identical briefs.** New mathematics is being made rather than read.

## The setting, given because every attack item needs it

$W$ is a unit-norm element of $\mathrm{Weyl}_m$, read as a symmetric operator on $\Lambda^2\mathbb R^m$ with eigenvalues $\lambda_\alpha$ in an orthonormal eigenbasis $v_\alpha$. Write $T_{\alpha\beta\gamma}=\langle[v_\alpha,v_\beta],v_\gamma\rangle^2$, and

$$\theta=\sum_\alpha\lambda_\alpha^3+3\!\!\sum_{\alpha<\beta<\gamma}\!\!T_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma,$$

an identity requiring $\lVert W\rVert=1$. **Trace-freeness gives $\sum_\alpha\lambda_\alpha=0$, and unit norm $\sum_\alpha\lambda_\alpha^2=1$.**

**GIVEN, on the record and NOT audited here.** A recorded chain relaxes $\theta$ to a quantity $G$ using nonnegativity, total symmetry and the pair caps $\sum_\gamma T_{\alpha\beta\gamma}\le2$, and $G$ decouples as an identity. With the negative eigenvalues written $-b,-c$ (so $b,c\ge0$), the positives written $\lambda_P$ with top $A$, and

$$s=b+c,\qquad u=\sum_P\lambda^2,\qquad d=u-A^2,$$

the recorded relaxation is, verbatim:

> `G = Σ_Pλ³ − b³ − c³ + 6Abc + 3M(λ_P)` with `M` a fractional triangle packing over the positives,
> `3M ≤ h·(s² − u)` with `h` the harmonic mean of the three largest positives, `h ≤ min(A, K₀√d)` with `K₀ = 3/(2√2)`,
> and `Σ_Pλ³ ≤ A³ + min(A,√d)·d`.
>
> Together: `G ≤ R(A,s,u) := A³ + min(A,√d)d + min(A,K₀√d)(s²−u) − b³ − c³ + 6A·bc`, and `bc = (s²−1+u)/2`.

**The case at issue.** That chain's endgame is written for **exactly two** negative eigenvalues, where a monotonicity step pushes $s$ and $u$ to the boundary $s^2=2-2u$, which is $b=c$. **The ONE-negative case is owed**, and the line once offered for it, taking $c\to0$ as a limit, fails because $bc=0$ is the locus $s^2=1-u$, which sits strictly inside $\{s^2<2-2u\}$ rather than on the face the maximisation runs on.

## The derivation under review, quoted verbatim from disk

> Put $c=0$ into the relaxation DIRECTLY rather than as a limit. The term $-b^3-c^3+6Abc$ collapses to $-s^3$, and bounding both $\min$ factors by $A$, legitimate because $d\ge0$ and $s^2-u\ge0$, the $A^3$ and $Au$ terms cancel identically:
>
> $$A^3+A\,d+A(s^2-u)-s^3\;=\;A s^2-s^3\;=\;s^2(A-s)\;\le\;0,$$
>
> since trace-freeness makes $s$ the sum of the POSITIVES as well as the negative magnitude, so the top positive $A$ is at most $s$. Equality is exactly $A=s$, one positive eigenvalue, the spectrum $(1,-1)/\sqrt2$ where $\theta=0$. **$u$ CANCELS, so the bound uses neither the unit norm nor the one-negative locus, only $A\le s$ and the two nonnegativity facts.**

## The claims to attack, one row per claim, with the Lean declaration that types it

| # | claim | Lean |
|---|---|---|
| 1 | one negative eigenvalue is exactly $bc=0$, hence exactly $s^2=1-u$ | none: a restatement of the recorded $bc=(s^2-1+u)/2$, which is given above |
| 2 | with $c=0$, the term $-b^3-c^3+6Abc$ equals $-s^3$ | none: immediate from $b=s$, $c=0$, and it is folded into the statement below |
| 3 | $s^2-u\ge0$ always, being $2\sum_{a<b}\lambda_a\lambda_b$ over the positives | `hsu`, a hypothesis binder of `one_negative_nonpos` |
| 4 | $A\le s$, because trace-freeness makes $s$ the sum of the positives and $A$ is the largest of them | `hAs`, a hypothesis binder |
| 5 | the identity $A^3+Ad+A(s^2-u)-s^3=s^2(A-s)$ whenever $d=u-A^2$ | `collapse`, **proved**, standard axioms |
| 6 | bounding both $\min$ factors by $A$ is legitimate, and gives $\le s^2(A-s)\le0$ | `one_negative_nonpos`, **proved**, standard axioms |
| 7 | equality forces $A=s$, one positive eigenvalue | `equality_iff_single_positive`, **proved**, standard axioms |
| 8 | therefore $\theta\le0$ on the one-negative stratum, closing L35's owed case | none: needs the chain $\theta\le G\le R$, which is the record's and is given above rather than audited |
| 9 | **the result is NOT VACUOUS: the one-negative stratum is nonempty and $\theta\le0$ is informative there** | none, **AND THIS IS THE ONE THE BRIEF MOST WANTS ATTACKED** |
| 10 | the $c\to0$ line genuinely fails, so this is a different argument rather than the same one restated | none: a claim about two loci, checkable by comparing $s^2=1-u$ against $s^2=2-2u$ |

## What to do

1. **Claim 9 first, and the brief is genuinely unsure.** Ask what the one-negative stratum contains. Trace-freeness forces the single negative eigenvalue to balance ALL the positives. **Does any Weyl tensor have exactly one negative eigenvalue on $\Lambda^2$?** If the stratum is empty, or if $\theta\le0$ there follows from something far cheaper (oddness of $P$, a sign argument, a known result), then the derivation is correct and buys nothing. *State what the finding would look like if it were vacuous, and check that it is not.*
2. **Claim 6 is the load-bearing step and the direction is what to check.** Bounding $\min(A,\cdot)$ above by $A$ increases the bound, so it preserves an upper bound on $G$. Confirm that, and confirm the two nonnegativity facts are what license it: a factor multiplying a NEGATIVE quantity would invert. **In particular check $s^2-u\ge0$ carefully**, since if it could be negative the step is wrong.
3. **Claim 5 is algebra and algebra inverts.** Expand it yourself and confirm the cancellation, in particular that $u$ really does drop out and that the surviving term is $s^2(A-s)$ rather than $s^2(s-A)$.
4. **Claim 4 is the hypothesis carrying the sign.** Confirm $A\le s$, and say whether it can fail: is $s$ the sum of the positives, and is $A$ their maximum? **If $A>s$ were possible the conclusion reverses**, so say what would have to be true for that.
5. **Claim 8 asks about reach.** The chain $\theta\le G\le R$ is the record's. Say whether the one-negative case sits inside its hypotheses, or whether some step of it assumed two negative eigenvalues in a way that does not survive $c=0$. **This is the most likely place for a real gap.**
6. **Claim 1 and claim 10 together.** Confirm $bc=0$ is $s^2=1-u$, and that this is strictly inside $\{s^2<2-2u\}$ rather than on its boundary, which is what makes the limit argument fail.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, and any run finishing in a few minutes on objects already in hand. **The deliverable is a derivation, and a number is a screen.**

**A control is an assertion, never a printed expectation.**

**Report.** Write `reviews/REVIEW_r<N>.md`, skeleton committed in your FIRST phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`, never `git add -A` and never `git commit -a`. **Never amend.** **Do not write to reviews/INDEX.md.**

**Two traps in the commit gate.** [cycle_deliverable.py](../.claude/hooks/cycle_deliverable.py) reads the first physical line of the bash command for `refut\w+`, so a subject line containing "refutes" trips its opens-an-item tripwire while the parent has `plan.md` staged. Its `SEARCHED` regex anchors on `$` under `re.M`, so a trailer works only when the closing shell quote sits on the next line.

**Log** to `agent_logs/<task-name>.log`: PID and phase plan on the first line, a line per phase, a heartbeat carrying live state at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
