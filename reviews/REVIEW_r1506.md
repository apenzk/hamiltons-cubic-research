# Review r1506: L186's rank count unconditional in Lean

Gate 2 review of commit aeb1f1f4: the new [Results/L186Rank.lean](../lean/HamiltonsCubic/Results/L186Rank.lean) (`det_skew4`, `rank_ge_four`, `rank_le_two`, `gram_quad`, `gram_quad_nonneg`, `rank_le_of_pos`, `same_sign_rank_impossible`), and the record edits to [lean/INDEX.md](../lean/INDEX.md)'s L186 (statement) row (line 85) and I69 (Phi sphere) row (line 215), [diagonal-half.md](../findings/diagonal-half.md) line 669 and [conventions.md](../findings/conventions.md) line 125. One reviewer. Analysis-only rule inherited: the only compute was the module build ("Build completed successfully", 8719 jobs) and the axiom audit.

| item | claim | verdict |
| --- | --- | --- |
| A | `same_sign_rank_impossible` states diagonal-half.md's same-sign rank count, strengthened to need only $\omega_1$ non-decomposable, and "non-decomposable skew implies rank at least four" is right | CONFIRMED |
| B | `det_skew4`, `rank_ge_four`, `rank_le_two`, `rank_le_of_pos` and both sign cases are sound, no hypothesis unused or missing | CONFIRMED |
| C | r1505's C-1 is repaired and no edited sentence overstates | CONFIRMED WITH GAP |
| D | all declarations rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: `same_sign_rank_impossible` proves that $\sum_i\lambda_i\,\omega_i\omega_i^{\mathsf T}=0$ (the Ricci form $\mathrm{Ric}_{ab}=\sum_c W_{acbc}$ of $W=\sum\lambda_i\omega_i\otimes\omega_i$) with $\omega_1$ skew and non-decomposable, $\omega_3$ decomposable and $\lambda_1,\lambda_2$ of one sign is impossible, through $\mathop{\mathrm{rank}}\omega_1\ge4$ (a nonzero Plücker entry is a principal $4\times4$ Pfaffian, $\det=\mathrm{Pf}^2$) against $\mathop{\mathrm{rank}}(c\,\omega_3\omega_3^{\mathsf T})\le2$. Every step is sound, 7/7 declarations on the standard three axioms, and r1505's C-1 is repaired. One gap: C-1, [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean) lines 27 to 28 still say the passage from a non-decomposable form to rank at least four is in no file of the layer, which L186Rank.lean now contradicts. CONFIRMED WITH GAP.**

## A. Fidelity

- **The record.** [diagonal-half.md](../findings/diagonal-half.md) line 669: with $\omega_1,\omega_2$ non-decomposable, $\lambda_1,\lambda_2$ of one sign and $\omega_3$ decomposable, Ricci-flatness reads $\lvert\lambda_1\rvert\omega_1\omega_1^{\mathsf T}+\lvert\lambda_2\rvert\omega_2\omega_2^{\mathsf T}=\lvert\lambda_3\rvert\Pi_3$, rank at least four against rank two.
- **The Ricci form.** For $W_{abcd}=\sum_i\lambda_i(\omega_i)_{ab}(\omega_i)_{cd}$ the contraction $\sum_cW_{acbc}=\sum_i\lambda_i(\omega_i\omega_i^{\mathsf T})_{ab}$, so `hsum` is Ricci-flatness exactly. For a unit decomposable $\omega_3$, $\omega_3\omega_3^{\mathsf T}=\Pi_3$, and the record's form is `hsum` with the same-signed terms moved to one side. The Lean needs neither $\sum\lambda_i=0$ nor a sign of $\lambda_3$, since $c\,\omega_3\omega_3^{\mathsf T}$ has rank at most two for every real $c$ (`hr3`). That is a harmless weakening of the hypotheses.
- **Only $\omega_1$ non-decomposable.** $\mathop{\mathrm{rank}}(\lambda_1\omega_1\omega_1^{\mathsf T}+\lambda_2\omega_2\omega_2^{\mathsf T})\ge\mathop{\mathrm{rank}}\omega_1$ whenever $\lambda_1,\lambda_2$ share a sign, whatever $\omega_2$ is, so the record's hypothesis on $\omega_2$ is idle for the count. The strengthening is correct, and $\omega_2$ carries no hypothesis at all in the Lean (not even skewness), which is correct since $\omega_2\omega_2^{\mathsf T}$ is positive semidefinite for any real matrix. The record's "Positivity of BOTH weights is load-bearing" stays true: `hsign` constrains $\lambda_2$ as well.
- **Non-decomposable implies rank at least four.** A real skew matrix has even rank, rank $0$ is the zero form and rank $2$ is $u\wedge v$, both decomposable in the sense of `IsDecomp` ([L186Proof.lean](../lean/HamiltonsCubic/Results/L186Proof.lean) line 27, which includes $u=v=0$). So a skew non-decomposable form has rank at least four. Right.
- **Non-vacuity.** The conclusion is `False`, so the content is that the hypotheses are jointly unsatisfiable. Each is satisfiable alone: at $n\ge4$, $e_{12}+e_{34}$ is skew and non-decomposable, and any $u\wedge v$ is decomposable. The theorem is not true for a trivial reason.
- **CONFIRMED.**

