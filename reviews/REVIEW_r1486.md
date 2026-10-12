# Review r1486: the second-order build's milestone 1 and the exponential to O(y³) in Lean, and the repair of r1485's gaps

Gate 2 review of commit 36b2eb1e, which adds `specFn_blk_bound` to [BlockValue.lean](../lean/HamiltonsCubic/Base/BlockValue.lean) and derives `specFn_blk` from it, adds [SecondOrder.lean](../lean/HamiltonsCubic/Base/SecondOrder.lean) (`schur_add_op`, `schur_smul_op`, `hsSq_add_le`, `hsSq_smul`, `specFn_blk_family`, `exp_sub_quadratic_isBigO`), and repairs [r1485](REVIEW_r1485.md)'s gaps D-a, D-b and D-c. One reviewer. Analysis-only rule inherited: the only compute was the module build (8770 jobs, all replayed from cache, no error) and `#print axioms` on a scratch file under `/private/tmp`, since deleted.

| item | claim | verdict |
| --- | --- | --- |
| A | `specFn_blk_bound`'s explicit threshold $t(C+1)\le\gamma/2$ is correct, `specFn_blk` states what it stated before, and `specFn_blk_family`'s $C=2\lVert H_{blk}\rVert^2+2\lVert H_{2,blk}\rVert^2$ bounds $\lVert(H+tH_2)_{blk}\rVert^2$ for $0\le t\le1$ | CONFIRMED |
| B | `exp_sub_quadratic_isBigO` states $\exp y-(1+y+\tfrac12y^2)=O(\lVert y\rVert^3)$ at $0$ in $E\to_L E$ and proves it soundly | CONFIRMED |
| C | route-a.md's codimension edit, row 17 against lean/INDEX.md and lean_debts.py, `admissible_opB` | CONFIRMED WITH GAP |
| D | every new or changed theorem rests on `propext`, `Classical.choice`, `Quot.sound` only | CONFIRMED |
| E | the second-order plan's Proved marks, SecondOrder.lean's docstring, punctuation | CONFIRMED |

**Summary: the Lean is correct and kernel-checked, and the codimension repair is right where it was made but incomplete: route-a.md line 73 keeps the heading "THE CONE IS MOST OF THE TANGENT SPACE" that line 93 calls false, and results.md line 1085, L17Statement.lean lines 204 to 211 and L17.lean line 15 still state $\operatorname{codim}\{F=0\}=186$ or "about 89% of directions". CONFIRMED WITH GAP.**

## A. The block value with an explicit threshold

- **The threshold.** `specFn_blk_bound` ([BlockValue.lean](../lean/HamiltonsCubic/Base/BlockValue.lean) line 150) takes $\gamma>0$ below every nonzero $\lvert\lambda_i\rvert$, $C\ge\lVert H_{blk}\rVert_{HS}^2$, and $0\le t$ with $t(C+1)\le\gamma/2$. The proof uses $C$ only in `hHb`, $\lvert\langle H_{blk}w,w\rangle\rvert\le(C+1)\lVert w\rVert^2$, obtained from `abs_inner_le_hs` ($\le(\lVert H_{blk}\rVert_{HS}^2+1)\lVert w\rVert^2$, valid since $\lVert X\rVert_{op}\le\sqrt{\lVert X\rVert_{HS}^2}\le\lVert X\rVert_{HS}^2+1$) and $\lVert H_{blk}\rVert_{HS}^2\le C$. Since $H_{blk}$ preserves each eigenspace of $u$, every eigenvalue of $u+tH_{blk}$ on a $\lambda\ne0$ block lies within $t(C+1)\le\gamma/2<\lvert\lambda\rvert$ of $\lambda$ and keeps its sign, which is all the negative part sees. The kernel block is $tP_0HP_0$, handled by homogeneity. **Correct**, and $C\ge0$ is automatic from `hsSq_nonneg`, so the hypothesis cannot be met vacuously.
- **`specFn_blk` is unchanged.** Its signature (line 313) is character for character the removed one: the same explicit arguments `g hpos hneg hhom hH`, the same `∃ t₀ > 0, ∀ t, 0 ≤ t → t ≤ t₀ → ∀ hW, ...` conclusion. The body takes `exists_gap`, sets $t_0=\gamma/(2(\lVert H_{blk}\rVert^2+1))$ as before, and calls `specFn_blk_bound` at $C=\lVert H_{blk}\rVert^2$ (`le_rfl`). Its downstream users (NegPartDeriv, L17Deriv, L17Phi, L17Converse) rebuild without change.
- **The family bound.** `specFn_blk_family` (SecondOrder.lean line 61) sets $t_0=\min(1,\gamma/(2(C+1)))$. By `schur_add_op` and `schur_smul_op`, $(H+tH_2)_{blk}=H_{blk}+tH_{2,blk}$, then `hsSq_add_le` and `hsSq_smul` give $\lVert(H+tH_2)_{blk}\rVert^2\le2\lVert H_{blk}\rVert^2+2t^2\lVert H_{2,blk}\rVert^2\le C$ for $t^2\le1$. `hsSq_add_le` is $\lVert a+b\rVert^2\le2\lVert a\rVert^2+2\lVert b\rVert^2$ columnwise, correct. The symmetry of $H+tH_2$ enters as a hypothesis per $t$, which a symmetric pair meets. **Valid for $0\le t\le1$**, and the `min 1` enforces that range.

