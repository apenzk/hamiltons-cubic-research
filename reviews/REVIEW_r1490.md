# Review r1490: L134(b)'s display in Lean, the first coefficient pinned and Φ to second order along the great circle

Gate 2 review of the Lean-layer part of commit 630a6974: the new [Results/L134bPhi.lean](../lean/HamiltonsCubic/Results/L134bPhi.lean) (`coeff_eq_zero_of_isLittleO`, `Exp2.first`, `c1Of`, `exp2_altNormSqOf'`, `Exp2.first_unique`, `opB_smul_add`, `Exp2.sub_isBigO`, `exp2_P_circle`, `Exp2.at_zero`, `Exp2.first_eq_deriv`, `dLine`, `L134b_first`, `opB_circle`, `L134b_Phi`), and the record edits that answer [r1489](REVIEW_r1489.md)'s gaps C-1, E-1, E-2 and E-3: [route-a.md](../findings/route-a.md) lines 189 and 203, the L134 row of [lean/INDEX.md](../lean/INDEX.md) (line 463), row 134 of [INDEX-results.md](../findings/INDEX-results.md) (line 150), the [L134b.lean](../lean/HamiltonsCubic/Results/L134b.lean) docstring (lines 25 to 28) and milestone 6 of the [second-order plan](2026-09-26-lean-second-order-plan.md) (line 14). The I73 files in the same commit belong to another session and are not reviewed here. One reviewer. Analysis-only rule inherited: the only compute was the module build (8786 jobs, no error, no warning in L134bPhi.lean) and `scripts/misc/axiom_audit.py --only L134bPhi`.

| item | claim | verdict |
| --- | --- | --- |
| A | `L134b_Phi` states route-a.md's (b) display $\Phi(t)-\theta_0=[\tfrac12\mathrm{Hess}(P\vert_S)[H,H]-\kappa c_2]t^2+o(t^2)$ on $\{F=0\}$ faithfully | CONFIRMED WITH GAP |
| B | `L134b_first` is sound: circle and line differ by $O(t^2)$, the negative part is Lipschitz, first coefficients are unique and equal the one-sided derivative | CONFIRMED |
| C | the record edits repair r1489's C-1, E-1, E-2, E-3 | CONFIRMED |
| D | every theorem of L134bPhi.lean rests on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no edited sentence overstates what is proved | CONFIRMED WITH GAP |
| F | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: the Lean is sound, kernel-checked on the standard three axioms, and its display is the record's (b) at the record's unit $H$. All four r1489 gaps are repaired. Two precision gaps remain: the docstrings, the L134 row and milestone 6 read the $t^2$ coefficient $3\langle u,Q(H)\rangle-\tfrac32P(u)$ as $\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]$ "for tangent $H$", which holds only at $\lVert H\rVert=1$ while `L134b_Phi` admits every tangent Weyl $H$, and route-a.md line 203 calls the display in its Hessian and $\theta_0$ form "kernel-checked", where the Lean states it in the $3\langle u,Q(H)\rangle$, $P(u)-\kappa/9$ form and the two readings are record-side. CONFIRMED WITH GAP.**

## A. Fidelity of `L134b_Phi`

The statement: for $n\ge4$, $H$ a Weyl `CurvOp2` with $\langle H,u\rangle=0$, any real $\kappa$ and a symmetry proof `hW` for $\cos t\,\mathrm{uOp}+\sin t\,\mathrm{opB}\,H$, there is $c_2$ with $\delta^2$ along that circle $=\tfrac19+t\,\mathrm{dLine}+t^2c_2+o(t^2)$ and $P(\cos t\,u+\sin t\,H)-\kappa\delta^2=(P(u)-\tfrac\kappa9)+t(-\kappa\,\mathrm{dLine})+t^2(3\langle u,Q(H)\rangle-\tfrac32P(u)-\kappa c_2)+o(t^2)$, one-sided along `𝓝[Set.Ici 0] 0`.

