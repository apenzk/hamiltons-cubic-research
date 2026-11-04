# Gate 2 brief, I106 batches 15 to 27 and the Lean file that types them

**Cold brief. Everything under "The claims under attack" is quoted verbatim from the record.** You are asked to break this work. Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per checklist item. Two reviewers, **r957** and **r958**, work this brief independently. Do not read the other's log or report, and do not edit [reviews/INDEX.md](INDEX.md).

**Analysis only.** Argue from the definitions. You may run a computation of a few seconds on an object you construct in order to screen a step you are about to report, and you must report it as a screen and never as evidence for a positive claim. No sweeps, no optimisation, no open-ended search. Building [I106Criticality.lean](../lean/HamiltonsCubic/Results/I106Criticality.lean) and running `#print axioms` is permitted and encouraged.

**Read the written chain link by link before rederiving anything.** For every step ask whether it follows from the line above it and from the hypotheses actually stated. A step whose conclusion is right and whose written justification does not establish it is a finding, a gap, and it is distinct from the result being wrong. **Re-deriving the same identity by another route confirms the identity and says nothing about the proof.**

**This body of work corrected itself four times.** Batch 18's multiplier constant was understated by a factor of two, batch 17's proposed lever was refuted by batch 18, batch 19's elimination hypotheses were struck when typing removed them, and batch 26's explanation of a sign was wrong and was replaced. *Treat every surviving constant and every surviving "therefore" as suspect, since the ones already caught were caught late.*

**Report to `reviews/REVIEW_r957.md` (r957) or `reviews/REVIEW_r958.md` (r958), committing a skeleton in your first phase**, the title, a claim table with every verdict `NOT REACHED`, and your log path, then overwriting one row per phase. **Commit by pathspec, never a bare `git commit`, never `git -C`, never amend.** Log to `agent_logs/r957-I106.log` or `agent_logs/r958-I106.log`, first line carrying your PID and phase plan, a line at each phase transition, a heartbeat with live state at least every three minutes, and a closing line whose FIRST word is `DONE` or `FAILED`, as the last line in the file.

**Known and out of scope**: [scripts/runs/screen_excess_n12.py](../scripts/runs/screen_excess_n12.py) has no row in [scripts/INDEX.md](../scripts/INDEX.md). It predates this work and is not yours to fix or to report.

## The setting, a GIVEN and not under attack

$G(2)$ at fixed total norm is $\sup\Phi$ over traceless symmetric $3\times3$ matrices $\hat U,V$ with $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2=T$, where
$$\Phi(\hat U,V)=\alpha\mathop{\mathrm{tr}}\hat U^3+\beta\mathop{\mathrm{tr}}(\hat UV^2)+\mathop{\mathrm{tr}}(\hat UA)+\mathop{\mathrm{tr}}(VC),\qquad\alpha=\tfrac{15}4,\ \beta=\tfrac94,$$
and $A,C$ are diagonal in a frame $F$. In $\hat U$'s own eigenframe, $V$ has diagonal $(a_1,a_2,a_3)$ and off-diagonal entries $w_k$ opposite index $k$, $K=[\hat U,V]$, and $D_1=u_2-u_3$, $D_2=u_1-u_3$, $D_3=u_1-u_2$. **[L229](../findings/second-order.md) closed the stratum where $\hat U$ and $V$ share an eigenvector of $F$, Gate 2 passed on [r955](REVIEW_r955.md) and [r956](REVIEW_r956.md). Everything below concerns what is left.**

The Lagrange forms of a critical point, from batch 10, are $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$ and $C\equiv\mu V-\beta\{\hat U,V\}$ up to multiples of $I$, with one multiplier $\mu$, and $q(t)=3\alpha\beta t^2+3\mu(\alpha+\beta)t+3\mu^2-\tfrac12\beta^2\lvert V\rvert^2$.

## The claims under attack ([reviews/2026-09-15-I106-m3-derivation.md](2026-09-15-I106-m3-derivation.md) lines 154-372)

## Batch 15, the criticality system in one eigenframe, and the quadratic that runs it

**The system.** At a critical point of $\Phi$ on $\tfrac32\lvert\hat U\rvert^2+\tfrac12\lvert V\rvert^2=T$ with multiplier $\mu$, batch 10's Lagrange forms are $A\equiv3\mu\hat U-3\alpha\hat U^2-\beta V^2$ and $C\equiv\mu V-\beta\{\hat U,V\}$ up to multiples of $I$, and $A,C$ are diagonal in $F$, so $[A,C]=0$. Screened to $5\cdot10^{-13}$ against batch 10's displayed expansion ([screen_I106_criticality.py](../scripts/misc/screen_I106_criticality.py)).

**In an eigenframe of $\hat U$.** Write $\hat U=\mathop{\mathrm{diag}}(u_1,u_2,u_3)$ and $K=[\hat U,V]$, so $K_{ij}=(u_i-u_j)V_{ij}$. The first three terms of batch 10's expansion are all of the form (diagonal) times $K$ times (diagonal), and their $(i,j)$ entry is $(u_i-u_j)V_{ij}$ times
$$3\mu^2+\tfrac32\alpha\beta\lvert\hat U\rvert^2-\tfrac12\beta^2\lvert V\rvert^2-3\mu(\alpha+\beta)(u_i+u_j)+3\alpha\beta\,u_iu_j .$$
With $\hat U$ traceless, $u_i+u_j=-u_k$ and $u_iu_j=u_k^2-\tfrac12\lvert\hat U\rvert^2$ for the complementary index $k$, **so the two $\lvert\hat U\rvert^2$ terms cancel** and the bracket is $\phi_k=q(u_k)$ for the single quadratic
$$q(t)=3\alpha\beta\,t^2+3\mu(\alpha+\beta)\,t+3\mu^2-\tfrac12\beta^2\lvert V\rvert^2 .$$
**So the criticality system is the three scalar equations**
$$(u_i-u_j)V_{ij}\,q(u_k)=\beta^2\,(VKV)_{ij},\qquad \{i,j,k\}=\{1,2,3\},$$
the diagonal entries carrying nothing because $VKV$ is skew. Screened to $6\cdot10^{-13}$. **The whole frame dependence of the first-order conditions is one quadratic sampled at the three eigenvalues of $\hat U$**, and a commuting pair satisfies the system trivially, since $K=0$ kills both sides.

