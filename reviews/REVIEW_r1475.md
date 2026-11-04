# REVIEW r1475: Weyl's eigenvalue inequality in Lean, milestone 1 of the L17 derivative build, commit d94815e3

Log [agent_logs/r1475.log](../agent_logs/r1475.log). One reviewer, working cold and adversarially. Analysis-only: `lake build HamiltonsCubic.Base.WeylIneq` (completed successfully) and one scratch file under /private/tmp, since deleted, carrying `#print axioms`, `#check` and a two-line composition test. No numerical run.

| Item | Verdict | Reason |
| --- | --- | --- |
| A. Statement fidelity | CONFIRMED | Mathlib's `eigenvalues` are `Antitone` (`LinearMap.IsSymmetric.eigenvalues_antitone`), so `i < k` in `inner_le_of_orth` and `k < i` in `le_inner_of_span` are the right directions. No hypothesis is vacuous or self-applied. The plan's $\lvert\lambda_i(A+tH)-\lambda_i(A)\rvert\le\lvert t\rvert\lVert H\rVert$ follows from `abs_eigenvalue_add_sub_le` at $c=\lVert tH\rVert$ with `abs_inner_self_le (t • H)` and `norm_smul`, which was compiled. Hand check on $2\times2$ diagonals passes |
| B. Axioms | CONFIRMED | All seven theorems: `[propext, Classical.choice, Quot.sound]` |
| C. Record accuracy | CONFIRMED WITH GAP | The file docstring, the plan's "Proved" sentence and the new INDEX clause claim exactly what is proved, with no em dash and no backtick inside link text. G1: the rewritten L17 (statement) row (lean/INDEX.md:478) carries a clause-splicing semicolon, "on negative parts; Mathlib carries neither". G2: the plan's milestone line (reviews/2026-09-26-lean-DK-plan.md:11), now marked **Proved**, still describes the target as "for symmetric matrices, through min–max built on Mathlib's Rayleigh quotient", while the file proves the operator form by an eigenbasis expansion and a dimension count, and the $\lvert t\rvert\lVert H\rVert$ form it displays is a composition the file does not name |

**Summary: CONFIRMED WITH GAP, the seven theorems are Weyl's inequality and its Courant–Fischer inputs stated correctly for Mathlib's decreasing eigenvalues and on the standard three axioms, and the gaps are one semicolon splice in the rewritten INDEX row and a plan line whose route and object description no longer match the proof it marks proved.**

## A. Statement fidelity

**Ordering.** `#check @LinearMap.IsSymmetric.eigenvalues_antitone` returns `Antitone (hT.eigenvalues hn)`, so $\lambda_0\ge\lambda_1\ge\dots$ as the docstring says.

