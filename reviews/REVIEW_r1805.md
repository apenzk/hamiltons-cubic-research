# REVIEW r1805: statement fidelity of ItemFour.lean and normSq2_Q_pair against Lemma L222 items 2 and 4

**Verdict: CONFIRMED WITH OBSERVATIONS.** `LG_Dminus` in [ItemFour.lean](../lean/HamiltonsCubic/Results/ItemFour.lean) (commit 79bac54f) states L222 item 4 on the parametrised odd part, with the record's $G_x$, the record's $Y$ and the record's product $\circ$, and it is strictly stronger than the record's formula (no sum hypothesis, and the whole product is pinned to $D^-_z$, which contains "the even part of $G\circ Y$ vanishes"). `normSq2_Q_pair` is item 2's last clause, squared. The observations concern bookkeeping: the record's provenance line is stale after this commit, and the INDEX's owed identification names only one of its two halves.

Footing: analysis only. The runs were one compile of ItemFour.lean (`lake env lean`, exit 0, no output) and `python3 scripts/misc/axiom_audit.py --only` on ItemFour.lean and on PairNorm.lean. No screen was run. The $n=5$ evaluation in section 4 is by hand, in exact integer arithmetic.

## The record, verbatim

- Preamble, [second-order.md:1591](../findings/second-order.md#L1591): "$D\in\mathcal D_n$ with sectional matrix $K$, and let $\sigma$ swap $j$ and $k$ with $D=D^++D^-$ its even and odd parts, the odd part having entries $K_{ja}=-K_{ka}$."
- Item 2, [second-order.md:1593](../findings/second-order.md#L1593): "$\nu\circ\nu=G_x$, the diagonal tensor with $K_{ja}=K_{ka}=x_a^2$, $K_{jk}=-\lVert x\rVert^2$, $K_{ab}=2x_ax_b$, and $\lVert G_x\rVert^2=3\lVert x\rVert^4$, so $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$."
- Item 4, [second-order.md:1595](../findings/second-order.md#L1595): "On the odd part, identified with $\{y:\sum y=0\}$, $L_{G_x}$ acts as $y\mapsto\tfrac12\lVert x\rVert^2y+x\langle x,y\rangle$."
- Proof of item 4, [second-order.md:1602](../findings/second-order.md#L1602): "With the diagonal product $(A\circ B)_{ab}=A_{ab}B_{ab}+\tfrac12\sum_c(A_{ac}B_{cb}+B_{ac}A_{cb})$ and $Y_{ja}=y_a$, $Y_{ka}=-y_a$: $(G\circ Y)_{ja}=x_a^2y_a+\tfrac12\big(\lVert x\rVert^2y_a+2x_a(\langle x,y\rangle-x_ay_a)\big)=\tfrac12\lVert x\rVert^2y_a+x_a\langle x,y\rangle$, and the even part of $G\circ Y$ vanishes."
- Item 3's odd clause fixes the $L$ convention, [second-order.md:1594](../findings/second-order.md#L1594): "$2L_{D^+}D^-=\theta D^-$", which the Lean carries as `Sjk_odd`'s $2\,D^+\circ D^-=\theta D^-$. So $L_AB=A\circ B$.

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | `foxProd2_coordOp`: $(a\odot\cdot)\circ(b\odot\cdot)=(a\odot b+\tfrac12(ab+ba))\odot\cdot$ at symmetric hollow weights, the record's diagonal product | CONFIRMED |
| 2 | `coordOp_congr_off`, `coordOp_sub` | CONFIRMED |
| 3 | `LG_Dminus` is L222 item 4 with the record's $G_x$, $Y$, $\circ$ and $L$ | CONFIRMED WITH OBSERVATIONS (O2, O3) |
| 4 | The owed identification of the odd part is stated honestly and nowhere claimed as proved | CONFIRMED WITH OBSERVATIONS (O2) |
| 5 | `normSq2_Q_pair` is item 2's last clause, and `Sjk_pin_uncond` uses it with an unchanged statement | CONFIRMED |
| 6 | [lean/INDEX.md:152](../lean/INDEX.md#L152), the L222 row: the ItemFour and `normSq2_Q_pair` sentences and the r1804 repairs O1, O4, O5, O6 | CONFIRMED WITH OBSERVATIONS (O2, O4) |
| 7 | Axiom audits: ItemFour 4/4, PairNorm 11/11, standard three | CONFIRMED |
| 8 | The record's provenance line agrees with the Lean after 79bac54f | REFUTED AS STATED (O1) |

**Summary:** the Lean is faithful and stronger than item 4, while the record's provenance line still says item 4 is owed and r1804 pending, and the owed identification should name both inclusions.

## 1. The objects match the record

- `coordOp a` ([I117Statements.lean:1360](../lean/HamiltonsCubic/Results/I117Statements.lean#L1360)) sends a skew $X$ to the skew part of $a\odot X$. On $\varphi_{pq}$ with $a$ symmetric this is $a_{pq}\varphi_{pq}$, so `coordOp K` is the diagonal tensor with sectional matrix $K$, off the diagonal of $K$.
- `Dminus j k y` ([DiagSquare.lean:91](../lean/HamiltonsCubic/Results/DiagSquare.lean#L91)) is $u\,v^{\mathsf T}+v\,u^{\mathsf T}$ with $u=e_j-e_k$ (`uj`) and $v$ = `vy j k y`, $y$ zeroed at $j,k$. Its entries are $(j,a)\mapsto y_a$, $(k,a)\mapsto-y_a$ and zero elsewhere: the record's $Y$.
- `Gy j k x` ([DiagSquare.lean:96](../lean/HamiltonsCubic/Results/DiagSquare.lean#L96)) is $u^{\odot2}(v^{\odot2})^{\mathsf T}+v^{\odot2}(u^{\odot2})^{\mathsf T}+\lVert v\rVert^2uu^{\mathsf T}+\lVert u\rVert^2vv^{\mathsf T}$ with $\lVert u\rVert^2=2$. Off the diagonal: $(j,a),(k,a)\mapsto x_a^2$, $(j,k)\mapsto\lVert x\rVert^2u_ju_k=-\lVert x\rVert^2$, $(a,b)\mapsto2x_ax_b$. These are item 2's entries verbatim. The diagonal differs from the record's hollow $K$, which the docstring says, and the proof of `LG_Dminus` replaces `Gy` by `offDiag (Gy …)` through `coordOp_offDiag` before invoking `foxProd2_coordOp`, whose hollowness hypothesis therefore holds.
- `foxProd2 X Y` ([FirstVariation.lean:57](../lean/HamiltonsCubic/Results/FirstVariation.lean#L57)) is $\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, so $X\circ X=Q(X)$. With `Qop2_coordOp`, $Q(a\odot\cdot)=(a\odot a+a\,a)\odot\cdot$, polarisation gives $(A\circ B)_{pq}=A_{pq}B_{pq}+\tfrac12\sum_c(A_{pc}B_{cq}+B_{pc}A_{cq})$. This is the record's product in item 4's proof, the factor $\tfrac12$ included, and `foxProd2_coordOp`'s identity `hW` is exactly that polarisation.
- The $L$ convention: the record's item 3 writes $2L_{D^+}D^-=\theta D^-$ where the Lean has $2\,D^+\circ D^-=\theta D^-$, so $L_{G_x}Y$ is `foxProd2 (coordOp (Gy j k x)) (coordOp (Dminus j k y))`. No factor of 2 is lost.

## 2. What LG_Dminus proves against what item 4 claims

- The conclusion is `coordOp (Dminus j k z)` with $z_i=\tfrac12\big(\sum_cv_c^2\big)(\mathrm{vy}\,y)_i+\big(\sum_cv_c(\mathrm{vy}\,y)_c\big)v_i$, $v$ = `vy j k x`. At $a\notin\{j,k\}$ that is $\tfrac12\lVert x\rVert^2y_a+\langle x,y\rangle x_a$, the record's formula.
- The equality is of whole operators, so it gives more than the $(j,a)$ entry the record computes. The $(k,a)$ entry is $-z_a$, and the $(j,k)$ and $(a,b)$ entries vanish. That is "the even part of $G\circ Y$ vanishes", and also that the odd part of $G\circ Y$ has the $D^-$ shape.
- No hypothesis beyond $j\ne k$. The record's preamble assumes $\sum x=0$ and the odd part carries $\sum y=0$. The Lean holds at every $x,y$, a strengthening. See O3 on what the sum hypotheses would add.
- "Identified with $\{y:\sum y=0\}$" is the part the Lean leaves open, and it says so (O2).

## 3. normSq2_Q_pair and Sjk_pin_uncond

- [PairNorm.lean](../lean/HamiltonsCubic/Results/PairNorm.lean) `normSq2_Q_pair`: at `IsWeyl2 ν` and `SignChar (setChar {j, k}) ν`, `normSq2 (Qop2 ν) = 3 / 4 * normSq2 ν ^ 2`. The hypotheses are the record's $\nu\in V_{jk}$. The record's $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$ is its square root, both sides being nonnegative.
- The norm is the record's: r1804 confirmed `normSq2_coordOp` as the unordered-pair convention, and the proof composes `Q_pair`, `normSq2_Gy` ($3\lVert x\rVert^4$) and `normSq2_nuX` ($2\lVert x\rVert^2$), giving $3\lVert x\rVert^4=\tfrac34(2\lVert x\rVert^2)^2$.
- `Sjk_pin_uncond`'s statement is byte-identical before and after the commit. Only its proof changed, from an inline `have hG` to a citation of `normSq2_Q_pair`. This closes r1804 O3.

## 4. A hand evaluation at n = 5

A hand evaluation, exact integer arithmetic, of an object satisfying `LG_Dminus`'s hypotheses. $n=5$, $j=0$, $k=1$, $a\in\{2,3,4\}$, $x=(1,-1,0)$, $y=(1,0,-1)$ on $\{2,3,4\}$ (both sum to zero, so the operators are Weyl by `Dminus_weyl` and the record's preamble holds). Then $\lVert x\rVert^2=2$, $\langle x,y\rangle=1$ and $z=\tfrac12\cdot2\cdot y+1\cdot x=(2,-1,-1)$, with $\sum z=0$.

Hollow $G$: $G_{02}=G_{03}=G_{12}=G_{13}=1$, $G_{04}=G_{14}=0$, $G_{01}=-2$, $G_{23}=-2$, $G_{24}=G_{34}=0$. $Y$: $Y_{02}=1$, $Y_{03}=0$, $Y_{04}=-1$, $Y_{12}=-1$, $Y_{13}=0$, $Y_{14}=1$, all other off-diagonal entries zero.

Using $(G\circ Y)_{pq}=G_{pq}Y_{pq}+\tfrac12\big(\sum_cG_{pc}Y_{cq}+\sum_cY_{pc}G_{cq}\big)$:

| Entry | $G_{pq}Y_{pq}$ | $\sum_cG_{pc}Y_{cq}$ | $\sum_cY_{pc}G_{cq}$ | Total | Lean $D^-_z$ |
|---|---|---|---|---|---|
| (0,2) | 1 | $G_{01}Y_{12}=2$ | 0 | 2 | $z_2=2$ |
| (0,3) | 0 | 0 | $Y_{02}G_{23}=-2$ | $-1$ | $z_3=-1$ |
| (0,4) | 0 | $G_{01}Y_{14}=-2$ | 0 | $-1$ | $z_4=-1$ |
| (1,2) | $-1$ | $G_{10}Y_{02}=-2$ | 0 | $-2$ | $-z_2=-2$ |
| (1,3) | 0 | 0 | $Y_{12}G_{23}=2$ | 1 | $-z_3=1$ |
| (1,4) | 0 | $G_{10}Y_{04}=2$ | 0 | 1 | $-z_4=1$ |
| (0,1) | 0 | $G_{02}Y_{21}=-1$ | $Y_{02}G_{21}=1$ | 0 | 0 |
| (2,3) | 0 | 0 | $Y_{20}G_{03}+Y_{21}G_{13}=0$ | 0 | 0 |
| (2,4) | 0 | $G_{20}Y_{04}+G_{21}Y_{14}=0$ | 0 | 0 | 0 |
| (3,4) | 0 | $G_{30}Y_{04}+G_{31}Y_{14}=0$ | 0 | 0 | 0 |

Every entry matches $D^-_z$, and the record's own $(j,a)$ formula gives the same three values. The record's eigen-structure also agrees: at $y=x$, $z=\tfrac32\lVert x\rVert^2x$, and at $y\perp x$, $z=\tfrac12\lVert x\rVert^2y$, which are `odd_action_on_x` and `odd_action_perp` of [L222Statement.lean](../lean/HamiltonsCubic/Results/L222Statement.lean).

## 5. The INDEX row

- "Item 4, PROVED on $\{D^-_y\}$" is accurately scoped. The three declarations are described as they are stated.
- `normSq2_Q_pair` is named as "item 2's last clause, r1804 O3": accurate.
- r1804 O1 (the crit_pair clause now reads "which item 2 (`Q_pair`) identifies with $G_x$"), O4 (ĝ matched to $G_x/\lVert G_x\rVert$ through `Q_pair`), O5 ("with item 2's norm proved rather than assumed") and O6 (the r1800 sentence moved after PairSquare's paragraph, the double space removed) are each repaired in the diff.
- "Gate 2 on PairNorm: r1804, CONFIRMED WITH OBSERVATIONS" matches r1804's verdict line.
- The Owed list: item 1's rotation invariance, item 4's identification, item 5's rotation action. Item 4's identification is owed and nowhere claimed as proved, in the row or in ItemFour's docstring. See O2 on its scope and O4 on r1804 O2.

## Observations

1. **The record's provenance line is stale after 79bac54f.** [second-order.md:1589](../findings/second-order.md#L1589) still reads "(Gate 2 [r1804](../reviews/REVIEW_r1804.md), pending)" and "The Lean owes item 1's rotation invariance, item 4 and item 5". r1804 has since returned CONFIRMED WITH OBSERVATIONS, and item 4 is now proved on the parametrised odd part. The fold should name `LG_Dminus` and scope it as the INDEX does, keeping the identification owed. This is the only claim of the brief that fails as stated, and it fails in the record's prose, which the commit did not touch.
2. **The owed identification has two halves, and the INDEX names one.** Item 4 acts "on the odd part, identified with $\{y:\sum y=0\}$", which needs both inclusions: every $D^-_y$ with $\sum y=0$ is a swap-odd Weyl operator of character $1$, and every such operator is some $D^-_y$. The row owes only the second. For the first, Weyl-ness is `Dminus_weyl` ([PairSquare.lean:308](../lean/HamiltonsCubic/Results/PairSquare.lean#L308)), and I found no declaration giving $\sigma\,D^-_y=-D^-_y$ under the swap frame change of [L222Swap.lean](../lean/HamiltonsCubic/Results/L222Swap.lean) (a grep over `lean/HamiltonsCubic` for `coordOp` with `swap`, `rotR`, `SignChar` or `hasChar` finds only PairSquare's rotation lemmas). The converse is true by hand: a swap-odd diagonal $K$ has $K_{jk}=K_{ab}=0$ and $K_{ka}=-K_{ja}$, and the zero row sum at $j$ gives $\sum y=0$. The owed item would read cleanly as "the swap-odd Weyl operators of character $1$ are exactly the $D^-_y$ with $\sum y=0$". The L224 row's owed link from $D^-=\tfrac12(D-\sigma D)$ to `coordOp (Dminus j k y)` is the same fact and could be cited.
3. **`LG_Dminus` drops both sum hypotheses, and the invariance of the odd part is left to the reader.** The map $y\mapsto\tfrac12\lVert x\rVert^2y+\langle x,y\rangle x$ preserves $\{\sum y=0\}$ only at $\sum x=0$, the record's preamble. The Lean states the formula at every $x,y$, which is stronger and correct, and a consumer wanting "$L_{G_x}$ is an endomorphism of the odd part" must supply $\sum z=\langle x,y\rangle\sum x=0$ separately. One line, no fidelity issue.
4. **r1804 O2 is deferred in the commit body only.** Dropping `hsum` from `normSq2_nuX` is a generality item, not a fidelity debt, so its absence from the Owed list is defensible. A reader of the row alone will not learn it was deferred.
5. **The docstrings agree with the statements.** ItemFour's module docstring says "with no condition on the sums" and "the converse … is owed", both accurate. The declaration docstring of `LG_Dminus` quotes the formula as proved.

## What would falsify each headline

- **`LG_Dminus` is item 4:** an entry of $G_x\circ D^-_y$, computed from the record's product formula, differing from $D^-_z$ at some $x,y$, or a convention mismatch, $L_A B=2A\circ B$ in the record, which item 3's $2L_{D^+}D^-=\theta D^-$ against `Sjk_odd` rules out. The $n=5$ table would show the first at the entries it covers.
- **`foxProd2_coordOp` is the record's product:** a definition of `foxProd2` other than the polarisation of $Q$ with $X\circ X=Q(X)$, or `Qop2_coordOp` computing $(A\circ A)_{pq}$ with a factor other than $A_{pq}^2+\sum_cA_{pc}A_{cq}$. Both were read at source.
- **`normSq2_Q_pair` is item 2's last clause:** `normSq2` on a scale other than the unordered-pair norm, which r1804's `normSq2_coordOp` check excludes.
- **The identification is honestly owed:** any sentence in the row, ItemFour's docstring or the commit body claiming the swap-odd part equals $\{D^-_y\}$ as proved. None does.
- **Axiom cleanliness:** a `sorry` or non-standard axiom in either audit. `axiom_audit.py --only ItemFour.lean` reports "4/4 clean -- resting on the standard three alone", and `--only PairNorm.lean` reports "11/11 clean -- resting on the standard three alone".