**What it leaves.** $G(2)$ on the stratum with no shared eigenvector follows if every solution with $K\ne0$ fails to be a global maximum. *The next step is that classification: $q$ has at most two roots, so at most two of $u_1,u_2,u_3$ can make the left side vanish through $q(u_k)=0$, and the remaining equations tie $V$'s off-diagonal entries to the cubic form $VKV$.* **This is a system in the three off-diagonal entries of $V$ alone once $\hat U$'s spectrum and $\mu$ are fixed.**

## Batch 16, what the criticality system says, and where it says anything new

**The remaining term, regrouped.** In $\hat U$'s eigenframe write the diagonal of $V$ as $(a_1,a_2,a_3)$ and its off-diagonal entries as $w_k$, the entry opposite index $k$, and put $D_3=u_1-u_2$, $D_2=u_1-u_3$, $D_1=u_2-u_3$. Then
$$(VKV)_{12}=D_3w_3\,a_1a_2+w_1w_2\big(a_1D_2-a_2D_1\big)+w_3\big(w_1^2D_1-w_2^2D_2-w_3^2D_3\big),$$
exact in sympy, and the other two entries are its images under the cyclic relabelling. **So every term of the equation indexed by $k$ carries either $w_k$ or the product $w_iw_j$ of the other two**, which is what makes the system degenerate on a whole stratum rather than at isolated points.

**Sharing an eigenvector is a condition on the $w$'s.** For $\hat U$ with distinct eigenvalues, $\hat U$ and $V$ share an eigenvector exactly when **at most one $w_k$ is nonzero**, since $Ve_k\parallel e_k$ says precisely that the two off-diagonal entries of row $k$ vanish. Screened over $20000$ draws with no mismatch.

**On that stratum the system collapses to one scalar condition.** Take $w_1=w_2=0$. The equations for the entries $(1,3)$ and $(2,3)$ then hold identically, every one of their terms carrying $w_2$ or $w_1w_3$, and the equation for $(1,2)$ becomes $D_3w_3\big[3\alpha\beta u_3^2+3\mu(\alpha+\beta)u_3+3\mu^2-\beta^2a_3^2\big]=0$, **the $w_3^2$ terms cancelling against the $-\tfrac12\beta^2\lvert V\rvert^2$ inside $q$ and the $a_1,a_2$ dependence collapsing to $a_3^2$ through $\mathop{\mathrm{tr}}V=0$**. So a non-commuting critical point sharing the eigenvector $e_3$ satisfies
$$3\alpha\beta\,u_3^2+3\mu(\alpha+\beta)\,u_3+3\mu^2=\beta^2a_3^2,$$
a single equation in the two eigenvalues on the shared axis and the multiplier, **free of $w_3$ entirely**. Exact in sympy ([screen_I106_criticality.py](../scripts/misc/screen_I106_criticality.py)).

**What this locates.** [L229](../findings/second-order.md) closes the stratum where the shared eigenvector is also a frame vector of $F$, and the display above is the first-order shadow of that stratum. **The criticality system carries new information only where at least two of $w_1,w_2,w_3$ are nonzero**, which is exactly the case with no shared eigenvector at all. *There the three equations are genuinely coupled, since the $w_iw_j$ terms no longer drop, and classifying their solutions is the next step.*

## Batch 17, the criticality system paired with the commutator, and one frame-free scalar constraint

**The pairing.** The system is the matrix equation $[A,C]=0$, and pairing it with $K=[\hat U,V]$ itself in the skew inner product $\langle X,Y\rangle=\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ collapses it to one scalar. Batch 15's first three terms are $K$ conjugated by diagonals, with $(i,j)$ entry $K_{ij}q(u_k)$, so $\langle\text{those},K\rangle=2\sum_kD_k^2w_k^2\,q(u_k)$ with $D_k$ and $w_k$ as in batch 16, while $\langle-\beta^2VKV,K\rangle=\beta^2\mathop{\mathrm{tr}}\big((VK)^2\big)$ because $VKV$ is skew. So every critical point satisfies
$$2\sum_{k}D_k^2w_k^2\,q(u_k)\ +\ \beta^2\mathop{\mathrm{tr}}\big((VK)^2\big)\ =\ 0,\qquad q(t)=3\alpha\beta t^2+3\mu(\alpha+\beta)t+3\mu^2-\tfrac12\beta^2\lvert V\rvert^2 .$$
Exact in sympy ([screen_I106_criticality.py](../scripts/misc/screen_I106_criticality.py)). **The fields $A$ and $C$ have left the statement entirely**, so this is a constraint on $\hat U$, $V$ and the multiplier alone, and it holds on both strata at once.

**Tracelessness is load-bearing, and a first check missed it.** Batch 10's displayed expansion equals $[A,C]$ only after Cayley--Hamilton for traceless $3\times3$ matrices, so with $u_i$ and $a_i$ left free the identity above is false, and the first symbolic check reported exactly that. *Recorded because the displayed form reads like an algebraic rearrangement and is not one: it carries the traceless hypothesis inside it.*

**What it does not do.** $\mathop{\mathrm{tr}}\big((VK)^2\big)$ takes both signs over traceless symmetric pairs, ranging over $[-50.1,\,8407.5]$ on the $200000$ draws the filed screen makes, so no sign argument follows from this identity by itself, and it cannot close the non-commuting case alone. **What it is good for is that it is frame-free and quadratic in the off-diagonal entries**, so a sign on $q$ at the three eigenvalues of $\hat U$ would force $\mathop{\mathrm{tr}}((VK)^2)$ to a definite sign and conversely. *The next step is therefore second-order: at a global maximum the partner $V$ maximises $\beta\mathop{\mathrm{tr}}(\hat UV^2)+\mathop{\mathrm{tr}}(VC)$ over its own sphere at fixed $\lvert V\rvert$, which bounds $\mu$ below by the top eigenvalue of the Jordan operator $V\mapsto\beta\cdot\tfrac12(\hat UV+V\hat U)$ on traceless symmetric matrices, and that is a bound on $\mu$ in terms of $\hat U$'s spectrum alone.*

## Batch 18, the multiplier is bounded below by L225's constant, and batch 17's proposed lever is refuted

