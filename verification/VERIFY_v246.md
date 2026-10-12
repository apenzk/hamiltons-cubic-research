# Verifier v246, Lemma L54: the φ- and ψ-identifications, the two diagonal sums, Schur's majorizations, the per-frame use of L94, sorted and vector rigidity at t_F = 2, the canonical forms, and the Lean statement

The brief [BRIEF_L54.md](BRIEF_L54.md) was read cold. No numerical work was done, no scripts were written, and every value below is exact. Sources read: [L54Statement.lean](../lean/HamiltonsCubic/Results/L54Statement.lean), [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean), [L94.lean](../lean/HamiltonsCubic/Results/L94.lean), Li arXiv:2112.08465 eqs. (2.1)–(2.2) in [li-2112.08465.txt](https://arxiv.org/abs/2112.08465), and Nienhaus–Petersen–Wink Proposition 3.10 on page 19 of [npw-2206.14218.pdf](https://arxiv.org/abs/2206.14218). Log: [agent_logs/verify-L54-v246.log](../agent_logs/verify-L54-v246.log).

| # | Claim | Verdict |
|---|---|---|
| C1 | In the stated basis the φ-block diagonal of W̊ is K | CONFIRMED |
| C2 | The ψ-block of W̊ is exactly −K restricted to 1^⊥ | HYPOTHESIS-DEBT |
| C3 | The diagonal of M in the φ-basis of Λ² is K | CONFIRMED |
| C4 | Σd_φ² = t/2 and Σd² = (3/2)t | CONFIRMED AS ALGEBRA |
| C5 | Schur gives μ ≻ d_φ and ω ≻ d | CONFIRMED |
| C6 | L94 gives t_F ≤ 2 with equality exactly when W is coordinate-diagonal in that frame | GAP |
| C7 | At t_F = 2, μ↓ = d_φ↓ and ω↓ = d↓ | HYPOTHESIS-DEBT |
| C8 | At t_F = 2, μ = d_φ and ω = d as vectors, by a Cauchy–Schwarz equality | HYPOTHESIS-DEBT |
| C9 | The canonical forms (Passages B, C) state what Passage A states | REFUTED AS STATED |
| C10a | The Lean theorems type what they name, and the one sorry is the rigidity step | CONFIRMED AS ALGEBRA |
| C10b | The Lean docstrings: t_F ≤ 2 enters as a hypothesis proved in L94, and the n = 2 witness is L94's equality case | REFUTED AS STATED |

**What the round should do:** fix Passage B (eigenbasis stipulation, "in that frame"), cite or prove the per-frame equality case of L94 and the ψ-block identification, name the norm identity Σω² = 3‖M‖_F² and the rigidity theorem, and correct the two Lean docstrings.

## 0. Conventions, fixed once

- W is a Weyl tensor on ℝⁿ: W_abcd = −W_bacd = −W_abdc = W_cdab, first Bianchi, and Σ_a W_abad = 0.
- F = (e_1, …, e_n) is an orthonormal frame, K_ab = W_abab, t_F = Σ_{a≠b} K_ab², κ² = max_F t_F.
- M is W on Λ² in the orthonormal basis {e_a∧e_b}_{a<b}, M_(ab),(cd) = W_abcd. ‖M‖_F² = Σ_{a<b, c<d} W_abcd² = 1.
- W̊ acts on S²_0 by (W̊h)_ij = Σ_{k,l} W_iklj h_kl. φ_ab = (e_a⊗e_b + e_b⊗e_a)/√2 for a < b. For v ∈ 1^⊥ ⊂ ℝⁿ, diag(v) ∈ S²_0 with ‖diag(v)‖ = |v|.
- 1 = (1, …, 1). P is the orthogonal projection of ℝⁿ onto 1^⊥.
- Lengths: μ and d_φ have n(n−1)/2 entries. ω and d have n(n−1)/2 + (n−1) = (n−1)(n+2)/2 entries.
- The witness used throughout, W⋆ at n = 4: the coordinate-diagonal tensor with W_abab = K_ab, W_abba = −K_ab, all other components 0, where K = ½·[[0,1,−1,0],[1,0,0,−1],[−1,0,0,1],[0,−1,1,0]].
  - Antisymmetries and pair symmetry hold by construction. Bianchi holds because every term of W_abcd + W_acdb + W_adbc vanishes when a, b, c, d are distinct, and the cyclic sum vanishes identically by antisymmetry when two indices coincide.
  - Tracelessness: Σ_a W_abad vanishes for b ≠ d (no surviving component) and equals Σ_a K_ab for b = d. Every row sum of K is 0, so W⋆ is Weyl.
  - ‖M‖_F² = Σ_{a<b} K_ab² = 4·¼ = 1, and t_F = 2 in the standard frame.
  - K has eigenvalue 0 on 1, and on 1^⊥ the eigenvalues 1, −1, 0. Check: K̃ = 2K satisfies K̃² = 2(I − J) with J the permutation 1↔4, 2↔3, so K̃ has spectrum {2, −2, 0, 0}, and the 0-eigenspace is span{(1,0,0,1), (0,1,1,0)}, which contains 1.

Quotation check: brief lines against [findings/bispectral.md](../findings/bispectral.md) lines 15, 75, 217, 257, 259, 476, 478, 480 and [results.md](../results.md) lines 330, 1080, 1082 match. Passage G matches the Lean file character for character. The file has 221 newline-terminated lines against the brief's "222 lines", which is immaterial.

## Hypothesis inventory

| Hypothesis | Source | Checked against the object | Used by | Stated in A? |
|---|---|---|---|---|
| W Weyl (antisymmetries, pair symmetry, Bianchi, traceless) | Passage F "W acting on Λ²" | Holds by definition | C2, C4, C5 | Implicit |
| K1 = 0, i.e. Σ_b K_ab = 0 | Consequence of tracelessness with d = b | Needed for "K on 1^⊥" to be a restriction and for Σ_{1^⊥}λ² = t | C2, C4 | **No** |
| ‖M‖_F = 1 | Passage F | Normalisation | C6, C7 | Yes (F) |
| Σω² = 3 when ‖M‖_F = 1 | Passage G convention only | Not stated or derived in A–F | C7 | **No** |
| ψ_k an orthonormal eigenbasis of K on 1^⊥ | Passage A | Exists since K is symmetric and K1 = 0 | C4, C7, C8 | Yes |
| Schur's theorem: diagonal ≺ spectrum for a real symmetric operator | Passage A "Schur–Horn", F "Schur's theorem" | Only Schur's half is used. **No source filed under references/** | C5 | Yes |
| M self-adjoint on Λ² | Pair symmetry | Holds | C5 | Implicit |
| W̊ self-adjoint on S²_0 and S²_0-preserving | Li p. 7 ("induces a symmetric bilinear form"), NPW p. 3 ("R̄ is self-adjoint", R̄(g) = −Ric) | Holds for Weyl W | C5 | Implicit |
| Li's convention (2.2) | Li eq. (2.2), with (2.1) fixing R_ijij as sectional curvature | Li's basis form R̊(e_i⊙e_j) = Σ R_iklj e_k⊙e_l has (a,b) matrix entry R_iabj + R_ibaj on h = e_a⊙e_b, identical to the record's component form | C1 | Yes |
| NPW φ_ij and g(R̄φ_ij, φ_ij) = R_ijij | NPW Proposition 3.10, proof "a straightforward computation" | Matches the record's φ | C1 | Yes |
| NPW staircase ψ_k | NPW Proposition 3.10 | **Printed with coefficient −k**, which is not trace-free (trace n − 2k) and has norm² k² + n − k ≠ (n−k+1)(n−k). The coefficient −(n−k) is the reading that makes the proposition true | C9 (Passage B) | Rejected in A |
| L94: κ² ≤ 2‖M‖_F², equality iff coordinate-diagonal in some frame | Passage E (heading only) | Existential form. No proof quoted. Lean carries it as sorry | C6, C8 | Cited, but in per-frame form |
| Rigidity: x ≻ y and Σx² = Σy² imply x↓ = y↓ | Passage A "so" | No citation, no source filed | C7 | **No** |

## 1. C1, the φ-diagonal of W̊ is K

Chain on file: Passage F's statement ⟨W̊φ_ij, φ_ij⟩ = W_ijij, with NPW Proposition 3.10 at source giving the same identity for the same φ_ij and the same operator R̄(h) = Σ R_·kl· h_kl.

Check from the definitions. With h = φ_ab, the nonzero entries are h_ab = h_ba = 1/√2. Then ⟨h, W̊h⟩ = ½(W_aabb + W_abab + W_baba + W_bbaa) = W_abab = K_ab, since W_aabb = W_bbaa = 0 by antisymmetry. The φ-diagonal is a diagonal only, and the full φ-compression carries off-diagonal entries ⟨φ_ab, W̊φ_cd⟩ that are nonzero in general.

Verdict: **CONFIRMED.** Candidate against it, W1 (sign convention), withdrawn below.

## 2. C2, the ψ-block of W̊ is −K on 1^⊥

Chain on file: Passage D, line 259, says Π_diag W̊ Π_diag = −K|_{1^⊥} was "checked at random Weyl tensors, n = 5, 6, 7, to 2×10⁻¹⁶". No derivation of the identity appears in Passages A–F. Passage F supplies only the φ half.

"Block" here is the whole compression onto the diagonal traceless subspace {diag(v) : v ∈ 1^⊥}, of dimension n − 1. "Restricted to 1^⊥" is a restriction, rather than the compression PKP, only if K maps 1^⊥ into itself, which requires K1 = 0. That fact is used and stated nowhere in A–F.

Why an eigenbasis: the compression is basis-independent, but the diagonal d_ψ equals −(eigenvalues of K on 1^⊥) only in an eigenbasis. In any other orthonormal basis of 1^⊥ the diagonal has strictly smaller square sum unless K|_{1^⊥} is already diagonal there, which breaks C4's Σd_ψ² = t and hence C7.

What would have to be proved: ⟨diag(u), W̊ diag(v)⟩ = −uᵀKv for u, v ∈ 1^⊥, and K1 = 0 from tracelessness. A screen on the witness W⋆ is consistent with the claim, and no counterexample was found.

Verdict: **HYPOTHESIS-DEBT.** A measurement stands where a derivation belongs, and Passage D itself says the identification "is the only justification ω ≻ d has".

## 3. C3, the φ-diagonal of M is K

Chain on file: Passage F, M_(ij),(ij) = W_ijij. With M_(ab),(cd) = W_abcd in the orthonormal basis {e_a∧e_b}_{a<b}, which is Li's (2.1) with its ½ absorbed by the two orderings of (k, l), the diagonal entry is W_abab = K_ab. d_φ as the diagonal of M and d_φ as the φ-diagonal of W̊ are the same vector, indexed by a < b.

Verdict: **CONFIRMED.**

## 4. C4, the two sums

- Σd_φ² = Σ_{a<b} K_ab² = ½Σ_{a≠b} K_ab² = t/2, using only symmetry and hollowness. Passage D calls this "pure algebra", correctly.
- Σd_ψ² = Σ_{k=1}^{n−1} λ_k² where λ_k are the eigenvalues of K on 1^⊥. Since K1 = 0, the spectrum of K on ℝⁿ is {0} ∪ {λ_k}, so Σλ_k² = ‖K‖_F² = t. **K1 = 0 is load-bearing here and unstated.** Without it the eigenvalues of PKP on 1^⊥ have square sum ‖PKP‖_F², which differs from t in general.
- Hence Σd² = (3/2)t, conditional on C2.

Verdict: **CONFIRMED AS ALGEBRA**, given C2 and K1 = 0.

## 5. C5, Schur

- The half used is Schur's (the diagonal of a real symmetric matrix is majorized by its spectrum). Horn's converse is never used.
- μ ≻ d_φ: M is symmetric by pair symmetry, d_φ is its full diagonal in an orthonormal basis of Λ², both vectors have n(n−1)/2 entries. Legitimate.
- ω ≻ d: W̊ is self-adjoint and maps S²_0 into itself for Weyl W (NPW p. 3: R̄(g) = −Ric = 0), d is its full diagonal in an orthonormal basis of S²_0, both vectors have (n−1)(n+2)/2 entries. Legitimate.
- Schur's theorem has no source filed under [references/](../references/), and none is cited in Passages A, C or F beyond the name.

Verdict: **CONFIRMED**, with the source not filed.

## 6. C6, the per-frame use of L94

Passage A uses: for the fixed frame F, t_F ≤ 2, **with equality exactly when W is coordinate-diagonal in that frame**. Passage E supplies: κ² ≤ 2‖M‖_F², with equality exactly when W is coordinate-diagonal **in some frame**.

- t_F ≤ 2 follows from E, since t_F ≤ max_G t_G = κ² ≤ 2.
- The per-frame equality clause does not follow from E. E's clause reads (κ² = 2) ⇔ (∃G, W coordinate-diagonal in G). From t_F = 2 it yields coordinate-diagonality in some G, possibly ≠ F. From coordinate-diagonality in F it yields κ² = 2, possibly attained elsewhere.
- The two readings genuinely differ. Take W⋆ and the frame F' = ((e_1+e_2)/√2, (e_1−e_2)/√2, e_3, e_4). For coordinate-diagonal W, W(x,y,x,y) = Σ_{a<b} K_ab (x_a y_b − x_b y_a)². This gives K'_{12} = ½, K'_{34} = ½, and K'_{13} = K'_{14} = K'_{23} = K'_{24} = −¼ (row sums 0, as they must be). So t_{F'} = 2(¼ + 4·1/16 + ¼) = 3/2 < 2, while W⋆ is coordinate-diagonal in the standard frame. E's "some frame" is therefore false read per frame, and A's "that frame" is a strictly different statement that A attributes to E.
- No proof of E is quoted. Passage G says L94 is "proved there". [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) lines 130–134 state it in the existential form and close it with sorry. [L94.lean](../lean/HamiltonsCubic/Results/L94.lean) carries only rational arithmetic (the norm-factor 4, the value 3/(m+1)). **The claim "proved there" is not borne out.**
- Where it is used: the sorted rigidity (C7) needs only t_F = 2 and does not touch the equality clause. The vector rigidity (C8) needs the per-frame direction "t_F = 2 ⇒ M diagonal in F's basis".

