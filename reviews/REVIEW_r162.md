# Gate 2, Reviewer r162: the half-eigenspace count and the (G) route

**Verdict.** Claim 1's number is right and its conclusion is wrong. $\dim E(\tfrac12)=pq$ is the record's statement *with the $(3,3)$ exception attached*, the exception is proved in closed form in [fence-posts.md](../findings/fence-posts.md), and $2pq$ is an arithmetic accident at $p=q=3$ with no general content. At $S^6\times S^6$, $n=12$: $\dim E(\tfrac12)=36=\dim\mathcal O$, **Hessian excess $0$**. The route does not die at its own extremiser. It dies one step earlier, at the reduction in Claim 2, which is a non sequitur with a witness against it already on the record.

---

## (b), the question the brief asked hardest. Derived, not computed.

### Setup, from the record's own proved statements

At $S^p\times S^q$, $p+q=n$, $p,q\ge3$, put $e=W/\theta$. $K=O(p)\times O(q)$ fixes $e$, so $L_e$ is $K$-equivariant. Nienhaus Proposition 4.6, as carried in [fence-posts.md](../findings/fence-posts.md), gives

$$\mathrm{Weyl}_n=\langle W\rangle\oplus\mathrm{Weyl}_p\oplus\mathrm{Weyl}_q\oplus(\mathbb R^p\!\otimes\!\mathbb R^q)\oplus S^2_0(\mathbb R^p)\oplus S^2_0(\mathbb R^q)\oplus(S^2_0\!\otimes\!S^2_0)\oplus(\Lambda^2\!\otimes\!\Lambda^2)\oplus(X_p\!\otimes\!\mathbb R^q)\oplus(X_q\!\otimes\!\mathbb R^p),$$

orthogonal, absolutely irreducible and **multiplicity-free** for $p,q\ge3$, the small-case commutants at $m=3,4$ were computed here and are $1$ with all cross-Homs zero, including the two coincidences ($\mathbb R^3$ vs $\Lambda^2\mathbb R^3$, $S^2_0$ vs $X_3$) that would have broken it. Schur plus symmetry of $L_e$ therefore makes $L_e$ **a scalar on each summand**, so the spectrum is exactly the ten values and nothing hides between them. That is the direction a multiplicity count needs, and the record has it unconditionally ("both debts are discharged").

The ten values, each proved on the record:

| summand | dimension | $L_e$ |
| --- | --- | --- |
| $\langle W\rangle$ | $1$ | $1$ |
| $\mathbb R^p\otimes\mathbb R^q$, the orbit tangent | $pq$ | $\tfrac12$ |
| $S^2_0(\mathbb R^m)$, $m=p,q$ | $s_m=\tfrac{(m+2)(m-1)}2$ | $\lambda_m=\tfrac{m-2}{2(m-1)}$ |
| $S^2_0\otimes S^2_0$ | $s_ps_q$ | $-\mu$ |
| $\Lambda^2\otimes\Lambda^2$ | $c_pc_q$, $c_m=\tfrac{m(m-1)}2$ | $+\mu$ |
| $\mathrm{Weyl}_p,\ \mathrm{Weyl}_q,\ X_p\otimes\mathbb R^q,\ X_q\otimes\mathbb R^p$ |, | $0$ |

with $\mu=\dfrac{n-2}{2(p-1)(q-1)}$.

### The count

$\dim E(\tfrac12)$ is the sum of the dimensions of the summands whose scalar is $\tfrac12$. Test each:

- $\lambda_m=\tfrac12\iff m-2=m-1$: **never**, and $\lambda_m<\tfrac12$ for every $m$, approaching it from below.
- $-\mu=\tfrac12$ needs $\mu<0$: impossible for $n>2$.
- $0$ and $1$ are not $\tfrac12$.
- $+\mu=\tfrac12\iff (p-1)(q-1)=n-2=p+q-2\iff pq-2p-2q+3=0\iff (p-2)(q-2)=1$.

Over integers $p,q\ge3$ the last has the single solution $p=q=3$. Hence

$$\boxed{\ \dim E(\tfrac12)=pq\ \text{ for all }p,q\ge3\ \text{ with }(p,q)\ne(3,3);\qquad \dim E(\tfrac12)=pq+c_pc_q=18\ \text{ at }(3,3).\ }$$

### $2pq$ is a coincidence, and the coincidence is visible in one line

