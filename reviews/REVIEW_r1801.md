# Review r1801: the closed branch at a product diagonal (I121, route R52)

Brief: [BRIEF_I121_closed_branch.md](BRIEF_I121_closed_branch.md). Log: agent_logs/r1801-closed.log (untracked, the folder is gitignored). Worked cold from the givens and the quoted claims, by hand throughout. **No computation was run**: every step, including the endpoint criterion, closed analytically.

**Verdict: every mathematical claim CONFIRMED.** Proposition 25.1 is rebuilt where the claims use it, and so is the binary endpoint criterion. There are four minor gaps, each a hypothesis left implicit or a wording, and none changes a conclusion.

| # | claim | verdict |
|---|---|---|
| 1 | the character-by-character table, and its conclusion $\tau=c_*$ with $f$ a combination of $+c_*$ modes | CONFIRMED (gap G1: $0<t<1$ and $\rho\ne0$ are used but not stated) |
| 2 | the $2+2$ eigenvectors $(2,1,-1)$ and $(0,1,1)$, and $v+w=0$ from the pairing $(ij\,|\,kl)$ | CONFIRMED |
| 3 | Proposition 25.1 where it is used: $W_{2,PQ}$, four-sets with $r\ne2$, $2+2$ values, and $c_*$ | CONFIRMED (rebuilt) |
| 4 | the cross-pairing bound, every term, and $\alpha,\beta,\gamma,K$ | CONFIRMED |
| 5 | the balanced constant $\tfrac43\tfrac{(2m-3)(2m-1)}{m^2(m-1)}$ and $0.733$ at $n=12$ | CONFIRMED |
| 6 | the reduction to $q^2\le d^2\tfrac{m^2(m-3)}{(m-1)^3}$, with the endpoint criterion | CONFIRMED (criterion rebuilt, with gap G2: $m\ge3$ is needed and unstated) |
| 7 | hypotheses | PLAUSIBLE: gaps G1 to G4 below, each minor |
| 8 | I104's triple survives, and it is exactly the case where each shared pair is split | CONFIRMED (combinatorics). "The author's open core is exactly this" is PLAUSIBLE, an interpretation the givens do not settle |

## Conventions rebuilt

