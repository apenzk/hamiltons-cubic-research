# REVIEW r1734: L271 (4) in Lean, L120's concrete pair-summand, and the INDEX rows

*Cold Gate 2 review of [L271Eigen.lean](../lean/HamiltonsCubic/Results/L271Eigen.lean) (commit 7c2851af), `pair_B_exists` in [L120Witness.lean](../lean/HamiltonsCubic/Results/L120Witness.lean) (commit ce441b01) and the L271, L120 and L244 rows of [lean/INDEX.md](../lean/INDEX.md). Analysis-only footing: Lean source read, no `lake build` or `lake env`. One screen only: an exact-rational check of the two-by-two algebra (200 random points, 0 failures), reported as a screen. Heartbeats in [agent_logs/review-r1734.log](../agent_logs/review-r1734.log).*

| # | Claim | Verdict |
|---|---|---|
| 1 | `L271_eigen` renders L271 (4)'s "second eigenvalue of C#· on span(C_P, C_Q)" faithfully | CONFIRMED |
| 2 | `(gP + gQ)` is the record's q = ‖C‖², and `t` is tr Q³ | CONFIRMED |
| 3 | The hypotheses (`TorusSystem`, pair weights, gP, gQ > 0) cover the record's "C ≠ I/c (so Q ≠ 0)" | CONFIRMED WITH OBSERVATION (O1) |
| 4 | `L271_threshold` is the record's threshold and its algebra is right | CONFIRMED |
| 5 | `pair_B_exists` is a correct, non-vacuous concrete nonzero pair-summand, and the L120Witness docstring now matches | CONFIRMED |
| 6 | The INDEX rows (L271, L120, L244) claim only what is typed | CONFIRMED WITH OBSERVATION (O2, O3) |

**Summary: both commits type what they claim. The one defect is a stale clause in the L271 INDEX row that still calls (4)'s formula and threshold prose.**

## 1. L271_eigen against the record

- The record's proof of (4) sets L_kl = F(C, C_k, C_l), G = diag(‖C_P‖², ‖C_Q‖²), uses C#C = C to make L's rows sum to G, and reads the second eigenvalue as 1 − L_PQ(1/G_PP + 1/G_QQ). That is the generalised problem L v = λ G v, i.e. the compression of C#· to the span (the orthogonal projection of C#X onto the span, tested against the span's basis). C#· need not preserve the span, so the compression is the only reading available, and it is the one the record's proof uses.
- `Ftri C X Y` is ⟨C#X, Y⟩ at self-adjoint Y. `Ftri_sharp` gives `Ftri C C Y = ⟨Y, C#C⟩`, `Ftri` is trilinear, and `Ftri_symm12` makes it symmetric in its first two slots when the third is self-adjoint. So the polarisation ½(F(C+X, C+X, Y) − F(C,C,Y) − F(X,X,Y)) equals `Ftri C X Y`. Both test vectors C_P, C_Q are proved self-adjoint in the file (`hPsa`, `hQsa`).
- The four conclusions `Ftri C C Y = ⟨C, Y⟩` and `Ftri C H Y = λ₂⟨H, Y⟩` for Y ∈ {C_P, C_Q} are exactly "C has compressed eigenvalue 1 and H has compressed eigenvalue λ₂".
- C and H are a basis of the span. Their coefficient matrix [[1, 1], [1, −gP/gQ]] has determinant −(gP/gQ) − 1 ≠ 0, and C_P, C_Q are orthogonal and nonzero. Also ⟨C, H⟩ = gP − (gP/gQ)gQ = 0, the G-orthogonality a symmetric pencil's eigenvectors must have. The basis property is not itself a conjunct, but it follows from the conclusions' own data (`⟨H, C_P⟩ = gP > 0`).
- λ₂'s value: 1 − (gQ/2 − t/4)(1/gP + 1/gQ) = ½ − gQ/(2gP) + (gP + gQ)t/(4gP gQ), the file's `lam2` and the record's formula. The Lean proof derives F(C, C_P, C_P) = gP − L and F(C, C_Q, C_Q) = gQ − L from the row sums, which is the record's argument.
- "Second" names the eigenvalue other than 1 on a two-dimensional space. No ordering is claimed by the record or the file.
- C_P and C_Q match the record: `torusOp (diag d) (½(U+V)) (½(U+V))` is (diag d, U = V = ½P), and `torusOp (Amu − diag d) (½(U−V)) (−½(U−V))` is (A_off, U = −V = ½Q), `Amu`'s diagonal being d.

## 2. q and t

- The proof shows ⟨C, C_P⟩ = gP and ⟨C, C_Q⟩ = gQ from C = C_P + C_Q and orthogonality (`L271_split_core`), so ‖C‖² = gP + gQ. The identity ‖C‖² = gP + gQ is not a stated conjunct, but it is one line from the proved facts.
- `normSq2 = innerOp2 R R` is the record's norm (Bivectors2's docstring, and the same `normSq2` in `L271_split_core`'s ½‖C_Q‖² − ¼ tr Q³, which matches the record's polarisation line).
- `t = trace ((U−V)(U−V)(U−V))` is tr Q³.

## 3. Hypotheses

