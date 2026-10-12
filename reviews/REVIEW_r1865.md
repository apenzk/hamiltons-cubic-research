# Gate 2 review r1865: SecondKindSharp.lean against its prose claim (I121)

Brief: [BRIEF_I121_secondkindSharp.md](BRIEF_I121_secondkindSharp.md). Note: [2026-09-28d-I121-smallmass-direct.md](2026-09-28d-I121-smallmass-direct.md). Lean: [SecondKindSharp.lean](../lean/HamiltonsCubic/Results/SecondKindSharp.lean) at 66302ece. Log: [agent_logs/r1865-i121-secondkindSharp.log](../agent_logs/r1865-i121-secondkindSharp.log). Footing: analysis only. The one computation is the audit script of item 4.

**Verdict: the Lean is the claim, its Cauchy–Schwarz gives exactly the record's constant, and the trace-free reduction is valid at a Ricci-flat operator. The note's own text around the new bullet lags it: one sentence still says the Lean proves only the weaker constant, and the Lean list and heading name only SecondKindE.**

| item | claim | verdict |
|---|---|---|
| 1 | statement fidelity | CONFIRMED, with a redundant `Nonempty ι` instance beside `n > 1` (C3) |
| 2 | prose follows the Lean | CONFIRMED on the mathematics, with stale sentences in the note (C1, C2) |
| 3 | agreement with the record's cap | CONFIRMED, the same constant, neither weaker nor stronger |
| 4 | axioms | CONFIRMED, rerun by this reviewer |

## Definitions read

- [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean): `Ric R a b = ∑_c inner2(R φ_ac, φ_bc) = ∑_c R4 a c b c`, and `IsWeyl` is skew preservation, bivector self-adjointness, first Bianchi and `∀ a b, Ric R a b = 0`.
- [SecondKind.lean](../lean/HamiltonsCubic/Results/SecondKind.lean): `ringW R h i j = ∑_{k,l} R4 i k l j h_kl`, `frob` the Frobenius pairing, `ringW_one`: `ringW R 1 = −Ric`, `trace_ringW`: `tr(ringW R h) = −frob(Ric, h)`.
- [SecondKindE.lean](../lean/HamiltonsCubic/Results/SecondKindE.lean): `secK R U p q = ∑ R4_abcd U_ap U_bq U_cp U_dq`, `E_le`, `neg_frob_ringW`, `eigen_expand`, `quad_eigen`, `frob_eigen`, `secK_diag`, all Gate 2 passed at [r1861](REVIEW_r1861.md).

## Item 1, statement fidelity: CONFIRMED

