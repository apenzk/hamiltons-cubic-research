# REVIEW r1758: SuRep.lean (L283's converse) and L270Op.lean (L270 (4) at every torus-invariant operator), against the record

**Verdict: CONFIRMED WITH OBSERVATIONS.** `su_rep` encodes "supported on $\mathfrak{su}(k)$" correctly: for a self-adjoint $C$ on $\mathfrak{so}(2k)$, vanishing on the $J$-anticommuting bivectors and on $J$ is vanishing on $\mathfrak{su}(k)^\perp=\mathfrak p\oplus\mathbb RJ$, and the conclusion is `torusOp A U 0` with $A$ symmetric, $U$ pair weights and $A\mathbf 1=0$, which is L283's family. `H_su_op` carries L283's bound with `kapE M` $=\kappa_{2M}$ at $k=j+1\le M$, $M\ge7$. `L270_light_op` is L270 (4): $\tfrac12\sum_{i,j}(U_{ij}^2+V_{ij}^2)=\sum_{\alpha>0}\mu_\alpha^2$, and the lightness hypothesis is $\lVert C\rVert^2<\lVert I\rVert^2/c^2$ with $c=2m-2$. All five theorems carry only the standard three axioms. The observations concern what stays prose and the inhabitation of L270 (4)'s hypothesis.

Targets: [SuRep.lean](../lean/HamiltonsCubic/Results/SuRep.lean) (commit ce4179f6), [L270Op.lean](../lean/HamiltonsCubic/Results/L270Op.lean) (commit 98a76967), the definitions `torusOp`, `torusMat`, `Aof`, `Uof`, `Vof`, `rootS`, `cartS`, `IsPairWeights`, `IsIdem`, `IsPD2`, `idOp` in [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean) and [L268Rep.lean](../lean/HamiltonsCubic/Results/L268Rep.lean), `Jm` in [SuTorus.lean](../lean/HamiltonsCubic/Results/SuTorus.lean), `kapE` in [TorusEmbed.lean](../lean/HamiltonsCubic/Results/TorusEmbed.lean), and the L283 and L270 rows of [lean/INDEX.md](../lean/INDEX.md). Source: [findings/second-order.md](../findings/second-order.md), Lemmas L283 and L270. Footing: analysis only. The one computation was a small check file run with `lake env lean` against the built oleans (`#print axioms` and one witness application over the whole family). It took seconds and built nothing.

| Claim | Verdict |
| --- | --- |
| A(i). "Supported on $\mathfrak{su}(k)$" as `hanti` plus `hJ`, for self-adjoint $C$ | CONFIRMED |
| A. `rootS2_anti`: the $\varepsilon_i+\varepsilon_j$ root vector `rootS i j 2` anticommutes with `Jm` | CONFIRMED |
| A. `mulVec_one_of_kills_J`: `torusOp A U V` kills $J$ only if $A\mathbf 1=0$ | CONFIRMED |
| A(ii). `su_rep` states the converse of L283's Statement that *What it gives* reads, with $A$ symmetric, $U$ pair weights, $A\mathbf 1=0$ | CONFIRMED WITH OBSERVATIONS (O1) |
| A(iii). `H_su_op` is L283's bound at $k=j+1\le M$, $M\ge7$, constant $\kappa_{2M}$ | CONFIRMED |
| A(iv). Header: the intrinsic $\mathfrak{su}(k)$ cubic form stays with the record | CONFIRMED WITH OBSERVATIONS (O1) |
| B. `L270_light_op` is L270 (4): weights, lightness, hypotheses | CONFIRMED WITH OBSERVATIONS (O2) |
| Axioms of all five theorems | CONFIRMED, `propext`, `Classical.choice`, `Quot.sound` |
| Witnesses for `su_rep` and `H_su_op` | CONFIRMED, $0$ and every `torusOp A U 0` with $A^{\mathsf T}=A$, $U^{\mathsf T}=U$, $A\mathbf 1=0$ |
| Witness for `L270_light_op` | NONE KNOWN (O2) |
| INDEX rows L283 and L270 | CONFIRMED WITH OBSERVATIONS (O1) |