**The second-order bound.** At a global maximum, $V$ maximises $\beta\mathop{\mathrm{tr}}(\hat UV^2)+\mathop{\mathrm{tr}}(VC)$ over its own sphere at fixed $\lvert V\rvert$, everything else held. That is a trust-region problem for the quadratic form $V\mapsto\beta\langle V,\mathcal LV\rangle$ with $\mathcal L(V)=\tfrac12(\hat UV+V\hat U)$ compressed to traceless symmetric matrices, and its necessary condition is that the trust-region multiplier dominates the form. **The normalisation is where a factor of two lives, and the first version of this batch lost it.** Written out, the $V$ equation is $2\beta\mathcal LV+C=\mu V$, since $\{\hat U,V\}=2\mathcal LV$, so the multiplier of $\max\langle V,\beta\mathcal LV\rangle+\langle V,C\rangle$ at fixed $\lvert V\rvert$ is $\nu=\mu/2$ rather than $\mu$, and optimality reads $\nu\ge\beta\lambda_{\max}(\mathcal L)$, that is $\mu\ge2\beta\lambda_{\max}(\mathcal L)$.

**The spectrum of $\mathcal L$, and why the diagonal directions win.** In $\hat U$'s eigenframe the traceless symmetric space splits into the traceless diagonal plane and the three off-diagonal directions, both $\mathcal L$-invariant. On $E_{ij}+E_{ji}$ the eigenvalue is $\tfrac{u_i+u_j}2=-\tfrac{u_k}2$. On the traceless diagonal plane the compression of $\mathop{\mathrm{diag}}(u)$ has trace $0$ and squared norm $\tfrac13\lvert\hat U\rvert^2$, so its eigenvalues are $\pm\lvert\hat U\rvert/\sqrt6$. **And the diagonal block always dominates**, because for traceless $u$
$$2\lvert\hat U\rvert^2-3u_k^2=2(u_i^2+u_j^2)-(u_i+u_j)^2=(u_i-u_j)^2\ \ge\ 0,$$
so $-\tfrac{u_k}2\le\lvert\hat U\rvert/\sqrt6$, **with equality exactly when the other two eigenvalues agree**, that is at $u\sim(t,t,-2t)$. Hence $\lambda_{\max}(\mathcal L)=\lvert\hat U\rvert/\sqrt6$ and
$$\mu\ \ge\ \frac{2\beta\,\lvert\hat U\rvert}{\sqrt6}\qquad\text{at every global maximum.}$$
*The constant is [L225](../findings/second-order.md)'s at $k=3$, reappearing as the top eigenvalue of a Jordan operator rather than as a cubic bound.* Screened to $9\cdot10^{-16}$ on the spectrum, and at the same ten constrained maximisers the ratio $\mu/(\beta\lambda_{\max})$ runs over $[2.13,\,9.37]$, so the doubled bound holds with margin everywhere and the halved one was simply slack. **The weaker form is what the first screen tested, which is why the screen could not catch the lost factor**: a bound stated below the truth is never violated.

**And the lever batch 17 proposed does not exist.** That batch closed by suggesting this bound would sign $q$ at the three eigenvalues of $\hat U$, which with its identity $2\sum_kD_k^2w_k^2q(u_k)+\beta^2\mathop{\mathrm{tr}}((VK)^2)=0$ would force $\mathop{\mathrm{tr}}((VK)^2)<0$ and constrain non-commuting critical points. **At five of the same ten maximisers some $q(u_k)$ is negative**, so $q$ is not positive at all three eigenvalues and no sign follows. *The bound on $\mu$ is real and the inference from it is not, so batch 17's identity stays unsigned and its closing sentence is withdrawn.*

**One corroboration.** All ten maximisers came out commuting to $10^{-6}$, which is $G(2)$ doing what batch 9's larger screen already found, and says nothing about the non-commuting critical points the system admits.

**What remains** is the classification of solutions with at least two of $w_1,w_2,w_3$ nonzero, now without a sign lever, so the next attempt is the three coupled equations of batch 16 directly.

## Batch 19, the degenerate spectrum, where a non-commuting critical point would have to hide

**Why this slice.** Batch 18's bound $\mu\ge\beta\lvert\hat U\rvert/\sqrt6$ is tight exactly at $\hat U\sim(t,t,-2t)$, so that is the spectrum on which the second-order condition says least. Take $u_1=u_2=t$ and $u_3=-2t$, write the diagonal of $V$ as $(a_1,a_2,a_3)$ with $a_3=-a_1-a_2$, put $S=w_1^2+w_2^2$ and $Q=q(u_1)$.

**The system becomes three equations, one of which has lost its $q$.** Since $D_3=u_1-u_2=0$, the equation indexed by $3$ carries no $q$ term at all and is a pure constraint, while $D_1=D_2=3t$ scale the other two:
$$\text{(i)}\ \ w_1w_2(a_1-a_2)+w_3\big(w_1^2-w_2^2\big)=0,$$
$$\text{(ii)}\ \ w_1\big[Q-\beta^2(a_2a_3-S)\big]=\beta^2a_3w_2w_3,\qquad\text{(iii)}\ \ w_2\big[Q-\beta^2(a_1a_3-S)\big]=\beta^2a_3w_1w_3 .$$
Exact in sympy against the general system of batch 16.

**Equation (i) is redundant off $a_3=0$.** Forming $w_2\cdot\text{(ii)}-w_1\cdot\text{(iii)}$ returns $\beta^2a_3$ times the left side of (i), so wherever $a_3\ne0$ the constraint carrying no multiplier is a consequence of the other two rather than an extra condition.

**Two of the equations give one equation, with no side conditions.** The combination $w_1\text{(ii)}-w_2\text{(iii)}$ divides by nothing and gives
$$\big(w_1^2-w_2^2\big)\big(Q+\beta^2S\big)=\beta^2a_3\big(a_2w_1^2-a_1w_2^2\big).$$
*A first derivation of this reached it by solving (iii) for $w_3$ and substituting, which needs $a_3\ne0$ and $w_1\ne0$, and typing the step as `collapse_from_pair` removed both hypotheses.* **In particular at $w_1^2=w_2^2$ the left side vanishes and the right forces $a_3=0$ or $a_1=a_2$.**

**Two nonzero entries force both $w_1$ and $w_2$ nonzero.** Setting $w_1=0$ makes (i) read $w_2^2w_3=0$, so $w_2=0$ or $w_3=0$, and either way at most one entry survives. **The case $w_1=0$ with $w_2$ and $w_3$ both nonzero is therefore impossible**, and the swap $e_1\leftrightarrow e_2$, which fixes $\hat U$ and exchanges $a_1\leftrightarrow a_2$ and $w_1\leftrightarrow w_2$ while fixing $w_3$, rules out $w_2=0$ with $w_1,w_3$ nonzero in the same way. *So on this spectrum the open case is exactly $w_1w_2\ne0$.*

