# REVIEW r1769: L120Blocks.lean (55b1f547), L120's "checkable block by block"

| Claim | Verdict | Reason |
|---|---|---|
| `char_orth` | CONFIRMED | one sign conjugation preserves `inner2` on each `φ_ij` pair and multiplies it by `c ε · c' ε = −1`, so every term of `innerOp2` vanishes |
| `hess_blockwise` | CONFIRMED | cross terms `⟨H v_k, v_l⟩` vanish by `hessOp_char` then `char_orth`, and `hessQ_op` turns the form into that pairing |
| `hess_nonpos_blockwise` | CONFIRMED | `hess_blockwise` plus `Finset.sum_nonpos` |
| `setChar_sep` | CONFIRMED | flipping one coordinate of the symmetric difference separates the two products |
| Hypotheses satisfiable | CONFIRMED | a scratch file instantiates `hess_blockwise` at the unit balanced `S^3 × S^3` (n = 6) with two pair-block tangent vectors of characters `ε0ε1` and `ε2ε3`, on the standard three axioms |
| INDEX L120 row | CONFIRMED WITH OBSERVATIONS | accurate against the code, the "Owed" clause overstates what the covering needs (O1) |

**Summary:** the four declarations are sound and say what the record's sentence says for vectors already split into isotypic pieces. The covering of W⊥ by those pieces is the one piece left to the record, and it is weaker than the INDEX phrases it.

## 1. SignChar against the record's sign-isotypic blocks

- `SignChar c R` ([L120Hess.lean:41](../lean/HamiltonsCubic/Results/L120Hess.lean)) says `S R(Sᵀ Z S) Sᵀ = c(ε) R(Z)` on skew `Z` for every sign matrix `S = diag ε`. That is the statement that `R` lies in the `c`-isotypic component of the full diagonal sign group Γ acting on operators on Λ² by conjugation, which is the record's reading of "block". Since `S = Sᵀ = S⁻¹`, the conjugation convention cannot flip a character.
- The characters match. Trivial: `signChar_diag` uses `fun _ => 1`, and `setChar ∅ = 1` by `prod_empty`. Pair: `pair_act_signMat` and `hessOp_pair` use `fun ε => ε j * ε k`, and `setChar_pair` (for `j ≠ k`) is exactly that after `funext`, which the witness in §4 uses. Four-set: `four_act_signMat` uses `ε i * ε j * ε k * ε l`, which equals `setChar {i,j,k,l}` for distinct indices by the same `prod_insert` reasoning. No `setChar_four` lemma is stated (O3).
- Record quote relied on (findings/second-order.md, Lemma L120, line 1299): "Hence the Hessian of $P$ on the sphere is block-diagonal in the same way, and [Lemma L24]'s criterion is checkable block by block **once $\mathcal D_n$ is cut by $\langle M\rangle$**".

## 2. Soundness of char_orth

- `char_phi` turns `HasChar` at `Z = φ_ij` into `S (Aφ_ij) Sᵀ = c(ε) ε_i ε_j · Aφ_ij`, using `signConj_phi` (`Sᵀ φ_ij S = ε_i ε_j φ_ij`) and linearity of `extend`. `inner2_signConj` then gives `k · x = x` with `k = c ε ε_iε_j · c' ε ε_iε_j = c ε · c' ε = −1`. The certificate `−½·e + (x/2)·hk` expands to `x`, so `x = 0`. I checked the certificate by hand, and the kernel checks it too.
- **The values in {±1} are neither assumed nor needed.** Only the product `−1` is used, together with `ε_i² = 1`. They also come for free: if `A ≠ 0` then `c(ε)² = 1` follows from `S² = 1`, and if `A = 0` the conclusion is trivial. So `c ε · c' ε = −1` is the right separation hypothesis, and on nonzero operators it is equivalent to `c ε ≠ c' ε`.

## 3. Does hess_blockwise say "checkable block by block"?

- It says that the Hessian form is additive over a finite family of tangent vectors in pairwise separated sign characters (no cross terms), and `hess_nonpos_blockwise` gives the direction "nonpositive on each piece ⇒ nonpositive on the sum". The converse is immediate, because each piece is itself in `weylPerpR a`. So the "iff" of the record's sentence holds for every vector that is a sum of isotypic pieces.
- **Left to the record: the covering**, meaning that every `v ∈ W⊥` is such a sum. Nothing else is missing. The cut by ⟨M⟩ is built in, since the pieces are taken in `weylPerpR a`, so the trivial piece is automatically in `D_n ∩ M⊥`. The L24 translation from λ_max(L_e) ≤ ½ to nonpositivity of `hessQ` is `hessQ_op`. Diagonality is the hypothesis `hfix`, which is weaker than "diagonal".
- **O1. The owed covering is weaker than the INDEX states it.** The INDEX owes "the decomposition of W⊥ itself into these summands on CurvOp2". For the block-by-block clause, only the character decomposition is needed. That decomposition is generic: the averaging projectors `P_t = 2^{-n} Σ_ε setChar t ε · (conj by diag ε)` sum to the identity over `t ⊆ univ`, and they preserve Weyl and `⟨a, ·⟩ = 0` at a Γ-fixed `a`. It needs no identification of the pieces with `D_n`, `V_jk` and `V_ijkl`. The specific summand list matters only for the block sizes. Suggest rewording the Owed clause to separate the two debts. The covering is still unproved in Lean either way.

