# ROUND L149-F, the five findings ROUND_L149 never adjudicated

**Id:** L149-F. **Source:** [ROUND_L149](ROUND_L149.md)'s finding table, F7, F9, F10, F11, F12, against [findings/second-order.md](../findings/second-order.md)'s Lemma L149. **Date:** 2026-09-05. **Adjudicators allocated:** v46, v47. **Phase:** 1, dispatched.

**Why now.** [ROUND_L149](ROUND_L149.md) adjudicated F8 alone, on the ground that it was the only finding reaching the proof itself, and its repair subsumed F1, F2, F5 and F6 by rewriting the text they attacked. **Five findings were carried forward and have sat unadjudicated through six later rounds**, three of which took values from the block they attack. *A carried-forward finding is the cheapest thing in the queue to lose track of, because nothing points at it.*

**Two things have changed under them since they were filed**, and the adjudicators are told both without being told what to conclude: the block's $\rho^{\text{eff}}_n$ now carries a closed form and four evaluated dimensions, and F12 was withdrawn by one later round and restored by another.

## The five, quoted from the finding table

| id | finding | step attacked | raised by |
|---|---|---|---|
| **F7** | **The kernel hypothesis is nowhere stated**: branches 2 and 3 rest on $\rho(H)\ge g_n/\lVert H\rVert_{op}$, i.e. $\ker W^*=0$ | branches 2 and 3 | one reader |
| **F9** | $\rho^{\text{eff}}_n>0$ across the range has **no argument on file**, four values and the word *"increasing"*. It is what separates $\Omega(n^{-1})$ from $\Theta(n^{-3/2})$ | the $\rho^{\text{eff}}$ display | one reader |
| **F10** | The $m=4$ argument names the wrong failure, the joint-eigenspace recipe gives $\rho=\theta_0>0$ there; what fails is L146's operator-norm input | the "what the coefficient buys" clause | one reader |
| **F11** | $\kappa$ and $w^*$ each name two different quantities inside one block | notation | one reader |
| **F12** | *"the first is minimised at $w=0$"*, branch 1 is $(c_p+u^2)/(S+au)$ with $f'(0)<0$, and $u\ne w$ | the boxed statement | one reader raises, another withdrew the same candidate |

## Phase 1, returns

- **v46** · [VERIFY_v46.md](VERIFY_v46.md) · **F7 `SUPERSEDED`, F9 `HYPOTHESIS-DEBT`, F10 `WITHDRAWN`, F11 `UPHELD IN PART`, F12 `UPHELD`.**

*Five findings filed, and five different verdicts, which is the argument for adjudicating a carried-forward list rather than acting on it or dropping it wholesale.*

| id | outcome |
|---|---|
| **F7** | **Superseded.** [Line 1227](../findings/second-order.md) now states $\ker W^*=0$, names branches 2 and 3 as its dependents, and discharges it with $g_n$. |
| **F9** | **`HYPOTHESIS-DEBT`, and the stake is exactly as filed.** Setting $\rho=0$ in the block's own $g_\rho$ gives $\Theta(n^{-3/2})$ at $w=1$; with $\rho$ bounded below, $\Theta(n^{-1})$. **Positivity is solely what separates the exponents**, the closed form is on file, and *the passage from it to "increasing" and to $>0$ is not.* |
| **F10** | **Withdrawn, on both halves.** At $m=4$ the off-summand margin $3\theta_0\tfrac{m-3}{2(m-1)}$ and $c_p$ are both exactly $\theta_0/2$, so the $w^2$ coefficient $c_{\min}-c_p$ is $0$ (the text names the right failure) and L146 is stated for $m\ge3$, so it does not fail there either. |
| **F11** | **Upheld in part.** $\kappa=3\sqrt{2.2}=4.4497$ at line 1229 against $\lvert\kappa_n\rvert=0.1016$ at line 1222, **a factor $43.8$, one subscript apart**, and [conventions.md](../findings/conventions.md) registers $\kappa$ three times without this one. *Reading line 1241 the wrong way turns $+0.416$ into $-2.60$.* The $w^*$ half fails: $w^*$ occurs nowhere in the block. |
| **F12** | **Upheld, and the consequence is the fatal direction.** $f'(0)=-ac_p/S^2<0$, so $w=0$ is branch 1's **maximum**. Its infimum is $f(u^*)=2u^*/a=\Theta(n^{-3/2})$ at $w=\Theta(1)$, strictly below $n^{-1-\beta}$ for $\beta<\tfrac12$, **so the boxed $r_n\gtrsim n^{-1-\beta}$ is a lower bound stated upward.** *The record's own lines 1111 and 1179 already point the same way.* |

