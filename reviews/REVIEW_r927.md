# Review r927, Lemma L214's frame split and the reduction it claims

**The round read the written chain link by link and re-derived every step symbolically before reading the block's own version of it.** Read: the [L214 block](../findings/second-order.md), [Lemma L24](../findings/second-order.md), [Lemma L123](../findings/second-order.md), [Lemma L57](../findings/problem.md) in its file form, [DERIVE-mx1](DERIVE-mx1.md) in full, the [2026-09-13b sweep](2026-09-13b-LIT-step8-sweep.md)'s Phase 3c where the route was derived, [routes.md](../routes.md)'s R24 row, [INDEX-results.md](../findings/INDEX-results.md)'s row 214, and [L214FrameSplit.lean](../lean/HamiltonsCubic/Results/L214FrameSplit.lean). Log: [agent_logs/gate2-l214-r927.log](../agent_logs/gate2-l214-r927.log). One seconds-long arithmetic screen of a claim recorded below, reported as a screen, on objects already in hand.

**The lemma stands and the reduction does not.** *The four steps are correct, the frame is genuinely arbitrary, and neither of [DERIVE-mx1](DERIVE-mx1.md)'s two mistakes is repeated. The **where it points** bound, which is what R24 consumes, cannot reach $\sqrt{3/2}$ at $n\ge12$ for any lower bound on the diagonal mass whatsoever, because $\Lambda_n\ge\Theta_n/2$ holds analytically and forces the bound's infimum over $t\in(0,1]$ to be $\Theta_n$, attained only at $t=1$.*

## Claims

| # | Item | Verdict | Reason |
| --- | --- | --- | --- |
| 1 | Any step using the eigenframe | CONFIRMED | every step survives an arbitrary orthonormal $F$, the only frame input being a sign-group statement that holds in any frame |
| 2 | $t_F$ silently replaced by $\max_Ft_F$ | CONFIRMED | the block never substitutes, and the route's use of the maximising frame is separately licensed because the bound is decreasing in $t$ |
| 3 | L120 applicable at $D$ | CONFIRMED | the quoted hypothesis is $\Gamma$-fixedness, which $D$ has as the orthogonal projection onto a $\Gamma$-invariant subspace, and the one-line proof that $\mathcal D_n$ is the whole fixed space is correct |
| 4 | $D\in\mathcal W_n$ | CONFIRMED | Ricci-flatness of $W$ gives the diagonal part vanishing row sums, so the coordinate-diagonal part and the projection onto $\mathcal D_n$ coincide, proved at [L57](../findings/problem.md) and uncited here |
| 5 | The two relations | CONFIRMED | both re-derived, total symmetry is [L24](../findings/second-order.md)'s already-audited step, and relation two is relation one plus the polarisation identity |
| 6 | The cancellation, step 3 | CONFIRMED | re-derived symbolically, coefficient of $a$ is $-1$ and the remainder $\theta t(1-t)$, and the two $\langle D\circ D,N\rangle$ terms are cancelled rather than dropped |
| 7 | The test vector and the ends | CONFIRMED | $X\perp W$ and $\lVert X\rVert^2=t(1-t)$ both hold, and at $t\in\{0,1\}$ the inequality reads $0\ge0$ with equality in the second form |
| 8 | L24's scope | GAP | "at every maximiser" should be "at every local maximiser with $\theta>0$", and L24's own owed $\theta=0$ branch is inherited without being named |
| 9 | The consequence and $\Theta_n$ | CONFIRMED | the algebra is exact, no factor of two is owed, and L57's file form already quantifies over every diagonal $W$ rather than only critical ones |
| 10 | Is the reduction real | REFUTED | $\Lambda_n\ge\Theta_n/2$ from the orbit tangent, and $\ge\sqrt3/2$ from the record's own padded-$\mathbb{CP}^2$ split, make the bound's infimum $\Theta_n>\sqrt{3/2}$ at $n\ge12$ |
| 11 | Already on the record | GAP | the split $W=\mathop{\mathrm{diag}}(M)+R$ and the norm bookkeeping are in [DERIVE-mx1](DERIVE-mx1.md), [bispectral.md](../findings/bispectral.md) and [target.md](../findings/target.md), uncredited, while the relations and the test vector are new |
| 12 | What would break it | ANSWERED | the falsifier of the reduction exists and is on the record already, and no object falsifying the lemma was found |

