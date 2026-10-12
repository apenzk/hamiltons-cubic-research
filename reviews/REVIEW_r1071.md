# Gate 2 review r1071: the pinning/tau trade-off identity (I111, posts F74-F75)

Log: [agent_logs/r1071-tradeoff.log](../agent_logs/r1071-tradeoff.log)

Targets: [reviews/2026-09-14-I104-tau-positive.md](2026-09-14-I104-tau-positive.md), section "THE PINNING SUM AND $\tau$ TRADE OFF EXACTLY"; [findings/fence-posts.md](../findings/fence-posts.md) posts F74 and F75; [lean/HamiltonsCubic/Results/I111Tradeoff.lean](../lean/HamiltonsCubic/Results/I111Tradeoff.lean).

| claim | statement | verdict |
|---|---|---|
| C1 | $a=\sum_ag_a$, $P(N)=6\tau$ | **CONFIRMED**, with three hypotheses to name |
| C2 | $\sum_ag_a+3\tau=\tfrac12\theta(1-t)$ | **CONFIRMED**, and it is [L221](../findings/second-order.md) item 2 summed |
| C3 | the identity reproduces $u\ge u_{\mathrm{lo}}(f)$ and excludes nothing on the diagonal | **CONFIRMED** in substance, **REFUTED** in its step names |
| C4 | $P(D)=\tfrac32\theta t-\tfrac\theta2+3\tau$ | **CONFIRMED**, reproduces $0.172852844$ |
| C5 (F74) | $58.1/41.4/10.3\\%$ at $n=6,7,8$ and nothing at $n\ge9$ | **REFUTED**: the floor on $f$ is the wrong one, and corrected shares reach $n=10$ |
| C6 (F75) | the $\mathcal D_n$ scalar shadow is redundant, and the perpendicular equations collapse | **CONFIRMED** with a missing hypothesis / **PLAUSIBLE** as an ansatz |
| C7 | invertibility margin $0.2132$ at the Gram cap | **REFUTED**: the Gram cap lies outside the surviving $u$-interval, and $0.3587$ is right |

**The two findings that matter.** *[Post F74](../findings/fence-posts.md)'s exclusion table is computed at a floor the file's own surviving-set table contradicts, and the route reaches $n=10$ rather than $n=8$. The $0.13\\%$ shortfall at $n=11$ is real rather than manufactured.* **And [post F75](../findings/fence-posts.md)'s correction of $0.3587$ to $0.2132$ runs the same way round as the error it corrects**, evaluating at a $u$ the chain has already excluded.

## C1, the two collapses: CONFIRMED, and the hypotheses are three

Re-derived from the definitions. $a=\langle D\circ N,N\rangle=\sum_{a,b}T(D,\nu_a,\nu_b)$, and $P(N)=\sum_{a,b,c}T(\nu_a,\nu_b,\nu_c)$.

- **The cross terms of $a$ die because $\nu_a\circ\nu_b$ carries the character $\chi_{Q_a}\chi_{Q_b}\ne1$**, so it lies in a nontrivial isotypic component and pairs to zero against $\mathcal D_n$. *The hypothesis is that $\circ$ is $\Gamma$-equivariant and the three blocks are distinct, nothing more.* **The section states the stronger $\nu_a\circ\nu_b\in V_{Q_c}$**, which additionally needs $Q_a\triangle Q_b=Q_c$, the cyclic configuration's own hypothesis. *That stronger form is false for disjoint blocks, where [L221](../findings/second-order.md)(a) gives $\nu_a\circ\nu_b=0$ instead, and both routes reach the same vanishing.*
- **The diagonal terms need $\nu_a\circ\nu_a\in\Pi_{Q_a}$**, which is [L220](../findings/second-order.md) step 2's support argument run on one block. *It survives the overlaps untouched, since it quantifies over $\nu_a$ alone, and it is what lets [L220](../findings/second-order.md) step 4 read $T(D,\nu_a,\nu_a)$ as $\langle L_{q_a}\nu_a,\nu_a\rangle$ with $q_a$ the orthogonal projection of $D$ on $\Pi_{Q_a}$.*
- **$P(N)=6\tau$ needs the same containment plus $\mathcal D_n\perp V_{Q_b}$**: $\nu_a\circ\nu_a\in\mathcal D_n$ kills the three $P(\nu_a)$ and the six $T(\nu_a,\nu_a,\nu_b)$ at once, and full symmetry makes the remaining six terms $\tau$ each.

