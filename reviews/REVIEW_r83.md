# Reviewer 83, Gate 2 on the three claimed derivations (cfdfb21, 1427bf4, d1427f6)

**No numerical checking was used.** Every conclusion is analytical, hand algebra plus symbolic manipulation in $p,q,k$; sympy only to expand and factor identities, never to evaluate a formula at data points and compare.

| Claim | Verdict |
|---|---|
| 1, dual-weight lemma | **CONFIRMED**, presentation OVERSTATED |
| 2 (balanced families | **CONFIRMED as algebra, OVERSTATED as derivation**), the $p=q=k$ specialisation of a closed form already in the record |
| 3, unbalanced families | **OVERSTATED, and REFUTED at its stated scope** |

## Claim 1, a real proof

Every step redone by hand and confirmed: the primal/dual pair (each triple sits in exactly three pair constraints, so the dual coefficient $2$ is the primal RHS); the objective convention over $\alpha<\beta<\gamma$, matching the file's own $\theta$-identity; that the pair cap $2$ is a genuine *relaxation*, since restricting $\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ to positive $\gamma$ only drops mass; feasibility $c\ge H/3$; and the dual value $(h/3)(s^2-u)$.

**The monotonicity worry is unfounded**, analytically: $\partial H/\partial\lambda_\alpha=3\lambda_\alpha^{-2}/(\sum1/\lambda)^2>0$ strictly, so ties give the same $h$ and small $\lambda$ depress $H$, the maximum is at the three largest, unconditionally.

**Two gaps.**
1. **The sharpness paragraph proves only the upper half.** It re-derives $\sum t\le k(k-1)/3$ from the pair caps; that is the bound again, not attainment. The missing witness: $t_{\alpha\beta\gamma}=2/(k-2)$ on every triple, whose pair marginal is $(k-2)\cdot2/(k-2)=2$, feasible, with $\sum t=\binom k3\cdot\frac2{k-2}=k(k-1)/3$. Equality then genuinely holds for $k\ge3$.
2. **Unstated hypothesis: at least three positives.** At $k\le2$ there are no triples, $M=0$, and $h$ is undefined.

**The factor-3 fix is incompletely propagated.** [target.md](../findings/target.md) still says the $(+{+}{+})$ block is covered by $z_{\alpha\beta}=\tfrac32h\lambda_\alpha\lambda_\beta$, which gives $2\sum z=\tfrac32h(s^2-u)$ and **contradicts the bound displayed two lines below it**. The displayed bound is the correct sharp one.

## The $c=6\lambda-3$ step, an identity presented as a fit

Both commits say it was obtained "by matching the $k=4$ blocks against the recorded $L_e$ spectrum". **It needs no matching.** For the cubic $P$, the sphere-constrained Hessian at a critical point is $6F_W-3\theta\,\mathrm{Id}$ on $W^\perp$, written in the project's own code at [p3b_local_separation.py](../scripts/p3b_local_separation.py), comment included. With $F$ linear in its subscript and $e=W/\theta$, $L_e=F_W/\theta$, so $c=6L_e-3$ in two lines. **Deriving it from a table row is fitting something already free.**

*Wrinkle:* the $c=+3$ block is $\langle W\rangle$ itself, not a sphere direction, so the tabulated blocks are the ambient $6F-3\theta$, not the constrained Hessian.

**Is $c=0$ really Morse–Bott degeneracy?** Yes, analytically: $\ker(\mathrm{Hess}|_{W^\perp})=E_{L_e}(\tfrac12)$, and differentiating $Q(W_t)=\theta W_t$ along the orbit puts the orbit tangent inside $E(\tfrac12)$, with $\dim=\binom n2-\binom p2-\binom q2=pq$ identically. Assumes the stabiliser is exactly $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$.

## Claims 2 and 3, right, derivable, and **already on record**

[fence-posts.md](../findings/fence-posts.md) carried, **before both commits**, the closed-form $L_e$ spectrum at $S^p\times S^q$: $1$ simple, $\tfrac12$ with multiplicity $pq$, $\lambda_m=\frac{m-2}{2(m-1)}$, $\pm\mu$ with $\mu=\frac{n-2}{2(p-1)(q-1)}$, and $0$ elsewhere. Applying $c=6\lambda-3$ with $n-2=(p-1)+(q-1)$ reproduces all five families exactly, verified symbolically, differences simplifying to $0$:

| block | $\lambda$ | $c$ | commit's name |
|---|---|---|---|
| $\langle W\rangle$ | $1$ | $+3$ |, |
| $\mathbb R^p\otimes\mathbb R^q$ | $\tfrac12$ | $0$ | orbit tangent |
| $S^2_0(\mathbb R^m)$ | $\frac{m-2}{2(m-1)}$ | $-3/(m-1)$ | $c_{A_m}$ |
| $\Lambda^2\otimes\Lambda^2$ | $+\mu$ | $-3+\frac3{p-1}+\frac3{q-1}$ | $c_B$ |
| $S^2_0\otimes S^2_0$ | $-\mu$ | $-3-\frac3{p-1}-\frac3{q-1}$ | $c_D$ |
| $\ker L_e$ | $0$ | $-3$ | $c_C$ |

The merges fall out of the rational functions, and the exception is an identity: $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}$, vanishing over integers $p,q\ge3$ exactly at $(3,3)$.

**So the algebra is right; the claim of novelty is not.** The sentence *"unconditionally: for $p,q\ge3$ with $(p,q)\ne(3,3)$ … $S^p\times S^q$ is Morse–Bott nondegenerate"* **predates both commits** and is backed by a genuine derivation (Nienhaus Prop 4.6 isotypic decomposition, multiplicity-freeness, Schur, plus the index proof). `1427bf4`'s ledger line *"unbalanced still verified rather than proved"* **contradicts a result standing four paragraphs below it in the same file**. Neither commit adds a derivation; they add a change of variable.

## REFUTATION, the $p=2$ scope

Both commits state the analysis over "integers $p,q\ge2$" and conclude *"every sphere product except $S^3\times S^3$"*. The ten summand dimensions sum to $\dim\mathrm{Weyl}_n$ as a **polynomial identity**, but that identity uses $W(x)=x(x+1)(x+2)(x-3)/12$, and $W(2)=-2$ while $\dim\mathrm{Weyl}_2=0$. Hence:

> **At $p=2$ the multiplicity list overcounts $\dim\mathrm{Weyl}_n$ by exactly $2$, for every $q$**, the analytic source of the record's own note that at $(2,2)$ the multiplicities sum to $14$ against $\dim\mathrm{Weyl}_4=10$.

And the conclusion fails there in substance: $c_B=6\mu-3=3/(q-1)>0$, i.e. $\lambda_{\max}=\mu>\tfrac12$, the $p=2$ exception **already recorded elsewhere in the same file**. The commits' criterion ("no family vanishes $\Rightarrow$ nondegenerate") is blind to it, because at $p=2$ the failure is a *positive* Hessian direction and loss of primitivity, not an extra kernel.

**Correct statement:** for $p,q\ge3$, every $S^p\times S^q$ other than $S^3\times S^3$ is nondegenerate. $p=2$ is outside the argument's scope.

## Residual soft spot in the underlying proof

Of the ten summand values, the record displays derivations for $1$, $\tfrac12$, $+\mu$ and the zeros. **$\lambda_m$ on $S^2_0(\mathbb R^m)$ and $-\mu$ on $S^2_0\otimes S^2_0$ (precisely $c_A$ and $c_D$), are listed as "known" with no in-text derivation.** The $\pm\mu$ assignment matters: swapping it moves the vanishing family from $\dim=c_pc_q$ to $\dim=s_ps_q$ and gives a kernel of $9+25=34$ at $(3,3)$ instead of $18$. The assignment is corroborated by the recorded $n=6$ kernel, **a measurement**. On the audit's own standard, that assignment is the one line still owed.

## Blunt answer

Claim 1 is a proof. Claims 2 and 3 are not dressed-up fits of *wrong* formulas (the formulas are right and a derivation exists) but the commits are **dressed-up fits of a result the project had already proved**, re-expressed through an identity that was already free, with the scope quietly widened past where the representation theory holds.
