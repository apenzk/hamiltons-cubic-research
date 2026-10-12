# REVIEW r878: the per-index (B)-augmented programme, where the three-line derivation stands, the contracted-form verdict falls, and the programme exceeds the target at a two-block spectrum

**Reviewer r878.** The brief was cold: [brief-r877-r878.md](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/brief-r877-r878.md) was the only file of the record read, and nothing in [findings/](../findings/), [plan.md](../plan.md), [reviews/](../reviews/) or the attempts notebook was opened. No numerical work beyond screening was done: every derivation below is by hand, every value is exact in closed form, and the two exact-rational screens run (the feasibility of the two-block point of §8, and the symmetric fill of §5) confirmed hand results already obtained and are reported as screens. Log: [review-r878-brow.log](../agent_logs/review-r878-brow.log).

## Claim table

| # | Claim, as quoted | Verdict |
|---|---|---|
| C1 | $\theta=6c^3(1+T_{123})$ at the padded $W_{\mathbb{CP}^2}$ spectrum, $n=12$ | **Valid.** Factor and triple count both correct |
| C2 | Hollowness kills $\beta=1$ in (B) at index $1$ | **Valid**, and it also kills $\gamma=1$ and $\beta=\gamma$, which the bound needs |
| C3 | (B) at index $1$ reads $\sum_\gamma T_{12\gamma}+\sum_\gamma T_{13\gamma}=4$ | **Valid** |
| C4 | Nonnegativity and total symmetry give $T_{123}\le 2$, hence $\theta\le\sqrt{3/2}$ | **Valid** |
| C5 | Rows at indices $2$ and $3$ add nothing to the bound | **Valid**, and stronger than stated: the three rows *pin* $S_{12}=S_{13}=S_{23}=2$ exactly |
| C6 | "It is TIGHT: the object itself attains it" | **Valid.** $[A_1,A_2]=\sqrt2\,A_3$ gives $T_{123}=2$ exactly, and the object's full $T$ is feasible |
| C7 | $\sqrt{3/2}<\theta_0(12)$ | **Valid**, margin $0.011288$ |
| C8 | "no further constraint can improve this spectrum" | **Valid**, and it is the reason for the scope finding of §8.2 |
| C9 | The contraction is $\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}=-2$ | **Valid** |
| C10 | The stated two-parameter dual and its objective $\sum\lambda^3+(n-2)Ny-3z$ | **Valid.** It is the uniform-$y$ restriction of the full dual |
| C11 | "Its optimum at that same spectrum is $23.48$" | **Defect, minor.** The exact optimum is $115/(2\sqrt6)=23.47428$, which rounds to $23.47$ |
| C12 | "five times WORSE than using the marginals alone" | **Defect, substantive.** The comparator $11/\sqrt6$ is a per-index LP value, the $23.47$ a uniform-$y$ value. At uniform $y$ the marginals alone give $221/\sqrt6=90.22$, so the contraction *improves* that bound by $3.8\times$ |
| C13 | "THE CONTRACTED FORM OF (B) IS WORSE THAN USELESS" | **Refuted.** Contracted (B) plus the marginals, with per-index multipliers, has exact LP value $5/\sqrt6=2.04124$ at that spectrum against the marginals-only $11/\sqrt6=4.49073$ |
| C14 | "A successor puts one multiplier per index, not one per relation" | **Valid conclusion, wrong evidence.** What the $23.47$ isolates is the cost of *uniformity*, not of contraction |
| C15 | Balanced product: added constraint lowers, true value is a floor, so the augmented programme returns $\theta_0(n)$ there | **Valid**, and it does need the balanced product's own $T$ to satisfy (B), which Given 3 supplies unconditionally |
| C16 | "RELATION (B) COLLAPSES **THE WORST SPECTRUM** TO ITS TRUE VALUE" | **Refuted as stated.** At the two-block spectrum of $W_{\mathbb{CP}^2}\oplus W_{\mathbb{CP}^2}$ padded to $n=12$ the augmented programme's exact value is $7\sqrt3/6=2.02073$, against target $1.23603$ and true value $\sqrt3/2=0.86603$ |

## Summary in one line

Every step of the three-line derivation and its tightness claim survives, the "worse than useless" verdict on contracted (B) is refuted by an exact LP value of $5/\sqrt6$, and the augmented programme itself is refuted as a route to the target by an exact feasible point of value $7\sqrt3/6$ at the two-block $\mathbb{CP}^2$ spectrum at $n=12$.

## Conventions, quoted from the brief

- $\Lambda^2\mathbb R^n$ is realised as skew matrices. $\varphi_{ab}=E_{ba}-E_{ab}$ and it is a UNIT bivector, the inner product being $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$.
- The norm on a four-index tensor is the record's: $\lVert R\rVert^2=\tfrac14\sum_{ijkl}R_{ijkl}^2$.
- $(\omega\wedge\omega)_{ijkl}=2(\omega_{ij}\omega_{kl}-\omega_{ik}\omega_{jl}+\omega_{il}\omega_{jk})$, so the record's wedge is twice the Pfaffian.
- $\mathcal W_n$ is the space of algebraic Weyl tensors, $\lVert W\rVert^2=\operatorname{tr}(W^2)$, and criticality on the unit sphere is $Q(W)=W^2+W^\#=\theta W$.

