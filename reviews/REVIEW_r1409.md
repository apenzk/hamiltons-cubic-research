# REVIEW r1409: λ_max(L_e on W⊥) ≤ ½ in Lean, `LeRestr_isSymmetric`, `L24_lambda_max`, and `FiniteDimensional ℝ (RecCurv ι)`

Log [agent_logs/r1409.log](../agent_logs/r1409.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: elaboration of scratch files for `#print axioms`, `rfl` identifications and short screening lemmas on objects constructed for the purpose, each finishing in seconds, no numerics. Record: [findings/second-order.md](../findings/second-order.md), Lemma L24 ("second-order optimality as an eigenvalue bound"), statement and argument. Lean: commit 8ac559c8, [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean), [RecordNormed.lean](../lean/HamiltonsCubic/Results/RecordNormed.lean), [CurvOpInner.lean](../lean/HamiltonsCubic/Results/CurvOpInner.lean) (`curvOpCore`), [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) (`innerOp2`, `normSq2`, `Pcubic2`), [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) (`foxProd2`), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) (`norm_nonneg` at line 280), Mathlib's `Rayleigh.lean`, and the L24 and "Base: record norm" rows of [lean/INDEX.md](../lean/INDEX.md). Prior reviews: [r1406](REVIEW_r1406.md), which named the missing symmetry, and [r1408](REVIEW_r1408.md), which diagnosed the `norm_nonneg` timeout.

**Standfirst.** The commit closes the gap r1406 named. `LeRestr_isSymmetric` is the self-adjointness of $L_e|_{W^\perp}$ under the record's own pairing, and `L24_lambda_max` bounds the supremum of the Rayleigh quotient of that operator over nonzero vectors of $W^\perp\cap\mathcal W_n$, which is the record's $\lambda_{\max}(L_e|_{W^\perp})$. The inner product and norm on `weylPerpR a` reduce by `rfl` to `innerOp2` and to $\sqrt{\texttt{normSq2}}$, the family is bounded above (screened), and Mathlib's spectral step makes the supremum an eigenvalue, so the `iSup` is a genuine maximum and never Lean's junk value. `[Nontrivial (weylPerpR a)]` is a hypothesis of that Mathlib lemma. At trivial $W^\perp$ the `iSup` over an empty type is `0` and the bound would hold trivially, so the hypothesis costs nothing and excludes nothing the record means. The docstring's and the L24 row's "Not typed" lists are now accurate. The axioms are the standard three. **The gap is the "Base: record norm" row**: the commit rewrote it to blame a unification loop through `SeminormedAddGroup`, but the timeout is a name clash with the layer's own `HamiltonsCubic.RealLayer.norm_nonneg`, as r1408 found two minutes after this commit landed and as this review reproduced independently. The L24 row also still reads "pending" for this review.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1a. The inner product and norm on `weylPerpR a` are the record's | CONFIRMED | Screened by `rfl`: `inner ℝ x y = innerOp2 x y` on submodule elements, and `‖x‖ = ‖(x : RecCurv ι)‖`, so `RecCurv.norm_sq_eq` gives `‖x‖ ^ 2 = normSq2 x`. `curvOpCore` has `inner := innerOp2`, the record's $\tfrac12\sum_{ij}\langle R\varphi_{ij},S\varphi_{ij}\rangle$. |
| 1b. `LeRestr` is the record's $L_e\vert_{W^\perp}$ | CONFIRMED | Screened by `rfl`: `LeRestr x` is `foxProd2 ((Pcubic2 a)⁻¹ • a) x` on the underlying element. `foxProd2` is $\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, the record's $\circ$, and $(P(a))^{-1}a$ is $e=W/\theta$. `weylPerp a` is the Weyl operators orthogonal to $a$, the record's tangent space $W^\perp$ inside $\mathrm{Weyl}_n$. |
| 1c. The `iSup` is $\lambda_{\max}(L_e\vert_{W^\perp})$ | CONFIRMED | It is the supremum of $\langle L_ex,x\rangle/\lVert x\rVert^2$ over nonzero $x$, which for a symmetric operator is its top eigenvalue. The family is bounded above by the operator norm (screened as a lemma through `rayleighQuotient_le_norm`), and `hasEigenvalue_iSup_of_finiteDimensional` shows the supremum is an eigenvalue. So the value is the true maximum. |
| 1d. `[Nontrivial (weylPerpR a)]` and nonvacuity | CONFIRMED | Required by Mathlib's lemma. Over an empty index the `iSup` is `sSup ∅ = 0 ≤ ½`, so dropping the hypothesis would make the trivial case true for a junk reason, and the hypothesis keeps the statement to the case with content. At $n\ge4$ $\mathcal W_n$ has dimension at least $10$, so $W^\perp$ is nontrivial wherever the record applies. Existence of an `a` meeting the other hypotheses is untyped and listed. |
| 2. `LeRestr_isSymmetric` | CONFIRMED | Mathlib's `IsSymmetric` is $\langle Tx,y\rangle=\langle x,Ty\rangle$ for all `x y`, here under `innerOp2` by 1a (screened by applying the theorem at that type). The proof rests on `foxTri2_symm_right` at Weyl `x`, `y`, the record's full symmetry of $T$. Self-adjoint on the finite-dimensional real space `weylPerpR a` is exactly this. |
| 3a. "Not typed" in the docstring and the L24 row | CONFIRMED | The symmetry and the spectral step are removed, correctly. What remains (the Hessian as the operator identity $6\theta(L_e-\tfrac12\mathrm{Id})$, sharpness of $\tfrac12$ on the orbit, existence of a local maximiser with $Q(a)=\lambda a$) is what the record claims beyond the Lean. The simplicity of $1$ is typed in L24Eigen. |
| 3b. The L24 row otherwise | CONFIRMED WITH GAP | Content is right. "Gate 2: r1409, pending" needs this verdict. |
| 3c. "Base: record norm" row, the unification trap | REFUTED | The diagnosis is wrong. `norm_nonneg x` at `RecCurv ι` elaborates at once with default heartbeats outside the namespace, even with L24Restrict imported. It times out only inside `HamiltonsCubic.RealLayer` (or with it open), where `norm_nonneg` resolves against `HamiltonsCubic.RealLayer.norm_nonneg (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : 0 ≤ norm R`. `_root_.norm_nonneg x` elaborates there. `@norm_nonneg _ inferInstance x` fails inside the namespace with a type mismatch against the layer lemma. |
| 3d. `FiniteDimensional ℝ (RecCurv ι)` | CONFIRMED | `inferInstanceAs` on the same carrier and module structure, which is the right transport for a synonym. It is what `hasEigenvalue_iSup_of_finiteDimensional` consumes through the submodule. |
| 4. Axioms | CONFIRMED | `L24_lambda_max` and `LeRestr_isSymmetric`: `[propext, Classical.choice, Quot.sound]`. |

