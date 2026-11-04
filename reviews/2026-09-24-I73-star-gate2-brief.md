# Gate 2 brief, I73 seven-frame lemma, STAR side (2026-09-24)

You are an independent adversarial reviewer. BREAK the claim below: find the gap in the written chain, the missing hypothesis, the excluded case, or a counterexample. Return CONFIRMED, PLAUSIBLE or REFUTED per numbered item, with corrections.

## Standing rule: analysis only
Argue from the definitions. You MAY run seconds of computation on objects you construct to SCREEN or REFUTE a step (say why an argument could not); you may NOT run sweeps, censuses, optimisations of unknown cost or unbounded hunts.

## Givens (proved elsewhere, take as true)
- Norm: <X,Y> = -1/2 tr XY on so(n). For X with angles a_k (block rotations), |X|^2 = sum a_k^2.
- Slot spectrum (L237's proof): -ad_X^2 has eigenvalues (a_k+a_l)^2 and (a_k-a_l)^2 for planes k<l, and a_k^2 on the kernel couplings, each on a 2-dimensional slot space.
- L237: for unit X0 and orthonormal X1..X6, sum_j ||[X0,Xj]||^2 <= kappa_6 = 8 (Ky Fan), with equality configurations the triangle (1,1,1)/sqrt3 and the star (3,1,1,1)/sqrt12.
- Neighbourhood lemma (Lean `c_*` in lean/HamiltonsCubic/Results/SevenFrameGap.lean): every three-slot configuration other than triangle and star has slot sum at most (19/5)|s|^2 (the tightest, path-with-kernel-slot, exactly (2+sqrt3)|s|^2), so an element with row > 7.6 has a triangle or a star as its top six-eigenspace.
- L239 (the triangle side, Gate 2 passed): if some element has deficit < 0.277 and a TRIANGLE top eigenspace, then T <= 53.05.
- Deficit identities (Lean `deficit_triangle`, `deficit_star`): 8 - 2(triangle slot sum) = 6(1-p^2) + 2(1-|v|^2); 8 - 2(star slot sum) = 6(1-p^2) + 2(1-|v|^2) + 1/2(a-L)^2, with p the alignment of the angle subvector v with the pattern (1,1,1)/sqrt3 or (3,1,1,1)/sqrt12, L the leaf sum.

## The claim, verbatim from reviews/2026-09-24-I73-seven-frame-stability.md

## A second route that closes both sides: count the partners' own deficits

**Every element of $E$ is far from the extremal set $\mathrm{Ext}$** (unit triangles and stars). Elements of $E$ have equal angles, rank $4$ (section 10 of the summed-pair note, for both types), so by von Neumann's inequality for skew matrices $\langle Y,Z\rangle\le\sqrt{2/3}\,\lVert Y\rVert$ for $Z\in\mathrm{Ext}$, and $\mathop{\mathrm{dist}}(Y,\mathrm{Ext})^2\ge r^2+1-2\sqrt{2/3}\,r\ge\tfrac13$ at every radius $r$. **So a partner $X_j=Y_j+D_j$ sits at distance at least $\sqrt{1/3}-\lVert D_j\rVert$ from $\mathrm{Ext}$**, and its own row pays for that distance: $\delta_j\ge\varphi(\mathop{\mathrm{dist}}^2)$.

*Screen* ([stability](../scripts/misc/screen_I73_stability.py), [phi](../scripts/misc/screen_I73_phi.py)): $\varphi(d^2)\approx\min(5.9\,d^2,\,0.536)$, the plateau being exactly $8-2(2+\sqrt3)$, the ceiling of the path-with-kernel class. With $\eta\le0.75$ at most two partners can be near $\mathrm{Ext}$ ($d_j^2\ge\tfrac13$ each), and the other four already carry $\sum\delta_j\ge4(0.536)>1.94$; with the leak spread evenly each partner sits at $d^2\approx0.09$ and pays about $0.5$. **So $T\le54.064$ on both sides**, once four pieces are proved:

1. **A star gap lemma**, bounding $\eta$ on the star side (screened worst $0.734$), as `triangle_gap_*` does on the triangle side.
2. **Equal angles on $E$ for the star**, and von Neumann's inequality for skew matrices, giving the $\sqrt{2/3}$.
3. **The deficit bound** $8-S_6(X)\ge\min(c\mathop{\mathrm{dist}}^2,\,8-2(2+\sqrt3))$ with $c$ near $5.9$: locally $y=8B+2\Delta\ge6(B+\Delta/3)\approx6\mathop{\mathrm{dist}}^2$ at the triangle, and the plateau from the seventeen class bounds at their exact ceilings.
4. **The counting**: $\sum_j\varphi\big((\sqrt{1/3}-d_j)_+^2\big)\ge1.94-x$ under $\sum d_j^2\le\eta$.

*This route uses no bracket-energy bound at all.*

**Piece 3 is proved, sharper than the screen.** For a triangle, $8-2\sum(a+a)^2=6(1-p^2)+2(1-\lVert v\rVert^2)$, and for a star $8-2\sum(a+l_b)^2=6(1-p^2)+2(1-\lVert v\rVert^2)+\tfrac12(a-L)^2$, with $p$ the alignment with the pattern and $L$ the leaf sum (`deficit_triangle`, `deficit_star`). Since $\mathop{\mathrm{dist}}^2\le2-2p$, every unit $X$ has $8-S_6(X)\ge\min\big(8-2(2+\sqrt3),\,6d^2(1-d^2/4)\big)$ (`deficit_of_dist`, the plateau from the seventeen class bounds). The top space's distance $\ge\sqrt{1/3}$ is `far_from_ext`.

**The counting (piece 4, screened)** needs the leak below about $0.6$: the smallest partner-deficit sum is $2.12$ at $\eta=0.5$, $1.91$ at $0.6$, $1.57$ at $0.75$ ([count](../scripts/misc/screen_I73_count.py)). **So the route reproves [L239](../findings/second-order.md)**, where $\eta\le\tfrac12$ gives $2.12>1.936$, and **falls short on the star side**, where the gap bound allows $\eta\le0.734$. *Taking all maps out of the dominant plane as the reference ($\mathfrak p$, gap about $1$) lowers the distance to $0.408$ and fails worse ($\eta\le0.22$ needed, $0.277$ available).* **The owed estimate is the weighted one**: leaks into the kernel slots cost $\tfrac7{12}$ each in row $0$ but pull a partner towards $\mathrm{Ext}$ only gradually (from $0.577$ at equal angles towards $0.408$), so charging each leak at its own slot and its own distance loss is the version with room.


## The weighted count closes the star side, on a screen

**The cheap leaks are harmless at first order.** On the star side split a partner as $X_j=Y_j+K_j+R_j$: $Y_j$ in $E'$, every $+$ slot from the dominant plane $\pi_1$ to any other plane (all anti-linear, so all equal-angle, and free in row $0$ up to their own small gap); $K_j=p\wedge u_1+q\wedge u_2$ in the kernel slots of $\pi_1$, gap $g_K=\mu_6-a_1^2$ ($\tfrac7{12}$ at the exact star); $R_j$ everything else, gap $g_M\approx1$. **$Y_j+K_j=p\wedge w_1+q\wedge w_2$ has Gram $\rho^2I+\mathrm{Gram}(u)$**, the cross terms vanishing because the kernel is orthogonal to every plane, so its two angles satisfy $\alpha^2-\beta^2\le\lVert K_j\rVert^2$: **the kernel leak moves a partner towards $\mathrm{Ext}$ only at second order.** By von Neumann's inequality its alignment with $\mathrm{Ext}$ is at most $\max\big(\tfrac{\sqrt3}2\alpha+\tfrac1{\sqrt{12}}\beta,\ (\alpha+\beta)/\sqrt3\big)$, so $\mathop{\mathrm{dist}}(X_j,\mathrm{Ext})\ge\sqrt{1-\mathrm{align}^2}-\lVert R_j\rVert$. **Row $0$ pays exactly** $\sum_{c\notin E}(\mu_6-\mu_c)w_c\le x-y$ with $w_c$ the partners' weight on each eigendirection.

*Screen* ([weighted](../scripts/misc/screen_I73_weighted.py), 3000 near-star $X_0$ with $y\le0.277$ and a fifth plane, worst allocation by local search): **the partners' deficits total at least $2.70$ against a requirement of at most $1.936-x\approx1.67$, margin $+1.03$.** *Owed analytically*: (1) star gap lemmas, lower bounds on $g_K=l_{\min}(2a_1+l_{\min})$ and $g_M$ for $y\le0.277$; (2) the Gram computation above, and equal angles on $E'$; (3) von Neumann for skew matrices; (4) the counting lemma under the weighted budget. **With those four, the seven-frame lemma holds**, the triangle side being [L239](../findings/second-order.md).


## The star side, assembled

**Claim.** An orthonormal seven-frame in $\mathfrak{so}(n)$ with an element $X_0$ of row deficit $x<0.277$ whose top eigenspace is a STAR has $T\le54.064$. With [L239](../findings/second-order.md) and the neighbourhood lemma this gives **the seven-frame lemma: every orthonormal seven-frame has $T\le54.064$**.

**Proof.** Let $X_0$ have angles $a$ on its dominant plane $\pi_1$, $l_1,l_2,l_3$ on its three leaves, $b$ the largest further angle, and $y=8-2\sum(a+l_i)^2\le x$. Split each partner as $X_j=Y_j+K_j+R_j$: $Y_j$ in $E$ (the three $+$ slots from $\pi_1$ to the leaves); $K_j$ the maps from $\pi_1$ into the complement of $\pi_1$ and the leaves; $R_j$ the rest.

1. **Row $0$ pays for the leaks.** $A=-\mathrm{ad}_{X_0}^2$ preserves each slot space, so with $w_c$ the partners' weight on eigendirection $c$, $\mathrm{row}_0=\sum_c\mu_cw_c$, $0\le w_c\le1$, $\sum w_c=6$, and the Ky Fan bound gives $x-y\ge g_K\sum_j\lVert K_j\rVert^2+g_M\sum_j\lVert R_j\rVert^2$, with $g_K=\mu_6-\max\{(a+b)^2,a^2\}$ and $g_M=\mu_6-\max\{(a-l)^2,(l+l')^2,(l+b)^2,l^2,2B\}$.
2. **The gaps are large enough** (proved): $0.677\,g_M+y\ge0.3$ and $3\,g_K+y\ge0.3$ for $y\le0.277$, so $g_K,g_M>0$.
3. **Partners are far from the triangles and stars.** $Y_j+K_j=p\wedge w_1+q\wedge w_2$ with $\mathrm{Gram}(w)=\rho_0^2I+\mathrm{Gram}(u)$, since $E$ is anti-linear (equal, orthogonal images) and the kernel directions are orthogonal to every plane; so its two angles have $\alpha^2-\beta^2=\kappa_j\le\lVert K_j\rVert^2/\lVert Y_j+K_j\rVert^2$. Von Neumann's inequality for skew matrices bounds its alignment with any triangle or star by the star branch $\tfrac{\sqrt3}2\alpha+\tfrac1{\sqrt{12}}\beta$ (which dominates the triangle branch), so $\mathop{\mathrm{dist}}(X_j,\mathrm{Ext})\ge\rho(\kappa_j)-\lVert R_j\rVert$ with $\rho(\kappa)^2=\tfrac7{12}-\tfrac\kappa3-\tfrac14\sqrt{1-\kappa^2}$.
4. **Each partner's own row pays for its distance** (proved): $\delta_j\ge\min\big(4-2\sqrt3,\,6d^2(1-d^2/4)\big)$ at distance $d$, from the exact deficit identities and the seventeen class bounds.
5. **The damage is at most $\tfrac12\kappa_j+2.3\lVert R_j\rVert^2$** (proved, `lam_pos`, `lam_neg`).
6. **Count.** $\sum_{j\ge1}\delta_j\ge6(4-2\sqrt3)-D$ with $D\le\max\big(\tfrac{0.5}{g_K},\tfrac{2.3}{g_M}\big)(x-y)$. Step 2 gives $\tfrac{2.3}{g_M}\le\tfrac{1.557}{0.3-y}$ and $\tfrac{0.5}{g_K}\le\tfrac{1.5}{0.3-y}$, so $D\le1.557\,\tfrac{x-y}{0.3-y}\le1.557\,\tfrac{x}{0.3}=5.19x$ (the ratio decreases in $y$ when $x\le0.3$). If $T>54.064$ then $x\le\sum\delta_i/7<0.27657$, and $\sum_{j\ge1}\delta_j\ge3.2154-5.19x>1.936-x$ holds for $x<0.3053$, so $T=56-x-\sum_{j\ge1}\delta_j<54.064$, a contradiction. $\square$ *The margin in $x$ is $0.029$.*

