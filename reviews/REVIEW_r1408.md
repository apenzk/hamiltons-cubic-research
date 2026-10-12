# REVIEW r1408: L66 on the Weyl operators in Lean, `L66_weyl`, `circDecomp_of_weyl`, `Pf_lt_max_on`

Log [agent_logs/r1408.log](../agent_logs/r1408.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: elaboration of four scratch files for `#print axioms`, `#check` and the norm test the brief names, no numerics. Record: [findings/support-dichotomy.md](../findings/support-dichotomy.md), the opening definition and theorem and Lemma L66, with [ROUND_L66](../verification/ROUND_L66.md) and [conventions.md](../findings/conventions.md) ($M(n)$ and the unit sphere). Lean: commit 76c2ac4c, [L66Weyl.lean](../lean/HamiltonsCubic/Results/L66Weyl.lean), [L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean), [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) (`foxProd2`, `foxTri2`, `foxTri2_symm_right`), [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) (`IsWeyl2`, `innerOp2`, `normSq2`, `Pcubic2_eq_innerOp2`), [RecordNormed.lean](../lean/HamiltonsCubic/Results/RecordNormed.lean), the L66, L66 (statement) and Base: record norm rows of [lean/INDEX.md](../lean/INDEX.md).

**Standfirst.** `L66_weyl` is Lemma L66 on $\mathcal W_n$, in a form stronger than the record's. `weylR` is the Weyl operators with all three `IsWeyl2` clauses, `weylSphere` is the record's unit sphere `normSq2 = 1`, `foxT` is $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ with $\circ$ the record's polarisation of $Q$, and `Pf_foxT` makes its diagonal `Pcubic2`. `IsCircDecompWeyl` carries the record's five clauses one for one, with $A_i\circ A_j=0$ read in the ambient operator space, which is where the record's $\circ$ lives. `circDecomp_of_weyl` runs in the direction the proof needs, and its one symmetry step uses self-adjointness of `X` and `A j`, both Weyl. The theorem drops the unit norm of `W`, drops $n\ge4$, and takes `M` as any upper bound on the sphere that `P(W)` reaches, all three of which widen it. The L66Statement edit changes no statement's meaning, as the `#check` output shows. The L66 row is accurate, with two editorial gaps. **The Base: record norm row's new DEFECT is misdiagnosed**: `norm_nonneg` on `RecCurv ι` elaborates at once under its fully qualified name, and the heartbeat timeout appears only with `HamiltonsCubic.RealLayer` open, where `norm_nonneg` is ambiguous with the layer's own `HamiltonsCubic.RealLayer.norm_nonneg` about matrix maps. `_root_.norm_nonneg` resolves it. The axioms are the standard three.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1a. `weylR`, `weylSphere` | CONFIRMED | `weylR` is the submodule of `RecCurv ι` cut out by `IsWeyl2` (self-adjoint, first Bianchi, Ricci-flat), the record's $\mathcal W_n$. `weylSphere` is `normSq2 (cv x) = 1`, which is $\lVert x\rVert=1$ by `RecCurv.norm_sq_eq` and the record's normalisation of `innerOp2` (Base rows, Gate 2 r1401). |
| 1b. `foxT`, `Pf_foxT` | CONFIRMED | `foxT X Y Z = innerOp2 (foxProd2 X Y) Z` with `foxProd2 X Y = ½(Q(X+Y)−Q(X)−Q(Y))`, the record's $\circ$. The record writes $T=\langle X,Y\circ Z\rangle$ in support-dichotomy.md and $\langle X\circ Y,Z\rangle$ in second-order.md, equal by full symmetry at Weyl arguments. `Pf_foxT` gives $T(X,X,X)=\langle Q(X),X\rangle=P(X)$. |
| 1c. `IsCircDecompWeyl` against the record's definition | CONFIRMED | $k\ge2$, each $A_i\in\mathcal W_n$ with $\lVert A_i\rVert=1$, $\sum a_i^2=1$, every $a_i\ne0$, $A_i\circ A_j=0$ for $i\ne j$, $W=\sum a_iA_i$. Clause for clause the record's. `foxProd2 = 0` in `CurvOp2` is the record's $A_i\circ A_j=0$, since $\circ$ of Weyl operators is Weyl (`isWeyl2_foxProd2`). |
| 1d. `L66_weyl` is Lemma L66 on $\mathcal W_n$ | CONFIRMED | A maximiser in the record's sense (unit Weyl $W$, $P(W)=M(n)$) satisfies `hM` and `hmax` with $M=M(n)$, and `hMpos` is the record's $M(n)>0$. The conclusion is `¬ IsCircDecompWeyl W`. |
| 2. `circDecomp_of_weyl` | CONFIRMED | Direction: record form to abstract form, which is what refuting the record's form needs. The chain $T(X,A_i,A_j)=T(A_i,X,A_j)=T(A_i,A_j,X)=\langle A_i\circ A_j,X\rangle=0$ uses `foxTri2_comm` (no hypothesis) and `foxTri2_symm_right` with `X`, `A j` self-adjoint, both supplied by `IsWeyl2`. The converse also holds by `isWeyl2_foxProd2`, so the two readings are equivalent on $\mathcal W_n$. |
| 3. Dropped unit norm of `W`, and `hM` | CONFIRMED | `hM` quantifies over exactly `{B : weylR ι | normSq2 (cv B) = 1}`. Dropping $\lVert W\rVert=1$, dropping $n\ge4$, and reading `M` as any upper bound attained by `P(W)` each weaken the hypotheses, so the statement implies the record's. At $n\le3$ it holds unconditionally. The docstring sentence justifying the dropped norm is garbled (section 3). |
| 4. L66Statement edit | CONFIRMED | `IsCircDecomposable`, `Pf_lt_max`, `no_maximizer_is_circDecomposable` now bind `[NormedAddCommGroup E] [NormedSpace ℝ E]` explicitly, and `#check` prints the same statement with `‖B‖ = 1` and `‖W‖ = 1`. `Pf` and `Pf_additive` moved to any real module, a generalisation. `IsCircDecomposableOn T {B | ‖B‖ = 1}` unfolds to `IsCircDecomposable T`. |
| 5a. L66 row of lean/INDEX.md | CONFIRMED WITH GAP | The content and "Owed: $M(n)>0$" are right. The row still ends "statement: not typed" beside "The instantiation at $\mathcal W_n$ is PROVED", the sibling L66 (statement) row still says the instantiation "enters as hypotheses", and "Standard three axioms; Gate 2" splices two clauses with a semicolon. |
| 5b. Base: record norm row, the DEFECT claim | REFUTED | The brief's `example` elaborates with no error under the qualified name. The timeout reproduces only with `open HamiltonsCubic.RealLayer`, and `#check @norm_nonneg` there reports an ambiguous term with `HamiltonsCubic.RealLayer.norm_nonneg : 0 ≤ norm R` for `R : Matrix ι ι ℝ → Matrix ι ι ℝ` from [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean). `_root_.norm_nonneg x` elaborates in the same context. The instance is usable. |
| 6. Axioms | CONFIRMED | `L66_weyl`, `circDecomp_of_weyl`, `Pf_lt_max_on`, `no_maximizer_is_circDecomposable`: `[propext, Classical.choice, Quot.sound]`. |

**One-line summary: CONFIRMED WITH GAP.** `L66_weyl` states Lemma L66 on $\mathcal W_n$ faithfully and more strongly, with $M(n)>0$ the one hypothesis left, and the gap is in the index: the record-norm DEFECT is a name clash rather than an unusable instance, and the L66 rows carry a stale tag, a stale sibling sentence and a semicolon splice.

## 1. The objects against the record

`weylR ι` has carrier `{v | IsWeyl2 v}` inside `RecCurv ι`, and `IsWeyl2` in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) is the conjunction of self-adjointness on bivectors, first Bianchi and Ricci-flatness, the record's $\mathcal W_n$. The record's unit sphere is $\lVert A\rVert=1$ in the record's norm ([conventions.md](../findings/conventions.md), the $M(n)$ row), which on this layer is `normSq2 = innerOp2 R R`, identified with $\lVert\cdot\rVert^2$ by `RecCurv.norm_sq_eq`. So `weylSphere` is the record's sphere.

