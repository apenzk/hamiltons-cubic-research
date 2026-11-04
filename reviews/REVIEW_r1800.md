# Reviewer r1800: PairSquare.lean (commit a88898d0) against Lemma L222 item 2 and L224 step 2's second square

**Verdict: CONFIRMED WITH OBSERVATIONS.** `nuX j k x` is the record's $\nu_x$, `Q_nuX` is the record's $\nu_x\circ\nu_x=G_x$ with the record's hypothesis $\sum x=0$, and every rotation fact is true as stated and hand-derived here. The observations concern scope wording in [lean/INDEX.md](../lean/INDEX.md) and two stale Lean-status notes in [findings/second-order.md](../findings/second-order.md). No statement is refuted.

Footing: analysis only. This reader was dispatched as r1797, a number already held by the committed I121 review, and was renumbered r1800 by the coordinator. Compute used: `python3 scripts/misc/axiom_audit.py --only PairSquare.lean` and one scratch file compiled with plain `lake env lean` for `#print axioms` and `#check`. No sweep, no numerical screen. The instance below is a hand evaluation.

## The record, quoted

[findings/second-order.md:1591](../findings/second-order.md), the Statement preamble: "Let $n\ge4$, $j\ne k$, and $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$. Write $\nu\in V_{jk}$ as $\nu=\sum_ax_a\,e_{ja}\odot e_{ka}$ ($a\notin\{j,k\}$, $\sum x=0$, $\lVert\nu\rVert^2=2\lVert x\rVert^2$), $D\in\mathcal D_n$ with sectional matrix $K$, [...] Sums over $a$ run over $a\notin\{j,k\}$."

[findings/second-order.md:1593](../findings/second-order.md), item 2: "$\nu\circ\nu=G_x$, the diagonal tensor with $K_{ja}=K_{ka}=x_a^2$, $K_{jk}=-\lVert x\rVert^2$, $K_{ab}=2x_ax_b$, and $\lVert G_x\rVert^2=3\lVert x\rVert^4$, so $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$."

[findings/second-order.md:1617](../findings/second-order.md), L224 step 2: "$\nu_x\circ\nu_x=G_x$ is L222's item 2."

## Claim table

| # | Claim (Lean) | Verdict |
|---|---|---|
| 1 | `nuX j k x` is the record's $\nu_x=\sum_ax_a\,e_{ja}\odot e_{ka}$, with `nuX_phi_ja`, `nuX_phi_ka` | CONFIRMED |
| 2 | `Q_nuX`: `Qop2 (nuX j k x) = coordOp (Gy j k x)` at $\sum_{a\notin\{j,k\}}x_a=0$ | CONFIRMED WITH OBSERVATIONS (O1, O2) |
| 3a | `Rot`, `Rot_orth`, `Rot_diag_fix`, `Rot_diag_u` | CONFIRMED |
| 3b | `uXu_eq_SXS`, `uXS_add` need skewness and are applied only to skew $X$ | CONFIRMED |
| 3c | `rot45_Dminus`, `Gy_rot`, `sandOp_uu_rot`, `coordOp_Gy`, `rotR_sandOp`, `coordOp_rank_two` | CONFIRMED |
| 4a | [lean/INDEX.md:152](../lean/INDEX.md), the L222 row | CONFIRMED WITH OBSERVATIONS (O3, O4) |
| 4b | [lean/INDEX.md:155](../lean/INDEX.md), the L224 row | CONFIRMED WITH OBSERVATIONS (O5, O6) |

## 1. `nuX` is the record's $\nu_x$

[PairSquare.lean:326](../lean/HamiltonsCubic/Results/PairSquare.lean) defines `nuX j k x` as `sandOp S (diag v)` with $S=E_{jk}+E_{kj}$ and $v$ = `vy j k x` ($x$ off $\{j,k\}$, zero at $j,k$), acting as $X\mapsto SXD_v+D_vXS$. With $\varphi_{pq}=E_{qp}-E_{pq}$ ([WeylReal.lean:45](../lean/HamiltonsCubic/Base/WeylReal.lean)), $S e_j=e_k$, $Se_k=e_j$, $Se_a=0$ otherwise, and $D_ve_b=v_be_b$:
$$S E_{ab} D_v + D_v E_{ab} S = v_b\,(Se_a)e_b^{\mathsf T}+v_a\,e_a(Se_b)^{\mathsf T}.$$
On $X=E_{qp}-E_{pq}$ this is $v_p(Se_q)e_p^{\mathsf T}+v_qe_q(Se_p)^{\mathsf T}-v_q(Se_p)e_q^{\mathsf T}-v_pe_p(Se_q)^{\mathsf T}$.

