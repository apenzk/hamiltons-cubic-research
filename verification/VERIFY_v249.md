# Verifier v249, Lemma L54 claims 1 to 4, proof steps (0) to (4), the closing witness, and the canonical forms

*Cold brief ([BRIEF_L54_repair.md](BRIEF_L54_repair.md)), read in full and nothing else from the verification record. No numerical work: every value below is exact and derived by hand, and no script was written or run. Log: agent_logs/verify-L54-v249.log.*

| Item | Verdict |
|---|---|
| Claim 1, the two diagonals and their sums of squares | CONFIRMED |
| Claim 2, $\mu\succ d_\varphi$ and $\omega\succ d$ | CONFIRMED |
| Claim 3, $t_F\le2$ with the equality case in $F$ | CONFIRMED |
| Claim 4, $\mu=d_\varphi$ and $\omega=d$ at $t_F=2$ | CONFIRMED |
| Step (0), $K\mathbf1=0$ | CONFIRMED |
| Step (1), block form and polarisation | CONFIRMED |
| Step (2), Schur | CONFIRMED |
| Step (3), Frobenius against the diagonal | CONFIRMED |
| Step (4), rigidity route | CONFIRMED |
| Step (4), direct route | CONFIRMED |
| Closing witness, $n=4$ staircase | CONFIRMED |
| Passage B, canonical forms against Passage A | CONFIRMED |

**Summary: every step of the repaired proof follows from the statement's hypotheses and the quoted givens, every candidate discrepancy was withdrawn at step (3) of the protocol, and the lemma is PROVEN.**

## 0. Conventions, fixed once

- $W$ is an algebraic curvature tensor: $W_{ijkl}=-W_{jikl}=-W_{ijlk}=W_{klij}$, first Bianchi $W_{ijkl}+W_{iklj}+W_{iljk}=0$, and Weyl means Ricci-free, $\sum_bW_{abcb}=0$ for all $a,c$.
- $\mathring W$ is L50's formula $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$. At source, Nienhaus–Petersen–Wink Example 1.1 uses exactly $\sum_{k,l}R_{iklj}h_{kl}$ with $R_{ijkl}=\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ on the sphere, giving $\mathring R|_{S^2_0}=\mathrm{id}$. Li's introduction defines the bilinear form $\mathring R(\varphi,\psi)=R_{ijkl}\varphi_{il}\psi_{jk}$, which pairs an outer index pair with one argument and an inner pair with the other, the same placement as L50, and Li's identity $\mathring R(e_i\odot e_j,e_k\odot e_l)=2(R_{iklj}+R_{ilkj})$ (li-2209.02119.txt line 731) is what L50's formula gives (checked in section 3.3).
- $e_a\odot e_b=e_a\otimes e_b+e_b\otimes e_a$, the unnormalised sum, as in Li ("$(e_p\odot e_q)(e_j,e_k)=\delta_{pj}\delta_{qk}+\delta_{qj}\delta_{pk}$") and NPW Proposition 3.10. So $\varphi_{ab}=(E_{ab}+E_{ba})/\sqrt2$ has norm $1$ in $\langle h,g\rangle=\mathop{\mathrm{tr}}(hg)$.
- $S^2_0$ carries $\langle h,g\rangle=\mathop{\mathrm{tr}}(hg)$. $\Lambda^2$ carries the inner product for which $\{e_a\wedge e_b\}_{a<b}$ is orthonormal, and $M_{(ab),(cd)}=\pm W_{abcd}$ up to a fixed sign convention, whose diagonal L52 fixes as $M_{(ab),(ab)}=W_{abab}$.
- $K$ is the $n\times n$ symmetric matrix $K_{ab}=W_{abab}$. Its diagonal is $K_{aa}=W_{aaaa}=0$, so $\mathop{\mathrm{tr}}K^2=\sum_{a\ne b}K_{ab}^2=t_F$.
- $x\succ y$ in $\mathbb R^m$: with both sorted decreasingly, $\sum_{i\le k}x_i\ge\sum_{i\le k}y_i$ for $k<m$ and equality at $k=m$.
- Every index identity used below uses only the antisymmetries, pair symmetry and Bianchi, so each step holds under either overall sign convention for $W$ once L50's formula and $K_{ab}=W_{abab}$ are fixed.