**The branch $a_3=0$ stays live and is different in kind.** There (ii) and (iii) read $w_1(Q+\beta^2S)=0$ and $w_2(Q+\beta^2S)=0$, so any solution with $w_1$ or $w_2$ nonzero has $Q=-\beta^2S$, and (i), no longer redundant, adds $2a_1w_1w_2+w_3(w_1^2-w_2^2)=0$. **Two conditions rather than one, and $Q=-\beta^2(w_1^2+w_2^2)\le0$ is a sign statement about the multiplier.**

**Batch 18's bound does not clear that branch, and the test is recorded here so it is not run twice.** At this spectrum $\lvert\hat U\rvert^2=6t^2$, so the bound reads $\mu\ge\beta\lvert t\rvert$. **With the sharp constant of batch 18 the bound is $\mu\ge2\beta\lvert t\rvert=4.5\lvert t\rvert$, and the arithmetic below uses that.** For $t>0$ the quadratic $Q$ increases in $\mu$ throughout, so its floor is $Q(2\beta t)=\tfrac{2673}{16}t^2-\tfrac{81}{32}\lvert V\rvert^2$, and $Q\le0$ asks for $\lvert V\rvert^2\ge66t^2$, which the norm constraint $T=9t^2+\tfrac12\lvert V\rvert^2$ still grants freely. For $t<0$ the picture changes in kind: the unconstrained vertex $\mu^\ast=3\lvert t\rvert$ now falls **below** the bound $4.5\lvert t\rvert$, so it is no longer admissible and the floor sits at the endpoint, $Q(2\beta\lvert t\rvert)=\tfrac{81}{16}t^2-\tfrac{81}{32}\lvert V\rvert^2$, giving $Q\le0$ for $\lvert V\rvert^2\ge2t^2$. *So the sign is compatible with the bound at both signs of $t$ and no contradiction follows, the conclusion surviving the corrected constant while both thresholds move.*

**What remains on this spectrum** is therefore two separate questions rather than one: off $a_3=0$, whether the single collapsed equation admits a solution with $w_1w_2\ne0$ that is a global maximum, and on $a_3=0$, the pair $Q=-\beta^2S$ with $2a_1w_1w_2+w_3(w_1^2-w_2^2)=0$. *Neither is settled by a first-order or second-order condition already on the record.*

## Lean for batches 15 to 26

**These batches recorded claims and were committed without typing any of them, which the loop's rule forbids: the trigger is a claim being recorded, not a result being numbered.** They had been checked in sympy and numpy alone, and a computer algebra run is not a kernel. [I106Criticality.lean](../lean/HamiltonsCubic/Results/I106Criticality.lean) now types and proves them, on standard axioms and with no `sorry`.

| claim | batch | declaration |
| --- | --- | --- |
| the $\lvert\hat U\rvert^2$ terms cancel, leaving $q$ at the complementary eigenvalue | 15 | `phi_collapse` |
| $(VKV)_{12}$ regroups so every term carries $w_k$ or $w_iw_j$, computed from the matrix product | 16 | `vkv_regroup` |
| $w_1=0$ forces $w_2^2w_3=0$, so two nonzero entries need $w_1w_2\ne0$ | 16, 19 | `w1_zero_forces` |
| $w_2\text{(ii)}-w_1\text{(iii)}=\beta^2a_3\text{(i)}$, so (i) is redundant off $a_3=0$ | 19 | `redundancy` |
| the single collapsed equation, by the combination $w_1\text{(ii)}-w_2\text{(iii)}$ | 19 | `collapse_from_pair` |
| $2\lvert\hat U\rvert^2-3u_3^2=(u_1-u_2)^2$, putting the Jordan top eigenvalue on the diagonal block | 18 | `jordan_gap`, `jordan_gap_le` |
| $q(\beta t)=81t^2-\tfrac{81}{32}n$, so $q\le0$ asks only for $n\ge32t^2$ | 19 | `Q_floor`, `Q_floor_nonpos_iff` |
| the pairing with $K$, $-\mathop{\mathrm{tr}}(\lbrack A,C\rbrack K)=2\sum_kD_k^2w_k^2q(u_k)+\beta^2\mathop{\mathrm{tr}}((VK)^2)$ | 17 | `paired_identity` |
| the value at any critical point, $\Phi=2\mu T-2P_3$ | 20 | `value_at_critical` |
| the sharp normalisation, a Rayleigh direction of ratio $c$ giving $\mu\ge2\beta c$, and the off-diagonal ratio $\tfrac12(u_1+u_2)$ | 18 | `mu_ge_of_rayleigh`, `offdiag_rayleigh` |
| the second variation of the cubic part, all four coefficients at once, and the constraint's expansion with its tangency form | 21 | `second_variation_expansion`, `constraint_expansion` |
| a quadratic nonpositive for every $t$, with negative leading coefficient, has $b^2\le4ac$ | 22 | `disc_of_nonpos` |
| the cubic behind the $\alpha$ part factors into the three eigenvalue gaps | 25 | `alpha_part_factors` |
| the eliminated equation transforms by the sign character of $S_3$, and the eigenvector sign flip fixes it | 26 | `elimPoly`, `elimPoly_antisymm`, `elimPoly_cycle`, `elimPoly_signFlip` |

**The proof of `collapse_from_pair` is better than the derivation's.** Batch 19 reached the single equation by solving (iii) for $w_3$ and substituting, which needs $a_3\ne0$ and $w_1\ne0$. In Lean it is the linear combination $w_1\text{(ii)}-w_2\text{(iii)}$, which divides by nothing, **so the equation holds with no side conditions at all** and batch 19's two hypotheses on that step are unnecessary.

**Not typed**: nothing here reaches a statement about maximisers, which is where the open question lives. *Every identity these five batches record is now kernel-checked, and none of them constrains a maximiser on its own.*

## Batch 20, the value at a critical point, with the fields eliminated