Verdict: **GAP.** The per-frame equality characterisation is used (C8) and attributed to a given whose stated form does not deliver it, with no proof of either form on file.

## 7. C7, sorted rigidity at t_F = 2

Passage A: "At t_F = 2 majorization has equal sums *and* equal norms on both sides, so μ↓ = d_φ↓ and ω↓ = d↓."

- Equal sums: supplied by Schur (C5).
- Equal norms, φ pair: Σμ² = ‖M‖_F² = 1 and Σd_φ² = t_F/2 = 1. Holds.
- Equal norms, full pair: Σd² = 3 needs C2 and K1 = 0. Σω² = ‖W̊‖_F² = 3 needs the identity ‖W̊‖_F² = 3‖M‖_F², which appears only in Passage G's convention paragraph and nowhere in A–F. A screen of it from the definitions and first Bianchi raised no failure.
- The implication "x ≻ y and Σx² = Σy² ⇒ x↓ = y↓" is asserted with "so". It is the strict Schur-convexity of Σx², uncited and with no source filed. Passage G names it and leaves it as sorry.
- On W⋆ in its standard frame the conclusion holds exactly: μ = (½, −½, 0, 0, −½, ½) = d_φ, and ω↓ = d↓ = (1, ½, ½, 0, 0, 0, −½, −½, −1).

