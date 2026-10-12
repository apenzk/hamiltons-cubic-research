# REVIEW r1789: statement fidelity of commit 52afe769 (L217Orbit, L222Op additions, L214_ineq_iff)

Gate 2 reader, Lean layer. Analysis-only footing: the only computation run was one scratch file compiled with `lake env lean` (a non-vacuity witness and `#print axioms`), which finished in under a minute. Reader r1788 covers L222Swap.lean and is not duplicated here.

## Claim table

| # | Claim | Verdict | Note |
|---|---|---|---|
| A1 | `rotR U` over `IsOrth U` is the record's $O(n)$-action on $\mathcal W_n$, so $\{\mathrm{rotR}\,U\,u\}$ is the orbit $\mathcal O=O(n)\cdot u$ | CONFIRMED | $\mathrm{rotR}\,U\,V\,X=U\,V(U^{\mathsf T}XU)\,U^{\mathsf T}$ is the pushforward $g\cdot R=g\,R(g^{-1}\cdot)\,g^{-1}$ on $\Lambda^2$, and `IsOrth` is $U^{\mathsf T}U=UU^{\mathsf T}=1$, which includes $\det U=-1$, as in $O(n)$ |
| A2 | `crit_rotR`, `unit_rotR`, `normal_rotR`, `normal_rotR_surj` carry criticality, unit norm, and the unit Weyl normal directions with their gap value $T(u,v,v)$ from $u$ to $u'$, onto every $v'\perp u'$ | CONFIRMED | each is one rewrite from FrameOp2.lean's invariances and `Qop2_rotR`, with surjectivity by $v=\mathrm{rotR}\,U^{\mathsf T}v'$ and `rotR_inv` |
| A3 | `L217_orbit`: $P(W^\ast)=\theta$ at $W^\ast=c\,u'+s\,v'$ from criticality and the gap stated at $u$ and $v$ | CONFIRMED WITH OBSERVATIONS | the record's step 1 sentence "By equivariance $P(u_1)=\theta_u$ and the gap holds at $u_1$" is typed for a single direction, and the tangent-orthogonality transport is untyped (O1) |
| A4 | lean/INDEX.md:145, L217 row: owed list names "the transport of the orbit-tangent condition itself" | CONFIRMED WITH OBSERVATIONS | the row is accurate. The commit message overstates (O2), and the record's L217 note does not cite L217Orbit.lean (O3) |
| A5 | `L217_orbit` calls `L217_op_eq` with hypotheses in the form it takes | CONFIRMED | argument lists match one for one ([L217Op.lean:60-67](../lean/HamiltonsCubic/Results/L217Op.lean), [L217Orbit.lean:66-68](../lean/HamiltonsCubic/Results/L217Orbit.lean)) |
| B1 | `crit_pair` is at least as strong as L222 item 6, and `innerOp2` is the record's unordered-pair pairing | CONFIRMED WITH OBSERVATIONS | weaker hypotheses than the record's. The docstring's "$G=G_x=\nu\circ\nu$" leans on item 2 (O4) |
| B2 | `Sjk_mul_weyl` types item 1's subalgebra clause on $\mathcal W_n$ | CONFIRMED WITH OBSERVATIONS | closes $\mathrm{InSjk}\cap\mathcal W_n$, while the identity $\mathcal S_{jk}=\mathrm{InSjk}\cap\mathcal W_n$ that r1787 O4 named is still unstated (O5) |
| B3 | lean/INDEX.md:151, L222 row lists items 1 to 6 as proved, conditional or owed | CONFIRMED WITH OBSERVATIONS | r1787 O6 is repaired in the INDEX, while the record's own L222 note at second-order.md:1575 still carries the pre-O6 owed list and is now stale in a second way (O6) |
| C1 | `L214_ineq_iff` types the record's "equivalently" (r1787 O2) | CONFIRMED | hypothesis `θ * t = PD + a` is `L214_frame`'s third conjunct verbatim in shape |

