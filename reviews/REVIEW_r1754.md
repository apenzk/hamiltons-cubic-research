# REVIEW r1754: L268Rep.lean, L268 and L271 (3) at the operator

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every theorem in [L268Rep.lean](../lean/HamiltonsCubic/Results/L268Rep.lean) says what [findings/second-order.md](../findings/second-order.md) Lemma L268 and Lemma L271 (3) say, the six headline theorems rest on the standard three axioms only, and r1753's O2, O3 and O5 are closed. The observations are an inert $m\ge3$, a loose docstring on the $V$ pairs, and (4)'s hypothesis still reached by a two-step chain rather than one theorem.

Target: [L268Rep.lean](../lean/HamiltonsCubic/Results/L268Rep.lean) (commit 6a9384b6) and the L268 and L271 rows of [lean/INDEX.md](../lean/INDEX.md). Definitions read in [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean). Footing: analysis only. The single computation was one `lake env lean` run of a throwaway check file (about 8 seconds against the built olean, nothing rebuilt), deleted afterwards.

| Claim | Verdict |
| --- | --- |
| `plane_const`: $T$-invariance makes $\langle Cr,r\rangle$ equal on the two unit vectors of each root plane | CONFIRMED |
| `L268_rep`: a $T$-invariant symmetric $C$ is $A\oplus\bigoplus_\alpha\mu_\alpha I_{R_\alpha}$, with $A$ symmetric and $U,V$ pair weights | CONFIRMED |
| `L268_full`: such a $C$ is a positive-definite idempotent exactly when $A=A_\mu$ and $\mu>0$ solves the system | CONFIRMED |
| `others`, `sum_split3`: $\sum_l f_l=f_i+f_j+\sum_{l\notin\{i,j\}}f_l$ | CONFIRMED |
| `RootDisplay`, `display_iff`: `TorusSystem` is the record's per-root display, for $\alpha=\varepsilon_i-\varepsilon_j$ and $\alpha=\varepsilon_i+\varepsilon_j$ | CONFIRMED |
| `ek`, `Amu_roots`: $A_\mu=2\sum_\alpha\mu_\alpha^2u_\alpha u_\alpha^{\mathsf T}$ | CONFIRMED |
| `torusMat_scale`, `torusOp_scale`: `torusOp` is homogeneous in $(A,U,V)$ | CONFIRMED |
| `L271_Q_zero_op`: a positive-definite idempotent `torusOp A U U` is $I/(2(m-1))$ | CONFIRMED |
| `L271_other_idem`: every other $T$-invariant symmetric positive-definite idempotent has $U_{ij}\ne V_{ij}$ for some pair | CONFIRMED |
| INDEX L268 row, partial to proved | CONFIRMED |
| INDEX L271 row, "`L271_other_idem` gives $Q\ne0$" for (4) | CONFIRMED (as a chain, O3) |

One line: L268 and L271 (3) are now typed as single operator statements over every torus-invariant symmetric operator, faithful to the record.

## (1) T-invariance, symmetry and the representation

- **T-invariance.** The hypothesis `∀ x, derOp (cartS x) C = 0` says $[\mathop{\mathrm{ad}}_{J_x},C]=0$ for each Cartan basis vector $J_x=\varphi_{(x,0)(x,1)}$. The condition is linear in the Lie algebra element, so it holds on all of $\mathfrak t=\mathop{\mathrm{span}}(J_x)$. The torus is connected and equals $\exp\mathfrak t$, so commuting with $\mathop{\mathrm{ad}}_{\mathfrak t}$ is equivalent to commuting with $\mathop{\mathrm{Ad}}_T$. The encoding is faithful. The record's "a maximal torus" is the coordinate torus up to conjugation, and every maximal torus of $SO(2m)$ is conjugate to it, so fixing it loses nothing.
- **Symmetry.** `hsa` is $\langle CX,Y\rangle=\langle X,CY\rangle$ for `inner2`, the invariant inner product on $\Lambda^2=\mathfrak{so}(2m)$. That is the record's "symmetric".
- **The conclusion.** `C = torusOp (Aof C) (Uof C) (Vof C)`, and `torusOp_cartS` gives $C J_k=\sum_l A_{lk}J_l$ (so $A$ is the Cartan block in the orthonormal basis $J_k$), while `torusOp_rootS` gives $C r_{ijt}=U_{ij}r_{ijt}$ for $t=0,1$ (the plane of $\varepsilon_i-\varepsilon_j$) and $V_{ij}r_{ijt}$ for $t=2,3$ (the plane of $\varepsilon_i+\varepsilon_j$). The $J_k$ and $r_{ijt}$ with $i<j$ span $\mathfrak{so}(2m)$ ($m+4\binom m2=m(2m-1)$), so this is exactly $C=A\oplus\bigoplus_\alpha\mu_\alpha I_{R_\alpha}$. The side conclusions $A^{\mathsf T}=A$ and `IsPairWeights` (symmetric, zero diagonal) are the record's "symmetric $m\times m$ matrices with zero diagonal". `Aof`, `Uof`, `Vof` read Gram values on unit vectors (`rootS_norm`), so they are the record's $A$, $\mu_\alpha$ with no normalisation factor.
- **Hypotheses.** Both are used: `hT` in `plane_const` and in the torus-invariance of $C-T$, `hsa` in $A$'s symmetry and in `torus_op_zero`. `L268_rep` carries no $m\ge3$ and holds for every $m$, which is stronger than the record and harmless.

