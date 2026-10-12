# REVIEW r1802: the closed branch at a product diagonal (I121, R52)

Brief: [BRIEF_I121_closed_branch.md](BRIEF_I121_closed_branch.md). Log: [agent_logs/r1802-closed.log](../agent_logs/r1802-closed.log). Analysis only: every item below was rebuilt by hand from the structure constants of $\mathfrak{so}(n)$, and no computation was run, since nothing needed refuting numerically.

**Verdict: the character table, the $2+2$ eigenvectors, $\tau=c_*$, the cross-pairing bound, the balanced constant and the endpoint reduction all hold. One scope slip (the balanced reduction needs $m\ge3$ and is false as written at $m=2$) and one overstated attribution (I104's triple is one instance of the author's open core, which also contains four-sets sharing three indices).**

| # | claim | verdict |
|---|---|---|
| 1 | table, pair block inside a factor | CONFIRMED (the quoted spectrum is wrong at $p=2$, unused) |
| 2 | table, mixed pair block and the orbit line | CONFIRMED |
| 3 | table, four-sets $4+0$ and $3+1$ | CONFIRMED |
| 4 | $2+2$ eigenvectors and $(ij\,\vert\,kl)$ forcing $v+w=0$ | CONFIRMED |
| 5 | $\tau=c_*$, $f$ a combination of $+c_*$ modes | CONFIRMED |
| 6 | I104's triple survives | CONFIRMED (combinatorics), and "exactly the open core" PLAUSIBLE only, overstated |
| 7 | cross-pairing bound and the sectional values | CONFIRMED |
| 8 | balanced constant, $0.733$ at $n=12$ | CONFIRMED |
| 9 | reduction via the endpoint criterion | REFUTED at $m=2$ as written, CONFIRMED for $m\ge3$, with the criterion itself rebuilt and CONFIRMED |
| 10 | hypotheses | two unstated ($b>0$, $m\ge3$), one ordering dependence, one sign case (empty) |

## Rebuilt: $L_R$ on the blocks at a diagonal $R$

With $Q(R)=R^2+R^\#$, $R^\#=\tfrac12\sum c_{\alpha\gamma\varepsilon}c_{\beta\gamma'\varepsilon'}R_{\gamma\gamma'}R_{\varepsilon\varepsilon'}$ (the normalisation that gives $(R^\#)_{ab,ab}=\sum_cK_{ac}K_{bc}$ on diagonal $R$), the polarisation is $Q(R,X)=\tfrac12(RX+XR)+\tfrac12\sum c\,c\,R\,X$, and for $R$ diagonal with sectional matrix $K$:

- **Pair block $(i,j)$**, coordinates $x_m=X_{im,jm}$, $\sum_mx_m=0$. The bracket terms come from $\gamma=(km)$, $\varepsilon=(ik)$, $\varepsilon'=(jk)$ with sign $+$, and from $\gamma=(ij)$, $\varepsilon=(jm)$, $\varepsilon'=(im)$ with sign $-$. So $2(Lx)_m=(K_{im}+K_{jm}-K_{ij})x_m+\sum_{k\notin\{i,j,m\}}K_{km}x_k$, which is [L122](../findings/second-order.md)'s form.
- **Four-set $\{1,2,3,4\}$**, $u=X_{12,34}$, $v=X_{13,24}$, $w=X_{14,23}$. The bracket at $(12,34)$ runs over $\gamma\in\{13,14,23,24\}$ with signs $+,-,-,+$ against $w,v,v,w$, giving $2u'=A_0u+B_0w-C_0v$. At $(13,24)$ it runs over $\gamma\in\{12,14,23,34\}$, all with sign $-$, against $w,u,u,w$, giving $2v'=B_0v-C_0u-A_0w$. **This is the author's action (5) exactly.**