At $(3,3)$ the extra summand is $\Lambda^2\otimes\Lambda^2$ of dimension $c_3c_3=3\cdot3=9$, which happens to equal $pq=9$. In general $c_pc_q=pq\iff(p-1)(q-1)=4\iff p=q=3$. So **two independent coincidences land on the same split** ($\mu=\tfrac12$ and $c_pc_q=pq$) and reading "$2pq$" off the one point where both fire generalises an accident. The record already names the first as "an eigenvalue coincidence, not representation mixing".

### $S^6\times S^6$, $n=12$

$\mu=\dfrac{10}{2\cdot5\cdot5}=\tfrac15$, $\lambda_6=\dfrac{4}{2\cdot5}=\tfrac25$. Both strictly below $\tfrac12$, so $E(\tfrac12)=\mathbb R^6\otimes\mathbb R^6$ and

$$\dim E(\tfrac12)=36 .$$

The orbit: the isotropy of $W_{6,6}$ in $\mathfrak{so}(12)$ is $\mathfrak{so}(6)\oplus\mathfrak{so}(6)$, so $\dim\mathcal O=\binom{12}2-2\binom62=66-30=36=pq$.

$$\textbf{Hessian excess at }S^6\times S^6=36-36=0 .$$

The full spectrum there, as a check the decomposition closes: $1^{1},(\tfrac12)^{36},(\tfrac25)^{40},(\tfrac15)^{225},0^{936},(-\tfrac15)^{400}$, summing to $1638=\dim\mathrm{Weyl}_{12}$.

### And the record already held this number

[fence-posts.md](../findings/fence-posts.md)'s classification table: *"$n=12$ | all five two-block splits | all nondegenerate, $20,27,32,35,36$ matching $pq$ exactly."* $36$ is $S^6\times S^6$. So plan.md item 2's *"nothing on the record gives the Hessian excess of the conjectured maximiser $S^6\times S^6$ at $n=12$, which is the number that decides the route"* is **false as written**, the record gives it twice, once as a measurement in that table and once as a theorem via the $(p-2)(q-2)=1$ identity.

### The identification $\ker\mathrm{Hess}=E(\tfrac12)$, since the route depends on it

$P(W)=T(W,W,W)$ with $T$ the totally symmetric trilinear form of the metrised algebra, so $\tfrac{d^2}{dt^2}P(W+tv)=6\,T(W,v,v)=6\theta\langle L_ev,v\rangle$. Criticality gives $\nabla P=3Q(W)=3\theta W$ against $\nabla|W|^2=2W$, so the multiplier is $\tfrac{3\theta}2$ and the constrained Hessian on $W^\perp$ is $6\theta\big(L_e-\tfrac12\big)$. Hence $\ker\mathrm{Hess}|_{W^\perp}=E(\tfrac12)\cap W^\perp$ **exactly**, and Lemma L24 *is* the second-order condition rather than a companion to it. The excess arithmetic above is therefore Hessian excess in the plan's own sense.

---

## CLAIM 1, the number is the record's, the conclusion is not

**The operator is right.** $L_e$ as the polarisation of $Q(W)=W^2+W^\#$ is what the record uses; the resulting spectrum at $S^3\times S^3$ is $1^{1},(\tfrac12)^{18},(\tfrac14)^{10},0^{30},(-\tfrac12)^{25}$, which is character-for-character the spectrum [second-order.md](../findings/second-order.md) records for the Peirce table at that point, and the ten summand dimensions above reproduce it exactly. No convention mismatch.

**The basis is right.** $\dim\mathrm{Weyl}_6=\tfrac{6\cdot7\cdot8\cdot3}{12}=84$, and the summand dimensions sum to $84$ independently of how the basis was built.

**$\lambda_{\max}=1.0000000$ is vacuous, and the reading drawn from it is wrong.** $e$ is an idempotent: $Q(e)=Q(W)/\theta^2=\theta W/\theta^2=e$, so $L_ee=e$ and **$1\in\sigma(L_e)$ at every critical point whatever it is**, maximiser, saddle or minimum. Lemma L24 bounds $\lambda_{\max}\big(L_e|_{W^\perp}\big)$, and on $W^\perp$ at $S^3\times S^3$ the largest value is $+\mu=\tfrac12$. So the figure $1$ was read off the unrestricted operator with the $\langle W\rangle$ line left in. It confirms nothing about saddle-ness and indicates nothing wrong with the operator; it indicates the restriction was dropped. *The record's own spectrum tables carry $1^{1}$ in every row for the same reason.*

