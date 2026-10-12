# REVIEW r1835: L220 step 5 in FourStep5.lean

*Gate 2 on [FourStep5.lean](../lean/HamiltonsCubic/Results/FourStep5.lean) at commit 2571dbf2, that commit's docstring and hypothesis edits to [FourStep4.lean](../lean/HamiltonsCubic/Results/FourStep4.lean), and its two L220 rows in [lean/INDEX.md](../lean/INDEX.md). The Lean is a faithful, slightly stronger formalisation of the record's step 5, its 2×2 determinant replacing the appeal to L121 checks by hand, and the module rests on the standard three axioms. The statement row of the INDEX still lists "the eigenvalue step" as owed after this commit proved it, the same defect r1832 O5 found for step 4.*

| # | Claim | Verdict |
|---|---|---|
| 1 | `step5`'s conclusion $\theta^2=3\lVert q\rVert^2$ is the record's $\lVert q\rVert^2=\theta^2/3$ (question a) | CONFIRMED WITH OBSERVATIONS |
| 2 | `normSq2_PiQ`, $\lVert q\rVert^2=2(x^2+y^2+z^2)$, is the Setting's norm (question b) | CONFIRMED |
| 3 | $M=-6\begin{pmatrix}y&z\\z&x\end{pmatrix}$, $G=\begin{pmatrix}4&-2\\-2&4\end{pmatrix}$, $\det(2M-\theta G)=12\theta^2-144(x^2+xy+y^2)$ at $x+y+z=0$ (question c) | CONFIRMED |
| 4 | `inner_PiQ` at one symmetric $b$ (question d) | CONFIRMED |
| 5 | FourStep4.lean's docstring and hypothesis edits (r1832 O2 to O4) | CONFIRMED |
| 6 | The INDEX statement row's owed list is accurate after the commit (question e) | REFUTED AS STATED |
| 7 | The INDEX result row: the step 5 sentence, the r1832 citation, the owed list, the pointer (question e) | CONFIRMED |
| 8 | `axiom_audit.py --only FourStep5.lean` | CONFIRMED |

**Summary.** The mathematics is right and faithful. One stale owed item in the statement row (O1) and its twin in the record's status paragraph (O2) need the downstream repair.

## 1. The conclusion against the record (question a)

The record, step 5, verbatim: "By [L121] $L_q$ on $V_Q$ has eigenvalues $\pm\tfrac12\sqrt E$ with $A=2x$, $B=2y$, $C=2z$, so $E=4(x^2+y^2+z^2-xy-yz-zx)=6(x^2+y^2+z^2)=3\lVert q\rVert^2$ … With $\theta>0$ and $\nu\ne0$, $\lVert q\rVert^2=\theta^2/3$."

- `step5` takes $x+y+z=0$, $\nu$ Weyl of character $\chi_Q$, $\nu\ne0$ and $2\,q\circ\nu=\theta\nu$ with $q=\Pi_Q(x,y,z)\odot\cdot$, and concludes $\theta^2=3\lVert q\rVert^2$.
- The record's argument reads $\tfrac\theta2\in\{\pm\tfrac12\sqrt E\}$, which is $\theta^2=E$ for either sign. The hypothesis $\theta>0$ selects the root $+\tfrac12\sqrt E$ but never enters the value of $\lVert q\rVert^2$. So the sign-free Lean statement is the record's conclusion with a hypothesis dropped, a strengthening.
- $\nu\ne0$ is used, as `hν0`, to make the coefficient vector $(a,b)$ nonzero, which is exactly where the record needs it.
- The index distinctness hypotheses (six `≠`) are the record's "$Q=\{i,j,k,l\}$" four-set.
- At the equality point (Section 6) the sign of $\theta$ is the sign of $t$, so the record's converse depends on a sign it leaves implicit (O4). The Lean's sign-free form is unaffected.

## 2. The norm convention (question b)