**Nothing in either collapse uses the four-set geometry beyond character bookkeeping**, which is what the Lean file says and is correct.

## C2: CONFIRMED, and it is the per-block identity summed

$\langle L_{q_a}\nu_a,\nu_a\rangle=\tfrac\theta2N_a-\tau$ is [L221](../findings/second-order.md) item 2, from pairing the $\chi_{Q_a}$ equation with $\nu_a$. Summing over $a$ with $\sum_aN_a=1-t$ gives the boxed line directly, so the identity carries no information the record lacked.

**Read the other way it is a genuine consistency check**, since the same line arrives from [second-order.md](../findings/second-order.md)'s $\theta(1-t)=2a+P(N)$ through C1's two collapses, and the two routes share no step. *The inputs it does need and the section does not name: the three blocks mutually orthogonal, and $W$ having no component outside $\mathcal S$.*

## C3: the ceiling is a real bound, and its step names are wrong

**The brief's worry is unfounded.** *[L220](../findings/second-order.md) step 5 makes $e=\tfrac{\sqrt3}2u$ an identity for the top eigenvalue, because $L_q$ restricted to the Bianchi plane is traceless with eigenvalues $\pm\tfrac12\sqrt E$ and $E=3\lVert q\rVert^2$.* **An identity for the top eigenvalue is exactly what makes $\langle L_{q_a}\nu_a,\nu_a\rangle\le\tfrac{\sqrt3}2u_aN_a$ a bound**, by Rayleigh, with equality iff $\nu_a$ is the top eigenvector. *In [L220](../findings/second-order.md)'s single-block setting criticality forces that alignment, and with three blocks it does not, which is the whole content of the pinning inequality.*

**So the arithmetic stands.** $g_a=\tfrac\theta2N-\tau=\tfrac12N(\theta-fs)=\tfrac{\sqrt3}2Nu_{\mathrm{lo}}(f)$, reproducing [r1062](REVIEW_r1062.md)'s $0.082786343$ at the corner to every recorded digit, and $g_a\le\tfrac{\sqrt3}2uN$ is $u\ge u_{\mathrm{lo}}(f)$ with no loss in either direction. **The conclusion that the identity yields no new exclusion on the equal-$N_i$ diagonal is correct.**

**TWO NAMING DEFECTS, BOTH INSIDE THE FILE THAT OWNS THE VOCABULARY.**