## 1. Hypothesis inventory

**Statement.**

| Label | Hypothesis | Where used |
|---|---|---|
| H1 | $W\in\mathrm{Weyl}_n$ | (0), trace-free image of $\mathring W$, witness |
| H2 | $n\ge4$ | existence of nonzero $W$ only, so $\lVert M\rVert_F=1$ is satisfiable |
| H3 | $M$ the action on $\Lambda^2$, $\lVert M\rVert_F=1$, spectrum $\mu$ | (3), (4) |
| H4 | $\mathring W$ on $S^2_0$ in Li's convention, spectrum $\omega$ | (1), (2), (4) |
| H5 | orthonormal frame $F$, $K_{ab}=W_{abab}$, $t_F=\sum_{a\ne b}K_{ab}^2$ | throughout |
| H6 | basis $\varphi_{ab}=(e_a\odot e_b)/\sqrt2$, $\psi_k=\mathop{\mathrm{diag}}(v_k)$ with $\{v_k\}$ an orthonormal eigenbasis of $K$ on $\mathbf1^\perp$ | (1), (2) |
| H7 | $d_\varphi$, $d_\psi$, $d$ the diagonals of $M$ in the pair basis and of $\mathring W$ in H6's basis | claims 1 to 4 |

Terms the statement uses without definition: "coordinate-diagonal in $F$", which step (3) reads as every off-diagonal entry of $M$ in the pair basis of $F$ vanishing (section 5.2), and the inner products of section 0.

**Givens.**

| Label | Given | Stated for | Applied to | Match |
|---|---|---|---|---|
| G1 | L52: $M_{(ij),(ij)}=W_{ijij}$, $\langle\mathring W\varphi_{ij},\varphi_{ij}\rangle=W_{ijij}$ | any orthonormal frame, $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$ | frame $F$, same $\varphi$ | yes |
| G2 | $\langle\mathring Wh,h\rangle=\sum_{i\ne j}W_{ijji}v_iv_j=-v^{\mathsf T}K^Fv$ | $h=\mathop{\mathrm{diag}}(v)$ in $h$'s own eigenframe $F$, $\sum v=0$, $\sum v^2=1$ | $\mathop{\mathrm{diag}}(v)$ in $F$, $v\perp\mathbf1$ | yes: $F$ is an eigenframe of every $\mathop{\mathrm{diag}}(v)$ in $F$, and both sides are homogeneous of degree 2, so the unit normalisation is a scaling |
| G3 | L50: $\sum\mu=\sum\omega=0$, $\sum\mu^2=1$, $\sum\omega^2=3$ | $W\in\mathrm{Weyl}_n$, $\lVert M\rVert_F=1$, $\mathring W$ by the formula of section 0 | the same $W$ | yes, and L50 carries no dimension restriction, so $n\ge4$ is inside its range |
| G4 | Schur (1923): the diagonal of a real symmetric matrix in an orthonormal basis is majorized by its spectrum | real symmetric operators | $M$, and $\mathring W$ on $S^2_0$ | yes, given section 3.3's self-adjointness and section 4's orthonormality. The source is cited and not filed under references/ |
| G5 | L94 | maximum over frames | a remark in (3), load-free | the proof uses nothing from it |
| G6 | NPW Proposition 3.10, Li's convention | read at source | section 0, section 7 | yes |

## 2. Quotations against source

- Passage A against findings/bispectral.md lines 476-498: identical except that the brief rewrites in-page anchors `#lemma-...` as `../findings/bispectral.md#lemma-...` and drops a trailing blank line.
- Line 75 (L52), lines 275-277 (quadratic form), lines 133-135 (L50), results.md lines 330 and 1082: identical.
- Lines 275-277 sit under the heading at line 257, "Both-sided Schur–Horn and the vertex-matrix budget are the SAME wall", with no heading between, so the proof's pointer "derived under the SAME wall" lands on the quoted given.

## 3. Claim 1, steps (0) and (1)

### 3.1 Step (0)