- The Setting, verbatim: "$K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$ with $x+y+z=0$, unit when $2(x^2+y^2+z^2)=1$."
- `innerOp2_coordOp` in [L224Rank.lean](../lean/HamiltonsCubic/Results/L224Rank.lean) is $\tfrac12\sum_{a\ne c}A_{ac}B_{ac}=\sum_{a<c}A_{ac}B_{ac}$ at symmetric $A,B$.
- `PiQ` in [FourProd.lean](../lean/HamiltonsCubic/Results/FourProd.lean) puts $x$ on $ij,kl$, $y$ on $ik,jl$, $z$ on $il,jk$, each pair symmetric. So $\sum_{a<c}K_{ac}^2=2x^2+2y^2+2z^2$, and `inner_PiQ` at $b=\Pi_Q(x,y,z)$ gives $x\cdot2x+y\cdot2y+z\cdot2z$, the same.
- The Setting's unit condition is this norm equal to $1$. The same `innerOp2` gives $\lVert\sigma\rVert^2=4$, so step 9's $\lVert r\rVert^2=1-\tfrac{\theta^2}3-\lVert\nu\rVert^2$ is read in one inner product throughout.

## 3. The 2×2 system by hand (question c)

**Weights of the squares.** `W4 i k j l` is $\mathrm{ind}_{ik}\mathrm{ind}_{jl}^{\mathsf T}+\mathrm{ind}_{jl}\mathrm{ind}_{ik}^{\mathsf T}+2(u_{ik}u_{ik}^{\mathsf T}+u_{jl}u_{jl}^{\mathsf T})$, $u_{ik}=e_i-e_k$. Off the diagonal it is $1$ on $ij,il,kj,kl$ and $-2$ on $ik,jl$. So by `inner_PiQ`:

- $M_{AA}=\langle q,\sigma_A\circ\sigma_A\rangle=2x-4y+2z$, which is `M_A`, and equals $-6y$ at $x+z=-y$.
- $M_{BB}$ uses `W4 i j k l`, $-2$ on $ij,kl$: $-4x+2y+2z=-6x$, which is `M_B`.
- `M_C` uses `W4 i l j k`, $-2$ on $il,jk$: $2x+2y-4z=-6z$.

**The mixed entry.** From $\sigma_A+\sigma_B=-\sigma_C$ (`sig_sum`), $Q(\sigma_A+\sigma_B)=Q_C$, so $2\sigma_A\circ\sigma_B=Q_C-Q_A-Q_B$ (the `hfox` step). Then $M_{AB}=\tfrac12\big((2x+2y-4z)-(2x-4y+2z)-(-4x+2y+2z)\big)=\tfrac12(4x+4y-8z)=2x+2y-4z=-6z$. Hence $M=-6\begin{pmatrix}y&z\\z&x\end{pmatrix}$.

**The Gram matrix.** $\lVert\sigma\rVert^2=4$ by `norm_sig`, and $\lVert\sigma_C\rVert^2=\lVert\sigma_A+\sigma_B\rVert^2=8+2\langle\sigma_A,\sigma_B\rangle=4$ gives $\langle\sigma_A,\sigma_B\rangle=-2$ (`inner_AB`). So $G=\begin{pmatrix}4&-2\\-2&4\end{pmatrix}$.

**The system.** With $\nu=a\sigma_A+b\sigma_B$ (`four_eq_sig`) and $s\in\{\sigma_A,\sigma_B\}$, $2\langle q\circ\nu,s\rangle=\theta\langle\nu,s\rangle$, and $\langle q\circ\nu,s\rangle=\langle q,\nu\circ s\rangle$ (`inner_fox_move`, all three self-adjoint), give $2Mc=\theta Gc$ with $c=(a,b)\ne0$.

**The determinant.**

