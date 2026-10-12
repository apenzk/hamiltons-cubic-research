# REVIEW r1142: Gate 2 on L240 piece (b), slot_eigen, pair_orthonormal and the index simp lemmas

Brief: [2026-09-25-L240b-eigen-gate2-brief.md](2026-09-25-L240b-eigen-gate2-brief.md). Log: agent_logs/r1142.log. File under review: [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean) at HEAD 4783ba22.

Build: `lake build HamiltonsCubic.Results.L240SlotBasis` in the background, exit 0, warnings are longLine style only.

## Item 1: each declaration states its claim. CONFIRMED (one minor note)

- **pairSlot_eigen** (L643): for any `c ≠ d` and any `x y`, every branch of `pairSlot` is an eigenvector with eigenvalue `pairMu`. The branch map is: `x = p_c, y = p_d` gives S1 with `(s_c+s_d)²`; `x = p_c, y = q_d` gives S2 with `(s_c+s_d)²`; `x = q_c, y = q_d` gives S3 with `(s_c−s_d)²`; `x = q_c, y = p_d` gives S4 with `(s_c−s_d)²`. This is exactly the RootSlots pairing (plus slots S1, S2; minus slots S3, S4), and the four index pairs of a block pair land on four distinct slots, each containing `φ_{xy}` with coefficient 1.
- **cartan_eigen** (L653): both indices in block `a`, `x ≠ y`, forces `{x,y} = {p_a, q_a}` in one of two orientations, both handled via `cartan_null`. Eigenvalue 0 as intended, valid at every `k`.
- **slot_eigen** (L663): no hypotheses beyond the type classes. The match on `(blockOf i, blockOf j)` covers all four Option cases: `some a, some b` splits into `a = b` (Cartan, 0), `a < b` (pairSlot a b at i j), `b < a` (pairSlot b a at j i, so `x` is always the index in the lower block); `some a, none` gives `s_a²`; `none, some b` gives `s_b²` via `negAd_phi_swap`; `none, none` gives 0. `slotφ` and `slotμ` use the same case split, so the eigenvalue attached in each case is the intended one. No vacuity: the statement is unconditional and `slotφ` is nonzero in every case (norm 1 or 2 by `pair_gram` and `inner2_phi_phi`).
- Screen: a scratch file instantiated `slot_eigen` at `ι = Fin n` (where DecidableEq and LinearOrder both supply equality decisions); it elaborates without an instance mismatch.
- Minor note: the `step9c` section variable adds `[LinearOrder ι]` to `i2_smul_smul` and `pair_orthonormal`, which do not use it (confirmed by `#check`). This restricts, never weakens, and is harmless for `Fin n`.

## Item 2: axiom audit. CONFIRMED

- `python3 scripts/misc/axiom_audit.py --only L240SlotBasis`: "auditing 60 declarations across 1 files, 60/60 clean, resting on the standard three alone".
- Direct `#print axioms` on `slot_eigen` and `pair_orthonormal`: `[propext, Classical.choice, Quot.sound]`. No `sorry`, no `native_decide`.

## Item 3: docstring and INDEX row. PLAUSIBLE, with two wording corrections

- **pair_orthonormal docstring overclaims** (L701): it reads "The normalised pair slots are orthonormal: ... `0` off it", but the statement delivers the four diagonal entries only. The off-diagonal zeros hold for the unnormalised slots in `pair_gram` and transfer via `i2_smul_smul`, but `pair_orthonormal` does not state them. Correction: "The normalised pair slots have `inner2`-norm 1", or add the six off-diagonal conjuncts. The INDEX row already says "have norm 1", which is accurate.
- **INDEX row calls `p_ne_free`, `q_ne_free` simp lemmas**: they carry no `@[simp]` attribute (L503, L504) and take a hypothesis `hw : N.Free w`. Correction: "index-equality simp lemmas (`p_eq_p_iff`, `q_eq_q_iff`, `p_eq_q_false`, `q_eq_p_false`) and the separation lemmas `p_ne_free`, `q_ne_free`".
- **The simp lemmas themselves are sound** and the brief's claim holds: each is a proved iff from the `NormalForm` injectivity and disjointness fields, so tagging cannot introduce a false rewrite. They are declared at L497 to L501, after every proof of steps 1 to 8 (commit 42e9e460 is insertions only), so no earlier proof in the file saw them. The later proofs that could see them compile, and no other module imports L240SlotBasis except the root `HamiltonsCubic.lean`, so no downstream proof's meaning changed. Screen: `simp` closes `(N.p a = N.q b) = False` and, given `a ≠ b`, `N.p a ≠ N.p b`.
- The free-index separation covers only the orientation `N.p a ≠ w`; `w ≠ N.p a` needs `.symm`. This is a usability note, not a defect.
- `slot_eigen` in the INDEX row ("every member of the φ-indexed slot family is an eigenvector of -ad_X² with eigenvalue slotμ") matches the declaration exactly, and "Still owed" correctly leaves orthonormality of `slotφ` across cells and completeness open.

## Verdicts

1. CONFIRMED
2. CONFIRMED
3. PLAUSIBLE: correct the `pair_orthonormal` docstring (norms only) and the INDEX wording that lists `p_ne_free`, `q_ne_free` among the simp lemmas.
