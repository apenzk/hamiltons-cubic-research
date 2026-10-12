# REVIEW r1796: DiagSquare.lean (commit 282cf3a8) against Lemma L224 step 2

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every declaration is true as stated and faithful to the record. `coordOp a` is the record's coordinate-diagonal tensor with sectional matrix $K=a$, `Qop2_coordOp` is the record's diagonal product, `Dminus j k y` is the record's $D^-_y$, and `Gy` agrees with the record's $G_y$ at every off-diagonal entry. The observations concern `Gy`'s diagonal (invisible to the operator), one docstring, the INDEX row's line number and the record's own Lean note, which predates this file.

Footing: analysis only. Compute used: `axiom_audit.py --only DiagSquare.lean` and one scratch file compiled with `lake env lean` for `#print axioms` and `#check`. No sweep, no numerical screen. The instance below is a hand evaluation.

## The record, quoted

[findings/second-order.md:1615](../findings/second-order.md), preamble: "$G_z$ is L222's diagonal tensor with $K_{ja}=K_{ka}=z_a^2$, $K_{jk}=-\lVert z\rVert^2$, $K_{ab}=2z_az_b$." Indices $a,b$ run over $a\notin\{j,k\}$ and $z$ lives in $\{z\in\mathbb R^{n-2}:\sum z=0\}$ (same line).

[findings/second-order.md:1616](../findings/second-order.md), step 1, the definition of $D^-_y$: "a diagonal $D$ splits as $D=E+D^-_y$ with $E$ swap-even and $D^-_y$ the tensor with $K_{ja}=y_a$, $K_{ka}=-y_a$ and no other entry, which lies in $\mathcal D_n$ exactly when $\sum y=0$, with $\lVert D^-_y\rVert^2=2\lVert y\rVert^2$."

[findings/second-order.md:1617](../findings/second-order.md), step 2, verbatim: "**The two squares.** $\nu_x\circ\nu_x=G_x$ is L222's item 2. With the diagonal product $(A\circ A)_{pq}=A_{pq}^2+\sum_cA_{pc}A_{cq}$, $D^-_y\circ D^-_y$ has $(ja)$-entry $y_a^2$, $(jk)$-entry $\sum_ay_a(-y_a)=-\lVert y\rVert^2$ and $(ab)$-entry $y_ay_b+(-y_a)(-y_b)=2y_ay_b$, so it is $G_y$. The entries of $G_z$ are linear in $zz^{\mathsf T}$, so $G_y+G_x=\mathcal G(C)$ for $C=yy^{\mathsf T}+xx^{\mathsf T}$ with $\mathcal G$ linear."

Conventions: [findings/conventions.md:140](../findings/conventions.md), $K_{ab}=W_{abab}$, symmetric and hollow. [findings/conventions.md:157](../findings/conventions.md): "On the diagonal locus the $\Lambda^2$ spectrum is the multiset of ENTRIES of $K$". The $\circ$ product is $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ (same file, the $\circ$ bullet), so $X\circ X=Q(X)$.

## Claim table

