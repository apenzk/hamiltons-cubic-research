# REVIEW r1458: L24's Riemannian Hessian as an operator in Lean, commit 4d23699f: hessQ, hessQ_eq, hessOp, hessQ_op, hessB_op, the L24 row's **proved**, and the Lemma 51 certificate sentence

Log [agent_logs/r1458.log](../agent_logs/r1458.log). One reviewer, working cold, statement fidelity and hypothesis use against the record. Analysis-only: `lake build HamiltonsCubic.Results.L24HessOp` (clean, one style warning from the `show` linter at [L24HessOp.lean:84](../lean/HamiltonsCubic/Results/L24HessOp.lean)), and one scratch file in the session scratchpad (outside the repository) carrying `#print axioms` for `hessQ_op`, `hessB_op`, `hessQ_eq` and `#print hessQ`. Every algebraic step was checked by hand. No numerical screen was run.

**Standfirst.** The record's claim, quoted from [second-order.md:61](../findings/second-order.md): "The **Riemannian** Hessian of $P$ on the unit sphere of $\mathrm{Weyl}_n$, the restriction of the ambient second differential **plus** the constraint's $-3\theta\,\mathrm{Id}$, the two differing by exactly that, is $6\theta\big(L_e-\tfrac12\mathrm{Id}\big)$. Hence if $W$ is a **local** maximiser, $\lambda_{\max}\big(L_e|_{W^\perp}\big)\le\tfrac12$." The commit types the first sentence as an operator identity on $W^\perp$, through `hessQ`, a definition of the Riemannian Hessian's quadratic form by the geodesic identity, and polarisation. The mathematics is right, the hypotheses are the ones under which the curve is a geodesic, and the axioms are the standard three. The one gap is downstream: the L170 row and file still name this identity as owed and untypable.

| Item | Verdict | Reason |
| --- | --- | --- |
| A. `hessQ` is the Riemannian Hessian's quadratic form | CONFIRMED | At unit $a$ and $v\in W^\perp\setminus0$, $u=v/\lVert v\rVert$ is unit, Weyl and orthogonal to $a$, so $\gamma(t)=\cos t\,a+\sin t\,u$ is a unit-speed great circle inside the unit Weyl sphere, hence a geodesic of it. $\mathrm{Hess}f(v,v)=\lVert v\rVert^2(f\circ\gamma)''(0)$ is the standard identity. `Pcubic2` is the ambient cubic, and it agrees with $P|_S$ along $\gamma\subset S$. The tangent space is `weylPerpR a`, Weyl and $\perp a$. The theorems that name the Hessian (`hessQ_op`, `hessB_op`) carry `ha`. |
| B. `hessQ_eq`, `hessOp`, `hessQ_op`, `hessB_op` | CONFIRMED | $r^2\cdot6(r^{-2}\langle a,Q(v)\rangle-\tfrac12P(a))=6(\langle a,Q(v)\rangle-\tfrac12P(a)r^2)$. $\langle6\theta(L_ev-\tfrac12v),v\rangle=6(\langle a,Q(v)\rangle-\tfrac12\theta\lVert v\rVert^2)$ by $\langle L_ev,v\rangle=\theta^{-1}\langle a,Q(v)\rangle$. Polarisation uses `LeRestr_isSymmetric`. The scale $6\theta$ with $\theta=P(a)$ at unit $a$ is the record's. |
| C. Axioms | CONFIRMED | `hessQ_op`, `hessB_op`, `hessQ_eq`: each `[propext, Classical.choice, Quot.sound]`. No `sorry`, `native_decide` or `axiom` in the file. |
| D. Record text | CONFIRMED | The L24 row's **proved** holds: the Statement's two clauses (the Hessian identity and the $\lambda_{\max}$ bound) and its "1 is simple" clause are all kernel-checked, and the row owes nothing. The report sentence is accurate and in status voice. |
| E. Downstream | CONFIRMED WITH GAP | [lean/INDEX.md:234](../lean/INDEX.md), the L170 row, still reads "**Owed: that $\mathrm{Hess}=6\theta(L_e-\tfrac12)$ on $W^\perp$, that $L_eW=W$**", and [L170.lean:18-21](../lean/HamiltonsCubic/Results/L170.lean) says both are statements "that the base layer has no type for". Both are now typed, the first by `hessQ_op`/`hessB_op`, the second by `Le_self` in [L24Eigen.lean](../lean/HamiltonsCubic/Results/L24Eigen.lean). |

