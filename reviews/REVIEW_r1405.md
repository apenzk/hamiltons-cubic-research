# REVIEW r1405: L24 as an eigenvalue bound in Lean, `L24_eigen`, `Le_self`, `L24_simple`

Log [agent_logs/r1405.log](../agent_logs/r1405.log). One reviewer, statement fidelity only (the kernel has checked the proofs). Analysis-only: one elaboration of a scratch file for `#print axioms` and `#check`, no numerics. Record: [findings/second-order.md](../findings/second-order.md), Lemma L24 ("second-order optimality as an eigenvalue bound, the canonical statement"), with its Step 5 on the full symmetry of $T$ and the closing paragraph on Weyl closure. Lean: [L24Eigen.lean](../lean/HamiltonsCubic/Results/L24Eigen.lean), [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) (`foxProd2`, `foxTri2`), [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) (`innerOp2`, `normSq2`, `IsWeyl2`, `Qop2`, `Pcubic2_eq_innerOp2`), [L24Weyl.lean](../lean/HamiltonsCubic/Results/L24Weyl.lean) (`L24_weyl`), [SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean), the L24 row of [lean/INDEX.md](../lean/INDEX.md).

**Standfirst.** `foxProd2` is the record's $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ verbatim, and `foxProd2 ((Pcubic2 a)⁻¹ • a)` is the record's $L_e$ with $e=W/\theta$, $\theta=P(W)$ at unit $W$. `L24_eigen` is a faithful per-eigenvector reading of $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$, `Le_self` correctly derives $\lambda=P(a)$ from the unit norm, and `L24_simple` is the record's "1 is a simple eigenvalue" read on the Weyl operators, which is the record's own domain. The axioms are the standard three. The INDEX row's "Not typed" list is correct as far as it goes and omits two steps between the per-eigenvector bound and $\lambda_{\max}$ of the restricted operator: the $L_e$-invariance of $W^\perp$ (the record's own second implicit step, [Lemma L125](../findings/second-order.md)) and the spectral theorem that $\lambda_{\max}$ is attained by an eigenvector. No object satisfying the hypotheses is exhibited, and the existence of a maximiser of `Pcubic2` on the Weyl sphere with exact criticality is not typed anywhere.

| Item | Verdict | Reason |
| --- | --- | --- |
| 1a. `foxProd2` is the record's $\circ$ | CONFIRMED | `foxProd2 X Y = (1/2) • (Qop2 (X+Y) - Qop2 X - Qop2 Y)` with `Qop2 R = R∘R + R#`, the record's $Q(R)=R^2+R^\#$. The record's Step 5 gives the same polarisation. |
| 1b. $L_e$ and $e=W/\theta$ | CONFIRMED | `foxProd2 ((Pcubic2 a)⁻¹ • a)` is $e\circ(\cdot)$ with $e=a/P(a)$. The record's $\theta=P(W)$ is read at unit $W$, and `ha : normSq2 a = 1` supplies that. |
| 2a. `L24_eigen`'s hypotheses | CONFIRMED | Unit Weyl $a$, $Q(a)=\lambda a$, local maximality of `Pcubic2` on $\{\lVert R\rVert^2=1\}\cap\mathrm{Weyl}$, $P(a)>0$ are exactly `L24_weyl`'s (r1194) and the record's "critical point with $\theta>0$ that is a local maximiser". The eigenvector hypotheses (Weyl, $\perp a$, nonzero, $L_ev=\mu v$) are what an eigenvector of $L_e|_{W^\perp}$ is. |
| 2b. Conclusion $\mu\le\tfrac12$ as $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$ | CONFIRMED WITH GAP | Every eigenvalue that exists is bounded, which implies the record's statement once the restriction is an operator on $W^\perp$ with an eigenvector at $\lambda_{\max}$. Three steps sit between: Weyl closure of $L_e$ (listed), $L_e$-invariance of $W^\perp$ (not listed), and the spectral theorem for the self-adjoint restriction (not listed). See section 2. |
| 2c. INDEX "Not typed" list | CONFIRMED WITH GAP | The three listed items (Weyl closure, the Hessian as an operator identity, sharpness along the orbit) are correct and are not typed. The two steps of 2b are missing from the list. Nothing the record claims is silently dropped beyond those. |
| 3. `L24_simple` is "1 is a simple eigenvalue" | CONFIRMED | With `Le_self`, the $1$-eigenspace of $L_e$ inside the Weyl operators is exactly $\mathbb Ra$. The record's $L_e$ acts on $\mathrm{Weyl}_n$, so restricting eigenvectors to Weyl $v$ is the record's domain, and $v$ ranges over all Weyl operators, including the $a$ direction. For a self-adjoint operator geometric and algebraic multiplicity agree, so geometric simplicity is the record's "simple". |
| 4. `Le_self` derives $\lambda=P(a)$ | CONFIRMED | `Pcubic2_eq_innerOp2` gives $P(a)=\langle a,Q(a)\rangle=\langle a,\lambda a\rangle=\lambda\lVert a\rVert^2=\lambda$ by `ha`. Then $L_ea=\theta^{-1}Q(a)=\theta^{-1}\lambda a=a$. The free `lam` is pinned, and `Le_self` needs neither Weyl nor maximality. |
| 5. Non-vacuity | CONFIRMED WITH GAP | No object satisfying the hypotheses is exhibited, which the INDEX row says. At `Fintype.card ι ≤ 3` the Weyl space is zero and the hypotheses are unsatisfiable. Existence of a maximiser is typed only abstractly (`SphereAttains.exists_max` on a `NormedSpace`), never for `Pcubic2` on the `normSq2` Weyl sphere, and exact criticality $Q(a)=\lambda a$ at it needs the off-file $\operatorname{Ric}(Q(W))=0$. See section 5. |
| 6. Axioms | CONFIRMED | `L24_eigen`, `L24_simple`, `Le_self`: `[propext, Classical.choice, Quot.sound]`. |

