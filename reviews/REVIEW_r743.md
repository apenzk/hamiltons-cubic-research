# r743, Ricci-flatness and first Bianchi for the Kähler family $W_{a,b}=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$: are the two conditions the same one line?

**Cold review from [BRIEF-g2-l166.md](BRIEF-g2-l166.md), on the brief alone.** I read no findings file and no other reviewer's report before forming the verdict below. Every derivation here is by hand and every value is exact rational arithmetic. One **screen** was run (exact `Fraction` matrices at $m=2,3,4,5$, seconds of compute on objects built for that purpose) and it reproduces every number I derived; it is reported as a screen and is cited nowhere as evidence for a positive claim. Log at [agent_logs/g2-l166-r743.log](../agent_logs/g2-l166-r743.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| **S** | For $m\ge2$: Ricci-flat $\iff$ first Bianchi $\iff am+b(m+2)=0$; $W_{a,b}\in\mathcal W_{2m}$ exactly on the line $(a,b)\propto(m+2,-m)$ | **CONFIRMED**, derived independently, both halves, every $m\ge2$ |
| **P1** | $\mathfrak{su}(m)=\{X+iY\}$, $X$ real skew, $Y$ real symmetric traceless; the bivector spanning sets, the $\tfrac1{\sqrt2}$, and $p+q=m^2-1$ | **CONFIRMED**, each spanning element derived from its operator; the bases are orthonormal for the stated pairing |
| **P2** | $\mathrm{Ric}(W)=\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ is the right normalisation | **CONFIRMED, and exact rather than up to a constant**, it *equals* the metric trace $\sum_c R(x,u_c,y,u_c)$, no factor. Nothing downstream reads a value |
| **P3a** | $C_{\mathfrak{su}(m)}$ scalar on $\mathbb C^m$ by Schur | **CONFIRMED**, the Casimir is complex-linear, and complex Schur applies at every $m\ge2$ |
| **P3b** | $C_{\mathfrak k}$ scalar because $\mathbb C^m|_{\mathfrak{so}(m)}$ is two copies of one real irreducible on which $C$ acts identically | **CONCLUSION CONFIRMED; the stated reason is an assertion and is insufficient at $m=2$.** Schur over $\mathbb R$ gives the commutant $\mathbb R$ only for $m\ge3$; at $m=2$ it gives $\mathbb C$. Repair: $C$ is symmetric, and the block-diagonality is a fact about the realification. Direct computation: $C_{\mathfrak k}=\tfrac{m-1}2\mathrm{Id}$ for all $m\ge2$ |
| **P3c** | $C_{\mathfrak m}=C_{\mathfrak{su}(m)}-C_{\mathfrak k}$ | **CONFIRMED**, legitimate because $\mathfrak k\perp\mathfrak m$ and their union of orthonormal bases is one for $\mathfrak{su}(m)$; $\mathfrak m$ being no subalgebra costs nothing |
| **P4** | $\mathop{\mathrm{tr}}C_{\mathfrak h}=2\dim\mathfrak h$, hence $C_{\mathfrak k}=\tfrac pm$, $C_{\mathfrak m}=\tfrac qm$ | **CONFIRMED**, and both verified a second time by summing squares directly |
| **P5** | $\Omega_{\mathfrak h}$ as displayed; it is a $4$-form; first Bianchi $\iff\Omega=0$ | **CONFIRMED term for term.** The displayed second and third terms are the cyclic sum's terms after two sign flips each; total antisymmetry checked in $x\leftrightarrow y$ and $z\leftrightarrow w$ separately |
| **P6** | Both forms vanish on all four outer summands at every $m$, "because every term carries a killed factor" | **CONCLUSION CONFIRMED; the stated reason covers two of the four summands.** On $\Lambda^4A$ and $\Lambda^4B$ it names only the factor $\mathfrak m$ kills, and $\Omega_{\mathfrak k}$ there needs a separate argument (disjoint index pairs). The omission bites **only at $m=4$**, since for $m\ne4$ invariance alone kills those two summands |
| **P7** | $SO(m)$-invariants of $\Lambda^4\mathbb R^{2m}$ sit in the middle summand alone once $m\ne4$; $2$ in the middle at $m=4$ | **CONFIRMED**, with the count completed: total $1$ at $m=2,3$ and $m\ge5$; at $m=4$ the middle carries $2$ and each of the four outer summands carries $1$, total $6$, which is why P6 must be proved directly and not inferred |
| **P8** | $\Omega_{\mathfrak k}(e_1,e_2,f_1,f_2)=\tfrac12$, $\Omega_{\mathfrak m}(e_1,e_2,f_1,f_2)=\tfrac12+\tfrac1m$, both zero at $(e_1,e_2,f_3,f_4)$; the two tuples separate $\mathrm{Id}$ from $*$ | **CONFIRMED, signs included.** The $+\tfrac1m$ is a double sign flip: $\langle vf_1,e_1\rangle=-Y_{11}$ against $\Pi_{\mathrm{Sym}_0}$'s $-\tfrac1m\delta\delta$. The separation matrix is diagonal and nonsingular |
| **P9** | $ap+bq=\tfrac{m-1}2[am+b(m+2)]$, and no $m$ makes the two conditions differ | **CONFIRMED**, Ricci carries the factor $\tfrac{m-1}2$, Bianchi the factor $\tfrac1{2m}$; both are nonzero for $m\ge2$, so the two cut the same line at every admissible $m$ |
| **P10** | Edges $m=2,3,4$ and $a=b=0$ | **CONFIRMED.** At $m=2$ the general equation reproduces $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ exactly: $\mathfrak k\oplus\mathfrak m=\mathfrak{su}(2)$ *is* one $\Lambda^\pm$, and the line is precisely the traceless part of $S^2(\Lambda^\epsilon)$. $a=b=0$ lies on the line and gives $W=0\in\mathcal W_{2m}$ |
| **P11** | $m\ge2$ is a used hypothesis | **CONFIRMED and load-bearing.** At $m=1$ both $\Pi$'s are zero, so every $(a,b)$ gives $W=0\in\mathcal W_2$ while $a+3b\ne0$ generally, $m=1$ is the one falsifier of the displayed equation, and the hypothesis excludes it |

