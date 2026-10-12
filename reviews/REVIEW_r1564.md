# Review r1564: L167's 𝔲(2) reading (commit f1fe5882) and r1562's repairs (commit 30a2fb3b)

**Standfirst.** [L167Full.lean](../lean/HamiltonsCubic/Results/L167Full.lean) builds (one flexible-`simp` linter note at [L167Full.lean:240](../lean/HamiltonsCubic/Results/L167Full.lean#L240)) and audits 24/24 on the standard three, with no `sorry`, `admit` or `native_decide` in any L167 file. The six new declarations carry the content of route-a's "Λ^∓ ⊕ ℝJ ≅ 𝔰𝔲(2) ⊕ 𝔲(1)": J₀ commutes with each K_a, the K_a close with structure constants −2ε_abc, and J₀, K₀, K₁, K₂ are independent. The rescaling e_a = −K_a/2 gives [e_a, e_b] = ε_abc e_c, 𝔰𝔬(3) ≅ 𝔰𝔲(2)'s constants, a step the file leaves to the reader. Commit 30a2fb3b closes r1562's gaps 1 to 4. The gaps are text: one "not typed" bullet in L167Statement.lean still lists the 𝔲(2) isomorphism with no pointer to the new proof, the row dropped L167Full's audit count, and the header's "∓2" hides a uniform cyclic sign.

| # | claim | verdict |
| --- | --- | --- |
| A-1a | `br_J0K`: J₀ central in the span | **CONFIRMED** (from `JK_comm`, and [J₀, J₀] = 0 is trivial) |
| A-1b | `br_K01`, `br_K02`, `br_K12`: the K_a close as 𝔰𝔲(2) | **CONFIRMED** (cyclically [K_a, K_{a+1}] = −2 K_{a+2}, so e_a = −K_a/2 has ε_abc constants) |
| A-1c | `inner2_KK`, `u2_indep`: the four generators independent | **CONFIRMED** |
| A-1d | together these are "span ≅ 𝔲(1) ⊕ 𝔰𝔲(2) ≅ 𝔲(2), dimension 4" | **CONFIRMED WITH GAPS** (the rescaling to ε_abc, closure of the span as a subalgebra, and 𝔲(1) ⊕ 𝔰𝔲(2) ≅ 𝔲(2) are unstated, each immediate) |
| A-2 | L167 row accurate, "owed: only the orbit dimension" right | **CONFIRMED WITH GAPS** (owed item right, L167Full's audit count dropped from the row) |
| A-3 | 30a2fb3b closes r1562 gaps 1 to 4 | **CONFIRMED** |
| B | builds, standard three axioms, no sorry/admit/native_decide | **CONFIRMED** |
| C | no text still calling the 𝔲(2) reading owed | **CONFIRMED WITH GAPS** (L167Statement.lean:56) |
| D | style of the markdown edits | **CONFIRMED** |

**Summary:** the 𝔲(2) reading is proved in the form the record states it, and the gaps are one stale "not typed" bullet, a dropped audit count and a sign written as ∓.

## 1. Fidelity of the 𝔲(2) declarations

- **The claim.** [route-a.md](../findings/route-a.md), Lemma L167, "Then the dimension is addition": the 𝔰𝔬(4) part of the stabiliser is Λ^∓ ⊕ ℝJ ≅ 𝔰𝔲(2) ⊕ 𝔲(1), J the eigenvalue-2 eigenvector. In the layer [mu](../lean/HamiltonsCubic/Results/CP2Real.lean#L172) is (2, −1, −1)/√6 and om 0 is pad J 0 over √2, so J₀ is that eigenvector, and `stab_so4` already identified the stabiliser as span(J₀, K₀, K₁, K₂).
- **Centrality.** [br_J0K](../lean/HamiltonsCubic/Results/L167Full.lean#L227) is `JK_comm` at a = 0. With [J₀, J₀] = 0 this makes ℝJ₀ central in the span.
- **The K_a brackets.** [br_K01](../lean/HamiltonsCubic/Results/L167Full.lean#L219), `br_K02`, `br_K12` give [K₀, K₁] = −2K₂, [K₀, K₂] = 2K₁, [K₁, K₂] = −2K₀, proved entrywise from `K_lit`. Read cyclically, [K₂, K₀] = −2K₁, so the constant is −2ε_abc throughout. Setting e_a = −K_a/2 gives [e_a, e_b] = ¼(−2ε_abc K_c) = ε_abc e_c, the structure constants of 𝔰𝔬(3) ≅ 𝔰𝔲(2), the compact real form (the sign fixes it over ℝ, excluding 𝔰𝔩(2, ℝ)). Checked by hand from the three stated identities.
- **Independence.** [u2_indep](../lean/HamiltonsCubic/Results/L167Full.lean#L233) pairs p J₀ + Σ q_a K_a = 0 against J₀ and each K_b with `inner2`, using `inner2_JJ`, `inner2_KJ` and the new [inner2_KK](../lean/HamiltonsCubic/Results/L167Full.lean#L229) (Gram matrix 2·Id). Correct, and it gives dimension 4.
- **What is left unstated.** No declaration states the rescaled ε_abc form, that the span is closed under the bracket (it follows from the four bracket identities by bilinearity), or that 𝔲(1) ⊕ 𝔰𝔲(2) ≅ 𝔲(2) (textbook, and the record's own "≅ 𝔰𝔲(2) ⊕ 𝔲(1)" is the form proved). No `LieSubalgebra` or `LieEquiv` is built. Each missing step is one line of algebra, so this is a presentation gap (gap 4), and the record's claim is carried.
- **Header precision.** [L167Full.lean:17](../lean/HamiltonsCubic/Results/L167Full.lean#L17) writes "[K_a, K_b] = ∓2 K_c", which reads as a sign varying with the pair. The sign is uniform cyclically, [K_a, K_b] = −2ε_abc K_c (gap 3).

## 2. The L167 row

- **Accurate** ([lean/INDEX.md:249](../lean/INDEX.md#L249)): `br_J0K`, `br_K01`, `br_K02`, `br_K12` and `u2_indep` are named for the reading, and "𝔲(2), dimension 4" is no longer owed.
- **"Owed: the orbit dimension" is right.** The first display is `stab_mixed_trivial`, the second is `stab_full` with the 𝔲(2) reading now proved, and the third, dim(SO(n)·u) = 4n − 14 as an orbit, is only the arithmetic `orbit_dimension` in L167.lean and L167Statement.lean. The count 4 + C(m,2) of the full stabiliser as a vector space is also unproved and is subsumed under the orbit-dimension item. **Partial is right.**
- **Gap 2.** The row's L167Full sentence lost its audit count: before f1fe5882 it read "18/18 on the standard three", and it now gives none, where the audit reads 24/24. The other two files keep theirs (7/7, 20/20).

## 3. Commit 30a2fb3b against r1562

- **Gap 1 closed.** [L167Statement.lean:50](../lean/HamiltonsCubic/Results/L167Statement.lean#L50) names `stab_full` for the second display and narrows to the third.
- **Gap 2 closed.** [L167Stab.lean:7](../lean/HamiltonsCubic/Results/L167Stab.lean#L7) states the span of J₀ and Λ⁻, and the closing paragraph points at `stab_full` as one sentence, the semicolon splice gone.
- **Gap 3 closed.** The title, bullet and `stab_full` docstring of L167Full.lean read "which the record reads as 𝔲(2) ⊕ 𝔰𝔬(m)". The `show` became `change`.
- **Gap 4 closed.** [L167.lean](../lean/HamiltonsCubic/Results/L167.lean)'s "Elsewhere" names `stab_so4` and `stab_full`.

## 4. Downstream

- **Gap 1.** [L167Statement.lean:56](../lean/HamiltonsCubic/Results/L167Statement.lean#L56), under "What is NOT typed here", still reads "That 𝔰𝔱𝔞𝔟(u) ∩ 𝔰𝔬(4) is 𝔲(2) rather than merely 4-dimensional ... only the dimension count is typed". True of that file, but unlike the first bullet it gives no pointer, so it reads as owed. It should name L167Full's `br_J0K`, `br_K01/02/12` and `u2_indep`, as the first bullet names `stab_full`.
- **Minor, optional.** [L167Stab.lean:143](../lean/HamiltonsCubic/Results/L167Stab.lean#L143) ("which the record reads as 𝔲(1) ⊕ 𝔰𝔲(2) = 𝔲(2)") and [L167.lean:32](../lean/HamiltonsCubic/Results/L167.lean#L32) (`stabiliser_four`'s docstring, whose theorem is 3 + 1 = 4) could point to the new lemmas. Neither calls the reading owed.
- [findings/route-a.md](../findings/route-a.md) and [findings/INDEX-results.md](../findings/INDEX-results.md) make no Lean claim about the reading and need nothing.

## 5. Style

- No em dash in either commit's added lines, and no backticks inside link text. The semicolons in the added lines are Lean syntax, a list separator in a Lean header bullet, or a pre-existing STATUS.md cell. No hard wrapping in the markdown row.

## 6. Verdict

**CONFIRMED WITH GAPS.** The span of J₀, K₀, K₁, K₂ is proved 4-dimensional with J₀ central and the K_a closing as 𝔰𝔲(2) up to the factor −2, on the standard three axioms, and r1562's gaps are closed. The gaps are text and none touches a proof:

1. [L167Statement.lean:56](../lean/HamiltonsCubic/Results/L167Statement.lean#L56) lists the 𝔲(2) isomorphism as not typed with no pointer to L167Full.
2. [lean/INDEX.md:249](../lean/INDEX.md#L249) dropped L167Full's audit count (now 24/24).
3. [L167Full.lean:17](../lean/HamiltonsCubic/Results/L167Full.lean#L17) writes "∓2" for a sign that is uniformly −2ε_abc.
4. The rescaling e_a = −K_a/2 to the ε_abc constants, closure of the span and 𝔲(1) ⊕ 𝔰𝔲(2) ≅ 𝔲(2) are unstated, each one line.
