# REVIEW r1123: the repair of the star-side count (Gate 2)

Log: [agent_logs/r1123.log](../agent_logs/r1123.log). Brief: [2026-09-24-I73-star-repair-brief.md](2026-09-24-I73-star-repair-brief.md). Claim: "The star side, assembled" in [2026-09-24-I73-seven-frame-stability.md](2026-09-24-I73-seven-frame-stability.md). Screens (seconds, on constructed objects): r1123_slots.py and r1123_lam.py in the session scratchpad.

**Verdict: the repair holds.** Both defects of [r1121](REVIEW_r1121.md) and [r1122](REVIEW_r1122.md) are answered: the damage bound is now stated in the budget variables and the plateau rests on typed ceilings. One completeness gap in the ceiling list (repeated kernel loops at one plane, six classes, all at most $2+\sqrt2$) and two stale sentences in the Lean docstrings; neither is load-bearing.

| # | Item | Verdict |
|---|---|---|
| 1 | Completeness of `slot_ceiling_*` | PLAUSIBLE: the 52 are exactly the 54 single-loop classes minus the two extremal ones; six repeated-loop classes (kernel dimension at least 2) are untyped, all at most $2+\sqrt2$ |
| 2 | The plateau of step 4 | CONFIRMED |
| 3 | Normalisation, `lam_pos_norm`, `lamG`, the identity | CONFIRMED |
| 4 | $m\le1$ in `lam_neg_norm` | CONFIRMED |
| 5 | The count's arithmetic | CONFIRMED |
| 6 | Damage against the plateau at $0.534$ | CONFIRMED |

## 1. Completeness of the ceilings: PLAUSIBLE

- **Own enumeration.** Slots $P_{ij}=(a_i+a_j)^2$, $M_{ij}=(a_i-a_j)^2$, $L_i=a_i^2$ (one loop per plane), three distinct slots on up to six planes, canonicalised under plane relabelling: **54 classes**, matching the parent. The two at $4$ are the all-plus star $P_{01}P_{02}P_{03}$ and triangle $P_{01}P_{02}P_{12}$. Next are exactly two at $2+\sqrt3$ ($L_0P_{01}P_{02}$, the path with a loop at its centre, and $M_{01}P_{02}P_{03}$, the star with one minus slot), then $2+\sqrt2$. Maxima computed exactly over nonnegative vectors (principal submatrices with a sign-definite eigenvector).
- **Lean against the enumeration.** Parsing the 52 statements and canonicalising: 52 distinct classes, no duplicates, none outside the enumeration, and the complement is exactly {star, triangle}. The ceiling $3.733>2+\sqrt3=3.73205$ is sound.
- **The gap.** The eigenvalue $a_i^2$ lives on $\pi_i\otimes\ker$, of dimension $2\dim\ker$, so with $\dim\ker\ge2$ one plane carries several distinct loop slots. The enumeration with repeated loops has **60 classes**; the six extra are $L_aL_aP_{ab}$, $L_aL_aM_{ab}$ (both $2+\sqrt2$), $L_aL_aL_a$ ($3$), $L_aL_aL_b$, $L_aL_aP_{bc}$, $L_aL_aM_{bc}$ (all $2$). None is typed. Slots of eigenvalue $0$ ($\mathfrak{so}(\pi_k)$, kernel-kernel) are also absent; any triple containing one is at most the two-slot maximum $3$. **Correction**: add the six one-line lemmas (or one lemma per shape) and a sentence on zero slots, or say in step 4 that "fifty-two" counts one loop per plane and the rest are bounded by hand at $2+\sqrt2$.
- **Nonnegativity is legitimate.** The angles of a real skew matrix are singular values, nonnegative after orienting each plane, and step 4 applies the ceilings to a partner's own angles. The hypotheses are needed: over $\mathbb R$, $M_{01}P_{02}P_{03}$ is the star under $a_1\mapsto-a_1$.

## 2. The plateau: CONFIRMED

- $\delta=8-\mathrm{row}\ge8-S_6(X)$ by L237, and $S_6(X)=2\times$ (top three-slot sum). If the top configuration is non-extremal, $S_6\le2(3.733)$, so $\delta\ge0.534$ (`slot_threshold`).
- If it is a triangle or star, `deficit_triangle` / `deficit_star` give $\delta\ge6(1-p^2)$ with $p\ge0$ the alignment with the pattern on $X$'s own planes, and $d^2=\mathop{\mathrm{dist}}(X,\mathrm{Ext})^2\le2-2p$, $d^2\le2$ (Ext is closed under negation), so `deficit_of_dist` gives $6d^2(1-d^2/4)$.
- Hence $\delta\ge\min(0.534,6d^2(1-d^2/4))$. The item 1 gap does not affect this, since the missing classes sit below $3.733$.