## Actionable summary

**The statement is proved and I found no error in any value; two sentences of the write-up need repair**, the outer-summand reason must add the disjoint-pair argument for $\Omega_{\mathfrak k}$ on $\Lambda^4A\oplus\Lambda^4B$ (the only place the proof does not reach at $m=4$), and the $C_{\mathfrak k}$-scalarity sentence must lean on block-diagonality plus symmetry of $C$ rather than on Schur, which returns $\mathbb C$ and not $\mathbb R$ at $m=2$.

## 0. Conventions, fixed once

I take the brief's conventions and use nothing else.

- $\langle X,Y\rangle=\tfrac12\mathop{\mathrm{tr}}(X^{\mathsf T}Y)$ on skew matrices. For skew $v$, $\lVert v\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(v^2)$, so a unit bivector has $\mathop{\mathrm{tr}}(v^2)=-2$.
- $x\wedge y$ is the operator $z\mapsto\langle x,z\rangle y-\langle y,z\rangle x$, i.e. the matrix $yx^{\mathsf T}-xy^{\mathsf T}$. Hence $\lVert x\wedge y\rVert=1$ for orthonormal $x,y$, and $x\wedge y$ and $x'\wedge y'$ are orthogonal whenever $\{x,y\}\ne\{x',y'\}$ within an orthonormal set.
- **The bracket identity used throughout.** For skew $v$, $\langle v,x\wedge y\rangle=\tfrac12\mathop{\mathrm{tr}}\!\big(v^{\mathsf T}(yx^{\mathsf T}-xy^{\mathsf T})\big)=\tfrac12(-x^{\mathsf T}vy+y^{\mathsf T}vx)=-x^{\mathsf T}vy=\langle vx,y\rangle$. This is the sign the brief's $\Omega$ is written in and I verified it before using it.
- $\Pi_{\mathfrak h}=\sum_\alpha v_\alpha v_\alpha^{\mathsf T}$ means the operator $\xi\mapsto\sum_\alpha\langle v_\alpha,\xi\rangle v_\alpha$ on $\Lambda^2$, orthogonal projection onto $\mathfrak h$ and zero on $\mathfrak h^\perp$. Inside the Ricci formula the same symbols denote the $N\times N$ matrix product. I keep the two readings apart below.
- $R(x,y,z,w):=\langle W(x\wedge y),z\wedge w\rangle$. For $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ this is $\sum_\alpha\lambda_\alpha\langle v_\alpha x,y\rangle\langle v_\alpha z,w\rangle$.
- $\mathbb R^{2m}=\mathbb C^m$ with $Je_k=f_k$, $Jf_k=-e_k$; $A=\langle e_k\rangle$, $B=\langle f_k\rangle$. A complex matrix $Z=X+iY$ realifies to $\begin{pmatrix}X&-Y\\ Y&X\end{pmatrix}$ in the ordered basis $(e_1,\dots,e_m,f_1,\dots,f_m)$.

## Hypothesis inventory

**Stated hypotheses of the theorem.**

| hypothesis | where it is used | verdict |
| --- | --- | --- |
| $m\ge2$ | twice: $m-1\ne0$ in the Ricci reduction, and $\mathfrak m\ne0$ | **used, and necessary**, §11 exhibits $m=1$ as the falsifier it excludes |
| $W$ of the form $a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ | everywhere | used |
| $J$ fixed, $\mathfrak{su}(m)$ the $J$-complex-linear traceless part | fixes $\mathfrak k,\mathfrak m$ | used |

**Imported facts and their own hypotheses.**

| import | hypotheses it needs | met? |
| --- | --- | --- |
| Schur for $C_{\mathfrak{su}(m)}$ | complex-linear endomorphism, $\mathbb C^m$ irreducible over $\mathbb C$ for $\mathfrak{su}(m)$ | **met at every $m\ge2$**; complex-linearity of $C$ checked in §3 |
| Schur for $C_{\mathfrak k}$ | $\mathbb R^m$ irreducible over $\mathbb R$ for $\mathfrak{so}(m)$ **of real type**, plus no mixing of the two copies | **real type fails at $m=2$**; no-mixing is true but is not part of Schur. Both repaired in §3 |
| $\Lambda^2\mathbb R^m$ irreducible for $SO(m)$ | $m\ne4$, $m\ge3$; at $m=2$ it is trivial and $1$-dimensional | met, and $m=4$ is handled by the second evaluation |
| $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$, inequivalent, real type | $m=4$ | met; gives the middle invariant space dimension $2$ |
| $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ | $N=4$ | met; used only as the $m=2$ consistency check of §11 |

**Unused stated hypotheses.** None. In particular the proof never uses Ricci-flatness inside the Bianchi half or the reverse, the two equations are derived independently and then compared, which is what makes the theorem non-vacuous.

**One hypothesis the proof needs and does not state.** For the *converse* direction of the Ricci half ($ap+bq=0\Rightarrow\mathrm{Ric}=0$), scalarity is essential; the trace alone gives only the forward implication. The proof does establish scalarity, so nothing is missing mathematically, but the write-up nowhere says which half of the biconditional each of its two ingredients (scalarity, trace) is carrying.

## 1. The identification of $\mathfrak k$ and $\mathfrak m$, and the spanning sets

