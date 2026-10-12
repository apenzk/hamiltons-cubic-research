# r744, Ricci-flatness and first Bianchi for $W_{a,b}=a\Pi_{\mathfrak k}+b\Pi_{\mathfrak m}$ on $\mathbb R^{2m}$

Gate 2, brief [BRIEF-g2-l166.md](BRIEF-g2-l166.md). **The brief was read cold**: I formed a verdict on every claim from the brief's own statement of the definitions, the statement and the proof, before opening any findings file, and I have opened none. **No numerical work was done.** Every value in this report is exact (rational, derived by hand) and the one machine run is a screen in the sense the standing rule allows: seconds of exact-fraction arithmetic on objects I built for the purpose, reported in §10 as a screen and cited nowhere as evidence for a positive claim. Log: [agent_logs/g2-l166-r744.log](../agent_logs/g2-l166-r744.log).

## Claim table

| # | claim as written | verdict |
| --- | --- | --- |
| 1 | $\mathfrak{su}(m)=\{X+iY: X$ real skew, $Y$ real symmetric traceless$\}$; $\mathfrak k$ spanned by $\tfrac1{\sqrt2}(e_i\wedge e_j+f_i\wedge f_j)$, $\mathfrak m$ by $\tfrac1{\sqrt2}(e_k\wedge f_l+e_l\wedge f_k)$ and the traceless span of $\{e_k\wedge f_k\}$; $p+q=m^2-1$ | **CONFIRMED**, each spanning element derived from its operator, normalisations correct |
| 2 | $\mathrm{Ric}(W)=\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ | **CONFIRMED** as an exact identity under the brief's conventions; nothing downstream reads an absolute value |
| 3a | $C_{\mathfrak{su}(m)}$ scalar by Schur on $\mathbb C^m$ | **CONFIRMED** for $m\ge2$ |
| 3b | $C_{\mathfrak k}$ scalar because $\mathbb C^m|_{\mathfrak{so}(m)}$ is two copies of one real irreducible | **GAP at $m=2$**, the cited reason does not apply there; the conclusion is true, by direct computation (§3) |
| 4 | $\operatorname{tr}C_{\mathfrak h}=2\dim\mathfrak h$, hence $C_{\mathfrak k}=\tfrac pm$, $C_{\mathfrak m}=\tfrac qm$ | **CONFIRMED**, and both re-derived independently of scalarity |
| 5 | the displayed $\Omega_{\mathfrak h}$, its total antisymmetry, and Bianchi $\iff\Omega=0$ | **CONFIRMED**, sign of $\langle v,x\wedge y\rangle$ tracked and clean |
| 6 | both forms vanish on the four outer summands at every $m$ | **claim CONFIRMED; the stated reason is INCOMPLETE**, it does not cover $\Omega_{\mathfrak k}$ on $\Lambda^4A$ or $\Lambda^4B$ (§6) |
| 7 | $SO(m)$-invariants of $\Lambda^4$ sit in the middle summand alone once $m\ne4$, giving a line | **CONFIRMED**, including $m=2$ and $m=3$ where outer summands vanish outright |
| 8 | $\Omega_{\mathfrak k}(e_1,e_2,f_1,f_2)=\tfrac12$, $\Omega_{\mathfrak m}(e_1,e_2,f_1,f_2)=\tfrac12+\tfrac1m$, both zero at $(e_1,e_2,f_3,f_4)$; $\mathrm{Id}$ separated from $*$ at $m=4$ | **CONFIRMED**, third term derived not read: it is $+\tfrac1m$ |
| 9 | $ap+bq=\tfrac{m-1}2[am+b(m+2)]$, and the two conditions cut the same line | **CONFIRMED** for every $m\ge2$ |
| 11 | the $m=2$ edge | **CONFIRMED, and the brief's own premise about it is wrong**, Bianchi is automatic on $S^2_0(\Lambda^\pm)$, not on $S^2(\Lambda^\pm)$; $\Pi_{\Lambda^+}$ has $\Omega=\tfrac32$ (§11) |
| 12 | no falsifying $(m,a,b)$ | **CONFIRMED** by closed form at every $m\ge2$ and every $(a,b)$ |

**Actionable summary.** The statement is true exactly as written and both linear conditions are the single equation $am+b(m+2)=0$; two sentences of the written proof do not establish what they claim, the $m=2$ scalarity of $C_{\mathfrak k}$ and the vanishing of $\Omega_{\mathfrak k}$ on $\Lambda^4A\oplus\Lambda^4B$, and each is closed by one line supplied in §3 and §6.

## 0. Conventions, fixed once

Inner product on skew matrices: $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, so $\operatorname{tr}(v^2)=-2$ for a unit bivector. Wedge: $x\wedge y$ is $z\mapsto\langle x,z\rangle y-\langle y,z\rangle x$, that is the matrix $yx^{\mathsf T}-xy^{\mathsf T}$. Curvature of a symmetric $W$ on $\Lambda^2$: $R(x,y,z,w)=\langle W(x\wedge y),z\wedge w\rangle$. Ricci trace: $\mathrm{Ric}(x,z)=\sum_bR(x,u_b,z,u_b)$ over an orthonormal frame $\{u_b\}$ of $\mathbb R^N$. First Bianchi in the cyclic form $R(x,y,z,w)+R(y,z,x,w)+R(z,x,y,w)=0$.

$\mathbb R^{2m}=A\oplus B$ with $A=\langle e_1,\dots,e_m\rangle$, $B=\langle f_1,\dots,f_m\rangle$, $f_k=Je_k$; the real vector of $u+iw\in\mathbb C^m$ is $\sum u_ke_k+\sum w_kf_k$. $p=\binom m2$, $q=\binom{m+1}2-1=\tfrac{(m-1)(m+2)}2$. All arithmetic below is exact.

One recurring identity, established once in §2 and used throughout: for skew $v$, $\langle v,x\wedge y\rangle=\langle vx,y\rangle$.

## Hypothesis inventory