**The pairing.** Each Lagrange equation is paired with its own variable. Both carry an undetermined multiple of $I$, and both multiples drop out because $\hat U$ and $V$ are traceless. From the $\hat U$ equation $3\alpha\hat U^2+\beta V^2+A\equiv3\mu\hat U$,
$$3\alpha\mathop{\mathrm{tr}}\hat U^3+\beta\mathop{\mathrm{tr}}(\hat UV^2)+\langle\hat U,A\rangle=3\mu\lvert\hat U\rvert^2,$$
and from the $V$ equation $\beta\{\hat U,V\}+C\equiv\mu V$, using $\mathop{\mathrm{tr}}\big(V\{\hat U,V\}\big)=2\mathop{\mathrm{tr}}(\hat UV^2)$,
$$2\beta\mathop{\mathrm{tr}}(\hat UV^2)+\langle V,C\rangle=\mu\lvert V\rvert^2 .$$

**The identity.** Substituting both into $\Phi=P_3+\langle\hat U,A\rangle+\langle V,C\rangle$ with $P_3=\alpha\mathop{\mathrm{tr}}\hat U^3+\beta\mathop{\mathrm{tr}}(\hat UV^2)$ gives $\Phi=3\mu\lvert\hat U\rvert^2+\mu\lvert V\rvert^2-2P_3$, and $3\lvert\hat U\rvert^2+\lvert V\rvert^2=2T$ by the definition of the total norm, so
$$\boxed{\ \Phi=2\mu T-2P_3\ }$$
at every critical point, with the linear part $\langle\hat U,A\rangle+\langle V,C\rangle=2\mu T-3P_3$. **The fields have left the statement entirely.** Typed and proved as `value_at_critical`, and confirmed exactly in sympy.

**What it gives.** *Comparing any two critical points at the same total norm is comparing $\mu T-P_3$, and nothing else.* In particular a non-commuting critical point beats the diagonal maximiser at the same $T$ exactly when its $\mu T-P_3$ is larger, so the open question is now a comparison of two numbers per point rather than a comparison of configurations. **It is a reformulation and settles nothing on its own**, since neither $\mu$ nor $P_3$ is yet controlled at a non-commuting point. *Batch 18 bounds $\mu$ from below at a maximum, which is the wrong direction for this comparison, so what is owed is an upper bound on $\mu$ or a lower bound on $P_3$.*


## Batch 21, the joint second-order condition, and the cross term that is the only lever on non-commutativity

**Why look here.** Batch 20 reduced the open comparison to $\mu T-P_3$ and left owed an upper bound on $\mu$ or a lower bound on $P_3$. Every bound reached so far runs the other way, and each was obtained by moving **one** variable while the other was held. **The second-order condition has never been used jointly**, and its cross term is the only place where a second-order statement sees $V$ failing to commute with $\hat U$.

**The expansion.** Along $(\hat U+sX,\,V+sY)$ with $X,Y$ traceless symmetric, the cubic part has second-order coefficient $3\alpha\mathop{\mathrm{tr}}(\hat UX^2)+\beta\big(2\mathop{\mathrm{tr}}(XVY)+\mathop{\mathrm{tr}}(\hat UY^2)\big)$, the norm has second-order coefficient $\tfrac32\lvert X\rvert^2+\tfrac12\lvert Y\rvert^2$, and the first-order coefficient of the norm is the tangency form $3\mathop{\mathrm{tr}}(\hat UX)+\mathop{\mathrm{tr}}(VY)$. All three exact in sympy, and the whole expansion typed as `second_variation_expansion` and `constraint_expansion`.

**The condition.** At a critical point the first differential of $\Phi-\mu T$ vanishes, so along any curve on the constraint surface the second derivative is $D^2(\Phi-\mu T)$ applied to the tangent vector alone, with no contribution from the curve's acceleration. Hence at every local maximum, for all traceless symmetric $X,Y$ with $3\mathop{\mathrm{tr}}(\hat UX)+\mathop{\mathrm{tr}}(VY)=0$,
$$6\alpha\mathop{\mathrm{tr}}(\hat UX^2)+4\beta\mathop{\mathrm{tr}}(XVY)+2\beta\mathop{\mathrm{tr}}(\hat UY^2)\ \le\ \mu\big(3\lvert X\rvert^2+\lvert Y\rvert^2\big).$$
**Setting $Y=0$ and $X=E_{ij}+E_{ji}$, which is tangent because $\hat U$ is diagonal, gives $\mu\ge-\alpha u_k$ at every $k$**, so $\mu\ge\alpha\lvert u_{\min}\rvert$, a bound with $\alpha=\tfrac{15}4$ in place of batch 18's $\beta$.

**Screened, after a bug that looked like a refutation.** The first screen reported a violation of $-1.92$, which would have refuted the derivation. **The fault was the screen's tangent projection**: the constraint gradient is $(3\hat U,V)$, so the projection must divide by $\lvert(3\hat U,V)\rvert^2=9\lvert\hat U\rvert^2+\lvert V\rvert^2$, and it divided by $3\lvert\hat U\rvert^2+\lvert V\rvert^2$. The directions were therefore not tangent and the condition was tested where it need not hold. With the projection corrected, over ten maximisers with criticality residual $1.2\cdot10^{-7}$ and four thousand tangent directions each, **the smallest slack is $+0.27$ and the condition is tight nowhere**. *Recorded because a wrong screen reporting a violated necessary condition is indistinguishable, at a glance, from a real refutation of the route.*

**What is owed.** The condition is a joint form, so it is a statement that a block operator is negative semidefinite on the tangent space. *Its Schur complement couples $\hat U$ and $V$ through the cross term, and whether that coupling forces $[\hat U,V]=0$ at a maximum is the next question.* **It is not settled by any specialisation to one variable**, which is all that has been extracted from it so far.

## Batch 22, the discriminant form, and the first inequality that binds $V$ to $\hat U$

**The line $(Z,tZ)$.** Batch 21's condition holds on tangent directions, and the pair $(Z,tZ)$ is tangent **for every $t$** exactly when $3\mathop{\mathrm{tr}}(\hat UZ)+t\mathop{\mathrm{tr}}(VZ)=0$ identically in $t$, that is when
$$\mathop{\mathrm{tr}}(\hat UZ)=\mathop{\mathrm{tr}}(VZ)=0 .$$
That is two linear conditions on the five-dimensional space of traceless symmetric $Z$, so the subspace is three-dimensional in general. **On it the whole second-order condition becomes one scalar quadratic in $t$ that must never be positive**, namely $at^2+bt+c\le0$ with
$$a=2\beta\mathop{\mathrm{tr}}(\hat UZ^2)-\mu\lvert Z\rvert^2,\qquad b=4\beta\mathop{\mathrm{tr}}(VZ^2),\qquad c=6\alpha\mathop{\mathrm{tr}}(\hat UZ^2)-3\mu\lvert Z\rvert^2 .$$
*The coefficient $a$ is the $X=0$ case of the same condition and $c$ is three times the $Y=0$ case, so both are already known to be at most zero.*

