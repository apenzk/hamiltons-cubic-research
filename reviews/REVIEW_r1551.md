# Review r1551: L116's n = 4 witness (commit 5365b7df), L67 at the operator (commit 80a75da6) and r1550's gaps repaired (commit fafa4a93)

**Standfirst.** All three Lean files build, audit clean on the standard three (4/4, 10/10, 5/5) and carry no `sorry`, `admit` or `native_decide`. The mathematics is right: [L116Witness.lean](../lean/HamiltonsCubic/Results/L116Witness.lean) is a genuine witness that first Bianchi is load-bearing, [L67Ring.lean](../lean/HamiltonsCubic/Results/L67Ring.lean) computes the second-kind operator of a two-block diagonal weight correctly and its eigen-decomposition covers S²₀, and `free_bound_every` closes r1550's k ≥ 2 restriction faithfully. The gaps are in the index: the L67 main row now says `statement: typed` although no file carries L67's own statement, the L67 statement row one line below still says nothing connects the typed facts to W̊, the L116 row's untyped list names the CP³/CP⁴ numerics only, and findings/INDEX-results.md still marks L116 partial.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `sharp_rankOne`, `comp_rankOne` are right under L116Statement's `sharp` (BW eq. (4)) and `comp` | **CONFIRMED** |
| A-1b | `witness` shows first Bianchi is load-bearing | **CONFIRMED** (the other three symmetries of v⊗v are true but untyped) |
| A-1c | L116's main row may move to proved, with only the CP³/CP⁴ numerics untyped | **CONFIRMED WITH GAP** (the untyped list is incomplete) |
| A-2a | `ringW_diagOp`, `eig_within`, `eig_cross`, `eig_line`, `decomp` give the spectrum {α, β, mβ − (m−1)α} | **CONFIRMED** (the "no other eigenvalue" step is by hand) |
| A-2b | `sphereWeight_blocks`, `sphere_blocks_record` and the record's normalisation | **CONFIRMED** |
| A-2c | the L67 row is accurate, its owed list complete, and `statement: typed` | **GAP** |
| A-3a | r1550 gaps 1 to 5 closed, `free_bound_every` faithful including one block | **CONFIRMED WITH GAP** (two "free bound" docstrings remain in L82.lean) |
| A-3b | only `hcontract` stays owed on L82 | **CONFIRMED WITH GAP** (three minor untyped pieces unnamed) |
| A-3c | proposal 195 is in the file's required format | **CONFIRMED** |
| B | build, axiom audit, no sorry, admit or native_decide | **CONFIRMED** |
| C | no downstream text still calls these untyped | **GAP** (L67 statement row, INDEX-results L116) |
| D | style of the markdown edits | **CONFIRMED WITH GAP** (two semicolon splices in the L116 row) |

**Summary: CONFIRMED WITH GAPS. The Lean is sound and faithful in all three commits, but the L67 row claims `statement: typed` without the assembly at S^m×S^m, the L67 statement row and INDEX-results' L116 entry are stale, and the L116 row's untyped list omits three claims its block makes.**

## 1. L116Witness.lean (A-1)