**Summary**: the Lean statements of 52afe769 are faithful and axiom-clean. The two INDEX rows are accurate. The residue is on the record side: second-order.md:1575 (L222) still carries the owed list r1787 O6 refuted, and second-order.md:1451 (L217) does not cite the new file.

## Axioms

`#print axioms` in a scratch file compiled with `lake env lean`:

| Declaration | Axioms |
|---|---|
| `HamiltonsCubic.L217Orbit.L217_orbit` | propext, Classical.choice, Quot.sound |
| `HamiltonsCubic.L217Orbit.normal_rotR_surj` | propext, Classical.choice, Quot.sound |
| `HamiltonsCubic.L222Op.crit_pair` | propext, Classical.choice, Quot.sound |
| `HamiltonsCubic.L222Op.Sjk_mul_weyl` | propext, Classical.choice, Quot.sound |
| `HamiltonsCubic.L214Frame.L214_ineq_iff` | propext, Classical.choice, Quot.sound |
| `r1789_witness` (below) | propext, Classical.choice, Quot.sound |

## A. Lemma L217 against L217Orbit.lean

**The record's statement** ([findings/second-order.md:1453](../findings/second-order.md)), verbatim:

> *Let $u$ be a unit critical point of $P$ on the unit sphere of $\mathcal W_n$ with $\theta_u=P(u)>0$ and $e=u/\theta_u$, and suppose $\langle L_eH,H\rangle\le\tfrac12-\gamma$ for every unit $H\perp u$ orthogonal to the orbit tangent $T_u\mathcal O$, $\mathcal O=O(n)\cdot u$, with $\gamma\ge0$. Let $W^\ast$ be a global maximiser of $P$ on the unit sphere, $m=P(W^\ast)$, at geodesic distance $\varphi\in[0,\tfrac\pi2]$ from $\mathcal O$ with $\sin\varphi\le\min(3\gamma,\tfrac12)$. Then $m\le\theta_u$, and since $m\ge P(u)=\theta_u$ by the definition of $m$, $m=\theta_u$: the orbit $\mathcal O$ is itself a set of global maximisers.*

**The step moving from $u$ to $u'$** ([findings/second-order.md:1461](../findings/second-order.md)), verbatim:

> (1) *The geodesic.* $\mathcal O$ is compact, so $\varphi$ is attained at some $u_1=g\cdot u$, and for $\varphi>0$ the minimising great circle leaves $u_1$ with a unit velocity $V\perp u_1$ and $V\perp T_{u_1}\mathcal O$ by the first variation of distance, so $W^\ast=c\,u_1+s\,V$ with $c=\cos\varphi\ge0$, $s=\sin\varphi$. By equivariance $P(u_1)=\theta_u$ and the gap holds at $u_1$ with $e_1=u_1/\theta_u$. At $\varphi=0$, $W^\ast\in\mathcal O$ and $m=\theta_u$.

**A.1 The action.** [FrameOp2.lean:54-56](../lean/HamiltonsCubic/Results/FrameOp2.lean) `rotR_coe` gives $(\mathrm{rotR}\,U\,V)(X)=U\,V(\mathrm{cU}\,U\,X)\,U^{\mathsf T}$ with `cU_coe` ([FrameOp2.lean:41-42](../lean/HamiltonsCubic/Results/FrameOp2.lean)) $\mathrm{cU}\,U\,X=U^{\mathsf T}XU$. That is $g\cdot R=\Lambda^2g\circ R\circ\Lambda^2g^{-1}$ with $\Lambda^2g\,X=UXU^{\mathsf T}$, the standard $O(n)$-action on curvature operators, and a left action by `rotR_comp` ([L219GenOps.lean:33](../lean/HamiltonsCubic/Results/L219GenOps.lean)). `IsOrth` ([Base/Frames.lean:27](../lean/HamiltonsCubic/Base/Frames.lean)) is $U^{\mathsf T}U=1\wedge UU^{\mathsf T}=1$, all of $O(n)$. So quantifying over `IsOrth U` is quantifying over the orbit. The file's prose "$u'=UuU^{\mathsf T}$" is informal notation for this, stated precisely by `rotR_coe`.