Verdict: **HYPOTHESIS-DEBT.** Two facts carry the step, the norm identity Σω² = 3‖M‖_F² and the rigidity theorem, and neither is argued or cited on file.

## 8. C8, vector rigidity by "Cauchy–Schwarz"

Passage A: "at t_F = 2 the Cauchy–Schwarz equality already makes M diagonal in the φ-basis and W̊ block-diagonal, whence μ = d_φ and ω = d as vectors."

- No Cauchy–Schwarz is written in Passages A–F. The inequality whose equality case gives diagonality is t_F/2 = Σ_{a<b} M_(ab),(ab)² ≤ ‖M‖_F² = 1, obtained by dropping the off-diagonal squares. Its equality case is M diagonal in {e_a∧e_b}, which is W coordinate-diagonal in F. That is C6's per-frame clause, itself without a proof on file.
- From "M diagonal" to "W̊ block-diagonal" no step is written.
- "Block-diagonal, whence ω = d" needs more than block-diagonality. If the φ-block were a non-diagonal symmetric matrix, the spectrum on that block would differ from its diagonal whenever the off-diagonal entries were nonzero. What is needed is that the φ-block is itself diagonal and the ψ-block is diagonal in the chosen eigenbasis. The sentence does not say the first.
- The most charitable reading: coordinate-diagonal W makes W̊ send φ_ab to K_ab φ_ab and diag(v) to −diag(Kv), so W̊ is fully diagonal in the stated basis. On W⋆ this holds exactly. The reading rescues the conclusion but supplies an argument the record does not carry.