Two derived conventions are used throughout and are established in §0: $[\varphi_{ab},\varphi_{ac}]=\varphi_{bc}$, and $\varphi_{ab}$ commutes with $\varphi_{cd}$ when the index pairs are disjoint.

## Hypothesis inventory

What the audited chain actually consumes, listed so that the scope of each verdict is legible.

| Ingredient | Source | Used where |
|---|---|---|
| $\theta=\sum_\alpha\lambda_\alpha^3+\tfrac12 m_3$ at fixed spectrum | Given 1 | Every section |
| $T$ totally symmetric, hollow, $T\ge0$ | Given 1 | §1, §2, §5, §8 |
| Marginal $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$, ordered pairs | Given 2, L153 | §3, §7, §8 |
| Relation (B) $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, one row per index, no criticality hypothesis | Given 3 | §1, §2, §5, §6, §8 |
| Trace-free spectrum, $\sum_\alpha\lambda_\alpha=0$ | $\mathcal W_n$ definition | §2, §9 |
| Unit norm, $\sum_\alpha\lambda_\alpha^2=1$ | Given 1 | §5, §8 |
| The balanced product is a genuine element of $\mathcal W_n$ whose true $\theta$ is $\theta_0(n)$ | presupposed by Given 6 | §6 |
| **The augmented programme's only inputs about $T$ are the marginal and the $N$ rows of (B)** | Given 1 with Given 4's phrasing | §8, and see §10 |

The last row is the load-bearing reading. §10 says what changes if the record's programme carries more.

## §0 The commutator table, and the two constants anchored on a real object

From $\varphi_{ab}=E_{ba}-E_{ab}$ and $E_{ij}E_{kl}=\delta_{jk}E_{il}$: $\varphi_{ab}^2=-(E_{aa}+E_{bb})$, so $\langle\varphi_{ab},\varphi_{ab}\rangle=\tfrac12\operatorname{tr}(-\varphi_{ab}^2)=1$, confirming the unit normalisation. For $a,b,c$ distinct, expanding the four products gives $[\varphi_{ab},\varphi_{ac}]=\varphi_{bc}$, and disjoint index pairs commute.

Take the $n=4$ self-dual triple $A_1=(\varphi_{12}+\varphi_{34})/\sqrt2$, $A_2=(\varphi_{13}+\varphi_{42})/\sqrt2$, $A_3=(\varphi_{14}+\varphi_{23})/\sqrt2$, each of unit norm. Then

$$[A_1,A_2]=\tfrac12\big([\varphi_{12},\varphi_{13}]+[\varphi_{12},\varphi_{42}]+[\varphi_{34},\varphi_{13}]+[\varphi_{34},\varphi_{42}]\big)=\tfrac12\big(\varphi_{23}+\varphi_{14}+\varphi_{14}+\varphi_{23}\big)=\sqrt2\,A_3 .$$

So $c_{123}=\sqrt2$ and $T_{123}=2$ for the eigenbasis of $W_{\mathbb{CP}^2}$, whose operator is $\operatorname{diag}(2c,-c,-c)$ on $\Lambda^+$ and $0$ on $\Lambda^-$.

This anchors both constants of the brief against an actual object, which matters because the record's $\#$ normalisation is not in the brief and a factor of two in it would move the $-2$ in (B).

- **Marginal.** For $\alpha=A_1$ at $n=12$: $\operatorname{ad}(A_1)$ sends $A_2\mapsto\sqrt2A_3$ and $A_3\mapsto-\sqrt2A_2$, contributing $2+2=4$. It kills $\Lambda^-$ and $\Lambda^2\mathbb R^8$. On the $32$ elements $\varphi_{ip}$ with $i\le4<p$ it gives $[A_1,\varphi_{1p}]=\varphi_{2p}/\sqrt2$ and its kin, each of squared norm $\tfrac12$, contributing $16$. Total $20=2(n-2)$, matching Given 2 exactly.
- **Relation (B).** At index $1$ the object gives $S_{12}=S_{13}=2$ (see §3), so $\sum_{\beta\gamma}\lambda_\beta T_{1\beta\gamma}=-c(2+2)=-4c=-2\lambda_1$. The constant is $-2$ and not $-1$, confirmed on the object.
- **Cross-check on the $\tfrac12$ in Given 1.** With $T_{123}=2$, Given 1 returns $\theta=18c^3=3/\sqrt6=\sqrt{3/2}$, which is the true $\theta$ that Given 5 records independently. The classical dimension-four form $W^\#|_{\Lambda^+}=2\operatorname{diag}(\lambda_2\lambda_3,\lambda_3\lambda_1,\lambda_1\lambda_2)$ gives $\langle W^\#,W\rangle=6\lambda_1\lambda_2\lambda_3=12c^3=\tfrac12m_3$, agreeing.

## §1 The three-line derivation, item 1

**Spectrum.** $\lambda_1=2c$, $\lambda_2=\lambda_3=-c$, $\lambda_k=0$ for $4\le k\le 66$, with $6c^2=1$ so $c=1/\sqrt6$. Trace-free and unit-norm, as required.

**The objective.** $\sum_\alpha\lambda_\alpha^3=8c^3-c^3-c^3=6c^3$. In $m_3=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma T_{\alpha\beta\gamma}$ the sum is over ordered triples, hollowness restricts to distinct triples, and a nonzero product needs all three indices in $\{1,2,3\}$. The six orderings each carry $\lambda_1\lambda_2\lambda_3T_{123}=2c^3T_{123}$, so $m_3=12c^3T_{123}$ and $\tfrac12m_3=6c^3T_{123}$. Hence

