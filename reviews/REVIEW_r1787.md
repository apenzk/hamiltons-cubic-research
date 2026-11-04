# REVIEW r1787: L214's cap theorems (80219868) and L222Op.lean (26b700a6)

Gate 2 reader for the Lean layer, statement fidelity. Analysis only: the compute was `python3 scripts/misc/axiom_audit.py --only L222Op.lean` (11/11 clean on the standard three) and one scratch file under the session scratchpad (R1787.lean, compiled with `lake env lean`, exit 0), holding `#print axioms` and two witnesses, listed in section 4. No numerics, no screens.

## Verdicts

| Claim | Verdict | Note |
|---|---|---|
| `L214_frame_cap`'s cap hypothesis is the record's "$L_W\le\tfrac\theta2$ on $W^\perp$" | CONFIRMED | $\langle W\circ X,X\rangle\le\tfrac\theta2\lVert X\rVert^2$ on Weyl $X\perp W$, with `foxProd2` the record's $\circ$ and $W^\perp$ taken inside $\mathcal W_n$ as in L24 (A.1) |
| `L214_frame_cap`'s second conjunct is the record's "equivalently" form, `piF_t_range` states $t\in[0,1]$ | CONFIRMED WITH OBSERVATIONS | both conclusions are proved, the equivalence itself as a one-way derivation (O2) |
| `L214_op_cap`, `L214_op_max` derived from it, `Tsym_eq_fox`, `piF_unique` | CONFIRMED | `L214_op_max` is exactly `L214_op_cap` fed `Tsym_cap` |
| lean/INDEX.md:199 "Every clause of L214's statement has a covering theorem in every frame at the record's hypotheses." | CONFIRMED WITH OBSERVATIONS | eleven clauses, each covered (table in A.3). r1786's refutation is answered |
| `InSjk`, `Sjk_mul` against item 1's subalgebra clause | CONFIRMED WITH OBSERVATIONS | `InSjk` is a superspace of $\mathcal S_{jk}$ (no Weyl condition), and its closure gives the record's clause through `isWeyl2_foxProd2`, a composition nowhere stated (O4) |
| `Sjk_crit` against item 3's two equations | CONFIRMED | $Q(D)+Q(\nu)=\theta D$ and $2D\circ\nu=\theta\nu$ at weaker hypotheses than the record's |
| `Sjk_pin` against item 3's pinning | CONFIRMED WITH OBSERVATIONS | first clause unconditional, and the $\theta/\sqrt3$ clause takes item 2's norm as a hypothesis, which is the record's normalisation, so the pinning inherits item 2's debt (O5) |
| lean/INDEX.md:151 L222 row: **partial** and the owed list | status CONFIRMED, owed list REFUTED AS STATED | items 5 and 6 are neither proved at the operator nor in the owed list (O6) |

**Summary**: 80219868 closes r1786 O1 and O2 exactly, and the L214 completeness sentence now survives. 26b700a6 types item 1's subalgebra clause and item 3 faithfully, with the pinning conditional on item 2. The L222 row's owed list omits items 5 and 6, and the record's own L222 note repeats the omission.

## A. Commit 80219868, Lemma L214

**The record** ([findings/second-order.md:1354-1357](../findings/second-order.md)), verbatim:

> **Fix any orthonormal frame $F$ of $\mathbb R^n$ and split a unit critical point as $W=D+N$, where $D=\pi_FW$ is its coordinate-diagonal part in $F$ and $N=W-D$, with $t=t_F=\lVert D\rVert^2\in[0,1]$ and $a=\langle L_DN,N\rangle$. Then**
> $$\theta\,t=P(D)+a,\qquad\theta\,(1-t)=2a+P(N),$$
> **and if in addition $L_W\le\tfrac\theta2$ on $W^\perp$, which [Lemma L24] gives at every GLOBAL maximiser, and at a local one with $\theta>0$, then**
> $$a\ \ge\ \tfrac\theta2\,t(1-t),\qquad\text{equivalently}\qquad P(D)\ \le\ \tfrac\theta2\,t(1+t).$$

