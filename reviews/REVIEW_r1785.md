# REVIEW r1785: L219FrameDiag.lean (9ea78e69)

Gate 2 reader for the Lean layer, statement fidelity. Analysis only: the compute was `lake build HamiltonsCubic.Results.L219FrameDiag` (cached, clean), `python3 scripts/misc/axiom_audit.py --only L219FrameDiag.lean` (10/10 clean on the standard three) and one scratch check file under the session scratchpad (`#print axioms`, one witness, one column computation, one `rfl` identity), listed in section 4. No numerics.

| Claim | Verdict | Reason |
|---|---|---|
| `col`, `col_unit` | CONFIRMED | `col U k a = U a k` is column $k$, the frame vector $u_k=Ue_k$, unit at orthogonal $U$ |
| `flip_eq_Su`, `Su_col` | CONFIRMED | $\mathrm{flip}_k=S_{e_k}$ and $S_{Ue_k}=US_{e_k}U^{\mathsf T}$ |
| `sig_eq_rotR`, `rotR_Su_col` | CONFIRMED | $\sigma_{e_k}$ is `rotR` of the coordinate reflection, so $\sigma_{u_k}=U\sigma_{e_k}U^{\mathsf T}$ as operators on `CurvOp2` |
| `half_odd_iff`, `odd_frame_iff`, `diag_frame_iff` | CONFIRMED | the odd part vanishes iff $\sigma W=W$, and both sides transport through `rotR Uᵀ` |
| `diagonal_iff_even_frame` against L219's diagonality clause | CONFIRMED | frame = columns of $U$, "diagonal in the frame" = `rotR U` of a coordinate-diagonal weight operator, which sends $u_i\wedge u_j$ to $w_{ij}\,u_i\wedge u_j$ (section 2) |
| `diagonal_iff_even_but_one_frame` against "$k=1,\dots,n-1$" | CONFIRMED | any omitted $k_0$ in place of $k_0=n$, a harmless generalisation |
| lean/INDEX.md:148 L219 (statement), the L219FrameDiag clause | CONFIRMED | describes what the file proves and nothing more |
| lean/INDEX.md:148 "Every clause of L219 is typed and proved." | REFUTED AS STATED | the record's first display holds at every $W\in\mathcal W_n$ and is typed only under `hQ`, and the maximiser bound at a general unit $u$ carries two hypotheses the record lacks (O1, O2) |

**Summary**: L219FrameDiag.lean is sound, axiom-clean, non-vacuous and is the record's diagonality clause in every orthonormal frame, with the orientation (columns, $U\,D\,U^{\mathsf T}$) right. The finding is against the closing sentence of the INDEX row and its twin at findings/second-order.md:1503: two clauses of L219 are proved only under stronger hypotheses than the record's, one of them the r1783 O1 caveat the same row already records.

## 1. Source, verbatim

[findings/second-order.md:1508](../findings/second-order.md):

> **And $W$ is coordinate-diagonal in an orthonormal frame $(e_1,\dots,e_n)$ exactly when its $\sigma_{e_k}$-odd part vanishes for $k=1,\dots,n-1$**, the last reflection being redundant since $-I$ acts trivially on $\mathcal W_n$.

[findings/second-order.md:1504](../findings/second-order.md) fixes $\sigma_u$: "*$\sigma_u\in O(n)$ the reflection in $u^\perp$, and split $W\in\mathcal W_n$ as $W=b+c$ with $\sigma_ub=b$ and $\sigma_uc=-c$.*"

[findings/second-order.md:1515](../findings/second-order.md), proof step 3:

> 3. **Diagonality.** The reflections $\sigma_{e_k}$ generate the sign group $\Gamma$ of the frame, and $\mathcal D_n$ is exactly the $\Gamma$-fixed subspace ([L214](...), from [L120](...)). So $W\in\mathcal D_n$ iff $\sigma_{e_k}W=W$ for every $k$, iff every odd part vanishes, and $\sigma_{e_1}\cdots\sigma_{e_n}=-I$ acts trivially, so $n-1$ of them suffice.

