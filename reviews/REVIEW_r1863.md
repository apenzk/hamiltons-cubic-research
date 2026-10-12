# Gate 2 review r1863: the balanced-product corollary of the second-kind threshold (I121)

Brief: [BRIEF_I121_balanced26.md](BRIEF_I121_balanced26.md). Note: [2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md), the bullet "One consequence at the balanced product". Lean: [SecondKindBalanced.lean](../lean/HamiltonsCubic/Results/SecondKindBalanced.lean) at HEAD 78fc91b2 (last changed in ab255352). Log: [agent_logs/r1863-i121-balanced26.log](../agent_logs/r1863-i121-balanced26.log). Footing: analysis only. The one computation is item 3's arithmetic, and item 4 is a `#print axioms` on a scratch file.

**Verdict: the Lean is the claim, the numbers are right, and the conclusion follows from the givens once two hypotheses the bullet leaves implicit are written in: the frame is the globally maximal one, and the diagonal part is a positive multiple of the balanced product.**

| item | claim | verdict |
|---|---|---|
| 1 | statement fidelity, `threshold_beats_balanced` and `eps_sq` | CONFIRMED |
| 2 | the chain to "at even $n\ge26$ ... is diagonal" | CONFIRMED conditionally on R53's untyped coupling bound, with two hypothesis corrections (C1, C2) |
| 3 | the four quoted values and the $n=24$ failure | CONFIRMED |
| 4 | axioms | CONFIRMED, standard three only |

## Item 1, statement fidelity: CONFIRMED

- `eps_sq`: $\theta_0-\tfrac3{2\theta_0}=\tfrac{\theta_0^2-3/2}{\theta_0}$, so its square is $(\theta_0^2-\tfrac32)^2/\theta_0^2$. The hypothesis $0<\theta_0$ supplies the nonzero denominator `field_simp` needs. Correct.
- `threshold_beats_balanced (n θ₀ t : ℝ)`: hypotheses $n\in\{26,28\}$, $0<\theta_0$, $\theta_0^2=2(n-1)(n-2)/n^2$, and $(\theta_0-3/(2\theta_0))/(\tfrac32\sqrt{2((n-1)/n)})\le t$. Conclusion $2/(n-4)<t$. This is the brief's claim word for word. The constant $c$ is written in exactly the form `E_le_tmax` produces, $\tfrac32\sqrt{2\cdot((n-1)/n)}$ with $n$ the frame cardinality, so `t_ge_of_crit` feeds it with no rewriting.
- $\theta_0^2=2(n-1)(n-2)/n^2$ is the record's $\theta_0(n)$: it gives $1.146$ at $n=8$ and $1.236$ at $n=12$, the values the note quotes.
- The proof squares both sides: `hsqb` computes $(\varepsilon/c)^2=\varepsilon^2/(\tfrac94\cdot2(n-1)/n)=\tfrac29\tfrac n{n-1}\varepsilon^2$, the note's squared threshold, `hkey` is the rational comparison at each $n$ by `norm_num`, `hnum` shows $\varepsilon\ge0$ from $\theta_0^2\ge\tfrac32$, and `lt_of_pow_lt_pow_left₀` returns to the unsquared inequality with the bound nonnegative. Each step is sound. The hypotheses are satisfiable (take $t$ large), so the statement is not vacuous.
- The identification $2/(n-4)=c_*/(d-c_*)$ at $m=n/2$ is `balanced_threshold` at $m=13,14$ ($1/(m-2)=2/(n-4)$), outside this file, as the docstring says.

## Item 2, the chain: CONFIRMED conditionally, two corrections

The chain, link by link, at a unit global maximiser $W$ of $P$ at even $n=2m$:

1. **Value.** $\rho=\theta=P(W)=\Theta_n\ge P(e)=d=\theta_0(n)$, the balanced product's value. This supplies both `dichotomy`'s $d\le\rho$ and `t_ge_of_crit`'s $\theta_0\le\theta$, and $\theta_0>0$.
2. **The second-kind threshold.** A global maximiser is a unit critical point, so `crit_E_bound'` gives $\theta^2\le\tfrac32+\theta E$. `E_le_tmax` at $t=t_{\max}(W)$ and $\lVert W\rVert=1$ gives $E\le c\,t_{\max}$. `t_ge_of_crit` gives $t_{\max}\ge\varepsilon_n/c$.
3. **R53.** In a frame maximising the diagonal mass, $A=te$, $t=\lVert A\rVert$, $t^2+b^2=1$, L214's relation, and the coupling bound $a\le tc_*b^2$ with $c_*=d/(m-1)<d$ (needs $m>2$) give $b=0$ or $t\le c_*/(d-c_*)=2/(n-4)$.
4. **Joining 2 and 3** needs R53's $t$ to equal $t_{\max}$. With $\lVert A\rVert^2=\sum_{p<q}K_{pq}^2$ (the diagonal part of $M$ on $\Lambda^2$, Weyl because the row sums $\sum_qK_{pq}$ are Ricci entries and vanish), this holds exactly when the frame is **globally** maximal. Then $t=t_{\max}>2/(n-4)$ at $n=26,28$ by item 1, and at $n\ge30$ by $t_{\max}^2\ge6/((n+1)(n+2))>4/(n-4)^2$ (the $O(n)$ average bounds the maximum, `average_beats_threshold`). The second branch is excluded and $b=0$.

Hypotheses the bullet uses, against what the givens supply:

| hypothesis | status |
|---|---|
| unit norm | supplied: `dichotomy` has $t^2+b^2=1$, `E_le_tmax` is used at $\lVert W\rVert^2=1$, and $\theta$ is the unit value in both |
| globally maximal frame | **used and load-bearing**. [r1816](REVIEW_r1816.md) O2 records that R53's coupling bound needs only a locally maximal frame, but a local maximum has $\lVert A\rVert\le t_{\max}$, which is the wrong direction for step 4. The bullet's first sentence says "maximal-frame", which the note's line 7 fixes as global, and its closing sentence drops the qualifier (C1) |
| $m\ge3$ | supplied: $m=13,14$ here and $m\ge15$ from $n=30$. `balanced_threshold` and $c_*<d$ need $m>2$, and r1816's content condition $(p-2)(q-2)\ge2$ holds |
| sign of the diagonal part | **implicit**. R53 has $A=te$ with $t>0$ and $e$ the unit sphere-product tensor with $Q(e)=de$, $d>0$. A negative multiple of the balanced product gives $e=-e_{\mathrm{prod}}$, $Q(e)=-de$, and the dichotomy's $c<d$ fails. "Proportional" has to read "a positive multiple" (C2) |
| the coupling bound | untyped, stated as such in the bullet, the Lean docstring and the brief's table |
| $t>0$ | supplied by the diagonal part being a nonzero multiple |

With C1 and C2 written in, the conclusion follows, and it is sharper than stated: $b=0$ and $t=1$ make $W$ equal to the balanced product in that frame.

## Item 3, numbers: CONFIRMED

One line of Python on $\theta_0^2=2(n-1)(n-2)/n^2$, $\varepsilon=\theta_0-3/(2\theta_0)$:

| $n$ | $\tfrac29\tfrac n{n-1}\varepsilon_n^2$ | $\tfrac4{(n-4)^2}$ | $\tfrac6{(n+1)(n+2)}$ |
|---|---|---|---|
| 24 | 0.00871 | 0.01000 | 0.00923 |
| 26 | 0.00986 | 0.00826 | 0.00794 |
| 28 | 0.01088 | 0.00694 | 0.00690 |
| 30 | 0.01181 | 0.00592 | 0.00605 |

All four quoted values and the $n=24$ shortfall agree to the digits given. The last column confirms the split the bullet draws: the average fails at $n=28$ by $0.00004$ and clears from $n=30$, and the new threshold covers $26$ and $28$. At $n=24$ both lower bounds fall short of $0.01$, so $n=24$ stays open by either route.

## Item 4, axioms: CONFIRMED

The toolchain was free (`pgrep` returned nothing). `lake env lean` on a scratch file in `lean/` importing the module, run in the background, printed for both `threshold_beats_balanced` and `eps_sq`: `[propext, Classical.choice, Quot.sound]`, exit code 0. No `sorryAx` and no project axiom.

## Corrections for the author

- **C1.** In the bullet's closing sentence write "a global maximiser whose globally maximal frame has a balanced-product diagonal part", since joining R53's $t$ to $t_{\max}$ needs the global maximum, where R53 alone needs only a local one.
- **C2.** Replace "proportional to the balanced product" by "a positive multiple of the balanced product", the sign R53's $Q(e)=de$ with $d>0$ requires.
- **C3 (optional).** The conclusion can read "is the balanced product", since $b=0$ at unit norm gives $W=e$.
