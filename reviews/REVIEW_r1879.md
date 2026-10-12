# REVIEW r1879: L222 item 5 on the rotated tensor, L222MinW.lean

Gate 2 review of [L222MinW.lean](../lean/HamiltonsCubic/Results/L222MinW.lean) against [second-order.md](../findings/second-order.md), Lemma L222, item 5, the minimising-angle sentence, and against [r1876](REVIEW_r1876.md) O1 and O2, which the file answers. Read at source together with [L222Min.lean](../lean/HamiltonsCubic/Results/L222Min.lean) (`L222_min`), [L222Rot.lean](../lean/HamiltonsCubic/Results/L222Rot.lean) (`Sjk_rot`, `sum_vy`), [L222Op.lean](../lean/HamiltonsCubic/Results/L222Op.lean) (`char_split_zero`), [OddPart.lean](../lean/HamiltonsCubic/Results/OddPart.lean) (`Dminus_weight`), [L224Rot.lean](../lean/HamiltonsCubic/Results/L224Rot.lean) (`rot_even`, `rot_Dminus`, `rot_nuX`), [PairConv.lean](../lean/HamiltonsCubic/Results/PairConv.lean) (`nuX_char`), [PairNorm.lean](../lean/HamiltonsCubic/Results/PairNorm.lean) (`normSq2_nuX`), [Families.lean](../lean/HamiltonsCubic/Base/Families.lean) (`IsWeight`) and the L222 row of [lean/INDEX.md](../lean/INDEX.md). Footing: analysis only. The one Lean run was `lake env lean` on a scratch file in /private/tmp/r1879/ holding four `#print axioms` lines and two short `example` screens.

| # | Claim | Verdict |
|---|---|---|
| 1 | `odd_sum_zero`: `Σ vy(y) = 0` for `y_a = (w_{ja} − w_{ka})/2` at a weight `w` | CONFIRMED |
| 2 | `rot_formula`: `R·(coordOp w + ν_x) = coordOp w' + (2cs ν_y + (c² − s²) ν_x)`, `w'` a weight | CONFIRMED |
| 3 | `pair_part_unique`: two splits into characters `1` and `ε_jε_k` share their pair part | CONFIRMED |
| 4 | `L222_min_W`: under the all-splits `hmin`, the record's two conclusions | CONFIRMED WITH OBSERVATIONS |

Summary: the file types both bridges r1876 left to reading, the weight discharge of `hys` (O2) and the identification of `hmin`'s expression with the pair part of `R·W` (O1), and the all-splits hypothesis is equivalent to L222Min's explicit one because a split exists (`rot_formula`) and its pair part is unique (`pair_part_unique`).

## A. Hypothesis inventory, used and unused

`odd_sum_zero` uses `hjk` (through `sum_vy`) and all three fields of `IsWeight`: `rowSum` at `j` and `k`, `hollow` at `j` and `k`, and `symm k j`. By hand: `Σ_c vy(y)_c = Σ_c y_c − y_j − y_k = (0 − 0)/2 − (−w_{kj}/2) − (w_{jk}/2) = (w_{kj} − w_{jk})/2 = 0`. This is the same derivation as the private one inside `Sjk_rot` (L222Rot lines 55 to 63), now exported, which is exactly what r1876 O2 asked for.

`rot_formula` uses `hjk`, `hcs` (in all three rotation lemmas), `hw` (symmetry of `ev`, and the weight of `w'`) and `hxv` (the weight of `D⁻_x` through `Dminus_weight`). It takes no `x_j = x_k = 0` hypothesis, which makes it slightly more general than `Sjk_rot`'s internal `hrot`. Nothing unused.

`pair_part_unique` uses all four character hypotheses and `h` through one call of `char_split_zero`. `hjk` is passed to `char_split_zero`, where it is needed (the character `ε_jε_k` at the sign vector `sgn j` is `−1`).

`L222_min_W` uses `hjk`, `hw` (through `odd_sum_zero` and `rot_formula`), `hxj`, `hxk`, `hxs` (for `hxv`, `nuX_char` on `x`, and passed to `L222_min`), and `hmin` at the one split `rot_formula` produces. Every hypothesis is used.

