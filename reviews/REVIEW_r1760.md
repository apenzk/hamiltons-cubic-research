# REVIEW r1760: L263Ideal.lean (the L263 witness is no ideal sum), against the record

**Verdict: CONFIRMED WITH OBSERVATIONS.** `L263_not_ideal_sum` is a strictly stronger form of "C is not $\bigoplus_i\Pi_i/c_i$ over $\mathfrak h$'s simple ideals": it excludes every family of mutually annihilating idempotents with bracket-closed, pairwise commuting ranges that covers $\mathfrak h$, with any weights, and the projections onto the simple ideals of $\mathfrak h$ (extended by zero off $\mathfrak h$) are one such family. The hypotheses are jointly satisfiable apart from the equation for $C$, so the theorem has content, and the near-miss family $(P_{\mathfrak{su}(3)},P_{\mathfrak p})$ shows the bracket hypotheses carry it. `br13` agrees with a hand computation from `gv`. The observations concern the scope item the header and INDEX row leave to the record, which is narrower than stated, one unnamed reading of $\#$, and an understatement in `eigen_bracket`'s description.

Targets: [L263Ideal.lean](../lean/HamiltonsCubic/Results/L263Ideal.lean) at commit 91b441ed, extended at the coordinator's request to its additions in commit 1a9af9df (`inner_br`, `isoK`, `isoP`, `iso_single`, `iso_ne`, `center_zero`) and the L263 INDEX row as edited there, the definitions `gv`, `gf6`, `gn`, `gop`, `lamC`, `lamP`, `su3idx`, `L263_witness`, `L263_g2` in [I117G2.lean](../lean/HamiltonsCubic/Results/I117G2.lean), `phi` and `br` in [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), `brS` and `CurvOp2` in [Bivectors2.lean](../lean/HamiltonsCubic/Base/Bivectors2.lean), `rk1` in [I117Four.lean](../lean/HamiltonsCubic/Results/I117Four.lean), and the L263 row of [lean/INDEX.md](../lean/INDEX.md) as edited in 91b441ed. Source: [findings/second-order.md](../findings/second-order.md), Lemmas L263 and L260. Footing: analysis only. The one computation was a small check file run with `lake env lean` against the built oleans (`#print axioms` on three theorems), seconds in length.

| Claim | Verdict |
| --- | --- |
| Q1(a). `L263_not_ideal_sum` reads "C is not $\bigoplus_i\Pi_i/c_i$ over $\mathfrak h$'s simple ideals" and is strictly stronger | CONFIRMED |
| Q1(b). The hypotheses describe decompositions of $\mathfrak h$ into ideals faithfully, and dropping self-adjointness and "range inside $\mathfrak h$" strengthens the theorem without making it vacuous | CONFIRMED |
| Q1(c). `hcov`, $\sum_i\Pi_i(g_k)=g_k$ for every $k$, is the right "covers $\mathfrak h$" | CONFIRMED |
| Q2. "U fails on $\mathfrak h$" still needs $\mathfrak h$ compact semisimple, and positive definiteness of $C$ on $\mathfrak h$ comes from `L263_g2` | CONFIRMED WITH OBSERVATIONS (O1, O2) |
| Q3. `br13`: $[g_1,g_3]=3g_4-2g_5$, with $4\in$ `su3idx` and $1,3,5\notin$ `su3idx` | CONFIRMED |
| Q4. Axioms of `L263_not_ideal_sum` | CONFIRMED, `propext`, `Classical.choice`, `Quot.sound` |
| Q5. A family meeting every hypothesis but the equation for $C$ exists, and no weights complete it | CONFIRMED |
| Q6. INDEX L263 row as edited | CONFIRMED WITH OBSERVATIONS (O1, O3) |
| E(a). `center_zero` (commit 1a9af9df) is the trivial-centre claim for $\mathfrak h=\mathop{\mathrm{span}}(g_k)$ | CONFIRMED |
| E(b). "A subalgebra of the compact $\mathfrak{so}(7)$ with trivial centre is semisimple" is the right remaining step for U's scope | CONFIRMED |
| E(c). Axioms of `center_zero` | CONFIRMED, `propext`, `Classical.choice`, `Quot.sound` |

One line: the theorem refutes U on $\mathfrak h$ for every ideal decomposition and every weighting, and what stays with the record is the standard step from trivial centre to semisimplicity (after 1a9af9df) and the identification of $\mathfrak h$'s own $\#$ with $\mathfrak{so}(7)$'s.

## The record