**One-line summary.** L24's Hessian identity $\mathrm{Hess}(P|_S)_a=6\theta(L_e-\tfrac12\mathrm{Id})$ on $W^\perp$ is proved in Lean faithfully to the record, on the standard three axioms, and the one gap is the L170 row and docstring still calling it owed. **CONFIRMED WITH GAP**

## A. Is `hessQ` the Riemannian Hessian's quadratic form?

`#print hessQ` returns `innerOp2 v v * deriv (deriv fun t => Pcubic2 (Real.cos t • a + Real.sin t • (√(innerOp2 v v))⁻¹ • v)) 0`, as the brief states.

**The geodesic.** On the round unit sphere of a real inner product space, $t\mapsto\cos t\,a+\sin t\,u$ is a unit-speed geodesic exactly when $\lVert a\rVert=\lVert u\rVert=1$ and $u\perp a$: then $\lVert\gamma(t)\rVert^2=\cos^2t+\sin^2t=1$ and $\gamma''=-\gamma$ is normal. Here $u=r^{-1}v$ with $r=\sqrt{\langle v,v\rangle}$ is unit by construction, and $u\perp a$, $u$ Weyl, come from $v\in$ `weylPerpR a` (`IsWeyl2 v ∧ innerOp2 a v = 0`, [L24Restrict.lean:107](../lean/HamiltonsCubic/Results/L24Restrict.lean) on `weylPerp`). The unit norm of $a$ is `ha : normSq2 a = 1` on `hessOp`, `hessQ_op` and `hessB_op`. The Weyl subspace is linear, so $\gamma$ lies in the unit Weyl sphere, which is a great subsphere and totally geodesic, and $\gamma$ is a geodesic of it.

**`hessQ_eq` without `ha`.** It is an algebraic identity about the second derivative along the curve, which holds whatever $\lVert a\rVert$ is. It names nothing Riemannian by itself, and the file's docstring for it says only "the Hessian quadratic form at a critical point". The theorems that identify the operator carry `ha`. *Argued the other way*: a reader could take `hessQ_eq` as "the Hessian at non-unit $a$". Its docstring does not say so, and `hessQ_op` is what the INDEX row cites as the Hessian. Withdrawn as a candidate.

**The identity.** For a geodesic $\gamma$ with $\gamma(0)=a$, $\gamma'(0)=w$, $(f\circ\gamma)''(0)=\mathrm{Hess}f(w,w)+df(\nabla_{\gamma'}\gamma')=\mathrm{Hess}f(w,w)$, since $\nabla_{\gamma'}\gamma'=0$. For $w=v$ of length $r$ the geodesic is $t\mapsto\cos(rt)a+\sin(rt)u$, whose second derivative at $0$ is $r^2$ times the unit-speed one. So `hessQ a v` $=\mathrm{Hess}(P|_S)_a(v,v)$. This holds at every point, critical or not. The function is `Pcubic2`, the ambient cubic on `CurvOp2`, and since $\gamma$ stays in $S$ it coincides with $P|_S\circ\gamma$. The record's $-3\theta\,\mathrm{Id}$ is the difference between this and the ambient second differential $6\theta L_e$, which is the $-3P(a)$ coming from $\cos^3t$ in `circle_deriv2` ($-3A+6B$).

**The tangent space.** `weylPerpR a` is $\{v:\ v\text{ Weyl},\ \langle a,v\rangle=0\}$, the tangent space at $a$ of the unit sphere in $\mathcal W_n$, not of the full `CurvOp2` sphere. That matches the record's $T_aS=W^\perp$.

