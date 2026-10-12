# Notes, Bengtsson et al. 2007, carrying Au-Yeung and Poon 1979

$\varphi_r:O(n)\to B_n$, $X\mapsto[x_{ij}^2]$, with $B_n$ Birkhoff's polytope; $\varphi_c$ and $\varphi_h$ the complex and quaternionic versions. An orthogonal matrix SPLITS if, up to permutations of rows and columns, it is a direct sum of two smaller orthogonal matrices.

> **Theorem 2.2.** If an orthogonal matrix splits, then it is a singular point of the map $\varphi_r$. Similar statements hold for the critical points of the maps $\varphi_c$ and $\varphi_h$.

> **Theorem 2.4.** Let $n=3$. The singular points of the map $\varphi_r$ are the matrices that split.

> **Theorem 2.5.** Let $n=3$. The set of critical points for the maps $\varphi_c$ and $\varphi_h$ is, up to equivalence, the set $O(3)$ of $3$ by $3$ real orthogonal matrices.

> **Theorem 2.6.** Let $n=4$. There are two types of singular points of the map $\varphi_r$. The first are the matrices that split. The second type are the matrices which are equivalent to a matrix having all diagonal entries zero and all other entries nonzero.

(pages 6 to 9.) **The $3\times3$ orthostochastic characterisation** (page 15): a bistochastic $3\times3$ matrix with entries $x,y,z,a,\dots$ is orthostochastic if and only if the vectors $(\sqrt x,\sqrt z,\sqrt a)$ and the row built from the next row's entries with appropriate signs $\varepsilon_i$ are orthogonal, which Au-Yeung and Poon write as the single equation $(1-x-y-z-w+xw+yz)^2=4xyzw$ in the four free entries.

**What matters for the record.** *A split $3\times3$ orthogonal matrix preserves a coordinate vector.* On the block problem that is the stratum where the two blocks share an eigenvector of the field frame, closed by [L229](../../findings/second-order.md). **So the record's open stratum is exactly where $\varphi_r$ is a local diffeomorphism, and there the value is a linear functional on the orthostochastic $3$-manifold rather than on its convex hull.** Theorem 2.5 explains why the real case is the one with structure: over $\mathbb C$ and $\mathbb H$ every real orthogonal matrix is critical.
