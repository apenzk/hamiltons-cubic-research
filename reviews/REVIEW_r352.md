# Review r352, Gate 2 on the pair block, DF1b step 4(i)

**K1, REFUTED as stated.** The sharp half of the recorded closed form is exactly half of its true value on both the diagonal and the off-diagonal, and the orientation signs $\sigma_i$ are attached to the wrong basis. The corrected form, proved below from the structure constants and screened exactly, is $L[i,i]=\tfrac12(M_{ji}+M_{ki})-\tfrac12M_{jk}$ and $L[i,m]=\tfrac12M_{im}$ in the basis $f_i=e_{ji}\odot e_{ki}$ as literally defined, with no sign.

**K2, CONFIRMED for the corrected form, and it is what refutes K1.** The orbit direction $x_i=M_{ki}-M_{ji}$ is an eigenvector of the corrected block with eigenvalue exactly $\theta/2$, by an exact cancellation against the criticality identity; the recorded $\tfrac14$-form gives $\tfrac14(M_{ji}+M_{ki}+\theta)x_i$ instead, which is $\tfrac\theta2 x_i$ only if $M_{ji}+M_{ki}=\theta$ for every $i$.

**K3, CONFIRMED for the corrected form, REFUTED for the recorded one.** The corrected block has within-factor top eigenvalue exactly $(p-2)/(2(p-1))$ for $L_e$ at every $S^p\times S^q$, derived in closed form below; the recorded form gives $0.2276$ at $S^4\times S^4$ where $\tfrac13$ is required.

**K4, CONFIRMED, with the Ricci cut identified and one framing corrected.** The Ricci cut is exactly $\sum_ix_i=0$ in the $f$-basis, $\mathbf 1$ is an eigenvector of the corrected block with eigenvalue $-M_{jk}/2$, so the block splits cleanly and the criterion is readable on the $(n-2)\times(n-2)$ matrix with that one eigenvalue removed. The criterion applies on the whole of $\mathbf 1^\perp$ including the orbit direction, which sits at equality rather than being excluded. The recorded form fails to preserve $\mathbf 1^\perp$ at all, which is a third refutation of it and needs no criticality.

**K5, CONFIRMED, and the scope is wider than the claim.** The closed form needs only that $M$ be diagonal: no criticality, no $\theta>0$, no Ricci-flatness, no Weyl conditions. Ricci-flatness of $M$ is what makes $\mathbf 1$ an eigenvector; criticality is what gives the orbit direction its $\theta/2$; $\theta>0$ enters only through [Lemma L24](../findings/second-order.md). Where the orbit direction vanishes the block loses its automatic $\tfrac12$ and the criterion binds on all $n-3$ dimensions.

---

## Setting, quoted rather than restated

Conventions from [conventions.md](../findings/conventions.md): $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ with $\varphi_{ab}=e_a\wedge e_b\leftrightarrow L_{ab}=E_{ab}-E_{ba}$, inner product $\langle A,B\rangle=-\tfrac12\mathop{\mathrm{tr}}(AB)$ so that $\langle L_{ab},L_{ab}\rangle=1$; structure constants $c_{\alpha\beta\gamma}=\langle[\varphi_\alpha,\varphi_\beta],\varphi_\gamma\rangle$ totally antisymmetric; $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$ with $Q(W)=W^2+W^\#$. The definition of record for the sharp is [Q_full](../scripts/lib/adversarial_check1.py), $(W^\#)_{\alpha\beta}=-\tfrac12\mathop{\mathrm{tr}}(A_\alpha WA_\beta W)$ with $(A_\alpha)_{\beta\gamma}=c_{\alpha\beta\gamma}$, so $A_\alpha=-\mathop{\mathrm{ad}}(\varphi_\alpha)$ and the two sign flips cancel inside the trace. Throughout, $L_{ab}=-L_{ba}$ and every bracket identity below is index-order-covariant, so no ordering of $j,k,i,m$ is ever assumed.