**The inequality.** A quadratic that is never positive, with $a<0$, satisfies $b^2\le4ac$, which is `disc_of_nonpos`. Writing $c=3(2\alpha\mathop{\mathrm{tr}}(\hat UZ^2)-\mu\lvert Z\rvert^2)$ and dividing by four,
$$\boxed{\ 4\beta^2\mathop{\mathrm{tr}}(VZ^2)^2\ \le\ 3\big(2\beta\mathop{\mathrm{tr}}(\hat UZ^2)-\mu\lvert Z\rvert^2\big)\big(2\alpha\mathop{\mathrm{tr}}(\hat UZ^2)-\mu\lvert Z\rvert^2\big)\ }$$
for every $Z$ in that subspace. **The left side is built from $V$ alone and the right side from $\hat U$ and $\mu$ alone.** *This is the first inequality on the record that bounds a quantity of $V$ by quantities of $\hat U$, which is what batch 20 said was owed, and it arrives from second order rather than first.* Both factors on the right are nonpositive, so their product is nonnegative and the inequality is not vacuous on sign grounds.

**Screened.** At the ten maximisers, over three thousand directions of the subspace each: $\min(-a)=8.8\cdot10^{-4}$ and $\min(4ac-b^2)=2.7\cdot10^{-6}$, both nonnegative as required. **Both minima sit close to zero**, so the inequality is nearly attained somewhere on this subspace, which is either a sign that it is a sharp lever or an artefact of nearly degenerate $Z$. *That distinction is not settled and is the next thing to look at.*

**What it does not yet do.** It constrains $\mathop{\mathrm{tr}}(VZ^2)$ for $Z$ orthogonal to both $\hat U$ and $V$, and the open question needs a statement about $[\hat U,V]$. *The gap is that $\mathop{\mathrm{tr}}(VZ^2)$ over this subspace is not obviously related to the commutator*, and finding a $Z$ whose $\mathop{\mathrm{tr}}(VZ^2)$ is forced large when $[\hat U,V]\ne0$ is what would close it.


## Batch 23, the interlacing route is dead, and why it could never have worked

**The idea.** Batch 22's inequality caps $\mathop{\mathrm{tr}}(VZ^2)/\lvert Z\rvert^2$ on the subspace $W=\{Z:\mathop{\mathrm{tr}}(\hat UZ)=\mathop{\mathrm{tr}}(VZ)=0\}$, roughly by $\tfrac{\sqrt3\,\mu}{2\beta}$ once $\mu$ dominates. That quotient is the Rayleigh quotient of $V$'s Jordan operator $\mathcal L_V$ restricted to $W$, and $W$ has codimension two, so Cauchy interlacing gives $\lambda_{\max}(\mathcal L_V\vert_W)\ge\lambda_3(\mathcal L_V)$. Capping the left side would then cap $\lambda_3(\mathcal L_V)$ and so constrain $V$ against $\mu$, which is what batch 20 asked for.

**Why it fails, structurally.** By the spectrum computed in batch 18 for $\hat U$ and identical for $V$, the five eigenvalues of $\mathcal L_V$ on traceless symmetric matrices are $\pm\lvert V\rvert/\sqrt6$ together with $-v_1/2,-v_2/2,-v_3/2$, and **those three sum to zero while the other two are symmetric about zero, so the median of the five is pinned near zero by construction.** Interlacing bounds the restricted maximum from *below* by that median, and a quantity pinned near zero can never meet a positive cap. **The route is not accidentally slack, it is the wrong direction of bound on a quantity that cannot be large.**

**Measured, at the ten maximisers.** $\lambda_3(\mathcal L_V)$ is negative at eight of the ten and at most $0.275$ at the others, while the cap runs over $[0.59,\,1.16]$ and the restricted maximum itself over $[0.11,\,0.54]$. *So the cap is slack by a factor of two to six everywhere, and the interlacing lower bound is vacuous against it at every point.*

**And it was not typable either.** Mathlib carries no eigenvalue interlacing and no Courant-Fischer statement under the names searched, so the step would have needed that theory built first.

**What remains.** The gap batch 22 named is unchanged and is a construction rather than a spectral inequality: **exhibit a $Z\in W$ whose $\mathop{\mathrm{tr}}(VZ^2)$ is forced large when $[\hat U,V]\ne0$.** *Interlacing was an attempt to get that for free from dimension counting alone, and dimension counting is exactly what cannot see a commutator.*

## Batch 24, the construction batch 22 asked for does not exist, and the discriminant line closes

**The natural candidate.** $K=[\hat U,V]$ is skew, and for skew $K$ and symmetric $M$ the commutator $[K,M]$ is symmetric, so $Z_1=[K,\hat U]$ is traceless symmetric and vanishes exactly when $K$ commutes with $\hat U$. It also satisfies one of the two constraints for free: $\mathop{\mathrm{tr}}(\hat UZ_1)=\mathop{\mathrm{tr}}(\hat UK\hat U)-\mathop{\mathrm{tr}}(\hat U^2K)=0$ by cyclicity. *So it is the obvious thing to feed into batch 22's inequality.*

**But no particular $Z$ is what is needed.** Batch 22's cap holds for **every** $Z\in W$, so a contradiction requires the *maximum* of $\mathop{\mathrm{tr}}(VZ^2)/\lvert Z\rvert^2$ over $W$ to exceed it, and that maximum is $\lambda_{\max}(\mathcal L_V\vert_W)$ whatever $Z$ one writes down. **The construction therefore reduces to a single question: is $\lambda_{\max}(\mathcal L_V\vert_W)$ bounded below by anything increasing in $\lVert[\hat U,V]\rVert$?**

