# Review r1913: the I-lift family between H and P (I123, third attempt)

Log: [agent_logs/r1913-lift-family.log](../agent_logs/r1913-lift-family.log). Section under review: [2026-09-28o-I123-coupling.md](2026-09-28o-I123-coupling.md), "Third attempt". Lean: [I123LiftFamily.lean](../lean/HamiltonsCubic/Results/I123LiftFamily.lean). Footing: analysis only, every claim below derived by hand; no numerical screen was needed.

**Verdict: the statement is correct and its proof is complete as written, with two wording corrections (the "only s=0 is sharp" clause and the first bullet are conditional on H and on P). The theorem itself uses neither H nor P.**

| # | claim | verdict |
|---|---|---|
| 1 | expansion of G_s(W+cI) | CONFIRMED |
| 2 | passage to b(s) | CONFIRMED (min exists; inf would suffice) |
| 3 | affine split | CONFIRMED |
| 4 | min f(u,0) = beta, A = t0, B = beta, t0 + beta = theta0 | CONFIRMED, closed forms derived below |
| 5 | phi >= 1, theta0 < sqrt(2(n-1)/n), the conclusion; use of H | CONFIRMED; H is not used by the inequality, only by the clause "s=0 is sharp" |
| 6 | the two closing bullets | CONFIRMED with correction (bullet 1 conditional) / CONFIRMED (bullet 2) |
| 7 | Lean | CONFIRMED (see row detail for axioms) |
| 8 | prior record | AGREES with and generalises findings/diagonal-half.md's split; extends batch 3 of 28n from s=1 to a segment |

## 1. Expansion

With $X=W+cI$, $\lVert W\rVert=1$, $\operatorname{tr}W=0$: $\operatorname{tr}X^3=A+3c\operatorname{tr}W^2+3c^2\operatorname{tr}W+c^3N=A+3c+c^3N$. By full symmetry of $\langle X^\#Y,Z\rangle$, $\langle X^\#X,X\rangle=B+3c\langle W^\#W,I\rangle+3c^2\langle W^\#I,I\rangle+c^3\langle I^\#I,I\rangle$, and $\langle W^\#W,I\rangle=\langle I^\#W,W\rangle=-1$, $\langle W^\#I,I\rangle=-\operatorname{tr}W=0$, $\langle I^\#I,I\rangle=(n-2)N$. So $G_s(W+cI)=sA+B+3c(s-1)+c^3N(s+n-2)$. Agrees with 28n batch 3 at $s=1$.

## 2. Passage to b(s)

$\lVert W+cI\rVert^2=1+c^2N$, so $sA+B\le g_s(1+c^2N)^{3/2}-3c(s-1)-c^3N(s+n-2)$ for every $c$. The coefficient of $g_s$ is positive, so the bracket increases with $g_s$. $G_s(I)=N(s+n-2)$ and $\lVert I\rVert^3=N^{3/2}$, so any valid cap has $g_s\ge(s+n-2)/\sqrt N$. With $c=u/\sqrt N$ the bracket at that least $g_s$ is exactly $f(u,s)$. The minimum exists: the bracket is continuous, and as $u\to+\infty$ it is at least $f(u,s)\sim\frac{(s+n-2)\tfrac32u+3u(1-s)}{\sqrt N}\to\infty$, as $u\to-\infty$ every term is positive and cubic. Only the lower bound $b(s)\ge\min_uf(u,s)$ is used, so an infimum would serve equally.

## 3. Affine split

$(1-s)\big((n-2)\varphi+3u\big)+s(n-1)\varphi=(n-2)\varphi+s\varphi+3u(1-s)=(s+n-2)\varphi+3u(1-s)$. Confirmed; this is `lift_affine`, a `ring` identity.

## 4. The minimum and the balanced product

**Minimum.** Put $h(u)=(n-2)\varphi(u)+3u$. $h'(u)=3(n-2)\big(u\sqrt{1+u^2}-u^2\big)+3$. The map $u\mapsto u\sqrt{1+u^2}-u^2$ has derivative $\frac{1+2u^2}{\sqrt{1+u^2}}-2u>0$ (clear for $u\le0$, and for $u>0$ from $(1+2u^2)^2>4u^2(1+u^2)$), so $h$ is strictly convex and has one critical point, at $u=-v$ with $(n-2)v(\sqrt{1+v^2}+v)=1$. Squaring $v\sqrt{1+v^2}=k-v^2$, $k=\frac1{n-2}$, gives $v^2=\frac{k^2}{1+2k}$, so $v=\frac1{\sqrt{n(n-2)}}$ (and $k-v^2>0$, so no spurious root). Then $1+v^2=\frac{(n-1)^2}{n(n-2)}$, $(1+v^2)^{3/2}+v^3=\frac{(n-1)^3+1}{(n(n-2))^{3/2}}=\frac{n(n^2-3n+3)}{(n(n-2))^{3/2}}$, and $h(-v)=\frac{n^2-3n+3-3}{\sqrt{n(n-2)}}=(n-3)\sqrt{\tfrac n{n-2}}$. Dividing by $\sqrt N$:
$$\min_uf(u,0)=(n-3)\sqrt{\frac2{(n-1)(n-2)}},$$
which at $n=2m$ is $\frac{2m-3}{\sqrt{(m-1)(2m-1)}}=\beta$. Confirmed at every $n$, not only even $n$.

