# REVIEW r1471: L225 in matrix form in Lean, commit b6c17d30: matrix_cube_le, matrix_cube_attained, trace_diagonal_pow, the L225 statement row, the L225Statement docstring and the second-order.md citation

Log [agent_logs/r1471.log](../agent_logs/r1471.log). One reviewer, working cold and adversarially. Analysis-only: `lake build HamiltonsCubic.Results.L225Matrix` and one scratch file in the session scratchpad outside the repository holding the `#print axioms` and `#check` calls. No numerical screen was run, since every check here is by reading the statements and the proofs.

**Standfirst.** The module builds with no warning of its own, and all three declarations rest on `propext`, `Classical.choice` and `Quot.sound` alone. `matrix_cube_le` is the record's bound at $\lvert M^0\rvert=1$: over $\mathbb R$, `IsHermitian` is $M^{\mathsf T}=M$, and for such $M$, $\mathop{\mathrm{tr}}M^2=\sum_{ij}M_{ij}^2$ is the squared Frobenius norm the record names. The proof is a correct transfer through `trace_pow_eq_sum_eigenvalues` at exponents 1, 2 and 3 into the already proved `cube_sum_le`. `matrix_cube_attained` exhibits the record's extremal matrix at $u=e_{i_0}$. What the commit does not deliver is the record's matrix-level equality clause, "equality exactly when $M^0=\lvert M^0\rvert(\tfrac kc uu^{\mathsf T}-\tfrac1cI)$", and the row nonetheless says "Nothing owed" (G1). The unnormalised form, which the new file's own title advertises, is not stated (G2), and the new file's docstring quotes as current an owed clause the same commit deletes (G3).

| Item | Verdict | Reason |
| --- | --- | --- |
| A. Fidelity | CONFIRMED WITH GAP | `trace (M^2) = 1` is $\lvert M^0\rvert_F=1$ for a real symmetric matrix, `IsHermitian` over $\mathbb R$ is symmetry, and $c>0$ with $c^2=k(k-1)$ pins $c=\sqrt{k(k-1)}$. The unnormalised $\lvert M^0\rvert^3$ form follows by homogeneity but is not stated, while L225Matrix.lean:7 titles the file with it (G2) |
| B. Sharpness | CONFIRMED WITH GAP | `matrix_cube_attained` is the record's equality matrix at $u=e_{i_0}$: $\tfrac kc e_{i_0}e_{i_0}^{\mathsf T}-\tfrac1cI$ is the diagonal with $\tfrac{k-1}c$ at $i_0$ and $-\tfrac1c$ elsewhere. The matrix "only when" is unproved, and so is the $k=3$ equality clause (G1) |
| C. Proofs | CONFIRMED | `trace_pow_eq_sum_eigenvalues` is used at the right exponents with the same `hM`, so the eigenvalue function is one object across the three rewrites. The `pow_one` pair is correct. `trace_diagonal_pow` is `diagonal_pow` plus `trace_diagonal` |
| D. Axioms | CONFIRMED | `matrix_cube_le`, `matrix_cube_attained`, `trace_diagonal_pow`: `[propext, Classical.choice, Quot.sound]` each |
| E. Record text | CONFIRMED WITH GAP | "Nothing owed" at lean/INDEX.md:121 and "Machine-checked, both forms" at findings/second-order.md:1286 overstate coverage of the matrix form (G1). L225Matrix.lean:9-11 quotes a deleted owed clause in the present tense (G3). No em dash in the diff, and every semicolon it adds separates list items or Lean tactics |

**Summary: CONFIRMED WITH GAP, the matrix bound and its attainment are proved faithfully at unit Frobenius norm, and the record text claims the matrix-level equality characterisation and the unnormalised form, neither of which is typed.**

## A. Fidelity

**The record's claim, quoted from source** (findings/second-order.md:1284): *"Applied to the eigenvalues of a trace-free symmetric $k\times k$ matrix $M^0$ with Frobenius norm $\lvert M^0\rvert$, this reads $\mathop{\mathrm{tr}}\big((M^0)^3\big)\le\frac{k-2}{\sqrt{k(k-1)}}\lvert M^0\rvert^3$, with equality exactly when $M^0=\lvert M^0\rvert\big(\tfrac kc\,uu^{\mathsf T}-\tfrac1cI\big)$ for a unit vector $u$. At $k=3$: $\mathop{\mathrm{tr}}\big((M^0)^3\big)\le\tfrac1{\sqrt6}\lvert M^0\rvert^3$, with equality exactly at nonnegative multiples of $\mathop{\mathrm{diag}}(2,-1,-1)$ in some orthonormal frame."*