## B. Soundness

- **`det_skew4`** (line 29). Laplace expansion along row zero with `Fin.sum_univ_succ`, zero diagonal and the six skew relations substituted, then `ring`. The target $(M_{01}M_{23}-M_{02}M_{13}+M_{03}M_{12})^2$ is the standard $\det=\mathrm{Pf}^2$ at $4\times4$. The kernel accepts it. **Sound.**
- **`rank_ge_four`** (line 40). `isDecomp_iff` (reviewed in r1504) turns non-decomposability into a tuple $(a,b,c,d)$ with $w_{ab}w_{cd}-w_{ac}w_{bd}+w_{ad}w_{bc}\ne0$ (`hw` removes the factor $2$ of `wedgeSelf`). $M$ is the submatrix at $e=(a,b,c,d)$, skew because $w$ is, and its Pfaffian is that bracket (`key`), so $\det M\ne0$, $M$ is a unit and `Matrix.rank_of_isUnit` gives rank $4$. Mathlib's `Matrix.rank_submatrix_le` (Mathlib/LinearAlgebra/Matrix/Rank.lean line 288) takes arbitrary maps `r : m₀ → m`, `c : n₀ → n`, so $e$ need not be injective. It is in fact injective whenever the bracket is nonzero (a repeated index makes it vanish by skewness), but the argument does not need that. **Sound.**
- **`rank_le_two`** (line 64). $uv^{\mathsf T}-vu^{\mathsf T}=UK$ with $U=[u\ v]$ ($n\times2$) and $K=[v^{\mathsf T};-u^{\mathsf T}]$, checked entrywise: $u_iv_j-v_iu_j$. Then `rank_mul_le_left` and `rank_le_card_width`. **Sound.**
- **`gram_quad`, `gram_quad_nonneg`** (lines 73, 77). $x^{\mathsf T}ww^{\mathsf T}x=\lVert w^{\mathsf T}x\rVert^2\ge0$. **Sound.**
- **`rank_le_of_pos`** (line 81). If $Sx=0$ then $\lambda_1q_1+\lambda_2q_2=0$ with $q_i\ge0$ and $\lambda_i>0$, so $q_1=0$ (`nlinarith`), so $w_1^{\mathsf T}x=0$ and $w_1w_1^{\mathsf T}x=0$. Hence $\ker S\le\ker(w_1w_1^{\mathsf T})$, and rank-nullity on the common domain $\mathbb R^n$ gives $\mathop{\mathrm{rank}}(w_1w_1^{\mathsf T})\le\mathop{\mathrm{rank}}S$, with `rank_self_mul_transpose` identifying the left side with $\mathop{\mathrm{rank}}w_1$. **Sound.**
- **`same_sign_rank_impossible`** (line 107). Positive case: `hsum` rearranges to $S=(-\lambda_3)\,\omega_3\omega_3^{\mathsf T}$, so $4\le\mathop{\mathrm{rank}}\omega_1\le\mathop{\mathrm{rank}}S\le2$. Negative case: negate, $(-\lambda_1)\omega_1\omega_1^{\mathsf T}+(-\lambda_2)\omega_2\omega_2^{\mathsf T}=\lambda_3\,\omega_3\omega_3^{\mathsf T}$, same count with $-\lambda_1,-\lambda_2>0$. `hr3` writes $c\,A=A\,(c\,I)$ and uses `rank_mul_le_left`. **Sound.**
- **Hypotheses.** `hskew` is used by `rank_ge_four` (skewness of $M$ for `det_skew4`), `hnd`, `h₃`, `hsign`, `hsum` are all used. None missing. No linter warning from this file in the build.
- **CONFIRMED.**

