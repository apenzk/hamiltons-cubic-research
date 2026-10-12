# REVIEW r1138: L240 slot basis (piece b, steps 1-3) and L246 matrix step

Brief: [2026-09-25-L240b-L246lean-gate2-brief.md](2026-09-25-L240b-L246lean-gate2-brief.md). Log: agent_logs/r1138.log. Reviewed at commit dfa71df3 (committed declarations only). The uncommitted kernel-slot declarations below `slot_null_general` in the working tree are outside this round.

## 1. Statements match claims: CONFIRMED (one minor note)

- `NormalForm` carries `p q : Fin k → ι`, both injective, and `p a ≠ q b` for all `a b`, so the `2k` indices are distinct. Weights `s` are arbitrary reals (no ordering, zeros allowed), which is more general than the claim.
- Satisfiable at `k = 2`: screen file (scratchpad, not committed) defines `N2 : NormalForm (Fin 4) 2` with `p = ![0,1]`, `q = ![2,3]`, `s = ![3,1]`, all three fields by `decide`, and instantiates `slot_plus_general N2` and `slot_null_general N2` at `a = 0, b = 1`. It compiles, `N2` on the standard three axioms.
- `NormalForm.X = ∑ c, s c • phi (p c) (q c)`, and each slot theorem states `-br X (br X Y) = λ • Y` with `br A B = A*B - B*A`, which is `-ad_X²`. Quantifiers are over all `N` and all `a ≠ b`, with no further hypothesis.
- Pairings, with `p,q,u,v := p_a,q_a,p_b,q_b` against [RootSlots.lean](../lean/HamiltonsCubic/Results/RootSlots.lean): `slot_plus_general` `φ_{p_a p_b} − φ_{q_a q_b}` at `(s_a+s_b)²` = `slot_plus` (`φ_pu − φ_qv`); `slot_plus2_general` `φ_{p_a q_b} + φ_{q_a p_b}` at `(s_a+s_b)²` = `slot_plus2` (`φ_pv + φ_qu`); `slot_minus_general` `φ_{p_a p_b} + φ_{q_a q_b}` at `(s_a−s_b)²` = `slot_minus`; `slot_minus2_general` `φ_{p_a q_b} − φ_{q_a p_b}` at `(s_a−s_b)²` = `slot_minus2`. This is the brief's `∓`/`±` reading. Each general proof reduces to the two-block statement via `reduce_two`/`br_X_two` and closes with the RootSlots lemma itself, so the pairing is inherited from it rather than restated.
- `slot_null_general` gives `φ_{p_a q_a}` null. With `a, b` swapped it gives `φ_{p_b q_b}` too, so the six slots of a pair are covered.
- Minor note: `slot_null_general` sits in the `include hab` section and so needs some `b ≠ a`, i.e. `k ≥ 2`. At `k = 1` the null slot (true, since `br X φ_{p_a q_a} = 0`) is not delivered. This makes no difference for pairs, but the completeness step will need the `k = 1` case or a separate lemma.
- The supporting lemmas `br_phi_disjoint`, `br_jacobi`, `br_sum_left`, `block_disj`, `hc_pair`, `br_X_two` and `reduce_two` state what their docstrings say. `slot_plus_general` repeats `block_disj` inline, which is redundant but harmless.
- L246 `skew_swap`: `(Xu)·v = −u·(Xv)` for `Xᵀ = −X`, correct. `M_le_A`: for any finite family of skew `ψ_i` and `e·e = 1`, `∑(ψ_i e·z)² ≤ ∑ |ψ_i z|²` for every `z`. The record ([second-order.md](../findings/second-order.md) line 341) needs it only for `z ⊥ e`, so the Lean version is stronger than the claim, and restricting it gives `M_c(e) ⪯ Â_c` on `e^⊥`.

## 2. Axiom audit: CONFIRMED

- `lake build` of both modules exit 0 (working tree).
- `axiom_audit.py --only L240SlotBasis`: 15/15 clean, standard three (`propext`, `Classical.choice`, `Quot.sound`). This includes the two uncommitted kernel declarations, and every declaration named in the brief is among the clean ones.
- `axiom_audit.py --only L246PairIsotropy`: 6/6 clean, standard three.
- No `sorry` and no `native_decide` in either committed file.

## 3. Docstrings and lean/INDEX.md: PLAUSIBLE, two docstring corrections

- [lean/INDEX.md](../lean/INDEX.md) L240 row: accurate. It lists exactly the committed declarations and names what is still owed (kernel slots, orthonormality, completeness).
- INDEX L246 row: accurate. `M_le_A` is described as evaluated at every `z`, which it is.
- **Correction (L240 module docstring)**: [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean) lines 8-10 say the file shows the slot bivectors are "orthonormal and complete, so `kyFan_eigen` applies at a general `X`". Nothing committed proves orthonormality, completeness or a `kyFan_eigen` application, so this reads as delivered when it is only the target. The step list (lines 14-15) also stops at step 2 and should add step 3 (`block_disj`, `reduce_two`, `hc_pair`, the remaining four slots).
- **Correction (L246 module docstring, stale)**: [L246PairIsotropy.lean](../lean/HamiltonsCubic/Results/L246PairIsotropy.lean) lines 14 and 21 say only "the two scalar steps" are typed and list "the Loewner-order steps" as untyped. The file now types four scalar theorems and, with `M_le_A`, the `M_c(e) ⪯ Â_c` step as a quadratic-form inequality. This underclaims and does not overclaim. The accurate untyped list is `M_c(e)` as a matrix, `∑_c M_c(e) = I − eeᵀ`, commutation and the spectral projector, which is what the INDEX row already says.
