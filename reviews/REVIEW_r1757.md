# REVIEW r1757: OddRep.lean, L280's representation and L281, L282 (2) at every torus-invariant operator, against the record

**Verdict: CONFIRMED WITH OBSERVATIONS.** `L280_rep` is the first sentence of L280's Statement: every self-adjoint operator on $\mathfrak{so}(2m+1)$ commuting with each $\mathop{\mathrm{ad}}_{J_x}$ equals `torusOpOdd A U V w`, which is $A\oplus\bigoplus_\alpha\mu_\alpha I_{R_\alpha}$ over the long roots $\varepsilon_i\pm\varepsilon_j$ and the short roots $\varepsilon_i$, with $w_i=\mu_{\varepsilon_i}$ on the record's $R_{\varepsilon_i}$. `H_torus_slice_odd_op` and `H_small_odd_op` are L281 and L282 (2) with the record's constants and ranges. `L271_four_pos` now carries both `IsPairWeights` conjuncts. All four theorems carry only the standard three axioms, and the identity operator on $\mathfrak{so}(2m+1)$ meets `L280_rep`'s hypotheses. The observations are packaging only.

Targets: [OddRep.lean](../lean/HamiltonsCubic/Results/OddRep.lean) (commit d75faa96), the definitions `torusOpOdd`, `extOp`, `shortOp`, `shortW`, `embedL`, `restrictL` in [OddTorus.lean](../lean/HamiltonsCubic/Results/OddTorus.lean), `L271_four_pos` in [L268Rep.lean](../lean/HamiltonsCubic/Results/L268Rep.lean), and the L271, L273, L280, L281, L282 rows of [lean/INDEX.md](../lean/INDEX.md). Source: [findings/second-order.md](../findings/second-order.md), Lemmas L280, L281, L282. Footing: analysis only. The one computation was a small check file run with `lake env lean` against the built oleans (`#print axioms`, one witness application, four one-line definitional checks). It took seconds and built nothing.

| Claim | Verdict |
| --- | --- |
| Q1a. `derOp (JO x) C = 0` for all `x`, `JO x = embedL (cartS x)`, is torus invariance on $\mathfrak{so}(2m+1)$ | CONFIRMED |
| Q1b. `inner2`-self-adjointness is "symmetric" | CONFIRMED |
| Q2. `torusOpOdd A U V w` is $A\oplus\bigoplus_\alpha\mu_\alpha I_{R_\alpha}$ with $w_i=\mu_{\varepsilon_i}$, `shortOp` and `extOp` acting as the record's $S$ and $E$ | CONFIRMED |
| Q3. `wOf C i` is the unit-normalised weight on $R_{\varepsilon_i}$ | CONFIRMED |
| L280_rep. The representation, with $A$ symmetric and $U$, $V$ pair weights | CONFIRMED |
| Q4a. `H_torus_slice_odd_op` is L281 | CONFIRMED |
| Q4b. `H_small_odd_op` is L282 (2) | CONFIRMED WITH OBSERVATIONS (O1) |
| Supporting lemmas `restrict_C_sv`, `C_embed_old`, `comp0_inv`, `comp0_sa`, `C_sv`, `skew_zero_of_phi` | CONFIRMED |
| `L271_four_pos` carries `IsPairWeights` for both weights (r1756 O1) | CONFIRMED |
| Q5. Axioms of `L280_rep`, `H_torus_slice_odd_op`, `H_small_odd_op`, `L271_four_pos` | CONFIRMED, `propext`, `Classical.choice`, `Quot.sound` |
| Q6. An object meeting `L280_rep`'s hypotheses | CONFIRMED, the identity, with $w\equiv1$ |
| Q7. INDEX rows L271, L273, L280, L281, L282 | CONFIRMED WITH OBSERVATIONS (O2) |

One line: the odd representation closes the prose clause of L280 faithfully, and the lifts of L281 and L282 (2) through it state exactly the record's bounds.

## The record

