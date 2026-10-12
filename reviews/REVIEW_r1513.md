# Review r1513: five main rows read proved, and dim z(c) ∩ c^⊥ = 3 at m = 3 (commits 8dd2120a, a721c348, 45f72fd7)

*Gate 2, one reviewer, Lean layer. Subject: the [lean/INDEX.md](../lean/INDEX.md) main rows for L125, L157, L36, L37 and L44, moved from **partial** to **proved** on the ground that each lemma's statement row proves it, and `finrank_eq_three` in [L81Three.lean](../lean/HamiltonsCubic/Results/L81Three.lean) with the record edits around it. Analysis only: seven builds and six axiom audits were run, nothing numerical.*

| item | claim | verdict |
| --- | --- | --- |
| L125 | [L125Statement.lean](../lean/HamiltonsCubic/Results/L125Statement.lean) and `L125_weyl` in [L125Weyl.lean](../lean/HamiltonsCubic/Results/L125Weyl.lean) prove the lemma as stated | **CONFIRMED** |
| L157 | [L157Statement.lean](../lean/HamiltonsCubic/Results/L157Statement.lean) proves every clause of the boxed lemma, including the three once owed | **CONFIRMED WITH GAP** |
| L36 | [L36Statement.lean](../lean/HamiltonsCubic/Results/L36Statement.lean)'s `L36` proves the cap and its attainment at every n ≥ 3 | **CONFIRMED WITH GAP** |
| L37 | [L37Statement.lean](../lean/HamiltonsCubic/Results/L37Statement.lean)'s `diagonality_criterion` proves the biconditional and its corollary | **CONFIRMED WITH GAP** |
| L44 | [L44Statement.lean](../lean/HamiltonsCubic/Results/L44Statement.lean)'s `L44_elementary` proves the lemma as stated, so **proved** is right | **REFUTED** |
| finrank_eq_three | dim(z(c) ∩ c^⊥) = 3 at every nonzero x ∈ so(3), sound and faithful | **CONFIRMED** |

**Summary: four of the five upgrades and `finrank_eq_three` stand, but L44's elementary route proves that the conjecture's conclusion fails for 4 ≤ n ≤ 11, while the lemma as stated concludes that the cone Ω₀ is non-invariant there, which the record itself says the elementary witness does not give, so L44's main row should read partial.**

## A. Statement fidelity, lemma by lemma

### L125

- Record ([second-order.md:121](../findings/second-order.md)): at a unit maximiser W with θ > 0, for every Y ∈ 𝒲ₙ, ⟨Y, L_eY⟩ ≤ ½‖Y‖² + ½⟨W, Y⟩², proved by collapsing to L24 in both directions.
- `L125_of_L24` and `L24_of_L125` prove the equivalence at the level of a self-adjoint L with LW = W on a unit W. The binder `hcap` (L24) is the lemma's premise in the record's own proof, and it is the hypothesis of one direction only, so it assumes nothing of the conclusion.
- `L125_weyl` ([L125Weyl.lean:61](../lean/HamiltonsCubic/Results/L125Weyl.lean)) proves the display itself on the operator from `hmax` (a local maximum on the unit Weyl sphere), `hcrit` (Q(a) = λa, a consequence of the maximiser hypothesis) and θ > 0. L24 enters there through `L24_perp`, which is proved from `L24_weyl`, so the external cap is no binder on this route.
- The four-set step (`L125_fourSet`) takes L121's block value as `hblock`. That value sits under the record's *"What the form is for"*, outside the statement, so it is correctly excluded from L125's debt.
- **proved** is right.

### L157

- Record box ([second-order.md:2116](../findings/second-order.md)): the branches η and t(1-η)² cross at the unique root in (0,1), η* = (2t+1-√(4t+1))/(2t), the other root its reciprocal and spurious, min of the two maximised there, and the identity η*γ = (A/(2J))(1-η*)².
- Proved: `crossing`, `etaStar_mem_Ioo`, `min_le_etaStar` with `min_at_etaStar`, `crossing_identity`, `etaStar_mono`, `factor_floor`. Every theorem takes t > 0 as a free real, which is faithful to how the lemma uses t.
- **Gap L157-1** ([L157Statement.lean:66](../lean/HamiltonsCubic/Results/L157Statement.lean)): the docstring of `etaStar_mem_Ioo` calls it the lemma's *"the unique root in (0,1)"*, but it proves only membership. No theorem says every root of t(1-η)² = η in (0,1) equals η*. The fact is two lines from `etaStar_root` (the quadratic's roots multiply to 1), and it is untyped.
- **Gap L157-2** ([L157Statement.lean:86](../lean/HamiltonsCubic/Results/L157Statement.lean)): `other_root` proves that the expression (2t+1+√(4t+1))/(2t) equals 1/η*. It does not prove that this expression is a root of the quadratic, nor that it exceeds 1 (the *"spurious"* clause). Both follow at once from what is proved, and neither is stated.
- **Gap L157-3** ([lean/INDEX.md:502](../lean/INDEX.md)): the old owed clause was *"that η* **is** the crossing root of the reach problem"*. The Lean takes the two branches η and t(1-η)² as given and proves they cross at η*. The step from the reach self-consistency condition r ≤ √c / sup‖A''‖ to those two branches is the box's opening premise and has no Lean counterpart. The row now reads the old clause as discharged by `crossing`, which discharges only its algebraic half.
- **proved** is defensible for the boxed algebra, with the three gaps above recorded in the row.

