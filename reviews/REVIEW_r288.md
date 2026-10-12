### Reviewer 288: the fourth-order condition at a critical point of a cubic on a sphere

Reviewer 288, adversarial. Claims under review: C1–C5 as briefed, against [scripts/runs/run_fourth_order.py](../scripts/runs/run_fourth_order.py) and [references/krasnov-tkachev-2018-idempotent-variety/notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md).

Everything numeric below comes from my own code path in [scripts/reviewers/r288/](../scripts/reviewers/r288/): my own structure constants (from the delta formula for $[\phi_{ij},\phi_{kl}]$, not matrix products), my own $\#$, my own Weyl basis (nullspace of the four-index Bianchi and Ricci functionals in weighted upper-triangular coordinates on $\mathrm{Sym}^2(\Lambda^2)$), my own $W_{\mathbb{CP}^2}$ (commutant of $J$ inside $\mathfrak{so}(4)$), and Taylor coefficients from the multinomial expansion of $T$ rather than from polynomial interpolation. The reviewed script is never imported. Agreement with [review_r30_core.py](../scripts/review_r30_core.py) on the structure constants is exact and on $Q$ is $10^{-15}$; my Weyl dimensions hit $n(n+1)(n+2)(n-3)/12$ on the nose at $n=6,8,10,12$ with the constraint matrix of full rank.

| # | Claim | Verdict |
|---|---|---|
| C1 | the $t^4$ and $t^3$ coefficients | **CONFIRMED, and stronger than stated**, proved from the definitions in six lines. Nothing is lost by taking $w\perp W$ (a radial component of $w$ cancels identically), and the $t^3,t^4$ terms of $x(t)$ that were "claimed to cancel" really do, so the family covers *every* smooth sphere curve with $\gamma'(0)=z$. Both statements need $z\in A(1/2)$, the $w$-independence of $[t^3]$ **is** the eigen-equation |
| C2 | $-3\theta/8$, and "zero information" | **CONFIRMED for $z\in A(1/2)$; the universality sentence is REFUTED as written.** The geodesic coefficient is $\tfrac{15\theta}{8}-\tfrac92\langle L_Wz,z\rangle$, which is $-3\theta/8$ **only** at $\langle L_Wz,z\rangle=\theta/2$. Witness: a generic cubic on $\mathbb R^6$ at a **strict** local maximum, where the geodesic $t^4$ coefficient is $+8.18$, and $x^3$ on $\mathbb R^2$, where it is $+15/8$. The stated reason ("$P$ is a cubic, so every term with algebra content sits at order $\le3$") is also wrong, $\tfrac32\langle z\circ z,w\rangle$ is order $4$ and is pure algebra |
| C3 | $\langle b,B^+b\rangle\le\theta/2$ | **CONFIRMED as a necessary condition**, with the derivation reproduced. Two corrections: the finiteness precondition is *not* an extra fusion rule, it **is** Krasnov–Tkachev's third-order condition after polarisation; and when it fails the honest verdict is $\sup=+\infty$, so a finite pseudo-inverse number is not the supremum of anything |
| C4 | orbit directions give equality | **CONFIRMED, by a clean derivation-property proof, and strengthened**: $T(XW,z_1,z_2)=0$ for **all** $z_1,z_2\in A(1/2)$, and $B(X^2W)=(XW)\circ(XW)$. Both hold at every critical point with $L_W\le\theta/2$, no maximality used. The consequence "content only on the excess" is a **theorem at third order** and **REFUTED at fourth order**: $\Pi(o\circ e)\ne0$ (measured $0.42$ at $S^3\times S^3$), so the quartic is not a function of the excess component alone |
| C5 | the measured table | **Dimensions CONFIRMED at all seven points**, independently, with the orbit dimensions matching the closed forms $pq$ and $\binom n2-4-\binom{n-4}2$. The $S^3\times S^3$ conclusion is CONFIRMED by direct evaluation of $P(\gamma(t))>\theta$. **The number $1.653$ is wrong: the true supremum is $1.712900399$.** And the framing is deflated, the **third**-order condition already fails at $S^3\times S^3$ ($\max|T(z,z,z)|\approx0.406$ on the excess), so the fourth-order apparatus is not what refutes that point |