- **L280, Statement, verbatim:** *"On $\mathfrak{so}(2m+1)$ with $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, Cartan $\mathop{\mathrm{span}}(e_{2k-1}\wedge e_{2k})$ and short root planes $R_{\varepsilon_i}=\mathop{\mathrm{span}}\{e_{2i-1}\wedge e_{2m+1},\,e_{2i}\wedge e_{2m+1}\}$, every torus-invariant symmetric $C$ is $A\oplus\bigoplus_\alpha\mu_\alpha I_{R_\alpha}$. With $U_{ij}=\mu_{\varepsilon_i-\varepsilon_j}$, $V_{ij}=\mu_{\varepsilon_i+\varepsilon_j}$, $w_i=\mu_{\varepsilon_i}$, $P=U+V$, $Q=U-V$ and $d_i=\sum_l(U_{il}^2+V_{il}^2)$, $\lVert C\rVert^2=\lVert A\rVert^2+\lVert U\rVert^2+\lVert V\rVert^2+2\lVert w\rVert^2,\ F(C)=3\sum_iA_{ii}(d_i+w_i^2)-3\sum_{i\ne j}A_{ij}P_{ij}Q_{ij}+\tfrac12(\mathop{\mathrm{tr}}P^3+\mathop{\mathrm{tr}}Q^3)+3\,w^{\mathsf T}Pw$."*
- **L281, Statement, verbatim:** *"For $m\ge7$ and every torus-invariant $C\in\mathop{\mathrm{Sym}}^2\mathfrak{so}(2m+1)$, $F(C)\le\kappa\lVert C\rVert^3$ with $\kappa=\tfrac{2m-1}{\sqrt{m(2m+1)}}=\tfrac{n-2}{\sqrt{\dim\mathfrak{so}(n)}}$, $n=2m+1$: statement H on the torus slice of $\mathfrak{so}(n)$ at odd $n\ge15$."*
- **L282, Statement, verbatim:** *"Let $M\ge7$ and $\kappa_{2M}=\tfrac{2(M-1)}{\sqrt{M(2M-1)}}$. (1) For $m\le M$, every torus-invariant $C\in\mathop{\mathrm{Sym}}^2\mathfrak{so}(2m)$ has $F(C)\le\kappa_{2M}\lVert C\rVert^3$. (2) For $m+1\le M$, every torus-invariant $C\in\mathop{\mathrm{Sym}}^2\mathfrak{so}(2m+1)$ has $F(C)\le\kappa_{2M}\lVert C\rVert^3$."*

## Q1: the hypotheses

- **Torus invariance.** The index is `Option (Fin m × Fin 2)`, `some (i, c)` standing for $e_{2i-1+c}$ and `none` for $e_{2m+1}$. `JO x = embedL (cartS x)`, and `JO_eq` proves it is `phiS (some (x, 0)) (some (x, 1))`, the record's $e_{2x-1}\wedge e_{2x}$. The maximal torus of $SO(2m+1)$ is the $SO(2)^m$ of $SO(2m)$ fixing $e_{2m+1}$, its Lie algebra is the span of these $J_x$, and since the torus is connected, commuting with $\mathop{\mathrm{Ad}}_t$ for every $t$ in it is equivalent to commuting with every $\mathop{\mathrm{ad}}_{J_x}$. `derOp X R = adS X ∘ R - R ∘ adS X`, so `∀ x, derOp (JO x) C = 0` is that commutation for a basis of the Cartan, which by linearity (`derOp_add_leftG`) is all of it.
- **Symmetry.** `inner2 X Y = ½ tr(XᵀY)` is the record's inner product, and the hypothesis `hsa` is self-adjointness of $C$ for it on `skewSub`, which is membership of $\mathop{\mathrm{Sym}}^2\mathfrak{so}(2m+1)$ under the metric identification. The printed signature of `L280_rep` has exactly these two hypotheses and no others.

## Q2: the operator