- **`sharp_rankOne`.** Under `sharp`, (v⊗v)^#_{ijkl} = Σ_{p,q} (v_ip v_kq · v_jp v_lq − v_ip v_lq · v_jp v_kq), and the two products are the same four factors, so each summand vanishes. Correct, and this is the known fact that a rank-one operator has zero sharp.
- **`comp_rankOne`.** ½ Σ_{p,q} v_ij v_pq v_pq v_kl = ½|v|²_F v_ij v_kl, with |v|²_F = Σ_{p,q} v_pq². Correct under `comp`'s ½ at the contraction.
- **`witness`.** At v = e₀₁ + e₂₃ on Fin 4, b(v⊗v)_{0123} = v₀₁v₂₃ + v₀₂v₃₁ + v₀₃v₁₂ = 1, so R = v⊗v violates Bianchi. |v|²_F = 4, so b(R²)_{0123} = ½·4·1 = 2 and −b(R²)_{0123} = −2, while b(R^#) = 0. `not_identity_without_bianchi` extracts the component. Checked by hand, all three values right.
- **Genuine instance.** v⊗v satisfies both antisymmetries and pair symmetry by inspection, so Bianchi is the only hypothesis of `L116` it drops, and it is a cleaner witness than r660's I + t⋆ ([REVIEW_r660.md §2.4](REVIEW_r660.md)). *The file does not type those three symmetries for `rankOne vW`*, so "Bianchi is the hypothesis that fails" rests on a one-line fact left unstated. Minor.
- **Moving to proved.** The displayed identity (`L116`), the bookkeeping half (`bianchi_sq_spectral`), the one-proposition equivalence (`identity_iff_vanishing`, `bianchi_add`) and now load-bearing Bianchi are typed, which justifies proved for the lemma's display. **Gap 3**: the block ([bounds-relaxations.md:246–289](../findings/bounds-relaxations.md#L246)) also asserts three things the row does not name as untyped:
  1. *"R^# alone does not [preserve Bianchi]"* ([:250](../findings/bounds-relaxations.md#L250)): an existence claim for a Bianchi R with b(R^#) ≠ 0. The new witness violates Bianchi, so it does not show this. [L116Statement.lean](../lean/HamiltonsCubic/Results/L116Statement.lean)'s header names it as untyped, the row does not.
  2. *"What M actually is"* ([:256](../findings/bounds-relaxations.md#L256)): X^# on the eigenframe, ⟨x,Mx⟩ = ⟨L_W X, X⟩, the characterisation of λ_max(M), and the C₅ value 1.206011. r659 §4c treats this subsection as the block's content.
  3. The degenerate point ([:287](../findings/bounds-relaxations.md#L287)): b(W²) = b(W^#) = 0 at S³×S³, which r660 D3 widens to the whole coordinate-diagonal locus.

## 2. L67Ring.lean (A-2)

- **`ringW_diagOp`.** `R4_diagOp` gives W_{ijkl} = w_ij(δ_ik δ_jl − δ_jk δ_il). In Li's iklj order, (W̊h)_ij = Σ_{k,l} W_{iklj} h_kl = Σ w_ik(δ_il δ_kj − δ_kl δ_ij) h_kl = w_ij h_ji − δ_ij Σ_k w_ik h_kk. Matches the theorem.
- **`eig_within`.** Off the diagonal, w_ij h_ji = α h_ij inside S and 0 outside. On the diagonal at i ∈ S, −Σ_{k∈S, k≠i} α h_kk = −α(0 − h_ii) = α h_ii by trace zero and w_ii = 0. At i ∉ S, −β Σ_{k∈S} h_kk = 0. Correct.
- **`eig_cross`.** A cross-supported h has zero diagonal, so the trace term vanishes and w_ij h_ji = β h_ij. Correct, and it needs no hollowness, which the `omit hh` records.
- **`eig_line`.** At i ∈ S, Σ_k w_ik L_kk = (m−1)α − mβ, so (W̊L)_ii = mβ − (m−1)α, and symmetrically at i ∉ S with L_ii = −1. Correct.
- **`decomp` against the three eigen lemmas.** hA is supported in S×S with total trace zero, which is `eig_within`'s hypothesis at S. hB is supported in Sᶜ×Sᶜ with trace zero, and `eig_within` applies at Sᶜ because (a ∈ Sᶜ ↔ b ∈ Sᶜ) ↔ (a ∈ S ↔ b ∈ S), so `hwv` transports. hX carries exactly `eig_cross`'s ¬(i ∈ S ↔ j ∈ S). The line coefficient c = (Σ_{k∈S} h_kk)/m makes both within traces vanish, using `htr` and |S| = |Sᶜ| = m. All four fit.
- **"Exactly" the three values.** From W̊h = λh and h = hA + hB + hX + c·L, eigenvectors of distinct eigenvalues are independent, so λ is one of α, β, mβ − (m−1)α. That inference is correct and **is by hand**: no theorem states that every eigenvalue of W̊ on S²₀ lies in the set. That all three occur needs nonzero vectors in each summand, m ≥ 2 for the within part, which the owed multiplicities cover.
- **`sphereWeight_blocks`, `sphere_blocks_record`.** With |S| = |Sᶜ| = m, `sphereWeight` is m/(m−1) within either block and −1 across, and t·m/(m−1) = m·(t/(m−1)), −t = −(m−1)(t/(m−1)) at m ≥ 2. Correct. The sign is right: the Weyl sectional values of S^m×S^m are m/(2m−1) within and −(m−1)/(2m−1) across, which are the record's 1 − c and −c, and `L67_values` reproduces 1 − m − c.
- **Normalisation.** diagOp w acts by w_ab on the orthonormal φ_ab, so ‖W‖²_F = Σ_{a<b} w²_ab = m(m−1)α² + m²β² = m²(m−1)(2m−1)A² at α = mA, β = −(m−1)A, and ‖W‖_F = 1 returns the record's A = 1/(m√((m−1)(2m−1))). With multiplicities, Σω² = 3m²(m−1)(2m−1)A², three times that, which is `spec_normalisation`'s Σω² = 3. The two conditions agree with no rescaling.
- **Gap 1, `statement: typed`.** [lean-layer.md:48](../.claude/skills/lean-layer.md) reserves the flag for a row whose file carries the lemma's own statement. L67's statement is the spectrum of W̊ at the unit Weyl tensor of S^m×S^m, with multiplicities. L67Ring carries eigenvector lemmas at a generic two-block weight, and the row itself owes the assembly with `sphereProduct_weylPart` and the multiplicities. The main row at [lean/INDEX.md:392](../lean/INDEX.md) flipped from `not typed` to `typed` in 80a75da6, and `cycle_deliverable.py` reads that flag. The owed list should also name the typed "no other eigenvalue" theorem.
- **Gap 2, the statement row is stale.** [lean/INDEX.md:393](../lean/INDEX.md) still reads "nothing connects the typed facts to W̊ at S^m×S^m" and `statement: not typed`, against the main row's "PROVED" one line above.

## 3. fafa4a93 against r1550 (A-3)

- **Gap 1 closed.** `free_bound_every` obtains a normal form from `skew_normal_form`, moves unitness to Σ s² = 1 as `free_bound_skew` does, rules out k = 0 (the sum is 0 ≠ 1), and at k = 1 gives |s₀| = 1, where s₁ + s₂ = 1 ≥ min{1, ·}. At k ≥ 2 it takes the argmax i and the argmax j over the rest, which are exactly `free_bound_skew`'s `hij`, `hji`, `htop`. Since the pair values are invariants of X, one normal form suffices. Faithful to "every unit skew matrix", with the "or" form equivalent to the min form as r1550 checked. The header cites `sum_two_ge_one`. `free_bound_skew`'s own docstring ([L82Free.lean:109](../lean/HamiltonsCubic/Results/L82Free.lean#L109)) still omits the two-block restriction the header now states. Cosmetic.
- **Gap 2 closed.** The L82 row credits `Tplus_le_two_abs` and `adNorm_eq_sum_two` and owes only `hcontract`, which is the one binder of [L82Statement.lean](../lean/HamiltonsCubic/Results/L82Statement.lean)'s `L82`. It now reads `statement: typed`, matching the statement row. Three small pieces of the block are untyped and unnamed: the equality case of the √2 cap (rank 4 with s₁ = s₂), the rank-4 conclusion of the one-negative result (`one_negative_forces_sqrt_two` proves adn = √2 only), and the tie between `L82`'s free real `adn` and ‖ad_{v_N}‖, since `L82` does not consume `adNorm_eq_sum_two`, which itself covers even m only. Minor, since each sits downstream of the owed `hcontract`.
- **Gap 3 mostly closed.** The row and [L82.lean:13](../lean/HamiltonsCubic/Results/L82.lean#L13) now say "the all-equal value". [L82.lean:45](../lean/HamiltonsCubic/Results/L82.lean#L45) ("The free bound `2/√k` is at least `1`") and [L82.lean:62](../lean/HamiltonsCubic/Results/L82.lean#L62) ("the free bound squares to `4/3`") still use the old name for the constant.
- **Gap 4 closed.** Both named splices are rewritten. **Gap 5 closed.** The L73 row names T ≥ 0, pair symmetry, (A) and (B), the four `RowCalculus` fields.
- **Proposal 195.** A `##` heading before the STOP section, and a row with Impact 6 (twice), Importance 8, Total 48, Occ 2, placed after the last 48 and before the first 45, so in rank order. The anchor matches the heading's slug, and the entry is three sentences. It targets lean-loop, where no equivalent rule exists, while promoted 188 covers the verification loop only.

## 4. Soundness (B)

- `lake build HamiltonsCubic.Results.L116Witness HamiltonsCubic.Results.L67Ring HamiltonsCubic.Results.L82Free`: build completed successfully (8751 jobs), warnings only in unrelated files.
- `axiom_audit.py --only`: L116Witness.lean 4/4, L67Ring.lean 10/10, L82Free.lean 5/5, each on propext, Classical.choice and Quot.sound alone.
- No `sorry`, `admit` or `native_decide` in the three files.

## 5. Downstream (C)

- [lean/INDEX.md:393](../lean/INDEX.md), the L67 statement row, is stale (gap 2).
- [findings/INDEX-results.md:132](../findings/INDEX-results.md#L132) still marks L116 **Lean: partial** while lean/INDEX.md:468 says proved. Rows proved in lean/INDEX.md read "Lean: proved" there (L73, for one).
- findings/INDEX-results.md's L67 and L82 entries say partial, which is still right. No text in findings/bispectral.md, findings/bounds-relaxations.md or findings/isotropy-cap.md calls these three pieces untyped. Those blocks carry no machine-checked credit either, a missing credit rather than a false statement.

## 6. Style (D)

- No em dash and no backtick inside link text in the added lines. Every row and the proposal entry stay on one line.
- **Gap 6, two semicolon splices** in the L116 row, [lean/INDEX.md:468](../lean/INDEX.md): "which violates Bianchi with $b(R)_{0123}=1$; 4/4 on the standard three" (the pattern r1550 flagged in the L82 row) and "used $I+t\star$; either shows the hypothesis needed". The semicolons in the L67 row separate list items that carry commas and stand. Pre-existing splices in rows fafa4a93 touched, not introduced by it: "forces ... $\ge3/2>1$; and the feasible class" (L82 row) and "names nothing owed; what follows" (L73 row).

## 7. Verdict

**CONFIRMED WITH GAPS.** Every Lean claim in the three commits is sound and faithful. Gaps:

1. [lean/INDEX.md:392](../lean/INDEX.md): the L67 main row says `statement: typed`, but no file carries L67's own statement at the unit Weyl tensor of S^m×S^m. The owed list should also name "every eigenvalue of W̊ on S²₀ is one of the three", which is by hand from `decomp`.
2. [lean/INDEX.md:393](../lean/INDEX.md): the L67 statement row still says nothing connects the typed facts to W̊.
3. [lean/INDEX.md:468](../lean/INDEX.md): the L116 row's untyped list omits "R^# alone does not preserve Bianchi" (the rank-one witness violates Bianchi and does not show it), the "What M actually is" subsection ([bounds-relaxations.md:256](../findings/bounds-relaxations.md#L256)) and the degenerate-point claim ([bounds-relaxations.md:287](../findings/bounds-relaxations.md#L287)). Minor: [L116Witness.lean:48](../lean/HamiltonsCubic/Results/L116Witness.lean#L48) leaves the antisymmetries and pair symmetry of `rankOne vW` untyped.
4. [findings/INDEX-results.md:132](../findings/INDEX-results.md#L132): L116 still reads "Lean: partial".
5. [L82.lean:45](../lean/HamiltonsCubic/Results/L82.lean#L45) and [L82.lean:62](../lean/HamiltonsCubic/Results/L82.lean#L62) still call 2/√k "the free bound", and [lean/INDEX.md:415](../lean/INDEX.md) owes only `hcontract` without naming the √2 cap's equality case, the one-negative rank-4 conclusion and the tie of `adn` to ‖ad_{v_N}‖.
6. [lean/INDEX.md:468](../lean/INDEX.md): two semicolon clause splices.

*Reviewer r1551, one reviewer, analysis only: hand derivations from the definitions, `lake build` and the axiom audit, no numerical screens run.*