**One-line summary: CONFIRMED WITH GAP.** The three theorems say what the record says, eigenvector by eigenvector and on the Weyl operators, and the INDEX row's "Not typed" list should add the invariance of $W^\perp$ under $L_e$ and the spectral step from per-eigenvector bounds to $\lambda_{\max}$.

## 1. The product and the operator

`foxProd2` in [FirstVariation.lean](../lean/HamiltonsCubic/Results/FirstVariation.lean) line 57 is the record's definition transcribed, over `CurvOp2`, the continuous linear endomorphisms of $\Lambda^2$. `Qop2` is `compOp2 R + sharpMapCL R`, which is $R^2+R^\#$. The file proves bilinearity and $v\circ v=Q(v)$ by pairing against every test operator through `foxTri2_split` and the definiteness lemma `eq_of_innerOp2`. `foxProd2_self` is the polarisation identity, so the definition is internally consistent with the record's $Q$.

The operator in every statement is `foxProd2 ((Pcubic2 a)⁻¹ • a)`, first slot $e$. Since $\circ$ is commutative (`foxProd2_comm`), the slot does not matter. With `ha` the record's $\theta=P(W)$ at unit $W$ is `Pcubic2 a`, so $e=a/\theta$ exactly.

## 2. `L24_eigen` against $\lambda_{\max}(L_e|_{W^\perp})\le\tfrac12$

The proof reads the Rayleigh quotient: $\langle L_ev,v\rangle=\theta^{-1}\langle a,Q(v)\rangle$ by full symmetry of $T$ on self-adjoint operators (`innerOp2_foxProd2_self`), and `L24_weyl` bounds $\langle a,Q(w)\rangle\le\theta/2$ at the unit $w=v/\lVert v\rVert$. At an eigenvector the quotient is $\mu$, so $\mu\le\tfrac12$. The logic is sound and the statement is the per-eigenvector form.

The record's statement is about the largest eigenvalue of the restricted operator. Getting there from the per-eigenvector form needs three things.

1. **Weyl closure of $L_e$**, so that $L_e$ is an operator on $\mathrm{Weyl}_n$. Listed as not typed. The record's own Step 5 flags the same point ("self-adjointness as an operator ON $\mathcal W_n$ needs $X\circ Y\in\mathcal W_n$").
2. **$L_e$-invariance of $W^\perp$** inside $\mathrm{Weyl}_n$, which the record's Argument calls its second implicit step and routes to Lemma L125: $\langle a,L_ev\rangle=\langle L_ea,v\rangle=\langle a,v\rangle=0$. The ingredients are on file (`Le_self`, `foxTri2_symm_right`), but the statement is not typed and is not on the INDEX list.
3. **The spectral theorem** for the self-adjoint restriction, so that $\lambda_{\max}$ is attained by an eigenvector that `L24_eigen` then bounds. Not typed and not listed.

If Weyl closure fails, the natural meaning of the record's $\lambda_{\max}$ is that of the compression $\pi_{W^\perp}L_e$, whose largest eigenvalue is the maximum Rayleigh quotient over unit Weyl $v\perp a$. That reading is `L24_weyl` itself, up to the Rayleigh–Ritz identification, which is also not typed. Either reading is therefore covered in content, and neither is closed in Lean as a statement about $\lambda_{\max}$.

Nothing else is dropped. The Hessian identity $6\theta(L_e-\tfrac12\mathrm{Id})$ and sharpness are on the list. The record's remarks on criticality of pieces, the Scope paragraph's $\theta\ge0$ at a local maximiser, and the prior art are commentary, not part of the statement being formalised.