## B. The exponential to second order

- **Statement.** `(fun y : E →L[ℝ] E => NormedSpace.exp y - (1 + y + (1/2 : ℝ) • (y * y))) =O[𝓝 0] fun y => ‖y‖ ^ 3`, with `NormedSpace.exp` Mathlib's exponential of the Banach algebra $E\to_L E$ (complete, $E$ finite-dimensional). That is $e^y=1+y+\tfrac12y^2+O(\lVert y\rVert^3)$ at $0$, the expansion milestone 3 needs.
- **Proof.** Mathlib's `hasFPowerSeriesAt_exp_zero_of_radius_pos` (infinite radius by `expSeries_radius_eq_top`) and `HasFPowerSeriesAt.isBigO_sub_partialSum_pow 3` give $\exp y-\sum_{k<3}\tfrac1{k!}y^k=O(\lVert y\rVert^3)$, and the `simp` step identifies the partial sum with $1+y+\tfrac12y\,y$. No local definition of `exp` intervenes. **Sound.**

## C. The r1485 repairs

- **The mathematics of $\le186$.** $u$ is nonzero only on the three self-dual bivectors of the $\mathbb{CP}^2$ factor, so at $n=12$ $\dim\ker u=66-3=63$, and the anti-self-dual span $A$ ($\dim3$) lies in $\ker u$. The conditions $\Pi_{ASD}H\Pi_{\ker u}=0$ are the $3\times63$ entries of the $A$-to-$\ker u$ block, of which the $A\times A$ corner is symmetric for symmetric $H$, so $3\cdot60+6=186$ linear functionals (r476 line 73 counts the same way). The codimension of their common kernel inside any subspace, $\mathcal W_{12}\cap T_uS$ included, is at most their number, and equality needs their independence on that subspace. $\dim\mathcal W_{12}=12\cdot13\cdot14\cdot9/12=1638$, so $\dim T_uS=1637$ and $\dim\{F=0\}\ge1451$. **Route-a.md line 93's new text is correct**, and "proper subspace" still holds because `Wb_F_pos` (and the kink witness two paragraphs below it) gives $F>0$ at $n=12$. **The removal of "about 89% of directions" from line 73 is right**: a proper subspace is measure zero among directions.
- **Gap C-1, route-a.md line 73 still contradicts line 93.** The callout keeps its bold heading **"AND THE CONE IS MOST OF THE TANGENT SPACE."**, and line 93 ends *"The readings "about 89% of directions" and "most of the tangent space" are both false."* The commit removed the first reading from line 73 and left the second.
- **Gap C-2, the downstream copies of the old claim were not swept.**
  - [results.md](../results.md) line 1085, Lemma L17's canonical text: "of codimension $186$ at $n=12$" and "the dimension ratio $1451/1637$", an equality.
  - [L17Statement.lean](../lean/HamiltonsCubic/Results/L17Statement.lean) lines 204 to 206, the section docstring: "The record's correction: `codim {F = 0} = 186` at `n = 12`, so `{F = 0}` holds `1451` of `T_uS`'s `1637` dimensions". Lines 209 to 210, `equality_set_dimensions`'s docstring: "`codim {F=0} = 186`, so `dim {F=0} = 1451`". The theorem proves only the arithmetic $1637-186=1451$, which stays true, and lean/INDEX.md line 479 cites it for the owed count.
  - [L17.lean](../lean/HamiltonsCubic/Results/L17.lean) line 15: "the truth is a subspace holding about `89%` of directions", the reading route-a.md line 93 calls false and this commit removed from line 73.
  - [lean/INDEX.md](../lean/INDEX.md) line 479, milder: "the record's own count at $n=12$ is $1451$ of $1637$, about $88.6\%$" reads as the subspace's dimension, where the same row's owed item now gives only a lower bound.