| hypothesis | where it enters | status against the object |
| --- | --- | --- |
| $m\ge2$ | the Ricci factorisation divides by nothing but needs $m-1\ne0$ to invert; $\mathfrak{su}(m)\ne0$ needs $m\ge2$ | **load-bearing and correct.** At $m=1$, $p=q=0$, so $W_{a,b}=0$ for every $(a,b)$ and both conditions hold identically, while $am+b(m+2)=a+3b$ does not, the "nowhere else" half of the statement fails at $m=1$ |
| $W$ symmetric on $\Lambda^2$ | needed for $R$ to have pair symmetry, hence for the cyclic form of Bianchi to be the right identity | holds: $\Pi_{\mathfrak k}$, $\Pi_{\mathfrak m}$ are orthogonal projectors, hence symmetric, and so is any real combination |
| $\{v_\alpha\}$ orthonormal in $\mathfrak h$ for $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ | $\Pi_{\mathfrak h}=\sum v_\alpha v_\alpha^{\mathsf T}$, and $\operatorname{tr}C_{\mathfrak h}=2\dim\mathfrak h$ | verified in §1 for the three families given, including the $\tfrac1{\sqrt2}$ |
| Schur over $\mathbb C$ (finite-dimensional, irreducible, intertwiner $\mathbb C$-linear) | $C_{\mathfrak{su}(m)}$ scalar | all three hold for $m\ge2$; complex-linearity checked in §3 |
| $\mathbb R^m$ irreducible over $\mathbb R$ for $\mathfrak{so}(m)$ | $C_{\mathfrak k}$ scalar | true for all $m\ge2$, **but insufficient at $m=2$**, where the module is of complex type and real Schur returns $\mathbb C$, not $\mathbb R$. See §3 |
| $\Lambda^2\mathbb R^m$ irreducible for $SO(m)$ | the middle summand carries a line of invariants | true for $m=3$ and $m\ge5$; at $m=2$ it is one-dimensional and trivial, which gives the same conclusion; at $m=4$ it splits and the proof handles that separately |
| $\Lambda^\pm$ splitting at $m=2$ | only in the consistency check of §11, not in the proof | correct as a splitting; the brief's gloss on what it implies is not (§11) |
| the normalisation of $\mathrm{Ric}$ | nothing downstream | **unused as a value.** The conclusion reads only the ratio $C_{\mathfrak k}:C_{\mathfrak m}=p:q$, which any overall constant leaves fixed |

No stated hypothesis is idle except the $\mathrm{Ric}$ normalisation, which is idle in the harmless sense just described.

## 1. The identification of $\mathfrak k$ and $\mathfrak m$, and every spanning element

Write $Z=X+iY$ with $X,Y$ real $m\times m$. Anti-Hermitian means $Z^*=-Z$, that is $X^{\mathsf T}-iY^{\mathsf T}=-X-iY$, so $X^{\mathsf T}=-X$ and $Y^{\mathsf T}=Y$: $\mathfrak u(m)=\{X+iY: X$ real skew, $Y$ real symmetric$\}$. Its trace is $\operatorname{tr}X+i\operatorname{tr}Y=i\operatorname{tr}Y$, since a real skew matrix is traceless. Hence $\mathfrak{su}(m)$ is the same set with $\operatorname{tr}Y=0$, which is the brief's description. **Confirmed.**

Realised on $\mathbb R^{2m}$: $(X+iY)(u+iw)=(Xu-Yw)+i(Yu+Xw)$, so in the $(A,B)$ blocks the real matrix is $\begin{pmatrix}X&-Y\\Y&X\end{pmatrix}$.

**$\mathfrak k$ ($Y=0$).** The matrix is $\operatorname{diag}(X,X)$. Take $X$ to be the operator $e_i\wedge e_j$ on $A$: it sends $e_i\mapsto e_j$, $e_j\mapsto-e_i$. The block form therefore sends $e_i\mapsto e_j$, $e_j\mapsto-e_i$, $f_i\mapsto f_j$, $f_j\mapsto-f_i$, which is exactly the operator $e_i\wedge e_j+f_i\wedge f_j$. The two summands are orthogonal unit bivectors, so the norm is $\sqrt2$ and the normalised element is $\tfrac1{\sqrt2}(e_i\wedge e_j+f_i\wedge f_j)$, $i<j$. **Confirmed**, count $\binom m2=p$.

**$\mathfrak m$ ($X=0$).** The matrix is $\begin{pmatrix}0&-Y\\Y&0\end{pmatrix}$, so $e_k\mapsto\sum_lY_{lk}f_l$ and $f_l\mapsto-\sum_kY_{kl}e_k$.

- $Y=E_{kl}+E_{lk}$, $k\ne l$: $e_k\mapsto f_l$, $e_l\mapsto f_k$, $f_l\mapsto-e_k$, $f_k\mapsto-e_l$. The operator $e_k\wedge f_l$ sends $e_k\mapsto f_l$, $f_l\mapsto-e_k$; the operator $e_l\wedge f_k$ sends $e_l\mapsto f_k$, $f_k\mapsto-e_l$. Their sum is exactly the above, has norm $\sqrt2$, and normalises to $\tfrac1{\sqrt2}(e_k\wedge f_l+e_l\wedge f_k)$. **Confirmed.**
- $Y=\operatorname{diag}(y_1,\dots,y_m)$ with $\sum y_k=0$: $e_k\mapsto y_kf_k$, $f_k\mapsto-y_ke_k$, that is $\sum_ky_k(e_k\wedge f_k)$. Since $\{e_k\wedge f_k\}$ is orthonormal, this is precisely the traceless span the brief names, with the induced inner product the standard one on $\{y:\sum y_k=0\}$. **Confirmed**, dimension $m-1$.

Count: $q=\binom m2+(m-1)=\tfrac{m(m-1)}2+m-1=\tfrac{(m-1)(m+2)}2$, which equals $\binom{m+1}2-1=\tfrac{m^2+m-2}2$. And $p+q=\tfrac{m(m-1)}2+\tfrac{m(m+1)}2-1=m^2-1$. **Confirmed.**

A useful by-product for §8: the induced inner product on the symmetric matrix $Y$ is $\lVert v\rVert^2=\tfrac12\big(\operatorname{tr}(Y^{\mathsf T}Y)+\operatorname{tr}(Y^{\mathsf T}Y)\big)=\operatorname{tr}(Y^2)$, so an orthonormal basis of $\mathfrak m$ corresponds to an orthonormal basis of $\mathrm{Sym}_0(m)$ under $\langle Y,Y'\rangle=\operatorname{tr}(YY')$. Both checks agree: $Y=E_{12}+E_{21}$ gives $\operatorname{tr}(Y^2)=2$ and $\lVert e_1\wedge f_2+e_2\wedge f_1\rVert^2=2$; a traceless diagonal $Y$ gives $\sum y_k^2$ either way.

