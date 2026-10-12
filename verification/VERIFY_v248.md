# Verifier v248, Lemma L54 repaired proof: claims 1-4, steps (0)-(4), the closing witness and the canonical forms

Cold brief ([BRIEF_L54_repair.md](BRIEF_L54_repair.md)), read in full and nothing else from the round. No numerical work, every value exact, no scripts. Log: agent_logs/verify-L54-v248.log.

| Item | Verdict |
|---|---|
| Claim 1 (the two diagonals and their square sums) | CONFIRMED |
| Claim 2 ($\mu\succ d_\varphi$, $\omega\succ d$) | CONFIRMED |
| Claim 3 ($t_F\le2$, equality iff coordinate-diagonal in $F$) | CONFIRMED |
| Claim 4 (multiset equalities at $t_F=2$) | CONFIRMED |
| Step (0) $K\mathbf1=0$ | CONFIRMED |
| Step (1) diagonals, polarisation, square sums | CONFIRMED |
| Step (2) Schur | CONFIRMED |
| Step (3) per-frame bound | CONFIRMED |
| Step (4) rigidity lemma and its application | CONFIRMED |
| Step (4) direct route | CONFIRMED |
| Closing witness ($n=4$, staircase $\sum d^2=\tfrac32$) | CONFIRMED |
| Passage B canonical forms against Passage A | CONFIRMED |

**Summary.** Every link of the repaired proof follows from the stated hypotheses, Li's convention read at source and the givens as quoted. Six candidate discrepancies were raised and all six withdrawn under the three-step protocol.

## 0. Conventions, fixed once

- $W$ is an algebraic Weyl tensor: $W_{abcd}=-W_{bacd}=-W_{abdc}=W_{cdab}$, first Bianchi, every trace zero.
- Inner product on $S^2$: $\langle h,g\rangle=\sum_{ij}h_{ij}g_{ij}$. Then $\varphi_{ab}=(e_a\otimes e_b+e_b\otimes e_a)/\sqrt2$ is a unit vector, which matches NPW Proposition 3.10 at source (references/nienhaus-petersen-wink-2022-betti-second-kind/, p. 19).
- Li's convention at source (references/li-2022-product-manifolds-second-kind/ lines 30-33): the symmetric bilinear form $\mathring R(\phi,\psi)=R_{ijkl}\phi_{il}\psi_{jk}$ on $S^2_0$. Lines 340-352 identify its spectrum with that of the self-adjoint operator $\pi\circ\mathring R$. Relabelling $(i,j,k,l)\to(k,i,j,l)$ gives $\mathring W(h,g)=\sum W_{kijl}h_{kl}g_{ij}$, and $W_{kijl}=W_{ljik}=W_{iklj}$ by pair symmetry and the two antisymmetries, so this is L50's $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$.
- $K$ is the $n\times n$ symmetric matrix $K_{ab}=W_{abab}$, so $K_{aa}=W_{aaaa}=0$.
- $x\succ y$ in $\mathbb R^m$: sorted decreasingly, partial sums $X_k\ge Y_k$ for $k<m$ and $X_m=Y_m$. This is the reading the proof writes in (4) and is invariant under permuting either vector.
- "Coordinate-diagonal in $F$": $W_{abcd}=0$ unless $\{a,b\}=\{c,d\}$, which is $M$ diagonal in the pair basis $\{e_a\wedge e_b\}$ of $F$. Step (3) states this reading and step (4) uses it in components. The record's usage agrees (findings/bounds.md line 359, findings/diagonal-half.md line 1082: "diagonal in the coordinate $2$-plane basis").
- Schur's majorization theorem (1923) is cited and not filed under references/. It is reported as not filed. Its content, that the diagonal of a real symmetric matrix in an orthonormal basis is majorized by its spectrum, is used as the proof states it.

Quotation check: Passage A matches findings/bispectral.md lines 476-498 except that the source's anchor links are same-file (#...) where the brief prefixes ../findings/bispectral.md, and one trailing blank line. Passage C matches lines 75, 133-135 and 275-277. Passage B matches results.md lines 330 and 1082.

## Hypothesis inventory

**Statement of L54.**

