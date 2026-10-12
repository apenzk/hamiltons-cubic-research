# Verifier v245, Lemma L54: the φ-diagonal and ψ-block of W̊, the φ-diagonal of M, the two sums, the Schur majorizations, the per-frame given from L94, rigidity at t_F = 2, the cheaper route, the Lean statement, and the canonical forms

The brief ([BRIEF_L54.md](BRIEF_L54.md)) was read cold. No numerical work was done, every value below is exact and obtained by hand in closed form, and no scripts were written. The Lean files were read and not built. Log: [agent_logs/verify-L54-v245.log](../agent_logs/verify-L54-v245.log).

| # | Claim | Verdict |
|---|---|---|
| 1 | The φ-diagonal of W̊ is K: ⟨W̊φ_ab, φ_ab⟩ = K_ab | CONFIRMED |
| 2 | The ψ-block of W̊ is −K restricted to 1⊥ | HYPOTHESIS-DEBT |
| 3 | The φ-diagonal of M is K | CONFIRMED AS ALGEBRA |
| 4a | Σd_φ² = t/2 | CONFIRMED |
| 4b | Σd² = (3/2)t, equivalently Σd_ψ² = t | HYPOTHESIS-DEBT |
| 5 | μ ≻ d_φ and ω ≻ d by Schur's half of Schur-Horn | CONFIRMED |
| 6 | The given: t_F ≤ 2 per frame, with equality exactly when W is coordinate-diagonal in that frame | HYPOTHESIS-DEBT |
| 7 | Rigidity at t_F = 2: μ↓ = d_φ↓ and ω↓ = d↓ | HYPOTHESIS-DEBT |
| 8 | Cheaper route: at t_F = 2, μ = d_φ and ω = d as vectors, by a Cauchy-Schwarz equality | HYPOTHESIS-DEBT |
| 9a | Passage G's typed statements type what they say | CONFIRMED AS ALGEBRA |
| 9b | Passage G's docstring claims ("proved there" for L94, the n = 2 witness as L94's equality case, the "verbatim" quotation, the doubly stochastic gloss) | REFUTED AS STATED |
| 10 | Passage B, the landscape form ("In the Nienhaus-Petersen-Wink basis", "at t=2 (coordinate-diagonal in some frame)") | REFUTED AS STATED |
| 11 | Passage C's added closing sentence (same wall, L52's coupling an identity exactly on the diagonal family) | HYPOTHESIS-DEBT |
| 12 | Passage A's remark that NPW's staircase is unusable "being fixed by the frame and carrying no dependence on W, so a hollow nonzero K is never diagonal in it" | GAP |

**What the round should do:** file derivations for the ψ-block compression, K**1** = 0 and the per-frame equality case of L94, cite or prove the rigidity lemma and Σω² = 3‖M‖_F², write out the cheaper route, fix Passage B's basis and frame wording, and correct the four Lean docstring claims.

## 0. Conventions, fixed once