---

## C1, the extraction, done by hand

Write $x(t)=a_0+a_1t+a_2t^2$ with $a_0=W$, $a_1=z$, $a_2=w/2$. Trilinearity and full symmetry of $T$ give the coefficients of $P(x(t))=\sum_{i,j,k}T(a_i,a_j,a_k)t^{i+j+k}$ directly:

$$p_0=\theta,\quad p_1=3T(W,W,z)=3\langle Q(W),z\rangle=0,\quad p_2=3\theta\langle W,w\rangle/2+3\langle L_Wz,z\rangle,$$
$$p_3=3\langle L_Wz,w\rangle+T(z,z,z),\qquad p_4=\tfrac34\langle L_Ww,w\rangle+\tfrac32\langle z\circ z,w\rangle .$$

With $w\perp W$ and $L_Wz=\tfrac\theta2z$, $|z|=1$: $p_2=\tfrac{3\theta}2$ and $p_3=\tfrac{3\theta}2\langle z,w\rangle+T(z,z,z)$. Meanwhile $|x(t)|^2=1+t^2+t^3\langle z,w\rangle+\tfrac{t^4}4|w|^2=1+s$, so

$$(1+s)^{-3/2}=1-\tfrac32t^2-\tfrac32\langle z,w\rangle t^3+\Big(\tfrac{15}8-\tfrac38|w|^2\Big)t^4+O(t^5).$$

Multiplying, $[t^3]=\theta\cdot(-\tfrac32\langle z,w\rangle)+p_3=T(z,z,z)$ and

$$[t^4]=\theta\Big(\tfrac{15}8-\tfrac38|w|^2\Big)+\tfrac{3\theta}2\cdot\Big(-\tfrac32\Big)+p_4=\tfrac34\big\langle(L_W-\tfrac\theta2)w,w\big\rangle+\tfrac32\langle z\circ z,w\rangle-\tfrac{3\theta}8 .$$

Exactly the claim. Verified numerically against an independent multinomial-plus-series evaluation at all seven points, to $10^{-13}$ absolute on values of order $10^2$.

**The two generality worries are both empty, and the claim is therefore stronger than briefed.**

- *A radial component of $w$.* Put $w=w_\perp+cW$. Then $L_WW=\theta W$ gives $\langle L_Ww,w\rangle=\langle L_Ww_\perp,w_\perp\rangle+c^2\theta$, $\langle z\circ z,W\rangle=\langle L_Wz,z\rangle=\theta/2$, and $|x|^2$ picks up $(1+c)t^2$. Collecting the $c$-terms: $\tfrac34c^2\theta-\tfrac{3\theta}8(2c+c^2)-\tfrac{3\theta}8c^2+\tfrac{3\theta}4c=0$. Identically zero. Restricting to $w\perp W$ loses nothing.
- *Higher-order terms of the curve.* Add $a_3t^3+a_4t^4$. They enter $P$ as $3\theta\langle W,a_3\rangle$ at order $3$ and $3\theta\langle z,a_3\rangle+3\theta\langle W,a_4\rangle$ at order $4$ (using $Q(W)=\theta W$ and $L_Wz=\tfrac\theta2z$), and enter $|x|^2$ as $2\langle W,a_3\rangle$ and $2\langle z,a_3\rangle+2\langle W,a_4\rangle$. The two sets cancel term by term against $\theta\cdot(-\tfrac32 s_k)$. So $[t^3]$ and $[t^4]$ are the same for **every** smooth curve on the sphere through $W$ with velocity $z$ and second derivative $w$, C1 is not a statement about one convenient parametrisation.

One thing the brief leaves implicit and should not: $A(1/2)\subseteq W^\perp$ is automatic, since $L_W$ is symmetric with $L_WW=\theta W$ and $\theta\ne\theta/2$. The intersection in the definition is decorative.

## C2, the coefficient is right, the quantifier is not

