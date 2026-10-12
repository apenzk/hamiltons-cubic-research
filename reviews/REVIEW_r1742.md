# REVIEW r1742: L217 at the operator (L217Op.lean), and the post-r1741 changes to L214Op.lean

**Verdict: CONFIRMED WITH OBSERVATIONS.** `L217_op` and `L217_op_eq` state Lemma L217 faithfully at the operator, with the geometric reduction (orbit, nearest point, first variation, equivariance) honestly left as hypotheses, and every proof is sound as read. The a16f92c2 changes to [L214Op.lean](../lean/HamiltonsCubic/Results/L214Op.lean) are sound and close r1741's O2 and O3. The observations are one redundant hypothesis, one owed step named only implicitly in the INDEX row, and one header phrase that is exact only in the Weyl case.

Read: [L217Op.lean](../lean/HamiltonsCubic/Results/L217Op.lean) (untracked, working tree), `value_bootstrap` in [L217Statement.lean](../lean/HamiltonsCubic/Results/L217Statement.lean), `tube_value_le` in [L217.lean](../lean/HamiltonsCubic/Results/L217.lean), [L214Op.lean](../lean/HamiltonsCubic/Results/L214Op.lean) at HEAD, `Pcubic2Lin_selfAdjoint` in [PhiTri.lean](../lean/HamiltonsCubic/Results/PhiTri.lean), `L24_weyl` in [L24Weyl.lean](../lean/HamiltonsCubic/Results/L24Weyl.lean), `Qop2` and `normSq2_eq_zero` in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), Lemma L217 with its proof in [second-order.md](../findings/second-order.md), the $\circ$, $T$ and $\theta$ rows of [conventions.md](../findings/conventions.md), the L214 and L217 (statement) rows of [lean/INDEX.md](../lean/INDEX.md), and [REVIEW_r1741.md](REVIEW_r1741.md). No `lake build` was run. `L217Op.olean` is dated 00:55 against its source at 00:54, and `L214Op.olean` 00:53 against 00:51, so both files as read compiled in the other session's build. Neither contains `sorry`, `axiom` or `native_decide`. The axiom audit is the author's. Analysis-only footing: every check is by hand, and no screen was needed.

## (1) The gap hypothesis

- **Criticality form.** `hQ : Qop2 u = θ • u` is the record's criticality: [conventions.md](../findings/conventions.md) tables "at a critical point, $Q(W)=\theta W$" and records that $Q$ preserves $\mathcal W_n$ (Böhm–Wilking), so the Weyl-sphere critical point satisfies the unprojected equation.
- **The gap is the record's.** [conventions.md](../findings/conventions.md) defines $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ and $L_e=e\circ(\cdot)$. r1741's polarisation (`Tsym_lin` with `Pcubic2Lin_selfAdjoint` gives $T(X,X,Z)=\langle Q(X),Z\rangle$ at self-adjoint $X$, then polarise over the self-adjoint subspace) gives $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ for self-adjoint $X,Y$ and any $Z$. With $u$ self-adjoint, $v$ Weyl, $e=u/\theta$: $\langle L_ev,v\rangle=\langle e\circ v,v\rangle=T(e,v,v)=T(u,v,v)/\theta$. Since $\theta>0$, `Tsym u v v ≤ θ(1/2 − γ)` is exactly $\langle L_ev,v\rangle\le\tfrac12-\gamma$.
- **One direction instead of all.** The record assumes the gap for every unit $H\perp u$, $H\perp T_u\mathcal O$, and its proof uses it only at the geodesic's velocity $V$ (step 2). The typed theorem assumes it only at $v$ and places no orbit-tangent condition on $v$, so its hypothesis is implied by the record's at $v=V$. That is a weaker hypothesis and a stronger theorem.
- Falsifier: self-adjoint $u$ and Weyl $H$ with $\langle(u/\theta)\circ H,H\rangle\ne T(u,H,H)/\theta$.

## (2) The geodesic replaced by `hW`

