# Review r1660: L54's (2) in subset-sum form (commit 4fe580af) and r1659's repairs (commit 437c2f64)

**Verdict: CONFIRMED WITH GAPS.** [L54Converse.lean](../lean/HamiltonsCubic/Results/L54Converse.lean) proves the converse half of Hardy–Littlewood–Pólya correctly, carries it across two index types correctly, and applies it to the same ω and d as [L54_majorizes_S20](../lean/HamiltonsCubic/Results/L54Diag.lean#L130), so the record's ω ≻ d on S²₀ now stands as L54Statement's `Majorizes`, in the right direction. That discharges r1567's owed item in full, index transport included. The axiom audit of all ten L54 files is 86/86 on the standard three. **proved** is the right state for the L54 row. The gaps are stale text left by the downstream sweep: L54Diag's header still lists the passage as not typed, and L54Schur's header still lists ω ≻ d as not typed. Commit 437c2f64 repairs r1659's G1 to G3, and the L250 row is untouched.

| # | claim | verdict |
| --- | --- | --- |
| 1 | `majorizes_of_convex`: convex inequality on one type gives `Majorizes x y` | **CONFIRMED** |
| 2 | `majorizes_of_convex'`: card equality from ±1, and the reindexing | **CONFIRMED** |
| 3a | `L54_majorizes_S20_sub` is ω ≻ d on S²₀, right direction, same objects as `L54_majorizes_S20` | **CONFIRMED** |
| 3b | the existential e is an honest rendering of "ω and d on one type" | **CONFIRMED** (permutation invariance checked by hand, stated nowhere in Lean) |
| 4 | L54 is fully proved, row state **proved** | **CONFIRMED WITH GAPS** (G1, G2 stale headers, G3 a one-step reading unnamed) |
| 5 | 437c2f64 repairs r1659 G1 to G3, L250 tag unchanged | **CONFIRMED** |
| 6 | axiom audit | **CONFIRMED** (L54Converse 3/3, all L54 files 86/86) |

**Summary:** ω ≻ d on S²₀ is proved in the record's subset-sum form and L54 is proved, with two stale "not typed" headers left behind.

## 1. `majorizes_of_convex` ([L54Converse.lean:31](../lean/HamiltonsCubic/Results/L54Converse.lean#L31))

- **Definition read.** [Majorizes](../lean/HamiltonsCubic/Results/L54Statement.lean#L63) x y is Σx = Σy and, for every S, some T with |T| = |S| and Σ_S y ≤ Σ_T x. So x is the majoriser.
- **Equal sums.** g = id gives Σy ≤ Σx and g = −id gives −Σy ≤ −Σx. Both are convex on ℝ. Correct.
- **Choice of T and c.** T is a top-|S| set of x from SchurMajor's `exists_top_set` (x_j ≤ x_i for i ∈ T, j ∉ T), and c = min_T x. Then g(t) = max(t − c, 0) is convex (affine sup constant), g(x_i) = x_i − c on T since x_i ≥ c, and g(x_j) = 0 off T since x_j ≤ x_{i0} = c.
- **Chain.** Σ_S y ≤ Σ_S (c + g(y)) = |S|c + Σ_S g(y) ≤ |S|c + Σ g(y) ≤ |S|c + Σ g(x) = |S|c + Σ_T x − |T|c = Σ_T x, using g ≥ 0 for the middle step and |T| = |S| at the end. Checked by hand.
- **Empty case.** T empty forces S empty through |T| = |S|, and both sums are 0.
- **Breakers tried.** Ties at c outside T (g still 0 there), entries of y below c (g(y) = 0 and y ≤ c), negative entries, N empty. None breaks a step.

## 2. `majorizes_of_convex'` ([L54Converse.lean:70](../lean/HamiltonsCubic/Results/L54Converse.lean#L70))

- Constant functions are convex, so g ≡ 1 gives |M| ≤ |N| and g ≡ −1 gives −|M| ≤ −|N|. Equal cardinalities follow, and `Fintype.equivOfCardEq` supplies e. Legitimate: this is the size information the convex family genuinely carries.
- Reindexing: Σ_i g(y(e⁻¹ i)) = Σ_j g(y j) by `Equiv.sum_comp`, so the hypothesis transfers to y ∘ e.symm on N. Correct.
- **Breaker tried.** Types of different sizes: the ±1 constants exclude them, so the ∃ is never vacuous by a size mismatch.

## 3. `L54_majorizes_S20_sub` ([L54Converse.lean:96](../lean/HamiltonsCubic/Results/L54Converse.lean#L96))

- **Direction.** `Majorizes ω (d ∘ e.symm)` has ω as majoriser, the record's ω ≻ d ([bispectral.md](../findings/bispectral.md), Lemma L54 (2)).
- **Objects.** The `let` block is verbatim that of `L54_majorizes_S20`, and the proof obtains `hWW`, `hWK` and the convex inequality from that theorem and feeds the same two functions to `majorizes_of_convex'`. d is `Bw` on the pairs (d_φ) summed with −eigenvalues of K on 𝟏^⊥ (d_ψ), ω the eigenvalues of W̊ on (ℝ∙gCoord w)^⊥ = S²₀, as r1567 established.
- **The existential e.** For σ a permutation of N, Majorizes x (y ∘ σ) and Majorizes x y are equivalent: sums are invariant, and S ↦ σ(S) is a cardinality-preserving bijection on subsets with Σ_S (y ∘ σ) = Σ_{σ(S)} y. Since any two e, e' differ by the permutation e ∘ e'.symm of N, the conclusion for one e gives it for every e. So the ∃ loses nothing and is an honest rendering of "ω and d on one type". *The invariance is a hand argument with no declaration. A `∀ e` form is provable by the same proof, since `majorizes_of_convex` applies to any e once the card equality holds. Optional.*

## 4. Is L54 fully proved?

- **The record's parts** ([bispectral.md](../findings/bispectral.md), Lemma L54): (1) d_φ = K for M and the φ-block, the ψ-block diagonal with d_ψ = −spec(K on 𝟏^⊥), Σd_φ² = t_F/2, Σd² = 3t_F/2; (2) μ ≻ d_φ and ω ≻ d; (3) t_F ≤ 2 with its equality case; (4) at t_F = 2 the two multiset equalities.
- **Coverage.** (1): `phi_block_diag`, `M_diag`, `psi_block` (any orthonormal eigenfamily, so the record's family on 𝟏^⊥ is an instance), `dpsi_split`, `sum_dphi_sq`, `sum_d_sq`. (2): `L54_mu_majorizes` and now `L54_majorizes_S20_sub`. (3): `tF_le`, `tF_eq_iff`. (4): `L54_rigidity` and `L54_rigidity_S20`.
- **G3 (minor).** Σd² = 3t_F/2 is declared on S² (`sum_d_sq`, Mathlib's eigenbasis of K on ℝⁿ) and the record states it on S²₀. At Ricci-flat R the two differ by one zero entry, by `dpsi_split`, so the S²₀ form is one step. No declaration states it and the row does not name the step as a reading.
- **Audit.** `axiom_audit.py --only L54` (a screen over the ten L54 files, L54Converse included): 86/86 on the standard three, matching the per-file theorem counts 9 + 12 + 3 + 6 + 13 + 12 + 10 + 3 + 8 + 10. No `sorry`, `admit` or `native_decide` in any L54 file.
- **State.** Every part has a declaration, so **proved** is right, with G3 as a naming gap, not an owed item.

## 5. Commit 437c2f64 against r1659

- **G1 repaired.** The row's L127WTop passage reads "(their filling the cut is [L127Fill.lean]'s `within_fill`)", and [L127WTop.lean:19-21](../lean/HamiltonsCubic/Results/L127WTop.lean#L19) now cites `within_fill`.
- **G2 repaired.** The tag reads "statement: typed in its eigenspace rows, the agreement's operator half owed", which names what is typed in the index's vocabulary.
- **G3 repaired.** The row now says the join of the fills with the `_mem` characterisations is prose (distinct eigenvalues) with no declaration, and that the fills are coefficient-level.
- **L250.** The commit's INDEX.md diff touches only the L127 row. The L250 row ([lean/INDEX.md:217](../lean/INDEX.md#L217)) still reads "statement: typed in its arithmetic", unchanged.

## 6. Gaps

- **G1, [L54Diag.lean:26-28](../lean/HamiltonsCubic/Results/L54Diag.lean#L26).** The header still reads "*Not typed*: the passage from that convex form to the subset-sum `Majorizes`", now typed in L54Converse. Replace with a pointer to `L54_majorizes_S20_sub`.
- **G2, [L54Schur.lean:17-18](../lean/HamiltonsCubic/Results/L54Schur.lean#L17).** The header still reads "**Not typed**: the second half ω ≻ d". It is typed on S² in L54Rigid and on S²₀ in L54Converse. Pre-existing, now contradicted by a **proved** row.
- **G3, [lean/INDEX.md:287](../lean/INDEX.md#L287).** Σd² = 3t_F/2 on S²₀ is `sum_d_sq` on S² plus `dpsi_split`'s zero entry, a step the row leaves unnamed.

## 7. What was run

- `axiom_audit.py --only L54`, one run, backgrounded after `pgrep` found no lake process. A screen: it confirms axioms, and every mathematical claim above was checked by hand.
