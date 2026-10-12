# REVIEW r1755: L273Op.lean and the L273 row's promotion to proved

**Verdict: CONFIRMED WITH OBSERVATIONS.** `L273_J1_op` is the record's L273 (3) at every torus-invariant self-adjoint operator, with J1 exactly the record's J1, and `L273_F_bound_op` is the inequality of (1) at every such operator. Both carry only the standard three axioms. With L273Owed and I117Statements every clause of (1), (2) and (3) is typed, so "proved" stands. Two clauses of (1) are typed on the torus family rather than at the operator, and (2)'s minimum $\Psi_\kappa$ is typed in closed form.

Target: [L273Op.lean](../lean/HamiltonsCubic/Results/L273Op.lean) (commit 7bcd38dc) and the L273 row of [lean/INDEX.md](../lean/INDEX.md). Source: [findings/second-order.md](../findings/second-order.md), Lemma L273. Footing: analysis only. The one computation was a small check file run with `lake env lean` against the built oleans, with `#print axioms` and the instance at the identity. It took seconds, built nothing and has been deleted.

| Claim | Verdict |
| --- | --- |
| J1 in `L273_J1_op` is the record's J1 on the unit root sphere, over all pair weights | CONFIRMED, identical and neither stronger nor weaker |
| The conclusion of `L273_J1_op` is (3), with the record's $F$ and $\lVert\cdot\rVert$ | CONFIRMED, tight at $I$ |
| `L273_F_bound_op` is the inequality of (1) | CONFIRMED |
| Every clause of (1), (2) and (3) is typed, so "proved" is justified | CONFIRMED WITH OBSERVATIONS (O1 to O3) |
| Axioms of both theorems | CONFIRMED, `propext`, `Classical.choice`, `Quot.sound` |
| The instance at $I$ | CONFIRMED, both theorems hold with equality there |

One line: L273Op composes `L268_rep` with the two torus-family theorems correctly, the hypotheses and constants are the record's, and the promotion stands with three wording and packaging observations.

## The record

Lemma L273, Statement, verbatim: *"In L271's coordinates let $X=(A,P,Q)$ be torus-invariant with $b^2=\tfrac12(\lVert P\rVert^2+\lVert Q\rVert^2)=1$, $g=\lVert A_\mu\rVert$ and $T=\tfrac12(\operatorname{tr}P^3+\operatorname{tr}Q^3)$, and put $\kappa=c/\sqrt N=\tfrac{2(m-1)}{\sqrt{m(2m-1)}}$, $\lambda_m=\tfrac{\sqrt{2m}\,(m-2)}{(m-1)^{3/2}}$ and $\Psi_\kappa(g)=\min_{a\ge0}\big(\kappa(1+a^2)^{3/2}-3ag\big)$. (1) $F(X)\le3\lVert A\rVert g+T$, with equality when $A$ is a non-negative multiple of $A_\mu$, and $g\ge1/\sqrt m$. (2) For $m\ge5$, $\lambda_m(1-g^2)\le\Psi_\kappa(g)$ for every $g\ge1/\sqrt m$, with equality at $g=1/\sqrt m$; at $m=4$ it fails for $g$ just above $1/\sqrt m$. (3) Hence for $m\ge5$, $\textbf{(J1)}\ T+\lambda_m\,g^2\le\lambda_m$ whenever $b=1$ implies H on the torus slice: $F(X)\le\kappa\lVert X\rVert^3$ for every torus-invariant $X\in\operatorname{Sym}^2\mathfrak{so}(2m)$."*

J1 is defined only there (line 556). L277's proof reuses the same quantities.

## Q1. The J1 hypothesis

The elaborated signature (printed with coercions) is: for all `U V` with `IsPairWeights U`, `IsPairWeights V` (symmetric, zero diagonal, any sign) and $\tfrac12\big(\sum_{ij}(U+V)_{ij}^2+\sum_{ij}(U-V)_{ij}^2\big)=1$,
$$\tfrac12\big(\operatorname{tr}(U+V)^3+\operatorname{tr}(U-V)^3\big)+\lambda_m\Big(\sum_id_i^2+\sum_{i\ne j}\big((U+V)_{ij}(U-V)_{ij}\big)^2\Big)\le\lambda_m,$$
with $\lambda_m$ written $\sqrt{2m}(m-2)/((m-1)\sqrt{m-1})$ over real casts of $m$.

