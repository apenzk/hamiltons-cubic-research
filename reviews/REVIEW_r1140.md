# Review r1140: Lean for L240 piece (b), steps 7, 8a and 8b

Brief: [2026-09-25-L240b-steps7-8-gate2-brief.md](2026-09-25-L240b-steps7-8-gate2-brief.md). Log: agent_logs/r1140.log. File under review: [L240SlotBasis.lean](../lean/HamiltonsCubic/Results/L240SlotBasis.lean). Build: `lake build HamiltonsCubic.Results.L240SlotBasis`, exit 0, no errors, no `sorry`.

## Item 1: declarations against claims. CONFIRMED

Step 7 (checked by hand against `inner2_phi_phi`, which gives the inner product of two basis bivectors as the ordered-pair delta minus the swapped-pair delta):

- `cartan_pair` (c arbitrary, x in block a, y in block b, a < b): `{p_c, q_c} = {x, y}` would put x and y in block c, forcing a = b. Correct. Covers every cross-block bivector, hence all four pair slots S1 to S4.
- `cartan_cartan` (c ≠ d): p_c = p_d contradicts injectivity, p_c = q_d contradicts `hpq`. Correct.
- `kernel_blk` (w free, x' and y' in blocks a, b, with a = b allowed): w differs from every block index. Covers kernel against pair bivectors and, with a = b = d, against Cartan slots. The block hypothesis on x is unused (`_hx`), so the statement is slightly more general than claimed.
- `kernel_kernel` (hne: not (x = x' and w = w')): the swapped match x = w' is excluded by `free_ne_blk`. Correct on every pair of distinct kernel slots.
- `free_blk` (w, w' free, x in a block, y arbitrary): covers free-free against Cartan, pair and kernel slots. Free-free against free-free on different pairs is `phi_orth` (step 6) directly.
- All hypotheses are satisfiable (any normal form with k ≥ 2 and a free index), so nothing is vacuous.
- Note: step 7 is stated at the level of basis bivectors. Orthogonality to the slot combinations S1 to S4 follows by bilinearity (`i2_addR`, `i2_subR`) and is not packaged as its own lemma, as `cross_comb` does for step 6. The consumer of step 7 will need that one-line extension.

Step 8a: S1 = φ_pp − φ_qq, S3 = φ_pp + φ_qq, S2 = φ_pq + φ_qp, S4 = φ_pq − φ_qp. Then (S1+S3)/2 = φ_pp, (S3−S1)/2 = φ_qq, (S2+S4)/2 = φ_pq, (S2−S4)/2 = φ_qp. The four Lean statements match exactly. They hold identically without a ≠ b, and the Lean statements carry no such hypothesis, which is right. The defs S1 to S4 sit in a section with `include hab`, and the step-8a statements apply them without `hab`. The build accepts this, so the defs do not take `hab` as an argument.

Step 8b, `transfer_expansion`: re-derived by hand.

- b_k ∈ S gives b_k = Σ_l R_kl φ_l with R_kl = B(φ_l, b_k).
- Linearity of B in its first argument gives δ_kk' = B(b_k, b_k') = Σ_l R_kl R_k'l, so R Rᵀ = 1.
- κ is finite and ℝ is a field, so `mul_eq_one_comm` gives Rᵀ R = 1.
- For y ∈ S, Σ_k B(b_k, y) b_k = Σ_m Σ_l (Rᵀ R)_ml B(φ_l, y) φ_m = Σ_m B(φ_m, y) φ_m = y.
- No hypothesis is missing: symmetry of B, orthonormality of φ, S being a subspace and φ_k ∈ S are all unnecessary, and the Lean asks for none of them.
- Not vacuous: φ = b, an orthonormal basis of a finite-dimensional inner product space with S the whole space, satisfies every hypothesis.
- Not trivially weaker than intended: the conclusion is the full expansion for every y ∈ S. For the intended use (φ the basis bivectors indexed by i < j, S the skew matrices, b the normalised slots), the hypotheses reduce to orthonormality of b (steps 5 to 7) and a bijection of the slot family onto the φ index set. Both are recorded as still owed in the INDEX row.

## Item 2: axiom audit. CONFIRMED

`python3 scripts/misc/axiom_audit.py --only L240SlotBasis`, run after the background build: "auditing 37 declarations across 1 files. 37/37 clean, resting on the standard three alone" (propext, Classical.choice, Quot.sound), exit 0. No sorryAx and no native_decide axioms.

## Item 3: docstring and lean/INDEX.md row. CONFIRMED, with one stale sentence to correct

- Nothing in either text claims more than the declarations deliver.
- Stale text: module docstring lines 11 and 12 say "orthogonality of the kernel and Cartan slots against the rest, and completeness, which `kyFan_eigen` needs, are not yet here". Step 7 (line 22 of the same docstring, and the declarations at lines 365 to 416) now supplies the orthogonality. Correction: "Orthogonality of all slot types is here (steps 5 to 7); completeness, which `kyFan_eigen` needs, is not yet here."
- Understatement: docstring line 24 describes step 8b as "an orthonormal family inside a subspace that an orthonormal family on the same index set expands". The theorem asks only that φ expand S, a predicate. The theorem's own docstring and the INDEX row ("any family") state it correctly. Optional correction: "an orthonormal family inside a set that any family on the same index set expands".
- INDEX row, "every slot type orthogonal to the others": true at the basis-bivector level. Extending it to the slot combinations is the bilinearity step noted under item 1.