**F12 is held for v47 before anything moves.** *It has been raised, withdrawn, withdrawn again and restored across four rounds without ever being settled, and it now carries a claim that a boxed lower bound is overstated*, the same shape as [ROUND_L157](ROUND_L157.md)'s fatal finding. **One adjudicator does not settle a bound's direction.**

- **v47** · [VERIFY_v47.md](VERIFY_v47.md) · **F7 `SUPERSEDED`, F9 `HYPOTHESIS-DEBT`, F10 `SUPERSEDED`, F11 `UPHELD IN PART`, F12 `UPHELD`.**

**F12 is unanimous, and both adjudicators reach the same consequence independently.** v47 derives the infimum from [L147](../findings/second-order.md)'s own identity, $f(u^*)=2u^*/a\ge\tfrac12\min(c_p/S,\sqrt{c_p}/a)$, and gets $\Theta(n^{-3/2})$ at $w=\Theta(1)$, so *"Hence $r_n\gtrsim n^{-1-\beta}$"* is **too large on all of $\beta\in[0,\tfrac12)$**. *It also notes the repair is determinate rather than open: $\sqrt{c(H)}/a$ **is** $g_\rho$, so giving branch 1 the $c(H)$ branch 2 already carries returns the display through the sweep and the clause is deleted rather than patched.*

**F9 is unanimous too**, and v47 supplies the shape of the debt: positivity of $\rho^{\text{eff}}_n=\sqrt6-\theta_0(n)\tfrac{n+16}{2(n-2)}$ is $11n^3-55n^2-224n+256>0$, **while what the block actually consumes is the stronger $\rho^{\text{eff}}_n\ge\rho^{\text{eff}}_{12}$**, and nothing on file proves either.

**F10 splits without consequence.** v46 withdraws it, v47 supersedes it; *they disagree about the $m=4$ arithmetic (v46 makes the coefficient $0$, v47 makes $\rho=\theta_0$) and agree the sentence it attacked is gone either way.* **The round records the split and takes no action, since both verdicts call for none.**

## Phase 5, the round's verdict

**Impact: `FATAL`.** *Repairs applied in [b3a87aba](../findings/second-order.md); the queue decision is the user's.*

**A boxed lower bound was stated upward for the second time in this block.** L149's *"Hence $r_n\gtrsim n^{-1-\beta}$"* is replaced by what its branches give, $r_n\gtrsim n^{-3/2}$, **which is [L145](../findings/second-order.md)'s own order, so nothing downstream of L145 moves.** **And [L147](../findings/second-order.md)'s `HYPOTHESIS-DEBT` on the same radius closes by refutation rather than by payment**: it recorded the joint minimisation as owed and the radius as *"not refuted"*; the minimisation has now been done and it refutes the radius.

### What this round is really about

**F12 was raised, withdrawn, withdrawn again and restored across four rounds without once being adjudicated.** Each of those rounds had a reason to defer it, it was one finding among twelve, then a side-issue to a repair, then a correction to a correction. *No round was wrong to defer, and the aggregate was that a false boxed bound stood through six audits of its own block.* **A carried-forward finding needs an owner, and the queue row it sat in could not even be parsed by the tooling that names the next task.**

**Owed, and not attempted here:** F9's two positivity statements, and the $\tfrac29$ box's alternative numerals, which v47 alone reads as $0.640026$ and $0.416102$ against the recorded $0.689771$ and $0.582938$, *one reader on a numeral, so it is queued rather than applied.*