The theorem as elaborated (`#check`): for `M : Matrix ι ι ℝ` with `M.IsHermitian`, `0 < c`, `c ^ 2 = card ι * (card ι - 1)`, `2 ≤ card ι`, `M.trace = 0` and `(M ^ 2).trace = 1`, it concludes `(M ^ 3).trace ≤ (card ι - 2) / c`.

- **Norm.** $\mathop{\mathrm{tr}}M^2=\sum_{i,j}M_{ij}M_{ji}$, and with $M_{ji}=M_{ij}$ this is $\sum_{i,j}M_{ij}^2=\lvert M\rvert_F^2$. So `(M ^ 2).trace = 1` is exactly $\lvert M^0\rvert=1$ in the record's Frobenius norm. The record uses no other normalisation (no $\tfrac12$ factor), so the constant matches.
- **Symmetry.** `IsHermitian` is `Mᴴ = M`, and `conjTranspose` over $\mathbb R$ applies the trivial `star` entrywise, so it is $M^{\mathsf T}=M$.
- **Constant.** $c>0$ and $c^2=k(k-1)$ force $c=\sqrt{k(k-1)}$, so a free `c` loses nothing. $k\ge2$ is the record's range.
- **Homogeneity (G2).** For $M^0\ne0$, $N=M^0/\lvert M^0\rvert$ is symmetric with $\mathop{\mathrm{tr}}N=0$ and $\mathop{\mathrm{tr}}N^2=1$, and $\mathop{\mathrm{tr}}N^3=\mathop{\mathrm{tr}}(M^0)^3/\lvert M^0\rvert^3$, so the unit bound gives the record's form. At $M^0=0$ both sides are $0$. *Argued against:* the step is two lines, so omitting it is not a mathematical gap. *It stands as a record gap* because L225Matrix.lean:7 heads the file `tr(M⁰)³ ≤ (k − 2)/√(k(k − 1)) ‖M⁰‖³`, which is not a statement in the file, and the row says "Nothing owed". Either the scaled statement is typed or the owed list names it.

## B. Sharpness

- **Attainment.** The witness is `diagonal (fun j => if j = i₀ then (k-1)/c else -1/c)`. The record's extremal matrix at unit norm and $u=e_{i_0}$ is $\tfrac kc e_{i_0}e_{i_0}^{\mathsf T}-\tfrac1cI$, whose $i_0$ entry is $\tfrac{k-1}c$ and whose other diagonal entries are $-\tfrac1c$. They agree. Every other $u$ is an orthogonal conjugate, which is the record's "for a unit vector $u$", and a single witness suffices for sharpness. The theorem drops `2 ≤ card ι`, which is harmless: at card $0$ or $1$, $c^2=0$ contradicts $c>0$.
- **The "only when" (G1).** The record claims equality *exactly* at $\lvert M^0\rvert(\tfrac kc uu^{\mathsf T}-\tfrac1cI)$, and at $k=3$ exactly at nonnegative multiples of $\mathop{\mathrm{diag}}(2,-1,-1)$ in some frame. No declaration in L225Matrix.lean states either. The vector equality case (`cube_sum_eq`, `cube_sum_eq_card`) gives only that the eigenvalues are one $\alpha$ and $k-1$ copies of $-\beta$. Turning that into the rank-one form needs the reconstruction $M=U\mathop{\mathrm{diag}}(\lambda)U^{\mathsf T}$, the identification $\mathop{\mathrm{diag}}(\lambda)=(\alpha+\beta)e e^{\mathsf T}-\beta I$ with $\alpha+\beta=\tfrac kc$, and the conjugated vector $u=Ue$ being a unit vector, plus the homogeneity scaling. *Argued against:* the old row said the matrix form "needs only the spectral theorem", and the reconstruction is routine. *It stands* because routine is not typed: the record states a matrix-level characterisation, the row claims nothing is owed, and the Lean file carries only the inequality and one attaining matrix.

## C. Proofs