## 2. The spectral form of $\mathrm{Ric}$

First the bracket identity. With $x\wedge y=yx^{\mathsf T}-xy^{\mathsf T}$ and $v$ skew,
$$\operatorname{tr}\!\big(v^{\mathsf T}(yx^{\mathsf T}-xy^{\mathsf T})\big)=x^{\mathsf T}v^{\mathsf T}y-y^{\mathsf T}v^{\mathsf T}x=\langle v^{\mathsf T}y,x\rangle-\langle v^{\mathsf T}x,y\rangle=-\langle vy,x\rangle+\langle vx,y\rangle=2\langle vx,y\rangle,$$
so $\langle v,x\wedge y\rangle=\langle vx,y\rangle$, with no sign to carry. (Had the opposite wedge convention been intended, this would read $-\langle vx,y\rangle$; since every term of $R$ and of $\Omega$ below is quadratic in a single $v_\alpha$, that choice is invisible in the results.)

Now let $W=\sum_\alpha\lambda_\alpha v_\alpha v_\alpha^{\mathsf T}$ spectrally, $\{v_\alpha\}$ orthonormal in $\Lambda^2$. Then
$$R(x,y,z,w)=\langle W(x\wedge y),z\wedge w\rangle=\sum_\alpha\lambda_\alpha\langle v_\alpha,x\wedge y\rangle\langle v_\alpha,z\wedge w\rangle=\sum_\alpha\lambda_\alpha\langle v_\alpha x,y\rangle\langle v_\alpha z,w\rangle,$$
and tracing,
$$\mathrm{Ric}(x,z)=\sum_bR(x,u_b,z,u_b)=\sum_\alpha\lambda_\alpha\sum_b\langle v_\alpha x,u_b\rangle\langle v_\alpha z,u_b\rangle=\sum_\alpha\lambda_\alpha\langle v_\alpha x,v_\alpha z\rangle=\Big\langle\Big(\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha\Big)x,\,z\Big\rangle.$$
So $\mathrm{Ric}(W)=\sum_\alpha\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ **exactly**, with no stray constant, under the frame trace $\sum_bR(x,u_b,z,u_b)$. **Confirmed.** For $W=\Pi_{\mathfrak h}$ the eigenvalues are $1$ on $\mathfrak h$ and $0$ off it, and $v^{\mathsf T}v=-v^2$ for skew $v$, so $\mathrm{Ric}(\Pi_{\mathfrak h})=-\sum_{v\in\mathfrak h}v^2=C_{\mathfrak h}$, matching the proof.

**Does anything downstream read a value?** No. The conclusion is $ap+bq=0$, which is homogeneous of degree one in $\mathrm{Ric}$; rescaling $\mathrm{Ric}$ by any nonzero constant leaves the line untouched. What *is* read is the ratio $C_{\mathfrak k}:C_{\mathfrak m}$, and that is normalisation-independent. Recording this explicitly because the brief asks: **a constant factor here is harmless, and no step depends on the constant being $1$.**

One notational point worth flagging in the write-up: $\Pi_{\mathfrak h}=\sum_\alpha v_\alpha v_\alpha^{\mathsf T}$ reads $v_\alpha$ as a *vector in $\Lambda^2$*, while $\mathrm{Ric}(W)=\sum\lambda_\alpha v_\alpha^{\mathsf T}v_\alpha$ reads the same symbol as a *matrix on $\mathbb R^N$*. Both are correct; the overload is a reading hazard, not an error.

## 3. The three scalarity claims

**$C_{\mathfrak{su}(m)}$.** Each $v\in\mathfrak{su}(m)\subset\mathfrak{gl}(m,\mathbb C)$ is complex-linear, hence so is $v^2$ and hence so is $C=-\sum v_\alpha^2$. The restriction of $\langle X,Y\rangle=-\tfrac12\operatorname{tr}(XY)$ to $\mathfrak{su}(m)$ is $\mathrm{Ad}$-invariant, so $C$ commutes with the $\mathfrak{su}(m)$-action in the standard way. $\mathbb C^m$ is irreducible over $\mathbb C$ for $\mathfrak{su}(m)$, $m\ge2$. Schur gives $C=c\,\mathrm{Id}$. **Confirmed**, with complex-linearity checked as the brief asks.

**$C_{\mathfrak k}$, this is where the written reason fails.** Two separate things are needed: no mixing between $A$ and $B$, and scalarity on each. *No mixing* is immediate and stronger than the proof states: every $v\in\mathfrak k$ is the block matrix $\operatorname{diag}(X,X)$, so $v^2=\operatorname{diag}(X^2,X^2)$ and $C_{\mathfrak k}$ is block-diagonal with equal blocks by construction. This matters, because for $m\ge3$ the module $V\oplus V$ has commutant $M_2(\mathbb R)$, so "two copies of one real irreducible" alone would permit mixing; the proof's parenthetical *on which $C$ acts identically* is doing that work, and it is true.

*Scalarity on each block* is where $m=2$ breaks. The brief's own framing ("$\mathbb R^2$ is not irreducible over $\mathbb R$") is itself inaccurate: $\mathfrak{so}(2)$ acting on $\mathbb R^2$ has **no** real invariant line, so $\mathbb R^2$ *is* irreducible over $\mathbb R$. What fails is *absolute* irreducibility (the module is of complex type, $\mathrm{End}_{\mathfrak{so}(2)}(\mathbb R^2)\cong\mathbb C$) so real Schur returns a two-dimensional endomorphism algebra and **does not** force $C$ to be scalar. For $m\ge3$, $\mathbb R^m$ is of real type for $\mathfrak{so}(m)$ and the argument goes through.

**The repair, valid at every $m\ge2$, and it needs no representation theory at all.** With $v_{ij}=\tfrac1{\sqrt2}\operatorname{diag}(X_{ij},X_{ij})$ and $X_{ij}=e_i\wedge e_j$ on $\mathbb R^m$, we have $X_{ij}^2=-(E_{ii}+E_{jj})$, so
$$C_{\mathfrak k}=-\sum_{i<j}v_{ij}^2=\tfrac12\sum_{i<j}\operatorname{diag}\big(E_{ii}+E_{jj},\,E_{ii}+E_{jj}\big)=\tfrac{m-1}2\,\mathrm{Id}_{2m},$$
each index appearing in $m-1$ pairs. This is $\tfrac pm\,\mathrm{Id}$, and at $m=2$ it reads $\tfrac12\,\mathrm{Id}_4$, scalar, as claimed, for a reason that survives.