| Hypothesis | Where used |
|---|---|
| $W\in\mathrm{Weyl}_n$ (symmetries, Ricci-flat) | (0) uses a trace. (1), (4) use pair symmetry and antisymmetry. Schur in (2) needs $M$ and $\mathring W$ symmetric |
| $n\ge4$ | Used only so that $\mathrm{Weyl}_n\ne0$ is compatible with $\lVert M\rVert_F=1$. No step depends on it otherwise |
| $\lVert M\rVert_F=1$ | (3) for the bound $2$. (4) through $\sum\mu^2=1$ and L50's $\sum\omega^2=3$ |
| $\mathring W$ in Li's convention | (1) through L52 and the diagonal quadratic form. (4) the direct route |
| Frame $F$, orthonormal (implicit, see 5.4) | (1), (2), (3) |
| $\{\psi_k\}$ from an orthonormal eigenbasis of $K$ on $\mathbf1^\perp$ | (1) diagonality of the $\psi$-block. (4) through $\sum d^2=\tfrac32t_F$ |

**Givens.**

| Given | Stated for | Applied to | Match |
|---|---|---|---|
| L52 statement (line 75) | any orthonormal frame, $\varphi_{ij}=(e_i\odot e_j)/\sqrt2$, $M$ and $\mathring W$ of $W$ | the frame $F$, the same $\varphi_{ab}$ | Yes |
| Quadratic form on diagonal $h$ (lines 275-277) | unit $h=\mathrm{diag}(v)$, $\sum v=0$, in a frame $F$ (there, the eigenframe of the bottom eigenvector) | every $\mathrm{diag}(v)$, $v\perp\mathbf1$, in the fixed $F$ | Yes as an identity, see 5.1 |
| L50 statement (lines 133-135) | $W\in\mathrm{Weyl}_n$, $\lVert M\rVert_F=1$, Li's operator formula, no restriction on $n$ | the same $W$, $n\ge4$ | Yes |
| Schur (1923) | real symmetric matrix, orthonormal basis | $M$ in the pair basis, and $\mathring W$ in $\{\varphi,\psi\}$ | Yes, not filed |
| NPW Prop. 3.10 | orthonormal basis $\{\phi_{ij},\psi_k\}$ of $S^2_0$ | the $\varphi_{ab}$, and the staircase in the witness | Yes. The printed $\psi_k$ carries a typo, see 5.2 |

## 1. Claim 1 and steps (0), (1)

**Step (0).** $\sum_bK_{ab}=\sum_bW_{abab}$ is a single contraction of $W$ over its second and fourth slots, which is $\pm\mathrm{Ric}(W)_{aa}$ according to the Ricci sign convention. It vanishes for Weyl $W$ under either sign. $K$ is symmetric ($W_{baba}=W_{abab}$), so $K\mathbf1=0$ gives $K(\mathbf1^\perp)\subseteq\mathbf1^\perp$ and the spectral theorem on $\mathbf1^\perp$ supplies an orthonormal eigenbasis $\{v_k\}_{k<n}$ with $Kv_k=\kappa_kv_k$. CONFIRMED.

**Step (1), the $\varphi$-diagonal.** L52 states $M_{(ab),(ab)}=W_{abab}$ and $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle=W_{abab}$ in any orthonormal frame. Both equal $K_{ab}$ by definition. CONFIRMED from the given.

**Step (1), the $\psi$-block (attack item 2).**
- The given's display: $\langle\mathring Wh,h\rangle=\sum_{i\ne j}W_{ijji}v_iv_j=-v^{\mathsf T}Kv$ for $h=\mathrm{diag}(v)$. The middle expression is in $W$-components, and $W_{ijji}=-W_{ijij}=-K_{ij}$, $K_{ii}=0$, give the right-hand side with this $K$.
- Symmetry: Li states $\mathring R$ is a symmetric bilinear form (lines 30-33) and identifies it with a self-adjoint operator (lines 340-352). So $B(h,g)=\langle\mathring Wh,g\rangle$ is symmetric and polarisation applies: $B(\mathrm{diag}\,u,\mathrm{diag}\,v)=\tfrac14[Q(u+v)-Q(u-v)]$ with $Q(v)=B(\mathrm{diag}\,v,\mathrm{diag}\,v)$. $Q$ is homogeneous of degree $2$, so the unit normalisation in the given extends to all $v\perp\mathbf1$, and $u\pm v\perp\mathbf1$. Result: $B(\mathrm{diag}\,u,\mathrm{diag}\,v)=-\tfrac14[(u+v)^{\mathsf T}K(u+v)-(u-v)^{\mathsf T}K(u-v)]=-u^{\mathsf T}Kv$, using $K$ symmetric.
- In the eigenbasis: $\langle\mathring W\psi_j,\psi_k\rangle=-v_j^{\mathsf T}Kv_k=-\kappa_k\delta_{jk}$. So the compression of $\mathring W$ to $\mathrm{span}\{\psi_k\}$ is $\mathrm{diag}(-\kappa_k)$. "The $\psi$-block is diagonal" means exactly this compression. The mixed $\varphi$-$\psi$ block is not claimed to vanish, and no later step uses it: Schur needs only the diagonal.