One line: both files state what the record says, and the only gaps are one prose step the L283 row no longer names and a hypothesis set in L270 (4) that no known object inhabits.

## The record

- **L283, Statement, verbatim:** *"Let $\mathfrak{su}(k)\subset\mathfrak u(k)\subset\mathfrak{so}(2k)$ be the standard embedding, $J$ the complex structure. In L271's coordinates, for $A$ symmetric with $A\mathbf 1=0$ and $U$ symmetric with zero diagonal, the torus-invariant operator `torusOp A U 0` kills every bivector anticommuting with $J$, and its image commutes with $J$ and is orthogonal to $J$, so it is supported on $\mathfrak{su}(k)$. For $M\ge7$ and $k\le M$ it has $F(C)\le\kappa_{2M}\lVert C\rVert^3$."*
- **L283, What it gives, verbatim:** *"These are exactly $\mathfrak{su}(k)$'s torus family, with $\mathfrak{su}(k)$'s own cubic form (batch 15, prose): an operator $C$ on $\mathfrak{su}(k)$ invariant under $SU(k)$'s torus $T'$, extended by zero to $\hat C$, is invariant under $U(k)$'s torus $T=T'Z$, a maximal torus of $SO(2k)$, because the centre $Z$ acts trivially on $\mathfrak u(k)$; it is then `torusOp A U 0` with $A\mathbf1=0$, the roots $\varepsilon_i-\varepsilon_j$ staying distinct on $T'$; and in an orthonormal basis adapted to $\mathfrak{su}(k)\oplus\mathfrak{su}(k)^\perp$ only $\mathfrak{su}(k)$'s own brackets enter $F(\hat C)$, so $F(\hat C)=F_{\mathfrak{su}(k)}(C)$. So for $n\ge14$ and $\mathfrak{su}(k)$ standardly embedded in $\mathfrak{so}(n)$ ($2k\le n$), $M=\lfloor n/2\rfloor$ gives $F_{\mathfrak{su}(k)}(C)\le\kappa_n\lVert C\rVert^3$ on its torus family, $\kappa$ increasing in the dimension, and $\lVert C\rVert^2\ge N/(n-2)^2$ at its torus-invariant idempotents: the standard $\mathfrak{su}(k)$ torus families ask nothing more of H at $n\ge14$. H with $\mathfrak{su}(k)$'s own constant fails on its slice (batch 1), consistently, since H at $n$ asks only for the ambient one. The argument needs $\mathfrak h$'s torus and its centraliser's to fill a maximal torus of an $\mathfrak{so}(n')\supseteq\mathfrak h$; $\mathfrak{sp}(k)\subset\mathfrak{so}(4k)$, $k\ge2$, and $\mathfrak g_2\subset\mathfrak{so}(7)$ fail that count and stay open."*
- **L270 (4), verbatim:** *"On the torus family of L268, a positive-definite idempotent lighter than $I/c$ has $\sum_\alpha\mu_\alpha^2<\tfrac m{4(m-1)}$, the value at $I/c$."* The surrounding Statement fixes $\mathfrak h$ compact simple with $I\#I=cI$, $d=\dim\mathfrak h$, and $C\ne I/c$ a positive-definite $\#$-idempotent.

## A(i): the encoding of "supported on su(k)"