**$C_{\mathfrak m}=C_{\mathfrak{su}(m)}-C_{\mathfrak k}$** is then scalar, and this step is sound *given* the two above. I also computed it directly, both to close the $m=2$ hole without leaning on the subtraction and because §8 needs the same projector:

- Off-diagonal. For $w=\tfrac1{\sqrt2}(e_k\wedge f_l+e_l\wedge f_k)$: $e_k\mapsto\tfrac1{\sqrt2}f_l\mapsto-\tfrac12e_k$, and likewise on $e_l,f_k,f_l$, so $-w^2=\tfrac12(E_{e_ke_k}+E_{e_le_l}+E_{f_kf_k}+E_{f_lf_l})$. Summing over $k<l$ gives $\tfrac{m-1}2\,\mathrm{Id}_{2m}$.
- Diagonal. With $u_\beta=\sum_kc_{\beta k}(e_k\wedge f_k)$ an orthonormal basis of the traceless span, $u_\beta^2$ acts as $-c_{\beta k}^2$ on $e_k$ and on $f_k$, and $\sum_\beta c_{\beta k}^2=1-\tfrac1m$ since $\sum_\beta c_{\beta k}c_{\beta l}=\delta_{kl}-\tfrac1m$ is the projector onto $\{\sum y_k=0\}$. So this part is $\tfrac{m-1}m\,\mathrm{Id}_{2m}$.

Total $C_{\mathfrak m}=(m-1)\big(\tfrac12+\tfrac1m\big)\mathrm{Id}=\tfrac{(m-1)(m+2)}{2m}\mathrm{Id}=\tfrac qm\,\mathrm{Id}$. Cross-check: $C_{\mathfrak k}+C_{\mathfrak m}=\tfrac{(m-1)(2m+2)}{2m}=\tfrac{m^2-1}m=\tfrac{p+q}m$, which is $C_{\mathfrak{su}(m)}$ by §4. **Consistent.**

**Discrepancy 3b, cleared through the three tests.** *Located*: the clause "$C_{\mathfrak k}$ is scalar because $\mathbb C^m|_{\mathfrak{so}(m)}=\mathbb R^m\oplus i\mathbb R^m$ is two copies of one real irreducible". *Exhibited concretely*: at $m=2$ that module is irreducible of complex type, its real endomorphism algebra is $\mathbb C$ and contains the non-scalar $\tfrac1{\sqrt2}(e_1\wedge e_2+f_1\wedge f_2)$ itself, so irreducibility does not by itself exclude a non-scalar commuting operator. *The opposite argued*: one could object that $m=2$ needs no separate treatment because $\mathfrak{so}(2)$ is one-dimensional and $-v^2$ for a unit $v$ is visibly $\tfrac12\mathrm{Id}$, which is correct, and is exactly why the finding is a defect in the *justification* and not in the claim.

## 4. The trace evaluation

$\lVert v\rVert^2=\tfrac12\operatorname{tr}(v^{\mathsf T}v)=-\tfrac12\operatorname{tr}(v^2)$, so a unit bivector has $\operatorname{tr}(v^2)=-2$ and $\operatorname{tr}C_{\mathfrak h}=-\sum_\alpha\operatorname{tr}(v_\alpha^2)=2\dim\mathfrak h$. **Confirmed.** The bases of §1 are orthonormal for exactly this pairing (that is what the $\tfrac1{\sqrt2}$ delivers) so the count is right. If $C_{\mathfrak h}=c\,\mathrm{Id}_{2m}$ then $2mc=2\dim\mathfrak h$, hence $c=\tfrac{\dim\mathfrak h}m$: $C_{\mathfrak k}=\tfrac pm$, $C_{\mathfrak m}=\tfrac qm$. **Confirmed**, and independently reproduced in §3 without using scalarity as an input.

Ricci-flatness is then $aC_{\mathfrak k}+bC_{\mathfrak m}=\tfrac{ap+bq}m\mathrm{Id}=0$, i.e. $ap+bq=0$. Since $\mathrm{Ric}(W_{a,b})$ is scalar and $\operatorname{tr}_{\mathbb R^{2m}}\mathrm{Ric}(W)=\sum_\alpha\lambda_\alpha\operatorname{tr}(v_\alpha^{\mathsf T}v_\alpha)=2\operatorname{tr}_{\Lambda^2}W$, the proof's slogan "**Ricci-flatness is tracelessness**" is literally right here: $\mathrm{Ric}=0\iff\operatorname{tr}_{\Lambda^2}W_{a,b}=ap+bq=0$.

## 5. The Bianchi sum

Substituting §2's expression for $R$ into the cyclic identity, with $W=\Pi_{\mathfrak h}$ (all $\lambda_\alpha=1$ on $\mathfrak h$):
$$\Omega_{\mathfrak h}(x,y,z,w)=\sum_\alpha\big[\langle v_\alpha x,y\rangle\langle v_\alpha z,w\rangle+\langle v_\alpha y,z\rangle\langle v_\alpha x,w\rangle+\langle v_\alpha z,x\rangle\langle v_\alpha y,w\rangle\big].$$
This is the brief's display, term for term and sign for sign. **Confirmed.** Since first Bianchi is the vanishing of this cyclic sum for all $x,y,z,w$, "first Bianchi $\iff\Omega_{\mathfrak h}\equiv0$" is the identity itself, not a reformulation. **Confirmed.**

**Total antisymmetry, derived rather than assumed.** *Cyclic in $(x,y,z)$*: the substitution $x\to y\to z\to x$ carries term 1 to term 2, term 2 to term 3, term 3 to term 1. *Antisymmetric in $x\leftrightarrow y$*: using $\langle vb,a\rangle=-\langle va,b\rangle$, the swapped sum is $-\langle v x,y\rangle\langle vz,w\rangle-\langle vz,x\rangle\langle vy,w\rangle-\langle vy,z\rangle\langle vx,w\rangle=-\Omega$. Those two give full antisymmetry in $x,y,z$. *Antisymmetric in $z\leftrightarrow w$*: adding $\Omega(x,y,z,w)$ and $\Omega(x,y,w,z)$, the first terms cancel as $\langle vx,y\rangle(\langle vz,w\rangle+\langle vw,z\rangle)=0$, and the remaining four group as $\langle vy,z\rangle(\langle vx,w\rangle+\langle vw,x\rangle)+\langle vy,w\rangle(\langle vz,x\rangle+\langle vx,z\rangle)=0$. Together these generate all of $S_4$, so $\Omega_{\mathfrak h}$ is a $4$-form. **Confirmed.**

