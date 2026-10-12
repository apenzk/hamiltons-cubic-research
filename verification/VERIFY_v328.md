# Verifier v328, whether $[A,u]$ in Lemma L101 is a well-defined element of $\mathcal W_n$ equal to $A\cdot u$ (step B4)

**The brief was cold ([ADJ_L101_B4.md](ADJ_L101_B4.md)). No numerical work was done and no scripts were written. Every value below is exact. The log is [agent_logs/verify-L101-v328.log](../agent_logs/verify-L101-v328.log).**

| # | Claim | Verdict |
|---|---|---|
| 1 | $[A,u]$ read literally, as the commutator of the $n\times n$ matrix $A$ with the operator $u$ on $\Lambda^2\mathbb R^n$, is defined | REFUTED AS STATED |
| 2 | Under $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n)$ the derivative $\rho_*(A)$ of $\rho$ is $\mathrm{ad}_A$, a skew operator on $\Lambda^2\mathbb R^n$ | CONFIRMED |
| 3 | $[\rho_*(A),u]$ is a symmetric operator on $\Lambda^2\mathbb R^n$ lying in $\mathcal W_n$, for every $u\in\mathcal W_n$ | CONFIRMED |
| 4 | $A\cdot u=[\rho_*(A),u]$, where $A\cdot u=\tfrac{d}{dt}\big|_{t=0}\exp(tA)\cdot u$ for the conjugation action $g\cdot u=\rho(g)\,u\,\rho(g)^{-1}$ | CONFIRMED |
| 5 | The same equality under the pullback (right) action $u\mapsto\rho(g)^{-1}u\,\rho(g)$ | REFUTED AS STATED (it holds with the opposite sign) |

**Summary: the step is VALID once $[A,u]$ is read as $[\rho_*(A),u]$, the reading the same block fixes by writing $[\rho(A),u]$ in its heading, its general identity and its derivation $X\mapsto[\rho(A),X]$.**

## 0. Conventions, fixed once

- $N=\binom n2=\tfrac{n(n-1)}2$. $\Lambda^2=\Lambda^2\mathbb R^n$ carries the inner product induced from $\mathbb R^n$, $\langle x\wedge y,z\wedge w\rangle=\langle x,z\rangle\langle y,w\rangle-\langle x,w\rangle\langle y,z\rangle$ (any positive rescaling changes nothing below).
- $\rho:SO(n)\to GL(\Lambda^2)$ is $\rho(g)(x\wedge y)=gx\wedge gy$, and $\rho_*=d\rho_e:\mathfrak{so}(n)\to\mathfrak{gl}(\Lambda^2)$ its derivative. The passage writes $\rho(A)$ for $\rho_*(A)$.
- $\mathcal W_n\subset\mathrm{Sym}(\Lambda^2)$ is the space of algebraic Weyl tensors. For a symmetric operator $u$ write $R_u(x,y,z,w)=\langle u(x\wedge y),z\wedge w\rangle$. Then $u\in\mathcal W_n$ means $R_u$ satisfies the first Bianchi identity $\sum_{\mathrm{cyc}(x,y,z)}R_u(x,y,z,w)=0$ and has zero Ricci contraction $\sum_iR_u(e_i,x,y,e_i)=0$. The pair symmetries $R_u(x,y,z,w)=-R_u(y,x,z,w)=R_u(z,w,x,y)$ hold for every symmetric $u$.
- The action named in the brief is conjugation through $\rho$, $g\cdot u=\rho(g)\,u\,\rho(g)^{-1}$, and $A\cdot u=\tfrac{d}{dt}\big|_{t=0}\exp(tA)\cdot u$.
- The identification $\Lambda^2\cong\mathfrak{so}(n)$ is $x\wedge y\mapsto xy^{\mathsf T}-yx^{\mathsf T}$.

## Hypothesis inventory

- **H1 (the reading of the bracket).** $[A,u]$ abbreviates $[\rho_*(A),u]=\rho_*(A)\,u-u\,\rho_*(A)$. This is unwritten at the two occurrences the step cites and written at the three other occurrences in the same block.
- **H2 (the side of the action).** $SO(n)$ acts on the left, $g\cdot u=\rho(g)\,u\,\rho(g)^{-1}$, and $A\cdot u$ is the derivative of $t\mapsto\exp(tA)\cdot u$ at $t=0$. Under the pullback convention the equality of claim 4 holds with a minus sign (claim 5).
- **H3 (invariance of the inner product on $\Lambda^2$).** $\rho(g)$ is orthogonal for the inner product on $\Lambda^2$ that defines "symmetric operator" and the Frobenius product. The induced inner product of §0 has this property, and so does every positive multiple of it.
- **No hypothesis on $u$ or $n$.** The step uses nothing about $u=W_{\mathbb{CP}^2}$, its norm, criticality, or $n\ge9$. For $n\le3$ it is vacuous since $\mathcal W_n=0$.

