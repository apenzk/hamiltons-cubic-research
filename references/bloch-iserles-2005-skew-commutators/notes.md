# Notes: Bloch and Iserles, Commutators of skew-symmetric matrices

**Normalisation (introduction, p. 3).** The radius of a Lie algebra $\mathfrak g$ under a norm is the least $\omega$ with $\lVert[X,Y]\rVert\le\omega\lVert X\rVert\lVert Y\rVert$ for all $X,Y\in\mathfrak g$. In the Frobenius norm $\omega_F(\mathfrak{so}(3))=1/\sqrt2$; the authors scale the Frobenius norm by $\sqrt2$, under which $\omega_F(\mathfrak{so}(3))=1$, "and strikingly this result does not hold for $n$ larger than 3". Scaling the norm by $c$ divides the radius by $c$, so the plain-Frobenius radius is the scaled one divided by $\sqrt2$.

> **Theorem 6.** For every $n\ge4$ it is true that $\omega(\mathfrak{so}(n))=\sqrt2$ (in the scaled Frobenius norm).

**Proof (p. 11–12), at the level of which estimate binds.** Represent $\mathrm{ad}_X$ on $\mathbb R^{\frac12n(n-1)}$ as the skew matrix $C_X$; with $X$ block-diagonalised with rotation parameters $\alpha_1,\dots,\alpha_N$, $|\alpha_1|\ge|\alpha_2|\ge\cdots$, the spectral radius is $\rho(C_X)=|\alpha_1|+|\alpha_2|$ (for $n=2N$ and $n=2N+1$ alike), while $\lVert X\rVert_F^2$ is the sum of the $|\lambda|^2$ over the spectrum. So $\lVert C_X\rVert_2/\lVert\nu(X)\rVert_2\le(|\alpha_1|+|\alpha_2|)/\sqrt{|\alpha_1|^2+|\alpha_2|^2}\le\sqrt2$ by Young's inequality, **with equality at $\alpha_1=\alpha_2>0$ and $\alpha_k=0$ for $k\ge3$, an embedding of $\mathfrak{so}(4)$**.

**In plain Frobenius terms**, the form used in the I121 note: $\lVert[X,Y]\rVert_F\le\lVert X\rVert_F\lVert Y\rVert_F$ for real skew-symmetric $X,Y$ at $n\ge4$, sharp, and $\le\tfrac1{\sqrt2}\lVert X\rVert_F\lVert Y\rVert_F$ at $n=3$.

**Cites**: Böttcher–Wenzel for the general-matrix constant $\sqrt2$ is the neighbouring result (not in this paper).
