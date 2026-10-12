# Step 9 literature sweep, 2026-09-26e: the open statement, after D13

Works from [the position file](2026-09-26e-step8-position.md).

## Batch 1: partial-transpose moments (a field no sweep has read)

**The realigned space is a partial-transpose class.** *$\iota(\operatorname{Sym}^2\mathfrak{so}(n))$ is exactly the set of symmetric operators $Z$ on $\mathbb R^n\otimes\mathbb R^n$ with $SZS=Z$ and $Z^\Gamma=-Z$ (batch 30; the skew-by-skew tensors are the $\Gamma$-odd ones, and swap-invariance is the symmetry of $X$). So H is a moment problem: maximise $\operatorname{tr}Z^3/(\operatorname{tr}Z^2)^{3/2}$ over symmetric, swap-invariant, partial-transpose-odd operators, with the value $\tfrac{n-2}{4\sqrt N}$ at $Z_0=|\Phi\rangle\langle\Phi|-S$, the antisymmetric Werner operator's realignment.*

- *PT-moment entanglement tests* ([Yu–Imai–Gühne 2021](https://arxiv.org/pdf/2103.06897), the $p_3$-PPT criterion, [a 2025 closed form](https://arxiv.org/html/2503.17525), [realignment moments](https://arxiv.org/pdf/2507.13840)): they bound $p_3=\operatorname{tr}(\rho^\Gamma)^3$ **from below** for PPT states and characterise the PPT region of $(p_2,p_3)$. **H needs an upper bound for a $\Gamma$-odd operator**, which none of them states.
- *Rana's bound* ($\operatorname{spec}\rho^\Gamma\subset[-\tfrac12,1]$ for every state) is the same Schmidt-coefficient mechanism as batch 30's $\Gamma$-cap, and like it binds one eigenvalue at a time.
- **Searched, nothing found** for third moments of operators odd under partial transpose, or for moment inequalities restricted to the swap-invariant sector.

## Phase 3: candidates for the open statement

| route | closes | attackable | margin | analytic | value | reach toward the open statement |
|---|---|---|---|---|---|---|
| **I117, the sharp $\#$ half of P, as the $\Gamma$-odd moment problem on $\iota(\mathrm{Weyl}\oplus\mathbb RI)$** | 2 | 2 | 1 | 1 | **4** | a sharp half of P at every even $n$ (the balanced product maximises $\langle W\#W,W\rangle$); the open statement then needs the trade against $\operatorname{tr}W^3$ |
| R43: H as the moment problem on all $\Gamma$-odd swap-invariant operators | 2 | 1 | 1 | 1 | 2 | I114 and the same sharp half; the extremal set (every involutive automorphism) is larger, so harder |
| I1, I7, I37: the open statement directly | 3 | 0 | 1 | 1 | 0 | the goal, no method |

**No candidate reaches the open statement with a method.** *The reach gate fires; the choice is recorded as [D14](../DECISIONS-TO-MAKE.md).*
