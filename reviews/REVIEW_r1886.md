# REVIEW r1886: L226GenA, part A of Lemma L226 item 1 at every k

Gate 2 review of [L226GenA.lean](../lean/HamiltonsCubic/Results/L226GenA.lean) at commit 4ac9d43b: the embedding of $\Lambda^2\mathbb R^J$ as the top-left block, the three block actions of `blockOpG`, and the split $\mathop{\mathrm{tr}}W^3=\mathop{\mathrm{tr}}R_J^3+\sum_a\mathop{\mathrm{tr}}M_a^3+\sum_{a<b}K_{ab}^3$. Every claim holds. The trace identity is true at every array $R$, with or without the curvature symmetries, and it reads as the record's $\mathop{\mathrm{tr}}R_J^3$ exactly when $R$ is pair-symmetric, which the file's docstring supplies through `IsCurvArray` and the theorem does not assume. Analysis-only footing: the numerical content of this review is one exact-rational screen of seconds on constructed objects, reported as a screen.

| Claim | Verdict |
|---|---|
| `emb`, `emb_phi`, `inner2_emb`, `br_emb`: $\Lambda^2\mathbb R^J$ as the top-left block, preserving $\varphi$, the inner product and the bracket | CONFIRMED |
| `blockOpG_emb`: $W(\mathrm{emb}\,X)=\mathrm{emb}(\mathrm{opOf}\,R\,X)$ at every matrix $X$ | CONFIRMED |
| `blockOpG_M`: $W\varphi_{pa}=\sum_q(M_a)_{pq}\varphi_{qa}$ | CONFIRMED |
| `blockOpG_K`: $W\varphi_{ab}=K_{ab}\varphi_{ab}$, including $a=b$ | CONFIRMED |
| `trCube_blockOpG`: $\mathop{\mathrm{tr}}W^3=\mathop{\mathrm{tr}}R_J^3+\sum_a\mathop{\mathrm{tr}}M_a^3+\sum_{a<b}K_{ab}^3$ | CONFIRMED WITH OBSERVATIONS |
| Hypotheses: none unused, none missing | CONFIRMED |
| Axioms: standard three on `trCube_blockOpG`, `blockOpG_emb` and the five others | CONFIRMED |
| L226 row of [lean/INDEX.md](../lean/INDEX.md): part A text and owed clause | CONFIRMED WITH OBSERVATIONS |

**One line.** Part A is correct as typed and slightly stronger than advertised, since `trCube_blockOpG` needs no curvature symmetry on $R$. The reading of `trCube (opOf R)` as the record's $\mathop{\mathrm{tr}}R_J^3$ needs pair symmetry, a point the docstring and the INDEX row leave implicit.

## Conventions

