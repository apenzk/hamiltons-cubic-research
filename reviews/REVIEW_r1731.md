# REVIEW r1731: L237Maxima.lean, the exact maxima 2 + √3 and 2 + √2

*Gate 2, cold brief, statement-fidelity review of [L237Maxima.lean](../lean/HamiltonsCubic/Results/L237Maxima.lean) at commit 18e0cd9b. Analysis-only footing: the certificates were checked by hand and the numerical items below are screens (pure Python, seconds, exact rationals in Q(√3) and Q(√2) for the identities, a KKT subset enumeration with Jacobi eigenvalues for the orthant maxima). `lake build` was not run, so the 8/8 axiom count is taken from the commit. Log: agent_logs/review-r1731.log.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `kernel_le` / `kernel_attained` are `slot_ceiling_7`'s form, the path b–a–c with a kernel slot at its centre, max 2 + √3 | CONFIRMED |
| 2 | `minus_le` / `minus_attained` are `slot_ceiling_3`'s form, the star with one minus slot, max 2 + √3 on nonnegative angles | CONFIRMED |
| 3 | `path_le` / `path_attained` are `slot_ceiling_0`'s form, the path c–a–b–d, max 2 + √2 | CONFIRMED |
| 4 | The certificates are identities and the attaining vectors are nonnegative with equality | CONFIRMED |
| 5 | The file discharges the owed "2 + √2 (r1122's screen)" item | CONFIRMED WITH GAPS (G1) |
| 6 | SevenFrameGap's "the rest are at most 2 + √2" | CONFIRMED (screen) |
| 7 | The INDEX row claims only what is typed | CONFIRMED WITH GAPS (G2, G3) |

**Summary: the three theorems are correct and exact, but the 2 + √2 configuration the source docstring owes is `slot3_pm_edge`, which the file does not type, and two docstrings are stale or miscounted.**

## 1. The configurations

- A term `(p ± q)²` is a plus or minus slot joining planes p and q, a lone `p²` is a kernel slot on plane p.
- `slot_ceiling_7`, `(a+b)² + (a+c)² + a²`: plus slots on (a,b) and (a,c) make the path b–a–c, and the kernel slot sits on the centre a. [KyFanBracketCap.lean](../lean/HamiltonsCubic/Results/KyFanBracketCap.lean)'s `slot3_path_loop` has the same form and says so ("a path P₃ with an s_a² slot at its centre"). The record's "path with a kernel slot" means this, the centre-loop path.
- The end-loop path is `slot_ceiling_8`, `(a+b)² + (a+c)² + b²`, which is r1122's `path_loop_end` with maximum 3.2470 (the largest root of x³ − 5x² + 6x − 1). The phrase "path with a kernel slot" is therefore ambiguous in the record, and "at its centre" should be added in L237Maxima's header and the INDEX row (minor).
- `slot_ceiling_3`, `(a+b)² + (a+c)² + (a−d)²`: three slots from centre a, one of them minus. This is the star with one minus slot.
- `slot_ceiling_0`, `(a+b)² + (a+c)² + (b+d)²`: the path c–a–b–d, r1122's `path` (KyFanBracketCap's `slot3_path` up to relabelling).

## 2. Exactness over nonnegative angles

- `kernel_le` and `path_le` hold for all reals and their attaining vectors are nonnegative, so each value is the exact maximum over the whole space and over the orthant alike.
- `minus_le` needs `a, d ≥ 0` (it uses `(a−d)² ≤ a² + d²`), and correctly so: over all reals the form is a sign-flipped star with maximum 4 (screen: 4.000000). Attainment at d = 0 reuses the kernel vector, which is nonnegative. So 2 + √3 is the orthant maximum.
- Screen: orthant maxima 3.732051 for forms 3 and 7, 3.414214 for form 0, all matching.
- r1122 §6 reports "path_loop `2+√3`, path and pm_edge `2+√2`, path_loop_end `3.247`". So r1122's 2 + √2 was reported for TWO configurations, the path and `pm_edge` (`(a+b)² + (a−b)² + (a+c)²`). See G1.

## 3. SevenFrameGap's "the rest are at most 2 + √2"