$\sum_bK_{ab}=\sum_bW_{abab}$. For Weyl, $\sum_bW_{abcb}=0$ for every $a,c$, and at $c=a$ this is $\sum_bW_{abab}=0$. (Under the other Ricci convention $\sum_bW_{baca}$ the same vanishing holds by pair symmetry.) So $K\mathbf1=0$. $K$ is symmetric since $W_{abab}=W_{baba}$, so $\langle Kx,\mathbf1\rangle=\langle x,K\mathbf1\rangle=0$ and $K$ maps $\mathbf1^\perp$ to itself. The restriction is symmetric on an $(n-1)$-dimensional space, and the spectral theorem gives the orthonormal eigenbasis $\{v_k\}_{k<n}$. CONFIRMED.

### 3.2 The $\varphi$-diagonal

G1 gives $M_{(ab),(ab)}=W_{abab}=K_{ab}$ and $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=K_{ab}$. Direct check in L50's formula: with $h=\varphi_{ab}$, $(\mathring Wh)_{ab}=(W_{aabb}+W_{abab})/\sqrt2=W_{abab}/\sqrt2$, and by symmetry $(\mathring Wh)_{ba}$ equals the same, so $\langle\mathring Wh,h\rangle=2\cdot\frac{W_{abab}}{\sqrt2}\cdot\frac1{\sqrt2}=W_{abab}$. This agrees with NPW 3.10 ("$g(\mathring R(\phi_{ij}),\phi_{ij})=R_{ijij}$") and with Li's "$\mathring R(\phi_{kl},\phi_{kl})=(R_1)_{klkl}$". So $d_\varphi=(K_{ab})_{a<b}$ for both operators, and $\sum d_\varphi^2=\sum_{a<b}K_{ab}^2=t_F/2$ since $K$ is symmetric with zero diagonal.

### 3.3 Self-adjointness and the polarisation (attack item 2)

- **Symmetric output, trace-free output.** $(\mathring Wh)_{ji}=\sum W_{jkli}h_{kl}$. Pair symmetry and then both antisymmetries give $W_{jkli}=W_{lijk}=-W_{iljk}=W_{ilkj}$. Relabelling $k\leftrightarrow l$ with $h_{kl}=h_{lk}$ gives $(\mathring Wh)_{ji}=\sum W_{iklj}h_{kl}=(\mathring Wh)_{ij}$. The trace is $\sum_{i,k,l}W_{ikli}h_{kl}=-\sum_{k,l}\big(\sum_iW_{ikil}\big)h_{kl}=0$ by H1. So $\mathring W$ maps $S^2_0$ to itself, and $\pi\circ\mathring W=\mathring W$ there, matching Li's reading of the bilinear form as the self-adjoint $\pi\circ\mathring R$.
- **Self-adjoint.** $\langle\mathring Wh,g\rangle=\sum W_{iklj}h_{kl}g_{ij}$ and $\langle h,\mathring Wg\rangle=\sum W_{kijl}g_{ij}h_{kl}$. Antisymmetry in both pairs gives $W_{iklj}=(-1)^2W_{kijl}$, so the two agree.
- **Li's identity.** For $h=e_k\odot e_l$, $g=e_i\odot e_j$: $\langle\mathring Wh,g\rangle=W_{iklj}+W_{ilkj}+W_{jkli}+W_{jlki}$. The first bullet gives $W_{jkli}=W_{ilkj}$ and likewise $W_{jlki}=W_{iklj}$, so the sum is $2(W_{iklj}+W_{ilkj})$, Li's line 731.
- **The bilinear form on diagonal tensors.** $\langle\mathring W\mathop{\mathrm{diag}}(u),\mathop{\mathrm{diag}}(v)\rangle=\sum_{i,k}W_{ikki}u_kv_i=-\sum_{i\ne k}K_{ik}v_iu_k=-u^{\mathsf T}Kv$, using $W_{ikki}=-W_{ikik}$ and $K_{ii}=0$. This is the direct form of G2's first equality, and the proof's route through polarisation gives the same: $B(u,v)=\tfrac14\big(Q(u+v)-Q(u-v)\big)$ is valid because $B$ is symmetric (self-adjointness) and $-u^{\mathsf T}Kv$ is symmetric ($K$ symmetric).
- **The whole compression.** $\psi_k=\mathop{\mathrm{diag}}(v_k)$ has $\lVert\psi_k\rVert^2=\sum v_k^2=1$ and $\langle\psi_j,\psi_k\rangle=v_j^{\mathsf T}v_k=\delta_{jk}$. Every entry of the $(n-1)\times(n-1)$ block is $\langle\mathring W\psi_j,\psi_k\rangle=-v_j^{\mathsf T}Kv_k=-\kappa_k\delta_{jk}$. "The $\psi$-block is diagonal" therefore holds for the whole compression to $\mathop{\mathrm{span}}\{\psi_k\}$, as the proof and claim 1 say. The $\varphi$-$\psi$ cross block and the $\varphi$ off-diagonal entries are claimed nowhere in claim 1, and the proof asserts nothing about them before (4).

