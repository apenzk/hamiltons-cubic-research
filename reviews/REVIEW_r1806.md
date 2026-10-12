# REVIEW r1806: statement fidelity of OddPart.lean against Lemma L222 item 4 and Lemma L224 step 3

**Verdict: CONFIRMED WITH OBSERVATIONS.** [OddPart.lean](../lean/HamiltonsCubic/Results/OddPart.lean) (commits ce51ee2f and a2513dda) identifies the swap-odd Weyl operators of character $1$ with the record's $D^-_y$, $\sum y=0$, using the record's $\mathcal D_n$, the record's $\sigma$ and the record's sign convention $Y_{ja}=y_a$, $Y_{ka}=-y_a$. `LG_odd` is item 4 as stated, and `Q_odd_half` is the operator identity L224's step 3 needs, on exactly the operator `L224_cubic` writes. The observations concern the converse half of the identification, which is split across two files with one of its three facts unnamed, and bookkeeping in the L224 row.

Footing: analysis only. The one run was `python3 scripts/misc/axiom_audit.py --only OddPart.lean`, which builds the module and reported 9/9 declarations clean on the standard three. No screen was run. The $n=4$ object in section 5 is a hand evaluation in exact integer arithmetic.

## The record, verbatim

- L222 preamble, [second-order.md:1591](../findings/second-order.md#L1591): "$D\in\mathcal D_n$ with sectional matrix $K$, and let $\sigma$ swap $j$ and $k$ with $D=D^++D^-$ its even and odd parts, the odd part having entries $K_{ja}=-K_{ka}$."
- L222 item 4, [second-order.md:1595](../findings/second-order.md#L1595): "On the odd part, identified with $\{y:\sum y=0\}$, $L_{G_x}$ acts as $y\mapsto\tfrac12\lVert x\rVert^2y+x\langle x,y\rangle$."
- L222 proof of item 4, [second-order.md:1602](../findings/second-order.md#L1602): "With the diagonal product $(A\circ B)_{ab}=A_{ab}B_{ab}+\tfrac12\sum_c(A_{ac}B_{cb}+B_{ac}A_{cb})$ and $Y_{ja}=y_a$, $Y_{ka}=-y_a$: ..."
- L224 step 1, [second-order.md:1616](../findings/second-order.md#L1616): "a diagonal $D$ splits as $D=E+D^-_y$ with $E$ swap-even and $D^-_y$ the tensor with $K_{ja}=y_a$, $K_{ka}=-y_a$ and no other entry, which lies in $\mathcal D_n$ exactly when $\sum y=0$"
- L224 step 3, [second-order.md:1618](../findings/second-order.md#L1618): "What remains is $P(E)+3T(E,D^-_y,D^-_y)+3T(E,\nu_x,\nu_x)$, and total symmetry with step 2 gives $$P(W)=P(E)+3\langle E,G_y\rangle+3\langle E,G_x\rangle$$"

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | `coordOp_weight_eq`: equal coordinate operators have equal symmetric weights off the diagonal | CONFIRMED |
| 2 | `rotR_swap_coordOp`: $\mathrm{rotR}(\mathrm{swapM}\,j\,k)(a\odot\cdot)=(a\circ(\sigma\times\sigma))\odot\cdot$, the record's $\sigma$ | CONFIRMED |
| 3 | `odd_eq_Dminus`: a swap-odd Weyl operator of character $1$ is $D^-_y$, $y$ zero at $j,k$, $\sum y=0$ | CONFIRMED WITH OBSERVATIONS (O2) |
| 4 | `Dminus_swap_odd`, and with claim 3 the set equality "identified with $\{y:\sum y=0\}$" | CONFIRMED WITH OBSERVATIONS (O1) |
| 5 | `LG_odd`: item 4 as stated on every such $V$, with the record's $z$ and the record's $y$ | CONFIRMED |
| 6 | `LG_sum`: $\sum z=\tfrac12\lVert x\rVert^2\sum y+\langle x,y\rangle\sum x$ | CONFIRMED |
| 7 | `odd_half_eq_Dminus`, `Q_odd_half`: L224's $D^-=\tfrac12(D-\sigma D)$ is $D^-_y$ with $\sum y=0$ and $D^-\circ D^-=G_y$ | CONFIRMED |
| 8 | [lean/INDEX.md:152](../lean/INDEX.md#L152), the L222 row's OddPart sentences | CONFIRMED WITH OBSERVATIONS (O1, O2) |
| 9 | [lean/INDEX.md:155](../lean/INDEX.md#L155), the L224 row's rewritten owed clause, still naming the pairings in `L224_cubic`'s statement | CONFIRMED WITH OBSERVATIONS (O3, O4) |
| 10 | Axiom audit of OddPart.lean | CONFIRMED (9/9, standard three) |

**Summary:** every declaration states what the record says on the record's objects, the sign conventions agree, and the gaps are the unnamed character-$1$ half of the converse and a stale step-1 owed clause in the L224 row.

## 1. The objects are the record's

- **Character $1$ is $\mathcal D_n$.** `SignChar (fun _ => 1) V` says every sign flip fixes $V$. [L120Ident.lean](../lean/HamiltonsCubic/Results/L120Ident.lean)'s `trivial_block_iff` turns this, at Weyl $V$, into $V=$ `restrict (diagOp_isWeyl hw)` for an `IsWeight w` (symmetric, hollow, zero row sums, [Families.lean:153](../lean/HamiltonsCubic/Base/Families.lean#L153)), and `coordOp_eq_restrict` rewrites that as `coordOp w`, the operator $\varphi_{ab}\mapsto w_{ab}\varphi_{ab}$. So $w$ is the record's sectional matrix $K$ and the zero row sums are the Weyl condition on a diagonal tensor. This is the record's $\mathcal D_n$.
- **rotR (swapM j k) is the record's $\sigma$.** `swapM` is the permutation matrix of $(j\,k)$, symmetric and involutive (`swapM_T`, `swapM_sq`), and `rotR_swap_coordOp` proves its action on a coordinate operator is $K_{pq}\mapsto K_{\sigma p,\sigma q}$, which is "let $\sigma$ swap $j$ and $k$" on the sectional matrix. The direction of the conjugation in `rotR` is immaterial for an involution.
- **$D^-_y$ and the sign convention.** [DiagSquare.lean:91](../lean/HamiltonsCubic/Results/DiagSquare.lean#L91) defines `Dminus j k y` $=u v^{\mathsf T}+v u^{\mathsf T}$ with $u=e_j-e_k$ and $v=y$ off $\{j,k\}$. Its $(j,a)$ entry is $1\cdot y_a=y_a$ and its $(k,a)$ entry is $-y_a$, every other off-diagonal entry zero. This is the record's "$Y_{ja}=y_a$, $Y_{ka}=-y_a$" and L224's "$K_{ja}=y_a$, $K_{ka}=-y_a$ and no other entry".
- **Which of $K_{ja}$, $K_{ka}$ is $y_a$.** In `odd_eq_Dminus`'s proof $y_a=w_{ja}=K_{ja}$ off $\{j,k\}$, and `hka` gives $K_{ka}=-K_{ja}=-y_a$. So $y_a=K_{ja}$, matching $Y_{ja}=y_a$, and the preamble's "$K_{ja}=-K_{ka}$" is `hka`. The sign is the record's, with no flip between the identification and the item-4 formula.

## 2. The identification (claims 1 to 4)

- `coordOp_weight_eq` evaluates both operators at $\varphi_{qp}$ and reads the $(p,q)$ entry: $a_{pq}$ on one side, $b_{pq}$ on the other, at $p\ne q$. Sound and exactly as described.
- `odd_eq_Dminus` derives, from $\sigma V=-V$ and `coordOp_weight_eq`, that $K_{\sigma p,\sigma q}=-K_{pq}$ off the diagonal. At $(j,k)$ this gives $K_{jk}=-K_{jk}=0$, at $(j,a)$ it gives $K_{ka}=-K_{ja}$, and at $(a,b)$ with both outside $\{j,k\}$ it gives $K_{ab}=0$. The row sum at $j$ is then $\sum_ay_a+K_{jk}=\sum y$, so $\sum y=0$. This is the record's odd part in full: the preamble lists only "$K_{ja}=-K_{ka}$", and the Lean also derives the other two vanishings the record leaves implicit.
- `Dminus_swap_odd` holds at every $y$, with no sum hypothesis: $u\circ\sigma=-u$ and $v\circ\sigma=v$, so the weight is negated.
- **Set equality.** "Identified with $\{y:\sum y=0\}$" asks for (a) every odd $V$ to be some $D^-_y$ with $\sum y=0$, and (b) every $D^-_y$ with $\sum y=0$, $y$ zero at $j,k$, to be a Weyl operator of character $1$ negated by $\sigma$. `odd_eq_Dminus` is (a) in full. (b) is three facts: Weyl is `Dminus_weyl` in [PairSquare.lean:308](../lean/HamiltonsCubic/Results/PairSquare.lean#L308), oddness is `Dminus_swap_odd`, and character $1$ is not a named theorem anywhere (O1). Injectivity of $y\mapsto D^-_y$ on $y$ zero at $j,k$ follows from `coordOp_weight_eq` at $(j,a)$, and is likewise unnamed.

## 3. Item 4 (claims 5 and 6)

- `LG_odd`'s product is `foxProd2 (coordOp (Gy j k x)) V`. The record's convention is $L_AB=A\circ B$ (r1805 fixed it from item 3's "$2L_{D^+}D^-=\theta D^-$"), and `Gy`'s off-diagonal entries are item 2's $G_x$: $K_{ja}=K_{ka}=x_a^2$, $K_{jk}=-\lVert x\rVert^2$, $K_{ab}=2x_ax_b$ (`Gy_ja`, `Gy_ka`, `Gy_jk`, `Gy_ab`).
- `LG_odd`'s $z_i=\tfrac12\big(\sum_cx_c^2\big)y_i+\big(\sum_cx_cy_c\big)x_i$ with $x$ read off $\{j,k\}$ is the record's "$y\mapsto\tfrac12\lVert x\rVert^2y+x\langle x,y\rangle$" term for term, $\lVert x\rVert^2$ and $\langle x,y\rangle$ being sums over $a\notin\{j,k\}$ as the preamble's "Sums over $a$ run over $a\notin\{j,k\}$" requires.
- The $y$ in `LG_odd` is the same existential $y$ as `odd_eq_Dminus`'s and is exported with $V=$ `coordOp (Dminus j k y)`, so the item-4 formula is stated in the coordinate the identification assigns. `LG_odd` carries no $\sum x=0$ and no $n\ge4$: a strengthening.
- `LG_sum` is a two-step linearity identity and says what it claims. At $\sum x=0$ it gives $\sum z=0$, so item 4's map sends the plane $\{\sum y=0\}$ to itself, which the record's "acts as" presupposes.

## 4. L224's step 3 link (claim 7)

- `odd_half_eq_Dminus` takes the operator $\tfrac12(D-\mathrm{rotR}(\mathrm{swapM}\,j\,k)\,D)$ syntactically identical to `L224_cubic`'s second and third `Tsym` arguments ([L224Cubic.lean:55](../lean/HamiltonsCubic/Results/L224Cubic.lean#L55)), under `L224_cubic`'s own hypotheses on $D$ (Weyl, character $1$). It checks Weyl (`rotR_isWeyl2`), character $1$ (`signChar_rotR_swap`, `signChar_add`, `signChar_smul`) and oddness ($\sigma^2=1$ through `rotR_comp`, `swapM_sq`, `rotR_one`), then applies `odd_eq_Dminus`. Sound.
- `Q_odd_half` adds $Q$ of that operator equals `coordOp (Gy j k y)` by `Q_Dminus`. With `Qop2` the record's $X\circ X$ (the r1796 reading), this is $D^-\circ D^-=G_y$ on the very operator `L224_cubic_pair` pairs against $E$. Rewriting `L224_cubic_pair`'s $\langle E,D^-\circ D^-\rangle$ with it gives the record's $\langle E,G_y\rangle$ in one step. Likewise `Q_pair` ([PairIdent.lean:115](../lean/HamiltonsCubic/Results/PairIdent.lean#L115)) takes `L224_cubic`'s $\nu$ hypotheses verbatim (Weyl, `SignChar (setChar {j, k})`) and gives $\nu\circ\nu=G_c$.

## 5. A concrete object (hand evaluation, exact, labelled as such)

Take $n=4$, $j=0$, $k=1$, and the weight $w$ with $w_{02}=w_{20}=1$, $w_{03}=w_{30}=-1$, $w_{12}=w_{21}=-1$, $w_{13}=w_{31}=1$, every other entry $0$.

- `IsWeight w`: symmetric and hollow by construction. Row sums: row 0 is $0+0+1-1=0$, row 1 is $0+0-1+1=0$, row 2 is $1-1+0+0=0$, row 3 is $-1+1+0+0=0$.
- So $V=$ `coordOp w` is Weyl with character $1$ (`coordOp_eq_restrict`, `isWeyl2_restrict`, `trivial_block_iff`).
- $\sigma V$ has weight $w'_{pq}=w_{\sigma p,\sigma q}$: $w'_{02}=w_{12}=-1$, $w'_{03}=w_{13}=1$, $w'_{12}=w_{02}=1$, $w'_{13}=w_{03}=-1$, $w'_{01}=w_{10}=0$, $w'_{23}=w_{23}=0$. So $w'=-w$ off the diagonal and $\sigma V=-V$.
- The proof's $y$ is $y_a=w_{0a}$ off $\{0,1\}$: $y=(0,0,1,-1)$, $\sum y=0$. With $u=(1,-1,0,0)$ and $v=(0,0,1,-1)$, `Dminus 0 1 y` has $(0,2)$ entry $1$, $(1,2)$ entry $-1$, $(0,3)$ entry $-1$, $(1,3)$ entry $1$, and $0$ at $(0,1)$ and $(2,3)$: equal to $w$ off the diagonal.
- Item 4 at $x=(0,0,1,-1)$: $\lVert x\rVert^2=2$, $\langle x,y\rangle=2$, so $z=y+2x=(0,0,3,-3)$, which is $3y=\tfrac32\lVert x\rVert^2y$, agreeing with L222Statement's `odd_action_on_x` eigenvalue. $\sum z=0$, as `LG_sum` gives at $\sum x=0$.

## 6. The INDEX rows (claims 8 and 9)

- L222 row, [lean/INDEX.md:152](../lean/INDEX.md#L152): each OddPart sentence matches its declaration. "$y_a=K_{ja}$ off $\{j,k\}$" is true of the proof and follows from the statement through `coordOp_weight_eq`, but it is absent from `odd_eq_Dminus`'s statement (O2). The row lists `Dminus_swap_odd` as "conversely", which is one of the converse's three facts (O1). Item 4 has left the owed list, correctly: `LG_odd` is item 4 on every odd $V$.
- L224 row, [lean/INDEX.md:155](../lean/INDEX.md#L155): the rewritten clause reads "the pairings $\langle E,D^-\circ D^-\rangle=\langle E,G_y\rangle$ and $\langle E,\nu\circ\nu\rangle=\langle E,G_x\rangle$ written into `L224_cubic`, whose two operator identities are now proved". This is accurate: no theorem yet states `L224_cubic` with $G_y$, $G_x$ in place of the products, and the two identities it cites exist with matching hypotheses. The owed list still names what remains.
- The same row's first owed item, "step 1's coordinates ($D^-_y$ and $\nu_x$ explicitly), its norm identities", now overstates the gap (O3). The row's file column omits OddPart.lean and PairIdent.lean though the owed clause cites both (O4).

## 7. Axiom audit

`python3 scripts/misc/axiom_audit.py --only OddPart.lean`: "auditing 9 declarations across 1 files", "9/9 clean -- resting on the standard three alone", exit 0. The nine are the eight declarations under review plus the helper `swapM_entry'`: `coordOp_weight_eq`, `swapM_entry'`, `rotR_swap_coordOp`, `odd_eq_Dminus`, `Dminus_swap_odd`, `LG_odd`, `LG_sum`, `odd_half_eq_Dminus`, `Q_odd_half`. The audit builds the module, so the file compiles at HEAD.

## Observations

- **O1. The converse half of "identified with" is split and partly unnamed.** $D^-_y$ with $\sum y=0$ lying in the odd part needs Weyl (`Dminus_weyl`, PairSquare.lean), oddness (`Dminus_swap_odd`) and character $1$. The last has no theorem: the `IsWeight (Dminus j k x)` fact that would give it is a local `have` inside `Dminus_weyl`. It is one line from `trivial_block_iff.mpr`, so this is bookkeeping rather than a gap in the mathematics, but the L222 record line's "the identification both ways, `odd_eq_Dminus` and `Dminus_swap_odd`" names two of three facts. Repair: export `Dminus_isWeight` and state a `Dminus_mem_odd` giving all three, or cite `Dminus_weyl` and the character in the row.
- **O2. $y_a=K_{ja}$ is proved but not stated.** `odd_eq_Dminus` exports an existential $y$. The formula lives in the proof. It is recoverable, since `coordOp_weight_eq` at $(j,a)$ pins $y$, so no content is lost, but the INDEX sentence reads as if the statement carried it.
- **O3. The L224 row's step-1 owed item is stale in the conservative direction.** `odd_half_eq_Dminus` gives $D^-=D^-_y$ explicitly, `pair_eq_nuX` gives $\nu=\nu_x$, and `normSq2_Dminus`, `normSq2_nuX` give $\lVert D^-_y\rVert^2=2\lVert y\rVert^2$ and $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$. What remains of step 1 is the splitting $D=E+D^-$ as a statement with $E$ swap-even (trivial) and the orthogonality giving $\lVert W\rVert^2=\lVert E\rVert^2+2s$. The row understates the Lean, which is the safe direction.
- **O4. File column.** The L224 row's file column lists L224Statement, L224Cubic, DiagSquare and PairSquare. OddPart.lean and PairIdent.lean are cited in its owed clause as holding proved identities for this lemma and belong in the column.
- **O5. Strengthenings.** `LG_odd` carries no $\sum x=0$ and no $n\ge4$, `Dminus_swap_odd` no $\sum y=0$, and `odd_eq_Dminus` no $n\ge4$. Each is harmless and each is stronger than the record.

## What would falsify each headline

- *The objects are the record's*: a Weyl operator of character $1$ that is not a coordinate operator with a symmetric hollow zero-row-sum weight, which would contradict `trivial_block_iff`, or `rotR (swapM j k)` acting on weights by something other than $K_{pq}\mapsto K_{\sigma p,\sigma q}$, which `rotR_swap_coordOp` excludes.
- *The sign convention agrees*: `Dminus j k y` having $-y_a$ at $(j,a)$. Its definition gives $+y_a$ there, by the evaluation in section 1 and section 5.
- *The identification is a set equality*: a $y$ zero at $j,k$ with $\sum y=0$ whose `coordOp (Dminus j k y)` fails character $1$. Its weight satisfies `IsWeight` (proved inside `Dminus_weyl`), so `trivial_block_iff` would have to fail.
- *`Q_odd_half` is the operator `L224_cubic` uses*: a difference between `(1 / 2 : ℝ) • (D - rotR (swapM j k) D)` in the two files. They are character-for-character identical.
- *The audit result*: a `sorryAx` or `Lean.ofReduceBool` under any of the nine, which the audit run reported absent.