**One line.** The lemma is correct and the route built on it is dead at the dimensions the conjecture is about.

## 1. No step uses the eigenframe

**Step by step, with the frame left arbitrary throughout.**

- **The split.** $D=\pi_FW$ and $N=W-D$ are defined for any orthonormal $F$, and $t_F=\lVert D\rVert^2$, $\lVert N\rVert^2=1-t_F$ follow from orthogonality of $\mathcal D_n(F)$ and its complement. No eigenframe.
- **Step 1.** The only frame-dependent input is $\langle D\circ D,N\rangle=0$, which comes from $\Gamma_F$-equivariance of $\circ$ and $\Gamma_F$-fixedness of $D$. Both hold for the sign group of whichever frame was fixed, so the statement is frame-indifferent rather than eigenframe-specific. No eigenframe.
- **Step 2.** Pure inner-product algebra in $t$. No eigenframe.
- **Step 3.** Pure trilinear algebra plus step 1. No eigenframe.
- **Step 4.** [L24](../findings/second-order.md) is a statement about the operator $L_e$ on $W^\perp$, carrying no frame at all, and its one hypothesis on the test direction, $X\perp W$, is verified in step 2 rather than assumed. No eigenframe.
- **Where it points.** [L57](../findings/problem.md) bounds $P$ over every coordinate-diagonal Weyl tensor of any fixed frame, and $\Lambda_n$ is an $O(n)$-invariant supremum. No eigenframe.

**And this is where [DERIVE-mx1](DERIVE-mx1.md) differs, in the mechanism and not only in the conclusion.** That note applied [Lemma L121](../findings/second-order.md)'s four-index inequality to a test direction drawn from a $4$-set plane, and off the eigenframe such an $X$ satisfies $\langle X,W\rangle=\langle X,R\rangle\ne0$, so L24's hypothesis fails and a projection defect $\tfrac12c^2$ is owed. L214 draws its test direction from the split itself and verifies orthogonality exactly, so the defect is zero by construction rather than by hope. **The block's "not used: any four-index inequality" is accurate.**

## 2. $t_F$ is the frame's own value everywhere it appears

**Every occurrence checked.** $t$ enters in the split, in both relations, in $X$, in $\lVert X\rVert^2$, in both forms of the inequality, in $d=D/\sqrt t$ and $\nu=N/\sqrt{1-t}$, and in the final bound. In all of them it is $\lVert\pi_FW\rVert^2$ for the frame fixed at the top, and the block says so in bold. **No substitution of the extremal value occurs.**

**The claims at the two ends are also per-frame and correct.** "Sharp as $t\to1$" means that as the frame's own diagonal mass approaches everything, the bound degenerates to L57 evaluated at $d$, and $\Theta_n$ is attained there by the balanced sphere product. "Blows up as $t\to0$" is the $(1-t)/\sqrt t$ prefactor, correct.

**The route's step to the maximising frame is legitimate, and for a reason the block does not give.** [routes.md](../routes.md)'s R24 row evaluates the bound "in the frame maximising $t$". That is sound because the per-frame inequality holds at every frame, so it holds at the maximising one with that frame's own $t$ on both sides. What mx1 did instead was keep a bound proved for $t_F$ and insert a larger value into a right-hand side decreasing in $t$, which is a different operation. **A lower bound $\tau_n\le\max_Ft_F$ then also suffices, because the bound is decreasing in $t$ on $(0,1]$**, which section 10 proves and which the block asserts only implicitly by asking for a lower bound. That direction is fine. The fatal problem is the value the decrease bottoms out at.

## 3. L120 applies at $D$, and $\mathcal D_n$ is exactly the fixed space

**The quoted hypothesis is $\Gamma$-fixedness, and the quoted sentence says criticality is unused.** $D$ is not critical and need not be, so the title's "at every diagonal critical point" is a description of the setting L120 was found in rather than a hypothesis of the sentence being consumed.

**$D$ is $\Gamma$-fixed, and the cleanest argument is shorter than the block's.** $\Gamma\subset O(n)$ acts orthogonally on $\mathcal W_n$ and $\mathcal D_n$ is a $\Gamma$-invariant subspace, so the orthogonal projection $\pi_F$ onto it is $\Gamma$-equivariant and $D=\pi_FW$ lands in $\mathcal D_n$, which is fixed pointwise. **No property of $W$ is used.**

