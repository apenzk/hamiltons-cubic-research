# r1067: Gate 2 on "I111 CLOSES: the norm constraint pins $u$ to $u_{\mathrm{lo}}$ exactly, at every $s$"

Target: the last section of [2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), dated 2026-09-22, with [I111Branch.lean](../lean/HamiltonsCubic/Results/I111Branch.lean).

Log: [agent_logs/r1067-i111-closure.log](../agent_logs/r1067-i111-closure.log)

**VERDICT: THE PINNING IS AN IDENTITY IN $\tau$, NOT IN $s$.** The window in $u$ that the section claims to empty has width exactly the slack in the product bound on $\tau$, so it collapses to a point precisely when $\tau=\tfrac12 s^3$ and at no other configuration. The section assumes that value in its first line and then reports the conclusion as holding "at every surviving configuration", while the same file records two sections earlier that $\tau$ runs down to $0.891690$ of its bound on that set.

| claim | verdict |
|---|---|
| K1, $\cos2\beta=u_{\mathrm{lo}}/u$ | CONFIRMED at $\tau=\tfrac12 s^3$, and the general form is $\cos2\beta=(\theta-2\tau/N)/(\sqrt3u)$ |
| K2, the norm expansion | CONFIRMED |
| K3, the cancellation | CONFIRMED |
| K4 (i) $g'=6u>0$ | CONFIRMED |
| K4 (ii) $g(u_{\mathrm{lo}})=N$ | REFUTED as an identity in $s$: the general value is $f^2N$ with $f=2\tau/s^3$ |
| K4 (iii) $g\le N$ from G7 | CONFIRMED, and the two-space worry is in the safe direction |
| K5, $u=u_{\mathrm{lo}}$ exactly | REFUTED as stated, CONFIRMED on the $\tau$-saturated locus alone |
| K6, the shape is forced throughout | REFUTED, it is forced exactly where $\tau$ saturates |
| K7, $\min_s\text{gain}/d$ | the ratio is $1.2968015$, the section prints $1.296955$; the minimiser is the endpoint $s_*$, CONFIRMED; "I104 closes" REFUTED |
| K8, $(x/u)^2$ at the Gram boundary | CONFIRMED |
| Lean vs prose | the four typed statements are algebra in free variables and assume the load-bearing hypothesis |
| vacuity | the $\tau$-saturated slice is non-vacuous, so K7 is true and narrow rather than true and empty |

## Finding 1, DECISIVE: the $u$-window's width IS the product-bound slack, exactly

**The two inequalities K5 plays against each other are one equation read twice, and their gap has a closed form the section did not compute.** Carry $\tau$ as a free variable through G6 instead of substituting $\tfrac12s^3$ at the first step.

G6 gives $\langle L_{q_a}\nu_a,\nu_a\rangle=\tfrac\theta2N_a-\tau$, so with $e_a=\tfrac{\sqrt3}2u_a$ (G5),

$$\cos2\beta_a=\frac{\theta-2\tau/N_a}{\sqrt3\,u_a},\qquad g_a\;=\;\theta^2+4e_a^2-4\theta e_a\cos2\beta_a\;=\;3u_a^2-\theta^2+\frac{4\theta\tau}{N_a}.$$

K3's cancellation survives verbatim, which is why the section's algebra is right and its scope is not. The two constraints are then

$$\underbrace{3u_a^2\;\ge\;\Big(\theta-\tfrac{2\tau}{N_a}\Big)^2}_{\cos2\beta_a\le1,\ \text{criticality}},\qquad \underbrace{3u_a^2\;\le\;\frac{N_bN_c}{N_a}+\theta^2-\frac{4\theta\tau}{N_a}}_{g_a\le N_bN_c/N_a,\ \text{G7}},$$

and subtracting gives the width of the admissible interval in $3u_a^2$:

$$\boxed{\;\text{upper}-\text{lower}\;=\;\frac{N_aN_bN_c-4\tau^2}{N_a^2}\;}$$

verified symbolically. **That is the product bound $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$ written as a width.** It is non-negative by G7, it holds off the equal-$N_i$ diagonal as well as on it, and **it is zero if and only if $\tau$ attains the product bound.**

