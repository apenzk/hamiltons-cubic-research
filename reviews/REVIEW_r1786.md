# REVIEW r1786: L214Frame.lean, L219's r1785 repairs and the two INDEX clause sentences (7f0505f3)

Gate 2 reader for the Lean layer, statement fidelity. Analysis only: the compute was `python3 scripts/misc/axiom_audit.py --only L214Frame.lean` (8/8 clean on the standard three) and one scratch file under the session scratchpad (R1786.lean, compiled with `lake env lean`), holding `#print axioms`, a bridge identity, a uniqueness theorem for `piF` and one witness, listed in section 4. No numerics.

| Claim | Verdict | Reason |
|---|---|---|
| `piF` is the record's $D=\pi_FW$ | CONFIRMED | `piF_diag` puts it in the frame-diagonal family, `piF_perp` makes the remainder orthogonal to that family, and the two together determine it (proved in scratch as `r1786_unique`, section 2) |
| "diagonal in $F$" is `rotR U (restrict (diagOp_isWeyl hw))`, frame = columns of $U$ | CONFIRMED | `rotR_coe` gives $U\varphi_{ab}U^{\mathsf T}=u_a\wedge u_b\mapsto w_{ab}\,u_a\wedge u_b$, $u_k=Ue_k$ |
| `L214_frame` against the two relations | CONFIRMED | hypotheses are the record's unit critical point, $a$ = `Tsym D N N` $=\langle L_DN,N\rangle$ (scratch `r1786_bridge`), $t$ = `normSq2 D` |
| `L214_frame_max`, `L214_frame_global` against the inequality at the two cases L24 supplies | CONFIRMED | local maximiser with $\theta>0$, and global maximiser with $\theta=P(W)$ derived, $n\ge4$ vacuous as a restriction ($\mathcal W_n=0$ at $n\le3$) |
| lean/INDEX.md:199 "Every clause of L214's statement has a covering theorem in every frame." | REFUTED AS STATED | the record's inequality clause is a conditional on the cap $L_W\le\tfrac\theta2$ on $W^\perp$ at any unit critical point, and it is covered only under the stronger maximiser hypotheses. The "equivalently $P(D)\le\tfrac\theta2t(1+t)$" form and $t\in[0,1]$ have no declaration (O1, O2) |
| `L219_split_gen` against L219's first display | CONFIRMED | unit $u$, Weyl $W$, no `hQ`: split, $P(c)=0$, $T(b,b,c)=0$ and $\langle b,c\rangle=0$ |
| `odd_mass_gen_global` against "at a unit global maximiser, $\lVert c_u\rVert^2\le\tfrac34$ for every unit $u$" | CONFIRMED | only extra hypothesis $n\ge4$, vacuous |
| lean/INDEX.md:148 clause map "Every clause of L219's statement has a covering theorem at the record's hypotheses: ..." | CONFIRMED WITH OBSERVATIONS | all ten clauses covered, the only extra hypothesis is $n\ge4$ on the bound (O4). r1785's refutation is answered |
| `foxProd2_rotR`, the `fcol` rename | CONFIRMED | polarisation of `Qop2_rotR` on Weyl pairs, rename complete with no stale `col` reference |

**Summary**: every declaration in 7f0505f3 is sound, axiom-clean and says what its docstring says, and the L219 repairs close r1785 O1 and O2 exactly. The finding is against the L214 INDEX row's completeness sentence: the record states the inequality under the cap hypothesis, and the Lean proves it only at the maximisers where L24 supplies the cap.

## 1. Sources, verbatim

[findings/second-order.md:1354-1357](../findings/second-order.md), Lemma L214:

> **Fix any orthonormal frame $F$ of $\mathbb R^n$ and split a unit critical point as $W=D+N$, where $D=\pi_FW$ is its coordinate-diagonal part in $F$ and $N=W-D$, with $t=t_F=\lVert D\rVert^2\in[0,1]$ and $a=\langle L_DN,N\rangle$. Then**
> $$\theta\,t=P(D)+a,\qquad\theta\,(1-t)=2a+P(N),$$
> **and if in addition $L_W\le\tfrac\theta2$ on $W^\perp$, which [Lemma L24] gives at every GLOBAL maximiser, and at a local one with $\theta>0$, then**
> $$a\ \ge\ \tfrac\theta2\,t(1-t),\qquad\text{equivalently}\qquad P(D)\ \le\ \tfrac\theta2\,t(1+t).$$