**Lean, [L219FrameDiag.lean:110-114](../lean/HamiltonsCubic/Results/L219FrameDiag.lean).**

```
theorem diagonal_iff_even_frame {U} (hU : IsOrth U) (W : CurvOp2 (Fin n)) (hW : IsWeyl2 W) :
    (∀ k, (1 / 2 : ℝ) • (W - rotR (Su (col U k)) W) = 0) ↔
      ∃ (w) (hw : IsWeight w), W = rotR U (RealLayer.restrict (diagOp_isWeyl hw))
```

and [L219FrameDiag.lean:117-122](../lean/HamiltonsCubic/Results/L219FrameDiag.lean), the same with `∀ k, k ≠ k0 → ...`.

## 2. Check by check

**2.1 Orientation of "diagonal in the frame $(u_k)$".** From [FrameOp2.lean:36-58](../lean/HamiltonsCubic/Results/FrameOp2.lean): `cU U X = Uᵀ X U` and `rotR_coe` gives `rotR U V X = U · V(Uᵀ X U) · Uᵀ`. `diagOp w X = (w_ab X_ab)` ([Families.lean:147](../lean/HamiltonsCubic/Base/Families.lean)), and `restrict` agrees with it on $\Lambda^2$ ([Bivectors2.lean:863](../lean/HamiltonsCubic/Base/Bivectors2.lean)). Let $u_k$ = `col U k`, so $u_k=Ue_k$ ([L219FrameDiag.lean:31](../lean/HamiltonsCubic/Results/L219FrameDiag.lean): `col U k a = U a k`). Take $X=u_iu_j^{\mathsf T}-u_ju_i^{\mathsf T}$. Then $U^{\mathsf T}u_i=U^{\mathsf T}Ue_i=e_i$ by `hU.1`, so $U^{\mathsf T}XU=E_{ij}-E_{ji}$. The Hadamard weight gives $w_{ij}E_{ij}-w_{ji}E_{ji}=w_{ij}(E_{ij}-E_{ji})$ by `IsWeight.symm`, and conjugating back gives $w_{ij}(u_iu_j^{\mathsf T}-u_ju_i^{\mathsf T})$. So `rotR U (restrict (diagOp_isWeyl hw))` sends $u_i\wedge u_j$ to $w_{ij}\,u_i\wedge u_j$ in the frame of COLUMNS, as the docstring at [L219FrameDiag.lean:13-14](../lean/HamiltonsCubic/Results/L219FrameDiag.lean) says. With rows $r_k=U^{\mathsf T}e_k$ in place of columns, $U^{\mathsf T}r_i=(U^2)^{\mathsf T}e_i$, which is $e_i$ only when $U^2=1$, so a swap would have been visible. The Lean pins the column reading on its own side too: `Su_col` proves $S_{\mathrm{col}\,U\,k}=U\,\mathrm{flip}_k\,U^{\mathsf T}$, which is false for rows at a non-involutive $U$. No swap.

**2.2 The reflection.** `Su u = 1 - 2 • vecMulVec u u` ([L219Gen.lean:31](../lean/HamiltonsCubic/Results/L219Gen.lean)), the reflection in $u^\perp$ at unit $u$, and `col_unit` supplies $\lVert u_k\rVert=1$ from `hU.1`. `rotR S` is the $O(n)$ action $V\mapsto\Lambda^2S\circ V\circ\Lambda^2S^{-1}$ with $\Lambda^2S\,X=SXS^{\mathsf T}$, the same $\sigma_u$ as `L219_gen` and `L219_ops_gen` use, confirmed there by r1783 and r1784. `sig_eq_rotR` identifies it with L219Op's `sig k` at $u=e_k$, using `flip_T`. Matches.