## (2) L268_full

- The left side is `IsIdem C ∧ IsPD2 C`, positive-definite $\#$-idempotent. The right side is `Aof C = Amu`, `TorusSystem`, and $U_{ij},V_{ij}>0$ for $i\ne j$, which is "$A=A_\mu$ and $\mu>0$ solves the system" once `Amu_roots` and `display_iff` identify the two forms (sections 3 and 4).
- The only hypothesis beyond the record's objects is $m\ge3$, which is the record's. It is inert: `L268_torus_idem` passes to `L268_torus_idem_core`, which has none, and the body of `L268_torus_pd` never mentions `hm` (O1).
- The ⇐ direction needs positive definiteness from $\mu>0$ at $A=A_\mu$, supplied by `L268_torus_pd`. The ⇒ direction reads positivity off the unit root vectors (`L268_pd_pos`). Neither side adds a condition the record lacks.

## (3) Amu_roots by hand

For $\alpha=\varepsilon_i\mp\varepsilon_j$, $u_\alpha=(e_i\mp e_j)/\sqrt2$, so $2\mu_\alpha^2u_\alpha u_\alpha^{\mathsf T}=\mu_\alpha^2(e_i\mp e_j)(e_i\mp e_j)^{\mathsf T}$. Each positive root appears as the ordered pairs $(i,j)$ and $(j,i)$ with the same weight (symmetry of $U,V$) and the same rank-one matrix (the sign flip squares away), and the $i=j$ terms vanish because $U_{ii}=V_{ii}=0$. So $2\sum_\alpha\mu_\alpha^2u_\alpha u_\alpha^{\mathsf T}=\tfrac12\sum_{i,j}\big(U_{ij}^2(e_i-e_j)(e_i-e_j)^{\mathsf T}+V_{ij}^2(e_i+e_j)(e_i+e_j)^{\mathsf T}\big)$, which is the Lean right side entrywise with `ek i k` $=(e_i)_k$.

- **Diagonal $k=l$.** $(\delta_{ik}\mp\delta_{jk})^2$ is $1$ when exactly one of $i,j$ is $k$. The two ordered positions give $\tfrac12\cdot2\sum_l(U_{kl}^2+V_{kl}^2)=d_k$, which is `Amu`'s diagonal.
- **Off the diagonal $k\ne l$.** $(\delta_{ik}-\delta_{jk})(\delta_{il}-\delta_{jl})=-1$ at $(i,j)=(k,l),(l,k)$ and $0$ otherwise, and the $+$ version is $+1$ there. The sum is $\tfrac12(2V_{kl}^2-2U_{kl}^2)=V_{kl}^2-U_{kl}^2$, which is `Amu`'s off-diagonal entry.

## (4) RootDisplay and display_iff