**Step (1), square sums.** $\sum d_\varphi^2=\sum_{a<b}K_{ab}^2=\tfrac12\sum_{a\ne b}K_{ab}^2=t_F/2$ by symmetry of $K$. The spectrum of $K$ on $\mathbb R^n$ is $\{\kappa_k\}_{k<n}\cup\{0\}$, the $0$ from (0), so $\sum_k\kappa_k^2=\mathrm{tr}K^2=\sum_{a,b}K_{ab}^2=t_F$ using $K_{aa}=0$. Hence $\sum d^2=\tfrac32t_F$. CONFIRMED.

**Falsifier for Claim 1 and the search.** A Weyl $W$ and frame with $\langle\mathring W\psi_j,\psi_k\rangle\ne0$ for some $j\ne k$, or $\langle\mathring W\varphi_{ab},\varphi_{ab}\rangle\ne K_{ab}$. I expanded Li's bilinear form at source on $\varphi_{ab}$ (four index assignments, two surviving, each $\tfrac12W_{abab}$) and on pairs of diagonal tensors ($\sum_{i,k}W_{ikki}u_kv_i=-u^{\mathsf T}Kv$). Both hold identically in $W$, so no falsifier exists.

## 2. Claim 2 and step (2)

- $M$ is symmetric in the pair basis since $W_{abcd}=W_{cdab}$. The pair basis is orthonormal under the proof's usage, and in any case a uniformly rescaled orthogonal basis gives the same matrix.
- $\{\varphi_{ab}\}_{a<b}$ are orthonormal (disjoint supports, unit), $\{\psi_k\}$ are orthonormal because $\{v_k\}$ are, and $\langle\varphi_{ab},\psi_k\rangle=0$ since one is supported off the diagonal and the other on it. Count: $\binom n2+(n-1)=\tfrac{n(n+1)}2-1=\dim S^2_0$. Traceless: $\mathrm{tr}\,\psi_k=\mathbf1^{\mathsf T}v_k=0$.
- $\mathring W$ is self-adjoint on $S^2_0$ by Li lines 340-352.
- Schur then gives $\mu\succ d_\varphi$ and $\omega\succ d$, equal totals included.

CONFIRMED. **Falsifier**: a non-orthonormal basis or non-symmetric operator. Both checked above, none available.

## 3. Claim 3 and step (3) (attack item 3)

- $t_F=\sum_{a\ne b}K_{ab}^2=2\sum_{a<b}K_{ab}^2=2\sum_{a<b}M_{(ab),(ab)}^2$ by L52.
- $\sum_{a<b}M_{(ab),(ab)}^2\le\sum_{(ab),(cd)}M_{(ab),(cd)}^2=\lVert M\rVert_F^2=1$: the diagonal squares are a subset of all entry squares.
- Equality holds iff every off-diagonal entry of $M$ in the pair basis of $F$ vanishes, which is the reading of coordinate-diagonal fixed in section 0.
- Both directions at the normalisation: a coordinate-diagonal $W$ with $\lVert M\rVert_F=1$ has $t_F=2\lVert M\rVert_F^2=2$, and $t_F=2$ forces zero off-diagonal entries.

CONFIRMED. **Falsifier**: a coordinate-diagonal $W$ in $F$ with $t_F<2$, or a $W$ with a nonzero off-diagonal pair entry and $t_F=2$. The inequality is a sum of nonnegative omitted terms, so neither exists.

## 4. Claim 4 and step (4)

**Rigidity lemma (attack item 4).** Sort $x,y\in\mathbb R^m$ decreasingly. This is legitimate because $\succ$ and $\sum x_i^2$ are permutation invariant, and the conclusion is about $x^\downarrow,y^\downarrow$. Put $D_k=X_k-Y_k$, $D_0=0$, $D_m=0$ (equal totals). Then $x_i-y_i=D_i-D_{i-1}$ and