- **L263 Statement, verbatim:** *"Let $\mathfrak g=\mathfrak k\oplus\mathfrak p$ inside a compact simple $\mathfrak g$ ($I\#I=cI$), with $\mathfrak k$ a subalgebra of one induced Casimir value ($P_{\mathfrak k}\#P_{\mathfrak k}=c_1P_{\mathfrak k}$, $c_1>0$) and $\mathfrak p\ne0$ its orthogonal complement, irreducible under $\mathfrak k$. Then $P_{\mathfrak k}\#P_{\mathfrak p}=\alpha P_{\mathfrak p}$ and $P_{\mathfrak p}\#P_{\mathfrak p}=xP_{\mathfrak k}+yP_{\mathfrak p}$, with $c_1=\tfrac12\mathrm{Cas}_{\mathfrak k}(\mathfrak k)$, $\alpha=\tfrac12\mathrm{Cas}_{\mathfrak k}(\mathfrak p)>0$, $c_1+x=c$, $2\alpha+y=c$ and $x\,d_{\mathfrak k}=\alpha\,d_{\mathfrak p}$. The idempotents among $aP_{\mathfrak k}+bP_{\mathfrak p}$ are $0$, $P_{\mathfrak k}/c_1$, $I/c$ and $\big(cx/D,\,c(y-x)/D\big)$, $D=c_1y^2+4\alpha^2x$, the last positive definite exactly when $y>x$, that is $\mathrm{Cas}_{\mathfrak k}(\mathfrak p)<\tfrac12\mathrm{Cas}_{\mathfrak k}(\mathfrak k)$. At $SU(3)\subset G_2$ ($\mathfrak p=\mathbb C^3$), $c=4$, $c_1=3$, $\alpha=\tfrac43$, $x=1$, $y=\tfrac43$, and $C=\tfrac9{28}P_{\mathfrak{su}(3)}+\tfrac3{28}P_{\mathfrak p}$ is a positive-definite idempotent on $\mathfrak g_2$ other than $I/4$, so U is false. Its squared norm $\tfrac{351}{392}$ exceeds $I/4$'s $\tfrac78$."*
- **U, verbatim (L260, What it gives):** *"U (the positive-definite idempotents on $\mathfrak h$ are exactly $\bigoplus_i\Pi_i/c_i$)"*, with $\Pi_i\#\Pi_i=c_i\Pi_i$ (L260 (3)) and $\mathfrak h$ ranging over the compact semisimple subalgebras of $\mathfrak{so}(n)$ (L260 (2), (3)).

## Q1: the hypotheses

- **The instance U would give meets every hypothesis.** Let $\mathfrak h=\bigoplus_i\mathfrak h_i$ be the simple ideals and $\Pi_i$ the Frobenius-orthogonal projection of $\mathfrak{so}(7)$ onto $\mathfrak h_i$. Ideals of $\mathfrak h$ are mutually orthogonal under the ad-invariant Frobenius form ($\langle[x,y],z\rangle=-\langle y,[x,z]\rangle=0$ for $x,y\in\mathfrak h_i$, $z\in\mathfrak h_j$, $\mathfrak h_i=[\mathfrak h_i,\mathfrak h_i]$), so `hPP` holds. Each $\mathfrak h_i$ is a subalgebra (`hsub`), $[\mathfrak h_i,\mathfrak h_j]\subseteq\mathfrak h_i\cap\mathfrak h_j=0$ (`hcomm`), and $\sum_i\Pi_i$ is the identity on $\mathfrak h$ (`hcov`). The operator $\bigoplus_i\Pi_i/c_i$ of U, read in $\mathfrak{so}(7)$, vanishes on $\mathfrak h^\perp$, and so does `gop lamC` (a sum of `rk1 (gv i)`, each $X\mapsto\langle X,g_i\rangle g_i$). So U at this $C$ would give `hC` with $\lambda_i=1/c_i$, and `L263_not_ideal_sum` says it cannot.
- **Strictly stronger.** The theorem asks less of the family: no self-adjointness, ranges anywhere in $\mathfrak{so}(7)$, any $r$, weights of any sign including zero, and "ideals" only in the sense of bracket-closed commuting summands of the covered part. Removing hypotheses from a statement of the form "hypotheses imply False" can only strengthen it. The risk to guard against is the opposite one, that the remaining hypotheses are unsatisfiable on their own, and Q5 excludes it.
- **`hcov` is the right covering.** $\sum_i\Pi_i g_k=g_k$ for the basis `gv` of $\mathfrak h$ gives $\sum_i\Pi_iX=X$ for every $X\in\mathfrak h$ by linearity, which is "$\mathfrak h\subseteq\bigoplus_i\mathop{\mathrm{range}}\Pi_i$ with the decomposition read off by the $\Pi_i$". The proof uses it only at $g_1$ and $g_3$.
- **Why `eigen_bracket` is the right lemma.** Under `hPP` and `hC`, $C\Pi_i=\lambda_i\Pi_i$ and $\Pi_iC=\lambda_i\Pi_i$, so an eigenvector $X$ of eigenvalue $\mu$ has $\Pi_iX=0$ whenever $\lambda_i\ne\mu$. With `hcomm`, $[X,Y]=\sum_i[\Pi_iX,\Pi_iY]$, and each surviving term lies in $\mathop{\mathrm{range}}\Pi_i$ (`hsub`), where $C$ acts by $\lambda_i=\mu$. Read line by line, the Lean proof is this argument.

