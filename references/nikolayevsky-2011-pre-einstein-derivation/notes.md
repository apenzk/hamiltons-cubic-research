# Notes, Nikolayevsky, *Einstein solvmanifolds and the pre-Einstein derivation*

Transcribed from [nikolayevsky-0802.2137.txt](https://arxiv.org/abs/0802.2137) (`pdftotext -layout`); line references are to that dump.

## The spectral obstruction (L89–L96, verbatim)

> **Theorem 1.**
> 1. (a) Any Lie algebra $\mathfrak g$ admits a pre-Einstein derivation $\varphi_{\mathfrak g}$.
>    (b) The derivation $\varphi_{\mathfrak g}$ is determined uniquely up to automorphism of $\mathfrak g$.
>    (c) All the eigenvalues of $\varphi_{\mathfrak g}$ are rational numbers.
> 2. Let $\mathfrak n$ be a nilpotent Lie algebra, with $\varphi$ a pre-Einstein derivation. If $\mathfrak n$ is an Einstein nilradical, then its Einstein derivation is positively proportional to $\varphi$ and
> $$\varphi>0\quad\text{and}\quad \mathrm{ad}\,\varphi\ge0. \tag{2}$$

> The inequalities (2) are necessary, but not sufficient to guarantee that a nilpotent Lie algebra is an Einstein nilradical.

**This is a realizability statement about a spectrum.** The derivation whose eigenvalues are constrained is the one the geometry produces, and the constraint has two parts of different characters: an inequality part ($\varphi>0$, $\mathrm{ad}\,\varphi\ge0$) that a convex test can carry, and an **arithmetic** part (rationality) that no convex test can. The remark is equally load-bearing: the inequalities alone do not decide the question.

## The exact criterion is GIT (L114–L120, verbatim)

> **Theorem 2.** For a nilpotent Lie algebra $\mathfrak n=(\mathbb R^n,\mu)$ with a pre-Einstein derivation $\varphi$, the following conditions are equivalent:
> (i) $\mathfrak n$ is an Einstein nilradical;
> (ii) the orbit $G_\varphi.\mu\subset V$ is closed;
> (iii) the function $f:G_\varphi\to\mathbb R^n$ defined by $f(g)=\lVert g.\mu\rVert^2$ has a critical point.

With $V=(\wedge^2\mathbb R^n)\otimes\mathbb R^n$, $\mathfrak g_\varphi=z(\varphi)\cap\ker(t)$, $t(A)=\mathrm{Tr}(A\varphi)$, and $G_\varphi\subset SL(n)$ the connected group with that Lie algebra.

## The nice basis and the linear system (L136–L160, verbatim)

> **Definition 3.** Let $\{X_1,\dots,X_n\}$ be a basis for a nilpotent Lie algebra $\mathfrak n$, with $[X_i,X_j]=\sum_k c^k_{ij}X_k$. The basis $\{X_i\}$ is called **nice**, if for every $i,j$, $\#\{k:c^k_{ij}\ne0\}\le1$, and for every $i,k$, $\#\{j:c^k_{ij}\ne0\}\le1$.

> Given a nilpotent algebra $\mathfrak n$ of dimension $n$ with a nice basis, introduce the following objects. In a Euclidean space $\mathbb R^n$ with the inner product $(\cdot,\cdot)$ and an orthonormal basis $f_1,\dots,f_n$, define the finite subset $F=\{(Y)^k_{ij}=f_i+f_j-f_k:c^k_{ij}\ne0,\ i<j\}$. Denote $L$ the affine span of $F$ ... Let $m=\#F$ ... define an $m\times n$ matrix $Y$ with the rows $(Y)^k_{ij}$.

> **Theorem 3.** A nonabelian nilpotent Lie algebra $\mathfrak n$ with a nice basis is an Einstein nilradical if and only if any of the following two equivalent conditions hold:
> (i) the projection of the origin of $\mathbb R^n$ to $L$ lies in the interior of the convex hull of $F$.
> (ii) there exists a vector $\alpha\in\mathbb R^m$ with all the coordinates positive satisfying $YY^t\alpha=[1]_m$.

> Note that by [Pay, Theorem 1], a metric nilpotent Lie algebra is nilsoliton if and only if the equation $YY^t\alpha=-2c\,[1]_m$ holds with respect to the basis of Ricci eigenvectors (where the components of $\alpha$ are the squares of the structural constants).

## What this settles for T9

**Positively, and this is the finding.** At a **fixed support**, "the linear system in the squares has a strictly positive solution" is not a relaxation of the geometric condition, it *is* the geometric condition, an if-and-only-if. The record's screen at seven fixed spectra found zero overshoot; the analogue literature says that at fixed support exactness is a theorem, so the screen's outcome is the expected one and carries no information about the maximum over spectra.

**The mechanism, and where it stops transferring.** Nikolayevsky's equivalence works because the diagonal group moves the magnitudes freely inside a fixed support while preserving the Jacobi identity, the bracket varies, the metric is fixed, and any positive $\alpha$ on an admissible support is realized by an actual Lie algebra with the original signs. This record's situation is the mirror image: **the bracket is fixed** ($\mathfrak{so}(n)$) and only the orthonormal frame moves, so $T_{abc}=\langle[v_a,v_b],v_c\rangle^2$ is rigid within its support. There is no group acting on $T$ at fixed spectrum. So the record's relaxation discards strictly more than Nikolayevsky's does, and its exactness at a fixed spectrum has a weaker mechanism behind it than the theorem above.

**Negatively.** Nothing here bounds the analogue of $\theta$, and nothing here characterizes which supports occur. Theorem 3 takes the algebra (hence the support) as given.
