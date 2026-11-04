# Gate 2 brief: the Lean proofs of L238 (i) and L243, and R39's spread caps (2026-09-25)

You are an independent adversarial reviewer (r1130 or r1131, as your dispatch says). BREAK the claims below: a Lean statement that says less than the prose it claims, a hypothesis that makes a statement vacuous, a gap in the written argument, a wrong constant. Return CONFIRMED, PLAUSIBLE or REFUTED per numbered item, with corrections.

## Standing rule: analysis only
Argue from the definitions. You MAY run seconds of computation on objects you construct, to SCREEN or REFUTE a step, saying why an argument could not; you may NOT run sweeps, censuses, optimisations of unknown cost or unbounded hunts.

## Logging and report
Log to `agent_logs/rNNNN.log` (your number): first line with your PID and phase plan, a line per phase, a heartbeat with live state at least every ~3 minutes, and a closing line that OPENS with `DONE <summary>` or `FAILED <reason>`. Commit a skeleton `reviews/REVIEW_rNNNN.md` in your first phase (title, the item table with every verdict `NOT REACHED`, the log path), staged by path and committed with `git commit -- reviews/REVIEW_rNNNN.md` and a `docs(reviews):` message; update it as verdicts land. Do NOT edit reviews/INDEX.md or any other file, and do not read the other reviewer's report or log. Never amend. If a commit is refused because another process holds the index, wait a minute and retry.

## Givens (take as true)
- The record's norm on $\mathfrak{so}(n)$: $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}XY$, so a unit skew $X$ has $\mathop{\mathrm{tr}}X^2=-2$. L238 and L243 are stated in findings/second-order.md (read their blocks there).
- Isserlis: `integral_quadForm_mul_quadForm` in lean/HamiltonsCubic/Results/GaussianMoment.lean, proved.

## Part A: the Lean files (a comparison against fixed statements)

lean/HamiltonsCubic/Results/GaussianPairForm.lean and lean/HamiltonsCubic/Results/GaussianRankStep.lean claim to prove, in Lean:
- `frame_gaussian_form`: L238 (i) at every frame size $k$, the ordered bracket total $=\mathbb E[\sum_{i\ne j}(G_{ii}G_{jj}-G_{ij}^2)]-4k(k-1)$.
- `L243_frame`: L243's cap at the frame level with no analytic hypothesis, $T\le(1-\tfrac1{n-1})(4k^2+2\mathop{\mathrm{tr}}P^2)-4k(k-1)$ for orthonormal skew $X_i$ on $\mathbb R^n$, $n\ge2$.

## Part B: the spread caps (an argument being made), verbatim from reviews/2026-09-25-I73c-per-vector-rows.md

## The joint statement, as a concave envelope: spread averages are class variables

**The average spread of an eigenspace is class-level.** For $x=\sum_\alpha\xi_\alpha\Psi_\alpha$ with $\xi$ uniform on the unit sphere of $E_c$, $m=m_c$, the fourth moment $\mathbb E[\xi_\alpha\xi_\beta\xi_\gamma\xi_\delta]=(\delta_{\alpha\beta}\delta_{\gamma\delta}+\delta_{\alpha\gamma}\delta_{\beta\delta}+\delta_{\alpha\delta}\delta_{\beta\gamma})/(m(m+2))$ gives
$$\mathbb E\mathop{\mathrm{tr}}x^4=\frac{2G_{cc}+\sum_{\alpha,\beta}\mathop{\mathrm{tr}}(\Psi_\alpha\Psi_\beta\Psi_\alpha\Psi_\beta)}{m(m+2)}=\frac{3G_{cc}-\tau_{cc\cdot}}{m(m+2)},$$
using $\sum\Psi_\alpha^2=-A_c$ and $\mathop{\mathrm{tr}}(XYXY)=\mathop{\mathrm{tr}}(X^2Y^2)-\lVert[X,Y]\rVert^2$ in the record's norm. With angles $s_i$ of unit $x$, $\mathop{\mathrm{tr}}x^4=2\sum_is_i^4$, so $\mathbb E\sum_is_i^4=(3G_{cc}-\tau_{cc\cdot})/(2m(m+2))$. *At $S^5\times S^7$'s $\Lambda^2\mathbb R^5$ class this is $(240-60)/240=0.75$.*