- `torusOpOdd A U V w = extOp (torusOp A U V) + shortOp w`. `torusOp` is L271's operator on $\mathfrak{so}(2m)$ with `U` on the $\varepsilon_i-\varepsilon_j$ planes and `V` on the $\varepsilon_i+\varepsilon_j$ planes, reviewed against the record in r1754 and r1756.
- `extOp R X = embedL (R (restrictL X))`. For `X = sv p = e_p ∧ e_none`, `restrictL X = 0` (`restrictL_phi_none_r`), so `extOp` kills $\mathfrak p=\mathop{\mathrm{span}}(e_a\wedge e_{2m+1})$ and acts as $R$ on the old block. Both facts were checked in the check file.
- `shortW w` is $w_{p.1}$ on the entries `(some p, none)` and `(none, some p)` and $0$ elsewhere, and `shortOp w` multiplies entrywise by it. So `shortOp w (sv (i, c)) = w_i • sv (i, c)` (`shortOp_sv`) and `shortOp w (embedL Y) = 0` (`shortOp_kills_old`), both rechecked. With `(i, 0)`, `(i, 1)` for $e_{2i-1}$, $e_{2i}$, the plane where `shortOp` acts by $w_i$ is the record's $R_{\varepsilon_i}$.
- So `torusOpOdd` is the record's $E+S$, $E$ the Cartan and long-root part on $\mathfrak{so}(2m)$ extended by zero and $S=\bigoplus_iw_iI_{R_{\varepsilon_i}}$, which is $A\oplus\bigoplus_\alpha\mu_\alpha I_{R_\alpha}$ over all roots of $B_m$.

## Q3: the weight

`wOf C i = inner2 (C (sv (i, 0))) (sv (i, 0))`, and `inner2_sv_sv` proves `inner2 (sv p) (sv q) = if p = q then 1 else 0`, so the short vectors are orthonormal and `wOf C i` is the diagonal entry of $C$ on a unit vector of $R_{\varepsilon_i}$. `short_diag` gives the same value on `sv (i, 1)`, `short_rot` the vanishing cross term, and `C_sv` assembles `C (sv (i, c)) = wOf C i • sv (i, c)`. The check file confirms `wOf id i = 1`.

## L280_rep and its supports

- The conclusion is `C = torusOpOdd (Aof (comp0 C)) (Uof (comp0 C)) (Vof (comp0 C)) (wOf C)` with `Aof (comp0 C)` symmetric and `IsPairWeights` for `Uof (comp0 C)` and `Vof (comp0 C)`: the record's "every torus-invariant symmetric $C$ is $A\oplus\bigoplus_\alpha\mu_\alpha I_{R_\alpha}$", with the data of the decomposition named as Gram values, which is stronger than an existential.
- `restrict_C_sv` (no $\mathfrak{so}(2m)$ component in `C (sv p)`) separates by the eigenvalues of $\mathop{\mathrm{ad}}_{J_i}^2$ and $\mathop{\mathrm{ad}}_{J_k+J_l}^2$, where the short vector has eigenvalue $-1$ and the target $0$ or $-4$. `C_embed_old` gets the converse block from self-adjointness. `comp0_inv` and `comp0_sa` hand the $\mathfrak{so}(2m)$ block to `L268_rep`, and `skew_zero_of_phi` closes by coordinates. Each statement says what its name says and nothing more hides in a hypothesis.
- Symmetry is used where it must be: an operator such as $\mathop{\mathrm{ad}}_{J_i}$ restricted to $R_{\varepsilon_i}$ commutes with the torus and rotates the plane, and `short_rot` excludes it only through `hsa`.

## Q4: the lifts

- **`H_torus_slice_odd_op`**: $m=n+1$ with `6 ≤ n`, so $m\ge7$, and the constant `(2(n+1) - 1) / √((n+1)(2(n+1)+1))` is $\tfrac{2m-1}{\sqrt{m(2m+1)}}$. `Ftri C C C` is $F(C)$ and `normSq2 C ^ (3/2)` is $\lVert C\rVert^3$, the identifications r1714, r1715 and the L280 row rest on. The hypotheses are Q1's. This is L281 verbatim.
- **`H_small_odd_op`**: $m=j+1$ with `7 ≤ M` and `j + 2 ≤ M`, so $m+1\le M$, and `kapE M = 2(M-1)/√(M(2M-1))` is $\kappa_{2M}$. This is L282 (2) at every $m\ge1$ (O1).

## Q5: axioms