### A.1 The cap hypothesis

`L214_frame_cap` ([L214Frame.lean:206-211](../lean/HamiltonsCubic/Results/L214Frame.lean)) takes `IsWeyl2 W`, `normSq2 W = 1`, `Qop2 W = θ • W`, and

`hcap : ∀ X, IsWeyl2 X → innerOp2 W X = 0 → innerOp2 (foxProd2 W X) X ≤ θ / 2 * normSq2 X`.

- **$L_W$.** The record's $L_W=W\circ(\cdot)$ with $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ ([conventions.md:136](../findings/conventions.md), L24's statement at [second-order.md:61](../findings/second-order.md)). `foxProd2` ([FirstVariation.lean:57-58](../lean/HamiltonsCubic/Results/FirstVariation.lean)) is `(1/2) • (Qop2 (X + Y) - Qop2 X - Qop2 Y)`, the same definition. So `innerOp2 (foxProd2 W X) X` is $\langle L_WX,X\rangle$ with no factor.
- **$W^\perp$ inside $\mathcal W_n$.** L24 is stated on "the unit sphere of $\mathrm{Weyl}_n$" ([second-order.md:61](../findings/second-order.md)), so its $W^\perp$ is the tangent space $W^\perp\cap\mathcal W_n$, and [conventions.md:35](../findings/conventions.md) reads $B=\tfrac\theta2\mathrm{Id}-L_W\succeq0$ on the same $W^\perp$. The Lean quantifies over Weyl $X$ with $\langle W,X\rangle=0$, exactly that space.
- **$\le$ as operators versus as forms.** "$L_W\le\tfrac\theta2$ on $W^\perp$" read as a Loewner inequality of the compression is the quadratic-form inequality the Lean states. At a critical point $W^\perp$ is $L_W$-invariant (L125), so compression and restriction agree. Neither stronger nor weaker.
- **No sign on $\theta$.** The record's clause carries none and the Lean carries none.
- **The bridge to `Tsym`.** The proof converts `hcap` into the `Tsym` form by `Tsym_eq_fox` at self-adjoint `W`, `X` ([L214Frame.lean:214-215](../lean/HamiltonsCubic/Results/L214Frame.lean)), then calls `L214_op_cap` with $D$ = `piF`, $N$ = `W - piF`, `ht := rfl`, $\langle D,N\rangle=0$ and $T(D,D,N)=0$ from `L214_frame`, $\lVert N\rVert^2=1-t$ from `piF_t_range`. I read each argument against `L214_op_cap`'s signature ([L214Op.lean:162-166](../lean/HamiltonsCubic/Results/L214Op.lean)).

`L214_op_cap` needs no unit hypothesis on $W$: `ht`, `htN` and `hDN` force $\lVert W\rVert^2=1$. Its cap is the `Tsym` form $T(W,X,X)\le\tfrac\theta2\lVert X\rVert^2$, equal to the record's by `Tsym_eq_fox`. `L214_op_max` ([L214Op.lean:207-213](../lean/HamiltonsCubic/Results/L214Op.lean)) is now one line, `L214_op_cap` fed `Tsym_cap`, which is what r1786 O1 asked for.

### A.2 The equivalent form and the range of $t$

- `L214_frame_cap`'s second conjunct is `Pcubic2 (piF …) ≤ θ / 2 * (normSq2 (piF …) * (1 + normSq2 (piF …)))`, which is $P(D)\le\tfrac\theta2t(1+t)$ with $t=\lVert D\rVert^2$. It is derived from the first conjunct and relation one by `ring` and `linarith` ([:219-222](../lean/HamiltonsCubic/Results/L214Frame.lean)), which is the record's step 4.
- `piF_t_range` ([L214Frame.lean:183-201](../lean/HamiltonsCubic/Results/L214Frame.lean)) states $\lVert W-\pi_FW\rVert^2=1-t$, $0\le t$ and $t\le1$ at unit Weyl $W$. That is $t\in[0,1]$.

### A.3 The clause map behind INDEX:199