Verdict: **HYPOTHESIS-DEBT.** What must be proved: (i) the per-frame equality case of the diagonal-drop inequality, (ii) that coordinate-diagonal W makes W̊ diagonal on the φ-block and equal to −K on the ψ-block with vanishing cross block.

## 9. C9, the canonical forms

**Passage B (results.md line 330).** "In the Nienhaus–Petersen–Wink basis of S²_0 the φ-diagonal of W̊ is K, the ψ-block is −K on 1^⊥ … so μ ≻ d_φ, ω ≻ d, and at t = 2 (coordinate-diagonal in some frame), both majorizations are equalities."

Three-step record, candidate B1 (the NPW basis):
1. Location: the phrase "In the Nienhaus–Petersen–Wink basis of S²_0" with no eigenbasis stipulation, against Passage A's "NPW's own staircase ψ_k will not serve".
2. Failure in closed form: W⋆, standard frame, t = 2, NPW's staircase (trace-free reading) ψ_1 = diag(−3,1,1,1)/√12, ψ_2 = diag(0,−2,1,1)/√6, ψ_3 = diag(0,0,−1,1)/√2. The diagonal entries −ψ_kᵀKψ_k are 0, −½, ½. So Σd_ψ² = ½, Σd² = 1 + ½ = 3/2 ≠ 3 = Σω². Sorted: d↓ = (½, ½, ½, 0, 0, 0, −½, −½, −½) against ω↓ = (1, ½, ½, 0, 0, 0, −½, −½, −1). The majorization ω ≻ d is strict. The printed coefficient −k gives no trace-free basis at all, so the literal reading fails earlier still.
3. Charitable reading: B is the one-line landscape form of C, and "NPW basis" abbreviates "NPW's φ with an eigenbasis ψ". The reading does not survive: the record's own detail forms say the NPW staircase will not serve, and a reader of B alone gets a false statement.