**2.3 Hypotheses.** `IsOrth U` is $U^{\mathsf T}U=1\wedge UU^{\mathsf T}=1$ ([Frames.lean:27](../lean/HamiltonsCubic/Base/Frames.lean)). The two conjuncts are equivalent for square real matrices, and every ordered orthonormal frame of $\mathbb R^n$ is the column list of exactly one such $U$. So the quantifier over $U$ is the record's "any orthonormal frame". `IsWeyl2 W` (self-adjoint, first Bianchi, Ricci-flat, [Bivectors2.lean:352](../lean/HamiltonsCubic/Base/Bivectors2.lean)) is the record's $W\in\mathcal W_n$. Neither is stronger than the record, and the witness of section 4 shows both satisfiable with a non-coordinate frame and a nonzero $W$.

**2.4 "Coordinate-diagonal" as $\mathcal D_n$.** The right-hand side asks for a weight $w$ with `IsWeight w` (symmetric, hollow, zero row sums), the record's $\mathcal D_n$ in the frame. Row sums are forced by Ricci-flatness once $W$ is diagonal and Weyl, so no diagonal Weyl operator is excluded, and the coordinate-frame version `diagonal_iff_even` ([L219Diag.lean:82](../lean/HamiltonsCubic/Results/L219Diag.lean)) was confirmed on this reading by r1777.

**2.5 The $n-1$ clause.** The record drops $k=n$, and the Lean drops an arbitrary $k_0$. At $k_0=n$ it is the record's statement, so the Lean is at least as strong.

**2.6 The proof route** matches step 3 transported: `odd_frame_iff` moves each odd-part condition to $U^{\mathsf T}WU$ at $\sigma_{e_k}$ through `rotR_Su_col`, `rotR_comp`, `rotR_inv`, and `diag_frame_iff` moves the diagonal form the same way. The coordinate case then does the work, so the frame version inherits L219Diag's content and adds only the transport, which is all the record's "in an orthonormal frame" asks.

## 3. The INDEX row and the clause map

[lean/INDEX.md:148](../lean/INDEX.md), the L219FrameDiag clause: "with $u_k=Ue_k$ the columns of an orthogonal $U$, `rotR_Su_col` gives $\sigma_{u_k}=U\sigma_{e_k}U^{\mathsf T}$ [...] a Weyl $W$ is $U\,D\,U^{\mathsf T}$ for a diagonal $D\in\mathcal D_n$ iff $\tfrac12(W-\sigma_{u_k}W)=0$ for every $k$, iff for every $k\ne k_0$; standard three axioms." Accurate.

Every clause of the record's statement ([findings/second-order.md:1504-1508](../findings/second-order.md)) against its covering theorem:

| # | Record clause | Record hypothesis | Covering Lean | Lean hypothesis | Match |
|---|---|---|---|---|---|
| 1 | $P(W)=P(b)+3\langle L_bc,c\rangle$ | $W\in\mathcal W_n$, unit $u$ | `L219_gen` ([L219Gen.lean:75](../lean/HamiltonsCubic/Results/L219Gen.lean)) and `L219_op` ([L219Op.lean:164](../lean/HamiltonsCubic/Results/L219Op.lean)) at $u=e_m$ | both carry `hQ : Qop2 W = θ • W` | no, critical $W$ only (O1) |
| 2 | $P(c)=0$ | same | same | same | no (O1) |
| 3 | $\langle b\circ b,c\rangle=0$ | same | `L219_gen` ($T(b,b,c)=0$) | `hQ` | no (O1) |
| 4 | $b\circ b+c\circ c=\theta b$ | $Q(W)=\theta W$ | `L219_ops_gen`, `L219_ops` | `hQ` | yes |
| 5 | $2\,b\circ c=\theta c$ | same | same | same | yes |
| 6 | $\langle L_bc,c\rangle=\tfrac\theta2\lVert c\rVert^2$ | same | `L219_gen`, `L219_op` | same | yes |
| 7 | $P(b)=\theta(\lVert b\rVert^2-\tfrac12\lVert c\rVert^2)$ | same | `L219_gen`, `L219_op` | same | yes |
| 8 | diagonal in an orthonormal frame iff odd parts vanish | $W\in\mathcal W_n$ | `diagonal_iff_even_frame`, coordinate case `diagonal_iff_even` | `IsWeyl2`, `IsOrth` | yes |
| 9 | $n-1$ reflections suffice | same | `diagonal_iff_even_but_one_frame`, `diagonal_iff_even_but_one` | same | yes |
| 10 | at a unit global maximiser, $\lVert c_u\rVert^2\le\tfrac34$ for every unit $u$ | unit maximiser | `odd_mass_gen` ([L219Gen.lean:142-145](../lean/HamiltonsCubic/Results/L219Gen.lean)) at every $u$, and `odd_mass_global` ([L219Max.lean:107](../lean/HamiltonsCubic/Results/L219Max.lean)) hypothesis-free at $u=e_m$, $n\ge4$ | `odd_mass_gen` adds `hQ` and `hθ : 0 < θ` | derivable, untyped at general $u$ (O2) |
| – | $b,c\in\mathcal W_n$ (implicit in "split $W\in\mathcal W_n$") | | `even_odd_isWeyl2` at $e_m$, and at general $u$ inside `L219_gen`'s proof via `rotR_isWeyl2` | | yes |

