# Review r1684: Lean fidelity of L277 (J1 for m at least 7, H on the torus slice of so(2m))

Log: [agent_logs/r1684.log](../agent_logs/r1684.log). Footing: analysis only. Runs: one compile of an independent copy of [J1.lean](../lean/HamiltonsCubic/Results/J1.lean) (namespace renamed, `#print axioms` and a literal-type application appended) and one `#print axioms` file against the built olean.

**Verdict: CONFIRMED on C1 to C5.** One presentational gap, in the block's *What it gives* (see G1). No correction to the statement or the Lean is owed.

| claim | Lean declaration | verdict |
|---|---|---|
| C1 J1_holds is J1 at m = n + 1 ≥ 7 in L273_J1_implies_H's form | HamiltonsCubic.J1.J1_holds | CONFIRMED |
| C2 H_torus_slice is L273's conclusion | HamiltonsCubic.J1.H_torus_slice | CONFIRMED |
| C3 fully proved, standard axioms | #print axioms | CONFIRMED |
| C4 helpers state their docstrings, J1b applies MWprime validly | helpers | CONFIRMED |
| C5 proof sketch matches the Lean | prose vs Lean | CONFIRMED |

## C1

- The hypothesis of `L273_J1_implies_H` (printed with `pp.numericTypes`) and the statement of `J1_holds` are the same term at `m := n + 1`: both read `√(2 * ↑m) * (↑m - 2) / ((↑m - 1) * √(↑m - 1))` for λ_m, and the cast `((n + 1 : ℕ) : ℝ)` is literally `↑m` there. The appended `example (n) (hn : 6 ≤ n) := L273_J1_implies_H (m := n + 1) (by omega) (J1_holds n hn)` elaborates, as does `H_torus_slice` itself.
- λ_m = √(2m)(m−2)/((m−1)√(m−1)) = √(2m)(m−2)/(m−1)^{3/2}, the record's value. `hlam2` proves λ_m² = `kap n` = 2(n+1)(n−1)²/n³, the record's κ' = λ_m².
- Normalisation: ½(‖P‖²+‖Q‖²) = 1 with P = U+V, Q = U−V, entrywise Frobenius sums, which is b = 1. The quartic factor is Σ_i d_i² + Σ_{i≠j} (P_ij Q_ij)², with d_i = `dvec` = Σ_l (U_il²+V_il²), which is ‖A_μ‖² = g² since (A_μ)_ij = −P_ij Q_ij. The Σ_{i≠j} P_ij²Q_ij² term is present.
- Range: `hn : 6 ≤ n`, so m ≥ 7, and the consumer's `5 ≤ m` is discharged by `omega`.
- Non-vacuity: U with U_01 = U_10 = 1/√2 and zero elsewhere, V = 0, satisfies every hypothesis (Σ d_i = 1). The hypotheses carry no sign condition on U, V, matching the block's "real symmetric zero-diagonal".

## C2

- `H_torus_slice` concludes `Ftri C C C ≤ 2(m−1)/√(m(2m−1)) · normSq2(C)^{3/2}` for `C = torusOp A U V`, A symmetric and U, V pair weights, with no normalisation hypothesis. That is L273 (3)'s κ‖C‖³ with κ = 2(m−1)/√(m(2m−1)).
- That `torusOp`, `Ftri` and `normSq2` realise the record's torus-invariant C, F and ‖·‖² is inherited from the consumer's own audit ([r1631](REVIEW_r1631.md)) and was left unrechecked here.

## C3

- `J1_holds`, `H_torus_slice` (both the built declarations and the independent copy) and `MWprime` depend on `[propext, Classical.choice, Quot.sound]` only.
- [L275.lean](../lean/HamiltonsCubic/Results/L275.lean) contains a `sorry` (`L275_bound`), which J1 does not use. It uses only `L275_interp`, and the axiom printout confirms no `sorryAx` reaches either target.