**Invariance.** For $g\in O(2m)$, $\Omega_{\mathfrak h}(gx,gy,gz,gw)=\Omega_{g^{-1}\mathfrak hg}(x,y,z,w)$, since $\langle v_\alpha gx,gy\rangle=\langle g^{-1}v_\alpha gx,y\rangle$ and conjugation is an isometry of $\Lambda^2$, carrying an orthonormal basis of $\mathfrak h$ to one of $g^{-1}\mathfrak hg$. So $\Omega_{\mathfrak h}$ is invariant under the normaliser. **Confirmed.** The group actually used is $SO(m)$ embedded diagonally as $\operatorname{diag}(g,g)$; it normalises $\mathfrak k$ trivially and normalises $\mathfrak m$ because $g(iY)g^{-1}=i(gYg^{\mathsf T})$ is again symmetric and traceless, this is the symmetric pair $SU(m)/SO(m)$. Under it $A\cong B\cong V$, the standard module.

## 6. Vanishing on the four outer summands, the claim holds, the stated reason does not

Because $\Omega$ is a $4$-form, it is determined by its values on $4$-tuples of *distinct* basis vectors from $\{e_i\}\cup\{f_j\}$, and vanishes whenever two arguments coincide. I checked all four summands for **both** algebras.

**$\Lambda^3A\otimes B$**, arguments $(e_1,e_2,e_3,f_j)$. The three terms are $\langle ve_1,e_2\rangle\langle ve_3,f_j\rangle$, $\langle ve_2,e_3\rangle\langle ve_1,f_j\rangle$, $\langle ve_3,e_1\rangle\langle ve_2,f_j\rangle$. Every term carries **both** an $AA$ factor and an $AB$ factor, so $\mathfrak m$ kills it (it exchanges $A$ and $B$, so $\langle ve,e'\rangle=0$) and $\mathfrak k$ kills it (it preserves each, so $\langle ve,f\rangle=0$). **Both vanish; the stated reason covers this summand.**

**$A\otimes\Lambda^3B$**, arguments $(e_1,f_1,f_2,f_3)$. Terms $\langle ve_1,f_1\rangle\langle vf_2,f_3\rangle$, $\langle vf_1,f_2\rangle\langle ve_1,f_3\rangle$, $\langle vf_2,e_1\rangle\langle vf_1,f_3\rangle$: again every term carries both an $AB$ and a $BB$ factor. **Both vanish; covered.**

**$\Lambda^4A$**, arguments $(e_1,e_2,e_3,e_4)$. Every factor in every term is of type $\langle ve,e'\rangle$. This kills $\mathfrak m$. **It does not kill $\mathfrak k$**, for $v\in\mathfrak k$ these factors are generically nonzero, and no term carries an $AB$ factor. So the sentence "every term of $\Omega$ carries a factor $\langle ve,e'\rangle$ or $\langle vf,f'\rangle$, which $\mathfrak m$ kills …, or a factor $\langle ve,f\rangle$, which $\mathfrak k$ kills" **does not establish $\Omega_{\mathfrak k}|_{\Lambda^4A}=0$**. Same hole at $\Lambda^4B$ by the mirror argument.

**The claim is nonetheless true, and here is the one-line repair.** Restricted to $A$, the elements $\tfrac1{\sqrt2}X_{ij}$ form $\tfrac1{\sqrt2}$ times an orthonormal basis of $\Lambda^2A$, so for $x,y,z,w\in A$ the reproducing kernel gives $\sum_\alpha\langle v_\alpha x,y\rangle\langle v_\alpha z,w\rangle=\tfrac12\langle x\wedge y,z\wedge w\rangle$. And
$$\langle x\wedge y,z\wedge w\rangle=\tfrac12\operatorname{tr}\!\big((xy^{\mathsf T}-yx^{\mathsf T})(wz^{\mathsf T}-zw^{\mathsf T})\big)=\langle x,z\rangle\langle y,w\rangle-\langle x,w\rangle\langle y,z\rangle,$$
the constant-curvature tensor, whose cyclic sum telescopes to zero:
$$\big[\langle x,z\rangle\langle y,w\rangle-\langle x,w\rangle\langle y,z\rangle\big]+\big[\langle y,x\rangle\langle z,w\rangle-\langle y,w\rangle\langle z,x\rangle\big]+\big[\langle z,y\rangle\langle x,w\rangle-\langle z,w\rangle\langle x,y\rangle\big]=0.$$
Hence $\Omega_{\mathfrak k}|_{\Lambda^4A}=\tfrac12\cdot0=0$, and identically on $\Lambda^4B$. A direct index check agrees: term 1 needs $\{i,j\}=\{1,2\}$ and $\{i,j\}=\{3,4\}$ at once, impossible, and likewise for terms 2 and 3.

**Discrepancy 6, cleared through the three tests.** *Located*: the sentence beginning "Both forms vanish identically on the four outer summands at every $m$", specifically its justification clause. *Exhibited concretely*: on $(e_1,e_2,e_3,e_4)$ with $v\in\mathfrak k$, the factor $\langle ve_1,e_2\rangle$ equals $\tfrac1{\sqrt2}$ for $v=v_{12}$, nonzero, so neither of the two offered reasons applies to any of the three terms. *The opposite argued*: one might read "every term carries a factor … or a factor …" as quantified over the pair $(\text{summand},\text{algebra})$ jointly, so that on $\Lambda^4A$ only the $\mathfrak m$ half is being asserted; but the sentence asserts *both forms* vanish on *all four* summands, so on that reading half of what it asserts is left unargued. Either way the written justification is short of the claim.

**Severity.** Repairable in one sentence, and the claim itself stands.

## 7. The invariant count

As $SO(m)$-modules, $\Lambda^4(A\oplus B)=\Lambda^4A\oplus(\Lambda^3A\otimes B)\oplus(\Lambda^2A\otimes\Lambda^2B)\oplus(A\otimes\Lambda^3B)\oplus\Lambda^4B$ with $A\cong B\cong V=\mathbb R^m$. Taking invariants summand by summand, using $V\cong V^*$:

| summand | invariants | $m=2$ | $m=3$ | $m=4$ | $m\ge5$ |
| --- | --- | --- | --- | --- | --- |
| $\Lambda^4V$ | volume form only when $m=4$ | $0$ (zero space) | $0$ (zero space) | $1$ | $0$ ($\Lambda^4V$ irreducible nontrivial) |
| $\Lambda^3V\otimes V$ | $\dim\mathrm{Hom}(\Lambda^3V,V)$ | $0$ | $0$ ($\Lambda^3V$ trivial, $V$ not) | $1$ ($\Lambda^3V\cong V$ by Hodge) | $0$ |
| $\Lambda^2V\otimes\Lambda^2V$ | $\dim\mathrm{End}(\Lambda^2V)$ | $1$ ($\Lambda^2V$ one-dimensional trivial) | $1$ ($\Lambda^2V\cong V$, real type) | $2$ ($\Lambda^+\oplus\Lambda^-$, non-isomorphic) | $1$ (adjoint irreducible, real type) |

So the total is $1$ for every $m\ne4$, concentrated in the middle summand, and the middle summand carries $2$ at $m=4$. **Confirmed**, including the two small cases the brief flags: at $m=2$ and $m=3$ the outer summands are zero spaces or carry no invariant, and $\Lambda^2\mathbb R^m$ behaves as the argument needs, one-dimensional and trivial at $m=2$, the irreducible $\mathbb R^3$ at $m=3$. The one place irreducibility of $\Lambda^2V$ genuinely matters is $m\ge5$ and $m=3$, and there $\mathfrak{so}(m)$ is simple and its adjoint is of real type, so $\dim\mathrm{End}=1$.

The middle invariant corresponding to $T\in\mathrm{End}(\Lambda^2V)$ is the $4$-form $\omega_T(x,y,z,w)=\langle T(x\wedge y),z\wedge w\rangle$ for $x,y\in A$, $z,w\in B$. For $m\ne4$ the space is the line $\mathbb R\,\omega_{\mathrm{Id}}$, and $\omega_{\mathrm{Id}}(e_1,e_2,f_1,f_2)=\langle e_1\wedge e_2,e_1\wedge e_2\rangle=1\ne0$, so **the single evaluation at $(e_1,e_2,f_1,f_2)$ is injective on the invariant line**, which is exactly what licenses reading Bianchi off one number.

## 8. The two evaluations, derived term by term

Throughout, $x=e_1$, $y=e_2$, and the three terms of $\Omega$ are
$$T_1=\langle ve_1,e_2\rangle\langle vz,w\rangle,\qquad T_2=\langle ve_2,z\rangle\langle ve_1,w\rangle,\qquad T_3=\langle vz,e_1\rangle\langle ve_2,w\rangle.$$

**$\Omega_{\mathfrak k}(e_1,e_2,f_1,f_2)$.** $\mathfrak k$ preserves $A$ and $B$, so $\langle ve_2,f_1\rangle=0$ and $\langle vf_1,e_1\rangle=0$: $T_2=T_3=0$. For $T_1$, $\langle v_{ij}e_1,e_2\rangle=\tfrac1{\sqrt2}(\delta_{i1}\delta_{j2}-\delta_{j1}\delta_{i2})$, nonzero only at $(i,j)=(1,2)$ where it is $\tfrac1{\sqrt2}$, and likewise $\langle v_{12}f_1,f_2\rangle=\tfrac1{\sqrt2}$. Hence $\Omega_{\mathfrak k}=\tfrac1{\sqrt2}\cdot\tfrac1{\sqrt2}=\boxed{\tfrac12}$. **Confirmed.**

**$\Omega_{\mathfrak m}(e_1,e_2,f_1,f_2)$, the term the brief warns about.** $\mathfrak m$ exchanges $A$ and $B$, so $T_1=0$. From §1, an element of $\mathfrak m$ with symmetric traceless $Y$ satisfies
$$\langle ve_k,f_l\rangle=Y_{lk}=Y_{kl},\qquad \langle vf_l,e_k\rangle=-Y_{kl}.$$
Therefore, **for a single $v$**,
$$T_2=\langle ve_2,f_1\rangle\langle ve_1,f_2\rangle=Y_{12}\cdot Y_{12}=Y_{12}^2,\qquad T_3=\langle vf_1,e_1\rangle\langle ve_2,f_2\rangle=(-Y_{11})\cdot Y_{22}=-Y_{11}Y_{22}.$$
The minus sign in $T_3$ comes from $\langle vf_l,e_k\rangle=-Y_{kl}$ and from nowhere else; it is the only sign in the computation. Summing over an orthonormal basis of $\mathrm{Sym}_0(m)$ uses the reproducing kernel, the orthogonal projector of $M_m(\mathbb R)$ onto $\mathrm{Sym}_0(m)$,
$$\sum_\alpha(Y_\alpha)_{ij}(Y_\alpha)_{kl}=P_{ij,kl}=\tfrac12(\delta_{ik}\delta_{jl}+\delta_{il}\delta_{jk})-\tfrac1m\delta_{ij}\delta_{kl},$$
giving
$$\sum_\alpha T_2=P_{12,12}=\tfrac12(1\cdot1+0\cdot0)-\tfrac1m\cdot0\cdot0=\tfrac12,\qquad \sum_\alpha T_3=-P_{11,22}=-\Big(\tfrac12(0+0)-\tfrac1m\cdot1\cdot1\Big)=+\tfrac1m.$$
So $\Omega_{\mathfrak m}(e_1,e_2,f_1,f_2)=\boxed{\tfrac12+\tfrac1m}$, **with the $\tfrac1m$ entering positively**. **Confirmed**, and the proof's gloss ("the diagonal projector reads $\delta_{kl}-\tfrac1m$, and $-(\delta_{12}-\tfrac1m)=\tfrac1m$"), is exactly this computation. A concrete check at $m=2$ with the explicit basis $Y_1=\tfrac1{\sqrt2}\operatorname{diag}(1,-1)$, $Y_2=\tfrac1{\sqrt2}(E_{12}+E_{21})$: $\sum(Y_\alpha)_{12}^2=\tfrac12$ and $\sum(Y_\alpha)_{11}(Y_\alpha)_{22}=-\tfrac12=-\tfrac1m$. Agrees.

**Both at $(e_1,e_2,f_3,f_4)$, $m\ge4$.** For $\mathfrak k$: $T_2=T_3=0$ as before, and $T_1$ needs $\langle v_{ij}e_1,e_2\rangle\ne0$, forcing $(i,j)=(1,2)$, whereupon $\langle v_{12}f_3,f_4\rangle=0$. So $\Omega_{\mathfrak k}=0$. For $\mathfrak m$: $T_1=0$, and $\sum T_2=P_{32,41}=\tfrac12(\delta_{34}\delta_{21}+\delta_{31}\delta_{24})-\tfrac1m\delta_{32}\delta_{41}=0$, $\sum T_3=-P_{13,42}=-\big[\tfrac12(\delta_{14}\delta_{32}+\delta_{12}\delta_{34})-\tfrac1m\delta_{13}\delta_{42}\big]=0$. So $\Omega_{\mathfrak m}=0$. **Confirmed.**

**The $m=4$ separation of $\mathrm{Id}$ from $*$.** With $\omega_T$ as in §7 and the standard orientation on $\mathbb R^4$, $*(e_1\wedge e_2)=e_3\wedge e_4$, so

| | $\omega_{\mathrm{Id}}$ | $\omega_*$ |
| --- | --- | --- |
| at $(e_1,e_2,f_1,f_2)$ | $\langle e_1\wedge e_2,e_1\wedge e_2\rangle=1$ | $\langle e_3\wedge e_4,e_1\wedge e_2\rangle=0$ |
| at $(e_1,e_2,f_3,f_4)$ | $\langle e_1\wedge e_2,e_3\wedge e_4\rangle=0$ | $\langle e_3\wedge e_4,e_3\wedge e_4\rangle=1$ |

The two evaluations are therefore a basis of the dual of the two-dimensional invariant space. Both forms give $0$ at the second, hence have zero $*$-component, hence lie on $\mathbb R\,\omega_{\mathrm{Id}}$, and the first evaluation reads off the coefficient. **$m=4$ takes the same equation. Confirmed.**

Assembling: on the whole plane, $\Omega_{W_{a,b}}=a\Omega_{\mathfrak k}+b\Omega_{\mathfrak m}$ is $\tfrac{am+b(m+2)}{2m}\,\omega_{\mathrm{Id}}$, so first Bianchi is
$$\tfrac a2+b\big(\tfrac12+\tfrac1m\big)=0\iff am+b(m+2)=0.$$

## 9. The two conditions coincide

$$ap+bq=a\tfrac{m(m-1)}2+b\tfrac{(m-1)(m+2)}2=\tfrac{m-1}2\big[am+b(m+2)\big].$$
**The brief's algebra is confirmed exactly.** (The proof's display drops the $\tfrac12$; harmless, since only the vanishing locus is read.) For $m\ge2$ the factor $\tfrac{m-1}2$ is nonzero, so Ricci-flatness is $am+b(m+2)=0$. Bianchi is $\tfrac{am+b(m+2)}{2m}=0$, the same equation with a different nonzero prefactor. **No $m\ge2$ makes them differ**, and the shared solution set is the line $(a,b)\propto(m+2,-m)$, origin included. The two prefactors do differ ($\tfrac{m-1}2$ against $\tfrac1{2m}$) which is the only sense in which the conditions are not literally identical, and it is invisible to a vanishing statement.