## 3. Normalisation and the certificate: CONFIRMED

- $\lVert Y_j+K_j\rVert^2=1-m_j^2$ exactly ($R_j\perp Y_j+K_j$, unit partner), so $\kappa_j(1-m_j^2)=\alpha^2-\beta^2\le\lVert K_j\rVert^2$. `lam_pos_norm` concludes $0.534-5.86(\rho-m)^2\le\tfrac12\kappa(1-m^2)+2.4m^2$ with $\kappa$ on the unit arc, which is what step 5 needs; it is applied at the actual $\kappa_j$, so no monotonicity of $\rho$ is used.
- **The identity**, expanded by hand: the $m^2$ coefficient of $A\cdot F$ is $A(8.26-\kappa/2)=A^2$, the $m$ coefficient $-11.72A\rho$, the constant $A(5.86\rho^2+\kappa/2-0.534)$, matching $(Am-5.86\rho)^2+G$ with $G=(5.86\rho^2+\kappa/2-0.534)A-5.86^2\rho^2$ and $\rho^2$ replaced by $\tfrac7{12}-\tfrac\kappa3-\tfrac c4$. It is `ring`-checked in Lean. $A\ge7.76>0$, so $F\ge0$ for every $m$ iff $G\ge0$.
- **`lamG`**: screen on the arc gives $\min G=0.11102$ at $\kappa=0.2641$, $c=0.9645$, matching the note's $0.111$ and the Lean hint point $(0.264,0.9645)$.
- **End-to-end screen** of the chain (exact $\varphi$ with plateau $0.534$, $\kappa=\min(1,k/(1-m^2))$ and every $\kappa$ below it, $k=\lVert K\rVert^2$, $k+m^2\le1$, $801^2\times41$ grid): $\max\big(\text{damage}-(\tfrac12k+2.4m^2)\big)=0$. The r1121 and r1122 counterexamples are inside the grid.

## 4. The case $m\ge\rho$: CONFIRMED

- $m_j=\lVert R_j\rVert\le\lVert X_j\rVert=1$ since $R_j$ is an orthogonal projection of a unit partner. At $m=1$, $\kappa$ is undefined but $2.4m^2=2.4\ge0.534$ for any $\kappa$ on the arc.
- In this case $e\ge\rho-m$ is vacuous, so damage $\le0.534$, which is exactly what `lam_neg_norm` bounds.

## 5. The count: CONFIRMED

| Line | Check |
|---|---|
| $2.4\times0.677$ | $=1.6248$ exactly |
| $0.5\times3$ | $=1.5<1.6248$, so the max is the $g_M$ branch |
| monotonicity | $\partial_y\frac{x-y}{0.3-y}=\frac{x-0.3}{(0.3-y)^2}\le0$; with $0\le y\le x$ ($y\ge0$ from $\kappa_6=8$) the worst is $y=0$ |
| $1.6248/0.3$ | $=5.416$ |
| $6\times0.534$ | $=3.204$ |
| threshold | $3.204-5.416x>1.936-x\iff x<1.268/4.416=0.287138$ |
| $T>54.064$ | $7x\le\sum\delta_i<1.936$, $x<0.276571$; margin $0.010566$ |

- $\sum_{j\ge1}\delta_j\ge\sum(0.534-\text{damage}_j)$ uses $d_j\ge e_j$ and $t\mapsto6t(1-t/4)$ increasing on $[0,2]$. Correct.
- Wording: "$x\le\sum\delta_i/7$" needs $X_0$ of least deficit, whereas the claim allows any star-type element with $x<0.277$. Harmless, since $x<0.277<0.2871$ directly.

## 6. Damage against the plateau: CONFIRMED

- $6t(1-t/4)=0.534$ at $t=0.091074<0.0914$, so `phi_low` covers the whole strip below the plateau and damage is $0$ above it.
- Plateau ($0.534$), `phi_low` ($5.86$) and `lamG` ($0.534$) use one constant throughout.

## Corrections requested

1. Item 1: type the six repeated-loop classes ($L_aL_a\ast$, $L_aL_aL_a$) or state them in prose with their bound $2+\sqrt2$; mention zero slots.
2. [SevenFrameGap.lean](../lean/HamiltonsCubic/Results/SevenFrameGap.lean) lines 556 and 561: the section docstring still reads "`κ ≤ ‖K‖²`" and cites `lam_pos`/`lam_neg`; it should read $\kappa(1-m^2)\le\lVert K\rVert^2$ and cite `lam_pos_norm`/`lam_neg_norm`. The same docstring writes "the budget paying `‖K‖² = κ(1 - m²)`", which should be $\ge$.
3. The note's earlier section (line 88) still says the constants $\lambda_K=0.5$, $\lambda_M=2.3$ are proved by `lam_pos`, `lam_neg`; it should point at the repair.
