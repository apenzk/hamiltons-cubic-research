# REVIEW r1722: L52DisplayTF, the second display in t_F

*Cold Gate 2 review of [L52DisplayTF.lean](../lean/HamiltonsCubic/Results/L52DisplayTF.lean) at commit 03d35d1a, statement fidelity against [bispectral.md](../findings/bispectral.md) Lemma L52 and the L52 row of [lean/INDEX.md](../lean/INDEX.md). Analysis only: the source and its dependency [L52Remarks.lean](../lean/HamiltonsCubic/Results/L52Remarks.lean) were read, no `lake build` or `lake env` was run, and the only computation is a seconds-long float screen at single points, reported as screens. Heartbeat log: agent_logs/review-r1722.log.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `display_needs_small_C_tF`'s display is the record's second display in $t_F$ | CONFIRMED |
| 2 | `u_of_tF`'s five conclusions at $t_F\in[0,2]$ | CONFIRMED |
| 3 | `display_needs_small_C_tF`'s hypotheses and conclusion are the record's remark, $t_F=2$ correctly excluded | CONFIRMED |
| 4 | No vacuity, and the INDEX row's new sentence claims what the file types | CONFIRMED |

**One line: both declarations say what the record says, with $\Theta$, $C$ and $t_F$ as abstract reals, and the INDEX sentence is exact.**

## Conventions

