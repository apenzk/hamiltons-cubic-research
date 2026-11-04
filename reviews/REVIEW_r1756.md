# REVIEW r1756: TorusLift.lean, L271_four_pos and L273Op's equality and g clauses against the record

**Verdict: CONFIRMED WITH OBSERVATIONS.** `H_torus_slice_op` and `H_small_even_op` are L277's H clause and L282 (1) at every torus-invariant self-adjoint operator, with the record's constants and ranges. `L271_four_pos` builds exactly `L271_eigen`'s $C_P$ and $C_Q$ and its `TorusSystem`, and `L273_F_eq_op`, `L273_g_ge_op` are L273 (1)'s equality case and $g\ge1/\sqrt m$. All six theorems carry only the standard three axioms. The observations are packaging: `L271_four_pos` omits two of `L271_eigen`'s hypotheses from its conclusion, `L273_g_ge_op` is a statement about the Gram weights of any operator, and no typed object meets `L271_four_pos`'s hypotheses.

Targets: [TorusLift.lean](../lean/HamiltonsCubic/Results/TorusLift.lean) (commit 47b50c13), `normSq2_pos_of_pair` and `L271_four_pos` in [L268Rep.lean](../lean/HamiltonsCubic/Results/L268Rep.lean) (commit 69595367), `L273_F_eq_op` and `L273_g_ge_op` in [L273Op.lean](../lean/HamiltonsCubic/Results/L273Op.lean) (commit e371e894), and the L271, L273, L277, L282 rows of [lean/INDEX.md](../lean/INDEX.md). Source: [findings/second-order.md](../findings/second-order.md), Lemmas L271, L273, L277, L282. Footing: analysis only. The one computation was a small check file run with `lake env lean` against the built oleans (`#print axioms`, four witness applications, one composition). It took seconds and built nothing.

| Claim | Verdict |
| --- | --- |
| A1. `H_torus_slice_op` is L277's "$F(C)\le\kappa\lVert C\rVert^3$ for every torus-invariant $C\in\mathop{\mathrm{Sym}}^2\mathfrak{so}(2m)$", $m\ge7$ | CONFIRMED |
| A2. `H_small_even_op` is L282 (1), every even $k=2m\le2M$, $M\ge7$, constant $\kappa_{2M}$ | CONFIRMED |
| A3. The INDEX note that L282 (2) stays over `torusOpOdd` | CONFIRMED |
| B1. `L271_four_pos`'s $C_P$, $C_Q$ are `L271_eigen`'s and the record's | CONFIRMED |
| B2. `L271_four_pos` supplies `L271_eigen`'s hypotheses and identifies $C$ with its `torusOp (Amu U V) U V` | CONFIRMED WITH OBSERVATIONS (O1) |
| B3. `normSq2_pos_of_pair` | CONFIRMED |
| C1. `L273_F_eq_op` is (1)'s equality case at every torus-invariant operator | CONFIRMED |
| C2. `L273_g_ge_op` is (1)'s $g\ge1/\sqrt m$ | CONFIRMED WITH OBSERVATIONS (O2) |
| C3. Together they close r1755 O1 | CONFIRMED |
| Axioms of all six theorems | CONFIRMED, `propext`, `Classical.choice`, `Quot.sound` |
| Objects meeting each hypothesis set | CONFIRMED for A and C, not exhibited for `L271_four_pos` (O3) |
| INDEX rows L271, L273, L277, L282 | CONFIRMED WITH OBSERVATIONS (O1) |

One line: the three statement sets are faithful to the record, and what remains is one missing conjunct in `L271_four_pos`'s conclusion, a generality note on `L273_g_ge_op`, and an untyped witness for L271 (4)'s hypotheses.

## The record