### 3.4 The sums

$\sum d_\psi^2=\sum_k\kappa_k^2$. The spectrum of $K$ on $\mathbb R^n$ is $\{\kappa_k\}\cup\{0\}$, the $0$ from (0), so $\sum_k\kappa_k^2=\mathop{\mathrm{tr}}K^2=t_F$. Then $\sum d^2=t_F/2+t_F=\tfrac32t_F$. Claim 1 CONFIRMED, steps (0) and (1) CONFIRMED.

### 3.5 Withdrawn candidates

- **C1a, G2 is stated for $h$'s own eigenframe with $\sum v^2=1$ and the proof applies it in an arbitrary frame to arbitrary $v\perp\mathbf1$.** (1) Located: "Every traceless symmetric $h$ is diagonal in **its own** eigenframe $F$, so $h=\mathrm{diag}(v)$ with $\sum v=0$, $\sum v^2=1$". (2) Failure sought: a frame $F$ and $v\perp\mathbf1$ where $\langle\mathring W\mathop{\mathrm{diag}}(v),\mathop{\mathrm{diag}}(v)\rangle\ne-v^{\mathsf T}Kv$. Section 3.3 derives the identity for every frame and every $v$ from L50's formula, so no such pair exists. (3) Charitable reading: $F$ is an eigenframe of every tensor diagonal in $F$, and both sides scale by $c^2$ under $v\mapsto cv$, so G2 is stated for this object. Withdrawn at (2).

## 4. Claim 2, step (2)

- $\{\varphi_{ab}\}_{a<b}\cup\{\psi_k\}_{k<n}$ is orthonormal: the $\varphi$ have disjoint off-diagonal supports, $\langle\varphi_{ab},\psi_k\rangle=0$ since $\varphi_{ab}$ has zero diagonal and $\psi_k$ zero off-diagonal, and the $\psi$ are orthonormal by section 3.3. Every element is trace-free ($\sum v_k=0$). The count is $\binom n2+n-1=\tfrac{n(n+1)}2-1=\dim S^2_0$, so it is a basis.
- $\{e_a\wedge e_b\}_{a<b}$ is orthonormal in $\Lambda^2$ by section 0, and $M$ is symmetric by pair symmetry.
- G4 applied to $M$ gives $\mu\succ d_\varphi$ and applied to $\mathring W$ on $S^2_0$ (self-adjoint by section 3.3) gives $\omega\succ d$. The equal totals are built into Schur's theorem ($\mathop{\mathrm{tr}}$ is basis-free) and agree with G3's $\sum\mu=\sum\omega=0$: $\sum d_\varphi=\tfrac12\sum_{a\ne b}K_{ab}=0$ by (0), and $\sum d_\psi=-\sum\kappa_k=-\mathop{\mathrm{tr}}K=0$.

Claim 2 and step (2) CONFIRMED. Schur's 1923 paper is cited and not filed under references/, so G4 was read as the classical theorem as quoted in the proof.

## 5. Claim 3, step (3) (attack item 3)

### 5.1 Derivation

$t_F=\sum_{a\ne b}K_{ab}^2=2\sum_{a<b}K_{ab}^2=2\sum_{a<b}M_{(ab),(ab)}^2$ by G1. In the orthonormal pair basis $\lVert M\rVert_F^2=\sum_{a<b}M_{(ab),(ab)}^2+\sum_{(ab)\ne(cd)}M_{(ab),(cd)}^2$, so $t_F=2\lVert M\rVert_F^2-2\sum_{\text{off}}M^2\le2$, with equality exactly when every off-diagonal entry vanishes. This is the Frobenius norm against the diagonal, as the proof says.