## 4. hessQ and satisfiability

- `hessQ a v = ‖v‖² · (d²/dt²) P(cos t · a + sin t · v/‖v‖)|₀`, the second derivative along the great circle, which is the Riemannian Hessian form at a critical point. `hessQ_eq` gives `6(⟨a,Q v⟩ − ½P(a)‖v‖²)` and `hessQ_op` gives `⟨6θ(L_e − ½)v, v⟩`, which is L24's operator. It matches.
- **Witness, checked in Lean** (scratch file `R1769.lean`, `lake env lean` exit 0, `witness` on `[propext, Classical.choice, Quot.sound]`, no `sorry`):
  - `a`: `balanced_unit 3`, the unit balanced S³×S³ at n = 6.
  - `hfix`: `signChar_diag`.
  - `v 0`: `pairS` at (0,1) with `c = δ₂ − δ₃`, character `setChar {0,1}`.
  - `v 1`: `pairS` at (2,3) with `c = δ₀ − δ₁`, character `setChar {2,3}`.
  - Tangency: `pair_mem_weylPerp`. Separation: `setChar_sep`. `hess_blockwise` then applies with `s = univ : Finset (Fin 2)`.
- Nonzeroness: `v 0`'s `B` is exactly `pair_B_exists`'s nonzero operator. `v 1`'s is nonzero by the same `coord_pairS_diag` reading (coordinate (2,0,3,0) equals `c 0 = 1`). That step is argued here, not compiled (O2).

## 5. Axioms

- `hess_blockwise`, `setChar_sep`, `char_orth`, `hess_nonpos_blockwise`: `[propext, Classical.choice, Quot.sound]`. No `sorryAx`, no `native_decide`.

## 6. INDEX row

- The L120 row's L120Blocks sentence names the four declarations with correct content and the standard three axioms, and the file is registered in `lean/HamiltonsCubic.lean` (line 989). It is accurate except for the Owed phrasing (O1).
- The row keeps **partial**, which is right while the covering is owed.

## 7. Falsifiers and search

- `char_orth`: operators `A`, `B` with characters of product −1 at some sign vector and `innerOp2 A B ≠ 0`. Search: I re-derived the proof and checked the certificate. No such pair can exist, because the argument is termwise on each `φ_ij`.
- `hess_blockwise` / `hess_nonpos_blockwise`: a Γ-fixed unit critical Weyl `a` with `P(a) ≠ 0` and isotypic tangent vectors `v_1`, `v_2` of separated characters with `⟨H v_1, v_2⟩ ≠ 0`. Search: I traced the reduction to `hessOp_char` plus `char_orth`, and instantiated the hypotheses at a concrete `a` to rule out vacuity. The hypotheses are satisfiable with two summands, so the theorem is not vacuous.
- `setChar_sep`: distinct finsets `t ≠ u` whose products agree at every sign vector. Search: I checked the proof's case split on `symmDiff`, where the flip at `x ∈ t \ u` gives `(−1)(1)`. The kernel checks this.
- Record-level: a `v ∈ W⊥` with no isotypic decomposition inside `W⊥`. None exists, by the averaging argument in O1, but that argument is not in Lean.
- No sweeps and no numerics were run. The only computation was the Lean check file above.

## Observations

- **O1**: the Owed clause in the INDEX conflates two things. The covering the block-by-block clause needs is the generic Γ-character decomposition, and identifying the pieces with `D_n`, `V_jk` and `V_ijkl` is a separate debt that bears on block sizes.
- **O2**: the witness compiles, and the nonzeroness of its second vector is argued rather than compiled. A `pair_B_exists`-style lemma for general `(j,k)` would close that.
- **O3**: `setChar_four` (`setChar {i,j,k,l} = ε i * ε j * ε k * ε l` for distinct indices) is not stated. The docstring says the four-set blocks are covered, and the bridge to `four_act_signMat`'s lambda is left to the user.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS**