- **Faithful.** The record's step 1 writes $W^\ast=c\,u_1+s\,V$ with $c=\cos\varphi\ge0$, $s=\sin\varphi$, $\varphi\in[0,\tfrac\pi2]$. The typed $c,s\ge0$, $c^2+s^2=1$ is the same parametrisation of $[0,\tfrac\pi2]$, and $s\le\min(3\gamma,\tfrac12)$ is `hs` with `hshalf`. The record's $\varphi=0$ branch is the instance $s=0$, $c=1$.
- **The orbit point taken as $u$.** Since `L217_op` quantifies over every $u$, applying it at $u_1=g\cdot u$ needs $Q(u_1)=\theta u_1$, $\lVert u_1\rVert=1$ and the gap at $u_1$, which is the record's equivariance step.
- **The INDEX row lists the remainder honestly.** It owes "the orbit, geodesic distance and the first-variation step, that a maximiser at distance $\varphi$ is $\cos\varphi\,u'+\sin\varphi\,v$ with $v$ orthogonal to the orbit tangent", and the file header says the same.
- **O2 (wording).** The transfer of criticality and the gap from $u$ to $u_1$ by $O(n)$-equivariance, which the record lists under "What is used", is owed but sits in the row only inside "the orbit". Naming it would make the owed list match the record's own.
- Falsifier: a global maximiser $W^\ast$ at distance $\varphi\in(0,\tfrac\pi2]$ from $\mathcal O$ with no decomposition $\cos\varphi\,u_1+\sin\varphi\,V$, $u_1\in\mathcal O$, $V$ unit, $V\perp u_1$, $V\perp T_{u_1}\mathcal O$ (this refutes the record's prose step, which the Lean does not claim).

## (3) `hmax` and the equality

- **`hmax` is the record's global maximiser.** `∀ R, IsWeyl2 R → normSq2 R = 1 → P(R) ≤ P(W*)` is maximality on the unit sphere of $\mathcal W_n$. In `L217_op_eq`, $u$ and $v$ are Weyl, orthogonal and unit, so $W^\ast$ is itself a unit Weyl operator and `hmax` says exactly that it is a global maximiser.
- **Only $P(v)\le m$ is consumed in `L217_op`**, which is the record's "one fact only a global maximiser supplies".
- **`L217_op_eq` gives $m\ge\theta$ as the record says.** `hPu` derives $P(u)=\theta$ from `Tsym_diag`, `Tsym_crit` and $\lVert u\rVert=1$, and `hmax u huW hu1` gives $P(u)\le P(W^\ast)$. `le_antisymm` with `L217_op` closes $m=\theta$.
- **O3 (header phrase).** In `L217_op`, $u$ is only self-adjoint, so $W^\ast$ need not be Weyl, and `hmax` then says $P(W^\ast)$ bounds $P$ on the Weyl sphere rather than that $W^\ast$ maximises it. The theorem is more general for it and still true. The header's "maximises $P$ on the unit Weyl sphere" is exact for `L217_op_eq`.
- Falsifiers: for `L217_op`, self-adjoint unit $u$ with $Q(u)=\theta u$, $\theta>0$, a unit Weyl $v\perp u$ with $T(u,v,v)\le\theta(\tfrac12-\gamma)$, $c,s\ge0$, $c^2+s^2=1$, $s\le\min(3\gamma,\tfrac12)$, $P(v)\le P(cu+sv)$ and $P(cu+sv)>\theta$. For `L217_op_eq`, the same with $u$ Weyl, $P(R)\le P(cu+sv)$ on the whole unit Weyl sphere, and $P(cu+sv)\ne\theta$.

## (4) Vacuity and unused hypotheses

- **Every hypothesis of `value_bootstrap` is discharged soundly.** `huu` from `Tsym_crit` and $\lVert u\rVert=1$, `hcrit` from `Tsym_crit` and $\langle u,v\rangle=0$, `hm` from `Tsym_diag`, `hvv` from `hmax` at $v$, `hc` from `hcs` by `linarith`.
- **$c\ge0$ is used**, in `tube_value_le`'s `hstepα` (positivity of $3cs^2$), exactly where the record's step 3 uses it, and in `envelope_le_one`.
- **O1 (redundancy).** `hγ0 : 0 ≤ γ` follows from `hs0` and `hs` ($0\le s\le3\gamma$). Harmless, and the record states it too.
- **Satisfiable.** Take $u$ a global maximiser on the unit Weyl sphere at $n\ge4$ (where $\theta>0$), $s=0$, $c=1$, $W^\ast=u$, $\gamma=0$, and any unit Weyl $v\perp u$: the gap is then `Tsym_cap`'s $T(u,v,v)\le\theta/2$. So neither theorem is vacuous at $n\ge4$, although the existence of such $u$ is prose.

## (5) The L214Op changes against r1741

- **`L214_op_max` drops `hNW`** and derives it: $N=W+(-1)\cdot D$ by operator extensionality from `hsplit` and `module`, then `isWeyl2_add hWW (isWeyl2_smul _ hDW)`. Sound, and it closes **r1741 O2**.
- **The test vector's Weyl-ness** rewrites $tN-(1-t)D=tN+(t-1)D$ by extensionality and closes by the same closure lemmas. Sound.
- **`Tsym_cap`'s $X=0$ branch.** `normSq2_eq_zero` gives $X=0$, extensionality gives $0\cdot X=X$, `Tsym_smul_mid 0` then gives $T(W,X,X)=0\cdot T(W,X,X)=0$, and `← hzero` turns the right side into $\tfrac\theta2\cdot0$. Sound.
- **The gloss.** The header now reads "`3 Tsym R H H = Pcubic2Quad R H`, its quadratic part, so `Tsym R H H = ⅙ P''(R)(H, H)`", and the L214 INDEX row reads $T(R,H,H)=\tfrac16P''(R)(H,H)$. Both agree with `Pcubic2Quad` being $\tfrac12P''$, which closes **r1741 O3**. r1741 O1 (global maximiser only through $\theta>0$) was not in scope of this change and stands as recorded.
- Falsifier: Weyl $W,D$ with $W-D$ not Weyl, or a unit Weyl local maximiser with $\theta>0$ and a Weyl $X\perp W$ of zero norm with $T(W,X,X)\ne0$.

## Summary

| Item | Verdict |
|---|---|
| gap `Tsym u v v ≤ θ(½−γ)` | the record's $\langle L_ev,v\rangle\le\tfrac12-\gamma$, taken at one direction only, so stronger |
| `hW`, $c,s\ge0$, $c^2+s^2=1$ | faithful to step 1, remainder owed in INDEX (O2: equivariance only implicit) |
| `hmax`, `L217_op_eq` | the record's global maximiser and its $m\ge P(u)=\theta$ (O3: header phrase exact only for Weyl $u$) |
| unused or vacuous | none vacuous, $c\ge0$ used (O1: `hγ0` redundant) |
| L214Op changes | sound, close r1741 O2 and O3 |