- $(p,q)=(j,a)$, $a\notin\{j,k\}$: $v_j=0$ and $Se_a=0$ leave $x_a(E_{ak}-E_{ka})=x_a\varphi_{ka}$. The case $(k,a)$ is symmetric and gives $x_a\varphi_{ja}$. These are `nuX_phi_ja` and `nuX_phi_ka`.
- $\varphi_{jk}$: $v_j=v_k=0$ kills all four terms, so $\nu_x\varphi_{jk}=0$.
- $\varphi_{ab}$ with $a,b\notin\{j,k\}$: $Se_a=Se_b=0$ kills all four terms, so $\nu_x\varphi_{ab}=0$.
- $\langle\varphi_{kb},\nu_x\varphi_{ja}\rangle=x_a\langle\varphi_{kb},\varphi_{ka}\rangle=0$ for $a\ne b$.

So `nuX` is supported exactly on the pairs $\varphi_{ja}\leftrightarrow\varphi_{ka}$, which is $\sum_ax_a(\varphi_{ja}\otimes\varphi_{ka}+\varphi_{ka}\otimes\varphi_{ja})$ under [conventions.md:104](../findings/conventions.md)'s $u\odot v=u\otimes v+v\otimes u$. **Normalisation.** `inner2` is $\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, so each $\varphi_{pq}$ ($p<q$) is a unit vector, and `innerOp2` ([Bivectors2.lean:279](../lean/HamiltonsCubic/Base/Bivectors2.lean)) is $\tfrac12\sum_{i,j}$ over ordered pairs, which is the Hilbert–Schmidt sum over $p<q$ ([conventions.md:85](../findings/conventions.md): $\tfrac12$ at the $\Lambda^2$ level, plain Frobenius on the pair matrix). Hence $\lVert\nu_x\rVert^2=\sum_a(x_a^2+x_a^2)=2\lVert x\rVert^2$, the record's normalisation. PairSquare does not prove this norm (O4). The orientation of $e_{ja}$ enters $\varphi_{ja}$ and $\varphi_{ka}$ alike, so no sign of $x_a$ is at stake, and $G_x$ is quadratic in $x$ in any case.

## 2. `Q_nuX`

- **$Q$ is the record's square.** `Qop2 = compOp2 + sharpMapCL` ([Bivectors2.lean:825](../lean/HamiltonsCubic/Base/Bivectors2.lean)) is $R^2+R^\#$, the record's $Q=W^2+W^\#$ ([second-order.md:1601](../findings/second-order.md)), and [conventions.md:136](../findings/conventions.md)'s $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ gives $X\circ X=Q(X)$. The $\#$ normalisation is the one `Q_Dminus` already uses (r1796).
- **The right side is the record's $G_x$.** `coordOp (Gy j k x)` acts as $\varphi_{pq}\mapsto(G)_{pq}\varphi_{pq}$, and from [DiagSquare.lean:96](../lean/HamiltonsCubic/Results/DiagSquare.lean) with $u=e_j-e_k$, $u\odot v$ disjoint: $(G)_{ja}=u_j^2v_a^2=x_a^2$, $(G)_{ka}=x_a^2$, $(G)_{jk}=\lVert v\rVert^2u_ju_k=-\lVert x\rVert^2$, $(G)_{ab}=2x_ax_b$. The diagonal of `Gy` differs from the record's hollow $K$ and is never read (r1796 O5).
- **The proof chain.** `rot45_Dminus` rewrites $\nu_x$ as `rotR R45 (coordOp (Dminus j k x))`, `Qop2_rotR` moves $Q$ through the frame change, `Q_Dminus` squares $D^-_x$ to $G_x$, and `Gy_rot` removes the rotation. Each step is hand-checked below.
- **The hypothesis.** $\sum_c$ `vy j k x c` $=0$ is the record's $\sum x=0$ over $a\notin\{j,k\}$ ([second-order.md:1591](../findings/second-order.md)), which is what puts $\nu$ in $V_{jk}\subset\mathcal W_n$: the Ricci entry $(jk)$ of $\nu_x$ is $\sum_ax_a$. It is genuinely consumed: `Dminus_weyl` ([PairSquare.lean:308](../lean/HamiltonsCubic/Results/PairSquare.lean)) needs zero row sums of the weight $uv^{\mathsf T}+vu^{\mathsf T}$, whose row $a$ sums to $u_a\sum v+v_a\sum u=u_a\sum v$, and `Qop2_rotR` ([L219GenOps.lean:51](../lean/HamiltonsCubic/Results/L219GenOps.lean)) is stated only at `IsWeyl2 V` because its proof runs by duality inside $\mathcal W_n$. O1 records that the identity itself survives without it.