$$\theta=6c^3\,(1+T_{123}),\qquad 6c^3=\frac{6}{6\sqrt6}=\frac1{\sqrt6}.$$

**C1 is correct**, factor and count alike. The count is six ordered triples from the single unordered triple $\{1,2,3\}$, and the marginals-only cap $T_{123}\le10$ (from $2T_{123}\le 2(n-2)=20$) reproduces Given 4's $11/\sqrt6=4.4907312$, which is an independent check that the objective is normalised as the record has it.

**Hollowness.** $T_{1\beta\gamma}$ vanishes when $\beta=1$, when $\gamma=1$, and when $\beta=\gamma$. The record names only $\beta=1$. The other two are used silently and correctly: $\gamma=1$ vanishing is what makes $\sum_\gamma T_{12\gamma}$ a sum over $\gamma\notin\{1,2\}$, and $\beta=\gamma$ vanishing is what keeps the row a sum over genuine triples. **C2 holds, with that amendment to the wording.**

**Relation (B) at index 1.** Nonzero $\lambda_\beta$ needs $\beta\in\{1,2,3\}$, and $\beta=1$ is hollow, so with $S_{\alpha\beta}:=\sum_\gamma T_{\alpha\beta\gamma}$,

$$\sum_{\beta\gamma}\lambda_\beta T_{1\beta\gamma}=-c\,(S_{12}+S_{13})=-2\lambda_1=-4c\quad\Longrightarrow\quad S_{12}+S_{13}=4 .$$

**C3 is exactly what the row says.**

## §2 The nonnegativity step, and the rows at 2 and 3, item 2

**The step.** $S_{12}=\sum_{\gamma\notin\{1,2\}}T_{12\gamma}\ge T_{123}$ because every term is nonnegative and $\gamma=3$ is one of them. Total symmetry gives $S_{13}\ge T_{132}=T_{123}$. Adding, $2T_{123}\le S_{12}+S_{13}=4$, so $T_{123}\le2$ and $\theta\le18c^3=3/\sqrt6=\sqrt{3/2}=1.2247449$. **C4 holds.**

**The rows at 2 and 3.** Write $u=S_{12}$, $v=S_{13}$, $w=S_{23}$. The three rows read

$$-c(u+v)=-4c,\qquad 2c\,u-c\,w=2c,\qquad 2c\,v-c\,w=2c,$$

that is $u+v=4$, $2u-w=2$, $2v-w=2$. The last two force $u=v$, the first then gives $u=v=2$, and $w=2u-2=2$. So **the three rows pin $u=v=w=2$ exactly**, leaving $T_{123}\le\min(u,v,w)=2$, the same bound. **C5 holds**, and the record understates its own result: the rows at $2$ and $3$ do not merely fail to improve the bound, they determine all three pair sums, which is what makes the equality case rigid (equality forces $T_{12\gamma}=T_{13\gamma}=T_{23\gamma}=0$ for every $\gamma\ge4$).

**A general lemma, free of charge.** For *any* trace-free unit-norm spectrum with exactly three nonzero eigenvalues $x,y,z$ (in any $n$), the (B) rows have the unique solution

$$u=S_{12}=\frac{z^2-x^2-y^2}{xy},\qquad v=S_{13}=\frac{y^2-x^2-z^2}{xz},\qquad w=S_{23}=\frac{x^2-y^2-z^2}{yz},$$

the system determinant being $2xyz$. Trace-freeness gives $xy=e_2-z(x+y)=-\tfrac12+z^2$ and its permutations, so $2z^2-1=2xy$ and hence $u=v=w=2$ identically. With $\sum\lambda^3=3e_3$ and $\tfrac12m_3=3e_3T_{123}$ this yields $\theta\le 9e_3\le 9/(3\sqrt6)=\sqrt{3/2}$ over the whole three-eigenvalue family, the maximum of $e_3$ being at the padded $W_{\mathbb{CP}^2}$ spectrum. The audited spectrum is therefore the worst of its own family, not merely one point of it. §8.2 draws the consequence.

## §3 Tightness, item 3

The object's $T$ must be feasible for both constraint families and must give $T_{123}=2$.

- $T_{123}=2$: established in §0 from $[A_1,A_2]=\sqrt2A_3$.
- $S_{12}=2$: $[A_1,A_2]=\sqrt2A_3$ has no component outside $A_3$, so $c_{12\gamma}=0$ for every $\gamma\ne3$ and $S_{12}=T_{123}=2$. Likewise $S_{13}=S_{23}=2$, matching the pinned values of §2 and saturating $T_{123}\le\min(u,v,w)$.
- The marginal at index $1$: $S_{12}+S_{13}+\sum_{k\ge4}S_{1k}=2+2+16=20=2(n-2)$, the $16$ being the $32$ elements $\varphi_{ip}$ at $\tfrac12$ each from §0. It closes exactly.
- The rows of (B) at the kernel indices: verified in §7.

**C6 holds. The bound is attained, the equality case is the object, and $T_{123}=2$ is exact.** The tightness claim is correct, and by §2 nothing weaker than a constraint outside the $\{T\ge0,\ \text{symmetry},\ \text{marginal},\ (B)\}$ family can move this spectrum.

## §4 The comparison against the target, item 4