$$\mathrm{Ric}(W_{a,b})=\tfrac{(m-1)[am+b(m+2)]}{2m}\,\mathrm{Id}_{2m},\qquad \Omega_{W_{a,b}}=\tfrac{am+b(m+2)}{2m}\,\omega_{\mathrm{Id}}.$$

## 10. The screen

To screen the closed forms above before recording them, I built $\Pi_{\mathfrak k}$ and $\Pi_{\mathfrak m}$ in exact rational arithmetic for $m=2,3,4,5,6$, carrying each $\tfrac1{\sqrt2}$ as the rational scale $\tfrac12$, since every expression is quadratic in a single basis element, and handling the traceless diagonal block through the projector $\delta_{kl}-\tfrac1m$ rather than a basis, and evaluated $\mathrm{Ric}$ and $\Omega$ on every $4$-subset of the standard basis. Result: $C_{\mathfrak k}$ and $C_{\mathfrak m}$ scalar with values $\tfrac pm$ and $\tfrac qm$ at every $m$ tested, $m=2$ included; $\Omega_{\mathfrak k}=\Omega_{\mathfrak m}=0$ on all tuples with $0,1,3$ or $4$ arguments in $A$; and on tuples with two in $A$ exactly two value pairs occur, $(0,0)$ and $\big(\tfrac12,\tfrac12+\tfrac1m\big)$, $(\tfrac12,1)$, $(\tfrac12,\tfrac56)$, $(\tfrac12,\tfrac34)$, $(\tfrac12,\tfrac7{10})$, $(\tfrac12,\tfrac23)$ at $m=2,\dots,6$.

