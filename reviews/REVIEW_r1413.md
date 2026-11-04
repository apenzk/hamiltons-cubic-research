# REVIEW r1413: the diagonal as a doubly stochastic image of the spectrum in Lean, `diag_doublyStochastic` and `diag_convex_le_spectrum`

Log [agent_logs/r1413.log](../agent_logs/r1413.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: scratch files elaborated for `#print axioms` and two screens on objects built for the purpose, each finishing in seconds, reported as screens and never as evidence. Record: [findings/bispectral.md](../findings/bispectral.md), Lemma L52 ("the shared-frame majorization bound, and what its equality clause needs"). Lean: commit e44bb55b, [SchurMajor.lean](../lean/HamiltonsCubic/Results/SchurMajor.lean) and [DoublyStochastic.lean](../lean/HamiltonsCubic/Results/DoublyStochastic.lean), with the consumer [L52Statement.lean](../lean/HamiltonsCubic/Results/L52Statement.lean), [L52.lean](../lean/HamiltonsCubic/Results/L52.lean), [L54Schur.lean](../lean/HamiltonsCubic/Results/L54Schur.lean), [SecondKind.lean](../lean/HamiltonsCubic/Results/SecondKind.lean) and the L52 row of [lean/INDEX.md](../lean/INDEX.md). Prior review: [r1412](REVIEW_r1412.md) asked for exactly this export.

**Standfirst.** `diag_doublyStochastic` is the spectral statement the record names: for every real symmetric `A` there is a doubly stochastic `P`, witnessed in the proof by $P_{ij}=U_{ij}^2$ for Mathlib's diagonalising orthogonal $U$, with $A_{ii}=\sum_jP_{ij}\lambda_j$ and $\lambda$ the spectrum counted with multiplicity. The axioms are the standard three. **The gap is in how the commit describes its second theorem.** `diag_convex_le_spectrum` asks for `g` convex on all of $\mathbb R$, and neither of L52's functions is: $t^3+3mt^2$ is convex only on $[-m,\infty)$ and $t^3-3M_+t^2$ concave only on $(-\infty,M_+]$. So it is not "the form L52 uses". The form L52Statement consumes is `diag_doublyStochastic`'s own, which matches `majorization_bound`'s `hDmu` and `hKmu` field for field. The L52 row's new Owed clause names only the $\mu$ side and omits the $\omega$ side, the two norm constraints and L50's identity. DoublyStochastic.lean's edited paragraph is accurate, and the paragraphs it left standing still claim the equality case makes $U$ a permutation, which the record's own L52 block refutes at degenerate spectra.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1a. `diag_doublyStochastic` is the statement "$P_{ij}=\lvert U_{ij}\rvert^2$ is doubly stochastic, $K_i=\sum_jP_{ij}\mu_j$" | CONFIRMED | Elaborated type: `∀ A (hA : A.IsHermitian), ∃ P, IsDoublyStochastic P ∧ ∀ i, A i i = ∑ j, P i j * hA.eigenvalues j`. Over $\mathbb R$, `IsHermitian` is symmetry. `IsDoublyStochastic` is nonnegativity plus unit row and column sums. The witness is `fun i x => U i x ^ 2` with `U` Mathlib's `eigenvectorUnitary`. |
| 1b. For every real symmetric matrix, spectrum with multiplicity | CONFIRMED | Index type `N` is any `Fintype` with `DecidableEq`, and no further hypothesis is taken. `Matrix.IsHermitian.eigenvalues : N → ℝ` is indexed by the eigenvector basis, so each eigenvalue appears as often as its multiplicity. |
| 1c. The existential | CONFIRMED WITH GAP | For the inequality the existential is all a consumer uses. The equality-case lemmas in DoublyStochastic.lean speak of $U$, and the statement hides which $U$ produced `P`. No current consumer needs that link. |
| 2a. `diag_convex_le_spectrum` is $\sum g(A_{ii})\le\sum g(\lambda_j)$ for convex $g$ | CONFIRMED | `ConvexOn ℝ Set.univ g → ∑ i, g (A i i) ≤ ∑ j, g (hA.eigenvalues j)`, the Jensen-and-column-sum argument of `DoublyStochastic.diagonal_le_spectrum` applied to 1a. |
| 2b. "the form L52 uses" (docstring, module header, commit message, INDEX row) | REFUTED | L52 applies Jensen to $t^3+3mt^2$ on $[-m,\infty)$ and to $t^3-3M_+t^2$ on $(-\infty,M_+]$. At $m=1$, $g(-2)=4$ exceeds $\tfrac12(g(-3)+g(-1))=1$, so $g$ is not convex on $\mathbb R$ and the hypothesis cannot be met (screened in Lean). A tangent-line extension below $-m$ would repair it, and no such lemma exists. L52Statement's `jensen_rows_convex` takes `ConvexOn ℝ s f` with the points in `s`, which is the form L52 uses. |
| 2c. What L52 actually consumes | CONFIRMED | `majorization_bound` takes `hDmu : DoublyStochastic Dmu` and `hKmu : ∀ i, K i = ∑ j, Dmu i j * mu j`, which is 1a's conclusion verbatim, modulo L52Statement's own copy of the structure (identical fields `nonneg`, `rows`, `cols`), and a screen composing the two with `mu_side` elaborated. So the $\mu$-side import is discharged by `diag_doublyStochastic`, not by `diag_convex_le_spectrum`. |
| 2d. The L52 row's Owed clause | CONFIRMED WITH GAP | Accurate as far as it goes, and incomplete. Missing: the $\omega$ side ($\mathring W$ as a symmetric matrix in an orthonormal basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$ with the $\psi_k$ an eigenbasis of $K$, its eigenvalues $\omega$, then `diag_doublyStochastic` there), $p_2(\mu)=1$ from $\lVert M\rVert_F=1$, $p_2(\omega)=3$, and L50's $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$. `Mpair` and `Mpair_isHermitian` already exist, so the $\mu$ side is an instantiation. |
| 3. DoublyStochastic.lean's docstring after the commit | CONFIRMED WITH GAP | The rewritten paragraph is accurate. Left standing: the title "L52 does not need Karamata" and "for strictly convex `g` that makes each row a point mass, so `U` is a permutation". The record's L52 block says Jensen equality makes the variable constant on each row's support, which a $\pi/4$ rotation in a degenerate eigenplane satisfies with no permutation. SchurMajor's docstring also points the import at L52.lean, which carries none, where L52Statement.lean does. |
| 4. Axioms | CONFIRMED | `diag_doublyStochastic`, `diag_convex_le_spectrum` and `schur_majorizes`: `[propext, Classical.choice, Quot.sound]`. |

**One-line summary: CONFIRMED WITH GAP.** `diag_doublyStochastic` is exactly the spectral statement L52 and DoublyStochastic.lean imported, for every real symmetric matrix with multiplicities, on the standard axioms, and the gap is that `diag_convex_le_spectrum`'s whole-line convexity is not the form L52 uses, the row's Owed clause omits the $\omega$ side and the norm and bi-spectral inputs, and DoublyStochastic's docstring keeps the refuted point-mass claim.

## 1. `diag_doublyStochastic`

The proof sets `U := hA.eigenvectorUnitary`, reads `U * star U = 1` and `star U * U = 1` from `unitaryGroup` membership, and takes `P i x := U i x ^ 2`. Nonnegativity is `sq_nonneg`. Row sums come from the $(i,i)$ entry of $UU^*=1$ and column sums from the $(x,x)$ entry of $U^*U=1$, with `star` on a real matrix the transpose. The representation comes from the $(i,i)$ entry of `hA.spectral_theorem`, $A=U\mathop{\mathrm{diag}}(\lambda)U^*$, giving $A_{ii}=\sum_xU_{ix}\lambda_xU_{ix}$. This is the record's "$K_i=\sum_j\lvert U_{ij}\rvert^2\mu_j$ with $(\lvert U_{ij}\rvert^2)$ doubly stochastic", real case.

The spectrum is Mathlib's `IsHermitian.eigenvalues`, a function on the index type `N`, so a repeated eigenvalue appears once per basis vector. This is the record's $\mu$ "with multiplicity", and the index sets of diagonal and spectrum coincide, which is what Jensen row by row needs.

The existential hides $U$. For the inequality this loses nothing. The equality analysis in DoublyStochastic.lean (`equality_forces_rowwise`, `permutation_gives_equality`) is phrased on an abstract `P`, so it also loses nothing today. A consumer who wants "the frame is shared" from row tightness will need `P` tied to `A`, and the statement as written does not supply that.

## 2. `diag_convex_le_spectrum` and what L52 needs

**The theorem is correct and misdescribed.** Its hypothesis is `ConvexOn ℝ Set.univ g`. L52's two functions are convex or concave only on half-lines, the record says so ("respectively convex on $[-m,\infty)$ and concave on $(-\infty,M_+]$"), and L52Statement types them that way (`convexOn_cubePlus m : ConvexOn ℝ (Set.Ici (-m)) _`). On $\mathbb R$ they fail: $g(t)=t^3+3t^2$ has $g(-3)=0$, $g(-1)=2$, $g(-2)=4>1$. A screen elaborated `¬ ConvexOn ℝ Set.univ (fun t => t^3 + 3*1*t^2)` without error. So `diag_convex_le_spectrum` cannot be applied to L52's functions as stated. Two repairs are available: state it with `ConvexOn ℝ s g` and `∀ j, λ_j ∈ s` (the diagonal then lies in `s` by convexity of `s`), or extend $t^3+3mt^2$ by its tangent line below $-m$, which is $C^1$ there since $g''(-m)=0$ and so convex on $\mathbb R$. Neither is in the layer.

**What L52 consumes is 1a itself.** `L52Statement.majorization_bound` is the lemma's display under hypotheses `hDmu`, `hKmu`, `hDom`, `hKom`, `hMp`, `hm`, `hp2mu`, `hp2om`, `hbispec`. The first two are `diag_doublyStochastic A hA`'s conclusion at `mu := hA.eigenvalues` and `K := fun i => A i i`, after rebuilding L52Statement's `DoublyStochastic` from `IsDoublyStochastic`'s three fields (the two structures are duplicates). A screen composing `diag_doublyStochastic` with `L52Statement.mu_side` for an arbitrary real symmetric `A` elaborated without error in two lines (`obtain`, then `mu_side ⟨hP.nonneg, hP.rows, hP.cols⟩ _ _ Mp hcap hd hp2`), leaving exactly `hcap` and `hp2` as hypotheses.

**The Owed clause.** It reads "instantiating it at the record's $K$ and $\mu$, which needs $K$ read as the diagonal of $M$ in a frame (L54Schur.lean's `Mpair`)". That is true of the $\mu$ half, and `Mpair`, `Mpair_diag` and `Mpair_isHermitian` already provide it. To state L52 itself the layer still needs:

1. the $\omega$ side: [SecondKind.lean](../lean/HamiltonsCubic/Results/SecondKind.lean) defines `ringW` on all matrices, and there is no matrix of $\mathring W$ in an orthonormal basis $\{\varphi_{ij},\psi_k\}$ of $S^2_0$, no $\psi$-stipulation that the $\psi_k$ diagonalise $K$ on $\mathbf1^\perp$, and no $\omega$ as its eigenvalues.
2. $p_2(\mu)=1$, the Frobenius norm of `Mpair R` equal to the sum of squared eigenvalues at the unit norm (r1411 gives the norm, the eigenvalue sum is unstated).
3. $p_2(\omega)=3$ (SecondKind's `trS2_ringW_sq` is over $S^2$, and the restriction to $S^2_0$ at a Weyl `R` is a further step).
4. `hbispec`, L50's identity, still a hypothesis.
5. the bridge between the two duplicate doubly stochastic structures, one line.

The row's "the convex bound in the form this row uses, $\sum g(A_{ii})\le\sum g(\lambda_j)$" repeats 2b and should point at `diag_doublyStochastic` instead. The row also joins clauses with semicolons, outside this review's file set.

## 3. DoublyStochastic.lean's docstring

The rewritten paragraph ("The spectral statement ... is proved in SchurMajor.lean") is accurate. Two earlier passages stand unchanged and disagree with the record's current L52 block:

- The title and "Karamata ... **It is not needed.**" are right for the inequality. For the equality clause the record says the "only if" half "does need Karamata".
- "Equality forces ... each row a point mass, so `U` is a permutation". Jensen equality under strict convexity forces $\mu_j$ constant on the support of row $i$, not a point mass, and the record's counterexample (a $\pi/4$ rotation inside a degenerate eigenplane) is row-tight and no permutation.

*A note for the owner, outside the verdict.* The shared-frame conclusion itself does follow from row tightness without Karamata. If every row of a doubly stochastic $P$ is supported on the level set of $\mu$ at the value $A_{ii}$, counting column mass per value shows the diagonal is a rearrangement of the spectrum, so $\sum A_{ii}^2=\sum\lambda_j^2=\lVert A\rVert_F^2$ and $A$ is diagonal. So the docstring's conclusion survives and its stated reason ("`U` is a permutation") does not. This bears on the record's "does need Karamata" and is routed to the L52 owner rather than decided here.

SchurMajor.lean's new docstring says the import was carried by "[L52](L52.lean)". L52.lean mentions neither double stochasticity nor Schur. The carrier is L52Statement.lean's `hDmu` and `hKmu`.

## 4. Axioms

Elaborated from the committed text (olean newer than the source at e44bb55b):

- `diag_doublyStochastic`: `[propext, Classical.choice, Quot.sound]`
- `diag_convex_le_spectrum`: `[propext, Classical.choice, Quot.sound]`
- `schur_majorizes`: `[propext, Classical.choice, Quot.sound]`

No `sorry` and no `native_decide` in either file.