| # | Declaration | Claim | Verdict |
|---|---|---|---|
| 1 | `coordOp` ([I117Statements.lean:1360](../lean/HamiltonsCubic/Results/I117Statements.lean)) | the record's coordinate-diagonal tensor with $K=a$ | CONFIRMED (O1) |
| 2 | `coordOp_add` ([DiagSquare.lean:29](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | additive in the weight | CONFIRMED |
| 3 | `compOp2_coordOp` ([DiagSquare.lean:34](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | $(a\odot\cdot)^2=(a\odot a)\odot\cdot$ at symmetric $a$ | CONFIRMED |
| 4 | `starW_eq_mul` ([DiagSquare.lean:43](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | `starW a` $=a\,a$ | CONFIRMED |
| 5 | `Qop2_coordOp` ([DiagSquare.lean:47](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | $Q(a\odot\cdot)=(a\odot a+a\,a)\odot\cdot$, symmetric hollow $a$ | CONFIRMED, the record's diagonal product (O2) |
| 6 | `Qop2_rank_two` ([DiagSquare.lean:53](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | $Q$ at $uv^{\mathsf T}+vu^{\mathsf T}$, $u_iv_i=0$ | CONFIRMED WITH OBSERVATIONS (O4) |
| 7 | `uj`, `vy`, `Dminus` ([DiagSquare.lean:85-92](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | the record's $D^-_y$ | CONFIRMED, $\sum y=0$ not assumed (O3) |
| 8 | `Gy` ([DiagSquare.lean:95](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | "The record's $G_y$" | CONFIRMED WITH OBSERVATIONS, equal off the diagonal only (O5) |
| 9 | `uj_vy`, `uj_norm` ([DiagSquare.lean:101](../lean/HamiltonsCubic/Results/DiagSquare.lean), [:112](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | disjoint supports, $\lVert e_j-e_k\rVert^2=2$ | CONFIRMED |
| 10 | `Q_Dminus` ([DiagSquare.lean:108](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | $D^-_y\circ D^-_y=G_y$ | CONFIRMED, at the coordinate level (O6, O7) |
| 11 | `Gy_ja`, `Gy_ka`, `Gy_jk`, `Gy_ab` ([DiagSquare.lean:121-135](../lean/HamiltonsCubic/Results/DiagSquare.lean)) | entries $y_a^2$, $y_a^2$, $-\lVert y\rVert^2$, $2y_ay_b$ | CONFIRMED WITH OBSERVATIONS, `Gy_ab` also covers $a=b$ (O5) |
| 12 | [lean/INDEX.md:155](../lean/INDEX.md), L224 (statement) row | what DiagSquare proves, and the owed link | CONFIRMED WITH OBSERVATIONS (O8, O9) |

## Derivations

**Item 1, normalisation.** `coordOp a` sends $X$ to the skew part of $a\odot X$ ([I117Statements.lean:1360](../lean/HamiltonsCubic/Results/I117Statements.lean)). At symmetric $a$, `coordOp_coe` ([I117Statements.lean:1393](../lean/HamiltonsCubic/Results/I117Statements.lean)) drops the skew projection and `hadamard_phi` ([I117Statements.lean:1398](../lean/HamiltonsCubic/Results/I117Statements.lean)) gives $a\odot\varphi_{ab}=a_{ab}\varphi_{ab}$. So $\varphi_{ab}$ is an eigenvector with eigenvalue $a_{ab}$, and by conventions.md:157 the $\Lambda^2$ eigenvalue on $\varphi_{ab}$ of a coordinate-diagonal $W$ is $K_{ab}=W_{abab}$. The weight is $K$ with no factor.

**Item 2, the square.** $Q=R^2+R^\#$ is `Qop2` ([Bivectors2.lean:825](../lean/HamiltonsCubic/Base/Bivectors2.lean)). The $R^2$ half is $a\odot a$ (`compOp2_coordOp`). The $R^\#$ half is `sharpMapCL_coordOp` ([I117Statements.lean:1542](../lean/HamiltonsCubic/Results/I117Statements.lean)), `starW a` with $(\text{starW }a)_{xy}=\sum_c a_{xc}a_{cy}$, which `starW_eq_mul` identifies with $a\,a$. At $p\ne q$ the weight is $a_{pq}^2+\sum_ca_{pc}a_{cq}$, the record's product verbatim. An independent derivation agrees: [SharpDiag.lean:560](../lean/HamiltonsCubic/Base/SharpDiag.lean)'s `sharpQF_diagOp_eq_sq` gives $\langle W^\#\varphi_{ab},\varphi_{ab}\rangle=(w^2)_{ab}$ at a symmetric hollow $w$, the same sign and the same product, reached through `diagOp` and the bracket formula rather than through `sharpBil2`.

**Item 3, $D^-_y$.** With $u=e_j-e_k$ and $v=y$ off $\{j,k\}$: $(uv^{\mathsf T}+vu^{\mathsf T})_{ja}=u_jv_a+v_ju_a=y_a$, $(\cdot)_{ka}=-y_a$, $(\cdot)_{jk}=u_jv_k+v_ju_k=0$, $(\cdot)_{ab}=0$ since $u_a=u_b=0$, and the diagonal is $2u_iv_i=0$. That is "$K_{ja}=y_a$, $K_{ka}=-y_a$ and no other entry".

**Item 4, the entries.** From `Gy`'s four summands, $u_i^2v_l^2+v_i^2u_l^2+\lVert v\rVert^2u_iu_l+\lVert u\rVert^2v_iv_l$ with $\lVert u\rVert^2=2$:

| entry | four summands | value | record |
|---|---|---|---|
| $(j,a)$ | $y_a^2+0+0+0$ | $y_a^2$ | $z_a^2$ |
| $(k,a)$ | $y_a^2+0+0+0$ | $y_a^2$ | $z_a^2$ |
| $(j,k)$ | $0+0-\lVert y\rVert^2+0$ | $-\lVert y\rVert^2$ | $-\lVert z\rVert^2$ |
| $(a,b)$, $a\ne b$ | $0+0+0+2y_ay_b$ | $2y_ay_b$ | $2z_az_b$ |
| $(j,j)$, $(k,k)$ | $0+0+\lVert y\rVert^2+0$ | $\lVert y\rVert^2$ | $0$ (hollow) |
| $(a,a)$ | $0+0+0+2y_a^2$ | $2y_a^2$ | $0$ (hollow) |

The last two rows are O5. `Gy` is symmetric by construction, so the $(a,j)$, $(a,k)$, $(k,j)$ entries follow.

## Axioms

`axiom_audit.py --only DiagSquare.lean`: "12/12 clean -- resting on the standard three alone". Scratch `#print axioms`:

```
'HamiltonsCubic.DiagSquare.Qop2_coordOp' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.DiagSquare.Qop2_rank_two' depends on axioms: [propext, Classical.choice, Quot.sound]
'HamiltonsCubic.DiagSquare.Q_Dminus' depends on axioms: [propext, Classical.choice, Quot.sound]
```

`Gy_ja`, `Gy_ka`, `Gy_jk`, `Gy_ab` and `uj_norm` print the same three. `#check @Q_Dminus` is `∀ {n : ℕ} (j k : Fin n) (y : Fin n → ℝ), Qop2 (coordOp (Dminus j k y)) = coordOp (Gy j k y)`, matching the source.

## A concrete instance (hand evaluation)

$n=4$, $j=0$, $k=1$, $y=(\cdot,\cdot,1,-1)$, so `vy` $=(0,0,1,-1)$, `uj` $=(1,-1,0,0)$, $\sum y=0$ and $\lVert y\rVert^2=2$.

- `Dminus`: $K_{02}=1$, $K_{03}=-1$, $K_{12}=-1$, $K_{13}=1$, every other entry $0$. Row sums vanish, so it is in $\mathcal D_4$.
- From the lemmas: `Gy_ja` gives $K_{02}=K_{03}=1$, `Gy_ka` gives $K_{12}=K_{13}=1$, `Gy_jk` gives $K_{01}=-2$, `Gy_ab` gives $K_{23}=2\cdot1\cdot(-1)=-2$.
- Against the record's product directly: $(0,1)$: $0+K_{02}K_{21}+K_{03}K_{31}=-1-1=-2$. $(2,3)$: $0+K_{20}K_{03}+K_{21}K_{13}=-1-1=-2$. $(0,2)$: $K_{02}^2=1$ plus $\sum_cK_{0c}K_{c2}$, whose nonzero candidates $c\in\{2,3\}$ meet $K_{22}=K_{32}=0$, so $1$. Agreement.
- Off-diagonal row sums of $G_y$: row 0 is $-2+1+1=0$, row 2 is $1+1-2=0$, consistent with L222's zero rows at $\sum y=0$.
- `Gy`'s diagonal here is $(2,2,2,2)$, which the record's hollow $G_y$ sets to $0$ and `coordOp` never reads (O5).

## Observations

- **O1, normalisation is exact.** `coordOp a` on $\varphi_{ab}$ is $a_{ab}\varphi_{ab}$ ([I117Statements.lean:1398](../lean/HamiltonsCubic/Results/I117Statements.lean)), and conventions.md:157 reads the $\Lambda^2$ spectrum on the diagonal locus as the entries of $K$. So `coordOp K` is the record's coordinate-diagonal tensor with sectional matrix $K$, with no factor of $2$ or sign. The ordered-versus-unordered normalisation of conventions.md:142 bears on norms and does not enter a pointwise square.
- **O2, the matrix product's diagonal is harmless.** $(a\,a)_{pp}=\sum_ca_{pc}^2$ is nonzero, while the record's product is quoted only at $p\ne q$. `coordOp` reads a weight through $a\odot X$ at skew $X$, whose diagonal is $0$, and [I117Statements.lean:1560](../lean/HamiltonsCubic/Results/I117Statements.lean)'s `coordOp_offDiag` states that the diagonal is invisible. `Qop2_coordOp`'s hypothesis `ha0` (hollow $a$) is used by `sharpMapCL_coordOp` and holds at `Dminus` (derived in `Qop2_rank_two` at [DiagSquare.lean:60](../lean/HamiltonsCubic/Results/DiagSquare.lean)).
- **O3, $\sum y=0$ is correctly absent.** Step 1 uses $\sum y=0$ only for $D^-_y\in\mathcal D_n$, and $Q$ is defined on every operator, so the square holds on the whole coordinate-diagonal family. `Q_Dminus` is a strengthening. The Lean $y$ is a vector on `Fin n` whose values at $j,k$ `vy` discards, the record's $y\in\mathbb R^{n-2}$ indexed by $a\notin\{j,k\}$. `Q_Dminus` also carries no $j\ne k$ hypothesis: at $j=k$ `uj` is $e_j$ and `Dminus` is a different object, true and unused, and every entry lemma carries `hjk`.
- **O4, docstring hypothesis.** [DiagSquare.lean:17](../lean/HamiltonsCubic/Results/DiagSquare.lean) lists "disjoint supports and $u\cdot v=0$", and the theorem's only hypothesis is `hdis`, $u_iv_i=0$, from which [DiagSquare.lean:64](../lean/HamiltonsCubic/Results/DiagSquare.lean) derives $u\cdot v=0$. The theorem is the stronger form. Cosmetic.
- **O5, `Gy` is the record's $G_y$ off the diagonal only.** `Gy`'s diagonal is $\lVert y\rVert^2$ at $j$ and $k$ and $2y_a^2$ at $a$ (table above), and the record's $K$ is hollow. The operator `coordOp (Gy j k y)` is the record's operator by `coordOp_offDiag`, so `Q_Dminus` is exact. Two textual consequences: the docstring "The record's $G_y$" at [DiagSquare.lean:94](../lean/HamiltonsCubic/Results/DiagSquare.lean) holds of `offDiag (Gy j k y)`, and `Gy_ab` at [DiagSquare.lean:134](../lean/HamiltonsCubic/Results/DiagSquare.lean) has no $a\ne b$ hypothesis, so at $a=b$ it asserts `Gy j k y a a` $=2y_a^2$, a true fact about the Lean weight that differs from the record's $K_{aa}=0$. A consumer that pairs `Gy` entrywise as a matrix (for instance $\sum_{p,q}E_{pq}(G_y)_{pq}$ with a non-hollow $E$) would pick up the diagonal. Repair, if wanted: add `(hab : a ≠ b)` to `Gy_ab`, or reword the docstring to "a weight whose off-diagonal part is the record's $G_y$".
- **O6, what is and is not proved at step 2.** Proved: the first square at the coordinate level, $Q(\text{coordOp}(D^-_y))=\text{coordOp}(G_y)$, with the record's four entries. Unproved here and correctly left: the second square $\nu_x\circ\nu_x=G_x$ (L222 item 2), and the linearity clause $G_y+G_x=\mathcal G(yy^{\mathsf T}+xx^{\mathsf T})$. The latter is visible in `Gy`'s form (each summand is quadratic in $v$ through $v_i^2$, $v_iv_l$ and $\lVert v\rVert^2$) and is stated nowhere in Lean.
- **O7, no gap in the reduction.** `Q_Dminus` is `Qop2_rank_two` at `uj_vy`, and `Qop2_rank_two`'s proof expands $\sum_c(u_xv_c+v_xu_c)(u_cv_y+v_cu_y)$ and uses $u_xv_x=0$ to kill the cross term of $a_{xy}^2$. I rederived the result's four summands by hand (item 4) and found no slip.
- **O8, INDEX row line.** The L224 (statement) row is at [lean/INDEX.md:155](../lean/INDEX.md), not 154. Its DiagSquare sentence is accurate: `Qop2_coordOp` with the record's product, `Qop2_rank_two`, `Q_Dminus` with `Dminus` as stated, the four entries, standard three axioms. It says "at a symmetric weight with zero diagonal", matching `ha`, `ha0`.
- **O9, the owed link is correctly owed and correctly stated.** Closing it needs three things, none in DiagSquare or L224Cubic: that a character-$1$ operator is `coordOp` of its sectional matrix (step 1's coordinates, already listed as owed in the same row), that the swap frame change `swapM` acts on `coordOp K` by permuting $K$'s indices, and that $\tfrac12(D-\sigma D)=$ `coordOp (Dminus j k y)` with $y_a=\tfrac12(K_{ja}-K_{ka})$. The row names the link in the right direction and ties it to $\langle E,D^-\circ D^-\rangle=\langle E,G_y\rangle$, which is the form step 3 consumes.
- **O10, the record's Lean note is behind.** [findings/second-order.md:1611](../findings/second-order.md) still says "The Lean owes step 1's coordinates, step 2's squares with $\langle E,D_-\circ D_-\rangle=\langle E,G_y\rangle$ ..." and does not cite DiagSquare.lean. The pairing form is still owed (O9), so the sentence stays true, but the first square is now proved at the coordinate level and the note should name `Q_Dminus`, as r1795 O8 asked of L224Cubic.

## Falsifiers

| Headline | Object that would falsify it |
|---|---|
| `coordOp K` is the record's diagonal tensor with sectional matrix $K$ | a symmetric $K$ and a pair $a\ne b$ with $\langle\text{coordOp }K\,\varphi_{ab},\varphi_{ab}\rangle/\lVert\varphi_{ab}\rVert^2\ne K_{ab}$, or a conventions.md reading in which $W_{abab}$ is a multiple other than $1$ of the $\Lambda^2$ eigenvalue on $\varphi_{ab}$ |
| `Qop2_coordOp` is the record's diagonal product | a symmetric hollow $a$ and $p\ne q$ with $\langle Q(\text{coordOp }a)\varphi_{pq},\varphi_{pq}\rangle\ne a_{pq}^2+\sum_ca_{pc}a_{cq}$ (times $\lVert\varphi_{pq}\rVert^2$), which would also contradict SharpDiag's `sharpQF_diagOp_eq_sq` |
| `Dminus j k y` is $D^-_y$ | an index pair off $\{(j,a),(k,a),(a,j),(a,k)\}$ where `Dminus` is nonzero, or $(j,a)$ where it is not $y_a$ |
| `Q_Dminus` with the entry lemmas is $D^-_y\circ D^-_y=G_y$ | $j\ne k$ and $a\ne b$ off $\{j,k\}$ at which some off-diagonal entry of `Gy` differs from $z_a^2$, $z_a^2$, $-\lVert z\rVert^2$, $2z_az_b$ at $z=y$ |
| INDEX's owed link | a proof in the layer, before this commit, that `L224Cubic`'s $D^-$ equals `coordOp (Dminus j k y)`, which would make the row understate the layer. None found in L224Cubic.lean or DiagSquare.lean |
