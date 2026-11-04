# Review r1556: batch 38, Lemma F (two-component idempotents), the Casimir-ratio table and the F-form of the condition

Log: agent_logs/r1556.log

**Overall: REFUTED (with corrections).** Lemma F's algebra, its constants, the table rows and the Lean statements all hold. The sharpness claim fails: $G_2/SU(3)$ (the nearly-Kähler $S^6$, isotropy irreducible, inside the simple $\mathfrak g_2$) has Casimir ratio $4/9<1/2$, and Lemma F's own second root there is a positive-definite idempotent $C=\tfrac{9}{28}P_{\mathfrak{su}(3)}+\tfrac{3}{28}P_{\mathfrak p}\neq I/4$. That refutes statement U (L260) on a simple $\mathfrak h$.

| claim | verdict | reason in one line |
|---|---|---|
| F1 block relations | CONFIRMED | $P_k\#P_k=\tfrac12\mathrm{Cas}_k|_k$ and $P_k\#P_p=\tfrac12\mathrm{Cas}_k|_p$ by direct computation, cross block of $P_p\#P_p$ forced to vanish by $I\#I=cI$. The record states the relations without derivation (gap, conclusion true) |
| F2 Casimir identification | CONFIRMED | $c_1=\tfrac12\mathrm{Cas}_k(k)$, $2\alpha=\mathrm{Cas}_k(p)$, $c_1+x=c$, $2\alpha+y=c$, every factor of 2 checked against the rank-one definition |
| F3 quadratic and second root | CONFIRMED | quadratic, root $b=1/c$, product of roots, $y-x=c_1-2\alpha$ all correct; list $0,P_k/c_1,I/c,(a',b')$ complete |
| F4 positive-definiteness condition | CONFIRMED (gap) | "only if" and the bold U-on-the-ansatz sentence hold. The iff reading of the heading and the parenthetical "it would give a second PD idempotent" need $a'>0$, unproved in the text but true: $a'=cx/(c_1y^2+4\alpha^2x)$ |
| F5 trace form of the condition | CONFIRMED | $\mathop{\mathrm{tr}}_{\mathfrak g}\mathrm{Cas}_k=2c\,d_k$ since each unit $u$ has $-\mathop{\mathrm{tr}}\mathrm{ad}_u^2=2c$, and the rearrangement to $c_1\le 2c d_k/(N+d_k)$ is exact |
| F6 computed cases and table | REFUTED (sharpness and boundary claims) | all eight rows and both worked cases reproduce, but "on the two-component families U is sharp, and its boundary is $G_2\subset SO(7)$" is false: $G_2/SU(3)$ has ratio $4/9$ |
| F7 F-form of the condition | CONFIRMED (gap) | $y\,d_p=F(P_p,P_p,P_p)$, $x\,d_k=\alpha\,d_p$, equivalence with $y\le x$ exact. "$x>0$ automatic" also needs $\alpha>0$, true because $\alpha=0$ would make $\mathfrak k$ an ideal |
| F8 Lean statements | CONFIRMED | twocomp_factor, twocomp_pd_unique and IsotropyPair.pd_unique say what the prose says, hypotheses match, file compiles |
| F9 U itself (L260) | REFUTED | the $G_2/SU(3)$ second root is a PD idempotent on the simple $\mathfrak g_2$ other than $I/c$ |

## Method

Read the quoted chain link by link and derived each step from the rank-one definition of $\#$. Read the three Lean declarations and compiled [I117LemmaF.lean](../lean/HamiltonsCubic/Results/I117LemmaF.lean) with `lake env lean` (clean). Screens, reported as screens only: (i) a numpy construction of $\mathfrak g_2\subset\mathfrak{so}(7)$ as the stabiliser of the octonion 3-form and $\mathfrak{su}(3)\subset\mathfrak g_2$ as the stabiliser of $e_1$, evaluating $I\#I$, the three block products and $C\#C-C$ for Lemma F's second root, for $G_2/SU(3)$ and $SO(7)/G_2$ (seconds); (ii) Sage Weyl-character decompositions of $\Lambda^2\rho$ for the $SU(8)$, $\mathrm{Spin}(16)$, $\mathrm{Spin}(9)$, $F_4$ rows. The $G_2/SU(3)$ refutation is derived by hand below from Lemma F and classical Casimir values. The screen only corroborates it.

## F1. Block relations

With $P_U\#P_V=\tfrac12\sum_{i,j}[u_i,v_j][u_i,v_j]^T$ and invariance $\langle[u,u'],w\rangle=\langle u',[w,u]\rangle$:

- For $w\in\mathfrak k$: $(P_k\#P_k)w=\tfrac12\sum_{u,u'}[u,u']\langle u',[w,u]\rangle=\tfrac12\sum_u[u,[w,u]]=\tfrac12\mathrm{Cas}_k w$, using $[w,u]\in\mathfrak k$. The image lies in $\mathfrak k$, so $P_k\#P_k=\tfrac12\mathrm{Cas}_k|_{\mathfrak k}$. "One induced Casimir value" is exactly what makes this scalar, and it is used nowhere else.
- $[\mathfrak k,\mathfrak p]\subset\mathfrak p$ because $\langle[u,v],u'\rangle=-\langle v,[u,u']\rangle=0$. The same computation gives $P_k\#P_p=\tfrac12\mathrm{Cas}_k|_{\mathfrak p}$ with image in $\mathfrak p$, so there is no $\mathfrak k$-component and no cross term.
- $\mathrm{Cas}_k|_{\mathfrak p}$ is symmetric and commutes with $\mathfrak k$, so its eigenspaces are $\mathfrak k$-invariant and irreducibility makes it scalar. This holds whatever the commutant type (real, complex, quaternionic): no Schur-over-$\mathbb R$ subtlety arises because the operator is symmetric.
- $P_p\#P_p=cI-P_k\#P_k-2P_k\#P_p=(c-c_1)P_k+(c-2\alpha)P_p$. The cross block and the non-scalar parts vanish because the other three terms have none. So the "Schur step" the Lean docstring mentions is unnecessary. $I\#I=cI$ does it.
- $\alpha>0$: if $\alpha=0$ then $[\mathfrak k,\mathfrak p]=0$, so $[\mathfrak k,\mathfrak g]\subset\mathfrak k$ and $\mathfrak k$ is a proper ideal of simple $\mathfrak g$. The record uses $\alpha>0$ (it divides by $2\alpha$) without saying so.
- Every table row has $K$ simple, so one Casimir value holds. The principal $SO(3)$ is simple.

The record asserts these relations with no argument in the quoted section, which is a gap in the written chain. The conclusion is true.

## F2. Constants

$\langle I\#I,ww^T\rangle=\tfrac12\sum_{i,j}\langle[e_i,e_j],w\rangle^2=\tfrac12(-\mathop{\mathrm{tr}}\mathrm{ad}_w^2)$, so $c=\tfrac12\mathrm{Cas}_{\mathfrak g}(\mathfrak g)$. For $\mathfrak{so}(n)$ that gives $\mathrm{Cas}_{\mathfrak g}(\mathfrak g)=2(n-2)$, matching the table's trace identity. $c_1=\tfrac12\mathrm{Cas}_k(k)$ and $\alpha=\tfrac12\mathrm{Cas}_k(p)$ from F1. $c_1+x=c$ and $2\alpha+y=c$ from the $\mathfrak k$ and $\mathfrak p$ blocks of $I\#I=P_k\#P_k+2P_k\#P_p+P_p\#P_p$. The screen on $SO(7)/G_2$ returns $c=5$, $c_1=4$, $\alpha=2$, $x=y=1$ with residuals below $10^{-14}$.

## F3. Idempotents

$C\#C=(a^2c_1+b^2x)P_k+(2ab\alpha+b^2y)P_p$. With $b=0$: $a\in\{0,1/c_1\}$. With $b\ne0$: $a=(1-by)/(2\alpha)$, and substituting into $a^2c_1+b^2x=a$ times $4\alpha^2$ gives $b^2(c_1y^2+4\alpha^2x)+2by(\alpha-c_1)+(c_1-2\alpha)=0$, as written. $b=1/c$ gives $a=(c-y)/(2\alpha c)=1/c$, the idempotent $I/c$. The product of roots is $(c_1-2\alpha)/D$ with $D=c_1y^2+4\alpha^2x$, so $b'=c(c_1-2\alpha)/D=c(y-x)/D$, using $y-x=(c-2\alpha)-(c-c_1)$. The list is complete. When $b'=0$ (so $c_1=2\alpha$), the root gives $a'=1/c_1$, which is $P_k/c_1$ again: the $G_2\subset SO(7)$ "merging" is correct. A further edge case: $b'=1/c$ (a double root), where the second root is $I/c$ itself.

## F4. Positive definiteness

$D>0$, so $b'>0$ iff $y>x$ iff $c_1>2\alpha$ iff $\mathrm{Cas}_k(p)<\tfrac12\mathrm{Cas}_k(k)$. The "only if" holds. So does the bold sentence: with $y\le x$ the only PD idempotent of the ansatz is $I/c$, since $b>0$ excludes $b=0$ and $b'\le0$. That is U restricted to the ansatz, and "U holds on every such family" should say "on the ansatz $aP_k+bP_p$" as L262 does.