**So K5 proves what it assumed.** Setting $\tau=\tfrac12s^3$ at $N_a=s^2$ sets the width to zero by hand, and the pinning is the arithmetic of that substitution rather than a consequence of the norm constraint.

**On the equal diagonal, write $\tau=f\cdot\tfrac12s^3$ as the file's own earlier section does.** Then $u_{\mathrm{lo}}(f)=(\theta-fs)/\sqrt3$, $g(u_{\mathrm{lo}}(f))=(\theta-\sqrt3u_{\mathrm{lo}}(f))^2=f^2s^2=f^2N$, and

$$u^2\;\in\;\Big[u_{\mathrm{lo}}(f)^2,\;u_{\mathrm{lo}}(f)^2+\tfrac13(1-f^2)s^2\Big].$$

**This is the file's own convention, not an imported one.** Reconstructing the chain function from the printed derivative and the printed $d(s,f)$ gives

$$F_\tau(u)=-\tfrac{\sqrt3}6u^3+\theta u^2-\frac{1-2s^2}{\sqrt3}u+\tau-\tfrac\theta2N,\qquad d(s,f)=-F_\tau\big(u_{\mathrm{lo}}(f)\big),$$

an exact symbolic match to the printed $d(s,f)=\tfrac{f(3-f^2)s^3}{18}+\tfrac{5fs}{12}-\tfrac{\sqrt6(1+f^2)s^2}{12}-\tfrac{\sqrt6}{24}$. So the file already carries the $f$-dependent $u_{\mathrm{lo}}$ inside its own deficit, and the closure section is the $f=1$ slice of it.

## Finding 2: the hole is a region, with the deficit still near its corner value

**The $f<1$ part of the surviving set is not thin.** Screening the file's own constraints, $d(s,f)>0$ together with Gram feasibility $u_{\mathrm{lo}}(f)^2\le\tfrac59t$:

| $f$ | largest Gram-feasible surviving $s$ | deficit there | $u$-window width |
|---|---|---|---|
| $1.00$ | $0.46765$ | $0.014873$ | $0$ |
| $0.99$ | $0.46530$ | $0.013558$ | $\approx0.0016$ |
| $0.98$ | $0.46310$ | $0.012246$ | $\approx0.0031$ |
| $0.95$ | $0.45610$ | $0.008194$ | $\approx0.0067$ |
| $0.92$ | $0.44890$ | $0.004025$ | $\approx0.0049$ |
| $0.892$ | $0.44205$ | $\approx0$ | $0$ |

The lowest surviving $f$ reproduces the file's $0.891690$ at $s=0.441973$ to three places, so the two computations agree on where the region ends. **At $f=0.98$ the deficit is $82\%$ of the corner's and the forcing is unavailable**, which is the state the closure claims cannot occur.

**One thing this does NOT touch: the corner itself.** At $s=s_*$ the Gram cap is $u^2\le\tfrac59t=u_{\mathrm{lo}}(1)^2$ while criticality needs $u\ge u_{\mathrm{lo}}(f)>u_{\mathrm{lo}}(1)$ for $f<1$, so $f=1$ is forced there. **[I110](../plan.md)'s exclusion of the corner stands in full.** What falls is its extension to the interior of the surviving range.

## Finding 3: the forcing is the thing that is lost, and it is lost all at once

**At $u=u_{\mathrm{lo}}(f)$ with $f<1$, condition 1 survives and condition 2 fails.** $\cos2\beta=1$ still holds, so $\nu_a$ is still $L_{q_a}$'s top eigenvector. But $\lVert2\nu_b\circ\nu_c\rVert^2=N\,g(u_{\mathrm{lo}}(f))=f^2N^2$, so the product bound sits at fraction $f$ and the equality case $a_1=a_2=0$, $\lvert b\rvert=\lvert c\rvert$ is not reached. **[I110](../plan.md)'s eigenvalue step needs both**: $B=C$ comes from the equality case alone, and without it $G$'s eigenvectors on $\mathbf1^\perp$ are not $(0,1,-1)$ and $(2,-1,-1)$, so nothing forces $q_a\propto(-2,1,1)$ and nothing licenses the gain $\tfrac1{2\sqrt3}u(t-u^2)$.

