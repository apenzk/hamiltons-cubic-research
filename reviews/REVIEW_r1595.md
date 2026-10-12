# Review r1595: L121's Bianchi cut at every tuple (L121Bianchi), working tree, repairing gap 2 of r1591

**Standfirst.** The new file closes the gap [r1591](REVIEW_r1591.md) named: `fourSet_bianchi_iff` states that x a + y b + z c satisfies the layer's first Bianchi at EVERY index tuple exactly when x + y + z = 0, in the signed basis a = φ_ij ⊙ φ_kl, b = φ_ki ⊙ φ_jl, c = φ_il ⊙ φ_jk of L121Block.lean, which is the record's "the Bianchi subspace is 1^⊥". The route is that the three basis operators carry the same Bianchi number at every tuple (p,q,r,s), so the Bianchi map on the span is (x + y + z) times a's, and a's number at (i,j,k,l) is 1. The layer's `bianchi` is the cyclic sum over the last three indices that `IsWeyl` quantifies over all tuples, repeated indices included, so it is the right condition. The build succeeds, the audit reads 5/5 on the standard three, and the L121 and L126 rows and L121Block.lean's docstrings are accurate. Two minor gaps: L121Statement.lean still describes the Bianchi cut at the one tuple with no pointer to the new file, and the two `maxHeartbeats 4000000` options carry no reason comment, which the linter flags.

| # | Claim | Verdict |
| --- | --- | --- |
| A-1 | `bianchi` (Base/WeylReal.lean) is the right first-Bianchi condition, including at repeated indices | **CONFIRMED** |
| A-2 | `bianchi_b_eq_a`, `bianchi_c_eq_a` quantify over all tuples (p,q,r,s) at four distinct i, j, k, l | **CONFIRMED** |
| A-3 | `fourSet_bianchi_all`: Bianchi of x a + y b + z c at every tuple is (x + y + z) times a's | **CONFIRMED** |
| A-4 | `fourSet_bianchi_iff` is the record's "Bianchi subspace is 1^⊥" in the signed basis, and matches the flip of x₁ − x₂ + x₃ = 0 to y₁ + y₂ + y₃ = 0 | **CONFIRMED** |
| A-5 | L121 and L126 rows in lean/INDEX.md, L121Block.lean's docstrings | **CONFIRMED** |
| B | `lake build HamiltonsCubic.Results.L121Bianchi` succeeds, audit 5/5 on propext, Classical.choice, Quot.sound, no `sorry`, no `native_decide` | **CONFIRMED** |
| C | downstream consistency | **CONFIRMED WITH GAP** (L121Statement.lean:55-57 still reads as a one-tuple account) |
| D | style | **CONFIRMED WITH GAP** (two maxHeartbeats linter warnings, markdown clean) |

**Summary:** L121Bianchi proves the record's Bianchi cut 1^⊥ at every tuple faithfully on the standard three, and r1591's gap 2 is closed, with one stale docstring in L121Statement.lean and two uncommented heartbeat bumps left.

## 1. Files and rows carrying the id