$$\theta_0(12)=\frac{\sqrt{2\cdot11\cdot10}}{12}=\frac{\sqrt{220}}{12}=1.2360331,\qquad \sqrt{3/2}=1.2247449,$$

so $\sqrt{3/2}<\theta_0(12)$ with margin $0.0112882$. Squaring settles it without decimals: $\tfrac32<\tfrac{220}{144}=\tfrac{55}{36}$ because $54<55$. **C7 holds.**

What it means at this spectrum: the augmented programme's value there equals the true $\theta$ of the object and sits strictly below the target, so this spectrum obstructs the conjecture no longer, and by §3 the value cannot be pushed lower by any further constraint. The margin is $0.91\%$, which is the whole of the room the conjecture has at this spectrum.

**C8 holds** as a statement about this spectrum. It does not extend to a statement about the programme, and §8 is where that distinction bites.

## §5 The contracted form, item 5

**The contraction, C9.** Multiplying the row at $k$ by $\lambda_k$ and summing gives

$$\sum_k\lambda_k\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=\sum_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta T_{\alpha\beta\gamma}=-2\sum_k\lambda_k^2=-2$$

at unit norm. **Correct.** It is satisfied by the object: with $T_{123}=2$ the only contribution is $2\cdot(-3c^2)\cdot 2$ over the two ordered positions, and in the unordered normalisation of the next paragraph, $2\cdot(-\tfrac12)=-1$.

**The stated dual, C10.** Pass to unordered triples, writing $t$ for the common value, $p=\lambda_\alpha\lambda_\beta\lambda_\gamma$ and $e_2=\lambda_\alpha\lambda_\beta+\lambda_\beta\lambda_\gamma+\lambda_\gamma\lambda_\alpha$. Then $\tfrac12m_3=3\sum t\,p$, the marginal at $k$ is $\sum_{\{\beta\gamma\}}t_{k\beta\gamma}=n-2$, and the contracted relation is $\sum t\,e_2=-1$. With multipliers $y_k$ on the marginals and $\zeta$ on the scalar, LP duality gives $3p\le y_\alpha+y_\beta+y_\gamma+\zeta e_2$ per triple and objective $(n-2)\sum_ky_k-\zeta$. Restricting to $y_k\equiv y$ and putting $z=\zeta/3$ reproduces the record's

$$p\le y+z\,e_2\ \text{ at every distinct triple},\qquad \theta\le\sum\lambda^3+(n-2)Ny-3z$$

verbatim. **The family is valid**, and it is the uniform-$y$ restriction of the full dual, so each member is an upper bound, and its optimum need not be the LP value.

**Its optimum, C11.** At the audited spectrum the distinct $(p,e_2)$ pairs are $(2c^3,-3c^2)$ for $\{1,2,3\}$, $(0,-2c^2)$ for $\{1,2,k\}$ and $\{1,3,k\}$, $(0,c^2)$ for $\{2,3,k\}$, and $(0,0)$ for every triple meeting $\{1,2,3\}$ at most once. With $c^2=\tfrac16$ the constraints are $y-\tfrac z2\ge K$ with $K=2c^3=1/(3\sqrt6)$, $y\ge\tfrac z3$, $y\ge-\tfrac z6$, $y\ge0$, and $(n-2)N=660$. Minimising $660y-3z$: the pairs $\{(a),(d)\}$, $\{(c),(d)\}$ and $\{(a),(b)\}$ are all infeasible or violate $y\ge0$, leaving the single vertex $y=K/4$, $z=-3K/2$, value $169.5K=56.5/\sqrt6$. Adding $\sum\lambda^3=1/\sqrt6$,

$$\theta\le\frac{57.5}{\sqrt6}=\frac{115}{2\sqrt6}=23.4742767 .$$

**The record's $23.48$ is a rounding slip: the exact value rounds to $23.47$.** Minor, and it does not touch the qualitative claim. The two ratios the record quotes survive: $23.4743/1.2247449=19.163$ and $23.4743/4.4907312=5.227$.

**The direction, C12 and C13.** The brief is right to press this: a dual family cannot be worse than a sub-family of itself, and the resolution is that $23.4743$ and $4.4907$ are not values of one family.

- $11/\sqrt6=4.4907312$ is the **full per-index** LP value of the marginals-only programme.
- $23.4743$ is the optimum of a **two-parameter uniform-$y$** family.
- Set $z=0$ in that same uniform family and the constraints collapse to $y\ge\max p=2c^3$, giving $\theta\le 6c^3+1320c^3=1326c^3=221/\sqrt6=90.2228722$.

So **within the uniform family the contraction improves the bound from $90.22$ to $23.47$, a factor of $3.84$ in the right direction.** The $5\times$ gap the record reports is the cost of collapsing $66$ multipliers into one, and the contraction pays for part of it rather than causing it.

**The contracted programme's own LP value.** Keep the contraction and restore per-index multipliers. At the audited spectrum put $t=t_{123}$, and $P,Q,R$ for $\sum_{k\ge4}t_{12k},\sum_{k\ge4}t_{13k},\sum_{k\ge4}t_{23k}$. The contraction reads $-\tfrac t2-\tfrac{P+Q}3+\tfrac R6=-1$, so $t=2-\tfrac23(P+Q)+\tfrac R3$, maximised at $P=Q=0$. The marginal at index $2$ gives $t+P+R\le10$, so $t=2+\tfrac R3$ with $t+R\le10$ forces $4t\le16$:

$$t\le4,\qquad \theta\le 6c^3\cdot5=\frac{30}{6\sqrt6}=\frac5{\sqrt6}=2.0412415 .$$

This is attained. Take $t_{123}=4$, $t_{23k}=\tfrac2{21}$ for each of the $63$ kernel indices, $t_{12k}=t_{13k}=0$, $t_{1kl}=6/\binom{63}2$, $t_{2kl}=t_{3kl}=0$, and $t_{klm}=\tfrac{68}{13237}$: all marginals equal $10$, the contraction equals $-1$, and every value is positive. Checked by hand and confirmed on an exact-rational screen.

**So contracted (B) plus the marginals has exact LP value $5/\sqrt6=2.0412$ at the spectrum where the marginals alone give $11/\sqrt6=4.4907$: the contraction cuts the bound by a factor $11/5$.** **C13, "worse than useless", is refuted.** It remains true that the contraction loses what the $N$ rows hold, since the rows give $\sqrt{3/2}=1.2247$ against the contraction's $2.0412$, and only the rows clear the target. **C14's conclusion stands, and its evidence needs replacing:** the honest statement is that one multiplier per index beats one multiplier for all indices, which is a fact about the multiplier structure and is visible in the marginals-only programme alone ($4.49$ per-index against $90.22$ uniform).

## §6 The balanced product, item 6

The argument is: the augmented programme adds constraints to the marginals-only programme, so its value at the balanced product spectrum is at most $\theta_0(n)$ by Given 6, and the true value is a floor, so it is at least $\theta_0(n)$.

**Both halves are valid, and the brief is right that the floor half needs the balanced product's own $T$ to be feasible.** In full: let $T^\star$ be the triangle tensor of the balanced product in its own eigenbasis. Then

1. $T^\star\ge0$, totally symmetric and hollow, by construction as $c^2_{\alpha\beta\gamma}$.
2. $T^\star$ satisfies the marginal, by Given 2, which holds at every index of any orthonormal basis of $\Lambda^2\mathbb R^n$.
3. $T^\star$ satisfies every row of (B), by Given 3, which is the diagonal of $W\#I=-W$ and carries no criticality hypothesis. This is the step the claim leaves implicit and it is the one that could have failed.
4. The programme's objective at $T^\star$ is $\sum\lambda^3+\tfrac12m_3(T^\star)$, which by Given 1 is the object's own $\theta$, namely $\theta_0(n)$.

Hence $\theta_0(n)\le V_{\text{aug}}\le V_{\text{marg}}=\theta_0(n)$ and both are equalities. The residual hypotheses are that the balanced product is a genuine element of $\mathcal W_n$ and that its $\theta$ is $\theta_0(n)$, both presupposed by Given 6 and not checkable from the brief. **C15 holds.**

Two remarks. First, the same four-step argument proves that **the augmented programme is exactly tight at every spectrum realised by an object whose true $\theta$ already saturates the marginals-only programme**, which is a general statement and not a property of the balanced product. Second, and against the claim's rhetorical weight, the argument is a floor argument: it shows the programme does not *lose* at the balanced product, and says nothing about spectra where the marginals-only programme is loose. §8 is exactly such a spectrum.

## §7 The kernel, item 7

**Does anything break where $\lambda=0$?** No. The kernel enters the derivation only through the $\gamma$ sums in $S_{12}=\sum_\gamma T_{12\gamma}$ and $S_{13}$, where $63$ of the terms have $\gamma$ in the kernel, and the only property used of them is nonnegativity. Weights $\lambda_\beta$ multiply the $\beta$ index alone, so kernel indices drop out of the $\beta$ sum in the row at index $1$ for the honest reason that their weight is zero.

**The rows at kernel indices are not vacuous.** At $k\ge4$, (B) reads $2\lambda$-weighted: $2c\,S_{k1}-c\,S_{k2}-c\,S_{k3}=-2\lambda_k=0$, that is

$$2S_{k1}=S_{k2}+S_{k3},$$

a homogeneous relation with content. The object satisfies it at each kind of kernel index:

| kernel index | $S_{k1}$ | $S_{k2}$ | $S_{k3}$ | row |
|---|---|---|---|---|
| $\varphi_{15}$ (and the other $31$ mixed $\varphi_{ip}$) | $\tfrac12$ | $\tfrac12$ | $\tfrac12$ | $1=1$ |
| $A_1^-=(\varphi_{12}-\varphi_{34})/\sqrt2$ (anti-self-dual) | $0$ | $0$ | $0$ | $0=0$ |
| $\varphi_{56}$ (and the other $\varphi_{pq}$) | $0$ | $0$ | $0$ | $0=0$ |

The first row uses $[A_1,\varphi_{15}]=\varphi_{25}/\sqrt2$, $[A_2,\varphi_{15}]=\varphi_{35}/\sqrt2$, $[A_3,\varphi_{15}]=\varphi_{45}/\sqrt2$, each of squared norm $\tfrac12$. The second uses that $\mathfrak{su}(2)_-$ commutes with $\mathfrak{su}(2)_+$, the third that disjoint index pairs commute.

**Is the marginal still satisfiable once (B) binds?** Yes, and by exhibition rather than by argument: the object's own $T$ has $S_{12}=S_{13}=S_{23}=2$, which is the pinned solution of §2, and $\sum_{k\ge4}S_{1k}=16$, so the marginal at index $1$ closes at exactly $2+2+16=20$. The binding of (B) costs $4$ of the $20$ and the kernel absorbs the remaining $16$ with room to spare.

