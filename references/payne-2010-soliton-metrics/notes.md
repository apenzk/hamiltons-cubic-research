# Notes, Payne, *The existence of soliton metrics for nilpotent Lie groups*

Transcribed from [payne-0809.5068.txt](https://arxiv.org/abs/0809.5068) (`pdftotext -layout`); line references are to that dump.

## The structure vector, the literature's $T$ (L235–L248, verbatim)

> Let $\alpha^k_{ij}$ denote the structure constant $\langle[X_i,X_j],X_k\rangle$. The set $\Lambda(n_\mu,B)=\{(i,j,k)\mid i<j,\ \alpha^k_{ij}\ne0\}$ indexes the set of nonzero structure constants, ignoring repetitions due to skew-symmetry. ... Let $[\alpha^2]_{(n_\mu,B)}$ denote the $m\times1$ vector with the entries $(\alpha^k_{ij})^2$ for $(i,j,k)\in\Lambda(n_\mu,B)$, again taken in dictionary order. We call $[\alpha^2]_{(n_\mu,B)}$ the **structure vector** for $(n_\mu,Q)$ with respect to $B$.

> A single nilmanifold may have different root vectors, structure vectors, and Gram matrices, depending on the choice of Ricci eigenvector basis. **Nonisometric nilmanifolds may have the same Gram matrices, structure vectors, and Dynkin diagrams.**

The root vector of a triple is $Y_{ijk}=\varepsilon_i^{\mathsf T}+\varepsilon_j^{\mathsf T}-\varepsilon_k^{\mathsf T}$; the root matrix $Y$ has these as rows; the Gram matrix is $U=YY^{\mathsf T}$, with entries in $\{-2,-1,0,1,2,3\}$ and $3$ on the diagonal only.

## What IS linear in the squares (L1035–L1050, Theorem 8 and Theorem 1)

> By Theorem 8, the Ricci vector equals $-\tfrac12Y^{\mathsf T}[\alpha^2]$, where $[\alpha^2]$ is the structure vector for $(n,Q)$ with respect to $B$.

> **Theorem 1.** Let $(n_\mu,Q)$ be a nonabelian metric algebra with Ricci eigenvector basis $B$. Let $U$ and $[\alpha^2]$ be the Gram matrix and the structure vector for $(n_\mu,Q)$ with respect to $B$. Then $(n_\mu,Q)$ satisfies the nilsoliton condition with nilsoliton constant $\beta$ if and only if $U[\alpha^2]=-2\beta[1]_{m\times1}$.

> Thus, to find all nilsoliton metrics, one needs to find all vectors $v$ with positive entries that are solutions to systems of the form $Uv=-2\beta[1]_{m\times1}$ ... **thus reducing the difficult tensorial problem of finding Einstein and soliton metrics to a problem of linear algebra.**

**This is the analogue of the record's (A)/(B)/(C).** The metric/geometric conditions (the ones built by contracting $c$ against $c$), are exactly linear in $T$, and the Gram matrix of the support plays the role of the record's row identities.

## What is NOT, the Jacobi condition (L798–L840, Theorem 13 and Corollary 14, verbatim)

> **Theorem 13.** Let $(n,Q)$ be an $n$-dimensional inner product space, and let $\mu$ be an element of $\Lambda^2n^*\otimes n$. Let $B=\{X_i\}_{i=1}^n$ be an orthonormal basis for $(n,Q)$ and suppose that $\mu$ is $B$-triangular. Then
> (1) If $i$, $j$ and $k$ are distinct, the product $\alpha^l_{ij}\alpha^m_{lk}\ne0$ if and only if $\langle Y^l_{ij},Y^m_{lk}\rangle=-1$.
> (2) The algebra $n_\mu$ defined by $\mu$ is a Lie algebra if and only if whenever there exists $m$ so that $\langle Y^l_{ij},Y^m_{lk}\rangle=-1$ for triples $(i,j,l)$ and $(l,k,m)$ or $(k,l,m)$ in $\Lambda(n_\mu,B)$, the equation
> $$\sum_{s<m}\alpha^s_{ij}\alpha^m_{sk}+\alpha^s_{jk}\alpha^m_{si}+\alpha^s_{ki}\alpha^m_{sj}=0 \tag{8}$$
> holds.

> One consequence of this theorem is that the generalized Dynkin diagram $S(U)$ for a nilsoliton metric Lie algebra can not have exactly one dashed edge with weight minus one, or an equation like Equation (8) would need to be satisfied, but would not be able to hold. Another consequence is that if there are no minus one edges, the Jacobi condition holds automatically:

> **Corollary 14.** ... If the Gram matrix $U$ for $(n_\mu,Q)$ has no entries of $-1$, then $(n_\mu,Q)$ is a Lie algebra.

> Equation (8) may have continuous families of solutions, or more than one finite solution (**because of sign choices in solving equations with squares**). **It is possible for different sign choices for the structure constants to give different nilpotent structures on an inner product space $n$, and hence nonisometric nilsolitons; i.e. there exists $\Lambda$ such that there are nonisometric $\mu$ in $\Omega_\Lambda$ with the same structure vector.** This occurs in dimension six (see $\mu_7$ and $\mu_8$ in [Wil03]).

## What this settles for T6

Three separate facts, each of them the answer to a part of the question:

1. **A support consequence exists.** Jacobi forbids a diagram carrying exactly one $-1$ edge in a Jacobi position, a condition on $\operatorname{supp}T$, which $T$ sees.
2. **Beyond the support there is no consequence at all in the favourable case.** Corollary 14: no $-1$ entries, Jacobi free. So Jacobi cannot in general impose anything on the values of $T$; whether it imposes anything is decided by the support first.
3. **Where it does impose something, $T$ cannot see it.** Equation (8) is a signed sum of products; the same $[\alpha^2]$ supports both a signing that satisfies it and (at $\mu_7,\mu_8$), two inequivalent algebras. **$T$ does not determine the algebra, so no function of $T$ can be equivalent to Jacobi.**

Formally, eliminating the signs from $\varepsilon_1x_1+\dots+\varepsilon_mx_m=0$ with $x_i\ge0$ the products of magnitudes gives $\prod_{\varepsilon\in\{\pm1\}^{m-1}}\big(\sum_i\varepsilon_ix_i\big)=0$, degree $2^{m-1}$ in the magnitudes, a **union** of hyperplane pieces rather than one equation. A linear functional of $T$ can be forced by Jacobi only if it vanishes on every one of those pieces.

---

## Added 2026-09-01 for T9, the solution set of the linear system, and the witness that Jacobi cuts it

**T6 asked what Jacobi forces on the squares. [T9](../../plan.md) asks the next question: how big is the gap between "the linear system in the squares has a nonnegative solution" and "an actual algebra realizes it".** Payne answers the first half completely and exhibits the gap explicitly.

### Theorem 2, when the linear system has a positive solution (L307–L340, verbatim)

> **Theorem 2.** Let $A$ be a $m\times m$ irreducible generalized Cartan matrix and let $U=cA+d[1]_{m\times m}$, where $c$ and $d$ are positive. Suppose $\beta<0$. Then there exists a unique real number $\mu$ such that solutions to
> $$U v=-2\beta[1]_{m\times1}\tag{3}$$
> are the same as solutions to $Av=\mu[1]_{m\times1}$. There are five mutually exclusive possibilities for the common solution space:
> (Fin) $A$ is of finite type, $\mu>0$, Equation (3) has a unique solution $v$, and $v>0$.
> (Aff) $A$ is of affine type, $\mu=0$, Equation (3) has a unique solution $v$, and $v>0$.
> (Ind1) $A$ is of indefinite type, $\mu<0$, Equation (3) has a positive solution $v_0$, the general solution to Equation (3) is $v_0+\ker A=v_0+\ker U=v_0+\ker Y^{\mathsf T}$, and the intersection of the solution space and the cone $\{v\in\mathbb R^m\mid v\ge0\}$ is a simplex of dimension $\ker A$ parallel to $[1]^\perp_{m\times1}$.
> (Ind2) $A$ is of indefinite type, $\mu<0$ and Equation (3) is consistent but has no solution $v$ with $v>0$.
> (Ind3) $A$ is of indefinite type, $\mu<0$, and Equation (3) is not consistent.
> Additionally, if $U$ is the Gram matrix for a metric algebra $(\mathfrak n_\mu,Q)$ with respect to a Ricci eigenvector basis $B$, then Case (Ind3) can not occur.

**The feasible set of the analogue of the record's LP is completely classified, by the Kac–Moody type of the associated generalized Cartan matrix.** In the singular case it is a *simplex of positive dimension*, the relaxation is genuinely under-determined at a fixed support.

### Theorem 3, the solution set is not the realizable set (L370–L383, verbatim)

> **Theorem 3.** ... Then the set of metric algebras $(\mathfrak n_\mu,Q)$ in $\Omega_\Lambda$ whose structure vector satisfies $U[\alpha^2]=-2\beta[1]$ is
> - finite of size $2^m$, if $U$ is nonsingular and there is a unique positive solution to $Uv=-2\beta[1]$,
> - a finite disjoint union of the interiors of $2^m$ simplices of dimension $\ker U$ if $U$ is singular and $Uv=-2\beta[1]$ has a solution $v>0$, or
> - empty if there are no solutions to $Uv=-2\beta[1]$ with $v>0$.

These are **metric algebras**, not Lie algebras: Jacobi has not been imposed. The realizable subset is cut out afterwards, by Theorem 13.

### The procedure, stated as four steps (L1206–L1212, verbatim)

> First, one can show that a generalized Dynkin diagram $S(U)$ is realized as the generalized Dynkin diagram for a nilsoliton metric Lie algebras by finding $S(U)$ as a minor graph of some $S(\Sigma_{(\mu_1,\dots,\mu_n)})$, finding a nilsoliton weighting on $S(U)$ by solving $Uv=[1]$, defining an algebra using structure constants from the weighting, and checking the Jacobi identity with Theorem 13.

### The witness, Jacobi cuts a one-parameter family to a point (L1246–L1253, verbatim)

> The generalized Dynkin diagram for $\Sigma_6$ is in Figure 2. It was shown in [McD] that $\Delta_6$ admits a **one-parameter family of nilsoliton weightings** with $\beta=-2$, and the **Jacobi condition** from the two dotted edges as described by Theorem 13 gives a constraint so that up to scaling, **there is a unique nilsoliton metric** $(\mathfrak n,Q)$ with $\Lambda(\mathfrak n,B)=\Sigma_6$ for a Ricci eigenvector basis $B$.

## What this adds for T9

**An explicit, published instance of exactly the situation T9 is asking about.** At a fixed support the linear system in the squares has a one-parameter family of nonnegative solutions; realizability (the Jacobi identity), selects a single point of that family. So in the closest analogue the linear-plus-positivity relaxation is *strictly larger* than the realizable set, and realizability is what does the cutting.

**Read against [Nikolayevsky Theorem 3](../nikolayevsky-2011-pre-einstein-derivation/notes.md), which says the relaxation is exact at a fixed support, the two are consistent and the distinction is the point:** Nikolayevsky asks whether *some* realizable point exists over the support (an existence question, and there the relaxation is exact), while Payne's $\Sigma_6$ shows the *set* of relaxation-feasible points is bigger than the realizable set. **T9 is the second kind of question** (it maximises a functional over the relaxation) so it is the $\Sigma_6$ phenomenon, not Nikolayevsky's equivalence, that governs it.