Setting $w=0$ gives $-3\theta/8$, and the cross-check in arclength agrees: $P(\cos s\,W+\sin s\,z)=\theta\cos^3s+\tfrac{3\theta}2\cos s\sin^2s+\sigma\sin^3s=\theta-\tfrac{3\theta}8s^4+O(s^5)$, the even part being fixed by $\theta$ and $\langle L_Wz,z\rangle$ alone.

**But the general geodesic coefficient is $\tfrac{15\theta}8-\tfrac92\lambda$ with $\lambda=\langle L_Wz,z\rangle$**, and only $\lambda=\theta/2$ produces $-3\theta/8$. So "automatically satisfied with strict inequality at every critical point of every cubic form on a sphere" is false as written. Two witnesses, both computed:

- [scripts/reviewers/r288/generic_cubic_witness.py](../scripts/reviewers/r288/generic_cubic_witness.py): a generic symmetric trilinear form on $\mathbb R^6$, critical point from power iteration on $Q$, $\theta=4.4726697218$, criticality residual $2.1\times10^{-15}$. The spectrum of $L_W$ on $W^\perp$ is $\{-1.19,-0.65,0.14,0.73,1.31\}$, all strictly below $\theta/2=2.236$, a **strict** local maximum with $A(1/2)=0$. The geodesic $t^4$ coefficient is $+8.18$, $+9.38$, $+7.83$ in three random directions, against $-3\theta/8=-1.68$.
- $P(x,y)=x^3$ on $\mathbb R^2$ at $W=(1,0)$, $\theta=1$: $P(\gamma)=\cos^3s=1-\tfrac32s^2+\tfrac78s^4$, i.e. $[t^4]=+15/8$ in the projective parameter, against $-3/8$.

The correct statement is: **along every direction in $A(1/2)$**, which is the only place the fourth-derivative test is ever invoked, since the test presupposes the second derivative vanishes, and at a point with $L_W\le\theta/2$ that forces $z\in\ker(\tfrac\theta2-L_W)=A(1/2)$. With that repair the consequence stands: Krasnov–Tkachev's $\partial^4f/\partial z^4$ inequality is satisfied strictly and automatically, and carries no information. It also settles the sign caveat flagged in [notes.md](../references/krasnov-tkachev-2018-idempotent-variety/notes.md), the printed $\partial^4f/\partial z^4\ge0$ cannot be the maximum convention, because $-3\theta/8<0$ would then fail at *every* extremal idempotent with $\tfrac12$ in the spectrum, including the ones the paper builds.

The stated *reason* is wrong even where the conclusion is right. "$P$ is a cubic, so every term with algebra content sits at order $\le3$" is contradicted by C1's own $\tfrac32\langle z\circ z,w\rangle$, which is order $4$ and is exactly algebra content. The real reason is narrower: **on a great circle the even part of $P$ is determined by $\theta$ and $\lambda$**, and $\lambda$ is pinned to $\theta/2$ by membership of $A(1/2)$.

## C3, right, but the finiteness clause is a restatement of the third-order condition

The second-order half is clean and holds on *all* of $W^\perp$: for any $z\perp W$, $[t^2]P(\gamma)=3\langle L_Wz,z\rangle-\tfrac32\theta|z|^2$, so local maximality gives $L_W\le\tfrac\theta2$ there, and the radial direction is correctly excluded ($L_WW=\theta W$ with $\theta>\theta/2$). $B=\tfrac\theta2-L_W$ is then positive semidefinite on $W^\perp$ with $\ker B=A(1/2)$.

Maximising $g(w)=-\tfrac34\langle Bw,w\rangle+\tfrac32\langle c,w\rangle-\tfrac{3\theta}8$, $c=P_{W^\perp}(z\circ z)$, over the unconstrained $w\in W^\perp$: if $c\not\perp\ker B$ the sup is $+\infty$; otherwise $Bw=c$ and the value is $\tfrac34\langle c,B^+c\rangle-\tfrac{3\theta}8$. So $\sup\le0$ reads $\langle b,B^+b\rangle\le\theta/2$. Confirmed.