**And $\mathcal D_n$ is the whole fixed space, as claimed.** A sign flip $\varepsilon$ sends the pair basis vector $\varphi_{ij}$ to $\varepsilon_i\varepsilon_j\varphi_{ij}$, so the entry $(\{i,j\},\{k,l\})$ is multiplied by $\prod_{m\in\{i,j\}\triangle\{k,l\}}\varepsilon_m$. For two distinct $2$-sets the symmetric difference is nonempty, so some $\varepsilon$ returns $-1$ and the entry must vanish. **Fixed exactly means pair-diagonal**, and inside $\mathcal W_n$ that is $\mathcal D_n$ by item 4. The block's one line is right.

**The consequence the proof needs is even more robust than the route L120 takes.** $\langle D\circ D,N\rangle=0$ follows from $\Gamma$-equivariance of $\circ$ alone: $D\circ D$ is $\Gamma$-fixed, $N$ lies in the sum of the nontrivial isotypics, and distinct isotypics of an elementary abelian $2$-group are orthogonal under an invariant pairing. **That is [Lemma L123](../findings/second-order.md)'s mechanism, already through Gate 2 twice**, so the block's structural input is carried by two independent already-audited results rather than one.

## 4. $D$ is in $\mathcal W_n$, and the row sums survive

**What $\mathcal D_n$ is on the record.** [L57](../findings/problem.md) defines $\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf1=0\}$, the vertex matrices of coordinate-diagonal Weyl operators, and proves the correspondence both ways: first Bianchi is automatic on the diagonal locus and Ricci-flatness is exactly $S\mathbf1=0$. Dimension $\binom n2-n=n(n-3)/2$, matching [L120](../findings/second-order.md)'s first summand.

**The row-sum condition survives the projection, and this is the step the block leaves implicit.** Write $S_{ij}=\langle W\varphi_{ij},\varphi_{ij}\rangle$ for the pair-diagonal entries of $W$. Ricci-flatness of $W$ reads $\sum_jS_{ij}=0$ for every $i$, which is precisely $S\mathbf1=0$. **So the naive "keep the diagonal entries" operation already lands inside $\mathcal D_n$**, and since the off-diagonal remainder is orthogonal to every pair-diagonal operator, that operation is the orthogonal projection onto $\mathcal D_n$. The two readings of $\pi_F$ coincide.

**Why it matters that they do.** Had $\pi_F$ meant projection onto diagonal operators without the Weyl conditions, $D$ would sit outside $\mathcal W_n$, [L120](../findings/second-order.md)'s decomposition would not be the right one, and $P(D)$ would be a value of the cubic at a non-Weyl point. **The block is entitled to the identification and does not spend one line on it**, and the line is available at [L57](../findings/problem.md), where the bijection is recorded as "asserted throughout the record and proved nowhere until this audit". *Recommend citing it.*

## 5. The two relations, re-derived, and one of them is free

**Total symmetry first, since three of the four cancellations rest on it.** $Q$ is homogeneous of degree two, so $Q(X+Y)=Q(X)+2B(X,Y)+Q(Y)$ for a symmetric bilinear $B$, and the record's $\circ$ is exactly $B$, with $X\circ X=Q(X)$. Put $T(X,Y,Z)=\langle X\circ Y,Z\rangle$, symmetric in the first two slots by construction. Full symmetry is a genuine fact about $Q$ and not a formality: the $W^2$ part gives $\tfrac12\mathop{\mathrm{tr}}(XYZ+YXZ)$, which is invariant under every transposition once cyclicity of the trace is used, and the $\#$ part is symmetric because permuting the arguments permutes the slots of two totally antisymmetric structure-constant tensors, sign $(-1)^2$. **This is [L24](../findings/second-order.md)'s own step, attributed there to [r285](REVIEW_r285.md) Claim 1, and I reproduced the $W^2$ half independently.**

**Relation one.** Pair $W\circ W=\theta W$ with $D$. The left side expands as $T(D,D,D)+2T(D,N,D)+T(N,N,D)$, which by full symmetry is $P(D)+2T(D,D,N)+T(D,N,N)=P(D)+0+a$. The right side is $\theta\langle W,D\rangle=\theta(\langle D,D\rangle+\langle N,D\rangle)=\theta t$. Hence $\theta t=P(D)+a$.

