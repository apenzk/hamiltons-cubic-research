# REVIEW r1903: L217Gen, RotDeriv and corollary (b) of Lemma L217

*Gate 2 review of commits 8812878e and b7602077, which move both L217 rows of [lean/INDEX.md](../lean/INDEX.md) to proved. The derivative of the orbit action is correct in sign and content, the typed gap hypothesis is the record's, and the conclusions carry the standard three axioms. Two readings need a sentence in the record: the spanning of $T_u\mathcal O$ by the generator tangents is a linearity fact outside Lean, and `L217_no_max_near` takes $P(M)<m$ where corollary (b) takes $\theta_{p,q}<\Theta_n$.*

| # | Claim | Verdict |
|---|---|---|
| 1 | RotDeriv: `HasMDeriv` rules, `hasMDeriv_Rot`, `hasMDeriv_rotR`, `hasDerivAt_pairing` | CONFIRMED |
| 2 | L217Gen: `first_order_gen`, `pairing_le_self`, `tangent_perp`, `L217_general` as the record's Statement | CONFIRMED WITH OBSERVATIONS |
| 3 | `L217_sphere`, `L217_no_max_near` as corollary (b) with L216's $\gamma_{p,q}$ | CONFIRMED WITH OBSERVATIONS |
| 4 | Both L217 INDEX rows proved, corollary (c) the record's own conditional, nothing Lean-owed left | CONFIRMED WITH OBSERVATIONS |
| 5 | Axioms and hypothesis inventory | CONFIRMED |

**One line.** The lemma at every gapped critical orbit and corollary (b) are kernel-checked on the standard three axioms, with hypotheses that match the record once $T_u\mathcal O=\operatorname{span}\{[\mathrm{ad}_{\varphi_{jk}},u]\}$ (linearity) and $\Theta_n\le m$ (the definition of $m$) are read in.

## Conventions

