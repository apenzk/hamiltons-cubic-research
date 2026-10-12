# Review r1489: L134(b) without Rellich, the defect to second order along the great circle

Gate 2 review of commit b80fb9b7, which adds [Results/L134b.lean](../lean/HamiltonsCubic/Results/L134b.lean) (`L134b` and its tools), edits [route-a.md](../findings/route-a.md)'s Lemma L134 (the Setting at line 182 and the proof of (b) at line 203) in answer to [r1488](REVIEW_r1488.md)'s gap A-1, and updates the L134 row of [lean/INDEX.md](../lean/INDEX.md), row 134 of [INDEX-results.md](../findings/INDEX-results.md) and milestones 2, 3 and 5 of the [second-order plan](2026-09-26-lean-second-order-plan.md). One reviewer. Analysis-only rule inherited: the only compute was the module build (8727 jobs, no error, no warning in L134b.lean or SecondAssembly.lean) and `#print axioms` on a scratch file under `/private/tmp`, since deleted.

| item | claim | verdict |
| --- | --- | --- |
| A | `L134b` is $\delta^2(\cos t\,u+\sin t\,H)=\tfrac19+c_1t+c_2t^2+o(t^2)$ as $t\to0^+$ at the unit padded competitor, for every symmetric $H$, and `exp2_altNormSqOf` is right that $\delta^2$ is a sum of squares of continuous linear functionals | CONFIRMED |
| B | `exp2_cos`, `exp2_sin`, `Exp2.map`, `Exp2.sum`, `Exp2.smul_vec` are correct | CONFIRMED |
| C | the redefinition of $c_2$ and the $o(t^2)$ remainder are faithful and sufficient for (b), and nothing downstream needs $O(t^3)$ or a genuine second derivative | CONFIRMED WITH GAP |
| D | all eleven declarations of L134b.lean rest on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | the L134 row, row 134, the plan's milestones 2 to 5 and the docstrings are accurate, punctuation clean | CONFIRMED WITH GAP |

**Summary: the Lean is correct, faithful and kernel-checked on the standard axioms, and it supplies the existence of $c_2(H)$ with an $o(t^2)$ remainder, which is all the sign argument of L134(b) uses. Three record gaps remain: statement (b) at route-a.md line 189 still reads $\tfrac12\Phi''(0^+)$, a second derivative the new Setting no longer supplies; the two index rows say "(b) proved" where what is proved is (b)'s existence input, with (a)'s bound still owed; and one docstring sentence identifies $c_1$ through a theorem stated on a different path. CONFIRMED WITH GAP.**

## A. Fidelity of `L134b`

The statement as `#check` prints it: for $n\ge4$, $H$ symmetric on $\Lambda^2\mathbb R^n$, and a proof `hW` that $\cos t\cdot u+\sin t\cdot H$ is symmetric for every $t$, there exist $c_1,c_2$ with `Exp2 (fun t => altNormSqOf (specFn hN negPartScalar (hW t))) (1/9) c₁ c₂`.

- **The path.** The function is $t\mapsto\lVert\mathrm{Alt}(W(t)_-)\rVert^2$ with $W(t)=\cos t\,u+\sin t\,H$, which is the record's great circle. **Correct.**
- **The point $u$.** `uOp` is `rankSum lam6 vec` with `lam6` $=(2,-1,-1,0,0,0)/\sqrt6$ on the orthonormal `vec` (L17Deriv.lean line 179), the self-dual spectrum of route-a.md line 215, so $\lVert u\rVert^2=(4+1+1)/6=1$. The constant term is $\tfrac19$ by `altNormSq_uNeg` (L17Deriv.lean line 422), which rests on `defect_u`. **Correct.**
- **The defect.** `negPartScalar` is $(\lvert x\rvert-x)/2=\max(-x,0)$ (AltPart.lean line 517), so `specFn` gives $W_-=\tfrac12(\lvert W\rvert-W)\succeq0$, the convention route-a.md line 215 fixes. `altNormSqOf` is `fourNormSq (alt4 (compOf X))` (BivModel.lean line 152), and `defectSq_eq` identifies it with the layer's $\delta^2=\lVert\mathrm{Alt}(W_-)\rVert^2$ at any orthonormal skew presentation. **Correct.**
- **One-sided, $o(t^2)$.** `Exp2` is little-o of $t^2$ along `𝓝[Set.Ici 0] 0` (Exp2.lean line 22). **Correct.**
- **Any symmetric $H$.** A strengthening. The record's $H$ is a unit Weyl tensor in $T_uS=u^\perp$, which is a symmetric operator on $\Lambda^2$, so it is one instance. Neither unit norm, orthogonality to $u$, nor first Bianchi is used. The hypothesis `hW` is not vacuous and restricts nothing: it follows from `uOp_isSymmetric` and `hH`, and `L134b`'s own proof derives the symmetry of $-\tfrac12u$ the same way.
- **`exp2_altNormSqOf`.** `altCLM i j k l` $=\tfrac13(\mathrm{comp}_{ijkl}+\mathrm{comp}_{iklj}+\mathrm{comp}_{iljk})$ composes `innerSL` with `ContinuousLinearMap.apply`, so it is a continuous linear functional, and `altCLM_apply` identifies it with `alt4 (compOf X)`. `fourNormSq` is $\tfrac14\sum_{ijkl}T_{ijkl}^2$ (AltPart.lean line 206), so `altNormSqOf_eq` is the definition unfolded. Each square expands by `Exp2.map` then `Exp2.mul`, the four sums by `Exp2.sum`, the $\tfrac14$ by `Exp2.smul`. The constant term is `altNormSqOf a`, as stated. **Correct.**
- **Existential coefficients.** $c_1$ and $c_2$ are not identified, and the record's (b) needs only their existence. Peano coefficients along $[0,\infty)$ are unique, so $c_2$ is the one number the record's Setting now names.