`#print axioms` on `L280_rep`, `H_torus_slice_odd_op`, `H_small_odd_op` and `L271_four_pos` returns `[propext, Classical.choice, Quot.sound]` for each.

## Q6: an object meeting the hypotheses

The identity `ContinuousLinearMap.id ℝ (skewSub (Option (Fin m × Fin 2)))` commutes with every `adS`, so `derOp (JO x) id = 0` by `simp`, and it is self-adjoint by `rfl`. The check file applies `L280_rep` to it, obtaining `id = torusOpOdd (Aof (comp0 id)) (Uof (comp0 id)) (Vof (comp0 id)) (wOf id)`, and proves `wOf id i = 1`. So the identity returns $w\equiv1$ on the short planes and, through `L268_rep` on the block `comp0 id`, the identity of $\mathfrak{so}(2m)$ as its long-root and Cartan part. The hypothesis set is non-empty.

## r1756 O1: L271_four_pos

The conclusion now reads `C = torusOp (Amu (Uof C) (Vof C)) (Uof C) (Vof C) ∧ IsPairWeights (Uof C) ∧ IsPairWeights (Vof C) ∧ TorusSystem (Uof C) (Vof C) ∧ 0 < ‖C_P‖² ∧ 0 < ‖C_Q‖²`, the two new conjuncts supplied by `L268_rep`'s `hU`, `hV`. `L271_eigen` takes exactly `hU`, `hV`, `hsys` and the two positivity facts, so the conclusion now carries every hypothesis it takes. The docstring change matches.

## Q7: INDEX rows

- **L280**: names [OddRep.lean](../lean/HamiltonsCubic/Results/OddRep.lean) and describes `L280_rep` and its route accurately, replacing "The claim ... is prose".
- **L281**: adds `H_torus_slice_odd_op` accurately.
- **L282**: replaces "The odd case (2) stays over `torusOpOdd`" with `H_small_odd_op`, accurate.
- **L271**: adds "with `IsPairWeights` for both weights" and the r1756 O1 citation, accurate (O2 on wording).
- **L273**: the note that `L273_g_ge_op` needs neither invariance nor symmetry is accurate, since its only hypothesis is the unit-norm condition on `Uof C`, `Vof C`.

## Overall verdict: CONFIRMED WITH OBSERVATIONS

1. **O1.** `H_small_odd_op` indexes $m=j+1$, so the case $m=0$ of L282 (2), $\mathfrak{so}(1)=0$, is outside it. That case is vacuous ($C=0$, both sides $0$), so nothing of the record's content is missing. A one-line note in the L282 row would make the range explicit.
2. **O2.** The L271 row now reads "at a solution of the system with $\lVert C_P\rVert^2>0$ and $\lVert C_Q\rVert^2>0$ with `IsPairWeights` for both weights": two "with" clauses in a row. "and `IsPairWeights` for both weights" reads cleanly. Wording only.

## Falsifiers

- `L280_rep`: a self-adjoint operator on $\mathfrak{so}(2m+1)$ commuting with every $\mathop{\mathrm{ad}}_{J_x}$ that sends some $e_a\wedge e_{2m+1}$ out of its short plane, or acts on $R_{\varepsilon_i}$ other than by a scalar, or mixes $\mathfrak{so}(2m)$ with $\mathfrak p$.
- `H_torus_slice_odd_op`: such a $C$ at $m\ge7$ with $F(C)>\tfrac{2m-1}{\sqrt{m(2m+1)}}\lVert C\rVert^3$.
- `H_small_odd_op`: such a $C$ at $1\le m$, $m+1\le M$, $M\ge7$, with $F(C)>\kappa_{2M}\lVert C\rVert^3$.
- `L271_four_pos`: a torus-invariant self-adjoint positive-definite idempotent on $\mathfrak{so}(2m)$, $m\ge3$, other than $I/(2(m-1))$, whose `Uof` or `Vof` fails to be symmetric with zero diagonal.
- A fidelity falsifier for Q2: a vector of $R_{\varepsilon_i}$ on which `torusOpOdd` acts by other than $w_i$, or an old vector on which `shortOp` acts nontrivially.
