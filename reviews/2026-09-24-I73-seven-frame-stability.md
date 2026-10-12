# I73, the seven-frame lemma: a stability reduction, closed on the triangle side, obstructed on the star side

*Derived 2026-09-24 at effort `medium` (`$CLAUDE_EFFORT` read `medium`), after the [targeted sweep](2026-09-24-LIT-I73-sweep.md) found no published bound. **Gate 2 on the triangle side by [r1119](REVIEW_r1119.md) and [r1120](REVIEW_r1120.md)**: every item CONFIRMED, the constant corrected to $53.05$, the top-eigenspace hypothesis made explicit, and the scope widened to any triangle-type element of deficit below $0.277$. Recorded as [L239](../findings/second-order.md). Screens are labelled as screens.*

## Setting

$X_0,\dots,X_6$ orthonormal in $\mathfrak{so}(n)$, $\langle X,Y\rangle=-\tfrac12\operatorname{tr}XY$, $\mathrm{row}_i=\sum_{j\ne i}\lVert[X_i,X_j]\rVert^2$, $T=\sum_i\mathrm{row}_i$. [L237](../findings/second-order.md): $\mathrm{row}_i\le\kappa_6=8$, so with $\delta_i=8-\mathrm{row}_i\ge0$, $T=56-\sum_i\delta_i$. **Owed**: $T\le54.064$ uniformly in $n$ (section 10 of [the summed-pair note](2026-09-23-I73c-summed-pairs.md)).

Relabel so that $\delta_0=x$ is the smallest deficit. Then
$$T\le56-7x,\qquad T=16-2x+T',\quad T'=\sum_{j\ne k\ge1}\lVert[X_j,X_k]\rVert^2. \tag{1}$$
If $T>54.064$ then $x<0.277$.

## The reference space and the decomposition

$A=-\mathrm{ad}_{X_0}^2$ has the slot spectrum of L237's proof: with the angles $a$ of $X_0$, the values $(a_k\pm a_l)^2$ and, when $X_0$ has a kernel, $a_k^2$, each on its own $2$-dimensional slot space, **and the slot spaces depend only on the planes of $X_0$, never on the angle values.** $\kappa_6=8$ is attained by exactly two three-slot configurations of $+$ slots, the triangle (planes $1,2,3$) and the star (plane $1$ with leaves $2,3,4$); every other three-slot class is strictly below $4$ ([KyFanBracketCap.lean](../lean/HamiltonsCubic/Results/KyFanBracketCap.lean) enumerates the nineteen), so on a neighbourhood of $\mathrm{row}_0=8$ the top configuration is a triangle or a star. **That neighbourhood contains every row above $7.6$**: each of the other seventeen classes is at most $\tfrac{19}5$ times the angles' squared norm, the tightest being the path with a kernel slot at $2+\sqrt3\approx3.732$ (`c_*` in [SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean)). $E$, the sum of the three slot spaces of the top configuration, is $6$-dimensional and $A$-invariant.

Write $X_j=Y_j+D_j$, $Y_j\in E$, $D_j\perp E$, $\eta=\sum_{j\ge1}\lVert D_j\rVert^2$, $y=8-\operatorname{tr}(A|_E)\ge0$ (the angle deficit), and $g=\min\mathrm{spec}(A|_E)-\max\mathrm{spec}(A|_{E^\perp})$ (the gap).

**(R1) The leak is paid for in row 0.** $\mathrm{row}_0=\operatorname{tr}(A\Pi)$ with $\Pi$ the projector onto the partners, $A$ preserves $E$, and $\operatorname{tr}\Pi_{EE}=6-\eta$, so $\mathrm{row}_0\le\operatorname{tr}(A|_E)-g\eta$, that is
$$g\,\eta\le x-y. \tag{2}$$