**A.2 The transport.** `crit_rotR` ([L217Orbit.lean:31-33](../lean/HamiltonsCubic/Results/L217Orbit.lean)) and `unit_rotR` ([:35-37](../lean/HamiltonsCubic/Results/L217Orbit.lean)) are the record's "$P(u_1)=\theta_u$" in the stronger form $Q(u')=\theta u'$, $\lVert u'\rVert=1$. `normal_rotR` ([:40-45](../lean/HamiltonsCubic/Results/L217Orbit.lean)) carries Weyl, unit, $\perp u$ and the value $T(u,v,v)$. `normal_rotR_surj` ([:48-55](../lean/HamiltonsCubic/Results/L217Orbit.lean)) gives, for every unit Weyl $v'\perp u'$, a unit Weyl $v\perp u$ with $\mathrm{rotR}\,U\,v=v'$. Together: the gap value at $(u',v')$ equals the gap value at $(u,\mathrm{rotR}\,U^{\mathsf T}v')$.

**A.3 What the record needs at $u'$.** The record needs, at $u_1$ and $V$: criticality, unit norm, and the gap at $V$. The gap at $u$ is assumed only for $H\perp T_u\mathcal O$. To feed `L217_orbit` the record's $V$, one takes $v=\mathrm{rotR}\,U^{\mathsf T}V$ (by `normal_rotR_surj`), and then needs $v\perp T_u\mathcal O$ to invoke the hypothesis. That is $\mathrm{rotR}\,U^{\mathsf T}(T_{u'}\mathcal O)=T_u\mathcal O$, true mathematically since $T_{g\cdot u}\mathcal O=g\cdot T_u\mathcal O$, and untyped: the layer defines no orbit tangent. The INDEX row names this as owed. `L217_orbit` itself takes `hgap` at $v$ directly, which makes it correct and strictly stronger than the record at a single direction. See O1.

**A.4 The hypotheses of `L217_op_eq`.** [L217Op.lean:60-66](../lean/HamiltonsCubic/Results/L217Op.lean) takes `(huW : IsWeyl2 u) (hQ) (hu1) (hθ) (hvW) (hv1) (hvu) (hgap : Tsym u v v ≤ θ * (1/2 - γ)) (hs0) (hc0) (hcs) (hs) (hshalf) (hW : Wst = c • u + s • v) (hmax)`. `L217_orbit` supplies `rotR_isWeyl2 hU huW`, `crit_rotR`, `unit_rotR`, `hθ`, the three components of `normal_rotR`, the gap rewritten by $T(u',v',v')=T(u,v,v)$, then the scalar hypotheses, `hW` and `hmax` unchanged. The forms match exactly. $W^\ast$'s unit norm is not a hypothesis and is not needed.

**A.5 The INDEX row, line 145.** Checked clause by clause against the file: `crit_rotR`, `unit_rotR` as stated. "The frame change carries the unit Weyl directions $v\perp u$ onto all unit Weyl directions $v'\perp u'$ with $T(u',v',v')=T(u,v,v)$" matches `normal_rotR` plus `normal_rotR_surj`. "`L217_orbit`, $P(W^\ast)=\theta$ for $W^\ast=c\,u'+s\,v'$ from criticality and the gap stated at $u$ and $v$" matches. The owed list names the orbit as a set, geodesic distance, the first-variation step, and the orbit-tangent transport. Nothing in the row is overclaimed. The status **proved** refers to the typed statement, consistent with the row's other clauses before this commit.

**A.6 Non-vacuity.** `r1789_witness` (scratch, compiled clean): at $n=4$, `exists_weyl_maximiser` gives a global maximiser $a$ with $\theta=P(a)\ge\sqrt{3/2}>0$, `Qop2_eq_smul_weyl` gives $Q(a)=\theta a$, and for EVERY unit Weyl $v\perp a$, `Tsym_cap` gives the gap at $\gamma=0$, and `L217_orbit` applies at $U=1$, $s=0$, $c=1$. So every hypothesis except the existence of $v$ is discharged by a concrete object. A unit Weyl $v\perp a$ is not constructed in the layer as a lemma I found (`exists_perp` in SkewCentraliser.lean is over `Fin m → ℝ`, not $\mathcal W_n$), so the witness quantifies over $v$ rather than exhibiting one. It is also degenerate at $s=0$: $W^\ast=u'$. A witness with $s>0$ would need a maximiser off the orbit point inside the tube, which the layer does not supply.

## B. Lemma L222 against L222Op.lean's additions

**Item 1** ([findings/second-order.md:1578](../findings/second-order.md)), verbatim:

> 1. *$\mathcal S_{jk}$ is a subalgebra, preserved by rotations in the $(j,k)$-plane.*

**Item 6** ([findings/second-order.md:1583](../findings/second-order.md)), verbatim:

> 6. *At a diagonal critical point $D$ and $x\perp\mathbf1$, $\theta\langle D,G_x\rangle=\langle L_{G_x}D,D\rangle$, where $\langle D,G_x\rangle=\sum_{a<b}K_{ab}(G_x)_{ab}$ over unordered pairs.*

**B.1 `crit_pair`** ([L222Op.lean:199-201](../lean/HamiltonsCubic/Results/L222Op.lean)): self-adjoint $D$, $G$, $Q(D)=\theta D$ give $\theta\,\langle D,G\rangle=\langle G\circ D,D\rangle$. The record's $L_{G}D=G\circ D$ with $\circ$ = `foxProd2`, the polarisation of $Q$ ([FirstVariation.lean:57-58](../lean/HamiltonsCubic/Results/FirstVariation.lean)), and the proof is the record's own ("pair $Q(D)=\theta D$ with $G_x$ and use total symmetry") through `innerOp2_foxProd2_self` ([L24Eigen.lean:87-91](../lean/HamiltonsCubic/Results/L24Eigen.lean)). The Lean drops "diagonal", "Weyl", "unit" and "$x\perp\mathbf1$", and quantifies over every self-adjoint $G$. The record's $G_x$ is a diagonal operator, hence self-adjoint, so item 6 is an instance. At least as strong: yes.

**B.2 The pairing.** `innerOp2 R S` $=\tfrac12\sum_{i,j}$`inner2`$(R\varphi_{ij},S\varphi_{ij})$ ([Base/Bivectors2.lean:279-280](../lean/HamiltonsCubic/Base/Bivectors2.lean)), with `inner2` the half-trace $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ ([Base/WeylReal.lean:39](../lean/HamiltonsCubic/Base/WeylReal.lean)). Under the half-trace $\{\varphi_{ab}\}_{a<b}$ is orthonormal, which is the record's convention ([findings/conventions.md:88](../findings/conventions.md)). The ordered double sum counts each unordered pair twice and $\varphi_{ii}=0$, so the $\tfrac12$ makes `innerOp2` $=\sum_{a<b}\langle R\varphi_{ab},S\varphi_{ab}\rangle$, the trace inner product in the orthonormal pair basis. For diagonal $D$, $G$ with pair-diagonal entries $K_{ab}$, $(G)_{ab}$, this is $\sum_{a<b}K_{ab}G_{ab}$, the record's unordered sum. Confirmed.

**B.3 `Sjk_mul_weyl`** ([L222Op.lean:193-195](../lean/HamiltonsCubic/Results/L222Op.lean)): $x,y\in\mathrm{InSjk}\cap\mathcal W_n$ gives $x\circ y\in\mathrm{InSjk}\cap\mathcal W_n$. Correct and exactly r1787 O4's suggested corollary. See O5 for the remaining identification.

**B.4 The INDEX row, line 151, item by item.**

| Item | Row says | Check |
|---|---|---|
| 1, subalgebra | PROVED (`Sjk_mul`, `Sjk_mul_weyl`) | yes, modulo O5 |
| 1, rotation invariance | owed | yes |
| 2 | owed ($\nu\circ\nu=G_x$ and its norm) | yes, L222Statement.lean's `G_norm_sq` is the polynomial core only |
| 3, criticality equations | PROVED (`Sjk_crit`) | yes |
| 3, pinning | $\langle D,\nu\circ\nu\rangle=\tfrac\theta2\lVert\nu\rVert^2$ PROVED, $\theta/\sqrt3$ CONDITIONAL on item 2's norm | yes, r1787 O5 repaired |
| 3, $2L_{D^+}D^-=\theta D^-$ | PROVED in L222Swap.lean (`Sjk_odd`) | r1788's scope |
| 4 | owed | yes |
| 5 | owed, only `pair_mass_le` typed | yes, r1787 O6 repaired |
| 6 | PROVED (`crit_pair`) | yes |

All six items are accounted for. r1787 O6 is repaired in the INDEX.

## C. L214_ineq_iff

[L214Frame.lean:225-229](../lean/HamiltonsCubic/Results/L214Frame.lean): from $\theta t=P_D+a$, $\tfrac\theta2t(1-t)\le a\iff P_D\le\tfrac\theta2t(1+t)$. Check: $a=\theta t-P_D$, and $\theta t-\tfrac\theta2t(1-t)=\tfrac\theta2t(1+t)$, so the two sides are the same inequality. The hypothesis has the shape of `L214_frame`'s third conjunct ([L214Frame.lean:92](../lean/HamiltonsCubic/Results/L214Frame.lean)), $\theta\lVert D\rVert^2=P(D)+T(D,N,N)$, with $t=\lVert D\rVert^2$ and $a=T(D,N,N)$ as the record defines them. This is the record's "equivalently" as an `↔`, closing r1787 O2. CONFIRMED.

## Observations

- **O1 ([L217Orbit.lean:58-65](../lean/HamiltonsCubic/Results/L217Orbit.lean), against [second-order.md:1461](../findings/second-order.md)).** `L217_orbit` needs the gap at $v=\mathrm{rotR}\,U^{\mathsf T}V$, and the record assumes the gap only for $H\perp T_u\mathcal O$. Reaching the record's hypothesis needs $V\perp T_{u'}\mathcal O\Rightarrow v\perp T_u\mathcal O$, and the layer has no orbit tangent to state it. At a global maximiser the gap holds for all $v\perp u$ at $\gamma=0$ (`Tsym_cap`), so the tangent condition is load-bearing only at $\gamma>0$ gaps, which is where corollaries (a) and (b) live.
- **O2 (commit message of 52afe769, third bullet).** "`L217_orbit`: … L217's owed O(n)-equivariance" reads as discharging the equivariance. The INDEX row is more precise: equivariance of criticality and of the gap value is proved, and of the orbit-tangent condition owed. No file change is needed, and later references should quote the INDEX row.
- **O3 ([second-order.md:1451](../findings/second-order.md)).** The record's L217 note cites L217.lean, L217Op.lean and L217Le.lean, and omits L217Orbit.lean. A clause "the $O(n)$-transport of criticality and of the gap along a single direction is `L217_orbit` in L217Orbit.lean, the orbit-tangent transport owed" would bring it level with the INDEX.
- **O4 ([L222Op.lean:197-198](../lean/HamiltonsCubic/Results/L222Op.lean), INDEX:151).** The docstring and the row write "in particular $G=G_x=\nu\circ\nu$". The second equality is item 2, which is owed. `crit_pair` applies to $\nu\circ\nu$ and to the record's diagonal $G_x$ separately, each being self-adjoint, so nothing is overclaimed about item 6. The chain of equalities could suggest item 2 is available, and "$G=G_x$ (and $G=\nu\circ\nu$, equal to $G_x$ by item 2)" would say it exactly.
- **O5 ([L222Op.lean:122-123](../lean/HamiltonsCubic/Results/L222Op.lean), INDEX:151).** The record's $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$ has both summands inside $\mathcal W_n$. `InSjk x ∧ IsWeyl2 x` contains it, and equality needs the character components of a Weyl operator to be Weyl (true: the sign group acts on $\mathcal W_n$, and `char_split_zero` makes the components unique). r1787 O4 named this step and it is still unstated. "$\mathcal S_{jk}\cap\mathcal W_n$" in the row is literally `Sjk_mul_weyl`, so the row is accurate as written. The record's clause "$\mathcal S_{jk}$ is a subalgebra" is covered once the identification is typed.
- **O6 (finding, [second-order.md:1575](../findings/second-order.md)).** The record's note still reads "The Lean owes item 2, item 3's $2L_{D_+}D_-=\theta D_-$, item 4 and the rotation invariance." r1787 O6's repair asked for both lists to gain items 5 and 6. 52afe769 repaired the INDEX only. The note is now wrong in two directions: it omits item 5 from the owed list, and it lists item 3's odd part as owed while INDEX:151 records it PROVED in L222Swap.lean (subject to r1788). It also does not mention `crit_pair` for item 6. Repair: rewrite the note's owed list as "item 1's rotation invariance, item 2, item 4, and item 5 (only `pair_mass_le` typed)", and add `crit_pair` (item 6) and L222Swap.lean's `Sjk_odd` (item 3's odd part) to the list of what is checked.
- **O7 (non-vacuity, A.6).** The `L217_orbit` witness discharges every hypothesis at a concrete $n=4$ maximiser except the existence of a unit Weyl $v\perp a$, which it quantifies over, and it sits at $s=0$. Neither L217Orbit.lean nor L217Op.lean carries a witness in the file. A lemma giving a unit Weyl vector orthogonal to a given one at $n\ge4$ (from $\dim\mathcal W_n\ge2$) would close the first gap.

## Falsifiers

| Headline | Object that would falsify it |
|---|---|
| A1, `rotR` is the orbit action | an orthogonal $U$ and a Weyl $u$ for which $\mathrm{rotR}\,U\,u$ differs from $g\cdot u$ under the record's pullback action, e.g. if `cU` were $UXU^{\mathsf T}$ (it is $U^{\mathsf T}XU$, so the two conventions agree up to $U\leftrightarrow U^{\mathsf T}$, which ranges over the same group) |
| A3, `L217_orbit` | an orthogonal $U$, a unit critical Weyl $u$ with $\theta>0$, a unit Weyl $v\perp u$ with $T(u,v,v)\le\theta(\tfrac12-\gamma)$ and admissible $c,s$, with $W^\ast=c\,u'+s\,v'$ maximising $P$ and $P(W^\ast)\ne\theta$ (kernel-checked, so only a kernel or axiom defect) |
| A4, INDEX:145 accurate | a step of the record's proof listed as proved there with no covering declaration. The one candidate, the orbit-tangent transport, is listed as owed |
| B1, `crit_pair` matches item 6 | `innerOp2` counting ordered pairs (a factor 2 against $\sum_{a<b}$), refuted by `inner2`'s half-trace and the $\tfrac12$ in `innerOp2` |
| B3, INDEX:151 covers items 1 to 6 | an item of L222 absent from both the proved and the owed clauses. None found |
| C1, `L214_ineq_iff` | reals $\theta,t,P_D,a$ with $\theta t=P_D+a$ satisfying one side and not the other. None exist, since the two sides differ by the substitution $a=\theta t-P_D$ |

## Verdict

**CONFIRMED WITH OBSERVATIONS.** Every new declaration states what the INDEX says it states, at hypotheses no stronger than the record's, on the standard three axioms. One finding, O6: the record's L222 note at second-order.md:1575 still carries the owed list r1787 refuted, and it is now also stale on item 3's odd part.