**The inner product.** `normSq2 = innerOp2 R R` ([Bivectors2.lean:283](../lean/HamiltonsCubic/Base/Bivectors2.lean)), the record's $\langle\cdot,\cdot\rangle$ carried to $\Lambda^2$, the same one `L24_weyl`, `L24_lambda_max` and `LeRestr_isSymmetric` use (Gate 2 r1194, r1409). The unit sphere, orthogonality and the Hessian are all taken in it.

**What the definition carries.** Mathlib has no Riemannian Hessian, so the identification of `hessQ` with it is the standard identity above, stated in the docstring and not a theorem. That is the natural and correct modelling, and the INDEX row describes it as a definition ("`hessQ`, the round sphere's Riemannian Hessian quadratic form ... along the unit-speed great circle"). `deriv` returns junk on non-differentiable functions, but the function is rewritten by `funext` to a trigonometric polynomial before `circle_deriv2` is applied, so no junk value enters.

## B. hessQ_eq, hessOp, hessQ_op, hessB_op

**`hessQ_eq`.** $v=0$: both sides are $0$ (`innerOp2_Qop2_zero`, via $Q(2\cdot0)=4Q(0)$). $v\ne0$: `L24_hessian` at $r^{-1}v$ gives $6(\langle a,Q(r^{-1}v)\rangle-\tfrac12P(a))=6(r^{-2}\langle a,Q(v)\rangle-\tfrac12P(a))$ by `Qop2_smul` (degree two). Multiplying by $r^2=\langle v,v\rangle$ gives $6(\langle a,Q(v)\rangle-\tfrac12P(a)\langle v,v\rangle)$. Correct. `L24_hessian`'s own hypotheses (Weyl $a$, Weyl $r^{-1}v$, $Q(a)=\lambda a$, $\langle a,r^{-1}v\rangle=0$) are all supplied.

**`hessOp`.** $(6P(a))\cdot(\mathrm{LeRestr}-\tfrac12\mathrm{id})$ on `weylPerpR a`, with $L_e=e\circ(\cdot)$, $e=a/P(a)$ (`LeLin`). This is the record's $6\theta(L_e-\tfrac12\mathrm{Id})$ with $\theta=P(W)$ at unit $W$ and $e=W/\theta$. It asks $\theta\ne0$, weaker than the Statement's $\theta>0$, which is harmless.

**`hessQ_op`.** $\langle6\theta(L_ev-\tfrac12v),v\rangle=6\theta\langle L_ev,v\rangle-3\theta\langle v,v\rangle$, and $\langle L_ev,v\rangle=\theta^{-1}\langle a\circ v,v\rangle=\theta^{-1}\langle a,Q(v)\rangle$ by full symmetry of $T$ (`innerOp2_foxProd2_self`). So the right side is $6(\langle a,Q(v)\rangle-\tfrac12\theta\langle v,v\rangle)$, which is `hessQ_eq`. Correct.

**`hessB_op`.** With $q(v)=\langle Hv,v\rangle$, $q(v+w)-q(v)-q(w)=\langle Hv,w\rangle+\langle Hw,v\rangle$. `hsym` shows $\langle Hw,v\rangle=\langle Hv,w\rangle$ from `LeRestr_isSymmetric` and `innerOp2_comm`, so half the sum is $\langle Hv,w\rangle$. Correct. A symmetric bilinear form is determined by its quadratic form, and the Riemannian Hessian is symmetric, so the Hessian as a bilinear form on $T_aS$ is $\langle H\cdot,\cdot\rangle$, and as an operator (via the inner product) it is `hessOp`. This is exactly the record's claim.