The conclusion the record actually holds for this point, and which stands untouched, is [second-order.md](../findings/second-order.md)'s: $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ exactly at $S^3\times S^3$, with $\theta$ taking both signs at cubic order on the nine transverse null directions, a degenerate saddle established at **third** order, not by a violated $\tfrac12$.

**"The record's $\dim E(\tfrac12)=pq$ is wrong" is a misreading.** The record's statement is scoped: *"for $p,q\ge3$, every $S^p\times S^q$ **other than $S^3\times S^3$** is Morse–Bott nondegenerate, $\dim E(\tfrac12)=pq$, and the exception is the identity $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$."* Dropping the exception clause and then testing at the exception is what produced the refutation.

## (a), asserted as new, already held

| asserted | where the record already holds it |
| --- | --- |
| $\dim E(\tfrac12)=18$ at $S^3\times S^3$ | [fence-posts.md](../findings/fence-posts.md) twice, [second-order.md](../findings/second-order.md) three times ("$18$ against $9$"), [nondegeneracy.md](../findings/nondegeneracy.md)'s table row *$S^3\times S^3$ (control) ($18/9$), excess $9$* |
| the orbit tangent is a $\tfrac12$-eigenvector | [second-order.md](../findings/second-order.md): *"Differentiating the equivariance $Q(gW)=gQ(W)$ … the orbit tangent lies in the $\tfrac12$-eigenspace at every critical point (Reviewer 29) … the inclusion itself is a theorem"*; and [fence-posts.md](../findings/fence-posts.md) uses it to fix the $\mathbb R^p\otimes\mathbb R^q$ value with no computation |
| the Hessian excess of $S^6\times S^6$ at $n=12$ is unrecorded | it is $36=pq$, in the $n=12$ classification row |
| $\mathrm{mult}(\tfrac12)\ge\dim\mathcal O$ is an inequality, not an identity | [second-order.md](../findings/second-order.md), stated in exactly those words in the retracted-quotient note |

## CLAIM 2, the combination is sound; the reduction is not

**Sound.** Orbit directions lie in $W^\perp$ because the orbit lies in the sphere. The identity is the same operator Lemma L24 bounds: differentiating $Q(e^{tX}W)=e^{tX}Q(W)$ at $t=0$ gives $2B(W,X\!\cdot\!W)=\theta\,X\!\cdot\!W$, i.e. $2\theta L_e(X\!\cdot\!W)=\theta\,X\!\cdot\!W$, so $L_e(X\!\cdot\!W)=\tfrac12 X\!\cdot\!W$. Since no nonzero $W\in\mathrm{Weyl}_n$ is $O(n)$-invariant, the orbit is positive-dimensional and $\lambda_{\max}\ge\tfrac12$ follows. With Lemma L24 it is an equality at any maximiser. **One line from two recorded theorems, and correct.**

**But it carries no information.** [second-order.md](../findings/second-order.md) already records that *"every split with $p,q\ge3$ has $\lambda_{\max}$ exactly $\tfrac12$"*, and that padded $W_{\mathbb{CP}^2}$ (**ungraded**), has $\lambda_{\max}=0.5000000000$ exactly. So $\lambda_{\max}=\tfrac12$ is satisfied by every candidate the record knows, graded and ungraded alike. An equality is rigid only if something fails it.

**"(G) reduces to excess $0$ at a maximiser" is a non sequitur.** Excess $0$ gives Morse–Bott nondegeneracy, hence that the maximiser's orbit is a union of components of $\mathrm{Crit}(P)$. **Nothing about gradedness follows.** Local rigidity of an unknown orbit does not identify the orbit. The step worked at $W_{\mathbb{CP}^2}$ only because that point was *known* and its $\theta$ *computed*; there is no known point in the (G) argument.

**And the property does not separate the two classes, by a witness on the record.** [nondegeneracy.md](../findings/nondegeneracy.md): *"$W_{\mathbb{CP}^2}$ is the first nondegenerate ungraded critical point on record … Morse–Bott nondegenerate at $n=8,10,12$ ($\dim E(\tfrac12)=\dim(\text{orbit})=18$)."* So there exists an **ungraded** critical point with excess $0$. Any argument of the shape "maximiser $\Rightarrow$ excess $0$ $\Rightarrow$ graded" is refuted at its second arrow before its first is ever proved. *Combined with the falsified gap theorem, both directions out of the excess are now closed: excess $>0$ does not follow from ungradedness, and gradedness does not follow from excess $0$.*

So the route needs strictly more than excess $0$, it needs a property that some ungraded critical point fails, and the excess is demonstrably not one.