**The error is the one the same file names two sections earlier.** $\partial d/\partial f\ge0.0958$ across the region, screened, so $f=1$ maximises the deficit and the earlier worst-case analysis was right to take it. The closure then reads the FORCING off that same maximiser. That is reading a rigidity off a relaxation's argmin, which the file's own I110 section calls out: *"a statement about the RELAXATION's argmin, and the argmin is the infeasible point"*. Here the direction is the mirror image and the cost is the same: the deficit is worst at $f=1$ and the gain exists only at $f=1$, so the two cannot be minimised and maximised at the same point and then compared.

## Finding 4: K7's constant is wrong in the fifth figure

At $s_*$, with $u=u_{\mathrm{lo}}$ and $t=\tfrac23-\tfrac{\sqrt{15}}{12}$, thirty-digit arithmetic gives

$$\text{gain}=\tfrac1{2\sqrt3}u(t-u^2)=0.0192873725521452,\qquad d=\tfrac{11\sqrt{10}}{486}-\tfrac{5\sqrt6}{216}=0.0148730342706614,\qquad \frac{\text{gain}}{d}=1.29680145968544.$$

**The section prints $1.296955$**, and prints it twice. The section's own two numerators, $0.0192874$ and $0.0148730$, divide to $1.29680$, so the discrepancy is in the quoted ratio rather than in the quantities. The minimiser is CONFIRMED to be the right endpoint $s_*$: the ratio decreases monotonically in $s$ across $(0.358719,s_*]$, screened at $4\times10^5$ points, so there is no interior minimum. The "$30\%$ margin" reading is unaffected.

## Finding 5: the two-space worry in K4 (iii) is in the safe direction, and G2 is fine

**G7 bounds a norm in the three-dimensional four-set space while the left side lies in the two-dimensional Bianchi plane, and that costs nothing here.** The block equation asserts the two vectors are equal, so their full-space norms agree, and the bound $\lVert2\nu_b\circ\nu_c\rVert^2\le N_bN_c$ applies to the common value. A bound over a larger space is weaker, so K4 (iii) is valid as used.

**Nor is there an unnoticed out-of-plane equation.** [L221 step 1](../findings/second-order.md) establishes $\mathcal S=\mathcal D_n\oplus V_{Q_1}\oplus V_{Q_2}\oplus V_{Q_3}$ as a SUBALGEBRA under $\circ$, with each $V_{Q_i}$ already the Bianchi plane, so $\nu_b\circ\nu_c\in V_{Q_a}$ by construction. G2's count of six scalar equations is right and the configuration set is not empty for that reason. **This attack line is closed.**

**And the equality case is reachable inside the plane**, which the file establishes independently: $a_1=a_2=0$ forces $\lvert b\rvert=\lvert c\rvert$ under $a+b+c=0$, and the corrected-sign maximisation gives $\max\lvert\tau\rvert/\sqrt{S_1S_2S_3}=\sqrt2$ on the Bianchi planes. So $g\le N$ is not strict for a hidden reason, and the alternative exit ("the set is empty because G7 is lossy under Bianchi") is NOT available.

## Finding 6: K1's sign and branch are sound

**$\cos2\beta$ comes out positive by derivation rather than by choice.** $\langle L_q\nu,\nu\rangle=\tfrac\theta2N-\tau=\tfrac{s^2}2(\theta-fs)>0$ on the surviving range, since $\theta=1.224745>s\ge fs$, so $\nu$ is nearer $f_+$ as a consequence. With $e=\tfrac{\sqrt3}2u\ge0$ fixing $f_+$ as the top eigenvector (G5, an identity), there is no branch to choose. **The one blemish is notational**: K1 writes $\nu=\cos\beta f_++\sin\beta f_-$, a unit vector, then pairs it to get $e\cos2\beta\,N$, which needs $\nu=\sqrt N(\cos\beta f_++\sin\beta f_-)$. K2's left side is divided by $N$, so the two readings are consistent and the results are right.