**Correction 1, the finiteness clause is not new content.** $T$ is symmetric, so $T(z,z,z)=0$ for all $z$ in a subspace is *equivalent*, by polarisation, to $T|_{A(1/2)^3}=0$, which is exactly $z\circ z\perp A(1/2)$ for all $z\in A(1/2)$. That is Krasnov–Tkachev Proposition 6.7's own third-order conclusion. So "finiteness of the sup over $\ker B$ is exactly the fusion rule" is true and says: *the fourth-order test is only defined where the third-order test has already passed.* The one piece of genuinely new content in the whole apparatus is the quantitative bound $\langle b,B^+b\rangle\le\theta/2$ **given** that.

**Correction 2, the fusion rule is the weak half of the Peirce rule.** $z\circ z\perp A(1/2)$ says $A(1/2)\circ A(1/2)\subseteq A(1/2)^\perp$, i.e. it lands in the sum of *all* other eigenspaces of $L_W$. That is weaker than $A(1/2)A(1/2)\subseteq A(1)\oplus A(0)$, and only the weak half is available here.

## C4, confirmed, and there is a stronger theorem underneath it

Every $X\in\mathfrak g$ is a derivation: differentiating $T(e^{sX}a,e^{sX}b,e^{sX}c)=T(a,b,c)$ gives $T(Xa,b,c)+T(a,Xb,c)+T(a,b,Xc)=0$, hence $\langle X(a\circ b),c\rangle=-T(a,b,Xc)=\langle Xa\circ b+a\circ Xb,c\rangle$. Three consequences, all verified numerically to $10^{-16}$ at all seven points:

1. **$XW\in A(1/2)$ unconditionally.** Apply $X$ to $W\circ W=\theta W$: $2L_W(XW)=\theta XW$. No maximality, no second-order hypothesis.
2. **$T(XW,z_1,z_2)=0$ for every $z_1,z_2\in A(1/2)$**, strictly stronger than C4's $T(z,z,z)=0$. Proof: $T(XW,z_1,z_2)=-T(W,Xz_1,z_2)-T(W,z_1,Xz_2)=-\langle Xz_1,L_Wz_2\rangle-\tfrac\theta2\langle z_1,Xz_2\rangle=-\tfrac\theta2(\langle Xz_1,z_2\rangle+\langle z_1,Xz_2\rangle)=0$ by skewness of $X$.
3. **$B(X^2W)=(XW)\circ(XW)$.** Apply $X$ twice to $W\circ W=\theta W$: $\theta X^2W=2(XW)\circ(XW)+2L_W(X^2W)$.

Item 3 is the whole of C4's second half, and it does **not** need the orbit curve. Write $w_0=X^2W$, $c=\langle W,X^2W\rangle=-|z|^2=-1$, $w_*=P_{W^\perp}w_0$. Since $BW$ picks up only $-\tfrac\theta2W$, item 3 projects to $P_{W^\perp}(z\circ z)=Bw_*$, so $b=\Pi(z\circ z)=Bw_*\in\operatorname{ran}B\perp\ker B$ (the sup is finite for free) and

$$\langle b,B^+b\rangle=\langle Bw_*,w_*\rangle=T(z,z,X^2W)+\tfrac\theta2=\tfrac\theta2,$$

because the derivation identity at $a=b=c=XW$ gives $3T(X^2W,XW,XW)=0$. The same identity at $a=b=XW$, $c=W$ gives $T(z,z,z)=-2T(W,XW,X^2W)=-\theta\langle XW,X^2W\rangle=\theta\langle W,X^3W\rangle=0$, $X^3$ being skew. So **both halves of C4 are theorems requiring only invariance and $L_W\le\theta/2$**, the brief's "the orbit curve supplies an admissible corrector, and local maximality caps the sup at $0$" is a correct heuristic but not needed, and its appeal to local maximality is avoidable. The higher-order terms of $e^{tX}W$ that the brief worried about are irrelevant for the independent reason established in C1.

**The consequence "content ONLY on the excess" splits.**

