# Notes, Fox 2022, Sectional nonassociativity of metrized algebras

**Read at section 8, lines 1195 to 1345 of the extraction, after the abstract and the theorem list.** *A metrised algebra is $(A,\circ,h)$ with $h$ an invariant nondegenerate bilinear form, $h(x\circ y,z)=h(x,y\circ z)$; Euclidean means $h$ positive definite.*

> **Definition 4.1.** For a metrized $k$-algebra $(A,\circ,h)$ of dimension at least $2$, the sectional nonassociativity of a nondegenerate plane spanned by $x,y$ is $K(x,y)=\dfrac{h(x\circ x,y\circ y)-h(x\circ y,x\circ y)}{h(x,x)h(y,y)-h(x,y)^2}$, defined by analogy with sectional curvature, the associator in place of the covariant derivative. *(line 479)*

> **Lemma 8.2.** Let $(A,\circ,h)$ be a Euclidean metrized commutative algebra of dimension $n\ge2$. If $0\ne e\in\mathrm{Idem}(A,\circ)$, then $4K(e,x)\le|e|^{-2}$ for all $x\in A$ such that $x\wedge e\ne0$, with equality if and only if $x-h(e,e)^{-1}h(e,x)e\in\ker(L_\circ(e)-\tfrac12\mathrm{Id}_A)$. *(line 1244)*

**Its proof is the display (8.5)**: for $h(e,x)=0$ and $x=\sum_{i=1}^{n-1}x_i$ over an $h$-orthogonal eigenbasis of $L_\circ(e)$ on $\langle e\rangle^\perp$ with eigenvalues $\lambda_i$, $$K(e,x)=\frac{h(e\circ x,x)-h(e\circ x,e\circ x)}{|e|^2|x|^2}=|e|^{-2}\sum_{i=1}^{n-1}\lambda_i(1-\lambda_i)\frac{|x_i|^2}{|x|^2},$$ a convex combination, whence (8.6) $|e|^{-2}\min_i\lambda_i(1-\lambda_i)\le K(e,x)\le|e|^{-2}\max_i\lambda_i(1-\lambda_i)$.

> **Lemma 8.3.** Let $(A,\circ,h)$ be a Euclidean metrized commutative algebra of dimension $n\ge2$ and $0\ne e\in\mathrm{Idem}(A,\circ)$. (1) If there is $b\in\mathbb R$ such that $K(U)\le b$ for all two-dimensional subspaces $U\subset A$ containing $e$, then $\mathrm{Spec}^\perp(e)\subset(-\infty,\tfrac{1-\sqrt B}2]\cup[\tfrac{1+\sqrt B}2,\infty)$, where $B=\max\{1-4b|e|^2,0\}$. (2) If there is $b$ such that $K(U)\ge b$ for all such $U$, then $b\le1/(4|e|^2)$ and $\mathrm{Spec}^\perp(e)\subset[\tfrac{1-\sqrt B}2,\tfrac{1+\sqrt B}2]$ for $B=1-4b|e|^2\ge0$. *(line 1268; $\mathrm{Spec}^\perp(e)$ is the spectrum of $L_\circ(e)$ on $\langle e\rangle^\perp$, display (8.4).)*

> **Theorem 8.1.** Let $(A,\circ,h)$ be a Euclidean metrized commutative algebra. (1) If it has negative sectional nonassociativity, then $\mathrm{Aut}(A,\circ,h)$ is finite. (2) If it has nonpositive sectional nonassociativity, either $\mathrm{Aut}(A,\circ,h)$ is finite or it contains a trivial subalgebra of dimension $1$ or $2$. *(line 1227; the proof is Suzuki's theorem on automorphism groups of multilinear forms.)*

**What this record takes from it.** *At a critical point of $P$ on the unit sphere, $e=W/\theta$ is idempotent with $|e|^2=1/\theta^2$, and $\tfrac12\in\mathrm{Spec}^\perp(e)$ on the orbit tangent. So Lemma 8.2's equality case reads $\theta^2=4\max_{x\perp e}K(e,x)$. Theorem 8.1(1) says, contrapositively, that since $\mathrm{Aut}\supseteq O(n)$ is infinite the Weyl algebra's sectional nonassociativity is not negative, which the $\tfrac12$-eigenvalue already shows.*

## Not transcribed

Sections 5 to 7, the two-parameter family $U_\epsilon$, symmetric composition algebras, and the Hermitian-matrix Jordan algebras with Theorem 6.3's Böttcher--Wenzel bound; Lemmas 8.4 to 8.7 on square-zero elements, exactness and the cone of squares, which need nonnegative sectional nonassociativity the Weyl algebra lacks.