**It is not.** Over $159273$ pairs of traceless symmetric matrices, both normalised to unit Frobenius norm and kept only when $\lVert K\rVert\ge\tfrac12$, the restricted maximum descends to $7.9\cdot10^{-4}$, attained at $\lVert K\rVert=0.70$, against the unrestricted value $\lvert V\rvert/\sqrt6=0.408$. **A strongly non-commuting pair can have a restricted maximum three orders of magnitude below the unrestricted one.** *So no inequality of the shape "the commutator is large, therefore $\mathop{\mathrm{tr}}(VZ^2)$ is large somewhere on $W$" holds, and the construction cannot come from linear algebra alone.*

**What this closes and what it does not.** It closes the discriminant line, batches 21 to 24, as a route to $[\hat U,V]=0$: that line produces a real inequality in batch 22 and no path from it to commutativity. **It does not show the inequality is useless**, and it does not rule out a proof that consumes the criticality equations, which cut the pair down far below a generic one. *What is refuted is the route that would have worked for any pair, which is the only thing the second-order condition by itself can supply.*

**Three methods have now closed on this node in one day**: the three-alignment relaxation, Cauchy interlacing, and this construction. *Each died for the same underlying reason, that a bound derived without using criticality cannot see a commutator, and by the plan's own standing rule several attempts failing for one reason is the signal to return to route selection rather than to try a fourth.*

## Batch 25, eliminating the multiplier and the norm, and what the system becomes

**The elimination.** With the $u_i$ distinct and all three $w_k$ nonzero, each equation of batch 16 solves for one value of $q$:
$$q(u_k)=\frac{\beta^2\,(VKV)_{ij}}{(u_i-u_j)\,w_k},\qquad\{i,j,k\}=\{1,2,3\}.$$
**And $q$ is a quadratic whose leading coefficient is $3\alpha\beta$, a constant free of $\mu$ and of $\lvert V\rvert^2$.** So its second divided difference over the three eigenvalues is forced:
$$\sum_k\frac{q(u_k)}{\prod_{m\ne k}(u_k-u_m)}=3\alpha\beta .$$
*Both unknowns of the Lagrange system disappear at once, because they sit only in the lower coefficients of $q$.*

**What is left is one polynomial equation in the block data alone.** Writing $D_1=u_2-u_3$, $D_2=u_1-u_3$, $D_3=u_1-u_2$ and $a_3=-a_1-a_2$, it is
$$3\alpha\,w_1w_2w_3\,D_1D_2D_3\ =\ \beta\Big[w_1w_2w_3\big(a_1^2D_2+2a_1a_2D_3-a_2^2D_1\big)+w_1^2w_2^2\big(a_1D_2-a_2D_1\big)$$
$$-\ w_1^2w_3^2\big(a_3D_1+a_1D_3\big)+w_2^2w_3^2\big(a_3D_2-a_2D_3\big)+w_1w_2w_3\big(w_1^2D_1-w_2^2D_2+w_3^2D_3\big)\Big],$$
exact in sympy. **The $\alpha$ side is a single monomial**, because the cubic $2u_1^3+3u_1^2u_2-3u_1u_2^2-2u_2^3$ factors as $D_1D_2D_3$, which is `alpha_part_factors`.

**Two checks it had no freedom to pass.** The coefficient of $w_1^2w_2^2$ is $a_1D_2-a_2D_1$, **exactly the combination batch 16's independent regrouping of $(VKV)_{12}$ produced**. And every term of the bracket carries a factor of some $w$, so a commuting pair satisfies the equation trivially, as it must.

**What it gives.** *The multiplier and the norm are gone, so a non-commuting critical point is now constrained by a relation among the eigenvalue gaps, the diagonal of $V$ and its off-diagonal entries alone.* **The $\alpha$ side vanishes exactly when some $w_k$ vanishes or some gap closes**, and both of those are the cases already settled, so in the open case both sides are nonzero and the equation is a genuine balance between $\alpha$ and $\beta$, whose values are $\tfrac{15}4$ and $\tfrac94$.

**What is owed.** The elimination consumed the three equations to produce one, so two independent combinations of the original system remain unused. **The question is whether this equation together with those two forces $w_1w_2w_3=0$**, which is commutativity on this stratum. *That is a question about a polynomial system in seven unknowns with two fixed rational constants, and it is the first form of the problem with no analysis in it at all.*


## Batch 26, the eliminated equation is invariant under the stratum's whole symmetry group

**The group.** Relabelling the three eigenvector axes acts simultaneously on the eigenvalues $u_k$, the diagonal entries $a_k$ and the off-diagonal entries $w_k$, since $w_k$ is by definition the entry opposite axis $k$. Flipping the sign of one eigenvector flips two of the three $w_k$ and fixes everything else. Together these generate $S_3$ times the sign flips, and they are symmetries of the whole setup, since they are conjugations of $\hat U$ and $V$ by signed permutation matrices, which preserve $\Phi$, the norm and the diagonality of the fields.

**Batch 25's equation is invariant under all of them.** Taking the ratio of the relabelled equation to the original: both transpositions give exactly $1$, both three-cycles give exactly $1$, and the sign flip of $e_1$ gives exactly $1$. *So the equation descends to the quotient by that group, its solution set is a union of orbits, and a search for non-commuting solutions may be conducted on the quotient rather than on the seven variables.*

**Two false alarms, both of which read as a refutation.** They are recorded because each looked, at a glance, like the derivation being wrong rather than the check.
1. **Comparing numerators.** The equation was extracted as the numerator of a rational function, and **a numerator is defined only up to a unit**, so it can acquire a sign or a factor under relabelling while the equation itself is unchanged. Comparing numerators reported the symmetry broken. The meaningful comparison is the ratio of the two equations.
2. **Cycling the $w$ indices against the $u$ indices.** Since $w_k$ sits opposite axis $k$, it must be permuted exactly as the axes are. Cycling $u$ and $a$ one way while cycling $w$ the other is a different substitution altogether, and it is the only one of the five tested that fails.

**The polynomial is antisymmetric, and the equation is invariant. Both, precisely.** Batch 25's explicit polynomial transforms by the **sign character** of $S_3$: substituting into it directly, with no re-derivation, it negates under either diagonal transposition and is fixed under either three-cycle, and its $\alpha$ and $\beta$ coefficients are separately antisymmetric. That is exactly as it must be, since the $\alpha$ coefficient is the invariant $w_1w_2w_3$ times the antisymmetric Vandermonde $D_1D_2D_3$. **The equation $P=0$ is then invariant, because a sign does not move a zero set**, which is what the ratio test found.