## CLAIM 3, 3b's retirement: right conclusion, wrong reason

**The stated reason does not support it, and it is about the wrong kind of point.** Padded $W_{\mathbb{CP}^2}$ is **ungraded** (the record derives $S_{\mathfrak{hhm}}=4(n-4)$ for exactly this family) so *"RESULT 1 does the work the graded set was supposed to do"* cites nondegeneracy at an ungraded point in place of a statement about the graded set. Worse, the record's own named mechanism reads: *"If **every** graded critical point with $\theta\ge t$ is Morse–Bott nondegenerate, each graded orbit is isolated (open and closed in $\mathrm{Crit}(P)$) so the ungraded part … is itself compact."* That is a quantifier over the whole graded classification, and [nondegeneracy.md](../findings/nondegeneracy.md) records that [graded-half.md](../findings/graded-half.md) **already withdrew its exhaustiveness claim**. One point's nondegeneracy cannot discharge a universal.

**The conclusion is nonetheless right, by an argument the plan states two lines above and does not use.** $\mathrm{Crit}(P)\cap S^{D-1}$ is compact and semialgebraic, so it has **finitely many** connected components (Łojasiewicz, cited in 3b's own opening sentence); connected semialgebraic sets are path-connected, and $\tfrac{d}{dt}P(\gamma)=\langle\nabla P,\gamma'\rangle=0$ along any path in $\mathrm{Crit}(P)$, so $P$ (hence $\theta$), takes **finitely many values** on it. A supremum of a finite set of values over *any* subset is attained. **Attainment therefore needs neither closedness of $\{S=0\}$ nor Morse–Bott anywhere.** This is not the refuted "finiteness shortcut": that one tried to derive finiteness of the *graded* set from discreteness in a compact Hausdorff quotient and was circular; Łojasiewicz finiteness of components of a compact semialgebraic set is unconditional and is already on the record.

**What survives as owed.** Closedness is off the critical path *for attainment*. It is **not** off the path for the compactness mechanism that separates the ungraded part and produces the constant $c>0$, that still needs nondegeneracy across a graded classification whose completeness is withdrawn. 3b's retirement should say "attainment never needed this", not "RESULT 1 supplies it".

## (c), item 2's grade

**The number $2\times0\times1=0$ is defensible; the reason recorded for the $0$ is not.**

- The `attackable = 0` column reads *"every named route closed"*. Two of the closures listed in the item body are sound (Euler–Jacobi, the moment method). The **third**, the one written most emphatically, *"the route's premise … is refuted at the first point tested"*, with the projected consequence *"the conjectured maximiser carries excess $36$ and the route dies at its own extremiser"*, is **false**. The excess at $S^6\times S^6$ is $0$.
- What genuinely closes the route is Claim 2's non sequitur plus the $W_{\mathbb{CP}^2}$ witness, neither of which the grade cites.
- The item body is internally inconsistent with its own grade: *"this is the grey box closest to colour, and the lever came out of this session"* sits above a value of $0$ in the table. One of the two is stale.

**Recommended repair to plan.md item 2**, in order:

1. Delete the "$2pq$" generalisation and the projected excess $36$; state $\dim E(\tfrac12)=pq$ for $p,q\ge3$ with the proved exception $(p-2)(q-2)=1$, and record $S^6\times S^6$ at $n=12$: $\dim E(\tfrac12)=36=\dim\mathcal O$, **excess $0$**, already in the record's $n=12$ classification row.
2. Withdraw *"$\lambda_{\max}=1.0000000$ at $S^3\times S^3$, so Lemma L24 is violated there"*: $1$ is $L_ee=e$ and is present at every critical point; on $W^\perp$ the value is $\tfrac12$.
3. Withdraw *"nothing on the record gives the Hessian excess of $S^6\times S^6$ at $n=12$"*.
4. Keep the closure of the route, restating its ground as: excess $0$ does not imply graded, and $W_{\mathbb{CP}^2}$ is an ungraded critical point with excess $0$.
5. Rewrite 3b's retirement ground as Łojasiewicz finiteness $+$ $P$ locally constant on $\mathrm{Crit}(P)$, and flag that the compactness/constant-$c$ mechanism still wants the graded universal.

## Method note

Everything above is derived from statements the record already proves, the isotypic decomposition, Schur on it, the six computed summand values, and the $\pm\mu$ closed form. No sweep was run and no number was computed to reach a conclusion; the arithmetic shown ($\mu=\tfrac15$, $36=66-30$, $1638$) is evaluation of proved formulae, not measurement.
