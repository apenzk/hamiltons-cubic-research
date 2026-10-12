# REVIEW r885, the orbit-minimum obstruction: Claims A (orbit dimension of $S^2\times S^{n-2}$), B ($d^\ast(n)-(2n-4)\in\{3,4\}$), C (no (G3)-only route improves the standing bound), D (no $SO(n-1)$-invariant Weyl tensor)

**Standfirst.** The brief was cold: I worked from its definitions and givens alone, read no findings file, plan, route or other review, and derived every step here myself. Every quantity below is exact rational arithmetic, computed with [fractions.Fraction](https://docs.python.org/3/library/fractions.html) in [r885_dstar.py](../../../../../../private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/r885_dstar.py) (absolute path `/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/r885_dstar.py`, 43 s, exact throughout, no floating point in any decision), with one numerical screen of an invariant count in [r885_invariants.py](../../../../../../private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/r885_invariants.py) (8 s, reported as a screen and never as evidence for a positive claim, the positive claim being carried by the representation-theoretic count in section 6). Both runs finished in under a minute on objects constructed for the purpose, which the standing analysis-only rule permits. Log: [agent_logs/review-r885-orbitmin.log](../agent_logs/review-r885-orbitmin.log).

## Claim table

| Claim | Verdict | Reason in a clause |
|---|---|---|
| **A**, orbit dimension $2n-4$ | **CONFIRMED** | $\dim SO(n)-\dim(SO(2)\times SO(n-2))=\tfrac{4n-6}{2}-1=2n-4$, the stabiliser contains $O(2)\times O(n-2)$ because the curvature tensor of a product metric is invariant under the full block group, and (G7) forces the identity component to be exactly $SO(2)\times SO(n-2)$ or $SO(n)$ |
| **A**, the step from (G7) to "exactly" | **HYPOTHESIS-DEBT, discharged here** | (G7) rules out $O(n)$-invariant vectors, while the maximality argument produces an $SO(n)$-invariant one, and at even $n$ those differ: the gap closes by $P(rW)=P(-W)=-P(W)$ together with $\theta\ne0$, so it costs nothing at this point but must be written down |
| **A**, the value $\theta^2=\frac{(n-1)(n-3)}{(n-2)^2}=1-\frac1{(n-2)^2}<1$ | **CONFIRMED** | (G6) at $p=2$, $q=n-2$ gives $\frac{2(n-1)(n-3)}{2(n-2)^2}$, positive for all $n\ge4$, hence the tensor is nonzero, and the family exists exactly for $n\ge4$ |
| **B**, the gap lies in $\{3,4\}$ | **CONFIRMED, and extended to every $n\ge8$** | exact arithmetic gives $d^\ast(n)=2n-1$ for $8\le n\le24$ and $d^\ast(n)=2n$ for $25\le n\le1000$, and the sign of $n^4-24n^3-7n^2-12n+6$ closes $n>1000$, so the gap is $3$ then $4$ with a single switch at $n=25$ |
| **B**, the asymptotic $d^\ast(n)=2n-1+o(1)$ | **REFUTED** | $d^\ast(n)=2n$ exactly for every $n\ge25$, so $d^\ast(n)-(2n-1)=1$ for all large $n$: the real-valued threshold is $2n-1+\frac2{n-1}$ and the claim reports it in place of its ceiling |
| **B**, $2n-4<d^\ast(n)$ throughout | **CONFIRMED for all $n\ge8$** | $4(n-1)^3<(3n-1)(D-2n+3)$ is the exact content of $B(n,1,2n-4)>S(n)^2$, and $D$ grows like $n^4/12$ against $4n^3$, so the inequality holds for every $n\ge8$ and not merely to $1000$ |
| **C**, the narrow core | **CONFIRMED** | the only general lower bound is $m\ge d$, $B$ decreases in $m$, and $\min_W d\le2n-4<d^\ast(n)$, so the single-inequality route "$\theta^2\le B(n,1,m)$, $m\ge d$" applied uniformly yields at best $B(n,1,2n-4)=S(n)^2+\tfrac32+O(n^{-1})$, which is weaker than the standing bound |
| **C**, as stated ("any proof must supply positive excess") | **REFUTED AS STATED** | the target is $\sup_W\theta$, so a case split is legitimate, and at the very witness the brief exhibits $\theta^2=1-\frac1{(n-2)^2}<1<S(n)^2$ is already known exactly with no excess input: the debt is "excess **or** an independent evaluation at every critical point with $d<d^\ast(n)$", and for the known family it is already paid |
| **D**, the algebra (no nonzero $SO(n-1)$-invariant Weyl tensor) | **CONFIRMED AS ALGEBRA for all $n\ge4$** | $\dim\big(S^2(\Lambda^2\mathbb R^n)\big)^{SO(n-1)}-\dim(\Lambda^4\mathbb R^n)^{SO(n-1)}=2$ at every $n\ge4$ (case by case at $n=4,5$ where $\Lambda^2\mathbb R^{n-1}$ is reducible or accidentally isomorphic to the vector), the two invariants are $g\wedge g$ and $g\wedge(v\otimes v)$, and the Weyl part of $g\wedge h$ vanishes for every symmetric $h$ |
| **D**, the consequence $d>n-1$ | **REFUTED AS STATED, and HYPOTHESIS-DEBT for $n\ge9$** | $d\le n-1$ gives only $\dim\mathrm{Stab}\ge\dim SO(n-1)$, which does not imply $SO(n-1)$-invariance: at $n=4$ the self-dual-only critical point has $\mathrm{Stab}^\circ\supseteq SU(2)_-$ and $d\le3=n-1$ with $\theta\ne0$, at $n=8$ the competitor $\mathrm{Spin}(7)$ has $\dim=21=\dim SO(7)$ (it fixes no nonzero Weyl tensor, so $n=8$ survives), and for $n\ge9$ the argument imports an unstated classification of proper connected subgroups of dimension $\ge\dim SO(n-1)$ |

**One line the cycle can act on.** The obstruction is real for the route it names, and the arithmetic is better than claimed (gap exactly $3$ for $8\le n\le24$, exactly $4$ for every $n\ge25$, proved for all $n$), but Claim C's "must supply positive excess" is wrong: the debt is discharged at $S^2\times S^{n-2}$ already by (G6), and what actually blocks the improvement is the missing classification of critical points with $d<d^\ast(n)$, so the plan item should be rewritten as "classify, or bound the excess of, the critical points of orbit dimension below $2n$".

## 0. Conventions, fixed once

Quoted from the brief, unaltered.

- $n\ge4$ an integer. $\mathcal W_n$ is the space of Weyl tensors in dimension $n$: algebraic curvature tensors that are Ricci-flat and satisfy the first Bianchi identity. $D:=\dim\mathcal W_n$.
- The norm is $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$.
- $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$. A **critical point** is $W$ with $\lVert W\rVert=1$ and $Q(W)=\theta W$; then $\theta=P(W)$.
- $O(n)$ acts orthogonally on $\mathcal W_n$. For a critical point $W$, $d:=\dim(O(n)\cdot W)$ is its orbit dimension.
- $L_x$ is the multiplication operator of the commutative nonassociative algebra on $\mathcal W_n$ whose cubic form is $P$; for $\theta\ne0$, $e:=W/\theta$ is an idempotent. $m:=\dim E_{1/2}(L_e)$.
- (G1) $D=\dfrac{n(n+1)(n+2)(n-3)}{12}$, (G2) $\kappa(n)=\dfrac{(2n-1)(n-1)}{4}$ with $\operatorname{tr}L_e=0$ and $\operatorname{tr}(L_e^2)=\kappa(n)/\theta^2$, (G3) $T_W(O(n)\cdot W)\subseteq E_{1/2}(L_e)$ hence $m\ge d$, (G4) $\theta^2\le B(n,p,m)=\dfrac{\kappa(n)}{p+\frac m4+\frac{(2p+m)^2}{4k}}$ with $k=D-p-m$, (G5) $\theta\le S(n)=\dfrac{n-1}{\sqrt{n+1}}$, (G6) $\theta(S^p\times S^q)^2=\dfrac{2(n-1)(p-1)(q-1)}{(n-2)pq}$, (G7) $SO(2)\times SO(n-2)$ is maximal connected in $SO(n)$ and $\mathcal W_n$ carries no nonzero $O(n)$-invariant vector.

Throughout I write $\Delta(n,d):=1+\frac d4+\frac{(d+2)^2}{4(D-1-d)}$ for the denominator of $B(n,1,d)$ and $T(n):=\kappa(n)/S(n)^2$, so that $B(n,1,d)\le S(n)^2\iff\Delta(n,d)\ge T(n)$.

## Hypothesis inventory

| Hypothesis | Source | Object it is applied to | Status against that object | Used by the argument? |
|---|---|---|---|---|
| $n\ge4$ integer | brief | all four claims | holds, and $n\ge4$ is exactly the range where $\mathcal W_n\ne0$ ($D=10$ at $n=4$, $D=0$ at $n=3$) | yes |
| $\lVert W\rVert=1$ and $Q(W)=\theta W$ | definition of critical point | $W(S^2\times S^{n-2})$ | holds by (G6), which asserts these are critical points | yes, A and C |
| $\theta\ne0$, needed for $e=W/\theta$, for $L_e$, for $m$, and for (G2) | (G2) and the definition of $e$ | $W(S^2\times S^{n-2})$ | holds: $\theta^2=1-\frac1{(n-2)^2}\ge\frac34>0$ for $n\ge4$ | yes, and it also closes the (G7) gap in section 1 |
| $p=\dim E_1(L_e)=1$ | brief instructs "take $p=1$" | every critical point in the comparison | **unverified at any point**, but conservative in the direction C needs: the denominator of $B$ increases in $p$, so $B$ decreases in $p$ and $p=1$ is the weakest case, while $p\ge1$ always because $L_ee=e$ | yes, and C is robust to it |
| $k=D-p-m>0$ | (G4) | $m$ near $d^\ast(n)\approx2n$ | holds with room: $D\sim n^4/12$ against $m\sim2n$ | yes |
| $L_e$ self-adjoint, so the $k$ remaining eigenvalues are real and Cauchy–Schwarz applies | implicit in "trace-form" | (G4) itself | taken as given, not audited here | imported |
| $B$ strictly decreasing in $m$ | (G4) | the comparison $B\le S^2$ | verified: both $\frac m4$ and $\frac{(2+m)^2}{4(D-1-m)}$ increase in $m$, so $\Delta$ increases and $d^\ast$ is a genuine threshold | yes, essential to "least $d$" being well defined |
| $T_W(\text{orbit})\subseteq E_{1/2}(L_e)$, and this is the only general lower bound on $m$ | (G3) | every critical point | taken as given | yes, C is a statement about exactly this |
| $p,q\ge2$ in (G6) | (G6) | $p=2$, $q=n-2$ | needs $n-2\ge2$, so the family exists for $n\ge4$ | yes, A |
| $SO(2)\times SO(n-2)$ maximal connected in $SO(n)$ | (G7) | $\mathrm{Stab}^\circ(W)$ | taken as given, true for $n\ge5$ in the standard classification, and at $n=4$ the group $SO(2)\times SO(2)$ is a maximal torus, still maximal connected among proper connected subgroups only in the weak sense, so A at $n=4$ rests on (G7) being asserted for $n\ge4$ | yes, A |
| no nonzero $O(n)$-invariant vector in $\mathcal W_n$ | (G7) | the alternative $\mathrm{Stab}^\circ=SO(n)$ | insufficient as literally stated at even $n$, where an $SO(n)$-invariant vector on which a reflection acts by $-1$ is not $O(n)$-invariant, and the patch is $P$-equivariance plus $\theta\ne0$ | yes, A, with the patch supplied in section 1 |
| orbit dimension $=\dim G-\dim\mathrm{Stab}^\circ$ | standard | $O(n)\cdot W$ | holds, the stabiliser is closed and $\dim(O(n)\cdot W)=\dim(SO(n)\cdot W)$ | yes, A |
| $n-1\ge2$ for the invariant $2$-tensor count | section 6 | $SO(n-1)$ acting on $\mathbb R^n$ | holds for $n\ge3$ | yes, D |
| $\Lambda^2\mathbb R^{n-1}$ irreducible and inequivalent to $\mathbb R^{n-1}$ | needed by the naive invariant count | $n-1=3$ (where $\Lambda^2\cong$ vector) and $n-1=4$ (where $\Lambda^2$ splits) | **fails** at $n=4$ and $n=5$, and section 6 handles those two cases separately, both giving the same answer $2$ | yes, D |
| every proper connected $H\subseteq SO(n)$ with $\dim H\ge\dim SO(n-1)$ is conjugate to $SO(n-1)$ | **unstated, required by D's consequence** | $\mathrm{Stab}^\circ$ when $d\le n-1$ | **false at $n=4$** ($U(2)$, $\dim4>3$) and **false at $n=8$** ($\mathrm{Spin}(7)$, $\dim21=21$), true at $n=5,6,7$ by inspection, and for $n\ge9$ an import | required by D, not supplied by the brief |
| the smaller factor of the sphere product is $S^2$ | the near-miss of section 8 | the family $S^p\times S^{n-p}$ | the near-miss is specific to $p=2$: $p=3$ gives $d=3n-9\ge d^\ast(n)$ for every $n\ge8$ | relevant to 8 and 9 |

## 1. Claim A's orbit dimension

$\dim SO(n)=\frac{n(n-1)}2$ and $\dim\big(SO(2)\times SO(n-2)\big)=1+\frac{(n-2)(n-3)}2$. The difference is

$$\frac{n^2-n-(n^2-5n+6)}{2}-1=\frac{4n-6}{2}-1=(2n-3)-1=2n-4 .$$

So the number is right, and it equals $pq$ at $p=2$, consistent with the general identity $\dim SO(n)-\dim SO(p)-\dim SO(q)=pq$ for $p+q=n$.

**Is the stabiliser exactly $SO(2)\times SO(n-2)$ up to components?** Two directions, and they need different arguments.

*Lower bound on the stabiliser.* At a point $x$ of $S^2\times S^{n-2}$ the tangent space splits orthogonally as $\mathbb R^2\oplus\mathbb R^{n-2}$ and the Riemann tensor is the direct sum of the two constant-curvature tensors of the factors. The tensor built from a metric on a subspace is invariant under the **full** orthogonal group of that subspace, so $\mathrm{Stab}(R)\supseteq O(2)\times O(n-2)$, which is larger than the isotropy group of the manifold at $x$ and is the right group here because the claim concerns the algebraic stabiliser in $O(n)=O(T_xM)$. The Weyl part is the $O(n)$-equivariant projection of $R$, hence $\mathrm{Stab}(W)\supseteq\mathrm{Stab}(R)\supseteq O(2)\times O(n-2)$, so $\mathrm{Stab}^\circ(W)\supseteq SO(2)\times SO(n-2)$ and $d\le2n-4$.

*Upper bound on the stabiliser.* $\mathrm{Stab}^\circ(W)$ is a connected subgroup of $SO(n)$ containing $SO(2)\times SO(n-2)$, so by the maximality half of (G7) it is either $SO(2)\times SO(n-2)$ or $SO(n)$. Hence $d=2n-4$ **or** $d=0$.

*What (G7) does and does not give.* The second half of (G7) is about $O(n)$-invariant vectors, while the alternative to be killed produces an $SO(n)$-invariant vector. At odd $n$ these coincide, because $-I\in O(n)\setminus SO(n)$ acts trivially on a $4$-tensor, so $O(n)=SO(n)\cdot\langle -I\rangle$ acts through $SO(n)$. At even $n$ they differ, and (G7) as literally stated leaves a loophole: let $V\subseteq\mathcal W_n$ be the $SO(n)$-fixed subspace and $r$ a reflection, then $V$ is $r$-stable, $V^{+}$ is the space of $O(n)$-invariants which (G7) says is zero, so $r$ acts as $-1$ on $V$. **The loophole closes on $P$**: for $W\in V$, $P(W)=P(rW)=P(-W)=-P(W)$, so $P(W)=0$, so $\theta=0$. Since the point under audit has $\theta^2=1-\frac1{(n-2)^2}>0$, the alternative $\mathrm{Stab}^\circ=SO(n)$ is excluded and

$$d\big(W(S^2\times S^{n-2})\big)=2n-4\qquad\text{for every }n\ge4 .$$

**Finding (minor, repairable, recorded).** The deduction of "exactly" needs one extra line beyond (G7) at even $n$, namely $P$-equivariance plus $\theta\ne0$. Anything on the record that cites (G7) alone for "$\mathrm{Stab}^\circ$ is not $SO(n)$" should carry that line.

**Direction of the error bar.** The brief asks which way a wrong stabiliser cuts. A larger stabiliser would shrink the orbit and **strengthen** Claim C, a smaller one would enlarge it and weaken C. Claim C therefore needs only the inequality $d\le2n-4$, which rests on the easy direction (the product tensor is $O(2)\times O(n-2)$-invariant). The "exactly", which is the direction that uses (G7) and the $\theta\ne0$ patch, is a nicety Claim C can survive without.

## 2. Claim A's value, and nonvanishing

(G6) at $p=2$, $q=n-2$:

$$\theta^2=\frac{2(n-1)(2-1)(n-2-1)}{(n-2)\cdot2\cdot(n-2)}=\frac{2(n-1)(n-3)}{2(n-2)^2}=\frac{(n-1)(n-3)}{(n-2)^2}=1-\frac{1}{(n-2)^2},$$

using $(n-1)(n-3)=n^2-4n+3=(n-2)^2-1$. So the value in Claim A is right, the bound $\theta^2<1$ is right, and the deficit from $1$ is exactly $(n-2)^{-2}$, which is sharper than "$<1$" and worth recording. Exact values: $\theta^2=\frac34$ at $n=4$, $\frac{35}{36}$ at $n=8$, $\frac{99}{100}$ at $n=12$, $\frac{323}{324}$ at $n=20$, $\frac{2303}{2304}$ at $n=50$.

**Nonzero.** $\theta^2>0$ for every $n\ge4$, and $\theta=P(W)$ with $\lVert W\rVert=1$, so $W\ne0$: a zero Weyl tensor would give $P=0$. Independently, the product of two spheres of positive curvature with both factors of dimension $\ge2$ is not conformally flat, which is the geometric statement matching $\theta\ne0$. **Existence of the family**: (G6) requires $p,q\ge2$, so $p=2$ needs $n\ge4$, which is the whole admissible range. The family therefore exists at every $n$ under discussion, including odd $n$, with no parity condition anywhere.

**One consequence worth flagging for item 5.** $\theta^2<1\le S(n)^2$ for every $n\ge3$ (since $S(n)^2\ge1\iff(n-1)^2\ge n+1\iff n\ge3$), and the ratio $S(n)^2/\theta^2\sim n$ diverges. The witness is not a near-extremal point for the standing bound. It is very far below it.

## 3. Claim B as arithmetic

Two exact reductions first, both identities in $\mathbb Q(n)$.

**(3a) The target.** $T(n)=\frac{\kappa(n)}{S(n)^2}=\frac{(2n-1)(n-1)}{4}\cdot\frac{n+1}{(n-1)^2}=\frac{(2n-1)(n+1)}{4(n-1)}$, and since $2n^2+n-1=(n-1)(2n+3)+2$,

$$4T(n)=2n+3+\frac{2}{n-1},\qquad\text{hence}\qquad 4\big(T(n)-1\big)-(2n-4)=3+\frac{2}{n-1}.$$

That is: dropping the $\frac{(d+2)^2}{4k}$ term, the real-valued threshold is $d_{\mathrm{real}}=4(T-1)=2n-1+\frac2{n-1}$, exceeding $2n-4$ by exactly $3+\frac2{n-1}$. Verified as an identity at $n=4,\dots,60$ in exact arithmetic.

**(3b) The $k$-term decides between $2n-1$ and $2n$.** $\Delta(n,2n-1)=\frac{2n+3}{4}+\frac{(2n+1)^2}{4(D-2n)}$ and $T(n)=\frac{2n+3}{4}+\frac1{2(n-1)}$, so

$$d^\ast(n)\le2n-1\iff\frac{(2n+1)^2}{4(D-2n)}\ge\frac{1}{2(n-1)}\iff(n-1)(2n+1)^2\ge2\big(D-2n\big)\iff n^4-24n^3-7n^2-12n+6\le0,$$

the last step by $2D=\frac{n^4-7n^2-6n}{6}$ and $(n-1)(2n+1)^2=4n^3-3n-1$. Meanwhile $\Delta(n,2n)\ge1+\frac{2n}{4}=\frac{2n+3}{4}+\frac14>T(n)$ whenever $\frac14>\frac1{2(n-1)}$, that is for every $n\ge4$. So $d^\ast(n)\in\{2n-1,2n\}$ as soon as no smaller $d$ qualifies, and the choice is the sign of a quartic. The quartic is $-4314$ at $n=24$ and $+10956$ at $n=25$, and for $n\ge25$

$$n^4-24n^3-7n^2-12n+6=n^3(n-24)-7n^2-12n+6\ge n^3-7n^2-12n+6=n^2(n-7)-12n+6\ge18n^2-12n+6>0,$$

so $d^\ast(n)=2n$ for **every** $n\ge25$, with no upper cutoff. This agrees with the exact test at every $n$ in $[8,1000]$.

**(3c) The four requested points, exact.**

| $n$ | $D$ | $\kappa(n)$ | $S(n)^2$ | $T(n)$ | $\Delta(n,d^\ast-1)<T$ | $\Delta(n,d^\ast)\ge T$ | $d^\ast$ | $2n-4$ | gap |
|---|---|---|---|---|---|---|---|---|---|
| $8$ | $300$ | $105/4$ | $49/9$ | $135/28$ | $\Delta(14)=2693/570$ | $\Delta(15)=5685/1136$ | $15$ | $12$ | $3$ |
| $12$ | $1638$ | $253/4$ | $121/13$ | $299/44$ | $\Delta(22)=21283/3230$ | $\Delta(23)=44203/6456$ | $23$ | $20$ | $3$ |
| $20$ | $13090$ | $741/4$ | $361/21$ | $819/76$ | $\Delta(38)=274871/26102$ | $\Delta(39)=562831/52200$ | $39$ | $36$ | $3$ |
| $50$ | $519350$ | $4851/4$ | $2401/51$ | $5049/196$ | $\Delta(99)=53492951/2077000$ | $\Delta(100)=4501025/173083$ | $100$ | $96$ | $4$ |

The $n=50$ row is the instructive one: $\Delta(50,99)=25.7549\ldots$ against $T(50)=25.7602\ldots$, a miss by $\frac{5049}{196}-\frac{53492951}{2077000}=0.00529\ldots$, which is the $\frac1{2(n-1)}$ of (3a) beating the $\frac{(2n+1)^2}{4(D-2n)}$ of (3b) once $D$ has grown past $n^4$-scale. That is the whole content of the $3\to4$ switch.

**(3d) The census over the claimed range, exact.** $d^\ast(n)=2n-1$ for every $n$ with $8\le n\le24$ and $d^\ast(n)=2n$ for every $n$ with $25\le n\le1000$, so the gap is $3$ on $17$ values and $4$ on $976$ values, with exactly one change point, at $n=25$. Claim B's set $\{3,4\}$ is therefore correct on the stated range, and by (3b) it is correct on **every** $n\ge8$: gap $3$ for $8\le n\le24$, gap $4$ for $n\ge25$. Below the claimed range the pattern breaks, which is why the range starts at $8$: the gap is $0$ at $n=4$, $1$ at $n=5$, $2$ at $n=6$, $3$ at $n=7$, because at small $D$ the $\frac{(d+2)^2}{4k}$ term dominates and pulls $d^\ast$ far below $2n-1$.

**(3e) $2n-4<d^\ast(n)$, closed for all $n\ge8$ rather than checked to $1000$.** This is the inequality $\Delta(n,2n-4)<T(n)$, that is $\frac{(n-1)^2}{D-2n+3}<\frac34+\frac1{2(n-1)}=\frac{3n-1}{4(n-1)}$, that is

$$4(n-1)^3<(3n-1)\big(D-2n+3\big).$$

At $n=8$ this reads $1372<6601$. The left side is cubic and the right side is quintic in $n$ (since $D\sim n^4/12$), and the exact inequality holds at every $n\in[8,1000]$. For $n\ge25$ it is implied outright by (3b), which gives $d^\ast(n)=2n>2n-4$. So the claim needs no appeal to the finite range.

**Finding (substantive, one clause of Claim B refuted).** "Asymptotically $d^\ast(n)=2n-1+o(1)$" is false. $d^\ast$ is an integer and equals $2n$ for every $n\ge25$, so $d^\ast(n)-(2n-1)=1$ for all large $n$ and the correct asymptotic statement is $d^\ast(n)=2n$ for $n\ge25$ exactly. The quantity that is $2n-1+o(1)$ is the **real-valued** threshold $4(T(n)-1)=2n-1+\frac2{n-1}$ of (3a), whose ceiling is $2n$ because $\frac2{n-1}>0$ always. The claim reports the pre-rounding quantity as if it were $d^\ast$. The direction of the error is harmless to Claim C (the true $d^\ast$ is larger, so the gap to $2n-4$ is wider), but the statement as written is wrong and would mislead anyone trying to reproduce the $\{3,4\}$ dichotomy.

## 4. Claim C's logic, which is the item that matters

Distinguish the three statements the brief names.

**(i) $\min_W d\le2n-4$.** Established, by section 1, for every $n\ge4$. This is what A actually delivers.

**(ii) every critical point has $d\le2n-4$.** False, and not needed. $S^p\times S^{n-p}$ has orbit dimension $\dim SO(n)-\dim SO(p)-\dim SO(n-p)=p(n-p)$, so $S^3\times S^{n-3}$ has $d=3n-9>2n-4$ for every $n>5$. Nothing in the argument requires (ii), and reading Claim C as needing it would be a misreading.

**(iii) no lower bound on $m$ from (G3) alone can discharge the debt.** Here the claim is right about one route and wrong about "any proof".

*What is right.* (G3) supplies $m\ge d$ and nothing else, $B$ is decreasing in $m$, so the strongest thing the composite "$\theta^2\le B(n,1,m)$ and $m\ge d$" can say **uniformly over critical points** is
$$\theta^2\ \le\ \max_{W\ \text{critical}}B\big(n,1,d(W)\big)\ \ge\ B(n,1,2n-4)\ =\ S(n)^2+\frac32+O(n^{-1})\ >\ S(n)^2 .$$
The exact excess $B(n,1,2n-4)-S(n)^2$ is $\frac{581}{684}=0.8494$ at $n=8$, $1.1041$ at $n=12$, $1.2834$ at $n=20$, $1.4226$ at $n=50$, $1.4965$ at $n=1000$, increasing to the limit $\frac32$: writing $\Delta(n,2n-4)=\frac n2+\frac{(n-1)^2}{D-2n+3}$ and dropping the second term, $B\to\frac{(2n-1)(n-1)}{2n}=n-\frac32+\frac1{2n}$ against $S(n)^2=n-3+\frac4{n+1}$. So the route loses by $\frac32$ on $\theta^2$, permanently. **This part of Claim C is CONFIRMED**, and it is not a small margin: it is $\frac32$ in the limit and never less than $0.84$ on $n\ge8$.

*What overreaches.* The object to be improved is $\sup_W\theta$ over critical points, a single number per $n$. A proof of $\sup_W\theta<S(n)$ is entitled to split the critical set into cases and use a different instrument on each. Claim C's "any proof that it improves must supply positive excess at the small-orbit critical points" forbids that, and the forbidden alternative is available at precisely the point the brief exhibits: by (G6), $\theta^2=1-\frac1{(n-2)^2}<1<S(n)^2$ at $W(S^2\times S^{n-2})$, with no reference to $m$, to $L_e$ or to any excess. The debt at that point is already paid, in closed form, at every $n\ge4$.

The honest form of the conclusion is therefore:

> Using (G4) with only (G3) as input, the trace-form bound improves on the standing bound at a critical point $W$ if and only if $m(W)\ge d^\ast(n)$, and since $\min_Wd\le2n-4=d^\ast(n)-3$ or $d^\ast(n)-4$, the inclusion $m\ge d$ alone never delivers this at the small-orbit points. Any proof of a uniform improvement must therefore supply, **for every critical point with $d<d^\ast(n)$, either positive excess $m-d\ge d^\ast(n)-d$ or an independent bound $\theta<S(n)$**. For the two-factor sphere products the second alternative is already discharged by (G6).

**Finding (substantive, Claim C refuted as stated).** The "must supply positive excess" is a false dichotomy, and the counterexample to it is the claim's own witness. The salvageable core is the sentence above. What actually remains unpaid is not excess at $S^2\times S^{n-2}$ but the **classification**: are there critical points with $d<d^\ast(n)$ other than $S^2\times S^{n-2}$, and if so what is $\theta$ there? Note how much of the known family is already discharged: among two-factor sphere products, $p(n-p)\ge3n-9\ge d^\ast(n)$ for every $n\ge8$ once $p\ge3$ (at $n=8$, $3n-9=15=d^\ast(8)$ exactly, and for $n\ge9$, $3n-9>2n\ge d^\ast(n)$), so the **only** member of that family below the threshold is $p=2$, and its $\theta$ is known. The debt is carried entirely by critical points not yet classified.

## 5. Is Claim C vacuous or circular?

**Not vacuous, and not circular, but conditional on ignorance in a way the statement hides.**

*The excess at the witness could be large, and nothing here bounds it above by anything small.* (G2) gives $\operatorname{tr}(L_e^2)=\kappa(n)/\theta^2$, which at this point is $\frac{(2n-1)(n-2)^2}{4(n-3)}$ exactly: $27$ at $n=8$, $\frac{575}9$ at $n=12$, $\frac{3159}{17}$ at $n=20$, $\frac{57024}{47}$ at $n=50$. Feeding that into (G4) read as a constraint on $m$ rather than on $\theta$, the inequality $1+\frac m4\le\kappa/\theta^2$ permits $m$ up to $4(\kappa/\theta^2-1)$, namely $104$ at $n=8$, $251$ at $n=12$, $739$ at $n=20$, $4849$ at $n=50$, all of order $2n^2$ against $d=2n-4$. So the trace identity is consistent with an excess of order $n^2$ at this point, and if the excess there were even $3$ or $4$ the point would stop being an obstruction at all. Claim C is thus a statement about what the (G3) inclusion **proves**, never about what is **true** at $W(S^2\times S^{n-2})$.

*What would have to be known.* Exactly one number per $n$: $m=\dim E_{1/2}(L_e)$ at $e=W(S^2\times S^{n-2})/\theta$. If $m\ge d^\ast(n)$, which is $3$ or $4$ above the orbit dimension, the witness is discharged by the trace-form bound itself and Claim C's obstruction evaporates at that point. Computing $m$ there is a finite linear-algebra problem in the $O(2)\times O(n-2)$-decomposition of $\mathcal W_n$, and it is the single most informative thing the cycle could do next.

*Does C survive not knowing it?* The narrow core survives: as an assertion about the inference chain "(G3) then (G4)", it is a theorem, and ignorance of $m$ is what makes it worth stating. The strong form does not survive, for the reason in section 4. Claim C reads as a no-go theorem and is actually a description of a missing input.

*Circularity.* I see none in the comparison itself. One caveat the brief does not let me resolve: the provenance of $S(n)$ is not given. If $S(n)$ were itself a consequence of (G4) at some assumed $m$, then "does the trace-form bound improve on the standing bound" would be a comparison of two hypotheses about $m$ within one system, and the answer would be arithmetic rather than geometry. Evidence against that reading, from (3a): the $m$ that makes $B(n,1,m)=S(n)^2$ is $2n-1+\frac2{n-1}$, not an integer at any $n\ge4$, so $S(n)$ is not $B(n,1,m)$ for any integer $m$. That is consistent with $S(n)$ having an independent origin, and I record it as consistency and not as proof.

## 6. Claim D's reasoning

**(6a) The invariant symmetric $2$-tensors.** Write $\mathbb R^n=\mathbb R^{n-1}\oplus\mathbb Rv$. Then $S^2(\mathbb R^n)=S^2(\mathbb R^{n-1})\oplus(\mathbb R^{n-1}\otimes\mathbb Rv)\oplus\mathbb Rv^2$, with $SO(n-1)$-invariants $1+0+1=2$ for $n\ge3$: the middle summand is the vector representation, which has no invariant for $n-1\ge2$, and $S^2$ of the vector representation has the single invariant $g_{\mathbb R^{n-1}}$ (true also at $n-1=2$, where $S^2(\mathbb R^2)=\mathbb R\oplus\mathbb R^2_{(2)}$). The span is $\{g,\ v\otimes v\}$. **Confirmed, for $n\ge3$.**

**(6b) The step the brief flags, done as a direct count.** The assertion is that every $SO(n-1)$-invariant algebraic curvature tensor is $a\,g\wedge g+b\,g\wedge(v\otimes v)$. Counting invariants in $S^2(\Lambda^2\mathbb R^n)$ with $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^{n-1}\oplus(\mathbb R^{n-1}\wedge v)$, so that $S^2(\Lambda^2\mathbb R^n)=S^2(\Lambda^2\mathbb R^{n-1})\oplus\big(\Lambda^2\mathbb R^{n-1}\otimes\mathbb R^{n-1}\big)\oplus S^2(\mathbb R^{n-1})$:

| $n$ | $S^2(\Lambda^2\mathbb R^{n-1})$ | $\Lambda^2\mathbb R^{n-1}\otimes\mathbb R^{n-1}$ | $S^2(\mathbb R^{n-1})$ | total in $S^2(\Lambda^2\mathbb R^n)$ | $(\Lambda^4\mathbb R^n)^{SO(n-1)}$ | invariant curvature tensors |
|---|---|---|---|---|---|---|
| $4$ | $1$ ($\Lambda^2\mathbb R^3\cong\mathbb R^3$) | $1$ (same accident) | $1$ | $3$ | $1$ ($\Lambda^3\mathbb R^3\wedge v$) | $2$ |
| $5$ | $2$ ($\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$) | $0$ | $1$ | $3$ | $1$ (volume of $\mathbb R^4$) | $2$ |
| $\ge6$ | $1$ (Killing form on the irreducible adjoint) | $0$ | $1$ | $2$ | $0$ | $2$ |

using $S^2(\Lambda^2V)=\ker(\text{first Bianchi})\oplus\Lambda^4V$, so that invariant curvature tensors $=$ total invariants $-$ invariants in $\Lambda^4$. The count is **$2$ at every $n\ge4$**, matching $\dim\mathrm{span}\{g\wedge g,\ g\wedge(v\otimes v)\}=2$ (independent for $n\ge3$, since $v\otimes v$ is not a multiple of $g$). Both spanning tensors are genuinely $SO(n-1)$-invariant, so the span is the whole invariant space and the step is **valid, for every $n\ge4$**, including the two dimensions where the naive count would have failed. Note that had the count been done only in the generic case, $n=4$ and $n=5$ would have been missed, and at both the extra invariant in $S^2(\Lambda^2)$ is cancelled by an extra invariant in $\Lambda^4$: the Bianchi identity is doing real work there.

**Screen.** Building the linear conditions (pair antisymmetry, pair exchange, first Bianchi, Ricci-flatness, annihilation by every generator of $\mathfrak{so}(n-1)$) directly on $(\mathbb R^n)^{\otimes4}$ and taking kernel dimensions returns invariant curvature tensors of dimension $2$ and invariant Weyl tensors of dimension $0$ at $n=4,5,6,7$. Reported as a screen of the count above, which is what carries the claim.

**(6c) The Weyl part of $g\wedge h$.** Within the curvature tensors, the map $h\mapsto g\wedge h$ from $S^2\mathbb R^n$ is injective for $n\ge3$ and its image is exactly the sum of the scalar and traceless-Ricci summands, which is the orthogonal complement of $\mathcal W_n$ in the space of curvature tensors. Hence the Weyl part of $g\wedge h$ vanishes for every symmetric $h$, and with (6b), **no nonzero Weyl tensor is $SO(n-1)$-invariant, for every $n\ge4$.** Dimension check at $n=4$: $S^2(\Lambda^2\mathbb R^4)=21=10+9+1+1$ with $\Lambda^4=1$, and the curvature space is $20=10+9+1$.

**(6d) The consequence $d>n-1$, which does not follow.** $d\le n-1$ gives only $\dim\mathrm{Stab}^\circ\ge\frac{n(n-1)}2-(n-1)=\frac{(n-1)(n-2)}2=\dim SO(n-1)$. To conclude $SO(n-1)$-invariance one needs: every proper connected subgroup of $SO(n)$ of dimension $\ge\dim SO(n-1)$ is conjugate to $SO(n-1)$. That is an unstated import, and it is **false at two dimensions**.

*$n=4$, a genuine counterexample to the consequence.* $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ and $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$, $5+5=10=D$. Both summands are ideals of the algebra: the cross term would be an equivariant map $S^2_0\Lambda^+\otimes S^2_0\Lambda^-\to\mathcal W_4$, and each target summand is trivial as a module over one of the two $SO(3)$ factors while the source is not, so the cross term vanishes, and likewise $Q$ maps each summand into itself. The restriction of $Q$ to $S^2_0(\Lambda^+)$ is nonzero: were it zero it would be zero on $S^2_0(\Lambda^-)$ too by the orientation-reversing element of $O(4)$, hence $Q\equiv0$ on $\mathcal W_4$ and every critical point would have $\theta=0$, contradicting (G6), which gives $\theta(S^2\times S^2)^2=\frac{2\cdot3\cdot1\cdot1}{2\cdot4}=\frac34\ne0$. So $P$ restricted to the unit sphere of $S^2_0(\Lambda^+)$ is a nonzero cubic (the unique $SO(3)$-invariant cubic on $S^2_0(\mathbb R^3)$ up to scale, namely $\operatorname{tr}A^3$), its maximum is attained, and the maximiser $W$ is a critical point of $P$ on the unit sphere of $\mathcal W_4$ with $\theta\ne0$, because $Q(W)$ has no component off the summand. Its stabiliser contains the $SU(2)_-$ factor, which acts trivially on $\Lambda^+$, so
$$d\le\dim SO(4)-3=3=n-1 ,$$
and with the maximiser being of type $\operatorname{diag}(-2,1,1)$ (stabiliser $SO(2)$ in $SO(3)^+$) the stabiliser is $U(2)$, $\dim=4$, giving $d=2$. Normalising, $\theta^2=\tfrac32$ for this point against $S(4)^2=\tfrac95$, consistent with (G5) and much closer to it than the $\tfrac34$ of $S^2\times S^2$. **Claim D's consequence fails at $n=4$**, and the failure is exactly the $U(2)\subset SO(4)$ hole in the missing classification: $\dim U(2)=4>3=\dim SO(3)$.

*$n=8$, a near-counterexample that survives.* $\mathrm{Spin}(7)\subset SO(8)$ acting by the spin representation has $\dim=21=\dim SO(7)$ and is not conjugate to $SO(7)$, so the missing classification is false at $n=8$ as well. It does no damage, because $\mathrm{Spin}(7)$ fixes no nonzero Weyl tensor: with $\Lambda^2\mathbb R^8=\Lambda^2_7\oplus\Lambda^2_{21}$, $S^2(\Lambda^2)$ has $1+0+1=2$ invariants ($S^2$ of the irreducible adjoint, the vector-adjoint cross term with none, and $S^2$ of the $7$), while $\Lambda^4\mathbb R^8=1\oplus7\oplus27\oplus35$ contributes $1$ (the Cayley form), $S^2_0(\mathbb R^8)=35$ contributes $0$ because the spin representation is irreducible, and the scalar contributes $1$: total $2-1-0-1=0$ for $\mathcal W_8$. So $d\le7$ at $n=8$ forces $\mathrm{Stab}^\circ\in\{SO(7),\mathrm{Spin}(7)\}$, both of which annihilate nothing nonzero, and $d\ge8$ holds at $n=8$.

*The smallest $n$ at which the argument is valid.* The invariance statement (6a)-(6c) is valid for every $n\ge4$. The consequence $d>n-1$ is **valid at $n=5,6,7$** by inspection of the maximal connected subgroups (the largest proper ones are $SO(4)$ with $6$, $SO(5)$ with $10$, $SO(6)$ with $15$, the runners-up being $SO(2)\times SO(3)$ with $4$, $U(3)$ with $9$, and $G_2$ with $14$), **valid at $n=8$** by the $\mathrm{Spin}(7)$ count above, **false at $n=4$**, and for $n\ge9$ it rests on the import that $SO(n-1)$ is the unique conjugacy class of dimension $\ge\dim SO(n-1)$, which I have not verified here and which should be cited rather than assumed. So: **smallest valid $n$ is $5$**, with $n\ge9$ carrying a citation debt.

**Direction of the damage.** All of this affects Claim D only, and Claim D is a **lower** bound on $d$. Claim C needs an **upper** bound on $\min_Wd$, so nothing in section 6 weakens Claim C. What section 6 does is make Claim C's obstruction wider than advertised: at $n=4$ the binding small-orbit point has $d=2$, not $2n-4=4$, and $B(4,1,2)=\kappa/\Delta(4,2)=\frac{21/4}{29/14}=2.534\ldots>\frac95=S(4)^2$, whereas $B(4,1,4)=\frac{105}{76}=1.38\ldots<\frac95$. At $n=4$ the sphere product is already discharged by the trace-form bound, and the obstruction comes from a point Claim A never mentions.

## 7. Kernels, $\theta=0$, the smallest $n$, odd $n$

**A kernel enlarges the orbit rather than shrinking it.** If $W$ vanishes on a subspace $V$ of dimension $r$ in the sense $W(v,\cdot,\cdot,\cdot)=0$ for $v\in V$, then $V$ is canonically attached to $W$, so $\mathrm{Stab}(W)\subseteq O(U)\times O(V)$ with $U=V^\perp$, and $\dim\mathrm{Stab}=\dim\mathrm{Stab}_{O(U)}(W)+\frac{r(r-1)}2$. Taking the smallest-orbit point of $\mathcal W_{n-r}$ from the same family, $r=1$ and $W=W(S^2\times S^{n-3})$ gives $d=\frac{n(n-1)}2-1-\frac{(n-3)(n-4)}2=3n-7>2n-4$ for $n>3$. Degenerate critical points therefore sit **above** the small-orbit family, because the group moves the kernel, and they are not a cheaper source of an obstruction. Nothing in sections 1 to 5 changes.

**$\theta=0$.** Then $e=W/\theta$ is undefined, $L_e$, $m$, $p$ and $k$ are undefined, and both (G2) and (G4) are vacuous, while (G5) holds trivially. Such points are outside the scope of the comparison entirely and cannot be the extremiser of $\theta$. Consistently, $\operatorname{tr}(L_e^2)=\kappa/\theta^2$ blows up as $\theta\to0$, which is the analytic shadow of the same fact. One place where $\theta\ne0$ is load-bearing and easy to forget: the patch to (G7) in section 1.

**The smallest admissible $n$.** $n=4$ is where the claims behave differently: the gap is $0$, so Claim B's dichotomy does not extend down there, $B(4,1,2n-4)<S(4)^2$ so the sphere product is discharged by the trace-form bound, Claim D's consequence is false, and the binding small-orbit point is the self-dual one with $d=2$ and $\theta^2=\frac32$. Everything about $n=4$ traces to $\mathcal W_4$ splitting into two ideals under $SO(4)$, which happens at no other $n$. Claim B's restriction to $n\ge8$ is therefore doing real work and should not be read as caution.

**Odd $n$.** No step in sections 2 to 5 sees the parity: $D$, $\kappa$, $S$, $T$, $\Delta$, $d^\ast$ and the $n=25$ switch are single rational expressions, and the exact census covers both parities uniformly. Parity enters in exactly two places, both in the group theory. First, the $O(n)$ versus $SO(n)$ subtlety of section 1 is automatic at odd $n$ (where $-I$ has determinant $-1$ and acts trivially on $4$-tensors) and needs the $P$-patch at even $n$. Second, the subgroup classification missing from Claim D has its counterexamples at even $n$ ($U(2)$ at $n=4$, $\mathrm{Spin}(7)$ at $n=8$), and the unitary and quaternionic families exist only at even and at multiple-of-four $n$. So odd $n$ is the easier case everywhere, and no claim above is an artefact of parity.

## 8. The near-miss: a gap of $3$ or $4$ against quantities of size $2n$

The constancy of the gap is **not** a numerical coincidence, and it is exactly computable. By (3a),

$$\underbrace{4\Big(\frac{\kappa(n)}{S(n)^2}-1\Big)}_{\text{real threshold on }d}-\underbrace{(2n-4)}_{\text{orbit dimension}}=3+\frac{2}{n-1}\qquad\text{identically in }n .$$

So the real-valued gap is $3+\frac2{n-1}$, which lies in $(3,4]$ for every $n\ge3$, and the integer gap is its value rounded through the $\frac{(d+2)^2}{4k}$ correction: $3$ while that correction covers the $\frac2{n-1}$, which is while $n^4-24n^3-7n^2-12n+6\le0$, and $4$ afterwards. The dichotomy $\{3,4\}$ is thus a theorem with a quartic as its discriminant, and there is no room for a third value.

**Is the slope match structural?** Two slopes have to agree for the gap to be $O(1)$ at all: the orbit side is $2n-4=2(n-2)$, and the bound side is $4\kappa(n)/S(n)^2=2n+3+\frac2{n-1}$. I can say precisely where each $2$ comes from and I cannot connect them. The orbit slope is $2$ because the smaller sphere has dimension $p=2$ and $\dim SO(n)-\dim SO(p)-\dim SO(n-p)=p(n-p)$, whose slope is $p$ (and the orbit is $O(n)$-geometry, indifferent to $P$). The bound slope is $4\lim_{n\to\infty}\frac{\kappa(n)}{nS(n)^2}=4\cdot\frac12=2$, where the $\frac12$ is $\kappa\sim\frac{n^2}2$ against $S^2\sim n$ (and this is algebra of the trace form, indifferent to any group). **Nothing in the givens links them**, and the evidence that they are unrelated is that the match is specific to $p=2$: at $p=3$ the orbit dimension is $3n-9$, of slope $3$, which overtakes $d^\ast(n)\le2n$ at $n=8$ and stays above it, so $S^3\times S^{n-3}$ is discharged by the trace-form bound at every $n\ge8$ and the near-miss does not recur. Had the two-sphere factor been absent from the family, the trace-form bound would already improve on the standing bound across the whole family. So: **the constancy of the gap given the slopes is exact arithmetic, and the equality of slopes is, on the evidence available in this brief, a coincidence of the $p=2$ family with the $\kappa/S^2$ ratio.** I assert nothing stronger, and I note what would settle it: a derivation of $S(n)$ showing whether its $\sqrt{n+1}$ arises from a codimension-$2$ reduction, in which case the coincidence would be one fact read twice.

## 9. What would falsify Claim C, and what I did to look for it

**The falsifier.** A proof of the uniform improvement $\sup_W\theta<S(n)$ that never bounds an excess: concretely, **a classification statement of the form "every critical point with $\theta\ne0$ and $d<d^\ast(n)$ lies in the two-factor sphere-product family"**, for every $n$. With that object in hand, Claim C's conclusion collapses, because the family's $\theta$ is known exactly from (G6) and is below $S(n)$ at every $n$: $\theta^2=1-\frac1{(n-2)^2}<1$ at $p=2$, and every $p\ge3$ member already satisfies $d\ge d^\ast(n)$, so the trace-form bound handles it. A weaker falsifier that also suffices: any upper bound $\theta^2\le c<S(n)^2$ valid at all critical points of orbit dimension below $2n$, proved by whatever means.

A second, cheaper falsifier of Claim C's premise rather than its logic: **a proof that $m-d\ge4$ at $W(S^2\times S^{n-2})$**, which would discharge the one known sub-threshold point through (G4) itself. Section 5 shows the trace identity permits excess up to order $n^2$ there, so this is not a long shot.

**What I did to look for them.** No sweep and no search of unbounded scope, per the standing rule. I checked the known family exhaustively against the threshold in exact arithmetic ($p(n-p)$ against $d^\ast(n)$ at $n=8,12,20,50$ and the general inequality $3n-9\ge d^\ast(n)$ for $n\ge8$), which localises the whole debt to $p=2$. I checked the smallest dimension by hand and found a critical point **outside** the sphere-product family with $d=2<2n-4$ at $n=4$ (section 6d), which is direct evidence that the classification falsifier is false as stated at $n=4$ and that similar points may exist at higher $n$: that is the single strongest reason to expect Claim C's spirit to hold even though its letter does not. At $n=8$ I checked the two subgroups of maximal proper dimension ($SO(7)$ and $\mathrm{Spin}(7)$) and found neither fixes a nonzero Weyl tensor, so no sub-$(n-1)$-dimensional orbit exists there. I did not attempt to compute $m$ at $W(S^2\times S^{n-2})$: that is a finite linear-algebra problem in the $O(2)\times O(n-2)$-isotypic decomposition of $\mathcal W_n$, well-defined and bounded in cost, and it is the item I would put at the top of the plan.

## Verdict

**Claims A and the arithmetic core of B are CONFIRMED and in two places strengthened: $\theta^2=1-\frac1{(n-2)^2}$ rather than merely $<1$, and the gap dichotomy is $3$ for $8\le n\le24$ and $4$ for every $n\ge25$ with a quartic discriminant, proved for all $n$ rather than checked to $1000$. Claim B's asymptotic clause is REFUTED: $d^\ast(n)=2n$ for every $n\ge25$, so $d^\ast(n)=2n-1+o(1)$ is wrong by $1$, the pre-rounding threshold $2n-1+\frac2{n-1}$ having been reported in place of the integer. Claim C is CONFIRMED as a statement about the single-inequality route "(G3) then (G4)", where the loss is $\frac32$ on $\theta^2$ in the limit and never below $0.84$ on $n\ge8$, and REFUTED AS STATED in its "any proof must supply positive excess", because the target is a supremum that admits a case split and the exhibited witness is already discharged in closed form by (G6). Claim D is CONFIRMED AS ALGEBRA for every $n\ge4$, by a direct invariant count that survives the two dimensions where the generic count would fail, while its orbit-dimension consequence is REFUTED AS STATED, being false at $n=4$ (a self-dual critical point with $\theta^2=\frac32$ and $d=2\le n-1$) and resting for $n\ge9$ on an unstated classification of proper connected subgroups of dimension at least $\dim SO(n-1)$, which fails at $n=8$ and is rescued there only by a separate count showing $\mathrm{Spin}(7)$ fixes no nonzero Weyl tensor.** The action the cycle should take is to restate the obstruction as a classification debt at orbit dimension below $2n$, and to compute $m$ at $W(S^2\times S^{n-2})$, which is bounded work and decides whether the obstruction has a witness at all.