**Why that closes the direction problem.** Every Ky Fan quantity is convex in $-\mathrm{ad}_x^2$, so averaging bounds it from below only. **But if $\kappa_r(x)\le\varphi_r\big(\sum_is_i^4\big)$ with $\varphi_r$ concave, Jensen runs the right way**: $\mathbb E_x\kappa_r(x)\le\varphi_r\big(\mathbb E\sum s_i^4\big)$, and the right side is class-level. Averaging the per-vector caps over a Haar-random orthonormal basis of $E_c$ then gives
$$2\sum_{\alpha\in E_c}R_a(\psi_\alpha)\ \le\ m_c\,\varphi_{r}\Big(\frac{3G_{cc}-\tau_{cc\cdot}}{2m_c(m_c+2)}\Big),$$
with the union version alike, and **each supporting line of the concave $\varphi_r$ is a constraint LINEAR in $(\tau,G)$**, which the class system does not have. *It is the averaged cap the previous section asked for, with the spread of the eigenspace, rather than its dimension, doing the work.*

**Owed**: $\varphi_r$, the concave upper envelope of $\kappa_r$ over angle types at fixed $\sum s_i^4$ (a six-parameter family, so a screen then a derivation), its supporting lines for the $r$ that occur, and a rerun of the survivors with the new constraints.

*Context*: the per-vector caps are L244 (i) (findings/second-order.md), CONFIRMED at Gate 2 by r1128 and r1129. The concave envelope $\varphi_r$ itself was computed numerically (scripts/misc/screen_I73c_spread_envelope.py) and is a screen; the caps built from it are used only in screens.

## Attack items
1. **A, statements.** Do `frame_gaussian_form` and `L243_frame` state L238 (i) and L243 as the record states them: the norm, the ordered-pair convention, $\mathop{\mathrm{tr}}P=2k$, $r=n-1$? Is any hypothesis vacuous or stronger than the prose (for instance, is `hnorm`/`horth` the record's orthonormality)?
2. **A, completeness.** `L243_frame` uses $r=n-1$ only; the record's $r=\min(k,n-1)$ also needs $r=k$ (`trace_sq_le_k` is proved but not assembled). Is anything the record claims left unproved, and is the Lean row's "proved at frame level" accurate?
3. **B, the mean-spread identity.** Check $\mathbb E\mathop{\mathrm{tr}}x^4=(3G_{cc}-\tau_{cc\cdot})/(m(m+2))$ for $x$ uniform on the unit sphere of $E_c$: the fourth-moment formula, $\sum\Psi_\alpha^2=-A_c$, $\mathop{\mathrm{tr}}(XYXY)=\mathop{\mathrm{tr}}(X^2Y^2)-\lVert[X,Y]\rVert^2$ in this norm, and $\mathop{\mathrm{tr}}x^4=2\sum s_i^4$. Is $\tau_{cc\cdot}$ the right class sum?
4. **B, the Jensen step.** If $\kappa_r(x)\le\varphi_r(\sum s_i^4)$ with $\varphi_r$ concave, is $\mathbb E_x\kappa_r(x)\le\varphi_r(\mathbb E\sum s_i^4)$, and does averaging the per-vector caps over a Haar-random orthonormal basis give $2\sum_{\alpha\in E_c}R_a(\psi_\alpha)\le m_c\varphi_r(\cdot)$, with the left side the class sum $\tau_{ca\cdot}$? Is each supporting line of $\varphi_r$ a valid linear cap?
5. **B, scope.** Is anything stated as proved that rests on the numerically computed envelope?

## Lean section
| Claim | Declaration |
|---|---|
| L238 (i) per pair | `gaussian_pair_form` |
| L238 (i) at every $k$ | `frame_gaussian_form` |
| L243 at the frame level | `L243_frame`, via `frame_cap`, `pointwise_rank_step`, `trace_sq_le_perp` |
| The rank-$k$ bound | `trace_sq_le_k` (proved, not assembled into a cap) |
| The mean-spread identity and the spread caps | none: they need the class variables on $\Lambda^2\mathbb R^n$ and the envelope, which is numerical |