## 1. The literal bracket is undefined

The line is "Setting $y=x$, $z=u$ and using $A\!\cdot\!u=[A,u]$". Here $A\in\mathfrak{so}(n)$ is an $n\times n$ skew matrix and $u$ is an $N\times N$ symmetric matrix. The products $Au$ and $uA$ exist only if $n=N$, that is $n(n-3)=0$. For $n\ge4$ one has $N-n=\tfrac{n(n-3)}2>0$, and for $n\le3$ the space $\mathcal W_n$ is zero. So in every dimension where the lemma has content the literal commutator is ill-typed, and claim 1 is REFUTED AS STATED.

Arguing the opposite: $A$ may be regarded as an element of $\Lambda^2$ through §0's identification, but then $A$ is a vector in the space $u$ acts on, and the natural expressions $u(A)\in\Lambda^2$ and $A\otimes A$ are not elements of $\mathcal W_n$. The only bilinear construction from $(A,u)$ into $\mathrm{Sym}(\Lambda^2)$ that is the infinitesimal conjugation is $[\rho_*(A),u]$. The block itself names it, in the heading "$T(x,y,[\rho(A),u])$", in the general identity, and in "the derivation $X\mapsto[\rho(A),X]$". So H1 is the reading the text supports, and the defect is notational.

## 2. $\rho_*(A)=\mathrm{ad}_A$, and it is skew

Under §0's identification, $\rho(g)(x\wedge y)=gx\wedge gy\mapsto g(xy^{\mathsf T}-yx^{\mathsf T})g^{\mathsf T}=gBg^{-1}$ with $B=xy^{\mathsf T}-yx^{\mathsf T}$, using $g^{\mathsf T}=g^{-1}$. By linearity $\rho(g)=\mathrm{Ad}_g$ on all of $\mathfrak{so}(n)$. Differentiating $\exp(tA)B\exp(-tA)$ at $t=0$ gives $\rho_*(A)B=AB-BA=\mathrm{ad}_A(B)$.

Skewness follows from H3: differentiating $\langle\rho(e^{tA})\xi,\rho(e^{tA})\eta\rangle=\langle\xi,\eta\rangle$ at $t=0$ gives $\langle\rho_*(A)\xi,\eta\rangle+\langle\xi,\rho_*(A)\eta\rangle=0$. The same holds directly on simple bivectors: $\rho_*(A)(x\wedge y)=Ax\wedge y+x\wedge Ay$, and $\tfrac{d}{dt}$ of the Gram determinant of §0 is zero because $\langle Ax,z\rangle=-\langle x,Az\rangle$. Claim 2 is CONFIRMED.

## 3. $[\rho_*(A),u]$ is symmetric

Write $S=\rho_*(A)$, so $S^{\mathsf T}=-S$ by §2 and $u^{\mathsf T}=u$. Then $[S,u]^{\mathsf T}=(Su-uS)^{\mathsf T}=u^{\mathsf T}S^{\mathsf T}-S^{\mathsf T}u^{\mathsf T}=-uS+Su=[S,u]$. So $[S,u]\in\mathrm{Sym}(\Lambda^2)$.

## 4. $[\rho_*(A),u]$ lies in $\mathcal W_n$, first proof by the orbit curve

- **$\mathcal W_n$ is $SO(n)$-invariant.** For $g\in SO(n)$, H3 gives $\rho(g)^{-1}=\rho(g)^{\mathsf T}$, so $g\cdot u$ is symmetric and $R_{g\cdot u}(x,y,z,w)=\langle u\,\rho(g)^{\mathsf T}(x\wedge y),\rho(g)^{\mathsf T}(z\wedge w)\rangle=R_u(g^{-1}x,g^{-1}y,g^{-1}z,g^{-1}w)$. Substituting $g^{-1}x,g^{-1}y,g^{-1}z,g^{-1}w$ into the cyclic Bianchi sum of $R_u$ gives zero. The Ricci contraction of $R_{g\cdot u}$ is $\sum_iR_u(g^{-1}e_i,g^{-1}x,g^{-1}y,g^{-1}e_i)$, and $\{g^{-1}e_i\}$ is again orthonormal, so it equals $\mathrm{Ric}_u(g^{-1}x,g^{-1}y)=0$ (the contraction is independent of the orthonormal basis).
- **The curve.** $c(t)=\exp(tA)\cdot u=\rho(e^{tA})\,u\,\rho(e^{tA})^{-1}$ is smooth and lies in $\mathcal W_n$ for all $t$. Since $\rho$ is a Lie group homomorphism, $\rho(e^{tA})=e^{t\rho_*(A)}$. Hence $c(t)=e^{tS}ue^{-tS}$ and the product rule gives $c'(0)=Su-uS=[S,u]$.
- **Membership.** $\mathcal W_n$ is a linear subspace of the finite-dimensional space $\mathrm{Sym}(\Lambda^2)$, hence closed, so $c'(0)=\lim_{t\to0}\tfrac{c(t)-u}{t}$ lies in $\mathcal W_n$.

