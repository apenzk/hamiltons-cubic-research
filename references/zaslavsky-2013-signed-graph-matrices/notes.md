# Zaslavsky, *Matrices in the Theory of Signed Simple Graphs*, the rank of the unoriented incidence matrix

Read 2026-09-08 from [zas-1303.3083.txt](https://arxiv.org/abs/1303.3083). Only the parts bearing on L177's rank identity are transcribed; the paper's line-graph and Kirchhoff material is out of scope here.

## The general theorem

A signed graph $\Sigma=(\Gamma,\sigma)$ carries a sign $\sigma(e)\in\{+,-\}$ on each edge; the sign of a walk is the product of its edge signs; $\Sigma$ is **balanced** when every circle in it is positive, and $b(\Sigma)$ counts the balanced connected components ($c(\Sigma)$ counts all of them). Its incidence matrix $H(\Sigma)$ has column $e=vw$ with entries $\eta(v,e),\eta(w,e)\in\{\pm1\}$ and $\eta(v,e)\eta(w,e)=-\sigma(e)$.

> **Theorem IV.1** (Jeurissen; Zaslavsky). If $k$ has characteristic 2, then $H(\Sigma)$ has rank $n-c(\Sigma)$. Otherwise, $H(\Sigma)$ has rank $n-b(\Sigma)$.

The proof is exactly the one L177 gives, in the signed generality. It **blocks over connected components first**, $H(\Sigma)$ is block diagonal in the components, so it suffices to prove the formula for a connected signed graph. Then: switch a spanning tree $T$ all-positive; if $\Sigma$ is balanced it becomes all-positive and $H$ is the oriented incidence matrix of $\lvert\Sigma\rvert$, of rank $n-1$ (rows sum to $0$, and $H(T)$ with one row dropped has determinant $\pm1$). If $\Sigma$ is unbalanced, take a negative edge $e$; in $\begin{bmatrix}H(T)&H(e)\end{bmatrix}$ the last column has two $+1$'s or two $-1$'s, so the row sum has $\pm2$ in that position, the only dependence among the rows of $H(T)$ is that they sum to zero, so **provided $2\ne0$ in $k$** the rows are independent and the rank is $n$.

## The specialisation the record needs

> **Example IV.F.2.** The unoriented incidence matrix of $\Gamma$ is a $(0,1)$-matrix which has 1 in position $(v,e)$ if $v$ is an endpoint of $e$ and has 0 otherwise. […] It is an incidence matrix of the all-negative signed graph, $-\Gamma$. Since an all-negative graph is balanced if and only if it is bipartite (Corollary I.3), the rank of the matrix (except in characteristic 2) equals $n-b$ where $b$ is the number of bipartite components of $\Gamma$. This result was previously obtained by ad hoc methods (originally by van Nuffelen [22]), but it is really a special case of the general rank theorem for signed graphs.

Corollary I.3 is $-\Gamma$ balanced $\iff\Gamma$ bipartite, which is Harary's Balance Theorem (Theorem I.2) read with every edge negative: the Harary bipartition $\{X,Y\}$, with $X$ or $Y$ allowed to be empty, is the 2-colouring.

Original source of the unsigned statement: **C. van Nuffelen, *On the rank of the incidence matrix of a graph*, Colloque sur la Théorie des Graphes (Bruxelles, 1973), Cahiers Centre Études Rech. Opér. 15 (1973), 363–365.**

## The three side conditions this pins down

1. **Characteristic.** The identity is a real-field (more generally $\mathop{\mathrm{char}}k\ne2$) statement; over $\mathbb F_2$ the rank is $n-c$, so every component counts and biparticity is invisible. L177 works over $\mathbb R$, so the identity applies, but the hypothesis is used and unstated.
2. **Looplessness.** Footnote 3: "Usually, negative loops would be allowed; but that is not so suitable to the matrix theory." The theorem is stated for loopless signed graphs. L177's graphs are supports of a hollow $K$, indexed by unordered pairs $\{a,b\}$ with $a\ne b$, so they are loopless.
3. **Edgeless components count.** $b$ counts balanced components, and a one-vertex edgeless component is balanced vacuously, so it contributes $1$ to both $n_i$ and $b_i$ and $0$ to the rank. Isolated vertices are therefore harmless in $\lvert V\rvert-b$, the identity is insensitive to whether the support graph is taken on $[n]$ or only on the vertices meeting an edge.

## What the paper does not say

Nothing about which edges can be given a nonzero value by a kernel vector. The rank identity controls $\dim\ker N=\lvert E\rvert-\lvert V\rvert+b$ and nothing finer; the question of a **full-support** kernel vector, which is where L177's claim (2) lives, is not addressed here.