## C. Record accuracy

- **r1505's C-1 is repaired.** [conventions.md](../findings/conventions.md) line 125 drops the early "Kernel-checked at every $n$" sentence and replaces the contradictory "owed ... needs a $\Lambda^4$" tail with "The general-$n$ identity is `phi_sphere` in PhiSphereN.lean, by relabelling four-index sums with no $\Lambda^4$, and it has no numbered result of its own." The bullet now states one thing, and the clause-splicing semicolon went with the tail. "No numbered result of its own" matches the record: I69 in [plan.md](../plan.md) line 332 is a retired plan item, and no findings file numbers the identity.
- **The L186 (statement) row** ([lean/INDEX.md](../lean/INDEX.md) line 85). "The rank count is PROVED unconditionally ... needing only $\omega_1$ non-decomposable; standard three axioms." Accurate, "unconditionally" meaning without the rank hypotheses [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean) takes, as the commit says.
- **diagonal-half.md line 669.** "Kernel-checked as `same_sign_rank_impossible` in L186Rank.lean, with only $\omega_1$ non-decomposable." Accurate (A).
- **The I69 (Phi sphere) row** (line 215). Only the stray `*` after "`pf4` and `w4` are the auxiliaries." is removed. Correct.
- **Gap C-1: L186Statement.lean's module docstring is now stale.** Lines 27 to 28, under "What is NOT typed here", say "the passage from a non-decomposable `2`-form to `rank ≥ 4`. Both are standard and neither is in this layer." `rank_ge_four` now puts that passage in the layer, and the commit did not touch the file. No edited sentence overstates, but a reader of L186Statement.lean meets a claim the commit falsified. The repair is to point that bullet at `rank_ge_four` and `rank_le_of_pos` in L186Rank.lean, and to do the same for the docstring of the rank lemma at lines 98 to 100 ("the range identity itself is standard and external").
- **The commit message** describes the edits as made. "7 declarations" matches the audit. STATUS.md and plan-lean.md change only the file count, 778 to 779.
- **CONFIRMED WITH GAP.**

## D. Axioms

- `python3 scripts/misc/axiom_audit.py --only L186Rank`: "auditing 7 declarations across 1 files ... 7/7 clean -- resting on the standard three alone".
- **CONFIRMED.**

## E. Style

- No em dash in any added line of the commit (grep count 0).
- No backticks inside markdown link text in the added lines (grep for ``[` `` count 0).
- The edited INDEX rows, the diagonal-half.md paragraph and the conventions.md bullet are single lines. No hard wrap.
- The semicolons in the L186 row ("rank_le_of_pos; and", "non-decomposable; standard three axioms") separate list items that carry commas, the pattern r1499 to r1505 passed.
- *Note, pre-existing, not introduced here:* the I69 row still carries the second unmatched `*` r1505 noted, before "The Lefschetz step itself is not typed", which opens an italic that never closes before "**statement: typed**". The commit message's "The stray asterisk in the I69 row is gone" is true of the one it names.
- **CONFIRMED.**

## Overall

**CONFIRMED WITH GAP.** `same_sign_rank_impossible` kernel-checks diagonal-half.md's same-sign rank count on the Ricci form $\sum\lambda_i\omega_i\omega_i^{\mathsf T}=0$, correctly strengthened to need only $\omega_1$ non-decomposable, through `rank_ge_four` ($\det=\mathrm{Pf}^2$ on a principal block, index distinctness not needed), `rank_le_two` and `rank_le_of_pos`. Every step is sound, 7/7 declarations on the standard three axioms, and r1505's C-1 is repaired. Gap C-1: [L186Statement.lean](../lean/HamiltonsCubic/Results/L186Statement.lean) lines 27 to 28 (and the docstring at lines 98 to 100) still say the non-decomposable-to-rank-four passage is outside the layer, which L186Rank.lean now contradicts.