**A third false alarm, and the one that took longest.** *Asking whether "the numerator" is symmetric is not a well-posed question*, because the numerator returned by cancelling a rational function is defined only up to a unit, so two such numerators may differ by a sign that has nothing to do with the group. Tests built that way reported the numerator antisymmetric once and symmetric once, and both readings were meaningless. **The well-posed test fixes the explicit polynomial and substitutes into that**, which is what settles it. *An earlier draft of this batch recorded the sign as an artefact of the numerator convention, and that was wrong: the antisymmetry is a real property of the polynomial.*

**What it opens.** An invariant equation is expressible in the invariants of the action, in the elementary symmetric functions of the $u_k$ and of the $a_k$, in $w_1w_2w_3$ and $\sum w_k^2$, and in the mixed invariants such as $\sum u_kw_k^2$. **Rewriting it that way would cut the seven variables down substantially.** *The mixed invariant ring of three index sets under one diagonal $S_3$ is not small, so choosing the right generating set is the work, and the cost of searching for it is not predictable in advance. It is named here rather than started.*

**Not typed.** Batch 25's equation itself is not in Lean, only `alpha_part_factors`, the cubic identity behind its $\alpha$ side. The invariance recorded here is a statement about that untyped equation.

## Batch 27, the elimination is blocked on an open-ended run, and the block is recorded

**The question in its sharpest form.** Does the criticality system admit a solution with $w_1w_2w_3\ne0$? Adjoining the saturation variable $t$ with $t\,w_1w_2w_3-1$ turns "some $w_k$ may not vanish" into an ideal membership question: **a Groebner basis equal to $\{1\}$ would say no non-commuting critical point exists**, and a non-trivial basis would hand over the solutions explicitly, to be tested for global maximality.

**The probe, capped in advance.** With the spectrum fixed at the generic traceless triple $(3,1,-4)$, the system is four polynomials of degrees $3,3,3,4$ in the seven unknowns $a_1,a_2,w_1,w_2,w_3,\mu,t$. **A lexicographic Groebner basis did not finish within a hard cap of $150$ seconds.** *The cap was set before the run, and the outcome is information about cost alone: it says nothing whatever about whether non-commuting critical points exist.*

**So the item is blocked, and the block is what is recorded.** The general question needs the spectrum symbolic, which is strictly harder than the specialised one that already failed to terminate, so the cost of the run is not predictable in advance and the standing footing does not permit starting it. *A specialised spectrum would in any case decide nothing on its own, since the conjecture is about every spectrum, so even a completed run at $(3,1,-4)$ would be a probe rather than a proof.*

**What the route has and has not produced.** Batches 25 and 26 reduced the system to one polynomial equation in the block data alone, carrying the sign character of $S_3$, with the multiplier and the norm eliminated and the whole structure typed. **What they did not produce is a decision procedure**, and the natural one is out of reach on this footing. *The remaining analytic openings are the invariant-module rewrite, whose generating set is itself an unbounded search, and any argument that consumes the criticality equations rather than eliminating them.*

## What to attack

1. **Batch 18's constant, which was already wrong once.** The $V$ equation is claimed to read $2\beta\mathcal LV+C=\mu V$ with $\mathcal LV=\tfrac12(\hat UV+V\hat U)$, making the trust-region multiplier $\mu/2$ and the bound $\mu\ge2\beta\lvert\hat U\rvert/\sqrt6$. Derive the factor yourself from the Lagrange form. Is it two, or one, or four?
2. **The Jordan spectrum.** Is $\lambda_{\max}(\mathcal L_{\hat U})=\lvert\hat U\rvert/\sqrt6$ on TRACELESS symmetric matrices, and is the off-diagonal block's $-u_k/2$ really dominated? Check the equality case $(t,t,-2t)$.
3. **Batch 20's identity $\Phi=2\mu T-2P_3$.** Verify both pairings, that the multiples of $I$ drop because $\hat U$ and $V$ are traceless, and that $\mathop{\mathrm{tr}}(V\{\hat U,V\})=2\mathop{\mathrm{tr}}(\hat UV^2)$. Does it hold at every critical point or only at maximisers?
4. **Batch 21's second variation.** Verify the order-two coefficient and the tangency form. **The claim that a curve's acceleration contributes nothing rests on the first differential of $\Phi-\mu T$ vanishing.** Is that stated correctly, and does it need the constraint to be a manifold near the point?
5. **Batch 22's tangency claim.** Is $(Z,tZ)$ tangent for EVERY $t$ exactly when $\mathop{\mathrm{tr}}(\hat UZ)=\mathop{\mathrm{tr}}(VZ)=0$? Is the subspace three-dimensional in general, and what happens when it is not? Is the leading coefficient $a$ really the $X=0$ case, and is it $\le0$ or $<0$? `disc_of_nonpos` assumes $a<0$ strictly.
6. **Batch 25's elimination, the load-bearing step.** Is the second divided difference of a quadratic equal to its leading coefficient with no extra factor? Verify the displayed equation and the $\alpha$-part factorisation. **Does the elimination lose solutions?** It divides by $w_k$ and by $(u_i-u_j)$.
7. **Batch 25's claim that two independent combinations remain.** Three equations produced one. Is that count right, and are the remaining two actually independent?
8. **Batch 26's parity.** Verify on the explicit polynomial. Is the group action correctly identified, in particular that $w_k$ permutes as the axes do and that a sign flip flips exactly two $w_k$?
9. **Batches 23 and 24, the negative results.** Batch 24 samples GENERIC pairs, not critical points, and concludes a route is closed. **Is that conclusion correctly scoped, or does it overreach?** Batch 23 claims interlacing is structurally the wrong direction. Check that argument, not just its numbers.
10. **Batch 27's block.** Is the cost claim honest, and is the saturation formulation right, in particular that a basis of $\{1\}$ means what it is said to mean?
11. **The Lean file.** Does each of the 21 declarations state what the prose attributes to it? Is any vacuous? Confirm no `sorry` and standard axioms. **Exhibit a non-vacuous witness for `value_at_critical`, `disc_of_nonpos` and `elimPoly_antisymm`.** Check `elimPoly` transcribes batch 25's equation, gaps inlined, without error.
12. **Scope, across the record.** Does anything here claim $G(2)$ closed, or the $\lvert J\rvert=3$ node closed? Neither is. Check the [lean/INDEX.md](../lean/INDEX.md) row and [plan.md](../plan.md)'s I106 item against what is actually proved.