**This is a screen and nothing more.** The evidence for every claim in this report is the derivation in §1–§9; the run is recorded because it was performed, and because a disagreement would have sent me back to the derivations.

## 11. The edges, and a correction to the brief's own premise

**$m=2$.** $\mathfrak{su}(2)=\mathfrak k\oplus\mathfrak m$ is three-dimensional inside $\mathfrak{so}(4)$, and with the orientation $e_1\wedge e_2\wedge f_1\wedge f_2$ it is the *self-dual* summand: computing the Hodge star on bivectors from that volume form gives $*(e_1\wedge e_2)=f_1\wedge f_2$, $*(e_1\wedge f_1)=-e_2\wedge f_2$, $*(e_1\wedge f_2)=e_2\wedge f_1$, and hence $*v=v$ for each of $\tfrac1{\sqrt2}(e_1\wedge e_2+f_1\wedge f_2)$, $\tfrac1{\sqrt2}(e_1\wedge f_2+e_2\wedge f_1)$, $\tfrac1{\sqrt2}(e_1\wedge f_1-e_2\wedge f_2)$. (Consistently, the Kähler form $J=e_1\wedge f_1+e_2\wedge f_2$ has $*J=-J$, so $\mathfrak u(2)=\Lambda^+\oplus\mathbb R J$.) So $W_{a,b}$ is supported in $S^2(\Lambda^+)$.

