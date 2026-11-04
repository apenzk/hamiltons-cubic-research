# REVIEW r1807: L224 steps 1 and 3 in the record's coordinates (L224Pair.lean, L224Norm.lean) and OddPart's set equality

**Verdict: CONFIRMED WITH OBSERVATIONS.** Commits 4cdb4bf2 and 5bb09949 state L224's step 3 as the pairing identity $P(W)=P(E)+3\langle E,G_y\rangle+3\langle E,G_x\rangle$ and step 1 as $\lVert W\rVert^2=\lVert E\rVert^2+2s$, both on the record's objects, with the record's norm and pairing and the record's coefficients. `odd_iff` is L222's identification of the odd part with $\{y:\sum y=0\}$ as a set equality. The observations are bookkeeping in [lean/INDEX.md](../lean/INDEX.md): one file missing from the L224 row's file column and one converse fact attributed to the wrong declarations in the L222 row.

Footing: analysis only. The runs were three compiles with `lake env lean` (each exit 0, no output) and three calls of `python3 scripts/misc/axiom_audit.py --only <File>.lean`. The $n=4$ object in section 5 is a hand evaluation in exact integer arithmetic, a screen of the identity at one point and no evidence for the general claim.

## The record, verbatim

- L224 step 1, [second-order.md:1616](../findings/second-order.md#L1616): "**Coordinates.** Let $\sigma$ swap $j$ and $k$. It fixes $K_{jk}$ and every $K_{ab}$, so a diagonal $D$ splits as $D=E+D^-_y$ with $E$ swap-even and $D^-_y$ the tensor with $K_{ja}=y_a$, $K_{ka}=-y_a$ and no other entry, which lies in $\mathcal D_n$ exactly when $\sum y=0$, with $\lVert D^-_y\rVert^2=2\lVert y\rVert^2$. Every element of $V_{jk}$ is $\nu_x=\sum_ax_a\,e_{ja}\odot e_{ka}$ with $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$, and $\sigma$ fixes it. So $W=E+D^-_y+\nu_x$ and $\lVert W\rVert^2=\lVert E\rVert^2+2s$ with $s=\lVert y\rVert^2+\lVert x\rVert^2$."
- L224 step 2, [second-order.md:1617](../findings/second-order.md#L1617): "**The two squares.** $\nu_x\circ\nu_x=G_x$ is L222's item 2. With the diagonal product $(A\circ A)_{pq}=A_{pq}^2+\sum_cA_{pc}A_{cq}$, $D^-_y\circ D^-_y$ has $(ja)$-entry $y_a^2$, $(jk)$-entry $\sum_ay_a(-y_a)=-\lVert y\rVert^2$ and $(ab)$-entry $y_ay_b+(-y_a)(-y_b)=2y_ay_b$, so it is $G_y$. The entries of $G_z$ are linear in $zz^{\mathsf T}$, so $G_y+G_x=\mathcal G(C)$ for $C=yy^{\mathsf T}+xx^{\mathsf T}$ with $\mathcal G$ linear."
- L224 step 3, [second-order.md:1618](../findings/second-order.md#L1618): "**The cubic.** In $P(W)=T(W,W,W)$ a term with an odd number of factors $D^-_y$ vanishes, $\sigma$ being an automorphism that fixes $E$ and $\nu_x$ and reverses $D^-_y$. A term with an odd number of factors $\nu_x$ vanishes by the character $\varepsilon_j\varepsilon_k$ ([L120](#lemma-l120-l_m-is-block-diagonal-over-the-sign-characters-at-every-diagonal-critical-point), L222's item 1). *This is [L219](#lemma-l219-the-reflection-split-the-odd-part-of-a-critical-point-has-zero-cubic-and-is-a-tfractheta2-eigenvector-of-the-even-part)'s reflection split applied at the reflections in $e_j-e_k$ and in $e_j$.* What remains is $P(E)+3T(E,D^-_y,D^-_y)+3T(E,\nu_x,\nu_x)$, and total symmetry with step 2 gives $$P(W)=P(E)+3\langle E,G_y\rangle+3\langle E,G_x\rangle=P(E)+3\langle E,\mathcal G(C)\rangle .$$"
- L224 proof preamble, [second-order.md:1615](../findings/second-order.md#L1615): "$G_z$ is L222's diagonal tensor with $K_{ja}=K_{ka}=z_a^2$, $K_{jk}=-\lVert z\rVert^2$, $K_{ab}=2z_az_b$."
- L222 Statement, [second-order.md:1591](../findings/second-order.md#L1591): "$D\in\mathcal D_n$ with sectional matrix $K$, and let $\sigma$ swap $j$ and $k$ with $D=D^++D^-$ its even and odd parts, the odd part having entries $K_{ja}=-K_{ka}$."
- L222 item 4, [second-order.md:1595](../findings/second-order.md#L1595): "On the odd part, identified with $\{y:\sum y=0\}$, $L_{G_x}$ acts as $y\mapsto\tfrac12\lVert x\rVert^2y+x\langle x,y\rangle$."

## Claim table

| # | Claim | Verdict |
|---|---|---|
| 1 | [L224Pair.lean](../lean/HamiltonsCubic/Results/L224Pair.lean) `L224_cubic_G`: step 3 with $\langle E,G_y\rangle$, $\langle E,G_x\rangle$ and coefficients $3$ | CONFIRMED |
| 2 | [L224Norm.lean](../lean/HamiltonsCubic/Results/L224Norm.lean) `inner_flip_zero` | CONFIRMED |
| 3 | `inner_char_pair`: characters $1$ and $\varepsilon_j\varepsilon_k$ orthogonal via the flip at $j$ | CONFIRMED |
| 4 | `L224_norm`: $\lVert D+\nu\rVert^2=\lVert E\rVert^2+2(\sum y^2+\sum x^2)$, the record's norm and the record's $\mathcal D_n$ | CONFIRMED WITH OBSERVATIONS (O3) |
| 5 | [OddPart.lean](../lean/HamiltonsCubic/Results/OddPart.lean) `Dminus_weight`, `Dminus_charOne` | CONFIRMED |
| 6 | `odd_iff` against L222's preamble and item 4's identification | CONFIRMED |
| 7 | [lean/INDEX.md:152](../lean/INDEX.md#L152), the L222 row's new sentences | CONFIRMED WITH OBSERVATIONS (O2) |
| 8 | [lean/INDEX.md:155](../lean/INDEX.md#L155), the L224 row: sentences, owed list, file column | CONFIRMED WITH OBSERVATIONS (O1, O4) |
| 9 | Axiom audits: L224Pair 1/1, L224Norm 3/3, OddPart 12/12, standard three | CONFIRMED |

**Summary:** both theorems say what steps 1 and 3 say on the record's objects under the record's conventions, `odd_iff` is the identification item 4 uses, and the defects are an incomplete file column and one misattributed converse fact in the index.

## 1. `L224_cubic_G` against step 3

The statement, verbatim:

```lean
theorem L224_cubic_G (hjk : j ≠ k) {D ν : CurvOp2 (Fin n)} (hDW : IsWeyl2 D) (hνW : IsWeyl2 ν)
    (hD : SignChar (fun _ => 1) D) (hν : SignChar (setChar {j, k}) ν) :
    ∃ y x : Fin n → ℝ, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ x j = 0 ∧ x k = 0 ∧ ∑ i, x i = 0 ∧
      (1 / 2 : ℝ) • (D - rotR (swapM j k) D) = coordOp (Dminus j k y) ∧ ν = nuX j k x ∧
      Pcubic2 (D + ν) = Pcubic2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D))
        + 3 * innerOp2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) (coordOp (Gy j k y))
        + 3 * innerOp2 ((1 / 2 : ℝ) • (D + rotR (swapM j k) D)) (coordOp (Gy j k x))
```

- **The hypotheses are the record's $W\in\mathcal S_{jk}$.** $\mathcal D_n$ is the Weyl operators of sign character $1$ (L120's trivial summand, [L120Ident.lean](../lean/HamiltonsCubic/Results/L120Ident.lean) `trivial_block_iff`: character $1$ and Weyl iff $V$ is `diagOp` of an `IsWeight` $w$, symmetric, hollow, zero row sums, which is the record's diagonal tensor with sectional matrix $K=w$). $V_{jk}$ is the Weyl operators of character $\varepsilon_j\varepsilon_k$, `setChar {j, k}` $=\varepsilon_j\varepsilon_k$ by `setChar_pair`.
- **The pairing is the record's.** `innerOp2 R S` $=\tfrac12\sum_{i,j}\langle R\varphi_{ij},S\varphi_{ij}\rangle_2$ with $\langle X,Y\rangle_2=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ and $\varphi_{ij}=E_{ji}-E_{ij}$, a unit vector for $\langle\cdot,\cdot\rangle_2$. The $\tfrac12$ over ordered pairs collapses to a sum over unordered pairs, so `innerOp2` is the Frobenius pairing on $\Lambda^2$ in the orthonormal basis $\{\varphi_{p<q}\}$. On two coordinate operators this is $\sum_{p<q}E_{pq}(G_z)_{pq}$, the pairing L222 item 6 writes as "$\langle D,G_x\rangle=\sum_{a<b}K_{ab}(G_x)_{ab}$ over unordered pairs".
- **`coordOp (Gy j k y)` is the record's $G_y$.** `Gy`'s off-diagonal entries are $y_a^2$ at $(j,a)$ and $(k,a)$, $(\sum y^2)u_ju_k=-\lVert y\rVert^2$ at $(j,k)$, and $(\sum u^2)y_ay_b=2y_ay_b$ at $(a,b)$, matching the preamble's $G_z$. Its diagonal differs from the record's hollow $K$, and `coordOp` never reads it (r1796 O4), so the operator is the record's.
- **`coordOp (Dminus j k y)` is the record's $D^-_y$.** The weight $(e_j-e_k)y^{\mathsf T}+y(e_j-e_k)^{\mathsf T}$ has $K_{ja}=y_a$, $K_{ka}=-y_a$ and nothing else, the record's sign convention.
- **The coefficients $3$ are right.** Expanding $T(E+M+\nu)^{\otimes3}$ with $T$ symmetric trilinear gives the ten monomials $E^3,3E^2M,3E^2\nu,3EM^2,3E\nu^2,6EM\nu,M^3,3M^2\nu,3M\nu^2,\nu^3$. The swap kills those with one or three $M$ ($E^2M$, $EM\nu$, $M\nu^2$, $M^3$), the flip at $j$ those with one or three $\nu$ ($E^2\nu$, $M^2\nu$, $\nu^3$). What remains is $T(E,E,E)+3T(E,M,M)+3T(E,\nu,\nu)$. With `foxTri2 X Y Z` $=\langle X\circ Y,Z\rangle$ and `foxProd2_self` ($X\circ X=Q(X)$, from $\tfrac12(Q(2X)-2Q(X))=Q(X)$), $T(E,M,M)=\langle M\circ M,E\rangle=\langle E,Q(M)\rangle$, which `Q_odd_half` makes $\langle E,G_y\rangle$ and `Q_pair` makes $\langle E,G_x\rangle$ for $\nu$. The factor $3$ enters once, from `L224_cubic_pair` (r1795), and `L224_cubic_G` rewrites only the second arguments.
- **The proof** is `Q_odd_half` and `Q_pair` for the witnesses, then `rw [L224_cubic_pair …, foxProd2_self, foxProd2_self, hQM, hQν]`. Each rewrite is an equality of the operator in the second slot, so no coefficient moves.

## 2. L224Norm.lean against step 1

- **`inner_flip_zero`.** From `innerOp2_rotR` (an orthogonal frame change preserves `innerOp2` on Weyl operators), $\langle A,B\rangle=\langle UA,UB\rangle=\langle A,-B\rangle=-\langle A,B\rangle$. Correct, and the Weyl hypotheses are what `innerOp2_rotR` needs.
- **`inner_char_pair`.** $\varepsilon=-1$ at $j$ and $+1$ elsewhere is a sign vector. Character $1$ gives `rotR (signMat ε) A = A`, and character $\varepsilon_j\varepsilon_k$ gives the scalar $\varepsilon_j\varepsilon_k=(-1)(1)=-1$ on $B$, using $j\ne k$ in `Finset.prod_pair`. This is the record's "reflection … in $e_j$".
- **`L224_norm`.** $E$ and $M=\tfrac12(D-\sigma D)$ are Weyl of character $1$ (the swap keeps character $1$, `signChar_rotR_swap`). $\sigma E=E$ and $\sigma M=-M$ from $\sigma^2=1$, so `inner_flip_zero` gives $\langle E,M\rangle=0$, and `inner_char_pair` gives $\langle E,\nu\rangle=\langle M,\nu\rangle=0$. With `normSq2_Dminus` and `normSq2_nuX` (PairNorm) the six-term expansion of $\lVert E+M+\nu\rVert^2$ is $\lVert E\rVert^2+2\sum y^2+2\sum x^2$. This is step 1's sentence "$\lVert W\rVert^2=\lVert E\rVert^2+2s$ with $s=\lVert y\rVert^2+\lVert x\rVert^2$", with $\lVert y\rVert^2=\sum_cy_c^2$ over all $c$ equal to the record's sum over $a\notin\{j,k\}$ because $y_j=y_k=0$.
- **The norm convention.** `normSq2 R = innerOp2 R R` $=\sum_{p<q}\lVert R\varphi_{pq}\rVert_2^2$, the record's $\lVert\cdot\rVert$. It is pinned independently by the record's own values: `normSq2_coordOp` gives $\tfrac12\sum_{i\ne l}a_{il}^2=\sum_{p<q}a_{pq}^2$, and on $D^-_y$ that is $2\lVert y\rVert^2$, the record's "$\lVert D^-_y\rVert^2=2\lVert y\rVert^2$". A doubled or halved convention would give $4\lVert y\rVert^2$ or $\lVert y\rVert^2$.
- **"a diagonal $D$" matches `IsWeyl2 D ∧ SignChar (fun _ => 1) D`.** The record's $\mathcal D_n$ is the Weyl diagonal tensors, $K$ symmetric hollow with zero row sums. `trivial_block_iff` is this equivalence, so the hypothesis is neither stronger nor weaker than the record's.
- The record's clause "which lies in $\mathcal D_n$ exactly when $\sum y=0$" is `odd_iff` (claim 6), and "Every element of $V_{jk}$ is $\nu_x$" is `pair_eq_nuX` inside `Q_pair`. "$\sigma$ fixes it" is `pair_swap_even`, which `L224_norm` does not need, orthogonality of $\nu$ to $M$ coming from the characters instead.

## 3. `Dminus_weight`, `Dminus_charOne`, `odd_iff`

- **`Dminus_weight`.** The weight $uv^{\mathsf T}+vu^{\mathsf T}$, $u=e_j-e_k$, $v=y$ off $\{j,k\}$, is symmetric, hollow ($u_iv_i=0$, `uj_vy`), and has row sums $u_a\sum v+v_a\sum u=0$ at $\sum v=0$ and $\sum u=0$. These are `IsWeight`'s three clauses. Correct.
- **`Dminus_charOne`.** `trivial_block_iff`'s reverse direction, with Weyl-ness from PairSquare's `Dminus_weyl` and `coordOp_eq_restrict` identifying the two operator forms. Correct.
- **`odd_iff`**: `(IsWeyl2 V ∧ SignChar (fun _ => 1) V ∧ rotR (swapM j k) V = -V) ↔ ∃ y, y j = 0 ∧ y k = 0 ∧ ∑ i, y i = 0 ∧ V = coordOp (Dminus j k y)`.
  - Against the preamble's "the odd part having entries $K_{ja}=-K_{ka}$": the left side is the odd part of $\mathcal D_n$ under the record's $\sigma$ (`swapM`, r1806 claim 2). The right side's operators have exactly the entries $K_{ja}=y_a=-K_{ka}$ and zero at $K_{jk}$ and $K_{ab}$, which is what the swap forces, since the swap fixes $K_{jk}$ and every $K_{ab}$ (step 1).
  - Against item 4's "identified with $\{y:\sum y=0\}$": $y$ zero at $j,k$ is a vector indexed by $a\notin\{j,k\}$, and $\sum_iy_i=\sum_ay_a$. The map $y\mapsto D^-_y$ is linear and injective (`coordOp_weight_eq`), so with `odd_iff` it is a linear bijection onto the odd part. Injectivity is argued in the index, and no declaration states it (r1806 O2).

## 4. lean/INDEX.md

**L222 row, line 152.** The sentence "`odd_eq_Dminus` … (the proof takes $y_a=K_{ja}$, and `coordOp_weight_eq` makes $y$ unique, r1806 O2)" is accurate. The sentence "`Dminus_swap_odd`, `Dminus_weight` and `Dminus_charOne`, conversely every such $D^-_y$ is swap-odd, Weyl and of character $1$, assembled in **`odd_iff`**" attributes Weyl-ness to the three named declarations. Weyl-ness is PairSquare's `Dminus_weyl`, and `Dminus_weight` is the weight property (O2).

**L224 row, line 155.**
- The L224Pair sentence matches the statement in section 1, including "from `L224_cubic_pair` with OddPart's `Q_odd_half` … and PairIdent's `Q_pair`".
- The L224Norm sentence matches section 2. "with the coordinates of `L224_cubic_G` (`odd_half_eq_Dminus`, `pair_eq_nuX`)" is right: `L224_norm` obtains its $y,x$ from `L224_cubic_G`, whose witnesses come from those two.
- The owed list after 5bb09949 reads: "step 4 on the operators ($z_*$ and $W'$); step 5's $q_E=q_{B'}$ and rotation action; the link from L57Block.lean's proved L57 to `pair_value_le`'s hypothesis and L57's equality clause in block-constant form; and the Statement assembled on the operators." It names step 4, step 5, the L57 link and the assembled Statement. The two items removed (step 1's coordinates and norms, the pairings in `L224_cubic`) are exactly the ones these commits discharge.
- The file column is L224Statement, L224Cubic, DiagSquare, PairSquare, L224Pair, L224Norm, OddPart, PairIdent. **PairNorm.lean is missing** although the row's step-1 sentence names its `normSq2_Dminus` and `normSq2_nuX` (O1).

## 5. A concrete object (exact hand evaluation, $n=4$, a screen)

Take $n=4$, $j=0$, $k=1$, so $a\in\{2,3\}$. Let $D$ be the diagonal tensor with sectional matrix entries $K_{01}=-2$, $K_{02}=2$, $K_{03}=0$, $K_{12}=0$, $K_{13}=2$, $K_{23}=-2$.

- **Hypotheses.** $K$ is symmetric and hollow with row sums $-2+2+0$, $-2+0+2$, $2+0-2$, $0+2-2$, all $0$, so $D$ is Weyl of character $1$. Let $\nu=\nu_x$ with $x_2=1$, $x_3=-1$, $x_0=x_1=0$: $\nu\varphi_{0a}=x_a\varphi_{1a}$, $\nu\varphi_{1a}=x_a\varphi_{0a}$, $\nu=0$ on $\varphi_{01},\varphi_{23}$. A sign flip scales $\varphi_{0a}\mapsto\varphi_{1a}$ by $\varepsilon_0\varepsilon_a\cdot\varepsilon_1\varepsilon_a=\varepsilon_0\varepsilon_1$, so $\nu$ has character $\varepsilon_0\varepsilon_1$, and $\sum x=0$ makes it Weyl (`pair_eq_nuX`'s range).
- **The split.** $\sigma D$ has $K'_{pq}=K_{\sigma p\,\sigma q}$: $K'_{01}=-2$, $K'_{02}=0$, $K'_{03}=2$, $K'_{12}=2$, $K'_{13}=0$, $K'_{23}=-2$. So $E=\tfrac12(D+\sigma D)$ has $K_{01}=-2$, $K_{02}=K_{03}=K_{12}=K_{13}=1$, $K_{23}=-2$, and $\tfrac12(D-\sigma D)$ has $K_{02}=1$, $K_{03}=-1$, $K_{12}=-1$, $K_{13}=1$, which is $D^-_y$ with $y_2=1$, $y_3=-1$, $\sum y=0$.
- **Norms**, $\lVert R\rVert^2=\sum_{p<q}\lVert R\varphi_{pq}\rVert^2$. $\lVert D\rVert^2=4+4+0+0+4+4=16$. $\langle D,\nu\rangle=0$, since $\nu\varphi_{pq}\perp\varphi_{pq}$ for every pair. $\lVert\nu\rVert^2=x_2^2+x_3^2+x_2^2+x_3^2=4$. So $\lVert D+\nu\rVert^2=20$.
- **Right side.** $\lVert E\rVert^2=4+1+1+1+1+4=12$, $\sum y^2=2$, $\sum x^2=2$, and $12+2(2+2)=20$. The identity holds at this point. The component checks $\lVert D^-_y\rVert^2=4=2\cdot2$ and $\lVert\nu_x\rVert^2=4=2\cdot2$ agree with `normSq2_Dminus` and `normSq2_nuX`.

## 6. Axiom audits and compiles

| File | Compile | Audit |
|---|---|---|
| [L224Pair.lean](../lean/HamiltonsCubic/Results/L224Pair.lean) | exit 0, no output | 1/1 clean, standard three |
| [L224Norm.lean](../lean/HamiltonsCubic/Results/L224Norm.lean) | exit 0, no output | 3/3 clean, standard three |
| [OddPart.lean](../lean/HamiltonsCubic/Results/OddPart.lean) | exit 0, no output | 12/12 clean, standard three |

OddPart's count rose from r1806's 9 to 12 by exactly `Dminus_weight`, `Dminus_charOne` and `odd_iff`.

## Observations

- **O1.** The L224 row's file column at [lean/INDEX.md:155](../lean/INDEX.md#L155) omits [PairNorm.lean](../lean/HamiltonsCubic/Results/PairNorm.lean), which holds `normSq2_Dminus` and `normSq2_nuX`, the two norms step 1's sentence in the same row names and `L224_norm` uses. Repair: add PairNorm.lean to the column.
- **O2.** The L222 row at [lean/INDEX.md:152](../lean/INDEX.md#L152) says "`Dminus_swap_odd`, `Dminus_weight` and `Dminus_charOne`, conversely every such $D^-_y$ is swap-odd, Weyl and of character $1$". Weyl-ness is [PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean)'s `Dminus_weyl`, and `Dminus_weight` is the `IsWeight` property that `Dminus_charOne` consumes. Repair: name `Dminus_weyl` for the Weyl clause and describe `Dminus_weight` as the weight property.
- **O3.** `L224_cubic_G` and `L224_norm` are separate existentials, each with its own $y,x$. They coincide in fact, since $\tfrac12(D-\sigma D)=D^-_y$ with $y$ zero at $j,k$ fixes $y$ (`coordOp_weight_eq`) and $\nu=\nu_x$ fixes $x$ (`nuX_phi_ja`), and `L224_norm`'s proof takes them from `L224_cubic_G`. Step 4 uses step 1's $s$ and step 3's pairings on the same $(y,x)$, so a consumer will need one statement carrying both identities, or the uniqueness as a lemma. This is owed to step 4's formalisation and blocks nothing now.
- **O4.** The L224 row's state column reads **proved** while its owed list names four open items. The state predates these commits (it read **proved** at 4cdb4bf2's parent), so it is outside this review's diff. It is noted for whoever next edits the row, since the neighbouring L222 row with a shorter owed list reads **partial**.

## What would falsify each headline

- **Claim 1** falls if `innerOp2` differed from the record's $\langle\cdot,\cdot\rangle$ by a factor (checked in section 2 against $\lVert D^-_y\rVert^2=2\lVert y\rVert^2$), if `Gy`'s off-diagonal entries differed from the preamble's $G_z$, or if `L224_cubic_pair`'s coefficient $3$ were wrong (the monomial count in section 1).
- **Claims 2 and 3** fall if `innerOp2_rotR` needed more than Weyl-ness and orthogonality, or if the flip at $j$ scaled $V_{jk}$ by $+1$. $\varepsilon_j\varepsilon_k=-1$ at that flip since $j\ne k$.
- **Claim 4** falls if the character-$1$ Weyl operators were a proper subset or superset of the record's $\mathcal D_n$. `trivial_block_iff` is the equivalence. It also falls if the $n=4$ evaluation in section 5 failed, and there it gives $20=20$.
- **Claims 5 and 6** fall if some swap-odd diagonal Weyl tensor had a nonzero $K_{jk}$ or $K_{ab}$, or if some $D^-_y$ with $\sum y=0$ were not in $\mathcal D_n$. The swap fixes $K_{jk}$ and $K_{ab}$, and `Dminus_charOne` proves the second.
- **Claims 7 and 8** fall on any sentence in the rows that misstates a declaration. O1 and O2 are the two found.
