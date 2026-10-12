# Reviewer r1839, L220 step 8 (FourStep8.lean), the operator assembly (FourL220.lean) and b55d4df6's inner_char_four and INDEX rows

Cold Gate 2 review of commits 2c5111b1 and b55d4df6 on an analysis-only footing. I read [FourStep8.lean](../lean/HamiltonsCubic/Results/FourStep8.lean), [FourL220.lean](../lean/HamiltonsCubic/Results/FourL220.lean), the b55d4df6 diff of [FourStep67.lean](../lean/HamiltonsCubic/Results/FourStep67.lean) and [lean/INDEX.md](../lean/INDEX.md), the record's Lemma L220 in [findings/second-order.md](../findings/second-order.md) (statement, setting, steps 1 to 9), and at source the definitions `coordOp`, `PiQ`, `E2`, `IsWeight`, `foxProd2`, `innerOp2`, `normSq2`, `Qop2`, `SignChar`, `setChar`, and the lemmas `trivial_block_iff`, `theta_sq_le`, `equality_case`, `pattern_entry_sq_le`, `L220_split`, `L220_step1_crit`, `inner_PiQ`, `normSq2_PiQ`, `normSq2_coordOp`, `foxProd2_coordOp`, `Qop2_coordOp`, `foxProd2_self`, `step5`, `step6`, `step7`, `norm_split`, `Lq_eigen`. Runs: `lake env lean` on two scratch files under /private/tmp (`#print axioms` on ten declarations, `#check` on two, and an `example` applying `inner_char_four` at the degenerate index set `{i, i, k, l}`), and a pure-Python screen of `kappa_expand` and of the step 8 inequality at one random weight on n = 6 (seconds). The screen is a screen and carries no weight as evidence. Heartbeat log: [agent_logs/review-r1839.log](../agent_logs/review-r1839.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | `col_bound`: `½cᵀKc ≤ M|c|²` at `x + y + z = 0`, `M ≥ 0, x, y, z` | CONFIRMED |
| 2 | `colT`, `colN`, `mul_self_apply` | CONFIRMED |
| 3 | `kappa_expand`: κ as the weighted internal squares plus `∑_m ½c_mᵀKc_m` over every column | CONFIRMED |
| 4 | `norm_ge`: `‖r‖²` at least the six internal squares plus `∑_{m∉Q}|c_m|²` | CONFIRMED |
| 5 | `kappa_le`: `κ ≤ M‖r‖²` under the two pairing-sum equalities | CONFIRMED |
| 6 | `step8`: `3κ ≤ θ‖r‖²`, the record's step 8 | CONFIRMED |
| 7 | `PiQ_entries`, `proj_PiQ`: the projection `D = q + r` with `r ⊥ Π_Q` | CONFIRMED |
| 8 | `L220_bound`: `θ² ≤ 3/2`, the record's statement without its equality and n ≥ 12 clauses | CONFIRMED WITH OBSERVATIONS |
| 9 | `L220_eq`: at `θ² = 3/2`, `D ∈ Π_Q` and `‖ν‖² = 1/2` | CONFIRMED WITH OBSERVATIONS |
| 10 | `inner_char_four` without distinctness hypotheses | CONFIRMED |
| 11 | INDEX L220 rows after b55d4df6, state `partial` | CONFIRMED |

**Summary: every declaration is kernel-checked on the standard three axioms and says what the record's step 8 and inequality say, and the observations concern a missing operator-level witness and two docstring wordings.**

## A. Statement fidelity of `step8`

