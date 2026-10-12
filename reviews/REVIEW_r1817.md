# REVIEW r1817: the product foothold and the knapsack reading of (MG), I121 route R53

Brief: [BRIEF_I121_foothold.md](BRIEF_I121_foothold.md). Log: [agent_logs/r1817-i121-foothold.log](../agent_logs/r1817-i121-foothold.log). Source note: [2026-09-28-LIT-step8-sweep.md](2026-09-28-LIT-step8-sweep.md). Lean read: [ProductFoothold.lean](../lean/HamiltonsCubic/Results/ProductFoothold.lean).

**Verdict: the foothold stands. The coupling bound, the value bound, the dichotomy, the averaging corollary and the knapsack rearrangement are all correct. The F67 clearance sentence is refuted as a general statement and needs rewording. Two corrections and four observations follow.** Everything was decided by hand from the definitions and the givens. No computation was run and no script is left.

| # | claim | verdict |
|---|---|---|
| 1 | coupling bound $a\le t\,c_*\,b^2$ at a product diagonal part | CONFIRMED, with observations O1 and O2 |
| 2 | $P(A)=dt^3$, "(MG) reads $\rho\le d$", $\rho=\Theta_n\ge d$ | CONFIRMED with correction C1 |
| 3 | value bound and dichotomy | CONFIRMED, with observation O3 |
| 4 | averaging corollary, $t^2\ge\tfrac6{(n+1)(n+2)}$, even $n\ge30$ | CONFIRMED |
| 5 | knapsack equivalence | CONFIRMED, with observation O4 |
| 6 | F67 clearance | REFUTED as a general statement, correction C2. Within the foothold it holds with a corrected attribution |
| 7 | hypotheses | CONFIRMED: no closedness is used, and the hypotheses used are listed below, with one strengthening (N1) |

## 1. The coupling bound, row by row, with $C$ arbitrary

**Cross terms vanish.** $a=\langle L_AB,B\rangle=t\langle L_eB,B\rangle$ by linearity of $L$ in its subscript. By [L120](../findings/second-order.md) at the diagonal $e$, $L_eB_U\in V_U$ for each nontrivial character $U$, and distinct character spaces are orthogonal. So $\langle L_eB,B\rangle=\sum_U\langle L_eB_U,B_U\rangle$. $B\perp\mathcal D_n$ by construction, so the trivial character is absent. The characters on $\mathrm{Sym}^2\Lambda^2$ are exactly the trivial one, the pair characters $\chi_{ij}$ (index pairs sharing one index) and the four-set characters (disjoint index pairs), so the list of rows is complete.

**Row by row**, with $a_{ik}=t\alpha,t\beta,t\gamma$ inside $P$, across and inside $Q'$:

- *Pair block $\chi_{ij}$ inside $P$.* $\delta_k=\tfrac12(a_{ik}-a_{jk})=0$ for every $k$, since $i,j$ see every $k$ through the same factor relation. The one-plane change is then $2\sin^22\varphi\,\lVert x\rVert^2\le0$ at every $\varphi$, so $x=0$ and $B_{ij}=0$. This uses no spectrum. The same holds inside $Q'$.
- *Mixed pair block, $i\in P$, $j\in Q'$.* $\delta$ is constant on each part: $\tfrac t2(\alpha-\beta)=\tfrac{t(q-1)}{2(n-2)}$ on $P\setminus i$ and $\tfrac t2(\beta-\gamma)=-\tfrac{t(p-1)}{2(n-2)}$ on $Q'\setminus j$. Its coordinate sum is $\tfrac t{2(n-2)}\big[(p-1)(q-1)-(q-1)(p-1)\big]=0$, so $\delta$ lies in the Ricci cut $\mathbf 1^\perp$ where the block lives. By the cross-factor row of [L127](../findings/second-order.md) the block's spectrum on $\mathbf 1^\perp$ is $0$ on the sum-zero-within-each-part vectors (dimension $(p-2)+(q-2)$) and $\tfrac d2$ on the one remaining line, the constant-on-parts line, which is $\delta$'s. The coordinates $x_k$ are coefficients in an orthogonal basis of common norm ([L122](../findings/second-order.md)), so the first-order condition $\langle\delta,x\rangle=0$ puts $x$ in the $0$-eigenspace exactly. **The orbit line is exactly the direction $\langle\delta,x\rangle=0$ removes, and the rest of the block is $0$.**
- *Four-set inside a factor, or split $3+1$.* By [L121](../findings/second-order.md), $A_0=B_0=C_0$ ($2\alpha$ each, or $\alpha+\beta$ each), so $E=0$ and the block is $0$. It contributes $0\le c_*$ and need not vanish.
- *Four-set split $2+2$.* The pairing $(ij\,|\,kl)$ rotates in the planes $(i,j)$ and $(k,l)$. In the double-rotation formula with $1,2,3,4=i,j,k,l$, the only pair profiles are $x^{12}$ (character $\chi_{ij}$, inside $P$) and $x^{34}$ (character $\chi_{kl}$, inside $Q'$), and every $\delta^{12}_m,\delta^{34}_m$ vanishes for the same reason as above. $\square=t\beta(1-1-1+1)=0$. The change is then $(v+w)^2\le0$, so $v+w=0$ with $v=W_{ik,jl}$, $w=W_{il,jk}$, matching the character table's labels. With Bianchi $u=v-w=2v$, the block is $(2v,v,-v)$, the $+c_*$ mode.

Summing, $a=t\,c_*\sum_{2+2}\lVert B_Q\rVert^2\le t\,c_*\,b^2$. **CONFIRMED.**

**O1. The double rotation is not needed for the upper bound.** The $-c_*$ mode has eigenvalue $-c_*<c_*$, so mass there only lowers $a$. Without the double rotation, $a\le t\,c_*\,b^2$ still holds, since every surviving eigenvalue ($0$, $\pm c_*$) is at most $c_*$ once the within-factor pair blocks and the orbit lines are gone. So the bound rests on the first-order condition and the one-plane bound only, both of which are local (second order) frame conditions. The brief's attack item on the eigenvector signs is therefore moot for claim 1. What does need removing: the orbit line at $\tfrac d2$, which exceeds $c_*$ whenever $(n-2)<(p-1)(q-1)$, and the within-factor $\tau_P=d\tfrac{p-2}{2(p-1)}$, which exceeds $c_*$ exactly when $(p-2)(q-1)>p+q-2$ (at $p=q=m$, when $(m-1)(m-4)>0$, i.e. $m\ge5$).

**O2. The quoted multiplicity table is malformed at $p=2$.** The within-factor row gives multiplicity $p-3=-1$. The row is never used spectrally (the block is killed by $\delta=0$), so nothing downstream is affected, but the table should carry $p\ge3$ on that row.

## 2. $P(A)=dt^3$ and what (MG) reads

$P(A)=P(te)=t^3\langle Q(e),e\rangle=t^3d$. **Correct.** $d=P(e)\le\max P=\Theta_n=\rho$ at a global maximiser under the brief's definition of $\Theta_n$. Under the audit note's usage ($\Theta_n$ the maximum over diagonal operators, [L57](../findings/problem.md)) one has $\rho\ge\Theta_n\ge d$ instead. Either reading gives $d\le\rho$, which is all that is used.

**C1.** "(MG) reads $\rho\le d$" is imprecise. With $P(A)/t^3=d$, (MG) reads $\rho\le\max\{\sqrt{3/2},d\}$, which is $\rho\le d$ only when $d\ge\sqrt{3/2}$ (the balanced product at $n\ge12$, and no product at $n<12$). The argument proves $\rho\le d$, which implies (MG) in every case, so the conclusions stand. Suggested wording: "(MG) follows from $\rho\le d$".

## 3. The value bound and the dichotomy

From $P(A)=\rho t^2-a$ and claim 1, $dt^3\ge\rho t^2-t\,c_*(1-t^2)$, and dividing by $t^2>0$ gives $\rho\le dt+c_*\tfrac{1-t^2}t$. **Correct.** With $g(t)=dt+c_*\tfrac{1-t^2}t$, $g(t)-d=(1-t)\big[\tfrac{c_*(1+t)}t-d\big]$. So $d\le\rho\le g(t)$ with $t<1$ forces $t(d-c_*)\le c_*$, and $t=1$ is $b=0$. **The dichotomy is correct**, and $g(t)\le d$ for $t\ge c_*/(d-c_*)$ gives (MG) above the threshold at any unit critical point in such a frame, without $d\le\rho$. At the threshold itself $g=d$, so $b>0$ is not excluded there, and the corollary needs the strict inequality (claim 4 supplies it).

$c_*<d$: $c_*/d=\tfrac{n-2}{2(p-1)(q-1)}<1\iff 2pq-3p-3q+4>0\iff(2p-3)(2q-3)>1$. **Correct**, and equality holds only at $p=q=2$. It is needed for the dichotomy's division and sufficient for it. `dichotomy` and `mg_of_threshold` in [ProductFoothold.lean](../lean/HamiltonsCubic/Results/ProductFoothold.lean) state exactly these scalar steps with these hypotheses.

**O3. The threshold is vacuous on a family.** $c_*/(d-c_*)<1\iff c_*<\tfrac d2\iff n-2<(p-1)(q-1)$. This fails at $p=2$ or $q=2$ (every $S^2\times S^q$) and at $S^3\times S^3$, where the threshold is at least $1$ and the dichotomy says nothing beyond $t\le1$. The balanced threshold $\tfrac1{m-2}$ is $1$ at $m=3$ and first bites at $m=4$ ($n=8$). The note should say so beside "(MG) holds whenever".

## 4. The averaging corollary

- **Irreducibility.** $\mathcal W_n$ is irreducible under $O(n)$ for every $n\ge4$ (at $n=4$ it splits under $SO(4)$ into $\mathcal W^\pm$, which a reflection exchanges). The averaged operator $\int g^{-1}\pi_{\mathcal D}g\,dg$ is symmetric and commutes with $O(n)$, so its eigenspaces are invariant and it is a scalar, with no appeal to absolute irreducibility.
- **The scalar.** $\pi_{\mathcal D}$ maps $\mathcal W_n$ into $\mathcal D_n\subset\mathcal W_n$, since Ricci-flatness constrains frame-diagonal entries only and a diagonal operator meets Bianchi trivially ([second-order.md](../findings/second-order.md), the scope note under L123). Its trace on $\mathcal W_n$ is $\dim\mathcal D_n$, so the average of $\lVert\pi_{\mathcal D}(gW)\rVert^2$ is $\dim\mathcal D_n/\dim\mathcal W_n=\tfrac6{(n+1)(n+2)}$ at $\lVert W\rVert=1$, in the same Hilbert–Schmidt norm as $t$. The maximum over $O(n)$ is at least the average. **Correct.**
- **The agreement with [bispectral.md](../findings/bispectral.md).** Its $t_F=\sum_{a\ne b}W_{abab}^2$ runs over ordered pairs at $\lVert M\rVert_F=1$ on $\Lambda^2$ (Lemma L94's statement), which is twice the unordered sum, so $\tfrac{12}{(n+1)(n+2)}$ there is $\tfrac6{(n+1)(n+2)}$ here. **Correct.**
- **The crossing.** $\tfrac6{(n+1)(n+2)}\ge\tfrac4{(n-4)^2}\iff2n^2-60n+88\ge0\iff n^2-30n+44\ge0$, roots $15\pm\sqrt{181}\approx1.55,\,28.45$. It holds at $n=29$ ($15>0$) and fails at $n=28$ ($-12$). The roots are irrational, so at integer $n$ the inequality is strict, which is what the dichotomy needs to exclude $b>0$. At even $n$ the condition is $n\ge30$. **Correct**, and `average_beats_threshold` types the strict form.

## 5. The knapsack equivalence

At $\rho>\sqrt{3/2}$, (MG) is $P(A)\ge\rho t^3$, which with $P(A)=\rho t^2-a$ is $a\le\rho t^2(1-t)$. For an orthonormal eigenbasis $\varphi_i$ of the compression of $L_{\hat A}$ to $\mathcal D_n^\perp\cap\mathcal W_n$, $y_i=\langle B,\varphi_i\rangle^2$ gives $\sum y_i=b^2=1-t^2$ and $a=t\sum\lambda_iy_i$. Dividing by $t(1-t^2)$ at $0<t<1$ turns $\sum\lambda_iy_i\le\rho t(1-t)$ into $\sum(\lambda_i-\tfrac{\rho t}{1+t})y_i\le0$. **Correct.** The agreement paragraph's test-vector value checks as well: at $X=b^2A-t^2B$, $\lVert X\rVert^2=t^2b^2$ and $\langle L_WX,X\rangle=\rho t^2b^2-a$ from both L214 relations and $\langle Q(A),B\rangle=0$, and the cap then gives $a\ge\tfrac\rho2t^2(1-t^2)$. Since $\tfrac\rho2t^2(1-t^2)\le\rho t^2(1-t)$ at every $t\in[0,1]$, the two bounds are compatible.

**O4.** Three precision points. (i) The display drops the qualifiers $\rho>\sqrt{3/2}$ and $0<t<1$ that the equivalence needs. (ii) L120 is not needed for the decomposition itself: the compression of a self-adjoint operator to $\mathcal D_n^\perp$ has an orthonormal eigenbasis whatever it preserves, and $a$ only sees the compression. L120 is what makes the eigenbasis explicit per character. (iii) **"The orbit line removed exactly" is exact only when $\hat A$ is a critical point.** Differentiating $Q(g\cdot\hat A)=g\cdot Q(\hat A)$ along $E_{ij}$ gives $L_{\hat A}[E_{ij},\hat A]=\tfrac12[E_{ij},Q(\hat A)]$, which is proportional to $[E_{ij},\hat A]$, the direction $\delta$, only when $Q(\hat A)$ is proportional to $\hat A$ on that block. In the nonclosed branch $q_\perp\ne0$ generically, so the first-order condition removes a direction that cuts across eigenmodes instead of removing one. The knapsack stays valid (the frame constraints are linear in $B$), but in "What it leaves" the constraint $\langle\delta,x\rangle=0$ is a linear constraint on the $x$-coordinates, not the deletion of a mode.

## 6. The F67 clearance

The sentence "What clears F67 is that the orbit direction is exactly the one the maximal frame's first-order condition removes from $\nu$", together with "the orbit direction alone carrying $\tfrac12\theta$", is **REFUTED as a general statement**, on the record's own data.

- **An orbit-free direction above $\tfrac12\Theta_n$ is on the record.** The F67 block in [second-order.md](../findings/second-order.md) (the paragraph under L120, cited to r926 and r927) records $\Lambda_n\ge\tfrac{\sqrt3}2$ from a padded $S^2\times S^2$ through L121's four-set block. Four-set blocks are orbit-free (`orbit_perp_fourSet`, [L126](../findings/second-order.md)), so the first-order condition leaves that direction untouched, and $\tfrac{\sqrt3}2>\tfrac12\Theta_n$. F67's own argument, $f(t)=\sqrt t\,\Theta_n+(1-t)\Lambda/\sqrt t\ge\Theta_n$ whenever $\Lambda\ge\tfrac12\Theta_n$, then applies unchanged to the orbit-free supremum. Removing the orbit direction does not clear F67.
- **Within the product foothold another near-$\tfrac12$ direction survives the first-order condition.** The within-factor pair block carries $\tau_P=d\tfrac{p-2}{2(p-1)}$, which tends to $\tfrac d2$ as $p$ grows and exceeds $c_*$ at the balanced product from $m=5$ (O1). It is removed by the **second-order** one-plane bound (through $\delta=0$), not by the first-order condition.
- **At noncritical diagonal parts** the orbit direction is not an eigenvector of $L_{\hat A}$ at all (O4 (iii)), so "exactly" has no counterpart there.

**C2, the correction.** What clears F67 in the foothold is the combination of the first-order condition (the orbit line of each mixed pair block, at $\tfrac d2$), the one-plane second-order bound (the whole within-factor pair blocks, including $\tau_P$), and the product structure itself (the only remaining positive eigenvalue is $c_*$, which is small). In general, clearing F67 needs the frame inequalities to control orbit-free directions too, which is what the knapsack paragraph and "What it leaves" say. The F67 sentence should be restricted to product diagonal parts and should name the one-plane bound alongside the first-order condition.

## 7. Hypotheses

Where each is used, read link by link:

| hypothesis | where it is used |
|---|---|
| unit critical point, $Q(W)=\rho W$ | $P(A)=\rho t^2-a$ (L214's first relation, criticality only) |
| frame conditions | claim 1: the first-order condition and the one-plane bound, both local second-order conditions (the one-plane mass is a quadratic form in $(\cos2\varphi,\sin2\varphi)$), plus the double rotation, which needs finite angle and so global frame maximality but is dispensable by O1. Claim 4: global maximality (maximum at least the average) |
| global maximiser $W$ | only $d\le\rho$ in the dichotomy and the corollary. The value bound and (MG) above the threshold do not use it |
| $\hat A=e$ in its own frame, $n=p+q$, $p,q\ge2$ | the block-constant diagonal behind $\delta$, $\square$ and the character table |
| $d>0$ | $c_*>0$ (so the $0$-modes sit at most at $c_*$) and $c_*<d$ |
| $(p,q)\ne(2,2)$ | $c_*<d$ |
| $0<t$ | dividing by $t$ |
| $C=0$ | nowhere. **No step uses closedness**, and nothing in the claims is true only in the closed branch |

Nothing is used without being stated, apart from the qualifiers in C1 and O4 (i). **CONFIRMED.**

**N1. The negated product is empty, which extends "proportional to a product" to both signs.** Suppose $\hat A=-e$ with $e$ as above and $d>0$. Then $L_{\hat A}=-L_e$. The within-factor pair blocks and the orbit lines go as before, and the double rotation (needed here, unlike O1) leaves only the $(2,1,-1)$ mode, whose $L_{-e}$-eigenvalue is $-c_*$. So $a=-t\,c_*\lVert B_{2+2}\rVert^2\le0$, while $P(A)=-dt^3<0$, and $\rho t^2=P(A)+a<0$. **At any unit critical point with $\rho>0$ in a globally maximal frame, the diagonal part is never a negative multiple of a sphere product.** This matches the closed-branch remark of [r1802](REVIEW_r1802.md) and removes the closedness from it. So the corollary reads: at even $n\ge30$, a global maximiser whose maximal-frame diagonal part is proportional (with either sign) to the balanced product is diagonal.

## Method

Every claim was checked by hand from the definitions and the brief's givens, reading [2026-09-28-I121-MG-audit.md](2026-09-28-I121-MG-audit.md), the L120 to L127 blocks and the F67 paragraph of [second-order.md](../findings/second-order.md), Lemma L94 of [bispectral.md](../findings/bispectral.md), and [ProductFoothold.lean](../lean/HamiltonsCubic/Results/ProductFoothold.lean), whose seven declarations state the scalar steps with the hypotheses the note uses. No computation was needed: every claim was decided by an argument, and O1 made the one candidate screen (the signs of the $2+2$ eigenvectors) irrelevant to claim 1.
