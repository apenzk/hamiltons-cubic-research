# Gate 2 brief, the repair of the star-side count (2026-09-24)

You are one independent reviewer checking a REPAIR made after [r1121](REVIEW_r1121.md) and [r1122](REVIEW_r1122.md) refuted step 6 of the star-side proof. Return CONFIRMED, PLAUSIBLE or REFUTED per item, with corrections.

## Standing rule: analysis only
Seconds of screening on objects you construct are allowed to refute or check a step; no sweeps, censuses or optimisations of unknown cost.

## The two defects the repair answers
1. Step 3 supplies the NORMALISED kernel leak kappa_j = (alpha^2-beta^2)/|Y_j+K_j|^2 <= ||K_j||^2/(1-m_j^2), m_j = ||R_j||, but step 6 charged kappa_j against the budget g_K sum ||K_j||^2 as if kappa_j <= ||K_j||^2.
2. Step 4's plateau 4 - 2 sqrt3 needs every non-extremal three-slot configuration to have slot sum at most (2+sqrt3)|s|^2; Lean had only a 19/5 bound on a list of seventeen classes that missed the star with one minus slot.

## The repaired claim, verbatim from reviews/2026-09-24-I73-seven-frame-stability.md

## The star side, assembled

**Claim.** An orthonormal seven-frame in $\mathfrak{so}(n)$ with an element $X_0$ of row deficit $x<0.277$ whose top eigenspace is a STAR has $T\le54.064$. With [L239](../findings/second-order.md) and the neighbourhood lemma this gives **the seven-frame lemma: every orthonormal seven-frame has $T\le54.064$**.

**Proof.** Let $X_0$ have angles $a$ on its dominant plane $\pi_1$, $l_1,l_2,l_3$ on its three leaves, $b$ the largest further angle, and $y=8-2\sum(a+l_i)^2\le x$. Split each partner as $X_j=Y_j+K_j+R_j$: $Y_j$ in $E$ (the three $+$ slots from $\pi_1$ to the leaves); $K_j$ the maps from $\pi_1$ into the complement of $\pi_1$ and the leaves; $R_j$ the rest.

1. **Row $0$ pays for the leaks.** $A=-\mathrm{ad}_{X_0}^2$ preserves each slot space, so with $w_c$ the partners' weight on eigendirection $c$, $\mathrm{row}_0=\sum_c\mu_cw_c$, $0\le w_c\le1$, $\sum w_c=6$, and the Ky Fan bound gives $x-y\ge g_K\sum_j\lVert K_j\rVert^2+g_M\sum_j\lVert R_j\rVert^2$, with $g_K=\mu_6-\max\{(a+b)^2,a^2\}$ and $g_M=\mu_6-\max\{(a-l)^2,(l+l')^2,(l+b)^2,l^2,2B\}$.
2. **The gaps are large enough** (proved): $0.677\,g_M+y\ge0.3$ and $3\,g_K+y\ge0.3$ for $y\le0.277$, so $g_K,g_M>0$.
3. **Partners are far from the triangles and stars.** $Y_j+K_j=p\wedge w_1+q\wedge w_2$ with $\mathrm{Gram}(w)=\rho_0^2I+\mathrm{Gram}(u)$, since $E$ is anti-linear (equal, orthogonal images) and the kernel directions are orthogonal to every plane; so its two angles have $\alpha^2-\beta^2=\kappa_j\le\lVert K_j\rVert^2/\lVert Y_j+K_j\rVert^2$. Von Neumann's inequality for skew matrices bounds its alignment with any triangle or star by the star branch $\tfrac{\sqrt3}2\alpha+\tfrac1{\sqrt{12}}\beta$ (which dominates the triangle branch), so $\operatorname{dist}(X_j,\mathrm{Ext})\ge\rho(\kappa_j)-\lVert R_j\rVert$ with $\rho(\kappa)^2=\tfrac7{12}-\tfrac\kappa3-\tfrac14\sqrt{1-\kappa^2}$.
4. **Each partner's own row pays for its distance** (proved): $\delta_j\ge\min\big(0.534,\,6d^2(1-d^2/4)\big)$ at distance $d$, from the exact deficit identities and the ceilings of the fifty-two other three-slot configurations at $3.733$ for nonnegative angles (`slot_ceiling_*`; the exact maximum is $2+\sqrt3$, attained by the path with a kernel slot and by the star with one minus slot).
5. **The damage is at most $\tfrac12\lVert K_j\rVert^2+2.4\lVert R_j\rVert^2$** (proved, `lam_pos_norm`, `lam_neg_norm`). *Step 3 gives the NORMALISED $\kappa_j\le\lVert K_j\rVert^2/(1-m_j^2)$, so the bound is stated with the budget paying $\kappa_j(1-m_j^2)\le\lVert K_j\rVert^2$; its certificate is $A\cdot F=(Am-5.86\rho)^2+G(\kappa,c)$ with $A=8.26-\kappa/2$ and $G\ge0$ on the arc (`lamG`, minimum $0.111$).*
6. **Count.** $\sum_{j\ge1}\delta_j\ge6(0.534)-D$ with $D\le\max\big(\tfrac{0.5}{g_K},\tfrac{2.4}{g_M}\big)(x-y)$. Step 2 gives $\tfrac{2.4}{g_M}\le\tfrac{1.6248}{0.3-y}$ and $\tfrac{0.5}{g_K}\le\tfrac{1.5}{0.3-y}$, so $D\le1.6248\,\tfrac{x-y}{0.3-y}\le1.6248\,\tfrac{x}{0.3}=5.416x$ (the ratio decreases in $y$ when $x\le0.3$). If $T>54.064$ then $x\le\sum\delta_i/7<0.27657$, and $\sum_{j\ge1}\delta_j\ge3.204-5.416x>1.936-x$ holds for $x<0.2871$, so $T=56-x-\sum_{j\ge1}\delta_j<54.064$, a contradiction. $\square$ *The margin in $x$ is $0.0106$.*