- **L277, Statement, verbatim:** *"For $m\ge7$ and real symmetric zero-diagonal $m\times m$ matrices $U,V$ with $\tfrac12(\lVert P\rVert^2+\lVert Q\rVert^2)=1$, $P=U+V$, $Q=U-V$, J1 holds: $\tfrac12(\mathop{\mathrm{tr}}P^3+\mathop{\mathrm{tr}}Q^3)+\lambda_m\big(\sum_id_i^2+\sum_{i\ne j}P_{ij}^2Q_{ij}^2\big)\le\lambda_m$. Hence (L273 (3)) $F(C)\le\kappa\lVert C\rVert^3$ for every torus-invariant $C\in\mathop{\mathrm{Sym}}^2\mathfrak{so}(2m)$, $\kappa=2(m-1)/\sqrt{m(2m-1)}$."*
- **L282, Statement, verbatim:** *"Let $M\ge7$ and $\kappa_{2M}=\tfrac{2(M-1)}{\sqrt{M(2M-1)}}$. (1) For $m\le M$, every torus-invariant $C\in\mathop{\mathrm{Sym}}^2\mathfrak{so}(2m)$ has $F(C)\le\kappa_{2M}\lVert C\rVert^3$. (2) For $m+1\le M$, every torus-invariant $C\in\mathop{\mathrm{Sym}}^2\mathfrak{so}(2m+1)$ has $F(C)\le\kappa_{2M}\lVert C\rVert^3$."*
- **L271 (4), opening, verbatim:** *"For $C\ne I/c$ (so $Q\ne0$ by (3)), with $C_P=(\mathop{\mathrm{diag}}d,\,U=V=\tfrac12P)$ and $C_Q=(A_{\mathrm{off}},\,U=-V=\tfrac12Q)$, orthogonal with sum $C$, the second eigenvalue of $C\#\cdot$ on $\mathop{\mathrm{span}}(C_P,C_Q)$ is ..."*, read in the context of (3), a torus-invariant positive-definite idempotent.
- **L273 (1), verbatim:** *"$F(X)\le3\lVert A\rVert g+T$, with equality when $A$ is a non-negative multiple of $A_\mu$, and $g\ge1/\sqrt m$"*, with $b^2=\tfrac12(\lVert P\rVert^2+\lVert Q\rVert^2)=1$, $g=\lVert A_\mu\rVert$, $T=\tfrac12(\mathop{\mathrm{tr}}P^3+\mathop{\mathrm{tr}}Q^3)$.

## A. TorusLift.lean

**What "torus-invariant" is.** Both theorems take `C : CurvOp2 (Fin k × Fin 2)`, a continuous linear map on `skewSub`, that is on $\mathfrak{so}(2k)$. `hsa` is symmetry for `inner2` $=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, so $C\in\mathop{\mathrm{Sym}}^2\mathfrak{so}(2k)$. `hT : ∀ x, derOp (cartS x) C = 0` says $[\mathop{\mathrm{ad}}_{J_x},C]=0$ for each $J_x=\varphi_{(x,0)(x,1)}$, the standard basis of the maximal torus's Lie algebra. The torus is connected, so commuting with its Lie algebra is invariance under the torus. That is the record's "every torus-invariant $C$", with no extra hypothesis.

**Constants and ranges.**

- `H_torus_slice_op`: $n\ge6$ with $m=n+1$, so $m\ge7$. The constant `2 * (((n+1:ℕ):ℝ) - 1) / √((n+1) * (2(n+1) - 1))` is $2(m-1)/\sqrt{m(2m-1)}$. `normSq2 C ^ (3/2)` is $\lVert C\rVert^3$ with `normSq2` the Hilbert–Schmidt norm over the orthonormal $\varphi_{ij}$, $i<j$ (r1684, r1755). This matches L277.
- `H_small_even_op`: $M\ge7$, $j+1\le M$, algebra $\mathfrak{so}(2(j+1))$, constant `kapE M` $=2(M-1)/\sqrt{M(2M-1)}=\kappa_{2M}$. As $j$ runs over $0,\dots,M-1$, $m=j+1$ runs over $1,\dots,M$, so every even $k=2m\in\{2,\dots,2M\}$ is covered. Only $k=0$ is absent, where $\mathfrak{so}(0)=0$ and the claim is empty. This is L282 (1) exactly.