**Relation two.** Pair with $N$: the left side is $T(D,D,N)+2T(D,N,N)+T(N,N,N)=0+2a+P(N)$, the right is $\theta\langle W,N\rangle=\theta(1-t)$.

**And relation two is relation one plus an identity already available.** Polarising the cubic gives $\theta=P(W)=P(D)+3T(D,D,N)+3a+P(N)=P(D)+3a+P(N)$, and subtracting relation one returns relation two exactly. **So the block's "two exact relations" carry one independent piece of information beyond $P(W)=\theta$.** *No defect, and the sweep file says as much. It is worth stating in the block, because a reader checking two relations is checking one relation twice.*

## 6. The cancellation, re-derived symbolically

**Write $s=1-t$, $A=T(D,D,D)=P(D)$, $B=T(D,D,N)=0$, $C=T(D,N,N)=a$, $E=T(N,N,N)=P(N)$.**

$W\circ X=(D+N)\circ(tN-sD)=(t-s)\,D\circ N-s\,D\circ D+t\,N\circ N$, and $t-s=2t-1$, matching the block exactly.

Pairing with $X=tN-sD$ term by term:

$$\langle L_WX,X\rangle=(2t-1)(tC-sB)+(-s)(tB-sA)+t(tE-sC)=\underbrace{\big[(2t-1)t-ts\big]}_{3t^2-2t}C+s^2A+t^2E-\underbrace{\big[(2t-1)s+ts\big]}_{s(3t-1)}B.$$

**The coefficient of $a$ is $3t^2-2t$, matching, and the $B$ terms are two in number and cancelled rather than dropped**: they carry the factor $s(3t-1)$, which does not vanish identically, so the vanishing is $B=0$ doing work, exactly the one scalar the block says it spends.

**Substituting $A=\theta t-C$ and $E=\theta s-2C$.** The coefficient of $C$ becomes $3t^2-2t-s^2-2t^2=t^2-2t-(1-2t+t^2)=-1$, identically in $t$, and the remainder is $s^2\theta t+t^2\theta s=\theta ts(s+t)=\theta t(1-t)$. Hence $\langle L_WX,X\rangle=\theta t(1-t)-a$. **Confirmed.**

## 7. The test vector, and both ends

$\langle X,W\rangle=\langle tN-sD,D+N\rangle=t(1-t)-s\,t=0$ using $\langle D,N\rangle=0$. $\lVert X\rVert^2=t^2(1-t)+s^2t=t(1-t)\big[t+(1-t)\big]=t(1-t)$. **Both confirmed.**

**At $t=0$ and $t=1$ the test vector is $0$ and the inequality is $0\ge0$, and nothing false is claimed.** At $t=0$ one has $D=0$, so $a=T(D,N,N)=0$ and $a\ge0$ holds with equality. At $t=1$ one has $N=0$, so again $a=0$ and $a\ge0$ holds with equality. The second form is a sharper check: at $t=1$ it reads $P(D)\le\theta$, and $D=W$ gives $P(D)=\theta$ exactly, **equality rather than violation**, which is the right behaviour for a bound derived from a test vector that degenerates. At $t=0$ it reads $0\le0$.

**The "where it points" paragraph is the one place the ends bite**, since $d$ is undefined at $t=0$ and $\nu$ at $t=1$. The block handles this by describing the limits rather than evaluating at them, correctly.

## 8. L24's scope, and the wrong quantifier

**Precisely which points the inequality is claimed at.** The relations hold at every critical point in every frame. The inequality holds at every point where $L_W\le\tfrac\theta2$ on $W^\perp$, and the block's licence for that hypothesis is [L24](../findings/second-order.md).

**L24's own statement is at a local maximiser with $\theta>0$, and $\theta>0$ is not free there.** L24's scope paragraph says $\theta>0$ carries two things, the division by $6\theta$ and the definition of $e=W/\theta$; that it is automatic at a **global** maximiser because $\max_SP\ge\sqrt{3/2}$; that at a **local** maximiser the record reaches $\theta\ge0$ and no further; and that **the $\theta=0$ middle branch is owed**, with every consumer inheriting the debt.