**(R2) Three structural facts about $E$.**
- **Energy.** $\sum_{a,b}\lVert[e_a,e_b]\rVert^2=24$ over an orthonormal basis of $E$, for both configurations. *Triangle, derived*: $E=\mathfrak m$, the anti-$J$-linear part of $\mathfrak{so}(6)$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak u(3)$, and the sum equals $\sum_c\operatorname{tr}(-\mathrm{ad}_{f_c}^2|_{\mathfrak m})$ over a basis of $\mathfrak u(3)$, which is $8\cdot2+1\cdot8=24$ by the two values below. *Star: screened*, [slot_costs.py](../scripts/misc/screen_I73_slot_costs.py) returns $24$. Since the partners' Gram operator on $E$ is at most the identity, $\sum_{j\ne k}\lVert[Y_j,Y_k]\rVert^2\le24$.
- **Orthogonality.** $[E,E]\perp[E,E^\perp]$. *Derived from the weight decomposition*: $E$ is the sum of the root spaces $\pm(e_k+e_l)$ of its configuration, $[E,E]$ has weights $0$ and $\pm(e_k-e_l)$ inside the configuration, and $\pm(e_k+e_l)+\gamma$ lands on one of those only for $\gamma$ a root of $E$ itself. So the terms of $T'$ linear in the $D_j$ vanish.
- **Leak cost.** $\sum_{j}\lVert[Y_j,D]\rVert^2\le Q(D):=\operatorname{tr}(-\mathrm{ad}_D^2|_E)$. *Triangle, derived*: $Q$ is $U(3)$-invariant, so it is $2$ on $\mathfrak{su}(3)$, $8$ on $\mathbb RJ$, $2$ on $W\wedge W^\perp$ (via $\sum_a Y_a^{\mathsf T}Y_a=2I_W$) and $0$ on $\mathfrak{so}(W^\perp)$, with no cross terms. The $J$-component of a $D_j\perp X_0$ is at most $\lVert D_j\rVert\sqrt{(y/6)/(1-y/6)}$, since $X_0$'s distance from $\mathbb RJ$ is $\sqrt{B+\Delta/3}\le\sqrt{y/6}$ (with $B$ the mass off the triangle and $\Delta=\sum_{k<l}(a_k-a_l)^2$, $y=8B+2\Delta$).

**(R3) The bound.** With $a,b,c$ the $YY$, the $YD+DY$ and the $DD$ parts of the partners' brackets, $a\perp b$, $\lVert a\rVert^2\le24$, $\lVert b\rVert^2\le4\sum_kQ(D_k)$, and $\lVert c\rVert^2\le\tfrac43\eta^2$ by [Ge 2014](../references/ge-2014-ddvv-skew-symmetric/notes.md)'s skew DDVV constant in this norm,
$$T\le16-2x+\big(\sqrt{24}+\sqrt{4/3}\,\eta\big)^2+\lVert b\rVert^2+2\sqrt{4/3}\,\eta\lVert b\rVert. \tag{3}$$

## The triangle side closes, and its gap lemma is proved in Lean

**Leak cost.** $Q(D_k)\le2\lVert D_k\rVert^2+6c_k^2$ with $c_k^2\le\lVert D_k\rVert^2\,y/(6-y)$ (*$y/6$ suffices, [r1119](REVIEW_r1119.md), [r1120](REVIEW_r1120.md); the looser form is kept since the margin does not need it*), so for $y\le0.277$, $\lVert b\rVert^2\le4\sum_kQ(D_k)\le9.16\,\eta$.

**Gap lemma, proved** ([SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean), eight declarations on the standard three axioms): against every competing slot, $\tfrac12g+y\ge0.277$. *Proof*: with $\sigma=\sum a_k$ and $u$ a deviation bound, the variance fact $(a_i-\sigma/3)^2\le\tfrac23(\sum a_k^2-\sigma^2/3)$ gives $y\ge8B+9u^2$ and $\sigma^2=3(1-B)-(y-8B)/2$, and each slot then reduces to a concave quadratic in $(b,u)$ with worst value about $0.38$: a slot joining the third plane (`triangle_gap_other`), a slot joining a plane of the pair, which with $b=0$ covers the kernel and difference slots (`triangle_gap_same`), and a slot of the leftover mass (`triangle_gap_small`).