## B. Trig and tool lemmas

- **`exp2_cos`.** $\cos t-(1-\tfrac{t^2}2)$ is bounded by Mathlib's `Real.cos_bound`, $\lvert t\rvert^4\cdot\tfrac5{96}$ for $\lvert t\rvert\le1$, which is $o(t^2)$ by `isLittleO_pow_pow`. **Correct.**
- **`exp2_sin`.** $\sin t-t=(\sin t-(t-\tfrac{t^3}6))-\tfrac{t^3}6$, bounded by `Real.sin_bound` plus $\lvert t\rvert^3/6$, both $o(t^2)$. The coefficients $(0,1,0)$ are right. **Correct.**
- **`Exp2.map`.** $L(f)-(La+tLb+t^2Lc)=L(f-(a+tb+t^2c))$ by linearity, and a continuous linear map is $O(1)$ in norm, so little-o is preserved. **Correct.**
- **`Exp2.sum`.** Finset induction on `Exp2.const 0` and `Exp2.add`. **Correct.**
- **`Exp2.smul_vec`.** $(f(t)-(a+tb+t^2c))\cdot v$ is $o(t^2)\cdot O(1)$. **Correct.**
- **The path's coefficients in `L134b`.** $\cos t\,u+\sin t\,H=u+tH+t^2(-\tfrac12u)+o(t^2)$, which is `hpath'`, the input `exp2_negPart_path` takes with $G=-\tfrac12u$ symmetric. **Correct.**

## C. The record edit

- **The new $c_2$.** route-a.md line 182 now defines $c_2(H)$ as the $t^2$ coefficient of the one-sided expansion, "which is $\tfrac12\tfrac{d^2}{dt^2}\vert_{t=0^+}$ wherever that derivative exists". Faithful: the coefficient is unique, and where a one-sided second derivative exists, Taylor's theorem with Peano remainder makes it twice the coefficient. Existence is what (b) proves and `L134b` supplies.
- **Sufficient for (b)'s sign argument.** $P$ is a cubic polynomial, so along the great circle its expansion is exact to any order, and $\delta^2$ contributes $c_1t+c_2t^2+o(t^2)$ with $c_1=0$ on $\{F=0\}$. So $\Phi(t)-\theta_0=[\tfrac12\mathrm{Hess}(P\vert_S)[H,H]-\kappa_nc_2]t^2+o(t^2)$, and a negative bracket gives $\Phi<\theta_0$ for small $t>0$. The argument uses nothing more.
- **$O(t^3)$ to $o(t^2)$ at line 203.** Correct as a statement of what is proved. The retained sentence, that Rellich's theorem makes the branches of $W(t)_-$ one-sidedly analytic and so gives $O(t^3)$, is a correct classical fact about a real-analytic symmetric family, recorded as a cited strengthening.

**Gap C-1.** route-a.md line 189, statement (b), still reads "**Hence $\tfrac12\Phi''(0^+)\le-\tfrac{\theta^*}2+\lvert\kappa_n\rvert\,c_2(H)$**". After the edit, neither the Setting nor the proof supplies a second derivative of $\Phi$: the proof at line 203 produces only the $t^2$ coefficient of $\Phi(t)-\theta_0$. The statement should read that coefficient in place of $\tfrac12\Phi''(0^+)$, which is what r1488's A-1 repair asked of the whole lemma and what the proof now derives.

**Downstream.** Nothing relies on $c_2$ being a genuine second derivative, and nothing needs $O(t^3)$ from L134(b).
- L135 (route-a.md lines 211 to 266). Its Setting (line 215) calls $c_2$ "the one-sided second-order coefficient", which agrees with the new definition. The $O(t^3)$ at lines 227, 230 and 231 belongs to L135's own straight-line expansion, whose block proof the record itself marks non-rigorous. The rigorous proof of (a) (line 234) matches $t^2$ coefficients through homogeneity, and $o(t^2)$ suffices (L135Statement.lean proves it that way). The mechanism at line 256, $\delta^2(t)=\tfrac19+c_2t^2+O(t^3)$ on $\{F=0\}$, needs only $o(t^2)$, since every real $c_2$ satisfies $c_2t^2\le C-\tfrac19+o(t^2)$ for small $t$. Its $O(t^3)$ still rests on the Rellich citation the record keeps. *A precision remark, not a gap.*
- L136 and L140 (lines 267 to 330) use $\Delta_2$, $X_2$ and $c_2$ as coefficients, and L140 closes "granting the remainder step L134 still owes" (line 315), which the edit leaves unchanged.
- L134's "What is left" paragraph (line 209) still attributes the defect side's $O(t^3)$ to a Rellich branch with $H$-dependent radius. That stays true, and it bears on the neighbourhood remainder step, which (b) never claimed.
- L141 ([second-order.md](../findings/second-order.md) line 1762 onwards) and [results.md](../results.md) carry no L134 $c_2$ and no $O(t^3)$ tied to it.

## D. Axioms

`#print axioms` on `Exp2.map`, `Exp2.sum`, `Exp2.smul_vec`, `exp2_cos`, `exp2_sin`, `L17Deriv.Exp2.coeff`, `altCLM`, `altCLM_apply`, `altNormSqOf_eq`, `exp2_altNormSqOf` and `L134b`: each depends on `[propext, Classical.choice, Quot.sound]` and nothing else. **CONFIRMED.**