- **Normalisation of the product.** `foxProd2 X Y = ½(Q(X+Y) − Q(X) − Q(Y))`, so `foxProd2 r r = Q(r)` (this is `foxProd2_self`), the symmetric bilinear `∘` with `X ∘ X = Q(X)`. The record's step 3 writes `Q(W) = D∘D + 2D∘ν + ν∘ν`, the same convention. So `innerOp2 (foxProd2 r r) q = ⟨r∘r, q⟩`, which is the record's step 6 definition `κ := ⟨r∘r, q⟩ = ⟨L_q r, r⟩` at the unnormalised `q`.
- **The factor of 2.** The record's step 8 reads `2⟨L_q̂ r, r⟩ = 2[x(p²+p'²)+y(a'²+b'²)+z(c'²+d'²)] + 2Σ + ∑_m c_mᵀ q̂ c_m` with `q̂` the symmetric matrix carrying `x` on both `ij` and `ji`. Then `c_mᵀ q̂ c_m = 2[x(c_i c_j + c_k c_l) + y(c_i c_k + c_j c_l) + z(c_i c_l + c_j c_k)]`, so halving gives κ̂ as the internal terms plus Σ plus `∑_{m∉Q} colT`. `colT` is exactly `½c_mᵀKc_m`. No factor is lost.
- **Σ.** `kappa_le`'s `hint` identifies `∑_{m∈Q} colT` with `x(w_ik+w_jl)(w_il+w_jk) + y(w_ij+w_kl)(w_il+w_jk) + z(w_ij+w_kl)(w_ik+w_jl)`. With the record's labels `p, p', a', b', c', d'` on `ij, kl, ik, jl, il, jk` this is the record's `Σ = z(p+p')(a'+b') + y(p+p')(c'+d') + x(a'+b')(c'+d')` term for term. I checked the column-by-column bookkeeping by hand: column `i` contributes `x·w_ki w_li`, column `j` `x·w_kj w_lj`, column `k` `x·w_ik w_jk`, column `l` `x·w_il w_jl`, summing to `x(w_ik+w_jl)(w_il+w_jk)`.
- **Unit `q̂` against unnormalised `(x, y, z)`.** The record bounds `κ ≤ max(x̂,ŷ,ẑ)‖q‖‖r‖²`. Since `max(x,y,z) = ‖q‖·max(x̂,ŷ,ẑ)`, the Lean's `M = max(x,y,z)` gives the same middle term, and `3M² ≤ 2(x²+y²+z²) = ‖q‖² = θ²/3` (from `pattern_entry_sq_le` and `ha`) is the record's `max(x̂,ŷ,ẑ) ≤ 1/√3`. With `θ ≥ 0` this is `3M ≤ θ`, hence `3κ ≤ θ‖r‖²`, the record's `κ ≤ (θ/3)‖r‖²`.
- **Hypotheses.** The record's `r ∈ 𝒟_n ⊖ Π_Q` is `IsWeyl2 r`, `SignChar 1 r` (which `trivial_block_iff` identifies with `r = w ⊙ ·`, `w` a weight) and `hperp` over every `(a,b,c)` with `a + b + c = 0`, which is all of `Π_Q`. The record's `3‖q‖² = θ²` is step 5's output and is `ha`. Nothing stronger, nothing weaker.

## B. `kappa_expand` and `col_bound`

- **Derivation by hand.** `Qop2_coordOp` gives `Q(w ⊙ ·) = (w⊙w + w²) ⊙ ·`, `inner_PiQ` gives `⟨PiQ(x,y,z) ⊙ ·, b ⊙ ·⟩ = x(b_ij+b_kl) + y(b_ik+b_jl) + z(b_il+b_jk)`, and `(w²)_ab = ∑_m w_am w_bm` by symmetry. Substituting gives exactly the Lean right-hand side, with the column sum over every `m` (the `m ∈ Q` columns carrying Σ).
- **Screen.** At n = 6, `Q = {0,1,2,3}`, a random weight built from twelve four-cycle patterns (row sums 4e-16), `(x,y,z) = (0.7, −0.2, −0.5)`: `⟨PiQ, w⊙w + w²⟩ = 1.88035038534940` against the formula `1.88035038534941`, residual 4e-16. After the `proj_PiQ` projection, the orthogonality residuals were 2e-16 and 1e-16, and `3κ − θ‖r‖²` stayed at or below −2.27 over 500 random directions `(x, y, −x−y)`. A screen only.
- **`col_bound`.** The `ring` identity is the eigen-decomposition on `(1,1,1,1)/2`, `(1,1,−1,−1)/2`, `(1,−1,1,−1)/2`, `(1,−1,−1,1)/2`, with eigenvalues of `½K` equal to `x+y+z`, `x`, `y`, `z`. It **does need `x + y + z = 0`**: the first coefficient is `M − (x+y+z)`, which is `M` only there. The proof uses `hs` through `subst`. `hM : 0 ≤ M` covers the zero eigenvalue. This matches the record's spectrum `{0, 2x, 2y, 2z}` of `q̂`.

## C. `L220_bound` fidelity

- **𝒟_n and V_Q.** `D` Weyl of character `1` is `𝒟_n` by `trivial_block_iff`. `ν` Weyl of character `χ_Q = setChar {i,j,k,l}` is `V_Q`, whose elements `four_eq_sig` shows are the two-dimensional span of the sandwiches, the record's `V_Q`. `ν ≠ 0`, `θ > 0`, `normSq2 (D + ν) = 1` are the record's `ν ≠ 0`, `θ > 0`, unit.
- **Critical in 𝒮_Q.** `SW t` is `𝒮_t ∩ 𝒲_n` and `SW_Qop2` shows `Q` maps it into itself. The gradient of `P` at `W` is `3Q(W)`, which then already lies in the subspace, so the Lagrange condition on its unit sphere is exactly `Q(W) = λW` in the full space. `hQ : Qop2 (D + ν) = θ • (D + ν)` is therefore neither stronger nor weaker than criticality in 𝒮_Q, and `L220_step1_crit` shows a local maximiser satisfies it with `θ = P(W)`.
- **θ is P(W).** `Pcubic2_eq_innerOp2` gives `P(W) = ⟨W, Q(W)⟩ = θ‖W‖² = θ` under `hunit`, so the Lean's free `θ` is forced to be `P(W)`.
- **The conclusion.** With `θ > 0`, `θ² ≤ 3/2` is equivalent to `θ ≤ √(3/2)`.
- **Range of n.** The record says `n ≥ 5`, the Lean needs only four distinct indices, so n ≥ 4. The Lean statement is at least as general as the record's (O3).
- The equality characterisation ("exactly at padded `W_CP²`") and the n ≥ 12 clause lie outside `L220_bound`, and the INDEX owes them (section H).