**Scale.** $6\theta$ with $\theta=P(a)$ at $\lVert a\rVert=1$ is the record's normalisation. Checked independently: the ambient $d^2P_a(v,v)=6\langle a,Q(v)\rangle=6\theta\langle L_ev,v\rangle$, minus $3\theta\lVert v\rVert^2$ from the multiplier, gives $6\theta(\langle L_ev,v\rangle-\tfrac12\lVert v\rVert^2)$.

## C. Axioms

```
'HamiltonsCubic.RealLayer.hessQ_op' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.hessB_op' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.RealLayer.hessQ_eq' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The file contains no `sorry`, `native_decide` or `axiom`, and it is imported by [HamiltonsCubic.lean:509](../lean/HamiltonsCubic.lean).

## D. Record text

**The L24 row.** Its **proved** rests on the Statement's three clauses. The Hessian identity is now `hessQ_op`/`hessB_op`. The bound at a local maximiser with $\theta>0$ is `L24_weyl`, `L24_restrict` and `L24_lambda_max`. The simplicity of $1$ is `L24_simple` and `Le_self`. Sharpness is `L24_sharp`/`L24_lambda_max_eq`, and nonvacuity is `L24_nonvacuous`. The old "Owed" sentence was the row's only owed item, and it is replaced. The Scope paragraph's owed middle branch (a local maximiser with $\theta=0$) sits outside the Statement, whose hypothesis is $\theta>0$, and the Lean carries $P(a)>0$, so it is no debt of this row. *Argued the other way*: the row could be read as claiming L24 at every local maximiser. It states `P(a) > 0` in its first sentence, so it does not. Two presentation notes, not gaps: the row's file column still lists four files while [L24Hess.lean](../lean/HamiltonsCubic/Results/L24Hess.lean), [L24Sharp.lean](../lean/HamiltonsCubic/Results/L24Sharp.lean) and [L24HessOp.lean](../lean/HamiltonsCubic/Results/L24HessOp.lean) are linked only in the body, and the canonical statement's "Machine-checked" line ([second-order.md:69](../findings/second-order.md)) cites `L24_hessian` and not the operator form. Neither says anything false.

**The report sentence.** [06b-bispectral.tex:55](../report/sections/06b-bispectral.tex) now reads "Sampled evaluations at $n=6,7$ agree with the proof's witness, which confines it at every $n\ge6$." The proof two paragraphs above confines the identity at every $n\ge6$ by the $S^3\times S^3$ witness, kernel-checked (r1457 item C), so the sentence is accurate and no longer contradicts it. It describes the certificate's state, not its history. "Agree with" is slightly loose (the samples show the same failure as the witness), and a reader cannot misread it. No em dash, and no spliced semicolon.

## E. Downstream

Searched findings/, results.md, report/sections/, lean/INDEX.md, plan-lean.md and STATUS.md for "Hessian" together with owed, operator, not typed and Mathlib. The L24 row is gone from plan-lean.md's queue and STATUS.md names L70 next, both consistent with **proved**.

**Gap.** [lean/INDEX.md:234](../lean/INDEX.md), the L170 row: "**Owed: that $\mathrm{Hess}=6\theta(L_e-\tfrac12)$ on $W^\perp$, that $L_eW=W$, and the identification of $\ker\mathrm{Hess}$ with $T_W\mathcal O$.**" And [L170.lean:18-21](../lean/HamiltonsCubic/Results/L170.lean): "That `Hess(P|_S)_W = 6θ(L_e - ½·Id)` on `W^⊥`, that `L_e W = W`, and the identification of `ker Hess` with `T_W𝒪`, all statements about operators on `Weyl_n` that the base layer has no type for." The first is now `hessQ_op`/`hessB_op`, and the second has been `Le_self` since L24Eigen. *Argued the other way*: "owed" in the L170 row could mean only that L170.lean (over `ℚ`, importing no operator) does not itself use these facts. The row's wording names the facts as owed, not their wiring into L170, and the docstring claims the layer has no type for them, which is now false for two of the three. The third (the kernel as the orbit tangent) remains owed. The gap stands.

No file in findings/, results.md or report/ says L24's operator Hessian is owed.
