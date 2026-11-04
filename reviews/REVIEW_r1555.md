# Review r1555: batch 38, Lemma F (two-component idempotents), the Casimir-ratio table and the F-form of the condition

Log: agent_logs/r1555.log

**Headline: Lemma F is correct, and it refutes U.** The isotropy-irreducible pair $SU(3)\subset G_2$ (the nearly Kähler $S^6=G_2/SU(3)$, $\mathfrak p=\mathbb C^3$ of complex type) has Casimir ratio $4/9<1/2$, so Lemma F produces the positive-definite idempotent $C=\tfrac{9}{28}P_{\mathfrak{su}(3)}+\tfrac{3}{28}P_{\mathfrak p}\ne I/4$ on the compact simple $\mathfrak g_2$. U (L260) says $I/4$ is the only one. The bold claim "U is sharp, and its boundary is $G_2\subset SO(7)$" is false.

| claim | verdict | reason in one line |
|---|---|---|
| F1 block relations | CONFIRMED | $P_{\mathfrak k}\#P_{\mathfrak k}=\tfrac12\mathrm{Cas}_{\mathfrak k}\vert_{\mathfrak k}$ and $P_{\mathfrak k}\#P_{\mathfrak p}=\tfrac12\mathrm{Cas}_{\mathfrak k}\vert_{\mathfrak p}$ exactly. $P_{\mathfrak p}\#P_{\mathfrak p}$ then follows from $I\#I=cI$, so it needs no Schur step. Real irreducibles of complex or quaternionic type are fine. |
| F2 Casimir identification | CONFIRMED | $c_1=\tfrac12\mathrm{Cas}_{\mathfrak k}(\mathfrak k)$, $2\alpha=\mathrm{Cas}_{\mathfrak k}(\mathfrak p)$, $c=\tfrac12\mathrm{Cas}_{\mathfrak g}(\mathfrak g)$, and every factor of 2 checks against $(vv^T)\#(ww^T)=\tfrac12[v,w][v,w]^T$ |
| F3 quadratic and second root | CONFIRMED | quadratic, root $1/c$, product of roots and the list $\{0,P_{\mathfrak k}/c_1,I/c,(a',b')\}$ are complete. Closed form: $a'=cx/D$, $b'=c(y-x)/D$, $D=c_1y^2+4\alpha^2x$ |
| F4 positive-definiteness condition | CONFIRMED WITH GAP | "only if" holds. The converse (used by the heading and by "it would give a second positive-definite idempotent") is also true, because $a'=cx/D>0$ always, but the record never proves it |
| F5 trace form of the condition | CONFIRMED | $\mathop{\mathrm{tr}}_{\mathfrak g}\mathrm{Cas}_{\mathfrak k}=2c\,d_{\mathfrak k}$, and $2\alpha\ge c_1\iff c_1\le 2c\,d_{\mathfrak k}/(N+d_{\mathfrak k})$ |
| F6 computed cases and table | REFUTED (with corrections) | all eight rows, the $G_2$ case and the principal $SO(3)$ case are arithmetically right. "U is sharp, its boundary is $G_2\subset SO(7)$" is false: $SU(3)\subset G_2$ has ratio $4/9$. The table covers only ambient $SO(n)$ |
| F7 F-form of the condition | CONFIRMED | $y\,d_{\mathfrak p}=F(P_{\mathfrak p},P_{\mathfrak p},P_{\mathfrak p})$, $x\,d_{\mathfrak k}=F(P_{\mathfrak p},P_{\mathfrak p},P_{\mathfrak k})=\alpha d_{\mathfrak p}$, and the inequality is exactly $y\le x$ |
| F8 Lean statements | CONFIRMED | twocomp_factor, twocomp_pd_unique and IsotropyPair.pd_unique say what the prose says. The one extra hypothesis, $b\ne0$ in twocomp_factor, matches the prose's branch |
| F9 other | REFUTED (upstream) | U of L260 fails on $\mathfrak g_2$. There are also scope gaps: ambient groups other than $SO(n)$, non-simple $K$ with equal Casimirs, and the fact that U on the ansatz is weaker than U on $\mathfrak g$ |

## Method