**One-line summary: CONFIRMED WITH GAP.** `L24_lambda_max` is Lemma L24's $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ under the record's pairing, with a genuine supremum and a harmless nontriviality hypothesis, and the gap is in the index: the record-norm row blames the unifier for what is a name clash, and the L24 row still reads "pending".

## 1. The supremum is the record's λ_max

The record's operator is $L_e=e\circ(\cdot)$ with $e=W/\theta$ and $\theta=P(W)$, restricted to $W^\perp$, the tangent space of the unit sphere of $\mathrm{Weyl}_n$ at $W$. Its argument notes that $L_e$ is self-adjoint "so $\lambda_{\max}$ is defined at all" and that $W^\perp$ is invariant "so the restriction is a genuine operator rather than a compression". Both are now typed: invariance by `LeLin_mapsTo` (r1406) and self-adjointness by `LeRestr_isSymmetric`.

Scratch file screens, each elaborating against the committed files:

- `inner ℝ x y = innerOp2 ((x : RecCurv ι) : CurvOp2 ι) ((y : RecCurv ι) : CurvOp2 ι)` for `x y : weylPerpR a`, by `rfl`.
- `‖x‖ = ‖(x : RecCurv ι)‖`, by `rfl`, and `‖x‖ ^ 2 = normSq2 _` by `RecCurv.norm_sq_eq`.
- The coercion of `LeRestr ha hWa hcrit hθ x` equals `foxProd2 ((Pcubic2 a)⁻¹ • a) x`, by `rfl`.
- `BddAbove (Set.range fun x : {x // x ≠ 0} => re ⟪T x, x⟫ / ‖x‖ ^ 2)` for every `T : Module.End ℝ (weylPerpR a)`, via `ContinuousLinearMap.rayleighQuotient_le_norm` on `LinearMap.toContinuousLinearMap T`.

