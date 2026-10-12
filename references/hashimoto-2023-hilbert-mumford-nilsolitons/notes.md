# Notes, Hashimoto, *A Hilbert–Mumford criterion for nilsolitons*

Transcribed from [hashimoto-2311.12469.txt](https://arxiv.org/abs/2311.12469) (`pdftotext -layout`); line references are to that dump.

## The abstract (L5–L11, verbatim)

> We give an algebraic criterion for a nilpotent real Lie algebra and prove that it provides a necessary and sufficient condition for the associated nilpotent Lie group to admit left-invariant Ricci solitons, called nilsolitons. As an application of this result, we generalise Nikolayevsky's criterion for the existence of nilsolitons to nilpotent Lie algebras without nice bases. We further prove a modified version of the Taketomi–Tamaru conjecture for nilpotent Lie groups which gives an obstruction to the existence of nilsolitons.

## The weight, and that it sees only the support (L58–L66, verbatim)

> We first fix an inner product $\langle,\rangle$ on $\mathfrak n$ so that a distinguished derivation $\phi_\mu$ of $(\mathfrak n,\mu)$, called the pre-Einstein derivation [35], is self-adjoint with respect to it ... For an endomorphism $\lambda\in\mathrm{End}(\mathfrak n)$ which is self-adjoint with respect to $\langle,\rangle$, we define the Hilbert–Mumford weight $\nu(\lambda;\mu)$ as
> $$\nu(\lambda;\mu):=-\min\{\lambda_i+\lambda_j-\lambda_k\mid 1\le i<j\le n,\ 1\le k\le n,\ \text{s.t. }\mu^k_{ij}\ne0\},$$
> where we presented $\lambda$ as a diagonal matrix $\mathrm{diag}(\lambda_1,\dots,\lambda_n)$ by choosing a $\langle,\rangle$-orthonormal basis $\{e_i\}_{i=1}^n$ for $\mathfrak n$ with respect to which we write $\mu(e_i,e_j)=\sum_{k=1}^n\mu^k_{ij}e_k$.

**Only the index set $\{(i,j,k):\mu^k_{ij}\ne0\}$ enters.** Magnitudes are invisible to the criterion; the support carries it all.

## The main theorem (L76–L81, verbatim)

> **Theorem 1.1.** Let $(N,g_N)$ be a homogeneous nilmanifold and $(\mathfrak n,\mu)$ be the corresponding nilpotent Lie algebra with the inner product $\langle,\rangle$, with respect to which the pre-Einstein derivation is self-adjoint. Then, $N$ admits a left-invariant Ricci soliton if and only if $\nu(\lambda;\mu)\ge0$ for any self-adjoint endomorphism $\lambda\in\mathrm{End}(\mathfrak n)$ which commutes with $S$ and is orthogonal to $S$ with respect to $\langle,\rangle_{\mathrm{End}(\mathfrak n)}$, with equality if and only if $\lambda$ is a derivation of $\mu$.

with $S:=\mathbb R(I_n-\phi_\mu)\subset\mathrm{End}(\mathfrak n)$, which "is proportional to the Ricci endomorphism of the nilsoliton if there exists one (Theorem 3.5)".

## The reduction to a linear system in the squares (L95–L132, verbatim)

> **Theorem 1.2.** Let $(\mathfrak n,\mu,\langle,\rangle)$ be a metric nilpotent Lie algebra such that the pre-Einstein derivation $\phi_\mu$ is self-adjoint with respect to $\langle,\rangle$, and let $B:=\{e_i\}_{i=1}^n$ be a $\langle,\rangle$-orthonormal basis for $\mathfrak n$ which diagonalises $\phi_\mu$. We define a finite subset $F_B$ of $\mathfrak n$ by
> $$F_B:=\{e_i+e_j-e_k\mid 1\le i<j\le n,\ 1\le k\le n,\ \text{s.t. }\mu^k_{ij}\ne0\},$$
> ... Let $L_B$ be the affine span of $F_B$ ..., $\mathrm{Conv}(F_B)$ be the convex hull of $F_B$, and $P_0$ be the projection of the origin of $\mathfrak n$ to $L_B$ ... Then the following hold.
> (i) Let $\mathfrak p_B$ be the set consisting of endomorphisms on $\mathfrak n$ that are diagonal with respect to $B$ and orthogonal to $S$ ... Then, $\nu(\lambda;\mu)>0$ for any $\lambda\in\mathfrak p_B\setminus\mathrm{Der}(\mu)$ if and only if $P_0$ lies in the interior of $\mathrm{Conv}(F_B)$.
> (ii) ... Then, $P_0$ lies in the interior of $\mathrm{Conv}(F_B)$ if and only if there exist $\alpha_1,\dots,\alpha_m>0$ such that $\sum_{i=1}^m\alpha_i=\lVert P_0\rVert^{-2}$ and
> $$Y_BY_B^{\mathsf T}\begin{pmatrix}\alpha_1\\\vdots\\\alpha_m\end{pmatrix}=\begin{pmatrix}1\\\vdots\\1\end{pmatrix}.\tag{1}$$

> In particular, given Theorem 1.1, a homogeneous nilmanifold $(N,g_N)$ associated to $(\mathfrak n,\mu,\langle,\rangle)$ admits a left-invariant Ricci soliton if and only if $P_0$ lies in the interior of $\mathrm{Conv}(F_B)$, or equivalently (1) admits a solution $\alpha_1,\dots,\alpha_m>0$ with $\sum_{i=1}^m\alpha_i=\lVert P_0\rVert^{-2}$, for any $\langle,\rangle$-orthonormal basis $B$ which diagonalises $\phi_\mu$.

## The author's own caveat on where the difficulty moved (L136–L140, verbatim)

> Theorem 1.2 reduces the problem of whether there exists a nilsoliton to finding a positive solution to the linear equation (1), although we first need to determine the finite set $F_B\subset\mathfrak n$ for each orthonormal basis $B$ which diagonalises $\phi_\mu$, **which should be a highly non-trivial problem**.

## What this settles for T9

1. **The linear-with-positivity layer is exact, and this is now a theorem with no nice-basis hypothesis.** At a fixed support the geometric condition and "the linear system in the squares has a strictly positive solution, normalised" are the same condition. The record's zero-overshoot table at seven fixed spectra is therefore the behaviour the analogue predicts, and it says nothing about the outer maximisation.
2. **The whole criterion is a function of the support.** In the record's language the analogue of the support is $\mathrm{supp}\,T$, which is exactly what [Conti–Rossi](../conti-rossi-2019-nice-nilpotent/notes.md)'s (N4) also isolated. Two independent lines of this literature agree that the support is where the content sits.
3. **The hard step did not disappear, it moved to enumerating the frames.** The author flags this himself. In the record's problem the corresponding step is exactly the unsolved one: which orthonormal frames of $\mathfrak{so}(n)$ diagonalise a Weyl operator with a given spectrum.
4. **The residual obstruction (Theorem 1.4) is group-theoretic, not convex.** It is stated as non-transitivity of an $\mathrm{Aut}(\mu)\cap G$-action on a symmetric space, nothing a linear program over the squares could express.