- `vertex_quad_sq_le`: for `K` with `K_pp = 0`, `∑_q K_pq = 0` and `∑ e = 0`, `(∑ K_pq e_p e_q)² ≤ (∑ K_pq²)·(n−2)/(n−1)·(∑ e²)²`, with `n = Fintype.card ι > 1`. This is the docstring's claim. The proof spends hollowness only through `∑_p K_pp = 0`, so the stated hypotheses are stronger than the proof needs, which is harmless.
- `rowsum_secK`: `∑_q secK R U p q = 0` for `UᵀU = 1` under `∀ a b, Ric R a b = 0`. Checked by hand: `∑_q U_bq U_dq = δ_bd` (from `UUᵀ = 1`), so the row sum is `∑_{a,c} U_ap U_cp ∑_b R4 a b c b = ∑_{a,c} U_ap U_cp Ric(a,c)`, which is `Ric(u_p, u_p)` as the docstring says and zero under the hypothesis.
- `ringW_sub_smul_one`: `ringW R (h − s·1) = ringW R h`, from linearity of `ringW` in `h` and `ringW R 1 = −Ric = 0`.
- `frob_ringW_traceless`: `frob(W̊(h − s·1), h − s·1) = frob(W̊h, h)` for every `s`, which contains the docstring's `s = tr h / n`. The step is `frob(W̊h, s·1) = s·tr(W̊h) = −s·frob(Ric, h) = 0`.
- `frob_traceless_le`: `‖h − (tr h/n)1‖² = ‖h‖² − (tr h)²/n ≤ ‖h‖²`, stated on squared Frobenius norms, which is what the uses need.
- `neg_frob_ringW_le_traceless` and `neg_frob_ringW_le_sharp`: under `∀ U, UᵀU = 1 → ∑ secK² ≤ B`, `−⟨W̊h, h⟩ ≤ √((n−2)/(n−1)) √B ‖h‖²`, first on symmetric trace-free `h`, then on every symmetric `h` by the reduction. These are the docstrings.
- `E_le_tmax_sharp`: `Pcubic R − (3/2) trCube R ≤ (3/2) √(2(n−2)/(n−1)) t · normSq R` for `t ≥ 0` under `∑ secK² ≤ 2t²` in every orthonormal frame. With `Pcubic − (3/2) trCube = E` and `normSq = ‖W‖²` ([r1861](REVIEW_r1861.md) item 1), this is the docstring's display.
- **The Ricci-flat hypothesis is the record's**: `hRic : ∀ a b, Ric R a b = 0` is verbatim the fourth clause of `IsWeyl`, with the same `Ric`. The remaining hypotheses of `E_le_tmax_sharp` are `IsLinOp R` and the other three `IsWeyl` clauses (`hskew`, `hsym`, `hB`), so the theorem holds on all of `Weyl_n`.
- **Size hypotheses.** `hn : 1 < n` is the only one in substance, used for `n − 1 ≠ 0` in the Cauchy–Schwarz. The section also carries `variable [Nonempty ι]` (line 210), which `frob_traceless_le` uses to divide by `n` and which therefore sits in the signatures of `neg_frob_ringW_le_sharp` and `E_le_tmax_sharp` as an instance argument. It follows from `hn`, so it adds no content, but the brief's "n > 1 is the only size hypothesis" holds in substance only (C3). At `n = 2` the constant is `0` and the statement reads `E ≤ 0`, consistent since `Weyl_2 = 0`.
- No `sorry`, `admit` or `axiom` in the file, and it is imported at HEAD in [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) (line 1083).

## Item 2, the prose follows the Lean: CONFIRMED on the mathematics

- **The Cauchy–Schwarz constant, derived.** Put `X = eeᵀ − c(I − J/n)` and `S = ∑ e²`. Then `⟨K, X⟩ = eᵀKe − c·tr K + (c/n)·𝟙ᵀK𝟙 = eᵀKe` by hollowness and zero row sums. And `‖X‖² = S² − 2c(S − (∑e)²/n) + c²‖I − J/n‖²`, with `‖I − J/n‖² = n((1 − 1/n)² + (n−1)/n²) = n − 1`. At `∑ e = 0` this is `S² − 2cS + c²(n−1)`, minimised at `c = S/(n−1)` with value `S²(1 − 1/(n−1)) = S²(n−2)/(n−1)`. So `(eᵀKe)² ≤ ‖K‖²_F ‖X‖² = ‖K‖²_F (n−2)/(n−1) S²`, exactly the stated constant. The Lean's `e3` computes the same row by row (`t1`, `t2`, `t3`) and closes by `field_simp; ring`. The choice of `c` is the optimal one, so the file's route extracts all the Cauchy–Schwarz can give against this family.
- **The trace-free reduction is valid at a Ricci-flat operator.** `W̊1 = −Ric = 0` and `tr(W̊h) = −⟨Ric, h⟩ = 0` together give `⟨W̊(h − s1), h − s1⟩ = ⟨W̊h, h⟩` for every `s`, and the trace-free part has smaller norm, so the bound on `S²_0` transfers to `S²` with the same constant. The eigenvalues of the trace-free part sum to zero (`hsum` in `neg_frob_ringW_le_traceless`, from `tr h = ∑ e_p` via `UᵀU = 1`), which is the `∑ e = 0` the Cauchy–Schwarz spends. At a non-Ricci-flat operator the first equality fails, so the hypothesis is load-bearing.
- **The 0.3% figure.** The ratio of the two constants is `√((n−1)²/(n(n−2)))`, which is `√(169/168) = 1.0030` at `n = 14`. Correct.
- **Stale text in the note (C1, C2).** The frame-quantity bullet (line 134) still says "The Lean below proves the slightly weaker `μ ≤ √(2(n−1)/n) t_max`", which the next bullet (line 135) now contradicts by calling both bounds typed. The Lean bullet (line 140) lists SecondKindE's declarations only, and the section heading (line 128) states the weaker constant. The node threshold (line 136) is derived from the weaker constant, `t_max² ≥ (2/9)·n/(n−1)·ε_n²`. The sharp constant gives `(2/9)·(n−1)/(n−2)·ε_n²`, larger by the factor `(n−1)²/(n(n−2))` (`1.0019` at `n = 24`, where `0.00871` becomes `0.00873`, still below `0.01`), so no conclusion of the note changes, but the note can now state the sharper threshold and cite the typed bound for it.