- **The $t^2$ coefficient of $P$.** `Pcubic2_circle` (L24Hess.lean line 29) gives $P(\cos t\,u+\sin t\,H)=\cos^3t\,P(u)+3\cos t\sin^2t\,\langle u,Q(H)\rangle+\sin^3t\,P(H)$ under $\langle H,Q(u)\rangle=0$, which `innerOp2_Qop2_u2` and tangency supply. With $\cos^3t=1-\tfrac32t^2+o(t^2)$, $\cos t\sin^2t=t^2+o(t^2)$ and $\sin^3t=o(t^2)$, the coefficients are $(P(u),0,3B-\tfrac32P(u))$, $B=\langle u,Q(H)\rangle$, as `exp2_P_circle` states. **Correct.**
- **Is it $\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]$?** At the unit critical $u$, with Lagrange multiplier $dP_u=3P(u)\langle u,\cdot\rangle$, $\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]=\tfrac12D^2P_u[H,H]-\tfrac32P(u)\lVert H\rVert^2=3B-\tfrac32P(u)\lVert H\rVert^2$. `L24_hessian_Le` (L24Hess.lean line 94) proves $\tfrac12\frac{d^2}{dt^2}P(\cos t\,u+\sin t\,H)\vert_0=3P(u)(\langle L_eH,H\rangle-\tfrac12)$, which `field_simp` reduces to the same $3B-\tfrac32P(u)$, with no norm hypothesis, because it is a statement about that curve. The curve is a geodesic of $S$ and its second derivative is the Hessian only when $\lVert H\rVert=1$. So the identification holds at the record's $H$ (route-a.md line 182 fixes $\lVert H\rVert=1$) and fails for other tangent $H$, which `L134b_Phi` admits. **Correct at the record's $H$, see gap A-1.**
- **The first coefficient.** $-\kappa\,\mathrm{dLine}(\mathrm{opB}\,H)=-\kappa\cdot(-2\cdot\tfrac1{3\sqrt6}\cdot S)=2\cdot\tfrac1{3\sqrt6}\cdot\kappa\cdot S$, with $S$ the bracket of `vec 1`, `vec 2` and the $\{3,4,5\}$ sum, which is term for term L17Phi.lean's `L17` derivative (line 285), the record's $2a\kappa F(H)$, $a=1/(3\sqrt6)$. So on $\{F=0\}$, the cone route-a.md line 182 defines as L17's $d^+\Phi=0$, the first coefficient vanishes. **Correct.**
- **The circle in $\delta^2$.** `L134b_Phi` evaluates $P$ on $\cos t\,u_2+\sin t\,H$ in `CurvOp2` and $\delta^2$ on $\cos t\,\mathrm{uOp}+\sin t\,\mathrm{opB}\,H$ in the bivector model. `opB_circle` proves the second is `opB` of the first, through `opB_smul_add` and `opB_u2`. It is not invoked in `L134b_Phi`'s proof and need not be: it certifies that the two halves of $\Phi$ are read on one path, as `opB_path` does for L17. **Correct.**
- **The constant.** The record sets $\theta^*=P(u)$ and $\kappa_n=9(\theta^*-\theta_0)$ (route-a.md line 182), so $P(u)-\kappa/9=\theta_0$ identically in the record's $\kappa$. No Lean lemma evaluates `Pcubic2 (u2 hn)` to $\sqrt{3/2}$, and the display keeps $P(u)$ symbolic, which is the faithful choice. **Correct.**
- **$c_2$.** The same $c_2$ appears in both conjuncts, and it is the $t^2$ coefficient of $\delta^2$ along the circle, unique by the Peano argument r1489 A noted, so it is the record's $c_2(H)$. **Correct.**

**Gap A-1.** "$3\langle u,Q(H)\rangle-\tfrac32P(u)$ is $\tfrac12\mathrm{Hess}(P\vert_S)_u[H,H]$ for tangent $H$" at [L134bPhi.lean](../lean/HamiltonsCubic/Results/L134bPhi.lean) lines 24 to 25, the same reading in `L134b_Phi`'s docstring (line 216), the L134 row of [lean/INDEX.md](../lean/INDEX.md) (line 463, "for tangent Weyl $H$ ... the $t^2$ coefficient being $\tfrac12\mathrm{Hess}(P|_S)_u[H,H]-\kappa c_2$") and milestone 6 of the [plan](2026-09-26-lean-second-order-plan.md) (line 14) omit $\lVert H\rVert=1$. For a tangent $H$ of other norm the Hessian is $3B-\tfrac32P(u)\lVert H\rVert^2$. The theorem is unaffected. Repair: "for unit tangent $H$".

## B. `L134b_first`