Consistency of the normalisations, derived and used only as a check on G3: the operator $T(h)_{ij}=\sum W_{iklj}h_{kl}$ on all $n\times n$ matrices has Frobenius norm squared $\sum_{ijkl}W_{iklj}^2=|W|^2$. It preserves the symmetric and the antisymmetric matrices (section 3.3 for the first). On antisymmetric $h$, Bianchi gives $W_{iklj}-W_{ilkj}=W_{iklj}+W_{iljk}=-W_{ijkl}$, so $T(h)_{ij}=-\tfrac12\sum W_{ijkl}h_{kl}$, which is $-M$ in the orthonormal basis $(E_{kl}-E_{lk})/\sqrt2$ with norm squared $\sum_{a<b,c<d}W_{abcd}^2=|W|^2/4=\lVert M\rVert_F^2$. $T$ kills $I$ (Ricci-free) and maps into $S^2_0$, so $\sum\omega^2=|W|^2-|W|^2/4=3\lVert M\rVert_F^2=3$. G3 and the pair-basis normalisation of section 0 agree.

### 5.2 The equality case read as coordinate-diagonal in $F$

The off-diagonal entries of $M$ in the pair basis are $\pm W_{abcd}$ with $\{a,b\}\ne\{c,d\}$. Their vanishing is $W_{abcd}\ne0$ only when $\{a,b\}=\{c,d\}$, the reading (4) uses. Claim 3 and step (3) CONFIRMED.

### 5.3 Withdrawn candidates

- **C3a, "coordinate-diagonal in $F$" is undefined in the statement.** (1) Located: claim 3, "with equality exactly when $W$ is coordinate-diagonal in $F$". (2) Failure sought: a reading of the term under which the equivalence fails. Under the proof's reading (off-diagonal $M$ entries vanish) it holds by 5.1, and under the index reading used in (4) ($W_{iklj}\ne0$ only when $\{i,k\}=\{l,j\}$) it is the same condition by 5.2. No closed-form failure exists under either reading. (3) Charitable reading: step (3) supplies the definition in its own words, and L94's heading uses the term in the same sense. Withdrawn at (2).
- **C3b, only the diagonal of $M$ is given (G1), and the identification of off-diagonal entries with $\pm W_{abcd}$ is unstated.** (1) Located: statement, "act on $\Lambda^2$ as $M$". (2) Failure sought: an $M$ that "is the action of $W$ on $\Lambda^2$" with off-diagonal entries other than $\pm W_{abcd}$ in an orthonormal pair basis. The action of a 4-tensor with pair symmetry on $\Lambda^2$ has matrix $\pm W_{abcd}$ in that basis by definition, and G3's $\sum\omega^2=3\lVert M\rVert_F^2$ (5.1) pins the normalisation to it. (3) Charitable reading: "acts on $\Lambda^2$ as $M$" is this definition. Withdrawn at (2).

## 6. Claim 4, step (4)

### 6.1 Rigidity (attack item 4)

Let $x=x^\downarrow$, $y=y^\downarrow$, $X_k=\sum_{i\le k}x_i$, $Y_k=\sum_{i\le k}y_i$, $D_k=X_k-Y_k$, $D_0=0$. Majorization gives $D_k\ge0$ and $D_m=0$. Abel summation:
$$\sum_{i=1}^my_i(D_i-D_{i-1})=\sum_{i=1}^my_iD_i-\sum_{i=0}^{m-1}y_{i+1}D_i=y_mD_m-y_1D_0+\sum_{k=1}^{m-1}D_k(y_k-y_{k+1})=\sum_{k<m}D_k(y_k-y_{k+1}).$$
Each $D_k\ge0$ by majorization and each $y_k-y_{k+1}\ge0$ because $y$ is sorted decreasingly, so the sum is $\ge0$. The equal totals enter as $D_m=0$, which kills the boundary term $y_mD_m$, whose sign is otherwise unknown. The identity $\sum x_i^2-\sum y_i^2=\sum(x_i-y_i)^2+2\sum y_i(x_i-y_i)$ expands to $\sum(x_i^2-2x_iy_i+y_i^2+2x_iy_i-2y_i^2)$, which is correct. With equal 2-norms, $0\ge\sum(x_i-y_i)^2$, so $x^\downarrow=y^\downarrow$. Sorting is legitimate: the majorization definition of section 0 is stated on sorted vectors, and $\sum x_i^2$ is permutation-invariant.