- `lean/HamiltonsCubic/Results/L121*.lean`: [L121.lean](../lean/HamiltonsCubic/Results/L121.lean), [L121Block.lean](../lean/HamiltonsCubic/Results/L121Block.lean), [L121Statement.lean](../lean/HamiltonsCubic/Results/L121Statement.lean), and the new [L121Bianchi.lean](../lean/HamiltonsCubic/Results/L121Bianchi.lean). The feat commit had not landed when this review ran (HEAD 2e943c55), so the staged working-tree files were reviewed. L121Bianchi.lean is staged with no unstaged changes.
- Rows: L121 at [lean/INDEX.md:354](../lean/INDEX.md#L354), L121 (statement) at [:355](../lean/INDEX.md#L355), L126 at [:482](../lean/INDEX.md#L482). The change edits the rows at 354 and 482, and imports the new module in [HamiltonsCubic.lean:124](../lean/HamiltonsCubic.lean#L124).

## 2. Fidelity against Lemma L121

**The condition.** [WeylReal.lean:110](../lean/HamiltonsCubic/Base/WeylReal.lean#L110) defines `bianchi R i j k l = ⟨R φ_ij, φ_kl⟩ + ⟨R φ_ik, φ_lj⟩ + ⟨R φ_il, φ_jk⟩`, the cyclic sum R_ijkl + R_iklj + R_iljk over the last three indices. `IsWeyl` at line 129 demands `∀ i j k l, bianchi R i j k l = 0`, repeated indices included, so "satisfies first Bianchi" in the layer means exactly the left side of `fourSet_bianchi_iff`. No restriction to distinct indices is smuggled in: the quantifier is over all of ι⁴.

**The basis.** a = `rk2 (phi i j) (phi k l)`, b = `rk2 (phi k i) (phi j l)`, c = `rk2 (phi i l) (phi j k)` are the same three operators as `fourSet_G` and `fourSet_bianchi` in L121Block.lean, and `rk2 U V` is X ↦ ⟨V,X⟩U + ⟨U,X⟩V, the symmetric product r1591 checked. b carries φ_ki = −φ_ik, the record's diag(1,−1,1) flip.

**Hand check at (i,j,k,l).** With inner2(φ_ab, φ_cd) = δ_ac δ_bd − δ_ad δ_bc: a contributes only through its first term, ⟨φ_ij,φ_ij⟩⟨φ_kl,φ_kl⟩ = 1. b contributes only through the second, ⟨φ_ki,φ_ik⟩⟨φ_jl,φ_lj⟩ = (−1)(−1) = 1. c contributes only through the third, 1 · 1 = 1. So the raw basis (φ_ik ⊙ φ_jl in the middle) gives x₁ − x₂ + x₃, and the flip gives y₁ + y₂ + y₃, exactly the record's sentence at [second-order.md:1202](../findings/second-order.md#L1202). The Lean `fourSet_bianchi` agrees.

**Every tuple.** `bianchi_b_eq_a` and `bianchi_c_eq_a` take `(p q r s : ι)` as explicit universally bound arguments, and the proof splits each of p, q, r, s into "equals one of i, j, k, l" or "differs from all four", five cases each, closing all 625 branches with `simp_all`. The theorem is stated for an arbitrary `Fintype ι` with only the six distinctness hypotheses. `bianchi_lin` is linearity of `bianchi` in R, by `ip_add_l`, `ip_smul_l` and `ring`. `fourSet_bianchi_all` combines them, and `fourSet_bianchi_iff` reads the forward direction at (i,j,k,l) through `fourSet_bianchi` and the reverse from `fourSet_bianchi_all` with x + y + z = 0.

**Reading of the record's reason.** The record says "â + b̂ + ĉ = 0 in these signed coordinates". The Lean content is that the Bianchi functional on the span is (x,y,z) ↦ (x + y + z)·β(a) with β(a) ≠ 0, which is the statement that its kernel is 1^⊥. The coefficients (x,y,z) are the record's coordinates. Linear independence of a, b, c is not needed for this equivalence and is not claimed.

**Rows.** The L121 row's new sentence names the four theorems accurately, says 5/5 (the audit's count), and drops "the Bianchi numbers at every other index tuple" from Owed, leaving the sphere normalisation, which is correct. The L126 row now points to `fourSet_bianchi_iff` "for the Bianchi cut", correct. L121Block.lean's module docstring and `fourSet_bianchi` docstring now point to L121Bianchi.lean in place of the owed sentence, correct.

## 3. Soundness

- `cd lean && ~/.elan/bin/lake build HamiltonsCubic.Results.L121Bianchi`: "Build completed successfully (8714 jobs)", the module itself in 111 s. Two warnings, both the `maxHeartbeats` style linter at [L121Bianchi.lean:26](../lean/HamiltonsCubic/Results/L121Bianchi.lean#L26) and [:44](../lean/HamiltonsCubic/Results/L121Bianchi.lean#L44).
- `python3 scripts/misc/axiom_audit.py --only L121Bianchi.lean`: "5/5 clean -- resting on the standard three alone".
- No `sorry`, `native_decide` or `axiom` in the file.

## 4. Downstream

- [second-order.md:1199](../findings/second-order.md#L1199) and [:1202](../findings/second-order.md#L1202) state the Bianchi subspace as 1^⊥ with no Lean pointer, nothing stale.
- lean/INDEX.md: no remaining "every other index tuple" or "one tuple" wording in the L121, L121 (statement) or L126 rows.
- **Gap 1.** [L121Statement.lean:55-57](../lean/HamiltonsCubic/Results/L121Statement.lean#L55) says the block is proved in L121Block.lean "with the `diag(1,-1,1)` sign flip and first Bianchi at the tuple `(i,j,k,l)` reading `x + y + z` (`fourSet_bianchi`)". That remains true, but it is the one-tuple account the change retires, and it names no pointer to `fourSet_bianchi_iff`. A reader of the statement file still sees only the single tuple.

## 5. Style

- No em dashes in the new file or in the added lines of lean/INDEX.md and L121Block.lean. No backticks inside link text. The table rows are single lines.
- The added sentences carry no semicolon splices. The semicolons in the module docstring's bullet list separate list items.
- **Gap 2.** The two `set_option maxHeartbeats 4000000 in` at [L121Bianchi.lean:26](../lean/HamiltonsCubic/Results/L121Bianchi.lean#L26) and [:44](../lean/HamiltonsCubic/Results/L121Bianchi.lean#L44) carry no reason comment, and the Mathlib linter warns on both. The reason is the 625-branch case split, one line each.

## 6. Verdict

**CONFIRMED WITH GAPS.** r1591's gap 2 is closed: the Bianchi cut on the four-set span is 1^⊥ at every tuple, machine-checked on the standard three. The two remaining gaps are a stale sentence in [L121Statement.lean:55-57](../lean/HamiltonsCubic/Results/L121Statement.lean#L55) and the uncommented heartbeat bumps at [L121Bianchi.lean:26](../lean/HamiltonsCubic/Results/L121Bianchi.lean#L26) and [:44](../lean/HamiltonsCubic/Results/L121Bianchi.lean#L44). Neither affects correctness.