### L36

- Record ([isotropy-cap.md:24](../findings/isotropy-cap.md)): an isotropic subspace 𝔪 ⊆ 𝔰𝔬(n) has dim 𝔪 ≤ ⌊n²/4⌋, with equality attained by the mixed planes at p = ⌈n/2⌉, every n ≥ 3.
- `L36` ([L36Statement.lean:538](../lean/HamiltonsCubic/Results/L36Statement.lean)) states exactly that, over subspaces (never subalgebras) of skew matrices, with ℕ-division as the floor. The cap is `L36Proof.cap` (line 374) from `mu_le` and `mu_ge`, attainment is `blockOff` at p = (n+1)/2 with `mixed_count`. No binder carries any part of the conclusion.
- The bridging clause (an S_𝔪𝔪𝔪 = 0 negative eigenspace at a critical W is isotropic) is untyped. The record calls it a one-line tautology under S_𝔪𝔪𝔪 = 0 and it sits outside the cap's statement, so this is no gap.
- **Gap L36-1** ([INDEX-results.md:51](../findings/INDEX-results.md)): row 36 still reads **Lean: partial** and says lean/INDEX.md records what it leaves out, while the lean/INDEX.md main row now reads **proved**. The two records disagree.
- **Gap L36-2** ([lean/INDEX.md:617](../lean/INDEX.md)): *"The cap is the statement row's `mu_le` and `mu_ge`"* names the two steps rather than the theorem. The cap is `L36Proof.cap`, with `L36` stating it.
- **proved** is right.

### L37

- Record ([target.md:636](../findings/target.md)): W is diagonal in some orthonormal frame iff some A ∈ ker Φ_W has pairwise-distinct sums, and dim ker Φ_W < n certifies non-diagonality.
- `diagonality_criterion` ([L37Statement.lean:508](../lean/HamiltonsCubic/Results/L37Statement.lean)) states both, for every endomorphism preserving the skew matrices, which covers the record's scope (every linear operator on Λ²). `kerPhi` is the commutation of δ_A with W on skew X over symmetric A, and `DistinctSums` asks for an orthogonal diagonalisation with distinct sums over i < j, which is the record's condition since every symmetric A is orthogonally diagonalisable. No binder beyond skew-preservation.
- **Gap L37-1** ([lean/INDEX.md:613](../lean/INDEX.md)): *"its corollary, an n-dimensional subspace of ker Φ_W"* misdescribes the corollary. The corollary is dim ker Φ_W < n ⇒ not diagonal, and the n-dimensional subspace `diagIn g` lies in ker Φ_W only when W is diagonal in g. Read literally the row says ker Φ_W always has dimension ≥ n, which L163 refutes (dim ker Φ_{W_CP²} = 1 at n = 4).
- **Gap L37-2** ([INDEX-results.md:52](../findings/INDEX-results.md)): row 37 still reads **Lean: partial**, the same disagreement as L36-1.
- **proved** is right.

### L44