Sectional values of $E=\pi_{\mathcal W}(I_P)$: the given $\alpha,\beta,\gamma$ have zero row sums ($(p-1)\alpha+q\beta=0$, $p\beta+(q-1)\gamma=0$), and $I_P-E$ has the form $h_a+h_b$ exactly when $\alpha+\gamma-2\beta=1$, which holds since $q(q-1)+p(p-1)+2(p-1)(q-1)=(n-1)(n-2)$. Ricci-type and Weyl parts are orthogonal, so $E$ is the projection. The three differences and $K=\sum_{a<b}E_{ab}^2=\tfrac{p(p-1)q(q-1)}{2N}$ check. On the diagonal $Q(E)_{ab,ab}=-(n-1)\beta^2$ across, so $d_E=-(n-1)\beta=\tfrac{(p-1)(q-1)}{n-2}$, and $c_*=\tfrac12$ in $E$ units, matching $c_*=d\tfrac{n-2}{2(p-1)(q-1)}$.

## Claims 1 to 3, the table

1. **Within a factor**, $i,j\in P$: $a_{im}=a_{jm}$ for every $m$, so $\delta^{ij}=0$ and the one-plane bound gives $x=0$. The row needs nothing from the spectrum. *Correction to the quoted spectrum:* at $p=2$ the block is $(-c_*)^{q-1}$ alone and the listed $\tau_P=0$ and multiplicity $p-3=-1$ are not in it. The rebuilt spectrum at $p\ge3$ is $0^{p-3}$ (sum-zero on $P\setminus\{i,j\}$), $(-c_*)^{q-1}$ (sum-zero on $Q'$, value $\tfrac12(2\beta-\alpha-\gamma)$), and one more.
2. **Mixed**, $i\in P$, $j\in Q'$: the formula gives $2(Lx)_m=(\alpha-\beta)X_P$ on $P\setminus i$ and $(\beta-\gamma)X_P$ on $Q'\setminus j$, with $X_P=\sum_{P\setminus i}x_m$. So $L$ has rank one, kernel $\{X_P=0\}$ of dimension $n-4$, image spanned by $v=(\alpha-\beta,\dots,\beta-\gamma,\dots)=2\delta$, eigenvalue $\tfrac12(p-1)(\alpha-\beta)=-\tfrac12(n-1)\beta=\tfrac d2$. The orbit tangent of the $(i,j)$ rotation is $a_{im}-a_{jm}=2\delta_m$. **So the orbit line is exactly $\mathbb R\delta$**, $\delta\ne0$ since $\alpha-\beta=\tfrac{q-1}{n-2}\ne0$, and $\langle\delta,x\rangle=0$ removes it. The plain dot product is the block inner product up to a constant, since every coordinate appears twice in the Frobenius norm. Killed. This matters at $(3,3)$, where $c_*=\tfrac d2$ coincides with the orbit value.
3. **$4+0$ and $3+1$**: $A_0=B_0=C_0$, so $2u'=A_0(u-v+w)=0$ and $2v'=A_0(v-u-w)=0$ by Bianchi. The block is zero and $\tau\ne0$ kills it. For $4+0$ all three pairings have $\square=0$ and every $\delta=0$, giving $v+w=0$, $u=w$, $u=-v$, and Bianchi then $3u=0$. Both reasons hold.

## Claims 4 and 5, the $2+2$ block and $\tau=c_*$

$A_0=\alpha+\gamma$, $B_0=C_0=2\beta$: $2u'=(\alpha+\gamma)u+2\beta(w-v)=(\alpha+\gamma-2\beta)u$ and $2v'=2\beta(v-u)-(\alpha+\gamma)w=-(\alpha+\gamma-2\beta)w$, using $w-v=-u$ and $v-u=w$. Bianchi on the image gives $w'=-\tfrac12v$ in $E$ units, so $L(u,v,w)=\tfrac12(u,-w,-v)$. Then $(2,1,-1)\mapsto\tfrac12(2,1,-1)$ and $(0,1,1)\mapsto-\tfrac12(0,1,1)$, both on $u-v+w=0$. **CONFIRMED.**

For $(ij\,|\,kl)$: $\square=\beta-\beta-\beta+\beta=0$, and $\delta^{kl}_{i,j}$, $\delta^{ij}_{k,l}$ and every outside $\delta^{ij}_m$, $\delta^{kl}_m$ vanish because each pair lies in one factor. So $(v+w)^2\le0$. The plane $u-v+w=0$ meets $v+w=0$ in the line $(2,1,-1)$, so the conclusion follows from the pairing alone, without the eigen-decomposition. The double rotation requires every pair profile zero, which rows 1 and 2 supply first: **the table's rows are ordered, not parallel**, and the $4+0$ and $2+2$ rows depend on rows 1 and 2.

With every other component zero and $f\ne0$, some $+c_*$ component is nonzero and is a $\tau$-eigenvector, so $\tau=c_*$. **CONFIRMED**, given $b>0$ (claim 10).

## Claim 6, I104's triple

With $Q_1=\{1,2,3,4\}$, $Q_2=\{1,2,5,6\}$, $Q_3=\{3,4,5,6\}$: if $\{1,2\}$ lay in one factor then $\{3,4\}$ and $\{5,6\}$ lie in the other and $Q_3$ is $4+0$. So $\{1,2\}$ is split, and then $Q_1,Q_2$ being $2+2$ forces $\{3,4\}$, $\{5,6\}$ split, which makes $Q_3$ $2+2$. **CONFIRMED.** Each block's $+c_*$ line is taken in its own labelling, the within-$P$ pair of $Q_1$ being $\{1,3\}$ under $1,3,5\in P$.

**"The author's open core is exactly this" is overstated.** The author's open case (an outside report archive (unpublished, held in the private record), section "The exact remaining lemmas") is "dense cyclic support with nonzero profile minors and active weight-four rectangles", and the rectangles are the terms $\langle y_S,y_{S\triangle U}\rangle$ of the finite-angle inequality over every nonzero character $U$. With $U$ a pair character, $S=\{i,j,k,l\}$ and $S\triangle U=\{i,j,k,l'\}$ share three indices, and both are $2+2$ when $l,l'\in Q'$. That rectangle also survives at a product diagonal and is a different configuration from I104's triple. Suggested wording: "the profile half of the open core vanishes here, and what remains are rectangles among $2+2$ four-sets, of which I104's triple is one type".

