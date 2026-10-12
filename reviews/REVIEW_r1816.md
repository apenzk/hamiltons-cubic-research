# REVIEW r1816: the product foothold and the knapsack reading of (MG), I121 route R53

Brief: [BRIEF_I121_foothold.md](BRIEF_I121_foothold.md). Log: [agent_logs/r1816-i121-foothold.log](../agent_logs/r1816-i121-foothold.log). Reviewer: r1816, Gate 2, analysis-only footing. Script: [scripts/reviewers/r1816_product_coupling_screen.py](../scripts/reviewers/r1816_product_coupling_screen.py), a screen of stated values (seconds of compute at six products), never evidence for a positive claim.

**Verdict: the foothold stands. The coupling bound, the value bound, the dichotomy, the threshold and the averaging corollary are CONFIRMED. The F67 clearance sentence is REFUTED as an account of what clears F67: the first-order condition removes the orbit line, but the within-factor modes at eigenvalue $\tau_P\to d/2$ survive it and are removed only by the second-order one-plane bound.**

| # | claim | verdict |
|---|---|---|
| 0 | agreement with L214: $P(A)=\rho t^2-a$, $P(B)=\rho b^2-2a$, test value $\rho t^2b^2-a$, (MG) $\iff a\le\rho t^2(1-t)$ above $\sqrt{3/2}$, cap $a\ge\frac\rho2t^2(1-t^2)$, unit form | CONFIRMED |
| 1 | coupling bound $a\le t\,c_*\,b^2$ at a product diagonal part, row by row | CONFIRMED, with observations O1 to O3 |
| 2 | $P(A)=dt^3$, "(MG) reads $\rho\le d$", $\rho=\Theta_n\ge d$ | CONFIRMED, O4 on the wording |
| 3 | value bound, dichotomy, threshold, $c_*<d$ off $S^2\times S^2$, balanced threshold $\frac1{m-2}$ | CONFIRMED, O5 on where the threshold has content |
| 4 | averaging corollary, $t^2\ge\frac6{(n+1)(n+2)}$, $n^2-30n+44\ge0$, even $n\ge30$ | CONFIRMED |
| 5 | knapsack equivalence and the mode decomposition $a=t\sum\lambda_iy_i$ | CONFIRMED, O6 on the hypothesis $\rho>\sqrt{3/2}$ |
| 6 | F67 clearance: "What clears F67 is that the orbit direction is exactly the one the maximal frame's first-order condition removes from $\nu$" | REFUTED as stated, correction below |
| 7 | hypotheses | CONFIRMED, notes H1 to H3 |

## Claim 0, agreement with L214

- With $t_{214}=t^2$ L214's two relations are $\rho t^2=P(A)+a$ and $\rho b^2=2a+P(B)$, as stated.
- The test vector is $X=b^2A-t^2B$. Then $\langle X,W\rangle=b^2t^2-t^2b^2=0$ and $\lVert X\rVert^2=t^2b^2$. With $T(x,y,z)=\langle L_xy,z\rangle$ totally symmetric and $T(A,A,B)=0$ (as $L_AA$ is diagonal), $T(W,X,X)=b^4P(A)-2b^2t^2a+t^4a+t^4P(B)$, and substituting both relations gives $\rho t^2b^2(t^2+b^2)-a(t^2+b^2)^2=\rho t^2b^2-a$. The cap $\le\frac\rho2\lVert X\rVert^2$ is then $a\ge\frac\rho2t^2(1-t^2)$.
- Above $\sqrt{3/2}$, (MG) is $\rho t^3\le P(A)=\rho t^2-a$, i.e. $a\le\rho t^2(1-t)$. The two bounds are compatible since $\frac{1+t}2\le1$.
- Dividing $\rho t^2=t^3P(\hat A)+tb^2\langle L_{\hat A}\nu,\nu\rangle$ by $t^2$ gives the unit form. [mg_iff_coupling](../lean/HamiltonsCubic/Results/ProductFoothold.lean) states exactly this equivalence.

## Claim 1, the coupling bound, character by character with $C$ arbitrary

The claim rests on four facts, each checked from the definitions.