- The Lean hypotheses are any solution of `TorusSystem` with symmetric zero-diagonal weights and gP, gQ > 0. Idempotency comes from `L268_converse`. Positivity of the weights is not assumed, so the theorem covers more than the record's positive solutions.
- gQ > 0 is the record's Q ≠ 0. C_Q's Cartan block is A_off with entries V² − U² = −P_ij Q_ij, so Q = 0 makes C_Q = 0. Conversely Q ≠ 0 gives ‖C_Q‖² ≥ ½‖Q‖² > 0 by L271 (1)'s norm formula. The record reaches Q ≠ 0 from C ≠ I/c through (3), so the Lean hypothesis is the record's working hypothesis stated directly.
- **O1 (gP > 0 is redundant).** Q ≠ 0 forces some U_ij or V_ij ≠ 0, hence d_i > 0 and diag d ≠ 0, so C_P ≠ 0 and gP > 0. The hypothesis is harmless and keeps the division in λ₂ visibly defined. No repair is owed. A docstring line saying it follows from gQ > 0 would save the next reader the check.

## 4. L271_threshold

- λ₂ − ½ = ((gP + gQ)t − 2gQ²)/(4gP gQ), with a positive denominator, so λ₂ > ½ iff 2gQ² < (gP + gQ)t, i.e. q tr Q³ > 2‖C_Q‖⁴. This is the record's threshold.
- The theorem is stated over free reals with gP, gQ > 0, the left side being syntactically `lam2`'s expression, so it composes with `L271_eigen` by instantiation.
- It also agrees with the earlier `qsplit_test` row entry (κ(G_PP + G_QQ) > 2G_QQ² with κ = tr Q³).

## 5. Screens

- **Exact-rational screen** (Python `fractions`, 200 random points with gP, gQ > 0 and t of either sign): with L_PQ = gQ/2 − t/4 and L built from row sums G, the vector (1, −gP/gQ) satisfies L v = λ₂ G v exactly, (1, 1) is fixed with eigenvalue 1, λ₂ equals 1 − L_PQ(1/gP + 1/gQ), and the threshold equivalence holds. 0 failures. A screen of the algebra only.
- **Hand check at m = 2** (so(4)). The system reduces to u(1 − 4u²) = 0 and v(1 − 4v²) = 0, and u = ½, v = 0 is a solution with Q ≠ 0 and tr Q³ = 0. By L271 (1)'s norm, gP = gQ = 3/8, so λ₂ = ½ − ½ + 0 = 0. Independently, C is the projection onto one su(2) ideal, C_P = ½I, C_Q = ½(π₊ − π₋), H = π₋, and C#H = π₊#π₋ = 0 because the brackets between the ideals vanish. The eigenvalue is 0 on both routes. This leaves the tr Q³ term untested by example (m = 2 has no triangles), which the algebraic screen covers.

## 6. pair_B_exists

- The statement: at every n ≥ 4 there is B in `weylModuleS (Fin n)`, B ≠ 0, with `act (flip m) B = (sgn m 0 · sgn m 1) • B` for every m. These are exactly `L120_pair_instance`'s `hB` and `hiso` at j = 0, k = 1, so at n = 2p (p ≥ 3, n ≥ 6 ≥ 4) the instance's universal clause has a nonzero witness.
- Membership and the character come from `pairS_mem` and `pairS_iso` with c = δ₂ − δ₃, whose sum over {i : 0 ≠ i, 1 ≠ i} is 1 − 1 = 0 (indices 2, 3 both lie in the filter, via `h20`, `h21`, `h30`, `h31`).
- Nonzero: `coord_pairS_diag` at y = 2 gives `coord B 0 2 1 2 = c 2 = 1`. If B = 0 the left side is 0, contradiction via `h23`. Sound.
- The module docstring now says `L120_pair_instance` quantifies B and names `pair_B_exists` as the concrete B. The theorem docstring matches its statement. r1732 O1 is repaired as recommended (the corollary route).
- The witness is stated separately rather than composed into one theorem with `L120_pair_instance`. That is a legitimate split: both are proved at compatible n and the composition is instantiation.

## 7. INDEX rows

- **O2 (L271 row contradicts itself).** Inside the `L271_split` parenthetical the row still ends *"(4)'s eigenvalue formula and threshold are prose"*, while the new closing sentence says **(4)'s eigenvalue formula and threshold are PROVED** in L271Eigen.lean. The closing sentence itself matches the types (C_P, C_Q ≠ 0 is gP, gQ > 0 by `normSq2_eq_zero`'s definiteness). **Repair**: delete the stale clause from the parenthetical. The row could also note O1 and that the reading is the compression of C#· to the span, per section 1.
- **L120 row**: accurate. It records `pair_B_exists` with j = 0, k = 1, c = δ₂ − δ₃ and nonzero by `coord_pairS_diag`, states that the statement's w is existential (r1732 O2), and marks O1 repaired.
- **L244 row**: the *Not typed* clause now lists the κ_r(x) identification, for h0 a basis of E₀ starting with x, `Pc ψf cls a` as W's eigenprojection with the `bMass`/`bAB` bridge, `cls` quantified rather than constructed, and the per-vector rows entering `per_vector_ceiling` as hypotheses. This is r1733's pruned list and no longer lists the built ψ. It claims nothing untyped.
- **O3 (record provenance, outside the INDEX).** The L271 Gate line in [findings/second-order.md](../findings/second-order.md) (line 575) still says *"part (3) and the polarisation in (4) are prose"* and does not name L271Eigen. (3) is `L271_Q_zero` and the polarisation is `L271_split_core`, both proved. The research loop owns that line and it should be brought level with the INDEX.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** `L271_eigen` and `L271_threshold` are faithful to L271 (4) under the record's own compression reading, with the hypothesis gQ > 0 equal to the record's Q ≠ 0 and gP > 0 redundant (O1). `pair_B_exists` is correct and non-vacuous, and repairs r1732 O1. One repair is owed in [lean/INDEX.md](../lean/INDEX.md): the L271 row's stale "(4) ... are prose" clause (O2). The record's L271 provenance line is also stale (O3).