## 3. `L24_simple`

`L24_simple` proves that a Weyl $v$ with $L_ev=v$ equals $\langle a,v\rangle a$. The proof splits $v=v'+\langle a,v\rangle a$ with $v'\perp a$ Weyl, uses `Le_self` to get $L_ev'=v'$, and applies `L24_eigen` at $\mu=1$ to force $v'=0$. Together with `Le_self` the $1$-eigenspace within the Weyl operators is $\mathbb Ra$.

The record's $L_e$ acts on $\mathrm{Weyl}_n$ ("the unit sphere of $\mathrm{Weyl}_n$", "every eigenvalue off $W$"), so eigenvectors are Weyl by the record's own domain, and the restriction is the right reading. The record's Krasnov–Tkachev source states $1$ simple for the operator on the whole algebra, which here is $\mathrm{Weyl}_n$. For a self-adjoint operator geometric multiplicity one is simplicity, and self-adjointness of the compression is on file through `foxTri2_symm_right`. Weyl closure is not needed for this statement as typed: an eigenvector in `CurvOp2` that is Weyl is exactly what the record's eigenvector is when closure holds, and when it fails the statement is about the eigenvectors that exist.

## 4. The free multiplier

`hcrit : Qop2 a = lam • a` leaves `lam` free. `Le_self` rewrites `Pcubic2 a` as `innerOp2 a (Qop2 a)`, substitutes `hcrit`, pulls the scalar out and uses `normSq2 a = 1`, giving `Pcubic2 a = lam`. The inverse `(Pcubic2 a)⁻¹` is then cancelled against `lam` using `hθ`. This is the record's $\theta=P(W)$ at a unit critical point, derived rather than assumed, and it is correct.

The exact form $Q(a)=\lambda a$ is the record's criticality equation. The record notes (closing paragraph of the first-variation derivation) that turning "critical on the Weyl sphere" into $Q(W)=\theta W$ rather than $\operatorname{proj}_{\mathcal W}Q(W)=\theta W$ needs $\operatorname{Ric}(Q(W))=0$, which is off file. So `hcrit` is an extra hypothesis relative to local maximality alone, carried unchanged from `L24_weyl` (r1194), and it matches the record's "Let $W$ be a critical point".

## 5. Non-vacuity

The file exhibits no object. A witness would need a unit Weyl operator that is a local maximiser of `Pcubic2` on the Weyl sphere, with exact criticality and positive value, which is well beyond a statement-fidelity screen and is not attempted.

- **At `Fintype.card ι ≤ 3`** the Weyl space is zero, so `normSq2 a = 1 ∧ IsWeyl2 a` is unsatisfiable and both theorems are vacuous there. This matches the record, whose lemma concerns $n\ge4$.
- **Existence by compactness is not typed for this problem.** `SphereAttains.exists_max` is generic over a finite-dimensional `NormedSpace`, and [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean) records that the `normSq2` norm on `CurvOp2` is not registered as an instance. No theorem in the layer produces an `a` with `IsLocalMaxOn Pcubic2 {R | normSq2 R = 1 ∧ IsWeyl2 R} a` (grep over `exists_isMaxOn`, `IsCompact.exists`, `IsLocalMaxOn Pcubic2`).
- **Exact criticality at a maximiser** needs the off-file $\operatorname{Ric}(Q(W))=0$ (section 4). A compactness argument alone would give `hmax` but not `hcrit`.

So `L24_eigen` and `L24_simple` are vacuous exactly if no such $a$ exists. The record asserts maximisers exist by compactness and that $\theta>0$ at a global one, which makes the hypotheses satisfiable in the record's mathematics at $n\ge4$, but nothing in Lean shows it. The INDEX row's sentence "No object satisfying `L24_weyl`'s hypotheses is exhibited in Lean" is accurate, and could add that the existence of a maximiser with exact criticality is untyped.

## 6. Axioms

Scratch file importing `HamiltonsCubic.Results.L24Eigen`:

```
'HamiltonsCubic.RealLayer.L24_eigen' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.L24_simple' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.Le_self' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `sorryAx`, no `native_decide` axiom.

## 7. Recommended repairs

1. Add to the L24 row's "Not typed" list, and to the module docstring of [L24Eigen.lean](../lean/HamiltonsCubic/Results/L24Eigen.lean): the $L_e$-invariance of $W^\perp$ (Lemma L125's step, two lines from `Le_self` and `foxTri2_symm_right`), and the spectral step from per-eigenvector bounds to $\lambda_{\max}$ of the self-adjoint restriction.
2. Add to the row's non-vacuity sentence that existence of a local maximiser of `Pcubic2` on the Weyl sphere is untyped, and that exact criticality there rests on the off-file $\operatorname{Ric}(Q(W))=0$.
