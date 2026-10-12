# REVIEW r1752: L271Sym.lean against L271 (2), and the L105 row's promotion to proved

**Verdict: CONFIRMED WITH OBSERVATIONS.** Every new L271Sym theorem is faithful to L271 (2) in the pair coordinates, and the bridges to L268's `TorusSystem` and to $F(C,C,C)$ at `torusOp` are exact. The L105 promotion to **proved** stands: every clause of L105's Statement has a typed counterpart at the operator. The observations are about assembly and provenance wording. None of them is a defect in a typed statement.

Scope: [L271Sym.lean](../lean/HamiltonsCubic/Results/L271Sym.lean) as committed at 479ac717, the L271 and L105 rows of [lean/INDEX.md](../lean/INDEX.md) (03a8b3c8, 54a09c5f), [L105Op.lean](../lean/HamiltonsCubic/Results/L105Op.lean) and [L105Eq.lean](../lean/HamiltonsCubic/Results/L105Eq.lean). Sources: Lemma L271 in [second-order.md](../findings/second-order.md) and Lemma L105 in [bounds-relaxations.md](../findings/bounds-relaxations.md). Analysis-only footing: the files were read by hand, and the only runs were two `#print axioms` scratch files through `lake env lean` (about 12 s each). No `lake build` was run.

## Build and axioms

- The L271Sym olean (02:02:59) is newer than the source (02:02:15). The file is imported at line 741 of [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean), and it contains no `sorry` and no `native_decide`.
- `#print axioms` gives `[propext, Classical.choice, Quot.sound]` for `torus_iff_PQSys`, `Ftri_eq_Fpq`, `PQSys_swap`, `Fpq_swap`, `PQSys_sign`, `Fpq_sign`, `Fpq_neg` and `pos_iff`. It gives the same three for `L105_op`, `L105_op_eq`, `L105_op_odd_min` and `L105_mult_conv`.

## (1) PQSys, Fpq and the bridges

- `dPQ` is $\tfrac12\sum_l(P_{il}^2+Q_{il}^2)$. With $P=U+V$ and $Q=U-V$ this equals the record's $d_i=\sum_l(U_{il}^2+V_{il}^2)$, because $(U+V)^2+(U-V)^2=2(U^2+V^2)$ entrywise. `dvec_eq` proves this identity.
- `PQSys` is the record's displayed pair $P_{ij}(1-d_i-d_j-2Q_{ij}^2)=(P^2)_{ij}$ and $Q_{ij}(1-d_i-d_j-2P_{ij}^2)=(Q^2)_{ij}$ for every $i\ne j$.
- `Fpq` is the record's $F$ from (1) term by term: $3\sum A_{ii}d_i$, $-3\sum_{i\ne j}A_{ij}P_{ij}Q_{ij}$, $\tfrac12\operatorname{tr}P^3$ and $\tfrac12\operatorname{tr}Q^3$.
- `torus_iff_PQSys` rewrites `TorusSystem U V` through `L271_pq_system` and `dvec_eq`, so it is unconditional in $U,V$. `Ftri_eq_Fpq` is `Ftri_torus` (with $A$ symmetric and $U,V$ pair weights) rewritten by `dvec_eq`, so $F(C,C,C)$ at $C$ = `torusOp A U V` is `Fpq A (U+V) (U-V)`.
- Falsifier for this part: pair weights $U,V$ with `TorusSystem U V` and `PQSys (U+V) (U-V)` disagreeing, or a symmetric $A$ with $F(C,C,C)\ne$ `Fpq`. The two theorems exclude both.

## (2) The three symmetries

- **$P\leftrightarrow Q$.** `PQSys_swap` exchanges the two equations of each pair, with `dPQ_swap` fixing $d$. `Fpq_swap` holds $A$ fixed, and the cross term $A_{ij}P_{ij}Q_{ij}$ is symmetric in $P,Q$. This is faithful. Falsifier: $(P,Q)$ solving the system with $(Q,P)$ failing it.
- **Sign conjugation.** In `PQSys_sign`, $(SQS)_{ij}=s_is_jQ_{ij}$ and $(SQS)^2=S Q^2 S$ (`conj_sq`), and $d$ is unchanged. The $Q$ equation is multiplied by $s_is_j$, and $(s_is_j)^2=1$ makes the change reversible. `Fpq_sign` conjugates $A$ as well: $A_{ii}$ is fixed, $A_{ij}Q_{ij}$ picks up $(s_is_j)^2=1$, and $\operatorname{tr}(SQS)^3=\operatorname{tr}Q^3$. $P$ is left fixed, as in the record. Falsifier: a sign vector $s$ and a solution $(P,Q)$ with $(P,SQS)$ failing the system, or with $F$ changed.
- **$(A_{\mathrm{off}},Q)\mapsto-(A_{\mathrm{off}},Q)$.** `Fpq_neg`'s $A'$ = `of fun i j => if i = j then A i j else -A i j` negates exactly the off-diagonal part, which is the record's $A_{\mathrm{off}}$. Under the map, $d$ is fixed ($Q^2$), the $A_{ii}d_i$ term is fixed, $(-A_{ij})P_{ij}(-Q_{ij})=A_{ij}P_{ij}Q_{ij}$ is fixed and $\tfrac12\operatorname{tr}(-Q)^3=-\tfrac12\operatorname{tr}Q^3$. So "fixes every term except $\tfrac12\operatorname{tr}Q^3$" is the same statement as "$F\mapsto F-\operatorname{tr}Q^3$". Falsifier: $(A,P,Q)$ with $\mathrm{Fpq}(A',P,-Q)\ne\mathrm{Fpq}(A,P,Q)-\operatorname{tr}Q^3$.
- **O1.** `PQSys` carries only the pair equations. The record's "system" in (2) also includes $A_{ii}=d_i$ and $A_{ij}=-P_{ij}Q_{ij}$. Their invariance under the swap and the sign map is immediate from `dPQ_swap` and `dPQ_sign` together with $s_is_j$ acting on both sides, but it is not typed. Under the record's reading this is harmless, because the $A$ equations determine $A$ and L268_torus_idem already splits them off.

