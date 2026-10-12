# REVIEW r1688: L226's block operator is skew-preserving and self-adjoint, and item 3's closing formula (c053deef, 1c76d74c)

**Verdict: CONFIRMED WITH GAPS.** `blockOp_isSkew` and `blockOp_selfAdjoint` in [L226Mixed.lean](../lean/HamiltonsCubic/Results/L226Mixed.lean) state the first two clauses of the base layer's `IsWeyl` for `blockOp`, each in a form that implies the clause (quantified over all matrices where `IsWeyl` quantifies over skew ones), under exactly the record's symmetries of $S$, $M_a$ and $K$, with $K$'s diagonal correctly absent. `opOf_selfAdjoint` is true as stated on all matrices, and `Pcubic_ricciFlat` is item 3's closing formula, `blockP` matching the record's displayed polynomial term by term. All ten declarations of the file rest on the standard three axioms. Two gaps are editorial: the [lean/INDEX.md](../lean/INDEX.md) row calls first Bianchi "the last clause of `IsWeyl`" (it is the third, Ricci is the fourth), and the record's Lean paragraph in [second-order.md](../findings/second-order.md) still lists skew-preservation and self-adjointness as owed.

| # | Claim | Verdict |
|---|---|---|
| 1a | `blockOp_isSkew` implies `IsWeyl`'s first clause for `blockOp` | **CONFIRMED** |
| 1b | `blockOp_selfAdjoint` implies `IsWeyl`'s second clause for `blockOp` | **CONFIRMED** |
| 1c | The hypotheses are the record's $W\in\mathcal S_J$: symmetric $S$, $M_a$, $K$, each load-bearing, with and $K_{aa}=0$ is correctly omitted | **CONFIRMED** (by hand) |
| 1d | `blockCoeff_symm` and `K_pat` state pair symmetry $C_{ijkl}=C_{klij}$ of the block coefficients | **CONFIRMED** (by hand, all six block patterns) |
| 2 | `opOf_selfAdjoint` is true on all matrices and its use of `inner2`'s bilinearity is sound | **CONFIRMED** |
| 3 | `Pcubic_ricciFlat` states item 3's closing formula: $S=N-\tfrac12(\operatorname{tr}N)I$ and $P(W)$ the displayed polynomial | **CONFIRMED** |
| 4a | The row's new sentences claim exactly what is proved | **CONFIRMED WITH GAPS** (G1) |
| 4b | The owed list is complete | **CONFIRMED** (with a duplication noted, O1) |
| 4c | The record agrees with the row about what the Lean holds | **GAP** (G2) |
| 5 | Axioms: standard three only | **CONFIRMED** (10/10 clean, a screen by the repo's audit script) |

One line: the two new `IsWeyl` clauses and the closing formula are faithful and sound, the row misnumbers Bianchi as `IsWeyl`'s last clause, and the record's Lean paragraph went stale again with 1c76d74c.

## Attack line 1: statement fidelity of the two `IsWeyl` clauses

- **`IsWeyl`'s clauses** ([WeylReal.lean:126](../lean/HamiltonsCubic/Base/WeylReal.lean#L126)): (1) `∀ X, IsSkew X → IsSkew (R X)`, (2) `∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)`, (3) `∀ i j k l, bianchi R i j k l = 0`, (4) `∀ a b, Ric R a b = 0`.
- **Clause 1.** `blockOp_isSkew S M K X : IsSkew (blockOp S M K X)` for every `X`, with no hypotheses. It implies clause 1 by discarding the skew hypothesis. It is true without hypotheses because `opOf C X` is a linear combination of the skew `phi k l` whatever `C` and `X` are (`opOf_isSkew`, [L226Statement.lean:171](../lean/HamiltonsCubic/Results/L226Statement.lean#L171)), and `blockOp = opOf (blockCoeff S M K)` by `rfl` (`blockOp_eq_opOf`).
- **Clause 2.** `blockOp_selfAdjoint` gives `inner2 (blockOp S M K X) Y = inner2 X (blockOp S M K Y)` for every `X Y`, which implies clause 2 by discarding both skew hypotheses. The same constant `inner2` is used on both sides, so no normalisation slip is possible between this statement and the clause.
- **Hypotheses.** `hS : S.IsSymm`, `hM : ∀ a, (M a).IsSymm`, `hK : ∀ a b, K a b = K b a`. These are the record's Setting: symmetric $R_J$ (written as symmetric $S$ at $k=3$), symmetric $M_a$, and $K$ symmetric because $W\varphi_{ab}=K_{ab}\varphi_{ab}$ and $\varphi_{ba}=-\varphi_{ab}$.
- **Each hypothesis is load-bearing**, checked by hand on `blockCoeff` ([L226Statement.lean:57](../lean/HamiltonsCubic/Results/L226Statement.lean#L57)). The $JJJJ$ entry $\sum_{x,y}\varepsilon_{pqx}\varepsilon_{rsy}S_{xy}$ swapped to $(rs,pq)$ is $\sum\varepsilon_{pqx}\varepsilon_{rsy}S_{yx}$, so an antisymmetric part of $S$ breaks pair symmetry. The $JAJA$ entry $[a=b](M_a)_{pq}$ swapped is $[a=b](M_a)_{qp}$, which needs $M_a$ symmetric. The outer entry at $a\ne b$, $a=d$, $b=c$ is $-K_{ab}$ and swapped is $-K_{ba}$, which needs `hK`.
- **$K$'s zero diagonal is correctly absent.** Every $K$ case of `blockCoeff` is gated by `a ≠ b`, so `blockOp` never reads $K_{aa}$, and `K_pat`'s two branches are both guarded by distinctness. `hK0` enters only where the record's $\sum_{b\ne a}$ is read as `∑ b` (the Ricci statements), and `Pcubic_ricciFlat` carries it for that reason alone.
- **`blockCoeff_symm` by hand.** The six nonzero patterns (by `Sum` tag) are $JJJJ$, $JAJA$, $AJJA$, $JAAJ$, $AJAJ$, $AAAA$. The swap $(i,j,k,l)\mapsto(k,l,i,j)$ fixes $JJJJ$, $JAJA$, $AJAJ$, $AAAA$ and exchanges $AJJA$ with $JAAJ$, so the set is swap-closed and every wildcard (zero) case maps to a wildcard case. Under the swap $AJJA$ entry $[a=b](-M_a)_{pq}$ goes to the $JAAJ$ entry at the swapped arguments, $[b=a](-M_b)_{qp}$, equal under `hM`. `K_pat` checked branch by branch: at $a\ne b$, $a=c$, $b=d$ both sides are $K_{ab}$. At $a\ne b$, $a=d$, $b=c$ the left is $-K_{ab}$ and the right is $-K_{cd}=-K_{ba}$. Otherwise both are $0$.

## Attack line 2: `opOf_selfAdjoint`

- **True as stated on all matrices.** By definition `opOf C X = ¼ Σ (inner2 X φ_ij · C_ijkl) φ_kl`, so `inner2 (opOf C X) Y = ¼ Σ inner2 X φ_ij · C_ijkl · inner2 φ_kl Y`. This is a bilinear form $B(X,Y)=\tfrac14\sum\ell_{ij}(X)C_{ijkl}\ell_{kl}(Y)$ in the linear functionals $\ell_{ij}=\langle\cdot,\varphi_{ij}\rangle$, and it is symmetric in $(X,Y)$ exactly when the coefficient array is symmetric under $(ij)\leftrightarrow(kl)$, which is `hC`. Nothing uses skewness of $X$ or $Y$, so the all-matrices statement is correct.
- **The bilinearity used is genuine.** The step `h` rewrites `inner2` as `KyFanPackaging.inner2Form` ([KyFanPackaging.lean:22](../lean/HamiltonsCubic/Results/KyFanPackaging.lean#L22)), a `LinearMap.mk₂` whose three linearity obligations are proved from `inner2 = ½ tr(Xᵀ Y)` by `simp` and `ring`, and `inner2Form_apply` is `rfl`. `map_smul` and `map_sum` then distribute the outer `¼ •` and the four sums in the first slot. The closing step swaps the sum order by `RealLayer.sum4_swap`, applies `hC k l i j`, and uses `inner2_comm` twice, then `ring`. Each rewrite is a standard identity and the kernel accepts the whole.
- **The import** of `HamiltonsCubic.Results.KyFanPackaging` is a new edge in the import graph. It builds, so it is acyclic. It is used only for the bilinear-form packaging of `inner2`.

## Attack line 3: `Pcubic_ricciFlat` against item 3

- **Hypotheses.** Those of `ricciFlat_iff` plus `hRic : ∀ i j, Ric (blockOp S M K) i j = 0`. The record's item 3 is stated on $\mathcal S_J\cap\mathcal W_n$, and Ricci-flatness is one of its clauses, so the Lean hypothesis is weaker and the theorem stronger. The record's step 5 uses only the Ricci equation to invert, so this matches the proof.
- **First conjunct.** `S = ∑ a, M a - ((1/2) * (∑ a, M a).trace) • 1` is $S=N-\tfrac12(\operatorname{tr}N)I$ with $N=\sum_aM_a$. The proof takes item 2's $J$ condition $(\operatorname{tr}S)I-S+N=0$ from `ricciFlat_iff`, rewrites it as $(\operatorname{tr}S)I-S=-N$, and inverts by `ricciJ_inverse` ([L226Statement.lean:1246](../lean/HamiltonsCubic/Results/L226Statement.lean#L1246)), which is step 5's trace argument.
- **Second conjunct.** `Pcubic (blockOp S M K) = blockP (N - ½(tr N)I) M K`, from `Pcubic_blockOp` and rewriting back with the first conjunct. `blockP` ([L226Statement.lean:50](../lean/HamiltonsCubic/Results/L226Statement.lean#L50)) against the record's display, term by term:
  - `cubicJ S = (S*S*S).trace + 3 * S.det` is $\operatorname{tr}S^3+3\det S$.
  - `∑ a, ((M a)^3.trace + 3 * (S * (M a).adjugate).trace)` is $\sum_a(\operatorname{tr}M_a^3+3\operatorname{tr}(S\operatorname{adj}M_a))$.
  - `∑ a, ∑ b, if a < b then K a b ^ 3 + 3 * K a b * (M a * M b).trace else 0` is $\sum_{a<b}(K_{ab}^3+3K_{ab}\operatorname{tr}(M_aM_b))$.
  - `3 * ∑ a b c, if a < b ∧ b < c then K a b * K a c * K b c else 0` is $3\sum_{a<b<c}K_{ab}K_{ac}K_{bc}$.
- **Nothing is dropped and no coefficient differs.** The record's $\operatorname{tr}(R_J\Lambda^2M_a)=\operatorname{tr}(S\operatorname{adj}M_a)$ and $P(R_J)=\operatorname{tr}S^3+3\det S$ are absorbed into `Pcubic_blockOp`, which states item 1 at $k=3$ directly in item 3's coordinates, reviewed earlier.
- **Non-vacuity.** $S=M=K=0$ satisfies every hypothesis, and item 3's $m=1$ case with $M_1$ traceless and $S=M_1$ is a nonzero Ricci-flat instance by `ricciFlat_iff`, so the theorem constrains real data.

## Attack line 4: the row

- **What the new sentences claim.** "`Pcubic_ricciFlat`, item 3's closing formula" and "Skew-preservation and self-adjointness are PROVED" with `blockOp_isSkew`, `blockOp_selfAdjoint`, `blockCoeff_symm`, `K_pat`, `opOf_selfAdjoint` described as they are stated. Accurate.
- **G1, a misnumbered clause.** The row writes "first Bianchi for `blockOp`, the last clause of `IsWeyl`". First Bianchi is `IsWeyl`'s third clause, and the fourth is Ricci. For `blockOp` Ricci is not a property to prove but a condition on the data, characterised by `ricciFlat_iff`, so the intended sense is "the last clause still unaddressed". Repair: "first Bianchi for `blockOp`, `IsWeyl`'s third clause and the one not yet proved or characterised".
- **The owed list.** First Bianchi for `blockOp`, item 3's automatic Bianchi, the rest of item 2's equivalence (membership in $\mathcal W_n$), and $k\ne3$. That is complete against items 1 to 3 and steps 4 and 5.
- **O1, a duplication rather than a gap.** `blockOp` exists only at $k=3$, so "first Bianchi for `blockOp`" and "item 3's automatic Bianchi" are one obligation there: step 4's reduction of Bianchi to $R_J$ plus step 5's observation that four indices from a set of three repeat one. Listing both is harmless, though a reader may count two proofs owed where one theorem discharges both.
- **Not owed by this lemma, noted for completeness.** That every $W\in\mathcal S_J$ is a `blockOp` is the Setting's appeal to the block note's character argument, and the row does not claim it.

## Attack line 5: axioms

- `python3 scripts/misc/axiom_audit.py --only L226Mixed.lean`: "auditing 10 declarations across 1 files, 10/10 clean, resting on the standard three alone". The file contains no `sorry` (grep). This is a screen by the repo's script.

## G2: the record's Lean paragraph is stale again

- [second-order.md](../findings/second-order.md), L226's **Lean.** paragraph, was repaired in 338c5f64 and reads "Owed in Lean: that `blockOp` preserves skew matrices, is self-adjoint and satisfies the first Bianchi identity". After 1c76d74c the first two are proved. Repair: "`blockOp_isSkew` and `blockOp_selfAdjoint` prove that `blockOp` preserves skew matrices and is self-adjoint. Owed in Lean: first Bianchi for `blockOp` (item 3's automatic Bianchi), the rest of item 2's equivalence, and $k\ne3$." The record is the research loop's file, and with both loops armed the repair belongs to this session.

## What would break the claims, and what I did to look for it

- **For self-adjointness**: a block entry of `blockCoeff` whose swap partner is not its transpose, for instance a mixed $JAAJ$ entry carrying $M_a$ where $AJJA$ carries $M_a^{\mathsf T}$ with an extra sign. I enumerated the six patterns, confirmed the swap closes the set and pairs $AJJA$ with $JAAJ$ with matching sign $-$, and checked the $K$ branches of `K_pat` by hand.
- **For `opOf_selfAdjoint`**: a use of skewness hidden in the bilinearity step, which would make the all-matrices statement false. `inner2Form`'s linearity is proved for arbitrary matrices from the trace formula, so none is hidden.
- **For the closing formula**: a coefficient in `blockP` differing from the record's display, or a sum over ordered rather than unordered pairs. All four groups match, with `a < b` and `a < b ∧ b < c` guards.
- **For the row**: a clause of `IsWeyl` neither proved nor listed as owed. Clauses 1 and 2 are proved, 3 is listed, 4 is characterised by `ricciFlat_iff`. The only defect found is the numbering in G1.