- $t_F=\lVert K(F)\rVert_F^2$ per frame, and $t_F\le2$ in every frame by Lemma L94 ([conventions.md](../findings/conventions.md), row $t,\kappa$), so $t_F\in[0,2]$.
- $\Theta_n$ is the diagonal maximum, positive at every $n\ge4$. $C=M_++m$ (bispectral.md, the second display's preamble).
- Mathlib's `Real.rpow` with base `tF / 2 ≥ 0`, so `(tF / 2) ^ ((3 : ℝ) / 2)` is the ordinary $(t_F/2)^{3/2}$.

## Hypothesis inventory

| Declaration | Hypothesis | Used | Needed |
|---|---|---|---|
| `u_of_tF` | `0 ≤ tF` | yes | yes, for `sq_sqrt` and `rpow_mul` |
| `u_of_tF` | `tF ≤ 2` | yes | yes, for $u\le1$ (the iff holds without it) |
| `display_needs_small_C_tF` | `0 ≤ tF` | yes | yes, through `u_of_tF` |
| `display_needs_small_C_tF` | `tF < 2` | yes | yes, falsifier at $t_F=2$ below |
| `display_needs_small_C_tF` | `0 ≤ Θ` | yes | yes, falsifier at $\Theta<0$ below |
| `display_needs_small_C_tF` | `0 ≤ C` | no (`_hC` in `display_needs_small_C`) | no, harmless, true at the record's objects |

## 1. The display

The record, bispectral.md L52, "A second display, derived and not reproduced here":

> With $s=t_F/2$ and $C=M_++m$, $$\theta\ \le\ (t_F/2)^{3/2}\,\Theta_n+\tfrac92C\big(1-t_F/2\big),$$ derived in r480 and carried here on a six-digit screen alone until this round.

The Lean hypothesis is `(tF / 2) ^ ((3 : ℝ) / 2) * Θ + (9 / 2) * C * (1 - tF / 2) ≤ Θ`. That is the display's right-hand side, exponent $3/2$, coefficients $1$ and $9/2$, penalty factor $1-t_F/2$, all matching, set at most $\Theta$. "The display returns $\theta\le\Theta_n$" means exactly that its right-hand side is at most $\Theta_n$, so this is the right reading. $\Theta$ and $C$ are free reals, $\Theta_n$ and $M_++m$ being instances, which is a generalisation, and the file never mentions $\theta$, correctly, since the display itself is still owed (INDEX keeps "the second display itself, derived in r480" on the owed list).

- Falsifier sought: a mismatch in exponent or coefficient between the Lean hypothesis and the record's display, or between the display in $u$ (`display_needs_small_C`, `u ^ 3 * Θ + (9 / 2) * C * (1 - u ^ 2) ≤ Θ`) and the one in $t_F$. With $u^2=t_F/2$ and $u^3=(t_F/2)^{3/2}$ the two coincide term by term, and the proof's `rw [hu3, hu2]` performs exactly that substitution. None found.

## 2. `u_of_tF`

The five conclusions for $u=\sqrt{t_F/2}$, $0\le t_F\le2$: $u\ge0$; $u\le1$ (iff $t_F/2\le1$); $u^2=t_F/2$ (`sq_sqrt`, nonnegative base); $u^3=(t_F/2)^{3/2}$, via `sqrt_eq_rpow` then `rpow_natCast` and `rpow_mul hnn`, giving $(x^{1/2})^3=x^{3/2}$ at $x\ge0$, which is the correct side condition; $t_F<2\iff u<1$ via `sqrt_lt'` at $1>0$, i.e. $\sqrt x<1\iff x<1$. All five are correct mathematics at the stated hypotheses.

- Screen at $t_F=1/2$ (float, seconds): $u=0.5$, $u^2=0.25=t_F/2$, $u^3=0.125=(1/4)^{3/2}$, and $t_F<2$, $u<1$ both true. Agrees.
- Falsifier sought: a $t_F\in[0,2]$ where any conclusion fails. By the one-line derivations above none exists. The rpow step is where one would look, and it needs only the nonnegative base, which `hnn` supplies.

## 3. `display_needs_small_C_tF` against the record's remark

The record, same block:

> Since $\frac{1-u^3}{1-u^2}=\frac{1+u+u^2}{1+u}\le\tfrac32$ on $[0,1]$, the display can return $\theta\le\Theta_n$ at some $t_F<2$ only if $C\le\tfrac13\Theta_n$, and then the one-line bound already gives $\theta\le\tfrac12\Theta_n$ outright. **So the display is informative only at $t_F=2$, the granted diagonal case.**

The Lean statement is the first clause: at $0\le t_F<2$, $\Theta\ge0$, $C\ge0$, the display returning $\Theta$ forces $C\le\Theta/3$. The second clause is [one_line_half](../lean/HamiltonsCubic/Results/L52Remarks.lean), cited in this file's header as a pointer and not composed here, which is accurate as worded ("so by `one_line_half`").

- Screen at $t_F=1/2$, $\Theta=1$: the display holds iff $C\le(1-1/8)/((9/2)(3/4))=7/27\approx0.259\le1/3$. Agrees, and the bound tends to $\Theta/3$ as $t_F\to2$, so $\Theta/3$ is sharp as a uniform constant.
- **$t_F=2$ is correctly excluded.** There the display reads $\Theta\le\Theta$ at every $C$. Falsifier of the lemma with `tF ≤ 2` in place of `tF < 2`: $t_F=2$, $\Theta=0$, $C=1$, display true, $C\le\Theta/3$ false (screened). This is the record's point: at $t_F=2$ the display returns $\Theta_n$ with no condition on $C$, which is where it is informative, and that is the granted diagonal case (coordinate-diagonal $W$, where $t_F=2$ by L94).
- **`0 ≤ Θ` is needed.** Falsifier without it: $t_F=0$, $\Theta=-9$, $C=-2.5$, display true ($-11.25\le-9$), $C\le-3$ false (screened). At the record's objects $\Theta_n>0$, so the hypothesis costs nothing.
- `0 ≤ C` is unused. $C=M_++m$ is positive at the record's objects ($\sum\mu=0$, $\sum\mu^2=1$ force $M_+>0$, and likewise $m>0$), so it is true where applied.

## 4. Vacuity and the INDEX sentence

- Not vacuous: $t_F=1/2$, $\Theta=1$, $C=0$ satisfies every hypothesis including the display, and the conclusion is a genuine constraint (it fails at $C=1/2$, where the display also fails, consistent).
- The INDEX change at 03d35d1a in the L52 row, isolated by diff against 03d35d1a^: the owed item "the change of variables $u=\sqrt{t_F/2}$ on $t_F\in[0,2]$ behind `display_needs_small_C`" is dropped, and the sentence "**The change of variables is PROVED** in L52DisplayTF.lean: `u_of_tF`, $u=\sqrt{t_F/2}\in[0,1]$ with $u^2=t_F/2$, $u^3=(t_F/2)^{3/2}$ and $t_F<2\iff u<1$, and `display_needs_small_C_tF`, the display in $t_F$ returning $\Theta$ at some $t_F\in[0,2)$ forces $C\le\Theta/3$" is added. Every clause is a conclusion typed in the file, at the file's hypotheses. It does not claim the display itself, which stays owed.
- Out of scope, noted for the record: the owed item "the one-line bound in its $\theta$ form at the record's objects" is present at 03d35d1a and absent at HEAD, so a later commit removed it. This review did not check that removal.
- Axioms: the file has no `sorry`, `admit`, `axiom` or `native_decide`, and it is imported by [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean). The kernel-axiom claim itself was not rechecked, per the no-build footing.

## Overall verdict

**CONFIRMED as typed.** `u_of_tF` and `display_needs_small_C_tF` are faithful to Lemma L52's second display and its "informative only at $t_F=2$" remark, $t_F=2$ is excluded exactly where the lemma would fail, no hypothesis is vacuous, and the INDEX row's new sentence claims no more than the file types.