## 3. The rotation facts

- **`Rot`** ([PairSquare.lean:76](../lean/HamiltonsCubic/Results/PairSquare.lean)) has columns $Re_j=ce_j+se_k$, $Re_k=-se_j+ce_k$ and fixes the rest, so at $c^2+s^2=1$ it is the rotation of the $(j,k)$-plane by the angle with cosine $c$ and sine $s$. `Rot_orth` derives $RR^{\mathsf T}=1$ from `Rot_diag_fix` at $w=\mathbf 1$ and $R^{\mathsf T}R=1$ from `mul_eq_one_comm`, matching `IsOrth` ([Frames.lean:27](../lean/HamiltonsCubic/Base/Frames.lean)).
- **`Rot_diag_u`.** $R\,\mathrm{diag}(u)R^{\mathsf T}=(Re_j)(Re_j)^{\mathsf T}-(Re_k)(Re_k)^{\mathsf T}$ has $(jj)$ entry $c^2-s^2$, $(kk)$ entry $s^2-c^2$ and $(jk)=(kj)$ entry $cs+sc$, which is $(c^2-s^2)\mathrm{diag}(u)+2cs\,S$. It holds with no constraint on $c,s$, and the Lean statement carries none.
- **`Rot_diag_fix`.** $R\,\mathrm{diag}(w)R^{\mathsf T}$ restricted to the plane is $w_j(c^2+s^2)I_2$ when $w_j=w_k$, so the diagonal is fixed exactly under the stated hypotheses.
- **`rotR_sandOp`** needs no orthogonality: `rotR U V X` $=U\,V(U^{\mathsf T}XU)\,U^{\mathsf T}$ ([FrameOp2.lean:45](../lean/HamiltonsCubic/Results/FrameOp2.lean)), and $U(AU^{\mathsf T}XUB)U^{\mathsf T}=(UAU^{\mathsf T})X(UBU^{\mathsf T})$.
- **`rot45_Dminus`.** `coordOp_rank_two` gives `coordOp (Dminus)` $=$ `sandOp (D_u) (D_v)` (entrywise $(u_av_b+v_au_b)X_{ab}$). At $c=s=\sqrt2/2$, `Rot_diag_u` sends $D_u$ to $S$ ($c^2-s^2=0$, $2cs=1$) and `Rot_diag_fix` fixes $D_v$ ($v_j=v_k=0$), giving `sandOp S D_v` $=$ `nuX`.
- **`uXu_eq_SXS` and `uXS_add` need skewness.** Only the $\{j,k\}$ block is involved. $(D_uXD_u)$ has block $\begin{pmatrix}X_{jj}&-X_{jk}\\-X_{kj}&X_{kk}\end{pmatrix}$ against $SXS$'s $\begin{pmatrix}X_{kk}&X_{kj}\\X_{jk}&X_{jj}\end{pmatrix}$, and $D_uXS+SXD_u$ has block $\begin{pmatrix}X_{jk}+X_{kj}&X_{jj}-X_{kk}\\X_{jj}-X_{kk}&-(X_{jk}+X_{kj})\end{pmatrix}$. Both identities need exactly $X_{kj}=-X_{jk}$ and $X_{jj}=X_{kk}$, which skewness supplies and which a symmetric $X$ with $X_{jk}\ne0$ violates. Their only call site is `sandOp_uu_rot` ([PairSquare.lean:259](../lean/HamiltonsCubic/Results/PairSquare.lean)), at `X.2`, a member of `skewSub`.
- **`sandOp_uu_rot` and `Gy_rot`.** With $\alpha=c^2-s^2$, $\beta=2cs$, the rotated $D_u$ sandwich is $\alpha^2D_uXD_u+\alpha\beta(D_uXS+SXD_u)+\beta^2SXS=(\alpha^2+\beta^2)D_uXD_u=D_uXD_u$. `coordOp_Gy` splits $G$ into `sandOp` $(D_{u^2},D_{v^2})$, $\tfrac12\lVert v\rVert^2$ `sandOp` $(D_u,D_u)$ and $\tfrac12\lVert u\rVert^2$ `sandOp` $(D_v,D_v)$ (`coordOp_vv`: $pp^{\mathsf T}\odot X=D_pXD_p$ is half the sandwich). $u^2=e_j+e_k$, $v^2$ and $v$ have equal $j,k$ entries and are fixed, and the $D_u$ sandwich is fixed although $D_u$ is not. So $G_x$ is fixed by every rotation of the plane, and `Gy_rot` carries no $\sum x=0$.