## Finding 7: what the Lean file proves is strictly less than what the prose claims

| declaration | statement | what it leaves out |
|---|---|---|
| [norm_expand](../lean/HamiltonsCubic/Results/I111Branch.lean) | $(\theta-2e)^2c^2+(\theta+2e)^2s^2=\theta^2+4e^2-4\theta e(c^2-s^2)$ under $c^2+s^2=1$ | nothing, K2 is fully typed |
| [g_closed_form](../lean/HamiltonsCubic/Results/I111Branch.lean) | an identity in four free reals $\theta,u,L,r_3$ | that $L=u_{\mathrm{lo}}$, which is K1, the $\tau$-dependent step and the one under attack |
| [g_at_uLo](../lean/HamiltonsCubic/Results/I111Branch.lean) | $\theta^2+3L^2-2r_3\theta L=(\theta-r_3L)^2$ | the identification of $(\theta-\sqrt3u_{\mathrm{lo}})^2$ with $N$, which runs through [coeff_at_uLo](../lean/HamiltonsCubic/Results/I110Deficit.lean) |
| [u_eq_uLo](../lean/HamiltonsCubic/Results/I111Branch.lean) | from `hbound : θ² + 3u² - 2r₃θL ≤ (θ - r₃L)²` and $L\le u$, conclude $u=L$ | everything: `hbound` IS the conjunction of G7 with K4 (ii), assumed |

**`u_eq_uLo` is a monotonicity lemma, not I111.** Read as stated it says a strictly increasing function bounded by its value at $L$ cannot be evaluated above $L$. The mathematics of the claim is entirely in `hbound`, and `hbound` is exactly where $\tau=\tfrac12s^3$ hides: replacing $N$ by its true value $f^2N$ on the right makes the hypothesis false for every $u>u_{\mathrm{lo}}(f)$ in the window of Finding 1.

**And [coeff_at_uLo](../lean/HamiltonsCubic/Results/I110Deficit.lean) hardwires the same assumption.** [I110Deficit.lean](../lean/HamiltonsCubic/Results/I110Deficit.lean) defines `uLo s = (theta - s) / Real.sqrt 3`, which is $u_{\mathrm{lo}}(f)$ at $f=1$ and nothing else, so `theta - Real.sqrt 3 * uLo s = s` is the $\tau$-saturated slice of $\theta-\sqrt3u_{\mathrm{lo}}(f)=fs$. **The typed layer is correct as far as it goes, and it stops one step short of the claim the prose draws from it.**

**The file compiles clean**: `lake env lean HamiltonsCubic/Results/I111Branch.lean` returns with no output, so every one of the six declarations is proved as stated. The defect is in the statements, not the proofs.

K8's two declarations, [ratio_sq](../lean/HamiltonsCubic/Results/I111Branch.lean) and [ratio_sq_at_gram](../lean/HamiltonsCubic/Results/I111Branch.lean), are CONFIRMED: $(3u^2-t)/(3.6u^2)=\tfrac56-\tfrac{5t}{18u^2}$ and at $u^2=\tfrac59t$ that is $\tfrac12$ subtracted from $\tfrac56$, namely $\tfrac13$. The file's own header states the scope honestly.

## Finding 8: vacuity, checked and cleared

**The $f=1$ locus is non-empty and the conclusion drawn on it is not trivially true.** At $f=1$ and $u=u_{\mathrm{lo}}$ the Gram condition $\tfrac95u_{\mathrm{lo}}^2\le t$ holds for every $s\le s_*$, with equality only at $s_*$, so configurations exist to be excluded and K7's comparison has content. **One scoping correction: the SECOND exclusion is corner-only.** [r1063](REVIEW_r1063.md)'s uniqueness of $D$ rests on $\tfrac95u_{\mathrm{lo}}^2=t$, which is the Gram-boundary identity and holds at $s_*$ alone, so the $P(D)$ route does not travel with the $P(q_i)$ route. Off the corner the exclusion is reached once, not twice, and the section's "reached twice" should not be carried along with "throughout".

