# Derdziński 1983, read for $\mathbb{CP}^2$'s self-dual spectrum

**Read 2026-09-08 during the Gate 2 audit of [Lemma L176](../../findings/diagonal-half.md), to put Corollary 2's premises ($W^-=0$ and $W^+\propto(2,-1,-1)$ for $\mathbb{CP}^2$), on a source instead of on memory.** Everything below is transcribed from the fetched scan or derived in closed form from [Bourguignon–Karcher §5.1](../bourguignon-karcher-1978-pinching/notes.md); no numerical work was done and every value is exact.

## What the paper states

**§1, the splitting.** "For an oriented Riemannian four-manifold $(M,g)$, the bundle of 2-forms over $M$ splits as the Whitney sum $\Lambda^2M=\Lambda^+ + \Lambda^-$, $\Lambda^\pm$ being the eigenspace bundles of the Hodge star operator. The Weyl conformal tensor $W$ leaves $\Lambda^\pm$ invariant, and the restriction $W^\pm$ of $W$ to $\Lambda^\pm$ may be viewed as a $(0,4)$ tensor, operating trivially on $\Lambda^\mp$. The oriented Riemannian four-manifold $(M,g)$ is said to be **self-dual** (resp., **anti-self-dual**) if $W^-=0$ (resp., $W^+=0$)." (p. 405.)

**Proposition 2 (p. 415), the Kähler spectrum.** "Let $(M,g,\omega)$ be a Kähler manifold of real dimension four, oriented in the natural way. Considering $W^+$ as an endomorphism of $\Lambda^2M$, trivial on $\Lambda^-M$, we have [the displayed formula in $u$ and the parallel tensor of (36)] … Moreover, (i) $\#\operatorname{spec}_{\Lambda^+}(W^+)\le2$, i.e. the endomorphism $W^+$ of $\Lambda^+$ has, at each point, less than three distinct eigenvalues; (ii) $u^2=24\lvert W^+\rvert^2$; (iii) $u\,\delta W^+ + W^+(\nabla u,\cdot,\cdot,\cdot)=0$." Its proof opens: "Since $W(\omega)=u\omega/6$ by (11) …", $u$ being the scalar curvature.

**What that pins down.** $W^+$ is trace-free on the three-dimensional $\Lambda^+$; the Kähler form is an eigenvector with eigenvalue $u/6$; at most two distinct eigenvalues occur. Hence the spectrum is $(u/6,-u/12,-u/12)$, which is $\tfrac{u}{12}\cdot(2,-1,-1)$, the proportionality Corollary 2 asserts, with every entry nonzero exactly when $u\ne0$. The paper's own clause (ii) is the check: $(u/6)^2+2(u/12)^2=u^2/36+u^2/72=u^2/24$.

**Corollary 4 (p. 424), self-duality of the symmetric case.** "Let $(M,g)$ be an orientable, locally irreducible, locally symmetric Riemannian manifold of dimension four. Then $(M,g)$ is self-dual for some orientation." Example 1(iii) on p. 424 lists those manifolds among the known compact self-dual ones. $\mathbb{CP}^2$ with the Fubini–Study metric is locally irreducible and locally symmetric, so it is covered.

## $\mathbb{CP}^2$ itself, computed in closed form from Bourguignon–Karcher §5.1

**The paper above treats the Kähler class and never works $\mathbb{CP}^2$ as a numbered example, so the numbers are taken from a second source on file.** Bourguignon–Karcher §5.1 gives the curvature tensor of $\mathbb{CP}^n$ outright, in the normalisation where the sectional curvature runs over $[1,4]$:

$$R(a,b,c,d)=\langle a,c\rangle\langle b,d\rangle-\langle a,d\rangle\langle b,c\rangle+\langle Ja,c\rangle\langle Jb,d\rangle-\langle Ja,d\rangle\langle Jb,c\rangle+2\langle Ja,b\rangle\langle Jc,d\rangle.$$

