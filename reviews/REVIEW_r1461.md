# REVIEW r1461: the defect ceiling in Lean, commit 61fe8312: `specLin`, `specOp_sum`, `specOp_eq`, `bianchi_specOp`, `absOp_frame`, `normSq_absOp`, `defectSq_le_quarter`, and the L134 row

Log [agent_logs/r1461.log](../agent_logs/r1461.log). One reviewer, working cold and adversarially. Analysis-only: `lake build HamiltonsCubic.Results.DefectQuarter` and one scratch file for `#check` and `#print axioms` in the session scratchpad outside the repository. No numerical screen was run.

**Standfirst.** The module builds and `defectSq_le_quarter` rests on `propext`, `Classical.choice` and `Quot.sound` alone. Its statement is the record's ceiling in the record's normalisation: `defectSq` is `fourNormSq (alt4 (comp W₋))`, the record's `⅓` cyclic `Alt` measured in `normSq`, the Hilbert–Schmidt norm on $\Lambda^2$ under $\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$, and at unit $W$ it reads $\delta^2\le\tfrac14$. The proof is $4\delta^2=\lVert\mathrm{Alt}\lvert W\rvert\rVert^2\le\lVert\lvert W\rvert\rVert^2=\sum\lambda^2=\lVert W\rVert^2$, each step an imported lemma applied with the right hypotheses. Three text-level gaps remain. The L134 row reads as if (c) owes only the direct-sum rule, and omits $\delta^2(u)=\tfrac19$ and the vanishing of the coupling. The L135 row still lists the ceiling as owed. And the file's docstring says L140 leans on the ceiling, which L140's proof does not.

| Item | Verdict | Reason |
| --- | --- | --- |
| A. Statement fidelity | CONFIRMED | `defectSq lam om` is $\lVert\mathrm{Alt}(W_-)\rVert^2$ with $W_-=\tfrac12(\lvert W\rvert-W)$ built on the frame, `Alt` the record's $\tfrac13$ cyclic sum, and the norm `normSq` via `normSq_eq_fourNormSq_comp`. Quantifying over every eigenframe is at least as strong as the record's frame-free claim. A frame exists mathematically, and Lean supplies one as `eigenFrame_exists` over `Pairs n`, which is not composed with this theorem's `Fin r` shape (a note, not a gap). |
| B. The proof | CONFIRMED | `specOp_eq` via `weyl_lin` and `hf.complete`, `bianchi_specOp` from `IsWeyl`'s Bianchi clause, `absOp_frame` and `normSq_absOp` via `innerOp_frame`, then `altNormSq_absOp` (Bianchi hypothesis supplied by `bianchi_specOp`) and `altNormSq_le_normSq` (skewness supplied by `specOp_isSkew` and `hf.skew`), `normSq_frame`, `linarith`. |
| C. Axioms | CONFIRMED | Standard three for `defectSq_le_quarter`, `normSq_absOp` and `specOp_eq`. No `sorry`, no `native_decide`. |
| D. Record text | CONFIRMED WITH GAP | The ceiling clause is faithful. The row's residual for (c) names only the direct-sum rule and leaves out $\delta^2(u)=\tfrac19$ and $\langle L_eH,H\rangle=0$ from disjoint support, both owed in Lean ([lean/INDEX.md:458](../lean/INDEX.md)). No em dash, no semicolon splice. |
| E. Downstream | CONFIRMED WITH GAP | The L135 row still lists "the unconditional ceiling" as owed ([lean/INDEX.md:456](../lean/INDEX.md)). The docstring's "L135 and L140 lean on the same ceiling" is false of L140 ([DefectQuarter.lean:11](../lean/HamiltonsCubic/Results/DefectQuarter.lean)). route-a.md's L134(c) proof and ATTEMPTS.md's by-products sentence could cite the Lean proof. results.md does not state the ceiling. |

**One-line summary: CONFIRMED WITH GAP.** `defectSq_le_quarter` proves the record's $\delta^2\le\tfrac14\lVert W\rVert^2$ in its exact normalisation on the standard three axioms, and the gaps are three sentences of record text: an incomplete owed list for L134(c), a stale owed item in the L135 row, and a provenance claim about L140.

## A. Statement fidelity