- **Cross terms vanish.** $L_e$ preserves every $\Gamma$-isotypic summand (L120), and distinct summands are HS-orthogonal, so $\langle L_eB,B\rangle=\sum_\chi\langle L_eB_\chi,B_\chi\rangle$. $B\perp\mathcal D_n$ by construction.
- **The pair character $\chi_{ij}$ is exactly the profile.** An entry $W(e_a\wedge e_b,e_c\wedge e_d)$ carries the character of $\{a,b\}\triangle\{c,d\}$, which equals $\{i,j\}$ only for $\{a,b\}=\{i,k\}$, $\{c,d\}=\{j,k\}$. So $B_{ij}$ is determined by $x_k=W_{ik,jk}$, as the one-plane bound assumes.
- **Within-factor pair block.** $a_{ik}$ is block-constant, so $i,j\in P$ gives $a_{ik}=a_{jk}$ for every $k$ and $\delta=0$. The one-plane change is then $2\sin^22\varphi\lVert x\rVert^2$, and maximality forces $x=0$. The $\tau_P$ and $-c_*$ modes carry no mass.
- **Mixed pair block.** For $i\in P$, $j\in Q'$, $\delta_k=\frac t2(\alpha-\beta)$ for $k\in P$ and $\frac t2(\beta-\gamma)$ for $k\in Q'$, which is nonzero and satisfies the trace condition $\sum_k\delta_k=0$ (both row sums of the diagonal equal $-a_{ij}$). Differentiating $Q(g\cdot e)=d\,g\cdot e$ gives $L_e(\mathrm{ad}_\xi e)=\frac d2\mathrm{ad}_\xi e$, and $\mathrm{ad}_{E_{ij}}e$ lies in $\chi_{ij}$ with profile $\propto\delta$ (the tangent of the one-plane formula at $\varphi=0$ is $2\delta$). The HS norm on the block is twice the Euclidean norm of $x$, uniformly, so $\langle\delta,x\rangle=0$ is HS-orthogonality to the orbit line. What remains lies in the $0$-eigenspace.
- **Four-sets.** Inside a factor and $3+1$ carry $0$. A $2+2$ four-set has top eigenvalue $c_*$, so its contribution is at most $c_*\lVert B_Q\rVert^2$.

Summing gives $a=t\langle L_eB,B\rangle\le t\,c_*\sum_{2+2}\lVert B_Q\rVert^2\le t\,c_*\,b^2$.

**Screen.** The script builds $\mathcal W_n$ from Bianchi and Ricci-free constraints, forms $L_e=\pi_{\mathcal W}Q(e,\cdot)$ at the unit product, and compresses it to $\{B\perp\mathcal D_n$, within-factor profiles zero, mixed profiles $\perp\delta\}$. The top eigenvalue equals $c_*$ to six digits at $(p,q)=(2,3),(3,3),(2,4),(3,4),(4,4),(5,5),(4,6)$, with $Q(e)=de$ residual below $5\times10^{-16}$ and $d$ reproducing $\theta_0(6)=1.054093$.

- **O1. The double rotation is not needed for the bound.** The $-c_*$ mode contributes $-c_*\lVert\cdot\rVert^2\le c_*\lVert\cdot\rVert^2$, so $a\le tc_*b^2$ holds whether or not $v+w=0$ is forced. The step "forces $v+w=0$ and $B$ keeps the $+c_*$ mode only" is itself correct: in the pairing $(ij\,|\,kl)$, $\square=t(\beta-\beta-\beta+\beta)=0$, the bracketed terms involve only $\chi_{kl}$ at $m\in\{i,j\}$ and $\chi_{ij}$ at $m\in\{k,l\}$ and the $m\ge5$ terms only $\chi_{ij},\chi_{kl}$, all within-factor, all zero with $\delta=0$, leaving $(v+w)^2\le0$. With Bianchi, $v+w=0$ gives $(u,v,w)=v(2,1,-1)$. It sharpens the statement to $a=tc_*\lVert B_{2+2}\rVert^2\ge0$, and is not load-bearing.
- **O2. Global frame maximality is more than the bound uses.** The within-factor kill is second-order at $\varphi\to0$, and the orbit removal is first-order, so a frame that is a local maximum of diagonal mass suffices for $a\le tc_*b^2$.
- **O3. The mixed block's rest spectrum is $0$**, as the table states. The screen confirms the compression's top eigenvalue is $c_*$, so no positive mode survives there.