**The case hypothesis.** The triangle side is the case where $E$ is the TOP six-dimensional eigenspace of $A$. Then $\operatorname{tr}(A|_E)$ is the Ky Fan sum, so $\mathrm{row}_0\le\operatorname{tr}(A|_E)$ gives $y\le x$, and only then does the gap lemma give $g>0$. At repeated angles the individual slot spaces are not defined but their sum $E=\mathfrak m_{J}$ is, which is all the argument uses.

**The assembly.** $x<0.277$ and $y\le x$ give $g>0$ and $\eta\le(x-y)/g\le\tfrac12$. Then (3) gives $\lVert c\rVert\le0.577$, $\lVert b\rVert^2\le4.58$, and
$$T\le16+\big(\sqrt{24}+0.5774\big)^2+4.58+2(2.140)(0.5774)\le53.05<54.064,$$
against (1). *The element need not be the one of least deficit: $T=2\,\mathrm{row}_i+T'_i$ for every $i$, so any triangle-type element with deficit below $0.277$ serves* ([r1119](REVIEW_r1119.md)). **So on the triangle side the seven-frame lemma holds**, modulo the prose steps (R1)–(R3), the slot spectrum and the neighbourhood size owed above, all untyped. *The screen's worst leak, $0.318$, sits well inside the $\tfrac12$ the gap lemma proves.*

## The star side does not close by this route, and why

At the exact star $(3,1,1,1)/\sqrt{12}$ the leak costs, per direction of $E^\perp$ (*screen*, [slot_costs.py](../scripts/misc/screen_I73_slot_costs.py)):

| $A$-eigenvalue | slot | multiplicity | gap to $\tfrac43$ | $\max Q$ |
|---|---|---|---|---|
| $\tfrac34$ | plane $1$ to the kernel | $2$ | $\tfrac7{12}$ | $3$ |
| $\tfrac13$ | leaf $-$ slots and leaf-leaf $+$ | $12$ | $1$ | $2$ |
| $\tfrac1{12}$ | leaf-leaf $-$ slots | $6$ | $\tfrac54$ | $1$ |
| $0$ | the rest | $16$ | $\tfrac43$ | $2$ |

The kernel direction costs $4Q/g=20.6$ per unit of row deficit, against $8$ on the triangle, and **near-stars with a fourth small leaf push the gap towards $0$** (screen: $g=0.16$ at $y=0.16$), where the fourth leaf's slot costs $Q=3$ and (2) allows $\eta\approx0.73$. (3) then returns about $63$. **So the star side needs a reference space that follows the leaves**, the anti-linear maps from the dominant plane to its complement rather than three fixed slots, together with its own energy bound. *At the exact star the frame totals $40$ (section 10 of the note), so the loss is in the estimate, not in the configuration.*

## The leaf-following reference space trades the gap for the energy ceiling

**The natural reference for a star is $\mathfrak p=\pi_1\otimes\pi_1^\perp$**, all maps between $X_0$'s dominant plane $\pi_1$ and its complement, the tangent space of $\mathrm{Gr}_2(\mathbb R^n)$. It contains every cheap leak of the table above (the kernel slots and any further leaf), and $(\mathfrak{so}(n),\mathfrak{so}(2)\oplus\mathfrak{so}(n-2))$ is a symmetric pair, so $[\mathfrak p,\mathfrak p]\subseteq\mathfrak k\perp\mathfrak p\supseteq[\mathfrak p,\mathfrak k]$ and the orthogonality survives. **But its six-dimensional subspaces carry more bracket energy than $E$**: in rows $M=(u;v)$, $\lVert[Y,Y']\rVert^2=(u\cdot v'-u'\cdot v)^2+\lvert u\wedge u'+v\wedge v'\rvert^2$, and the pencil $v=0$ with orthonormal $u_j$ gives $30$ (*screen*, [grass_energy.py](../scripts/misc/screen_I73_grass_energy.py): ascent reaches $29.0$ at $n=10$, undershooting the pencil). **So (3) with $\mathfrak p$ in place of $E$ starts from $16+30$**, and the partners' spread inside $\mathfrak p$ has to be charged against row $0$ slot by slot: $\sum_j\langle(\tfrac43-A)Y_j,Y_j\rangle\le x-y$, with the kernel slots charged $\tfrac7{12}$ per unit. **The owed estimate on the star side is that weighted problem**: the largest energy of a partner family in $\mathfrak p$ whose slot-weighted departure from $E$ is at most $x-y$.