## C4

- `cocktail_rows`: states ½(tr P³ + tr Q³) ≤ Σ_{i,j}(|U_ij|+|V_ij|)√((d_i−w_ij)(d_j−w_ij)), as its docstring says. It takes only symmetry and zero diagonal. Nit: the module header's "excluding the four indices a row pair meets" describes the four entries U_ij, V_ij (row i) and U_ij, V_ij (column j) removed. The index set dropped is k ∈ {i, j}, which is the block's "k ≠ i, j".
- `Rw`: d_i d_j − (U_ij²−V_ij²)² off the diagonal, 0 on it. `ee_le_R` proves the block's excess w(d_i−w)+w(d_j−w)+4U²V², and `Rw_nonneg` holds.
- `fw`: s²·E/R with s = |U|+|V|, set to 0 where R = 0. `pair_bound` covers the R = 0 and w = 0 cases separately, so the convention adds no restriction.
- `pairing`: Σ s√E ≤ √(Σ f)√(Σ R), as its docstring says.
- `ww`, `gam`, `hterm`: w = U²+V², γ = 2|UV|/w (0 at w = 0), and hterm = w[γ(1−p)² + (1−γ)(1−p)/2] with p = w/d_i. Here 2·hterm = w(1−p)(1+γ(1−2p)), which is MW' first summand (`e2` in `J1b`).
- `pair_core`: the real-variable per-pair bound. Its extra hypotheses (0 < w ≤ d_i, d_j, γ ∈ [0,1], R > 0) are exactly what `pair_bound` has in the branch where it applies it.
- `J1b` applies `MWprime n hn` to w = `ww U V` and γ = `gam U V`. Non-negativity holds by positivity, symmetry by `symm_of`, the zero diagonal by `IsPairWeights`, Σw = 1 by `hS` and γ ∈ [0,1] by `gam_range`. MWprime's row sum Σ_k w_ik is `dvec` by `rfl`. Division by a zero row sum uses Lean's x/0 = 0 identically on both sides. That row carries w = 0, so its terms vanish anyway.

## C5

- (1) matches `cocktail_rows`: the α/β split in `htr`, then two applications of `cs_pair` over k ≠ i, j.
- (2) matches `pairing`, `ee_le_R` and `hRsum` (Σ R = 1 − g²).
- (3) matches `pair_bound` and `pair_core`: (|U|+|V|)² = w(1+γ) is `hs2`, R = d_i d_j(1−pq(1−γ²)) is `hRe`, and the bound comes through `L275_interp` at a = 1−p, b = 1−q.
- (4) matches `J1b`. Nit: the symmetrised sum is MW's left side less its κ w²(1−γ²) term, and that term is moved into Σ R (`hsR`). The block's wording compresses this rearrangement.
- (5) matches the end of `J1_holds`: √(Σf) ≤ λ_m √(Σ R), so T ≤ λ_m Σ R = λ_m(1−g²).

## Overstatement check

- The block claims m ≥ 7 throughout. m = 6 is explicitly placed outside the lemma. The Lean's `6 ≤ n` is the same threshold.
- **G1 (presentational).** *What it gives* reads "R47 at 2m ≥ 14 in the kernel: U_s' holds at every torus-invariant positive-definite idempotent". The kernel holds H on the torus slice. The step from H to U_s' at an idempotent is one line of prose: F(C) = ‖C‖² there, so ‖C‖ ≥ 1/κ = ‖I/c‖. No Lean declaration consumes `H_torus_slice`, and none states U_s' on the torus family. Suggested wording: "H on the torus slice for m ≥ 7 is in the kernel, and U_s' at every torus-invariant positive-definite idempotent follows from it in one line (F(C) = ‖C‖² at an idempotent)".
- Side note, outside this block: [routes.md](../routes.md) R47 cites the m = 6 case as "batch 12", while this block cites batch 13 (the certificate batch). Both batches exist in the working note.