Candidate B2 ("at t = 2 (coordinate-diagonal in some frame)"):
1. Location: the parenthetical, with t undefined in B and the frame never fixed.
2. Failure: read t as κ² and the frame as arbitrary, W⋆ in F' has κ² = 2 and is coordinate-diagonal in some frame, yet t_{F'} = 3/2 gives Σd_φ² = 3/4 ≠ 1 = Σμ², so μ↓ ≠ d_φ↓ in F'.
3. Charitable reading: t means t_F and the parenthetical loosely quotes L94. The reading makes B true on this clause, but it is the per-frame/over-frames conflation the lemma itself warns against ("the bound is per-frame"). Kept as a wording defect under B1's verdict.

**Passage C (results.md line 1082).** Matches Passage A on the basis, the identifications, the sums, Schur, the per-frame L94 clause (inheriting C6) and the sorted rigidity. Two differences:
- The vector equality is justified only by "the Cauchy–Schwarz equality that makes M diagonal", dropping A's "and W̊ block-diagonal", so ω = d as vectors has no stated route in C at all.
- The closing sentence, "the shared-frame coupling of Lemma L52 is an identity exactly on the diagonal family", is not in A and no argument for it is quoted. Not checked further.

Verdict: **REFUTED AS STATED** (Passage B). Passage C carries C6's and C8's debts.

