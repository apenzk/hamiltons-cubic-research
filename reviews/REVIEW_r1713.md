# Review r1713: L279, J1 on so(2m+1)'s torus slice for m ≥ 7, statement fidelity of `J1odd_holds`

*Re-filed under a fresh number. The reviewer ran as r1711 (log agent_logs/r1711.log, closing `DONE r1711: C1-C6 all CONFIRMED, axioms standard three`), and a concurrent reader using the same number wrote its own report over this one before the commit, so e332d851 carries that reader's L56 text. The table below is this reviewer's final hand-back, verbatim in substance.*

Cold brief, one reviewer: the round compares a kernel-checked statement against the record. Analysis only, one seconds-long screen, reported as a screen.

**Verdict: all six claims CONFIRMED. The kernel statement of `J1odd_holds` is the record's L279 statement term for term.**

| # | claim | verdict | reason |
|---|---|---|---|
| C1 | the hypotheses are the record's: m = n+1 ≥ 7, U and V symmetric with zero diagonal, w arbitrary, b² = 1 | **CONFIRMED** | `6 ≤ n` on `Fin (n+1)`, so m ≥ 7. `IsPairWeights` is `Uᵀ = U ∧ ∀ i, U i i = 0`. `w` carries no hypothesis. `hb` is ‖U‖² + ‖V‖² + 2‖w‖² = 1 with full Frobenius sums. `#check` shows no extra hypothesis. |
| C2 | the conclusion is the record's inequality | **CONFIRMED** | The cubic part is ½(tr P³ + tr Q³) and the next term is 3·Σ w_i P_ij w_j. λ = 3√2(n+1)/(2(2(n+1)−1)), and `a/b*c` parses as (a/b)·c, so λ multiplies all of g². g² is Σ(dvec_i + w_i²)² plus `if i = j then 0 else (P_ij Q_ij)²`, with `dvec i = Σ_l (U_il² + V_il²)`. c₀ = √2(2m−1)(4m−1)/(8m²), and the inequality is `≤`. OddMW's `Lam` and `C0` leave out √2, and the proof bridges that with `hlam` and `hc0`. The statement writes its constants out in m. |
| C3 | the statement is not vacuous | **CONFIRMED** | U = V = 0 with w = e₁/√2 at m = 7 satisfies the hypotheses with b² = 1, and the L278 uniform point also has mass 1. A seconds-long numpy screen at m = 7 gave U = J−I a left side of 0.962 against c₀ = 1.266. 3000 random normalised points all lay within the bound, with max(left − c₀) ≈ −0.742. That is a screen only. |
| C4 | `#print axioms` shows only the standard three | **CONFIRMED** | `[propext, Classical.choice, Quot.sound]`, no `sorryAx`. |
| C5 | the lean/INDEX.md L279 row is accurate | **CONFIRMED** | The hypotheses and conclusion are right, and every named declaration exists: `bord`, `trace_bord`, `term_le`, `sqrt_amgm` and `fw_new` in OddJ1, `cocktail_rows` (J1.lean:45), `pair_bound` (J1.lean:255) and `oddMWprime` (OddMW.lean:1340). "At size m+1" and the walk W, u are both correct. |
| C6 | the OddJ1.lean header is accurate | **CONFIRMED** | The statement is accurate. The border is w/√2 on both U and V with a zero corner. `trace_bord`'s identity is its type verbatim. Every named lemma exists and plays its stated role, with t = √2·To and t = √2·Tn. The header numbers the steps 1–7, where the inline comments number them 1–10. That is labelling only. |

No defects found.

Log: agent_logs/r1711.log.
