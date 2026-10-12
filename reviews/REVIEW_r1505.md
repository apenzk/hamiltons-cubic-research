# Review r1505: the Phi sphere identity at every n in Lean

Gate 2 review of commit 86ee0fc0: the new [Results/PhiSphereN.lean](../lean/HamiltonsCubic/Results/PhiSphereN.lean) (`w4n`, `sum4_swap_bc`, `sum4_swap_cd`, `sum4_prod`, `trace_pow_four_eq`, `skew_entry`, `phi_sphere`), and the record edits to [lean/INDEX.md](../lean/INDEX.md)'s L194 (statement) row (line 214) and I69 (Phi sphere) row (line 215) and to [conventions.md](../findings/conventions.md) line 125. One reviewer. Analysis-only rule inherited: the only compute was the module build ("Build completed successfully", 8708 jobs, no warning from PhiSphereN.lean on a fresh `lake env lean`) and the axiom audit.

| item | claim | verdict |
| --- | --- | --- |
| A | `phi_sphere` states conventions.md's $\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2=2\langle\omega,\omega\rangle^2$ at every skew $\omega$ and every $n$, and agrees with `trace_pow_four_add_pf_sq` and `phi_sphere6` | CONFIRMED |
| B | the relabellings, the trace expansion, the three squares, the three cross terms and the final arithmetic are sound, no hypothesis unused or missing | CONFIRMED |
| C | no edited sentence overstates | CONFIRMED WITH GAP |
| D | all declarations rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | no em dash, no clause-splicing semicolon, no backticks in link text, no hard-wrapped markdown prose | CONFIRMED |

**Summary: `phi_sphere` proves $\operatorname{tr}(\omega^4)+\tfrac16\sum_{abcd}w_4(a,b,c,d)^2=2\,\mathrm{inner2}(\omega,\omega)^2$ for every skew real $n\times n$ matrix, where $\tfrac16\sum_{abcd}w_4^2$ equals $\lVert\omega\wedge\omega\rVert_\perp^2=\sum_{a<b<c<d}(2w_4)^2$ because $w_4$ is alternating and vanishes on repeated indices, and $\mathrm{inner2}(\omega,\omega)=\tfrac12\sum\omega_{ab}^2$ is the record's $\langle\omega,\omega\rangle$. The expansion $\sum w_4^2=3S^2-6Q$ checks by hand term by term. 6/6 declarations on the standard three axioms. One gap: C-1, the tail of the edited conventions.md bullet (line 125) still says the general-$n$ proof "is owed a numbered result and a Lean statement, which needs a $\Lambda^4$ the layer carries at no $n$", contradicting the sentence the commit added to the same bullet. CONFIRMED WITH GAP.**

## A. Fidelity