**The composition.** Both proofs are `L268_rep` (r1754) followed by `H_torus_slice` or `H_small_even`, whose hypotheses `Aᵀ = A`, `IsPairWeights U`, `IsPairWeights V` are exactly the three side conjuncts `L268_rep` returns. The composition adds nothing and drops nothing.

**A3.** `H_small_odd` in [TorusEmbed.lean](../lean/HamiltonsCubic/Results/TorusEmbed.lean) is over `torusOpOdd A U V w`. Neither TorusEmbed.lean nor [OddTorus.lean](../lean/HamiltonsCubic/Results/OddTorus.lean) mentions `derOp` or `cartS`, so no odd analogue of `L268_rep` exists and the INDEX note "The odd case (2) stays over `torusOpOdd`, an odd analogue of `L268_rep` being unwritten" is accurate.

## B. normSq2_pos_of_pair and L271_four_pos

**B1, the pieces.** `L271_four_pos`'s third and fourth conjuncts are the norms of

- `torusOp (diagonal (dvec U V)) (½(U + V)) (½(U + V))`, which is the record's $C_P=(\mathop{\mathrm{diag}}d,\,U=V=\tfrac12P)$, and
- `torusOp (Amu U V - diagonal (dvec U V)) (½(U - V)) (-(½(U - V)))`, which is $C_Q=(A_{\mathrm{off}},\,U=-V=\tfrac12Q)$, since $A_{\mathrm{off}}=A_\mu-\mathop{\mathrm{diag}}d$ by `Amu`'s diagonal $d_i$,

with $U=$ `Uof C`, $V=$ `Vof C`. These are character for character the `CP` and `CQ` of `L271_eigen` in [L271Eigen.lean](../lean/HamiltonsCubic/Results/L271Eigen.lean). Summing the weights gives $U$ on $\varepsilon_i-\varepsilon_j$, $V$ on $\varepsilon_i+\varepsilon_j$ and Cartan block $A_\mu$, so $C_P+C_Q$ is the first conjunct's `torusOp (Amu U V) U V`, which is `L271_eigen`'s `C`.

**B2, the hypotheses.** `L271_eigen` takes `IsPairWeights U`, `IsPairWeights V`, `TorusSystem U V`, `0 < gP` and `0 < gQ`. `L271_four_pos` returns `TorusSystem`, both positivity facts and $C=$ `torusOp (Amu U V) U V`. It does not return `IsPairWeights (Uof C)` and `IsPairWeights (Vof C)`, which come from a second call to `L268_rep` on the same hypotheses (O1). The check file composes the three:

```lean
obtain ⟨hC, hsys, hP, hQ⟩ := L271_four_pos hm C hT hsa hidem hpd hne
obtain ⟨-, -, hU, hV⟩ := L268_rep C hT hsa
have := L271_eigen (Uof C) (Vof C) hU hV hsys hP hQ
```

and it typechecks. So nothing mathematical stands between a $T$-invariant self-adjoint positive-definite idempotent $C\ne I/(2(m-1))$, $m\ge3$, and `L271_eigen`'s conclusion at $C$, after rewriting with `hC`. The constant is right: $c=2(m-1)$ for $\mathfrak{so}(2m)$ (L268, `L268_uniform_iff`), so `hne` is the record's $C\ne I/c$. The record's "(so $Q\ne0$ by (3))" enters through `L271_other_idem`, and the positive-definiteness `hpd` and idempotency `hidem` are the context (3) and (4) are stated in.

**How the positivity is obtained.** At the pair $(i,j)$ with $U_{ij}\ne V_{ij}$ from `L271_other_idem`, the $C_Q$ weight is $\tfrac12(U_{ij}-V_{ij})\ne0$. The $C_P$ weight is $\tfrac12(U_{ij}+V_{ij})>0$ from `L268_full`'s positivity. `normSq2_pos_of_pair` then reads the norm through `normSq2_torusOp` as $\sum A^2+\sum_{k\ne l}(U_{kl}^2+V_{kl}^2)$ and bounds it below by one positive term. Its hypotheses are symmetric $U,V$, $i\ne j$ and $U_{ij}\ne0$, and the conclusion needs nothing else, so B3 stands.