$\mathfrak u(m)\subset\mathfrak{so}(2m)$ is the set of $J$-complex-linear skew-adjoint maps, i.e. complex matrices with $Z^*=-Z$. Writing $Z=X+iY$ with $X,Y$ real, $Z^*=X^{\mathsf T}-iY^{\mathsf T}$, so $Z^*=-Z$ reads $X^{\mathsf T}=-X$ and $Y^{\mathsf T}=Y$. Then $\mathop{\mathrm{tr}}Z=\mathop{\mathrm{tr}}X+i\mathop{\mathrm{tr}}Y=i\mathop{\mathrm{tr}}Y$ since a real skew matrix is trace-free, so $\mathfrak{su}(m)$ adds exactly $\mathop{\mathrm{tr}}Y=0$. **The brief's description is correct**: $\mathfrak{su}(m)=\{X+iY:X\ \text{real skew},\ Y\ \text{real symmetric traceless}\}$, with $\mathfrak k=\{X\}\cong\mathfrak{so}(m)$ and $\mathfrak m=\{iY\}\cong i\,\mathrm{Sym}_0(m)$.

**$\mathfrak k$, derived from the operator.** $Z=X$ realifies to $\mathop{\mathrm{diag}}(X,X)$: $e_j\mapsto\sum_aX_{aj}e_a$, $f_j\mapsto\sum_aX_{aj}f_a$. Take $X=E_{ji}-E_{ij}$ (a basis of real skew for $i<j$). Then $e_i\mapsto e_j$, $e_j\mapsto-e_i$, all other $e$'s to zero, and the same on $B$. The operator $e_i\wedge e_j$ sends $e_i\mapsto e_j$, $e_j\mapsto -e_i$ and kills the rest. Hence the realification is $e_i\wedge e_j+f_i\wedge f_j$, **exactly the brief's spanning element**.

**$\mathfrak m$, derived from the operator.** $Z=iY$ realifies to $\begin{pmatrix}0&-Y\\ Y&0\end{pmatrix}$: $e_j\mapsto\sum_aY_{aj}f_a$, $f_j\mapsto-\sum_aY_{aj}e_a$. For $Y=E_{kl}+E_{lk}$ ($k\ne l$): $e_k\mapsto f_l$, $e_l\mapsto f_k$, $f_k\mapsto-e_l$, $f_l\mapsto-e_k$. The operator $e_k\wedge f_l$ sends $e_k\mapsto f_l$, $f_l\mapsto-e_k$; adding $e_l\wedge f_k$ gives precisely the four assignments. For $Y=E_{kk}$: $e_k\mapsto f_k$, $f_k\mapsto -e_k$, which is $e_k\wedge f_k$. **Both of the brief's spanning families are right**, and the traceless constraint on $Y$ is exactly the traceless constraint on $\sum_kc_k(e_k\wedge f_k)$, whose omitted direction $\sum_ke_k\wedge f_k=J$ is the $\mathfrak u(1)$ centre.

**Normalisation.** $e_i\wedge e_j$ and $f_i\wedge f_j$ are unit and supported on disjoint pairs of basis vectors, hence orthogonal; the sum has norm $\sqrt2$ and $\tfrac1{\sqrt2}(e_i\wedge e_j+f_i\wedge f_j)$ is unit. Identically, $e_k\wedge f_l$ and $e_l\wedge f_k$ have supports $\{e_k,f_l\}$ and $\{e_l,f_k\}$, disjoint for $k\ne l$, so $\tfrac1{\sqrt2}(e_k\wedge f_l+e_l\wedge f_k)$ is unit. Each $e_k\wedge f_k$ is already unit. **The $\tfrac1{\sqrt2}$ is correct and the two families are orthonormal**; distinct members have distinct supports within the orthonormal set $\{e_a\wedge e_b,\ f_a\wedge f_b,\ e_a\wedge f_b\}$, and $\mathfrak k\perp\mathfrak m$ because the first uses only $e\wedge e$ and $f\wedge f$ and the second only $e\wedge f$.

**The count.** $p=\binom m2$, $q=\binom m2+(m-1)=\tfrac{m^2+m-2}2=\binom{m+1}2-1=\tfrac{(m-1)(m+2)}2$, and $p+q=\tfrac{m(m-1)}2+\tfrac{m(m+1)}2-1=m^2-1=\dim\mathfrak{su}(m)$. **Confirmed.**

## 2. The spectral form of $\mathrm{Ric}$, and whether the normalisation matters

Take $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ on $\Lambda^2$ with $\{v_\alpha\}$ orthonormal. Then, using the bracket identity of §0,
$$R(x,y,z,w)=\sum_\alpha\lambda_\alpha\langle v_\alpha,x\wedge y\rangle\langle v_\alpha,z\wedge w\rangle=\sum_\alpha\lambda_\alpha\langle v_\alpha x,y\rangle\langle v_\alpha z,w\rangle .$$
Contract over an orthonormal basis $\{u_c\}$ of $\mathbb R^N$:
$$\mathrm{Ric}(x,y)=\sum_cR(x,u_c,y,u_c)=\sum_\alpha\lambda_\alpha\sum_c\langle v_\alpha x,u_c\rangle\langle v_\alpha y,u_c\rangle=\sum_\alpha\lambda_\alpha\langle v_\alpha x,v_\alpha y\rangle=x^{\mathsf T}\Big(\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha\Big)y .$$
So $\mathrm{Ric}(W)=\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ **on the nose**, not merely up to a constant, under the brief's $\tfrac12$-at-$\Lambda^2$ convention. Since $v^{\mathsf T}v=-v^2$ for skew $v$, this is $aC_{\mathfrak k}+bC_{\mathfrak m}$ with $C_{\mathfrak h}=-\sum_{v\in\mathfrak h}v^2$, matching the proof.