## Claims 7 and 8, the cross pairing

Relabel $(1,2,3,4)=(i,k,j,l)$: $v\mapsto W_{ij,kl}=u$, $w\mapsto W_{il,kj}=-w$, so the pairing bounds $(u-w)^2$. $\square=a_{ij}-a_{il}-a_{kj}+a_{kl}=\alpha+\gamma-2\beta$. $\delta^{jl}_i+\delta^{jl}_k=\tfrac12(\alpha-\beta)+\tfrac12(\beta-\gamma)$ and $\delta^{ik}_j+\delta^{ik}_l$ is the same, so those two terms give $\tfrac12(\alpha-\gamma)^2$. Each outside $m\in P$ gives $2[\tfrac14(\alpha-\beta)^2+\tfrac14(\alpha-\beta)^2]=(\alpha-\beta)^2$, there are $p-2$, and likewise $(\beta-\gamma)^2$ for the $q-2$ outside indices of $Q'$. Scaling $a=tE/\sqrt K$ gives the factor $t^2/K$. The pairing $(il\,|\,jk)$ bounds $(u+v)^2$ by the same bracket. On $\sigma(2,1,-1)$: $u-w=3\sigma$, $\lVert\nu_Q\rVert^2=2\cdot6\sigma^2$. **CONFIRMED.**

Balanced: $\alpha-\beta=\tfrac12$, $\beta-\gamma=-\tfrac12$, $\alpha=\gamma$, the bracket is $\tfrac14+\tfrac{m-2}2=\tfrac{2m-3}4$, $K=\tfrac{m^2(m-1)}{4(2m-1)}$, and the ratio is $\tfrac43\tfrac{(2m-3)(2m-1)}{m^2(m-1)}$. At $m=6$: $\tfrac43\cdot\tfrac{99}{180}=\tfrac{11}{15}=0.7\overline3$. Asymptotic $\tfrac{16}{3m}$. **CONFIRMED.**

