# Gate 2 brief: two claims about I104's deficit, and whether they stand at the same configuration

You are an adversarial reviewer. **Work from the definitions below and from the mathematics alone.** Do not read the working note these blocks were drawn from, and do not import the scripts under review.

**One reviewer, not two, and deliberately.** Both claims compare a computed number against a bound the record already states and calls exact. There is no argument being made, so a second reader would perform the same comparison and report it in different words.

## The setting, quoted from the record and NOT restated

**The chain's per-block slack**, verbatim:

> at $\theta^2=\tfrac32$ the per-block slack $F_i(u)=\theta u^2-\tfrac{u^3}{2\sqrt3}-\tfrac u{\sqrt3}\big(t+\tfrac{N-N_i}2\big)-N_i\big(\tfrac\theta2-\tfrac\tau{N_i}\big)$ is negative somewhere on every block's admissible $u$-interval on a whole region of the grid, not at one point: the most negative value of the largest block slack is $-0.020$, at $N_1=N_2=N_3=0.268$ with $\tau$ at its bound $0.069$

with the admissible interval given by $u_i\ge(\theta-2\tau/N_i)/\sqrt3$ and $u_i\le\sqrt t$, and $t=1-N$, $N=\sum_iN_i$, $\theta=\sqrt{3/2}$.

**The Gram bound**, a theorem the record proves exact:

> the cross-plane geometry is rigid [...] **the cross-Gram has rank one, and the principal cosines are exactly $(\tfrac13,0)$** [...] $\sum_iu_i^2\le\lambda_{\max}(G_e)\,t$ with $G_e$ the $3\times3$ matrix of unit diagonal and off-diagonals $\pm\tfrac13$

and $\lambda_{\max}(G_e)=\tfrac53$, attained.

**The joint system**, verbatim, with $G_e^{-1}=\tfrac32I-\tfrac3{10}J$:

> $$t\ \ge\ \sum_a\beta_a^2+\tfrac32\sum_a\alpha_a^2-\tfrac3{10}\Big(\sum_a\alpha_a\Big)^2,\qquad\langle q_a,q_b\rangle=\tfrac13\alpha_a\alpha_b,$$
> an identity on $\Sigma$, equivalently $\sum_iu_i^2\le t-\tfrac32\sum_ix_i^2+\tfrac9{10}(\sum_ix_i)^2$ under $\alpha_i=\sqrt3x_i$

with $u_a^2=\alpha_a^2+\beta_a^2$. **These $x_i$ are the shared-channel coefficients of the Gram system.** They are a different object from the sectional shape $(x,y,z)$ that appears in the same file.

## The two blocks under review, quoted verbatim from disk

> **At that configuration the admissible interval starts at $u_{\mathrm{lo}}=(\theta-2\tau/N_i)/\sqrt3=0.4098$**, so the smallest admissible $\sum_iu_i^2$ is $3\cdot0.4098^2=0.504$, against $\tfrac53t=0.327$. **The configuration cannot occur.**
>
> *Why testing at $u_{\mathrm{lo}}$ is the right test: it MINIMISES $\sum_iu_i^2$ over the interval, so if even the minimum violates the bound then every admissible triple there does, and the test is the most permissive one available.*
>
> | sweep | worst shortfall | at |
> |---|---|---|
> | all configurations | $-0.020422$ | $N_i=0.278$, $\tau=0.0733$, EXCLUDED by the Gram bound |
> | Gram-admitted only | $-0.014793$ | $N_i=0.218$, $\tau=0.0509$ |

> **What the system forces.** At the recorded failing configuration $t=0.598$, $u_a=0.496$, so $\sum u_a^2=0.738048$. The $x$-FREE part of the joint system reads $\sum u^2\le t=0.598$, which is VIOLATED by $0.140048$, so the $x$-dependent terms must make up exactly that. Cauchy--Schwarz gives $S_1^2\le3S_2$, hence $\tfrac9{10}S_1^2-\tfrac32S_2\le1.2\,S_2$, and therefore
> $$S_2=\sum_ix_i^2\ \ge\ \frac{0.140048}{1.2}=0.116707,$$
> **with equality only when all $x_i$ are equal.**

## The claims to attack