- **Paths.** `hpath'`: $\cos t\,u+\sin t\,H=u+tH+t^2(-\tfrac12u)+o(t^2)$, from `exp2_cos`, `exp2_sin`, `Exp2.smul_vec`. `hline`: $u+tH$ exactly, by `Exp2.poly`. Same $a$ and $b$, so `Exp2.sub_isBigO` gives the difference $O(t^2)$. **Correct.**
- **Negative parts.** `exp2_negPart_path` expands both, with $G=-\tfrac12u$ and $G=0$ symmetric. `norm_specFn_sub_le` with `negPart_lipschitz` bounds $\lVert g(L(t))-g(W(t))\rVert\le\sqrt{\dim\Lambda^2}\,\lVert L(t)-W(t)\rVert$ pointwise, so the negative parts differ by $O(t^2)$. **Correct.**
- **Uniqueness.** `Exp2.first_unique`: with the same constant, $f-g=O(t^2)$ and both expansions give $t(b-b')=o(t)$, hence $\lVert b-b'\rVert t=o(t)$ on $[0,\infty)$ and `coeff_eq_zero_of_isLittleO` (which argues on `Ioi 0`, a nontrivial filter) gives $b=b'$. **Correct.**
- **Through $\delta^2$.** `exp2_altNormSqOf'` names the first coefficient `c1Of a b`, which depends only on the constant and the first coefficient, so $A_1=B_1$ makes the circle's and the line's first $\delta^2$ coefficients equal. **Correct.**
- **Derivative.** `Exp2.first_eq_deriv`: `HasDerivWithinAt f D (Ici 0) 0` is $f(t)-f(0)-tD=o(t)$, `Exp2.at_zero` gives $f(0)=a$, `Exp2.first` gives $f(t)-a-tb=o(t)$, so $(b-D)t=o(t)$ and $b=D$. Applied with `hasDerivWithinAt_defect_u`, whose value is `dLine` by definition. **Correct.**
- **Constant.** `altNormSq_uNeg` gives $\tfrac19$. **Correct.**
- **Hypotheses.** `hn`, `hN`, `hH`, `hW` are all used, none is missing. `hW` restricts nothing, as r1489 A noted for `L134b`.

## C. The record edits and r1489's gaps

- **C-1.** route-a.md line 189 now reads "the $t^2$ coefficient of $\Phi(\cos t\,u+\sin t\,H)-\theta_0$ is at most $-\tfrac{\theta^*}2+\lvert\kappa_n\rvert c_2(H)$". No second derivative remains. **Repaired.**
- **E-1.** Row 134 (INDEX-results.md line 150) reads "(b)'s expansion and display proved ..., its inequality owed to (a)'s bound", and lean/INDEX.md line 463 reads "(b)'s expansion is PROVED" and "(b)'s inequality is owed, since it substitutes (a)'s bound". **Repaired.**
- **E-2.** L134b.lean lines 25 to 27 now route the identification through `L134b_first` ("it is $\delta^2$'s one-sided derivative along the line $u+tH$, which L17Deriv.lean computes as $-2aF(H)$"), and B above confirms `L134b_first` proves it. **Repaired.**
- **E-3.** route-a.md line 203: "$+o(t^2)$ (kernel-checked ...). Substituting (a) and $\kappa_n=-\lvert\kappa_n\rvert$ gives the bound." A full stop. **Repaired.**

## D. Axioms

`python3 scripts/misc/axiom_audit.py --only L134bPhi`: "auditing 12 declarations across 1 files, 12/12 clean, resting on the standard three alone". The script collects `theorem` and `lemma` declarations, the twelve theorems here. The two definitions `c1Of` and `dLine` carry no proof and reach the audit through `exp2_altNormSqOf'`, `L134b_first` and `L134b_Phi`. **CONFIRMED.**

## E. Record accuracy

- **Row 134, the L134 row, L134b.lean, milestone 6** state what is proved: the expansion, the pinned first coefficient and the display, with (b)'s inequality owed on (a)'s bound. Milestone 6's "**Proved**" names `L134b_first` and `L134b_Phi`, which is exact. The unit-norm qualifier is gap A-1.
- **route-a.md line 203** is gap E-1 below.
- *Remark, outside the commit:* the plan's Goal paragraph (line 3) still describes $c_2(H)$ as "a genuine one-sided second derivative", the wording r1489 C-1 retired from route-a.md. Not a gap of this commit.

**Gap E-1.** route-a.md line 203 says the display $\Phi(t)-\theta_0=\big[\tfrac12\mathrm{Hess}(P|_S)[H,H]-\kappa_nc_2(H)\big]t^2+o(t^2)$ is "kernel-checked as `L134b_Phi`". The Lean states the constant as $P(u)-\kappa/9$ and the $t^2$ coefficient as $3\langle u,Q(H)\rangle-\tfrac32P(u)-\kappa c_2$. Reading the first as $\theta_0$ uses the record's definition of $\kappa_n$ and $\theta^*=P(u)$, and reading the second as the Hessian uses $\lVert H\rVert=1$ and `L24_hessian_Le`, a separate theorem about the circle's second derivative that no Lean statement composes with `L134b_Phi`. Both readings are elementary and correct at the record's $H$ (A above), so nothing false is claimed, but the parenthetical credits the kernel with two steps it does not check. Repair: "kernel-checked as `L134b_Phi` in the form $3\langle u,Q(H)\rangle-\tfrac32P(u)-\kappa c_2$, which `L24_hessian_Le` reads as the Hessian at unit $H$".

## F. Style

- No em dash in L134bPhi.lean, L134b.lean or any added record line.
- The semicolons in L134bPhi.lean's docstring (lines 14 to 22) end list items, the file layer's list convention (L134b.lean uses it too), and join no clauses. None in the added record prose.
- No backticks inside markdown link text in any added line.
- The edited markdown lines (route-a.md 189 and 203, lean/INDEX.md 463, INDEX-results.md 150, plan line 14) are each one unwrapped line. **CONFIRMED.**

## Verdict

**CONFIRMED WITH GAP.** The mathematics and the Lean are sound and the four r1489 gaps are closed. Open: A-1, the missing "unit" in the Hessian reading at L134bPhi.lean lines 24 to 25 and 216, lean/INDEX.md line 463 and the plan's line 14, and E-1, route-a.md line 203 crediting the kernel with the $\theta_0$ and Hessian readings.