- `Rot j k c s` ([PairSquare.lean:76](../lean/HamiltonsCubic/Results/PairSquare.lean#L76)): column $j$ carries $c$ at row $j$ and $s$ at row $k$, column $k$ carries $-s$ at row $j$ and $c$ at row $k$. So $\frac{d}{d\varphi}\mathrm{Rot}(\cos\varphi,\sin\varphi)|_0$ has $+1$ at $(k,j)$ and $-1$ at $(j,k)$.
- `phi i j = single j i 1 - single i j 1` ([WeylReal.lean:45](../lean/HamiltonsCubic/Base/WeylReal.lean#L45)): $+1$ at $(j,i)$, $-1$ at $(i,j)$. So $\varphi_{jk}$ has $+1$ at $(k,j)$ and $-1$ at $(j,k)$, the derivative above. The Casimir copy in [Casimir.lean:23](../lean/HamiltonsCubic/Results/Casimir.lean#L23) has the same entries.
- `rotR U V` acts by $X\mapsto U\,V(U^{\mathsf T}XU)\,U^{\mathsf T}$ (`rotR_coe`, [FrameOp2.lean:54](../lean/HamiltonsCubic/Results/FrameOp2.lean#L54)).
- `orbitTangent C X = (adS X).comp C - C.comp (adS X)` ([I117Statements.lean:1969](../lean/HamiltonsCubic/Results/I117Statements.lean#L1969)), with `adS X Y` coercing to $XY-YX$ (the `rfl` in `h1` of `hasMDeriv_rotR` checks this).
- `LeLin a v = foxProd2 ((P a)⁻¹ • a) v` ([L24Restrict.lean:87](../lean/HamiltonsCubic/Results/L24Restrict.lean#L87)), with `foxProd2 X Y = ½(Q(X+Y) − Q X − Q Y)` ([FirstVariation.lean:57](../lean/HamiltonsCubic/Results/FirstVariation.lean#L57)). This is $L_e$ with $e=u/\theta_u$.

## Hypothesis inventory

`L217_general`: `huW` ($u$ Weyl), `hu1` ($\lVert u\rVert=1$), `hQ` ($Q(u)=\theta u$), `hθ` ($\theta>0$), `hγ` ($\gamma\ge0$), `hgap` (the gap at every unit Weyl $H\perp u$ orthogonal to every `tang u j k`, $j\ne k$), `hWW`, `hW1` ($W^\ast$ unit Weyl), `hmax` ($W^\ast$ a global maximiser on the unit Weyl sphere), `hnear` ($\exists U$ orthogonal with $\langle U\cdot W^\ast,u\rangle\ge\sqrt{1-\min(3\gamma,\tfrac12)^2}$). Each is a clause of the record's Statement. $\theta=P(u)$ is derived (`Pcubic2_crit`) rather than assumed. `hQ` is the record's criticality on the Weyl sphere because $Q$ preserves Weyl operators (`isWeyl2_Qop2`, [WeylMaximiser.lean:128](../lean/HamiltonsCubic/Results/WeylMaximiser.lean#L128)).

`L217_sphere`: `T` with $|T|\ge3$, $|T^c|\ge3$, not both $3$, $t>0$ with the product unit, $W^\ast$ unit Weyl global maximiser, and `hnear` at angle $\arcsin\min(3\gamma_{p,q},\tfrac12)$, $\gamma_{p,q}=\tfrac12-$`lamTop p q`. `L217_no_max_near` adds `hlt`: $P(M)<P(W^\ast)$.

## 1. RotDeriv

**By hand.** Put $R_\varphi=\mathrm{Rot}(\cos\varphi,\sin\varphi)$, $R_0=1$, $R'_0=\xi=\varphi_{jk}$, $\xi^{\mathsf T}=-\xi$. Differentiating $R\,u(R^{\mathsf T}XR)\,R^{\mathsf T}$ at $0$ by the product rule and linearity of $u$ gives
$$\xi\,uX+u(\xi^{\mathsf T}X+X\xi)+uX\,\xi^{\mathsf T}=\xi\,uX-uX\,\xi-u(\xi X-X\xi)=[\xi,uX]-u[\xi,X],$$
which is `orbitTangent u ξ` applied to $X$. The Lean proof follows exactly this route: `hZ` is $R^{\mathsf T}XR$, `hLZ` pushes it through `extL u` (the linear extension of $u$ to all matrices, agreeing with $u$ on skew matrices by `extend_apply`), `hY` multiplies back, and the final `abel` closes the identity above after `phi_isSkew`.

- `HasMDeriv.mul` is the entrywise product rule over the sum in `Matrix.mul_apply`. `transpose` swaps the indices. `hasMDeriv_const` is trivial. `HasMDeriv.linear` expands $L(M)=\sum_{p,q}M_{pq}L(E_{pq})$ and differentiates term by term. All correct, and the entrywise definition is the Fréchet derivative on a finite-dimensional space, so nothing is lost by it.
- `hasMDeriv_Rot` is checked case by case on $(p,q)$. The derivative matrix it proves is `phi j k`, and the conventions above confirm the sign.
- `hasDerivAt_pairing` sums `hasDerivAt_inner2` over the $\varphi_{ab}$ basis inside `innerOp2`. Correct.

**Verdict: CONFIRMED.**

## 2. L217Gen

- `first_order_gen`. Since $\langle R_\psi\cdot u,U_0\cdot V\rangle=\langle (R_\psi^{\mathsf T}U_0)\cdot V,u\rangle$ (`innerOp2_rotR_adj`, `rotR_comp`), the function $\psi\mapsto\langle R_\psi\cdot u,U_0V\rangle$ is bounded by its value at $0$ for every $\psi$, a global hence local maximum. `IsLocalMax.hasDerivAt_eq_zero` with `hasDerivAt_pairing` gives $\langle\mathrm{tang}\,u\,j\,k,U_0V\rangle=0$. Correct, and it is the record's first variation of distance in step 1 with the geodesic replaced by the maximal pairing.
- `pairing_le_self` is Cauchy–Schwarz in the form $0\le\lVert Uu-u\rVert^2$ with $\lVert Uu\rVert=\lVert u\rVert$. `tangent_perp` applies `first_order_gen` at $V=u$, $U_0=1$. Correct.
- **Is `hgap` the record's gap hypothesis?** The record quantifies over unit $H\perp u$ orthogonal to $T_u\mathcal O$. The map $X\mapsto[\mathrm{ad}_X,u]$ is linear in $X$ (`adS` is linear in its first argument), every skew $X$ is $\sum_{j<k}X_{kj}\varphi_{jk}$, and the tangent to $\mathcal O$ at $u$ along $X\in\mathfrak{so}(n)$ is $[\mathrm{ad}_X,u]$ (`hasMDeriv_rotR` at the generators, linearity for the rest). So orthogonality to every `tang u j k` is orthogonality to $T_u\mathcal O$, and the two hypothesis sets coincide. The spanning step is a linearity fact outside Lean (O1). Had the generators spanned less, `hgap` would ask the gap on more directions and the theorem would be weaker, never falsely stronger.
- **Is `LeLin u` the record's $L_e$?** Yes, `LeLin u v = foxProd2 (P(u)⁻¹u) v` $=e\circ v$ with $e=u/\theta_u$, and $\langle L_{u}V,V\rangle=T(u,V,V)$ is the record's step 2.
- **Is `hnear` the record's geodesic condition?** The geodesic distance from $W^\ast$ to $\mathcal O$ is $\arccos\max_U\langle W^\ast,U\cdot u\rangle=\arccos\max_U\langle U^{\mathsf T}\cdot W^\ast,u\rangle$. For $\varphi\in[0,\tfrac\pi2]$ and $r=\min(3\gamma,\tfrac12)\in[0,\tfrac12]$, $\sin\varphi\le r$ is $\cos\varphi\ge\sqrt{1-r^2}$, and the existence of one $U$ with the pairing at least $\sqrt{1-r^2}$ is the maximal pairing at least $\sqrt{1-r^2}$. The bound $\sqrt{1-r^2}>0$ also enforces $\varphi\le\tfrac\pi2$, which the record states separately. Equivalent.
- `L217_general` then decomposes $U_0W^\ast=c\,u+s\,v$ with $v\perp u$ and $v\perp$ every tangent (from `first_order_gen` and `tangent_perp`), shows $s\le r$ from $c\ge\sqrt{1-r^2}$, and hands off to `L217_op_Le` (Gate 2 r1775). The case $s=0$ gives $U_0W^\ast=u$ directly. The gap is used at $u$ itself, since the proof rotates $W^\ast$ rather than $u$, so the equivariance of `L217Orbit.lean` is not needed here.

**Verdict: CONFIRMED WITH OBSERVATIONS** (O1).

## 3. `L217_sphere` and `L217_no_max_near`

- $\gamma_{p,q}=\tfrac12-\max\big(\frac{p-2}{2(p-1)},\frac{q-2}{2(q-1)},\frac{p+q-2}{2(p-1)(q-1)}\big)=\min\big(\frac1{2(p-1)},\frac1{2(q-1)},\tfrac12-\mu\big)$ with $\mu=\frac{n-2}{2(p-1)(q-1)}$, the record's L216 corollary exactly.
- `gap_lt_half` takes `hne` over $\mathbb R$. `L217_sphere` converts with `fun h => hne ⟨by exact_mod_cast h.1, by exact_mod_cast h.2⟩`, which is the correct direction (a real equality of casts gives the natural one). The result is used only for $\gamma_{p,q}>0$, hence $r\ge0$.
- The orbit-normal condition is supplied through `first_order` on the cross tangents and `horb_of_orbit`, the gap by `Le_gap_sphere`, and the closing step is the same `L217_op_Le` call as in `L217_general`.
- **Corollary (b) against `L217_no_max_near`.** The record assumes $\theta_{p,q}<\Theta_n$ and concludes via $\theta_{p,q}<\Theta_n\le m$. The Lean theorem assumes $P(M)<P(W^\ast)=m$ directly and concludes $\langle U\cdot W^\ast,M\rangle<\sqrt{1-r^2}$ for every orthogonal $U$, that is no orbit point within the angle. The Lean hypothesis is implied by the record's once $\Theta_n\le m$, which holds because $\Theta_n$ is the value of a unit Weyl operator and $m$ is the supremum. So the Lean theorem is the record's (b) in its general form ("below $\sup P$"), and the literal (b) is one inequality away (O2).

**Verdict: CONFIRMED WITH OBSERVATIONS** (O2).

## 4. The INDEX rows and corollary (c)

The record, quoted verbatim.

> **Statement.** *Let $u$ be a unit critical point of $P$ on the unit sphere of $\mathcal W_n$ with $\theta_u=P(u)>0$ and $e=u/\theta_u$, and suppose $\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp u$ orthogonal to the orbit tangent $T_u\mathcal O$, $\mathcal O=O(n)\cdot u$, with $\gamma\ge0$. Let $W^\ast$ be a global maximiser of $P$ on the unit sphere, $m=P(W^\ast)$, at geodesic distance $\varphi\in[0,\tfrac\pi2]$ from $\mathcal O$ with $\sin\varphi\le\min(3\gamma,\tfrac12)$. Then $m\le\theta_u$, and since $m\ge P(u)=\theta_u$ by the definition of $m$, $m=\theta_u$: the orbit $\mathcal O$ is itself a set of global maximisers.*

> - **(b) Every sub-maximal sphere product with $p,q\ge3$ and $(p,q)\ne(3,3)$.** *For such $S^p\times S^q$ with $\theta_{p,q}<\Theta_n$, with L216's gap $\gamma_{p,q}$, no global maximiser lies within geodesic angle $\arcsin\min(3\gamma_{p,q},\tfrac12)$ of its orbit*, since $m=\theta_{p,q}<\Theta_n\le m$ would follow. *More generally, no global maximiser lies in such a tube about any gapped critical orbit whose value is below $\sup P$.*
> - **(c) Padded $\mathbb{CP}^2$, for comparison only.** *At $n\ge12$, where $\sqrt{3/2}<\Theta_n$, and conditional on [L21](route-a.md)'s $\alpha\le\tfrac13$, whose $m$-freeness of four $F_\lambda$ blocks is owed as [I54](../plan-verification.md), its gap is $\gamma=\tfrac16$, so (b)'s device puts every global maximiser at $\varphi>\tfrac\pi6$ from the orbit, weaker than [L20](route-a.md)'s $0.5748$, which solves the envelope exactly rather than bounding it.*

- The Statement is `L217_general` (section 2). Corollary (a) is `L217_balanced` (r1898). Corollary (b) is `L217_no_max_near` (section 3). The "more generally" sentence of (b) is `L217_general` with $\theta<m$ contradicting $P(W^\ast)=\theta$, a one-line corollary with no theorem of its own (O3).
- Corollary (c) rests on L21's $\alpha\le\tfrac13$, which the record itself owes as I54. A Lean proof of (c) would first need that gap, which the record does not supply, so (c) is correctly outside what the row can owe. The INDEX's sentence, "`L217_general` at $\gamma=\tfrac16$ once that gap is supplied", is accurate: $3\cdot\tfrac16=\tfrac12$, and the angle is $\arcsin\tfrac12=\tfrac\pi6$.
- Nothing Lean-owed remains for the lemma and (a), (b). The record's step 1 phrase "first variation of distance" is replaced in Lean by the maximal pairing, which is equivalent (section 2) and is the form r1898 already accepted.

**Verdict: CONFIRMED WITH OBSERVATIONS** (O3).

## 5. Axioms

`lake build HamiltonsCubic.Results.L217Gen HamiltonsCubic.Results.L217Bal` completed (8963 jobs, no lake was running before). `#print axioms` on `L217_general`, `hasDerivAt_pairing`, `hasMDeriv_rotR`, `first_order_gen`, `tangent_perp`, `L217_sphere` and `L217_no_max_near` returns `[propext, Classical.choice, Quot.sound]` for each. The hypotheses are satisfiable: `L217_sphere` discharges every hypothesis of the `L217_op_Le` chain at a concrete orbit, and at $\gamma=0$ `hgap` is L24's second-order condition at a maximiser.

**Verdict: CONFIRMED.**

## Verdict

**CONFIRMED WITH OBSERVATIONS.** RotDeriv and L217Gen prove the record's Lemma L217 at every gapped critical orbit, and L217Bal proves corollary (b) in its general form, all on the standard three axioms. Both L217 rows are correctly marked proved.

**Falsifier and search.** The object that would falsify the claims is a sign or index mismatch between `Rot` and `phi` making `hasMDeriv_rotR` prove the derivative of a different curve, or a gap hypothesis quantified over a proper subset of the record's normal directions. I checked the entries of `Rot` and `phi` against each other, rederived the derivative by hand from `rotR_coe`, checked that the generator tangents span $T_u\mathcal O$ by linearity, and checked `lamTop` against the record's $\gamma_{p,q}$. None of these fired. No numerical run was made. The kernel proofs and the build are the evidence.

## Observations

- **O1.** The equality of "orthogonal to every `tang u j k`" with "orthogonal to $T_u\mathcal O$" rests on $X\mapsto[\mathrm{ad}_X,u]$ being linear and the $\varphi_{jk}$ spanning $\mathfrak{so}(n)$, which the docstring states and Lean does not prove. It is elementary, and a one-line Lean lemma (`orbitTangent` linear in `X` plus `φ` resolving a bivector) would close the reading.
- **O2.** `L217_no_max_near` assumes $P(M)<P(W^\ast)$, while corollary (b) assumes $\theta_{p,q}<\Theta_n$. The Lean form is the more general one, and the record's follows with $\Theta_n\le m$. The INDEX row could say so in one clause.
- **O3.** The "more generally" clause of (b), at any gapped critical orbit below $\sup P$, has no named theorem. It is immediate from `L217_general`.
- **O4.** `L217_sphere` repeats `L217_general`'s body at the sphere product instead of calling it, because its orbit-normal condition goes through the cross tangents and `horb_of_orbit`. Both are correct. A future cleanup could derive `L217_sphere` from `L217_general` by showing that at $M$ the cross orbit tangents span the same space as the generator tangents, the rotations inside each factor fixing $M$.