**`pair_part_unique` is not used by `L222_min_W`.** It is unused anywhere in the Lean tree: a grep for the name finds only its definition, the module docstring and the INDEX row. The proof of `L222_min_W` needs only the direction "all-splits `hmin` implies L222Min's explicit `hmin`", which instantiates `hmin` at the split `(coordOp w', 2cs ν_y + (c² − s²) ν_x)`. The converse direction is where `pair_part_unique` enters: given L222Min's explicit `hmin` and any split `R·W = D' + ν'`, `pair_part_unique` against the `rot_formula` split gives `ν' = 2cs ν_y + (c² − s²) ν_x`, so the bound transfers. So it is the right supporting lemma. It is what makes "every split" and "the split" the same hypothesis, which in turn makes the all-splits wording neither stronger nor weaker than the record's "the `ν` of the rotated tensor". It does not appear as a stated equivalence, however (O1).

One check on its scope: `char_split_zero` and `pair_part_unique` take arbitrary `CurvOp2` of the two characters, with no Weyl hypothesis, and `hmin`'s `D'` and `ν'` are likewise arbitrary operators of those characters. The uniqueness therefore covers every split `hmin` quantifies over, not only Weyl ones. Good.

## B. Fidelity and satisfiability of hmin

The record: "At an angle of the `(j,k)`-rotation minimising `‖ν‖²`, with `D`, `K` and `x` those of the rotated tensor". The Lean: at `W = coordOp w + ν_x`, every rotation `R = Rot j k c s` and every character split `R·W = D' + ν'` has `‖ν_x‖² ≤ ‖ν'‖²`. Read with A's equivalence, this is "`‖ν‖²` of `W` is at most `‖ν‖²` of every rotation of `W`", i.e. `W` itself sits at a minimising angle of its orbit. r1876 C already showed that this reading of "with `D`, `K`, `x` those of the rotated tensor" is right, since the rotations of the plane form a group and rotating to the minimiser reparametrises the orbit. The global-minimum reading (every rotation, not a neighbourhood) is r1876 O3's point and is unchanged here: the sinusoid in `4φ` makes it equivalent to the local reading, and that remains prose.

`w` is the weight of the character-1 part and plays the record's `K`. That reading goes through `coordOp_eq_restrict` and `trivial_block_iff` (used in the proof's `hD'`), the same as in `Sjk_rot`.

**Not vacuous by emptiness.** A vacuous-by-emptiness failure would need `R·W` to have no split, so that `hmin` holds trivially at that rotation. `rot_formula` supplies a split at every rotation, and my second scratch `example` restates that existence from `rot_formula` and elaborates. So `hmin` always binds at least one `ν'`, namely the explicit pair part, and it is no weaker than L222Min's hypothesis.

**Satisfiable.** A satisfying object: `x = 0` at any weight `w` (any `n`, any `j ≠ k`). Then `‖ν_0‖² = 2 Σ vy(0)² = 0 ≤ ‖ν'‖²`. My first scratch `example` proves the all-splits `hmin` at `x = 0` from `normSq2_nuX` and `normSq2_nonneg`. That is a screen that the hypothesis can hold, and it says nothing about non-trivial `x`. For non-trivial `x`, r1876 F's object applies: `x ⊥ y_v` with `‖x‖ ≤ ‖y_v‖`, where `‖ν‖²` along the orbit is `2(C²‖x‖² + S²‖y_v‖²) ≥ 2‖x‖²`. By hand, this needs `n ≥ 5`. At `n = 4` the plane `{z_j = z_k = 0, Σz = 0}` is a line, so `x ⊥ y_v` forces `x = 0` or `y_v = 0`, and `y_v = 0` with `hmin` forces `x = 0`. At `n = 4` the only minimisers are therefore `x = 0`, and both conclusions hold there trivially.

## C. rot_formula: w' against L222Rot's D-part

The witness `w' = w + (−1)•D⁻_y + (c² − s²)•D⁻_y + (−2cs)•D⁻_x` is character for character the matrix in L222Rot's `refine` at line 110, same summands in the same order, and the weight proof is the same three nested `isWeight_add_smul` calls. The pair part `(2cs)•ν_y + (c² − s²)•ν_x` is L222Rot's `ν'` at line 111. The proof of `rot_formula` repeats L222Rot's `ev`, `hevT`, `hevs` and `hsplit` verbatim.

The final `module` step. After the first `rw`, the left side is `coordOp ev + ((c² − s²)•coordOp D⁻_y + (2cs)•ν_y) + ((c² − s²)•ν_x + (−2cs)•coordOp D⁻_x)`. After the second `rw` (three `coordOp_add`, three `coordOp_smul'`, then `hsplit` on the remaining `coordOp w`), the right side is `(coordOp ev + coordOp D⁻_y) + (−1)•coordOp D⁻_y + (c² − s²)•coordOp D⁻_y + (−2cs)•coordOp D⁻_x + ((2cs)•ν_y + (c² − s²)•ν_x)`. The `coordOp D⁻_y` and `(−1)•coordOp D⁻_y` cancel, and what is left is the left side term for term. That is a linear identity over `ℝ` in the atoms `coordOp ev`, `coordOp D⁻_y`, `coordOp D⁻_x`, `ν_y`, `ν_x`, which is what `module` closes. Checked by hand.