## §8 What a counterexample looks like, item 8

**This item is answered in the affirmative, in closed form, at $n=12$.**

### 8.1 The two-block $\mathbb{CP}^2$ spectrum defeats the augmented programme

**Where to look, and why.** §2's lemma closes the whole three-nonzero-eigenvalue family at $\sqrt{3/2}$, because three (B) rows pin all three pair sums. Counting says the pinning is a coincidence of $m=3$: with $m$ nonzero eigenvalues there are $m$ rows and $\binom m2$ pair sums, so the rows determine the pair sums only at $m\le3$. At $m=4$ the tested families ($(a,a,a,-3a)$ and $(a,a,-a,-a)$) still gave nothing above the target, because their $e_3$ is negative or their positive triples are few. The construction that should hurt is one with **many positive-product triples**, which means one positive eigenvalue against two negatives repeated in blocks, and the smallest such case is two blocks.

**The spectrum.** At $n=12$, $N=66$, take

$$\lambda=(2d,-d,-d,\;2d,-d,-d,\;0^{60}),\qquad 12d^2=1,\ d=\tfrac1{\sqrt{12}} .$$

Trace-free and unit-norm. It is realised by an actual object: $W_{\mathbb{CP}^2}\oplus W_{\mathbb{CP}^2}$ on $\mathbb R^4\oplus\mathbb R^4\subset\mathbb R^{12}$, whose operator on $\Lambda^2\mathbb R^{12}$ carries $2d,-d,-d$ on each block's self-dual part and zero elsewhere. Ricci-flatness and first Bianchi pass to the direct sum and to the padding, so the spectrum is in the admissible set and cannot be dismissed as spurious.

**The true value.** Bivectors of different blocks commute, so the true $T$ has $T_{123}=T_{456}=2$ and nothing else among the six nonzero indices. Hence $\tfrac12m_3=3(2d^3\cdot2+2d^3\cdot2)=24d^3$, $\sum\lambda^3=2(8d^3)+4(-d^3)=12d^3$, and

$$\theta_{\text{true}}=36d^3=\frac3{\sqrt{12}}=\frac{\sqrt3}2=0.8660254 ,$$

comfortably under the target, as the conjecture requires.

**The programme's value.** Write $P=\{1,4\}$, $M=\{2,3,5,6\}$, $Z$ for the $60$ kernel indices. The positive-product triples are the $2\cdot\binom42=12$ triples with one index in $P$ and two in $M$, each with $p=2d^3$. Triples $PPM$ have $p=-4d^3$ and $MMM$ have $p=-d^3$. The spectrum's stabiliser is $S_2\times S_4\times S_{60}$, the programme is invariant under it, and averaging a feasible point over the group preserves feasibility and objective, so the optimum is attained on the block-symmetric ansatz. Take

$$t_{PMM}=1,\quad t_{PPM}=t_{MMM}=0,\quad t_{PPZ}=\tfrac1{15},\quad t_{PMZ}=0,\quad t_{MMZ}=\tfrac1{45},\quad t_{PZZ}=t_{MZZ}=0,\quad t_{ZZZ}=\tfrac{49}{8555}.$$

The pair sums are then $S_{PP}=4$, $S_{PM}=3$, $S_{MM}=\tfrac{10}3$, $S_{PZ}=S_{MZ}=\tfrac1{15}$, $S_{ZZ}=\tfrac{98}{295}$, and every constraint closes:

| constraint | value | required |
|---|---|---|
| marginal at $\alpha\in P$: $S_{PP}+4S_{PM}+60S_{PZ}$ | $4+12+4$ | $20$ |
| marginal at $\beta\in M$: $2S_{PM}+3S_{MM}+60S_{MZ}$ | $6+10+4$ | $20$ |
| marginal at $z\in Z$: $2S_{PZ}+4S_{MZ}+59S_{ZZ}$ | $\tfrac2{15}+\tfrac4{15}+\tfrac{98\cdot59}{295}$ | $20$ |
| (B) at $\alpha\in P$: $2S_{PP}-4S_{PM}$ (units of $d$) | $8-12=-4$ | $-2\lambda_1/d=-4$ |
| (B) at $\beta\in M$: $4S_{PM}-3S_{MM}$ | $12-10=2$ | $-2\lambda_2/d=2$ |
| (B) at $z\in Z$: $4S_{PZ}-4S_{MZ}$ | $0$ | $0$ |

All values are nonnegative. The objective is

$$\theta=12d^3+3\cdot12\cdot 2d^3\cdot 1=84d^3=\frac7{\sqrt{12}}=\frac{7\sqrt3}6=\boxed{2.0207259}.$$

**Against $\theta_0(12)=1.2360331$ this exceeds the target by a factor $1.635$, and it exceeds the object's true value by the exact factor $7/3$.**

**It is the exact LP value, not merely a feasible point.** In the symmetric ansatz, (B) at $P$ gives $S_{PP}=2S_{PM}-2$, the marginal at $P$ gives $6S_{PM}+60S_{PZ}=22$, and $S_{PZ}\ge t_{PPZ}=S_{PP}/60$ forces $8S_{PM}\le24$, so $S_{PM}\le3$ and $t_{PMM}\le S_{PM}/3\le1$. Allowing $t_{PPM}=h>0$ raises the cap to $S_{PM}\le3+h/2$ while costing $t_{PMM}\le(S_{PM}-h)/3\le1-h/6$, so $h=0$ is optimal and the value is exactly $7\sqrt3/6$.