**Does anything downstream read a value?** No. The conclusion of the Ricci half is the vanishing locus $ap+bq=0$, which is scale-invariant in $\mathrm{Ric}$; a rescaled Ricci would give the same line. The one place a *value* is read is the Bianchi half, and that reads $\Omega$, not $\mathrm{Ric}$. **Any constant here is harmless, and in fact there is none.**

## 3. The three scalarity claims

**Casimirs commute.** $\langle X,Y\rangle=-\tfrac12\mathop{\mathrm{tr}}(XY)$ is $\mathrm{ad}$-invariant on $\mathfrak{so}(N)$, hence on any subalgebra, so for a subalgebra $\mathfrak h$ with orthonormal basis $\{v_\alpha\}$ the element $C_{\mathfrak h}=-\sum v_\alpha^2$ commutes with the $\mathfrak h$-action. This applies to $\mathfrak{su}(m)$ and to $\mathfrak k$; it does **not** apply to $\mathfrak m$, which is no subalgebra, and the proof correctly avoids needing it, reaching $C_{\mathfrak m}$ by subtraction.

**(a) $C_{\mathfrak{su}(m)}$.** Every $v\in\mathfrak{su}(m)$ is complex-linear by construction, so each $v^2$ and hence $C$ is complex-linear. $C$ commutes with $\mathfrak{su}(m)$, and $\mathbb C^m$ is irreducible over $\mathbb C$ for $\mathfrak{su}(m)$ at every $m\ge2$. Complex Schur gives $C=c\,\mathrm{Id}$, $c\in\mathbb C$; $C$ is a real symmetric matrix, so $c\in\mathbb R$. **Confirmed, no edge case.**

**(b) $C_{\mathfrak k}$, the stated reason is insufficient, the conclusion is right.** Two things are needed and the proof asserts both in one clause.

*No mixing.* Each $v\in\mathfrak k$ realifies to $\mathop{\mathrm{diag}}(X,X)$, so $v^2=\mathop{\mathrm{diag}}(X^2,X^2)$ and $C_{\mathfrak k}$ is block-diagonal with equal blocks. **This is a fact about the realification, not a consequence of Schur**, the commutant of $\mathfrak{so}(m)$ acting on $\mathbb R^m\oplus\mathbb R^m$ is $\mathrm{Mat}_2(\mathbb R)$ for $m\ge3$, so irreducibility of $\mathbb R^m$ alone would leave a four-parameter family.

*$m=2$.* The brief's own gloss ("$\mathbb R^2$ is not irreducible over $\mathbb R$" for $\mathfrak{so}(2)$), is itself wrong: a rotation generator has no real eigenvector, so $\mathbb R^2$ **is** irreducible over $\mathbb R$. What fails at $m=2$ is *absolute* irreducibility: the commutant is $\mathbb C$, not $\mathbb R$, so real Schur returns $\alpha I+\beta j$ rather than a scalar. **Repair:** $C=-\sum v^2=\sum v^{\mathsf T}v$ is symmetric, $j$ is skew, so $\beta=0$ and $C$ is scalar after all. The same repair covers every $m$ and makes the argument uniform.

*Direct computation, which settles it without Schur at all.* With $w_{ij}=\tfrac1{\sqrt2}(e_i\wedge e_j+f_i\wedge f_j)$, the two summands have disjoint supports so their product vanishes and $(e_i\wedge e_j)^2=-(P_{e_i}+P_{e_j})$ for the rank-one projections $P$. Hence
$$C_{\mathfrak k}=-\sum_{i<j}w_{ij}^2=\tfrac12\sum_{i<j}\big(P_{e_i}+P_{e_j}+P_{f_i}+P_{f_j}\big)=\tfrac{m-1}2\sum_k(P_{e_k}+P_{f_k})=\tfrac{m-1}2\,\mathrm{Id},$$
each index appearing in $m-1$ pairs. Valid for every $m\ge2$, and equal to $p/m=\tfrac{m-1}2$.

**(c) $C_{\mathfrak m}=C_{\mathfrak{su}(m)}-C_{\mathfrak k}$.** $\mathfrak k\perp\mathfrak m$ (§1) and $\mathfrak k\oplus\mathfrak m=\mathfrak{su}(m)$, so the union of the two orthonormal bases is an orthonormal basis of $\mathfrak{su}(m)$ and the Casimirs add. **Confirmed.** A scalar minus a scalar is scalar.

*Second, independent evaluation of $C_{\mathfrak m}$.* The off-diagonal part contributes $-\sum_{k<l}u_{kl}^2=\tfrac{m-1}2\mathrm{Id}$ by the same disjoint-support computation. For the diagonal part, take any orthonormal basis $\{t_\beta\}_{\beta=1}^{m-1}$ of the traceless span of $\{d_k=e_k\wedge f_k\}$. The $d_k$ have disjoint supports, so $d_kd_l=0$ for $k\ne l$ and $t_\beta^2=-\sum_kc^\beta_k{}^2(P_{e_k}+P_{f_k})$. Summing, $\sum_\beta c^\beta_kc^\beta_k=(\Pi_{D_0})_{kk}=1-\tfrac1m$, giving $\tfrac{m-1}m\mathrm{Id}$. Total $C_{\mathfrak m}=(m-1)\big(\tfrac12+\tfrac1m\big)\mathrm{Id}=\tfrac{(m-1)(m+2)}{2m}\mathrm{Id}=\tfrac qm\mathrm{Id}$. **Agrees with the trace route.**

## 4. The trace evaluation