- $2M-\theta G=\begin{pmatrix}-12y-4\theta&-12z+2\theta\\-12z+2\theta&-12x-4\theta\end{pmatrix}$.
- $\det=(12y+4\theta)(12x+4\theta)-(2\theta-12z)^2=144xy+48\theta(x+y)+16\theta^2-4\theta^2+48\theta z-144z^2$.
- At $x+y+z=0$ the $\theta$-linear terms cancel, leaving $12\theta^2+144(xy-z^2)$, and $z^2=x^2+2xy+y^2$ gives $12\theta^2-144(x^2+xy+y^2)$.
- So $\theta^2=12(x^2+xy+y^2)$, and $3\lVert q\rVert^2=6(x^2+y^2+(x+y)^2)=12(x^2+xy+y^2)$. The two agree.

The Lean's `A`, `B`, `D` are $2M_{AA}-4\theta$, $2M_{AB}+2\theta$ and $2M_{BB}-4\theta$ with $z=-x-y$ substituted, the entries above, and `hdet` is $AD-B^2=0$ from $c\ne0$ by cases on which coordinate is nonzero. The final `linear_combination (1/12) * hdet` is the division by $12$.

This matches L121's route: the determinant's roots are $\pm\sqrt{12(x^2+xy+y^2)}=\pm\sqrt E$ for $\theta$, so $\tfrac\theta2=\pm\tfrac12\sqrt E$, the record's spectrum.

## 4. `inner_PiQ` by hand (question d)

Take $b=E_2(i,j)$, $1$ at $(i,j)$ and $(j,i)$, zero elsewhere.

- Direct: $\tfrac12\sum_{a\ne c}\Pi_Q(x,y,z)_{ac}b_{ac}=\tfrac12(x+x)=x$.
- Formula: $x(b_{ij}+b_{kl})+y(b_{ik}+b_{jl})+z(b_{il}+b_{jk})=x(1+0)=x$.

They agree. `double_single` is the one-entry evaluation behind it.

## 5. FourStep4.lean's edits and the INDEX (question e)

**FourStep4.lean.**

