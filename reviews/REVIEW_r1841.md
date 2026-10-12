# Reviewer r1841, L220's supremum (FourSup.lean) and equality points (FourEqNu.lean), with the INDEX rows

Cold Gate 2 review of commits f46d227b and b78e652d, working from the brief's verbatim quotation of [Lemma L220](../findings/second-order.md) (lines 1542 to 1560) and from the Lean sources. I read [FourSup.lean](../lean/HamiltonsCubic/Results/FourSup.lean) and [FourEqNu.lean](../lean/HamiltonsCubic/Results/FourEqNu.lean) in full, and at source `SW` and `InS` ([SubFermat.lean](../lean/HamiltonsCubic/Results/SubFermat.lean), [BlockSub.lean](../lean/HamiltonsCubic/Results/BlockSub.lean)), `trivial_block_iff` ([L120Ident.lean](../lean/HamiltonsCubic/Results/L120Ident.lean)), `sphere_unit` ([L2Operators.lean](../lean/HamiltonsCubic/Results/L2Operators.lean)), `sphereWeight`, `thetaSplitSq`, `thetaSplit`, `theta0Sq`, `ThetaSqOdd`, `ThetaSq`, `thetaSplitSq_balanced`, `thetaSplitSq_odd` ([Families.lean](../lean/HamiltonsCubic/Base/Families.lean)), `theta_sphereProduct_value` ([SphereValue.lean](../lean/HamiltonsCubic/Base/SphereValue.lean)), `thetaOddSq` and `thetaOddSq_eq`, `L57_even`, `L57_odd`, `L220_n12_even`, `L220_n12_odd` ([FourN12.lean](../lean/HamiltonsCubic/Results/FourN12.lean)), `L220_eq_shape`, `Q_nu`, `fox_pair`, `converse`, `L220_witness` ([FourEq.lean](../lean/HamiltonsCubic/Results/FourEq.lean)), `PiQ`, `nu_sq` ([FourProd.lean](../lean/HamiltonsCubic/Results/FourProd.lean)), `sig4` ([FourSquare.lean](../lean/HamiltonsCubic/Results/FourSquare.lean)), `Wc` and its lemmas ([CP2Real.lean](../lean/HamiltonsCubic/Results/CP2Real.lean)), the record's Θₙ in [problem.md](../findings/problem.md), and the two L220 rows of [lean/INDEX.md](../lean/INDEX.md) at HEAD. Runs, all of a few minutes on objects in hand: `lake env lean` on both files (0 errors, no warnings, no `sorry`), and a scratch file `/private/tmp/r1841/Scratch.lean` with `#print axioms` on the three main theorems, `L220_eq_points` instantiated on `L220_witness` at `Fin 4`, `L220_sup_even` instantiated at `n = 12`, and the identity `√(2·11·10)/12 = √(theta0Sq 12)` (0 errors). The linear algebra of attack line C was done by hand. Log: [agent_logs/review-r1841.log](../agent_logs/review-r1841.log).

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | `diag_mem`: a unit weight gives a unit element of `SW t` with zero `V_Q` component and the same `P` | CONFIRMED |
| 2 | `P_eq_theta`: `P = θ` at a unit diagonal operator | CONFIRMED |
| 3 | `attained_even`: `θ₀(n)` attained on the unit sphere of `SW t` at even `n ≥ 4` by the balanced sphere product | CONFIRMED |
| 4 | `attained_odd`: `√(thetaOddSq n)` attained there at odd `n ≥ 5` by the `(m, m+1)` sphere product | CONFIRMED |
| 5 | `L220_sup_even`: at even `n ≥ 12`, `Θₙ` bounds `P`, is attained, and only at character `1` | CONFIRMED WITH OBSERVATIONS |
| 6 | `L220_sup_odd`: the same at odd `n ≥ 13` | CONFIRMED WITH OBSERVATIONS |
| 7 | `pair_nu`: the Gram data of `ν = aσ_A + bσ_B` | CONFIRMED |
| 8 | `L220_eq_points`: every equality point of `L220_bound` is one of the three listed rows, `u² = t²` | CONFIRMED WITH OBSERVATIONS |
| 9 | INDEX L220 rows at HEAD: `partial`, owing only the identification with `Wc` | CONFIRMED WITH OBSERVATIONS |