## E. Record accuracy

- **Plan milestones 2 to 5** (plan lines 10 to 13). Milestone 2 now credits Schur linearity (`schur_add_op`, `schur_smul_op`) and names `exp2_negPart_blk`. Milestone 3 names `commutator_toCLM`. Milestone 5 marks `L134b` as "L134(b)'s existence claim", which is exactly what is proved. r1488's D-1 and D-2 are repaired. **Accurate.**
- **SecondAssembly.lean docstring** (lines 10 to 12) now says the $o(t^2)$ form is proved and the $O(t^3)$ form is Rellich's. r1488's A-1 on the docstring and D-3 (`change`) are repaired.
- **L134b.lean file docstring** (lines 13 to 16) states the $o(t^2)$ form and disclaims $O(t^3)$. **Accurate.**
- **Punctuation.** No em dash in any added line or in L134b.lean. No backticks inside markdown link text.

**Gap E-1.** The L134 row of [lean/INDEX.md](../lean/INDEX.md) (line 462) reads "**(b) is PROVED without Rellich's theorem**", and row 134 of [INDEX-results.md](../findings/INDEX-results.md) (line 150) reads "(b) proved without Rellich as L134b". Lemma L134(b) is the inequality $\tfrac12\Phi''(0^+)\le-\tfrac{\theta^*}2+\lvert\kappa_n\rvert c_2(H)$ and the resulting threshold, and it follows from (a)'s bound, which the same row lists as owed, combined with $P$'s expansion along the great circle, which no Lean file assembles with $\delta^2$'s. What `L134b` proves is (b)'s analytic input, the existence of $c_2$ with an $o(t^2)$ remainder, and milestone 5 of the plan words it correctly. Repair: "(b)'s existence claim is proved", with (b)'s inequality owed on (a)'s bound.

**Gap E-2.** L134b.lean line 25: "*With [L17Deriv.lean](L17Deriv.lean) the first coefficient is $c_1=-2aF(H)$*". The L17Deriv theorem, `hasDerivWithinAt_defect_u` (L17Deriv.lean line 345), is a one-sided derivative along the straight line $u+tH$, and `L134b` expands along the great circle. The identification is true: the two paths agree to first order, the negative part is Lipschitz, and a Peano expansion's $t$ coefficient is the one-sided derivative. No Lean statement makes it. Repair: say the value follows from L17Deriv by those two facts, or prove the link.

**Gap E-3.** route-a.md line 203, in the edited sentence: "$\ldots\big]t^2+o(t^2)$; substitute (a) and $\kappa_n=-\lvert\kappa_n\rvert$" is a semicolon joining two clauses. The splice predates the commit and was carried through the edit. Repair: a full stop.