The converse is asserted twice: in the heading ("U on every two-component family is a Casimir-ratio inequality") and in the parenthetical "(it would give a second positive-definite idempotent and refute U)". The text proves neither. It is true:
$$D-c(y-x)y=2\alpha x c\quad\Longrightarrow\quad a'=\frac{1-b'y}{2\alpha}=\frac{c\,x}{c_1y^2+4\alpha^2x}>0\ \text{always}.$$
(Substitute $y=x+s$, $s=c_1-2\alpha$, $c=c_1+x$. The numerator reduces to $x[(c_1-s)(x+s)+4\alpha^2]=2\alpha x(y+2\alpha)$.) Check: principal $SO(3)$ gives $a'=3\cdot2.8/16.2=14/27$, and $G_2$ gives $5/20=1/4$. So ratio $<\tfrac12$ (and $b'\ne1/c$) gives a second PD idempotent. That line should be added to the record, because F6 and F9 turn on it.

## F5. Trace identity

$\mathop{\mathrm{tr}}_{\mathfrak g}\mathrm{Cas}_k=\sum_u(-\mathop{\mathrm{tr}}_{\mathfrak g}\mathrm{ad}_u^2)=d_k\cdot2c$ by F2. So $d_k\,2c_1+d_p\,2\alpha=2c\,d_k$, the same as $x\,d_k=\alpha\,d_p$. Then $2\alpha\ge c_1\iff 2(c-c_1)d_k\ge c_1d_p\iff c_1\le 2c\,d_k/(N+d_k)$. Exact.

## F6. Cases and table

Each row reproduced with $\ell_\rho$ = Dynkin's original index (vector of $\mathfrak{so}(m)$, $m\ge5$, equal to 2):

- $G_2$ on $\mathbb R^7$: $\ell=2$, $h^\vee=4$, $8$, $14\cdot2/7=4$, ratio $\tfrac12$. $c_1=4=2\cdot5\cdot14/35$, second root $(1/4,0)$. Screen agrees.
- $\mathrm{Spin}(7)$ on $\mathbb R^8$: $\ell=2$, $h^\vee=5$, $10$, $21\cdot2/7=6$, $0.6$. $\Lambda^2\mathbb R^8=21\oplus7$ with the $7$ the vector of $\mathfrak{so}(7)$. This is the triality image of the symmetric pair $SO(8)/SO(7)$, so $y=0$ and $2\alpha=c=6$, consistent.
- $\mathrm{Spin}(9)$ on $\mathbb R^{16}$: $\ell=4$, $h^\vee=7$, $7$, $36\cdot21/84=9$, $9/7$. Sage: $\Lambda^2 16=36\oplus84$.
- $F_4$ on $\mathbb R^{26}$: $\ell=6$, $h^\vee=9$, $6$, $52\cdot42/273=8$, $4/3$. Sage: $\Lambda^2 26=52\oplus273$.
- adjoint: $\ell=2h^\vee$, $2$, $d_k(2d_k-6)/(d_k(d_k-3)/2)=4$, $2$. $\Lambda^2\mathfrak k\ominus\mathfrak k$ is real-irreducible for every simple $\mathfrak k$ except $\mathfrak{su}(2)$, where $\mathfrak p=0$ and the row's formula reads $0/0$. The row should exclude $SU(2)$.
- $\mathrm{Spin}(16)$ on $\mathbb R^{128}$: $\ell=32$, $h^\vee=14$, $1.75$, $120\cdot250.25/8008=3.75$, $2.14$. Sage: complement $V(\omega_6)$ of dimension $8008$.
- $SU(8)$ on $\mathbb R^{70}$: $\ell=70\cdot18/63=20$, $h^\vee=8$, $1.6$, $63\cdot134.4/2352=3.6$, $2.25$. Sage: $\Lambda^2 70=63\oplus2352$.
- principal $SO(3)$ on $\mathbb R^5$: direct computation with $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}_5XY$ gives internal mass $2/5=0.4$, and $3(6-0.4)/7=2.4$, ratio $6$. $\mathfrak{so}(5)=V_1\oplus V_3$ under the principal $\mathfrak{so}(3)$. $c=3$, $c_1=0.2$, $\alpha=1.2$, $x=2.8$, $y=0.6$, $D=16.2$, $(a',b')=(14/27,-11/27)$, all confirmed. Convention note: $\ell=10$ requires $h^\vee(\mathfrak{so}(3))=1$ in L256's formula (the $\mathfrak{so}(m)$ value $m-2$), while the $A_1$ reading gives $h^\vee=2$ with $\ell=20$. The two agree on $\mathrm{Cas}=0.4$, but the text should say which it uses.

**The sharpness claims fail.** The heading ("tight at $G_2\subset SO(7)$"), the bold sentence "So on the two-component families U is sharp, and its boundary is $G_2\subset SO(7)$", and "The smallest $\mathfrak p$ relative to $\mathfrak k$ in the cases computed is $G_2$'s" are read as the minimum of the ratio over Lemma F's hypothesis class. That class is every isotropy-irreducible pair inside any compact simple $\mathfrak g$, and the table covers only $K\subset SO(n)$. Counterexample, $\mathfrak g=\mathfrak g_2\supset\mathfrak k=\mathfrak{su}(3)$, $\mathfrak p=\mathbb C^3$ realified (6-dim, real-irreducible of complex type, non-symmetric):

