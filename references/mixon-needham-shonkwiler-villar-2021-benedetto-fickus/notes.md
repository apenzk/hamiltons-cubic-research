# Notes, Three proofs of the Benedetto–Fickus theorem

*Transcribed from [2112.02916.txt](https://arxiv.org/abs/2112.02916). The frame potential of $Z=[z_1\cdots z_n]\in\mathbb C^{d\times n}$ with unit-norm columns is $\mathrm{FP}(Z)=\sum_{i,j}\lvert\langle z_i,z_j\rangle\rvert^2=\lVert ZZ^*\rVert_F^2$, and $\mathcal S(d,n)$ is the set of such $Z$.*

> **Theorem 1.** For each $d,n\in\mathbb N$, the second-order critical points of the frame potential $\mathrm{FP}\colon\mathcal S(d,n)\to\mathbb R$ are precisely the global minimizers of the frame potential, namely, the $d\times n$ matrices with orthonormal columns when $n\le d$, and the $d\times n$ unit norm tight frames when $n\ge d$.

*Page 4. A second-order critical point is one where the constraint gradients are independent and the Lagrangian Hessian is positive semidefinite on the tangent space.*

> **Corollary 1.** Fix $d,n\in\mathbb N$, and suppose $Z\in\mathcal S(d,n)$ is a first-order critical point of the frame potential that is not a global minimizer. Then there exist $d',n'\in\mathbb N$ satisfying $d'<d$, $n'/d'>\max\{n/d,1\}$ such that the maximum eigenvalue of $ZZ^*$ has a $d'$-dimensional eigenspace $E$ that contains exactly $n'$ columns of $Z$, which in turn form a unit norm tight frame for $E$.

*Page 6. The first-order condition is $ZZ^*z_j=-\tfrac12\lambda_jz_j$ with $\lambda_j$ the multipliers, so every column is an eigenvector of the frame operator.*

**The first proof's construction, page 9, verbatim in substance.** With $J$ the columns spanning the top eigenspace $E$ (eigenvalue $\alpha$) and $E'$ another eigenspace (eigenvalue $\beta<\alpha$): select $u\in E'$ with $\lVert u\rVert=1$; since $d'<n'$ the columns in $J$ are linearly dependent, select $v$ supported on $J$ with $Zv=0$ and $\lVert v\rVert=1$; take $Y:=uv^*$. Then the constraint tangency $\mathrm{Re}\mathop{\mathrm{tr}}(\nabla h_j(Z)^*Y)=0$ holds for every $j$ because $v_j=0$ off $J$ and $z_j^*u=0$ on $J$, the holomorphic Hessian terms vanish because $v$ and $Z^*u$ have disjoint support, and the mixed term is

$$\sum\frac{\partial^2\mathrm{FP}}{\partial Z\,\partial\bar Z}\,Y\bar Y=2\lVert Zv\rVert^2\lVert u\rVert^2+2\lVert Z^*u\rVert^2\lVert v\rVert^2=2\beta,\qquad \sum\lambda_j\lvert v_j\rvert^2=-2\alpha,$$

so the Lagrangian Hessian along $Y$ is $2(\beta-\alpha)<0$ and $Z$ is not a second-order critical point. $\square$

**The three ingredients, named for the transfer.** (1) Every column is an eigenvector of the frame operator, the first-order system in the eigenframe. (2) The direction couples TWO eigenspaces and lies in the constraint kernel, which is what makes the constraint terms vanish. (3) The sign of the second variation is the eigenvalue gap, so a non-degenerate spectrum is contradicted by its own top and bottom.

**Sections 3 and 4**, convexity through Schur–Horn on the diagonal-versus-spectrum majorisation, and geometric invariant theory through Kempf–Ness with the frame potential as a moment-map norm square, are recorded and not transferred, see the README.