- All 52 `slot_ceiling_*` forms and the six `slot_ceiling_rep*` forms were screened over the nonnegative orthant.
- Only forms 3 and 7 exceed 2 + √2, both at exactly 3.732051. The sentence is consistent.
- The forms reaching exactly 2 + √2 on the orthant are 0, 2, 21, 26 and rep0. Form 2 is `pm_edge` (attained at (1+√2, 0, 1), exact check True).
- Side note: the SevenFrameGap header counts fifty-four configurations including the triangle and star, fifty-two others, which matches the 52 lemmas.

## 4. The certificates

- Kernel, by hand: (2+s)Σ − Q = (s−1)a² + (1+s)(b²+c²) − 2a(b+c). The right side expands with h = (1+s)/2 to 2h(b²+c²) = (1+s)(b²+c²), cross term −2h(s−1)a(b+c) = −(s²−1)a(b+c) = −2a(b+c), and h(s−1)²a² = (s²−1)(s−1)a²/2 = (s−1)a². Identity holds.
- Path, by hand: (2+t)Σ − Q = t(a²+b²) + (1+t)(c²+d²) − 2ab − 2ac − 2bd. The two h-squares give (1+t)(c²+d²), cross terms −(t²−1)(2ac + 2bd) = −2ac − 2bd, and (t−1)(a²+b²), and (a−b)² supplies a² + b² − 2ab. Identity holds.
- Screen: both identities agree exactly at 30 random rational points in Q(√3) and Q(√2), which settles a quadratic identity.
- Attaining vectors: (1, (√3−1)/2, (√3−1)/2) with (√3−1)/2 ≈ 0.366 ≥ 0 (proved in `kernel_attained` via `1 ≤ √3`), (1+√2, 1+√2, 1, 1) ≥ 0, and d = 0 for the minus form. Equality verified exactly in all three.
- The `linear_combination` coefficients are consistent with these expansions (the residual is a multiple of s² − 3 or t² − 2).

## 5. Gaps

- **G1 (fidelity of the discharge).** KyFanBracketCap's docstring on `slot3_pm_edge` reads *"The configuration's exact maximum `2 + √2`, a value from r1122's screen, is owed in the L237 row."* The owed 2 + √2 item is thus attached to `pm_edge`, `(a+b)² + (a−b)² + (a+c)²` (SevenFrameGap's `slot_ceiling_2`), and the file types the path's 2 + √2 instead. The row dropped the item while `pm_edge`'s maximum stays untyped. Repair: add `pm_le`, `pm_attained`. Here Q = 3a² + 2b² + c² + 2ac and (2+t)Σ − Q = (t−1)a² + t b² + (1+t)c² − 2ac = (1+t)(c − (t−1)a)² + t b², checked by hand: the cross term is −2(1+t)(t−1)ac = −2ac and the a² term is (1+t)(t−1)² a² = (t−1)a². Equality at (a, b, c) = (1+√2, 0, 1), nonnegative (screen: exact check True). Alternatively record that the path was chosen and keep `pm_edge` on the owed list.
- **G2 (stale docstrings).** KyFanBracketCap's `slot3_pm_edge` and `slot3_path_loop` docstrings still say their exact maxima are "owed in the L237 row", which the row no longer lists. `slot3_path_loop`'s is now discharged by `kernel_le` (same form) and should point there.
- **G3 (count).** L237Maxima's header says SevenFrameGap "bounds the fifty-four three-slot configurations other than the all-plus triangle and star". SevenFrameGap says fifty-four in all and fifty-two others. It should read "fifty-two".
- Minor: "path with a kernel slot" should read "path with a kernel slot at its centre" in the header and the INDEX row (§1).

## 6. The INDEX row

- The row's new sentence names `kernel_le`, `kernel_attained`, `minus_le` (nonnegative angles), `minus_attained`, `path_le`, `path_attained`, the forms and the values. Each matches a typed statement with its hypotheses. No over-claim beyond G1's choice of configuration.
- "using only √3² = 3 and √2² = 2": `kernel_attained` also uses `1 ≤ √3` for nonnegativity, a harmless omission.

## Overall verdict

**CONFIRMED WITH GAPS.** The three bounds and their attainment are correct, exact, and are the maxima over nonnegative angles for the configurations the SevenFrameGap header names. SevenFrameGap's "the rest are at most 2 + √2" survives the screen. G1: the owed 2 + √2 item, per KyFanBracketCap's docstring, is `pm_edge`, which remains untyped. G2 and G3 are docstring repairs.
