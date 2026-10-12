# Review r1509: L178 at n = 4 for real Weyl operators, the rational-to-real transfer

Gate 2 review of commit fbb09a40: the new [Results/L178Real.lean](../lean/HamiltonsCubic/Results/L178Real.lean) (Sharp.lean's n = 4 model over ℝ on WeylReal.lean's `phi`, `br`, `inner2`, then the chain of L178Sharp.lean, L178Theta.lean, L178N4.lean and L178Eq.lean read over ℝ), the edits to [lean/INDEX.md](../lean/INDEX.md)'s L178 row (line 70), and [diagonal-half.md](../findings/diagonal-half.md) Lemma L178 step 5 (line 613) and Lemma L194's header (line 1017, the repair of [r1508](REVIEW_r1508.md)'s E-1). One reviewer. Analysis-only rule inherited: the only compute was the module build ("Build completed successfully", 8728 jobs, exit 0) and the axiom audit.

| item | claim | verdict |
| --- | --- | --- |
| A | the real definitions are Sharp.lean's verbatim with ℚ → ℝ, on the same `phi`, `br`, `inner2`, with the same anchor, and `L178_n4`, `L178_n4_eq`, `L178_n4_attained` state the record's L178 at V = ℝ⁴ for real W | CONFIRMED |
| B | no statement weakened against its rational twin, the cast steps of L178Eq.lean trivial over ℝ, the module builds | CONFIRMED |
| C | no edited sentence overstates, r1508's E-1 repaired | CONFIRMED WITH GAP |
| D | all declarations rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED WITH GAP |

**Summary: L178Real.lean's twelve model definitions and its anchor are Sharp.lean's lines 41 to 110 character for character after ℚ → ℝ (one comment word aside), WeylReal.lean's `phi`, `br`, `inner2` are Bivectors.lean's with ℚ → ℝ, and all 39 theorem and definition statements shared with the four rational files match their twins verbatim after the same substitution, so `L178_n4` is $P(R)^2\le\tfrac32\lVert R\rVert^6$ for every real `IsWeyl` $R$ on $\Lambda^2\mathbb R^4$ of rank at most three, `L178_n4_eq` the spectral equality clause and `L178_n4_attained` its converse. 32/32 declarations on the standard three axioms, r1500's C-1 transfer is discharged, r1508's E-1 is repaired. Gaps: C-1, the anchor's docstring (lines 67 to 71) is the rational one with ℚ → ℝ substituted and now states a false history and a false mechanism; E-1, a copied comment (line 63) splices two clauses with a semicolon. CONFIRMED WITH GAP.**

## A. Fidelity

- **Definitions.** Sharp.lean lines 40 to 110 with every ℚ replaced by ℝ, diffed against L178Real.lean lines 34 to 110: the only difference is the comment above `sharpQF_one_basis` ("literal rational arithmetic" became "literal arithmetic"). `basis4`, `pair4`, `coord4`, `toMat4`, `sharpQF`, `sharpMat`, `Qop`, `Pcubic`, `IsBianchi`, `Ric`, `IsRicciFlat`, `IsWeyl` are the rational ones verbatim. **Faithful.**
- **The base operations.** [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) lines 39, 42, 45: `inner2 X Y = (1/2) * (Xᵀ * Y).trace`, `br X Y = X * Y - Y * X`, `phi i j = single j i 1 - single i j 1`, the shapes of [Bivectors.lean](../lean/HamiltonsCubic/Base/Bivectors.lean)'s rational `inner2`, `br`, `phi` exactly, the ½ at the Λ² level in both. The real model is therefore the rational model's object over ℝ, with the rational one its restriction to rational coordinates.
- **The anchor.** `sharpQF_one_basis` (line 72) states `sharpQF 1 (Pi.single a 1) = 2` for every `a`, the same statement as Sharp.lean's, so `Id# = (n-2) Id` at n = 4 pins the same normalisation of `#`. It is reproved over ℝ by the same `fin_cases`, `simp only`, `norm_num` script, not imported.
- **𝒲₄.** `IsWeyl` is symmetry in the basis `basis4`, which is orthonormal under `inner2` (`inner2_phi_self` and orthogonality of distinct pairs, the same fact over ℝ), the single first Bianchi equation at n = 4, and Ricci-flatness through `Ric` built from `inner2` and `phi`. That is the record's $\mathcal W_4$ in the fixed orthonormal basis $\{\varphi_{ij}\}_{i<j}$, as [r1500](REVIEW_r1500.md) found for the rational twin, now with real entries. `Matrix.rank` is taken over ℝ, which is the record's rank of $W:\Lambda^2\to\Lambda^2$.
- **The inequality.** `L178_n4` (line 438): `IsWeyl R`, `R.rank ≤ 3` give `Pcubic R ^ 2 ≤ (3/2) * ((Rᵀ * R).trace) ^ 3`, the sign-closed homogeneous form of $\lvert\theta\rvert\le\sqrt{3/2}$, the record's Lemma L178 at V = ℝ⁴ for every real W. The scale argument of r1500 (both sides homogeneous of degree six, $R=0$ trivial) carries over unchanged.
- **The equality clause, both directions.** `L178_n4_eq` (line 547): at `Pcubic R ^ 2 = (3/2)‖R‖⁶` with `Pcubic R > 0` (that is $\theta=+\sqrt{3/2}$), R is a trace-free block on Λ⁺ or Λ⁻ whose normalised block has eigenvalues $2/\sqrt6$ once and $-1/\sqrt6$ otherwise. `L178_n4_attained` (line 577): $R^+(\operatorname{diag}(2,-1,-1))$ is Weyl, of rank at most three, with $P>0$ and equality. Together they are the record's step 5 equality clause in spectral form. The record's equality is at $\theta=+\sqrt{3/2}$, and the $P<0$ branch is not part of it.
- **What remains owed.** The padding from $\Lambda^2V$ to $\Lambda^2\mathbb R^n$ (step 3) and the rigidity up to an $O(n)$ frame change, as lean/INDEX.md line 70 now lists. **Note, no gap:** the real carrier `Matrix (Fin 6) (Fin 6) ℝ` in `basis4` coordinates is a third n = 4 model beside [L178Split.lean](../lean/HamiltonsCubic/Results/L178Split.lean)'s bivector model and WeylReal.lean's operator-valued `IsWeyl` (line 126). Nothing bridges L178Real's `IsWeyl` to WeylReal's. The padding item is where that bridge would be needed, so the owed list covers it implicitly.
- **CONFIRMED.**

## B. Soundness

- **Statements against their twins.** Every `theorem` and `def` head of L178Sharp.lean, L178Theta.lean, L178N4.lean and L178Eq.lean (39 declarations), whitespace-normalised and with ℚ → ℝ, compared with L178Real.lean's same-named declaration: all 39 are present and identical. No hypothesis was added, no conclusion weakened. `disc_nonneg` was already stated over ℝ in L178Theta.lean and is unchanged.
- **The cast steps of L178Eq.lean.** The rational `blockR` takes ℚ entries into a real matrix, and `blockR_trace_sq`, `blockR_trace_cube` and the `M` of `L178_eq_block` and `L178_n4_eq` carry `((… : ℚ) : ℝ)` coercions. Over ℝ they read `((… : ℝ) : ℝ)`, a type ascription with no coercion inserted, so the statements say the same thing about the same numbers. Inside `L178_eq_block` the `exact_mod_cast`, `push_cast` and `congrArg (fun q : ℝ => (q : ℝ))` steps (lines 489, 498, 499, 516) become identity moves, which the build accepts. The meaning is unchanged.
- **The proofs.** The scripts are the rational ones read over ℝ. Each step is ordered-field arithmetic (`norm_num`, `ring`, `linarith`, `nlinarith`, `field_simp`), rank through `LinearIndependent` over ℝ in `rank4`, and the spectral step through [L225Matrix.lean](../lean/HamiltonsCubic/Results/L225Matrix.lean)'s `matrix_cube_eq`, which was already real. Nothing in them depends on ℚ.
- **Build.** `lake build HamiltonsCubic.Results.L178Real`: "Build completed successfully (8728 jobs)", exit 0, no error and no `sorry` from the module.
- **CONFIRMED.**

## C. Record accuracy

- **lean/INDEX.md line 70.** "The transfer to real $W$ is PROVED in L178Real.lean: Sharp.lean's $n=4$ definitions carried verbatim over $\mathbb R$ …, with the same anchor …, and the whole chain reproved there". Accurate, per A and B. The owed list now names the padding and the rigidity, the right two. The earlier sentences keep "for rational $W$", which stays true of L178N4.lean and L178Eq.lean. **Accurate.**
- **diagonal-half.md line 613.** "The inequality of steps 1 to 5 is kernel-checked at $V=\mathbb R^4$ for real $W$ as `L178_n4` in L178Real.lean, and for the layer's rational $n=4$ model …". Accurate. The equality case is still cited only at the rational L178Eq.lean, which understates rather than overstates, since `L178_n4_eq` is also in L178Real.lean. **Accurate.**
- **r1508's E-1.** diagonal-half.md line 1017 now reads "… no curvature in it. **The identity is machine-checked at every $n$** …", the full stop r1508 asked for. **Repaired.**
- **GAP C-1.** [L178Real.lean](../lean/HamiltonsCubic/Results/L178Real.lean) lines 67 to 71, the docstring of `sharpQF_one_basis`: "**PROVED IN THE KERNEL, WHERE THIS WAS `native_decide` UNTIL 2026-09-20.** *`decide` walls on `ℝ` because `Rat.normalize` is what the kernel will not unfold cheaply …*". This is Sharp.lean's docstring with ℚ → ℝ substituted. The real theorem was never `native_decide` (the file is new in this commit), and `Rat.normalize` is the reason `decide` walls on ℚ, not on ℝ, where equality is not decidable at all. The docstring states a false history and a false mechanism for this declaration. The repair is a docstring saying the real anchor is reproved by Sharp.lean's `norm_num` script.
- **CONFIRMED WITH GAP.**

## D. Axioms

- `python3 scripts/misc/axiom_audit.py --only L178Real`: "auditing 32 declarations across 1 files, 32/32 clean -- resting on the standard three alone". The file has 32 `theorem` declarations, so every one is audited. **CONFIRMED.**

## E. Style

- **Em dashes.** None in L178Real.lean, in diagonal-half.md lines 613 and 1017, in lean/INDEX.md line 70, or on any added line of the commit.
- **Backticks in link text, hard wraps.** None in the edited markdown lines. Each edited paragraph and table row is one line.
- **Semicolons.** The INDEX row's "…; standard three axioms" endings follow the row's established pattern, a fragment rather than a spliced clause. The module docstring's list items end in semicolons as list separators.
- **GAP E-1.** [L178Real.lean](../lean/HamiltonsCubic/Results/L178Real.lean) line 63, the comment above `sharpQF_one_basis`: "-- into literal arithmetic; the default limit is reached on branch three." Two independent clauses spliced by a semicolon, copied from Sharp.lean. The repair is a full stop.
- **CONFIRMED WITH GAP.**

## Overall

**CONFIRMED WITH GAP.** L178Real.lean is Sharp.lean's n = 4 model and the four rational L178 files carried verbatim to ℝ on WeylReal.lean's `phi`, `br`, `inner2`, which have Bivectors.lean's shapes, with the anchor `Id# = 2 Id` reproved. `L178_n4` kernel-checks Lemma L178's inequality at V = ℝ⁴ for every real Weyl operator of rank at most three, and `L178_n4_eq` with `L178_n4_attained` the spectral equality clause in both directions. 32/32 declarations on the standard three axioms, r1500's C-1 transfer is discharged, and r1508's E-1 is repaired. Gaps: C-1, the anchor docstring at L178Real.lean lines 67 to 71 carries the rational file's `native_decide` history and `Rat.normalize` mechanism with ℚ → ℝ substituted, both false here; E-1, a clause-splicing semicolon in the comment at L178Real.lean line 63.