- **Row 17 and the coverage records now agree.** [INDEX-results.md](../findings/INDEX-results.md) line 32 reads **Lean: partial**, "the lemma is proved ... the dimension count of $\{F=0\}$, the one claim left, as owed". The [L17] row of lean/INDEX.md (line 479) is **partial**, the L17 (statement) row (line 480) **proved**, and [lean_debts.py](../scripts/misc/lean_debts.py) lines 346 to 356 clear a number only on a proved non-statement row, so [plan-lean.md](../plan-lean.md) line 75 lists L17 as partial. All three say the same thing. Row 17's "of codimension at most $186$" matches the owed item's $\le186$. **r1485 D-b repaired, and D-a repaired in those two rows.**
- **`admissible_opB`** ([L17Converse.lean](../lean/HamiltonsCubic/Results/L17Converse.lean) line 199): for $n\ge4$, `IsWeyl2 H` and `innerOp2 H (u2 hn) = 0` give `Admissible (opB H)`. Its three fields are exactly the three facts `Wb_F_pos` derived inline before: `opB_isSymmetric` from self-adjointness, `alt4_opB_eq_zero` from Bianchi, and tangency through `opB_u2` and `innerOp2_eq_trace`, the same pairing `L17`'s `hT` uses. `Wb_F_pos` now takes its three facts from it and still builds. The `Admissible` docstring (L17Cone.lean line 176) now points at a named lemma. **Correct. r1485 D-c repaired.**

## D. Axioms

- `#print axioms` on `specFn_blk_bound`, `specFn_blk`, `specFn_blk_family`, `exp_sub_quadratic_isBigO`, `schur_add_op`, `schur_smul_op`, `hsSq_add_le`, `hsSq_smul`, `admissible_opB` and `Wb_F_pos`: all ten report `[propext, Classical.choice, Quot.sound]`. No `sorryAx`, no `Lean.ofReduceBool`. The scratch file is deleted.

## E. Record accuracy

- **Plan milestone 1** ([second-order plan](2026-09-26-lean-second-order-plan.md) line 9) is marked **Proved** as `specFn_blk_family` on `specFn_blk_bound`. The theorem's left side $u+t(H+tH_2)_{blk}$ is the plan's $u+tB+t^2B_2$ with $B=H_{blk}$, $B_2=H_{2,blk}$, by `schur_add_op`, and its right side's multipliers see only the diagonal blocks, so they agree with the plan's $P_\lambda(B+tB_2)P_\lambda$ and $P_0(B+tB_2)P_0$. Accurate. *A precision remark, not a gap*: the plan's "the same bound holds for the family" is realised with $C=2\lVert B\rVert^2+2\lVert B_2\rVert^2$ in place of $\lVert X\rVert^2$ and $t_0$ capped at $1$.
- **Plan milestone 3** (line 11) marks only the exponential's expansion as proved, which is what `exp_sub_quadratic_isBigO` is. Accurate.
- **SecondOrder.lean's module docstring** names each declaration and says what milestone 1 and milestone 3's first step state, correctly. `hsSq_add_le` and `hsSq_smul` are listed without a description of their content, which is minor.
- **Punctuation.** No em dash in any added line. No backtick inside link text. The semicolons in SecondOrder.lean lines 10 and 13 separate items of a bulleted list whose items carry commas, the use the rule keeps. The commit's `Searched:` trailer joins clauses with an ASCII `--` again, which cannot be amended and is noted only.
- **Indexing, noted.** SecondOrder.lean is reached from the plan and from HamiltonsCubic.lean and has no row in lean/INDEX.md, like the other Base files of an unfinished build.

## Repairs owed

1. Route-a.md line 73: replace the heading "AND THE CONE IS MOST OF THE TANGENT SPACE" with one that states the dimension bound without the "most" reading.
2. Results.md line 1085: "of codimension at most $186$", with the dimension ratio read as a lower bound.
3. L17Statement.lean lines 204 to 210: say $\le186$ and $\dim\ge1451$ in both docstrings, the arithmetic theorem unchanged.
4. L17.lean line 15: drop "about 89% of directions" in favour of the dimension statement.
5. lean/INDEX.md line 479: "at least $1451$ of $1637$".