- Record: [results.md:107](../results.md) states L44 as *"The cone is non-invariant for 4 ≤ n ≤ 11 by a witness: the dimension hypothesis is the problem's"*, and [L44Statement.lean:16](../lean/HamiltonsCubic/Results/L44Statement.lean) quotes the canonical statement ending *"So the cone is non-invariant for 4 ≤ n ≤ 11"*.
- `L44_elementary` ([L44Statement.lean:134](../lean/HamiltonsCubic/Results/L44Statement.lean)) proves something else: given a unit Weyl W with P(W) = √(3/2) (`hwitness`), there is a unit Weyl tensor with θ² above the sphere-product maximum, so the conjecture's conclusion θ ≤ Θₙ fails for 4 ≤ n ≤ 11. The proof is sound and the arithmetic (`criterion_lt_of_le_eleven`, `criterion_gt_of_twelve_le`, `roots_between_eleven_and_twelve`) is correct.
- **Gap L44-1, the refutation** ([problem.md:213](../findings/problem.md), [lean/INDEX.md:611](../lean/INDEX.md)): the record says in the paragraph that introduces the elementary route that the cone version earns its keep *"against the Ricci-flow statement that Ω₀ is non-invariant there, neither of which the elementary witness gives"*. So the elementary route proves the heading (*n ≥ 12 cannot be weakened*) and does not prove the stated conclusion (Ω₀ non-invariant for 4 ≤ n ≤ 11). The row's *"proves the conclusion by the elementary route"* is an overstatement, and the Lean file's own docstring says the step to non-invariance *"is not stated"*. The main row should read **partial**, with the cone conclusion listed as owed. The same holds for [INDEX-results.md:59](../findings/INDEX-results.md), which reads **Lean: proved**, and for STATUS.md's count, which 45f72fd7 lowered by five including L44.
- **Gap L44-2** ([lean/INDEX.md:611](../lean/INDEX.md)): the kept earlier account now says *"The padding map the record uses to carry the value to every n is replaced there by the elementary route"*. The elementary route needs the padded value at every n as much as the cone route does, and carries it in `hwitness` ([L44Statement.lean:137](../lean/HamiltonsCubic/Results/L44Statement.lean)). Nothing is replaced.
- **Gap L44-3** ([L44Statement.lean:52](../lean/HamiltonsCubic/Results/L44Statement.lean)): the docstring says θ(S⁴) = √(3/2) at every n ≥ 4 is *"imported, not proved"*. The layer proves it: [CP2Real.lean:186](../lean/HamiltonsCubic/Results/CP2Real.lean) `Wc_weyl`, [CP2Real.lean:303](../lean/HamiltonsCubic/Results/CP2Real.lean) `Wc_values` (normSq = 1) and [CP2Real.lean:329](../lean/HamiltonsCubic/Results/CP2Real.lean) `Wc_theta`, in the same `RealLayer` types L44 uses. `hwitness` is therefore dischargeable in-repo and the elementary route could be stated unconditionally. The binder is sound, and the stale docstring misreports the layer.
- `hub` is unused (`have _ := hub`), attainment `hatt` being what the argument needs. That is harmless.

## B. finrank_eq_three

- Statement ([L81Three.lean:52](../lean/HamiltonsCubic/Results/L81Three.lean)): for skew nonzero x on ℝ³, `finrank ℝ (zPerp x) = 3`. `zPerp` ([L81Statement.lean:150](../lean/HamiltonsCubic/Results/L81Statement.lean)) is the skew u commuting with and orthogonal to every element of `cc x`, and `cc x` (line 129) is 𝔷(x) ∩ x^⊥, the record's 𝔠. Faithful.
- Proof: `cc_three` ([L160.lean:127](../lean/HamiltonsCubic/Results/L160.lean)) gives 𝔠 = 0, so every skew y is in `zPerp x`. Upper bound: the map to the three coordinates (1,0), (2,0), (2,1) is injective on skew matrices, since skewness fixes the diagonal at 0 and the upper triangle by the lower. Lower bound: E3 0 1, E3 0 2, E3 1 2 are independent, read off at those coordinates. Sound.
- `lake build` of all seven modules completed successfully, with only linter warnings (unused simp args in L37Statement, `show` style in L125Weyl). No `sorry` and no errors.
- `axiom_audit.py --only L81Three`: 3/3 clean on the standard three. Also L125 (3 files) 12/12, L157Statement 12/12, L36Statement 21/21, L37Statement 20/20, L44Statement 7/7, all on the standard three alone.
- The docstring edits in [L81Statement.lean](../lean/HamiltonsCubic/Results/L81Statement.lean) now point to `cc_three` and `finrank_eq_three`, which closes r1512's C-1. The L81 row ([lean/INDEX.md:413](../lean/INDEX.md)) states the value 3, which closes r1512's A-1 and C-2.

## C. Row text

- L125 ([lean/INDEX.md:463](../lean/INDEX.md)): no overstatement, no contradiction with the kept account. The reframing of the old owed clause as L121's debt matches [second-order.md:128](../findings/second-order.md).
- L157 ([lean/INDEX.md:502](../lean/INDEX.md)): *"every clause of the boxed lemma"* overstates by L157-1 and L157-2, and *"make η* the crossing root"* overstates by L157-3.
- L36 ([lean/INDEX.md:617](../lean/INDEX.md)): L36-2. No contradiction with the kept account.
- L37 ([lean/INDEX.md:613](../lean/INDEX.md)): L37-1.
- L44 ([lean/INDEX.md:611](../lean/INDEX.md)): L44-1 and L44-2. The cone conclusion is still owed and is no longer listed as owed anywhere in the row.
- Cross-record: L36-1 and L37-2 (INDEX-results rows still partial). L44-1 applies to INDEX-results row 44 and to STATUS.md.

## D. Style

- No em dashes in the six changed rows, and none in the added Lean docstrings. No backticks inside markdown link text. The rows are single lines.
- **Gap D-1** ([lean/INDEX.md:463](../lean/INDEX.md)): *"…on W^⊥; and `L125_fourSet`…"* and *"…is √Σ/(2θ); standard three axioms."* splice clauses with semicolons, in the kept account of a row this commit rewrote.
- **Gap D-2** ([lean/INDEX.md:613](../lean/INDEX.md)): *"…act on `Λ²`; `δ` is additive…"* and *"…the corollary counts; and **the distinctness…"* do the same in L37's kept account.
