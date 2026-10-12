# I111's $-$ branch, a Fable derivation, 2026-09-22

**Position at the switch.** The $+$ branch is closed ([r1076](REVIEW_r1076.md), [r1077](REVIEW_r1077.md)). What remains: on the $-$ branch the gain $g(\psi)\,u(t-u^2)$ with $g(\psi)=\tfrac1{\sqrt3}(1-\cos\tilde\psi)$ must exceed the deficit $-F(s,f,u)$ wherever $F<0$. [r1070](REVIEW_r1070.md)'s bound uses the Gram shape pin $\Phi(c)=\tfrac3{10}(\sum c_a)^2-\tfrac12\sum c_a^2\ge K=3-t/u^2$ alone, minimises at $c_1=c_2=c_3$, and closes $s\le0.380969$ and $s\ge0.463562$, short by $26\%$ near $s\approx0.42$.

**The setup, on the equal-$N_i$ diagonal.** $N=s^2$, $t=1-3s^2$, $\tau=\tfrac12fs^3$, $u_{\mathrm{lo}}(f)=(\theta-fs)/\sqrt3$, and

$$F(s,f,u)=\theta u^2-\tfrac{u^3}{2\sqrt3}-\tfrac{u}{\sqrt3}(1-2s^2)-\tfrac{\theta s^2}2+\tfrac{fs^3}2,$$

which at $f=1$, $u=u_{\mathrm{lo}}$ returns $-d(s)$ (`deficit_eq`). The surviving $u$-interval is $[u_{\mathrm{lo}}(f),\,u_{F=0}]$.

**Constraints NOT used by r1070's bound, each on the record:**
1. the pinning identity per block, $\cos2\beta_a=u_{\mathrm{lo}}(f)/u$ ([L221](../findings/second-order.md) item 2);
2. [r1069](REVIEW_r1069.md)'s direction confinement, every $\nu_a$ within $\arccos f$ of $(0,1,-1)$;
3. the half-rate map, $\eta_a=\gamma(\psi_a)\pm\beta_a$ with $\gamma(\psi)=\tfrac\pi2+\tfrac\psi2$;
4. the three perpendicular block equations and the $\mathcal D_n$ vector equation.

*Appended below as batches finish.*

## Batch 1: r1070's bound reproduced, and WHERE its gap sits

*Reproduced on a $41\times41\times41$ grid over $(s,f,u)$: worst ratio $0.7377$ at $s=0.41591$, r1070's "$26\%$ near $0.42$".* **The worst case sits at $f=1$, $u=u_{\mathrm{lo}}$, the pinning-tight locus**, where the record's own forcing (the section "THE FORCING HOLDS AT EVERY $s$") says $\psi=\pi$ exactly and the gain is MAXIMAL. *So the Gram-only bound is loosest precisely where the forcing is exact, because it never uses the pinning.*

## Batch 2: the direction bound is [r1069](REVIEW_r1069.md)'s, boxed at its line 31

$$\lvert\psi_a-\pi\rvert\le2\arccos f+2\beta_a,\qquad\cos2\beta_a=u_{\mathrm{lo}}(f)/u,$$

*from $\eta_a=\gamma(\psi_a)\pm\beta_a$, the half-rate map $\gamma(\pi+\delta)=\eta_0+\delta/2$, and r1069's confinement $\lvert\eta_a-\eta_0\rvert\le\arccos f$.* **r1069 screened it ALONE and found it bottoms at $0.202$ near $s=0.4459$**, which this derivation reproduces as its "dir-only" column ($0.2021$ at $s=0.44586$). *The gain factor along it is $\tfrac1{\sqrt3}\big(1-\cos(\tfrac\pi3-\lvert\delta\rvert)\big)$, which r1069's line 37 also carries.*

**AND THE NOVELTY CLAIM IS WITHDRAWN: [r1069](REVIEW_r1069.md) CARRIED BOTH BOUNDS** ([r1078](REVIEW_r1078.md)). *Its line 45 reads $\sum_a\cos^2\psi_a\ge\tfrac{5(3u^2-t)}{2u^2}=\tfrac52K$, and with $\sum m^2\le3M^2$ that gives $M\ge\sqrt{5K/6}$, which is EXACTLY [r1070](REVIEW_r1070.md)'s $g_{\mathrm{Gram}}$.* **Verified here at five values of $K$, identical to twelve digits.** *So the combination sits inside ONE review rather than between two, and "neither reader took the other's" is false: the check run was whether r1070 held r1069's bound, and never whether r1069 held r1070's.* **What survives is the evaluation**, that the two together clear the deficit everywhere with margin $1.43\%$, which neither reader computed.

## Batch 3: the maximum of the two closes the $-$ branch, margin $1.43\%$

*Grid $41\times61\times61$: combined ratio $\ge1.0225$ everywhere, worst at $s=0.454$.* **Refined by Nelder–Mead from $35\times9\times3$ starts with every constraint enforced** ($f\ge f_{\mathrm{Gram}}$, $u\ge u_{\mathrm{lo}}(f)$, $u^2\le5t/9$, $F<0$):

$$\min\frac{\text{gain}}{\text{deficit}}=1.014293\quad\text{at}\quad s=0.455838,\ f=0.992111,\ u=0.446191,$$

*where $\beta=0.828^\circ$, $2\arccos f=14.403^\circ$, $K=1.10818$, and* **the two bounds are EQUAL there, $0.161630$ each**, *which is the signature of a max-of-two minimax sitting on the crossing.* **A first refinement returned $0$ at $f=0.886$ near $s_*$ and was WRONG: it had dropped the Gram floor, and $f=0.886$ is below $f_{\mathrm{Gram}}(s_*)=1$.**