Two consequences of $L_{ab}$'s definition used repeatedly, from $[L_{ab},L_{cd}]=\delta_{bc}L_{ad}-\delta_{bd}L_{ac}-\delta_{ac}L_{bd}+\delta_{ad}L_{bc}$:

$$[L_{ji},L_{ki}]=-L_{jk},\qquad [L_{jm},L_{ji}]=-L_{mi}=L_{im},\qquad [L_{jm},L_{ki}]=0\quad(i,m,j,k\ \text{distinct}).$$

$M$ is diagonal in the sense of [conventions.md](../findings/conventions.md), $M\varphi_{ab}=M_{ab}\varphi_{ab}$ with $M_{ab}$ the sectional matrix, symmetric and hollow. The pair block of $\{j,k\}$ is spanned by $f_i=\varphi_{ji}\odot\varphi_{ki}=uv^{\mathsf T}+vu^{\mathsf T}$ with $u=L_{ji}$, $v=L_{ki}$, $i\notin\{j,k\}$; these are mutually orthogonal with $\mathop{\mathrm{tr}}(f_if_i)=2$, and $f_i$ is unambiguous because flipping the orientation flips both factors.

## Step 1, the polarised sharp, reduced to two brackets, and where the factor 2 went

The polarisation of $W\mapsto W^\#$ is $(M\# X)_{\alpha\beta}=-\tfrac14[\mathop{\mathrm{tr}}(A_\alpha MA_\beta X)+\mathop{\mathrm{tr}}(A_\alpha XA_\beta M)]$, as the brief and [DERIVE-df1.md](DERIVE-df1.md) both state. **The two traces are equal**, by cyclicity alone: $\mathop{\mathrm{tr}}(A_\alpha XA_\beta M)=\mathop{\mathrm{tr}}(A_\beta MA_\alpha X)$, and the resulting $T(\alpha,\beta)=\mathop{\mathrm{tr}}(A_\alpha MA_\beta X)$ is symmetric under $\alpha\leftrightarrow\beta$ because $M$ and $X$ are symmetric and $A$ skew. So the $-\tfrac14$ collapses to $-\tfrac12$, and **$(M\#X)_{\alpha\beta}=-\tfrac12\mathop{\mathrm{tr}}(A_\alpha MA_\beta X)$ rather than $-\tfrac14\mathop{\mathrm{tr}}(A_\alpha MA_\beta X)$.** This is the whole of the discrepancy: the recorded closed form equals the symmetrised half plus exactly one half of the true sharp half, entry by entry, which is what writing $(M\#X)=-\tfrac14\mathop{\mathrm{tr}}(A_\alpha MA_\beta X)$ (one of the two traces kept with the $\tfrac14$), produces. *That is a diagnosis of the origin, offered as PLAUSIBLE; the refutation below does not rest on it.*

Expanding $T$ with $M$ diagonal and $X=u\odot v$, and using total antisymmetry of $c$ to turn each contraction into a bracket, gives the reduction this review runs on: for any $p,q\in\Lambda^2$,