**Summary:** both files prove what they state with the standard three axioms, the supremum theorems carry exactly the record's `n ≥ 12` clause, the equality list is complete and its first row is the record's `ν = ±t(2,−1,−1)`, and the L220 row stays `partial` because the record names the equality points as padded W_CP² and the sufficiency of rows 2 and 3 rests on relabelling done on paper.

## 1. Attack line A: the supremum against the record

- The record: *at n ≥ 12, sup P = Θₙ on the unit sphere of 𝒮_Q, attained only on 𝒟ₙ*, and step 9's gloss *every maximiser on 𝒮_Q has ν = 0*.
- Conjunct 1 of `L220_sup_even` is `∀ W, normSq2 W = 1 → W ∈ SW {i,j,k,l} → Pcubic2 W ≤ Θ`, and conjunct 2 is `∃ W` unit in `SW {i,j,k,l}` with `Pcubic2 W = Θ`. Together they say the supremum is a maximum equal to Θ, which is the record's `sup P = Θₙ` with attainment. Conjunct 3 says every unit `W ∈ SW {i,j,k,l}` with `P(W) = Θ` has `SignChar (fun _ => 1) W`, which is "attained only on 𝒟ₙ".
- Character 1 is the same as membership in 𝒟ₙ for a Weyl operator: `trivial_block_iff` states, for `IsWeyl2 V`, `SignChar (fun _ => 1) V ↔ ∃ w, IsWeight w ∧ V = restrict (diagOp_isWeyl hw)`, which is the layer's 𝒟ₙ. Elements of `SW t` are Weyl by the carrier's first conjunct, so the hypothesis of `trivial_block_iff` is always available. It is also equivalent to the record's "ν = 0": `W = D + ν` with `W` and `D` of character 1 leaves `ν` of both characters 1 and χ_Q, and `char_split_zero_t` (BlockSub) sends it to zero.
- The attaining `W` in `diag_mem` is `restrict (diagOp_isWeyl hw)`, and its `SW t` witness is the triple `(D, ν) = (W, 0)` with `signChar_zero` for the `V_Q` part and `(add_zero _).symm` for the decomposition, so the `V_Q` component is literally `0`. Unit norm is `normSq2_restrict` applied to `hu`, and `P` is carried by `Pcubic2_restrict`. The attaining operator is unit and in `SW {i,j,k,l}`.
- The value Θ is written as the raw expression `√(2(n−1)(n−2))/n` at even `n` and `√(thetaOddSq n)` at odd `n`. These are the record's θ₀(n) and Θₙ ([problem.md](../findings/problem.md) line 170: θ₀(n)² = 2(n−1)(n−2)/n² even, Θₙ² = 2(n−1)(n−3)/((n−2)(n+1)) odd), see O1.
- The norm is the layer's operator norm throughout (bound from L57 in `normSq`, attainment from `sphere_unit` in `normSq`, carried by `normSq2_restrict`). The bound and the attainment are in the same normalisation, so the problem.md `√2` trap (tr S² = 2 versus |S| = 1) cannot separate them.

Finding: none against the claim. The three conjuncts state the record's clause exactly.

## 2. Attack line B: the attainment and its bookkeeping