- **The complement.** Conjugation $X\mapsto JXJ^{-1}=-JXJ$ is an involutive isometry of $\mathfrak{so}(2k)$ for $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$, since $J$ is orthogonal. Its $+1$ eigenspace is $\mathfrak u(k)=\{XJ=JX\}$ and its $-1$ eigenspace is $\mathfrak p=\{XJ=-JX\}$, and eigenspaces of an isometric involution are orthogonal. So $\mathfrak{so}(2k)=\mathfrak u(k)\oplus\mathfrak p$ orthogonally.
- Inside $\mathfrak u(k)$, $J$ is central and $\mathfrak{su}(k)=\mathfrak u(k)\cap J^\perp$ (the complex trace of $X\in\mathfrak u(k)$ is a multiple of $\mathop{\mathrm{tr}}(JX)$), so $\mathfrak u(k)=\mathfrak{su}(k)\oplus\mathbb RJ$. Hence $\mathfrak{su}(k)^\perp=\mathfrak p\oplus\mathbb RJ$, exactly the two pieces. $\mathfrak p$ is a linear subspace, so "kills every $X$ with $XJ=-JX$" is "kills $\mathfrak p$".
- For self-adjoint $C$, vanishing on $\mathfrak{su}(k)^\perp$ is equivalent to $\mathop{\mathrm{im}}C\subseteq\mathfrak{su}(k)$, and $C$ is then determined by its restriction to $\mathfrak{su}(k)$. So `hanti` with `hJ` and `hsa` is the record's "supported on $\mathfrak{su}(k)$", and matches the Statement's forward form (kills $\mathfrak p$, image commutes with $J$ and is orthogonal to $J$).
- **`Jm` is $J$.** `Jm (p,q) = if p.1 = q.1 then J2 p.2 q.2 else 0` with `J2 1 0 = 1`, `J2 0 1 = -1`, and `cartS k = phi (k,0) (k,1)` has entry $+1$ at $((k,1),(k,0))$ and $-1$ at $((k,0),(k,1))$. So `Jm` $=\sum_k$ `cartS k`, the record's $J=\sum_p h_p$.

## A(ii): su_rep's conclusion