- $\mathfrak{su}(3)$ is the long-root subalgebra (embedding index 1), so $\mathrm{Cas}_k(k)/\mathrm{Cas}_{\mathfrak g}(\mathfrak g)=h^\vee(A_2)/h^\vee(G_2)=3/4$, $\mathrm{Cas}_k(k)=\tfrac32c$, $c_1=\tfrac34c$.
- Trace identity: $8\cdot\tfrac32c+6\,\mathrm{Cas}_k(p)=16c$, so $\mathrm{Cas}_k(p)=\tfrac23c$, and the ratio is $4/9$. Independent check: $C(\mathbf 3)/C(\mathbf 8)=(8/3)/6=4/9$ with long roots of length$^2$ 2.
- $\alpha=c/3$, $x=c/4$, $y=c/3>x$. $D=c^3(1/12+1/9)=7c^3/36$, so $b'=3/(7c)>0$ and $a'=cx/D=9/(7c)>0$.
- Screen (numpy, $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}_7$ on $\mathfrak g_2$): $c=4$, $c_1=3$, $\alpha=4/3$, $x=1$, $y=4/3$, block residuals below $3\cdot10^{-15}$, and $C=\tfrac9{28}P_k+\tfrac3{28}P_p$ gives $|C\#C-C|=2\cdot10^{-16}$.

So the claim "no isotropy-irreducible pair has ratio below $\tfrac12$" is false. The record's closing sentence (a Wolf pass "is owed before 'every two-component family' can be claimed") is honest, but it contradicts the heading and the bold sentence above it. Correction: delete "U is sharp, and its boundary is $G_2\subset SO(7)$" and "tight at $G_2\subset SO(7)$", and record $G_2/SU(3)$ as a counterexample to U.

## F7. F-form

$F(P_p,P_p,P_k)=\mathop{\mathrm{tr}}((xP_k+yP_p)P_k)=x\,d_k$, $F(P_k,P_p,P_p)=\mathop{\mathrm{tr}}(\alpha P_pP_p)=\alpha\,d_p$, $F(P_p,P_p,P_p)=y\,d_p$. So $y\le x$ is exactly $F(P_p,P_p,P_p)/d_p\le F(P_p,P_p,P_k)/d_k$. The reading "the $\mathfrak p$-part of $[\mathfrak p,\mathfrak p]$ per dimension" matches $F(P_p,P_p,P_W)=\tfrac12\sum\langle[v,v'],w\rangle^2$. For symmetric pairs the left side is $0$. "$x>0$ automatic" needs $\alpha>0$ as well (F1), which the text leaves unstated. $G_2/SU(3)$: $F(ppp)/d_p=4/3>1=F(ppk)/d_k$, so the pair violates the condition, consistent with F6.

## F8. Lean fidelity

- twocomp_factor: hypotheses $c_1+x=c$, $2\alpha+y=c$, the two coefficient equations and $b\ne0$, conclusion the stated factorisation. The prose's factorisation lives in the $b\ne0$ branch, so this matches, and nothing is vacuous.
- twocomp_pd_unique: $x,\alpha,c_1>0$, $y\le x$, $b>0$ imply $a=b=1/c$. This matches the prose. $x>0$ and $\alpha>0$ are consistent with the geometric case (F1, F7), so the hypotheses are satisfiable, e.g. by $SO(7)/G_2$.
- IsotropyPair.pd_unique: the structure's fields are the block relations, the two sum rules and linear independence of $P_k,P_p$ (needed to read off coefficients, and true when $\mathfrak k,\mathfrak p\ne0$). sharp_C and idempotent_coeffs are correct, and pd_unique reduces to the scalar lemma. The Lean statements do not cover the idempotent list or the converse, and the prose does not claim they do. The file compiles clean.

## F9. U itself

L260's U says the PD idempotents on a compact simple $\mathfrak h$ are exactly $I/c$. On $\mathfrak h=\mathfrak g_2$ the operator $C=\tfrac{9}{7c}P_{\mathfrak{su}(3)}+\tfrac{3}{7c}P_{\mathfrak p}$ is positive definite and satisfies $C\#C=C$ (proved by hand from Lemma F plus $C(\mathbf3)/C(\mathbf8)=4/9$, corroborated by the screen). U is false as stated. Everything in the record that cites U as established (I117's PSD reduction, and whatever rests on it) needs its dependence traced. Other scope notes: the adjoint row needs $SU(2)$ excluded, and the double-root edge ($b'=1/c$) should be named in the converse.