[findings/second-order.md:1505-1509](../findings/second-order.md), Lemma L219: "Let $u\in\mathbb R^n$ be a unit vector, $\sigma_u\in O(n)$ the reflection in $u^\perp$, and split $W\in\mathcal W_n$ as $W=b+c$ with $\sigma_ub=b$ and $\sigma_uc=-c$. Then $P(W)=P(b)+3\langle L_bc,c\rangle$, $P(c)=0$, $\langle b\circ b,c\rangle=0$. If $W$ is a critical point, $Q(W)=\theta W$, then $b\circ b+c\circ c=\theta b$, $2\,b\circ c=\theta c$, $\langle L_bc,c\rangle=\tfrac\theta2\lVert c\rVert^2$, $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$. And $W$ is coordinate-diagonal in an orthonormal frame $(e_1,\dots,e_n)$ exactly when its $\sigma_{e_k}$-odd part vanishes for $k=1,\dots,n-1$ [...]. At a unit global maximiser, $\lVert c_u\rVert^2\le\tfrac34$ for every unit $u$."

## 2. L214Frame.lean

**What $\pi_F$ is.** [L214Frame.lean:34-36](../lean/HamiltonsCubic/Results/L214Frame.lean) defines `piF hU W hW = rotR U (comp ∅ (rotR Uᵀ W) _)`. By [FrameOp2.lean:54-57](../lean/HamiltonsCubic/Results/FrameOp2.lean) (`rotR_coe`), `rotR U V X = U·V(UᵀXU)·Uᵀ`, so `rotR Uᵀ W` is $W$ read in the frame coordinates: its $(\varphi_{ab},\varphi_{cd})$ entry is $\langle W(u_a\wedge u_b),u_c\wedge u_d\rangle$ with $u_k=Ue_k$ the columns and $U\varphi_{ab}U^{\mathsf T}=u_au_b^{\mathsf T}-u_bu_a^{\mathsf T}$. `comp ∅` is the sign-fixed component, which `trivial_block_iff` ([L120Ident.lean:49](../lean/HamiltonsCubic/Results/L120Ident.lean)) identifies with `restrict (diagOp w)` for a weight $w$ (symmetric, hollow, zero row sums, [Families.lean:147-160](../lean/HamiltonsCubic/Base/Families.lean)). Transporting back, `rotR U (restrict (diagOp w))` sends $u_a\wedge u_b$ to $w_{ab}\,u_a\wedge u_b$, which is "coordinate-diagonal in $F$". The same form is L219FrameDiag's, so the two files agree on what diagonal in a frame means.

**Uniqueness, argued and compiled.** Let $\mathcal S_F$ be the set of operators `rotR U (restrict (diagOp_isWeyl hw))`. Suppose $D_1,D_2\in\mathcal S_F$ with $W-D_i\perp\mathcal S_F$ for $i=1,2$. Then the four pairings $\langle D_i,W-D_j\rangle$ all vanish, so
$$\lVert D_1-D_2\rVert^2=\langle (W-D_2)-(W-D_1),\,D_1-D_2\rangle=\langle D_1,W-D_2\rangle-\langle D_2,W-D_2\rangle-\langle D_1,W-D_1\rangle+\langle D_2,W-D_1\rangle=0,$$
and `normSq2_eq_zero` gives $D_1=D_2$. The argument needs no linearity of $w\mapsto$ `diagOp w`, only the two memberships and the four orthogonalities. `piF_diag` ([:55-59](../lean/HamiltonsCubic/Results/L214Frame.lean)) and `piF_perp` ([:62-78](../lean/HamiltonsCubic/Results/L214Frame.lean)) supply exactly the hypotheses for $D_2$ = `piF`, so `piF` is the unique element of $\mathcal S_F$ with remainder orthogonal to $\mathcal S_F$, which is the orthogonal projection. Compiled in scratch:

```
theorem r1786_unique {n : ℕ} {U : Matrix (Fin n) (Fin n) ℝ} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W)
    (D : CurvOp2 (Fin n))
    (hDd : ∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), D = rotR U (restrict (diagOp_isWeyl hw)))
    (hDp : ∀ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w),
      innerOp2 (rotR U (restrict (diagOp_isWeyl hw))) (W - D) = 0) :
    D = piF hU W hW
```

The projection is onto the Weyl diagonal operators (weights with zero row sums). That is the record's $\mathcal D_n$, and it agrees with truncating $W$ to its pair-diagonal entries, since those entries' row sums are Ricci entries and vanish at Weyl $W$.

**Hypotheses of `L214_frame`** ([:81-87](../lean/HamiltonsCubic/Results/L214Frame.lean)): `IsWeyl2 W`, `normSq2 W = 1`, `Qop2 W = θ • W`. The record's "unit critical point" on $\mathcal W_n$ is $\pi_{\mathcal W}Q(W)=\theta W$ at unit norm, and $Q$ preserves $\mathcal W_n$ (`isWeyl2_Qop2`, [WeylMaximiser.lean](../lean/HamiltonsCubic/Results/WeylMaximiser.lean)), so the Lean hypothesis is the record's. $\theta=P(W)$ follows (`Pcubic2_crit`, [L217Le.lean](../lean/HamiltonsCubic/Results/L217Le.lean)).