| # | Record clause | Covering theorem | Lean hypothesis beyond the record's |
|---|---|---|---|
| 1 | any orthonormal frame $F$ | every declaration takes `U` with `IsOrth U`, frame = columns | none |
| 2 | $D=\pi_FW$, the coordinate-diagonal part in $F$ | `piF`, `piF_diag`, `piF_perp`, `piF_unique` | none |
| 3 | $N=W-D$ | literally `W - piF hU W hW` in every statement | none |
| 4 | $t=\lVert D\rVert^2\in[0,1]$ | `piF_t_range` | none |
| 5 | $a=\langle L_DN,N\rangle$ | `Tsym_eq_fox`, at self-adjoint $D$, $N$ (both Weyl: `isWeyl2_piF`, `isWeyl2_sub'`) | none |
| 6 | $\theta t=P(D)+a$ | `L214_frame`, third conjunct | none |
| 7 | $\theta(1-t)=2a+P(N)$ | `L214_frame`, fourth conjunct | none |
| 8 | under the cap, $a\ge\tfrac\theta2t(1-t)$ | `L214_frame_cap`, first conjunct | none |
| 9 | equivalently $P(D)\le\tfrac\theta2t(1+t)$ | `L214_frame_cap`, second conjunct | none |
| 10 | L24 supplies the cap at every global maximiser | `L214_frame_global` (the conclusion), with `Tsym_cap` supplying the cap once $\theta=P(W)>0$ is derived | $n\ge4$, vacuous since $\mathcal W_n=0$ at $n\le3$ (r1786 O4) |
| 11 | and at a local one with $\theta>0$ | `Tsym_cap` (the cap itself), `L214_frame_max` (the conclusion) | none |

**The sentence survives.** Every clause, including the two r1786 found uncovered, has a theorem at the record's hypotheses. `a` in clauses 6 to 9 is `Tsym D N N`, and clause 5 is the separate theorem that makes it the record's $a$. The rest of row 199 matches the files: the stale "$\theta>0$" sentence is gone (r1786 O3), and r1741 is attributed to L214Op.

## B. Commit 26b700a6, Lemma L222

**The record** ([findings/second-order.md:1578](../findings/second-order.md) and [:1580](../findings/second-order.md)), verbatim:

> 1. *$\mathcal S_{jk}$ is a subalgebra, preserved by rotations in the $(j,k)$-plane.*
> 3. *If $W=D+\nu$ is a unit critical point with $\nu\ne0$, then $\langle D,\hat g\rangle=\theta/\sqrt3$ for $\hat g=G_x/\lVert G_x\rVert$, and $2L_{D^+}D^-=\theta D^-$.*

and item 2 ([:1579](../findings/second-order.md)): *$\nu\circ\nu=G_x$ … and $\lVert G_x\rVert^2=3\lVert x\rVert^4$, so $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$*, with $\lVert\nu\rVert^2=2\lVert x\rVert^2$ in the statement's preamble.

### B.1 `InSjk` against $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$

`SignChar c R` ([L120Hess.lean:41-42](../lean/HamiltonsCubic/Results/L120Hess.lean)) says conjugation by every $\mathrm{diag}(\varepsilon)$, $\varepsilon_i=\pm1$, scales $R$ by $c(\varepsilon)$. In the orthonormal pair basis the entry $R_{ab,cd}$ picks up $\varepsilon_a\varepsilon_b\varepsilon_c\varepsilon_d$, so:

- **character $1$** is support on $\{a,b\}\triangle\{c,d\}=\varnothing$, the pair-diagonal operators. On Weyl operators, `trivial_block_iff` ([L120Ident.lean:49-51](../lean/HamiltonsCubic/Results/L120Ident.lean)) makes this exactly `restrict (diagOp w)` for a weight $w$, the record's $\mathcal D_n$;
- **character $\varepsilon_j\varepsilon_k$** (`setChar {j,k}`, `setChar_pair` at $j\ne k$) is support on $\{a,b\}\triangle\{c,d\}=\{j,k\}$, which forces $\{a,b\}=\{j,x\}$, $\{c,d\}=\{k,x\}$ with $x\notin\{j,k\}$ (or the transpose). On self-adjoint operators these are $\sum_ax_a\,e_{ja}\odot e_{ka}$, and the Weyl condition adds only $\mathop{\mathrm{Ric}}_{jk}=\sum_ax_a=0$, Bianchi being automatic with a repeated index. That is the record's $V_{jk}$ with its $\sum x=0$. This coordinate reading is argued here and matches L120's block description ([second-order.md:1295](../findings/second-order.md) onward). The Lean does not state it, and the INDEX row owes it under item 2.