- **The record.** [conventions.md](../findings/conventions.md) line 125: $\operatorname{tr}(\omega^4)+\lVert\omega\wedge\omega\rVert_\perp^2=2\langle\omega,\omega\rangle^2$ at every skew $\omega$ and every $n$, with $\lVert\cdot\rVert_\perp$ the multi-index-orthonormal norm $\sum_{i<j<k<l}$ on $\Lambda^4$.
- **The wedge factor.** [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) line 105 defines `wedgeSelf`, and `wedgeSelf_apply` (line 111) gives $(\omega\wedge\omega)_{abcd}=2(\omega_{ab}\omega_{cd}-\omega_{ac}\omega_{bd}+\omega_{ad}\omega_{bc})=2\,w_4(a,b,c,d)$, with `w4n` ([PhiSphereN.lean](../lean/HamiltonsCubic/Results/PhiSphereN.lean) line 27) the bracket exactly.
- **The norm conversion, checked by hand.** For skew $\omega$, $w_4$ changes sign under each transposition of adjacent indices: swapping $c,d$ sends the three terms to $\omega_{ab}\omega_{dc}-\omega_{ad}\omega_{bc}+\omega_{ac}\omega_{bd}=-w_4$, and swapping $a,b$ or $b,c$ likewise. At a repeated index, e.g. $a=b$, it reads $\omega_{aa}\omega_{cd}-\omega_{ac}\omega_{ad}+\omega_{ad}\omega_{ac}=0$. So $\sum_{\text{all}}w_4^2=24\sum_{a<b<c<d}w_4^2$ and $\lVert\omega\wedge\omega\rVert_\perp^2=\sum_{a<b<c<d}4w_4^2=\tfrac16\sum_{\text{all}}w_4^2$. The statement's left side is the record's.
- **`inner2` is the record's $\langle\omega,\omega\rangle$.** [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) line 39: $\mathrm{inner2}(X,Y)=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\mathrm{inner2}(\omega,\omega)=\tfrac12\sum\omega_{ab}^2$, which at the normal form $\omega=\sum\sigma_i e_{2i-1,2i}$ is $\sum\sigma_i^2$, the record's normalisation ("with $\sum\sigma_i^2=1$"). PhiSphereN.lean sits in `HamiltonsCubic.RealLayer`, the namespace of that definition.
- **Agreement at $n=4$ and $n=6$.** At $n=4$ every nonzero $w_4$ is $\pm$`pf4`$(\omega)$ at the $24$ orderings of $(0,1,2,3)$, so $\tfrac16\sum w_4^2=4\,\mathrm{pf4}^2$, the term in `trace_pow_four_add_pf_sq` ([PhiSphere.lean](../lean/HamiltonsCubic/Results/PhiSphere.lean) line 41). At $n=6$, `w4` (line 55) is the same bracket and `phi_sphere6` (line 64) carries $4\sum_{a<b<c<d}w_4^2$ over the fifteen sorted quadruples, which equals $\tfrac16\sum_{\text{all}}w_4^2$ by the conversion above. Screen at $\omega=\sigma_1e_{12}+\sigma_2e_{34}$: $2\sigma_1^4+2\sigma_2^4+4\sigma_1^2\sigma_2^2=2(\sigma_1^2+\sigma_2^2)^2$.
- *Note, no gap:* the bridge from `(1/6) * ∑ all w4n²` to $\lVert\omega\wedge\omega\rVert_\perp^2$ (alternation of `w4n` and the factor $24$) is prose in the docstring and the record, not a typed lemma. It is elementary and correct as checked above.
- **CONFIRMED.**

## B. Soundness

- **Relabellings.** `sum4_swap_bc` (line 32) applies `Finset.sum_comm` to the $b,c$ pair inside a fixed $a$, and `sum4_swap_cd` (line 35) to the $c,d$ pair inside fixed $a,b$. Both are bijective reindexings of finite sums. `sum4_prod` (line 38) is $\sum_{abcd}g_{ab}h_{cd}=(\sum g)(\sum h)$ by distributing `sum_mul` and `mul_sum` level by level. **Sound.**
- **`trace_pow_four_eq`** (line 53). After `pow_succ` and `mul_apply` the trace is $\sum_a\sum_d\sum_c\sum_b\omega_{ab}\omega_{bc}\omega_{cd}\omega_{da}$ with the three inner indices in reverse order, and the three `sum_comm` rewrites permute them to $b,c,d$. Any order is correct by Fubini on a finite type, and the kernel accepts the specific rewrites. **Sound.**
- **Squares.** $E_1=\sum(\omega_{ab}\omega_{cd})^2=S^2$ directly by `sum4_prod`. $E_2=\sum(\omega_{ac}\omega_{bd})^2$ becomes $\sum(\omega_{ab}\omega_{cd})^2$ after swapping $b,c$. $E_3=\sum(\omega_{ad}\omega_{bc})^2$ after swapping $c,d$ then $b,c$. Each is $S^2$ without skewness. **Sound.**
- **Cross terms, checked by hand.** $X_1=\sum\omega_{ab}\omega_{cd}\omega_{ac}\omega_{bd}$: the cycle $a\to b\to d\to c\to a$ gives $\omega_{ab}\omega_{bd}\omega_{dc}\omega_{ca}=\omega_{ab}\omega_{bd}\omega_{cd}\omega_{ac}$ under two sign flips, so $X_1=Q$. $X_2=\sum\omega_{ab}\omega_{cd}\omega_{ad}\omega_{bc}$ is the cycle $a\to b\to c\to d\to a$ with one flip $\omega_{da}=-\omega_{ad}$, so $X_2=-Q$. $X_3=\sum\omega_{ac}\omega_{bd}\omega_{ad}\omega_{bc}$ is the cycle $a\to c\to b\to d\to a$ with two flips, so $X_3=Q$. The Lean proofs apply the matching relabel and the matching `skew_entry` rewrites (`hs c d, hs a d`, then `hs a d`, then `hs c b, hs a d`) before `ring`. **Sound.**
- **Expansion and arithmetic.** `hexp` (line 102) is $(x-y+z)^2=x^2+y^2+z^2-2xy+2xz-2yz$ with $x,y,z$ the three products, by `ring`. So $\sum w_4^2=3S^2-2Q+2(-Q)-2Q=3S^2-6Q$, and $Q+\tfrac16(3S^2-6Q)=\tfrac12S^2=2(S/2)^2=2\,\mathrm{inner2}(\omega,\omega)^2$ via `hin` (line 71). **Sound.**
- **Hypotheses.** `hw` is used through `skew_entry` in the three cross terms, which is where skewness is needed. No hypothesis is unused, none missing. No linter warning from this file.
- **CONFIRMED.**

