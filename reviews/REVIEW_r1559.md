# Review r1559: L167's stabiliser on so(4) (commit 099670c9), I117's Lemma E at the operator (commit c4183221) and L141's constant (commit 5f8f7bc6)

**Standfirst.** [L167Stab.lean](../lean/HamiltonsCubic/Results/L167Stab.lean), [I117LemmaE.lean](../lean/HamiltonsCubic/Results/I117LemmaE.lean) and [L141.lean](../lean/HamiltonsCubic/Results/L141.lean) build (warnings only, unused simp arguments at [L167Stab.lean:158](../lean/HamiltonsCubic/Results/L167Stab.lean#L158)) and audit 20/20, 2/2 and 6/6 on the standard three, with no `sorry`, `admit` or `native_decide`. `stab_so4` is L167's second display on so(4) exactly, and `idempotent_iff` is Lemma E's conclusion from the proof's own inputs. The constant 3θ₀(n)/(n−2) is the record's. The gaps are row text and headers: the L167 (statement) row still calls the second display unstated, the L262 row calls a typed statement untyped, the Lemma E header names a hypothesis the lemma does not use, and one r1554 residue stands at [lean/INDEX.md:29](../lean/INDEX.md#L29).

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `stab_so4` states L167's so(4) stabiliser as ℝJ₀ ⊕ Λ⁻ at n = 4, with `Wc 4`, CP2Real's J and L178Asd's K | **CONFIRMED** |
| A-1b | J₀ is the μ-eigenvalue-2 direction | **CONFIRMED** (`mu 0 = 2/√6` against `−1/√6` twice, ratio 2 : −1 : −1, `Wc4_J`) |
| A-1c | ρ(A) commuting with u read as [A, Wc X] = Wc [A, X] on skew X | **CONFIRMED** |
| A-1d | the L167 owed list (assembly at general n, orbit dimension) is complete | **CONFIRMED WITH GAP** (the row and docstring assert ≅ 𝔲(2) and dimension 4, which the file does not prove, and the owed list does not name them) |
| A-2a | `SymmetricPair` carries exactly Lemma E's proof inputs | **CONFIRMED** (the fields are the proof's first step's output, `2α = c` and `c_k + β = c` its two trace relations) |
| A-2b | `idempotent_iff` states Lemma E's conclusion, under the lemma's nonvanishing hypotheses | **CONFIRMED** (c, c_k, β ≠ 0 are weaker than the lemma's c, c_k, β > 0) |
| A-2c | Lemma E and the L262 row are unaffected by L263's SU(3) ⊂ G₂ counterexample | **CONFIRMED** (SU(3) ⊂ G₂ is no symmetric pair) |
| A-2d | the header and the L262 row describe the file accurately | **GAP** (header adds "𝔭 irreducible", row says "statement: not typed") |
| A-2e | no duplication of `sympair_idem` | **CONFIRMED** (overlap only: `idempotent_iff` is the operator-level iff, `sympair_idem` the scalar forward half) |
| A-3 | c_n = 3θ₀(n)/(n−2) is the record's, and row 141, `c_decays` and the L141 row agree | **CONFIRMED** |
| A-4 | r1554 gaps 1–6 repaired | **CONFIRMED WITH GAP** (all six closed in their files, [lean/INDEX.md:29](../lean/INDEX.md#L29) still lists L141 among files naming Alt's absence) |
| B | builds, standard axioms, heartbeat comments | **CONFIRMED** |
| C | no stale "untyped" so(4) stabiliser, no remaining 2.464 as L141's constant | **CONFIRMED WITH GAP** (the L167 (statement) row) |
| D | style of the markdown edits | **CONFIRMED WITH GAP** (one semicolon splice in the L262 row, one in a new Lean header) |

**Summary: the three commits are sound and faithful, and six text-level gaps remain, none touching a proof.**

## 1. L167Stab.lean against Lemma L167 (A-1)

- **The statement.** [route-a.md](../findings/route-a.md), Lemma L167, second display, 𝔰𝔱𝔞𝔟(u) = 𝔲(2) ⊕ 𝔰𝔬(m), with the so(4) part identified in "Then the dimension is addition" as the complementary summand (3 dimensions) plus the stabiliser of diag(2,−1,−1) in 𝔰𝔬(3) (1 dimension, the eigenvalue-2 direction J). `stab_so4` ([L167Stab.lean:140](../lean/HamiltonsCubic/Results/L167Stab.lean#L140)) says: a skew A on ℝ⁴ satisfies A·Wc 4 X − Wc 4 X·A = Wc 4 (AX − XA) for every skew X iff A = pJ₀ + Σ_a q_a K_a. That is the paragraph's conclusion at n = 4 with both of its pieces merged: the K_a span the summand complementary to u's support (JK_comm makes them commute with every J_b, hence with Wc 4), and pJ₀ is the 1-dimensional stabiliser of the ratio-(2,−1,−1) operator inside the J-summand.
- **The support.** `Wc_four` gives Wc 4 X = Σ_a ½ μ_a ⟨X, J_a⟩ J_a, so u lives on span{J_a}, and CP2Real's `om` is J_a/√2 under the identity embedding at n = 4 (`Emb_four`, `om_four`). J and K commute entrywise (`JK_comm`) and are inner2-orthogonal (`inner2_KJ`), so they are the two summands Λ^± whatever the orientation label. The file's naming (J self-dual, K anti-self-dual from [L178Asd.lean:29](../lean/HamiltonsCubic/Results/L178Asd.lean#L29)) matches the record's Λ^∓ as the summand complementary to u's.
- **J₀.** `mu = ![2/√6, −1/√6, −1/√6]`, so `Wc4_J` gives Wc 4 J₀ = (2/√6) J₀ with the other two eigenvalues equal at −1/√6. J₀ is the eigenvalue-2 direction of the ratio 2 : −1 : −1, the record's Kähler form. `stab_forward` uses exactly μ₁ = μ₂ ≠ μ₀ (`mu_ne`), which is the record's "stabiliser of diag(2,−1,−1) in 𝔰𝔬(3)" computed on the two brackets [A, J₁], [A, J₂] against J₀.
- **ρ(A).** The derivation of Λ²ℝⁿ induced by a skew A is, under Λ² ≅ 𝔰𝔬(n), the commutator [A, ·]. The stabiliser condition [ρ(A), u] = 0 on Λ² is therefore ad_A ∘ Wc = Wc ∘ ad_A on skew X, which is what the hypothesis quantifies. Wc is applied to arbitrary matrices but only skew arguments are quantified, which is the record's domain.
- **Both directions are proved.** The forward direction reconstructs A from `skew_JK` with the J₁, J₂ coefficients killed. The converse is an entrywise expansion at a general skew X (six free entries). Neither direction assumes anything the record does not.
- **Owed list (gap 2).** The L167 row at [lean/INDEX.md:248](../lean/INDEX.md#L248) owes the assembly at general n and the orbit dimension, and those two are the right residue for the displays. But the row and the docstring at [L167Stab.lean:143](../lean/HamiltonsCubic/Results/L167Stab.lean#L143) also assert "≅ 𝔲(1) ⊕ 𝔰𝔲(2) = 𝔲(2), of dimension 4". The file proves neither the linear independence of J₀, K₀, K₁, K₂ (it has `inner2_JJ` and `inner2_KJ` but no K-K Gram lemma) nor the bracket structure. This was the substance of the r745/r746 finding ("𝔲(2) a dimension count and now an isomorphism"). The ingredients exist ([L178Asd.lean:34](../lean/HamiltonsCubic/Results/L178Asd.lean#L34) `Kz_inner`, `Kz_br`, and `JK_comm` here), so this is a naming gap: either prove the two facts or list them as owed.

## 2. I117LemmaE.lean against batch 37's Lemma E (A-2)

- **The inputs.** [reviews/2026-09-26-I73-class-ceiling.md:367](2026-09-26-I73-class-ceiling.md#L367): the hypothesis is P_k#P_k = c_k P_k with c_k > 0 (a single induced Casimir value on 𝔨). The bracket relations give P_k#P_p supported on 𝔭 and P_p#P_p supported on 𝔨. I#I = cI read on 𝔭 and on 𝔨 then gives P_k#P_p = (c/2)P_p and P_p#P_p = (c − c_k)P_k, and β > 0 follows from [𝔭,𝔭] = 𝔨. `SymmetricPair` takes `kk`, `kp` (with a free α), `pp` (with a free β), `trace_p : 2α = c`, `trace_k : c_k + β = c`, symmetry of #, and independence of P_k, P_p (𝔨, 𝔭 ≠ 0). Those are exactly what the proof consumes after its bracket step, so the structure is faithful.
- **The conclusion.** `idempotent_iff` gives C#C = C iff (a,b) ∈ {(0,0), (1/c_k,0), (1/c,1/c), (1/c,−1/c)}, i.e. 0, P_k/c_k, I/c and σ/c. Both directions are proved, the converse by substitution with β = c − c_k. The hypotheses c, c_k, β ≠ 0 are implied by the lemma's (c > 0 for compact simple 𝔤, c_k > 0 assumed, β > 0 derived), and each is needed (β = 0 frees b at a = 1/c).
- **The header (gap 4).** [I117LemmaE.lean:9](../lean/HamiltonsCubic/Results/I117LemmaE.lean#L9) and [:15](../lean/HamiltonsCubic/Results/I117LemmaE.lean#L15) give the lemma's hypotheses as "𝔨 simple and 𝔭 irreducible" and call all three relations "Schur relations". The lemma assumes a single Casimir value on 𝔨 ("for instance 𝔨 simple"), and 𝔭's irreducibility is used nowhere: only `kk` is a Schur-type hypothesis, while `kp` and `pp` come from the bracket supports plus I#I = cI. The INDEX-results row 262 states the hypothesis correctly. The brief's own gloss ("it assumes 𝔨 simple and 𝔭 irreducible") repeats the header's reading.
- **L263 and G₂.** 0765a5a7 found a second positive-definite idempotent at SU(3) ⊂ G₂. That pair has [𝔭,𝔭] ⊄ 𝔨 (G₂/SU(3) = S⁶ is isotropy-irreducible but not symmetric), so it lies in batch 38's two-component family with y ≠ 0, and Lemma E (the case y = 0) is untouched. The L262 row claims only the classification on the ansatz aP_k + bP_p of a symmetric pair, which is what is proved, so it does not overclaim.
- **The L262 row (gap 3).** [lean/INDEX.md:113](../lean/INDEX.md#L113) still opens "*statement: not typed.*" while the same row says `idempotent_iff` is "Lemma E's conclusion" at the operator, and the commit message says this types the declaration cbd40ef named as blocked. The sibling L263 row, in the same shape, reads "statement: typed from the block relations as data". The L262 row should read the same. The row also splices "σ/c; 2/2 on the standard three" with a semicolon.
- **Duplication.** [I117PsdReduction.lean:129](../lean/HamiltonsCubic/Results/I117PsdReduction.lean#L129) `sympair_idem` is the scalar forward implication for b ≠ 0. `idempotent_iff` is the operator-level iff over all (a,b) and reproves that step inline rather than calling `sympair_idem`. Overlap, no duplicate declaration.

## 3. L141's constant (A-3)

- [second-order.md:1844](../findings/second-order.md#L1844) displays c_n = 3θ₀(n)/(n−2), attained on the within-factor pair block ([:1849](../findings/second-order.md#L1849)), and [:1853](../findings/second-order.md#L1853) withdraws the crossing argument that produced 2.464θ₀/(n−2). 5f8f7bc6 moves row 141 of [INDEX-results.md](../findings/INDEX-results.md), [L141.lean](../lean/HamiltonsCubic/Results/L141.lean) and the L141 row to 3θ₀/(n−2).
- `c_decays` now takes c = 3·2/(n−2), θ₀ replaced by its bound 2 (θ₀ < √2 by `theta0_below_two`), and concludes c ≤ 6. That is the Θ(1/n) decay statement with the constant's own factor, and the docstring says 2 bounds θ₀. Consistent with the row and with [L141Statement.lean](../lean/HamiltonsCubic/Results/L141Statement.lean)'s `cn` and `pair_block_binds`.
- Grep for 2.464 and 2464 over findings/, lean/, STATUS.md and plan-lean.md returns only the withdrawn-crossing paragraph at [second-order.md:1853](../findings/second-order.md#L1853), which names it as withdrawn.

## 4. r1554's gaps (A-4)

- **Gap 1 closed.** The L141 owed list at [lean/INDEX.md:523](../lean/INDEX.md#L523) now names the Alt instantiation, L133's support table, the attainment clause and the domain T_{W*}S ∩ T_{W*}𝒪^⊥.
- **Gap 2 closed** in the file: [L141Statement.lean:66](../lean/HamiltonsCubic/Results/L141Statement.lean#L66) points at `half_contraction` and AltPart. **Residue (gap 5):** [lean/INDEX.md:29](../lean/INDEX.md#L29) still says "the files that name this absence are L141, L133, …", linking L141Statement.lean, whose header now says the opposite. r1554 section 6 predicted exactly this.
- **Gap 3 closed.** [L141Contract.lean:20](../lean/HamiltonsCubic/Results/L141Contract.lean#L20) now says L141 (a) asserts the shape inside its own proof and that the classical formula does not cover a degenerate V.
- **Gap 4 closed** (the instantiation is named as owed, in both the row and the header).
- **Gap 5 closed.** The L141 (statement) row at [lean/INDEX.md:524](../lean/INDEX.md#L524) is two sentences.
- **Gap 6 closed.** [L116Sharp.lean:15](../lean/HamiltonsCubic/Results/L116Sharp.lean#L15) names `degenerate_S3S3`.
- **New splice (gap 6).** The rewritten header at [L141Statement.lean:69](../lean/HamiltonsCubic/Results/L141Statement.lean#L69) reads "`Alt(H) = 0`; `Alt` and `W_-` are built in AltPart.lean", a semicolon joining two clauses. Minor.

## 5. Soundness (B)

- `lake build HamiltonsCubic.Results.L167Stab HamiltonsCubic.Results.I117LemmaE HamiltonsCubic.Results.L141`: completed, 8722 jobs, warnings only (unused simp arguments `Matrix.vecMul`, `dotProduct` in `stab_so4`'s converse).
- `axiom_audit.py --only`: L167Stab.lean 20/20, I117LemmaE.lean 2/2, L141.lean 6/6, all on propext, Classical.choice and Quot.sound alone.
- No `sorry`, `admit` or `native_decide` in the three files.
- Raised heartbeats: [L167Stab.lean:96](../lean/HamiltonsCubic/Results/L167Stab.lean#L96) (4000000, `skew_JK`) and [:140](../lean/HamiltonsCubic/Results/L167Stab.lean#L140) (8000000, `stab_so4`). Each is followed on the next line by a comment giving the reason (sixteen entries of six pairings, and an entrywise expansion over six free entries). I117LemmaE.lean and L141.lean raise none.

## 6. Downstream (C)

- **Gap 1.** The L167 (statement) row at [lean/INDEX.md:249](../lean/INDEX.md#L249) says the first display is stated in L167Mixed.lean "and the other two are not stated". `stab_so4` now states the second display's so(4) part, so the row should name L167Stab.lean and narrow "not stated" to the assembly at general n and the dimension.
- The L167 row at [lean/INDEX.md:248](../lean/INDEX.md#L248) calls the so(4) part PROVED. Row 167 of [INDEX-results.md](../findings/INDEX-results.md) and [route-a.md](../findings/route-a.md) carry no so(4)-specific Lean status and defer to lean/INDEX.md. plan-lean.md's row 94 is the regenerated truncation of the L167 row.
- No remaining 2.464 as L141's constant (section 3).

## 7. Style (D)

- No em dashes and no backticks inside link text in the added markdown lines of the three commits. Rows are single lines.
- One semicolon splice introduced in markdown, the L262 row's "σ/c; 2/2 on the standard three" (gap 3). The semicolons in the L141 owed list separate list items that carry commas, which is their permitted use.

## Verdict

**CONFIRMED WITH GAPS.** The mathematics of all three commits is faithful and kernel-checked on the standard three. Gaps, all text:

1. [lean/INDEX.md:249](../lean/INDEX.md#L249): the L167 (statement) row says the second and third displays are not stated, while `stab_so4` states the second display's so(4) part.
2. [lean/INDEX.md:248](../lean/INDEX.md#L248) and [L167Stab.lean:143](../lean/HamiltonsCubic/Results/L167Stab.lean#L143): "≅ 𝔲(2)" and "dimension 4" are asserted, not proved in the file (no independence of J₀, K_a, no bracket closure), and the owed list omits them. Minor.
3. [lean/INDEX.md:113](../lean/INDEX.md#L113): the L262 row says "statement: not typed" while `idempotent_iff` types Lemma E's conclusion from the block relations as data (the L263 row's wording), and it splices "σ/c; 2/2" with a semicolon.
4. [I117LemmaE.lean:9](../lean/HamiltonsCubic/Results/I117LemmaE.lean#L9) and [:15](../lean/HamiltonsCubic/Results/I117LemmaE.lean#L15): the header gives Lemma E's hypotheses as "𝔨 simple and 𝔭 irreducible" and calls all three relations Schur relations. The lemma assumes a single Casimir value on 𝔨, and `kp`, `pp` come from the bracket supports plus I#I = cI. Minor.
5. [lean/INDEX.md:29](../lean/INDEX.md#L29): still lists L141 among the files naming Alt's absence, stale since r1554 gap 2's repair. Minor.
6. [L141Statement.lean:69](../lean/HamiltonsCubic/Results/L141Statement.lean#L69): a semicolon clause splice in the rewritten header. Minor.