## Corrections to make

1. **Retitle and rescope the section.** It establishes: *the pinning $u=u_{\mathrm{lo}}$ holds exactly on the locus where $\tau$ attains its product bound, and the width of the admissible $u$-interval is the product-bound slack.* Both halves are stronger than what is written, because the width identity $(N_aN_bN_c-4\tau^2)/N_a^2$ needs neither the equal-$N_i$ diagonal nor $\theta^2=\tfrac32$.
2. **Withdraw "I104's $\tau>0$ case is closed on the equal-$N_i$ diagonal."** What is closed is the $\tau$-saturated slice of it. The open part is $f\in[0.891690,1)$, carrying deficits up to $0.0122$ at $f=0.98$.
3. **Correct $1.296955$ to $1.2968015$**, here and in the preceding section.
4. **Record that the second exclusion is corner-only**, per Finding 8.
5. **Type the width identity rather than `u_eq_uLo`.** $3u^2$ bounded below by $(\theta-2\tau/N)^2$ and above by $N_bN_c/N_a+\theta^2-4\theta\tau/N_a$ with the difference $(N_aN_bN_c-4\tau^2)/N_a^2$ is one `ring`-level statement in free variables, and unlike `u_eq_uLo` it says something that is false if the mathematics is wrong.

## Reach

**What survives.** K2, K3, K4 (i), K4 (iii), K8 and the whole of the typed layer are correct. K1 is correct and generalises. [I110](../plan.md)'s exclusion of the corner is untouched and is now supported by a second route: at $s_*$ the Gram cap forces $\tau$ to its product bound, which is why the forcing needed no extra argument there.

**What falls.** The extension of the forcing off the corner, and with it the claimed closure of I104's $\tau>0$ case on the equal-$N_i$ diagonal. The preceding section's framing, *"what I111 actually owes is the pinning slack in $u$"*, is REINSTATED and sharpened: the slack in $u$ is the slack in $\tau$, so I111's question is a question about one scalar rather than two.

**What the programme gains.** I111 now has a single closed-form handle. The item is: **does the forced shape persist under a product-bound slack of $1-f$, for $f\in[0.891690,1)$?** Two routes are visible and neither needs a sweep.

- **A stability version of [I110](../plan.md)'s eigenvalue step.** $\lVert\nu_b\circ\nu_c\rVert=\tfrac f2\sqrt{N_bN_c}$ puts $\nu_b,\nu_c$ within a computable angle of the equality case, $B-C$ is then $O(\sqrt{1-f})$ rather than zero, and $q_a$'s shape moves off $(-2,1,1)$ by the same order. The margin to spend is $23\%$ of the gain, so the question is whether the shape factor $\tfrac1{\sqrt3}-\max(x,y,z)$ loses less than $0.0664$ from $\tfrac1{2\sqrt3}$ over $f\ge0.891690$. That is a perturbation bound on a $3\times3$ symmetric matrix and it is analysis, not computation.
- **Eliminating $f$ against Gram.** Feasibility needs $3(\theta-fs)^2\le5(1-3s^2)$, which is increasing in $f$, while the deficit $d(s,f)$ is also increasing in $f$ at rate at least $0.0958$. The two pull the same way, and the region they leave is bounded by two explicit curves meeting at $(s,f)=(0.441973,0.891690)$. **If the shape-stability loss can be bounded by anything increasing in $1-f$ faster than $d$ decreases, the region closes by a one-variable argument on its boundary.** That is worth attempting before anything numerical.

**What would refute this review.** An argument from the block equations that forces $\tau$ to its product bound at every critical point, which would restore the section as written. This review found none: pairing the $\chi_{Q_a}$ equation with $\nu_a$ and substituting G6 returns $\tau=\tau$, so the system offers no such forcing at the level at which it has been used here.

**Standing rule observed.** Every number above is a screen on objects already in hand, seconds of arithmetic, reported as a screen. The two symbolic identities, the width formula and the reconstruction of $F_\tau$, are exact and are the load-bearing results. No sweep, census or hunt was run.