$$\big(M\#(u\odot v)\big)(p,q)=\tfrac12\Big[\big\langle[p,u],\,M[q,v]\big\rangle+\big\langle[p,v],\,M[q,u]\big\rangle\Big].$$

**Control on the reduction, out of sample.** Put $u=v=\varphi_b$ and sum $W=\sum_b\tfrac{\lambda_b}2\varphi_b\odot\varphi_b$: the formula returns $(W^\#)_{\alpha\alpha}=\sum_b\tfrac{\lambda_b}2\langle[\varphi_\alpha,\varphi_b],W[\varphi_\alpha,\varphi_b]\rangle$, which at $\alpha=(1,2)$ is $\sum_{m}\lambda_{1m}\lambda_{2m}$, the trusted coordinate-diagonal formula $(Q(W))_{ab,ab}=\lambda_{ab}^2+\sum_{c\neq a,b}\lambda_{ac}\lambda_{bc}$ that [check_diagonal_formula](../scripts/lib/adversarial_check1.py) validates $Q$ against. The normalisation of the reduction is therefore pinned by an identity the record already trusts.

Since the $f_m$ are orthogonal with equal norm, the coefficient of $f_m$ in a symmetric $S$ is $\mathop{\mathrm{tr}}(Sf_m)/\mathop{\mathrm{tr}}(f_mf_m)=S(p,q)$ with $f_m=p\odot q$, no inner-product normalisation enters, the matrix of a linear operator in a basis being what it is.

## Step 2, the two entries

**Diagonal.** With $p=u=L_{ji}$, $q=v=L_{ki}$: the first term dies on $[u,u]=0$, and the second is $\tfrac12\langle[u,v],M[v,u]\rangle=-\tfrac12\langle L_{jk},ML_{jk}\rangle=-\tfrac12M_{jk}$. Adding the symmetrised half $\tfrac12(Mf_i+f_iM)=\tfrac12(M_{ji}+M_{ki})f_i$, already done by hand in [DERIVE-df1.md](DERIVE-df1.md):

$$L[i,i]=\tfrac12(M_{ji}+M_{ki})-\tfrac12M_{jk}.$$

**Off-diagonal**, $m\neq i$. With $p=L_{jm}$, $q=L_{km}$: the cross brackets $[p,v]=[L_{jm},L_{ki}]$ and $[q,u]=[L_{km},L_{ji}]$ both vanish, while $[p,u]=[q,v]=L_{im}$, leaving $\tfrac12\langle L_{im},ML_{im}\rangle$:

$$L[i,m]=\tfrac12M_{im}.$$

**No $\sigma$ appears.** The bracket identities above hold for every index order, so in the basis $f_i=e_{ji}\odot e_{ki}$ *as the brief defines it* ($e_{ji}$ meaning $e_j\wedge e_i$ whether or not $j<i$), the off-diagonal entry is $+\tfrac12M_{im}$ unsigned. The signs belong to the **sorted** basis $g_i=\sigma_if_i$ built from $\varphi_{\min\max}$, where the entry is $\sigma_i\sigma_m\tfrac12M_{im}$. The record has the two bases interchanged. Because $f\mapsto g$ is conjugation by $\mathop{\mathrm{diag}}(\sigma)$ this is spectrum-neutral and costs no result, but the statement as written is false in the basis it names, and the $16\%$ failure that first exposed $\sigma_i$ is evidence that the screening code used sorted bivectors while the note described unsorted ones.

**Corrected closed form.** In the basis $f_i$, with $M^{(jk)}$ the hollow $(n-2)\times(n-2)$ submatrix of $M$ on the indices outside $\{j,k\}$,

$$L^{\{j,k\}}=\tfrac12\Big[\mathop{\mathrm{diag}}_i(M_{ji}+M_{ki})-M_{jk}\,\mathrm{Id}+M^{(jk)}\Big].$$

**Screen** (seconds, on objects built for it, reported as a screen): rebuilt $\circ$ from [Q_full](../scripts/lib/adversarial_check1.py) and read the block off, over **the same 222 blocks the record used**, every pair $\{j,k\}$ at $n=5,6,7,8$, three random hollow Ricci-flat $M$ each. The corrected form matches at $0.00\times10^{0}$, exact in floating point at every entry of every block; the recorded form is off by $0.07$ to $0.35$ against a block scale of $\approx0.4$. Cross-block leak $3\times10^{-16}$, agreeing with [Lemma L120](../findings/second-order.md).

## Step 3, K2, the orbit check, done by hand

[DERIVE-df1.md](DERIVE-df1.md)'s own computation gives the orbit tangent $X_{\mathrm{orb}}=[\rho(E_{jk}),M]=\sum_i(M_{ki}-M_{ji})f_i$ in this exact basis, and $O(n)$-equivariance of $Q$ forces $L_MX_{\mathrm{orb}}=\tfrac\theta2X_{\mathrm{orb}}$ at a critical point, since $DQ_M(X)=2M\circ X$ and $[\,A,Q(M)\,]=\theta[A,M]$. Criticality in sectional entries is $\sum_{c\notin\{a,b\}}M_{ac}M_{bc}=\theta M_{ab}-M_{ab}^2$, so splitting off $c=j$ and $c=k$,

$$\tfrac12\sum_{m\notin\{i,j,k\}}M_{im}(M_{km}-M_{jm})=\tfrac12(M_{ik}-M_{ij})\big[\theta-M_{ik}-M_{ij}+M_{jk}\big],$$

which added to the diagonal contribution $\tfrac12(M_{ki}-M_{ji})(M_{ji}+M_{ki}-M_{jk})$ cancels every quadratic term and leaves exactly $\tfrac\theta2(M_{ki}-M_{ji})$. **The corrected form passes on the nose.** The same computation run against the recorded form returns $\tfrac14(M_{ji}+M_{ki}+\theta)x_i$, an eigenvector only in the degenerate case $M_{ji}+M_{ki}=\theta$ for all $i$. Screened at $S^4\times S^4$, $S^3\times S^5$, $S^4\times S^6$, $S^5\times S^5$: residual $\lvert L_Mx-\tfrac\theta2x\rvert\le1.8\times10^{-15}$.

## Step 4, K3, the sphere product, in closed form

At $S^p\times S^q$ the Weyl sectional matrix is fixed up to scale by hollowness and Ricci-flatness alone: $A=q/(p-1)$ within the first factor, $B=p/(q-1)$ within the second, $C=-1$ across, and criticality then holds with $\theta=n-1$ from both the within-factor and the mixed row of $Q(M)=\theta M$. For a within-factor block $\{j,k\}\subset$ factor one, the corrected $2L_M$ is $A\,J_{p-2}$ on the factor-one indices, $B\,J_q+(2C-A-B)\mathrm{Id}_q$ on the factor-two indices, and $C$ across, whose spectrum is $0$ with multiplicity $p-3$, $2C-A-B<0$ with multiplicity $q-1$, and the two roots of $\begin{pmatrix}A(p-2)&Cq\\C(p-2)&Bq+2C-A-B\end{pmatrix}$. Substituting $\mu=(n-1)(p-2)/(p-1)$ gives diagonal entries $-(p-2)$ and $-q$ and determinant $(p-2)q-q(p-2)=0$ identically, so $\mu$ is a root at every $(p,q)$; the other root is $-q/(p-1)<0$. Hence

$$\lambda_{\max}\big(L_e|_{\text{within-factor pair block}}\big)=\frac{\mu}{2(n-1)}=\frac{p-2}{2(p-1)},$$

the value [r345](REVIEW_r345.md) and [r346](REVIEW_r346.md) located. Screened at $(4,4),(3,5),(4,6),(5,5)$: $0.333333,\,0.250000,\,0.333333,\,0.375000$, exact. **This also settles the attribution dispute [plan.md](../plan.md) carries as a verification-loop candidate**, the value provably tops the within-factor *pair* block, so the screen that found it off the diagonal was right, and its presence inside $\mathcal D_n$ is a separate coincidence. The mixed blocks top at exactly $\tfrac12$, carried by their orbit direction. The recorded form gives $0.2276$ at $S^4\times S^4$ against the required $\tfrac13$, a fourth-decimal miss, not a sign slip.

## Step 5, K4, the Ricci cut, and the criterion the block really imposes

**The cut is clean.** An $X=\sum_ix_if_i$ has $R_{jiki}=\langle X\varphi_{ji},\varphi_{ki}\rangle=x_i$, so the single Ricci relation cutting the block from $n-2$ to $n-3$ is $\mathop{\mathrm{Ric}}_{jk}=\sum_ix_i=0$: **the Weyl subspace of the pair block is $\mathbf 1^\perp$ in the $f$-basis.** For Ricci-flat $M$ the row sums vanish, so $\sum_{m\notin\{i,j,k\}}M_{im}=-(M_{ij}+M_{ik})$ and the corrected block gives $L\mathbf 1=-\tfrac12M_{jk}\mathbf 1$. **So $\mathbf 1$ is an eigenvector, $\mathbf 1^\perp$ is invariant, and reading the criterion off the $(n-2)\times(n-2)$ matrix is legitimate provided the eigenvalue $-M_{jk}/2$ is struck out**, it belongs to a direction outside $\mathcal W_n$ and can be the largest when $M_{jk}<0$. The recorded form instead gives $(L\mathbf 1)_i=\tfrac14(M_{ji}+M_{ki}-M_{jk})$, not proportional to $\mathbf 1$, so it does not preserve $\mathcal W_n$: a refutation independent of K2 and K3, using Ricci-flatness only and no criticality at all.

**Nothing beyond $M$ is needed, and the criterion has a name.** Writing $\Delta^{(jk)}=\mathop{\mathrm{diag}}(M^{(jk)}\mathbf 1)-M^{(jk)}$, the weighted graph Laplacian of the sectional matrix with rows and columns $j,k$ deleted, Ricci-flatness turns the corrected block into

$$L^{\{j,k\}}=-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\,\mathrm{Id},$$

so [Lemma L24](../findings/second-order.md)'s $\lambda_{\max}\le\theta/2$ on this block is exactly $\lambda_{\min}\big(\Delta^{(jk)}|_{\mathbf 1^\perp}\big)\ge-(\theta+M_{jk})$, a Laplacian eigenvalue bound on an $(n-2)$-vertex weighted graph read off $M$. $\Delta^{(jk)}\mathbf 1=0$ re-derives the eigenvector above, and the cut subspace is the Laplacian's own $\mathbf 1^\perp$, which is the natural place for it to live.

**The framing correction.** [Lemma L24](../findings/second-order.md) bounds $L_e$ on all of $W^\perp$, and the orbit directions lie in $W^\perp$; they are not excluded, they saturate. So the criterion applies to the whole of $\mathbf 1^\perp$, with the orbit direction at equality whenever it is nonzero. [DERIVE-df1.md](DERIVE-df1.md)'s "on the complement of its orbit direction, of dimension $n-4$" reaches the same test only because that direction is an eigenvector, which is a consequence of the closed form rather than a licence to drop it.

## Step 6, K5, scope

The derivation in steps 1–2 uses diagonality of $M$ and nothing else, not criticality, not $\theta>0$, not hollowness beyond what a sectional matrix has automatically, not Ricci-flatness, not first Bianchi. The screen bears this out: it matched exactly on $M$ that were Ricci-flat but **not** critical. What each further hypothesis buys is separable. Ricci-flatness of $M$ makes $\mathbf 1$ an eigenvector and hence makes the $(n-3)$-dimensional Weyl block a summand rather than a quotient. Criticality gives the orbit direction its $\theta/2$, and only then. $\theta>0$ is [Lemma L24](../findings/second-order.md)'s own hypothesis, load-bearing there and irrelevant to the closed form.

**When the orbit direction vanishes**, which is exactly $M_{ji}=M_{ki}$ for every $i$, equivalently $E_{jk}$ in the isotropy algebra, matching [r347](REVIEW_r347.md)'s corollary, the block carries no automatic $\tfrac12$ and the criterion binds on all $n-3$ dimensions. Every within-factor pair block at $S^p\times S^q$ is of this kind, which is why its top sits strictly below $\tfrac12$ at $(p-2)/(2(p-1))$ and why that number is a real constraint rather than a saturation artefact.

## What the record should do with this

The closed form appears only in [DERIVE-df1.md](DERIVE-df1.md); it has not propagated into [findings/](../findings/), so the correction is contained and no indexed lemma is disturbed. [Lemma L120](../findings/second-order.md) and [Lemma L121](../findings/second-order.md) are untouched, L120's block-diagonality is confirmed incidentally by the $3\times10^{-16}$ leak, and L121 concerns the $4$-set block, which this review did not test.