- `L268_rep` gives $C=$ `torusOp (Aof C) (Uof C) (Vof C)` with `Aof C` symmetric and `Uof C`, `Vof C` pair weights. `Vof C i j` is $\langle C\,r,r\rangle$ at the unit $\varepsilon_i+\varepsilon_j$ root vector $r=$ `rootS i j 2` $=\tfrac1{\sqrt2}(\varphi_{(i,0)(j,0)}-\varphi_{(i,1)(j,1)})$. That vector anticommutes with $J$ (`rootS2_anti`, and by hand: $J$ rotates each plane by $+90°$, and the difference of the two parallel wedges picks up opposite signs), so `hanti` kills it and $V=0$.
- `torusMat` on the Cartan block maps $X$ to $\sum_k A_{pk}X_{(k,1)(k,0)}$ times $J_2$ in plane $p$, so $C J=\sum_p(A\mathbf 1)_p\,h_p$, and $CJ=0$ is $A\mathbf 1=0$ (`mulVec_one_of_kills_J`).
- The conclusion `C = torusOp (Aof C) (Uof C) 0 ∧ (Aof C)ᵀ = Aof C ∧ IsPairWeights (Uof C) ∧ (Aof C).mulVec 1 = 0` is the record's family: $A$ symmetric with $A\mathbf 1=0$, $U$ symmetric with zero diagonal, $V=0$. CONFIRMED.
- **What su_rep takes as hypothesis that *What it gives* derives (O1).** `hT` is invariance under every `cartS x`, the full torus $T$ of $SO(2k)$. The record starts from $SU(k)$'s torus $T'$ and an operator on $\mathfrak{su}(k)$, and passes to $T$ and $\mathfrak{so}(2k)$ by extension by zero and the centre acting trivially. That step is sound: on $\mathfrak u(k)$, $\mathop{\mathrm{ad}}_J=0$ and $\hat C$ maps into $\mathfrak{su}(k)\subseteq\ker\mathop{\mathrm{ad}}_J$, and on $\mathfrak p$, $\hat C=0$ with $[J,\mathfrak p]\subseteq\mathfrak p$, so $[\mathop{\mathrm{ad}}_J,\hat C]=0$, and $\mathop{\mathrm{Lie}}(T')+\mathbb RJ=\mathop{\mathrm{Lie}}(T)$. It stays prose, which the header's "Inside $\mathfrak{so}(2k)$" says and the edited INDEX row no longer names.

## A(iii): H_su_op against the bound

- $\kappa_{2M}=\tfrac{2M-2}{\sqrt{\dim\mathfrak{so}(2M)}}=\tfrac{2(M-1)}{\sqrt{M(2M-1)}}$, and `kapE M` is `2 * (M - 1) / √(M * (2M - 1))`. Equal.
- `Ftri C C C ≤ kapE M * normSq2 C ^ (3/2)` is $F(C)\le\kappa_{2M}\lVert C\rVert^3$ in the layer's normalisation, the one `H_su_slice` already carries (r1727, r1728). Ranges: `7 ≤ M`, `j + 1 ≤ M` with $k=j+1\ge1$, the record's $M\ge7$, $k\le M$. At $k=1$ the hypotheses force $C=0$ ($\mathfrak{so}(2)=\mathbb RJ$), harmless.
- The proof rewrites by `su_rep` and applies `H_su_slice`, so `H_su_op` is L283's bound over every operator supported on $\mathfrak{su}(k)$ rather than only over the parametrised family. CONFIRMED.

## A(iv): the header's residual

- A search of the layer for an intrinsic $\mathfrak{su}(k)$ found none: [ValueIndex.lean](../lean/HamiltonsCubic/Results/ValueIndex.lean) names the $(\mathfrak{su}(k),\mathfrak{so}(k))$ family in prose only. So $F(\hat C)=F_{\mathfrak{su}(k)}(C)$ is prose, as the header says. Accurate.
- The header's last paragraph lists only the cubic form as staying with the record. The $T'\to T$ extension step of A(ii) is the second prose residue (O1). The header's own "Inside $\mathfrak{so}(2k)$" covers it implicitly.

## B: L270_light_op

- **Weights.** `Uof C i j` and `Vof C i j` are the Gram values of $C$ at the unit root vectors of $\varepsilon_i-\varepsilon_j$ and $\varepsilon_i+\varepsilon_j$ ($\lVert$`rootS`$\rVert=1$ since $\langle\varphi_p,\varphi_p\rangle=1$ and the two wedges are orthogonal), which by `L268_rep` are the eigenvalues $\mu_\alpha$ on the root planes. Both are symmetric with zero diagonal, so $\tfrac12\sum_{i,j}(U_{ij}^2+V_{ij}^2)=\sum_{i<j}(U_{ij}^2+V_{ij}^2)=\sum_{\alpha>0}\mu_\alpha^2$ over the $m(m-1)$ positive roots.
- **Threshold.** At $I/c$ with $c=n-2=2m-2$ (`sharpMapCL_id`), every $\mu_\alpha=1/(2m-2)$ and $\sum_{\alpha>0}\mu_\alpha^2=m(m-1)/(4(m-1)^2)=m/(4(m-1))$. Matches the conclusion's right side.
- **Lightness.** $\lVert I/c\rVert^2=\lVert I\rVert^2/c^2$ = `normSq2 idOp / (2 * (m - 1))^2`, with $\lVert I\rVert^2=d=m(2m-1)$. `hlight` is strict, so $C\ne I/c$ is implied, as the record's Statement requires.
- **Hypotheses.** `hm : 3 ≤ m` is L268's range, $\mathfrak{so}(2m)$ simple. `hT` is torus invariance, `hsa` is membership in $\mathop{\mathrm{Sym}}^2$, `IsIdem` is $C\#C=C$ with the layer's `sharpMapCL`, `IsPD2` is positive definite on $\Lambda^2$. Together they are "a positive-definite idempotent on the torus family of L268". The proof routes through `L268_full` to the slice `torusOp (Amu U V) U V` and applies the previously proved `L270_torus_light`. CONFIRMED.

## Axioms and witnesses

- `#print axioms` on `rootS2_anti`, `mulVec_one_of_kills_J`, `su_rep`, `H_su_op`, `L270_light_op`: each `[propext, Classical.choice, Quot.sound]`.
- **su_rep, H_su_op.** The check file applied `su_rep` to `torusOp A U 0` for arbitrary $A^{\mathsf T}=A$, $U^{\mathsf T}=U$, $A\mathbf 1=0$, discharging the hypotheses with `derOp_torusOp`, `torusOp_isSelfAdjoint2`, `torusOp_kills_anti` and `torusOp_kills_J`. It elaborated. The zero operator is its case $A=U=0$. A nonzero instance: $A=0$, $U_{ij}=1$ for $i\ne j$, $k\ge2$. The hypothesis set is the whole of L283's family, so the theorems are non-vacuous.
- **L270_light_op (O2).** $0$ fails `IsPD2`. $I/c$ meets every hypothesis except `hlight`, where it sits at equality (and then the conclusion holds with equality). No object is known that meets `hlight`: every torus solution the record computed at $m=4,5$ is heavier than $I/c$ (L270, *What it gives*). The hypothesis set being empty is the norm form of the record's target U$_{\mathrm s}'$ on the torus family, so the theorem is an a priori confinement ($y<y_0$) of an object whose existence is open, which is what the record claims for (4).

## INDEX rows

- **L283.** Adds SuRep.lean and states `su_rep` and `H_su_op` accurately. The old row named the identification "these are all of $\mathfrak{su}(k)$'s torus-invariant operators" as prose. The new row retires that clause entirely and keeps only the cubic form as prose. Within $\mathfrak{so}(2k)$ the retirement is right. The passage from $T'$-invariant operators on $\mathfrak{su}(k)$ to $T$-invariant operators on $\mathfrak{so}(2k)$ is still prose and unnamed (O1).
- **L270.** Adds L270Op.lean and states `L270_light_op` accurately. Status stays **partial** because (3)'s reduction to simple subalgebras is prose. Consistent.

## Overall verdict: CONFIRMED WITH OBSERVATIONS

1. **O1 (INDEX L283 row and SuRep.lean header).** The step from an $SU(k)$-torus-invariant operator on $\mathfrak{su}(k)$ to its zero extension being invariant under $SO(2k)$'s torus is prose in *What it gives* and is a hypothesis (`hT`) in `su_rep`. The step is sound (argument in A(ii)). The INDEX row should name it next to the cubic form as what stays prose, for example "the passage from $T'$ on $\mathfrak{su}(k)$ to $T$ on $\mathfrak{so}(2k)$ and the equality with $\mathfrak{su}(k)$'s own cubic form stay prose".
2. **O2 (L270_light_op).** No object is known to meet `hlight` together with idempotence and positive definiteness, and the record's target asks that none exist. The theorem is correct as a conditional and matches (4). A reader should read it as a confinement, not as evidence that light idempotents exist.

**What would falsify each statement.**

- `rootS2_anti`: a pair $i\ne j$ with $r_{ij}^+J\ne-Jr_{ij}^+$.
- `mulVec_one_of_kills_J`: $A$ with $A\mathbf 1\ne0$ and `torusOp A U V J = 0`.
- `su_rep`: a torus-invariant self-adjoint $C$ on $\mathfrak{so}(2k)$ killing $\mathfrak p\oplus\mathbb RJ$ with a nonzero $\varepsilon_i+\varepsilon_j$ weight or $A\mathbf 1\ne0$. As a fidelity claim: a vector in $\mathfrak{su}(k)^\perp$ outside $\mathfrak p\oplus\mathbb RJ$, which A(i) excludes.
- `H_su_op`: $C$ supported on $\mathfrak{su}(k)$, $k\le M$, $M\ge7$, with $F(C)>\kappa_{2M}\lVert C\rVert^3$.
- `L270_light_op`: a torus-invariant positive-definite idempotent with $\lVert C\rVert^2<d/c^2$ and $\sum_{\alpha>0}\mu_\alpha^2\ge m/(4(m-1))$.