At $t_F=2$: claim 1 gives $\sum d_\varphi^2=1$, and $\sum\mu^2=\lVert M\rVert_F^2=1$ ($M$ symmetric). Claim 1 gives $\sum d^2=3$, and G3 gives $\sum\omega^2=3$. Claim 2 supplies the majorizations in $\mathbb R^N$ and $\mathbb R^{N+n-1}$, and rigidity gives $\mu^\downarrow=d_\varphi^\downarrow$, $\omega^\downarrow=d^\downarrow$, that is equality as multisets. CONFIRMED.

### 6.2 Direct route (attack item 5)

By 5.2, $W_{iklj}\ne0$ requires $\{i,k\}=\{l,j\}$ with $i\ne k$. In $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$ this allows $(l,k)=(i,j)$ or ($i=j$ and $k=l$).
- $i\ne j$: only $(k,l)=(j,i)$, so $(\mathring Wh)_{ij}=W_{ijij}h_{ji}=K_{ij}h_{ij}$.
- $i=j$: the first option forces $k=i$, where $W_{iiii}=0$, so $(\mathring Wh)_{ii}=\sum_kW_{ikki}h_{kk}=-(K\mathop{\mathrm{diag}}(h))_i$.

Hence $\mathring W\varphi_{ab}=K_{ab}\varphi_{ab}$, $\mathring W\mathop{\mathrm{diag}}(v)=\mathop{\mathrm{diag}}(-Kv)$, and $\mathring W\psi_k=-\kappa_k\psi_k$. $\mathring W$ is diagonal in H6's basis with diagonal $d$, and its spectrum is $d$ as a multiset. $M$ is diagonal in the pair basis by 5.1, so $\mu=d_\varphi$. The route yields $\omega=d$ as multisets, and more, the eigenvectors. CONFIRMED. Claim 4 CONFIRMED.

### 6.3 Withdrawn candidates

- **C4a, $(\mathring Wh)_{ij}$ reads $h_{ji}$, and the proof says $h_{ij}$.** (1) Located: "so $(\mathring Wh)_{ij}$ reads $h_{ij}$ alone for $i\ne j$". (2) Failure sought: $h_{ij}\ne h_{ji}$, impossible on $S^2_0$. (3) Charitable reading: $h$ is symmetric. Withdrawn at (2).

## 7. Closing witness (attack item 6)

- **A coordinate-diagonal Weyl tensor with this $K$.** Set $W_{abab}=K_{ab}$, extend by the symmetries, all other components $0$. Bianchi $W_{abcd}+W_{acdb}+W_{adbc}=0$: with all four indices distinct every term has $\{a,b\}\ne\{c,d\}$ and vanishes, and with a repeated index Bianchi follows from the antisymmetries. So $W$ is an algebraic curvature tensor. Ricci: $\sum_bW_{abcb}$ for $a\ne c$ needs $\{a,b\}=\{c,b\}$ and vanishes, and for $a=c$ the row sums are row 1: $\tfrac12-\tfrac12+0=0$, row 2: $\tfrac12+0-\tfrac12=0$, row 3: $-\tfrac12+0+\tfrac12=0$, row 4: $0-\tfrac12+\tfrac12=0$. So $W$ is Weyl. $\lVert M\rVert_F^2=\sum_{a<b}K_{ab}^2=4\cdot\tfrac14=1$ and $t_F=2$.
- **NPW's staircase at source.** Proposition 3.10 prints $\psi_k=\frac1{\sqrt{(n-k+1)(n-k)}}\big(-ke^k\otimes e^k+\sum_{l=k+1}^ne^l\otimes e^l\big)$ (PDF page 19). As printed its trace is $n-2k$, so the coefficient $-k$ is a typo for $-(n-k)$, the unique coefficient making it trace-free and of the stated norm, $(n-k)^2+(n-k)=(n-k+1)(n-k)$. At $n=4$: $v_1=(-3,1,1,1)/\sqrt{12}$, $v_2=(0,-2,1,1)/\sqrt6$, $v_3=(0,0,-1,1)/\sqrt2$.
- **The staircase diagonal**, $d_{\psi_k}=-v_k^{\mathsf T}Kv_k=-2\sum_{i<j}K_{ij}v_iv_j$:
  - $v_1$: $2\big[\tfrac12(-3)+(-\tfrac12)(-3)+0+0+(-\tfrac12)+\tfrac12\big]/12=0$, so $d_{\psi_1}=0$.
  - $v_2$: $2\big[0\cdot(-2)+(-\tfrac12)(-2)+\tfrac12\big]/6=\tfrac12$, so $d_{\psi_2}=-\tfrac12$.
  - $v_3$: $2\big[\tfrac12(-1)\big]/2=-\tfrac12$, so $d_{\psi_3}=\tfrac12$.
  
  $\sum d_\psi^2=\tfrac12$ and $\sum d^2=\sum d_\varphi^2+\sum d_\psi^2=1+\tfrac12=\tfrac32$ against $\sum\omega^2=3$. The ordering with $k$ leading ones and $-k$ in slot $k+1$ gives $v=(1,-1,0,0)/\sqrt2,(1,1,-2,0)/\sqrt6,(1,1,1,-3)/\sqrt{12}$ and $d_\psi=(\tfrac12,-\tfrac12,0)$, the same $\tfrac32$. CONFIRMED.

