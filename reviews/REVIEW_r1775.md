# REVIEW r1775: L217Le.lean (5e7deff4)

| Claim | Verdict | Reason |
|---|---|---|
| `LeLin u` is the record's $L_e$, $e=u/\theta_u$ | CONFIRMED | `LeLin a v := foxProd2 ((Pcubic2 a)⁻¹ • a) v` and `foxProd2 X Y := ½(Q(X+Y) − Q(X) − Q(Y))` are the record's $e\circ(\cdot)$ with $e=u/P(u)$ |
| `Pcubic2_crit`: $P(u)=\theta$ at a unit critical $u$ | CONFIRMED | `Tsym_diag` then `Tsym_crit` give $P(u)=\theta\lVert u\rVert^2=\theta$ |
| `Tsym_eq_Le`: $T(u,v,v)=P(u)\langle L_ev,v\rangle$ | CONFIRMED | `Tsym_quad` plus `Pcubic2Quad_selfAdjoint` (needs $v$ self-adjoint) and `innerOp2_foxProd2_self` (needs $u$ and $v$ self-adjoint) |
| `L217_op_Le` | CONFIRMED WITH OBSERVATIONS | the gap hypothesis is the record's inequality at the single direction $v$ the proof uses, and the orbit-tangent restriction stays with the record's step 1 |
| `no_critical_in_tube_Le` | CONFIRMED WITH OBSERVATIONS | $\theta>0$ is added relative to `no_critical_in_tube_crit` and is the record's $\theta_0>0$, while $H$ carries no unit-norm hypothesis |
| `#print axioms`, four names | CONFIRMED | `propext`, `Classical.choice`, `Quot.sound` on each |
| INDEX rows L216 (statement), L217 (statement) | CONFIRMED WITH OBSERVATIONS | both describe the code, and the L217 row's gloss of `Tsym_eq_Le` omits the hypothesis $P(u)\ne0$ |

**Summary.** The four declarations are sound and their gap hypothesis is the record's $\langle L_eH,H\rangle\le\tfrac12-\gamma$ at the direction each proof uses, with three observations, none of which changes a verdict.

**Standing rule.** Analysis only. The one computation run is `lake env lean` on a five-line check file for `#print axioms` and `#check`, seconds of work. No numerical screen was run.

## 1. `LeLin u` against the record's $L_e$

- Record ([second-order.md](../findings/second-order.md), the criterion at line 11): *"put $e=W/\theta$, an idempotent of $X\circ Y:=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, and $L_e=e\circ(\cdot)$"*. L217's statement: *"$\theta_u=P(u)>0$ and $e=u/\theta_u$"*.
- Code ([L24Restrict.lean:87](../lean/HamiltonsCubic/Results/L24Restrict.lean)): `toFun v := foxProd2 ((Pcubic2 a)⁻¹ • a) v`. [FirstVariation.lean:57](../lean/HamiltonsCubic/Results/FirstVariation.lean): `foxProd2 X Y := (1 / 2 : ℝ) • (Qop2 (X + Y) - Qop2 X - Qop2 Y)`. This is the record's $\circ$ word for word, and $e=u/P(u)$ is the record's $e=u/\theta_u$ with $\theta_u$ read as $P(u)$.
- `Pcubic2_crit` closes the identification with the Lean $\theta$, which is the $Q$-eigenvalue in `hQ : Qop2 u = θ • u`: `rw [← Tsym_diag, Tsym_crit hu hQ, …, hu1, mul_one]` gives $P(u)=T(u,u,u)=\theta\langle u,u\rangle=\theta$. `Tsym_crit` needs $u$ self-adjoint, which `hu` supplies. So at a unit critical point `LeLin u` is $L_e$ with $e=u/\theta_u$ and $\theta_u=\theta$.

## 2. `Tsym_eq_Le`

