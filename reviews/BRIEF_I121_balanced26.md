# Gate 2 brief (one reader): the balanced-product corollary of the second-kind threshold

**This round compares a complete Lean proof against its prose claim, so it has one reader.** Verdict per item: CONFIRMED, PLAUSIBLE or REFUTED with corrections. **Analysis-only footing**: read, compare and derive; compute only to check a value, the smallest computation that does it (seconds). No sweeps.

## The block under review, verbatim from [the working note](2026-09-28d-I121-smallmass-direct.md)

- **One consequence at the balanced product.** Where the maximal-frame diagonal part is proportional to the balanced product, [R53](../routes.md)'s dichotomy (Gate 2 [r1816](REVIEW_r1816.md), [r1817](REVIEW_r1817.md)) leaves "$W$ diagonal or $t\le\tfrac2{n-4}$", and Schur's average excludes the second branch from $n=30$ (`average_beats_threshold`). **The threshold above excludes it at $n=26$ and $n=28$ as well**, where $\tfrac29\tfrac n{n-1}\varepsilon_n^2$ is $0.00986$ and $0.01088$ against $\tfrac4{(n-4)^2}=0.00826$ and $0.00694$ ([SecondKindBalanced.lean](../lean/HamiltonsCubic/Results/SecondKindBalanced.lean), `threshold_beats_balanced`). At $n=24$ it falls short, $0.00871$ against $0.01$. *So at even $n\ge26$ a global maximiser with a balanced-product diagonal part is diagonal, resting on R53's untyped coupling bound.*

## Givens

- **`t_ge_of_crit`** in `lean/HamiltonsCubic/Results/SecondKindE.lean` (Gate 2 [r1861](REVIEW_r1861.md)): at a unit critical point with $\theta\ge\theta_0>0$, $\theta^2\le\tfrac32+\theta E$ and $E\le ct$ with $c>0$ give $t\ge(\theta_0-\tfrac3{2\theta_0})/c$; with `E_le_tmax`, $c=\tfrac32\sqrt{2(n-1)/n}$ and $t=t_{\max}$.
- **R53's dichotomy** (`dichotomy` and `balanced_threshold` in `lean/HamiltonsCubic/Results/ProductFoothold.lean`, Gate 2 r1816, r1817): in a frame maximising the diagonal mass, with $W=A+B$, $t=\lVert A\rVert$, $A=te$, $e$ a unit sphere-product Weyl tensor with $Q(e)=de$, the coupling bound $a\le t\,c_*\,b^2$ and $d\le\rho$ give $b=0$ or $t\le c_*/(d-c_*)$, and at the balanced product $c_*=d/(m-1)$ makes this $1/(m-2)=2/(n-4)$. The coupling bound itself is untyped and argued in reviews/2026-09-28-I121-MG-audit.md.
- **`average_beats_threshold`** in the same file: $4/(n-4)^2<6/((n+1)(n+2))$ at $n\ge30$.

## Items

1. **Statement fidelity.** Is `threshold_beats_balanced` in `lean/HamiltonsCubic/Results/SecondKindBalanced.lean` (commit `ab255352`) the claim "$t\ge(\theta_0-3/(2\theta_0))/c$ implies $2/(n-4)<t$ at $n=26,28$" with $\theta_0^2=2(n-1)(n-2)/n^2$ and $c$ as above? Is `eps_sq` right?
2. **The chain.** Does the block's conclusion ("at even $n\ge26$ a global maximiser with a balanced-product diagonal part is diagonal") follow from the givens: $t$ in R53 is $t_{\max}$, a global maximiser has $\rho=\theta\ge\theta_0=d$, and $n\ge30$ is covered by the average? Name any hypothesis the prose uses that the givens do not supply (unit norm, the frame being globally maximal, $m\ge3$).
3. **Numbers.** Check the four quoted values and the $n=24$ failure with one line of Python.
4. **Axioms.** `#print axioms threshold_beats_balanced` if the toolchain is free (run from `lean/` on a scratch file outside `lean/HamiltonsCubic/`, after `pgrep -f '\.elan/toolchains/[^ ]*/bin/(lake (build|env|exe)|lean /)'` returns nothing, in the background); otherwise run `python3 scripts/misc/axiom_audit.py --only SecondKindBalanced` the same way.

## Lean table

| claim | declaration |
|---|---|
| $\varepsilon^2=(\theta_0^2-3/2)^2/\theta_0^2$ | `eps_sq` |
| the threshold exceeds $2/(n-4)$ at $n=26,28$ | `threshold_beats_balanced` |
| R53's dichotomy | `dichotomy`, `balanced_threshold` (ProductFoothold.lean) |
| R53's coupling bound | none: untyped, argued in the MG audit note, Gate 2 r1816, r1817 |
| $n\ge30$ | `average_beats_threshold` |