**The brief's expectation ("Bianchi should be automatic on a $\Lambda^\pm$ summand"), is false as stated, and it is the brief that is wrong, not the proof.** The decomposition is $\mathcal W_4=S^2_0(\Lambda^+)\oplus S^2_0(\Lambda^-)$ with the **traceless** parts; Bianchi is automatic on $S^2_0(\Lambda^\pm)$, not on $S^2(\Lambda^\pm)$. Concretely, $\Pi_{\Lambda^+}=\Pi_{\mathfrak k}+\Pi_{\mathfrak m}$ has
$$\Omega_{\Lambda^+}(e_1,e_2,f_1,f_2)=\tfrac12+\big(\tfrac12+\tfrac12\big)=\tfrac32\ne0,$$
so the identity on $\Lambda^+$ violates first Bianchi. Read the classical way this is the statement that the Bianchi obstruction of $R\in S^2(\Lambda^2\mathbb R^4)$ is proportional to $\operatorname{tr}R^{++}-\operatorname{tr}R^{--}$, which is $3-0=3$ here and $3-3=0$ for the constant-curvature tensor $\mathrm{Id}_{\Lambda^2}$, both consistent with §6 and §8.

**Does the general argument reproduce the $m=2$ structure?** Yes, and sharply. On $S^2(\Lambda^+)$ both conditions reduce to tracelessness: $\operatorname{tr}W_{a,b}=ap+bq=a+2b$, and the general Bianchi equation at $m=2$ is $2a+4b=0$, i.e. $a+2b=0$, the same. The line is $(a,b)\propto(4,-2)\propto(2,-1)$, giving $W=b(-2\Pi_{\mathfrak k}+\Pi_{\mathfrak m})$, a trace-free symmetric operator on $\Lambda^+$ extended by zero, an element of $S^2_0(\Lambda^+)\subset\mathcal W_4$, and nonzero for $b\ne0$. **The general equation and the four-dimensional classification agree exactly.**

**$m=3$.** $p=3$, $q=5$. Ricci: $3a+5b=0$. Bianchi: $\tfrac a2+b(\tfrac12+\tfrac13)=\tfrac a2+\tfrac{5b}6=0$, i.e. $3a+5b=0$. Same line, and it is the line $(a,b)\propto(5,-3)=(m+2,-m)$. **Consistent.**

**$m=4$.** $p=6$, $q=9$. Ricci: $6a+9b=3(2a+3b)=0$. Bianchi: $\tfrac a2+\tfrac{3b}4=0$, i.e. $2a+3b=0$. Same line $(a,b)\propto(6,-4)\propto(3,-2)$. **Consistent**, and §7–§8 show the extra invariant does not enter.

**$a=b=0$.** $W=0$, which is Ricci-flat, satisfies Bianchi, lies in $\mathcal W_{2m}$, and satisfies $am+b(m+2)=0$. The statement's "line" is a linear subspace through the origin and the trivial point is on the right side of every clause. **Consistent**, worth stating because "exactly on the line and nowhere else" would be false for an affine line.

## 12. What would break it, and what I did to look

A falsifier is a triple $(m,a,b)$ with $m\ge2$ and $(a,b)\ne(0,0)$ of one of two kinds:

- **Type I**, $am+b(m+2)\ne0$ but $W_{a,b}\in\mathcal W_{2m}$. This needs $\tfrac{m-1}{2m}[am+b(m+2)]=0$ and $\tfrac1{2m}[am+b(m+2)]=0$ simultaneously with the bracket nonzero, which is impossible for $m\ge2$.
- **Type II**, $am+b(m+2)=0$ but $W_{a,b}\notin\mathcal W_{2m}$. This needs one of the two closed forms of §9 to be wrong.

**What I did.** I derived both closed forms from the definitions for arbitrary $m\ge2$ and arbitrary $(a,b)$, rather than checking cases: the Ricci form from the direct Casimir computation of §3, which needs no representation theory and so has no small-$m$ exception; the Bianchi form from the $SO(m)$-decomposition of §7 plus the two evaluations of §8, with $m=4$'s extra invariant killed by the second evaluation and $m=2,3$'s absent summands checked in the table of §7. I then checked the two structurally distinct edges, $m=1$, where the statement genuinely fails and the hypothesis $m\ge2$ earns its place, and $m=2$, where the independent four-dimensional classification reproduces the same line. Finally I screened (§10) at $m=2,\dots,6$ over every basis $4$-tuple, in exact arithmetic, and found no disagreement. **No falsifier exists**, and the reason is that both conditions are *the same linear functional* $am+b(m+2)$ up to a nonzero factor, at every $m\ge2$.

## Verdict

**GAP**, two steps of the *written* proof do not establish what they claim, and both are closed inside this report:

1. **§3.** "$C_{\mathfrak k}$ is scalar because $\mathbb C^m|_{\mathfrak{so}(m)}$ is two copies of one real irreducible" fails at $m=2$: the module is irreducible over $\mathbb R$ but of complex type, so Schur permits a two-dimensional commutant. **Repair**: replace the appeal to Schur by the one-line computation $C_{\mathfrak k}=-\sum_{i<j}v_{ij}^2=\tfrac{m-1}2\mathrm{Id}_{2m}$, valid at every $m\ge2$ and needing no irreducibility.
2. **§6.** "every term of $\Omega$ carries a factor $\langle ve,e'\rangle$ or $\langle vf,f'\rangle$ … or a factor $\langle ve,f\rangle$" does not cover $\Omega_{\mathfrak k}$ on $\Lambda^4A$ or on $\Lambda^4B$, where no term carries an $AB$ factor. **Repair**: add that $\Omega_{\mathfrak k}$ restricted to $A$ equals $\tfrac12$ times the Bianchi sum of the constant-curvature tensor $\langle x,z\rangle\langle y,w\rangle-\langle x,w\rangle\langle y,z\rangle$, which telescopes to zero, and likewise on $B$.

**The statement under review is true exactly as written, for every $m\ge2$**, and I verified every other step, the identification of $\mathfrak k$ and $\mathfrak m$ with both normalisations, the spectral form of $\mathrm{Ric}$, the trace evaluation, the derivation and total antisymmetry of $\Omega$, the invariant count at every $m$, both evaluations including the sign of $\Omega_{\mathfrak m}$'s third term, the $\mathrm{Id}$-versus-$*$ separation at $m=4$, and the coincidence of the two conditions. With the two repairs above the proof is complete. A separate correction belongs to the brief rather than to the proof: **Bianchi is automatic on $S^2_0(\Lambda^\pm)$, not on $S^2(\Lambda^\pm)$**, and $\Pi_{\Lambda^+}$ is a concrete violator with $\Omega=\tfrac32$.