## Hand-evaluated instance

$n=4$, $j=0$, $k=1$, $x=(\cdot,\cdot,1,-1)$, so $v=(0,0,1,-1)$ and $\sum v=0$.

- Direct from the sandwich at $X=\varphi_{02}=E_{20}-E_{02}$: $SX=-E_{12}$, $SXD_v=-E_{12}$, $D_vXS=E_{20}S=E_{21}$, sum $E_{21}-E_{12}=\varphi_{12}$.
- $\nu_x\varphi_{02}=\varphi_{12}$, $\nu_x\varphi_{12}=\varphi_{02}$, $\nu_x\varphi_{03}=-\varphi_{13}$, $\nu_x\varphi_{13}=-\varphi_{03}$, $\nu_x\varphi_{01}=\nu_x\varphi_{23}=0$.
- $G_x$: $K_{02}=K_{12}=1$, $K_{03}=K_{13}=1$, $K_{01}=-2$, $K_{23}=-2$. Row sums vanish ($-2+1+1=0$ at rows $0,1$, $1+1-2=0$ at rows $2,3$).
- Cross-check through $D^-_x$ ($K_{02}=1$, $K_{12}=-1$, $K_{03}=-1$, $K_{13}=1$) and the diagonal product: $(01)$ entry $A_{02}A_{21}+A_{03}A_{31}=-1-1=-2$, $(23)$ entry $A_{20}A_{03}+A_{21}A_{13}=-2$, $(02)$ entry $A_{02}^2+A_{01}A_{12}+A_{03}A_{32}=1$. It agrees with $G_x$, as `rot45_Dminus` and `Gy_rot` require.
- $\nu_x^2$ is the identity on $\mathop{\mathrm{span}}\{\varphi_{02},\varphi_{12},\varphi_{03},\varphi_{13}\}$, the record's $(\nu^2)_{ja,ja}=x_a^2=1$. $\lVert\nu_x\rVert^2=4=2\lVert x\rVert^2$ and $\lVert G_x\rVert^2=1+1+1+1+4+4=12=3\lVert x\rVert^4$.

## Axioms

`#print axioms`, scratch file, `lake env lean`, exit 0: `Q_nuX`, `rot45_Dminus`, `Gy_rot`, `nuX_phi_ja`, `nuX_phi_ka`, `uXu_eq_SXS`, `uXS_add` each depend on `[propext, Classical.choice, Quot.sound]`. `axiom_audit.py --only PairSquare.lean`: 32/32 clean on the standard three. `#check @Q_nuX` returns the statement quoted in section 2 verbatim.

## Observations