**What this refutes.** The padded $W_{\mathbb{CP}^2}$ spectrum is the worst spectrum of the *marginals-only* programme, and (B) does collapse it to its true value. It is not the worst spectrum of the *augmented* programme: the two-block spectrum, which the marginals-only programme rated at only $132d^3=3.176$, is rated $2.021$ by the augmented programme and stays above the target. **The headline C16 is refuted as a statement about the programme, and the pattern the brief warned of has recurred for a third time: a relaxation tight where it was tested and loose elsewhere.**

**The failure grows with dimension.** The same two-block point at general $n$ gives $S_{PM}\le n/4$ from the same three inequalities and hence a programme value of at least $(n+2)/(4\sqrt3)$, which is $1.443$ at $n=8$, $2.021$ at $n=12$ and $3.175$ at $n=20$, while $\theta_0(n)$ rises only to $\sqrt2$. The $n=12$ value is verified exactly above, and the family is reported as indicated by the same construction rather than as checked at each $n$.

### 8.2 A second, structural exceedance, and the dimension threshold it forces

The derivation of §1 to §3 is independent of $n$: (B) at index $1$ gives $S_{12}+S_{13}=4$ in every dimension, so the augmented programme's value at the padded $W_{\mathbb{CP}^2}$ spectrum is **exactly $\sqrt{3/2}$ for every $n\ge4$**, the object's own $T$ being feasible there (at $n=4$ the marginal closes as $2+2=4=2(n-2)$ with the anti-self-dual kernel contributing nothing). Meanwhile

$$\theta_0(n)>\sqrt{3/2}\iff 4(n-1)(n-2)>3n^2\iff n^2-12n+8>0\iff n>6+2\sqrt7=11.2915 .$$

So the augmented programme exceeds $\theta_0(n)$ at the padded $W_{\mathbb{CP}^2}$ spectrum for **every $4\le n\le11$**, with $\theta_0(4)=\tfrac{\sqrt3}2=0.866$, $\theta_0(10)=1.2$ and $\theta_0(11)=\sqrt{180}/11=1.2197$ all below $1.2247$. This exceedance is not looseness in the relaxation: a genuine element of $\mathcal W_n$ sits above the target. **The consequence is a hypothesis the record must carry explicitly: $\theta_0(n)$ can be the target only for $n\ge12$, and the padded $W_{\mathbb{CP}^2}$ family makes that threshold sharp.** If the record already restricts to $n\ge12$ this is a scope note. If it states the target for all $n$, it is a defect.

### 8.3 What was done to look, and what remains unlooked

Analysis only, no sweeps. Four families were worked by hand in closed form: the full three-nonzero-eigenvalue family (closed at $\sqrt{3/2}$ by the §2 lemma, for all $n$); $(a,a,a,-3a)$ at $m=4$, where summing the three rows at the positive indices gives $S_{12}+S_{13}+S_{23}=6$ and hence $\theta\le-18a^3<0$; $(a,a,-a,-a)$ at $m=4$, which is feasible with small pair sums; and the $k$-block family of §8.1, which breaks at $k=2$. The counting argument that rows cannot pin pair sums beyond $m=3$ is what selected the last. Untouched: spectra with $m$ between $7$ and the balanced product's support, and the question of where between the two-block spectrum and the balanced product the programme's maximum over spectra actually sits. That last question would settle whether the augmented programme has any dimension in which it proves the conjecture, and the honest answer from this round is that at $n=12$ it does not.

## §9 Vacuity, item 9

**Infeasibility would make the line vacuous, and it does not arise at the spectra that matter.** At any spectrum realised by a genuine $W\in\mathcal W_n$ the object's own $T$ is feasible, by the four steps of §6, so the programme is non-vacuous exactly on the admissible set. The two spectra audited here are both realised, and both were exhibited with explicit feasible points (§3, §8.1).

Feasibility can fail once the spectrum is allowed off the admissible set, and the hypothesis that does the work is trace-freeness. Exhibit: $\lambda=(1,0,\dots,0)$. Then (B) at index $1$ reads $\sum_{\beta\gamma}\lambda_\beta T_{1\beta\gamma}=0$ on the left, since every $\beta\ne1$ has $\lambda_\beta=0$ and $\beta=1$ is hollow, against $-2\lambda_1=-2$ on the right. The programme is infeasible and would "prove" anything. Since $\mathcal W_n$ is trace-free, that spectrum is outside the admissible set, and **the record should state $\sum_\alpha\lambda_\alpha=0$ as a hypothesis of the augmented programme rather than leave it to the reader.**

Within the trace-free unit-norm set, no infeasible spectrum was found. At $m=2$ both rows give $S_{12}=2$ consistently; at $m=3$ the rows pin $S_{12}=S_{13}=S_{23}=2>0$ identically (§2), so no sign obstruction exists; at $m=4$ the family $(a,a,-a,-a)$ admits $S_{13}=S_{14}=S_{23}=S_{24}=1$, $S_{12}=S_{34}=0$. A general proof that the trace-free set is always feasible is not offered here and is not needed for the verdict.

## §10 What would make this round wrong, item 10