- I read the quoted chain link by link, then derived F1 to F7 by hand from the definition of $\#$ on rank ones.
- Screen (seconds, numpy under `sage -python`, a script in the session scratchpad, reported as a screen and never as a proof). I built $\mathfrak g_2\subset\mathfrak{so}(7)$ as the annihilator of the octonionic 3-form, $\mathfrak{su}(3)$ as the stabiliser of $e_1$ inside it, and the principal $\mathfrak{so}(3)\subset\mathfrak{so}(5)$ from the spin-2 action on traceless symmetric $3\times3$ matrices. The inner product was $-\tfrac12\mathop{\mathrm{tr}}$, restricted. For each pair I computed $P_U\#P_V=\tfrac12\sum[u_i,v_j][u_i,v_j]^T$ in an adapted orthonormal basis, read off $c,c_1,\alpha,x,y$ with the residuals of the block relations, and evaluated $C\#C-C$ at the second root.
- Screen output. The block-relation residuals are all at most $4\cdot10^{-15}$.

| pair | $c$ | $c_1$ | $\alpha$ | $x$ | $y$ | ratio | $(a',b')$ | $\vert C\#C-C\vert$ |
|---|---|---|---|---|---|---|---|---|
| $G_2\subset SO(7)$ | 5 | 4 | 2 | 1 | 1 | 0.5 | (0.25, 0) | $2\cdot10^{-16}$ |
| $SU(3)\subset G_2$ | 4 | 3 | 4/3 | 1 | 4/3 | 0.444 | (0.3214, 0.1071) = (9/28, 3/28) | $2\cdot10^{-16}$ |
| principal $SO(3)\subset SO(5)$ | 3 | 0.2 | 1.2 | 2.8 | 0.6 | 6 | (14/27, −11/27) | $2\cdot10^{-16}$ |

## F1. Block relations

- Write $P_U=\sum u_iu_i^T$. Bilinearity gives $P_U\#P_V=\tfrac12\sum_{i,j}[u_i,v_j][u_i,v_j]^T$. Using $\langle[u,v],w\rangle=-\langle v,[u,w]\rangle$, this operator is $-\tfrac12\sum_i\mathrm{ad}_{u_i}P_V\,\mathrm{ad}_{u_i}$.
- $\mathfrak p=\mathfrak k^\perp$ is $\mathfrak k$-invariant by ad-invariance, and $\mathfrak k$ is a subalgebra. So $P_{\mathfrak k}\#P_{\mathfrak k}=\tfrac12\mathrm{Cas}_{\mathfrak k}\vert_{\mathfrak k}\oplus0$ and $P_{\mathfrak k}\#P_{\mathfrak p}=0\oplus\tfrac12\mathrm{Cas}_{\mathfrak k}\vert_{\mathfrak p}$ exactly. Neither has a cross term, and $P_{\mathfrak k}\#P_{\mathfrak p}$ has no $\mathfrak k$-component.
- "One induced Casimir value" is exactly the hypothesis that $\mathrm{Cas}_{\mathfrak k}\vert_{\mathfrak k}$ is scalar. Irreducibility of $\mathfrak p$ is used only to make $\mathrm{Cas}_{\mathfrak k}\vert_{\mathfrak p}$ scalar. It does that for every real type: $\mathrm{Cas}_{\mathfrak k}\vert_{\mathfrak p}$ is a symmetric element of the commutant $\mathbb R$, $\mathbb C$ or $\mathbb H$, and the symmetric elements there are the real scalars, since the imaginary units act skew.
- $P_{\mathfrak p}\#P_{\mathfrak p}=cI-P_{\mathfrak k}\#P_{\mathfrak k}-2P_{\mathfrak k}\#P_{\mathfrak p}=(c-c_1)P_{\mathfrak k}+(c-2\alpha)P_{\mathfrak p}$. The absence of cross terms here is forced by $I\#I=cI$. The Schur step the Lean docstring attributes to this block is unnecessary, which makes the lemma strictly easier than stated. The weaker hypothesis "$\mathrm{Cas}_{\mathfrak k}$ scalar on $\mathfrak p$" suffices.
- Every row of the table has $K$ simple, so every row satisfies one Casimir value. $SU(3)\subset G_2$ (complex type) satisfies all the hypotheses, and the screen confirms the block relations there to $10^{-15}$.
- $\alpha>0$ holds automatically. If $\mathrm{Cas}_{\mathfrak k}(\mathfrak p)=0$ then $[\mathfrak k,\mathfrak p]=0$, so $[\mathfrak p,\mathfrak p]\perp\mathfrak k$ and $\mathfrak g=\mathfrak k\oplus\mathfrak p$ as ideals, which contradicts simplicity.