`foxProd2 X Y = ½ • (Qop2 (X+Y) − Qop2 X − Qop2 Y)` is the record's $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ ([second-order.md](../findings/second-order.md), the L24 criterion), and `foxT` is its pairing against a third argument. `Pf_foxT` rewrites `foxProd2 X X` to `Qop2 X` and uses `Pcubic2 R = innerOp2 R (Qop2 R)`, so the diagonal is $P$. The record's definition of $\circ$-decomposability, both at the head of support-dichotomy.md and in Lemma L66, matches `IsCircDecompWeyl` clause for clause (table, item 1c).

## 2. The conversion to the abstract form

`Pf_lt_max_on` consumes `T X Aᵢ Aⱼ = 0` for every `X` in the space. With `foxT`, that is $\langle X\circ A_i,A_j\rangle=0$ for every Weyl `X`. `circDecomp_of_weyl` derives it from the record's $A_i\circ A_j=0$ by swapping the first two slots and then the last two, and the second swap is `foxTri2_symm_right`, whose hypotheses (the two moved arguments self-adjoint) hold because both are Weyl. Symmetry in slots two and three is exactly what the record calls the load-bearing use of total symmetry ("the cross term $T(A_i,A_j,A_j)$ dies only after moving the first slot"). The other hypothesis of `Pf_lt_max_on`, closure of the sphere under negation, is `weylSphere_neg`, proved from the bilinearity of `innerOp2`.