`InSjk j k R` ([L222Op.lean:120-121](../lean/HamiltonsCubic/Results/L222Op.lean)) asks for a character-$1$ `D` and a character-$\varepsilon_j\varepsilon_k$ `ν` with no Weyl or self-adjointness condition. So `InSjk` is a superspace of $\mathcal S_{jk}$, and $\mathcal S_{jk}=\mathrm{InSjk}\cap\mathcal W_n$: for Weyl $R=D+\nu$ the two parts are the sign-isotypic components (unique by `char_split_zero`), and those of a Weyl operator are Weyl (`comp_isWeyl2`).

`Sjk_mul` ([:124-133](../lean/HamiltonsCubic/Results/L222Op.lean)) closes the superspace under `foxProd2`: $D\circ D'+\nu\circ\nu'$ has character $1$ (`pairChar_sq`), $D\circ\nu'+\nu\circ D'$ has character $\varepsilon_j\varepsilon_k$. The record's clause follows at once with `isWeyl2_foxProd2` ([L24Restrict.lean:64](../lean/HamiltonsCubic/Results/L24Restrict.lean)), L209's closure of $\mathcal W_n$. **Faithful and stronger**, with the intersection step left to the reader (O4). It is also the record's own proof of item 1 read as characters: its "fixed space of $\ker(\varepsilon_j\varepsilon_k)$" is character $1$ plus character $\varepsilon_j\varepsilon_k$, the only characters trivial on that kernel. `Sjk_mul` needs no $j\ne k$. At $j=k$ it degenerates harmlessly.

`foxProd2_char2` ([:50-65](../lean/HamiltonsCubic/Results/L222Op.lean)) rests on `foxProd_act`, the equivariance of $\circ$ under orthogonal conjugation, and `signMat_orth`. `char_split_zero` ([:89-117](../lean/HamiltonsCubic/Results/L222Op.lean)) uses the flip at $j$, where the pair character is $-1$, so $A=-B$ has characters $1$ and $-1$ at once and vanishes. Correct.

### B.2 `Sjk_crit` and `Sjk_pin` against item 3