**So "at every maximiser" is the wrong quantifier, in two ways.** It does not say local or global, and a local maximiser is exactly where the owed branch lives. **The correct reading is "at every local maximiser with $\theta>0$, automatically at every global maximiser."** *This is a GAP of statement and not a defect of proof: the block's own hypothesis line is the honest one, "if in addition $L_W\le\tfrac\theta2$ on $W^\perp$", and only the parenthetical attribution overreaches. Recommend replacing "at every maximiser" with L24's own scope, in the block, in [results.md](../results.md) line 350 and in [INDEX-results.md](../findings/INDEX-results.md) row 214, all three of which carry the loose form.*

**Two further scope points, both clean.** $W^\perp$ is $L_e$-invariant by [L24](../findings/second-order.md)'s own argument, so $\lambda_{\max}$ of the restriction really does bound the Rayleigh quotient at $X$ rather than only the compression. And $L_W=\theta L_e$ exactly, so multiplying L24's $\tfrac12$ by $\theta$ preserves the direction of the inequality precisely because $\theta>0$, the same hypothesis. **No requirement that $X$ avoid the orbit is needed**, since L24 bounds all of $W^\perp$ and the orbit directions attain the bound.

**And the inequality is not what the route consumes.** The **where it points** bound uses relation one alone. So the L24-dependent half of L214, with all of its inherited debt, is decorative for R24, and the half the route stands on holds at every critical point. *That is a point in the lemma's favour and the block does not make it.*

## 9. The consequence, and $\Theta_n$ is the right constant

**The algebra, re-derived.** With $D=\sqrt t\,d$ and $N=\sqrt{1-t}\,\nu$ at unit $d,\nu$, relation one reads $\theta t=t^{3/2}P(d)+\sqrt t(1-t)\langle L_d\nu,\nu\rangle$. Dividing by $\sqrt t$ gives $\theta\sqrt t=tP(d)+(1-t)\langle L_d\nu,\nu\rangle$, hence both of the block's forms:

$$\langle L_d\nu,\nu\rangle=\frac{\theta\sqrt t-tP(d)}{1-t},\qquad \theta=\sqrt t\,P(d)+\frac{1-t}{\sqrt t}\langle L_d\nu,\nu\rangle.$$

**Confirmed, and the bound follows because both coefficients $\sqrt t$ and $(1-t)/\sqrt t$ are positive on $(0,1)$.**

**No factor of two is owed, and the brief's worry is answered by L57's file form rather than by a conversion.** [L57](../findings/problem.md) states $\langle Q(W),W\rangle\le\Theta_n\lVert W\rVert^3$ **for every diagonal $W$ at every $n\ge4$**, a scale-free inequality quantified over the whole diagonal locus, with the bridge from a critical point to every diagonal $W$ carried by a named step of its own proof. **So the block's $P(d)\le\Theta_n$ at every unit diagonal $d$ is L57's own statement and not an extension of it**, and the "$\mathop{\mathrm{tr}}S^2=2$ against unit Frobenius norm" question does not arise in the form the brief poses it.

**The two conventions do agree, checked independently.** For a coordinate-diagonal operator with vertex matrix $S$, $\lVert W\rVert^2=\sum_{i<j}S_{ij}^2=\tfrac12\mathop{\mathrm{tr}}S^2$, so $\mathop{\mathrm{tr}}S^2=2$ is exactly $\lVert W\rVert=1$ and $\lambda=P$ there. **The arithmetic confirms it at a point**: $\Theta_8=\sqrt{2\cdot7\cdot6}/8=1.14564392$, against the $S^4\times S^4$ value $\theta=1.145643924$ that the block's own Gate 1 screen quotes as fixing the convention. *Two independently recorded numbers agreeing to nine digits.*

**And the block's normalisation is internally consistent.** It uses $t=\lVert D\rVert^2\in[0,1]$ throughout and never imports the record's $t=\lVert K\rVert_F^2\le2$. The relation between them, $\lVert R\rVert^2=1-t_F/2$ in the ordered-pair convention, is [DERIVE-mx1](DERIVE-mx1.md)'s and matches $\lVert N\rVert^2=1-t$ here exactly.

## 10. The reduction is REFUTED, and the refutation is on the record already

**Set $f(t)=\sqrt t\,\Theta_n+\dfrac{1-t}{\sqrt t}\Lambda_n$, the block's bound.** Then

$$f'(t)=\frac1{2\sqrt t}\Big[\Theta_n-\Lambda_n\Big(1+\frac1t\Big)\Big],$$

so **$f$ is non-increasing on the whole of $(0,1]$ as soon as $\Lambda_n\ge\Theta_n/2$**, because $1+1/t\ge2$ there. Its infimum is then $f(1)=\Theta_n$, attained only in the limit $t\to1$.