## 4. Axioms and the witness

Scratch file (session scratchpad, R1785.lean), compiled with `lake env lean`:

```
'HamiltonsCubic.L219FrameDiag.diagonal_iff_even_frame' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L219FrameDiag.diagonal_iff_even_but_one_frame' depends on axioms: [propext, Classical.choice, Quot.sound]
```

`axiom_audit.py --only L219FrameDiag.lean`: "10/10 clean -- resting on the standard three alone".

**Witness, compiled.** $n=4$, $w$ the $S^2\times S^2$ pattern $w_{01}=w_{23}=2$ and $w=-1$ on the other four pairs (`IsWeight` proved by `fin_cases`), $u=(\tfrac12,\tfrac12,\tfrac12,\tfrac12)$, $U=S_u$ (orthogonal by `Su_orth`), $W=U\,\mathrm{diagOp}(w)\,U^{\mathsf T}$ (Weyl by `rotR_isWeyl2`, `isWeyl2_restrict`). The frame is $u_k=e_k-2u_ku=e_k-\tfrac12\mathbf 1$, a non-coordinate frame, and `col (Su u4) 0 = ![1/2, -1/2, -1/2, -1/2]` compiles. The theorem's reverse direction then asserts, and the scratch file derives, that $\tfrac12(W-\sigma_{u_k}W)=0$ for all four $k$, so $W$ is fixed by the reflection in each $u_k^\perp$. The forward direction at this $W$ returns a weight whose conjugate is $W$. The instance is nonzero since $w\ne0$ and `rotR U` is invertible (`rotR_inv`).

**Also compiled**: `HamiltonsCubic.L219FrameDiag.col U k = Matrix.col U k` by `rfl` (O3).

## 5. Observations