- Step 1: `Tsym_quad u v`, $3T(u,v,v)=\mathrm{Pcubic2Quad}(u,v)$, holds with no hypothesis (`ring` after unfolding).
- Step 2: `Pcubic2Quad_selfAdjoint hv u` rewrites the right side to $3\langle u,Q(v)\rangle$. It needs only the second argument self-adjoint, so `hv` is used here and `hu` is not.
- Step 3: $\langle L_ev,v\rangle=\langle\mathrm{foxProd2}(P(u)^{-1}u,v),v\rangle=P(u)^{-1}\langle\mathrm{foxProd2}(u,v),v\rangle$ by `foxProd2_smul_left` and `innerOp2_smul_left`, then $=P(u)^{-1}\langle u,Q(v)\rangle$ by `innerOp2_foxProd2_self hu hv`. That lemma runs through `foxTri2_symm_right v a v ha hv`, so it needs both $u$ and $v$ self-adjoint. This is the one place `hu` enters.
- Step 4: $P(u)\cdot P(u)^{-1}=1$ by `mul_inv_cancel₀ hP`, and `linarith` closes from step 1. `hP` is used only here.
- Every hypothesis is used and each is necessary for the step it feeds. The statement is sound.

## 3. The replaced hypothesis and the record's $H$ family

- `L217_op`'s `hgap : Tsym u v v ≤ θ * (1 / 2 - γ)` becomes `hgap : innerOp2 (LeLin u v) v ≤ 1 / 2 - γ`. The bridge is `Tsym_eq_Le` with $P(u)=\theta$, then `mul_le_mul_of_nonneg_left hgap hθ.le`. The two forms are equivalent at $\theta>0$, so the replacement loses nothing.
- The record's hypothesis is universal: *"$\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp u$ orthogonal to the orbit tangent $T_u\mathcal O$"*. `L217_op_Le` quantifies over nothing. It takes the gap at the one unit Weyl `v` with `innerOp2 u v = 0`, which is the one direction the record's proof uses (step 2: *"$\alpha=\langle L_{e_1}V,V\rangle\le\tfrac12-\gamma$"*).
- So the Lean hypothesis is a consequence of the record's whenever `v` is a member of the family. The record's step 1 is what supplies membership: $V\perp u_1$ and $V\perp T_{u_1}\mathcal O$ by the first variation, and the gap carried from $u$ to $u_1$ by equivariance. Both remain on the INDEX row's **Owed** list, which is accurate.
- Observation O1: the Lean theorem, as typed, asks for no orbit-tangent orthogonality, so it is strictly more general than the record's instance. That is sound, being the right direction of generality, and the docstring's phrase "the gap stated as the record states it" should read "the record's gap at the direction $v$" to avoid suggesting the universal quantifier is typed.

## 4. $\theta>0$ in `no_critical_in_tube_Le`

- `no_critical_in_tube_crit` ([L216Bern.lean:185](../lean/HamiltonsCubic/Results/L216Bern.lean)) has no `hθ`. `no_critical_in_tube_Le` adds `(hθ : 0 < θ)`. So it is an added hypothesis.
- It is used twice: to make $P(W)=\theta\ne0$ for `Tsym_eq_Le`, and to multiply the gap by $\theta$ preserving the inequality.
- It is the record's: L216 opens *"Let $W_0$ be a unit critical point of $P$ with $\theta_0=P(W_0)>0$ and $e=W_0/\theta_0$"*. The record also needs it to define $e$ at all.
- It costs no generality relative to the record. With $s>0$, $M>0$ and $s<4\theta\gamma/(9M)$, the conclusion is vacuous unless $\theta\gamma>0$, and the record has $\gamma>0$.
- Observation O2: $H$ carries no unit-norm hypothesis, inherited from `no_critical_in_tube_crit`. At a non-unit $H$ the hypothesis $\langle L_eH,H\rangle\le\tfrac12-\gamma$ is homogeneous of degree two on the left against a constant on the right, so it is not the record's gap and `cub (Dq (qP W H))` is not $\varphi'$ of a unit-speed great circle. The theorem is still true as typed, and at unit $H$, the record's case, both readings agree. Stating `normSq2 H = 1` would pin the reading, at no cost to the proof.

