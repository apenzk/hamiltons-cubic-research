# REVIEW r1141: L240 piece (b), steps 9a to 9c

Brief: [2026-09-25-L240b-step9-gate2-brief.md](2026-09-25-L240b-step9-gate2-brief.md). Log: [agent_logs/r1141.log](../agent_logs/r1141.log). File under review: [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean), lines 492 to 617.

Method: read the declarations against the brief's claims. The module was built in the background (`lake build HamiltonsCubic.Results.L240SlotBasis`, success, lint warnings only). A throwaway scratch Lean file outside the repo served as a screen for the role selection. It is reported as a screen only.

## Item 1: declarations state their claims. CONFIRMED, with two notes

**Step 9a.** CONFIRMED.

- `classify` gives the three-way disjunction (p-side, q-side, `Free`).
- `p_ne_q_side`, `p_not_free` and `q_not_free` give pairwise exclusivity from `hpq` and the definition of `Free`.
- The injectivity of `p` and `q` makes the witnessing block unique within each side.
- No hypothesis is missing and nothing is vacuous.

**Step 9b.** CONFIRMED.

- `blockOf_spec` puts the returned block on `x`. Uniqueness of that block follows by `same_block`.
- `blockOf_of_p` and `blockOf_of_q` evaluate `blockOf` on every block index.
- `blockOf_none` gives `none → Free`.
- Note: the converse `Free x → blockOf x = none` is not a declaration. The brief's claim "`none` exactly for free `x`" is delivered only as a three-line consequence of `blockOf_spec`: the screen proved it by case split on `blockOf x`. `slot_eigen` will need this direction to evaluate `slotφ` on kernel and free-free pairs, so stating it as `blockOf_free` would save duplication.

**Step 9c.** CONFIRMED. `pairSlot` and `pairMu` agree with steps 2 and 3.

`pairSlot N c d x y` for `x` in block `c` and `y` in block `d` selects as follows. The screen checked all four rows by `simp` with only `hpq`, and `pairMu` on both sides.

| index pair | `pairSlot` gives | vector | eigen lemma | eigenvalue | `pairMu` gives |
|---|---|---|---|---|---|
| (p_c, p_d) | `S1` | φ(p_c p_d) − φ(q_c q_d) | `slot_plus_general` | (s_c+s_d)² | (s_c+s_d)² |
| (p_c, q_d) | `S2` | φ(p_c q_d) + φ(q_c p_d) | `slot_plus2_general` | (s_c+s_d)² | (s_c+s_d)² |
| (q_c, q_d) | `S3` | φ(p_c p_d) + φ(q_c q_d) | `slot_minus_general` | (s_c−s_d)² | (s_c−s_d)² |
| (q_c, p_d) | `S4` | φ(p_c q_d) − φ(q_c p_d) | `slot_minus2_general` | (s_c−s_d)² | (s_c−s_d)² |

- The map from the four index pairs of a block pair to `S1`, `S2`, `S3`, `S4` is a bijection. Each slot is therefore attached to exactly one pair, which is what indexing "like the φ basis" requires.
- **`slotφ`** takes the ordered pair `i < j` with blocks `a`, `b`:
  - If `a < b`, it uses `pairSlot N a b i j`, which puts `i` in `a` and `j` in `b`.
  - If `b < a`, it uses `pairSlot N b a j i`, again with the right memberships.
  - For `a = b` (Cartan), kernel or free-free pairs, it keeps `φ_{ij}`.
  - The factor `(√2)⁻¹` normalises correctly, since `pair_gram` gives `inner2 S S = 2`.
- **`slotμ`** agrees case by case:
  - Cross-block pairs get `pairMu` with the same first argument that `pairSlot` tests.
  - Cartan and free-free pairs get 0.
  - Kernel pairs get `s_a²`, matching `slot_kernel_general` and `slot_kernel_q`.
- `slot_eigen` will need orientation in two cases, and `negAd_phi_swap` supplies it for both:
  - `(none, some b)` gives `φ(w, x)`.
  - The Cartan pair with `q_a < p_a` gives `φ(q_a, p_a)`.
- **`cartan_null`** states `br N.X (phi (N.p a) (N.q a)) = 0` for every `k`, including `k = 1`. This is the commutator itself, stronger than the `-ad²` form.
- **`negAd_smul`** and **`negAd_phi_swap`** are correct as stated.

Note (nuisance, not a defect): the step 9c section redeclares `ι` with both `[DecidableEq ι]` and `[LinearOrder ι]`. That gives two sources of decidable equality. The direct local instance is found first, so `phi` and `pairSlot` elaborate with the same instance as the earlier sections. A Mathlib lemma phrased through the order's instance may need `convert` in `slot_eigen`.

## Item 2: axiom audit. CONFIRMED

`python3 scripts/misc/axiom_audit.py --only L240SlotBasis`, run after a successful background build, reports `48/48 clean -- resting on the standard three alone`. There is no `sorryAx` and no `native_decide` axiom.

## Item 3: docstring and lean/INDEX.md row. REFUTED (minor), corrections below

- **[lean/INDEX.md](../lean/INDEX.md) row L240, "Still owed for (b)"**: this entry lists "the null slot at a single block ($k=1$)" as owed. The same row credits `cartan_null` with "closing r1138's $k\ge2$ gap", and `cartan_null` does deliver the `k = 1` case, because `-ad_X²` of the slot is `-br X 0 = 0`. The row therefore contradicts itself. **Correction**: delete ", and the null slot at a single block ($k=1$)" from "Still owed".
- **[L240SlotBasis.lean:561](../lean/HamiltonsCubic/Results/L240SlotBasis.lean#L561)**: the section header reads "the slot family on the index pairs, and its eigen relation". The section proves no eigen relation for `slotφ` (`slot_eigen` is owed). **Correction**: change it to "and its eigenvalues", matching the module docstring's line 29 to 31, which correctly says the eigen relation is owed.
- The module docstring's step 9a to 9c lines (26 to 31) claim nothing beyond the declarations.
- The line-18 remark "(the null slot needs a second block, `k ≥ 2`)" is accurate for `slot_null_general`. It now reads as stale beside `cartan_null`, and a pointer to `cartan_null` there would help. This is optional.

## Verdicts

| item | verdict |
|---|---|
| 1 | CONFIRMED (notes: the converse of `blockOf_none` is not stated, the instance note) |
| 2 | CONFIRMED (48/48, standard three) |
| 3 | REFUTED, minor: the INDEX row lists the `k = 1` null slot as owed although `cartan_null` delivers it, and the section header at line 561 claims an eigen relation |