**$\Lambda_n\ge\Theta_n/2$ holds analytically, from the record's own sharpness argument for L24.** Let $W_0$ be the balanced sphere product, a unit diagonal critical point with $\theta=\Theta_n$ at even $n$, and take $d=W_0$. For a generator $E_{kl}\in\mathfrak{so}(n)$ the orbit direction $\xi=\mathop{\mathrm{ad}}_{E_{kl}}W_0$ satisfies $L_{W_0}\xi=\tfrac{\Theta_n}2\xi$ by equivariance, which is exactly [L24](../findings/second-order.md)'s sharpness clause. And $\xi$ lies in $\mathcal D_n^\perp$: conjugation by $\varepsilon\in\Gamma$ sends $E_{kl}$ to $\varepsilon_k\varepsilon_lE_{kl}$, a nontrivial character, and $W_0$ is $\Gamma$-fixed, so $\xi$ sits in a nontrivial isotypic. Some $E_{kl}$ gives $\xi\ne0$, since $\mathcal W_n$ carries no $O(n)$-invariant vector and the orbit is not a point, again L24's own remark. **Hence $\Lambda_n\ge\langle L_d\hat\xi,\hat\xi\rangle=\Theta_n/2$ with no computation at all.**

**The record holds a much larger witness, in the very file that proposed the route.** The [2026-09-13b sweep](2026-09-13b-LIT-step8-sweep.md)'s Phase 3c records that at padded $W_{\mathbb{CP}^2}$'s natural frame the split is $d=W_{S^2\times S^2}$ with $t=\tfrac12$ and $\langle L_d\nu,\nu\rangle=\tfrac{\sqrt3}2$ exactly. **Three independent confirmations that this is the right pair of numbers.** [DERIVE-mx1](DERIVE-mx1.md)'s table gives $t_F=1$ at padded $\mathbb{CP}^2$ for $n=8,10,12$, which is $\lVert D\rVert^2=\tfrac12$ in this block's convention. [L57](../findings/problem.md)'s closed form gives $\theta(S^2\times S^2)^2=\tfrac{2\cdot3\cdot1\cdot1}{2\cdot4}=\tfrac34$, so $P(d)=\tfrac{\sqrt3}2$. And relation one at $t=\tfrac12$, $\theta=\sqrt{3/2}$ then forces $\langle L_d\nu,\nu\rangle=(\theta-\sqrt t\,P(d))\sqrt t/(1-t)=\tfrac{\sqrt3}2$. **Since $d$ is a unit element of $\mathcal D_n$ and $\nu$ a unit element of $\mathcal D_n^\perp$, and padding preserves both Ricci-flatness and every value of $P$ and $Q$, this gives $\Lambda_n\ge\tfrac{\sqrt3}2=0.866025$ at every $n\ge4$.**

**What the route would have needed.** For $f$ to dip below $\sqrt{3/2}$ anywhere, its minimum $2\sqrt{\Lambda_n(\Theta_n-\Lambda_n)}$ must satisfy $4\Lambda_n(\Theta_n-\Lambda_n)\le\tfrac32$, that is $\Lambda_n^2-\Theta_n\Lambda_n+\tfrac38\ge0$. At $n=12$, $\Theta_{12}^2-\tfrac32=\tfrac1{36}$ exactly, so the roots are $(\Theta_{12}\pm\tfrac16)/2$ and the admissible branch compatible with an interior minimum is

$$\Lambda_{12}\ \le\ \tfrac12\big(\Theta_{12}-\tfrac16\big)\ =\ 0.534683 .$$

**Against the witness $0.866025$ the route is short by a factor of $1.62$, and the shortfall is not a matter of sharpening.** Because $\Lambda_n\ge\Theta_n/2$ holds for structural reasons, $f$ is monotone decreasing on $(0,1]$ at every $n$, so

$$\theta\ \le\ f(t)\ >\ \Theta_n\qquad\text{for every }t\in(0,1),$$