- W is an algebraic curvature tensor on ℝⁿ with Ricci contraction zero (a Weyl tensor), as in [L94Statement.lean:66-67](../lean/HamiltonsCubic/Results/L94Statement.lean#L66-L67). Components are taken in an orthonormal frame F = (e_1, …, e_n).
- Sign: the round sphere has R_ijkl = δ_ik δ_jl − δ_il δ_jk, so R_ijij = +1 is the sectional curvature ([Li, arXiv:2112.08465](../references/li-2021-nonnegative-second-kind/README.md), Example 2.4, and [NPW, arXiv:2206.14218](../references/nienhaus-petersen-wink-2022-betti-second-kind/README.md), Example 1.1). K_ab = W_abab.
- Second-kind operator, read at source: Li (2.2) gives W̊(e_i ⊙ e_j) = Σ_kl W_iklj e_k ⊙ e_l with u ⊙ v = u⊗v + v⊗u and ⟨A, B⟩ = tr(AᵀB). NPW §1 gives (Rh)_ij = Σ_kl R_iklj h_kl. These agree with Passage F's component form: expanding h = ½Σ h_ij e_i ⊙ e_j gives (W̊h)_kl = ½Σ_ij h_ij (W_iklj + W_ilkj), and the second term equals the first after renaming i ↔ j, using h symmetric and W_jlki = W_kijl = W_iklj (pair symmetry, then both antisymmetries).
- M is Li's (2.1), R̂(e_i ∧ e_j) = ½Σ_kl W_ijkl e_k ∧ e_l, with {e_i ∧ e_j}_{i<j} orthonormal. Its matrix is M_(ij),(kl) = W_ijkl and ‖M‖_F² = Σ_{i<j, k<l} W_ijkl², which is [L94Statement.lean:84-85](../lean/HamiltonsCubic/Results/L94Statement.lean#L84-L85).
- φ_ab = (e_a⊗e_b + e_b⊗e_a)/√2 for a < b, as [NPW Proposition 3.10](https://arxiv.org/abs/2206.14218) (page 19) prints it. ψ_k = diag(v_k) with (v_k) orthonormal in **1**⊥, so ⟨diag v, diag w⟩ = v·w.
- NPW's printed staircase reads ψ_k = (−k e^k⊗e^k + Σ_{l>k} e^l⊗e^l)/√((n−k+1)(n−k)). As printed its trace is n − 2k, so the source carries a typo. Tracelessness and the stated normalisation both force the coefficient −(n−k). I read the staircase that way, and NPW's own partial-sum formula for Σ_{k≤p} g(R(ψ_k), ψ_k) agrees with that reading on the example of §10.
- t = t_F = Σ_{a≠b} K_ab², and κ² = max_F t_F. Majorization x ≻ y means equal sums and each top-k sum of y is at most the top-k sum of x.
- **The running example W₀** (n = 4). K_12 = K_34 = ½, K_13 = K_24 = −½, K_14 = K_23 = 0, and W₀_abcd = K_ab(δ_ac δ_bd − δ_ad δ_bc). Checks: both antisymmetries and pair symmetry hold by inspection. The Bianchi sum vanishes because a nonzero term needs {a,b} = {c,d}, and the two surviving terms cancel as +K_ab − K_ab. The Ricci contraction is Σ_a W₀_abad = δ_bd (K**1**)_b = 0 because every row of K sums to zero. ‖M‖_F² = Σ_{a<b} K_ab² = 1 and t = 2. K has eigenvalues 1, −1, 0 on (1,1,−1,−1)/2, (1,−1,1,−1)/2, (1,−1,−1,1)/2 and 0 on **1**.

## Hypothesis inventory (standing item 1)

| Hypothesis | Source | Used by | Stated in A to F? |
|---|---|---|---|
| W is trace-free (Weyl) | L94's setting, [L94Statement.lean:66-67](../lean/HamiltonsCubic/Results/L94Statement.lean#L66-L67), and the letter W | K**1** = 0 (claims 2, 4b), W̊ preserving S²₀ (claim 5), Σω² = 3 (claim 7) | **Used, unstated** in the quoted passages |
| ‖M‖_F = 1 | Passage F, line 15 | equal norms at t_F = 2 (claim 7) | Stated |
| F orthonormal, fixed | Passage A | every claim | Stated |
| ψ_k an orthonormal eigenbasis of K inside **1**⊥ | Passage A | claims 4b and 8 | Stated. "Inside **1**⊥" is the working condition when K's zero eigenspace in ℝⁿ is degenerate (§ standing item 3) |
| Li's convention (2.2) | Passage F, read at source | claims 1, 2 | Stated, agrees with source |
| M_(ij),(ij) = W_ijij sign | Passage F, line 75, matching Li (2.1) | claim 3 | Stated as a statement, fixes the sign |
| Schur (1923): real symmetric matrix, orthonormal basis | Passage A names Schur-Horn | claim 5 | Named. **Source not filed** in [references/](../references/INDEX.md) |
| L94: W Weyl, ‖M‖_F the Λ² operator norm | Passage E | claim 6 | Supplies κ² ≤ 2 and "some frame" only |
| NPW Proposition 3.10: algebraic curvature tensor, orthonormal frame | Passage A names the vectors | claim 1 | Named, read at source. Proof there is "a straightforward computation" |
| Rigidity: majorization plus equal 2-norms forces equal sorted vectors | none | claim 7 | **Used, unstated, source not filed** |
| Σω² = 3‖M‖_F² | Passage G docstring (file line 71) | claim 7 | **Used, stated only in Lean prose** |

## 1. The φ-diagonal of W̊ is K

**Record.** Passage F (line 75) states ⟨W̊φ_ij, φ_ij⟩ = W_ijij "in any orthonormal frame". Passage D reports a check at random Weyl tensors. Passage A asserts it.

**At source.** NPW Proposition 3.10 states g(R(φ_ij), φ_ij) = R_ijij for their operator, the same as Li's (§0). The proof of NPW Proposition 1.2 displays the same identity. For Weyl W the projection to S²₀ is the identity on S²₀ (NPW §1: R preserves S²₀ iff Einstein), so it holds for W̊.

**Screen.** h = φ_ab has h_ab = h_ba = 1/√2. ⟨W̊h, h⟩ = Σ W_pklq h_kl h_pq over (p,q), (k,l) ∈ {(a,b), (b,a)}, times ½. The four terms are W_aabb = 0, W_abab, W_baba = W_abab, and W_bbaa = 0, so the value is W_abab = K_ab. It uses only the antisymmetries and pair symmetry. No falsifier exists at the level of the definitions.

**Verdict: CONFIRMED.** The record should cite NPW Proposition 3.10 for it and drop reliance on the numerical check.

## 2. The ψ-block of W̊ is −K on **1**⊥

**Record.** Passage A asserts the block. Passage D gives Π_diag W̊ Π_diag = −K|_{**1**⊥} "checked at random Weyl tensors, n = 5,6,7, to 2×10⁻¹⁶". Passage F carries the eigenbasis stipulation and no derivation. NPW Proposition 3.10 gives only partial sums of the staircase diagonal. **On file there is a check and no derivation.**

**What "block" means.** Passage A's sentence covers the whole ψψ compression ("the ψ-block of W̊ is exactly −K restricted"). The claimed d_ψ is its diagonal in the eigenbasis, the eigenvalues negated. The φψ cross block is left unconstrained, and A claims it is zero only at t_F = 2 (claim 8).

**Why an eigenbasis.** d_ψ must carry the whole Frobenius norm of the block for Σd_ψ² = t (claim 4b). The block must also be diagonal at t_F = 2 for ω = d (claim 8). The staircase fails the first on W₀ (§10).

**What would have to be proved.** (i) For v, w ∈ **1**⊥, ⟨diag w, W̊ diag v⟩ = −wᵀKv. (ii) K**1** = 0, so that K maps **1**⊥ to itself and the compression is a restriction. (iii) In an eigenbasis of that restriction the block is diag(−λ_k).

**Screen.** (i) Σ_ijkl W_iklj v_k δ_kl w_i δ_ij = Σ_ik W_ikki v_k w_i = −Σ_ik K_ik w_i v_k. (ii) (K**1**)_b = Σ_a W_abab, the Ricci contraction at (b,b), which is zero for Weyl W. No falsifier found.

**Verdict: HYPOTHESIS-DEBT.**

## 3. The φ-diagonal of M is K

Under Li (2.1), R̂(e_i ∧ e_j) = Σ_{k<l} W_ijkl e_k ∧ e_l, so M_(ij),(ij) = W_ijij = K_ij. Li notes the operator is fixed "up to sign". The opposite sign gives −K, and Passage F's line 75 fixes the sign by stating M_(ij),(ij) = W_ijij. "The φ-basis of Λ²" is read as {e_i ∧ e_j}_{i<j}, indexed by the same pairs as φ_ij. This is one entry of the defining matrix.

**Verdict: CONFIRMED AS ALGEBRA.**

## 4. The sums

### 4a. Σd_φ² = t/2

d_φ = (K_ab)_{a<b} by claim 1. Symmetry of K gives Σ_{a<b} K_ab² = ½Σ_{a≠b} K_ab² = t/2. Hollowness is what lets t be written as the full Frobenius norm, which [sum_offDiag_sq](../lean/HamiltonsCubic/Results/L54Statement.lean#L113-L164) types. K**1** = 0 is not used. **Verdict: CONFIRMED.**

### 4b. Σd² = (3/2)t

**Record.** Passage D: "Σd² = t/2 + t = (3/2)t … is **pure algebra**". The step Σd_ψ² = Σλ_k² = t is unargued. Passage G takes it as the hypothesis hpsi.

**Where it needs K1 = 0.** Σλ_k² over the spectrum of K on **1**⊥ equals tr K² = t exactly when **1** spans a zero eigendirection. K**1** = 0 comes from tracelessness (claim 2 (ii)), and no quoted passage states it.

**Discrepancy record.** (1) Location: Passage D, line 259, "So Σd² = t/2 + t = 3/2 t … is pure algebra". (2) Failure without tracelessness: the sphere tensor R_ijkl = δ_ik δ_jl − δ_il δ_jk at n = 4 has K = J − I and t = 12. On **1**⊥, K = −I, so Σd_ψ² = 3 and Σd² = 6 + 3 = 9 ≠ 18 = (3/2)t. (3) Charitable reading: W is the Weyl tensor throughout the file, so K**1** = 0 and the identity holds. The candidate is withdrawn as a refutation (§ Withdrawn) and stands as debt: the step is used and has no argument on file.

**Verdict: HYPOTHESIS-DEBT.** The owed argument is K**1** = 0 from tracelessness, then Σλ_k² = tr K² − 0.

## 5. Schur's majorizations

**Import.** Schur (1923): the diagonal of a real symmetric matrix in an orthonormal basis is majorized by its spectrum. Only this half is used, and Horn's converse plays no role. **The source is not filed** in [references/INDEX.md](../references/INDEX.md), which carries no Schur or majorization entry.

**Hypotheses against the objects:**

- M is real symmetric: M_(ij),(kl) = W_ijkl = W_klij by pair symmetry.
- W̊ is self-adjoint on S² (NPW §1). For Weyl W, R(g) = −Ric = 0 (NPW §1), so ⟨Rh, g⟩ = ⟨h, R g⟩ = 0 and W̊ maps S²₀ into S²₀.
- {e_i ∧ e_j} is orthonormal in Li's Λ² inner product. {φ_ab, ψ_k} is orthonormal in tr(AᵀB): the φ_ab by NPW Proposition 3.10, the ψ_k because the v_k are orthonormal, and φ ⟂ ψ by disjoint supports.
- Lengths: μ and d_φ both have n(n−1)/2 entries. ω and d both have n(n−1)/2 + (n−1) = (n−1)(n+2)/2 = N entries, Li's dim S²₀.
- Equal sums: Σμ = tr M = Σd_φ, and Σω = tr W̊ = Σd, trace being basis-free.

**Verdict: CONFIRMED** (application correct, source not filed).

## 6. The given from Lemma L94

**Record.** Passage A uses "t_F ≤ 2, with equality exactly when W is coordinate-diagonal **in that frame**". Passage E's heading states "κ² ≤ 2‖M‖_F², with equality exactly when W is coordinate-diagonal in **some** frame".

**What E supplies:**

- The per-frame bound t_F ≤ κ² ≤ 2 follows.
- t_F = 2 gives κ² = 2 and so coordinate-diagonality in some frame F′. E does not assert F′ = F.
- Coordinate-diagonality in F gives κ² = 2. E does not assert t_F = 2.
- So E supplies the bound and **neither direction** of the per-frame equality case.

**Proof on file.** The brief quotes none. Passage G's "[Lemma L94](L94.lean) of this record, proved there and not here" ([L54Statement.lean:44](../lean/HamiltonsCubic/Results/L54Statement.lean#L44)) is not borne out:

- [L94.lean](../lean/HamiltonsCubic/Results/L94.lean) carries the κ²(ℂPᵐ) = 3/(m+1) arithmetic and the factor-4 norm remark. It contains neither a statement nor a proof of the bound.
- [L94Statement.lean:130-134](../lean/HamiltonsCubic/Results/L94Statement.lean#L130-L134) states the lemma with a sorry over the whole of it, and its docstring says "stated in full and unproved".
- Its equality clause is the "some frame" form, ∃ frame attaining ↔ ∃ frame coordinate-diagonal.

**Discrepancy record.** (1) Location: Passage A, line 480, "gives t_F≤2, with equality exactly when W is coordinate-diagonal in that frame", against Passage E, line 217. (2) Concrete failure: the inference from E fails, but no tensor exhibits a false conclusion. My screen finds the per-frame claim true. Per-vector Cauchy-Schwarz gives Σ_{a<b} M_(ab),(ab)² ≤ ‖M‖_F², with equality iff M is diagonal in {e_a ∧ e_b}, which is coordinate-diagonality in F, and t_F = 2Σ_{a<b} M_(ab),(ab)². (3) Charitable reading: "that frame" is the evident intended per-frame lemma. That reading is still unargued on file. The candidate is therefore a missing argument and not a false claim.

**Use.** Rigidity (claim 7) needs only the value t_F = 2, so L94 enters it only as the statement that 2 is the ceiling. The cheaper route (claim 8) needs the per-frame direction t_F = 2 ⇒ M diagonal in F.

**Verdict: HYPOTHESIS-DEBT.** The owed argument is the per-frame inequality and its equality case in the same frame.

## 7. Rigidity at t_F = 2

**Record.** Passage A: "At t_F=2 majorization has equal sums *and* equal norms on both sides, so μ↓ = d_φ↓ and ω↓ = d↓". No argument or citation is given. Passage G leaves [sameSorted_of_majorizes_of_normSq_eq](../lean/HamiltonsCubic/Results/L54Statement.lean#L102-L105) as sorry.

**Equal norms:**

- Σd_φ² = t_F/2 = 1 = ‖M‖_F² = Σμ², by claims 3, 4a and ‖M‖_F = 1.
- Σd² = (3/2)·2 = 3, by claim 4b (itself debt).
- Σω² = 3 is the normalisation stated in [L54Statement.lean:71](../lean/HamiltonsCubic/Results/L54Statement.lean#L71), granted by the brief, and derived nowhere in A to F. On W₀, ω = d = (½, ½, −½, −½, 0, 0, −1, 1, 0) has Σω² = 3, which is consistent.
- Equal sums hold by trace (claim 5).

**The rigidity step.** It is a classical fact of majorization theory (strict Schur-convexity of Σx²), true as stated. My screen: x ≻ y gives y = Dx with D doubly stochastic, and Σ(Dx)_i² ≤ Σx_j² with equality iff each row of D is supported on one level set of x. Counting column sums per level set then makes y a rearrangement of x. No source is filed and no quoted passage names it.

**Verdict: HYPOTHESIS-DEBT.** Owed: a filed citation or proof of the rigidity step, and a derivation of Σω² = 3‖M‖_F².

## 8. The cheaper route

**Record.** Passage A: "at t_F=2 the Cauchy-Schwarz equality already makes M diagonal in the φ-basis and W̊ block-diagonal, whence μ = d_φ and ω = d as vectors". Passage C cites only M's diagonality. No derivation is quoted, and the Cauchy-Schwarz is not named.

**Which Cauchy-Schwarz.** The charitable identification is per basis vector: ⟨Mφ, φ⟩² ≤ ‖Mφ‖², summed over {e_a ∧ e_b}, with equality iff each e_a ∧ e_b is an eigenvector.

**What would have to be proved:**

- (i) The per-frame equality case of claim 6.
- (ii) M diagonal in {e_a ∧ e_b} gives μ = d_φ. This is immediate once (i) holds.
- (iii) Coordinate-diagonality of W in F gives W̊φ_ab = K_ab φ_ab, W̊ diag(v) = −diag(Kv), and a zero φψ cross block.
- (iv) In the eigenbasis the ψψ block is diagonal, so ω = d.

Passage C's sentence covers only (i) and (ii), so it supports μ = d_φ and leaves ω = d resting on the step A names.

**Screen.** For coordinate-diagonal W, (W̊φ_ab)_ij = (W_iabj + W_ibaj)/√2 is nonzero only at (i,j) ∈ {(a,b), (b,a)}, where it is K_ab/√2. (W̊ diag v)_ij = Σ_k W_ikkj v_k is zero for i ≠ j and equals −(Kv)_i for i = j. On W₀ this gives ω = d as listed in §7. No falsifier found.

**Verdict: HYPOTHESIS-DEBT.**

## 9. The Lean statement (Passage G)

File line = brief line − 35 (the diff of brief lines 36 to 256 against the file is empty).

### 9a. Typed statements

- [Majorizes](../lean/HamiltonsCubic/Results/L54Statement.lean#L85-L87) is correct. For fixed k, "∀S ∃T with |T| = |S| and Σ_S y ≤ Σ_T x" is equivalent to top-k(y) ≤ top-k(x). Take S to be y's top k for one direction. For the other, bound any Σ_S y by top-k(y) and choose T as x's top k. Direction: Majorizes mu dphi is μ ≻ d_φ, as intended.
- [SameSorted](../lean/HamiltonsCubic/Results/L54Statement.lean#L90-L91) is "y is a rearrangement of x", which is correct.
- The single sorry, [sameSorted_of_majorizes_of_normSq_eq](../lean/HamiltonsCubic/Results/L54Statement.lean#L102-L105), is exactly claim 7's rigidity step, true, over an arbitrary finite index type.
- [sum_offDiag_sq](../lean/HamiltonsCubic/Results/L54Statement.lean#L113-L164) types claim 4a with symmetry and hollowness as its only hypotheses. [sum_full_diag_sq](../lean/HamiltonsCubic/Results/L54Statement.lean#L169-L171) and [norms_match_at_two](../lean/HamiltonsCubic/Results/L54Statement.lean#L176-L178) are arithmetic.
- [rigidity_at_t_two](../lean/HamiltonsCubic/Results/L54Statement.lean#L183-L200) carries the majorizations, t = 2, both normalisations and both diagonal norms as binders. They are jointly satisfiable (W₀'s vectors satisfy all of them), so no binder excludes a case.
- The theorem is independent of W, K and n. P and Q are arbitrary, and hdphi and hd are free hypotheses left unconnected to sum_offDiag_sq. The file's "What is NOT typed here" says as much.
- Minor binder mismatch: the header ([L54Statement.lean:44-46](../lean/HamiltonsCubic/Results/L54Statement.lean#L44-L46)) calls "t_F ≤ 2" a named hypothesis, and the theorem carries only ht : t = 2 ([line 190](../lean/HamiltonsCubic/Results/L54Statement.lean#L190)). The bound appears in no binder and is unused.

**Verdict: CONFIRMED AS ALGEBRA.**

### 9b. Docstring claims

Four candidates, each with its three-step record:

1. **"proved there"** ([line 44](../lean/HamiltonsCubic/Results/L54Statement.lean#L44)). (1) Located. (2) L94.lean has no proof of the bound and L94Statement.lean:134 is a sorry over the whole lemma (claim 6). (3) Charitable reading "proved in bispectral.md": the link targets L94.lean, and no proof is quoted in the brief. **Stands.**
2. **The n = 2 witness "is exactly the equality case of L94"** ([lines 213-215](../lean/HamiltonsCubic/Results/L54Statement.lean#L213-L215)). (1) Located. (2) At n = 2 tracelessness with b = d = 2 gives Σ_a W_a2a2 = W_1212 = K_12 = 0, so no Weyl tensor has K = [[0,1],[1,0]]. That K also has K**1** = (1,1) ≠ 0. (3) Charitable reading "2 is the number in L94's equality case": the words claim an instance. **Stands.**
3. **"The record's statement, verbatim"** ([lines 13-29](../lean/HamiltonsCubic/Results/L54Statement.lean#L13-L29)). (1) Located. (2) The quotation has "---" at two places where [bispectral.md:480](../findings/bispectral.md#L480) now reads ",", and its L94 link target differs. (3) Charitable reading: an earlier revision, same content. The word "verbatim" is false of the current file. **Stands**, as a stale quotation.
4. **"a doubly stochastic map strictly decreases the 2-norm unless it is a permutation"** ([line 100](../lean/HamiltonsCubic/Results/L54Statement.lean#L100)). (1) Located. (2) D = ½[[1,1],[1,1]] and x = (1,1) give Dx = x with equal norms, and D is no permutation. (3) Charitable reading "unless Dx is a rearrangement of x" is the true statement. The typed theorem is unaffected. **Stands**, as wording.

**Verdict: REFUTED AS STATED** (prose only, the typed content of 9a is unaffected).

## 10. Passage B, the landscape form

Passage B reads: "In the Nienhaus-Petersen-Wink basis of S²₀ … so μ ≻ d_φ, ω ≻ d, and at t=2 (coordinate-diagonal in some frame), both majorizations are equalities". Two candidates:

**10(a), the basis.** (1) Location: [results.md:330](../results.md#L330), "In the Nienhaus–Petersen–Wink basis". Passages A and C say NPW's staircase "will not serve". (2) Failure: take W₀ in its own frame, t = 2. The NPW staircase at n = 4 is u_1 = (−3,1,1,1)/√12, u_2 = (0,−2,1,1)/√6, u_3 = (0,0,−1,1)/√2. With K = ½A:

- Au_1·√12 = (0,−4,4,0), so u_1ᵀKu_1 = 0.
- Au_2·√6 = (−3,−1,1,3), so u_2ᵀKu_2 = ½·6/6 = ½.
- Au_3·√2 = (1,−1,1,−1), so u_3ᵀKu_3 = ½·(−2)/2 = −½.

So d_ψ = (0, −½, ½), and NPW's partial-sum formula gives the same (0, −½, 0). Then Σd² = 1 + ½ = 3/2 ≠ 3 = Σω², so ω↓ ≠ d↓ at t = 2 in the basis B names. (3) Charitable reading: B abbreviates the detail form's basis. The words name the basis A and C exclude. **Stands.**

**10(b), "(coordinate-diagonal in some frame)".** (1) Location: the same line, the parenthetical glossing "t=2". (2) Failure: W₀ is coordinate-diagonal in the standard frame. Take F = ((e_1+e_3)/√2, e_2, (−e_1+e_3)/√2, e_4).

- W₀(f_1,f_2,f_3,f_2) = ½(−K_12 + K_32) = −¼, so M in F has M_(12),(23) = W₀(f_1,f_2,f_2,f_3) = ¼, and its transpose, off the diagonal.
- ‖M‖_F = 1 is frame-invariant, so Σ_{a<b} K(F)_ab² ≤ 1 − 2/16 = 7/8 and t_F ≤ 7/4.
- Then Σd_φ² ≤ 7/8 < 1 = Σμ², so μ↓ ≠ d_φ↓ in F.

(3) Charitable reading: "t = 2, which some frame attains iff W is coordinate-diagonal in some frame". Under it B is true apart from 10(a). The parenthetical as written reads as the condition. **Stands**, as wording.

**Verdict: REFUTED AS STATED.** Passages A and C are consistent with each other on "in that frame".

## 11. Passage C's additions

- "So both-sided Schur–Horn and the vertex-matrix budget are the same wall, and the shared-frame coupling of Lemma L52 is an identity exactly on the diagonal family." Neither the vertex-matrix budget nor L52's statement is quoted in the brief. "Exactly" asserts both directions, and neither is argued in A to F.
- C's cheaper-route sentence covers M only (claim 8).
- C omits A's "hollow nonzero K" remark (claim 12), which spares it that defect.

**Verdict: HYPOTHESIS-DEBT.**

## 12. The staircase remark

(1) Location: Passage A, line 480, "being fixed by the frame and carrying no dependence on W, so a hollow nonzero K is never diagonal in it". (2) Failure of the inference: at n = 4 the orthonormal basis (1,1,−1,−1)/2, (1,−1,1,−1)/2, (1,−1,−1,1)/2 of **1**⊥ is fixed by the frame and independent of W, yet W₀'s K is diagonal in it with eigenvalues 1, −1, 0 (§0). Frame-fixedness therefore does not yield the conclusion. (3) Charitable reading: the conclusion rests on the staircase's triangular support. Under that reading the conclusion survives my screen for K**1** = 0. If K|_{**1**⊥} = Σλ_k v_k v_kᵀ, then K_11 = λ_1(n−1)/n forces λ_1 = 0, K_22 = λ_2(n−2)/(n−1) forces λ_2 = 0, and so on. The remark does not state that argument.

**Verdict: GAP.** The stated reason does not imply the claim, and the working reason (the triangular shape plus K**1** = 0) is unwritten.

### Withdrawn candidates

- **Σd² = (3/2)t fails** (§4b). Withdrawn at step 3: the sphere counterexample is not Weyl, and under the file's Weyl hypothesis the identity holds. It survives only as debt.
- **"A hollow nonzero K is never diagonal in the staircase" is false.** K = J − I is hollow and nonzero, and its compression to **1**⊥ is −I, diagonal in every basis. Withdrawn at step 3: K(F) of a Weyl tensor has K**1** = 0, and J − I has K**1** = (n−1)**1**.
- **Passage D's "wrong basis inside K's degenerate eigenspaces" is incoherent**, since any orthonormal basis of an eigenspace is an eigenbasis. Withdrawn at step 3: on W₀, K's zero eigenspace in ℝ⁴ is spanned by **1** and (1,−1,−1,1). An eigensolver's basis of it need not lie in **1**⊥, and that is the failure D describes.
- **Passage F's convention disagrees with Li (2.2)**, which is written on basis elements. Withdrawn at step 2: the two forms agree (§0).
- **Per-frame t_F = 2 does not force coordinate-diagonality in F.** Withdrawn at step 2: no tensor exhibits it, and the screen in §6 closes. It stands as debt.

## Standing list

1. **Hypothesis inventory:** the table above. Used but unstated: tracelessness of W (for K**1** = 0 and S²₀-invariance), the rigidity lemma, and Σω² = 3‖M‖_F².
2. **Quantifier order and scope.** A is per frame throughout: ψ_k depends on (F, W), and t = t_F. The over-all-frames quantity κ² enters only through E, whose "some frame" is weaker than A's "that frame" (claim 6). B mixes the two (claim 10(b)).
3. **Edges:**
   - n = 4: W₀ attains t_F = 2 and every step holds. At n = 2, ‖M‖_F = 1 is unreachable, since tracelessness forces K_12 = 0 (§9b).
   - Odd n: W₀ padded with a zero row and column at n = 5 keeps K**1** = 0, ‖M‖_F = 1 and t_F = 2, and nothing in the chain uses parity.
   - t_F = 0: d = 0, every top-k sum of a zero-sum vector is at least k·0, so μ ≻ 0 and ω ≻ 0 hold. The eigenbasis is arbitrary and rigidity is not invoked.
   - ker W ≠ 0: W₀ has dim ker M = 2 and dim ker W̊ = 3, and every step holds. The degenerate zero eigenspace of K in ℝ⁴ is where "inside **1**⊥" must be enforced.
4. **Proven against stated.** Proven on file or at source: claims 1, 3, 4a, 5. Used without argument on file: 2, 4b, 6 (per frame), 7, 8, 11. Wording defects: 9b, 10, 12. The quoted chain that actually closes is: identification ⇒ sums ⇒ Schur ⇒ at t_F = 2, rigidity. Its links 2, 4b and 7 are debt.
5. **Lean:** §9. Binders are sound and exclude nothing. The one sorry is the claim it names. The t_F ≤ 2 binder the header announces is absent, and four prose claims are wrong as stated.
6. **What to attack:**
   1. §1, §2, §3. A derivation is on file at source for the φ-diagonal (NPW 3.10). For the ψ-block there is only a numerical check. The M-diagonal is definitional. "Block" means the whole ψψ compression, and the eigenbasis is needed for claims 4b and 8.
   2. §4. K**1** = 0 is used for the ψ half only and comes from tracelessness, which is unstated.
   3. §5. Schur's half is used, the lengths match (n(n−1)/2 and (n−1)(n+2)/2), and the source is not filed.
   4. §6. E supplies the bound and not the per-frame equality case. No proof is quoted, and "proved there" is not borne out.
   5. §7. The rigidity step is true and unargued. Equal norms hold at t_F = 2 given Σμ² = 1 and Σω² = 3, with the latter underived in A to F.
   6. §8. Per-vector Cauchy-Schwarz, written nowhere. The W̊ block-diagonality is unwritten.
   7. §10, §11. B is refuted as stated on the basis and on "some frame". C matches A on "that frame" and adds an unargued L52 sentence.
   8. §9.
   9. Standing item 3.
7. **Falsifiers named and sought:**

| Claim | Falsifying object | Search and outcome |
|---|---|---|
| 1 | W with ⟨W̊φ_ab, φ_ab⟩ ≠ W_abab | Component computation. None exists |
| 2 | Weyl W, v, w ∈ **1**⊥ with ⟨diag w, W̊ diag v⟩ ≠ −wᵀKv | Component computation. None exists |
| 3 | A convention with M_(ij),(ij) = −W_ijij | Li's "up to sign", excluded by F line 75 |
| 4a | Symmetric hollow K with Σ_{a<b} K_ab² ≠ t/2 | None |
| 4b | K(F) with Σλ_k² ≠ t | Sphere (not Weyl), withdrawn |
| 5 | Non-symmetric operator or length mismatch | None |
| 6 | Weyl W with t_F = 2 and W coordinate-diagonal only in another frame | Screen closes. None |
| 7 | x ≻ y with equal norms and y not a rearrangement | Doubly stochastic equality case. None |
| 8 | Weyl W with t_F = 2 and ω ≠ d | Coordinate-diagonal computation. None |
| 9b | W₀-free witnesses | D = ½J and x = (1,1). The n = 2 trace argument. The L94 sorry. The stale quote |
| 10 | Coordinate-diagonal W with strict majorization in the named basis or frame | W₀ in the NPW staircase (Σd² = 3/2) and W₀ in the rotated frame F (t_F ≤ 7/4) |
| 12 | A frame-fixed basis diagonalising a nonzero Weyl K | W₀'s eigenbasis |

## Overall verdict

**HYPOTHESIS-DEBT.** No claim in the findings form (Passage A) is false: every falsifier sought in closed form either failed or was withdrawn at step 3. But several load-bearing links have no argument on file:

- the ψ-block compression and K**1** = 0
- Σd_ψ² = t
- the per-frame equality case of L94, whose Lean statement is a sorry and whose quoted form covers "some frame"
- the rigidity step and Σω² = 3
- the cheaper route

Passage B is wrong as stated on its basis and its frame, and four Lean docstring claims are wrong as stated.
