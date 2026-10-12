# REVIEW r1685: L237's attainment at every even r by the doubled k-star (53bf7fd1), and r1683's repairs (47c3844d)

**Verdict: CONFIRMED WITH GAPS.** `attains_star` proves $\kappa_{2k}\ge2k+2$ in the record's normalisation for every $k\ge1$ and every $n\ge2k+2$, with the record's own doubled $k$-star, and together with `kappa_cap_norm` that makes the cap the supremum over exactly the record's range. `X_norm` is `L237SlotCounts.inner2_X_X` restated without `LinearOrder ι`, all twelve declarations rest on the standard three, and 47c3844d's two docstrings now cite sources that do state the values. One gap: the record's Statement clause $\kappa_1=1$ at $n=3$ appears in the L237 row neither as proved nor as owed, so the row's attainment ledger is complete except for that one value.

| # | Claim | Verdict |
|---|---|---|
| 1 | `attains_star` says $\kappa_{2k}\ge2k+2$ in the record's normalisation, non-vacuously, over $k\ge1$, $n\ge2k+2$ | **CONFIRMED** |
| 2 | `star` is the record's doubled $k$-star, its $2k$ slots are the plus slots of the centre–leaf pairs, eigenvalue $(k+1)^2$ | **CONFIRMED** (hand-checked at $k=1,2$ against `attains_two`, `attains_four`) |
| 3 | `X_norm` duplicates `inner2_X_X` without `LinearOrder` | **CONFIRMED** |
| 4a | L237 row, the new "at every even $r$" sentence | **CONFIRMED** |
| 4b | 47c3844d: `slot3_pm_edge`, `slot3_path_loop` docstrings and the row's source citations | **CONFIRMED** |
| 4c | Row: the repaired below-$n=r+2$ clause ($r=2,4$ owed, $r=6$ at $n=6,7$ the exception) | **CONFIRMED** |
| 4d | Row: every attainment clause of the record proved or owed | **CONFIRMED WITH GAPS** (G1) |
| 5 | Axioms: standard three only | **CONFIRMED** (12/12 clean, import present) |

One line: the Lean proves exactly the record's even-$r$ equality with the record's witness, and the row reports it faithfully, but the record's $\kappa_1=1$ at $n=3$ is missing from the row's proved and owed lists.

## Attack line 1: statement fidelity