## 3. The strengthening, and a docstring sentence

The record: for $n\ge4$, no $W$ with $\lVert W\rVert=1$ and $P(W)=M(n)$ is $\circ$-decomposable. The Lean: for every index type, every $M>0$ bounding $P$ on the unit Weyl sphere, every Weyl $W$ with $P(W)=M$ is not $\circ$-decomposable. Each difference removes a hypothesis, so the Lean statement implies the record's, and nothing in the record is lost. At $n\le3$ the Lean holds too (it is proved at every `ι`), which is consistent with the record's remark that $\mathcal W_n=0$ there.

The module docstring justifies dropping the norm with: "a decomposable `W` is a unit vector by its own clauses only through `Σ aᵢ² = 1`, which the argument never needs". The clauses do not make `W` a unit vector (they say nothing about $\langle A_i,A_j\rangle$), so the sentence reads as a claim the definition does not support. The correct justification is shorter: the argument never uses $\lVert W\rVert$. Editorial only.

## 4. The L66Statement edit

The section variable moved from a normed space to `[AddCommGroup E] [Module ℝ E]`, which only generalises `Pf` and `Pf_additive`. The three previously proved statements now carry their own normed binders, and `#check @no_maximizer_is_circDecomposable` prints the pre-edit statement, with `hM : ∀ B, ‖B‖ = 1 → Pf T B ≤ M` and `‖W‖ = 1`. `IsCircDecomposableOn T S W` is `IsCircDecomposable T W` with `‖Aᵢ‖ = 1` replaced by `Aᵢ ∈ S`, and `Pf_lt_max_on` repeats `Pf_lt_max`'s chain with `hM` and oddness read on `S`. No meaning changed.

## 5. The index rows

**L66 row.** Accurate on `foxT`, `Pf_foxT`, `circDecomp_of_weyl`, `L66_weyl` and the axioms, and "Owed: $M(n)>0$" is the one hypothesis the statement still carries. Three editorial gaps:

- the row's closing tag "statement: not typed" now sits beside a proved instantiation of the record's statement on $\mathcal W_n$,
- the L66 (statement) row still says "The instantiation at $\mathcal W_n$, that the record's $T$ is this form, that $P$ is its diagonal, and $M(n)>0$, enters as hypotheses", of which only $M(n)>0$ remains,
- "Standard three axioms; Gate 2: [r1408] ..." joins two clauses with a semicolon, and "pending" needs this verdict.

**Base: record norm row.** The row says `norm_nonneg` at a `RecCurv ι` element "exhausts the heartbeat budget in `isDefEq`, so the norm instance is registered and unusable". Tested on scratch files:

- `import HamiltonsCubic.Results.RecordNormed`, then the brief's `example` with `HamiltonsCubic.RealLayer.RecCurv ι` written out: **no error**.
- The same with `open HamiltonsCubic.RealLayer in`, or inside `namespace HamiltonsCubic.RealLayer`: **timeout at `isDefEq`**, reproduced.
- `open HamiltonsCubic.RealLayer in #check @norm_nonneg`: **ambiguous term**, `_root_.norm_nonneg` against `HamiltonsCubic.RealLayer.norm_nonneg (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : 0 ≤ norm R` ([WeylReal.lean:280](../lean/HamiltonsCubic/Base/WeylReal.lean#L280)).
- `_root_.norm_nonneg x` with the namespace open: **no error**.

So the elaborator's overload resolution tries to unify `RecCurv ι` with a function type on matrices, and that is what exhausts the budget. The norm instance works. The row's "DEFECT" and "Not done: a norm instance that elaborates" should be replaced by the name clash and its fix (`_root_.norm_nonneg`, or renaming the layer lemma), and the L24 row's "blocked on the record-norm base row's defect" loses its blocker. *The test ran while another session rebuilt RecordNormed.olean with an added `FiniteDimensional` instance, and the results were the same before and after that rebuild.*

## 6. Axioms

`#print axioms` on `L66_weyl`, `circDecomp_of_weyl`, `Pf_lt_max_on` and `no_maximizer_is_circDecomposable`: `[propext, Classical.choice, Quot.sound]` for each. No `sorryAx`, no `native_decide`.