- **Third order: a theorem.** By item 2, $T(o,o,o)=T(o,o,e)=T(o,e,e)=0$, so for $z=z_o+z_e$, $T(z,z,z)=T(z_e,z_e,z_e)$ exactly. Measured at $S^3\times S^3$: $\max|T(o,o,e)|$ and $\max|T(o,e,e)|$ are $0.0000$ over all basis pairs, against $\max|T(e,e,e)|=0.302$.
- **Fourth order: refuted.** $\Pi(o\circ e)$ need not vanish, and at $S^3\times S^3$ it does not, $\max\|\Pi(o\circ e)\|=0.423$, $\max\|\Pi(o\circ o')\|=0.732$. Along $z=\cos\varphi\,o+\sin\varphi\,e$ the quantity $\langle b,B^+b\rangle$ runs $0.5270\to0.5104\to0.5575\to0.8118$, non-monotone and equal to neither endpoint in between. So the fourth-order quantity is a genuine quartic on $A(1/2)$, not a function of the excess component; sampling pure-excess directions can under-report it. This does not damage C5, where the excess is $0$ and every direction is an orbit direction.

## C5, dimensions right, the number wrong, the framing deflated

Recomputed from my own basis, my own $L_W$ and my own orbit tangent ([r288_big.py](../scripts/reviewers/r288/r288_big.py), [r288_run.py](../scripts/reviewers/r288/r288_run.py)):

| point | $n$ | $\theta$ | criticality | $\dim A(1/2)$ | orbit | excess | $\max\operatorname{spec}(L_W\mid W^\perp)$ |
|---|---|---|---|---|---|---|---|
| $S^4\times S^4$ | 8 | 1.145643924 | $3.3\cdot10^{-16}$ | 16 | 16 | **0** | $\theta/2$ |
| $S^6\times S^6$ | 12 | 1.236033081 | $4.6\cdot10^{-16}$ | 36 | 36 | **0** | $\theta/2$ |
| $S^5\times S^7$ | 12 | 1.228239158 | $4.1\cdot10^{-16}$ | 35 | 35 | **0** | $\theta/2$ |
| padded $W_{\mathbb{CP}^2}$ | 8 | 1.224744871 | $2.5\cdot10^{-16}$ | 18 | 18 | **0** | $\theta/2$ |
| padded $W_{\mathbb{CP}^2}$ | 10 | 1.224744871 | $2.5\cdot10^{-16}$ | 26 | 26 | **0** | $\theta/2$ |
| padded $W_{\mathbb{CP}^2}$ | 12 | 1.224744871 | $2.5\cdot10^{-16}$ | 34 | 34 | **0** | $\theta/2$ |
| $S^3\times S^3$ | 6 | 1.054092553 | $3.6\cdot10^{-16}$ | 18 | 9 | **9** | $\theta/2$ |

Every dimension in C5 reproduces. The orbit numbers are independently corroborated by the closed forms: $\dim O(n)-\dim(O(p)\times O(q))=pq$ gives $16,36,35,9$, and $\binom n2-\dim\mathfrak u(2)-\binom{n-4}2$ gives $18,26,34$ for the padded $\mathbb{CP}^2$. $\theta=\sqrt{3/2}=1.224744871392$ for $W_{\mathbb{CP}^2}$ at all three $n$, from a construction of $W_{\mathbb{CP}^2}$ that never touches [b_cpm_closed_form.py](../scripts/b_cpm_closed_form.py) (it agrees with it to $8\cdot10^{-17}$). $\mathrm{Weyl}_n$ is closed under $\circ$ (the non-Weyl part of $\circ$ on random Weyl pairs is $10^{-14}$), so there is no hidden projection in $L_W$ and no ambiguity about where the corrector $w$ lives.

**The vacuity conclusion at the six excess-zero points is correct**, with excess $0$, $A(1/2)$ *is* the orbit tangent, so C4 applies to every $z$ and both conditions hold with equality. Measured: $\sup|T(z,z,z)|$ over $A(1/2)$ is $\le10^{-15}$ and $\sup\langle b,B^+b\rangle=\theta/2$ to nine digits at each of them.

**$1.653$ is not the supremum at $S^3\times S^3$.** Gradient ascent over the unit sphere of $A(1/2)$ ([s3s3_direct_refutation.py](../scripts/reviewers/r288/s3s3_direct_refutation.py)) reaches $\langle b,B^+b\rangle=1.712900399$ against $\theta/2=0.527046277$. Random sampling of pure-excess directions (what the reviewed script does, 200 draws), lands at $1.65$–$1.71$ depending on the seed; the reported figure is an under-sampled lower bound presented as a supremum.

**The conclusion "$S^3\times S^3$ is not a local maximum" is nonetheless right, and I confirm it without using C1 at all.** At the maximiser both $T(z,z,z)=-7.5\cdot10^{-16}$ and $\|P_{A(1/2)}(z\circ z)\|=1.8\cdot10^{-10}$, so the sup over $w$ is finite and attained at $w=B^+b$; feeding that pair into $P(\gamma(t))$ directly:

| $t$ | $0.5$ | $0.2$ | $0.1$ | $0.05$ | $0.02$ |
|---|---|---|---|---|---|
| $P(\gamma)-\theta$ | $+3.44\cdot10^{-2}$ | $+1.34\cdot10^{-3}$ | $+8.76\cdot10^{-5}$ | $+5.54\cdot10^{-6}$ | $+1.42\cdot10^{-7}$ |
| $(P(\gamma)-\theta)/t^4$ | $+0.550$ | $+0.836$ | $+0.876$ | $+0.886$ | $+0.889$ |

$P$ strictly exceeds $\theta$ on an explicit curve through $W$, and the ratio converges to $0.889390592=\tfrac34(1.712900399)-\tfrac38\theta$, which is C1's prediction. That is simultaneously the cleanest confirmation of C1 and a self-contained refutation of maximality.

**Three deflations of the framing.**

1. **The third-order condition already kills $S^3\times S^3$.** On the excess, $\max|T(z,z,z)|\approx0.406$ over $3000$ unit directions, and $\|P_{A(1/2)}(z\circ z)\|$ reaches $0.416$. Krasnov–Tkachev Proposition 6.7 as it stands therefore refutes the point; the fourth-order machinery is not needed for it. Worse, at those generic excess directions the sup over $w$ is $+\infty$, and any finite pseudo-inverse number reported there is not a supremum. The one place the fourth-order test does real work is the ascent maximiser, where the third-order condition happens to hold.
2. **Excess $=0$ is the Morse–Bott nondegeneracy already on file.** $\dim A(1/2)=\dim(\text{orbit})$ is precisely the statement that the Hessian kernel of $P|_{S}$ is exactly the orbit direction, the condition [b_cp2_nondegenerate.py](../scripts/b_cp2_nondegenerate.py) checks. *Any* tool that only probes the Hessian kernel is vacuous at a nondegenerate critical orbit. C5's vacuity is therefore a corollary of nondegeneracy rather than an independent finding, and its force is exhausted by that.
3. **It says nothing about a hypothetical non-graded maximiser.** The seven points are known critical orbits; the apparatus has content exactly where excess $>0$, and no tested point is of that type except $S^3\times S^3$, which is not a maximum. Concluding anything about an unknown maximiser $W_*$ from this table would be an inference from six nondegenerate points to a degenerate one, which the data does not support.

## Verified by argument vs by computation

- **By argument only** (numerics used solely as a check): C1 in full, including the two generality claims; the general geodesic coefficient $\tfrac{15\theta}8-\tfrac92\lambda$; $L_W\le\theta/2$ on $W^\perp$; the maximisation giving $\langle b,B^+b\rangle\le\theta/2$; the equivalence of the finiteness clause with the third-order condition; all three derivation identities of C4 and hence both halves of C4; and $T(z,z,z)=T(z_e,z_e,z_e)$.
- **By computation, necessarily**: the C2 counterexamples (a specific cubic and a specific critical point); every entry of the C5 table; $\max\|\Pi(o\circ e)\|=0.423$; the corrected supremum $1.712900399$; the direct $P(\gamma(t))>\theta$ refutation; and $\mathrm{Weyl}_n$'s closure under $\circ$.
- **Not settled either way**: whether the sup over $A(1/2)$ at $S^3\times S^3$ is exactly $1.712900399$ or merely at least that, the ascent is local, restarted $40$ times, and I have no argument that pins the maximum. Nothing in the verdicts depends on it, since any value above $\theta/2$ refutes maximality.


*Joint section with Reviewer 287, see [REVIEW_r287.md](REVIEW_r287.md).*