This proves $[\rho_*(A),u]\in\mathcal W_n$ (claim 3) and $A\cdot u=[\rho_*(A),u]$ under H2 (claim 4).

## 5. Second proof, directly on the four-tensor

From §2, $\rho_*(A)(x\wedge y)=Ax\wedge y+x\wedge Ay$ and $S^{\mathsf T}=-S$. So

$$R_{[S,u]}(x,y,z,w)=\langle Su(x\wedge y),z\wedge w\rangle-\langle uS(x\wedge y),z\wedge w\rangle=-R_u(x,y,Az,w)-R_u(x,y,z,Aw)-R_u(Ax,y,z,w)-R_u(x,Ay,z,w).$$

Call this $D(x,y,z,w)$.

- **Bianchi.** Let $b(x,y,z)=\sum_{\mathrm{cyc}(x,y,z)}R_u(x,y,z,w)$, which is zero for all arguments. The cyclic sum over $(x,y,z)$ of the three terms of $-D$ that move $x$, $y$ or $z$ has nine summands, and they are exactly the nine summands of $b(Ax,y,z)+b(x,Ay,z)+b(x,y,Az)$, which is zero. The cyclic sum of the remaining term $R_u(x,y,z,Aw)$ is $b(x,y,z)$ with $w$ replaced by $Aw$, which is zero.
- **Ricci.** $\sum_iD(e_i,x,y,e_i)=-\sum_iR_u(Ae_i,x,y,e_i)-\sum_iR_u(e_i,x,y,Ae_i)-\mathrm{Ric}_u(Ax,y)-\mathrm{Ric}_u(x,Ay)$. The last two vanish. Expanding $Ae_i=\sum_jA_{ji}e_j$, the first sum is $\sum_{i,j}A_{ji}R_u(e_j,x,y,e_i)$ and the second is $\sum_{i,j}A_{ji}R_u(e_i,x,y,e_j)$. Swapping the names $i,j$ in the second turns it into $\sum_{i,j}A_{ij}R_u(e_j,x,y,e_i)=-\sum_{i,j}A_{ji}R_u(e_j,x,y,e_i)$, so the two cancel.

So $R_{[S,u]}$ is an algebraic Weyl tensor, confirming claim 3 without the Lie correspondence. The formula for $D$ is the derivative at $t=0$ of $R_u(e^{-tA}x,e^{-tA}y,e^{-tA}z,e^{-tA}w)$, which is §4's $R_{c(t)}$, confirming claim 4 a second time.

## 6. The side of the action

If the brief's "acts by conjugation" were read as the pullback $g\ast u=\rho(g)^{-1}u\,\rho(g)$, which on four-tensors is $R_u(gx,gy,gz,gw)$, the curve $e^{-tS}ue^{tS}$ has derivative $-[S,u]$. Membership in $\mathcal W_n$ is unchanged, and the stated equality holds with a minus sign, so claim 5 is REFUTED AS STATED. The brief's definition "acts on $\mathcal W_n$ by conjugation through its action $\rho$" reads naturally as the left action of H2. Downstream in the lemma, the invariance identity $T(A\cdot x,y,z)+T(x,A\cdot y,z)+T(x,y,A\cdot z)=0$ holds for either convention used consistently in all three slots, and its consequence $T(x,x,[A,u])=0$ is insensitive to the sign. That consequence lies outside this step and is recorded only to show the convention choice carries no hidden weight.

## 7. Verdict for the step

**VALID.** Under H1 ($[A,u]$ means $[\rho_*(A),u]$), H2 (left conjugation action, $A\cdot u$ its derivative along $\exp(tA)$) and H3 (the inner product on $\Lambda^2$ is $\rho$-invariant, true for the standard one), $[A,u]$ is a symmetric operator on $\Lambda^2\mathbb R^n$ lying in $\mathcal W_n$ for every $u\in\mathcal W_n$ and every $n$, and it equals $A\cdot u$ (§§3–5). The only defect is notational: the two occurrences $A\!\cdot\!u=[A,u]$ and $T(x,x,[A,u])$ drop the $\rho$ that the rest of the block writes, and read literally they are ill-typed because $N=\tfrac{n(n-1)}2\ne n$ for $n\ge4$ (§1). Writing $[\rho(A),u]$ at both places, with $\rho(A)$ meaning $d\rho(A)$, repairs it.
