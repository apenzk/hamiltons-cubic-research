# Review r1726: L52OneLine, the one-line bound at the record's objects, its theta form and its strictness

**Standfirst.** Cold Gate 2 statement-fidelity review of [L52OneLine.lean](../lean/HamiltonsCubic/Results/L52OneLine.lean) at commit 2f62970d, against [bispectral.md](../findings/bispectral.md) Lemma L52 and the L52 row of [lean/INDEX.md](../lean/INDEX.md). Analysis-only footing: Lean source and definitions were read, `lake build` and `lake env` were not run, so the kernel check and the axiom count are taken from the commit and not re-established here. One screen was run (seconds, numpy, padded `W_CP²` at `n = 4`), reported as a screen. Log: [agent_logs/review-r1726.log](../agent_logs/review-r1726.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | `one_line_record` states the record's one-line bound on the record's two spectra and objects, and is correct without Ricci-flatness | **CONFIRMED** |
| 2 | `one_line_theta` is the bound in its theta form | **CONFIRMED** (multiplier reading, see G1) |
| 3 | `one_line_strict` proves strictness at every unit Weyl tensor for every admissible `M₊`, `m`, and the equality step is sound using the mu side alone | **CONFIRMED** |
| 4 | Screen at padded `W_CP²`, `n = 4`: strict gap consistent with the record's figures | **CONFIRMED** (screen) |
| 5 | Docstrings and the INDEX row claim only what is typed | **PLAUSIBLE** (G2, G3, G4 are wording and bookkeeping, no false mathematics) |

**One line.** The three theorems are faithful compositions of `one_line_bound`, `L50_bispectral`, the trace lemmas and `strictly_loose`, the record's figures reproduce at `W_CP²`, and four small wording and bookkeeping gaps remain.

## 1. The objects and `one_line_record`

- **The record.** [bispectral.md:71](../findings/bispectral.md#L71): *"$W\in\mathrm{Weyl}_n$ with $n\ge4$ and $\lVert M\rVert_F=1$; $M_+$ is any constant with $\mu_i\le M_+$, $m$ any constant with $\omega_i\ge-m$, both frame-independent."* The one-line bound is *"$\theta\le\tfrac32(M_++m)$ (immediate from $\mu_i\le M_+$ and $\omega_i\ge-m$)"* ([bispectral.md:63](../findings/bispectral.md#L63)).
- **`μ` is the record's `μ`.** `Mpair R p q = R4 R p.1.1 p.1.2 q.1.1 q.1.2` over pairs `a < b` ([L54Schur.lean:31](../lean/HamiltonsCubic/Results/L54Schur.lean#L31)), with `R4 R i j k l = inner2 (R (phi i j)) (phi k l)`, so it is `M_{(ab),(cd)} = W_{abcd}` in the pair basis. `sum_mu_sq` ([SpectralTrace.lean:129](../lean/HamiltonsCubic/Results/SpectralTrace.lean#L129)) gives `∑ μ² = normSq R`, so `normSq R = 1` is the record's `‖M‖_F = 1`.
- **`ω` is the record's `ω`.** `Bmat (ringW R)` is `W̊` on `S²` in an orthonormal basis ([SecondKindMatrix.lean:193](../lean/HamiltonsCubic/Results/SecondKindMatrix.lean#L193)), and `sum_omega_sq` gives `∑ ω² = 3 normSq R`, the record's `p₂(ω) = 3` at `‖M‖_F = 1` ([bispectral.md:65](../findings/bispectral.md#L65), the normalisation-trap paragraph). At a Weyl tensor the `S²` spectrum is the `S²₀` spectrum plus one `0`, and `0 ≥ −m` is forced by `∑ ω = 0`, so `ω ≥ −m` on `S²` and on `S²₀` agree there (r1678's reading of `omega_lower_iff`).
- **`M₊`, `m`.** `hμ : ∀ j, μ j ≤ Mp` and `hω : ∀ j, −m ≤ ω j` are the record's two constants exactly, universally quantified as "any constant".
- **The hypothesis set.** `IsLinOp R`, bivector preservation, self-adjointness on bivectors and first Bianchi are `IsWeyl` ([WeylReal.lean:125](../lean/HamiltonsCubic/Base/WeylReal.lean#L125)) minus its Ricci clause, plus linearity. So the theorem's range contains every unit Weyl tensor and more.
- **No Ricci-flatness is needed, and the bound is still correct there.** The composition uses `sum_mu_sq` (no Bianchi), `sum_omega_sq` (Bianchi through `L50_norm`), `sum_mu_cube`, `sum_omega_cube` (neither needs Bianchi) and `L50_bispectral` (Bianchi) ([L50Spectra.lean:141](../lean/HamiltonsCubic/Results/L50Spectra.lean#L141)). `one_line_bound` ([L52Remarks.lean:89](../lean/HamiltonsCubic/Results/L52Remarks.lean#L89)) is termwise `μ³ ≤ M₊μ²` and `−ω³ ≤ mω²` and needs nothing else. So the theorem is a true strengthening of the record's claim to first-Bianchi operators.
- **Falsifier sought.** A unit first-Bianchi `R` with `P > (3/2)(M₊ + m)`. The proof is termwise, so none can exist once the three identities hold, and the identities are kernel lemmas used elsewhere (L52Frame). The screen in §4 shows positive slack on both sides.

## 2. `one_line_theta`

- **What it says.** At `IsCritical R θ`, that is `Q(R)(φ_ij) = θ R(φ_ij)` for all `i, j` ([WeylReal.lean:194](../lean/HamiltonsCubic/Base/WeylReal.lean#L194)), `Pcubic_eq_innerOp_Qop` and `innerOp_Qop_of_critical` ([L53CPm.lean:115](../lean/HamiltonsCubic/Results/L53CPm.lean#L115), [:122](../lean/HamiltonsCubic/Results/L53CPm.lean#L122)) give `P = θ normSq R = θ`, so `θ ≤ (3/2)(M₊ + m)`. The rewrite chain is correct, and the hypothesis is satisfiable (`WCPm_critical`, used at [L53CPm.lean:131](../lean/HamiltonsCubic/Results/L53CPm.lean#L131)).
- **Faithfulness.** The record's `θ` is the value `θ(W) = P/‖W‖³` at every unit `W` (the block evaluates it at padded `W_CP²` and on random Weyl tensors, [bispectral.md:63](../findings/bispectral.md#L63)), not only at critical points. That reading is `one_line_record` rewritten by `theta_of_unit` ([Families.lean:636](../lean/HamiltonsCubic/Base/Families.lean#L636)), one line, and is undeclared. `one_line_theta` reads `θ` as the Lagrange multiplier, which is the same number exactly at critical unit `R`, so it is a correct but narrower form (G1).

## 3. `one_line_strict`

- **The record's claim.** The phrase *"strictly loose at every unit Weyl tensor"* is absent from the current block (grep over `findings/` finds it only in [fence-posts.md](../findings/fence-posts.md) about a different relaxation). It comes from r1677 §6 and an earlier block form. The current block carries it as *"the strict one-line bound $\theta\le\tfrac32(M_++m)$"* ([bispectral.md:86](../findings/bispectral.md#L86)). Both mean the same thing: `P < (3/2)(M₊ + m)` at every unit Weyl `W`, for every admissible `M₊, m`.
- **The Lean proves exactly that.** Hypotheses are `IsLinOp` plus all four `IsWeyl` clauses plus `normSq R = 1`, with `Mp, m` universally quantified under `hμ, hω`. The conclusion is strict.
- **The equality step, checked by hand.** Assume `P ≥ (3/2)(M₊ + m)`. With `S₁ = ∑(M₊μ² − μ³) = M₊ − ∑μ³` (`e1`, uses `∑μ² = 1`) and `S₂ = ∑(mω² + ω³) = 3m + ∑ω³` (`e2`, uses `∑ω² = 3`), `hP` gives `(3/2)S₁ + (1/2)S₂ = (3/2)(M₊ + m) − P ≤ 0`. Both are sums of nonnegative terms (`t1`, `t2`), so `S₁ = 0` (`z1`), so each term `μ_j²(M₊ − μ_j) = 0` (`sum_eq_zero_iff_of_nonneg`), so `μ_j ∈ {0, M₊}`. With `∑μ = 0` (`sum_mu_zero`, [L50Traces.lean:53](../lean/HamiltonsCubic/Results/L50Traces.lean#L53), needs Ricci-flat) and `∑μ² = 1`, `strictly_loose` ([L52.lean:64](../lean/HamiltonsCubic/Results/L52.lean#L64)) gives `False`: `μ² = M₊μ` termwise, so `∑μ² = M₊∑μ = 0 ≠ 1`.
- **The ω side is legitimately unused.** Strictness of a sum of two nonnegative slacks needs only one to be positive. The μ slack alone is positive at every unit Ricci-flat `R`, so the ω slack's tightness never has to be analysed. This matches r1677 §6, which derives strictness from the μ side alone.
- **Falsifier sought.** A unit Weyl `W` whose `μ` takes only the values `0` and `M₊`. `∑μ = 0` with all `μ_j ∈ {0, M₊}` forces `M₊ · #{μ_j = M₊} = 0`, so `μ = 0`, contradicting `∑μ² = 1`. None exists, at any `n` and any `M₊` (including `M₊ ≤ 0`).

## 4. Screen at padded `W_CP²`, `n = 4` (screen, not evidence)

- **Object.** `W = 2aaᵀ − bbᵀ − ccᵀ` on unit self-dual bivectors `a = e₀₁+e₂₃`, `b = e₀₂+e₃₁`, `c = e₀₃+e₁₂` (each over `√2`), [Families.lean:769–826](../lean/HamiltonsCubic/Base/Families.lean#L769)'s `WCP2`, scaled to `‖M‖_F = 1`. `W̊ h_ij = ∑ W_{iklj} h_kl` as in `ringW`.
- **Results** (python3 with numpy, under a second):
  - Bianchi residual `0`, Ricci residual `0`.
  - `μ·√6 = (2, −1, −1, 0, 0, 0)`, as the brief states. `∑μ = 0`, `∑μ² = 1`.
  - `ω·√6 = (−2, −2, −2, 0, 1, 1, 1, 1, 1, 1)`. `∑ω = 0`, `∑ω² = 3`.
  - `P = (3/2)∑μ³ − (1/2)∑ω³ = 1.2247449 = √(3/2)`, the record's `θ`.
  - `M₊ = m = 2/√6 = 0.8164966`, one-line `= (3/2)(M₊ + m) = 2.4494897 = √6`, the record's `2.4495`, and `M₊ + m = √(8/3)`, matching `Mm_sq` in L52.lean.
  - Slacks: μ side `M₊ − ∑μ³ = 0.4082`, ω side `3m + ∑ω³ = 1.2247`, and `(3/2)(0.4082) + (1/2)(1.2247) = 1.2247 = √6 − √(3/2)`.
- **Reading.** The gap is positive and the μ slack is positive on its own, as `one_line_strict` requires: `−1/√6 ∉ {0, M₊}`. The sign convention for `ω` is the one that reproduces the record's `θ`, so the screen and the Lean sit in the same convention.

## 5. Docstrings and the INDEX row

- **The file header and docstrings** describe the three theorems as typed, with one exception (G2).
- **L52.lean's header** ([L52.lean:14–15](../lean/HamiltonsCubic/Results/L52.lean#L14)) still says the equality step and `∑μ = 0` "are not declared here". That stays literally true of L52.lean, so no repair is forced, though a pointer to L52OneLine would help a reader.
- **The INDEX row** (the new clause after `strictly_loose` in the L52 row) states `one_line_record`, `one_line_theta` and `one_line_strict` as typed, and correctly drops the theta form and r1677 G7 from the owed list. Its wording of the hypotheses is shorter than the types (G3), and its bookkeeping is incomplete (G4).

## Gaps

- **G1, [L52OneLine.lean:47](../lean/HamiltonsCubic/Results/L52OneLine.lean#L47).** `one_line_theta` reads `θ` as the critical multiplier. The record's `θ` is the value at every unit `W`, which is `one_line_record` plus `theta_of_unit` and is undeclared. Fix: add `theta R ≤ (3/2)(M₊ + m)` at unit `R` via `theta_of_unit`, or say in the docstring that the value reading is `one_line_record` by `theta_of_unit`.
- **G2, [L52OneLine.lean:57](../lean/HamiltonsCubic/Results/L52OneLine.lean#L57) and the header.** "Strictly loose at every unit Weyl tensor" is quoted as the record's phrase, but the current block says "the strict one-line bound" ([bispectral.md:86](../findings/bispectral.md#L86)) and the quoted words are r1677 §6's. Fix: anchor the docstring to bispectral.md:86.
- **G3, lean/INDEX.md L52 row.** "at a unit first-Bianchi $R$" omits linearity, bivector preservation and self-adjointness, which the types carry. Fix: name them, or say "at a unit first-Bianchi curvature operator".
- **G4, lean/INDEX.md L52 row.** The row's file column does not list L52OneLine.lean (nor L52DisplayTF, L52StairAll, L52Rot), and the new clause carries no axiom count for the three declarations. Fix: add the file and "3/3 on the standard three" once printed.

## What would break each claim, and what was done

| Claim | Falsifying object | What was done |
|---|---|---|
| 1 | A unit first-Bianchi `R` with `P > (3/2)(M₊+m)` | Read every lemma in the chain, confirmed each identity's hypotheses, screened `W_CP²` |
| 2 | A critical unit `R` with `θ ≠ P` | Read `IsCritical`, `Pcubic_eq_innerOp_Qop`, `innerOp_Qop_of_critical` |
| 3 | A unit Weyl `W` with `μ ⊂ {0, M₊}` | Derived the equality step by hand, shown impossible by `∑μ = 0` |
| 4 | Record figures that disagree with the Lean's convention | Screen reproduced `√(3/2)`, `√6`, `√(8/3)` and positive μ slack |
| 5 | A docstring or row clause claiming beyond the types | Read the header, docstrings, and the word diff of the INDEX row in 2f62970d |

## Overall verdict

**CONFIRMED WITH GAPS.** The three theorems are correct and faithful to L52's one-line bound and its strictness at every unit Weyl tensor. G1–G4 are wording and bookkeeping, and none of them touches the mathematics.
