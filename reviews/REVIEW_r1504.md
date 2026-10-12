# Review r1504: L186 in Lean, one non-decomposable image form is impossible

Gate 2 review of commit 1d0501e4: the new [Results/L186Proof.lean](../lean/HamiltonsCubic/Results/L186Proof.lean) (`IsDecomp`, `wedgeSelf_of_decomp`, `decomp_of_wedgeSelf`, `isDecomp_iff`, `L186`), and the record edits to [lean/INDEX.md](../lean/INDEX.md)'s L186 (statement) row (line 85) and to [diagonal-half.md](../findings/diagonal-half.md) Lemma L186 (line 663). One reviewer. Analysis-only rule inherited: the only compute was the module build ("Build completed successfully", 8714 jobs, no warning from L186Proof.lean on a fresh `lake env lean`) and the axiom audit.

| item | claim | verdict |
| --- | --- | --- |
| A | `L186` states diagonal-half.md's Lemma L186 in a general-rank form with fewer hypotheses, `IsDecomp` is the record's "decomposable" and `wedgeSelf` its $\omega\wedge\omega$ | CONFIRMED |
| B | the forward direction, the Plücker converse (skewness not assumed), the zero case and `L186` are sound | CONFIRMED |
| C | no edited sentence overstates, and the L186 row's "proved" is justified | CONFIRMED |
| D | all declarations rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: `isDecomp_iff` proves that a real square matrix is $uv^{\mathsf T}-vu^{\mathsf T}$ exactly when $X_{ab}X_{cd}-X_{ac}X_{bd}+X_{ad}X_{bc}=0$ at every index tuple, the converse by $u=\mathrm{row}_a/X_{ab}$, $v=\mathrm{row}_b$, and correct without a skewness hypothesis since the relation at $a=b$ and its neighbours already forces skewness when $X\ne0$. `L186` then reads first Bianchi for `rankSumOp λ ω` through `bianchi_iff_wedge` and collapses the sum to $\lambda_i\,\omega_i\wedge\omega_i=0$ with `Finset.sum_eq_single`, at every rank and without Ricci-flatness or orthonormality, which is the record's own remark that these are unused. 4/4 declarations on the standard three axioms. One note, no gap: the passage from "a rank-three Weyl tensor" to the spectral form $\sum\lambda_i\omega_i\otimes\omega_i$ is untyped, as in r1503. CONFIRMED.**

## A. Fidelity