## D. Hypothesis inventory and non-vacuity

- `col_bound`: `hs`, `hx`, `hy`, `hz`, `hM` all used.
- `mul_self_apply`: `hw.symm` only. The distinctness hypotheses are omitted.
- `kappa_expand`: `hw.symm`, `hw.hollow`, the six distinctness hypotheses (through `inner_PiQ`). `rowSum` is unused, as the commit says.
- `norm_ge`: `symm`, `hollow`, distinctness (for the four-element sum). `rowSum` unused.
- `kappa_le`: every hypothesis used, `h1` and `h2` in `hcross`, `hs` in both `hcross` and `col_bound`.
- `step8`: `hs`, `hθ` (in `3M ≤ θ`), `ha`, `hrW` and `hr` (to obtain `w`), `hperp` (to obtain `h1`, `h2`). All used, none vacuous.
- `proj_PiQ`: `hDW` and `hD` used to obtain `w`.
- `L220_bound`, `L220_eq`: `hν0` feeds `step5`, `hθ` feeds `step7`, `step8`, `theta_sq_le`, `hunit` feeds `norm_split`, `hQ` feeds `L220_split`. All used.
- **Non-vacuity.** I did not construct an operator-level object satisfying `L220_bound`'s hypotheses (O1). The obstruction: verifying `Qop2 (q + ν) = θ(q + ν)` at `q = t·PiQ(2,−1,−1)`, `ν = t·(2,−1,−1)` in signed coordinates needs `2q∘ν` evaluated on the sandwiches `sig4`, and the library holds `PiQ_mul` (for `q∘q`) and `nu_sq` (for `ν∘ν`) but no lemma computing `foxProd2 (coordOp (PiQ …)) (sig4 …)`. `step5` reaches the eigenvalue through inner products only. The padded `W_CP²` witnesses in the library ([L47CPm.lean](../lean/HamiltonsCubic/Results/L47CPm.lean), [L70CPmCrit.lean](../lean/HamiltonsCubic/Results/L70CPmCrit.lean)) live in the tensor layer, with no bridge to a `D + ν` split. What I can say: each hypothesis is separately satisfiable (`sigA_char` with `norm_sig = 4` gives a nonzero Weyl `ν` of character `χ_Q`), the scalar chain has a witness at padded `W_CP²` in [L220Statement.lean](../lean/HamiltonsCubic/Results/L220Statement.lean), and the record's converse (r1835 O4) says the point exists. The joint operator witness remains unconstructed.

## E. `proj_PiQ`

- With `s₁, s₂, s₃` the pairing sums and `m` their mean, the choice `x = (s₁ − m)/2` and cyclically gives `x + y + z = 0` by `ring`.
- `r = coordOp (w − PiQ(x,y,z))`, and `w − P` is a weight (symmetric, hollow, zero row sums from `PiQ_weight`), so `r` is Weyl of character `1`.
- `⟨r, PiQ(a,b,c)⟩ = a(s₁ − 2x) + b(s₂ − 2y) + c(s₃ − 2z) = m(a + b + c) = 0` for every `a + b + c = 0`, and those `(a,b,c)` are all of `Π_Q`. The `linear_combination m * habc` is exactly this. The screen agrees to 2e-16.
- This is the orthogonal projection: `q ∈ Π_Q`, `r ⊥ Π_Q`, `D = q + r`.

## F. `L220_eq`

- The conclusion is `∃ x y z, x + y + z = 0 ∧ D = coordOp (PiQ x y z) ∧ ‖ν‖² = 1/2`, obtained from `equality_case`'s `R = 0` by `normSq2_eq_zero`. `D ∈ Π_Q` is `r = 0`, the record's first forced condition, and `‖ν‖² = 1/2` its second.
- The record's third forced condition (the `S²×S²` shape `q ∝ (2,−1,−1)` up to permutation), the identification with padded `W_CP²`, and the converse are not in `L220_eq`. The INDEX row lists all three as owed ("the rest of the equality case at the operators, the `S²×S²` shape, its identification with padded `W_CP²` and the converse"). Honest.
- The module docstring summarises `L220_eq` as "`‖r‖² = 0`", while the theorem states `D = coordOp (PiQ …)` (O2). The two are equivalent, and the declaration's own docstring and the INDEX row both give the actual form.