$$\sum_{i=1}^my_i(D_i-D_{i-1})=\sum_{i=1}^my_iD_i-\sum_{i=0}^{m-1}y_{i+1}D_i=y_mD_m-y_1D_0+\sum_{k=1}^{m-1}(y_k-y_{k+1})D_k .$$

The boundary terms vanish because $D_0=0$ and $D_m=0$. The second of these is where equal totals enter. Each surviving factor has a sign: $D_k\ge0$ by majorization, $y_k-y_{k+1}\ge0$ by the sort of $y$. So $\sum y_i(x_i-y_i)\ge0$. The identity $x_i^2-y_i^2=(x_i-y_i)^2+2y_i(x_i-y_i)$ holds termwise, so $0=\sum(x_i-y_i)^2+2\sum y_i(x_i-y_i)\ge\sum(x_i-y_i)^2$, whence $x^\downarrow=y^\downarrow$. CONFIRMED.

**Application.** At $t_F=2$: $\sum d_\varphi^2=1$ by (1), $\sum\mu^2=\lVert M\rVert_F^2=1$ (L50). $\sum d^2=3$ by (1), $\sum\omega^2=3$ by L50, stated with $\lVert M\rVert_F=1$ and Li's formula, which are this lemma's hypotheses. Vector lengths agree: $N$ and $N+n-1$. With (2), rigidity gives $\mu^\downarrow=d_\varphi^\downarrow$ and $\omega^\downarrow=d^\downarrow$, i.e. equality as multisets. CONFIRMED.

**Direct route (attack item 5).**
- Coordinate-diagonal means $W_{iklj}\ne0$ only if $\{i,k\}=\{l,j\}$ (first pair against second pair). CONFIRMED as the fixed reading.
- For $i\ne j$: $\{i,k\}=\{l,j\}$ with $i\ne j$ forces $l=i$, $k=j$ (the case $k=i$ would need $\{i\}=\{l,j\}$, impossible). So $(\mathring Wh)_{ij}=W_{ijij}h_{ji}=K_{ij}h_{ij}$.
- For $i=j$: $\{i,k\}=\{l,i\}$ forces $k=l$, so $(\mathring Wh)_{ii}=\sum_kW_{ikki}h_{kk}=-(Kh_{\mathrm{diag}})_i$.
- Hence $\mathring W\varphi_{ab}=K_{ab}\varphi_{ab}$ exactly (its diagonal part reads $h_{kk}=0$), and $\mathring W\,\mathrm{diag}(v)=\mathrm{diag}(-Kv)$, which lies in $S^2_0$ since $\mathbf1^{\mathsf T}Kv=0$ by (0). So $\mathring W\psi_k=-\kappa_k\psi_k$ and $\mathring W$ is diagonal in the full basis with diagonal $d$. Its spectrum is $d$ as a multiset.
- $M$ diagonal in the pair basis gives spectrum $d_\varphi$.

CONFIRMED. The two routes agree.

**Falsifier for Claim 4 and the search.** A $W$ with $t_F=2$ and $\omega\ne d$ as multisets. The direct route shows $\mathring W$ is literally diagonal there, so none exists. The witness in section 6 is consistent: $\omega=d=\{\tfrac12,\tfrac12,-\tfrac12,-\tfrac12,0,0,-1,1,0\}$, $\sum=0$, $\sum\omega^2=1+2=3$.

## 5. Candidates, all withdrawn

### 5.1 The quadratic-form given is stated for the bottom eigenvector

1. Locate: lines 275-277, "Let $h$ be the unit bottom eigenvector of $\mathring W$ on $S^2_0$ ... so $h=\mathrm{diag}(v)$ ... and there $\langle\mathring Wh,h\rangle=\sum_{i\ne j}W_{ijji}v_iv_j=-v^{\mathsf T}K^Fv$". Step (1) applies it to every diagonal traceless tensor in a fixed frame.
2. Exhibit: no failing object. The display's equalities use only $h=\mathrm{diag}(v)$ in frame $F$ and Li's formula, with no eigenvector property. A failure would need a diagonal $h$ where the expansion differs, and none exists.
3. Charitable reading: the eigenvector hypothesis enters only the subsequent "so $\mu=\dots$". The displayed identity is stated for $h=\mathrm{diag}(v)$ in $F$.

Withdrawn: step 2 fails, since no concrete failure exists.

