# REVIEW r1704: L112 proved at the operator, relations (A) and (B) in the Weyl eigenframe (5beb9eda)

**Verdict: CONFIRMED WITH GAP.** [L112Op.lean](../lean/HamiltonsCubic/Results/L112Op.lean) discharges relations (A) and (B) with the record's constants at every orthonormal eigenframe of every Weyl operator, with $T_{abc}=c_{abc}^2$ in the record's normalisation, and `L112_op` is the record's headline at every linear Weyl operator on $\mathbb R^n$, $n\ge3$. The module builds and the audit screen reports the standard three axioms only. The gap is the pair cap $\hat S_{ab}\le1/(n-2)$, which the block names as "this lemma['s] one constructive consequence": it is true at the operator by [L31Statement](../lean/HamiltonsCubic/Results/L31Statement.lean#L452)'s `L31_cap_unit` and [L41Statement](../lean/HamiltonsCubic/Results/L41Statement.lean#L733)'s `brnorm_frame`, but no theorem types it, and the L112 row now reads **proved** with no owed clause while the statement row beside it still says the cap "DOES NOT FOLLOW".

| # | Claim | Verdict |
|---|---|---|
| 1a | `Tc v a b c = cst v a b c ^ 2` is the record's $T_{abc}=c_{abc}^2$, $c_{abc}=\langle[v_a,v_b],v_c\rangle$ in the $\tfrac12\mathop{\mathrm{tr}}$ pairing | **CONFIRMED** |
| 1b | `rowA_frame` is (A), $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$, same constant | **CONFIRMED** |
| 1c | `rowB_frame` is (B), $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, weight on the same (second) slot, same constant | **CONFIRMED** |
| 2a | `rowB_frame`'s derivation from `aW2` (innerOp_frame, frame_quad, the swap by `cst_swap23`) | **CONFIRMED** |
| 2b | `aW2` holds at every `IsWeyl W`, no criticality, matching "at every $W$" | **CONFIRMED** |
| 3a | `L112_at_frame` and `L112_op` correct at every linear Weyl operator, $n\ge3$ | **CONFIRMED** |
| 3b | "proved" on the row covers the doubly stochastic form, the eigenvector, symmetry, hollowness | **CONFIRMED**, symmetry by `S_symm` beside the headline rather than inside it (O2) |
| 3c | "proved" covers the majorisation and the L73 shadow at the operator | **CONFIRMED BY INSTANTIATION**, no operator-level theorem (O1) |
| 3d | "proved" covers the pair cap $\hat S_{ab}\le1/(n-2)$ the block attributes to the lemma | **GAP** (G1) |
| 3e | the refuted unification sentence is not claimed | **CONFIRMED** |
| 4 | Axioms: standard three only | **CONFIRMED** (screen by the repo's audit script) |

One line: the two relations L112 took as hypotheses are now kernel-checked theorems of every Weyl operator with the record's constants, so the lemma's headline is proved, and the one clause left untyped is the pair cap, true at the operator by two lemmas the layer already holds.

## Attack line 1: the objects and the constants

- **$T$.** [L41Statement.lean:721](../lean/HamiltonsCubic/Results/L41Statement.lean#L721) defines `cst v a b c := inner2 (br (v a) (v b)) (v c)`, with `inner2 X Y = ½ tr(XᵀY)` and `br X Y = XY − YX` from [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean#L39). That is [conventions.md](../findings/conventions.md)'s $c_{abc}=\langle[v_a,v_b],v_c\rangle$ in the record's $\Lambda^2$ pairing, where a unit bivector has $\mathop{\mathrm{tr}}(v^2)=-2$. `Tc` squares it. The normalisation is pinned independently by `killing_frame` returning exactly the record's Killing mass $2(n-2)$: a factor error in `cst` or `inner2` would move that constant.
- **(A).** The record ([bounds.md](../findings/bounds.md), the three per-index relations above L198) reads $\sum_{\beta\gamma}T_{k\beta\gamma}=2(n-2)$. `rowA_frame` unfolds `Smat (Tc v) x b = ∑ c, cst v x b c ^ 2` and is `killing_frame` verbatim, $\sum_b\sum_c c_{xbc}^2=2((\#\iota)-2)$ with $\#\iota=n$.
- **(B).** The record reads $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, the weight on the second slot. `rowB_frame` reads $\sum_b(\sum_c c_{xbc}^2)\lambda_b=-2\lambda_x$, the weight on the second slot. Same relation, same constant, and L112's $S\lambda=-2\lambda$ is exactly this row.
- **$S$, $\hat S$.** `Smat T a b = ∑ c, T a b c` is the block's $S_{ab}:=\sum_cT_{abc}$, and `hatS S n = S/(2(n−2))` is the normalisation that turns row sum $2(n-2)$ into $1$ and $S\lambda=-2\lambda$ into eigenvalue $-1/(n-2)$.

## Attack line 2: `rowB_frame`

- **The input.** `aW2` ([L41Statement.lean:461](../lean/HamiltonsCubic/Results/L41Statement.lean#L461)) takes only `IsWeyl W` and a skew `X` and proves $\tfrac12\sum_{ij}\langle W[X,\varphi_{ij}],[X,\varphi_{ij}]\rangle=-2\langle WX,X\rangle$. No criticality hypothesis appears in its signature or in the four `IsWeyl` components it consumes (skew-preserving, self-adjoint, Bianchi, Ricci-flat). This matches the record: (B) "is Weyl-specific since it consumes first Bianchi and Ricci-flatness", with criticality nowhere in it.
- **The frame reading.** `e1` identifies the left side with `innerOp (W ∘ ad v_x) (ad v_x)` by `rfl`, which is the definition of `innerOp` (½ Σ over the $\varphi$ basis). `innerOp_frame` replaces the $\varphi$-basis sum by the frame sum $\sum_\gamma\langle W[v_x,v_\gamma],[v_x,v_\gamma]\rangle$, and its linearity side conditions `hF`, `hG` are discharged by `br_sum_r` and `weyl_lin` on skew inputs. The frame completeness and orthonormality that `innerOp_frame` needs are fields of `EigenFrame`.
- **Each term.** `hterm` expands $[v_x,v_\gamma]=\sum_b c_{x\gamma b}v_b$ by `hf.complete` and applies `frame_quad`, $\langle W\sum d_bv_b,\sum d_bv_b\rangle=\sum_b\lambda_bd_b^2$ (eigen, orthonormal, linearity). So $\sum_\gamma\sum_b\lambda_bc_{x\gamma b}^2=-2\lambda_x$ after `hrhs` reads $\langle Wv_x,v_x\rangle=\lambda_x$.
- **The swap.** After `Finset.sum_comm` the right side is $\sum_b\sum_\gamma\lambda_bc_{x\gamma b}^2$, the weight on the third slot, and the goal has it on the second. `cst_swap23` gives $c_{xbc}=-c_{xcb}$, from `adinv` (ad-invariance of the pairing on skew matrices), and the square kills the sign. Checked by hand at each rewrite. The existing `aW2_frame` states the third-slot form, and `rowB_frame` is its second-slot twin by exactly this swap.

## Attack line 3: `L112_at_frame`, `L112_op`, and what "proved" now covers

- **`L112_at_frame`.** Its three conjuncts are `hatS_doublyStochastic` (Mathlib's `Matrix.doublyStochastic`: nonnegative, row and column sums $1$), fed nonnegativity by `sq_nonneg`, symmetry by `S_symm`, rows by `rowA_frame`. `hatS_hollow` is fed by `S_hollow` and `hatS_eigenvector` by `rowB_frame`. `S_symm` and `S_hollow` use only `cst_swap12` (antisymmetry of the bracket), so they hold at every orthonormal frame. The hypothesis `0 < n − 2` is the only numeric one.
- **Every eigenframe, not one.** The theorem quantifies over every `EigenFrame W v lam`, so the conclusion does not depend on the choice of eigenbasis inside a repeated eigenvalue, which is the reading the record needs since its $\lambda$ is "the" spectrum and its $T$ is basis-dependent.
- **`L112_op`.** `IsWeylOp W = IsLinOp W ∧ IsWeyl W` ([FoxProduct.lean:110](../lean/HamiltonsCubic/Base/FoxProduct.lean#L110)). `eigenFrame_exists` takes exactly `hW.1`, `hW.2.1`, `hW.2.2.1` (linear, skew-preserving, self-adjoint) and returns an `EigenFrame` whose `lam` is the spectrum of `Mpair W`, the record's $\lambda$. `hW.2` is the `IsWeyl` that `L112_at_frame` needs. `Fintype.card (Fin n) = n` closes the cast. The linearity clause is harmless: the record's $W$ is a linear operator on $\Lambda^2$.
- **The range $n\ge3$.** At $n=3$ every Weyl operator vanishes, so $\lambda=0$ and the eigenvector clause is trivially true, while $n-2=1>0$ keeps $\hat S$ defined. The record's $\mathcal W_n$ is nontrivial from $n=4$, and the theorem covers that range and one vacuous dimension below it.
- **Symmetry (O2).** The block says "symmetric hollow doubly stochastic". `L112_op`'s conjunction states doubly stochastic, hollow and the eigenvector, with symmetry of $\hat S$ proved as `S_symm` at the same frame and used inside. A reader of the headline alone does not see the symmetric clause.
- **Majorisation and the L73 shadow (O1).** [L112Doubly.lean](../lean/HamiltonsCubic/Results/L112Doubly.lean)'s `shadow_convex` and `L73_shadow` take `hT` (symmetric in the first two slots), `hT0`, `hA` and `hB` on an abstract `T`, in exactly the form $\sum_\beta\sum_\gamma T_{k\beta\gamma}=2(n-2)$ and $\sum_\beta\sum_\gamma\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$. At `T := Tc v` these are `T12`, `sq_nonneg`, `killing_frame` and `rowB_frame` after distributing, so the operator-level majorisation is a four-argument instantiation. No theorem performs it. The row's "proved" is accurate on that reading, and an `L112_shadow_op` would make it a citation.
- **The pair cap (G1).** The block's correction reads: the T9 run "omits the pair cap the record's own full pinned relaxation includes, which this lemma supplies as $\hat S_{ab}\le1/(n-2)$, its one constructive consequence, unused". The statement row correctly says the cap does not follow from (A), (B), symmetry and nonnegativity on an abstract $T$. At the operator it does follow, from outside that hypothesis set: `brnorm_frame` gives $S_{ab}=\lVert[v_a,v_b]\rVert^2$ and `L31_cap_unit` gives $\lVert[X,Y]\rVert^2\le2$ at unit skew $X,Y$, so $\hat S_{ab}\le2/(2(n-2))=1/(n-2)$. Neither `L112Op.lean` nor the row carries this. The row moved to **proved** and dropped its owed list, while the statement row beside it still reads **partial** on exactly this clause. Repair: add `hatS_pair_cap` to L112Op (a few lines from the two cited lemmas) and name it on the row, or list the cap as owed on the L112 row.
- **The refuted sentence.** The block's "so" that bounds $\theta$ from this system is refuted by r649 and r650. The row claims nothing of it and explains why (A) and (B) cannot bound $\theta$ (they do not contain it). Correctly not claimed.

## Attack line 4: axioms and build

- `lake build HamiltonsCubic.Results.L112Op` completed with no errors, only linter notes (screen).
- `python3 scripts/misc/axiom_audit.py --only L112Op.lean`: 7/7 clean, resting on propext, Classical.choice and Quot.sound alone (screen).
- `L112Op.lean` contains no `sorry`, no `native_decide`, no `axiom` declaration (read).

## What would break the claims, and where I looked

- **A normalisation mismatch in `cst`** (a factor $2$ or $\tfrac12$ against the record's $c$) would change the constants in (A) and (B). Looked: `inner2`'s $\tfrac12$, `br`'s sign, and `killing_frame` returning the record's $2(n-2)$. The record's conventions list $\mathop{\mathrm{tr}}(v^2)=-2$, matching.
- **A slot mismatch in (B)** (weight on the third index where the record puts it on the second) would make `rowB_frame` a different relation. Looked: the record's display is $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}$, and `rowB_frame` weights `b`, the second slot of `Smat`. The swap in the proof is the correct one.
- **A hidden criticality hypothesis in `aW2`** would restrict L112 to critical points. Looked: its signature and the `IsWeyl` components it uses.
- **A frame-dependent conclusion** (true at `frameVec` only) would miss eigenbases inside repeated eigenvalues. Looked: `L112_at_frame` quantifies over every `EigenFrame`.
- **A clause of the block left untyped under "proved"**. Found one: the pair cap (G1).

## Findings

- **G1 (GAP).** The pair cap $\hat S_{ab}\le1/(n-2)$, attributed by the block to this lemma, is untyped at the operator though it follows from `brnorm_frame` and `L31_cap_unit`. The L112 row reads proved with no owed clause, and the statement row still says the cap does not follow.
- **O1.** The operator-level majorisation and L73 shadow are one instantiation of L112Doubly away and not typed as theorems.
- **O2.** `L112_op`'s conjunction omits the symmetry of $\hat S$, which `S_symm` proves at the same frame.