- **O1. The hypothesis $\sum x=0$ is the record's and is consumed, and the identity holds without it** ([PairSquare.lean:348](../lean/HamiltonsCubic/Results/PairSquare.lean)). $Q$ is equivariant under every orthogonal conjugation on all self-adjoint operators, since $R^2$ is and $R^\#$ is built from the bracket, which $X\mapsto UXU^{\mathsf T}$ preserves. `Q_Dminus` carries no hypothesis. So $Q(\nu_x)=G_x$ at every $x$, and the Lean theorem is the record's scope, restricted by `Qop2_rotR`'s Weyl-only statement. An unrestricted `Qop2_rotR` would drop `Dminus_weyl` from the chain. This is an argument, unchecked in Lean.
- **O2. `Q_nuX` proves item 2 on the `nuX` parametrisation only.** Item 2 speaks of every $\nu\in V_{jk}$, and the step "every Weyl operator of character $\varepsilon_j\varepsilon_k$ is some `nuX j k x`" is owed, as the L222 row says. Until it lands, `Q_nuX` cannot be fed into `Sjk_pin` or `crit_pair`, whose $\nu$ is an arbitrary operator of that character.
- **O3. [lean/INDEX.md:152](../lean/INDEX.md) says "Item 2, PROVED", and item 2 has three clauses.** PairSquare proves the first, $\nu\circ\nu=G_x$. The row's own owed list keeps $\lVert G_x\rVert^2=3\lVert x\rVert^4$, so the content is right and the heading overstates. Suggested wording: "Item 2's first clause, PROVED".
- **O4. The L222 row's owed list omits $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$ on the operators.** The row says the norm $\lVert G_x\rVert^2=3\lVert x\rVert^4$ "makes `Sjk_pin`'s pinning unconditional". The pinning needs $\lVert\nu\circ\nu\rVert^2=\tfrac34\lVert\nu\rVert^4$, which takes $\lVert G_x\rVert^2=3\lVert x\rVert^4$, $\lVert\nu_x\rVert^2=2\lVert x\rVert^2$ (the preamble's norm, [second-order.md:1591](../findings/second-order.md)) and the identification of O2, all three. The second is unlisted. The L224 row does list step 1's norm identities.
- **O5. The record's Lean-status notes are stale after a88898d0.** [second-order.md:1589](../findings/second-order.md) still reads "The Lean owes item 1's rotation invariance, item 2, item 4 and item 5", and [second-order.md:1611](../findings/second-order.md) still lists "the second square $\nu_x\circ\nu_x=G_x$ (L222's item 2)" among what the Lean owes. Both should name `Q_nuX` in [PairSquare.lean](../lean/HamiltonsCubic/Results/PairSquare.lean) and keep only the norm and the identification as owed. [lean/INDEX.md:155](../lean/INDEX.md) was updated and is consistent.
- **O6. The L224 row carries state `proved` beside an owed list of six items** ([lean/INDEX.md:155](../lean/INDEX.md)), while the L222 row with a comparable owed list reads `partial`. The state predates a88898d0 (the diff leaves the column untouched), so this commit introduces nothing, but the column reads as a claim about L224 that the row's own text withdraws.
- **O7. The brief's line reference for the L222 row is off by one**: the row is [lean/INDEX.md:152](../lean/INDEX.md), where the brief says 151.

## What would falsify each headline

| Statement | Falsifying object |
|---|---|
| `nuX_phi_ja`, `nuX_phi_ka` | an index $a\notin\{j,k\}$ and $x$ with $\nu_x\varphi_{ja}$ having a nonzero component on some $\varphi_{pq}\ne\varphi_{ka}$, or coefficient $\ne x_a$ on $\varphi_{ka}$ |
| `nuX` is the record's $\nu_x$ | a pair $\varphi_{pq}$ outside $\{\varphi_{ja},\varphi_{ka}\}$ with $\nu_x\varphi_{pq}\ne0$ |
| `rot45_Dminus` | a skew $X$ with `rotR R45 (coordOp (Dminus j k x)) X` $\ne$ `nuX j k x X` |
| `Gy_rot` | $c,s$ with $c^2+s^2=1$ and a skew $X$ where `rotR (Rot j k c s)` moves `coordOp (Gy j k x)` at $X$ |
| `uXu_eq_SXS`, `uXS_add` | a skew $X$ breaking either identity on the $\{j,k\}$ block |
| `Q_nuX` | $x$ with $\sum_{a\notin\{j,k\}}x_a=0$ and a pair $\varphi_{pq}$ with $\langle\varphi_{pq},Q(\nu_x)\varphi_{pq}\rangle\ne(G_x)_{pq}$, or a nonzero off-diagonal entry of $Q(\nu_x)$ in the $\varphi$ basis |
| L222 row, "Item 2, PROVED" | item 2's norm clause, which PairSquare does not state (O3) |