### 7.1 Withdrawn candidates

- **C7a, NPW's $\psi_k$ as printed is outside $S^2_0$, so "NPW's staircase" names no basis.** (1) Located: witness, "Nienhaus–Petersen–Wink's staircase $\psi_k$ are fixed by the frame". (2) Failure: at $n=4$, $k=1$, the printed tensor $(-1,1,1,1)/\sqrt{12}$ has trace $2$ and norm $1/\sqrt3$. (3) Charitable reading: NPW assert the family is a trace-free orthonormal basis, which fixes the coefficient as $-(n-k)$, and both natural staircase orderings give $\sum d^2=\tfrac32$, so the witness's value is independent of the reading. Withdrawn at (3): the defect is in the cited paper's typesetting and changes nothing in L54.

## 8. Passage B against Passage A (attack item 7)

- Line 330 carries the same content as claims 1 to 4: $\varphi$-diagonal $K$ for both operators, $\psi$-block $-K$ on $\mathbf1^\perp$, both majorizations, $t_F\le2$ with equality exactly when coordinate-diagonal in $F$, and equality of both majorizations there.
- Line 1082 matches claims 1 to 4 and the direct route of (4), including $n\ge4$, $\lVert M\rVert_F=1$, the eigenbasis stipulation, $\sum\omega^2=3$ by L50, and "the vectors agree too".
- CONFIRMED.

### 8.1 Withdrawn candidates

- **C8a, line 330 says "so $\mu\succ d_\varphi$ and $\omega\succ d$", reading the majorizations as consequences of the block form.** (1) Located as quoted. (2) Failure sought: a case where the block form fails and the majorizations fail with it. Schur holds in every orthonormal basis, so the majorizations hold regardless. (3) Charitable reading: "so" introduces the majorizations of the vectors just identified. Withdrawn at (2), wording only.
- **C8b, line 1082 says "the diagonal of $M$ in the $\varphi$-basis of $\Lambda^2$", and the $\varphi$ live in $S^2_0$.** (1) Located as quoted. (2) Failure sought: a basis of $\Lambda^2$ called $\varphi$ that differs from the pair basis. None is defined. (3) Charitable reading: the pair basis $\{e_a\wedge e_b\}$ indexed like $\varphi_{ab}$. Withdrawn at (2), wording only.
- **C8c, line 1082 omits Li's convention for $\mathring W$.** (1) Located: "the diagonal of the second-kind operator $\mathring W$". (2) Failure sought: a convention under which the claims change. Section 0 shows NPW's and Li's conventions coincide with L50's formula, and every identity used is sign-convention-free. (3) Charitable reading: L50's canonical statement fixes the formula. Withdrawn at (2).

## 9. Boundary (attack item 8)