**Gate 2 by [r1121](REVIEW_r1121.md) and [r1122](REVIEW_r1122.md)**, independently: steps 1 to 3 and 5 CONFIRMED; both found that step 6 charged the unnormalised $\lVert K_j\rVert^2$ where step 3 supplies only the normalised $\kappa_j$ (explicit counterexamples to the per-partner bound $\tfrac12\kappa+2.3m^2$), and that step 4's plateau rested on class ceilings typed only at $\tfrac{19}5$, with a class (the star with one minus slot) missing from the list. **Steps 4 to 6 above are the repair**: the normalised damage bound at $\lambda_M=2.4$, and all fifty-two ceilings typed.

*What is typed*: steps 2, 4 and 5, and the scalar arithmetic, in [SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean). *What is prose*: the slot spectrum, the Ky Fan weights of step 1, the Gram computation and von Neumann's inequality of step 3, the dist-to-alignment step, and the count's final line.


## Items
1. Completeness: do the `slot_ceiling_*` lemmas in lean/HamiltonsCubic/Results/SevenFrameGap.lean cover EVERY three-slot configuration (plus slots (a_i+a_j)^2, minus slots (a_i-a_j)^2, kernel loops a_i^2, distinct slots, up to relabelling) other than the all-plus triangle and all-plus star? Count them against your own enumeration (the parent found 54 in total). Is the nonnegativity hypothesis on the angles legitimate where the lemmas are used?
2. The plateau: with every non-extremal configuration at most 3.733|s|^2, does step 4's deficit bound min(0.534, 6d^2(1-d^2/4)) follow?
3. Normalisation: do `lam_pos_norm` and `lam_neg_norm` state what step 5 needs, with kappa the normalised quantity, and the budget paying kappa(1-m^2) <= ||K||^2? Is `lamG` (the discriminant G >= 0 on the arc) the right certificate, and is the identity A F = (A m - 5.86 rho)^2 + G correct (A = 8.26 - kappa/2)?
4. The case m >= rho (lam_neg_norm): is the hypothesis m <= 1 available where it is used?
5. The count: check each line of step 6 (2.4 * 0.677 = 1.6248; 0.5 * 3 = 1.5; the ratio monotonicity in y; 1.6248/0.3 = 5.416; 6 * 0.534 = 3.204; the threshold x < 0.2871; x < 0.27657 from T > 54.064).
6. Does the damage bound interact correctly with phi's plateau now at 0.534 (phi_low's threshold e^2 <= 0.0914)?

## Lean section
| Claim | Declaration |
|---|---|
| Ceilings | `slot_ceiling_0` .. `slot_ceiling_51`, `slot_threshold` |
| Normalised damage | `lam_pos_norm`, `lam_neg_norm`, `lamG`, `phi_low` |
| Gaps (unchanged, already reviewed) | `sgM_*`, `sgM_bulk`, `sgK` |
| The count's arithmetic | none: prose, step 6 |

Kernel-checked proofs need no re-checking; check the STATEMENTS.

## Protocol
Log to agent_logs/r1123.log (first line with id and phase plan, a line per phase, heartbeat every ~3 min, LAST line starts `DONE <summary>` or `FAILED <reason>`). Report to reviews/REVIEW_r1123.md, skeleton first. Do NOT edit reviews/INDEX.md or any record file. Do NOT commit.
