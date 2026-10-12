# REVIEW r1707: Lean-fidelity audit of L278 (oddMWprime)

Target: `HamiltonsCubic.OddMW.oddMWprime` in [OddMW.lean](../lean/HamiltonsCubic/Results/OddMW.lean) against Lemma L278 in [second-order.md](../findings/second-order.md). Footing: analysis only. The numerical items below are screens (seconds of exact sympy arithmetic on objects built for the purpose, and one Lean elaboration of a two-line scratch file).

**Verdict: CONFIRMED. `oddMWprime` states exactly the record's L278 divided by √2, over the record's index sets, with no extra hypothesis, and depends on the three standard axioms only.**

## Checks

| # | Check | Verdict | Evidence |
|---|---|---|---|
| 1 | √2 bookkeeping, term by term | CONFIRMED | By hand, below. A sympy screen also gives record/√2 − Lean LHS = 0 exactly and c₀/√2 − `C0` = 0 exactly at m = 7, at the uniform point and at a random admissible walk with random rational γ. |
| 2 | Index sets, q's, m, total mass | CONFIRMED | Below. |
| 3 | γ explicit per ordered pair in [0,1], as L276's `MWprime` | CONFIRMED | `(γ : Fin (n+1) → Fin (n+1) → ℝ) (hγ : ∀ i j, 0 ≤ γ i j ∧ γ i j ≤ 1)`, universally quantified, the same binder shape as `HamiltonsCubic.MWPrime.MWprime` (MWPrime.lean line 690). A universal over γ ∈ [0,1] is equivalent to the maximum form. Diagonal γ i i is inert since `W i i = 0`. |
| 4 | Non-vacuity, equality at the uniform point | CONFIRMED (screen) | Below. |
| 5 | `#print axioms` | CONFIRMED | `[propext, Classical.choice, Quot.sound]`. The file contains no `sorry`, `native_decide` or `axiom`. |
| 6 | Header accuracy, `cert_*` coverage | CONFIRMED | Below. |

## 1. The √2 bookkeeping

Write t_o = √2·`To`, t_n = √2·`Tn`, λ = √2·`Lam`, c₀ = √2·`C0`. The four definitions (lines 33–36) are the record's constants with the √2 removed: `To = (2m−1)²/(4m(2m−3))`, `Tn = (2m−1)/(4(m−1))`, `Lam = 3m/(2(2m−1))`, `C0 = (2m−1)(4m−1)/(8m²)`.

- Old-old first term: (t_o/2)·w(1−q)(1+γ(1−2q))/√2 = (`To`/2)·w(1−q)(1+γ(1−2q)).
- Old-old second coefficient: (λ − 1/(2t_o))/√2 = `Lam` − 1/(2·√2·√2·`To`) = `Lam` − 1/(4`To`).
- New-edge term: 2t_n/√2 = 2`Tn`.
- Cross term: (1/(2t_o))/√2 = 1/(4`To`), multiplying Σ_{i≠j≥1} π_iπ_j = (Σπ_i)² − Σπ_i², which is the Lean form.
- Vertex-0 term: (π₀/t_n)·Σπ_i/√2 = π₀·Σπ_i/(2`Tn`). Lean's `(∑ k, u k) * (∑ i, P i) / (2 * Tn)` parses as (π₀·S)/(2`Tn`) (confirmed from the elaborated `#check`).
- Square term: λΣπ_i²/√2 = `Lam`·Σπ_i².
- Right side: c₀/√2 = `C0`.

Constants are evaluated at `(↑n + 1 : ℝ)`, which is m.

## 2. Index sets

- Old vertices are `Fin (n+1)` with m = n+1, and `hn : 6 ≤ n` is m ≥ 7.
- The Lean double sum runs over all ordered pairs including i = j. With `hdiag : W i i = 0` each diagonal summand is (`To`/2)·0·… + (…)·0²·… = 0, so it equals the record's sum over i ≠ j ≥ 1.
- π_i = Σ_{k≥1} W i k + u i is the record's Σ_j w_ij over all m+1 vertices (w_{i0} = u i). π₀ = Σ u k.
- q_ij = W i j/π_i, q_{i0} = u i/π_i, q_{0i} = w_{0i}/π₀ = u i/Σ u k: all as the record.
- Symmetry of w on all m+1 vertices is `hsym` on the old block plus w_{0i} = w_{i0} built into the single weight u. Zero diagonal at vertex 0 is implicit (w₀₀ is not a variable). Non-negativity is `hW0`, `hu0`.
- Total mass Σ_{i,j} w_ij over all m+1 vertices = Σ_{old} W + Σ_i w_{i0} + Σ_i w_{0i} = Σ W + 2Σu, which is `htot`.
- Division convention: Lean's x/0 = 0 applies only when π_i = 0 (then W i j = u i = 0 on that row) or π₀ = 0 (then every u i = 0), so every affected summand is 0 with or without the convention. The record's q is undefined there and the summands carry a factor w that vanishes. No strengthening or weakening follows.
- No hypothesis beyond the record's appears in the statement. Facts such as π_i ≤ 1/2 and S ≥ 1/2 are derived in the proof body (`hPhalf`, `hShalf`).

## 4. Non-vacuity (screen, exact rational arithmetic, m = 7)

Uniform point W i j = 1/m² (i ≠ j), u i = 1/(2m²). It satisfies every hypothesis: non-negative, symmetric, zero diagonal, and total mass m(m−1)/m² + 2·m/(2m²) = 1 (screen returned 1). With γ ≡ g constant, the Lean LHS minus `C0` is exactly −3(g−1)(68g−1453)/33124, which on [0,1] is ≤ 0 with equality exactly at g = 1 (at g = 0 it is −4359/33124). So LHS = `C0` = 351/392 ≈ 0.8954 at γ ≡ 1, the record's equality case. A random admissible rational walk with random γ gave LHS ≈ 0.7968 ≤ `C0`.

## 5. Axioms

Scratch file importing `HamiltonsCubic.Results.OddMW`, run by `lake env lean`:

```
'HamiltonsCubic.OddMW.oddMWprime' depends on axioms: [propext, Classical.choice, Quot.sound]
```

## 6. Header and certificates

- The header's account (constants over √2, W and u, π_i and π₀, the step-by-step declaration list) matches the declarations present. Each named declaration exists with the role described.
- The six `cert_*` lemmas take `t : ℕ` and `S` in [1/2, 1] (`cert_Ql`: [1/2, 2/3]) and state their polynomial with `m := (t : ℝ) + 7`. `cert_enum0` and `cert_enumh` state strict positivity, which is stronger than the header's "non-negativity" wording. `oddMWprime` rewrites n = t+6, so m = t+7, and every integer m ≥ 7 is covered. The S ranges match the callers: `ggo_mono`, `enum_pos` and `closing_cubic` take 1/2 ≤ S ≤ 1, and `closing_line` takes S ≤ 2/3, which feeds `cert_Ql`.
- `cert_ellh` writes its polynomial inline instead of through `NUMhP`. The screen confirms the inline polynomial is exactly −`NUMhP` (their sum expands to 0), which is the sign `ggo_mono` consumes.

## Findings

No defect in `HamiltonsCubic.OddMW.oddMWprime` or its header. One presentational note: `cert_ellh` states −`NUMhP` inline where its siblings name their polynomial. The screen confirms it matches, and it is a candidate for a one-line tidy (`0 ≤ -NUMhP m S`) and nothing more.
