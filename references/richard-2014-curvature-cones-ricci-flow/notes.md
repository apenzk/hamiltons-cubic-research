# Richard, *Curvature cones and the Ricci flow* (Séminaire de théorie spectrale et géométrie 31, 2012–2014, 197–220)

**Thomas Richard**, Institut Fourier, Université de Grenoble I. Transcribed 2026-09-02 from [richard-TSG_2012-2014__31__197_0.txt](https://www.numdam.org/article/TSG_2012-2014__31__197_0.pdf) (`pdftotext -layout`). See [README.md](README.md) for the verdict, the folder was opened looking for a polar-representation technique and found none.

**A survey, so the theorems are mostly quoted from elsewhere and attributed here as the paper attributes them.**

## The setting

> **Definition 1.2.** The space of algebraic curvature operators $S^2_B\Lambda^2\mathbb R^n$ is the space of symmetric endomorphisms $R$ of $\Lambda^2\mathbb R^n$ which satisfy the first Bianchi identity:
> $$\forall x,y,z,t\in\mathbb R^n\quad\langle R(x\wedge y),z\wedge t\rangle+\langle R(z\wedge x),y\wedge t\rangle+\langle R(y\wedge z),x\wedge t\rangle=0.$$

with the inner product $\langle R,L\rangle=\mathrm{trace}(RL^T)$, and $\rho:S^2_B\Lambda^2\mathbb R^n\to S^2\mathbb R^n$ the Ricci morphism. The $O(n)$-decomposition is written $R=R_I+R_0+R_W$; in dimension 3 the $\mathcal W$ factor vanishes and from dimension 4 all three exist.

> **Definition 1.3.** A **curvature cone** is a closed convex cone $C\subset S^2_B\Lambda^2\mathbb R^n$ which is invariant under the action of $O(n,\mathbb R)$.

> **Definition 1.4.** A curvature cone is said to be **nonnegative** if it contains the identity operator $I:\Lambda^2\mathbb R^n\to\Lambda^2\mathbb R^n$ in its interior.

The paper is explicit about which group: "we require the cone to be invariant under the **full** orthogonal group $O(n,\mathbb R)$, rather than under the special orthogonal group $SO(n,\mathbb R)$. This makes a difference only in dimension 4, where the action of $SO(4,\mathbb R)$ on the space of Weyl tensors is not irreducible." Definition 1.4 is traced to Gromov [9].

> **Definition 1.5.** Let $C$ be a nonnegative curvature cone. A Riemannian manifold $(M,g)$ has **$C$-nonnegative curvature** if for any $x\in M$ the curvature operator of $(M,g)$ at $x$ belongs to the previously discussed embedding of $C$ in $S^2_B\Lambda^2T_xM$.

> **Definition 1.7.** A curvature cone $C$ is said to be **Ricci flow invariant** if for any $R$ in the boundary $\partial C$ of $C$, $Q(R)\in T_RC$, the tangent cone at $R$ to $C$.

> **Remark 1.8.** In other words, a cone is Ricci flow invariant if at every $R\in\partial C$, $Q(R)$ points towards the inside of $C$. This condition is equivalent to the fact that the solutions to the ODE $\tfrac{d}{dt}R=Q(R)$ which start inside $C$ stay in $C$ for positive times.

> **Theorem 1.9.** Let $C$ be a Ricci flow invariant curvature cone. If $(M,g(t))_{t\in[0,T)}$ is a Ricci flow on a compact manifold such that $(M,g(0))$ has $C$-nonnegative curvature, then for $t\in[0,T)$, $(M,g(t))$ has $C$-nonnegative curvature.

*Consequence of Hamilton's maximum principle [12].*

## The statement that bears directly on $\mathrm{Weyl}_n$, Theorem 3.3 and Remark 3.4

> **Theorem 3.3.** Let $C\subset S^2_B\Lambda^2\mathbb R^n$, $n\ge4$, be a Ricci flow invariant curvature cone; assume $C$ contains $\mathcal W$, the space of Ricci flat curvature operators. Then $C$ is either the cone $C_{\mathrm{Scal}}$ or the whole space $S^2_B\Lambda^2\mathbb R^n$.

> **Remark 3.4.** For representation theoretic reasons, any curvature cone which contains a non-vanishing tensor $W\in\mathcal W$ automatically contains the whole space $\mathcal W$.

**Remark 3.4 is the load-bearing sentence for this project**: irreducibility of $\mathcal W$ under $O(n)$ means an $O(n)$-invariant convex cone cannot separate one Weyl tensor from another. **A cone-based argument therefore cannot distinguish points of $\mathrm{Weyl}_n$ at all**, which is a sharper reason than "no precedent" for why the cone literature cannot supply a bound on the record's cubic at a single tensor. The proof sketch given is: if $C$ is Ricci flow invariant, contains $\mathcal W$, and is neither $C_{\mathrm{Scal}}$ nor the whole space, the $O(n)$-decomposition forces $C$ to contain no nonzero tensor in $S^2_0\mathbb R^n$; then $R\in\partial C$ and $W\in\mathcal W$ give $R+tW\in\partial C$, contradiction.

> **Remark 3.5.** … The above result shows the only condition one can get following this idea is the "nonnegative scalar curvature" condition.

The same irreducibility argument appears earlier, in the proof of

> **Proposition 1.6.** If $C$ is a nonnegative curvature cone which is not the full space $S^2_B\Lambda^2\mathbb R^n$, then $C\subset\{R\mid\mathrm{trace}\,R\ge0\}$.

Proof: if $C$ contained $R$ with negative trace, the Haar average $\tilde R=\int_{O(n)}g\cdot R\,dg$ has vanishing projection on $\mathcal W$ and on $S^2_0\mathbb R^n\wedge\mathrm{id}$ **by irreducibility**, so $\tilde R=\lambda I$ with $\lambda<0$, and $C$ contains the whole line $\mathbb RI$ with $I$ interior, hence $C$ is everything.

## The catalogue of invariant cones

> **Proposition 2.1.** $C_{\mathrm{Scal}}=\{R\mid\mathrm{trace}\,R\ge0\}$ is a Ricci flow invariant nonnegative curvature cone.

Its proof turns on one identity worth keeping: **$\mathrm{trace}\,Q(R)=2\lvert\rho(R)\rvert^2\ge0$, valid for any $R$.**

> **Proposition 2.2.** $C_{PCO}=\{R\mid\forall\omega\in\Lambda^2\mathbb R^2,\ \langle R\omega,\omega\rangle\ge0\}$ is a Ricci flow invariant nonnegative curvature cone. [A nonnegative $R$ is on the boundary iff $\ker(R)\ne\{0\}$, and then $T_RC_{PCO}=\{L\mid\forall\omega\in\ker(R),\ \langle L\omega,\omega\rangle\ge0\}$.]

> **Definition 2.6 / 2.7.** $R:\Lambda^2\mathbb R^n\to\Lambda^2\mathbb R^n$ is **PIC1** if its natural extension $\tilde R:\Lambda^2\mathbb R^{n+1}\to\Lambda^2\mathbb R^{n+1}$ is PIC; it is **PIC2** if its extension to $\Lambda^2\mathbb R^{n+2}$ is PIC. One obviously has $C_{IC2}\subset C_{IC1}\subset C_{IC}$.

> **Theorem 2.8.** The nonnegative curvature cones $C_{2PCO}$, $C_{IC}$, $C_{IC1}$ and $C_{IC2}$ are Ricci flow invariant.

Attributions given: $C_{2PCO}$ to Chen [6]; $C_{IC}$ to Brendle–Schoen [5] and independently Nguyen [19]; $C_{IC1}$ and $C_{IC2}$ follow from $C_{IC}$ because the ODE $R'=Q(R)$ respects product structures, first pointed out in [5].

## Wilking's construction

Recalling that $\Lambda^2\mathbb R^n\cong\mathfrak{so}(n,\mathbb R)$ with the $SO(n,\mathbb R)$-action being the adjoint action:

> **Definition 2.9.** Let $S$ be a subset of the complex Lie algebra $\mathfrak{so}(n,\mathbb C)\cong\Lambda^2\mathbb C^n$ which is invariant under the action of $SO(n,\mathbb C)$. The nonnegative curvature cone
> $$C(S)=\big\{R\in S^2_B\Lambda^2\mathbb R^n\ \big|\ \langle R(\omega),\bar\omega\rangle\ge0\ \text{for all}\ \omega\in S\big\}$$
> is called the **Wilking cone** associated with $S$.

> **Theorem 2.10 ([26]).** Any Wilking cone $C(S)$ is Ricci flow invariant.

*This is the construction transcribed at first hand in [wilking-lie-algebraic-cones](../wilking-lie-algebraic-cones/notes.md).*

## Pinching sets and pinching families

> **Definition 2.11.** A closed convex $O(n)$-invariant $F\subset S^2_B\Lambda^2\mathbb R^n$ is called a **pinching set** if: it is Ricci flow invariant; and as $\lambda$ goes to 0, $\lambda F$ converges to $\mathbb R^+I$.

> **Remark 2.12.** A pinching set has to be a subset of the half space $\{R\mid\mathrm{trace}\,R>0\}$.

> **Definition 2.13.** A curvature cone $C$ is said to have the **pinching property** if for any compact $K$ contained in the interior of $C$, there is a pinching set $F$ containing $K$.

> **Proposition 2.14 ([12],[3]).** Let $C$ be a curvature cone with the pinching property; then any compact manifold with positive $C$-curvature admits a metric with constant positive sectional curvature.

> **Definition 2.16.** A one-parameter family $(C_s)_{s\in[0,1)}$ of nonnegative curvature cones is called a **pinching family** if: $s\mapsto C_s$ is continuous; as $s\to1$, $C_s$ converges to $\mathbb R^+I$; for each $s>0$, every $R\in C_s\setminus\{0\}$ has positive trace; every $C_s$ is Ricci flow invariant, and moreover for any $s>0$ and any nonzero $R\in\partial C_s$, $Q(R)$ belongs to the **interior** of $T_RC_s$.

> **Theorem 2.17.** Let $(C_s)_{s\in[0,1)}$ be a pinching family. Then $C_0$ has the pinching property.

*Attributed to Boehm–Wilking [3].* Richard's reading of its force:

> **Remark 2.18.** From a PDE point of view … it allows to build from a family of **scale invariant** estimates (the pinching family) a self improving **non scale invariant** estimate (the pinching set). Usually, non scale invariant estimates are harder to obtain.

> **Proposition 2.19 ([11]).** The curvature cones $C_s=\{R\in S^2_B\Lambda^2\mathbb R^3\mid\rho(R)\ge\tfrac{2s}{3}(\mathrm{trace}\,R)\,\mathrm{id}\ge0\}$ for $s\in[0,1)$ form a pinching family such that $C_0=\{R\mid\rho(R)\ge0\}$.

## The restrictions on what a cone can be

> **Theorem 3.1.** Let $C\subset S^2_B\Lambda^2\mathbb R^n$ be a Wilking cone with $n\ge5$; then $C$ is contained in the cone $C_{IC}$ of manifolds with nonnegative isotropic curvature.

> **Theorem 3.2.** Let $C\subset S^2_B\Lambda^2\mathbb R^n$ be a Wilking cone with $n\ge5$; assume that $C$ has the pinching property. Then $C$ is contained in the cone $C_{IC1}$.

*Both from Gururaja–Maity–Seshadri [10]; their proofs use advanced results on the orbits of the adjoint action of Lie groups.* Theorem 3.3 above is from Richard and Seshadri [23], see [richard-seshadri-2013-noncoercive-cones](../richard-seshadri-2013-noncoercive-cones/README.md).

## Incomplete

Proposition 0.1, Definitions 2.3 and 2.4, and §3.2 (the oriented cones in dimension 4) are not transcribed, nor are the proofs beyond the sketches quoted above. Being a survey, the paper's own contributions are Theorem 3.3 and Proposition 1.6; the rest is attributed and should be cited to its source.