## G. Axioms

`#print axioms` on `col_bound`, `kappa_expand`, `norm_ge`, `kappa_le`, `step8`, `PiQ_entries`, `proj_PiQ`, `L220_bound`, `L220_eq`, `inner_char_four`: each depends on `[propext, Classical.choice, Quot.sound]` and nothing else. The three `error` lines in that first scratch run were my own misnamed identifiers in an appended `example`, and after the fix a second scratch file compiled with no errors in the example.

## H. INDEX bookkeeping

- **Result row [L220].** It lists `col_bound`, `kappa_expand`, `norm_ge`, `kappa_le`, `step8` and `proj_PiQ`, `L220_bound`, `L220_eq` with statements matching the Lean, including `L220_eq` as `D ∈ Π_Q` and `‖ν‖² = 1/2`. It owes the n ≥ 12 clause and the rest of the equality case. Nothing proved is owed and nothing unproved is claimed.
- **Statement row.** It owes "the n ≥ 12 clause … and the equality case at the operators beyond `r = 0` and `‖ν‖² = 1/2`", and points to the result row for steps 2, 4 to 8, the norm split, the projection and `L220_bound`. Consistent.
- **`inner_char_four`.** The row says it carries no distinctness hypothesis, which the `#check` confirms. My scratch `example` applied it at `setChar {i, i, k, l}` and it compiled, so the statement really holds at degenerate index sets. The new proof is sound: `mul_prod_erase` splits off `ε i = −1` and every other element of the erased set differs from `i`, so the product is `−1` whatever `j, k, l` are.
- **State `partial`** is right: the statement's equality clause is only two thirds done at the operators, and its n ≥ 12 clause is untouched.

## I. What would break each statement, and what I did to look

- **`kappa_expand`**: a weight `w` and `(x,y,z)` where `⟨PiQ, w⊙w + w²⟩` differs from the column formula. Hand derivation plus a one-point screen (residual 4e-16). The kernel check is decisive.
- **`col_bound`**: a vector `c` with `½cᵀKc > M|c|²`, possible only if `x + y + z ≠ 0` or `M` below an eigenvalue. The hypotheses exclude both.
- **`step8`**: an `r ∈ 𝒟_n ⊖ Π_Q` with `3κ > θ‖r‖²`. Screened 500 directions at one `r`, none found. Kernel-checked.
- **`proj_PiQ`**: an `r` with a nonzero `Π_Q` component. The explicit inner product vanishes identically.
- **`L220_bound`**: a unit critical `W = D + ν`, `ν ≠ 0`, `θ > √(3/2)`. The derivation chain is kernel-checked from `Qop2 (D+ν) = θ(D+ν)`. The one place it could be empty is a hypothesis set with no model (O1), which would make it true and useless rather than false.
- **`L220_eq`**: an equality point with `r ≠ 0` or `‖ν‖² ≠ 1/2`. Kernel-checked through `equality_case`.

## Observations

- **O1.** No operator-level witness satisfies `L220_bound`'s hypotheses in the library, so the operator statement is shown non-vacuous only through the record's converse and the scalar witness. The missing lemma is `2q∘ν` on the sandwiches, `foxProd2 (coordOp (PiQ i j k l x y z)) (sig4 …)` in closed form. It is also what the owed converse needs, so the converse would discharge O1.
- **O2.** The module docstring of [FourL220.lean](../lean/HamiltonsCubic/Results/FourL220.lean) summarises `L220_eq` as "`‖r‖² = 0` and `‖ν‖² = 1/2`", while the theorem concludes `D = coordOp (PiQ i j k l x y z)`. They are equivalent, and a one-word alignment with the declaration would help a reader.
- **O3.** `L220_bound` and `L220_eq` hold for every n with four distinct indices, so n ≥ 4, more general than the record's n ≥ 5. On my reading the record's n ≥ 5 serves the subalgebra identification of step 1 (a flip at an index outside `Q`), which the operator statement takes as hypotheses rather than deriving. No INDEX change is needed, and a note on the row would make the generality visible.
- **O4.** `step8`, `kappa_le` and `norm_ge` use only the symmetry and hollowness of `w`, as the commit body says. Zero row sums enter only through `r = coordOp w` being Weyl of character `1`.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** Step 8 on the operators is the record's step 8 with no factor lost, the projection is correct, and `L220_bound` is the record's inequality `θ ≤ √(3/2)` under hypotheses equivalent to the record's, all on the standard three axioms. `L220_eq` proves the first two of the record's three forced conditions, and the INDEX owes the rest together with the n ≥ 12 clause, so `partial` is right. The main open point is O1, an operator-level witness, which the owed converse would supply.