For unit skew $v$, $\lVert v\rVert^2=-\tfrac12\mathop{\mathrm{tr}}(v^2)=1$ gives $\mathop{\mathrm{tr}}(v^2)=-2$, so $\mathop{\mathrm{tr}}C_{\mathfrak h}=-\sum_\alpha\mathop{\mathrm{tr}}(v_\alpha^2)=2\dim\mathfrak h$. The bases used are orthonormal for exactly this pairing (§1), so the count is right. Scalarity then forces $C_{\mathfrak h}=\tfrac{2\dim\mathfrak h}{2m}\mathrm{Id}=\tfrac{\dim\mathfrak h}{m}\mathrm{Id}$ on $\mathbb R^{2m}$: $C_{\mathfrak k}=\tfrac pm$, $C_{\mathfrak m}=\tfrac qm$. **Confirmed**, and cross-checked against §3's direct sums, which agree at every $m$.

$$\mathrm{Ric}(W_{a,b})=\Big(\tfrac{ap+bq}m\Big)\mathrm{Id}=0\iff ap+bq=0 .$$

## 5. The Bianchi sum, derived rather than read

First Bianchi is $R(x,y,z,w)+R(x,z,w,y)+R(x,w,y,z)=0$ for all arguments. With $R(x,y,z,w)=\sum_\alpha\langle v_\alpha x,y\rangle\langle v_\alpha z,w\rangle$ for $\Pi_{\mathfrak h}$, the cyclic sum is
$$\sum_\alpha\big[\langle v_\alpha x,y\rangle\langle v_\alpha z,w\rangle+\langle v_\alpha x,z\rangle\langle v_\alpha w,y\rangle+\langle v_\alpha x,w\rangle\langle v_\alpha y,z\rangle\big].$$
Match against the brief's display. Its first term is mine verbatim. Its third, $\langle v z,x\rangle\langle v y,w\rangle$, equals my second: $\langle vz,x\rangle=-\langle vx,z\rangle$ and $\langle vy,w\rangle=-\langle vw,y\rangle$, two flips cancelling. Its second, $\langle vy,z\rangle\langle vx,w\rangle$, is my third reordered. **The displayed $\Omega_{\mathfrak h}$ is exactly the cyclic Bianchi sum, and "first Bianchi $\iff\Omega=0$" is the identity itself, not a proxy.**

**Total antisymmetry, checked and not assumed.** Under $y\to z\to w\to y$ the three terms permute cyclically, so $\Omega$ is invariant, consistent with an even permutation. Under $z\leftrightarrow w$: term 1 flips by $\langle vw,z\rangle=-\langle vz,w\rangle$; term 2 becomes $\langle vy,w\rangle\langle vx,z\rangle$, which is $-\langle vz,x\rangle\langle vy,w\rangle$, the negative of term 3; term 3 becomes $-\langle vx,w\rangle\langle vy,z\rangle$, the negative of term 2. Under $x\leftrightarrow y$: term 1 flips; term 2 becomes $\langle vx,z\rangle\langle vy,w\rangle=-\langle vz,x\rangle\langle vy,w\rangle$; term 3 becomes $\langle vz,y\rangle\langle vx,w\rangle=-\langle vy,z\rangle\langle vx,w\rangle$. Transpositions $(xy)$ and $(zw)$ together with the $3$-cycle generate $S_4$, so $\Omega$ is a $4$-form. **Confirmed.**

**Invariance.** $\Omega_{\mathfrak h}$ depends on $\mathfrak h$ only through $\Pi_{\mathfrak h}$, so it is unchanged by a change of orthonormal basis; if $g\in O(2m)$ normalises $\mathfrak h$ then $\{gv_\alpha g^{-1}\}$ is again an orthonormal basis of $\mathfrak h$ and $\Omega_{\mathfrak h}(g\cdot)=\Omega_{\mathfrak h}$. Diagonal $SO(m)$, acting as $\mathop{\mathrm{diag}}(g,g)$, normalises $\mathfrak k$ ($gXg^{\mathsf T}$ is real skew) and $\mathfrak m$ ($g(iY)g^{\mathsf T}=i\,gYg^{\mathsf T}$ is $i$ times a symmetric traceless matrix). **Both forms are $SO(m)$-invariant.**

## 6. The vanishing on the outer summands, where the write-up does not reach

Write $\mathfrak m$'s brackets in terms of its symmetric matrix: for $v\leftrightarrow Y$, $\langle ve_a,f_b\rangle=Y_{ba}$, $\langle vf_a,e_b\rangle=-Y_{ba}$, $\langle ve_a,e_b\rangle=\langle vf_a,f_b\rangle=0$. For $v\in\mathfrak k$: $\langle ve_a,f_b\rangle=\langle vf_a,e_b\rangle=0$, and $\langle ve_a,e_b\rangle=\langle vf_a,f_b\rangle$ is the entry of $X$.

Each of $\Omega$'s three terms is one of the three perfect matchings of $\{x,y,z,w\}$ into two pairs, so the argument reduces to counting $A$'s and $B$'s.

| summand | matchings | $\Omega_{\mathfrak m}$ | $\Omega_{\mathfrak k}$ |
| --- | --- | --- | --- |
| $\Lambda^4A$ | every matching is $ee\mid ee$ | zero, factor $\langle ve,e'\rangle=0$ | **the stated reason names no factor $\mathfrak k$ kills** |
| $\Lambda^3A\otimes B$ | every matching is $ee\mid ef$ | zero via $ee$ | zero via $ef$ |
| $A\otimes\Lambda^3B$ | every matching is $ff\mid ef$ | zero via $ff$ | zero via $ef$ |
| $\Lambda^4B$ | every matching is $ff\mid ff$ | zero, factor $\langle vf,f'\rangle=0$ | **the stated reason names no factor $\mathfrak k$ kills** |