**$a$.** The record's $a=\langle L_DN,N\rangle$ with $L_e=e\circ(\cdot)$ and $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ ([conventions.md:136](../findings/conventions.md)), which is `foxProd2` ([FirstVariation.lean:57](../lean/HamiltonsCubic/Results/FirstVariation.lean)). The Lean writes `Tsym D N N`. The identity `Tsym D N N = innerOp2 (foxProd2 D N) N` at self-adjoint $D,N$ follows from `Tsym_quad` ($3T(D,N,N)$ = `Pcubic2Quad D N`), `Pcubic2Quad_selfAdjoint` ($=3\langle D,Q(N)\rangle$) and `innerOp2_foxProd2_self` ($\langle D\circ N,N\rangle=\langle D,Q(N)\rangle$). It is not stated in the tree under that name. Compiled in scratch as `r1786_bridge`. $D$ and $N$ are Weyl (`isWeyl2_piF`, `isWeyl2_sub'`), hence self-adjoint, so $a$ is rendered faithfully. The normalisation is the record's: `Tsym R R R = P(R)` and $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ as tabled in conventions.md:24. $t$ = `normSq2 (piF ..)` is $\lVert D\rVert^2\in[0,1]$, the block's own half-convention, which the record flags against conventions.md's $t_F$.

**The conclusions.** `L214_frame` gives $\langle D,N\rangle=0$, $T(D,D,N)=0$ and both relations, transported from `L214_diag` by `innerOp2_rotR`, `Tsym_rotR`, `normSq2_rotR`, `Pcubic2_rotR` at Weyl arguments. The first two conjuncts are more than the record states and are the inputs the record draws from L120.

**The inequality.** `L214_frame_max` ([:102-127](../lean/HamiltonsCubic/Results/L214Frame.lean)) takes a local maximiser on `{R | normSq2 R = 1 ∧ IsWeyl2 R}` (the same set as `weylSphereSet`) and $\theta>0$. The transport of the local maximum through `rotR U` by `IsLocalMaxOn.comp_continuousOn` is correct: `rotR U` maps the sphere into itself (`hmaps`) and $P\circ$`rotR U` $=P$ on it. `L214_frame_global` ([:131-141](../lean/HamiltonsCubic/Results/L214Frame.lean)) takes `IsMaxOn` on `weylSphereSet` at $n\ge4$ and derives $Q(W)=P(W)W$ and $P(W)\ge\sqrt{3/2}>0$. So both cases the record names as L24's are covered. The restriction $n\ge4$ is vacuous: $\dim\mathcal W_n=n(n+1)(n+2)(n-3)/12$ is $0$ at $n\le3$, so no unit Weyl operator exists there. No tree lemma stating that was located, so this rests on the mathematics.

## 3. L219 repairs and the clause map

`L219_split_gen` ([L219Gen.lean:77-124](../lean/HamiltonsCubic/Results/L219Gen.lean)) takes unit `u`, `IsWeyl2 W`, nothing else, with $b,c=\tfrac12(W\pm\sigma_uW)$, $\sigma_u$ = `rotR (Su u)`, $S_u=I-2uu^{\mathsf T}$, the reflection in $u^\perp$. The record's $b,c$ are defined by $\sigma_ub=b$, $\sigma_uc=-c$, $W=b+c$, a decomposition that is unique since $\sigma_u^2=1$, and the Lean formulas are that decomposition. `T(b,b,c)` is $\langle b\circ b,c\rangle$ by `Tsym_lin` and `Pcubic2Lin_selfAdjoint` ($b$ Weyl), and `Tsym b c c` is $\langle L_bc,c\rangle$ by the bridge of section 2. `L219_gen` now takes the four clauses from it, which I checked in the diff.

`odd_mass_gen_global` ([L219GenMax.lean:25-34](../lean/HamiltonsCubic/Results/L219GenMax.lean)) takes $n\ge4$, unit `u`, `W ∈ weylSphereSet`, `IsMaxOn`, and concludes `normSq2 (½ • (W - rotR (Su u) W)) ≤ 3/4`. The composition of `Qop2_eq_smul_weyl`, `exists_weyl_maximiser` and `odd_mass_gen` is the one r1785 O2 named, and the `hmax` adapter `fun R hR hR1 => hmax ⟨hR1, hR⟩` matches `odd_mass_gen`'s form.

**Clause map, [lean/INDEX.md:148](../lean/INDEX.md).**

| # | Record clause | Record hypothesis | Covering theorem | Lean hypothesis beyond the record's |
|---|---|---|---|---|
| 1 | $P(W)=P(b)+3\langle L_bc,c\rangle$ | $W\in\mathcal W_n$, unit $u$ | `L219_split_gen` | none |
| 2 | $P(c)=0$ | same | `L219_split_gen` | none |
| 3 | $\langle b\circ b,c\rangle=0$ | same | `L219_split_gen` ($T(b,b,c)=0$) | none |
| 4 | $b\circ b+c\circ c=\theta b$ | $Q(W)=\theta W$ | `L219_ops_gen` ($Q(b)+Q(c)$, and $Q(x)=x\circ x$ by `foxProd2_self`) | none |
| 5 | $2\,b\circ c=\theta c$ | same | `L219_ops_gen` | none |
| 6 | $\langle L_bc,c\rangle=\tfrac\theta2\lVert c\rVert^2$ | same | `L219_gen` | none |
| 7 | $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$ | same | `L219_gen` | none |
| 8 | diagonal in an orthonormal frame iff all odd parts vanish | $W\in\mathcal W_n$ | `diagonal_iff_even_frame` | none |
| 9 | $k=1,\dots,n-1$ suffice | same | `diagonal_iff_even_but_one_frame` at $k_0$ = last index | none (any $k_0$, a generalisation) |
| 10 | $\lVert c_u\rVert^2\le\tfrac34$ at a unit global maximiser, every unit $u$ | unit global maximiser | `odd_mass_gen_global` | $n\ge4$, vacuous (O4) |

The sentence survives. r1785's refutation rested on clauses 1-3 and 10, and each now has a theorem at the record's hypotheses.

## 4. Axioms, the witness, the scratch file

```
'HamiltonsCubic.L214Frame.L214_frame' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Frame.L214_frame_max' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Frame.L214_frame_global' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Frame.piF_diag' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Frame.piF_perp' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219Gen.L219_split_gen' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219GenMax.odd_mass_gen_global' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219GenOps.foxProd2_rotR' depends on axioms: [propext, Classical.choice, Quot.sound]
'r1786_bridge' depends on axioms: [propext, Classical.choice, Quot.sound]
'r1786_unique' depends on axioms: [propext, Classical.choice, Quot.sound]
'r1786_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
```

`axiom_audit.py --only L214Frame.lean`: "8/8 clean -- resting on the standard three alone".

**Witness, compiled (`r1786_witness`).** $n=4$, $W$ the unit Weyl global maximiser of `exists_weyl_maximiser` ($P(W)\ge\sqrt{3/2}$, so $W\ne0$), and $U=S_v$ with $v=(\tfrac35,\tfrac45,0,0)$, orthogonal by `Su_orth`, with $U_{00}=\tfrac7{25}$ (compiled), so the frame $u_0=(\tfrac7{25},-\tfrac{24}{25},0,0)$, $u_1=(-\tfrac{24}{25},-\tfrac7{25},0,0)$, $e_2$, $e_3$ is not the coordinate frame up to signs and order. The scratch theorem instantiates `L214_frame` (with $Q(W)=P(W)W$ from `Qop2_eq_smul_weyl`), extracting $P(W)\,t=P(D)+a$, and `L214_frame_global`, extracting $a\ge\tfrac{P(W)}2t(1-t)$, both at `piF (Su_orth _ hv) W _`. Every hypothesis of `L214_frame` is met by a nonzero object in a non-coordinate frame.

## 5. Observations

- **O1 (finding, against [lean/INDEX.md:199](../lean/INDEX.md), "Every clause of L214's statement has a covering theorem in every frame.")** The record's inequality clause ([second-order.md:1356-1357](../findings/second-order.md)) is a conditional: at any unit critical point with $L_W\le\tfrac\theta2$ on $W^\perp$, $a\ge\tfrac\theta2t(1-t)$. The named L24 cases are an aside on where the hypothesis is available. `L214_frame_max` and `L214_frame_global` ([L214Frame.lean:102-141](../lean/HamiltonsCubic/Results/L214Frame.lean)) prove the conclusion only under `IsLocalMaxOn` with $\theta>0$ or `IsMaxOn`, each stronger than the cap. The cap-conditional form is nowhere at the operator level either: `L214_op_max` ([L214Op.lean:160-165](../lean/HamiltonsCubic/Results/L214Op.lean)) also takes `hmax`, and only the abstract `maximiser_ineq` ([L214FrameSplit.lean:128-132](../lean/HamiltonsCubic/Results/L214FrameSplit.lean)) takes `hcap`. Repair: a theorem `L214_frame_cap` with hypothesis `∀ X, IsWeyl2 X → innerOp2 W X = 0 → Tsym W X X ≤ θ / 2 * normSq2 X` in place of `hmax`, `hθ` (the proof of `L214_op_max` minus its `Tsym_cap` call), or narrow the sentence to "the inequality at both maximiser cases L24 covers".
- **O2 (finding, same sentence, minor).** Two further pieces of the record's statement have no declaration: the "equivalently $P(D)\le\tfrac\theta2t(1+t)$" form, one `linarith` from `L214_frame`'s third conjunct and the inequality, and $t\in[0,1]$, which is Pythagoras from $\langle D,N\rangle=0$ and $\lVert W\rVert=1$. Either a one-line corollary or naming them as derived in the sentence settles it.
- **O3 (stale sentence, [lean/INDEX.md:199](../lean/INDEX.md)).** "The record's global maximiser is covered at $\theta>0$." now reads as a restriction, while `L214_frame_global` carries no sign hypothesis and the same row says so a sentence earlier. It should be deleted or restated as "$\theta>0$ derived". The next sentence, "Gate 2 [r1741] CONFIRMED WITH OBSERVATIONS", sits after the L214Frame paragraph but r1741 reviewed L214Op.lean (its title), so it reads as a verdict on L214Frame. It belongs after the L214Op clause.
- **O4 (clause map, [lean/INDEX.md:148](../lean/INDEX.md)).** "the bound at every global maximiser at $n\ge4$" is accurate, and the $n\ge4$ is the only hypothesis beyond the record's. It is vacuous ($\mathcal W_n=0$ at $n\le3$). One clause "no hypothesis beyond the record's, $n\le3$ being empty" would pre-empt the question. The map also leaves diagonality's theorems unnamed. They are named earlier in the row.
- **O5 (bridge untyped by name).** The identity $T(D,N,N)=\langle D\circ N,N\rangle$ that makes `Tsym` the record's $\langle L_D\,\cdot,\cdot\rangle$ is stated in L214Frame's docstring ([:20](../lean/HamiltonsCubic/Results/L214Frame.lean)) and in the L219 row ("$T(b,b,c)=0$ is $\langle b\circ b,c\rangle=0$") but proved nowhere under a name. `Tsym_eq_Le` ([L217Le.lean:34](../lean/HamiltonsCubic/Results/L217Le.lean)) is the scaled version. Scratch `r1786_bridge` is three lines and could be added to L214Op.lean.
- **O6 (uniqueness untyped).** The INDEX row's "so $\pi_F$ is the orthogonal projection the record names" is correct but its uniqueness step is argued only in prose. Scratch `r1786_unique` (section 2) types it without any linearity lemma and could be added to L214Frame.lean.
- **O7 (record pointer, [findings/second-order.md:1503](../findings/second-order.md)).** The L219 provenance note records r1785 as "CONFIRMED". r1785's verdict was CONFIRMED WITH OBSERVATIONS for L219FrameDiag.lean and REFUTED AS STATED for the INDEX sentence. The same note names this review as pending, which this file settles.

## 6. Falsifiers

| Statement | Object that would falsify it |
|---|---|
| `piF` is the record's $\pi_FW$ | an orthogonal $U$ and Weyl $W$ with some $D'\ne$ `piF` in $\mathcal S_F$ and $W-D'\perp\mathcal S_F$ (excluded by `r1786_unique`) |
| `L214_frame` | a unit Weyl $W$ with $Q(W)=\theta W$ and an orthogonal $U$ where $\theta\lVert\pi_FW\rVert^2\ne P(\pi_FW)+T(\pi_FW,N,N)$ |
| `L214_frame_max` | a unit Weyl local maximiser with $\theta>0$ and a frame with $T(D,N,N)<\tfrac\theta2t(1-t)$ |
| `L214_frame_global` | a unit Weyl global maximiser at $n\ge4$ and a frame with $T(D,N,N)<\tfrac{P(W)}2t(1-t)$ |
| INDEX:199 "Every clause [...] has a covering theorem" | already falsified as a coverage claim: a unit critical Weyl $W$ meeting the cap on $W^\perp$ that is not a local maximiser with $\theta>0$ and not a global maximiser falls under the record's clause and under no Lean theorem (O1) |
| `L219_split_gen` | a unit $u$ and non-critical Weyl $W$ with $P(c_u)\ne0$ |
| `odd_mass_gen_global` | a unit Weyl global maximiser at $n\ge4$ and a unit $u$ with $\lVert c_u\rVert^2>\tfrac34$ |
| INDEX:148 clause map | a clause of the record's L219 statement whose only covering theorem carries a hypothesis the record lacks, other than the vacuous $n\ge4$. None found |
| `foxProd2_rotR` | an orthogonal $U$ and Weyl $X,Y$ with $U(X\circ Y)U^{\mathsf T}\ne(UXU^{\mathsf T})\circ(UYU^{\mathsf T})$ |

## 7. Verdict

**CONFIRMED WITH OBSERVATIONS for L214Frame.lean, `L219_split_gen`, `odd_mass_gen_global`, `foxProd2_rotR` and the `fcol` rename, CONFIRMED WITH OBSERVATIONS for the L219 clause map at INDEX:148, and REFUTED AS STATED for INDEX:199's "Every clause of L214's statement has a covering theorem in every frame."** The theorems are true, axiom-clean, non-vacuous and faithful. `piF` is the record's projection, uniquely, and $a$ is the record's $a$. The L214 sentence overclaims on the cap-conditional form of the inequality and on its "equivalently" form (O1, O2), each repairable by a short theorem or a narrower sentence.