- Even `n = m + m` (`Even n` unfolds to `n = m + m`): `T` with `|T| = m` from `exists_subset_card_eq`, `|Tᶜ| = n − m = m` by `card_compl`. `n ≥ 4` gives `m ≥ 2`, so both side conditions `2 ≤ |T|`, `2 ≤ |Tᶜ|` of `sphere_unit` and `theta_sphereProduct_value` hold.
- Value: `θ = thetaSplit m m = √(thetaSplitSq m m)`, `thetaSplitSq_balanced` gives `theta0Sq (2m) = 2(2m−1)(2m−2)/(2m)²`, and `Real.sqrt_div'` with `√((2m)²) = 2m` returns `√(2(n−1)(n−2))/n` at `n = 2m`. Its hypotheses `m ≠ 0`, `m − 1 ≠ 0` follow from `m ≥ 2`. I confirmed independently at `n = 12` that `√(2·11·10)/12 = √(theta0Sq 12)` in the scratch file (a screen of the rewriting, not evidence beyond the proof).
- Odd `n = 2m + 1`: `|T| = m`, `|Tᶜ| = m + 1`, `n ≥ 5` gives `m ≥ 2`, so `|T| ≥ 2` and `|Tᶜ| ≥ 3`. `thetaSplitSq_odd` gives `ThetaSqOdd (2m+1)`, and `thetaOddSq_eq` is `thetaOddSq n = ThetaSqOdd n` by `ring` (the two definitions differ only in the order of the denominator's factors). Its hypotheses `m ≠ 0`, `m + 1 ≠ 0`, `2m − 1 ≠ 0` hold at `m ≥ 2`.
- By hand: θ_{m,m}² = 2(2m−1)(m−1)²/((2m−2)m²) = (2m−1)(m−1)/m², and θ₀(2m)² = 2(2m−1)(2m−2)/(4m²) = (2m−1)(m−1)/m². Equal. θ_{m,m+1}² = 2·2m·(m−1)·m/((2m−1)m(m+1)) = 4m(m−1)/((2m−1)(m+1)), and ThetaSqOdd(2m+1) = 2·2m·(2m−2)/((2m−1)(2m+2)) = 4m(m−1)/((2m−1)(m+1)). Equal.
- `P_eq_theta`: `theta R = Pcubic R / norm R ^ 3` (the unfolding `rw [hnorm1, one_pow, div_one]` confirms the form), and `norm = √normSq = √1 = 1`.
- Independence of Q: `attained_even` and `attained_odd` take an arbitrary `t : Finset (Fin n)` and never use it except to name `SW t`, because `diag_mem` puts the sphere product in the character-1 summand, which lies in `SW t` for every `t`. This matches the record: 𝒟ₙ ⊂ 𝒮_Q for every Q, and step 9 cites the balanced product "attained in 𝒟ₙ" with no reference to Q. The index set `T` of the split is also unrelated to Q, and it need not be.

Finding: none. The bookkeeping and side conditions are right, and the threshold `n ≥ 12` enters only the bound, the attainment holding from `n ≥ 4` and `n ≥ 5` (O2).

## 3. Attack line C: the linear algebra of `L220_eq_points`

`fox_pair` (read at source) gives, at `q = Π_Q(x,y,z)`, `x+y+z = 0`, `ν = aσ_A + bσ_B`,
⟨q∘ν, σ_A⟩ = a·M_A + b·M_C, ⟨q∘ν, σ_B⟩ = a·M_C + b·M_B, with M_A = 2x+2z−4y, M_B = 2y+2z−4x, M_C = 2x+2y−4z,
and `pair_nu` gives ⟨ν,σ_A⟩ = 4a−2b, ⟨ν,σ_B⟩ = −2a+4b, ‖ν‖² = 4a²−4ab+4b², the Gram matrix G = [[4,−2],[−2,4]] (from `norm_sig` = 4 and `inner_AB` = −2). The eigen-equation 2q∘ν = θν paired with σ_A, σ_B is (2M − θG)(a,b)ᵀ = 0 with M = [[M_A, M_C],[M_C, M_B]]. With θ = 6t:

| placement (x,y,z) | M_A | M_B | M_C | 2M − θG | kernel | ‖ν‖² |
| --- | --- | --- | --- | --- | --- | --- |
| t(2,−1,−1) | 6t | −12t | 6t | [[−12t, 24t],[24t, −48t]] | a = 2b | 12b² |
| t(−1,2,−1) | −12t | 6t | 6t | [[−48t, 24t],[24t, −12t]] | b = 2a | 12a² |
| t(−1,−1,2) | 6t | 6t | −12t | [[−12t, −12t],[−12t, −12t]] | b = −a | 12a² |

- Each matrix has determinant 0 (as `step5` requires) and rank 1 at t ≠ 0, so ν is determined up to one scalar. The Lean uses only the σ_A row (`eA`): row 1 gives `t(a − 2b) = 0` from `(−1/12)·eA`, row 2 `t(b − 2a) = 0` from `(1/24)·eA`, row 3 `t(b + a) = 0` from `(−1/12)·eA`. The coefficients match my hand expansion: for row 1, 2(6ta + 6tb) − 6t(4a − 2b) = −12t(a − 2b). The σ_B row is consistent with the same kernel in all three placements (checked by hand), so discarding it loses nothing.
- `‖ν‖² = 1/2` from `L220_eq_shape`, with ‖ν‖² = 12u² in each row, forces u² = 1/24 = t², since t² = θ²/36 = 1/24 at θ² = 3/2. The Lean derives this with `nlinarith` after substituting the kernel relation.
- Row 1 against the record: `nu_sq` writes ν = a·σ_A + (−b)·σ_B for signed coordinates (a,b,c), a+b+c = 0. The record's ν = u(2,−1,−1) has (a,b,c) = (2u,−u,−u), so ν = 2uσ_A + uσ_B, which is row 1. With u = ±t this is the record's ν = ±t(2,−1,−1).
- Rows 2 and 3 as relabellings: from `PiQ`'s definition, swapping j and k gives `PiQ i k j l x y z = PiQ i j k l y x z` and exchanges `sig4 i k j l` with `sig4 i j k l`, so row 1 at the labels (i,k,j,l) is row 2. Swapping j and l gives `PiQ i l k j x y z = PiQ i j k l z y x`, and with the antisymmetry of the pair matrices and `sig_sum` (σ_A + σ_B = −σ_C) row 1 goes to ν = −uσ_A + uσ_B, which is row 3 after u ↦ −u. In signed coordinates row 2 is u(1,−2,1) = −u(−1,2,−1) and row 3 is u(1,1,−2) = −u(−1,−1,2), each ν parallel to its q's pattern, the same form as row 1. The relabelling check is by hand and uses the sign convention of `Smat` as I read it, so it is a screen for rows 2 and 3 being the same object, and the Lean holds no lemma for it (O3).
- Completeness: `L220_eq_shape` leaves exactly the three placements for (x,y,z), `four_eq_sig` puts every Weyl ν of character χ_Q in span(σ_A, σ_B), and the rank-1 kernels leave one scalar per placement. So the three rows exhaust the equality points as a necessary condition. The "exactly" of the record also needs each row to be an equality point, which `converse` gives for row 1 (both signs of u, since its hypothesis is u² = t²) and nothing in the Lean gives for rows 2 and 3 (O3).

Finding: none against the stated theorem. The list is complete as a necessary condition and row 1 is the record's.

## 4. Attack line D: vacuity

- `L220_eq_points` instantiated on `L220_witness` at `Fin 4`, labels 0,1,2,3, θ = √(3/2), with `heq` from `Real.sq_sqrt`, compiles. The hypotheses are jointly satisfiable, so the conclusion is non-vacuous.
- `L220_sup_even` instantiated at `n = 12` with `Even 12` by `decide` compiles, so its hypotheses are satisfiable at the threshold. The same holds at `n = 13` for the odd theorem by the same pattern (its hypotheses `13 ≤ n`, `¬ Even n` are satisfiable at 13, and its distinctness hypotheses at `Fin 13`). I did not compile that instance separately.
- The conclusions are not trivially true: conjunct 2 of the supremum is an existential over a nonempty set, and the equality list pins `D` and `ν` to explicit operators. Neither admits a proof by an empty disjunction or a false premise.

Finding: nothing is vacuous.

## 5. Attack line E: hypothesis inventory

| theorem | hypotheses | use |
| --- | --- | --- |
| `diag_mem` | `t`, `hw : IsWeight w`, `hu : normSq (diagOp w) = 1` | `t` names `SW t` only (any `t` works). `hw` for the Weyl property and `trivial_block_iff`. `hu` for unit norm |
| `P_eq_theta` | `hu` | the norm is 1 |
| `attained_even` | `t`, `hn : 4 ≤ n`, `heven` | `heven` gives `m`. `hn` gives `m ≥ 2` for the split's side conditions and the `≠ 0` facts |
| `attained_odd` | `t`, `hn : 5 ≤ n`, `hodd` | `hodd` gives `n = 2m+1`. `hn` gives `m ≥ 2` |
| `L220_sup_even` | six distinctness, `hn : 12 ≤ n`, `heven` | distinctness and `hn` enter conjuncts 1 and 3 through `L220_n12_even`. `heven` enters conjunct 2 only (O2) |
| `L220_sup_odd` | six distinctness, `hn : 13 ≤ n`, `hodd` | all three conjuncts use `hodd` (through `L57_odd` and `attained_odd`) |
| `pair_nu` | six distinctness, `a`, `b` | distinctness through `norm_sig` and `inner_AB` |
| `L220_eq_points` | six distinctness, `hDW`, `hD`, `hνW`, `hν`, `hν0`, `hθ`, `hQ`, `hunit`, `heq` | all passed to `L220_eq_shape`. `hD`, `hν`, `hQ` again to `L220_split`, `hνW`, `hν` to `four_eq_sig`, `hθ` for `t > 0`, `heq` for `t² = 1/24` |

- Both files compile with no unused-variable warnings, which agrees with the table.
- The record's `n ≥ 5` is absent from `L220_eq_points`, which needs only four distinct indices, so `n ≥ 4`. This is a strengthening (r1839 O3 made the same observation for `L220_bound`).

Finding: every hypothesis is used, none is stronger than the record's, and `heven`'s role is only in attainment.

## 6. Attack line F: axioms

`#print axioms` on `L220_sup_even`, `L220_sup_odd` and `L220_eq_points` returns `[propext, Classical.choice, Quot.sound]` for each. No `sorry` in either file (grep).

## 7. Attack line G: the INDEX rows and whether `Wc` is owed

- The result row (line 152) is `partial` and its owed list is one item: the identification of the listed equality points with CP2Real's padded W_CP² (`Wc`), needing the frame carrying Q to the first four indices (r1792 O6). The statement row (line 151) is `proved` as a typed statement, lists the same single owed item, and says "the list of equality points and the converse are proved". Every theorem the two rows name as PROVED or LISTED exists at HEAD with the stated content, and nothing unproved is listed as proved. The row's own account of r1840 O3 ("`converse` covers the placement (2t,−t,−t), the other two following by relabelling Q") discloses that rows 2 and 3 are equality points only on paper.
- The record's converse is literally "q = t(2,−1,−1), ν = ±t(2,−1,−1) … satisfies both equations of step 3", one placement, and `converse` proves that one completely. So "the converse is proved" is true of the record's converse.

**Is `Wc` needed for the statement?**

- *For "not needed".* The mathematical content of "equality exactly at padded W_CP² on Q" is a characterisation of the equality set, and the Lean holds the necessary half as `L220_eq_points` and the sufficient half, for the record's own placement, as `converse` with `L220_witness`. The phrase "padded W_CP²" names that set, and the downstream uses in the record (the corollary (J), the `n ≥ 12` clause) consume only the bound and the fact that equality occurs at `ν ≠ 0`, never the identity of the tensor with CP². A hand check of the spectrum also screens the identification as true: at row 1 the operator q + ν has eigenvalues 2t(2,−1,−1) on a three-dimensional space and 0 on its complement in Λ²(Q), with ‖W‖² = 24t², the spectrum of W_CP² = W⁺ with W⁻ = 0.
- *For "needed".* The record asserts an identity ("which is padded W_CP²") with a named object that the layer has typed (`Wc`, with `Wc_theta = √(3/2)`), and "exactly" is two-directional. As the Lean stands, the three rows are six explicit operators on Q, of which only row 1's two are machine-checked as equality points. Rows 2 and 3 being equality points, and all six being padded W_CP² in some frame on Q, is argued in prose and by relabelling. A row marked proved would then assert, in the layer's name, a fact about `Wc` that no declaration mentions.
- **Verdict.** I judge the identification is needed while the record's statement names W_CP², so `partial` is the right state. The mathematical gap is smaller than "identification with `Wc`" suggests, and it is two pieces: (a) rows 2 and 3 are equality points, which is `converse` at the relabelled indices plus the two `PiQ`/`sig4` relabelling identities of section 3; and (b) the six operators are conjugate to `Wc` under a frame carrying Q to the first four indices. Piece (a) is what "exactly" needs even with no reference to CP², so the owed list should name it (O3). If the programme prefers not to owe (b), the alternative is a record edit that states equality "exactly at the six operators of `L220_eq_points`, which are padded W_CP² on Q" with the identification recorded as the record's own gloss, after which (a) alone would decide `proved`.

Finding: the rows list nothing unproved as proved, `partial` is right, and the owed list omits piece (a) (O3).

## 8. Attack line H: what would break each statement, and what I did to look

- `L220_sup_even` / `L220_sup_odd`, conjunct 1: a unit element of `SW {i,j,k,l}` with P > Θₙ. By step 1 a maximiser is critical, so this would need either a diagonal operator above Θₙ (contradicting L57, `L57_even`/`L57_odd`) or a critical point with ν ≠ 0 and θ > √(3/2) (contradicting `L220_bound`), with Θₙ² > 3/2 at `n ≥ 12` even (`n(n−12)+8 > 0`) and `n ≥ 13` odd (`n(n−13)+18 > 0`). I read the call chain into `L220_n12_even`/`_odd` and the constants against problem.md line 170, and checked both inequalities by hand at the thresholds (8 > 0 and 18 > 0).
- Conjunct 2: a mismatch between the attained value and the constant, for instance an off-by-one in the split or θ₀ used at odd `n`. I recomputed both split values by hand (section 2) and checked the odd theorem uses `thetaOddSq`, never θ₀ (problem.md line 183 warns against θ₀ at odd `n`).
- Conjunct 3: an element at P = Θₙ with ν ≠ 0. It would be a critical point at θ = Θₙ > √(3/2) with ν ≠ 0, again excluded by `L220_bound`. I also confirmed that character 1 is 𝒟ₙ through `trivial_block_iff`, so the conclusion is the record's and not a weaker proxy.
- `L220_eq_points`: an equality point outside the three rows, from a fourth shape of q, an r ≠ 0, or a second ν direction in some placement. `L220_eq_shape` excludes the first two, and my hand computation of the three 2×2 systems shows each kernel is one-dimensional, which excludes the third. I instantiated the theorem on the witness to confirm it is not vacuous.

No counterexample was found. The numeric instantiations above are screens.

## Observations

- **O1.** `L220_sup_even` and `L220_sup_odd` write Θₙ as the raw expressions `√(2(n−1)(n−2))/n` and `√(thetaOddSq n)`. The layer has `Theta n = √(ThetaSq n)` in [Families.lean](../lean/HamiltonsCubic/Base/Families.lean), whose parity split is part of the definition. A corollary stated with `Theta n` at every `n ≥ 12` would carry the record's single symbol and remove the reader's matching step. Cosmetic.
- **O2.** The attainment conjunct holds from `n ≥ 4` (even) and `n ≥ 5` (odd). Only the bound and the character-1 clause need the threshold. The file documents this in `attained_even`/`attained_odd`, so it is a remark on scope, a strengthening of the record's sub-claim.
- **O3.** Rows 2 and 3 of `L220_eq_points` are proved as necessary conditions, and no declaration proves them sufficient. The INDEX discloses this through r1840 O3, and the owed list names only the `Wc` identification. The record's "equality exactly at …" needs rows 2 and 3 to be equality points independently of any CP² naming, so the owed list should name "the converse at the placements (−t,2t,−t) and (−t,−t,2t), by relabelling Q" as its own item. It is a short task: `converse` at (i,k,j,l) and (i,l,k,j) plus the `PiQ` and `sig4` relabelling identities.
- **O4.** `L220_eq_points` uses the σ_A pairing only. This is sufficient because each 2M − θG has rank 1, and the σ_B pairing gives the same kernel in each placement (section 3). The docstring's "the eigen-equation paired with σ_A and σ_B" slightly overstates what the proof uses, with no effect on the result.
- **O5.** The record's statement assumes `n ≥ 5`. `L220_eq_points` and `pair_nu` need only four distinct indices, a strengthening of the same kind as r1839 O3.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** `L220_sup_even` and `L220_sup_odd` state the record's `n ≥ 12` clause exactly (bound, attainment, attainment only on 𝒟ₙ) with standard axioms, and `L220_eq_points` gives the complete list of equality points with the record's row first. The INDEX's `partial` is right. The owed list should add the sufficiency of rows 2 and 3 as its own item (O3), and the `Wc` identification remains owed while the record names the equality points as padded W_CP².