with equality only in the excluded diagonal limit. **The bound therefore cannot certify anything stronger than L57's diagonal theorem, at any $n$, for any lower bound $\tau_n$ on $\max_Ft_F$ short of $\tau_n=1$.** At $n\ge12$, where $\Theta_n>\sqrt{3/2}$ and the conjecture actually bites, it cannot reach the target at all, and the shortfall at $n=12$ is at least $\Theta_{12}-\sqrt{3/2}=0.011288$. *Arithmetic screen of these evaluations, seconds, on the two closed forms already in hand, reported as a screen: $f$ minimised at $t=1$ with value $\Theta_n$ at $n=4,6,8,10,12,14,16,20,100$, and $f(\tfrac12)=\sqrt{3/2}$ exactly at $n=4$, where $\Theta_4=\tfrac{\sqrt3}2=\Lambda_4$ and padded $\mathbb{CP}^2$ saturates the bound.*

**Where the loss happens, stated positively.** At padded $\mathbb{CP}^2$ the identity is an equality with $P(d)=\langle L_d\nu,\nu\rangle=\tfrac{\sqrt3}2$, both slots at the same modest value. The bound replaces them by two unrelated suprema, $\Theta_n$ and $\Lambda_n$, each attained at a different pair $(d,\nu)$. **Decoupling the two slots is the lossy step**, and at $n=12$ it costs $f(\tfrac12)-\sqrt{3/2}=0.26$, more than twenty times the whole window the programme is working in.

**Consequences for the plan, and this is the part that should be acted on.** [I92](../plan.md), the lower bound on $\max_Ft_F$, decides nothing for R24 any more, because no value of it closes the route. [I93](../plan.md), the closed form for $\Lambda_n$, is answered far enough to be closed as a route input: $\Lambda_n\in[\max(\Theta_n/2,\tfrac{\sqrt3}2),\ \theta_{\max}(n)]$, and the lower end alone kills the bound. **A successor has to keep $P(d)$ and $\langle L_d\nu,\nu\rangle$ coupled**, for instance through a joint bound on the pair at fixed $t$, rather than bounding each separately. *The exact saturation at padded $\mathbb{CP}^2$ is the datum any such successor must reproduce, and it is the same equality case that [DERIVE-mx1](DERIVE-mx1.md) found saturating $\Sigma=\theta^2$ at $t_F=1$.*

## 11. What is already on the record

**Prior, and uncredited in the block.** The decomposition of a critical point in an arbitrary frame into its pair-diagonal part and the rest is [DERIVE-mx1](DERIVE-mx1.md)'s $W=\mathop{\mathrm{diag}}(M)+R$, together with the orthogonality $\lVert W\rVert^2=\lVert\mathop{\mathrm{diag}}(M)\rVert^2+\lVert R\rVert^2$ verified there to machine precision. The norm bookkeeping in the record's own diagonality coordinate is prior twice over: mx1 itself notes that [bispectral.md](../findings/bispectral.md) already carries $\sum d_\varphi^2=t/2$ and [target.md](../findings/target.md) already carries $\sum R=1-t/2$, and calls its own version "agreement, not derivation".

**New.** The two relations, the test vector $X=tN-(1-t)D$, the cancellation, and the resulting inequality. Their first appearance is the [2026-09-13b sweep](2026-09-13b-LIT-step8-sweep.md)'s Phase 3c, the same cycle, so this is the derivation's own source rather than independent prior art. **Nothing in [L120](../findings/second-order.md) to [L122](../findings/second-order.md) states a relation of this shape**, those being closed forms for $L_d$'s blocks at a diagonal argument, which is what $\Lambda_n$ would be computed from.

**One sentence to add rather than a correction to make.** *Recommend crediting the split and the norm identity to [DERIVE-mx1](DERIVE-mx1.md), and noting that the block's $t\in[0,1]$ is half the record's $t_F\le2$, so a reader moving between the two files is not left to discover the factor.*

## 12. What would break it, and what I did to look

**For the lemma.** A falsifier would be either a $\Gamma$-fixed $D$ with $\langle D\circ D,N\rangle\ne0$ for some $N$ in the complement, which would need $\circ$ to fail $\Gamma$-equivariance, or a critical point with $L_W\le\tfrac\theta2$ on $W^\perp$ and a frame violating $a\ge\tfrac\theta2t(1-t)$, which would mean the step-3 algebra is wrong. **I looked in three ways and found neither.** The equivariance is $O(n)$-equivariance of $W\mapsto W^2+W^\#$ restricted to a subgroup, and it is carried independently by [L123](../findings/second-order.md), through Gate 2 twice. The algebra I re-derived symbolically in section 6 and the `linear_combination` certificate checks by hand, coefficient by coefficient. And I evaluated the inequality at the record's hardest catalogued non-diagonal point, padded $\mathbb{CP}^2$ at $t=\tfrac12$: $a=\sqrt t(1-t)\langle L_d\nu,\nu\rangle=0.306186$ against a required $\tfrac\theta2t(1-t)=0.153093$, and $P(D)=t^{3/2}P(d)=0.306186$ against a permitted $\tfrac\theta2t(1+t)=0.459279$. **Both hold, by a factor of two and by $0.15$.**

