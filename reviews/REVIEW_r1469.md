# REVIEW r1469: L143's estimate B5 <= sqrt(n-2) in Lean, commit 434da8a8: form_le_mass, form_le, B5_sq_le, B5_frame, the L143 row and the bounds.md citation

Log [agent_logs/r1469.log](../agent_logs/r1469.log). One reviewer, working cold and adversarially. Analysis-only: `lake build HamiltonsCubic.Results.L143` and one scratch file in the session scratchpad outside the repository holding the `#print axioms` and `#check` calls. Every proof step was read by hand. No numerical run and no screen was made.

**Standfirst.** The module builds (four linter warnings, an unused `DecidableEq Γ` on `form_le_mass` and `form_le`), and all four declarations rest on `propext`, `Classical.choice` and `Quot.sound` alone. `B5_frame` is the record's $B_5\le\sqrt{n-2}$ squared and multiplied by $4$, with the record's $T=c^2$ in a Weyl eigenframe, the record's normalisation $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$, and a quantifier over every unit $\mu\ge0$ that contains the record's $\mu=\lvert\lambda\rvert$. Both marginals enter with the record's constants, the pair cap through `L31_cap_unit` and `brnorm_frame` and the row mass through `killing_frame`. The L143 row is honest about the second-order bound and the attainment, and it omits one further unformalised input that the file's own docstring names, $\lambda_{\max}p\le1$ (G1). The edited bounds.md line carries a pre-existing semicolon splice (G2).

| Item | Verdict | Reason |
| --- | --- | --- |
| A. Fidelity | CONFIRMED | `cst v a b c` is $\langle[v_a,v_b],v_c\rangle$, the record's $c_{efm}$ (second-order.md:83), and $T=c^2$ in an eigenbasis of $W$ is the record's $T=c'^2$ (second-order.md:706, :722). The pair cap and the row mass are L31 and L153 with constants $2$ and $2(n-2)$ under the layer's $\tfrac12\mathop{\mathrm{tr}}$ norm. $\sum_\alpha\langle T_\alpha\mu,\mu\rangle^2\le4(n-2)$ is $B_5\le\sqrt{n-2}$ |
| B. Proofs | CONFIRMED | AM-GM termwise with $T\ge0$, the $\mu_c^2$ half moved to $\mu_b^2$ by `sum_comm` and slot-2/3 symmetry, $x^2\le2x$ from $0\le x\le2$ by `nlinarith`, and the row-sum exchange by slot-1/2 symmetry. `B5_frame` instantiates each hypothesis correctly |
| C. Axioms | CONFIRMED | `B5_frame`, `B5_sq_le`, `form_le`, `form_le_mass`: `[propext, Classical.choice, Quot.sound]` each |
| D. Record text | CONFIRMED WITH GAP | The citation and the row's proved part are accurate, the diff adds no em dash, and the row's owed list is honest on the two items it names. It omits $\lambda_{\max}p\le1$ and the final assembly (G1, lean/INDEX.md:345). The edited line findings/bounds.md:33 keeps a semicolon splice from fcd87819 (G2) |

**Summary: CONFIRMED WITH GAP, the estimate is proved faithfully at every Weyl eigenframe, and the row's owed list is one input short.**

## A. Fidelity

**The record's claim.** [findings/bounds.md](../findings/bounds.md), Lemma L143, statement at line 25: *"$\displaystyle\sup_{\lVert W\rVert=1}\lvert P(W)\rvert\;\le\;1+\sqrt{n-2}$."* The proof (line 27) reads *"[second-order.md](second-order.md)'s bound $\theta\le\lambda_{\max}p+B_5$ applies, with $p=\sum_{\lambda>0}\lambda^2$, $\mu=\lvert\lambda\rvert$ and $B_5=\tfrac12\big(\sum_\alpha\langle T_\alpha\mu,\mu\rangle^2\big)^{1/2}$"*, and line 33 closes *"Hence $B_5\le\tfrac12\sqrt{4(n-2)}=\sqrt{n-2}$."*