**The defect.** `#check @defectSq_le_quarter` prints `IsWeyl W → EigenFrame W om lam → defectSq lam om ≤ 1 / 4 * normSq W`, with `IsWeyl` resolving to `RealLayer.IsWeyl` and `normSq` to `RealLayer.normSq`. In [AltPart.lean](../lean/HamiltonsCubic/Base/AltPart.lean), `defectSq lam om = altNormSq (negPartOp lam om)`, `negPartOp` is `specOp` at $\lambda\mapsto\tfrac12(\lvert\lambda\rvert-\lambda)$, so $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$, the record's sign from conventions.md. `altNormSq R = fourNormSq (alt4 (comp R))` with `alt4` the $\tfrac13$ cyclic average, the record's `Alt(R)_{ijkl}=⅓(R_{ijkl}+R_{iklj}+R_{iljk})`, and `fourNormSq` carries the $\tfrac14$ that `normSq_eq_fourNormSq_comp` proves equal to `normSq` on bivector-preserving operators. So `Alt` and $W$ are measured in one norm, as the record's contraction $\lVert\mathrm{Alt}X\rVert\le\lVert X\rVert$ requires.

**The norm.** `normSq R = innerOp R R = ½ Σ_{ij} inner2 (R φ_ij) (R φ_ij)` with `inner2 X Y = ½ tr(XᵀY)`, so it is the Hilbert–Schmidt norm on $\Lambda^2$ in the orthonormal basis $\{\varphi_{ij}\}_{i<j}$ under conventions.md's $\lVert Z\rVert^2=\tfrac12\operatorname{tr}(Z^{\mathsf T}Z)$. Anchor: the competitor's spectrum $\tfrac1{\sqrt6}(2,-1,-1)$ has $\sum\lambda^2=1$ and the record's $\delta^2(u)=\tfrac19<\tfrac14$, consistent with the theorem at unit norm.

**Quantifying over frames.** The theorem holds for every orthonormal eigenframe, so whichever frame the record's functional calculus uses, the conclusion holds there. Frame-independence of `negPartOp` is owed in AltPart.lean, and the theorem needs none of it. *Argued the opposite: could a frame give a `defectSq` differing from the record's $W_-$?* Mathematically no, since an orthonormal eigenframe with complete span computes the functional calculus exactly. And even if one could, the bound holds for it too. Nothing is lost.

**Existence.** [EigenFrameExist.lean:146](../lean/HamiltonsCubic/Results/EigenFrameExist.lean)'s `eigenFrame_exists` gives an `EigenFrame` indexed by `Pairs n` for `R` with `IsLinOp R`, skew-preserving and self-adjoint on bivectors. `defectSq_le_quarter` takes `Fin r`. The reindexing along `Pairs n ≃ Fin (card)` and the passage from `RealLayer.IsWeyl` (linear on bivectors only) to `IsLinOp` (e.g. through $W\circ\mathrm{skew}$, which agrees with $W$ on bivectors and so has the same eigenframes) are routine and not composed. The row says "in any orthonormal eigenframe", which is what is proved, so this is a note, not a gap.

## B. The proof

- `specOp_eq`: rewrites $X=\sum\langle X,\omega_\gamma\rangle\omega_\gamma$ by `hf.complete`, pushes $W$ through by `weyl_lin` with `hf.skew`, then `hf.eigen` and `inner2_comm`. Correct: both sides are $\sum\lambda_\gamma\langle\omega_\gamma,X\rangle\omega_\gamma$.
- `bianchi_specOp`: rewrites the three `specOp (phi …)` terms to `W (phi …)` by `specOp_eq` with `phi_isSkew`, then `hW.2.2.1`. Correct and uses exactly the Bianchi clause.
- `absOp_frame`: `absOp` is `specOp` at $\lvert\lambda\rvert$, eigen by orthonormality collapsing the sum. `complete` is reused from `hf`, which is legitimate since completeness is a property of the $\omega$ alone.
- `normSq_absOp`: `innerOp_frame` in the `absOp` frame with linearity from `specOp_sum`, then $\lvert\lambda\rvert^2=\lambda^2$ by `sq_abs`.
- `defectSq_le_quarter`: `altNormSq_absOp lam om (bianchi_specOp hW hf)` gives $\lVert\mathrm{Alt}\lvert W\rvert\rVert^2=4\delta^2$, whose hypothesis is Bianchi of `specOp lam om`, supplied correctly. `altNormSq_le_normSq (absOp lam om) (fun i j => specOp_isSkew _ om hf.skew _)` needs `absOp (phi i j)` skew for all `i j`, supplied correctly. `normSq_absOp` and `normSq_frame` turn both sides to $\sum\lambda^2$, and `linarith` closes $4d\le S\Rightarrow d\le\tfrac14S$.

No hypothesis is vacuous: `IsWeyl` and `EigenFrame` are both inhabited (e.g. `isWeyl_zero` with any orthonormal basis of bivectors and zero spectrum, and the nonzero Weyl operators the layer frames elsewhere).

## C. Axioms