- **`Sjk_crit`** ([:136-159](../lean/HamiltonsCubic/Results/L222Op.lean)): from $Q(D+\nu)=\theta(D+\nu)$ (`Qop2_add` polarises), the character-$1$ part gives $Q(D)+Q(\nu)=\theta D$ and the $\varepsilon_j\varepsilon_k$ part gives $2D\circ\nu=\theta\nu$. These are the record's "$D\circ D+G_x=\theta D$" and "$L_D\nu=\tfrac\theta2\nu$" from item 3's proof, with $G_x=\nu\circ\nu=Q(\nu)$ by `foxProd2_self` ([L24Eigen.lean:48](../lean/HamiltonsCubic/Results/L24Eigen.lean)). The Lean needs no unit norm, no Weyl and no $\nu\ne0$, so its hypotheses are weaker than the record's.
- **`Sjk_pin`, first clause** ([:163-176](../lean/HamiltonsCubic/Results/L222Op.lean)): $\langle D,Q(\nu)\rangle=\tfrac\theta2\lVert\nu\rVert^2$ at self-adjoint $D,\nu$, through `innerOp2_foxProd2_self` ($\langle D\circ\nu,\nu\rangle=\langle D,Q(\nu)\rangle$). This is the record's $\langle D,G_x\rangle=\tfrac\theta2\lVert\nu\rVert^2$, unconditional.
- **`Sjk_pin`, second clause**: given `normSq2 (Qop2 ν) = 3/4 * normSq2 ν ^ 2` and $\nu\ne0$, `innerOp2 D (Qop2 ν) / √(normSq2 (Qop2 ν)) = θ / √3`. Here $\hat g=Q(\nu)/\lVert Q(\nu)\rVert=\nu\circ\nu/\lVert\nu\circ\nu\rVert$ by `foxProd2_self`, the record's $G_x/\lVert G_x\rVert$.
- **Normalisation.** Item 2's $\lVert G_x\rVert^2=3\lVert x\rVert^4$ with $\lVert\nu\rVert^2=2\lVert x\rVert^2$ gives $\lVert\nu\circ\nu\rVert^2=3(\lVert\nu\rVert^2/2)^2=\tfrac34\lVert\nu\rVert^4$, the hypothesis exactly. Both sides use one norm: `innerOp2` is $\tfrac12\sum_{i,j}\tfrac12\mathop{\mathrm{tr}}((R\varphi_{ij})^{\mathsf T}S\varphi_{ij})$ ([Bivectors2.lean:279-280](../lean/HamiltonsCubic/Base/Bivectors2.lean), `inner2` at [WeylReal.lean:39](../lean/HamiltonsCubic/Base/WeylReal.lean)), the Frobenius norm in the orthonormal pair basis over unordered pairs. That is the norm item 2's proof computes in ("the norm over unordered pairs"), and it gives $\lVert\nu\rVert^2=2\lVert x\rVert^2$ with $\nu$ carrying $x_a$ at $(ja,ka)$ and $(ka,ja)$. The arithmetic $\tfrac{\theta/2\,\lVert\nu\rVert^2}{(\sqrt3/2)\lVert\nu\rVert^2}=\theta/\sqrt3$ is item 3's proof.

### B.3 The INDEX:151 row

- **partial**: correct. Item 1's rotation invariance, item 2, item 3's $2L_{D^+}D^-=\theta D^-$ and item 4 at the operator are not proved.
- The PROVED list matches the file: `foxProd2_char2`, `char_split_zero`, `Sjk_mul`, `Sjk_crit`, `Sjk_pin` with the norm stated as a hypothesis ("given item 2's norm").
- **The owed list is incomplete** (O6). Items 5 and 6 have no operator-level declaration. `pair_mass_le` ([L222Statement.lean:81](../lean/HamiltonsCubic/Results/L222Statement.lean)) is the scalar step $X_N\le X_D\Rightarrow N\le A/2$ of item 5's last inequality, with $\lVert\xi\cdot D\rVert^2=2A$ and $\lVert\xi\cdot\nu\rVert^2=4N$ as hypotheses. $\xi\cdot D\in V_{jk}$, $\xi\cdot\nu\in\mathcal D_n$, the stationarity $\langle x,K_{j\cdot}-K_{k\cdot}\rangle=0$ and item 6's $\theta\langle D,G_x\rangle=\langle L_{G_x}D,D\rangle$ are typed nowhere. The row names neither item.

## 4. Axioms and witnesses (scratch R1787.lean, `lake env lean`, exit 0)

```
'HamiltonsCubic.L214Frame.L214_frame_cap' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Op.L214_op_cap' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Op.L214_op_max' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Frame.piF_unique' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Frame.piF_t_range' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L214Frame.Tsym_eq_fox' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L222Op.Sjk_mul' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L222Op.Sjk_crit' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L222Op.Sjk_pin' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L222Op.char_split_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.L222Op.foxProd2_char2' depends on axioms: [propext, Classical.choice, Quot.sound]
'r1787_cap_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
'r1787_sjk_witness' depends on axioms: [propext, Classical.choice, Quot.sound]
```

`axiom_audit.py --only L222Op.lean`: "11/11 clean -- resting on the standard three alone".