- **Neighbours.** For $\alpha=\varepsilon_i\pm\varepsilon_j$ the positive roots with $\langle\alpha,\beta\rangle=\pm1$ are exactly those sharing one index with $\alpha$ and having one index $l\notin\{i,j\}$: $\varepsilon_i\pm\varepsilon_l$, $\varepsilon_j\pm\varepsilon_l$, four per $l$, $4(m-2)$ in all. The other root on $\{i,j\}$ is orthogonal to $\alpha$, and roots disjoint from $\{i,j\}$ are orthogonal. `RootDisplay`'s $\sum_{l\in\text{others}}(U_{il}^2+V_{il}^2+U_{jl}^2+V_{jl}^2)$ is that sum, the same set for both roots of the pair.
- **Pairs for $\alpha=\varepsilon_i-\varepsilon_j$ (weight $U$).** $(\varepsilon_i-\varepsilon_l)+(\varepsilon_l-\varepsilon_j)=\alpha$ with weight $U_{il}U_{lj}$, and $(\varepsilon_i+\varepsilon_l)-(\varepsilon_j+\varepsilon_l)=\alpha$ with weight $V_{il}V_{jl}=V_{il}V_{lj}$. Two per $l$, $2(m-2)$ in all, summing to $\sum_l(U_{il}U_{lj}+V_{il}V_{lj})$. Matches.
- **Pairs for $\alpha=\varepsilon_i+\varepsilon_j$ (weight $V$).** $(\varepsilon_i-\varepsilon_l)+(\varepsilon_j+\varepsilon_l)=\alpha$ with weight $U_{il}V_{lj}$, and $(\varepsilon_i+\varepsilon_l)+(\varepsilon_j-\varepsilon_l)=\alpha$ with weight $V_{il}U_{lj}$. (Up to sign the second is also a difference, $(\varepsilon_i+\varepsilon_l)-(\varepsilon_l-\varepsilon_j)$, the same unordered pair, counted once.) Two per $l$, summing to $\sum_l(U_{il}V_{lj}+V_{il}U_{lj})$. Matches. No pair whose sum or difference is $\pm\alpha$ uses a root disjoint from $\{i,j\}$ or a root on $\{i,j\}$ itself, since the $l$-components must cancel.
- **The algebra.** With $d_i=U_{ij}^2+V_{ij}^2+N_i$ and $d_j=U_{ij}^2+V_{ij}^2+N_j$, the $U$ equation of `TorusSystem`, $U(1-d_i-d_j+2(V^2-U^2))=(U^2+V^2)_{ij}$, becomes $U(1-4U^2-N_i-N_j)=\sum_l(U_{il}U_{lj}+V_{il}V_{lj})$, the display. The $V$ equation's $-2(V^2-U^2)$ gives $1-4V^2-N$ in the same way. The coefficient $4\mu_\alpha^3$ is the record's.
- **Docstring.** `RootDisplay`'s docstring names the pairs $(\varepsilon_i\mp\varepsilon_l,\varepsilon_l\mp\varepsilon_j)$ for both roots, which fits the $U$ equation. The $V$ equation's pairs are $(\varepsilon_i\mp\varepsilon_l,\varepsilon_l\pm\varepsilon_j)$ with opposite signs. The formula is right and only the comment is loose (O2).

## (5) L271_Q_zero_op and L271_other_idem

- **$I/c$.** L268's uniform clause fixes $c=2(m-1)$, and `idOp` on `Fin m × Fin 2` is $I$ on $\mathfrak{so}(2m)$, so `(1 / (2 * ((m : ℝ) - 1))) • idOp` is the record's $I/c$. It is a genuine idempotent: $I\#I=(2m-2)I$ (`sharpMapCL_id`), so $(sI)\#(sI)=s^2(2m-2)I=sI$ at $s=1/(2m-2)$. The exclusion in `L271_other_idem` is therefore of a real member of the family.
- **`L271_Q_zero_op`** is "the only positive solution with $Q=0$ is $I/c$" at the operator: `torusOp A U U` is $Q=0$, and positive-definite idempotent is "positive solution" by `L268_full`. $A$ is arbitrary symmetric and is forced to $\tfrac1c I$ inside the proof, so no hypothesis restricts it. $m\ge3$ is used here (through `L271_Q_zero` and $m-1\ne0$).
- **`L271_other_idem`** is the record's third clause: its hypotheses are $T$-invariance at the operator, symmetry, idempotence and positive definiteness, and $C\ne I/c$, and it concludes $\mu_{\varepsilon_i+\varepsilon_j}=V_{ij}\ne U_{ij}=\mu_{\varepsilon_i-\varepsilon_j}$ for some $i\ne j$. Torus invariance is now `derOp`, so it covers every torus-invariant operator and not only `torusOp` data.
- **r1753.** O2 (the second clause typed only in parts) is closed by `L271_Q_zero_op`. O3 (the third clause untyped) is closed by `L271_other_idem`. O5 (the row overstating) is closed by the row now naming both theorems. r1753's O4 is reduced, not closed (O3 below).

## (6) Axioms

`#print axioms` on `L268_rep`, `L268_full`, `display_iff`, `Amu_roots`, `L271_Q_zero_op`, `L271_other_idem`, and also `plane_const` and `torusOp_scale`: each depends on `[propext, Classical.choice, Quot.sound]` only. No `sorryAx`, no `Lean.ofReduceBool`.

## (7) A witness for L268_rep