- `inner2 X Y` $=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, so $\lvert\varphi_{ij}\rvert=1$ for $i\ne j$ ([WeylReal.lean:39](../lean/HamiltonsCubic/Base/WeylReal.lean#L39)).
- `phi i j` $=E_{ji}-E_{ij}$, with `phi_swap` and `phi_self` ($\varphi_{ii}=0$).
- `innerOp R S` $=\tfrac12\sum_{i,j}\langle R\varphi_{ij},S\varphi_{ij}\rangle$ over ordered pairs, and `trCube R` $=$ `innerOp (compOp R) R` $=\tfrac12\sum_{i,j}\langle R^2\varphi_{ij},R\varphi_{ij}\rangle$ ([WeylReal.lean:135](../lean/HamiltonsCubic/Base/WeylReal.lean#L135)).
- `opOf C X` $=\tfrac14\sum_{ijkl}\langle X,\varphi_{ij}\rangle C_{ijkl}\varphi_{kl}$ ([L226Statement.lean:168](../lean/HamiltonsCubic/Results/L226Statement.lean#L168)). It depends on $X$ only through its skew part and on $C$ only through its antisymmetrisation in each pair.
- `blockCoeffG R M K` ([L226Gen.lean:44](../lean/HamiltonsCubic/Results/L226Gen.lean#L44)) is $R$ on four $J$ indices, $\pm\delta_{ab}(M_a)_{pq}$ on the four mixed patterns, $\pm K_{ab}$ on $(a,b,a,b)$ and $(a,b,b,a)$ at $a\ne b$, and zero elsewhere. `blockOpG = opOf (blockCoeffG R M K)`.
- `IsCurvArray R`: `anti1`, `anti2`, `pair` ([L226Gen.lean:32](../lean/HamiltonsCubic/Results/L226Gen.lean#L32)).

The record, [second-order.md](../findings/second-order.md), heading "Lemma L226, the cubic on the block subalgebra", verbatim:

> **Setting.** Fix $J\subseteq[n]$ with $\lvert J\rvert=k\ge2$, outer set $A=[n]\setminus J$ and $m=n-k$. Put $V_a=\mathop{\mathrm{span}}\{\varphi_{pa}:p\in J\}$, identified with $\mathbb R^J$ by $x\mapsto\sum_px_p\varphi_{pa}$, and for $x,y\in\mathbb R^J$ put $x\wedge y=\sum_{p,q}x_py_q\varphi_{pq}\in\Lambda^2\mathbb R^J$. Here $\mathcal S_J$ is the fixed space of $H_J$ in the symmetric operators on $\Lambda^2\mathbb R^n$. The block note's character argument uses no Weyl condition and gives the same block form on it, and the block note's $\mathcal S_J$ is $\mathcal S_J\cap\mathcal W_n$ in this notation. By the block note, $W\in\mathcal S_J$ is block-diagonal on $\Lambda^2\mathbb R^n=\Lambda^2\mathbb R^J\oplus\bigoplus_{a\in A}V_a\oplus\Lambda^2\mathbb R^A$: a symmetric $R_J$ on $\Lambda^2\mathbb R^J$, a symmetric $M_a$ on $V_a$ with $(M_a)_{pq}=W_{pa,qa}$, and $W\varphi_{ab}=K_{ab}\varphi_{ab}$. So $\lVert W\rVert^2=\lvert R_J\rvert^2+\sum_a\lvert M_a\rvert^2+\sum_{a<b}K_{ab}^2$. $\Lambda^2M$ is the operator $x\wedge y\mapsto Mx\wedge My$ on $\Lambda^2\mathbb R^J$.

> 1. *For every $W\in\mathcal S_J$,* $$P(W)=P(R_J)+\sum_{a\in A}\Big(\mathop{\mathrm{tr}}M_a^3+3\mathop{\mathrm{tr}}\big(R_J\,\Lambda^2M_a\big)\Big)+\sum_{a<b}\Big(K_{ab}^3+3K_{ab}\mathop{\mathrm{tr}}(M_aM_b)\Big)+3\sum_{a<b<c}K_{ab}K_{ac}K_{bc},$$ *where $P(R_J)=\mathop{\mathrm{tr}}R_J^3+\langle R_J,R_J^\#\rangle$ is the cubic of $\Lambda^2\mathbb R^J=\mathfrak{so}(k)$.*

Part A is the $\mathop{\mathrm{tr}}W^3$ half of item 1, the identity closing proof step 3: "With $\mathop{\mathrm{tr}}W^3=\mathop{\mathrm{tr}}R_J^3+\sum_a\mathop{\mathrm{tr}}M_a^3+\sum_{a<b}K_{ab}^3$ this is item 1."

## Hypothesis inventory

| Declaration | Hypotheses | Used where | Needed? |
|---|---|---|---|
| `emb`, `emb_phi`, `inner2_emb`, `br_emb`, `inner2_emb_*` | none | | |
| `blockOpG_emb` | none (arbitrary $R$, $M$, $K$, $X$) | | yes, none needed (section 2) |
| `blockOpG_M` | none | | none needed: the computation never swaps $p,q$ in $M_a$ |
| `blockOpG_K_ne` | `hK` symmetric, `hab` $a\ne b$ | `rw [hK b a]` in the case table | yes: without `hK` the action is $\tfrac12(K_{ab}+K_{ba})\varphi_{ab}$ |
| `blockOpG_K` | `hK` | passed to `blockOpG_K_ne` | yes, as above |
| `trk` | `hA` symmetric | `hA.apply i j` | yes: without it the sum is $\mathop{\mathrm{tr}}(AAA^{\mathsf T})$ |
| `trCube_blockOpG` | `hM` symmetric, `hK` symmetric | `hM` in `trk` (B2), `hK` in `blockOpG_K` and `offdiag_sym` (B4) | both needed, see section 4 |

No `IsCurvArray`, no $K_{aa}=0$, no Ricci or Bianchi hypothesis appears anywhere in the file, and none is needed: $K_{aa}$ never enters `blockCoeffG` (every outer entry requires $a\ne b$), and $\varphi_{aa}=0$ removes the diagonal from B4.

## 1. The embedding

`emb X = fromBlocks X 0 0 0` is linear. `emb_phi`: the block of $E_{qp}-E_{pq}$ at `(inl, inl)` is $\varphi_{pq}$ and the other three blocks are zero, checked entrywise over the four `Sum` cases. `inner2_emb`: $(\mathrm{emb}X)^{\mathsf T}\mathrm{emb}Y=\mathrm{fromBlocks}(X^{\mathsf T}Y)\,0\,0\,0$, whose trace is $\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$. `br_emb`: block multiplication of two top-left blocks is the top-left block of the product. All four hold at arbitrary (not only skew) matrices, which is what the proofs give. CONFIRMED.

## 2. `blockOpG_emb` at every X

The question in the brief was whether this holds at a non-skew $X$ given that `opOf` reads $X$ through $\langle X,\varphi_{ij}\rangle$. It does, and the reason is structural. $\langle\mathrm{emb}X,\varphi_{ij}\rangle=\tfrac12((\mathrm{emb}X)_{ji}-(\mathrm{emb}X)_{ij})$ (`inner2_phi_eq'`) vanishes unless $i,j$ are both in $J$, where it is $\langle X,\varphi_{pq}\rangle$ (`inner2_emb_M`, `_M'`, `_K`, `_J`). So only $(i,j)=(\mathrm{inl}\,p,\mathrm{inl}\,q)$ survives, and `blockCoeffG` at `(inl p, inl q, k, l)` is nonzero only when $k,l$ are both in $J$, where it is $R_{pqrs}$ (every other `(inl, inl, _, _)` pattern falls to the `| _, _, _, _ => 0` arm). The surviving sum is $\tfrac14\sum_{pqrs}\langle X,\varphi_{pq}\rangle R_{pqrs}\varphi_{\mathrm{inl}r,\mathrm{inl}s}=\mathrm{emb}(\mathrm{opOf}\,R\,X)$ by `emb_phi` and linearity. Both sides see only the skew part of $X$, so the identity at non-skew $X$ is the skew identity with the symmetric part discarded on both sides. No symmetry of $R$ enters. CONFIRMED.

## 3. The block actions

`blockOpG_M`. By `opOf_phi`, $W\varphi_{pa}=\tfrac14\sum_{kl}(C_{p a k l}-C_{a p k l})\varphi_{kl}$. The nonzero terms are $(k,l)=(q,a)$, contributing $(M_a)_{pq}-(-(M_a)_{pq})=2(M_a)_{pq}$ on $\varphi_{qa}$, and $(k,l)=(a,q)$, contributing $-(M_a)_{pq}-(M_a)_{pq}$ on $\varphi_{aq}=-\varphi_{qa}$, so $+2(M_a)_{pq}\varphi_{qa}$. Total $\tfrac14\cdot4(M_a)_{pq}\varphi_{qa}$. This matches the Setting's $(M_a)_{pq}=W_{pa,qa}=\langle W\varphi_{pa},\varphi_{qa}\rangle$ and the identification $x\mapsto\sum_px_p\varphi_{pa}$. No symmetry of $M_a$ is used, correctly. CONFIRMED.

`blockOpG_K`. At $a\ne b$ the same formula gives $\tfrac14[(K_{ab}+K_{ba})\varphi_{ab}-(K_{ab}+K_{ba})\varphi_{ba}]=\tfrac12(K_{ab}+K_{ba})\varphi_{ab}$, which is $K_{ab}\varphi_{ab}$ under `hK`. At $a=b$ both sides are zero ($\varphi_{aa}=0$, and `opOf_smul` at $c=0$ gives $W0=0$), so the statement holds with no hypothesis on $K_{aa}$. CONFIRMED.

## 4. `trCube_blockOpG` and the normalisations

Unfolding, $\mathop{\mathrm{trCube}}W=\tfrac12\sum_{i,j\in J\sqcup A}\langle W^2\varphi_{ij},W\varphi_{ij}\rangle$, split by `Fintype.sum_sum_type` into four ordered-pair blocks.

- **(J, J), B1.** By `blockOpG_emb` twice and `inner2_emb`, $\sum_{p,q}\langle W^2\varphi_{pq},W\varphi_{pq}\rangle=\sum_{p,q}\langle L_R^2\varphi_{pq},L_R\varphi_{pq}\rangle$ with $L_R=\mathrm{opOf}\,R$ on `Fin k`. The factor $\tfrac12$ of the big `innerOp` is then exactly the factor $\tfrac12$ of `trCube` on `Fin k`, so this block contributes `trCube (opOf R)` with no leftover factor.
- **(J, A) and (A, J), B2 and B3.** $\{\varphi_{\mathrm{inl}p,\mathrm{inr}a}\}_p$ is orthonormal (`orthM`), $W$ carries it by $M_a$ (`blockOpG_M`), so `tri_orth` gives $\sum_{ijl}(M_a)_{ij}(M_a)_{jl}(M_a)_{il}$, which is $\mathop{\mathrm{tr}}M_a^3$ by `trk` under `hM`. B3 equals B2 through $\varphi_{ap}=-\varphi_{pa}$ with two sign flips cancelling. The two blocks give $2\sum_a\mathop{\mathrm{tr}}M_a^3$, halved to $\sum_a\mathop{\mathrm{tr}}M_a^3$.
- **(A, A), B4.** $\langle K_{ab}^2\varphi_{ab},K_{ab}\varphi_{ab}\rangle=K_{ab}^3\langle\varphi_{ab},\varphi_{ab}\rangle$, which is $K_{ab}^3$ at $a\ne b$ and $0$ at $a=b$. `offdiag_sym` with `hK` turns the off-diagonal sum into $2\sum_{a<b}K_{ab}^3$, halved to $\sum_{a<b}K_{ab}^3$.

The ordered-pair doubling is therefore handled consistently: the big operator's $\tfrac12$ halves the doubled mixed and outer sums, and on the $J$ block it is absorbed into the small operator's own $\tfrac12$. The final `ring` closes $\tfrac12(B_1+B_2+B_3+B_4)$ against the right side.

**Does the statement need `IsCurvArray`?** No. Every step above holds at an arbitrary array $R$, and the theorem is true as stated at every $R$. **Is `opOf R` then still the record's $R_J$?** Only under pair symmetry. `opOf R` equals `opOf` of the pair-antisymmetrisation of $R$, so `anti1` and `anti2` are automatic in effect. Pair symmetry is what makes $\langle\mathrm{opOf}\,R\,\varphi_{pq},\varphi_{rs}\rangle=R_{pqrs}$ a symmetric matrix and hence the record's symmetric $R_J$ (`pairing_J` in [L226Gen.lean](../lean/HamiltonsCubic/Results/L226Gen.lean) proves the entry formula under `IsCurvArray`). Without it, `trCube L` $=\sum_{e}\langle L^2e,Le\rangle=\mathop{\mathrm{tr}}(L^{\mathsf T}L^2)$, which differs from $\mathop{\mathrm{tr}}L^3$. The screen of section 6 shows the two differ at a non-pair-symmetric array ($-623/216$ against $-305/216$). So the theorem is true at every $R$, and its right side is "the record's $\mathop{\mathrm{tr}}R_J^3$" when $R$ is an `IsCurvArray`, which is the case the docstring describes (O1).

**Hypotheses.** `hM` is needed: without symmetry the (J, A) blocks give $\mathop{\mathrm{tr}}(M_aM_aM_a^{\mathsf T})$, and at $M=\begin{pmatrix}1&1\\0&0\end{pmatrix}$ that is $2$ against $\mathop{\mathrm{tr}}M^3=1$. `hK` is needed: without it the outer eigenvalue is $\tfrac12(K_{ab}+K_{ba})$. CONFIRMED WITH OBSERVATIONS.

## 5. Axioms and build

`#print axioms`, run through `lake env lean` from `lean/` on a scratch file after the background tree build finished (`/tmp/lean_tree_build.log`: "Build completed successfully (9808 jobs)", zero error lines), gives `[propext, Classical.choice, Quot.sound]` for `trCube_blockOpG`, `blockOpG_emb`, `blockOpG_K`, `blockOpG_M`, `br_emb`, `inner2_emb` and `emb_phi`. The file contains no `sorry`, `admit` or `axiom`. CONFIRMED.

## 6. A concrete object (screen)

A screen in exact rationals (session scratchpad, /private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/02e525cf-c3d5-4040-a8be-a716103a9bb2/scratchpad/screen_r1886.py, not committed) reimplements `phi`, `inner2`, `opOf`, `trCube` and `blockCoeffG` as the Lean file defines them, with random rational $R$, symmetric $M_a$, symmetric $K$ and a nonzero junk diagonal $K_{aa}$. It establishes nothing by itself.

| $k$ | $m$ | $R$ | $\mathop{\mathrm{tr}}W^3$ | right side | equal | `blockOpG_emb` at a non-skew $X$ |
|---|---|---|---|---|---|---|
| 2 | 1 | `IsCurvArray` | 3430/27 | 3430/27 | yes | yes |
| 2 | 2 | `IsCurvArray` | 199/216 | 199/216 | yes | yes |
| 3 | 2 | `IsCurvArray` | 1115/8 | 1115/8 | yes | yes |
| 3 | 3 | `IsCurvArray` | -3377/108 | -3377/108 | yes | yes |
| 2 | 2 | arbitrary | 2411/27 | 2411/27 | yes | yes |
| 3 | 2 | arbitrary | 473153/3456 | 473153/3456 | yes | yes |

A second screen at $k=3$ builds $R$ from a $3\times3$ pair matrix $S$: `trCube (opOf R)` equals $\mathop{\mathrm{tr}}S^3$ at symmetric $S$ ($-91/12$ both) and differs at non-symmetric $S$, the observation of section 4. The $k=2$, $m=1$ row is the object the brief named: there $\Lambda^2\mathbb R^J$ is the line $\varphi_{01}$, $R_J$ is the scalar $R_{0101}$, and the identity reads $\mathop{\mathrm{tr}}W^3=R_{0101}^3+\mathop{\mathrm{tr}}M_0^3$, with no $K$ term at one outer index.

## 7. The INDEX row

The L226 row's new text: "**Item 1 at every $k$, part A, PROVED** in L226GenA.lean: `emb` ... with `emb_phi`, `inner2_emb`, `br_emb`; **`blockOpG_emb`**, $W(\mathrm{emb}\,X)=\mathrm{emb}(R_JX)$ at every $X$; `blockOpG_M`, `blockOpG_K` ...; **`trCube_blockOpG`**, $\mathop{\mathrm{tr}}W^3=\mathop{\mathrm{tr}}R_J^3+\sum_a\mathop{\mathrm{tr}}M_a^3+\sum_{a<b}K_{ab}^3$ with $\mathop{\mathrm{tr}}R_J^3$ the layer's `trCube` on `Fin k`; standard three axioms." Every declaration named exists with the stated content and the axiom claim is right. The owed clause, "item 1 at $k\ne3$ (r1686), the sharp pairing $\langle W,W^\#\rangle$ on the block form, which needs $\Lambda^2M$ on $\Lambda^2\mathbb R^k$", correctly leaves the $\langle W,W^\#\rangle$ half (the four sums of proof step 3) open, and the row's status stays **partial**, which is right. Two small points are O1 and O3. CONFIRMED WITH OBSERVATIONS.

## Verdict

**CONFIRMED WITH OBSERVATIONS.** Every declaration of part A is correct, kernel-checked on the standard three axioms, with each hypothesis used and needed. `trCube_blockOpG` holds at every array $R$. Its identification with the record's $\mathop{\mathrm{tr}}R_J^3$ holds under `IsCurvArray`'s pair symmetry, stated in the docstring rather than the theorem.

**Falsifier.** A choice of $R$, $M_a$ symmetric and $K$ symmetric at some $(k,m)$ with $\mathop{\mathrm{trCube}}(\mathrm{blockOpG}\,R\,M\,K)\ne\mathop{\mathrm{trCube}}(\mathrm{opOf}\,R)+\sum_a\mathop{\mathrm{tr}}M_a^3+\sum_{a<b}K_{ab}^3$, or an $X$ with $\mathrm{blockOpG}(\mathrm{emb}X)\ne\mathrm{emb}(\mathrm{opOf}\,R\,X)$. I looked for it by deriving each block contribution by hand from `opOf_phi` and `blockCoeffG` (sections 2 to 4), by checking the $\tfrac12$ on both operators, and by the exact screen at six $(k,m,R)$ configurations including arbitrary $R$, non-skew $X$ and a nonzero $K_{aa}$. None was found. The kernel check makes the Lean statements themselves unfalsifiable, so the live question was only whether the statements say what the record says, answered in section 4 and O1.

## Observations

- **O1. The theorem is stronger than its reading, and the reading needs pair symmetry.** `trCube_blockOpG` assumes nothing on $R$, while "`trCube (opOf R)` is $\mathop{\mathrm{tr}}R_J^3$" holds only when $R$ is pair-symmetric (section 4, screen $-623/216\ne-305/216$). A one-line corollary under `IsCurvArray`, or a sentence in the docstring of `trCube_blockOpG` and in the INDEX row saying the identity holds at every $R$ and is the record's $\mathop{\mathrm{tr}}R_J^3$ at an `IsCurvArray`, would pin the reading.
- **O2. `blockOpG_emb` at every $X$ is true for a trivial reason worth recording.** Both sides depend on $X$ only through its skew part, so the non-skew case adds no content. The INDEX phrase "at every $X$" is accurate.
- **O3. Link text in the INDEX row's file column.** The file column lists `[L226GenA.lean](HamiltonsCubic/Results/L226GenA.lean)`, whose target resolves, while its neighbours use the full path as link text. Cosmetic only.
- **O4. Lean's range is wider than the record's.** The file has no $k\ge2$ hypothesis. At $k\le1$, $\Lambda^2\mathbb R^J=0$ and `trCube (opOf R)` is $0$, so the statement degrades gracefully, and at $m=0$ it is the identity $\mathop{\mathrm{tr}}W^3=\mathop{\mathrm{tr}}R_J^3$.
- **O5. The block form is built, not derived.** As at item 2 (r1864 O1), the step from $W\in\mathcal S_J$ to `blockOpG R M K` is the block note's argument, untyped. Part A is item 1's trace half on the block form. The INDEX row inherits this caveat from the item 2 text above it and does not repeat it for part A.