- **`inner_apply_eq_sum`.** $\langle Tx,x\rangle=\sum_i\lambda_i\langle e_i,x\rangle^2$ in `eigenvectorBasis`. This is Parseval in an orthonormal eigenbasis, correct.
- **`inner_le_of_orth`.** Hypothesis: $\langle e_i,x\rangle=0$ for every `i < k`. Every surviving term has $i\ge k$, so $\lambda_i\le\lambda_k$ by antitonicity, giving $\langle Tx,x\rangle\le\lambda_k\lVert x\rVert^2$. Direction correct.
- **`le_inner_of_span`.** Hypothesis: $\langle e_i,x\rangle=0$ for every `k < i`, which is $x\in\mathop{\mathrm{span}}(e_0,\dots,e_k)$. Every surviving term has $i\le k$, so $\lambda_i\ge\lambda_k$, giving $\lambda_k\lVert x\rVert^2\le\langle Tx,x\rangle$. Direction correct.
- **`eigenvalue_le_of_inner_le`.** $\Phi:\mathbb R^n\to\mathbb R^{n-1}$ records $\langle e_i,Lv\rangle$ for $i<k$ (the $k$ top eigenvectors of $A$) and $v_i$ for $i>k$ (coordinates of $x=Lv$ in $S$'s eigenbasis $f$). Its kernel is nonzero by rank, so $x\ne0$ lies in $\mathop{\mathrm{span}}(f_0,\dots,f_k)$ and is orthogonal to $e_0,\dots,e_{k-1}$. Then $\lambda_k(S)\lVert x\rVert^2\le\langle Sx,x\rangle\le\langle Ax,x\rangle+c\lVert x\rVert^2\le(\lambda_k(A)+c)\lVert x\rVert^2$, and dividing by $\lVert x\rVert^2>0$ closes it. This is the standard Courant–Fischer comparison, and the two bounds are applied to different operators as they must be.
- **`abs_eigenvalue_add_sub_le`.** Applies the comparison twice: $(S,A)=(A+B,A)$ from the upper half of `abs_le`, and $(S,A)=(A,A+B)$ from the lower half. The hypothesis `hB` is a universally quantified quadratic-form bound on the free operator `B`, supplied by the caller, and nothing is applied to its own arguments. `B` carries no symmetry hypothesis, which is harmless since `A` and `A + B` symmetric force it.
- **`abs_inner_self_le`.** Cauchy–Schwarz then `le_opNorm`, correct for any continuous linear `B`.

**The plan's form.** The scratch file compiled this, with no error:

```lean
example ... (A : E →ₗ[ℝ] E) (H : E →L[ℝ] E) (t : ℝ) (hA : A.IsSymmetric)
    (hAt : (A + (t • H : E →L[ℝ] E).toLinearMap).IsSymmetric) (k : Fin n) :
    |hAt.eigenvalues hn k - hA.eigenvalues hn k| ≤ |t| * ‖H‖ := by
  have := abs_eigenvalue_add_sub_le hn hA hAt ‖t • H‖ (fun x => abs_inner_self_le (t • H) x) k
  rwa [norm_smul, Real.norm_eq_abs] at this
```

So `abs_inner_self_le` applied to $tH$ delivers the plan's $\lvert t\rvert\lVert H\rVert$, the coercion from `E →L[ℝ] E` to `E →ₗ[ℝ] E` being definitional at `B x`.

**Hand check.** $E=\mathbb R^2$, $A=\mathop{\mathrm{diag}}(1,0)$, $B=\mathop{\mathrm{diag}}(0,2)$. Then $A+B=\mathop{\mathrm{diag}}(1,2)$, sorted decreasingly $\lambda(A)=(1,0)$ and $\lambda(A+B)=(2,1)$. $\lvert\langle Bx,x\rangle\rvert=2x_2^2\le2\lVert x\rVert^2$, so $c=2=\lVert B\rVert$. Differences $\lvert2-1\rvert=1$ and $\lvert1-0\rvert=1$, both $\le2$. The sorted pairing matters here: pairing by basis vector would give $\lvert2-0\rvert=2$ at $e_2$, still within $c$, and Lean's statement pairs by sorted index as Weyl requires. A tight case: $B=\mathop{\mathrm{diag}}(2,0)$ gives $\lambda(A+B)=(3,0)$ and differences $(2,0)$, attaining $c=2$ at $k=0$.

## B. Axioms

`#print axioms` on `inner_apply_eq_sum`, `inner_le_of_orth`, `le_inner_of_span`, `eigenvalue_le_of_inner_le`, `eigenvalue_le_add`, `abs_eigenvalue_add_sub_le` and `abs_inner_self_le`: each depends on `[propext, Classical.choice, Quot.sound]`. The file contains no `sorry` and no `native_decide`.

## C. Record accuracy

- **File docstring** (WeylIneq.lean:5-18). Each bullet matches its theorem's statement, including the index conditions "orthogonal to $e_0,\dots,e_{k-1}$" and "in the span of $e_0,\dots,e_k$". The theorem docstring of `abs_eigenvalue_add_sub_le` says the $\lvert t\rvert\lVert H\rVert$ control holds "with $c=\lVert B\rVert$", which is the composition verified in A. The bullets end in semicolons as list punctuation, which is the list use and not a splice.
- **INDEX row** (lean/INDEX.md:478). The added clause says milestone 1 is proved as $\lvert\lambda_k(A+B)-\lambda_k(A)\rvert\le c$ under $\lvert\langle Bx,x\rangle\rvert\le c\lVert x\rVert^2$, kernel-checked, which is exactly `abs_eigenvalue_add_sub_le`. The row's status stays **partial**, correctly, since `hderiv` and `hcompress` remain binders. **G1**: the row, rewritten whole by this commit, still carries "`hcompress` is a trace inequality on negative parts; Mathlib carries neither", a semicolon joining two clauses. The text predates the commit, but the commit rewrote the line.
- **Plan** (reviews/2026-09-26-lean-DK-plan.md:11). The appended sentence ("**Proved** in Base/WeylIneq.lean: `abs_eigenvalue_add_sub_le`, with `abs_inner_self_le` supplying the hypothesis at $c=\lVert B\rVert$") is accurate. **G2**: the sentence it attaches to describes the milestone as "for symmetric matrices, through min–max built on Mathlib's Rayleigh quotient". The file states symmetric operators on a finite-dimensional real inner product space (matrices reach it through `Matrix.toEuclideanLin`, not done here), uses no Rayleigh-quotient API (the bounds come from `inner_apply_eq_sum` and a rank count), and names no theorem with the $\lvert t\rvert\lVert H\rVert$ conclusion. The mathematics is delivered, and a reader following the line to the file finds a different object and route than the line announces.
- **Commit message.** "Courant-Fischer's two Rayleigh bounds in Mathlib's eigenbasis" is accurate as scoped: the file proves the two eigenbasis bounds and the comparison, and does not state the min-max characterisation as an extremum over subspaces. Nothing in the record claims it does.
- **Marks.** No em dash in the file, the new INDEX text or the plan line. No backtick inside markdown link text in either markdown change.