## F2. Constants

- $c_1+x=c$ and $2\alpha+y=c$ follow by construction (F1).
- $c=\tfrac12\mathrm{Cas}_{\mathfrak g}(\mathfrak g)$: $\langle(I\#I)w,w\rangle=\tfrac12\sum_i\vert[e_i,w]\vert^2$. For $\mathfrak{so}(n)$ with $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}XY$ the Killing form is $(n-2)\mathop{\mathrm{tr}}$, so $-\mathop{\mathrm{tr}}\mathrm{ad}_X^2=2(n-2)$ and $c=n-2$. The screen gives $c=5$ for $\mathfrak{so}(7)$ and $c=3$ for $\mathfrak{so}(5)$.
- $c_1=\tfrac12\mathrm{Cas}_{\mathfrak k}(\mathfrak k)$ and $2\alpha=\mathrm{Cas}_{\mathfrak k}(\mathfrak p)$, from F1. Every factor of 2 is correct.

## F3. The quadratic and the list

- $C\#C=(a^2c_1+b^2x)P_{\mathfrak k}+(2ab\alpha+b^2y)P_{\mathfrak p}$. The $P_{\mathfrak p}$ equation is $b(2a\alpha+by-1)=0$.
- The branch $b=0$ gives $a^2c_1=a$, so $0$ or $P_{\mathfrak k}/c_1$. The record reaches these two without writing the branch, but they are the right two.
- The branch $b\ne0$: substituting $a=(1-by)/(2\alpha)$ and multiplying by $4\alpha^2$ gives exactly the stated quadratic. $b=1/c$ is a root, since $(2\alpha+y)/c=1$ and $(c_1+x)/c^2=1/c$. The product of the roots is $(c_1-2\alpha)/D$, so $b'=c(c_1-2\alpha)/D=c(y-x)/D$, using $y-x=c_1-2\alpha$.
- $1-b'y=\big(D-cy(y-x)\big)/D$, and substituting $c=c_1+x$, $y-x-c_1=-2\alpha$ gives $D-cy(y-x)=2\alpha x c$. So **$a'=cx/D$**. The screen reproduces this value in all three cases.
- The list is complete. When $y=x$ one has $b'=0$ and $a'=1/(2\alpha)=1/c_1$, so the second root falls into the $b=0$ branch as $P_{\mathfrak k}/c_1$ for every pair with $y=x$, $G_2$ being one of them.
- Symmetric case: $y=0$ gives $2\alpha=c$, $b'=-1/c$ and $a'=1/c$, which is $\sigma/c$. This agrees with Lemma E / L262.

## F4. Positive definiteness

- "Positive definite only if $\mathrm{Cas}_{\mathfrak k}(\mathfrak p)<\tfrac12\mathrm{Cas}_{\mathfrak k}(\mathfrak k)$" follows, because $b'>0\iff y>x\iff c_1>2\alpha$.
- The converse is used but not proved. The heading ("is a Casimir-ratio inequality") and the sentence "ratio below $\tfrac12$ ... would give a second positive-definite idempotent and refute U" both need it. It is true, because $a'=cx/D>0$ always (F3) and $x>0$. So for ratio $<\tfrac12$ the second root is positive definite, and it is distinct from $I/c$ unless the quadratic has a double root ($c^2(y-x)=D$). This is a gap in the argument with a true conclusion. Add the line $a'=cx/D$.
- "U holds on every such family with ratio $\ge\tfrac12$" is established on the ansatz. $0$ and $P_{\mathfrak k}/c_1$ are singular, and $b'\le0$. "On the family" has to be read as on the ansatz $aP_{\mathfrak k}+bP_{\mathfrak p}$, which is weaker than U on $\mathfrak g$ (see F9).

## F5. Trace identity

- $\mathop{\mathrm{tr}}_{\mathfrak g}\mathrm{Cas}_{\mathfrak k}=\sum_u(-\mathop{\mathrm{tr}}_{\mathfrak g}\mathrm{ad}_u^2)=d_{\mathfrak k}\cdot2c$ by F2. So $c_1d_{\mathfrak k}+\alpha d_{\mathfrak p}=c\,d_{\mathfrak k}$.
- Then $2\alpha\ge c_1\iff2(c-c_1)d_{\mathfrak k}\ge c_1d_{\mathfrak p}\iff c_1\le2c\,d_{\mathfrak k}/(N+d_{\mathfrak k})$. For $G_2$ the bound is $140/35=4=c_1$. Confirmed.

## F6. Cases and table

- **Row checks.** In each row $\mathfrak p=\mathfrak{so}(n)\ominus\mathfrak k$, not $\mathbb R^n$. The dimension and Casimir checks below use the independent formula $\mathrm{Cas}_{\mathfrak k}(\mathfrak p)=C_{\mathrm{norm}}(\mathfrak p)\cdot2/\ell_\rho$.

| row | $\ell_\rho$ | $h^\vee$ | $\mathrm{Cas}_{\mathfrak k}(\mathfrak k)$ | $\mathrm{Cas}_{\mathfrak k}(\mathfrak p)$ | ratio | independent check |
|---|---|---|---|---|---|---|
| $G_2$ | 2 | 4 | 8 | $14(10-8)/7=4$ | 0.5 | vector Casimir 4, screen |
| $\mathrm{Spin}(7)$ | 2 | 5 | 10 | $21\cdot2/7=6$ | 0.6 | vector Casimir 6. Also $y=6-6=0$ as symmetric |
| $\mathrm{Spin}(9)$ | 4 | 7 | 7 | $36\cdot21/84=9$ | 1.29 | $\mathfrak p=\Lambda^3\mathbb R^9$, $3\cdot6\cdot2/4=9$ |
| $F_4$ | 6 | 9 | 6 | $52\cdot42/273=8$ | 1.33 | |
| adjoint | $2h^\vee$ | | 2 | $d(2(d-3))/(d(d-3)/2)=4$ | 2 | |
| $\mathrm{Spin}(16)$ | 32 | 14 | 1.75 | $120\cdot250.25/8008=3.75$ | 2.14 | $\mathfrak p=\Lambda^6\mathbb R^{16}$, $60\cdot2/32=3.75$ |
| $SU(8)$ | 20 | 8 | 1.6 | $63\cdot134.4/2352=3.6$ | 2.25 | |
| principal $SO(3)$ | 10 | 1 | 0.4 | $3\cdot5.6/7=2.4$ | 6 | spin 3 against spin 1: $12/2=6$, screen |

- The principal $SO(3)$ row needs $h^\vee=1$, which follows from normalising the vector (adjoint) of $\mathfrak{so}(3)$ to $\ell=2$. The table shows no $h^\vee$ column, so this is consistent but implicit.
- $\mathrm{Spin}(7)\subset SO(8)$ is the triality image of $SO(7)$, so the pair is symmetric. Confirmed, and $y=0$ agrees.
- The irreducibility of $\mathfrak p$ in the adjoint, $\mathrm{Spin}(16)$ and $SU(8)$ rows rests on Wolf's list, which is quoted input. The adjoint case is of complex type for $SU(n)$, and F1 covers that.
- The $G_2$ claims check (ratio exactly $\tfrac12$, $c_1=4$ equal to the bound, second root $(\tfrac14,0)=P_{\mathfrak g_2}/c_1$), and so does $(14/27,-11/27)$ for principal $SO(3)$. By hand and on the screen.
- **Refutation of the boundary claim.** $SU(3)\subset G_2$ is isotropy irreducible, non-symmetric and in Wolf's list ($G_2/SU(3)=S^6$). $\mathfrak{su}(3)$ is the long-root subalgebra, so the normalised form restricts to the normalised form.
  - $\mathrm{Cas}(\mathfrak k)=2h^\vee(\mathfrak{su}_3)=6$ and $\mathrm{Cas}(\mathfrak p)=C_2(\text{fund})=8/3$, with $c=\tfrac12\cdot2h^\vee(\mathfrak g_2)=4$.
  - Trace check: $8\cdot6+6\cdot\tfrac83=64=2\cdot4\cdot8$.
  - So $c_1=3$, $\alpha=4/3$, $x=1$, $y=4/3$, ratio $4/9<\tfrac12$ and $D=112/9$.
  - $(a',b')=(9/28,3/28)$. By hand, $a^2c_1+b^2x=\tfrac{243+9}{784}=\tfrac{9}{28}$ and $2a\alpha+by=\tfrac{24+4}{28}=1$. The screen gives $\vert C\#C-C\vert=2\cdot10^{-16}$.
  - This positive-definite idempotent differs from $I/4$.
- **Corrections.** Withdraw "So on the two-component families U is sharp, and its boundary is $G_2\subset SO(7)$", and the implicit claim that no isotropy-irreducible pair falls below $\tfrac12$. The table is correct only as a list of its eight rows, and it covers only ambient $SO(n)$.
- **Internal inconsistency.** The closing sentence ("a full pass over Wolf's table is owed before 'every two-component family' can be claimed") already contradicts the bold sentence and the heading, which state the conclusion as established. The pass would have failed at its second non-$SO(n)$ entry.

## F7. F-form

- $F(P_{\mathfrak p},P_{\mathfrak p},P_{\mathfrak p})=\mathop{\mathrm{tr}}\big((xP_{\mathfrak k}+yP_{\mathfrak p})P_{\mathfrak p}\big)=y\,d_{\mathfrak p}$.
- $F(P_{\mathfrak p},P_{\mathfrak p},P_{\mathfrak k})=x\,d_{\mathfrak k}$, and by symmetry this equals $F(P_{\mathfrak k},P_{\mathfrak p},P_{\mathfrak p})=\alpha d_{\mathfrak p}$. So $x>0$.
- The stated inequality is $y\le x$ verbatim. Confirmed. For $SU(3)\subset G_2$ the left side is $4/3$ and the right side is $1$, so the F-form correctly flags the failure.

## F8. Lean fidelity

- twocomp_factor carries $b\ne0$. This matches the prose, which derives the quadratic from $2a\alpha+by=1$ (the $b\ne0$ branch).
- twocomp_pd_unique and IsotropyPair.pd_unique conclude from $b>0$ alone, which is stronger than positive definiteness. Their hypotheses $x,\alpha,c_1>0$ are all automatic (F1, F7).
- The IsotropyPair fields are the block relations as data. They are satisfiable (the $G_2\subset SO(7)$ instance), so the structure is not vacuous.
- The Lean layer types neither the second-root formula nor the converse of F4. The prose does not claim it does.
- The IsotropyPair docstring lists "the Schur step" for the block relations. Per F1, only the scalarity of $\mathrm{Cas}_{\mathfrak k}$ on $\mathfrak k$ and on $\mathfrak p$ is needed. This is a harmless overstatement of what the Lie theory must supply.

## F9. Other findings

- **U (L260) is refuted on $\mathfrak g_2$** by the idempotent above: a compact simple $\mathfrak h$ with a positive-definite idempotent other than $I/c$. Everything downstream that assumes U needs revisiting. L262 (symmetric pairs) is unaffected.
- **Scope, ambient group.** The standard-list table has only $K\subset SO(n)$. Wolf's list also has ambient $G_2$, $F_4$, $E_n$, $SU(n)$ and $Sp(n)$, and its first non-$SO$ entry fails.
- **Scope, non-simple $K$.** A non-simple $K$ with all ideals at one Casimir value (for example $SO(m)\times SO(m)\subset SO(m^2)$, or $SU(m)\times SU(m)\subset SU(m^2)$) also satisfies Lemma F's hypotheses, and none is tabulated.
- **Ansatz and U.** "U holds on the family" is U restricted to the two-parameter ansatz, not U on $\mathfrak g$. The heading's "U on every two-component family" should say so.