- **The record.** [diagonal-half.md](../findings/diagonal-half.md) line 661 (the statement): *"There is no rank-three Weyl tensor with exactly one non-decomposable image form."* Proof, line 663: L179(b) gives $\sum_i\lambda_i\,\omega_i\wedge\omega_i=0$, decomposable is $\omega\wedge\omega=0$, so the identity collapses to $\lambda_1\,\omega_1\wedge\omega_1=0$ with $\lambda_1\ne0$.
- **`L186`** ([L186Proof.lean](../lean/HamiltonsCubic/Results/L186Proof.lean) line 58) takes `lam : Fin r → ℝ`, skew `om : Fin r → Matrix ι ι ℝ`, first Bianchi for `rankSumOp lam om` at every index tuple, an index `i` with `lam i ≠ 0` and `IsDecomp (om j)` for every `j ≠ i`, and concludes `IsDecomp (om i)`. At $r=3$ with all $\lambda_i\ne0$ this is the contrapositive of "exactly one non-decomposable": whichever form is the non-decomposable one, the other two being decomposable force it decomposable.
- **Fewer hypotheses than the record.** No Ricci-flatness, no orthonormality, no sign or rank condition, arbitrary rank $r$, and $\lambda_j$ unrestricted for $j\ne i$. A strengthening, and exactly the record's own block at line 665, "Ricci-flatness, orthonormality, the signs, the ranks and the support are all unused."
- **`IsDecomp` is the record's "decomposable".** `IsDecomp X := ∃ u v, X = vecMulVec u v - vecMulVec v u` is $X=uv^{\mathsf T}-vu^{\mathsf T}$, the layer's matrix of $u\wedge v$ (the same shape as r1503's `dform`). It includes $X=0$ ($u=v=0$), which does not matter here because an image form at a nonzero weight is nonzero, and the conclusion "decomposable" is only strengthened by admitting zero.
- **`wedgeSelf` is the record's $\omega\wedge\omega$.** [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) line 105 defines it as `wedge2 X X = halfw X X + halfw X X`, and `wedgeSelf_apply` (line 111) gives $2(X_{ab}X_{cd}-X_{ac}X_{bd}+X_{ad}X_{bc})$. This is the layer's fixed normalisation, twice the Pfaffian quadratic, which diagonal-half.md line 641 records. Vanishing is scale-free, so the factor $2$ does not touch the lemma.
- *Note, no gap:* the record's statement is about a rank-three Weyl tensor, and the typed statement is about $W=\sum\lambda_i\omega_i\otimes\omega_i$ with skew $\omega_i$. The bridge (the spectral theorem on $\Lambda^2$) is untyped, and the record's proof starts from the spectral form too. The same note stood in r1503.
- **CONFIRMED.**

## B. Soundness

- **`wedgeSelf_of_decomp`** (line 30). With $X_{ab}=u_av_b-v_au_b$, the expression $X_{ab}X_{cd}-X_{ac}X_{bd}+X_{ad}X_{bc}$ is the Plücker relation of the $2\times4$ matrix with rows $u,v$ at columns $a,b,c,d$, identically zero. After unfolding `wedgeSelf`, `wedge2`, `halfw` and `vecMulVec_apply`, `ring` closes it. **Sound.**
- **`decomp_of_wedgeSelf`** (line 36), nonzero case. Pick $X_{ab}\ne0$ and set $u_c=X_{ac}/X_{ab}$, $v_d=X_{bd}$. Then $(uv^{\mathsf T}-vu^{\mathsf T})_{cd}=(X_{ac}X_{bd}-X_{bc}X_{ad})/X_{ab}$. The hypothesis at $(a,b,c,d)$, unfolded to `hp`, is $2(X_{ab}X_{cd}-X_{ac}X_{bd}+X_{ad}X_{bc})=0$ (the two halves added), so $X_{ab}X_{cd}=X_{ac}X_{bd}-X_{ad}X_{bc}$, which is the required entry after `field_simp` clears $X_{ab}$ and `linarith` uses `hp`. Only the one relation per entry is used. **Sound.**
- **Skewness is not assumed, and the converse is still true.** The Lean proof itself shows the relations force $X=uv^{\mathsf T}-vu^{\mathsf T}$, hence skew. Checked by hand as a screen of the claim: at $a=b$ the relation reads $X_{aa}X_{cd}=0$, so a nonzero $X$ has zero diagonal, and at $c=a$ it reads $X_{ad}(X_{ab}+X_{ba})-X_{aa}X_{bd}=0$, pushing toward $X_{ba}=-X_{ab}$. A non-skew example such as $X=e_1e_2^{\mathsf T}$ fails the relation at $(1,2,1,2)$ ($1-0+0=1$). So the equivalence holds on all real square matrices, and dropping the skewness hypothesis is a generalisation.
- **Zero case** (line 46). `push Not` gives $X_{cd}=0$ everywhere, and $u=v=0$ works. **Sound.**
- **`L186`** (line 58). `bianchi_iff_wedge` ([L179Statement.lean](../lean/HamiltonsCubic/Results/L179Statement.lean) line 217, needing `hskew`) turns `hB` into $\sum_{\lambda_j\ne0}\lambda_j\,\omega_j\wedge\omega_j=0$ componentwise. `bianchi_sum_filter` (line 208) rewrites the filtered sum as the full sum over `Fin r` (the dropped terms have $\lambda_j=0$). `Finset.sum_eq_single i` kills every $j\ne i$ through `wedgeSelf_of_decomp (hothers j hj)` and `mul_zero`, and the membership side-goal is `mem_univ`. So $\lambda_i\,(\omega_i\wedge\omega_i)_{abcd}=0$, and `mul_eq_zero` with `hi` gives $(\omega_i\wedge\omega_i)_{abcd}=0$ at every tuple, which `decomp_of_wedgeSelf` turns into `IsDecomp (om i)`. **Sound.**
- **Hypotheses.** `hskew` feeds `bianchi_iff_wedge`, `hB` is the Bianchi input, `hi` is the final cancellation, `hothers` kills the other terms. None unused, none missing. The `[Fintype ι] [DecidableEq ι]` instances are required by `bianchi` and `rankSumOp`. No linter warning is raised by this file.
- **CONFIRMED.**

## C. Record accuracy

- **The L186 (statement) row** ([lean/INDEX.md](../lean/INDEX.md) line 85). The state moves from partial to **proved** and the file column adds L186Proof.lean. The new sentence, "The branch it bounds holds no Weyl tensor, and that is PROVED in L186Proof.lean: `isDecomp_iff`, a $2$-form is decomposable exactly when $\omega\wedge\omega=0$, the converse by the Plücker relation at a nonzero entry (`decomp_of_wedgeSelf`); and `L186`, with `bianchi_iff_wedge`, first Bianchi collapses to $\lambda_i\omega_i\wedge\omega_i=0$ and forces $\omega_i$ decomposable at every rank; standard three axioms", describes the typed theorems exactly. The retained Gate 2 sentences are about L186Statement.lean and remain true of it. The lemma as the record states it follows from `L186` at $r=3$ with no `sorry`, so **proved** is justified, subject to the spectral-form note in A, which is the record's own starting point.
- **diagonal-half.md line 663.** "*Kernel-checked as `L186` in L186Proof.lean, with $\omega\wedge\omega=0\iff$ decomposable as `isDecomp_iff`.*" Accurate, and it does not claim the Weyl-to-spectral bridge.
- **The commit message** describes the edits as made. "4 declarations" matches the audit. STATUS.md and plan-lean.md change only the file count, 776 to 777. **CONFIRMED.**

## D. Axioms

- `python3 scripts/misc/axiom_audit.py --only L186Proof`: "auditing 4 declarations across 1 files … 4/4 clean -- resting on the standard three alone". The `def IsDecomp` carries no axioms.
- **CONFIRMED.**

## E. Style

- No em dash in any added markdown line of the commit (grep count 0). The `−` in the Lean docstrings is the minus sign U+2212.
- No backticks inside markdown link text in the added lines (grep for ``[` `` count 0).
- The edited INDEX row and the diagonal-half.md line are single lines. No hard wrap.
- The two semicolons in the INDEX row separate list entries that carry commas ("…(`decomp_of_wedgeSelf`); and `L186`, …; standard three axioms"), the pattern r1499 to r1503 passed. **CONFIRMED.**

## Overall

**CONFIRMED.** `L186` kernel-checks diagonal-half.md's Lemma L186 at every rank, with Ricci-flatness, orthonormality and signs all dropped, as the record's own remark says they can be. `isDecomp_iff` is the Plücker criterion on arbitrary real square matrices, true without a skewness hypothesis. Every step is sound, the L186 row's **proved** is justified, and all 4 declarations rest on the standard three axioms. Note, no gap: the bridge from a rank-three Weyl operator to its spectral form $\sum\lambda_i\omega_i\otimes\omega_i$ is untyped, as for L185.
