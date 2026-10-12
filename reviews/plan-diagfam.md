# plan-diagfam, the exact diagonal families and the boundary between the halves

Planner report, 2026-09-02. Analysis-only footing; every screen below is seconds of compute on a constructed object and is reported as a screen. Scripts: [screen_diagfam.py](../scripts/reviewers/plan-2026-09-02/screen_diagfam.py) in this scratchpad (uses [adversarial_check1.py](../scripts/lib/adversarial_check1.py)'s validated `Q_full`, `B_full`). Nothing was written into findings/, results.md, plan.md, routes.md or ATTEMPTS.md.

**Where the region stands, in one line.** The diagonal half is a theorem at every n (Lemma L57, both parities), so the exact families (Lemma L74 SRGs, DGK Ex 6.4/7.5/7.6, blow-ups, unbalanced products) can no longer move the diagonal maximum; their remaining value is as the only critical points at which the full second variation and every off-locus candidate inequality can be evaluated in closed form, and the boundary between the halves is a symmetry-breaking locus that one finite-group block decomposition makes explicit.

## The four questions of the brief, answered

| question | answer | where |
|---|---|---|
| (i) what the multi-valued families say about the ≥3-eigenvalue regime | on the locus that regime is closed by Lemma L57; off the locus the families are exact evaluation points, and the useful reading is of I24's interior row at the unbalanced products, by hand | I29 |
| (ii) harmonic-square law: fourth relation or consequence | a consequence of (C) alone plus quadratic homogeneity and block additivity of Q; it is a closure property of the critical set under ⊕, carries no information at a single point, and is on record as Lemma L99 (diagonal) and post F35 / Lemma L66 (off locus). r331's completeness of (A)(B)(C) stands. Dropped as an item | record screen below |
| (iii) which of Lemma L57's three steps survives off the locus | steps 2 and 3 survive verbatim in every frame; step 1 survives as an exact identity whose single defect term is ε_F, and ε_F/μ_F = θ/2 at padded CP², order one, so no small-defect argument closes it | I11 |
| (iv) θ_0 versus the max over the closure of the diagonal locus under SO(n) | the SO(n)-saturation of the locus is already compact, so the closure is itself and its maximum is Θ_n at the balanced product's orbit; the boundary between the halves is the set of diagonal points with a degenerate sign-flip block | I21, I14 |

## Section 1, advance

### I14. The second variation at every diagonal critical point, block-diagonalised by the sign-flip group

**Theorem it would produce.** We would be able to state that at every diagonal critical point M the operator L_e (hence the Hessian of P on the sphere, Lemma L24) is block-diagonal over the characters of the sign-flip group Γ = {diag(±1)} ∩ SO(n), with one block of dimension n(n−3)/2 (the diagonal locus, the record's 𝓛/θ), C(n,4) blocks of dimension 2 indexed by 4-subsets {i,j,k,l}, and C(n,2) blocks of dimension n−3 indexed by pairs {j,k}, each given by an explicit small matrix in the entries of M and θ; and hence that a diagonal critical point is a local maximum of P on W_n iff every block is ≤ ½ off the orbit directions, and that a non-diagonal critical point can branch off M only where a Γ-nontrivial block has eigenvalue exactly ½ beyond the orbit direction.

**Route.**
1. (one hour) Γ acts on Λ² by ε_iε_j on e_i∧e_j; its fixed set in W_n is exactly the diagonal locus D_n ([diagonal-half.md](../findings/diagonal-half.md) line 80, the symmetric-criticality "if" direction). Decompose Sym²(Λ²) by character: trivial (the diagonal entries, C(n,2)), ε_iε_jε_kε_l for four distinct indices (three elements e_ij⊙e_kl, e_ik⊙e_jl, e_il⊙e_jk), ε_jε_k (the n−2 elements e_ij⊙e_ik, i ≠ j,k). Impose Bianchi (signed: α − β + γ = 0 on each 4-set, one relation) and Ricci (signed: Σ_i σ_i x_i = 0 on each pair, one relation). Verify the count n(n−3)/2 + 2C(n,4) + (n−3)C(n,2) = n(n−3)(n+1)(n+2)/12 = dim W_n. *Screened: character multiplicities in Sym²(Λ²) at n=6 are 15×3, 15×4, 1×15 as predicted.*
2. L_e = e∘(·) with e = M/θ is Γ-equivariant because ∘ is O(n)-equivariant ([conventions.md](../findings/conventions.md) line 66) and e is Γ-fixed; so L_e preserves each character space. *Screened at S³×S³: leak of L_e X outside X's character block 9×10⁻¹⁶.* Domain: every diagonal critical point with θ > 0 (Lemma L24's hypothesis; the θ < 0 branch reverses the criterion).
3. Derive the 4-set block: for X = α e_ij⊙e_kl + β e_ik⊙e_jl + γ e_il⊙e_jk, compute WX + XW (entrywise (M_ij + M_kl)α etc.) and W#X via the structure constants c_{(ij)(ik)(jk)}, only the six edges of the 4-set enter. Restrict to α − β + γ = 0. Target closed form to match: at S^p×S^q the block with two indices in each factor has top eigenvalue ½(1/(p−1) + 1/(q−1)) and the blocks with all four (or three) indices in one factor vanish on the Bianchi plane. *Screened: 0.5, 1/3, 3/8, 1/4 at (3,3), (4,4), (3,5), (5,5); zeros at pppp and pqqq.* The closed form is a fit to four points and is the executor's first check.
4. Derive the pair block {j,k}: X = Σ_i x_i e_ji⊙e_ki with the signed Ricci relation; WX + XW gives (M_ji + M_ki)x_i and W#X couples x_i to x_m through M_jm, M_km. Prove the orbit direction x_i = σ_i(M_ji − M_ki) is an eigenvector with eigenvalue ½ (it is the tangent to the SO(n)-orbit in the (j,k) rotation, so this is forced and fixes normalisation). Target: at S^p×S^q the within-factor pair block has top eigenvalue (p−2)/(2(p−1)) and the cross pair block is ½ on the orbit direction and 0 elsewhere. *Screened at the four products above; the orbit Rayleigh quotient is 0.5000 at each.*
5. Recover the record's nondegeneracy gap 1/(2(M−1)), M = max(p,q) ([plan.md](../plan.md) warnings block), as ½ − max over the two block formulas of steps 3–4: at (4,4) it is ½ − 1/3 = 1/6, at (5,5) ½ − 3/8 = 1/8, at (3,5) 1/8. At S³×S³ the ppqq block is exactly ½: the degenerate direction toward CP³ at n = 6, where CP³ ties θ_0(6). This turns Lemma L19's exact-arithmetic rigidity at sphere pairs into a two-line formula.
6. Apply to the exact families: for the SRG points of Lemma L74 all three block types are functions of (v,k,λ,μ) and the two SRG eigenvalues; read off which block carries the top eigenvalue at Δ > 0 points. *Screened: at the C₅ blow-up (θ = 0.6708) the diagonal block itself carries 1.206 and the Γ-nontrivial blocks stay at 0.76 and 0.67; at the Kneser SRG(15,6,1,3) point (θ = 0.197) the diagonal block carries 2.73.* So r310's floor 1 + 1/(2(n−3)(n−4)) (Observation L98) lives in the diagonal block, and V3 on the diagonal locus reduces to the n×n operator 𝓛 the record already has; the Γ-nontrivial blocks decide branching, not maximality, at every screened point.
7. State the branching corollary: by equivariant bifurcation at a Γ-fixed critical point, a curve of critical points leaving D_n has tangent in a Γ-nontrivial block with eigenvalue exactly ½ beyond the orbit; list the diagonal points where a block hits ½ (S³×S³ at n = 6 is one), this is the boundary between the halves, stated as a locus.

**Grade.** closes 1 (a sub-step: it makes the second-order structure at every exact diagonal point hand-checkable and names the boundary locus; it moves no value bound) × attackable 3 (the mechanism is R12's block-diagonalisation with the isotype enumeration done in step 1 in one line, untried on the diagonal family) × margin 2 (an identity; nothing saturates) × analytic 1 (closed forms in M and θ) = **6**.

**Fence-post screen.** Quantity: the spectrum of L_e at diagonal critical points, from the sign-flip symmetry. Grep over findings/ for "sign-flip", "(Z/2)", "4-set", "character.*Hessian": no recorded negative; the only sign-flip mention is problem.md line 127 (sign-flip averaging is norm-decreasing, irrelevant here). R12's stall reason (the branching enumeration of H-isotypes), is trivial for Γ. R10's closure (equivariant objects cannot see violations in non-trivial isotypes) is cleared: the item enumerates the non-trivial isotypes rather than building in the trivial one.

**Record screen.** Nearest: Lemma L24 (the ½ criterion), the diagonal reduction of Lemma L24 to 𝓛 ([diagonal-half.md](../findings/diagonal-half.md) line 145, which warns the diagonal restriction is blind to non-diagonal directions), Lemma L19 (orbit rigidity at sphere pairs by exact arithmetic), Observation L98. Difference: the record has the diagonal block and numerical spectra of the full operator; it has no decomposition of the non-diagonal directions, and the (p−2)/(2(p−1)) values it attributes to the diagonal restriction appear here as the within-factor pair blocks.

**What would falsify it.** A leak between character blocks (impossible by equivariance) or a block closed form that fails at a fifth sphere product; either costs an hour. If the closed forms fail the decomposition still stands and the blocks are computed per point.

**Consumes / unblocks.** Consumes nothing beyond Lemma L24 and the criticality equation. Unblocks I21's branching statement, gives R11 a hand-checkable test for "local maximum and Morse–Bott degenerate" over the whole SRG supply, and un-stalls R12 on the diagonal family.

## Section 2, build

### I21. The SO(n)-saturation of the diagonal locus is compact, and the closure question is void

**Theorem it would produce.** We would be able to state that O := SO(n)·D_n is compact, equals {W : some conjugate of Γ fixes W} = {W : ker Φ_W contains an A with pairwise-distinct sums} (Lemma L37), that max_O θ = Θ_n with equality only on the orbit of the balanced product, and that every critical point in the closure of the diagonal family is diagonal, so the boundary between the halves is not a limit set but the locus of diagonal points with a degenerate Γ-block (I14 step 7).

**Route.**
1. O is the image of the compact set SO(n) × {M ∈ D_n : |M| = 1} under a continuous map, hence compact; θ is SO(n)-invariant, so max_O θ = max_{D_n} θ = Θ_n (Lemma L57). One paragraph.
2. Identify O with the isotropy condition: W ∈ O iff Stab_{SO(n)}(W) ⊇ gΓg⁻¹ for some g; upper semicontinuity of stabilisers gives closedness a second way and explains why the "diagonal locus is not invariant" remark has no bite.
3. Read it through Lemma L37's kernel: dim ker Φ_W ≥ n on O, and the kernel dimension is upper semicontinuous, consistent with step 1.
4. Combine with I14 step 7: near a diagonal critical point whose Γ-nontrivial blocks are all ≠ ½ off the orbit, the critical set is locally the SO(n)-orbit of the diagonal critical set (implicit function theorem transverse to the orbit). This bounds reviewer 130's "PSD on a neighbourhood of the locus inside the critical set" (Lemma L97 discussion): on such neighbourhoods E = 0 by invariance and the claim is empty; it has content only near Γ-degenerate diagonal points.

**Grade.** closes 1 (settles brief question (iv) and prunes a claim) × attackable 3 (untried, elementary) × margin 1 (no inequality; the content is a sharp structural statement) × analytic 1 = **3**.

**Fence-post screen.** Quantity: none bounded; the object is the set O. Grep for "closure of the diagonal", "orbit of the diagonal", "not invariant": no recorded negative. Post F41/42 (kernel obstruction, gradedness screen vacuous when ker W ≠ 0) touched: padded points are in O only if diagonal in some frame; padded CP² is not (Lemma L37 / Plücker), consistent.

**Record screen.** Nearest: Lemma L37 (kernel criterion), Lemma L19 (isolated top orbits). Difference: neither states compactness of O or the branching characterisation of the boundary.

**Falsifier.** A non-diagonal critical point within distance ε of a Γ-nondegenerate diagonal critical point would contradict step 4; the record's n = 8 witness at 1.088948 (Observation L98 table) is the candidate to check by Lemma L37's kernel dimension, one evaluation. Worth a fence post either way.

**Consumes / unblocks.** Consumes I14 step 7 for step 4 only. Unblocks the verification-loop candidate on reviewer 130 below.

### I11. Lemma L57 lifted to every frame: which steps survive, with the defect isolated

**Theorem it would produce.** We would be able to state that at every critical point W, in every orthonormal frame F, the sectional matrix M_F (M_ij = ⟨W e_ij, e_ij⟩) is hollow with zero row sums and |M_F| ≤ |W|, that steps 2 and 3 of Lemma L57 apply to it verbatim, and that θ = μ_F − Σ_F/μ_F + ε_F/μ_F ≤ Θ_n|W| + ε_F/μ_F exactly, with ε_F := θμ_F − μ_F² + Σ_F the contraction of the off-diagonal defect of the criticality equation in the frame; and that at padded CP² in its unitary frame μ = 2/√6, Σ = 1/6, ε = ½, ε/μ = θ/2.

**Route.**
1. Define M_F; zero row sums are Ricci-flatness in the frame; |M_F|² ≤ |W|² with equality iff W is diagonal in F. Domain: all of W_n.
2. Read the diagonal entries of Q(W) = θW in F: θM_ij = M_ij² + (M²)_ij + E_ij with E_ij = ρ_ij − Σ_k W_{ik,jk}² + (cross terms k ≠ l), ρ_ij the off-diagonal mass of row (ij); on D_n, E = 0 and the equation is DGK (1). Domain: critical points.
3. Pair with v⊗v, v the top eigenvector of M_F: the s_i terms cancel exactly as in Lemma L57 step 1 ([problem.md](../findings/problem.md) lines 309–323), giving θμ = μ² − Σ_{i<j}M_ij²(v_i−v_j)² + ε_F; Cauchy–Schwarz needs only M1 = 0 and v ⊥ 1, so θ ≤ (n−1)μ/n + ε_F/μ.
4. Steps 2 and 3 of Lemma L57 (Z(v) projection, fourth-moment lemma) are statements about D_n and R^n and apply to M_F unchanged: μ ≤ 2|Z(v)||M_F| ≤ 2|Z|_max|W|, hence θ ≤ Θ_n|W| + ε_F/μ_F.
5. Evaluate at padded CP² in the unitary frame. *Screened at n = 6: θ = 1.224745, μ = 0.816497, Σ = 0.166667, ε = 0.500000, ε/μ = 0.612372 = θ/2; the Cauchy–Schwarz step is slack there (v is three-valued once padded).* The needed inequality ε_F/μ_F ≤ Θ_n − (n−1)μ_F/n is off by exactly Θ_n − θ = 0.011 at n = 12 (the same window as Lemma L18), so the lift is a rearrangement of θ ≤ Θ_n unless a frame is chosen by a principle.
6. BLOCKED sub-item (numerical): minimise ε_F/μ_F − (Θ_n − (n−1)μ_F/n) over frames at padded CP² at n = 12. Outcome ≤ 0: a frame-selection principle could close the lift and the item is promoted to section 1. Outcome > 0 in every frame: the lifted Lemma L57 is dead at the rival maximiser and this is a fence post against every frame-dependent lift of the diagonal proof.

**Grade.** closes 1 (answers brief question (iii); reduces the conjecture to a frame statement that is itself the conjecture at CP²) × attackable 2 (Lemma L18 already spent the analogous lift of Jäger's chain) × margin 1 (window 0.011 at padded CP², intrinsic) × analytic 1 = **2**.

**Fence-post screen.** Quantity: θ from the sectional matrix in a frame. Post F34 (R2 clearance: not a rearrangement of θ) is the live danger and step 5 shows the lift is one unless step 6 succeeds; R14's clearance ("substitute criticality and see what survives"), ε_F is a function of (θ, M_F) at a critical point, the free variable being the frame. Post F35 not touched. Grep "in every frame", "Dirichlet": Lemma L18 (problem.md line 254) is the recorded analogue.

**Record screen.** Nearest: Lemma L18 (Jäger's §3.3 workhorse inequality as an exact identity in every frame, defect priced by ‖Alt(W_-)‖²) and Lemma L15 (the one term that stops the lift). Difference: this lifts the three-step Lemma L57 rather than Jäger's chain, isolates a different defect ε_F, and shows steps 2–3 cost nothing.

**Falsifier.** Step 6's second outcome. Worth a fence post.

**Consumes / unblocks.** Consumes Lemma L57 and the criticality equation; unblocks nothing unless step 6 returns ≤ 0.

## Section 3, disprove

### I29. I24's interior row at the exact three-eigenvalue diagonal points, UNSCREENED

**Theorem it would produce.** We would be able to state, in closed form in (p,q), the slack of I24's hull condition on the middle-eigenvalue row at every unbalanced S^p×S^q and at DGK Ex 6.4, and hence whether the row family's implied θ-bound at a three-eigenvalue diagonal spectrum stays below θ_0(n) (I24 alive in the regime it has never been read in) or exceeds it (a fence post against I24 closing on its own).

**Route.**
1. At a diagonal point T_abc = c_abc² is the fixed so(n) data: row (ij)'s neighbours in the Killing sense are (ik),(jk) for k ≠ i,j, so the row's pair-points are (M_ik, M_jk), S_ab = Σ_c T_abc (r338) is the adjacency of the triangular graph T(n) and Sλ = −2λ is exactly M1 = 0. Domain: every diagonal W, critical or not.
2. Write (A), (B), (C) at row (ij) of S^p×S^q with M = (a within p, b within q, c cross), a = −qc/(p−1), b = −pc/(q−1), normalised; (C) is θc = c² + (p−1)ac + (q−1)bc for a cross row and its two within-factor analogues.
3. Form the hull condition of r337 at the interior row (the middle eigenvalue among a, b, c) with the six pair-points {(x,y): x,y ∈ {a,b,c}} and read off the maximal θ it admits as a linear inequality; compare with θ(S^p×S^q) (Lemma L57 chain, closed form) and with θ_0(p+q).
4. Repeat at DGK Ex 6.4 on Z/ℓ×Z/m (three values, θ_record ≈ √(2/(m+ℓ))), whose row structure is the Cayley graph's.
5. State the result as slack(p,q) and slack(ℓ,m); if any exceeds θ_0 − θ at that point the family cannot close there.

**Grade.** closes 1 (a decisive calibration of the grade-6 item at the only exact points in its open regime) × attackable 3 (closed-form data, untried by hand) × margin 1 × analytic 1 = **3**. UNSCREENED: the r337 hull statement was not re-read for its exact normalisation before the budget closed; the executor must take it from [REVIEW_r337.md](REVIEW_r337.md) first.

**Fence-post screen.** Post F34 (positive-side row family slack n/(n−2) at the balanced product) narrows it: the positive-side row is known slack; the item reads the interior row, which post F34 does not cover. Grep "interior row", "three distinct": plan.md I24 names it as the one unread regime; no negative.

**Record screen.** Nearest: plan.md I24 steps 1–3 and Lemma L73's saturation at S²×S^{n−2}. Difference: the interior row has never been evaluated; the exact families make it a hand computation.

**Falsifier / worth.** Either outcome is worth recording; the negative outcome is a fence post on I24.

**Consumes / unblocks.** Consumes r337's hull statement; unblocks I24's owed reading.

## Dropped after the record screen

- **Harmonic-square law (brief question (ii)).** DGK Lemma 3.1 is Lemma L99's direct-sum construction with θ = (Σθ_i⁻²)^{−1/2}, derived from (C) and Q(tW) = t²Q(W) and block additivity; off the locus it is the ∘-orthogonal additivity of Lemma L66 and post F35. It is a closure property of the critical set under ⊕, adds no relation at a single point, and r331's completeness of (A)(B)(C) is untouched. The one residual, ∘-orthogonal pairs on the locus with overlapping vertex sets (disjoint edge supports with M₁M₂ + M₂M₁ = 0 off-diagonal), is a curiosity below the value floor.
- **DGK Thm 3.2's prime obstruction** (no two-eigenvalue diagonal critical point at prime n ≡ 3 mod 4): consistent with Lemma L57's odd equality case having three eigenvalues; outside the goal (even n ≥ 12).

## (a) Where the region stands relative to the goal

The diagonal half is closed at every n by Lemma L57, and the exact families confirm it from outside (I26) without moving it, so the region contributes to the goal only through the boundary and through exact evaluation points. I14 makes the second variation at every diagonal critical point a finite set of closed-form blocks and turns the boundary between the halves into a stated locus (degenerate sign-flip blocks), which is the one place a non-diagonal critical point can be born from a diagonal one. Nothing here bounds θ off the locus; I11 shows the diagonal proof's only lossy step is the whole problem again, with the rival maximiser inside a 0.011 window.

## (b) Doubtful claims on the record, verification-loop candidates

- **Reviewer 130's "Lemma L97's PSD holds on a neighbourhood of the locus inside the critical set."** By I21 step 4, near a Γ-nondegenerate diagonal critical point the critical set is the SO(n)-orbit of diagonal points, on which E = 0 identically; the claim has content only near Γ-degenerate points, and it rests on rotated-frame numerics. Ask what points the neighbourhood contained.
- **[diagonal-half.md](../findings/diagonal-half.md) line 143: "(p−2)/(2(p−1)) is the diagonal value at a sphere product."** The screen finds that value as the top eigenvalue of the within-factor sign-flip pair block (a non-diagonal direction), while the diagonal block's value at S^p×S^q was not measured before the budget closed. One of the two attributions is wrong or the values coincide; a ten-line check.
- **Lemma L68 single-audited** (r291 outstanding, per plan.md), used by I14 step 6's Δ = 0 reading.
- **Second-kind index order** unsettled across files (conventions.md); I14 steps 3–4 depend on signed Bianchi and Ricci relations, and the screen needed the orientation signs (α − β + γ = 0; Σσ_i x_i = 0) to reproduce the orbit eigenvalue ½, an unsigned convention gives 0.1 in place of ½.