**Balanced product.** On $\Lambda^2\mathbb R^{2m}=\Lambda^2V_1\oplus\Lambda^2V_2\oplus V_1\otimes V_2$ the curvature operator is $R=E_1+E_2$ (identity on the two $\Lambda^2V_i$, zero on the mixed part), Einstein with scalar curvature $2m(m-1)$, so $W=R-\lambda I$ with $\lambda=\frac{m-1}{2m-1}$: eigenvalue $\frac m{2m-1}$ on dimension $m(m-1)$ and $-\frac{m-1}{2m-1}$ on dimension $m^2$. Then $\lVert W\rVert^2=\frac{m^2(m-1)}{2m-1}$ and $\operatorname{tr}W^3=\frac{m^2(m-1)}{(2m-1)^2}$, so $A=\frac{\operatorname{tr}W^3}{\lVert W\rVert^3}=\frac1{m\sqrt{(m-1)(2m-1)}}=t_0$. For $B$: $[\mathfrak{so}(V_1),\mathfrak{so}(V_2)]=0$ gives $E_1^\#E_2=0$ and $E_i^\#E_i=(m-2)E_i$, so $R^\#R=(m-2)R$; with $I^\#R=-W+\lambda(n-2)I$, $W^\#W=(m-2)(W+\lambda I)+2\lambda W-\lambda^2(n-2)I$, so $\langle W^\#W,W\rangle=(m-2+2\lambda)\lVert W\rVert^2=\frac{m(2m-3)}{2m-1}\lVert W\rVert^2$ and $B=\frac{m(2m-3)}{(2m-1)\lVert W\rVert}=\frac{2m-3}{\sqrt{(m-1)(2m-1)}}=\beta$. Finally $t_0+\beta=\frac{1+2m^2-3m}{m\sqrt{(m-1)(2m-1)}}=\frac{(2m-1)(m-1)}{m\sqrt{(m-1)(2m-1)}}=\frac{\sqrt{(m-1)(2m-1)}}m=\theta_0$. All confirmed.

## 5. The conclusion, and whether H is used

$\varphi\ge1$: $(1+u^2)^3-(1+u^3)^2=u^2(3u^2-2u+3)\ge0$ (discriminant $4-36<0$), so $(1+u^2)^{3/2}\ge\lvert1+u^3\rvert\ge1+u^3$. Then $f(u,1)=(n-1)\varphi/\sqrt N\ge(n-1)/\sqrt N=\sqrt{2(n-1)/n}$. $\theta_0^2=\frac{(2m-1)(m-1)}{m^2}=\frac{2m-1}m\cdot\frac{m-1}m<\frac{2m-1}m=\frac{2(n-1)}n$. So $b(s)\ge\min_uf(u,s)\ge(1-s)\beta+s\sqrt{2(n-1)/n}$ and $b(s)-(st_0+\beta)\ge s\big(\sqrt{2(n-1)/n}-\beta-t_0\big)=s\big(\sqrt{2(n-1)/n}-\theta_0\big)>0$ for $s\in(0,1]$. The bound is uniform over all valid caps $g_s$. At $n=12$ the gap coefficient is $1.354006-1.236033=0.117973$.

**H is not used.** The inequality uses $\min_uf(u,0)=\beta$, which is the calculus fact of row 4, and $g_s\ge G_s(I)/\lVert I\rVert^3$, which holds for any valid cap. H enters only the clause "only $s=0$, statement H, is sharp there": $b(0)=\beta$, attained at the balanced product, holds exactly when $g_0=(n-2)/\sqrt N$ is a valid cap, which is H. **Correction:** that clause should read "every $s\in(0,1]$ misses the balanced product; $s=0$ reaches it if and only if H holds". The Lean docstring's "given that $\beta$ is the bracket's minimum at $s=0$" is likewise a calculus fact, and the section's "enter as hypotheses" could note that row 4 closes it.

## 6. The closing bullets