- The objects are operators on $\Lambda^2$ in the basis $e_a\wedge e_b$, with HS norm and $e_a\wedge e_b=E_{ab}-E_{ba}$, so that $[e_i\wedge e_s,e_s\wedge e_j]=e_i\wedge e_j$ with sign $+1$ for every $s$. Also $Q(R)=R^2+R^\#$, and $Q(e,X)$ is its symmetric polarisation.
- Summing over ordered pairs gives $(R^\#)_{ij,kl}=\sum_{s\notin\{i,j\},\,t\notin\{k,l\}}\big[R(is,kt)R(sj,tl)-R(is,tl)R(sj,kt)\big]$. This is calibrated by $I^\#=(n-2)I$.
- **The second term matters.** Dropping it gives a four-set action that violates Bianchi. I checked this, and it is the kind of slip that would make the author's $C_0$ terms look wrong. With both terms, $2Q(e,X)=eX+Xe+\text{(the part of }(e+X)^\#\text{ linear in }X)$.

## Claim 3, Proposition 25.1 rebuilt

**The product diagonal.** A block-constant diagonal $E$ with values $\alpha,\beta,\gamma$ is Weyl iff $(p-1)\alpha+q\beta=0=p\beta+(q-1)\gamma$. The quoted values satisfy both.

- $\alpha+\gamma-2\beta=\big[(p+q)^2-3(p+q)+2\big]/N=1$.
- $\lVert E\rVert^2=\binom p2\alpha^2+pq\beta^2+\binom q2\gamma^2=\tfrac{p(p-1)q(q-1)}{2N^2}\cdot N=K$.
- $Q(E)_{ab,ab}=a_{ab}^2+\sum_ka_{ak}a_{kb}$. Across the factors this is $\beta(\beta+(p-1)\alpha+(q-1)\gamma)=(1-n)\beta^2$, and within $P$ it is $q\beta(\beta-\alpha)$. Both equal $d_E$ times the entry with $d_E=\tfrac{(p-1)(q-1)}{n-2}$.
- So $d=\tfrac{(p-1)(q-1)}{(n-2)\sqrt K}>0$, and $c_*=d\tfrac{n-2}{2(p-1)(q-1)}=\tfrac1{2\sqrt K}$.

**$W_{2,PQ}$, with $i\in P$ and $j\in Q'$.** Take the profile $x_m=X(im,jm)$ with $\sum_mx_m=0$ (the Ricci condition). The linear part of $\#$ at $(im,jm)$ is $-a_{ij}x_m+\sum_{k\notin\{i,j,m\}}a_{km}x_k$, and the second structure term contributes nothing here.

- Split $x$ into $y$ on $P\setminus i$ and $z$ on $Q'\setminus j$, with sums $Y+Z=0$. On $P\setminus i$ this gives $(L_EX)_m=\tfrac12(\alpha-\beta)Y$, and on $Q'\setminus j$ it gives $\tfrac12(\beta-\gamma)Y$.
- So $L_EX=Y\,\delta$ with $\delta_m=\tfrac12(a_{im}-a_{jm})$. This is rank one, with kernel $\{Y=0\}$, which is orthogonal to $\delta$.
- The one nonzero eigenvalue is $Y(\delta)=\tfrac{(p-1)(q-1)}{2(n-2)}$, which is $d/2$ after dividing by $\sqrt K$.
- $\operatorname{span}\delta$ is the orbit line. The infinitesimal rotation $\xi=e_i\wedge e_j$ gives $[\operatorname{ad}\xi,e](jm\to im)=a_{jm}-a_{im}=-2\delta_m$, with the same sign for every $m$. Equivariance gives $Q(e,\xi e)=\tfrac d2\xi e$ at any $e$ with $Q(e)=de$.
- **So the orbit line is exactly what $\langle\delta,x\rangle=0$ removes.** A $\tau$-eigenvector with $\tau>0$ is proportional to $\delta$, and only when $\tau=d/2$. Then $\langle\delta,x\rangle=c\lVert\delta\rVert^2=0$ with $\delta\ne0$, so $c=0$.
- The same formula on $W_{2,PP}$ reproduces the author's $0,-c_*,\tau_P$ with multiplicities $p-3,q-1,1$. Row 1 does not need this.

**Four-sets.** Use Bianchi coordinates $u=X(ij,kl)$, $v=X(ik,jl)$, $w=X(il,jk)$, with $u-v+w=0$ and $\lVert X\rVert^2=2(u^2+v^2+w^2)$.

- Computing both structure terms gives $2u'=A_0u+B_0w-C_0v$, $2v'=B_0v-C_0u-A_0w$ and $2w'=C_0w-A_0v+B_0u$. This is the author's (5), and $u'-v'+w'=0$ checks.
- In $(u,w)$ the matrix of $2L$ is $\begin{pmatrix}A_0-C_0&B_0-C_0\\B_0-A_0&C_0-A_0\end{pmatrix}$. It is traceless, so the eigenvalues of $L$ are $\pm\tfrac12\sqrt{A_0^2+B_0^2+C_0^2-A_0B_0-B_0C_0-C_0A_0}$.
- For a four-set inside one factor, and for any $3+1$ four-set, $A_0=B_0=C_0$ (in the $3+1$ case each is $\alpha+\beta$), so $L=0$.
- For a $2+2$ four-set, $A_0=\alpha+\gamma$ and $B_0=C_0=2\beta$, which gives $\pm\tfrac12$, that is $\pm c_*$.

## Claims 1 and 2, the table

- **Row 1.** Here $\delta^{ij}=0$ ($\alpha-\alpha$ and $\beta-\beta$), and the $\chi_{ij}$ component of $W$ is exactly the profile $x$, so $\lVert x\rVert\le0$. The component of $f=B/b$ is $x/b=0$. This row uses no spectrum. CONFIRMED.
- **Row 2.** As rebuilt above. CONFIRMED.
- **Rows 3 and 4.** $L_e=0$ there and $\tau\ne0$. In-factor four-sets have $\square=0$ and every $\delta=0$, so all three pairings vanish, and Bianchi's sum of squares kills the block. CONFIRMED.
- **Row 5.** With $A_0-C_0=1$ and $B_0=C_0$, $2L=\begin{pmatrix}1&0\\-1&-1\end{pmatrix}$ on $(u,w)$, so $2u'=u$ and $2v'=2u'+2w'=-w$.
  - $+\tfrac12$ gives $w=-u/2$, which is $(u,v,w)\propto(2,1,-1)$.
  - $-\tfrac12$ gives $u=0$ and $v=w$, which is $(0,1,1)$. The two are orthogonal.
  - The pairing $(ij\,|\,kl)$ has $\square=\beta-\beta-\beta+\beta=0$, and every $\delta^{ij}_\cdot,\delta^{kl}_\cdot$ is zero. The premise that every pair profile is zero is supplied by rows 1 and 2.
  - So $v+w=0$, which is $1+1\ne0$ for the $-c_*$ mode and $1-1=0$ for the $+c_*$ mode. CONFIRMED.
- **Conclusion.** Characters on $\Lambda^2$ have weight $0$, $2$ or $4$, and $f\ne0$. Every surviving component is a $+c_*$ mode, so some $2+2$ block is nonzero and $\tau=c_*$. CONFIRMED, given G1.

## Claims 4 and 5, the cross-pairing bound

- **Pairing $(ik\,|\,jl)$.** Map it to $(12\,|\,34)$ with $(1,2,3,4)=(i,k,j,l)$. Then $v_{\rm pair}=u$ and $w_{\rm pair}=-w$, so the pairing bounds $(u-w)^2$.
  - $\square=\alpha-2\beta+\gamma=1$.
  - $\delta^{34}_1+\delta^{34}_2=\tfrac12(\alpha-\beta)+\tfrac12(\beta-\gamma)=\tfrac12(\alpha-\gamma)$, and $\delta^{12}_3+\delta^{12}_4$ is the same.
  - Each outside $m\in P$ gives $2\cdot2\cdot\tfrac14(\alpha-\beta)^2=(\alpha-\beta)^2$, and there are $p-2$ of them. Each outside $m\in Q'$ gives $(\beta-\gamma)^2$, and there are $q-2$ of them.
  - The scale is $A=te=tE/\sqrt K$, which gives $t^2/K$. Every term CONFIRMED.
- **Pairing $(il\,|\,jk)$.** This gives $v_{\rm pair}+w_{\rm pair}=-(u+v)$ with the same bracket. CONFIRMED.
- **The $+c_*$ mode.** $\sigma(2,1,-1)$ has $u-w=u+v=3\sigma$, $\lVert\nu_Q\rVert^2=12\sigma^2$, and $(u-w)^2=\tfrac34\lVert\nu_Q\rVert^2$.
- **The balanced product $p=q=m$.** Here $\alpha-\gamma=0$ and $\alpha-\beta=\gamma-\beta=\tfrac12$.
  - The bracket is $\tfrac14+\tfrac{m-2}2=\tfrac{2m-3}4$.
  - With $N=2(2m-1)(m-1)$, $K=\tfrac{m^2(m-1)}{4(2m-1)}$.
  - At $m=6$ the constant is $\tfrac43\cdot\tfrac{99}{180}=0.7\overline3$. For large $m$ it behaves like $\tfrac{16}{3m}$, so each block is of order $m^{-1/2}\,t$.
  - CONFIRMED.

## Claim 6, the endpoint criterion rebuilt, and the reduction

**Restricting to $t,u\ge0$ loses nothing.**

- $P(xe+yf)=dx^3+3\tau xy^2+qy^3$, since $\langle Q(e),f\rangle=0$ and $\langle Q(e,f),f\rangle=\tau$.
- Points with $x<0$ are dominated, and $q\mapsto-q$ is the reflection $y\mapsto-y$, so only $q^2$ matters.

**The criterion.**

- Put $x=u/t$ and $r=\sqrt{1+x^2}\ge1$. "The maximum is $d$" is the statement $q\le\min_{r>1}\varphi(r)$, where $\varphi^2=h(r)=N(r)^2/\big((r-1)(r+1)^3\big)$ and $N=d(r^2+r+1)-3\tau(r+1)$.
- When $d\ge2\tau$, $N\ge\tau(2r+1)(r-1)\ge0$.
- $h'=0$ reduces to $N'(r^2-1)=N(2r-1)$, which reduces exactly to $-3r\,[d-\tau(r+1)]=0$. So $r^*=d/\tau-1$ is the unique critical point, with $h\to\infty$ as $r\to1^+$ (when $d>2\tau$) and $h\to d^2$ as $r\to\infty$.
- $N(r^*)=d(r^*+2)(r^*-1)$ gives $h(r^*)=(d+\tau)^2(d-2\tau)/d$.
- The criterion holds, in both directions. **CONFIRMED.**

**The reduction.** $c_*=d\tfrac{2m-2}{2(m-1)^2}=\tfrac d{m-1}$. Substituting gives $(d+\tau)^2(d-2\tau)=d^3\tfrac{m^2(m-3)}{(m-1)^3}$, and so the stated bound on $q^2$. CONFIRMED.

## Gaps (claim 7)

- **G1.** $C$, $z$ and L284 need $0<t<1$ (so $b>0$) and $\rho\ne0$, and the conclusion $\tau=c_*$ needs $f\ne0$. The text does not state either. **Correction:** add "$0<t<1$" to the section's "Assume".
- **G2.** "$\tau=c_*=\tfrac d{m-1}\le\tfrac d2$" holds only for $m\ge3$. At $m=2$ ($n=4$), $c_*=d$ and the criterion does not apply. This is harmless at $n\ge12$ but should be stated.
- **G3.** The first section says the cross-pairing bounds on $\lVert\nu_Q\rVert$ bound $r=b/t$. The second section correctly says they do not, when many four-sets are active. **Correction:** change the first section to "bound each four-set's $\lVert\nu_Q\rVert$ against $t$; they bound $r$ only if $f$ is spread over boundedly many four-sets".
- **G4.** "Reduces the balanced closed branch to a bound on $q$" is a sufficient condition. Meeting the bound gives $\rho=d\le\Theta_n$ by L57. Failing it does not refute (MG), which could still hold through $\rho\le\sqrt{3/2}$. The wording should say "suffices".
- **Used and stated:** global frame maximality (rows 1, 2, 3 and 5, and the cross pairings), $\tau>0$ (rows 2 to 5), $C=0$, and $e$ a product in the maximal frame (flagged as the hypothesis to discharge). $p,q\ge2$ is automatic, since $e$ is a unit vector and $K>0$ requires it.