In ℝ, `iSup` of a family not bounded above, or over an empty index, is `0` by convention, which would make a `≤ ½` statement hollow. Neither case occurs with content: the family is bounded (last screen), and the empty case is excluded by `[Nontrivial (weylPerpR a)]`. Mathlib's `hasEigenvalue_iSup_of_finiteDimensional` then says the supremum is an eigenvalue of `LeRestr`, and `L24_restrict` bounds every eigenvalue by $\tfrac12$. So the statement bounds the largest eigenvalue, as the record does.

The nontriviality hypothesis is typeclass-bracketed, so a caller supplies it by `haveI`. It is required by the Mathlib lemma rather than by the truth of the bound, which holds trivially at $W^\perp=0$. The record works at $n\ge4$, where $\dim\mathcal W_n\ge10$ and $W^\perp$ has dimension at least $9$.

## 2. Symmetry

`LinearMap.IsSymmetric T` is `∀ x y, ⟪T x, y⟫ = ⟪x, T y⟫`. At `T = LeRestr`, by section 1, this is $\langle e\circ x,y\rangle=\langle x,e\circ y\rangle$ in `innerOp2` for Weyl $x,y\perp a$. The proof rewrites with `innerOp2_comm` and applies `foxTri2_symm_right`, whose hypotheses are self-adjointness of `x` and `y`, both Weyl. That is the record's "$T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric", used in slots two and three. The statement is the correct reading of self-adjointness on a finite-dimensional real inner product space.

## 3. The index and the docstring

**L24 row and docstring.** The removed item (symmetry and spectral step) is now typed. The three remaining items are the record's Hessian identity, sharpness and the existence of a maximiser, which is the complete list of what the record claims and the Lean does not. The row's "Gate 2: r1409, pending" should carry this verdict. Cosmetic: the docstring's new bullet is separated from its list by a blank line, and `L24_lambda_max`'s docstring follows the previous proof with no blank line.

**Base: record norm row.** The commit replaced the old "DEFECT" with "`norm_nonneg x` at a `RecCurv ι` element exhausts even ten times the heartbeat budget, while `@norm_nonneg _ inferInstance x` and `norm_add_le` elaborate at once, so the instance works and the unifier's path to it through `SeminormedAddGroup` loops". Screens, default heartbeats:

- Importing only RecordNormed, with no namespace open: `norm_nonneg x` elaborates, at a generic `ι` and at `Fin 3`.
- Importing L24Restrict (or L24Eigen, FoxBridge, L209WeylClosure, L66Weyl) with no namespace open: `norm_nonneg x` elaborates.
- Importing only RecordNormed with `open HamiltonsCubic.RealLayer`, or inside `namespace HamiltonsCubic.RealLayer`: **timeout at `isDefEq`**, on `RecCurv ι` and on `weylPerpR a` elements alike.
- Inside the namespace, `_root_.norm_nonneg x` elaborates, and `@norm_nonneg _ inferInstance x` fails with a type mismatch against `HamiltonsCubic.RealLayer.norm_nonneg`, whose type is `∀ (R : Matrix ι ι ℝ → Matrix ι ι ℝ), 0 ≤ norm R` ([WeylReal.lean:280](../lean/HamiltonsCubic/Base/WeylReal.lean#L280)).
- `norm_add_le` and `positivity` on `RecCurv ι` elaborate with the namespace open, which is why they looked healthy.

So the loop is the overload resolution trying the layer's lemma about matrix maps, and the instance is fine. This agrees with [r1408](REVIEW_r1408.md) item 5b, which was committed two minutes after 8ac559c8 and so could not have informed it. The row should name the clash and its fix (`_root_.norm_nonneg`, or renaming the layer lemma), and its "Not done: a norm instance on which `norm_nonneg` elaborates" should go, since that instance exists.

## 4. Axioms

```
'HamiltonsCubic.RealLayer.L24_lambda_max' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.LeRestr_isSymmetric' depends on axioms: [propext, Classical.choice, Quot.sound]
```