- **`matrix_cube_le`.** `e1`, `e2`, `e3` are `trace_pow_eq_sum_eigenvalues M hM` at $1,2,3$, all against `hM.eigenvalues`, the same function passed to `cube_sum_le`. `rw [pow_one] at e1` rewrites the outer `M ^ 1` to `M`. The summand `hM.eigenvalues j ^ 1` sits under the `∑` binder, which `rw` cannot reach, and `simp only [pow_one] at e1` clears it. The side goals `∑ λ = 0` and `∑ λ² = 1` close by `rw [← e1, h1]` and `rw [← e2, h2]`, and `rw [e3]` puts the goal into `cube_sum_le`'s conclusion. Correct.
- **`trace_diagonal_pow`.** `diagonal_pow` gives `diagonal (v ^ n)`, `trace_diagonal` gives `∑ j, (v ^ n) j`, and `rfl` closes the pointwise power. Correct.
- **`matrix_cube_attained`.** Hermitian by `isHermitian_diagonal_of_self_adjoint` with `star` trivial on $\mathbb R$, and the three traces reduce to `cube_sum_attained`'s three sums. Correct.
- **Upstream.** `trace_pow_eq_sum_eigenvalues` (SpectralTrace.lean:27) goes through Mathlib's `spectral_theorem` and was built in the same run.

## D. Axioms

`lake build HamiltonsCubic.Results.L225Matrix` completed, with no warning from the file. The scratch file printed:

- `matrix_cube_le` depends on axioms: `[propext, Classical.choice, Quot.sound]`
- `matrix_cube_attained` depends on axioms: `[propext, Classical.choice, Quot.sound]`
- `trace_diagonal_pow` depends on axioms: `[propext, Classical.choice, Quot.sound]`

No `sorry`, no `native_decide`.

## E. Record text

- **G1, "Nothing owed" (lean/INDEX.md:121).** The row describes `matrix_cube_le` and `matrix_cube_attained` accurately, including the unit normalisation, and then says "Nothing owed". Per B, the matrix equality characterisation and the $k=3$ equality clause are owed, and per A the unnormalised form is too. The citation at findings/second-order.md:1286, *"Machine-checked, both forms: the vector bound, its equality case and its attainment in L225Statement.lean, and the matrix bound with its sharpness in L225Matrix.lean"*, is literally accurate, since it credits the equality case only to the vector form. *Argued against:* a careful reader sees the asymmetry. *It stands* for the row, whose "Nothing owed" is flatly false against the record's statement, and it is noted for the citation, whose "both forms" reads as full coverage.
- **G3, stale quotation (L225Matrix.lean:9-11).** The docstring says L225Statement.lean *"owes 'the matrix form, which needs only the spectral theorem carrying a symmetric matrix to its eigenvalues'"*. That clause was the INDEX row's, and this commit replaced it, so the file quotes in the present tense an owed item that no longer exists anywhere. *Argued against:* it reads as the motivation for the file. *It stands* as a minor wording gap, since a reader following the quote finds no such text.
- **L225Statement docstring** (L225Statement.lean:24). The replacement sentence names both theorems and links correctly.
- **Links.** `../lean/HamiltonsCubic/Results/L225Matrix.lean` from findings/ and `HamiltonsCubic/Results/L225Matrix.lean` from lean/ resolve. The module is imported at lean/HamiltonsCubic.lean:618.
- **Punctuation.** The diff adds no em dash. "Case–Tyrrell" and "Cauchy–Schwarz" carry en dashes in names. The added semicolons are in the row's list of items that already carry commas, in a docstring bullet, and between Lean tactics, so none splices two clauses.

## Gaps

- **G1** (lean/INDEX.md:121, with findings/second-order.md:1286): "Nothing owed" while the record's matrix-level "equality exactly when $M^0=\lvert M^0\rvert(\tfrac kc uu^{\mathsf T}-\tfrac1cI)$" and its $k=3$ equality clause are unproved in Lean.
- **G2** (L225Matrix.lean:7, lean/INDEX.md:121): the unnormalised $\lvert M^0\rvert^3$ form is the file's title and the record's statement, and it is neither typed nor listed as owed.
- **G3** (L225Matrix.lean:9-11): the docstring quotes the deleted owed clause as current.

**Verdict: CONFIRMED WITH GAP.**