- **$n=4$.** $N=6$, $\dim S^2_0=9$. Nothing in (0) to (4) uses $n>4$, and section 7 exhibits the equality case at $n=4$. No finding.
- **Odd $n$.** No step uses parity. The equality case of claim 3 is nonvacuous at $n=5$: extend section 7's tensor by $K_{5b}=0$, which keeps zero row sums, Bianchi and $\lVert M\rVert_F=1$. No finding.
- **Repeated eigenvalues of $K$ on $\mathbf1^\perp$.** The eigenbasis is non-unique, and every choice gives the same multiset $d_\psi=-\{\kappa_k\}$ with multiplicity and the same diagonal block $\mathop{\mathrm{diag}}(-\kappa_k)$. A zero eigenvalue on $\mathbf1^\perp$ leaves section 3.4 intact, the excluded eigenvalue being the $0$ on $\mathbf1$. No finding.
- **$t_F=0$.** $K=0$, every orthonormal basis of $\mathbf1^\perp$ is an eigenbasis, $d=0$. Claim 2 reads $\mu\succ0$, true since $\sum\mu=0$ makes every decreasing partial sum nonnegative. Claim 3 is strict, and claim 4 is vacuous. No finding.
- **$n\le3$.** Excluded by H2, and $\mathrm{Weyl}_3=0$ makes $\lVert M\rVert_F=1$ unsatisfiable there, so H2 costs nothing.

## 10. Attack items, one line each

1. Steps (0) to (4) link by link: sections 3 to 6, no finding. Each given is stated for the object it is applied to (section 1 table): L52 for any orthonormal frame, G2 after the eigenframe and scaling reading of C1a, L50 for $\mathrm{Weyl}_n$ with $\lVert M\rVert_F=1$ in L50's formula, which is NPW's and Li's convention.
2. Polarisation: No finding. $\mathring W$ is self-adjoint on $S^2_0$ and the bilinear identity holds directly. "The $\psi$-block is diagonal" is the whole compression (3.3).
3. Per-frame bound: No finding. The identity, the Frobenius inequality and the equality case in $F$ are as stated (5.1, 5.2).
4. Rigidity: No finding. Abel summation verified with its boundary terms, both factor signs nonnegative, equal totals remove the boundary term, sorting is part of the definition (6.1).
5. Direct route: No finding. The nonzero pattern, the form of $(\mathring Wh)_{ij}$ and $\omega=d$ as multisets all hold (6.2).
6. Witness: No finding. $K$ is the sectional matrix of a coordinate-diagonal Weyl tensor with $t_F=2$ and the staircase diagonal has $\sum d^2=\tfrac32$ (7). NPW's printed coefficient is a typo in the source (C7a, withdrawn).
7. Canonical forms: No finding beyond wording (C8a to C8c, withdrawn).
8. Boundary: No finding (9).

## 11. Falsifiers sought

| Claim | Object that would falsify it | What was done |
|---|---|---|
| 1 | A Weyl $W$, frame $F$ and $K$-eigenbasis with $\langle\mathring W\psi_j,\psi_k\rangle\ne0$ for $j\ne k$, or a $\varphi$-diagonal entry $\ne K_{ab}$ | derived the bilinear form on diagonal tensors and on $\varphi_{ab}$ from L50's formula for arbitrary $W$ (3.2, 3.3) |
| 2 | A non-orthonormal or incomplete basis, or a non-self-adjoint $\mathring W$ | proved orthonormality, completeness, symmetric trace-free output and self-adjointness (3.3, 4) |
| 3 | $W$ with $t_F>2$, or $t_F=2$ with a nonzero off-diagonal pair-basis entry | the Frobenius identity $t_F=2-2\sum_{\text{off}}M^2$ excludes both (5.1) |
| 4 | $W$ at $t_F=2$ with $\omega\ne d$ or $\mu\ne d_\varphi$ | derived both routes, and the direct route exhibits $\mathring W$ as diagonal in H6's basis (6.1, 6.2) |

## Overall verdict

**PROVEN.** Every link of (0) to (4) follows from H1 to H7 and G1 to G4, and the closing witness and both canonical forms agree with the proof. The one citation without a filed source is Schur (1923), used as the classical theorem.