## C. L273_F_eq_op and L273_g_ge_op

**C1.** The hypothesis `Aof C = s • Amu (Uof C) (Vof C)` with `0 ≤ s` is "$A$ is a non-negative multiple of $A_\mu$" at the Gram values of $C$ (`Aof C` is the Cartan block on the orthonormal $J_k$, r1755 Q3). The conclusion is equality in the same expression `L273_F_bound_op` bounds by: $3\lVert A\rVert_F\,\lVert A_\mu\rVert_F+\tfrac12(\mathop{\mathrm{tr}}P^3+\mathop{\mathrm{tr}}Q^3)$. The theorem has no $b=1$ hypothesis. Both sides are homogeneous of degree 3 under $(A,U,V)\mapsto t(A,U,V)$, so this is the record's clause without its normalisation, a harmless strengthening. The proof substitutes `L268_rep` into `L273Owed.L273_F_eq`, which is stated at `torusOp (s • Amu U V) U V`.

**C2.** `L273_g_ge_op` has only `hb`, the record's $b^2=1$ written in `Uof C`, `Vof C`, and concludes $1/\sqrt m\le\lVert A_\mu(\mathrm{Uof}\,C,\mathrm{Vof}\,C)\rVert_F$, which is $g\ge1/\sqrt m$. It drops `hT` and `hsa`, and is `L273_g_ge` at the Gram weights of an arbitrary `C` (O2). At a torus-invariant $C$ this is the record's clause. The argument ($\mathop{\mathrm{tr}}A_\mu=\sum_id_i=b^2=1$, then Cauchy–Schwarz on the diagonal) is valid for any weights, so the generality is genuine.

**C3.** r1755 O1 asked that the equality case and $g\ge1/\sqrt m$ reach the operator. Both now do, and the L273 row names them. Every clause of L273 (1) is typed at the operator.

## Axioms

