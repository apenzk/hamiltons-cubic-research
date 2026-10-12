# Review r1139: Lean for L240 piece (b), steps 4 to 6

Brief: [2026-09-25-L240b-steps4-6-gate2-brief.md](2026-09-25-L240b-steps4-6-gate2-brief.md). Log: [agent_logs/r1139.log](../agent_logs/r1139.log). File under review: [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean). Build of `HamiltonsCubic.Results.L240SlotBasis`: success (8733 jobs), no `sorry` in any declaration.

| Item | Verdict |
|---|---|
| 1. Statements of steps 4, 5, 6 | CONFIRMED |
| 2. Axiom audit | CONFIRMED |
| 3. Docstring and lean/INDEX.md row | PLAUSIBLE, two wording corrections |

## Item 1: statements (CONFIRMED)

Conventions read: `phi i j = single j i 1 - single i j 1` ([WeylReal.lean:45](../lean/HamiltonsCubic/Base/WeylReal.lean#L45)), `br X Y = X*Y - Y*X` and `inner2 X Y = ½ tr(XᵀY)` ([L82Statement.lean:182](../lean/HamiltonsCubic/Results/L82Statement.lean#L182)), `inner2_phi_phi` ([WeylTraceSchur.lean:42](../lean/HamiltonsCubic/Results/WeylTraceSchur.lean#L42)). `NormalForm` asks `p`, `q` injective and `p a ≠ q b` for all `a, b`, so the `2k` indices are distinct, which is the normal form of the claim.

**Step 4.**

- `NormalForm.Free N w := ∀ c, N.p c ≠ w ∧ N.q c ≠ w` is "outside every block".
- `br_X_one` reduces `br N.X Z` to block `a` when every other block commutes with `Z`. Its hypothesis is the one the claim needs.
- `slot_kernel_general N a (hw : N.Free w)` concludes `-br N.X (br N.X (phi (N.p a) w)) = N.s a ^ 2 • phi (N.p a) w`, universally in `N`, `a`, `w`. This is the claim exactly.
- `slot_free_null` concludes `-ad_X² φ_{ww'} = 0 • φ_{ww'}` for two free indices, with no `w ≠ w'` hypothesis (at `w = w'` both sides are 0, so the statement is only stronger).
- **Non-vacuity**, checked in a scratch file against the built module: on `Fin 3` with `k = 1`, `p = 0`, `q = 1`, `s = 5`, the index 2 is free (`free2`). `slot_kernel_general N3 0 free2` gives `-ad_X² φ_{02} = 25 • φ_{02}`, and `φ_{02} ≠ 0` is proved there too, so the relation is not `0 = 0`.
- Note, not a defect: the file states the `p`-side kernel slot only. The `q`-side slot `φ_{q_a w}` follows by applying `slot_kernel_general` to the swapped normal form `(q, p, -s)`, which has the same `X` by `phi_swap`. The scratch file proves this in six lines (`kernel_q`). Completeness in (b) will need it stated.

**Step 5.**

- `S1 = φ_{p_a p_b} − φ_{q_a q_b}`, `S2 = φ_{p_a q_b} + φ_{q_a p_b}`, `S3 = φ_{p_a p_b} + φ_{q_a q_b}`, `S4 = φ_{p_a q_b} − φ_{q_a p_b}`: the four vectors of the claim, with the signs matching the eigenvectors of `slot_plus_general`, `slot_plus2_general`, `slot_minus_general`, `slot_minus2_general`.
- `#check @S1` shows the definitions take no `a ≠ b` argument, while `pair_gram` takes `a ≠ b` (via `include hab`). That is the claim's hypothesis, and it is needed: at `a = b` the vectors collapse.
- `pair_gram` states the four diagonal entries equal 2 and all six upper off-diagonal entries equal 0. The lower six follow from symmetry of `inner2`, which holds for real matrices since `tr(AᵀB) = tr(BᵀA)`. This is the Gram matrix `2I`. The `i2_*` lemmas are plain bilinearity, correctly stated.

**Step 6.**

- `NormalForm.InBlk N c x := x = N.p c ∨ x = N.q c`, and `same_block` (an index in blocks `a` and `c` forces `a = c`) is correct from the three distinctness fields.
- `phi_orth`: `φ_{ij} ⊥ φ_{kl}` unless `(i,j) = (k,l)` or `(i,j) = (l,k)`, which is `inner2_phi_phi` read off. Correct.
- `cross_phi` takes `a < b`, `c < d`, `(a, b) ≠ (c, d)` and indices `x ∈ a`, `y ∈ b`, `x' ∈ c`, `y' ∈ d`. The two coincidences are excluded correctly: `(x,y) = (x',y')` forces `(a,b) = (c,d)`, and `(x,y) = (y',x')` forces `a = d`, `b = c`, hence `a < b = c < d = a`. Every slot vector of the pair `(a, b)` has its first index in `a` and second in `b`, so this covers the claim.
- `cross_comb` extends to `φ + ε•φ` against `φ + δ•φ` with both terms of each side in the same ordered pair and `ε, δ` arbitrary, which contains `S1` to `S4` (the minus forms after `sub_eq_add_neg` and `neg_one_smul`). Correct and not weakened.

## Item 2: axiom audit (CONFIRMED)

`python3 scripts/misc/axiom_audit.py --only L240SlotBasis`, after the background build: `auditing 24 declarations across 1 files`, `24/24 clean -- resting on the standard three alone` (`propext`, `Classical.choice`, `Quot.sound`). The file has 25 theorems. The audit skips the one `private` theorem `ne_facts` by design, and its taint would reach the report through `pair_gram` and the slot theorems that use it. Every step 4 to 6 theorem is among the 24.

## Item 3: docstring and lean/INDEX.md row (PLAUSIBLE, two corrections)

Nothing claimed is missing from the declarations in substance. Two wordings say more than the file delivers:

1. **"the kernel slots"** (docstring, Step 4 line, and the INDEX row's "the kernel slots at indices outside every block"). The file proves the `φ_{p_a w}` slot and the null `φ_{ww'}` slot. The `φ_{q_a w}` slot is not stated. Correction: either say "the `p`-side kernel slot `φ_{p_a w}` and the free-free null slot", or add the `q`-side lemma (a short swap argument, sketched in item 1) before the wording stands. The INDEX "Still owed" list should then carry "the `q`-side kernel slot" until it is stated.
2. **Docstring line 11**, "Orthonormality and completeness, which `kyFan_eigen` needs, are not yet here", is now partly stale: orthogonality inside a pair (`pair_gram`) and across pairs (`cross_phi`, `cross_comb`) is here. Correction: "Orthogonality of the pair slots is here (steps 5, 6). Orthogonality of the kernel and Cartan slots against the rest, and completeness, are not yet here."

The INDEX row's "slot vectors of different block pairs are orthogonal" and "Gram matrix 2I" match `cross_comb` and `pair_gram`. Its "Still owed" list (kernel and Cartan slots against the rest, completeness, the null slot at `k = 1`) is accurate apart from the `q`-side slot above.