- **"Step 7's ceiling $g_a\le\tfrac{\sqrt3}2uN$" names the wrong step.** *[L220](../findings/second-order.md) step 7 is $P(q)=18xyz\le\tfrac{\sqrt3}2\lVert q\rVert^3$, which [this file's own table](2026-09-14-I104-tau-positive.md) lists as "step 7, $18xyz$". The pinning ceiling is [L221](../findings/second-order.md) item 2 resting on [L220](../findings/second-order.md) step 5.* **The two carry the same constant $\tfrac{\sqrt3}2$**, which is why the substitution reads naturally and stays invisible.
- **"Step 8's ceiling on the cross term" names the wrong step twice over.** *[L220](../findings/second-order.md) step 8 is the coupling $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2$, a bound on $\langle L_qr,r\rangle$ and not on $\tau$. The ceiling on $\tau$ is the product bound $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$.*
- **And $g$ collides with itself.** *Four sections above, the same file writes $g_a=3u_a^2-\theta^2+4\theta\tau/N_a$, which at $u_{\mathrm{lo}}$ is $f^2N=0.218694$ at the corner against this section's $g_a=0.082786$.* **Same letter, same file, two quantities**, which is the second such collision the file carries after the $x_i$ one it already documents.

## The one vacuous check

**"Testing it against step 7's ceiling gives $u\ge u_{\mathrm{lo}}(f)$ EXACTLY ... checked at four points of the window, agreeing to machine precision."** *The two sides are the same algebraic statement divided by $\tfrac{\sqrt3}2N$, so the four-point check cannot fail at any point of any window and distinguishes nothing.* **The corner screen two paragraphs later is the opposite case and is worth its line**: $g_a=0.082786343$ and $P(D)=0.172852844$ are compared against figures [r1062](REVIEW_r1062.md) and the $\mathcal D_n$ equation recorded through other quantities, and both reproduce here.

## C4: CONFIRMED

$P(D)=\theta t-a=\theta t-\big(\tfrac\theta2(1-t)-3\tau\big)=\tfrac32\theta t-\tfrac\theta2+3\tau$. At the corner it gives $0.172852844$ against the $+0.172853$ the $\mathcal D_n$ equation was reported to require, and [r1069](REVIEW_r1069.md)'s $\theta t-\tfrac{3\theta}2N+3\tau$ returns the same sixteen digits on the diagonal. *The claim of shape-independence is right and is the substantive part: $P(D)$ is fixed by $(t,\tau)$ with $D$'s direction free.*

## C5, post F74: REFUTED, and the route reaches further than the post says

**The direction is right.** *Exclusion is "forced value exceeds the cap", so what governs is the minimum of $P(D)/t^{3/2}$ over the admissible $f$ at each $s$, and $P(D)$ is increasing in $f$, so the minimum sits at the floor.* **What is wrong is which floor.**

**The post floors $f$ at the Gram condition alone**, $f\ge(\theta-\sqrt{5t/3})/s$. *Reproducing its table that way returns $58.12$, $41.40$, $10.29$, $0$, $0$, $0$, $0$ at $n=6\ldots12$, matching all three printed figures, which identifies the computation.* **But a configuration is in the surviving set only if the chain also fails there**, $d(s,f)>0$, and [this file's own $(s,f)$ table](2026-09-14-I104-tau-positive.md) prints both floors side by side: at $s=0.35882$ Gram needs $f\ge0.594602$ while $d>0$ needs $f\ge0.999828$. *Points below the deficit floor are already excluded by the chain, so minimising across them understates the route.*

With $f_{\min}(s)=\max\big(f_{\mathrm{Gram}}(s),f_d(s)\big)$ over the window $s\in(0.358719,\,0.467647]$:

| $n$ | $6$ | $7$ | $8$ | $9$ | $10$ | $11$ | $12$ |
|---|---|---|---|---|---|---|---|
| $\Theta_n$ | $1.054093$ | $1.095445$ | $1.145644$ | $1.171080$ | $1.200000$ | $1.217161$ | $1.236033$ |
| share excluded, post F74's floor | $58.1\\%$ | $41.4\\%$ | $10.3\\%$ | $0$ | $0$ | $0$ | $0$ |
| share excluded, the surviving set's floor | $65.6\\%$ | $56.5\\%$ | $41.4\\%$ | $30.8\\%$ | $13.7\\%$ | $0$ | $0$ |

**So the route excludes $30.8\\%$ of the window at $n=9$ and $13.7\\%$ at $n=10$, where the post records nothing**, and the reach is $n\le10$ rather than $n\le8$. *Screened on the file's own closed forms for $d(s,f)$, $f_{\mathrm{Gram}}$ and $P(D)$, $200001$ points in $s$.* **[r1072](REVIEW_r1072.md) reached the same six shares independently on a cold brief**, to every printed digit. *And the two floors cross at $s=0.441973$, which is the file's own recorded root where $d=0$ meets the Gram boundary at $f=0.891690$, so the deficit floor is the binding one on the left $80\\%$ of the window.*

**AND THE $n=11$ NEAR-MISS IS REAL.** *The maximum of the forced ratio over the surviving set is $1.215586$, against $\Theta_{11}=1.217161$: a shortfall of $0.13\\%$, reached near the window's lower edge where $f_{\min}\to0.9998$ and the minimum and the maximum over $f$ coincide.* **The post attributes that figure to "reading the MAXIMUM instead", and it survives reading the minimum.** *Its reason, that the lower edge is "where the deficit vanishes and there is nothing left to close", describes a surviving set of width $1.7\times10^{-4}$ in $f$ and $2.9\times10^{-5}$ in $u$, which is thin and not empty, so a point there is unexcluded until something excludes it.*

**WHAT SURVIVES OF THE POST.** *The mechanism, the direction of the comparison, the demand that a successor state which $f$ it evaluates at, and the headline conclusion that the route cannot reach $n=11$.* **The margin behind that conclusion is $0.13\\%$ rather than the comfortable gap the table implies**, which is what a successor needs to know.

## C6, post F75

**The redundancy: CONFIRMED, with one hypothesis the post omits.** *Pairing $W\circ W=\theta W$ with $D$ gives $\theta t=P(D)+a$ and with $N$ gives $\theta(1-t)=2a+P(N)$, and their sum is $\theta=P(D)+3a+P(N)$.* **That sum is $P(W)=\theta$ only because $T(D,D,N)=0$**, the same character orthogonality C1 runs on, and the post's "given $P(W)=\theta$ and $\lVert W\rVert=1$" does not name it. *With it, either relation follows from the other, and the $\mathcal D_n$ equation's scalar shadow is no addition to the block equations.*

**One phrase is wrong.** *"The shadow that reads as an independent equation on top of the six is the sixth of them, resummed."* **It is the SUM of three of the six**, the block-parallel components, each block equation being two scalars on its two-dimensional $V_{Q_a}$. *And the redundancy reaches only the shadow: the $\mathcal D_n$ equation is a vector equation in a space of dimension $n(n-3)/2$, and its pairings against $q_a$ and against $r$ are untouched by this post. The post's heading scopes it correctly and its second sentence does not.*

**The collapse at $\psi_a\equiv0$: PLAUSIBLE, and it is an ansatz rather than a theorem.** *Equal shapes make the three perpendicular equations cyclically equivariant only together with equal $u_a$, which the $(s,f)$ parametrisation supplies and the post does not name, and an equivariant system may carry solutions its symmetry group moves.* **So "one equation in one unknown" holds inside the symmetric ansatz and says nothing about solutions outside it**, which is what the post writes, and the conclusion drawn from it, that a counting argument cannot exclude, holds either way. *The $\nu$-angles are the place the symmetry can break: they are fixed by the equations rather than by $\psi_a$, so the symmetric ansatz is a restriction on the solution and not a consequence of $\psi_a\equiv0$.* **And the post's "that configuration is invariant under the cyclic rotation of the blocks" reaches further than $\psi_a\equiv0$ licenses**, since the configuration includes $D$'s component outside $\bigcup_a\Pi_{Q_a}$, which the shape angles say nothing about and which the rotation must also fix. *The count survives that gap, because a cyclic ansatz is a restriction whichever way the ambient symmetry falls.*

## C7: REFUTED, and $0.3587$ is the right number

**$\theta-\sqrt3u$ is decreasing in $u$, so the worst case is the largest admissible $u$. That is not the Gram cap.** *The admissible interval on the equal-$N_i$ diagonal is $[u_{\mathrm{lo}}(f),\,u_{F=0}]$, since $F$ is increasing there and $F(u)\ge0$ is the chain closing, and [this file's own table](2026-09-14-I104-tau-positive.md) prints its width as at most $0.0247$.* **At $s=0.35882$ that interval is $[0.499942,\,0.499971]$ while the Gram cap is $0.583926$**, so [post F75](../findings/fence-posts.md)'s $u=0.584029$ sits where the chain has already closed.

Minimised over the surviving set, $\theta-\sqrt3u=0.358730$ at $s\to0.358719$, reproducing the $0.3587$ the post calls "the window's lower endpoint wearing the appearance of a margin".

**THE COINCIDENCE IS STRUCTURAL, NOT COSMETIC.** *At the window's lower edge the deficit pinches $f$ to $1$ and the $u$-interval to the single point $u_{\mathrm{lo}}$, and $\theta-\sqrt3u_{\mathrm{lo}}=fs$ identically, so the margin there IS $s$ and the endpoint IS the margin.* **What the post gets right is the general principle**, that a constant quoted at the flattering end of a range is worth checking, and what it gets wrong is which end the range has. *[r1070](REVIEW_r1070.md)'s figure stands. Its stated reason, evaluation at $u_{\mathrm{lo}}$, wants replacing by the $F=0$ cap, which is what actually bounds $u$ above.*

**AND THE ENDPOINT IS EXACT.** *At the lower edge $f\to1$ and $u\to u_{\mathrm{lo}}=(\theta-s)/\sqrt3$, so $\theta-\sqrt3u=s$ there, and the endpoint solving that is $s_{\mathrm{lo}}=\theta-\tfrac{\sqrt3}2=\tfrac{\sqrt6-\sqrt3}2=0.358719467607$ with $u=\tfrac12$ exactly.* **So the margin, the endpoint and the pinched $u$ are one number three ways**, which is why the two figures coincide rather than by accident.

**AND THE SCOPE IS THE EQUAL-$u$ ANSATZ EITHER WAY.** *$\sum_au_a^2\le\tfrac53t$ gives $u\le\sqrt{5t/9}$ only when the three $u_a$ agree, and the raw bound permits one block at $\sqrt{5t/3}$, where $\theta-\sqrt3u$ is negative across the whole window.* **So invertibility of $\theta-2L_{q_a}$, and with it the square-system reading, is established on the ansatz the $(s,f)$ parametrisation encodes and nowhere else.**

## The Lean file

**The three hypotheses are the right ones and nothing is vacuous.** *[a_eq_sum_g](../lean/HamiltonsCubic/Results/I111Tradeoff.lean)'s `hDab` is exactly the cross-term vanishing C1 derives from characters, and [P_N_eq_six_tau](../lean/HamiltonsCubic/Results/I111Tradeoff.lean)'s `haaa` and `haab` are the repeated-index vanishings. Each is satisfiable and each is used.*

- **The missing hypothesis of C6 is now a binder.** *[cubic_expand](../lean/HamiltonsCubic/Results/I111Tradeoff.lean) landed in the file during this round, carrying `T D D N = 0` explicitly, which is the same step this report reaches at C6 from the prose side and an independent corroboration of it.*
- **The module docstring names a hypothesis that does not exist.** *It lists "`hDab`, `haab` and `hPnu`", and the file has `hDab`, `haaa` and `haab`, and `hPnu` appears nowhere.* **The brief inherited the error**, so the doc is being read.
- **`tradeoff` and `PD_closed_form` are `linarith` over free reals** and carry no geometry at all, which is honest bookkeeping rather than a defect, and the file says so.
- **`SymTri` asks for additivity in each slot plus the two swaps, without scalar homogeneity.** *The proofs need no more, so the file is more general than the "totally symmetric trilinear form" of its own docstring.*
- **What is untyped is what the verdicts above turn on**: C3's arithmetic, C5's comparison and C7's margin are all decidable over the regime constants once the window endpoints are named, and none is typed.

## One structural note for the fold

**[Posts F74 and F75](../findings/fence-posts.md) carry headings with no row in the file's own table**, which the structure gate reports as "posts headed without a table row: [74, 75]". *Not this report's to fix, and named so it is a decision rather than an omission.*