- **Bullet 1 (joint range).** The geometric reading is right, with one correction: the line of normal $(1,1)$ through $(t_0,\beta)$ is a supporting line of the joint range exactly when P holds, and the line of normal $(0,1)$ exactly when H holds on the Weyl subspace. The bullet states both unconditionally. Also worth saying: if H and P both hold, every normal $(s,1)$, $s\in[0,1]$, supports the range at $(t_0,\beta)$, since $sA+B=s(A+B)+(1-s)B\le s\theta_0+(1-s)\beta=st_0+\beta$. So the theorem shows the $I$-lift fails to certify inequalities that are (conjecturally) true, which is the reading "a whole segment of failures" intends. The phrase "the $I$-lift certifies the second" is conditional on H.
- **Bullet 2.** Under H, $B\le\beta$, so $A\le t_0$ gives $A+B\le t_0+\beta=\theta_0$. Confirmed; this is immediate and uses neither the lift nor the theorem. $t_0(12)=1/(6\sqrt{55})=0.022473$ is correct (the section's $0.02247$ truncates). "Sharp at the balanced product in both halves" is right in the sense that the balanced product has $A=t_0$, on the boundary of the remaining region, with $B=\beta$ saturating H, so any certificate on the closure of $\{A>t_0\}$ must be tight there. The remaining region is stated for $n=2m$ only, where $t_0$ and $\beta$ are defined.

## 7. Lean

- `phi_ge_one (u y) (hy : 0 ≤ y) (hy2 : y^2 = (1+u^2)^3) : 1 ≤ y - u^3` states $\varphi\ge1$ as the table says.
- `lift_affine` is the split, as a ring identity with $\varphi$ a free variable.
- `theta0_lt_sphere (m) (hm : 2 ≤ m)` states $\frac{(2m-1)(m-1)}{m^2}<\frac{2(2m-1)}{2m}$. Correct. The step from it to the hypothesis `hθ : θ0 * R < n - 1` of `lift_not_sharp` (taking square roots, $R=\sqrt N$) is prose.
- `lift_not_sharp` proves $(\beta+s(\theta_0-\beta))R<(s+n-2)\varphi+3u(1-s)$ from $0<s\le1$, $\varphi\ge1$, $n\ge2$, $\beta R\le(n-2)\varphi+3u$, $\theta_0R<n-1$. Correct and non-vacuous: the file's `example` instantiates every hypothesis at $n=12$, $s=\frac12$, $\varphi=1$, $u=0$, $R=8$, $\beta=1$, $\theta_0=\frac{13}{10}$, and the true values ($R=\sqrt{66}$, $\beta=9/\sqrt{55}$, $\theta_0=\sqrt{55}/6$, with $\varphi$ and $u$ tied) also satisfy them by rows 4 and 5. It carries the strict gap only; the quantitative gap $s(\sqrt{2(n-1)/n}-\theta_0)$ of the statement is prose (it follows from the same two lines of the proof with $\ge$ in place of $>$).
- Variables $\varphi,u,R,\beta,\theta_0$ are untied reals, so the Lean is an arithmetic skeleton; the table says as much. No overclaim.
- Axioms: all four depend on `[propext, Classical.choice, Quot.sound]` only (`#print axioms` via `lake env lean` on the built module, exit 0). No `sorry`.

## 8. Prior record

- [findings/diagonal-half.md](../findings/diagonal-half.md) line 43 (after [r389](REVIEW_r389.md)) already records the split $1.236033=1.213562+0.022471$ at $S^6\times S^6$, with the $\tfrac12\operatorname{tr}M^3$ (triangle, that is $\#$) half at a cap it saturates, and the entrywise ($\operatorname{tr}W^3$) half supplying $0.022471$, and concludes "the two halves are not independent ... the coupling is what a proof has to use". That split is exactly $(B,A)=(\beta,t_0)$ at $m=6$ on the diagonal locus. The section agrees with it and generalises the closed forms to every $m$; the closed form of $t_0$ is also on record as $p_3(\mu)$ in [findings/bispectral.md](../findings/bispectral.md) (lines 186 to 188, 510) and in [findings/ad-form-attempt.md](../findings/ad-form-attempt.md) line 9.
- The $\beta$ cap and the halves-apart fact are [28m](2026-09-28m-LIT-step8-sweep.md) question 2 and F26; the $s=1$ end is [28n](2026-09-28n-LIT-step8-sweep.md) batch 3.
- **New:** the interpolation over $s\in(0,1)$, the closed form of the $s=0$ minimum at every $n$ (row 4, which the section cites rather than derives), and the quantitative gap. This sharpens batch 3 from a point to a segment; nothing duplicates it. Bullet 2 restates, in $(A,B)$ coordinates, what diagonal-half line 43 and 28m question 2 already say; a cross-reference to diagonal-half line 43 would be proper.
