# REVIEW r1868: the Λ² loss of the E route bounded by the index concentration of W

**Standfirst.** Cold Gate 2 read (reader one of two) of the block "The Λ² loss is the index concentration of W" in [the working note](2026-09-28d-I121-smallmass-direct.md), against [BRIEF_I121_indexconc.md](BRIEF_I121_indexconc.md) at commit 5919f267 and [IndexConcentration.lean](../lean/HamiltonsCubic/Results/IndexConcentration.lean). I read Lemma L198, Lemma L199 and "The first free invariant" in [bounds.md](../findings/bounds.md), the record's index formula for # in [diagonal-half.md](../findings/diagonal-half.md) (Step 2 of the su(2) sharp), the g_k and G₂ row of [conventions.md](../findings/conventions.md), the screen [screen_I121_index_concentration.py](../scripts/misc/screen_I121_index_concentration.py) and the helper it imports. Computation was limited to seconds-scale checks on objects constructed for the purpose: the record's # built from its structure constants on Λ²ℝ⁴ and Λ²ℝ⁶, evaluated at padded W_CP², CP³, Λ²₊'s projection and nine random Weyl tensors, plus the table's arithmetic. No sweep, no search, no lake run. Log: [agent_logs/r1868-i121-indexconc.log](../agent_logs/r1868-i121-indexconc.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The weighted rows, θ p₃ = p₄ + ½S | CONFIRMED |
| 2 | p₄ ≤ 1/θ² | CONFIRMED |
| 3 | The sign drop, ½S ≤ tr(G#G) | CONFIRMED |
| 4 | The coordinate formula and the index bound | REFUTED as written. The coordinate formula is wrong, the step tr(G#G) ≤ ½Σr_k² is false for symmetric G and false in some frames for Weyl W. The end bound tr(W²#W²) ≤ ⅛‖N‖²_F is an exact identity minus a quartic Q whose sign is open, and it holds on every tensor checked (equality at padded W_CP²) |
| 5 | The combined inequality and its table | PLAUSIBLE: algebra and table confirmed to every digit, isotropy claims confirmed, conditional on item 4's end bound |
| 6 | Scope | PLAUSIBLE with corrections: conditional on item 4, and the argument gives more than exact isotropy from n = 30 |
| 7 | Classification | Steps 1 and 3 are on the record (bounds.md's S₂₂ identity with g_k ≥ 0, equivalently L199 weighted by λ_k²). The ‖N‖_F bound on tr(W²#W²) is new to the record |

**Summary.** The chain up to θ p₃ ≤ p₄ + tr(W²#W²) is correct and is already on the record in another form. The step that makes the block new, tr(W²#W²) ≤ ⅛‖N‖²_F, rests on a coordinate formula for # that keeps only the k = l slice of a double sum, and the argument as written would prove the bound for every positive semidefinite G, where it is false. The end bound itself survives every check and reduces to the sign of one explicit quartic, so the block's conclusions stand as conditional on a stated lemma.

## 1. The weighted rows

L198's row k is λᵀT⁽ᵏ⁾λ = 2λ_k(θ − λ_k) with T_{αkγ} = c²_{αkγ}. Multiplying by ½λ_k² and summing over k gives Σ_k λ_k³(θ − λ_k) = θp₃ − p₄ on the left and ½Σ_{k,α,γ} c²_{αkγ} λ_k²λ_αλ_γ on the right. Since c is totally antisymmetric, c² is totally symmetric, so c²_{αkγ} = c²_{kαγ} and the right side is ½S. The row is criticality (C), so the identity holds at critical points only, which is where the block uses it. CONFIRMED. At padded W_CP² (λ = (2, −1, −1, 0, …)/√6, θ = √6/2) both sides are ½ − ½ = 0, consistent with L198 being sharp there.

## 2. p₄ ≤ 1/θ²

The first display gives θλ_max ≤ 1, so λ_max ≤ 1/θ at θ > 0. The second gives θ|λ_min| ≤ 1 − 2λ²_min ≤ 1, so |λ_min| ≤ 1/θ. Then p₄ = Σλ_k²·λ_k² ≤ max_k λ_k² · p₂ and p₂ = 1 at unit norm, which the block uses silently in "p₄ ≤ max(λ²_max, λ²_min)". CONFIRMED. Wording: "below 1/θ" is "at most 1/θ", equality holding at padded W_CP² (λ_max = 2/√6 = 1/θ).

## 3. The sign drop

With the record's formula (W#)_{ab} = ½Σ c_{acd}c_{bef}W_{ce}W_{df} ([diagonal-half.md](../findings/diagonal-half.md), anchored by I#I = (n − 2)I), an operator diagonal in the eigenbasis φ has (A#B)_{mm} = ½Σ_{k,l} a_k b_l c²_{klm}, so tr(G#G) = ½Σ_{k,l} λ_k²λ_l² Σ_m c²_{klm} = ½Σ_{k,l} λ_k²λ_l²‖[φ_k, φ_l]‖². AM–GM with c² ≥ 0 symmetric in α, γ and λ_k² ≥ 0 gives ½S ≤ that quantity. CONFIRMED, and [weighted_sign_drop](../lean/HamiltonsCubic/Results/IndexConcentration.lean) is exactly this step.

**The deficit is on the record, exactly.** bounds.md's "first free invariant" writes S₂₂ = 2tr(W²#W²) = 2θ tr W³ − 2tr W⁴ + ½G₂ at a critical point, with G₂ = Σ_k λ_k² g_k and g_k = ‖[ad(v_k), W]‖² ≥ 0. Hence θp₃ − p₄ = tr(G#G) − ¼G₂, the sign drop's loss is ¼G₂, the second λ-moment of the orbit-tangent norms, and the step is L199's θλ_k ≤ λ_k² + ½R_k weighted by λ_k² (item 7).

## 4. The coordinate formula and the index bound

**The formula is the k = l slice of a double sum.** From the record's index formula, the pairs (β, γ) with c_{βγ,ij} ≠ 0 are (ik, jk) and (jk, ik) for k ∉ {i, j}, so for symmetric G, with sign-adjusted basis vectors x_k = ±e_{ik}, y_k = ±e_{jk} chosen so that [x_k, y_k] = e_{ij},

(G#G)_{ij,ij} = Σ_{k,l ∉ {i,j}} ( G(x_k, x_l) G(y_k, y_l) − G(x_k, y_l) G(y_k, x_l) ).

The block's Σ_k (G_{ik,ik}G_{jk,jk} − G²_{ik,jk}) is the k = l part. The two checks the brief names cannot separate them: at a diagonal G every k ≠ l term vanishes, and I is diagonal. A random symmetric G on Λ²ℝ⁴ gives (G#G)_{01,01} = 7.767 against 5.750 from the block's formula.

**The index step fails, analytically, for symmetric G.** Take G = P₊, the projection onto Λ²₊ℝ⁴. The record has (P₊)# = 2P₊ (`sharp_sd`, diagonal-half.md), so tr(P₊#P₊) = 6. In the standard frame every G_{ik,ik} = ½, so r_k = 3/2 and ½Σ_k r_k² = 9/2 < 6. The block's chain, stated "in any frame" for G = W² ⪰ 0 but using nothing about W beyond G ⪰ 0 symmetric, would give 6 ≤ 9/2.

**It also fails in some frames for Weyl W.** At padded W_CP² in ℝ⁶, tr(G#G) = ½ (= Σ_{a≠b} g_ag_b with g = (4, 1, 1)/6 and ‖[φ_a, φ_b]‖² = 2 on Λ²₊). In the standard frame Σ_{i<j}Σ_k R_ikR_jk = ¼, below ½, so the first inequality of the bullet already fails there, and ½Σr_k² = ½ recovers the bound only through the discarded R²_ik terms. In a random frame of ℝ⁶, ½Σr_k² = 0.361 < ½. Further, "tr(G#G) ≤ ½Σr_k² in any frame" would give tr(G#G) ≤ ⅛·min_frames Σ_k N²_kk = 2/n for every unit Weyl tensor, which padded W_CP² contradicts at every n ≥ 5. The same failure of Σ_{i<j}Σ_k R_ikR_jk ≥ tr(G#G) shows at CP³ (0.155 against 0.279) and at random Weyl tensors (0.299 against 0.322 at n = 5, 0.212 against 0.218 at n = 8).

**What the end bound is, exactly.** Writing Φ_a for φ_a as a skew matrix in the record's units (e_{ij} ↔ E_{ij} − E_{ji}, so ‖φ‖² = ½‖Φ‖²_F), ‖[φ_a, φ_b]‖² = tr(Φ_a²Φ_b²) − tr((Φ_aΦ_b)²), and N = −2Σ_a g_aΦ_a². Hence, for every symmetric G = Σ_a g_a φ_aφ_aᵀ,

tr(G#G) = ⅛‖N_G‖²_F − ½Q,  Q = Σ_{a,b} g_a g_b tr((Φ_aΦ_b)²) = Σ_{ijkl} G(ij,kl) G(jk,li),

with N_G = −2Σg_aΦ_a², which is the block's N at G = W². Checks: at G = I, Q = n² − n and the identity returns (n − 2)·n(n − 1)/2. At random Weyl tensors at n = 6, 8 both sides agree to six digits, with Q = 0.196 and 0.114. So **tr(W²#W²) ≤ ⅛‖N‖²_F is equivalent to Q(W²) ≥ 0**. Q is negative at P₊ (Q = −3 in unit normalisation), so any proof must spend the Weyl structure. At n = 4 it holds: on a self-dual W with Λ²₊-spectrum (x, y, z), Q ∝ Σx⁴ − 2Σx²y², which vanishes by x + y + z = 0 (Heron's factorisation), and the Λ²₊ × Λ²₋ cross terms are traces of squares of symmetric matrices, so nonnegative. That is where padded W_CP²'s equality comes from. At n ≥ 5 the sign of Q(W²) is open, and it holds on every tensor checked here and in the screen.

**The remaining links hold.** R_ik = ‖Me_{ik}‖² = G_{ik,ik}, r_k = ½N_kk and tr N = 4 were confirmed numerically in the record's normalisation, and Σ_k N²_kk ≤ ‖N‖²_F. [rowsum_sq_le](../lean/HamiltonsCubic/Results/IndexConcentration.lean) is a true statement about R ≥ 0, and it is the formula it would be fed by that fails. The screen tests tr(G#G) and ½Σr_k² in the identity frame only, and never evaluates the per-entry formula, which is why it passed.

Verdict: REFUTED as written. The end bound is PLAUSIBLE, screened only, and reduces to Q(W²) ≥ 0.

## 5. The combined inequality and its table

θ² = (3/2)θp₃ + θE ≤ (3/2)(p₄ + ½S) + θC_n t_max ≤ 3/(2θ²) + (3/16)‖N‖²_F + θC_n t_max, using θ = (3/2)p₃ + E (L50), θ > 0 for θE ≤ θC_n t_max, and items 1 to 4. This is [theta_sq_le](../lean/HamiltonsCubic/Results/IndexConcentration.lean) exactly. The comparison with θ² ≤ 3/2 + θE is right: (3/2)θ⁻² + (3/16)ν < 3/2 iff ν < 8(1 − θ⁻²). ‖N‖²_F ≥ (tr N)²/n = 16/n by Cauchy–Schwarz, with equality iff N = (4/n)I.

**Table.** With θ₀(n) = √(2(n−1)(n−2))/n and f(θ) = θ − 3/(2θ³) − 3/(nθ), increasing in θ, the threshold is t²_max ≥ (f(θ₀)/C_n)². Recomputed: 0.0286, 0.0640, 0.0972, 0.1341, 0.1497 at n = 14, 20, 30, 60, 100, the old thresholds 0.00128 and 0.0224, and the limit (√2 − 3/(4√2))²/4.5 = 0.1736. All match. The crossover with 3/(n+2) is at n = 30 exactly: n = 29 gives 0.0948 against 0.0968, n = 30 gives 0.0972 against 0.0938, and the gap widens after since one side increases and the other decreases. At odd n the value to beat is Θ_n, and the threshold with Θ_n still exceeds 3/(n+2) (0.0995 against 0.0909 at n = 31).

**Isotropy.** At CP^m, N commutes with U(m) acting irreducibly on ℝ^{2m} with commutant ℂ, so N = aI + bJ with b = 0 by symmetry. At a balanced product N = aI_p ⊕ bI_p and the swap forces a = b. At n = 4, N = I. CP³ confirms numerically (‖N‖²_F/8 = 1/3 = 2/n). CONFIRMED.

Verdict: PLAUSIBLE, conditional on item 4's end bound.

## 6. Scope

- The sentence "from n = 30 the band below the CP^m scale is empty for index-spread tensors" is stated at the strength of exact isotropy, which the parenthetical defines. It inherits item 4's open lemma and must say so.
- The argument gives more than exact isotropy. The band t²_max < 3/(n+2) is cleared whenever ‖N‖²_F ≤ ν*(n) with ν*(n) = (16/3)(θ₀² − 3/(2θ₀²) − θ₀C_n√(3/(n+2))): ν*(30) = 0.618 against 16/n = 0.533, ν*(40) = 1.50, ν*(60) = 2.53, ν*(100) = 3.54. At n = 30 the margin is a factor 1.16, at n = 100 a factor 22. This positive statement is the one to record.
- "The band splits by ‖N‖_F" is correct in that the bound is monotone in ‖N‖²_F. "Cleared up to a threshold rising to about 0.17" is the exact-isotropy value only.
- "Concentrated on few directions" for ‖N‖²_F > ν*(n) is accurate for N as an operator on ℝⁿ (eigenvalues summing to 4 with large square sum), which is index concentration rather than concentration of M on Λ².
- The lead's "a quantity the value controls" is unsupported by the block: the inequality ties ‖N‖_F to θ and t_max, and nothing in the block bounds ‖N‖_F by θ.

## 7. Classification

- **Items 1 and 3 together are on the record.** [bounds.md](../findings/bounds.md) "The first free invariant, made basis-free" has S₂₂ = 2tr(W²#W²) = 2θ tr W³ − 2tr W⁴ + ½G₂ at a critical point, and conventions.md has g_k ≥ 0, so θp₃ − p₄ ≤ tr(W²#W²) with deficit ¼G₂ is one line from there. It is also L199 (θλ_k ≤ λ_k² + ½R_k, Gate 2 r842, r843) weighted by λ_k² ≥ 0, since ½Σλ_k²R_k = tr(W²#W²). The weighted identity of item 1 also appears in [2026-09-28f-LIT-step8-sweep.md](2026-09-28f-LIT-step8-sweep.md) from this session.
- **Item 2** is L198 with p₂ = 1, and p4_le is its scalar form.
- **The bound of tr(W²#W²) by ‖N‖_F is new.** [LIT-invariants.md](LIT-invariants.md) records no literature name for tr(W²#W²), the record bounds S₂₂ nowhere by ‖N‖_F, and the ‖N‖_F occurrences in r379 and r383 concern a different matrix. The identity tr(G#G) = ⅛‖N‖²_F − ½Q does not appear in the record.
- The note should cite S₂₂, L199 and G₂ at steps 1 and 3 in place of re-deriving them, and name the drop's loss ¼G₂.

## Lean

The four declarations prove what their docstrings say and match the steps they are attached to. The file's "Not typed" list names the coordinate formula for #, which is the step this review refutes, so no Lean statement is wrong. The Lean table's "the index step: rowsum_sq_le" describes a true scalar lemma whose input the block computes with a wrong formula, so the table should say the index step is untyped at its # end.

## Corrections for the author

1. Replace the bullet "The commutator mass is the index concentration" with the exact identity tr(G#G) = ⅛‖N‖²_F − ½Q, Q = Σ_{a,b} g_ag_b tr((Φ_aΦ_b)²), and state tr(W²#W²) ≤ ⅛‖N‖²_F as a conjecture (equivalently Q(W²) ≥ 0), screened, proved at n = 4, equality at padded W_CP², false for general G ⪰ 0 (G = P₊: 6 against 9/2).
2. Remove the coordinate formula (G#G)_{ij,ij} = Σ_k(…) and the "in any frame" claims, or replace the formula by the double sum over k, l.
3. Mark the display and the table conditional on correction 1's conjecture, and change "(derived, Gate 2 owed)" accordingly.
4. At step 1 and 3 cite bounds.md's S₂₂ identity and L199, and name the sign drop's loss as ¼G₂.
5. Replace the exact-isotropy scope sentence with the ν*(n) statement (band cleared when ‖N‖²_F ≤ ν*(n), 0.618 at n = 30, 2.53 at n = 60, 3.54 at n = 100), and drop "a quantity the value controls".
6. Extend the screen to evaluate the per-entry formula against the true (G#G)_{ij,ij} and to test the frame claims in rotated frames, and record Q beside tr(G#G).
7. In the Lean table, mark the index step's # end as untyped, and in item 2 write "at most 1/θ" and name p₂ = 1.
