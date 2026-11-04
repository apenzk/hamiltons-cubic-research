# REVIEW r1121: I73 seven-frame lemma, star side (Gate 2)

Log: [agent_logs/r1121.log](../agent_logs/r1121.log). Brief: [2026-09-24-I73-star-gate2-brief.md](2026-09-24-I73-star-gate2-brief.md). Claim: "The star side, assembled" in [2026-09-24-I73-seven-frame-stability.md](2026-09-24-I73-seven-frame-stability.md).

**Verdict: the assembly has one genuine gap, at the seam between step 3 and step 6.** Step 3 correctly bounds the NORMALISED angle split, $\hat\kappa_j\le\lVert K_j\rVert^2/(1-\lVert R_j\rVert^2)$, and `lam_pos`/`lam_neg` are stated in that normalised $\hat\kappa$. Step 6 then charges $\sum_j\hat\kappa_j$ against the budget $g_K\sum_j\lVert K_j\rVert^2$, which needs $\hat\kappa_j\le\lVert K_j\rVert^2$. That is false by the factor $1/(1-m_j^2)$. On a screen the count survives the correction with smaller room (margin in $x$ about $0.006$ instead of $0.029$), so the claim is PLAUSIBLE, not yet proved. Secondary: step 4's plateau $4-2\sqrt3$ is labelled typed, but the Lean file proves only the $19/5$ ceilings, which give plateau $0.4$ and do not close the count.

