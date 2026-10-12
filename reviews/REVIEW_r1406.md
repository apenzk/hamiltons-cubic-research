# REVIEW r1406: L24 on the restricted operator in Lean, `isWeyl2_foxProd2`, `LeLin_mapsTo`, `L24_restrict`

Log [agent_logs/r1406.log](../agent_logs/r1406.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: two elaborations of scratch files, one for `#print axioms` and one screening a ten-line symmetry lemma, no numerics. Record: [findings/second-order.md](../findings/second-order.md), Lemma L24 ("second-order optimality as an eigenvalue bound, the canonical statement") and Lemma L125 ("L24 off $W^\perp$"), and [findings/curvature-invariants.md](../findings/curvature-invariants.md), Lemma L209. Lean: [L24Restrict.lean](../lean/HamiltonsCubic/Results/L24Restrict.lean), [TensorBridge.lean](../lean/HamiltonsCubic/Results/TensorBridge.lean) (`extend`, `isWeyl_extend`), [FoxBridge.lean](../lean/HamiltonsCubic/Results/FoxBridge.lean) (`foxProd_extend`), [L209WeylClosure.lean](../lean/HamiltonsCubic/Results/L209WeylClosure.lean) (`foxProd_isWeylOp`), [RecordNormed.lean](../lean/HamiltonsCubic/Results/RecordNormed.lean) (`RecCurv`), [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean) (`IsWeyl`), [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) (`IsWeyl2`), [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) (`foxTri2_symm_right`), [L24Eigen.lean](../lean/HamiltonsCubic/Results/L24Eigen.lean) (`Le_self`, `L24_eigen`), the L24 and L125 rows of [lean/INDEX.md](../lean/INDEX.md).

**Standfirst.** `isWeyl2_foxProd2` is L209's polarised closure on `CurvOp2`, and the transfer through `extend` recovers all three `IsWeyl2` clauses exactly, the fourth `IsWeyl` clause being the type. `weylPerp a` is the record's $W^\perp$ inside $\mathrm{Weyl}_n$, `LeLin a` is $L_e$, and `weylPerpR` and `LeRestr` re-read them on `RecCurv`, whose module structure is `CurvOp2`'s by `inferInstanceAs`, so nothing changes in meaning. `LeLin_mapsTo` is L125's invariance claim, proved from exactly the ingredients L125 names (self-adjointness of $L_e$ and $L_eW=W$) plus the Weyl closure L125 leaves tacit, under hypotheses weaker than L125's (criticality in place of maximality). `L24_restrict` bounds every real eigenvalue of the restricted operator, which is $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ once the restriction is known to be symmetric. **That symmetry is not typed, and it is ten lines away**: a screen elaborated `LeRestr_isSymmetric` from `foxTri2_symm_right` on the standard three axioms, after which Mathlib's `LinearMap.IsSymmetric.hasEigenvalue_iSup_of_finiteDimensional` makes the top Rayleigh quotient an eigenvalue with nothing further. The "Not typed" list is accurate. The L125 row of lean/INDEX.md still owes "that $L_e$ is self-adjoint with $L_eW=W$", which this file and `Le_self` now largely discharge.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1. `isWeyl2_foxProd2` is L209's $X,Y\in\mathcal W_n\Rightarrow X\circ Y\in\mathcal W_n$ | CONFIRMED | `foxProd_isWeylOp` gives `IsWeylOp` of the bare product of the extensions. `foxProd_extend` identifies it with `foxProd2 A B` on every skew argument, and each of the three `IsWeyl2` clauses quantifies only over skew arguments or the $\varphi_{ij}$, so each is recovered verbatim. `IsWeyl`'s first clause (bivectors to bivectors) is `CurvOp2`'s type. `isLinOp_extend` supplies the `IsLinOp` half `foxProd_isWeylOp` needs. |
| 2a. `weylPerp a` is $W^\perp\cap\mathrm{Weyl}_n$ | CONFIRMED | Carrier `{v | IsWeyl2 v ∧ innerOp2 a v = 0}`, the record's pairing, at the record's $W=a$. |
| 2b. `LeLin a` is $L_e$ | CONFIRMED | `foxProd2 ((Pcubic2 a)⁻¹ • a) v`, $e=a/P(a)$, as in r1405. Linearity by `foxProd2_add_right` and `foxProd2_smul_right`. |
| 2c. `weylPerpR a`, `LeRestr` on `RecCurv` | CONFIRMED | `RecCurv ι := CurvOp2 ι` with `AddCommGroup` and `Module ℝ` by `inferInstanceAs`, so elements, sum and scaling are identical. `weylPerpR` has the same carrier set, and `LeRestr` is `LeLin a` cast to `RecCurv →ₗ RecCurv` and restricted by `LinearMap.restrict`. The eigenvector of `LeRestr` returns to `foxProd2 … v = μ • v` by `congrArg Subtype.val`, which is `L24_eigen`'s hypothesis. |
| 3. `LeLin_mapsTo` is L125's invariance | CONFIRMED | L125: "$L_e$ is self-adjoint with $L_eW=W$, so $W^\perp$ is invariant". Lean: Weyl closure (item 1), then $\langle a,L_ev\rangle=\langle L_ea,v\rangle$ by `foxTri2_symm_right` at the Weyl $v$ and $a$, then `Le_self`. Hypotheses: unit, Weyl, $Q(a)=\lambda a$, $P(a)\ne0$, which a maximiser with $\theta>0$ satisfies. |
| 4a. `L24_restrict` is $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$ | CONFIRMED WITH GAP | Faithful for a symmetric operator on a finite-dimensional real space, where every eigenvalue is real and $\lambda_{\max}$ is one. For a non-symmetric real endomorphism `HasEigenvalue` could be empty and the bound vacuous. Symmetry holds and is not typed in the file. See section 4. |
| 4b. "Not typed" list and the L24 INDEX row | CONFIRMED WITH GAP | Accurate: every named theorem exists and states what the row says, the axioms are the standard three, and the four untyped items are untyped. Complete for L24. Two stale cross-row points: the row's Gate 2 for r1406 still reads "pending", and the L125 row's owed item is now mostly discharged. |
| 4c. The spectral step needs self-adjointness | CONFIRMED | Yes, and once `IsSymmetric` is typed nothing more is needed: `hasEigenvalue_iSup_of_finiteDimensional` makes $\sup_x\langle Tx,x\rangle/\lVert x\rVert^2$ an eigenvalue, on `FiniteDimensional` and `Nontrivial` instances. A screen typed the symmetry in ten lines. |
| 5. Axioms | CONFIRMED | `L24_restrict`, `isWeyl2_foxProd2`: `[propext, Classical.choice, Quot.sound]`. |

**One-line summary: CONFIRMED WITH GAP.** The file's objects are the record's $W^\perp$ and $L_e|_{W^\perp}$, invariance is L125's argument on L125's ingredients, and the only step between `L24_restrict` and $\lambda_{\max}\le\tfrac12$ is the symmetry of `LeRestr`, which is untyped, correctly listed, and a short lemma.

## 1. `isWeyl2_foxProd2` and the transfer through `extend`

`extend R` precomposes `R` with the skew projection $X\mapsto\tfrac12(X-X^{\mathsf T})$, so it is a bare function on all matrices that agrees with `R` on $\Lambda^2$ (`extend_apply`). `isWeyl_extend` turns `IsWeyl2 R` into the four-clause `IsWeyl (extend R)`: clause one because the output is a `skewSub` element, the other three by `extend_apply`. `isLinOp_extend` proves `IsLinOp (extend R)` over all matrices, which the bare closure `foxProd_isWeylOp` requires.

The return trip is where information could be lost, and none is. `IsWeyl2 (foxProd2 A B)` has three clauses:

1. Self-adjointness over `X Y : skewSub ι`. The proof rewrites `foxProd2 A B X` as `foxProd (extend A) (extend B) X` by `foxProd_extend`, then applies `IsWeyl`'s self-adjointness clause at the skew `X.2`, `Y.2`.
2. Bianchi over the $\varphi_{ij}$. `applyPhi (foxProd2 A B) i j` is rewritten to the bare product at `phi i j`, a skew argument, and `IsWeyl`'s Bianchi clause closes it.
3. Ricci over the $\varphi_{ac}$, the same way.

`foxProd_extend` is an equality at every skew argument, so it transports each clause exactly. The asymmetry "three clauses against four" is `IsWeyl`'s first clause, which `CurvOp2` carries in its type, as the `IsWeyl2` docstring says. The theorem is L209's sentence "by polarisation, $X,Y\in\mathcal W_n\Rightarrow X\circ Y\in\mathcal W_n$", with $\circ$ the record's polarisation `foxProd2` (confirmed r1405).

## 2. $W^\perp$, $L_e$, and the synonym

The record's $W^\perp$ in L24 is the orthogonal complement of $W$ in the tangent space to the unit sphere of $\mathrm{Weyl}_n$, which is $\{v\in\mathrm{Weyl}_n:\langle W,v\rangle=0\}$. `weylPerp a` is exactly that set, with the pairing `innerOp2`, the record's $\Lambda^2$ pairing (r1405, Bivectors2). The definition takes any `a`. Unit norm enters only where L24 needs it, through `LeLin_mapsTo` and `LeRestr`.

`RecCurv` is a `def` synonym for `CurvOp2` whose `AddCommGroup` and `Module ℝ` are `inferInstanceAs` the originals, and `RecCurv.equiv` is `LinearEquiv.refl`. So a submodule of `RecCurv` with carrier `{v | v ∈ weylPerp a}` is the same subset closed under the same operations, and `weylPerpR`'s closure proofs are literally `weylPerp`'s. The only structure `RecCurv` adds is the inner product, which is `innerOp2` by `RecCurv.inner_eq` (`rfl`). The file's reason for the synonym, that on `CurvOp2` the `ContinuousLinearMap` instances do not reach a submodule's additive group, is an elaboration matter and changes no statement. `LeRestr` is `LeLin a` viewed as a linear map on `RecCurv` (the `show` coerces with no change of function) and restricted along `LeLin_mapsTo`.

## 3. `LeLin_mapsTo` against L125

L125's proof: "$L_e$ is self-adjoint with $L_eW=W$, so $W^\perp$ is invariant." L24's Argument says the same: "$L_ee=e$ by criticality and self-adjointness then carries the complement." For $v\in W^\perp\cap\mathrm{Weyl}_n$ the Lean proof shows two things:

- **Weyl membership**: `isWeyl2_foxProd2` at $e=\theta^{-1}a$ (Weyl by `isWeyl2_smul`) and $v$. This is L209. The record uses it tacitly, since it defines $L_e$ as an operator on $\mathrm{Weyl}_n$. The Lean makes it explicit and proves it.
- **Orthogonality**: $\langle a,e\circ v\rangle=T(e,v,a)=T(e,a,v)=\langle e\circ a,v\rangle=\langle a,v\rangle=0$. The swap is `foxTri2_symm_right`, which requires its second and third arguments self-adjoint. Both are Weyl (`hWv`, `hWa`), and $e$ may be arbitrary. This is the self-adjointness of $L_e$ on the Weyl operators, the record's r285 Claim 1. The last step is `Le_self`, which uses unit norm and criticality to pin $\lambda=P(a)$ (r1405 item 4).

The hypotheses are unit, Weyl, critical, $P(a)\ne0$. L125 states "a maximiser $W$ of unit norm with $\theta>0$". A maximiser is critical, so the Lean is at least as general, and it uses exactly the ingredients L125 names. L125's displayed inequality $\langle Y,L_eY\rangle\le\tfrac12\lVert Y\rVert^2+\tfrac12\langle W,Y\rangle^2$ is a separate statement, typed in [L125Statement.lean](../lean/HamiltonsCubic/Results/L125Statement.lean) with L24 as a binder. This file does not touch it and does not claim to.

## 4. `L24_restrict`, the spectral step, and the INDEX row

`Module.End.HasEigenvalue f μ` on a real module means a nonzero $v$ with $fv=\mu v$ and $\mu\in\mathbb R$. `L24_restrict` says every such $\mu$ for `LeRestr` is at most $\tfrac12$. It passes the eigenvector to `L24_eigen`, whose hypotheses (Weyl, $\perp a$, nonzero, $L_ev=\mu v$) are exactly membership in `weylPerp a` plus the eigen-equation.

**Is "every eigenvalue $\le\tfrac12$" the same as $\lambda_{\max}\le\tfrac12$?** For a symmetric operator on a nontrivial finite-dimensional real inner product space, yes: all eigenvalues are real, $\lambda_{\max}$ is attained, and it equals the top Rayleigh quotient. For a general real endomorphism, no: there may be no real eigenvalue, and then the Lean statement is vacuous. The record says $L_e$ is self-adjoint, "so $\lambda_{\max}$ is defined at all", so the fidelity rests on the symmetry of `LeRestr`. The file does not prove it, and the "Not typed" list names it.

**Is more than self-adjointness needed?** No. The screen below elaborated with the standard three axioms:

```lean
theorem LeRestr_isSymmetric … : (LeRestr ha hWa hcrit hθ).IsSymmetric := by
  intro u w
  have hu : ((u : RecCurv ι) : CurvOp2 ι) ∈ weylPerp a := u.2
  have hw : ((w : RecCurv ι) : CurvOp2 ι) ∈ weylPerp a := w.2
  have key := foxTri2_symm_right ((Pcubic2 a)⁻¹ • a) ((u : RecCurv ι) : CurvOp2 ι)
    ((w : RecCurv ι) : CurvOp2 ι) hu.1.isSelfAdjoint2 hw.1.isSelfAdjoint2
  unfold foxTri2 at key
  rw [Submodule.coe_inner, Submodule.coe_inner, RecCurv.inner_eq, RecCurv.inner_eq]
  refine key.trans ?_
  exact innerOp2_comm _ _
```

Mathlib's `LinearMap.IsSymmetric.hasEigenvalue_iSup_of_finiteDimensional` then gives `HasEigenvalue T (⨆ x, re ⟪T x, x⟫ / ‖x‖²)` under `[FiniteDimensional ℝ E] [Nontrivial E]`. With `L24_restrict` this bounds the supremum by $\tfrac12$, which is $\lambda_{\max}\le\tfrac12$ literally. The remaining inputs are a `FiniteDimensional` instance on `weylPerpR a` (from `CurvOp2` being finite-dimensional) and `Nontrivial (weylPerpR a)`, which holds when $\dim\mathrm{Weyl}_n\ge2$, i.e. $n\ge4$. Neither was checked here. The quadratic-form reading, $\langle L_ev,v\rangle\le\tfrac12$ at every unit $v\in W^\perp$, is already `L24_weyl`, which is the Rayleigh-quotient form of $\lambda_{\max}$ with no spectral theorem at all.

**The INDEX row.** Each named theorem exists and states what the row says, and `#print axioms` confirms the standard three. The "Not typed" list names the spectral step, with the correct requirement, the Hessian as an operator identity, sharpness, and existence of a maximiser. Nothing the record's L24 claims is missing from it. Three bookkeeping points:

1. The row's Gate 2 entry for r1406 reads "pending" and should carry this verdict.
2. The spectral item could say that the symmetry is a short lemma from `foxTri2_symm_right` and that `hasEigenvalue_iSup_of_finiteDimensional` then closes the step.
3. The L125 row ("**Owed**: that $L_e$ is self-adjoint with $L_eW=W$") is stale. $L_eW=W$ is `Le_self`, and self-adjointness on the Weyl operators is `foxTri2_symm_right`, packaged as an `IsSymmetric` lemma by the screen above but not yet in the tree.

## 5. Axioms

A scratch file importing `HamiltonsCubic.Results.L24Restrict`:

```
'HamiltonsCubic.RealLayer.L24_restrict' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.isWeyl2_foxProd2' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.LeRestr_isSymmetric' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The third is the screen of section 4, which lives only in the scratchpad.