- **Term by term.** $P=U+V$ and $Q=U-V$ are L271's. The constraint is $b^2=1$ with Frobenius norms over ordered pairs, the normalisation of `L271_norm` ($\lVert C\rVert^2=\lVert A\rVert^2+\tfrac12\lVert P\rVert^2+\tfrac12\lVert Q\rVert^2$). The record's proof uses the same normalisation: $\operatorname{tr}A_\mu=\sum_id_i=b^2$, and `sum_dvec` gives the same identity. The bracket is $g^2=\lVert A_\mu\rVert^2$ by `Amu_sq`, since $(A_\mu)_{ii}=d_i$ and $(A_\mu)_{ij}=V_{ij}^2-U_{ij}^2=-P_{ij}Q_{ij}$. The first term is $T$.
- **Quantifier.** The record's (3) concludes for every torus-invariant $X$, whose root weights $\mu_\alpha$ are arbitrary reals. So J1 "whenever $b=1$" ranges over all real pair weights. $(U,V)\mapsto(P,Q)$ is a bijection of symmetric zero-diagonal pairs. The hypothesis is therefore the record's J1 exactly, neither stronger nor weaker. It is also the form `J1_holds` proves for $m\ge7$ (L277).

## Q2. The conclusion of L273_J1_op

`Ftri C C C ≤ 2(m-1)/√(m(2m-1)) · normSq2 C ^ (3/2)`, all in $\mathbb R$.

- $\kappa$ is the record's constant. `normSq2 C` is $\lVert C\rVert^2$ in L271's normalisation (`L271_norm`, through `L268_rep`), and `normSq2 C ≥ 0`, so the real power is $\lVert C\rVert^3$.
- `Ftri` is the record's $F(X)=\langle X\#X,X\rangle$. The check file proves `Ftri idOp idOp idOp = (2m - 2) · normSq2 idOp` from `Ftri_sharp` and `sharpMapCL_id`, and `normSq2_idOp_torus` gives $N=m(2m-1)$. So $F(I)/\lVert I\rVert^3=c/\sqrt N=\kappa$, and the conclusion is tight at $I$, as H is.
- Torus invariance is `derOp (cartS x) C = 0` for every Cartan generator $J_x=e_{2x-1}\wedge e_{2x}$, the infinitesimal form of commuting with the torus. Self-adjointness for `inner2` is membership in $\operatorname{Sym}^2$.

## Q3. L273_F_bound_op

The statement is `Ftri C C C ≤ 3 √(∑ Aof C ij²) · √(∑ Amu (Uof C) (Vof C) ij²) + ½(tr P³ + tr Q³)` with $P,Q$ from `Uof C`, `Vof C`.

- `Aof C` is the Gram matrix $\langle CJ_k,J_l\rangle$ on the Cartan basis `cartS`, which is `inner2`-orthonormal. So $\sqrt{\sum A_{ij}^2}$ is the Frobenius norm of the Cartan block, the $\lVert A\rVert$ of `L271_norm`.
- `Uof C` and `Vof C` are the weights on the unit root vectors `rootS i j 0` and `rootS i j 2`. `L268_rep` identifies them with the $U,V$ of the representation. The second factor is $g$ and the last term is $T$.
- It is (1)'s inequality with no normalisation $b=1$, which is correct: (1)'s inequality is homogeneous and the record states it before normalising.

## Q4. Is the row fully typed?