Take $n=2$ and the orthonormal frame $e_1,\ e_2=Je_1,\ e_3,\ e_4=Je_3$, so that $\Omega_{ab}:=\langle Je_a,e_b\rangle$ has $\Omega_{12}=\Omega_{34}=1$ and every other entry above the diagonal zero.

**Sectional curvatures.** $R(a,b,a,b)=1+3\langle Ja,b\rangle^2$ for orthonormal $a,b$, giving $4$ on holomorphic planes and $1$ on totally real ones, which is the stated range.

**Ricci and scalar.** $\operatorname{Ric}_{11}=R_{1212}+R_{1313}+R_{1414}=4+1+1=6$, so $\operatorname{Ric}=6g$ and $u=24$.

**Weyl.** In dimension four an Einstein tensor of scalar curvature $u$ has $W=R-\kappa\,(g_{ac}g_{bd}-g_{ad}g_{bc})$ with $\kappa=u/12=2$, so

$$W(a,b,c,d)=-\left(g_{ac}g_{bd}-g_{ad}g_{bc}\right)+\left(\Omega_{ac}\Omega_{bd}-\Omega_{ad}\Omega_{bc}\right)+2\,\Omega_{ab}\Omega_{cd}.$$

Its components in this frame: $W_{1212}=W_{3434}=2$; $W_{1313}=W_{1414}=W_{2323}=W_{2424}=-1$; $W_{1234}=2$; $W_{1324}=1$; $W_{1423}=-1$; all others zero. The first Bianchi identity holds, $W_{1234}+W_{1342}+W_{1423}=2-1-1=0$, and the traces vanish, $W_{1212}+W_{1313}+W_{1414}=2-1-1=0$.

**The $\Lambda^2$ operator**, with $W(e_a\wedge e_b)=\sum_{c<d}W_{abcd}\,e_c\wedge e_d$, is block diagonal in the three pair-planes:

| plane | matrix | eigenvalues |
| --- | --- | --- |
| $\langle e_1\wedge e_2,\ e_3\wedge e_4\rangle$ | $\begin{pmatrix}2&2\\2&2\end{pmatrix}$ | $4$ on $e_1\wedge e_2+e_3\wedge e_4$, $0$ on the difference |
| $\langle e_1\wedge e_3,\ e_2\wedge e_4\rangle$ | $\begin{pmatrix}-1&1\\1&-1\end{pmatrix}$ | $-2$ on $e_1\wedge e_3-e_2\wedge e_4$, $0$ on the sum |
| $\langle e_1\wedge e_4,\ e_2\wedge e_3\rangle$ | $\begin{pmatrix}-1&-1\\-1&-1\end{pmatrix}$ | $-2$ on $e_1\wedge e_4+e_2\wedge e_3$, $0$ on the difference |

With the orientation $e_1\wedge e_2\wedge e_3\wedge e_4$ the star acts by $\star(e_1\wedge e_2)=e_3\wedge e_4$, $\star(e_1\wedge e_3)=-e_2\wedge e_4$, $\star(e_1\wedge e_4)=e_2\wedge e_3$, so

$$\Lambda^+=\langle e_1\wedge e_2+e_3\wedge e_4,\ e_1\wedge e_3-e_2\wedge e_4,\ e_1\wedge e_4+e_2\wedge e_3\rangle,$$

which is exactly the span of the three eigenvectors carrying $4,-2,-2$, while $\Lambda^-$ is the span of the three carrying $0,0,0$.

**Conclusion, exact.** $W^-=0$; $W^+$ has spectrum $(4,-2,-2)=2\cdot(2,-1,-1)$, every entry nonzero; the full $\Lambda^2\mathbb R^4$ spectrum is $(4,-2,-2,0,0,0)$ and the $\Lambda^2$-rank is **three**. This agrees with Derdziński's Proposition 2 at $u=24$: $(u/6,-u/12,-u/12)=(4,-2,-2)$.

**One further reading, used by the audit.** In this frame $W_{1234}=2\ne0$, so $\mathbb{CP}^2$'s Weyl tensor fails to be coordinate-diagonal in the very frame adapted to $J$, an instance of the general statement L176's Corollary 2 makes about every frame.