- **O1 (finding, against [lean/INDEX.md:148](../lean/INDEX.md) and [findings/second-order.md:1503](../findings/second-order.md)).** The record's first display, $P(W)=P(b)+3\langle L_bc,c\rangle$, $P(c)=0$, $\langle b\circ b,c\rangle=0$, is stated at every $W\in\mathcal W_n$ ([second-order.md:1504-1505](../findings/second-order.md)). Its only $\mathcal W_n$ instantiations, `L219_op` ([L219Op.lean:164](../lean/HamiltonsCubic/Results/L219Op.lean)) and `L219_gen` ([L219Gen.lean:75-76](../lean/HamiltonsCubic/Results/L219Gen.lean)), take `hQ : Qop2 W = θ • W`, and the abstract `reflection_split` is instantiated on `RecCurv` only inside `L219_op` ([L219Op.lean:205](../lean/HamiltonsCubic/Results/L219Op.lean)). At a non-critical Weyl $W$ no $\theta$ exists, so those three clauses are typed nowhere there. This is r1783 O1, which the same INDEX row records, so the row's closing sentence "Every clause of L219 is typed and proved." contradicts its own caveat. The record's "so the lemma is typed in full" at :1503 overclaims the same way. Repair: an unconditional `L219_split_gen` (r1783 notes the proofs of these clauses never use `hQ`), or narrow both sentences.
- **O2 (finding, same sentence).** The record's last clause is hypothesis-free: "At a unit global maximiser, $\lVert c_u\rVert^2\le\tfrac34$ for every unit $u$." `odd_mass_gen` ([L219Gen.lean:142-144](../lean/HamiltonsCubic/Results/L219Gen.lean)) adds `hQ` and `hθ : 0 < θ`. `odd_mass_global` ([L219Max.lean:107-115](../lean/HamiltonsCubic/Results/L219Max.lean)) discharges both from the maximiser hypothesis at $n\ge4$ through `Qop2_eq_smul_weyl` and `exists_weyl_maximiser`, but only at coordinate reflections `sig m`. The same composition with `odd_mass_gen` would close it at every $u$ and is untyped. At $n\le3$, $\mathcal W_n=0$ and the clause is vacuous.
- **O3 (naming).** `col` ([L219FrameDiag.lean:31](../lean/HamiltonsCubic/Results/L219FrameDiag.lean)) duplicates Mathlib's `Matrix.col` (equal by `rfl`) and is ambiguous in any file that opens both `Matrix` and `HamiltonsCubic.L219FrameDiag`, which the scratch file hit. Harmless inside the file. The same pattern as r1784 O4's `isOrth_transpose` collision.
- **O4 (unused).** `col_unit` ([L219FrameDiag.lean:33](../lean/HamiltonsCubic/Results/L219FrameDiag.lean)) is used by no proof in the tree. It documents that `Su (col U k)` is a reflection, which the headline never needs since `Su_col` rewrites it to a conjugate of `flip k`. Worth keeping as the link to the record's "reflection in $u_k^\perp$".
- **O5 (stale pointer).** [findings/second-order.md:1503](../findings/second-order.md) still reads "Gate 2 [r1784](../reviews/REVIEW_r1784.md) pending" for L219GenOps.lean, and r1784 is filed (CONFIRMED WITH OBSERVATIONS).

## 6. Falsifiers

| Statement | Object that would falsify it |
|---|---|
| `diagonal_iff_even_frame`, forward | an orthogonal $U$ and a Weyl $W$ fixed by every $\sigma_{u_k}$, $u_k$ the columns, with $U^{\mathsf T}WU$ not of the form `diagOp w` for any weight $w$ |
| `diagonal_iff_even_frame`, reverse | a weight $w$, orthogonal $U$ and column $u_k$ with $\sigma_{u_k}(U\,\mathrm{diagOp}(w)\,U^{\mathsf T})\ne U\,\mathrm{diagOp}(w)\,U^{\mathsf T}$ |
| `diagonal_iff_even_but_one_frame` | a Weyl $W$ fixed by $\sigma_{u_k}$ for all $k\ne k_0$ and moved by $\sigma_{u_{k_0}}$ |
| `Su_col` | an orthogonal $U$ with $I-2u_ku_k^{\mathsf T}\ne U\,\mathrm{flip}_k\,U^{\mathsf T}$ for a column $u_k$ |
| the INDEX sentence "Every clause of L219 is typed and proved" | already falsified: $P(c)=0$ at a non-critical Weyl $W$ has no covering theorem (O1) |

## 7. Verdict

**CONFIRMED WITH OBSERVATIONS for L219FrameDiag.lean, and REFUTED AS STATED for the INDEX sentence "Every clause of L219 is typed and proved."** The file is the record's diagonality clause in every orthonormal frame with the orientation right, and its INDEX clause says exactly that. O1 and O2 are repairs to the INDEX row and findings:1503 (or two short theorems), O3 to O5 are bookkeeping, and none affects a theorem's truth.