Scratch file `import HamiltonsCubic.Results.DefectQuarter` in the scratchpad, run with `lake env lean` after `lake build HamiltonsCubic.Results.DefectQuarter` (completed successfully):

- `defectSq_le_quarter`: `[propext, Classical.choice, Quot.sound]`
- `normSq_absOp`: `[propext, Classical.choice, Quot.sound]`
- `specOp_eq`: `[propext, Classical.choice, Quot.sound]`

The working tree copies of DefectQuarter.lean, AltPart.lean and L41Statement.lean match HEAD.

## D. Record text

**The ceiling clause is faithful.** It states $4\delta^2=\lVert\mathrm{Alt}(\lvert W\rvert)\rVert^2\le\lVert\lvert W\rvert\rVert^2=\lVert W\rVert^2$ for every Weyl $W$ in any orthonormal eigenframe, with the axioms, which is what the file proves. It does not claim the record's intermediate identity $\delta^2=\tfrac12\langle\mathrm{Alt}(W_-),\lvert W\rvert\rangle$, which the file does not prove, and correctly so.

**GAP D1, the residual for (c) is incomplete** ([lean/INDEX.md:458](../lean/INDEX.md)). The row now reads "(c), the defect on the padded flat, whose ceiling $\delta^2\le\tfrac14$ is PROVED … while its direct-sum rule on disjoint blocks is owed", and the commit message says "the L134 row now owes only (c)'s direct-sum rule". The proof of (c) at [route-a.md:205](../findings/route-a.md) uses four inputs: the direct-sum rule, $\delta^2(u)=\tfrac19$, the ceiling, and $T(u,H,H)=0$ from disjoint support giving $\langle L_eH,H\rangle=0$. Lean has no $\delta^2(u)=\tfrac19$ (AltPart.lean lists it owed, and L17Statement's `kinkProfile_zero` is a profile evaluation, not the defect), and nothing types the vanishing coupling. *Argued the opposite:* the L135 row carries $\delta^2=1/9$ as owed, so a reader of both rows sees it, and $\delta^2(u)$ enters only through the direct-sum identity. But the L134 row is read alone, and its residual for (c) now names one owed item where two more are owed. **Stands, minor.** The fix is to list $\delta^2(u)=\tfrac19$ and the vanishing coupling beside the direct-sum rule.

**Marks.** No em dash in any added line. The semicolons in the added text are the row's list separators between owed items that carry internal commas, and the docstring's are list-item terminators and a quotation of ATTEMPTS.md. No splice.

## E. Downstream

**GAP E1, the L135 row is stale** ([lean/INDEX.md:456](../lean/INDEX.md)). Its owed list ends "and the unconditional ceiling", which is the $\delta^2\le\tfrac14$ ceiling the row itself names ("the $1/4$ is the record's ceiling for $\delta^2$"). `defectSq_le_quarter` now discharges it at unit norm. *Argued the opposite:* the owed item might mean the ceiling applied to $\Delta_2$. The row explicitly separates the two and calls $\Delta_2\le\delta^2$ "a further statement", so the owed item is the $\delta^2$ ceiling. **Stands.**

**GAP E2, the docstring misstates L140's dependence** ([DefectQuarter.lean:11](../lean/HamiltonsCubic/Results/DefectQuarter.lean), repeated in the commit message). It says "L135 and L140 lean on the same ceiling". L140's proof at [route-a.md:316](../findings/route-a.md) bounds $\lVert g_1\rVert\le\inf_\mu\lVert Z+\mu H\rVert\le\tfrac12$ from $\mathrm{Alt}(H)=0$ and the Daleckii–Krein multipliers in $[-1,0]$, and never invokes $\delta^2\le\tfrac14$. The same shape (Alt kills a Bianchi term, centre at $\tfrac12$) appears in both, and L140's $\tfrac14$ coincides with the ceiling's value. *Argued the opposite:* L140's statement combines with L135, whose candidate is "the record's own universal ceiling", so L140 "leans" on it through L135. But L135 uses the ceiling only as the value $\tfrac14$ it lands on, which it flags as belonging to another quantity, and L140's bound on $\lVert g_1\rVert^2$ is proved independently. **Stands, minor.** L135 does reference the ceiling. L134(c) uses it.

**Citations the record could add, report only.** [route-a.md:205](../findings/route-a.md), L134(c)'s proof, cites the ceiling to "same by-products" in ATTEMPTS.md and could cite `defectSq_le_quarter`. [ATTEMPTS.md:843](../ATTEMPTS.md)'s by-products sentence could note the Lean proof. results.md does not state the ceiling (its L140 at results.md:358 is the Lipschitz statement), so it owes nothing. Nothing was repaired.