*What is typed*: steps 2, 4 and 5, and the scalar arithmetic, in [SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean). *What is prose*: the slot spectrum, the Ky Fan weights of step 1, the Gram computation and von Neumann's inequality of step 3, the dist-to-alignment step, and the count's final line.


## Attack items
1. The overall logic: with L239 and the neighbourhood lemma, does the star-side claim give "every orthonormal seven-frame has T <= 54.064"? Is the case split (least-deficit element triangle or star) exhaustive, including ties in the top six eigenvalues and elements with no kernel?
2. Step 1: is the weighted Ky Fan budget x - y >= g_K sum|K_j|^2 + g_M sum|R_j|^2 correct? Which eigendirections carry weight, what happens to the E-part weights, and are the + slots from pi_1 to further planes correctly charged at g_K (they have eigenvalue (a+b)^2)?
3. Step 1's split: is every eigendirection of A outside E assigned to exactly one of K (charged g_K) or R (charged g_M), and are g_K and g_M the correct minima over their classes? In particular the classes of so(pi_1), so(pi_1-perp), the minus slots pi_1 to the leaves, and the kernel slots of the leaves.
4. Step 3, the Gram computation: are E's elements anti-linear so that their two images are equal-length and orthogonal, and are K's images orthogonal to E's images, so Gram(w) = rho0^2 I + Gram(u)? Is alpha^2 - beta^2 <= |K|^2 / |Y+K|^2 correct, or does the normalisation change kappa?
5. Step 3, alignment: is von Neumann's inequality for skew matrices (alignment <= sum of sorted angle products) correctly applied to a rank-four element against every triangle and star, and does the star branch dominate for all kappa in [0,1]? Is dist(X,Ext)^2 >= 1 - align^2 (minimised over the radius) the right distance bound, and does dist(X_j) >= rho(kappa_j) - |R_j| follow?
6. Step 4: from the deficit identities, is 8 - S6(X) >= min(4-2sqrt3, 6d^2(1-d^2/4)) correct for every unit X at distance d from Ext? Check the case where S6 is attained by a non-triangle/star configuration, and the dist^2 <= 2 - 2p step.
7. Step 5: are lam_pos and lam_neg the right statements (damage <= 0.5 kappa + 2.3 m^2), with phi_low covering the region below the plateau?
8. Step 6: is the count correct? Check D <= max(0.5/g_K, 2.3/g_M)(x-y), the conversion via step 2 to D <= 5.19x, and the final inequality 3.2154 - 5.19x > 1.936 - x for x < 0.3053, and that T > 54.064 forces x < 0.27657.
9. Scope and hidden assumptions: n, the kernel's presence or absence, repeated angles, a fifth plane with angle near the smallest leaf, and whether the six partners' weights can exceed what step 1 allows.