## Item 3, agreement with the record's cap: CONFIRMED

- The record's cap ([bispectral.md](../findings/bispectral.md), r555, r556) is `μ = vᵀK^F v ≤ μ_1(K^F) ≤ √(t_F(n−2)/(n−1))` with `t_F = ‖K^F‖²_F`, spending `K^F𝟙 = 0`. Read at `t_F ≤ 2t_max²` it is `μ ≤ √(2(n−2)/(n−1)) t_max`.
- `neg_frob_ringW_le_sharp` at `B = 2t²` and a unit bottom eigenvector `h` gives `μ = −⟨W̊h, h⟩ ≤ √((n−2)/(n−1)) √2 t`, the same constant. It is proved by a different route (a direct Cauchy–Schwarz on the quadratic form over `𝟙^⊥`, where the record bounds the top eigenvalue of `K^F` on `𝟙^⊥`), and the two constants coincide: the record's `μ_1(K) ≤ √(t(n−2)/(n−1))` is the eigenvalue-spread bound on a trace-zero matrix of rank `n − 1` on `𝟙^⊥`, whose extremal ratio is the same `(n−2)/(n−1)`.
- The frame hypothesis is quantified over every orthonormal frame, where the record's cap is used in the eigenframe of `h` only. With `t = t_max` the hypothesis is the definition `κ² = 2t_max²` ([L94](../findings/bispectral.md), normalisation confirmed at [r1861](REVIEW_r1861.md) item 3), so it is the record's reading and not an extra assumption.
- The step from `μ` to `E` is `E_le` (trace positivity, `E ≤ (3/2) μ ‖W‖²`), already Gate 2 passed. So `E_le_tmax_sharp` is exactly the record's cap read at `t_F ≤ 2t_max²` and composed with trace positivity, neither weaker nor stronger.

## Item 4, axioms: CONFIRMED

- The toolchain was free at the check, and `python3 scripts/misc/axiom_audit.py --only SecondKindSharp` printed "auditing 8 declarations across 1 files" and "8/8 clean -- resting on the standard three alone", the brief's quoted output reproduced. The eight are the eight declarations of item 1. SecondKindSharp.lean and SecondKindE.lean match HEAD in the working tree, so the run audits the reviewed text.

## Corrections for the author

- **C1.** In the note's frame-quantity bullet (line 134), replace "The Lean below proves the slightly weaker ..." with a sentence saying both constants are typed: the sharp one in SecondKindSharp.lean, spending `K_F𝟙 = 0` and `∑ e = 0`, and the hollow-only one in SecondKindE.lean.
- **C2.** Add SecondKindSharp.lean's declarations (`vertex_quad_sq_le`, `rowsum_secK`, `frob_ringW_traceless`, `frob_traceless_le`, `neg_frob_ringW_le_sharp`, `E_le_tmax_sharp`) to the note's Lean bullet (line 140), update the heading (line 128) to the sharp constant, and optionally restate the node threshold (line 136) as `(2/9)·(n−1)/(n−2)·ε_n²`, which changes no conclusion.
- **C3.** Optional, in the Lean: derive `Nonempty ι` from `hn` inside `neg_frob_ringW_le_sharp` rather than carrying it as a section instance, so that `hn` is literally the only size hypothesis of `E_le_tmax_sharp`.