```
'HamiltonsCubic.TorusLift.H_torus_slice_op' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.TorusLift.H_small_even_op' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L268Rep.normSq2_pos_of_pair' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L268Rep.L271_four_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L273Op.L273_F_eq_op' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L273Op.L273_g_ge_op' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## Objects meeting the hypotheses

- **`H_torus_slice_op`**: `idOp` on $\mathfrak{so}(14)$ ($n=6$), with `hT` by `ext X; simp [derOp]` and `hsa` by `simp [idOp]`, and the zero operator. Both typecheck. At `idOp` the bound holds with equality (r1755 Q6).
- **`H_small_even_op`**: the zero operator on $\mathfrak{so}(6)$ at $M=7$, $j=2$, typechecks. `idOp` works the same way.
- **`L273_F_eq_op`**: the zero operator on $\mathfrak{so}(6)$ with $s=0$, typechecks. The informative instance is $C=\alpha\,\mathrm{idOp}$, $\alpha>0$: then `Aof C` $=\alpha I_m$, `Uof C` $=$ `Vof C` $=\alpha(J-I)$, $A_\mu=2(m-1)\alpha^2I_m$, so $s=1/(2(m-1)\alpha)$, and equality is r1755's computation at $I$.
- **`L273_g_ge_op`**: $C=\alpha\,\mathrm{idOp}$ with $2m(m-1)\alpha^2=1$, where $g^2=4(m-1)^2\alpha^4m=1/m$, so equality holds.
- **`L271_four_pos`**: needs a $T$-invariant self-adjoint positive-definite idempotent other than $I/(2(m-1))$ at $m\ge3$. No such operator is typed (O3). A hand screen of the constant-weight family $U\equiv u$, $V\equiv v$ off the diagonal finds none: subtracting the two pair equations gives $(v^2-u^2)(4-(m-2)/u)=0$, so $v\ne u$ forces $u=(m-2)/4$, and then $2m\,v^2=1-(m-2)^2/2-(m-2)^3/8$, positive only at $m=3$, where $v=\tfrac14=u$. The record's L271 *What it gives* reports non-uniform positive solutions at $m=4,5$ (supported on two or three indices, L267's and the $\mathfrak{su}(3)$-seed), which would be witnesses. This review did not verify them.

## INDEX rows

- **L277**: names `H_torus_slice_op` and TorusLift.lean, and says "every torus-invariant $C$" is typed at the operator. Accurate.
- **L282**: names `H_small_even_op` for (1) on $\mathfrak{so}(2(j+1))$ and states that (2) stays over `torusOpOdd`. Accurate (A3).
- **L273**: names `L273_F_eq_op` and `L273_g_ge_op` and cites r1755 O1. Accurate. "At every such $C$ … on the unit root sphere" for `L273_g_ge_op` understates its generality (O2), which does no harm.
- **L271**: "(4)'s hypotheses in `L271_eigen` are one theorem, `L271_four_pos`" is one conjunct short: the pair-weight hypotheses come from `L268_rep` (O1). The same holds for `L271_four_pos`'s docstring ("the hypotheses `L271_eigen` takes").

## Overall verdict: CONFIRMED WITH OBSERVATIONS

1. **O1: `L271_four_pos` returns four of `L271_eigen`'s six inputs, plus the identification of $C$.** `IsPairWeights (Uof C)` and `IsPairWeights (Vof C)` come from a separate `L268_rep` call. The three-line composition typechecks, so the gap is packaging. Adding the two conjuncts, or stating `L271_eigen_op` at $C$ directly, would make the L271 row's "one theorem" literally true.
2. **O2: `L273_g_ge_op` holds for every `CurvOp2` $C$.** It carries no `hT` or `hsa`, and is a statement about the Gram weights `Uof C`, `Vof C`. That is stronger than the record's clause and correct, but the `_op` name and the row's "at every such $C$" suggest the invariance hypotheses it does not need.
3. **O3: no typed object meets `L271_four_pos`'s hypotheses.** The constant-weight family gives only $I/c$. The record's screened non-uniform solutions at $m=4,5$ are the candidates. The statement is faithful either way, since the record's (4) is conditioned on the same $C\ne I/c$.

**Falsifiers.**

- `H_torus_slice_op`: for some $m\ge7$, a self-adjoint $C$ on $\mathfrak{so}(2m)$ commuting with every $\mathop{\mathrm{ad}}_{J_x}$ and $F(C)>\tfrac{2(m-1)}{\sqrt{m(2m-1)}}\lVert C\rVert^3$.
- `H_small_even_op`: for some $M\ge7$ and $1\le m\le M$, such a $C$ on $\mathfrak{so}(2m)$ with $F(C)>\kappa_{2M}\lVert C\rVert^3$.
- `normSq2_pos_of_pair`: symmetric $U,V$ with $U_{ij}\ne0$ for some $i\ne j$ and `normSq2 (torusOp A U V) = 0`.
- `L271_four_pos`: a $T$-invariant self-adjoint positive-definite idempotent $C\ne I/(2(m-1))$, $m\ge3$, whose `Uof C`, `Vof C` fail `TorusSystem`, or with $C_P=0$ or $C_Q=0$ (equivalently $U+V\equiv0$ or $U\equiv V$ off the diagonal).
- `L273_F_eq_op`: such a torus-invariant $C$ with `Aof C` $=sA_\mu$, $s\ge0$, and $F(C)$ strictly below $3\lVert A\rVert g+T$.
- `L273_g_ge_op`: weights with $\tfrac12(\lVert P\rVert^2+\lVert Q\rVert^2)=1$ and $\lVert A_\mu\rVert<1/\sqrt m$, impossible since $\mathop{\mathrm{tr}}A_\mu=1$ and $A_\mu$ has $m$ diagonal entries.