## Claim 2

- $P(A)=P(te)=t^3\langle Q(e),e\rangle=dt^3$ with $\lVert e\rVert=1$.
- At a global maximiser $Q(W)=\rho W$ with $\rho=P(W)=\Theta_n\ge P(e)=d$.
- **O4.** "(MG) reads $\rho\le d$" is exact only when $d\ge\sqrt{3/2}$. Otherwise (MG) reads $\rho\le\sqrt{3/2}$, and $\rho\le d$ is a sufficient condition for it. The screen gives $d<\sqrt{3/2}$ at every product up to $n=10$ ($d=1.2$ at $S^5\times S^5$). The logic is unaffected, since the argument concludes $\rho\le d$, which implies (MG) in either case, and [mg_of_threshold](../lean/HamiltonsCubic/Results/ProductFoothold.lean) concludes $\rho\le d$.

## Claim 3

- **Value bound.** $dt^3=\rho t^2-a\ge\rho t^2-tc_*(1-t^2)$, divided by $t>0$.
- **Dichotomy.** With $\rho\ge d$: $dt(1-t)\le c_*(1-t)(1+t)$. At $t=1$, $b=0$. At $t<1$, $t(d-c_*)\le c_*$, which needs $d>c_*$ to yield an upper bound on $t$. So $c_*<d$ is needed, and sufficient.
- **(MG) above the threshold.** The value bound is $\le d$ exactly when $(d-c_*)t^2-dt+c_*\le0$, whose roots are $t=1$ and $T=c_*/(d-c_*)$. So $t\in[T,1]$ gives $\rho\le d$ without using $\rho\ge d$. At $t=T$ exactly with $b\ne0$, (MG) holds with equality possible, and the dichotomy does not force $b=0$, which is why the corollary needs strict inequality (it has it).
- **$c_*<d$.** $\frac{n-2}{2(p-1)(q-1)}<1\iff 2pq-3p-3q+4>0\iff(2p-3)(2q-3)>1$, equality exactly at $(2,2)$.
- **Balanced.** $c_*=d\frac{2m-2}{2(m-1)^2}=\frac d{m-1}$, $T=\frac1{m-2}$.
- **O5. Where the threshold has content.** $T\le1\iff c_*\le\frac d2\iff(p-2)(q-2)\ge1$, and $T<1$ needs $(p-2)(q-2)\ge2$. So products with a factor $S^2$, and $S^3\times S^3$, give only $t\le1$, and the foothold says nothing there. The record should state the range $p,q\ge3$, $(p,q)\ne(3,3)$.

## Claim 4, averaging

- $\mathcal W_n$ is an irreducible $O(n)$-module of real type for $n\ge4$ (at $n=4$ it splits under $SO(4)$ only), so $\int_{O(n)}g^{-1}\pi_{\mathcal D}g\,dg$ restricted to $\mathcal W_n$ commutes with $O(n)$ and is the scalar $\operatorname{tr}\pi_{\mathcal D}/\dim\mathcal W_n=\dim\mathcal D_n/\dim\mathcal W_n$. The norm is HS on $\Lambda^2$, the same as $t=\lVert A\rVert$.
- A maximum is at least an average, so $t^2\ge\frac{n(n-3)/2}{n(n-3)(n+1)(n+2)/12}=\frac6{(n+1)(n+2)}$.
- bispectral.md's $\mathbb E_F\lVert K(F)\rVert_F^2=\frac{12}{(n+1)(n+2)}\lVert M\rVert_F^2$ sums over $a\ne b$, twice the unordered sum, so the two agree.
- $6(n-4)^2\ge4(n+1)(n+2)\iff n^2-30n+44\ge0$, roots $15\pm\sqrt{181}$, i.e. $1.55$ and $28.45$. So the first even $n$ is $30$, and the inequality is strict there ($44>0$), which gives $t>T$ and hence $b=0$ through the dichotomy. [average_beats_threshold](../lean/HamiltonsCubic/Results/ProductFoothold.lean) states the strict form.

## Claim 5, the knapsack