**For the reduction.** A falsifier is a unit diagonal $d$ and unit off-diagonal $\nu$ with $\langle L_d\nu,\nu\rangle$ large enough to push $f$'s minimum above $\sqrt{3/2}$, and **I found one already written down**, section 10. I looked for it by asking what the bound must do at the record's equality case, since a sharp conjecture forces any valid bound of this shape to be saturated at padded $\mathbb{CP}^2$, and then reading the route's own source file for the value it records there. *The general form, $\Lambda_n\ge\Theta_n/2$ from the orbit tangent, arrived second and needs no witness at all.*

## Verdicts

**Lemma L214: CONFIRMED.** *The two relations hold at every critical point in every orthonormal frame, the inequality holds wherever the cap does, the frame is genuinely arbitrary, $t_F$ is never confused with $\max_Ft_F$, and neither of [DERIVE-mx1](DERIVE-mx1.md)'s two mistakes recurs. Two GAPs of statement, neither touching the proof: L24's quantifier at item 8, and the uncredited prior art plus the unstated projection identification at items 11 and 4.*

**The reduction of item 10: REFUTED.** *$\Lambda_n\ge\Theta_n/2$ makes $\sqrt t\,\Theta_n+(1-t)\Lambda_n/\sqrt t$ monotone decreasing on $(0,1]$ with infimum $\Theta_n$, so the bound can never improve on [L57](../findings/problem.md), and at $n\ge12$, where $\Theta_n>\sqrt{3/2}$, it cannot reach the open statement's constant for any lower bound on the diagonal mass. The record's own padded-$\mathbb{CP}^2$ split gives $\Lambda_n\ge\tfrac{\sqrt3}2=0.866$ against a required $\Lambda_{12}\le0.5347$. **R24 needs a new engine, and the block's "where it points" paragraph should be replaced by this ceiling.***

## The Lean file

**What type-checks is the block's algebra, faithfully and no more.** The eight declarations work over an abstract totally symmetric trilinear form `T` on a real module with a symmetric bilinear `ip`, and take as hypotheses exactly what the block's proof spends: total symmetry as two transpositions, which generate $S_3$; criticality in paired form; $\langle D,N\rangle=0$; $\lVert D\rVert^2=t$ and $\lVert N\rVert^2=1-t$; and `hperp : T D D N = 0`. **I checked the `linear_combination` certificate by hand.** With $s=1-t$ the goal minus $(-s^2)\cdot$`hr1`$-t^2\cdot$`hr2` matches coefficient by coefficient: $C$ gives $3t^2-2t+1$ on both sides, $\theta$ gives $-ts$ against $-s^2t-t^2s=-ts(s+t)$, and $A$ and $E$ match directly. **Exact, with nothing hidden in a tactic.**

**What the abstraction drops, and whether the block's proof silently uses any of it.** `ip` is never assumed positive definite, so `test_norm` proves a bilinear value rather than a norm and the cap enters as `hcap` at the specific test vector rather than as a spectral statement; `t` is tied to $\lVert D\rVert^2$ only by hypothesis; and $t\in[0,1]$ is never assumed, which is harmless because every identity is polynomial. **Against that list, the block's own proof uses positive definiteness in exactly one place, to read L24's $\lambda_{\max}$ bound as $\langle L_WX,X\rangle\le\tfrac\theta2\lVert X\rVert^2$, and that is precisely the step the file leaves as `hcap`.** So the abstraction drops nothing the typed part of the argument needs.

**What it does not reach, as its own docstring says.** That $\mathcal D_n$ is the $\Gamma$-fixed subspace, that $L_D$ preserves the isotypics, and L24's cap. **Those are the block's real debts, and items 3, 4 and 8 above are where they are discharged or flagged.** *The file's claim that typing found the block's two frame inputs to be one scalar is correct and is the cleanest thing in it.*