## A second route that closes both sides: count the partners' own deficits

**Every element of $E$ is far from the extremal set $\mathrm{Ext}$** (unit triangles and stars). Elements of $E$ have equal angles, rank $4$ (section 10 of the summed-pair note, for both types), so by von Neumann's inequality for skew matrices $\langle Y,Z\rangle\le\sqrt{2/3}\,\lVert Y\rVert$ for $Z\in\mathrm{Ext}$, and $\operatorname{dist}(Y,\mathrm{Ext})^2\ge r^2+1-2\sqrt{2/3}\,r\ge\tfrac13$ at every radius $r$. **So a partner $X_j=Y_j+D_j$ sits at distance at least $\sqrt{1/3}-\lVert D_j\rVert$ from $\mathrm{Ext}$**, and its own row pays for that distance: $\delta_j\ge\varphi(\operatorname{dist}^2)$.

*Screen* ([stability](../scripts/misc/screen_I73_stability.py), [phi](../scripts/misc/screen_I73_phi.py)): $\varphi(d^2)\approx\min(5.9\,d^2,\,0.536)$, the plateau being exactly $8-2(2+\sqrt3)$, the ceiling of the path-with-kernel class. With $\eta\le0.75$ at most two partners can be near $\mathrm{Ext}$ ($d_j^2\ge\tfrac13$ each), and the other four already carry $\sum\delta_j\ge4(0.536)>1.94$; with the leak spread evenly each partner sits at $d^2\approx0.09$ and pays about $0.5$. **So $T\le54.064$ on both sides**, once four pieces are proved:

1. **A star gap lemma**, bounding $\eta$ on the star side (screened worst $0.734$), as `triangle_gap_*` does on the triangle side.
2. **Equal angles on $E$ for the star**, and von Neumann's inequality for skew matrices, giving the $\sqrt{2/3}$.
3. **The deficit bound** $8-S_6(X)\ge\min(c\operatorname{dist}^2,\,8-2(2+\sqrt3))$ with $c$ near $5.9$: locally $y=8B+2\Delta\ge6(B+\Delta/3)\approx6\operatorname{dist}^2$ at the triangle, and the plateau from the seventeen class bounds at their exact ceilings.
4. **The counting**: $\sum_j\varphi\big((\sqrt{1/3}-d_j)_+^2\big)\ge1.94-x$ under $\sum d_j^2\le\eta$.

*This route uses no bracket-energy bound at all.*

**Piece 3 is proved, sharper than the screen.** For a triangle, $8-2\sum(a+a)^2=6(1-p^2)+2(1-\lVert v\rVert^2)$, and for a star $8-2\sum(a+l_b)^2=6(1-p^2)+2(1-\lVert v\rVert^2)+\tfrac12(a-L)^2$, with $p$ the alignment with the pattern and $L$ the leaf sum (`deficit_triangle`, `deficit_star`). Since $\operatorname{dist}^2\le2-2p$, every unit $X$ has $8-S_6(X)\ge\min\big(8-2(2+\sqrt3),\,6d^2(1-d^2/4)\big)$ (`deficit_of_dist`, the plateau from the seventeen class bounds). The top space's distance $\ge\sqrt{1/3}$ is `far_from_ext`.