- $L_{\hat A}$ is symmetric (total symmetry of $\langle L_XY,Z\rangle$) and preserves $\mathcal D_n$, hence $\mathcal D_n^\perp$. An orthonormal eigenbasis $v_i$ of $\mathcal D_n^\perp$ gives $B=\sum\beta_iv_i$, $y_i=\beta_i^2$, $\sum y_i=b^2$, $a=t\sum\lambda_iy_i$.
- With $b^2=1-t^2$, $\rho t(1-t)=\frac{\rho t}{1+t}b^2$, so $a\le\rho t^2(1-t)\iff\sum(\lambda_i-\frac{\rho t}{1+t})y_i\le0$.
- **O6.** The displayed "$(\mathrm{MG})\iff$" holds under $\rho>\sqrt{3/2}$, inherited from the agreement paragraph. Below $\sqrt{3/2}$ (MG) holds outright and the knapsack is only sufficient. The display should carry the hypothesis.
- The sentence listing "the double rotation per four-set" among the knapsack's constraints is correct as a general programme, but at a product diagonal part the double rotation plays no role (O1).

## Claim 6, the F67 clearance

**REFUTED as stated.** The sentence "What clears F67 is that the orbit direction is exactly the one the maximal frame's first-order condition removes from $\nu$" names a necessary step as the whole mechanism.

- The within-factor pair blocks carry $\tau_P=d\frac{p-2}{2(p-1)}$, which tends to $\frac d2$ as $p$ grows. These modes lie in $\mathcal D_n^\perp$, are orthogonal to every orbit line (the orbit of $e$ in a within-factor plane is trivial, $e$ being $O(p)\times O(q)$-invariant), and survive the first-order condition.
- **Screen.** With only the orbit lines removed, the top eigenvalue of the compression is $\max(\tau_P,\tau_Q)$: $0.45$ against $c_*=0.30$ at $S^5\times S^5$, and $0.474$ against $0.316$ at $S^4\times S^6$. Adding the within-factor kill brings it to $c_*$.
- **Consequence.** With the first-order condition alone the balanced threshold is $\frac{\tau}{d-\tau}=\frac{m-2}m$, which tends to $1$, so F67's obstruction returns in the limit and no averaging bound reaches it.
- **Correction.** *At a product diagonal part, F67 is cleared by two frame conditions acting on different characters: the first-order condition removes the orbit line from each mixed pair block, and the second-order one-plane bound, with $\delta=0$, removes the within-factor pair blocks, whose top mode $\tau_P$ tends to $\frac d2$. At a general diagonal part the second of these bounds the within-factor mass instead of removing it, and that bound is the knapsack's binding constraint.*
- "The orbit direction alone carrying $\frac12\theta$" is literally true at the product ($\tau_P<\frac d2$ strictly), and it is the near-$\frac12$ modes that matter for a bound.

## Claim 7, hypotheses

- **H1.** Every use is stated: unit critical point (L214's relations), $t>0$ (division), globally maximal frame (in fact local suffices, O2), $\hat A=e$ in the maximal frame's own coordinates, $d>0$, $n=p+q$, and a global maximiser only for $\rho\ge d$ in the dichotomy and the corollary. "(MG) above the threshold" needs only a critical point in a locally maximal frame.
- **H2.** Nothing uses $C=0$ or closedness. The one-plane, orbit and spectral facts are statements about $e$ and the frame, and L214's relations hold at any critical point. "No closedness is used" is CONFIRMED.
- **H3.** $d>0$ is load-bearing. At the negated product $\hat A=-e$ the spectra flip, the within-$2+2$ top mode becomes $(0,1,1)$ and only the double rotation removes it, so O1's shortcut fails there. The brief's hypothesis excludes that case, correctly.

## Lean

The declarations in [ProductFoothold.lean](../lean/HamiltonsCubic/Results/ProductFoothold.lean) state the scalar steps with the hypotheses above: mg_iff_coupling, coupling_iff_knapsack, value_bound, dichotomy (with $c<d$, $d\le\rho$), mg_of_threshold, balanced_threshold ($m>2$), average_beats_threshold (strict). The rows marked "none" (the coupling bound, Schur, $c_*<d$) are checked in claims 1, 4 and 3 above. I did not build the file.