| Item | Verdict |
|---|---|
| 1 overall logic and case split | CONFIRMED (with the plateau caveat of item 6 feeding the neighbourhood lemma's sign variants) |
| 2 step 1 weighted Ky Fan budget | CONFIRMED |
| 3 step 1 split and the gaps | CONFIRMED |
| 4 Gram computation, normalisation | CONFIRMED for step 3 as written; normalisation DOES change $\kappa$ (see item 8) |
| 5 alignment and distance | CONFIRMED |
| 6 deficit bound of step 4 | PLAUSIBLE: true (exact screen), but the $2+\sqrt3$ ceilings it needs are untyped |
| 7 lam_pos, lam_neg, phi_low | CONFIRMED (statements are in normalised $\kappa$) |
| 8 the count | REFUTED as written; repairable, repair screened |
| 9 scope | CONFIRMED |

## 1. Overall logic

- If $T>54.064$ then the least-deficit element has $x\le1.936/7<0.27657$, so $\mathrm{row}_0>7.72>7.6$, and since $\mathrm{row}_0\le S_6(X_0)$ its top configuration is a triangle or a star. L239 covers the first, the claim the second.
- Ties: a tie between $E$ and any slot outside it means $g_K=0$ or $g_M=0$, which step 2 forbids when $y\le x<0.277$. So the top six-space is unique, and a triangle and a star cannot both be top.
- No kernel: the $K$-class reduces to the maps into further planes, and every statement holds with the kernel terms absent. With no further plane, $b=0$ and $g_K=\mu_6-a^2$, which `sgK` covers at $b=0$.
- The claim is stated for any star-type element with $x<0.277$, whereas step 6 uses least deficit only for $x<0.27657$. The proof works for any such element anyway: it needs only $y\le x\le0.277$ and $x<0.3053$.
- The neighbourhood lemma's Lean list (`c_*`, all over $\mathbb R$) cannot contain the sign variants that are extremal over $\mathbb R$ (a star with one minus slot is the star under $d\mapsto-d$, and a triangle with two minus slots is the triangle under $c\mapsto-c$). Over nonnegative angles they are below $2+\sqrt3$ (item 6 screen). This is a documentation gap in a given, not a defect of the claim.

## 2. Step 1, the budget

- With $\mu_c\ge\mu_6$ on $E$: $\sum_{c\in E}\mu_cw_c=\mathop{\mathrm{tr}}A|_E-\sum_{c\in E}\mu_c(1-w_c)\le\mathop{\mathrm{tr}}A|_E-\mu_6\sum_{c\notin E}w_c$, using $\sum_cw_c=6$ and $w_c\le1$ (Bessel for the orthonormal partners). Hence $x-y\ge\sum_{c\notin E}(\mu_6-\mu_c)w_c$. Correct.
- The E-part weights enter only through $\mu_c\ge\mu_6$, which is exactly the top-eigenspace hypothesis.
- $X_0$ itself lies in $\bigoplus\mathfrak{so}(\pi_k)$ (eigenvalue $0$) and is orthogonal to the partners, so it carries no weight.
- $K$-space and $R$-space are sums of slot spaces, hence $A$-invariant, so there are no cross terms and $\sum_{c\in K}(\mu_6-\mu_c)w_c\ge g_K\sum_j\lVert K_j\rVert^2$, likewise for $R$.
- The $+$ slots $\pi_1\to\pi_m$ (further plane) have eigenvalue $(a+b_m)^2\le(a+b)^2$ and are in $K$. $g_K=\mu_6-\max\{(a+b)^2,a^2\}=\mu_6-(a+b)^2$ for $b\ge0$. Correct.

## 3. Step 1, the split

Every slot space of $X_0$ outside $E$, with its class:

| slot | eigenvalue | class | covered by |
|---|---|---|---|
| $\pi_1\to$ further, $\pm$ | $(a\pm b_m)^2\le(a+b)^2$ | K | `sgK` |
| $\pi_1\to$ kernel | $a^2$ | K | `sgK` |
| $\pi_1\to$ leaf, $-$ | $(a-l)^2$ | R | `sgM_minus_same`, `sgM_minus_other` |
| leaf-leaf $\pm$, pair containing $l_{\min}$ | $\le(l+l')^2$ | R | `sgM_leaves_in` |
| leaf-leaf $\pm$, other pairs | $\le2(1-a^2)$ | R | `R_leaves_out`, `sgM_bulk` |
| leaf-further $\pm$ | $\le(l+b)^2\le2(1-a^2)$ | R | `R_leaf_b_*`, `sgM_bulk` |
| leaf-kernel | $l^2\le2(1-a^2)$ | R | `sgM_bulk` |
| further-further, further-kernel | $\le2B$ | R | `sgM_mass` |
| $\mathfrak{so}(\pi_k)$, $\mathfrak{so}(\ker)$ | $0$ | R | any of the above |

- Every direction is assigned exactly once, and $\mu_6=(a+l_{\min})^2$ is instantiated by setting `l1` to the smallest leaf. The lemmas are stated for arbitrary labelling, so the instantiation is legal.
- The Lean statements say what the prose needs: nonnegative angles, $a^2+\sum l_i^2+b^2\le1$, $y\le0.277$ (absent from `sgM_bulk`, which is stronger).

## 4. Step 3, the Gram computation

- The three $+$ slots from $\pi_1$ to the leaves share one sign convention ($MJ_1=\mp J_iM$), so $Y=p\wedge w_1+q\wedge w_2$ with $w_2=\mp J_Lw_1$: equal length, orthogonal. $\mathrm{Gram}(w^Y)=\rho_0^2I$. Correct.
- $K$'s images lie in the further planes and the kernel, orthogonal to the leaves, so the cross terms vanish and $\mathrm{Gram}(w)=\rho_0^2I+\mathrm{Gram}(u)$. Correct.
- The angles of $p\wedge w_1+q\wedge w_2$ are the singular values of $[w_1\,w_2]$, so $\alpha^2-\beta^2=\lambda_1(\mathrm{Gram}\,u)-\lambda_2(\mathrm{Gram}\,u)\le\mathop{\mathrm{tr}}\mathrm{Gram}\,u=\lVert K\rVert^2$. Screened (random $X_0\in\mathfrak{so}(12)$ with a fifth plane and a 2-dim kernel, 2000 draws): $\max(\alpha^2-\beta^2-\lVert K\rVert^2)=-1.4\cdot10^{-6}$, so the bound is tight.
- **Normalisation changes $\kappa$.** The alignment formula needs $\alpha^2+\beta^2=1$, so the $\kappa$ that enters $\rho(\kappa)$ is $\hat\kappa=(\alpha^2-\beta^2)/\lVert Y+K\rVert^2\le\lVert K\rVert^2/(1-m^2)$, as step 3 writes. It is not bounded by $\lVert K\rVert^2$ (a rank-one $\mathrm{Gram}\,u$ attains the ratio). The earlier section ("the counting by hand") had $\kappa_j\le\lVert K_j\rVert^2$, and step 6 still uses that version. See item 8.

## 5. Step 3, alignment

- Von Neumann for real skew matrices: singular values come in pairs, so $\langle X,Z\rangle=\tfrac12\mathop{\mathrm{tr}}X^{\mathsf T}Z\le\sum_k\alpha_k\zeta_k$ over sorted angles. Applied to the rank-four $Y+K$ against a star $(3,1,1,1)/\sqrt{12}$ and a triangle $(1,1,1)/\sqrt3$, it gives the two branches as written.
- With $\alpha^2=(1+\kappa)/2$, $\beta^2=(1-\kappa)/2$, $\alpha\beta=c/2$: $\mathrm{star}^2=\tfrac5{12}+\tfrac\kappa3+\tfrac c4$, $\mathrm{tri}^2=(1+c)/3$, difference $\tfrac1{12}+\tfrac\kappa3-\tfrac c{12}\ge0$ on $[0,1]$ (`star_ge_tri`). Correct.
- $\mathop{\mathrm{dist}}(Z,\mathrm{Ext})^2\ge r^2+1-2r\,\mathrm{align}\ge1-\mathrm{align}^2$ at every radius, and $\mathop{\mathrm{dist}}(\cdot,\mathrm{Ext})$ is 1-Lipschitz, so $\mathop{\mathrm{dist}}(X_j,\mathrm{Ext})\ge\rho(\hat\kappa_j)-m_j$. Correct.
- $\rho$ is not monotone ($\min0.408$ at $\hat\kappa=0.8$, back to $0.5$ at $1$). The argument applies `lam_*` at the actual $\hat\kappa_j$ and bounds afterwards, so this is harmless.

## 6. Step 4, the deficit bound

- For a triangle- or star-type $X$, the pattern element $Z$ on $X$'s own planes and orientations has $\langle X,Z\rangle=p$, so $d^2\le2-2p$. With $p\ge0$ and $d^2\le2$ (Ext is closed under negation), `deficit_of_dist` gives $6(1-p^2)\ge6d^2(1-d^2/4)$. Correct.
- For every other top configuration the plateau needs $S_6\le2(2+\sqrt3)$, i.e. every non-extremal three-slot sum at most $2+\sqrt3$ **over nonnegative angles**. **Screen (exact, not sampled)**: all 3-slot choices on 6 planes and 3 kernel directions, signs and loops included, maximised by top eigenvectors of principal submatrices with nonnegative eigenvector. The maximum is $2+\sqrt3$, attained by the path with a loop and by the star with one minus slot, and nothing exceeds it.
- **The overclaim.** The note says step 4 is typed. Lean has `deficit_of_dist` and `plateau_le` (an UPPER bound on $4-2\sqrt3$), and the class ceilings only at $19/5$. With $19/5$ the plateau is $0.4$, $6(0.4)=2.4$, and the count needs $x<0.111$, so the exact $2+\sqrt3$ ceilings are load-bearing and untyped. The sign-variant classes can only be stated with nonnegativity hypotheses. **Correction**: type the ceilings $2+\sqrt3$ with $a_i\ge0$ for the classes that are extremal over $\mathbb R$ under a sign flip, or relabel step 4 as prose for the plateau.

## 7. Step 5, the leak constants

- `lam_pos`: hypotheses $\kappa,c\ge0$, $\kappa^2+c^2=1$, $\rho^2=\tfrac7{12}-\tfrac\kappa3-\tfrac c4$, $m\ge0$. Conclusion $0.5359-5.86(\rho-m)^2\le\tfrac12\kappa+2.3m^2$. `lam_neg` covers $m\ge\rho$. These are what the prose needs, with $\kappa$ the NORMALISED split.
- `phi_low` covers $e^2\le0.0914$, and the plateau is reached at $e^2=0.091377$, so there is no uncovered strip. Damage is $0$ above it.
- `plateau_le` has the right direction for damage ($4-2\sqrt3-\varphi\le0.5359-5.86e^2$).

## 8. Step 6, the count

- **The defect.** $D\le\sum_j(\tfrac12\hat\kappa_j+2.3m_j^2)$ with $\hat\kappa_j\le\lVert K_j\rVert^2/(1-m_j^2)$. The line $D\le\max(\tfrac{0.5}{g_K},\tfrac{2.3}{g_M})(x-y)$ needs $\hat\kappa_j\le\lVert K_j\rVert^2$. Counterexample to the per-partner inequality: $k=\lVert K\rVert^2=0.3$, $m^2=0.1$ gives $\min(0.5359,\ 0.5\cdot0.333+0.23)=0.397>0.5k+2.3m^2=0.38$.
- **Screened repair.** Per partner, the ratio of $\min(0.5359,\tfrac12\min(1,\tfrac{k}{1-m^2})+2.3m^2)$ to the worst-case cost $\tfrac k3+\tfrac{m^2}{0.677}$ (in units of $0.3-y$) has sup $1.627$ at $k=0.38$, $m^2=0.14$, against $1.557$ as written. The count needs this ratio below $0.3(1.2794+0.27657)/0.27657=1.688$. A linear form that works on a grid ($2001^2$, $k+m^2\le1$): damage $\le0.55\,k+2.45\,m^2$, ratio $\max(3\cdot0.55,\,0.677\cdot2.45)=1.659$, giving $D\le5.53x$ and closure for $x<0.2825$, margin $0.006$ in $x$. The exact chain (without the `lam` linearisation) gives ratio $1.542$ and more room.
- **Owed for the repair**: a lemma of the form $\min(4-2\sqrt3,\ \tfrac12\hat\kappa+2.3m^2)\le0.55k+2.45m^2$ for $\hat\kappa\le\min(1,k/(1-m^2))$, $k+m^2\le1$, plus the step-2 conversions at these constants ($0.55/g_K\le1.65/(0.3-y)$ from `sgK`, $2.45/g_M\le1.6587/(0.3-y)$ from `sgM_*`).
- **The rest of the arithmetic is right**: $(x-y)/(0.3-y)$ has $y$-derivative $(x-0.3)/(0.3-y)^2\le0$, $x\le1.936/7=0.276571$, and $3.21539-5.1903x>1.936-x\iff x<0.30532$. Two harmless roundings: $0.677\cdot2.3=1.5571$ (written $1.557$), $6(4-2\sqrt3)=3.21539$ (written $3.2154$).

## 9. Scope

- $n$ enters only through the kernel's dimension, and all bounds are dimension-free.
- Repeated angles: slot spaces depend on a choice of invariant planes, and $E$ is intrinsic once the gap is positive, which step 2 guarantees.
- A fifth plane with $b\to l_{\min}$: $g_K\to0$, and `sgK` then forces $y\ge0.3$, outside the case. Consistent.
- The partners' weights obey $0\le w_c\le1$, $\sum w_c=6$ (item 2), and nothing in steps 3 to 6 needs more.

## Corrections requested

1. Step 6 (and the "counting by hand" section): replace $\kappa_j\le\lVert K_j\rVert^2$ by $\hat\kappa_j\le\lVert K_j\rVert^2/(1-\lVert R_j\rVert^2)$, re-prove the damage bound in the budget variables (screened: $0.55k+2.45m^2$), and restate $D\le5.53x$ with margin $0.006$.
2. Step 4: the plateau $4-2\sqrt3$ rests on the ceilings $2+\sqrt3$ over nonnegative angles for every non-extremal class, including the sign variants. Type them or label them prose. They hold on an exact screen.
3. The claim's "typed" line: steps 2, 4 and 5 are typed only as scalar inequalities, and the plateau and the $\hat\kappa$ link are not.