## C. Record accuracy

- **The I69 (Phi sphere) row** ([lean/INDEX.md](../lean/INDEX.md) line 215). It adds PhiSphereN.lean to the file column and replaces "WHAT IT DOES NOT STATE: the identity at general $n$" with "THE IDENTITY AT EVERY $n$ IS PROVED ... `phi_sphere`, $\operatorname{tr}(\omega^4)+\tfrac16\sum_{abcd}w_4^2=2\langle\omega,\omega\rangle^2$ for every skew $\omega$, the $\tfrac16\sum$ being $\lVert\omega\wedge\omega\rVert_\perp^2$ over all index quadruples ...; standard three axioms". Accurate, and the identification is the correct one (A).
- **The L194 (statement) row** (line 214). "that $\Phi(\omega)$ has constant norm, which is that identity's, now proved at every $n$ as `phi_sphere`". Accurate.
- **conventions.md line 125.** The added sentence, "Kernel-checked at every $n$ as `phi_sphere` in PhiSphereN.lean", is accurate.
- **Gap C-1: the same bullet is left contradicting itself.** Its unedited tail still reads "PhiSphere.lean proves the identity at $\dim=4$ and $\dim=6$; *the general-$n$ proof is four lines from the normal form and is owed a numbered result and a Lean statement, which needs a $\Lambda^4$ the layer carries at no $n$.*" The Lean statement now exists and needed no $\Lambda^4$. No sentence overstates, but a reader of line 125 meets both claims. The repair is to replace the tail with the positive state (the Lean statement is `phi_sphere`, stated over index quadruples, and the numbered result, if still owed, is named as such).
- **The commit message** describes the edits as made. "6 declarations" matches the audit. STATUS.md and plan-lean.md change only the file count, 777 to 778.
- **CONFIRMED WITH GAP.**

## D. Axioms

- `python3 scripts/misc/axiom_audit.py --only PhiSphereN`: "auditing 6 declarations across 1 files ... 6/6 clean -- resting on the standard three alone".
- **CONFIRMED.**

## E. Style

- No em dash in any added line of the commit (grep count 0). The `−` in the Lean docstrings is the minus sign U+2212.
- No backticks inside markdown link text in the added lines (grep for ``[` `` count 0).
- The edited INDEX rows and the conventions.md bullet are single lines. No hard wrap.
- The semicolon in the I69 row, "no normal form; standard three axioms", follows the list-tail pattern r1499 to r1504 passed.
- *Note, pre-existing, not introduced here:* the I69 row carries an unmatched `*` after "`pf4` and `w4` are the auxiliaries." and another before "The Lefschetz step", both present in the parent commit. The semicolon in conventions.md line 125, "dim=6; *the general-$n$ proof", splices two clauses and predates the commit. It goes with the C-1 repair.
- **CONFIRMED.**

## Overall

**CONFIRMED WITH GAP.** `phi_sphere` kernel-checks conventions.md's identity at every $n$ and every skew $\omega$, with $\tfrac16\sum_{\text{all}}w_4^2$ equal to $\lVert\omega\wedge\omega\rVert_\perp^2$ and `inner2` the record's $\langle\omega,\omega\rangle$, consistent with `trace_pow_four_add_pf_sq` at $n=4$ and `phi_sphere6` at $n=6$. The proof is four-index relabelling plus skewness in the three cross terms, every step sound, 6/6 declarations on the standard three axioms. Gap C-1: [conventions.md](../findings/conventions.md) line 125 keeps a tail saying the general-$n$ Lean statement is owed and needs a $\Lambda^4$, contradicting the sentence added to the same bullet.