One subtlety I checked: the second `rw [..., hsplit]` rewrites `coordOp w` on the right. After the first `rw`, the left side no longer contains `coordOp w` (it was rewritten by the first `hsplit`), so the second rewrite touches only the right-hand occurrence. `coordOp_add` could in principle have split `coordOp (w + …)` so that `coordOp w` is exposed, and it is: that is the occurrence `hsplit` hits. Consistent.

## D. Axioms

`#print axioms` on a scratch file importing [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean) (which imports the module at line 1079), via `lake env lean`: `odd_sum_zero`, `rot_formula`, `pair_part_unique` and `L222_min_W` each depend on `[propext, Classical.choice, Quot.sound]`, the standard three. The two `example` screens of B (the all-splits `hmin` at `x = 0`, and a split existing at every rotation) elaborated with exit code 0 and one unused-variable warning on the first, whose `hw` binder the proof does not need.

## E. Breakers

- `odd_sum_zero`: breaks if `w` is not symmetric. Object: `n = 3`, `j = 0`, `k = 1`, `w` hollow with zero row sums and `w_{01} ≠ w_{10}`, e.g. rows `(0, 1, −1)`, `(2, 0, −2)`, `(0, 0, 0)`. Then `Σ vy(y) = (w_{10} − w_{01})/2 = 1/2`. Found by hand from the identity in A. The file carries `IsWeight`, which includes `symm`, so the object fails the hypothesis.
- `rot_formula`: breaks if `hxv` is dropped, since then `D⁻_x` is not a weight and the witness `w'` fails `IsWeight` (its row sums pick up `−2cs Σ vy(x)`). The identity itself survives. I looked for a way the equation could fail at the stated hypotheses and found none: it is `hrot` of L222Rot with the character-1 part collected by `coordOp` linearity, which I recomputed in C.
- `pair_part_unique`: breaks at `j = k`, where `setChar {j, j}` is `setChar {j}` and `char_split_zero`'s separating sign vector `sgn j` no longer separates `1` from the pair character. The file carries `hjk`. At `j ≠ k` a breaker would be a nonzero operator of both characters, which `char_split_zero` excludes. I read its proof (the character at `sgn j` is `−1`) and found no gap.
- `L222_min_W`: breaks if `hmin` quantified over splits that need not exist (vacuity), which B rules out through `rot_formula`. It breaks at a non-minimiser, which is `hmin` failing, as r1876 F records for `L222_min`. It would break with the constant `¼`, by r1876 F's equality case, which carries over since the two hypotheses are equivalent (A).

## Observations

- O1. `pair_part_unique` is unused. Its role, making the all-splits `hmin` equivalent to L222Min's explicit `hmin`, is argued here and not typed. A one-line corollary stating the equivalence (`hmin_W ↔ hmin_explicit` at a weight, the reverse direction by `pair_part_unique` against `rot_formula`) would give the lemma a consumer and put the equivalence on file. As it stands the docstring's claim that "every split" is the record's wording rests on this review.
- O2. `rot_formula` and `Sjk_rot` carry the same twenty-line derivation of `ev`, `hevT`, `hevs`, `hsplit`. `Sjk_rot` could now be proved from `rot_formula` and `odd_sum_zero`. Cosmetic, since both are correct.
- O3. The L222 row of [lean/INDEX.md](../lean/INDEX.md) now credits `L222_min_W` with stating the minimising angle through every split, and its **Owed** clause still lists "the minimising angle being untyped (r1824 O5)". After this file, what remains untyped is the local-versus-global equivalence (r1876 O3) and item 5's infinitesimal form, and the owed clause should say that.
- O4. The docstring's sentence that the identification "being L222Rot's computation, read rather than typed" describes the state before this file. It is framed as the reason for the file, so it reads correctly, but a reader landing on L222Min.lean's docstring still finds the older wording.

## Verdict

CONFIRMED WITH OBSERVATIONS. `odd_sum_zero`, `rot_formula` and `pair_part_unique` are correct, and `L222_min_W` states the record's minimising angle on the rotated tensor itself with every hypothesis used. r1876 O1 and O2 are answered. The one untyped link, the equivalence of the all-splits and explicit hypotheses, holds by `pair_part_unique` and is O1. None of the observations changes a verdict.
