# REVIEW r1631: L273 (1)-(3), L269, L271 (4)'s identity and L268_pd_pos against the record

**Verdict: two rows CONFIRMED, four CONFIRMED WITH GAPS, none REFUTED.** Every Lean statement says what the record says, or something stronger, on the hypotheses it states. The gaps are record clauses left untyped without being listed as owed, one docstring that claims an unproved equality case, the representability owe that L273 (3) inherits from L268, and one record sentence in L269 that says more than its proof gives.

Log: agent_logs/r1631.log

Footing: analysis only. The runs were one `lake env lean` on a scratch copy of the working-tree [I117Statements.lean](../lean/HamiltonsCubic/Results/I117Statements.lean) with `#print axioms` appended (51 s, exit 0, no errors). The olean (08:56) is older than the staged source (09:29), so I compiled the source itself and did not rebuild the olean. The imports' oleans are newer than their sources. I also ran one screen of a few seconds on points I built (section 7). It is a screen, not evidence.

## Claim table

| # | Claim | Lean declaration | Verdict |
|---|---|---|---|
| 1 | L273 (1): $F(X)\le3\lVert A\rVert g+T$ | L273_F_bound ([I117Statements.lean:5074](../lean/HamiltonsCubic/Results/I117Statements.lean#L5074)), L273_F_bound_core ([:4816](../lean/HamiltonsCubic/Results/I117Statements.lean#L4816)) | CONFIRMED WITH GAPS |
| 2 | L273 (2): $\lambda_m(1-g^2)\le\Psi_\kappa(g)$, $g\ge1/\sqrt m$, $m\ge5$ | psi_bound ([:4905](../lean/HamiltonsCubic/Results/I117Statements.lean#L4905)) | CONFIRMED WITH GAPS |
| 3 | L273 (3): J1 implies H on the torus slice, $m\ge5$ | L273_J1_implies_H ([:5083](../lean/HamiltonsCubic/Results/I117Statements.lean#L5083)) | CONFIRMED WITH GAPS |
| 4 | L269: $\Phi>0$ gives an eigenvalue of $C\#\cdot$ above $\tfrac12$ on $C^\perp$ | L269_phi_test ([:5575](../lean/HamiltonsCubic/Results/I117Statements.lean#L5575)) | CONFIRMED WITH GAPS |
| 5 | L271 (4)'s identity $F(C,C_P,C_Q)=\tfrac12\lVert C_Q\rVert^2-\tfrac14\mathop{\mathrm{tr}}Q^3$ | L271_split ([:5561](../lean/HamiltonsCubic/Results/I117Statements.lean#L5561)) | CONFIRMED |
| 6 | L268 positivity clause, forward | L268_pd_pos ([:5097](../lean/HamiltonsCubic/Results/I117Statements.lean#L5097)) | CONFIRMED |
| 7 | Axioms | all six, plus Ftri_It and Ftri_IR | standard three (propext, Classical.choice, Quot.sound) on all eight |

## 1. L273 (1)

- **Norm conventions match.** $\lVert A\rVert$ is the Frobenius norm $\sqrt{\sum A_{ij}^2}$, which is L271 (1)'s convention: L271_norm gives $\lVert X\rVert^2=\sum A_{ij}^2+b^2$, and L273_J1_core uses it (`hN`). $g=\sqrt{\sum (A_\mu)_{ij}^2}$ with Amu $=\mathop{\mathrm{diag}}d$ on the diagonal and $V_{ij}^2-U_{ij}^2=-P_{ij}Q_{ij}$ off it, as in L271 (2). $T=\tfrac12(\mathop{\mathrm{tr}}P^3+\mathop{\mathrm{tr}}Q^3)$ with $P=U+V$ and $Q=U-V$.
- **The Lean statement is stronger than the record's.** It holds for every symmetric $A$ and all pair weights with no $b=1$ normalisation. Both sides have degree 3 in $(A,U,V)$, so the normalisation carries no content. The proof is Ftri_torus, the rewrite $F=3\langle A,A_\mu\rangle+T$ (`hpair`) and Cauchy–Schwarz (cs_double), which is the record's proof.
- **Gap 1a: the equality clause is untyped.** The record says equality holds when $A$ is a non-negative multiple of $A_\mu$, but L273_F_bound proves only the inequality. **Its docstring nonetheless says "with equality when $A$ is a non-negative multiple of $A_\mu$"**, which claims more than the theorem proves. The fix is either to prove the case (Cauchy–Schwarz equality at $A=sA_\mu$, $s\ge0$, is one line from `hpair`) or to cut the clause from the docstring and list it as owed.
- **Gap 1b: $g\ge1/\sqrt m$ is proved but not exported.** The bound appears only as the local fact `hgm` ($g\ge b^2/\sqrt m$) inside L273_J1_core. It holds for all pair weights, by Cauchy–Schwarz on $\sum_id_i=b^2$ together with $\sum d_i^2\le g^2$.
- **Gap 1c: the INDEX row reads "(1), from Ftri_torus and Cauchy–Schwarz" and names neither untyped clause.**

## 2. L273 (2)

- **psi_bound is exactly (2)'s inequality.** $\Psi_\kappa(g)=\min_{a\ge0}(\kappa(1+a^2)^{3/2}-3ag)$, so $\lambda_m(1-g^2)\le\Psi_\kappa(g)$ is equivalent to $3ag+\lambda_m(1-g^2)\le\kappa(1+a^2)^{3/2}$ for every $a\ge0$. The equivalence holds whether the minimum is read as a min or an inf, so the Lean form needs no attainment argument.
- **The constants match.** Lean's $\sqrt{2m}(m-2)/((m-1)\sqrt{m-1})$ is $\lambda_m$, $2(m-1)/\sqrt{m(2m-1)}$ is $\kappa$, and $\sqrt{1+a^2}^{\,3}$ is $(1+a^2)^{3/2}$. The hypotheses are $m\ge5$ (over the reals, which covers every natural $m\ge5$), $a\ge0$ and $g\ge1/\sqrt m$, the record's set.
- The proof is sound as a route. It takes the tangent line of $(1+a^2)^{3/2}$ at $b=\sqrt{u-1}$, where $u=t^2$ solves $\kappa^2u(u-1)=g^2$, shows $t\ge t_0$ from monotonicity of $t^2(t^2-1)$, and then applies jh_nonneg. That is the record's substitution $t=\sqrt{1+a^2}$ run in reverse.
- **Gap 2a: equality at $g=1/\sqrt m$ is untyped in the $\Psi$ form.** jh_zero gives $h(t_0)=0$ in the variable $t$, and the INDEX row does not list this clause among the "not stated".
- **Gap 2b: the failure at $m=4$ is untyped.** The INDEX row lists this one.

## 3. L273 (3)

- **J1 is transcribed faithfully.** The Lean hypothesis quantifies over all pair weights $U,V$ with no sign constraint, as the record's "whenever $b=1$" does. It requires $\tfrac12(\lVert P\rVert^2+\lVert Q\rVert^2)=1$ and concludes $T+\lambda_m(\sum_id_i^2+\sum_{i\ne j}(P_{ij}Q_{ij})^2)\le\lambda_m$. **Amu_sq ([:4918](../lean/HamiltonsCubic/Results/I117Statements.lean#L4918)) proves that this bracket equals $\sum_{ij}(A_\mu)_{ij}^2=g^2$**, since the off-diagonal entries of $A_\mu$ are $-P_{ij}Q_{ij}$.
- **The conclusion is H with the record's $\kappa$.** It reads $F(X,X,X)\le\kappa\,\lVert X\rVert^{3}$, with $\lVert X\rVert^{3}$ written as normSq2 raised to the power $3/2$, for every symmetric $A$ and all pair weights $U,V$. The proof rescales to the unit root sphere and applies J1, then (1), then psi_bound at $a=\sqrt{SA}/b$ and $g'=\sqrt{G_2}/b^2$ with $g'\ge1/\sqrt m$ taken from `hgm`. The case $b=0$ is handled separately. This matches the record's proof step for step.
- **Gap 3a: the torus slice is inherited from L268.** The record says "every torus-invariant $X\in\mathop{\mathrm{Sym}}^2\mathfrak{so}(2m)$", while the Lean quantifies over the image of torusOp. The statement that every $T$-invariant symmetric operator is a torusOp is recorded as **owed** in L268's INDEX row ([r1629](REVIEW_r1629.md)). L273's row presents (3) as proved without naming that inherited owe, and it should name it.
- **Is the statement vacuous?** Its content is conditional on J1, which is open. The hypotheses other than J1 are satisfiable by any $(A,U,V)$. The screen in section 7 finds the Lean-transcribed J1 tight at the record's equality points and never exceeded, so the hypothesis matches the record's J1 and carries no transcription error that would make it trivially false.

## 4. L269

- **The hypothesis sets are equivalent.** Lean assumes pair weights, $U_{ij},V_{ij}>0$, TorusSystem, and $C=$ torusOp(Amu, U, V). By L268_torus_idem_core this makes $C$ an idempotent, by L268_torus_pd it is positive definite, and by L268_pd_pos every positive-definite torus idempotent has positive weights. So the Lean hypotheses are exactly the record's "torus-invariant positive-definite idempotent". $m\ge3$ is L268's standing bound.
- **The data match.** The record's $x=\sum_\alpha\mu_\alpha$ runs over the positive roots $\varepsilon_i\pm\varepsilon_j$ with $i<j$, which is Lean's $\tfrac12\sum_{i,j}(U_{ij}+V_{ij})$. Likewise $y$ is $\tfrac12\sum(U^2+V^2)$, and $q$ is normSq2 C, which is L271 (1)'s norm. $R$ and $W$ are verbatim. $\Phi$ is verbatim.
- **The conclusion is literally ¬IsStable C.** IsStable ([:43](../lean/HamiltonsCubic/Results/I117Statements.lean#L43)) is "$F(C,H,H)\le\tfrac12\lVert H\rVert^2$ for every self-adjoint $H\perp C$", L264's sense. The theorem exhibits a self-adjoint $H\perp C$ with $2F(C,H,H)>\lVert H\rVert^2$. So the record's "not stable in the sense of L264" is exactly what is proved.
- **Gap 4a: the eigenvalue form is one untyped step away.** Reading the conclusion as "$C\#\cdot$ has an eigenvalue above $\tfrac12$ on $C^\perp$" needs $C^\perp$ to be invariant, and it is: $\langle C\#H,C\rangle=F(C,H,C)=\langle H,C\rangle=0$ by Ftri_idem and symmetry. The docstring of L269_phi_test uses a colon to present the Rayleigh form as that eigenvalue claim.
- **Gap 4b: "At $I/c$, $\Phi=0$" is untyped and is not listed as owed.**
- **Gap 4c: the location clause is untyped, and as worded it is stronger than the record's proof.** The record says "the eigenvector lies in the projection of $\mathop{\mathrm{span}}\{I_{\mathfrak t},I_R\}$ onto $C^\perp$." The proof's pencil argument places a direction whose Rayleigh quotient exceeds $\tfrac12$ in that plane. The Lean witness $H=aI_{\mathfrak t}+I_R-\lambda C$ is such a direction. That direction is an eigenvector of $C\#\cdot$ only if $\mathop{\mathrm{span}}\{C,I_{\mathfrak t},I_R\}$ is $C\#$-invariant.
  - By the record's own proof, $C\#I_{\mathfrak t}$ has zero Cartan block and root scalars $\mu_\alpha$. It is therefore torusOp(0, U, V) $=C-$ torusOp($A_\mu$, 0, 0).
  - That operator lies in the span only if $A_\mu$ is scalar. At positive weights a scalar $A_\mu$ forces $V_{ij}^2=U_{ij}^2$, hence $Q=0$, hence $C=I/c$ by L271 (3).
  - So at every non-uniform solution the 3-plane is not invariant, and the sentence should read "a destabilising direction lies in the projection". This is a defect in the record's wording, not in the Lean, which states only the witness.
- **Is the statement vacuous?** The uniform point $U=V=\tfrac1{2(m-1)}$ off the diagonal satisfies every hypothesis except $\Phi>0$ (L268_uniform, and $\Phi=0$ there). So the hypotheses on $(U,V)$ are consistent. The record's screens place $\Phi>0$ at non-uniform solutions, and no Lean object exhibits one.

## 5. L271 (4)'s identity

- **The operators match the record.** Lean's $C_P$ is torusOp($\mathop{\mathrm{diag}}d$, $P/2$, $P/2$), which is $(\mathop{\mathrm{diag}}d,\,U=V=\tfrac12P)$. $C_Q$ is torusOp($A_\mu-\mathop{\mathrm{diag}}d$, $Q/2$, $-Q/2$). At an idempotent $A=A_\mu$, $A_\mu-\mathop{\mathrm{diag}}d$ is $A_{\mathrm{off}}$, so this is $(A_{\mathrm{off}},\,U=-V=\tfrac12Q)$. The sum, the orthogonality and the identity are all proved, and they are what the record's proof uses.
- **The hypotheses are weaker than the record's, so the statement is stronger.** Lean takes pair weights and TorusSystem at $A=A_\mu$, which is exactly idempotency by L268_torus_idem_core. Neither positivity nor $C\ne I/c$ is needed. The record needs $C\ne I/c$ only so that it can divide by $\lVert C_Q\rVert^2$ in the eigenvalue formula.
- **It is consistent with the record's formula.** $C\#C=C$ and orthogonality give $F(C,C_P,C_P)=\lVert C_P\rVert^2-L_{PQ}$ and $F(C,C_Q,C_Q)=\lVert C_Q\rVert^2-L_{PQ}$. The second eigenvalue is therefore $1-L_{PQ}\,q/(\lVert C_P\rVert^2\lVert C_Q\rVert^2)$. Substituting $L_{PQ}=\tfrac12\lVert C_Q\rVert^2-\tfrac14\mathop{\mathrm{tr}}Q^3$ reproduces the record's displayed eigenvalue exactly. I derived this by hand, and it confirms the sign and the factor $\tfrac14$.
- The eigenvalue formula and the threshold are untyped. The docstring and the INDEX row both say so, so this is no gap for the row.

## 6. L268_pd_pos

- **The hypotheses are weaker than the record's.** IsPD2 means strictly positive on every nonzero skew $X$. The theorem needs neither idempotency nor any condition on $A$, so it is stronger than the record's forward clause ("$C$ a positive-definite idempotent implies $\mu>0$").
- **The proof uses unit root vectors.** The test vectors are rootS $i\,j\,0$ (weight $U_{ij}$) and rootS $i\,j\,2$ (weight $V_{ij}$). They are nonzero by rootS_norm, and $\langle Cr,r\rangle=$ rootW by QF_root. The docstring says exactly this.
- **The statement is satisfiable.** The uniform point is positive definite by L268_torus_pd.

## 7. Docstrings of the new lemmas, axioms, screen

- **Most docstrings claim nothing beyond their statements.** This covers Ftri_pol (polarisation, exact), Ftri_It ($F(C,I_{\mathfrak t},I_{\mathfrak t})=0$ for every torus $C$, which the record's $L_{22}=0$ needs), Ftri_IR (at $A=A_\mu$ it gives $2(m-1)\cdot2y+2(m-2)\cdot2x=W$, the record's $L_{33}$) and cube_tangent (the tangent line at $b\ge0$, stated as proved). It also covers torusOp_add ("additive in its data", under the symmetry hypotheses it carries).
  - psi_core's docstring omits the side hypotheses $\kappa>0$, $t_0\ge0$ and $g>0$ but claims nothing false.
  - torusOp_smul has no docstring.
- **Two docstrings overclaim.** L273_F_bound claims the equality case (gap 1a). L269_phi_test equates the Rayleigh form with the eigenvalue claim (gap 4a, mild).
- **Axioms.** L273_F_bound, psi_bound, L273_J1_implies_H, L269_phi_test, L271_split, L268_pd_pos, Ftri_It and Ftri_IR each depend on [propext, Classical.choice, Quot.sound] only. The file's named `sorry`s (lines 1974, 1984, 1992, 2428) are not in their closure.
- **Screen (a check, not evidence).** I evaluated the Lean transcription of J1 on points I built, at $m=5$ and $m=6$.
  - It gives 0 to rounding at the uniform point and at both $\Lambda^2_+$ edge points (a single $U_{12}$ or a single $V_{12}$). These are the record's equality cases.
  - Over 20,000 random pair weights of either sign, and 20,000 positive ones, the maximum of $T+\lambda_mg^2-\lambda_m$ is $-0.29$ and $-0.13$ at $m=5$, and $-0.49$ and $-0.21$ at $m=6$.
  - Script: [j1screen.py](/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d3790d3b-3383-4c5d-9548-46ea15965c86/scratchpad/j1screen.py), run under sage -python.

## Repairs owed

1. **L273_F_bound:** prove the equality case, or cut it from the docstring and list it as owed in INDEX. Export $g\ge1/\sqrt m$ (currently `hgm`) or list it as owed.
2. **INDEX L273 row:** add the untyped clauses (1)'s equality case, $g\ge1/\sqrt m$ as a standalone statement, and (2)'s equality at $g=1/\sqrt m$ in the $\Psi$ form. Name the inherited L268 owe (every $T$-invariant symmetric operator is a torusOp) against (3).
3. **INDEX L269 row:** list "At $I/c$, $\Phi=0$", the invariance step that turns the witness into an eigenvalue, and the location clause as untyped.
4. **Record, L269:** change "the eigenvector lies in the projection of $\mathop{\mathrm{span}}\{I_{\mathfrak t},I_R\}$" to "a destabilising direction lies in ...". The 3-plane is $C\#$-invariant only at $I/c$ (gap 4c).
5. **Record headers of L268, L269, L271 and L273:** the "typed in" sentences still call prose what is now proved at the operator level: L268's idempotency equivalence, L269's $G$, $L$ entries and sign argument, L271's reduction of $F$, (3) and (4)'s polarisation, and L273's (1) and (3).
