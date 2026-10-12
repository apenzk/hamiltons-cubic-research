# Gate 2 review r1074: the fold of r1071/r1072, the L221 withdrawal, and the deficit factorisation

Round: one reader. Commits under review: `29775227`, `2460e4ae`, `bce39dfc`, and `097beb40` which landed mid-review and repairs two of the declarations below.
Log: [agent_logs/r1074-fold.log](../agent_logs/r1074-fold.log)

| claim | subject | verdict |
|---|---|---|
| D1 | the deficit factors, `s_lo = (√6-√3)/2` exactly, typed in [I110Deficit.lean](../lean/HamiltonsCubic/Results/I110Deficit.lean) | **CONFIRMED** as mathematics and as a Lean witness, with a defect in the record that stands |
| D2 | novelty of D1 against the record | **REFUTED IN PART**: the factorisation is new, the endpoint's closed form was on the record three minutes earlier |
| D3 | the withdrawal in `29775227`: the trade-off is L221 item 2 summed | **CONFIRMED**, with one over-concession |
| D4 | the four stale absence claims repaired in `2460e4ae` | **CONFIRMED**, all four, with one residue of the same wording |
| D5 | the fold in `bce39dfc`: F74's shares and the three F75 corrections | **CONFIRMED** on every number, **REFUTED** on two sentences left standing inside F74 |
| D6 | the two post-r1073 wording corrections in [lean/INDEX.md](../lean/INDEX.md) | **CONFIRMED**, accurate and not over-corrected |

## D1: CONFIRMED, and the mathematics is separable from the tactic

**The identity is exact, checked by hand before any machine.** With `θ = √6/2`, `θ² = 3/2` and `θ³ = 3√6/4`, the product `(s-θ)((s-θ)² - 3/4)` expands to `s³ - (3√6/2)s² + (15/4)s - 3√6/8`, which over nine is `s³/9 - √6 s²/6 + 5s/12 - √6/24`, term for term the file's `deficit`. Screened to `3e-17` at seven points spanning the window and beyond it. `s_lo = θ - √3/2 = (√6-√3)/2 = 0.35871946760715034`, against the record's `0.358719467607`.

**The certificate in `097beb40` is the right one.** Reducing `LHS - RHS` modulo `(a²-2, b²-3)` with `a = √2`, `b = √3` gives cofactors `(b²-3)(ab/72 - s/12) + (ab/24 - s/4)`, which is `b²(ab - 6s)/72`, and `ab/72 - 5s/36`. That is the committed pair exactly. The `nlinarith` it replaced is the wrong instrument for an equality and its failure was real: my own first run at 21:05 returned `linarith failed to find a contradiction` at line 353.

**Lean, verified here rather than taken.** `lake env lean` on both files: exit 0, linter warnings only, no error and no `sorry`. Axioms, printed in this session:

| declaration | axioms |
|---|---|
| `deficit_factors`, `deficit_at_sLo`, `sLo_eq`, `deficit_eq` | `propext`, `Classical.choice`, `Quot.sound` |
| `cubic_expand`, `tradeoff`, `a_eq_sum_g`, `P_N_eq_six_tau` | `propext`, `Classical.choice`, `Quot.sound` |

**`deficit_factors`' hypotheses, which the brief asked about.** It is stated at a general `s : ℝ` with no side condition, and `deficit` in that file is literally the prose's `d(s)`: [deficit_eq](../lean/HamiltonsCubic/Results/I110Deficit.lean) ties it to `-chainF s (uLo s)`, and reconstructing `F` independently from the source note's own formula gives `d(s_lo, 1) = 0` to forty digits. So the statement is the one the prose means, at `f = 1` on the equal-`Nᵢ` diagonal.

**THE DEFECT IN THE RECORD STANDS AND IS NOT REPAIRED BY THE FIX.** Commit `2460e4ae`'s body and [post F75](../findings/fence-posts.md) both describe the factorisation as checked and `T(D,D,N) = 0` as "now typed as `cubic_expand`". At the moment those words were committed neither declaration elaborated: `deficit_factors` failed on `nlinarith` and `cubic_expand` failed with an application type mismatch at line 128, `h.swap23 D D N` being offered where `T D N D = ?m` was wanted. A written-but-unverified result cited as established is the defect the layer exists to prevent, and it reached the findings file as well as the commit. That the author volunteered it does not reduce it.