## 10. C10, the Lean statement

**C10a, what is typed.**
- [Majorizes](../lean/HamiltonsCubic/Results/L54Statement.lean#L120) (equal totals, and every S has a T of equal cardinality with Σ_S y ≤ Σ_T x) is equivalent to the standard definition, since max over |S| = k of Σ_S y is the sum of the k largest entries. [SameSorted](../lean/HamiltonsCubic/Results/L54Statement.lean#L125) is "y is a permutation of x". Both correct.
- [sameSorted_of_majorizes_of_normSq_eq](../lean/HamiltonsCubic/Results/L54Statement.lean#L137) is exactly the rigidity implication of C7, and it carries the single sorry. The sorry is the claim it names.
- [sum_offDiag_sq](../lean/HamiltonsCubic/Results/L54Statement.lean#L148) proves Σ_{a<b} K_ab² = (Σ_{a,b} K_ab²)/2 from symmetry and hollowness. Correct, and it uses no K1 = 0, as the φ half needs none.
- [sum_full_diag_sq](../lean/HamiltonsCubic/Results/L54Statement.lean#L204) and [norms_match_at_two](../lean/HamiltonsCubic/Results/L54Statement.lean#L211) are arithmetic on hypotheses.
- [rigidity_at_t_two](../lean/HamiltonsCubic/Results/L54Statement.lean#L218): binders are free vectors mu, dphi on P and om, d on Q, with no link to W, K, n, or the dimensions. Hypotheses: two Majorizes, t = 2, Σμ² = 1, Σω² = 3, Σdphi² = t/2, Σd² = (3/2)t. They exclude nothing and are jointly satisfiable (P = Q = Unit, mu = dphi = 1, om = d = √3). The conclusion follows from them and the named sorry.

Verdict: **CONFIRMED AS ALGEBRA.** The file types the rigidity step with the geometry supplied as hypotheses, as its "What is NOT typed" section says.

**C10b, what the docstrings claim.**
- Candidate L1. Location: header lines 79–81, "t_F ≤ 2 is Lemma L94 of this record, proved there and not here, it is a named hypothesis with that provenance". Failure: no hypothesis t ≤ 2 occurs in the file. The only one is ht : t = 2 (line 225), a case assumption that L94 does not supply, and L94 is unproved in both [L94Statement.lean](../lean/HamiltonsCubic/Results/L94Statement.lean) (sorry, line 134) and [L94.lean](../lean/HamiltonsCubic/Results/L94.lean) (arithmetic only). Charitable reading: "that provenance" means the equality case is where L94 lives. That rescues the hypothesis's meaning but not "proved there". Stands.
- Candidate L2. Location: header line 82, "Σd_φ² = t/2 is proved below". Failure: rigidity_at_t_two takes hdphi as a hypothesis on a free vector, and sum_offDiag_sq is never consumed. Charitable reading: the identity is proved as a standalone lemma, which is literally true. Kept as a note, not a finding.
- Candidate L3. Location: lines 248–250, "K = ![![0,1],![1,0]] has t = ‖K‖_F² = 2, which is exactly the equality case of L94". Failure: at n = 2 tracelessness reads Σ_a W_a2a2 = W_1212 = K_12 = 0, so K(F) of any Weyl tensor at n = 2 is 0. The displayed K has K1 = (1,1) ≠ 0, so it is the sectional matrix of no Weyl tensor and ‖M‖_F = 1 is unreachable there. Charitable reading: "equality case" means only the number 2. The docstring says "exactly the equality case of L94", a lemma about Weyl tensors. Stands.

Verdict: **REFUTED AS STATED** (L1, L3). Neither affects the typed theorems.

## 11. The standing list, item by item

1. **Hypothesis inventory.** See the table above. Used but unstated: K1 = 0 (C2, C4), Σω² = 3‖M‖_F² (C7), the rigidity theorem (C7), the per-frame equality case of L94 (C8). Schur's theorem has no filed source.
2. **Quantifier order.** Everything in A is per frame F, and t in A means t_F. Passage E is over frames (κ²), and its equality clause is existential in the frame. A's use needs the universal per-frame form (§6). Passage B loses the frame entirely (§9, B2).
3. **Edges.**
   - n = 4: No finding. W⋆ exhibits every clause of A at n = 4 with t_F = 2.
   - Odd n: No finding. No step depends on parity, and (n−1)(n+2)/2 is an integer for all n.
   - t_F = 0: No finding. K = 0, every basis of 1^⊥ is an eigenbasis, d = 0, and μ ≻ 0, ω ≻ 0 hold since tr M = ½·1ᵀK1 = 0 and tr W̊ = 0. The rigidity clause is not engaged.
   - ker W ≠ 0: No finding against the lemma. Zero eigenvalues in μ or ω change nothing in Schur or rigidity. A degenerate 0-eigenspace of K containing 1 bears only on how an eigenbasis of 1^⊥ is chosen (W2 below).
   - n ≤ 3 (beyond the list): W = 0, so ‖M‖_F = 1 is unreachable and the lemma is vacuous. This is what makes L3 a finding.
4. **Proven against stated.** Proven on file: C1, C3 (by NPW and Passage F), C4's algebra, C5. Stated without proof: C2 (measured only), the per-frame L94 clause, Σω² = 3, the rigidity theorem, and the vector-equality route.
5. **Lean statements.** §10. Binders are free vectors, no hypothesis excludes anything, the sorry is the claim it names, and two docstring claims are false.
6. **What to attack.**
   1. The identification: C1 and C3 have a statement on file (F) and a published source (NPW 3.10). C2 has only a check (D). "Block" is the whole compression. The eigenbasis is needed for Σd_ψ² = t (§2).
   2. The sums: Σd_φ² = t/2 needs no K1 = 0. Σd² = (3/2)t needs K1 = 0, which comes from tracelessness and is unstated (§4).
   3. Schur–Horn: Schur's half. Both uses legitimate. Lengths n(n−1)/2 and (n−1)(n+2)/2 (§5).
   4. The given: E does not supply the per-frame equality clause (witness F', t_{F'} = 3/2). No proof of E is quoted, and "proved there" is not borne out (§6).
   5. The rigidity: the φ-pair norms are equal at t_F = 2. The full-pair norms are equal given C2 and Σω² = 3, the latter unstated in A–F. The rigidity theorem is uncited (§7).
   6. The cheaper route: no Cauchy–Schwarz is written. The operative inequality is the off-diagonal drop, and "block-diagonal" understates what ω = d needs (§8).
   7. Canonical forms: B refuted as stated. C drops W̊'s part of the vector route and adds an unargued L52 sentence (§9).
   8. Lean: §10.
   9. The boundary: item 3 above.
7. **Falsifiers and the search.**

| Claim | Object that would falsify it | What I did |
|---|---|---|
| C1, C3 | A Weyl W and pair a < b with ⟨φ_ab, W̊φ_ab⟩ ≠ W_abab, or a convention in which the sign flips | Expanded the quadratic form from the definition. Read Li (2.1)–(2.2) and NPW 3.10 at source (W1) |
| C2 | u, v ∈ 1^⊥ with ⟨diag u, W̊ diag v⟩ ≠ −uᵀKv | Screened on W⋆. Found none. The debt is the missing derivation |
| C4 | A Weyl W with Σ_{1^⊥}λ² ≠ t | Traced the dependence to K1 = 0, which tracelessness forces |
| C5 | A non-self-adjoint M or W̊, or a length mismatch | Checked pair symmetry, NPW's self-adjointness, and both dimension counts |
| C6 | A frame F with t_F < 2 and W coordinate-diagonal in another frame | Exhibited: W⋆ in F', t_{F'} = 3/2. Falsifies E read per frame, and shows A's clause is not E's |
| C7 | x ≻ y with Σx² = Σy² and x↓ ≠ y↓, or Σω² ≠ 3 at ‖M‖_F = 1 | Screened the norm identity. Checked W⋆ exactly |
| C8 | t_F = 2 with M not diagonal in F's basis, or W̊ not diagonal | Checked W⋆ exactly. The debt is the missing derivation |
| C9 | A basis named by B in which equality fails at t = 2 | Exhibited: NPW staircase on W⋆, Σd² = 3/2 |
| C10 | A docstring claim contradicted by the file or by the definitions | L1 (no t ≤ 2 hypothesis, L94 unproved), L3 (n = 2 has no nonzero Weyl) |

### Withdrawn candidates

- **W1, Li's sign convention.** (1) Passage F line 15, "(W̊h)_ij = Σ W_iklj h_kl" with K_ab = W_abab, could flip the φ-diagonal to −K if Li's R_ijij were minus the sectional curvature. (2) No failure: Li's remark after (2.1), that eigenvalues of R̂ ≥ κ bound sectional curvatures below by κ, fixes R_ijij as the sectional curvature, and the basis form of (2.2) equals the record's component form entry by entry (R_iabj + R_ibaj on e_a⊙e_b). (3) Withdrawn: the conventions agree.
- **W2, Passage D's degenerate-eigenspace remark.** (1) Line 259, "A reimplementation that picked the wrong basis inside K's degenerate eigenspaces fails to reproduce the identity". Any two orthonormal eigenbases of K|_{1^⊥} give the same diagonal. (2) No failure in the lemma. (3) Charitable reading holds: on W⋆ the 0-eigenspace of K is span{(1,0,0,1), (0,1,1,0)} ∋ 1, and an eigenbasis chosen there, such as (1,0,0,1)/√2, lies outside 1^⊥, so diag(v) is not trace-free. The remark is about implementations. Withdrawn.
- **W3, NPW's printed ψ_k.** (1) NPW p. 19, ψ_k with coefficient −k. (2) Trace n − 2k ≠ 0 for k ≠ n/2. (3) A misprint in the source, and −(n−k) is the only coefficient consistent with the proposition's own "trace-free" and normalisation. Withdrawn as a finding against L54. It is used in §9 only in the corrected form.
- **W4, "a hollow nonzero K is never diagonal" in the staircase.** (1) Passage A. (2) Sought a nonzero hollow K with K1 = 0 whose restriction to 1^⊥ is diagonal in the staircase. Such K equals Σλ_kψ_kψ_kᵀ, and hollowness read at coordinates 1, 2, … in turn forces λ_1 = λ_2 = … = 0, each coordinate first meeting a new ψ_k with nonzero weight. No failure. (3) Withdrawn: the remark holds.
- **W5, Lean Majorizes nonstandard.** (1) Line 120. (2) No failure: the maximum over |S| = k is the sorted partial sum. (3) Withdrawn.
- **W6, ht : t = 2 mistypes L94.** (1) Line 225. (2) It is a case assumption, and the theorem is correct with it. (3) Withdrawn against the theorem. The docstring half survives as L1.

## Overall verdict

**GAP.** The mathematics of Passage A survives every attack, and the witness W⋆ realises every clause exactly. The chain on file breaks at the per-frame equality case attributed to L94, whose stated form does not deliver it and which has no proof on file or in Lean. It also owes derivations for the ψ-block identification (measured only), for Σω² = 3‖M‖_F² and the rigidity theorem, and for the vector-equality route. Passage B is refuted as stated by the NPW staircase at t = 2.