- **(1), inequality:** `L273_F_bound` on the family and `L273_F_bound_op` at every operator.
- **(1), equality at $A=sA_\mu$, $s\ge0$:** `L273_F_eq`, on `torusOp (s • Amu U V) U V`. By `L268_rep` this covers every operator whose Cartan block is $sA_\mu$ of its own weights.
- **(1), $g\ge1/\sqrt m$ at $b=1$:** `L273_g_ge`, on the weights, from $\sum_id_i=1$ and Cauchy–Schwarz.
- **(2), the bound:** `psi_bound`, $3ag+\lambda_m(1-g^2)\le\kappa(1+a^2)^{3/2}$ for all $a\ge0$, $g\ge1/\sqrt m$, $m\ge5$. Over all $a\ge0$ this is $\lambda_m(1-g^2)\le\Psi_\kappa(g)$, the minimum being an infimum of the same family.
- **(2), equality at $g=1/\sqrt m$:** `psi_min`, `IsLeast` of the function under the minimum over $a\ge0$ at $g_0$ with value $\lambda_m(1-1/m)$, which is $\Psi_\kappa(g_0)=\lambda_m(1-g_0^2)$ with $\Psi$ unfolded.
- **(2), failure at $m=4$:** `psi_fails` for every real $2<m<5$, covering $m=4$. It exhibits $a_0$ with $\kappa(1+a_0^2)^{3/2}-3a_0g<\lambda_m(1-g^2)$ on a non-empty interval just above $g_0$. Since $\Psi_\kappa(g)$ is at most that value, the failure follows from the definition alone.
- **(3):** `L273_J1_implies_H` on the family and `L273_J1_op` at every operator.

Every clause has a theorem, so "proved" is justified. The observations are packaging and wording.

## Q5. Axioms

```
'HamiltonsCubic.L273Op.L273_J1_op' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L273Op.L273_F_bound_op' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## Q6. The object at the identity

$C=\mathrm{idOp}$ satisfies both hypotheses: `derOp (cartS x) idOp = 0` by `simp [derOp_apply]`, and self-adjointness by `rfl`. Both applications typecheck in the check file. By `idOp_eq_torusOp`, $\mathrm{idOp}$ is `torusOp 1 onesOff onesOff`, so $A=I_m$, $U=V=J-I$, $P=2(J-I)$, $Q=0$.

- **`L273_F_bound_op` returns** $F(I)\le3\cdot\sqrt m\cdot2(m-1)\sqrt m+4m(m-1)(m-2)=2m(m-1)(2m-1)$ by hand. Here $A_\mu=2(m-1)I_m$ and $\operatorname{tr}(J-I)^3=(m-1)^3-(m-1)$. The left side is $cN=2(m-1)\,m(2m-1)$, so equality holds, as (1)'s equality case predicts ($A=I_m$ is $A_\mu/(2(m-1))$).
- **`L273_J1_op` returns**, given J1 at $m\ge5$, $F(I)\le\kappa(m(2m-1))^{3/2}$, which holds with equality.

## Overall verdict: CONFIRMED WITH OBSERVATIONS

1. **O1: "(1) at every such C" names only (1)'s inequality.** The L273Op docstring and the INDEX sentence "(1) and (3) at every torus-invariant operator are PROVED" should say "(1)'s bound". The equality case (`L273_F_eq`) is typed on `torusOp`, and $g\ge1/\sqrt m$ (`L273_g_ge`) on the weights. Both reach every operator through `L268_rep`, a one-line substitution that no theorem states.
2. **O2: $\Psi_\kappa$ is typed in closed form ([r1737](REVIEW_r1737.md) O1, still current).** `psi_bound` and `psi_min` are (2) with the minimum unfolded. `psi_fails` gives the failure through one value of the minimised function, and the row says so accurately.
3. **O3: for $m=5,6$, `L273_J1_op` is an implication from a conjecture.** This is faithful to (3), which is an implication. H on the torus slice unconditionally is `H_torus_slice` for $m\ge7$ only, and the row's "Not stated: J1 itself" sentence could name that range beside L277.

**Falsifiers.**

- `L273_J1_op`: at some $m\ge5$ where J1 holds, a self-adjoint $C$ commuting with every $\operatorname{ad}_{J_x}$ with $F(C)>\kappa\lVert C\rVert^3$. The record's $m=4$ $\Lambda^2_+$ point ($F/\lVert X\rVert^3=2/\sqrt3>\kappa_4$) shows why the hypothesis $m\ge5$ is needed.
- `L273_F_bound_op`: such a $C$ with $F(C)>3\lVert A\rVert g+T$. That would contradict Cauchy–Schwarz on $3\langle A,A_\mu\rangle$ in L271 (1).