**So the sentence "every term of $\Omega$ carries a factor $\langle ve,e'\rangle$ or $\langle vf,f'\rangle$, which $\mathfrak m$ kills, or a factor $\langle ve,f\rangle$, which $\mathfrak k$ kills" covers two of the four summands for $\Omega_{\mathfrak k}$ and all four for $\Omega_{\mathfrak m}$.** The brief's named mixed cases are covered: $(e_1,e_2,e_3,f_1)$ has every matching of shape $ee\mid ef$ regardless of the repeated index $1$, and $(e_1,f_2,f_3,f_4)$ every matching of shape $ff\mid ef$; index coincidence changes nothing because the reason is about the $A$/$B$ type of each pair.

**The repair, in closed form.** With $v_{ij}=\tfrac1{\sqrt2}(e_i\wedge e_j+f_i\wedge f_j)$, $\langle v_{ij}e_a,e_b\rangle=\tfrac1{\sqrt2}(\delta_{ia}\delta_{jb}-\delta_{ja}\delta_{ib})$, so
$$\sum_{i<j}\langle v_{ij}e_a,e_b\rangle\langle v_{ij}e_c,e_d\rangle=\tfrac12\sum_{i<j}(\delta_{ia}\delta_{jb}-\delta_{ja}\delta_{ib})(\delta_{ic}\delta_{jd}-\delta_{jc}\delta_{id}),$$
which needs $\{i,j\}=\{a,b\}$ from the first factor and $\{i,j\}=\{c,d\}$ from the second. On $\Lambda^4A$ the four indices are distinct, so $\{a,b\}\cap\{c,d\}=\emptyset$ and every term vanishes. Identically on $\Lambda^4B$. **Two lines, and they close the hole.**

**How much the hole costs.** For $m\ne4$, nothing: $\Omega_{\mathfrak k}$ is $SO(m)$-invariant, its $\Lambda^4A$-component is an $SO(m)$-invariant of $\Lambda^4A$, and §7 shows that space is zero unless $m=4$. **The gap is live only at $m=4$**, where $\Lambda^4A$ carries the volume form as an invariant. That is the one place the proof as written does not reach, and it is the case the proof singles out for special treatment on other grounds, so the omission is easy to miss and worth fixing in the file.

## 7. The invariant count

$SO(m)$ acts diagonally on $A\oplus B$, both copies the standard $V=\mathbb R^m$; $\Lambda^4(A\oplus B)=\bigoplus_{k=0}^4\Lambda^kA\otimes\Lambda^{4-k}B$ as stated. Summand by summand:

- $(\Lambda^4V)^{SO(m)}$: zero for $m\le3$ (the space itself is zero) and for $m\ge5$ (invariants of $\Lambda^kV$ occur only at $k=0,m$); **dimension $1$ at $m=4$**, the volume form.
- $(\Lambda^3V\otimes V)^{SO(m)}=\mathop{\mathrm{Hom}}_{SO(m)}(V,\Lambda^3V)$: zero at $m=2$ ($\Lambda^3V=0$) and at $m=3$ ($\Lambda^3V$ trivial, $V$ not); at $m\ge5$, $\Lambda^3V\not\cong V$ ($m=5$: $\Lambda^3\cong\Lambda^2$; $m=6$: $\Lambda^3$ splits into two $10$'s; $m\ge7$: irreducible of dimension $\binom m3>m$). **Dimension $1$ at $m=4$**, where Hodge gives $\Lambda^3V\cong V$.
- Middle, $(\Lambda^2A\otimes\Lambda^2B)^{SO(m)}=\mathop{\mathrm{End}}_{SO(m)}(\Lambda^2V)$: at $m=2$, $\Lambda^2V$ is $1$-dimensional and trivial, dimension $1$; at $m=3$, $\Lambda^2V\cong V$ irreducible of real type, dimension $1$; at $m\ge5$, $\Lambda^2V=\mathfrak{so}(m)$ irreducible of real type, dimension $1$; **at $m=4$, $\Lambda^2V=\Lambda^+\oplus\Lambda^-$, two inequivalent real-type irreducibles, dimension $2$.**
- The two remaining summands mirror the first two.

**Totals: $1$ at $m=2$, $1$ at $m=3$, $6$ at $m=4$, $1$ at $m\ge5$.** The proof's "invariants sit in the middle summand alone once $m\ne4$, giving a line" is **correct as stated**, and the count above also shows why §6 has to be proved directly rather than inferred from invariance at $m=4$. Small $m$: at $m=2$ the middle is the single line $\mathbb R\,e_1\wedge e_2\wedge f_1\wedge f_2$ and invariance is not even needed; at $m=3$ the irreducibility of $\Lambda^2\mathbb R^3\cong\mathbb R^3$ is the fact used, and it holds.

## 8. The two evaluations, derived

**The $\mathfrak m$-kernel.** The correspondence $v\leftrightarrow Y$ sends $u_{kl}$ to $\tfrac1{\sqrt2}(E_{kl}+E_{lk})$ and $d_k$ to $E_{kk}$, both of Frobenius norm $1$; it is an isometry from $\mathfrak m$ onto $\mathrm{Sym}_0(m)$ with $\mathop{\mathrm{tr}}(Y^{\mathsf T}Y)$. Hence, summing over any orthonormal basis of $\mathfrak m$,
$$M_{ab,cd}:=\sum_vY^{(v)}_{ab}Y^{(v)}_{cd}=\big(\Pi_{\mathrm{Sym}_0}\big)_{ab,cd}=\tfrac12(\delta_{ac}\delta_{bd}+\delta_{ad}\delta_{bc})-\tfrac1m\delta_{ab}\delta_{cd}.$$
**The $-\tfrac1m$ is the traceless constraint, and it is the only place $m$ enters the Bianchi half.**

**$\Omega_{\mathfrak m}(e_1,e_2,f_1,f_2)$, term by term** with $(x,y,z,w)=(e_1,e_2,f_1,f_2)$:

- $\langle vx,y\rangle\langle vz,w\rangle=\langle ve_1,e_2\rangle\langle vf_1,f_2\rangle=0$, both factors of forbidden type.
- $\langle vy,z\rangle\langle vx,w\rangle=\langle ve_2,f_1\rangle\langle ve_1,f_2\rangle=Y_{12}Y_{21}$, summing to $M_{12,21}=\tfrac12(\delta_{12}\delta_{21}+\delta_{11}\delta_{22})-\tfrac1m\delta_{12}\delta_{21}=\tfrac12$.
- $\langle vz,x\rangle\langle vy,w\rangle=\langle vf_1,e_1\rangle\langle ve_2,f_2\rangle=(-Y_{11})Y_{22}$, summing to $-M_{11,22}=-\big(0-\tfrac1m\big)=+\tfrac1m$.

**The sign the brief warns about.** The third term carries two independent minus signs (the $-$ in $\langle vf_a,e_b\rangle=-Y_{ba}$, and the $-\tfrac1m$ of the traceless projector) and they cancel. Had either been absent the term would read $-\tfrac1m$ and the Bianchi line would be $am+b(m-2)=0$, disagreeing with Ricci at every $m$. **As derived, $\Omega_{\mathfrak m}(e_1,e_2,f_1,f_2)=\tfrac12+\tfrac1m$, matching the proof.**

**$\Omega_{\mathfrak k}(e_1,e_2,f_1,f_2)$.** Terms two and three each carry an $ef$ factor and vanish. Term one is $\sum_{i<j}\tfrac12(\delta_{i1}\delta_{j2}-\delta_{j1}\delta_{i2})^2$, receiving only $(i,j)=(1,2)$: **$\tfrac12$.** Matching.

**The second tuple $(e_1,e_2,f_3,f_4)$, $m\ge4$.** For $\mathfrak k$: term one needs $\{i,j\}=\{1,2\}$ and $\{i,j\}=\{3,4\}$ simultaneously, zero; the others carry $ef$ factors. For $\mathfrak m$: term one has an $ee$ factor; term two sums $Y_{41}Y_{32}$ to $M_{41,32}=\tfrac12(\delta_{43}\delta_{12}+\delta_{42}\delta_{13})-\tfrac1m\delta_{41}\delta_{32}=0$; term three sums $-Y_{31}Y_{24}$ to $-M_{31,24}=0$ likewise. **Both zero**, as claimed.

**Separation of $\mathrm{Id}$ from $*$ at $m=4$.** Identify $\Lambda^2A\wedge\Lambda^2B\cong\mathop{\mathrm{Hom}}(\Lambda^2A,\Lambda^2A)$ via the metric. The invariant $\mathrm{Id}$ is $\sum_{i<j}(e_i\wedge e_j)\otimes(f_i\wedge f_j)$, which has no $e_1e_2f_3f_4$ component; the invariant $*$ pairs $e_1\wedge e_2$ with $f_3\wedge f_4$ and so has no $e_1e_2f_1f_2$ component. **The $2\times2$ evaluation matrix on the pair of tuples is diagonal with nonzero entries**, so the two tuples separate the two invariants, and a form vanishing at $(e_1,e_2,f_3,f_4)$ has zero $*$-component. Both of ours do. Hence at $m=4$ both forms are multiples of $\mathrm{Id}$ and the first evaluation fixes the ratio, **the same equation as every other $m$.**

## 9. The two conditions coinciding

$$ap+bq=a\tfrac{m(m-1)}2+b\tfrac{(m-1)(m+2)}2=\tfrac{m-1}2\big[am+b(m+2)\big].$$
**Confirmed**, the brief's item-9 identity is exact. The proof's display omits the $\tfrac12$ but writes $\iff$, so it asserts equality of zero sets and is correct as written.

Bianchi is $\tfrac a2+b\big(\tfrac12+\tfrac1m\big)=\tfrac1{2m}\big[am+b(m+2)\big]=0$.

The two conditions carry the prefactors $\tfrac{m-1}2$ and $\tfrac1{2m}$, both nonzero for every $m\ge2$. **No $m\ge2$ makes them differ**, and the common locus is the line $(a,b)\propto(m+2,-m)$, since $(m+2)m+(-m)(m+2)=0$.

One structural point worth recording: the two halves are proved by disjoint machinery, the Ricci half by Casimirs on $\mathbb R^{2m}$, the Bianchi half by invariant theory on $\Lambda^4\mathbb R^{2m}$, and both land on the same integer combination $am+b(m+2)$. Nothing in either derivation makes that inevitable, so **the theorem is a genuine coincidence rather than a restatement.**

## 10. The edges

**$m=2$, and whether the general argument reproduces $\mathcal W_4$.** Here $\mathfrak k\oplus\mathfrak m=\mathfrak{su}(2)$ is $3$-dimensional and is precisely one of the two ideals of $\mathfrak{so}(4)=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$, i.e. one $\Lambda^\epsilon$. The line is $2a+4b=0$, so $(a,b)\propto(4,-2)$ and $W=4\Pi_{\mathfrak k}-2\Pi_{\mathfrak m}$ has eigenvalues $4$ (multiplicity $1$, on $\mathfrak k$) and $-2$ (multiplicity $2$, on $\mathfrak m$), zero off $\Lambda^\epsilon$. Its trace is $4-4=0$: **$W$ lies in $S^2_0(\Lambda^\epsilon)\subset\mathcal W_4$, exactly as the $\Lambda^\pm$ description demands.** Off the line the family leaves $\mathcal W_4$, and the reason is visible: $a=b$ gives $\Pi_{\mathfrak{su}(2)}=\Pi_{\Lambda^\epsilon}=\tfrac12(\mathrm{Id}\pm*)$, and $\mathrm{Id}$ satisfies Bianchi while $*$ does not, so $\Pi_{\Lambda^\epsilon}$ fails it, and indeed $2a+4b=6a\ne0$ there. **Consistent, and the general argument does reproduce it**, since at $m=2$ the middle summand is one line and the single evaluation is a coordinate.

Aside, the claim "Bianchi should be automatic on a $\Lambda^\pm$ summand" is true for $S^2_0(\Lambda^\pm)$ and false for $\Pi_{\Lambda^\pm}$ itself; the family's Bianchi line meets the first, not the second, so no contradiction arises.

**$m=3$.** $\Lambda^4A=0$ and $\Lambda^3A\otimes B\cong B$ carries no invariant, so the outer summands are inert and the middle is $\mathop{\mathrm{End}}_{SO(3)}(\Lambda^2\mathbb R^3)=\mathbb R$. Line $(5,-3)$: $3\cdot5+5\cdot(-3)=0$.

**$m=4$.** The one case needing the second evaluation, handled in §8, and the one case where §6's gap is live, closed in §6. Line $(6,-4)\propto(3,-2)$: $4\cdot6+6\cdot(-4)=0$.

**$a=b=0$.** $W=0$, which is in $\mathcal W_{2m}$ trivially and satisfies $am+b(m+2)=0$. The origin lies on the line, so the "exactly on the line" phrasing is right; only the notation $(a,b)\propto(m+2,-m)$ reads awkwardly at the origin, which is a wording matter and not a defect.

## 11. What would break it, and what I did to look

**A falsifier would be a triple $(m,a,b)$ with $m\ge2$ that is either (i) Ricci-flat but not Bianchi, or Bianchi but not Ricci-flat, or (ii) in $\mathcal W_{2m}$ with $am+b(m+2)\ne0$, or (iii) on the line but outside $\mathcal W_{2m}$.**

Type (i) is impossible by §9: both conditions are the vanishing of the *same* linear functional $am+b(m+2)$ times a nonzero rational, so they cannot separate. Types (ii) and (iii) reduce to the same, given that §2–§4 compute $\mathrm{Ric}$ exactly and §5–§8 compute $\Omega$ exactly.

**The one real falsifier lives at $m=1$**, which the hypothesis excludes. There $\mathfrak{so}(1)=0$ and $\mathrm{Sym}_0(1)=0$, so $\Pi_{\mathfrak k}=\Pi_{\mathfrak m}=0$ and $W_{a,b}=0\in\mathcal W_2$ for *every* $(a,b)$, while $am+b(m+2)=a+3b$ vanishes only on a line. **So $m\ge2$ is not decorative**, and the write-up would be improved by saying which step it protects.

**What I did to look.** Analytically: I derived $\mathrm{Ric}$ and $\Omega$ in closed form in $m$, so the whole plane and every $m\ge2$ are covered by the two prefactor computations rather than by sampling. As a **screen** of the values I was about to record, I built exact `Fraction` matrices for $m=2,3,4,5$, formed $\Pi_{\mathfrak k}$ and $\Pi_{\mathfrak m}$ from the spanning sets of §1, and evaluated $\mathrm{Ric}$, the two Casimirs, the five $4$-tuples of §6 and §8, and $\Omega_{W}$ over all $(2m)^4$ argument tuples on the line $(m+2,-m)$ and at $(1,0)$. Every derived value reproduced, $C_{\mathfrak k}=\tfrac12,1,\tfrac32,2$ and $C_{\mathfrak m}=1,\tfrac53,\tfrac94,\tfrac{14}5$; $\Omega_{\mathfrak k}=\tfrac12$ and $\Omega_{\mathfrak m}=1,\tfrac56,\tfrac34,\tfrac7{10}$ at $(e_1,e_2,f_1,f_2)$; all outer tuples zero; zero Bianchi violations and zero Ricci on the line, and $24,72,144,240$ violations at $(1,0)$. **This is a screen and no positive claim above rests on it**; every number in this report is derived in the section that states it.

## Verdict

**PROVEN.**

The statement is correct at every $m\ge2$, both equivalences, and I reproduced every value in the proof independently and exactly. **Two sentences of the write-up need repair, neither touching the statement:**

1. **§6.** "Both forms vanish identically on the four outer summands at every $m$" is true, but the reason given covers $\Omega_{\mathfrak k}$ on only two of the four summands. On $\Lambda^4A$ and $\Lambda^4B$ the disjoint-index-pair argument of §6 must be added. This is live only at $m=4$; for $m\ne4$ invariance supplies it.
2. **§3.** "$C_{\mathfrak k}$ is scalar because $\mathbb C^m|_{\mathfrak{so}(m)}$ is two copies of one real irreducible on which $C$ acts identically" asserts both the no-mixing and the equal-action facts without proof, and Schur cannot supply scalarity at $m=2$, where the commutant of $\mathfrak{so}(2)$ on $\mathbb R^2$ is $\mathbb C$. Either cite the block-diagonality of the realification plus the symmetry of $C$, or replace the whole clause with the two-line direct sum $C_{\mathfrak k}=\tfrac{m-1}2\mathrm{Id}$.

Two smaller notes for the file: $ap+bq=\tfrac{m-1}2[am+b(m+2)]$ carries a $\tfrac12$ the display drops (harmless, the display asserts $\iff$); and the brief's own gloss that $\mathbb R^2$ is reducible over $\mathbb R$ for $\mathfrak{so}(2)$ is wrong, it is irreducible but not absolutely irreducible, and that is the distinction the $m=2$ repair turns on.