## Claim 9, the endpoint reduction

**The criterion, rebuilt.** On the arc, $g=dt^3+3\tau tu^2+qu^3$ is exactly $P(te+uf)$, since $\langle Q(e),f\rangle=d\langle e,f\rangle=0$ and $\langle L_ef,f\rangle=\tau$. Interior critical points satisfy $\tau y^2-qy+(d-2\tau)=0$, $y=u/t$. There $qy^3=\tau y^4+(d-2\tau)y^2$, so $g=\tfrac{d+\tau y^2}{\sqrt{1+y^2}}$, and $g\le d$ iff $y^2\le Y^2:=\tfrac{d(d-2\tau)}{\tau^2}$. With the quadratic $h$: $h(Y)\ge0$ iff $(d-2\tau)(d+\tau)\ge q\sqrt{d(d-2\tau)}$, which is $dq^2\le(d+\tau)^2(d-2\tau)$. That inequality also puts the vertex $\tfrac q{2\tau}$ below $Y$ (it needs $\tau\le d$) and gives $q\le d$ at the far endpoint, because $(1+s)^2(1-2s)=1-3s^2-2s^3\le1$. If it fails, a root lies above $Y$ and $g>d$ there. At negative discriminant it holds automatically, by $4d\tau\le(d+\tau)^2$. **CONFIRMED**, for $q\ge0$. At $q<0$, $g\le dt^3+3\tau tu^2\le d$ once $d\ge2\tau$.

**The reduction.** $c_*=d\tfrac{2m-2}{2(m-1)^2}=\tfrac d{m-1}$, and $(d+\tau)^2(d-2\tau)/d=d^2\tfrac{m^2(m-3)}{(m-1)^3}$. Correct. **But "$\tau=\tfrac d{m-1}\le\tfrac d2$" holds only for $m\ge3$.** At $m=2$ ($S^2\times S^2$, $n=4$), $\tau=d$, the criterion's hypothesis $d\ge2\tau$ fails, and near $u=0$ we have $g\approx d(1+3u^2)>d(1+u^2)^{3/2}$, so the branch does not close there by this route. *Correction:* state the balanced reduction for $m\ge3$. At $m=3$ it demands $q=0$ exactly. "$Q(f)_{\mathcal D}=\tau e$" (the brief's "diagonal squares sum to $\tau e$") checks: the diagonal row of $Q(W)=\rho W$ makes $Q(f)_{\mathcal D}$ proportional to $e$, and $\langle Q(f),e\rangle=\langle L_ef,f\rangle=\tau$.

## Claim 10, hypotheses

- **Stated and used where claimed.** $C=0$ gives $Q(e)=de$ and $f$ an eigenvector. $\tau\ne0$ is used in rows 2 and 3, and $\tau>0$ in the criterion. The global maximal frame supplies the one-plane bound and the double rotation. The product hypothesis is used in every $\delta$ and $\square$ evaluation.
- **Unstated: $b>0$.** $f=B/b$ and the conclusion $\tau=c_*$ need $B\ne0$. $B=0$ is the diagonal case, which is covered elsewhere, but it should be excluded in words.
- **Unstated: $m\ge3$** in the balanced reduction (claim 9). $p,q\ge2$ is also implicit, since $E=0$ at $p=1$.
- **Order dependence.** The double rotation's hypothesis "every pair profile zero" is discharged by rows 1 and 2, so rows 3 ($4+0$) and 5 are conditional on them.
- **Sign.** "$e$ the Weyl tensor of a product" fixes $d>0$. The negated product $-E/\sqrt K$ is also diagonal with $Q(e)=de$, at $d<0$. It belongs under the classification hypothesis the note already flags, and that case is empty: every spectrum flips, and the only $2+2$ direction the pairing allows, $(2,1,-1)$, has eigenvalue $-c_*<0$, which contradicts $\tau>0$.
- **The classification hypothesis** (that $e$ is a two-sphere product) is flagged by the note itself as open. I did not check it.