### 5.2 NPW's printed staircase is not a traceless unit basis

1. Locate: NPW p. 19, $\psi_k=\frac1{\sqrt{(n-k+1)(n-k)}}\big(-k\,e^k\otimes e^k+\sum_{l=k+1}^ne^l\otimes e^l\big)$.
2. Exhibit: at $n=4$, $k=1$ the printed tensor is $\mathrm{diag}(-1,1,1,1)/\sqrt{12}$, trace $2/\sqrt{12}\ne0$, norm$^2=\tfrac13$. The coefficient that makes the proposition's "orthonormal basis for $S^2_0$" true is $-(n-k)$, giving $\mathrm{diag}(-3,1,1,1)/\sqrt{12}$.
3. Charitable reading: this is a typo in the source, and the witness does not quote the formula. With the corrected staircase $v_1=(-3,1,1,1)/\sqrt{12}$, $v_2=(0,-2,1,1)/\sqrt6$, $v_3=(0,0,-1,1)/\sqrt2$, the witness gives $\sum d^2=\tfrac32$ (section 6). The reversed staircase $(1,-1,0,0)/\sqrt2$, $(1,1,-2,0)/\sqrt6$, $(1,1,1,-3)/\sqrt{12}$ gives $d_\psi=(\tfrac12,-\tfrac12,0)$ and the same $\tfrac32$.

Withdrawn: the defect is in the source's typesetting and does not reach L54.

### 5.3 Li's section-2 operator formula has a different index order from L50

1. Locate: Li lines 340-341, $\mathring R(\phi)_{ij}=\sum_{k,l}R_{ijkl}\phi_{kl}$, against L50's $(\mathring Wh)_{ij}=\sum W_{iklj}h_{kl}$.
2. Exhibit: read literally with $R_{ijkl}=-R_{ijlk}$, Li's printed expression is $0$ on every symmetric $\phi$, so it cannot be compared as a formula for the same operator.
3. Charitable reading: Li defines $\mathring R$ by the bilinear form of lines 30-33, and lines 344-352 identify the section-2 operator with it. That form equals L50's formula (section 0).

Withdrawn: the definition L54 uses is Li's stated definition.

### 5.4 The frame $F$ is not stated to be orthonormal

1. Locate: statement, "Fix a frame $F$", while L52 is stated "in any orthonormal frame".
2. Exhibit: in a non-orthonormal frame, $\varphi_{ab}=(e_a\odot e_b)/\sqrt2$ is not unit, so the step-(2) Schur application would fail.
3. Charitable reading: the same sentence calls $\{\varphi_{ab}\}\cup\{\psi_k\}$ "the orthonormal basis", which holds only when $F$ is orthonormal. The record uses "frame" for orthonormal frame, as L52 and L94's title do.

Withdrawn: the statement fixes orthonormality through its own basis clause.

### 5.5 "Coordinate-diagonal" is not defined in the statement

1. Locate: Claim 3, "equality exactly when $W$ is coordinate-diagonal in $F$".
2. Exhibit: no reading makes a claim fail. Under the component reading and the pair-basis reading, the equivalence is the identity $M_{(ab),(cd)}=W_{abcd}$ of "$W$ acts on $\Lambda^2$ as $M$", the convention of which L52's diagonal identity is the diagonal case.
3. Charitable reading: step (3) states the reading and step (4) uses it in components. The record's usage (section 0) is the same.

Withdrawn: no concrete failure.

### 5.6 Passage B says NPW's staircase "will not serve"

1. Locate: results.md line 1082, "NPW's own staircase $\psi_k$ will not serve, being fixed by the frame alone". Passage A says the staircase diagonalises $K$ "only when $K$ happens to be diagonal in them".
2. Exhibit: a case where the staircase serves. $K=\sum_k\kappa_kv_kv_k^{\mathsf T}$ with $K_{ii}=\sum_k\kappa_k(v_k)_i^2=0$ for all $i$. For the corrected staircase, $(v_k)_i=0$ for $i<k$ and $(v_k)_k\ne0$, so row $i=1$ forces $\kappa_1=0$, then row $2$ forces $\kappa_2=0$, and so on. The same triangular argument applies to the reversed staircase from the last row. The staircase therefore serves only at $K=0$, i.e. $t_F=0$, where every orthonormal basis of $\mathbf1^\perp$ serves.
3. Charitable reading: B's sentence is a general warning, and A's "only when" is the exact condition. The two agree off the single point $K=0$, where the claim concerns no content.