## D2: REFUTED IN PART, and the premise of the novelty sentence is false

**What is new.** The full factorisation. `git log -S` across all refs finds "factors completely" only in `2460e4ae` and `097beb40` for this object, no statement anywhere that `d` has three real roots, and no occurrence of the third root `θ + √3/2 = 2.0908` in any form.

**What is NOT new.** The closed form of the endpoint.

- [REVIEW_r1071.md:91](REVIEW_r1071.md), committed 21:00:10, three minutes before `bce39dfc`: "*the endpoint solving that is $s_{\mathrm{lo}}=\theta-\tfrac{\sqrt3}2=\tfrac{\sqrt6-\sqrt3}2=0.358719467607$ with $u=\tfrac12$ exactly*". Derived from the pinch, `θ - √3 u_lo = fs` at `f → 1`, independently of any factorisation.
- [REVIEW_r1072.md:88](REVIEW_r1072.md), 21:00:06: `θ - √3/2 = 0.3587194676` as the infimum of the margin.
- [REVIEW_r1070.md:86](REVIEW_r1070.md), 20:25:59: `θ - √3/2 = 0.3587`, in the margin role, and `2460e4ae`'s own body cites that line.

**So [fence-posts.md:665](../findings/fence-posts.md)'s "the record carried $s_{\mathrm{lo}}$ only as the decimal $0.358719467607$" is false at the moment it was written**, and false about the two reviews the same commit folds and indexes. The display two lines above it, `s_lo = θ - √3/2 = (√6-√3)/2`, is r1071's own line. The clause the sentence ends on, "All three roots are `θ` and `θ ± √3/2`, which is new to the record", is true.

**The distinction worth keeping.** r1071 IDENTIFIED the endpoint with `θ - √3/2` from the pinch and matched the decimal. The factorisation PROVES the identification and supplies the other two roots. That is a real advance and it is not the one the sentence claims.

**Repair.** Replace the premise: the record carried `s_lo` as a decimal described as the root of `d(s) = 0`, [r1071](REVIEW_r1071.md) identified it as `θ - √3/2` from the pinch, and what is new here is the factorisation, which proves that identification rather than recognising it and gives the remaining two roots.

## D3: CONFIRMED, with one over-concession

**The source says it.** [second-order.md:925](../findings/second-order.md), L221 item 2: "*pairing the $\chi_{Q_i}$ equation with $\nu_i$ gives $\langle L_{q_i}\nu_i,\nu_i\rangle=\tfrac\theta2N_i-\tau$*", per block, in this exact setting. [second-order.md:915](../findings/second-order.md) records "*Gate 2 PASSED ([r941](REVIEW_r941.md), [r942](REVIEW_r942.md), all eight items CONFIRMED by both)*".

**The summation is the session's identity.** L220 step 4 gives `g_a = <D∘ν_a, ν_a> = <L_{q_a}ν_a, ν_a>`, so item 2 reads `g_a = (θ/2)N_a - τ` per block. Summing the three: `Σ g_a = θN/2 - 3τ`, and `N = 1 - t`, hence `Σ g_a + 3τ = θ(1-t)/2`. That is [tradeoff](../lean/HamiltonsCubic/Results/I111Tradeoff.lean) exactly. The per-block statement is strictly stronger, so the withdrawal is right and complete.

**THE OVER-CONCESSION.** `29775227`'s body says the per-block identity is "*Gate 2 passed by r941 and r942 and kernel-checked in `L221Statement.lean`*". It is not kernel-checked. [L221Statement.lean](../lean/HamiltonsCubic/Results/L221Statement.lean) types `nu_square_norm`, `per_block`, `sum_three` and `sum_two`, and its own docstring lists those three items. `per_block` takes `hu : θ ≤ s * u`, the pinning's CONSEQUENCE, as a hypothesis, and the chain as `hchain`. The identity appears nowhere in the file. The source's own line 915 is careful about this and says only that "the norm identity and the scalar steps" are kernel-checked.

**Why it matters in this direction.** A withdrawal that inflates the prior art is the mirror of an overclaim, and it leaves the record understating what the session added: the Lean typing of the pinning as an identity is still absent, and the commit reads as though it were already there. The withdrawal itself survives, prose passed by two Gate 2 readers being enough to put the identity on the record.

