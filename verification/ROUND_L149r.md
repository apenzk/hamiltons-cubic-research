# ROUND L149r, the repair of L149's uniformity proof

**Id** L149-repair · **File** [findings/second-order.md](../findings/second-order.md), the "Proof of the uniformity" and the two blockquotes above it · **Opened and closed** 2026-09-05

**Verifiers:** v16 (never filed), v17, v18. **Verdict: `GAP`.**

## A degraded round, recorded as such

**Three were dispatched; two filed.** v16 produced neither a report nor a log line, *it never started, which is a different thing from a reviewer that goes silent mid-derivation and files at eighty-two minutes, as one did earlier today.* **So this round rests on two independent readings, not three**, and the skill's third draw is missing. It is recorded here rather than papered over, and the id stays in the queue.

## What both verifiers confirm

- **The closed form for $\inf_{w\ge0}g_\rho$ is correct**, derived independently by each. The stationary point $w_*=3\sqrt{n-1}/(\rho n)$ is $1.153$ at $n=12$ (**outside $[0,1]$**) so *"no case analysis needed"* is load-bearing rather than stylistic.
- **$\inf_{[0,1]}\ge\inf_{w\ge0}$ is legitimate and needs nothing**: a subset inequality, no attainment on either side. It costs $0.217\%$ at $n=12$.
- **$0.7197978$ is exact at $n=12$**, by two independent hand routes, and is the minimum over even $n\ge12$.
- **$a_0=\sqrt{2n/(n-2)}$ is the right constant in the right place**, $a_0n^{1/2}+nw=n(\lVert H_s\rVert^{\mathrm{bd}}_{op}+w)$ with [L146](../findings/second-order.md)'s $1/\sqrt{m-1}$.

## The three defects, all in the repair as written

| # | defect | fix applied |
|---|---|---|
| **G1** | *"branch 2 is $\ge0.7198/n$"* transports a bound on $g_\rho$ **past the prefactor** $K=\lambda(1-\eta^*)^2/(\sqrt2 J)$, which is below $1$ by better than an order of magnitude | the numeral now prices $g_\rho$ explicitly, with $K$ separated and the order-level claim stated on its own |
| **G2** | *"increasing in $n$"* is **false of the object named**, the displayed quantity carries $1/n$ and falls. What increases is its $n$-free coefficient | reworded to the coefficient, with the falling of the whole displayed |
| **G3** | $0.7198$ **rounds a lower bound upward**: the infimum is $0.7197978$, so the stated floor exceeds it by $2.24\times10^{-6}$ | floor restated as $0.71979$ |

*G3 is the sixth instance today of a lower bound stated in the unsafe direction, and the first produced by rounding.*

## The debt, and it decides the direction

**The $\tfrac29$ in $\rho^{\mathrm{eff}}$ is sourced but the sourcing needs an identification nothing on file makes.** It comes from [L141](../findings/second-order.md)(b) via [L133](../findings/second-order.md)'s $\sigma\le\tfrac29$ on the $(2,2)$ four-set block, and reading it into $\rho^{\mathrm{eff}}$ identifies that block with $\Lambda^2\!\otimes\!\Lambda^2$, **two different decompositions.** Three passages of the same file price the same constant at $1$ or record it as unknown.

**At coefficient $1$ the constant reads $0.689771$ and *decreases* to a floor of $0.582938$, the monotonicity reverses.** The order $\Omega(n^{-1})$ survives either reading; the numeral and the direction do not.

`HYPOTHESIS-DEBT`: **what is owed is the identification of the $(2,2)$ four-set block with $\Lambda^2\!\otimes\!\Lambda^2$, or a penalty bound that does not need it.** Handed to the research loop, where new mathematics belongs.

## Hypotheses

All three stated are used. **Both verifiers find more used and unlisted**, $\lVert H\rVert_F=1$, $n=2m$ even with $p=q=m$, and $\sigma\le\tfrac29$ among them. The boxed lemma's range is corrected to $m\ge6$, matching the body.

## Withdrawn under the protocol

The $\tfrac{m-3}{2(m-1)}$ against $\tfrac{m-4}{2(m-1)}$ clash, the second is the first minus the $\lambda_m$ margin, exactly as a convex combination requires. *Withdrawn by three separate readers now, in two rounds; the record should state the relation so it stops being re-found.*