- `Lq_eigen` binds $q$ with no $\Pi_Q$ hypothesis, so "for any $q$ (in L220's use $q\in\Pi_Q$)" is accurate (r1832 O2).
- `PiQ_closed`'s docstring now names `PiQ_mul`, whose values it sums (r1832 O3).
- `_hs'` is unused: the proof rewrites to $(x+y+z)(x'+y'+z')$ and uses `hs` alone (r1832 O4).

**The statement row.** It now reads, verbatim: "steps 2 and 4 (now proved on the operators in the [L220] result row below, r1831 O3, r1832 O5)". That drops $L_r\nu=0$ and points to the result row, which is the r1832 O5 repair. The same list still closes with, verbatim, "and the eigenvalue step (r1790 O6)", which is step 5 and is proved by `step5` in this commit (O1). REFUTED AS STATED.

**The result row.**

- The step 5 sentence lists the declarations with their statements correctly, and "$0\ne\nu\in V_Q$" is `step5`'s Weyl and `SignChar` hypotheses under `four_eq_sig`'s identification.
- It cites r1832 for FourStep4 as "CONFIRMED WITH OBSERVATIONS", which is r1832's claim table (four claims with observations).
- The pointer reads "The account of steps 1 and 3, with their Gate 2 history, is in the L220 (statement) row above (r1832 O7)", limited to steps 1 and 3 as O7 asked.
- The owed list drops the eigenvalue step and keeps the $n\ge12$ clause, the equality case, `hunit`, `hpair`, and steps 7 and 8 at the operators. That matches what remains.
- It records no Gate 2 for FourStep5, which this review is (O3).

## 6. Hand evaluation at the equality point (exact, by hand)

The record, verbatim: "$q=t(2,-1,-1)$, $\nu=\pm t(2,-1,-1)$ with $t^2=\tfrac1{24}$ … at $\theta=\sqrt{3/2}$".

- $\lVert q\rVert^2=2(4+1+1)t^2=12t^2=\tfrac12$, so $3\lVert q\rVert^2=\tfrac32=\theta^2$. The identity holds.
- The eigen-equation itself, in the Lean's coordinates: $\sigma_A=(1,0,-1)$ and $\sigma_B=(0,-1,1)$ in signed coordinates, so $a\sigma_A+b\sigma_B=(a,-b,b-a)$, and $\nu=t(2,-1,-1)$ is $(a,b)=(2t,t)$.
- $M=-6\begin{pmatrix}-t&-t\\-t&2t\end{pmatrix}$, $Mc=-6(-3t^2,0)=(18t^2,0)$, so $2Mc=(36t^2,0)$. $Gc=(8t-2t,\,-4t+4t)=(6t,0)$.
- $2Mc=\theta Gc$ holds with $\theta=6t$, and $t=1/\sqrt{24}$ gives $\theta=\sqrt{36/24}=\sqrt{3/2}$.

## 7. The axiom audit

`python3 scripts/misc/axiom_audit.py --only FourStep5.lean`: "auditing 11 declarations across 1 files", "11/11 clean -- resting on the standard three alone". The eleven are `W4_T`, `double_single`, `inner_PiQ`, `normSq2_PiQ`, `M_A`, `M_B`, `M_C`, `norm_w4`, `norm_sig`, `inner_AB` and `step5`. `lake env lean HamiltonsCubic/Results/FourStep5.lean` exits 0 with one linter warning (O5).

## Observations

- **O1.** The statement row's owed list still ends "and the eigenvalue step (r1790 O6)" after `step5` proved it. Fold it into the pointer, "steps 2, 4 and 5 (now proved on the operators in the [L220] result row below, …)". This is r1832 O5's defect again, one step later.
- **O2.** The record's L220 status paragraph in [second-order.md](../findings/second-order.md) still reads, verbatim, "The Lean owes the norm split, step 6's pairing, steps 7 and 8 at the operators, the eigenvalue step, …", and it records r1832 as "CONFIRMED" where r1832's table carries four CONFIRMED WITH OBSERVATIONS and one REFUTED AS STATED. The commit touched neither. Both need the downstream repair, with step 5 and `step5` added to the paragraph's account.
- **O3.** The result row records no Gate 2 for FourStep5.lean. This review is it, and the row should cite r1835.
- **O4.** At the record's equality point $\theta=6t$ (Section 6), so the converse in step 9 holds at $\theta=\sqrt{3/2}$ only for $t=+1/\sqrt{24}$. At $t=-1/\sqrt{24}$ step 3's equation holds at $\theta=-\sqrt{3/2}$. The record should read $t=1/\sqrt{24}$ (or $t>0$). This is a record-side precision point, and the Lean's $\theta^2$ form is unaffected.
- **O5.** `double_single` auto-includes the six distinctness hypotheses and uses none of them, which is the compile's one warning. An `omit hij hik hil hjk hjl hkl in` before it, or moving it above the `section`, clears it. The commit's "Module builds clean" is accurate for errors only.

## What would falsify each headline

- **Claims 1 to 4.** A choice of distinct $i,j,k,l$ and $(x,y,z)$, $x+y+z=0$, where a Weyl $\nu$ of character $\chi_Q$, $\nu\ne0$, satisfies $2q\circ\nu=\theta\nu$ with $\theta^2\ne6(x^2+y^2+z^2)$. The kernel excludes it given the definitions, so the falsifier would sit in the definitions: `W4` carrying weights other than $1$ and $-2$ on the stated pairs, or `innerOp2` differing from $\sum_{a<c}$ on `coordOp`. Sections 2 and 3 read both from source.
- **Claim 5.** A use of `hs'` in `PiQ_closed`'s proof, or a $\Pi_Q$ hypothesis in `Lq_eigen`'s signature. Neither is present.
- **Claim 6.** Evidence that "the eigenvalue step" in the statement row names something other than step 5. The record's step 5 is titled "The eigenvalue fixes $\lVert q\rVert$" and r1790 O6 is where it was first listed.
- **Claim 7.** A proved item remaining in the result row's owed list, or an owed item missing from it. The five listed are the record's remaining steps.
- **Claim 8.** An axiom beyond `propext`, `Classical.choice` and `Quot.sound` in the audit's output. There was none.