## D4: CONFIRMED, all four

| repair | check run here | verdict |
|---|---|---|
| (a) [AltAntisym.lean](../lean/HamiltonsCubic/Base/AltAntisym.lean), "exactly ONE `native_decide` TACTIC use" | grep over the whole tree, excluding prose | **TRUE**: `WCP2_sharp_one` at [RelationB.lean:58](../lean/HamiltonsCubic/Base/RelationB.lean). Every other occurrence of the word is a docstring |
| (b) [RelationBSharp.lean](../lean/HamiltonsCubic/Base/RelationBSharp.lean), the "better target" is already hit | `WCP2_bianchiOf`, `W33_bianchiOf` in [L34c.lean](../lean/HamiltonsCubic/Results/L34c.lean) | **TRUE**, and "this assembly is the tree's ONLY remaining `native_decide`" reads correctly: the assembly is `W # I = -W`, which is `WCP2_sharp_one`'s statement |
| (c) [L144Statement.lean](../lean/HamiltonsCubic/Results/L144Statement.lean) at three sites, `DiagCriticalityIsCritical` discharged | [SharpDiag.lean:806](../lean/HamiltonsCubic/Base/SharpDiag.lean) | **TRUE**: `diagCriticalityIsCritical` is a term proof, the file carries no live `sorry` (all six matches are prose), and the audit gives it `Classical.choice`, `Quot.sound`, `propext` |
| (d) [plan-lean.md](../plan-lean.md), "tainting 1 declarations" from a regenerated [lean/axioms.json](../lean/axioms.json) | parsed the JSON | **TRUE**: 5579 declarations, exactly one carrying `...WCP2_sharp_one._native.native_decide.ax_1_1`, and 68 carrying `sorryAx` |

**One residue.** [lean/INDEX.md:96](../lean/INDEX.md)'s L199 cell still reads "*The retirement STRENGTHENS the claim, the lemmas holding at every `R` where the tactic held at `diagTest`*" in the 2026-09-21 paragraph, the exact phrasing [r1073](REVIEW_r1073.md) corrected, one paragraph above the correction and in the same table cell. The same argument applies there: `Gmat_diagTest_ne_zero` states word for word what it stated, and what improved is the evidence. The repair was applied at one site of two.

## D5: the numbers reproduce, and two refuted sentences survive the fold

**REPRODUCED INDEPENDENTLY**, from the source note's own `F`, `u_lo(s,f) = (θ - fs)/√3`, `f_Gram = (θ - √(5t/3))/s` and `P(D) = (3/2)θt - θ/2 + 3τ`, with bisection for `f_d` and a 20001-point midpoint grid. No reviewer script read.

| quantity | this reader | the adopted figure |
|---|---|---|
| shares at `n = 6…12`, floor `max(f_Gram, f_d)` | 65.60 / 56.49 / 41.41 / 30.77 / 13.67 / 0 / 0 | 65.6 / 56.5 / 41.4 / 30.8 / 13.7 / 0 / 0 |
| shares under F74's Gram-only floor | 58.12 / 41.40 / 10.29 / 0 / 0 / 0 / 0 | the post's own printed row |
| the two floors cross | `s = 0.44197308`, `f = 0.891690422` | `s = 0.441973`, `f = 0.891690` |
| `n = 11` supremum of the forced ratio | 1.21558586978, at the left endpoint with `f = 1` | 1.21558587 |
| `Θ₁₁` and the shortfall | 1.2171612389, 0.12943 per cent | 1.21716124, 0.1294 per cent |

**And the direction of the deficit floor is right.** `d(s,f)` is INCREASING in `f`: at `s = 0.4` it runs `-0.1347`, `-0.0547`, `-0.0042`, `+0.0012`, `+0.0064` at `f = 0, 0.5, 0.9, 0.95, 1`. So `d > 0` is a lower bound on `f` and `max(f_Gram, f_d)` is the floor.

**The three F75 corrections.**