- **The record's $T$.** second-order.md:722 defines it: *"With $T=c'^2\ge0$ transported to an eigenbasis of $W$ and $\mu=|\lambda|$"*. The structure constants are fixed at second-order.md:83 as $c_{efm}=\langle[e,f],m\rangle$ with $\langle A,B\rangle=\tfrac12\mathop{\mathrm{tr}}(A^{\mathsf T}B)$, and second-order.md:706 writes the eigenframe identity with $c_{\alpha\beta\gamma}^2$. So $T_{\alpha\beta\gamma}$ is the squared structure constant in the eigenframe, summed over ordered triples.
- **The Lean $T$.** [cst](../lean/HamiltonsCubic/Results/L41Statement.lean#L721) is `inner2 (br (v a) (v b)) (v c)`, with `inner2 X Y = ½ tr(XᵀY)` and `br X Y = XY − YX`. [EigenFrame](../lean/HamiltonsCubic/Results/L41Statement.lean#L97) makes `v` an orthonormal, complete, skew eigenbasis of `W`. So `cst v a b c ^ 2` is the record's $T_{abc}$ with the record's normalisation, and $n$ is `Fintype.card ι`, the matrix size.
- **$\mu$.** The record's $\mu=\lvert\lambda\rvert$ at $\lVert W\rVert=1$ has $\sum\mu^2=\sum\lambda^2=1$ (bounds.md:29 uses exactly this, *"$p\le\sum_\alpha\lambda_\alpha^2=1$"*) and $\mu\ge0$. `B5_frame` quantifies over every `μ` with `0 ≤ μ b` and `∑ μ b ^ 2 = 1`, decoupled from `lam`. That is a strengthening which contains the record's instance. *Opposite argued*: a decoupled $\mu$ could make the statement vacuous or different in kind. It does not, because the record's $\mu$ is one admissible choice and the conclusion is uniform in $\mu$.
- **The inequality is the record's.** $\langle T_\alpha\mu,\mu\rangle=\sum_{\beta\gamma}T_{\alpha\beta\gamma}\mu_\beta\mu_\gamma$ is the Lean `∑ b, ∑ c, cst v a b c ^ 2 * μ b * μ c`. The conclusion $\sum_\alpha(\cdot)^2\le4(n-2)$ gives $B_5=\tfrac12\sqrt{\sum}\le\tfrac12\sqrt{4(n-2)}=\sqrt{n-2}$ by monotonicity of the square root. The file does not state the $\sqrt{\ }$ form, and the step is one line of monotonicity. *Edge case checked*: at $n\le1$ the right side is negative, and there the hypotheses are inconsistent, since the skew space is $\{0\}$, forcing $\Gamma$ empty and `∑ μ b ^ 2 = 0 ≠ 1`. At $n=2$ both sides are $0$.
- **The pair cap.** The record: *"$\sum_\gamma T_{\alpha\beta\gamma}=\lVert[v_\alpha,v_\beta]\rVert^2\le2$ (Lemma L31)"*. The Lean: [brnorm_frame](../lean/HamiltonsCubic/Results/L41Statement.lean#L733) gives `inner2 (br (v x) (v a)) (br (v x) (v a)) = ∑ b, cst v x a b ^ 2`, the equality, and [L31_cap_unit](../lean/HamiltonsCubic/Results/L31Statement.lean#L452) gives `≤ 2` at unit skew `X`, `Y` in the same `inner2`. Constant $2$, matching.
- **The row mass.** The record: *"$\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ (Lemma L153)"*. The Lean: [killing_frame](../lean/HamiltonsCubic/Results/L41Statement.lean#L740), `∑ a, ∑ b, cst v x a b ^ 2 = 2 * (card ι − 2)`, over ordered pairs as in the record. Constant $2(n-2)$, matching. `killing_frame` carries `hW : IsWeyl W` but its proof reads only the frame and `killing_phi`, consistent with L153 holding at every skew $v$. This makes `B5_frame`'s Weyl hypothesis stronger than needed, which is harmless.

No discrepancy survives. A is CONFIRMED.

## B. Proofs

- **`form_le_mass`** ([L143.lean:29](../lean/HamiltonsCubic/Results/L143.lean#L29)). Termwise, $T\mu_b\mu_c\le T\tfrac12(\mu_b^2+\mu_c^2)$ from $T\ge0$ and $(\mu_b-\mu_c)^2\ge0$ by `nlinarith`. The sum of the $\mu_c^2$ half is turned into the $\mu_b^2$ half by `sum_comm` and `hs : T a b c = T a c b`, which is the right symmetry (the fixed index $a$ is in slot 1, the swapped pair in slots 2 and 3). The two halves sum to $2\sum_b\mu_b^2\sum_cT_{abc}$, halved. Correct. No sign hypothesis on $\mu$ is needed here, and none is taken.
- **`form_le`** ([L143.lean:52](../lean/HamiltonsCubic/Results/L143.lean#L52)). The same AM-GM and split, then `hcap` termwise against $\mu_b^2\ge0$. Correct. It duplicates `form_le_mass`'s body rather than calling it, which is style only. Nonnegativity of the form is proved inside `B5_sq_le` (`hx0`) from $T\ge0$, $\mu\ge0$.
- **`B5_sq_le`** ([L143.lean:79](../lean/HamiltonsCubic/Results/L143.lean#L79)). `hx2` is `form_le` at `hunit`. `hsum`: $\sum_ax_a\le\sum_a\sum_b\mu_b^2\sum_cT_{abc}$, then `sum_comm` to $\sum_b\mu_b^2\sum_a\sum_cT_{abc}$ and slot-1/2 symmetry `hs12` (line 96) to reach `hrow`'s $\sum_a\sum_cT_{bac}$, then $\sum_b\mu_b^2M=M$. The final step $x_a^2\le2x_a$ from $0\le x_a\le2$ by `nlinarith`, summed, and $2\sum x_a\le2M$. Correct. The record says *"with $T$ totally symmetric"*, and the file uses the two transpositions (12) and (23), which generate $S_3$, so nothing weaker is being assumed.
- **`B5_frame`** ([L143.lean:105](../lean/HamiltonsCubic/Results/L143.lean#L105)). Slot symmetries of $T=c^2$ come from `cst_swap23` and `cst_swap12` (sign flips, squared away by `ring`). The cap is `L31_cap_unit` on `v a`, `v b` with skewness from `hf.skew` and unit norms from `hf.orthonormal` at `if_pos rfl`, rewritten by `brnorm_frame`. The row mass is `killing_frame hW hf b`, with $M=2(n-2)$. The conclusion $\le2M=4(n-2)$ follows by `linarith`. Correct.

B is CONFIRMED.

## C. Axioms

From a scratch file importing `HamiltonsCubic.Results.L143`:

```
'HamiltonsCubic.L143.B5_frame' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L143.B5_sq_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L143.form_le' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L143.form_le_mass' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `sorry`, no `native_decide`. The `#check` of `B5_frame` matches the statement read in A. C is CONFIRMED.

## D. Record text

- **The citation** (bounds.md:33): *"The estimate $B_5\le\sqrt{n-2}$ is machine-checked at every Weyl eigenframe as `B5_frame` in [L143.lean]"*. Accurate, with the squared form noted in A.
- **The row's proved part** (lean/INDEX.md:345) names the four declarations, the two marginals with their constants and sources, and the standard three axioms. Accurate.
- **The owed list** names *"the second-order bound $\theta\le\lambda_{\max}p+B_5$ at a critical point"* and *"the attainment of $\sup\lvert P\rvert$ at a critical point"*. Both are genuinely absent from the file. Honest on what it names.
- **G1. The owed list omits $\lambda_{\max}p\le1$ and the assembly** ([lean/INDEX.md:345](../lean/INDEX.md#L345)). The record's proof has three inputs beyond the estimate: attainment, the second-order bound, and *"The first term is bounded by $1$ outright: $p\le\sum_\alpha\lambda_\alpha^2=1$ and $\lambda_{\max}\le1$"* (bounds.md:29). The file's own docstring ([L143.lean:19](../lean/HamiltonsCubic/Results/L143.lean#L19)) calls $\lambda_{\max}p\le1$ one of *"the lemma's other inputs"*, and no declaration in the file or elsewhere in the layer proves it for L143 (the only `lamMax` is [L73Statement.lean:108](../lean/HamiltonsCubic/Results/L73Statement.lean#L108), unrelated). The combination into $\sup\lvert P\rvert\le1+\sqrt{n-2}$ is likewise untyped. *Opposite argued*: the step is a two-line triviality, and the trailing *"statement: not typed"* already tells a reader the lemma as a whole is unformalised. That holds for the headline, but the row presents a two-item owed list as the complete remainder, and a reader checking what is left would conclude that proving the second-order bound and attainment closes the lemma. The file itself lists the missing input, so the row and its own file disagree. Survives, minor.
- **G2. A semicolon splice on the edited line** ([findings/bounds.md:33](../findings/bounds.md#L33)). *"so $\sum_\alpha\langle T_\alpha\mu,\mu\rangle^2\le2\sum_\alpha\langle T_\alpha\mu,\mu\rangle$; and the same AM–GM against the **row mass** gives …"* joins two independent clauses with a semicolon. `git blame` puts it at fcd87819, so 434da8a8 did not introduce it, and the commit appended its citation to this very line. *Opposite argued*: provenance could exempt it. The repository's convention treats such marks as defects wherever seen, and the commit edited the line, so it is reported, minor and pre-existing.
- **Withdrawn candidate.** The row's *"`killing_frame`); standard three axioms."* uses a semicolon before a verbless fragment. A fragment is not a clause, so this is no splice. Withdrawn.
- **Em dashes.** None in any added line of the diff. The "AM–GM" marks are en dashes.

D is CONFIRMED WITH GAP.