Withdrawn: B and A are consistent, and B's wording is correct at every $K\ne0$.

## 6. The closing witness (attack item 6)

$K_{12}=K_{34}=\tfrac12$, $K_{13}=K_{24}=-\tfrac12$, $K_{14}=K_{23}=0$, all other components of $W$ zero apart from symmetries.
- Algebraic curvature tensor: a Bianchi sum $W_{abcd}+W_{acdb}+W_{adbc}$ has a nonzero term only if its indices lie in a two-element set $\{a,b\}$, $a\ne b$. The two such cases give $K_{ab}+0-K_{ab}=0$ and $-K_{ab}+K_{ab}+0=0$.
- Weyl: row sums $\tfrac12-\tfrac12+0$, $\tfrac12+0-\tfrac12$, $-\tfrac12+0+\tfrac12$, $0-\tfrac12+\tfrac12$ are all $0$. Off-diagonal Ricci entries $\sum_bW_{abcb}$, $a\ne c$, vanish by the coordinate-diagonal support.
- $\lVert M\rVert_F^2=\sum_{a<b}K_{ab}^2=4\cdot\tfrac14=1$ and $t_F=2$.
- Staircase (corrected, 5.2): $v^{\mathsf T}Kv=2\sum_{a<b}K_{ab}v_av_b$. For $v_1$: $2[-\tfrac32+\tfrac32-\tfrac12+\tfrac12]/12=0$. For $v_2$: $2[1+\tfrac12]/6=\tfrac12$. For $v_3$: $2[-\tfrac12]/2=-\tfrac12$. So $d_\psi=(0,-\tfrac12,\tfrac12)$, $\sum d_\psi^2=\tfrac12$, $\sum d^2=1+\tfrac12=\tfrac32$.
- Eigenbasis: $K(1,1,-1,-1)^{\mathsf T}=(1,1,-1,-1)^{\mathsf T}$, $K(1,-1,1,-1)^{\mathsf T}=-(1,-1,1,-1)^{\mathsf T}$, $K(1,-1,-1,1)^{\mathsf T}=0$. So $\kappa=(1,-1,0)$, $\sum\kappa^2=2=t_F$ and $\sum d^2=3=\sum\omega^2$.

CONFIRMED.

## 7. Passage B against Passage A (attack item 7)

- Line 330 omits $n\ge4$. Line 1082, the canonical statement, carries it, and no step uses $n\ge4$ beyond nonemptiness.
- "Schur-Horn gives" (B) against "Schur" (A): the direction used is Schur's half of Schur-Horn. Consistent.
- "the $\psi$-block of $\mathring W$ is exactly $-K$ restricted to $\mathbf1^\perp$" (B) is the polarised compression of step (1), which is $\mathrm{diag}(-\kappa_k)$ in the eigenbasis (A). Consistent.
- "equality exactly when $W$ is coordinate-diagonal in that frame", "equal sums and equal norms", "$\mathring W$ is diagonal in the $\varphi$-and-eigenbasis": each matches A's (3) and (4).
- "will not serve": see 5.6, withdrawn.

CONFIRMED.

## 8. Boundary (attack item 8)

- **$n=4$**: $N=6$, $\dim S^2_0=9=6+3$. The witness lives here and checks. No finding.
- **Odd $n$**: no step uses parity. No finding.
- **Repeated eigenvalues of $K$ on $\mathbf1^\perp$**: the eigenbasis is not unique, but every orthonormal eigenbasis gives $\langle\mathring W\psi_j,\psi_k\rangle=-\kappa_k\delta_{jk}$. $d_\psi$ as a multiset is basis-independent, and the direct route's $\mathring W=-K$ on the diagonal block is diagonal in any eigenbasis. No finding.
- **$t_F=0$**: $K=0$, $d=0$. Claim 2 reduces to $\sum\mu=\mathrm{tr}M=\sum_{a<b}K_{ab}=0$ with nonnegative partial sums of $\mu^\downarrow$, true. Claim 3 is strict and Claim 4 is vacuous. No finding.

## Overall verdict

**PROVEN.** Claims 1-4 follow link by link from the hypotheses, Li's convention at source, L52, the quadratic-form identity and L50. The closing witness and the canonical forms are correct. Schur (1923) is cited and not filed.