- **"Sum of three" rather than "the sixth resummed": CONFIRMED.** `θ(1-t) = 2Σg_a + 6τ` is the three block scalar equations added, and the `𝒟ₙ` shadow follows from it with `P(W) = θ`.
- **The third input `<D∘D, N> = 0`: CONFIRMED and genuinely needed.** `P(D+N) = P(D) + 3T(D,N,N) + P(N)` carries a `3T(D,D,N)` term otherwise, and it is that term's vanishing that lets `θt = P(D) + a` and `θ = P(W)` produce the second relation. Typed as [cubic_expand](../lean/HamiltonsCubic/Results/I111Tradeoff.lean), which now elaborates on the three standard axioms.
- **The `ψ ≡ 0` collapse is an ANSATZ: PLAUSIBLE, and THIS IS THE ITEM THE ROUND OWES A SECOND READER.** Every other claim in this brief is a comparison against something fixed. This one is an argument being made, that the `ν`-angles are fixed by the equations rather than by the shape angles, so equal shapes leave the `ν_a` free. It is reached by [r1071](REVIEW_r1071.md) and [r1072](REVIEW_r1072.md) and I can follow it, but there is no fixed object to check it against, and two readers who saw the same brief are not two independent derivations of a symmetry-breaking argument.

**TWO SENTENCES THE FOLD LEFT STANDING, BOTH NOW FALSE.**

1. **[fence-posts.md:647](../findings/fence-posts.md)**: "*Reading the MAXIMUM instead inflates the reach from $n\le8$ to $n\le10$ and manufactures a $0.13\%$ near-miss at $n=11$ that does not exist.*" Both halves are refuted by the fold's own row four lines above and by the rewritten heading: the reach IS `n ≤ 10` and the near-miss IS 0.1294 per cent. The same sentence's lead-in still ends "*and $f$ is bounded below by the Gram floor*", which is the error the fold exists to correct. The next sentence, "*the maximum is attained at the window's lower edge, where the deficit vanishes and there is nothing left to close*", is the reason [r1072](REVIEW_r1072.md) answers directly: the surviving set there has width `1.7e-4` in `f`, which is thin and not empty.
2. **[fence-posts.md:649](../findings/fence-posts.md)**: "*The forced ratio falls from $1.1572$ at the window's lower edge to $0.8570$ at the corner, a factor of $1.35$.*" 1.15719 is the ratio at the GRAM floor, the floor the post has just abandoned. Under the adopted floor it is 1.21559 and the factor is 1.4184. [r1072](REVIEW_r1072.md) flagged this figure explicitly and the fold adopted the rest of that verdict.

**One nit.** "*the deficit floor is the higher for every $s<0.4405$; the two cross at $s=0.441973$*" puts a slack bound next to the sharp one it follows from. The crossing gives "for every `s < 0.441973`" directly, and I confirm `f_d = 0.893115 > f_Gram = 0.885811` at `s = 0.4405`.

## D6: CONFIRMED, and not over-corrected

Both corrections are on disk at [lean/INDEX.md:96](../lean/INDEX.md) and both are accurate.

- "*The retirement STRENGTHENS THE EVIDENCE ([r1073](REVIEW_r1073.md) corrected "the claim"): the proposition is word for word what it was, and what improved is the axiom set together with the generality of the lemma beneath it.*" That is [r1073](REVIEW_r1073.md)'s C3 verdict, and it concedes the right amount: the axiom-set improvement and the general-`d` lemma are both named as gains.
- "*Cross-checked by two routes sharing no THEOREM above the bivector model, and [r1073](REVIEW_r1073.md) refuses the stronger "share nothing": both stand on `basis4`, `pair4`, `coord4`, `br` and the same `diagTest`, so a sign error IN THE MODEL is invisible to both.*" Accurate, and the sentence following keeps what the cross-check does buy rather than surrendering it.

The one gap is the residue recorded under D4: the superseded phrasing survives at the other site in the same cell.

## What the parent owes

1. **[fence-posts.md:647 and 649](../findings/fence-posts.md)**, the two refuted sentences, which are the highest-value item here: a post whose heading says the near-miss is real and whose body says it does not exist reads as either one depending on where the eye lands.
2. **[fence-posts.md:665](../findings/fence-posts.md)**, the novelty premise, replaced with the split between identification and proof.
3. **`29775227`'s "kernel-checked in `L221Statement.lean`"**, which the file does not support, and which understates what the session still owes.
4. **[lean/INDEX.md:96](../lean/INDEX.md)**'s surviving "strengthens the claim".
5. **A second reader on the `ψ ≡ 0` ansatz claim**, the only item in this brief that is an argument rather than a comparison.