- **Definition.** `Attains ι r κ` ([L237Attain.lean:41](../lean/HamiltonsCubic/Results/L237Attain.lean#L41)) asserts a skew $X$ with $\langle X,X\rangle>0$ and $r$ skew $y_j$ with $\langle y_i,y_j\rangle=\delta_{ij}$ and $\sum_j\lVert[X,y_j]\rVert^2=\kappa\langle X,X\rangle$. `inner2` is $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, which is $-\tfrac12\operatorname{tr}XY$ on skew matrices, the record's pairing. The ratio is invariant under scaling $X$, so this is $\kappa_r\ge\kappa$ in the record's definition ("the largest sum of $r$ top eigenvalues of $-\mathrm{ad}_X^2$ over unit $X$").
- **Range.** `attains_star {k} (hk : 0 < k) (h : 2 * k + 2 ≤ Fintype.card ι) : Attains ι (2 * k) (2 * k + 2)`. With $n=\lvert\iota\rvert$ this is the record's "every even $r=2k$ once $n\ge2k+2$".
- **Non-vacuity.** The hypotheses are met by `ι = Fin (2k+2)` for each $k\ge1$, and `Attains` is existential, so the conclusion carries content at every such $k$.
- **Equality.** The theorem is the lower bound. The upper bound is `kappa_cap_norm` at $r=2k\ge1$, which the file's docstring invokes. The row writes "$\kappa_{2k}=2k+2$" for `attains_star`, the same convention the row already uses for `attains_four` and `attains_six` and that r1683 accepted, with "$\kappa_r$ as a supremum" on the owed list.
- **Is $k\ge1$ needed?** Yes. At $k=0$ the sum over `Fin 0` is $0$, so `Attains ι 0 2` would need $2\langle X,X\rangle=0$, contradicting $\langle X,X\rangle>0$. The conclusion is false at $k=0$, and the star there is the zero matrix. The record's sentence is silent on $k=0$, and its Statement ranges over $X_1,\dots,X_r$ with $r\ge1$ implicit, as `kappa_cap` requires. Reading "every even $r$" as $r\ge2$ is the only reading under which the record is true, and it is the one the Lean takes.

## Attack line 2: the witness and its slots

- **Weights and blocks.** `star k e : NormalForm ι (k+1)` has blocks $(e_{2c},e_{2c+1})$, $c\le k$, with $s_0=k$ and $s_c=1$ for $c\ge1$ (`star_s0`, `star_ssucc`). All weights are positive, so "all one sign" holds. This is the record's doubled $k$-star: $k+1$ planes, centre weight $k$, $k$ leaves of weight $1$.
- **Index injectivity.** The `NormalForm` fields `hp`, `hq`, `hpq` follow from `e.injective` and `omega` on $2a=2b$, $2a+1=2b+1$, $2a\ne2b+1$. These are the conditions under which the $2k+2$ indices are distinct.
- **Slots.** `slot N c true` is $\varphi_{p_0p_c}-\varphi_{q_0q_c}$ and `slot N c false` is $\varphi_{p_0q_c}+\varphi_{q_0p_c}$ (`slot_true`, `slot_false`), which are L240's `S1` and `S2` at the pair $(0,c)$. `starSlot` indexes them by `Fin k × Bool` via `c ↦ c.succ`, so the $2k$ slots are the two plus slots of each centre–leaf pair, as the record says.
- **Eigenvalue.** `slot_plus_general` and `slot_plus2_general` ([L240SlotBasis.lean:88](../lean/HamiltonsCubic/Results/L240SlotBasis.lean#L88), [:187](../lean/HamiltonsCubic/Results/L240SlotBasis.lean#L187)) need only a normal form and $a\ne b$. At $a=0$, $b=c\ne0$ they give $(s_0+s_c)^2=(k+1)^2$.
- **Gram.** Within a pair, `pair_gram` gives $\langle S_1,S_1\rangle=\langle S_2,S_2\rangle=2$, $\langle S_1,S_2\rangle=0$. Across pairs $(0,c)\ne(0,d)$, `cross_comb` needs $0<c$, $0<d$, which `slot_gram` supplies from $c,d\ne0$.
- **Arithmetic.** `attains_of_scaled` asks for $\sum_j\lVert[X,Z_j]\rVert^2=2\kappa\langle X,X\rangle$ with $\langle Z_i,Z_j\rangle=2\delta_{ij}$. Left side: $2k\cdot2(k+1)^2=4k(k+1)^2$. Right side: $2(2k+2)(k^2+k)=4k(k+1)^2$. Equal.
- **Hand check (a screen).** At $k=1$ the star is $\varphi_{01}+\varphi_{23}$, `attains_two`'s `star1`. At $k=2$ it is $2\varphi_{01}+\varphi_{23}+\varphi_{45}$, `attains_four`'s `star2`, with the same four slots. Both agree with the r1683-audited witnesses.

## Attack line 3: X_norm

- **Statement.** `X_norm {m} (N : NormalForm ι m) : inner2 N.X N.X = ∑ c, N.s c ^ 2` and `inner2_X_X : inner2 N.X N.X = ∑ c, N.s c ^ 2` ([L237SlotCounts.lean:195](../lean/HamiltonsCubic/Results/L237SlotCounts.lean#L195)) are the same proposition. The only difference is the section variable `[LinearOrder ι]` that `inner2_X_X` carries from [L237SlotCounts.lean:19](../lean/HamiltonsCubic/Results/L237SlotCounts.lean#L19).
- **Proof.** Line for line the same: block orthonormality from `inner2_phi_phi`, `hp` and `hpq`, bilinearity through `inner2Form`, closed by `simp`. The final `simp [sq]` versus `simp [Finset.sum_ite_eq, sq]` is a tactic variation. The duplicate is sound and the docstring names its source.

## Attack line 4: docstrings and row

- **The new row sentence** matches the file: `attains_star`, $\kappa_{2k}=2k+2$ for $k\ge1$ and $n\ge2k+2$, `star` with $k+1$ blocks, `slot_eigen` from the two L240 lemmas, `slot_gram` from `pair_gram` and `cross_comb`, $\langle X,X\rangle=k^2+k$ from `X_norm`.
- **47c3844d's docstrings.** `slot3_pm_edge` now cites [r1122](REVIEW_r1122.md), whose line 68 reads "path and pm_edge `2+√2`". `slot3_path_loop` cites the L239/L240 block of [second-order.md](../findings/second-order.md), whose L239 paragraph ([:269](../findings/second-order.md#L269)) states "the exact maximum $2+\sqrt3$ being attained by the path with a kernel slot". Both citations hold, both values stay owed, and the relative links resolve from `lean/HamiltonsCubic/Results/`.
- **The below-$n=r+2$ clause.** The record after 344eb645 ([:236](../findings/second-order.md#L236)) reads "For $r=2,4$ the maximum below $n=r+2$ is smaller ($3+\sqrt5$ at $n=5$, $r=4$)", and "at $r=6$ the doubled triangle also attains it, already at $n=6$ and $7$". The row owes the values at $r=2,4$ and names $r=6$ at $n=6,7$ as the exception `attains_six` proves. Accurate.
- **Strictness.** Owed at odd $r\ge3$, with $r=1$ strict by `L31_cap` ($\kappa_1=2<3$). Accurate.
- **Ledger of attainment clauses.**

| Record clause | Row |
|---|---|
| $\kappa_1=2$, $\kappa_2=4$ at $n\ge4$ | proved, `attains_one` + `L31_cap_unit`, `attains_two` |
| $\kappa_2=2$ at $n=3$ | owed (below $n=r+2$, $r=2$) |
| $\kappa_1=1$ at $n=3$ | **absent** (G1) |
| $\kappa_4=6$, $\kappa_6=8$ at $n\ge6$ | proved, `attains_four`, `attains_six` |
| $\kappa_4=4$ at $n=4$, $3+\sqrt5$ at $n=5$ | owed (below $n=r+2$, $r=4$) |
| $\kappa_{2k}=2k+2$ at $n\ge2k+2$ | proved, `attains_star` |
| $r=6$ attained at $n=6,7$ by the triangle | proved, `attains_six` |
| strict at odd $r$ | $r=1$ proved, $r\ge3$ owed |

## Attack line 5: axioms

- `python3 scripts/misc/axiom_audit.py --only L237Star.lean` reports "12/12 clean -- resting on the standard three alone". [HamiltonsCubic.lean:745](../lean/HamiltonsCubic.lean#L745) imports the file.

## G1: κ₁ = 1 at n = 3 is neither proved nor owed

- **Where.** The record's Statement ([:232](../findings/second-order.md#L232)): "$\kappa_1,\kappa_2=2,4$ for $n\ge4$ ($1,2$ at $n=3$)".
- **What the row says.** The owed list covers "the values below $n=r+2$ at $r=2,4$", which takes in $\kappa_2=2$ at $n=3$. At $r=1$, $n=3$ equals $r+2$, so that item does not cover $\kappa_1=1$, and no other item does. `L31_cap_unit` gives only $\kappa_1\le2$, which is not the value at $n=3$.
- **Scope.** The omission predates both commits (r1683 read the $n=3$ values as consistent with the witnesses' ranges and did not ask whether they are owed). It falls under this brief's question 4 because the row now claims a complete attainment ledger.
- **Repair.** Add "$\kappa_1=1$ at $n=3$" to the owed list beside the below-$n=r+2$ values, or phrase that item as "the values at $n<4$ for $r\le2$ and $n=4,5$ for $r=4$".

## What would break the row, and what I did to look

- **The object.** A failure of the $2k$ slots to be orthonormal at the star, which happens exactly when two of its $2k+2$ indices coincide (a centre index equal to a leaf index makes `cross_comb`'s block hypotheses false and the slots collapse). For the equality half, an $X$ at $n\ge2k+2$ whose top $2k$ eigenvalues exceed $(2k+2)\langle X,X\rangle$ would break `kappa_cap_norm`, which is outside these commits.
- **What I did.** Checked that `star`'s injectivity fields follow from `e.injective` alone, that `slot_gram` feeds `cross_comb` its strict-order hypotheses from $c,d\ne0$, that the eigenvalue lemmas carry no hypothesis beyond $a\ne b$, recomputed $4k(k+1)^2$ on both sides, matched $k=1,2$ against the r1683-audited witnesses, confirmed the $k=0$ failure that makes `hk` necessary, and ran the axiom audit. The kernel accepted the file, and these checks confirm that what it accepted is the record's statement.