## (3) Positivity

- `pos_iff` is the scalar identity $u,v>0\iff|u-v|<u+v$. At $u=U_{ij}$ and $v=V_{ij}$ it reads $\mu_{\varepsilon_i\mp\varepsilon_j}>0\iff P_{ij}>|Q_{ij}|$, which is the record's translation. Falsifier: reals $u,v$ with the two sides disagreeing. None exist.
- The operator content is in L268: `L268_pd_pos` gives positive definite $\Rightarrow\mu>0$, and `L268_torus_pd` gives $\mu>0$ at $A=A_\mu$ $\Rightarrow$ positive definite. The latter is the record's "the Cartan block $A=A_\mu$ is then positive definite by L268".
- **O2.** No single theorem states "at an idempotent, $C$ is positive definite iff $P_{ij}>|Q_{ij}|$ for all $i\ne j$". It is the conjunction of `L268_torus_idem`, `L268_pd_pos`, `L268_torus_pd` and `pos_iff`. The row calls the "positivity criterion PROVED" and cites only `pos_iff`. It should also name the two L268 halves, since those carry the operator content.
- **O3.** "Which $P\leftrightarrow Q$ does not preserve" is not typed. It is a one-line fact: $P_{ij}>|Q_{ij}|$ and $Q_{ij}>|P_{ij}|$ imply $P_{ij}>Q_{ij}>P_{ij}$. The swap therefore sends every positive solution with $m\ge2$ to a non-positive one. Nothing downstream uses it, so typing it is optional.

## (4) The L271 row

- The row claims only what is typed: the symmetries, `pos_iff` and the two identifications.
- The owed item is stated correctly. `L271_Q_zero` proves that a positive solution with $Q=0$ is the uniform point, but (3)'s "$Q=0$ exactly when coordinate-diagonal" is an identification of operators on $\mathfrak{so}(2m)$ that the Lean layer does not state. The row's gloss ("a torus operator with $U=V$ identified with a coordinate-diagonal one") is accurate. The status stays **partial**, which is correct.

## (5) L105 promoted to proved

Clause-by-clause map of the Statement:

| Clause | Typed as |
|---|---|
| $\theta\le(n-1)w$ and $\theta\le[(n-2)u^2-2uw-w^2]/w$ | `L105_branches` (the tangent branch as $\theta w\le\dots$, equivalent since $w>0$) |
| $\min\{\dots\}\le\theta_0(n)$ | `L105_closing` with `uwN_one`, and `L105_op` gives $\theta\le\theta_0$ at the operator |
| equality in the second inequality $\iff u/w=n/(n-2)$ | `L105_eq_iff` (both branches $\ge\theta_0$ iff $(n-2)u=nw$, which is $\min=\theta_0$ given `L105_closing`) |
| equality exactly at $r=n(n-2)/4$ | `L105_mult`, `L105_mult_conv`, and at the operator `L105_op_eq` with $r$ the card of the $u$-eigenspace |
| $n$ even | `L105_odd` |
| strict at odd $n$ | `L105_op_odd` ($\theta<\theta_0$), `L105_op_odd_min` ($\min<\theta_0$) |

- Nothing in the Statement proper is left untyped. The hypotheses match: unit norm, critical, exactly two values $u>0$ and $-w<0$. The Lean statements need $n\ge3$, which costs nothing, because $N\le1$ at $n\le2$ admits no two-valued spectrum.
- $T_{abc}=c_{abc}^2$ appears in the record's proof route and in *What this supplies*. $r\le8$ at $n=6$ appears in the refutation paragraph under *What this supplies*. Neither is part of the Statement, so bypassing them is fair. The operator proof reads the rows per vector (r1735).
- **O4.** The converse at the operator ($r=n(n-2)/4\Rightarrow\min=\theta_0$) is assembled only through scalars: `mult_rel`, then `L105_mult_conv`, then `L105_eq_iff`. There is no single operator theorem for it, which is acceptable because each link is typed.
- **O5.** Provenance drift. The findings Lean line (03a8b3c8) lists `L105_eq_iff`, `L105_mult`, `L105_odd`, `L105_op_eq` and `L105_op_odd`, but omits `L105_mult_conv` and `L105_op_odd_min`. The INDEX row's file column omits [L105Closing.lean](../lean/HamiltonsCubic/Results/L105Closing.lean), although the row's text links it and relies on `L105_closing`.
- Falsifier for L105: a unit critical Weyl operator on $\mathbb R^n$ with exactly two eigenvalues and $\theta>\theta_0(n)$, or with $\theta=\theta_0(n)$ at $4r\ne n(n-2)$ or at odd $n$. The typed theorems exclude each case.