**The counting (piece 4, screened)** needs the leak below about $0.6$: the smallest partner-deficit sum is $2.12$ at $\eta=0.5$, $1.91$ at $0.6$, $1.57$ at $0.75$ ([count](../scripts/misc/screen_I73_count.py)). **So the route reproves [L239](../findings/second-order.md)**, where $\eta\le\tfrac12$ gives $2.12>1.936$, and **falls short on the star side**, where the gap bound allows $\eta\le0.734$. *Taking all maps out of the dominant plane as the reference ($\mathfrak p$, gap about $1$) lowers the distance to $0.408$ and fails worse ($\eta\le0.22$ needed, $0.277$ available).* **The owed estimate is the weighted one**: leaks into the kernel slots cost $\tfrac7{12}$ each in row $0$ but pull a partner towards $\mathrm{Ext}$ only gradually (from $0.577$ at equal angles towards $0.408$), so charging each leak at its own slot and its own distance loss is the version with room.

## The weighted count closes the star side, on a screen

**The cheap leaks are harmless at first order.** On the star side split a partner as $X_j=Y_j+K_j+R_j$: $Y_j$ in $E'$, every $+$ slot from the dominant plane $\pi_1$ to any other plane (all anti-linear, so all equal-angle, and free in row $0$ up to their own small gap); $K_j=p\wedge u_1+q\wedge u_2$ in the kernel slots of $\pi_1$, gap $g_K=\mu_6-a_1^2$ ($\tfrac7{12}$ at the exact star); $R_j$ everything else, gap $g_M\approx1$. **$Y_j+K_j=p\wedge w_1+q\wedge w_2$ has Gram $\rho^2I+\mathrm{Gram}(u)$**, the cross terms vanishing because the kernel is orthogonal to every plane, so its two angles satisfy $\alpha^2-\beta^2\le\lVert K_j\rVert^2$: **the kernel leak moves a partner towards $\mathrm{Ext}$ only at second order.** By von Neumann's inequality its alignment with $\mathrm{Ext}$ is at most $\max\big(\tfrac{\sqrt3}2\alpha+\tfrac1{\sqrt{12}}\beta,\ (\alpha+\beta)/\sqrt3\big)$, so $\operatorname{dist}(X_j,\mathrm{Ext})\ge\sqrt{1-\mathrm{align}^2}-\lVert R_j\rVert$. **Row $0$ pays exactly** $\sum_{c\notin E}(\mu_6-\mu_c)w_c\le x-y$ with $w_c$ the partners' weight on each eigendirection.

*Screen* ([weighted](../scripts/misc/screen_I73_weighted.py), 3000 near-star $X_0$ with $y\le0.277$ and a fifth plane, worst allocation by local search): **the partners' deficits total at least $2.70$ against a requirement of at most $1.936-x\approx1.67$, margin $+1.03$.** *Owed analytically*: (1) star gap lemmas, lower bounds on $g_K=l_{\min}(2a_1+l_{\min})$ and $g_M$ for $y\le0.277$; (2) the Gram computation above, and equal angles on $E'$; (3) von Neumann for skew matrices; (4) the counting lemma under the weighted budget. **With those four, the seven-frame lemma holds**, the triangle side being [L239](../findings/second-order.md).

## The counting by hand, and the one inequality it leaves

**Per partner, the damage is at most $\lambda_K\lVert K_j\rVert^2+\lambda_Mm_j^2$**, damage meaning $0.534-\varphi(e_j^2)$ with $e_j\ge\rho(\kappa_j)-m_j$, $m_j=\lVert R_j\rVert$, and the NORMALISED $\kappa_j$ with $\kappa_j(1-m_j^2)\le\lVert K_j\rVert^2$; $\rho(\kappa)=\sqrt{1-\mathrm{align}(\kappa)^2}$ falls from $\sqrt{1/3}$ at $\kappa=0$ to its minimum $0.408$ at $\kappa=0.8$. *A kernel leak alone never leaves the plateau*, since $\rho\ge0.408$ gives $e^2\ge0.167>0.0914$. **The constants are $\lambda_K=0.5$, $\lambda_M=2.4$** (step 5 of the assembled proof below). Summing under the budget $g_K\sum\lVert K_j\rVert^2+g_M\sum m_j^2\le x-y$,
$$\sum_{j}\delta_j\ \ge\ 6(0.534)-\max\Big(\frac{\lambda_K}{g_K},\frac{\lambda_M}{g_M}\Big)(x-y),$$
and this beats the requirement $1.936-x$ once the gaps are large enough; the constants actually used, $\lambda_K=0.5$ and $\lambda_M=2.4$ with $\kappa$ normalised, and the resulting count are in step 6 of the assembled proof below.