- **`r1787_cap_witness`.** $n=4$, $W$ the unit Weyl global maximiser of `exists_weyl_maximiser`, $U=S_v$ with $v=(\tfrac35,\tfrac45,0,0)$ (r1786's non-coordinate frame). The cap hypothesis of `L214_frame_cap` is discharged in its `foxProd2` form from `Tsym_cap` and `Tsym_eq_fox` with $\theta=P(W)\ge\sqrt{3/2}$, and the theorem is instantiated to extract $P(\pi_FW)\le\tfrac{P(W)}2t(1+t)$. Every hypothesis is met by a nonzero object. A critical point meeting the cap that is not a maximiser is not exhibited: none is cheaply on file.
- **`r1787_sjk_witness`.** $n=6$, $D$ the unit balanced sphere product of `L120Witness.balanced_unit 3` ($S^3\times S^3$ as a diagonal operator, $P(D)\ne0$, $Q(D)=\lambda D$), character $1$ by `trivial_block_iff`, $\nu=0$ of character $\varepsilon_0\varepsilon_1$, $j=0$, $k=1$. `Sjk_crit` is instantiated. This is the $\nu=0$ case only.
- **A $\nu\ne0$ example is on the record but not in Lean**: L224's equality case ([second-order.md](../findings/second-order.md), Lemma L224 step 5), $W=e^{\varphi\xi}\cdot B$ with $B$ an L57 maximiser whose blocks separate $j$ and $k$. It is critical as a rotation of a critical point, lies in $\mathcal S_{jk}$ by item 1's rotation invariance (owed in Lean), and has $\nu\ne0$ at generic $\varphi$ because $\xi\cdot D^-_y=\nu_{2y}\ne0$ (item 5, untyped). Building it in Lean needs both owed items.

## 5. Observations

- **O1 (record pointer, [findings/second-order.md:1359](../findings/second-order.md)).** The note says the inequality under the cap "is `L214_op_cap` in the coordinate frame and `L214_frame_cap` in every frame". `L214_op_cap` is frame-free: it takes any split with $\langle D,N\rangle=0$, $T(D,D,N)=0$, $D$ Weyl. The coordinate-frame file is L214Diag.lean, which has no cap theorem. Suggested wording: "`L214_op_cap` at any split with $T(D,D,N)=0$".
- **O2 ([L214Frame.lean:209-211](../lean/HamiltonsCubic/Results/L214Frame.lean)).** The record's "equivalently" is typed as two conjuncts, the second derived from the first. The converse direction is equally one `linarith` from `L214_frame`'s third conjunct and is not stated. Coverage is complete because both conclusions are theorems. An `↔` would type the word itself.
- **O3 (record heading, [second-order.md:1352](../findings/second-order.md)).** "one inequality at every maximiser" is wider than the body, which gets the cap at global maximisers and local ones with $\theta>0$. L24's $\theta=0$ local branch is owed ([second-order.md](../findings/second-order.md), L24 scope). The Lean covers what the body says, so this is a record matter.
- **O4 ([L222Op.lean:120-133](../lean/HamiltonsCubic/Results/L222Op.lean)).** `InSjk` omits the Weyl condition, so `Sjk_mul` closes a superspace. The record's "$\mathcal S_{jk}$ is a subalgebra" is `Sjk_mul` plus `isWeyl2_foxProd2` plus $\mathcal S_{jk}=\mathrm{InSjk}\cap\mathcal W_n$. The last needs the isotypic parts of a Weyl operator to be Weyl, from `comp_isWeyl2` and `char_split_zero`. A two-line corollary `Sjk_mul_weyl` would make the INDEX's "item 1's subalgebra clause" literal. The identification of the character-$\varepsilon_j\varepsilon_k$ Weyl operators with $\mathop{\mathrm{span}}\{e_{ja}\odot e_{ka}\}$, $\sum x=0$ is argued in B.1 and owed in Lean under item 2.
- **O5 ([L222Op.lean:167](../lean/HamiltonsCubic/Results/L222Op.lean), INDEX:151).** The $\theta/\sqrt3$ pinning is conditional on item 2's norm, which is owed. The row does say "given item 2's norm" but files it under PROVED as "item 3's pinning". Stating in the owed list that item 3's pinning inherits item 2's debt would stop a reader counting it as discharged.
- **O6 (finding, against [lean/INDEX.md:151](../lean/INDEX.md) and [second-order.md:1575](../findings/second-order.md)).** The owed list, "item 1's rotation invariance; item 2 …; item 3's $2L_{D^+}D^-=\theta D^-$ …; item 4", omits items 5 and 6. The record's note repeats the omission ("The Lean owes item 2, item 3's $2L_{D_+}D_-=\theta D_-$, item 4 and the rotation invariance"), and 26b700a6's message says the list was *narrowed to* those items. Item 5 has only its scalar core `pair_mass_le`. Item 6 has nothing. Repair: add "item 5 (the orbit derivatives $\xi\cdot D$, $\xi\cdot\nu$ and the stationarity condition, with only the scalar step `pair_mass_le` typed) and item 6" to both lists. Item 6 is a two-line consequence of `Sjk_crit`'s first equation paired with $G_x$ and total symmetry, once $G_x$ is available.
- **O7 (non-vacuity, [L222Op.lean](../lean/HamiltonsCubic/Results/L222Op.lean)).** The file carries no witness, unlike L222Statement.lean. `r1787_sjk_witness` shows the hypotheses of `Sjk_crit` met by a nonzero $D$ at $\nu=0$, which is the case in which $\mathcal S_{jk}$ says nothing new. A $\nu\ne0$ witness needs items 1 and 5 (section 4).

## 6. What would falsify each headline

| Statement | Falsifying object |
|---|---|
| `L214_frame_cap` | a unit Weyl $W$ with $Q(W)=\theta W$ meeting $\langle W\circ X,X\rangle\le\tfrac\theta2\lVert X\rVert^2$ on Weyl $X\perp W$, and an orthogonal $U$ with $T(\pi_FW,N,N)<\tfrac\theta2t(1-t)$ or $P(\pi_FW)>\tfrac\theta2t(1+t)$ |
| `L214_op_cap` | a critical Weyl $W$ under the `Tsym` cap and a split $W=D+N$, $D$ Weyl, $\langle D,N\rangle=0$, $\lVert D\rVert^2=t$, $\lVert N\rVert^2=1-t$, $T(D,D,N)=0$, with $T(D,N,N)<\tfrac\theta2t(1-t)$ |
| `piF_unique` | two distinct frame-diagonal operators each with $W-D$ orthogonal to all frame-diagonal operators |
| `piF_t_range` | a unit Weyl $W$ and frame with $\lVert\pi_FW\rVert^2>1$ |
| INDEX:199 completeness sentence | a clause of L214's statement whose only covering theorem carries a hypothesis the record lacks, other than the vacuous $n\ge4$. None found |
| `Sjk_mul` | $x,y$ in `InSjk j k` with $x\circ y$ carrying a nonzero component of a sign character other than $1$ and $\varepsilon_j\varepsilon_k$ |
| `Sjk_crit` | $D$ of character $1$, $\nu$ of character $\varepsilon_j\varepsilon_k$, $j\ne k$, $Q(D+\nu)=\theta(D+\nu)$, with $Q(D)+Q(\nu)\ne\theta D$ |
| `Sjk_pin` | the same with $D,\nu$ self-adjoint and $\langle D,Q(\nu)\rangle\ne\tfrac\theta2\lVert\nu\rVert^2$ |
| INDEX:151 owed list | a clause of L222's statement neither proved at the operator nor owed: **items 5 and 6 are such clauses** (O6) |

## Verdict

**CONFIRMED for `L214_op_cap`, `L214_op_max`, `Tsym_eq_fox`, `piF_unique`, `Sjk_crit`. CONFIRMED WITH OBSERVATIONS for `L214_frame_cap`, `piF_t_range`, `Sjk_mul`, `Sjk_pin`, and for INDEX:199's "Every clause of L214's statement has a covering theorem in every frame at the record's hypotheses", which now survives. INDEX:151's status "partial" CONFIRMED, and its owed list REFUTED AS STATED: items 5 and 6 are missing from it and from the record's L222 note.** All theorems are axiom-clean on the standard three and non-vacuous at the witnesses above.