**The reading that carries the most weight is the content of "the programme".** §8.1's counterexample is a feasible point of $\{T\ge0,\ \text{total symmetry},\ \text{hollowness},\ \text{marginal at every index},\ (B)\ \text{at every index}\}$ and nothing more. That set is what Given 1 defines and what Given 4 describes when it calls the weaker programme the one "whose only input about $T$ is the marginal". If the record's augmented programme carries further constraints, the counterexample must be rechecked against them, and it will very likely fall to any constraint that remembers that $T_{\alpha\beta\gamma}=c^2_{\alpha\beta\gamma}$ for *real* structure constants: my point has $t_{123}=0$ with $t_{125}=1$, which no Lie algebra permits, since $T$ loses the Jacobi identity and every Gram condition on the $c$'s when it is formed by squaring. **To rule this out I checked that the two constraint families are exactly the two Givens, that Given 4 names the marginals-only programme by exclusion, and that the counterexample uses no property of $T$ beyond the five listed.** What I could not rule out, being cold on everything else, is that the record's I77 line adds a third family elsewhere in the findings.

Three further ways to be wrong, and what was done about each.

1. **The normalisation of $\#$, hence the $-2$ in (B).** The brief gives the relation but not the $\#$ convention, and the natural reading of $(W\#I)_{\alpha\alpha}$ returns $-\lambda_\alpha$ rather than $-2\lambda_\alpha$, so the record's $\#$ is twice mine. Resolved by anchoring on the object: the padded $W_{\mathbb{CP}^2}$ has $S_{12}=S_{13}=2$ from $[A_1,A_2]=\sqrt2A_3$, so its row at index $1$ evaluates to $-4c=-2\lambda_1$, and the constant is $-2$ as the brief states. The marginal $2(n-2)=20$ was anchored the same way, by summing $\|\operatorname{ad}A_1\|^2$ over $\Lambda^2\mathbb R^{12}$.
2. **The $\tfrac12$ in Given 1 and the wedge factor.** Resolved by two independent agreements: Given 1 with $T_{123}=2$ returns $\sqrt{3/2}$, which Given 5 records as the object's true $\theta$, and the classical dimension-four $W^\#$ gives $\langle W^\#,W\rangle=6\lambda_1\lambda_2\lambda_3=\tfrac12m_3$. A wrong factor here would have broken both.
3. **The realisability of the two-block spectrum.** If it were not in the admissible set the counterexample would be a statement about a relaxation of an empty problem. Resolved by exhibiting the object: the direct sum of two padded $W_{\mathbb{CP}^2}$'s is Ricci-flat, satisfies first Bianchi, and has exactly that spectrum after normalisation, with true $\theta=\sqrt3/2$.

The arithmetic of §5 and §8.1 was additionally confirmed on two exact-rational screens, reported as screens. Both matched the hand derivations they were run against.

## Verdict

**The first claim is VALID in every step, including its tightness. The second claim is PARTLY REFUTED. A new defect of larger consequence is confirmed: the augmented programme exceeds the target at a realisable spectrum at $n=12$, so the claim's framing of the padded $W_{\mathbb{CP}^2}$ spectrum as "the worst spectrum" cannot stand.**

| What | Status | Action the record needs |
|---|---|---|
| Three-line derivation, its tightness, and the comparison with $\theta_0(12)$ | **Valid, exact** | Amend the hollowness wording to name $\gamma=1$ and $\beta=\gamma$, and record that the three rows pin $S_{12}=S_{13}=S_{23}=2$, which is what makes the equality case rigid |
| "Its optimum at that same spectrum is $23.48$" | **Minor defect** | Replace with the exact $115/(2\sqrt6)=23.4743$ |
| "The contracted form of (B) is worse than useless", and the $5\times$ comparison | **Refuted** | Replace with: contracted (B) plus the marginals has exact LP value $5/\sqrt6=2.0412$, against the marginals-only $11/\sqrt6=4.4907$, and the $5\times$ gap is the cost of uniform multipliers, visible already in the marginals-only programme at $221/\sqrt6=90.22$ uniform against $4.49$ per-index. The conclusion "one multiplier per index" survives on this new evidence |
| "Relation (B) collapses **the worst spectrum**" | **Refuted as stated** | Narrow to the padded $W_{\mathbb{CP}^2}$ spectrum, and record the two-block spectrum at $7\sqrt3/6=2.0207$ against $\theta_0(12)=1.2360$ as the new worst known point of the augmented programme |
| The target $\theta_0(n)$ for $n\le11$ | **Scope defect** | State $n\ge12$ as a hypothesis, the threshold $n>6+2\sqrt7$ being sharp for the padded $W_{\mathbb{CP}^2}$ family |
| Trace-freeness of the spectrum | **Unstated hypothesis** | State $\sum_\alpha\lambda_\alpha=0$: without it the programme is infeasible at $\lambda=(1,0,\dots,0)$ |
| The balanced-product floor argument | **Valid** | Make step 3 explicit, that (B) holds on the object's own $T$ by Given 3, and note the argument is a floor argument that says nothing about loose spectra |

**The line's standing after this round.** Relation (B) is real, its per-index rows are the right form, and they are exactly tight at two spectra. They are not sufficient: the gap at the two-block spectrum is a factor $7/3$ over the truth and a factor $1.635$ over the target, and it widens linearly in $n$. A successor needs a constraint that remembers that $T$ is a square of real structure constants, since the two-block counterexample is defeated by nothing weaker.