**AND THE REGION AS PRINTED OMITS TWO CONSTRAINTS** ([r1078](REVIEW_r1078.md)): $f\le1$, without which the minimum over the printed region is $0.18280$ at $f=1.5$; and the product bound $h\le1$, which is strictly tighter than the Gram cap and collapses $u$ to $u_{\mathrm{lo}}$ at $f=1$. *Neither moves the number, the search having capped $f$ at $1$ and a tighter region only raising a minimum, but the region as WRITTEN was wrong.*

**SCOPE.** *Everything here is on the equal-$N_i$, equal-$u$ ansatz that the $(s,f,u)$ parametrisation encodes, as [post F75](../findings/fence-posts.md) scopes it. Both input bounds were derived on that ansatz.*

**NOT YET DONE**: calibration of $F$ and the gain against the corner's recorded $0.0148730$ and $0.0192874$; a dense scan against a missed basin; Gate 2.

## Batch 4: calibration and the guard scan, both pass

**Calibration against the record's corner figures, to every digit.** *At $s_*$, $f=1$, $u=u_{\mathrm{lo}}$: $-F=0.0148730343$ against the record's $d(s_*)=0.0148730342706614$; $u(t-u^2)/(2\sqrt3)=0.0192873726$ against the record's $0.0192874$; ratio $1.2968015$ against [r1068](REVIEW_r1068.md)'s corrected $1.2968015$.* **So $F(s,f,u)$ and the gain multiplier are the record's, not a reconstruction.**

**Dense scan, $400\times120\times120$ over $(s,f,u)$ with every constraint enforced: worst ratio $1.018045$ at $s=0.456210$, $f=0.991712$, $u=0.445988$.** *Same basin as the refined minimiser's $1.014293$ at $s=0.455838$, and above it as a grid value must be.* **No second basin anywhere on the window.**

## The result, stated with its scope

**THE STATEMENT RESTS ON AN UNSTATED QUANTIFIER, WHICH [r1078](REVIEW_r1078.md) NAMES.** *The gain is a MAX over the three blocks. Read instead as the WORST block, using [r1070](REVIEW_r1070.md)'s coordinatewise corollary in place of its equal-$c$ optimum, the minimum is $0.70665$ and the item is OPEN.* **The max reading is the correct one**, because [L220](../findings/second-order.md) step 6 is a PER-BLOCK chain and a contradiction at any one block suffices, *but the theorem as written never says so, and a reader cannot recover it from the formula.* **So the quantifier is part of the statement and is written into it below.**

**THEOREM (on the equal-$N_i$, equal-$u$ ansatz).** *For every surviving $(s,f,u)$ on I111's $-$ branch, there EXISTS a block $a$ whose gain exceeds the deficit, which is what the chain needs since [L220](../findings/second-order.md) step 6 runs per block and one contradiction suffices:*

$$\max\Big(\text{gain}_{\mathrm{Gram}}(K),\ \text{gain}_{\mathrm{dir}}(f,\beta)\Big)\cdot u(t-u^2)\ \ge\ 1.0142\cdot\big(-F(s,f,u)\big),$$

**THE CONSTANT IS $1.0142$, NOT $1.0143$** ([r1079](REVIEW_r1079.md)): *$1.0143$ is the minimum $1.014293$ rounded UP, so the inequality as first printed FAILS at its own minimiser, by $7.2\times10^{-6}$.*

*with $\text{gain}_{\mathrm{Gram}}$ [r1070](REVIEW_r1070.md)'s bound from $\Phi(c)\ge K=3-t/u^2$ and $\text{gain}_{\mathrm{dir}}=\tfrac1{\sqrt3}\big(1-\cos(\tfrac\pi3-2\arccos f-2\beta)\big)$ [r1069](REVIEW_r1069.md)'s bound from $\lvert\psi_a-\pi\rvert\le2\arccos f+2\beta$.* **Together with the $+$ branch's closure ([r1076](REVIEW_r1076.md), [r1077](REVIEW_r1077.md)), this closes [I111](../plan.md) on the ansatz, and with it [I104](../plan.md)'s $\tau>0$ case there.**

**What is NEW is only the combination.** *Each bound is on the record under its reviewer's name and each is individually short, r1070's by $26\%$ at $s\approx0.416$ and r1069's by $80\%$ at $s\approx0.446$; their maximum is short nowhere, because each is loose where the other is tight.* **The worst point is where the two bounds CROSS, which is what a max-of-two minimax looks like when it is real.** *And the $1.43\%$ margin is UNDERSTATED* ([r1079](REVIEW_r1079.md)): $g_{\mathrm{dir}}$ uses $\arccos f$ where the record's own equality gives $\arccos\sqrt{g/N}$, tighter at every $u>u_{\mathrm{lo}}$, *and with it the minimum rises to $1.021551$, so the closure has $2.16\%$ of room.* **The region also omits the product band top** $u^2\le u_{\mathrm{lo}}(f)^2+s^2(1-f^2)/3$, *which this file derives from $g\le N$; conservative, and the minimum is unchanged with it enforced.*

**What is NOT established.** *Anything off the equal-$u$ ansatz. Both input bounds were derived on it, [post F75](../findings/fence-posts.md) scopes the invertibility to it, and the $(s,f,u)$ parametrisation IS it.* **Lifting the ansatz is the next item and is not this one.**

*Fable derivation ends here. Recording, typing and Gate 2 wait for the switch back to Opus.*