## Lean section
| Claim | Declaration |
|---|---|
| Star gap lemma, first-order slots | `sgM_minus_same`, `sgM_minus_other`, `sgM_leaves_in`, `sgM_mass`, `sgM_bulk` with `R_leaves_out`, `R_leaf_b_out`, `R_leaf_b_in`, `bulk_core` |
| Star gap lemma, kernel gap | `sgK`, `sgK_core` |
| Neighbourhood | `c_*`, `c_threshold` |
| Deficit identities and distance | `deficit_triangle`, `deficit_star`, `deficit_of_dist`, `far_from_ext` |
| Leak constants | `lam_pos`, `lam_neg`, `phi_low`, `star_ge_tri`, `plateau_le` |
| Slot spectrum, Ky Fan weights, Gram computation, von Neumann, assembly of step 6 | none: the layer carries only block-pair root slots (RootSlots.lean) and scalar Ky Fan (KyFanPrinciple.lean); prose |

All in lean/HamiltonsCubic/Results/SevenFrameGap.lean. For typed rows, check only that the STATEMENTS say what the prose needs (variables, hypotheses, constants); the kernel checked the proofs.

## Protocol
- Log to agent_logs/<id>.log: first line with id and phase plan; a line per phase; a heartbeat with live state at least every ~3 minutes; LAST line must START with `DONE <summary>` or `FAILED <reason>`.
- Report to reviews/REVIEW_<id>.md: skeleton first (title, claim table with every verdict NOT REACHED, log path), overwrite rows as you go. Do NOT edit reviews/INDEX.md or any other record file. Do NOT commit.
- Work from the definitions. Do not read the other reviewer's files.