| # | claim | kind |
|---|---|---|
| 1 | $u_{\mathrm{lo}}$ minimises $\sum_iu_i^2$ over the admissible interval, so an exclusion tested there holds for every admissible triple | mathematics |
| 2 | The recorded worst configuration is therefore excluded by the Gram bound and cannot occur | mathematics |
| 3 | Restricted to Gram-admitted configurations the worst shortfall is $-0.014793$, at $N_i=0.218$, $\tau=0.0509$ | numerical |
| 4 | The joint system's two displayed forms are equivalent under $\alpha_i=\sqrt3x_i$ | mathematics |
| 5 | At $t=0.598$, $u_a=0.496$, the $x$-free part is violated by $0.140048$, and Cauchy--Schwarz then forces $S_2\ge0.116707$ | mathematics |
| 6 | The scalar corollary $\sum u^2\le\tfrac53t$ discards exactly that, being slack by $0.2586$ there | mathematics |
| 7 | Neither claim closes the $0.02$, and the deficit the estimates must now cover is $0.0148$ | about the item |
| 8 | **The two blocks are stated at the SAME configuration, so claim 7's arithmetic is well posed** | **mixed, and this is the one the brief most wants attacked** |

## The Lean declarations, one row per claim

| # | Lean |
|---|---|
| 1 | none: the admissible interval and $\sum u_i^2$ are scalar quantities of a configuration, and the base layer carries matrices rather than this problem's parametrisation |
| 2 | none: an exclusion of a configuration, which needs the interval object row 1 says is absent |
| 3 | none: a grid sweep's extremum is not a proposition |
| 4 | **none, AND THIS IS A GAP**: it is an algebraic identity in $\alpha,\beta,x$ with no matrices in it, so it is TYPEABLE by `ring` after substitution and is not typed. *If you confirm it, say so, because it becomes an obligation* |
| 5 | **none, and the Cauchy--Schwarz step alone IS typeable**: $(\sum_ix_i)^2\le3\sum_ix_i^2$ at three terms is `inner_mul_le_norm_mul_norm` or a direct `nlinarith`, and it is not typed |
| 6 | none: a comparison of two computed numbers against each other |
| 7 | none: a claim about what an item's estimates must cover |
| 8 | none: a claim about whether two blocks share a configuration, which is about the text rather than about the objects |

## What to do

1. **Claim 8 is the one to settle first, and the brief believes it is FALSE.** The Gram-exclusion block works at $N_i=0.268$ and moves the worst to $N_i=0.218$; the joint-forcing block works at $t=0.598$, which is $N_a=0.134$. **Compute $t$ at each and say plainly whether the two blocks are describing the same point.** If they are not, say what claim 7's arithmetic is actually comparing, and whether the $0.1167$ forcing has any bearing on the $0.0148$ deficit.
2. **Claim 1 is the load-bearing direction argument.** Verify that $u_{\mathrm{lo}}$ minimises $\sum_iu_i^2$, and in particular whether all three blocks must sit at their own lower endpoints simultaneously, or whether a configuration can mix endpoints in a way the test does not cover.
3. **Claim 4 is a restatement and restatements invert.** Derive the second form from the first yourself and say whether the coefficients $\tfrac32$ and $\tfrac9{10}$ are right.
4. **Claim 5's Cauchy--Schwarz step**: confirm $S_1^2\le3S_2$ is the right direction here, and that using it to bound $\tfrac9{10}S_1^2-\tfrac32S_2$ from above is valid rather than mixing an upper bound into a lower-bound argument.
5. **Claim 3 is reproducible and you should reproduce it** from the quoted $F_i$ and the quoted interval, rather than trusting the figures. Say what you get, and whether the sweep's assumption that $N_1=N_2=N_3$ is one the record's own grid makes.
6. **Claim 2 asks about a theorem's reach.** The Gram bound is proved for the three pattern projections of a single $D$. Confirm the configurations being excluded are ones it actually governs.
7. Return **CONFIRMED**, **PLAUSIBLE** or **REFUTED** per claim, with corrections.

**State what a claim would look like if it were vacuous, and check that it is not.** Claim 5 in particular: a forced lower bound on a quantity nothing else constrains buys nothing, so say whether $S_2$ appears anywhere the item can use.

## Standing rules

**Analysis only.** A LONG or OPEN-ENDED run needs the user's approval for the specific task. **Permitted without asking**: screening a claim you are about to record, seconds of compute on objects you construct for that purpose, and any run finishing in a few minutes on objects already in hand.

**A control is an assertion, never a printed expectation.**

**Report.** Write `reviews/REVIEW_r<N>.md`, skeleton in your first phase with every verdict `NOT REACHED`. **Commit with an explicit PATHSPEC**, `git commit -m "<msg>" -- reviews/REVIEW_r<N>.md`, never `git add -A` and never `git commit -a`. **Never amend.** **Do not write to [reviews/INDEX.md](INDEX.md).**

**Log** to `agent_logs/<task-name>.log`: PID and phase plan on the first line, a line per phase, a heartbeat at least every 3 minutes, and a closing line OPENING with `DONE ` or `FAILED `.