`idOp` meets both hypotheses: `derOp (cartS x) idOp` is $\mathop{\mathrm{ad}}_{J_x}-\mathop{\mathrm{ad}}_{J_x}=0$, and self-adjointness is `rfl`. The check file applied `L268_rep idOp` and it typechecked. By hand the returned data are $A_{lk}=\langle J_k,J_l\rangle=\delta_{kl}$ (the $J_k$ are orthonormal), $U_{ij}=V_{ij}=\lVert r_{ijt}\rVert^2=1$ for $i\ne j$ with zero diagonal, so the theorem returns `idOp = torusOp 1 (onesOff m) (onesOff m)`, which is `idOp_eq_torusOp`. `L268_full` on `idOp` returns false on both sides at $m\ge3$, as it must, since $I\#I=(2m-2)I\ne I$.

## (8) The INDEX rows

- **L268**, partial to proved. The row names `L268_rep`, `L268_full`, `Amu_roots` and `display_iff` with the statements they carry, and together with `L268_uniform_iff` every clause of the record's statement is typed. The promotion stands.
- **L271**, the new sentence on (3)'s second and third clauses is accurate.
- **"`L271_other_idem` gives $Q\ne0$, so $C_Q\ne0$, and $C_P\ne0$ follows as above".** True as mathematics. `L271_other_idem` concludes `Uof C i j ≠ Vof C i j`. `L271_eigen`'s hypotheses are `0 < normSq2 CQ` and `0 < normSq2 CP` over `torusOp (Amu U V) U V`. Getting there needs `L268_rep` and `L268_full` to put $C$ in that form, then `innerOp2_torusOp` to turn $Q_{ij}\ne0$ into $\lVert C_Q\rVert^2\ge\tfrac12Q_{ij}^2>0$. Those links are all typed, and the assembly is prose (O3).

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.**

- **O1: $m\ge3$ is inert in `L268_full`.** Both routes it feeds, `L268_torus_idem` (through `_core`) and `L268_torus_pd`, leave it unused. It is the record's hypothesis and harmless. r1753 O1 already recorded the same for `L268_torus_idem`.
- **O2: `RootDisplay`'s docstring on the $V$ pairs.** It writes the pairs as $(\varepsilon_i\mp\varepsilon_l,\varepsilon_l\mp\varepsilon_j)$ for both roots. For $\alpha=\varepsilon_i+\varepsilon_j$ they are $(\varepsilon_i\mp\varepsilon_l,\varepsilon_l\pm\varepsilon_j)$. The formula is correct.
- **O3: (4)'s $C_P,C_Q\ne0$ at $C\ne I/c$ is a typed chain, not one theorem.** The INDEX sentence is true, and a short corollary (a $T$-invariant symmetric positive-definite idempotent $C\ne I/c$ gives `0 < normSq2 CQ` and `0 < normSq2 CP` for its `Uof`, `Vof`) would make it literal and close r1753 O4.
- **O4: `hsa` in `L271_other_idem` may be derivable.** $C\#C$ is self-adjoint for any $C$ in this layer if `sharpMapCL` symmetrises, so an idempotent would be self-adjoint automatically. Not checked. The record's family is symmetric operators, so the hypothesis matches the record either way.

## What would falsify each statement

- `plane_const`: a $T$-invariant operator with $\langle Cr_{ij0},r_{ij0}\rangle\ne\langle Cr_{ij1},r_{ij1}\rangle$.
- `L268_rep`: a symmetric operator commuting with every $\mathop{\mathrm{ad}}_{J_x}$ that mixes two root planes or a root plane with $\mathfrak t$.
- `L268_full`: a torus-invariant symmetric positive-definite idempotent whose Cartan block differs from $A_\mu$, or a positive solution of the system with $A=A_\mu$ that fails to be idempotent or positive definite.
- `display_iff`: pair weights $(U,V)$ satisfying one of `TorusSystem` or `RootDisplay` and not the other.
- `Amu_roots`: pair weights where one entry of $A_\mu$ differs from $\tfrac12\sum_{i,j}(\dots)$.
- `torusOp_scale`: $(c,A,U,V)$ with $\mathop{\mathrm{torusOp}}(cA,cU,cV)\ne c\mathop{\mathrm{torusOp}}(A,U,V)$.
- `L271_Q_zero_op`: a positive-definite idempotent `torusOp A U U` other than $I/(2(m-1))$ at some $m\ge3$.
- `L271_other_idem`: a torus-invariant symmetric positive-definite idempotent $C\ne I/(2(m-1))$ with $U_{ij}=V_{ij}$ on every pair.