## 5. Axioms

Check file importing `HamiltonsCubic.Results.L217Le`, run with `lake env lean` against an olean newer than the committed source (olean mtime 1790564948, source 1790564849):

```
'HamiltonsCubic.L217Le.Tsym_eq_Le' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L217Le.Pcubic2_crit' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L217Le.L217_op_Le' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L217Le.no_critical_in_tube_Le' depends on axioms: [propext, Classical.choice, Quot.sound]
```

No `sorryAx`, no `Lean.ofReduceBool`, so no `native_decide`. `#check @no_critical_in_tube_Le` prints the signature quoted in section 4.

## 6. lean/INDEX.md rows

- **L216 (statement)**: *"`no_critical_in_tube_Le` …, step 5 at a critical point with $\langle L_eH,H\rangle\le\tfrac12-\gamma$ in place of `hgap`, at $\theta>0$, through `Tsym_eq_Le`; standard three axioms."* Matches the code and section 5. Status **partial** stays right, since step 1 and L143's $M$ remain with the record.
- **L217 (statement)**: *"`L217_op_Le` …, `L217_op` with its hypothesis stated as $\langle L_ev,v\rangle\le\tfrac12-\gamma$, through `Tsym_eq_Le` ($T(u,v,v)=\langle u,Q(v)\rangle=P(u)\langle L_ev,v\rangle$ at self-adjoint $u,v$) and `Pcubic2_crit`"*. Matches. Observation O3: the parenthetical drops `hP : Pcubic2 u ≠ 0`. The first equality holds without it, and the second needs it, since at $P(u)=0$ the Lean `LeLin u` is the zero map (`(0:ℝ)⁻¹ = 0`) and the identity fails for any $v$ with $\langle u,Q(v)\rangle\ne0$. Suggested wording: "at self-adjoint $u,v$ with $P(u)\ne0$".
- Both rows carry the "standard three axioms" claim, which section 5 confirms.

## 7. Falsifiers and the search

- `Tsym_eq_Le`: a self-adjoint pair $u,v$ with $P(u)\ne0$ and $T(u,v,v)\ne P(u)\langle L_ev,v\rangle$. The kernel excludes it. The semantic falsifier is a mismatch between `LeLin` and the record's $L_e$, which I looked for by reading both definitions (section 1) and found none.
- `Pcubic2_crit`: a unit self-adjoint $u$ with $Q(u)=\theta u$ and $P(u)\ne\theta$. Kernel-excluded, and the record's own identity $P(u)=\langle Q(u),u\rangle$ gives the same.
- `L217_op_Le`: a unit critical $u$, a unit Weyl $v\perp u$ satisfying the gap, and a Weyl-sphere maximiser $W^\ast=cu+sv$ in the allowed range with $P(W^\ast)>\theta$. Kernel-excluded given `L217_op`, whose Gate 2 is [r1742](REVIEW_r1742.md). The semantic falsifier is a hypothesis stronger than the record's, which I looked for by comparing each binder with the record's statement (section 3) and found the Lean hypotheses weaker or equal.
- `no_critical_in_tube_Le`: a unit critical $W$, $\theta>0$, $H\perp W$ with the gap, and $0<s<4\theta\gamma/(9M)$ with the cubic's derivative nonnegative at $s$. Kernel-excluded given `no_critical_in_tube_crit` ([r1761](REVIEW_r1761.md)). I checked that the added $\theta>0$ is the record's (section 4) and found the missing unit norm on $H$ (O2).
- No numerical screen was run: every question here is definitional or kernel-settled.

## Observations

- O1: `L217_op_Le`'s docstring and the header say the gap is stated "as the record states it". It is the record's inequality at one direction, the universal quantifier over the orbit-normal family staying with step 1.
- O2: `no_critical_in_tube_Le` has no `normSq2 H = 1`, so its gap hypothesis is the record's only at unit $H$.
- O3: the L217 INDEX row's gloss of `Tsym_eq_Le` omits $P(u)\ne0$, which the second equality needs.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS**