## Q2: what "U fails on $\mathfrak h$" still needs

- **Positive definiteness of $C$ on $\mathfrak h$** is a clause of `L263_g2` (with self-adjointness, idempotence and $\mathop{\mathrm{range}}C=\mathfrak h$), and `L263_witness` gives the eigenvalues $\tfrac9{28}$ and $\tfrac3{28}$ on the orthogonal basis `gv`. This file does not restate it and does not need to.
- **Compact semisimple $\mathfrak h$ (U's scope)** is still needed, since U speaks only of such $\mathfrak h$. Compactness is automatic for a subalgebra of $\mathfrak{so}(7)$ (the Frobenius form is positive definite and ad-invariant on it). What remains is semisimplicity, narrower than the header's "compact semisimple" (O1).
- **$C$ is an idempotent of $\mathfrak h$'s own $\#$.** `L263_witness` proves idempotence under $\mathfrak{so}(7)$'s `sharpMapCL`. U and L260 (2) speak of $\mathfrak h$'s own $\#$. For an operator $\sum\lambda_iv_iv_i^{\mathsf T}$ with every $v_i\in\mathfrak h$, `sharp_rk1_sum` writes $\#$ through brackets $[v_i,v_j]\in\mathfrak h$, so the two coincide with $\mathfrak h$'s $\#$ taken in the restricted Frobenius form. The reading is exact but unnamed in the header and INDEX row (O2). It does not touch `L263_not_ideal_sum`, whose weights are free.

## Q3: `br13` by hand

With `phi i j` $=E_{ji}-E_{ij}$ (`Matrix.single j i 1 - Matrix.single i j 1`) and `br X Y` $=XY-YX$, $\varphi_{ij}=-A_{ij}$ for $A_{ij}=E_{ij}-E_{ji}$, and $[A_{ij},A_{jk}]=A_{ik}$ gives $[\varphi_{ij},\varphi_{jk}]=-\varphi_{ik}$ for distinct $i,j,k$, with $\varphi_{ji}=-\varphi_{ij}$ and disjoint pairs commuting. From lines 185–200 of I117G2.lean, $g_1=\varphi_{12}+\varphi_{34}-2\varphi_{56}$, $g_3=-\varphi_{02}+\varphi_{35}+2\varphi_{46}$. The nonzero brackets:

| pair | bracket |
| --- | --- |
| $[\varphi_{12},-\varphi_{02}]$ | $\varphi_{01}$ |
| $[\varphi_{34},\varphi_{35}]$ | $\varphi_{45}$ |
| $[\varphi_{34},2\varphi_{46}]$ | $-2\varphi_{36}$ |
| $[-2\varphi_{56},\varphi_{35}]$ | $-2\varphi_{36}$ |
| $[-2\varphi_{56},2\varphi_{46}]$ | $4\varphi_{45}$ |

The sum is $\varphi_{01}+5\varphi_{45}-4\varphi_{36}$. With $g_4=\varphi_{01}+\varphi_{45}$ and $g_5=\varphi_{01}-\varphi_{45}+2\varphi_{36}$, $3g_4-2g_5=\varphi_{01}+5\varphi_{45}-4\varphi_{36}$. The entry `gf6 1 3` is `![0,0,0,0,18,-12,0,…]`, which is $3g_4-2g_5$ after division by $6$, consistent with `gv_br`. `su3idx` $=\{0,2,4,6,8,10,12,13\}$ contains $4$ and omits $1,3,5$. The contradiction in the proof: $C[g_1,g_3]$ would be $\tfrac3{28}(3g_4-2g_5)$, while $C(3g_4-2g_5)=\tfrac{27}{28}g_4-\tfrac6{28}g_5$, and the $g_4$ components $\tfrac9{28}$ and $\tfrac{27}{28}$ differ.

## Q4: axioms

A check file importing `HamiltonsCubic.Results.L263Ideal`, run with `lake env lean` from `lean/` against the oleans built from HEAD (1d433644, whose `L263_not_ideal_sum`, `eigen_bracket` and `br13` are unchanged from 91b441ed), printed for each of `L263_not_ideal_sum`, `eigen_bracket`, `br13` and `center_zero`: `depends on axioms: [propext, Classical.choice, Quot.sound]`. No `sorryAx`, no `Lean.ofReduceBool`.

## Q5: a family meeting every hypothesis but `hC`

- **The trivial decomposition.** $r=1$, $\Pi_1=$ `gop lamP`, the orthogonal projection onto $\mathfrak h$ (`L263_witness` gives $\Pi_1g_k=g_k$, and `gop lamP` vanishes on $\mathfrak h^\perp$). `hPP` is $\Pi_1^2=\Pi_1$, true since $\Pi_1$ fixes $\mathfrak h$ and maps into it. `hsub` is closure of $\mathfrak h$ under the bracket (`gv_br`, `L263_g2`). `hcomm` is vacuous at $r=1$. `hcov` is $\Pi_1g_k=g_k$. `hC` would need `gop lamC` $=\lambda_1$ `gop lamP`, a single eigenvalue on $\mathfrak h$, while $C$ has two ($\tfrac9{28}$ on $g_4$, $\tfrac3{28}$ on $g_1$). No weight works. This matches U's case of simple $\mathfrak h$, where U predicts $C=P_{\mathfrak h}/c$ and `L263_g2`'s clause $C\ne(1/c)P_{\mathfrak h}$ already refutes it.
- **The near miss that locates the content.** $r=2$, $\Pi_1=P_{\mathfrak{su}(3)}$, $\Pi_2=P_{\mathfrak p}$, $\lambda=(\tfrac9{28},\tfrac3{28})$ satisfies `hPP`, `hcov`, `hC`, and `hsub` at $i=1$. It fails `hsub` at $i=2$ and `hcomm`, both by `br13` itself: $[g_1,g_3]\in[\mathfrak p,\mathfrak p]$ has an $\mathfrak{su}(3)$ component, and $[\mathfrak{su}(3),\mathfrak p]\ne0$ since $\mathfrak p$ is a nonzero $\mathfrak{su}(3)$-module on which $\mathfrak{su}(3)$ acts faithfully. So each of the two bracket hypotheses is what separates $C$ from an ideal sum, and the theorem is not decided by `hPP`, `hcov` or `hC` alone.

## Q6: the INDEX row

- The added clause is accurate: "the witness is $\sum_i\lambda_i\Pi_i$ for no family of projections onto commuting ideals covering $\mathfrak h$ and no weights", "since each eigenspace of such a sum is closed under the bracket (`eigen_bracket`) while $[g_1,g_3]=3g_4-2g_5$ leaves the $\tfrac3{28}$-eigenspace (`br13`)", "so the conclusion *U is false* needs neither that $\mathfrak h$ is simple nor that it is $\mathfrak g_2$". Each piece matches the Lean.
- "Left to the record: that $\mathfrak h$ is compact semisimple (U's scope)" is correct but wider than necessary (O1), and the row does not name the $\#$ reading of Q2 (O2).
- The file is listed in the row's file column and imported from [HamiltonsCubic.lean](../lean/HamiltonsCubic.lean).

## Extension: `center_zero` (commit 1a9af9df)

- **(a) The statement is the trivial-centre claim.** `center_zero` says: for every $z\in\mathbb R^{14}$, if $[\sum_mz_mg_m,g_k]=0$ for every $k$ then every $z_m=0$. `gv` is linearly independent and spans $\mathfrak h$ (`L263_g2`'s `hli` and `hdim`), so the elements of $\mathfrak h$ are exactly the sums $\sum_mz_mg_m$, and commuting with each $g_k$ is commuting with $\mathfrak h$ by bilinearity. So the statement is $\mathfrak z(\mathfrak h)=0$, neither weaker nor stronger. The proof isolates $z_m$ by pairing $[Z,g_{\mathrm{isoK}(m)}]$ with $g_{\mathrm{isoP}(m)}$: `inner_br` reads the pairing off `gf6` and `gn`, `iso_single` says only $q=m$ contributes, and `iso_ne` that its coefficient is nonzero. Spot check at $m=1$: $\mathrm{isoK}=2$, $\mathrm{isoP}=5$, and `gf6 1 2` $=$ `![0,0,0,0,0,6,…]` has entry $6$ at index $5$, and `iso_single` has the kernel check that `gf6 q 2 5` vanishes for every $q\ne1$.
- **(b) The remaining step is the right one.** The Frobenius form restricted to $\mathfrak h$ is positive definite and $\mathrm{ad}_{\mathfrak h}$-invariant, so $\mathfrak h$ is a compact Lie algebra and hence reductive: $\mathfrak h=\mathfrak z(\mathfrak h)\oplus[\mathfrak h,\mathfrak h]$ with $[\mathfrak h,\mathfrak h]$ semisimple (the orthogonal complement of an ideal is an ideal, and a compact algebra with no abelian ideal is semisimple since the Killing form is then negative definite). With $\mathfrak z(\mathfrak h)=0$, $\mathfrak h$ is compact semisimple, which is U's scope in L260 (2), (3). The step is standard and is the same one L260 (2) and L264 (1) carry as prose (there from perfectness). Nothing further is needed for U's scope.
- **(c)** Axioms as in Q4.
- The INDEX row as edited in 1a9af9df ("Left to the record: that a subalgebra of the compact $\mathfrak{so}(7)$ with trivial centre is semisimple (so $\mathfrak h$ is in U's scope), …") states exactly this, which closes O1 below.

## Observations

1. **The scope item left to the record is narrower than "compact semisimple".** Compactness is automatic for a subalgebra of $\mathfrak{so}(7)$. Perfectness follows from `L260_range_subalgebra` applied to `gop lamC` (self-adjoint, positive semidefinite, idempotent, range $\mathfrak h$), which the layer proves at $\mathfrak{so}(n)$. What stays prose is only "a perfect (or centreless) subalgebra of a compact Lie algebra is semisimple", the same step L260 (2) and L264 (1) already carry. Commit 1a9af9df takes the centre route instead (`center_zero`) and narrows the INDEX row to the standard step, so this observation is closed as of that commit (see the Extension section). Falsifier: a nonzero central element of $\mathop{\mathrm{span}}(g_k)$, which `center_zero` rules out.
2. **The identification of $\mathfrak h$'s own $\#$ with $\mathfrak{so}(7)$'s $\#$ on operators supported on $\mathfrak h$ is used and not named.** It is exact (Q2, via `sharp_rk1_sum`), in the restricted Frobenius normalisation, which is why $c=4$. The header and INDEX row could list it beside the scope item, as the L264 row does for its own reading. Falsifier: an operator supported on $\mathfrak h$ whose $\mathfrak{so}(7)$-$\#$ square has a component outside $\mathop{\mathrm{End}}(\mathfrak h)$, impossible since $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$.
3. **`eigen_bracket` proves more than its description says.** The header and INDEX row say each eigenspace is "closed under the bracket". The theorem takes $X$ in the $\mu$-eigenspace and $Y$ any covered vector, so the eigenspace is an ideal of the covered part. The stronger reading is the natural one (the eigenspace is the sum of the $\mathop{\mathrm{range}}\Pi_i$ with $\lambda_i=\mu$) and could be stated. Falsifier: none, the Lean statement already has it.

## Falsifiers

| Statement | Object that would falsify it |
| --- | --- |
| `br13` | a coefficient of $[g_1,g_3]$ other than $(3,-2)$ on $(g_4,g_5)$, excluded by the hand computation above |
| `eigen_bracket` | a family meeting its hypotheses with an eigenvector $X$, covered $Y$ and $C[X,Y]\ne\mu[X,Y]$ |
| `center_zero` | a nonzero $z\in\mathbb R^{14}$ with $[\sum z_mg_m,g_k]=0$ for every $k$ |
| `L263_not_ideal_sum` | idempotents $\Pi_i$ with `hPP`, `hsub`, `hcomm`, `hcov` and weights with $\sum\lambda_i\Pi_i=$ `gop lamC` |
| "U is false" (record) | a proof that $\mathop{\mathrm{span}}(g_k)$ is not semisimple, or that $C$ is not an idempotent of $\mathfrak h$'s own $\#$ |

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** `L263_not_ideal_sum` states faithfully, and more strongly, the half of L263's "so U is false" that the earlier Lean left to prose, and its hypotheses are satisfiable. `center_zero` states the trivial centre of $\mathfrak h$ exactly, and the remaining prose step to U's scope is the standard reductive decomposition of a compact Lie algebra. Observation 1 is closed by 1a9af9df, observations 2 and 3 stand.