**The star gap lemma is proved** ([SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean), `sgM_*`, `sgM_bulk`, `sgK`), after a sharper split of the leak: maps from $\pi_1$ to anything outside $\pi_1$ and the three leaves (kernel slots, and both slots to further planes $b$) have Gram $\rho^2I+\mathrm{Gram}(u)$ with vanishing cross terms, so they are second order and are charged at $g_K=\mu_6-(a+b)^2$; the first-order leaks are the minus slots to the leaves and everything outside $\mathfrak p$, charged at $g_M=\mu_6-\max\{(a-l)^2,(l+l')^2,(l+b)^2,l^2,2B\}$. **Proved: $0.677\,g_M+y\ge0.3$ and $3\,g_K+y\ge0.3$ whenever $y\le0.277$**, the second stronger than the $3.11$ required; the reduced forms' minima are $0.148$ (the bulk quadratic) and $0.066$ (the kernel gap). *Screen* ([star gaps](../scripts/misc/screen_I73_star_gaps.py) and the joint check in its commit): $\min(0.58\,g_M+y)=0.2845$, so the $0.708$ form holds with room; $\min(4.27\,g_K+y)=0.99$. The minima of $g_K$, $g_M$ alone ($0.16$, $0.18$) sit at $y\approx0.277$, where the budget $x-y$ vanishes. **So on screens the seven-frame lemma holds on both sides.** *The constants actually used are $\lambda_K=0.5$, $\lambda_M=2.4$ with $\kappa$ normalised* (`lam_pos_norm`, `lam_neg_norm`, `lamG`, `phi_low`, `star_ge_tri`; step 5 below); *owed*: the prose steps (the Gram computation, equal angles on $E'$, von Neumann for skew matrices, the weighted Ky Fan budget).

## The star side, assembled

**Claim.** An orthonormal seven-frame in $\mathfrak{so}(n)$ with an element $X_0$ of row deficit $x<0.277$ whose top eigenspace is a STAR has $T\le54.064$. With [L239](../findings/second-order.md) and the neighbourhood lemma this gives **the seven-frame lemma: every orthonormal seven-frame has $T\le54.064$**.

**Proof.** Let $X_0$ have angles $a$ on its dominant plane $\pi_1$, $l_1,l_2,l_3$ on its three leaves, $b$ the largest further angle, and $y=8-2\sum(a+l_i)^2\le x$. Split each partner as $X_j=Y_j+K_j+R_j$: $Y_j$ in $E$ (the three $+$ slots from $\pi_1$ to the leaves); $K_j$ the maps from $\pi_1$ into the complement of $\pi_1$ and the leaves; $R_j$ the rest.

1. **Row $0$ pays for the leaks.** $A=-\mathrm{ad}_{X_0}^2$ preserves each slot space, so with $w_c$ the partners' weight on eigendirection $c$, $\mathrm{row}_0=\sum_c\mu_cw_c$, $0\le w_c\le1$, $\sum w_c=6$, and the Ky Fan bound gives $x-y\ge g_K\sum_j\lVert K_j\rVert^2+g_M\sum_j\lVert R_j\rVert^2$, with $g_K=\mu_6-\max\{(a+b)^2,a^2\}$ and $g_M=\mu_6-\max\{(a-l)^2,(l+l')^2,(l+b)^2,l^2,2B\}$.
2. **The gaps are large enough** (proved): $0.677\,g_M+y\ge0.3$ and $3\,g_K+y\ge0.3$ for $y\le0.277$, so $g_K,g_M>0$.
3. **Partners are far from the triangles and stars.** $Y_j+K_j=p\wedge w_1+q\wedge w_2$ with $\mathrm{Gram}(w)=\rho_0^2I+\mathrm{Gram}(u)$, since $E$ is anti-linear (equal, orthogonal images) and the kernel directions are orthogonal to every plane; so its two angles have $\alpha^2-\beta^2=\kappa_j\le\lVert K_j\rVert^2/\lVert Y_j+K_j\rVert^2$. Von Neumann's inequality for skew matrices bounds its alignment with any triangle or star by the star branch $\tfrac{\sqrt3}2\alpha+\tfrac1{\sqrt{12}}\beta$ (which dominates the triangle branch), so $\operatorname{dist}(X_j,\mathrm{Ext})\ge\rho(\kappa_j)-\lVert R_j\rVert$ with $\rho(\kappa)^2=\tfrac7{12}-\tfrac\kappa3-\tfrac14\sqrt{1-\kappa^2}$.
4. **Each partner's own row pays for its distance** (proved): $\delta_j\ge\min\big(0.534,\,6d^2(1-d^2/4)\big)$ at distance $d$, from the exact deficit identities and the ceilings of the fifty-two other three-slot configurations at $3.733$ for nonnegative angles (`slot_ceiling_*`; the exact maximum is $2+\sqrt3$, attained by the path with a kernel slot and by the star with one minus slot).
5. **The damage is at most $\tfrac12\lVert K_j\rVert^2+2.4\lVert R_j\rVert^2$** (proved, `lam_pos_norm`, `lam_neg_norm`). *Step 3 gives the NORMALISED $\kappa_j\le\lVert K_j\rVert^2/(1-m_j^2)$, so the bound is stated with the budget paying $\kappa_j(1-m_j^2)\le\lVert K_j\rVert^2$; its certificate is $A\cdot F=(Am-5.86\rho)^2+G(\kappa,c)$ with $A=8.26-\kappa/2$ and $G\ge0$ on the arc (`lamG`, minimum $0.111$).*
6. **Count.** $\sum_{j\ge1}\delta_j\ge6(0.534)-D$ with $D\le\max\big(\tfrac{0.5}{g_K},\tfrac{2.4}{g_M}\big)(x-y)$. Step 2 gives $\tfrac{2.4}{g_M}\le\tfrac{1.6248}{0.3-y}$ and $\tfrac{0.5}{g_K}\le\tfrac{1.5}{0.3-y}$, so $D\le1.6248\,\tfrac{x-y}{0.3-y}\le1.6248\,\tfrac{x}{0.3}=5.416x$ (the ratio decreases in $y$ when $x\le0.3$). If $T>54.064$ then $x\le\sum\delta_i/7<1.936/7=0.2765714\ldots$, and $\sum_{j\ge1}\delta_j\ge3.204-5.416x>1.936-x$ holds for $x<0.2871$, so $T=56-x-\sum_{j\ge1}\delta_j<54.064$, a contradiction. $\square$ *The margin in $x$ is $0.0106$.*

**Gate 2 by [r1121](REVIEW_r1121.md) and [r1122](REVIEW_r1122.md)**, independently: steps 1 to 3 and 5 CONFIRMED; both found that step 6 charged the unnormalised $\lVert K_j\rVert^2$ where step 3 supplies only the normalised $\kappa_j$ (explicit counterexamples to the per-partner bound $\tfrac12\kappa+2.3m^2$), and that step 4's plateau rested on class ceilings typed only at $\tfrac{19}5$, with a class (the star with one minus slot) missing from the list. **Steps 4 to 6 above are the repair**: the normalised damage bound at $\lambda_M=2.4$, and all fifty-two ceilings typed.

*What is typed*: steps 2, 4 and 5, and the scalar arithmetic, in [SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean). *What is prose*: the slot spectrum, the Ky Fan weights of step 1, the Gram computation and von Neumann's inequality of step 3, the dist-to-alignment step, and the count's final line.

## What this is

**A split of the seven-frame lemma**: the case where the frame's best element is triangle-type is closed, its gap lemma proved in Lean and the rest prose awaiting Gate 2; the star case is obstructed at a named direction with named constants. *Neither closes I73's sub-step (c) alone.*
